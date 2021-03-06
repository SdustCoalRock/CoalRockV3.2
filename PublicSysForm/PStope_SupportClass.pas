unit PStope_SupportClass;

interface

uses
  Windows, SysUtils, Classes, Messages, Controls, Forms, StdCtrls, ExtCtrls
  ,ComCtrls,math,IniFiles,Jpeg,Graphics,Dialogs,Lu_Public_BasicModual
  ,PStope_WorKFace,PStope_Immediate,uHintWin
   ;
type
  TDrawZjRecord=Record
     ShowV:Boolean; //是否显示
     Zj_body_fillColor:Tcolor;// 主体填充颜色
     Zj_State:integer;// 1 升级 状态  2 降架状态
     zj_MN:integer;//  0 不模拟  1 升架模拟  2 降架模拟
     Zj_DL:integer;//  1 整体 顶梁 2 铰接顶梁
     Zj_Hb:integer;//  1 一级互帮 2 二级互帮
     zj_LZ:integer;//  2 两立柱 4 四立柱
     ZJ_FM:integer;// 1 放顶煤 2 综采液压支架
     Zj_LiZhu_SuoLiang:integer;// 支架立柱缩量    0-100
     Zj_used_suo_Unit:double;// 可以使用的缩量单元
     Zj_Dl_Suoliange:integer;// 液压支架顶梁的伸缩  0-100
     Zj_Jiaojie_Jd:double;// 液压支架铰接梁的角度
     ZJ_First_HB_Jd,ZJ_Second_HB_Jd:double;// 支架一级互帮角度
     First_HB_Center,Second_Hb_Center:TPoint;//一级互帮 中心  二级互帮中心点
     First_HB_Li_Point:TPoint;// 一级护帮着力点
     Zj_StartPoint:Tpoint;//液压支架绘图开始基准点
     Zj_DL_EndPoint:TPoint;// 支架顶梁端头的节点
     Zj_Bei_L,Zj_Bei_Jd:Double;// 支架背板的长度  与角度
     Zj_Bei_First_St_Pt, Zj_Bei_First_ED_Pt:Tpoint;// 背板第一立柱的 两个端点
     Zj_Bei_Second_St_Pt, Zj_Bei_Second_ED_Pt:Tpoint;// 背板第二立柱的 两个端点
     Zj_Bei_Start_pt:TPoint;//背板的起点坐标
     Zj_Lizhu_First_St_Pt, Zj_Lizhu_First_ed_Pt:TPoint;// 第一根立柱 的两个端点
     Zj_Lizhu_Second_St_Pt, Zj_Lizhu_Second_ed_Pt:TPoint;// 第二根立柱 的两个端点
     Zj_blance_Qjd_st_pt,Zj_blance_Qjd_ed_pt:TPoint;// 平衡千斤顶的 两个端点
     Zj_First_hb_L:double;// 一级互帮的高度
     Disp_Tip:Boolean;// 是否找到标签，进行弹出
     Disp_ComeState:Integer;// 支架是否是来压状态  0 不标注来压状态  1 标注 正常受力  2 标注来压受力
     ReulerMark:Boolean; //支架是否进行标注
     TipHandle:HWND;// tip 弹出的handle;
     HB_H:Double;//液压支架互帮高度，
     HB_QD:double;// 液压支架护帮强度
  End;

  TLabelMark =Class
    private
       FStPoint,FEndPoint:TPoint;
       FCenterPoint:TPoint;
       FCanvas: TCanvas;
       FTitlle:String;
       FVisible,FArrowVisible:Boolean;
       FLineColor:TColor;
       FLineWidth:Integer;
       FlabelState:Integer;// 1 一般标尺  2 压力标尺

       function GetAngleFromTwoPoint(pt1,pt2:TPoint):Double; //返回两个点之间角度
       function GetLengthFromTwoPoint(pt1,pt2:TPoint):Double; //返回L的店之间的距离
       procedure BaseTWoPointDrawRuler(pt1,pt2:TPoint);  // 一般的尺寸标尺
       procedure BaseTWoPointDrawRockPress(pt1,pt2:TPoint);  // 一般的尺寸标尺
       function ChangeJdToHu(JiaoDu:Double):Double;// 把角度转变为可以 进行三角运算的弧度

   protected
        function GetVisible:Boolean;
        procedure SetVisible(Value:Boolean);
        function GetLineColor:TColor;
        procedure SetLineColor(Value:TColor);
        function GetLineWidth:Integer;
        procedure SetLineWidth(Value:integer);

        function GetCanvas: TCanvas;
        procedure SetCanvas(Value: TCanvas);
     published
        Property MotherCanvas: TCanvas  read GetCanvas write  SetCanvas;
        property Visible:Boolean read GetVisible write  SetVisible;
        property LineColor:TColor read GetLineColor write  SetLineColor;
        property LineWidth:Integer read GetLineWidth write  SetLineWidth;
     Public

        procedure  DrawMark(Disp:Boolean; FillColor:TColor);

     //系统函数
      constructor Create;
      destructor Destroy;
  End;
  TLinkMark =Class
     Private
      FCPt:TPoint;
      FRad:integer;
      FCanvas: TCanvas;
      FDoubleCycle:Boolean;
      FLineCenter:Boolean;
      DoubleDispLay:Boolean;
     protected
        function GetCentPt:TPoint;
        procedure SetCentPt(Value:TPoint);
        function GetRadio:Integer;
        procedure SetRadio(Value:Integer);
        function GetCanvas: TCanvas;
        procedure SetCanvas(Value: TCanvas);
     published
        property CenterPt:TPoint read GetCentPt write  SetCentPt;
        property Rad:Integer read GetRadio write  SetRadio;
        Property MotherCanvas: TCanvas  read GetCanvas write  SetCanvas;
     public

      procedure  DrawMark(Disp:Boolean; FillColor:TColor);
       //系统函数
      constructor Create;
      destructor Destroy;
  End;
  TDrawNode= Class
    private
       FPointCount:integer;
       FChildCount:integer;
       FMarkCount:integer;
       FLabelMarkCount:integer;
       PointNodes:Array of TPoint;
       FChlidClass: array of TDrawNode;
       FMarkArry :Array of TLinkMark;
       FMarkRuler:Array of TLabelMark;
       FCanvas: TCanvas;
       FCaption:String;
       FStartPoint,FEndPoint:TPoint;
       FWithoutYs,FmaxYs:TPoint;
       F_X_Unit,F_Y_Unit:double;
       ZJ_Disgn_Max_H,ZJ_Disgn_Min_H:double; //支架设计大的最大与最小高度
       ZJ_Use_Max_H,ZJ_Use_Min_H:double;// 支架使用的最大高度与最小高度
       Zj_Usual_F,ZJ_max_F:double;//液压支架正常工作阻力与最大工作阻力
       TipTimer:TTimer;
       TipCount:integer;
       TipMemo:TMemo;
       procedure ClearPoint;
       procedure ClearChlid;

    protected
       function GetPointCount:integer;
       function GetChlidCount:integer;
       function GetCaption:string;
       procedure SetCaption(Value:String);
       function GetStartPoint:TPoint;
       procedure SetStartPoint(Value:TPoint);
       function GetEndPoint:TPoint;
       procedure SetEndPoint(Value:TPoint);

       function GetXUnit:double;
       procedure SetXUnit(Value:double);
       function GetYUnit:double;
       procedure SetYUnit(Value:double);
     
       function GetCanvas: TCanvas;
       procedure SetCanvas(Value: TCanvas);

       function CalDis(pt1,pt2:TPoint):Double;
       function ChangeJdToHu(JiaoDu:Double):Double;// 把角度转变为可以 进行三角运算的弧度
       procedure Cal_Draw_RecInformation(var Rec:TDrawZjRecord);// 计算支架顶梁端头的节点
       function GetAngleFromTwoPoint(pt1,pt2:TPoint):Double; //返回两个点之间角度
       function GetLengthFromTwoPoint(pt1,pt2:TPoint):Double; //返回L的店之间的距离
       procedure BaseTWoPointDrawRect(pt1,pt2:TPoint;Rad:double;Circle:Boolean);
       function FromTwoPointCalMidPoint(jieCount:integer;pt1,pt2:TPoint;Suoliang:integer):TPoint;

       procedure TipTimeOnTime(Sender: TObject);
       function ReturnSuoLiang(Use_H: double): double;

    published
       property PointCount:Integer read GetPointCount ;
       property ChlidCount:Integer read GetChlidCount ;
       property Caption:string read GetCaption write  SetCaption;
       property StartPoint:TPoint read GetStartPoint write  SetStartPoint;
       property EndPoint:TPoint read GetEndPoint write  SetEndPoint;

       property X_Unit:double read GetXUnit write  SetXUnit;
       property Y_Unit:double read GetYUnit write  SetYUnit;



       Property MotherCanvas: TCanvas  read GetCanvas write  SetCanvas;
    public

       Function AddPointNode(pt:TPoint):Integer;
       function AddChildClass: TDrawNode;
       {AddMarkLabel 是添加连接的标注符号}
       function AddMarkLabel(pt:TPoint;Rad:integer;DoubleC,CenLine,Print_State:Boolean): TLinkMark;
        {AddMarkLabel 是添加液压支架的标尺}
       function AddLabelRuler(State:Integer;st,Ed:TPoint;Title:string;
                    Visible,Arrow:Boolean;LineColor:TColor):TLabelMark;
       procedure DrawCircle(Pt:TPoint;PointR:double;S_Jd,E_jd:integer);

       function  Draw_ZC_Zj(Rec:TDrawZjRecord):Boolean;  // 1绘制综采液压支架
       procedure Draw_Zc_Dz(Rec:TDrawZjRecord); // 1-1  综采液压支架底座
       procedure Draw_Zc_Dz_Fj_1(Rec:TDrawZjRecord); // 1-1-1  综采液压支架底座 附件
       procedure Draw_Zc_Dz_Fj_2(Rec:TDrawZjRecord); // 1-1-2  综采液压支架底座 推溜千斤顶

       procedure Draw_Zc_Dz_First(Rec:TDrawZjRecord); // 最先绘制的 图件

       procedure Draw_DL_Main(Rec:TDrawZjRecord);//2-0 绘制支架顶梁
       procedure Draw_DL_Public(Rec:TDrawZjRecord);// 2-1顶梁通用部分
       procedure Draw_DL_HuBang(Reco:TDrawZjRecord);// 2-2 液压支架互帮
       procedure Draw_Dl_First_Hb_Qjd(Reco:TDrawZjRecord);// 绘制一级护帮的千斤顶

       procedure Draw_DL_QianDuan(Reco:TDrawZjRecord);// 2-1顶梁前面部分


       procedure Draw_beiban(Rec:TDrawZjRecord);// 3-1 绘制背板
       procedure Draw_BeiBan_Lizhu(Rec:TDrawZjRecord);//3-0 绘制液压支架
       procedure Draw_balance_Qjd(Rec:TDrawZjRecord);// 绘制平衡千斤顶
       procedure Draw_Lizhu(Rec:TDrawZjRecord);// 绘制液压支架的立柱

       procedure Draw_Reluer(Rec:TDrawZjRecord);//绘制液压支架的整体标尺

       procedure DrawAndFill(FillVis:Boolean;PenSize:integer;FillColor:TColor);
       procedure Draw_Xc(Rec:TDrawZjRecord;FillC:TColor);  //绘制销子

       function DispClickLabel(Memo:TMemo;pt0,pt1:TPoint;Rec:TDrawZjRecord):String;
       procedure DisptipMemo(Memo:TMemo;pt:TPoint;title:string);

       procedure ClearAll;
    //系统函数
      constructor Create;
      destructor Destroy;
  End;
  //定义支架类
  TZJ_Class=class
      private
           Draw_zj:TDrawNode;
           function CalMyMBPh_H( gzm:TG_Stope):double;//计算我自己的煤壁片帮 高度
           procedure Cal_Main_Support(Imm_F:double;gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof); // 计算支架阻力 的函数
           procedure Cal_Main_Support_OneRock(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof;Imm_F,C0_xs,Ci_Xs:double); // 单岩梁计算方法
           procedure Change_F_to_P_Support(imm_P:double);
           function GetImmP0(gzm:TG_Stope):double; //获得支架上方对煤的压力
           procedure SplitZhijiaDisg_maxMin_H(ZhijaN:string);
           function ReturnSuoLiang(Use_H: double): double;
           function ChangeHBGDToYUnit(HBG:Double):Double;// 把护帮高度换算为 YUnit的单位

           procedure ZongheMbph(gzm:TG_Stope);// 煤壁片帮的综合意见
      public
         Zj_Name: WideString;    //支架的名称
         ZJ_Disg_max_H,Zj_Disg_Min_H:double;// 液压支架设计的最大与最小高度
         ZJ_Tu_Bianhao:widestring; //支架图例编号
         Zj_BianHao:WideString;  //支架的编号
         Zj_XingHao:WideString;   //支架的型号
         Zj_Lizhu_count: Integer;  //支架立柱数量
         Zj_toall_F:double;       //支架整架阻抗力
         zj_toall_P:double;       //支架支护强度
         Zj_suoliang:double;      //支架最大缩量
//         Zj_Max_h:double;         //支架最大高度
//         Zj_min_h:double;         //支架最小高度
         Zj_KongdingJU:double;    //支架控顶距
         Zj_zhongxinju:double;    //支架中心矩
         Zj_hlzyd:double;        //合力作用点
         Zj_hubang_h:double;      //支架护帮高度
         Zj_hubang_jishu:integer;  //支架护帮级数
         zj_hubang_F:double;     //支架护帮阻力
         zj_hubang_P:double;     //支架护帮强度
         Zj_JiSuan_suoliang: double;// 支架计算的缩量
         Zj_JiSuan_C0_F: array[0..2] of double;// 初次来压时支架计算的阻力  0 最大值 1 最小值 2 平均值
         Zj_JiSuan_C0_P: array[0..2] of double;// 初次来压时支架计算的支护强度  0 最大值 1 最小值 2 平均值
         Zj_JiSuan_Ci_F: array[0..2] of double;// 周期来压时支架计算的阻力  0 最大值 1 最小值 2 平均值
         Zj_JiSuan_Ci_P: array[0..2] of double;// 周期来压时支架计算的支护强度  0 最大值 1 最小值 2 平均值
         Zj_emp1_Formula:array[0..2] of double;// 经验方程1 计算支护强度
         Zj_emp2_Formula:array[0..2] of double;// 经验方程2 计算支护强度
         Zj_emp3_Formula:array[0..2] of double;// 经验方程2 计算支护强度
         Zj_Jisuan_SL: array[0..2] of double;// 支架计算的缩量  0 最大值 1 最小值 2 平均值
         { '(0) 综合分析方法（1）统计经验  ，(2)为剪切滑移面(3) 内摩擦角计算,
            (4)横拱式片帮,(5)为压杆计算,(6)支架工作阻力方式计算}
         Zj_JiSuan_hubang_H: array[0..6] of double;// 支架计算互帮高度
         Zj_JiSuan_hubang_P: array[0..2] of double;// 支架计算互帮强度   0 最大值 1 最小值 2 平均值
         Zi_JiSuan_hubang_s: array[0..6] of double;// 煤壁片帮深度   '(0)为剪切滑移面，(1)为内摩擦角计算,(2)为压杆计算,(3)为煤体自身能力 ,(4)支架工作阻力方式计算
         JG_jx:widestring;     //  架型结构
         JG_Dl:widestring;     //  顶梁结构
         JG_Dz:widestring;     // 底座结构
         JG_slg:widestring;     // 四连干结构
         JG_ty:widestring;     // 推移结构
         JG_Fm:widestring;     // 放煤结构
         JG_Wl:widestring;     // 尾梁结构
         JG_Qc:widestring;     // 前梁、尾梁侧护板
         JG_Ct:widestring;     // 侧推结构
         JG_Dt:widestring;     //底调结构
         JG_Ql:widestring;     //前梁结构
         ZJ_JianYi_Type:Widestring;  //支架的选择型号
         zhiJia_F_xs  :double; // 支架阻力修订系数
         zhijia_L_xs  :double; // 支架缩量修订系数
         zhijia_hb_Q_xs :double;// 支架护帮强度修订系数
         Zj_DBFD_xs:  array[1..9] of double;// 保存不同类别的 参数
         OcxPath:widestring; //Ocx路径
         Zj_imm_p:double; // 支架支撑直接顶的压强
         Zj_old_C0_p:array[0..2] of double;// 初次来压时支架计算的支护强度  0 最大值 1 最小值 2 平均值
         Zj_old_Ci_p:array[0..2] of double;// 周期来压时支架计算的支护强度  0 最大值 1 最小值 2 平均值
         Zj_Lz_Diameter:double; //立柱的直径

         function  Init(str:wideString;out sEorr:Widestring):WordBool; //初始化支架
         procedure Cal_empirical_formula1(gzm:TG_Stope); //动载系数法
         procedure Cal_empirical_formula2(gzm:TG_Stope); //开采高度法
         procedure Cal_empirical_formula3(gzm:TG_Stope;imm:TImmediate_roof;old:Told_roof); //经验公式法
         procedure Cal_sup_Beam_def(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof); //挠曲法计算压强
         procedure Cal_Sup_Beam_step( gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof);//步距法计算压强
         function  OneBeam_sup(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):double; // 单岩梁计算压力
         function  ManyBeam_sup(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):double ; // 多梁计算压力
         procedure  Having_stress(gzm: TG_Stope; Zk: Tzk_bore; mm: TImmediate_roof; old: Told_roof;
                                  idefOrStep:string;BeamNumber:integer;MaxV,MinV:double); // 有内应力计算压力
         function  NOHaving_stress(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):double ; // 无内应力计算压力
         procedure  Calculate_weight(gzm:TG_Stope;Zk:Tzk_bore;old:Told_roof;defOrStep:string;BeamNumber:integer;
                    var maxV,minV :double);

         function  Cal_Sup_Para(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString; //计算支架参sh

         function  DzXd_Cal_sup_para(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString; //  根据地质条件修订支架的基本参数
         function  Return_zj_Para(Version:WideString):WideString;   //返回支架参数
         function  SpliJG(str:widestring;out sEorr:widestring):WordBool; //拆分传入支架结构字符串
         function  ReadZhijia_XS(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString; //计算支架参sh
         procedure Draw_zhiJia(Image:TImage;x1,y1,x2,y2,mc_h:double;lizhushu,jia_type:integer);// jia_type 1 综采  2 综放
         //----------------------
         function  MainDraw_Class_Zj(Image:TImage;pt1,pt2:TPoint;Mc_h:double;Rec:TDrawZjRecord):integer;// 绘制液压支架的类 主函数
         procedure TipMessage(Memo:TMemo;pt0,pt1:TPoint;Rec:TDrawZjRecord);
         //---------------------
         procedure Revision_ZhiJiaZuli;// 修订支架阻力 根据现场的情况
         //系统函数

         constructor Create;
         destructor Destroy;
  end;

implementation

{ TZJ_Class }

procedure TZJ_Class.Calculate_weight(gzm: TG_Stope; Zk: Tzk_bore;
  old: Told_roof; defOrStep: string; BeamNumber: integer; var maxV,
  minV: double);
begin
   maxV:=0;MinV:=0;
   if defOrStep='Def' then  begin
      if BeamNumber+1>old.YL_Dep_struct then  exit;
      maxV:=zk.Beam_Def[BeamNumber].Step_0_Simple* (zk.Beam_Def[BeamNumber].Ztc_ms+
               zk.Beam_Def[BeamNumber].Sdc_mc)*25;
      minV:=zk.Beam_Def[BeamNumber].Step_0_Compr* (zk.Beam_Def[BeamNumber].Ztc_ms+
               zk.Beam_Def[BeamNumber].Sdc_mc)*25;
   end else begin
      if BeamNumber+1>old.YL_Step_struct then  exit;

      maxV:=zk.Beam_step[BeamNumber].Step_0_Simple* (zk.Beam_step[BeamNumber].Ztc_ms+
               zk.Beam_step[BeamNumber].Sdc_mc)*25;
      minV:=zk.Beam_step[BeamNumber].Step_0_Compr* (zk.Beam_step[BeamNumber].Ztc_ms+
               zk.Beam_step[BeamNumber].Sdc_mc)*25;

   end;
end;

function TZJ_Class.CalMyMBPh_H (gzm:TG_Stope): double;

    { (6) 支架工作状态煤体高度计算    是一个分段函数
            Hde=  2*c tan(0.25 *3.14 + 0.5 *  gzm.S_M_mcj) /r   K=0
            (2*c/r+ K/r) *tan(0.25 *3.14 + 0.5 *  gzm.S_M_mcj)  0<K < 2C
            4*c tan(0.25 *3.14 + 0.5 *  gzm.S_M_mcj) /r   K=2C
      其中： K= sqrt(4 c*c -2 P0 r tan(0.25* 3.14 -0.5* gzm.S_M_mcj  );
     }
var
  Ki, Q1,Q2:double;
  p0:double;
  Ret:double;
begin

  Q1:=tan(0.25 *3.1415926 - 0.5 * gzm.S_M_mcj);
  Q2:=tan(0.25 *3.1415926 + 0.5 * gzm.S_M_mcj);
  P0:=GetImmP0(gzm);
  Ki:=4 * gzm.S_M_njl * gzm.S_M_njl - 2*  P0* 15  * Q1   ;
  if Ki <=0  then  begin
     Ret:=2*gzm.S_M_njl / 15  * Q2;
  end else if sqrt(Ki)< 2*gzm.S_M_njl then  begin
     Ret:=(2*gzm.S_M_njl +sqrt(Ki) ) / 15  * Q2;
  end else begin
     Ret:=(4*gzm.S_M_njl  ) / 15  * Q2;
  end;

  Result:=gzm.S_Cg_h - Ret;

end;

procedure TZJ_Class.Cal_empirical_formula1(gzm: TG_Stope);
var
  fujia_C:double;
begin
     {
     Q=h*r*D/(k-1)cosa *B
     Q 液压支架的支护强度；h 工作面开采采高   r顶板岩石容量   2.5
     D 顶板来压动载系数  ci <8 D=1.1; Ci <=15 D =1.3 ;ci<=20 D= 1.5  Ci >=25 D=1.7
     k 顶板岩石破碎膨胀系数    a工作面倾角
     B 附加阻力系数 两立柱取 1.2，四立柱取 1.6
     }
     if self.Zj_Lizhu_count=2 then  fujia_C:=1.2  else   fujia_C:=1.6 ;
     //最大值
     self.Zj_emp1_Formula[0]:=gzm.S_Cg_h*25*gzm.dynamic_factor* (fujia_C+0.1);
        self.Zj_emp1_Formula[0]:=self.Zj_emp1_Formula[0]/((1.1-1)*cos(gzm.S_qj/180.0*3.14159));
     //最小值
     self.Zj_emp1_Formula[1]:=gzm.S_Cg_h*23*gzm.dynamic_factor* (fujia_C-0.1);
        self.Zj_emp1_Formula[1]:=self.Zj_emp1_Formula[0]/((1.3-1)*cos(gzm.S_qj/180.0*3.14159));
     //中间值
     self.Zj_emp1_Formula[2]:=gzm.S_Cg_h*24*gzm.dynamic_factor* (fujia_C);
        self.Zj_emp1_Formula[2]:=self.Zj_emp1_Formula[0]/((1.2-1)*cos(gzm.S_qj/180.0*3.14159));


end;

procedure TZJ_Class.Cal_empirical_formula2(gzm: TG_Stope);
begin
    {
     Q=KHR
     Q 液压支架的支护强度；  r顶板岩石容量   2.5
     k 作用于支架上的顶板岩石系数    一般取 5-8
     h 工作面开采采高
     }
     //最大值
     self.Zj_emp2_Formula[0]:=gzm.S_Cg_h*25*8;
     //最小值
     self.Zj_emp2_Formula[1]:=gzm.S_Cg_h*23*5;
     //中间值
     self.Zj_emp2_Formula[2]:=gzm.S_Cg_h*24*6.5;
end;

procedure TZJ_Class.Cal_empirical_formula3(gzm: TG_Stope; imm: TImmediate_roof;
  old: Told_roof);
var
   N: double;
begin
    { 史学伟经验公式
      q=72.3M + 4.5 L2 +78.9 Ls-10.24N-62..1
      M 开采高度
      L2 老顶来压步距
      Ls 控顶宽度
    }
    N:=imm.Immroof_M/gzm.S_Cg_h;

     //最大值
     self.Zj_emp3_Formula[0]:=gzm.S_Cg_h*72.3+old.YL_Zhouqi_step[0]*4.5+78.9*self.Zj_KongdingJU
                  -10.24*N-62.1;
     //最小值
     self.Zj_emp3_Formula[1]:=gzm.S_Cg_h*72.3+old.YL_Zhouqi_step[1]*4.5+78.9*self.Zj_KongdingJU
                  -10.24*N-62.1;
     //中间值
     self.Zj_emp3_Formula[2]:=gzm.S_Cg_h*72.3+old.YL_Zhouqi_step[2]*4.5+78.9*self.Zj_KongdingJU
                  -10.24*N-62.1;
end;

procedure TZJ_Class.Cal_Main_Support(Imm_F:double;gzm: TG_Stope; Zk: Tzk_bore;
  imm: TImmediate_roof; old: Told_roof);
  {

     2013年12月为郑州煤机厂制定如下系数准则：
     （1）当有内应力场， 是单岩梁结构，考虑支架的让压作用  在初次来压阶段  系数暂定为 0.25 ，在周期来压阶段 系数暂定为 0.5
                          多岩梁结构，考虑支架的支撑作用  在初次来压阶段  系数暂定为 0.5 ，在周期来压阶段 系数暂定为 0.8
     （2）当无内应力场， 是单岩梁结构，考虑支架的让压作用  在初次来压阶段  系数暂定为 0.4 ，在周期来压阶段 系数暂定为 0.6
                          多岩梁结构，考虑支架的支撑作用  在初次来压阶段  系数暂定为 0.6 ，在周期来压阶段 系数暂定为 1



  }
begin

 //判断内应立场的作用

   old.YL_min_m:=Zk.Beam_step[0].Ztc_ms;
   old.YL_max_m:=old.YL_min_m+gzm.S_Cg_h;


  if gzm.ZCYL_s0>1 then   begin        //     1----  有内应力场
         if old.YL_struc =1 then begin   //   begin  2----单岩梁结构
            Cal_Main_Support_OneRock(gzm,zk,imm,old,imm_f,Zj_DBFD_xs[1],Zj_DBFD_xs[2]);
         end else begin   //多岩梁结构
            Cal_Main_Support_OneRock(gzm,zk,imm,old,imm_f,Zj_DBFD_xs[3],Zj_DBFD_xs[4]);
         end;
  end else begin  //无内应立场
         if old.YL_struc =1 then begin   //   begin  2----单岩梁结构
            Cal_Main_Support_OneRock(gzm,zk,imm,old,imm_f,Zj_DBFD_xs[6],Zj_DBFD_xs[7]);
         end else begin   //多岩梁结构
            Cal_Main_Support_OneRock(gzm,zk,imm,old,imm_f,Zj_DBFD_xs[8],Zj_DBFD_xs[9]);
         end;
  end;
end;

procedure TZJ_Class.Cal_Main_Support_OneRock(gzm: TG_Stope; Zk: Tzk_bore;
  imm: TImmediate_roof; old: Told_roof;Imm_F,C0_xs,Ci_Xs:double);
var
  Old_C0_F  :array[0..2] of double; // 老顶初次来压时支架的受力  0  最大值 1 最小值 2 平均值
  Old_Ci_F  :array[0..2] of double;  // 老顶周期来压时支架的受力  0  最大值 1 最小值 2 平均值
  Old_C0_L  :array[0..2] of double; // 老顶初次来压时支架的缩量   0  最大值 1 最小值 2 平均值
  Old_Ci_L  :array[0..2] of double;  // 老顶周期来压时支架的缩量  0  最大值 1 最小值 2 平均值
  //    : double;//不同结构下岩梁的分担系数
begin
    //老顶初次来压 //压力
    Old_C0_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*C0_Xs;    //阻力最大值
    Old_C0_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*C0_Xs;  //阻力最小值
    Old_C0_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*C0_Xs;  //阻力平均值
    //缩量
//    Old_C0_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h-imm.Immroof_M* 0.2)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[1];  //缩量最大值
//    Old_C0_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h-imm.Immroof_M* 0.2)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[0];  //缩量最 小值
//    Old_C0_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h-imm.Immroof_M* 0.2)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[2];  //缩量平均值

    Old_C0_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h-imm.Immroof_M* 0.2)*(ZJ_hlzyd)/old.YL_First_step[1];  //缩量最大值
    Old_C0_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h-imm.Immroof_M* 0.2)*(ZJ_hlzyd)/old.YL_First_step[0];  //缩量最 小值
    Old_C0_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h-imm.Immroof_M* 0.2)*(ZJ_hlzyd)/old.YL_First_step[2];  //缩量平均值

    //老顶周期来压

    Old_Ci_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*Ci_xs*gzm.Ci_xs;    //阻力最大值
    Old_Ci_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*Ci_xs*gzm.Ci_xs;  //阻力最小值
    Old_Ci_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*Ci_xs*gzm.Ci_xs;  //阻力平均值

     //缩量
//    Old_Ci_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h-imm.Immroof_M* 0.2)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[1]*gzm.Ci_xs);  //缩量最大值
//    Old_Ci_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h-imm.Immroof_M* 0.2)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[0]*gzm.Ci_xs);  //缩量最小值
//    Old_Ci_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h-imm.Immroof_M* 0.2)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[2]*gzm.Ci_xs);  //缩量平均值

    Old_Ci_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(ZJ_hlzyd)/(old.YL_First_step[1]*gzm.Ci_xs);  //缩量最大值
    Old_Ci_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h-imm.Immroof_M* 0.15)*(ZJ_hlzyd)/(old.YL_First_step[0]*gzm.Ci_xs);  //缩量最小值
    Old_Ci_L[2] :=(Old_Ci_L[0] +Old_Ci_L[1])  /2 ;//缩量平均值


    //给类里面的压力与压强赋值
    Zj_jisuan_C0_F[0]:=Old_C0_F[0]*zhiJia_F_xs;  //最大
           Zj_jisuan_C0_F[1]:=Old_C0_f[1]*zhiJia_F_xs; // 最小
              Zj_jisuan_C0_F[2]:=Old_C0_f[2]*zhiJia_F_xs;  //平均

    Zj_jisuan_Ci_F[0]:=Old_Ci_F[0]*zhiJia_F_xs;    //最大
            Zj_jisuan_Ci_F[1]:=Old_Ci_f[1]*zhiJia_F_xs;  // 最小
               Zj_jisuan_Ci_F[2]:=Old_Ci_f[2]*zhiJia_F_xs;  //最大  最小 平均

     //支架的缩量 进行赋值
    Zj_jisuan_sl[0]:=Old_Ci_L[0]*zhiJia_L_xs;
    Zj_jisuan_sl[1]:=Old_Ci_L[1]*zhiJia_L_xs;
    Zj_jisuan_sl[2]:=Old_Ci_L[2]*zhiJia_L_xs;

end;

procedure TZJ_Class.Cal_sup_Beam_def(gzm: TG_Stope; Zk: Tzk_bore;
  imm: TImmediate_roof; old: Told_roof);
begin

end;

procedure TZJ_Class.Cal_Sup_Beam_step(gzm: TG_Stope; Zk: Tzk_bore;
  imm: TImmediate_roof; old: Told_roof);
begin

end;

function TZJ_Class.Cal_Sup_Para(gzm: TG_Stope; Zk: Tzk_bore;
  imm: TImmediate_roof; old: Told_roof): WideString;
  var
     Imm_F     :double ; //支架支撑直接顶的力
     Imm_P     :double;  //支架支撑直接顶的压强
     Imm_f_z   :double; //直接顶的悬顶系数
     Imm_ls    :double;//直接顶的悬顶距离
     Q1,Q2,Q3,Q0:double;// 计算互帮强度所需连是变量 Q1 直接顶的载荷 Q2 前方支撑压力的载荷 Q3 老顶通过基本顶传递的载荷  Q0 煤壁承担载荷
     i:integer;
   begin
      //单体支架另行处理
      if Trim(ZJ_Name)= '单体' then   begin
        Exit;
      end;
      //验证支架是否被初始化
      if length(Trim(Zj_XingHao))<1 then  begin   //验证支架是否被初始化
          ZJ_Zhongxinju:=1.5 ;//给支架中心距赋默认值
          ZJ_KongdingJu:=5 ;//给支架控顶距赋默认值
          ZJ_hlzyd:=3 ;//给支架合作作用点赋默认值

      end; //end  length(Trim(Zj_XingHao))>0
       //初始化支架修订参数
     DzXd_Cal_sup_para(gzm,zk,imm,old);
      //读取文件
     ReadZhijia_XS(gzm,zk,imm,old);
      //计算支架的悬顶系数
      if gzm.S_Fm_h> 1 then  begin   //20150506 edit
          Imm_ls:=0;
      end else begin
         if Imm.Immroof_C0*0.3>ZJ_Kongdingju then  begin  //判断支架控顶距与直接顶周期跨落的关系
              if Imm.Immroof_C0*0.3- ZJ_Kongdingju > gzm.S_Cg_h then  begin
                 Imm_ls:=(gzm.S_Cg_h)+ imm.Immroof_M/2*tan(30/180*3.14159);
              end else begin
                 Imm_ls:=( Imm.Immroof_C0*0.3- ZJ_Kongdingju)+ imm.Immroof_M/2*tan(30/180*3.14159);
              end;
         end else begin
              Imm_ls:=imm.Immroof_M/2*tan(30/180*3.14159);
         end;
      end;
     Imm_f_z :=ZJ_KongDingJu*Power(1*Imm_ls/ZJ_Kongdingju,2)/2/ZJ_hlzyd;
     //计算支架支撑直接顶的需要的力  //201505060edit

     if gzm.S_Fm_h> 1 then  begin   //20150506 edit
        Imm_P:= Imm.Immroof_M *25 * Imm_f_z/ZJ_KongDingJu*(ZJ_KongDingJu-gzm.S_Fm_h*tan(30/180*3.14159));          //  直接顶的压强
     end else begin
        Imm_P:= Imm.Immroof_M *25 * Imm_f_z;          //  直接顶的压强
     end;

    Imm_F:= ZJ_Kongdingju * ZJ_ZhongxinJu *Imm_P ;
    zj_imm_p:=Imm_P/1000;

    old.YL_min_m:=Zk.Beam_step[0].Ztc_ms;
    old.YL_max_m:=old.YL_min_m+gzm.S_Cg_h;
    //计算液压支架阻力与缩量
    Cal_Main_Support(imm_f,gzm,zk,imm,old);
    // 对计算的液压支架数据进行强制修订  20160506
    Revision_ZhiJiaZuli ;
    // 对 放顶煤的信息进行修订
    if  gzm.S_Fm_h>0 then begin
      for I := 0 to 2 do
       begin
                 Zj_jisuan_C0_F[i]:=Zj_jisuan_C0_F[i]*(1-gzm.S_Fm_h/(gzm.S_Fm_h+gzm.S_Cg_h));
                 Zj_jisuan_Ci_F[i]:=Zj_jisuan_Ci_F[i]*(1-gzm.S_Fm_h/(gzm.S_Fm_h+gzm.S_Cg_h));

       end;

   end;

   // 计算液压支架的支护强度
   Change_F_to_P_Support(zj_imm_p);

   //====================以下为计算煤壁片帮的数据
  //计算片帮高度
   ZongheMbph(gzm);
  //煤壁互帮强度计算
   Q1:= Imm_P;
   if(gzm.ZCYL_s1[0]=0) then begin
          Q2:= gzm.ZCYL_s0 * gzm.ZCYL_s0 / 2 * gzm.S_K_zcfz * gzm.S_Cg_h * 25 ;
   end else begin
          Q2:= gzm.ZCYL_s0 * gzm.ZCYL_s0 / 2 / gzm.ZCYL_s1[0]   * gzm.S_K_zcfz * gzm.S_Cg_h * 25 ;
   end;

   Q3:= old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*0.5*0.3;
   Q0:=Q1+Q2+Q3-GetImmP0(gzm)*1000*Zj_zhongxinju*zj_kongdingju*cos(70.0/180*3.1415926);
   if Q0<0 then  Q0:=0;      //强制处理
   if Q0>500 then  Q0:=500;  //强制处理
//  计算支架的护帮强度
   Zj_jisuan_hubang_p[2]:=(Q0+0.5*gzm.ZCYL_s0*Zj_JiSuan_hubang_H[0]*15)/1000/Zj_JiSuan_hubang_H[0]*self.zhijia_hb_Q_xs;


end;

function TZJ_Class.ChangeHBGDToYUnit(HBG: Double): Double;
{
   把护帮高度换算为 YUnit的单位
}
begin
   Result:=50/ZJ_Disg_max_H * HBG;
end;

procedure TZJ_Class.Change_F_to_P_Support(imm_P: double);
begin
          //支架的支护强度 初次
    Zj_jisuan_C0_p[0]:= Zj_jisuan_C0_F[0]/zj_kongdingju/zj_zhongxinju/1000;
       zj_old_C0_p[0]:= Zj_jisuan_C0_p[0]-imm_P;
    Zj_jisuan_C0_p[1]:= Zj_jisuan_C0_F[1]/zj_kongdingju/zj_zhongxinju/1000;
       zj_old_C0_p[1]:= Zj_jisuan_C0_p[1]-imm_P;
    Zj_jisuan_C0_p[2]:= Zj_jisuan_C0_F[2]/zj_kongdingju/zj_zhongxinju/1000;
       zj_old_C0_p[2]:= Zj_jisuan_C0_p[2]-imm_P;

     //支架的支护强度  周期
    Zj_jisuan_Ci_p[0]:= Zj_jisuan_Ci_F[0]/zj_kongdingju/zj_zhongxinju/1000;
        zj_old_Ci_p[0]:= Zj_jisuan_Ci_p[0]-imm_P;
    Zj_jisuan_Ci_p[1]:= Zj_jisuan_Ci_F[1]/zj_kongdingju/zj_zhongxinju/1000;
        zj_old_Ci_p[1]:= Zj_jisuan_Ci_p[1]-imm_P;
    Zj_jisuan_Ci_p[2]:= Zj_jisuan_Ci_F[2]/zj_kongdingju/zj_zhongxinju/1000;
        zj_old_Ci_p[2]:= Zj_jisuan_Ci_p[2]-imm_P;

end;

constructor TZJ_Class.Create;
begin
    Draw_zj:=TDrawNode.Create ;
end;

destructor TZJ_Class.Destroy;
begin
   if Assigned(Draw_zj) then   FreeAndNil(Draw_zj);

end;

procedure TZJ_Class.Draw_zhiJia(Image: TImage; x1, y1, x2, y2, mc_h: double;
  lizhushu, jia_type: integer);
var
    zJ_H,zJ_w :double;
     Points: array[0..3] of TPoint;
     bitmap1:Tbitmap;//创建位图 bitmap1
 begin
  //=====================
    zj_w:=x2-x1;
    zj_h:=y2-y1;

    if jia_type=1  then begin    //综采支架
        //画底座    综采支架
        Image.Canvas.Pen.Width :=1;
        Image.Canvas.Pen.Color :=$000000;
        Image.Canvas.MoveTo(trunc(x1+zj_w/60*27),trunc(y2));
        Image.Canvas.LineTo(trunc(x2-zj_w/60*3),trunc(y2));
        Image.Canvas.LineTo(trunc(x2-zj_w/60*3),trunc(y2-zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*13),trunc(y2-zj_H/60*12)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*20),trunc(y2-zj_H/60*8)) ;
        Image.Canvas.LineTo(trunc(x1+zj_w/60*27),trunc(y2-zj_H/60*8)) ;
        Image.Canvas.LineTo(trunc(x1+zj_w/60*27),trunc(y2));
        //画背梁支撑  综采支架
        Image.Canvas.Pen.Width :=1;
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*3),trunc(y2-zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*1),trunc(y2-zj_H/60*20)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*2),trunc(y2-zj_H/60*20)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*4),trunc(y2-zj_H/60*6)) ;

        Image.Canvas.MoveTo(trunc(x2-zj_w/60*13),trunc(y2-zj_H/60*12)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*6),trunc(y2-zj_H/60*30)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*5),trunc(y2-zj_H/60*28)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y2-zj_H/60*11)) ;
        //画背梁   综采支架
        Image.Canvas.MoveTo(trunc(x2),trunc(y2-zj_H/60*20)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*13),trunc(y2-zj_H/60*58)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*15),trunc(y2-zj_H/60*56)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*2),trunc(y2-zj_H/60*18)) ;
        Image.Canvas.LineTo(trunc(x2),trunc(y2-zj_H/60*20)) ;
        ////画顶梁   综采支架
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*12),trunc(y1)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y1+zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y1)) ;

        if mc_h>2.5 then  begin
             //伸缩梁  综采支架
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*58),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*58),trunc(y1+zj_H/30*2)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*2)) ;
            // //护帮  综采支架
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*58),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1+zj_H/30*13)) ;
            Image.Canvas.LineTo(trunc(x1+zj_w/60*1),trunc(y1+zj_H/30*13)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*57),trunc(y1+zj_H/30*2)) ;

        end else begin
             //伸缩梁  综采支架
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1+zj_H/30*2)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*2)) ;
        end;
         //立柱  综采支架
        if lizhushu=2 then  begin  // 两立柱   综采支架
           if mc_h>=4.0 then  begin  // 双伸缩  综采支架
                 // 下柱筒  综采支架
                 Points[0].X:=trunc(x2-zj_w/60*23);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*27);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*31);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*27);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // 中柱筒  综采支架
                 Points[0].X:=trunc(x2-zj_w/60*27.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*31.5);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*34.5);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*30.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // 上柱筒  综采支架
                 Points[0].X:=trunc(x2-zj_w/60*32);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*34);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*36);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*34);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end else begin  // // 单伸缩   综采支架
                 Points[0].X:=trunc(x2-zj_w/60*23);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*27);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*31);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*27);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // 上柱筒    综采支架
                 Points[0].X:=trunc(x2-zj_w/60*28);       Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*31);       Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*33);       Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*30);       Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end;    //end  if zj_h> 40 then  begin  // 双伸缩  综采支架

        end else begin   // 四立柱  综采支架
               if mc_h>=4.0 then  begin  // 双伸缩  综采支架
                 // 后柱下柱筒 综采支架
                 Points[0].X:=trunc(x2-zj_w/60*14);                  Points[0].Y:=trunc(y2-zj_H/60*9);
                 Points[1].X:=trunc(x2-zj_w/60*14);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*18);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*18);                  Points[3].Y:=trunc(y2-zj_H/60*9);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // 后柱下中柱筒  综采支架
                 Points[0].X:=trunc(x2-zj_w/60*14.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*14.5);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*17.5);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*17.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // 后柱上下柱筒 综采支架
                 Points[0].X:=trunc(x2-zj_w/60*15);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*15);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*17);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*17);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);
                 // 前柱下柱筒  综采支架
                 Points[0].X:=trunc(x2-zj_w/60*26);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*29);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*33);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*30);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // 前柱中柱筒   综采支架
                 Points[0].X:=trunc(x2-zj_w/60*29.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*32);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*35);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*32.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // 前柱上柱筒 综采支架
                 Points[0].X:=trunc(x2-zj_w/60*32.5);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*34);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*36);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*34.5);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end else begin  // // 单伸缩  综采支架
                 // 后柱 下竹筒   综采支架
                 Points[0].X:=trunc(x2-zj_w/60*14);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*14);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*18);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*18);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // 后柱 上柱筒  综采支架
                 Points[0].X:=trunc(x2-zj_w/60*15);       Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*15);       Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*17);       Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*17);       Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);
                  // 前柱下柱筒   综采支架
                 Points[0].X:=trunc(x2-zj_w/60*26);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*29);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*33);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*30);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                  Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                    // 前柱上柱筒 综采支架
                 Points[0].X:=trunc(x2-zj_w/60*30);                  Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*32);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*34);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*32);                  Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end;    //end  if zj_h> 40 then  begin  // 双伸缩
        end;  //end 立柱数目
        //画背后矸石   综采支架
        //上段        综采支架
         {  Points[0].X:=trunc(x2-zj_w/60*8);                  Points[0].Y:=trunc(y1);
           Points[1].X:=trunc(x2-zj_w/60*10);                 Points[1].Y:=trunc(y2-zj_H/60*50);
           Points[2].X:=trunc(x2);                            Points[2].Y:=trunc(y2-zj_H/60*20);
           Points[3].X:=trunc(x2);                            Points[3].Y:=trunc(y1);
           Image.Canvas.Brush.Bitmap:=nil;
           Image.Canvas.Polygon(Points) ;
           bitmap1:=Tbitmap.Create;//创建位图 bitmap1
          // if  fileexists(dll_Path+'\BmpSi\矸石.Bmp') then  begin
          //            bitmap1.LoadFromFile(dll_Path+'\BmpFZ\矸石.Bmp');//装入图像文件
           bitmap1.LoadFromFile('C:\矸石.Bmp');//装入图像文件
           Image.Canvas.Brush.Bitmap:=bitmap1;
           Image.Canvas.FloodFill( Points[0].X+3,Points[0].Y+1,$000000,fsBorder);
           Image.Canvas.Brush.Bitmap:=nil;
            //下段   综采支架
           Points[0].X:=Points[2].X;                         Points[0].Y:=Points[2].Y;
           Points[1].X:=trunc(x2-zj_w/60*3);                 Points[1].Y:=trunc(y2-zj_H/60*6);
           Points[2].X:=trunc(x2-zj_w/60*3);                 Points[2].Y:=trunc(y2);
           Points[3].X:=trunc(x2);                           Points[3].Y:=trunc(y2);
           Image.Canvas.Polygon(Points) ;
           bitmap1:=Tbitmap.Create;//创建位图 bitmap1
           bitmap1.LoadFromFile(dll_Path+'\BmpSi\矸石.Bmp');//装入图像文件

           Image.Canvas.Brush.Bitmap:=bitmap1;
           Image.Canvas.FloodFill( Points[2].X+1,Points[2].Y-1,$000000,fsBorder);
           Image.Canvas.Brush.Bitmap:=nil;
           bitmap1.free;
         }
           //画刮板输送机
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*40),trunc(y2));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*52),trunc(y2));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*52),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y2-zj_H/60*1));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*41),trunc(y2-zj_H/60*1));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*41),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*40),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*40),trunc(y2));
    end else begin     //综放
          //画底座   //综放
        Image.Canvas.Pen.Width :=1;
        Image.Canvas.Pen.Color :=$000000;
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*40),trunc(y2));
        Image.Canvas.LineTo(trunc(x2-zj_w/60*13),trunc(y2));
        Image.Canvas.LineTo(trunc(x2-zj_w/60*13),trunc(y2-zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*16),trunc(y2-zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*16),trunc(y2-zj_H/60*9)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*20),trunc(y2-zj_H/60*9)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*20),trunc(y2-zj_H/60*12)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*23),trunc(y2-zj_H/60*12)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*24),trunc(y2-zj_H/60*8)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*40),trunc(y2-zj_H/60*8)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*40),trunc(y2));
        //画背梁支撑   //综放
        Image.Canvas.Pen.Width :=1;
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*16),trunc(y2-zj_H/60*9)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*11),trunc(y2-zj_H/60*25)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y2-zj_H/60*25)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*17),trunc(y2-zj_H/60*9)) ;

        Image.Canvas.MoveTo(trunc(x2-zj_w/60*21),trunc(y2-zj_H/60*11)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*16),trunc(y2-zj_H/60*35)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*17),trunc(y2-zj_H/60*35)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*22),trunc(y2-zj_H/60*12)) ;
        //画背梁   //综放
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*9),trunc(y2-zj_H/60*25)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*23),trunc(y2-zj_H/60*58)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*25),trunc(y2-zj_H/60*56)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*11),trunc(y2-zj_H/60*23)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*9),trunc(y2-zj_H/60*25)) ;
        //画尾梁   //综放
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*9),trunc(y2-zj_H/60*25)) ;
       // Image.Canvas.MoveTo(trunc(x2-zj_w/60*9),trunc(y2-zj_H/60*19)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*0),trunc(y2-zj_H/60*4)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*0),trunc(y2-zj_H/60*2)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*11),trunc(y2-zj_H/60*25)) ;
       ////画顶梁   //综放
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*22),trunc(y1)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*22),trunc(y1+zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*22),trunc(y1)) ;
         if mc_h>2.5 then  begin
             //伸缩梁  //综放
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*58),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*58),trunc(y1+zj_H/30*2)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*2)) ;
            // //护帮   //综放
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*58),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1+zj_H/30*13)) ;
            Image.Canvas.LineTo(trunc(x1+zj_w/60*1),trunc(y1+zj_H/30*13)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*57),trunc(y1+zj_H/30*2)) ;

        end else begin
             //伸缩梁   //综放
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1+zj_H/30*2)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*2)) ;
        end;


         //立柱   //综放
        if lizhushu=2 then  begin  // 两立柱   //综放
           if mc_h>=4.0 then  begin  // 双伸缩  //综放
                 // 下柱筒  //综放
                 Points[0].X:=trunc(x2-zj_w/60*29);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*33);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*37);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*33);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // 中柱筒 //综放
                 Points[0].X:=trunc(x2-zj_w/60*33.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*37.5);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*40.5);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*36.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // 上柱筒   //综放
                 Points[0].X:=trunc(x2-zj_w/60*38);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*40);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*42);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*40);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end else begin  // // 单伸缩  //综放
                 Points[0].X:=trunc(x2-zj_w/60*29);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*33);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*37);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*33);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // 上柱筒  //综放
                 Points[0].X:=trunc(x2-zj_w/60*34);       Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*37);       Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*39);       Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*36);       Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end;    //end  if zj_h> 40 then  begin  // 双伸缩 //综放

        end else begin   // 四立柱  //综放
               if mc_h>=4.0 then  begin  // 双伸缩    //综放
                 // 后柱下柱筒  //综放
                 Points[0].X:=trunc(x2-zj_w/60*24);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*24);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*28);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*28);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // 后柱下中柱筒   //综放
                 Points[0].X:=trunc(x2-zj_w/60*24.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*24.5);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*27.5);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*27.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // 后柱上下柱筒   //综放
                 Points[0].X:=trunc(x2-zj_w/60*25);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*25);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*27);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*27);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);
                 // 前柱下柱筒  //综放
                 Points[0].X:=trunc(x2-zj_w/60*34);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*37);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*41);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*38);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // 前柱中柱筒   //综放
                 Points[0].X:=trunc(x2-zj_w/60*37.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*40);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*43);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*40.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // 前柱上柱筒  //综放
                 Points[0].X:=trunc(x2-zj_w/60*40.5);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*42);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*44);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*42.5);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end else begin  // // 单伸缩 //综放
                 // 后柱 下竹筒 //综放
                 Points[0].X:=trunc(x2-zj_w/60*24);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*24);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*28);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*28);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // 后柱 上柱筒  //综放
                 Points[0].X:=trunc(x2-zj_w/60*25);       Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*25);       Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*27);       Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*27);       Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);
                  // 前柱下柱筒 //综放
                 Points[0].X:=trunc(x2-zj_w/60*34);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*37);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*41);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*38);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                  Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                    // 前柱上柱筒  //综放
                 Points[0].X:=trunc(x2-zj_w/60*38);                  Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*40);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*42);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*40);                  Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end;    //end  if zj_h> 40 then  begin  // 双伸缩    //综放
        end;  //end 立柱数目  //综放
        //画背后矸石  //综放
        //上段
           //画背梁   //综放
         {  Points[0].X:=trunc(x2-zj_w/60*22);                  Points[0].Y:=trunc(y1);
           Points[1].X:=trunc(x2-zj_w/60*22);                 Points[1].Y:=trunc(y2-zj_H/60*55);
           Points[2].X:=trunc(x2);                            Points[2].Y:=trunc(y2-zj_H/60*4);
           Points[3].X:=trunc(x2);                            Points[3].Y:=trunc(y1);
           Image.Canvas.Brush.Bitmap:=nil;
           Image.Canvas.Polygon(Points) ;
           bitmap1:=Tbitmap.Create;//创建位图 bitmap1
           bitmap1.LoadFromFile(dll_Path+'\BmpSi\煤.Bmp');//装入图像文件

           Image.Canvas.Brush.Bitmap:=bitmap1;
           Image.Canvas.FloodFill( Points[0].X+3,Points[0].Y+1,$000000,fsBorder);
           Image.Canvas.Brush.Bitmap:=nil;
           bitmap1.Free;  }
            //画刮板输送机
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*45),trunc(y2));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*55),trunc(y2));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*55),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*54),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*54),trunc(y2-zj_H/60*1));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*46),trunc(y2-zj_H/60*1));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*46),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*45),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*45),trunc(y2));

            Image.Canvas.MoveTo(trunc(x2-zj_w/60*2),trunc(y2));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y2));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*11),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*11),trunc(y2-zj_H/60*1));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*3),trunc(y2-zj_H/60*1));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*3),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*2),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*2),trunc(y2));
    end;   //end  //综放


end;

function TZJ_Class.DzXd_Cal_sup_para(gzm: TG_Stope; Zk: Tzk_bore;
  imm: TImmediate_roof; old: Told_roof): WideString;
 var
     s_out:widestring;
     Yl_stuct:integer;
     imm_m,Imm_c0,old_h_Max,Old_h_Min,old_l_max,old_l_min,Old_l_avg:double;
  begin
     //根据地质条件修订地质参数
      zhiJia_F_xs:=1;zhijia_L_xs:=1; //初始化系数
      if  gzm.S_cmfs='4' then begin       //采煤方式  放顶煤
          zhiJia_F_xs:=zhiJia_F_xs*1; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1.1;// 缩量修订系数
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// 护帮强度修订
      end;
      //修改值保存
      yL_stuct:=old.YL_struc;
      imm_m:=imm.Immroof_M;
      imm_c0:=imm.Immroof_C0 ;
      old_h_max:=old.YL_max_m ;
      old_h_min:=old.YL_min_m ;
      old_l_max:= old.YL_First_step[0] ;
      old_l_min:= old.YL_First_step[1] ;
      old_l_avg:= old.YL_First_step[2] ;

      imm.init(gzm,zk,0.5,s_out);    //初始化直接顶
      old.init(gzm,zk,imm,s_out);  //初始化老顶
     // cal_zcyl(zk,imm,gzm,old,s_out);     //计算支撑压力
     // cal_ldg(zk,gzm,imm,200,s_out);  ;     //计算裂断拱
      //数值更替回来
      old.YL_struc     :=yL_stuct;
      imm.Immroof_M  :=imm_m ;
      imm.Immroof_C0 :=imm_c0 ;
      old.YL_max_m     :=old_h_min ;
      old.YL_First_step[0] :=old_l_max ;
      old.YL_First_step[1] :=old_l_min;
      old.YL_First_step[2] :=old_l_avg  ;

      if  gzm.Dz_yxfx = 1 then begin       //仰斜
          zhiJia_F_xs:=zhiJia_F_xs*1.05; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *0.95;// 缩量修订系数
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.1;// 护帮强度修订
      end else if gzm.Dz_yxfx = 2 then begin  // 俯斜
          zhiJia_F_xs:=zhiJia_F_xs*0.95; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1.05;// 缩量修订系数
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*0.95;// 护帮强度修订
      end;

      if  gzm.Dz_JYHD  =1 then begin       //基岩厚度    薄基岩
          zhiJia_F_xs:=zhiJia_F_xs*3; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1;// 缩量修订系数
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// 护帮强度修订
      end else if gzm.Dz_JYHD = 2 then begin            // 一般基岩
          zhiJia_F_xs:=zhiJia_F_xs*1.5; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1;// 缩量修订系数
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// 护帮强度修订
      end;

      if  gzm.Dz_DCGZ  =1 then begin       //地质构造少
          zhiJia_F_xs:=zhiJia_F_xs*0.95; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1.05;   //
      end else if gzm.Dz_DCGZ >3  then begin            // 地址构造复杂
          zhiJia_F_xs:=zhiJia_F_xs*1.05; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1;// 缩量修订系数
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// 护帮强度修订
      end;

      if  gzm.Dz_TopWater  =2  then begin       //顶板水
          zhiJia_F_xs:=zhiJia_F_xs*1.05; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1;   //
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// 护帮强度修订
      end else if gzm.Dz_TopWater =4  then begin            //
          zhiJia_F_xs:=zhiJia_F_xs*1.05; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1;// 缩量修订系数
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// 护帮强度修订
      end;

      if  gzm.Dz_BottomWater  =2  then begin       //底板水
          zhiJia_F_xs:=zhiJia_F_xs*0.95; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1;   //
      end else if gzm.Dz_BottomWater =4  then begin            //
          zhiJia_F_xs:=zhiJia_F_xs*0.95; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1;// 缩量修订系数
      end;


      if  gzm.Dz_Kyxx =3  then begin       //矿压现象
          zhiJia_F_xs:=zhiJia_F_xs*1.05; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1.05;   //
      end else if gzm.Dz_Kyxx =4  then begin            //
          zhiJia_F_xs:=zhiJia_F_xs*1.1; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1.05;// 缩量修订系数
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// 护帮强度修订
      end;

      if  gzm.Dz_HangDaoSup =4  then begin       //巷道支护
          zhiJia_F_xs:=zhiJia_F_xs*0.95; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1.05;   //
      end else if gzm.Dz_HangDaoSup=5  then begin            //
          zhiJia_F_xs:=zhiJia_F_xs*0.9; //阻力修订系数
          zhijia_L_xs:=zhijia_L_xs *1.05;// 缩量修订系数
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// 护帮强度修订
      end;

      if gzm.UP_Ckq =2 then  begin
         if gzm.UP_CKQ_JuLI < imm.Immroof_M then  begin
             imm.Immroof_M:=imm.Immroof_M+gzm.UP_CKQ_Kc_H*3;
         end else  if gzm.UP_CKQ_JuLI <gzm.Hg_ldg  then begin
             zhiJia_F_xs:=zhiJia_F_xs*1.1; //阻力修订系数
             zhijia_L_xs:=zhijia_L_xs *1;// 缩量修订系数
         end;
      end;


end;

function TZJ_Class.GetImmP0(gzm:TG_Stope): double;
var
  p0:double;
  {
    如果使用初次来压 的最大值计算 是  Zj_jisuan_c0_p[0]
    如果使用周期来压的最大值计算  是  Zj_jisuan_ci_p[0]
    Zj_jisuan_c0_p[0]*10 是 MPA 与 KN 的换算 系数 ，该系数 应该是 9.8
  }
begin
  p0:=Zj_jisuan_c0_p[0]*9.8-zj_toall_P   ;
  if P0<0  then P0:=0;
  Result:=P0;
end;

procedure TZJ_Class.Having_stress(gzm: TG_Stope; Zk: Tzk_bore;
  mm: TImmediate_roof; old: Told_roof; idefOrStep: string; BeamNumber: integer;
  MaxV, MinV: double);
var
   MaxValue,MinValue:double;
   YLFDXS:double;
begin
    {
       Calculate_weight(Zk:Tzk_bore;old:Told_roof;defOrStep:string;BeamNumber:integer;
                    var maxV,minV :double);

      （1）当有内应力场， 是单岩梁结构，考虑支架的让压作用  在初次来压阶段  系数暂定为 0.25 ，在周期来压阶段 系数暂定为 0.5
                          多岩梁结构，考虑支架的支撑作用  在初次来压阶段  系数暂定为 0.5 ，在周期来压阶段 系数暂定为 0.8
     （2）当无内应力场， 是单岩梁结构，考虑支架的让压作用  在初次来压阶段  系数暂定为 0.4 ，在周期来压阶段 系数暂定为 0.6
                         多岩梁结构，考虑支架的支撑作用  在初次来压阶段  系数暂定为 0.6 ，在周期来压阶段 系数暂定为 1

    }
       //判断内应立场的作用
      if idefOrStep='Def' then   begin
          if old.YL_Dep_struct=1 then   begin   //单岩梁



          end else begin  //  多岩梁结构

          end;

      end else begin

      end;


    //  if old.YL_struc =1 then begin   //   begin  2----单岩梁结构
            //老顶初次来压 //压力
//            YLFDXS :=Zj_DBFD_xs[1];
//            Old_C0_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS;    //阻力最大值
//            YLFDXS :=Zj_DBFD_xs[1];
//            Old_C0_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS;  //阻力最小值
//            YLFDXS :=Zj_DBFD_xs[1];
//            Old_C0_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS;  //阻力平均值
//            //缩量
//            Old_C0_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[1];  //缩量最大值
//            Old_C0_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[0];  //缩量最 小值
//            Old_C0_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[2];  //缩量平均值



end;

function TZJ_Class.Init(str: wideString; out sEorr: Widestring): WordBool;
var
           temp1,temp2 :Str_Dt_array;
           i,Count1,Count2:integer;
begin
        Result:=true;
        sEorr:='支架初始化成功!';
        if trim(str)='' then begin
            str:='ZJ:综采,ZY13000/25/50,1.75,5,2.6,2,2.5,13000,1.46,2,.5,';
        end;
      try
            temp1:=Public_Basic.split(str,':',Count1);

            if UpperCase(temp1[0])<>'ZJ' then
             begin
               Result:=False;
               sEorr:='支架报头ZJ错误!';
               exit;
             end;

           temp2:=Public_Basic.split(temp1[1],',',Count2);
           if count2<12 then
               begin
               Result:=False;
               sEorr:='请仔细检查文件!';
               exit;
              end;
         for i :=low(temp2) to high(temp2) do
           begin
             if length(temp2[i])=0 then continue;
                  case i of
                     0: Zj_XingHao :=Trim(temp2[i]);
                     1: ZJ_BianHao:=Trim(temp2[i]);
                     2: ZJ_Zhongxinju :=Public_Basic.strTodouble_lu(temp2[i]);
                     3: ZJ_KongDingJU  :=Public_Basic.strTodouble_lu(temp2[i]);
                     4: Zj_Hlzyd  :=Public_Basic.strTodouble_lu(temp2[i]);
                     5: ZJ_Lizhu_count  :=Public_Basic.strToInt_lu(temp2[i]);
                     6: ZJ_suoliang    :=Public_Basic.strTodouble_lu(temp2[i]);
                     7: ZJ_toall_F:=Public_Basic.strTodouble_lu(temp2[i]);
                     8: ZJ_toall_P  :=Public_Basic.strTodouble_lu(temp2[i]);
                     9: ZJ_Hubang_h :=Public_Basic.strTodouble_lu(temp2[i]);
                     10: ZJ_Hubang_p :=Public_Basic.strTodouble_lu(temp2[i]);
                     11: Zj_Lz_Diameter:= Public_Basic.strTodouble_lu(temp2[i]);
                  end;
             end; //endfor
              temp1:=nil;temp2:=nil;
              //拆分支架最大高度与最小高度
              SplitZhijiaDisg_maxMin_H(ZJ_BianHao);
              if Trim(ZJ_Name)<> '单体' then   begin

                       if ZJ_Zhongxinju=0  then //判断支架中心距
                         begin
                           Result:=False;
                           sEorr:=sEorr+'支架中心距/';
                          end;
                       if ZJ_KongDingJU=0  then  // 判断支架控顶距
                         begin
                           Result:=False;
                           sEorr:=sEorr+'支架控顶距/';
                         end;
                       if Zj_Hlzyd=0  then  // 判断支架合力作用点
                         begin
                           Result:=False;
                           sEorr:=sEorr+'合力作用点/';
                         end;
              end; //end    if Trim(ZJ_Name)<> '单体' then   begin
         except
              Result:=False;
              sEorr:='数据格式有误/';
              exit;
       end;
         zhiJia_F_xs :=1;   // 支架支护强度修订系数
         zhijia_L_xs :=1;; // 支架缩量修订系数
         zhijia_hb_Q_xs :=1;// 支架护帮强度修订系数
end;

function TZJ_Class.MainDraw_Class_Zj(Image: TImage; pt1, pt2: TPoint;
  Mc_h: double;Rec:TDrawZjRecord): integer;
  {
    绘制液压支架 主函数
    State: 状态   0 代表 是 支架的 全载状态     1 代表 支架 压缩状态
    jia_type 1  是综采支架  2 综放 支架
    SuoLiang 代表支架的 高度， 本次支架 只能 压缩 40%  即 每次压缩 5 20次压缩完毕
    支架的背板 长度 默认为 43 个告诉单位  上 绞点 在 1   下绞点在 5 与 1
    支架每压缩 一个单位的高度， 背板与 垂直的夹角 增大1度   初始夹角 为 15度
    支架每压缩一个单位， 画图 的 W_C 增加一个单位
  }
var
  Draw_H,W_C,H_C:integer;
  Strat_P,End_P:TPoint;
  Use_H,Use_W:double;
  SuoCount:integer;
  LeftBlank,RightBlank:integer;
  TopBlank,BottomBlank:integer;
begin
   TopBlank:=5;
   BottomBlank:=5;
   LeftBlank:=trunc((pt2.Y-pt1.Y)/100 * 5);
   RightBlank:=trunc((pt2.Y-pt1.Y)/100 * 30);
   Strat_P.X:=LeftBlank; Strat_P.Y:=TopBlank;
   SuoCount:=0;
   W_C:=50;H_C:=50;
   Use_H:= (pt2.Y-pt1.Y-Strat_P.Y)/ H_C ;

   Draw_zj.FWithoutYs.X := Strat_P.X;
   Draw_zj.FWithoutYs.Y:=  TopBlank;
   Draw_zj.FmaxYs.X:=pt2.X;
   Draw_zj.FmaxYs.Y:=Strat_P.Y+ Trunc(Use_H* 20 );
   // 计算立柱的有限缩量
   Rec.Zj_used_suo_Unit:= 50/zj_Disg_max_h *(zj_Disg_max_h-Zj_Disg_Min_H) ;// 该立柱一共需要缩多少个单元
   if Rec.Zj_used_suo_Unit >20 then Rec.Zj_used_suo_Unit:=20;
   // 传到支架征程工作阻力与 最大工作阻力
   if Zj_JiSuan_Ci_F[2] > Zj_toall_F then begin
     if  Zj_JiSuan_Ci_F[1] > Zj_toall_F then     Draw_zj.Zj_Usual_F:=Zj_toall_F*0.95
        else  Draw_zj.Zj_Usual_F:=Zj_JiSuan_Ci_F[1];
   end else begin
      Draw_zj.Zj_Usual_F:=Zj_JiSuan_Ci_F[2];
   end;
      Draw_zj.ZJ_max_F:=Zj_toall_F;
   if Rec.Zj_LiZhu_SuoLiang >0  then begin
      SuoCount:= Rec.Zj_LiZhu_SuoLiang div 5;
      Strat_P.Y:=Strat_P.Y+ Trunc(Use_H* Rec.Zj_used_suo_Unit / 20 * SuoCount)  ;
   end;

    //计算支架实际高度
   Draw_zj.ZJ_Use_Max_H:=Mc_h;
   Draw_zj.ZJ_Use_Min_H:=Mc_h-Zj_jisuan_sl[0];
   Draw_zj.ZJ_Disgn_Max_H:=self.ZJ_Disg_max_H;
   Draw_zj.ZJ_Disgn_Min_H:=self.Zj_Disg_Min_H;

   Use_W:=(pt2.X-pt1.X-RightBlank)/ W_C ;

   // 赋初值
   Draw_zj.MotherCanvas :=Image.Canvas;
   Draw_zj.X_Unit := Use_W;
   Draw_zj.Y_Unit := Use_H;
   Draw_zj.StartPoint:=Strat_P;
   End_P.X:= pt2.x;
       End_P.Y:= pt2.Y-pt1.Y-TopBlank;
   Draw_zj.EndPoint :=End_P;
   Draw_zj.ZJ_Use_Max_H:=Mc_h;

   //Zhijia_shiji_h

   // 画支架
   Rec.Zj_StartPoint:= Strat_P;
   Draw_zj.Draw_ZC_Zj(Rec);

   Image.Repaint;
end;

function TZJ_Class.ManyBeam_sup(gzm: TG_Stope; Zk: Tzk_bore;
  imm: TImmediate_roof; old: Told_roof): double;
begin

end;

function TZJ_Class.NOHaving_stress(gzm: TG_Stope; Zk: Tzk_bore;
  imm: TImmediate_roof; old: Told_roof): double;
begin

end;

function TZJ_Class.OneBeam_sup(gzm: TG_Stope; Zk: Tzk_bore;
  imm: TImmediate_roof; old: Told_roof): double;
begin

end;

function TZJ_Class.ReadZhijia_XS(gzm: TG_Stope; Zk: Tzk_bore;
  imm: TImmediate_roof; old: Told_roof): WideString;
 var
      pIniFile:     TIniFile;
      i,j:integer;
      in_Zj_DBFD_xs:  array [1..4] of array[1..9] of double;// 保存不同类别的 参数
      ZhijiaXiu_count:integer;
   begin
          if not FileExists(Public_Basic.Get_MyModulePath +'ZhijiaCs_lulei.dll') then   begin
                  // I
                  in_Zj_DBFD_xs[1][1] :=0.25;
                  in_Zj_DBFD_xs[1][2] :=0.5;
                  in_Zj_DBFD_xs[1][3] :=0.5;
                  in_Zj_DBFD_xs[1][4] :=1;
                  in_Zj_DBFD_xs[1][6] :=0.3;
                  in_Zj_DBFD_xs[1][7] :=0.6;
                  in_Zj_DBFD_xs[1][8] :=0.6;
                  in_Zj_DBFD_xs[1][9] :=1.1;


                   // II

                  in_Zj_DBFD_xs[2][1] :=0.25;
                  in_Zj_DBFD_xs[2][2] :=0.5;
                  in_Zj_DBFD_xs[2][3] :=0.5;
                  in_Zj_DBFD_xs[2][4] :=0.8;
                  in_Zj_DBFD_xs[2][6] :=0.4;
                  in_Zj_DBFD_xs[2][7] :=0.6;
                  in_Zj_DBFD_xs[2][8] :=0.6;
                  in_Zj_DBFD_xs[2][9] :=1;

                   // III
                  in_Zj_DBFD_xs[3][1] :=0.1;
                  in_Zj_DBFD_xs[3][2] :=0.3;
                  in_Zj_DBFD_xs[3][3] :=0.6;
                  in_Zj_DBFD_xs[3][4] :=1;
                  in_Zj_DBFD_xs[3][6] :=0.2;
                  in_Zj_DBFD_xs[3][7] :=0.4;
                  in_Zj_DBFD_xs[3][8] :=0.6;
                  in_Zj_DBFD_xs[3][9] :=1;


                  // IV
                  in_Zj_DBFD_xs[4][1] :=0.2;
                  in_Zj_DBFD_xs[4][2] :=0.5;
                  in_Zj_DBFD_xs[4][3] :=0.6;
                  in_Zj_DBFD_xs[4][4] :=1;
                  in_Zj_DBFD_xs[4][6] :=0.2;
                  in_Zj_DBFD_xs[4][7] :=0.4;
                  in_Zj_DBFD_xs[4][8] :=0.6;
                  in_Zj_DBFD_xs[4][9] :=1;

          end else begin
                  pIniFile := Tinifile.create(Public_Basic.Get_MyModulePath+'ZhijiaCs_lulei.dll');
                  for I := 1 to 9 do  begin
                     // I
                     if i=5 then   continue;
                     if i<3 then  begin
                         j:=i+2;
                     end else if i<8 then  begin
                         j:=i+3;
                     end else begin
                         j:=i+4;
                     end;
                     in_Zj_DBFD_xs[1][i]:=pIniFile.ReadFloat('I',IntToStr(j),0);
                        // II
                     in_Zj_DBFD_xs[2][i]:=pIniFile.ReadFloat('II',IntToStr(j),0);
                        // III
                     in_Zj_DBFD_xs[3][i]:=pIniFile.ReadFloat('III',IntToStr(j),0);
                        // III
                     in_Zj_DBFD_xs[4][i]:=pIniFile.ReadFloat('IV',IntToStr(j),0);
                  end;
              pIniFile.Free;
          end;
          //  自助检索
           //判断规则：
           if old.Old_leibie<3 then  begin
                ZhijiaXiu_count:=1;
                gzm.Dz_JYHD:=2;
           end else if old.Old_leibie =3 then  begin
                ZhijiaXiu_count:=2;
                gzm.Dz_JYHD:=2;
           end else begin
                ZhijiaXiu_count:=3;
                gzm.Dz_JYHD:=3;
           end;

           if gzm.S_mcsd_h< 200 then  begin
                ZhijiaXiu_count:=4;
                gzm.Dz_JYHD:=1;
           end;


           for I := 1 to 9 do begin
               Zj_DBFD_xs[i]:=in_Zj_DBFD_xs[ZhijiaXiu_count][i];
           end;
end;

function TZJ_Class.ReturnSuoLiang(Use_H: double): double;
var
  Tmp_H:double;
  zj_d_s:double;
begin
   zj_d_s:=ZJ_Disg_max_H-Zj_Disg_Min_H;
   Tmp_H:=trunc(20/zj_d_s*(ZJ_Disg_max_H-Use_H))*5;
   Result:=Tmp_H;

end;

function TZJ_Class.Return_zj_Para(Version: WideString): WideString;
  var
         RStr:Widestring;
         i:integer;
     begin
       if Version='1.0'  then begin
           Rstr:='老顶初次来压时:'+#13#10;
           for I := 0 to 2 do  begin    //组合工作阻力 单位KN
              if i=0 then  begin
                 Rstr:=Rstr+ '      阻力最大值:'+FormatFloat('0.0',zj_jisuan_c0_F[i])+'KN，';
                 Rstr:=Rstr+ '强度最大值:'+FormatFloat('0.0',zj_jisuan_c0_P[i])+'MPa;'+#13#10;
              end else if i=1 then  begin
                 Rstr:=Rstr+ '      阻力最小值:'+FormatFloat('0.0',zj_jisuan_c0_F[i])+'KN，';
                 Rstr:=Rstr+ '强度最小值:'+FormatFloat('0.0',zj_jisuan_c0_P[i])+'MPa;'+#13#10;
              end else if i=2 then begin
                 Rstr:=Rstr+ '      阻力建议值'+FormatFloat('0.00',zj_jisuan_c0_F[i])+'KN，';
                 Rstr:=Rstr+ '强度建议值:'+FormatFloat('0.00',zj_jisuan_c0_P[i])+'MPa。'+#13#10;
              end;

           end;


            Rstr:=Rstr+#13+'老顶周期来压时:'+#13#10;;
           for I := 0 to 2 do  begin    //组合工作阻力 单位KN
              if i=0 then  begin
                 Rstr:=Rstr+'      阻力最大值:'+ FormatFloat('0.0',zj_jisuan_ci_F[i])+'KN，';
                 Rstr:=Rstr+'强度最大值:'+FormatFloat('0.0',zj_jisuan_ci_P[i])+'MPa，'+#13#10;;
              end else   if i=1 then  begin
                 Rstr:=Rstr+'      阻力最小值:'+ FormatFloat('0.0',zj_jisuan_ci_F[i])+'KN，';
                 Rstr:=Rstr+'强度最小值:'+FormatFloat('0.0',zj_jisuan_ci_P[i])+'MPa，'+#13#10;;
              end else begin
                 Rstr:=Rstr+'      阻力建议值:'+ FormatFloat('0.00',zj_jisuan_ci_F[i])+'KN，';
                 Rstr:=Rstr+'强度建议值:'+FormatFloat('0.00',zj_jisuan_ci_P[i])+'MPa。'+#13#10;;
              end;

           end;

           {  Rstr:=Rstr+'护帮高度:';
              for I := 0 to 4 do  begin    //组合互帮高度 单位m
                if i<>4 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_hubang_H[i])+'m,';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_hubang_H[i])+'m#';
                end;

             end;
              Rstr:=Rstr+'护帮强度:';
              Rstr:=Rstr+ FormatFloat('0.0', Zj_jisuan_hubang_p[2])+'MPa#';
             }

       end; //end 1.0

      if Version='2.0'  then begin
          Rstr:='';
           for I := 0 to 2 do  begin    //组合工作阻力 单位KN
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_c0_F[i])+',';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_c0_F[i])+';';
                end;

             end;
             for I := 0 to 2 do  begin    //组合工作强度 单位MPa
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_c0_P[i])+',';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_c0_P[i])+';';
                end;

             end;


             for I := 0 to 2 do  begin    //组合工作阻力 单位KN
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_ci_F[i])+',';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_ci_F[i])+';';
                end;

             end;

             for I := 0 to 2 do  begin    //组合工作强度 单位MPa
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_ci_P[i])+',';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_ci_P[i])+';';
                end;

             end;

              for I := 0 to 4 do  begin    //组合互帮高度 单位m
                if i<>4 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_hubang_H[i])+',';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_hubang_H[i])+';';
                end;

             end;

               for I := 0 to 2 do  begin    //组合互帮强度 单位MPa
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0', Zj_jisuan_hubang_p[i])+',';
                end else begin
                    Rstr:=Rstr+ FormatFloat('0.0', Zj_jisuan_hubang_p[i])+';';
                end;

              end;


      end;  //end 2.0

       if Version='3.0'  then begin
                   Rstr:='';

                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_c0_F[2])+',';

                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_ci_F[2])+'';
       end;

       Result:=Rstr;

end;

procedure TZJ_Class.Revision_ZhiJiaZuli;
var
  i:integer;
  MaxSupp,MinSupp,Maxbl,MinBl:Single;
begin
    { 强制修订支架的阻力参数
      修订的原则  支架不能大于 260000KN， 如果大于 将    强制处理
      支架不能小于 8000KN  如果小于 将强制处理
    }
    MaxSupp:=0; MinSupp:=1000000;
    for I := 0 to 2 do begin
       if MaxSupp < self.Zj_JiSuan_C0_F[i]  then  MaxSupp := self.Zj_JiSuan_C0_F[i] ;
       if MaxSupp < self.Zj_JiSuan_Ci_F[i]  then  MaxSupp := self.Zj_JiSuan_Ci_F[i] ;
       if MinSupp > self.Zj_JiSuan_C0_F[i]  then  MinSupp := self.Zj_JiSuan_C0_F[i] ;
       if MinSupp > self.Zj_JiSuan_Ci_F[i]  then  MinSupp := self.Zj_JiSuan_Ci_F[i] ;
    end;
    if MaxSupp > 26000 then begin  Maxbl:= 8000/(MaxSupp-18000) ;
    end else if MaxSupp > 22000 then begin  Maxbl:= 4000/(MaxSupp-18000) ;
    end else if MaxSupp > 20000 then begin  Maxbl:= 2000/(MaxSupp-18000) ;
    end;

    if MinSupp < 4000 then begin     MinBl:= 2000/(6000-MinSupp) ;
    end else if MinSupp < 6000 then begin     MinBl:= 2000/(8000-MinSupp) ;
    end else if MinSupp < 8000 then begin     MinBl:= 2000/(8000-MinSupp) ;
    end;

   for I := 0 to 2 do begin
      if Zj_JiSuan_C0_F[i]> 26000 then  begin
         Zj_JiSuan_C0_F[i]:=18000+(Zj_JiSuan_C0_F[i]-18000)*Maxbl;
      end;
      if Zj_JiSuan_Ci_F[i]> 15000 then  begin
         Zj_JiSuan_Ci_F[i]:=15000+(Zj_JiSuan_Ci_F[i]-15000)*Maxbl;
      end;
      //
      if Zj_JiSuan_C0_F[i]< 10000 then  begin
         Zj_JiSuan_C0_F[i]:=10000-(10000-Zj_JiSuan_C0_F[i])*Minbl;
      end;
      if Zj_JiSuan_Ci_F[i]< 8000 then  begin
         Zj_JiSuan_Ci_F[i]:=8000-(8000-Zj_JiSuan_Ci_F[i])*Minbl;
      end;
  end;


end;

function TZJ_Class.SpliJG(str: widestring; out sEorr: widestring): WordBool;
 var
           temp1 :Str_Dt_array;
           i,Count1:integer;
  begin
        Result:=true;
        sEorr:='支架拆分成功!';
      try
            temp1:=Public_Basic.split(str,',',Count1);
         if count1<11 then
               begin
               Result:=False;
               sEorr:='请仔细检查文件!';
               exit;
              end;
         for i :=low(temp1) to high(temp1) do
           begin
                  if length(temp1[i])=0 then continue;
                  case i of
                     0: self.JG_jx   :=Trim(temp1[i]);
                     1: self.JG_Dl   :=Trim(temp1[i]);
                     2: self.JG_Dz   :=Trim(temp1[i]);
                     3: self.JG_slg  :=Trim(temp1[i]);
                     4: self.JG_ty   :=Trim(temp1[i]);
                     5: self.JG_Fm   :=Trim(temp1[i]);
                     6: self.JG_Wl   :=Trim(temp1[i]);
                     7: self.JG_Qc   :=Trim(temp1[i]);
                     8: self.JG_Ct   :=Trim(temp1[i]);
                     9: self.JG_Dt   :=Trim(temp1[i]);
                     10: self.JG_Ql  :=Trim(temp1[i]);

                  end;

             end; //endfor
         except
              Result:=False;
              sEorr:='数据格式有误/';
              exit;
        end;  //end try
         if Trim(self.JG_Dl)='DL1' then  //铰接顶梁
           begin
                 if  self.Zj_JiSuan_Ci_F[0]>=10000 then   begin
                      if  JG_jx='JX1' then   begin
                          self.ZJ_JianYi_Type:='112';
                      end else if  JG_jx='JX2' then begin
                          self.ZJ_JianYi_Type:='122';
                      end; //endif JG_jx='JX1'
                 end else begin
                      if  JG_jx='JX1' then   begin
                          self.ZJ_JianYi_Type:='212';
                      end else if  JG_jx='JX2' then begin
                          self.ZJ_JianYi_Type:='222';
                      end; //endif JG_jx='JX1'
                 end;  //  if  self.Zj_JiSuan_Ci_F[0]>=10000
           end else begin //esle if Trim(self.JG_Dl)='DL1' then  // 整体
                  if  self.Zj_JiSuan_Ci_F[0]>=10000 then   begin
                      if  JG_jx='JX1' then   begin
                          self.ZJ_JianYi_Type:='111';
                      end else if  JG_jx='JX2' then begin
                          self.ZJ_JianYi_Type:='121';
                      end; //endif JG_jx='JX1'
                 end else begin
                      if  JG_jx='JX1' then   begin
                          self.ZJ_JianYi_Type:='211';
                      end else if  JG_jx='JX2' then begin
                          self.ZJ_JianYi_Type:='221';
                      end; //endif JG_jx='JX1'
                 end;  //  if  self.Zj_JiSuan_Ci_F[0]>=10000

           end;  //end if  Trim(self.JG_Dl)='DL1'



        //单绞点 单摆杆
            if  JG_jx='JX3' then   begin
                self.ZJ_JianYi_Type:='JX3';
            end else if  JG_jx='JX4' then   begin
                self.ZJ_JianYi_Type:='JX4';
            end;
end;

procedure TZJ_Class.SplitZhijiaDisg_maxMin_H(ZhijaN: string);
var
    temp1:Str_Dt_array;
    Count1:integer;
begin
        if Trim(ZhijaN)='' then  begin
           ZJ_Disg_max_H:=-1;
           Zj_Disg_Min_H:=-1;
        end;

       try
          temp1:=Public_Basic.split(ZhijaN,'/',Count1);
          if Count1>=2 then  begin
             Zj_Disg_Min_H:=public_Basic.StrToInt_lu(temp1[1])/10;
             Zj_Disg_Max_H:=public_Basic.StrToInt_lu(temp1[2])/10;
          end;

       finally

       end;

end;

procedure TZJ_Class.TipMessage(Memo:TMemo;pt0,pt1: TPoint; Rec: TDrawZjRecord);
begin
    Draw_zj.DispClickLabel(Memo,pt0,pt1,REc) ;
end;

procedure TZJ_Class.ZongheMbph(gzm: TG_Stope);
var
  i:integer;
  MBphgd_t:array[0..6] of Double ;//  ，煤壁片帮深度
  MBph_Jd:double;// 煤壁片帮执行的角度
begin
     // (0) 统计经验
     if gzm.S_Cg_h >2.5  then  begin
         MBphgd_t[1] :=(636.72 *(gzm.S_Cg_h/2)-127*Zj_toall_F/1000)/1000;
     end else begin
         MBphgd_t[1] :=(636.72 -127*Zj_toall_F/1000)/1000;
     end;
 //(1)为剪切滑移面计算
    MBphgd_t[2] :=  gzm.S_Cg_h*Tan((45 - gzm.S_M_mcj / 2) / 180 * 3.14159);

 //(2)重力滑落式片帮的力学机理
    MBphgd_t[3] := gzm.S_Cg_h*Tan(gzm.S_M_mcj / 180 * 3.14159);

 // (3) 横拱式片帮
    MBphgd_t[4]:=  gzm.S_Cg_h/2/gzm.S_f_PS;

  //(4)为压杆计算
    MBphgd_t[5] := 0.35 * gzm.S_Cg_h;
  // (6) 支架工作状态煤体高度计算
    MBphgd_t[6]:=CalMyMBPh_H(gzm);


    for I := 1 to 4 do  begin
       if MBphgd_t[i]<0  then  begin
          Zi_JiSuan_hubang_s[i]:=0; Zj_JiSuan_hubang_H[i]:=0;
       end else begin
          Zi_JiSuan_hubang_s[i]:=MBphgd_t[i];
          Zj_JiSuan_hubang_H[i]:=MBphgd_t[i]/tan((45 - gzm.S_M_mcj / 2)/180*3.1415926) ;
       end;

    end;

    for I := 5 to 6 do  begin
       Zj_JiSuan_hubang_H[i]:=MBphgd_t[i];
       Zi_JiSuan_hubang_s[i]:=MBphgd_t[i]*tan((45-gzm.S_M_mcj / 2)/180*3.1415926);
    end;
    // 压杆的 片帮高度
   Zj_JiSuan_hubang_H[0]:=Zj_JiSuan_hubang_H[5];
   // 基于支架状态的 片帮深度
   Zi_JiSuan_hubang_s[0]:=Zi_JiSuan_hubang_s[6];
end;

{ TDrawNode }

function TDrawNode.AddChildClass: TDrawNode;
begin
   Inc(FChildCount);
   setlength(FChlidClass,FChildCount);
   FChlidClass[FChildCount-1]:=TDrawNode.Create;
   FChlidClass[FChildCount-1].MotherCanvas := MotherCanvas;


    Result:=FChlidClass[FChildCount-1];
end;

function TDrawNode.AddLabelRuler(State:Integer;st, Ed: TPoint; Title: string;
  Visible,Arrow:Boolean;LineColor:TColor): TLabelMark;
{
  创建液压支架色的标注
  State 是标尺的状态  1  普通标尺  2 压力标尺
  Visible 标尺 是否无条件显示 FALSE 无条件显示  true  仅 第一次显示
  Arrow 是否显示标尺两端的箭头
  LineColor 标尺线的颜色

}
begin
   Inc(FLabelMarkCount);
   setlength(FMarkRuler,FLabelMarkCount);
     FMarkRuler[FLabelMarkCount-1]:=TLabelMark.Create;

     FMarkRuler[FLabelMarkCount-1].FStPoint :=st;
     FMarkRuler[FLabelMarkCount-1].FEndPoint:=ed;
     FMarkRuler[FLabelMarkCount-1].FTitlle :=Title;
     FMarkRuler[FLabelMarkCount-1].Visible :=Visible;
     FMarkRuler[FLabelMarkCount-1].MotherCanvas:=MotherCanvas;
     FMarkRuler[FLabelMarkCount-1].LineColor :=LineColor;
     FMarkRuler[FLabelMarkCount-1].LineWidth :=2;
     FMarkRuler[FLabelMarkCount-1].FlabelState:= State;
      FMarkRuler[FLabelMarkCount-1].FArrowVisible:= Arrow;
   Result:=FMarkRuler[FLabelMarkCount-1];
end;

function TDrawNode.AddMarkLabel(pt:TPoint;Rad:integer;DoubleC,CenLine,Print_State:Boolean): TLinkMark;
{
    DoubleC 是否画两个圆
    CenLine 是否画中心线
    Print_State 打印条件  true 是指有条件打印  FALSE 无条件大打印
}
begin
   Inc(FMarkCount);
   setlength(FMarkArry,FMarkCount);
     FMarkArry[FMarkCount-1]:=TLinkMark.Create;
    Result:=FMarkArry[FMarkCount-1];
    FMarkArry[FMarkCount-1].MotherCanvas := MotherCanvas;
    FMarkArry[FMarkCount-1].CenterPt :=pt;
    FMarkArry[FMarkCount-1].Rad :=Rad;
    FMarkArry[FMarkCount-1].FDoubleCycle:=DoubleC;
    FMarkArry[FMarkCount-1].FLineCenter:=CenLine;
    FMarkArry[FMarkCount-1].DoubleDispLay:= Print_State;
end;

function TDrawNode.AddPointNode(Pt: TPoint): Integer;
var
  Prv:TPoint;
begin
   if FPointCount> 0 then   begin
      Prv:=PointNodes[FPointCount-1];
      if CalDis(prv,pt) < 2 then   exit;
   end;


   Inc(FPointCount);
   setlength(PointNodes,FPointCount);
   PointNodes[FPointCount-1]:=Pt;
end;

procedure TDrawNode.BaseTWoPointDrawRect(pt1, pt2: TPoint;Rad:double; Circle: Boolean);
var
  Qjd_L,Qjd_Jd:double;
  Pt,pt_3:TPoint;
begin

      Qjd_Jd:=GetAngleFromTwoPoint(pt1,pt2);
      Qjd_L:=GetLengthFromTwoPoint(pt1,pt2);



     { 开始点}    Pt.x:= pt1.x+trunc(Y_Unit*Rad*Cos(ChangeJdToHu(90+Qjd_Jd)));
                     pt.Y:=pt1.Y -trunc(Y_Unit*Rad*sin (ChangeJdToHu(90+Qjd_Jd)));
                  if Circle then   begin // 如果需要圆角
                    // DrawCircle()
                  end else begin //如果不需要圆角
                     AddPointNode(Pt)  ;
                  end;

     { 连接点 1}  Pt.x:= Pt.x+trunc(Qjd_L*Cos(ChangeJdToHu(Qjd_Jd)));
                     pt.Y:=Pt.Y -trunc(Qjd_L*sin (ChangeJdToHu(Qjd_Jd)));
                  if Circle then   begin // 如果需要圆角
                    // DrawCircle()
                  end else begin //如果不需要圆角
                     AddPointNode(Pt)  ;
                  end;
      { 连接点 1} Pt.x:= Pt.x+trunc(Y_Unit*2*Rad*Cos(ChangeJdToHu(270+Qjd_Jd)));
                     pt.Y:=Pt.Y -trunc(Y_Unit*2*Rad*sin (ChangeJdToHu(270+Qjd_Jd)));
                   if Circle then   begin // 如果需要圆角
                    // DrawCircle()
                  end else begin //如果不需要圆角
                     AddPointNode(Pt)  ;
                  end;

      { 连接点 1} Pt.x:= Pt.x+trunc(Qjd_L*Cos(ChangeJdToHu(180+Qjd_Jd)));
                     pt.Y:=Pt.Y -trunc(Qjd_L*sin (ChangeJdToHu(180+Qjd_Jd)));
                  if Circle then   begin // 如果需要圆角
                    // DrawCircle()
                  end else begin //如果不需要圆角
                     AddPointNode(Pt)  ;
                  end;

end;

function TDrawNode.CalDis(pt1, pt2: TPoint): Double;
begin
   Result:=sqrt(power(pt2.x-pt1.x,2)+ power(pt2.Y-pt1.Y,2));
end;

procedure TDrawNode.Cal_Draw_RecInformation(var Rec: TDrawZjRecord);
{
  计算支架顶梁端头的节点
   Dl 1 整体 顶梁  2  铰接顶梁
   顶梁伸缩 从 X_unt 单位 5 到 15
   Reco.Zj_Dl_Suoliange  =100 时  一级互帮 顶梁的位置的 2   二级护帮 的位置 为 4
   Reco.Zj_Dl_Suoliange  =0 时 顶梁的位置的 12
}
var
  DL_ShenCount:integer;
  p0:TPoint;
  Bei_L,Zj_C,Zj_H:integer;
begin
    // 通过对顶梁的设定 改变顶梁结束点坐标
    if Rec.Zj_DL=1 then begin  //如果是整体顶梁
        if Rec.Zj_Hb =1 then  begin  // 一级护帮 then
           DL_ShenCount:=Rec.Zj_Dl_Suoliange div 10;
           Rec.Zj_DL_EndPoint.x:=StartPoint.x+trunc((12-DL_ShenCount  )*X_Unit);
        end else if Rec.Zj_Hb =2 then  begin
           DL_ShenCount:=Rec.Zj_Dl_Suoliange div 12;
           Rec.Zj_DL_EndPoint.x:=StartPoint.x+trunc((12-DL_ShenCount  )*X_Unit);
        end;

        Rec.Zj_DL_EndPoint.Y:=StartPoint.Y;
    end else begin // 如果是铰接顶梁
        Rec.Zj_DL_EndPoint.x:=StartPoint.x+trunc((2)*X_Unit);
        Rec.Zj_DL_EndPoint.Y:=StartPoint.Y;
    end;
    // 通过对护帮级别的设定 改变 一级护帮中心点的坐标
    if Rec.Zj_Hb =1 then  begin  // 一级护帮中心点
        Rec.First_HB_Center.X:=Rec.Zj_DL_EndPoint.x+ trunc(Y_Unit );
        Rec.First_HB_Center.Y:=  trunc(Rec.Zj_DL_EndPoint.y+Y_Unit*2.5);
        // 根据角度修改护帮中线点
        p0.X :=Rec.First_HB_Center.x+trunc(Y_Unit *2.5 * Cos(ChangeJdToHu(90+Rec.ZJ_First_HB_Jd)) );
        p0.Y :=Rec.First_HB_Center.y- round(Y_Unit *2.5 *sin(ChangeJdToHu(90+Rec.ZJ_First_HB_Jd))) ;
        Rec.First_HB_Li_Point.x:= p0.x+trunc(Y_Unit *4* Cos(ChangeJdToHu(270+Rec.ZJ_First_HB_Jd)) );
        Rec.First_HB_Li_Point.Y:=p0.Y -  trunc(Y_Unit *4* Sin(ChangeJdToHu(270+Rec.ZJ_First_HB_Jd)));


    end else  begin  //二级护帮中心点
        Rec.First_HB_Center.X:=Rec.Zj_DL_EndPoint.x+ trunc(Y_Unit );
        Rec.First_HB_Center.Y:=  trunc(Rec.Zj_DL_EndPoint.y+Y_Unit*2.5);
         // 根据角度修改护帮中线点
        p0.X :=Rec.First_HB_Center.x+trunc(Y_Unit *2.5 * Cos(ChangeJdToHu(90+Rec.ZJ_First_HB_Jd)) );
        p0.Y :=Rec.First_HB_Center.y- round(Y_Unit *2.5 *sin(ChangeJdToHu(90+Rec.ZJ_First_HB_Jd))) ;
        Rec.First_HB_Li_Point.x:= p0.x+trunc(Y_Unit *4* Cos(ChangeJdToHu(270+Rec.ZJ_First_HB_Jd)) );
        Rec.First_HB_Li_Point.Y:=p0.Y -  trunc(Y_Unit *4* Sin(ChangeJdToHu(270+Rec.ZJ_First_HB_Jd)));
        //二级互帮中线点
        REC.Second_Hb_Center.x:= p0.X+trunc(Y_Unit *(Rec.Zj_First_hb_L*2/3)* Cos(ChangeJdToHu(180+Rec.ZJ_First_HB_Jd)) );
        REC.Second_Hb_Center.Y:=p0.Y -  trunc(Y_Unit *(Rec.Zj_First_hb_L*2/3)* Sin(ChangeJdToHu(180+Rec.ZJ_First_HB_Jd)));
        // 二级护帮角度
        if REC.ZJ_First_HB_Jd>70 then  begin
             REC.ZJ_Second_HB_Jd:=20-20*(REC.ZJ_First_HB_Jd-70)/110;
        end else begin
            REC.ZJ_Second_HB_Jd:=20;
        end;

    end;


    // 计算支架背板的相关参数
    Bei_L:=22;Zj_C:=22;
    Zj_H:=40-Rec.Zj_LiZhu_SuoLiang div 5;
    Rec.Zj_Bei_Jd:=arcCos((bei_l * bei_l + Zj_H* Zj_H  - Zj_C *Zj_C ) /(2* bei_l *Zj_H))/3.14159*180;
    Rec.Zj_Bei_L:=Bei_L+10;
    // 背板的起点坐标
    Rec.Zj_Bei_Start_pt.x:=self.StartPoint.X +trunc(x_unit*38);
    Rec.Zj_Bei_Start_pt.Y:=self.StartPoint.Y +trunc(Y_Unit*3);
    // 背板立柱坐标
     Rec.Zj_Bei_First_St_Pt.X:=StartPoint.X +trunc(x_unit*38);
          Rec.Zj_Bei_First_St_Pt.Y:=EndPoint.Y -trunc(x_unit*6);
      Rec.Zj_Bei_Second_St_Pt.X:=StartPoint.X +trunc(x_unit*43);
          Rec.Zj_Bei_Second_St_Pt.Y:=EndPoint.Y -trunc(x_unit*3);

     Rec.Zj_Bei_First_ED_Pt.x:= Rec.Zj_Bei_Start_pt.x+trunc(Y_Unit *(Rec.Zj_Bei_L-15)* cos(changeJdTohu(270+Rec.Zj_Bei_Jd)));
          Rec.Zj_Bei_First_ED_Pt.Y:= Rec.Zj_Bei_Start_pt.Y-trunc(Y_Unit *(Rec.Zj_Bei_L-15)* Sin(changeJdTohu(270+Rec.Zj_Bei_Jd)));
     Rec.Zj_Bei_Second_ED_Pt.x:= Rec.Zj_Bei_Start_pt.x+trunc(Y_Unit *(Rec.Zj_Bei_L-4)* cos(changeJdTohu(270+Rec.Zj_Bei_Jd)));
          Rec.Zj_Bei_Second_ED_Pt.Y:= Rec.Zj_Bei_Start_pt.Y-trunc(Y_Unit *(Rec.Zj_Bei_L-4)* Sin(changeJdTohu(270+Rec.Zj_Bei_Jd)));

     // 平衡千斤顶的两个端点
       REC.Zj_blance_Qjd_st_pt.X:=self.StartPoint.X +trunc(x_unit*30);
       REC.Zj_blance_Qjd_st_pt.Y:=self.StartPoint.Y +trunc(Y_Unit*4);
          Rec.Zj_blance_Qjd_ed_pt.x:= Rec.Zj_Bei_Start_pt.x+trunc(Y_Unit *(Rec.Zj_Bei_L/2)* cos(changeJdTohu(270+Rec.Zj_Bei_Jd)));
          Rec.Zj_blance_Qjd_ed_pt.Y:= Rec.Zj_Bei_Start_pt.Y-trunc(Y_Unit *(Rec.Zj_Bei_L/2)* Sin(changeJdTohu(270+Rec.Zj_Bei_Jd)));

    // 立柱位置
    if Rec.zj_LZ =2 then  begin  //两立柱
       { 顶梁的高度为 10个单位.着力点在 3个单位上
         底座的高度的 6个单位，着力点在 4个单位上
       }
       Rec.Zj_Lizhu_First_St_Pt.x := StartPoint.X +trunc(x_unit*25);
           Rec.Zj_Lizhu_First_St_Pt.Y:=StartPoint.Y +trunc(Y_Unit*3);
       Rec.Zj_Lizhu_First_ed_Pt.x := StartPoint.X +trunc(x_unit*30);
           Rec.Zj_Lizhu_First_ed_Pt.Y:=EndPoint.Y -trunc(Y_Unit*4);
    end else if Rec.zj_LZ =4 then  begin  //四立柱
       { 顶梁的高度为 10个单位.着力点在 3个单位上
         底座的高度的 6个单位，着力点在 4个单位上
         前柱的 结束点 X 在 22  后边的结束在  X 34
         前柱的 开始点 X 在 20  后边的结束在  X 32
       }
       Rec.Zj_Lizhu_First_St_Pt.x := StartPoint.X +trunc(x_unit*20);
           Rec.Zj_Lizhu_First_St_Pt.Y:=self.StartPoint.Y +trunc(Y_Unit*3);
       Rec.Zj_Lizhu_First_ed_Pt.x := StartPoint.X +trunc(x_unit*24);
           Rec.Zj_Lizhu_First_ed_Pt.Y:=EndPoint.Y -trunc(Y_Unit*4);

       Rec.Zj_Lizhu_Second_St_Pt.x := StartPoint.X +trunc(x_unit*32);
           Rec.Zj_Lizhu_Second_St_Pt.Y:=self.StartPoint.Y +trunc(Y_Unit*3);
       Rec.Zj_Lizhu_Second_ed_Pt.x := StartPoint.X +trunc(x_unit*32);
           Rec.Zj_Lizhu_Second_ed_Pt.Y:=EndPoint.Y -trunc(Y_Unit*4);
    end;
end;

function TDrawNode.ChangeJdToHu(JiaoDu: Double): Double;
begin
   Result:=JiaoDu /180 *3.1415926;
end;

procedure TDrawNode.ClearAll;
begin
    ClearPoint;
   ClearChlid;
end;

procedure TDrawNode.ClearChlid;
var
  i:integer;
begin
   //------------------------
   for I := FChildCount-1 downto 0 do
       if Assigned(FChlidClass[i]) then  FreeAndNil(FChlidClass[i]);
   FChildCount:=0;
   setlength(FChlidClass,0);
   //----------------------
   for I := FMarkCount-1 downto 0 do
       if Assigned(FMarkArry[i]) then  FreeAndNil(FMarkArry[i]);
   FMarkCount:=0;
   setlength(FMarkArry,0);
   //----------------------------
   for I := FLabelMarkCount-1 downto 0 do
       if Assigned(FMarkRuler[i]) then  FreeAndNil(FMarkRuler[i]);
   FLabelMarkCount:=0;
   setlength(FMarkRuler,0);
end;

procedure TDrawNode.ClearPoint;
begin
   FPointCount:=0;
   setlength(PointNodes,FPointCount);
end;

constructor TDrawNode.Create;
begin
    FPointCount:=0;
    FChildCount:=0;
    FMarkCount:=0;
    FLabelMarkCount:=0;
    TipTimer:=TTimer.Create(nil) ;
    TipTimer.Enabled :=False;
    TipTimer.Interval :=100;
    TipTimer.OnTimer :=self.TipTimeOnTime;
end;

destructor TDrawNode.Destroy;
begin
  ClearAll;
//  if Assigned(FHint) then FreeAndNil(FHint);
  TipTimer.Free;
end;

function TDrawNode.DispClickLabel(Memo:TMemo;pt0,pt1: TPoint;Rec:TDrawZjRecord): String;
{
   pt0 是本身坐标 用于查找
   pt1 是 屏幕 坐标

}
var
  i:integer;
  iRect:TRect;
begin
  if not (Rec.Disp_Tip) then  exit;

  if (FChildCount >0)  then
         for I := 0 to FChildCount-1 do
             FChlidClass[i].DispClickLabel(Memo,pt0,pt1,Rec);

  if not (Rec.Disp_Tip) then  exit;

  if Public_Basic.IsPtInPoly(pt0.X,pt0.Y,PointNodes ) then   begin
       if (Rec.Disp_Tip) and  (Caption<>'') then begin
           DisptipMemo(Memo,pt1,Caption);
           Rec.Disp_Tip:=False;
      end;

  end;
 

  

end;

procedure TDrawNode.DisptipMemo(Memo: TMemo; pt: TPoint;title:string);
begin

       TipMemo:=Memo;
       TipCount:=0;
       tipTimer.Enabled :=true;
       Memo.Clear ;
       Memo.Lines.Add(title);
       Memo.Top :=pt.Y ;
       Memo.Left :=pt.X ;
       Memo.Visible :=True;


end;

procedure TDrawNode.DrawAndFill(FillVis: Boolean; PenSize: integer;
  FillColor: TColor);
var
  PenS,i:integer;
  FC:TColor;

begin
   if FillVis then begin
      FC:=MotherCanvas.Brush.Color;
      MotherCanvas.Brush.Color:=FillColor;
      MotherCanvas.Polygon(PointNodes);
      MotherCanvas.Brush.Color:=FC;
   end else begin
      PenS:=MotherCanvas.Pen.Width;
      MotherCanvas.Pen.Color :=ClBlack;
      MotherCanvas.Pen.Width:=PenSize;
      MotherCanvas.Brush.Color:=ClWhite;
      MotherCanvas.Polygon(PointNodes);
      MotherCanvas.Pen.Width:=PenS;
   end;

//   if FPointCount>0 then   begin
//      MotherCanvas.MoveTo(PointNodes[0].x,PointNodes[0].y)  ;
//      for I := 1 to FPointCount-1 do
//           MotherCanvas.LineTo(PointNodes[i].x,PointNodes[i].y)  ;
//   end;
//     MotherCanvas.LineTo(PointNodes[0].x,PointNodes[0].y)  ;
end;

procedure TDrawNode.DrawCircle(Pt: TPoint; PointR: double; S_Jd, E_jd: integer);
{

   PointR 生成点的半径
   S_Jd : 生成点的开始角度,
   E_jd ：生成点的 结束角度
          }
Var
  tem:TColor;
  st:integer;
  pi:Tpoint;
begin

    if S_Jd >E_jd then  begin
      st:= S_Jd;
      while st >= E_jd do   begin
        pi.X:=pt.X+ trunc(PointR *Cos (st /180 *3.14159));
        pi.Y:=Pt.Y- trunc(PointR *Sin (st /180 *3.14159));
        AddPointNode(Pi);
        st:=st-5;
       end;
    end else begin
       st:= S_Jd;
       while st<= E_jd do   begin
        pi.X:=pt.X+ trunc(PointR *Cos (st /180 *3.14159));
        pi.Y:=Pt.Y- trunc(PointR *Sin (st /180 *3.14159));
        AddPointNode(Pi);
        st:=st+5;
       end;
    end;


end;

procedure TDrawNode.Draw_balance_Qjd(Rec: TDrawZjRecord);
{
  绘制平衡千斤顶

}
var
  tempN:TDrawNode;
  Second_St,Third_Sd:TPoint;

begin
      //------------------------------------------
     if Rec.zj_LZ=2 then begin  // 两立柱支架
          //根据缩量计算第二级立柱的开始为主
        Second_St:=FromTwoPointCalMidPoint(15,Rec.Zj_blance_Qjd_st_pt,Rec.Zj_blance_Qjd_ed_pt,0);
//        //-----------------------------
        tempN:=AddChildClass;
        tempN.Caption :='平衡千斤顶上面一节';
        tempN.StartPoint:=StartPoint;
        tempN.X_Unit :=X_Unit;
        tempN.Y_Unit :=Y_Unit;
        tempN.BaseTWoPointDrawRect(Rec.Zj_blance_Qjd_st_pt,Rec.Zj_blance_Qjd_ed_pt,0.5,False);
         // 显示 伸缩杆主体
        tempN.DrawAndFill(true,1,ClGreen);
          //-----------------------------
        tempN:=AddChildClass;
        tempN.Caption :='平衡千斤顶下面一节';
        tempN.StartPoint:=StartPoint;
        tempN.X_Unit :=X_Unit;
        tempN.Y_Unit :=Y_Unit;
        tempN.BaseTWoPointDrawRect(Second_St,Rec.Zj_blance_Qjd_ed_pt,0.6,False);
         // 显示 伸缩杆主体
        tempN.DrawAndFill(true,1,ClYellow);
     end;

end;

procedure TDrawNode.Draw_beiban(Rec:TDrawZjRecord);
{
   3-1 绘制背板
   背板长度 35个 Y_unit 单位  支撑体长度 20 个 Y_unit 单位
   支架 实际绘图高度  40个 Y_Unit 单位 支架 压缩 智能  20个单位
   cos(Usd_jd)= (bei_l * bei_l + Zj_H* Zj_H  - 20 *20 ) /(2* bei_l *Zj_H)
}
var
  Pt1,pt2:Tpoint; // 背板与第一个 与底座支持的坐标点， 背板与底座支持的第二个坐标点
  P0:Tpoint;// 背板的 初始坐标点
  tempClass:TDrawNode;
  pt:TPoint;

begin
//  P0.x:=self.StartPoint.X +trunc(x_unit*38);
//  P0.Y:=self.StartPoint.Y +trunc(Y_Unit*3);
    P0:=Rec.Zj_Bei_Start_pt;

    tempClass:=AddChildClass;
    tempClass.Caption :='液压支架背板';
    tempClass.StartPoint:=p0;
    tempClass.X_Unit :=X_Unit;
    tempClass.Y_Unit :=Y_Unit;

    { 开始点}  pt.x:= p0.x+trunc(Y_Unit *3 * cos(changeJdTohu(Rec.Zj_Bei_Jd)));
               pt.Y:= p0.Y-trunc(Y_Unit *3 * Sin(changeJdTohu(Rec.Zj_Bei_Jd)));
                  tempClass.AddPointNode(Pt)  ;

     { 角的狐} pt.x:= pt.x+trunc(Y_Unit *(Rec.Zj_Bei_L-1) * cos(changeJdTohu(270+Rec.Zj_Bei_Jd)));
               pt.Y:= pt.Y-trunc(Y_Unit *(Rec.Zj_Bei_L-1) * Sin(changeJdTohu(270+Rec.Zj_Bei_Jd)));
                   tempClass.DrawCircle(pt,Y_Unit,Round(Rec.Zj_Bei_Jd),0);
                   tempClass.DrawCircle(pt,Y_Unit,360,Round(270+Rec.Zj_Bei_Jd));
     {固定点}  pt.x:= p0.x+trunc(Y_Unit *(Rec.Zj_Bei_L)* cos(changeJdTohu(270+Rec.Zj_Bei_Jd)));
               pt.Y:= p0.Y-trunc(Y_Unit *(Rec.Zj_Bei_L)* Sin(changeJdTohu(270+Rec.Zj_Bei_Jd)));
                   tempClass.AddPointNode(Pt)  ;

     {  角的狐 }  pt.x:= pt.x+trunc(Y_Unit *(4-1) * cos(changeJdTohu(180+Rec.Zj_Bei_Jd)));
               pt.Y:= pt.Y-trunc(Y_Unit *(2) * Sin(changeJdTohu(180+Rec.Zj_Bei_Jd)));
                    tempClass.DrawCircle(pt,Y_Unit,Round(270+Rec.Zj_Bei_Jd),270);
                    tempClass.DrawCircle(pt,Y_Unit,270,Round(180+Rec.Zj_Bei_Jd));
      {固定点} pt.x:= p0.x+trunc(Y_Unit *(Rec.Zj_Bei_L*2/3)* cos(changeJdTohu(270+Rec.Zj_Bei_Jd)));
               pt.Y:= p0.Y-trunc(Y_Unit *(Rec.Zj_Bei_L*2/3)* Sin(changeJdTohu(270+Rec.Zj_Bei_Jd)));
               pt.x:= pt.x+trunc(Y_Unit *4 * cos(changeJdTohu(180+Rec.Zj_Bei_Jd)));
               pt.Y:= pt.Y-trunc(Y_Unit *4 * Sin(changeJdTohu(180+Rec.Zj_Bei_Jd)));
               tempClass.AddPointNode(Pt)  ;
      {做一个坡度圆弧}
               pt.x:= pt.x+trunc(Y_Unit *3* cos(changeJdTohu(Rec.Zj_Bei_Jd)));
               pt.Y:= pt.Y-trunc(Y_Unit *3 * Sin(changeJdTohu(Rec.Zj_Bei_Jd)));
               tempClass.DrawCircle(pt,Y_Unit*3,Round(180+Rec.Zj_Bei_Jd),Round(135+Rec.Zj_Bei_Jd));
     { 连接点 2}  pt.x:= p0.x+trunc(Y_Unit *(Rec.Zj_Bei_L*1/2)* cos(changeJdTohu(270+Rec.Zj_Bei_Jd)));
               pt.Y:= p0.Y-trunc(Y_Unit *(Rec.Zj_Bei_L*1/2)* Sin(changeJdTohu(270+Rec.Zj_Bei_Jd)));
               pt.x:= pt.x+trunc(Y_Unit *3 * cos(changeJdTohu(180+Rec.Zj_Bei_Jd)));
               pt.Y:= pt.Y-trunc(Y_Unit *3 * Sin(changeJdTohu(180+Rec.Zj_Bei_Jd)));
               tempClass.AddPointNode(Pt)  ;
     { 连接点 3 }  pt.x:= p0.x+trunc(Y_Unit *3 * cos(changeJdTohu(180+Rec.Zj_Bei_Jd)));
                   pt.Y:= p0.Y-trunc(Y_Unit *3 * Sin(changeJdTohu(180+Rec.Zj_Bei_Jd)));
                  tempClass.AddPointNode(Pt)  ;

//     // 添加链接的销子
//     pt.X:= p0.x+ trunc(X_Unit *5.4+Y_Unit ); pt.Y:=  trunc(p0.y+Y_Unit*2);
//        tempN.AddMarkLabel(pt,trunc(Y_Unit*0.4),False,False);
//     pt.X:=  trunc(p0.x+X_Unit *6-Y_Unit*0.4 ); pt.Y:=  trunc(p0.y+Y_Unit*3);
//        tempN.AddMarkLabel(pt,trunc(Y_Unit*0.4),FALSE,FALSE);

         //显第一节附件
     tempClass.DrawAndFill(true,1,Rec.Zj_body_fillColor);

end;

procedure TDrawNode.Draw_BeiBan_Lizhu(Rec: TDrawZjRecord);
{
  绘制背板的立柱
}
var
  tempN:TDrawNode;
begin
      //------------------------------------------
      tempN:=AddChildClass;
      tempN.Caption :='支架背板第一根立柱';
      tempN.StartPoint:=StartPoint;
      tempN.X_Unit :=X_Unit;
      tempN.Y_Unit :=Y_Unit;

         // 增加点
      tempN.BaseTWoPointDrawRect(Rec.Zj_Bei_First_St_Pt,Rec.Zj_Bei_First_ED_Pt,1.5,False);
         // 显示 伸缩杆主体
      tempN.DrawAndFill(true,1,Rec.Zj_body_fillColor);
      // 添加链接的销子
      tempN.AddMarkLabel(Rec.Zj_Bei_First_ED_Pt,trunc(Y_Unit),true,true,False);
        //------------------------------------------
      tempN:=AddChildClass;
      tempN.Caption :='支架背板第二根立柱';
      tempN.StartPoint:=StartPoint;
      tempN.X_Unit :=X_Unit;
      tempN.Y_Unit :=Y_Unit;

         // 增加点
      tempN.BaseTWoPointDrawRect(Rec.Zj_Bei_Second_St_Pt,Rec.Zj_Bei_Second_ED_Pt,2.5,False);
         // 显示 伸缩杆主体
      tempN.DrawAndFill(true,1,Rec.Zj_body_fillColor);
      tempN.AddMarkLabel(Rec.Zj_Bei_Second_ED_Pt,trunc(Y_Unit),true,true,False);

end;

procedure TDrawNode.Draw_Dl_First_Hb_Qjd(Reco: TDrawZjRecord);
{
  绘制一级护帮的千斤顶
}
var
  tempN:TDrawNode;
  p0,pt:TPoint;
  pt1,pt2:TPoint;
  Qjd_L,Qjd_Jd,Q_l1:double;
begin
      //------------------------------------------
      tempN:=AddChildClass;
      tempN.Caption :='顶梁一级护帮千斤顶-伸缩杆';
      tempN.StartPoint:=StartPoint;
      tempN.X_Unit :=X_Unit;
      tempN.Y_Unit :=Y_Unit;

      p0:=StartPoint;
      pt1.X:=P0.X+trunc(X_Unit *14);   pt1.Y:=P0.Y+trunc(Y_Unit*4);
      pt2.X:=P0.X+trunc(X_Unit *30);   pt2.Y:=P0.Y+trunc(Y_Unit*5);

      Q_l1:=GetLengthFromTwoPoint(pt1,pt2);
      pt1:=Reco.First_HB_Li_Point;
      pt1.Y:= pt1.Y + trunc(Y_Unit*0.5);
      Qjd_Jd:=GetAngleFromTwoPoint(pt1,pt2);
      Qjd_L:=GetLengthFromTwoPoint(pt1,pt2);
         // 增加点
         tempN.BaseTWoPointDrawRect(pt1,pt2,0.3,False);
         // 显示 伸缩杆主体
         tempN.DrawAndFill(true,1,clGreen);
      //-------------------------------------------------
      tempN:=AddChildClass;
      tempN.Caption :='顶梁一级护帮千斤顶-缸体';
      tempN.StartPoint:=StartPoint;
      tempN.X_Unit :=X_Unit;
      tempN.Y_Unit :=Y_Unit;
        // 计算终点
        Pt1.x:= Pt1.x+trunc((Qjd_L-Q_l1)*Cos(ChangeJdToHu(Qjd_Jd)));
           pt1.Y:=Pt1.Y -trunc((Qjd_L-Q_l1)*sin (ChangeJdToHu(Qjd_Jd)));
        //增加点
        tempN.BaseTWoPointDrawRect(pt1,pt2,0.7,False);
        // 增加销子
        pt.X:=  trunc(p0.x+X_Unit *30); pt.Y:=  trunc(p0.y+Y_Unit*5);
        tempN.AddMarkLabel(pt,trunc(Y_Unit*0.4),true,FALSE,False);
        // 显示缸体主体
       tempN.DrawAndFill(true,1,clYellow);

end;

procedure TDrawNode.Draw_DL_HuBang( Reco:TDrawZjRecord);
{
    液压支架前面互帮
    Hbjb 1 一级互帮   2 二级互帮
}
var
  tempN:TDrawNode;
  p0,pt1,pt,pt2:TPoint;
  HB_L,Hu_Jd,Qjd_Jd,Qjd_l:double;
begin
    Hu_Jd:=Reco.ZJ_First_HB_Jd;
    p0.X :=Reco.First_HB_Center.x+trunc(Y_Unit *2.5 * Cos(ChangeJdToHu(90+Hu_Jd)) );
         p0.Y :=Reco.First_HB_Center.y- round(Y_Unit *2.5 *sin(ChangeJdToHu(90+Hu_Jd))) ;
    if Reco.Zj_Hb=1 then  begin // 一级互帮
         HB_L:=Reco.Zj_First_hb_L;
         pt1.x:=P0.X ;   pt1.y:=P0.y ;
             //----------------------------------------
         tempN:=AddChildClass;
         tempN.Caption :='一级互帮-护帮板主体';
         tempN.StartPoint:=StartPoint;
         tempN.X_Unit :=X_Unit;
         tempN.Y_Unit :=Y_Unit;
         { 开始点 1}  pt.x:= pt1.x+trunc(Y_Unit *0.5* Cos(ChangeJdToHu(270+Hu_Jd)) );
                          pt.Y:=pt1.Y -  trunc(Y_Unit *0.5* Sin(ChangeJdToHu(270+Hu_Jd)));
                        tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= pt.x+trunc(Y_Unit *3.5* Cos(ChangeJdToHu(280+Hu_Jd)) );
                           pt.Y:=pt.Y -  trunc(Y_Unit *3.5* Sin(ChangeJdToHu(280+Hu_Jd)));
                       tempN.AddPointNode(Pt)  ;

         { 连接点 1 一级互帮中心点}  pt.x:= pt1.x+trunc(Y_Unit *4* Cos(ChangeJdToHu(270+Hu_Jd)) );
                           pt.Y:=pt1.Y -  trunc(Y_Unit *4* Sin(ChangeJdToHu(270+Hu_Jd)));
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1 一级互帮中心点}  pt.x:= pt1.x+trunc(Y_Unit *4* Cos(ChangeJdToHu(270+Hu_Jd-8)) );
                           pt.Y:=pt1.Y -  trunc(Y_Unit *4* Sin(ChangeJdToHu(270+Hu_Jd-8)));
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}   pt.x:= pt1.x+trunc(Y_Unit *2* Cos(ChangeJdToHu(225+Hu_Jd)) );
                           pt.Y:=pt1.Y -  trunc(Y_Unit *2* Sin(ChangeJdToHu(225+Hu_Jd)));
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}   pt.x:= pt1.x+trunc(Y_Unit *(HB_L-0.5)* Cos(ChangeJdToHu(180+Hu_Jd)) );
                           pt.Y:=pt1.Y -  trunc(Y_Unit *(HB_L-0.5)* Sin(ChangeJdToHu(180+Hu_Jd)));
                       tempN.AddPointNode(Pt)  ;
         tempN.DrawAndFill(true,1,Reco.Zj_body_fillColor);
         // 增加连接销子
           pt.x:= pt1.x+trunc(Y_Unit *2.5* Cos(ChangeJdToHu(225+Hu_Jd)) );
           pt.Y:= pt1.Y-trunc(Y_Unit *2.5* Sin(ChangeJdToHu(225+Hu_Jd)));
              tempN.AddMarkLabel(pt ,trunc(Y_Unit*0.5),FALSE,False,true);
              tempN.FMarkArry[0].DrawMark(False,ClBlack);
         //===================================
          tempN:=AddChildClass;
          tempN.Caption :='一级互帮-互帮板';
          tempN.StartPoint:=StartPoint;
          tempN.X_Unit :=X_Unit;
          tempN.Y_Unit :=Y_Unit;
          {定义互帮初始点}

                      tempN.AddPointNode(Pt1)  ;
         { 开始点 1}  pt.x:= pt1.x+trunc(Y_Unit *HB_L * Cos(ChangeJdToHu(180+Hu_Jd)) );
                           pt.Y:=pt1.Y -  trunc(Y_Unit *HB_L * Sin(ChangeJdToHu(180+Hu_Jd)));
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= pt.x+trunc(Y_Unit *0.2* Cos(ChangeJdToHu(270+Hu_Jd)) );
                           pt.Y:=pt.Y -  trunc(Y_Unit *0.2* Sin(ChangeJdToHu(270+Hu_Jd)));
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= pt1.x+trunc(Y_Unit *0.5 * Cos(ChangeJdToHu(270+Hu_Jd)) );
                           pt.Y:=pt1.Y -  trunc(Y_Unit *0.5 * Sin(ChangeJdToHu(270+Hu_Jd)));
                       tempN.AddPointNode(Pt)  ;

         tempN.DrawAndFill(true,1,Reco.Zj_body_fillColor);

           //----------------------------------------
         tempN:=AddChildClass;
         tempN.Caption :='一级互帮-着力点';
         tempN.StartPoint:=StartPoint;
         tempN.X_Unit :=X_Unit;
         tempN.Y_Unit :=Y_Unit;
         { 连接点 1 一级互帮中心点} tempN.DrawCircle(Reco.First_HB_Center,trunc(Y_Unit),0,360);
          tempN.AddMarkLabel(Reco.First_HB_Li_Point ,trunc(Y_Unit*0.4),FALSE,False,true);
          tempN.DrawAndFill(true,1,Reco.Zj_body_fillColor);
          tempN.FMarkArry[0].DrawMark(False,ClBlack);


    end else if Reco.Zj_Hb=2 then  begin // 二级互帮 then
          HB_L:=Reco.Zj_First_hb_L;
          pt1.x:=P0.X ;   pt1.y:=P0.y ;
          // 千斤顶第2级
          tempN:=AddChildClass;
          tempN.Caption :='二级互帮千斤顶第2级';
          tempN.StartPoint:=StartPoint;
          tempN.X_Unit :=X_Unit;
          tempN.Y_Unit :=Y_Unit;

           pt.x:= pt1.x+trunc(Y_Unit *(HB_L*1/4)* Cos(ChangeJdToHu(185+Hu_Jd+4)) );
               pt.Y:=pt1.Y -  trunc(Y_Unit *(HB_L*1/4)* Sin(ChangeJdToHu(185+Hu_Jd+4)));

               pt2.x:= Reco.Second_Hb_Center.x+trunc(Y_Unit *(HB_L*1/3)* Cos(ChangeJdToHu(185+RECo.ZJ_Second_HB_Jd+Hu_Jd)) );
                    pt2.Y:=Reco.Second_Hb_Center.Y -  trunc(Y_Unit *(HB_L*1/3)* Sin(ChangeJdToHu(185+RECo.ZJ_Second_HB_Jd+Hu_Jd)));

           if RECo.ZJ_First_HB_Jd< 90  then  begin
               tempN.BaseTWoPointDrawRect(pt2,pt,0.2,False);
           end else begin
               tempN.BaseTWoPointDrawRect(pt,pt2,0.2,False);
           end;


            tempN.DrawAndFill(true,1,clGreen);
           // 添加链接的销子
             tempN.AddMarkLabel(pt,trunc(Y_Unit*0.4),False,False,False);
             tempN.AddMarkLabel(pt2,trunc(Y_Unit*0.4),False,False,False);
          // 千斤顶第一级
          tempN:=AddChildClass;
          tempN.Caption :='二级互帮千斤顶第1级';
          tempN.StartPoint:=StartPoint;
          tempN.X_Unit :=X_Unit;
          tempN.Y_Unit :=Y_Unit;
          // 分别计算相关的值
           Qjd_Jd:=GetAngleFromTwoPoint(pt,pt2);
           Qjd_l:=GetLengthFromTwoPoint(pt,pt2);

           if RECo.ZJ_First_HB_Jd< 90  then  begin
               Pt.x:= Pt2.x +trunc((Qjd_L*0.4)*Cos(ChangeJdToHu(Qjd_Jd)));
               pt.Y:= Pt2.Y -trunc((Qjd_L*0.4)*sin (ChangeJdToHu(Qjd_Jd)));
               tempN.BaseTWoPointDrawRect(pt,pt2,0.2,False);
           end else begin
                Pt2.x:= Pt.x+trunc((Qjd_L*0.6)*Cos(ChangeJdToHu(Qjd_Jd)));
                 pt2.Y:=Pt.Y -trunc((Qjd_L*0.6)*sin (ChangeJdToHu(Qjd_Jd)));
               tempN.BaseTWoPointDrawRect(pt,pt2,0.2,False);
           end ;
            tempN.DrawAndFill(true,1,ClYellow);



             //----------------------------------------
         tempN:=AddChildClass;
         tempN.Caption :='二级互帮第一级挡板';
         tempN.StartPoint:=StartPoint;
         tempN.X_Unit :=X_Unit;
         tempN.Y_Unit :=Y_Unit;
         { 开始点 1}  pt.x:= pt1.x+trunc(Y_Unit *0.1* Cos(ChangeJdToHu(270+Hu_Jd)) );
                          pt.Y:=pt1.Y -  trunc(Y_Unit *0.1* Sin(ChangeJdToHu(270+Hu_Jd)));
                        tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= pt.x+trunc(Y_Unit *3.5* Cos(ChangeJdToHu(280+Hu_Jd)) );
                           pt.Y:=pt.Y -  trunc(Y_Unit *3.5* Sin(ChangeJdToHu(280+Hu_Jd)));
                       tempN.AddPointNode(Pt)  ;

         { 连接点 1 一级互帮中心点}  pt.x:= pt1.x+trunc(Y_Unit *4* Cos(ChangeJdToHu(270+Hu_Jd)) );
                           pt.Y:=pt1.Y -  trunc(Y_Unit *4* Sin(ChangeJdToHu(270+Hu_Jd)));
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1 一级互帮中心点}  pt.x:= pt1.x+trunc(Y_Unit *4* Cos(ChangeJdToHu(270+Hu_Jd-8)) );
                           pt.Y:=pt1.Y -  trunc(Y_Unit *4* Sin(ChangeJdToHu(270+Hu_Jd-8)));
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}   pt.x:= pt1.x+trunc(Y_Unit *2* Cos(ChangeJdToHu(225+Hu_Jd)) );
                           pt.Y:=pt1.Y -  trunc(Y_Unit *2* Sin(ChangeJdToHu(225+Hu_Jd)));
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}   pt.x:= pt1.x+trunc(Y_Unit *(HB_L*2/3)* Cos(ChangeJdToHu(180+Hu_Jd+4)) );
                           pt.Y:=pt1.Y -  trunc(Y_Unit *(HB_L*2/3)* Sin(ChangeJdToHu(180+Hu_Jd+4)));
                       tempN.AddPointNode(Pt)  ;
          { 连接点 1}  pt.x:= pt1.x+trunc(Y_Unit *(HB_L*2/3)* Cos(ChangeJdToHu(180+Hu_Jd-4)) );
                           pt.Y:=pt1.Y -  trunc(Y_Unit *(HB_L*2/3)* Sin(ChangeJdToHu(180+Hu_Jd-4)));
                       tempN.AddPointNode(Pt)  ;
          tempN.DrawAndFill(true,1,Reco.Zj_body_fillColor);
          //--------------------------------

         // 第二段
          tempN:=AddChildClass;
          tempN.Caption :='液压二级互帮第二级 挡板';
          tempN.StartPoint:=StartPoint;
          tempN.X_Unit :=X_Unit;
          tempN.Y_Unit :=Y_Unit;

          { 连接点 1}  pt.x:= pt1.x+trunc(Y_Unit *(HB_L*2/3+0.3)* Cos(ChangeJdToHu(180+Hu_Jd+4)) );
                           pt.Y:=pt1.Y -  trunc(Y_Unit *(HB_L*2/3+0.3)* Sin(ChangeJdToHu(180+Hu_Jd+4)));
                       tempN.AddPointNode(Pt)  ;
          { 连接点 1}  pt.x:= pt1.x+trunc(Y_Unit *(HB_L*2/3+0.3)* Cos(ChangeJdToHu(180+Hu_Jd-4)) );
                           pt.Y:=pt1.Y -  trunc(Y_Unit *(HB_L*2/3+0.3)* Sin(ChangeJdToHu(180+Hu_Jd-4)));
                       tempN.AddPointNode(Pt)  ;

                       pt.x:= pt1.x+trunc(Y_Unit *(HB_L*2/3+0.3)* Cos(ChangeJdToHu(180+Hu_Jd)) );
                           pt.Y:=pt1.Y -  trunc(Y_Unit *(HB_L*2/3+0.3)* Sin(ChangeJdToHu(180+Hu_Jd)));

         { 开始点 1}  pt.x:= pt.x+trunc(Y_Unit *(HB_L*2/3)* Cos(ChangeJdToHu(180+RECo.ZJ_Second_HB_Jd+Hu_Jd)) );
                         pt.Y:=pt.Y -  trunc(Y_Unit *(HB_L*2/3)* Sin(ChangeJdToHu(180+RECo.ZJ_Second_HB_Jd+Hu_Jd)));
                        tempN.AddPointNode(Pt)  ;

         tempN.DrawAndFill(true,1,Reco.Zj_body_fillColor);

         pt.x:= pt1.x+trunc(Y_Unit *(HB_L*2/3+0.2)* Cos(ChangeJdToHu(180+Hu_Jd)) );
                           pt.Y:=pt1.Y -  trunc(Y_Unit *(HB_L*2/3+0.2)* Sin(ChangeJdToHu(180+Hu_Jd)));
         tempN.AddMarkLabel(pt,trunc(Y_Unit*0.5),true,False,False);
    end;

end;



procedure TDrawNode.Draw_DL_Main(Rec:TDrawZjRecord);
 {
    绘制支架顶梁
    Lizhu ： 立柱的数量
    DL  1 整体顶梁  2 铰接顶梁
    顶梁绘制的坐标基点 为 支架 顶梁的 TopLef
 }
var
   tempClass:TDrawNode;
   p0,pt:TPoint;
begin
    p0:=Rec.Zj_StartPoint;
    tempClass:=AddChildClass;
    tempClass.Caption :='液压支架顶梁';
    tempClass.StartPoint:=p0;
    tempClass.X_Unit :=X_Unit;
    tempClass.Y_Unit :=Y_Unit;
    
    // 2-1顶梁前面部分
    Draw_DL_QianDuan(Rec);
    // 顶梁通用部分
    tempClass.Draw_DL_Public(Rec);



//
//       if lizhu=2 then  begin   //两立柱底座
//       end;



end;

procedure TDrawNode.Draw_DL_Public(Rec:TDrawZjRecord);
{  顶梁通用部分
   顶梁的高度为 10个 Y_unit单位
}
var
  tempN:TDrawNode;
  p0,pt:TPoint;

begin
      p0:=StartPoint;
         tempN:=AddChildClass;
         if Rec.Zj_DL=1 then begin // 整体顶梁
            tempN.Caption :='整体顶梁-主梁';
         end else begin
            tempN.Caption :='铰接顶梁-主梁';
         end;

            tempN.StartPoint:=StartPoint;
            tempN.X_Unit :=X_Unit;
            tempN.Y_Unit :=Y_Unit;
              // 顶梁通用部分
         { 开始点}  pt.x:= p0.x+trunc(X_Unit *15);  pt.Y:=  trunc(p0.y);
                       tempN.AddPointNode(Pt)  ;

         { Top Right Cicle}  pt.X:=  p0.x+trunc(X_Unit *40-Y_Unit); pt.Y:= trunc(p0.y+Y_Unit);
                       tempN.DrawCircle(pt,Y_Unit,90,1);
         {Bottom Right Cicle}  pt.X:=  p0.x+trunc(X_Unit *40-Y_Unit); pt.Y:= trunc(p0.y+Y_Unit*7);
                       tempN.DrawCircle(pt,Y_Unit,360,270);
         {Bottom Right-left 1 Cicle}  pt.X:=  p0.x+trunc(X_Unit *36-Y_Unit); pt.Y:= trunc(p0.y+Y_Unit*7);
                       tempN.DrawCircle(pt,Y_Unit,270,225);
         {Bottom Right-left 1 Cicle}  pt.X:=  p0.x+trunc(X_Unit *35-2*Y_Unit); pt.Y:= trunc(p0.y+Y_Unit*8);
                       tempN.DrawCircle(pt,Y_Unit*2,45,90);
         { 连接点 2}  pt.x:= p0.x+trunc(X_Unit *30);  pt.Y:=  trunc(p0.y+Y_Unit*6);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 3}  pt.x:= p0.x+trunc(X_Unit *15+Y_Unit);  pt.Y:=  trunc(p0.y+Y_Unit*4);
                       tempN.AddPointNode(Pt)  ;
         {Bottom left 1 Cicle}  pt.X:=  p0.x+trunc(X_Unit *15+Y_Unit); pt.Y:= trunc(p0.y+Y_Unit*3);
                       tempN.DrawCircle(pt,Y_Unit,270,180);

         // 添加链接的销子
         pt.X:=  trunc(p0.x+X_Unit *38.5); pt.Y:=  trunc(p0.y+Y_Unit*4);
            tempN.AddMarkLabel(pt,trunc(Y_Unit),true,true,False);
         pt.X:=  trunc(p0.x+X_Unit *37); pt.Y:=  trunc(p0.y+Y_Unit*1.5);
            tempN.AddMarkLabel(pt,trunc(Y_Unit*0.8),FALSE,FALSE,False);
         pt.X:=  trunc(p0.x+X_Unit *36); pt.Y:=  trunc(p0.y+Y_Unit*7);
            tempN.AddMarkLabel(pt,trunc(Y_Unit*0.8),FALSE,FALSE,False);
         pt.X:=  trunc(p0.x+X_Unit *16); pt.Y:=  trunc(p0.y+Y_Unit*2);
            tempN.AddMarkLabel(pt,trunc(Y_Unit*0.4),false,FALSE,False);
         pt.X:=  trunc(p0.x+X_Unit *18); pt.Y:=  trunc(p0.y+Y_Unit*3.5);
            tempN.AddMarkLabel(pt,trunc(Y_Unit*0.4),FALSE,FALSE,False);
    //显示支架主体
    tempN.DrawAndFill(true,1,Rec.Zj_body_fillColor);

end;

procedure TDrawNode.Draw_DL_QianDuan(Reco:TDrawZjRecord);
{
   绘制顶梁前段的 结构部分
   Dl 1 整体 顶梁  2  铰接顶梁
   顶梁伸缩 从 X_unt 单位 5 到 15
   Reco.Zj_Dl_Suoliange  =100 时 顶梁的位置的 4
   Reco.Zj_Dl_Suoliange  =0 时 顶梁的位置的 12
}
var
  tempN:TDrawNode;
  p0,pt:TPoint;
  DL_ShenCount:integer;
  Sec_P:double;
begin
    DL_ShenCount:=Reco.Zj_Dl_Suoliange div 8;
    Sec_P:= 1.8 ;
//    p0.x:=StartPoint.x+trunc((12-DL_ShenCount  )*X_Unit);
//    P0.Y:=StartPoint.Y;
    p0:=Reco.Zj_DL_EndPoint;
    Reco.Zj_DL_EndPoint:=P0;
    if Reco.Zj_DL=1 then  begin // 整体顶梁
          tempN:=AddChildClass;
          tempN.Caption :='整体顶梁-互帮支撑结构';
          tempN.StartPoint:=StartPoint;
          tempN.X_Unit :=X_Unit;
          tempN.Y_Unit :=Y_Unit;
         { 开始点 1}  pt.x:= p0.x+trunc(X_Unit *0);  pt.Y:=  trunc(p0.y+Y_Unit*3.2);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *0);  pt.Y:=  trunc(p0.y+Y_Unit*0.5);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *0.3);  pt.Y:=  trunc(p0.y+Y_Unit*0.5);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *0.3);  pt.Y:=  trunc(p0.y+Y_Unit*3.1);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *0.3);  pt.Y:=  trunc(p0.y+Y_Unit*0.5);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *10);  pt.Y:=  trunc(p0.y+Y_Unit*0.8);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *10);  pt.Y:=  trunc(p0.y+Y_Unit*1.1);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *0.3);  pt.Y:=  trunc(p0.y+Y_Unit*0.8);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *10);  pt.Y:=  trunc(p0.y+Y_Unit*1.1);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *10);  pt.Y:=  trunc(p0.y+Y_Unit*2.5);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *1.5);  pt.Y:=  trunc(p0.y+Y_Unit*2.5);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *1.5);  pt.Y:=  trunc(p0.y+Y_Unit*3.2);
                       tempN.AddPointNode(Pt)  ;

         // 添加链接的销子
         pt.X:= p0.x+ trunc(Y_Unit ); pt.Y:=  trunc(p0.y+Y_Unit*2.5);
            tempN.AddMarkLabel(pt,trunc(Y_Unit*0.5),true,False,False);
         tempN.DrawAndFill(true,1,Reco.Zj_body_fillColor);
//
//         //------------------------------------------
          tempN:=AddChildClass;
          tempN.Caption :='整体顶梁-伸缩梁';
          tempN.StartPoint:=StartPoint;
          tempN.X_Unit :=X_Unit;
          tempN.Y_Unit :=Y_Unit;

         { 开始点}    pt.x:= p0.x+trunc(X_Unit *Sec_P );  pt.Y:=  trunc(p0.y+Y_Unit*3.7);
                      tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *Sec_P );  pt.Y:=  trunc(p0.y+Y_Unit*0);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *20);  pt.Y:=  trunc(p0.y+Y_Unit*0.2);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *20);  pt.Y:=  trunc(p0.y+Y_Unit*3.7);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *(Sec_P+0.3));  pt.Y:=  trunc(p0.y+Y_Unit*3.7);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *(Sec_P+0.3));  pt.Y:=  trunc(p0.y+Y_Unit*0.1);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *(Sec_P+0.3));  pt.Y:=  trunc(p0.y+Y_Unit*3.7);
                      tempN.AddPointNode(Pt)  ;
          //  添加链接的销子
           pt.X:=  trunc(p0.x+X_Unit *(Sec_P+1) ); pt.Y:=  trunc(p0.y+Y_Unit*1.5);
            tempN.AddMarkLabel(pt,trunc(Y_Unit*0.6),true,FALSE,False);
         tempN.DrawAndFill(true,1,Reco.Zj_body_fillColor);
//
    end else begin  // 铰接顶梁
          tempN:=AddChildClass;
          tempN.Caption :='液压支架铰接顶梁第一节';
          tempN.StartPoint:=StartPoint;
          tempN.X_Unit :=X_Unit;
          tempN.Y_Unit :=Y_Unit;

         { 开始点}  pt.x:= p0.x+trunc(X_Unit *7.5-Y_Unit *0.5);  pt.Y:=  trunc(p0.y+Y_Unit*3);
                        tempN.DrawCircle(pt,Y_Unit*0.5,360,225);
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *6);  pt.Y:=  trunc(p0.y+Y_Unit*3);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *6);  pt.Y:=  trunc(p0.y+Y_Unit*2);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *6 + Y_Unit *0.5);  pt.Y:=  trunc(p0.y+Y_Unit*1.5);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *6 + Y_Unit *0.5);  pt.Y:=  trunc(p0.y);
                       tempN.AddPointNode(Pt)  ;
         { 连接点 1}  pt.x:= p0.x+trunc(X_Unit *7.5);  pt.Y:=  trunc(p0.y);
                       tempN.AddPointNode(Pt)  ;

         // 添加链接的销子
        pt.X:=  trunc(p0.x+X_Unit *7.5-Y_Unit*0.4 ); pt.Y:=  trunc(p0.y+Y_Unit*3);
            tempN.AddMarkLabel(pt,trunc(Y_Unit*0.4),FALSE,FALSE,False);


             //显第一节附件
         tempN.DrawAndFill(true,1,Reco.Zj_body_fillColor);
    end;



end;

procedure TDrawNode.Draw_Lizhu(Rec: TDrawZjRecord);
{
  绘制液压支架的立柱
}
var
  tempN:TDrawNode;
  Second_St,Third_Sd:TPoint;

begin
      //------------------------------------------
     if Rec.zj_LZ=2 then begin  // 两立柱支架
          //根据缩量计算第二级立柱的开始为主
        Second_St:=FromTwoPointCalMidPoint(2,Rec.Zj_Lizhu_First_St_Pt,Rec.Zj_Lizhu_First_ed_Pt,Rec.Zj_LiZhu_SuoLiang);
        Third_Sd:=FromTwoPointCalMidPoint(1,Rec.Zj_Lizhu_First_St_Pt,Rec.Zj_Lizhu_First_ed_Pt,Rec.Zj_LiZhu_SuoLiang);
//        //-----------------------------
        tempN:=AddChildClass;
        tempN.Caption :='两立柱支架第三节';
        tempN.StartPoint:=StartPoint;
        tempN.X_Unit :=X_Unit;
        tempN.Y_Unit :=Y_Unit;

         // 第三级活柱的杆
        tempN.BaseTWoPointDrawRect(Rec.Zj_Lizhu_First_St_Pt,Rec.Zj_Lizhu_First_ed_Pt,1.5,False);
         // 显示 伸缩杆主体
        tempN.DrawAndFill(true,1,$e9e7ef);
          //-----------------------------
        tempN:=AddChildClass;
        tempN.Caption :='两立柱支架第二节';
        tempN.StartPoint:=StartPoint;
        tempN.X_Unit :=X_Unit;
        tempN.Y_Unit :=Y_Unit;
         // 第二级级活柱的杆
        tempN.BaseTWoPointDrawRect(Second_St,Rec.Zj_Lizhu_First_ed_Pt,2,False);
         // 显示 伸缩杆主体
        tempN.DrawAndFill(true,1,$e9e7ef);
//          //-----------------------------
        tempN:=AddChildClass;
        tempN.Caption :='两立柱支架最下面一节';
        tempN.StartPoint:=StartPoint;
        tempN.X_Unit :=X_Unit;
        tempN.Y_Unit :=Y_Unit;
         // 第二级级活柱的杆
        tempN.BaseTWoPointDrawRect(Third_Sd,Rec.Zj_Lizhu_First_ed_Pt,2.5,False);
         // 显示 伸缩杆主体
        tempN.DrawAndFill(true,1,clYellow);

     end else if Rec.zj_LZ=4 then begin  // 四立柱支架
         //---------------------------
         // 前柱的 数据
         //--------------------------
        Second_St:=FromTwoPointCalMidPoint(2,Rec.Zj_Lizhu_First_St_Pt,Rec.Zj_Lizhu_First_ed_Pt,Rec.Zj_LiZhu_SuoLiang);
        Third_Sd:=FromTwoPointCalMidPoint(1,Rec.Zj_Lizhu_First_St_Pt,Rec.Zj_Lizhu_First_ed_Pt,Rec.Zj_LiZhu_SuoLiang);
//        //-----------------------------
        tempN:=AddChildClass;
        tempN.Caption :='前柱支架第三节';
        tempN.StartPoint:=StartPoint;
        tempN.X_Unit :=X_Unit;
        tempN.Y_Unit :=Y_Unit;

         // 第三级活柱的杆
        tempN.BaseTWoPointDrawRect(Rec.Zj_Lizhu_First_St_Pt,Rec.Zj_Lizhu_First_ed_Pt,0.8,False);
         // 显示 伸缩杆主体
        tempN.DrawAndFill(true,1,$e9e7ef);
          //-----------------------------
        tempN:=AddChildClass;
        tempN.Caption :='前柱支架第二节';
        tempN.StartPoint:=StartPoint;
        tempN.X_Unit :=X_Unit;
        tempN.Y_Unit :=Y_Unit;
         // 第二级级活柱的杆
        tempN.BaseTWoPointDrawRect(Second_St,Rec.Zj_Lizhu_First_ed_Pt,1.2,False);
         // 显示 伸缩杆主体
        tempN.DrawAndFill(true,1,$e9e7ef);
//          //-----------------------------
        tempN:=AddChildClass;
        tempN.Caption :='前柱支架最下面一节';
        tempN.StartPoint:=StartPoint;
        tempN.X_Unit :=X_Unit;
        tempN.Y_Unit :=Y_Unit;
         // 第二级级活柱的杆
        tempN.BaseTWoPointDrawRect(Third_Sd,Rec.Zj_Lizhu_First_ed_Pt,1.6,False);
         // 显示 伸缩杆主体
        tempN.DrawAndFill(true,1,clYellow);
        //---------------------------------------------
        //后柱的数据
        //------------------------------------------------
        // 前柱的 数据
        Second_St:=FromTwoPointCalMidPoint(2,Rec.Zj_Lizhu_Second_St_Pt,Rec.Zj_Lizhu_Second_ed_Pt,Rec.Zj_LiZhu_SuoLiang);
        Third_Sd:=FromTwoPointCalMidPoint(1,Rec.Zj_Lizhu_Second_St_Pt,Rec.Zj_Lizhu_Second_ed_Pt,Rec.Zj_LiZhu_SuoLiang);
//        //-----------------------------
        tempN:=AddChildClass;
        tempN.Caption :='后柱支架第三节';
        tempN.StartPoint:=StartPoint;
        tempN.X_Unit :=X_Unit;
        tempN.Y_Unit :=Y_Unit;

         // 第三级活柱的杆
        tempN.BaseTWoPointDrawRect(Rec.Zj_Lizhu_Second_St_Pt,Rec.Zj_Lizhu_Second_ed_Pt,0.8,False);
         // 显示 伸缩杆主体
        tempN.DrawAndFill(true,1,$e9e7ef);
          //-----------------------------
        tempN:=AddChildClass;
        tempN.Caption :='后柱支架第二节';
        tempN.StartPoint:=StartPoint;
        tempN.X_Unit :=X_Unit;
        tempN.Y_Unit :=Y_Unit;
         // 第二级级活柱的杆
        tempN.BaseTWoPointDrawRect(Second_St,Rec.Zj_Lizhu_Second_ed_Pt,1.2,False);
         // 显示 伸缩杆主体
        tempN.DrawAndFill(true,1,$e9e7ef);
//          //-----------------------------
        tempN:=AddChildClass;
        tempN.Caption :='后柱支架最下面一节';
        tempN.StartPoint:=StartPoint;
        tempN.X_Unit :=X_Unit;
        tempN.Y_Unit :=Y_Unit;
         // 第二级级活柱的杆
        tempN.BaseTWoPointDrawRect(Third_Sd,Rec.Zj_Lizhu_Second_ed_Pt,1.6,False);
         // 显示 伸缩杆主体
        tempN.DrawAndFill(true,1,clYellow);
        //---------------------------------------------
     end;



        //------------------------------------------
end;

procedure TDrawNode.Draw_Reluer(Rec: TDrawZjRecord);
var
   tempN:TDrawNode;
   Rule_st,Rule_ed:TPoint;
   Hu_jd:Double;
   P0,pt1,pt2:TPoint;
begin
     tempN:=AddChildClass;
     tempN.Caption :='液压支架整体标尺';
     tempN.StartPoint:=StartPoint;
     tempN.X_Unit :=X_Unit;
     tempN.Y_Unit :=Y_Unit;

      // 增加液压支架设计标注标尺
      Rule_st.X :=FmaxYs.x-trunc(x_unit *2) ; Rule_st.Y:= self.FWithoutYs.y ;
      Rule_ed.X :=FmaxYs.x-trunc(x_unit *2)  ; Rule_ed.Y:= EndPoint.y ;
      tempN.AddLabelRuler(1,Rule_st,Rule_ed,'支架设计最大高度【'+FormatFloat('0.0',ZJ_Disgn_Max_H) +'】米',FALSE,True,ClBlue);
      // 增加液压支架设计最小高度标尺
      Rule_st.X :=FmaxYs .x-trunc(x_unit *4) ; Rule_st.Y:= FmaxYs.y ;
      Rule_ed.X :=FmaxYs .x-trunc(x_unit *4)  ; Rule_ed.Y:= EndPoint.y ;
      tempN.AddLabelRuler(1,Rule_st,Rule_ed,'支架设计最小高度【'+FormatFloat('0.0',ZJ_Disgn_Min_H) +'】米',FALSE,True,ClBlue);
      // 增加液压支架最小高度水平线
      Rule_st.X :=StartPoint.x ; Rule_st.Y:= FmaxYs.y ;
      Rule_ed.X :=FmaxYs .x-trunc(x_unit *4) ; Rule_ed.Y:= FmaxYs.y  ;
      tempN.AddLabelRuler(1,Rule_st,Rule_ed,'',FALSE,FALSE,ClGreen);

      // 液压支架正常工作高度
      Rule_st.X :=Rec.Zj_Lizhu_First_St_Pt.x div 3 ; Rule_st.Y:=  FWithoutYs.y + Trunc(ReturnSuoLiang(ZJ_Use_Max_H)*Y_unit ) ;
      Rule_ed.X :=FmaxYs .x-trunc(x_unit *4) ; Rule_ed.Y:= Rule_st.Y ;
      tempN.AddLabelRuler(1,Rule_st,Rule_ed,'',FALSE,FALSE,ClGray);

      Rule_st.X :=Rec.Zj_Lizhu_First_St_Pt.x div 3 ; Rule_st.Y:= FWithoutYs.y + Trunc(ReturnSuoLiang(ZJ_Use_Max_H)*Y_unit ) ;
      Rule_ed.X :=Rec.Zj_Lizhu_First_St_Pt.x div 3 ; Rule_ed.Y:= EndPoint.y ;  ;
      tempN.AddLabelRuler(1,Rule_st,Rule_ed,'支架正常工作高度【'+FormatFloat('0.0',self.ZJ_Use_Max_H) +'】米',FALSE,true,ClBlue);
       // 液压支架正常工作可能的高度
      Rule_st.X :=Rec.Zj_Lizhu_First_St_Pt.x div 2; Rule_st.Y:= FWithoutYs.y + Trunc(ReturnSuoLiang(ZJ_Use_Min_H)*Y_unit ) ;
      Rule_ed.X :=FmaxYs .x-trunc(x_unit *4) ; Rule_ed.Y:= Rule_st.Y ;
      tempN.AddLabelRuler(1,Rule_st,Rule_ed,'',FALSE,FALSE,ClGray);

      Rule_st.X :=Rec.Zj_Lizhu_First_St_Pt.x div 2 ; Rule_st.Y:= FWithoutYs.y + Trunc(ReturnSuoLiang(ZJ_Use_Min_H)*Y_unit ) ;
      Rule_ed.X :=Rec.Zj_Lizhu_First_St_Pt.x div 2 ; Rule_ed.Y:= EndPoint.y ;  ;
      tempN.AddLabelRuler(1,Rule_st,Rule_ed,'顶板来压时支架可能工作高度【'+FormatFloat('0.0',self.ZJ_Use_MIn_H) +'】米',FALSE,true,ClBlue);
      // 标志来压状态受力
      if Rec.Disp_ComeState =1 then   begin  //如果是来压状态
         Rule_st.X :=Rec.Zj_Lizhu_First_St_Pt.x  ; Rule_st.Y:= FWithoutYs.y  ;
         Rule_ed.X :=Rec.Zj_Lizhu_First_St_Pt.x  ; Rule_ed.Y:= FWithoutYs.y + Trunc(ReturnSuoLiang(ZJ_Use_Max_H)*Y_unit );  ;
         tempN.AddLabelRuler(2,Rule_st,Rule_ed,'顶板工作压力在【'+FormatFloat('0',ZJ_Usual_F) +'-' +
                             FormatFloat('0',ZJ_max_F) +'KN】之间',FALSE,true,ClBlack);
      end else  if Rec.Disp_ComeState =2 then   begin  //如果是来压状态
         Rule_st.X :=Rec.Zj_Lizhu_First_St_Pt.x  ; Rule_st.Y:= FWithoutYs.y +Trunc(ReturnSuoLiang(ZJ_Use_MIn_H)*Y_unit /3) ;
         Rule_ed.X :=Rec.Zj_Lizhu_First_St_Pt.x  ; Rule_ed.Y:= FWithoutYs.y + Trunc(ReturnSuoLiang(ZJ_Use_MIn_H)*Y_unit ) ;
         tempN.AddLabelRuler(2,Rule_st,Rule_ed,'顶板整体压力大于【'+FormatFloat('0',ZJ_max_F) +'KN】',FALSE,true,ClBlack);

      end;

      // 为护帮进行标注
        Hu_Jd:=Rec.ZJ_First_HB_Jd;
       p0.X :=Rec.First_HB_Center.x+trunc(Y_Unit *2.5 * Cos(ChangeJdToHu(90+Hu_Jd)) );
         p0.Y :=Rec.First_HB_Center.y- round(Y_Unit *2.5 *sin(ChangeJdToHu(90+Hu_Jd))) ;
    if Rec.Zj_Hb=1 then  begin // 一级互帮
         Rule_st:=p0;
         Rule_ed.X := p0.x+trunc(Y_Unit *REC.Zj_First_hb_L * Cos(ChangeJdToHu(180+Hu_Jd)) );
         Rule_ed.Y := p0.Y -  trunc(Y_Unit *REC.Zj_First_hb_L * Sin(ChangeJdToHu(180+Hu_Jd)));
         tempN.AddLabelRuler(1,Rule_st,Rule_ed,'支架一级互帮高度【'+FormatFloat('0.0',Rec.HB_H ) +'】米',FALSE,true,ClBlue);

    end else if Rec.Zj_Hb=2 then  begin // 二级互帮
         Rule_ed:=p0;
         Rule_st.X := p0.x+trunc(Y_Unit *(REC.Zj_First_hb_L*2/3+0.3)* Cos(ChangeJdToHu(180+Hu_Jd+4)) );
         Rule_st.Y := p0.Y -  trunc(Y_Unit *(REC.Zj_First_hb_L*2/3+0.3)* Sin(ChangeJdToHu(180+Hu_Jd+4)));
          Rule_st.x:= Rule_st.x+trunc(Y_Unit *(REC.Zj_First_hb_L*2/3)* Cos(ChangeJdToHu(180+REC.ZJ_Second_HB_Jd+Hu_Jd)) );
                   Rule_st.Y:=Rule_st.Y -  trunc(Y_Unit *(REC.Zj_First_hb_L*2/3)* Sin(ChangeJdToHu(180+REC.ZJ_Second_HB_Jd+Hu_Jd)));

          tempN.AddLabelRuler(1,Rule_st,Rule_ed,'支架二级互帮高度【'+FormatFloat('0.0',Rec.HB_H ) +'】米',FALSE,true,ClBlue);
    end;
    //护帮受力图
//      pt1.X:= (Rule_st.X+ Rule_ed.Y ) div 2;
//     pt1.Y:= (Rule_st.Y+ Rule_ed.Y ) div 2;
//     Pt2.X :=Pt1.X+100;
//     Pt2.Y:=pt1.Y ;
//     tempN.AddLabelRuler(2,pt2,pt1,'支架护帮的强度为'+FormatFloat('0.0',REC.HB_QD) +'MPA】',FALSE,true,ClBlack);
end;

procedure TDrawNode.Draw_Xc(Rec:TDrawZjRecord;FillC:TColor);
var
  i,j:Integer;
begin
   if FChildCount>0 then
     for I := 0 to FChildCount-1 do  begin
        //函数递归调用 绘制销子
        FChlidClass[i].Draw_Xc(Rec,FillC);
     end;


   if FMarkCount>0 then   // 绘制销子
      for I := 0 to FMarkCount-1 do
         FMarkArry[i].DrawMark(true,FillC);

   if Rec.ReulerMark  then
     if FLabelMarkCount>0 then   // 绘制标尺
      for I := 0 to FLabelMarkCount-1 do
         FMarkRuler[i].DrawMark(true,FillC);


end;

procedure TDrawNode.Draw_Zc_Dz(Rec:TDrawZjRecord);
{
  底座绘制的坐标 基点为 底座的 Bottomright
}
var
   tempClass:TDrawNode;
   p0,pt:TPoint;
begin
    p0.x:=StartPoint.X ;P0.Y:=EndPoint.Y ;
    tempClass:=AddChildClass;
    tempClass.Caption :='液压支架底座加强';
    tempClass.StartPoint:=p0;
    tempClass.X_Unit :=X_Unit;
    tempClass.Y_Unit :=Y_Unit;

       if Rec.zj_LZ=2 then  begin   //两立柱底座

          { 开始点}  pt.x:= p0.x+trunc(X_Unit *46);  pt.Y:=  trunc(p0.y);
                     tempClass.AddPointNode(Pt)  ;
    //      { } pt.x:= trunc(p0.x-X_Unit *4);  pt.Y:=  trunc(p0.y);
    //                 DzClass.AddPointNode(Pt)  ;
          { 做下半圆}  pt.X:=  p0.x+trunc(X_Unit *47-Y_Unit); pt.Y:=  p0.y-trunc(Y_Unit);
                     tempClass.DrawCircle(pt,Y_Unit,270,360);

          { 做上半圆}  pt.X:=  p0.x+trunc(X_Unit *47-Y_Unit); pt.Y:=  p0.y-trunc(Y_Unit);
                     tempClass.DrawCircle(pt,Y_Unit,0,60);

          { 做第二立柱处半圆}  pt.X:=  p0.x+trunc(X_Unit *40); pt.Y:=  p0.y-trunc(Y_Unit*9);
                     tempClass.DrawCircle(pt,Y_Unit,60,120);

          { 连接线} pt.x:= p0.x+round(X_Unit *38);  pt.Y:=  p0.y-round(Y_Unit*9);
                      tempClass.AddPointNode(Pt)  ;

          { 做第三处半圆}  pt.X:=  p0.x+trunc(X_Unit *34+Y_Unit); pt.Y:=  p0.y-trunc(Y_Unit*8);
                     tempClass.DrawCircle(pt,Y_Unit,90,180);

          { 做第四处半圆}  pt.X:= p0.x+ trunc(X_Unit *34-Y_Unit); pt.Y:= p0.y- trunc(Y_Unit*7);
                     tempClass.DrawCircle(pt,Y_Unit,360,270);

          { 做第五处半圆}  pt.X:=  p0.x+trunc(X_Unit *25+Y_Unit); pt.Y:=  p0.y-trunc(Y_Unit*5);
                     tempClass.DrawCircle(pt,Y_Unit,90,180);

          { 做第六处半圆}  pt.X:=  p0.x+trunc(X_Unit *25-Y_Unit); pt.Y:= p0.y- trunc(Y_Unit*4);
                     tempClass.DrawCircle(pt,Y_Unit,360,270);

         { 底座靠近溜子的上结点}    pt.X:=  p0.x+trunc(X_Unit *20); pt.Y:=  p0.y-trunc(Y_Unit*3);
                     tempClass.DrawCircle(pt,Y_Unit*0.5,360,270);
    //                  pt.X:=  p0.x-trunc(X_Unit *30); pt.Y:=  p0.y-trunc(Y_Unit*1);
    //                  DzClass.AddPointNode(Pt)  ;
          { 底座靠近溜子的下结点}    pt.X:=  p0.x+trunc(X_Unit *20+Y_Unit); pt.Y:=p0.y-trunc(Y_Unit);
                     tempClass.DrawCircle(pt,Y_Unit,180,270);
          // 添加链接的销子
             pt.X:=  trunc(p0.x+X_Unit *43.5); pt.Y:=  trunc(p0.y-Y_Unit*3);
                tempClass.AddMarkLabel(pt,trunc(Y_Unit),true,true,False);
             pt.X:=  round(p0.x+X_Unit *39.5); pt.Y:=  trunc(p0.y-Y_Unit*7);
                tempClass.AddMarkLabel(pt,trunc(Y_Unit),true,true,False);

             pt.X:=  trunc(p0.x+X_Unit *46); pt.Y:=  round(p0.y-Y_Unit*0.8);
                tempClass.AddMarkLabel(pt,trunc(Y_Unit/2),False,False,False);

             pt.X:=  trunc(p0.x+X_Unit *36); pt.Y:=  trunc(p0.y-Y_Unit*1.5);
                tempClass.AddMarkLabel(pt,trunc(Y_Unit*1.1),False,False,False);

             pt.X:=  trunc(p0.x+X_Unit *30); pt.Y:=  trunc(p0.y-Y_Unit*1.5);
                tempClass.AddMarkLabel(pt,trunc(Y_Unit/2.5),False,False,False);
             // {1-3 绘制推溜千斤顶}
            tempClass.Draw_Zc_Dz_Fj_2(Rec);
             //显示底座底层
            tempClass.DrawAndFill(true,1,Rec.Zj_body_fillColor);
            // {1-2 绘制底座附件}
            tempClass.Draw_Zc_Dz_Fj_1(Rec);
       end else if Rec.zj_LZ=4 then  begin   //四立柱底座

          { 开始点}  pt.x:= p0.x+trunc(X_Unit *46);  pt.Y:=  trunc(p0.y);
                     tempClass.AddPointNode(Pt)  ;
    //      { } pt.x:= trunc(p0.x-X_Unit *4);  pt.Y:=  trunc(p0.y);
    //                 DzClass.AddPointNode(Pt)  ;
          { 做下半圆}  pt.X:=  p0.x+trunc(X_Unit *47-Y_Unit); pt.Y:=  p0.y-trunc(Y_Unit);
                     tempClass.DrawCircle(pt,Y_Unit,270,360);

          { 做上半圆}  pt.X:=  p0.x+trunc(X_Unit *47-Y_Unit); pt.Y:=  p0.y-trunc(Y_Unit);
                     tempClass.DrawCircle(pt,Y_Unit,0,60);

          { 做第二立柱处半圆}  pt.X:=  p0.x+trunc(X_Unit *40); pt.Y:=  p0.y-trunc(Y_Unit*9);
                     tempClass.DrawCircle(pt,Y_Unit,60,120);

          { 连接线} pt.x:= p0.x+round(X_Unit *38);  pt.Y:=  p0.y-round(Y_Unit*9);
                      tempClass.AddPointNode(Pt)  ;

          { 做第三处半圆}  pt.X:=  p0.x+trunc(X_Unit *34+Y_Unit); pt.Y:=  p0.y-trunc(Y_Unit*8);
                     tempClass.DrawCircle(pt,Y_Unit,90,180);

          { 做第四处半圆}  pt.X:= p0.x+ trunc(X_Unit *34-Y_Unit); pt.Y:= p0.y- trunc(Y_Unit*7);
                     tempClass.DrawCircle(pt,Y_Unit,360,270);

          { 做第五处半圆}  pt.X:=  p0.x+trunc(X_Unit *20+Y_Unit); pt.Y:=  p0.y-trunc(Y_Unit*5);
                     tempClass.DrawCircle(pt,Y_Unit,90,180);

          { 做第六处半圆}  pt.X:=  p0.x+trunc(X_Unit *20-Y_Unit); pt.Y:= p0.y- trunc(Y_Unit*4);
                     tempClass.DrawCircle(pt,Y_Unit,360,270);

         { 底座靠近溜子的上结点}    pt.X:=  p0.x+trunc(X_Unit *18); pt.Y:=  p0.y-trunc(Y_Unit*3);
                     tempClass.DrawCircle(pt,Y_Unit*0.5,360,270);
    //                  pt.X:=  p0.x-trunc(X_Unit *30); pt.Y:=  p0.y-trunc(Y_Unit*1);
    //                  DzClass.AddPointNode(Pt)  ;
          { 底座靠近溜子的下结点}    pt.X:=  p0.x+trunc(X_Unit *18+Y_Unit); pt.Y:=p0.y-trunc(Y_Unit);
                     tempClass.DrawCircle(pt,Y_Unit,180,270);
          // 添加链接的销子
             pt.X:=  trunc(p0.x+X_Unit *43.5); pt.Y:=  trunc(p0.y-Y_Unit*3);
                tempClass.AddMarkLabel(pt,trunc(Y_Unit),true,true,False);
             pt.X:=  round(p0.x+X_Unit *39.5); pt.Y:=  trunc(p0.y-Y_Unit*7);
                tempClass.AddMarkLabel(pt,trunc(Y_Unit),true,true,False);

             pt.X:=  trunc(p0.x+X_Unit *46); pt.Y:=  round(p0.y-Y_Unit*0.8);
                tempClass.AddMarkLabel(pt,trunc(Y_Unit/2),False,False,False);

             pt.X:=  trunc(p0.x+X_Unit *36); pt.Y:=  trunc(p0.y-Y_Unit*1.5);
                tempClass.AddMarkLabel(pt,trunc(Y_Unit*1.1),False,False,False);

             pt.X:=  trunc(p0.x+X_Unit *30); pt.Y:=  trunc(p0.y-Y_Unit*1.5);
                tempClass.AddMarkLabel(pt,trunc(Y_Unit/2.5),False,False,False);
             // {1-3 绘制推溜千斤顶}
            tempClass.Draw_Zc_Dz_Fj_2(REc);
             //显示底座底层
            tempClass.DrawAndFill(true,1,Rec.Zj_body_fillColor);
            // {1-2 绘制底座附件}
            tempClass.Draw_Zc_Dz_Fj_1(Rec);
       end;




end;

procedure TDrawNode.Draw_Zc_Dz_Fj_1(Rec:TDrawZjRecord);
var
  tempN:TDrawNode;
  p0,pt:TPoint;
  nsl:double;
begin
      p0:=StartPoint;
      nsl:=0.15;
      tempN:=AddChildClass;
      tempN.Caption :='液压支架底座附件';
      tempN.StartPoint:=StartPoint;
      tempN.X_Unit :=X_Unit;
      tempN.Y_Unit :=Y_Unit;
      if Rec.zj_LZ=2 then  begin   //两立柱底座
          { 做第三处半圆}  pt.X:=  trunc(p0.x+X_Unit *34+Y_Unit); pt.Y:=  trunc(p0.y-Y_Unit*8);
                     tempN.DrawCircle(pt,Y_Unit*(1-nsl),90,180);
          { 做第四处半圆}  pt.X:=  trunc(p0.x+X_Unit *34-Y_Unit); pt.Y:=  trunc(p0.y-Y_Unit*7);
                     tempN.DrawCircle(pt,Y_Unit*(1+nsl),360,270);
          { 做第五处半圆}  pt.X:=  trunc(p0.x+X_Unit *25+Y_Unit); pt.Y:=  trunc(p0.y-Y_Unit*5);
                     tempN.DrawCircle(pt,Y_Unit*(1-nsl),90,180);
          { 做第六处半圆}  pt.X:=  trunc(p0.x+X_Unit *25+Y_Unit); pt.Y:=  trunc(p0.y-Y_Unit*4);
                     tempN.DrawCircle(pt,Y_Unit*(1-nsl),180,270);
          { 做第七处半圆}  pt.X:=  trunc(p0.x+X_Unit *37-Y_Unit); pt.Y:=  trunc(p0.y-Y_Unit*4);
                     tempN.DrawCircle(pt,Y_Unit*(1-nsl),270,360);
          { 做第八处半圆}  pt.X:=  trunc(p0.x+X_Unit *37-Y_Unit); pt.Y:=  trunc(p0.y-Y_Unit*8);
                     tempN.DrawCircle(pt,Y_Unit*(1-nsl),0,90);
    //
    //
          // 添加链接的销子
             pt.X:=  trunc(p0.x+X_Unit *35.5); pt.Y:=  trunc(p0.y-Y_Unit*7);
                tempN.AddMarkLabel(pt,trunc(Y_Unit*0.8),False,False,False);
             pt.X:=  trunc(p0.x+X_Unit *33); pt.Y:=  trunc(p0.y-Y_Unit*4.5);
                tempN.AddMarkLabel(pt,trunc(Y_Unit*0.4),False,False,False);


       end else  if REc.zj_LZ=4 then  begin   //四立柱底座
           { 做第三处半圆}  pt.X:=  trunc(p0.x+X_Unit *34+Y_Unit); pt.Y:=  trunc(p0.y-Y_Unit*8);
                     tempN.DrawCircle(pt,Y_Unit*(1-nsl),90,180);
          { 做第四处半圆}  pt.X:=  trunc(p0.x+X_Unit *34-Y_Unit); pt.Y:=  trunc(p0.y-Y_Unit*7);
                     tempN.DrawCircle(pt,Y_Unit*(1+nsl),360,270);
          { 做第五处半圆}  pt.X:=  trunc(p0.x+X_Unit *20+Y_Unit); pt.Y:=  trunc(p0.y-Y_Unit*5);
                     tempN.DrawCircle(pt,Y_Unit*(1-nsl),90,180);
          { 做第六处半圆}  pt.X:=  trunc(p0.x+X_Unit *20+Y_Unit); pt.Y:=  trunc(p0.y-Y_Unit*4);
                     tempN.DrawCircle(pt,Y_Unit*(1-nsl),180,270);
          { 做第七处半圆}  pt.X:=  trunc(p0.x+X_Unit *37-Y_Unit); pt.Y:=  trunc(p0.y-Y_Unit*4);
                     tempN.DrawCircle(pt,Y_Unit*(1-nsl),270,360);
          { 做第八处半圆}  pt.X:=  trunc(p0.x+X_Unit *37-Y_Unit); pt.Y:=  trunc(p0.y-Y_Unit*8);
                     tempN.DrawCircle(pt,Y_Unit*(1-nsl),0,90);
    //
    //
          // 添加链接的销子
             pt.X:=  trunc(p0.x+X_Unit *35.5); pt.Y:=  trunc(p0.y-Y_Unit*7);
                tempN.AddMarkLabel(pt,trunc(Y_Unit*0.8),False,False,False);
             pt.X:=  trunc(p0.x+X_Unit *33); pt.Y:=  trunc(p0.y-Y_Unit*4.5);
                tempN.AddMarkLabel(pt,trunc(Y_Unit*0.4),False,False,False);

       end;
       tempN.DrawAndFill(true,1,Rec.Zj_body_fillColor);



end;

procedure TDrawNode.Draw_Zc_Dz_Fj_2(Rec:TDrawZjRecord);
{
  绘制支架前方推溜千斤顶
}
var
  tempN:TDrawNode;
  p0,pt:TPoint;
  nsl:double;
begin
      p0:=StartPoint;
      nsl:=0.3;
      tempN:=AddChildClass;
      tempN.Caption :='液压支架底座推溜千斤顶';
      tempN.StartPoint:=StartPoint;
      tempN.X_Unit :=X_Unit;
      tempN.Y_Unit :=Y_Unit;
       if REc.zj_LZ=2 then  begin   //两立柱底座
          { 开始点}  pt.x:= p0.x+trunc(X_Unit *20);  pt.Y:=  trunc(p0.y-Y_Unit*1.5);
                     tempN.AddPointNode(Pt)  ;
          { 连接点}  pt.x:= p0.x+trunc(X_Unit *19.5);  pt.Y:=  trunc(p0.y-Y_Unit*1.5);
                     tempN.AddPointNode(Pt)  ;
          { 做第一处多半圆}  pt.X:=  trunc(p0.x+X_Unit *18); pt.Y:=  trunc(p0.y-Y_Unit*1.5);
                     tempN.DrawCircle(pt,Y_Unit,60,270);
          { 连接点}  pt.x:= p0.x+trunc(X_Unit *20);  pt.Y:=  trunc(p0.y-Y_Unit*0.5);
                     tempN.AddPointNode(Pt)  ;
    //
    //
          // 添加链接的销子
             pt.X:=  trunc(p0.x+X_Unit *18); pt.Y:=  trunc(p0.y-Y_Unit*1.5);
                tempN.AddMarkLabel(pt,trunc(Y_Unit*0.5),False,False,False);
             pt.X:=  trunc(p0.x+X_Unit *22); pt.Y:=  trunc(p0.y-Y_Unit*1.5);
                tempN.AddMarkLabel(pt,trunc(Y_Unit*0.8),true,true,False);


       end else  if REc.zj_LZ=4 then  begin   //四立柱底座
          { 开始点}  pt.x:= p0.x+trunc(X_Unit *18);  pt.Y:=  trunc(p0.y-Y_Unit*1.5);
                     tempN.AddPointNode(Pt)  ;
          { 连接点}  pt.x:= p0.x+trunc(X_Unit *17.5);  pt.Y:=  trunc(p0.y-Y_Unit*1.5);
                     tempN.AddPointNode(Pt)  ;
          { 做第一处多半圆}  pt.X:=  trunc(p0.x+X_Unit *16); pt.Y:=  trunc(p0.y-Y_Unit*1.5);
                     tempN.DrawCircle(pt,Y_Unit,60,270);
          { 连接点}  pt.x:= p0.x+trunc(X_Unit *18);  pt.Y:=  trunc(p0.y-Y_Unit*0.5);
                     tempN.AddPointNode(Pt)  ;
    //
    //
          // 添加链接的销子
             pt.X:=  trunc(p0.x+X_Unit *16); pt.Y:=  trunc(p0.y-Y_Unit*1.5);
                tempN.AddMarkLabel(pt,trunc(Y_Unit*0.5),False,False,False);
             pt.X:=  trunc(p0.x+X_Unit *20); pt.Y:=  trunc(p0.y-Y_Unit*1.5);
                tempN.AddMarkLabel(pt,trunc(Y_Unit*0.8),true,true,False);
       end;

       tempN.DrawAndFill(true,1,REc.Zj_body_fillColor);


end;

procedure TDrawNode.Draw_Zc_Dz_First(Rec:TDrawZjRecord);
{
  绘制底座后端附件
}
var
  tempN:TDrawNode;
  p0,pt:TPoint;

begin
      p0:=EndPoint;
      tempN:=AddChildClass;
      tempN.Caption :='液压支架底座后端附件';
      tempN.StartPoint:=StartPoint;
      tempN.X_Unit :=X_Unit;
      tempN.Y_Unit :=Y_Unit;

      { 开始点}  pt.x:= p0.x+trunc(X_Unit *45);  pt.Y:=  trunc(p0.y-Y_Unit*0);
                 tempN.AddPointNode(Pt)  ;
      { 做第一处多半圆}  pt.X:=  trunc(p0.x+X_Unit *49); pt.Y:=  trunc(p0.y-Y_Unit*1.5);
                 tempN.DrawCircle(pt,Y_Unit,270,360);
      { 连接点1}  pt.x:= p0.x+trunc(X_Unit *49);  pt.Y:=  trunc(p0.y-Y_Unit*4);
                 tempN.AddPointNode(Pt)  ;
      { 连接点2}  pt.x:= p0.x+trunc(X_Unit *48);  pt.Y:=  trunc(p0.y-Y_Unit*5);
                 tempN.AddPointNode(Pt)  ;
      { 做第一处多半圆}  pt.X:=  trunc(p0.x+X_Unit *43+Y_Unit*3); pt.Y:=  trunc(p0.y-Y_Unit*9);
                 tempN.DrawCircle(pt,Y_Unit*4,270,225);

      { 连接点}  pt.x:= p0.x+trunc(X_Unit *43);  pt.Y:=  trunc(p0.y-Y_Unit*5);
                 tempN.AddPointNode(Pt)  ;
//
//
      // 添加链接的销子
         pt.X:=  trunc(p0.x+X_Unit *49); pt.Y:=  trunc(p0.y-Y_Unit*1);
            tempN.AddMarkLabel(pt,trunc(Y_Unit*0.5),False,False,False);



       tempN.DrawAndFill(true,1,Rec.Zj_body_fillColor);

end;

function TDrawNode.Draw_ZC_Zj(Rec:TDrawZjRecord): Boolean;
 {
   绘制综采液压支架
   SuoB 代表 支架被压缩的 高度数值  即 几个 Y_Unit  该数值 最大为 20
 }
begin
   {0-0 清理类 }
   ClearAll;
   {初始化数据记录类}
   Cal_Draw_RecInformation(Rec);
   {绘制护帮板 级互帮}
   Draw_DL_HuBang(Rec);
   {绘制护帮千斤顶}
   Draw_Dl_First_Hb_Qjd(Rec);
   {绘制平衡千斤顶}
   Draw_balance_Qjd(Rec);
    {绘制背板立柱}
   Draw_BeiBan_Lizhu(Rec);
    {绘制支架的背板}
   Draw_beiban(Rec);
    {绘制液压支架的立柱}
   Draw_Lizhu(Rec);

   {绘制液压支架的顶梁}
   Draw_DL_Main(Rec);
   { 底座尾梁组件}
   Draw_Zc_Dz_First(Rec);
   {底座的其他组件}
   Draw_Zc_Dz(Rec);
   {液压支架标尺的标注}
   Draw_Reluer(Rec);
   {5-5 绘制销子 }
   Draw_Xc(Rec,ClBlack);
end;

function TDrawNode.FromTwoPointCalMidPoint(jieCount:integer;pt1, pt2: TPoint;
  Suoliang: integer): TPoint;
  {
     jieCount 代表返回的是第几节

    根据两个 坐标点 以及 缩量的位置 计算 中间立柱缩量的位置
    立柱 第一级的高度不超过 18
    立柱第二级 最小高度 不低于18.5
    立柱第三级 最高一级的高度不低于 19
    最高点 开始于 3个数据单位
    目前的数据单位为 3+ Suoliang div 5
    中间点确定原则：
    如果  Suoliang =0  中间点在 最大高度我 28.5（从底梁开始计算）
    如果 suoliang =100 中间点在 最小高度我 18.5（从底梁开始计算）
    即
         中间立柱的 高度为 18.5 + 0.5（suoliang div 5)
  }
var
  jd,jl,ht:double;
  sul:integer ;
  pt:TPoint;
begin
      jd:=GetAngleFromTwoPoint(pt1,pt2);
      jl:=GetLengthFromTwoPoint(pt1,pt2);
      sul:= Suoliang  div 5;
      ht:=29-0.5*sul;
      if jieCount=1 then   begin //如果是第一级
         pt.X :=pt2.X + trunc(Y_Unit*18*Cos(ChangeJdToHu(180+jd)));
         pt.Y :=pt2.Y - trunc(Y_Unit*18*sin(ChangeJdToHu(180+jd)));
      end else  if jieCount=2 then   begin   //如果是第二级
          pt.X :=pt2.X + trunc(Y_Unit*ht*Cos(ChangeJdToHu(180+jd)));
          pt.Y :=pt2.Y - trunc(Y_Unit*ht*sin(ChangeJdToHu(180+jd)));
      end else if jieCount=15 then begin // 平衡千斤顶的节点
          pt.X :=pt2.X + trunc(jl*2/3*Cos(ChangeJdToHu(180+jd)));
          pt.Y :=pt2.Y - trunc(jl*2/3*sin(ChangeJdToHu(180+jd)));
      end;

      Result:=Pt;
end;

function TDrawNode.GetAngleFromTwoPoint(pt1, pt2: TPoint): Double;
var
  tm:Double;
begin
    tm:=(pt2.y-pt1.Y)/(pt2.X-Pt1.X);
    Result:=  -1* ArcTan(tm)/3.1415962*180 ;

end;

function TDrawNode.GetCanvas: TCanvas;
begin
  Result:=FCanvas;
end;

function TDrawNode.GetCaption: string;
begin
    Result:=FCaption;
end;

function TDrawNode.GetChlidCount: integer;
begin
   Result:=FChildCount;
end;

function TDrawNode.GetEndPoint: TPoint;
begin
   Result:=FEndPoint;
end;

function TDrawNode.GetLengthFromTwoPoint(pt1, pt2: TPoint): Double;
var
  tm:Double;
begin
    tm:=sqrt(sqr(pt2.y-pt1.Y)+sqr(pt2.X-Pt1.X));
    Result:=tm;

end;

function TDrawNode.GetPointCount: integer;
begin
   Result:=FPointCount;
end;


function TDrawNode.GetStartPoint: TPoint;
begin
   Result:=FStartPoint;
end;

function TDrawNode.GetXUnit: double;
begin
  Result:=F_X_Unit;
end;

function TDrawNode.GetYUnit: double;
begin
  Result:=F_Y_Unit;
end;

function TDrawNode.ReturnSuoLiang(Use_H: double): double;
var
  Tmp_H:double;
  zj_d_s:double;
  tmp_used_suo_Unit:double;
begin
   tmp_used_suo_Unit:= 50/ZJ_Disgn_max_H *(ZJ_Disgn_max_H-Zj_Disgn_Min_H) ;// 该立柱一共需要缩多少个单元
   if tmp_used_suo_Unit >20 then tmp_used_suo_Unit:=20;
   zj_d_s:=ZJ_Disgn_max_H-Zj_Disgn_Min_H;
   Tmp_H:=trunc(tmp_used_suo_Unit/zj_d_s*(ZJ_Disgn_max_H-Use_H));
   Result:=Tmp_H;

end;

procedure TDrawNode.SetCanvas(Value: TCanvas);
begin
   FCanvas:=Value;
end;

procedure TDrawNode.SetCaption(Value: String);
begin
   FCaption:=Value;
end;

procedure TDrawNode.SetEndPoint(Value: TPoint);
begin
   FEndPoint:=Value;
end;




procedure TDrawNode.SetStartPoint(Value: TPoint);
begin
   FStartPoint:=Value;
end;

procedure TDrawNode.SetXUnit(Value: double);
begin
   F_X_Unit:=Value;
end;

procedure TDrawNode.SetYUnit(Value: double);
begin
   F_Y_Unit:=Value;
end;

procedure TDrawNode.TipTimeOnTime(Sender: TObject);
begin
   if TipCount>=10 then begin
      TipMemo.Visible :=False;
      TipTimer.Enabled :=False;
      TipCount:=0;
   end;
   inc(TipCount);
end;

{ TLinkMark }

constructor TLinkMark.Create;
begin

end;

destructor TLinkMark.Destroy;
begin

end;

procedure TLinkMark.DrawMark(Disp:Boolean; FillColor:TColor);
{
  Disp true 意思是 有条件的打印   False  无条件打印
  系统统一打印是 有条件打印

}
var
  tempColor:TColor;
  PenWid:integer;
  pt:TPoint;
  Pi:Double;
begin
      if Disp then  begin
         if DoubleDispLay  then     exit;
      end;
      tempColor:= FCanvas.Pen.Color;
      FCanvas.Pen.Color:= FillColor;
      PenWid:=FCanvas.Pen.Width ;
      Pi:=3.1415926;
      FCanvas.Pen.Width:=1;
      if FDoubleCycle then  begin
         FCanvas.Ellipse(FCPt.X -trunc(Rad*1.5),FCPt.Y-trunc(Rad*1.5),
                      FCPt.X +trunc(Rad*1.5),FCPt.Y+trunc(Rad*1.5));
      end;
      FCanvas.Pen.Width:=2;
      FCanvas.Ellipse(FCPt.X -Rad,FCPt.Y-Rad,FCPt.X +Rad,FCPt.Y+Rad);
      FCanvas.Pen.Width:=1;
      // 上测
      if FLineCenter then  begin
          pt.X := FCPt.X +trunc(Rad*1.5* Cos(135/180*Pi)) ;
          pt.Y := FCPt.Y -trunc(Rad*1.5* Sin(135/180*Pi)) ;
             FCanvas.MoveTo(pt.x,pt.Y ) ;
          pt.X := pt.x +trunc(Rad/2* Cos(45/180*Pi));
          pt.Y := pt.y -trunc(Rad/2* Sin(45/180*Pi)) ;
             FCanvas.LineTo(pt.x,pt.Y ) ;
          pt.X := pt.x + trunc(Rad/2* Cos(135/180*Pi));
          pt.Y := pt.y - trunc(Rad/2 * Sin(135/180*Pi)) ;
             FCanvas.LineTo(pt.x, pt.Y ) ;
          pt.X := pt.x +trunc(Rad  * Cos(225/180*Pi));
          pt.Y := pt.y -trunc(Rad * Sin(225/180*Pi)) ;
             FCanvas.LineTo(pt.x, pt.Y ) ;
          pt.X := FCPt.X +trunc(Rad*1.5* Cos(135/180*Pi))  + trunc(Rad/2* cos(225/180*Pi) ) ;
          pt.Y := FCPt.Y - trunc(Rad*1.5* Sin(135/180*Pi))  - trunc(Rad/2* Sin(225/180*Pi) ) ;
             FCanvas.LineTo(pt.x, pt.Y ) ;
          pt.X := FCPt.X +trunc(Rad*1.5* Cos(135/180*Pi)) ;
          pt.Y := FCPt.Y -trunc(Rad*1.5* Sin(135/180*Pi)) ;
             FCanvas.LineTo(pt.x, pt.Y ) ;

          pt.X := FCPt.X +trunc(Rad*1.5* Cos(315/180*Pi)) ;
          pt.Y := FCPt.Y -trunc(Rad*1.5* Sin(315/180*Pi)) ;
             FCanvas.MoveTo(pt.x,pt.Y ) ;
          pt.X := pt.x +trunc(Rad/2* Cos(45/180*Pi));
          pt.Y := pt.y -trunc(Rad/2* Sin(45/180*Pi)) ;
             FCanvas.LineTo(pt.x,pt.Y ) ;
          pt.X := pt.x + trunc(Rad/2* Cos(315/180*Pi));
          pt.Y := pt.y - trunc(Rad/2 * Sin(315/180*Pi)) ;
             FCanvas.LineTo(pt.x, pt.Y ) ;
          pt.X := pt.x +trunc(Rad  * Cos(225/180*Pi));
          pt.Y := pt.y -trunc(Rad * Sin(225/180*Pi)) ;
             FCanvas.LineTo(pt.x, pt.Y ) ;
          pt.X := FCPt.X +trunc(Rad*1.5* Cos(315/180*Pi))  + trunc(Rad/2* cos(225/180*Pi) ) ;
          pt.Y := FCPt.Y - trunc(Rad*1.5* Sin(315/180*Pi))  - trunc(Rad/2* Sin(225/180*Pi) ) ;
             FCanvas.LineTo(pt.x, pt.Y ) ;
          pt.X := FCPt.X +trunc(Rad*1.5* Cos(315/180*Pi)) ;
          pt.Y := FCPt.Y -trunc(Rad*1.5* Sin(315/180*Pi)) ;
             FCanvas.LineTo(pt.x, pt.Y ) ;
          // 中心线
          pt.X := FCPt.X +trunc(Rad* Cos(120/180*Pi)) ;;
          pt.Y := FCPt.Y -trunc(Rad* Sin(120/180*Pi)) ;
             FCanvas.MoveTo(pt.x,pt.Y ) ;
          pt.X := FCPt.X +trunc(Rad* Cos(330/180*Pi)) ;
          pt.Y := FCPt.Y -trunc(Rad* Sin(330/180*Pi)) ;
             FCanvas.LineTo(pt.x,pt.Y ) ;
          pt.X := FCPt.X +trunc(Rad* Cos(150/180*Pi)) ;
          pt.Y := FCPt.Y -trunc(Rad* Sin(150/180*Pi)) ;
             FCanvas.MoveTo(pt.x,pt.Y ) ;
          pt.X := FCPt.X +trunc(Rad* Cos(300/180*Pi)) ;
          pt.Y := FCPt.Y -trunc(Rad* Sin(300/180*Pi)) ;
          FCanvas.LineTo(pt.x,pt.Y ) ;
      end;


      FCanvas.Pen.Color:= tempColor;
      FCanvas.Pen.Width:=PenWid;
end;

function TLinkMark.GetCanvas: TCanvas;
begin
   REsult:=FCanvas;
end;

function TLinkMark.GetCentPt: TPoint;
begin
    Result:=FCPt;
end;

function TLinkMark.GetRadio: Integer;
begin
    REsult:=FRad;
end;

procedure TLinkMark.SetCanvas(Value: TCanvas);
begin
   FCanvas:=Value;
end;

procedure TLinkMark.SetCentPt(Value: TPoint);
begin
   FCPt:=Value;
end;

procedure TLinkMark.SetRadio(Value: Integer);
begin
  FRad:=Value;
end;

{ TLabelMark }

procedure TLabelMark.BaseTWoPointDrawRockPress(pt1, pt2: TPoint);
{
       绘制大的压力箭头    箭头标号    ptx[i]
                            4---3
                            |   |
                            |   |
                            |   |
                       6--- 5   2---1
                        |          |
                          |       |
                            |   |
                              0
}


var
  Qjd_L,Qjd_Jd:double;
  Pt:TPoint;
  ptx: array [0..6] of TPoint;
  Arrow_L_Unit:double;

begin

      Qjd_Jd:=GetAngleFromTwoPoint(pt1,pt2);
      Qjd_L:=GetLengthFromTwoPoint(pt1,pt2);
      Arrow_L_Unit:= Qjd_L/9;
      MotherCanvas.Pen.Width :=LineWidth;
      MotherCanvas.Pen.Color :=FLineColor;
         ptx[0]:=pt2;
         ptx[1].x:= pt2.x+trunc(Arrow_L_Unit*3*1.414*Cos(ChangeJdToHu(180+Qjd_Jd-45)));
                ptx[1].Y:=pt2.Y -trunc(Arrow_L_Unit*3*1.414*sin (ChangeJdToHu(180+Qjd_Jd-45)));
         ptx[2].x:= ptx[1].x+trunc(Arrow_L_Unit*1.5*Cos(ChangeJdToHu(270+Qjd_Jd)));
                ptx[2].Y:=ptx[1].Y -trunc(Arrow_L_Unit*1.5*sin (ChangeJdToHu(270+Qjd_Jd)));
         ptx[3].x:= ptx[2].x+trunc(Arrow_L_Unit*4*Cos(ChangeJdToHu(180+Qjd_Jd)));
                ptx[3].Y:=ptx[2].Y -trunc(Arrow_L_Unit*4*sin (ChangeJdToHu(180+Qjd_Jd)));
         ptx[4].x:= ptx[3].x+trunc(Arrow_L_Unit*3*Cos(ChangeJdToHu(270+Qjd_Jd)));
                ptx[4].Y:=ptx[3].Y -trunc(Arrow_L_Unit*3*sin (ChangeJdToHu(270+Qjd_Jd)));

         ptx[6].x:= pt2.x+trunc(Arrow_L_Unit*3*1.414*Cos(ChangeJdToHu(180+Qjd_Jd+45)));
                ptx[6].Y:=pt2.Y -trunc(Arrow_L_Unit*3*1.414*sin (ChangeJdToHu(180+Qjd_Jd+45)));
         ptx[5].x:= ptx[6].x+trunc(Arrow_L_Unit*1.5*Cos(ChangeJdToHu(90+Qjd_Jd)));
                ptx[5].Y:=ptx[6].Y -trunc(Arrow_L_Unit*1.5*sin (ChangeJdToHu(90+Qjd_Jd)));

         MotherCanvas.Brush.Color:=LineColor;
         MotherCanvas.Polygon(ptx);


        pt.x:= pt1.x+trunc(length(FTitlle)*5*Cos(ChangeJdToHu(270+Qjd_Jd)));
                pt.Y:=pt1.Y -trunc(length(FTitlle)*5 *sin (ChangeJdToHu(270+Qjd_Jd)));
         public_Basic.CanvasRotatedText(MotherCanvas,
                            pt.x,pt.y,
                            '宋体',
                            10,
                            round(Qjd_Jd+90),
                            LineColor,
                            FTitlle
                            );

end;

procedure TLabelMark.BaseTWoPointDrawRuler(pt1, pt2: TPoint);
{
   液压支架一般标注
   |                       |
   |-----------------------|
   |                       |


}
var
  Qjd_L,Qjd_Jd:double;
  Pt,pt_3:TPoint;
  LineStyle:TPenStyle;
begin

      Qjd_Jd:=GetAngleFromTwoPoint(pt1,pt2);
      Qjd_L:=GetLengthFromTwoPoint(pt1,pt2);

   //   if Qjd_Jd< 0  then      Qjd_Jd:=-1*Qjd_Jd;
      MotherCanvas.Pen.Width :=LineWidth;
      MotherCanvas.Pen.Color :=FLineColor;
      if FArrowVisible then  begin

     { 开始点的箭头左侧}    Pt.x:= pt1.x+trunc(10*Cos(ChangeJdToHu(Qjd_Jd+45)));
                     pt.Y:=pt1.Y -trunc(10*sin (ChangeJdToHu(Qjd_Jd+45)));
                  MotherCanvas.MoveTo(pt1.x,pt1.y);
                  MotherCanvas.LineTo(pt.x,pt.y);
     { 开始点的箭头右侧}    Pt.x:= pt1.x+trunc(10*Cos(ChangeJdToHu(Qjd_Jd-45)));
                     pt.Y:=pt1.Y -trunc(10*sin (ChangeJdToHu(Qjd_Jd-45)));
                  MotherCanvas.MoveTo(pt1.x,pt1.y);
                  MotherCanvas.LineTo(pt.x,pt.y);

     { 结束点的箭头左侧}    Pt.x:= pt2.x+trunc(10*Cos(ChangeJdToHu(180+Qjd_Jd+45)));
                     pt.Y:=pt2.Y -trunc(10*sin (ChangeJdToHu(180+Qjd_Jd+45)));
                  MotherCanvas.MoveTo(pt2.x,pt2.y);
                  MotherCanvas.LineTo(pt.x,pt.y);
     { 结束点的箭头右侧}    Pt.x:= pt2.x+trunc(10*Cos(ChangeJdToHu(180+Qjd_Jd-45)));
                     pt.Y:=pt2.Y -trunc(10*sin (ChangeJdToHu(180+Qjd_Jd-45)));
                  MotherCanvas.MoveTo(pt2.x,pt2.y);
                  MotherCanvas.LineTo(pt.x,pt.y);
       {主体标尺线}
                 MotherCanvas.MoveTo(pt1.x,pt1.y);
                 MotherCanvas.LineTo(pt2.x,pt2.y);
      end else begin
          {主体标尺线}
                 LineStyle:=MotherCanvas.Pen.Style;
                 MotherCanvas.Pen.Style:=psDash;
                 MotherCanvas.MoveTo(pt1.x,pt1.y);
                 MotherCanvas.LineTo(pt2.x,pt2.y);
                 MotherCanvas.Pen.Style:= LineStyle;
      end;

   
     {打印title       }
      if Trim(FTitlle) <> '' then  begin
             Pt.x:=pt1.x+trunc((Qjd_L/2-length(FTitlle)*5)*Cos(ChangeJdToHu(Qjd_Jd)));
                     pt.Y:=pt1.Y -trunc((Qjd_L/2-length(FTitlle)*5)*sin (ChangeJdToHu(Qjd_Jd)));

             public_Basic.CanvasRotatedText(MotherCanvas,
                                    pt.x,pt.y,
                                    '宋体',
                                    10,
                                    round(Qjd_Jd),
                                    LineColor,
                                    FTitlle
                                    );
      end;
end;

function TLabelMark.ChangeJdToHu(JiaoDu: Double): Double;
begin
   Result:=JiaoDu /180 *3.1415926;
end;

constructor TLabelMark.Create;
begin

end;

destructor TLabelMark.Destroy;
begin

end;

procedure TLabelMark.DrawMark(Disp: Boolean; FillColor: TColor);
{
  Disp true 意思是 有条件的打印   False  无条件打印
  系统统一打印是 有条件打印

}
var
  tempColor:TColor;
  PenWid:integer;
  pt:TPoint;
  Pi:Double;
begin
      if Disp then  begin
         if Visible  then     exit;
      end;
      tempColor:= FCanvas.Pen.Color;
      FCanvas.Pen.Color:= LineColor;
      PenWid:=FCanvas.Pen.Width ;
      if FlabelState=1 then  begin  // 一般的尺度 标尺
           BaseTWoPointDrawRuler(FStPoint,FEndPoint);
      end else if FlabelState=2 then  begin  // 液压支架的压力标尺
           BaseTWoPointDrawRockPress(FStPoint,FEndPoint);
      end;


      FCanvas.Pen.Color:= tempColor;
      FCanvas.Pen.Width:=PenWid;

end;

function TLabelMark.GetAngleFromTwoPoint(pt1, pt2: TPoint): Double;
var
  tm:Double;
begin
    tm:=(pt2.y-pt1.Y)/(pt2.X-Pt1.X);
    Result:=  -1* ArcTan(tm)/3.1415962*180 ;

end;

function TLabelMark.GetCanvas: TCanvas;
begin
   Result:=FCanvas;
end;

function TLabelMark.GetLengthFromTwoPoint(pt1, pt2: TPoint): Double;
var
  tm:Double;
begin
    tm:=sqrt(sqr(pt2.y-pt1.Y)+sqr(pt2.X-Pt1.X));
    Result:=tm;


end;

function TLabelMark.GetLineColor: TColor;
begin
    Result:=FLineColor;
end;

function TLabelMark.GetLineWidth: Integer;
begin
   Result:=FLineWidth;
end;

function TLabelMark.GetVisible: Boolean;
begin
   Result:=FVisible;
end;

procedure TLabelMark.SetCanvas(Value: TCanvas);
begin
  FCanvas:=Value;
end;

procedure TLabelMark.SetLineColor(Value: TColor);
begin
   FLineColor:=Value;
end;

procedure TLabelMark.SetLineWidth(Value: integer);
begin
  FLineWidth:=Value;
end;

procedure TLabelMark.SetVisible(Value: Boolean);
begin
   FVisible:=Value;
end;

end.
