unit InputForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids;

type
  TInPutExcel = class(TForm)
    ADOCExcel: TADOConnection;
    ADODataSetExcel: TADODataSet;
    StringGrid1: TStringGrid;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
     procedure loadexcel(Sender: TObject);{ Private declarations }
  public
    { Public declarations }
     procedure ReadExcel(Sender: TObject;Excel:WideString);
  end;

var
  InPutExcel: TInPutExcel;

implementation

uses MapX_LuLeiImpl;

{$R *.dfm}

const{TADOConnection �������ݿ�Ĳ���}
ADOLinkString ='Provider=Microsoft.Jet.OLEDB.4.0;Extended Properties=excel 8.0;'
   + 'Password=%s;'     //�û�������(*.mdw)����
   + 'User ID=%s;'     //�û�������(*.mdw)�û���Admin
   + 'Data Source=%s;'    //���ݿ��ļ�(*.mdb)λ��
   + 'Jet OLEDB:Database Password=%s;' //���ݿ�����
   + 'Jet OLEDB:New Database Password=%s;'    //?����
;

 wdDialogToolsWordCount   =   $000000E4;
var  mdwPassword,mdwUserID,mdbDataSource,mdbUserID,mdbPassword,mdbNewPassword:string;
var path:string;


procedure TInPutExcel.ReadExcel(Sender: TObject;Excel:WideString);
 var
    Row_c,Col_C:integer;
 begin

    mdbDataSource :=Excel ; //��ͬϵͳ�������ݿ�
    self.loadexcel(Sender);
     Row_c:=2;
    self.ADODataSetExcel.Close ();
         ADODataSetExcel.CommandText :='select * from [sheet1$]';
         ADODataSetExcel.Open();
        while not ADODataSetExcel.Eof  do  begin
           if length(Trim(ADODataSetExcel.FieldByName('���').AsString))<1 then   begin
               exit;
           end;

           self.StringGrid1.Cells[0,Row_c]:=ADODataSetExcel.FieldByName('���').AsString;
           ADODataSetExcel.Next;
           Row_c:=Row_c+1;
        end;
    self.ADODataSetExcel.Close ();
 end;

 procedure TInPutExcel.FormCreate(Sender: TObject);
begin
     StringGrid1.FixedCols:=1;
     StringGrid1.FixedRows:=1;
     StringGrid1.DefaultRowHeight:=18;
    // StringGrid1.ColWidths[0]:=30;
end;

procedure TInPutExcel.loadexcel(Sender: TObject);{ Private declarations }
begin
        //  Path :=ExtractFilePath(ParamStr(0));
           mdwPassword :='';
           mdwUserID :='Admin';
           mdbUserID :='Admin';
           mdbPassword :=''; //password wss690905
           mdbNewPassword :='';
             ADOCExcel.Connected:=false;
             ADOCExcel.ConnectionString :=Format(ADOLinkString, [mdwPassword,  mdwUserId,mdbDataSource, mdbPassword, mdbNewPassword]);{��ʼ���Ӳ���}
             ADOCExcel.Connected:=true;


end;
end.
