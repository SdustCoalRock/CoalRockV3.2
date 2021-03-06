unit RockPressReport;

interface
uses
  Winapi.Windows,System.SysUtils,Vcl.ExtCtrls,unWord_Lu,PStope_GzmGuidClass ,
  uDrawGraphClass,Word2000, Vcl.ComCtrls,System.Classes,Vcl.Forms,
  UICallPstope, UMakeRuleClass;

type
    TWordReport = class(TMyWord)

    private
        ExHandle:THandle;
        iDwGrap:TDrawGrap;
        iCallPStope:TDefine_CallPStope; // 采矿算法类
        innWord:TMyWord;
        SencentId:integer;
        ReportInputData:TDataFrequency;
        Second_Tab_id,third_Tab_id,Fhird_Tu_id:integer;
        fuLu_Tu_id:integer;
        Yu_Start_id,Yu_End_id:integer;//云图开始与结束编号
        ForCaseTuid:integer;// 预测图编号
        PinPutuid,TongjiTuid :integer;//整体频谱图编号 统计图 编号
        Subject_Str:TStringList; //建议字符串
        ForceExit:Boolean;
        MainPanel:TPanel; // WordPanel
        function  Get_Cmff(id:integer):String;         //采煤方法
        function  Get_Coal_F(id:integer):String;       //煤体应力
        function  Get_JYHD(id:integer):String;           //基岩厚度
        function  Get_HangDao_Stress(id:integer):String; //巷道压力
        function  Get_HangDao_support(id:integer):String; //巷道支护方式
        function  Get_support_type(id:integer):String; //支架型号
        function  Get_DZGZ(id:integer):String;  //地质构造
        function  Get_WSFC(id:integer):String;  //瓦斯含量
        function  Get_TopWater(id:integer):String;  //顶板水源
        function  Get_BottomWater(id:integer):String;  //地板水源
        function  Get_RockPress(id:integer):String;  //矿压情况
        function  Get_YxFx(id:integer):String;  //仰斜与俯斜
        // main Myword
        Procedure CreateWordClass();
        procedure FreeMyWordClass();
        procedure AddDocmentTitle(CoalName,WorkFaceName,ReportType:String);
        procedure ADDWorkFaceInFo_1(inGzm:TGzm);
        procedure ADDDrilleInFo_2(inGzm:TGzm);
        procedure AddFYYDInfo_3(inGzm:TGzm;ReportType:String);
        procedure AddYDFZInfo_4(inGzm:TGzm);
        procedure AddSupportInfo_5(inGzm:TGzm);
        procedure AddSupSubject_6(inGzm:TGzm);

        //------------------
        procedure AddYklhInfo_5(inGzm:TGzm);
        procedure AddYklhInfo_5_2;

        procedure Add_disclaimer(Xhstr:String);

       //
        procedure DeleteBmPFile;
        function  isExsitBmpFile(BmpFile:string):Boolean;
        function  Report_Zcyl(inGzm:TGzm):Boolean;
        //report 矿压分析
        procedure Add_Kyfx_Cover(CoalName, WorkFaceName:String);    // 制作报告封面
        procedure Add_WorkFace_BasicInformation(inGzm:TGZM);
        procedure ADD_Abstric; // 摘要
        procedure ADD_Fuhaoshuming;// 符号说明
        procedure Add_FYYD_2(inGzm:TGZM);
        // 第三章
        procedure Add_Second_Secents(inGZm:TGzm);
        procedure Add_Second_QianYan;
        procedure Add_Second_First_main(P_Str:string;inGZm:TGzm);// 3.1 数据分析综述
        procedure Add_Second_First(P_Str:string;inGZm:TGzm);// 3.1  主要分析参数
        procedure Add_Second_Two_Table_1(P_Str:string;inGZm:TGzm;phaseNumber:integer);// 3.2.*   技术参数统计分析表
        function  Add_Second_Two_Table_fulu_Bmp(PhaseNumber:Integer):string;// 给附录增加 图形
        procedure Add_Second_Two_Table_2(P_Str:string;inGZm:TGzm;phaseNumber:integer); //3.2.*   统计结果分析
        procedure Add_Second_Two_Jielun(P_Str:string;inGZm:TGzm);// 3.3 结论
        // 第四章
        procedure Add_Third_Secents(inGZm:TGzm);
        procedure Add_Third_QianYan; // 介绍三维曲面分析方法




        procedure Add_Third_one_Main(P_Str:string;inGZm:TGzm);// 3.2 主控程序
        procedure Add_Third_one_First(P_Str:string;inGZm:TGzm);// 3.2.1  分析的主要数据
        Procedure ADd_Third_one_First_Table(P_Str:string;Modify:integer);// 添加表格
        procedure Add_Third_one_First_Table_Chlid(phaseNumber:integer;OneStepIn: TcomprehensiveOldStep;
           sup_st,sup_ed:integer;itab:Table; var come_i,iRow:integer);// 为添加表格服务

        procedure Add_Third_two_Main(P_Str:string;inGZm:TGzm);// 3.3  分阶段来压信息 通报
        procedure Add_Third_two_one(phaseNumber,P_c,modify:integer;P_Str:string;inGZm:TGzm);// 3.3  分区域来压信息 通报
        function  Add_Third_two_Main_Chlid_Add_fulu_Bmp(PhaseNumber:Integer):string;// 给附录增加 图形

        procedure Add_fourth_Secents(inGZm:TGzm);// 第五章整体结论
        procedure Add_fourth_QianYan; // 结论的前言
        procedure Add_fourth_one(P_Str:string;inGZm:TGzm);// 5.1 结论
        procedure Add_fourth_two(P_Str:string;inGZm:TGzm);// 5.2 结论
        procedure Add_fourth_three(P_Str:string;inGZm:TGzm);// 5.3 结论
        procedure Add_Fourth_Four(P_Str:string;inGZm:TGzm);//5.4 预测


        procedure ProDisposeFiveDataType;
        procedure Add_Fulu_TuFirstToFive;//把 附录前面的四张图给添加了。
        function  ReturnDataTypeName(Value:integer):String;

        // 辅助函数
        procedure Add_Support_Information(inGzm:TGzm);
        function  ReturnTimeToChinese(dt:TdateTime):String;

        procedure Add_Contents;// 制作目录
        procedure ADD_Fulu;//制作附录
        procedure ADd_HouJi;//制作后记
        procedure Add_FuLuTu(tuOrTable,id :integer;title,Memo,FileName:string);
        function  ReturnFileName(FileType:String;L_Min,L_Max:integer;DataType,lx:integer):String;
        procedure InsertPageSetupWater(Path:string);
        procedure ChangePictureWidth(Path:string) ;


    public

        procedure ReportZhijia(AHandle:THandle;inGzm:TGzm); //打印支架报告
        procedure ReportYklh(AHandle:THandle;inGzm:TGzm);//  打印沿空留巷
        //
        procedure SetDrawGraph(iDw:TDrawGrap;iCallP:TDefine_CallPStope);

        function ReportAnsysisRockPress(AHandle:THandle;inGzm:TGZM;ExWord:Boolean):Boolean;
        procedure SetReportExit(Value:Boolean);
        procedure SetWordPanel(iPanel:TPanel);
        procedure ReSize;
        procedure KillWord;

        constructor Create;
        destructor  Destroy;

    end;


implementation

{ TWordReport }

uses UMainDataModule, Lu_Public_BasicModual,IOUtils, UForm_ContourGraph,
  UForm_Brand_Bar, UForm_LineGraph, RockPresstool,math,TypInfo,
  UForm_phaseGraph_Tongji;
Procedure CreateWordClass(MyUseWord:TMyWord);
begin

end;

procedure TWordReport.AddDocmentTitle(CoalName, WorkFaceName,ReportType: String );
var
  title:String;
  i:integer;
begin
    with innWord do begin
         if ReportType='Support' then  begin
            title:=CoalName+'【'+WorkFaceName+'】液压支架选型报告';
         end else if ReportType='Yklh' then begin
            title:=CoalName+'【'+WorkFaceName+'】沿空留巷技术报告';
         end;

         SetFont('楷体_GB2312',18,false,false);
         AlignLine(1);  //居中
         SetHeading(title,1); //报告标题

    end;
end;

procedure TWordReport.ADDDrilleInFo_2( inGzm: TGzm);
var
  str:string;
  i:integer;
  tab:Table;
begin

    with innWord do begin
           //正文
        if inGzm.UsedDrill.Zk_Yc_Count> 0 then begin
            SetFont('宋体',12,false,false);
            AlignLine(0);
            WriteText('    该次测算使用的钻孔名称为：'+inGzm.UsedDrill.Zk_name +
                      '，该钻孔录入岩层：'+IntToStr(inGzm.UsedDrill.Zk_Yc_Count)+'层。'+#13,1);

            AlignLine(1);
            SetFont('宋体',11,true,false);
            SetHeading('表1-2【'+inGzm.UsedDrill.Zk_name+'】钻孔岩层信息表',4);
            SetFont('宋体',11,false,false);
            tab:=AddTable(6,1);
            SetFont('宋体',11,true,false);
            InsertRow(tab,1,1);  AlignLine(1);
            WriteText('岩层序号',0);   MoveRight(1);   SetFont('宋体',11,true,false);   AlignLine(1);
            WriteText('岩层名称',0);   MoveRight(1);   SetFont('宋体',11,true,false);   AlignLine(1);
            WriteText('均厚(米)',0);   MoveRight(1);   SetFont('宋体',11,true,false);   AlignLine(1);
            WriteText('岩石容重',0);   MoveRight(1);   SetFont('宋体',11,true,false);   AlignLine(1);
            WriteText('抗压MPa',0);    MoveRight(1);   SetFont('宋体',11,true,false);   AlignLine(1);
            WriteText('抗拉MPa',0);
            SetFont('宋体',11,False,false);
            for I := 0 to inGzm.UsedDrill.Zk_Yc_Count-1 do   begin
                InsertRow(tab,1,1);    MoveRight(1); AlignLine(1);
                WriteText(inttoStr(i+1),0);                      AlignLine(1);  MoveRight(1);
                WriteText(inGzm.UsedDrill.Yc_Rock[i].R_Name,0);   AlignLine(1);  MoveRight(1);
                WriteText(FormatFloat('#.##',inGzm.UsedDrill.Yc_Rock[i].R_h),0);   AlignLine(1);    MoveRight(1);
                WriteText(FormatFloat('#.##',inGzm.UsedDrill.Yc_Rock[i].R_r),0);   AlignLine(1);    MoveRight(1);
                WriteText(FormatFloat('#.##',inGzm.UsedDrill.Yc_Rock[i].R_kyqd),0);   AlignLine(1); MoveRight(1);
                WriteText(FormatFloat('#.##',inGzm.UsedDrill.Yc_Rock[i].R_klqd),0);   AlignLine(1);
            end;

            MoveDown(1); MoveDown(1); //跳出表格

        end;

     end;

end;


procedure TWordReport.AddFYYDInfo_3(inGzm: TGzm;ReportType:String);
var
  Pic_Path:Ansistring;
begin
    Pic_Path:=Public_Basic.Get_MyModulePath+'saveBmp\FYYD\';
    with innWord do begin
          AlignLine(0);
          AddReturn();   //加一个空行
          SetFont('宋体',15,false,false);
          SetHeading('三、覆岩运动规律',2);// 章节
          AddReturn();
           //正文
          SetFont('黑体',13,false,false);
          SetHeading('1、三种算法',3);
          AddReturn();
          AlignLine(1);
          SetFont('宋体',10,true,false);
          AddTable(1,6);
          if self.isExsitBmpFile(Pic_Path+'NQF.JPG') then
             AddPicture(Pic_Path+'NQF.JPG',1);
          MoveRight(1);
          WriteText('图3.1 覆岩运动规律挠曲算法图示',0);
          MoveRight(1);
          if self.isExsitBmpFile(Pic_Path+'BJF.JPG') then
             AddPicture(Pic_Path+'BJF.JPG',1);
          MoveRight(1);
          WriteText('图3.2 覆岩运动规律步距算法图示',0);
          MoveRight(1);
           if self.isExsitBmpFile(Pic_Path+'ZHSF.JPG') then
             AddPicture(Pic_Path+'ZHSF.JPG',1);
          MoveRight(1);
          WriteText('图3.3 覆岩运动规律综合算法图示',0);
          MoveDown(1);

          AddReturn();

          AlignLine(0);

          SetFont('黑体',13,false,false);
          SetHeading('2、覆岩运动规律',3);
          AddReturn();
          SetFont('宋体',13,false,false);
//          WriteText('   直接顶运动参数：'+StrPas(Main_CallPStope.UsePStope.Get_immediate_roof('1.0')));
//          AddReturn();
//          WriteText('   老顶运动参数：'+StrPas(Main_CallPStope.UsePStope.Get_Old_roof('1.0')));
          AddReturn();
          {为沿空留巷定制}
          if ReportType='Yklh' then begin
              SetFont('黑体',13,false,false);
              SetHeading('3、支承压力分布规律',3);
              AddReturn();
              SetFont('宋体',13,false,false);
              Report_Zcyl(inGzm);
          end;
    end;
end;

procedure TWordReport.AddSupportInfo_5(inGzm: TGzm);
var
  i,selectedid:integer;
  Image1:TImage;
  Pic_Path,DispStr:string;
begin
   Image1 := TImage.Create(nil);

   try
    with innWord do begin
          AlignLine(0);
          AddReturn();   //加一个空行
          SetFont('宋体',15,false,false);
          SetHeading('五、支架选型',2);// 章节
          AddReturn();
           //正文
          SetFont('黑体',13,false,false);
          SetHeading('1、开采条件影响值',3);
          AddReturn();
          AlignLine(1);
          SetFont('宋体',10,true,false);
          AddTable(8,2);
          WriteText('直接顶类别',0);MoveRight(1);
          WriteText('基本顶类别',0);MoveRight(1);
          WriteText('底板类别',0);MoveRight(1);
          WriteText('工作阻力/KN',0);MoveRight(1);
          WriteText('采高/m',0);MoveRight(1);
          WriteText('矿井瓦斯',0);MoveRight(1);
          WriteText('冒放性类别',0);MoveRight(1);
          WriteText('煤层倾角',0);MoveRight(1);
          for I := 0 to 7 do  begin

          end;

          MoveDown(1);

          AddReturn();

          AlignLine(0);
          SetFont('黑体',13,false,false);
          SetHeading('2、注意事项',3);
          AddReturn();
          SetFont('宋体',13,false,false);
          WriteText('液压支架阻力计算建议值：',0);
          AddReturn();

          MoveDown(1);

    end;
   finally
      Image1.Free;
   end;
end;

procedure TWordReport.AddSupSubject_6(inGzm: TGzm);
begin
end;

procedure TWordReport.ADDWorkFaceInFo_1(inGzm: TGzm);
var
  str:string;
begin
  with innWord do begin
      AlignLine(0);
      AddReturn();   //加一个空行
        //正文
      SetFont('宋体',13,false,false);
      str:='  模拟开采工作面名称为【'+inGzm.S_Name+'】煤层平均厚度为' +
                  FormatFloat('#.##',inGzm.S_Agv_mch) +'米, 设定开采高度为' +
                  FormatFloat('#.##',inGzm.S_Cg_h)+'米, 采煤方法是' +
                  Get_Cmff(inGzm.S_CMFS_INteger)+ ',工作面上界采深是'+FormatFloat('#.##',inGzm.S_Sh_UP)+
                  '米,下界采深是'+FormatFloat('#.##',inGzm.S_Sh_Down)+'米，平均采深是'   +
                  FormatFloat('#.##',inGzm.S_mcsd_h)+'米';
      WriteText(str,0);
      AddReturn();
      str:='  该工作面推进长度是'+FormatFloat('#.##',inGzm.S_Sx_zx )+'米，'+
                '倾斜长度是'+FormatFloat('#.##',inGzm.S_L_qx)+'米，'   +
                '煤层硬度是'+Get_Coal_F(round(inGzm.S_f_PS))+',基岩厚度是'+Get_JYHd(inGzm.Dz_JYHD)+
                ',每天推进'+FormatFloat('#.##',inGzm.S_DayStep_speed)+'米左右。' ;

      WriteText(Str,0);
      AddReturn();

      Str:='  该次模拟计算使用的液压支架参数为:'+
                '中心距：'+ FormatFloat('#.##',inGzm.Usedsupport.Zj_zhongxinju) +  '米,'+
                '控顶距：'+ FormatFloat('#.##',inGzm.Usedsupport.Zj_KongdingJU) +  '米,'+
                '合力作用点：'+ FormatFloat('#.##',inGzm.Usedsupport.Zj_hlzyd)  +  '米,'+
                '立柱数量：'+ IntTostr(inGzm.Usedsupport.Zj_Lizhu_count) +  '个。';
      WriteText(Str,0);
      AddReturn();
  end;
end;

procedure TWordReport.AddYDFZInfo_4(inGzm: TGzm);
var
  Pic_Path:Ansistring;
begin
    Pic_Path:=Public_Basic.Get_MyModulePath+'saveBmp\FYYD\';
    with innWord do begin
          AlignLine(1);
          AddReturn();   //加一个空行
          SetFont('宋体',15,false,false);
          SetHeading('四、采场开采覆岩运动模拟',1);// 章节
          AddReturn();
           //正文
          AlignLine(1);
          SetFont('宋体',10,true,false);
          AddTable(1,12);
          if self.isExsitBmpFile(Pic_Path+'IMM0.JPG') then
             AddPicture(Pic_Path+'IMM0.JPG',1);
          MoveRight(1);
          WriteText('图4.1 开采模拟初始状态图',0);
          MoveRight(1);
          if self.isExsitBmpFile(Pic_Path+'IMM1.JPG') then
             AddPicture(Pic_Path+'IMM1.JPG',1);
          MoveRight(1);
          WriteText('图4.2 直接顶初次垮落示意图',0);
          MoveRight(1);
          if self.isExsitBmpFile(Pic_Path+'IMM2.JPG') then
             AddPicture(Pic_Path+'IMM2.JPG',1);
          MoveRight(1);
          WriteText('图4.3 顶板冒落形成示意图',0);
          MoveRight(1);
          if self.isExsitBmpFile(Pic_Path+'IMM3.JPG') then
             AddPicture(Pic_Path+'IMM3.JPG',1);
          MoveRight(1);
          WriteText('图4.4 老顶初次来压示意图',0);
          MoveRight(1);
          if self.isExsitBmpFile(Pic_Path+'IMM4.JPG') then
             AddPicture(Pic_Path+'IMM4.JPG',1);
          MoveRight(1);
          WriteText('图4.5 老顶周期来压示意图',0);
          MoveRight(1);
          if self.isExsitBmpFile(Pic_Path+'IMM5.JPG') then
             AddPicture(Pic_Path+'IMM5.JPG',1);
          MoveRight(1);
          WriteText('图4.6 采动见方顶板运动示意图',0);
          MoveDown(1);

    end;

end;

procedure TWordReport.AddYklhInfo_5(inGzm: TGzm);
var
  i,selectedid:integer;
   s_temp:Str_DT_array;
   C1:integer;
   S_out:Pansichar;
   Tab:Table;
   Str_S:array [0..7] of string;
begin
    S_out:= iCallPStope.Get_judge_KCJSTC;
    s_temp:=Public_Basic.split(StrPas(S_out),';',C1);
    Str_S[0]:= '直接顶类别';   Str_S[1]:= '基本顶类别'; Str_S[2]:= '底板类别';
    Str_S[3]:= '工作阻力/KN';   Str_S[4]:= '采高/m'; Str_S[5]:= '矿井瓦斯';
    Str_S[6]:= '冒放性类别';   Str_S[7]:= '煤层倾角';
   try
    with innWord do begin
          SetFont('宋体',11,true,false);AlignLine(1);
          SetHeading('表'+IntTostr(SencentId)+'-2'+'【'+MainDataModule.WorkFace_Name+'工作面】采动条件判断分析表',4);

          SetFont('宋体',10,false,false);
          Tab:=AddTable(2,9);
          setTableColumsWidth(Tab,1,60);
          setTableColumsWidth(Tab,2,60);
          SetFont('宋体',11,true,false) ; AlignLine(1);
          WriteText('项目名称',0);
          Moveright(1);AlignLine(1); SetFont('宋体',11,true,false) ;
          WriteText('数值',0);  Moveright(1);AlignLine(0);
          AlignLine(0);
          for I := 0 to 7 do  begin
             SetFont('宋体',11,false,false);
             WriteText(Str_S[i],1);
             MoveRight(1);AlignLine(1);
             SetFont('宋体',11,false,false);
             WriteText(s_temp[i],1);  
             if i<7 then  begin
                MoveRight(1); AlignLine(0);
             end;
          end;

          MoveDown(1);

          AddReturn();

    end;
   finally

   end;

end;

procedure TWordReport.AddYklhInfo_5_2;
begin

end;

procedure TWordReport.ADD_Abstric;
var
   title,istr:String;
   Steps:integer;
begin
    title:='摘  要';
   with innWord do begin
        SetFont('楷体_GB2312',16,true,false);
        AddReturn();
        AlignLine(1);  //居中
        WriteText(title,0); //报告标题   标题编号为1
        AddReturn();
        istr:='   本文提供的矿压深度分析报告以山东科技大学宋振骐院士创建的《实用矿山压力控制》理论为基础而撰写的。'+
              '矿压报告的编写遵循以“岩层运动为中心”的核心理念，工作面矿压显现排查方式遵循“寻找大显现、关注异常点”的工作思路,' +
              '利用理论模型计算、数据统计分析与整体压力三维曲面耦合等分析方法，融合工作面所在的地质条件、采动条件与矿山压力实时监测数据，'+
              '形成的一篇多角度、多参量、多目标的矿压分析报告。' ;
        SetFont('宋体',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
        // 把数据拉过来
        ReportInputData.FillDataFromDataBase(iDwGrap.FGzm.Gzmbh, -1,-1,
                                        iDwGrap.DataTimeAndFootAge.StartTime,
                                        iDwGrap.DataTimeAndFootAge.EndTime);
        Steps:=iDwGrap.Auto_Judge_OldStep.GetComeStepCount(10) +
                iDwGrap.Auto_Judge_OldStep.GetComeStepCount(9) +
                iDwGrap.Auto_Judge_OldStep.GetComeStepCount(8) +
                iDwGrap.Auto_Judge_OldStep.GetComeStepCount(5);

       istr:='   本报告对'+ MainDataModule.Coal_Name+'煤矿【'+MainDataModule.WorkFace_Name+'工作面】采动条件、地质条件与矿压实时数据展开了数据分析，' +
              '分析数据量为'+IntToStr(Round(ReportInputData.TotalCount/10000/5))+'万条,检索到压力显现区域'+InttoStr(Steps) +'处，其中：矿压显现显著区域'+
              intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(10))+'处，矿压显现明显区域'+
              intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(9))+'处，矿压显现异常区域'+
              intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(8)+iDwGrap.Auto_Judge_OldStep.GetComeStepCount(5))+'处。'+
              '报告把工作面按照倾斜方向分为' + intTostr(iDwGrap.Auto_Judge_OldStep.PhaseNumber)+'个区域，按照区域的划分对各区域进行了'+
              '不同来压强度的判定，并进行了'+ intTostr((iDwGrap.Auto_Judge_OldStep.PhaseNumber-2)*3) +'次来压强度的预报。' ;
       SetFont('宋体',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();

        istr:='   本矿压分析报告完全由计算机自动生成，在计算机自动分析计算过程中，不可能对所有的数据面面俱到，'+
              '如果你在使用过程中发现有较大的计算错误请包涵，并及时通告技术服务团队,技术团队将会对你的意见与建议进行认真分析，' +
              '并逐步完善，你的参与就是技术的最大进步。';
        SetFont('宋体',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();

        istr:='   如果你想获得更为完善、更专业、更个性化的报告，请联系技术服务团队(LGZ2050@163.COM)展开深度合作。';
        SetFont('宋体',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();

        istr:='   对煤矿的可知可感与可控是您我共同心愿!';
        SetFont('宋体',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();

        istr:='   科技兴安、科技强矿、安全开采是我们的共同目标!';
        SetFont('宋体',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();


   end;
end;

procedure TWordReport.Add_Contents;
var
   title:String;
begin
    with innWord do begin
        GotoBookMark('mulu');
        title:='目  录';
        SetFont('楷体_GB2312',18,true,false);
        AlignLine(1);  //居中
        WriteText(title,0); //报告标题   标题编号为1
        AddReturn();
        InsertContents(1,3,0);
        //----
        insertPage(0);
        title:='表格清单';
        SetFont('楷体_GB2312',16,true,false);
        AlignLine(1);  //居中
        WriteText(title,0); //报告标题   标题编号为1
        InsertContents(4,4,0);
        //------
        insertPage(0);
        title:='图表清单';
        SetFont('楷体_GB2312',16,true,false);
        AlignLine(1);  //居中
        WriteText(title,0); //报告标题   标题编号为1
        InsertContents(5,5,0);

    end;
end;

procedure TWordReport.Add_disclaimer(Xhstr:String);
begin
     with innWord do begin
          AlignLine(1);
          AddReturn();   //加一个空行
          SetFont('宋体',15,false,false);
          SetHeading(Xhstr+ '、补充建议',2);// 章节
          AddReturn();
           //正文
          AlignLine(0);
          SetFont('宋体',13,false,false);
          WriteText('    本计算主要是使用钻孔柱状图的信息,关于岩石力学参数采用的是经验值,给出的结论仅供参考, ' +
                    ' 如果想确定对采煤工作面有实用性的数据,需要加强现场矿压观测校订关键参数！',0);

     end;
end;

procedure TWordReport.Add_Fourth_Four(P_Str: string; inGZm: TGzm);
var
  istr,tStr:String;
  Jie_id,i,N:integer;
  AGV_D,ADV_C:double;
begin
  with innWord do begin
     SetHeading(P_Str+'.4 工作面即将来压预测预报',2);// 章节
     istr:='   利用三维曲面分方法，对工作面下一步矿压显现预测如下：';
     SetFont('宋体',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
     Jie_id:=0;
     //各个区域的 数值
     tStr:=''; istr:='';
     for I := 0 to high(iDWGrap.Auto_Judge_OldStep.ExSteps ) do  begin
         if (iDWGrap.Auto_Judge_OldStep.ExSteps[i].ModifyData =3 ) and
            (iDWGrap.Auto_Judge_OldStep.ExSteps[i].ForcaseId=1 )  then    // 剧烈运动 预测数据
            if (iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.EndSup-iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.StartSup > 2)  and
               (iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.End_AGVFootage-iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.Start_AGVFootage>1)   and
               (iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.WholeQD>0)  and (iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.AreaQD > 0) then begin

                  inc(Jie_id);
                  istr:='   ('+intTostr(Jie_id)+ ')矿压显现显著预测：支架范围'+ intTostr(iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.StartSup ) +
                        '-'+intTostr(iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.EndSup ) +',进尺范围：'+
                        FormatFloat('0.00',iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.Start_AGVFootage) +'-' +
                        FormatFloat('0.00',iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.End_AGVFootage) +'米，来压强度系数'+
                        FormatFloat('0.00',iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.WholeQD) +',来压面积强度'+
                        FormatFloat('0.00',iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.AreaQD) +',请注意防范。';
                  SetFont('宋体',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
               end;
     end;

     for I := 0 to high(iDWGrap.Auto_Judge_OldStep.ExSteps ) do  begin
         if (iDWGrap.Auto_Judge_OldStep.ExSteps[i].ModifyData =3 ) and
            (iDWGrap.Auto_Judge_OldStep.ExSteps[i].ForcaseId=2 )  then   // 剧烈运动 预测数据
            if (iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.EndSup-iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.StartSup > 2)  and
               (iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.End_AGVFootage-iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.Start_AGVFootage>1)   and
               (iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.WholeQD>0)  and (iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.AreaQD > 0) then begin

                  inc(Jie_id);
                  istr:='   ('+intTostr(Jie_id)+ ')矿压显现明显预测：支架范围'+ intTostr(iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.StartSup ) +
                        '-'+intTostr(iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.EndSup ) +',进尺范围：'+
                        FormatFloat('0.00',iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.Start_AGVFootage) +'-' +
                        FormatFloat('0.00',iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.End_AGVFootage) +'米，来压强度系数'+
                        FormatFloat('0.00',iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.WholeQD) +',来压面积强度'+
                        FormatFloat('0.00',iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.AreaQD) +',请注意防范。';
                  SetFont('宋体',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
               end;
     end;
  end;


     
end;

procedure TWordReport.Add_fourth_one(P_Str: string; inGZm: TGzm);
var
  istr:String;
  Jie_id:integer;
begin
  with innWord do begin
     SetHeading(P_Str+'.1 基于理论模型的分析结果',2);// 章节
     istr:='   基于实用矿山压力控制理论进行模型分析的矿用结果如下：';
     SetFont('宋体',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
     Jie_id:=0;
     inc(Jie_id);
     istr:='   ('+intTostr(Jie_id)+')直接顶参数：'+ StrPas(iCallPStope.Get_immediate_roof('1.0'));
     SetFont('宋体',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
     inc(Jie_id);
     istr:='   ('+intTostr(Jie_id)+')老顶参数：'+ StrPas(iCallPStope.Get_Old_roof('1.0'));
     SetFont('宋体',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
     inc(Jie_id);
     istr:='   ('+intTostr(Jie_id)+')支承压力参数：'+ StrPas(iCallPStope.Get_Zcyl('4.0',400));
     SetFont('宋体',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
  end;
end;

procedure TWordReport.Add_fourth_QianYan;
var
 istr:string;
begin
    with innWord do begin
        SetFont('宋体',12,False,False);
        istr:='   本次矿压分析报告是以山东科技大学宋振骐院士创建的《实用矿山压力控制》理论为基础而编写的，'+
              '本次报告主要从三个方面进行了深入分析。';
        WriteText(istr,1);  AddReturn();

        istr:='   第一：利用《实用矿山压力控制》理论，结合采煤工作面基本参数信息与周边钻孔岩层详细信息，对【'+MainDataModule.WorkFace_Name+
              '】工作面的上覆岩层运动规律与支承压力分布规律进行了理论层面的分析与推演。';
        WriteText(istr,1); AddReturn();
        istr:='   第二：利用统计学分析方法中矿压实时监测数据进行了定量分析，检索出工作面矿压显现明显的区域。';
        WriteText(istr,1); AddReturn();
        istr:='   第三：采用三维曲面的矿压分析方法对工作面实时监测数据进行深入分析。';
        WriteText(istr,1);AddReturn();

        istr:='   系统通过理论推演到实测分析，得出以下基本结论：';
        WriteText(istr,1); AddReturn();
    end;

end;

procedure TWordReport.Add_fourth_Secents(inGZm: TGzm);
{ 其实是第五结论}
var
  Str_Secents:String;
  tab:Table;
begin
   third_Tab_id:=0;
   Subject_Str.Clear ;
   Str_Secents:=intTostr(SencentId);
    with innWord do begin
      AlignLine(0); Addreturn();
      SetFont('宋体',16,true,false);
      SetHeading(Str_Secents+' '+MainDataModule.WorkFace_Name +'矿压分析结论',1);// 章节
      SetFont('宋体',11,false,false);
      //前言
      Add_fourth_QianYan;
      public_Basic.WriteMakeWordPercent(true,91);
      // 第一节实用矿山压力理论 结论
      Add_fourth_one(Str_Secents,inGZm);
      public_Basic.WriteMakeWordPercent(true,92);
      //第二节 基于统计学分析方法
      Add_fourth_two(Str_Secents,inGZm);
      public_Basic.WriteMakeWordPercent(true,93);
      //第三节 基于曲面的分析方法
      Add_fourth_three(Str_Secents,inGZm);
      public_Basic.WriteMakeWordPercent(true,94);
      // 矿压显现预测
      Add_Fourth_Four(Str_Secents,inGZm);
    end;

end;

procedure TWordReport.Add_fourth_three(P_Str: string; inGZm: TGzm);
var
  istr:String;
  Jie_id,P,P_Count:integer;
  AGV_D,ADV_C:double;
begin
   with innWord do begin
     SetHeading(P_Str+'.3 基于三维曲面的分析方法的分析结果',2);// 章节
     istr:='   利用三维曲面分方法，对工作面矿压实时监测数据进行分析，结果如下：';
     SetFont('宋体',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();

     iDwGrap.Auto_Judge_OldStep.GetComeStepInfo(10,AGV_D,ADV_C) ;
     if (AGV_D>0) and (ADV_C>0)  then  begin
         inc(Jie_id);
         istr:='   ('+intTostr(Jie_id)+')工作面整体分析矿压显现显著：'+intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(10)) +'次,'+
               '平均进刀为：'+FormatFloat('0.00' , AGV_D)+'刀，平均进尺为：'+ FormatFloat('0.00' , ADV_C)+'米';
         SetFont('宋体',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
     end;

     iDwGrap.Auto_Judge_OldStep.GetComeStepInfo(9,AGV_D,ADV_C) ;
     if (AGV_D>0) and (ADV_C>0)  then  begin
         inc(Jie_id);
         istr:='   ('+intTostr(Jie_id)+')工作面整体分析矿压显现明显：'+intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(9)) +'次,'+
               '平均进刀为：'+FormatFloat('0.00' , AGV_D)+'刀，平均进尺为：'+ FormatFloat('0.00' , ADV_C)+'米';
         SetFont('宋体',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
     end;

     //各个区域的 数值
     for P := 0 to iDWGrap.Auto_Judge_OldStep.PhaseNumber -1 do  begin
         P_Count:=0;
         P_Count:=iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(10) ;
         iDwGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepsInfo(10,AGV_D,ADV_C) ;
         if P_Count>0 then  begin
            inc(Jie_id);
            istr:='   ('+intTostr(Jie_id)+')工作面第【'+Public_Basic.GetChineseNumber(P+1)+'】'+
               '区间，液压支架编号范围【'+IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].StartsupBh ) +'-'+
                IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].EndSupBh ) +'】架,'+
               '该区域矿压显现显著：'+intTostr(P_Count) +'次,'+
               '平均进刀为：'+FormatFloat('0.00' , AGV_D)+'刀，平均进尺为：'+ FormatFloat('0.00' , ADV_C)+'米';

            SetFont('宋体',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
         end;
         //----------------
         P_Count:=0;
         P_Count:=iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(9) ;
         iDwGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepsInfo(9,AGV_D,ADV_C) ;
         if P_Count>0 then  begin
            inc(Jie_id);
            istr:='   ('+intTostr(Jie_id)+')工作面第【'+Public_Basic.GetChineseNumber(P+1)+'】'+
               '区间，液压支架编号范围【'+IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].StartsupBh ) +'-'+
                IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].EndSupBh ) +'】架,'+
               '该区域矿压显现明显：'+intTostr(P_Count) +'次,'+
               '平均进刀为：'+FormatFloat('0.00' , AGV_D)+'刀，平均进尺为：'+ FormatFloat('0.00' , ADV_C)+'米';

            SetFont('宋体',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
         end;

     end;
   end;


end;

procedure TWordReport.Add_fourth_two(P_Str: string; inGZm: TGzm);
var
  istr:String;
begin
    with innWord do begin
     SetHeading(P_Str+'.2 基于统计学方法分析的分析结果',2);// 章节
     Add_Second_Two_Jielun(P_Str,inGZm);
    end;
end;

procedure TWordReport.ADD_Fuhaoshuming;
var
   title,istr:String;
   Steps:integer;
begin
    title:='符号说明';
   with innWord do begin
        SetFont('楷体_GB2312',15,true,false);
        AddReturn();
        AlignLine(1);  //居中
        WriteText(title,0); //报告标题   标题编号为1
        AddReturn();
        istr:='直接顶:' ;
        SetFont('宋体',10,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
        istr:='老顶:' ;
        SetFont('宋体',10,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();


   end;

end;

procedure TWordReport.ADD_Fulu;
var
  title:String;
begin

    with innWord do begin
        GotoBookMark('fulu');
        title:='附录X';
        SetFont('宋体',14,true,false);
        AlignLine(0);  //向左对其
        SetHeading(title,1);
    end;

end;

procedure TWordReport.Add_FuLuTu(tuOrTable,id :integer;title,Memo,FileName:string);
{tuOrTable   0 表示 的是图
             1  表示的是表
}
var
  R_str:String;
  tab:Table;
begin
    with innWord do begin
        GotoBookMark('fulu');
        MoveEnd(0);
        Tab:=AddTable(1,1);
        AlignLine(1);
        if tuOrTable=0  then  begin // 图
           if id =1 then  begin
             AddPicture(FileName,0.95);
           end else begin
             AddPicture(FileName,1);
           end;
            moveDown(1);
           SetFont('宋体',10,true,false); AlignLine(1);
           SetHeading('图X-'+InttoStr(id)+' ' +title,5);
           if length(Memo) >0  then   begin
              SetFont('宋体',10,true,false); AlignLine(1);WriteText(Memo,0);
           end;

        end;
       TableBorders(tab,0,0);

       insertpage(0);
    end;


end;

procedure TWordReport.Add_Fulu_TuFirstToFive;
var
   PathFile:string;
   i:integer;
   DataTypeStr:string;

begin
     // 把附录的图表 给添加了

     fuLu_Tu_id:=0;
     with innword do begin
         //第一张图
        Yu_Start_id:=1;
         for I := 0 to 5 do  begin
               if ForceExit then   exit;
               if i=2 then  continue; // 初撑力 返回
               if (i=5) and (not MainDataModule.SelectRockPressDataNumber(5,iDwGrap.FGzm.Gzmbh)) then  continue;

               DataTypeStr:=ReturnDataTypeName(i);
               PathFile:=ReturnFileName('YT',iDwGrap.DataTimeAndFootAge.Graph_MinDao,
                                             iDwGrap.DataTimeAndFootAge.Graph_MaxDao,i,1);
               if PathFile<>'' then  begin
                  inc(fuLu_Tu_id);
                  ChangePictureWidth(PathFile);
                  Add_FuLuTu(0,fuLu_Tu_id,
                        '【'+MainDataModule.WorkFace_Name+'工作面】液压支架循环【'+DataTypeStr+'】原始数据压力云图',
                         '',PathFile);
               end;
                //第二张图
               PathFile:=ReturnFileName('YT',iDwGrap.DataTimeAndFootAge.Graph_MinDao,
                                             iDwGrap.DataTimeAndFootAge.Graph_MaxDao,i,0);
               if PathFile<>'' then  begin
                  inc(fuLu_Tu_id);
                  ChangePictureWidth(PathFile);
                  Add_FuLuTu(0,fuLu_Tu_id,
                        '【'+MainDataModule.WorkFace_Name+'工作面】循环【'+DataTypeStr+'】矿压显现明显区域自动标定图',
                          '(矿压显现判断临界线【'+FormatFloat('0.00',iDwGrap.GetStepJudgeLevel(i)*iDwGrap.ColorValue.UnitValue)+'】'+
                          iDwGrap.ColorValue.UntiName +  '，压力显现比值为【'+FormatFloat('0.0',iDwGrap.GetStepJudgeRatio(i))+'%】)',
                          PathFile);
               end;

               //第三张图
               PathFile:=ReturnFileName('YT',iDwGrap.DataTimeAndFootAge.Graph_MinDao,
                                             iDwGrap.DataTimeAndFootAge.Graph_MaxDao,i,2);
               if PathFile<>'' then  begin
                  inc(fuLu_Tu_id);
                  ChangePictureWidth(PathFile);
                  Add_FuLuTu(0,fuLu_Tu_id, '【'+MainDataModule.WorkFace_Name+'工作面】循环【'+DataTypeStr+'】矿压显现明显区域综合标定图 ',
                               ' (【粉红色】矿压显现显著 【蓝色】矿压显现明显 【黄色】矿压显现异常)', PathFile);
               end;
              public_Basic.WriteMakeWordPercent(true,20+i);
         end;
          Yu_End_id:=fuLu_Tu_id;
        //第四张图  把 平均值的预测 反应出来
          PathFile:=ReturnFileName('YB',iDwGrap.DataTimeAndFootAge.Graph_MaxDao-20,
                                         iDwGrap.DataTimeAndFootAge.Graph_MaxDao+80,1,2);
          DataTypeStr:=ReturnDataTypeName(1);
           if PathFile<>'' then  begin
              inc(fuLu_Tu_id);
              ChangePictureWidth(PathFile);
              Add_FuLuTu(0,fuLu_Tu_id, '【'+MainDataModule.WorkFace_Name+'工作面】循环【'+DataTypeStr+'】矿压显现明显区域预测分析图 ' ,
                             '(【红色】矿压显现显著 【黄色】矿压显现明显)' , PathFile);
              ForCaseTuid:= fuLu_Tu_id;
           end else begin
              ForCaseTuid:=-1;
           end;

         // 整体 直方图
          CreateBand_Bar(ExHandle,'',0,0,2);
          iDwGrap.BarMarks.Fromcontour:=true;;//代表从云图中传递数据
          if Assigned(Form_Band_Bar) then  begin
              Form_Band_Bar.InitForm(iDwGrap) ;
              Form_Band_Bar.SetOpenFormVar('',
                                    true, //外部传过来数据
                                    true// 是否打开工具菜单
                                    );

          end;
         FormPressTool.Close ;
         Form_Band_Bar.RefreshBarSeries(-1);
         Form_Band_Bar.Main_panel.Refresh;
         PathFile:=Form_Band_Bar.AutoSaveOnesupportOneBMP(-1);
         if PathFile<>'' then  begin
            inc(fuLu_Tu_id);
            ChangePictureWidth(PathFile);
            Add_FuLuTu(0,fuLu_Tu_id, '【'+MainDataModule.WorkFace_Name+'工作面】液压支架压力频谱分析图',
                     '中心图是全工作面全部数据分析图，其他12幅图是随机选择12个支架的压力频谱分析图',PathFile);
            PinPutuid:= fuLu_Tu_id;
         end else begin
            PinPutuid:=-1;
         end;
         Form_Band_Bar.Close ;
         // 添加 统计图 TongjiTuid
         CreateTongJiXueGraph(ExHandle,'',0,0,0);
         TongjiTuid:=-1;
         if Assigned(Form_TongJIGraph) then  begin
           Form_TongJIGraph.WindowState:=wsNormal;
           Form_TongJIGraph.InitForm(iDwGrap) ;
           Form_TongJIGraph.RefreshChartGraph;
           Form_TongJIGraph.Close ;
           PathFile  :=Public_Basic.Get_MyModulePath+'saveBmp\KYFX\TongJi.BMP';
           inc(fuLu_Tu_id);
           ChangePictureWidth(PathFile);
           Add_FuLuTu(0,fuLu_Tu_id, '【'+MainDataModule.WorkFace_Name+'工作面】统计分析方法矿压判断图',
                     '黑色为区间所有支架压力均值线，红色为矿压显现明显优化曲线',PathFile);
           TongjiTuid:= fuLu_Tu_id;
         end;

     end;


end;

procedure TWordReport.Add_FYYD_2(inGzm: TGZM);
{
   增加矿压分析理论 知识
}
var
  str:string;
  fileName,textString:Ansistring;
  DirName:Ansistring;
  Dll_Path:AnsiString;
  tab:Table;
begin
   Dll_Path:=Public_Basic.Get_MyModulePath;
   DirName:=DLL_path+'\InputData\WorkDace_'+IntTostr(inGzm.Gzmbh)+'\';
    with innWord do begin
      AlignLine(0);
      SetFont('宋体',16,true,false);
      SetHeading(IntTostr(SencentId)+' 实用矿山压力控制理论及实践应用',1);// 章节
      SetFont('宋体',12,false,false);
      insertotherfile(Dll_Path+'BJTP\A00'+IntTostr(SencentId)+'.rtf');
      public_Basic.WriteMakeWordPercent(true,36);
      //---------------------
      // 第二节
      SetFont('宋体',14,false,false);
      SetHeading(IntTostr(SencentId)+'.2 采场空间结构模型对【'+MainDataModule.WorkFace_Name+'工作面】计算分析',2);// 章节
      str:='   ' + MainDataModule.WorkFace_Name + '工作面附近的钻孔为【'+ MainDataModule.Drill_Name+'】钻孔,'+
           '根据工作面与钻孔的数据，利用实用矿山压力控制理论进行计算分析，结果如下：';
      SetFont('宋体',12,false,false);  AlignLine(0); WriteText(str,1);
      AddReturn();
      //2.2.1
      SetFont('宋体',12,false,false);
      SetHeading(IntTostr(SencentId)+'.2.1【'+MainDataModule.WorkFace_Name+'工作面】顶板结构计算分析',3);// 章节
      str:='   根据实用矿山压力控制理论，利用钻孔岩层数据对采煤工作面的顶板结构进行分析，主要有两种计算方法：';
      SetFont('宋体',12,false,false);  AlignLine(0); WriteText(str,1);   AddReturn();
      str:='   第一种挠曲计算法:就是在计算岩层结构关系时，按照岩层挠曲值进行推算，该种方法对顶板比较软的岩层适用性较强。';
      WriteText(str,1);   AddReturn();
      str:='   第二种步距计算法:就是在计算岩层结构关系时，按照岩层固有的来压步距进行推算，该种方法对顶板相对坚硬岩层有较强的适应性。';
      SetFont('宋体',12,false,false);  AlignLine(0); WriteText(str,1);  AddReturn();
      str:='   两种计算方法如图'+IntTostr(SencentId)+'-8,'+IntTostr(SencentId)+'-9所示，图' +
             IntTostr(SencentId)+ '-10为两种算法的综合显示。';
      SetFont('宋体',12,false,false);  AlignLine(0); WriteText(str,1);  AddReturn();
      tab:=AddTable(1,1);
      TableBorders(tab,0,0);  //把边框为 0
      AlignLine(1);
      if self.isExsitBmpFile(Dll_Path+'SaveBmp\FYYD\NQF.JPG') then
         AddPicture(Dll_Path+'SaveBmp\FYYD\NQF.JPG',1);
      MoveDown(1);
      public_Basic.WriteMakeWordPercent(true,37);
      SetFont('宋体',11,true,false);AlignLine(1);
      SetHeading('图'+IntTostr(SencentId)+'-8'+' 【'+MainDataModule.WorkFace_Name+'工作面】顶板结构挠曲算法图示',5);
      AddReturn();
      tab:=AddTable(1,1);
      TableBorders(tab,0,0);  //把边框为 0
      AlignLine(1);
      if self.isExsitBmpFile(Dll_Path+'SaveBmp\FYYD\BJF.JPG') then
         AddPicture(Dll_Path+'SaveBmp\FYYD\BJF.JPG',1);
      MoveDown(1);
      public_Basic.WriteMakeWordPercent(true,38);

      SetFont('宋体',11,true,false);AlignLine(1);
      SetHeading('图'+IntTostr(SencentId)+'-9'+' 【'+MainDataModule.WorkFace_Name+'工作面】顶板结构步距算法图示',5);
      AddReturn();
      tab:=AddTable(1,1);
      TableBorders(tab,0,0);  //把边框为 0
      AlignLine(1);
       if self.isExsitBmpFile(Dll_Path+'SaveBmp\FYYD\ZHSF.JPG') then
         AddPicture(Dll_Path+'SaveBmp\FYYD\ZHSF.JPG',1);
      MoveDown(1);
      SetFont('宋体',11,true,false);AlignLine(1);
      SetHeading('图'+IntTostr(SencentId)+'-10'+'【'+MainDataModule.WorkFace_Name+'工作面】顶板结构综合算法图示',5);
      AddReturn();
      public_Basic.WriteMakeWordPercent(true,39);
      //
      str:='   根据实用矿山压力控制理论，综合判断的直接顶参数如下：';
      SetFont('宋体',12,false,false);  AlignLine(0); WriteText(str,1);   AddReturn();
      str:='   '+ StrPas(iCallPStope.Get_immediate_roof('1.0'));
      SetFont('宋体',12,false,false);  AlignLine(0); WriteText(str,1);   AddReturn();
      str:='   根据实用矿山压力控制理论，综合判断的老顶参数如下：';
      SetFont('宋体',12,false,false);  AlignLine(0); WriteText(str,1);   AddReturn();
      str:='   '+ StrPas(iCallPStope.Get_Old_roof('1.0'));
      SetFont('宋体',12,false,false);  AlignLine(0); WriteText(str,1);
      AddReturn();
      //2.2.2
      SetFont('宋体',12,false,false);
      SetHeading(IntTostr(SencentId)+'.2.2【'+MainDataModule.WorkFace_Name+'工作面】上覆岩层运动仿真模拟',3);// 章节
      str:='   根据实用矿山压力控制理论，对该工作面不同进尺处的顶板运动状态进行模拟，模拟结果如图'+IntTostr(SencentId)+
            '-11--'+IntTostr(SencentId)+'-16。';
      SetFont('宋体',12,false,false);  AlignLine(0); WriteText(str,1);   AddReturn();

      tab:=AddTable(1,1);
      TableBorders(tab,0,0);  //把边框为 0
      AlignLine(1);
      public_Basic.WriteMakeWordPercent(true,40);

      if self.isExsitBmpFile(Dll_Path+'SaveBmp\FYYD\IMM0.JPG') then
         AddPicture(Dll_Path+'SaveBmp\FYYD\IMM0.JPG',1);
      MoveDown(1);
      SetFont('宋体',11,true,false);AlignLine(1);
      SetHeading('图'+IntTostr(SencentId)+'-11'+'【'+MainDataModule.WorkFace_Name+'工作面】开采模拟初始状态图',5);
      AddReturn();
      tab:=AddTable(1,1);
      TableBorders(tab,0,0);  //把边框为 0
      AlignLine(1);
      if self.isExsitBmpFile(Dll_Path+'SaveBmp\FYYD\IMM1.JPG') then
         AddPicture(Dll_Path+'SaveBmp\FYYD\IMM1.JPG',1);
      MoveDown(1);
      SetFont('宋体',11,true,false);AlignLine(1);
      SetHeading('图'+IntTostr(SencentId)+'-12'+'【'+MainDataModule.WorkFace_Name+'工作面】直接顶初次垮落示意图',5);
      AddReturn();
      tab:=AddTable(1,1);
      TableBorders(tab,0,0);  //把边框为 0
      AlignLine(1);
      if self.isExsitBmpFile(Dll_Path+'SaveBmp\FYYD\IMM2.JPG') then
         AddPicture(Dll_Path+'SaveBmp\FYYD\IMM2.JPG',1);
      MoveDown(1);
      SetFont('宋体',11,true,false);AlignLine(1);
      SetHeading('图'+IntTostr(SencentId)+'-13'+'【'+MainDataModule.WorkFace_Name+'工作面】顶板冒落初步形成示意图',5);
      AddReturn();
      tab:=AddTable(1,1);
      TableBorders(tab,0,0);  //把边框为 0
      AlignLine(1);
      if self.isExsitBmpFile(Dll_Path+'SaveBmp\FYYD\IMM3.JPG') then
         AddPicture(Dll_Path+'SaveBmp\FYYD\IMM3.JPG',1);
      MoveDown(1);
      SetFont('宋体',11,true,false);AlignLine(1);
      SetHeading('图'+IntTostr(SencentId)+'-14'+'【'+MainDataModule.WorkFace_Name+'工作面】老顶初次来压示意图',5);
      AddReturn();
      tab:=AddTable(1,1);
      TableBorders(tab,0,0);  //把边框为 0
      AlignLine(1);
      if self.isExsitBmpFile(Dll_Path+'SaveBmp\FYYD\IMM4.JPG') then
         AddPicture(Dll_Path+'SaveBmp\FYYD\IMM4.JPG',1);
      MoveDown(1);
      SetFont('宋体',11,true,false);AlignLine(1);
      SetHeading('图'+IntTostr(SencentId)+'-15'+'【'+MainDataModule.WorkFace_Name+'工作面】老顶周期来压示意图',5);
      AddReturn();
      tab:=AddTable(1,1);
      TableBorders(tab,0,0);  //把边框为 0
      AlignLine(1);
      if self.isExsitBmpFile(Dll_Path+'SaveBmp\FYYD\IMM5.JPG') then
         AddPicture(Dll_Path+'SaveBmp\FYYD\IMM5.JPG',1);
      MoveDown(1);
      SetFont('宋体',11,true,false);AlignLine(1);
      SetHeading('图'+IntTostr(SencentId)+'-16'+'【'+MainDataModule.WorkFace_Name+'工作面】采动见方顶板运动示意图',5);
      AddReturn();
      public_Basic.WriteMakeWordPercent(true,43);

      str:='   通过图'+IntTostr(SencentId)+'-14--图'+IntTostr(SencentId)+'-16可以非常清晰的看出【'+
            MainDataModule.WorkFace_Name+'】工作面老顶下位'+
            '岩梁从开始裂断到周期裂断的运动状态，详细的岩层运动状态可以到软件中查看。';
      SetFont('宋体',12,false,false);  AlignLine(0); WriteText(str,1);   AddReturn();
      //2.2.3
      SetFont('宋体',12,false,false);
      SetHeading(IntTostr(SencentId)+'.2.3【'+MainDataModule.WorkFace_Name+'工作面】支承压力分布计算分析',3);// 章节
      str:='   根据图'+IntTostr(SencentId)+'-3到图'+IntTostr(SencentId)+'-7描述的采煤工作面周边支承压力的转移规律，' +
            '利用实用矿山压力控制理论对 '+ '【'+MainDataModule.WorkFace_Name+
            '】工作面的支承压力分布规律进行计算，得到结果如表'+IntTostr(SencentId)+'-1 所示，三维形态图如图'+
            '图'+IntTostr(SencentId)+'-17 所示';
      SetFont('宋体',12,false,false);  AlignLine(0); WriteText(str,1);   AddReturn();
      Report_Zcyl(inGzm);

      AddReturn();
      tab:=AddTable(1,1);
      TableBorders(tab,0,0);  //把边框为 0
      AlignLine(1);
      if self.isExsitBmpFile(Dll_Path+'SaveBmp\FYYD\ZCYL.Bmp') then
         AddPicture(Dll_Path+'SaveBmp\FYYD\ZCYL.Bmp',1);
      MoveDown(1);
      SetFont('宋体',11,true,false);AlignLine(1);
      SetHeading('图'+IntTostr(SencentId)+'-17'+'【'+MainDataModule.WorkFace_Name+'工作面】支承压力三维形态示意图',5);
      AddReturn();
      //2.2.4
      SetFont('宋体',12,false,false);
      SetHeading(IntTostr(SencentId)+'.2.4【'+MainDataModule.WorkFace_Name+'工作面】采动条件计算分类',3);// 章节
      AddYklhInfo_5(inGzm);
    end;

end;


procedure TWordReport.ADd_HouJi;
var
  title:String;
begin

    with innWord do begin
        GotoBookMark('houji');
        title:='后记';
        SetFont('宋体',14,true,false);
        AlignLine(0);  //向左对其
        SetHeading(title,1);
    end;
end;

procedure TWordReport.Add_Kyfx_Cover(CoalName, WorkFaceName:string);
var
  title:String;
  i:integer;
  Pic_Path:string;
  tab:Table;
begin

    Pic_Path:=Public_Basic.Get_MyModulePath;
    with innWord do begin

        for I := 0 to 2 do    AddReturn();
        title:=CoalName+'煤矿'+WorkFaceName+'工作面';
        SetFont('宋体',18,true,false);   AlignLine(1);      WriteText(title,1); //报告标题   标题编号为1
        AddReturn(); AddReturn();
        SetFont('黑体',28,true,false);   AlignLine(1);      WriteText('矿山压力深度分析报告',1); //报告标题   标题编号为1
        SetFont('黑体',18,true,false);

        for I := 0 to 2 do      AddReturn();

         // 插入图标
         tab:=AddTable(3,1); moveright(1);
         TableBorders(tab,0,0);
         if self.isExsitBmpFile(Pic_Path+'BJTP\cover1.jpg') then
             AddPicture(Pic_Path+'BJTP\cover1.jpg',1);
         MoveDown(1);


        for I := 0 to 1 do
            AddReturn();

       // 插入其他信息
         SetFont('黑体',12,true,false);
         AlignLine(1);  //居中
         tab:=AddTable(2,6);
         TableBorders(tab,0,0);
         setTableColumsWidth(tab,1,35);
         setTableColumsWidth(tab,2,95);
         SetFont('宋体',12,true,false);   AlignLine(0);    WriteText('数据分析时间:',1);  moveright(1);
              title:='  【'+FormatDatetime('MM-DD HH:NN:SS',iDWGrap.DataTimeAndFootAge.StartTime  )+'】-【'+
                    FormatDatetime('MM-DD HH:NN:SS',iDWGrap.DataTimeAndFootAge.EndTime ) +'】';
              for I := strlen(PwideChar(title)) to 85 do     title:=title+' ';
              SetFont('宋体',12,false,true);   AlignLine(0);    WriteText(title,1);  moveright(1);
         SetFont('宋体',12,true,false);   AlignLine(0);    WriteText('数据分析进刀:',1);  moveright(1);
              title:='  从第【'+IntToStr(iDWGrap.DataTimeAndFootAge.Graph_MinDao  )+'】刀-第【'+
                      IntToStr(iDWGrap.DataTimeAndFootAge.Graph_MaxDao ) +'】刀';
              for I := strlen(PwideChar(title)) to 85 do     title:=title+' ';
              SetFont('宋体',12,false,true);   AlignLine(0);    WriteText(title,1);  moveright(1);
         SetFont('宋体',12,true,false);   AlignLine(0);    WriteText('数据分析进尺:',1);  moveright(1);
              title:='  从第【'+FormatFloat('0.0',iDWGrap.DataTimeAndFootAge.DownStartFootage  )+'】米-第【'+
                      FormatFloat('0.0',iDWGrap.DataTimeAndFootAge.DownEndFootage ) +'】米';
              for I := strlen(PwideChar(title)) to 85 do     title:=title+' ';
              SetFont('宋体',12,false,true);   AlignLine(0);    WriteText(title,1);  moveright(1);
        SetFont('宋体',12,true,false);   AlignLine(0);    WriteText('报告编制单位:',1);  moveright(1);
              title:='  '+MainDataModule.Coal_Name+'煤矿生产科矿压工作组';
              for I := strlen(PwideChar(title)) to 85 do     title:=title+' ';
              SetFont('宋体',12,false,true);   AlignLine(0);    WriteText(title,1);  moveright(1);
        SetFont('宋体',12,true,false);   AlignLine(0);    WriteText('技术支持团队:',1);  moveright(1);
              title:='  '+'山东科技大学宋振骐院士技术团队';
              for I := strlen(PwideChar(title)) to 85 do     title:=title+' ';
              SetFont('宋体',12,false,true);   AlignLine(0);    WriteText(title,1);  moveright(1);
        SetFont('宋体',12,true,false);   AlignLine(0);    WriteText('报告编制时间:',1);  moveright(1);
              title:='  '+ReturnTimeToChinese(now);
              for I := strlen(PwideChar(title)) to 85 do     title:=title+' ';
              SetFont('宋体',12,false,true);   AlignLine(0);    WriteText(title,1);
        movedown(1);

    end;


end;

procedure TWordReport.Add_Second_Secents(inGZm: TGzm);
{ 其实是第三章}

var
  Str_Secents,istr:String;
  tab:Table;
  i:integer;
begin
   Second_Tab_id:=0;
   //fuLu_Tu_id:=5; // 前面五张图 被预定   (不能锁定被预定了）
   Subject_Str.Clear ;
   Str_Secents:=intTostr(SencentId);
    with innWord do begin
      AlignLine(0); Addreturn();
      SetFont('宋体',16,true,false);
      SetHeading(Str_Secents+' 矿压实时数据统计学特征分析',1);// 章节
      SetFont('宋体',11,false,false);
      //前言
      Add_Second_QianYan;
//      // 第三章 第一节
       Add_Second_First_main(Str_Secents,inGZm);
//      //第三章 第二节
        SetFont('宋体',12,false,false);
        SetHeading(Str_Secents+'.2 矿压监测数据统计学特征分析',2);// 章节
        SetFont('宋体',12,False,False);
        istr:='    为便于数据统计，本次矿压分析方法是以每个支架的一次循环（进刀）为基准进行矿压分析，' +
               '提取每个支架、每次循环的初撑力、末阻力、最大值、平均值及某一时刻支架瞬间监测值等五类数据，' +
               '在分析各类数据的统计学特征基础上，对数据进行穿透、交叉融合，寻找矿压监测数据的内在联系。分析结果如表'+
               Str_Secents+'-2到表'+Str_Secents+'-'+intTostr(iDwGrap.Auto_Judge_OldStep.PhaseNumber*2+1) +'。';
        WriteText(istr,1); AddReturn();
        if TongjiTuid>0 then  begin
            istr:='    统计分析方法压力各区域压力均值曲线与优化曲线如附录 图 X-'+IntTostr(TongjiTuid)+'所示。';
             WriteText(istr,1); AddReturn();

        end;
        public_Basic.WriteMakeWordPercent(true,47);
//
        Second_Tab_id:=1;
         for I := 0 to iDwGrap.Auto_Judge_OldStep.PhaseNumber-1 do  begin
            SetHeading(Str_Secents+'.2.'+IntTostr(i+1)+' 第【'+Public_Basic.GetChineseNumber(i+1)+'】区间矿压实测数据统计学特征分析',3);// 章节
            SetFont('宋体',12,False,False);
            //统计学数据分析
            Add_Second_Two_Table_1(Str_Secents,inGZm,i) ;
            // 统计数据结果分析
            Add_Second_Two_Table_2(Str_Secents,inGZm,i) ;
            public_Basic.WriteMakeWordPercent(true,47+3*i);
         end;

        // 第三节 结论
      SetHeading(Str_Secents+'.3 矿压实时数据分析结果',2);// 章节
      Add_Second_Two_Jielun(Str_Secents,inGZm);

    end;

end;

procedure TWordReport.Add_Support_Information(inGzm: TGzm);
var
  str:string;
  i:integer;
begin

    with innWord do begin
         AlignLine(1);
         SetFont('宋体',11,True,false);
         WriteText('表1-3 '+inGzm.SupportName+'液压支架主要技术参数',0);
         AddReturn();
         SetFont('宋体',11,true,false);
         AddTable(4,7);
          WriteText('参数名称',0);   MoveRight(1);   WriteText('参数值',0);   MoveRight(1);
              WriteText('参数名称',0);   MoveRight(1);   WriteText('参数值',0);   MoveRight(1);
          SetFont('宋体',11,False,false);
          WriteText('支架类型',0);   MoveRight(1);
               WriteText(inGzm.Usedsupport.Zj_leixing,0);   MoveRight(1);
          WriteText('支架型号',0);   MoveRight(1);
               WriteText(inGzm.Usedsupport.Zj_Name,0);   MoveRight(1);
          WriteText('支架中心距（米）',0);   MoveRight(1);
               WriteText(FormatFloat('.##',inGzm.Usedsupport.Zj_zhongxinju),0);   MoveRight(1);
          WriteText('支架控顶距（米）',0);   MoveRight(1);
               WriteText(FormatFloat('.##',inGzm.Usedsupport.Zj_KongdingJU),0);   MoveRight(1);
          WriteText('合力作用点（米）',0);   MoveRight(1);
               WriteText(FormatFloat('.##',inGzm.Usedsupport.Zj_hlzyd),0);   MoveRight(1);
          WriteText('立柱数量（个）',0);   MoveRight(1);
               WriteText(IntToStr(inGzm.Usedsupport.Zj_Lizhu_count),0);   MoveRight(1);
          WriteText('立柱缩量（米）',0);   MoveRight(1);
               WriteText(FormatFloat('.##',inGzm.Usedsupport.Zj_suoliang),0);   MoveRight(1);
          WriteText('支架阻抗力（KN）',0);   MoveRight(1);
               WriteText(FormatFloat('.##',inGzm.Usedsupport.Zj_toall_F),0);   MoveRight(1);
          WriteText('支护强度（MPa）',0);   MoveRight(1);
               WriteText(FormatFloat('.##',inGzm.Usedsupport.zj_toall_P),0);   MoveRight(1);
          WriteText('护帮高度（米）',0);   MoveRight(1);
               WriteText(FormatFloat('.##',inGzm.Usedsupport.Zj_hubang_h),0);   MoveRight(1);

          WriteText('护帮强度（MPa）',0);   MoveRight(1);
               WriteText(FormatFloat('.##',inGzm.Usedsupport.zj_hubang_P),0);   MoveRight(1);
          WriteText('立柱缸径（毫米）',0);   MoveRight(1);
               WriteText(FormatFloat('0',inGzm.Usedsupport.Lz_Diameter),0);

         MoveDown(1);
    end;

end;

procedure TWordReport.Add_Third_QianYan;
var
 istr:string;
begin
    with innWord do begin
        SetFont('宋体',12,False,False);
//         istr:='   三维曲面方法是神华集团神东煤炭公司技术中心周海丰高工在多年矿压分析' +
//             '的基础上总结出来的一种基于“寻找大显现、关注异常点”的矿压分析方法。'+
//             '该分析方法具有制图直观、操作方便、分析结果全面、客观等特点。';
          istr:='   三维曲面方法是山东科技大学宋振骐院士矿压技术分析团队在多年矿压分析' +
             '的基础上总结出来的一种基于“寻找大显现、关注异常点”的矿压分析方法。'+
             '该分析方法具有制图直观、操作方便、分析结果全面、客观等特点。';
        WriteText(istr,1);  AddReturn();
         istr:='   进行三维曲面方法分析要注意以下五个条件：';
        WriteText(istr,1); AddReturn();
         istr:='   第一：假设采煤工作面矿压数据构成的数据序列是基于时间轴连续的（也就是可以把变化的数据采集到）；';
        WriteText(istr,1); AddReturn();
         istr:='   第二：假设工作面倾斜方向等距离采集压力数据（也就是液压支架的支架间隔相等，' +
              '比如 间隔5架 即：采集第5，10,15,20….）；';
        WriteText(istr,1); AddReturn();
         istr:='   第三：假设工作面矿压数据分析以进刀为基本参照点（也就是在数据分析中，' +
              '必须设定以哪一个支架的进刀标识作为整个工作面进刀的基本参照）；';
        WriteText(istr,1);AddReturn();

         istr:='   第四：矿压显现判定以超过某一特定值为参考的，在一次选定的开采区间的分析中，该参考值无法改变'+
               '（对于工作面推进过程中，顶底板岩性变化较大的采煤工作面，液压支架压力值变化较大，部分区域压力值普' +
               '遍偏低或者偏高，这样需要缩小数据分析进刀数，即在选定分析区间内认为顶底板条件相对稳定）；';
        WriteText(istr,1); AddReturn();

         istr:='   第五：“寻找大显现、关注异常点”矿压显现分析要有一定的数据对照区间，最小进刀区间最好选择在50刀以上。';
        WriteText(istr,1); AddReturn();
    end;
end;

procedure TWordReport.Add_Third_Secents(inGZm: TGzm);
{ 其实是第四章}
var
  Str_Secents:String;
  tab:Table;
begin
   third_Tab_id:=0;
   Subject_Str.Clear ;
   Str_Secents:=intTostr(SencentId);
    with innWord do begin
      AlignLine(0); Addreturn();
      SetFont('宋体',16,true,false);
      SetHeading(Str_Secents+' 基于三维曲面分析法对矿压实时数据进行分析',1);// 章节
      SetFont('宋体',11,false,false);
      //前言
      Add_Third_QianYan;
      public_Basic.WriteMakeWordPercent(true,61);
      // 第三章 第一节
      Add_Third_one_Main(Str_Secents,inGZm);
//      //第二节 或者更多的节
      Add_Third_two_Main(Str_Secents,inGZm);

    end;
end;

procedure TWordReport.Add_Third_one_Main(P_Str: string; inGZm: TGzm);
var
 istr:string;
begin

     with innWord do begin
          // 第二节
         SetFont('宋体',14,false,false);
         SetHeading(P_Str+'.1 '+'采煤工作面矿压显现整体特征分析',2);// 章节
         istr:='    基于曲面的矿山压力分析的思想就是“寻找大显现、关注异常点”，'+
               '本次分析在对数据进行了多轮预判的基础上，得到了其矿压显现规律如下。';
         SetFont('宋体',12,False,False);
         WriteText(istr,1);  AddReturn();

         istr:='    本次矿压分析中，共提取矿压显现显著区域' +
             '【'+intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(10))+'】处、矿压显现明显区域'+
             '【'+intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(9))+'】处与局部矿压异常点'+
             '【'+intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(8)+iDwGrap.Auto_Judge_OldStep.GetComeStepCount(5)+
               iDwGrap.Auto_Judge_OldStep.GetComeStepCount(6))+ '】处 ' +
             '(详细数据见表'+P_Str+'.'+intToStr(Third_Tab_id+1)+'-'+P_Str+'.'+intToStr(Third_Tab_id+3)+')。' ;
         SetFont('宋体',12,False,False);
         WriteText(istr,1);  AddReturn();
          // 说明
         istr:='    关于数据分析的图形信息，请参考附录中图号X-'+IntToStr(Yu_Start_id)+'-'+'X-'+IntToStr(Yu_End_id)+ '。' +
              '本次数据分析分别对最大值、平均值、末阻力与瞬间压力值进行了迭代分析。';
         SetFont('宋体',12,False,False);
         WriteText(istr,1);  AddReturn();
         // 第一小节
         Add_Third_one_First(P_Str,inGZm);
         public_Basic.WriteMakeWordPercent(true,65);
     end ;



end;

procedure TWordReport.Add_Third_one_First(P_Str: string; inGZm: TGzm);
var
  tab:Table;
  R_Str,PathFile:String;
begin
    R_Str:=' ';
    with innWord do begin
         SetFont('宋体',12,false,false);
         SetHeading(P_Str+'.1.1 采煤工作面矿压显现显著整体特征分析',3);// 章节
         //
         R_Str:='    本次数据分析中，共提取矿压显现显著区域' +
             '【'+intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(10))+'】次如表' +
             P_Str+'-'+intToStr(Third_Tab_id+1)+ '所示：';
         SetFont('宋体',12,False,False);
         WriteText(R_Str,1);  AddReturn();
         // 表名
         SetFont('宋体',11,true,false);AlignLine(1);
         inc(third_Tab_id);
         SetHeading('表'+P_Str+'-'+intToStr(Third_Tab_id)+'【'+MainDataModule.WorkFace_Name+
                   '工作面】整体分析矿压显现显著数据表',4);
         ADd_Third_one_First_Table(P_Str,10);

         R_Str:='    备注：[动载系数]是指通报区域压力最大值与整个工作面压力平均值的比值；'+
                  '[均值系数]是指通报区域压力平均值与整个工作面压力平均值的比值； ' +
                  '[面积系数]是指通报区域面积值与所有显现区域平均面积的比值；' +
                  '[综合系数]是指通报区域的面积系数与均值系数的乘积。以后意义相同';
           SetFont('宋体',8,false,false) ; AlignLine(0); WriteText(R_Str,0);
         Addreturn();
         //
         SetFont('宋体',12,false,false);
         SetHeading(P_Str+'.1.2 采煤工作面矿压显现明显整体特征分析',3);// 章节

         R_Str:='    本次数据分析中，共提取' +
             '【'+intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(9))+'】次一般来压信息如' +
             P_Str+'-'+intToStr(Third_Tab_id+1)+ '所示：';
         SetFont('宋体',12,False,False);
         WriteText(R_Str,1);  AddReturn();

         SetFont('宋体',11,true,false);AlignLine(1);
         inc(third_Tab_id);
         SetHeading('表'+P_Str+'-'+intToStr(Third_Tab_id)+'【'+MainDataModule.WorkFace_Name+
                   '工作面】整体分析矿压显现明显数据表',4);
         ADd_Third_one_First_Table(P_Str,9);
         Addreturn();
          //
         SetFont('宋体',12,false,false);
         SetHeading(P_Str+'.1.3 采煤工作面局部矿压显现异常整体特征分析',3);// 章节
         //
         R_Str:='    本次数据分析中，共提取' +
             '【'+intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(8)+iDwGrap.Auto_Judge_OldStep.GetComeStepCount(5)+
               iDwGrap.Auto_Judge_OldStep.GetComeStepCount(6))+'】次局部矿压显现异常信息如' +
             P_Str+'-'+intToStr(Third_Tab_id+1)+ '所示：';
         SetFont('宋体',12,False,False);
         WriteText(R_Str,1);  AddReturn();

         SetFont('宋体',11,true,false);AlignLine(1);
         inc(third_Tab_id);
         SetHeading('表'+P_Str+'-'+intToStr(Third_Tab_id)+'【'+MainDataModule.WorkFace_Name+
                   '工作面】局部矿压显现异常数据表',4);
         ADd_Third_one_First_Table(P_Str,-1);

         Addreturn();
    end;
end;

procedure TWordReport.ADd_Third_one_First_Table(P_Str: string; Modify: integer);
var
  i,i_Row,N,come_c:integer;
  R_Str,t_str:string;
  tab:Table;
  Ex_Stepid:integer;
begin
      R_Str:=' ';
      with innWord do begin
           SetFont('宋体',11,false,false) ;
           AlignLine(0);
           Tab:=AddTable(8,1);
           setTableColumsWidth(Tab,1,25);  setTableColumsWidth(Tab,2,15);
           setTableColumsWidth(Tab,3,25);  setTableColumsWidth(Tab,4,15);
           setTableColumsWidth(Tab,5,25);  setTableColumsWidth(Tab,6,15);
           setTableColumsWidth(Tab,7,25);  setTableColumsWidth(Tab,8,15);
           //表头
           i_Row:=0; come_c:=0;
           for I := 0 to length(iDwGrap.Auto_Judge_OldStep.ExSteps)-1 do begin
              if Modify>0  then   begin
                 if iDwGrap.Auto_Judge_OldStep.ExSteps[i].ModifyData <> Modify  then
                    continue;
              end else  begin
                 if (iDwGrap.Auto_Judge_OldStep.ExSteps[i].ModifyData <> 5 ) and
                    (iDwGrap.Auto_Judge_OldStep.ExSteps[i].ModifyData <> 8 ) and
                    (iDwGrap.Auto_Judge_OldStep.ExSteps[i].ModifyData <> 6 ) then
                    continue;
              end;

              if not((iDwGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.EndDao>iDwGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.StartDao ) and
                 (iDwGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.EndSup>iDwGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.StartSup )) then
                     continue;
             // 把数据写入表格
             Add_Third_one_First_Table_Chlid(-1,iDwGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo,
                                             -1,-1,tab,come_c,i_Row);
           end;
           TableBorders(tab,1,1);
           MoveDown(1); MoveDown(1);
      end;

end;

procedure TWordReport.Add_Second_First(P_Str: string; inGZm: TGzm);
var
  tab:Table;
  i,Row_st,D_JIndao,N_C:integer;
  Di_Day:double;
  R_Str:String;
begin
    R_Str:=' '; N_C:=0;
    with innWord do begin

       AddReturn();
       SetFont('宋体',10,false,false) ;
       AlignLine(0);
       Tab:=AddTable(7,19);
       setTableColumsWidth(Tab,1,30);  setTableColumsWidth(Tab,2,15);
       setTableColumsWidth(Tab,3,25);  setTableColumsWidth(Tab,4,15);
       setTableColumsWidth(Tab,5,25);  setTableColumsWidth(Tab,6,20);
       setTableColumsWidth(Tab,7,20);
          // 第1行   工作面 总体数据情况
       TableCellMerge(Tab,1,1,7,1);
       SetFont('宋体',10,true,false) ; AlignLine(1); WriteText('矿压监测数据整体技术参数情况分析',0); Moveright(1);

        // 第2行
       SetFont('宋体',10,true,false) ; AlignLine(0); WriteText('数据分析时间',0); Moveright(1);
       SetFont('宋体',10,true,false) ; AlignLine(1); WriteText('开始',0); Moveright(1);
       SetFont('宋体',10,False,false) ; AlignLine(1);
                     WriteText(FormatDateTime('YYYY-MM-DD',iDWGrap.DataTimeAndFootAge.StartTime),0); Moveright(1);
       SetFont('宋体',10,true,false) ; AlignLine(1); WriteText('结束',0); Moveright(1);
       SetFont('宋体',10,False,false) ; AlignLine(1);
                     WriteText(FormatDateTime('YYYY-MM-DD',iDWGrap.DataTimeAndFootAge.EndTime),0); Moveright(1);
       SetFont('宋体',10,true,false) ; AlignLine(1); WriteText('历时(天)',0); Moveright(1);
       SetFont('宋体',10,False,false) ; AlignLine(1);
       Di_Day:= iDWGrap.DataTimeAndFootAge.EndTime-iDWGrap.DataTimeAndFootAge.StartTime;
                WriteText(IntToStr(round(Di_Day)),0); Moveright(1);
         // 第3行   刀
       SetFont('宋体',10,true,false) ; AlignLine(0); WriteText('数据分析进刀',0); Moveright(1);
       SetFont('宋体',10,true,false) ; AlignLine(1); WriteText('开始',0); Moveright(1);
       SetFont('宋体',10,False,false) ; AlignLine(1);
                     WriteText(IntToStr(iDWGrap.DataTimeAndFootAge.Graph_MinDao),0); Moveright(1);
       SetFont('宋体',10,true,false) ; AlignLine(1); WriteText('结束',0); Moveright(1);
       SetFont('宋体',10,False,false) ; AlignLine(1);
                     WriteText(IntToStr(iDWGrap.DataTimeAndFootAge.Graph_MaxDao),0); Moveright(1);
       SetFont('宋体',10,true,false) ; AlignLine(1); WriteText('跨度(刀)',0); Moveright(1);
       SetFont('宋体',10,False,false) ; AlignLine(1);
               D_JIndao:=iDWGrap.DataTimeAndFootAge.Graph_MaxDao-iDWGrap.DataTimeAndFootAge.Graph_MinDao +1;
                     WriteText(IntToStr(D_JIndao),0); Moveright(1);
          if D_JIndao >=80 then  begin
              inc(N_c);
              R_Str:=R_Str+'  ('+IntTostr(N_c)+') 数据进刀范围选择较好，有利于对矿压显现规律的判断。' +#13#10;
          end else if D_JIndao >=40 then  begin
              inc(N_c);
              R_Str:=R_Str+'  ('+IntTostr(N_c)+') 数据进刀范围选择较小，矿压显现规律的预测具有片面性。' +#13#10;
          end else begin
              inc(N_c);
              R_Str:=R_Str+'  ('+IntTostr(N_c)+') 数据进刀范围选择太小，不利于矿压显现规律的判断。' +#13#10;
              Subject_Str.Add('31'); { 矿压监测数据 整体技术参数分析}
              Subject_Str.Add('该工作面整体压力数据进刀范围选择太小，这样会影响来压规律的判断，建议选择在80刀范围以外。');
          end;

         // 第4行   进尺
       SetFont('宋体',10,true,false) ; AlignLine(0); WriteText('数据分析进尺',0); Moveright(1);
       SetFont('宋体',10,true,false) ; AlignLine(1); WriteText('开始',0); Moveright(1);
       SetFont('宋体',10,False,false) ; AlignLine(1);
                     WriteText(FormatFloat('0.00',iDWGrap.DataTimeAndFootAge.DownStartFootage),0); Moveright(1);
       SetFont('宋体',10,true,false) ; AlignLine(1); WriteText('结束',0); Moveright(1);
       SetFont('宋体',10,False,false) ; AlignLine(1);
                     WriteText(FormatFloat('0.00',iDWGrap.DataTimeAndFootAge.DownEndFootage),0); Moveright(1);
       SetFont('宋体',10,true,false) ; AlignLine(1); WriteText('跨度(米)',0); Moveright(1);
       SetFont('宋体',10,False,false) ; AlignLine(1);
                     WriteText(FormatFloat('0.00',iDWGrap.DataTimeAndFootAge.DownEndFootage-iDWGrap.DataTimeAndFootAge.DownStartFootage ),0); Moveright(1);
         // 第5行   支架总数
       TableCellMerge(Tab,2,5,3,5);
       SetFont('宋体',10,true,false) ; AlignLine(0); WriteText('综采支架数',0); Moveright(1);
       SetFont('宋体',10,False,false) ; AlignLine(1);
                    WriteText(IntTostr(iDWGrap.FGzm.SupEndNumber),0); Moveright(1);
       SetFont('宋体',10,FALSE,false) ; AlignLine(1);  WriteText('架',0); Moveright(1);
       SetFont('宋体',10,true,false) ; AlignLine(1);  WriteText('分析数据间隔',0); Moveright(1);
       SetFont('宋体',10,False,false) ; AlignLine(1);
            WriteText(IntToStr(iDwGrap.FGzm.RockPressAnalysis.ManulInput_Interval_support ),0); Moveright(1);
       SetFont('宋体',10,False,false) ; AlignLine(1);  WriteText('架',0); Moveright(1);
       if iDwGrap.FGzm.RockPressAnalysis.ManulInput_Interval_support < 3 then    begin
           inc(N_c);
           R_Str:=R_Str+'   ('+IntTostr(N_c)+') 支架数据太密，一方面加重图形刷新速度;' +
                  ' 另一方面，太密的数据不利于全局数据的分析，一般以间隔5架为最优。' +#13#10;
           Subject_Str.Add('31'); { 矿压监测数据 整体技术参数分析}
           Subject_Str.Add('对矿压数据进行全局分析时，没有必要把全部数据纳入分析，间隔5架左右效果最佳。');
       end;

        // 第6行   支架总数
        // 把数据拉过来
       ReportInputData.FillDataFromDataBase(inGZm.Gzmbh, -1,-1,
                                        iDwGrap.DataTimeAndFootAge.StartTime,
                                        iDwGrap.DataTimeAndFootAge.EndTime);
       TableCellMerge(Tab,2,6,4,6);   TableCellMerge(Tab,3,6,5,6);
       SetFont('宋体',10,true,false) ; AlignLine(0); WriteText('分析数据总量',0); Moveright(1);
       SetFont('宋体',10,False,false) ; AlignLine(1);
                    WriteText(IntToStr(Round(ReportInputData.TotalCount/10000/5))+'万条',0); Moveright(1);

       SetFont('宋体',10,False,false) ; AlignLine(0);  WriteText('说明:大约5秒钟一个数据',0); Moveright(1);
        // 第7行   支架总数
       TableCellMerge(Tab,2,7,5,7);
       SetFont('宋体',9,true,false) ; AlignLine(2); WriteText('其中:无效数据',0); Moveright(1);
       SetFont('宋体',10,False,false) ; AlignLine(1);
              WriteText(IntToStr(Round(ReportInputData.ReturnNotEddirctCount /10000/5))+
                        '万条(数值小于10MPa)',0); Moveright(1);
       SetFont('宋体',10,true,false) ; AlignLine(1); WriteText('占比(%)',0); Moveright(1);
       SetFont('宋体',10,False,false) ; AlignLine(1);
              WriteText(FormatFloat('0',ReportInputData.ReturnNotEffiectBl )+'%',0); Moveright(1);
        //
        if ReportInputData.ReturnNotEffiectBl > 8 then  begin
           inc(N_c);
           R_Str:=R_Str+'   ('+IntTostr(N_c)+') 导入的数据连续性较差，请加强对现场观测数据的管理。' +#13#10;
           Subject_Str.Add('31');
           Subject_Str.Add('数据分析区间内，监测数据连续性较差，下一步加强对矿压监测数据的管理。');
        end else  if ReportInputData.ReturnNotEffiectBl >4 then  begin
           inc(N_c);
           R_Str:=R_Str+'   ('+IntTostr(N_c)+') 导入的数据连续性一般，现场矿压观测管理还有改进的空间。' +#13#10;
        end else begin
           inc(N_c);
           R_Str:=R_Str+'   ('+IntTostr(N_c)+') 现场矿压数据保存良好，在线矿压设备运行状况整体优良。' +#13#10;
        end;

         // 第8行   支架总数
       TableCellMerge(Tab,1,8,7,8);
       SetFont('宋体',10,true,false) ; AlignLine(1); WriteText('依支架编号分区间进行矿压分析，区间划分情况',0); Moveright(1);
         // 第9行   支架总数
       TableCellMerge(Tab,1,9,2,9); TableCellMerge(Tab,2,9,5,9);
       SetFont('宋体',10,true,false) ; AlignLine(0); WriteText('区间划分数量',0); Moveright(1);
       SetFont('宋体',10,False,false) ; AlignLine(1);
           WriteText(IntTostr(iDwGrap.Auto_Judge_OldStep.PhaseNumber)  ,0); Moveright(1);

       SetFont('宋体',10,False,false) ; AlignLine(1);  WriteText('个',0); Moveright(1);
       Row_st:=10;
       for I := 0 to iDwGrap.Auto_Judge_OldStep.PhaseNumber-1 do  begin
            TableCellMerge(Tab,2,Row_st,3,Row_st);  TableCellMerge(Tab,4,Row_st,5,Row_st);
            SetFont('宋体',10,true,false) ; AlignLine(0); WriteText('第【'+IntToStr(i+1)+'】区间',0); Moveright(1);
            SetFont('宋体',10,true,false) ; AlignLine(0); WriteText('开始支编编号',0); Moveright(1);
            SetFont('宋体',10,False,false) ; AlignLine(1);
                     WriteText(IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].StartsupBh),0); Moveright(1);
            SetFont('宋体',10,true,false) ; AlignLine(0); WriteText('结束支架编号',0); Moveright(1);
            SetFont('宋体',10,False,false) ; AlignLine(1);
                     WriteText(IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].EndSupBh),0); Moveright(1);
            // 进入下一行
            inc( Row_st);
              // 把数据拉过来
            ReportInputData.FillDataFromDataBase(inGZm.Gzmbh,iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].StartsupBh,
                                        iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].EndSupBh,
                                        iDwGrap.DataTimeAndFootAge.StartTime,
                                        iDwGrap.DataTimeAndFootAge.EndTime);
            TableCellMerge(Tab,1,Row_st,2,Row_st);
            SetFont('宋体',9,true,false) ; AlignLine(2); WriteText('其中：数据总量',0); Moveright(1);
            SetFont('宋体',9,false,false) ; AlignLine(1); WriteText(IntToStr(Round(ReportInputData.TotalCount/10000/5))+'万条',0); Moveright(1);
            SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('有效量',0); Moveright(1);
            SetFont('宋体',9,false,false) ; AlignLine(1);
                 WriteText(IntToStr(Round(ReportInputData.ReturnEddirctCount/10000/5))+'万条',0); Moveright(1);
            SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('占比(%)',0); Moveright(1);
            SetFont('宋体',9,false,false) ; AlignLine(1);
                 WriteText(FormatFloat('0',ReportInputData.ReturnEffiectBl )+'%',0); Moveright(1);

            if ReportInputData.ReturnNotEffiectBl > 8 then  begin
               inc(N_c);
               R_Str:=R_Str+'   ('+IntTostr(N_c)+') 第【'+intToSTr(i+1)+'】区间矿压数据的连续性较差，请加强对现场观测数据的管理。' +#13#10;
               Subject_Str.Add('32');
               Subject_Str.Add('第【'+intToSTr(i+1)+'】区间(液压支架范围:'+IntTostr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].StartsupBh)
                                  +'-'+IntTostr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].StartsupBh)+'架)监测数据的连续性较差，请加强对矿压监测数据的管理。');
            end else  if ReportInputData.ReturnNotEffiectBl >4 then  begin
               inc(N_c);
               R_Str:=R_Str+'   ('+IntTostr(N_c)+') 第【'+intToSTr(i+1)+'】区间矿压数据的连续性一般，现场矿压观测管理还有改进的空间。' +#13#10;
            end;
            // 进入下一行
            inc( Row_st);
       end;
       MoveDown(1);
       TableBorders(tab,1,1);

       SetFont('宋体',12,false,false) ; AlignLine(0);
       WriteText('   备注:附录中图X-'+IntTostr(PinPutuid)+'集中展示了全工作面矿压数据频谱图，辅助显示了随机选取的12个支架的压力频谱图。',1);
       AddReturn();

       R_Str:='   通过表'+P_Str+'-1 的分析数据，对矿压监测的数据质量提出以下【'+IntTostr(N_c)+'】点看法：' +#13#10 + R_Str;
       SetFont('宋体',12,false,false) ; AlignLine(0);
       WriteText(R_Str,1);
       AddReturn();
    end;

end;

procedure TWordReport.Add_Second_First_Main (P_Str:string;inGZm: TGzm);
var
 istr:string;
begin

     with innWord do begin
         SetFont('宋体',14,false,false);
         SetHeading(P_Str+'.1 '+'采煤工作面矿压监测数据统计学特征分析',2);// 章节
         SetFont('宋体',12,False,False);
         istr:='    对选定区间内所有液压支架的监测数据进行技术分析，分析数据的质量及相关参数，见表'+P_Str+'.1所示。';
         WriteText(istr,1); AddReturn();

         SetFont('宋体',11,true,false);AlignLine(1);
         WriteText('表'+P_Str+'.1 矿压监测数据整体技术参数分析表',0);
          // 第三章 第一节  第一小节
         Add_Second_First(P_Str,inGZm);


     end ;




end;

procedure TWordReport.Add_Second_QianYan;
var
 istr:string;
begin
    with innWord do begin
        SetFont('宋体',12,False,False);

        istr:='   本节提到的统计分析方法主要指统计学中的数量关系分析方法。';
        WriteText(istr,1);  AddReturn();
         istr:='   数量关系分析方法是运用统计学中论述的方法对矿压数据的数量表现， '  +
               '包括数据的规模、水平、速度、结构比例、数据之间的联系进行分析的方法。 ' +
               '如对比分析法、平均和变异分析法、综合评价分析法、结构分析法、平衡分析法、动态分析法、因素分析法、相关分析法等。：';
        WriteText(istr,1); AddReturn();
         istr:='   本章节主要对实时矿压数据进行了均值、方差、标准差、中位数、众数、峰度、偏度、置信区间等参数进行分析，'+
               '利用统计学规律寻找矿压数据之间的内在关系';
        WriteText(istr,1); AddReturn();

    end;

end;

procedure TWordReport.Add_Second_Two_Table_2(P_Str: string; inGZm: TGzm;phaseNumber:integer);
var
  k,Sub_id,iRow:integer;
  Tab:Table;
  Str_Out,istr:string;
begin
   {ChangeThreeArrayContourGrid}
    with innWord do begin //
         SetFont('宋体',12,False,False);
         inc(Second_Tab_id);
         if iDWGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array_Count< 1 then  begin
            istr:='    在该区间没有检索到明显的来压信息。';
            WriteText(istr,1); AddReturn();
            exit;
         end;
         istr:='    对表'+P_Str+'-'+IntTostr(Second_Tab_id-1)+'数据进行深层矿压参数判定'+
               '结果如表'+P_Str+'-'+IntTostr(Second_Tab_id) +'所示';
         WriteText(istr,1); AddReturn();

         SetFont('宋体',11,true,false);AlignLine(1);
         SetHeading('表'+P_Str+'-'+IntTostr(Second_Tab_id)+' 第'+Public_Basic.GetChineseNumber(phaseNumber+1)+'区间【'+
                    IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].StartsupBh) +'-'+
                    IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].EndSupBh) +'】号支架矿压特征分析结果表',4);
         SetFont('宋体',10,false,false) ;
         AlignLine(0);
         iRow:=3;
         Tab:=AddTable(11,iRow);
         setTableColumsWidth(Tab,1,15);  setTableColumsWidth(Tab,2,15);
         setTableColumsWidth(Tab,3,15);  setTableColumsWidth(Tab,4,15);
         setTableColumsWidth(Tab,5,15);  setTableColumsWidth(Tab,6,15);
         setTableColumsWidth(Tab,7,15);  setTableColumsWidth(Tab,8,15);
         setTableColumsWidth(Tab,9,15);  setTableColumsWidth(Tab,10,15);
          // 合并单元格

         TableCellMerge(Tab,7,1,11,1);
         TableCellMerge(Tab,1,1,6,1);
         TableCellMerge(Tab,9,2,11,2);
         TableCellMerge(Tab,7,2,8,2);
         TableCellMerge(Tab,4,2,6,2);
         TableCellMerge(Tab,2,2,3,2);



         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('来压步距信息',0); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('显著来压步距信息',0); Moveright(1); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('开始',0); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('结束',0); Moveright(1);

         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('开始',0); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('结束',0); Moveright(1);


         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('序号',0); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('进刀',0); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('进尺m',0); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('进刀',0); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('进尺m',0); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('距离m',0); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('进刀',0); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('进尺m',0); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('进刀',0); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('进尺m',0); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('距离m',0); Moveright(1);

         for k := 0 to   iDWGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array_Count -1 do  begin
//             insertRow(Tab,0,1);inc(iRow); MoveDown(1);
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(intTostr(k+1),0);  Moveright(1);
             SetFont('宋体',9,false,false) ; AlignLine(1); //开始进刀
                WriteText(FormatFloat('0',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_Start_JinD),0); Moveright(1);
              SetFont('宋体',9,false,false) ; AlignLine(1);  //开始进尺
                WriteText(FormatFloat('0.0',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_Start_FG),0); Moveright(1);
              SetFont('宋体',9,false,false) ; AlignLine(1);  //结束进刀
                WriteText(FormatFloat('0',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_End_JinD),0); Moveright(1);
             SetFont('宋体',9,false,false) ; AlignLine(1);  //结束进尺
                WriteText(FormatFloat('0.0',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_End_FG),0); Moveright(1);
             SetFont('宋体',9,false,false) ; AlignLine(1);  //距离差值
                WriteText(FormatFloat('0.0',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_End_FG -
                             iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_Start_FG),0); Moveright(1);

             SetFont('宋体',9,false,false) ; AlignLine(1); //显著开始进刀
                WriteText(FormatFloat('0',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_U_st_JinD),0); Moveright(1);
             SetFont('宋体',9,false,false) ; AlignLine(1);  //显著开始进尺
                WriteText(FormatFloat('0.0',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_U_st_FG),0); Moveright(1);

             SetFont('宋体',9,false,false) ; AlignLine(1);  //显著结束进刀
                WriteText(FormatFloat('0',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_U_Ed_JinD),0); Moveright(1);
             SetFont('宋体',9,false,false) ; AlignLine(1);  //显著结束进尺
                WriteText(FormatFloat('0.0',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_U_Ed_FG),0); Moveright(1);
             SetFont('宋体',9,false,false) ; AlignLine(1);  //显著距离差值
                WriteText(FormatFloat('0.0',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_U_Ed_FG -
                             iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_U_st_FG),0);Moveright(1);

         end;

          // 跳出单元格
         MoveDown(1);
         TableBorders(tab,1,1);
         AddReturn();

    end;
end;

procedure TWordReport.Add_Second_Two_Jielun(P_Str: string; inGZm: TGzm);
var
  i,k,Jie_id:integer;
  istr:string;
  V_count:integer;
  AGV_Dao,AGV_JinChi,T_A_D,T_A_C:double;
  Totalcount:integer;
begin
  with innWord do begin //
      SetFont('宋体',12,False,False);
      istr:='   通过前面利用统计学的分析方法进行分析，该工作面实际开采过程中矿压情况如下：';
      WriteText(istr,1);  AddReturn();
      Jie_id:=0;
      T_A_D:=0;T_A_C:=0; V_count:=0;  Totalcount:=0;
      for I := 0 to iDwGrap.Auto_Judge_OldStep.PhaseNumber-1 do  begin
         if iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].Step_Array_Count>0 then  begin
            inc(Jie_id);
            istr:='   ('+intTostr(Jie_id)+') 第'+Public_Basic.GetChineseNumber(i+1)+'区间【'+IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].StartsupBh) +'-'+
                  IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].EndSupBh) +'】号支架经历了'+
                  intTostr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].Step_Array_Count) +'次运动周期，';
            AGV_Dao:=0;AGV_JinChi:=0;
            for k := 0 to   iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].Step_Array_Count -1 do  begin
                AGV_Dao:=AGV_Dao+ iDwGrap.Auto_Judge_OldStep.PhaseSteps[i].Step_Array[k].Get_End_JinD -
                             iDwGrap.Auto_Judge_OldStep.PhaseSteps[i].Step_Array[k].Get_Start_JinD;
                AGV_JinChi:=AGV_JinChi+iDwGrap.Auto_Judge_OldStep.PhaseSteps[i].Step_Array[k].Get_End_FG -
                             iDwGrap.Auto_Judge_OldStep.PhaseSteps[i].Step_Array[k].Get_Start_FG;
                inc(Totalcount);
            end;
            AGV_Dao:=AGV_Dao/iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].Step_Array_Count;
            AGV_JinChi:=AGV_JinChi/iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].Step_Array_Count;
            inc(V_count);
            T_A_D:=T_A_D+AGV_Dao;
            T_A_C:=T_A_C+AGV_JinChi;
            istr:=istr+'运动周期平均进刀为：'+FormatFloat('0.00' , AGV_Dao)+'刀，平均进尺为：'+
                  FormatFloat('0.00' , AGV_JinChi)+'米';
            WriteText(istr,1);  AddReturn();
         end else begin
           inc(Jie_id);
           istr:='   ('+intTostr(Jie_id)+') 第'+Public_Basic.GetChineseNumber(i+1)+'区间【'+IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].StartsupBh) +'-'+
                  IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].EndSupBh) +'】号支架没有感应到明细的周期运动。';
           WriteText(istr,1);  AddReturn();
         end;
      end;

      if V_count>0 then begin
          inc(Jie_id);
          istr:='   ('+intTostr(Jie_id)+') 利用统计学分析方法分析工作面在'+
                 FormatFloat('0' ,iDwGrap.DataTimeAndFootAge.Graph_MinDao) +'刀到' + FormatFloat('0' ,iDwGrap.DataTimeAndFootAge.Graph_MaxDao)+
                 '刀之间的压力数据，感应到明显压力显现【'+intTostr(Totalcount)+'】次，平均进刀为' +FormatFloat('0.00' , T_A_D/V_count)+'刀，平均进尺为：'+
                  FormatFloat('0.00' , T_A_C/V_count)+'米';
          WriteText(istr,1);  AddReturn();
      end;
  end;
end;

procedure TWordReport.Add_Second_Two_Table_1(P_Str: string; inGZm: TGzm;phaseNumber:integer);
var
  k,Sub_id:integer;
  Tab:Table;
  Str_Out,istr:string;
begin
   {ChangeThreeArrayContourGrid}
    with innWord do begin
//
         AddReturn();
         SetFont('宋体',12,False,False);
         inc(Second_Tab_id);
         istr:='    表'+P_Str+'-'+IntTostr(Second_Tab_id)+'是对第【'+IntTostr(phaseNumber+1)+'】区域的数据'+
               '进行统计学特征分析。';
         WriteText(istr,1); AddReturn();

         SetFont('宋体',11,true,false);AlignLine(1);
         SetHeading('表'+P_Str+'-'+IntTostr(Second_Tab_id)+' 第'+Public_Basic.GetChineseNumber(phaseNumber+1)+'区间【'+
                    IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].StartsupBh) +'-'+
                    IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].EndSupBh) +'】号支架统计学特征分析',4);
         SetFont('宋体',10,false,false) ;
         AlignLine(0);
         Tab:=AddTable(6,18);
         setTableColumsWidth(Tab,1,30);  setTableColumsWidth(Tab,2,25);
         setTableColumsWidth(Tab,3,25);  setTableColumsWidth(Tab,4,25);
         setTableColumsWidth(Tab,5,25);  setTableColumsWidth(Tab,6,25);
         //第一行
         SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('区间编号',0); Moveright(1);
                SetFont('宋体',9,False,false) ; AlignLine(1); WriteText(InttoStr(phaseNumber+1),0); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('开始支架编号',0); Moveright(1);
                SetFont('宋体',9,False,false) ; AlignLine(1);
                WriteText(IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].StartsupBh),0); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('结束支架编号',0); Moveright(1);
                SetFont('宋体',9,False,false) ; AlignLine(1);
                WriteText(IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].EndSupBh),0); Moveright(1);
         // 第二行
         TableCellMerge(Tab,1,2,6,2); Moveright(1);
         //第三行
         //加入表头
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('项目名称',0); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('循环最大值',0); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('循环平均值',0); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('循环初撑力',0); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('循环末阻力',0); Moveright(1);
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('同一时刻值',0); Moveright(1);
         // 下面的列数(从第四行起， 第一列的 数据）
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('平均数',0); MoveDown(1);   // 第4 行
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('标准误差',0); MoveDown(1);  // 第5 行
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('中位数',0); MoveDown(1);  // 第6 行
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('众数',0); MoveDown(1);    // 第7 行
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('标准差',0); MoveDown(1);  // 第8 行
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('方差',0); MoveDown(1);   // 第9 行
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('峰度',0); MoveDown(1);   // 第10 行
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('偏度',0); MoveDown(1);   // 第11 行
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('区间',0); MoveDown(1);   // 第12行
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('最小值',0); MoveDown(1);   // 第13 行
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('最大值',0); MoveDown(1);   // 第14 行
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('求和',0); MoveDown(1);     // 第15行
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('观测数',0); MoveDown(1);   // 第16 行
         SetFont('宋体',9,true,false) ; AlignLine(1); WriteText('置信度(95.0%)',0);  // 第17 行
         // 数据分析
         Str_Out:=''; Sub_id:=0;
         for k := 0 to 4 do   begin // 五种数据类型
             MoveRight(1);  MoveUp(13);
             iDwGrap.ChangeThreeArrayContourGrid(iDwGrap.ColorValue.UnitType ,K);
             if iDwGrap.ColorValue.UnitType =1 then  begin
                iDwGrap.Auto_Judge_OldStep.CalCulatePhaseStatistical_Data(iDwGrap.MyContourDoubleGrid,iDwGrap.FilledContourData,1);
             end else begin
                iDwGrap.Auto_Judge_OldStep.CalCulatePhaseStatistical_Data(iDwGrap.MyContourDoubleGrid,iDwGrap.FilledContourData,10);
             end;
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_AGV),0); MoveDown(1);   // 第4 行
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_Standard_erro),0); MoveDown(1);   // 第5 行
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_Median),0); MoveDown(1);   // 第6 行
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_Model),0); MoveDown(1);   // 第7 行
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_Standard_Deviation),0); MoveDown(1);   // 第8 行
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_Variance),0); MoveDown(1);   // 第9 行
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_peakedness),0); MoveDown(1);   // 第10 行
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_bs),0); MoveDown(1);   // 第11 行
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_max_Min),0); MoveDown(1);   // 第12 行
              SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_Min_Data),0); MoveDown(1);   // 第13 行
              SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_Max_Data),0); MoveDown(1);   // 第14 行
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_ToTal),0); MoveDown(1);   // 第15 行
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(IntTostr(iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_Count),0); MoveDown(1);   // 第16 行
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_ZXQD95),0);   // 第17 行

         end;
         // 第18行
          TableCellMerge(Tab,1,18,6,18); MoveDown(1);
          SetFont('宋体',9,False,false) ; AlignLine(0);
                WriteText(Add_Second_Two_Table_fulu_Bmp(phaseNumber),0);
          // 跳出单元格
          MoveDown(1); TableBorders(tab,1,1);
          AddReturn();

    end;
end;

function TWordReport.Add_Second_Two_Table_fulu_Bmp(PhaseNumber:Integer):string;
{
   ComeStep  False  代表是前面的 统计数字，没有来压的像个信息 主要实现  频谱图  压力基本曲线图
             true   代表是后面的  来压分析数据  要显示 来压的相关信息， 主要实现来压步距曲线
}
var
   PathFile,iStr:String;
begin
   // 把附录的图表 给添加了
    iStr:='   备注：';
    innword.createBookMark('tempPosition' );
    try
       //打开直方图模式
         CreateBand_Bar(ExHandle,'',0,0,2);
          iDwGrap.BarMarks.Fromcontour:=true;;//代表从云图中传递数据
          if Assigned(Form_Band_Bar) then  begin
              Form_Band_Bar.InitForm(iDwGrap) ;
              iDwGrap.Auto_Judge_OldStep.PhaseSteps[PhaseNumber].SetSupportInval_ExUsed(iDwGrap.FGzm.RockPressAnalysis.ManulInput_Interval_support) ;
              iDwGrap.GraphClass.SupportList :=iDwGrap.Auto_Judge_OldStep.PhaseSteps[PhaseNumber].returnSupportList ;
              Form_Band_Bar.SetOpenFormVar(iDwGrap.GraphClass.SupportList,
                                    true, //外部传过来数据
                                    true// 是否打开工具菜单
                                    );

          end;
         FormPressTool.Close ;
         Form_Band_Bar.RefreshBarSeries(PhaseNumber);
         Form_Band_Bar.Main_panel.Refresh;
         PathFile:=Form_Band_Bar.AutoSaveOnesupportOneBMP(PhaseNumber+1);
         ChangePictureWidth(PathFile);
         if PathFile<>'' then  begin
            inc(fuLu_Tu_id);
            Add_FuLuTu(0,fuLu_Tu_id,
                  '【'+MainDataModule.WorkFace_Name+'工作面】第'+Public_Basic.GetChineseNumber(PhaseNumber+1)+
                   '区间各液压支架压力频谱图', '',PathFile);
            iStr:=iStr+'压力频谱图见附录图 X-'+IntToStr(fuLu_Tu_id) +',';
         end;
         Form_Band_Bar.Close ;


     // 打开 曲线图 绘制界面
        CreateLineGraph(ExHandle,'',0,0,2);
        iDwGrap.GraphClass.CycleDataEfficient:=False;//代表从云图中传递数据
        Form_LineGraph.SetOpenFormVar(Form_ContourGraph.DrawGzm,
                                      iDwGrap.Auto_Judge_OldStep.PhaseSteps[PhaseNumber].returnSupportList,
                                      true, // 是否有步距信息
                                      true// 是否打开工具菜单
                                      );
        FormPressTool.Close ;
        Form_LineGraph.Main_Line_DrawClass.GraphClass.YAxisType :=5; // 六个坐标轴
        Form_LineGraph.RefreshMyGraphChart(true);
        PathFile:=Form_LineGraph.SaveChartToBmp;
        ChangePictureWidth(PathFile);
         if PathFile<>'' then  begin
            inc(fuLu_Tu_id);
            Add_FuLuTu(0,fuLu_Tu_id,
                  '【'+MainDataModule.WorkFace_Name+'工作面】第'+Public_Basic.GetChineseNumber(PhaseNumber+1)+
                   '区间液压支架压力曲线图(6Y)', '(6个Y坐标轴，每个坐标轴显示两个支架的压力曲线)',PathFile);
            iStr:=iStr+'压力曲线图（六坐标轴）见附录图 X-'+IntToStr(fuLu_Tu_id) +',';
         end;

       Form_LineGraph.Main_Line_DrawClass.GraphClass.YAxisType :=1;
       Form_LineGraph.DrawLineGraph.NextDataDisp:=0; // 第一屏
       Form_LineGraph.DrawLineGraph.MarkerStep:=FALSE;
       Form_LineGraph.RefreshMyGraphChart(true);
       PathFile:=Form_LineGraph.SaveChartToBmp;
       ChangePictureWidth(PathFile);
       if PathFile<>'' then  begin
          inc(fuLu_Tu_id);
          Add_FuLuTu(0,fuLu_Tu_id,
                '【'+MainDataModule.WorkFace_Name+'工作面】第'+Public_Basic.GetChineseNumber(PhaseNumber+1)+
                 '区间液压支架压力曲线图（1）', '(四个坐标轴，每个坐标轴显示一条曲线，第一批)',PathFile);
          iStr:=iStr+'压力曲线图1见附录图 X-'+IntToStr(fuLu_Tu_id) +',';
       end;
       //
       Form_LineGraph.DrawLineGraph.NextDataDisp:=1; // 第二屏
       Form_LineGraph.DrawLineGraph.MarkerStep:=FALSE;
       Form_LineGraph.RefreshMyGraphChart(true);
       PathFile:=Form_LineGraph.SaveChartToBmp;
       ChangePictureWidth(PathFile);
       if PathFile<>'' then  begin
          inc(fuLu_Tu_id);
          Add_FuLuTu(0,fuLu_Tu_id,
                '【'+MainDataModule.WorkFace_Name+'工作面】第'+Public_Basic.GetChineseNumber(PhaseNumber+1)+
                  '区间液压支架压力曲线图（2）', '(四个坐标轴，每个坐标轴显示一条曲线，第二批)',PathFile);
          iStr:=iStr+'压力曲线图2见附录图 X-'+IntToStr(fuLu_Tu_id) +',';
       end;

       Form_LineGraph.DrawLineGraph.NextDataDisp:=2; // 第三屏
       Form_LineGraph.DrawLineGraph.MarkerStep:=FALSE;
       Form_LineGraph.RefreshMyGraphChart(true);
       PathFile:=Form_LineGraph.SaveChartToBmp;
       ChangePictureWidth(PathFile);
       if PathFile<>'' then  begin
          inc(fuLu_Tu_id);
          Add_FuLuTu(0,fuLu_Tu_id,
                '【'+MainDataModule.WorkFace_Name+'工作面】第'+Public_Basic.GetChineseNumber(PhaseNumber+1)+
                '区间液压支架压力曲线图（3）', '(四个坐标轴，每个坐标轴显示一条曲线，第三批)',PathFile);
          iStr:=iStr+'压力曲线图3见附录图X-'+IntToStr(fuLu_Tu_id) +'。';
       end;
       Form_LineGraph.Close ;


    finally

    end;
    // 书签再回来
    innword.GotoBookMark('tempPosition');
   //删除该书签
    innword.DeleteBookMark('tempPosition');
    Result:=iStr;
end;

procedure TWordReport.Add_Third_two_Main(P_Str: string; inGZm: TGzm);
var
  istr,PathFile:string;
  P_c,P,ComeStep:integer;
  th_id:integer;
begin
    P_c:=1;
    with innWord do begin
         for P := 0 to iDWGrap.Auto_Judge_OldStep.PhaseNumber -1 do  begin
             inc(P_c);
             SetFont('宋体',14,false,false);
             SetHeading(P_Str+'.'+IntTostr(P_c )+' '+'采煤工作面矿压显现' +
                    '第【'+Public_Basic.GetChineseNumber(P+1)+'】区间特征分析',2);// 章节
              istr:='    为使矿压分析具有更强的针对性，按照工作面矿压显现规律的差异，把工作面按液压支架编号划分为' +
                    intTostr(iDWGrap.Auto_Judge_OldStep.PhaseNumber) +'个数据区间，各数据区间独立分析其矿压显现规律。' ;
             SetFont('宋体',12,False,False);
             WriteText(istr,1);  AddReturn();
             istr:='    本区间为划分的第'+Public_Basic.GetChineseNumber(P+1)+'个区间，该区间的液压支架编号范围为第【'+
                IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].StartsupBh ) +'】架到第【'+
                IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].EndSupBh ) +'】架。';
             SetFont('宋体',12,False,False);
             WriteText(istr,1);  AddReturn();
             //
             th_id:=0;
             ComeStep:=iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(10);
             if ComeStep>0  then   begin
                 inc(th_id);
                 SetFont('宋体',12,false,false);
                 SetHeading(P_Str+'.'+IntTostr(P_c )+'.'+IntTostr(th_id)+' 第【'+Public_Basic.GetChineseNumber(P+1)+
                           '】区间矿压显现显著区域分析',3);// 章节
                 istr:='    本区间数据分析，共得到矿压显现显著区域【'+IntTostr(ComeStep)+'】处，具体信息见表'+
                      P_Str+'-'+intToStr(Third_Tab_id+1)+ '。';
                 SetFont('宋体',12,False,False);
                 WriteText(istr,1);  AddReturn();

                 SetFont('宋体',11,true,false);AlignLine(1);
                 inc(third_Tab_id);
                 SetHeading('表'+P_Str+'-'+intToStr(Third_Tab_id)+' 第【'+Public_Basic.GetChineseNumber(P+1)+
                           '】区间矿压显现显著区域信息表',4);
                 Add_Third_two_one(p,P_c,10,P_Str,inGZm);
             end;
            //----------
             ComeStep:=iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(9);
             if ComeStep>0  then   begin
                 inc(th_id);
                 SetFont('宋体',12,false,false);
                 SetHeading(P_Str+'.'+IntTostr(P_c )+'.'+IntTostr(th_id)+' 第【'+Public_Basic.GetChineseNumber(P+1)+
                           '】区间矿压显现明显区域分析',3);// 章节
                 istr:='    本区间数据分析，共得到矿压显现明显区域【'+IntTostr(ComeStep)+'】处，具体信息见表'+
                      P_Str+'-'+intToStr(Third_Tab_id+1)+ '。';
                 SetFont('宋体',12,False,False);
                 WriteText(istr,1);  AddReturn();

                 SetFont('宋体',11,true,false);AlignLine(1);
                 inc(third_Tab_id);
                 SetHeading('表'+P_Str+'-'+intToStr(Third_Tab_id)+' 第【'+Public_Basic.GetChineseNumber(P+1)+
                           '】区间矿压显现明显区域信息表',4);
                  Add_Third_two_one(p,P_c,9,P_Str,inGZm);
             end;
            //----------
             ComeStep:=iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(8)+
                       iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(5)+
                       iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(6);
             if ComeStep>0  then   begin
                 inc(th_id);
                 SetFont('宋体',12,false,false);
                 SetHeading(P_Str+'.'+IntTostr(P_c )+'.'+IntTostr(th_id)+' 第【'+Public_Basic.GetChineseNumber(P+1)+
                           '】区间局部矿压异常区域分析',3);// 章节
                 istr:='    本区间数据分析，共得到局部矿压异常信息【'+IntTostr(ComeStep)+'】处，具体信息见表'+
                      P_Str+'-'+intToStr(Third_Tab_id+1)+ '。';
                 SetFont('宋体',12,False,False);
                 WriteText(istr,1);  AddReturn();

                 SetFont('宋体',11,true,false);AlignLine(1);
                 inc(third_Tab_id);
                 SetHeading('表'+P_Str+'-'+intToStr(Third_Tab_id)+' 第【'+Public_Basic.GetChineseNumber(P+1)+
                           '】区间局部矿压异常区域信息表',4);
                 Add_Third_two_one(p,P_c,-1,P_Str,inGZm);
             end;

              //----------
             ComeStep:=iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(30) +
                       iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(27);
             if ComeStep>0  then   begin
                 inc(th_id);
                 SetFont('宋体',12,false,false);
                 SetHeading(P_Str+'.'+IntTostr(P_c )+'.'+IntTostr(th_id)+' 第【'+Public_Basic.GetChineseNumber(P+1)+
                           '】区间未采区域矿压显现预测分析',3);// 章节
                 ComeStep:=iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(30);
                 if ComeStep > 0 then  begin
                     istr:='    利用矿山压力理，对第'+Public_Basic.GetChineseNumber(P+1)+'区间顶板运动情况进行预测分析， ' +
                           '系统预测矿压显现显著区域【'+IntTostr(ComeStep)+'】处息，具体信息见表'+
                          P_Str+'-'+intToStr(Third_Tab_id+1)+ ',图形信息见图X-'+IntTostr(4)+'（图中红色区间为预测矿压显现显著区域，'+
                          ' 黄色区间为预测矿压显现明显区域）。';
                     SetFont('宋体',12,False,False);
                     WriteText(istr,1);  AddReturn();

                     SetFont('宋体',11,true,false);AlignLine(1);
                     inc(third_Tab_id);
                     SetHeading('表'+P_Str+'-'+intToStr(Third_Tab_id)+' 第【'+Public_Basic.GetChineseNumber(P+1)+
                           '】区间未采区域矿压显现显著预测信息表',4);
                     AddReturn();
                     Add_Third_two_one(p,P_c,30,P_Str,inGZm);
                 end;

                 ComeStep:=iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(27);
                 if ComeStep > 0 then  begin
                     istr:='    利用矿山压力理论，对第'+Public_Basic.GetChineseNumber(P+1)+'区间顶板运动情况进行预测分析， ' +
                           '系统预测矿压显现明显区域【'+IntTostr(ComeStep)+'】处，具体信息见表'+
                          P_Str+'-'+intToStr(Third_Tab_id+1)+ '。';
                     SetFont('宋体',12,False,False);
                     WriteText(istr,1);  AddReturn();

                     SetFont('宋体',11,true,false);AlignLine(1);
                     inc(third_Tab_id);
                     SetHeading('表'+P_Str+'-'+intToStr(Third_Tab_id)+' 第【'+Public_Basic.GetChineseNumber(P+1)+
                           '】区间未采区域矿压显现明显预测信息表',4);
                     AddReturn();
                     Add_Third_two_one(p,P_c,27,P_Str,inGZm);
                 end;
             end;

            SetFont('宋体',12,false,false);AlignLine(0);
            WriteText( Add_Third_two_Main_Chlid_Add_fulu_Bmp(p) ,1);
            AddReturn();
            public_Basic.WriteMakeWordPercent(true,65+5*p);
         end;
    end;
end;

procedure TWordReport.Add_Third_two_one(phaseNumber,P_c,modify: integer;
  P_Str: string; inGZm: TGzm);
var
  i,i_Row,come_c:integer;
  tab:Table;
begin
    with innWord do begin
       SetFont('宋体',11,false,false) ;
       AlignLine(0);
       Tab:=AddTable(8,1);
       setTableColumsWidth(Tab,1,25);  setTableColumsWidth(Tab,2,15);
       setTableColumsWidth(Tab,3,25);  setTableColumsWidth(Tab,4,15);
       setTableColumsWidth(Tab,5,25);  setTableColumsWidth(Tab,6,15);
       setTableColumsWidth(Tab,7,25);  setTableColumsWidth(Tab,8,15);
           //表头
       i_Row:=0; come_c:=0;
       for I := 0 to high(iDWGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Steps) do  begin
              if Modify>0  then   begin
                 if iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Steps[i].ModifyData <> Modify  then
                    continue;
              end else  begin
                 if (iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Steps[i].ModifyData <> 5 ) and
                    (iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Steps[i].ModifyData <> 8 ) and
                    (iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Steps[i].ModifyData <> 6 ) then
                    continue;
              end;

              if not((iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Steps[i].EndDao>iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Steps[i].StartDao ) and
                 (iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Steps[i].EndSup>iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Steps[i].StartSup )) then
                     continue;
             // 把数据写入表格
             Add_Third_one_First_Table_Chlid(phaseNumber+1,iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Steps[i],
                                            iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].StartsupBh,
                                            iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].EndSupBh,
                                            tab,come_c,i_Row);
       end;
       TableBorders(tab,1,1);
       MoveDown(1); MoveDown(1);


    end;
end;

function TWordReport.Add_Third_two_Main_Chlid_Add_fulu_Bmp(
  PhaseNumber: Integer): string;
var
   PathFile,iStr:String;
begin
   // 把附录的图表 给添加了
    iStr:='   备注：';
    innword.createBookMark('tempPosition' );
    try

     // 打开 曲线图 绘制界面
        CreateLineGraph(ExHandle,'',0,0,2);
        iDwGrap.GraphClass.CycleDataEfficient:=False;//代表从云图中传递数据
        Form_LineGraph.SetOpenFormVar(Form_ContourGraph.DrawGzm,
                                      iDwGrap.Auto_Judge_OldStep.PhaseSteps[PhaseNumber].returnSupportList,
                                      true, // 是否有步距信息
                                      true// 是否打开工具菜单
                                      );
        FormPressTool.Close ;
        Form_LineGraph.Main_Line_DrawClass.GraphClass.YAxisType :=4; // 4个坐标轴
        Form_LineGraph.DrawLineGraph.MarkerStep:=true;
        Form_LineGraph.RefreshMyGraphChart(true);
        PathFile:=Form_LineGraph.SaveChartToBmp;
         if PathFile<>'' then  begin
            inc(fuLu_Tu_id);
            ChangePictureWidth(PathFile);
            Add_FuLuTu(0,fuLu_Tu_id,
                  '【'+MainDataModule.WorkFace_Name+'工作面】第'+Public_Basic.GetChineseNumber(PhaseNumber+1)+
                   '区间液压支架矿压显现标注图（4Y）', '(四个坐标轴，每个坐标轴显示显示三条曲线)',PathFile);
            iStr:=iStr+'矿压显现标注图（四坐标轴）见附录图X-'+IntToStr(fuLu_Tu_id) +',';
         end;

       Form_LineGraph.Main_Line_DrawClass.GraphClass.YAxisType :=1;
       Form_LineGraph.DrawLineGraph.NextDataDisp:=0; // 第一屏
       Form_LineGraph.DrawLineGraph.MarkerStep:=true;
       Form_LineGraph.RefreshMyGraphChart(true);
       PathFile:=Form_LineGraph.SaveChartToBmp;
       if PathFile<>'' then  begin
          inc(fuLu_Tu_id);
          ChangePictureWidth(PathFile);
          Add_FuLuTu(0,fuLu_Tu_id,
                '【'+MainDataModule.WorkFace_Name+'工作面】第'+Public_Basic.GetChineseNumber(PhaseNumber+1)+
                '区间矿压显现标注图（1）', '(四个坐标轴，每个坐标轴显示一条曲线，第一批)',PathFile);
          iStr:=iStr+'矿压显现标注图1见附录图X-'+IntToStr(fuLu_Tu_id) +'。';
       end;
       //
       Form_LineGraph.DrawLineGraph.NextDataDisp:=1; // 第二屏
       Form_LineGraph.DrawLineGraph.MarkerStep:=true;
       Form_LineGraph.RefreshMyGraphChart(true);
       PathFile:=Form_LineGraph.SaveChartToBmp;
       if PathFile<>'' then  begin
          inc(fuLu_Tu_id);
          ChangePictureWidth(PathFile);
          Add_FuLuTu(0,fuLu_Tu_id,
                '【'+MainDataModule.WorkFace_Name+'工作面】第'+Public_Basic.GetChineseNumber(PhaseNumber+1)+
                 '区间矿压显现标注图（2）', '(四个坐标轴，每个坐标轴显示一条曲线，第二批)',PathFile);
           iStr:=iStr+'矿压显现标注图2见附录图X-'+IntToStr(fuLu_Tu_id) +';';
       end;

       Form_LineGraph.DrawLineGraph.NextDataDisp:=2; // 第三屏
       Form_LineGraph.DrawLineGraph.MarkerStep:=true;
       Form_LineGraph.RefreshMyGraphChart(true);
       PathFile:=Form_LineGraph.SaveChartToBmp;
       if PathFile<>'' then  begin
          inc(fuLu_Tu_id);
          ChangePictureWidth(PathFile);
          Add_FuLuTu(0,fuLu_Tu_id,
                '【'+MainDataModule.WorkFace_Name+'工作面】第'+Public_Basic.GetChineseNumber(PhaseNumber+1)+
                '区间矿压显现标注图（3）', '(四个坐标轴，每个坐标轴显示一条曲线，第三批)',PathFile);
          iStr:=iStr+'矿压显现标注图3见附录图X-'+IntToStr(fuLu_Tu_id) +'。';
       end;
       Form_LineGraph.Close ;


    finally

    end;
    // 书签再回来
    innword.GotoBookMark('tempPosition');
   //删除该书签
    innword.DeleteBookMark('tempPosition');
    Result:=iStr;

end;

procedure TWordReport.Add_Third_one_First_Table_Chlid(phaseNumber:integer;OneStepIn: TcomprehensiveOldStep;
       sup_st,sup_ed:integer;   itab: Table;var come_i,iRow:integer);
var
  t_str,R_Str:string;
  Ex_Stepid,N:integer;
begin
 //增加一行
     with innWord do begin
             insertRow(itab,0,1);inc( iRow);Moveright(1);
             inc(come_i);
             TableCellMerge(itab,2,iRow,8,iRow);
             SetFont('宋体',9,true,false) ; AlignLine(1); WriteText(InttoStr(come_i),0); Moveright(1);
             if phaseNumber >0 then   begin
                   if OneStepIn.ModifyData =10 then  begin
                      t_str:='第'+Public_Basic.GetChineseNumber(phaseNumber)+
                             '区间(支架范围:'+IntTostr(sup_st) +'-'+IntTostr(sup_ed)+')'+
                             '第【'+InttoStr(come_i)+'】个矿压显现显著区域通报';
                   end else if OneStepIn.ModifyData =9 then  begin
                      t_str:='第'+Public_Basic.GetChineseNumber(phaseNumber)+'区间(支架范围:'+
                              '区间(支架范围:'+IntTostr(sup_st) +'-'+IntTostr(sup_ed)+')'+
                             '第【'+InttoStr(come_i)+'】个矿压显现明显区域通报';
                   end else if OneStepIn.ModifyData =8 then  begin
                      t_str:='第'+Public_Basic.GetChineseNumber(phaseNumber)+'区间(支架范围:'+
                              '区间(支架范围:'+IntTostr(sup_st) +'-'+IntTostr(sup_ed)+')'+
                             '第【'+InttoStr(come_i)+'】个矿压局部矿压显现明显点通报';
                   end else if (OneStepIn.ModifyData =5) or (OneStepIn.ModifyData =6) then  begin
                      t_str:='第'+Public_Basic.GetChineseNumber(phaseNumber)+'区间(支架范围:'+
                             '区间(支架范围:'+IntTostr(sup_st) +'-'+IntTostr(sup_ed)+')'+
                             '第【'+InttoStr(come_i)+'】个矿压显现异常点通报';
                   end else  if OneStepIn.ModifyData =30 then  begin
                      t_str:='第'+Public_Basic.GetChineseNumber(phaseNumber)+'区间(支架范围:'+
                              '区间(支架范围:'+IntTostr(sup_st) +'-'+IntTostr(sup_ed)+')'+
                             '第【'+InttoStr(come_i)+'】次预报即将到来的矿压显现显著区域';
                   end else  if OneStepIn.ModifyData =27 then  begin
                      t_str:='第'+Public_Basic.GetChineseNumber(phaseNumber)+'区间(支架范围:'+
                             '区间(支架范围:'+IntTostr(sup_st) +'-'+IntTostr(sup_ed)+')'+
                             '第【'+InttoStr(come_i)+'】次预报即将到来的矿压显现明显区域';
                   end;

             end else begin
                  if OneStepIn.ModifyData =10 then  begin
                      t_str:='第【'+InttoStr(come_i)+'】个矿压显现显著区域通报';
                   end else if OneStepIn.ModifyData =9 then  begin
                      t_str:='第【'+InttoStr(come_i)+'】个矿压显现明显区域通报';
                   end else if OneStepIn.ModifyData =8 then  begin
                      t_str:='第【'+InttoStr(come_i)+'】个矿压局部矿压显现明显点通报';
                   end else if (OneStepIn.ModifyData =5) or (OneStepIn.ModifyData =6) then  begin
                      t_str:='第【'+InttoStr(come_i)+'】个矿压显现异常点通报';
                   end else  if OneStepIn.ModifyData =3 then  begin
                      t_str:='第【'+InttoStr(come_i)+'】次预报即将到来的矿压显现明显区域';
                   end;
             end;

             SetFont('宋体',9,false,false) ; AlignLine(0); WriteText(t_str,0);
             insertRow(itab,0,1); inc( iRow);  Moveright(1);
             // 下一行
             SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('开始最小进刀',0); Moveright(1);
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(IntTostr(OneStepIn.StartDao),0); Moveright(1);

             SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('结束最大进刀',0); Moveright(1);
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(IntTostr(OneStepIn.EndDao),0); Moveright(1);

             SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('显著运动进刀',0); Moveright(1);
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(formatFloat('0',OneStepIn.End_AGVDao-OneStepIn.Start_AGVDao),0); Moveright(1);
             SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('开始支架编号',0); Moveright(1);
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(IntTostr(OneStepIn.StartSup),0);
              //增加一行
             insertRow(itab,0,1); inc( iRow);  Moveright(1);
             SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('开始进尺(米)',0); Moveright(1);
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(formatFloat('0.00',OneStepIn.Start_AGVFootage),0); Moveright(1);

             SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('结束进尺(米)',0); Moveright(1);
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(formatFloat('0.00',OneStepIn.End_AGVFootage),0); Moveright(1);

             SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('显著运动进尺',0); Moveright(1);
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(formatFloat('0.00',OneStepIn.End_AGVFootage-OneStepIn.Start_AGVFootage),0); Moveright(1);

             SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('结束支架编号',0); Moveright(1);
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(IntTostr(OneStepIn.EndSup),0);
             //下一行
             insertRow(itab,0,1);inc( iRow);Moveright(1);
             SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('动载系数',0); Moveright(1);
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(formatFloat('0.00',OneStepIn.NormalQd),0); Moveright(1);

             SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('均值系数',0); Moveright(1);
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(formatFloat('0.00',OneStepIn.AGVDataQD),0); Moveright(1);

             SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('面积系数',0); Moveright(1);
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(formatFloat('0.00',OneStepIn.AreaQD),0); Moveright(1);

             SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('综合系数',0); Moveright(1);
             SetFont('宋体',9,false,false) ; AlignLine(1);
                WriteText(formatFloat('0.00',OneStepIn.WholeQD),0);
//             //下一行

               if OneStepIn.FindNextStep   then  begin
              {如果进行下一步来压预报}
                  insertRow(itab,0,1);inc( iRow);Moveright(1);
                  SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('下一次步距',0); Moveright(1);
                  SetFont('宋体',9,false,false) ; AlignLine(1);
                  WriteText(formatFloat('0.00',OneStepIn.Step_Move_AGV_Footage),0); Moveright(1);

                  SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('显著运动步距',0); Moveright(1);
                  SetFont('宋体',9,false,false) ; AlignLine(1);
                  WriteText(formatFloat('0.00',OneStepIn.Step_Obvious_Footage[2]),0); Moveright(1);



                  SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('稳定运动步距',0); Moveright(1);
                  SetFont('宋体',9,false,false) ; AlignLine(1);
                  WriteText(formatFloat('0.00',OneStepIn.Step_Continue_Footage),0); Moveright(1);

                  Moveright(1);

              end;
              //下一行
               R_Str:='';
               for N := 0 to OneStepIn.NextStepCount -1 do   begin
                   if N >0  then R_Str:= R_Str + #13#10 +'';
                   Ex_Stepid:=iDwGrap.Auto_Judge_OldStep.ReturnExStepidFromInn_Stepid(
                                    OneStepIn.NextStepClassID[N]);
                   if sup_st>0  then  begin
                      R_Str:= R_Str + '第['+IntTostr(N+1)+']区间    进刀范围：'+
                          IntTostr(iDwGrap.Auto_Judge_OldStep.ExSteps[Ex_Stepid].OneStepInfo.StartDao)+ '-'+
                          IntTostr(iDwGrap.Auto_Judge_OldStep.ExSteps[Ex_Stepid].OneStepInfo.EndDao) +', 支架范围：' +
                          IntTostr(max(iDwGrap.Auto_Judge_OldStep.ExSteps[Ex_Stepid].OneStepInfo.StartSup,sup_st))+ '-'+
                          IntTostr(Min(iDwGrap.Auto_Judge_OldStep.ExSteps[Ex_Stepid].OneStepInfo.EndSup,sup_ed))  ;
                   end else begin
                     R_Str:= R_Str + '第['+IntTostr(N+1)+']区间    进刀范围：'+
                          IntTostr(iDwGrap.Auto_Judge_OldStep.ExSteps[Ex_Stepid].OneStepInfo.StartDao)+ '-'+
                          IntTostr(iDwGrap.Auto_Judge_OldStep.ExSteps[Ex_Stepid].OneStepInfo.EndDao) +', 支架范围：' +
                          IntTostr(iDwGrap.Auto_Judge_OldStep.ExSteps[Ex_Stepid].OneStepInfo.StartSup)+ '-'+
                          IntTostr(iDwGrap.Auto_Judge_OldStep.ExSteps[Ex_Stepid].OneStepInfo.EndSup)  ;
                   end;
               end;

               if length(R_Str)> 0 then  begin
                  //下一行
                  insertRow(itab,0,1);inc( iRow); Moveright(1);
                  TableCellMerge(itab,2,iRow,8,iRow);
                  SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('后续来压区间',0); Moveright(1);
                  SetFont('宋体',9,false,false) ; AlignLine(0); WriteText(R_Str,0);

               end;

               if length(OneStepIn.SupportString) >0  then begin
                  insertRow(itab,0,1);inc( iRow); Moveright(1);
                  TableCellMerge(itab,1,iRow,2,iRow); TableCellMerge(itab,2,iRow,7,iRow);
                  SetFont('宋体',9,true,false) ; AlignLine(0); WriteText('矿压显现明显支架编号:',0); Moveright(1);
                  t_str:='';
                  R_Str:=OneStepIn.SupportString;
                  while length(R_Str) > 70 do   begin
                       t_str:= t_str+ copy(R_Str,1,70) +#13#10;
                       R_Str:=copy(R_Str,71,length(R_Str)-70);
                  end;
                  t_str:= t_str+ R_Str;
                  SetFont('宋体',9,false,false) ; AlignLine(0); WriteText(t_str,0);
               end;
     end;

end;

procedure TWordReport.Add_WorkFace_BasicInformation(inGzm: TGZM);
var
  str:string;
  Richedit1:Trichedit;
  fileName,textString:Ansistring;
  DirName:Ansistring;
  Dll_Path:AnsiString;

begin
   Dll_Path:=Public_Basic.Get_MyModulePath;
   DirName:=DLL_path+'\InputData\WorkDace_'+IntTostr(inGzm.Gzmbh)+'\';

  try
    Richedit1:=Trichedit.CreateParented(ExHandle);
    with innWord do begin
      AlignLine(0);
      SetFont('宋体',16,true,false);
      SetHeading(IntTostr(SencentId)+' 工作面地质及开采条件',1);// 章节
         SetFont('宋体',14,false,false);
         SetHeading(IntTostr(SencentId)+'.1 工作面地质及开采条件',2);// 章节
         SetFont('宋体',12,false,false);
         SetHeading(IntTostr(SencentId)+'.1.1 工作面概况及地质说明书',3);// 章节
         if MainDataModule.ReadRichTextFromDataBase(RichEdit1.Lines,'GZMBASIC','rtf',
                         inGzm.Gzmbh ,101,-1,-1) then begin
             RichEdit1.Lines.SaveToFile(DirName+'B001.rtf');
             AlignLine(1);
             SetFont('宋体',11,true,false);
             SetHeading('表1-1 工作面回采地质说明书',4);
             AlignLine(0);
             SetFont('宋体',11,false,false);
             insertotherfile(DirName+'B001.rtf');
         end else begin
              // 填写本程序书写的 格式
             ADDWorkFaceInFo_1(inGzm);
         end;
         //-----------------
         if ForceExit then   exit;
         public_Basic.WriteMakeWordPercent(true,31);
         //
         AddReturn();
         SetFont('宋体',12,false,false);
         SetHeading(IntTostr(SencentId)+'.1.2 顶底板岩层岩性分析',3);// 章节
         SetFont('宋体',12,false,false);
         if MainDataModule.ReadRichTextFromDataBase(RichEdit1.Lines,'GZMBASIC','rtf',
                         inGzm.Gzmbh ,102,-1,-1) then begin
            RichEdit1.Lines.SaveToFile(DirName+'B002.rtf');
            insertotherfile(DirName+'B002.rtf');
             //插入钻孔岩层表格
            ADDDrilleInFo_2(inGzm);
         end else begin
            //插入钻孔岩层表格
            ADDDrilleInFo_2(inGzm);
         end;
         //-----------------
         if ForceExit then   exit;
         public_Basic.WriteMakeWordPercent(true,32);
         //-----------------------
         SetFont('宋体',12,false,false);
         SetHeading(IntTostr(SencentId)+'.1.3 地质构造情况',3);// 章节
         SetFont('宋体',10,false,false);
         if MainDataModule.ReadRichTextFromDataBase(RichEdit1.Lines,'GZMBASIC','rtf',
                         inGzm.Gzmbh ,103,-1,-1) then begin
            RichEdit1.Lines.SaveToFile(DirName+'B003.rtf');
            insertotherfile(DirName+'B003.rtf');
         end else begin
             SetFont('宋体',12,False,true);
             WriteText('【没有录入该工作面地质构造，请到资料补录界面补录】',0);
         end;
         AddReturn();

       //-----------------
         if ForceExit then   exit;
         public_Basic.WriteMakeWordPercent(true,33);
       //-----------------------  // 第二节
      SetFont('宋体',14,false,false);
      SetHeading(IntTostr(SencentId)+'.2 支护信息',2);// 章节
         SetFont('宋体',12,false,false);
         SetHeading(IntTostr(SencentId)+'.2.1 正常支护',3);// 章节
         Add_Support_Information(inGzm);
         SetFont('宋体',12,false,false);
         if MainDataModule.ReadRichTextFromDataBase(RichEdit1.Lines,'GZMBASIC','rtf',
                         inGzm.Gzmbh ,201,-1,-1) then begin
            RichEdit1.Lines.SaveToFile(DirName+'B004.rtf');
            insertotherfile(DirName+'B004.rtf');
         end else begin
            SetFont('宋体',12,False,true);
            WriteText('【没有录入该工作面正常支护，请到资料补录界面补录】',0);
         end;

         SetFont('宋体',12,false,false);
         AddReturn();
         SetHeading('1.2.2 特殊支护',3);// 章节
         SetFont('宋体',12,false,false);
         if MainDataModule.ReadRichTextFromDataBase(RichEdit1.Lines,'GZMBASIC','rtf',
                         inGzm.Gzmbh ,202,-1,-1) then begin
            RichEdit1.Lines.SaveToFile(DirName+'B005.rtf');
            insertotherfile(DirName+'B005.rtf');
         end else  begin
            SetFont('宋体',12,False,true);
            WriteText('【没有录入该工作面特殊支护，请到资料补录界面补录】',0);
         end;

         //-----------------
         if ForceExit then   exit;
         public_Basic.WriteMakeWordPercent(true,34);
         //-----------------------

         SetFont('宋体',12,false,false);
         AddReturn();
         SetHeading(IntTostr(SencentId)+'.2.3 确定支护强度',3);// 章节
         SetFont('宋体',12,false,false);
         if MainDataModule.ReadRichTextFromDataBase(RichEdit1.Lines,'GZMBASIC','rtf',
                         inGzm.Gzmbh ,203,-1,-1) then begin
            RichEdit1.Lines.SaveToFile(DirName+'B006.rtf');
            insertotherfile(DirName+'B006.rtf');
         end else begin
           SetFont('宋体',12,False,true);
           WriteText('【没有录入该工作面确定支护强度，请到资料补录界面补录】',0);
         end;
     end;
  finally
     FreeandNil(RichEdit1);
  end;
end;

procedure TWordReport.ChangePictureWidth(Path: string);
var
  in_imge,imag:Timage;
begin
    imag:=Timage.Create(nil);
    imag.Width :=1600;
    imag.Height :=880;
    in_imge:=Timage.Create(nil);
    try
       in_imge.Picture.LoadFromFile(Path);
       in_imge.Stretch:=true;

       imag.Canvas.StretchDraw(imag.ClientRect,in_imge.Picture.Graphic);
       imag.Picture.SaveToFile(Path);

    finally
       in_imge.Free;
       imag.Free;
    end;

end;

constructor TWordReport.Create;
begin
    CreateWordClass;
    // 创建report数据类
    ReportInputData:=TDataFrequency.Create ;
    Subject_Str:=TStringList.Create ;
end;

procedure TWordReport.CreateWordClass;
begin
    if not Assigned(innWord) then
         innWord:= TMyWord.Create;



end;

procedure TWordReport.DeleteBmPFile;
var
 BmpPath:WideString;
begin
    BmpPath:=Public_Basic.Get_MyModulePath+'SaveBmp\FYYD\';
    if  DirectoryExists(BmpPath) then
        TDirectory.Delete(BmpPath, true);
    ForceDirectories(BmpPath);
end;

destructor TWordReport.Destroy;
begin
   FreeMyWordClass;
   if Assigned(ReportInputData) then
      FreeAndNil(ReportInputData);
   if Assigned(Subject_Str) then
      FreeAndNil(Subject_Str);
end;

procedure TWordReport.FreeMyWordClass();
begin
   try
     if Assigned(innWord) then FreeandNil(innWord);
   finally

   end;

end;

function TWordReport.Get_BottomWater(id: integer): String;
begin
  case id of
     1: Result:='底板无水';
     2: Result:='底板有水源，较远';
     3: Result:='底板有水源，较近';
     4: Result:='曾发生底板突出事故';
     else  Result:='其他';
  end;
end;

function TWordReport.Get_Cmff(id: integer): String;
begin
    case id of
       1: Result:='炮采';
       2: Result:='普采';
       3: Result:='综采';
       else Result:='放顶煤';
    end;
end;

function TWordReport.Get_Coal_F(id: integer): String;
begin
   case id of
         1: Result:='普氏系数0.8以下';
         2: Result:='普氏系数0.8-1.5之间';
         3: Result:='普氏系数1.5-2.5之间';
         else Result:='普氏系数2.5以上';
   end;
end;

function TWordReport.Get_DZGZ(id: integer): String;
begin
   case id of
       1: Result:='地质构造较少';
       2: Result:='背斜轴部';
       3: Result:='向斜轴部';
       4: Result:='断层密集，但不影响推进';
       5: Result:='断层密集，影响推进';
       6: Result:='地质及其复杂';
   end;
end;

function TWordReport.Get_HangDao_Stress(id: integer): String;
begin
   case id  of
       1: Result:='基本无水平应力';
       2: Result:='水平应力小于垂直应力';
       3: Result:='水平应力与垂直应力相当';
       else Result:='水平应力大于垂直应力1.5倍以上';
   end;
end;

function TWordReport.Get_HangDao_support(id: integer): String;
begin
   case id of
       1: Result:='巷道基本不需要支护';
       2: Result:='巷道需要简单的锚网支护';
       3: Result:='巷道架棚支护，基本不变形';
       4: Result:='巷道变形，底鼓，变形小';
       else Result:='巷道急速变形，底鼓，严重影响生产';
   end;
end;

function TWordReport.Get_JYHD(id: integer): String;
begin
   case id of
     1: Result:='基岩层较薄';
     2: Result:='基岩层一般';
     3: Result:='基岩层较厚';
     else Result:='基岩层巨厚';
   end;
end;

function TWordReport.Get_RockPress(id: integer): String;
begin
   case id of
       1: Result:='矿压显现不明显';
       2: Result:='有矿压显现，不影响生产';
       3: Result:='矿压显现叫剧烈，影响生产';
       4: Result:='发生过顶板事故';
   end;
end;

function TWordReport.Get_support_type(id: integer): String;
begin
   case id of
      1: Result:='单体支护';
      2: Result:='综采液压支架';
   end;
end;

function TWordReport.Get_TopWater(id: integer): String;
begin
   case id of
     1: Result:='顶板无水';
     2: Result:='含水层距离顶板较远';
     3: Result:='含水层距离顶板较近';
     4: Result:='曾发生透水事故';
     else  Result:='其他';

  end;
end;

function TWordReport.Get_WSFC(id: integer): String;
begin
  case id of
      1: Result:='瓦斯含量较低';
      2: Result:='低瓦斯，但局部超限';
      3: Result:='高瓦斯';
  end;
end;

function TWordReport.Get_YxFx(id: integer): String;
begin
   case id of
      1: Result:='水平推进';
      2: Result:='仰斜推进';
      3: Result:='俯斜推进';
   end;
end;

procedure TWordReport.InsertPageSetupWater(path:string);
begin
   with innword do begin
       InsetWaterBmp(path+'BJTP\water.bmp',path+'BJTP\login.ico',30,85,105,70);
   end;
end;

function TWordReport.isExsitBmpFile(BmpFile: string): Boolean;
begin
    Result:=False;
    while not FileExists(BmpFile) do  sleep(100);
    Result:=true;

end;

procedure TWordReport.KillWord;
var
 ProcessID: Hwnd;
begin
   if gWaveHwnd<>0 then   begin
     //OpenProcess(PROCESS_ALL_ACCESS, False, ProcessID);
    TerminateProcess(gWaveHwnd,4);
   end;

end;

procedure TWordReport.ProDisposeFiveDataType;
var
  i,percent:integer;
  useDataType:TCycleData;
  pi:PTypeInfo;
begin
   useDataType:=iDwGrap.CloudClass.Yuntu_CycleData;
   pi:=  TypeInfo(TCycleData);
   percent:=2;
    for I := 0 to 5 do  begin
      if ForceExit then   exit;
      if i=2 then  continue; // 初撑力 返回
      if (i=5) and (not MainDataModule.SelectRockPressDataNumber(5,iDwGrap.FGzm.Gzmbh)) then  continue;
      if i=ord(useDataType) then continue;

      iDwGrap.CloudClass.Yuntu_CycleData:=TCycleData(GetEnumValue(pi,GetEnumName(pi,i))) ;
      CreateRockPressTool(Application.Handle,'云图显示属性设置界面',
                         Form_ContourGraph.Width ,Form_ContourGraph.Height,1);
      FormPressTool.RecallDataSet ;
      FormPressTool.Close ;
      Form_ContourGraph.But_Start_KYFX.Click ;
          // 控制显示
      if Assigned(Form_ContourGraph) then
           Form_ContourGraph.setContourChartMin_MaxToBmp(
              iDwGrap.DataTimeAndFootAge.Graph_MaxDao-20,
              iDwGrap.DataTimeAndFootAge.Graph_MaxDao+80
              ) ;
        // 再把云图 返回来
      if Assigned(Form_ContourGraph) then
           Form_ContourGraph.setContourChartMin_MaxToBmp(
              iDwGrap.DataTimeAndFootAge.Graph_MinDao,
              iDwGrap.DataTimeAndFootAge.Graph_MaxDao
              ) ;
       public_Basic.WriteMakeWordPercent(true,3+percent*i);
    end;
    // 把图形返回来
    if ForceExit then   exit;
      iDwGrap.CloudClass.Yuntu_CycleData:=useDataType;
      CreateRockPressTool(Application.Handle,'云图显示属性设置界面',
                         Form_ContourGraph.Width ,Form_ContourGraph.Height,1);
      FormPressTool.RecallDataSet ;
      FormPressTool.Close ;
      Form_ContourGraph.But_Start_KYFX.Click ;
        // 控制显示
    if ForceExit then   exit;
    if Assigned(Form_ContourGraph) then
         Form_ContourGraph.setContourChartMin_MaxToBmp(
            iDwGrap.DataTimeAndFootAge.Graph_MaxDao-20,
            iDwGrap.DataTimeAndFootAge.Graph_MaxDao+80
            ) ;
      // 再把云图 返回来
    if ForceExit then   exit;
    if Assigned(Form_ContourGraph) then
         Form_ContourGraph.setContourChartMin_MaxToBmp(
            iDwGrap.DataTimeAndFootAge.Graph_MinDao,
            iDwGrap.DataTimeAndFootAge.Graph_MaxDao
            ) ;
    public_Basic.WriteMakeWordPercent(true,15);
end;

function TWordReport.ReportAnsysisRockPress(AHandle: THandle; inGzm: TGZM;ExWord:Boolean):Boolean;
var
  i:integer;
  pic_path,SaveFile,tmp:string;
  HeadValue,FootValue1,FootValue2:string;
begin
     Result:=False;
  try
     ExHandle:=AHandle;
     Pic_Path:=Public_Basic.Get_MyModulePath;
     DeleteBmPFile; {删除文件夹}
       {提前调用，为文件保存预留时间}
      // 矿压观测报告  提前打开
     CreateWordClass();

     innWord.OpenWord('');
     if ExWord then   begin   // 如果是外部调用
        innWord.SetParentWindow(MainPanel);
        innWord.SetZoomPercentage(75);
     end;

      //
     iCallPStope.SetFyyd_Bmp(AHandle);//把覆岩运动规律图片形成了
     iCallPStope.GetDTFZBmp(AHandle); // 把动态仿真图片形成了
     iCallPStope.GetZCYLBMP(AHandle); // 把支承压力分布规律图片形成了
     SencentId:=0;   fuLu_Tu_id:=0;
     HeadValue:='    '+MainDataModule.Coal_Name+'煤矿【'+MainDataModule.WorkFace_Name+'工作面】矿压深度分析报告';
     FootValue1:=  MainDataModule.Coal_Name+'煤矿生产科矿压工作组编制' ;
     FootValue2:=  '山东科技大学宋振骐院士技术团队监制';
     // 把图形遍历了
     public_Basic.WriteMakeWordPercent(true,2);
     ProDisposeFiveDataType;
     if ForceExit then   exit;

      with  innWord do begin
          //设置页眉页脚  0 相同 1 不同
          SetHeadFootSame(1);//也指页眉页脚不同
          //把拼写检查屏蔽
          CloseCheckGrammar(False);
          // 控制页边距
          setpagemargin(25,20,25,20);
           // 添加封面
          Add_Kyfx_Cover(MainDataModule.Coal_Name,MainDataModule.WorkFace_Name);
           //插入摘要
          insertPage(2);
          ADD_Abstric;
          insertPage(2);
         // ADD_Fuhaoshuming;// 添加符号说明
            //插入下一页
          insertPage(2);
          //插入目录标记
          createBookMark('mulu' );
          //-----
               // 添加水印
          InsertPageSetupWater(Pic_Path);
          insertpageHead('目录',HeadValue);
          insertpageFoot(FootValue1,FootValue2);

          // 插入页码 重新排序的那种
          insertPagenum(1);
          public_Basic.WriteMakeWordPercent(true,20);
          // 插入正文
          insertPage(2);
          createBookMark('zhengwen' );
          AddReturn();
          insertPagenum(1);
           // 插入附录
          insertPage(2);
          createBookMark('fulu' );
          SetPageOrient(1);
          insertPagenum(0);
          ADD_Fulu;
          if ForceExit then   exit;
          Add_Fulu_TuFirstToFive; // 把附录前面的四章图给插入了
          public_Basic.WriteMakeWordPercent(true,30);
          if ForceExit then   exit;
           // 插入后记
//          insertPage(2);
//          createBookMark('houji' );
//          SetPageOrient(0);
//          insertPagenum(0);
//          ADd_HouJi;
//
//           找到正文插入
          GotoBookMark('zhengwen');
          if ForceExit then   exit;

          if iDwGrap.GraphClass.ReportFirst  then  begin
             inc(SencentId);
             Add_WorkFace_BasicInformation(inGzm);
             insertPage(0);
          end;
        public_Basic.WriteMakeWordPercent(true,35);

////         // 添加实用矿压压力控制理论 第二章
          if ForceExit then   exit;
           if iDwGrap.GraphClass.ReportSecond  then  begin
                 inc(SencentId);
                 Add_FYYD_2(inGzm);
                 insertPage(0);
           end;
         public_Basic.WriteMakeWordPercent(true,45);

         // 插入第三章 统计数据分析单元
         inc(SencentId);
         if ForceExit then   exit;
         Add_Second_Secents(inGzm);
         insertPage(0);
         public_Basic.WriteMakeWordPercent(true,60);
//          插入第四章 给予曲面的数据分析单元
         inc(SencentId);
         if ForceExit then   exit;
         Add_Third_Secents(inGzm);
         insertPage(0);
         public_Basic.WriteMakeWordPercent(true,90);
          // 插入第五章 结论
         inc(SencentId);
         if ForceExit then   exit;
         Add_fourth_Secents(inGzm);
         insertPage(0);
         public_Basic.WriteMakeWordPercent(true,95);
     end;

      //插入目录
     Add_Contents;
     //保存为文件
     tmp:=pic_path+'SaveBmp\KYJG\Report_' +Trim(IntTostr(inGzm.Gzmbh))+'_' +
                 FormatDateTime('yyyymmddHHNNSS',now());
     SaveFile:=tmp+'.Doc' ;
     public_Basic.WriteMakeWordPercent(true,98);
     innWord.Save(SaveFile) ;
     SaveFile:=tmp+'.mht' ;
     innWord.SaveAs(SaveFile) ;
     public_Basic.WriteMakeWordPercent(False,0);
  finally
     Result:=True;
  end;
     // 释放类
//     FreeMyWordClass;
end;

procedure TWordReport.ReportYklh(AHandle:THandle;inGzm:TGzm);
begin
       CreateWordClass();
       innWord.OpenWord('');
       DeleteBmPFile; {删除文件夹}
       {提前调用，为文件保存预留时间}
//       Main_CallPStope.UsePStope.GetFyydBmp(AHandle);
//       Main_CallPStope.UsePStope.GetDTFZBmp(AHandle);
       // 添加标题
       AddDocmentTitle(MainDataModule.Coal_Name,MainDataModule.WorkFace_Name,
                       'Yklh');
      //添加工作面信息
       ADDWorkFaceInFo_1(inGzm);
       //添加钻孔基本信息
       ADDDrilleInFo_2(inGzm);
       //添加覆岩运动规律
       AddFYYDInfo_3(inGzm,'Yklh');
       //添加采动模拟仿真
       AddYDFZInfo_4(inGzm);
       //添加支架选型
       AddYklhInfo_5(inGzm);
       //添加支架专家意见表
//       AddSupSubject_6(inGzm);
//       //添加已存在液压支架信息
//       AddExsitSupport_7(inGzm);
       //免责声明
       Add_disclaimer('六');
       FreeMyWordClass();
end;

procedure TWordReport.ReportZhijia(AHandle:THandle;inGzm:TGzm);
begin
       CreateWordClass();
       innWord.OpenWord('');
       DeleteBmPFile; {删除文件夹}
       {提前调用，为文件保存预留时间}
//       Main_CallPStope.UsePStope.GetFyydBmp(AHandle);
//       Main_CallPStope.UsePStope.GetDTFZBmp(AHandle);
       // 添加标题
       AddDocmentTitle(MainDataModule.Coal_Name,MainDataModule.WorkFace_Name,
                       'Support' );
      //添加工作面信息
       ADDWorkFaceInFo_1(inGzm);
       //添加钻孔基本信息
       ADDDrilleInFo_2(inGzm);
       //添加覆岩运动规律
       AddFYYDInfo_3(inGzm,'Support');
       //添加采动模拟仿真
       AddYDFZInfo_4(inGzm);
       //添加支架选型
       AddSupportInfo_5(inGzm);
       //添加支架专家意见表
       AddSupSubject_6(inGzm);
       //添加已存在液压支架信息
//       AddExsitSupport_7(inGzm);
       //免责声明
       Add_disclaimer('八');
       FreeMyWordClass();
end;

function TWordReport.Report_Zcyl(inGzm:TGzm): Boolean;
 var
   s_temp:Str_DT_array;
   C1:integer;
   S_out:Pansichar;
   Tab:Table;
begin
//*************
     S_out:= iCallPStope.Get_Zcyl('2.0',
           iDwGrap.DataTimeAndFootAge.DownEndFootage );
     s_temp:=Public_Basic.split(StrPas(S_out),';',C1);
     if C1> 4 then  begin
         {内应力场峰值k1;内应力场s0; 外应力场峰值k2; 支承压力峰值距离煤壁距离s1; 外应力范围sx; }
         with innWord do begin
             SetFont('宋体',11,true,false);AlignLine(1);
             SetHeading('表'+IntTostr(SencentId)+'-1'+'【'+MainDataModule.WorkFace_Name+'工作面】支承压力分布计算分析表',4);
             SetFont('宋体',11,false,false) ;
             Tab:=AddTable(2,6);
             setTableColumsWidth(Tab,1,60);
             setTableColumsWidth(Tab,2,60);
             AlignLine(1);
             SetFont('宋体',11,true,false) ;
             WriteText('项目名称',0);
             Moveright(1);AlignLine(1); SetFont('宋体',11,true,false) ;
             WriteText('数值',0);

             SetFont('宋体',11,False,false) ;
             Moveright(1);  AlignLine(0);
             WriteText('内应力场范围（米）',0);
             Moveright(1);AlignLine(1);
             WriteText(s_temp[1],0);

             Moveright(1);  AlignLine(0);
             WriteText('内应力场应力集中系数',0);
             Moveright(1);AlignLine(1);
             WriteText(s_temp[0],0);

             Moveright(1);  AlignLine(0);
             WriteText('外应力场范围（米）',0);
             Moveright(1);AlignLine(1);
             WriteText(s_temp[4],0);

             Moveright(1);  AlignLine(0);
             WriteText('外应力场应力集中系数',0);
             Moveright(1);AlignLine(1);
             WriteText(s_temp[2],0);

             Moveright(1);  AlignLine(0);
             WriteText('压力峰值距煤壁距离（米）',0);
             Moveright(1);AlignLine(1);
             WriteText(s_temp[3],0);
             MoveDown(1);

         end;

     end;
end;

procedure TWordReport.ReSize;
begin
  try
      if Assigned(innWord) then
         innWord.Resize(MAinPanel);
  finally

  end;
end;

function TWordReport.ReturnDataTypeName(Value: integer): String;
begin
    if Value=0 then  begin
        Result:='最大值'
    end else  if Value=1 then  begin
        Result:='平均值' ;
    end else  if Value=2 then  begin
        Result:='初撑力' ;
    end else  if Value=3 then  begin
        Result:='末阻力' ;
    end else  if Value=4 then  begin
        Result:='瞬间值' ;
    end else  if Value=5 then  begin
        Result:='手动录入值' ;
    end;

end;

function TWordReport.ReturnFileName(FileType: String; L_Min, L_Max,
  DataType,lx: integer): String;
{
   FileType 代表 图片文件 的标号 YT LN  Bar
   L_Min  >= 0 代表   最小进尺
   L_Max  >=0 代表 最大进尺
   lx  代表图片 最后的类型 0 1 2
}
var
  SearchRec: TSearchRec;
  found: integer;
  DirName:Ansistring;
  Dll_Path:AnsiString;
  s1,stemp:Str_DT_array;
  C1:integer;
begin
   Dll_Path:=Public_Basic.Get_MyModulePath;
   DirName:=DLL_path+'SaveBmp\KYFX\'+IntTostr(iDwGrap.FGzm.Gzmbh);
   Result:='';
  found := FindFirst(DirName + '\' + '*.bmp', faAnyFile, SearchRec);
  while found = 0 do   begin
    if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') and
      (SearchRec.Attr <> faDirectory) then  begin
        s1:=Public_Basic.split(SearchRec.Name,'.',C1);
        if C1>=1 then  begin
          stemp:=Public_Basic.split(S1[0],'_',C1);
          if C1>=1 then
            if Uppercase(stemp[0])=Uppercase(FileType) then
               if (L_Min >=0 ) and (C1>=2) and (stemp[1]= intTostr(L_Min) )   then
                   if  (L_Max >=0 ) and (C1>=3) and (stemp[2]= intTostr(L_Max) )   then   begin
                       { 查找 YT 类文件}
                        if (lx>=0) and (C1>=4) and (stemp[3]= intTostr(DataType) ) and (stemp[4]= intTostr(lx) ) then begin
                            Result:=DirName+'\'+SearchRec.Name;
                            break;
                        end;
                   end else begin
                      {查找Bar 文件}
                      Result:=DirName+'\'+SearchRec.Name;
                      break;
                   end;
        end;
      end;

      found := FindNext(SearchRec);
  end;

  FindClose(SearchRec);

end;

function TWordReport.ReturnTimeToChinese(dt: TdateTime): String;
var
  YYYY,MM,DD,i,Qt,tm:integer;
  St:String;
begin
   YYYY:=Public_Basic.StrToInt_lu(FormatDateTime('YYYY',dt));
   st:='';  Qt:=1000;
   for I := 4 downto 1 do  begin
     tm:=YYYY div Qt;
     YYYY:= YYYY mod Qt;
     St:=St+ public_Basic.GetChineseNumber(tm);
     Qt:=Qt div 10;
   end;
   St:=St+ '年';

   MM:=Public_Basic.StrToInt_lu(FormatDateTime('MM',dt));
   St:=St+public_Basic.GetChineseNumber(mm) +'月';

   DD:=Public_Basic.StrToInt_lu(FormatDateTime('DD',dt));

   tm:=DD div 10;
     if tm>0 then
        St:=St+ public_Basic.GetChineseNumber(tm);
   DD:= DD mod 10;
   St:=St+ public_Basic.GetChineseNumber(DD) +'日';
   Result:=st;
end;


procedure TWordReport.SetDrawGraph(iDw:TDrawGrap;iCallP:TDefine_CallPStope);
begin
   iDwGrap:=iDw;
   iCallPStope:=iCallP;
end;

procedure TWordReport.SetReportExit(Value: Boolean);
begin
    ForceExit:=Value;
end;

procedure TWordReport.SetWordPanel(iPanel: TPanel);
begin
   MainPanel:=iPanel;
end;

end.
