unit UnEditZJ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, ComCtrls, ToolWin, ExtCtrls, OleCtrls, Grids, System.ImageList,
  UMainDataModule;

type
  TZkZJForm = class(TForm)
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
    Label3: TLabel;
    EditKd: TEdit;
    Label2: TLabel;
    Label6: TLabel;
    EditXdj: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    EditMd: TEdit;
    Label4: TLabel;
    EditYsl: TEdit;
    Label5: TLabel;
    EditHbqd: TEdit;
    Label9: TLabel;
    EditHbgd: TEdit;
    Label10: TLabel;
    EditZcl: TEdit;
    Label11: TLabel;
    EditZhqd: TEdit;
    Label12: TLabel;
    EditKdj: TEdit;
    EditHld: TEdit;
    ComboZJlx: TComboBox;
    ComboZjxh: TComboBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    StringGrid1: TStringGrid;
    Label23: TLabel;
    EditZjCcl: TEdit;
    Label24: TLabel;
    Label25: TLabel;
    EditYyfkqqd: TEdit;
    Label26: TLabel;
    Label27: TLabel;
    EditLzgj: TEdit;
    Label28: TLabel;
    StatusBar1: TStatusBar;
    procedure ExitButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);

    procedure EditButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EditKdKeyPress(Sender: TObject; var Key: Char);
    procedure ComboZjxhKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure ComboZjxhClick(Sender: TObject);
    procedure EditKdClick(Sender: TObject);
    procedure EditMdClick(Sender: TObject);
    procedure EditLzgjClick(Sender: TObject);
    procedure EditZjCclClick(Sender: TObject);
    procedure EditZclClick(Sender: TObject);
    procedure EditYslClick(Sender: TObject);
    procedure EditXdjClick(Sender: TObject);
    procedure EditKdjClick(Sender: TObject);
    procedure EditHbqdClick(Sender: TObject);
    procedure EditHbgdClick(Sender: TObject);
    procedure EditZhqdClick(Sender: TObject);
    procedure EditHldClick(Sender: TObject);
    procedure EditYyfkqqdClick(Sender: TObject);
    procedure ComboZjxhDblClick(Sender: TObject);
    procedure EditZjCclExit(Sender: TObject);
    procedure EditKdjExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure EditMdExit(Sender: TObject);
    procedure EditLzgjExit(Sender: TObject);
    procedure EditZclExit(Sender: TObject);
    procedure EditKdExit(Sender: TObject);
  private
    { Private declarations }
    i_Kid,i_cqid:Integer;   //矿ID，采区 ID
    i_Zid:integer; // 选中的NO
    KARow:integer;
    lzs,dim,Qt1,Qt2,Pt:double;
    zjk,kdj,zhqd:double;
    MySqlDataSet1:TMyDataSet;
    MyCommand1:TMyCommand;
    procedure SetCellHead; //设置Cell表头
    procedure FillCell; //填充表格
    procedure refreshCell; // 刷新表格
    procedure ClearEdit;   //清空编辑框  //
    function checkInputEdit:wordbool; //检查录入格式是否合格
    procedure SetEnable(ISCanEnable:bool);//控件显示格式
    procedure OptionTip(Str:String);
  public
    { Public declarations }
    Save_Lx:string;
    zjxh:string;
  end;
        //记录RockBasic
  type
    TYockBasic= class
       private
        Comboid:integer; //combo选择记录
        Name:String;     //     汉字名称
    end;

function CreateZj_inn(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;stdcall;
var
  ZkZJ_inn: TZkZJForm;
  YockBasic:array of TYockBasic;  


implementation

uses uWinFrameClass,  Lu_Public_BasicModual;


{$R *.dfm}

function CreateZj_inn(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;stdcall;
 begin
       if Assigned(ZkZj_inn) then  FreeANdNil(ZkZj_inn);

        ZkZJ_inn:=TZkZJForm.Create(nil);
        try
           with ZkZJ_inn do begin
               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

                Show;
                SetFocus;
                Result:=ZkZj_inn.Handle;//函数值
          end ;
        except
         FreeAndNil(ZkZJ_inn);
        end;
end;



function TZkZJForm.checkInputEdit;
begin
  result:=false;
  if self.ComboZJlx.ItemIndex=-1 then
  begin
    messagebox(self.Handle,'请选择支架类型！','系统提示',mb_iconerror+mb_ok);
    exit;
  end else if trim(self.ComboZjxh.Text)='' then
  begin
    messagebox(self.Handle,'请填写支架型号！','系统提示',mb_iconerror+mb_ok);
    exit;
  end else if trim(EditKd.Text)='' then
  begin
    messagebox(self.Handle,'请填写支架宽度！','系统提示',mb_iconerror+mb_ok);
    exit;
//  end else if trim(EditXdj.Text)='' then
//  begin
//    EditXdj.Text:='0';
//    messagebox(self.Handle,'请填写支架悬顶距！','系统提示',mb_iconerror+mb_ok);
//    exit;
  end else if trim(EditMd.Text)=''  then
  begin
    messagebox(self.Handle,'','系统提示',mb_iconerror+mb_ok);
    ShowMessage('请填写支架立柱个数！');
    exit;
  end else if trim(EditYsl.Text)='' then
  begin
    EditYsl.Text:='0';
    messagebox(self.Handle,'请填写支架压缩量！','系统提示',mb_iconerror+mb_ok);
    exit;
  end else if trim(EditHbqd.Text)='' then
  begin
    EditHbqd.Text:='0';
    messagebox(self.Handle,'','系统提示',mb_iconerror+mb_ok);
    ShowMessage('请填写支架护帮强度！');
    exit;
  end else if trim(EditHbgd.Text)=''then
  begin
    EditHbgd.Text:='0';
    messagebox(self.Handle,'请填写支架护帮高度！','系统提示',mb_iconerror+mb_ok);
    exit;
  end else if trim(EditZcl.Text)='' then
  begin
    EditZcl.Text:='0';
    messagebox(self.Handle,'','系统提示',mb_iconerror+mb_ok);
    ShowMessage('请填写支架支撑力！');
    exit;
  end else if trim(EditZhqd.Text)=''then
  begin
    messagebox(self.Handle,'请填写支架支护强度！','系统提示',mb_iconerror+mb_ok);
    exit;
  end else if trim(EditHld.Text)='' then
  begin
    messagebox(self.Handle,'请填写支架合力作用点！','系统提示',mb_iconerror+mb_ok);
    exit;
  end else if trim(EditKdj.Text)='' then
  begin
    messagebox(self.Handle,'请填写支架控顶距！','系统提示',mb_iconerror+mb_ok);
    exit;
  end else if trim(EditZjCcl.Text)=''  then
  begin
     messagebox(self.Handle,'请填写初撑力！','系统提示',mb_iconerror+mb_ok);
     exit;
  end else if trim(EditYyfkqqd.Text)=''  then
  begin
      messagebox(self.Handle,'请填写液压阀开启强度！','系统提示',mb_iconerror+mb_ok);
      exit;
  end else if EditLzgj.Text = '' then  //2016-6-28
  begin
      messagebox(self.Handle,'请填写立柱缸径！','系统提示',mb_iconerror+mb_ok);
      exit;
  end;
           
  
  result:=true;
end;
//清空编辑框  //13-3-26-16-zry
procedure TZkZJForm.ClearEdit;
begin
    EditKd.Text:='';
    EditXdj.Text:='';
    EditMd.Text:='';
    EditYsl.Text:='';
    EditHbqd.Text:='';
    EditHbgd.Text:='';
    EditZcl.Text:='';
    EditZhqd.Text:='';
    EditHld.Text:='';
    EditKdj.Text:='';
    ComboZJlx.ItemIndex:=-1;
    ComboZjxh.ItemIndex:=-1;

    EditZjCcl.Text:='';   //2016-6-2 添加
    EditYyfkqqd.Text:=''; //2016-6-2 添加
    EditLzgj.Text:='';//2016-6-28添加
end;

procedure TZkZJForm.ComboZjxhClick(Sender: TObject);
var
  Key:char;
begin
    Key:=#37;
    ComboZjxh.SetFocus ;
    ComboZjxh.OnKeyPress(Sender,Key);
end;

procedure TZkZJForm.ComboZjxhDblClick(Sender: TObject);
var
  Key:char;
begin
    Key:=#39;
    ComboZjxh.SetFocus ;
    ComboZjxh.OnKeyPress(Sender,Key);
end;

procedure TZkZJForm.ComboZjxhKeyPress(Sender: TObject; var Key: Char);
begin

//    if not (key in ['0'..'9','A'..'Z','a'..'z',' ','/','\','_',#8]) then key:=#0
end;

procedure TZkZJForm.FormActivate(Sender: TObject);
begin
     PubLic_Basic.InitStatusBar(self.StatusBar1);
end;

procedure TZkZJForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   
    if Assigned(ZkZJ_inn) then  FreeAndNil(ZkZJ_inn);
end;

procedure TZkZJForm.FormCreate(Sender: TObject);

begin
  //
    MySqlDataSet1:=TMyDataSet.Create(nil);
    MySqlDataSet1.MySqlConnection :=MainDataModule.ExConn;

    MyCommand1:=TMyCommand.Create (nil);
    MyCommand1.MySqlConnection :=MainDataModule.ExConn;
   //

   MainDataModule.MySQlFillComBox(MySqlDataSet1,ComboZjxh,'select distinct xh from zjxhb','xh','','');
   self.FillCell ;
   SetEnable(false); //2016-6-29
   //--------------------------------
    lzs:=-1;dim:=-1;Qt1:=-1;Qt2:=-1;Pt:=-1;
    zjk:=-1;kdj:=-1;zhqd:=-1;
end;

procedure TZkZJForm.FormDestroy(Sender: TObject);
begin
    FreeAndNil(MySqlDataSet1);
    FreeAndNil(MyCommand1);
end;

procedure TZkZJForm.OptionTip(Str: String);
begin
  self.StatusBar1.Panels[0].Text :=str;
end;

procedure TZkZJForm.AddButtonClick(Sender: TObject);
begin

    i_zid:=0;
    //控制按钮
    self.SaveButton.Enabled :=true;
    self.EditButton.Enabled :=false;
    

  i_zid :=0;
  Save_Lx:='add'; //
  
  ClearEdit;
  SetEnable(true);//2016-6-29
    OptionTip('正在进行【添加】操作!');
end;

procedure TZkZJForm.DeleteButtonClick(Sender: TObject);
 Var
   t_s:String;
   t_sql:String;
begin
    t_s:='你确定要删除【'+self.ComboZJXh.Text+'】的数据么?';
    if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

    t_sql:='delete from  zjxhb  where id='+self.StringGrid1.Cells [16,i_Zid];
   try
      MyCommand1.CommandText :=t_sql;
      MyCommand1.Execute(MainDataModule.ExUserName)  ;
   except
      exit;
   end;

    //填充Cell
    self.FillCell ;
    self.refreshCell ;
    //控制按钮
    self.DeleteButton.Enabled :=false;
    self.AddButton.Enabled :=true;

    //提示信息
     OptionTip('数据删除成功!');

   i_Kid :=0;
   i_zid:=0;   
   ClearEdit;
   SetEnable(false);//2016-6-29
end;

procedure TZkZJForm.EditButtonClick(Sender: TObject);
begin
   //控制按钮
   self.EditButton.Enabled :=false;
   self.SaveButton.Enabled :=true;
   Save_Lx:='up'; //
   SetEnable(true); //2016-6-29
    OptionTip('正在进行【修改】操作!');
end;

procedure TZkZJForm.EditHbgdClick(Sender: TObject);
begin
   EditHbgd.SetFocus;
end;

procedure TZkZJForm.EditHbqdClick(Sender: TObject);
begin
    EditHbqd.SetFocus;
end;

procedure TZkZJForm.EditHldClick(Sender: TObject);
begin
     EditHld.SetFocus;
end;

procedure TZkZJForm.EditKdClick(Sender: TObject);
begin
    EditKd.SetFocus;
end;

procedure TZkZJForm.EditKdExit(Sender: TObject);
begin
   zjk:=Public_Basic.StrToDouble_lu(EditKd.Text );
end;

procedure TZkZJForm.EditKdjClick(Sender: TObject);
begin
       EditKdj.SetFocus;
end;

procedure TZkZJForm.EditKdjExit(Sender: TObject);
begin
    kdj:=Public_Basic.StrToDouble_lu(EditKdj.Text );
    Edithld.Text :=FormatFloat('0.0',Public_Basic.StrToDouble_lu(EditKdj.Text )/2);
end;

procedure TZkZJForm.EditKdKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkZJForm.EditLzgjClick(Sender: TObject);
begin
     EditLzgj.SetFocus;
end;

procedure TZkZJForm.EditLzgjExit(Sender: TObject);
begin
     Dim:=Public_Basic.StrToInt_lu(EditLzgj.Text) ;
end;

procedure TZkZJForm.EditMdClick(Sender: TObject);
begin
   EditMd.SetFocus;
end;

procedure TZkZJForm.EditMdExit(Sender: TObject);
begin
    lzs:=Public_Basic.StrToInt_lu(EditMd.Text) ;
end;

procedure TZkZJForm.EditXdjClick(Sender: TObject);
begin
    EditXdj.SetFocus;
end;

procedure TZkZJForm.EditYslClick(Sender: TObject);
begin
    EditYsl.SetFocus;
end;

procedure TZkZJForm.EditYyfkqqdClick(Sender: TObject);
begin
   EditYyfkqqd.SetFocus;
end;

procedure TZkZJForm.EditZclClick(Sender: TObject);
begin
    EditZcl.SetFocus;
end;

procedure TZkZJForm.EditZclExit(Sender: TObject);
var
 ss:double;
begin
    Pt:=Public_Basic.StrToInt_lu(EditZcl.Text) ;
    if EditKd.Text<> '' then
       zjk:=Public_Basic.StrToDouble_lu(EditKd.Text );
    if EditKdj.Text<>'' then
       kdj:=Public_Basic.StrToDouble_lu(EditKdj.Text );
    if EditMd.Text <>'' then
       lzs:=Public_Basic.StrToInt_lu(EditMd.Text) ;
    if EditLzgj.Text<>'' then
       Dim:=Public_Basic.StrToInt_lu(EditLzgj.Text) ;

    if (zjk>0) and (kdj>0) then   begin
       zhqd:=pt/zjk/kdj/1000;
       Editzhqd.Text :=formatFloat('0.00',zhqd);
    end;

    //
    if (lzs>0) and (Dim>0) then  begin
      SS:=0.25*3.1415926*sqr(Dim/1000);
      qt2:=pt/lzs/SS/1000;
      EditYyfkqqd.Text:= formatFloat('0.00',qt2);
    end;

end;

procedure TZkZJForm.EditZhqdClick(Sender: TObject);
begin
    EditZhqd.SetFocus;
end;

procedure TZkZJForm.EditZjCclClick(Sender: TObject);
begin
    EditZjCcl.SetFocus;
end;

procedure TZkZJForm.EditZjCclExit(Sender: TObject);
begin
   Qt1 :=Public_Basic.StrToDouble_Lu(EditZjCcl.Text) ;
end;

procedure TZkZJForm.ExitButtonClick(Sender: TObject);
begin
  self.Close ;
end;
procedure TZkZJForm.SaveButtonClick(Sender: TObject);
 var
  t_sql,gzm_sql:String;
begin
  if self.checkInputEdit=false then exit;

  begin
    if Save_Lx ='add' then   begin   //是增加操作
      t_sql:='insert into zjxhb (lx,xh,zjkd,kdj,xdj,hld,zjmd,ysl,zcl,hbqd,hbgd,zhqd,zjczl,yyfkqqd,lzgj) values('''+
              self.ComboZJlx.Text+ ''','''+self.ComboZjxh.Text+ ''','+
              self.EditKd.Text+','+self.EditKdj.Text+','+
              self.EditXdj.Text+','+self.EditHld.Text+','+
              self.EditMd.Text+','+self.EditYsl.Text+','+
              self.EditZcl.Text+','+self.EditHbqd.Text+','+
              self.EditHbgd.Text+','+self.EditZhqd.Text+','+
              self.EditZjCcl.Text+','+self.EditYyfkqqd.Text+','+self.EditLzgj.Text+')';   //2016-6-28 修改
    end else if Save_Lx='up' then   //是修改操作
    begin
      t_sql:='update zjxhb set'+
              ' lx='''+self.ComboZJlx.Text+''',xh='''+self.ComboZjxh.Text+
              ''',zjkd='+self.EditKd.Text+',kdj='+self.EditKdj.Text+
              ',xdj='+self.EditXdj.Text+',hld='+self.EditHld.Text+
              ',zjmd='+self.EditMd.Text+',ysl='+self.EditYsl.Text+
              ',zcl='+self.EditZcl.Text+',hbqd='+self.EditHbqd.Text+
              ',hbgd='+self.EditHbgd.Text+',zhqd='+self.EditZhqd.Text+
              ',zjczl='+self.EditZjCcl.Text+',yyfkqqd='+self.EditYyfkqqd.Text+  //2016-6-28 修改
              ',lzgj = '+self.EditLzgj.Text+' where id='+self.StringGrid1.Cells [16,i_Zid];
       gzm_sql:='select cqID from cqcsb where zjxh='''+zjxh+'''';
       MyCommand1.CommandText :=gzm_sql;
       if MyCommand1.Execute  then
       begin
        gzm_sql:='update cqcsb set zjxh='''+ComboZjxh.Text+''' where zjxh='''+zjxh+'''';
         MyCommand1.CommandText :=gzm_sql;
         MyCommand1.Execute(MainDataModule.ExUserName)  ;
       end;

    end;
  end;
 try
   MyCommand1.CommandText :=t_sql;
   MyCommand1.Execute ;
 except
   exit;
 end;

    //填充Cell
    self.FillCell ;
    self.refreshCell ;
    //控制按钮
    self.SaveButton.Enabled :=false;
    self.AddButton.Enabled :=true;

    //提示信息
     OptionTip('数据存储成功!');
     MainDataModule.MySQlFillComBox(MySqlDataSet1,ComboZjxh,'select distinct xh from zjxhb','xh','','');

     i_zid :=0;
     Save_Lx:=''; //
     ClearEdit;
     SetEnable(false);//
end;

procedure TZkZJForm.SetCellHead;
 var
   i:integer;
begin
      // 清空单元格
      for i := 1 to  StringGrid1.RowCount - 1 do
          StringGrid1.Rows[i].Clear ;
     self.StringGrid1.ColCount:=17;
     self.StringGrid1.RowCount :=4;
     self.StringGrid1.Cells [0,0]:='序号';
     self.StringGrid1.Cells [1,0]:='支架类型';
     self.StringGrid1.Cells [2,0]:='支架型号';
     self.StringGrid1.Cells [3,0]:='支架宽度';
     self.StringGrid1.Cells [4,0]:='支架控顶距';
     self.StringGrid1.Cells [5,0]:='支架悬顶距';
     self.StringGrid1.Cells [6,0]:='支架合力作用点';
     self.StringGrid1.Cells [7,0]:='支架立柱数';
     self.StringGrid1.Cells [8,0]:='支架压缩量';
     self.StringGrid1.Cells [9,0]:='支架支撑力';
     self.StringGrid1.Cells [10,0]:='支架护帮强度';
     self.StringGrid1.Cells [11,0]:='支架护帮高度';
     self.StringGrid1.Cells [12,0]:='支架支护强度';

     //2016-6-2 添加初撑力、液压阀开启强度，ID最后一列编号成15
     self.StringGrid1.Cells [13,0]:='支架初撑力';
     self.StringGrid1.Cells [14,0]:='液压阀开启强度';

     self.StringGrid1.Cells [15,0]:='立柱缸径';
     self.StringGrid1.Cells [16,0]:='编号';


     self.StringGrid1.ColWidths[0]:=30;
     self.StringGrid1.ColWidths[1]:=50;
     self.StringGrid1.ColWidths[2]:=80;
     self.StringGrid1.ColWidths[3]:=50;
     self.StringGrid1.ColWidths[4]:=80;
     self.StringGrid1.ColWidths[5]:=80;
     self.StringGrid1.ColWidths[6]:=90;
     self.StringGrid1.ColWidths[7]:=80;
     self.StringGrid1.ColWidths[8]:=80;
     self.StringGrid1.ColWidths[9]:=60;
     self.StringGrid1.ColWidths[10]:=80;
     self.StringGrid1.ColWidths[11]:=80;
     self.StringGrid1.ColWidths[12]:=80;

     self.StringGrid1.ColWidths[13]:=80;
     self.StringGrid1.ColWidths[14]:=80;
     self.StringGrid1.ColWidths[15]:=80;
     self.StringGrid1.ColWidths[16]:=0;

 end;

procedure TZkZJForm.SetEnable(ISCanEnable: bool);
begin
    EditKd.Enabled:=ISCanEnable;
    EditXdj.Enabled:=ISCanEnable;
    EditMd.Enabled:=ISCanEnable;
    EditYsl.Enabled:=ISCanEnable;
    EditHbqd.Enabled:=ISCanEnable;
    EditHbgd.Enabled:=ISCanEnable;
    EditZcl.Enabled:=ISCanEnable;
    EditZhqd.Enabled:=ISCanEnable;
    EditHld.Enabled:=ISCanEnable;
    EditKdj.Enabled:=ISCanEnable;
    ComboZJlx.Enabled:=ISCanEnable;
    ComboZjxh.Enabled:=ISCanEnable;

    EditZjCcl.Enabled:=ISCanEnable;
    EditYyfkqqd.Enabled:=ISCanEnable;
    EditLzgj.Enabled:=ISCanEnable;
end;

procedure TZkZJForm.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;   var CanSelect: Boolean);
var
   s_temp:Str_DT_array;
   C1,i:integer;

begin
//  if (ARow=0) or (kArow=ARow) then   exit;
//         KARow:=AROW;

  i_Zid:=ARow;
  self.ComboZJlx.ItemIndex:= self.ComboZJlx.Items.IndexOf(StringGrid1.Cells[1,i_Zid]);   // 1 支架类型

//  ComboZjxh.Text:=self.StringGrid1.Cells [2,i_Zid]; // 2 支架型号

  ComboZjxh.ItemIndex := ComboZjxh.Items.IndexOf(trim(self.StringGrid1.Cells [2,i_Zid]));
  EditKd.Text:=self.StringGrid1.Cells [3,i_Zid]; // 3 支架宽度
  EditKdj.Text:=self.StringGrid1.Cells [4,i_Zid]; // 4 支架控顶距
  EditXdj.Text:=self.StringGrid1.Cells [5,i_Zid]; // 5 支架悬顶距
  EditHld.Text:=self.StringGrid1.Cells [6,i_Zid];  // 6 合力点
  EditMd.Text:=self.StringGrid1.Cells [7,i_Zid];  // 7 立柱个数
  EditYsl.Text:=self.StringGrid1.Cells [8,i_Zid];  // 8 压缩量
  EditZcl.Text:=self.StringGrid1.Cells [9,i_Zid];  // 9 支撑力
  EditHbqd.Text:=self.StringGrid1.Cells [10,i_Zid];  // 10 护帮强度
  EditHbgd.Text:=self.StringGrid1.Cells [11,i_Zid];  // 11 护帮高度
  EditZhqd.Text:=self.StringGrid1.Cells [12,i_Zid];  // 12 支护强度

  EditZjCcl.Text:=self.StringGrid1.Cells [13,i_Zid];  // 13 初撑力 2016-6-2
  EditYyfkqqd.Text:=self.StringGrid1.Cells [14,i_Zid];  //14 液压阀开启强度 2016-6-2

  EditLzgj.Text :=self.StringGrid1.Cells [15,i_Zid];//15 立柱缸径  2016-6-28

  zjxh:=self.StringGrid1.Cells [2,i_Zid];
     //控制按钮
     self.EditButton.Enabled :=true;
     self.DeleteButton.Enabled :=true;


end;

procedure TZkZJForm.FillCell; //填充表格
  var
    t_col,t_row:integer;
    kname,jname,cqname:Ansistring;
    i:integer;
    J:integer;
   begin
       SetCellHead;
      
       MySqlDataSet1.Close();
       MySqlDataSet1.CommandText:='select * from zjxhb';
       MySqlDataSet1.Open;
       t_col:=1;t_row:=1;

       J:=1;
       while not  MySqlDataSet1.Eof  do
         begin
               self.StringGrid1.Cells [0,t_row]:=inttostr(J);
               self.StringGrid1.Cells [1,t_row]:= MySqlDataSet1.FieldByName('lx').AsString ;   // 1 支架类型
               self.StringGrid1.Cells [2,t_row]:= MySqlDataSet1.FieldByName('xh').AsString ; // 2 支架型号
               self.StringGrid1.Cells [3,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('zjkd').AsFloat);//MainCForm.ADODataSet1.FieldByName('zjkd').AsString ; // 3 支架宽度
               self.StringGrid1.Cells [4,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('kdj').AsFloat);//MainCForm.ADODataSet1.FieldByName('kdj').AsString ; // 4 支架控顶距
               self.StringGrid1.Cells [5,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('xdj').AsFloat);//MainCForm.ADODataSet1.FieldByName('xdj').AsString ; // 5 支架悬顶距
               self.StringGrid1.Cells [6,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('hld').AsFloat);//MainCForm.ADODataSet1.FieldByName('hld').AsString;  // 6 合力点
               self.StringGrid1.Cells [7,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('zjmd').AsFloat);//MainCForm.ADODataSet1.FieldByName('zjmd').AsString;  // 7 立柱个数
               self.StringGrid1.Cells [8,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('ysl').AsFloat);//MainCForm.ADODataSet1.FieldByName('ysl').AsString;  // 8 压缩量
               self.StringGrid1.Cells [9,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('zcl').AsFloat);//MainCForm.ADODataSet1.FieldByName('zcl').AsString;  // 9 支撑力
               self.StringGrid1.Cells [10,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('hbqd').AsFloat);//MainCForm.ADODataSet1.FieldByName('hbqd').AsString;  // 10 护帮强度
               self.StringGrid1.Cells [11,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('hbgd').AsFloat);//MainCForm.ADODataSet1.FieldByName('hbgd').AsString;  // 11 护帮高度
               self.StringGrid1.Cells [12,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('zhqd').AsFloat);//MainCForm.ADODataSet1.FieldByName('zhqd').AsString;  // 12 支护强度

               self.StringGrid1.Cells [13,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('zjczl').AsFloat); //13 支架初撑力 2016-6-2
               self.StringGrid1.Cells [14,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('yyfkqqd').AsFloat);//14 液压阀开启强度 2016-6-2

               self.StringGrid1.Cells [15,t_row]:= FormatFloat('.##',MySqlDataSet1.FieldByName('lzgj').AsFloat);;  // 15 立柱缸径 2016-6-28

               self.StringGrid1.Cells [16,t_row]:= MySqlDataSet1.FieldByName('id').AsString;  // 15 id

               t_row:=t_row+1;
              if t_row>self.StringGrid1.RowCount  then
                       self.StringGrid1.RowCount :=t_row;
              MySqlDataSet1.Next ;
             J:=J+1;
         end;
       MySqlDataSet1.Close ;
   end;

 procedure TZkZJForm.refreshCell; // 刷新表格
  var
    i,j :integer;
  begin

  end;

end.
