unit DataCurve;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  ExtCtrls;

type
  TCurveinfo=record
    color:Tcolor;
    width:byte;
    data:double;
    id:integer;
  end;
  TArryCur=array of Tcurveinfo;
  TDataCurve=class(Tthread)
  private
    { Private declarations }
    Curpos:integer;
    BMP:Tbitmap;
    c_w,c_h:integer;
    DataList: array of array of double;
    //Curveinfo:array of TCurveinfo;
    MoveLen:integer;
    Gridsize:integer;
    Sleeptime:integer;  //��ͣʱ��
    dotN:integer;
    bl_Resert:boolean; //���¿�ʼ

    FImg:TImage;
    Ftimer:TTimer;
    FBgColor,FGridColor:Tcolor; //������������ɫ
    FGridN:byte;                //�����ܶ�(����MoveLen һ������)
    FGridHide:boolean;          //�Ƿ���������
    FCurveNum:byte;             //��������
    FTimeRange:integer;         //������ʾ��ʱ�䷶Χ(��λ��)
    FSpeed:single;                //����ˢ���ٶ�(ÿ����ٴΣ� Ƶ��)�Ӷ����������MoveLen
    FVmax,FVmin:double;         //���߻�ͼ��������ֵ����Сֵ

    FPause:boolean;  //��ͣ
  protected
    function TransY(Y:double):integer;
    function YTrans(Y:integer):double;
    procedure Execute; override;
  public
    { Public declarations }
    Curveinfo:array of TCurveinfo;
    //�ɶ�д����
    property  Image:Timage read Fimg write Fimg;
    property  BgColor:TColor read FBgColor write FBgColor default clBlack;
    property  GridColor:TColor read FGridColor write FGridColor default clteal;
    property  GridN:byte read FGridN write FGridN default 5;
    property  Gridhide:boolean read Fgridhide write fgridhide default false;
    property  TimeRange:integer read FTimeRange write FTimeRange;
    property  Speed:single read FSpeed write FSpeed;
    property  Vmax:double read FVmax write FVmax;
    property  Vmin:double read FVmin write FVmin;
    property  Pause:boolean read FPause write FPause;
    property  Timer:TTimer read Ftimer write Ftimer;
    //ֻ������
    property  CurveNum:byte read FCurveNum default 12;

    //����
    Constructor Create(Image:Timage;tim:ttimer);
    procedure ClearAll;
//    procedure ReSize(iHeight,iWidth:Integer);
    procedure DrawGrid;
    procedure DrawLine(startX,startY,endX,endY:Integer);
    procedure AddCurve(NewCurve:TCurveinfo);
    procedure DelCurve(index:byte);
    procedure SetValue(value:double;index:integer);
    procedure Resert;
    procedure DrawCoor;
  end;
 {  �������ݴ�������  datalist[DataDot][CurveIndex] }

const  bdw=15;
implementation
function TdataCurve.TransY(Y:double):integer;
begin
    if Y>FVmax then
      result:=c_h
    else if Y<FVmin  then
      result:=0
    else begin
      result:=round(((y-FVmin)/(FVmax-FVmin))*c_h);
    end;
end;
function TdataCurve.YTrans(Y:integer):double;
begin
    if Y>c_h then
      result:=FVmax
    else if Y<0  then
      result:=FVmin
    else begin
      result:=(y/c_h)*(FVmax-FVmin);
    end;
end;
//��ʼ����������
Procedure TDataCurve.Resert;
var
  i:Integer;
begin
  bl_resert:=false;
  if FSpeed>20 then FSpeed:=20;//ˢ��Ƶ�ʲ���̫�ߣ�������20��������
  MoveLen:=round(c_w/(FTimeRange * FSpeed));
  if movelen<1 then movelen:=1;
  GridSize:=MoveLen*FGridN;
  Sleeptime:=round(1000/FSpeed)-3;

  dotN:=round(c_w/movelen)+1;
  datalist:=nil;
  Setlength(DataList,dotN); //���ݴ���Ķ�ά����
  for i:=low(datalist) to high(datalist) do
  begin
    setlength(datalist[i],FcurveNum);
  end;

  for i:=0 to FcurveNum-1 do
  begin
    datalist[dotN-1][i]:=0.00;
  end;
  FPause:=false;
end;

//����
Constructor TdataCurve.Create(Image:Timage;tim:ttimer);
var
  i:integer;
begin
  Inherited Create(false);
  FImg:=image;
  BMP:=Tbitmap.Create;
  bmp.PixelFormat:= pf24bit	;
  bmp.Height := image.Height;
  bmp.Width := image.Width;
  c_w:=bmp.Width-bdw;
  c_h:=bmp.Height-bdw;

  //������ʼ��
  FCurveNum:=1;            //��������
  Ftimerange:=c_w;
  FVmax:=c_h;
  FVmin:=0;
  Fbgcolor:=clblack;
  FGridcolor:=clTeal;
  FGridN:=5;
  FSpeed:=10;
  curpos:=0;
  Setlength(Curveinfo,255);//�ɻ����������
  for i:=low(curveinfo) to high(curveinfo) do
  begin
      curveinfo[i].color:=clred;
      curveinfo[i].width:=1;
      curveinfo[i].data:=10.01;
  end;
  FPause:=false;
end;


//ִ��
Procedure TDataCurve.Execute;
var
  i,j:Integer;
begin

  self.Resert;
  While not Terminated do
  begin
    if FPause then Continue;
    if Bl_Resert then self.Resert;
    self.ClearAll;
    if not fgridhide then self.DrawGrid;

    for i:=low(datalist[0]) to high(datalist[0]) do
    begin
      bmp.Canvas.Pen.Color:=curveinfo[i].color;
      bmp.Canvas.Pen.Width:=curveinfo[i].width;
      For j := 0 To DotN-2 do
      begin
        DrawLine(j*moveLen,c_h-transY(datalist[j][i]),(j+1)*movelen,c_h-transY(datalist[j+1][i]));
        datalist[j][i] := datalist[j+1][i];
      end;

      bmp.Canvas.Font.Color:=curveinfo[i].color;
      bmp.Canvas.Brush.Color:=Fbgcolor;
      bmp.Canvas.Font.Size:=5;
      bmp.Canvas.TextOut(c_w-33,c_h-transY(datalist[dotN-1][i])-15,floattostr(datalist[dotN-1][i]));
    end;
    for i:=0 to FcurveNum-1 do
    begin
      datalist[dotN-1][i]:=curveinfo[i].data;
    end;

    DrawCoor;

    Fimg.Picture.Bitmap:=bmp;
    getlasterror;
    sleep(sleeptime);
  end;

  If Assigned(Bmp) then  Bmp.Free;
end;

// ��ֵ
procedure Tdatacurve.SetValue(value:double;index:integer);
begin
  curveinfo[index].data:=value;
end;

//����һ������
procedure Tdatacurve.AddCurve(NewCurve:TCurveinfo);
var
  i:integer;
begin
  inc(FCurvenum);
  for i:=low(datalist) to high(datalist) do
  begin
    setlength(datalist[i],FcurveNum);
  end;
  Curveinfo[Fcurvenum-1]:=NewCurve;
  bl_resert:=true;
end;


//ɾ��һ������
procedure Tdatacurve.DelCurve(index:byte);
var
  i:integer;
begin
  if index>=FCurveNum then exit;
  dec(FCurvenum);
  for i:=low(datalist) to high(datalist) do
  begin
    setlength(datalist[i],FcurveNum);
  end;
  for i:=index to FCurveNum-1 do
  begin
    Curveinfo[i]:=curveinfo[i+1];
  end;
  bl_resert:=true;
end;


//�������ͼ
procedure TDatacurve.ClearAll;
var
  i,w:integer;
begin
  bmp.Canvas.Pen.Color:=Fbgcolor;
  bmp.Canvas.Pen.Width:=1;
  w:=bmp.Width;
  for i:= 0 to bmp.Height do
  begin
    bmp.Canvas.MoveTo(0,i);
    bmp.Canvas.LineTo(w,i);
  end;
end;


//��������
procedure TDatacurve.DrawGrid;
var
  i:integer;
begin
  bmp.Canvas.Pen.Color:=fgridcolor;
  bmp.Canvas.Pen.Width:=1;
  for i:=0 to c_h do
  begin
    if (i mod Gridsize)=0 then
    begin
      bmp.Canvas.MoveTo(0,c_h-i);
      bmp.canvas.LineTo(c_w,c_h-i);
    end;
  end;
  for i := 0 To c_w do
  begin
    If (i mod gridsize)=0 then
    begin
      bmp.Canvas.MoveTo(i-CurPos,0);
      bmp.canvas.LineTo(i-CurPos,c_h);
    end;
  end;
  CurPos:=Curpos + movelen;
  If CurPos>=Gridsize then CurPos := 0;
end;


//��ֱ��
procedure Tdatacurve.DrawLine(startX, startY, endX, endY: Integer);
begin
  bmp.Canvas.MoveTo(startX,startY);
  bmp.Canvas.LineTo(endx,endY);
end;

//������
procedure Tdatacurve.DrawCoor;
begin
  bmp.Canvas.Pen.Width:=2;
  bmp.Canvas.Pen.Color:=clyellow;
  bmp.Canvas.MoveTo(0,c_h+1);
  bmp.Canvas.LineTo(c_w+1,c_h+1);
  bmp.Canvas.LineTo(c_w+1,0);

  bmp.Canvas.Font.Size:=5;
  bmp.Canvas.Font.Color:=clyellow;
  bmp.Canvas.Brush.Color:=FBgcolor;

  bmp.Canvas.TextOut(c_w-5,c_h+2,' 0s');
  bmp.Canvas.TextOut(0,c_h+2,'-'+floattostr(Ftimerange)+'s');
  bmp.Canvas.TextOut(c_w div 2-100,c_h+2,'ʱ���ᣨ���񳤶�Ϊ��' + inttostr(round(1000*FGridN/FSpeed))+' ���룩');

  bmp.Canvas.TextOut(c_w-15,c_h-15,floattostr(FVmin));
  bmp.Canvas.TextOut(c_w-15,0,floattostr(FVmax));
end;

end.