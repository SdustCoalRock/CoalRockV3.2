unit uBatInputRockData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.FileCtrl, Vcl.StdCtrls, StrUtils,
  UMainDataModule,UMakeRuleClass, System.ImageList, Vcl.ImgList, Vcl.ComCtrls,
  Vcl.ToolWin, Winapi.ActiveX

  ;

type

  TReadDataClass =Class(TObject)
    FileDir:String;
    Count:Integer;
    elapsedMilliseconds : cardinal;
    Items:Array of TReadRecord;
    CloseThread:Boolean;
    ProcessStep:integer;
    ExHandle:THandle;

    procedure Add(tm:TReadRecord);
    Procedure ClearItems;
    procedure SetFileName(Value:String);
    procedure SetCloseThread(Value:Boolean);

    destructor Destroy; override;
    constructor  Create;
  End;

  TReadFileData= class (TThread)

    private
       MyDataSet:TMyDataSet;
       MyCommand:TMyCommand;
       MyRule:TMakeRuleClass;
       Rule_id:integer;
       WorkFace_id:string;
       ReadClass:TReadDataClass;
       procedure FillRuleClass(id:integer);
       function ReadJinDaoBasicData: string;
       function OneButtonDisposeData:Boolean;
    public
        procedure Execute ;override;

        destructor Destroy; override;
        constructor  Create(ADOC: TMySqlConnection;Ru_id:integer;
                            Gzm_id:string;MYClass:TReadDataClass);
  end;


  TForm_BatInPutData = class(TForm)
    GB_SelectFile: TGroupBox;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Panel1: TPanel;
    GB_Select_Rule: TGroupBox;
    CB_RuleName: TComboBox;
    ToolBar1: TToolBar;
    AddButton: TToolButton;
    EditButton: TToolButton;
    SaveButton: TToolButton;
    ExitButton: TToolButton;
    ImageList2: TImageList;
    InputFileListBox: TFileListBox;
    Memo_log: TMemo;
    ProgressBar1: TProgressBar;
    Speed_Label: TLabel;
    Timer1: TTimer;
    Button2: TButton;
    Panel_GzmName: TPanel;
    ToolButton1: TToolButton;
    Label_Title: TLabel;
    RG_JD_Basic: TRadioGroup;
    GroupBox1: TGroupBox;
    Edit_JD_support: TEdit;
    Label39: TLabel;
    RG_JD_Time: TRadioGroup;
    Splitter3: TSplitter;
    But_AutoDraw: TToolButton;
    RD_CJ_Type: TRadioGroup;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CB_RuleNameClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RG_JD_BasicClick(Sender: TObject);
    procedure Edit_JD_supportClick(Sender: TObject);
    procedure Edit_JD_supportKeyPress(Sender: TObject; var Key: Char);
    procedure But_AutoDrawClick(Sender: TObject);
  private
    { Private declarations }
     MyDataSet:TMYDataSet;
     MyCommand:TMyCommand;
     MyRule:TMakeRuleClass;
     parentWid,ParentHig:Integer;
     Selected_Ruleid:integer;
     MyReadDataClass: TReadDataClass;
     S_CoalName,S_WorkFaceName:String;
     S_Coalid,S_WorkFaceid:string;
     TotalTime:Double;
     JinDaoBasicSupport:String;
     EndSupNumber:integer;
     ThreadProcessStep:integer;
     ShowScreen:integer;

     procedure FillCB_RuleName(CB_RuleName:TComboBox);
     function  SecectedRuleName(Str:String):Boolean;
     function  FillMyRuleData(id:Integer;Rule:TMakeRuleClass):Boolean;
     function  FillMyReadDataClass(Rd:TReadDataClass):Boolean;
     procedure AddLOG(log_Str:String);
     procedure RefreshTotalTime(Coun:integer;tim:double);
     function  ReadJinDaoBasicData(Rd:TReadDataClass):Boolean;
     function  SeekMyRuleJinDaoChanged:Boolean;
     function CreateSaveBmpPath:String;
     function  DelAllSaveFile(aDir:string;Gzmid:integer):Boolean;
     procedure FromSaveToBmp(pic_path:string);
     procedure SetFromWidthAndHeigth(flag:integer);

  public
    { Public declarations }
     function MakeJinDaoBasicData:Boolean;
     function MakeOtherSupportDate: Boolean;
     procedure OneButtonDisposeData;
     function GetCloseState:Integer;

  end;

var
  Form_BatInPutData: TForm_BatInPutData;
  MYReadDataThread:TReadFileData;

 function IsExsitReadThread(ClassName:String):Boolean;
 function CreateBatInputData_inn(AHandle:THandle;ACaption:string;Wid,Hi,Flag:integer):THandle;stdcall;

implementation

{$R *.dfm}

uses MakeDataRule, Lu_Public_BasicModual, StopWatch, PStope_GzmGuidClass,
  UFormModifyJinDao, UFormEditPressData, UForm_ContourGraph, RockPresstool,
  UForm_LineGraph, UForm_Brand_Bar;
 //--------------------------------
 function IsExsitReadThread(ClassName:String):Boolean;
var
    exitCode: DWord;
begin
     if ClassName='MYReadDataThread' then  begin
       if Assigned(MYReadDataThread) then
          GetExitCodeThread(MYReadDataThread.Handle, exitCode);
     end else if ClassName='Form_ContourGraph' then  begin
       if Assigned(Form_ContourGraph) then
          GetExitCodeThread(Form_ContourGraph.Handle, exitCode);
     end else if ClassName='FormPressTool' then begin
         if Assigned(FormPressTool) then
          GetExitCodeThread(FormPressTool.Handle, exitCode);

     end;

       if exitCode = STILL_ACTIVE then begin
          Result:=True;
       end else begin
          Result:=False;
       end;
 end;
//-------------------------------
function CreateBatInputData_inn(AHandle:THandle;ACaption:string;Wid,Hi,Flag:integer):THandle;stdcall;

begin
       if Assigned(Form_BatInPutData) then  FreeAndNil(Form_BatInPutData);
       Application.Handle:=AHandle;
       Form_BatInPutData:=TForm_BatInPutData.Create(Application);
        try
           with Form_BatInPutData do begin
               Caption:=ACaption;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;
                //
                 parentWid:=Wid;
                 ParentHig:=Hi;
                 //
                SetFromWidthAndHeigth(Flag);
                Result:=Form_BatInPutData.Handle ;//����ֵ
          end ;
        except
           FreeAndNil(Form_BatInPutData);
        end;
end;

procedure TForm_BatInPutData.AddButtonClick(Sender: TObject);
var
  i:integer;
begin
     for I := 0 to InputFileListBox.Count -1 do
         InputFileListBox.Selected[i]:=true;

end;

procedure TForm_BatInPutData.AddLOG(log_Str: String);
begin
    Memo_Log.Lines.Add(log_str);
end;

procedure TForm_BatInPutData.Button2Click(Sender: TObject);
begin

   Self.SaveButton.Click ;

end;

procedure TForm_BatInPutData.But_AutoDrawClick(Sender: TObject);
begin
    Create_ConTourGrap(application.Handle,'�Զ���ͼ����',0,0,1);
    FormPressTool.Close ;
    // ��ȷ���
    Form_ContourGraph.But_Start_KYFX.Click ;
    // �� ����ͼ ���ƽ���
    CreateLineGraph(application.Handle,'',0,0,0);
    Form_ContourGraph.DrawGzm.GraphClass.CycleDataEfficient:=False;//��������ͼ�д�������
    Form_LineGraph.SetOpenFormVar(Form_ContourGraph.DrawGzm,
                                  '',
                                  true, // �Ƿ��в�����Ϣ
                                  true// �Ƿ�򿪹��߲˵�
                                  );
    FormPressTool.Close ;
       // ����������ģʽ
       Form_LineGraph.Main_Line_DrawClass.GraphClass.YAxisType :=1;
       Form_LineGraph.DrawLineGraph.NextDataDisp:=0; // ��һ��
       Form_LineGraph.DrawLineGraph.MarkerStep:=true;
       Form_LineGraph.RefreshMyGraphChart(true);
       Form_LineGraph.DrawLineGraph.NextDataDisp:=1; //�ڶ���
       Form_LineGraph.RefreshMyGraphChart(true);
       Form_LineGraph.DrawLineGraph.NextDataDisp:=2; //������
       Form_LineGraph.RefreshMyGraphChart(true);
       Form_LineGraph.Close ;
    //��ֱ��ͼģʽ
     CreateBand_Bar(ExHandle,'',0,0,0);
     Form_ContourGraph.DrawGzm.BarMarks.Fromcontour:=true;;//��������ͼ�д�������
     if Assigned(Form_Band_Bar) then  begin
        Form_Band_Bar.InitForm(Form_ContourGraph.DrawGzm) ;
        Form_Band_Bar.SetOpenFormVar( '',
                                  False,
                                  true// �Ƿ�򿪹��߲˵�
                                  );

     end;

     FormPressTool.Close ;
//     while  IsExsitReadThread('FormPressTool') do
//        Sleep(100);
     Form_Band_Bar.Main_panel.Refresh;
     Form_Band_Bar.AutoSaveOnesupportOneBMP(-1) ;

     Form_Band_Bar.Close ;

    Form_ContourGraph.Close ;


end;

procedure TForm_BatInPutData.CB_RuleNameClick(Sender: TObject);
begin
   if SecectedRuleName(CB_RuleName.Text ) then  begin
       self.SaveButton.Enabled :=true;
   end else begin
      if InputFileListBox.SelCount <1 then   begin
         messagebox(self.Handle,'���ݹ�����������⣬��ͨ�����Ժ�����!','ϵͳ��ʾ',mb_iconerror+mb_ok);
         exit;
      end;
      self.SaveButton.Enabled :=False;
   end;


end;

function TForm_BatInPutData.CreateSaveBmpPath: String;
var
 BmpPath:WideString;
begin
    BmpPath:=Public_Basic.Get_MyModulePath+'SaveBmp\KYFX\';
    if  not DirectoryExists(BmpPath) then
         ForceDirectories(BmpPath);

    Result:=BmpPath;
end;

function TForm_BatInPutData.DelAllSaveFile(aDir:string;Gzmid: integer): Boolean;
var
    vSearch: TSearchRec;
    vRet: integer;
    vKey: string;
begin

    if aDir[Length(aDir)] <> '\' then
        aDir := aDir + '\';
    vKey := aDir + '*.*';
    vRet := FindFirst(vKey, faanyfile, vSearch);
    while vRet = 0 do       begin
        if ((vSearch.Attr and fadirectory) = fadirectory) then       begin
            if (vSearch.Name <> '.') and (vSearch.name <> '..') then
                DelAllSaveFile(aDir + vSearch.name,0);
            end
        else    begin
            if ((vSearch.Attr and fadirectory) <> fadirectory) then     begin
              {System.Sysutils.}DeleteFile(aDir + vSearch.name);
             end;
        end;
        vRet := FindNext(vSearch);
    end; //while

    {System.SysUtils.}FindClose(vSearch);
   //  Removedir(aDir); // �����Ҫɾ���ļ���������
    result := True;

end;

procedure TForm_BatInPutData.EditButtonClick(Sender: TObject);
var
  i:integer;
begin
     for I := 0 to InputFileListBox.Count -1 do
         InputFileListBox.Selected[i]:=False;
end;

procedure TForm_BatInPutData.Edit_JD_supportClick(Sender: TObject);
begin
   Edit_JD_support.SetFocus;
end;

procedure TForm_BatInPutData.Edit_JD_supportKeyPress(Sender: TObject;
  var Key: Char);
begin
    if not (key in ['0'..'9',#8]) then key:=#0  ;
end;

procedure TForm_BatInPutData.ExitButtonClick(Sender: TObject);
begin
    CloseQuery ;
end;

procedure TForm_BatInPutData.FillCB_RuleName(CB_RuleName: TComboBox);
var
  Sql:String;
begin
  CB_RuleName.Clear ;
  try
       sql:='select id,RuleName  from  inputRule ';
        MyDataSet.Close ;
        MyDataSet.CommandText :=sql;
        if MyDataSet.Open  then
        while not MyDataSet.Eof  do  begin
           CB_RuleName.Items.Add(MyDataSet.FieldByName('id').AsString + '_' +
                           MyDataSet.FieldByName('RuleName').AsString );
           MyDataSet.Next ;
        end;
   finally
     MyDataSet.Close ;
     if CB_RuleName.Items.Count >0 then  begin
        CB_RuleName.ItemIndex :=0;
        SaveButton.Enabled :=true;
        SecectedRuleName(CB_RuleName.Text )
     end;
   end;

end;

function TForm_BatInPutData.FillMyReadDataClass(Rd: TReadDataClass): Boolean;
var
  i:integer;
  tm: TReadRecord;
begin
   Result:=False;
   Rd.FileDir :=self.DirectoryListBox1.Directory ;
   for I := 0 to InputFileListBox.Count -1 do  begin
       if not InputFileListBox.Selected[i]  then continue;
       if InputFileListBox.Items[i]= Rd.Items[0].FileName  then  continue;
       tm.FileName:=InputFileListBox.Items[i];
       tm.elapsedMilliseconds :=0;
       tm.RecordNumber :=0;
       tm.ReadFin :=False;
       tm.printed :=False;
       tm.Processing :=0;
       Rd.Add(tm);
   end;

end;

function TForm_BatInPutData.FillMyRuleData(id: Integer;
  Rule: TMakeRuleClass): Boolean;
var
   Sql:string;
   tmp:TBasicDataParm;
begin
   {
        inputRule  RuleName,FileSufix,LineSplitStr,SupProFlag,SupUpper, ' +
          ' TimeProFlag,TimeUpper,TimeString )
        InputRule_DataType  Ruleid,DataType,DataBh,DataProFlag,DataUpper) values ( ';
   }

   try
       sql:='select * from  inputRule where id= ' +IntTostr(id);
        Rule.ClearDataS ;
        MyDataSet.Close ;
        MyDataSet.CommandText :=sql;
        if MyDataSet.Open  then  begin
           Rule.RuleId:=MyDataSet.FieldByName('id').AsInteger;
           Rule.RuleName :=MyDataSet.FieldByName('RuleName').AsString;
           Rule.FileSuffix :=MyDataSet.FieldByName('FileSufix').AsString;
           Rule.LineSplitTag :=MyDataSet.FieldByName('LineSplitStr').AsString;
           Rule.SupProRec.TagStr :=MyDataSet.FieldByName('SupProFlag').AsString;
           Rule.SupProRec.UpperCase :=MyDataSet.FieldByName('SupUpper').AsInteger;
           Rule.DTProRec.TagStr :=MyDataSet.FieldByName('TimeProFlag').AsString;
           Rule.DTProRec.UpperCase :=MyDataSet.FieldByName('TimeUpper').AsInteger;
           Rule.DataTimeStr :=MyDataSet.FieldByName('TimeString').AsString;
            if MyDataSet.FieldByName('MoveSupTag').AsInteger=1 then  begin
              Rule.MoveSuppFlag:=true;
              Rule.MoveProRec.UpperCase:=MyDataSet.FieldByName('MoveSuP_Upper').AsInteger;
              Rule.MoveSupp_Equal :=MyDataSet.FieldByName('MoveSup_Equal').AsString;
              Rule.MoveProRec.TagStr :=MyDataSet.FieldByName('MoveSup_ProFlag').AsString;
              Rule.MoveSupp_Value:=MyDataSet.FieldByName('MoveSup_Value').AsInteger;
           end else begin
              Rule.MoveSuppFlag:=False;
              Rule.MoveProRec.UpperCase:=0;
              Rule.MoveSupp_Equal :='';
              Rule.MoveProRec.TagStr :='';
              Rule.MoveSupp_Value:=0;
           end;
            Rule.MuleData_MAX_AGV:= MyDataSet.FieldByName('Mult_Max_AGV').AsInteger;
        end;
       MyDataSet.Close ;
       sql:='select * from  InputRule_DataType where Ruleid= ' +IntTostr(Rule.RuleId);
       MyDataSet.CommandText :=sql;
       if MyDataSet.Open  then
         while not MyDataSet.Eof  do  begin
           tmp.DataName :=MyDataSet.FieldByName('DataType').AsString;
           tmp.DataBh :=MyDataSet.FieldByName('DataBh').AsInteger ;
           tmp.TagStr :=MyDataSet.FieldByName('DataProFlag').AsString;
           tmp.UpperCase :=MyDataSet.FieldByName('DataUpper').AsInteger ;
           tmp.DataUnit:=MyDataSet.FieldByName('DataUnit').AsString;
           Rule.AddBasicDataS(tmp);
           MyDataSet.Next ;
         end;
   finally
     MyDataSet.Close ;
   end;

end;

procedure TForm_BatInPutData.FormActivate(Sender: TObject);
begin
  FillCB_RuleName(self.CB_RuleName );
  Label_Title.AutoSize :=False;
  Label_Title.WordWrap :=False;
  Label_Title.Caption :='��ǰ�������ǡ�'+s_CoalName+'�������ġ�'+S_WorkFaceName+'��������';
  Label_Title.WordWrap :=true;
     //�ж��빤������ص����ݱ��Ƿ񴴽������û�д������ٴ˴���
   if not MainDataModule.IsExsitTableName('D_'+S_WorkFaceid+'_BasicData') then begin
       MainDataModule.CreateTable('2',MainDataModule.DataType,S_WorkFaceid,'') ;
   end;
end;

procedure TForm_BatInPutData.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  t_s:string;
  pic_Path:string;

begin
   t_s:='���ڴ����������ݽ��治�ܹرգ�'+#13#10 +'����رգ����뽫��ֹ����ȷ��ô?';
   if  IsExsitReadThread('MYReadDataThread') then  begin
      if Application.MessageBox(Pwidechar(t_s),'��ʾ',MB_OKCANCEL+MB_ICONQUESTION) =1 then  begin
         {�����ر��̵߳�ָ��}
         MyReadDataClass.SetCloseThread(true);
         while IsExsitReadThread('MYReadDataThread') do   begin
            MYReadDataThread.Terminate;
            MyReadDataClass.SetCloseThread(true);
            sleep(500);
         end;
         ShowScreen:=0;

      end else begin
          CanClose:=False;
          exit;
      end;

   end;

     Pic_Path  :=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\OneCoal'+'_8_1.BMP';
     FromSaveToBmp(Pic_Path);
   {�رմ��壬������Ҫ����Close����}
    if Assigned(Form_BatInPutData) then  FreeAndNil(Form_BatInPutData);

end;

procedure TForm_BatInPutData.FormCreate(Sender: TObject);
begin
    if not Assigned(MyRule) then
      MyRule:=TMakeRuleClass.Create(MainDataModule.ExConn); ;

    if not Assigned(MyReadDataClass) then
      MyReadDataClass:=TReadDataClass.Create ;

   MyDataSet:=TMYDataSet.Create(nil);
   MyCommand:=TMyCommand.Create(nil);
   MyDataSet.MySqlConnection :=MainDataModule.ExConn;
   MyCommand.MySqlConnection :=MainDataModule.ExConn;
   //
    MainDataModule.ReadPublicUsedMkInfoFromFile;
    s_CoalName :=MainDataModule.Coal_Name;
    S_WorkFaceName :=MainDataModule.WorkFace_Name;
    S_Coalid:=MainDataModule.Coal_id ;
    S_WorkFaceid:=MainDataModule.WorkFace_id;
   //
    Selected_Ruleid:=-1;
     //�ж��빤������ص����ݱ��Ƿ񴴽������û�д������ٴ˴���
   if not MainDataModule.IsExsitTableName('D_'+S_WorkFaceid+'_BasicData') then begin
       MainDataModule.CreateTable('2',MainDataModule.DataType,S_WorkFaceid,'') ;
   end;


end;

procedure TForm_BatInPutData.FormDestroy(Sender: TObject);
begin
    if Assigned(MyRule) then  FreeAndNil(MyRule);
    if Assigned(MyReadDataClass) then  FreeAndNil(MyReadDataClass);

    FreeAndNil(MyDataSet);
    FreeAndNil(MyCommand);
end;



procedure TForm_BatInPutData.FormShow(Sender: TObject);
begin
     MyRule.DisPoseCycleDataS.Set_WorkFaceId(S_WorkFaceid);
     MyRule.DisPoseCycleDataS.ReadWorkFaceInforMation  ;
     RG_JD_Basic.ItemIndex :=MyRule.DisPoseCycleDataS.MyWokFace_Info.JinDao_Basic;
     Edit_JD_support.Text:=intTostr(MyRule.DisPoseCycleDataS.MyWokFace_Info.JinDao_Support);
     RG_JD_time.ItemIndex:=MyRule.DisPoseCycleDataS.MyWokFace_Info.JinDao_Time;
     RD_CJ_Type.ItemIndex:=MyRule.DisPoseCycleDataS.MyWokFace_Info.Jindao_DataType;
     EndSupNumber:= MyRule.DisPoseCycleDataS.GetFGzmEndSupNumber(S_WorkFaceid);
end;

procedure TForm_BatInPutData.FromSaveToBmp(pic_path: string);
var
    BitRect: TRect;
    Bitmap: TBitmap;
    FScreenCanvas: TCanvas;
begin
      Bitmap := TBitmap.Create;
   try
      Bitmap.SetSize(Self.ClientWidth, Self.ClientHeight);
      BitRect.Left := 0;
      BitRect.Top := 0;
      BitRect.Right := BitRect.Left + Bitmap.Width;
      BitRect.Bottom := BitRect.Top + Bitmap.Height;
      FScreenCanvas := TCanvas.Create;
      FScreenCanvas.Handle := Self.Canvas.Handle;
      Bitmap.Canvas.Lock;
      Bitmap.Canvas.CopyRect(BitRect, FScreenCanvas, Self.ClientRect);
      Bitmap.Canvas.Unlock;
      Bitmap.SaveToFile(pic_path);
   finally
     Bitmap.Free;
   end;

end;

function TForm_BatInPutData.GetCloseState: Integer;
begin
    Result:=ShowScreen;
end;

function TForm_BatInPutData.MakeJinDaoBasicData: Boolean;
var
  t_s:string;
  tm: TReadRecord;
begin
   Result:=true;
   MyRule.SetUsed_WorkFaceId(S_WorkFaceid);
   if not ReadJinDaoBasicData(MyReadDataClass ) then  begin
       t_s:='��ѡ����ļ�������û��֧�ܱ��Ϊ��'+JinDaoBasicSupport+'��������' +#13#10
            +'��֧������Ϊ��ȡ����������ȷʵû���뵽����¼���������޸ģ�';
       Application.MessageBox(Pwidechar(t_s),'��ʾ',MB_OK+MB_ICONQUESTION);
       Result:=False;

   end else begin
       MyReadDataClass.ClearItems ;
       tm.FileName:=ChangeFileExt(JinDaoBasicSupport,'.'+MyRule.FileSuffix);
       tm.elapsedMilliseconds :=0;
       tm.RecordNumber :=0;
       tm.ReadFin :=False;
       tm.printed :=False;
       tm.Processing :=0;
       MyReadDataClass.Add(tm);
       MakeOtherSupportDate;
   end;

end;

function TForm_BatInPutData.MakeOtherSupportDate: Boolean;
var
  sql:string;
  t_s:string;

begin
   Result:=False;
   if InputFileListBox.SelCount <1 then   begin
      messagebox(self.Handle,'��û��ѡ���κ��ļ����޷��������ݣ�','ϵͳ��ʾ',mb_iconerror+mb_ok);
      exit;
   end;

   t_s:='    ��ȷ��Ҫ��ѡ�еġ�'+IntToStr(self.InputFileListBox.SelCount)+'���������ļ����е����������ô?'  + #13#10   +
        '�������ݻỨ�Ѻܳ�ʱ�䣬�����ݵ��뿪ʼ���뾡����Ҫֹͣ�� '  + #13#10 +
        'Ҳ��Ҫ�Ըù�����Ŀ�ѹ���ݽ�����ز�������л������';
   if Application.MessageBox(Pwidechar(t_s),'��ʾ',MB_OKCANCEL+MB_ICONWARNING) =2 then  exit;


   // ��ʼ��������
   // ���������ݵ���
   FillMyReadDataClass(MyReadDataClass);
   {����ִ��ָ��}
   MyReadDataClass.SetCloseThread(False);
   // �ƶ� �������̵� �׶�
   ThreadProcessStep:=5;
   MyReadDataClass.ProcessStep :=ThreadProcessStep;
   MyReadDataClass.ExHandle :=Application.Handle ;
   MYReadDataThread:=TReadFileData.Create(MainDataModule.ExConn,Selected_Ruleid,
                                    S_WorkFaceid,MyReadDataClass);
   MYReadDataThread.FreeOnTerminate:=true;
   MYReadDataThread.Resume;
   Memo_Log.Clear ;
   Timer1.Enabled :=true;

   self.AddLOG('���ݷ�����ʼ....');
   Result:=True;
end;

procedure TForm_BatInPutData.OneButtonDisposeData;
begin

end;

function TForm_BatInPutData.ReadJinDaoBasicData(Rd:TReadDataClass): Boolean;
var
  i:integer;
  tm: TReadRecord;
  FiLeName:String;
begin
  Result:=False;
  
  JinDaoBasicSupport:= MyRule.DisPoseCycleDataS.GetJinDaoBasicSupport;
  //
  Rd.ClearItems ;
  Rd.FileDir :=self.DirectoryListBox1.Directory ;
   for I := 0 to InputFileListBox.Count -1 do  begin
       FiLeName:= ExtractFileName(ChangeFileExt(InputFileListBox.Items[i],''));
       if FiLeName = UpperCase(Trim(JinDaoBasicSupport))  then begin
           tm.FileName:=InputFileListBox.Items[i];
           tm.elapsedMilliseconds :=0;
           tm.RecordNumber :=0;
           tm.ReadFin :=False;
           tm.printed :=False;
           tm.Processing :=0;
           Rd.Add(tm);
           Result:=true;
           break;
       end;
   end;

end;

procedure TForm_BatInPutData.RefreshTotalTime(Coun: integer; tim: double);
var
  Min,Sec:integer;
begin
   if  TotalTime < (Coun-2)*30 + ThreadProcessStep*10 then    TotalTime:=(Coun-2)*30+ThreadProcessStep*10;
   if  TotalTime > (Coun)*30 +ThreadProcessStep*10 then    TotalTime:=(Coun)*30+ThreadProcessStep*10;

   TotalTime:= TotalTime-tim;
   if TotalTime <0  then TotalTime:=30;

   Min:=trunc(TotalTime) div 60;
   Sec:=trunc(TotalTime ) mod 60;
   if Min>0  then begin
     Speed_Label.Caption :='Ԥ�����ݵ��뻹�衾'+IntToStr(Min)+'���֡�'+IntToStr(Sec)+'����';
   end else begin
     Speed_Label.Caption :='Ԥ�����ݵ��뻹�衾'+IntToStr(Sec)+'����';
   end;


end;

procedure TForm_BatInPutData.RG_JD_BasicClick(Sender: TObject);
begin
  if RG_JD_Basic.ItemIndex =0 then begin
     self.Edit_JD_support.Text:='10';
  end else if RG_JD_Basic.ItemIndex =1 then begin
     Edit_JD_support.Text:=intToStr(EndSupNumber div 2 );
  end else begin
     Edit_JD_support.Text:=intToStr(EndSupNumber-10 );
  end;

end;

procedure TForm_BatInPutData.SaveButtonClick(Sender: TObject);
begin
   TotalTime:=10000;
   //�� MyRule ����������Ƿ�ı�
   if SeekMyRuleJinDaoChanged then
      MyRule.DisPoseCycleDataS.SaveWorkFaceInforMation ;
   if Selected_Ruleid <1 then
       if not SecectedRuleName(CB_RuleName.Text ) then     exit;


   if not MakeJinDaoBasicData   then exit ;
   ShowScreen:=2;
end;

function TForm_BatInPutData.SecectedRuleName(Str: String):Boolean;
begin
  Result:=False;
    Selected_Ruleid:=public_Basic.StrToInt_lu(LeftStr(Str,pos('_',Str)-1));
    if Selected_Ruleid >0  then   begin
        FillMyRuleData(Selected_Ruleid,MyRule);
        InputFileListBox.Mask :='*.' +MyRule.FileSuffix;
        REsult:=True;
    end;

end;

function TForm_BatInPutData.SeekMyRuleJinDaoChanged: Boolean;
var
  tmpSup:integer;
begin
   Result:=False;
   tmpSup:=public_Basic.StrToInt_lu(Trim(Edit_JD_support.Text)) ;
   if tmpSup <1 then  begin
      exit;
   end;

   if  RG_JD_Basic.ItemIndex <> MyRule.DisPoseCycleDataS.MyWokFace_Info.JinDao_Basic  then  begin
       MyRule.DisPoseCycleDataS.MyWokFace_Info.JinDao_Basic:=RG_JD_Basic.ItemIndex ;
       Result:=true;
   end;

   if  tmpSup <> MyRule.DisPoseCycleDataS.MyWokFace_Info.JinDao_Support  then  begin
       MyRule.DisPoseCycleDataS.MyWokFace_Info.JinDao_Support:=tmpSup ;
       Result:=true;
   end;

   if  RG_JD_time.ItemIndex <> MyRule.DisPoseCycleDataS.MyWokFace_Info.JinDao_Time  then  begin
       MyRule.DisPoseCycleDataS.MyWokFace_Info.JinDao_Time:=RG_JD_time.ItemIndex ;
       Result:=true;
   end;

   if  RD_CJ_Type.ItemIndex <> MyRule.DisPoseCycleDataS.MyWokFace_Info.Jindao_DataType  then  begin
       MyRule.DisPoseCycleDataS.MyWokFace_Info.Jindao_DataType:=RD_CJ_Type.ItemIndex ;
       Result:=true;
   end;

end;

procedure TForm_BatInPutData.SetFromWidthAndHeigth(flag: integer);
begin
   if Flag=1  then  begin
       WindowState:= wsNormal;
       ShowScreen:=1;
       Show;
       SetFocus;
   end else begin
       ShowScreen:=0;
       WindowState:= wsNormal;
       Show;
       SetFocus;
   end;
end;

procedure TForm_BatInPutData.Timer1Timer(Sender: TObject);
var
  i:integer;
  Hou,Min,sec:integer;
  st:String;
  LabDisp:Boolean;
begin
   Hou:=0;Min:=0; LabDisp:=False;
   self.ProgressBar1.StepIt ;
    for I := 0 to MyReadDataClass.count -1 do   begin
         if (not MyReadDataClass.Items[i].printed ) and (MyReadDataClass.Items[i].ReadFin)  then   begin
            St:='& �ļ�['+MyReadDataClass.Items[i].FileName+']����ɹ���' + ' / �����¼['+Inttostr(MyReadDataClass.Items[i].RecordNumber)+']��'
                + ' / ��ʱ['+FormatFloat('0.00',MyReadDataClass.Items[i].elapsedMilliseconds/1000)+']��' ;
            AddLOG(St);
            MyReadDataClass.Items[i].printed:=true;
         end else if (not MyReadDataClass.Items[i].printed ) and (not MyReadDataClass.Items[i].ReadFin) and
                  (MyReadDataClass.Items[i].Processing > 0)  then  begin
              if MyReadDataClass.Items[i].PrintProc <> trunc(MyReadDataClass.Items[i].Processing) div 30 then begin
                    AddLOG('  --���������ļ�['+MyReadDataClass.Items[i].FileName+']��չ['+FormatFloat('0',MyReadDataClass.Items[i].Processing)+'%]');
                    MyReadDataClass.Items[i].PrintProc := trunc(MyReadDataClass.Items[i].Processing) div 30 ;
              end;

         end;

        if  ( MyReadDataClass.Items[i].printed=False  ) and (not LabDisp) then  begin
            RefreshTotalTime(MyReadDataClass.count -i,0.5);
            LabDisp:=true;
        end;

    end;
    // �жϹ���
    if ThreadProcessStep<> MyReadDataClass.ProcessStep then begin
       if MyReadDataClass.ProcessStep=4 then begin
          AddLOG('=======================================');
          AddLOG('& ϵͳ���ڴ����������ݣ�Ҳ���Ե�������ά���������޸ģ�');
       end;

       if MyReadDataClass.ProcessStep=3 then begin
          AddLOG('& �������ݴ�����ɣ�');
          AddLOG('=======================================');
          AddLOG('& ϵͳ������ȡÿһ�������ݣ�Ҳ���Ե�������ά���������޸ģ�');
       end;

       if MyReadDataClass.ProcessStep=2 then begin
          AddLOG('& ÿһ��ѹ�����ݴ�����ɴ�����ɣ�');
          AddLOG('=======================================');
          //AddLOG('& ϵͳ������ȡÿһ�������ݣ�Ҳ���Ե�������ά���������޸ģ�');
       end;

       RefreshTotalTime(0,0.5);

       ThreadProcessStep:= MyReadDataClass.ProcessStep ;
    end;
    //���ݵ������
    if (not IsExsitReadThread('MYReadDataThread') ) then  begin
        AddLOG('=======================================');
        AddLOG('& �����ļ�������ɣ�');
        sec:=Round(MyReadDataClass.elapsedMilliseconds/1000);
        Min:=trunc(Sec/60);
        if Min >0 then   Sec:= Sec mod 60;
        Hou:= Trunc(Min /60);
        if Hou >0 then  Min:=MIn mod 60;
        if Hou >0  then  begin
            AddLOG('& �����ļ���ʱ['+IntTostr(hou)+']Сʱ['+IntTostr(Min)+']����['+IntTostr(Sec)+']��');
            Speed_Label.Caption :='����������ɣ�����ʱ['+IntTostr(hou)+']Сʱ['+IntTostr(Min)+']����['+IntTostr(Sec)+']��';
        end else if Min >0 then  begin
            AddLOG('& �����ļ���ʱ['+IntTostr(Min)+']����['+IntTostr(Sec)+']��');
            Speed_Label.Caption :='����������ɣ�����ʱ['+IntTostr(Min)+']����['+IntTostr(Sec)+']��';
        end else begin
            AddLOG('& �����ļ���ʱ['+IntTostr(Sec)+']��');
            Speed_Label.Caption :='����������ɣ�����ʱ['+IntTostr(Sec)+']��';
        end;
        Timer1.Enabled :=False;
        ProgressBar1.Position := ProgressBar1.Max ;
        But_AutoDraw.Enabled :=true;
    end;


end;

procedure TForm_BatInPutData.ToolButton1Click(Sender: TObject);
begin
   CreateMakeRule_inn(Application.Handle,'���ݹ��򲹳����',ParentWid,ParentHig);
end;

{ TReadFileData }

constructor TReadFileData.Create(ADOC: TMySqlConnection;Ru_id:integer;Gzm_id:string;MYClass:TReadDataClass);
{
  ADOC:���ݿ������
  id: ���ݹ���ı�ţ����ڵ����ݿ��в���
  MYClass: ��ȡ���ݵĹ��� ��
}
begin

   inherited  Create(true) ;
   FreeOnTerminate := True;

   MyDataSet:=TMyDataSet.Create(nil);
   MyDataSet.MySqlConnection:=ADOC;
   MyCommand:=TMyCommand.Create(nil);
   MyCommand.MySqlConnection :=ADOC;

   if not Assigned(MyRule) then
      MyRule:=TMakeRuleClass.Create(ADOC) ;
    //
    ReadClass:=MYClass;;
    Rule_id:=Ru_id;
    WorkFace_id:=Gzm_id;
    //Fill
    FillRuleClass(Rule_id);
end;

destructor TReadFileData.Destroy;
begin
  if Assigned(MyRule) then  FreeAndNil(MyRule);
  FreeAndNil(MyDataSet);
  FreeAndNil(MyCommand);

  inherited;
end;

procedure TReadFileData.Execute;
var
  i,S_C:Integer;
  Sw1,sw2:TStopWatch;
  BasicSupport:Integer;

begin
  inherited;
   CoInitialize(nil);
  Sw1:=TstopWatch.Create();    Sw2:=TstopWatch.Create();
  ReadClass.elapsedMilliseconds:=0;
  SW1.Start;
  MyRule.SetUsed_WorkFaceId(WorkFace_id);
    //�ѽ���������ȷ��
  BasicSupport:=Public_Basic.StrToInt_lu(ReadJinDaoBasicData);
  MyRule.DisPoseCycleDataS.BasicJindao.StartTime :=-1;

  // ������������
    for I := 0 to ReadClass.Count -1 do  begin
       {���ϵͳ�˳�}
       if ReadClass.CloseThread then  exit;

       SW2.Start;
       S_C:=-1;
       // �����������������
       MyRule.ClearAnal_DataS ;
       //������һ��֧�� ��֧���� �ж������Ļ���֧��
       if i=0 then  begin
         S_C:= MyRule.LoadDataFromFlie(ReadClass.Items[i],ReadClass.FileDir + '\' +ReadClass.Items[i].FileName,-1);
       end else begin
         // �Ѹ��ļ��еļ�¼׷�ӵ���
         S_C:= MyRule.LoadDataFromFlie(ReadClass.Items[i],ReadClass.FileDir + '\' +ReadClass.Items[i].FileName,BasicSupport);
       end;
       


       if S_C>=0  then  begin
           SW2.stop;
           ReadClass.Items[i].RecordNumber:=S_C;
           ReadClass.Items[i].elapsedMilliseconds:=sw2.ElapsedMilliseconds;
           ReadClass.Items[i].ReadFin :=true;
       end;

    end;

   // ����������һ���׶�
   OneButtonDisposeData;

   SW1.Stop;
   ReadClass.elapsedMilliseconds := sw1.ElapsedMilliseconds;

   FreeAndNil(sw1);
   FreeAndNil(sw2);
   CoUnInitialize;
end;

procedure TReadFileData.FillRuleClass(id: integer);
var
   Sql:string;
   tmp:TBasicDataParm;
begin
   {
        inputRule  RuleName,FileSufix,LineSplitStr,SupProFlag,SupUpper, ' +
          ' TimeProFlag,TimeUpper,TimeString )
        InputRule_DataType  Ruleid,DataType,DataBh,DataProFlag,DataUpper) values ( ';
   }

   try
       sql:='select * from  inputRule where id= ' +IntTostr(id);
        MyRule.ClearDataS ;
        MyDataSet.Close ;
        MyDataSet.CommandText :=sql;
        if MyDataSet.Open  then  begin
           MyRule.RuleId:=MyDataSet.FieldByName('id').AsInteger;
           MyRule.RuleName :=MyDataSet.FieldByName('RuleName').AsString;
           MyRule.FileSuffix :=MyDataSet.FieldByName('FileSufix').AsString;
           MyRule.LineSplitTag :=MyDataSet.FieldByName('LineSplitStr').AsString;
           MyRule.SupProRec.TagStr :=MyDataSet.FieldByName('SupProFlag').AsString;
           MyRule.SupProRec.UpperCase :=MyDataSet.FieldByName('SupUpper').AsInteger;
           MyRule.DTProRec.TagStr :=MyDataSet.FieldByName('TimeProFlag').AsString;
           MyRule.DTProRec.UpperCase :=MyDataSet.FieldByName('TimeUpper').AsInteger;
           MyRule.DataTimeStr :=MyDataSet.FieldByName('TimeString').AsString;
            if MyDataSet.FieldByName('MoveSupTag').AsInteger=1 then  begin
              MyRule.MoveSuppFlag:=true;
              MyRule.MoveProRec.UpperCase:=MyDataSet.FieldByName('MoveSuP_Upper').AsInteger;
              MyRule.MoveSupp_Equal :=MyDataSet.FieldByName('MoveSup_Equal').AsString;
              MyRule.MoveProRec.TagStr :=MyDataSet.FieldByName('MoveSup_ProFlag').AsString;
              MyRule.MoveSupp_Value:=MyDataSet.FieldByName('MoveSup_Value').AsInteger;
           end else begin
              MyRule.MoveSuppFlag:=False;
              MyRule.MoveProRec.UpperCase:=0;
              MyRule.MoveSupp_Equal :='';
              MyRule.MoveProRec.TagStr :='';
              MyRule.MoveSupp_Value:=0;
           end;
            MyRule.MuleData_MAX_AGV:= MyDataSet.FieldByName('Mult_Max_AGV').AsInteger;
        end;
       MyDataSet.Close ;
       sql:='select * from  InputRule_DataType where Ruleid= ' +IntTostr(MyRule.RuleId);
       MyDataSet.CommandText :=sql;
       if MyDataSet.Open  then
         while not MyDataSet.Eof  do  begin
           tmp.DataName :=MyDataSet.FieldByName('DataType').AsString;
           tmp.DataBh :=MyDataSet.FieldByName('DataBh').AsInteger ;
           tmp.DataType :=TSupportDataType(tmp.DataBh);

           tmp.TagStr :=MyDataSet.FieldByName('DataProFlag').AsString;
           tmp.UpperCase :=MyDataSet.FieldByName('DataUpper').AsInteger ;
           tmp.DataUnit:=MyDataSet.FieldByName('DataUnit').AsString;
           MyRule.AddBasicDataS(tmp);
           MyDataSet.Next ;
         end;
   finally
     MyDataSet.Close ;
   end;

end;



function TReadFileData.OneButtonDisposeData: Boolean;
var
   tmp_JinDao:TModifyJinDao_From ;
   tmp_RockPress:TEdit_PressDataForm;
   tmp_ContourGraph:TForm_ContourGraph;
   tmp_tool: TFormPressTool;
   tmp_LineGrahp:TForm_LineGraph;
   tmp_Band_Bar:TForm_Band_Bar;
begin
    // �����һ���׶�
    Dec(ReadClass.ProcessStep);
    { �ѽ��� ����Ϣ�Զ����}
    try
       tmp_JinDao:=TModifyJinDao_From.Create(nil) ;
       with tmp_jinDao do  begin
           InitForm;
           AutoLoadInputJinDao(0);
           SaveJinDaoIntoDAtaBase(0);
       end;
    finally
       FreeAndNil(tmp_JinDao);
    end;
    // �����һ���׶�
    Dec(ReadClass.ProcessStep);
    {������ά����Ϣ�Զ����}
    try
       tmp_RockPress:=TEdit_PressDataForm.Create(nil);
        with tmp_RockPress do  begin
           InitForm;
           UpdateBatInputData(0);
       end;
    finally
       FreeAndNil(tmp_RockPress);
    end;
    // �����һ���׶�
    Dec(ReadClass.ProcessStep);
   

end;

function TReadFileData.ReadJinDaoBasicData: string;
begin
  Result:='';
  if not  MyRule.DisPoseCycleDataS.ReadWorkFaceInforMation  then
     exit;
  Result:= MyRule.DisPoseCycleDataS.GetJinDaoBasicSupport;

end;

{ TReadDataClass }

procedure TReadDataClass.Add(tm: TReadRecord);
begin
  inc(Count);
  setlength(Items,Count);
  Items[Count-1]:=tm;
  Items[Count-1].CloseThread:=False;
end;

procedure TReadDataClass.ClearItems;
begin
  setlength(Items,0);
  Count:=0;
end;

constructor TReadDataClass.Create;
begin
   Count:=0;
   ProcessStep:=0;
   CloseThread:=False;
end;

destructor TReadDataClass.Destroy;
begin

  inherited;
end;

procedure TReadDataClass.SetCloseThread(Value: Boolean);
var
  i:integer;
begin
   CloseThread:=Value;
   for I := 0 to Count-1 do
       Items[i].CloseThread:=Value;
end;

procedure TReadDataClass.SetFileName(Value: String);
begin
   self.FileDir :=Value;
end;

end. // end unit