unit UPressureGraph;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,Vcl.StdCtrls ,
  UMainDataModule,uDrawGraphClass, Vcl.Buttons, Vcl.CheckLst ,System.TypInfo,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart,
  VCLTee.TeeSurfa, Vcl.Menus, System.ImageList, Vcl.ImgList, Vcl.ToolWin,
  Vcl.Grids,Vcl.Clipbrd, VCLTee.TeeLegendPalette, VCLTee.TeePieTool,
  VCLTee.TeeTriSurface, VCLTee.TeePoin3, VCLTee.TeeTools, VCLTee.TeeDragPoint,
  VCLTee.Series,VCLTee.TeeMapSeries, Vcl.ExtDlgs,
  UMakeRuleClass
  ;

 type

  TDrawBmp_From = class(TForm)
    StatusBar1: TStatusBar;
    LeftPageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ChartPageControl: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    DrawGraph: TImage;
    TabSheet6: TTabSheet;
    GroupBox3: TGroupBox;
    RG_Yun_Main: TRadioGroup;
    RG_Graph_Main: TRadioGroup;
    GroupBox1: TGroupBox;
    CheckListBox_Support: TCheckListBox;
    GB_Graph_L: TGroupBox;
    CheckListBox_phase: TCheckListBox;
    GroupBox4: TGroupBox;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    Memo_info: TMemo;
    LeftVisiblePanel: TPanel;
    RG_Yun_DataType: TRadioGroup;
    GB_Graph_DataType: TGroupBox;
    CheckListBox_DataType: TCheckListBox;
    TabSheet7: TTabSheet;
    GroupBox6: TGroupBox;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    TreePopu: TPopupMenu;
    TreePop_Delete: TMenuItem;
    TreePop_Recall: TMenuItem;
    Main_PageControl: TPageControl;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    GB_DW: TGroupBox;
    Label3: TLabel;
    Label1: TLabel;
    Label45: TLabel;
    JITuanCombo: TComboBox;
    ComboKName: TComboBox;
    GzmCombo: TComboBox;
    PageControl4: TPageControl;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    RockDataGrid: TStringGrid;
    FootageGrid: TStringGrid;
    RockDataRightGrid: TStringGrid;
    FootageToolPanel: TPanel;
    GroupBox7: TGroupBox;
    Label9: TLabel;
    ComboFootSteps: TComboBox;
    Label10: TLabel;
    ComboBoxStepTime: TComboBox;
    Label11: TLabel;
    Label12: TLabel;
    PopMemu_Footage: TPopupMenu;
    Pop_Foot_oneday: TMenuItem;
    Pop_Foot_AddStep: TMenuItem;
    N4: TMenuItem;
    Pop_Foot_EditTime: TMenuItem;
    N6: TMenuItem;
    Pop_Foot_Update_PartData: TMenuItem;
    Pop_Foot_Update_allData: TMenuItem;
    N9: TMenuItem;
    Pop_Foot_Paste: TMenuItem;
    Pop_Foot_UpdateTime: TMenuItem;
    Label13: TLabel;
    Footsteps_L: TEdit;
    Label14: TLabel;
    Button6: TButton;
    Button7: TButton;
    N3: TMenuItem;
    Pop_Foot_Save: TMenuItem;
    Pop_Foot_Refresh: TMenuItem;
    Pop_Foot_InsertStep: TMenuItem;
    Pop_Foot_DeleteStep: TMenuItem;
    Pop_Foot_DeleteAll: TMenuItem;
    ImageList1: TImageList;
    Label15: TLabel;
    Edit_SupportNumber: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    Edit_interVal_support: TEdit;
    Label18: TLabel;
    Pop_Rock_Paste: TMenuItem;
    Pop_Rock_DeleteOne: TMenuItem;
    N10: TMenuItem;
    Pop_Rock_Save: TMenuItem;
    N12: TMenuItem;
    Pop_Rock_Refresh: TMenuItem;
    N14: TMenuItem;
    Pop_Rock_DeletaAll: TMenuItem;
    ScrollBar1: TScrollBar;
    N5: TMenuItem;
    Pop_Rock_Input_Memo: TMenuItem;
    Pop_Rock_Disp_Memo: TMenuItem;
    N7: TMenuItem;
    Label_DataPress_Unit: TLabel;
    N11: TMenuItem;
    Pop_Rock_Disp_50: TMenuItem;
    Pop_Rock_Disp_300: TMenuItem;
    Pop_Rock_Disp_All: TMenuItem;
    Panel_ProcessBar: TPanel;
    FirstPGBar: TProgressBar;
    SecondPGBar: TProgressBar;
    ColorDialog1: TColorDialog;
    ContourChart: TChart;
    ContourSeries: TContourSeries;
    ThreeDimContourChart: TChart;
    ContourChart_Cursor: TCursorTool;
    ContourPop_Main: TPopupMenu;
    ContourPop_LeftZoom: TMenuItem;
    N8: TMenuItem;
    ContourPop_loadData: TMenuItem;
    ContourPop_ChangUnit: TMenuItem;
    ContourPop_refreshchart: TMenuItem;
    N15: TMenuItem;
    ContourPop_Save_Bmp: TMenuItem;
    ContourPop_LeftTool: TMenuItem;
    N13: TMenuItem;
    ContourPop_RightTool: TMenuItem;
    contourPop_KYFX: TMenuItem;
    RightPageControl: TPageControl;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    GB_KYFX_Top: TGroupBox;
    GB_KYFX_Bottom: TGroupBox;
    GB_KY_Memo1: TMemo;
    ToolBar1: TToolBar;
    But_Kyfx_Start: TToolButton;
    But_Kyfx_FillMap: TToolButton;
    But_Kyfx_Depth_Fx: TToolButton;
    ToolButton3: TToolButton;
    But_Kyfx_Report: TToolButton;
    But_Kyfx_SaveBmp: TToolButton;
    Splitter1: TSplitter;
    GroupBox5: TGroupBox;
    DragPoint: TDragPointTool;
    TreeView1: TTreeView;
    ImageList2: TImageList;
    DragMark: TDragMarksTool;
    GB_ContourAxis: TGroupBox;
    Lab_Axis: TLabel;
    RG_XAxis: TRadioGroup;
    Edit_Axis: TEdit;
    ContourPop_Shizhi: TMenuItem;
    N16: TMenuItem;
    RightVisiblePanel: TPanel;
    GroupBox8: TGroupBox;
    Label_FillColor: TLabel;
    Label29: TLabel;
    Edit_Step_TranC: TEdit;
    Label31: TLabel;
    GroupBox9: TGroupBox;
    Button8: TButton;
    Button9: TButton;
    StepColorBox: TColorBox;
    RG_Step_Fill: TRadioGroup;
    Edit_Fill_Line_Wide: TEdit;
    RG_Step_Ground_Fill: TRadioGroup;
    Label27: TLabel;
    SelectedColorBox: TColorBox;
    LineSeries: TLineSeries;
    N17: TMenuItem;
    ContourPop_EditMap: TMenuItem;
    ContourPop_SaveEditMap: TMenuItem;
    ContourPop_UndoEdit: TMenuItem;
    N18: TMenuItem;
    contourPop_Disp_Step: TMenuItem;
    TabSheet14: TTabSheet;
    ContourPop_Delete: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    TreePop_Refresh: TMenuItem;
    PageControl_timeOrDao: TPageControl;
    TabSheet15: TTabSheet;
    TabSheet16: TTabSheet;
    GB_DateTime: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    StartDateTime: TDateTimePicker;
    StartEdit: TEdit;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    EndDateTime: TDateTimePicker;
    EndEdit: TEdit;
    BitBtn4: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox10: TGroupBox;
    Label32: TLabel;
    Label33: TLabel;
    Edit_StartDao: TEdit;
    Edit_EndDao: TEdit;
    BitBtn7: TBitBtn;
    Label34: TLabel;
    Label35: TLabel;
    RG_DaoOrFootage: TRadioGroup;
    TreePop_Start: TMenuItem;
    TreePop_Fill: TMenuItem;
    TreePop_depth: TMenuItem;
    TreePop_save: TMenuItem;
    TreePop_Report: TMenuItem;
    TreePop_Close: TMenuItem;
    N20: TMenuItem;
    GroupBox11: TGroupBox;
    Label37: TLabel;
    CB_PhaseNumber: TComboBox;
    StringGridPhase: TStringGrid;
    Label38: TLabel;
    PageCon_JudgeStep: TPageControl;
    TabSheet17: TTabSheet;
    TabSheet18: TTabSheet;
    Label20: TLabel;
    Edit_StartPt: TEdit;
    Lab_Unit1: TLabel;
    Label22: TLabel;
    ComboBox_KY_Lmd: TComboBox;
    Lab_Unit2: TLabel;
    Edit_EndPt: TEdit;
    Label21: TLabel;
    Label24: TLabel;
    Edit_Sup_Con: TEdit;
    Label28: TLabel;
    Edit_Foot_Con: TEdit;
    Label25: TLabel;
    Label36: TLabel;
    Label26: TLabel;
    Edit_Min_Pt: TEdit;
    Edit_MinQd: TEdit;
    Label23: TLabel;
    Lab_Unit3: TLabel;
    Button10: TButton;
    SavePictureDialog1: TSavePictureDialog;
    TabSheet19: TTabSheet;
    GroupBox2: TGroupBox;
    RG_Option_DispProDao: TRadioGroup;
    RG_Option_Forcase: TRadioGroup;
    RG_Option_DispSave_MidDao: TRadioGroup;
    RG_Option_QYorStep: TRadioGroup;
    Panel1: TPanel;
    RG_Print_Option: TRadioGroup;
    RG_Print_Disp: TRadioGroup;
    TopPanel: TPanel;
    PageControl_Result: TPageControl;
    TabSheet20: TTabSheet;
    TabSheet21: TTabSheet;
    TabSheet22: TTabSheet;
    TabSheet23: TTabSheet;
    GB_Result_Memo: TGroupBox;
    Memo_Result: TMemo;
    GroupBox13: TGroupBox;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    PopMenu_Result: TPopupMenu;
    ResultPop_SaveTxt: TMenuItem;
    N19: TMenuItem;
    ResultPop_SaveExcel: TMenuItem;
    N21: TMenuItem;
    ResultPop_OpenLefttool: TMenuItem;
    N23: TMenuItem;
    ResultPop_OpenRightTool: TMenuItem;
    StringGrid_Result: TStringGrid;
    SaveDialog1: TSaveDialog;
    Splitter2: TSplitter;
    N22: TMenuItem;
    ResultPop_Print_Phase: TMenuItem;
    ResultPop_Print_whole: TMenuItem;
    RG_JD_Basic: TRadioGroup;
    Label30: TLabel;
    Edit_JD_support: TEdit;
    Label39: TLabel;
    RG_JD_Time: TRadioGroup;
    N24: TMenuItem;
    Pop_Foot_Auto: TMenuItem;
    Pop_Foot_UpdateDao: TMenuItem;
    Pop_Rock_Auto: TMenuItem;
    RG_Rock_DataType: TRadioGroup;
    RockDataGrid_Edit: TStringGrid;
    PopupMenu_RockData: TPopupMenu;
    Pop_Rock_SaveExcel: TMenuItem;
    GB_Contour_Color: TGroupBox;
    Label19: TLabel;
    CB_Box_ColorGroup: TComboBox;
    StringGridColorGroup: TStringGrid;
    ColorGroupButton: TButton;
    Button1: TButton;
    RadioGroup_DownFootage: TRadioGroup;
    RG_Yun_Cycle: TRadioGroup;
    RadioGroup_UpperFootage: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure JITuanComboChange(Sender: TObject);
    procedure ComboKNameChange(Sender: TObject);
    procedure GzmComboChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure StartEditClick(Sender: TObject);
    procedure EndEditClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure RG_Yun_MainClick(Sender: TObject);
    procedure RG_Graph_MainClick(Sender: TObject);
    procedure CheckListBox_phaseClick(Sender: TObject);
    procedure CheckListBox_SupportClick(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure LeftVisiblePanelClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ChartYunGetAxisLabel(Sender: TChartAxis; Series: TChartSeries;
      ValueIndex: Integer; var LabelText: string);
    procedure ChartYunClick(Sender: TObject);
    procedure ChartYunExit(Sender: TObject);
    procedure ChartYunKeyPress(Sender: TObject; var Key: Char);
    procedure TwoDimCloudMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FootageGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FootageGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FootageGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Footsteps_LClick(Sender: TObject);
    procedure Footsteps_LKeyPress(Sender: TObject; var Key: Char);
    procedure Pop_Foot_onedayClick(Sender: TObject);
    procedure Pop_Foot_AddStepClick(Sender: TObject);
    procedure Pop_Foot_EditTimeClick(Sender: TObject);
    procedure Pop_Foot_InsertStepClick(Sender: TObject);
    procedure Pop_Foot_DeleteStepClick(Sender: TObject);
    procedure Pop_Foot_UpdateTimeClick(Sender: TObject);
    procedure Pop_Foot_PasteClick(Sender: TObject);
    procedure Pop_Foot_Update_PartDataClick(Sender: TObject);
    procedure Pop_Foot_Update_allDataClick(Sender: TObject);
    procedure Pop_Foot_SaveClick(Sender: TObject);
    procedure Pop_Foot_RefreshClick(Sender: TObject);
    procedure Pop_Foot_DeleteAllClick(Sender: TObject);
    procedure Edit_SupportNumberKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_interVal_supportKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_SupportNumberClick(Sender: TObject);
    procedure Edit_interVal_supportChange(Sender: TObject);
    procedure RockDataGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure RockDataRightGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure RockDataGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure RockDataGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ScrollBar1Change(Sender: TObject);
    procedure Pop_Rock_PasteClick(Sender: TObject);
    procedure Pop_Rock_Input_MemoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Pop_Rock_Disp_MemoClick(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure Pop_Rock_SaveClick(Sender: TObject);
    procedure Pop_Rock_Disp_50Click(Sender: TObject);
    procedure Pop_Rock_Disp_300Click(Sender: TObject);
    procedure Pop_Rock_Disp_AllClick(Sender: TObject);
    procedure Pop_Rock_DeletaAllClick(Sender: TObject);
    procedure Pop_Rock_RefreshClick(Sender: TObject);
    procedure Pop_Rock_DeleteOneClick(Sender: TObject);
    procedure Main_PageControlDrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
    procedure PageControl4DrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
    procedure LeftPageControlDrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
    procedure StringGridColorGroupDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure CB_Box_ColorGroupChange(Sender: TObject);
    procedure StringGridColorGroupSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure ColorGroupButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TwoDimChartResize(Sender: TObject);
    procedure ContourChartGetAxisLabel(Sender: TChartAxis; Series: TChartSeries;
      ValueIndex: Integer; var LabelText: string);
    procedure ContourChartMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ContourPop_loadDataClick(Sender: TObject);
    procedure ContourChartMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ContourPop_LeftZoomClick(Sender: TObject);
    procedure ContourPop_refreshchartClick(Sender: TObject);
    procedure EndDateTimeClick(Sender: TObject);
    procedure StartDateTimeClick(Sender: TObject);
    procedure ContourPop_LeftToolClick(Sender: TObject);
    procedure ContourPop_RightToolClick(Sender: TObject);
    procedure ContourPop_Ky_MainClick(Sender: TObject);
    procedure GB_KY_Memo1Click(Sender: TObject);
    procedure contourPop_KYFXClick(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure ContourPop_ChangUnitClick(Sender: TObject);
    procedure Edit_Foot_ConClick(Sender: TObject);
    procedure Edit_StartPtClick(Sender: TObject);
    procedure Edit_EndPtClick(Sender: TObject);
    procedure Edit_Sup_ConClick(Sender: TObject);
    procedure Edit_Min_PtClick(Sender: TObject);
    procedure Edit_StartPtKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_EndPtKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_Sup_ConKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_Foot_ConKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_Min_PtKeyPress(Sender: TObject; var Key: Char);
    procedure TreeView1Collapsed(Sender: TObject; Node: TTreeNode);
    procedure TreeView1Expanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure But_Kyfx_StartClick(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
    procedure RG_XAxisClick(Sender: TObject);
    procedure Edit_AxisKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_AxisClick(Sender: TObject);
    procedure EndEditKeyPress(Sender: TObject; var Key: Char);
    procedure StartEditKeyPress(Sender: TObject; var Key: Char);
    procedure ContourPop_ShizhiClick(Sender: TObject);
    procedure But_Kyfx_FillMapClick(Sender: TObject);
    procedure RightVisiblePanelClick(Sender: TObject);
    procedure Edit_Step_TranCClick(Sender: TObject);
    procedure RG_Step_FillClick(Sender: TObject);
    procedure Edit_Fill_Line_WideClick(Sender: TObject);
    procedure DragPointStartDrag(Sender: TDragPointTool; Index: Integer;
      var Start: Boolean);
    procedure DragPointEndDrag(Sender: TDragPointTool; Index: Integer);
    procedure ContourPop_SaveEditMapClick(Sender: TObject);
    procedure ContourPop_UndoEditClick(Sender: TObject);
    procedure ContourPop_EditMapClick(Sender: TObject);
    procedure contourPop_Disp_StepClick(Sender: TObject);
    procedure But_Kyfx_Depth_FxClick(Sender: TObject);
    procedure Memo_ResultClick(Sender: TObject);
    procedure ContourPop_DeleteClick(Sender: TObject);
    procedure TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TreePop_DeleteClick(Sender: TObject);
    procedure TreePop_RecallClick(Sender: TObject);
    procedure TreePop_RefreshClick(Sender: TObject);
    procedure Edit_StartDaoKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_EndDaoKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_StartDaoClick(Sender: TObject);
    procedure Edit_EndDaoClick(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure TreePop_CloseClick(Sender: TObject);
    procedure TreePop_FillClick(Sender: TObject);
    procedure TreePop_depthClick(Sender: TObject);
    procedure TreePop_saveClick(Sender: TObject);
    procedure TreePop_ReportClick(Sender: TObject);
    procedure CB_PhaseNumberChange(Sender: TObject);
    procedure ComboBox_KY_LmdChange(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure TabSheet17Show(Sender: TObject);
    procedure ContourPop_Save_BmpClick(Sender: TObject);
    procedure But_Kyfx_SaveBmpClick(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Memo_ResultMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid_ResultMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ResultPop_OpenLefttoolClick(Sender: TObject);
    procedure ResultPop_OpenRightToolClick(Sender: TObject);
    procedure ResultPop_SaveExcelClick(Sender: TObject);
    procedure ResultPop_SaveTxtClick(Sender: TObject);
    procedure ResultPop_Print_PhaseClick(Sender: TObject);
    procedure ResultPop_Print_wholeClick(Sender: TObject);
    procedure TabSheet20Resize(Sender: TObject);
    procedure ChartPageControlDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure PageControl_ResultDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure Edit_JD_supportClick(Sender: TObject);
    procedure RG_JD_BasicClick(Sender: TObject);
    procedure Pop_Foot_AutoClick(Sender: TObject);
    procedure Pop_Foot_UpdateDaoClick(Sender: TObject);
    procedure Pop_Rock_AutoClick(Sender: TObject);
    procedure RG_Rock_DataTypeClick(Sender: TObject);
    procedure Pop_Rock_SaveExcelClick(Sender: TObject);
    procedure RG_Yun_CycleClick(Sender: TObject);
  private
    { Private declarations     }
     FootStringGrid_SelectCol,FootStringGrid_SelectRow:integer;
     RockStringGrid_SelectCol,RockStringGrid_SelectRow:integer;
     DataPress_Unit_Flag:integer; // 1ΪMPa  2ΪBar
     SelectRockDataRecordNumber:String;// ��ѯ��¼ ������
     Mouse_x,Mouse_y:integer;
     MySqlDataSet1:TMyDataSet;
     MySqlDataSet2:TMyDataSet;
     MyCommand1:TMyCommand;
     DrawGzm:TDrawGrap;
     s_MinName,S_WorkFaceName:string;
     StringGroupColor:String;
     CurrentChart:String;
     SaveBmpPath:String; //ͼƬ�ļ������·��
     BasicJinDao:TBasicJinDao;
     //
     MapSeries:TMapSeries;
     TreeView_Stepid,TreeView_APolid:integer;

    procedure InitForm;      //��ʼ�����沿�ֹ���
    procedure RefreshForm; //ˢ���������������
    function  InitDateTimeFootage :Boolean;  //�ڹ�������ȷ��������½��еĳ�ʼ��
    procedure OptionTip(index:integer;Str:String);
    procedure AutoLoadcomboBox(MkName,WkName:string);
   //-----------------------
    procedure RefreshSize;     // ˢ�½��沼��
    function  GetDataClass:Boolean;    //��ȡ����ѡ����
    function  GetTimeAndFootage:Boolean; // ��ȡ��ʼʱ������ߵ� ѡ����
    procedure RefreshMemoInfo(Memo:TMemo);  // ˢ����Ϣ����
    procedure RefreshInputData; //��¼���������и���
    procedure RefreshFootageStringGrid;
    procedure RefreshRockPressStringGrid(Flag:string);
    procedure RefreshContourlegendPalette;
    function  GetBatInputDataMaxGenTime(Support:integer):TDateTime;
    Procedure FillBasicJinDao(B_JinDao:TBasicJinDao;Support:integer);
    procedure UpdateBatInputData; // �Ե�������ݽ��д���
    //---------------------------
    procedure InitStringGrid;//��ʼ��������e
    procedure InitFootageGrid; // ��ʼ���������ݱ�
    procedure InitRockDataGrid;// ��ʼ����ѹ����¼���
    procedure InitStringGridGroupColor;//��ʼ����ɫ�������
    procedure InitStringGridPhase;//��ʼ����ɫ�������
    procedure initInputRockPressData ;//��ʼ����ɽѹ��¼������
    procedure InitKyfxResultStringGrid;// ��ʼ����ѹ��ʾ�������
    function  ZoomRect(mRect: TRect; mZoom: Integer): TRect;// ���Ʊ�����
    //--------------------------
    procedure DispFootAgePopMumu(px,py,Col,Row:integer); //��ʾ�������ݿ�ݲ˵�
    procedure DispRockDataPopMumu(px,py,Col,Row:integer); //��ʾ��ѹ���ݿ�ݲ˵�
    procedure DispContourPopMemu(Px,Py:Integer;ChartName:string);  //��ʾ��ͼ���ƿ�ݲ˵�
    Procedure DispTreePop(Px,Py:Integer);//��ʾTreeView���ƿ�ݲ˵�
    procedure DispResultPop(Px,Py:integer;TP:String);// ��ʾResult ���ƵĹ�����
    //----------------------------

    procedure InsertNextDayFootage(StrGrid:TStringGrid;Row,dayOrstep:integer);
    function  GetFootStepCount:Integer; // ��ȡһ�������
    function  GetFootStepTime:double;overload;  // ��ȡ�������ʱ��  1��Ϊ 1
    function  GetFootStepTime(FistSt,SecondSt:String;Interval:integer):double;Overload; // ��ȡ�������ʱ��  1��Ϊ 1
    function  GetFootOneStepDis:double;  // ��ȡ�����������
    //---------------------------------
    procedure InserOneRecordToFootage(StrGrid:TstringGrid;Row:integer);  //����һ����¼
    procedure DeleteOnRecordToFootage(StrGrid:TstringGrid;Row:integer);  //ɾ��һ����¼
    procedure MoveStringGridRecord(StrGrid:TstringGrid;FRow,MRow:integer); //�ƶ�һ����¼������
    procedure UpdateFootageStringGridFromRow(StrGrid:TstringGrid;InserOrdelete:string;Row:integer);// �ӵ�ǰ�п�ʼ��������
    procedure UpdateTdateTimeFormCurrRow(StrGrid:TstringGrid;Row:integer);// �ӵ�ǰ�п�ʼ����ʱ��
    procedure CopyDataToStringGridFromPaste(StrGrid:TstringGrid;Col,Row,ColNumber:integer);  // �������ݽ���StringGrid
    function  UpdateShouDongInputFootae(StrGrid:TstringGrid;Row:integer;DownOrUp:string):integer;//�����յ�¼�����
    function  AutoUpdateFootage(StrGrid: TStringGrid;Row:integer):Boolean;
    //---------------------------
    procedure ChangePressDataUnit(Flag:integer);  // �������ݵ�λ
    function  SetAnalysisSenstive(Index:integer):Boolean;//ͨ��ѡ�����������ı��ж���ֵ
    procedure GetMyContourGroupColor(NumLevel:integer);
    procedure FillStringGridColorGroup(NumLevel:integer);
    procedure FillStringGridPhase(Number:integer);
    procedure SplitWorkFaceMemo1Text;
    procedure SplitWorkFaceMemo2Text;
    procedure SaveWorkFaceMemo1Text ;
    procedure SaveWorkFaceMemo2Text(lx:String) ; // Ӧ�û��߱���
    procedure splitStringGroupColor;
    procedure SplitStringGridPhase;
    function  MakeStringGroupColorToString:String;
    function  MakeStringGridPhaseToString:String;
    procedure DisPoseContourGroupColor;

    //---------------------------------------
    procedure setLeftToolVisible(Value:Boolean);   //��๤��������
    procedure SetRightToolVisible(Value:Boolean);  // �Ҳ๤��������
    procedure SetCusorShizhiVisible(Value:Boolean);// ʮ������ָʾ
    procedure SetContourSeriseZoomUsed(Value:Boolean);//�����������Ŵ���
    procedure SetOldStepVisible(Value:Boolean);//�����Ƿ���ʾ��ѹ����
    //-------------------------------------------------------------
    procedure RecallLoadDataToDataBase(Value:Boolean);//�����ݿ����¼�������
    // RockPreeKyfx
    procedure MainTreeView(TreeView: TTreeView;FromWhere:string);
    procedure ExtractDataFormSeries(TreeView: TTreeView;ParantNode:TTreeNode;Series:TContourSeries;
              DataType:integer);
    procedure RockPressDataAnalysis(Series:TContourSeries);
       //control Series Display
       {��ʾ�����ע}
    procedure DisplyMapSeries(series:TMapSeries;OldStep:TOldSteps;TranVis:Boolean;Color:TColor;LineWide:integer);
    procedure SetPolygenProperty(OneStep:TOldOneStep;CeatePoint:Boolean;
                  Apol:TTeePolygon;Tran:Boolean;MC:TColor;LineW:integer);
    procedure MapSeriesClick(Sender: TChartSeries; ValueIndex: Integer;
              Button: TMouseButton; Shift: TShiftState; X, Y: Integer) ;
    procedure MapSeriesDoubleClick(Sender: TChartSeries; ValueIndex: Integer;
              Button: TMouseButton; Shift: TShiftState; X, Y: Integer) ;
    //--------------------------------------------------
    //��ʼ���п�ѹ���ݷ�������������
    function  StartRockPressAnslysisBegin:Boolean;
    function  EditMapSeriesSteps(ApolId,StepClassId:integer):TEditMapSeriesRe;
    procedure ReModiFyStepOldClass(OldStep:TOldSteps;EditMapRec:TEditMapSeriesRe);
    //ˢ����ѹ�����ͼ�㺯��
    procedure RefreshOldStepAddToMapSeries(Visible:Boolean);
    function ContourChartSaveIntoBMP(Path:string):Boolean;
    function CreateSaveBmpPath:String; //��������ͼƬ���ļ�·��
    function GetContOurChartBmpFileName:String;  //��ȡcontourChar�����ļ����ļ���
    // ���ƿ�ѹ�������
    function SaveResultIntoFile(Memo1:TMemo;FileName:String):Boolean;
  public
     EXCaption:String; // �ⲿ�������ı���
    { Public declarations }
      procedure Return_CallEditDateTime(DTS:String);//�����޸�ʱ�����Ļص�����
      procedure Return_CallEditRockPressMemo(DTS:String);
      procedure RefreshMyCloudChart;
  end;

function CreateDraw_Pressure(AHandle:THandle;ACaption:string;Wid,Hi,Flag:integer):THandle;stdcall;

var
 DrawBmp_From: TDrawBmp_From;

implementation

{$R *.dfm}

uses uWinFrameClass, Lu_Public_BasicModual, PStope_GzmGuidClass,
  UEditFootageDateTime, UEditRockDataMemo;
function CreateDraw_Pressure(AHandle:THandle;ACaption:string;Wid,Hi,Flag:integer):THandle;stdcall;
{Flag 1 ����ά��  Flag 2 ��ѹ����ά��  3 ��ѹ���ݷ���}
begin
        if Assigned(DrawBmp_From) then  FreeAndNil(DrawBmp_From);
        Application.Handle :=AHandle;
        DrawBmp_From:=TDrawBmp_From.Create(Application);

         try
           with DrawBmp_From do begin
               EXCaption:=ACaption;
               WindowState:= wsMaximized;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

               Show;
               SetFocus;

               if Flag=1 then begin//  ά������
                  Main_PageControl.ActivePage:=Main_PageControl.Pages[0];
                  PageControl4.ActivePage:= TabSheet10;
                  Main_PageControl.Pages[1].TabVisible :=False;
               end else if Flag=2 then begin  // ��ѹ����
                  Main_PageControl.ActivePage:=Main_PageControl.Pages[0];
                  PageControl4.ActivePage:= TabSheet11;
                  Main_PageControl.Pages[1].TabVisible :=False;
               end else if Flag=3 then begin  // ��ѹ����
                  Main_PageControl.ActivePage:=Main_PageControl.Pages[1];
                //  Main_PageControl.Pages[0].TabVisible :=False;
               end;


                Result:=DrawBmp_From.Handle ;//����ֵ
          end ;
        except
           FreeAndNil(DrawBmp_From);
        end;


end;

{ TForm1 }

procedure TDrawBmp_From.AutoLoadcomboBox(MkName, WkName: string);
var
   s_temp:Str_DT_array;
   i,C1:integer;
begin
   if length(trim(WkName))=0 then  exit;
   if not DrawGzm.SelectMineAndWorkFaceBh(MkName, WkName) then   exit;
   //�ж��빤������ص����ݱ��Ƿ񴴽������û�д������ٴ˴���
   if not MainDataModule.IsExsitTableName('D_'+inttostr(DrawGzm.FGzm.Gzmbh)+'_BasicData') then begin
       MainDataModule.CreateTable('2',MainDataModule.DataType,inttostr(DrawGzm.FGzm.Gzmbh),'') ;
   end;

    //����JiTuancombo
     for I := 0 to self.JiTuanCombo.Items.Count -1  do
        begin
              s_temp:=Public_Basic.split(self.JiTuanCombo.Items.Strings[i] ,'_',C1);
                if s_temp[0]=IntToStr(DrawGzm.Jituan_id) then
                  begin
                   self.JiTuanCombo.ItemIndex :=i;
                   break;
                  end;
        end;
   // ���� ComboKName
    MainDataModule.MySQlFillComBox(MySqlDataSet1,ComboKName,'select * from KuangJingXinXiBiao  where Jituanid=' +
                  IntToStr(DrawGzm.Jituan_id)+' order by id ','id','MeiKuangMing','');

   //ComboKName
     for I := 0 to self.ComboKName.Items.Count -1  do
        begin
              s_temp:=Public_Basic.split(self.ComboKName.Items.Strings[i] ,'_',C1);
                if s_temp[0]=IntTostr(DrawGzm.Mk_id) then
                  begin
                   self.ComboKName.ItemIndex :=i;
                   break;
                  end;
        end;

   // ���� GzmCombo
    MainDataModule.MySQlFillComBox(MySqlDataSet1,GzmCombo,' select cqid,cqName from cqcsb where kid = ' + IntTostr(DrawGzm.Mk_id)  +
                                           ' order by cqid','cqid','cqName','');
    //GzmCombo
     for I := 0 to self.GzmCombo.Items.Count -1  do
        begin
              s_temp:=Public_Basic.split(self.GzmCombo.Items.Strings[i] ,'_',C1);
                if s_temp[0]=IntTostr(DrawGzm.FGzm.Gzmbh ) then
                  begin
                   self.GzmCombo.ItemIndex :=i;
                   break;
                  end;
        end;

     OptionTip(0,'�ԡ�'+DrawGzm.FGzm.S_Name+'�����ݽ��з���!');
     GB_dateTime.Enabled :=true;
end;

function TDrawBmp_From.AutoUpdateFootage(StrGrid: TStringGrid;Row:integer): Boolean;
var
  i:integer;
  sRow:Integer;
  EndTime:TDateTime;
  Sql,Strdt:string;
  Step_Footage:double;
  RecordCount,left_FootageCount,Right_FootageCount:Integer;
  Left_Sum_Footage,Right_SumFootage:Double;
begin
  if DrawGzm.FGzm.Gzmbh <0 then exit;

  for I := 2 to StrGrid.RowCount-1 do
       if Trim(StrGrid.Cells[0,i])='' then  begin
          sRow:=i-1;
          if i>2 then  begin
            EndTime:=StrToDateTime(Trim(StrGrid.Cells[1,i-1]),Public_Basic.FSetting);
            left_FootageCount:=public_Basic.StrToInt_lu(Trim(StrGrid.Cells[2,i-1]));
            Right_FootageCount:=public_Basic.StrToInt_lu(Trim(StrGrid.Cells[10,i-1]));
            Left_Sum_Footage:=public_Basic.StrToDouble_Lu(Trim(StrGrid.Cells[4,i-1]));
            Right_SumFootage:=public_Basic.StrToDouble_Lu(Trim(StrGrid.Cells[8,i-1]));
            RecordCount:=public_Basic.StrToInt_lu(Trim(StrGrid.Cells[0,i-1]));
          end else begin
            EndTime:=0;
            left_FootageCount:=0;
            Right_FootageCount:=0;
            Left_Sum_Footage:=0;
            Right_SumFootage:=0;
            RecordCount:=0;
          end;
          break;
       end;
  if i=StrGrid.RowCount then begin
     sRow:=StrGrid.RowCount-1;
  end;

   // �����ݿ�ѽ��߲����
   MySqlDataSet1.Close ;
   Step_Footage:=self.GetFootOneStepDis;
   Strdt:=Public_Basic.ReturnDateTimeString(MainDataModule.DataType ,EndTime);
   Sql:=' select endtime from  D_'+IntToStr(DrawGzm.FGzm.Gzmbh)+'_SupportMoveInfo ' +
        ' where supportbh =' + IntTostr(DrawGzm.FGzm.RockPressAnalysis.JinDao_Support) + ' and  EndTime > ' + Strdt  +
        ' order by endtime ';
   MySqlDataSet1.CommandText :=sql;
   try
     if MySqlDataSet1.Open  then
       while not MySqlDataSet1.Eof  do begin
          inc(sRow);
          if StrGrid.RowCount <=sRow+1 then  StrGrid.RowCount:=  sRow+2;
          RecordCount:=RecordCount+1;
          StrGrid.Cells[0,SRow]:= IntToStr(RecordCount);
          StrGrid.Cells[1,SRow]:= FormatDateTime('yyyy-mm-dd HH:nn:ss',MySqlDataSet1.FieldByName('endtime').AsDateTime);
          left_FootageCount:=left_FootageCount+1;
          StrGrid.Cells[2,SRow]:= IntToStr(left_FootageCount);
          StrGrid.Cells[3,SRow]:= FormatFloat('0.000',Step_Footage);
          Left_Sum_Footage:=Left_Sum_Footage+Step_Footage;
          StrGrid.Cells[4,SRow]:= FormatFloat('0.00',Left_Sum_Footage);
          //
          Right_SumFootage:=Right_SumFootage+Step_Footage;
          StrGrid.Cells[8,SRow]:= FormatFloat('0.00',Right_SumFootage);
          StrGrid.Cells[9,SRow]:= FormatFloat('0.000',Step_Footage);
          Right_FootageCount:=Right_FootageCount+1;
          StrGrid.Cells[10,SRow]:= IntToStr(Right_FootageCount);
          MySqlDataSet1.Next ;
       end;
   finally
      MySqlDataSet1.Close ;
   end;
   {



   for I := 1 to StepCount do   begin
      if StepTime*i>=1 then break;
      NDataTime:=NDataTime+StepTime;
      SRow:=SRow+1;
      if StrGrid.RowCount <=sRow+1 then  StrGrid.RowCount:=  SRow+2;
      RecordCount:=RecordCount+1;
      StrGrid.Cells[0,SRow]:= IntToStr(RecordCount);
      StrGrid.Cells[1,SRow]:= FormatDateTime('yyyy-mm-dd HH:nn:ss',NDataTime);
      left_FootageCount:=left_FootageCount+1;
      StrGrid.Cells[2,SRow]:= IntToStr(left_FootageCount);
      StrGrid.Cells[3,SRow]:= FormatFloat('0.000',Step_Footage);
      Left_Sum_Footage:=Left_Sum_Footage+Step_Footage;
      StrGrid.Cells[4,SRow]:= FormatFloat('0.00',Left_Sum_Footage);
      //
      Right_SumFootage:=Right_SumFootage+Step_Footage;
      StrGrid.Cells[8,SRow]:= FormatFloat('0.00',Right_SumFootage);
      StrGrid.Cells[9,SRow]:= FormatFloat('0.000',Step_Footage);
      Right_FootageCount:=Right_FootageCount+1;
      StrGrid.Cells[10,SRow]:= IntToStr(Right_FootageCount);
   end;

   }
end;

procedure TDrawBmp_From.BitBtn1Click(Sender: TObject);
begin
    StartEdit.Text:=FormatFloat('0.00',DrawGzm.DatetimeToFootage(StartDateTime.DateTime,'Null') );
    RecallLoadDataToDataBase(true);
end;

procedure TDrawBmp_From.BitBtn2Click(Sender: TObject);
begin
   if length(trim(EndEdit.Text )) <1 then  exit;
     EndDateTime.DateTime := DrawGzm.FootageToDatetime(Public_Basic.StrTodouble_lu(EndEdit.Text),'NUll');
    RecallLoadDataToDataBase(true);
end;

procedure TDrawBmp_From.BitBtn3Click(Sender: TObject);
begin
  if length(trim(StartEdit.Text )) <1 then  exit;
     startDateTime.DateTime := DrawGzm.FootageToDatetime(Public_Basic.StrTodouble_lu(StartEdit.Text),'NUll');
   RecallLoadDataToDataBase(true);
end;

procedure TDrawBmp_From.BitBtn4Click(Sender: TObject);
begin
   EndEdit.Text:=FormatFloat('0.00',DrawGzm.DatetimeToFootage(EndDateTime.DateTime ,'NUll' ));
   RecallLoadDataToDataBase(true);
end;

procedure TDrawBmp_From.BitBtn5Click(Sender: TObject);
begin
     RefreshInputData;
end;

procedure TDrawBmp_From.BitBtn7Click(Sender: TObject);
var
  maxD,MinD:integer;
begin
   MinD:=Public_Basic.StrToInt_lu(Trim(Edit_StartDao.Text ));
   maxD:=Public_Basic.StrToInt_lu(Trim(Edit_EndDao.Text ));

   if maxD>0 then  DrawGzm.DataTimeAndFootAge.Graph_MaxDao:=MaxD;
   if MinD>=0 then  DrawGzm.DataTimeAndFootAge.Graph_MinDao:=MinD;
    StartDateTime.DateTime :=DrawGzm.FGzm.ReturnDataTimeFromDao(DrawGzm.DataTimeAndFootAge.Graph_MinDao);
    EndDateTime.DateTime:= DrawGzm.FGzm.ReturnDataTimeFromDao(DrawGzm.DataTimeAndFootAge.Graph_MaxDao);
    {�ѽ�����Ϣ�������}
    StartEdit.Text:=FormatFloat('0.00',DrawGzm.DatetimeToFootage(StartDateTime.DateTime,'NUll' ) );
    EndEdit.Text:=FormatFloat('0.00',DrawGzm.DatetimeToFootage(EndDateTime.DateTime,'NUll' ) );
    RecallLoadDataToDataBase(true);
end;

procedure TDrawBmp_From.Button10Click(Sender: TObject);
begin
   SplitWorkFaceMemo2Text;

end;

procedure TDrawBmp_From.Button1Click(Sender: TObject);
begin
    FillStringGridColorGroup(DrawGzm.MyContourColor_NumLevel);
    StringGridColorGroup.Repaint;
end;

procedure TDrawBmp_From.Button2Click(Sender: TObject);
begin
   ThreeDimContourChart.View3DOptions.Rotation :=  ThreeDimContourChart.View3DOptions.Rotation-10;
end;

procedure TDrawBmp_From.Button3Click(Sender: TObject);
begin
  ThreeDimContourChart.View3DOptions.Rotation :=  ThreeDimContourChart.View3DOptions.Rotation+10;
  ThreeDimContourChart.SetFocus ;
  ThreeDimContourChart.Refresh;
end;

procedure TDrawBmp_From.Button4Click(Sender: TObject);
begin
    if ThreeDimContourChart.View3DOptions.Perspective<=85 then
       ThreeDimContourChart.View3DOptions.Perspective:= ThreeDimContourChart.View3DOptions.Perspective+5;
end;

procedure TDrawBmp_From.Button5Click(Sender: TObject);
begin
   if ThreeDimContourChart.View3DOptions.Perspective>=5 then
       ThreeDimContourChart.View3DOptions.Perspective:= ThreeDimContourChart.View3DOptions.Perspective-5;
end;

procedure TDrawBmp_From.Button6Click(Sender: TObject);
begin
   SaveWorkFaceMemo1Text;


end;

procedure TDrawBmp_From.Button7Click(Sender: TObject);
begin
   SplitWorkFaceMemo1Text;
end;

procedure TDrawBmp_From.Button8Click(Sender: TObject);
begin
    //�����ֵѹ��ֵ������
    SaveWorkFaceMemo2Text('');
    //RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
    // ˢ������ͼ��
    StartRockPressAnslysisBegin;
end;

procedure TDrawBmp_From.Button9Click(Sender: TObject);
begin
  SaveWorkFaceMemo2Text('save');
end;

procedure TDrawBmp_From.MainTreeView(TreeView: TTreeView;FromWhere:string);
 var
  strcon: String;
  RecData: PMyRec;
  xNode,xNodeJing:TTreeNode;
  i,j,k:integer;
begin
        //��ͼ��ʼ��
    TreeView.Items.Clear;
     //
    New(RecData);
    RecData^.BName:='-1';
    RecData^.DName:='ROOT';
    RecData^.XHeight:='-1';
    xNode:=TreeView.Items.AddObject(nil,'�Ѿ��洢����ѹ��Ϣ',RecData);
    Xnode.ImageIndex:=0;
      ExtractDataFormSeries(TreeView,xNode,ContourSeries,1);

    New(RecData);
    RecData^.BName:='-1';
    RecData^.DName:='ROOT';
    RecData^.XHeight:='-1';
    xNode:=TreeView.Items.AddObject(nil,'δ�洢����ѹ��Ϣ',RecData);
    Xnode.ImageIndex:=0;
       Xnode.Expand(true);
       ExtractDataFormSeries(TreeView,xNode,ContourSeries,-1);





end;

function TDrawBmp_From.MakeStringGridPhaseToString: String;
var
  s_Value:string;
  i,Col,Row:integer;
begin
    if DrawGzm.Auto_Judge_OldStep.PhaseNumber  < 3 then begin
      Result:='';
      exit;
    end;

    s_Value:='';
    s_Value:=s_Value+IntTostr(DrawGzm.Auto_Judge_OldStep.PhaseNumber) +';';
    for I := 0 to DrawGzm.Auto_Judge_OldStep.PhaseNumber -1 do begin
        if i<4 then begin
           Row:=i+1  ;
           Col:=1;
        end else begin
           Row:=i-3;
           Col:=4;
        end;
        if (Public_Basic.StrToInt_lu(StringGridPhase.Cells[Col,Row]) =0   )  or
           (Public_Basic.StrToInt_lu(StringGridPhase.Cells[Col+1,Row]) =0   )
        then  begin
            Result:='';  exit;
        end;
        s_Value:=s_Value+StringGridPhase.Cells[Col,Row]+ ',' +
                    StringGridPhase.Cells[Col+1,Row]+ ';';
    end;
    Result:=S_Value;

end;

function TDrawBmp_From.MakeStringGroupColorToString: String;
var
  s_Value:string;
  i,UPValue,temp_Int:integer;
  proValue:integer;
begin
    if DrawGzm.MyContourColor_NumLevel < 1 then begin
      Result:='';
      exit;
    end;

    s_Value:='';
    s_Value:=s_Value+IntTostr(DrawGzm.MyContourColor_NumLevel) +';';
    proValue:=0;
    for I := 0 to DrawGzm.MyContourColor_NumLevel -1 do begin
        //��ֹ���ݳ���   �����������һ����ֵ�ڴ�
        if DataPress_Unit_Flag =2 then
             UPValue:=DrawGzm.MyContourColor[i].UpToValue*10;

        if i<5 then  begin
          temp_Int:=Public_Basic.StrToInt_lu(StringGridColorGroup.Cells[2,i+1]);
          if temp_Int>0 then UPValue:= temp_Int;
        end else begin
          temp_Int:=Public_Basic.StrToInt_lu(StringGridColorGroup.Cells[6,i-4]);
          if temp_Int>0 then UPValue:= temp_Int;
        end;

        if DataPress_Unit_Flag =2 then begin
           UPValue:=trunc(UPValue/10);
        end;
        //��ֹ�����߼��ʹ���
        if UPValue<proValue then  UPValue:=ProValue+5;

        s_Value:=s_Value+IntToStr(UPValue)+ ',' +
                 IntToStr(DrawGzm.MyContourColor[i].ContourColor)+ ';';
         //��ֹ�����߼��ʹ���
        ProValue:=UPValue;
    end;
    Result:=S_Value;
end;

procedure TDrawBmp_From.MapSeriesClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if Button =mbLeft then  begin
     DrawGzm.EditMapPoint.Apol :=ValueIndex;
     DrawGzm.MapSeriesEditState:=2;
   end;

end;

procedure TDrawBmp_From.MapSeriesDoubleClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   pt:TPoint;
begin
   if Button =mbLeft then  begin
//      ContourChart.ScrollMouseButton:=mbMiddle;
       //���ı༭״̬
      DrawGzm.EditMapPoint:=EditMapSeriesSteps(ValueIndex,-1);
//      ContourChart.ScrollMouseButton:=mbLeft;
   end;
end;

procedure TDrawBmp_From.Memo_ResultClick(Sender: TObject);
begin
   Memo_Result.SetFocus;
end;

procedure TDrawBmp_From.Memo_ResultMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt:Tpoint;
begin
   if Button=mbRight then begin
      pt:= self.Memo_Result.ClientToScreen(Point(0,0));
      DispResultPop (pt.X+x,pt.Y +y,'Memo');
   end;


end;

procedure TDrawBmp_From.MoveStringGridRecord(StrGrid: TstringGrid; FRow,
  MRow: integer);
var
   i:integer;
begin
    for I := 0 to StrGrid.ColCount -1 do
        StrGrid.Cells[i,MRow]:= StrGrid.Cells[i,FRow];

end;

procedure TDrawBmp_From.N7Click(Sender: TObject);
begin
  if DataPress_Unit_Flag=1 then  begin
     DataPress_Unit_Flag:=2;
  end else if DataPress_Unit_Flag=2 then   begin
     DataPress_Unit_Flag:=1;
  end;

    ChangePressDataUnit(DataPress_Unit_Flag);
end;

procedure TDrawBmp_From.ContourPop_LeftToolClick(Sender: TObject);
begin
    setLeftToolVisible(not leftPageControl.Visible);

end;

procedure TDrawBmp_From.ContourPop_Ky_MainClick(Sender: TObject);
begin
//    SetRightKyffVisible(true);
//   SetProcegressBarVisual(true,100,100);
//   StepProcegressBar(10,0);
   RockPressDataAnalysis(self.ContourSeries);


end;

procedure TDrawBmp_From.ContourPop_LeftZoomClick(Sender: TObject);
begin
  SetContourSeriseZoomUsed(False);
end;

procedure TDrawBmp_From.ContourPop_loadDataClick(Sender: TObject);
begin
   RefreshInputData ;
   //��ȡ�ֹ�¼������
   DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,true,100,100);
   DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
   if RG_DaoOrFootage.ItemIndex =0 then  begin //�Խ���Ϊ�����в�ѯ
      if not  DrawGzm.GetManualInputPressData(intToStr(DrawGzm.FGzm.Gzmbh),
                   DrawGzm.DataTimeAndFootAge.Graph_MinDao, DrawGzm.DataTimeAndFootAge.Graph_MaxDao,SecondPGBar) then
           exit;
   end else begin
      if not  DrawGzm.GetManualInputPressData(intToStr(DrawGzm.FGzm.Gzmbh),
                   DrawGzm.DataTimeAndFootAge.StartTime, DrawGzm.DataTimeAndFootAge.EndTime,SecondPGBar) then
           exit;
   end;

//   //����ѭ������
//   if not  DrawGzm.GetCycleData(intToStr(DrawGzm.FGzm.Gzmbh),
//              GetEnumName(TypeInfo(TSupportDataType),ord(DrawGzm.CloudClass.Yuntu_DataType  )),
//              DrawGzm.DataTimeAndFootAge.StartTime, DrawGzm.DataTimeAndFootAge.EndTime,SecondPB) then
//           exit;

//   //���Ҵ����������
//   if not  DrawGzm.GetThirdDPThreeDimData (intToStr(DrawGzm.FGzm.Gzmbh),
//              GetEnumName(TypeInfo(TSupportDataType),ord(DrawGzm.CloudClass.Yuntu_DataType  )),
//              DrawGzm.DataTimeAndFootAge.StartTime, DrawGzm.DataTimeAndFootAge.EndTime,SecondPB) then
//           exit;

   // ������ͼ
     DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,False,0,0);

    //��֪��Ϊʲô����Ҫˢ������
    RefreshMyCloudChart ;
    //RefreshMyCloudChart;
    // ���ư�ť
    ContourPop_loadData.Enabled:=False;
    DrawGzm.MapSeriesEditState:=1;
    ChartPageControl.ActivePage:=ChartPageControl.Pages[0];
end;

procedure TDrawBmp_From.ContourPop_refreshchartClick(Sender: TObject);
begin
   RefreshMyCloudChart;
   //RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
   //����������ͼ
   if DrawGzm.CloudClass.OldStepDisplay then
       StartRockPressAnslysisBegin;
   // ������ѹ���� �ļ���
   if  DrawGzm.Auto_Judge_OldStep.isCalComeStep  then  begin
       InitKyfxResultStringGrid;
       DrawGzm.CalComeStepAndPrintToMemo(Memo_Result,StringGrid_Result);
   end;
end;

procedure TDrawBmp_From.ContourPop_RightToolClick(Sender: TObject);
begin
   SetRightToolVisible(not RightPageControl.Visible);

end;

procedure TDrawBmp_From.ContourPop_SaveEditMapClick(Sender: TObject);
begin
    ReModiFyStepOldClass(DrawGzm.Auto_Judge_OldStep,DrawGzm.EditMapPoint);
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TDrawBmp_From.ContourPop_Save_BmpClick(Sender: TObject);
begin
  SavePictureDialog1.Execute ;
  ContourChartSaveIntoBMP(SavePictureDialog1.FileName);
end;

procedure TDrawBmp_From.ContourPop_ShizhiClick(Sender: TObject);
begin
   SetCusorShizhiVisible(not ContourChart_Cursor.Visible);
end;



procedure TDrawBmp_From.ContourPop_UndoEditClick(Sender: TObject);
begin
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TDrawBmp_From.UpdateBatInputData;
var
  i,Sup:integer;
  sql1,sql2,Strdt:String;
  MaxTime:TdateTime;
  JinDao,SupportBh:integer;
  Data0,Data1,Data2,Data3,Data4:double;
begin

   //�� ������
   DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,true,100,100);
   DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
   Sup:= DrawGzm.FGzm.RockPressAnalysis.ManulInput_Interval_support;
   while Sup<=DrawGzm.FGzm.SupEndNumber  do  begin
      DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
      Data0:=0;
      // ��� ������
      FillBasicJinDao(BasicJinDao,Sup);
      for I := 0 to BasicJinDao.Count-1 do   begin
         if (i>1) and (Data0<1) then  break;
         DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,0,20);
         Strdt:=Public_Basic.ReturnDateTimeString(MainDataModule.DataType ,BasicJinDao.ArrayBasicJinDao[i].ShotTime);
         Sql1:=' select * from  D_'+IntToStr(DrawGzm.FGzm.Gzmbh)+'_SupportMoveInfo ' +
               ' where supportbh >=' + IntTostr(Sup) + ' and supportbh < '+IntTostr(Sup+DrawGzm.FGzm.RockPressAnalysis.ManulInput_Interval_support)  +
               ' and  EndTime >= ' + Strdt + ' and StartTime <= ' +Strdt;
         MySqlDataSet1.Close ;
         MySqlDataSet1.CommandText :=sql1;
         try
         if MySqlDataSet1.Open  then
           if MySqlDataSet1.RecordCount >0 then   begin
              MySqlDataSet1.First ;
              Data0:=MySqlDataSet1.FieldByName('Max_Value').AsFloat;
              Data1:=MySqlDataSet1.FieldByName('AGVData').AsFloat;
              Data2:=MySqlDataSet1.FieldByName('BeforeMoveValue').AsFloat;
              Data3:=MySqlDataSet1.FieldByName('SameTimeValue').AsFloat;
              Data4:=MySqlDataSet1.FieldByName('SupportStartPress').AsFloat;
           end;
         finally
            if Data0>0 then
              DrawGzm.FGzm.SaveMultPressDataToDAteBase(
                                          FormatdateTime('yyyy-mm-dd HH:NN:SS',BasicJinDao.ArrayBasicJinDao[i].ShotTime) ,
                                          BasicJinDao.ArrayBasicJinDao[i].Daoshu,
                                          Sup,
                                          Data0,Data1,Data2,Data3,Data4,0,''
                                          ) ;
            MySqlDataSet1.Close ;
         end;


      end;

      Sup:=Sup+DrawGzm.FGzm.RockPressAnalysis.ManulInput_Interval_support;
   end;
   // �رս�����
   DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,false,0,0);
end;

procedure TDrawBmp_From.UpdateFootageStringGridFromRow(StrGrid: TstringGrid;
  InserOrdelete:string;Row: integer);
var
   i:integer;
   StepTime,Step_L:double;
begin
   if Row <2 then  exit;
   for I := Row to StrGrid.RowCount -2  do begin

      // ��0���ۼӸ���         ���
        if(i=2) then  begin
           StrGrid.Cells[0,i]:= '1';
        end else begin
           StrGrid.Cells[0,i]:= IntTostr(Public_Basic.StrToInt_lu(StrGrid.Cells[0,i-1])+1);
        end;

      //��1 �� ȡ ʱ�� ��ֵ ����  ʱ��
       if (InserOrdelete='Insert') and (i=Row)  then  begin //ֻ�в��� ��ǰ���ڸı�ʱ�� ����������ı�ʱ��
          if Trim(StrGrid.Cells[1,i+1])='' then  begin
             StepTime:=self.GetFootStepTime;
          end else begin
              StepTime:=self.GetFootStepTime(Trim(StrGrid.Cells[1,i-1]),Trim(StrGrid.Cells[1,i+1]),2);
          end;
          StrGrid.Cells[1,i]:=  FormatDateTime('yyyy-mm-dd HH:nn:ss',StrToDateTime(Trim(StrGrid.Cells[1,i-1]),Public_Basic.FSetting)+StepTime );
       end;
        // ��2���ۼӸ���    left ������
        if i=2 then  begin
            StrGrid.Cells[2,i]:='1';
        end else begin
            StrGrid.Cells[2,i]:= IntTostr(Public_Basic.StrToInt_lu(StrGrid.Cells[2,i-1])+1);
        end;

       //  //��ȡ��3 �� ��ֵ   left ����
        if (Trim(StrGrid.Cells[3,i-1])='') or (i=2) then  begin
           Step_L:=self.GetFootOneStepDis;
        end else   begin
           Step_L:=Public_Basic.StrToDouble_Lu(Trim(StrGrid.Cells[3,i-1]));
        end;

        if Trim(StrGrid.Cells[5,i])='' then
           StrGrid.Cells[3,i]:=FormatFloat('0.000',Step_L);

        //  //��4 �� ȡ �ۼƽ���
        if i=2 then  begin
           StrGrid.Cells[4,i]:=FormatFloat('0.000',Step_L);
        end else if Trim(StrGrid.Cells[5,i])='' then  begin
           StrGrid.Cells[4,i]:=FormatFloat('0.000',Public_Basic.StrToDouble_Lu(Trim(StrGrid.Cells[2,i-1]))+Step_L);
        end;
        // ��10 ���ۼƸ���    right  ������
         if i=2 then  begin
            StrGrid.Cells[10,i]:='1';
        end else begin
            StrGrid.Cells[10,i]:= IntTostr(Public_Basic.StrToInt_lu(StrGrid.Cells[10,i-1])+1);
        end;

          //  //��ȡ��9 �� ��ֵ   right ����
        if (Trim(StrGrid.Cells[9,i-1])='') or (i=2) then  begin
           Step_L:=self.GetFootOneStepDis;
        end else  begin
           Step_L:=Public_Basic.StrToDouble_Lu(Trim(StrGrid.Cells[9,i-1]));
        end;

        if Trim(StrGrid.Cells[7,i])='' then
            StrGrid.Cells[9,i]:=FormatFloat('0.000',Step_L);
        //  //��8 �� ȡ �ۼƽ���
         if i=2 then  begin
           StrGrid.Cells[8,i]:=FormatFloat('0.000',Step_L);
         end else if Trim(StrGrid.Cells[7,i])='' then  begin
           StrGrid.Cells[8,i]:=FormatFloat('0.000',Public_Basic.StrToDouble_Lu(Trim(StrGrid.Cells[8,i-1]))+Step_L);
         end;

         //�˳�����
         if Trim(StrGrid.Cells[1,i+1])='' then  break;
   end;

end;

function TDrawBmp_From.UpdateShouDongInputFootae(StrGrid: TstringGrid;
  Row: integer;DownOrUp:string) :Integer ;
var
  i:integer;
  StartRow,EndRow:integer;
  StepDis:Double;
  StartFootage,EndFootage:Double;
  StepCol,AutoCol,SelectCol:integer;
  AutoAddlastData:Boolean;
begin
   if DownOrUp='Down' then  begin
       StepCol:=3;
       AutoCol:=4;
       SelectCol:=5;
   end else begin
       StepCol:=9;
       AutoCol:=8;
       SelectCol:=7;
   end;
   if Row= StrGrid.RowCount-1  then  AutoAddlastData:=true
       else AutoAddlastData:=false;
   EndRow:=Row;
   StartRow:=2; //�������
   for i :=EndRow  downto 2 do
       if (Trim(StrGrid.Cells[SelectCol,i]) <> '')  and  (Trim(StrGrid.Cells[AutoCol,i]) <> '' )then begin
           EndRow:=i;
           break;
       end;
   for i := EndRow-1 downto 2 do   begin
       if (Trim(StrGrid.Cells[SelectCol,i]) <> '')  and  (Trim(StrGrid.Cells[AutoCol,i]) <> '' )then begin
           StartRow:=i;
           break;
       end;
   end;
   // ��� ��ʼʱ��һ������
   if StartRow=2 then  begin
      StrGrid.Cells[SelectCol,StartRow]:=StrGrid.Cells[AutoCol,StartRow] ;
   end;

   if  (Trim(StrGrid.Cells[SelectCol,EndRow]) <> '' ) and (StartRow >=2) then  begin   //��˳�۵� ����
       if  Trim(StrGrid.Cells[SelectCol,StartRow]) ='' then begin
           StartFootage:=0;
       end else begin
           StartFootage:=Public_Basic.StrToDouble_Lu(StrGrid.Cells[SelectCol,StartRow]);
       end;
       // ��ʼ����
       EndFootage:=Public_Basic.StrToDouble_Lu(StrGrid.Cells[SelectCol,EndRow]);
       StepDis:=(EndFootage-StartFootage)/(EndRow-StartRow);
       if StepDis>=0  then
         for I := StartRow+1 to EndRow do  begin
             StrGrid.Cells[AutoCol,i]:=FormatFloat('0.00',StartFootage+StepDis);
             StrGrid.Cells[StepCol,i]:=FormatFloat('0.000',StepDis);
             StartFootage:=StartFootage+StepDis;
         end;
   end;
   //�����޶����������
   if AutoAddlastData then
       for I := EndRow+1 to StrGrid.RowCount -1 do begin
          if trim(StrGrid.Cells[AutoCol,i]) ='' then  break;
          if (trim(StrGrid.Cells[AutoCol,i-1]) ='') or (i-1<2) then  break;
           StrGrid.Cells[AutoCol,i]:=FormatFloat('0.00',Public_Basic.StrToDouble_Lu(StrGrid.Cells[AutoCol,i-1])
                                                       +Public_Basic.StrToDouble_Lu(StrGrid.Cells[StepCol,i]) );
       end;
   Result:= StartRow;
end;

procedure TDrawBmp_From.UpdateTdateTimeFormCurrRow(StrGrid: TstringGrid;
  Row: integer);
var
   i,j,FromRow,ToRow:integer;
   StepTime:double;
   StartDatatime,DateTime_1,DateTime_2,UseddateTime:TdateTime;
begin
   if Row <2 then  exit;
   if Trim(StrGrid.Cells[1,Row])='' then  exit;
      StartDatatime:= StrToDateTime( FormatDateTime('yyyy-mm-dd',StrToDateTime(Trim(StrGrid.Cells[1,Row]),Public_Basic.FSetting) )
                                      +' 00:00:00',Public_Basic.FSetting );
   FromRow:=Row+1;
   ToRow:=-1;
   UseddateTime:=StrToDateTime(Trim(StrGrid.Cells[1,Row]),Public_Basic.FSetting) ;
   while FromRow <= StrGrid.RowCount -1  do begin
       if Trim(StrGrid.Cells[1,FromRow])= ''  then break;
       //�ҵ�������
       for j := FromRow to StrGrid.RowCount -2 do  begin
          if Trim(StrGrid.Cells[1,j+1])= '' then begin
              ToRow:=j;
              break;
          end;

          DateTime_1:=StrToDateTime( FormatDateTime('yyyy-mm-dd',StrToDateTime(Trim(StrGrid.Cells[1,j]),Public_Basic.FSetting) )
                                      +' 00:00:00',Public_Basic.FSetting );
          DateTime_2:=StrToDateTime(Trim(StrGrid.Cells[1,j+1]),Public_Basic.FSetting);

           if DateTime_2 - DateTime_1 >=1 then  begin
              ToRow:=j;
              break;
           end;
       end;

      if ToRow < FromRow then  begin
         ToRow:=StrGrid.RowCount -1;
      end;

       //  ��д����
       if ToRow =FromRow then  begin
           StepTime:=self.GetFootStepTime;
       end else begin
           StepTime:=self.GetFootStepTime(Trim(StrGrid.Cells[1,FromRow]),Trim(StrGrid.Cells[1,ToRow]),ToRow-FromRow);
       end;

       for j := FromRow to ToRow do  begin
           UseddateTime:=UseddateTime+ StepTime;
           StrGrid.Cells[1,j]:=  FormatDateTime('yyyy-mm-dd HH:nn:ss',UseddateTime);
       end;

       FromRow:=ToRow+1;
       UseddateTime:= StrToDateTime( FormatDateTime('yyyy-mm-dd',StrToDateTime(Trim(StrGrid.Cells[1,ToRow]),Public_Basic.FSetting)+1 )
                                      +' 00:00:00',Public_Basic.FSetting );
   end;

end;

procedure TDrawBmp_From.CB_Box_ColorGroupChange(Sender: TObject);
begin
    FillStringGridColorGroup(CB_Box_ColorGroup.ItemIndex+3);
    StringGridColorGroup.Repaint;
end;

procedure TDrawBmp_From.CB_PhaseNumberChange(Sender: TObject);
begin
  self.FillStringGridPhase(3+2*CB_PhaseNumber.ItemIndex );
end;

procedure TDrawBmp_From.ChangePressDataUnit(Flag: integer);
var
  i,j:integer;
  TemValue:Double;
begin
  if Flag=1 then   begin
     Label_DataPress_Unit.Caption :='��ǰ���ݵ�λΪ MPa' ;
     DrawGzm.ColorValue.UnitType :=1;
     DataPress_Unit_Flag:=1;
     Lab_Unit1.Caption :='MPa';
     Lab_Unit2.Caption :='MPa';
     Lab_Unit3.Caption :='MPa';
  end else begin
     Label_DataPress_Unit.Caption :='��ǰ���ݵ�λΪ Bar' ;
     DrawGzm.ColorValue.UnitType:=2;
     DataPress_Unit_Flag:=2;
     Lab_Unit1.Caption :='Bar';
     Lab_Unit2.Caption :='Bar';
     Lab_Unit3.Caption :='Bar';
  end;

  for I := 4 to RockDataGrid.ColCount-1 do  begin
      for j := 2 to RockDataGrid.RowCount -1 do  begin
         TemValue:=Public_Basic.StrToDouble_Lu(RockDataGrid.Cells[i,j]);
         if TemValue>0 then   begin
            if DataPress_Unit_Flag=1 then  begin
               RockDataGrid.Cells[i,j]:=FormatFloat('0.00',TemValue/10) ;
            end else begin
               RockDataGrid.Cells[i,j]:=FormatFloat('0.00',TemValue*10) ;
            end;
         end else begin
             RockDataGrid.Cells[i,j]:='';
         end;
      end;
  end;
   //����Memo2 ����
   SplitWorkFaceMemo2Text;
  //����contourStringGrid
   DisPoseContourGroupColor;
  //����ChartGraphi
   RefreshMyCloudChart;
   Caption:=EXCaption+'��'+ Label_DataPress_Unit.Caption+'��';
end;

procedure TDrawBmp_From.ChartPageControlDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
   if Active then
    begin
        Control.Canvas.Brush.Color := ClHighLight;
        Control.Canvas.Font.Color := clWhite;
    end;
    Control.Canvas.FillRect(Rect);
    Control.Canvas.TextOut(Rect.Left + 4,Rect.Top + 4,ChartPageControl.Pages[TabIndex].Caption);
end;

procedure TDrawBmp_From.ChartYunClick(Sender: TObject);
begin
//    ChartYun.SetFocus;
//    ChartYun.BevelInner:= bvLowered;
//    ChartYun.BevelOuter:= bvLowered;
//    ChartYun.BevelWidth:=2;
end;

procedure TDrawBmp_From.ChartYunExit(Sender: TObject);
begin
//    ChartYun.BevelInner:= bvNone;
//    ChartYun.BevelOuter:= bvNone;
//    ChartYun.BevelWidth:=1;
end;

procedure TDrawBmp_From.ChartYunGetAxisLabel(Sender: TChartAxis;
  Series: TChartSeries; ValueIndex: Integer; var LabelText: string);
var
  i:integer;
  FSetting : TFormatSettings;  //���ڸ�ʽת��
begin
     //���ڸ�ʽת��
       FSetting.ShortDateFormat:='yyyy-mm-ss' ;
       FSetting.DateSeparator :='-';
       FSetting.ShortTimeFormat :='hh:nn:ss';
       FSetting.TimeSeparator :=':';
       FSetting.DecimalSeparator :='.';
      // ���ĵڶ��������
//     if Sender = ChartYun.Axes.Bottom.SubAxes.Items[0] then
//         LabelText :=  FormatFloat('0.00',DrawGzm.DatetimeToFootage(StrToDateTime(LabelText,FSetting),'Down'));
//     if Sender = ChartYun.Axes.Bottom.SubAxes.Items[1] then
//         LabelText :=  FormatFloat('0.00',DrawGzm.DatetimeToFootage(StrToDateTime(LabelText,FSetting),'Upper'));

end;

procedure TDrawBmp_From.ChartYunKeyPress(Sender: TObject; var Key: Char);
begin
//   if (Key= 'a')  or (Key= 'A') then
//      ChartYun.View3DOptions.Rotation :=  ChartYun.View3DOptions.Rotation-10;
//   if (Key= 'd')  or (Key= 'D') then
//      ChartYun.View3DOptions.Rotation :=  ChartYun.View3DOptions.Rotation+10;
//   if (Key= 'w')  or (Key= 'W') then
//      if ChartYun.View3DOptions.Perspective<=85 then
//           ChartYun.View3DOptions.Perspective:= ChartYun.View3DOptions.Perspective+5;
//   if (Key= 's')  or (Key= 'S') then
//      if ChartYun.View3DOptions.Perspective>=5 then
//           ChartYun.View3DOptions.Perspective:= ChartYun.View3DOptions.Perspective-5;
//   ChartYun.SetFocus;
end;

procedure TDrawBmp_From.CheckListBox_phaseClick(Sender: TObject);
begin
    GetDataClass;
    RefreshMemoInfo(Memo_info);
end;

procedure TDrawBmp_From.CheckListBox_SupportClick(Sender: TObject);
var
 i,C:integer;
begin
   C:=0;
   for I := 0  to CheckListBox_Support.Count -1 do  begin
       if CheckListBox_Support.Checked[i]  then  c:=c+1;
       if C > 10 then  begin
          CheckListBox_Support.Checked[i] :=false;
          OptionTip(0,'ѡ��֧�ܵ��������ܳ���10��!');
       end;
   end;
    GetDataClass;
    RefreshMemoInfo(Memo_info);
end;



procedure TDrawBmp_From.ColorGroupButtonClick(Sender: TObject);
begin
   SaveWorkFaceMemo1Text;
   RefreshMyCloudChart;
   //ˢ�� stringColor
   FillStringGridColorGroup(CB_Box_ColorGroup.ItemIndex+3);
   StringGridColorGroup.Repaint;
end;

procedure TDrawBmp_From.ComboBox_KY_LmdChange(Sender: TObject);
begin
   SetAnalysisSenstive(ComboBox_KY_Lmd.ItemIndex);
end;

procedure TDrawBmp_From.ComboKNameChange(Sender: TObject);
var
   s_temp:Str_DT_array;
   C1:integer;
begin
   s_temp:=Public_Basic.split(ComboKName.Text,'_',C1);
   if length(trim(s_temp[0])) >0  then  begin
       DrawGzm.Mk_id:=strToInt(s_temp[0]);
       DrawGzm.Mk_Name:=s_temp[1];
       MainDataModule.MySQlFillComBox(MySqlDataSet1,GzmCombo,' select cqid,cqName from cqcsb where kid = ' +  s_temp[0]+
                                              ' order by cqid','cqid','cqName','');

   end;

end;



procedure TDrawBmp_From.ContourChartGetAxisLabel(Sender: TChartAxis;
  Series: TChartSeries; ValueIndex: Integer; var LabelText: string);
var
  LabDaoshu:double;
  Daoshu:integer;
  Text:String;
begin
        if Sender=ContourChart.BottomAxis.SubAxes.Items[0] then   begin
             Text:=StringReplace (LabelText, ',', '', [rfReplaceAll]);
             Daoshu:=Round(Public_Basic.StrToDouble_Lu(Text));
            if (Daoshu>= 0  ) and (Daoshu <DrawGzm.FilledContourDataNumber ) then  begin
                if DrawGzm.ConTourSeriesPar.Display_DownFootage =1 then  begin
                    if (DrawGzm.FilledContourData[Daoshu].Down_footage >0)then   begin
                        LabelText:=FormatFloat('0',DrawGzm.FilledContourData[Daoshu].Down_footage  ) ;
                    end else begin
                        LabelText:='';
                    end;

                end else begin
                    if DrawGzm.FilledContourData[Daoshu].DT>10000 then   begin
                       LabelText:=FormatDateTime('yyyy-mm-dd',DrawGzm.FilledContourData[Daoshu].DT  ) ;
                    end else begin
                       LabelText:='';
                    end;
                end;
            end else begin
               LabelText:='';
            end;

        end;


//
        if Sender=ContourChart.TopAxis then  begin
             Text:=StringReplace (LabelText, ',', '', [rfReplaceAll]);
             Daoshu:=Round(Public_Basic.StrToDouble_Lu(Text));
            if (Daoshu>= 0  ) and (Daoshu <DrawGzm.FilledContourDataNumber ) then  begin
               if DrawGzm.ConTourSeriesPar.Display_UpperFootage =1 then  begin
                   if (DrawGzm.FilledContourData[Daoshu].Upper_Footage>0 )then   begin
                       LabelText:=FormatFloat('0',DrawGzm.FilledContourData[Daoshu].Upper_Footage  ) ;
                    end else begin
                       LabelText:='';
                    end;

               end else begin
                   if DrawGzm.FilledContourData[Daoshu].DT >10000 then   begin
                      LabelText:=FormatDateTime('yyyy-mm-dd',DrawGzm.FilledContourData[Daoshu].DT  ) ;
                   end else begin
                      LabelText:='';
                   end;
               end;
           end else begin
               LabelText:='';
           end;
        end;


end;

procedure TDrawBmp_From.ContourChartMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt:Tpoint;
begin
   if Button=mbRight then begin
      pt:= ContourChart.ClientToScreen(Point(0,0));
      DispContourPopMemu(pt.X+x,pt.Y +y,'TwoDimChart');
   end;


end;

procedure TDrawBmp_From.ContourChartMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
    tmp : Integer;
begin
  try
    tmp:=ContourSeries.Clicked(x,y);
    if tmp=-1 then  begin
       OptionTip(1,'') ;
    end else begin
//       OptionTip(1,'����:'+IntToStr(Round((ContourSeries1.XValues[tmp])))+' '+
//                        '֧��:'+IntToStr(Round((ContourSeries1.ZValues[tmp])))+
//                        ' ѹ��: '+FloatToStr(ContourSeries1.YValues[tmp]));
//      OptionTip(1,'����:'+IntToStr(x)+' '+
//                        '֧��:'+IntToStr(y)+
//                        ' ѹ��: '+FloatToStr(ContourSeries1.YValues[tmp]));


    end;
   //artTool1.AxisAnnotation.Text := FloatToStr(Sgrid.YValues[tmp]);
   except

  end;
end;

function TDrawBmp_From.ContourChartSaveIntoBMP(Path: string): Boolean;
var
  FileName,tmp:string;
begin
   if trim(Path) <> '' then  begin
          if SavePictureDialog1.FilterIndex =2 then  begin
             if ExtractFileExt(SavePictureDialog1.FileName) <> '.jpg' then
                 SavePictureDialog1.FileName := ChangeFileExt(SavePictureDialog1.FileName,'.jpg');
          end else if SavePictureDialog1.FilterIndex =3 then  begin
             if ExtractFileExt(SavePictureDialog1.FileName) <> '.png' then
                 SavePictureDialog1.FileName := ChangeFileExt(SavePictureDialog1.FileName,'.png');
          end else  begin
             if ExtractFileExt(SavePictureDialog1.FileName) <> '.bmp' then
                 SavePictureDialog1.FileName := ChangeFileExt(SavePictureDialog1.FileName,'.bmp');
          end;
          ContourChart.SaveToBitmapFile(SavePictureDialog1.FileName);
          if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWater(SavePictureDialog1.FileName)
            else Public_Basic.AddMultTextWater(SavePictureDialog1.FileName);
   end else begin
      tmp:=GetContOurChartBmpFileName;
      if tmp ='' then  exit;

      if not DrawGzm.CloudClass.OldStepDisplay then   begin
            FileName:=SaveBMpPath+ tmp +'_0.bmp';
            ContourChart.SaveToBitmapFile(FileName);
            if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWater(FileName)
                  else Public_Basic.AddMultTextWater(FileName);
      end else begin
          FileName:=SaveBMpPath+ tmp +'_1.bmp';
          ContourChart.SaveToBitmapFile(FileName);
          if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWater(FileName)
            else Public_Basic.AddMultTextWater(FileName);
      end;
   end;


  
end;

procedure TDrawBmp_From.ContourPop_ChangUnitClick(Sender: TObject);
begin
  if DataPress_Unit_Flag=1 then  begin
     DataPress_Unit_Flag:=2;
  end else if DataPress_Unit_Flag=2 then   begin
     DataPress_Unit_Flag:=1;
  end;

    ChangePressDataUnit(DataPress_Unit_Flag);
end;

procedure TDrawBmp_From.ContourPop_DeleteClick(Sender: TObject);
begin
   DrawGzm.Auto_Judge_OldStep.ExSteps[DrawGzm.EditMapPoint.StepClassid].Used :=2;
   RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TDrawBmp_From.contourPop_Disp_StepClick(Sender: TObject);
begin
   SetOldStepVisible(not DrawGzm.CloudClass.OldStepDisplay);
   RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TDrawBmp_From.ContourPop_EditMapClick(Sender: TObject);
begin
      ContourChart.ScrollMouseButton:=mbMiddle;
       //���ı༭״̬
      DrawGzm.EditMapPoint:=EditMapSeriesSteps(DrawGzm.EditMapPoint.Apol,-1);
      ContourChart.ScrollMouseButton:=mbLeft;
end;

procedure TDrawBmp_From.contourPop_KYFXClick(Sender: TObject);
begin
    setLeftToolVisible(false);
    SetRightToolVisible(true);
    StartRockPressAnslysisBegin;
end;

procedure TDrawBmp_From.CopyDataToStringGridFromPaste(StrGrid: TstringGrid; Col,
  Row, ColNumber: integer);
var
  arr: array[0..99999] of Char;
  i,j,inColNumber:Integer;
  s_temp:Str_DT_array;
  C1,ColS:integer;
  List1:TStringList;
begin

  Clipboard.GetTextBuf(arr, Length(arr));
  List1:=TStringList.Create ;
  List1.Text:=arr;
  try
     for I := 0 to List1.Count-1 do  begin
          s_temp:=Public_Basic.split(List1.Strings[i],#9,C1);
          if ColNumber < 1   then inColNumber:=C1
              else  inColNumber:=ColNumber;

          for j := 0 to inColNumber-1 do  begin
             if Col+j>StrGrid.ColCount-1 then   break;

             StrGrid.Cells[Col+j,Row]:=s_temp[j];
          end;

          Row:=Row+1;
          if Row> StrGrid.RowCount -1 then break;

    end;

  finally
     FreeAndNil(List1);
  end;


end;

function TDrawBmp_From.CreateSaveBmpPath: String;
var
 BmpPath:WideString;
begin
    BmpPath:=Public_Basic.Get_MyModulePath+'SaveBmp\KYFX\';
    if  not DirectoryExists(BmpPath) then
         ForceDirectories(BmpPath);

    Result:=BmpPath;
end;

procedure TDrawBmp_From.DeleteOnRecordToFootage(StrGrid: TstringGrid;
  Row: integer);
var
  i:integer;
begin
   if Row <2  then exit;
   for i:=Row to StrGrid.RowCount-2 do
       MoveStringGridRecord(StrGrid,i+1,i);
    //������һ��
    FootageGrid.Rows[StrGrid.RowCount-1].Clear ;
    StrGrid.RowCount:=StrGrid.RowCount-1;
    UpdateFootageStringGridFromRow(StrGrid,'Detlete',Row);
    //���µ���
   RefreshFootageStringGrid
end;

procedure TDrawBmp_From.DispContourPopMemu(Px, Py: Integer; ChartName: string);
begin
   //ContourPop_loadData.Enabled :=false;
   ContourPop_refreshchart.Enabled :=false;
//   ContourPop_TwoDim.Enabled :=false;
//   ContourPop_ThreeDim.Enabled :=false;
//   ContourPop_Graph.Enabled :=false;
   ContourPop_Save_Bmp.Enabled :=false;
   ContourPop_ChangUnit.Enabled :=false;
   //ContourPop_LeftZoom.Enabled:=false;
    ContourPop_Kyfx.Enabled :=false;
    ContourPop_EditMap.Enabled :=false;
    ContourPop_SaveEditMap.Enabled :=False;
    ContourPop_UndoEdit.Enabled :=false;
    ContourPop_Delete.Enabled:=false;
    contourPop_Disp_Step.Enabled :=false;
    if DrawGzm.MapSeriesEditState >0 then  begin
       ContourPop_Kyfx.Enabled :=true;       // ��ѹ������
       ContourPop_refreshchart.Enabled :=true;// ˢ��ҳ��
       ContourPop_ChangUnit.Enabled :=true;  //  �ı䵥λ
       ContourPop_Save_Bmp.Enabled :=true; //  ����ͼƬ
       contourPop_Disp_Step.Enabled :=true;//��ʾ��ѹ����

    end;

    if DrawGzm.MapSeriesEditState =2 then  begin
       ContourPop_EditMap.Enabled :=true;   //�༭״̬
       ContourPop_SaveEditMap.Enabled :=true; //����״̬
       ContourPop_UndoEdit.Enabled :=true;   // ����״̬
       ContourPop_Delete.Enabled:=true;//ɾ��ѡ������
    end;




   if ChartName='TwoDimChart' then  begin
      LeftPageControl.Pages[3].TabVisible :=false;{��ά����ҳ��}
      CurrentChart:='TwoDimChart';
      ContourPop_Main.Popup(px,py);
   end else if  ChartName='ThreeDimChart' then  begin
      LeftPageControl.Pages[3].TabVisible :=true;{��ά����ҳ��}
      CurrentChart:='ThreeDimChart';
      ContourPop_Main.Popup(px,py);
   end;


end;

procedure TDrawBmp_From.DispFootAgePopMumu(px,py,Col,Row:integer);
begin
   if  (Row <=1) or (Col<0)  then exit;

    //
    Pop_Foot_oneday.Enabled :=False;
    self.Pop_Foot_AddStep.Enabled :=False;
    self.Pop_Foot_InsertStep.Enabled :=False;
    self.Pop_Foot_DeleteStep.Enabled :=False;

    Pop_Foot_EditTime.Enabled :=False;
    Pop_Foot_UpdateTime.Enabled :=False;
    Pop_Foot_Update_PartData.Enabled :=False;
    Pop_Foot_Update_allData.Enabled :=False;
    Pop_Foot_Paste.Enabled :=False;
    Pop_Foot_UpdateDao.Enabled:=False;
//    if col=0 then  begin   //ѡ�� �Ĳ���
        Pop_Foot_oneday.Enabled :=true;
        self.Pop_Foot_AddStep.Enabled :=true;
        self.Pop_Foot_InsertStep.Enabled :=true;
        self.Pop_Foot_DeleteStep.Enabled :=true;
//    end;

    if col=1 then  begin
        Pop_Foot_EditTime.Enabled :=true;
        Pop_Foot_UpdateTime.Enabled :=true;
    end;

    if (col=5) or (col=7 )  then  begin
       Pop_Foot_Update_PartData.Enabled :=true;
       Pop_Foot_Update_allData.Enabled :=true;
       Pop_Foot_Paste.Enabled :=true;
    end;

    if (col=2) or (col=10 )  then  begin
       Pop_Foot_Paste.Enabled :=true;
       Pop_Foot_UpdateDao.Enabled:=true;
    end;


    PopMemu_Footage.Popup(px,py);

end;

procedure TDrawBmp_From.DisplyMapSeries(series:TMapSeries;
    OldStep:TOldSteps;TranVis:Boolean;Color:TColor;LineWide:integer);
    {
      series ��ͼ����
      OldStep ��������
      TranVis ����Ƿ�͸��
      Color �����ɫ �����͸��  ������ɫ
      LineWide ��������
    }
var
  i,j:integer;
  APol    : TTeePolygon;
  PointIndex:integer;
begin
//    for I := series.Shapes.Count -1 downto 0 do
//        series.Shapes[i].Free ;

    series.Clear ;
    series.Visible :=Visible;
    if Visible then   begin
        for I := 0 to length(OldStep.ExSteps ) -1 do  begin

            if (OldStep.ExSteps[i].GetMinDao >= DrawGzm.CloudClass.SaveDataMinDao  ) and
                  (OldStep.ExSteps[i].GetMaxDao <= DrawGzm.CloudClass.SaveDataMaxDao )  then
                  {��������������ݿⱣ������ݿռ���
                   �ж������Ƿ�������¼���
                  }
                 if DrawGzm.CloudClass.RecallMidDaoSaveStep  then  begin    // ������¼���
                    if (OldStep.ExSteps[i].Used=3) then    OldStep.ExSteps[i].Used:=1;
                 end else begin // ��������¼���
                    // ��Ȧ������ͼ��ɲ�����
                    if (OldStep.ExSteps[i].Used=1) and (OldStep.ExSteps[i].ModifyData=1)  then  // ��ʾ ����ֵ����Ԥ��ֵ
                       OldStep.ExSteps[i].Used:=3;
                 end;

            if  OldStep.ExSteps[i].Used <> 1 then   continue;   // ����������ʾ�ķ���
            APol:=series.Shapes.Add ;
            OldStep.ExSteps[i].MapSeriesIndex :=APol.Index ;
            APol.Points.Clear ;

            //
             if  (OldStep.ExSteps[i].GetMinDao > DrawGzm.DataTimeAndFootAge.Graph_MinDao ) and
                         (OldStep.ExSteps[i].GetMaxDao < DrawGzm.DataTimeAndFootAge.Graph_MaxDao ) then  begin
                 {
                   ����������� ������ ����������

                 }
                  if OldStep.ExSteps[i].ModifyData =3  then  begin  // ��ʾԤ������
                      if DrawGzm.CloudClass.DisPlayForcase then    //���ͬ����ʾԤ������
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,FALSE,ClRed,LineWide);

                  end else if OldStep.ExSteps[i].ModifyData =1  then begin
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,Color,LineWide);
                  end else if OldStep.ExSteps[i].ModifyData =4  then begin
                       if not DrawGzm.CloudClass.RecallMidDaoSaveStep  then
                         {
                           ��������½��м��� ��ô�� ����� ��ѹ������ͼ������ʾ
                           ����ؽ����м��� �����������ͼ����ѹ������ͼ������ʾ
                         }
                        SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,Color,LineWide);
                  end;


             end else begin
                {
                   ���������������� �ж�����ʾʲô����

                }
                 if DrawGzm.CloudClass.DisPlayProMinDaoSaveStep then  begin // ���������Ƿ���ʾ�Ƿ� ��ʾ
                     if (DrawGzm.CloudClass.DisplaySaveDate_Quyu_Step) and (OldStep.ExSteps[i].ModifyData =2) then
                      {
                        �����ʾ������ͼ ���Ҵ����ݿ�����ȡ���� ������ͼ ����ʾ
                      }
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,Color,LineWide);
                      if (not DrawGzm.CloudClass.DisplaySaveDate_Quyu_Step) and (OldStep.ExSteps[i].ModifyData =4) then
                      {
                        �����ʾ��ѹ������ͼ ���Ҵ����ݿ�����ȡ���� ��ѹ������ͼ ����ʾ
                      }
                      SetPolygenProperty(OldStep.ExSteps[i],true,APol,TranVis,Color,LineWide);
                 end;


             end;


      end;
   end;
   series.RefreshSeries;
end;

procedure TDrawBmp_From.DisPoseContourGroupColor;
begin
     {����Ӧ����ͼ����ɫ����}
     if StringGroupColor<>'' then  begin
         {�ֽ��ַ���}
         splitStringGroupColor;
      end else begin
         // Ĭ����ɫΪ������ɫ
         DrawGzm.MyContourColor_NumLevel:=6;
      end;
      if DrawGzm.MyContourColor_NumLevel>=3 then
         CB_Box_ColorGroup.ItemIndex := DrawGzm.MyContourColor_NumLevel-3;
           {���}
      FillStringGridColorGroup(DrawGzm.MyContourColor_NumLevel);
end;

procedure TDrawBmp_From.DispResultPop(Px, Py: integer;TP:String);
begin
    ResultPop_SaveTxt.Enabled :=false;
    ResultPop_SaveExcel.Enabled :=false;
   // ResultPop_OpenLefttool.Enabled :=false;
   // ResultPop_OpenRightTool.Enabled :=false;
   ResultPop_Print_Phase.Enabled :=false;
   ResultPop_Print_whole.Enabled :=false;
    if TP='Memo' then  begin
       ResultPop_SaveTxt.Enabled :=true;
       ResultPop_Print_Phase.Enabled :=true;
       ResultPop_Print_whole.Enabled :=true;
    end else begin
       ResultPop_SaveExcel.Enabled :=true;
    end;
    PopMenu_Result.Popup(px,py);
end;

procedure TDrawBmp_From.DispRockDataPopMumu(px, py, Col, Row: integer);
begin
     if  (Row <=1) or (Col<4)  then exit;

     if  RG_Rock_DataType.ItemIndex <4 then  begin
         Pop_Rock_Paste.Enabled :=false;
     end else begin
         Pop_Rock_Paste.Enabled :=true;
     end;

//     self.Pop_Rock_Paste.Enabled :=false;
//     self.Pop_Rock_DeleteOne .Enabled :=false;
//     //self.Pop_Rock_Save.Enabled :=false;
//     self.Pop_Rock_Refresh.Enabled :=false;
//     self.Pop_Rock_DeletaAll.Enabled :=false;
       //Pop_Rock_Input_Memo.Enabled :=False;

       Pop_Rock_Disp_Memo.Enabled :=False;
     if Trim(RockDataRightGrid.Cells[RockStringGrid_SelectCol,RockStringGrid_SelectRow]) <> '' then
              Pop_Rock_Disp_Memo.Enabled :=true;

     PopupMenu_RockData.Popup(px,py);
end;

procedure TDrawBmp_From.DispTreePop(Px, Py: Integer);
begin
     if TreeView_Stepid <0 then  begin
        TreePop_Delete.Enabled :=false;
        TreePop_Recall.Enabled :=false;
     end else begin
        TreePop_Delete.Enabled :=true;
        TreePop_Recall.Enabled :=true;
     end;

     TreePopu.Popup(px,py);
end;

procedure TDrawBmp_From.DragPointEndDrag(Sender: TDragPointTool;
  Index: Integer);
begin
   if (Index>=0) and (index<=7 )  then   begin
      DrawGzm.EditMapPoint.tmpPoints[index].x :=Round(LineSeries.XValues[index]);
      DrawGzm.EditMapPoint.tmpPoints[index].Y :=Round(LineSeries.YValues[index]);
   end;
    //�ָ����Ŵ�״̬
  //  SetContourSeriseZoomUsed(true);
end;

procedure TDrawBmp_From.DragPointStartDrag(Sender: TDragPointTool;
  Index: Integer; var Start: Boolean);
begin
    // SetContourSeriseZoomUsed(False);
     DrawGzm.EditMapPoint.Pointid :=Index;
end;

procedure TDrawBmp_From.Edit_StartDaoClick(Sender: TObject);
begin
    Edit_StartDao.SetFocus;
     RecallLoadDataToDataBase(true);
end;

procedure TDrawBmp_From.Edit_StartDaoKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9',#8]) then key:=#0  ;
end;

procedure TDrawBmp_From.Edit_EndDaoClick(Sender: TObject);
begin
   Edit_EndDao.SetFocus;
   RecallLoadDataToDataBase(true);
end;

procedure TDrawBmp_From.Edit_EndDaoKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9',#8]) then key:=#0
end;

function TDrawBmp_From.EditMapSeriesSteps(ApolId,
  StepClassId: integer): TEditMapSeriesRe;
var
  tmp:TEditMapSeriesRe;
  i:integer;
begin
    if StepClassId <0 then   begin
       StepClassId:=DrawGzm.Auto_Judge_OldStep.ReturnStepid(ApolId) ;
    end;
    if StepClassId <0 then   exit;

    DrawGzm.MapSeriesEditState:=2;
    tmp.Apol :=Apolid;
    tmp.StepClassid:=StepClassid;
    Result:=tmp;
    // ��������ͼ
    LineSeries.Clear ;

    for I := 0 to 7 do  begin
      LineSeries.AddXY(DrawGzm.Auto_Judge_OldStep.ExSteps[StepClassid].MyOutLinePoint[i].x,
                        DrawGzm.Auto_Judge_OldStep.ExSteps[StepClassid].MyOutLinePoint[i].y
                        );
      //���������
      tmp.tmpPoints[i].X:=DrawGzm.Auto_Judge_OldStep.ExSteps[StepClassid].MyOutLinePoint[i].x;
      tmp.tmpPoints[i].Y:=DrawGzm.Auto_Judge_OldStep.ExSteps[StepClassid].MyOutLinePoint[i].Y;
    end;
     LineSeries.AddXY(DrawGzm.Auto_Judge_OldStep.ExSteps[StepClassid].MyOutLinePoint[0].x,
                        DrawGzm.Auto_Judge_OldStep.ExSteps[StepClassid].MyOutLinePoint[0].y
                        );

    LineSeries.XValues.Order:=loNone;
    LineSeries.Pen.Width :=DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide;
    LineSeries.Pen.Color :=ClBlue;
    LineSeries.OutLine.Visible :=true;
    LineSeries.Pointer.Size:=LineSeries.Pen.Width+4;
    MapSeries.Selected.Hover.Visible :=false;
    ContourSeries.Selected.Hover.Visible :=False;
    // �����Ŵ������Ϊ�Ŵ�ģʽ
    SetContourSeriseZoomUsed(true);
    Result:=tmp;
end;

procedure TDrawBmp_From.Edit_AxisClick(Sender: TObject);
begin
   Edit_Axis.SetFocus;
end;

procedure TDrawBmp_From.Edit_AxisKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9',#8]) then key:=#0  ;
end;

procedure TDrawBmp_From.Edit_EndPtClick(Sender: TObject);
begin
   Edit_EndPt.SetFocus;
end;

procedure TDrawBmp_From.Edit_EndPtKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TDrawBmp_From.Edit_Fill_Line_WideClick(Sender: TObject);
begin
     Edit_Fill_Line_Wide.SetFocus ;
end;

procedure TDrawBmp_From.Edit_Foot_ConClick(Sender: TObject);
begin
    Edit_Foot_Con.SetFocus ;
end;

procedure TDrawBmp_From.Edit_Foot_ConKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9',#8]) then key:=#0  ;
end;

procedure TDrawBmp_From.Edit_interVal_supportChange(Sender: TObject);
begin
   Edit_interVal_support.SetFocus;
end;

procedure TDrawBmp_From.Edit_interVal_supportKeyPress(Sender: TObject;
  var Key: Char);
begin
   if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TDrawBmp_From.Edit_JD_supportClick(Sender: TObject);
begin
   Edit_JD_support.SetFocus ;
end;

procedure TDrawBmp_From.Edit_Min_PtClick(Sender: TObject);
begin
  Edit_Min_Pt.SetFocus;
end;

procedure TDrawBmp_From.Edit_Min_PtKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TDrawBmp_From.Edit_StartPtClick(Sender: TObject);
begin
   Edit_StartPt.SetFocus;
end;

procedure TDrawBmp_From.Edit_StartPtKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TDrawBmp_From.Edit_Step_TranCClick(Sender: TObject);
begin
    Edit_Step_TranC.SetFocus;
end;

procedure TDrawBmp_From.Edit_SupportNumberClick(Sender: TObject);
begin
    self.Edit_SupportNumber.SetFocus ;
end;

procedure TDrawBmp_From.Edit_SupportNumberKeyPress(Sender: TObject;
  var Key: Char);
begin
   if not (key in ['0'..'9',#8]) then key:=#0  ;
end;

procedure TDrawBmp_From.Edit_Sup_ConClick(Sender: TObject);
begin
   Edit_Sup_Con.SetFocus;
end;

procedure TDrawBmp_From.Edit_Sup_ConKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9',#8]) then key:=#0  ;
end;

procedure TDrawBmp_From.EndDateTimeClick(Sender: TObject);
begin
    RecallLoadDataToDataBase(false);
end;

procedure TDrawBmp_From.EndEditClick(Sender: TObject);
begin
   EndEdit.SetFocus;
   RecallLoadDataToDataBase(false);
end;



procedure TDrawBmp_From.EndEditKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TDrawBmp_From.ExtractDataFormSeries(TreeView: TTreeView; ParantNode:TTreeNode;
  Series: TContourSeries ; DataType:integer);
 var
  strcon: String;
  RecData: PMyRec;
  xChilld11,xChilld12,xChilld13:TTreeNode;
  xChild3:TTreeNode;
  i, j, m: Integer;
  lvl: TContourLevel;
  seg: TLevelSegment;
  //pt:TPoint;
  KK:integer;

begin

   if DataPress_Unit_Flag =1 then   begin
      KK:=1;
   end else begin
      KK:=10;
   end;

//   DrawGzm.Auto_Judge_OldStep.SetJudgeBasicParameters(DrawGzm.FGzm.RockPressAnalysis.Continue_SupNumber,
//                    DrawGzm.FGzm.RockPressAnalysis.conTinue_Footage/DrawGzm.FGzm.RockPressAnalysis.OneDao_step,
//                    DrawGzm.FGzm.RockPressAnalysis.AnalysisSenstive
//                    ) ;

   DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,true,100,100);

   if DataType=-1 then   begin // ���� ��Ϊδ�������Ϣ

        New(RecData);
        RecData^.BName:='-1';
        RecData^.DName:='ROOT';
        RecData^.XHeight:='-1';
        xChilld11:=TreeView.Items.AddChildObject(ParantNode,'��Ч��������Ϣ',RecData);
        xChilld11.ImageIndex:=0;
        //�ڵ㱻ѡ��չ��


        New(RecData);
        RecData^.BName:='-1';
        RecData^.DName:='ROOT';
        RecData^.XHeight:='-1';
        xChilld12:=TreeView.Items.AddChildObject(ParantNode,'��ɾ����������Ϣ',RecData);
        xChilld12.ImageIndex:=0;



        New(RecData);
        RecData^.BName:='-1';
        RecData^.DName:='ROOT';
        RecData^.XHeight:='-1';
        xChilld13:=TreeView.Items.AddChildObject(ParantNode,'��ѹ����Ԥ����Ϣ',RecData);
        xChilld13.ImageIndex:=0;
           for I := 0 to length(DrawGzm.Auto_Judge_OldStep.ExSteps)-1 do   begin
                 if  DrawGzm.Auto_Judge_OldStep.ExSteps[i].Used =0 then continue;
                 if DrawGzm.Auto_Judge_OldStep.ExSteps[i].ModifyData =1  then  begin // ����ֵ
                      if  DrawGzm.Auto_Judge_OldStep.ExSteps[i].Used =1 then   begin
                            New(RecData);
                            RecData^.BName:='1';
                            RecData^.DName:=IntToStr(i);
                            RecData^.XHeight:=intTostr(DrawGzm.Auto_Judge_OldStep.ExSteps[i].MapSeriesIndex);
                            xChild3:=TreeView.Items.AddChildObject(xChilld11,DrawGzm.Auto_Judge_OldStep.ExSteps[i].GetDispTitle ,  RecData);
                            xChild3.ImageIndex:=2;
                      end else if  DrawGzm.Auto_Judge_OldStep.ExSteps[i].Used =2 then begin
                            New(RecData);
                            RecData^.BName:='2';
                            RecData^.DName:=IntToStr(i);
                            RecData^.XHeight:='0';
                            xChild3:=TreeView.Items.AddChildObject(xChilld12,DrawGzm.Auto_Judge_OldStep.ExSteps[i].GetDispTitle ,  RecData);
                            xChild3.ImageIndex:=6;
                      end;
                 end else if DrawGzm.Auto_Judge_OldStep.ExSteps[i].ModifyData =3  then  begin // Ԥ��ֵ
                       New(RecData);
                        RecData^.BName:='2';
                        RecData^.DName:=IntToStr(i);
                        RecData^.XHeight:='0';
                        xChild3:=TreeView.Items.AddChildObject(xChilld13,DrawGzm.Auto_Judge_OldStep.ExSteps[i].GetDispTitle ,  RecData);
                        xChild3.ImageIndex:=5;
                 end;

           end;

         // xChilld11.Expand(true);
   end else if  DataType= 1 then   begin // ���� ��Ϊ�Ѿ��������Ϣ
        New(RecData);
        RecData^.BName:='-1';
        RecData^.DName:='ROOT';
        RecData^.XHeight:='-1';
        xChilld11:=TreeView.Items.AddChildObject(ParantNode,'��Ҫ��ͼ����',RecData);
        xChilld11.ImageIndex:=0;
        //�ڵ㱻ѡ��չ��


        New(RecData);
        RecData^.BName:='-1';
        RecData^.DName:='ROOT';
        RecData^.XHeight:='-1';
        xChilld12:=TreeView.Items.AddChildObject(ParantNode,'��ѹ��������',RecData);
        xChilld12.ImageIndex:=0;

         for I := 0 to length(DrawGzm.Auto_Judge_OldStep.ExSteps)-1 do   begin
             if  DrawGzm.Auto_Judge_OldStep.ExSteps[i].Used <>1 then continue;
             if (DrawGzm.Auto_Judge_OldStep.ExSteps[i].Used =1) and  (DrawGzm.Auto_Judge_OldStep.ExSteps[i].ModifyData =2) then  begin
                // ���������ݿ�����ȡ�� ��ͼ��Ϣ Ҳ���� ���ݿⱣ��dataType = 2 �� ����
                New(RecData);
                RecData^.BName:='2';
                RecData^.DName:=IntToStr(i);
                RecData^.XHeight:=intTostr(DrawGzm.Auto_Judge_OldStep.ExSteps[i].MapSeriesIndex);
                xChild3:=TreeView.Items.AddChildObject(xChilld11,DrawGzm.Auto_Judge_OldStep.ExSteps[i].GetDispTitle ,  RecData);
                xChild3.ImageIndex:=2;
             end;

             if (DrawGzm.Auto_Judge_OldStep.ExSteps[i].Used =1) and  (DrawGzm.Auto_Judge_OldStep.ExSteps[i].ModifyData =4) then  begin
                // ���������ݿ�����ȡ�� ��ѹ������Ϣ Ҳ���� ���ݿⱣ��dataType = 4 �� ����
                New(RecData);
                RecData^.BName:='2';
                RecData^.DName:=IntToStr(i);
                RecData^.XHeight:=intTostr(DrawGzm.Auto_Judge_OldStep.ExSteps[i].MapSeriesIndex);
                xChild3:=TreeView.Items.AddChildObject(xChilld12,DrawGzm.Auto_Judge_OldStep.ExSteps[i].GetDispTitle ,  RecData);
                xChild3.ImageIndex:=2;
             end;

       end;

   end;



      DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,False,0,0);

end;

procedure TDrawBmp_From.FillBasicJinDao(B_JinDao: TBasicJinDao;Support:integer);
var
  sql,Strdt:string;
  MaxTime:TDateTime;
  Rd:TJinDaoRecord;
begin
   MaxTime:=GetBatInputDataMaxGenTime(Support);
   MySqlDataSet2.Close ;

   Strdt:=Public_Basic.ReturnDateTimeString(MainDataModule.DataType ,MaxTime);

   Sql:=' select * from  D_'+IntToStr(DrawGzm.FGzm.Gzmbh)+'_footage ' +
        ' where  footday > ' + Strdt +
        ' order by Daoshu  ' ;
   B_JinDao.ClearArray;
   MySqlDataSet2.CommandText :=sql;
   try
      if MySqlDataSet2.Open then
       while not MySqlDataSet2.Eof  do  begin
          Rd.ShotTime :=MySqlDataSet2.FieldByName('FootDay').AsDateTime;
          Rd.Daoshu:=MySqlDataSet2.FieldByName('DaoShu').AsInteger;
          B_JinDao.Add(RD);
          MySqlDataSet2.Next;
       end;
   finally
      MySqlDataSet2.Close ;
   end;
end;

procedure TDrawBmp_From.FillStringGridColorGroup(NumLevel: integer);
var
  i:integer;
  UpValue:Integer;
  PerValue:integer;
begin
    InitStringGridGroupColor;
    PerValue:=0;
    if (StringGroupColor='') or (NumLevel <> DrawGzm.MyContourColor_NumLevel ) then  begin
       DrawGzm.MyContourColor_NumLevel:=NumLevel;
       GetMyContourGroupColor(NumLevel);
    end else begin
       splitStringGroupColor;// �����ַ���
    end;

    //��䵽grid
    for I := 1 to DrawGzm.MyContourColor_NumLevel do   begin
         if DataPress_Unit_Flag=1 then begin
             UpValue:=DrawGzm.MyContourColor[i-1].UpToValue ;
         end else begin
             UpValue:=DrawGzm.MyContourColor[i-1].UpToValue*10 ;
         end;

        if i<=5 then  begin
           StringGridColorGroup.Cells[0,i]:=IntTostr(DrawGzm.MyContourColor[i-1].xh);
           StringGridColorGroup.Cells[1,i]:=IntTostr(PerValue+1);
           StringGridColorGroup.Cells[2,i]:=IntTostr(UpValue);

        end else begin
           StringGridColorGroup.Cells[4,i-5]:=IntTostr(DrawGzm.MyContourColor[i-1].xh);
           StringGridColorGroup.Cells[5,i-5]:=IntTostr(PerValue+1);
           StringGridColorGroup.Cells[6,i-5]:=IntTostr(UpValue);

        end;

        PerValue:=UpValue;
    end;
end;

procedure TDrawBmp_From.FillStringGridPhase(Number:integer);
var
  i:integer;
begin
    InitStringGridPhase;
    if (DrawGzm.FGzm.RockPressAnalysis.OldStepPhaseString = '' ) or
       ( DrawGzm.Auto_Judge_OldStep.PhaseNumber<> Number )then  begin
        DrawGzm.Auto_Judge_OldStep.InitPhaseSteps(Number,DrawGzm.FGzm);
    end;

    //��䵽grid
    for I := 0 to DrawGzm.Auto_Judge_OldStep.PhaseNumber -1 do   begin

        if i<=3 then  begin
           StringGridPhase.Cells[0,i+1]:=IntTostr(i+1);
           StringGridPhase.Cells[1,i+1]:=IntTostr(DrawGzm.Auto_Judge_OldStep.PhaseSteps[i].StartsupBh);
           StringGridPhase.Cells[2,i+1]:=IntTostr(DrawGzm.Auto_Judge_OldStep.PhaseSteps[i].EndSupBh);

        end else begin
           StringGridPhase.Cells[3,i-3]:=IntTostr(i+1);
           StringGridPhase.Cells[4,i-3]:=IntTostr(DrawGzm.Auto_Judge_OldStep.PhaseSteps[i].StartsupBh);
           StringGridPhase.Cells[5,i-3]:=IntTostr(DrawGzm.Auto_Judge_OldStep.PhaseSteps[i].EndSupBh);

        end;
    end;

end;

procedure TDrawBmp_From.FootageGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  iRect:TRect;
begin
      with FootageGrid do  begin
          if (ACol =6) or(ACol=0) or (ARow=0) or (ARow=1) then       begin
            iRect:=ZoomRect(Rect, 1);

            Canvas.Font.Color   :=   clBlack; //������ɫΪ���
            Canvas.Brush.color:=clMoneyGreen; //����Ϊ ��Ԫ��ɫ
            Canvas.FillRect(iRect);
            Canvas.TextOut(Rect.Left+2,Rect.Top+2,Cells[ACol,ARow]);
         end;

          if (State = []) and (FootStringGrid_SelectRow = ARow) then  begin
             Canvas.Brush.Color := clSkyBlue;
             Canvas.FillRect(Rect);
             Canvas.TextOut(Rect.left , Rect.top, Cells[ACol, ARow]);
          end;
      end;

end;

procedure TDrawBmp_From.FootageGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 pt:TPoint;
 col, row: Longint;
begin
   FootageGrid.MouseToCell(X, Y, col, row);

   if Button=mbRight then  begin
      pt:= FootageGrid.ClientToScreen(Point(0,0));
      Mouse_x:=pt.X+x;
      Mouse_y:=Pt.Y+y;
      FootStringGrid_SelectCol :=col;
      FootStringGrid_SelectRow := row;
      DispFootAgePopMumu(Mouse_x,Mouse_y,FootStringGrid_SelectCol,FootStringGrid_SelectRow);
     // FootStringGrid_SelectRow:=0;
   end else if Button = mbLeft then  begin
       if row <> FootStringGrid_SelectRow then  begin
          FootStringGrid_SelectRow := row;
          FootageGrid.Repaint;
       end;
   end;



end;

procedure TDrawBmp_From.FootageGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
   FootStringGrid_SelectCol:=ACol;
   FootStringGrid_SelectRow:=ARow;
end;

procedure TDrawBmp_From.Footsteps_LClick(Sender: TObject);
begin
  Footsteps_L.SetFocus ;
end;

procedure TDrawBmp_From.Footsteps_LKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TDrawBmp_From.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   {�رմ��壬������Ҫ����Close����}
   if Assigned(DrawBmp_From) then  FreeAndNil(DrawBmp_From);
end;

procedure TDrawBmp_From.FormCreate(Sender: TObject);
begin
    MySqlDataSet1:=TMyDataSet.Create(nil);
    MySqlDataSet1.MySqlConnection :=MainDataModule.ExConn;
    MySqlDataSet2:=TMyDataSet.Create(nil);
    MySqlDataSet2.MySqlConnection :=MainDataModule.ExConn;
    MyCommand1:=TMyCommand.Create (nil);
    MyCommand1.MySqlConnection :=MainDataModule.ExConn;
    DrawGzm:=TDrawGrap.Create(MainDataModule.ExConn);
    //create
     MapSeries:=TMapSeries.Create(contourchart);
     MapSeries.ParentChart:= contourchart;
     MapSeries.OnClick:=MapSeriesClick;
     MapSeries.OnDblClick:=MapSeriesDoubleClick;


    MainDataModule.ReadPublicUsedMkInfoFromFile;
    s_MinName :=MainDataModule.Coal_Name;
    S_WorkFaceName :=MainDataModule.WorkFace_Name;
    // ��ʼ������
    InitFootageGrid;
    FootStringGrid_SelectCol:=-1;
    FootStringGrid_SelectRow:=-1;
    // ��ѹ���ݱ�
     SelectRockDataRecordNumber:='50';

     RockStringGrid_SelectCol:=-1;
     RockStringGrid_SelectRow:=-1;
     {�ֶ��������� �������ҳ��}
    // LeftPageControl.Pages[1].TabVisible:=False;
     LeftPageControl.Pages[2].TabVisible:=False;
     SetRightToolVisible(false);
     //Ĭ�ϻ�β��ʾ ʱ��
     DrawGzm.ConTourSeriesPar.Display_UpperFootage:=0;
     DrawGzm.ConTourSeriesPar.Display_DownFootage:=1;
     // �ر�ʮ�ֹ����
     SetCusorShizhiVisible(False);
     ChartPageControl.ActivePage :=ChartPageControl.Pages[0];
     ChartPageControl.Pages[1].TabVisible :=false;  //��άӦ����ͼ
     ChartPageControl.Pages[2].TabVisible :=false;  //ѹ�����߱仯ͼ
     PageControl_timeOrDao.ActivePage := PageControl_timeOrDao.Pages[0];
     //��ѹ��������״̬   Ĭ��û�н���������
     SetOldStepVisible(false);
     //����ͼƬ�����ļ���
     SaveBmpPath:=CreateSaveBmpPath;
    //
    BasicJinDao:=TBasicJinDao.Create ;
end;

procedure TDrawBmp_From.FormDestroy(Sender: TObject);
begin
     FreeAndNil(MySqlDataSet1);
     FreeAndNil(MyCommand1);
     FreeAndNil(MySqlDataSet2);
     FreeAndNil(DrawGzm);

     FreeAndNil(MapSeries);
     FreeAndNil(BasicJinDao);

end;

procedure TDrawBmp_From.FormResize(Sender: TObject);
begin
   RefreshSize;
end;

procedure TDrawBmp_From.FormShow(Sender: TObject);
begin
   InitForm;
   Caption:=EXCaption+'��'+ Label_DataPress_Unit.Caption+'��';
end;

procedure TDrawBmp_From.GB_KY_Memo1Click(Sender: TObject);
begin
     GB_KY_Memo1.SetFocus ;
end;

function TDrawBmp_From.GetBatInputDataMaxGenTime(Support:integer): TDateTime;
var
  sql:String;
begin
   Result:=-1;
   MySqlDataSet2.Close ;
   Sql:=' select Max(generatetime) as MAXTime from  D_'+IntToStr(DrawGzm.FGzm.Gzmbh)+'_ManualInputPressData  '  +
        ' where supportbh = ' +IntTostr(Support) ;
   MySqlDataSet2.CommandText :=sql;
   try
       if MySqlDataSet2.Open then
        Result:= MySqlDataSet2.FieldByName('MAXTime').AsDateTime

   finally
       MySqlDataSet2.Close ;
   end;
end;

function TDrawBmp_From.GetContOurChartBmpFileName: String;
var
  MinLab,MaxLab:integer;
begin
   Result:='';
   if DrawGzm.FGzm.Gzmbh <1 then  exit;
   MinLab:=Round(ContourChart.BottomAxis.Minimum);
   MaxLab:=Round(ContourChart.BottomAxis.Maximum);
   Result:='YT_'+Trim(IntTostr(DrawGzm.FGzm.Gzmbh)) +'_'+
           Trim(IntTostr(MinLab))+ '_'+Trim(IntTostr(MaxLab)) ;
end;

function TDrawBmp_From.GetDataClass: Boolean;
var
 i:integer;
 Str:string;
begin
    //��ͼ��������
 if RG_YUN_Main.ItemIndex=0 then  begin
          // ʵʱ���� ѹ������
          DrawGzm.CloudClass .YUntu_DataClass:=DisPoseData;

   end else if RG_YUN_Main.ItemIndex=1 then begin
          // ѭ��������������
          DrawGzm.CloudClass .YUntu_DataClass:=Cycle;

   end else if RG_YUN_Main.ItemIndex=2 then begin
         // �ֶ�¼������
         DrawGzm.CloudClass .YUntu_DataClass:=ManualInput;
   end;

    if RG_YUN_Cycle.ItemIndex=0 then  begin
        DrawGzm.CloudClass .Yuntu_CycleData :=MAX_CData;
        DrawGzm.CloudClass.Yuntu_Data_Name:='���ֵ';
    end else if RG_YUN_Cycle.ItemIndex=1 then  begin
        DrawGzm.CloudClass .Yuntu_CycleData :=AVG_CData;
        DrawGzm.CloudClass.Yuntu_Data_Name:='ƽ��ֵ';
    end else if RG_YUN_Cycle.ItemIndex =2 then begin
       DrawGzm.CloudClass .Yuntu_CycleData :=Mzl_CData;
        DrawGzm.CloudClass.Yuntu_Data_Name:='ĩ����';
    end else if RG_YUN_Cycle.ItemIndex =3 then begin
       DrawGzm.CloudClass .Yuntu_CycleData :=Sametime_CData;
        DrawGzm.CloudClass.Yuntu_Data_Name:='ͬһʱ��ץȡֵ';
    end else begin
       DrawGzm.CloudClass .Yuntu_CycleData :=Manual_CData;
       DrawGzm.CloudClass. Yuntu_Data_Name:='�ֶ�¼��ֵ';
    end;

             //��ͼѹ��ѡ��
   if RG_Yun_DataType.ItemIndex=0 then begin
      DrawGzm.CloudClass.Yuntu_DataType:=FrontPressData;
      DrawGzm.CloudClass.YunTu_DataType_Name:='ǰ��ѹ��';
   end else if RG_Yun_DataType.ItemIndex=1 then begin
      DrawGzm.CloudClass.Yuntu_DataType:=BehindPressData;
      DrawGzm.CloudClass.YunTu_DataType_Name:='����ѹ��';
   end else if RG_Yun_DataType.ItemIndex=2 then begin
      DrawGzm.CloudClass.Yuntu_DataType:=LeftPressData;
      DrawGzm.CloudClass.YunTu_DataType_Name:='����ѹ��';
   end else if RG_Yun_DataType.ItemIndex=3 then begin
      DrawGzm.CloudClass.Yuntu_DataType:=RightPressData;
      DrawGzm.CloudClass.YunTu_DataType_Name:='����ѹ��';
   end;

   // ��������
   if RG_Graph_Main.ItemIndex=0 then   begin
      DrawGzm.GraphClass.Graph_DataCalss :=phase;
      DrawGzm.GraphClass.DataName:='�׶�֧������չʾ';
   end else begin
      DrawGzm.GraphClass.Graph_DataCalss :=single;
      DrawGzm.GraphClass.DataName:='����֧������չʾ';
   end;
   // CheckListBox_phase
   str:='';
   if  DrawGzm.GraphClass.Graph_DataCalss =phase then  begin
       for I := 0  to CheckListBox_phase.Count -1 do
          if CheckListBox_phase.Checked[i]  then   str:=str+IntToStr(i+1)+',';
   end else begin
       for I := 0  to CheckListBox_Support.Count -1 do
       if CheckListBox_Support.Checked[i]  then    str:=str+IntToStr(i+1)+',';
   end;

   if length(Str) >1  then  begin
      DrawGzm.GraphClass.SupportList:=copy(str,0,length(str)-1);
   end else begin
      DrawGzm.GraphClass.SupportList:='';
   end;
  // RadidFootage_Upper Down
    DrawGzm.ConTourSeriesPar.Display_UpperFootage:=self.RadioGroup_UpperFootage.ItemIndex;
    DrawGzm.ConTourSeriesPar.Display_DownFootage:=self.RadioGroup_DownFootage.ItemIndex;
  //��ȡ��������ʾ�����÷�ʽ
   if self.RG_XAxis.ItemIndex =0 then  begin
      DrawGzm.CloudClass.X_Axis_Disp_Type:=0;

   end else begin
     DrawGzm.CloudClass.X_Axis_Disp_Type:=1;
     DrawGzm.CloudClass.X_Axis_Disp_Dao :=Public_Basic.StrToInt_lu(Self.Edit_Axis.Text );
   end;
  //��ȡ�Ƿ���ʾԤ��������Ϣ
  if self.RG_Option_ForCase.ItemIndex =0 then  begin
     DrawGzm.CloudClass.DisPlayForcase:=true;
  end else begin
     DrawGzm.CloudClass.DisPlayForcase:=false;
  end;
    //��ȡ�Ƿ���ʾ��С����֮ǰ����ѹ����
  if self.RG_Option_DispProDao.ItemIndex =0 then  begin
     DrawGzm.CloudClass.DisPlayProMinDaoSaveStep:=true;
  end else begin
     DrawGzm.CloudClass.DisPlayProMinDaoSaveStep:=false;
  end;

     //��ȡ�Ƿ�������·���  ���ڽ���֮�ڵ����򱣴������
  if self.RG_Option_DispSave_MidDao.ItemIndex =0 then  begin
     DrawGzm.CloudClass.RecallMidDaoSaveStep:=true;
  end else begin
     DrawGzm.CloudClass.RecallMidDaoSaveStep:=false;
  end;
   // ��ȡ���ݿ����������С������
   DrawGzm.ReturnDataBaseMin_MaxDao(DrawGzm.CloudClass.SaveDataMinDao,
                                    DrawGzm.CloudClass.SaveDataMaxDao );
   //��ȡ�洢����������ʾ������ͼ������ʾ��ѹ����
  if self.RG_Option_QYorStep.ItemIndex =0 then  begin
     DrawGzm.CloudClass.DisplaySaveDate_Quyu_Step:=true;
  end else begin
     DrawGzm.CloudClass.DisplaySaveDate_Quyu_Step:=false;
  end;
     //��ȡ������Χ֮�����ѹ��Ϣ�Ƿ����
  if self.RG_Print_Option.ItemIndex =0 then  begin
     DrawGzm.CloudClass.PrintOutDaoStepInto:=true;
  end else begin
     DrawGzm.CloudClass.PrintOutDaoStepInto:=false;
  end;
       //��ȡ��ѹ���ݷֶ���ʾ��ʽ
  if self.RG_Print_Disp.ItemIndex =0 then  begin
     DrawGzm.CloudClass.PrintDispPhaseVisual:=true;
  end else begin
     DrawGzm.CloudClass.PrintDispPhaseVisual:=false;
  end;

   Result:=true;
end;

function TDrawBmp_From.GetFootOneStepDis: double;
begin
    Result:=Public_Basic.StrToDouble_Lu(self.Footsteps_L.Text);
end;

function TDrawBmp_From.GetFootStepCount: Integer;
begin
   Result:=Public_Basic.StrToInt_lu(self.ComboFootSteps.Text);
end;

function TDrawBmp_From.GetFootStepTime(FistSt, SecondSt: String;Interval:integer): double;
var
  Fir,Sec:TdateTime;
begin
   Fir:=StrToDateTime(FistSt,Public_Basic.FSetting);
   Sec:=StrToDateTime(SecondSt,Public_Basic.FSetting);
   Result:=(Sec-Fir)/Interval;
end;

procedure TDrawBmp_From.GetMyContourGroupColor(NumLevel: integer);
var
  i:integer;
begin
    if NumLevel >10 then  exit;
    for I := 0 to NumLevel-1 do  begin
       DrawGzm.MyContourColor[i].ContourColor:=DrawGzm.GetContourColor(NumLevel,
        i,DrawGzm.MyContourColor[i].UpToValue );
       DrawGzm.MyContourColor[i].xh :=i;
    end;

end;

function TDrawBmp_From.GetFootStepTime: double;
var
   DT:integer;
begin
  DT:=Public_Basic.StrToInt_lu(self.ComboBoxStepTime.Text);
  Result:=DT/1440;
end;

function TDrawBmp_From.GetTimeAndFootage: Boolean;
var
  MaxDao,MInDao:integer;
begin
    Result:=False;

    //��ò�ѯ����
    if RG_DaoOrFootage.ItemIndex =0 then  begin //�Խ���Ϊ�����в�ѯ
         maxDao:=Public_Basic.StrToInt_lu(Trim(Edit_EndDao.Text ));
         MinDao:=Public_Basic.StrToInt_lu(Trim(Edit_StartDao.Text ));
         if maxDao>0 then  DrawGzm.DataTimeAndFootAge.Graph_MaxDao:=MaxDao;
         if MinDao>=0 then  DrawGzm.DataTimeAndFootAge.Graph_MinDao:=MinDao;
         StartDateTime.DateTime :=DrawGzm.FGzm.ReturnDataTimeFromDao(DrawGzm.DataTimeAndFootAge.Graph_MinDao);
         EndDateTime.DateTime:= DrawGzm.FGzm.ReturnDataTimeFromDao(DrawGzm.DataTimeAndFootAge.Graph_MaxDao);
          {�ѽ�����Ϣ�������}
         StartEdit.Text:=FormatFloat('0.00',DrawGzm.DatetimeToFootage(StartDateTime.DateTime,'NUll' ) );
         EndEdit.Text:=FormatFloat('0.00',DrawGzm.DatetimeToFootage(EndDateTime.DateTime,'NUll' ) );

    end else begin    //�Խ���Ϊ�����в�ѯ
          if Public_Basic.StrTodouble_lu(EndEdit.Text)>0 then
           EndDateTime.DateTime := DrawGzm.FootageToDatetime(Public_Basic.StrTodouble_lu(EndEdit.Text),'NUll');

          if Public_Basic.StrTodouble_lu(StartEdit.Text)> 0 then
           startDateTime.DateTime := DrawGzm.FootageToDatetime(Public_Basic.StrTodouble_lu(StartEdit.Text),'NUll');
          DrawGzm.DataTimeAndFootAge.Graph_MaxDao:=DrawGzm.FGzm.ReturnDaoShuBasicTime(EndDateTime.DateTime);
          Edit_endDao.Text :=IntTostr(DrawGzm.DataTimeAndFootAge.Graph_MaxDao);
          DrawGzm.DataTimeAndFootAge.Graph_MinDao:=DrawGzm.FGzm.ReturnDaoShuBasicTime(startDateTime.DateTime);
          Edit_StartDao.Text :=IntTostr(DrawGzm.DataTimeAndFootAge.Graph_MinDao);
    end;

    DrawGzm.DataTimeAndFootAge.StartTime :=StartDateTime.DateTime ;
    DrawGzm.DataTimeAndFootAge.EndTime :=EndDateTime.DateTime ;
    DrawGzm.DataTimeAndFootAge.Minfootage :=Public_Basic.StrToDouble_lu(StartEdit.Text );
    DrawGzm.DataTimeAndFootAge.MaxFootage :=Public_Basic.StrToDouble_lu(EndEdit.Text );
    DrawGzm.DataTimeAndFootAge.UpperStartfootage:=DrawGzm.DatetimeToFootage(StartDateTime.DateTime,'Upper');
    DrawGzm.DataTimeAndFootAge.UpperEndfootage:=DrawGzm.DatetimeToFootage(EndDateTime.DateTime,'Upper');
    DrawGzm.DataTimeAndFootAge.DownStartfootage:=DrawGzm.DatetimeToFootage(StartDateTime.DateTime,'Down');
    DrawGzm.DataTimeAndFootAge.DownEndfootage:=DrawGzm.DatetimeToFootage(EndDateTime.DateTime,'Down');

    DrawGzm.DataTimeAndFootAge.TimeLength:= DrawGzm.DataTimeAndFootAge.EndTime
                              - DrawGzm.DataTimeAndFootAge.StartTime;
    if DrawGzm.DataTimeAndFootAge.TimeLength <1 then  begin
       DrawGzm.DataTimeAndFootAge.TimeLength:=1;
    end;
    // ����Ԥ������
    DrawGzm.DataTimeAndFootAge.ForCaseDay :=20;
    Result:=true;
end;

procedure TDrawBmp_From.GzmComboChange(Sender: TObject);
var
   s_temp:Str_DT_array;
   C1:integer;
begin
   s_temp:=Public_Basic.split(GzmCombo.Text,'_',C1);
   if length(trim(s_temp[0])) >0  then  begin
       DrawGzm.FGzm.Gzmbh:=strToInt(s_temp[0]);
       DrawGzm.FGzm.S_Name:=s_temp[1];
         //�ж��빤������ص����ݱ��Ƿ񴴽������û�д������ٴ˴���
       if not MainDataModule.IsExsitTableName('D_'+inttostr(DrawGzm.FGzm.Gzmbh)+'_BasicData') then begin
           MainDataModule.CreateTable('2',MainDataModule.DataType,inttostr(DrawGzm.FGzm.Gzmbh),'') ;
       end;
       OptionTip(0,'�ԡ�'+DrawGzm.FGzm.S_Name+'�����ݽ��з���!');
       GB_dateTime.Enabled :=true;
       // ˢ�½�������
       RefreshForm;

   end;

end;

function TDrawBmp_From.InitDateTimeFootage:boolean;
var
 i:integer;
 str:string;
begin
   //ʱ�������   �ڵõ����幤�����ŵ�����½��еĳ�ʼ��
    //EndDateTime.DateTime:=now();
    {todo:����ʹ��}
    Result:=false;
    {��䵶��}
    DrawGzm.DataTimeAndFootAge.Graph_MaxDao:=DrawGzm.FGzm.ReturnMaxDao ;
      if DrawGzm.DataTimeAndFootAge.Graph_MaxDao >120 then
         DrawGzm.DataTimeAndFootAge.Graph_MinDao :=DrawGzm.DataTimeAndFootAge.Graph_MaxDao -120
      else   DrawGzm.DataTimeAndFootAge.Graph_MinDao :=1;
    {�������ʱ��}
    EndDateTime.DateTime:=DrawGzm.FGzm.ReturnMaxFootAgeTime ;
    StartDateTime.DateTime :=DrawGzm.FGzm.ReturnMinFootAgeTime;

    //  {todo:����ʹ��}
    EndDateTime.DateTime:=now-440;
    StartDateTime.DateTime:=EndDateTime.DateTime-10;
    {�ѽ�����Ϣ�������}
    StartEdit.Text:=FormatFloat('0.00',DrawGzm.DatetimeToFootage(StartDateTime.DateTime,'NUll' ) );
    EndEdit.Text:=FormatFloat('0.00',DrawGzm.DatetimeToFootage(EndDateTime.DateTime,'NUll' ) );
    Edit_endDao.Text :=IntTostr(DrawGzm.DataTimeAndFootAge.Graph_MaxDao);
    Edit_StartDao.Text :=IntTostr(DrawGzm.DataTimeAndFootAge.Graph_MinDao);
    
    // ��ͼ
    RG_Yun_Main.ItemIndex:=2;     //�ֶ�����
    RG_Yun_Cycle.ItemIndex :=4;     //ѭ������ ĩ����
    RG_Yun_DataType.ItemIndex :=2; // ����ѹ��

    // ����ͼ
    RG_Graph_Main.ItemIndex :=0; //  ��������
    CheckListBox_DataType.Checked[0]:=true; //���ۺ�����ѡ��

    //��ʼ������ͼ �����б�
    if DrawGzm.FGzm.Gzmbh <1  then  exit;

    if not DrawGzm.FGzm.InputGzmData(DrawGzm.FGzm.Gzmbh)  then  begin
          OptionTip(0,'�������ʼ����������ϸ���!');
          self.Enabled:=false;
         exit;
    end;
   //��ʼ����ͼ����ɫ��
    DrawGzm.ColorValue.MinValue :=2;
    DrawGzm.ColorValue.MaxValue:=Round(DrawGzm.FGzm.Usedsupport.EndOpenLoad);
    DrawGzm.ColorValue.UnitType:=DataPress_Unit_Flag;


    //��������������
    DrawGzm.ThreeDimCloud.Support_interval:=5;// ֧���� 1�ܵļ�� ����
    DrawGzm.ThreeDimCloud.Time_InterVal :=0.5;//ʱ���԰���ļ������
    Result:=true;
    //��ʼ�������ȷ���
    ComboBox_KY_Lmd.ItemIndex:=1;
end;

procedure TDrawBmp_From.InitFootageGrid;
var
   i:integer;
begin

    for i := 1 to  FootageGrid.RowCount - 1 do
          FootageGrid.Rows[i].Clear ;
      FootageGrid.ColCount :=11;
      FootageGrid.RowCount :=3;
      FootageGrid.Font.Size:=9;
      FootageGrid.FixedRows :=2;

      FootageGrid.Cells [3,0]:='    ��';
      FootageGrid.Cells [4,0]:='      ͷ';
      FootageGrid.Cells [0,1]:='���';
         FootageGrid.ColWidths[0]:=40;
      FootageGrid.Cells [1,1]:='ʱ������';
         FootageGrid.ColWidths[1]:=150;
      FootageGrid.Cells [2,1]:='�ƽ�����';
         FootageGrid.ColWidths[2]:=60;
      FootageGrid.Cells [3,1]:='ÿ��(��)';
         FootageGrid.ColWidths[3]:=60;
      FootageGrid.Cells [4,1]:='�ۼƽ���(��)';
         FootageGrid.ColWidths[4]:=80;
      FootageGrid.Cells [5,1]:='�޶�����(��)';
         FootageGrid.ColWidths[5]:=80;
      FootageGrid.Cells [6,1]:='';
         FootageGrid.ColWidths[6]:=30;

      //
      FootageGrid.Cells [8,0]:='    ��';
      FootageGrid.Cells [9,0]:='      β';

      FootageGrid.Cells [7,1]:='�޶�����(��)';
         FootageGrid.ColWidths[7]:=80;
      FootageGrid.Cells [8,1]:='�ۼƽ���(��)';
         FootageGrid.ColWidths[8]:=80;
      FootageGrid.Cells [9,1]:='ÿ��(��)';
         FootageGrid.ColWidths[9]:=60;
      FootageGrid.Cells [10,1]:='�ƽ�����';
         FootageGrid.ColWidths[10]:=60;


      //
     FootageGrid.Align :=alClient;
     FootageGrid.Options:=FootageGrid.Options +[goEditing]    ;

end;

procedure TDrawBmp_From.InitForm;
begin

    ChartPageControl.Align :=alClient;
    Public_basic.InitStatusBar(StatusBar1);
    MainDataModule.MySQlFillComBox(MySqlDataSet1,JiTuanCombo,'select * from JItuanName order by id','id','DwName','');
    AutoLoadcomboBox(s_MinName,S_WorkFaceName);
    //ˢ����������
    DrawGzm.CloudClass.X_Axis_Disp_Type :=0;
    DrawGzm.CloudClass.X_Axis_Disp_Dao :=100;
       // ��ʼ�� ͼ����ز���
    LineSeries.XValues.Order:=loNone;
    LineSeries.Pen.Width :=DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide;
    LineSeries.Pen.Color :=ClBlue;
    LineSeries.OutLine.Visible :=true;
    LineSeries.Pointer.Size:=LineSeries.Pen.Width+4;
    // MapSeries.Selected.Hover.Visible :=false;
    ContourSeries.Selected.Hover.Visible :=False;
    RefreshForm;
    DrawGZm.MapSeriesEditState :=-1;  // Ĭ��û�м�������
    DrawGzm.CloudClass.OldStepDisplay :=False; //��ͼ����ʾ��ѹ����

end;

procedure TDrawBmp_From.initInputRockPressData;
var
   I:integer;
begin
   {�����ݿ��ж�ȡ��� Memo1 ����}
   SplitWorkFaceMemo1Text;
   {�����ݿ��ȡMemo2 ����Ϣ}
   SplitWorkFaceMemo2Text;
   {��ʼ��������Ľ�������}
   InitFootageGrid; // ��ʼ��������¼��
//    if DrawGzm.FGzm.Gzmbh>0 then
//       DrawGzm.FGzm.ReadFootageDataToStringGrid(FootageGrid) ;


  //=============��ѹ���ݱ���ά��
   RockDataGrid.OnMouseWheelDown  :=RockDataRightGrid.OnMouseWheelDown;
   RockDataGrid.OnMouseWheelUp :=RockDataRightGrid.OnMouseWheelUp;
   ChangePressDataUnit(2);//MPa
   {ˢ�¹���������¼�����ݱ�}
   RefreshRockPressStringGrid(SelectRockDataRecordNumber);
end;

procedure TDrawBmp_From.InitKyfxResultStringGrid;
var
   i:integer;
begin
    for i := 1 to  StringGrid_Result.RowCount - 1 do
          StringGrid_Result.Rows[i].Clear ;

      StringGrid_Result.ColCount :=24;
      StringGrid_Result.RowCount :=3;
      StringGrid_Result.Font.Size:=9;
      StringGrid_Result.FixedRows :=2;
      StringGrid_Result.FixedCols :=1;

      StringGrid_Result.Cells [0,0]:='  ��';
      StringGrid_Result.Cells [0,1]:='  ��';
        StringGrid_Result.ColWidths[0]:=30;
      StringGrid_Result.Cells [1,0]:='Ԥ��';
      StringGrid_Result.Cells [1,1]:='��ʽ';
        StringGrid_Result.ColWidths[1]:=50;

      StringGrid_Result.Cells [2,0]:='��ѹ';
      StringGrid_Result.Cells [2,1]:='�׶�';
        StringGrid_Result.ColWidths[2]:=50;

      StringGrid_Result.Cells [3,0]:='�׶�֧';
      StringGrid_Result.Cells [4,0]:='�ܷ�Χ';
        StringGrid_Result.Cells [3,1]:=' ��ʼ';
        StringGrid_Result.Cells [4,1]:=' ����';
        StringGrid_Result.ColWidths[3]:=50;
        StringGrid_Result.ColWidths[4]:=50;

      StringGrid_Result.Cells [5,0]:='Ԥ��';
      StringGrid_Result.Cells [5,1]:='����';
        StringGrid_Result.ColWidths[5]:=50;

      StringGrid_Result.Cells [6,0]:='��ѹ��';
      StringGrid_Result.Cells [7,0]:='ʼ����';
        StringGrid_Result.Cells [6,1]:='��Сֵ';
        StringGrid_Result.Cells [7,1]:='���ֵ';
        StringGrid_Result.ColWidths[6]:=50;
        StringGrid_Result.ColWidths[7]:=50;
      StringGrid_Result.Cells [8,0]:='��ѹ��';
      StringGrid_Result.Cells [9,0]:='������';
        StringGrid_Result.Cells [8,1]:='��Сֵ';
        StringGrid_Result.Cells [9,1]:='���ֵ';
        StringGrid_Result.ColWidths[8]:=50;
        StringGrid_Result.ColWidths[9]:=50;

      StringGrid_Result.Cells [10,0]:='Һѹ֧';
      StringGrid_Result.Cells [11,0]:='�ܷ�Χ';
        StringGrid_Result.Cells [10,1]:=' ��ʼ';
        StringGrid_Result.Cells [11,1]:=' ����';
        StringGrid_Result.ColWidths[10]:=50;
        StringGrid_Result.ColWidths[11]:=50;

     StringGrid_Result.Cells [12,0]:='��С';
     StringGrid_Result.Cells [12,1]:='ѹ��';
        StringGrid_Result.ColWidths[12]:=50;

     StringGrid_Result.Cells [13,0]:='���';
     StringGrid_Result.Cells [13,1]:='ѹ��';
        StringGrid_Result.ColWidths[13]:=50;
     StringGrid_Result.Cells [14,0]:='ƽ��';
     StringGrid_Result.Cells [14,1]:='ѹ��';
        StringGrid_Result.ColWidths[14]:=50;

     StringGrid_Result.Cells [15,0]:='ƽ��ѹ';
     StringGrid_Result.Cells [15,1]:='��ϵ��';
        StringGrid_Result.ColWidths[15]:=50;

     StringGrid_Result.Cells [16,0]:='��ѹǿ';
     StringGrid_Result.Cells [16,1]:='��ϵ��';
        StringGrid_Result.ColWidths[16]:=50;

     StringGrid_Result.Cells [17,0]:=' ��ѹ';
     StringGrid_Result.Cells [18,0]:=' ����';
        StringGrid_Result.Cells [17,1]:=' ��С';
        StringGrid_Result.Cells [18,1]:=' ���';
        StringGrid_Result.ColWidths[17]:=50;
        StringGrid_Result.ColWidths[18]:=50;

     StringGrid_Result.Cells [19,0]:='������';
     StringGrid_Result.Cells [20,0]:='������';
        StringGrid_Result.Cells [19,1]:=' ��С';
        StringGrid_Result.Cells [20,1]:=' ���';
        StringGrid_Result.ColWidths[19]:=50;
        StringGrid_Result.ColWidths[20]:=50;

     StringGrid_Result.Cells [21,0]:='�ȶ���';
     StringGrid_Result.Cells [21,1]:='������';
        StringGrid_Result.ColWidths[21]:=50;

     StringGrid_Result.Cells [22,0]:='ѹ���������Ե�֧��';
        StringGrid_Result.ColWidths[22]:=200;

end;

procedure TDrawBmp_From.InitRockDataGrid;
var
   i:integer;
   Cols:integer;
   SupperNumber,interVal_support,ColDiv:integer;
begin
    RockDataRightGrid.Align  :=alRight;
    RockDataGrid.Align :=alClient;
    RockDataRightGrid.Width:=95;

    for i := 0 to  RockDataGrid.RowCount - 1 do  begin
        RockDataGrid.Rows[i].Clear ;
        RockDataRightGrid.Rows[i].Clear;
        RockDataGrid_Edit.Rows[i].Clear;
    end;
      SupperNumber:= Public_Basic.StrToInt_lu(Edit_SupportNumber.text);
      interVal_support:= Public_Basic.StrToInt_lu(Edit_interVal_support.text);
      Cols:= SupperNumber div interVal_support;

      Cols:=Cols+4;
      RockDataGrid.ColCount :=Cols;
      RockDataGrid.RowCount :=3;
      RockDataGrid.FixedRows:=2;
      RockDataGrid.FixedCols:=4;
      // RockDataGrid_Edit
      RockDataGrid_Edit.ColCount :=Cols;
      RockDataGrid_Edit.RowCount :=3;
      RockDataGrid_Edit.FixedRows:=2;
      RockDataGrid_Edit.FixedCols:=4;
      //
      RockDataRightGrid.ColCount :=Cols;
      RockDataRightGrid.RowCount:=3;
      RockDataRightGrid.FixedRows:=2;
      RockDataRightGrid.FixedCols:=2;


      RockDataGrid.Cells [0,1]:='���';
         RockDataGrid.ColWidths[0]:=30;
      RockDataGrid.Cells [1,0]:='  ��';
      RockDataGrid.Cells [1,1]:='ʱ������';
         RockDataGrid.ColWidths[1]:=120;
      RockDataGrid.Cells [2,1]:='����';
         RockDataGrid.ColWidths[2]:=30;
      RockDataGrid.Cells [3,0]:='ͷ';
      RockDataGrid.Cells [3,1]:='����(��)';
         RockDataGrid.ColWidths[3]:=40;

      RockDataRightGrid.Cells [0,0]:='  ��';
      RockDataRightGrid.Cells [0,1]:='����(��)';
         RockDataRightGrid.ColWidths[0]:=40;
      RockDataRightGrid.Cells [1,0]:='  β';
      RockDataRightGrid.Cells [1,1]:='����';
         RockDataRightGrid.ColWidths[1]:=40;
         RockDataRightGrid.ColWidths[2]:=60;
      // ������ͷ
      ColDiv:= (Cols-4) div 8;
      RockDataGrid.Cells [4+ColDiv,0]:=' Һ';
      RockDataGrid.Cells [4+2*ColDiv,0]:=' ѹ';
      RockDataGrid.Cells [4+3*ColDiv,0]:=' ֧';
      RockDataGrid.Cells [4+4*ColDiv,0]:=' ��';
      RockDataGrid.Cells [4+5*ColDiv,0]:=' ѹ';
      RockDataGrid.Cells [4+6*ColDiv,0]:=' ��';
      RockDataGrid.Cells [4+7*ColDiv,0]:=' ��';
      RockDataGrid.Cells [4+8*ColDiv,0]:=' ��';

      for i := 4 to Cols-1 do  begin
         RockDataGrid.Cells [i,1]:='  '+IntTostr((i-3)*interVal_support);
         RockDataGrid.ColWidths[i]:=40;
      end;


end;

procedure TDrawBmp_From.InitStringGrid;
 var
   i:integer;
 begin
//    for i := 1 to  StringGrid1.RowCount - 1 do
//          StringGrid1.Rows[i].Clear ;
//      self.StringGrid1.ColCount :=19;
//      self.StringGrid1.RowCount :=2;
//      self.StringGrid1.Cells [0,0]:='���';
//      self.StringGrid1.Cells [1,0]:='��ױ��';
//      self.StringGrid1.Cells [2,0]:='�Ҳ����';
end;

procedure TDrawBmp_From.InitStringGridGroupColor;
var
   i:integer;
begin

    for i := 0 to  StringGridColorGroup.RowCount - 1 do begin
          StringGridColorGroup.Rows[i].Clear ;
          StringGridColorGroup.RowHeights[i]:=18;
    end;
      StringGridColorGroup.ColCount :=8;
      StringGridColorGroup.RowCount :=7;
      StringGridColorGroup.Font.Size:=8;
      StringGridColorGroup.FixedRows :=1;

      StringGridColorGroup.Cells [0,0]:='���';
      StringGridColorGroup.Cells [4,0]:='���';
          StringGridColorGroup.ColWidths[0]:=30;
          StringGridColorGroup.ColWidths[4]:=30;
      StringGridColorGroup.Cells [1,0]:='����';
      StringGridColorGroup.Cells [2,0]:='����';
      StringGridColorGroup.ColWidths[1]:=25;
      StringGridColorGroup.ColWidths[2]:=30;

      StringGridColorGroup.Cells [5,0]:='����';
      StringGridColorGroup.Cells [6,0]:='����';
        StringGridColorGroup.ColWidths[5]:=25;
        StringGridColorGroup.ColWidths[6]:=30;

      StringGridColorGroup.Cells [3,0]:='��ɫ';
      StringGridColorGroup.Cells [7,0]:='��ɫ';
          StringGridColorGroup.ColWidths[3]:=30;
          StringGridColorGroup.ColWidths[7]:=30;

end;

procedure TDrawBmp_From.InitStringGridPhase;
var
   i:integer;
begin

    for i := 0 to  StringGridPhase.RowCount - 1 do begin
          StringGridPhase.Rows[i].Clear ;
          StringGridPhase.RowHeights[i]:=18;
    end;
      StringGridPhase.ColCount :=6;
      StringGridPhase.RowCount :=6;
      StringGridPhase.Font.Size:=8;
      StringGridPhase.FixedRows :=1;

      StringGridPhase.Cells [0,0]:='����';
      StringGridPhase.Cells [3,0]:='����';
          StringGridPhase.ColWidths[0]:=30;
          StringGridPhase.ColWidths[3]:=30;
      StringGridPhase.Cells [1,0]:='��֧��';
      StringGridPhase.Cells [4,0]:='��֧��';
          StringGridPhase.ColWidths[1]:=50;
          StringGridPhase.ColWidths[4]:=50;

      StringGridPhase.Cells [2,0]:='ֹ֧��';
      StringGridPhase.Cells [5,0]:='ֹ֧��';
          StringGridPhase.ColWidths[2]:=50;
          StringGridPhase.ColWidths[5]:=50;

end;

procedure TDrawBmp_From.InserOneRecordToFootage(StrGrid:TstringGrid;Row: integer);
var
  i:integer;
begin
   StrGrid.RowCount := StrGrid.RowCount+1;
   for i:=StrGrid.RowCount-2  downto Row+1 do
       MoveStringGridRecord(StrGrid,i,i+1);
   UpdateFootageStringGridFromRow(StrGrid,'Insert',Row+1);
   //���µ���
   RefreshFootageStringGrid;
end;

procedure TDrawBmp_From.InsertNextDayFootage(StrGrid: TStringGrid; Row,dayOrstep:integer);
var
  NDataTime:TdateTime;
  StrDateTime:String;
  StepCount,i,SRow:Integer;
  StepTime:double;
  SelectCurrRow:integer;
  RecordCount,left_FootageCount,Right_FootageCount:Integer;
  Left_Sum_Footage,Right_SumFootage:Double;
  Step_Footage:Double;
begin
   //�������һ������
   SRow:=Row;
   SelectCurrRow:=0;
   {��ǰ��Ϊ�գ���ǰ�ң��ҵ���һ����Ϊ�յ��У���һ��Ϊ������}
   while Trim(StrGrid.Cells[1,SRow])='' do begin
     SRow:=SRow-1;
     SelectCurrRow:=1;
     if SRow=1 then  break;
   end;
  {��ǰ��Ϊ��Ϊ�գ�����ң��ҵ���һ��Ϊ�յ��У���ǰ��Ϊ������}
   while (Trim(StrGrid.Cells[1,SRow])<>'') and ( SelectCurrRow <>1) do begin
      SRow:=SRow+1;
      SelectCurrRow:=2;
      if SRow = StrGrid.RowCount -1 then  break;
   end;
   if SelectCurrRow=2 then  SRow:=SRow-1; //����ң��ҵ����Ƶ���һ��
   // ȡ�����һ��ʱ���ַ���
   if SRow =1 then    begin
      StrDateTime:=FormatDateTime('yyyy-mm-dd',Now)+ ' 00:00:00';
      RecordCount:=0;
      left_FootageCount:=0;
      Right_FootageCount:=0;
      Left_Sum_Footage:=0;
      Right_SumFootage:=0;

   end else begin
      if dayOrstep= 1 then  begin
          StrDateTime:=FormatDateTime('yyyy-mm-dd',StrToDateTime(Trim(StrGrid.Cells[1,SRow]),Public_Basic.FSetting)+1 )+
                   ' 00:00:00';
      end else begin
          StrDateTime:=Trim(StrGrid.Cells[1,SRow]);
      end;

      RecordCount:=Public_Basic.StrToInt_lu(StrGrid.Cells[0,SRow]);
      left_FootageCount:=Public_Basic.StrToInt_lu(StrGrid.Cells[2,SRow]) ;
      Right_FootageCount:=Public_Basic.StrToInt_lu(StrGrid.Cells[10,SRow]);
      Left_Sum_Footage:=Public_Basic.StrToDouble_Lu(StrGrid.Cells[4,SRow]);
      Right_SumFootage:=Public_Basic.StrToDouble_Lu(StrGrid.Cells[8,SRow]);;
   end;

   NDataTime:=StrToDateTime(StrDateTime,Public_Basic.FSetting);
   if dayOrstep=1 then   begin
      StepCount:=self.GetFootStepCount;
   end else begin
      StepCount:=1;
   end;


   StepTime:=self.GetFootStepTime;
   Step_Footage:=self.GetFootOneStepDis;

   for I := 1 to StepCount do   begin
      if StepTime*i>=1 then break;
      NDataTime:=NDataTime+StepTime;
      SRow:=SRow+1;
      if StrGrid.RowCount <=sRow+1 then  StrGrid.RowCount:=  SRow+2;
      RecordCount:=RecordCount+1;
      StrGrid.Cells[0,SRow]:= IntToStr(RecordCount);
      StrGrid.Cells[1,SRow]:= FormatDateTime('yyyy-mm-dd HH:nn:ss',NDataTime);
      left_FootageCount:=left_FootageCount+1;
      StrGrid.Cells[2,SRow]:= IntToStr(left_FootageCount);
      StrGrid.Cells[3,SRow]:= FormatFloat('0.000',Step_Footage);
      Left_Sum_Footage:=Left_Sum_Footage+Step_Footage;
      StrGrid.Cells[4,SRow]:= FormatFloat('0.00',Left_Sum_Footage);
      //
      Right_SumFootage:=Right_SumFootage+Step_Footage;
      StrGrid.Cells[8,SRow]:= FormatFloat('0.00',Right_SumFootage);
      StrGrid.Cells[9,SRow]:= FormatFloat('0.000',Step_Footage);
      Right_FootageCount:=Right_FootageCount+1;
      StrGrid.Cells[10,SRow]:= IntToStr(Right_FootageCount);
   end;

end;

procedure TDrawBmp_From.JITuanComboChange(Sender: TObject);
 var
   s_temp:Str_DT_array;
   C1:integer;
begin

   s_temp:=Public_Basic.split(self.JituanCombo.Text,'_',C1);
   if s_temp[0]='' then exit;

   DrawGzm.Jituan_id:=strToInt(s_temp[0]);
   DrawGzm.Jituan_name:=s_temp[1];
   MainDataModule.MySQlFillComBox(MySqlDataSet1,ComboKName,'select * from KuangJingXinXiBiao  where Jituanid=' +
                  IntToStr(DrawGzm.Jituan_id)+' order by id ','id','MeiKuangMing','');
   //�������
   GzmCombo.Items.Clear ;
   OptionTip(0,'');
   DrawGzm.FGzm.Gzmbh:=-1;
   DrawGzm.FGzm.S_Name :='';
   GB_dateTime.Enabled :=false;
end;

procedure TDrawBmp_From.OptionTip(index:integer;Str:String);
begin
   self.StatusBar1.Panels[index].Text :=str;
end;



procedure TDrawBmp_From.Pop_Foot_EditTimeClick(Sender: TObject);
var
  sDT:String;
  pt:TPoint;
begin
   sDT:=FootageGrid.Cells[1,FootStringGrid_SelectRow] ;
   if Trim(SDT)<> '' then begin
      pt.X:=mouse_x;
      Pt.y:=Mouse_y;
      CreateEditTime(FootageGrid.Handle,pt,sDT);
   end;
end;

procedure TDrawBmp_From.Pop_Foot_InsertStepClick(Sender: TObject);
begin
 InserOneRecordToFootage(FootageGrid,FootStringGrid_SelectRow);
end;

procedure TDrawBmp_From.LeftPageControlDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
    if Active then
    begin
        Control.Canvas.Brush.Color := ClHighLight;
        Control.Canvas.Font.Color := clWhite;
    end;
    Control.Canvas.FillRect(Rect);
    Control.Canvas.TextOut(Rect.Left + 4,Rect.Top + 4,LeftPageControl.Pages[TabIndex].Caption);
end;

procedure TDrawBmp_From.Main_PageControlDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
    if Active then
    begin
        Control.Canvas.Brush.Color := ClGreen;
        Control.Canvas.Font.Color := clWhite;
    end;
    Control.Canvas.FillRect(Rect);
    Control.Canvas.TextOut(Rect.Left + 4,Rect.Top + 4,Main_PageControl.Pages[TabIndex].Caption);
end;

procedure TDrawBmp_From.PageControl4DrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
    if Active then
    begin
        Control.Canvas.Brush.Color := ClHighLight;
        Control.Canvas.Font.Color := clWhite;
    end;
    Control.Canvas.FillRect(Rect);
    Control.Canvas.TextOut(Rect.Left + 4,Rect.Top + 4,PageControl4.Pages[TabIndex].Caption);
end;

procedure TDrawBmp_From.PageControl_ResultDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
   if Active then
    begin
        Control.Canvas.Brush.Color := ClHighLight;
        Control.Canvas.Font.Color := clWhite;
    end;
    Control.Canvas.FillRect(Rect);
    Control.Canvas.TextOut(Rect.Left + 4,Rect.Top + 4,PageControl_Result.Pages[TabIndex].Caption)
end;

procedure TDrawBmp_From.Panel1Click(Sender: TObject);
begin
    DrawGzm.CloudClass.OldStepDisplay :=true;
    //ˢ�����ͼ��
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
   if  DrawGzm.Auto_Judge_OldStep.isCalComeStep  then  begin
       InitKyfxResultStringGrid;
       DrawGzm.CalComeStepAndPrintToMemo(Memo_Result,StringGrid_Result);
   end;
end;

procedure TDrawBmp_From.Pop_Foot_AddStepClick(Sender: TObject);
begin
   InsertNextDayFootage(FootageGrid,FootStringGrid_SelectRow,0);
end;

procedure TDrawBmp_From.Pop_Foot_AutoClick(Sender: TObject);
begin
  AutoUpdateFootage(FootageGrid,FootStringGrid_SelectRow);
end;

procedure TDrawBmp_From.Pop_Foot_DeleteAllClick(Sender: TObject);
var
  t_s:string;
begin
//   t_s:='��ȷ��Ҫɾ����������ô?';
//    if Application.MessageBox(Pwidechar(t_s),'��ʾ',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;
//    if DrawGzm.FGzm.DeleteAllFootageData then begin
//        Optiontip(0,'���������ɹ�');
//        InitFootageGrid;
//    end;
end;

procedure TDrawBmp_From.Pop_Foot_DeleteStepClick(Sender: TObject);
begin
  DeleteOnRecordToFootage(FootageGrid,FootStringGrid_SelectRow);
end;

procedure TDrawBmp_From.Pop_Foot_onedayClick(Sender: TObject);
begin
  InsertNextDayFootage(FootageGrid,FootStringGrid_SelectRow,1);
end;

procedure TDrawBmp_From.Pop_Foot_PasteClick(Sender: TObject);
begin
    CopyDataToStringGridFromPaste(FootageGrid,FootStringGrid_SelectCol,FootStringGrid_SelectRow,1);
end;

procedure TDrawBmp_From.Pop_Foot_RefreshClick(Sender: TObject);
begin
//  InitFootageGrid;
//  DrawGzm.FGzm.ReadFootageDataToStringGrid(FootageGrid) ;
end;

procedure TDrawBmp_From.Pop_Foot_SaveClick(Sender: TObject);
var
  i:integer;
  t_s:string;
  Daoshu:integer;
begin
//   if DrawGzm.FGzm.Gzmbh <0 then exit;
//    DrawGzm.FGzm.DeleteAllFootageData;
//    Daoshu:=0;
//   for I := 2 to FootageGrid.RowCount-1 do  begin
//      if Trim(FootageGrid.Cells[0,i]) ='' then  break;
//      if Public_Basic.StrToInt_lu(FootageGrid.Cells[2,i]) < Public_Basic.StrToInt_lu(FootageGrid.Cells[10,i]) then
//         FootageGrid.Cells[2,i]:=FootageGrid.Cells[10,i];
//
//      if Public_Basic.StrToInt_lu(FootageGrid.Cells[2,i])<=DaoShu then   begin
//         inc(DaoShu);
//      end else  begin
//         Daoshu:=Public_Basic.StrToInt_lu(FootageGrid.Cells[2,i]);
//      end;
//
//      DrawGzm.FGzm.Manual_InputFootage(StrToDateTime(Trim(FootageGrid.Cells[1,i]),Public_Basic.FSetting),
//                                      Public_Basic.StrToDouble_Lu(FootageGrid.Cells[3,i]) ,  //downStepDis
//                                      Public_Basic.StrToDouble_Lu(FootageGrid.Cells[4,i]) ,  //autoDownFootage
//                                      Public_Basic.StrToDouble_Lu(FootageGrid.Cells[5,i]) ,  //EditDownFootage
//                                      Public_Basic.StrToDouble_Lu(FootageGrid.Cells[9,i]) ,  //UpperStepDis
//                                      Public_Basic.StrToDouble_Lu(FootageGrid.Cells[8,i]) ,  //autoUpperFootage
//                                      Public_Basic.StrToDouble_Lu(FootageGrid.Cells[7,i]) ,  //EditUpperFootage
//                                      Daoshu ,  //jinDaoshu
//                                      1   //flag
//                                      );
//
//
//   end;
//   t_s:= '���ݴ洢�ɹ���';
//   Application.MessageBox(Pwidechar(t_s),'��ʾ',MB_OK+MB_ICONQUESTION) ;
//   OptionTip(0,t_s);
//   // ˢ�±���
//   InitFootageGrid;
//   DrawGzm.FGzm.ReadFootageDataToStringGrid(FootageGrid) ;
end;

procedure TDrawBmp_From.Pop_Foot_UpdateDaoClick(Sender: TObject);
var
  i:integer;
begin
   if FootStringGrid_SelectCol=2 then  begin
      FootageGrid.Cells[10,FootStringGrid_SelectRow]:=FootageGrid.Cells[2,FootStringGrid_SelectRow];
   end else  if FootStringGrid_SelectCol=10 then  begin
      FootageGrid.Cells[2,FootStringGrid_SelectRow]:=FootageGrid.Cells[10,FootStringGrid_SelectRow];
   end else begin
      exit;
   end;

   for I := FootStringGrid_SelectRow+1 to FootageGrid.RowCount -1 do  begin
       if FootageGrid.Cells[10,i]<> ''  then  begin
          FootageGrid.Cells[10,i]:=IntTostr(Public_Basic.StrToInt_lu(FootageGrid.Cells[10,i-1])+1);
       end;

       if FootageGrid.Cells[2,i]<> ''  then  begin
          FootageGrid.Cells[2,i]:=IntTostr(Public_Basic.StrToInt_lu(FootageGrid.Cells[2,i-1])+1);
       end;

   end;



end;

procedure TDrawBmp_From.Pop_Foot_UpdateTimeClick(Sender: TObject);
begin
   UpdateTdateTimeFormCurrRow(FootageGrid,FootStringGrid_SelectRow);
end;

procedure TDrawBmp_From.Pop_Foot_Update_allDataClick(Sender: TObject);
begin
   RefreshFootageStringGrid;
end;

procedure TDrawBmp_From.Pop_Foot_Update_PartDataClick(Sender: TObject);
var
  CurrRow:integer;
begin
   CurrRow:=FootageGrid.RowCount-1;
   CurrRow:=UpdateShouDongInputFootae(FootageGrid,CurrRow,'Down');
   CurrRow:=FootageGrid.RowCount-1;
   CurrRow:=UpdateShouDongInputFootae(FootageGrid,CurrRow,'Up');

end;

procedure TDrawBmp_From.Pop_Rock_AutoClick(Sender: TObject);
begin
  UpdateBatInputData;
  RefreshRockPressStringGrid(SelectRockDataRecordNumber);
end;

procedure TDrawBmp_From.Pop_Rock_DeletaAllClick(Sender: TObject);
var
  t_s:string;
begin
   t_s:='��ȷ��Ҫɾ����������ô?';
   if Application.MessageBox(Pwidechar(t_s),'��ʾ',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

   if DrawGzm.FGzm.Gzmbh<1 then exit ;
       DrawGzm.FGzm.DeleteRockPressData(0,0,0);
    RefreshRockPressStringGrid(SelectRockDataRecordNumber);
end;

procedure TDrawBmp_From.Pop_Rock_DeleteOneClick(Sender: TObject);
var
  t_s:string;
  daoshu,Support,j:integer;
begin
   t_s:='��ȷ��Ҫɾ����ǰ�е�����ô?';
   if Application.MessageBox(Pwidechar(t_s),'��ʾ',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

   daoshu:=public_Basic.StrToInt_lu(RockDataGrid.Cells[2,RockStringGrid_SelectRow] );
   if (DrawGzm.FGzm.Gzmbh<1) and (Daoshu < 1) then exit ;

   for j := 4 to RockDataGrid.ColCount-1 do  begin
       Support:=public_Basic.StrToInt_lu(RockDataGrid.Cells[j,1] );
       if (daoshu>0) and (Support>0) then
       DrawGzm.FGzm.DeleteRockPressData(daoshu,Support,1);
   end;

    RefreshRockPressStringGrid(SelectRockDataRecordNumber);
end;

procedure TDrawBmp_From.Pop_Rock_Disp_300Click(Sender: TObject);
begin
    SelectRockDataRecordNumber:='300';
    RefreshRockPressStringGrid(SelectRockDataRecordNumber);
end;

procedure TDrawBmp_From.Pop_Rock_Disp_50Click(Sender: TObject);
begin
    SelectRockDataRecordNumber:='50';
     RefreshRockPressStringGrid(SelectRockDataRecordNumber);
end;

procedure TDrawBmp_From.Pop_Rock_Disp_AllClick(Sender: TObject);
begin
   SelectRockDataRecordNumber:='All';
   RefreshRockPressStringGrid(SelectRockDataRecordNumber);
end;

procedure TDrawBmp_From.Pop_Rock_Disp_MemoClick(Sender: TObject);
var
  sDT:String;
begin
   sDT:=RockDataGrid.Cells[RockStringGrid_SelectCol,RockStringGrid_SelectRow] ;
   if Trim(SDT)<> '' then begin
      CreateEditRockDataMemo(TabSheet11.Handle,
                             TabSheet11.Width,TabSheet11.Height,
                             '������:'+ RockDataGrid.Cells[2,RockStringGrid_SelectRow]+  '   '  +
                             '֧�ܱ��:' + RockDataGrid.Cells[RockStringGrid_SelectCol,1] + '   '  +
                             '����ֵ:' + SDT ,
                             RockDataRightGrid.Cells[RockStringGrid_SelectCol,RockStringGrid_SelectRow]
                             );
   end;

end;

procedure TDrawBmp_From.Pop_Rock_Input_MemoClick(Sender: TObject);
var
  sDT:String;
begin
   sDT:=RockDataGrid.Cells[RockStringGrid_SelectCol,RockStringGrid_SelectRow] ;
   if Trim(SDT)<> '' then begin
      CreateEditRockDataMemo(TabSheet11.Handle,
                             TabSheet11.Width,TabSheet11.Height,
                             '������:'+ RockDataGrid.Cells[2,RockStringGrid_SelectRow]+  '   '  +
                             '֧�ܱ��:' + RockDataGrid.Cells[RockStringGrid_SelectCol,1] + '   '  +
                             '����ֵ:' + SDT ,
                             RockDataRightGrid.Cells[RockStringGrid_SelectCol,RockStringGrid_SelectRow]
                             );
   end;
end;

procedure TDrawBmp_From.Pop_Rock_PasteClick(Sender: TObject);
begin
  CopyDataToStringGridFromPaste(self.RockDataGrid ,RockStringGrid_SelectCol,RockStringGrid_SelectRow,0);
end;

procedure TDrawBmp_From.Pop_Rock_RefreshClick(Sender: TObject);
begin
    RefreshRockPressStringGrid(SelectRockDataRecordNumber);
end;

procedure TDrawBmp_From.Pop_Rock_SaveClick(Sender: TObject);
var
  i,j,Daoshu,supportbh:integer;
  DataV:double;
  Memo,t_s:string;
  td:String;
begin
     DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,true,RockDataGrid.RowCount,RockDataGrid.ColCount);
    t_s:= '���ڱ������ݣ����ĵȴ�...';
    OptionTip(0,t_s);

    for I := 2 to RockDataGrid.RowCount -1  do  begin
       Daoshu:=Public_Basic.StrToInt_lu(Trim(RockDataGrid.Cells[2,i]));
      DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,1,0);
       if Daoshu <=0 then  break;
       for j := 4 to RockDataGrid.ColCount-1 do  begin
           supportbh:=Public_Basic.StrToInt_lu(Trim(RockDataGrid.Cells[j,1]));
           DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);
           if Supportbh<=0  then continue;
           // �Ѹ�����¼�����
           //DrawGzm.FGzm.DeleteRockPressData(Daoshu,Supportbh,1);
           if RockDataGrid_Edit.Cells[j,i]= '1'  then  begin  // ֤�����޸���
               DataV:=Public_Basic.StrToDouble_Lu(Trim(RockDataGrid.Cells[j,i]));
               if DataV <=1 then  continue;
               if DataPress_Unit_Flag =2 then //�����λ��bar
                  DataV:=DataV/10;
               if Trim(RockDataRightGrid.Cells[j,i])<> '' then  Memo:= Trim(RockDataRightGrid.Cells[j,i])
                  else Memo:='';
                 td:=Trim(RockDataGrid.Cells[1,i]);
                DrawGzm.FGzm.UpdateRockPressDataToDataBase(DaoShu,Supportbh,RG_Rock_DataType.ItemIndex,Memo,DataV) ;
               // DrawGzm.FGzm.SaveRockPressDataToDataBase(td,DaoShu,Supportbh,DataV,Memo);
           end;
       end;
    end;
    // �������ݿ�����ǰ¼��ȵ�ǰ��������ļ�¼
    if Daoshu >0 then    begin
       DrawGzm.FGzm.DeleteRockPressData(Daoshu,0,2);
    end;
   DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,False,0,0);

    t_s:= '���ݴ洢�ɹ���';
    Application.MessageBox(Pwidechar(t_s),'��ʾ',MB_OK+MB_ICONQUESTION) ;
    OptionTip(0,t_s);

end;

procedure TDrawBmp_From.Pop_Rock_SaveExcelClick(Sender: TObject);
var
  Tilte:string;
begin
   if self.RG_Rock_DataType.ItemIndex =0 then   begin
     Tilte:=s_MinName +'['+S_WorkFaceName+']������ÿ�ν���ѹ���������ֵ';
   end else if self.RG_Rock_DataType.ItemIndex =1 then   begin
     Tilte:=s_MinName +'['+S_WorkFaceName+']������ÿ�ν���ѹ������ƽ��ֵ';
   end else if self.RG_Rock_DataType.ItemIndex =2 then   begin
     Tilte:=s_MinName +'['+S_WorkFaceName+']������ÿ�ν���ѹ������ĩ����';
   end else if self.RG_Rock_DataType.ItemIndex =3 then   begin
     Tilte:=s_MinName +'['+S_WorkFaceName+']������ÿ�ν���ѹ������ͬһʱ��ץȡֵ';
   end else if self.RG_Rock_DataType.ItemIndex =4 then   begin
     Tilte:=s_MinName +'['+S_WorkFaceName+']������ÿ�ν���ѹ�������ֶ�¼��ֵ';
   end;


   Public_Basic.StringGridtoExcel(Tilte,RockDataGrid,14 );
end;

procedure TDrawBmp_From.LeftVisiblePanelClick(Sender: TObject);
begin
    if leftPageControl.Visible  then   begin
       leftPageControl.Visible :=false;
       leftVisiblePanel.Caption :='>>';
       leftVisiblePanel.Width:=10;
       leftVisiblePanel.Color:=clYellow;
    end else begin
       leftPageControl.Visible :=true;
       leftVisiblePanel.Caption :='<<';
       leftVisiblePanel.Width:=10;
       leftVisiblePanel.Color:=clBtnFace;
    end;
     setLeftToolVisible(leftPageControl.Visible);

end;

function TDrawBmp_From.ZoomRect(mRect: TRect; mZoom: Integer): TRect;
begin
  Result.Left := mRect.Left - mZoom;
  Result.Right := mRect.Right + mZoom;
  Result.Top := mRect.Top;// - mZoom;
  Result.Bottom := mRect.Bottom- mZoom;
end;

procedure TDrawBmp_From.RG_XAxisClick(Sender: TObject);
begin
    if RG_XAxis.ItemIndex =0 then begin
       Edit_Axis.Enabled :=False;
    end else begin
       Edit_Axis.Enabled :=true;
    end;
end;

procedure TDrawBmp_From.RecallLoadDataToDataBase(Value:Boolean);
begin
     ContourPop_loadData.Enabled :=Value;
     if not  Value then
        contourPop_KYFX.Enabled :=Value;
end;

procedure TDrawBmp_From.RefreshContourlegendPalette;
begin
    ContourChart.Legend.Visible :=true;
//    if DataPress_Unit_Flag=1 then  begin
//       ContourChart.Legend.Title.Text.Text :='MPa';
//    end else begin
//       ContourChart.Legend.Title.Text.Text :='Bar';
//    end;
    ContourChart.Legend.Transparent:=true;
    ContourChart.AutoRepaint :=true;
    ContourChart.Refresh;
    


end;

procedure TDrawBmp_From.RefreshFootageStringGrid;
var
  CurrRow:integer;
begin
  CurrRow:=FootageGrid.RowCount-1;
  while CurrRow >1 do
       CurrRow:=UpdateShouDongInputFootae(FootageGrid,CurrRow,'Down');

  CurrRow:=FootageGrid.RowCount-1;
  while CurrRow >1 do
       CurrRow:=UpdateShouDongInputFootae(FootageGrid,CurrRow,'UP');
end;

procedure TDrawBmp_From.RefreshForm;
begin
     {��ʼ��ʱ�����ѡ��Ŀؼ����� }
    InitDateTimeFootage ;
    {��ʼ����ú���������¼���� ��ѹ�����ֶ�¼��}
    initInputRockPressData ;

    {����ContourChart ��ͼ ��ɫ���Ʊ���  }
   // DisPoseContourGroupColor
end;

procedure TDrawBmp_From.RefreshInputData;
begin
     GetTimeAndFootage;
     GetDataClass;
end;

procedure TDrawBmp_From.RefreshMemoInfo(Memo:TMemo);
begin
     Memo.Clear ;
     Memo.Lines.Add('ѡ����������:'+DrawGzm.GraphClass.DataName);
     Memo.Lines.Add('�Ѿ�ѡ��:'+DrawGzm.GraphClass.SupportList);
end;

procedure TDrawBmp_From.RefreshMyCloudChart;
begin
   GetDataClass;
    // ������ͼ
   DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,true,100,100);
   DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);


   DrawGzm.RefreshChart_ConTourSeries(ContourChart,self.ContourSeries,FirstPGBAr,SecondPGBar);

   RefreshContourlegendPalette;
   DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,False,0,0);
   // ����ͼƬ
   ContourChartSaveIntoBMP('');
end;

procedure TDrawBmp_From.RefreshOldStepAddToMapSeries(Visible: Boolean);
var
  Vis:Boolean;
begin
     //��������ѡ��
     GetDataClass;
     if DrawGzm.FGzm.RockPressAnalysis.StepFillIsTran =0  then
              Vis:=true else Vis:=False;
      //�����������ˢ��
     DrawGzm.Auto_Judge_OldStep.Refresh;
     if Visible then  begin    // ������ͼ�Ƿ���ʾ
        DisplyMapSeries(MapSeries,DrawGzm.Auto_Judge_OldStep,
                     Vis,
                     DrawGzm.FGzm.RockPressAnalysis.StepFillColor,
                     DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide
                     );
     end else begin
         MapSeries.Visible :=False;
     end;

      MainTreeView(TreeView1,'Series');

      LineSeries.Clear ;

     // �ı����ģʽ
     DrawGzm.MapSeriesEditState:=1;
     But_Kyfx_Depth_Fx.Enabled :=true;
    // SetMapSeriesIndexIntoOldStep(MapSeries,DrawGzm.Auto_Judge_OldStep);
end;

procedure TDrawBmp_From.RefreshRockPressStringGrid(Flag: string);
var
  MaxDaoshu:Integer;
begin
  InitRockDataGrid;
  if DrawGzm.FGzm.Gzmbh<1 then exit ;

  MaxDaoshu:=DrawGzm.FGzm.ReturnRockPressDataMaxDaoshu;
   if Flag='50' then  begin
      DrawGzm.FGzm.ReadFootageDataToRockDataGrid(RockDataGrid ,RockDataRightGrid,RockDataGrid_Edit,
                        MaxDaoshu-50) ;
      DrawGzm.FGzm.ReadRockPressDataToStrGrid(RockDataGrid,RockDataRightGrid,RockDataGrid_Edit,
                        MaxDaoshu-50,DataPress_Unit_Flag,RG_Rock_DataType.ItemIndex);
   end else if Flag='300' then  begin
      DrawGzm.FGzm.ReadFootageDataToRockDataGrid(RockDataGrid ,RockDataRightGrid,RockDataGrid_Edit,
                        MaxDaoshu-300) ;
      DrawGzm.FGzm.ReadRockPressDataToStrGrid(RockDataGrid,RockDataRightGrid,RockDataGrid_Edit,
                        MaxDaoshu-300,DataPress_Unit_Flag,RG_Rock_DataType.ItemIndex);
   end else if Flag='All' then  begin
      DrawGzm.FGzm.ReadFootageDataToRockDataGrid(RockDataGrid ,RockDataRightGrid,RockDataGrid_Edit,
                        0) ;
      DrawGzm.FGzm.ReadRockPressDataToStrGrid(RockDataGrid,RockDataRightGrid,RockDataGrid_Edit,
                        0,DataPress_Unit_Flag,RG_Rock_DataType.ItemIndex);
   end;

   self.ScrollBar1.Max:=RockDataGrid.RowCount;
end;

procedure TDrawBmp_From.RefreshSize;
begin
    //GB_DW.Height :=Round(TabSheet1.Height/3);
//    ChartYun.Top :=Round(TabSheet4.Height/6);
//    ChartYun.Left:=0;
//    ChartYun.Width:= Round(TabSheet4.Width*5/5);
//    ChartYun.Height:=Round(TabSheet4.Height*2/3);

end;

procedure TDrawBmp_From.ReModiFyStepOldClass(OldStep: TOldSteps;
  EditMapRec: TEditMapSeriesRe);
var
  i:integer;
begin
   for I := 0 to 7 do
     OldStep.ExSteps[EditMapRec.StepClassid].SetMyOutLinePoint(
              i,
              EditMapRec.tmpPoints[i]
              );
    OldStep.ExSteps[EditMapRec.StepClassid].ModifyData :=1; // ��ʾ���ݱ��޶�
    OldStep.ExSteps[EditMapRec.StepClassid].Used :=1;
   //ˢ��һ������
   OldStep.ExSteps[EditMapRec.StepClassid].Refresh ;
   Optiontip(1,'���ݴ洢�ɹ���');
end;

procedure TDrawBmp_From.ResultPop_OpenLefttoolClick(Sender: TObject);
begin
  setLeftToolVisible(not leftPageControl.Visible);
end;

procedure TDrawBmp_From.ResultPop_OpenRightToolClick(Sender: TObject);
begin
  SetRightToolVisible(not RightPageControl.Visible);
end;

procedure TDrawBmp_From.ResultPop_Print_PhaseClick(Sender: TObject);
begin
  DrawGzm.CloudClass.PrintDispPhaseVisual:=false;
    if  DrawGzm.Auto_Judge_OldStep.isCalComeStep  then  begin
       InitKyfxResultStringGrid;
       DrawGzm.CalComeStepAndPrintToMemo(Memo_Result,StringGrid_Result);
   end;
end;

procedure TDrawBmp_From.ResultPop_Print_wholeClick(Sender: TObject);
begin
    DrawGzm.CloudClass.PrintDispPhaseVisual:=true;
   if  DrawGzm.Auto_Judge_OldStep.isCalComeStep  then  begin
       InitKyfxResultStringGrid;
       DrawGzm.CalComeStepAndPrintToMemo(Memo_Result,StringGrid_Result);
   end;
end;

procedure TDrawBmp_From.ResultPop_SaveExcelClick(Sender: TObject);
begin
   Public_Basic.StringGridtoExcel('��ѹ�������',self.StringGrid_Result,14 );
end;

procedure TDrawBmp_From.ResultPop_SaveTxtClick(Sender: TObject);
begin
       SaveDialog1.Filter :='���ı��ļ�(*.txt)|*.txt';
       SaveDialog1.Title :='*.txt';
       if SaveDialog1.Execute =true then  begin
          if ExtractFileExt(SaveDialog1.FileName) <> '.txt' then
                 SaveDialog1.FileName := ChangeFileExt(SaveDialog1.FileName,'.txt');
          SaveResultIntoFile(self.Memo_Result,SaveDialog1.FileName);
       end;

end;

procedure TDrawBmp_From.Return_CallEditDateTime(DTS: String);
begin
   self.FootageGrid.Cells[1,FootStringGrid_SelectRow]:= DTS;
end;

procedure TDrawBmp_From.Return_CallEditRockPressMemo(DTS: String);
begin
  self.RockDataRightGrid.Cells[ RockStringGrid_SelectCol,RockStringGrid_SelectRow]:=DTS;
end;

procedure TDrawBmp_From.RG_Graph_MainClick(Sender: TObject);
begin
   if RG_Graph_Main.ItemIndex =0 then   begin
      CheckListBox_phase.Checked[0]:=true;
      CheckListBox_phase.Enabled :=true;
      CheckListBox_Support.Enabled :=false;
   end else begin
      CheckListBox_Support.Checked[0]:=true;
      CheckListBox_phase.Enabled :=false;
      CheckListBox_Support.Enabled :=true;
   end;
   Memo_info.Clear ;
end;

procedure TDrawBmp_From.RG_JD_BasicClick(Sender: TObject);
begin
  if RG_JD_Basic.ItemIndex =0 then begin
     self.Edit_JD_support.Text:='10';
  end else if RG_JD_Basic.ItemIndex =1 then begin
     Edit_JD_support.Text:=intToStr(Public_Basic.StrToInt_lu(self.Edit_SupportNumber.Text) div 2 );
  end else begin
     Edit_JD_support.Text:=intToStr(Public_Basic.StrToInt_lu(self.Edit_SupportNumber.Text)-10 );
  end;


end;

procedure TDrawBmp_From.RG_Rock_DataTypeClick(Sender: TObject);
begin
   RefreshRockPressStringGrid(SelectRockDataRecordNumber);
end;

procedure TDrawBmp_From.RG_Step_FillClick(Sender: TObject);
begin
   if RG_Step_Fill.ItemIndex =0 then   begin
       Label_FillColor.Caption :='���������ɫ';
       self.Edit_Fill_Line_Wide.Enabled :=true;
       self.Edit_Step_TranC.Enabled :=false;
   end else begin
       Label_FillColor.Caption :='�����ɫ';
       self.Edit_Fill_Line_Wide.Enabled :=False;
       self.Edit_Step_TranC.Enabled :=true;
   end;

end;

procedure TDrawBmp_From.RG_Yun_CycleClick(Sender: TObject);
begin
    RecallLoadDataToDataBase(true);
end;

procedure TDrawBmp_From.RG_Yun_MainClick(Sender: TObject);
begin
    if RG_Yun_Main.ItemIndex =2 then  begin  //�ֶ� ¼������
       RG_Yun_Cycle.Enabled :=true;
       RG_Yun_DataType.Enabled :=False;
       RG_Yun_Cycle.ItemIndex :=1;
    end else begin
       RG_Yun_Cycle.ItemIndex :=1;
       RG_Yun_DataType.Enabled :=true;
       RG_Yun_Cycle.Enabled :=true;
       RG_Yun_DataType.ItemIndex :=2;
    end;

//    LoadDataBtn.Enabled :=true;

 // UpdateImageBtn.Enabled:=False;
end;

procedure TDrawBmp_From.RightVisiblePanelClick(Sender: TObject);
begin
    if RightPageControl.Visible  then   begin
       RightPageControl.Visible :=false;
       RightVisiblePanel.Caption :='<<';
       RightVisiblePanel.Width:=10;
       RightVisiblePanel.Color:=clYellow;
    end else begin
       RightPageControl.Visible :=true;
       RightVisiblePanel.Caption :='>>';
       RightVisiblePanel.Width:=10;
       RightVisiblePanel.Color:=clBtnFace;
    end;
     setRightToolVisible(RightPageControl.Visible);
end;

procedure TDrawBmp_From.RockDataGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  iRect:TRect;
begin
     with RockDataGrid do  begin
          if ((ACol >=0) and (ACol<=3) ) or (ARow=0) or (ARow=1) then       begin
            iRect:=ZoomRect(Rect, 1);
            if ARow=0 then  begin
                Canvas.Font.Color   :=   clBlue; //������ɫΪ���
                Canvas.Brush.color:=clYellow; //����Ϊ ��Ԫ��ɫ
            end else begin
                Canvas.Font.Color   :=   clBlack; //������ɫΪ���
                Canvas.Brush.color:=clMoneyGreen; //����Ϊ ��Ԫ��ɫ
            end;

            Canvas.FillRect(iRect);
            Canvas.TextOut(Rect.Left+2,Rect.Top+2,Cells[ACol,ARow]);
         end;

         if (Trim(RockDataRightGrid.Cells[ACol,ARow])<>'' ) and (ACol>3)  then begin
            iRect:=ZoomRect(Rect, 1);
                Canvas.Font.Color   :=   clBlack; //������ɫΪ���
                Canvas.Brush.color:=clFuchsia; //����Ϊ ��Ԫ��ɫ
            Canvas.FillRect(iRect);
            Canvas.TextOut(Rect.Left+2,Rect.Top+2,Cells[ACol,ARow]);
         end;


      end;
end;

procedure TDrawBmp_From.RockDataGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 pt:TPoint;
 col, row: Longint;
begin
   RockDataGrid.MouseToCell(X, Y, col, row);

   if Button=mbRight then  begin
      pt:= RockDataGrid.ClientToScreen(Point(0,0));
      Mouse_x:=pt.X+x;
      Mouse_y:=Pt.Y+y;
      RockStringGrid_SelectCol :=col;
      RockStringGrid_SelectRow := row;
      DispRockDataPopMumu(Mouse_x,Mouse_y,RockStringGrid_SelectCol,RockStringGrid_SelectRow);

   end else if Button = mbLeft then  begin
       if row <> RockStringGrid_SelectRow then  begin
          RockStringGrid_SelectRow := row;
          RockDataGrid.Repaint;
       end;
       RockDataGrid_edit.Cells[col,Row]:='1';
   end;



end;

procedure TDrawBmp_From.RockDataGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
   RockStringGrid_SelectCol:=ACol;
   RockStringGrid_SelectRow:=ARow;
   RockDataRightGrid.Row:= ARow;
end;

procedure TDrawBmp_From.RockDataRightGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  iRect:TRect;
begin
     with RockDataRightGrid do  begin
          if ((ACol >=0) and (ACol<=1) ) or (ARow=0) or (ARow=1) then       begin
            iRect:=ZoomRect(Rect, 1);
             if ARow=0 then  begin
                Canvas.Font.Color   :=   clBlue; //������ɫΪ���
                Canvas.Brush.color:=clYellow; //����Ϊ ��Ԫ��ɫ
            end else begin
                Canvas.Font.Color   :=   clBlack; //������ɫΪ���
                Canvas.Brush.color:=clMoneyGreen; //����Ϊ ��Ԫ��ɫ
            end;
            Canvas.FillRect(iRect);
            Canvas.TextOut(Rect.Left+2,Rect.Top+2,Cells[ACol,ARow]);
         end;

//          if (State = []) and (FootStringGrid_SelectRow = ARow) then  begin
//             Canvas.Brush.Color := clSkyBlue;
//             Canvas.FillRect(Rect);
//             Canvas.TextOut(Rect.left , Rect.top, Cells[ACol, ARow]);
//          end;
      end;

end;

procedure TDrawBmp_From.RockPressDataAnalysis(Series: TContourSeries);
{
  ��ѹ���ݷ���ģ��
  ��Ҫ����˼· �� Series ��ͼ����ȡ����
}
var
    i, j, m: Integer;
    lvl: TContourLevel;
    seg: TLevelSegment;

begin
      GB_Ky_Memo1.Clear ;
      for I := Series.Levels.Count-1 downto 0 do  begin
          lvl:=series.Levels.Items[i];
          GB_Ky_Memo1.Lines.Add('Level: ' + IntToStr(i) + ', UpToValue: ' + FormatFloat('#,##0.###', lvl.UpToValue));
          DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
          for j:=0 to length(lvl.Segments)-1 do
          begin
            DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
            seg:=lvl.Segments[j];
            GB_Ky_Memo1.Lines.Add('Segment: ' + IntToStr(j));

            for m:=0 to length(seg.Points)-1 do
            begin
               DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);
              GB_Ky_Memo1.Lines.Add('Point[' + IntToStr(m) + ']: (' + FormatFloat('#,##0.###', seg.Points[m].X) +
                     ',' + FormatFloat('#,##0.###', seg.Points[m].Y) + ')');
            end;

            GB_Ky_Memo1.Lines.Add('');
          end;

          GB_Ky_Memo1.Lines.Add('');

      end;

end;

function TDrawBmp_From.SaveResultIntoFile(Memo1: TMemo;
  FileName: String): Boolean;
begin
   Memo1.Lines.SaveToFile(FileName);
end;

procedure TDrawBmp_From.SaveWorkFaceMemo1Text;
var
  StrValue:String;
  i:integer;
begin
   StrValue:='';
   if DrawGzm.FGzm.Gzmbh <1 then exit;
      DrawGzm.FGzm.RockPressAnalysis.Oneday_daoshu:=Public_Basic.StrToInt_lu(Trim(ComboFootSteps.Text));
      DrawGzm.FGzm.RockPressAnalysis.TwoDao_IntervalTime:=Public_Basic.StrToInt_lu(Trim(ComboBoxStepTime.Text));
      DrawGzm.FGzm.RockPressAnalysis.OneDao_step:=Public_Basic.StrTodouble_lu(Trim(Footsteps_L.Text));
      DrawGzm.FGzm.RockPressAnalysis.ManulInput_Interval_support:=Public_Basic.StrToInt_lu(Trim(Edit_interVal_support.Text));

    if Public_Basic.StrToInt_lu(self.ComboFootSteps.Text)>0 then
      StrValue:=Trim(ComboFootSteps.Text) +',';
    if Public_Basic.StrToInt_lu(self.ComboBoxStepTime.Text)>0 then
      StrValue:=StrValue+Trim(ComboBoxStepTime.Text) +',';
    if Public_Basic.StrToDouble_Lu(self.Footsteps_L.Text)>0 then
      StrValue:=StrValue+Trim(Footsteps_L.Text) +',';
    if Public_Basic.StrToDouble_Lu(self.Edit_interVal_support.Text)>0 then
      StrValue:=StrValue+Trim(Edit_interVal_support.Text)+',';

      StrValue:=StrValue+IntToStr(self.RG_JD_Basic.ItemIndex)+',';
    if Public_Basic.StrToInt_lu(self.Edit_JD_Support.Text)>0 then
      StrValue:=StrValue+Trim(Edit_JD_Support.Text)+',';

      StrValue:=StrValue+IntToStr(self.RG_JD_Time.ItemIndex);

    // �ϳ���ɫ�ַ���
    StringGroupColor:=MakeStringGroupColorToString;
    if  length(Trim(StringGroupColor)) >0 then    begin
        StrValue:=StrValue+'&'+StringGroupColor;
    end;

    if DrawGzm.FGzm.UpdataFootStepParameters(StrValue,self.Edit_SupportNumber.Text) then
       OptionTip(0,'���ݸ��³ɹ�!') else   OptionTip(0,'���ݸ���ʧ��!')



end;

procedure TDrawBmp_From.SaveWorkFaceMemo2Text(lx:String);
var
  StrValue:String;
  Kid:integer;
begin
   StrValue:='';
   if DataPress_Unit_Flag =1 then   begin
      Kid:=1;
   end else begin
      Kid:=10;
   end;
   if DrawGzm.FGzm.Gzmbh <1 then exit;
      DrawGzm.FGzm.RockPressAnalysis.RP_Start_pt:=Public_Basic.StrTodouble_lu(Trim(Edit_startpt.Text))/kid;
      DrawGzm.FGzm.RockPressAnalysis.RP_End_Pt:=Public_Basic.StrTodouble_lu(Trim(Edit_Endpt.Text))/kid;
      DrawGzm.FGzm.RockPressAnalysis.AnalysisSenstive:=self.ComboBox_KY_Lmd.ItemIndex ;
      DrawGzm.FGzm.RockPressAnalysis.Continue_SupNumber:=Public_Basic.StrToInt_lu(Trim(Edit_sup_con.Text));
      DrawGzm.FGzm.RockPressAnalysis.conTinue_Footage:=Public_Basic.StrToInt_lu(Trim(Edit_Foot_con.Text));
      DrawGzm.FGzm.RockPressAnalysis.Min_Pt:=Public_Basic.StrTodouble_lu(Trim(Edit_Min_pt.Text))/kid;
      DrawGzm.FGzm.RockPressAnalysis.StepGroundFilled:=self.RG_Step_Ground_Fill.ItemIndex;
      DrawGzm.FGzm.RockPressAnalysis.StepFillIsTran:=self.RG_Step_Fill.ItemIndex;
      DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide:=Public_Basic.StrToInt_lu(Trim(Edit_Fill_Line_Wide.Text));
      DrawGzm.FGzm.RockPressAnalysis.StepFillColor:=StepColorBox.Selected ;
      DrawGzm.FGzm.RockPressAnalysis.SetpFillTran:= Public_Basic.StrToInt_lu(Trim(Edit_Step_TranC.Text));
      DrawGzm.FGzm.RockPressAnalysis.JudgeMInQD :=Public_Basic.StrTodouble_lu(Trim(Edit_MinQd.Text));

      if lx='save' then begin
          StrValue:=FormatFloat('0.0',DrawGzm.FGzm.RockPressAnalysis.RP_Start_pt) +',';        //0
          StrValue:=StrValue+FormatFloat('0.0',DrawGzm.FGzm.RockPressAnalysis.RP_End_Pt)+',';  // 1
          StrValue:=StrValue+IntTostr(ComboBox_KY_Lmd.ItemIndex) +',';                       //2
          StrValue:=StrValue+intToStr(DrawGzm.FGzm.RockPressAnalysis.Continue_SupNumber) +','; //3
          StrValue:=StrValue+intToStr(DrawGzm.FGzm.RockPressAnalysis.conTinue_Footage) +',' ;  //4
          StrValue:=StrValue+FormatFloat('0.0',DrawGzm.FGzm.RockPressAnalysis.Min_Pt)+',';    //5
          StrValue:=StrValue+intToStr(DrawGzm.FGzm.RockPressAnalysis.StepGroundFilled) +',';  //6
          StrValue:=StrValue+intToStr(DrawGzm.FGzm.RockPressAnalysis.StepFillIsTran) +',' ;   //7
          StrValue:=StrValue+intToStr(DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide) +',';  //8
          StrValue:=StrValue+intToStr(DrawGzm.FGzm.RockPressAnalysis.StepFillColor) +',' ;    //9
          StrValue:=StrValue+intToStr(DrawGzm.FGzm.RockPressAnalysis.SetpFillTran)+ ',' ;          //10
          StrValue:=StrValue+intToStr(DrawGzm.FGzm.RockPressAnalysis.SelectedFillColor) +',' ;         //11
          StrValue:=StrValue+FormatFloat('0.0',DrawGzm.FGzm.RockPressAnalysis.JudgeMInQD);           //12
          //
          StrValue:=StrValue+ '&' + self.MakeStringGridPhaseToString;

          if DrawGzm.FGzm.UpdateRockPressParameters(StrValue) then
              OptionTip(0,'���ݸ��³ɹ�!') else   OptionTip(0,'���ݸ���ʧ��!')
      end;



end;

procedure TDrawBmp_From.ScrollBar1Change(Sender: TObject);
begin
   if ScrollBar1.Position>=2 then  begin
     RockDataGrid.TopRow :=ScrollBar1.Position ;
     RockDataRightGrid.TopRow :=ScrollBar1.Position ;
   end;
end;

function TDrawBmp_From.SetAnalysisSenstive(Index: integer): Boolean;
var
  kk:integer;
begin
   ReSult:=False;
   if DataPress_Unit_Flag=2 then  KK:=10 else kk:=1;

   DrawGzm.FGzm.RockPressAnalysis.AnalysisSenstive:=Index;
   if index=0 then  begin // �����Ⱥܸ�
      DrawGzm.FGzm.RockPressAnalysis.Continue_SupNumber:=2;
      DrawGzm.FGzm.RockPressAnalysis.conTinue_Footage:=1;
      DrawGzm.FGzm.RockPressAnalysis.JudgeMInQD :=0.1;
      DrawGzm.FGzm.RockPressAnalysis.NearColorLineUp_DownValue :=1;
      DrawGzm.FGzm.RockPressAnalysis.NearTwoStepDaoValue :=2;
      DrawGzm.FGzm.RockPressAnalysis.NearTwoStepAGvData_BS :=1;
      DrawGzm.FGzm.RockPressAnalysis.Min_Pt:=DrawGzm.FGzm.RockPressAnalysis.RP_End_Pt*0.96;
   end else if  index=1 then  begin // �����Ƚϸ� then
      DrawGzm.FGzm.RockPressAnalysis.Continue_SupNumber:=4;
      DrawGzm.FGzm.RockPressAnalysis.conTinue_Footage:=1;
      DrawGzm.FGzm.RockPressAnalysis.JudgeMInQD :=0.4;
      DrawGzm.FGzm.RockPressAnalysis.NearColorLineUp_DownValue :=1;
      DrawGzm.FGzm.RockPressAnalysis.NearTwoStepDaoValue :=4;
      DrawGzm.FGzm.RockPressAnalysis.NearTwoStepAGvData_BS :=1.1;
      DrawGzm.FGzm.RockPressAnalysis.Min_Pt:=DrawGzm.FGzm.RockPressAnalysis.RP_End_Pt*0.95;
   end else if  index=2 then  begin // ������һ�� then
      DrawGzm.FGzm.RockPressAnalysis.Continue_SupNumber:=5;
      DrawGzm.FGzm.RockPressAnalysis.conTinue_Footage:=2;
      DrawGzm.FGzm.RockPressAnalysis.JudgeMInQD :=0.4;
      DrawGzm.FGzm.RockPressAnalysis.NearColorLineUp_DownValue :=1;
      DrawGzm.FGzm.RockPressAnalysis.NearTwoStepDaoValue :=6;
      DrawGzm.FGzm.RockPressAnalysis.NearTwoStepAGvData_BS :=1.1;
      DrawGzm.FGzm.RockPressAnalysis.Min_Pt:=DrawGzm.FGzm.RockPressAnalysis.RP_End_Pt*0.96-1;
   end else begin  // �����Ƚϵ�
      DrawGzm.FGzm.RockPressAnalysis.Continue_SupNumber:=6;
      DrawGzm.FGzm.RockPressAnalysis.conTinue_Footage:=3;
      DrawGzm.FGzm.RockPressAnalysis.JudgeMInQD :=0.6;
      DrawGzm.FGzm.RockPressAnalysis.NearColorLineUp_DownValue :=1;
      DrawGzm.FGzm.RockPressAnalysis.NearTwoStepDaoValue :=8;
      DrawGzm.FGzm.RockPressAnalysis.NearTwoStepAGvData_BS :=1.2;
      DrawGzm.FGzm.RockPressAnalysis.Min_Pt:=DrawGzm.FGzm.RockPressAnalysis.RP_End_Pt*0.96-2;
   end;

  
   // ���������ֵ
   Edit_MinQd.Text := FormatFloat('0.00',DrawGzm.FGzm.RockPressAnalysis.JudgeMInQD);
   Edit_Sup_Con.Text:=IntTostr(DrawGzm.FGzm.RockPressAnalysis.Continue_SupNumber);
   Edit_Foot_Con.Text :=IntTostr(DrawGzm.FGzm.RockPressAnalysis.conTinue_Footage);
   self.Edit_Min_Pt.Text :=FormatFloat('0.00',DrawGzm.FGzm.RockPressAnalysis.Min_Pt*KK);
   Result:=True;
end;

procedure TDrawBmp_From.SetContourSeriseZoomUsed(Value: Boolean);
begin
     // ContourPop_LeftZoom
   if CurrentChart='TwoDimChart'  then    begin
      if Value then  begin
          ContourChart.Zoom.MouseButton := mbLeft;
          ContourPop_LeftZoom.Caption :='ֹͣ����Ŵ���';
        //  self.ContourChart_Cursor.Active:=false;
      end else begin
          if ContourChart.Zoom.MouseButton=mbLeft then  begin
              ContourChart.Zoom.MouseButton := mbMiddle;
              ContourPop_LeftZoom.Caption :='��������Ŵ���';
            //  self.ContourChart_Cursor.Active:=true;
          end else begin
              ContourChart.Zoom.MouseButton := mbLeft;
              ContourPop_LeftZoom.Caption :='ֹͣ����Ŵ���';
             // self.ContourChart_Cursor.Active:=false;
          end;
      end;
   end;
end;

procedure TDrawBmp_From.SetCusorShizhiVisible(Value: Boolean);
begin
    if Value then    begin
        ContourPop_Shizhi.Caption :='�ر�ʮ�ֹ����';
        ContourChart_Cursor.Visible :=true;
    end else  begin
        ContourPop_Shizhi.Caption :='��ʮ�ֹ����';
        ContourChart_Cursor.Visible :=FALSE;
    end;
end;

procedure TDrawBmp_From.setLeftToolVisible(Value: Boolean);
begin

    if Value then    begin
        ContourPop_Lefttool.Caption :='�ر���๤����';
        ResultPop_OpenLefttool.Caption :='�ر���๤����';
        LeftPageControl.Visible :=true;
    end else  begin
        ContourPop_Lefttool.Caption :='����๤����';
        ResultPop_OpenLefttool.Caption:='����๤����';
        LeftPageControl.Visible :=False;
    end;
end;


procedure TDrawBmp_From.SetOldStepVisible(Value: Boolean);
begin
     {contourPop_Disp_Step}
    if Value then    begin
        contourPop_Disp_Step.Caption :='������ѹ��־��ͼ';
        DrawGzm.CloudClass.OldStepDisplay:=true;

    end else  begin
        contourPop_Disp_Step.Caption :='������ѹ��־��ͼ';
        DrawGzm.CloudClass.OldStepDisplay:=False;

    end;
end;

procedure TDrawBmp_From.SetPolygenProperty(OneStep:TOldOneStep;CeatePoint:Boolean;
     Apol:TTeePolygon;Tran:Boolean; MC:TColor;LineW:integer);
var
  i,PointIndex:integer;
begin
   Apol.Transparency:=DrawGzm.FGzm.RockPressAnalysis.SetpFillTran;
   Apol.Transparent:=Tran;
   Apol.Color :=Mc;
   Apol.Pen.Color :=MC;
   Apol.Pen.Width :=LineW;
   if CeatePoint then
      for i := 0 to 7 do  begin
           PointIndex:=APol.Points.AddXY(OneStep.MyOutLinePoint[i].x ,OneStep.MyOutLinePoint[i].Y);
           OneStep.MyOutLinePoint[i].PointId := PointIndex;
      end;
end;



procedure TDrawBmp_From.SetRightToolVisible(Value: Boolean);
begin
   //ContourPop_RightTool
    if Value then    begin
        ContourPop_RightTool.Caption :='�ر��Ҳ๤����';
        ResultPop_OpenRightTool.Caption:= '�ر��Ҳ๤����';
        RightPageControl.Visible :=true;
        ChartPageControl.ActivePageIndex :=0;
    end else  begin
        ContourPop_RightTool.Caption :='���Ҳ๤����';
        ResultPop_OpenRightTool.Caption:= '���Ҳ๤����';
        RightPageControl.Visible :=False;
    end;
end;

procedure TDrawBmp_From.SplitStringGridPhase;
begin
    if not DrawGzm.Auto_Judge_OldStep.SplitPhaseString(DrawGzm.FGzm.RockPressAnalysis.OldStepPhaseString)  then exit;
    if DrawGzm.Auto_Judge_OldStep.PhaseNumber >2 then
        CB_PhaseNumber.ItemIndex:= DrawGzm.Auto_Judge_OldStep.PhaseNumber div 2 -1 ;
end;

procedure TDrawBmp_From.splitStringGroupColor;
var
   s_temp,s2:Str_DT_array;
   C1,C2,i:integer;
begin
   if length(trim(StringGroupColor))>0 then   begin
         s_temp:=Public_Basic.split(StringGroupColor,';',C1);
         if C1> 0 then  begin
            DrawGzm.MyContourColor_NumLevel:=Public_Basic.StrToInt_lu(s_temp[0]) ;
         end else begin
            exit;
         end;

          for I := 0 to DrawGzm.MyContourColor_NumLevel-1 do  begin
              S2:=Public_Basic.split(s_temp[i+1],',',C2);
              if C2>0  then  begin
                 DrawGzm.MyContourColor[i].UpToValue :=Public_Basic.StrToInt_lu(S2[0]) ;
                 DrawGzm.MyContourColor[i].ContourColor :=Public_Basic.StrToInt_lu(S2[1]) ;
                 DrawGzm.MyContourColor[i].xh :=i+1;
              end;
          end;
   end;

end;

procedure TDrawBmp_From.SplitWorkFaceMemo1Text;
begin
   if DrawGzm.FGzm.Gzmbh <1 then exit;
   // ���߱���ά��
   DrawGzm.FGzm.InputGzmData(DrawGzm.FGzm.Gzmbh);
   if not DrawGzm.FGzm.splitFootStepParameters then begin
       DrawGzm.FGzm.RockPressAnalysis.Oneday_daoshu:=10;
       DrawGzm.FGzm.RockPressAnalysis.TwoDao_IntervalTime:=90;
       DrawGzm.FGzm.RockPressAnalysis.OneDao_step:=0.865;
       DrawGzm.FGzm.RockPressAnalysis.ManulInput_Interval_support:=5;
       if DrawGzm.FGzm.SupEndNumber < 1 then
          DrawGzm.FGzm.SupEndNumber:=200;
       DrawGzm.FGzm.RockPressAnalysis.JinDao_Basic:=1;
       DrawGzm.FGzm.RockPressAnalysis.JinDao_Support:=100;
       DrawGzm.FGzm.RockPressAnalysis.JinDao_Time:=0;
   end;
   StringGroupColor:='';
   ComboFootSteps.Text  :=intTostr(DrawGzm.FGzm.RockPressAnalysis.Oneday_daoshu);
   ComboBoxStepTime.Text :=intTostr(DrawGzm.FGzm.RockPressAnalysis.TwoDao_IntervalTime);
   Footsteps_L.Text :=FormatFloat('0.000',DrawGzm.FGzm.RockPressAnalysis.OneDao_step);
   Edit_SupportNumber.Text :=InttoStr(DrawGzm.FGzm.SupEndNumber);
   Edit_interVal_support.Text:=IntTostr(DrawGzm.FGzm.RockPressAnalysis.ManulInput_Interval_support);
   StringGroupColor:=DrawGzm.FGzm.RockPressAnalysis.ColorString;
   RG_JD_Basic.ItemIndex:=DrawGzm.FGzm.RockPressAnalysis.JinDao_Basic;
   Edit_JD_support.Text:=intTostr(DrawGzm.FGzm.RockPressAnalysis.JinDao_Support);
   RG_JD_time.ItemIndex:=DrawGzm.FGzm.RockPressAnalysis.JinDao_Time;

end;

procedure TDrawBmp_From.SplitWorkFaceMemo2Text;
var
  Kid:integer;
begin
   if DrawGzm.FGzm.Gzmbh <1 then exit;
   // ���߱���ά��
   DrawGzm.FGzm.ClearMemo2Parameters ;
   DrawGzm.FGzm.InputGzmData(DrawGzm.FGzm.Gzmbh);
   if not DrawGzm.FGzm.SplitRockPressParameters then begin
       DrawGzm.FGzm.RockPressAnalysis.RP_Start_pt:=25;
       DrawGzm.FGzm.RockPressAnalysis.RP_End_Pt:=42;
       DrawGzm.FGzm.RockPressAnalysis.AnalysisSenstive:=1;
       DrawGzm.FGzm.RockPressAnalysis.Continue_SupNumber:=4;
       DrawGzm.FGzm.RockPressAnalysis.conTinue_Footage:=2;
       DrawGzm.FGzm.RockPressAnalysis.Min_Pt:=40;
       DrawGzm.FGzm.RockPressAnalysis.StepFillColor:=ClYellow;
       DrawGzm.FGzm.RockPressAnalysis.SetpFillTran:=50;
       DrawGzm.FGzm.RockPressAnalysis.StepGroundFilled:=0;
       DrawGzm.FGzm.RockPressAnalysis.StepFillIsTran :=1;
       DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide:=5;
       DrawGzm.FGzm.RockPressAnalysis.SelectedFillColor:=ClRed;
       DrawGzm.FGzm.RockPressAnalysis.JudgeMInQD :=0.5;
       // ���ֿ�ѹ�����׶�
       DrawGzm.Auto_Judge_OldStep.InitPhaseSteps(5,DrawGzm.FGzm ) ;
   end;

   if DrawGzm.FGzm.RockPressAnalysis.OldStepPhaseString <> '' then  begin
       SplitStringGridPhase;
   end else begin
       DrawGzm.Auto_Judge_OldStep.InitPhaseSteps(5,DrawGzm.FGzm ) ;
       CB_PhaseNumber.ItemIndex:=1 ;
   end;

   if DataPress_Unit_Flag =1 then   begin
      Kid:=1;
   end else begin
      Kid:=10;
   end;

   Edit_StartPt.Text  :=FormatFloat('0.0',DrawGzm.FGzm.RockPressAnalysis.RP_Start_pt*Kid);
   Edit_EndPt.Text  :=FormatFloat('0.0',DrawGzm.FGzm.RockPressAnalysis.RP_End_Pt*Kid);
   ComboBox_KY_Lmd.ItemIndex :=DrawGzm.FGzm.RockPressAnalysis.AnalysisSenstive ;

   Edit_sup_con.Text:=InttoStr(DrawGzm.FGzm.RockPressAnalysis.Continue_SupNumber);
   Edit_foot_con.Text:=InttoStr(DrawGzm.FGzm.RockPressAnalysis.conTinue_Footage);
   Edit_Min_pt.Text  :=FormatFloat('0.0',DrawGzm.FGzm.RockPressAnalysis.Min_Pt*Kid);
   StepColorBox.Selected  :=DrawGzm.FGzm.RockPressAnalysis.StepFillColor;
   Edit_Step_TranC.Text:=InttoStr(DrawGzm.FGzm.RockPressAnalysis.SetpFillTran);
   RG_Step_Ground_Fill.ItemIndex:=DrawGzm.FGzm.RockPressAnalysis.StepGroundFilled;
   RG_Step_Fill.ItemIndex :=DrawGzm.FGzm.RockPressAnalysis.StepFillIsTran;
   Edit_Fill_Line_Wide.Text:=InttoStr(DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide);
   Edit_MinQd.Text:=FormatFloat('0.00', DrawGzm.FGzm.RockPressAnalysis.JudgeMInQD);
   SelectedColorBox.Selected  :=DrawGzm.FGzm.RockPressAnalysis.SelectedFillColor;
   // �����򻮷ֽ����ʷֲ��������
  if DrawGzm.Auto_Judge_OldStep.PhaseNumber > 2 then
        FillStringGridPhase(DrawGzm.Auto_Judge_OldStep.PhaseNumber)
     else FillStringGridPhase(5);
end;

procedure TDrawBmp_From.StartDateTimeClick(Sender: TObject);
begin
    RecallLoadDataToDataBase(false);
end;

procedure TDrawBmp_From.StartEditClick(Sender: TObject);
begin
   StartEdit.SetFocus ;
   RecallLoadDataToDataBase(false);
end;

procedure TDrawBmp_From.StartEditKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

function TDrawBmp_From.StartRockPressAnslysisBegin: Boolean;
begin
     SetOldStepVisible(true);// ����������
    // У����ѯ����
    if DrawGzm.GetMyCoutOurColorUpToValue (DrawGzm.MyContourColor_NumLevel,
                      DrawGzm.FGzm.RockPressAnalysis.Min_Pt ,
                      DrawGzm.FGzm.RockPressAnalysis.NearColorLineUp_DownValue
                      )=-1 then    Exit;

      {�������ݷ�������}
     DrawGzm.Auto_Judge_OldStep.ClearSteps ;
     //�����ݿ�����ȡ ������ͼ����
     DrawGzm.ReadContoueSeriesToClass(DrawGzm.Auto_Judge_OldStep,2);
     // �������� ��ȡ �Ѿ� ����õĵ���ѹ���� ����
     DrawGzm.ReadContoueSeriesToClass(DrawGzm.Auto_Judge_OldStep,4);
    // ��ȡ���ݽ���
     DrawGzm.ExtractDataFormSeries(ContourSeries,Panel_ProcessBar,FirstPGBar,SecondPGBar);
 // ����������
     DrawGzm.Auto_Judge_OldStep.Sort;
 // ������ˢ��
     DrawGzm.Auto_Judge_OldStep.Refresh;
     MainTreeView(TreeView1,'Series');
     ChartPageControl.ActivePage :=ChartPageControl.Pages[0];
     // ���ư�ť
     But_Kyfx_FillMap.Enabled:=True;
     // ֱ��ˢ�� ���ദ�� ͼ��
     RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
     // ����ͼƬ
     ContourChartSaveIntoBMP('');;
end;

procedure TDrawBmp_From.But_Kyfx_SaveBmpClick(Sender: TObject);
begin
  DrawGzm.SaveContourSeriesIntoDataBase(DrawGzm.Auto_Judge_OldStep,2 ) ;
  if DrawGzm.Auto_Judge_OldStep.isCalComeStep then
     DrawGzm.SaveContourSeriesIntoDataBase(DrawGzm.Auto_Judge_OldStep,4 ) ;
   OptionTip(1,'���ݱ���ɹ�!');
end;

procedure TDrawBmp_From.But_Kyfx_StartClick(Sender: TObject);
begin
   StartRockPressAnslysisBegin;
end;


procedure TDrawBmp_From.StringGridColorGroupDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  iRect:TRect;
begin
     with StringGridColorGroup do  begin
         if (ACol =3) and (ARow <= DrawGzm.MyContourColor_NumLevel)
            and (ARow >0 )  and (ARow <=5 )then       begin
            iRect:=ZoomRect(Rect, 1);
            Canvas.Brush.color:=DrawGzm.MyContourColor[ARow-1].ContourColor ;
            Canvas.FillRect(iRect);
         end;

         if (ACol =7) and (DrawGzm.MyContourColor_NumLevel>5) and
            (ARow <= DrawGzm.MyContourColor_NumLevel-5)  and (ARow >0 ) then       begin
            iRect:=ZoomRect(Rect, 1);
            Canvas.Brush.color:=DrawGzm.MyContourColor[ARow+5-1].ContourColor ;
            Canvas.FillRect(iRect);
         end;

      end;

end;

procedure TDrawBmp_From.StringGridColorGroupSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
  var
   i:Integer;
begin
   if (ARow>0) and ((Acol=3) or (ACol=7)) then begin
       if (Acol=3) then    begin
          i:=ARow-1;
       end else if (ACol=7) then  begin
          i:= 4+ARow;
       end;
       if i+1 <=Drawgzm.MyContourColor_NumLevel then begin
           ColorDialog1.Color:=Drawgzm.MyContourColor[i].ContourColor;
           ColorDialog1.Execute;
           Drawgzm.MyContourColor[i].ContourColor:=ColorDialog1.Color;
           StringGridColorGroup.Repaint;
       end;
   end;

end;

procedure TDrawBmp_From.StringGrid_ResultMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt:Tpoint;
begin
   if Button=mbRight then begin
      pt:= self.StringGrid_Result.ClientToScreen(Point(0,0));
      DispResultPop (pt.X+x,pt.Y +y,'StringGrid');
   end;


end;

procedure TDrawBmp_From.But_Kyfx_FillMapClick(Sender: TObject);

begin
    DrawGzm.CloudClass.OldStepDisplay :=true;
    //ˢ�����ͼ��
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
    ChartPageControl.ActivePage :=ChartPageControl.Pages[0];
end;

procedure TDrawBmp_From.But_Kyfx_Depth_FxClick(Sender: TObject);
begin

   InitKyfxResultStringGrid;
   DrawGzm.CalComeStepAndPrintToMemo(Memo_Result,StringGrid_Result);

   ChartPageControl.ActivePage :=ChartPageControl.Pages[3];
end;

procedure TDrawBmp_From.TabSheet17Show(Sender: TObject);
begin
   Edit_StartPt.SetFocus;
end;

procedure TDrawBmp_From.TabSheet20Resize(Sender: TObject);
begin
    GB_Result_Memo.Height := TabSheet20.Height div 2;
end;

procedure TDrawBmp_From.TreePop_CloseClick(Sender: TObject);
begin
   SetRightToolVisible(FALSE);
end;

procedure TDrawBmp_From.TreePop_DeleteClick(Sender: TObject);
begin
   if (TreeView_Stepid >=0) and (TreeView_Stepid < length(DrawGzm.Auto_Judge_OldStep.ExSteps) ) then
      DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].Used :=2;
     RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TDrawBmp_From.TreePop_depthClick(Sender: TObject);
begin
  self.But_Kyfx_FillMap.Click ;
end;

procedure TDrawBmp_From.TreePop_FillClick(Sender: TObject);
begin
   self.But_Kyfx_Start.Click ;
end;

procedure TDrawBmp_From.TreePop_RecallClick(Sender: TObject);
begin
  if (TreeView_Stepid >=0) and (TreeView_Stepid < length(DrawGzm.Auto_Judge_OldStep.ExSteps) ) then
      DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].Used :=1;
     RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TDrawBmp_From.TreePop_RefreshClick(Sender: TObject);
begin
    RefreshOldStepAddToMapSeries(DrawGzm.CloudClass.OldStepDisplay);
end;

procedure TDrawBmp_From.TreePop_ReportClick(Sender: TObject);
begin
   But_Kyfx_Report.Click;
end;

procedure TDrawBmp_From.TreePop_saveClick(Sender: TObject);
begin
  But_Kyfx_Depth_Fx.Click ;
end;

procedure TDrawBmp_From.TreeView1Click(Sender: TObject);
var
  XNode: TTreeNode;
  i:integer;
  VIS:Boolean;
  MoveDis:double;
begin
  TreeView_Stepid:=-1;
  TreeView_APolid:=-1;
   if (TreeView1.Selected = nil) or (PMyRec(TreeView1.Selected.Data)^.DName = 'ROOT')   then
        Exit;

   if  Public_Basic.StrToInt_lu(PMyRec(TreeView1.Selected.Data)^.BName) <0  then   exit;

   XNode:=TreeView1.Selected;

   if (XNode=nil) then        exit;

   TreeView_Stepid:=Public_Basic.StrToInt_lu(PMyRec(XNode.Data )^.DName);
   TreeView_APolid:=Public_Basic.StrToInt_lu(PMyRec(XNode.Data )^.XHeight);

  if DrawGzm.FGzm.RockPressAnalysis.StepFillIsTran =0  then
              Vis:=true else Vis:=False;

  for I := 0 to self.MapSeries.Shapes.Count -1 do
    if i= TreeView_APolid then  begin
        SetPolygenProperty(DrawGzm.Auto_Judge_OldStep.ExSteps[0],false,
                   MapSeries.Shapes[i],
                   false,
                   DrawGzm.FGzm.RockPressAnalysis.SelectedFillColor,
                   DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide);
        //���ı༭״̬
    //  DrawGzm.EditMapPoint:=EditMapSeriesSteps(APolid,Stepid);
    end else begin
        SetPolygenProperty( DrawGzm.Auto_Judge_OldStep.ExSteps[0],false,
                   MapSeries.Shapes[i],
                   Vis,
                   DrawGzm.FGzm.RockPressAnalysis.StepFillColor,
                   DrawGzm.FGzm.RockPressAnalysis.StepFillLineWide);
    end;

  // �ı��������λ��
     if ContourChart.BottomAxis.Minimum >=DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].GetMinDao   then    begin
         MoveDis:= DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].GetMinDao;
         if MoveDis-+DrawGzm.CloudClass.X_Axis_Disp_Dao/2 < DrawGzm.DataTimeAndFootAge.Graph_MinDao  then begin
            ContourChart.BottomAxis.SetMinMax(DrawGzm.DataTimeAndFootAge.Graph_MinDao,
                              DrawGzm.DataTimeAndFootAge.Graph_MinDao+DrawGzm.CloudClass.X_Axis_Disp_Dao);
         end else begin
            ContourChart.BottomAxis.SetMinMax(MoveDis-DrawGzm.CloudClass.X_Axis_Disp_Dao/2,MoveDis+DrawGzm.CloudClass.X_Axis_Disp_Dao/2);
         end;



     end;

     if ContourChart.BottomAxis.Maximum <=DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].GetMaxDao  then   begin
         MoveDis:= DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].GetMaxDao ;
         if MoveDis+DrawGzm.CloudClass.X_Axis_Disp_Dao /2  >DrawGzm.DataTimeAndFootAge.Graph_MaxDao  then begin
             ContourChart.BottomAxis.SetMinMax(DrawGzm.DataTimeAndFootAge.Graph_MaxDao-DrawGzm.CloudClass.X_Axis_Disp_Dao  ,
                            DrawGzm.DataTimeAndFootAge.Graph_MaxDao );
         end else begin
             ContourChart.BottomAxis.SetMinMax(MoveDis-DrawGzm.CloudClass.X_Axis_Disp_Dao /2 ,
                           MoveDis+DrawGzm.CloudClass.X_Axis_Disp_Dao /2 );
         end;


     end;



    if TreeView_Stepid>=0 then
       if TreeView_Stepid< length(DrawGzm.Auto_Judge_OldStep.ExSteps) then   begin
//         for i := 0 to DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].Pointcount -1 do   begin
//              GB_Ky_Memo1.Lines.Add('Point[' + IntToStr(i) + ']: (' + FormatFloat('0.00',DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].Points[i].x) +
//                       ',' +  FormatFloat('0.00',DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].Points[i].y) + ')');
//         end;
         GB_Ky_Memo1.Lines.add ('');
          for i := 0 to 7 do
           GB_Ky_Memo1.Lines.Add('OutPoint[' + IntToStr(i) + ']: (' + FormatFloat('0',DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].MyOutLinePoint[i].x) +
                       ',' +  FormatFloat('0',DrawGzm.Auto_Judge_OldStep.ExSteps[TreeView_Stepid].MyOutLinePoint[i].y) + ')');
       end;



end;

procedure TDrawBmp_From.TreeView1Collapsed(Sender: TObject; Node: TTreeNode);
begin
   Node.ImageIndex:=0;
   Node.SelectedIndex:=0;
end;

procedure TDrawBmp_From.TreeView1Expanding(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
begin
     Node.ImageIndex:=1;
    Node.SelectedIndex:=1;
end;

procedure TDrawBmp_From.TreeView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt:Tpoint;
begin
   if Button=mbRight then begin
      pt:= TreeView1.ClientToScreen(Point(0,0));
      DispTreePop (pt.X+x,pt.Y +y);
   end;


end;

procedure TDrawBmp_From.TwoDimChartResize(Sender: TObject);
begin
  //  RefreshContourlegendPalette;
end;

procedure TDrawBmp_From.TwoDimCloudMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  SelectPoint:TSelectImageGrid;
  Stime:String;
begin
//  SelectPoint:=DrawGzm.GetImagePointData(x,y,0,0);
//  if SelectPoint.StartSupbh >0  then begin
//     Stime:=FormatdateTime('YYYY-mm-dd hh:nn:ss',SelectPoint.StartTime);
//     StatusBar_Image.Panels[0].Text := Format('֧�ܱ��:%d   ʱ��%s', [SelectPoint.StartSupbh,Stime]);
//     DrawGzm.MoveDoubleMYLine(TwoDimCloud,Point(x,y));
//  end;

 // self.StatusBar_Image.Panels[0].Text := Format('Val at (%d, %d) = %d', [x,y, x*y div 256 ]);
end;


end.  //end Unit