unit UForm_LineGraph;

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
  UMakeRuleClass, uDrarLineGraph
  ;

 type

  TForm_LineGraph = class(TForm)
    StatusBar1: TStatusBar;
    ImageList1: TImageList;
    ToolBar2: TToolBar;
    SaveButton: TToolButton;
    But_OpenScroll: TToolButton;
    But_SaveBMP: TToolButton;
    ExitButton: TToolButton;
    Open_ToolForm: TToolButton;
    But_NextData: TToolButton;
    PopupMenu_LineGraph: TPopupMenu;
    LineGraphPop_Refresh: TMenuItem;
    N6: TMenuItem;
    LineGraph_ScorllBar: TMenuItem;
    N3: TMenuItem;
    LineGraphPop_NextData: TMenuItem;
    N4: TMenuItem;
    LineGraphPop_SaveBMP: TMenuItem;
    N5: TMenuItem;
    LineGraphPop_tool: TMenuItem;
    Pop_Exit: TMenuItem;
    N1: TMenuItem;
    SavePictureDialog1: TSavePictureDialog;
    Panel_ProcessBar: TPanel;
    FirstPGBar: TProgressBar;
    SecondPGBar: TProgressBar;
    GraphChart: TChart;
    N2: TMenuItem;
    LineGraphPop_Markstep: TMenuItem;
    Mark_Memo: TMemo;
    But_MarkStep: TToolButton;
    N7: TMenuItem;
    LineGraph_changeUnit: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure GraphChartMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure LineGraphPop_toolClick(Sender: TObject);
    procedure LineGraph_ScorllBarClick(Sender: TObject);
    procedure LineGraphPop_NextDataClick(Sender: TObject);
    procedure LineGraphPop_RefreshClick(Sender: TObject);
    procedure Pop_ExitClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure But_NextDataClick(Sender: TObject);
    procedure Open_ToolFormClick(Sender: TObject);
    procedure LineGraphPop_SaveBMPClick(Sender: TObject);
    procedure GraphChartGetAxisLabel(Sender: TChartAxis; Series: TChartSeries;
      ValueIndex: Integer; var LabelText: string);
    procedure But_SaveBMPClick(Sender: TObject);
    procedure GraphChartMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormResize(Sender: TObject);
    procedure LineGraphPop_MarkstepClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure But_OpenScrollClick(Sender: TObject);
    procedure But_MarkStepClick(Sender: TObject);
    procedure LineGraph_changeUnitClick(Sender: TObject);
    
  private
     s_MinName,S_WorkFaceName:string;
     ReCallData:Boolean;
     //
     EXCaption:String; // �ⲿ�������ı���


     JinDaotimeCount:integer;
     JinDaotimeArray :Array of TContourFootageData;
     ScrollBar1 : TScrollBar;
     ShowScreen:integer;//��Ļ�رպ���
     //��������
     procedure OptionTip(index:integer;Str:String);
     function InputFaceWoking(MkName, WkName: string):Boolean;
     procedure ChangePressDataUnit(Flag:integer);  // �������ݵ�λ
     procedure InitDrawGzmClass;//��ʼ����������
     procedure MakeWindowsSingle(Single:integer);
     //�����Ҽ�����
     procedure SetScrollVisible(Value:Boolean);// ����ʮ������ָʾ);
     procedure SetStepMarks(Value:Boolean);//�����ѹ���
     function CreateSaveBmpPath:String; //��������ͼƬ���ļ�·��
     function LineGraphChartSaveIntoBMP(Path:string):Boolean;
     function GetLineGraphChartBmpFileName:String;  //��ȡLineGraph�����ļ����ļ���
     // ���� ��ݹ�����
     procedure DispLineGraphPop(Px,Py:Integer);//��ʾGraphChart ���ƵĹ�����
     procedure RefreshButtonVisiuble;
     // ��������
     procedure ClearJinDaotimeArray;
     procedure AddJinDaotimeArray(Rec:TContourFootageData);
     procedure LoadJinDaoAndTime(MinDao,MaxDao:integer);
     // graphChart
     procedure InitChart(Chart:TChart);
     function  GetJinDaoFromJinDaotimeArray(TD,DT:String):String;
     procedure ScrollBar1Change(Sender : TObject);
     function GetOldStepNumber(Value:string;Var Supportbh,stepNumber,Qd:integer):Boolean;
     procedure DispLabelMarkToMemo(Value:Boolean;Px,Py,SupportBh,id,Qd:integer);

  public
      DrawLineGraph:TDrawLineGraph;
      Main_Line_DrawClass:TDrawGrap;  // �������
      function InitForm(MkName, WkName: string):Boolean;      //��ʼ�����沿�ֹ���
      function GetReCallFrom:Boolean;
      procedure InputSupportList(Value:string);   //�ⲿ����֧���ַ���
      procedure RefreshMyGraphChart(Display:Boolean);
      procedure SetOpenFormVar( iDC:TDrawGrap;
                 SupportList:String;CycleEff,OpenTool:Boolean);
      function SaveChartToBmp:string;
  end;

function CreateLineGraph(AHandle:THandle;ACaption:string;Wid,Hi,Single:integer):THandle;stdcall;

var
   Form_LineGraph: TForm_LineGraph;

implementation

{$R *.dfm}

uses  Lu_Public_BasicModual, PStope_GzmGuidClass, RockPresstool;

function CreateLineGraph(AHandle:THandle;ACaption:string;Wid,Hi,Single:integer):THandle;stdcall;
{

  Single 0 ����ҳ��  1 ȫ��ҳ��
}
begin
        if Assigned(Form_LineGraph) then  FreeAndNil(Form_LineGraph);
        Application.Handle :=AHandle;
        Form_LineGraph:=TForm_LineGraph.Create(Application);

         try
           with Form_LineGraph do begin
               EXCaption:=ACaption;
               ParentWindow:=Ahandle;
               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

               MakeWindowsSingle(Single);
               Result:=Form_LineGraph.Handle ;//����ֵ
          end ;
        except
           FreeAndNil(Form_LineGraph);
        end;


end;

{ TForm1 }



procedure TForm_LineGraph.AddJinDaotimeArray(Rec: TContourFootageData);
begin
   inc(JinDaotimeCount);
   setlength(JinDaotimeArray,JinDaotimeCount);
   JinDaotimeArray[JinDaotimeCount-1]:=Rec;
end;

procedure TForm_LineGraph.But_MarkStepClick(Sender: TObject);
begin
   SetStepMarks(not DrawLineGraph.MarkerStep );
   RefreshMyGraphChart(true);
end;

procedure TForm_LineGraph.But_NextDataClick(Sender: TObject);
begin
    LineGraphPop_NextData.Click ;
end;

procedure TForm_LineGraph.But_OpenScrollClick(Sender: TObject);
begin
     SetScrollVisible(not scrollBar1.Visible);
end;

procedure TForm_LineGraph.ChangePressDataUnit(Flag: integer);
var
  i,j:integer;
  TemValue:Double;
  UnitName:string;
begin
  if Flag=1 then   begin
     UnitName :='��ǰ���ݵ�λΪѹǿ MPa' ;
     Main_Line_DrawClass.ColorValue.UnitType :=1;
     Main_Line_DrawClass.ColorValue.UnitValue:=1;
     LineGraph_changeUnit.Caption :='����Ϊ����ѹǿBar';
  end else if Flag=2 then begin
     UnitName :='��ǰ���ݵ�λΪѹǿ Bar' ;
     Main_Line_DrawClass.ColorValue.UnitType:=2;
     Main_Line_DrawClass.ColorValue.UnitValue:=10;
     LineGraph_changeUnit.Caption :='����Ϊ����ѹ��KN';
  end else if Flag=3 then begin
     UnitName :='��ǰ���ݵ�λΪѹ�� KN' ;
     Main_Line_DrawClass.ColorValue.UnitType:=3;
     Main_Line_DrawClass.Cal_MPaChangeKN_xs;
     Main_Line_DrawClass.ColorValue.UnitValue:= Main_Line_DrawClass.ColorValue.MPaChangeKN_Xs;
     LineGraph_changeUnit.Caption :='����Ϊ����ѹǿMPa';
  end;

   Caption:=EXCaption+'��'+ UnitName+'��';
   RefreshMyGraphChart(true);
end;

procedure TForm_LineGraph.ClearJinDaotimeArray;
begin
 JinDaotimeCount:=0;
 setlength(JinDaotimeArray,JinDaotimeCount);

end;

function TForm_LineGraph.CreateSaveBmpPath: String;
var
 BmpPath:WideString;
begin
    BmpPath:=Public_Basic.Get_MyModulePath+'SaveBmp\KYFX\'+Trim(IntTostr(Main_Line_DrawClass.FGzm.Gzmbh)) + '\'  ;
    if  not DirectoryExists(BmpPath) then
         ForceDirectories(BmpPath);

    Result:=BmpPath;
end;

procedure TForm_LineGraph.DispLabelMarkToMemo(Value: Boolean; Px, Py, SupportBh,
  id,Qd: integer);
  {
    QD := 10 9  8 ���� modifydata = 10 9 8
         �ֱ���� QL_oldsteps,YB_oldsteps,JB_oldsteps ��������

    id ������� �����е�λ��
  }
var
  i:integer;
begin
    if  not Value then Mark_Memo.Visible :=False;

    if Value  then  begin
       Mark_Memo.Top :=py;
       Mark_Memo.Left :=Px;
       Mark_Memo.Enabled :=False;
       if DrawLineGraph.ReturnMarkLabel(Mark_Memo,SupportBh,id,qd) then
          Mark_Memo.Visible :=True;
    end;

end;

procedure TForm_LineGraph.DispLineGraphPop(Px, Py: Integer);
begin
    LineGraph_ScorllBar.Enabled :=true;
    LineGraphPop_NextData.Enabled :=false;
    LineGraphPop_SaveBmp.Enabled :=false;
    LineGraphPop_Markstep.Enabled :=False;

    if Main_Line_DrawClass.GraphClass.YAxisType =1 then
       if DrawLineGraph.SupportMaxCount  >6 then
          LineGraphPop_NextData.Enabled :=true;
    if GraphChart.SeriesCount >0  then  begin
       LineGraphPop_SaveBmp.Enabled :=True;
    end;
    if (Main_Line_DrawClass.GraphClass.CycleDataEfficient)  and  ( Main_Line_DrawClass.CloudClass.RockPressAnslysis)  then
        LineGraphPop_Markstep.Enabled:=true;

    PopupMenu_LineGraph.Popup(px,py);
end;

procedure TForm_LineGraph.ExitButtonClick(Sender: TObject);
begin
    Close;
end;

procedure TForm_LineGraph.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
   pic_Path:string;
   pt1,pt2:TPoint;
begin
   if ShowScreen=1 then  begin
      Pic_Path  :=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\OneCoal'+'_4_1.BMP';
      Form_LineGraph.GraphChart.SaveToBitmapFile(Pic_Path);
   end;

  {�رմ��壬������Ҫ����Close����}
   if Assigned(Form_LineGraph) then  FreeAndNil(Form_LineGraph);
end;

procedure TForm_LineGraph.FormCreate(Sender: TObject);
begin
     MainDataModule.ReadPublicUsedMkInfoFromFile;
     //Create Class
     Main_Line_DrawClass:=TDrawGrap.Create(MainDataModule.ExConn);
     DrawLineGraph:=TDrawLineGraph.Create ;
     //
     s_MinName :=MainDataModule.Coal_Name;
     S_WorkFaceName :=MainDataModule.WorkFace_Name;
     //����ͼƬ�����ļ���
     GraphChart.Align:=alClient;
     InitChart(GraphChart);
     ReCallData:=False;

end;

procedure TForm_LineGraph.FormDestroy(Sender: TObject);
begin

   FreeAndNil(Main_Line_DrawClass);
   FreeAndNil(DrawLineGraph);
   FreeAndNil(Scrollbar1);
end;

procedure TForm_LineGraph.FormResize(Sender: TObject);
begin
    if WindowState=wsMaximized  then  begin
       StatusBar1.Visible :=False;
    end else begin
       StatusBar1.Visible :=true;
    end;

end;

procedure TForm_LineGraph.FormShow(Sender: TObject);
begin
    InitForm('','');
end;

function TForm_LineGraph.GetJinDaoFromJinDaotimeArray(TD,DT: String): String;
{ DT  JinDao, Down_Footage,Upper_Footage;}
var
  tmp_TD:TdateTime;
  i,selectid,Start:integer;
begin
    { JinDaotimeCount:integer;
     JinDaotimeArray :Array of TContourFootageData;
}
    Result:='';
    selectid:=-1;
    if trim(TD) ='' then   exit;
    Start:=pos('-',TD);

    if Start=0 then  begin
       tmp_TD:=Public_Basic.StrToDouble_Lu(TD);
    end else begin
       tmp_TD:=StrToDateTime(TD,Public_Basic.FSetting);
    end;

    for I := 0 to JinDaotimeCount-1 do begin
       if i< JinDaotimeCount-1 then   begin
          if (JinDaotimeArray[i].DT <= tmp_TD ) and (JinDaotimeArray[i+1].DT > tmp_TD) then  begin
              selectid:=i;
              break;
          end;
       end else  if i= JinDaotimeCount-1 then   begin
          if (JinDaotimeArray[i].DT <= tmp_TD ) then begin
              selectid:=i;
              break;
          end;
       end;

    end;

    if selectid>0 then  begin
       if DT='JinDao' then begin
          Result:=IntTostr(JinDaotimeArray[i].Daoshu);
       end else if  DT='Down_Footage' then begin
          Result:=FormatFloat('0.0',JinDaotimeArray[i].Down_footage);
       end else if  DT='Upper_Footage' then begin
          Result:=FormatFloat('0.0',JinDaotimeArray[i].Upper_Footage);
       end;

    end;

end;

function TForm_LineGraph.GetLineGraphChartBmpFileName: String;
var
  MinLab,MaxLab:integer;
begin
   Result:='';
   if Main_Line_DrawClass.FGzm.Gzmbh <1 then  exit;
   MinLab:=Main_Line_DrawClass.DataTimeAndFootAge.Graph_MinDao;
   MaxLab:=Main_Line_DrawClass.DataTimeAndFootAge.Graph_MaxDao;
   Result:='LGN_'+Trim(IntTostr(MinLab))+ '_'+Trim(IntTostr(MaxLab)) ;


end;

function TForm_LineGraph.GetOldStepNumber(Value: string; var Supportbh,
  stepNumber,Qd: integer): Boolean;
  {
    QD ���� ��ѹ��ǿ��ֵ 10 ���� ModifyData =10
                         9 ���� ModifyData =9
                         8 ���� ModifyData =8
  }
var
  Sup_St,sup_ed:integer;
  SN_st,SN_ed:integer;
  tmStr,First_s:String;
begin
    Result:=False;
    Sup_St:=pos('[',Value);
    sup_ed:=pos(']',Value);
    Sn_st:=pos('(',Value);
    SN_ed:=pos(')',Value);
    Supportbh:=public_Basic.StrToInt_lu(copy(Value,Sup_St+1,sup_ed-Sup_St-1));
    if Supportbh< 1 then  exit;
    tmStr:=copy(Value,Sn_st+1,SN_ed-Sn_st-1);
    First_s:=copy(tmStr,1,1);
    if First_s='Q' then  begin
       Qd:=10;
    end else if First_s='Y' then  begin
       Qd:=9;
    end else if First_s='J' then  begin
       Qd:=8;
    end else  begin
       exit;
    end;
    stepNumber:=public_Basic.StrToInt_lu(copy(tmStr,3,length(tmstr)-2));
    if stepNumber< 1 then  exit;
    Result:=true;
end;

function TForm_LineGraph.GetReCallFrom: Boolean;
begin
     Result:=ReCallData;
end;

procedure TForm_LineGraph.GraphChartGetAxisLabel(Sender: TChartAxis;
  Series: TChartSeries; ValueIndex: Integer; var LabelText: string);
var
  Raplab:string;
  Text:String;
begin
        if Sender=GraphChart.BottomAxis.SubAxes.Items[0] then   begin
            Text:=StringReplace (LabelText, ',', '', [rfReplaceAll]);
            if Main_Line_DrawClass.ConTourSeriesPar.Display_DownFootage =1 then  begin
               Raplab:=GetJinDaoFromJinDaotimeArray(Text,'Down_Footage');
               LabelText:=Raplab;

            end;
        end;


       if Sender=GraphChart.BottomAxis then   begin
            Text:=StringReplace (LabelText, ',', '', [rfReplaceAll]);
            Raplab:=GetJinDaoFromJinDaotimeArray(Text,'JinDao');
            LabelText:=Raplab;
       end;

       if Sender=GraphChart.TopAxis then   begin
           if Main_Line_DrawClass.ConTourSeriesPar.Display_UpperFootage =1 then  begin
              Text:=StringReplace (LabelText, ',', '', [rfReplaceAll]);
              Raplab:=GetJinDaoFromJinDaotimeArray(Text,'Upper_Footage');
              LabelText:=Raplab;
           end;

       end;

end;

procedure TForm_LineGraph.GraphChartMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
 var
  pt:Tpoint;
  s, i,SupportBh,Stepid,QD:integer;
  series : TPointSeries;
  markPos : TSeriesMarkPosition;
  MarkLabel:String;
begin
  DispLabelMarkToMemo(False,0,0,0,0,0);

   if Button=mbRight then begin
      pt:= GraphChart.ClientToScreen(Point(0,0));
      DispLineGraphPop(pt.X+x,pt.Y +y);

   end;

   if (Button=mbLeft) and (DrawLineGraph.MarkerStep) then begin
       for S := 0 to GraphChart.SeriesCount - 1 do
          begin
            if GraphChart[S] is TPointSeries then       begin
              Series := GraphChart[S] as TPointSeries;
                for i := 0 to Series.Count - 1 do        begin
                    if (Series.Marks.Positions[i] <> nil) then                begin
                          markPos := Series.Marks.Positions[i]; // saved custom location in screen coords
                          if (x > markPos.LeftTop.X ) and ( x < markPos.LeftTop.x+markPos.Width ) and
                             (Y > markPos.LeftTop.Y ) and ( Y < markPos.LeftTop.y+markPos.Height  )  then begin
                                 MarkLabel:=Trim(Series.Marks.Item[i].Text.Text) ;
                                 if GetOldStepNumber(MarkLabel,SupportBh,Stepid,Qd)  then  begin
                                    pt:= GraphChart.ClientToScreen(Point(0,0));
                                    DispLabelMarkToMemo(true,x,y,SupportBh,Stepid,qd);
                                 end;

                            end;
                    end;
                end;
            end;
          end;
   end;


end;

procedure TForm_LineGraph.GraphChartMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
     DispLabelMarkToMemo(False,0,0,0,0,0);
     if WheelDelta>0 then  begin  //����  ǰ�� �Ŵ�
         GraphChart.ZoomPercent( 110 );
     end else begin   //����  ��� ��С
         GraphChart.ZoomPercent( 90);
     end;


end;

procedure TForm_LineGraph.InitChart(Chart:TChart);
begin
      //Chart.ClearChart ;

      Chart.BottomAxis.SubAxes.Add ;
        //�ƶ�legend˳��
      Chart.Legend.CheckBoxes:=true;
      Chart.View3D :=False;
        //����Scrollbar1
      Scrollbar1 := TScrollBar.Create(Chart);
      Scrollbar1.Parent := Chart;
      ScrollBar1.Align := alBottom;
      ScrollBar1.OnChange := ScrollBar1Change;
      ScrollBar1.Visible := False;
      ScrollBar1.Enabled := False;


end;

procedure TForm_LineGraph.InitDrawGzmClass;
var
  i:integer;
begin

    // ��������
    Main_Line_DrawClass.GraphClass.Out_input_Data :=False;
    Main_Line_DrawClass.GraphClass.Graph_DataCalss:=single;
    Main_Line_DrawClass.GraphClass.SupportList :='';
    Main_Line_DrawClass.GraphClass.Support_Select_List:='';
    Main_Line_DrawClass.GraphClass.ScrollPageSize :=2; //3��
    // ��һ��ʾʱ ׷������
    for I := 0 to 2 do
         Main_Line_DrawClass.GraphClass.Disp_DataType[i]:=true;

     Main_Line_DrawClass.GraphClass.YAxisType:=4;  // �ĸ�������
     // ���� ������ ��ʾ
     Main_Line_DrawClass.GraphClass.Line_Tpye:=1;// ���������Ƿ� �ò�ͬ���ͱ�ʾ  0 ͳһ���� 1 ��ͬ����
     Main_Line_DrawClass.GraphClass.Line_Color:=1; //�������� �Ƿ� ͳһ��ɫ��ʾ  0 ��ɫ  1 ��ɫ �� ��  ��  ��
     Main_Line_DrawClass.GraphClass.Line_Width:=0;  // �ߵĿ���Ϊ1
    //
    Main_Line_DrawClass.ConTourSeriesPar.Display_UpperFootage:=1; //�ۼƽ���
    Main_Line_DrawClass.ConTourSeriesPar.Display_DownFootage:=0;  //ʱ��
  //��ȡ��������ʾ�����÷�ʽ

    Main_Line_DrawClass.CloudClass.X_Axis_Disp_Type:=0;   //��ʾ�̶�����
    Main_Line_DrawClass.CloudClass.X_Axis_Disp_Dao:=80;

  //��ȡ�Ƿ���ʾԤ��������Ϣ
    Main_Line_DrawClass.CloudClass.DisPlayForcase:=true;


    //��ȡ�Ƿ���ʾ��С����֮ǰ����ѹ����
     Main_Line_DrawClass.CloudClass.DisPlayProMinDaoSaveStep:=true;

     //��ȡ�Ƿ�������·���  ���ڽ���֮�ڵ����򱣴������
     Main_Line_DrawClass.CloudClass.RecallMidDaoSaveStep:=False;

   //��ȡ�洢�������Ƿ���Ա༭
     Main_Line_DrawClass.CloudClass.SaveDate_Edit:=true;


     //��ȡ������Χ֮�����ѹ��Ϣ�Ƿ����
     Main_Line_DrawClass.CloudClass.PrintOutDaoStepInto:=False;

       //��ȡ��ѹ���ݷֶ���ʾ��ʽ
     Main_Line_DrawClass.CloudClass.PrintDispPhaseVisual:=False;
     // Tabpage ����ʾ ��ʽ
     Main_Line_DrawClass.GraphClass.FisrtPageId:=2;
     Main_Line_DrawClass.GraphClass.SecondPageid:=1;
end;

function TForm_LineGraph.InitForm(MkName, WkName: string):Boolean;
var
  i:integer;
begin
    Result:=False;
    Public_basic.InitStatusBar(StatusBar1);
    if  WkName='' then   begin
       if not  InputFaceWoking(s_MinName,S_WorkFaceName) then
          exit;
    end else begin
       if not InputFaceWoking(MkName, WkName) then
          exit;
    end;

    // ��ʼ��DrawGzmClass
    InitDrawGzmClass;
    SetScrollVisible(False);
    // ˢ�°�ť
    RefreshButtonVisiuble;
    // ��ѹ��ǵı�ע
    SetStepMarks(FALSE);
    //MarkLabel False
    DispLabelMarkToMemo(False,0,0,0,0,0);
    Result:=true;
end;

function TForm_LineGraph.InputFaceWoking(MkName, WkName: string): Boolean;
begin
   Result:=true;
   if length(trim(WkName))=0 then  exit;
   if not Main_Line_DrawClass.SelectMineAndWorkFaceBh(MkName, WkName) then   exit;
   //�ж��빤������ص����ݱ��Ƿ񴴽������û�д������ٴ˴���
   if not MainDataModule.IsExsitTableName('D_'+inttostr(Main_Line_DrawClass.FGzm.Gzmbh)+'_BasicData') then begin
       MainDataModule.CreateTable('2',MainDataModule.DataType,inttostr(Main_Line_DrawClass.FGzm.Gzmbh),'') ;
   end;

   // �ڴ˶�FGZM ��֧�������Ϣ���в���
    if not Main_Line_DrawClass.Cal_MPaChangeKN_xs then  begin
       //messagebox(Handle,'�벹ȫҺѹ֧������������','ϵͳ��ʾ',mb_iconerror+mb_ok);
    end;

   OptionTip(0,'�ԡ�'+Main_Line_DrawClass.FGzm.S_Name+'�����ݽ��з���!');
   Result:=true;

end;

procedure TForm_LineGraph.InputSupportList(Value: string);
begin
    Main_Line_DrawClass.GraphClass.SupportList :=Value;
end;

function TForm_LineGraph.LineGraphChartSaveIntoBMP(Path: string): Boolean;
var
  FileName,tmp:string;
  Index:Integer;
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
          GraphChart.SaveToBitmapFile(SavePictureDialog1.FileName);
          if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWaterFromFile(SavePictureDialog1.FileName)
            else Public_Basic.AddMultTextWaterFormFile(SavePictureDialog1.FileName);
   end else begin
      tmp:=GetLineGraphChartBmpFileName;
      if tmp ='' then  exit;
      Index:= Main_Line_DrawClass.GraphClass.YAxisType;
      FileName:=CreateSaveBmpPath+ tmp +'_'+IntToStr(Index)+'.bmp';
      GraphChart.SaveToBitmapFile(FileName);
      if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWaterFromFile(FileName)
            else Public_Basic.AddMultTextWaterFormFile(FileName);

   end;


end;

procedure TForm_LineGraph.LineGraph_changeUnitClick(Sender: TObject);
begin
  if Main_Line_DrawClass.ColorValue.UnitType =1 then  begin
     ChangePressDataUnit(2);
  end else if Main_Line_DrawClass.ColorValue.UnitType=2 then   begin
     ChangePressDataUnit(3);
  end else if Main_Line_DrawClass.ColorValue.UnitType=3 then   begin
     ChangePressDataUnit(1);
  end;

end;

procedure TForm_LineGraph.LineGraph_ScorllBarClick(Sender: TObject);
begin
   SetScrollVisible(not scrollBar1.Visible);
end;

procedure TForm_LineGraph.LineGraphPop_MarkstepClick(Sender: TObject);
begin
   SetStepMarks(not DrawLineGraph.MarkerStep );
   RefreshMyGraphChart(true);
end;

procedure TForm_LineGraph.LineGraphPop_NextDataClick(Sender: TObject);
begin
    DrawLineGraph.NextDataDisp :=DrawLineGraph.NextDataDisp+1;
    RefreshMyGraphChart(true);
end;

procedure TForm_LineGraph.LineGraphPop_RefreshClick(Sender: TObject);
begin
   RefreshMyGraphChart(False);
end;

procedure TForm_LineGraph.LineGraphPop_SaveBMPClick(Sender: TObject);
begin
   SavePictureDialog1.Execute ;
   LineGraphChartSaveIntoBMP(SavePictureDialog1.FileName);
end;

procedure TForm_LineGraph.LineGraphPop_toolClick(Sender: TObject);
begin
   CreateRockPressTool(Application.Handle,'����ͼ�����������ý���',
                       Width ,Height,2);
end;

procedure TForm_LineGraph.LoadJinDaoAndTime(MinDao, MaxDao: integer);
var
  sql,Strdt:string;
  MaxTime:TDateTime;
  Rd:TJinDaoRecord;
  MySqlDataSet1 :TMyDataSet;
  rec:TContourFootageData;
begin
    MySqlDataSet1:=TMyDataSet.Create(nil);
    MySqlDataSet1.MySqlConnection :=MainDataModule.ExConn;

    MySqlDataSet1.Close ;

   Strdt:=Public_Basic.ReturnDateTimeString(MainDataModule.DataType ,MaxTime);

   Sql:=' select * from  D_'+IntToStr(Main_Line_DrawClass.FGzm.Gzmbh)+'_footage ' +
        ' where  DaoShu >= ' + IntTostr(MinDao) +  ' and  DaoShu <= ' + IntToStr(MaxDao) +
        ' order by Daoshu  ' ;
   self.ClearJinDaotimeArray;
   MySqlDataSet1.CommandText :=sql;
   try
      if MySqlDataSet1.Open then
       while not MySqlDataSet1.Eof  do  begin
          Main_Line_DrawClass.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);
          rec.DT :=MySqlDataSet1.FieldByName('FootDay').AsDateTime;
          rec.Down_footage:=MySqlDataSet1.FieldByName('sumdownfootage').AsFloat;
          rec.Upper_Footage:=MySqlDataSet1.FieldByName('sumdownfootage').AsFloat;
          rec.Daoshu:=MySqlDataSet1.FieldByName('DaoShu').AsInteger;
          AddJinDaotimeArray(Rec);
          MySqlDataSet1.Next;
       end;
   finally
      MySqlDataSet1.Close ;
      FreeAndNil(MySqlDataSet1);
   end;

end;

procedure TForm_LineGraph.MakeWindowsSingle(Single: integer);
begin
     if Single=0 then  begin
        WindowState:= wsMaximized;
        ShowScreen:=0;
     end else  begin
        WindowState:= wsNormal;
        ShowScreen:=Single;
     end;
     Show;
end;

procedure TForm_LineGraph.Open_ToolFormClick(Sender: TObject);
begin
     LineGraphPop_tool.Click;
end;

procedure TForm_LineGraph.OptionTip(index: integer; Str: String);
begin
    StatusBar1.Panels[index].Text :=str;
end;

procedure TForm_LineGraph.Pop_ExitClick(Sender: TObject);
begin
    Close;
end;

procedure TForm_LineGraph.RefreshButtonVisiuble;
begin
       But_NextData.Enabled :=False;
       LineGraphPop_NextData.Enabled :=False;
       But_SaveBMP.Enabled :=FALSE;
       But_MarkStep.Enabled :=False;

      if Main_Line_DrawClass.GraphClass.YAxisType =1 then
         if DrawLineGraph.SupportMaxCount  >6 then  begin
            But_NextData.Enabled :=True;
            LineGraphPop_NextData.Enabled :=true;
         end;
    if GraphChart.SeriesCount >0  then  begin
       But_SaveBMP.Enabled :=True;
    end;

    if (Main_Line_DrawClass.GraphClass.CycleDataEfficient)  and
       ( Main_Line_DrawClass.CloudClass.OldStepDisplay)  then
        But_MarkStep.Enabled:=true;
end;

procedure TForm_LineGraph.RefreshMyGraphChart(Display: Boolean);
begin
    // ˢ�°�ť
     RefreshButtonVisiuble;
     Main_Line_DrawClass.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,true,100,100);
     Main_Line_DrawClass.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
    {iChart:TChart;iDTF:TDataTimeAndFootAge;
                           iClourClass:TCloudClass;
                           iGzm:TGzm;
                           iLineClass:TGraphDataClass;
                           iFBP,iSPB:TProgressBar
                           }
   DrawLineGraph.UnitType := Main_Line_DrawClass.ColorValue;
   // ��ȡ��������
   Main_Line_DrawClass.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
   LoadJinDaoAndTime(Main_Line_DrawClass.DataTimeAndFootAge.Graph_MinDao,
                     Main_Line_DrawClass.DataTimeAndFootAge.Graph_MaxDao);

   DrawLineGraph.InitClass(GraphChart,
                           ScrollBar1,
                           Main_Line_DrawClass,
                           FirstPGBar,SecondPGBar
                           ) ;
   // �� ͼ�α���ΪͼƬ
   GraphChart.Repaint ;
   LineGraphChartSaveIntoBMP('');
   //�رչ���������
   SetScrollVisible(False);
   //�رս��ȹ�����
   Main_Line_DrawClass.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,False,0,0);
   ReCallData:=true;
end;

procedure TForm_LineGraph.SaveButtonClick(Sender: TObject);
begin
    LineGraphPop_Refresh.Click ;
end;

function TForm_LineGraph.SaveChartToBmp: string;
var
  FileName,tmp:string;
  Index:Integer;
begin
    tmp:=GetLineGraphChartBmpFileName;
    if tmp ='' then  exit;
    Index:= Main_Line_DrawClass.GraphClass.YAxisType;
    FileName:=CreateSaveBmpPath+ tmp +'_'+IntToStr(Index)+'.bmp';
    GraphChart.SaveToBitmapFile(FileName);
    if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWaterFromFile(FileName)
          else Public_Basic.AddMultTextWaterFormFile(FileName);
    Result:=FileName;
end;

procedure TForm_LineGraph.ScrollBar1Change(Sender: TObject);
var
  graphMin : Double;
  graphMax : Double;
begin
  DispLabelMarkToMemo(False,0,0,0,0,0);

  graphMin := scrollBar1.Position;
  graphMax := graphMin + scrollBar1.PageSize;

  if graphMax > scrollBar1.Max then
  begin
    graphMax := scrollBar1.Max;
  end;

  if graphMin < scrollBar1.Min then
  begin
    graphMin := scrollBar1.Min;
  end;

  GraphChart.Axes.Bottom.SetMinMax(graphMin, graphMax);

end;

procedure TForm_LineGraph.SetScrollVisible(Value: Boolean);
begin
    DispLabelMarkToMemo(False,0,0,0,0,0);
    if Value then    begin
         //����ScrollBar
        GraphChart.BottomAxis.Automatic :=false;
        GraphChart.AllowPanning:=pmNone;

        scrollBar1.SetParams(0, trunc(Main_Line_DrawClass.DataTimeAndFootAge.StartTime),
                                Trunc(Main_Line_DrawClass.DataTimeAndFootAge.EndTime));
        if Main_Line_DrawClass.GraphClass.ScrollPageSize=0 then   begin
           scrollBar1.PageSize :=1;
        end else  if Main_Line_DrawClass.GraphClass.ScrollPageSize=1 then   begin
           scrollBar1.PageSize :=2;
        end else  if Main_Line_DrawClass.GraphClass.ScrollPageSize=2 then   begin
           scrollBar1.PageSize :=3;
        end else  if Main_Line_DrawClass.GraphClass.ScrollPageSize=3 then   begin
           scrollBar1.PageSize :=4;
        end else  begin
           scrollBar1.PageSize :=6;
        end;

        scrollBar1.SmallChange := 1;
        scrollBar1.LargeChange := scrollBar1.PageSize;
        scrollBar1.Position := (trunc(Main_Line_DrawClass.DataTimeAndFootAge.StartTime)+
                                      trunc(Main_Line_DrawClass.DataTimeAndFootAge.EndTime)) div 2
                              - scrollBar1.PageSize div 2;
        scrollBar1.Visible := true;
        scrollBar1.Enabled := true;
        LineGraph_ScorllBar.Caption :='��ֹʹ�ù�����';
        But_OpenScroll.Caption :='���÷Ŵ�';
    end else  begin
        scrollBar1.Visible := False;
        scrollBar1.Enabled := False;

        GraphChart.BottomAxis.Automatic :=true;
        GraphChart.AllowPanning:=pmNone;
        GraphChart.Zoom.MouseButton:=mbLeft;

        LineGraph_ScorllBar.Caption :='��ͼ�ι�����';
        But_OpenScroll.Caption :='ʹ�÷Ŵ�';
    end;

end;

procedure TForm_LineGraph.SetStepMarks(Value: Boolean);
begin
     if Value then  begin
         DrawLineGraph.MarkerStep:=true;
         LineGraphPop_Markstep.Caption :='ȡ����ѹ���';
         But_MarkStep.Caption :='ȡ����ע';
     end else begin
         DrawLineGraph.MarkerStep:=FALSE;
         LineGraphPop_Markstep.Caption :='��ע��ѹ���';
         But_MarkStep.Caption :='��ע��ѹ';
     end;
end;

procedure TForm_LineGraph.SetOpenFormVar(iDC:TDrawGrap;
            SupportList: String;CycleEff,OpenTool:Boolean);
var
   i,j:integer;
begin
    if length(SupportList)< 1 then   begin
        Main_Line_DrawClass.GraphClass.Out_input_Data :=False;
    end else begin
        Main_Line_DrawClass.GraphClass.Out_input_Data :=true;
    end;
    // �� iDC �����ݴ���
    Main_Line_DrawClass.CloudClass:= iDC.CloudClass;
    Main_Line_DrawClass.Auto_Judge_OldStep:= Main_Line_DrawClass.ChangeJudgeStepClass(Main_Line_DrawClass.CloudClass.Yuntu_CycleData) ;
    Main_Line_DrawClass.GraphClass.CycleDataEfficient:=CycleEff;
    if Main_Line_DrawClass.GraphClass.CycleDataEfficient then  begin
        Main_Line_DrawClass.FilledContourDataNumber:=High(iDC.MyContourDoubleGrid)+1;
        setlength(Main_Line_DrawClass.MyContourDoubleGrid,High(iDC.MyContourDoubleGrid)+1);
        for I := 0 to High(iDC.MyContourDoubleGrid) do  begin
            setlength(Main_Line_DrawClass.MyContourDoubleGrid[i],High(iDC.MyContourDoubleGrid[i])+1);
            for j := 0 to High(iDC.MyContourDoubleGrid[i])do
             Main_Line_DrawClass.MyContourDoubleGrid[i][j]:= iDC.MyContourDoubleGrid[i][j];
        end;

        if iDC.CloudClass.RockPressAnslysis  then  begin
           Main_Line_DrawClass.CloudClass.RockPressAnslysis :=true;
           Main_Line_DrawClass.Auto_Judge_OldStep.CopyThisClass(iDC.Auto_Judge_OldStep);
           Main_Line_DrawClass.FGzm.RockPressAnalysis:= iDC.FGzm.RockPressAnalysis;
        end else begin
           Main_Line_DrawClass.CloudClass.RockPressAnslysis :=False;
        end;



    end else begin
         Main_Line_DrawClass.FilledContourDataNumber:=0;
    end;


    Main_Line_DrawClass.DataTimeAndFootAge.Graph_MinDao:=iDC.DataTimeAndFootAge.Graph_MinDao;
    Main_Line_DrawClass.DataTimeAndFootAge.Graph_MaxDao:=iDC.DataTimeAndFootAge.Graph_MaxDao;

    Main_Line_DrawClass.GraphClass.Support_Select_List:= SupportList;


    // �� ҳ�����ý���
    if OpenTool then begin
        CreateRockPressTool(Application.Handle,'����ͼ�����������ý���',
                           Width ,Height,2);
        // ����pageҳ�����ʾ
        FormPressTool.MainPage.ActivePageIndex:=2;
        FormPressTool.SecondPage_2.ActivePageIndex:=0;
        FormPressTool.Tab_SupDisp.TabVisible :=true;
        FormPressTool.Tab_SupBar.TabVisible:=FAlse;
    end;
    //�ı����ݵ�λ
     ChangePressDataUnit(3);
end;

procedure TForm_LineGraph.But_SaveBMPClick(Sender: TObject);
begin
   LineGraphPop_SaveBMP.click;
end;

end.  //end Unit