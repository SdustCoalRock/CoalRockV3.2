unit MainReport;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
   {���˶���ӿ�}
  UIWinFrame,UICallPstope, UIGuideMapDll,uIRockPress,RockPressReport,
  System.ImageList, Vcl.ImgList, Vcl.Menus, Vcl.StdCtrls;

type
   pUserRecord =^TUsedDataBase;
  TUsedDataBase=packed record
    UserName: string;
    UserId:String;
    Admin:Boolean;
    Coal_id:string;
    Coal_Name:String;
    Workface_id:String;
    WorkFace_Name:String;
    Drill_id:String;
    Drill_Name:String;
  end;

  TMainFrom = class(TForm)
    MainMemu: TMainMenu;
    M_HELP: TMenuItem;
    M_HELP_Version: TMenuItem;
    N1: TMenuItem;
    N12: TMenuItem;
    N4: TMenuItem;
    M_HELP_HELP1: TMenuItem;
    ImageList1: TImageList;
    StatusBar1: TStatusBar;
    N2: TMenuItem;
    word1: TMenuItem;
    Rightpanel: TPanel;
    Leftpanel: TPanel;
    Splitter1: TSplitter;
    N3: TMenuItem;
    N5: TMenuItem;
    Timer1: TTimer;
    Panel1: TPanel;
    OpenWordBut: TButton;
    Memo1: TMemo;
    RadioGroup1: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LeftpanelResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure N3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure OpenWordButClick(Sender: TObject);
  private
    { Private declarations }
    StatusCaption:string;
    pUser:pUserRecord;
    ConnectedDataBase:Boolean;// ���ݿ������Ƿ�ɹ�
    Create_Public_Modul:Boolean;
    CloseFlag:Boolean;


    UserWin:TDefine_WinFrame; {�û�DLL��}
    CallPStope:TDefine_CallPStope;
    Call_MapDll:TDefine_MapDll;
    Call_RockPress:TDefine_RockPress;
    KyFxReport:TWordReport;

    function  CreateDLLClass:Boolean;
    procedure FreeDLLClass;
    procedure RefreshUsedInformation;
    procedure SetStatusBarDisplay;
    procedure CreateSaveBmpDirectory;
    procedure OpenKYFXReoprt;

  public
    { Public declarations }
     ExMinJinDao:String;

     function ConnectDataBase:Boolean;
     function KillProgram(WindowTitle : string):Boolean;


  end;

var
  MainFrom: TMainFrom;

implementation

{$R *.dfm}

uses Lu_Public_BasicModual, UMainDataModule, UForm_ContourGraph, RockPresstool,TlHelp32 ;
{����  'LibWinFrame.dll'�� Ϊ UserWin:TWinFrame ����}
function TuseWin:TClassStateMent_WinFrame; external 'LibWinFrame.dll' ;
{����  'LibCallPstope.dll'�� Ϊ TuserCallPstope ����}
function TCallPStope:TClassStateMent_CallPStope; external 'LibCallPStope.dll' ;
{����  'LibMapDll.dll'�� Ϊ TCallMmapDll ����}
function TCallMapDll:TClassStateMent_MapDll; external 'LibMapDll.dll' ;
{����  'LibRockPress.dll'�� Ϊ TCallRockPress ����}
function TCallRockPress:TClassStateMent_RockPress; external 'LibRockPress.dll' ;


function TMainFrom.ConnectDataBase: Boolean;
var
  DataType,IP,Password,Port,User,DataBase:String;
  intPort:Integer;
begin
   Result:=False;
   if not Public_Basic.ReadDataBaseType(DataType) then exit;
   if not Public_Basic.ReadMySqlDataBase(DataType,IP,User,Password,Port,DAtaBase)  then
           exit;
   if Port<> '' then   begin
      intPort:=StrToInt(Port);
   end else begin
      intPort:=0;
   end;

   if  not Assigned(UserWin)  then exit;
   if  UserWin.ConnectDataBase(     PansiChar(AnsiString(DataType)),
                                         PansiChar(AnsiString(DataBase)),
                                         PansiChar(AnsiString(Ip)),
                                         intPort,
                                         PansiChar(AnsiString(User)),
                                         PansiChar(AnsiString(Password))
                                      ) then  begin
                 Result:=True;
                 ConnectedDataBase:=True;
    end;

end;

function TMainFrom.CreateDLLClass: Boolean;
var
  UN:PansiChar;
begin
   Result:=true;
   try
       if not Assigned(Public_Basic) then begin
          Public_Basic:=TLu_BasicClass.Create('','serverinfo.dll');
          Public_Basic.SetStatusCaption(StatusCaption);
          Public_Basic.InitStatusBar(self.StatusBar1);
       end;
       {'LibWinFrame.dll' ���ⲿ��}
       if not Assigned(UserWin) then begin
          UserWin:=TuseWin.Create ;
          UserWin.SetStatuesCaption(PansiChar(Ansistring(StatusCaption)));
       end;
//       {'LibCallPstope.dll' ���ⲿ��}
       if not Assigned(CallPStope) then  begin
           CallPStope:=TCallPstope.Create ;
           CallPStope.SetStatuesCaption(PansiChar(Ansistring(StatusCaption)));
           Public_Basic.Licensing :=CallPStope.VerFityUserName(UN);
           Public_Basic.UseUnitName :=strPas(UN);
       end;
       {LibMapDll.dll���ⲿ��  Call_MapDll}
        if not Assigned(Call_MapDll) then  begin
           Call_MapDll:=TCallMapDll.Create ;
          // Call_MapDll.SetStatuesCaption(PansiChar(Ansistring(StatusCaption)));
       end;
       {LibRockPress.dll �� �ⲿ�� Call_RockPress}
       if not Assigned(Call_RockPress) then  begin
           Call_RockPress:=TCallRockPress.Create ;
           Call_RockPress.SetStatuesCaption(PansiChar(Ansistring(StatusCaption)));
           Call_RockPress.SetPublic_BasicLicending(Public_Basic.Licensing,
                                   PansiChar(Ansistring(Public_Basic.UseUnitName))  );
       end;


       if not Assigned(MainDataModule )then    begin
          MainDataModule:=TDataModule1.Create(nil) ;
          MainDataModule.ExMainPath :=Public_Basic.Get_MyModulePath ;
          MainDataModule.ConnectSystemDataBase;
          Create_Public_Modul:=true;
       end;

       if not Assigned(KyFxReport)  then  begin
           KyFxReport:=TWordReport.Create;
           KyFxReport.SetWordPanel(LeftPanel);
       end;

       //ϵͳ��ʼ��
       RefreshUsedInformation;
       Public_Basic.InitStatusBar(self.StatusBar1);
       SetStatusBarDisplay;
       CreateSaveBmpDirectory;//������ʱ������ļ���
       
   except
       Result:=FaLse;
   end;

end;

procedure TMainFrom.CreateSaveBmpDirectory;
var
  path:Ansistring;
begin
   path:=Public_Basic.Get_MyModulePath+'SaveBMP\FYYD\';
   if not DirectoryExists(path) then begin
       ForceDirectories(path);
    end;

   path:=Public_Basic.Get_MyModulePath+'SaveBMP\KYJG\';
   if not DirectoryExists(path) then begin
       ForceDirectories(path);
    end;
   path:=Public_Basic.Get_MyModulePath+'SaveBMP\KYFX\';

   if not DirectoryExists(path) then begin
       ForceDirectories(path);
    end;

end;

procedure TMainFrom.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    public_Basic.WriteMakeWordPercent(False,0);
    KillProgram('WINWORD.EXE');
end;

procedure TMainFrom.FormCreate(Sender: TObject);
begin
   Set8087CW($133f); { Disable all fpu exceptions }

   New(PUser);
   StatusCaption:='ɽ���Ƽ���ѧ������Ժʿ�Ŷ��з� CopyRight (2004-2020)';
   LeftPanel.Align :=alLeft;
   splitter1.Align:=alLeft;

   RightPanel.Align :=alClient;


   ConnectedDataBase:=False;
   if not CreateDLLClass then      exit;

   CloseFlag:=False;


end;

procedure TMainFrom.FormDestroy(Sender: TObject);
begin
   try
      FreeDLLClass;
      Dispose(PUser);
   finally

   end;
end;

procedure TMainFrom.FormShow(Sender: TObject);
var
  Pstr:string;
begin
   Pstr:='����������ɿ�ѹ�۲ⱨ�棬������Ҫ30�������ҵ�ʱ��!���ȷ�ϣ������ť��'+
              'ϵͳ�������̨��ѹ�������,�ڿ�ѹ�������ɹ����У��벻Ҫ��word�༭�����ĵ������������Ű�������μǣ�'  ;
   Memo1.Clear ;

   // �������ݿ�
   if not  ConnectedDataBase  then
       if  ConnectDataBase then begin
            Memo1.Lines.Add(Pstr) ;
            OpenWordBut.Enabled :=true;
       end else begin
           Pstr:='���ݿ����������⣬����ͨ��������' ;
           Memo1.Lines.Add(Pstr) ;
           OpenWordBut.Enabled :=False;
       end;

end;

procedure TMainFrom.FreeDLLClass;
begin
    if  Create_Public_Modul then
      if Assigned(MainDataModule) then   FreeAndNil(MainDataModule);

    if Assigned(CallPStope) then  FreeAndNil(CallPStope);
    if Assigned(Call_MapDll) then FreeAndNil(Call_MapDll);
    if Assigned(Call_RockPress) then FreeAndNil(Call_RockPress);
    if Assigned(UserWin) then  FreeAndNil(UserWin);
    if Assigned(Public_Basic) then  FreeAndNil(Public_Basic);
    if Assigned(KyFxReport)  then   FreeAndNil(KyFxReport);
end;

function TMainFrom.KillProgram(WindowTitle: string):Boolean;
const
    PROCESS_TERMINATE = $0001;
var
    _vHandle : THandle;
    _vProEntry : TProcessEntry32;
    _vIsFound : Boolean;
    _vTempStr : string;
begin
    Result := False;
    _vHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    try
      _vProEntry.dwSize := SizeOf(_vProEntry);
      _vIsFound := Process32First(_vHandle, _vProEntry);
      while _vIsFound do     begin
          _vTempStr := _vProEntry.szExeFile;
          if (UpperCase(_vTempStr) = UpperCase(ExtractFileName(WindowTitle))) or
          (UpperCase(_vTempStr) = UpperCase(WindowTitle)) then          begin
              Result := TerminateProcess(OpenProcess(PROCESS_TERMINATE,
              Boolean(0), _vProEntry.th32ProcessID), 0);
          end;
          _vIsFound := Process32Next(_vHandle, _vProEntry);
      end;
    finally
      CloseHandle(_vHandle);
    end;

end;

procedure TMainFrom.LeftpanelResize(Sender: TObject);
begin
   if Assigned(KyFxReport) then
            KyFxReport.ReSize;
end;

procedure TMainFrom.N3Click(Sender: TObject);
begin
   OpenWordBut.Click ;
end;

procedure TMainFrom.N5Click(Sender: TObject);
begin
   KyFxReport.SetReportExit(true);
end;

procedure TMainFrom.OpenKYFXReoprt;
var
  MinD,MaxD:integer;
  s_temp:Str_DT_array;
  C1:integer;

begin
    if RadioGroup1.ItemIndex =0 then   begin //���ؽ�����ʾ��ʽ
       Hide ;
    end else begin
       self.Width :=1100;
       self.Height:=650;
       //WindowState:=wsNormal; //wsMaximized   wsMinimized
    end;


    s_temp:=Public_Basic.split(ExMinJinDao,'_',C1);
    if s_temp[0]='' then begin
       MinD:=0;
       MaxD:=0;
    end else begin
       MinD:=Public_Basic.StrToInt_lu(s_temp[0]);
       MaxD:=Public_Basic.StrToInt_lu(s_temp[1]);
    end;



    Open_innFrom(RightPanel.Handle,MinD,MaxD,1);
    if Assigned(FormPressTool) then  FormPressTool.close;
    Form_ContourGraph.But_Start_KYFX.Click ;
//
    KyFxReport.SetDrawGraph(Form_ContourGraph.DrawGzm,CallPStope);
    public_Basic.WriteMakeWordPercent(true,1);
    if KyFxReport.ReportAnsysisRockPress(RightPanel.Handle ,Form_ContourGraph.DrawGzm.FGzm,true ) then

    begin
       CloseFlag:=true;
       Timer1.Enabled :=true;
    end;


end;

procedure TMainFrom.OpenWordButClick(Sender: TObject);
var
 t_s:widestring;
begin
    t_s:='��ӡ������ͨ������ϵͳOFFICE��ʵ�����'+#13#10 +
         '����OFFICE ��ķ�һ���ʱ�䣬��ȷ��ô?';
   if Application.MessageBox(Pwidechar(t_s),'�ر���ʾ',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;
   // ��ӡ����
   OpenKYFXReoprt;
end;

procedure TMainFrom.RefreshUsedInformation;
VAr
  AdminB:String;
begin
   Public_Basic.ReadLoginInfo('UserInFormation',PUser.UserName,PUser.UserId,AdminB);
   if AdminB='1' then PUser.Admin :=true else PUser.Admin :=False;
   Public_Basic.ReadUsedMeiKuangInfo('UsedCoalInfo',PUser.Coal_id,PUser.Coal_Name,
            PUser.Workface_id,PUser.WorkFace_Name,PUser.Drill_id,PUser.Drill_Name);
   if Trim(PUser.Coal_Name)<>'' then
       StatusBar1.Panels[1].Text:='������ģ����ǡ�'+PUser.Coal_Name+'ú����_'+PUser.WorkFace_Name+'����ú������';
end;


procedure TMainFrom.SetStatusBarDisplay;
begin

    StatusBar1.Panels[0].Text:='��ӭ�㡾'+PUser.UserName+'������';
    if Trim(PUser.Coal_Name)<>'' then
       StatusBar1.Panels[1].Text:='������ģ����ǡ�'+PUser.Coal_Name+'ú����_'+PUser.WorkFace_Name+'����ú������';

    StatusBar1.Panels[2].Text:= StatusCaption  ;
end;

procedure TMainFrom.Timer1Timer(Sender: TObject);
begin
    if CloseFlag then begin
       Timer1.Enabled :=False;
       Close;
    end;

end;

end.