unit UFormModifyJinDao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,Vcl.StdCtrls ,
  UMainDataModule,uDrawGraphClass, Vcl.Buttons, Vcl.CheckLst ,System.TypInfo,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart,
  VCLTee.TeeSurfa, Vcl.Menus, System.ImageList, Vcl.ImgList, Vcl.ToolWin,
  Vcl.Grids,Vcl.Clipbrd,  VCLTee.TeePieTool, VCLTee.TeeLegendPalette,
  VCLTee.TeeTriSurface, VCLTee.TeePoin3, VCLTee.TeeTools, VCLTee.TeeDragPoint,
  VCLTee.Series,VCLTee.TeeMapSeries, Vcl.ExtDlgs,
  UMakeRuleClass,UGraphLineClass
  ;

 type

  TModifyJinDao_From = class(TForm)
    StatusBar1: TStatusBar;
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
    N3: TMenuItem;
    Pop_Foot_Save: TMenuItem;
    Pop_Foot_Refresh: TMenuItem;
    Pop_Foot_InsertStep: TMenuItem;
    Pop_Foot_DeleteStep: TMenuItem;
    Pop_Foot_DeleteAll: TMenuItem;
    ImageList1: TImageList;
    N24: TMenuItem;
    Pop_Foot_Auto: TMenuItem;
    Pop_Foot_UpdateDao: TMenuItem;
    GroupBox1: TGroupBox;
    FootageGrid: TStringGrid;
    ToolBar1: TToolBar;
    AddButton: TToolButton;
    EditButton: TToolButton;
    SaveButton: TToolButton;
    ToolButton1: TToolButton;
    ExitButton: TToolButton;
    GroupBox7: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    ComboFootSteps: TComboBox;
    ComboBoxStepTime: TComboBox;
    Footsteps_L: TEdit;
    Button6: TButton;
    Edit_SupportNumber: TEdit;
    Edit_interVal_support: TEdit;
    Panel1: TPanel;
    Splitter1: TSplitter;
    GraphChart: TChart;
    GraphSeries: TLineSeries;
    CursorTool1: TCursorTool;
    Panel_ProcessBar: TPanel;
    FirstPGBar: TProgressBar;
    SecondPGBar: TProgressBar;
    Label1: TLabel;
    Label39: TLabel;
    ColorBand: TColorBandTool;
    Support_JinDao_Combo: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);


    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FootageGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FootageGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FootageGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Pop_Foot_onedayClick(Sender: TObject);
    procedure Pop_Foot_AddStepClick(Sender: TObject);
    procedure Pop_Foot_InsertStepClick(Sender: TObject);
    procedure Pop_Foot_DeleteStepClick(Sender: TObject);
    procedure Pop_Foot_UpdateTimeClick(Sender: TObject);
    procedure Pop_Foot_PasteClick(Sender: TObject);
    procedure Pop_Foot_Update_PartDataClick(Sender: TObject);
    procedure Pop_Foot_Update_allDataClick(Sender: TObject);
    procedure Pop_Foot_RefreshClick(Sender: TObject);
    procedure Pop_Foot_DeleteAllClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure ChartPageControlDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure Pop_Foot_UpdateDaoClick(Sender: TObject);
    procedure Footsteps_LKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_SupportNumberKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_interVal_supportKeyPress(Sender: TObject; var Key: Char);
    procedure Footsteps_LClick(Sender: TObject);
    procedure Edit_SupportNumberClick(Sender: TObject);
    procedure Edit_interVal_supportClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure Pop_Foot_EditTimeClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure Pop_Foot_AutoClick(Sender: TObject);
    procedure Pop_Foot_SaveClick(Sender: TObject);

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
     SaveFootage_EndTime:TDateTime;
     //
     MyDrawJinDaoGraph:TDrawGraphClass;
     Saved_DataBase:Boolean;
     ShowScreen:integer;

    procedure OptionTip(index:integer;Str:String);
    procedure AutoLoadcomboBox(MkName,WkName:string);
   //-----------------------
    function  GetDataClass:Boolean;    //��ȡ����ѡ����

    procedure RefreshMemoInfo(Memo:TMemo);  // ˢ����Ϣ����

    procedure RefreshFootageStringGrid;

    function  GetBatInputDataMaxGenTime(Support:integer):TDateTime;
    Procedure FillBasicJinDao(B_JinDao:TBasicJinDao;Support:integer);

    //---------------------------

    procedure InitFootageGrid; // ��ʼ���������ݱ�

    function  ZoomRect(mRect: TRect; mZoom: Integer): TRect;// ���Ʊ�����
    //--------------------------
    procedure DispFootAgePopMumu(px,py,Col,Row:integer); //��ʾ�������ݿ�ݲ˵�
    procedure DispRockDataPopMumu(px,py,Col,Row:integer); //��ʾ��ѹ���ݿ�ݲ˵�
    
    //----------------------------

    procedure InsertNextDayFootage(StrGrid:TStringGrid;Row,dayOrstep:integer);
    function  GetFootStepCount:Integer; // ��ȡһ�������
    function  GetFootStepTime:Double;Overload;
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
    function  AutoUpdateFootage(StrGrid: TStringGrid;Row:integer):Boolean;  // �Զ���ȡ �ռ���Ľ�������

    //-------------------
     procedure SplitWorkFaceMemo1Text;
     procedure SaveWorkFaceMemo1Text ;
    // chart
     procedure MakeGraphChartTitle(Chart:Tchart;Series:TLineSeries);
     procedure UpdateColorBand(Cols,Rows:integer);
     //
     procedure LoadSupportBhFillComboBoxSupport(StrDate:string);
     procedure SetFromWidthAndHeigth(flag:integer);
      procedure FromSaveToBmp(pic_path:string);
  public
     EXCaption:String; // �ⲿ�������ı���
    { Public declarations }
      procedure Return_CallEditDateTime(DTS:String);//�����޸�ʱ�����Ļص�����
      procedure Return_CallEditRockPressMemo(DTS:String);
      //
      procedure RefreshMyGraphChart;
      // �ⲿ�Զ���������
       //----
     procedure InitForm;      //��ʼ�����沿�ֹ���
     function AutoLoadInputJinDao(Flag:integer):Boolean;
     function SaveJinDaoIntoDAtaBase(Flag:integer):Boolean;
  end;

function CreateModify_JinDao(AHandle:THandle;ACaption:string;Wid,Hi,Flag:integer):THandle;stdcall;

var
 ModifyJinDao_From: TModifyJinDao_From;

implementation

{$R *.dfm}

uses Lu_Public_BasicModual, PStope_GzmGuidClass , UEditFootageDateTime;
function CreateModify_JinDao(AHandle:THandle;ACaption:string;Wid,Hi,Flag:integer):THandle;stdcall;
{Flag 1 ����ά��  Flag 2 ��ѹ����ά��  3 ��ѹ���ݷ���}
begin
        if Assigned(ModifyJinDao_From) then  FreeAndNil(ModifyJinDao_From);
        Application.Handle :=AHandle;
        ModifyJinDao_From:=TModifyJinDao_From.Create(Application);

         try
           with ModifyJinDao_From do begin
               EXCaption:=ACaption;

               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

               SetFromWidthAndHeigth(Flag);


                Result:=ModifyJinDao_From.Handle ;//����ֵ
          end ;
        except
           FreeAndNil(ModifyJinDao_From);
        end;


end;

{ TForm1 }

procedure TModifyJinDao_From.AddButtonClick(Sender: TObject);
begin
   Pop_Foot_Auto.Click ;
end;

procedure TModifyJinDao_From.AutoLoadcomboBox(MkName, WkName: string);
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

 

end;

function TModifyJinDao_From.AutoLoadInputJinDao(Flag:integer): Boolean;
var
 tmp_Jindao_sup:integer;
 Strdt:string;
begin
  Saved_DataBase:=False;
  // ��ȡ���ݿⱣ������ʱ��
  SaveFootage_EndTime:=DrawGzm.FGzm.GetModifyFootageMaxDateTime(Flag);
  // ��ȡ�����ж�֧�ܲ���
  tmp_Jindao_sup:=public_Basic.StrToInt_lu(Trim(Support_JinDao_Combo.Text));
  if (tmp_Jindao_sup <>DrawGzm.FGzm.RockPressAnalysis.JinDao_Support ) and (tmp_Jindao_sup >0 ) then   begin
     DrawGzm.FGzm.RockPressAnalysis.JinDao_Support:=tmp_Jindao_sup;
  end;
  //���ȼ������ݿ���ǰ����Ľ�������
  InitFootageGrid;
  Strdt:=Public_Basic.ReturnDateTimeString(MainDataModule.DataType ,SaveFootage_EndTime-0.5);

  DrawGzm.FGzm.ReadFootageDataToStringGrid(FootageGrid,Strdt) ;

  AutoUpdateFootage(FootageGrid,FootageGrid.RowCount-1);
  MyDrawJinDaoGraph.SetMaxJinDaoTime(self.SaveFootage_EndTime-1);

  RefreshMyGraphChart;

end;

function TModifyJinDao_From.AutoUpdateFootage(StrGrid: TStringGrid;Row:integer): Boolean;
var
  i:integer;
  sRow:Integer;
  Sql,Strdt:string;
  Step_Footage:double;
  left_FootageCount,Right_FootageCount:Integer;
  Left_Sum_Footage,Right_SumFootage:Double;
  Tem_FirstData:TFirstData;
begin
  if DrawGzm.FGzm.Gzmbh <0 then exit;
  // ����StrGrid ���һ����¼
  sRow:=Row;
  while sRow >1 do  begin
     if sRow > StrGrid.RowCount-1 then begin
         Dec(SRow); continue;
     end;

     if Trim(StrGrid.Cells[1,SRow]) =''  then   begin
        Dec(SRow); continue;
     end else begin
        break;
     end;

  end;

  // ��ʼ������
   if sRow=1 then  begin
      left_FootageCount:=0;
      Right_FootageCount:=0;
      Left_Sum_Footage:=0;
      Right_SumFootage:=0;
   end else begin
      left_FootageCount:= Public_Basic.StrToInt_lu(StrGrid.Cells[2,SRow]);
      Right_FootageCount:= Public_Basic.StrToInt_lu(StrGrid.Cells[10,SRow]);
      Left_Sum_Footage:= Public_Basic.StrToDouble_Lu(StrGrid.Cells[4,SRow]);
      Right_SumFootage:= Public_Basic.StrToDouble_Lu(StrGrid.Cells[8,SRow]);
   end;


   // �����ݿ�ѽ��߲����
   MySqlDataSet1.Close ;
   Step_Footage:=self.GetFootOneStepDis;
   Strdt:=Public_Basic.ReturnDateTimeString(MainDataModule.DataType ,SaveFootage_EndTime);
   Sql:=' select * from  D_'+IntToStr(DrawGzm.FGzm.Gzmbh)+'_SupportMoveInfo ' +
        ' where supportbh =' + IntTostr(DrawGzm.FGzm.RockPressAnalysis.JinDao_Support) + ' and  EndTime > ' + Strdt  +
        ' order by endtime ';
   MySqlDataSet1.CommandText :=sql;
   MyDrawJinDaoGraph.ClearItems ;
   try
     if MySqlDataSet1.Open  then
       while not MySqlDataSet1.Eof  do begin
          inc(sRow);
          if StrGrid.RowCount <=sRow+1 then  StrGrid.RowCount:=  sRow+2;
          StrGrid.Cells[0,SRow]:= IntToStr(SRow-1);
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
          {generatetime,Valuetype,supportbh, Starttime,EndTime, startValue,EndValue, ' +
            ' Max_Value,Min_Value,Max_Valuetime,Min_valueTime, AGVDAta ,SupportStartPress,ZhuYeEndTime, ' +
            ' BeforeMoveValue,BeforeMoveMaxValue ,BefortMovetime,BeforeMoveMaxTime,zhuyeReturnGrad,DataVarience,SameTimeValue, '+
            ' MoveState,Process}
          Tem_FirstData.dStartTime:=MySqlDataSet1.FieldByName('Starttime').AsDateTime;
          Tem_FirstData.dEndTime:=MySqlDataSet1.FieldByName('EndTime').AsDateTime;

          Tem_FirstData.dStartValue:=MySqlDataSet1.FieldByName('startValue').AsFloat;
          Tem_FirstData.dEndValue:=MySqlDataSet1.FieldByName('EndValue').AsFloat;

          Tem_FirstData.dMaxValue:=MySqlDataSet1.FieldByName('Max_Value').AsFloat;
          Tem_FirstData.dMinValue:=MySqlDataSet1.FieldByName('Min_Value').AsFloat;
          Tem_FirstData.dAvgValue:=MySqlDataSet1.FieldByName('AGVDAta').AsFloat;

          Tem_FirstData.dMaxValuetime:=MySqlDataSet1.FieldByName('Max_Valuetime').AsDateTime;
          Tem_FirstData.dMinValuetime:=MySqlDataSet1.FieldByName('Min_valueTime').AsDateTime;

          Tem_FirstData.dStartPressure:=MySqlDataSet1.FieldByName('SupportStartPress').AsFloat;
          Tem_FirstData.dBeforeLastValue:=MySqlDataSet1.FieldByName('BeforeMoveValue').AsFloat;
          Tem_FirstData.dbeforeLastMaxValue:=MySqlDataSet1.FieldByName('BeforeMoveMaxValue').AsFloat;

          Tem_FirstData.dzhuyeEndTime:=MySqlDataSet1.FieldByName('ZhuYeEndTime').AsDateTime;
          Tem_FirstData.dBeforeLastValueTime:=MySqlDataSet1.FieldByName('BefortMovetime').AsDateTime;
          Tem_FirstData.dBeforeLastMaxValueTime:=MySqlDataSet1.FieldByName('BeforeMoveMaxTime').AsDateTime;
          MyDrawJinDaoGraph.AddItem(Tem_FirstData);
          //
          MySqlDataSet1.Next ;
       end;
   finally
      MySqlDataSet1.Close ;
   end;
  
end;

procedure TModifyJinDao_From.Button6Click(Sender: TObject);
begin
   SaveWorkFaceMemo1Text;
end;

procedure TModifyJinDao_From.MakeGraphChartTitle(Chart: Tchart;
  Series: TLineSeries);
var
 Caption:String;
 lowTime,highTime,InterValTime:integer;
 i:integer;
begin
   // Chart.Refresh;
    series.Clear;
    series.XValues.DateTime :=true;
    series.ValueFormat:='YYYY-MM-DD HH:NN:SS' ;
    series.Pen.Width :=2;

    Chart.Title.Font.Color :=ClBlack;
    Caption:=DrawGzm.FGzm.S_Name +'�Եڡ�' + IntTostr(DrawGzm.FGzm.RockPressAnalysis.JinDao_Support) +
           '����֧���жϽ���ѹ������ͼ' ;


    Chart.Title.TextAlignment:=taCenter;
    Chart.Title.Font.Name :='����';
    Chart.Title.Font.Size :=14;
    Chart.Title.Caption := Caption;

    Chart.SubTitle.Font.Color :=ClBlack;
    Chart.SubTitle.TextAlignment:=taCenter;
    Chart.SubTitle.Font.Name :='����';
    Chart.SubTitle.Font.Size :=9;
//
//    Caption:='��ʼʱ��:'+FormatDateTime('yyyy-mm-dd hh:nn:ss ',SaveFootage_EndTime);
//
//    Chart.SubTitle.Caption := Caption;
//    Chart.SubTitle.Font.Color :=ClBlack;


    // ������
    Chart.Legend.Visible :=false;
    Chart.BottomAxis.Visible :=true;
    //��������������ʾ��ʽ
//    Chart.BottomAxis.Automatic :=true;
//    Chart.Zoom.MouseButton:=mbLeft ;
    //Chart.Zoom.MouseButton:=mbmiddle;
   // Chart.AllowPanning:=pmNone;
     // �϶���� �ƶ�ͼ��
     Chart.BottomAxis  .Automatic :=false;
     Chart.ScrollMouseButton:=mbleft;
     Chart.AllowPanning:=pmHorizontal;

     Chart.BottomAxis.Title.Caption :='����ʱ��';
     Chart.BottomAxis.Title.Position  :=tpStart ;
   
    if DrawGzm.ColorValue.UnitType =1 then  begin
       Chart.LeftAxis.Title.Caption :='ѹ��ֵ��MPa��';
    end else begin
       Chart.LeftAxis.Title.Caption :='ѹ��ֵ��Bar��';
    end;
      Chart.LeftAxis.Title.Position  :=tpEnd ;

end;

procedure TModifyJinDao_From.MoveStringGridRecord(StrGrid: TstringGrid; FRow,
  MRow: integer);
var
   i:integer;
begin
    for I := 0 to StrGrid.ColCount -1 do
        StrGrid.Cells[i,MRow]:= StrGrid.Cells[i,FRow];

end;



procedure TModifyJinDao_From.UpdateColorBand(Cols, Rows: integer);
var
  starttime,EndTime:TdateTime;
begin
    if Rows< 2 then  exit;
    if Trim(FootageGrid.Cells[1,Rows])='' then  exit;

    EndTime:=StrToDateTime(Trim(FootageGrid.Cells[1,Rows]),Public_Basic.FSetting);
    ColorBand.EndValue :=EndTime;
    if Rows >2  then  begin
       starttime:=StrToDateTime(Trim(FootageGrid.Cells[1,Rows-1]),Public_Basic.FSetting);

       if (EndTime-starttime > 1/24/3) and (EndTime-starttime <0.5) then  begin
          ColorBand.StartValue:= starttime ;
       end else if EndTime-starttime <  1/24/3 then  begin
          ColorBand.StartValue:= EndTime- 1/24/3 ;
       end else begin
          ColorBand.StartValue:= EndTime-0.5 ;
       end;
    end else begin
       ColorBand.StartValue := ColorBand.EndValue-1;
    end;
    // ����������λ��
    GraphChart.BottomAxis.Minimum:=0;
    GraphChart.BottomAxis.Maximum:=ColorBand.StartValue+1;
    GraphChart.BottomAxis.Minimum:=ColorBand.StartValue-1;
    GraphChart.Refresh;
end;

procedure TModifyJinDao_From.UpdateFootageStringGridFromRow(StrGrid: TstringGrid;
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

function TModifyJinDao_From.UpdateShouDongInputFootae(StrGrid: TstringGrid;
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
   if (StartRow=2)  then
       if  (Trim(StrGrid.Cells[SelectCol,StartRow])='')  then begin
           StrGrid.Cells[SelectCol,StartRow]:=StrGrid.Cells[AutoCol,StartRow] ;
       end else begin
            StrGrid.Cells[AutoCol,StartRow]:=StrGrid.Cells[SelectCol,StartRow] ;
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

procedure TModifyJinDao_From.UpdateTdateTimeFormCurrRow(StrGrid: TstringGrid;
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


procedure TModifyJinDao_From.ChartPageControlDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
   if Active then
    begin
        Control.Canvas.Brush.Color := ClHighLight;
        Control.Canvas.Font.Color := clWhite;
    end;
    Control.Canvas.FillRect(Rect);

end;


procedure TModifyJinDao_From.CopyDataToStringGridFromPaste(StrGrid: TstringGrid; Col,
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


procedure TModifyJinDao_From.DeleteOnRecordToFootage(StrGrid: TstringGrid;
  Row: integer);
var
  i:integer;
  t_s:string;
begin
   if Row <2  then exit;

   t_s:='��ȷ��Ҫɾ����ǰ������־ô?';

   if Application.MessageBox(Pwidechar(t_s),'��ʾ',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

   for i:=Row to StrGrid.RowCount-2 do
       MoveStringGridRecord(StrGrid,i+1,i);
    //������һ��
    FootageGrid.Rows[StrGrid.RowCount-1].Clear ;
    StrGrid.RowCount:=StrGrid.RowCount-1;
    UpdateFootageStringGridFromRow(StrGrid,'Detlete',Row);
    //���µ���
   RefreshFootageStringGrid
end;


procedure TModifyJinDao_From.DispFootAgePopMumu(px,py,Col,Row:integer);
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


procedure TModifyJinDao_From.DispRockDataPopMumu(px, py, Col, Row: integer);
begin

end;



procedure TModifyJinDao_From.EditButtonClick(Sender: TObject);
begin
    Saved_DataBase:=False;
    Pop_Foot_Refresh.Click;
end;

procedure TModifyJinDao_From.Edit_interVal_supportClick(Sender: TObject);
begin
    Edit_interVal_support.SetFocus;
end;

procedure TModifyJinDao_From.Edit_interVal_supportKeyPress(Sender: TObject;
  var Key: Char);
begin
   if not (key in ['0'..'9',#8]) then key:=#0  ;
end;

procedure TModifyJinDao_From.Edit_SupportNumberClick(Sender: TObject);
begin
    Edit_SupportNumber.SetFocus;
end;

procedure TModifyJinDao_From.Edit_SupportNumberKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (key in ['0'..'9',#8]) then key:=#0  ;
end;

procedure TModifyJinDao_From.ExitButtonClick(Sender: TObject);
begin
   close;
end;

procedure TModifyJinDao_From.FillBasicJinDao(B_JinDao: TBasicJinDao;Support:integer);
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



procedure TModifyJinDao_From.FootageGridDrawCell(Sender: TObject; ACol,
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

procedure TModifyJinDao_From.FootageGridMouseDown(Sender: TObject;
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
      Saved_DataBase:=False;
      DispFootAgePopMumu(Mouse_x,Mouse_y,FootStringGrid_SelectCol,FootStringGrid_SelectRow);
     // FootStringGrid_SelectRow:=0;
   end else if Button = mbLeft then  begin
       if row <> FootStringGrid_SelectRow then  begin
          FootStringGrid_SelectRow := row;
          FootageGrid.Repaint;
       end;
   end;



end;

procedure TModifyJinDao_From.FootageGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
   FootStringGrid_SelectCol:=ACol;
   FootStringGrid_SelectRow:=ARow;
   UpdateColorBand(FootStringGrid_SelectCol,FootStringGrid_SelectRow);
   FootageGrid.Refresh;
end;

procedure TModifyJinDao_From.Footsteps_LClick(Sender: TObject);
begin
   Footsteps_L.SetFocus;
end;

procedure TModifyJinDao_From.Footsteps_LKeyPress(Sender: TObject;
  var Key: Char);
begin
   if not (key in ['0'..'9','.',#8]) then key:=#0  ;
end;

procedure TModifyJinDao_From.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
 Pic_Path:string;
begin
   Pic_Path  :=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\OneCoal'+'_9_1.BMP';
   if ShowScreen=1 then      FromSaveToBmp(Pic_Path);
   {�رմ��壬������Ҫ����Close����}
   if Assigned(ModifyJinDao_From) then  FreeAndNil(ModifyJinDao_From);
end;

procedure TModifyJinDao_From.FormCreate(Sender: TObject);
begin
    MySqlDataSet1:=TMyDataSet.Create(nil);
    MySqlDataSet1.MySqlConnection :=MainDataModule.ExConn;
    MySqlDataSet2:=TMyDataSet.Create(nil);
    MySqlDataSet2.MySqlConnection :=MainDataModule.ExConn;
    MyCommand1:=TMyCommand.Create (nil);
    MyCommand1.MySqlConnection :=MainDataModule.ExConn;
    DrawGzm:=TDrawGrap.Create(MainDataModule.ExConn);
    MyDrawJinDaoGraph:=TDrawGraphClass.Create(MainDataModule.ExConn);
    //create


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


     //Ĭ�ϻ�β��ʾ ʱ��
     DrawGzm.ConTourSeriesPar.Display_UpperFootage:=0;
     DrawGzm.ConTourSeriesPar.Display_DownFootage:=1;

     BasicJinDao:=TBasicJinDao.Create ;
     SaveFootage_EndTime:=-1;
     Saved_DataBase:=true;
end;

procedure TModifyJinDao_From.FormDestroy(Sender: TObject);
begin
     FreeAndNil(MySqlDataSet1);
     FreeAndNil(MyCommand1);
     FreeAndNil(MySqlDataSet2);
     FreeAndNil(DrawGzm);
     FreeAndNil(MyDrawJinDaoGraph);

     FreeAndNil(MapSeries);
     FreeAndNil(BasicJinDao);

end;

procedure TModifyJinDao_From.FormShow(Sender: TObject);
begin
   InitForm;
   Caption:=EXCaption;
end;

procedure TModifyJinDao_From.FromSaveToBmp(pic_path: string);
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

function TModifyJinDao_From.GetBatInputDataMaxGenTime(Support:integer): TDateTime;
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



function TModifyJinDao_From.GetDataClass: Boolean;
var
 i:integer;
 Str:string;
begin

end;


function TModifyJinDao_From.GetFootOneStepDis: double;
begin
   Result:=DrawGzm.FGzm.RockPressAnalysis.OneDao_step;
end;

function TModifyJinDao_From.GetFootStepTime: Double;
var
   DT:integer;
begin
  DT:=DrawGzm.FGzm.RockPressAnalysis.TwoDao_IntervalTime;
  Result:=DT/1440;

end;

function TModifyJinDao_From.GetFootStepCount: Integer;
begin
  Result:=DrawGzm.FGzm.RockPressAnalysis.Oneday_daoshu;
end;

function TModifyJinDao_From.GetFootStepTime(FistSt, SecondSt: String;Interval:integer): double;
var
  Fir,Sec:TdateTime;
begin
   Fir:=StrToDateTime(FistSt,Public_Basic.FSetting);
   Sec:=StrToDateTime(SecondSt,Public_Basic.FSetting);
   Result:=(Sec-Fir)/Interval;
end;


procedure TModifyJinDao_From.InitFootageGrid;
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

procedure TModifyJinDao_From.InitForm;
begin
    Public_basic.InitStatusBar(StatusBar1);
    AutoLoadcomboBox(s_MinName,S_WorkFaceName);
   
    DrawGZm.MapSeriesEditState :=-1;  // Ĭ��û�м�������
    DrawGzm.CloudClass.OldStepDisplay :=False; //��ͼ����ʾ��ѹ����
    // ��������
    LoadSupportBhFillComboBoxSupport('');
    SplitWorkFaceMemo1Text;
    // ��ȡ���ݿⱣ������ʱ��
    SaveFootage_EndTime:=DrawGzm.FGzm.GetModifyFootageMaxDateTime(0);

end;





procedure TModifyJinDao_From.InserOneRecordToFootage(StrGrid:TstringGrid;Row: integer);
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

procedure TModifyJinDao_From.InsertNextDayFootage(StrGrid: TStringGrid; Row,dayOrstep:integer);
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

procedure TModifyJinDao_From.LoadSupportBhFillComboBoxSupport(StrDate: string);
var
 sql:string;
begin
     MySqlDataSet1.Close;
     sql:=' select supportbh from D_'+IntToStr(DrawGzm.FGzm.Gzmbh)+'_SupportMoveInfo  group by Supportbh' ;
     MySqlDataSet1.CommandText :=sql;
     MySqlDataSet1.Open ;
     Support_JinDao_Combo.Clear ;
     while not MySqlDataSet1.eof do begin
        Support_JinDao_Combo.Items.Add(IntTostr(MySqlDataSet1.FieldByName('supportbh').AsInteger));
        MySqlDataSet1.Next ;
     end;
     MySqlDataSet1.Close ;

end;

procedure TModifyJinDao_From.OptionTip(index:integer;Str:String);
begin
   self.StatusBar1.Panels[index].Text :=str;
end;



procedure TModifyJinDao_From.Pop_Foot_InsertStepClick(Sender: TObject);
begin
 InserOneRecordToFootage(FootageGrid,FootStringGrid_SelectRow);
end;

procedure TModifyJinDao_From.Pop_Foot_AddStepClick(Sender: TObject);
begin
   InsertNextDayFootage(FootageGrid,FootStringGrid_SelectRow,0);
end;

procedure TModifyJinDao_From.Pop_Foot_AutoClick(Sender: TObject);
begin
  AutoLoadInputJinDao(1);
end;

procedure TModifyJinDao_From.Pop_Foot_DeleteAllClick(Sender: TObject);
var
  t_s:string;
  Strdt:String;
begin
    t_s:='��ȷ��Ҫɾ����������ô?';

    if Application.MessageBox(Pwidechar(t_s),'��ʾ',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;


    Strdt:=Public_Basic.ReturnDateTimeString(MainDataModule.DataType ,0);
    if DrawGzm.FGzm.DeleteAllFootageData(Strdt) then begin
        Optiontip(0,'���������ɹ�');
        InitFootageGrid;
    end;
end;

procedure TModifyJinDao_From.Pop_Foot_DeleteStepClick(Sender: TObject);
begin
  DeleteOnRecordToFootage(FootageGrid,FootStringGrid_SelectRow);
end;

procedure TModifyJinDao_From.Pop_Foot_EditTimeClick(Sender: TObject);
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

procedure TModifyJinDao_From.Pop_Foot_onedayClick(Sender: TObject);
begin
  InsertNextDayFootage(FootageGrid,FootStringGrid_SelectRow,1);
end;

procedure TModifyJinDao_From.Pop_Foot_PasteClick(Sender: TObject);
begin
    CopyDataToStringGridFromPaste(FootageGrid,FootStringGrid_SelectCol,FootStringGrid_SelectRow,1);
end;

procedure TModifyJinDao_From.Pop_Foot_RefreshClick(Sender: TObject);
var
  Strdt:string;
begin
  InitFootageGrid;
  Strdt:=Public_Basic.ReturnDateTimeString(MainDataModule.DataType ,0);
  DrawGzm.FGzm.ReadFootageDataToStringGrid(FootageGrid,Strdt) ;
  if Trim(FootageGrid.Cells[1,2])<> ''  then
     MyDrawJinDaoGraph.SetMaxJinDaoTime(StrToDateTime(Trim(FootageGrid.Cells[1,2]),Public_Basic.FSetting));

  RefreshMyGraphChart;
end;

procedure TModifyJinDao_From.Pop_Foot_SaveClick(Sender: TObject);
begin
   SaveJinDaoIntoDAtaBase(1);
end;

procedure TModifyJinDao_From.Pop_Foot_UpdateDaoClick(Sender: TObject);
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

procedure TModifyJinDao_From.Pop_Foot_UpdateTimeClick(Sender: TObject);
begin
   UpdateTdateTimeFormCurrRow(FootageGrid,FootStringGrid_SelectRow);
end;

procedure TModifyJinDao_From.Pop_Foot_Update_allDataClick(Sender: TObject);
begin
   RefreshFootageStringGrid;
end;

procedure TModifyJinDao_From.Pop_Foot_Update_PartDataClick(Sender: TObject);
var
  CurrRow:integer;
begin
   CurrRow:=FootageGrid.RowCount-1;
   CurrRow:=UpdateShouDongInputFootae(FootageGrid,CurrRow,'Down');
   CurrRow:=FootageGrid.RowCount-1;
   CurrRow:=UpdateShouDongInputFootae(FootageGrid,CurrRow,'Up');

end;

function TModifyJinDao_From.ZoomRect(mRect: TRect; mZoom: Integer): TRect;
begin
  Result.Left := mRect.Left - mZoom;
  Result.Right := mRect.Right + mZoom;
  Result.Top := mRect.Top;// - mZoom;
  Result.Bottom := mRect.Bottom- mZoom;
end;



procedure TModifyJinDao_From.RefreshFootageStringGrid;
var
  CurrRow:integer;
begin
  CurrRow:=FootageGrid.RowCount-1;
  while CurrRow >2 do
       CurrRow:=UpdateShouDongInputFootae(FootageGrid,CurrRow,'Down');

  CurrRow:=FootageGrid.RowCount-1;
  while CurrRow >2 do
       CurrRow:=UpdateShouDongInputFootae(FootageGrid,CurrRow,'UP');
end;


procedure TModifyJinDao_From.RefreshMemoInfo(Memo:TMemo);
begin
     Memo.Clear ;
     Memo.Lines.Add('ѡ����������:'+DrawGzm.GraphClass.DataName);
     Memo.Lines.Add('�Ѿ�ѡ��:'+DrawGzm.GraphClass.SupportList);
end;






procedure TModifyJinDao_From.RefreshMyGraphChart;
begin
    // ��������ͼ
   DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,true,100,100);
   DrawGzm.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);

   MyDrawJinDaoGraph.SetWorkface_id(DrawGzm.FGzm.Gzmbh) ;
   MyDrawJinDaoGraph.SetSupportBh(DrawGzm.FGzm.RockPressAnalysis.JinDao_Support);
   //DrawGzm.RefreshChart_GraphLineSeries(GraphChart,GraphSeries,FirstPGBAr,SecondPGBar);
    MakeGraphChartTitle(GraphChart,GraphSeries);
    MyDrawJinDaoGraph.DrawGraphLine(GraphSeries,ColorBand);
    //ˢ����������ʾ
     // ������������ʾ
    GraphChart.BottomAxis.Minimum:=0;
    GraphChart.BottomAxis.Maximum:=ColorBand.StartValue+1;
    GraphChart.BottomAxis.Minimum:=ColorBand.StartValue-1;
   //RefreshContourlegendPalette;
   DrawGzm.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,False,0,0);
end;

procedure TModifyJinDao_From.Return_CallEditDateTime(DTS: String);
begin
   self.FootageGrid.Cells[1,FootStringGrid_SelectRow]:= DTS;
end;

procedure TModifyJinDao_From.Return_CallEditRockPressMemo(DTS: String);
begin

end;

procedure TModifyJinDao_From.SaveButtonClick(Sender: TObject);
begin
   Saved_DataBase:=False;
   DeleteOnRecordToFootage(FootageGrid,FootStringGrid_SelectRow);
end;

function TModifyJinDao_From.SaveJinDaoIntoDAtaBase(Flag: integer): Boolean;
var
  i:integer;
  t_s,Strdt:string;
  Daoshu:integer;
  StartTime:TdateTime;
begin
   if DrawGzm.FGzm.Gzmbh <0 then exit;
   if Trim(FootageGrid.Cells[1,2])<>''  then  begin
      StartTime:=StrToDateTime(Trim(FootageGrid.Cells[1,2]),Public_Basic.FSetting);
      Strdt:=Public_Basic.ReturnDateTimeString(MainDataModule.DataType ,StartTime);
      DrawGzm.FGzm.DeleteAllFootageData(Strdt);
   end else begin
      exit;
   end;

   Daoshu:=0;
   for I := 2 to FootageGrid.RowCount-1 do  begin
      if Trim(FootageGrid.Cells[0,i]) ='' then  break;
      if Public_Basic.StrToInt_lu(FootageGrid.Cells[2,i]) < Public_Basic.StrToInt_lu(FootageGrid.Cells[10,i]) then
         FootageGrid.Cells[2,i]:=FootageGrid.Cells[10,i];

      if Public_Basic.StrToInt_lu(FootageGrid.Cells[2,i])<=DaoShu then   begin
         inc(DaoShu);
      end else  begin
         Daoshu:=Public_Basic.StrToInt_lu(FootageGrid.Cells[2,i]);
      end;

      DrawGzm.FGzm.Manual_InputFootage(StrToDateTime(Trim(FootageGrid.Cells[1,i]),Public_Basic.FSetting),
                                      Public_Basic.StrToDouble_Lu(FootageGrid.Cells[3,i]) ,  //downStepDis
                                      Public_Basic.StrToDouble_Lu(FootageGrid.Cells[4,i]) ,  //autoDownFootage
                                      Public_Basic.StrToDouble_Lu(FootageGrid.Cells[5,i]) ,  //EditDownFootage
                                      Public_Basic.StrToDouble_Lu(FootageGrid.Cells[9,i]) ,  //UpperStepDis
                                      Public_Basic.StrToDouble_Lu(FootageGrid.Cells[8,i]) ,  //autoUpperFootage
                                      Public_Basic.StrToDouble_Lu(FootageGrid.Cells[7,i]) ,  //EditUpperFootage
                                      Daoshu ,  //jinDaoshu
                                      Flag   //flag
                                      );


   end;

   t_s:= '���ݴ洢�ɹ���';
   if Flag=1 then   begin
      DrawGzm.FGzm.UpdataRockPress_Process(0,Strdt,0);
      Application.MessageBox(Pwidechar(t_s),'��ʾ',MB_OK+MB_ICONQUESTION) ;
   end;
   OptionTip(0,t_s);
   // ˢ�±���
   InitFootageGrid;
   //
   Strdt:=Public_Basic.ReturnDateTimeString(MainDataModule.DataType ,StartTime);
   DrawGzm.FGzm.ReadFootageDataToStringGrid(FootageGrid,Strdt) ;

end;

procedure TModifyJinDao_From.SaveWorkFaceMemo1Text;
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

      StrValue:=StrValue+IntToStr(DrawGzm.FGzm.RockPressAnalysis.JinDao_Basic)+',';
      StrValue:=StrValue+IntToStr(DrawGzm.FGzm.RockPressAnalysis.JinDao_Support)+',';

      StrValue:=StrValue+IntToStr(DrawGzm.FGzm.RockPressAnalysis.JinDao_Time)+',' ;
      StrValue:=StrValue+IntToStr(DrawGzm.FGzm.RockPressAnalysis.Jindao_DataType);

    // �ϳ���ɫ�ַ���
   // StringGroupColor:=MakeStringGroupColorToString;
    StringGroupColor:='';
    if  length(Trim(StringGroupColor)) >0 then    begin
        StrValue:=StrValue+'&'+StringGroupColor;
    end;

    if DrawGzm.FGzm.UpdataFootStepParameters(StrValue,self.Edit_SupportNumber.Text) then
       OptionTip(0,'���ݸ��³ɹ�!') else   OptionTip(0,'���ݸ���ʧ��!')

end;

procedure TModifyJinDao_From.SetFromWidthAndHeigth(flag: integer);
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

procedure TModifyJinDao_From.SplitWorkFaceMemo1Text;
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
       DrawGzm.FGzm.RockPressAnalysis.Jindao_DataType:=1;
   end;
   StringGroupColor:='';
   ComboFootSteps.Text  :=intTostr(DrawGzm.FGzm.RockPressAnalysis.Oneday_daoshu);
   ComboBoxStepTime.Text :=intTostr(DrawGzm.FGzm.RockPressAnalysis.TwoDao_IntervalTime);
   Footsteps_L.Text :=FormatFloat('0.000',DrawGzm.FGzm.RockPressAnalysis.OneDao_step);
   Edit_SupportNumber.Text :=InttoStr(DrawGzm.FGzm.SupEndNumber);
   Edit_interVal_support.Text:=IntTostr(DrawGzm.FGzm.RockPressAnalysis.ManulInput_Interval_support);
   Support_JinDao_Combo.Text:=IntTostr(DrawGzm.FGzm.RockPressAnalysis.JinDao_Support);
   StringGroupColor:=DrawGzm.FGzm.RockPressAnalysis.ColorString;

end;

procedure TModifyJinDao_From.ToolButton1Click(Sender: TObject);
begin
  Pop_Foot_Save.Click ;
end;

end.  //end Unit