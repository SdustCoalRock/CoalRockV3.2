unit FormMonitor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,System.SyncObjs,
  uIRockPress, Vcl.Menus

  ;

type
  // ����һ���߳�
  TOpenContourThread = class; //��Ϊ��ǰ����
  TOnAccumulated = procedure(Sender: TOpenContourThread) of object;
  // �������ǰ������Sender ��Ҫ����� TObject
  // ���¼������У�Ҫ���� Sender ����Ҫǿ��ת��
  TOpenContourThread = class(TThread)
  private
     FEvent: TEvent; // ��������ʵ���̹߳�����
     procedure OpenFrom;
  protected
    procedure Execute; override;
  public
     inCallRock:TDefine_RockPress;
     ExHandle:THandle;
     OnAccumulated: TOnAccumulated;

     constructor Create(CreateSuspended: Boolean);
     destructor Destroy; override;
     procedure StartThread; // ����̵߳�����������
  end;

  TCoalRec= Class(TPersistent)
     private
          WholeOrOneCoal:Boolean; // true ȫ�� False  һ��ú��
          ParentPanel:TPanel;
          MoveLabel:TLabel;
          LabelPanel:TPanel;
          MapPanel:TPanel;
          innTime:TTimer;
          ShowBmpTime:TTimer;
          BmpTime:Integer;
          BasicBmpName,UseBmpName:String;

          procedure ImageShowFrom(img1,img2:TImage;Value:integer);
          procedure SetWholeScreenInfo(Panel:TPanel;Left_V:integer);
          procedure SetOneCoalInfo(Panel:TPanel;Left_V:integer);
          function  ChangeStretch(imag:Timage;pic_Path:string):Boolean;


     public
          Jituan:string;
          CoalName:string;
          Address:string;
          FormCaption:String;
          ImageBmp,shadowImg:TImage;
          Mkid:integer;
          Classid:integer;
          jingdu,weidu:double;
          MouseLeft:integer;
          ScreenPt:TPoint;

          procedure SetParentPanel(Panel:TPanel;Left_V:integer);
          procedure OnTimer(Sender: TObject);
          procedure flickerOnTimer2(Sender: TObject);
          procedure BmpOnClick(Sender: TObject);
          procedure BmpDoubleClick(Sender: TObject);
          procedure SetWholeOrOne(Value:integer);
          procedure ClearParent;
          procedure ReLoadFirstImg(First:Boolean);
          procedure BmpMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);


      constructor Create;
      destructor Destroy;
   end;

  TUserRec=record
      WholeScreenOrOneCol:integer;// ��ȫ�ֽ��滹��һ��ú��Ľ���    1 ȫ�ֽ���  2 ����ú��Ľ���
      CoalInforLoaded:Boolean;// ����ú����Ϣ�Ƿ����
      MeiKuang_id:integer;
      MeiKuang_Name:string;
      workFace_First_id:integer;
      workFace_id:integer ;
      WorkFace_Name:String;
      Drill_id:integer;
      Drill_Name:String;
      isUsedWorkFace:Boolean;//ѡ�еĹ������Ƿ���Ч
      ClickPanel:integer; // ����ı��
  end;

  TMonitorForm = class(TForm)
    StatusBar1: TStatusBar;
    ImageList1: TImageList;
    MainPanel: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Timer1: TTimer;
    JudgeSelectCoal: TTimer;
    PopLeftMouse: TPopupMenu;
    Pop_Selgzm: TMenuItem;
    Pop_Return: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Pop_RefBmp: TMenuItem;
    Pop_NextGroup: TMenuItem;
    Pop_OneCoal: TMenuItem;
    N3: TMenuItem;
    Pop_ExitMonitor: TMenuItem;
    MakeWorkTimer: TTimer;
    Pop_PrevGroup: TMenuItem;
    N4: TMenuItem;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure JudgeSelectCoalTimer(Sender: TObject);
    procedure Pop_ReturnClick(Sender: TObject);
    procedure Pop_SelgzmClick(Sender: TObject);
    procedure Pop_OneCoalClick(Sender: TObject);
    procedure Pop_RefBmpClick(Sender: TObject);
    procedure Pop_NextGroupClick(Sender: TObject);
    procedure Pop_ExitMonitorClick(Sender: TObject);
    procedure MakeWorkTimerTimer(Sender: TObject);
    procedure Pop_PrevGroupClick(Sender: TObject);

  private
    { Private declarations }
    SelectData:TUserRec;
    StartCoalId:integer;
    DispStore,ShowMapForm,MapSaveB:Boolean;
    CoalNameCount:integer;
    CoalClass:array of TCoalRec;
    DataSource:integer;// ����Դ�����ͣ������;����� ���ݵĽ��뷽ʽ 0  ��������  1 ��ʱ����
    WordTotalPercent:integer;// word�ĵ���������
    //
    SingleForm:array [0..13] of TCoalRec;
    //
    MapClass,NextClass: TCoalRec;
    pop_left_clickid:integer;// ����Ҽ��������


    function  ReturnPanel(id:integer):TPanel;
    procedure MakeWindowsSingle(Single:integer); // ����ҳ����ʾ��ʽ
    procedure SetPanelPoistion(Rect1:TRect;col,Row:integer);
    // control CoalClass
    procedure AddCoalClass(Jituan,MkN,Addr:String;id:integer;path1,path2:string;jd,wd:double);
    procedure ClearCoalClass;
    // �������ݿ��е� ú����Ϣ��
    procedure LoadCoalInformation; //����ȫ��ú����Ϣ
    procedure IntoOneCoal(MKid,WorkFaceid:integer);// ����һ��ú�������
    function  ReturnFormCaption(id:integer):String;
    procedure LoadUsedInformation; //�������õ�����
    procedure AddOtherClassInformation(otherClass:TCoalRec;Jituan,MkN,Addr:String;
                                       id:integer;path1,path2:string;jd,wd:double);
    //
    procedure DisLpayWholeCoalScreenGuld(Mkid,Classid:integer); // ��ʾ�� ������
    procedure DispLayScreen(Startid:integer);
    procedure ScreenCap(LeftPos,TopPos,RightPos,BottomPos:integer;pic_path:string);
    procedure SaveMapToBmp;
    function  ChangeStretch(imag:Timage;pic_Path:string):Boolean;
    function  GetWorkFaceFisrtid(MKid:integer):Boolean;
    procedure PanelComponentClear;
    procedure CallWorkFaceSingleFrom(id:integer);
    procedure ShowClickFromCommand(Vis:Boolean);
    procedure CreateThreadOpenContourForm(value:Boolean);
    procedure ReadPublicUsedMkInfoFromFile(id:integer);
    procedure SavePublicUsedMkInfoIntoFile;
    //
    procedure OnAccumulated(Sender: TOpenContourThread);
    procedure OpenContourForm(Vis:boolean);// ��ConTourForm
    Procedure DispLeftPop(Clickid,MouseFlag:integer;Px,Py:Integer);//��ʾPopleft���ƿ�ݲ˵�

   // ����DPI��ʾ
     procedure WMDpiChanged(var Message: TMessage); message WM_DPICHANGED;
  public
    { Public declarations }
    procedure SetCloseQuery;
  end;

  function CreateMonitorForm(AHandle:THandle;ACaption:string;Wid,Hi,Single:integer):THandle;stdcall;
  procedure MakeThreadToOpenConToursForm;
var
  MonitorForm: TMonitorForm;
  ExClickid,EXClassid:integer;
  ShowPuse,DoubleClick:Boolean;
  ContourOpen:Boolean;
  staticTime:integer;
  //
implementation

{$R *.dfm}

uses MainForm, Lu_Public_BasicModual,JPeg,shellapi;

//---------------------
procedure MakeThreadToOpenConToursForm;
begin
//    if not MainCForm.Call_RockPress.GetWinFormIsExsit('CONTOUR') then  begin
//         MainCForm.Call_RockPress.CreateRockPressGraph(MainCForm.ShowPanel.Handle,
//               '��ɽѹ���ۺϷ�������',0,0,3);
//         MainCForm.Call_RockPress.CloseRockPressTool ;
//         ContourOpen:=true;
//    end;
//     MainCForm.Call_RockPress.SetOpenFormChangeParentPanel('CONTOUR',MonitorForm.Handle)  ;
end;
//--------------------
 function CreateMonitorForm(AHandle:THandle;ACaption:string;Wid,Hi,Single:integer):THandle;stdcall;
{

  Single 0 ����ҳ��  1 ȫ��ҳ��
}
begin
        if Assigned(MonitorForm) then  FreeAndNil(MonitorForm);
        Application.Handle :=AHandle;
        MonitorForm:=TMonitorForm.Create(Application);

         try
           with MonitorForm do begin
               Caption:=ACaption;
               //WindowState:=wsMaximized;
               ParentWindow:=Ahandle;

               Height:=Hi;
               Width:=Wid;
               Show;
               MakeWindowsSingle(Single);

               Result:=MonitorForm.Handle ;//����ֵ
          end ;
        except
           FreeAndNil(MonitorForm);
        end;

end;

{ TForm2 }

procedure TMonitorForm.AddCoalClass(Jituan,MkN,Addr: String; id: integer; path1,path2:string;
          jd, wd: double);
begin
   inc(CoalNameCount);
   setlength(CoalClass,CoalNameCount);
   CoalClass[CoalNameCount-1]:=TCoalRec.Create ;
      CoalClass[CoalNameCount-1].Jituan:= Jituan;
      CoalClass[CoalNameCount-1].CoalName :=MkN;
      CoalClass[CoalNameCount-1].Address:=Addr;
      CoalClass[CoalNameCount-1].Mkid :=id;
      CoalClass[CoalNameCount-1].BasicBmpName:=path1;
      CoalClass[CoalNameCount-1].UseBmpName:=path2;
      CoalClass[CoalNameCount-1].jingdu :=jd;
      CoalClass[CoalNameCount-1].weidu :=wd;
      //---------
      CoalClass[CoalNameCount-1].SetWholeOrOne(1);
      CoalClass[CoalNameCount-1].Classid:=CoalNameCount-1;
end;

procedure TMonitorForm.AddOtherClassInformation(otherClass: TCoalRec; Jituan,
  MkN, Addr: String; id: integer; path1,path2:string; jd, wd: double);
begin
      otherClass.Jituan:= Jituan;
      otherClass.CoalName :=MkN;
      otherClass.Address:=Addr;
      otherClass.Mkid :=id;
      otherClass.BasicBmpName:=path1;
      otherClass.UseBmpName :=path2;
      otherClass.jingdu :=jd;
      otherClass.weidu :=wd;
      otherClass.WholeOrOneCoal :=True;
      otherClass.Classid:=-1;
end;


procedure TMonitorForm.CallWorkFaceSingleFrom(id: integer);
var
  MinD,MaxD:integer;
begin
    selectData.ClickPanel :=id;
     case id of
       3000: //  ='�ɳ��ϸ��Ҳ��˶������ƶ�';
            begin
                MainCForm.CallPStope.OpenFyyd(Handle,
                  '�ɳ��ϸ��Ҳ��˶������ƶ�',Width,Height,1);
                JudgeSelectCoal.Enabled :=true;

            end;
       3001: //  '�ɳ��ɶ������˶�����ģ��'
           begin
               MainCForm.CallPStope.OpenDTFZ(Handle,
                  '�ɳ��ɶ������˶�����ģ��',Width,Height,1);
               JudgeSelectCoal.Enabled :=true;
           end;

       3002: //  '�����˶����ɽṹչʾ'
           begin
               MainCForm.CallPStope.OpenEditPstope(Handle,
                  '�����˶����ɽṹչʾ',Width,Height,1);
               JudgeSelectCoal.Enabled :=true;
           end;


       3003: //  '�ɳ�֧��ѹ���ֲ���Χ����'
           begin
               MainCForm.CallPStope.OpenZCYL(Handle,
                  '�ɳ�֧��ѹ���ֲ���Χ����',Width,Height,1);
               JudgeSelectCoal.Enabled :=true;
           end;
       
       3004: //  'Һѹ֧��ʵʱѹ������ͼ'
          begin //
               OpenContourForm(False);
               MainCForm.Call_RockPress.OpenConTourChildForm('LINEGRAHP',Handle,0,0) ;
               JudgeSelectCoal.Enabled :=true;
          end;
       3005: //   'ʵʱѹ��������ά����ͼ';
          begin //
               OpenContourForm(False);
               MainCForm.Call_RockPress.OpenConTourChildForm('THREERESULT',Handle,0,0) ;
               JudgeSelectCoal.Enabled :=true;
          end;
       3006: //  'Һѹ֧��ʵʱѹ��ͳ��ѧ����';
          begin //
               OpenContourForm(False);
               MainCForm.Call_RockPress.OpenConTourChildForm('TONGJI',Handle,0,0) ;
               JudgeSelectCoal.Enabled :=true;
          end;

       3007: //  'Һѹ֧��ʵʱѹ��ֱ��ͼ';  BRANDBAR
          begin //
               OpenContourForm(False);
               MainCForm.Call_RockPress.OpenConTourChildForm('BRANDBAR',Handle,0,0) ;
               JudgeSelectCoal.Enabled :=true;
          end;
       3008: // 'ʵʱ���ݲɼ�����'
          begin
             MainCForm.Call_RockPress.CreateBatInputD(Handle,
                               '��ѹʵʱ���ݵ������',Width,Height,1);
             JudgeSelectCoal.Enabled :=true;
          end ;

       3009: //  '���������ά������';
         begin
             MainCForm.Call_RockPress.CreateEditJinDao(Handle,
                               '���������ά������',Width,Height,1);
             JudgeSelectCoal.Enabled :=true;
         end ;

       3010: //  '��ѹ��ȷ�������';
         begin //
              MainCForm.Call_RockPress.GetMinAndMaxJinDao(MinD,MaxD);

              MainCForm.UserWin.CreateOpenWordFrom(Handle,
                               '�򿪿�ѹ�۲ⱨ��ҳ��',Width,Height,1);
              MainCForm.UserWin.GetMinAndMaxJinDao(MinD,MaxD);
              public_Basic.WriteMakeWordPercent(true,1);
              MakeWorkTimer.Enabled :=true;
              JudgeSelectCoal.Enabled :=true;
         end;


       3011: //  'Һѹ֧���Ƽ�ʱ��ɢ��ͼ';
          begin
              OpenContourForm(False);
              MainCForm.Call_RockPress.OpenConTourChildForm('MOVEPOINT',Handle,0,0) ;
              JudgeSelectCoal.Enabled :=true;
          end;

       3012: // '�������������ѹ����ͼ';
          begin //
               OpenContourForm(true);
               JudgeSelectCoal.Enabled :=true;
          end;
      


    end;
end;

function TMonitorForm.ChangeStretch(imag: Timage; pic_Path:string): Boolean;
var
  in_imge:Timage;
begin
    in_imge:=Timage.Create(nil);
    try
       in_imge.Picture.LoadFromFile(pic_Path);
       in_imge.Stretch:=true;
       imag.Canvas.StretchDraw(imag.ClientRect,in_imge.Picture.Graphic);
    finally
       in_imge.Free;
    end;
end;

procedure TMonitorForm.ClearCoalClass;
var
  i:integer;
begin
  for I := CoalNameCount-1  downto 0   do
     if assigned(CoalClass[i]) then begin
       CoalClass[i].Destroy;
//       FreeandNil(CoalClass[i]);
     end;
  setlength(CoalClass,0);
  CoalNameCount:=0;
end;

procedure TMonitorForm.CreateThreadOpenContourForm(Value:Boolean);
var
 accThread: TOpenContourThread;
begin
 // if not Assigned(accThread)  then
     accThread := TOpenContourThread.Create(False);
//     accThread.OnAccumulated := self.OnAccumulated; //ָ���¼���
     //accThread.FreeOnTerminate := true; // �߳̽������Զ��ͷ�
     accThread.inCallRock :=MainCForm.Call_RockPress;
//     accThread.ExHandle :=MainCForm.ShowPanel.Handle;
     //accThread.Start ;
end;

procedure TMonitorForm.DisLpayWholeCoalScreenGuld(Mkid,Classid:integer);
var
  i:integer;
  State:Boolean;
  Percent:integer;
begin
     // ��Panel�ڿؼ����
     if DoubleClick then DoubleClick:=False;

     staticTime:=1;
     ShowPuse:=False; // �����е� ����ֹͣ
     if SelectData.WholeScreenOrOneCol=1 then  begin
        PanelComponentClear;
        DispLayScreen(0);
        MakeWorkTimer.Enabled :=False;
     end else if SelectData.WholeScreenOrOneCol=2 then begin  // ���������ú��
        ReadPublicUsedMkInfoFromFile(0);
        if Mkid <> SelectData.MeiKuang_id then  begin // ������ǵ�ǰ�ļ�¼��ú��
           {���ǵ�ǰ��ú�� ȥ��ǰú���� ���� ��һ���ܹ�ʹ�õ�ú��}
            if GetWorkFaceFisrtid(SelectData.MeiKuang_id) then begin
                  PanelComponentClear;// �����Ļ
                  IntoOneCoal(SelectData.MeiKuang_id,SelectData.workFace_id);
                  for I := 0 to 12 do
                     singleForm[i].SetParentPanel(ReturnPanel(i+1),(i+1) mod 12 );
            end else begin
                SelectData.WholeScreenOrOneCol:=1;
                if (Classid <=12 ) and (Classid >=0 )then begin
                    CoalClass[Classid].LabelPanel.Color :=ClYellow;
                    CoalClass[Classid].MoveLabel.Caption :='û���ҵ����ʵ�����빤����ƥ�䣬��ά����������';
                end;
            end;
        end  else begin
           {����ǵ�ǰ��ú�󣬰�ú�����Ϣ�ҳ���������Ҫ���κζ���}
            PanelComponentClear;// �����Ļ
            ReadPublicUsedMkInfoFromFile(1);
            IntoOneCoal(SelectData.MeiKuang_id,SelectData.workFace_id);
            for I := 0 to 12 do
               singleForm[i].SetParentPanel(ReturnPanel(i+1),(i+1) mod 12 );
        end;
        //��ȡ word�ĵ�����
         State:=public_Basic.ReadMakeWordPercent(Percent) ;
         if State then    begin
            MakeWorkTimer.Enabled :=true;
         end else begin
            MakeWorkTimer.Enabled :=False;
         end;
     end;


end;

procedure TMonitorForm.DispLayScreen(Startid:integer);
var
  i:integer;
  pid:integer;
begin
   for I := 0 to CoalNameCount-1 do
         CoalClass[i].ClearParent;

   if Startid+11>CoalNameCount-1 then  Startid:=CoalNameCount-11;
    for I := Startid to Startid+11 do begin
          if not DispStore then  begin
             pid:=i+1-Startid;
             CoalClass[i].SetParentPanel(ReturnPanel(pid),(i+1) mod 12 );
          end else begin
              pid:=11+Startid-i;
             CoalClass[i].SetParentPanel(ReturnPanel(pid),(i+1) mod 12 );
          end;
    end;

//    NextClass.SetParentPanel(ReturnPanel(12),10);
    if not ShowMapForm then
        MapClass.SetParentPanel(ReturnPanel(13),10);


end;


procedure TMonitorForm.DispLeftPop(Clickid,MouseFlag:integer;Px, Py: Integer);
begin
    if MouseFlag=1 then  begin   // ú��ȫ�ֽ��� ���������
       Pop_PrevGroup.Enabled :=true;
       Pop_NextGroup.Enabled :=true;
       Pop_RefBmp.Enabled :=true;
       Pop_OneCoal.Enabled :=true;
       Pop_ExitMonitor.Enabled:=true;

       Pop_Selgzm.Enabled :=False;
       Pop_Return.Enabled :=False;

    end else if MouseFlag=2  then begin     //  ú����������������
       Pop_Selgzm.Enabled :=true;
       Pop_Return.Enabled :=true;
       Pop_ExitMonitor.Enabled:=true;

       Pop_PrevGroup.Enabled :=False;
       Pop_NextGroup.Enabled :=False;
       Pop_RefBmp.Enabled :=False;
       Pop_OneCoal.Enabled :=False;

    end else  begin
       exit;
    end;
    pop_left_clickid:=Clickid;
    PopLeftMouse.Popup(px,py);
end;

procedure TMonitorForm.ExitButtonClick(Sender: TObject);
begin
   close;
end;

procedure TMonitorForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  try
       MainCForm.UserWin.CloseActiveForm('all') ;
       MainCForm.Call_RockPress.CloseActiveForm('All');
       MainCForm.CallPStope.CloseActiveForm('All');

       MainCForm.Main_CoolBar.Visible :=true;
         {�رմ��壬������Ҫ����Close����}
       MainCForm. M_Basic_WholeScreen.Caption:='���ü��ȫ����ʾ';
       MainCForm.WholeScreen :=0;
       if Assigned(MonitorForm) then  FreeAndNil(MonitorForm);
   finally

   end;
end;

procedure TMonitorForm.FormCreate(Sender: TObject);
var
  i:integer;
begin
   MainPanel.Align:=alClient;

   MapClass:=TCoalRec.Create;
   NextClass:=TCoalRec.Create;

   ExClickid:=-1;
   EXClassid:=-1;
   StartCoalId:=0;
   DispStore:=False;
   ShowMapForm:=False;
   DoubleClick:=False;
   MapSaveB:=False;
  // SelectData.WholeScreenOrOneCol:=1; // ȫ�ֵĽ���
   SelectData.workFace_id:=0;
   SelectData.workFace_First_id:=0;

   for I := 0 to 13 do begin
       SingleForm[i]:=TCoalRec.Create ;
       SingleForm[i].SetWholeOrOne(2);
       SingleForm[i].MouseLeft:=2;
   end;

   LoadUsedInformation;
   staticTime:=0;
   ContourOpen:=False;
   pop_left_clickid:=-1;
   MakeWorkTimer.Enabled :=False;
   WordTotalPercent:=0;
end;

procedure TMonitorForm.FormDestroy(Sender: TObject);
var
  i:integer;
begin
 try
   ClearCoalClass;
   for I := 0 to 13 do
      if assigned(SingleForm[i]) then  SingleForm[i].Destroy;
   if assigned(MapClass) then  MapClass.Destroy;
   if assigned(NextClass) then  NextClass.Destroy;

 finally

 end;
end;

procedure TMonitorForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   staticTime:=1;
   ShowPuse:=False;
end;

procedure TMonitorForm.FormShow(Sender: TObject);
begin
   SetPanelPoistion(MainPanel.BoundsRect,4,4) ;
   DisLpayWholeCoalScreenGuld(-1,-1);
end;

function TMonitorForm.GetWorkFaceFisrtid(MKid: integer): Boolean;
  var
   s_1:Str_DT_array;
   C1:integer;
   iStr:String;
begin
    Result:=False;
    iStr:=strPas(MainCForm.UserWin.GEtWorkFaceBhList(MKid));
    s_1:=Public_Basic.split(istr,',',C1);
    if C1>=2 then  begin
       SelectData.workFace_id:=Public_Basic.StrToInt_lu(S_1[0]);
       SelectData.Drill_id:=Public_Basic.StrToInt_lu(S_1[1]);
       if (SelectData.workFace_id>0 ) and (SelectData.Drill_id>0) then  begin
           SelectData.MeiKuang_id := MKid;
           SavePublicUsedMkInfoIntoFile;
           Result:=true;
       end;
    end;

end;

procedure TMonitorForm.IntoOneCoal(MKid,WorkFaceid: integer);
var
  Pic_Path,Basic_path:string;
  id:integer;
begin
   DataSource:=MainCForm.UserWin.GetWorkFaceDataType(WorkFaceid);
   for id := 0 to 12 do    begin
       Basic_path:=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\OneCoal_'+IntToStr(id)+'_0.BMP';
       Pic_Path  :=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\OneCoal_'+IntToStr(id)+'_1.BMP';
       singleForm[id].FormCaption:=ReturnFormCaption(id);
       singleForm[id].Classid:=id;
       singleForm[id].UseBmpName:=Pic_Path ;
       singleForm[id].BasicBmpName:=Basic_path;
         //  11 �Ƿ��ؽ���
       singleForm[id].MKid :=3000+id;
       singleForm[id].SetParentPanel(ReturnPanel(id+1),id+1);
   end;
end;

procedure TMonitorForm.JudgeSelectCoalTimer(Sender: TObject);
begin
   case SelectData.ClickPanel of
        3000: //  ='�ɳ��ϸ��Ҳ��˶������ƶ�';
            begin
                if not MainCForm.CallPStope.GetWinFormIsExsit('FYYD') then begin
                     selectData.ClickPanel:=-2;
                     SingleForm[0].ReLoadFirstImg(False) ;
                     SingleForm[0].ImageBmp.Visible:=True;
                     JudgeSelectCoal.Enabled :=False;
                 end;
            end;


       3001: //  '�ɳ��ɶ������˶�����ģ��'
            begin
                if not MainCForm.CallPStope.GetWinFormIsExsit('DTFZ') then begin
                      selectData.ClickPanel:=-2;
                     SingleForm[1].ReLoadFirstImg(False) ;
                     SingleForm[1].ImageBmp.Visible:=True;
                     JudgeSelectCoal.Enabled :=False;
                 end;
            end;
       3002: // �ɳ���������չʾ
            begin
                if not MainCForm.CallPStope.GetWinFormIsExsit('DZTJ') then begin
                     selectData.ClickPanel:=-2;
                     SingleForm[2].ReLoadFirstImg(False) ;
                     SingleForm[2].ImageBmp.Visible:=True;
                     JudgeSelectCoal.Enabled :=False;
                 end;
            end;
       3003: //  '�ɳ�֧��ѹ���ֲ���Χ����'
            begin
                if not MainCForm.CallPStope.GetWinFormIsExsit('ZCYL') then begin
                      selectData.ClickPanel:=-2;
                     SingleForm[3].ReLoadFirstImg(False) ;
                     SingleForm[3].ImageBmp.Visible:=True;
                     JudgeSelectCoal.Enabled :=False;
                 end;
            end;

       
       3004: //  'Һѹ֧��ʵʱѹ������ͼ'
            begin
              if not MainCForm.Call_RockPress.GetWinFormIsExsit('LINEGRAHP') then begin
                    selectData.ClickPanel:=-2;
                   SingleForm[4].ReLoadFirstImg(False) ;
                   SingleForm[4].ImageBmp.Visible:=True;
                   JudgeSelectCoal.Enabled :=False;
              end;
            end;
       3005: //   'ʵʱѹ��������ά����ͼ';
            begin
              if not MainCForm.Call_RockPress.GetWinFormIsExsit('THREERESULT') then begin
                   SingleForm[5].ReLoadFirstImg(False) ;
                   SingleForm[5].ImageBmp.Visible:=True;
                   JudgeSelectCoal.Enabled :=False;
              end;
            end;
       3006: //  'Һѹ֧��ʵʱѹ��ͳ��ѧ����';
           if not MainCForm.Call_RockPress.GetWinFormIsExsit('TONGJI') then begin
                   selectData.ClickPanel:=-2;
                   SingleForm[6].ReLoadFirstImg(False) ;
                   SingleForm[6].ImageBmp.Visible:=True;
                  JudgeSelectCoal.Enabled :=False;
           end;

       3007: //  'Һѹ֧��ʵʱѹ��ֱ��ͼ';
           if not MainCForm.Call_RockPress.GetWinFormIsExsit('BRANDBAR') then begin
                   SingleForm[7].ReLoadFirstImg(False) ;
                   SingleForm[7].ImageBmp.Visible:=True;
                  JudgeSelectCoal.Enabled :=False;
           end;
      
       3008:// ���������ݵ���
           if not MainCForm.Call_RockPress.GetWinFormIsExsit('BATINPUT') then begin
                   SingleForm[8].ReLoadFirstImg(False) ;
                   SingleForm[8].ImageBmp.Visible:=True;
                  JudgeSelectCoal.Enabled :=False;
           end;


       3009: //  '���������ά��';
           if not MainCForm.Call_RockPress.GetWinFormIsExsit('EDITJINCHI') then begin
                   SingleForm[9].ReLoadFirstImg(False) ;
                   SingleForm[9].ImageBmp.Visible:=True;
                  JudgeSelectCoal.Enabled :=False;
           end;

       3010: //   '�������ѹ��ȷ�������';    OPENWORD
           if not MainCForm.UserWin.GetWinFormIsExsit('OPENWORD') then begin
                   SingleForm[10].ReLoadFirstImg(False) ;
                   SingleForm[10].ImageBmp.Visible:=True;
                  JudgeSelectCoal.Enabled :=False;
           end;
       3011: //  'Һѹ֧���Ƽ�ʱ��ɢ��ͼ';
          if not MainCForm.Call_RockPress.GetWinFormIsExsit('MOVEPOINT') then begin
               SingleForm[11].ReLoadFirstImg(False) ;
               SingleForm[11].ImageBmp.Visible:=True;
              JudgeSelectCoal.Enabled :=False;
          end;
       3012: // '�������������ѹ����ͼ';
            begin
               selectData.ClickPanel:=-2;
               SingleForm[12].ReLoadFirstImg(False) ;
               SingleForm[12].ImageBmp.Visible:=True;
               JudgeSelectCoal.Enabled :=False;
            end;
    end;


end;

procedure TMonitorForm.LoadCoalInformation;
var
  Re_str,Pic_Path,BaPath:string;
  s1,s2:Str_DT_array;
  C1,C2,i,MKid,CoalCount,MkTotalC:integer;
  DataType:string;
begin
   if not Public_Basic.ReadDataBaseType(DataType) then exit;
   Re_str:=strPas(MainCForm.UserWin.GetMeiKuangInFormation);
   S1:=Public_Basic.split(Re_str,';',C1);

    CoalCount:=0;
     for I := 0 to C1-1 do begin
         S2:=Public_Basic.split(s1[i],',',C2);
         if (C2>4) and (s2[0]<> '') then begin
            MKid:=Public_Basic.StrToInt_lu(s2[0]);
            if DataType='ACCESS' then   begin
               Pic_Path:=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\CoalBmp_'+IntToStr(Mkid)+'.BMP';
               if not  FileExists(Pic_Path)  then
                  Pic_Path:=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\DataBase_'+IntToStr(Mkid)+'.BMP';
            end else begin
                if s2[6]='1' then
                   Pic_Path:=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\DataBase_'+IntToStr(Mkid)+'.BMP';
            end;

            BaPath:=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\CoalBmp_0.BMP';

            AddCoalClass( s2[1],s2[2],s2[3],MKid,BaPath,Pic_Path,
                      Public_Basic.StrToDouble_Lu(s2[4]),
                      Public_Basic.StrToDouble_Lu(s2[5]));
            inc(CoalCount);
         end;
     end;

      //����һ���ص���Ϣ�������
     Pic_Path:=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\NextBmp.BMP';

//     AddOtherClassInformation(NextClass,'','���������һ��','',
//                       2212,Pic_Path,Pic_Path, 12, -12);
     // �Ѱٶȵ�ͼ��������
     Pic_Path:=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\MainBmp.BMP';
     BaPath:=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\MainBmp_0.BMP';


     AddOtherClassInformation(MapClass,'ȫ��ú���ѹ��ص�ͼ','-'+IntTostr(CoalCount)+'-ú������','',
                       2213,BaPath,Pic_Path, 13, -13);

     //��������û�����ݵĿհ׿�
     Pic_Path:=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\CoalBmp_0.BMP';

     MkTotalC:=(CoalCount-1) div 12  +1;
     for I := 1 to MkTotalC * 12 -CoalCount do begin   //[i]
       AddCoalClass( '���������','��'+IntTostr(i)+'������','',2100,Pic_Path,Pic_Path,
                      -1,
                      -1);

     end;

     SelectData.CoalInforLoaded:=True;


end;

procedure TMonitorForm.LoadUsedInformation;
begin
   SelectData.WholeScreenOrOneCol:=1;

   if SelectData.WholeScreenOrOneCol=1 then  begin
      if not SelectData.CoalInforLoaded then    LoadCoalInformation;
   end else if SelectData.WholeScreenOrOneCol=2 then begin
       if GetWorkFaceFisrtid(SelectData.MeiKuang_id) then begin
          IntoOneCoal(SelectData.MeiKuang_id,SelectData.workFace_id);
       end else begin
           SelectData.WholeScreenOrOneCol:=1;
       end;
   end;

  SelectData.WholeScreenOrOneCol:=Public_Basic.ReadDisplayWholeScreen;

end;

procedure TMonitorForm.MakeWindowsSingle(Single: integer);
begin
     if Single=0 then  begin
         BorderStyle:=BsSizeable;
         self.StatusBar1.Visible :=true;
         WindowState:= wsNormal;
     end else begin
         BorderStyle:=BsNone;
         self.StatusBar1.Visible :=False;
         WindowState:=wsMaximized;
     end;
end;

procedure TMonitorForm.MakeWorkTimerTimer(Sender: TObject);
var
  State:Boolean;
  Percent:integer;
begin
  {
     public_Basic.CanvasRotatedText(imag.Picture.Bitmap.Canvas ,
                    imag.Picture.Bitmap.Width div 2 -90 ,imag.Picture.Bitmap.Height div 2-10 , '����',
                    18,0,ClRed,'��������������');

  }
  State:=public_Basic.ReadMakeWordPercent(Percent) ;
  if State then    begin
     if WordTotalPercent<> Percent then  begin
         SingleForm[10].ReLoadFirstImg(False);
         public_Basic.CanvasRotatedText(SingleForm[10].ImageBmp.Picture.Bitmap.Canvas ,
                        SingleForm[10].ImageBmp.Picture.Bitmap.Width div 2 -100 ,
                        SingleForm[10].ImageBmp.Picture.Bitmap.Height div 2-10 , '����',
                        15,0,ClGreen,'�������ɿ�ѹ���桾'+IntTostr(Percent)+'%��...');
         WordTotalPercent:=Percent;
     end;
  end else begin
     MakeWorkTimer.Enabled :=False;
     WordTotalPercent:=0;
     SingleForm[10].ReLoadFirstImg(False);
     public_Basic.CanvasRotatedText(SingleForm[10].ImageBmp.Picture.Bitmap.Canvas ,
                    SingleForm[10].ImageBmp.Picture.Bitmap.Width div 2 -100 ,
                    SingleForm[10].ImageBmp.Picture.Bitmap.Height div 2-10 , '����',
                    15,0,ClGreen,'��ѹ�����������');
  end;

end;

procedure TMonitorForm.OnAccumulated(Sender: TOpenContourThread);
begin
   // �������߳�ʱ��
  // Ҫ���� UI ��Ҫ�� Synchorinize �Ѹ��µĲ���
  // �������߳�ʱ����ȥ���С�ע�����⣺��������
  TThread.Synchronize(nil,
    procedure
    begin
      // ����Ĵ��뱻�������߳�ʱ����ȥ�ˡ�
      MainCForm.Call_RockPress.SetOpenFormChangeParentPanel('CONTOUR',MonitorForm.Handle)  ;
    end);
  // Synchronize ��һ�������� nil
  // �ڶ���������һ���������� ʲô������������ �Ժ����ܵ���
end;

procedure TMonitorForm.OpenContourForm(Vis:boolean);
begin
      if (SelectData.workFace_First_id<>SelectData.workFace_id ) and
                            (SelectData.workFace_id >0)    then begin
          MainCForm.Call_RockPress.CloseActiveForm('All');
          ContourOpen:=False;
      end;

     if (MainCForm.Call_RockPress.GetWinFormIsExsit('CONTOUR')) and (ContourOpen) then  begin
         if Vis then  begin
             MainCForm.Call_RockPress.SetOpenFormChangeParentPanel('CONTOUR',Handle);
         end;
     end else begin
          MainCForm.Call_RockPress.CreateRockPressGraph(Handle,
                               '��ɽѹ���ۺϷ�������',Width,Height,1);
          if not Vis then
               MainCForm.Call_RockPress.CloseRockPressTool ;

          SelectData.workFace_First_id:=SelectData.workFace_id;
          ContourOpen:=true;
     end
end;

procedure TMonitorForm.PanelComponentClear;
var
  i,j:integer;
begin
     //������ҳ��
   try
    MainCForm.UserWin.CloseActiveForm('ALL');
    MainCForm.Call_RockPress.CloseActiveForm('All');
    MainCForm.CallPStope.CloseActiveForm('All');
    MapClass.ImageBmp.Visible :=true;

    for I := 0 to CoalNameCount-1 do
         CoalClass[i].ClearParent;
     //
     for I := 0 to 13 do
          SingleForm[i].ClearParent ;
    //
       MapClass.ClearParent ;
       NextClass.ClearParent ;
       ShowMapForm:=False;
   finally

   end;
  
end;

procedure TMonitorForm.Pop_ExitMonitorClick(Sender: TObject);
begin
   Close;
end;

procedure TMonitorForm.Pop_NextGroupClick(Sender: TObject);
begin
    if StartCoalId +12 < CoalNameCount then begin
       StartCoalId:=StartCoalId+12;
       //   DispStore:=not DispStore;
        DispLayScreen(StartCoalId);
        SaveMapToBmp;
    end;

end;

procedure TMonitorForm.Pop_OneCoalClick(Sender: TObject);
begin
   if pop_left_clickid>0 then  begin
     SelectData.WholeScreenOrOneCol:=2; //���嵽ú��
     SaveMapToBmp;
     DisLpayWholeCoalScreenGuld(pop_left_clickid,EXClassid);
   end;
end;

procedure TMonitorForm.Pop_PrevGroupClick(Sender: TObject);
begin
    if StartCoalId -12 >=0 then begin
       StartCoalId:=StartCoalId-12;
       //   DispStore:=not DispStore;
        DispLayScreen(StartCoalId);
        SaveMapToBmp;
    end;

end;

procedure TMonitorForm.Pop_RefBmpClick(Sender: TObject);
begin
  LoadUsedInformation;

end;

procedure TMonitorForm.Pop_ReturnClick(Sender: TObject);
begin
    SelectData.WholeScreenOrOneCol:=1; //���嵽ú��
    DisLpayWholeCoalScreenGuld(-1,-1);
end;

procedure TMonitorForm.Pop_SelgzmClick(Sender: TObject);
begin
   MainCForm.UserWin.CreateSelectedWorkFaceINFo(Handle,
                  '������ѧģ�ͽ��й�����ѡ��',width ,height,0);
end;

procedure TMonitorForm.ReadPublicUsedMkInfoFromFile(id:integer);
var
  Mid,Wid,ZDid:String;
begin
    if (id=1) and (SelectData.workFace_id>0) then
       SelectData.workFace_First_id:= SelectData.workFace_id;

    Public_Basic.ReadUsedMeiKuangInfo('UsedCoalInfo',Mid,   SelectData.MeiKuang_Name,
            Wid ,SelectData.WorkFace_Name,
            ZDid,SelectData.Drill_Name );
    SelectData.MeiKuang_id :=public_Basic.StrToInt_lu(Mid) ;

    if  id =1 then
      SelectData.workFace_id :=public_Basic.StrToInt_lu(Wid) ;
    SelectData.Drill_id :=public_Basic.StrToInt_lu(ZDid) ;

    SelectData.isUsedWorkFace:=False;

    if MainCForm.UserWin.verificationGzmLinkZk(SelectData.workFace_id,SelectData.Drill_id)  then   begin
          SelectData.isUsedWorkFace:=true;
          MainCForm.RefreshUsedInformation
    end;


end;

function TMonitorForm.ReturnFormCaption(id: integer): String;
begin
    Result:='δ����ҳ��';
    case id of
       0: //  ������ѡ��
          Result:='�ɳ��ϸ��Ҳ��˶�����չʾ';
       1: //
          Result:='�ɳ��ɶ������˶������˶�';
       2: //
          Result:='�ɳ����ʽṹ��Ϣչʾ';
       3: //
          Result:='�ɳ�֧��ѹ����άģ��չʾ';
       4: //
          Result:='Һѹ֧��ʵʱѹ������ͼ';
       5: //
          Result:='ʵʱѹ��������ά����ͼ';
       6: //
          Result:='Һѹ֧��ʵʱѹ��ͳ��ѧ����';
       7: //
          Result:='Һѹ֧��ʵʱѹ��ֱ��ͼ';
       8: //
          Result:='Һѹ֧��ʵʱ���ݵ������';
       9: //
          Result:='�����������Ϣά������';
       10: //
          Result:='�������ѹ��ȷ�������';
       11: //
          Result:='Һѹ֧���Ƽ�ʱ��ɢ��ͼ';
       12: //
          Result:='�������������ѹ����ͼ';
    end;

end;

function TMonitorForm.ReturnPanel(id: integer): TPanel;
begin

      if id=1  then  begin
         Result:=Panel1;
      end else if id=2  then  begin
         Result:=Panel2;
      end else if id=3  then  begin
         Result:=Panel3;
      end else if id=4  then  begin
         Result:=Panel4;
      end else if id=5  then  begin
         Result:=Panel5;
      end else if id=6 then  begin
         Result:=Panel6;
      end else if id=7  then  begin
         Result:=Panel7;
      end else if id=8  then  begin
         Result:=Panel8;
      end else if id=9  then  begin
         Result:=Panel9;
      end else if id=10  then  begin
         Result:=Panel10;
      end else if id=11  then  begin
         Result:=Panel11;
      end else if id=12  then  begin
         Result:=Panel12;
      end else  begin
         Result:=Panel13;
      end
end;

procedure TMonitorForm.SaveMapToBmp;
var
  pt1,pt2:TPoint;
  Pic_Path:string;
begin

   if (ShowMapForm) and (not MapSaveB) then  begin
       pt1:=MapClass.MapPanel.ClientToScreen(MapClass.MapPanel.BoundsRect.TopLeft);
       pt2:=MapClass.MapPanel.ClientToScreen(MapClass.MapPanel.BoundsRect.BottomRight) ;
       Pic_Path:=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\MainBmp.BMP';
       ScreenCap(pt1.x,pt1.Y ,pt2.X ,pt2.Y,Pic_Path);
       MapSaveB:=True;
   end;

end;

procedure TMonitorForm.SavePublicUsedMkInfoIntoFile;
begin
   Public_Basic.WriteUsedMeiKuanginfo('UsedCoalInfo',intToStr(SelectData.MeiKuang_id),
                '' ,intToStr(SelectData.workFace_id) ,'',
                intToStr(SelectData.Drill_id),''  );

end;

procedure TMonitorForm.ScreenCap(LeftPos, TopPos, RightPos, BottomPos: integer;
  pic_path: string);
var
    RectWidth,RectHeight:integer;
    SourceDC,DestDC,Bhandle:integer;
    Bitmap:TBitmap;
    Stream:TMemoryStream;
  begin
      RectWidth:=RightPos-LeftPos;
      RectHeight:=BottomPos-TopPos;
      SourceDC:=CreateDC('DISPLAY','','',nil);
      DestDC:=CreateCompatibleDC(SourceDC);
      Bhandle:=CreateCompatibleBitmap(SourceDC,
      RectWidth,RectHeight);
      SelectObject(DestDC,Bhandle);
      BitBlt(DestDC,0,0,RectWidth,RectHeight,SourceDC,
             LeftPos,TopPos,SRCCOPY);
      Bitmap:=TBitmap.Create;
      Bitmap.Handle:=BHandle;
      Stream := TMemoryStream.Create;
      Bitmap.SaveToStream(Stream);
      Stream.Free;
      try
        Bitmap.SaveToFile(pic_path);
      finally
        Bitmap.Free;
        DeleteDC(DestDC);
        ReleaseDC(Bhandle,SourceDC);
      end;

end;

procedure TMonitorForm.SetCloseQuery;
begin
   ExClickid:=-1;;
   ShowPuse:=False;
   DoubleClick:=False;
end;

procedure TMonitorForm.SetPanelPoistion(Rect1: TRect; col, Row: integer);
var
  Width_s,Heigth_s:integer;
  chlid_Width,Chlid_Heigth:integer;
  i,j:integer;
  RowTop,ColLeft:Integer;
  Col_N,Row_N:integer;
  ChartBh:integer;
begin
    width_s:=Rect1.Right -REct1.Left ;
    Heigth_s:=Rect1.Bottom -Rect1.Top ;
    chlid_width:=width_s div Col;
    Chlid_Heigth:=(Heigth_s) div Row;

  for I := 1 to  16 do   begin
       Row_N:=(i-1) div Col;
       col_N:=(i-1) mod Col;
       RowTop:=0+ Row_N* Chlid_Heigth ;
       colLeft:=0 + col_N*  chlid_width;
       if (i<=5)  then  begin
           ChartBh:=i;
       end else  if i=6 then  begin
          ChartBh:=13;
           ReturnPanel(ChartBh).Top :=RowTop ;
           ReturnPanel(ChartBh).Left :=ColLeft;
           ReturnPanel(ChartBh).Width :=Chlid_width*2;
           ReturnPanel(ChartBh).Height :=Chlid_Heigth *2;
           //ReturnChart(ChartBh).Title.Caption :=InttoStr(ChartBh);
           continue;
       end else  if (i=7) or (i=10) or (i=11)   then   begin
          continue;
       end else if (i=8) or (i=9) then begin
          ChartBh:=i-2;
       end else begin
          ChartBh:=i-4;
       end;
       ReturnPanel(ChartBh).Top :=RowTop ;
       ReturnPanel(ChartBh).Left :=ColLeft;
       ReturnPanel(ChartBh).Width :=Chlid_width;
       ReturnPanel(ChartBh).Height :=Chlid_Heigth;
      // ReturnChart(ChartBh).Title.Caption :=InttoStr(ChartBh);

   end;

end;



procedure TMonitorForm.ShowClickFromCommand(Vis: Boolean);
begin

end;

procedure TMonitorForm.Timer1Timer(Sender: TObject);
{
   1- 2999 Ϊ ú�������Ϣ�б�����

   3000- 4000 Ϊ����ú����Ϣҳ��

}
begin
   inc(staticTime);
   if staticTime > 10 then  ShowPuse:=true;

   if ExClickid <=0 then  exit;

   Timer1.Enabled:=False;

   if ExClickid=2212 then begin      // ��һ������
      if StartCoalId+11 < CoalNameCount then begin
         StartCoalId:=StartCoalId+11;
      end else begin
         StartCoalId:=CoalNameCount-11;
      end;
      DispStore:=not DispStore;
      DispLayScreen(StartCoalId);
      SaveMapToBmp;
   end;

   if ExClickid=2213 then begin    // �ѵ�ͼ������ʾ

       if not ShowMapForm then  begin
           MainCForm.UserWin.ShowMapForm(MapClass.MapPanel.Handle,'',MapClass.MapPanel.Width,MapClass.MapPanel.Height,1 );
           ShowMapForm:=true;
       end else begin
           MapClass.ImageBmp.Visible :=False;
           MapClass.MapPanel.Visible :=True;
           MainCForm.UserWin.SetMapAllMarker;
       end;

   end;


   if (ExClickid >0 )and (ExClickid< 2000) and (DoubleClick) then  begin   // ��������
      SelectData.WholeScreenOrOneCol:=2; //���嵽ú��
      SaveMapToBmp;
      DisLpayWholeCoalScreenGuld(ExClickid,EXClassid);
      DoubleClick:=False;
   end;

//   // ����ú������ ���ص���һ�����
//    if ExClickid=3888 then begin
//       SelectData.WholeScreenOrOneCol:=1; //���嵽ú��
//       DisLpayWholeCoalScreenGuld(-1,-1);
//    end;

    if (ExClickid >=3000 )and (ExClickid< 3020) and(DoubleClick) then  begin  //ִ�й���ģ��
        DoubleClick:=False;
        CallWorkFaceSingleFrom(ExClickid);
    end;

   Timer1.Enabled:=true;

   ExClickid:=-1;



end;

procedure TMonitorForm.WMDpiChanged(var Message: TMessage);
 {$IFDEF DELPHI_STYLE_SCALING}
  function FontHeightAtDpi(aDPI, aFontSize: integer): integer;
  var
    tmpCanvas: TCanvas;
  begin
    tmpCanvas := TCanvas.Create;
    try
      tmpCanvas.Handle := GetDC(0);
      tmpCanvas.Font.Assign(self.Font);
      tmpCanvas.Font.PixelsPerInch := aDPI; //must be set BEFORE size
      tmpCanvas.Font.size := aFontSize;
      result := tmpCanvas.TextHeight('0');
    finally
      tmpCanvas.free;
    end;
  end;
  {$ENDIF}

begin
  inherited;
  {$IFDEF DELPHI_STYLE_SCALING}
  ChangeScale(FontHeightAtDpi(LOWORD(Message.wParam), self.Font.Size), FontHeightAtDpi(self.PixelsPerInch, self.Font.Size));
  {$ELSE}
  ChangeScale(LOWORD(Message.wParam), self.PixelsPerInch);
  {$ENDIF}
  self.PixelsPerInch := LOWORD(Message.wParam);
end;

{ TCoalRec }

procedure TCoalRec.BmpDoubleClick(Sender: TObject);
begin
    if WholeOrOneCoal then begin
        ShowPuse:=False;
        ExClickid:=MKid;
        EXClassid:=Classid;
        staticTime:=1;
        DoubleClick:=true;
    end else begin
        ShowPuse:=False;
        ExClickid:=MKid;
        EXClassid:=Classid;
        staticTime:=1;
        DoubleClick:=true;
    end;
end;

procedure TCoalRec.BmpMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin
   if Button=mbRight then begin
       MonitorForm.DispLeftPop(MKid,MouseLeft,ScreenPt.X+x,ScreenPt.Y +y) ;
   end;
end;

procedure TCoalRec.BmpOnClick(Sender: TObject);
begin
     if WholeOrOneCoal then begin
         ShowPuse:=False;
         ExClickid:=MKid;
         EXClassid:=Classid;
         staticTime:=1;
     end else begin
         ShowPuse:=False;
         ExClickid:=MKid;
         EXClassid:=Classid;
         staticTime:=1;
     end;
end;

function TCoalRec.ChangeStretch(imag: Timage; pic_Path: string): Boolean;
var
  in_imge:Timage;
begin
    imag.Picture.Graphic:=nil;
    in_imge:=Timage.Create(nil);
    try
       in_imge.Picture.LoadFromFile(pic_Path);
       in_imge.Stretch:=true;
       imag.Canvas.StretchDraw(imag.ClientRect,in_imge.Picture.Graphic);

       if MKid=3000 then
          public_Basic.CanvasRotatedText(imag.Picture.Bitmap.Canvas ,
                    imag.Picture.Bitmap.Width div 2 -90 ,imag.Picture.Bitmap.Height div 2-10 , '����',
                    18,0,ClRed,'��������������');


    finally
       in_imge.Free;
    end;

end;

procedure TCoalRec.ClearParent;
begin
    LabelPanel.Parent:=nil;
    MapPanel.Parent:=nil;
    ImageBmp.Parent:=nil;
    shadowImg.Parent:=nil;
    innTime.Enabled :=False;
    ShowBmpTime.Enabled:=False;
    shadowImg.Visible:=False;
    BmpTime:=0;
end;

constructor TCoalRec.Create;
begin
    ImageBmp:=TImage.Create(nil);
    ImageBmp.OnClick:=BmpOnClick;
    ImageBmp.OnDblClick:=BmpDoubleClick;
    shadowImg:=TImage.Create(nil);
    shadowImg.Visible :=False;
    LabelPanel:=TPanel.Create(nil);
    MoveLabel:=TLabel.Create(nil);
    MoveLabel.Parent:=LabelPanel;
    LabelPanel.ParentBackground:=False;

    MapPanel:=TPanel.Create(nil);

    innTime:=TTimer.Create(nil);
    innTime.OnTimer:= OnTimer;
    innTime.Enabled :=False;

    ShowBmpTime:=TTimer.Create(nil);
    ShowBmpTime.OnTimer:=flickerOnTimer2;
    ShowBmpTime.Enabled :=False;
    //
    MouseLeft:=1;
    ImageBmp.OnMouseDown:=BmpMouseDown;

    BmpTime:=1;
end;

destructor TCoalRec.Destroy;
begin
    innTime.Enabled :=False;
    ShowBmpTime.Enabled :=False;
    MoveLabel.Left :=10;

   if assigned(ImageBmp) then
      FreeandNil(ImageBmp);
   if assigned(MoveLabel) then
      FreeandNil(MoveLabel);
   if assigned(LabelPanel) then
      FreeandNil(LabelPanel);
   if assigned(innTime) then
      FreeandNil(innTime);
   if assigned(shadowImg) then
      FreeandNil(shadowImg);
   if assigned(ShowBmpTime) then
      FreeandNil(ShowBmpTime);
   if assigned(MapPanel) then
      FreeandNil(MapPanel);
end;


procedure TCoalRec.flickerOnTimer2(Sender: TObject);
begin
   if ShowPuse then begin
        inc(BmpTime);
        if BmpTime > 120*10 then  begin
           Randomize;
           ShowBmpTime.Enabled :=false;
           ImageShowFrom(ImageBmp,shadowImg,random(6) mod 6);
           BmpTime:=1;
           ShowBmpTime.Enabled :=true;
        end;
   end;

end;

procedure TCoalRec.ImageShowFrom(img1, img2: TImage; Value: integer);
var
   w,h,i,j:integer;
   hdc1,hdc2: HDC;
   rect1,rect2,rect3: TRect;
begin
    w:= img1.Picture.Bitmap.Width ;
    h:= img1.Picture.Bitmap.Height;
    img2.Canvas.FillRect(img2.Canvas.ClipRect);
    img2.Visible :=true;
    hdc1:=img1.Canvas.Handle;
    hdc2:=img2.Canvas.Handle;

    case Value of
      1:   // ������
         for i:=0 to (w div 3) do   begin
            for j:=0 to 1 do  begin
             bitblt(hdc2,0,0,i,i,hdc1,w div 3-i,h div 3-i,srccopy);
             bitblt(hdc2,w div 3,0,w div 3,i,hdc1,w div 3,h div 3-i,srccopy);
             bitblt(hdc2,w-i,0,i,i,hdc1,2*w div 3,h div 3-i,srccopy);
             bitblt(hdc2,0,h div 3,i,h div 3,hdc1,w div 3-i,h div 3,srccopy);
             bitblt(hdc2,w-i,h div 3,i,h div 3,hdc1,2*w div 3,h div 3,srccopy);
             bitblt(hdc2,0,h-i,i,h div 3,hdc1,w div 3-i,2*h div 3,srccopy);
             bitblt(hdc2,w div 3,h-i,w div 3,h-i,hdc1,w div 3,2*h div 3,srccopy);
             bitblt(hdc2,w-i,h-i,i,i,hdc1,2*w div 3,2*h div 3,srccopy);
             bitblt(hdc2,w div 2-i div 2,h div 2-i div 2,i,i,hdc1,w div 2-i div 2,h div 2-i div 2,srccopy);
             sleep(5);
             img2.Refresh;

             if not ShowPuse then  begin
                img2.Visible :=False;
                exit;
             end;
            end;
          end;

      2: //
           for i:=0 to w do  begin
              for j:=0 to 1 do     begin
                bitblt(hdc2,0,0,i,h div 4,hdc1,w-i,0,srccopy);
                bitblt(hdc2,w-i,h div 4,i,h div 4,hdc1,0,h div 4,srccopy);
                bitblt(hdc2,0,h div 2,i,h div 4,hdc1,w-i,h div 2,srccopy);
                bitblt(hdc2,w-i,3*h div 4,i,h div 4,hdc1,0,3*h div 4,srccopy);
                sleep(5);
                img2.Refresh;
                if not ShowPuse then  begin
                   img2.Visible :=False;
                    exit;
                end;
              end;
            end;
      3://
            for i:=0 to (h div 2)+1 do    begin
              bitblt(hdc2,0,i,w,1,hdc1,0,i,srccopy);
              bitblt(hdc2,0,h-i,w,h,hdc1,0,h-i,srccopy);
              sleep(5);
              img2.Refresh;
              if not ShowPuse then  begin
                 img2.Visible :=False;
                  exit;
              end;
            end;
      4://
           for i:=0 to h do     begin
              for j:=0 to 1 do    begin
                bitblt(hdc2,0,0,w div 4,i,hdc1,0,h-i,srccopy);
                bitblt(hdc2,w div 4,h-i,w div 4,i,hdc1,w div 4,0,srccopy);
                bitblt(hdc2,w div 2,0,w div 4,i,hdc1,w div 2,w-i,srccopy);
                bitblt(hdc2,3*w div 4,h-i,w div 4,i,hdc1,3*w div 4,0,srccopy);
                sleep(5);
                img2.Refresh;
                if not ShowPuse then  begin
                   img2.Visible :=False;
                    exit;
                end;
              end;
           end;
      5: //
          for i:=0 to (w div 2)+1 do    begin
            bitblt(hdc2,i,0,1,h,hdc1,i,0,srccopy);
            bitblt(hdc2,w-i,0,w,h,hdc1,w-i,0,srccopy);
            sleep(5);
            img2.Refresh;
            if not ShowPuse then  begin
                 img2.Visible :=False;
                 exit;
            end;
          end;
    end;

     img2.Visible :=False;

end;

procedure TCoalRec.OnTimer(Sender: TObject);
begin
   if (MoveLabel.Left >-length(MoveLabel.Caption)*12 )  then begin
      MoveLabel.Left :=MoveLabel.Left-10;
   end else  begin
      MoveLabel.Left:=LabelPanel.Width;
   end;

end;



procedure TCoalRec.ReLoadFirstImg(First:Boolean);
begin
   if First then begin
      if  FileExists(BasicBmpName) then  begin
           ChangeStretch(ImageBmp,BasicBmpName);
       end else  if  FileExists(UseBmpName) then  begin
           ChangeStretch(ImageBmp,UseBmpName);
       end;
   end else begin
       if  FileExists(UseBmpName) then  begin
           ChangeStretch(ImageBmp,UseBmpName);
       end else if  FileExists(BasicBmpName) then  begin
           ChangeStretch(ImageBmp,BasicBmpName);
       end;
   end;
end;

procedure TCoalRec.SetOneCoalInfo(Panel: TPanel; Left_V: integer);
begin
     ParentPanel:=Panel;
     ImageBmp.Parent:=ParentPanel;
     shadowImg.Parent:=ParentPanel;

     LabelPanel.Parent:=ParentPanel;
     LabelPanel.Align :=AlBottom;
     LabelPanel.Color :=clBtnFace;
     LabelPanel.Height:=25;
     MoveLabel.Height :=23;

     MapPanel.Parent:=ParentPanel;
     MapPanel.Align :=AlClient;
     MapPanel.Width:=Panel.Width;
     MapPanel.Height:=Panel.Height-26;
     MapPanel.Visible:=False;


     MoveLabel.Caption :='��'+FormCaption+'��';
     MoveLabel.Font.Color:=clGrayText;

     MoveLabel.Font.Name:='����';
     MoveLabel.Font.Size:=12;
     MoveLabel.Left:=LabelPanel.Width-Left_V*24;
     MoveLabel.Font.Style:=MoveLabel.Font.Style + [fsBold] ;

     ImageBmp.Align :=AlClient;
     ImageBmp.Width:=Panel.Width;
     ImageBmp.Height:=Panel.Height-26;
     ImageBmp.Visible :=True;
     // ����ͼƬ
     ReLoadFirstImg(true);

     shadowImg.Align :=AlClient;
     shadowImg.Width:=Panel.Width;
     shadowImg.Height:=Panel.Height-26;
     shadowImg.Visible :=False;


     Panel.Refresh ;
     innTime.Interval:=400+10*Left_V;
     innTime.Enabled :=True;

     ScreenPt.x:= Panel.BoundsRect.Left+10;
     ScreenPt.Y:= Panel.BoundsRect.Top +10;

//     ShowBmpTime.Interval:=500+100*Left_V;
//     ShowBmpTime.Enabled :=true;


end;

procedure TCoalRec.SetParentPanel(Panel: TPanel;Left_V:integer);
begin
    if WholeOrOneCoal then begin
       SetWholeScreenInfo(Panel,Left_V);
    end else begin
       SetOneCoalInfo(Panel,Left_V);
    end;
    Panel.Refresh;
end;



procedure TCoalRec.SetWholeOrOne(Value: integer);
begin
    if Value=1 then  begin
       WholeOrOneCoal:=True;
    end else  begin
       WholeOrOneCoal:=False;
    end;
end;

procedure TCoalRec.SetWholeScreenInfo(Panel: TPanel; Left_V: integer);
begin
     ParentPanel:=Panel;
     ImageBmp.Parent:=ParentPanel;
     shadowImg.Parent:=ParentPanel;

     LabelPanel.Parent:=ParentPanel;
     LabelPanel.Align :=AlBottom;
     LabelPanel.Color :=clHighlight;
     LabelPanel.Height:=25;
     MoveLabel.Height :=23;

     MapPanel.Parent:=ParentPanel;
     MapPanel.Align :=AlClient;
     MapPanel.Width:=Panel.Width;
     MapPanel.Height:=Panel.Height-26;
     MapPanel.Visible:=False;

     if jingdu>0 then  begin
         MoveLabel.Caption :=Jituan +'��'+CoalName+'����ܽ�����';
         MoveLabel.Font.Color:=CLRed;
     end else begin
         MoveLabel.Caption :=Jituan +'��'+CoalName+'��';
         MoveLabel.Font.Color:=ClGreen;
     end;
     MoveLabel.Font.Name:='����';
     MoveLabel.Font.Size:=12;
     MoveLabel.Left:=LabelPanel.Width-Left_V*24;
     MoveLabel.Font.Style:=MoveLabel.Font.Style + [fsBold] ;

     ImageBmp.Align :=AlClient;
     ImageBmp.Width:=Panel.Width;
     ImageBmp.Height:=Panel.Height-26;
     ImageBmp.Visible :=true;
      // ����ͼƬ
     ReLoadFirstImg(False);


     shadowImg.Align :=AlClient;
     shadowImg.Width:=Panel.Width;
     shadowImg.Height:=Panel.Height-26;


     Panel.Refresh ;
     innTime.Interval:=400+10*Left_V;
     innTime.Enabled :=True;

     ShowBmpTime.Interval:=500+100*Left_V;
     ShowBmpTime.Enabled :=true;

     ScreenPt.x:= Panel.BoundsRect.Left+10;
     ScreenPt.Y:= Panel.BoundsRect.Top +10;

end;

{ TOpenContourThread }

constructor TOpenContourThread.Create(CreateSuspended: Boolean);
begin
    inherited;
  FEvent := TEvent.Create(nil, true, false, '');// Ĭ���� FEvent ���ź�
  FreeOnTerminate := true; // True�������ǣ������˳� Execute �󣬱����Զ��ͷš�
end;

destructor TOpenContourThread.Destroy;
begin
  FEvent.Free;
  inherited;
end;

procedure TOpenContourThread.Execute;
begin
  inherited;
      FEvent.WaitFor;
  // ��� FEvent ���ź�,��һֱ�ȡ�
  // ��� FEvent �ѱ��������źţ����˳� WaitFor �����������
  // ��������ʵ�����̵߳Ĺ����ܡ�
  // ������ָ�߳�ʱ�յĴ��룬ͣ���˵�ǰλ�ã����� FEvent.WaitFor ���λ�á�
  FEvent.ResetEvent; // ����ź�,�Ա���һ�μ�������
  while not Terminated do    begin
    OpenFrom;
    FEvent.WaitFor; // ͬ��
    FEvent.ResetEvent;
  end;

     //  ��������ɺ�,�͵���  OnAccumulated ֪ͨ������
//    if Assigned(OnAccumulated) then
//       OnAccumulated(self);
end;

procedure TOpenContourThread.OpenFrom;
begin
     if not inCallRock.GetWinFormIsExsit('CONTOUR') then  begin
         inCallRock.CreateRockPressGraph(EXHandle,
                                         '��ɽѹ���ۺϷ�������',0,0,3);
         inCallRock.CloseActiveForm('PRESSTOOL');
     end;
end;

procedure TOpenContourThread.StartThread;
begin
    FEvent.SetEvent;
end;

end.