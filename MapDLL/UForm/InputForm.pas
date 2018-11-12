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

const{TADOConnection 连接数据库的参数}
ADOLinkString ='Provider=Microsoft.Jet.OLEDB.4.0;Extended Properties=excel 8.0;'
   + 'Password=%s;'     //用户工作组(*.mdw)密码
   + 'User ID=%s;'     //用户工作组(*.mdw)用户名Admin
   + 'Data Source=%s;'    //数据库文件(*.mdb)位置
   + 'Jet OLEDB:Database Password=%s;' //数据库密码
   + 'Jet OLEDB:New Database Password=%s;'    //?密码
;

 wdDialogToolsWordCount   =   $000000E4;
var  mdwPassword,mdwUserID,mdbDataSource,mdbUserID,mdbPassword,mdbNewPassword:string;
var path:string;


procedure TInPutExcel.ReadExcel(Sender: TObject;Excel:WideString);
 var
    Row_c,Col_C:integer;
 begin

    mdbDataSource :=Excel ; //不同系统更换数据库
    self.loadexcel(Sender);
     Row_c:=2;
    self.ADODataSetExcel.Close ();
         ADODataSetExcel.CommandText :='select * from [sheet1$]';
         ADODataSetExcel.Open();
        while not ADODataSetExcel.Eof  do  begin
           if length(Trim(ADODataSetExcel.FieldByName('序号').AsString))<1 then   begin
               exit;
           end;

           self.StringGrid1.Cells[0,Row_c]:=ADODataSetExcel.FieldByName('序号').AsString;
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
             ADOCExcel.ConnectionString :=Format(ADOLinkString, [mdwPassword,  mdwUserId,mdbDataSource, mdbPassword, mdbNewPassword]);{初始连接参数}
             ADOCExcel.Connected:=true;


end;
end.
