unit UFormZhijia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, ComCtrls,Jpeg,PngImage,StrUtils,
  math;

type
  TFormZhiJia = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    SaveDialog1: TSaveDialog;
    BitBtn2: TBitBtn;
    Panel3: TPanel;
    Panel4: TPanel;
    PageControl1: TPageControl;
    TabSheetDz: TTabSheet;
    TabSheetZj: TTabSheet;
    StringGridDZ: TStringGrid;
    StringGridZJ: TStringGrid;
    Panel5: TPanel;
    Panel6: TPanel;
    Button1: TButton;
    Button2: TButton;
    PageControl2: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ImageZT: TImage;
    ComboZtjx: TComboBox;
    Label12: TLabel;
    Panel7: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Combojx: TComboBox;
    ComboDl: TComboBox;
    ComboDz: TComboBox;
    ComboSlg: TComboBox;
    ComboTy: TComboBox;
    ComboFm: TComboBox;
    ComboWLqjD: TComboBox;
    ComboChb: TComboBox;
    ComboCt: TComboBox;
    ComboDt: TComboBox;
    ComboQl: TComboBox;
    Panel2: TPanel;
    Label1: TLabel;
    Image1: TImage;
    PanelZoom: TPanel;
    ImageZoom: TImage;
    TabSheetFY: TTabSheet;
    StringGridFy: TStringGrid;
    BitBtn3: TBitBtn;
    Button3: TButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TabSet1Change(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure ComboBox1Change(Sender: TObject);
    procedure StringGridDZSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboZtjxChange(Sender: TObject);
    procedure ComboDlChange(Sender: TObject);
    procedure ComboDzChange(Sender: TObject);
    procedure ComboSlgChange(Sender: TObject);
    procedure ComboTyChange(Sender: TObject);
    procedure ComboFmChange(Sender: TObject);
    procedure ComboWLqjDChange(Sender: TObject);
    procedure ComboChbChange(Sender: TObject);
    procedure ComboCtChange(Sender: TObject);
    procedure ComboDtChange(Sender: TObject);
    procedure ComboQlChange(Sender: TObject);
    procedure ImageZoomDblClick(Sender: TObject);
    procedure CombojxChange(Sender: TObject);
    procedure StringGridFySelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGridZJSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    ComboDz_psxs_12,ComboDz_cmfs_4,ComboDz_yxfx_16,ComboDz_jyhd,ComboDz_dcgz,ComboDz_WsFc : TComboBox;
    ComboDz_TopWater,ComboDz_BottomWater,ComboDz_HeoStress,ComboDz_kyxx,ComboDz_HangDaoSup :TComboBox;
    ComBo_YlJg,Combo_nYLc,Combo_ckq,combo_imm_leibie,combo_old_leibie,combo_diban_leibie,combo_fdm_leibie:TComboBox;
     //岩梁结构 与 内外应力场  上方是否存在采空区  直接顶  老顶  底板  冒放性 类别 
    IndexC:integer;
    ModuleName,dllPath:Widestring;   //控件的绝对路径
    Image1TopBlank,Image1LeftBlank,imagespace: integer;  //图片上下的空白
    ImageArry:Array [0..12] of  TImage;  //12Image 控件
    ComBo_Click_Count:integer; //记录点击的combo的标号
    Leiji_Jinchi:double;
    png:TPngObject;
    Procedure initGzmDCGrid(Sender:TObject);
    Procedure initzjGrid(Sender:TObject);
    procedure initFyydGrid(Sender:TObject);
    procedure Combo_Gzm_psxs_12(Sender:TObject) ;
    procedure Combo_Gzm_cmfs_4(Sender:TObject) ;
    procedure Combo_Gzm_yxfx_16(Sender:TObject) ;

    procedure Combo_Gzm_jyhd(Sender:TObject) ;
    procedure Combo_Gzm_dcgz(Sender:TObject) ;
    procedure Combo_Gzm_wsfc(Sender:TObject) ;

    procedure Combo_Gzm_TopWater(Sender:TObject) ;
    procedure Combo_Gzm_BottomWater(Sender:TObject) ;
    procedure Combo_Gzm_HeoStress(Sender:TObject) ;
    procedure Combo_Gzm_kyxx(Sender:TObject) ;
    procedure Combo_Gzm_HangDaoSup(Sender:TObject) ;
    procedure ComBo_YlJg_Fy_1(Sender:Tobject);
    procedure ComBo_Nyl_Fy_2(Sender:Tobject);
    //
    procedure IntImage1();
    //imageArray click event
    procedure ImageArryClick(Sender: TObject);
    procedure InitZjjbcs(Sender: TObject);
    procedure Edit_Cs(Sender:Tobject); //修订参数

   

  public
    { Public declarations }
     Mc_FdBs: double;
  end;



 function ShowZhiJia_inn(AHandle:THandle;ACaption:string;FullOrBf:integer):integer;stdcall;

implementation




{$R *.dfm}
  function ShowZhiJia_inn(AHandle:THandle;ACaption:string;FullOrBf:integer):integer;stdcall;
  var
       FormZhiJia: TFormZhiJia;
   begin
        Application.Handle:=Ahandle;

        FormZhiJia:=TFormZhiJia.Create(Application);

        try
        FormZhiJia.Caption:=ACaption;

        if FullOrBf=1 then  begin
           FormZhiJia.Panel1.Visible:=false;
           FormZhiJia.Panel7.Visible:=false;
           FormZhiJia.PageControl2.Visible :=false;
           FormZhiJia.Width :=FormZhiJia.Panel5.Width+10;
        end;
        FormZhiJia.WindowState:= wsNormal;
        FormZhiJia.ParentWindow:=Ahandle;
        
        //以模式窗体形式显示窗体
        FormZhiJia.Show;


        Result:=1;//函数值
        except
        FormZhiJia.Free;
     end;
     end;
 //============
procedure TFormZhiJia.BitBtn1Click(Sender: TObject);
begin
     self.SaveDialog1.Execute();
    // self.Image1.Picture.SaveToFile(self.SaveDialog1.FileName);
end;
//====
procedure TFormZhiJia.ComboBox1Change(Sender: TObject);
begin
   //  ShowMessage('OK');
end;

procedure TFormZhiJia.ComboChbChange(Sender: TObject);
Var
  ImgName:WideString;
begin
    ComBo_Click_Count:=7;
    if ComboChb.ItemIndex=0 then  begin
        ImgName:='QC1';
      end else  begin
        ImgName:='QC2';
     end;
    png.LoadFromFile(dllPath+'\ZJBmp\'+ImgName+'.PNG');
    ImageArry[ComBo_Click_Count].Picture.Bitmap.Assign(png);
end;

procedure TFormZhiJia.ComboCtChange(Sender: TObject);
Var
  ImgName:WideString;
begin
    ComBo_Click_Count:=8;
    if ComboCt.ItemIndex=0 then  begin
        ImgName:='CT1';
     end else  if ComboCt.ItemIndex=1 then  begin
        ImgName:='CT2';
     end else  begin
        ImgName:='CT3';
     end;
    png.LoadFromFile(dllPath+'\ZJBmp\'+ImgName+'.PNG');
    ImageArry[ComBo_Click_Count].Picture.Bitmap.Assign(png);
end;

procedure TFormZhiJia.ComboDlChange(Sender: TObject);
Var
  ImgName:WideString;
begin
    ComBo_Click_Count:=1;
    if ComboDl.ItemIndex=0 then  begin
        ImgName:='DL1';
     end else  if ComboDl.ItemIndex=1 then  begin
        ImgName:='DL2';
     end else  if ComboDl.ItemIndex=2then  begin
        ImgName:='DL3';
     end else  begin
        ImgName:='DL4';
     end;
    png.LoadFromFile(dllPath+'\ZJBmp\'+ImgName+'.PNG');
    ImageArry[ComBo_Click_Count].Picture.Bitmap.Assign(png);
end;

procedure TFormZhiJia.ComboDtChange(Sender: TObject);
Var
  ImgName:WideString;
begin
    ComBo_Click_Count:=9;
    if ComboDt.ItemIndex=0 then  begin
        ImgName:='DT1';
      end else  begin
        ImgName:='Dt2';
     end;
    png.LoadFromFile(dllPath+'\ZJBmp\'+ImgName+'.PNG');
    ImageArry[ComBo_Click_Count].Picture.Bitmap.Assign(png);
end;

procedure TFormZhiJia.ComboDzChange(Sender: TObject);
Var
  ImgName:WideString;
begin
    ComBo_Click_Count:=2;
    if ComboDZ.ItemIndex=0 then  begin
        ImgName:='DZ1';
     end else  if ComboDZ.ItemIndex=1 then  begin
        ImgName:='DZ2';
     end else  if ComboDZ.ItemIndex=2 then  begin
        ImgName:='DZ3';
     end else  if ComboDZ.ItemIndex=3 then  begin
        ImgName:='DZ4';
     end else  begin
        ImgName:='DZ5';
     end;
    png.LoadFromFile(dllPath+'\ZJBmp\'+ImgName+'.PNG');
    ImageArry[ComBo_Click_Count].Picture.Bitmap.Assign(png);
end;

procedure TFormZhiJia.ComboFmChange(Sender: TObject);
Var
  ImgName:WideString;
begin
    ComBo_Click_Count:=5;
    if ComboFM.ItemIndex=0 then  begin
        ImgName:='FM1';
     end else  if ComboFM.ItemIndex=1 then  begin
        ImgName:='FM2';
     end else  begin
        ImgName:='FM3';
     end;
    png.LoadFromFile(dllPath+'\ZJBmp\'+ImgName+'.PNG');
    ImageArry[ComBo_Click_Count].Picture.Bitmap.Assign(png);
end;


procedure TFormZhiJia.CombojxChange(Sender: TObject);
Var
  ImgName:WideString;
begin
    ComBo_Click_Count:=0;
    if Combojx.ItemIndex=0 then  begin
        ImgName:='JX1';
     end else  if Combojx.ItemIndex=1 then  begin
        ImgName:='JX2';
     end else  if Combojx.ItemIndex=2then  begin
        ImgName:='JX3';
     end else  begin
        ImgName:='JX4';
     end;
    png.LoadFromFile(dllPath+'\ZJBmp\'+ImgName+'.PNG');
    ImageArry[ComBo_Click_Count].Picture.Bitmap.Assign(png);
end;

procedure TFormZhiJia.ComboQlChange(Sender: TObject);
Var
  ImgName:WideString;
begin
    ComBo_Click_Count:=10;
    if ComboQl.ItemIndex=0 then  begin
        ImgName:='Ql1';
      end else  begin
        ImgName:='Ql2';
     end;
    png.LoadFromFile(dllPath+'\ZJBmp\'+ImgName+'.PNG');
    ImageArry[ComBo_Click_Count].Picture.Bitmap.Assign(png);
end;

procedure TFormZhiJia.ComboSlgChange(Sender: TObject);
Var
  ImgName:WideString;
begin
    ComBo_Click_Count:=3;
    if Comboslg.ItemIndex=0 then  begin
        ImgName:='LG1';
     end else  if Comboslg.ItemIndex=1 then  begin
        ImgName:='LG2';
     end else  if Comboslg.ItemIndex=2then  begin
        ImgName:='LG3';
     end else  begin
        ImgName:='LG4';
     end;
    png.LoadFromFile(dllPath+'\ZJBmp\'+ImgName+'.PNG');
    ImageArry[ComBo_Click_Count].Picture.Bitmap.Assign(png);
end;

procedure TFormZhiJia.ComboTyChange(Sender: TObject);
Var
  ImgName:WideString;
begin
    ComBo_Click_Count:=4;
    if ComboTy.ItemIndex=0 then  begin
        ImgName:='TY1';
     end else  if ComboTy.ItemIndex=1 then  begin
        ImgName:='TY2';
     end else  begin
        ImgName:='Ty3';
     end;
    png.LoadFromFile(dllPath+'\ZJBmp\'+ImgName+'.PNG');
    ImageArry[ComBo_Click_Count].Picture.Bitmap.Assign(png);
end;

procedure TFormZhiJia.ComboWLqjDChange(Sender: TObject);
Var
  ImgName:WideString;
begin
    ComBo_Click_Count:=6;
    if ComboWlqjd.ItemIndex=0 then  begin
        ImgName:='Wl1';
    end else  begin
        ImgName:='Wl2';
     end;
    png.LoadFromFile(dllPath+'\ZJBmp\'+ImgName+'.PNG');
    ImageArry[ComBo_Click_Count].Picture.Bitmap.Assign(png);
end;


procedure TFormZhiJia.ComboZtjxChange(Sender: TObject);
var
    jpg: TJPEGImage; // 要use Jpeg单元
begin
       jpg := TJPEGImage.Create;
       self.Panel2.Caption:= ComboZtjx.Text;
   case self.ComboZtjx.ItemIndex of
      0:  begin
           png.LoadFromFile(dllPath+'\ZJBmp\111.PNG');
           self.ImageZT.Picture.Bitmap.Assign(PNG);    // 因为 img 控件是基于bmp的
          end;
      1:  begin
           png.LoadFromFile(dllPath+'\ZJBmp\112.PNG');
           self.ImageZT.Picture.Bitmap.Assign(PNG);    // 因为 img 控件是基于bmp的
          end;
      2:  begin
           png.LoadFromFile(dllPath+'\ZJBmp\121.PNG');
           self.ImageZT.Picture.Bitmap.Assign(PNG);    // 因为 img 控件是基于bmp的
          end;
      3:  begin
           png.LoadFromFile(dllPath+'\ZJBmp\122.PNG');
           self.ImageZT.Picture.Bitmap.Assign(PNG);    // 因为 img 控件是基于bmp的
          end;
      4:  begin
           png.LoadFromFile(dllPath+'\ZJBmp\211.PNG');
           self.ImageZT.Picture.Bitmap.Assign(PNG);    // 因为 img 控件是基于bmp的
          end;
      5:  begin
           png.LoadFromFile(dllPath+'\ZJBmp\212.PNG');
           self.ImageZT.Picture.Bitmap.Assign(PNG);    // 因为 img 控件是基于bmp的
          end;
      6:  begin
           png.LoadFromFile(dllPath+'\ZJBmp\221.PNG');
           self.ImageZT.Picture.Bitmap.Assign(PNG);    // 因为 img 控件是基于bmp的
          end;
      7:  begin
           png.LoadFromFile(dllPath+'\ZJBmp\222.PNG');
           self.ImageZT.Picture.Bitmap.Assign(PNG);    // 因为 img 控件是基于bmp的
          end;

      8:  begin
           png.LoadFromFile(dllPath+'\ZJBmp\JX3.PNG');
           self.ImageZT.Picture.Bitmap.Assign(PNG);    // 因为 img 控件是基于bmp的
          end;
      9:  begin
           png.LoadFromFile(dllPath+'\ZJBmp\JX4.PNG');
           self.ImageZT.Picture.Bitmap.Assign(PNG);    // 因为 img 控件是基于bmp的
          end;




      11:  begin
           jpg.LoadFromFile(dllPath+'\ZJBmp\22131_3.jpg');
           self.ImageZT.Picture.Bitmap.Assign(jpg);    // 因为 img 控件是基于bmp的
          end;
      12:  begin
           jpg.LoadFromFile(dllPath+'\ZJBmp\22231_2.9.jpg');
           self.ImageZT.Picture.Bitmap.Assign(jpg);    // 因为 img 控件是基于bmp的
          end;
      13:  begin
           jpg.LoadFromFile(dllPath+'\ZJBmp\22232_6.3.jpg');
           self.ImageZT.Picture.Bitmap.Assign(jpg);    // 因为 img 控件是基于bmp的
          end;
      14:  begin
           jpg.LoadFromFile(dllPath+'\ZJBmp\22231_3.8.jpg');
           self.ImageZT.Picture.Bitmap.Assign(jpg);    // 因为 img 控件是基于bmp的
          end;
      15:  begin
           jpg.LoadFromFile(dllPath+'\ZJBmp\42121_3.jpg');
           self.ImageZT.Picture.Bitmap.Assign(jpg);    // 因为 img 控件是基于bmp的
          end;
      16:  begin
           jpg.LoadFromFile(dllPath+'\ZJBmp\42141_3.5.jpg');
           self.ImageZT.Picture.Bitmap.Assign(jpg);    // 因为 img 控件是基于bmp的
          end;
      17:  begin
           jpg.LoadFromFile(dllPath+'\ZJBmp\42131_4.2.jpg');
           self.ImageZT.Picture.Bitmap.Assign(jpg);    // 因为 img 控件是基于bmp的
          end;
      18:  begin
           jpg.LoadFromFile(dllPath+'\ZJBmp\41210.jpg');
           self.ImageZT.Picture.Bitmap.Assign(jpg);    // 因为 img 控件是基于bmp的
          end;
      19:  begin
           jpg.LoadFromFile(dllPath+'\ZJBmp\43241_4.2.jpg');
           self.ImageZT.Picture.Bitmap.Assign(jpg);    // 因为 img 控件是基于bmp的
          end;
      20:  begin
           jpg.LoadFromFile(dllPath+'\ZJBmp\43231_4.jpg');
           self.ImageZT.Picture.Bitmap.Assign(jpg);    // 因为 img 控件是基于bmp的
          end;
      21:  begin
           jpg.LoadFromFile(dllPath+'\ZJBmp\43232_5.jpg');
           self.ImageZT.Picture.Bitmap.Assign(jpg);    // 因为 img 控件是基于bmp的
          end;


   end;
      jpg.Free;
end;
//   初始化支架基本参数
 procedure TFormZhiJia.InitZjjbcs(Sender: TObject);
  begin
//    //---
//      if length(Trim(P_Stope.t_ZhiJia.JG_jx))=0 then begin
//          self.Combojx.ItemIndex:=0;
//       end else begin
//          self.Combojx.ItemIndex:=StrToInt(RightStr(Trim(P_Stope.t_ZhiJia.JG_jx),1))-1;
//       end;
//          self.Combojx.OnChange(Sender);
//     //----
//     if length(Trim(P_Stope.t_ZhiJia.JG_Dl))=0 then begin
//        self.ComboDl.ItemIndex:=0;
//     end else begin
//        self.ComboDl.ItemIndex:=StrToInt(RightStr(Trim(P_Stope.t_ZhiJia.JG_Dl),1))-1;
//     end;
//       //激发cobobox
//       self.ComboDl.OnChange(Sender);
//    //----
//     if length(Trim(P_Stope.t_ZhiJia.JG_Dz))=0 then begin
//        self.ComboDz.ItemIndex:=0;
//     end else begin
//        self.ComboDz.ItemIndex:=StrToInt(RightStr(Trim(P_Stope.t_ZhiJia.JG_Dz),1))-1;
//     end;
//     //激发cobobox
//       self.ComboDz.OnChange(Sender);
//    //
//    if length(Trim(P_Stope.t_ZhiJia.JG_slg))=0 then begin
//        self.ComboSlg.ItemIndex:=0;
//     end else begin
//        self.ComboSlg.ItemIndex:=StrToInt(RightStr(Trim(P_Stope.t_ZhiJia.JG_slg),1))-1;
//     end;
//     //激发cobobox
//       self.ComboSlg.OnChange(Sender);
//     //
//      if length(Trim(P_Stope.t_ZhiJia.JG_ty))=0 then begin
//        self.ComboTy.ItemIndex:=0;
//     end else begin
//        self.ComboTy.ItemIndex:=StrToInt(RightStr(Trim(P_Stope.t_ZhiJia.JG_ty),1))-1;
//     end;
//     //激发cobobox
//       self.ComboTy.OnChange(Sender);
//     //
//     if length(Trim(P_Stope.t_ZhiJia.JG_Fm))=0 then begin
//        self.ComboFm.ItemIndex:=0;
//     end else begin
//        self.ComboFm.ItemIndex:=StrToInt(RightStr(Trim(P_Stope.t_ZhiJia.JG_Fm),1))-1;
//     end;
//     //激发cobobox
//       self.ComboFm.OnChange(Sender);
//     //
//      if length(Trim(P_Stope.t_ZhiJia.JG_Wl))=0 then begin
//        self.ComboWLqjD.ItemIndex:=0;
//     end else begin
//        self.ComboWLqjD.ItemIndex:=StrToInt(RightStr(Trim(P_Stope.t_ZhiJia.JG_Wl),1))-1;
//     end;
//     //激发cobobox
//       self.ComboWLqjD.OnChange(Sender);
//     //
//      if length(Trim(P_Stope.t_ZhiJia.JG_Qc))=0 then begin
//        self.ComboChb.ItemIndex:=0;
//     end else begin
//        self.ComboChb.ItemIndex:=StrToInt(RightStr(Trim(P_Stope.t_ZhiJia.JG_Qc),1))-1;
//     end;
//         //激发cobobox
//       self.ComboChb.OnChange(Sender);
//     //
//      if length(Trim(P_Stope.t_ZhiJia.JG_Ct))=0 then begin
//        self.ComboCt.ItemIndex:=0;
//     end else begin
//        self.ComboCt.ItemIndex:=StrToInt(RightStr(Trim(P_Stope.t_ZhiJia.JG_Ct),1))-1;
//     end;
//       //激发cobobox
//       self.ComboCT.OnChange(Sender);
//     //
//      if length(Trim(P_Stope.t_ZhiJia.JG_Dt))=0 then begin
//        self.ComboDt.ItemIndex:=0;
//     end else begin
//        self.ComboDt.ItemIndex:=StrToInt(RightStr(Trim(P_Stope.t_ZhiJia.JG_Dt),1))-1;
//     end;
//       //激发cobobox
//       self.ComboDt.OnChange(Sender);
//     //
//      if length(Trim(P_Stope.t_ZhiJia.JG_Ql))=0 then begin
//        self.ComboQl.ItemIndex:=0;
//     end else begin
//        self.ComboQl.ItemIndex:=StrToInt(RightStr(Trim(P_Stope.t_ZhiJia.JG_Ql),1))-1;
//     end;
//      //激发cobobox
//       self.ComboQl.OnChange(Sender);
  end;

//
procedure TFormZhiJia.IntImage1();
var
   Pointxy   :Array [0..3] of TPoint; //  绘制柱状图图时的坐标变量
   i,X_sup,Y_sup:integer;

begin

    //汉字
    Image1.Canvas.Font.Size := 8;
    //
    Image1.Canvas.TextOut(Round((Image1.Width-2*Image1LeftBlank)/4*0.5)-30+Image1LeftBlank,Image1TopBlank-10,'架型结构');
    Image1.Canvas.TextOut(Round((Image1.Width-2*Image1LeftBlank)/4*1.5)-30+Image1LeftBlank,Image1TopBlank-10,'顶梁结构');
    Image1.Canvas.TextOut(Round((Image1.Width-2*Image1LeftBlank)/4*2.5)-30+Image1LeftBlank,Image1TopBlank-10,'底座结构');
    Image1.Canvas.TextOut(Round((Image1.Width-2*Image1LeftBlank)/4*3.5)-30+Image1LeftBlank,Image1TopBlank-10,'四连杆结构');
    //
    Image1.Canvas.TextOut(Round((Image1.Width-2*Image1LeftBlank)/4*0.5)-30,Round((Image1.Height-2*Image1TopBlank)/3)*1+Image1TopBlank-10,'推移结构');
    Image1.Canvas.TextOut(Round((Image1.Width-2*Image1LeftBlank)/4*1.5)-30+Image1LeftBlank,Round((Image1.Height-2*Image1TopBlank)/3)*1+Image1TopBlank-10,'放煤结构');
    Image1.Canvas.TextOut(Round((Image1.Width-2*Image1LeftBlank)/4*2.5)-30+Image1LeftBlank,Round((Image1.Height-2*Image1TopBlank)/3)*1+Image1TopBlank-10,'尾梁千斤顶');
    Image1.Canvas.TextOut(Round((Image1.Width-2*Image1LeftBlank)/4*3.5)-30+Image1LeftBlank,Round((Image1.Height-2*Image1TopBlank)/3)*1+Image1TopBlank-10,'前梁尾梁侧护板');
     //
    Image1.Canvas.TextOut(Round((Image1.Width-2*Image1LeftBlank)/4*0.5)-30,Round((Image1.Height-2*Image1TopBlank)/3)*2+Image1TopBlank-10,'侧推结构');
    Image1.Canvas.TextOut(Round((Image1.Width-2*Image1LeftBlank)/4*1.5)-30+Image1LeftBlank,Round((Image1.Height-2*Image1TopBlank)/3)*2+Image1TopBlank-10,'底调结构');
    Image1.Canvas.TextOut(Round((Image1.Width-2*Image1LeftBlank)/4*2.5)-30+Image1LeftBlank,Round((Image1.Height-2*Image1TopBlank)/3)*2+Image1TopBlank-10,'前梁结构');
    //Image1.Canvas.TextOut(Round((Image1.Width-2*Image1LeftBlank)/4*1.5)-30+Image1LeftBlank,Round((Image1.Height-2*Image1TopBlank)/4)*2+Image1TopBlank-10,'四连杆结构');
    //图片

    for I := 0 to 10 do   begin
          X_sup:=i mod 4;
          Y_sup:=trunc (i/4);
          Y_Sup:=Y_sup mod 3 ;
          ImageArry[i].Width := Round((Image1.Width-2*Image1LeftBlank-3*Imagespace)/4);
          ImageArry[i].Height:= Round((Image1.Height-2*Image1TopBlank-2*Imagespace)/3);

          ImageArry[i].Left:=Image1LeftBlank+ X_sup *ImageArry[i].Width + x_sup*ImageSpace;
          ImageArry[i].Top:=Image1TopBlank+Y_sup *ImageArry[i].Height + Y_sup*ImageSpace+10;
          ImageArry[i].Visible :=true;
          png.LoadFromFile(dllPath+'\ZJBmp\Null.PNG');
          ImageArry[i].Picture.Bitmap.Assign(png);
    end;



end;
procedure TFormZhiJia.PageControl2Change(Sender: TObject);
begin

end;

//=====
procedure TFormZhiJia.ImageArryClick(Sender: TObject);
var
  comboIndex:integer;
begin
     comboIndex:=Timage(Sender).Tag;
      self.PanelZoom.Visible :=true;
      ImageZoom.Picture :=ImageArry[comboIndex].Picture;

end;
procedure TFormZhiJia.ImageZoomDblClick(Sender: TObject);
begin
      self.PanelZoom.Visible :=false;
end;

procedure TFormZhiJia.Combo_Gzm_psxs_12(Sender:TObject) ;
begin
   // ShowMessage('OK');

end;
//======
 procedure TFormZhiJia.Combo_Gzm_cmfs_4(Sender:TObject) ;
 begin
     //ShowMessage('4');
 end;
 //------
 procedure TFormZhiJia.Combo_Gzm_yxfx_16(Sender:TObject) ;
 begin

 end;
//=====
 procedure TFormZhiJia.Combo_Gzm_jyhd(Sender:TObject) ;
 begin

 end;
 //========
procedure TFormZhiJia.Combo_Gzm_dcgz(Sender:TObject) ;
begin

end;
//============
procedure TFormZhiJia.Combo_Gzm_wsfc(Sender:TObject) ;
begin

end;
//===================

procedure TFormZhiJia.Combo_Gzm_TopWater(Sender:TObject) ;
begin

end;
//===================
procedure TFormZhiJia.Combo_Gzm_BottomWater(Sender:TObject) ;
begin

end;
//===================
procedure TFormZhiJia.Combo_Gzm_HeoStress(Sender:TObject) ;
begin

end;
//===================
procedure TFormZhiJia.Combo_Gzm_kyxx(Sender:TObject) ;
begin

end;
//===================
procedure TFormZhiJia.Combo_Gzm_HangDaoSup(Sender:TObject) ;
begin

end;
procedure TFormZhiJia.ComBo_YlJg_Fy_1(Sender:Tobject);
begin

end;
procedure TFormZhiJia.ComBo_Nyl_Fy_2(Sender:Tobject);
begin

end;

//===================
procedure TFormZhiJia.initGzmDCGrid(Sender:TObject);
 Var
    I,j :Integer;
    vRect:    TRect;
begin
    //初始化地质stringgrid
    StringGridDZ.ColCount :=4;
    if StringGridDZ.Height/20<33 then begin
        StringGridDZ.RowCount :=33;
    end else begin
        StringGridDZ.RowCount :=trunc(StringGridDZ.Height/20);
    end;

    StringGridDZ.FixedCols:=0;
    StringGridDZ.FixedRows:=1;
    StringGridDZ.DefaultRowHeight:=18;
    StringGridDZ.ColWidths[0]:=30;
    StringGridDZ.ColWidths[1]:=80;
    StringGridDZ.ColWidths[2]:=StringGridDZ.Width-140;
    StringGridDZ.ColWidths[3]:=10;

    StringGridDZ.Canvas.Font.Size:=8;
    StringGridDZ.Cells[0,0]:='序号';
    StringGridDZ.Cells[1,0]:='名称';
    StringGridDZ.Cells[2,0]:='取值';

    StringGridDZ.Cells[1,1]:='工作面基本信息';
      StringGridDZ.Cells[0,2]:='1';
      StringGridDZ.Cells[1,2]:='工作面名称';
      StringGridDZ.Cells[2,2]:=P_Stope.t_Gzm.S_Name;
      StringGridDZ.Cells[0,3]:='2';
      StringGridDZ.Cells[1,3]:='工作面编号';
      StringGridDZ.Cells[2,3]:=P_Stope.t_Gzm.S_No;
      StringGridDZ.Cells[0,4]:='3';
      StringGridDZ.Cells[1,4]:='所在煤层';
      StringGridDZ.Cells[2,4]:=P_Stope.t_Gzm.S_mc_name;
      StringGridDZ.Cells[0,5]:='4';
      StringGridDZ.Cells[1,5]:='采煤方式';
         if ComboDz_cmfs_4=nil then begin
                vRect := StringGridDZ.CellRect(2, 4);
                ComboDz_cmfs_4 := TComboBox.Create(StringGridDZ);
                ComboDz_cmfs_4.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_cmfs_4.BoundsRect := vRect;
                ComboDz_cmfs_4.Color :=clBtnFace;
                ComboDz_cmfs_4.Visible := true;
                ComboDz_cmfs_4.OnClick:=Combo_Gzm_cmfs_4;

                ComboDz_cmfs_4.Style :=csDropDownList;
                ComboDz_cmfs_4.Items.Clear;
                ComboDz_cmfs_4.Items.Add('炮采');// 1	cqcsb	cmfa	1	炮采
                ComboDz_cmfs_4.Items.Add('普采');//    2	cqcsb	cmfa	2	普采
                ComboDz_cmfs_4.Items.Add('综采');//    3	cqcsb	cmfa	3	综采（采全高）
                ComboDz_cmfs_4.Items.Add('放顶煤开采');//    4	cqcsb	cmfa	4	放顶煤开采
                ComboDz_cmfs_4.Items.Add('分层开采上分层');//    5	cqcsb	cmfa	4	分层开采上分层
                ComboDz_cmfs_4.Items.Add('分层开采下分层');//    6	cqcsb	cmfa	4	分层开采上分层
               
                 for I := 0 to ComboDz_cmfs_4.Items.Count - 1 do
                    begin
                       if ComboDz_cmfs_4.Items[i] =Trim(StringReplace(P_Stope.t_Gzm.S_cmfs,#13#10,'',[])) then  begin
                          ComboDz_cmfs_4.ItemIndex:=i;
                          break;
                       end;
                    end;
                 if i>ComboDz_cmfs_4.Items.Count - 1 then  begin
                    if strToInt_lu(P_Stope.t_Gzm.S_cmfs)>0 then begin
                          ComboDz_cmfs_4.ItemIndex:=strToInt_lu(P_Stope.t_Gzm.S_cmfs)-1;
                    end else  begin
                          ComboDz_cmfs_4.ItemIndex:=0;
                    end;
                 end;


         end;
      StringGridDZ.Cells[0,6]:='5';
      StringGridDZ.Cells[1,6]:='开采高度(m)';
      StringGridDZ.Cells[2,6]:=FormatFloat('0.00',P_Stope.t_Gzm.S_Cg_h);
      StringGridDZ.Cells[0,7]:='6';
      StringGridDZ.Cells[1,7]:='放煤高度(m)';
      StringGridDZ.Cells[2,7]:=FormatFloat('0.00',P_Stope.t_Gzm.S_Fm_h);
      StringGridDZ.Cells[0,8]:='7';
      StringGridDZ.Cells[1,8]:='倾角(度)';
      StringGridDZ.Cells[2,8]:=FormatFloat('0.00',P_Stope.t_Gzm.S_qj);
      StringGridDZ.Cells[0,9]:='8';
      StringGridDZ.Cells[1,9]:='埋藏深度(m)';
      StringGridDZ.Cells[2,9]:=FormatFloat('0.00',P_Stope.t_Gzm.S_mcsd_h);
      StringGridDZ.Cells[0,10]:='9';
      StringGridDZ.Cells[1,10]:='倾斜长(m)';
      StringGridDZ.Cells[2,10]:=FormatFloat('0.00',P_Stope.t_Gzm.S_L_qx);
      StringGridDZ.Cells[0,11]:='10';
      StringGridDZ.Cells[1,11]:='走向长(m)';
      StringGridDZ.Cells[2,11]:=FormatFloat('0.00',P_Stope.t_Gzm.S_Sx_zx);
      StringGridDZ.Cells[0,12]:='11';
      StringGridDZ.Cells[1,12]:='累计进尺(m)';
      StringGridDZ.Cells[2,12]:=FormatFloat('0.00',P_Stope.t_Gzm.S_Jc_L);
      StringGridDZ.Cells[0,13]:='12';
      StringGridDZ.Cells[1,13]:='普氏系数';
       if ComboDz_psxs_12=nil then begin
                vRect := StringGridDZ.CellRect(2, 12);
                ComboDz_psxs_12 := TComboBox.Create(StringGridDZ);
                ComboDz_psxs_12.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_psxs_12.BoundsRect := vRect;
                ComboDz_psxs_12.Color :=clBtnFace;
                ComboDz_psxs_12.Visible := true;
                ComboDz_psxs_12.OnClick:=Combo_Gzm_psxs_12;

                ComboDz_psxs_12.Style :=csDropDownList;
                ComboDz_psxs_12.Items.Add('普氏系数0.8以下');// 普氏系数0.8以下
                ComboDz_psxs_12.Items.Add('普氏系数0.8-1.5之间');   // 6	cqcsb	mtyd	2	普氏系数0.8-1.5之间
                ComboDz_psxs_12.Items.Add('普氏系数1.5-2.5之间');   // 7	cqcsb	mtyd	3	普氏系数1.5-2.5之间
                ComboDz_psxs_12.Items.Add('氏系数2.5以上');   // 8	cqcsb	mtyd	4	普氏系数2.5以上1

                   if P_Stope.t_Gzm.S_f_PS =1then begin
                       ComboDz_psxs_12.ItemIndex:=0;
                       P_Stope.t_Gzm.S_M_njl:=10;
                       P_Stope.t_Gzm.S_M_mcj:=20;
                       P_Stope.t_Gzm.S_Bsb:=0.35;
                       P_Stope.t_Gzm.S_K_zcfz:=1.6-0.1*(P_Stope.t_Gzm.S_Cg_h-4);
                   end else if P_Stope.t_Gzm.S_f_PS=2 then begin
                       ComboDz_psxs_12.ItemIndex:=1;
                       P_Stope.t_Gzm.S_M_njl:=30;
                       P_Stope.t_Gzm.S_M_mcj:=25;
                       P_Stope.t_Gzm.S_Bsb:=0.3;
                       P_Stope.t_Gzm.S_K_zcfz:=2.0-0.1*(P_Stope.t_Gzm.S_Cg_h-4);
                   end else if P_Stope.t_Gzm.S_f_PS=3 then begin
                       ComboDz_psxs_12.ItemIndex:=2;
                       P_Stope.t_Gzm.S_M_njl:=50;
                       P_Stope.t_Gzm.S_M_mcj:=30;
                       P_Stope.t_Gzm.S_Bsb:=0.25;
                       P_Stope.t_Gzm.S_K_zcfz:=2.3-0.1*(P_Stope.t_Gzm.S_Cg_h-4);
                   end else begin
                       ComboDz_psxs_12.ItemIndex:=3;
                       P_Stope.t_Gzm.S_M_njl:=100;
                       P_Stope.t_Gzm.S_M_mcj:=35;
                       P_Stope.t_Gzm.S_Bsb:=0.2;
                       P_Stope.t_Gzm.S_K_zcfz:=2.6-0.1*(P_Stope.t_Gzm.S_Cg_h-4);
                   end;

         end;

      StringGridDZ.Cells[0,14]:='13';
      StringGridDZ.Cells[1,14]:='煤内摩擦角';
      StringGridDZ.Cells[2,14]:=FormatFloat('0.00',P_Stope.t_Gzm.S_M_mcj);
      StringGridDZ.Cells[0,15]:='14';
      StringGridDZ.Cells[1,15]:='泊松比';
      StringGridDZ.Cells[2,15]:=FormatFloat('0.00',P_Stope.t_Gzm.S_Bsb);
      StringGridDZ.Cells[0,16]:='15';
      StringGridDZ.Cells[1,16]:='仰斜俯斜';    //ComboDz_yxfx_16
      if ComboDz_yxfx_16=nil then begin
                vRect := StringGridDZ.CellRect(2, 15);
                ComboDz_yxfx_16 := TComboBox.Create(StringGridDZ);
                ComboDz_yxfx_16.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_yxfx_16.BoundsRect := vRect;
                ComboDz_yxfx_16.Color :=clBtnFace;
                ComboDz_yxfx_16.Visible := true;
                ComboDz_yxfx_16.OnClick:=Combo_Gzm_yxfx_16;

                ComboDz_yxfx_16.Style :=csDropDownList;
                ComboDz_yxfx_16.Items.Add('水平推进');// 1	水平推进
                ComboDz_yxfx_16.Items.Add('仰斜推进');
                ComboDz_yxfx_16.Items.Add('俯斜推进');
                 if P_Stope.t_Gzm.Dz_yxfx>0 then begin
                          ComboDz_yxfx_16.ItemIndex:=P_Stope.t_Gzm.Dz_yxfx-1;
                 end else begin
                          ComboDz_yxfx_16.ItemIndex:=0;
                 end;


         end;
      StringGridDZ.Cells[0,17]:='16';
      StringGridDZ.Cells[1,17]:='基岩厚度';    //ComboDz_yxfx_16
      if ComboDz_jyhd=nil then begin
                vRect := StringGridDZ.CellRect(2, 16);
                ComboDz_jyhd := TComboBox.Create(StringGridDZ);
                ComboDz_jyhd.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_jyhd.BoundsRect := vRect;
                ComboDz_jyhd.Color :=clBtnFace;
                ComboDz_jyhd.Visible := true;
                ComboDz_jyhd.OnClick:=Combo_Gzm_jyhd;

                ComboDz_jyhd.Style :=csDropDownList;
                ComboDz_jyhd.Items.Add('薄基岩');// 
                ComboDz_jyhd.Items.Add('一般基岩');
                ComboDz_jyhd.Items.Add('中厚基岩');
                ComboDz_jyhd.Items.Add('巨厚基岩');
                 if P_Stope.t_Gzm.Dz_JYHD>0 then begin
                          ComboDz_jyhd.ItemIndex:=P_Stope.t_Gzm.Dz_JYHD-1;
                 end else begin
                          ComboDz_jyhd.ItemIndex:=0;
                 end;
         end;

      StringGridDZ.Cells[0,18]:='17';
      StringGridDZ.Cells[1,18]:='地质构造';    //ComboDz_yxfx_16
      if ComboDz_DCGZ=nil then begin
                vRect := StringGridDZ.CellRect(2, 17);
                ComboDz_DCGZ := TComboBox.Create(StringGridDZ);
                ComboDz_DCGZ.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_DCGZ.BoundsRect := vRect;
                ComboDz_DCGZ.Color :=clBtnFace;
                ComboDz_DCGZ.Visible := true;
                ComboDz_DCGZ.OnClick:=Combo_Gzm_dcgz;

                ComboDz_DCGZ.Style :=csDropDownList;
                ComboDz_DCGZ.Items.Add('地质构造较少');//
                ComboDz_DCGZ.Items.Add('背斜轴部');
                ComboDz_DCGZ.Items.Add('向斜轴部');
                ComboDz_DCGZ.Items.Add('断层密集，但不影响推进');
                ComboDz_DCGZ.Items.Add('断层密集，影响推进');
                ComboDz_DCGZ.Items.Add('构造极其复杂');
                if P_Stope.t_Gzm.Dz_DCGZ>0 then begin
                          ComboDz_DCGZ.ItemIndex:=(P_Stope.t_Gzm.Dz_DCGZ)-1;
                end else begin
                          ComboDz_DCGZ.ItemIndex:=0;
                 end;
         end;

     StringGridDZ.Cells[0,19]:='18';
     StringGridDZ.Cells[1,19]:='瓦斯含量';    //ComboDz_yxfx_16
      if ComboDz_WSFC=nil then begin
                vRect := StringGridDZ.CellRect(2, 18);
                ComboDz_WSFC := TComboBox.Create(StringGridDZ);
                ComboDz_WSFC.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_WSFC.BoundsRect := vRect;
                ComboDz_WSFC.Color :=clBtnFace;
                ComboDz_WSFC.Visible := true;
                ComboDz_WSFC.OnClick:=Combo_Gzm_WSFC;

                ComboDz_WSFC.Style :=csDropDownList;
                ComboDz_WSFC.Items.Add('瓦斯含量较低');//
                ComboDz_WSFC.Items.Add('低瓦斯，局部超限');
                ComboDz_WSFC.Items.Add('高瓦斯');
                if (P_Stope.t_Gzm.Dz_WSFC)>0 then begin
                          ComboDz_WSFC.ItemIndex:=(P_Stope.t_Gzm.Dz_WSFC)-1;
                end else begin
                          ComboDz_WSFC.ItemIndex:=0;
                 end;
         end;

     StringGridDZ.Cells[0,20]:='19';
     StringGridDZ.Cells[1,20]:='顶板含水';    //ComboDz_yxfx_16
      if ComboDz_TopWater=nil then begin
                vRect := StringGridDZ.CellRect(2, 19);
                ComboDz_TopWater := TComboBox.Create(StringGridDZ);
                ComboDz_TopWater.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_TopWater.BoundsRect := vRect;
                ComboDz_TopWater.Color :=clBtnFace;
                ComboDz_TopWater.Visible := true;
                ComboDz_TopWater.OnClick:=Combo_Gzm_TopWater;

                ComboDz_TopWater.Style :=csDropDownList;
                ComboDz_TopWater.Items.Add('顶板无水');//
                ComboDz_TopWater.Items.Add('含水层距离顶板较近');
                ComboDz_TopWater.Items.Add('含水层距离顶板较远');
                ComboDz_TopWater.Items.Add('曾发生透水事故');
                ComboDz_TopWater.Items.Add('其他');
                if (P_Stope.t_Gzm.Dz_TopWater)>0 then begin
                          ComboDz_TopWater.ItemIndex:=(P_Stope.t_Gzm.Dz_TopWater)-1;
                end else begin
                          ComboDz_TopWater.ItemIndex:=0;
                 end;
         end;

     StringGridDZ.Cells[0,21]:='20';
     StringGridDZ.Cells[1,21]:='底板含水';    //ComboDz_yxfx_16
      if ComboDz_BottomWater=nil then begin
                vRect := StringGridDZ.CellRect(2, 20);
                ComboDz_BottomWater := TComboBox.Create(StringGridDZ);
                ComboDz_BottomWater.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_BottomWater.BoundsRect := vRect;
                ComboDz_BottomWater.Color :=clBtnFace;
                ComboDz_BottomWater.Visible := true;
                ComboDz_BottomWater.OnClick:=Combo_Gzm_BottomWater;

                ComboDz_BottomWater.Style :=csDropDownList;
                ComboDz_BottomWater.Items.Add('底板无水源');//
                ComboDz_BottomWater.Items.Add('底板有水源，较远');
                ComboDz_BottomWater.Items.Add('底板有水源，较近');
                ComboDz_BottomWater.Items.Add('曾发生底板突出事故');
                ComboDz_BottomWater.Items.Add('其他');
                if (P_Stope.t_Gzm.Dz_BottomWater)>0 then begin
                          ComboDz_BottomWater.ItemIndex:=(P_Stope.t_Gzm.Dz_BottomWater)-1;
                end else begin
                          ComboDz_BottomWater.ItemIndex:=0;
                 end;
         end;

     StringGridDZ.Cells[0,22]:='21';
     StringGridDZ.Cells[1,22]:='水平应力';    //ComboDz_yxfx_16
      if ComboDz_HeoStress=nil then begin
                vRect := StringGridDZ.CellRect(2, 21);
                ComboDz_HeoStress := TComboBox.Create(StringGridDZ);
                ComboDz_HeoStress.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_HeoStress.BoundsRect := vRect;
                ComboDz_HeoStress.Color :=clBtnFace;
                ComboDz_HeoStress.Visible := true;
                ComboDz_HeoStress.OnClick:=Combo_Gzm_HeoStress;

                ComboDz_HeoStress.Style :=csDropDownList;
                ComboDz_HeoStress.Items.Add('基本无水平应力');//
                ComboDz_HeoStress.Items.Add('水平应力小于垂直应力');
                ComboDz_HeoStress.Items.Add('水平应力与垂直应力相当');
                ComboDz_HeoStress.Items.Add('水平应力大于垂直应力1.5倍以上');
                if (P_Stope.t_Gzm.Dz_HeoStress)>0 then begin
                          ComboDz_HeoStress.ItemIndex:=(P_Stope.t_Gzm.Dz_HeoStress)-1;
                 end else begin
                          ComboDz_HeoStress.ItemIndex:=0;
                 end;
         end;

     StringGridDZ.Cells[0,23]:='22';
     StringGridDZ.Cells[1,23]:='矿压显现';    //ComboDz_yxfx_16
      if ComboDz_kyxx=nil then begin
                vRect := StringGridDZ.CellRect(2, 22);
                ComboDz_kyxx := TComboBox.Create(StringGridDZ);
                ComboDz_kyxx.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_kyxx.BoundsRect := vRect;
                ComboDz_kyxx.Color :=clBtnFace;
                ComboDz_kyxx.Visible := true;
                ComboDz_kyxx.OnClick:=Combo_Gzm_Kyxx;

                ComboDz_kyxx.Style :=csDropDownList;
                ComboDz_kyxx.Items.Add('矿压显现不明显');
                ComboDz_kyxx.Items.Add('有矿压显现，不影响生产');
                ComboDz_kyxx.Items.Add('矿压显现较剧烈，影响生产');
                ComboDz_kyxx.Items.Add('发生过顶板事故');
                if (P_Stope.t_Gzm.Dz_Kyxx)>0 then begin
                          ComboDz_kyxx.ItemIndex:=(P_Stope.t_Gzm.Dz_Kyxx)-1;
                 end else begin
                          ComboDz_kyxx.ItemIndex:=0;
                 end;
         end;

     StringGridDZ.Cells[0,24]:='23';
     StringGridDZ.Cells[1,24]:='巷道支护';    //ComboDz_yxfx_16
      if ComboDz_HangDaoSup=nil then begin
                vRect := StringGridDZ.CellRect(2, 23);
                ComboDz_HangDaoSup := TComboBox.Create(StringGridDZ);
                ComboDz_HangDaoSup.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_HangDaoSup.BoundsRect := vRect;
                ComboDz_HangDaoSup.Color :=clBtnFace;
                ComboDz_HangDaoSup.Visible := true;
                ComboDz_HangDaoSup.OnClick:=Combo_Gzm_HangDaoSup;

                ComboDz_HangDaoSup.Style :=csDropDownList;
                ComboDz_HangDaoSup.Items.Add('巷道基本不需要支护');
                ComboDz_HangDaoSup.Items.Add('巷道简单锚网支护');
                ComboDz_HangDaoSup.Items.Add('巷道架棚支护，基本不变形');
                ComboDz_HangDaoSup.Items.Add('巷道变形，底鼓，安全影响小');
                ComboDz_HangDaoSup.Items.Add('巷巷道急速变形，底鼓，严重影响安全');
                 if (P_Stope.t_Gzm.Dz_HangDaoSup)>0 then begin
                          ComboDz_HangDaoSup.ItemIndex:=(P_Stope.t_Gzm.Dz_HangDaoSup)-1;
                  end else begin
                          ComboDz_HangDaoSup.ItemIndex:=0;
                  end;
         end;
      StringGridDZ.Cells[0,26]:='24';
      StringGridDZ.Cells[1,26]:='上界开采';
      
      StringGridDZ.Cells[0,27]:='25';
      StringGridDZ.Cells[1,27]:='上界煤柱';
      if P_Stope.t_Gzm.CK_Upkc=1 then  begin
             StringGridDZ.Cells[2,27]:=FormatFloat('0.00',P_Stope.t_Gzm.CK_UpMz);
             StringGridDZ.Cells[2,26]:='已采';
      end else begin
             StringGridDZ.Cells[2,27]:='0';
             StringGridDZ.Cells[2,26]:='未采';
      end;

      StringGridDZ.Cells[0,28]:='26';
      StringGridDZ.Cells[1,28]:='下界开采';

      StringGridDZ.Cells[0,29]:='27';
      StringGridDZ.Cells[1,29]:='下界煤柱';
      if P_Stope.t_Gzm.CK_Downkc=1 then  begin
             StringGridDZ.Cells[2,29]:=FormatFloat('0.00',P_Stope.t_Gzm.CK_DownMz);
             StringGridDZ.Cells[2,28]:='已采';
      end else begin
             StringGridDZ.Cells[2,29]:='0';
             StringGridDZ.Cells[2,28]:='未采';
      end;
      //日推进速度
      StringGridDZ.Cells[0,30]:='28';
      StringGridDZ.Cells[1,30]:='日推进速度(m)';
      StringGridDZ.Cells[2,30]:=FormatFloat('0.00',P_Stope.t_Gzm.S_DayStep_speed);
     //是否存在采空区
      StringGridDZ.Cells[0,31]:='29';
      StringGridDZ.Cells[1,31]:='工作面上方是否存在采空区';
      StringGridDZ.Cells[0,32]:='30';
      StringGridDZ.Cells[1,32]:='采空区采高';
      StringGridDZ.Cells[2,32]:='0';
      StringGridDZ.Cells[0,33]:='31';
      StringGridDZ.Cells[1,33]:='层间距';
      StringGridDZ.Cells[2,33]:='0';
       if Combo_ckq=nil then begin
                vRect := StringGridDZ.CellRect(2, 30);
                Combo_ckq := TComboBox.Create(StringGridDZ);
                Combo_ckq.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                Combo_ckq.BoundsRect := vRect;
                Combo_ckq.Color :=clBtnFace;
                Combo_ckq.Visible := true;
                Combo_ckq.OnClick:=Combo_Gzm_HangDaoSup;

                Combo_ckq.Style :=csDropDownList;
                Combo_ckq.Items.Add('没有采空区');
                Combo_ckq.Items.Add('存在采空区');

                 if (P_Stope.t_Gzm.UP_Ckq)>0 then begin
                          Combo_ckq.ItemIndex:=1;
                           StringGridDZ.Cells[2,32]:=FormatFloat('0.00',P_Stope.t_Gzm.UP_CKQ_Kc_H);
                           StringGridDZ.Cells[2,33]:=FormatFloat('0.00',P_Stope.t_Gzm.UP_CKQ_JuLI);
                  end else begin
                          Combo_ckq.ItemIndex:=0;
                  end;
         end;
end;
//======
 Procedure TFormZhiJia.initzjGrid(Sender:TObject);
 begin
       //初始化支架stringgrid
    StringGridZJ.ColCount :=4;
    if StringGridZJ.Height/20<30  then  begin
         StringGridZJ.RowCount :=30;
    end else begin
         StringGridZJ.RowCount :=trunc(StringGridZJ.Height/20);
    end;
    StringGridZJ.FixedCols:=0;
    StringGridZJ.FixedRows:=1;
    StringGridZJ.DefaultRowHeight:=18;
    StringGridZJ.ColWidths[0]:=30;
    StringGridZJ.ColWidths[1]:=StringGridZJ.Width-180;
    StringGridZJ.ColWidths[2]:=100;
    StringGridZJ.ColWidths[3]:=30;

    StringGridZJ.Canvas.Font.Size:=8;
    StringGridZJ.Cells[0,0]:='序号';
    StringGridZJ.Cells[1,0]:='名称';
    StringGridZJ.Cells[2,0]:='取值';


    StringGridZJ.Canvas.Font.Size:=8;

    //-- FormatFloat('0.00',P_Stope.t_Gzm.CK_DownMz);
    StringGridZJ.Cells[0,1]:='1';
    StringGridZJ.Cells[1,1]:='支架编号';
    StringGridZJ.Cells[2,1]:=P_Stope.t_ZhiJia.Zj_BianHao;
    //----
    StringGridZJ.Cells[0,2]:='2';
    StringGridZJ.Cells[1,2]:='支架型号';
    StringGridZJ.Cells[2,2]:=P_Stope.t_ZhiJia.Zj_XingHao;
      //----
    StringGridZJ.Cells[0,3]:='3';
    StringGridZJ.Cells[1,3]:='支架立柱数量';
    StringGridZJ.Cells[2,3]:=IntToStr(P_Stope.t_ZhiJia.Zj_Lizhu_count);
    StringGridZJ.Cells[3,3]:='个';
      //----
    StringGridZJ.Cells[0,4]:='4';
    StringGridZJ.Cells[1,4]:='支架控顶距';
    StringGridZJ.Cells[2,4]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_KongdingJU);
    StringGridZJ.Cells[3,4]:='米';
      //----
    StringGridZJ.Cells[0,5]:='5';
    StringGridZJ.Cells[1,5]:='支架中心矩';
    StringGridZJ.Cells[2,5]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_zhongxinju);
    StringGridZJ.Cells[3,5]:='米';
     //----
    StringGridZJ.Cells[0,6]:='6';
    StringGridZJ.Cells[1,6]:='支架合力作用点';
    StringGridZJ.Cells[2,6]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_hlzyd);
    StringGridZJ.Cells[3,6]:='米';
     //----
    StringGridZJ.Cells[0,7]:='7';
    StringGridZJ.Cells[1,7]:='支架设计阻抗力';
    StringGridZJ.Cells[2,7]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_toall_F);
    StringGridZJ.Cells[3,7]:='KN';
    //----
    StringGridZJ.Cells[0,8]:='8';
    StringGridZJ.Cells[1,8]:='初压预计最大阻抗力';
    StringGridZJ.Cells[2,8]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_JiSuan_C0_F[0]);
    StringGridZJ.Cells[3,8]:='KN';
      //----
    StringGridZJ.Cells[0,9]:='9';
    StringGridZJ.Cells[1,9]:='初压预计最小阻抗力';
    StringGridZJ.Cells[2,9]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_JiSuan_C0_F[1]);
    StringGridZJ.Cells[3,9]:='KN';
      //----
    StringGridZJ.Cells[0,10]:='10';
    StringGridZJ.Cells[1,10]:='初压预计合理阻抗力';
    StringGridZJ.Cells[2,10]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_JiSuan_C0_F[2]);
    StringGridZJ.Cells[3,10]:='KN';
      //----
    StringGridZJ.Cells[0,11]:='11';
    StringGridZJ.Cells[1,11]:='周压预计最大阻抗力';
    StringGridZJ.Cells[2,11]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_JiSuan_Ci_F[0]);
    StringGridZJ.Cells[3,11]:='KN';
      //----
    StringGridZJ.Cells[0,12]:='12';
    StringGridZJ.Cells[1,12]:='周压预计最小阻抗力';
    StringGridZJ.Cells[2,12]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_JiSuan_Ci_F[1]);
    StringGridZJ.Cells[3,12]:='KN';
      //----
    StringGridZJ.Cells[0,13]:='13';
    StringGridZJ.Cells[1,13]:='周压预计合理阻抗力';
    StringGridZJ.Cells[2,13]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_JiSuan_Ci_F[2]);
    StringGridZJ.Cells[3,13]:='KN';
      //----
    StringGridZJ.Cells[0,14]:='14';
    StringGridZJ.Cells[1,14]:='支架设计强度';
    StringGridZJ.Cells[2,14]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_toall_P);
    StringGridZJ.Cells[3,14]:='MPa';
    //----
    StringGridZJ.Cells[0,15]:='15';
    StringGridZJ.Cells[1,15]:='初压预计最大强度';
    StringGridZJ.Cells[2,15]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_JiSuan_C0_P[0]);
    StringGridZJ.Cells[3,15]:='MPa';
      //----
    StringGridZJ.Cells[0,16]:='16';
    StringGridZJ.Cells[1,16]:='初压预计最小强度';
    StringGridZJ.Cells[2,16]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_JiSuan_C0_P[1]);
    StringGridZJ.Cells[3,16]:='MPa';
      //----
    StringGridZJ.Cells[0,17]:='17';
    StringGridZJ.Cells[1,17]:='初压预计合理强度';
    StringGridZJ.Cells[2,17]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_JiSuan_C0_P[2]);
    StringGridZJ.Cells[3,17]:='MPa';
      //----
    StringGridZJ.Cells[0,18]:='18';
    StringGridZJ.Cells[1,18]:='周压预计最大强度';
    StringGridZJ.Cells[2,18]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_JiSuan_Ci_P[0]);
    StringGridZJ.Cells[3,18]:='MPa';
      //----
    StringGridZJ.Cells[0,19]:='19';
    StringGridZJ.Cells[1,19]:='周压预计最小强度';
    StringGridZJ.Cells[2,19]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_JiSuan_Ci_P[1]);
    StringGridZJ.Cells[3,19]:='MPa';
      //----
    StringGridZJ.Cells[0,20]:='20';
    StringGridZJ.Cells[1,20]:='周压预计合理强度';
    StringGridZJ.Cells[2,20]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_JiSuan_Ci_P[2]);
    StringGridZJ.Cells[3,20]:='MPa';
      //----

    StringGridZJ.Cells[0,21]:='21';
    StringGridZJ.Cells[1,21]:='支架设计缩量';
    StringGridZJ.Cells[2,21]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_suoliang*1000);
    StringGridZJ.Cells[3,21]:='mm';
    //----
    StringGridZJ.Cells[0,22]:='22';
    StringGridZJ.Cells[1,22]:='预计最大缩量';
    StringGridZJ.Cells[2,22]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_Jisuan_SL[0]*1000);
    StringGridZJ.Cells[3,22]:='mm';
      //----
    StringGridZJ.Cells[0,23]:='23';
    StringGridZJ.Cells[1,23]:='预计最小缩量';
    StringGridZJ.Cells[2,23]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_Jisuan_SL[1]*1000);
    StringGridZJ.Cells[3,23]:='mm';
      //----
    StringGridZJ.Cells[0,24]:='24';
    StringGridZJ.Cells[1,24]:='预计合理缩量';
    StringGridZJ.Cells[2,24]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_Jisuan_SL[2]*1000);
    StringGridZJ.Cells[3,24]:='mm';
    //===========

       //===========
    StringGridZJ.Cells[0,26]:='25';
    StringGridZJ.Cells[1,26]:='承担直接顶的强度';
    StringGridZJ.Cells[2,26]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_imm_p);
    StringGridZJ.Cells[3,26]:='MPa';
      //----
          //===========
    StringGridZJ.Cells[0,27]:='26';
    StringGridZJ.Cells[1,27]:='承担老初压平均强度';
    StringGridZJ.Cells[2,27]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_old_C0_p[2]);
    StringGridZJ.Cells[3,27]:='MPa';
      //----
    StringGridZJ.Cells[0,28]:='267';
    StringGridZJ.Cells[1,28]:='承担老顶合理平均强度';
    StringGridZJ.Cells[2,28]:=FormatFloat('0.00',P_Stope.t_ZhiJia.Zj_old_Ci_p[2]);
    StringGridZJ.Cells[3,28]:='MPa';
      //----

 end;
//-------------
procedure TFormZhiJia.initFyydGrid(Sender:TObject);
var
    vRect:    TRect;
begin
    //初始化覆岩运动规律stringGrid
    StringGridFy.ColCount :=4;
    if StringGridFy.Height/20<30  then  begin
         StringGridFy.RowCount :=30;
    end else begin
         StringGridFy.RowCount :=trunc(StringGridFy.Height/20);
    end;
    StringGridFy.FixedCols:=0;
    StringGridFy.FixedRows:=1;
    StringGridFy.DefaultRowHeight:=18;
    StringGridFy.ColWidths[0]:=30;
    StringGridFy.ColWidths[1]:=StringGridFy.Width-180;
    StringGridFy.ColWidths[2]:=100;
    StringGridFy.ColWidths[3]:=30;

    StringGridFy.Canvas.Font.Size:=8;
    StringGridFy.Cells[0,0]:='序号';
    StringGridFy.Cells[1,0]:='名称';
    StringGridFy.Cells[2,0]:='取值';


    StringGridFy.Canvas.Font.Size:=8;

    //-- FormatFloat('0.00',P_Stope.t_Gzm.CK_DownMz);
    StringGridFy.Cells[0,1]:='1';
    StringGridFy.Cells[1,1]:='顶板结构';
      if Combo_YlJg=nil then begin
                vRect := StringGridFy.CellRect(2, 0);
                Combo_YlJg := TComboBox.Create(StringGridFY);
                Combo_YlJg.Parent := StringGridFY.Parent;
                     OffsetRect(vRect, StringGridFY.left+1, StringGridFY.Top+StringGridFY.DefaultRowHeight*1);
                Combo_YlJg.BoundsRect := vRect;
                Combo_YlJg.Color :=clBtnFace;
                Combo_YlJg.Visible := true;
                Combo_YlJg.OnClick:=Combo_YlJg_Fy_1;

                Combo_YlJg.Style :=csDropDownList;
                Combo_YlJg.Items.Add('单岩梁结构');// 1	水平推进
                Combo_YlJg.Items.Add('多岩梁结构');

                 if P_Stope.t_old.YL_struc=1  then begin
                          Combo_YlJg.ItemIndex:=0;
                 end else begin
                          Combo_YlJg.ItemIndex:=1;
                 end;


         end;
    //
    StringGridFy.Cells[0,2]:='2';
    StringGridFy.Cells[1,2]:='是否有内应力场';
      if Combo_nylc=nil then begin
                vRect := StringGridFy.CellRect(2, 1);
                Combo_nylc := TComboBox.Create(StringGridFY);
                Combo_nylc.Parent := StringGridFY.Parent;
                     OffsetRect(vRect, StringGridFY.left+1, StringGridFY.Top+StringGridFY.DefaultRowHeight*1);
                Combo_nylc.BoundsRect := vRect;
                Combo_nylc.Color :=clBtnFace;
                Combo_nylc.Visible := true;

                Combo_nylc.Style :=csDropDownList;
                Combo_nylc.Items.Add('有内应力场');// 1	水平推进
                Combo_nylc.Items.Add('无内应力场');

                 if P_Stope.t_Gzm.ZCYL_s0>1  then begin
                          Combo_nylc.ItemIndex:=1;
                 end else begin
                          Combo_nylc.ItemIndex:=0;
                 end;


         end;

    //----
    StringGridFy.Cells[0,3]:='3';
    StringGridFy.Cells[1,3]:='直接顶高度';
    StringGridFy.Cells[2,3]:=FormatFloat('0.00',P_Stope.t_imm_r.Immroof_M);
    StringGridFy.Cells[3,3]:='米';
      //----
    StringGridFy.Cells[0,4]:='4';
    StringGridFy.Cells[1,4]:='直接顶初次垮落步距';
    StringGridFy.Cells[2,4]:=FormatFloat('0.00',P_Stope.t_imm_r.Immroof_C0);
    StringGridFy.Cells[3,4]:='个';
      //----
    StringGridFy.Cells[0,5]:='5';
    StringGridFy.Cells[1,5]:='老顶最大高度';
    StringGridFy.Cells[2,5]:=FormatFloat('0.00',P_Stope.t_old.YL_max_m);
    StringGridFy.Cells[3,5]:='米';
      //----
    StringGridFy.Cells[0,6]:='6';
    StringGridFy.Cells[1,6]:='老顶最小高度';
    StringGridFy.Cells[2,6]:=FormatFloat('0.00',P_Stope.t_old.YL_min_m);
    StringGridFy.Cells[3,6]:='米';
      //-----
    StringGridFy.Cells[0,7]:='7';
    StringGridFy.Cells[1,7]:='老顶初次来压最大步距';
    StringGridFy.Cells[2,7]:=FormatFloat('0.00',P_Stope.t_old.YL_First_step[0]);
    StringGridFy.Cells[3,7]:='米';
      //-----
    StringGridFy.Cells[0,8]:='8';
    StringGridFy.Cells[1,8]:='老顶初次来压最小步距';
    StringGridFy.Cells[2,8]:=FormatFloat('0.00',P_Stope.t_old.YL_First_step[1]);
    StringGridFy.Cells[3,8]:='米';
      //-----
    StringGridFy.Cells[0,9]:='9';
    StringGridFy.Cells[1,9]:='老顶初次来压平均步距';
    StringGridFy.Cells[2,9]:=FormatFloat('0.00',P_Stope.t_old.YL_First_step[2]);
    StringGridFy.Cells[3,9]:='米';
      //-------
    StringGridFy.Cells[0,10]:='10';
    StringGridFy.Cells[1,10]:='老顶周期来压最大步距';
    StringGridFy.Cells[2,10]:=FormatFloat('0.00',P_Stope.t_old.YL_First_step[0]*0.408);
    StringGridFy.Cells[3,10]:='米';
      //-----
    StringGridFy.Cells[0,11]:='11';
    StringGridFy.Cells[1,11]:='老顶周期来压最小步距';
    StringGridFy.Cells[2,11]:=FormatFloat('0.00',P_Stope.t_old.YL_First_step[1]*0.408);
    StringGridFy.Cells[3,11]:='米';
      //-----
    StringGridFy.Cells[0,12]:='12';
    StringGridFy.Cells[1,12]:='老顶周期来压平均步距';
    StringGridFy.Cells[2,12]:=FormatFloat('0.00',P_Stope.t_old.YL_First_step[2]*0.408);
    StringGridFy.Cells[3,12]:='米';
     //
       //
    StringGridFy.Cells[0,13]:='13';
    StringGridFy.Cells[1,13]:='直接顶类别';
      if Combo_imm_leibie=nil then begin
                vRect := StringGridFy.CellRect(2,12);
                Combo_imm_leibie := TComboBox.Create(StringGridFY);
                Combo_imm_leibie.Parent := StringGridFY.Parent;
                     OffsetRect(vRect, StringGridFY.left+1, StringGridFY.Top+StringGridFY.DefaultRowHeight*1);
                Combo_imm_leibie.BoundsRect := vRect;
                Combo_imm_leibie.Color :=clBtnFace;
                Combo_imm_leibie.Visible := true;

                Combo_imm_leibie.Style :=csDropDownList;
                Combo_imm_leibie.Items.Add('1a 极不稳定');//
                Combo_imm_leibie.Items.Add('1b 较不稳定');
                Combo_imm_leibie.Items.Add('2a 中下稳定');//
                Combo_imm_leibie.Items.Add('2b 中上稳定');
                Combo_imm_leibie.Items.Add('3  类稳定顶板');//
                Combo_imm_leibie.Items.Add('4  类非常稳定顶板'); //
                Combo_imm_leibie.ItemIndex:=P_Stope.t_imm_r.Imm_leibie-1;
     end;

    //----
           //
    StringGridFy.Cells[0,14]:='14';
    StringGridFy.Cells[1,14]:='老顶类别';
      if Combo_old_leibie=nil then begin
                vRect := StringGridFy.CellRect(2, 13);
                Combo_old_leibie := TComboBox.Create(StringGridFY);
                Combo_old_leibie.Parent := StringGridFY.Parent;
                     OffsetRect(vRect, StringGridFY.left+1, StringGridFY.Top+StringGridFY.DefaultRowHeight*1);
                Combo_old_leibie.BoundsRect := vRect;
                Combo_old_leibie.Color :=clBtnFace;
                Combo_old_leibie.Visible := true;

                Combo_old_leibie.Style :=csDropDownList;
                Combo_old_leibie.Items.Add('I    不明显');//
                Combo_old_leibie.Items.Add('II   明显');
                Combo_old_leibie.Items.Add('III  强烈');//
                Combo_old_leibie.Items.Add('IVa  非常强烈');
                Combo_old_leibie.Items.Add('IVb  非常强烈');//


                     Combo_old_leibie.ItemIndex:=P_Stope.t_old.Old_leibie-1;
     end;

    //----
            //
    StringGridFy.Cells[0,15]:='15';
    StringGridFy.Cells[1,15]:='底板类别';
      if Combo_diban_leibie=nil then begin
                vRect := StringGridFy.CellRect(2, 14);
                Combo_diban_leibie := TComboBox.Create(StringGridFY);
                Combo_diban_leibie.Parent := StringGridFY.Parent;
                     OffsetRect(vRect, StringGridFY.left+1, StringGridFY.Top+StringGridFY.DefaultRowHeight*1);
                Combo_diban_leibie.BoundsRect := vRect;
                Combo_diban_leibie.Color :=clBtnFace;
                Combo_diban_leibie.Visible := true;

                Combo_diban_leibie.Style :=csDropDownList;
                Combo_diban_leibie.Items.Add('I    极软');//
                Combo_diban_leibie.Items.Add('II   松软');
                Combo_diban_leibie.Items.Add('IIIa 较软');//
                Combo_diban_leibie.Items.Add('IIIb 较软');
                Combo_diban_leibie.Items.Add('IV   中硬');//
                Combo_diban_leibie.Items.Add('V   坚硬');//

                Combo_diban_leibie.ItemIndex:=P_Stope.t_old.diban_leobie-1;
     end;
     //
     StringGridFy.Cells[0,16]:='16';
     StringGridFy.Cells[1,16]:='顶煤冒放性';
      if Combo_fdm_leibie=nil then begin
                vRect := StringGridFy.CellRect(2, 15);
                Combo_fdm_leibie := TComboBox.Create(StringGridFY);
                Combo_fdm_leibie.Parent := StringGridFY.Parent;
                     OffsetRect(vRect, StringGridFY.left+1, StringGridFY.Top+StringGridFY.DefaultRowHeight*1);
                Combo_fdm_leibie.BoundsRect := vRect;
                Combo_fdm_leibie.Color :=clBtnFace;
                Combo_fdm_leibie.Visible := true;

                Combo_fdm_leibie.Style :=csDropDownList;
                Combo_fdm_leibie.Items.Add('不放顶');//
                Combo_fdm_leibie.Items.Add('1类 可放性好');
                Combo_fdm_leibie.Items.Add('2类 可放性较好');//
                Combo_fdm_leibie.Items.Add('3类 可放性一般');
                Combo_fdm_leibie.Items.Add('4类 可放性差');//
                Combo_fdm_leibie.Items.Add('5类  难放');//

                Combo_fdm_leibie.ItemIndex:=P_Stope.t_imm_r.FDm_leibie;
     end;


end;
///
procedure TFormZhiJia.StringGridDZSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
       if ACol=0 then  StringGridDZ.Options :=StringGridZJ.Options -[goEditing];
       if ACol=1 then  StringGridDZ.Options :=StringGridZJ.Options -[goEditing];
       if ACol=2 then  StringGridDZ.Options :=StringGridZJ.Options +[goEditing];

 // if (ACol = 1) and (ACol = 2) then CanSelect := False;  //第一列第二行不可选
end;

procedure TFormZhiJia.StringGridFySelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
       if ACol=0 then  StringGridFY.Options :=StringGridZJ.Options -[goEditing];
       if ACol=1 then  StringGridFY.Options :=StringGridZJ.Options -[goEditing];
       if ACol=2 then  StringGridFY.Options :=StringGridZJ.Options +[goEditing];
end;

procedure TFormZhiJia.StringGridZJSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
       if ACol=0 then  StringGridZJ.Options :=StringGridZJ.Options -[goEditing];
       if ACol=1 then  StringGridZJ.Options :=StringGridZJ.Options -[goEditing];
       if ACol=2 then  StringGridZJ.Options :=StringGridZJ.Options +[goEditing];
end;

procedure TFormZhiJia.TabSet1Change(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin


end;

//====
procedure TFormZhiJia.BitBtn2Click(Sender: TObject);
begin
      FormZJCS:=TFormZJCS.Create(self);
     // ShowMessage(dllPath);
      FormZJCS.dllpath:=P_Stope.dllPath ;
      FormZJCS.Show;

end;

procedure TFormZhiJia.BitBtn3Click(Sender: TObject);
begin
      self.Close ;
end;

procedure TFormZhiJia.Button1Click(Sender: TObject);

begin
         self.Edit_Cs(Sender);
         P_stope.t_ZhiJia.Cal_Sup_Para(P_Stope.T_gzm,P_Stope.t_zk,P_Stope.T_imm_r,P_Stope.t_old);
         initzjGrid(Sender);
         self.TabSheetZj.Show;
end;
procedure TFormZhiJia.Button2Click(Sender: TObject);
begin
        initGzmDCGrid(Sender);
        initzjGrid(Sender);
        initFyydGrid(Sender);
end;
 procedure TFormZhiJia.Button3Click(Sender: TObject);
begin
   self.BitBtn3.Click;
end;

procedure TFormZhiJia.Button7Click(Sender: TObject);
begin
   
end;

// 修订参数

 procedure TFormZhiJia.Edit_Cs(Sender:Tobject);
 begin
     P_stope.t_Gzm.S_cmfs:=IntToStr(self.ComboDz_cmfs_4.ItemIndex+1); //采煤方式
     if self.ComboDz_cmfs_4.ItemIndex=3 then
       begin
          P_stope.t_Gzm.S_Fm_h:=StrToFloat(self.StringGridDZ.Cells[2,7]);// 放煤高度
       end else begin
          P_stope.t_Gzm.S_Fm_h:=0;
       end;

     P_stope.t_Gzm.S_Cg_h:=StrToFloat(self.StringGridDZ.Cells[2,6]);//开采高度
     P_stope.t_Gzm.S_qj:= StrToFloat(self.StringGridDZ.Cells[2,8]);//倾角
     P_stope.t_Gzm.S_mcsd_h:= StrToFloat(self.StringGridDZ.Cells[2,9]);//埋藏深度
     P_stope.t_Gzm.S_L_qx:= StrToFloat(self.StringGridDZ.Cells[2,10]);//   倾向长
     P_stope.t_Gzm.S_Jc_L:= StrToFloat(self.StringGridDZ.Cells[2,12]);//   累计进尺
     P_stope.t_Gzm.S_f_PS:=(self.ComboDz_psxs_12.ItemIndex+1); //普氏系数
             if P_Stope.t_Gzm.S_f_PS =1then begin
                       P_Stope.t_Gzm.S_M_njl:=10;
                       P_Stope.t_Gzm.S_M_mcj:=20;
                       P_Stope.t_Gzm.S_Bsb:=0.35;
                       P_Stope.t_Gzm.S_K_zcfz:=1.6-0.1*(P_Stope.t_Gzm.S_Cg_h-4);
                   end else if P_Stope.t_Gzm.S_f_PS=2 then begin
                       P_Stope.t_Gzm.S_M_njl:=30;
                       P_Stope.t_Gzm.S_M_mcj:=25;
                       P_Stope.t_Gzm.S_Bsb:=0.3;
                       P_Stope.t_Gzm.S_K_zcfz:=2.0-0.1*(P_Stope.t_Gzm.S_Cg_h-4);
                   end else if P_Stope.t_Gzm.S_f_PS=3 then begin
                       P_Stope.t_Gzm.S_M_njl:=50;
                       P_Stope.t_Gzm.S_M_mcj:=30;
                       P_Stope.t_Gzm.S_Bsb:=0.25;
                       P_Stope.t_Gzm.S_K_zcfz:=2.3-0.1*(P_Stope.t_Gzm.S_Cg_h-4);
                   end else begin
                       P_Stope.t_Gzm.S_M_njl:=100;
                       P_Stope.t_Gzm.S_M_mcj:=35;
                       P_Stope.t_Gzm.S_Bsb:=0.2;
                       P_Stope.t_Gzm.S_K_zcfz:=2.6-0.1*(P_Stope.t_Gzm.S_Cg_h-4);
                   end;
     P_stope.t_Gzm.Dz_yxfx:=(self.ComboDz_yxfx_16.ItemIndex+1); // 仰斜俯斜
     P_stope.t_Gzm.Dz_JYHD:=(self.ComboDz_jyhd.ItemIndex+1); // 基岩厚度
     P_stope.t_Gzm.Dz_DCGZ:=(self.ComboDz_dcgz.ItemIndex+1); // 地质构造
     P_stope.t_Gzm.Dz_WSFC:=(self.ComboDz_WsFc.ItemIndex+1); //  瓦斯含量
     P_stope.t_Gzm.Dz_TopWater:=(self.ComboDz_TopWater.ItemIndex+1); //  顶板水
     P_stope.t_Gzm.Dz_BottomWater:=(self.ComboDz_BottomWater.ItemIndex+1); // 底板水
     P_stope.t_Gzm.Dz_HeoStress:=(self.ComboDz_HeoStress.ItemIndex+1); // 水平应力
     P_stope.t_Gzm.Dz_Kyxx:=(self.ComboDz_kyxx.ItemIndex+1); //  矿压现象
     P_stope.t_Gzm.Dz_HangDaoSup:=(self.ComboDz_HangDaoSup.ItemIndex+1); // 巷道支护
     if  StrToFloat(StringGridDZ.Cells[2,27])> 0 then  begin                  // //上界煤柱
          P_Stope.t_Gzm.CK_UpMz:=StrToFloat( StringGridDZ.Cells[2,27]);
          P_Stope.t_Gzm.CK_Upkc:=1;
     end else begin
          P_Stope.t_Gzm.CK_UpMz:=0;
          P_Stope.t_Gzm.CK_Upkc:=0;
     end;

     if  StrToFloat(StringGridDZ.Cells[2,29])>0 then  begin                 //下界煤柱
          P_Stope.t_Gzm.CK_downmz:=StrToFloat( StringGridDZ.Cells[2,29]);
          P_Stope.t_Gzm.CK_downkc:=1;
     end else begin
          P_Stope.t_Gzm.CK_downmz:=0;
          P_Stope.t_Gzm.CK_downkc:=0;
     end;
     //
          P_Stope.t_Gzm.UP_Ckq:=Combo_ckq.ItemIndex;      //上覆岩层是否存在采空区
              if (P_Stope.t_Gzm.UP_Ckq)>0 then begin
                           P_Stope.t_Gzm.UP_CKQ_Kc_H:=StrToFloat(StringGridDZ.Cells[2,32]);
                           P_Stope.t_Gzm.UP_CKQ_JuLI:=StrTofloat(StringGridDZ.Cells[2,33]);
              end else begin
                        P_Stope.t_Gzm.UP_CKQ_Kc_H:=0;
                        P_Stope.t_Gzm.UP_CKQ_JuLI:=0;
              end;

    //
      P_Stope.t_old.YL_struc:=self.ComBo_YlJg.ItemIndex+1;  //    岩梁结构
     { if (P_Stope.t_Gzm.ZCYL_s0<1) and (self.Combo_nYLc.ItemIndex=1) then   //内应力场
          P_Stope.t_Gzm.ZCYL_s0:=1.5;
      if (P_Stope.t_Gzm.ZCYL_s0>1) and (self.Combo_nYLc.ItemIndex=0) then
          P_Stope.t_Gzm.ZCYL_s0:=0.5;
      }
    //
    P_Stope.t_imm_r.Immroof_M:=StrToFloat(StringGridFy.Cells[2,3]);//  直接顶高度
    P_Stope.t_imm_r.Immroof_C0:=StrToFloat(StringGridFy.Cells[2,4]);//  直接顶初次垮落步距
    P_Stope.t_old.YL_max_m := StrToFloat(StringGridFy.Cells[2,5]);//  老顶最大高度
    P_Stope.t_old.YL_min_m := StrToFloat(StringGridFy.Cells[2,6]);// 老顶最小高度
    P_Stope.t_old.YL_First_step[0] := StrToFloat(StringGridFy.Cells[2,7]);// 老顶初次来压最大步距
    P_Stope.t_old.YL_First_step[1] := StrToFloat(StringGridFy.Cells[2,8]);// 老顶初次来压最小步距
    P_Stope.t_old.YL_First_step[2] := StrToFloat(StringGridFy.Cells[2,9]);// 老顶初次来压平均步距
    P_Stope.t_imm_r.Imm_leibie:=Combo_imm_leibie.ItemIndex+1;  // 直接顶类别
    P_Stope.t_old.Old_leibie:= Combo_old_leibie.ItemIndex+1;   //  老顶类别
    P_Stope.t_old.diban_leobie:=Combo_diban_leibie.ItemIndex+1;       // 底板类别'
    P_Stope.t_imm_r.FDm_leibie:=Combo_fdm_leibie.ItemIndex;          //  顶煤冒放性

    p_stope.t_ZhiJia.Zj_KongdingJU:= StrToFloat(StringGridZj.Cells[2,4]);// 支架控顶距
    p_stope.t_ZhiJia.Zj_zhongxinju:= StrToFloat(StringGridZj.Cells[2,5]);// 支架中心距
    p_stope.t_ZhiJia.Zj_hlzyd:= StrToFloat(StringGridZj.Cells[2,6]);// 支架合力作用点
    p_stope.t_ZhiJia.Zj_toall_F:= StrToFloat(StringGridZj.Cells[2,7]);// 支架设计阻力



 end;
procedure TFormZhiJia.FormClose(Sender: TObject; var Action: TCloseAction);
var
   i:integer;
begin
      for i := 0 to 11 do   begin
         ImageArry[i].Free;
      end;
      png.Free ;
     Action := caFree;
end;

procedure TFormZhiJia.FormCreate(Sender: TObject);
var
   i:integer;
begin
    SetLength(ModuleName, 255);
  //取得Dll自身路径
      GetModuleFileName(HInstance, PChar(ModuleName), Length(ModuleName));
      dllPath:=Trim(PChar(ModuleName)) ;
       i:=Pos('\',ReverseString(dllPath));
      dllPath:=Copy(dllPath,1,Length(dllPath)-i);

   self.Width :=1200;
   self.Height:=768;
   self.ComboZtjx.Items.Clear();
        ComboZtjx.Items.Add('111-10000KN以上_四柱整体顶梁结构');
        ComboZtjx.Items.Add('112-10000KN以上_四柱铰接顶梁结构');
        ComboZtjx.Items.Add('121-10000KN以上_两柱整体顶梁结构');
        ComboZtjx.Items.Add('122-10000KN以上_两柱铰接顶梁结构');
        ComboZtjx.Items.Add('211-5000_10000KN_四柱整体顶梁结构');
        ComboZtjx.Items.Add('212-5000_10000KN以上_四柱铰接顶梁结构');
        ComboZtjx.Items.Add('221-5000_10000KN以上_两柱整体顶梁结构');
        ComboZtjx.Items.Add('222-5000_10000KN以上_两柱铰接顶梁结构');
        ComboZtjx.Items.Add('JX3-单绞点');
        ComboZtjx.Items.Add('JX4-单摆杆');
        ComboZtjx.Items.Add('//-——————————————————————————————————————————————');
        ComboZtjx.Items.Add('22131-两柱掩护式放顶煤３米支架（整体＋伸缩顶梁）');
        ComboZtjx.Items.Add('22231-两柱掩护式综采2.9米支架（整体＋伸缩顶梁）');
        ComboZtjx.Items.Add('22132-两柱掩护式综采6.3米支架（整体＋伸缩顶梁+二级护帮）');
        ComboZtjx.Items.Add('22231-两柱掩护式综采3.8米支架（整体＋伸缩顶梁）');
        ComboZtjx.Items.Add('42121-四柱掩护式放顶煤3米支架（铰接顶梁）');
        ComboZtjx.Items.Add('42141-四柱掩护式放顶煤3.5米支架（铰接＋伸缩顶梁）');
        ComboZtjx.Items.Add('42131-四柱掩护式放顶煤4.2米支架（整体＋伸缩顶梁）');
        ComboZtjx.Items.Add('42210-四柱支撑式支架');
        ComboZtjx.Items.Add('43241-四柱支撑掩护式综采4.2米支架（铰接＋伸缩顶梁）');
        ComboZtjx.Items.Add('43231-四柱支撑掩护式综采4米支架（整体＋伸缩顶梁）');
        ComboZtjx.Items.Add('43232-四柱支撑掩护式综采5米支架（整体＋伸缩顶梁+二级护帮））');

   //==================
     for i := 0 to 11 do   begin
       ImageArry[i]:=TImage.Create(application);
       ImageArry[i].Proportional:=true;
       ImageArry[i].Parent:=self.TabSheet1;
       ImageArry[i].Visible :=false;
       ImageArry[i].OnDblClick:=ImageArryClick;
       ImageArry[i].Tag:=i;
     end;
    //
    ComBo_Click_Count:=0;
    png := TPngObject.Create;

end;// end


procedure TFormZhiJia.FormResize(Sender: TObject);
begin
     //变化行数
      if StringGridDZ.Height/20<30 then begin
        StringGridDZ.RowCount :=30;
        end else begin
            StringGridDZ.RowCount :=trunc(StringGridDZ.Height/20);
        end;
end;

procedure TFormZhiJia.FormShow(Sender: TObject);
var
  i,Count1:integer;
  temp1 :Str_Dt_array;
begin
        initGzmDCGrid(Sender);
        initzjGrid(Sender);
        initFyydGrid(Sender);
        comboZtjx.OnChange(sender);
        Image1TopBlank:=20;
        Image1LeftBlank:=20;
        ImageSpace:=5;
        IntImage1();
        InitZjjbcs(Sender);
        //
        Mc_FdBs:=1.5;
        for I := 0 to self.ComboZtjx.Items.Count-1 do
          begin
             temp1:=split(ComboZtjx.Items[i],'-',Count1);
             if trim(temp1[0])=P_Stope.t_ZhiJia.ZJ_JianYi_Type then
                begin
                  self.ComboZtjx.ItemIndex:=i;
                  self.ComboZtjx.OnChange(sender);
                end;

          end;
end;

end.
