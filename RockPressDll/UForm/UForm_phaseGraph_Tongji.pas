unit UForm_phaseGraph_Tongji;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, Vcl.ComCtrls,
  VCLTee.TeEngine, VCLTee.TeeTools, VCLTee.Series, VCLTee.TeeProcs,
  VCLTee.Chart, Vcl.ExtCtrls, Vcl.ExtDlgs, System.ImageList, Vcl.ImgList,
  Vcl.ToolWin,
  uDrawGraphClass, Vcl.StdCtrls, Vcl.Menus
  ;

type
  TForm_TongJIGraph = class(TForm)
    ToolBar2: TToolBar;
    SaveButton: TToolButton;
    Open_ToolForm: TToolButton;
    ToolButton1: TToolButton;
    ExitButton: TToolButton;
    ImageList1: TImageList;
    SavePictureDialog1: TSavePictureDialog;
    Panel1: TPanel;
    GraphChart: TChart;
    Panel_ProcessBar: TPanel;
    FirstPGBar: TProgressBar;
    SecondPGBar: TProgressBar;
    StatusBar1: TStatusBar;
    Mark_Memo: TMemo;
    PopupMenu_LineGraph: TPopupMenu;
    LineGraphPop_Refresh: TMenuItem;
    N7: TMenuItem;
    LineGraphPop_Markstep: TMenuItem;
    N4: TMenuItem;
    LineGraphPop_SaveBMP: TMenuItem;
    N5: TMenuItem;
    Pop_Exit: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure GraphChartGetAxisLabel(Sender: TChartAxis; Series: TChartSeries;
      ValueIndex: Integer; var LabelText: string);
    procedure GraphChartMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ExitButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure Open_ToolFormClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure Pop_ExitClick(Sender: TObject);
    procedure LineGraphPop_SaveBMPClick(Sender: TObject);
    procedure LineGraphPop_MarkstepClick(Sender: TObject);
    procedure LineGraphPop_RefreshClick(Sender: TObject);
  private
    { Private declarations }
    initData:Boolean;
    FVertAxis:integer; // ��������
    EXCaption:String; // �ⲿ�������ı���
    JinDaotimeCount:integer;
    JinDaotimeArray :Array of TContourFootageData;
    MarkerStep:Boolean;
    typeUnit,ShowScreen:integer;

    procedure MakeLineGraphChartTitle(Chart: Tchart);
    procedure SetChartAxisMaxAndMinValue(BottomAxis: TChartAxis;MaxV,MinV:double);
    procedure ChangePressDataUnit(Flag:integer);  // �������ݵ�λ
    procedure MakeWindowsSingle(Single:integer);
    procedure MakeVertAxis(Number:integer);
    procedure AddSupportMarkLabel(Postion,id,xh:integer;Value:String;Data:Double);
    procedure AddShupingLine(Chart:TChart; Asix:TChartAxis;Flag:integer;iData:Double);
    function  GetJinDaoFromJinDaotimeArray(TD,DT:String):String;
    function  MakerStepInfo(Chart:TChart; Asix:TChartAxis;phaseNumber:Integer):integer;
    procedure DispLabelMarkToMemo(Value:Boolean;Px,Py,phaseNumber,id:integer);
    function  ReturnMarkLabel(Mem1:TMemo;phaseNumber,id:integer):Boolean;
    function  GetOldStepNumber(Value:string;Var phaseNumber,stepNumber:integer):Boolean;
    function  CreateSaveBmpPath:String; //��������ͼƬ���ļ�·��
    function  LineGraphChartSaveIntoBMP(Path:string):Boolean;
    function  GetLineGraphChartBmpFileName:String;  //��ȡLineGraph�����ļ����ļ���
      // ���� ��ݹ�����
     procedure DispLineGraphPop(Px,Py:Integer);//��ʾGraphChart ���ƵĹ�����
        // ��������
     procedure ClearJinDaotimeArray;
     procedure AddJinDaotimeArray(Rec:TContourFootageData);
     procedure LoadJinDaoAndTime(MinDao,MaxDao:integer);

  public
    TongJi_DrawClass:TDrawGrap;  // �������

    procedure InitForm(DW:TDrawGrap);
    procedure RefreshChartGraph;
    { Public declarations }
  end;
function CreateTongJiXueGraph(AHandle:THandle;ACaption:string;Wid,Hi,Single:integer):THandle;stdcall;

var
  Form_TongJIGraph: TForm_TongJIGraph;

implementation

{$R *.dfm}

uses UMainDataModule, Lu_Public_BasicModual, UMakeRuleClass;

function CreateTongJiXueGraph(AHandle:THandle;ACaption:string;Wid,Hi,Single:integer):THandle;stdcall;
{

  Single 0 ����ҳ��  1 ȫ��ҳ��
}
begin
        if Assigned(Form_TongJIGraph) then  FreeAndNil(Form_TongJIGraph);
        Application.Handle :=AHandle;
        Form_TongJIGraph:=TForm_TongJIGraph.Create(Application);

         try
           with Form_TongJIGraph do begin
               EXCaption:=ACaption;
               ParentWindow:=Ahandle;
               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

               MakeWindowsSingle(Single);

               Result:=Form_TongJIGraph.Handle ;//����ֵ
          end ;
        except
           FreeAndNil(Form_TongJIGraph);
        end;


end;

//------------------------------------------------
{ TForm3 }
procedure TForm_TongJIGraph.AddJinDaotimeArray(Rec: TContourFootageData);
begin
   inc(JinDaotimeCount);
   setlength(JinDaotimeArray,JinDaotimeCount);
   JinDaotimeArray[JinDaotimeCount-1]:=Rec;
end;

procedure TForm_TongJIGraph.AddShupingLine(Chart: TChart; Asix: TChartAxis;
  Flag: integer;iData:Double);

begin
    Chart.AddSeries(TLineSeries);
    if Flag=1 then  begin   // ������
       Chart[Chart.SeriesCount-1].Color :=ClGreen;
    end else if  Flag=2  then begin      //Һѹ������
       Chart[Chart.SeriesCount-1].Color :=ClRed;
    end else if Flag=3  then begin      //����ƽ��ֵ����
       Chart[Chart.SeriesCount-1].Color :=ClGreen;
    end;
    Chart[Chart.SeriesCount-1].Pen.width:=1;
    Chart[Chart.SeriesCount-1].Pen.Style:= TPenStyle(3);
    Chart[Chart.SeriesCount-1].AddXY(TongJi_DrawClass.DataTimeAndFootAge.Graph_MinDao,iData);
    Chart[Chart.SeriesCount-1].AddXY(TongJi_DrawClass.DataTimeAndFootAge.Graph_MaxDao,iData);
    Chart[Chart.SeriesCount-1].CustomVertAxis:=Asix;
    Chart[Chart.SeriesCount-1].Legend.Visible:=False;

end;

procedure TForm_TongJIGraph.AddSupportMarkLabel(Postion, id, xh: integer;
  Value: String;Data:Double);
var
  TB:TPointSeries;
begin
   if Xh>0  then  begin
        GraphChart.CustomAxes.Add;
        GraphChart.CustomAxes.Items[GraphChart.CustomAxes.Count-1].StartPosition := Trunc((5*id+4)/4 * Postion);
        GraphChart.CustomAxes.Items[GraphChart.CustomAxes.Count-1].EndPosition :=Trunc((5*id+5)/4 * Postion);
        GraphChart.CustomAxes.Items[GraphChart.CustomAxes.Count-1].Labels:=False;
        GraphChart.CustomAxes.Items[GraphChart.CustomAxes.Count-1].Axis.width:=3;
        GraphChart.CustomAxes.Items[GraphChart.CustomAxes.Count-1].Minimum :=0;
        GraphChart.CustomAxes.Items[GraphChart.CustomAxes.Count-1].Maximum :=100;
   end;

    TB:=GraphChart.AddSeries(TPointSeries) as TPointSeries;
    with TB do begin
        Marks.Visible:=true;
       // Marks.Transparent:=true;
        Marks.Font.Size:=8;
        legend.Visible :=False;
        Pointer.Style:=psNothing;
        if xh>0 then  begin
           AddXY((TongJi_DrawClass.DataTimeAndFootAge.Graph_MinDao+TongJi_DrawClass.DataTimeAndFootAge.Graph_MaxDao)/2,1,Value);
        end else begin
           if TongJi_DrawClass.ColorValue.UnitType=1 then   begin
             AddXY((TongJi_DrawClass.DataTimeAndFootAge.Graph_MinDao+TongJi_DrawClass.DataTimeAndFootAge.Graph_MaxDao)/2,5,Value);
           end else begin
             AddXY((TongJi_DrawClass.DataTimeAndFootAge.Graph_MinDao+TongJi_DrawClass.DataTimeAndFootAge.Graph_MaxDao)/2,Data,Value);
           end;


        end;
        CustomVertAxis:= GraphChart.CustomAxes.Items[GraphChart.CustomAxes.Count-1];
    end;
end;



procedure TForm_TongJIGraph.ChangePressDataUnit(Flag: integer);
var
  i,j:integer;
  TemValue:Double;
  UnitName:string;
begin
  if Flag=1 then   begin
     UnitName :='��ǰ���ݵ�λΪѹǿ MPa' ;
     TongJi_DrawClass.ColorValue.UnitType :=1;
     TongJi_DrawClass.ColorValue.UnitValue:=1;
    // LineGraph_changeUnit.Caption :='����Ϊ����ѹǿBar';
  end else if Flag=2 then begin
     UnitName :='��ǰ���ݵ�λΪѹǿ Bar' ;
     TongJi_DrawClass.ColorValue.UnitType:=2;
     TongJi_DrawClass.ColorValue.UnitValue:=10;
    // LineGraph_changeUnit.Caption :='����Ϊ����ѹ��KN';
  end else if Flag=3 then begin
     UnitName :='��ǰ���ݵ�λΪѹ�� KN' ;
     TongJi_DrawClass.ColorValue.UnitType:=3;
     TongJi_DrawClass.ColorValue.UnitValue:= TongJi_DrawClass.ColorValue.MPaChangeKN_Xs;
    // LineGraph_changeUnit.Caption :='����Ϊ����ѹǿMPa';
  end;

   Caption:=EXCaption+'��'+ UnitName+'��';
   RefreshChartGraph;

end;

procedure TForm_TongJIGraph.ClearJinDaotimeArray;
begin
   JinDaotimeCount:=0;
 setlength(JinDaotimeArray,JinDaotimeCount);
end;

function TForm_TongJIGraph.CreateSaveBmpPath: String;
var
 BmpPath:WideString;
begin
    BmpPath:=Public_Basic.Get_MyModulePath+'SaveBmp\KYFX\'+Trim(IntTostr(TongJi_DrawClass.FGzm.Gzmbh)) + '\'  ;
    if  not DirectoryExists(BmpPath) then
         ForceDirectories(BmpPath);

    Result:=BmpPath;

end;

procedure TForm_TongJIGraph.DispLabelMarkToMemo(Value: Boolean; Px, Py,
  phaseNumber, id: integer);
var
  i:integer;
begin
    if  not Value then Mark_Memo.Visible :=False;

    if Value  then  begin
       Mark_Memo.Top :=py;
       Mark_Memo.Left :=Px;
       Mark_Memo.Enabled :=False;
       if ReturnMarkLabel(Mark_Memo,phaseNumber,id) then
          Mark_Memo.Visible :=True;
    end;

end;

procedure TForm_TongJIGraph.DispLineGraphPop(Px, Py: Integer);
begin
    LineGraphPop_SaveBmp.Enabled :=true;
    LineGraphPop_Markstep.Enabled:=true;
    PopupMenu_LineGraph.Popup(px,py);
end;

procedure TForm_TongJIGraph.ExitButtonClick(Sender: TObject);
begin
  close;
end;

procedure TForm_TongJIGraph.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
   pic_Path:string;
   pt1,pt2:TPoint;
begin
   if ShowScreen=1 then  begin
      Pic_Path  :=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\OneCoal'+'_6_1.BMP';
      Form_TongJIGraph.GraphChart.SaveToBitmapFile(Pic_Path);
   end else begin
      Pic_Path  :=Public_Basic.Get_MyModulePath+'saveBmp\KYFX\TongJi.BMP';
      Form_TongJIGraph.GraphChart.SaveToBitmapFile(Pic_Path);
   end;

   ChangePressDataUnit(typeUnit);
   {�رմ��壬������Ҫ����Close����}
   if Assigned(Form_TongJIGraph) then  FreeAndNil(Form_TongJIGraph);
end;

procedure TForm_TongJIGraph.FormCreate(Sender: TObject);
begin
    self.Panel1.Align:=alClient;
    initData:=true;
    Public_basic.InitStatusBar(StatusBar1);
end;

function TForm_TongJIGraph.GetJinDaoFromJinDaotimeArray(TD, DT: String): String;
{ DT  JinDao, Down_Footage,Upper_Footage;}
var
  tmp_TD:TdateTime;
  i,selectid:integer;
begin
    { JinDaotimeCount:integer;
     JinDaotimeArray :Array of TContourFootageData;
}
    Result:='';
    selectid:=-1;
    if trim(TD) ='' then   exit;
    tmp_TD:=StrToDateTime(TD,Public_Basic.FSetting);
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

function TForm_TongJIGraph.GetLineGraphChartBmpFileName: String;
var
  MinLab,MaxLab:integer;
begin
   Result:='';
   if TongJi_DrawClass.FGzm.Gzmbh <1 then  exit;
   MinLab:=TongJi_DrawClass.DataTimeAndFootAge.Graph_MinDao;
   MaxLab:=TongJi_DrawClass.DataTimeAndFootAge.Graph_MaxDao;
   Result:='PTS_'+'_'+Trim(IntTostr(MinLab))+ '_'+Trim(IntTostr(MaxLab)) ;


end;

function TForm_TongJIGraph.GetOldStepNumber(Value: string; var phaseNumber,
  stepNumber: integer): Boolean;
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
    phaseNumber:=public_Basic.StrToInt_lu(copy(Value,Sup_St+1,sup_ed-Sup_St-1));
    if phaseNumber< 1 then  exit;
    tmStr:=copy(Value,Sn_st+1,SN_ed-Sn_st-1);
    First_s:=copy(tmStr,1,1);
    stepNumber:=public_Basic.StrToInt_lu(copy(tmStr,3,length(tmstr)-2));
    if stepNumber< 1 then  exit;
    Result:=true;
end;


procedure TForm_TongJIGraph.GraphChartGetAxisLabel(Sender: TChartAxis;
  Series: TChartSeries; ValueIndex: Integer; var LabelText: string);
var
  LabDaoshu:double;
  Daoshu:integer;
  Text:String;
begin
        if Sender=GraphChart.BottomAxis.SubAxes.Items[0] then   begin
             Text:=StringReplace (LabelText, ',', '', [rfReplaceAll]);
             Daoshu:=Round(Public_Basic.StrToDouble_Lu(Text));
            if (Daoshu>= 0  ) and (Daoshu <TongJi_DrawClass.FilledContourDataNumber ) then  begin
                if TongJi_DrawClass.ConTourSeriesPar.Display_DownFootage =1 then  begin
                    if (TongJi_DrawClass.FilledContourData[Daoshu].Down_footage >0)then   begin
                        LabelText:=FormatFloat('0',TongJi_DrawClass.FilledContourData[Daoshu].Down_footage  ) ;
                    end else begin
                        LabelText:='';
                    end;

                end else begin
                    if TongJi_DrawClass.FilledContourData[Daoshu].DT>10000 then   begin
                       LabelText:=FormatDateTime('yyyy-mm-dd',TongJi_DrawClass.FilledContourData[Daoshu].DT  ) ;
                    end else begin
                       LabelText:='';
                    end;
                end;
            end else begin
               LabelText:='';
            end;

        end;



        if Sender=GraphChart.TopAxis then  begin
             Text:=StringReplace (LabelText, ',', '', [rfReplaceAll]);
             Daoshu:=Round(Public_Basic.StrToDouble_Lu(Text));
            if (Daoshu>= 0  ) and (Daoshu <TongJi_DrawClass.FilledContourDataNumber ) then  begin
               if TongJi_DrawClass.ConTourSeriesPar.Display_UpperFootage =1 then  begin
                   if (TongJi_DrawClass.FilledContourData[Daoshu].Upper_Footage>0 )then   begin
                       LabelText:=FormatFloat('0',TongJi_DrawClass.FilledContourData[Daoshu].Upper_Footage  ) ;
                    end else begin
                       LabelText:='';
                    end;

               end else begin
                   if TongJi_DrawClass.FilledContourData[Daoshu].DT >10000 then   begin
                      LabelText:=FormatDateTime('yyyy-mm-dd',TongJi_DrawClass.FilledContourData[Daoshu].DT  ) ;
                   end else begin
                      LabelText:='';
                   end;
               end;
           end else begin
               LabelText:='';
           end;
        end;


end;

procedure TForm_TongJIGraph.GraphChartMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
 var
  pt:Tpoint;
  s, i,SupportBh,Stepid,QD:integer;
  serie1 : TPointSeries;
  markPos : TSeriesMarkPosition;
  MarkLabel:String;
begin
  DispLabelMarkToMemo(False,0,0,0,0);

   if Button=mbRight then begin
      pt:= GraphChart.ClientToScreen(Point(0,0));
      DispLineGraphPop(pt.X+x,pt.Y +y);

   end;

   if (Button=mbLeft) and (MarkerStep) then begin
       for S := 0 to GraphChart.SeriesCount - 1 do
          begin
            if GraphChart[S] is TPointSeries then       begin
              serie1 := GraphChart[S] as TPointSeries;
                for i := 0 to serie1.Count - 1 do        begin
                    if (serie1.Marks.Positions[i] <> nil) then                begin
                          markPos := serie1.Marks.Positions[i]; // saved custom location in screen coords
                          if (x > markPos.LeftTop.X ) and ( x < markPos.LeftTop.x+markPos.Width ) and
                             (Y > markPos.LeftTop.Y ) and ( Y < markPos.LeftTop.y+markPos.Height  )  then begin
                                 MarkLabel:=Trim(serie1.Marks.Item[i].Text.Text) ;
                                 if GetOldStepNumber(MarkLabel,SupportBh,Stepid)  then  begin
                                    pt:= GraphChart.ClientToScreen(Point(0,0));
                                    DispLabelMarkToMemo(true,x,y,SupportBh-1,Stepid-1);
                                    exit;
                                 end;

                            end;
                    end;
                end;
            end;
          end;
   end;

end;

procedure TForm_TongJIGraph.InitForm(DW: TDrawGrap);
begin
   TongJi_DrawClass:=DW;
   initData:=true;
   MarkerStep:=False;
   typeUnit:= TongJi_DrawClass.ColorValue.UnitType;
   ChangePressDataUnit(3);
   FVertAxis:=TongJi_DrawClass.Auto_Judge_OldStep.PhaseNumber;
   DispLabelMarkToMemo(False,0,0,0,0);
end;

function TForm_TongJIGraph.LineGraphChartSaveIntoBMP(Path: string): Boolean;
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
          GraphChart.SaveToBitmapFile(SavePictureDialog1.FileName);
          if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWaterFromFile(SavePictureDialog1.FileName)
            else Public_Basic.AddMultTextWaterFormFile(SavePictureDialog1.FileName);
   end else begin
      tmp:=GetLineGraphChartBmpFileName;
      if tmp ='' then  exit;
      if MarkerStep then begin
         FileName:=CreateSaveBmpPath+ tmp +'_'+'1.bmp';
      end else begin
         FileName:=CreateSaveBmpPath+ tmp +'_'+'0.bmp';
      end;
      GraphChart.SaveToBitmapFile(FileName);
      if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWaterFromFile(FileName)
            else Public_Basic.AddMultTextWaterFormFile(FileName);

   end;
end;

procedure TForm_TongJIGraph.LineGraphPop_MarkstepClick(Sender: TObject);
begin
   MarkerStep:=not MarkerStep;
   if MarkerStep then  begin
      LineGraphPop_Markstep.Caption :='������ѹ��ע';
      Open_ToolForm.Caption:='���ر�ע';
   end else begin
      LineGraphPop_Markstep.Caption :='��ע��ѹ����';
      Open_ToolForm.Caption:='��ѹ��ע';
   end;

   RefreshChartGraph;
end;

procedure TForm_TongJIGraph.LineGraphPop_RefreshClick(Sender: TObject);
begin
   RefreshChartGraph;
end;

procedure TForm_TongJIGraph.LineGraphPop_SaveBMPClick(Sender: TObject);
begin
    SavePictureDialog1.Execute ;
   LineGraphChartSaveIntoBMP(SavePictureDialog1.FileName);
end;

procedure TForm_TongJIGraph.LoadJinDaoAndTime(MinDao, MaxDao: integer);
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

   Sql:=' select * from  D_'+IntToStr(TongJi_DrawClass.FGzm.Gzmbh)+'_footage ' +
        ' where  DaoShu >= ' + IntTostr(MinDao) +  ' and  DaoShu <= ' + IntToStr(MaxDao) +
        ' order by Daoshu  ' ;
   self.ClearJinDaotimeArray;
   MySqlDataSet1.CommandText :=sql;
   try
      if MySqlDataSet1.Open then
       while not MySqlDataSet1.Eof  do  begin
          TongJi_DrawClass.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);
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

procedure TForm_TongJIGraph.MakeLineGraphChartTitle(Chart: Tchart);
var
 Caption:String;
 lowTime,highTime,InterValTime:integer;
 i:integer;
begin

    Chart.Title.Font.Color :=ClBlack;
    Caption:= MainDataModule.Coal_Name+'ú��'+MainDataModule.WorkFace_Name +'�����桿ƽ��ֵ������ͳ��ѧ����';

    Chart.MarginLeft :=80;
    Chart.Title.TextAlignment:=taCenter;
    Chart.Title.Font.Name :='����';
    Chart.Title.Font.Size :=14;
    Chart.Title.Caption := Caption;

    Chart.SubTitle.Font.Color :=ClBlack;
    Chart.SubTitle.TextAlignment:=taCenter;
    Chart.SubTitle.Font.Name :='����';
    Chart.SubTitle.Font.Size :=9;

    Caption:='��ֹ����:'+FormatDateTime('yyyy-mm-dd hh:nn ',TongJi_DrawClass.DataTimeAndFootAge.StartTime)
                            +'('+FormatFloat('0.00',TongJi_DrawClass.DataTimeAndFootAge.Minfootage)+  '��)--' +
                             FormatDateTime('yyyy-mm-dd hh:nn ',TongJi_DrawClass.DataTimeAndFootAge.EndTime) +
                             '('+FormatFloat('0.00',TongJi_DrawClass.DataTimeAndFootAge.MAXfootage)+  '��)';

    Chart.SubTitle.Caption := Caption;
    Chart.SubTitle.Font.Color :=ClBlack;

    Chart.BottomAxis.Visible :=true;
    Chart.BottomAxis.DateTimeFormat:='YYYY-MM-DD HH:NN:SS' ;
    Chart.TopAxis.Visible :=true;
    Chart.TopAxis.DateTimeFormat:='YYYY-MM-DD HH:NN:SS' ;
    Chart.BottomAxis.SubAxes.Items[0].Visible :=true;
    Chart.BottomAxis.SubAxes.Items[0].DateTimeFormat:='YYYY-MM-DD HH:NN:SS' ;
    //��������������ʾ��ʽ

     Chart.BottomAxis.Automatic :=true;
     Chart.BottomAxis.SubAxes.Items[0].Automatic :=true;
     Chart.TopAxis.Automatic:=true;
     Chart.Zoom.MouseButton:=mbLeft;
     Chart.AllowPanning:=pmNone;


    Chart.BottomAxis.Title.Caption :='�ۼƽ���';
    Chart.BottomAxis.Title.Position  :=tpStart ;

    if  TongJi_DrawClass.ConTourSeriesPar.Display_DownFootage=1 then  begin
      Chart.BottomAxis.SubAxes.Items[0].Title.Caption:='�ۼƽ���';
    end else begin
      Chart.BottomAxis.SubAxes.Items[0].Title.Caption:='����ʱ��';
    end;

    Chart.BottomAxis.SubAxes.Items[0].Title.Position:=tpEnd;


    Chart.TopAxis.Visible :=true;
    if TongJi_DrawClass.ConTourSeriesPar.Display_UpperFootage=1 then  begin
      Chart.TopAxis.Title.Caption:='�ۼƽ���';
    end else begin
      Chart.TopAxis.Title.Caption:='����ʱ��';
    end;

    if TongJi_DrawClass.ColorValue.UnitType=1 then begin
        Chart.LeftAxis.Title.Caption :='����ѹǿMPa' ;
    end  else  if TongJi_DrawClass.ColorValue.UnitType =2 then begin
        Chart.LeftAxis.Title.Caption :='����ѹǿBar';
    end  else  if TongJi_DrawClass.ColorValue.UnitType =3 then begin
        Chart.LeftAxis.Title.Caption :='��������KN';
    end;

    Chart.LeftAxis.Title.Position  :=tpCenter ;
    // �� ����������
    Chart.Legend.Visible:=False;
end;

function TForm_TongJIGraph.MakerStepInfo(Chart: TChart;
  Asix: TChartAxis;phaseNumber:Integer): integer;
var
   i,id:integer;
   LabMark:String;
begin

    with GraphChart.AddSeries(TPointSeries) as TPointSeries do begin
        Marks.Visible:=true;
        Marks.Font.Size:=8;
        Marks.Color :=ClYellow;
        legend.Visible :=False;
        Pointer.Style:=psArrow;
        Pointer.Size:=15;
        CustomVertAxis:= Asix;
        for I := 0 to TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array_Count-1 do   begin
            LabMark:='��['+IntTostr(phaseNumber+1)+']�����(Q_'+IntTostr(i+1)+')��';
            id:=AddXY(TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[i].Get_MaxValueid,
                  TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[i].Get_Max_Data*
                  TongJi_DrawClass.ColorValue.MPaChangeKN_Xs,LabMark) ;
            Marks.Item[id].Text.Text:=LabMark;
            TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[i].SetAGVData(
              TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[phaseNumber].AGv_AGV_Data,
              TongJi_DrawClass.Auto_Judge_OldStep.AGV_AGV_Whole_Data     );
        end;


    end;
end;

procedure TForm_TongJIGraph.MakeVertAxis(Number: integer);
var
  i,j,t,Lin:integer;
  Postio:double;
  iColor:Array [0..5] of TColor;
  iLineType:Array [0..5 ] of integer;
  LabelMark:String;
  tmpLines:TLineSeries;
  stU,St1,edU,ed1:integer;
begin
    while GraphChart.SeriesCount>0 do GraphChart[0].Free;
    while GraphChart.CustomAxes.Count>0  do
          GraphChart.CustomAxes.Items[0].Free ;

    //
   iColor[0]:=ClBlack;
   iColor[1]:=ClBlue;
   iColor[2]:=clTeal;
   iColor[3]:=clPurple;
   iColor[4]:=clAqua;
   iColor[5]:=clLime;

   //
   iLineType[0]:=0;   iLineType[1]:=3;  iLineType[2]:=4;
   iLineType[3]:=1;   iLineType[4]:=2;  iLineType[5]:=4;

    //
    Postio:=100 / (Number+(Number)/4);
    GraphChart.CustomAxes.Clear ;

    for i := Number-1 downto 0 do begin
        TongJi_DrawClass.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);
        GraphChart.CustomAxes.Add;
        GraphChart.CustomAxes.Items[GraphChart.CustomAxes.Count-1].StartPosition := Trunc((5*i)/4 * Postio);
        GraphChart.CustomAxes.Items[GraphChart.CustomAxes.Count-1].EndPosition :=Trunc((5*i+4)/4 * Postio);
        GraphChart.CustomAxes.Items[GraphChart.CustomAxes.Count-1].Axis.Color:=iColor[5-i] ;
        GraphChart.CustomAxes.Items[GraphChart.CustomAxes.Count-1].LabelsFont.Color:=iColor[0]  ;
        GraphChart.CustomAxes.Items[GraphChart.CustomAxes.Count-1].Axis.width:=3;
        GraphChart.CustomAxes.Items[GraphChart.CustomAxes.Count-1].Title.Caption:=
                                 GraphChart.LeftAxis.Title.Caption;
        GraphChart.CustomAxes.Items[GraphChart.CustomAxes.Count-1].Title.Position  :=tpCenter ;

        t:=Number-i-1;
        LabelMark:='�ڡ�'+public_Basic.GetChineseNumber(t+1) +'������(֧�ܱ��:'+IntToStr(TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].StartsupBh) +
                       '-' +IntToStr(TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].EndSupBh) + '��), ��ɫ��ʵ�ߡ������ֵ�ߣ� ��ɫ�����ߡ���ѹ������' +
                        FormatFloat('0,0',TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].ComeStepLine*
                        TongJi_DrawClass.ColorValue.MPaChangeKN_Xs ) + 'KN' + '; ��ɫ�����ߡ� �Ż�������';
       for Lin := 0 to 1 do  begin
            tmpLines:= GraphChart.AddSeries(TLineSeries) as TLineSeries;
            with tmpLines do   begin
               CustomVertAxis:=GraphChart.CustomAxes.Items[GraphChart.CustomAxes.Count-1];
               pen.Style:= TPenStyle(iLineType[Lin]);
               ParentChart:= GraphChart;
               Title :='��['+public_Basic.GetChineseNumber(t+1)+']��';
               if Lin=0 then   begin // ƽ         ��ֵ
                    Color:=clBlack;
                    Pen.Width :=2;
                   for j:= 0 to TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].PhaseAGV_Count-1 do
                      tmpLines.AddXY(TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].PhaseAGV_EvenDao[j].JinDao,
                                  TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].PhaseAGV_EvenDao[j].AGVData *
                                  TongJi_DrawClass.ColorValue.MPaChangeKN_Xs) ;
               end else begin
                   Color:=clRed;
                   Pen.Width :=3;
                   for j := 0 to TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].Step_Array_Count -1 do  begin
                      st1:= TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].Step_Array[j].Get_Startid;
                      ed1:=  TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].Step_Array[j].Get_Endid;
                      stU:= TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].Step_Array[j].Get_StartULid;
                      edU:=  TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].Step_Array[j].Get_EndULid;
                      if (st1 <0)  or  (ed1 <0) or  (stU <0) or (edU <0)  then  continue;

                      if stU <= st1 then  begin
                         tmpLines.AddXY(TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].PhaseAGV_EvenDao[st1].JinDao,
                                  TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].Step_Array[j].Get_UpperLineData *
                                  TongJi_DrawClass.ColorValue.MPaChangeKN_Xs) ;
                         tmpLines.AddXY(TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].PhaseAGV_EvenDao[stU].JinDao,
                                  TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].Step_Array[j].Get_UpperLineData  *
                                  TongJi_DrawClass.ColorValue.MPaChangeKN_Xs) ;

                         tmpLines.AddXY(TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].PhaseAGV_EvenDao[edU].JinDao,
                                  TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].Step_Array[j].Get_UpperLineData  *
                                  TongJi_DrawClass.ColorValue.MPaChangeKN_Xs) ;
                         tmpLines.AddXY(TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].PhaseAGV_EvenDao[edU].JinDao,
                                  TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].Step_Array[j].Get_DownLineData  *
                                  TongJi_DrawClass.ColorValue.MPaChangeKN_Xs) ;
                         tmpLines.AddXY(TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].PhaseAGV_EvenDao[ed1].JinDao,
                                  TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].Step_Array[j].Get_DownLineData  *
                                  TongJi_DrawClass.ColorValue.MPaChangeKN_Xs) ;
                      end else begin
                         tmpLines.AddXY(TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].PhaseAGV_EvenDao[st1].JinDao,
                                  TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].Step_Array[j].Get_DownLineData *
                                  TongJi_DrawClass.ColorValue.MPaChangeKN_Xs) ;
                         tmpLines.AddXY(TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].PhaseAGV_EvenDao[stU].JinDao,
                                  TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].Step_Array[j].Get_DownLineData  *
                                  TongJi_DrawClass.ColorValue.MPaChangeKN_Xs) ;
                         tmpLines.AddXY(TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].PhaseAGV_EvenDao[stU].JinDao,
                                  TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].Step_Array[j].Get_UpperLineData  *
                                  TongJi_DrawClass.ColorValue.MPaChangeKN_Xs) ;

                         tmpLines.AddXY(TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].PhaseAGV_EvenDao[edU].JinDao,
                                  TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].Step_Array[j].Get_UpperLineData  *
                                  TongJi_DrawClass.ColorValue.MPaChangeKN_Xs) ;
                         tmpLines.AddXY(TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].PhaseAGV_EvenDao[edU].JinDao,
                                  TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].Step_Array[j].Get_DownLineData  *
                                  TongJi_DrawClass.ColorValue.MPaChangeKN_Xs) ;
                         tmpLines.AddXY(TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].PhaseAGV_EvenDao[ed1].JinDao,
                                  TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].Step_Array[j].Get_DownLineData  *
                                  TongJi_DrawClass.ColorValue.MPaChangeKN_Xs) ;

                      end;

                      
                   end;

               end;

            end;
       end;

       // ��ע ��ѹ���
       if (TongJi_DrawClass.CloudClass.RockPressAnslysis) and (MarkerStep)  then   begin
          MakerStepInfo(GraphChart,
                        GraphChart.CustomAxes.Items[GraphChart.CustomAxes.Count-1],
                        t );
       end else if MarkerStep then begin
           MarkerStep:=False;
       end;


        TongJi_DrawClass.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);
        // ƽ��ֵ�ж���
        AddShupingLine(GraphChart,GraphChart.CustomAxes.Items[GraphChart.CustomAxes.Count-1],3,
              TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].ComeStepLine *
              TongJi_DrawClass.ColorValue.MPaChangeKN_Xs );

       if length(LabelMark)>1 then begin
            LabelMark:=copy(LabelMark,0,length(LabelMark));
             //���ӱ�ע
            AddSupportMarkLabel(trunc(Postio),i,1,LabelMark,
                          TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[t].ComeStepLine*
                          TongJi_DrawClass.ColorValue.MPaChangeKN_Xs);
       end;

    end;

      GraphChart.Axes.Bottom.LabelStyle:=talValue;
      GraphChart.Axes.Top.LabelStyle:= talValue;
      GraphChart.Axes.Bottom.SubAxes.Items[0].LabelStyle:= talValue;

end;

procedure TForm_TongJIGraph.MakeWindowsSingle(Single: integer);
begin
     if Single=0 then  begin
        WindowState:= wsMaximized;
        ShowScreen:=0;
     end else if Single=1 then begin
        WindowState:= wsNormal;
        ShowScreen:=1;
     end;

     show;
end;

procedure TForm_TongJIGraph.Open_ToolFormClick(Sender: TObject);
begin
    LineGraphPop_Markstep.Click;
end;

procedure TForm_TongJIGraph.Pop_ExitClick(Sender: TObject);
begin
    Close;
end;

procedure TForm_TongJIGraph.RefreshChartGraph;
begin
    if not initData then  exit;
    LoadJinDaoAndTime(TongJi_DrawClass.DataTimeAndFootAge.Graph_MinDao,
                      TongJi_DrawClass.DataTimeAndFootAge.Graph_MaxDao);
    MakeLineGraphChartTitle(GraphChart);
    MakeVertAxis(FVertAxis);
    LineGraphChartSaveIntoBMP('');
end;

function TForm_TongJIGraph.ReturnMarkLabel(Mem1: TMemo; phaseNumber,
  id: integer): Boolean;
var
  i:integer;
  tmpStep:TPhaseRecord;
  Disp:Boolean;
  UN:String;
begin
    Result:=False;
    Disp:=False;
    Mem1.Clear ;
    if TongJi_DrawClass.ColorValue.UnitType=1 then begin
        UN:='MPa' ;
    end  else   if TongJi_DrawClass.ColorValue.UnitType=2 then begin
        UN:='Bar' ;
    end else begin
        UN:='KN';
    end;
    if (phaseNumber<TongJi_DrawClass.Auto_Judge_OldStep.PhaseNumber)  then
       if  (id < TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array_Count ) then begin
          tmpStep:=TongJi_DrawClass.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[id];
          Disp:=True;
       end;


    if Disp then begin
       tmpStep.Return(Mem1) ;
    end;
    Result:=true;

end;

procedure TForm_TongJIGraph.SaveButtonClick(Sender: TObject);
begin
    RefreshChartGraph;
end;

procedure TForm_TongJIGraph.SetChartAxisMaxAndMinValue(BottomAxis: TChartAxis; MaxV,
  MinV: double);
begin
  BottomAxis.Automatic :=False;
  BottomAxis.Minimum :=0;
  if MaxV <10 then    BottomAxis.Maximum:=10
         else   BottomAxis.Maximum := MaxV;
  if MinV< MaxV then  begin
     BottomAxis.Minimum :=MinV;
  end;
end;

procedure TForm_TongJIGraph.ToolButton1Click(Sender: TObject);
begin
   SavePictureDialog1.Execute ;
   LineGraphChartSaveIntoBMP(SavePictureDialog1.FileName);
end;

end.