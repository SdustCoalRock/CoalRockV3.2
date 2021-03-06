unit UnZkGzmLink;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, ImgList, DB, ADODB, ToolWin, System.ImageList,
  UMainDataModule,PStope_GzmGuidClass, Vcl.Grids;
type
  TZkGzmLink = class(TForm)
    JITuanTreeView: TTreeView;
    Panel1: TPanel;
    ImageList1: TImageList;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Edit_Drill: TEdit;
    Edit_WorkFace: TEdit;
    Label2: TLabel;
    Edit_Start_JuLi: TEdit;
    Label4: TLabel;
    Edit_End_JuLi: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    AddButton: TToolButton;
    EditButton: TToolButton;
    SaveButton: TToolButton;
    DeleteButton: TToolButton;
    ExitButton: TToolButton;
    ImageList2: TImageList;
    GroupBox2: TGroupBox;
    StringGrid1: TStringGrid;
    CaptionLable: TLabel;
    FindButton: TToolButton;
    procedure JITuanTreeViewExpanded(Sender: TObject; Node: TTreeNode);
    procedure JITuanTreeViewCollapsed(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
    procedure JITuanTreeViewClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure FormActivate(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Edit_DrillClick(Sender: TObject);
    procedure Edit_WorkFaceClick(Sender: TObject);
    procedure Edit_Start_JuLiClick(Sender: TObject);
    procedure Edit_End_JuLiClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FindButtonClick(Sender: TObject);

  private
    { Private declarations }
     MySqlDataSet1:TMyDataSet;
     MySqlDataSet2:TMyDataSet;
     MySqlDataSet3:TMyDataSet;
     MyCommand1:TMyCommand;
     FinGzm:TGzm;
     Zkid_s,kid_s,Gzmid_s:string;
     Kid_gzm,Kid_zk:string;
     W_ID:string;
     Save_Lx:string; //
     KARow:integer;
     procedure SetCellHead; //设置Cell表头
     function CheckInsertValue:Boolean;
     procedure FillCell(kid,Gzmid,zkid :integer); //填充表格
     procedure OptionTip(Str:String);
     procedure MainTreeView(TreeView: TTreeView);
     procedure MeiKuangTreeView(TreeView: TTreeView;XNode: TTreeNode;Jituanid:String);
     procedure WorkFaceTreeView(TreeView: TTreeView;XNode: TTreeNode;Meikuangid:String);
     procedure DrillTreeView(TreeView: TTreeView;XNode: TTreeNode;Meikuangid:String);
     procedure RefreshEditEnabled(Value:Boolean);
     procedure GetRootNodes(RNode:TTreeNode;InImageIndex:Integer);//得到所有根节点
     procedure SetEditValue(Value:string);
     procedure RefreshCaptionLable(id:String);
     procedure DealWithTreeViewClick(S_text:String;kid,Gzmid,zkid :integer);
     procedure AddAndEditEnabled(Value:Boolean);
     function GzmAndZkIsEffective(Gzmid,zkid:String):Boolean;
  public
    { Public declarations }
  end;


 function CreateBgz_inn(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;stdcall;

var
  ZkGzmLink: TZkGzmLink;

implementation   


{$R *.dfm}

uses uWinFrameClass, Lu_Public_BasicModual;

function CreateBgz_inn(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;stdcall;
begin
        if Assigned(ZkGzmLink) then  FreeAndNil(ZkGzmLink);

        ZkGzmLink:=TZkGzmLink.Create(nil);
        try
           with ZkGzmLink do begin
               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

                Show;
                SetFocus;
                Result:=ZkGzmLink.Handle ;//函数值
          end ;
        except
            FreeAndNil(ZkGzmLink);
        end;


end;


procedure TZkGzmLink.AddAndEditEnabled(Value: Boolean);
begin
     self.JITuanTreeView.Enabled :=Value;
     self.GroupBox1.Enabled :=Value;
end;

procedure TZkGzmLink.AddButtonClick(Sender: TObject);
begin
    AddAndEditEnabled(True);
    RefreshEditEnabled(true);
    self.SetEditValue('');
    Zkid_s:='';
    kid_s:='';
    Gzmid_s:='';

    //控制按钮
    self.SaveButton.Enabled :=true;
    self.EditButton.Enabled :=false;
    Save_Lx:='insert';
    OptionTip('正在进行【添加】操作!');

end;

function TZkGzmLink.CheckInsertValue: Boolean;
begin
    Result:=False;
    if (Kid_Gzm<>Kid_zk)  then   begin
         messagebox(self.Handle,'钻孔与工作面不是同一个煤矿，请重新选择!','系统提示',mb_iconerror+mb_ok);
         exit;
    end else begin
        Kid_s:=Kid_Gzm;
    end;
    if  not GzmAndZkIsEffective(Gzmid_s,Zkid_s)  then  begin
         messagebox(self.Handle,'工作面开采煤层在钻孔信息里没有标注，'+#13#13+'请修改后再来绑定!','系统提示',mb_iconerror+mb_ok);
         exit;
    end;


    if Trim(Edit_Drill.Text) ='' then   begin
         messagebox(self.Handle,'没有选择钻孔信息!','系统提示',mb_iconerror+mb_ok);
         exit;
    end else if Trim(Edit_WorkFAce.Text) ='' then   begin
         messagebox(self.Handle,'没有选择工作面信息!','系统提示',mb_iconerror+mb_ok);
         exit;
    end else  if Trim(Edit_Start_JulI.Text) ='' then   begin
         messagebox(self.Handle,'请录入应用钻孔开始距离(距开切眼)!','系统提示',mb_iconerror+mb_ok);
         exit;
    end else  if Trim(Edit_End_JUlI.Text) ='' then   begin
         messagebox(self.Handle,'请录入应用钻孔终止距离(距开切眼)!','系统提示',mb_iconerror+mb_ok);
         exit;
    end;
     Result:=true;

end;

procedure TZkGzmLink.DealWithTreeViewClick(S_text:String;kid, Gzmid, zkid: integer);
begin
    if  (Save_Lx ='insert') then  begin
       if Gzmid >0  then
          Edit_WorkFace.Text:= S_text;
       if zkid>0 then
          Edit_Drill.Text:=S_text;
       RefreshCaptionLable('');
    end else if (Save_Lx ='find') then  begin
       SetEditValue('');
       if Gzmid>0 then
          FillCell(0,Gzmid,0);
       if zkid>0 then
          FillCell(0,0,zkid);
    end;
end;

procedure TZkGzmLink.DeleteButtonClick(Sender: TObject);
var
  t_s:Widestring;
begin
   if(length(Trim(W_id))<1 ) then exit;
    t_s:='你确定要删除选中编号为【'+W_id+'】的数据么?';
    if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;
  try
        MyCommand1.CommandText:='delete from WorkFaceBuillDrill where id='+W_ID;
        MyCommand1.Execute(MainDataModule.ExUserName) ;

  except
    exit;
  end;

  OptionTip('数据删除成功!');


  FillCell(0,StrToInt(Gzmid_s),0);

    DeleteButton.Enabled :=false;

end;

procedure TZkGzmLink.DrillTreeView(TreeView: TTreeView; XNode: TTreeNode;
  Meikuangid: String);
var
   RecData: PMyRec;
   XNode_First,xNode_Second:TTreeNode;
begin
          New(RecData);
          RecData^.BName:='1';
          RecData^.DName:='ZK_LEI';
          XNode_First := TreeView.Items.AddChildObject(XNode,'钻孔名称',RecData);
          XNode_First.ImageIndex:=0;
               //添加钻孔信息
          MySqlDataSet3.Close;
          MySqlDataSet3.CommandText:= 'SELECT  zkId,zkName FROM zkb WHERE kid='+Meikuangid+' ORDER BY zkID';
          MySqlDataSet3.Open;
          while not MySqlDataSet3.Eof do  begin
                New(RecData);
                RecData^.BName:='-4';
                RecData^.DName:='ZK_DETIL';
                RecData^.XHeight:=Trim(MySqlDataSet3.FieldByName('zkId').AsString);
                xNode_Second:=TreeView.Items.AddChildObject(XNode_First,Trim(MySqlDataSet3.FieldByName('zkName').AsString),RecData);
                xNode_Second.ImageIndex:=2;
                MySqlDataSet3.Next;
          end;
          MySqlDataSet3.Close;
end;

procedure TZkGzmLink.EditButtonClick(Sender: TObject);
begin
   //控制按钮
   self.EditButton.Enabled :=false;
   self.SaveButton.Enabled :=true;
   self.AddButton.Enabled:=false;
   //控制录入框
    self.RefreshEditEnabled(true) ;
    Save_Lx:='update'; //
    OptionTip('正在进行【修改】操作!');
    Edit_Start_juli.SetFocus ;
end;

procedure TZkGzmLink.Edit_DrillClick(Sender: TObject);
begin
   Edit_Drill.SetFocus ;
end;

procedure TZkGzmLink.Edit_WorkFaceClick(Sender: TObject);
begin
     Edit_WorkFAce.SetFocus ;
end;

procedure TZkGzmLink.ExitButtonClick(Sender: TObject);
begin
     Close;
end;

procedure TZkGzmLink.Edit_Start_JuLiClick(Sender: TObject);
begin
       Edit_Start_JuLi.SetFocus ;
end;

procedure TZkGzmLink.Edit_End_JuLiClick(Sender: TObject);
begin
      Edit_End_JUli.SetFocus ;
end;

procedure TZkGzmLink.FillCell(kid,Gzmid,zkid :integer);
var
    t_col,t_row,i:integer;
    kname,jname,cqname,zkName:Ansistring;
    temp_zk_id:string;
    startL,EndL:string;
    zkb_x,zkb_y:real;
    s,sql:string;
    kjBh,Jituan_id:string;
begin
        if  (Save_Lx<> 'find') then  exit;

        if (Kid>0) and (Gzmid<1 ) and (Zkid< 1) then  begin
            sql:= 'select  W.id As Wid,W.startDistance as WST,W.endDistance  as WED , C.CqName AS CQName, Z.zkName as ZKName, '+
                ' C.cqid as Cqid ,Z.Zkid as Zkid  from WorkFaceBuillDrill as W,cqcsb as C,zkb as Z where C.kid=   ' +IntToStr(kid)  +
                ' and Z.kid= ' +IntToStr(kid)  + ' and W.zkid=Z.zkid and W.Gzmid=C.cqid order by C.cqid,W.startDistance' ;

        end else if (Gzmid>0 ) then begin
           sql:= 'select  W.id As Wid,W.startDistance as WST,W.endDistance  as WED , C.CqName AS CQName, Z.zkName as ZKName, '+
                ' C.cqid as Cqid ,Z.Zkid as Zkid  from WorkFaceBuillDrill as W,cqcsb as C,zkb as Z where C.cqid=   ' +IntToStr(gzmid)  +
                ' and Z.kid= C.kid and W.zkid=Z.zkid and W.Gzmid='+IntToStr(gzmid)+' order by C.cqid,W.startDistance' ;
        end else if (Zkid>0 ) then begin
           sql:= 'select  W.id As Wid,W.startDistance as WST,W.endDistance  as WED , C.CqName AS CQName, Z.zkName as ZKName, '+
                ' C.cqid as Cqid ,Z.Zkid as Zkid  from WorkFaceBuillDrill as W,cqcsb as C,zkb as Z where C.cqid=  W.Gzmid  ' +
                ' and Z.kid= C.kid and Z.zkid='+IntToStr(Zkid) +' and W.Zkid='+IntToStr(Zkid)+' order by C.cqid,W.startDistance' ;
        end;

       SetCellHead;
       MySqlDataSet1.Close();

       MySqlDataSet1.CommandText:=Sql;
       MySqlDataSet1.Open;
       t_col:=1;t_row:=1;

       while not MySqlDataSet1.Eof  do        begin
           self.StringGrid1.Cells [1,t_row]:=MySqlDataSet1.FieldByName('Wid').AsString ;
           self.StringGrid1.Cells [2,t_row]:=MySqlDataSet1.FieldByName('CQName').AsString ;   // 工作面名称
           self.StringGrid1.Cells [3,t_row]:=MySqlDataSet1.FieldByName('ZKName').AsString ;   // 绑定钻孔名
           self.StringGrid1.Cells [4,t_row]:=MySqlDataSet1.FieldByName('WST').AsString;  //   //  开始距离
           self.StringGrid1.Cells [5,t_row]:=MySqlDataSet1.FieldByName('WED').AsString;   //  终止距离
           self.StringGrid1.Cells [6,t_row]:=MySqlDataSet1.FieldByName('Cqid').AsString; // 工作面 id
           self.StringGrid1.Cells [7,t_row]:=MySqlDataSet1.FieldByName('Zkid').AsString;;//  钻孔编号

           t_row:=t_row+1;
           if t_row>self.StringGrid1.RowCount  then
                  self.StringGrid1.RowCount :=t_row;

           MySqlDataSet1.Next ;

       end;
       MySqlDataSet1.Close ;
end;


procedure TZkGzmLink.FindButtonClick(Sender: TObject);
begin
    Save_Lx:='find';
    AddAndEditEnabled(true);
    self.SetEditValue('');
    OptionTip('正在进行【查看】操作!');
end;

procedure TZkGzmLink.FormActivate(Sender: TObject);
begin
   PubLic_Basic.InitStatusBar(self.StatusBar1);
   findButton.Click ;
end;

procedure TZkGzmLink.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    if assigned(ZkGzmLink) then  FreeAndNil(ZkGzmLink);
end;

procedure TZkGzmLink.FormCreate(Sender: TObject);
begin
     //
    MySqlDataSet1:=TMyDataSet.Create(nil);
    MySqlDataSet1.MySqlConnection :=MainDataModule.ExConn;

    MySqlDataSet2:=TMyDataSet.Create(nil);
    MySqlDataSet2.MySqlConnection :=MainDataModule.ExConn;

    MySqlDataSet3:=TMyDataSet.Create(nil);
    MySqlDataSet3.MySqlConnection :=MainDataModule.ExConn;

    MyCommand1:=TMyCommand.Create (nil);
    MyCommand1.MySqlConnection :=MainDataModule.ExConn;
   //


    MainTreeView(JITuanTreeView);

end;

procedure TZkGzmLink.FormDestroy(Sender: TObject);
begin
    FreeAndNil(MySqlDataSet1);
    FreeAndNil(MySqlDataSet2);
    FreeAndNil(MySqlDataSet3);

    FreeAndNil(MyCommand1);
end;

procedure TZkGzmLink.GetRootNodes(RNode:TTreeNode;InImageIndex:Integer);
var
   vNode:TTreeNode;
begin
  vNode:=RNode.getFirstChild;
  While vNode<>nil do
  begin
    vNode.ImageIndex:=InImageIndex;
    vNode:=vNode.GetNextChild(vNode);

  end;

end;

function TZkGzmLink.GzmAndZkIsEffective(Gzmid, zkid: String): Boolean;
var
  Sql:string;
  McId:Integer;
begin
     Result:=False;
     MCid:=0;
    try
     MySqlDataSet1.Close();
     sql:= 'select mcid  from cqcsb where  cqid=   ' +Gzmid;
     MySqlDataSet1.CommandText:=Sql;
     if   MySqlDataSet1.Open then
        if   MySqlDataSet1.RecordCount >0 then
            MCid:=MySqlDataSet1.FieldByName('mcid').AsInteger ;
     MySqlDataSet1.Close();
     if MCid<1 then  exit;

     sql:= 'select mcid  from Zkycb where  zkid=   ' +zkid +' and Mcid= '+IntToStr(MCid) ;
     MySqlDataSet1.CommandText:=Sql;
     if   MySqlDataSet1.Open then
        if   MySqlDataSet1.RecordCount >0 then
             Result:=true;

    finally
       MySqlDataSet1.Close();
    end;

end;

procedure TZkGzmLink.OptionTip(Str: String);
begin
   self.StatusBar1.Panels[0].Text :=str;
end;

procedure TZkGzmLink.RefreshCaptionLable(id: String);
begin
  if length(id) >0 then begin
    CaptionLable.Caption :='正在对【'+id+'】号【'+Edit_WorkFace.Text+'】【'+Edit_Drill.Text+'】数据进行编辑！';
  end else begin
     if (length(Edit_WorkFace.Text) >0 ) and ( length(Edit_Drill.Text) >0 ) then begin
        CaptionLable.Caption :='正在编辑【'+Edit_WorkFace.Text+'】工作面与【'+Edit_Drill.Text+'】钻孔数据！';
     end else if length(Edit_Drill.Text) >0 then begin
       CaptionLable.Caption :='正在编辑【'+Edit_Drill.Text+'】钻孔数据！';
     end else if (length(Edit_WorkFace.Text) >0) then begin
        CaptionLable.Caption :='正在编辑【'+Edit_WorkFace.Text+'】工作面数据！';
     end;
  end;


end;

procedure TZkGzmLink.RefreshEditEnabled(Value: Boolean);
begin
   Edit_Drill.Enabled := value;
   Edit_WorkFace.Enabled :=Value;
   Edit_Start_JUli.Enabled :=value;
   Edit_End_Juli.Enabled :=Value;
end;

procedure TZkGzmLink.SaveButtonClick(Sender: TObject);
var
  cou:Integer;
  sql:string;
begin
   if not CheckInsertValue  then  exit;

  try
    if  Save_Lx='insert' then     begin
        MyCommand1.CommandText:='insert into WorkFaceBuillDrill (ZKid,GZMid,startdistance,enddistance) values('+
                         zkID_s+','+gzmID_s+','+Trim(Edit_Start_JUlI.Text )+',' + Trim(Edit_End_JulI.Text )  + ')';

        MyCommand1.Execute(MainDataModule.ExUserName) ;
    end else if Save_Lx='update' then   begin
        if W_ID= '' then exit;
        MyCommand1.CommandText:=' update WorkFaceBuillDrill set startdistance= '+Trim(Edit_Start_JUlI.Text )+',enddistance='+
                                Trim(Edit_End_JulI.Text )+' where id='+W_ID ;
        MyCommand1.Execute(MainDataModule.ExUserName) ;
    end;
  except
    exit;
  end;

  OptionTip('数据存储成功!');
  //
  FindButton.Click ;
  FillCell(0,StrToInt(gzmID_s),0);

  SaveButton.Enabled :=false;
  AddButton.Enabled :=true;

end;

procedure TZkGzmLink.SetCellHead;
var
   i:integer;
begin
      // 清空单元格
      for i := 1 to  StringGrid1.RowCount - 1 do
          StringGrid1.Rows[i].Clear ;

     self.StringGrid1.ColCount :=10;
     self.StringGrid1.RowCount :=4;
     self.StringGrid1.Cells [1,0]:='序    号';
     self.StringGrid1.Cells [2,0]:='工作面名称';
     self.StringGrid1.Cells [3,0]:='钻孔名称';
     self.StringGrid1.Cells [4,0]:='开始距离';
     self.StringGrid1.Cells [5,0]:='结束距离';
     self.StringGrid1.Cells [6,0]:='gsmid';
     self.StringGrid1.Cells [7,0]:='zkid';


     self.StringGrid1.ColWidths[0]:=-1;
     self.StringGrid1.ColWidths[1]:=50;
     self.StringGrid1.ColWidths[2]:=80;
     self.StringGrid1.ColWidths[3]:=80;
     self.StringGrid1.ColWidths[4]:=80;
     self.StringGrid1.ColWidths[5]:=80;
     self.StringGrid1.ColWidths[6]:=-1;
     self.StringGrid1.ColWidths[7]:=-1;


end;

procedure TZkGzmLink.SetEditValue(Value: string);
begin
   Edit_Drill.Text := value;
   Edit_WorkFace.Text :=Value;
   Edit_Start_JUli.Text :=value;
   Edit_End_Juli.Text :=Value;
end;

procedure TZkGzmLink.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
    if (ARow=0) or (kArow=ARow) then   exit;
         KARow:=AROW;
    if length(Trim(StringGrid1.Cells [1,ARow]))>0 then  begin
       W_ID:=StringGrid1.Cells [1,ARow];
    end else begin
       W_ID:='';
       exit;
    end;
    Edit_WorkFAce.Text:=self.StringGrid1.Cells [2,ARow]; // 4 工作面名称

    Edit_Drill.Text:=self.StringGrid1.Cells [3,ARow]; //  已经绑定钻孔
    Edit_Start_Juli.Text:=self.StringGrid1.Cells [4,ARow]; // 6 开始距离
    Edit_End_JULI.Text:=self.StringGrid1.Cells [5,ARow]; // 7 结束距离

    Gzmid_s:= self.StringGrid1.Cells [6,ARow];  // gsmid
    zkid_s:= self.StringGrid1.Cells [7,ARow];  //  zkid
    RefreshCaptionLable(W_ID);
    self.DeleteButton.Enabled :=true;
    self.EditButton.Enabled :=true;
end;

procedure TZkGzmLink.WorkFaceTreeView(TreeView: TTreeView; XNode: TTreeNode;
  Meikuangid: String);
var
   RecData: PMyRec;
   XNode_First,xNode_Second:TTreeNode;
begin
          New(RecData);
          RecData^.BName:='1';
          RecData^.DName:='WorkFace_Lei';
          XNode_First := TreeView.Items.AddChildObject(XNode,'采煤工作面',RecData);
          XNode_First.ImageIndex:=0;
               //添加钻孔信息
          MySqlDataSet3.Close;
          MySqlDataSet3.CommandText:= 'SELECT  cqId,cqName FROM cqcsb WHERE kid='+Meikuangid+' ORDER BY cqID';
          MySqlDataSet3.Open;
          while not MySqlDataSet3.Eof do  begin
                New(RecData);
                RecData^.BName:='-3';
                RecData^.DName:='WorkFAce_DETIL';
                RecData^.XHeight:=Trim(MySqlDataSet3.FieldByName('cqId').AsString);
                xNode_Second:=TreeView.Items.AddChildObject(XNode_First,Trim(MySqlDataSet3.FieldByName('cqName').AsString),RecData);
                xNode_Second.ImageIndex:=2;
                MySqlDataSet3.Next;
          end;
          MySqlDataSet3.Close;

end;

procedure TZkGzmLink.JITuanTreeViewClick(Sender: TObject);
var
//  objname:    String;
//  objName3d:  String;
//  sp:double;
  XNode: TTreeNode;
//
//  LSTiShi:string;
//  isOpenDwg:boolean;
//  qryTemp:          TADOQuery;
//  LSString,gzm_s,zk_s,gzmName,sql:string;
//  i,j,cou :integer;
begin
if (JITuanTreeView.Selected = nil) or (PMyRec(JITuanTreeView.Selected.Data)^.DName = 'ROOT')   then  begin
     Exit;
   end;
if  (PMyRec(JITuanTreeView.Selected.Data)^.DName = 'ZK_LEI')  or
    (PMyRec(JITuanTreeView.Selected.Data)^.DName = 'WorkFace_Lei')  then   exit;


    XNode:=JITuanTreeView.Selected;

    if (XNode=nil) then        exit;

    if PMyRec(XNode.Data)^.BName='-2' then begin
      kid_s:=PMyRec(JITuanTreeView.Selected.Data)^.XHeight;
      if length(trim(kid_s))>0 then    FillCell(StrToInt(kid_s),0,0);

    end else if PMyRec(XNode.Data)^.BName='-3' then begin  //工作面
      Gzmid_s:= PMyRec(XNode.Data)^.XHeight;
      Kid_Gzm:= PMyRec(XNode.Parent.Parent.Data)^.XHeight;
      GetRootNodes(XNode.Parent,2);
      self.JITuanTreeView.Selected.SelectedIndex:=4;
      self.JITuanTreeView.Selected.ImageIndex:= JITuanTreeView.Selected.SelectedIndex;
      DealWithTreeViewClick(JITuanTreeView.Selected.Text,
                   StrToint(Kid_Gzm),StrToint(Gzmid_s),0);

    end else if PMyRec(XNode.Data)^.BName='-4' then begin  // 钻孔
      zkID_s:= PMyRec(XNode.Data)^.XHeight;
      Kid_zk:= PMyRec(XNode.Parent.Parent.Data)^.XHeight;
      GetRootNodes(XNode.Parent,2);
      self.JITuanTreeView.Selected.SelectedIndex:=4;
      self.JITuanTreeView.Selected.ImageIndex:= JITuanTreeView.Selected.SelectedIndex;
      DealWithTreeViewClick(JITuanTreeView.Selected.Text,
                            StrToint(Kid_zk),0,StrToint(zkID_s));

    end;

end;
procedure TZkGzmLink.JITuanTreeViewCollapsed(Sender: TObject; Node: TTreeNode);
begin
   Node.ImageIndex:=0;
   Node.SelectedIndex:=0;
end;

procedure TZkGzmLink.JITuanTreeViewExpanded(Sender: TObject; Node: TTreeNode);
begin
   Node.ImageIndex:=1;
   Node.SelectedIndex:=1;
end;
//增加，加载TreeView
procedure TZkGzmLink.MainTreeView(TreeView: TTreeView);
 var
  strcon: String;
  RecData: PMyRec;
  xNode,xNodeJing:TTreeNode;

begin
        //树图初始化
    TreeView.Items.Clear;
    MySqlDataSet1.Close;
    MySqlDataSet1.CommandText:= 'SELECT id,DwName from JituanName order by id';
    MySqlDataSet1.Open;
    MySqlDataSet1.First;

   while not MySqlDataSet1.Eof do begin
    New(RecData);
    RecData^.BName:='-1';
    RecData^.DName:='ROOT';
    RecData^.XHeight:=Trim(MySqlDataSet1.FieldByName('id').AsString);
    xNode:=TreeView.Items.AddObject(nil,Trim(MySqlDataSet1.FieldByName('DwName').AsString),RecData);
    Xnode.ImageIndex:=0;
    //
    MeiKuangTreeView(TreeView,xNode,RecData^.XHeight);
    //
    MySqlDataSet1.Next;
  end;
  MySqlDataSet1.Close;



end;

procedure TZkGzmLink.MeiKuangTreeView(TreeView: TTreeView; XNode: TTreeNode;Jituanid:String);
var
   RecData: PMyRec;
   XNodeChild:TTreeNode;
begin
    MySqlDataSet2.Close;
    MySqlDataSet2.CommandText:= 'SELECT id,MeiKuangMing from KuangJingXinXiBiao' +
       ' where Jituanid='+Jituanid +' order by id';
    MySqlDataSet2.Open;
      while not MySqlDataSet2.Eof do begin
           New(RecData);
           RecData^.BName:='-2';
           RecData^.DName:='KID';
           RecData^.XHeight:=Trim(MySqlDataSet2.FieldByName('id').AsString);
           XNodeChild:=TreeView.Items.AddChildObject(xNode,Trim(MySqlDataSet2.FieldByName('MeiKuangMing').AsString),RecData);
           XNodeChild.ImageIndex:=0;
           WorkFaceTreeView(TreeView,XNodeChild,RecData^.XHeight);
           DrillTreeView(TreeView,XNodeChild,RecData^.XHeight);
        MySqlDataSet2.Next ;
     end ;  // end  MaincForm ADODataSet2
     MySqlDataSet2.Close ;
end;

end.
