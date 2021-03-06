unit UnZkBasic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, ComCtrls, ToolWin, ExtCtrls, OleCtrls,
  Grids,System.ImageList,
  PStope_GzmGuidClass, UMainDataModule;

type
  TZkBasicForm = class(TForm)
    Splitter1: TSplitter;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    AddButton: TToolButton;
    EditButton: TToolButton;
    SaveButton: TToolButton;
    DeleteButton: TToolButton;
    ExitButton: TToolButton;
    ImageList1: TImageList;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    ComboKName: TComboBox;
    Label3: TLabel;
    EditZkBasic: TEdit;
    StringGrid1: TStringGrid;
    Label2: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Label5: TLabel;
    JiTuanCombo: TComboBox;
    StatusBar1: TStatusBar;
    But_AddYc: TToolButton;
    procedure ExitButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure ComboKNameChange(Sender: TObject);
    procedure ComboGzmChange(Sender: TObject);
//    procedure RBYesClick(Sender: TObject);
//    procedure RBNOClick(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure EditZkBasicClick(Sender: TObject);
    procedure JiTuanComboChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure But_AddYcClick(Sender: TObject);
  private
    { Private declarations }
     MySqlDataSet1:TMyDataSet;
     MySqlDataSet2:TMyDataSet;
     MyCommand1:TMyCommand;
     i_Kid,i_Jituan:Integer;   //矿ID，采区 ID
     i_Zid:integer; // 选中的NO
     KARow:integer;
     Save_Lx:string;
     ExHandle:THandle;
    procedure SetCellHead; //设置Cell表头
    procedure FillCell(id :integer); //填充表格
    procedure OptionTip(Str:String);


  public
    { Public declarations }
  end;
 function CreateZk_inn(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;stdcall;

var
  ZkBasicForm: TZkBasicForm;

implementation

uses UnEditGzk, uWinFrameClass,  Lu_Public_BasicModual, UnDetail;



{$R *.dfm}
function CreateZk_inn(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;stdcall;
begin
        ZkBasicForm:=TZkBasicForm.Create(nil);
        try
           with  ZkBasicForm do begin
               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;
               ExHandle:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

                Show;
                SetFocus;
                Result:=ZkBasicForm.Handle ;//函数值
           end;

        except
           FreeAndNil(ZkBasicForm);
        end;
end;

procedure TZkBasicForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

 if Assigned(ZkBasicForm) then  FreeAndNil(ZkBasicForm);

end;


procedure TZkBasicForm.FormCreate(Sender: TObject);
begin
  //
    MySqlDataSet1:=TMyDataSet.Create(nil);
    MySqlDataSet1.MySqlConnection :=MainDataModule.ExConn;
    MySqlDataSet2:=TMyDataSet.Create(nil);
    MySqlDataSet2.MySqlConnection :=MainDataModule.ExConn;
    MyCommand1:=TMyCommand.Create (nil);
    MyCommand1.MySqlConnection :=MainDataModule.ExConn;

end;



procedure TZkBasicForm.FormDestroy(Sender: TObject);
begin
     FreeAndNil(MySqlDataSet1);
     FreeAndNil(MyCommand1);

end;



procedure TZkBasicForm.FormShow(Sender: TObject);
begin
    MainDataModule.MySQlFillComBox(MySqlDataSet2,JiTuanCombo,'select * from JItuanName order by id','id','DwName','');
    FillCell(0);
    PubLic_Basic.InitStatusBar(self.StatusBar1);

end;

procedure TZkBasicForm.JiTuanComboChange(Sender: TObject);
 var
   s_temp:Str_DT_array;
   C1:integer;
   Sql:String;
begin

   s_temp:=Public_Basic.split(self.JituanCombo.Text,'_',C1);
   if s_temp[0]='' then exit;

   i_Jituan:=strToInt(s_temp[0]);
   if i_Jituan >0  then  begin
      Sql:='select * from KuangJingXinXiBiao  where Jituanid='+IntToStr(i_Jituan)+' order by id ' ;
   end else begin
      Sql:='select * from KuangJingXinXiBiao  order by id ' ;
   end;

   MainDataModule.MySQlFillComBox(MySqlDataSet2,ComboKName,sql,'id','MeiKuangMing','');

end;

procedure TZkBasicForm.OptionTip(Str: String);
begin
    self.StatusBar1.Panels[0].Text :=str;
end;

procedure TZkBasicForm.AddButtonClick(Sender: TObject);
begin
    self.EditZkBasic.Enabled :=true;
    self.EditZkBasic.Text :='';
    self.Edit1.Text:='';
    self.Edit2.Text:='';

    //控制按钮
    self.SaveButton.Enabled :=true;
    self.EditButton.Enabled :=false;
    EditZkBasic.SetFocus ;

    i_KID:=0;
    i_zid:=0;
    Save_Lx:='Insert'; //
    OptionTip('正在进行【添加】操作!');
end;

procedure TZkBasicForm.But_AddYcClick(Sender: TObject);
begin
  CreateDrillDetail_inn(ExHandle,'钻孔岩层信息维护界面',0,0);
end;

procedure TZkBasicForm.ComboGzmChange(Sender: TObject);
var
   s_temp:Str_DT_array;
   C1:integer;

begin



end;

procedure TZkBasicForm.ComboKNameChange(Sender: TObject);
 var
   s_temp:Str_DT_array;
   C1:integer;
begin

   s_temp:=Public_Basic.split(self.ComboKName.Text,'_',C1);

   if (C1>0)  then  begin
      i_kid:=strToInt(s_temp[0]);
      FillCell(i_kid);
   end else begin
      FillCell(0);
   end;

end;

procedure TZkBasicForm.DeleteButtonClick(Sender: TObject);
 Var
   t_s:String;
   t_sql:String;
begin
    t_s:='你确定要删除【'+self.EditZkBasic.Text+'】的数据么?';
    if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;
    if i_Zid<1 then  exit;

  try
     t_sql:='delete from  zkb  where zkid='+IntToStr(i_zid);

      MyCommand1.CommandText :=t_sql;

      MyCommand1.Execute(MainDataModule.ExUserName)  ;
  except
      exit;
  end;

    //填充Cell
    self.FillCell(0) ;
    //控制按钮
    self.DeleteButton.Enabled :=false;
    self.AddButton.Enabled :=true;
    // 控制录入框
    self.EditZkBasic.Text:='';
    //提示信息
    OptionTip('数据删除成功!');

   i_Kid :=0;

end;

procedure TZkBasicForm.EditButtonClick(Sender: TObject);
begin
   //控制按钮
   self.EditButton.Enabled :=false;
   self.SaveButton.Enabled :=true;
   self.AddButton.Enabled:=false;
   //控制录入框
    self.EditZkBasic.Enabled :=true;
    EditZkBasic.SetFocus ;
    Save_Lx:='Update';
    OptionTip('正在进行【修改】操作!');
end;

procedure TZkBasicForm.EditZkBasicClick(Sender: TObject);
begin
   EditZkBasic.SetFocus;
end;

procedure TZkBasicForm.ExitButtonClick(Sender: TObject);
begin
  self.Close ;
end;
procedure TZkBasicForm.SaveButtonClick(Sender: TObject);
 var
  t_sql:String;
  s_temp:Str_DT_array;
  C1,temp_id:integer;
begin
   if length(trim(self.EditZkBasic.Text))<1 then   exit;
   //获取矿区编号
   s_temp:=Public_Basic.split(self.ComboKName.Text,'_',C1);

   if (C1>1)  then  begin
      temp_id:=Public_Basic.strToInt_lu(s_temp[0]);
      if temp_id >0 then
         i_KID:=temp_id;
   end;

   if i_KID=0 then exit;

    if Save_Lx='Insert' then   begin
         t_sql:='insert into zkb (zkname,kid,isbd) values ('''+
               self.EditZkBasic.Text+''','+InttoStr(i_KID)+',''0'')';
    end else if Save_Lx='Update' then begin
         t_sql:='update zkb  set zkname ='''+self.EditZkBasic.Text+''',kid=' +
               InttoStr(i_KID) +',isbd=''0'' where zkid='+IntToStr(i_zid);
    end else begin
         exit;
    end;

    try
      MyCommand1.CommandText :=t_sql;
      MyCommand1.Execute(MainDataModule.ExUserName)  ;
    except
       exit;
    end;
    //填充Cell
    self.FillCell(i_KID) ;

    //控制按钮
    self.SaveButton.Enabled :=false;
    self.AddButton.Enabled :=true;
    // 控制录入框
    self.EditZkBasic.Enabled :=false;
    self.EditZkBasic.Text :='';

    //提示信息
    OptionTip('数据存储成功!');
    i_zid :=0;
    Save_Lx:='';

end;

procedure TZkBasicForm.SetCellHead;
var
   i:integer;
begin
      // 清空单元格
      for i := 1 to  StringGrid1.RowCount - 1 do
          StringGrid1.Rows[i].Clear ;

     self.StringGrid1.ColCount :=10;
     self.StringGrid1.RowCount :=4;
     self.StringGrid1.Cells [1,0]:='序    号';
     self.StringGrid1.Cells [2,0]:='钻孔编号';
     self.StringGrid1.Cells [3,0]:='钻孔名称';
     self.StringGrid1.Cells [4,0]:='集团公司';
     self.StringGrid1.Cells [5,0]:='矿    名';
     self.StringGrid1.Cells [6,0]:='kid';
     self.StringGrid1.Cells [7,0]:='集团编号';
     self.StringGrid1.Cells [8,0]:='经度x';
     self.StringGrid1.Cells [9,0]:='纬度y';

     self.StringGrid1.ColWidths[0]:=0;
     self.StringGrid1.ColWidths[1]:=100;
     self.StringGrid1.ColWidths[2]:=100;
     self.StringGrid1.ColWidths[3]:=100;
     self.StringGrid1.ColWidths[4]:=100;
     self.StringGrid1.ColWidths[5]:=100;
     self.StringGrid1.ColWidths[6]:=-1;
     self.StringGrid1.ColWidths[7]:=-1;
     self.StringGrid1.ColWidths[8]:=-1;
     self.StringGrid1.ColWidths[9]:=-1;

 end;

 procedure TZkBasicForm.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
 var
   s_temp:Str_DT_array;
   C1,i:integer;
begin
    if (ARow=0) or (KARow=ARow) then  exit;

     //根据鼠标位置改变录入
     self.EditZkBasic.text:=Trim(StringGrid1.Cells[3,ARow]);
     if length(Trim(StringGrid1.Cells[2,ARow]))>0 then   begin
         i_zid:=StrToInt(Trim(StringGrid1.Cells[2,ARow]));
     end else begin
         i_zid:=0;
         exit;
     end;

       //控制JiTuancombo
     for I := 0 to self.JiTuanCombo.Items.Count -1  do
        begin
              s_temp:=Public_Basic.split(self.JiTuanCombo.Items.Strings[i] ,'_',C1);
                if s_temp[0]=Trim(Trim(StringGrid1.Cells[7,ARow])) then
                  begin
                   i_jituan:=StrToInt(Trim(StringGrid1.Cells[7,ARow]));
                   self.JiTuanCombo.ItemIndex :=i;
                   break;
                  end;
        end;

    if length(Trim(Trim(StringGrid1.Cells[7,ARow]))) >0 THEN
        MainDataModule.MySQlFillComBox(MySqlDataSet2,ComboKName,'select * from KuangJingXinXiBiao  where Jituanid=' +
                     Trim(Trim(StringGrid1.Cells[7,ARow]))+' order by id ','id','MeiKuangMing','');


     //控制combokname
     for I := 0 to self.ComboKName.Items.Count -1  do
        begin
              s_temp:=Public_Basic.split(self.ComboKName.Items.Strings[i] ,'_',C1);
                if s_temp[0]=Trim(Trim(StringGrid1.Cells[6,ARow])) then
                  begin
                   i_Kid:=StrToInt(Trim(StringGrid1.Cells[6,ARow]));
                   self.ComboKName.ItemIndex :=i;
                   break;
                  end;
        end;
        self.Edit1.Text:=Trim(StringGrid1.Cells[8,ARow]);//14-5-12wd
        self.Edit2.Text:=Trim(StringGrid1.Cells[9,ARow]);//14-5-12wd

      KARow:=ARow;
     //控制按钮
     self.EditButton.Enabled :=true;
     self.DeleteButton.Enabled :=true;
     self.SaveButton.Enabled:=false;//13-3-22-9-zry 增加
     self.But_AddYc.Enabled :=True;
end;

procedure TZkBasicForm.FillCell(id :integer); //填充表格
var
    t_col,t_row,i:integer;
    kname,jname,cqname:Ansistring;
    zkb_x,zkb_y:real;
    s,sql:string;
    kjBh,Jituan_id:string;
   begin
       SetCellHead;
      //
       MySqlDataSet1.Close();
       if id=0 then    begin
          sql:=  'select * from zkb';
       end else begin
          sql:=  'select * from zkb where kid=' +IntTostr(id );
       end;

       MySqlDataSet1.CommandText:=Sql;
       MySqlDataSet1.Open;
       t_col:=1;t_row:=1;

       while not MySqlDataSet1.Eof  do        begin
             MySqlDataSet2.Close;
             MySqlDataSet2.CommandText:='select * from KuangJingXinXiBiao where id= '+
                       MySqlDataSet1.FieldByName('kid').AsString+'' ;
             MySqlDataSet2.Open;
             if MySqlDataSet2.RecordCount >0 then   begin
                  Kname:=MySqlDataSet2.FieldByName('jituanName').AsString ;
                  Jname:=MySqlDataSet2.FieldByName('MeiKuangMing').AsString ;
                  kjBh:= MySqlDataSet2.FieldByName('id').AsString;
                  Jituan_id:=MySqlDataSet2.FieldByName('JiTuanid').AsString;
                end;
             MySqlDataSet2.Close;
           self.StringGrid1.Cells [1,t_row]:=Inttostr(MySqlDataSet1.RecNo);
           self.StringGrid1.Cells [2,t_row]:=MySqlDataSet1.FieldByName('zkid').AsString ;   //钻孔编号
           self.StringGrid1.Cells [3,t_row]:=MySqlDataSet1.FieldByName('zkname').AsString; // 钻孔名称
           self.StringGrid1.Cells [4,t_row]:=Kname;  // 矿名
           self.StringGrid1.Cells [5,t_row]:=jname;  // 井名
           self.StringGrid1.Cells [6,t_row]:=kjBh;  //  矿井编号
           self.StringGrid1.Cells [7,t_row]:=Jituan_id;  //  集团公司编号

           t_row:=t_row+1;
           if t_row>self.StringGrid1.RowCount  then
                  self.StringGrid1.RowCount :=t_row;
           MySqlDataSet1.Next ;
         end;

         MySqlDataSet1.Close ;
         self.EditZkBasic.Text :='';
         self.Edit1.Text:='';
         self.Edit2.Text:='';

   end;


end.
