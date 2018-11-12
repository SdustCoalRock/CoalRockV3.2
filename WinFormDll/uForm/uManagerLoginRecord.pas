unit uManagerLoginRecord;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids, Vcl.StdCtrls,UMainDataModule;

type
  TForm_ManagerLogin = class(TForm)
    ToolBar1: TToolBar;
    AddButton: TToolButton;
    EditButton: TToolButton;
    SaveButton: TToolButton;
    DeleteButton: TToolButton;
    ExitButton: TToolButton;
    ImageList1: TImageList;
    GroupBox1: TGroupBox;
    TreeView_User: TTreeView;
    StringGrid_Login: TStringGrid;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
     FAdoDataSet1:TMyDataSet;
     FAdoCommand:TMyCommand;
    procedure OptionTip(Str:String);
    procedure SetCellHead; //����Cell��ͷ
    procedure FillCell(id:integer); //������
    procedure MainTreeView(TreeView: TTreeView);
    procedure ChildTreeView(TreeView: TTreeView;XNode: TTreeNode;Typeid:integer);
  public
    { Public declarations }
  end;

var
  Form_ManagerLogin: TForm_ManagerLogin;

implementation

{$R *.dfm}

uses Lu_Public_BasicModual;

procedure TForm_ManagerLogin.ChildTreeView(TreeView: TTreeView;
  XNode: TTreeNode; Typeid: integer);
var
   RecData: PMyRec;
   XNode_First:TTreeNode;
begin
          New(RecData);
          FAdoDataSet1.Close;
          FAdoDataSet1.CommandText:= 'SELECT  id,userName FROM userinfo WHERE User_Type='+IntToStr(Typeid)+  ' ORDER BY cqID';
          FAdoDataSet1.Open;
            while not FAdoDataSet1.Eof do begin
                 New(RecData);
                 RecData^.BName:='-2';
                 RecData^.DName:=FAdoDataSet1.FieldByName('Used').AsString;
                 RecData^.XHeight:=Trim(FAdoDataSet1.FieldByName('id').AsString);
                 XNode_First:=TreeView.Items.AddChildObject(xNode,Trim(FAdoDataSet1.FieldByName('UserName').AsString),RecData);
                 if RecData^.DName='1' then     XNode_First.ImageIndex:=2
                    else  XNode_First.ImageIndex:=3;
//                 if RecData^.XHeight=User_id then
//                    XNode.Selected :=true;

              FAdoDataSet1.Next ;
           end ;
           FAdoDataSet1.Close ;

end;

procedure TForm_ManagerLogin.FillCell(id: integer);
begin

end;

procedure TForm_ManagerLogin.FormCreate(Sender: TObject);
begin
      FAdoDataSet1:=TMyDataSet.Create(nil);

     FAdoCommand:=TMyCommand.Create(nil);
     FAdoDataSet1.MySqlConnection:=MainDataModule.ExConn;

     FAdoCommand.MySqlConnection:=MainDataModule.ExConn;
end;

procedure TForm_ManagerLogin.FormDestroy(Sender: TObject);
begin
     {ֻ�з���Free ���������ʱ�� �ŵ���Destory}
   FreeAndNil(FAdoDataSet1);
   FreeAndNil( FAdoCommand);
end;

procedure TForm_ManagerLogin.FormResize(Sender: TObject);
begin
    self.StringGrid_Login.ColWidths[2]:=StringGrid_Login.Width-300;
end;

procedure TForm_ManagerLogin.FormShow(Sender: TObject);
begin
   PubLic_Basic.InitStatusBar (self.StatusBar1);
   SetCellHead;
end;

procedure TForm_ManagerLogin.MainTreeView(TreeView: TTreeView);
var
  i:integer;
  RecData: PMyRec;
  xNode:TTreeNode;

begin
        //��ͼ��ʼ��
    TreeView.Items.Clear;

  for I := 0 to 1 do  begin

    New(RecData);
    RecData^.BName:='-1';
    RecData^.DName:='ROOT';
    RecData^.XHeight:=IntToStr(i+1);
    if i=0 then     xNode:=TreeView.Items.AddObject(nil,'����Ա',RecData)
           else     xNode:=TreeView.Items.AddObject(nil,'һ����Ա',RecData) ;
    Xnode.ImageIndex:=0;
    self.ChildTreeView(TreeView,Xnode,i+1);
  end;


end;

procedure TForm_ManagerLogin.OptionTip(Str: String);
begin
   self.StatusBar1.Panels[0].Text :=str;
end;

procedure TForm_ManagerLogin.SetCellHead;
var
   i:integer;
begin
      // ��յ�Ԫ��
      for i := 1 to  StringGrid_Login.RowCount - 1 do
          StringGrid_Login.Rows[i].Clear ;
     StringGrid_Login.Canvas.Font.Size :=8;
     StringGrid_Login.ColCount :=3;
     StringGrid_Login.RowCount :=6;
     StringGrid_Login.Cells [0,0]:='���';
     StringGrid_Login.Cells [1,0]:='����ʱ��';
     StringGrid_Login.Cells [2,0]:='��������';
     StringGrid_Login.ColWidths[0]:=100;
     StringGrid_Login.ColWidths[1]:=200;
     StringGrid_Login.ColWidths[2]:=StringGrid_Login.Width-300;
end;

end.