unit EX_Grid_Serice;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,PStope_WorKFace,PStope_Immediate,PStope_SupportClass,
  Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls ;

type
  pDrawZKT =^TZKTRecord;
  TZKTRecord=packed record
     Y_total_T :double;     //��Y �������ָ߶�
     Y_total_H :double;     //  �� ����ͼ�θ߶�
     TitleText :Widestring; //����
     Pointxy   :Array [0..3] of TPoint; //  ������״ͼͼʱ���������
     TableH    :Integer; //��ͷ�߶�
     textHtemp :double;     // �����Ҳ�����ʱ����ʱ����
     YLPoint   :Array [0..3] of Tpoint; // ��������ʱ���������
     Yc_Xiabiao:integer;// ����һ���Ҳ������ʾ
     Yl_Name_bl,Yl_Text_bl:double;//    �������������ַ�����
     Yl_name_count,Yl_Text_count:integer;// ������ʾ������
     Stop_H:Integer;   //������߶���ֹ

     ZtPoint :Array [0..3] of Tpoint;//֮�����������
     HanziHeight:Integer;//���ֵ���С�߶�
     X_Image_Bl,Y_Image_Bl:double;   //��ͼ�ı���
     X_Text_Bl,Y_Text_Bl:double;     //���ֵı���
     TopBlank,BottomBlank: integer;  //ͼƬ���µĿհ�
     LeftBlank,RightBlank:integer;   // ͼƬ���ҵĿհ�
     ZhuZhuangtu_Wid:Integer; //  ָ����״ͼ�Ŀ���
     Yc_End_Nu :integer; //   ������һ���Ҳ�ı��


     //�Ա���׵Ļ���
     NQ_count,Bj_Count:integer; //
     Dep_k,Step_k:integer;  //��ʱ����

  end;

  TEX_Grid_From = class(TForm)
    StringGrid1: TStringGrid;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    
     t_Gzm:TG_Stope;     //������
     t_zk:Tzk_bore;     //���
     t_imm_r:TImmediate_roof; //ֱ�Ӷ�
     t_old:Told_roof;    //�϶�
     t_ZhiJia:TZJ_Class;  //֧��

     pDF:pDrawZKT;
     Zk_Total_H:double;

     procedure SetBasicClass;
     //workFaceInfo
     procedure InitWorkFaceGrid(Grid1:TStringGrid);
     procedure FillWorkFaceBasicInfo(Grid1:TStringGrid);
    //ZkYc
     procedure InitYcZkGrid(Grid1:TStringGrid);
     procedure FillZkYcDrillInfo(Grid1:TStringGrid);
     // DrawZhuzhuangTu
     procedure InitImage(Image1:Timage);
     procedure DrawTitleandTable(Image:Timage);
     procedure DrawZhuZhuangTu(Image:Timage);
     procedure FillYCBmp(Image:Timage;Ycid:integer);
      // ����DPI��ʾ
     procedure WMDpiChanged(var Message: TMessage); message WM_DPICHANGED;

  public
    { Public declarations }
     //��乤���������Ϣ
     procedure FillWorkFaceInfo(Grid1:TStringGrid);
     procedure DrawZk_Image(image1:TImage);
     procedure FillZkYc(Grid1:TStringGrid);
  end;

var
  EX_Grid_From: TEX_Grid_From;

function CreateEx_Grid_Class(ACaption:string;Wid,Hig,Flag:integer):integer;stdcall;

implementation

{$R *.dfm}

uses Main_PStope, Lu_Public_BasicModual;
function CreateEx_Grid_Class(ACaption:string;Wid,Hig,Flag:integer):integer;stdcall;

begin
    if Assigned(EX_Grid_From) then   FreeAndNil(EX_Grid_From);

    EX_Grid_From:=TEX_Grid_From.Create(nil);
    try
        with EX_Grid_From do  begin
//            Caption:=ACaption;
//            WindowState:= wsNormal;
//            ParentWindow:=Ahandle;
//            if Hig >Height then
//               Top :=Round((Hig-Height)/2)
//            else  Top :=0;
//            if Wid> Width then
//               Left:=Round((Wid-Width)/2)
//            else  Left:=0;
            if Flag=1 then  Show ;


        end;
        Result:=1;//����ֵ
    except
        FreeAndNil(EX_Grid_From);
    end;
end;

{ TEX_Grid_From }


procedure TEX_Grid_From.DrawTitleandTable(Image: Timage);
begin
    //ָ����״ͼ�Ŀ���
    pDF.ZhuZhuangtu_Wid:=Image.Width-pDF.LeftBlank -pDF.RightBlank -180;
    // //д����
    Image.Canvas.Font.Size := 8;
    Image.Canvas.TextOut(pDF.LeftBlank+30,round(Image.Height/30) div 2,pDF.TitleText);
   //����ͷ
     Image.Canvas.MoveTo(pDF.LeftBlank,pDF.TopBlank-pDF.TableH);
     Image.Canvas.LineTo(pDF.LeftBlank+160,pDF.TopBlank-pDF.TableH);
     Image.Canvas.MoveTo(pDF.LeftBlank,pDF.TopBlank);
     Image.Canvas.LineTo(pDF.LeftBlank+160,pDF.TopBlank);
     // ����
     Image.Canvas.MoveTo(pDF.LeftBlank,pDF.TopBlank-pDF.TableH);
     Image.Canvas.LineTo(pDF.LeftBlank,pDF.TopBlank);
     Image.Canvas.MoveTo(pDF.LeftBlank+25,pDF.TopBlank-pDF.TableH);
     Image.Canvas.LineTo(pDF.LeftBlank+25,pDF.TopBlank );
     Image.Canvas.MoveTo(pDF.LeftBlank+80,pDF.TopBlank-pDF.TableH);
     Image.Canvas.LineTo(pDF.LeftBlank+80,pDF.TopBlank );
     Image.Canvas.MoveTo(pDF.LeftBlank+120,pDF.TopBlank-pDF.TableH);
     Image.Canvas.LineTo(pDF.LeftBlank+120,pDF.TopBlank );
     Image.Canvas.MoveTo(pDF.LeftBlank+160,pDF.TopBlank-pDF.TableH);
     Image.Canvas.LineTo(pDF.LeftBlank+160,pDF.TopBlank );

     //===�Ҳ�����

     Image.Canvas.Font.Size := 8;
     Image.Canvas.TextOut(pDF.LeftBlank+2,pDF.TopBlank-pDF.HanziHeight,'���');
     Image.Canvas.TextOut(pDF.LeftBlank+27,pDF.TopBlank-pDF.HanziHeight,'�Ҳ�����');
     Image.Canvas.TextOut(pDF.LeftBlank+82,pDF.TopBlank-pDF.HanziHeight,'�ۼ�(m)');
     Image.Canvas.TextOut(pDF.LeftBlank+122,pDF.TopBlank-pDF.HanziHeight,'���(m)');
     //д�Ҳ���


end;

procedure TEX_Grid_From.DrawZhuZhuangTu(Image: Timage);
var
  i:integer;
begin
   PDF.Y_total_H:=0 ;
   PDF.Y_total_T:=0;
   PDF.Pointxy[0].X :=PDF.LeftBlank+180;
   PDF.Pointxy[0].Y :=PDF.TopBlank-PDF.TableH;

   PDF.Pointxy[1].X := PDF.Pointxy[0].X+PDF.ZhuZhuangtu_wid;
   PDF.Pointxy[1].Y := PDF.Pointxy[0].Y;
   //��һ��б��
  Image.Canvas.MoveTo(pDF.LeftBlank+160,PDF.TopBlank);
  Image.Canvas.LineTo(pDF.LeftBlank+180,PDF.TopBlank-PDF.TableH);
  Zk_Total_H:=0;
   for I := 0 to t_zk.Zk_Yc_Count-1 do  begin
       FillYCBmp(Image,i);
       PDF.Pointxy[0].X :=PDF.Pointxy[3].x;
       PDF.Pointxy[0].Y :=PDF.Pointxy[3].Y;
       PDF.Pointxy[1].X :=PDF.Pointxy[2].x;
       PDF.Pointxy[1].Y :=PDF.Pointxy[2].Y;
   end;


end;

procedure TEX_Grid_From.DrawZk_Image(image1: TImage);
begin
    InitImage(image1);
    DrawTitleandTable(Image1);
    DrawZhuZhuangTu(Image1);
end;

procedure TEX_Grid_From.FillWorkFaceBasicInfo(Grid1: TStringGrid);
var
   Rowi:integer;
   vRect:    TRect;
begin
      Rowi:=1; //1
      Grid1.Cells[0,Rowi]:='����������';
      Grid1.Cells[1,Rowi]:=t_Gzm.S_Name;
      inc(Rowi); //2
      Grid1.Cells[0,Rowi]:='��������';
      Grid1.Cells[1,Rowi]:=t_Gzm.S_No;
      inc(Rowi);  //3
      Grid1.Cells[0,Rowi]:='����ú��';
      Grid1.Cells[1,Rowi]:=t_Gzm.S_mc_name;
//      inc(Rowi);  //4
//      Grid1.Cells[0,Rowi]:='��ú��ʽ';
//      Grid1.Cells[1,Rowi]:=public_Basic.Get_workFace_Cmff(t_Gzm.s_c) ;
      inc(Rowi);  //5
      Grid1.Cells[0,Rowi]:='���ɸ߶�(m)';
      Grid1.Cells[1,Rowi]:=FormatFloat('0.00',t_Gzm.S_Cg_h);
      inc(Rowi);  //6
      Grid1.Cells[0,Rowi]:='��ú�߶�(m)';
      Grid1.Cells[1,Rowi]:=FormatFloat('0.00',t_Gzm.S_Fm_h);
      inc(Rowi);  //7
      Grid1.Cells[0,Rowi]:='���(��)';
      Grid1.Cells[1,Rowi]:=FormatFloat('0.00',t_Gzm.S_qj);
      inc(Rowi);  //8
      Grid1.Cells[0,Rowi]:='������(m)';
      Grid1.Cells[1,Rowi]:=FormatFloat('0.00',t_Gzm.S_mcsd_h);
      inc(Rowi);  //9
      Grid1.Cells[0,Rowi]:='��б��(m)';
      Grid1.Cells[1,Rowi]:=FormatFloat('0.00',t_Gzm.S_L_qx);
      inc(Rowi); //10
      Grid1.Cells[0,Rowi]:='����(m)';
      Grid1.Cells[1,Rowi]:=FormatFloat('0.00',t_Gzm.S_Sx_zx);
      inc(Rowi);  //11
      Grid1.Cells[0,Rowi]:='�ۼƽ���(m)';
      Grid1.Cells[1,Rowi]:=FormatFloat('0.00',t_Gzm.S_Jc_L);
      inc(Rowi); //12
      Grid1.Cells[0,Rowi]:='����ϵ��';
      Grid1.Cells[1,Rowi]:=public_Basic.Get_workFace_Coal_F(round(t_Gzm.S_f_PS)) ;

      inc(Rowi);  //13
      Grid1.Cells[0,Rowi]:='ú��Ħ����';
      Grid1.Cells[1,Rowi]:=FormatFloat('0.00',t_Gzm.S_M_mcj);
      inc(Rowi);  //14
      Grid1.Cells[0,Rowi]:='���ɱ�';
      Grid1.Cells[1,Rowi]:=FormatFloat('0.00',t_Gzm.S_Bsb);
      inc(Rowi);  //15
      Grid1.Cells[0,Rowi]:='��б��б';
      Grid1.Cells[1,Rowi]:=public_Basic.Get_workFace_YxFx(t_Gzm.Dz_yxfx);
      inc(Rowi);  //16
      Grid1.Cells[0,Rowi]:='���Һ��';
      Grid1.Cells[1,Rowi]:=public_Basic.Get_workFace_JYHD(t_Gzm.Dz_JYHD);
      inc(Rowi);  //17
      Grid1.Cells[0,Rowi]:='���ʹ���';
      Grid1.Cells[1,Rowi]:=public_Basic.Get_workFace_Cmff(t_Gzm.Dz_DCGZ);
      inc(Rowi);  //18
      Grid1.Cells[0,Rowi]:='��˹����';
      Grid1.Cells[1,Rowi]:=public_Basic.Get_workFace_WSFC(t_Gzm.Dz_WSFC);
      inc(Rowi);  //19
      Grid1.Cells[0,Rowi]:='���庬ˮ';
      Grid1.Cells[1,Rowi]:=public_Basic.Get_workFace_TopWater(t_Gzm.Dz_TopWater);
      inc(Rowi);  //20
      Grid1.Cells[0,Rowi]:='�װ庬ˮ';
      Grid1.Cells[1,Rowi]:=public_Basic.Get_workFace_BottomWater(t_Gzm.Dz_BottomWater);
      inc(Rowi);  //21
      Grid1.Cells[0,Rowi]:='ˮƽӦ��';
      Grid1.Cells[1,Rowi]:=public_Basic.Get_workFace_HangDao_Stress(t_Gzm.Dz_HeoStress);
      inc(Rowi);  //22
      Grid1.Cells[0,Rowi]:='��ѹ����';
      Grid1.Cells[1,Rowi]:=public_Basic.Get_workFace_RockPress(t_Gzm.Dz_Kyxx);
      inc(Rowi);  //23
      Grid1.Cells[0,Rowi]:='���֧��';
      Grid1.Cells[1,Rowi]:=public_Basic.Get_workFace_HangDao_support(t_Gzm.Dz_HangDaoSup);
      inc(Rowi);  //24
      Grid1.Cells[0,Rowi]:='���ƽ��ٶ�(m)';
      Grid1.Cells[1,Rowi]:=FormatFloat('0.00',t_Gzm.S_DayStep_speed);


end;

procedure TEX_Grid_From.FillWorkFaceInfo(Grid1: TStringGrid);
begin
   InitWorkFaceGrid(Grid1);
   FillWorkFaceBasicInfo(Grid1);
end;

procedure TEX_Grid_From.FillYCBmp(Image: Timage; Ycid: integer);
var
 bmap1:Tbitmap;//����λͼ bitmap1
 tmpTextTop:double;
 TextY:integer;
begin
   bmap1:=Tbitmap.Create;//����λͼ bitmap1

   PDF.Y_total_H:=PDF.Y_total_H+t_zk.Yc_Rock[Ycid].R_h;
   tmpTextTop:=PDF.Y_total_T;
   PDF.Y_total_T:=PDF.Y_total_T+PDF.HanziHeight+t_zk.Yc_Rock[Ycid].R_h*PDF.Y_Text_Bl;
   PDF.Pointxy[2].X :=PDF.Pointxy[1].X ;
   PDF.Pointxy[2].Y :=PDF.TopBlank-Pdf.TableH+Trunc(PDF.Y_total_H*PDF.Y_Image_BL);
   PDF.Pointxy[3].X :=PDF.Pointxy[0].X ;
   PDF.Pointxy[3].Y :=PDF.Pointxy[2].Y ;
   //���Ҳ������Ҳ����ƽ��������
     if PDF.Y_Text_Bl>0  then begin
        TextY:=pDF.TopBlank+TRUNC(tmpTextTop + t_zk.Yc_Rock[Ycid].R_h*PDF.Y_Text_Bl /2 )+1;
     end else begin
        TextY:=pDF.TopBlank+TRUNC(tmpTextTop)+1;
     end;

    Image.Canvas.TextOut(pDF.LeftBlank+2,TextY,IntTostr(Ycid+1));
    Image.Canvas.TextOut(pDF.LeftBlank+27,TextY,t_zk.Yc_Rock[Ycid].R_Name);
    Image.Canvas.TextOut(pDF.LeftBlank+82,TextY,FormatFloat('0.0',t_zk.Yc_Rock[Ycid].R_h));
    Zk_Total_H:=Zk_Total_H+t_zk.Yc_Rock[Ycid].R_h;
    Image.Canvas.TextOut(pDF.LeftBlank+122,TextY,FormatFloat('0.0',Zk_Total_H));
    // ������
    Image.Canvas.MoveTo(pDF.LeftBlank,trunc(pDF.TopBlank+tmpTextTop));
    Image.Canvas.LineTo(pDF.LeftBlank,trunc(pDF.TopBlank+PDF.Y_total_T));
    Image.Canvas.MoveTo(pDF.LeftBlank+25,trunc(pDF.TopBlank+tmpTextTop));
    Image.Canvas.LineTo(pDF.LeftBlank+25,trunc(pDF.TopBlank+PDF.Y_total_T));
    Image.Canvas.MoveTo(pDF.LeftBlank+80,trunc(pDF.TopBlank+tmpTextTop));
    Image.Canvas.LineTo(pDF.LeftBlank+80,trunc(pDF.TopBlank+PDF.Y_total_T));
    Image.Canvas.MoveTo(pDF.LeftBlank+120,trunc(pDF.TopBlank+tmpTextTop));
    Image.Canvas.LineTo(pDF.LeftBlank+120,trunc(pDF.TopBlank+PDF.Y_total_T));
    Image.Canvas.MoveTo(pDF.LeftBlank+160,trunc(pDF.TopBlank+tmpTextTop));
    Image.Canvas.LineTo(pDF.LeftBlank+160,trunc(pDF.TopBlank+PDF.Y_total_T));

    // ������
    Image.Canvas.MoveTo(pDF.LeftBlank,trunc(pDF.TopBlank+PDF.Y_total_T));
    Image.Canvas.LineTo(pDF.LeftBlank+160,trunc(pDF.TopBlank+PDF.Y_total_T));
    //��б��
    Image.Canvas.LineTo(pDF.LeftBlank+180,PDF.Pointxy[3].y);

   Image.Canvas.Brush.Bitmap:=nil;
   //����Ҳ��ͼ��

   if t_zk.Yc_Rock[Ycid].BmpFile <>'' then begin
       ExPstopeClass.MySqliteTable.GetBMPToSQlite(t_zk.Yc_Rock[Ycid].BmpFile+'.Bmp','1',bmap1);
       Image.Canvas.Polygon(PDF.Pointxy) ;
       Image.Canvas.Brush.Bitmap:=bmap1;
       if   (PDF.Pointxy[2].Y-PDF.Pointxy[1].Y>2)  then
            Image.Canvas.FloodFill(Trunc((PDF.Pointxy[0].X+PDF.Pointxy[1].X)/2),
                      Trunc((PDF.Pointxy[1].Y+PDF.Pointxy[2].Y)/2),clBlack,fsBorder);
       Image.Canvas.Brush.Bitmap:=nil;
   end;

   FreeAndNil(bmap1);

end;

procedure TEX_Grid_From.FillZkYc(Grid1:TStringGrid);
begin
   InitYcZkGrid( Grid1);
   FillZkYcDrillInfo(Grid1);
end;

procedure TEX_Grid_From.FillZkYcDrillInfo(Grid1: TStringGrid);
var
  i,Rowi:integer;
  TotalS:double;
begin
   Rowi:=1; TotalS:=0;
   for i := 0 to t_zk.Zk_Yc_Count-1 do  begin
       Grid1.Cells[0,Rowi]:=IntToStr(i+1);
       Grid1.Cells[1,Rowi]:=t_zk.Yc_Rock[i].R_Name;
       Grid1.Cells[2,Rowi]:=FormatFloat('0.00',t_zk.Yc_Rock[i].R_h);
       TotalS:=TotalS+t_zk.Yc_Rock[i].R_h;
       Grid1.Cells[3,Rowi]:=FormatFloat('0.00',TotalS);
       Inc(Rowi);
       if Grid1.RowCount< Rowi+2 then
          Grid1.RowCount:=Rowi+2 ;
   end;

end;

procedure TEX_Grid_From.FormCreate(Sender: TObject);
begin
   SetBasicClass;
end;

procedure TEX_Grid_From.InitImage(Image1: Timage);
var
  i:integer;
begin
   //Clear
   Image1.Picture.Graphic:=nil;
   Image1.Canvas.Refresh;
   Image1.Canvas.FillRect(Image1.ClientRect);
   // init
   if Assigned(Pdf) then     Dispose(pDF);
   new(pDf);
   //�հױ߽��ʼ��
   pDF.TopBlank:=round(Image1.Height/30)+30 ;
   pDF.BottomBlank:=round(Image1.Height/30);
   pDF.LeftBlank:=round(Image1.Width/60);
   pDF.RightBlank:=round(Image1.Width/60);
   pDF.TableH:=20;
   pDF.HanziHeight:=15;
   pDF.TitleText:='��'+t_zk.Zk_name+'�������״ͼ';
   // �������
   pDF.Y_total_H:=0;
   for I:=0 to t_zk.Zk_Yc_Count-1 do
          pDF.Y_total_H:=pDF.Y_total_H+t_zk.Yc_Rock[i].R_h;

   if Image1.Height-pDF.TopBlank-pDF.BottomBlank-(t_zk.Zk_Yc_Count-1)*pDF.HanziHeight >0  then   begin
       pDF.Y_Text_Bl:=(Image1.Height-pDF.TopBlank-pDF.BottomBlank-
                         (t_zk.Zk_Yc_Count-1)*pDF.HanziHeight)/pDF.Y_total_H;
   end else begin
       pDF.Y_Text_Bl:=0;
       pDF.HanziHeight:= trunc((Image1.Height-pDF.TopBlank-pDF.BottomBlank)/ (t_zk.Zk_Yc_Count-1) );
   end;




   pDF.Y_Image_BL:=(Image1.Height-pDF.TopBlank-pDF.BottomBlank+pDF.TableH)/pDF.Y_total_H;


end;

procedure TEX_Grid_From.InitWorkFaceGrid(Grid1: TStringGrid);
begin
     //��ʼ������stringgrid
    Grid1.ColCount :=2;
    Grid1.RowCount :=24;

    Grid1.FixedCols:=0;
    Grid1.FixedRows:=1;
    Grid1.DefaultRowHeight:=18;
    Grid1.ColWidths[0]:=90;
    Grid1.ColWidths[1]:=trunc(Grid1.Width)-120;

    Grid1.Canvas.Font.Size:=8;
    Grid1.Cells[0,0]:='����';
    Grid1.Cells[1,0]:='ȡֵ';


end;

procedure TEX_Grid_From.InitYcZkGrid(Grid1: TStringGrid);
begin
    //��ʼ���Ҳ�stringgrid
    Grid1.ColCount :=4;
    Grid1.RowCount :=10;

    Grid1.FixedCols:=0;
    Grid1.FixedRows:=1;
    Grid1.DefaultRowHeight:=18;
    Grid1.ColWidths[0]:=25;
    Grid1.ColWidths[1]:=75;
    Grid1.ColWidths[2]:=(trunc(Grid1.Width)-130) div 2;
    Grid1.ColWidths[3]:=(trunc(Grid1.Width)-130) div 2;

    Grid1.Canvas.Font.Size:=8;
    Grid1.Cells[0,0]:='���';
    Grid1.Cells[1,0]:='�Ҳ�����';
    Grid1.Cells[2,0]:='���(m)';
    Grid1.Cells[3,0]:='�ۼ�(m)';


end;

procedure TEX_Grid_From.SetBasicClass;
begin
   t_Gzm:=ExPstopeClass.Ex_Gzm ;
   t_zk:=ExPstopeClass.Ex_zk ;
   t_imm_r:=ExPstopeClass.Ex_imm_r ;
   t_old:=ExPstopeClass.Ex_old ;
   t_zhijia:=ExPstopeClass.Ex_ZhiJia ;
end;

procedure TEX_Grid_From.WMDpiChanged(var Message: TMessage);
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

end.