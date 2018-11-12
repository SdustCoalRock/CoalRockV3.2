unit UForm_Brand_Bar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids,
  Vcl.StdCtrls, System.ImageList, Vcl.ImgList, Vcl.Menus,
  uDrawGraphClass , Lu_Public_BasicModual, VclTee.TeeGDIPlus, VCLTee.TeEngine,
  Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart ,VCLTee.TeeSubChart, VCLTee.Series,
  UMainDataModule,UMakeRuleClass, Vcl.ExtDlgs , VclTee.CurvFitt
  ;

type
  TForm_Band_Bar = class(TForm)
    ToolBar2: TToolBar;
    SaveButton: TToolButton;
    Open_ToolForm: TToolButton;
    ToolButton1: TToolButton;
    ExitButton: TToolButton;
    ImageList1: TImageList;
    StatusBar1: TStatusBar;
    Panel_ProcessBar: TPanel;
    FirstPGBar: TProgressBar;
    SecondPGBar: TProgressBar;
    Main_panel: TPanel;
    Chart1: TChart;
    Chart2: TChart;
    Chart3: TChart;
    Chart4: TChart;
    Chart5: TChart;
    Chart6: TChart;
    Chart7: TChart;
    Chart8: TChart;
    Chart9: TChart;
    Chart10: TChart;
    Chart11: TChart;
    Chart12: TChart;
    Chart13: TChart;
    SavePictureDialog1: TSavePictureDialog;
    Pop_BarChart: TPopupMenu;
    Pop_refresh: TMenuItem;
    N2: TMenuItem;
    Pop_Edit: TMenuItem;
    N1: TMenuItem;
    Pop_SaveOneBMP: TMenuItem;
    N3: TMenuItem;
    Pop_Savechart: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Pop_BatSave: TMenuItem;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Pop_CloseClick(Sender: TObject);
    procedure ResultPop_SaveExcelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Open_ToolFormClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure Pop_refreshClick(Sender: TObject);
    procedure Pop_EditClick(Sender: TObject);
    procedure Pop_SaveOneBMPClick(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure Pop_SavechartClick(Sender: TObject);
    procedure Pop_BatSaveClick(Sender: TObject);
    procedure Chart13AfterDraw(Sender: TObject);
  private
    { Private declarations }
    FUsedStep:TOldSteps;
    FUseDrawClass:TDrawGrap;
    Kyfx_StringMeregExcel:Rec_StringToExcel_Array;
    MySqlDataSet1:TMyDataSet;
    Use_DataFrequency:TDataFrequency;
    ColorGroup:Array [0..5 ] of TColor;
    SelectChart:Tchart;
    FChartRefreshFinlly:Boolean;// 记录Chart是否否新完成
    ShowScreen:integer;


    procedure InitKyfxResultStringGrid(GString:TStringGrid);// 初始化矿压显示结果表格
    procedure InsertMeregCellToArray(Col1,Row1,Col2,Row2:integer;var Arry:Rec_StringToExcel_Array);
    procedure DispResultPop(Px,Py:integer;TP:String);// 显示Result 控制的工具栏
    procedure MakeWindowsSingle(Single:integer); // 控制页面显示方式
   
     // 控制矿压分析结果
    function SaveResultIntoFile(Memo1:TMemo;FileName:String):Boolean;
    //
    procedure SetUseStep(Value:TOldSteps);
    function  GetUseStep:TOldSteps;
    function GetDrawClass: TDrawGrap;
    procedure setDRawClass(Value:TDrawGrap);
    function  FillBarSeries(phaseNumber:integer):Boolean;
    function SelectDataFrequFromDataBase(Support:integer;Str_time,En_Time:TDateTime):Boolean;
    procedure AddSeriesData(Chart:TChart;Sup_ST,Sup_ed:Integer);
    procedure sample3;
    procedure SetchartPoistion(Rect1:TRect;col,Row:integer);
    function  ReturnChart(id:integer):TChart;
    procedure ChartClick(Sender: TObject);
    procedure DispPopEditArea(Chart:Tchart;Px,Py:Integer);  // 控制编辑菜单的显示
    procedure chartMouseDown(Sender: TObject; Button: TMouseButton;
              Shift: TShiftState; X, Y: Integer);
    function GetChartFefresh: Boolean;
    procedure setChartRefresh(const Value: Boolean);

    function SelectXhPoistion(id:integer;var Row,Col:integer):integer;

  public
    { Public declarations }
      property UseOldStep:TOldSteps  read GetUseStep write SetUseStep;
      property DrawClass:TDrawGrap  read GetDrawClass write setDRawClass;

      procedure InitForm(iDrawG:TDrawGrap);
      procedure RefreshBarSeries(PhaseNumber:integer);
      procedure SetOpenFormVar( SupportList:String;CycleEff,OpenTool:Boolean);
      procedure SaveMbmpToFile(fileName:String);
      function CreateSaveBmpPath:String;
      function GetBarChartBmpFileName(Value:integer):String;
      function AutoSaveOnesupportOneBMP(phaseNumber:Integer):string;
      //向外传送相关数据


      property ChartRefreshFinlly:Boolean read GetChartFefresh write setChartRefresh;
  end;

function CreateBand_Bar(AHandle:THandle;ACaption:string;Wid,Hi,Single:integer):THandle;stdcall;

var
  Form_Band_Bar: TForm_Band_Bar;

implementation

{$R *.dfm}

uses RockPresstool;


function CreateBand_Bar(AHandle:THandle;ACaption:string;Wid,Hi,Single:integer):THandle;stdcall;
{

  Single 0 正常页面  1 全屏页面
}
begin
        if Assigned(Form_Band_Bar) then  FreeAndNil(Form_Band_Bar);
        Application.Handle :=AHandle;
        Form_Band_Bar:=TForm_Band_Bar.Create(Application);

         try
           with Form_Band_Bar do begin
               Caption:=ACaption;

               ParentWindow:=Ahandle;


               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

               MakeWindowsSingle(Single);
               Result:=Form_Band_Bar.Handle ;//函数值
          end ;
        except
           FreeAndNil(Form_Band_Bar);
        end;

end;


//=============================================
{ TForm_StepResult }

procedure TForm_Band_Bar.AddSeriesData(Chart: TChart; Sup_ST,Sup_ed: Integer);
{
  Sup_ST  = -1  全部支架数据
  Sup_ST >0   Sup_ed  =-1  具体某个支架的数据
  Sup_ST >0   Sup_ed  > 0 具体支架范围 的数据
}
var
  i:integer;
  tmpBar: TBarSeries;
  xTrend:TTrendFunction;
  m, b: Double;
 begin
     DrawClass.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);

     Use_DataFrequency.FillDataFromDataBase(DrawClass.FGzm.Gzmbh,
                                            Sup_ST,Sup_ed,
                                            DrawClass.DataTimeAndFootAge.StartTime,
                                            DrawClass.DataTimeAndFootAge.EndTime
                                           );
     Chart.ClearChart ;
     Chart.Legend.Visible:=False;
      if DrawClass.BarMarks.Disp_0 =0 then  begin    //不显示无效数据
          Use_DataFrequency.TotalCount:=Round( Use_DataFrequency.TotalCount *
                                                (1- Use_DataFrequency.MyChild[0].Percent /100 ));
      end;

     if (Sup_ST >0 ) and (Sup_ed <0 ) then   begin
         Chart.Title.Caption  :=DrawClass.FGzm.S_Name+'第【'+IntToStr(Sup_ST)+'】号支架压力频谱直方图';
         Chart.Title.Font.Size :=10;
         Chart.Title.Font.Color :=Clblack;
         chart.SubTitle.Font.Size:=8;
         Chart.SubTitle.Font.Color :=Clblack;
         chart.SubTitle.Caption :='数据总点数【'+InttoStr(Use_DataFrequency.TotalCount)+'】个'
     end else if (Sup_ST < 0 ) then  begin
         Chart.Title.Caption :='【'+DrawClass.FGzm.S_Name+ '】全部支架压力频谱直方图';
         Chart.Title.Font.Size :=14;
         Chart.Title.Font.Color :=ClBlue;
         chart.SubTitle.Font.Size:=10;
         Chart.SubTitle.Font.Color :=Clblack;
         chart.SubTitle.Caption :='统计数据位于第【'+InttoStr(DrawClass.DataTimeAndFootAge.Graph_MinDao)+'】-【'+
                InttoStr(DrawClass.DataTimeAndFootAge.Graph_MaxDao)+'】刀之间，数据总点数【'+
                InttoStr(Use_DataFrequency.TotalCount)+'】个' ;

     end else if (Sup_ST > 0 )  and (Sup_ed >0 ) then begin
         Chart.Title.Caption :='【'+DrawClass.FGzm.S_Name+ '】第【'+IntTostr(Sup_ST)+'】到【'+
                                IntTostr(Sup_ed)+'】支架压力频谱直方图';
         Chart.Title.Font.Size :=14;
         Chart.Title.Font.Color :=ClBlue;
         chart.SubTitle.Font.Size:=10;
         Chart.SubTitle.Font.Color :=Clblack;
         chart.SubTitle.Caption :='统计数据位于第【'+InttoStr(DrawClass.DataTimeAndFootAge.Graph_MinDao)+'】-【'+
                InttoStr(DrawClass.DataTimeAndFootAge.Graph_MaxDao)+'】刀之间，数据总点数【'+
                InttoStr(Use_DataFrequency.TotalCount)+'】个' ;
     end;

     Chart.Title.TextAlignment:=taCenter;
     Chart.Title.Font.Name :='黑体';

     Chart.SubTitle.TextAlignment:=taCenter;
     Chart.SubTitle.Font.Name :='黑体';
     Chart.BottomAxis.Title.Caption :='MPa';
     Chart.BottomAxis.Title.Position :=tpEnd;
     Chart.LeftAxis.Title.Position :=tpEnd;
     Chart.View3D:=False;
     Chart.Zoom.Allow :=FALSE;
     chart.AllowPanning := pmNone;
     tmpBar:= Chart.AddSeries(TBarSeries) as TBarSeries;
     with tmpBar do  begin

          for I := 1 to High(Use_DataFrequency.MyChild) do
            Use_DataFrequency.MyChild[i].Percent:=  Use_DataFrequency.MyChild[i].Count/ Use_DataFrequency.TotalCount *100;

         //
         for I := 0 to high(Use_DataFrequency.MyChild)  do begin
             DrawClass.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);
             if  (DrawClass.BarMarks.Disp_0 =0) and (i=0)  then    // 不显示无效数字
                     continue;
             if DrawClass.BarMarks.Disp_B_D =0 then begin  //显示比例
                    AddXY((Use_DataFrequency.MyChild[i].TopLine + Use_DataFrequency.MyChild[i].BottomLine)/2,
                    Use_DataFrequency.MyChild[i].Percent);
                     //
                    Chart.LeftAxis.Title.Caption :='%';
             end else begin  //显示 点数
                 AddXY((Use_DataFrequency.MyChild[i].TopLine + Use_DataFrequency.MyChild[i].BottomLine)/2,
                        Use_DataFrequency.MyChild[i].Count);
                 Chart.LeftAxis.Title.Caption :='个';
             end;


         end;

        if DrawClass.BarMarks.Disp_Mark =0  then     Marks.Visible:=False
                else    Marks.Visible:=true;

        ColorEachPoint:=True;
     end;
      // 增加趋势线
     xTrend:=TTrendFunction.Create(Self);
     xTrend.CalculateTrend(m,b,tmpBar,0,tmpBar.Count);
     xTrend.Period:=3;
     with  Chart.AddSeries(TLineSeries) as TLineSeries do  begin
           Smoothed :=true;
           SetFunction(xTrend);
           DataSource:=tmpBar;
           pen.Width :=2;
           Pen.Color :=clRed;
     end;

     Chart.Refresh ;
     //FreeAndNil(xTrend);
end;


function TForm_Band_Bar.AutoSaveOnesupportOneBMP(phaseNumber:Integer):string;
var
  i:integer;
  DPath,FName:String;
begin
   DPath:=CreateSaveBmpPath  + GetBarChartBmpFileName(phaseNumber) ;
   for I := 1 to 13 do  begin
       FName:=DPath+'_'+IntToStr(i)+'.BMP';
       ReturnChart(i).SaveToBitmapFile(FName);
       if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWaterFromFile(FName)
            else Public_Basic.AddMultTextWaterFormFile(FName);
   end;
   // 保存为 整体文件
   FName:=DPath+'_000.BMP';
   SaveMbmpToFile(DPath+'_000.BMP' );
   if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWaterFromFile(FName)
            else Public_Basic.AddMultTextWaterFormFile(FName);
   Result:=FName;
end;

procedure TForm_Band_Bar.Chart13AfterDraw(Sender: TObject);
begin
    FChartRefreshFinlly:=true;
end;

procedure TForm_Band_Bar.ChartClick(Sender: TObject);
begin
    case ( (sender as TChart).Tag ) of
        1: // chart1

    end;
end;

procedure TForm_Band_Bar.chartMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pt:Tpoint;
begin
   if Button=mbRight then begin
      SelectChart:= ReturnChart((sender as TChart).Tag);
      pt:= SelectChart.ClientToScreen(Point(0,0));
      DispPopEditArea(SelectChart,pt.X+x,pt.Y +y) ;
   end;


end;

function TForm_Band_Bar.CreateSaveBmpPath: String;
var
 BmpPath:WideString;
begin
    BmpPath:=Public_Basic.Get_MyModulePath+'SaveBmp\KYFX\'+ Trim(IntTostr(DrawClass.FGzm.Gzmbh)) + '\'  ;;
    if  not DirectoryExists(BmpPath) then
         ForceDirectories(BmpPath);

    Result:=BmpPath;
end;

procedure TForm_Band_Bar.DispPopEditArea(Chart:Tchart;Px, Py: Integer);
begin
    Pop_BarChart.Popup(px,py);
end;

procedure TForm_Band_Bar.DispResultPop(Px, Py: integer; TP: String);
begin

end;

function TForm_Band_Bar.FillBarSeries(phaseNumber:integer): Boolean;
var
  s1,s2:Str_DT_array;
  C1,C2:integer;
  supportbh:integer;
  i:integer;

begin
   if Length(DrawClass.GraphClass.SupportList )>0 then  begin
       S1:=public_Basic.split(DrawClass.GraphClass.SupportList,';',C1);
       for i := 0 to High(S1) do  begin
           S2:=public_Basic.split(S1[i],',',C2);
           DrawClass.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
           if C2>=1 then  begin
              supportbh:=Public_Basic.StrToInt_lu(S2[1]);
              AddSeriesData(ReturnChart(i+1),supportbh,-1);
           end;

       end;
       // 统计整个工作面的 压力频谱
        ChartRefreshFinlly:=False;
        if phaseNumber <0  then    begin  //全部工作面数据
            AddSeriesData(ReturnChart(13),-1,-1);
        end else begin
            AddSeriesData(ReturnChart(13),DrawClass.Auto_Judge_OldStep.PhaseSteps[phaseNumber].StartsupBh,
                      DrawClass.Auto_Judge_OldStep.PhaseSteps[phaseNumber].EndSupBh);
        end;


   end;


end;

procedure TForm_Band_Bar.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
   pic_Path:string;
   pt1,pt2:TPoint;
begin
   if ShowScreen=1 then  begin
      Pic_Path  :=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\OneCoal'+'_7_1.BMP';
      Form_Band_Bar.SaveMbmpToFile(Pic_Path);
   end;
    {关闭窗体，还得需要发出Close命令}
   if Assigned(Form_Band_Bar) then  FreeAndNil(Form_Band_Bar);
end;

procedure TForm_Band_Bar.FormCreate(Sender: TObject);
begin
  MySqlDataSet1:=TMyDataSet.Create(nil);
  MySqlDataSet1.MySqlConnection :=MainDataModule.ExConn;
  Use_DataFrequency:=TDataFrequency.Create ;

end;

procedure TForm_Band_Bar.FormDestroy(Sender: TObject);
begin

     FreeAndNil(MySqlDataSet1);
     FreeAndNil(Use_DataFrequency);

end;

procedure TForm_Band_Bar.FormResize(Sender: TObject);
begin
   SetchartPoistion(main_Panel.BoundsRect,4,4) ;
end;

function TForm_Band_Bar.GetBarChartBmpFileName(Value:integer): String;
var
  MinLab,MaxLab:integer;
begin
   Result:='';
   if DrawClass.FGzm.Gzmbh <1 then  exit;
   if Value>0 then  begin
       Result:='Bar_'+IntTostr(Value);
   end else begin
       Result:='Bar' ;
   end;

end;

function TForm_Band_Bar.GetChartFefresh: Boolean;
begin
   Result:=FChartRefreshFinlly;
end;

function TForm_Band_Bar.GetDrawClass: TDrawGrap;
begin
   Result:=FUseDrawClass;
end;

function TForm_Band_Bar.GetUseStep: TOldSteps;
begin
    Result:=FUsedStep;
end;

procedure TForm_Band_Bar.InitKyfxResultStringGrid(GString:TStringGrid);
begin

end;

procedure TForm_Band_Bar.InsertMeregCellToArray(Col1, Row1, Col2,
  Row2: integer; var Arry: Rec_StringToExcel_Array);
var
  Count:integer;
begin
    Count:=length(Arry);
    inC(Count);
    setlength(Arry,Count);
    Arry[Count-1].FromCol :=Col1;
    Arry[Count-1].FromRow :=Row1;
    Arry[Count-1].ToCol :=Col2;
    Arry[Count-1].ToRow :=Row2;
end;

procedure TForm_Band_Bar.MakeWindowsSingle(Single: integer);
begin
     if Single=0 then  begin
        WindowState:= wsMaximized;
        ShowScreen:=0;
     end else  begin
        WindowState:= wsNormal;
        ShowScreen:=Single;
     end;

     show;
end;

procedure TForm_Band_Bar.N5Click(Sender: TObject);
begin
   Close;
end;

procedure TForm_Band_Bar.Open_ToolFormClick(Sender: TObject);
begin
     CreateRockPressTool(Application.Handle,'直方图绘制属性设置界面',
                       Width ,Height,3);
end;

procedure TForm_Band_Bar.Pop_BatSaveClick(Sender: TObject);
var
  t_s:string;
begin
   AutoSaveOnesupportOneBMP(-1);

   t_s:='数据保存在【'+CreateSaveBmpPath+'】下面，'+#13#10+'以Bar开头的图片文件，请到该处查看';
   Application.MessageBox(Pwidechar(t_s),'提示',MB_ICONINformation) ;


end;

procedure TForm_Band_Bar.Pop_CloseClick(Sender: TObject);
begin
   Close;
end;



procedure TForm_Band_Bar.Pop_EditClick(Sender: TObject);
begin
     CreateRockPressTool(Application.Handle,'直方图绘制属性设置界面',
                       Width ,Height,3);
end;

procedure TForm_Band_Bar.Pop_refreshClick(Sender: TObject);
begin
   RefreshBarSeries(-1);
end;

procedure TForm_Band_Bar.Pop_SavechartClick(Sender: TObject);
begin
   self.SavePictureDialog1.Execute()  ;
   selectChart.SaveToBitmapFile(SavePictureDialog1.FileName);

end;

procedure TForm_Band_Bar.Pop_SaveOneBMPClick(Sender: TObject);
begin
    ToolButton1.Click;
end;

procedure TForm_Band_Bar.InitForm(iDrawG: TDrawGrap);
var
  i:integer;
begin
    DrawClass:=iDrawG;
    UseOldStep:=iDrawG.Auto_Judge_OldStep;
    Main_Panel.Align  :=alClient;
    SetchartPoistion(main_Panel.BoundsRect,4,4) ;
    for I := 1 to 13 do
       ReturnChart(i).OnMouseDown :=chartMouseDown;
end;

procedure TForm_Band_Bar.RefreshBarSeries(PhaseNumber:integer);
begin
   DrawClass.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,true,100,100);
   DrawClass.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);

   FillBarSeries(PhaseNumber);

   DrawClass.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,FALSE,0,0);
end;

procedure TForm_Band_Bar.ResultPop_SaveExcelClick(Sender: TObject);
var
  Tilte,t_s:string;
begin
    t_s:='你确定要保存为Excel吗？打开OFFice会耗费一点时间'+#13#10+'请耐心等待！';
   if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;

//   Public_Basic.StringGridToExcel_MegerCell('矿压分析结果',SG_Result,10, Kyfx_StringMeregExcel);
   //Public_Basic.StringGridtoExcel('矿压分析结果',SG_Result,10 );
end;

function TForm_Band_Bar.ReturnChart(id: integer): TChart;
begin
      if id=1  then  begin
          Result:=Chart1;
      end else if id=2  then  begin
         Result:=Chart2;
      end else if id=3  then  begin
         Result:=Chart3;
      end else if id=4  then  begin
         Result:=Chart4;
      end else if id=5  then  begin
         Result:=Chart5;
      end else if id=6 then  begin
         Result:=Chart6;
      end else if id=7  then  begin
         Result:=Chart7;
      end else if id=8  then  begin
         Result:=Chart8;
      end else if id=9  then  begin
         Result:=Chart9;
      end else if id=10  then  begin
         Result:=Chart10;
      end else if id=11  then  begin
         Result:=Chart11;
      end else if id=12  then  begin
         Result:=Chart12;
      end else if id=13  then  begin
         Result:=Chart13;
      end;

end;

procedure TForm_Band_Bar.sample3;
var
 tmpChart:TChart;
 SubChart_Main:TSubChartTool;
 SubCount:Integer;
 i:integer;
begin
   SubChart_Main:=Chart1.Tools.Add(TSubChartTool.Create(self)) as TSubChartTool;
   SubCount:=0;

       tmpChart:= TChart.Create (self);
       tmpChart.Parent:=self;
//       if I<6 then begin
//          tmpChart.Top :=Chart1.ChartRect.Top  ;
//          tmpChart.Left :=I*200;
//          tmpChart.Width :=150;
//          tmpChart.Height :=100;
//
//       end else begin
//          tmpChart.Top :=150;
//          tmpChart.Left :=(I-6)*200;
//          tmpChart.Width :=150;
//          tmpChart.Height :=100;
//       end;

        with tmpChart.AddSeries(TBarSeries) as TBarSeries do  begin
            FillSampleValues(100);
        end;

end;

procedure TForm_Band_Bar.SaveButtonClick(Sender: TObject);
begin
  RefreshBarSeries(-1);
end;

procedure TForm_Band_Bar.SaveMbmpToFile(fileName: String);
var
  Image1,FileImage,StrImage:TImage;
  w1,h1,bh:integer;
  I,stX,StY,Row,Col: Integer;
  pic_Path:string;
begin
   try
      Image1:=Timage.Create(nil);
      FileImage:=Timage.Create(nil);
      StrImage:=Timage.Create(nil);
      Image1.Width :=Main_panel.Width;
      Image1.Height :=Main_panel.Height ;
      w1:=Image1.Width div 4;
      h1:=Image1.Height div 4;
      stX:=0;StY:=0; Row:=0;Col:=0;
      if ShowScreen=2 then begin
          for I := 1 to 16 do  begin
               Bh:=SelectXhPoistion(i,Row,Col) ;
               if  Bh=13  then begin
                  pic_Path:=CreateSaveBmpPath  + GetBarChartBmpFileName(-1) +'_'+IntToStr(BH)+'.BMP';
                  FileImage.Picture.Graphic:=nil;
                  FileImage.Picture.LoadFromFile(pic_Path);
                  FileImage.Stretch:=true;
                  StrImage.Picture.Graphic :=nil;
                  StrImage.Width:=2*w1;
                  StrImage.Height:=2*h1;

                  StrImage.Canvas.StretchDraw(StrImage.ClientRect,FileImage.Picture.Graphic);
                  Image1.Canvas.Draw(StX+W1*1,StY+H1*1,StrImage.Picture.Graphic);
               end else if (Bh>0) and (BH<13) then begin
                  pic_Path:=CreateSaveBmpPath  + GetBarChartBmpFileName(-1) +'_'+IntToStr(BH)+'.BMP';
                  FileImage.Picture.Graphic:=nil;
                  FileImage.Picture.LoadFromFile(pic_Path);
                  FileImage.Stretch:=true;
                  StrImage.Picture.Graphic:=nil;
                  StrImage.Width:=w1;
                  StrImage.Height:=h1;
                  StrImage.Canvas.StretchDraw(StrImage.ClientRect,FileImage.Picture.Graphic);
                  Image1.Canvas.Draw(StX+W1*Col,StY+H1*Row,StrImage.Picture.Graphic);
               end;


          end;
      end else begin
         StretchBlt(Image1.Canvas.Handle,0,0,Main_Panel.Width ,Main_Panel.Height ,
                 GetDc( Main_Panel.Handle ) , 0,0, Main_Panel.Width ,Main_Panel.Height ,
                SRCCOPY);
      end;

      Image1.Picture.SaveToFile(FileName);
      if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWaterFromFile(FileName)
            else Public_Basic.AddMultTextWaterFormFile(FileName);
   finally
      FreeAndNil(Image1);
      FreeAndNil(FileImage);
      FreeAndNil(StrImage);
   end;
end;

function TForm_Band_Bar.SaveResultIntoFile(Memo1: TMemo;
  FileName: String): Boolean;
begin
    Memo1.Lines.SaveToFile(FileName);
end;

function TForm_Band_Bar.SelectDataFrequFromDataBase(Support: integer; Str_time,
  En_Time: TDateTime): Boolean;
var
 str_st,Str_ed:string;
 Sql:string;
 Sub_DF:TDataFrequency;
begin
   str_st:=public_Basic.ReturnDateTimeString(MainDataModule.DataType ,Str_time);
   Str_ed:=public_Basic.ReturnDateTimeString(MainDataModule.DataType ,En_Time);
   Sub_DF:= TDataFrequency.Create ;
   MySqlDataSet1.Close;
   Use_DataFrequency.InitArrayChild ;
   if Support <=0 then  begin //工作面全部支架
      Sql:=' select Memo1 from  D_'+IntToStr(DrawClass.FGzm.Gzmbh)+'_SupportMoveInfo ' +
        ' where   startTime >= ' + Str_st  +  ' and  endTime <= ' + Str_ed  +
        '  order by endtime ';
   end else  begin
      Sql:=' select Memo1 from  D_'+IntToStr(DrawClass.FGzm.Gzmbh)+'_SupportMoveInfo ' +
        ' where supportbh =' + IntTostr(Support) + ' and  startTime >= ' + Str_st  +
        ' and  endTime <= ' + Str_ed  +
        '  order by endtime ';
   end;
  try
     MySqlDataSet1.CommandText :=Sql;
     if MySqlDataSet1.Open  then  begin
       while not MySqlDataSet1.Eof  do  begin
          DrawClass.StepProcegressBar(FirstPGBar,SecondPGBar,0,10);
          Sub_DF.InitArrayChild;
          Sub_DF.SplitString(MySqlDataSet1.FieldByName('Memo1').AsString  );
          Use_DataFrequency.AddNextClassToSelf(Sub_DF);
          MySqlDataSet1.Next ;
       end;
     end;
  finally
     FreeandNil(Sub_DF);
     Result:=true;
  end;


end;

function TForm_Band_Bar.SelectXhPoistion(id: integer; var Row,
  Col: integer): integer;
var
  Bh:integer;
begin
     Row:=(id-1) div 4;
     Col:=(id-1) mod 4;
     Bh:=-1;
     if id < 1  then  exit;

     if (id<=5)  then  begin
        Bh:=id;
     end else  if id=6 then  begin
        Bh:=13;
     end else  if (id=7) or (id=10) or (id=11)   then   begin
        Bh:=-1;
     end else if (id=8) or (id=9) then begin
        Bh:=id-2;
     end else begin
        Bh:=id-4;
     end;
     Result := Bh;
end;

procedure TForm_Band_Bar.SetchartPoistion(Rect1:TRect;col, Row: integer);
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
           ReturnChart(ChartBh).Top :=RowTop ;
           ReturnChart(ChartBh).Left :=ColLeft;
           ReturnChart(ChartBh).Width :=Chlid_width*2;
           ReturnChart(ChartBh).Height :=Chlid_Heigth *2;
           //ReturnChart(ChartBh).Title.Caption :=InttoStr(ChartBh);
           continue;
       end else  if (i=7) or (i=10) or (i=11)   then   begin
          continue;
       end else if (i=8) or (i=9) then begin
          ChartBh:=i-2;
       end else begin
          ChartBh:=i-4;
       end;
       ReturnChart(ChartBh).Top :=RowTop ;
       ReturnChart(ChartBh).Left :=ColLeft;
       ReturnChart(ChartBh).Width :=Chlid_width;
       ReturnChart(ChartBh).Height :=Chlid_Heigth;
      // ReturnChart(ChartBh).Title.Caption :=InttoStr(ChartBh);

   end;

end;

procedure TForm_Band_Bar.setChartRefresh(const Value: Boolean);
begin
    FChartRefreshFinlly:=Value;
end;

procedure TForm_Band_Bar.setDRawClass(Value: TDrawGrap);
begin
   FUseDrawClass:=Value;
end;



procedure TForm_Band_Bar.SetOpenFormVar( SupportList: String;
  CycleEff,OpenTool: Boolean);
var
   i,j:integer;
begin

    DrawClass.GraphClass.Support_Select_List:= SupportList;
    DrawClass.GraphClass.Out_input_Data:=CycleEff;
    
    // 打开 页面配置界面
    if OpenTool then begin
        CreateRockPressTool(Application.Handle,'曲线图绘制属性设置界面',
                           Width ,Height,3);
        // 更改page页面的显示
        FormPressTool.MainPage.ActivePageIndex:=2;
        FormPressTool.SecondPage_2.ActivePageIndex:=0;
        FormPressTool.Tab_SupDisp.TabVisible :=False;
        FormPressTool.Tab_SupBar.TabVisible:=True;
    end;

end;

procedure TForm_Band_Bar.SetUseStep(Value: TOldSteps);
begin
   FUsedStep:=Value;
end;

procedure TForm_Band_Bar.ToolButton1Click(Sender: TObject);
begin
//    SavePictureDialog1.Execute()  ;
//    SaveMbmpToFile(SavePictureDialog1.FileName );
     AutoSaveOnesupportOneBMP(-1);
end;

end.
