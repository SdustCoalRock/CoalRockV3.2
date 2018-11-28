unit UForm_ThreeZcyl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtDlgs,
  System.ImageList, Vcl.ImgList, VclTee.TeeGDIPlus, VCLTee.TeEngine,
  VCLTee.Series, VCLTee.TeeTools, Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart,
  Vcl.Menus, VCLTee.TeeSurfa, VCLTee.TeeTriSurface,VCLTee.TeePoin3, Vcl.StdCtrls
  ;

type

  TZcylRecord= record
     SmoothData:Double;// 三维平衡后是的数据
     SmoothCount:integer;
   end;

  TsupportMoveRec=record
    gentime:TdateTime;
    Support:integer;
  end;

  TSmotherThreePoint=record
    pt:TPoint;
    DataV:Double;
  end;

  TSelectPoint=Record
    pt:TPoint;
    Select:Boolean;
  End;

  TZcylRec=record
    S0:double;
    S1:double;
    SX:double;
    K1:double;
    k2:double;
  end;

  TForm_ThreeZCyl = class(TForm)
    ImageList1: TImageList;
    SavePictureDialog1: TSavePictureDialog;
    ToolBar2: TToolBar;
    SaveButton: TToolButton;
    But_DispWl: TToolButton;
    ToolButton1: TToolButton;
    ExitButton: TToolButton;
    GraphChart: TChart;
    StatusBar1: TStatusBar;
    PopupMenu_LineGraph: TPopupMenu;
    LineGraphPop_Refresh: TMenuItem;
    N7: TMenuItem;
    LineGraphPop_SaveBMP: TMenuItem;
    N5: TMenuItem;
    Pop_Exit: TMenuItem;
    But_Turn_Right: TToolButton;
    But_Turn_Left: TToolButton;
    But_Turn_top: TToolButton;
    But_Turn_Bottom: TToolButton;
    But_Turn_Redo: TToolButton;
    ZCYL_Series: TSurfaceSeries;
    But_ChangFillColor: TToolButton;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N51: TMenuItem;
    N6: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    GZM_Series: TTowerSeries;
    GS_Series: TTowerSeries;
    MZCombox: TComboBox;
    SecondJinchi: TTrackBar;
    JinChi_Label: TLabel;
    ToolButton2: TToolButton;
    TB_TiGao: TToolButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure GraphChartMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure ExitButtonClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure Pop_ExitClick(Sender: TObject);
    procedure LineGraphPop_RefreshClick(Sender: TObject);
    procedure LineGraphPop_SaveBMPClick(Sender: TObject);
    procedure GraphChartMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure But_Turn_RightClick(Sender: TObject);
    procedure But_Turn_LeftClick(Sender: TObject);
    procedure But_Turn_topClick(Sender: TObject);
    procedure But_Turn_BottomClick(Sender: TObject);
    procedure But_Turn_RedoClick(Sender: TObject);
    procedure But_ChangFillColorClick(Sender: TObject);
    procedure But_DispWlClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N51Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure GraphChartDblClick(Sender: TObject);
    procedure GraphChartGetAxisLabel(Sender: TChartAxis; Series: TChartSeries;
      ValueIndex: Integer; var LabelText: string);
    procedure MZComboxChange(Sender: TObject);
    procedure SecondJinchiChange(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure TB_TiGaoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
     MySupportMove_count:integer;
     MySupportMove:Array of TsupportMoveRec;
     loadData:Boolean;
     MarkerStep,DispMark:Boolean;
     EXCaption:string;
     Whole_MaxValue:double;
     Pu_L0,Pu_TJ,Second_Jinchi:double;
     PU_Old_Ci:double;
     tmpIni,tmpWl:integer;
     Graph_x,Graph_Z:integer; // 图形的总尺寸
     Mid_Coal:integer;// 中间煤柱的宽度
     Work1Width,Work2Width:integer; //第一个工作面宽与第二个工作面的宽
     Ganshi_Center:TPoint;
     leftBlank,BottomBlank,TopBlank,RightBlanK:integer;
     ZCYL_ThreeDim:array of  array of TZcylRecord;// 支承压力三维数组
     Basic_Line,Val_D:integer;// 基本数据
     ShowScreen:integer;
    { Private declarations }
   
    procedure MakeLineGraphChartTitle(Chart: Tchart);
    procedure SetChartAxisMaxAndMinValue(BottomAxis: TChartAxis;MaxV,MinV:double);
    procedure AddVertAxes(Chart: Tchart);
    function Split_Get_ZCYl(Sout:String):TZcylRec;
    procedure MakeWorkFace(L0,TJ,JinChi:Double;GZM_S,GS_S: TTowerSeries);
    procedure FillGS_series(L0,Jinchi:double;GS_S: TTowerSeries);
    procedure SetArrowMark(Jinchi:double;GM_S,GS_S: TTowerSeries);
    procedure MakeWindowsSingle(Single:integer);
    // 三维差值算法
    function  Inverse_Distance_Powe(p0,p1,p2,p3,p4:TSmotherThreePoint) :TSmotherThreePoint;// 反距离插值算法
    procedure SetSelectPointIsFalse(SePoint:Array of TSelectPoint);
    function  SelectMinDisPoint(var SePoint:Array of TSelectPoint;P0:TPoint):TPoint;
//    function  selectFromFourFangxiang(var TD:TDoubleContourRecord; pt:TPoint; AGV:double;
//                min_Dao,Max_Dao,Min_Sup,Max_Sup:integer ):Boolean;
 
    procedure CreateZcyl_ThreeDim(X,Y:integer);
    procedure ClearZcyl_ThreeDim;
    procedure FillDimYData(X0,UpperOrDown,QY,gzmbh:integer;Basic,Val:double;Zcyl:TZcylRec);
    procedure FillCircleData(X0,Y0,Fx,Bh:integer;Basic,Val:Double;Zcyl:TZcylRec);
    procedure FillDimXData(Y0,UpperOrDown,GzmBh:integer;Jinchi,Basic,Val:double;Zcyl:TZcylRec);
    procedure FillDimXYData(x,y,SmoothCount,iMax:integer;Data:Double);
    procedure ClearDimSmoothCount(x1,x2,y1,y2,SC:integer);
    function  LoadZCYLThreeDimData(Bas_Ys,BS_V:integer):Boolean;
    procedure ChangeBasicData(wid_Mz:integer);
    procedure MakeFirstGzmZcyl(JinChi:double;Bas_Ys,BS_V:integer);
    procedure MakeSecondGzmZcyl(JinChi:double;Bas_Ys,BS_V:integer);
    procedure FillSeiesData(Series:TCustom3DSeries);
    function  ZCYL_Norm2(xi:integer;s1,sx,k2:double):double;
    function  ZCYL_Norm3(xi:integer;s0,s1,k2,k0:double):double;
    function  ZCYL_Norm4(xi:integer;s0,s1,k1,k0:double):double;
    procedure FillDimZeroData(xi,yi,CountLine:integer;Basic_C:Double);
    procedure FillDimSecondData(xi,yi:integer;lineValue,Basic_C:Double);


    procedure  setSeriesLevelColor(Max_V,Min_V:Double);
    Function   GetContourColor(Mia_V,Min_V:Double;xh:integer; Var Up_Value:double ):TColor;  // 获得云图颜色区分
    //-----
  
   
      // 控制 快捷工具栏
     procedure DispLineGraphPop(Px,Py:Integer);//显示GraphChart 控制的工具栏
     function SetMarkLabelVisible(Value:Boolean):Boolean;
     procedure SetFromWidthAndHeigth(flag:integer);

  public

    procedure SmoothThreeDimPointValue(min_Dao,Max_Dao,Min_Sup,Max_Sup:integer);
    procedure InitForm();
    procedure RefreshChartGraph;
    { Public declarations }
  end;

 function ShowZCYL_inn(AHandle:THandle;ACaption:string;Wid,Hi,Flag:integer):integer;stdcall;
 procedure save_ZCYL_tu_inn(AHandle:THandle);

var
  Form_ThreeZCyl: TForm_ThreeZCyl;

implementation

{$R *.dfm}

uses  Lu_Public_BasicModual,math, Main_PStope;

//------------------------------
procedure save_ZCYL_tu_inn(AHandle:THandle);
var
  FileName:string;
begin

     if Assigned(Form_ThreeZCyl) then    FreeAndNil(Form_ThreeZCyl);
     Form_ThreeZCyl:=TForm_ThreeZCyl.Create(nil);
     try
        Form_ThreeZCyl.WindowState:= wsNormal;
        Form_ThreeZCyl.ParentWindow:=Ahandle;
        FileName:=public_Basic.Get_MyModulePath +'SaveBmp\FYYD\ZCYL.BMP' ;
        Form_ThreeZCyl.GraphChart.SaveToBitmapFile(FileName);
        if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWaterFromFile(FileName)
            else Public_Basic.AddMultTextWaterFormFile(FileName);

     finally
          FreeAndNil(Form_ThreeZCyl);
     end;


end;
//-------------------
function ShowZCYL_inn(AHandle:THandle;ACaption:string;Wid,Hi,Flag:integer):integer;stdcall;
{

  Single 0 正常页面  1 全屏页面
}
begin
    if Assigned(Form_ThreeZCyl) then   FreeAndNil(Form_ThreeZCyl);
    Form_ThreeZCyl:=TForm_ThreeZCyl.Create(nil);
    try
        with Form_ThreeZCyl do begin
            Caption:=ACaption;
            ParentWindow:=Ahandle;
            if Hi >Form_ThreeZCyl.Height then
               Top :=Round((Hi-Height)/2)
            else   Top :=0;
            if Wid> Width then
                Left:=Round((Wid-Width)/2)
            else  Left:=0;

            SetFromWidthAndHeigth(Flag);
            Result:=1;//函数值
        end;
    except
        FreeAndNil(Form_ThreeZCyl);
    end;

end;
{ TUForm_MoveSupport }




procedure TForm_ThreeZCyl.But_Turn_BottomClick(Sender: TObject);
begin
  if GraphChart.View3DOptions.Orthogonal then  GraphChart.View3DOptions.Orthogonal:=False;
  if GraphChart.View3DOptions.Perspective >5 then
       GraphChart.View3DOptions.Perspective:= GraphChart.View3DOptions.Perspective-5;
end;

procedure TForm_ThreeZCyl.But_Turn_LeftClick(Sender: TObject);
begin
   if GraphChart.View3DOptions.Orthogonal then  GraphChart.View3DOptions.Orthogonal:=False;
    GraphChart.View3DOptions.Rotation :=  GraphChart.View3DOptions.Rotation+10;
end;

procedure TForm_ThreeZCyl.But_Turn_RedoClick(Sender: TObject);
begin
   GraphChart.View3DOptions.Orthogonal :=True;
end;

procedure TForm_ThreeZCyl.But_Turn_RightClick(Sender: TObject);
begin
   if GraphChart.View3DOptions.Orthogonal then  GraphChart.View3DOptions.Orthogonal:=False;
   GraphChart.View3DOptions.Rotation :=  GraphChart.View3DOptions.Rotation-10;
end;

procedure TForm_ThreeZCyl.But_Turn_topClick(Sender: TObject);
begin
    if GraphChart.View3DOptions.Orthogonal then  GraphChart.View3DOptions.Orthogonal:=False;
   if GraphChart.View3DOptions.Perspective<=85 then
       GraphChart.View3DOptions.Perspective:= GraphChart.View3DOptions.Perspective+5;
end;



procedure TForm_ThreeZCyl.ChangeBasicData(wid_Mz:integer);
begin
   Whole_MaxValue:=0;
   DispMark:=False;
   //
   tmpIni:=0; tmpWl:=0;
   MarkerStep:=False;

    Graph_x:=90;
    Graph_Z:=70;
    leftBlank:=15;
    BottomBlank:=15;
    TopBlank:=15;
    RightBlanK:=15;
    Mid_Coal:=wid_Mz;// 4 2 0
    Work1Width:= (Graph_Z- BottomBlank-TopBlank- Mid_Coal) div 2;
    Work2Width:= Work1Width;

   // 把支承压力的数值穿过来
    PU_Old_Ci:=public_Basic.StrToDouble_Lu(ExPstopeClass.Get_Old_roof('4.0'));
    Pu_L0:=ExPstopeClass.Ex_Gzm.S_L_qx;
    Pu_TJ:=ExPstopeClass.Ex_Gzm.S_Sx_zx ;
    if Pu_L0< 10 then  Pu_L0:=300;
    if Pu_TJ<10  then  Pu_TJ:=600;
    if Pu_TJ>600 then  Pu_TJ:=600;
    Second_Jinchi:=250;

    Ganshi_Center.X:=Graph_x-RightBlanK-round(Second_Jinchi/2/10);
    Ganshi_Center.y:=BottomBlank+Work2Width div 2;
end;

procedure TForm_ThreeZCyl.ClearDimSmoothCount(x1, x2, y1, y2, SC: integer);
var
  i,j:integer;
begin
    if x1>= Graph_x *5 then  x1:= Graph_x*5-1;
    if x1<= 0 then  x1:= 1;
    if x2>= Graph_x *5 then  x2:= Graph_x*5-1;
    if x2<= 0 then  x2:= 1;

    if y1>=Graph_Z*5 then  y1:=Graph_Z*5-1;
    if Y1<=0 then   Y1:=1;
    if y2>=Graph_Z*5 then  y2:=Graph_Z*5-1;
    if Y2<=0 then   Y2:=1;

    for I := x1 to x2 do
       for j := y1 to y2 do
       ZCYL_ThreeDim[i][j].SmoothCount:=sc;
end;

procedure TForm_ThreeZCyl.ClearZcyl_ThreeDim();
var
  i:integer;
begin
   for I := 0 to high(ZCYL_ThreeDim) do
       setlength(ZCYL_ThreeDim[i],0) ;
  setlength(ZCYL_ThreeDim,0) ;
  GraphChart.ClearChart ;
end;

procedure TForm_ThreeZCyl.CreateZcyl_ThreeDim(X, Y: integer);
var
  i,j:integer;
begin
   setlength(ZCYL_ThreeDim,x*5+1) ;
   for I := 0 to high(ZCYL_ThreeDim) do begin
       setlength(ZCYL_ThreeDim[i],y*5+1) ;
       for j := 0 to high(ZCYL_ThreeDim[i]) do
         FillDimXYData(i,j,0,0,0);
   end;
end;

procedure TForm_ThreeZCyl.DispLineGraphPop(Px, Py: Integer);
begin
    LineGraphPop_SaveBmp.Enabled :=true;
    PopupMenu_LineGraph.Popup(px,py);
end;

procedure TForm_ThreeZCyl.ExitButtonClick(Sender: TObject);
begin
    Close;
end;

procedure TForm_ThreeZCyl.FillCircleData(X0, Y0, Fx,Bh: integer; Basic,
  Val: Double;Zcyl:TZcylRec);
  {
    Fx := 1 是指 东南  2 东北 3 西北  4 西南 角
    Gh :=1  第一个 工作面  2 第二个工作面
  }
var
  X1,x2,y1,y2:integer;
  xFlag,YFlag,ZFlag:integer;
  xi,yi:integer;
begin

  if Fx=1 then begin
     xFlag:=1;
     YFlag:=-1;
     ZFlag:=1;
  end else if Fx=2 then begin
     xFlag:=1;
     YFlag:=1;
     ZFlag:=-1;
  end else if Fx=3 then begin
     xFlag:=-1;
     YFlag:=1;
     ZFlag:=1;
  end else if Fx=4 then begin
     xFlag:=-1;
     YFlag:=-1;
     ZFlag:=-1;
  end ;
   //内应力场峰值
  x1:=min(x0,x0+xFlag*round(Zcyl.S0/2/2));
  x2:=max(x0,x0+xFlag*round(Zcyl.S0/2/2));
  y1:=min(y0,Y0+YFlag*round(Zcyl.S0/2/2));
  y2:=max(y0,Y0+YFlag*round(Zcyl.S0/2/2));
  if ZFlag>0 then  yi:=Y1 else Yi:=y2;
  for xi := x1 to x2 do begin
       FillDimXYData(xi,Yi,bh,1, Basic+Val*Zcyl.K1);
       Yi:=Yi+ZFlag;
  end;
//      //内应力场边界
  x1:=min(x0,x0+xFlag*round(Zcyl.S0/2));
  x2:=max(x0,x0+xFlag*round(Zcyl.S0/2));
  y1:=min(y0,Y0+YFlag*round(Zcyl.S0/2));
  y2:=max(y0,Y0+YFlag*round(Zcyl.S0/2));
  if ZFlag>0 then  yi:=Y1 else Yi:=y2;
  for xi := x1 to x2 do begin
       FillDimXYData(xi,Yi,bh,1, Basic+Val*0.5);
       Yi:=Yi+ZFlag;
  end;

//       //外应力场峰值
  x1:=min(x0,x0+xFlag*round(Zcyl.S1/2));
  x2:=max(x0,x0+xFlag*round(Zcyl.S1/2));
  y1:=min(y0,Y0+YFlag*round(Zcyl.S1/2));
  y2:=max(y0,Y0+YFlag*round(Zcyl.S1/2));
  if ZFlag>0 then  yi:=Y1 else Yi:=y2;
  for xi := x1 to x2 do begin
       FillDimXYData(xi,Yi,bh, 1,Basic+Val*Zcyl.k2);
       Yi:=Yi+ZFlag;
  end;

//         //外应力场中线
  x1:=min(x0,x0+xFlag*round(Zcyl.SX/2/3));
  x2:=max(x0,x0+xFlag*round(Zcyl.SX/2/3));
  y1:=min(y0,Y0+YFlag*round(Zcyl.SX/2/3));
  y2:=max(y0,Y0+YFlag*round(Zcyl.SX/2/3));
  if ZFlag>0 then  yi:=Y1 else Yi:=y2;
  for xi := x1 to x2 do begin
       FillDimXYData(xi,Yi,bh,1, Basic+Val*(Zcyl.k2-(Zcyl.k2-1)/4));
       Yi:=Yi+ZFlag;
  end;

//         //外应力场边界
  x1:=min(x0,x0+xFlag*round(Zcyl.SX/2));
  x2:=max(x0,x0+xFlag*round(Zcyl.SX/2));
  y1:=min(y0,Y0+YFlag*round(Zcyl.SX/2));
  y2:=max(y0,Y0+YFlag*round(Zcyl.SX/2));
  if ZFlag>0 then  yi:=Y1 else Yi:=y2;
  for xi := x1 to x2 do begin
       FillDimXYData(xi,Yi,bh, 1,Basic+Val*1);
       Yi:=Yi+ZFlag;
  end;
end;

procedure TForm_ThreeZCyl.FillDimSecondData(xi, yi: integer; lineValue,
  Basic_C: Double);
var
  i,j:integer;
  pt:array [0..4] of TSmotherThreePoint;
begin
    for I := 0 to 4 do begin
        pt[i].pt.X:=xi;
        pt[i].pt.Y :=Yi;
        pt[i].DataV:=Basic_C;
    end;

    for I := xi-1 downto 0 do
        if ZCYL_ThreeDim[i][yi].SmoothCount=2 then begin
           pt[1].pt.X :=i;
           pt[1].pt.Y :=yi;
           pt[1].DataV:=ZCYL_ThreeDim[i][yi].SmoothData;
           break;
        end;

    for I := xi+1 to Graph_x*5 do
        if ZCYL_ThreeDim[i][yi].SmoothData>lineValue then begin
           pt[2].pt.X :=i;
           pt[2].pt.Y :=yi;
           pt[2].DataV:=ZCYL_ThreeDim[i][yi].SmoothData;
           break;
        end;


    for j := yi-1 downto 0 do
        if ZCYL_ThreeDim[xi][j].SmoothData>lineValue then begin
           pt[3].pt.X :=xi;
           pt[3].pt.Y :=j;
           pt[3].DataV:=ZCYL_ThreeDim[xi][j].SmoothData;
           break;
        end;

    for j := yi+1 to Graph_Z*5 do
        if ZCYL_ThreeDim[xi][j].SmoothData>lineValue then begin
           pt[4].pt.X :=xi;
           pt[4].pt.Y :=j;
           pt[4].DataV:=ZCYL_ThreeDim[xi][j].SmoothData;
           break;
        end;

        pt[0]:=self.Inverse_Distance_Powe(pt[0],pt[1],pt[2],pt[3],pt[4]);

     ZCYL_ThreeDim[pt[0].pt.x][pt[0].pt.y].SmoothData:=pt[0].DataV;

end;

procedure TForm_ThreeZCyl.FillDimXData(Y0,UpperOrDown,GzmBh: integer; Jinchi,Basic,Val: double;
                          Zcyl:TZcylRec);
{ UpperOrDown 1 向外扩展  -1 向内扩展
  dJ 应力是否叠加  0 不叠加  1 叠加
}
var
  i,yi:integer;
  x10,x20,Xi1,Xi2:integer;
begin
    //边界处
    X10:=round((Graph_x-RightBlanK-Jinchi)*5);
    X20:= (Graph_x-RightBlanK)*5;
    yi:=Y0;
    for i := X10 to X20 do  begin
       FillDimXYData(i,Yi,GzmBh,0, Basic+Val*0.2);
    end;
    // 老塘处
    yi:=Y0+UpperOrDown * Round(PU_Old_Ci/2) *-1;
    for i := X10 to X20 do begin
      FillDimXYData(i,Yi,GzmBh,0, Basic+Val*0.2);
    end;
    // 内应力场峰值处
    yi:=Y0+UpperOrDown * round(Zcyl.S0/2/2);
    if yi>Graph_Z*5 then  yi:=Graph_Z*5;
    Xi1:=X10-round(Zcyl.S0/2/2);
    xi2:=X20+round(Zcyl.S0/2/2);
    for i := Xi1 to Xi2 do  begin
       FillDimXYData(i,Yi,GzmBh,0, Basic+Val*Zcyl.K1);
    end;
     // 内应力场峰边界处
    yi:=Y0+UpperOrDown * round(Zcyl.S0/2);
    Xi1:=X10-round(Zcyl.S0/2);
    xi2:=X20+round(Zcyl.S0/2);

    for i := Xi1 to Xi2 do begin
       FillDimXYData(i,Yi,GzmBh, 0,Basic+Val*0.5);

    end;
     // 外应力场峰处
    yi:=Y0+UpperOrDown * round(Zcyl.S1/2);
    if yi>Graph_Z*5 then  yi:=Graph_Z*5;
    Xi1:=X10-round(Zcyl.S1/2);
    xi2:=X20+round(Zcyl.S1/2);
    if xi2>= Graph_x *5 then  xi2:= Graph_x*5-1;
    if xi1< 0 then  xi1:= 0;
    for i := Xi1 to Xi2 do  begin
       if  ZCYL_ThreeDim[i][Yi].SmoothData >Basic+ Val then begin
           FillDimXYData(i,Yi,GzmBh, 1,Basic+Val*(ZCYL_ThreeDim[i][Yi].SmoothData/Basic*Zcyl.k2)) ;
       end else if ZCYL_ThreeDim[i][Yi].SmoothData >Basic then begin
           FillDimXYData(i,Yi,GzmBh, 0,Basic+Val*(Zcyl.k2-ZCYL_ThreeDim[i][Yi].SmoothData/Basic));
       end else begin
           FillDimXYData(i,Yi,GzmBh,1,Basic+ Val*Zcyl.k2);
       end ;



    end;

    // 外应力场边界处
    yi:=Y0+UpperOrDown * round(Zcyl.SX/2);
    if yi>Graph_Z*5 then  yi:=Graph_Z*5;
    if yi<0 then  exit;


    Xi1:=X10-round(Zcyl.SX/2);
    xi2:=X20+round(Zcyl.SX/2);
    if xi2>= Graph_x *5 then  xi2:= Graph_x*5-1;
    if xi1< 0 then  xi1:= 0;
    for i := Xi1 to Xi2 do begin
       if  ZCYL_ThreeDim[i][Yi].SmoothData >Basic  then
            FillDimXYData(i,Yi,GzmBh, 0,Basic+Val*(ZCYL_ThreeDim[i][Yi].SmoothData/Basic*1))
         else    FillDimXYData(i,Yi,GzmBh,0,Basic+ Val*1);

    end;

end;

procedure TForm_ThreeZCyl.FillDimXYData(x, y,SmoothCount,iMax: integer; Data: Double);
begin
    if x> Graph_x *5 then  x:= Graph_x*5-1;
    if x< 0 then  x:= 1;

    if y>Graph_Z*5 then  y:=Graph_Z*5;
    if Y<0 then   Y:=0;

    if iMax=0 then begin
       ZCYL_ThreeDim[x][y].SmoothData:=Data;
    end else if iMax=1 then  begin
       ZCYL_ThreeDim[x][y].SmoothData:=max(ZCYL_ThreeDim[x][y].SmoothData,Data);

    end;
    ZCYL_ThreeDim[x][y].SmoothCount:=SmoothCount;
end;

procedure TForm_ThreeZCyl.FillDimYData(X0,UpperOrDown,QY,gzmbh: integer; Basic,Val: double;
                        Zcyl:TZcylRec);
{ 1 向外扩展  -1 向内扩展
  QY  0 不是切眼  1 是切眼
}
var
  j,xi,x1,X2:integer;
  Yi1,Yi2,Y10,y20:integer;
  Fir_S0,Fir_S1,Fir_SX,Fir_K1,Fir_k2:double;
begin
   // 支承压力老塘边界第一工作面
   if gzmbh=1 then  begin
        Y10:=(BottomBlank+Work2Width+Mid_Coal )*5;
        y20:= (Graph_Z-TopBlank )*5;
        if QY=0 then   begin //不是切眼处
           x1:=15*5;
        end else begin
           x1:=X0;
        end;
        //老塘边界
        xi:=x1;
        for j := Y10 to y20 do
           FillDimXYData(xi,j,gzmbh,0, Basic+Val*0.2);

        //老塘内部
        xi:=x1+UpperOrDown *-1 * round(PU_Old_Ci/2);
        yi1:=y10+Round(Zcyl.S0/2/2);
        yi2:=y20-Round(Zcyl.S0/2/2);
        for j := Yi1 to yi2 do
             FillDimXYData(xi,j,gzmbh,0, Basic+Val*0.5);
    //
        //内应力场峰值
         xi:=x1+UpperOrDown * round(Zcyl.S0/2/2);
         yi1:=y10-round(Zcyl.S0/2/2);
         yi2:=y20+round(Zcyl.S0/2/2);
         for j := Yi1 to yi2 do
              FillDimXYData(xi,j,gzmbh,0, Basic+Val*Zcyl.K1);
          //内应力场边界
         xi:=x1+UpperOrDown * round(Zcyl.S0/2);

        yi1:=y10-round(Zcyl.S0/2);
        yi2:=y20+round(Zcyl.S0/2);
        for j := Yi1 to yi2 do
          FillDimXYData(xi,j,gzmbh,0, Basic+Val*0.5);
           //外应力场峰值
        xi:=x1+UpperOrDown * round(Zcyl.S1/2);
        yi1:=y10-round(Zcyl.S1/2);
        yi2:=y20+round(Zcyl.S1/2);
        for j := Yi1 to yi2 do
          FillDimXYData(xi,j,gzmbh, 0,Basic+Val*Zcyl.k2);
    //         //外应力场边界
        xi:=x1+UpperOrDown * round(Zcyl.SX/2);
        yi1:=y10-round(Zcyl.SX/2);
        yi2:=y20+round(Zcyl.SX/2);
        for j := Yi1 to yi2 do
          FillDimXYData(xi,j,gzmbh,0, Basic+Val*1);
   end else begin
          //支承压力老塘边界  第二工作面
          Y10:=BottomBlank*5; y20:= (BottomBlank+Work2Width )*5;
//          //把涉及到的区域编号清空
//          X1:=min(x0+UpperOrDown *-1 * round(PU_Old_Ci/2),x0+UpperOrDown * round(Pu_SX/2));
//          X2:=max(x0+UpperOrDown *-1 * round(PU_Old_Ci/2),x0+UpperOrDown * round(Pu_SX/2));
//          ClearDimSmoothCount(x1,x2,y1,y2,1);
          //老塘边界
          xi:=x0;
         for j := Y10 to y20 do
            FillDimXYData(xi,j,gzmbh,0, Basic+Val*0.2);
           //老塘内部
          xi:=x0+UpperOrDown *-1 * round(PU_Old_Ci/2);
          yi1:=y10+Round(Zcyl.S0/2/2);
          yi2:=y20-Round(Zcyl.S0/2/2);
          for j := Yi1 to yi2 do begin
              FillDimXYData(xi,j,gzmbh,0, Basic+Val*0.5);
          end;
          //内应力场峰值
         xi:=x0+UpperOrDown * round(Zcyl.S0/2/2);
         yi1:=y10-round(Zcyl.S0/2/2);
         yi2:=y20+round(Zcyl.S0/2/2);
          for j := Yi1 to yi2 do  begin
            FillDimXYData(xi,j,gzmbh, 0,Basic+Val*Zcyl.K1);
          end;
            //内应力场边界
         xi:=x0+UpperOrDown * round(Zcyl.S0/2);
         yi1:=y10-round(Zcyl.S0/2);
         yi2:=y20+round(Zcyl.S0/2);
          for j := Yi1 to yi2 do begin
            FillDimXYData(xi,j,gzmbh,0, Basic+Val*0.5);
          end;
             //外应力场峰值
         xi:=x0+UpperOrDown * round(Zcyl.S1/2);
         if xi> Graph_x *5 then  xi:= Graph_x*5-1;
         if xi< 0 then  xi:= 1;
         yi1:=y10-round(Zcyl.S1/2);
         yi2:=y20+round(Zcyl.S1/2);
         if yi2>=Graph_Z*5 then  yi2:=Graph_Z*5-1;
         if yi1<=0 then yi1:=1;
          for j := Yi1 to yi2 do  begin
            if (ZCYL_ThreeDim[Xi][j].SmoothCount<=0) and (ZCYL_ThreeDim[Xi][j].SmoothData>Basic) then
                FillDimXYData(xi,j,gzmbh,1, Basic+Val*(ZCYL_ThreeDim[Xi][j].SmoothData/Basic*Zcyl.k2))
               else   FillDimXYData(xi,j,gzmbh, 1,Basic+Val*Zcyl.k2);
          end;
               //外应力场边界
         xi:=x0+UpperOrDown * round(Zcyl.SX/2);
         if xi> Graph_x *5 then  xi:= Graph_x*5-1;
         if xi< 0 then  xi:= 1;
         yi1:=y10-round(Zcyl.SX/2);
         yi2:=y20+round(Zcyl.SX/2);
         if yi2>=Graph_Z*5 then  yi2:=Graph_Z*5-1;
         if yi1<=0 then yi1:=1;

          for j := Yi1 to yi2 do  begin
             if (ZCYL_ThreeDim[Xi][j].SmoothCount<=0) and (ZCYL_ThreeDim[Xi][j].SmoothData>Basic)   then
                FillDimXYData(xi,j,gzmbh,1, Basic+Val*(ZCYL_ThreeDim[Xi][j].SmoothData/Basic*1))
               else   FillDimXYData(xi,j,gzmbh,1,Basic+Val*1);
          end;
   end;
end;

procedure TForm_ThreeZCyl.FillDimZeroData(xi, yi,CountLine: integer;Basic_C:Double);
var
  i,j:integer;
  pt:array [0..4] of TSmotherThreePoint;
begin
    for I := 0 to 4 do begin
        pt[i].pt.X:=xi;
        pt[i].pt.Y :=Yi;
        pt[i].DataV:=Basic_C;
    end;

    for I := xi-1 downto 0 do
        if ZCYL_ThreeDim[i][yi].SmoothCount>=CountLine then begin
           pt[1].pt.X :=i;
           pt[1].pt.Y :=yi;
           pt[1].DataV:=ZCYL_ThreeDim[i][yi].SmoothData;
           break;
        end;

    if  pt[1].DataV <=Basic_C then   begin
        J:=Yi+1;
         for I := xi-1 downto 0 do begin
             if (i>=0) and (j<=Graph_Z*5)  then
                 if ZCYL_ThreeDim[i][yi].SmoothCount>=CountLine then begin
                     pt[1].pt.X :=i;
                     pt[1].pt.Y :=yi;
                     pt[1].DataV:=ZCYL_ThreeDim[i][yi].SmoothData;
                     break;
                  end;
             J:=J+1;
         end;
    end;


    for I := xi+1 to Graph_x*5 do
        if ZCYL_ThreeDim[i][yi].SmoothCount>=CountLine then begin
           pt[2].pt.X :=i;
           pt[2].pt.Y :=yi;
           pt[2].DataV:=ZCYL_ThreeDim[i][yi].SmoothData;
           break;
        end;

    if  pt[2].DataV <=Basic_C then   begin
        J:=Yi-1;
         for I := xi+1 to Graph_x*5 do   begin
             if (i<=Graph_x*5) and (j>=0)  then
                 if ZCYL_ThreeDim[i][yi].SmoothCount>=CountLine then begin
                     pt[2].pt.X :=i;
                     pt[2].pt.Y :=yi;
                     pt[2].DataV:=ZCYL_ThreeDim[i][yi].SmoothData;
                     break;
                  end;
             J:=J-1;
         end;
    end;


    for j := yi-1 downto 0 do
        if ZCYL_ThreeDim[xi][j].SmoothCount>=CountLine then begin
           pt[3].pt.X :=xi;
           pt[3].pt.Y :=j;
           pt[3].DataV:=ZCYL_ThreeDim[xi][j].SmoothData;
           break;
        end;

    if  pt[3].DataV <=Basic_C then   begin
        I:=Xi-1;
         for j := yi-1 downto 0 do   begin
             if (i>=0) and (j>=0)  then
                 if ZCYL_ThreeDim[i][yi].SmoothCount>=CountLine then begin
                     pt[3].pt.X :=i;
                     pt[3].pt.Y :=yi;
                     pt[3].DataV:=ZCYL_ThreeDim[i][yi].SmoothData;
                     break;
                  end;
             I:=I-1;
         end;
    end;

    for j := yi+1 to Graph_Z*5 do
        if ZCYL_ThreeDim[xi][j].SmoothCount>=CountLine then begin
           pt[4].pt.X :=xi;
           pt[4].pt.Y :=j;
           pt[4].DataV:=ZCYL_ThreeDim[xi][j].SmoothData;
           break;
        end;

    if  pt[4].DataV <=Basic_C then   begin
        I:=Xi+1;
         for  j := yi+1 to Graph_Z*5 do   begin
             if (i<=Graph_x*5) and (j<=Graph_Z*5)  then
                 if ZCYL_ThreeDim[i][yi].SmoothCount>=CountLine then begin
                     pt[4].pt.X :=i;
                     pt[4].pt.Y :=yi;
                     pt[4].DataV:=ZCYL_ThreeDim[i][yi].SmoothData;
                     break;
                  end;
             I:=I+1;
         end;
    end;


     pt[0]:=self.Inverse_Distance_Powe(pt[0],pt[1],pt[2],pt[3],pt[4]);
     ZCYL_ThreeDim[pt[0].pt.x][pt[0].pt.y].SmoothData:=
          max(ZCYL_ThreeDim[pt[0].pt.x][pt[0].pt.y].SmoothData,pt[0].DataV);

end;

procedure TForm_ThreeZCyl.FillGS_series(L0, Jinchi: double; GS_S: TTowerSeries);
var
  tmp1 ,tmp2,i,j :integer;
begin
  GS_S.Dark3D :=true;

   with GS_S do begin

     // Origin:=YValues.MinValue+(YValues.MaxValue-YValues.MinValue)/2;
     // UseOrigin:=true;
      {tsArrow tsRectangle  tsCylinder   tsCover   tsArrow   tsSlantCube  tsCube}
      TowerStyle:=tsRectangle;
      Marks.Visible:=False;
      Dark3D:=true;
      Transparency:=0;
      UseColorRange:=false;
      UsePalette:=true;
      ColorEachPoint:=true;
   end;

   if Jinchi <= (Graph_x-LeftBlank-rightBlank) div 2 then   begin
       GS_S.Brush.Image.Bitmap.LoadFromFile(public_Basic.Get_MyModulePath +'BJtp\gs.bmp');
   end;

    // 第一个老塘区域

       for I := leftBlank to Graph_x-RightBlank  do
          for j := Graph_z div 2 + Mid_Coal div 2 to graph_Z- TopBlank do begin
              tmp1:=GS_S.AddXYZ(i,3,j);
          end;

     // 第二个老塘区域
    for I := Graph_x-RightBlank- round(Jinchi)+2 to Graph_x-RightBlank  do
          for j := BottomBlank+2  to + Graph_z div 2- Mid_Coal div 2 do begin
              tmp1:=GS_S.AddXYZ(i,3,j);
          end;

    tmp1:=GS_S.AddXYZ(8,6,10);
    tmp1:=GS_S.AddXYZ(8,2,10);
    GS_S.ValueColor[tmp1]:=clBlack;

end;

procedure TForm_ThreeZCyl.FillSeiesData(Series: TCustom3DSeries);
var
  i,j:integer;
begin
    Series.Clear ;
    if loadData then
     for I := 0 to Graph_x*5 do
        for j := 0 to Graph_Z*5 do
         Series.AddXYZ( i/5,
                        ZCYL_ThreeDim[i][j].SmoothData,
                        j/5
                        );

    Series.AddXYZ(0,0,Graph_Z);
    Series.RefreshSeries;



end;

procedure TForm_ThreeZCyl.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action:=CaFree;
   Form_ThreeZCyl:=nil;
end;

procedure TForm_ThreeZCyl.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
   pic_Path:string;
   pt1,pt2:TPoint;
begin
try
   Pic_Path  :=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\OneCoal'+'_3_1.BMP';
   if ShowScreen=1 then begin
      Form_ThreeZCyl.GraphChart.SaveToBitmapFile(Pic_Path);
   end;

    ClearZcyl_ThreeDim;
    //if Assigned(Form_ThreeZCyl) then  FreeandNil(Form_ThreeZCyl);
finally

end;

end;

procedure TForm_ThreeZCyl.FormCreate(Sender: TObject);
begin
   Public_basic.InitStatusBar(StatusBar1);
   InitForm;
end;

function TForm_ThreeZCyl.GetContourColor(Mia_V, Min_V: Double; xh: integer;
  var Up_Value: double): TColor;
var
   ContourColor : array [0..10] of TColor;
   dis:double;
begin
    ContourColor[0]:=clwhite;    ContourColor[1]:=clInfoBk;   {白  淡黄}
    ContourColor[2]:=ClYellow;    ContourColor[3]:=$00E500;   {黄  浅绿}
    ContourColor[4]:=$0C8918;    ContourColor[5]:=clBlue;   {深绿  深蓝}
    ContourColor[6]:=$0080FF;    ContourColor[7]:=ClFuchsia;   {橙红 绯红 }
    ContourColor[8]:=$0000FF;    ContourColor[9]:=$000080;   { 红 深红}
    if xh > 6 then   exit;
    dis:=(Mia_V- Min_V)/6;
    Up_Value:=Min_V+dis*xh;
    Result:=ContourColor[3+xh];

end;



procedure TForm_ThreeZCyl.GraphChartDblClick(Sender: TObject);
begin
//    DispMark:=not DispMark;
//    SetMarkLabelVisible(DispMark);

end;

procedure TForm_ThreeZCyl.GraphChartGetAxisLabel(Sender: TChartAxis;
  Series: TChartSeries; ValueIndex: Integer; var LabelText: string);
var
  Daoshu:integer;
  Text:String;
begin
        if Sender=GraphChart.BottomAxis then   begin
             Text:=StringReplace (LabelText, ',', '', [rfReplaceAll]);
             Daoshu:=Round(Public_Basic.StrToDouble_Lu(Text));
             LabelText:=FormatFloat('0',(GRaph_x-RightBlank-DaoShu)*10);
        end;

          if Sender=GraphChart.DepthAxis then   begin
             Text:=StringReplace (LabelText, ',', '', [rfReplaceAll]);
             Daoshu:=Round(Public_Basic.StrToDouble_Lu(Text));
             LabelText:=FormatFloat('0',(DaoShu-BottomBlank)*15);
        end;

end;

procedure TForm_ThreeZCyl.GraphChartMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
 var
  pt:Tpoint;
begin

   if Button=mbRight then begin
      pt:= GraphChart.ClientToScreen(Point(0,0));
      DispLineGraphPop(pt.X+x,pt.Y +y);

   end;

end;

procedure TForm_ThreeZCyl.GraphChartMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
//     if WheelDelta>0 then  begin  //滚轮  前推 放大
//         GraphChart.ZoomPercent( 110 );
//     end else begin   //滚轮  后滚 缩小
//         GraphChart.ZoomPercent( 90);
//     end;

end;

procedure TForm_ThreeZCyl.InitForm();
begin
   loadData:=False;
   GraphChart.Align :=AlClient;
   AddVertAxes(GraphChart);
   //
   Basic_Line:=15;
   Val_D:=2;
    //
   ChangeBasicData(4);
   CreateZcyl_ThreeDim(Graph_x,Graph_Z);
    //加载数据
   LoadZCYLThreeDimData(Basic_Line,Val_D);

end;

function TForm_ThreeZCyl.Inverse_Distance_Powe(p0, p1, p2, p3,
  p4: TSmotherThreePoint): TSmotherThreePoint;
var
  D_i,W_i :Array [0..3] of double;
  D_s:double;
  i:integer;
begin
     d_i[0]:=sqrt(sqr(p1.pt.x-p0.pt.x)+sqr(p1.pt.Y -p0.pt.Y));
     d_i[1]:=sqrt(sqr(p2.pt.X-p0.pt.x)+sqr(p2.pt.Y -p0.pt.Y));
     d_i[2]:=sqrt(sqr(p3.pt.X-p0.pt.x)+sqr(p3.pt.Y -p0.pt.Y));
     d_i[3]:=sqrt(sqr(p4.pt.X-p0.pt.x)+sqr(p4.pt.Y -p0.pt.Y));
     D_s:=0;
     for I := 0 to 3 do
       if d_i[i]>0 then  D_s:=D_s+1/d_i[i];

     if D_s=0 then D_s:=1;
     for I := 0 to 3 do begin
         if d_i[i]>0 then  begin
            W_i[i]:=1/d_i[i]/D_s;
         end  else  begin
            W_i[i]:=0;
         end;
     end;

    P0.DataV:=p1.DataV * w_i[0]+  p2.DataV * w_i[1]  + p3.DataV * w_i[2] +  p4.DataV * w_i[3];

    Result:=P0;

end;


procedure TForm_ThreeZCyl.LineGraphPop_RefreshClick(Sender: TObject);
begin
     RefreshChartGraph;
end;

procedure TForm_ThreeZCyl.LineGraphPop_SaveBMPClick(Sender: TObject);
begin
   SavePictureDialog1.Execute ;

end;



function TForm_ThreeZCyl.LoadZCYLThreeDimData(Bas_Ys,BS_V:integer): Boolean;
var
  i,j:integer;
  x1,x2,y1,y2,Value:integer;
begin
    for I := 0 to high(ZCYL_ThreeDim) do
       for j := 0 to high(ZCYL_ThreeDim[i]) do
          FillDimXYData(i,j,0,0,0);

   {把图形四周边界封死}
   //左边界
   for j := 0 to High(ZCYL_ThreeDim[0]) do
      FillDimXYData(0,j,2, 0,Bas_Ys+BS_V);

    //右边界
   for j := 0 to High(ZCYL_ThreeDim[ High(ZCYL_ThreeDim)  ]) do
      FillDimXYData(High(ZCYL_ThreeDim) ,j,2,0, Bas_Ys+BS_V);

   //下边界
   for i := 0 to High(ZCYL_ThreeDim) do
       FillDimXYData(i ,0,2,0, Bas_Ys+BS_V);
   //上边界
   for i := 0 to High(ZCYL_ThreeDim) do
       FillDimXYData(i,High(ZCYL_ThreeDim[i]),2,0, Bas_Ys+BS_V);
   // 第一个工作面
   MakeFirstGzmZcyl((Graph_x-RightBlanK-LeftBlank)*5,Bas_Ys,BS_V);

   //第二个工作面
   MakeSecondGzmZcyl(Second_JinChi,Bas_Ys,BS_V);

   loadData:=true;


end;

procedure TForm_ThreeZCyl.MakeFirstGzmZcyl(JinChi:double;Bas_Ys,BS_V:integer);
var
  i,j:integer;
  x1,x2,y1,y2,Value:integer;
  Fir_Zcyl: TZcylRec;
begin
   Fir_Zcyl:=Split_Get_ZCYl(ExPstopeClass.Get_Zcyl('2.0',JinChi));

   // 开切眼后方的 支承压力范围
   x1:=(Graph_x-RightBlanK)*5;
   FillDimYData(x1,1,1,1,Bas_Ys,BS_V,Fir_Zcyl);
   // 工作面前方的 支承压力范围
   x1:=round((LeftBlanK)*5);
   FillDimYData(x1,-1,0,1,Bas_Ys,BS_V,Fir_Zcyl);
   //第一个工作面的上方
   y1:=(Graph_Z-TopBlank)*5;
   FillDimXData(y1,1,1,60,Bas_Ys,BS_V,Fir_Zcyl);
  //第一个工作面的下方
   y1:=(Graph_Z-TopBlank-Work1Width)*5;
   FillDimXData(y1,-1,1,60,Bas_Ys,BS_V,Fir_Zcyl);

   x1:= round((LeftBlanK)*5)+round(PU_Old_Ci/2);
   x2:=(Graph_x-RightBlanK)*5-round(PU_Old_Ci/2);
   Y1:=(Graph_Z-TopBlank-Work1Width)*5+round(PU_Old_Ci/2);
   Y2:=(Graph_Z-TopBlank)*5-round(PU_Old_Ci/2);

   for I := x1 to x2 do
         for j := y1 to y2 do
            FillDimXYData(i,j,2,0, Bas_Ys+BS_V*0.5);
       // 东南角
       FillCircleData((Graph_x-RightBlanK)*5,(Graph_Z-TopBlank-Work1Width)*5,1,2,Bas_Ys,BS_V,Fir_Zcyl);
       // 东北角
       FillCircleData((Graph_x-RightBlanK)*5,(Graph_Z-TopBlank)*5,2,2,Bas_Ys,BS_V,Fir_Zcyl);
        // 西北角
       FillCircleData(round(LeftBlanK)*5,(Graph_Z-TopBlank)*5,3,2,Bas_Ys,BS_V,Fir_Zcyl);
        // 西南角
       FillCircleData(round(LeftBlanK)*5,(Graph_Z-TopBlank-Work1Width)*5,4,2,Bas_Ys,BS_V,Fir_Zcyl);


     //第一次数据平衡
    for I := 0 to High(ZCYL_ThreeDim) do
       for j := 0 to High(ZCYL_ThreeDim[i]) do
         if ZCYL_ThreeDim[i][j].SmoothCount<=0 then begin
            FillDimZeroData(i,j,1,Bas_Ys);
            ZCYL_ThreeDim[i][j].SmoothCount:=1;
         end else begin
            ZCYL_ThreeDim[i][j].SmoothCount:=2;
         end;
end;

procedure TForm_ThreeZCyl.MakeLineGraphChartTitle(Chart: Tchart);
var
 Caption:String;
 lowTime,highTime,InterValTime:integer;
 i:integer;
begin

    Chart.Title.Font.Color :=ClBlack;
    Caption:='【'+ExPstopeClass.Ex_Gzm.S_Name +'工作面】支承压力分布三维示意图';

    Chart.MarginLeft :=50;
    Chart.Title.TextAlignment:=taCenter;
    Chart.Title.Font.Name :='黑体';
    Chart.Title.Font.Size :=14;
    Chart.Title.Caption := Caption;

    Chart.SubTitle.Font.Color :=ClBlack;
    Chart.SubTitle.TextAlignment:=taCenter;
    Chart.SubTitle.Font.Name :='宋体';
    Chart.SubTitle.Font.Size :=9;


    Chart.BottomAxis.Visible :=true;

    //控制坐标横轴的显示方式
     Chart.ScrollMouseButton:=mbleft;
     Chart.AllowPanning:=pmHorizontal;

     Chart.BottomAxis.Title.Caption :='<--向方进推';
     Chart.BottomAxis.Title.Position  :=tpCenter ;


    // 把 工具条隐藏
    Chart.Legend.Visible:=False;
end;

procedure TForm_ThreeZCyl.MakeSecondGzmZcyl(JinChi:double;Bas_Ys,BS_V:integer);
var
  i,j:integer;
  x1,x2,y1,y2,Value:integer;
  sec_Zcyl: TZcylRec;
begin

     sec_Zcyl:=Split_Get_ZCYl(ExPstopeClass.Get_Zcyl('2.0',JinChi));

     // 把第二个工作面次的区域标注给改了
     x1:=round((Graph_x-RightBlanK)*5-JinChi/2)-round(sec_Zcyl.SX/2);
     x2:=(Graph_x-RightBlanK)*5+round(sec_Zcyl.SX/2);
     y1:=(BottomBlank)*5-round(sec_Zcyl.SX/2);
     y2:=(BottomBlank+Work2Width)*5+round(sec_Zcyl.SX/2);
     ClearDimSmoothCount(x1,x2,y1,y2,0);

  // 第二个工作面
     // 老塘的应力变化
      x1:= round((Graph_x-RightBlanK)*5-JinChi/2)+round(PU_Old_Ci/2);
      x2:=(Graph_x-RightBlanK)*5-round(PU_Old_Ci/2);
      Y1:=(BottomBlank)*5+round(PU_Old_Ci/2);
      Y2:=(BottomBlank+Work2Width)*5-round(PU_Old_Ci/2);
      for I := x1 to x2 do
         for j := y1 to y2 do
            FillDimXYData(i,j,2,0, Bas_Ys+BS_V*0.5);
//
//
//       开切眼后方的 支承压力范围
      x1:=(Graph_x-RightBlanK)*5;
      FillDimYData(x1,1,1,2,Bas_Ys,BS_V,sec_Zcyl);
       // 工作面前方的 支承压力范围
      x1:=round((Graph_x-RightBlanK)*5-JinChi/2);
      FillDimYData(x1,-1,0,2,Bas_Ys,BS_V,sec_Zcyl);
       //第二个工作面的上方
      y1:=(BottomBlank+Work2Width)*5;
      FillDimXData(y1,1,2,JinChi/10,Bas_Ys,BS_V,sec_Zcyl);
       // 第二个工作面的下方
      y1:=(BottomBlank)*5;
      FillDimXData(y1,-1,2,JinChi/10,Bas_Ys,BS_V,sec_Zcyl);
       // 东南角
       FillCircleData((Graph_x-RightBlanK)*5,(BottomBlank)*5,1,2,Bas_Ys,BS_V,sec_Zcyl);
       // 东北角
       FillCircleData((Graph_x-RightBlanK)*5,(BottomBlank+Work2Width)*5,2,2,Bas_Ys,BS_V,sec_Zcyl);
        // 西北角
       FillCircleData(round((Graph_x-RightBlanK)*5-JinChi/2),(BottomBlank+Work2Width)*5,3,2,Bas_Ys,BS_V,sec_Zcyl);
        // 西南角
       FillCircleData(round((Graph_x-RightBlanK)*5-JinChi/2),(BottomBlank)*5,4,2,Bas_Ys,BS_V,sec_Zcyl);

//    第二次数据平衡
     for I := 0 to High(ZCYL_ThreeDim) do
        for j := 0 to High(ZCYL_ThreeDim[i]) do
         if ZCYL_ThreeDim[i][j].SmoothCount<=1 then  begin
            FillDimZeroData(i,j,2,Bas_Ys+BS_V);
         end;

end;

procedure TForm_ThreeZCyl.MakeWindowsSingle(Single: integer);
begin
     if Single=0 then  begin
         BorderStyle:=BsSizeable;
         ToolBar2.Visible :=true;
         StatusBar1.Visible :=true;
     end else begin
         BorderStyle:=BsNone;
         ToolBar2.Visible :=False;
         StatusBar1.Visible :=False;
     end;
end;

procedure TForm_ThreeZCyl.MakeWorkFace(L0, TJ, JinChi: Double;GZM_S,GS_S:TTowerSeries);
var
  tmp1 ,tmp2,i,j :integer;
  mid_L,st_sup:integer;
begin
  Gzm_Series.Clear ;
  GS_S.Clear ;
  Gzm_Series.Dark3D :=true;
   with Gzm_Series do begin

     // Origin:=YValues.MinValue+(YValues.MaxValue-YValues.MinValue)/2;
     // UseOrigin:=true;
      {tsArrow tsRectangle  tsCylinder   tsCover   tsArrow   tsSlantCube  tsCube}
      Dark3D :=true;
      TowerStyle:=tsCube;
      Marks.Visible:=False;
      Dark3D:=true;
      Transparency:=0;
      UseColorRange:=false;
      UsePalette:=true;
      ColorEachPoint:=true;
      //
      //立柱起到支持的作用
      tmp1:=GZM_S.AddXYZ(5,5,10);
      GZM_S.ValueColor[tmp1]:=Clwhite;
      //四周煤体未采区域   5个单元
      //Left  15个单元
      for I := 0 to leftBlank-1  do
          for j := 0 to graph_Z do begin
              tmp1:=GZM_S.AddXYZ(i,2,j);
              GZM_S.ValueColor[tmp1]:=ClBlack;
          end;
      //right 15个单元
       for I := graph_x-RightBlanK+1 to graph_x  do
          for j := 0 to graph_Z do begin
              tmp1:=GZM_S.AddXYZ(i,2,j);
              GZM_S.ValueColor[tmp1]:=ClBlack;
          end;
       // top 10个单元
       for I := 0 to graph_x  do
          for j := graph_Z-TopBlank +1 to graph_Z do begin
              tmp1:=GZM_S.AddXYZ(i,2,j);
              GZM_S.ValueColor[tmp1]:=ClBlack;
          end;

       //Bottom  10个单元
        for I := 0 to graph_x  do
          for j := 0 to BottomBlank -1 do begin
              tmp1:=GZM_S.AddXYZ(i,2,j);
              GZM_S.ValueColor[tmp1]:=ClBlack;
          end;

      // 中间煤柱
        if Mid_Coal>0 then
         for I := leftBlank+1  to Graph_x- RightBlanK do
            for j := Graph_z div 2- Mid_Coal div 2  to  Graph_z div 2 + Mid_Coal div 2 do begin
                tmp1:=GZM_S.AddXYZ(i,2,j);
                GZM_S.ValueColor[tmp1]:=ClBlack;
            end;

      //第二个 采煤区域  未采煤体
      // NO1 Left  2个单元
         for I := leftBlank+1  to Graph_x- RightBlanK- trunc(Jinchi)  do
            for j := BottomBlank +1  to Graph_z div 2 -2 - Mid_Coal div 2 do begin
                tmp1:=GZM_S.AddXYZ(i,2,j);
                GZM_S.ValueColor[tmp1]:=ClBlack;
            end;

   end;

    tmp1:=GZM_S.AddXYZ(5,2,10);
    GZM_S.ValueColor[tmp1]:=clBlack;
    FillGS_series(L0,Jinchi,GS_S);
//
end;

procedure TForm_ThreeZCyl.MZComboxChange(Sender: TObject);
begin
   if MZCombox.ItemIndex=0 then  begin
      ChangeBasicData(6);
   end else if MZCombox.ItemIndex=1 then  begin
      ChangeBasicData(3);
   end else if MZCombox.ItemIndex=2 then  begin
      ChangeBasicData(1);
   end else if MZCombox.ItemIndex=3 then  begin
      ChangeBasicData(0);
   end;


   LoadZCYLThreeDimData(Basic_Line,Val_D);
   RefreshChartGraph;
end;

procedure TForm_ThreeZCyl.N10Click(Sender: TObject);
begin
   But_ChangFillColor.Click;
end;

procedure TForm_ThreeZCyl.N12Click(Sender: TObject);
begin
  But_DispWl.Click;
end;

procedure TForm_ThreeZCyl.N1Click(Sender: TObject);
begin
   But_Turn_Redo.Click ;
end;

procedure TForm_ThreeZCyl.N2Click(Sender: TObject);
begin
   But_Turn_left.Click ;
end;

procedure TForm_ThreeZCyl.N3Click(Sender: TObject);
begin
   But_Turn_Right.Click;
end;

procedure TForm_ThreeZCyl.N4Click(Sender: TObject);
begin
    But_Turn_top.Click;
end;

procedure TForm_ThreeZCyl.N51Click(Sender: TObject);
begin
    But_Turn_bottom.Click;
end;

procedure TForm_ThreeZCyl.But_DispWlClick(Sender: TObject);
var
 bmap1:Tbitmap;//创建位图 bitmap1
begin
   inc(tmpWl);
   if tmpWl=1 then  begin
        ZCYL_Series.SideBrush.Image.Bitmap:=nil;
      ZCYL_Series.SideBrush.BackColor:=ClGreen;
      ZCYL_Series.SideBrush.Color :=ClYellow;
   end else if tmpWl=2 then  begin
      ZCYL_Series.SideBrush.Image.Bitmap:=nil;
      ZCYL_Series.SideBrush.BackColor:=clGradientActiveCaption;
      ZCYL_Series.SideBrush.Color :=ClYellow;

   end  else  if tmpWl=3 then  begin
      ZCYL_Series.SideBrush.Clear ;
   end  else  if tmpWl=4 then  begin
      ZCYL_Series.SideBrush.Image.Bitmap:=nil;
      ZCYL_Series.SideBrush.BackColor:=clYellow;
      ZCYL_Series.SideBrush.Color :=ClYellow;
      try
         bmap1:=Tbitmap.Create;//创建位图 bitmap1
//         MainDataModule.MySqliteDataBase.GetBMPToSQlite('ht.bmp','1',bmap1);
         ZCYL_Series.SideBrush.Image.Bitmap :=bmap1;

      finally
         FreeAndNil(bmap1);
      end;
   end else if  tmpWl=5 then  begin
      ZCYL_Series.SideBrush.Image.Bitmap:=nil;
      ZCYL_Series.SideBrush.BackColor:=clGray;
      ZCYL_Series.SideBrush.Color :=ClYellow;
      tmpWl:=0;
   end;

end;

procedure TForm_ThreeZCyl.Pop_ExitClick(Sender: TObject);
begin
   Close;
end;

procedure TForm_ThreeZCyl.RefreshChartGraph;
var
 i_Count,i:integer;
begin
   MakeLineGraphChartTitle(GraphChart);
   if true then  begin
      MakeWorkFace(PU_L0/10,PU_Tj/10, Second_Jinchi/10,GZM_Series,Gs_Series);
      FillSeiesData(ZCYL_Series);
      SetArrowMark(Second_Jinchi/10,GZM_Series,Gs_Series);
   end;
   setSeriesLevelColor(25 ,20);
   GraphChart.Refresh;
  // LineGraphChartSaveIntoBMP('');

end;

procedure TForm_ThreeZCyl.SaveButtonClick(Sender: TObject);
begin
   RefreshChartGraph;
end;

//function TForm_ThreeZCyl.selectFromFourFangxiang(var TD: TDoubleContourRecord;
//  pt: TPoint; AGV:double;min_Dao,Max_Dao,Min_Sup,Max_Sup:integer): Boolean;
//var
//  Dao,Sup,i,C_i,Flag:integer;
//  findB:Boolean;
//  ArPt: array [0..4] of TSmotherThreePoint;
//  t_D,t_S,S_C:integer;
//
//begin
//   findB:=False;
//   Dao:=pt.X;Sup:=pt.Y;
//   C_i:=1;Flag:=1; S_C:=0;   t_D:=0;t_S:=0;
//   for I := 0 to 3 do    begin
//        repeat
//            if t_D< C_i then begin
//               Dao:=Dao+Flag;   inc(t_D);
//            end else if t_S<C_i then  begin
//               Sup:=sup+Flag;  inc(T_s);
//            end else begin
//              inc(C_i);
//              Flag:=-Flag;
//              t_S:=0;
//              t_D:=0;
//              Dao:=Dao+Flag;   inc(t_D);
//            end;
//
//
//            if Dao<min_Dao then  begin
//               Dao:=0;
//                if TD[Dao][sup].SmoothData <0 then  TD[Dao][sup].SmoothData :=AGV;
//            end;
//            if Dao> Max_Dao then  begin
//               Dao:=Max_Dao;
//                if TD[Dao][sup].SmoothData <0 then TD[Dao][sup].SmoothData :=AGV;
//            end;
//            if sup<Min_Sup then begin
//                Sup:=Min_Sup;
//                if TD[Dao][sup].SmoothData <0 then TD[Dao][sup].SmoothData :=AGV;
//            end;
//            if Sup>Max_Sup then begin
//               Sup:= Max_Sup;
//               if TD[Dao][sup].SmoothData <0 then TD[Dao][sup].SmoothData :=AGV;
//            end;
//
//
//            inc(S_C);
//            if S_C >900  then    break;
//
//       until (TD[Dao][sup].SmoothData > 0 ) ;
//
//        if S_C >900  then    break;
//
//        if TD[Dao][sup].SmoothData>0  then begin
//           ArPt[i].pt.X:=Dao;
//           ArPt[i].pt.Y:=sup;
//           ArPt[i].DataV:=TD[Dao][sup].SmoothData;
//        end;
//
//   end;
//
//   if S_C> 900 then  begin
//      TD[pt.x][pt.y].SmoothData:= AGV;
//   end else begin
//      ArPt[4].pt := pt;
//      ArPt[4]:=Inverse_Distance_Powe(ArPt[4],ArPt[0],ArPt[1],ArPt[2],ArPt[3]);
//      TD[pt.x][pt.y].SmoothData:=ArPt[4].DataV;
//   end;

//end;

procedure TForm_ThreeZCyl.SecondJinchiChange(Sender: TObject);
begin
  JinChi_Label.Caption:='当前进尺:'+IntTostr(SecondJinchi.Position)+'米';

end;

function TForm_ThreeZCyl.SelectMinDisPoint(var SePoint: array of TSelectPoint;
  P0: TPoint):TPoint;
var
  i:integer;
  Minid:integer;
  dis:double;
begin
    dis:=10000000;Minid:=-1;
    for I := 0 to High(SePoint) do   begin
      if SePoint[i].Select then   continue;
      if dis > sqrt(sqr(SePoint[i].pt.x-p0.x)+sqr(SePoint[i].pt.Y -p0.Y)) then begin
         dis := sqrt(sqr(SePoint[i].pt.x-p0.x)+sqr(SePoint[i].pt.Y -p0.Y));
         Minid:=i;
      end;

    end;

    if Minid>=0 then  begin
       SePoint[Minid].Select:=true;
       Result:=SePoint[Minid].pt;
    end else begin
       Result:=SePoint[0].pt ;
    end;


end;

procedure TForm_ThreeZCyl.SetArrowMark(Jinchi: double; GM_S,GS_S: TTowerSeries);
var
  i,j,CenterX,CenterY:integer;
  temp,hight:integer;
  ust:TTowerSeries;
begin
   if Jinchi > (Graph_x-LeftBlank-rightBlank) div 2 then   begin
      CenterX:=Graph_x-rightBlank-trunc(Jinchi/2);
      hight:=4;
      ust:= GS_S;
   end else  begin
      CenterX:=LeftBlank +trunc((Graph_x-LeftBlank-rightBlank-Jinchi)/2) +1;
      hight:=3;
      ust:= GM_S;
   end;

   CenterY:=BottomBlank +trunc(((Graph_z-BottomBlank-TopBlank) div 2 -mid_Coal  div 2)/2) ;

   for I := CenterX-5 to CenterX+5 do
       for j := CenterY-2 to CenterY+2 do begin
          temp:=ust.AddXYZ(i,hight,j);
          ust.ValueColor[temp]:=clREd;
       end;

   temp:=ust.AddXYZ(CenterX-7,hight,CenterY);
          ust.ValueColor[temp]:=clREd;
   temp:=ust.AddXYZ(CenterX-6,hight,CenterY-1);
          ust.ValueColor[temp]:=clREd;
   temp:=ust.AddXYZ(CenterX-6,hight,CenterY);
          ust.ValueColor[temp]:=clREd;
    temp:=ust.AddXYZ(CenterX-6,hight,CenterY+1);
          ust.ValueColor[temp]:=clREd;
    temp:=ust.AddXYZ(CenterX-5,hight,CenterY-3);
          ust.ValueColor[temp]:=clREd;
    temp:=ust.AddXYZ(CenterX-5,hight,CenterY+3);
          ust.ValueColor[temp]:=clREd;
    temp:=ust.AddXYZ(CenterX-4,hight,CenterY-3);
          ust.ValueColor[temp]:=clREd;
    temp:=ust.AddXYZ(CenterX-4,hight,CenterY+3);
          ust.ValueColor[temp]:=clREd;
     temp:=ust.AddXYZ(CenterX-4,hight,CenterY-4);
          ust.ValueColor[temp]:=clREd;
    temp:=ust.AddXYZ(CenterX-4,hight,CenterY+4);
          ust.ValueColor[temp]:=clREd;

end;

procedure TForm_ThreeZCyl.SetChartAxisMaxAndMinValue(BottomAxis: TChartAxis;
  MaxV, MinV: double);
begin
  BottomAxis.Automatic :=False;
  BottomAxis.Minimum :=0;
  if MaxV <10 then    BottomAxis.Maximum:=10
         else   BottomAxis.Maximum := MaxV;
  if MinV< MaxV then  begin
     BottomAxis.Minimum :=MinV;
  end;
end;

procedure TForm_ThreeZCyl.SetFromWidthAndHeigth(flag: integer);
begin
   if Flag=1  then  begin
      BorderStyle:=BsSizeable;
      StatusBar1.Visible :=False;
      WindowState:=wsNormal;
   end else   begin
      BorderStyle:=BsSizeable;
      StatusBar1.Visible :=true;
      WindowState:= wsNormal;
   end;

  ShowScreen:=flag;
  Show;
  RefreshChartGraph;
end;

function TForm_ThreeZCyl.SetMarkLabelVisible(Value: Boolean): Boolean;
var
  i:integer;
begin
   for I := 0 to graphChart.SeriesCount -1 do
      if graphChart.Series[i] is TPoint3DSeries then
         graphChart.Series[i].Marks.Visible :=Value;

end;

procedure TForm_ThreeZCyl.SetSelectPointIsFalse(
  SePoint: array of TSelectPoint);
var
  i:integer;
begin
   for I := 0 to High(SePoint) do
       SePoint[i].Select:=False;
end;

procedure TForm_ThreeZCyl.setSeriesLevelColor(Max_V, Min_V: Double);
begin
    ZCYL_Series.UseColorRange :=False;
    ZCYL_Series.UsePalette :=true;
    ZCYL_Series.PaletteStyle :=psRainbow;
    ZCYL_Series.PaletteSteps:=32;
    //
    ZCYL_Series.SideBrush.Clear ;
    if ShowScreen <>2 then  begin
        ZCYL_Series.SideBrush.Image.Bitmap:=nil;
        ZCYL_Series.SideBrush.BackColor:=ClGreen;
        ZCYL_Series.SideBrush.Color :=ClYellow;
    end;
end;

procedure TForm_ThreeZCyl.SmoothThreeDimPointValue(min_Dao, Max_Dao, Min_Sup,
  Max_Sup: integer);
var
  dao,sup,i,j:integer;
//  tmpStep:TOldOneStep;
  AryPt:Array [0..4] of TSmotherThreePoint;
  iPt:TSmotherThreePoint;
  SelectPoint:Array [0..7] of TSelectPoint ;
  AGV_Data,tmpV,Upper_Bl,ce:Double;
  tmPoint:Tpoint;
begin
    //清理原来的数据
//    AGV_Data:=DW_ThreeDim.Auto_Judge_OldStep.Whole_AGV_Data;
//    ce:=0.3;
//    for Dao := min_Dao to Max_Dao do    begin
//        DW_ThreeDim.MyContourDoubleGrid[Dao][Min_Sup].SmoothData:= AGV_Data*(0.95+0.1*sin((Dao mod 40)/20*3.1415926));
//        DW_ThreeDim.MyContourDoubleGrid[Dao][Max_Sup].SmoothData:= AGV_Data;
//        for sup := Min_Sup to Max_Sup do  begin
//            if sup > Min_Sup then
//               DW_ThreeDim.MyContourDoubleGrid[min_Dao][sup].SmoothData:= AGV_Data;
//            DW_ThreeDim.MyContourDoubleGrid[Max_Dao][sup].SmoothData:= AGV_Data;
//            if DW_ThreeDim.MyContourDoubleGrid[Dao][Sup].ContoursideData >10 then begin
//               DW_ThreeDim.MyContourDoubleGrid[Dao][Sup].SmoothData:=AGV_Data*0.95;
//            end else begin
//               DW_ThreeDim.MyContourDoubleGrid[Dao][Sup].SmoothData:=-1;
//            end;
//
//        end;
//    end;
//
//   DW_ThreeDim.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,true,100,100);
//   for I :=0 to  High(DW_ThreeDim.Auto_Judge_OldStep.ExSteps) do   begin
//       DW_ThreeDim.StepProcegressBar(FirstPGBar,SecondPGBar,10,0);
//       tmpStep:=DW_ThreeDim.Auto_Judge_OldStep.ExSteps[i];
//       if tmpStep.ModifyData >=8 then   begin
//          AryPt[0].pt.x:=tmpStep.OneStepInfo.MaxData_Dao;
//          AryPt[0].pt.y:=tmpStep.OneStepInfo.MaxData_Sup;
//          AryPt[0].DataV:=tmpStep.OneStepInfo.AGVDAta;
//          //------------
//          Whole_MaxValue:=max(Whole_MaxValue,tmpStep.OneStepInfo.AGVDAta);
//          //------------
//          for j := 0 to 7 do  begin
//              SelectPoint[j].pt:=tmpStep.MyOutLinePoint[j].Point;
//              SelectPoint[j].Select:=False;
//              DW_ThreeDim.MyContourDoubleGrid[tmpStep.MyOutLinePoint[j].Point.x]
//                    [tmpStep.MyOutLinePoint[j].Point.y].SmoothData:=
//                      AGV_Data+abs((tmpStep.OneStepInfo.AGVDAta-AGV_Data)/3);;
//          end;
//
//          for Dao := tmpStep.OneStepInfo.StartDao to tmpStep.OneStepInfo.EndDao do
//            for sup := tmpStep.OneStepInfo.StartSup to tmpStep.OneStepInfo.EndSup do begin
//                DW_ThreeDim.StepProcegressBar(FirstPGBar,SecondPGBar,0,5);
//                if DW_ThreeDim.MyContourDoubleGrid[Dao][Sup].SmoothData >0  then  continue;
//                iPt.pt.X :=Dao;
//                iPt.pt.Y :=Sup;
//                iPt.DataV:=-1;
//                if not tmpStep.IsPtInOutLine(iPt.pt) then continue;
//                SetSelectPointIsFalse(SelectPoint);
//                for j := 1 to 3 do begin
//                   AryPt[j].pt:=SelectMinDisPoint(SelectPoint,iPt.pt);
//                   AryPt[j].DataV:=AGV_Data+abs((tmpStep.OneStepInfo.AGVDAta-AGV_Data)/3);
//                end;
//                iPt:=Inverse_Distance_Powe(ipt,AryPt[0],AryPt[1],AryPt[2],AryPt[3]);
//                if ipt.DataV > 0 then
//                   DW_ThreeDim.MyContourDoubleGrid[Dao][Sup].SmoothData:=ipt.DataV;
//            end;
//       end;
//   end;
//   // 填充最小的值
//   Upper_Bl:=AGV_Data*ce/(Whole_MaxValue- AGV_Data) ;
//   Upper_Bl:=1;
//   for Dao := min_Dao to Max_Dao do
//        for sup := Min_Sup to Max_Sup do   begin
//           DW_ThreeDim.StepProcegressBar(FirstPGBar,SecondPGBar,0,1);
//           if DW_ThreeDim.MyContourDoubleGrid[Dao][Sup].SmoothData > AGV_Data then  begin
//              DW_ThreeDim.MyContourDoubleGrid[Dao][Sup].SmoothData:=AGV_Data+
//                    (DW_ThreeDim.MyContourDoubleGrid[Dao][Sup].SmoothData- AGV_Data)* Upper_Bl;
//           end ;
//        end;
//  // 填充其他的数值
//  for Dao := min_Dao to Max_Dao do
//        for sup := Min_Sup to Max_Sup do   begin
//            if DW_ThreeDim.MyContourDoubleGrid[Dao][Sup].SmoothData < 0 then begin
//               tmPoint.X :=Dao;tmPoint.Y :=Sup;
//               selectFromFourFangxiang(DW_ThreeDim.MyContourDoubleGrid,tmPoint,AGV_Data,
//                      min_Dao, Max_Dao, Min_Sup, Max_Sup);
//            end;
//        end;
//     //--------------------------------------------
//  // 图形立柱
//  if AGV_Data-(Whole_MaxValue- AGV_Data)*2 >1 then  begin
//     DW_ThreeDim.MyContourDoubleGrid[Max_Dao][Max_Sup].SmoothData:=AGV_Data-(Whole_MaxValue- AGV_Data)*2 ;
//  end else begin
//     DW_ThreeDim.MyContourDoubleGrid[Max_Dao][Max_Sup].SmoothData:=1;
//  end;
//
//
//
//   loadData:=true;
//   DW_ThreeDim.SetProcegressBarVisual(Panel_ProcessBar,FirstPGBar,SecondPGBar,False ,0,0);
end;


function TForm_ThreeZCyl.Split_Get_ZCYl(Sout: String):TZcylRec;
 var
    s_temp:Str_DT_array;
    C1:integer;
    ZRec:TZcylRec;
begin
    s_temp:=Public_Basic.split(Sout,';',C1);
    if C1>=4 then  begin
        ZRec.K1:=Public_Basic.StrToDouble_Lu(s_temp[0]);
        ZRec.S0:=Public_Basic.StrToDouble_Lu(s_temp[1]);
        ZRec.k2:=Public_Basic.StrToDouble_Lu(s_temp[2]);
        ZRec.S1:=Public_Basic.StrToDouble_Lu(s_temp[3]);
        ZRec.SX:=Public_Basic.StrToDouble_Lu(s_temp[4]);
    end else begin
        ZRec.K1:=0.8;
        ZRec.S0:=1;
        ZRec.k2:=2.5;
        ZRec.S1:=4;
        ZRec.SX:=20;
    end;

    Result:= ZRec;
end;

procedure TForm_ThreeZCyl.TB_TiGaoClick(Sender: TObject);
begin
  if  Val_D<6 then  begin
      Val_D:=Val_D+2;
  end else begin
      Val_D:=2;
  end;
  LoadZCYLThreeDimData(Basic_Line,Val_D);
   RefreshChartGraph;
end;

procedure TForm_ThreeZCyl.ToolButton1Click(Sender: TObject);
begin
   SavePictureDialog1.Execute ;

end;

procedure TForm_ThreeZCyl.ToolButton2Click(Sender: TObject);
begin
   Second_Jinchi:= SecondJinchi.Position;
   LoadZCYLThreeDimData(Basic_Line,Val_D);
   RefreshChartGraph;
end;

function TForm_ThreeZCyl.ZCYL_Norm2(xi: integer; s1, sx, k2: double): double;
begin
    Result:=k2-(k2-1)*sqr(xi-s1)/sqr(sx-s1);
end;

function TForm_ThreeZCyl.ZCYL_Norm3(xi: integer; s0, s1, k2,
  k0: double): double;
begin
   Result:=k2-(k2-k0)*sqr(s1-xi)/sqr(s1-s0);
end;

function TForm_ThreeZCyl.ZCYL_Norm4(xi: integer; s0, s1, k1,
  k0: double): double;
begin
   Result:=k1-(k1-k0)*sqr(xi-s0/2)/sqr(s0/2);
end;

procedure TForm_ThreeZCyl.AddVertAxes(Chart: Tchart);
begin
    Chart.CustomAxes.Add;
    Chart.CustomAxes.Items[Chart.CustomAxes.Count-1].StartPosition := 0;
    Chart.CustomAxes.Items[Chart.CustomAxes.Count-1].EndPosition :=50;
    Chart.CustomAxes.Items[Chart.CustomAxes.Count-1].Title.Caption:='支承压力曲面';
    Chart.CustomAxes.Items[Chart.CustomAxes.Count-1].Title.Position  :=tpCenter ;
   // Chart.CustomAxes.Items[Chart.CustomAxes.Count-1].Labels:=False;

    Chart.CustomAxes.Add;
    Chart.CustomAxes.Items[Chart.CustomAxes.Count-1].StartPosition := 90;
    Chart.CustomAxes.Items[Chart.CustomAxes.Count-1].EndPosition :=100;

    ZCYL_Series.CustomVertAxis:= Chart.CustomAxes.Items[0] ;
    GS_Series.CustomVertAxis:= Chart.CustomAxes.Items[1] ;
    GZm_Series.CustomVertAxis :=Chart.CustomAxes.Items[1] ;

end;

procedure TForm_ThreeZCyl.But_ChangFillColorClick(Sender: TObject);
begin
   {psPale, psStrong, psGrayScale, psInvGray, psRainbow}
    inc(tmpIni);
    if tmpIni=1  then begin
      ZCYL_Series.PaletteStyle :=psPale;
      ZCYL_Series.PaletteSteps:=32;
    end else   if tmpIni=2  then begin
      ZCYL_Series.PaletteStyle :=psStrong;
      ZCYL_Series.PaletteSteps:=32;
    end else   if tmpIni=3  then begin
      ZCYL_Series.PaletteStyle :=psGrayScale;
      ZCYL_Series.PaletteSteps:=32;
    end else   if tmpIni=4  then begin
      ZCYL_Series.PaletteStyle :=psInvGray;
      ZCYL_Series.PaletteSteps:=32;
    end else   if tmpIni=5  then begin
      ZCYL_Series.PaletteStyle :=psRainbow;
      ZCYL_Series.PaletteSteps:=32;
      tmpIni:=0;
    end;
    ZCYL_Series.RefreshSeries;
end;

end.
