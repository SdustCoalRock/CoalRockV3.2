unit UnEditGzk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, ComCtrls, ToolWin, ExtCtrls, OleCtrls,StrUtils,
  Grids,ADODB, DB,SQLiteTable3,SQLite3, System.ImageList,
  PStope_GzmGuidClass ,UMainDataModule,UnTxMc;

type
  TZkGzmForm = class(TForm)
    Splitter1: TSplitter;
    ImageList1: TImageList;
    Panel1: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    EditCqName: TEdit;
    Label2: TLabel;
    ComboMcId: TComboBox;
    Label5: TLabel;
    EditMcHd: TEdit;
    Label6: TLabel;
    EditzKcgd: TEdit;
    Label7: TLabel;
    ComboCmFa: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    AddButton: TToolButton;
    EditButton: TToolButton;
    SaveButton: TToolButton;
    DeleteButton: TToolButton;
    ExitButton: TToolButton;
    Label15: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    Label12: TLabel;
    EditGc: TEdit;
    EditZxc: TEdit;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label36: TLabel;
    LablMK: TLabel;
    Editqj2: TEdit;
    Editqj1: TEdit;
    EditQxc: TEdit;
    ComboMKy: TComboBox;
    Combozhqk: TComboBox;
    ComboZJType: TComboBox;
    ComboYxFx: TComboBox;
    ComboJYhd: TComboBox;
    EditSpeed: TEdit;
    ComboDzgz: TComboBox;
    Label17: TLabel;
    EditSh1: TEdit;
    Label18: TLabel;
    Label11: TLabel;
    Editsh2: TEdit;
    Label19: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    ComboBottomWater: TComboBox;
    ComboTopWater: TComboBox;
    ComboWs: TComboBox;
    ComboHdzh: TComboBox;
    ComboKsyl: TComboBox;
    ComboStress: TComboBox;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    StringGrid1: TStringGrid;
    FcRadioButton: TRadioGroup;
    Label46: TLabel;
    Label47: TLabel;
    EditJueJin: TEdit;
    Label48: TLabel;
    Button1: TButton;
    Label4: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    ComboSupNumberDirection: TComboBox;
    SupStartNumber: TEdit;
    SupEndNumber: TEdit;
    cboQyzt: TComboBox;
    Label53: TLabel;
    CkCkq: TButton;
    CkDc: TButton;
    CkMz: TButton;
    CreatTable: TButton;
    btnBf: TButton;
    btnHf: TButton;
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    ComboKName: TComboBox;
    StatusBar1: TStatusBar;
    Label45: TLabel;
    JITuanCombo: TComboBox;
    But_EditFileName: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure ComboKNameChange(Sender: TObject);
    procedure ComboZkChange(Sender: TObject);
    procedure EditMcHdKeyPress(Sender: TObject; var Key: Char);
    procedure EditzKcgdKeyPress(Sender: TObject; var Key: Char);
    procedure EditSh1KeyPress(Sender: TObject; var Key: Char);
    procedure EditZxcKeyPress(Sender: TObject; var Key: Char);
    procedure EditGcKeyPress(Sender: TObject; var Key: Char);
    procedure Editsh2KeyPress(Sender: TObject; var Key: Char);
    procedure Editqj1KeyPress(Sender: TObject; var Key: Char);
    procedure Editqj2KeyPress(Sender: TObject; var Key: Char);
    procedure EditSpeedKeyPress(Sender: TObject; var Key: Char);
    procedure EditUPMzKeyPress(Sender: TObject; var Key: Char);
    procedure EditDownMzKeyPress(Sender: TObject; var Key: Char);
    procedure CombozhqkChange(Sender: TObject);
    procedure ComboCmFaChange(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FcRadioButtonClick(Sender: TObject);
    procedure EditJueJinKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);

    procedure EditSh1MouseEnter(Sender: TObject);

    procedure SupStartNumberKeyPress(Sender: TObject; var Key: Char);
    procedure SupEndNumberKeyPress(Sender: TObject; var Key: Char);
    procedure EditQxcKeyPress(Sender: TObject; var Key: Char);
    procedure CkCkqClick(Sender: TObject);
    procedure CkDcClick(Sender: TObject);
    procedure CkMzClick(Sender: TObject);
    procedure CreatTableClick(Sender: TObject);
    procedure btnBfClick(Sender: TObject);
    procedure btnHfClick(Sender: TObject);
    procedure EditCqNameClick(Sender: TObject);
    procedure SupEndNumberChange(Sender: TObject);
    procedure SupEndNumberClick(Sender: TObject);
    procedure SupStartNumberClick(Sender: TObject);
    procedure EditGcClick(Sender: TObject);
    procedure EditJueJinClick(Sender: TObject);
    procedure EditZxcClick(Sender: TObject);
    procedure EditQxcClick(Sender: TObject);
    procedure Editqj1Click(Sender: TObject);
    procedure Editqj2Click(Sender: TObject);
    procedure EditSpeedClick(Sender: TObject);
    procedure Editsh2Click(Sender: TObject);
    procedure EditSh1Click(Sender: TObject);
    procedure EditzKcgdClick(Sender: TObject);
    procedure EditMcHdClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure JITuanComboChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure ComboMcIdClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure But_EditFileNameClick(Sender: TObject);
  private
    { Private declarations } 
    FinGzm:TGzm;
    i_Kid,i_Jituan:Integer;   //��ID��//���Ź���˾���
    Save_Lx:string; //
    KARow:integer;
    gzmqyzt:Integer ;
    //2017 edit
    MySqlDataSet1:TMyDataSet;
    MySqlDataSet2:TMyDataSet;
    MyCommand1:TMyCommand;
    kczt,kccd:Integer;// ����״̬ �� ���ɵĽ���

    //
    procedure SetCellHead; //����Cell��ͷ
    procedure FillCell(id:Integer); //������
    procedure IniForm;  //��ʼ������
    procedure ClearEdit;   //��ձ༭��
    function  CheckInputEdit:wordbool; //���¼���ʽ�Ƿ�ϸ�
    procedure SetEnable(ISCanEnable:bool);
    procedure CboCsh(ISCom:bool);//combox��ʼ����ʱ��ѡ���һ�true��ʼ������Ϊ�գ�falseΪ���ӻ��޸�ʹ�ã�����һ��
    procedure OptionTip(Str:String);
    procedure SaveSupportInfo(SupportName:String);
  public
    KuangJingBianHao:string;
    ExHandle:THandle;
    EX_width,Ex_Height:integer;
    procedure Fill_MCBh_Combo;  //2016-6-14
  end;

 function CreateGzm_inn(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;stdcall;

var
  innGzmForm: TZkGzmForm;

implementation

uses math,IniFiles,FileCtrl , uWinFrameClass, UnCkq, UnDc,
  UnMz,  Lu_Public_BasicModual, uLuSqliteDealWith, UFormEditWordFile;

{$R *.dfm}
//�ڲ���ʼ�������溯��
function CreateGzm_inn(AHandle:THandle;ACaption:string;Wid,Hi:integer):THandle;stdcall;
   begin
        if Assigned(innGzmForm) then  FreeAndNil(innGzmForm);
        Application.Handle :=AHandle;
        innGzmForm:=TZkGzmForm.Create(nil);
        try
           with innGzmForm do begin
               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;
               //
               ExHandle:= AHandle;
               EX_width:=wid;
               Ex_Height:=hi;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

                Show;
                SetFocus;
                Result:=innGzmForm.Handle;//����ֵ
          end ;
        except
          FreeAndNil(innGzmForm);
        end;
end;


procedure TZkGzmForm.IniForm ;  // ��ʼ������
var
   t:TDateTime;
begin
     //�ӱ������ݿ��ȡ
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboCmFa,'select zdid,Text from zdname  where zdname=''cmfa'' order by zdid','zdid','Text',''); //��ú����
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboMKy,'select zdid,Text from zdname  where zdname=''mtyd'' order by zdid','zdid','Text',''); //ú��Ӳ��
     MainDataModule.MySqliteDataBase.SqliteComboList(Combozhqk ,'select zdid,Text from zdname  where zdname=''zhqk'' order by zdid','zdid','Text',''); //֧�����
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboYxFx ,'select zdid,Text from zdname  where zdname=''YxFX'' order by zdid','zdid','Text',''); //  ��б��б
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboJYhd  ,'select zdid,Text from zdname  where zdname=''JYHD'' order by zdid','zdid','Text',''); // ���Һ��
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboDzgz  ,'select zdid,Text from zdname  where zdname=''DCGZ'' order by zdid','zdid','Text',''); // ���ʹ���
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboWs  ,'select zdid,Text from zdname  where zdname=''WSFC'' order by zdid','zdid','Text',''); //  ��˹
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboTopWater  ,'select zdid,Text from zdname  where zdname=''TopWater'' order by zdid','zdid','Text',''); //  ����ˮ
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboBottomWater  ,'select zdid,Text from zdname  where zdname=''BottomWater'' order by zdid','zdid','Text',''); //  �װ�ˮ
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboStress  ,'select zdid,Text from zdname  where zdname=''HeoStress'' order by zdid','zdid','Text',''); //  �װ�ˮ
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboKsyl  ,'select zdid,Text from zdname  where zdname=''Kyxx'' order by zdid','zdid','Text',''); //  ��ѹ����
     MainDataModule.MySqliteDataBase.SqliteComboList(ComboHdzh   ,'select zdid,Text from zdname  where zdname=''HangDaoSup'' order by zdid','zdid','Text',''); // ���֧��
     //��¼�����ݿ��ȡҺѹ֧��
     MainDataModule.MySQlFillComBox(MySqlDataSet2,ComboZJType  ,'select xh,id from zjxhb  order by id', 'xh','',''); //  ֧���ͺ�
     MainDataModule.MySQlFillComBox(MySqlDataSet2,JiTuanCombo,'select * from JItuanName order by id','id','DwName','');
     ComboZJType.Items.Add('   ');
     ComboZJType.ItemIndex :=ComboZJType.Items.Count -1;

     ClearEdit;
     SetEnable(false);

end;

procedure TZkGzmForm.JITuanComboChange(Sender: TObject);
 var
   s_temp:Str_DT_array;
   C1:integer;
begin

   s_temp:=Public_Basic.split(self.JituanCombo.Text,'_',C1);
   if s_temp[0]='' then exit;

     i_Jituan:=strToInt(s_temp[0]);
     MainDataModule.MySQlFillComBox(MySqlDataSet2,ComboKName,'select * from KuangJingXinXiBiao  where Jituanid=' +
                      IntToStr(i_Jituan)+' order by id ','id','MeiKuangMing','');

     ComboKName.Enabled :=true;
      FillCell(0);
end;

procedure TZkGzmForm.OptionTip(Str: String);
begin
    self.StatusBar1.Panels[0].Text :=str;
end;

procedure TZkGzmForm.Fill_MCBh_Combo;
var
    s_temp:Str_DT_array;
   C1:integer;
   C1LS:integer;
begin
    s_temp:=Public_Basic.split(self.ComboKName.Text,'_',C1);
    if s_temp[0]='' then exit;
    i_kid:=strToInt(s_temp[0]);

     MainDataModule.MySQlFillComBox(MySqlDataSet2,ComboMcId ,'select ID,MeiCengMing from MeiCeng where KuangJingBianHao='+
          s_temp[0],'ID','MeiCengMing','' );
  self.ComboMcId.Items.Add('0_��');
  self.ComboMcId.ItemIndex := ComboMcId.Items.Count-1;

end;

procedure TZkGzmForm.CkCkqClick(Sender: TObject);
var
  StrOut:String;
begin
  StrOut:='��'+EditCqName.Text +'�����Ӳɿ���¼�����'  ;
  CreateUnCkq_inn(Handle,StrOut,FinGzm.Gzmbh);


end;

procedure TZkGzmForm.CkDcClick(Sender: TObject);
var
  StrOut:String;
begin
  StrOut:='��'+EditCqName.Text +'�����Ӷϲ�¼�����'  ;
  CreateUnDc_inn(Handle,StrOut,FinGzm.Gzmbh );

end;

procedure TZkGzmForm.CkMzClick(Sender: TObject);
var
  StrOut:String;
begin
  StrOut:='��'+EditCqName.Text +'������ ú��¼�����'  ;
  CreateUnMz_inn(Handle,StrOut,FinGzm.Gzmbh );

end;

procedure  TZkGzmForm.ClearEdit ;  //  ��ձ༭��
begin
      //clear ¼���
       self.EditCqName.Text :=''; // ��ղ�������
       self.ComboMcId.Items.Clear ;// ú����
       self.EditzKcgd.Text :='';//   ���ɸ߶�
       self.EditMcHd.Text :='';// ú�����
       self.EditSh1.Text :='';//    �ϱ߽����
       self.Editsh2.Text :='';//      �±߽����
       self.EditGc.Text :='';//     ƽ������
       self.EditZxc.Text:='';//    ���򳤶�
       self.EditQxc.Text :='';//   ���򳤶�
       self.Editqj2.Text :='';//    �������
       self.Editqj1.Text :='';//    �������
       self.EditSpeed.Text :='';//      �ƽ��ٶ�
     
       self.EditJueJin.Text:='';//  ��� �ۼƽ���
       self.SupStartNumber.Text:='';// ��ʼ֧�ܱ��  2016-6-3
       self.SupEndNumber.Text:='';//��ֹ֧�ܱ��     2016-6-3

     //clear InputGzm����
       FinGzm.S_Name:='';//     1 :  ��������
       FinGzm.S_mc_name:='';//  2 :  ú������
       FinGzm.S_Agv_mch:=0;//       3 :  ú�����
       FinGzm.S_Cg_h:=0;//      4 :  ���ɸ߶�
       FinGzm.S_cmfs :='0';//       5:   ��ú����
       FinGzm.S_Sh_UP :=0;//   6:    �ϱ߽����
       FinGzm.S_Sh_Down:=0;//  7:     �±߽����
       FinGzm.S_mcsd_h :=0;//  8:    ƽ������
       FinGzm.S_Sx_zx:=0; // 9:      ����
       FinGzm.S_L_qx :=0;// 10:       ����
       FinGzm.S_SX_qj :=0;//11:        �������
       FinGzm.S_qj :=0;// 12:      �������
       FinGzm.S_DayStep_speed:=0;//13:       �ƽ��ٶ�
       FinGzm.CK_Upkc:=0;  //           �ϱ߽�  ������� 1 �Ѳ� 0 δ��
       FinGzm.CK_UpMz:=0;// 14:    �ϱ߽�ú��
       FinGzm.CK_downkc:=0;   //           �ϱ߽�  ������� 1 �Ѳ� 0 δ��
       FinGzm.CK_downmz :=0;// 15��  �±߽�ú��

       FinGzm.KuangJingId :=0;  // 17:�������

       FinGzm.S_f_PS:=0;  // 18:ú��Ӳ��
       FinGzm.Dz_HangDaoSup  :=0;  // 19:֧�����

       FinGzm.SupportName :='';  // 20:֧���ͺ�
       FinGzm.Dz_yxfx  :=0;  // 21:��б��б

       FinGzm.Dz_JYHD :=0;  // 22: ���Һ��
       FinGzm.Dz_DCGZ :=0;  // 23:���ʹ���

       FinGzm.Dz_WSFC  :=0;  // 24: ��˹����
       FinGzm.Dz_TopWater  :=0;  // 25:����ˮԴ

       FinGzm.Dz_BottomWater  :=0;  // 26:  �װ�ˮԴ
       FinGzm.Dz_HeoStress  :=0;  // 27:ˮƽӦ��

       FinGzm.Dz_Kyxx :=0;  // 28:��ѹ����
       FinGzm.Dz_HangDaoSup  :=0;  // 29: ���֧��

       self.ComboKName.ItemIndex:=-1;
       self.ComboMcId.ItemIndex:=-1;


//     self.ComboZk.ItemIndex:=-1;


        SupStartNumber.Text :='';// ֧�ܿ�ʼ���
        SupEndNumber.Text :='';  //֧����ֹ���
       // ComboSupNumberDirection.ItemIndex :=-1; //֧���ͺŷ���
      //  cboQyzt.ItemIndex := -1; //������״̬

       ComboCmFa.ItemIndex :=2; //һ�β�ȫ��
       ComboMKy.ItemIndex :=2;//P 1.5-2
       Combozhqk.ItemIndex:=1;//Һѹ֧��
       ComboYxFx.ItemIndex :=0;// ˮƽ�ƽ�
       ComboJYhd.ItemIndex:=1;// һ�����
       ComboDzgz.ItemIndex:=0;//���ʹ������
       ComboWs.ItemIndex:=0;  //��˹Ũ�Ƚϵ�
       ComboTopWater.ItemIndex:=0;   //������ˮ
       ComboBottomWater.ItemIndex:=0; //�װ���ˮ
       ComboStress.ItemIndex:=0; //ˮƽӦ��С�ڴ�ֱӦ��
       ComboKsyl.ItemIndex:=1;//�п�ѹ����
       ComboHdzh.ItemIndex:=1;//��ê��֧��

       ComboMcId.ItemIndex := 0; //ú����
       ComboZJType.ItemIndex := 0; //֧���ͺ�
       ComboSupNumberDirection.ItemIndex := 0;   //�������
       cboQyzt.ItemIndex := 0; //����״̬

end;

procedure TZkGzmForm.SetEnable(ISCanEnable: LongBool);
begin
     ComboKName.Enabled:= ISCanEnable;
     EditCqName.Enabled:=ISCanEnable;
     EditMcHd.Enabled:= ISCanEnable;
     EditzKcgd.Enabled:= ISCanEnable;
     ComboCmFa.Enabled:= ISCanEnable;
     EditSh1.Enabled:= ISCanEnable;
     Editsh2.Enabled:= ISCanEnable;
     EditGc.Enabled:= ISCanEnable;
     EditZxc.Enabled:= ISCanEnable;
     EditQxc.Enabled:= ISCanEnable;
     EditJueJin.Enabled:=ISCanEnable;
     Editqj1.Enabled:= ISCanEnable;
     Editqj2.Enabled:= ISCanEnable;
     ComboMKy.Enabled:= ISCanEnable;
     Combozhqk.Enabled:= ISCanEnable;
     EditSpeed.Enabled:= ISCanEnable;
     SupStartNumber.Enabled:= ISCanEnable;
     SupEndNumber.Enabled:= ISCanEnable;
     ComboSupNumberDirection.Enabled:= ISCanEnable;
     cboQyzt.Enabled:= ISCanEnable;
     //
     ComboCmFa.Enabled:= ISCanEnable; //һ�β�ȫ��
     ComboMKy.Enabled:= ISCanEnable;//P 1.5-2
     Combozhqk.Enabled:= ISCanEnable;//Һѹ֧��
     ComboYxFx.Enabled:= ISCanEnable;// ˮƽ�ƽ�
     ComboJYhd.Enabled:= ISCanEnable;// һ�����
     ComboDzgz.Enabled:= ISCanEnable;//���ʹ������
     ComboWs.Enabled:= ISCanEnable;  //��˹Ũ�Ƚϵ�
     ComboTopWater.Enabled:= ISCanEnable;   //������ˮ
     ComboBottomWater.Enabled:= ISCanEnable; //�װ���ˮ
     ComboStress.Enabled:= ISCanEnable; //ˮƽӦ��С�ڴ�ֱӦ��
     ComboKsyl.Enabled:= ISCanEnable;//�п�ѹ����
     ComboHdzh.Enabled:= ISCanEnable;//��ê��֧��

     ComboMcId.Enabled:= ISCanEnable; //ú����
     ComboZJType.Enabled:= ISCanEnable; //֧���ͺ�


end;



procedure TZkGzmForm.btnBfClick(Sender: TObject);
var
   t_sql,sql:string;
   lsz,lsz1,lsz2:string;
   sltb1,sltb2: TSQLIteTable;
   lsz3:integer;
   wStr:string;
   i:integer;
   Path:string;

begin
//    //��ҪĿ���������ļ���
//       if not SelectDirectory('��ѡ�����ݴ洢Ŀ¼', '',Path)  then
//          exit;
//       if trim(path) ='' then  exit;
//
//    wStr:='ȷ���������ݱ�������ȷ�����ݿ�����ر��ݱ����ڣ�';
//
//    if MessageBox(0, Pchar(wstr),'��ʾ',MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDNO then exit;
//    try
//    sql:='SELECT * from CreateTable where CreatLeg in (2,3) and used = 1';
//    sltb1:= uMyDataModule.Maindb.GetTable(sql);
//    while not sltb1.Eof do
//    begin
//        lsz2:=sltb1.FieldByName['CreateTableName'];
//        lsz3:=strtoint(sltb1.FieldByName['CreatLeg']);
//        if lsz3 = 2 then begin
//           lsz1:='d_'+inttostr(FinGzm.cq_id)+'_'+lsz2+'';
//           lsz:=Path+'\'+lsz1+'.txt';
//
//           if FileExists(Lsz) then  DeleteFile(lsz);
//
//           t_sql:='select * from '+lsz1+' into outfile '''+lsz+'''';
//           t_sql:=StringReplace(t_sql, '\', '/', [rfReplaceAll]);
//
//           uMyDataModule.ExCommand1.CommandText :=t_sql;
//           uMyDataModule.ExCommand1.Execute ;
//
//            t_sql:='DROP TABLE '+lsz1+'';
//            uMyDataModule.ExCommand1.CommandText :=t_sql;
//            uMyDataModule.ExCommand1.Execute ;
//
//        end else if lsz3 = 3 then begin
//           for I := FinGzm.SupStartNumber to   FinGzm.SupEndNumber  do  begin
//                 lsz1:='d_'+inttostr(FinGzm.cq_id)+'_'+IntTostr(i)+'_'+lsz2;
//                 lsz:=Path+'\'+lsz1+'.txt';
//
//                 if FileExists(Lsz) then  DeleteFile(lsz);
//
//                 t_sql:='select * from '+lsz1+' into outfile '''+lsz+'''';
//                 t_sql:=StringReplace(t_sql, '\', '/', [rfReplaceAll]);
//
//                 uMyDataModule.ExCommand1.CommandText :=t_sql;
//                 uMyDataModule.ExCommand1.Execute ;
//
//                 t_sql:='DROP TABLE '+lsz1+'';
//                 uMyDataModule.ExCommand1.CommandText :=t_sql;
//                 uMyDataModule.ExCommand1.Execute ;
//           end;
//
//
//        end;
//         sltb1.Next;
//      end;
//      showmessage('���ݱ��ݵ�'''+Path+''' Ŀ¼�³ɹ���');
//    except
//       showmessage('���ݱ���ʧ�ܣ�');
//       exit;
//    end;
//
//    t_sql:='update  cqcsb  set qyzt =2 where cqid='+IntToStr(FinGzm.cq_id)+'';
//    uMyDataModule.ExCommand1.CommandText :=t_sql;
//    uMyDataModule.ExCommand1.Execute ;
//    CreatTable.Enabled:=false; //2016-7-5
//    btnBf.Enabled:=false;//2016-7-5
//    btnHf.Enabled:=true;//2016-7-5
//    cboQyzt.ItemIndex:=2;
//    self.FillCell(i_kid) ;
end;

procedure TZkGzmForm.btnHfClick(Sender: TObject);
var
   t_sql,sql:string;
   lsz,lsz1,lsz2:string;
   sltb1,sltb2: TSQLIteTable;
   lsz3,i:integer;
   wStr,path:string;
begin

//      if not SelectDirectory('��ѡ��ָ����ݴ洢��Ŀ¼', '',Path)  then
//          exit;
//       if trim(path) ='' then  exit;
//
//     wStr:='ȷ���������ݻָ�����ȷ�ϻָ������ļ����ڣ�';
//     if MessageBox(0, Pchar(wstr),'��ʾ',MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDNO then exit;
//
//     try
//     uMyDataModule.CreateMySqlTable('2',inttostr(FinGzm.cq_id),'');
//     sql:='SELECT * from CreateTable where CreatLeg in (2,3) and used = 1';
//     sltb1:= uMyDataModule.Maindb.GetTable(sql);
//     while not sltb1.Eof do
//     begin
//        lsz2:=sltb1.FieldByName['CreateTableName'];
//        lsz3:=strtoint(sltb1.FieldByName['CreatLeg']);
//        if lsz3 = 2 then begin
//           lsz1:='d_'+inttostr(FinGzm.cq_id)+'_'+lsz2+'';
//           lsz:=Path+'\'+lsz1+'.txt';
//
//           if  FileExists(Lsz) then  begin
//                 t_sql:='load data infile '''+lsz+''' into table '+lsz1+' CHARACTER SET utf8;';
//                 uMyDataModule.ExCommand1.CommandText :=t_sql;
//                 t_sql:=StringReplace(t_sql, '\', '/', [rfReplaceAll]);
//                 uMyDataModule.ExCommand1.Execute ;
//                 DeleteFile(lsz);
//            end;
//
//        end else if lsz3 = 3 then begin
//           for I := FinGzm.SupStartNumber to   FinGzm.SupEndNumber  do  begin
//                 uMyDataModule.CreateMySqlTable('3',inttostr(FinGzm.cq_id),IntToStr(i));
//                 lsz1:='d_'+inttostr(FinGzm.cq_id)+'_'+IntTostr(i)+'_'+lsz2;
//                 lsz:=Path+'\'+lsz1+'.txt';
//
//                 if  FileExists(Lsz) then  begin
//                      t_sql:='load data infile '''+lsz+''' into table '+lsz1+' CHARACTER SET utf8;';
//                     uMyDataModule.ExCommand1.CommandText :=t_sql;
//                     t_sql:=StringReplace(t_sql, '\', '/', [rfReplaceAll]);
//                     uMyDataModule.ExCommand1.Execute ;
//                     DeleteFile(lsz);
//                 end;
//           end;
//
//
//        end;
//
//         sltb1.Next;
//    end;
//        showmessage('���ݻָ��ɹ���');
//    except
//         showmessage('���ݻָ�ʧ�ܣ�');
//         exit;
//    end;
//
//    t_sql:='update  cqcsb  set qyzt = 1 where cqid='+IntToStr(FinGzm.cq_id)+'';
//    uMyDataModule.ExCommand1.CommandText :=t_sql;
//    uMyDataModule.ExCommand1.Execute ;
//
//    CreatTable.Enabled:=false; //2016-7-5
//    btnBf.Enabled:=true;//2016-7-5
//    btnHf.Enabled:=false;//2016-7-5
//    cboQyzt.ItemIndex:=1;
//    self.FillCell(i_kid) ;
end;

procedure TZkGzmForm.Button1Click(Sender: TObject);
var
  SDisp:String;
begin
    MainDataModule.UseFormName :='Gzm';
    SDisp:='��'+ComboKName.Text+'�������µ�ú��';
    CreateFormMC(Handle,SDisp,Self.ComboKName.Text,i_kid);
end;






procedure TZkGzmForm.But_EditFileNameClick(Sender: TObject);
begin
 {
   ExHandle:= AHandle;
               EX_width:=wid;
               Ex_Height:=hi;
 }
  CreateWorkFaceFileName(ExHandle,'��ѹ������ʱ���¼����',EX_width,Ex_Height);
  FormFileEdit.SetWorkFaceInfo(FinGzm.Gzmbh,FinGzm.S_Name) ;

end;

procedure TZkGzmForm.CboCsh(ISCom: bool);
begin
   if ISCom = true then begin
      ComboMcId.ItemIndex := -1;
      ComboCmFa.ItemIndex := -1;
      ComboMKy.ItemIndex := -1;
      Combozhqk.ItemIndex := -1;
      ComboZJType.ItemIndex := -1;
      ComboYxFx.ItemIndex := -1;
      ComboJYhd.ItemIndex := -1;
      ComboDzgz.ItemIndex := -1;
      ComboWs.ItemIndex := -1;
      ComboTopWater.ItemIndex := -1;
      ComboBottomWater.ItemIndex := -1;
      ComboStress.ItemIndex := -1;
      ComboKsyl.ItemIndex := -1;
      ComboHdzh.ItemIndex := -1;
      ComboSupNumberDirection.ItemIndex := -1;
      cboQyzt.ItemIndex := -1;
   end;
   if ISCom = false then  begin
      ComboMcId.ItemIndex := 0;
      ComboCmFa.ItemIndex := 0;
      ComboMKy.ItemIndex := 0;
      Combozhqk.ItemIndex := 0;
      ComboZJType.ItemIndex := 0;
      ComboYxFx.ItemIndex := 0;
      ComboJYhd.ItemIndex := 0;
      ComboDzgz.ItemIndex := 0;
      ComboWs.ItemIndex := 0;
      ComboTopWater.ItemIndex := 0;
      ComboBottomWater.ItemIndex := 0;
      ComboStress.ItemIndex := 0;
      ComboKsyl.ItemIndex := 0;
      ComboHdzh.ItemIndex := 0;
      ComboSupNumberDirection.ItemIndex := 0;
      cboQyzt.ItemIndex := 0;
   end;


end;

function TZkGzmForm.checkInputEdit:wordbool; //���¼���ʽ�Ƿ�ϸ�
var
  s_temp:Str_DT_array;
  C1:integer;
 begin
     Result:=false;
//

     if Trim(self.EditCqName.Text)=''   then   begin   //1:�жϲ������
         messagebox(self.Handle,'����������ƣ�','ϵͳ��ʾ',mb_iconerror+mb_ok);
         exit;
      end else begin
         FinGzm.S_Name:=self.EditCqName.Text;
      end;
     if Trim(self.ComboMcId.Text )=''   then   begin   //2:�ж�ú����
         messagebox(self.Handle,' ����ú���ţ� ','ϵͳ��ʾ',mb_iconerror+mb_ok);
         exit;
      end else begin
         s_temp:=Public_Basic.split(ComboMcId.Text,'_',C1);
         if C1>1 then  FinGzm.S_mc_name:=s_temp[0];
      end;

    if Trim(self.EditMcHd.Text )=''   then   begin   //3:�ж�ú��ú����
         messagebox(self.Handle,'����ú���ȣ�  ','ϵͳ��ʾ',mb_iconerror+mb_ok);
         exit;
     end else begin
         FinGzm.S_Agv_mch:=Public_Basic.StrToDouble_lu(self.EditMcHd.Text);
     end;

     if Trim(self.EditzKcgd.Text )=''   then   begin   //4:�жϿ��ɸ߶�
         messagebox(self.Handle,'���鿪�ɸ߶ȣ�  ','ϵͳ��ʾ',mb_iconerror+mb_ok);
         exit;
     end else begin
         FinGzm.S_Cg_h:=Public_Basic.StrToDouble_lu(self.EditzKcgd.text);
     end;
     //�жϿ��ɸ߶�֮����߼���ϵ
      if FinGzm.S_Cg_h > FinGzm.S_Agv_mch +2 then  begin
         if Application.MessageBox(Pwidechar('��ȷ�Ͽ��ɸ߶���ú���ȵ���ֵô��'), '������ʾ', MB_YESNO + MB_DEFBUTTON1
                       + MB_ICONQUESTION) = IDNO then   begin
            self.EditSh1.SetFocus;
            exit;
         end;
      end;

    if Trim(self.ComboCmFa.Text )=''   then   begin   //5:�жϲ�ú����
         messagebox(self.Handle,'�����ú������  ','ϵͳ��ʾ',mb_iconerror+mb_ok);
         exit;
     end else begin
        FinGzm.S_CMFS_INteger :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboCmFa.Text),1));
     end;

     if Trim(self.EditSh1.text )=''   then   begin   //6:�ж��ϱ߽����
         messagebox(self.Handle,'�����ϱ߽���','ϵͳ��ʾ',mb_iconerror+mb_ok);
         exit;
     end else begin
         FinGzm.S_Sh_UP:=Public_Basic.StrToDouble_lu(self.Editsh1.Text);
     end;

     if Trim(self.EditSh2.text )=''   then   begin   //7:�ж��±߽����
         messagebox(self.Handle,'�����±߽��� ','ϵͳ��ʾ',mb_iconerror+mb_ok);
         exit;
     end else begin
         FinGzm.S_Sh_Down:=Public_Basic.StrToDouble_lu(self.Editsh2.Text);
     end;

      if Trim(self.EditGc.text )=''   then   begin   //8:�ж�ƽ������
         messagebox(self.Handle,'����ƽ����� ','ϵͳ��ʾ',mb_iconerror+mb_ok);
         exit;
     end else begin
         FinGzm.S_mcsd_h:=Public_Basic.StrToDouble_lu(self.EditGc.Text);
     end;
        //�жϲ���֮����߼���ϵ
      if FinGzm.S_mcsd_h < FinGzm.S_Sh_UP then  begin
         if Application.MessageBox(Pwidechar('�Ͻ�������ƽ�����'), '������ʾ', MB_YESNO + MB_DEFBUTTON1
                       + MB_ICONQUESTION) = IDNO then   begin
            self.EditSh1.SetFocus;
            exit;
         end;

      end;
      if FinGzm.S_mcsd_h > FinGzm.S_Sh_Down then  begin
         if Application.MessageBox(Pwidechar('�½����С��ƽ�����'), '������ʾ', MB_YESNO + MB_DEFBUTTON1
                       + MB_ICONQUESTION) = IDNO then   begin
            self.EditSh1.SetFocus;
            exit;
         end;

      end;

     if Trim(self.EditZxc.text )=''   then   begin   //9:�ж�����
          messagebox(self.Handle,'�������򳤣�','ϵͳ��ʾ',mb_iconerror+mb_ok);
         exit;
     end else begin
         FinGzm.S_Sx_zx :=Public_Basic.StrToDouble_lu(self.EditZxc.Text);
     end;

     if Trim(self.EditQxc.text )=''   then   begin   //10:�ж�����
          messagebox(self.Handle,'�������򳤣� ','ϵͳ��ʾ',mb_iconerror+mb_ok);
          exit;
     end else begin
         FinGzm.S_L_qx:=Public_Basic.StrToDouble_lu(self.EditQxc.Text);
     end;

     if FinGzm.S_Sx_zx < FinGzm.S_L_qx then  begin
         if Application.MessageBox(Pwidechar('��ȷ�Ϲ�������������������ô��'), '������ʾ', MB_YESNO + MB_DEFBUTTON1
                       + MB_ICONQUESTION) = IDNO then   begin
            self.EditSh1.SetFocus;
            exit;
         end;

     end;

     if Trim(self.Editqj2.text )=''   then   begin   //11:�ж��������
          messagebox(self.Handle,'����������ǣ� ','ϵͳ��ʾ',mb_iconerror+mb_ok);
          exit;
     end else begin
         FinGzm.S_SX_qj  :=Public_Basic.StrToDouble_lu(self.Editqj2.Text);
     end;

     if FinGzm.S_SX_qj > 45  then  begin
         if Application.MessageBox(Pwidechar('��ȷ�Ϲ������������ô��'), '������ʾ', MB_YESNO + MB_DEFBUTTON1
                       + MB_ICONQUESTION) = IDNO then   begin
            self.EditSh1.SetFocus;
            exit;
         end;

     end;


     if Trim(self.Editqj1 .text )=''   then   begin   //12:�ж��������
          messagebox(self.Handle,'����������ǣ� ','ϵͳ��ʾ',mb_iconerror+mb_ok);
          exit;
     end else begin
         FinGzm.S_qj:=Public_Basic.StrToDouble_lu(self.Editqj1.text);
     end;

     if FinGzm.S_SX_qj > 30  then  begin
         if Application.MessageBox(Pwidechar('��ȷ�Ϲ������������ô��'), '������ʾ', MB_YESNO + MB_DEFBUTTON1
                       + MB_ICONQUESTION) = IDNO then   begin
            self.EditSh1.SetFocus;
            exit;
         end;

     end;


     if Trim(self.EditSpeed.text )=''   then   begin   //13:�ж��ƽ��ٶ�
          messagebox(self.Handle,' �����ƽ��ٶȣ�','ϵͳ��ʾ',mb_iconerror+mb_ok);
          exit;
     end else begin
         FinGzm.S_DayStep_speed:=Public_Basic.StrToDouble_lu(self.EditSpeed.text);
     end;

      if FinGzm.S_DayStep_speed > 30  then  begin
         if Application.MessageBox(Pwidechar('��ȷ�Ϲ�����ÿ����ƽ��ٶ�ô��'), '������ʾ', MB_YESNO + MB_DEFBUTTON1
                       + MB_ICONQUESTION) = IDNO then   begin
            self.EditSh1.SetFocus;
            exit;
         end;

     end;


     FinGzm.KuangJingId :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboKName.Text),1));  // 17:�������

     FinGzm.S_Mtyd :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboMKy.text),1));  // 18:ú��Ӳ��
     FinGzm.DZ_Zhqk :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.Combozhqk.Text),1));  // 19:֧�����

         if FinGzm.DZ_Zhqk=1 then begin
               FinGzm.SupportName :='����֧��';
         end else begin
               FinGzm.SupportName :=Trim(self.ComboZJType.text);  // 20:֧���ͺ�
         end;



       FinGzm.Dz_yxfx  :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboYxFx.Text),1));  // 21:��б��б

       FinGzm.Dz_JYHD :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboJYhd.Text),1));  // 22: ���Һ��
       FinGzm.Dz_DCGZ:=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboDzgz.Text),1));  // 23:���ʹ���

       FinGzm.Dz_WSFC :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboWs.Text),1));  // 24: ��˹����
       FinGzm.Dz_TopWater  :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboTopWater.Text),1));  // 25:����ˮԴ

       FinGzm.Dz_BottomWater  :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboBottomWater.Text),1));  // 26:  �װ�ˮԴ
       FinGzm.Dz_HeoStress  :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboStress.Text),1));  // 27:ˮƽӦ��

       FinGzm.Dz_Kyxx:=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboKsyl.Text),1));  // 28:��ѹ����
       FinGzm.Dz_HangDaoSup  :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboHdzh.Text),1));  // 29: ���֧��

    //
   if  (self.FcRadioButton.ItemIndex=0) then   begin
       kczt:=1;
       if (self.EditJueJin.Text='')  then begin
          messagebox(self.Handle,'�������ۼƽ��ߣ� ','ϵͳ��ʾ',mb_iconerror+mb_ok);
          exit ;
       end else begin
          kccd:=Public_Basic.StrToInt_lu(EditJueJin.Text);
       end;

   end  else begin
       kczt:=0; kccd:=0;
   end;

  if Trunc(StrTofloat(trim(self.EditSh1.Text)))<100 then
      if Application.MessageBox(Pwidechar('�Ͻ����С��100m�Ƿ�ȷ��¼�룿'), '��ʾ', MB_YESNO + MB_DEFBUTTON1
                       + MB_ICONQUESTION) = IDNO then   begin
           self.EditSh1.SetFocus;
           exit;
      end else begin
          FinGzm.S_Sh_UP:= Public_Basic.StrToDouble_lu(self.EditSh1.Text);
      end;

  if Trunc(StrTofloat(trim(self.EditSh2.Text)))<100 then
           if Application.MessageBox(Pwidechar('�½����С��100m�Ƿ�ȷ��¼�룿'), '��ʾ', MB_YESNO + MB_DEFBUTTON1
                           + MB_ICONQUESTION) = IDNO then   begin
               self.EditSh2.SetFocus;
               exit;
            end else begin
               FinGzm.S_Sh_Down:= Public_Basic.StrToDouble_lu(self.EditSh2.Text);
            end;

  if Trunc(StrTofloat(trim(self.EditGc.Text)))<100 then
      if Application.MessageBox(Pwidechar('ƽ������С��100m�Ƿ�ȷ��¼�룿'), '��ʾ', MB_YESNO + MB_DEFBUTTON1
                      + MB_ICONQUESTION) = IDNO then  begin
           self.EditGc.SetFocus;
           exit;
      end else begin
           FinGzm.S_mcsd_h:= Public_Basic.StrToDouble_lu(self.EditGc.Text);
      end;


  if Trunc(StrTofloat(trim(self.Editzxc.Text)))<100 then
     if Application.MessageBox(Pwidechar('���򳤶�С��100m�Ƿ�ȷ��¼�룿'), '��ʾ', MB_YESNO + MB_DEFBUTTON1
                      + MB_ICONQUESTION) = IDNO then  begin
           self.Editzxc.SetFocus;
           exit;
      end else begin
           FinGzm.S_Sx_zx:= Public_Basic.StrToDouble_lu(self.Editzxc.Text);
      end;


    //

      if self.SupStartNumber.Text=''    then  begin
         messagebox(self.Handle,'������֧�ܿ�ʼ��� �� ','ϵͳ��ʾ',mb_iconerror+mb_ok);
         exit;
       end else begin
           FinGzm.SupStartNumber :=Public_Basic.StrToInt_lu(self.SupStartNumber.Text);  //30����ʼ���
       end;

      if self.SupEndNumber.Text='' then   begin
         messagebox(self.Handle,'������֧����ֹ��� �� ','ϵͳ��ʾ',mb_iconerror+mb_ok);
         exit;
       end else begin
          FinGzm.SupEndNumber := Public_Basic.StrToInt_lu(self.SupEndNumber.Text);    //31;�������
       end;

       if self.ComboSupNumberDirection.Text='' then    begin
         messagebox(self.Handle,'��ѡ��֧�ܿ�ʼ���� �� ','ϵͳ��ʾ',mb_iconerror+mb_ok);
         exit;
       end else begin
         FinGzm.SupNumberDirection :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.ComboSupNumberDirection.Text),1));
       end;


       if self.cboQyzt.Text='' then   begin
         messagebox(self.Handle,'��ѡ������״̬ �� ','ϵͳ��ʾ',mb_iconerror+mb_ok);
         exit;
       end else begin
         FinGzm.used :=Public_Basic.StrToInt_lu(LeftStr(Trim(self.cboQyzt.Text),1))-1;
       end;


     Result:=true;

 end;
procedure TZkGzmForm.FormActivate(Sender: TObject);
begin
   PubLic_Basic.InitStatusBar(self.StatusBar1);
   
end;

procedure TZkGzmForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    FinGzm.Free ;

end;

procedure TZkGzmForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if Assigned(innGzmForm) then FreeAndNil(innGzmForm);
end;

procedure TZkGzmForm.FormCreate(Sender: TObject);
begin
    MySqlDataSet1:=TMyDataSet.Create(nil);
    MySqlDataSet1.MySqlConnection :=MainDataModule.ExConn;
    MySqlDataSet2:=TMyDataSet.Create(nil);
    MySqlDataSet2.MySqlConnection :=MainDataModule.ExConn;
    MyCommand1:=TMyCommand.Create (nil);
    MyCommand1.MySqlConnection :=MainDataModule.ExConn;

    FinGzm:=TGzm.Create(MainDataModule.ExConn);

    ClearEdit ;
    SetCellHead;
    SetEnable(false);
    ComboCmFa.Enabled :=TRUE;
    self.ComboKName.Enabled:=true;

    self.CkCkq.Enabled:=false;//2016-6-12
    self.CkDc.Enabled:=false;//2016-6-12
    self.CkMz.Enabled:=false;//2016-6-12

    CreatTable.Enabled:=false; //2016-7-4
    btnBf.Enabled:=false;//2016-7-4
    btnHf.Enabled:=false;//2016-7-4
end;
procedure TZkGzmForm.FormDestroy(Sender: TObject);
begin
    FreeAndNil(MySqlDataSet1);
    FreeAndNil(MySqlDataSet2);
    FreeAndNil(MyCommand1);
    if Assigned(FinGzm) then FreeAndNil(FinGzm);

    //
    if Assigned(EXUsedCqk) then  FreeAndNil(EXUsedCqk);
    if Assigned(ExUsedMz) then  FreeAndNil(ExUsedMz);
    if Assigned(ExUsedDc) then  FreeAndNil(ExUsedDc);
end;

procedure TZkGzmForm.FormShow(Sender: TObject);
begin
  IniForm ;
  FillCell(0);
end;

procedure TZkGzmForm.AddButtonClick(Sender: TObject);
begin

    self.EditCqName.Enabled:=true;
    SetEnable(true);
    FinGzm.Gzmbh :=0;

    //���ư�ť
    self.SaveButton.Enabled :=true;
    self.EditButton.Enabled :=false;

    Save_Lx:='Insert';
    self.ClearEdit;


    self.CkCkq.Enabled:=false; //2016-6-12
    self.CkDc.Enabled:=false;//2016-6-12
    self.CkMz.Enabled:=false;//2016-6-12
   // self.ComboZJType.Enabled:=true;//2016-6-15
    cboQyzt.Enabled :=false;   //2016-6-28
    CreatTable.Enabled:=false; //2016-7-4
    btnBf.Enabled:=false;//2016-7-4
    btnHf.Enabled:=false;//2016-7-4
    But_EditFileName.Enabled :=False;

    OptionTip('���ڽ��С����ӡ�����!');
end;

procedure TZkGzmForm.ComboCmFaChange(Sender: TObject);
begin
   if (self.ComboCmFa.ItemIndex=0 )or (self.ComboCmFa.ItemIndex=1 )then  begin
      self.Combozhqk.ItemIndex:=0;
   end else begin
      self.Combozhqk.ItemIndex:=1;
   end;

end;

procedure TZkGzmForm.ComboKNameChange(Sender: TObject);
var
   s_temp:Str_DT_array;
  C1:integer;
  C1LS:integer;
begin
    s_temp:=Public_Basic.split(self.ComboKName.Text,'_',C1);
    if s_temp[0]='' then exit;
    i_kid:=strToInt(s_temp[0]);
       ComboMcId.Items.Clear;

    Fill_MCBh_Combo;
    FillCell(i_kid) ;
end;




procedure TZkGzmForm.ComboMcIdClick(Sender: TObject);
begin
    ComboMcId.SetFocus;
end;

procedure TZkGzmForm.CombozhqkChange(Sender: TObject);
begin
    if Public_Basic.StrToInt_lu(LeftStr(Trim(self.Combozhqk.Text),1)) =1 then  begin
       self.ComboZJType.Enabled:=false;
    end else begin
       self.ComboZJType.Enabled:=true;
    end;   
end;

procedure TZkGzmForm.ComboZkChange(Sender: TObject);
var
  C1LS:integer;
  mcId:string;
  mcName:string;
  str_sql:String;
begin



end;

procedure TZkGzmForm.CreatTableClick(Sender: TObject);
var
  t_sql,wStr:String;
  TableName:String;
  FalOrTrue:boolean;
  i:integer;
begin
      //  �������ݿ��Ƿ�������ݱ�
        FalOrTrue:=False;
        MySqlDataSet1.Close ;
        MySqlDataSet1. CommandText:='SELECT  TABLE_NAME FROM INFORMATION_SCHEMA.TABLES ';
        MySqlDataSet1.Open ;
       while not MySqlDataSet1.eof    do  begin
          TableName:=MySqlDataSet1.FieldByName('TABLE_NAME').AsString;
          if UpperCase(Trim(TableName))=UpperCase('D_'+inttostr(FinGzm.Gzmbh)+'_BasicData') then  begin
             FalOrTrue:=true;
             break;
          end;
          MySqlDataSet1.Next ;
       end;
       MySqlDataSet1.Close ;
        if FalOrTrue then  begin
           wStr:='����������ݱ��Ѿ����ڣ���Ҫ�ظ�����ô��';
           if MessageBox(0, Pwidechar(wstr),'��ʾ',MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDNO then exit;
        end;

       if MainDataModule.CreateMySqlTable('2',inttostr(FinGzm.Gzmbh),'') then begin
                messagebox(self.Handle,'������ݱ������ɹ���','ϵͳ��ʾ',mb_iconerror+mb_ok);
       end else begin
                messagebox(self.Handle,'������ݱ�����ʧ�ܣ�','ϵͳ��ʾ',mb_iconerror+mb_ok);
                exit;
       end;

         for I := FinGzm.SupStartNumber to FinGzm.SupEndNumber do
           if (MainDataModule.GetExDataType= 'SQLSERVER') or(MainDataModule.GetExDataType= 'SQL SERVER') then  begin
               MainDataModule.CreateSerVerTable('3',inttostr(FinGzm.Gzmbh),intToStr(i));
           end else if (MainDataModule.GetExDataType= 'MYSQL') or (MainDataModule.GetExDataType= 'MY SQL') then  begin
               MainDataModule.CreateMySqlTable('3',inttostr(FinGzm.Gzmbh),intToStr(i));
           end;


      t_sql:='update  cqcsb  set qyzt =1 where cqid='+IntToStr(FinGzm.Gzmbh)+'';
      MyCommand1.CommandText :=t_sql;
      MyCommand1.Execute ;

      CreatTable.Enabled:=false; //2016-7-5
      btnBf.Enabled:=true;//2016-7-5
      btnHf.Enabled:=false;//2016-7-5
      cboQyzt.ItemIndex:=1;
      self.FillCell(i_kid) ;
end;

procedure TZkGzmForm.DeleteButtonClick(Sender: TObject);
 Var
   t_s:String;
   t_sql,t_sql1:String;

   sql:string;
   lsz,lsz1,lsz2:string;
   sltb1,sltb2: TSQLIteTable;
   lsz3:integer;

begin
    t_s:='��ȷ��Ҫɾ����'+self.EditCqName.Text+'��������ô?';
    if Application.MessageBox(Pwidechar(t_s),'��ʾ',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;
    if FinGzm.Gzmbh  <1 then  exit;
    MyCommand1.MySqlConnection.BeginTrans ;
  try
    try
      t_sql:='delete from  cqcsb  where cqid='+IntToStr(FinGzm.Gzmbh);
      MyCommand1.CommandText :=t_sql;
      MyCommand1.Execute(MainDataModule.ExUserName)  ;

      t_sql1:= 'delete from ckq_mineoutarea where gzmid = '+inttostr(FinGzm.Gzmbh)+'';
      MyCommand1.CommandText :=t_sql1;
      MyCommand1.Execute ;

      t_sql1:= 'delete from dc_fault where gzmid = '+inttostr(FinGzm.Gzmbh)+'';
      MyCommand1.CommandText :=t_sql1;
      MyCommand1.Execute ;

      t_sql1:= 'delete from mz_coalpillar where gzmid = '+inttostr(FinGzm.Gzmbh)+'';
      MyCommand1.CommandText :=t_sql1;
      MyCommand1.Execute ;
      //
       sql:='SELECT * from CreateTable where CreatLeg in (2,3) and used = 1';
       sltb1:= MainDataModule.Maindb.GetTable(sql);
        while not sltb1.Eof do    begin
            lsz2:=sltb1.FieldByName['CreateTableName'];
            lsz3:=strtoint(sltb1.FieldByName['CreatLeg']);
            if lsz3 = 2 then begin
               lsz:='c:/basicdata/d_'+inttostr(FinGzm.Gzmbh)+'_'+lsz2+'.txt';
               lsz1:='d_'+inttostr(FinGzm.Gzmbh)+'_'+lsz2+'';
            end else begin
               lsz:='c:/basicdata/d_'+inttostr(FinGzm.Gzmbh)+'_'+lsz2+'.txt';
               lsz1:='d_'+inttostr(FinGzm.Gzmbh)+'_'+lsz2+'';
            end;

            if  DeleteFile(lsz) = false then begin
                MainDataModule.DropIsExsitTable(lsz1) ;

            end;
            sltb1.Next;
        end;
    finally
      MyCommand1.MySqlConnection.CommitTrans;
      OptionTip('����ɾ���ɹ�!');
    end;
  except
       MyCommand1.MySqlConnection.RollbackTrans ;
       OptionTip('���ݲ�������!');
       exit;
  end;
      //////////////


    //���Cell
    self.FillCell(i_kid) ;
    //���ư�ť
    self.DeleteButton.Enabled :=false;
    self.AddButton.Enabled :=true;
    self.EditButton.Enabled:=false;//2016-6-15
    self.SaveButton.Enabled:=false;//2016-6-15
    // ����¼���
    self.EditCqName.Text:='';
    self.EditCqName.Enabled:=false;
    FinGzm.Gzmbh:=0;

   

end;

procedure TZkGzmForm.EditButtonClick(Sender: TObject);
begin
   //���ư�ť
   self.EditButton.Enabled :=false;
   self.SaveButton.Enabled :=true;
   self.AddButton.Enabled:=false;
   SetEnable(true);
   //����¼���     
   Save_Lx:='Update'; //  ����ʱ���������ͣ��������޸�   �޸�
    OptionTip('���ڽ��С��޸ġ�����!');
end;

procedure TZkGzmForm.EditCqNameClick(Sender: TObject);
begin
    EditCqName.SetFocus;
end;

procedure TZkGzmForm.EditDownMzKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.EditGcClick(Sender: TObject);
begin
       EditGc.SetFocus ;
end;

procedure TZkGzmForm.EditGcKeyPress(Sender: TObject; var Key: Char);
begin
      if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.EditJueJinClick(Sender: TObject);
begin
      EditJueJin.SetFocus ;
end;

procedure TZkGzmForm.EditJueJinKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9','.',#8]) then begin
    key:=#0;
    exit;
  end else begin
    if Public_Basic.StrtoDouble_lu(self.EditJueJin.Text+key) >
             Public_Basic.StrtoDouble_lu(self.EditZxc.Text) then   begin
      messagebox(self.Handle,'�ۼƽ��ߴ����ƽ����ȣ�','ϵͳ��ʾ',mb_iconerror+mb_ok);
      key:=#0;
      exit;
    end;
  end;

end;

procedure TZkGzmForm.EditMcHdClick(Sender: TObject);
begin
     EditMcHd.SetFocus;
end;

procedure TZkGzmForm.EditMcHdKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.Editqj1Click(Sender: TObject);
begin
    Editqj1.SetFocus;
end;

procedure TZkGzmForm.Editqj1KeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.Editqj2Click(Sender: TObject);
begin
       Editqj2.SetFocus;
end;

procedure TZkGzmForm.Editqj2KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.EditQxcClick(Sender: TObject);
begin
    EditQxc.SetFocus;
end;

procedure TZkGzmForm.EditQxcKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.EditSh1Click(Sender: TObject);
begin
      EditSh1.SetFocus ;
end;

procedure TZkGzmForm.EditSh1KeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9','.',#8]) then key:=#0 
end;

procedure TZkGzmForm.EditSh1MouseEnter(Sender: TObject);
begin
//
end;

procedure TZkGzmForm.Editsh2Click(Sender: TObject);
begin
         Editsh2.SetFocus ;
end;

procedure TZkGzmForm.Editsh2KeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.EditSpeedClick(Sender: TObject);
begin
        EditSpeed.SetFocus;
end;

procedure TZkGzmForm.EditSpeedKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.EditUPMzKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.EditzKcgdClick(Sender: TObject);
begin
    EditZkcgd.SetFocus ;
end;

procedure TZkGzmForm.EditzKcgdKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.EditZxcClick(Sender: TObject);
begin
          EditZxc.SetFocus ;
end;

procedure TZkGzmForm.EditZxcKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9','.',#8]) then key:=#0
end;



procedure TZkGzmForm.ExitButtonClick(Sender: TObject);
begin
  self.Close ;

end;
procedure TZkGzmForm.SaveButtonClick(Sender: TObject);
 var
  t_sql:String;
  Sfkc:string;//�Ƿ񿪲�
  TempGzmid:integer;
  lsz,lsz1,lsz2:string;

begin
   //¼�����ݼ��
   if self.checkInputEdit=false  then   exit;

   if Save_Lx='Insert'  then   begin
      t_sql:='insert into cqcsb (kid,cqname,mcid,sh1,sh2,gc,zxc,qxc,zxqj,qxqj,mch,kch,cmfa,mtyd,speed,yxfx,zjxh,dcgz,jyhd,zhqk,wsfc,' +
              ' topwater,bottomwater,heostress,kyxx,hangdaosup,kuangjingbianhao,' +
              ' kczt,kccd,SupStartNumber,SupEndNumber,SupNumberDirection,qyzt)' +
              ' values ('+IntToStr(FinGzm.KuangJingId)+ ',''' + FinGzm.S_Name+ ''',' +
               FinGzm.S_mc_name+ ','+FloatToStr(FinGzm.S_Sh_UP)+ ','+FloatToStr(FinGzm.S_Sh_Down )+
              ','+FloatToStr(FinGzm.S_mcsd_h )+ ','+ FloatToStr(FinGzm.S_Sx_zx )+ ','+FloatToStr(FinGzm.S_L_qx )+
              ','+FloatToStr(FinGzm.S_SX_qj )+ ','+ FloatToStr(FinGzm.S_qj )+ ','+FloatToStr(FinGzm.S_Agv_mch  )+
              ','+FloatToStr(FinGzm.S_Cg_h  )+ ','+ IntToStr(FinGzm.S_CMFS_Integer )+','+IntToStr(FinGzm.S_Mtyd   )+
              ','+FloatToStr(FinGzm.S_DayStep_speed )+ ','+ IntToStr(FinGzm.Dz_yxfx  )+ ','''+FinGzm.SupportName +''','+
                  IntToStr(FinGzm.Dz_DCGZ)+ ','+ IntToStr(FinGzm.Dz_JYHD)+ ','+IntToStr(FinGzm.DZ_Zhqk)+
              ','+IntToStr(FinGzm.Dz_WSFC)+ ','+ IntToStr(FinGzm.Dz_TopWater)+ ','+IntToStr(FinGzm.Dz_BottomWater)+
              ','+IntToStr(FinGzm.Dz_HeoStress)+ ','+ IntToStr(FinGzm.Dz_Kyxx)+ ','+IntToStr(FinGzm.Dz_HangDaoSup)+
              ','+inttoStr(i_kid)+','+intToStr(kczt)+','+IntToStr(kccd) +',' + IntToStr(FinGzm.SupStartNumber)+','+
              IntToStr(FinGzm.SupEndNumber)+','+IntToStr(FinGzm.SupNumberDirection)+','+IntToStr(FinGzm.used)+')';
   end else if Save_Lx='Update' then    begin
       t_sql:='update  cqcsb  set kid = '+IntToStr(FinGzm.KuangJingId)+ ',cqname=''' + FinGzm.S_Name+
             ''',mcid=' +  FinGzm.S_mc_name+ ', sh1=' + FloatToStr(FinGzm.S_Sh_UP)+
             ',sh2='+FloatToStr(FinGzm.S_Sh_Down )+ ', gc=' +FloatToStr(FinGzm.S_mcsd_h )+
             ',zxc='+FloatToStr(FinGzm.S_Sx_zx )+ ',qxc='+ FloatToStr(FinGzm.S_L_qx )+
             ',zxqj='+FloatToStr(FinGzm.S_SX_qj )+',qxqj=' + FloatToStr(FinGzm.S_qj )+
             ',mch=' +FloatToStr(FinGzm.S_Agv_mch  )+',kch='+ FloatToStr(FinGzm.S_Cg_h  )+
             ',cmfa='+ IntToStr(FinGzm.S_CMFS_Integer)+',mtyd='+IntToStr(FinGzm.S_Mtyd   )+
             ',speed='+ FloatToStr(FinGzm.S_DayStep_speed )+',yxfx='+IntToStr(FinGzm.Dz_yxfx   )+
             ',zjxh='''+ FinGzm.SupportName+''',dcgz='+IntToStr(FinGzm.Dz_DCGZ )+
             ',jyhd='+ IntToStr(FinGzm.Dz_JYHD  )+',zhqk='+IntToStr(FinGzm.DZ_Zhqk    )+
             ',wsfc='+ IntToStr(FinGzm.Dz_WSFC)+',topwater='+IntToStr(FinGzm.Dz_TopWater )+
             ',bottomwater='+ IntToStr(FinGzm.Dz_BottomWater )+',heostress='+IntToStr(FinGzm.Dz_HeoStress)+
             ',kyxx='+ IntToStr(FinGzm.Dz_Kyxx  )+',hangdaosup='+IntToStr(FinGzm.Dz_HangDaoSup )+
             ',kczt='+inttostr(kczt)+',kccd='+IntToStr(kccd)+',SupStartNumber = '+IntToStr(FinGzm.SupStartNumber)+' '
            +',SupEndNumber = '+IntToStr(FinGzm.SupEndNumber)+',SupNumberDirection = '+IntToStr(FinGzm.SupNumberDirection)+
            ' where cqid='+IntToStr(FinGzm.Gzmbh);
   end ;

   try
      MyCommand1.CommandText :=t_sql;
      MyCommand1.Execute(MainDataModule.ExUserName)  ;
      //
      SaveSupportInfo(FinGzm.SupportName);

   except
      OptionTip('����ϸ�������!');
      exit;
   end;
    SetEnable(false);
    self.FillCell(i_kid) ;
    //���ư�ť
    self.SaveButton.Enabled :=false;
    self.AddButton.Enabled :=true;
    self.EditCqName.Enabled:=false;
    self.DeleteButton.Enabled:=false;
    //��ʾ��Ϣ
     OptionTip('���ݴ洢�ɹ�!');

     FinGzm.Gzmbh  :=0;
     Save_Lx:=''; //

     CreatTable.Enabled:=false; //2016-7-5
     btnBf.Enabled:=false;//2016-7-5
     btnHf.Enabled:=false;//2016-7-5


end;

procedure TZkGzmForm.SaveSupportInfo(SupportName: String);

begin
     try
        FinGzm.BuilledSupportNumber:=1;

        Setlength(FinGzm.BuilledSupportType,1);
        FinGzm.BuilledSupportType[0]:=TWorkFaceBuillSupport.Create;
        FinGzm.BuilledSupportType[0].Supportid:=FinGzm.isExistSupportName (SupportName);
        if FinGzm.BuilledSupportType[0].Supportid< 0 then  exit;
        FinGzm.BuilledSupportType[0].startsupportNo := FinGzm.SupStartNumber ;
        FinGzm.BuilledSupportType[0].endsupportNo :=FinGzm.SupEndNumber;

      FinGzm.InsertWorkfaceSelectSupportDataBase(FinGzm.Gzmbh );
     finally
        FreeAndNil(FinGzm.BuilledSupportType[0]);
        FinGzm.BuilledSupportNumber:=1;
     end;

end;

procedure TZkGzmForm.SetCellHead;
 var
   i,j :integer;
 begin
     for i := 1 to  StringGrid1.RowCount - 1 do
          StringGrid1.Rows[i].Clear ;
    //���� �ֺ�
     StringGrid1.Canvas.Font.Size :=8;

     self.StringGrid1.ColCount :=40;
     self.StringGrid1.RowCount :=20;
     self.StringGrid1.Cells [1,0]:='��������';
     self.StringGrid1.Cells [2,0]:='�������';
     self.StringGrid1.Cells [3,0]:='��������';
     self.StringGrid1.Cells [4,0]:='ú����';
     self.StringGrid1.Cells [5,0]:='�Ͻ����';
     self.StringGrid1.Cells [6,0]:='�½����';
     self.StringGrid1.Cells [7,0]:='ƽ�����';
     self.StringGrid1.Cells [8,0]:='���򳤶�';
     self.StringGrid1.Cells [9,0]:='���򳤶�';
     self.StringGrid1.Cells [10,0]:='�������';

     self.StringGrid1.Cells [11,0]:='�������';
     self.StringGrid1.Cells [12,0]:='ú�����';
     self.StringGrid1.Cells [13,0]:='���ɸ߶�';
     self.StringGrid1.Cells [14,0]:='��ú����';
     self.StringGrid1.Cells [15,0]:='ú��Ӳ��';
     self.StringGrid1.Cells [16,0]:='�ƽ��ٶ�';
     self.StringGrid1.Cells [17,0]:='��б��Щ';
     self.StringGrid1.Cells [18,0]:='֧���ͺ�';
     self.StringGrid1.Cells [19,0]:='�������';
     self.StringGrid1.Cells [20,0]:='���Һ��';

     self.StringGrid1.Cells [21,0]:='֧�����';
     self.StringGrid1.Cells [22,0]:='��˹����';
     self.StringGrid1.Cells [23,0]:='����ˮԴ';
     self.StringGrid1.Cells [24,0]:='�װ�ˮԴ';
     self.StringGrid1.Cells [25,0]:='ˮƽӦ��';
     self.StringGrid1.Cells [26,0]:='��ѹ����';
     self.StringGrid1.Cells [27,0]:='���֧��';
     self.StringGrid1.Cells [28,0]:='�ϱ߽�ú��';
     self.StringGrid1.Cells [29,0]:='�ϱ߽�ɿ�';
     self.StringGrid1.Cells [30,0]:='�±߽�ú��';
     self.StringGrid1.Cells [31,0]:='�±߽�ɿ�';
     self.StringGrid1.Cells [32,0]:='����״̬';
     self.StringGrid1.Cells [33,0]:='���ɳ���';

     self.StringGrid1.Cells [34,0]:='֧�ܿ�ʼ���';
     self.StringGrid1.Cells [35,0]:='֧�ܽ������';
     self.StringGrid1.Cells [36,0]:='֧������';
     self.StringGrid1.Cells [37,0]:='������״̬';
     self.StringGrid1.Cells [38,0]:='���Ź�˾���';


      self.StringGrid1.ColWidths[0]:=10;
      for I := 1 to StringGrid1.ColCount-1 do
         self.StringGrid1.ColWidths[i]:=60;

       self.StringGrid1.ColWidths[3]:=80;

 end;

procedure TZkGzmForm.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;  var CanSelect: Boolean);
 var
   s_temp:Str_DT_array;
   C1,i:integer;

   s_tempZRY:Str_DT_array;
   C1ZRY:integer;
   CqID,zkid:string;
   J:string;
   MeiCengID:Integer;
   MeiCengName:String;

begin
      if (ARow=0) or (kArow=ARow) then   exit;

       KARow:=AROW;
       ClearEdit;

      //�������λ�øı�¼��
       if length(Trim(StringGrid1.Cells[1,ARow]))>0 then  begin
          FinGzm.Gzmbh:=StrToInt(Trim(StringGrid1.Cells[1,ARow]));    //c1 �������
       end else begin
          exit;
       end;


       //����JiTuancombo
     for I := 0 to self.JiTuanCombo.Items.Count -1  do
        begin
              s_temp:=Public_Basic.split(self.JiTuanCombo.Items.Strings[i] ,'_',C1);
              if C1>1 then
                  if s_temp[0]=Trim(Trim(StringGrid1.Cells[38,ARow])) then    begin
                      self.JiTuanCombo.ItemIndex :=i;
                      break;
                  end;

        end;


     MainDataModule.MySQlFillComBox(MySqlDataSet2,ComboKName,'select * from KuangJingXinXiBiao  order by id ','id','MeiKuangMing','');


     //����combokname
     for I := 0 to self.ComboKName.Items.Count -1  do
        begin
              s_temp:=Public_Basic.split(self.ComboKName.Items.Strings[i] ,'_',C1);
              if C1>1 then
               if s_temp[0]=Trim(Trim(StringGrid1.Cells[2,ARow])) then   begin
                   self.ComboKName.ItemIndex :=i;
                   i_kid:=strToInt(s_temp[0]);
                   break;
               end;
        end;



      if length(Trim(StringGrid1.Cells[3,ARow]))>0 then
             EditCqName.Text := Trim(StringGrid1.Cells[3,ARow]);// c3:    ��������
      if length(Trim(StringGrid1.Cells[5,ARow]))>0 then
             EditSh1.Text :=Trim(StringGrid1.Cells[5,ARow]);//c5:      �ϱ߽����
      if length(Trim(StringGrid1.Cells[6,ARow]))>0 then
             EditSh2.Text :=Trim(StringGrid1.Cells[6,ARow]);//c6:      �±߽����
      if length(Trim(StringGrid1.Cells[7,ARow]))>0 then
             EditGc .Text :=Trim(StringGrid1.Cells[7,ARow]);//c7:   ƽ�����
      if length(Trim(StringGrid1.Cells[8,ARow]))>0 then
             EditZxc.Text :=Trim(StringGrid1.Cells[8,ARow]);//c8:   ���򳤶�
      if length(Trim(StringGrid1.Cells[9,ARow]))>0 then
             EditQxc.Text :=Trim(StringGrid1.Cells[9,ARow]);//c9:   ���򳤶�
      if trim(StringGrid1.Cells [10,ARow])<>'' then
             Editqj2.Text :=Trim(StringGrid1.Cells[10,ARow]);//c10:  �������

      if length(Trim(StringGrid1.Cells[11,ARow]))>0 then
            Editqj1.Text :=Trim(StringGrid1.Cells[11,ARow]);//c11:  �������
      if length(Trim(StringGrid1.Cells[12,ARow]))>0 then
            EditMcHd.Text :=Trim(StringGrid1.Cells[12,ARow]);//c12:  ú�����
      if length(Trim(StringGrid1.Cells[13,ARow]))>0 then
            EditzKcgd.Text :=Trim(StringGrid1.Cells[13,ARow]);//c13:  ���ɸ߶�
      if length(Trim(StringGrid1.Cells[14,ARow]))>0 then
            ComboCmFa.ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[14,ARow]))-1;//c14:  ��ú����
      if length(Trim(StringGrid1.Cells[15,ARow]))>0 then
            ComboMKy.ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[15,ARow]))-1;//c15:  ú��Ӳ��
      if length(Trim(StringGrid1.Cells[16,ARow]))>0 then
            EditSpeed.Text :=Trim(StringGrid1.Cells[16,ARow]);//c16: �ƽ��ٶ�
      if length(Trim(StringGrid1.Cells[17,ARow]))>0 then
            ComboYxFx.ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[17,ARow]))-1;//c17:     ��б��Щ

      if length(Trim(StringGrid1.Cells[18,ARow]))>0 then                   //C18֧���ͺ�
            ComboZJType.ItemIndex := ComboZJType.Items.IndexOf(trim(StringGrid1.Cells[18,ARow]));
      if length(Trim(StringGrid1.Cells[19,ARow]))>0 then
            ComboDzgz.ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[19,ARow]))-1;//c19:   �������
      if length(Trim(StringGrid1.Cells[20,ARow]))>0 then
            ComboJYhd .ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[20,ARow]))-1;//c20:   ���Һ��
      if length(Trim(StringGrid1.Cells[21,ARow]))>0 then  begin
            Combozhqk .ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[21,ARow]))-1;//c21:  ֧�����
            if Combozhqk .ItemIndex >0 then begin
                ComboZJType.Enabled :=true;
            end else begin
                ComboZJType.Enabled :=false;
            end;

      end;

      if length(Trim(StringGrid1.Cells[22,ARow]))>0 then
            ComboWs .ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[22,ARow]))-1;//c22:   ��˹����
      if length(Trim(StringGrid1.Cells[23,ARow]))>0 then
            ComboTopWater .ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[23,ARow]))-1;//c23:  ����ˮԴ
      if length(Trim(StringGrid1.Cells[24,ARow]))>0 then
            ComboBottomWater .ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[24,ARow]))-1;//c24:   �װ�ˮԴ
      if length(Trim(StringGrid1.Cells[25,ARow]))>0 then
            ComboStress .ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[25,ARow]))-1;//c25: ˮƽӦ��
      if length(Trim(StringGrid1.Cells[26,ARow]))>0 then
            ComboKsyl .ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[26,ARow]))-1;//c26:    ��ѹ����
      if length(Trim(StringGrid1.Cells[27,ARow]))>0 then
            ComboHdzh .ItemIndex  :=StrToInt(Trim(StringGrid1.Cells[27,ARow]))-1;//c27:    ���֧��
       if Trim(StringGrid1.Cells[32,ARow])='1' then  begin
          self.FcRadioButton.ItemIndex:=0;
          self.EditJueJin.Enabled:=true;
          self.EditJueJin.Text:= Trim(StringGrid1.Cells[33,ARow]);
       end else begin
         self.FcRadioButton.ItemIndex:=1;
           self.EditJueJin.Enabled:=false;
          self.EditJueJin.Text:= '';
       end;
        if length(Trim(StringGrid1.Cells[34,ARow]))>0 then
           SupStartNumber.Text :=Trim(StringGrid1.Cells[34,ARow]);//c34:  ֧�ܿ�ʼ
        if length(Trim(StringGrid1.Cells[35,ARow]))>0 then
           SupEndNumber.Text :=Trim(StringGrid1.Cells[35,ARow]);//c35:    ֧�ܽ���
        if length(Trim(StringGrid1.Cells[36,ARow]))>0 then
            ComBoSupNumberDirection.ItemIndex := StrToInt(Trim(StringGrid1.Cells[36,ARow]))-1;//c36:    ֧������
        if length(Trim(StringGrid1.Cells[37,ARow]))>0 then  begin
            cboQyzt.ItemIndex :=StrToInt(Trim(StringGrid1.Cells[37,ARow]));//c37:    ������״̬  2016-6-6
            gzmqyzt:=StrToInt(Trim(StringGrid1.Cells[37,ARow]));//2017-7-2
        end;
        // ���inttostr(FinGzm.cq_id)
        if  length(Trim(SupStartNumber.text))>0  then
             FinGzm.SupStartNumber :=StrToInt(SupStartNumber.text) ;
        if  length(Trim(SupEndNumber.text))>0  then
             FinGzm.SupEndNumber:= StrToInt(SupEndNumber.Text);
        {TODO��2018����  ��û�п�������� }
//        if gzmqyzt = 0 then begin
//            CreatTable.Enabled:=true;
//            btnBf.Enabled:=false;
//            btnHf.Enabled:=false;
//        end else if gzmqyzt = 1 then begin
//            CreatTable.Enabled:=false;
//            btnBf.Enabled:=true;
//            btnHf.Enabled:=false;
//        end else if gzmqyzt = 2 then  begin
//            CreatTable.Enabled:=false;
//            btnBf.Enabled:=false;
//            btnHf.Enabled:=true;
//        end;
       //////


     //���ư�ť
     self.EditButton.Enabled :=true;
     self.DeleteButton.Enabled :=true;

      Fill_MCBh_Combo;

       s_temp:=Public_Basic.split(self.ComboKName.Text,'_',C1);//  c2:�������
       if s_temp[0]='' then exit;
         i_kid:=strToInt(s_temp[0]);

        if trim(StringGrid1.Cells [1,ARow])<>'' then
        begin
           CqID:=StringGrid1.Cells [1,ARow];  //:�������
        end;

         MySqlDataSet1.close;
         MySqlDataSet1.CommandText:='select zkID from zkb where cqID='+(CqID);
         MySqlDataSet1.Open;
         while not MySqlDataSet1.Eof do
         begin
             zkId:=MySqlDataSet1.FieldByName('zkID').AsString;
             MySqlDataSet1.Next;
         end;
         //  �������ļ���������ֵ
          FinGzm.S_Name:=EditCqName.Text;
          FinGzm.Gzmbh:=public_Basic.StrToInt_lu(cqid);
          But_EditFileName.Enabled :=true;

       // ���ú����

         for I := 0 to self.ComboMcId.Items.Count -1  do
          begin
              s_temp:=Public_Basic.split(self.ComboMcId.Items.Strings[i] ,'_',C1);
              if C1>1 then
                if s_temp[0]=Trim(Trim(StringGrid1.Cells[4,ARow])) then    begin
                   self.ComboMcId.ItemIndex :=i;
                   break;
                end;
           end;


           self.CkCkq.Enabled:=true;//2016-6-12
           self.CkDc.Enabled:=true;//2016-6-12
           self.CkMz.Enabled:=true;//2016-6-12

end;


procedure TZkGzmForm.SupEndNumberChange(Sender: TObject);
begin
   SupEndNumber.SetFocus ;
end;

procedure TZkGzmForm.SupEndNumberClick(Sender: TObject);
begin
        SupEndNumber.SetFocus ;
end;

procedure TZkGzmForm.SupEndNumberKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TZkGzmForm.SupStartNumberClick(Sender: TObject);
begin
         SupStartNumber.SetFocus;
end;

procedure TZkGzmForm.SupStartNumberKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9','.',#8]) then key:=#0
end;



procedure TZkGzmForm.FcRadioButtonClick(Sender: TObject);
begin
  if self.FcRadioButton.ItemIndex =0 then begin
      self.EditJueJin.Enabled :=true;
      kczt:=1;//�ѿ���
    end else begin
      self.EditJueJin.Text:='';
      self.EditJueJin.Enabled :=false;
      kczt:=0;//δ����
    end;
end;

procedure TZkGzmForm.FillCell(id:Integer); //������
var
    t_col,t_row,i,a:integer;
    kname,jname,cqname:Ansistring;
    SQL:string;
begin
       SetCellHead;
     
      //
       if id=0 then   begin
         SQL:='select * from cqcsb ';
       end else begin
         SQL:='select * from cqcsb where kID='+inttostr(id);
       end;

       MySqlDataSet1.Close();
       MySqlDataSet1.CommandText:=Sql;
       MySqlDataSet1.Open;
       t_col:=1;t_row:=1;
       while not MySqlDataSet1.Eof  do     begin
               self.StringGrid1.Cells [1,t_row]:=MySqlDataSet1.FieldByName('cqid').AsString ;    // c1:��ȡ���
               self.StringGrid1.Cells [2,t_row]:=MySqlDataSet1.FieldByName('kid').AsString;  //  c2:�������
               self.StringGrid1.Cells [3,t_row]:=MySqlDataSet1.FieldByName('cqname').AsString;     // c3: ��������
               self.StringGrid1.Cells [4,t_row]:=MySqlDataSet1.FieldByName('mcid').AsString;    //c4:  ú����
               self.StringGrid1.Cells [5,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('sh1').AsFloat);    // c5: �Ͻ����   // c5: �Ͻ����
//
               self.StringGrid1.Cells [6,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('sh2').AsFloat);//MainCForm.ADODataSet1.FieldByName('sh2').AsString ;    //c6: �½����'
               self.StringGrid1.Cells [7,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('gc').AsFloat);//MainCForm.ADODataSet1.FieldByName('gc').AsString ;  //  c7: ƽ�����
               self.StringGrid1.Cells [8,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('zxc').AsFloat);//MainCForm.ADODataSet1.FieldByName('zxc').AsString;     // c8:���򳤶�
               self.StringGrid1.Cells [9,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('qxc').AsFloat);//MainCForm.ADODataSet1.FieldByName('qxc').AsString;    // c9:���򳤶�
               self.StringGrid1.Cells [10,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('zxqj').AsFloat);//MainCForm.ADODataSet1.FieldByName('zxqj').AsString;    // c10: �������

               self.StringGrid1.Cells [11,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('qxqj').AsFloat);//MainCForm.ADODataSet1.FieldByName('qxqj').AsString ;    // c11:  �������
               self.StringGrid1.Cells [12,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('mch').AsFloat);//MainCForm.ADODataSet1.FieldByName('mch').AsString;  //  c12: ú�����
               self.StringGrid1.Cells [13,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('kch').AsFloat);//MainCForm.ADODataSet1.FieldByName('kch').AsString;     // c13:���ɸ߶�
               self.StringGrid1.Cells [14,t_row]:=MySqlDataSet1.FieldByName('cmfa').AsString;  //  c14: ��ú����
               self.StringGrid1.Cells [15,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('mtyd').AsFloat);//MainCForm.ADODataSet1.FieldByName('mtyd').AsString;    //  c15: ú��Ӳ��

               self.StringGrid1.Cells [16,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('speed').AsFloat);//MainCForm.ADODataSet1.FieldByName('speed').AsString ;    //c16: '�ƽ��ٶ�
               self.StringGrid1.Cells [17,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('yxfx').AsFloat);//MainCForm.ADODataSet1.FieldByName('yxfx').AsString ;  //   c17:  ��б��Щ
               self.StringGrid1.Cells [18,t_row]:=MySqlDataSet1.FieldByName('zjxh').Asstring;     //  c18: ֧���ͺ�
               self.StringGrid1.Cells [19,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('dcgz').AsFloat);//MainCForm.ADODataSet1.FieldByName('dcgz').AsString;    // c19:  �������
               self.StringGrid1.Cells [20,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('jyhd').AsFloat);//MainCForm.ADODataSet1.FieldByName('jyhd').AsString;    // c20: ���Һ��

               self.StringGrid1.Cells [21,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('zhqk').AsFloat);//MainCForm.ADODataSet1.FieldByName('zhqk').AsString ;    // c21:֧�����
               self.StringGrid1.Cells [22,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('wsfc').AsFloat);//MainCForm.ADODataSet1.FieldByName('wsfc').AsString ;  // c22:  ��˹����
               self.StringGrid1.Cells [23,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('topwater').AsFloat);//MainCForm.ADODataSet1.FieldByName('topwater').AsString;     // c23:����ˮԴ
               self.StringGrid1.Cells [24,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('bottomwater').AsFloat);//MainCForm.ADODataSet1.FieldByName('bottomwater').AsString;    // c24:    �װ�ˮԴ
               self.StringGrid1.Cells [25,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('heostress').AsFloat);//MainCForm.ADODataSet1.FieldByName('heostress').AsString;    //  c25:   ˮƽӦ��

               self.StringGrid1.Cells [26,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('kyxx').AsFloat);//MainCForm.ADODataSet1.FieldByName('kyxx').AsString ;    // c26: ��ѹ����
               self.StringGrid1.Cells [27,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('hangdaosup').AsFloat);//MainCForm.ADODataSet1.FieldByName('hangdaosup').AsString ;  // c27:     ���֧��
               self.StringGrid1.Cells [28,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('upmz').AsFloat);//MainCForm.ADODataSet1.FieldByName('upmz').AsString;     // c28:  �ϱ߽�ú��
               self.StringGrid1.Cells [29,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('upkc').AsFloat);//MainCForm.ADODataSet1.FieldByName('upkc').AsString;    //   c29: �ϱ߽�ɿ�
               self.StringGrid1.Cells [30,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('downmz').AsFloat);//MainCForm.ADODataSet1.FieldByName('downmz').AsString;    //  c30:   �±߽�ú��

               self.StringGrid1.Cells [31,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('downkc').AsFloat);//MainCForm.ADODataSet1.FieldByName('downkc').AsString;    //  c31:   �±߽�ɿ�

               self.StringGrid1.Cells [32,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('kczt').AsFloat);//MainCForm.ADODataSet1.FieldByName('downkc').AsString;    //  c31:   �±߽�ɿ�
               self.StringGrid1.Cells [33,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('kccd').AsFloat);//MainCForm.ADODataSet1.FieldByName('downkc').AsString;    //  c31:   �±߽�ɿ�


               self.StringGrid1.Cells [34,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('SupStartNumber').AsFloat);  //  c34:   ֧�ܿ�ʼ
               self.StringGrid1.Cells [35,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('SupEndNumber').AsFloat);  //35֧�ܽ���
               self.StringGrid1.Cells [36,t_row]:=FormatFloat('.##',MySqlDataSet1.FieldByName('SupNumberDirection').AsFloat);  //����
               self.StringGrid1.Cells [37,t_row]:=MySqlDataSet1.FieldByName('qyzt').AsString;  //��������״̬
               MySqlDataSet2.Close ;
               MySqlDataSet2.CommandText :='select * from kuangjingxinxibiao where  id =' +self.StringGrid1.Cells [2,t_row];
               MySqlDataSet2.Open ;
               if MySqlDataSet2.RecordCount >0 then  begin
                   self.StringGrid1.Cells [38,t_row]:=MySqlDataSet2.FieldByName('JituanId').AsString;  //  ���Ź�˾���
               end else begin
                   self.StringGrid1.Cells [38,t_row]:='0';
               end;
               MySqlDataSet2.Close ;

               t_row:=t_row+1;

              if t_row>self.StringGrid1.RowCount  then    self.StringGrid1.RowCount :=t_row;

             MySqlDataSet1.Next ;
         end;
         MySqlDataSet1.Close;
   end;

end.