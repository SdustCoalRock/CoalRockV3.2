//    该函数是使用时间为循环变量的统计方法,由于工作面可能上下顺槽的进尺不一致
// 造成同一个计算区域步距具有较大的差异,
//
// 该函数的姊妹函数是uThirdthread ,该文件主要是使用 时间作为循环的方式
//
//
unit uFourththread;

interface
uses
    Classes,uDisPoseData, GzmClass,MySQLDataSet,SysUtils,uDataModule,math,System.TypInfo,
     Winapi.ActiveX;

type
  PFourRec =^TFourthPD;
  TFourthPD= packed record
      generatetime:Tdatetime;   // 数据产生时间
      Phasenumber:integer;     //阶段数目
      ForcaseNumber:integer;   //预测编号
      eachsteps:double;        // 当前步距的进尺
      startfootage:double;    // 来压开始步距
      endfootage:double;      //来压结束步距
      startSupid:integer;     //开始支架编号
      EndSupid:integer;       //结束支架编号
      ComePressStarttime:tdatetime; // 来压开始时间
      EndPresstime:tdatetime;      //来压结束时间
      OutStandComePressStartTime:tdatetime;  // 显著来压时刻
      OutStandSupport:String;  // 支架来压序列
      AGVStep:double;     // 平均步距
      dayJinchi:double;    //每天进尺
      ComePressLevel:integer;  // 来压强度 五种状态
      AGVSecondJudge:double;  //第二次判断均值
      CycleSecondJudge:double;  // 当前第二次判断均值
      thirdJ_AGV:double;      //第三次判断均值
      thirdJ_Max:double;      // 第三次判断最大值
      AGVData:double;   //本次来压的均值
      SupportBeforeMoveData:double;//  本次来压的末阻力
      OldToPressure:integer;//老顶来压标记
      OldToPressureStep:double;//老顶来压步距
  end;


  PRec = ^TThirdDPD;
  TThirdDPD =packed record
     dSupStartBh:integer;
     dSupEndBh:integer;
     dSupNumber:integer;
     did:integer;
     dRecordNumber:integer;
     dMinData:double;
     dMaxData:double;
     dAGvData:double;
     dAGvDataFangCha:double;
     dAGVSupportMovePress:double;
     dPressWeigth:double;
     dString:String;
     PressSupportNumber:Integer;
     PressSupportProportion:double ;
     dmaxWightSupbh:integer;
     MaxWeightValue:double;
     dFootage:double;
     dFootageInterval:double;
     dStartTime:Tdatetime;
     dEndTime:TdateTime;
     stepStartTime:TdateTime;
     firstjudge:integer; //顶板来压状态
     ForeCase_step:double;//预测步距
     ForeCase_Pass_l:double; // 预测走过的距离
     ForeCase_Front_l:double; // 预测下一个步距的距离
     judgeLeval:double;//判断标准
     DsystemMinfootage:double;
     secondJudge,thirdjudge:integer;
     startFootage,EndFootage:double;// 最大进尺与最小进尺
     Generatetime:Tdatetime;// 记录产生时间
     //前两个周期步距的平均值
     Prev_TwoStep_AGV_Data:double;  //前两个周期步距平均值
     Prev_TwoStep_AGV_Fangcha:double; //前两个周期步距平均方差
     Prev_TwoStep_AGV_Weight:double; //前两个周期步距平均权重
     Prev_TwoStep_AGV_FirstJudge:double;  //前两个周期步距平均第二次判断
     Prev_TwoStep_AGV_SecondJudge:double;  //前两个周期步距平均第二次判断
     Prev_TwoStep_AGV_BeforeMovePress:double;  //前两个周期步距平均末阻力
     // 前面那条记录
     prev_Record_id: integer; // 前一条记录的 id
     prev_Record_AGV_data:double;//前一条记录的 平均值压力数据
     prev_Record_Fangcha:double;//前一条记录的 方差
     prev_Record_SecondJudge:double;//前一条记录的 第二次判断
     prev_Record_ForeCaseStep:double; //前一条记录的 预测步距
     prev_Record_Footage:double;//前一条记录的 进尺
     prev_Record_BeforeMovePress:double;//前一条记录的 末阻力
  end;

   TFourthThread=class(TThread)
   private
      TotalNumber:Integer;
      FGzmbh:String;
      FSupbh:integer;
      succeed:Boolean;
      EspTime:String;
      FDataTimeintVal:double;

      FDisPose:TDisposeData;
      FinGzm:TGzm;
     // Fsconn:String;
      ProcessTime:integer;
      ForCaseFlag:String;
      //

      dRecArry:array [0..8] of PRec;
      RecArryNumber:integer;
      //dRecList:TList;
      dFourRec:PFourRec;
      FAdoconn:TMySqlConnection;
      FAdoDataSet1:TMyDataSet;
      FAdoDataSet2:TMyDataSet;
      FAdoCommand:TMyCommand;
      DataBaseType:String;
      Pub_judgeLeval:double;
      RebalanceNumber:integer;
      OldStep:Integer;
      // 停止线程服务
      uThirdProcessStop:Boolean;
      //支架整体数据
      ThirdTableFiledNumber:Integer;
   protected

     procedure Execute ;override;

     function SelectMinFootAge(dGzmid:string;typeValue:string;Minsupid,Maxsupid:integer;
                               Var Minsupid_Minfootage,Minsupid_Maxfootage,MaxSupid_MinFootage,
                               MaxSupid_MaxFootage: double ):Boolean;
     function idDataValidity(dGzmid:string;typeValue:string;Minsupid,Maxsupid:integer;IntervalTime:double;
               Min_time,Max_time:TdateTime; Var R_Min_Time,R_Max_Time:TdateTime ):Boolean;
     function isUsedFootage(dGzmid:string;typeValue:string;Minsupid,Maxsupid:integer;Min_Time,Max_Time:TDateTime;
         Var MinFootage,MaxFootage,AGVFootage:double): Boolean;
     function SelectMinMaxTime(dGzmid:string;typeValue:string;Minsupid,Maxsupid:integer;IntervalTime:double;
                Var Min_Time,Max_Time:TdateTime ):Boolean;

     function SelectCountData(sql,Field1:string;Var Value:double):Boolean;
     procedure insertOrUpdateData(Sql:string);
     function ThirdDisPosePressDate(FGzmid:string;var TotalCount:integer;
                          var elapsedtime:string):Boolean;  //数据处理核心程序
     function SelectEachPhase(FGzmid,typeValue:string;PhaseNumber:integer;IntervalTime:double):Boolean;
     function selectPhaseComplete(dGzmid,typeValue:string;PhaseStartSupNo,PhaseEndSupNo:integer):Boolean;
     function FillDRec(FGzmid,typeValue:string;var DRec:PRec;Min_Time,Max_Time:TdateTime): Boolean;
     function InsertDatabase( FGzmid,typeValue:string;DRec:PRec):Boolean;
     //---------RebalanceDataBase 系列
     function RebalanceDataBase_Core(FGzmid,typeValue:string;var DRec:Prec):boolean;
     function RebalanceDataBase_First_FillData(FGzmid,typeValue:string;var DRec:Prec):boolean;
     function RebalanceDataBase_First_Judge( FRec:Prec):Integer;
     function RebalanceDataBase_Second_Judge( FRec:Prec):Integer;
     function RebalanceDataBase_Third_Judge(FGzmid,typeValue:string;var FRec:Prec):Integer;
     function RebalanceDataBase_Third_Judge_MerGeData(FGzmid,typeValue:string; FRec:Prec;Prev_two_Id,Prev_two_ThreeJudgeCount:integer;
          Prev_two_Footage,Prev_two_MoveBeforeData,Prev_two_ForCaseStep,Prev_two_AGVData:Double ):integer;

     function EditOldStep(FGzmid,typeValue:string;PhaseNumber:integer;Footage:double):Boolean;
     function JudgeMAXFootageFalg(FGzmid,typeValue:string;PhaseNumber:integer;
                               StartFootage,endFootage,FootageInterval:double):double;
     function SelectJudgeLevel(FGzmid,typeValue:string;PhaseNumber:integer;
                     Var JudgeLevel,UsedOldstep:double):Boolean;
     //-------------------

     function FirstStepJudge(FGzmid,typeValue:string;var Rec:Prec):boolean;

     function IntiArrayDrec:Boolean;
     function SelectProcessTime(FGzmid,typeValue:string;PhaseNumber:integer;
                     Var ProcessNumber:integer):Boolean;

     //------- 分 支架通道处理数据程序
     function ForCaseRockPress(FGzmid:string;var TotalCount:integer;
                          var elapsedtime:string):Boolean;  //数据处理核心程序;
     Function ForcaseThirdTable(FGzmid,typeValue:string;PhaseNumber:integer;FootageInterval:double):Boolean;
     function ForcaseSelectData(FGzmid,typeValue:string;PhaseNumber:integer;FootageInterval:double):Boolean;
     function ForCaseSelectCycleSecond(FGzmid,typeValue:string;PhaseNumber:integer;FootS,FootE:double):Boolean;
     function ForcaseDayJinChi(FGzmid,typeValue:string;PhaseNumber:integer):Boolean;
     function SaveFourthProcessData(FGzmid,typeValue:string;PhaseNumber:integer):Boolean;
     function ReturnPressStartTime(secondJudge:double;OST:integer;DT:Tdatetime):Integer;
     function ForcasePressIntensity(secondJudge,thirdJudge:double;OST:integer):Integer;
     procedure initPFourRec(pd:PFourRec);
     function ForcaseOldPressure(FGzmid,typeValue:string;PhaseNumber:integer):Boolean;
     function UpdataForcaseData(FGzmid:string ; id:integer;ComeFlag:integer;
              ComeStep,ForaseNextStep:double):Boolean;
     function selectMaxFootAge(FGzmid:string):double;
     procedure RefreshThreadState;
     function MakeForCaseNextStep(FGzmid,typeValue:string;PhaseNumber:integer;
              NowFootage,FirstStep:double):Double;
     // 支架整体数据处理程序
     function WholeSupport_ForCaseRockPress(FGzmid:string;var TotalCount:integer;
                          var elapsedtime:string):Boolean;  //数据处理核心程序;
     function SetThirdTableFiledNumber(FGzmid:string):Integer;
     function SetThirdTableFiledString(FGzmid,DataName:string):String; // 返回组合字符串
     Function WholeSupport_ForcaseThirdTable(FGzmid,FieldString:string;PhaseNumber:integer;FootageInterval:double):Boolean;
     function WholeSupport_ForcaseSelectData(FGzmid,FieldString:string;PhaseNumber:integer;FootageInterval:double):Boolean;
   public
      destructor Destroy; override;
      constructor  Create(uObjusers:TDisposeData;BaseType,Flag:string);

  end;

implementation

{ TThridhread }
//uses ;

constructor TFourthThread.Create(uObjusers:TDisposeData;BaseType,Flag:string);
var
   v1,v2,v3,v4,j:integer;
begin
     Inherited  Create(true) ; //继承 创建后 不启动 只有发出Resum采启动
     CoInitialize(Nil);
     FreeOnTerminate := True;

     ForCaseFlag:=Flag;
     FDisPose:=uObjusers;
     FAdoconn:=TMySqlConnection.Create(nil);
     FAdoconn.Open(uObjusers.FinDataModule.EXDataIP,uObjusers.FinDataModule.Port,uObjusers.FinDataModule.ExUser,
                    uObjusers.FinDataModule.EXPassword,uObjusers.FinDataModule.DataBaseName);

     FAdoDataSet1:=TMyDataSet.Create(nil);
     FAdoDataSet2:=TMyDataSet.Create(nil);
     FAdoCommand:=TMyCommand.Create(nil);
     FAdoDataSet1.MySqlConnection:=FAdoconn;
     FAdoDataSet2.MySqlConnection:=FAdoconn;
     FAdoCommand.MySqlConnection:=FAdoconn;

     FinGzm:=TGzm.Create(FAdoconn) ;
     DataBaseType:=BaseType;     //
     FDataTimeintVal:=FinGzm.GetDateintervalTime*MinutesD;
     //Create MyPStope
     for j := 0 to 7 do  new(dRecArry[j]);
     //
     new(dFourRec);
     initPFourRec(dFourRec);
     //
     ProcessTime:=1;
     Pub_judgeLeval:=0.2;
     RebalanceNumber:=0;
end;

destructor TFourthThread.Destroy;
var
  j:integer;
 begin
    for j := 0 to 7 do
         Dispose(dRecArry[j]);
     DisPose(dFourRec);

     FreeAndNil(FAdoDataSet1);
     FreeAndNil(FAdoDataSet2);
     FreeAndNil(FAdoCommand);
     FreeAndNil(FinGzm) ;
     FAdoconn.Free ;
     CoUninitialize;
     inherited Destroy;
end;
function TFourthThread.EditOldStep(FGzmid, typeValue: string;PhaseNumber:integer;Footage:double): Boolean;
var
  sql:string;
   AdjustCount:integer;
   Adjust_MinStep,Adjust_MaxStep,Adjust_AGVvstep:double;
begin
      Result:=false;
      sql:='select count(id) as StepCount,Min(ForCaseStep) as MinStep ,Max(ForCaseStep) as MaxStep '+
              ' , AVG(ForCaseStep) as AGVStep from D_' + Trim(FGzmid) +'_ThirdDP where Footage <' +  FormatFloat('0.00',Footage) +
               ' and phaseNumber =' +IntTostr(PhaseNumber) +  ' and EditOldStep =0  and '+' ThirdJudge >0 ' +
               ' and ForCaseStep >= '+FormatFloat('0.00',FinGzm.Old_Step[2]*0.5) +' and TypeData= ''' +typeValue +'''';

     FAdoDataSet1.Close ;
     FAdoDataSet1.CommandText :=sql;
      if  FAdoDataSet1.Open then begin
         AdJustCount:= FAdoDataSet1.FieldByName('StepCount').AsInteger;
         AdJust_MaxStep:= FAdoDataSet1.FieldByName('MaxStep').AsFloat;
         AdJust_MinStep:= FAdoDataSet1.FieldByName('MinStep').AsFloat;
         Adjust_AGVvstep:= FAdoDataSet1.FieldByName('AGVStep').AsFloat;
         FAdoDataSet1.Close ;

         if AdJustCount >=5 then  begin
              if FinGzm.Old_Step[2]=0 then FinGzm.Old_Step[2]:=15;
              if ((100*abs(Adjust_AGVvstep -FinGzm.Old_Step[2])/FinGzm.Old_Step[2])>=10)
                 and (RebalanceNumber<3)  then  begin
                  FinGzm.EditOldstep( AdJust_MaxStep,AdJust_MinStep,Adjust_AGVvstep);
                  FinGzm.UpdateEditZkzinfo;
                  FinGzm.Get_PStope_OldInfo;
                  FinGzm.UpdatedataBaseToZkInfo;
              end;                     //

             sql:=' update D_' +Trim(FGzmid) +'_ThirdDP  set EditOldStep=1,UsedOldStep=' + FormatFloat('0.00',FinGzm.Old_Step[2]) +
                  ' where Footage <' +  FormatFloat('0.00',Footage) +
                  ' and phaseNumber =' +IntTostr(PhaseNumber) +  ' and EditOldStep =0  ' +' and TypeData= ''' +typeValue +'''';
             FAdoCommand.CommandText:=sql;
             FAdoCommand.Execute ;
             Result:=true;
         end;
      end;
     FAdoDataSet1.Close ;
end;

procedure TFourthThread.Execute;
var
   t,TCount:integer;
   ListGzm:TStringList;
   sql:string;
   Gzm_Simple,Gzm_Difficult,Zk_str,SEorr:string;
   GetPStopeStr:String;
begin
  inherited;
   ListGzm:= TStringList.Create ;
   FAdoDataSet1.Close ;
   FAdoDataSet1.CommandText:='select cqid from cqcsb where qyzt=1';
   if FAdoDataSet1.Open then
       while not FAdoDataSet1.Eof  do  begin
          ListGzm.Add(Trim(IntToStr(FAdoDataSet1.FieldByName('cqid').AsInteger)));
          FAdoDataSet1.Next ;
       end;
   FAdoDataSet1.Close ;

   //
   totalnumber:=0;
   if ForCaseFlag='ThirdThread' then  begin  // 'ThirdThread'
       for t := 0 to ListGzm.Count - 1 do begin
            if FDisPose.ThirdProcessStop   then  break;
            FGzmbh:=ListGzm[t];
            // 读取 FinGzm的数据
            FinGzm.setGzmNumber(StrToint(FGzmbh)) ;
            if FinGzm.ReadData then   begin
               FinGzm.RefreshFootage(100);
               FinGzm.GetGzmZkStr(Gzm_Simple,Gzm_Difficult,Zk_str);
               FinGzm.MyP_stope.InitModel(Gzm_Simple,Zk_str,SEorr);
               GetPStopeStr:=FinGzm.Get_PStope_OldInfo ;
               OldStep:=Round(FinGzm.Old_Step[2]);
               ThirdDisPosePressDate(FGzmbh,TCount,EspTime);
            end else begin
               FinGzm.MakeGzmIsVail(0);
            end;
       end; //end t
   end else if ForCaseFlag='Forcase' then  begin  //  'ForCase'
      for t := 0 to ListGzm.Count - 1 do begin
            if FDisPose.FourthProcessStop   then  break;
            FGzmbh:=ListGzm[t];
            FinGzm.setGzmNumber(StrToint(FGzmbh)) ;
            if FinGzm.ReadData then   begin
               FinGzm.RefreshFootage(100);
               FinGzm.GetGzmZkStr(Gzm_Simple,Gzm_Difficult,Zk_str);
               FinGzm.MyP_stope.InitModel(Gzm_Simple,Zk_str,SEorr);
               GetPStopeStr:=FinGzm.Get_PStope_OldInfo ;
               ForCaseRockPress(FGzmbh,TCount,EspTime);
            end else begin
               FinGzm.MakeGzmIsVail(0);
            end;
      end; //end t
   end;


   FreeAndNil(ListGzm) ;
   //
   if (FDisPose.writeProcessflag) then
      sql:=' insert into processlog (generatetime,DataNumber,threadid,Processtype) values (''' +
        FormatDaTeTime('yyyy-mm-dd hh:nn:ss',now())+''','+IntToStr(TCount)+',' +
        IntToStr(self.Handle)+','''+ForCaseFlag+'Stop'')' ;

   FAdoCommand.CommandText:=sql;
   FAdoCommand.Execute ;


end;

function TFourthThread.FillDRec(FGzmid, typeValue: string; var DRec: PRec;
         Min_Time,Max_Time:TdateTime): Boolean;
var
  sql:string;
  MaxWeightSupbh:integer;
  RetVaule:double;
  Max_V,Min_V,Agv_V,Fangcha,Group_AGV:double;
  maxWeight, Weight:double;
  DownMinFootage,DownMaxFootage,UpperMinFootage,UpperMaxFootage:integer;
  MinFage,MaxFage:integer;
  MaxTime,MinTime:TdateTime;
  temp_w:double;
begin
      Result:=false;

       sql:= ' select AVG(AGV_Cycle_Value) as AGV_V  from  D_'+trim(FGzmid)+'_Seconddp' +
             ' where  endTime >= '''+FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Min_Time) +'''' +
             ' and endTime <= '''+FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Max_Time) +''''  +
             ' and supportworkingstate >1 and TypeData= '''+typeValue+'''  '+
             ' and supportbh >= ' +IntTostr(DRec.dSupStartBh) +
             ' and supportbh <= ' +IntToStr(DRec.dSupEndBh);

         SelectCountData(sql,'AGV_V',AGV_V);
         sql:= ' select sum(power(2,supportworkingstate)) as weight,count(id) as CN,supportbh,AVG(AGV_Cycle_Value) as AGV_V, ' +
             ' Max(Max_Value) as Max_v ,Min(Min_Value) as Min_V,Min(starttime) as Min_T,Max(Endtime) as Max_t, ' +
             ' SupportBeforeMovePress AS MZL from  D_'+trim(FGzmid)+'_Seconddp' +
             ' where  endTime >= '''+FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Min_Time) +'''' +
             ' and endTime <= '''+FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Max_Time) +''''  +
             ' and supportworkingstate >1 and TypeData= '''+typeValue+'''  '+
             ' and supportbh >= ' +IntTostr(DRec.dSupStartBh) +
             ' and supportbh <= ' +IntToStr(DRec.dSupEndBh) +
             ' group by supportbh order by supportbh';


        FAdoDataSet1.Close ;
        FAdoDataSet1.CommandText :=sql;
        if FAdoDataSet1.Open then
            if FAdoDataSet1.RecordCount<1 then  begin
               DRec.dRecordNumber:=0;
               exit;
            end;

        FAdoDataSet1.First;
        Min_V:= FAdoDataSet1.FieldByName('Min_V').AsFloat;
        Group_AGV:= FAdoDataSet1.FieldByName('AGV_V').AsFloat;
        Fangcha:= power(Group_AGV-AGV_V,2);
        Max_V:= FAdoDataSet1.FieldByName('Max_V').AsFloat;
        temp_w:=FAdoDataSet1.FieldByName('weight').AsFloat/FAdoDataSet1.FieldByName('cn').AsFloat;
        maxWeight:= temp_w;
        MaxWeightSupbh:=FAdoDataSet1.FieldByName('supportbh').AsInteger;
        weight:=temp_w;;
        Mintime:= FAdoDataSet1.FieldByName('Min_t').AsDateTime;
        Maxtime:= FAdoDataSet1.FieldByName('Max_t').AsDateTime;

       // dRecArry[PhaseNUmber].did:=PhaseNUmber;

        DRec.dAGVSupportMovePress:= FAdoDataSet1.FieldByName('MZL').AsFloat;
        if Group_AGV>(AGV_V) then   begin
            DRec.dString:= FAdoDataSet1.FieldByName('supportbh').AsString+',';
            DRec.PressSupportNumber :=DRec.PressSupportNumber +1;
        end;

         DRec.dRecordNumber:=0;
        //-----
        FAdoDataSet1.Next ;
        while not FAdoDataSet1.Eof do begin
            temp_w:=FAdoDataSet1.FieldByName('weight').AsFloat
                   /FAdoDataSet1.FieldByName('cn').AsFloat;

           if Min_V > FAdoDataSet1.FieldByName('Min_V').AsFloat then
                Min_V:= FAdoDataSet1.FieldByName('Min_V').AsFloat;
           if Max_V< FAdoDataSet1.FieldByName('Max_V').AsFloat then
                Max_V:= FAdoDataSet1.FieldByName('Max_V').AsFloat;
           if maxWeight< temp_w then  begin
               maxWeight:=temp_w;
               MaxWeightSupbh:=FAdoDataSet1.FieldByName('supportbh').AsInteger;
           end;
           if Mintime > FAdoDataSet1.FieldByName('Min_t').AsDateTime then
                Mintime:= FAdoDataSet1.FieldByName('Min_t').AsDateTime;
           if Maxtime < FAdoDataSet1.FieldByName('Max_t').AsDateTime then
                Maxtime:= FAdoDataSet1.FieldByName('Max_t').AsDateTime;


           Group_AGV:= FAdoDataSet1.FieldByName('AGV_V').AsFloat;
           Fangcha:= Fangcha+power(Group_AGV-AGV_V,2);
           weight:=weight+temp_w;
           if Group_AGV>(AGV_V) then begin   // 可以增加液压支架编号的字符字符串
              DRec.dString:= DRec.dString
                          + FAdoDataSet1.FieldByName('supportbh').AsString+',';
              DRec.PressSupportNumber :=DRec.PressSupportNumber +1;
           end;
           //
           DRec.dAGVSupportMovePress:=DRec.dAGVSupportMovePress+
                                    FAdoDataSet1.FieldByName('MZL').AsFloat;
           DRec.dRecordNumber:= DRec.dRecordNumber+FAdoDataSet1.FieldByName('CN').AsInteger;
           FAdoDataSet1.Next ;
        end;
        FAdoDataSet1.close;

         DRec.dMinData:= Min_V;
         DRec.dMaxData:= Max_V;
         DRec.dAGVData:= AGV_V;
         DRec.dAGvDataFangCha:=sqrt(Fangcha/DRec.dRecordNumber);
         DRec.dmaxWightSupbh:=Maxweightsupbh;
         DRec.dPressWeigth :=weight/DRec.dRecordNumber;
         DRec.MaxWeightValue :=maxWeight;
        // DRec.dFootage:=FootStep;
         DRec.GenerateTime:=Max_Time;
         DRec.dStartTime:=MinTime;
         DRec.dEndTime:=Maxtime;
         // 液压支架的末阻力是通过求平均的方式得到的
         DRec.dAGVSupportMovePress:=DRec.dAGVSupportMovePress/DRec.dRecordNumber;
         //判断液压支架超过均值的支架数量
         if DRec.PressSupportNumber >0  then  begin
            DRec.PressSupportProportion:=(DRec.PressSupportNumber/(DRec.dSupNumber+1))*100;
         end else begin
            DRec.PressSupportProportion:=0;
         end;
         Result:=true;
end;

function TFourthThread.FirstStepJudge(FGzmid, typeValue: string;
  var Rec: Prec): boolean;
var
  Sql:string;
  PrevStepFootage,MaxData:double;
  PrevStepEndTime:TdateTime;
  First_forcaseStep:double;
begin

       //如果没有标记，不用计算
    if Rec.secondJudge >0 then begin
          // 计算如果本次是来压步距，需要计算的数值
            sql:='select Footage,phase_endTime from D_' +Trim(FGzmid) +'_ThirdDP where ThirdJudge > 0' +
                 ' and phaseNumber =' +IntTostr(Rec.did) + ' and TypeData= ''' +typeValue +'''' +
                 ' order by footage desc limit 1 ';
           FAdoDataSet1.Close ;
           FAdoDataSet1.CommandText :=sql;

           if  (FAdoDataSet1.Open) and (FAdoDataSet1.RecordCount>0 ) then  begin    //如果前面有来压标记
              PrevStepFootage:= FAdoDataSet1.FieldByName('Footage').AsFloat;
              PrevStepEndTime:= FAdoDataSet1.FieldByName('phase_endTime').AsDateTime;
              FAdoDataSet1.Close ;
           end else begin  // 如果没有来压标记，取第一条记录
              sql:='select Footage from D_' +Trim(FGzmid) +'_ThirdDP   where  TypeData= ''' +typeValue +''''+
                   ' and phaseNumber =' +IntTostr(Rec.did) + ' order by footage  limit 1 ';
              FAdoDataSet1.Close ;
              FAdoDataSet1.CommandText :=sql;
              if FAdoDataSet1.Open then begin
                  Rec.DsystemMinfootage:=  FAdoDataSet1.FieldByName('Footage').Asfloat;
              end else begin
                  Rec.DsystemMinfootage:=0;
              end;
              FAdoDataSet1.Close ;
               // 把当前记录中最大的均值标记为来压
              if((Rec.dFootage-Rec.DsystemMinfootage > finGzm.Old_Step[0]*1.5) and ( Rec.DsystemMinfootage >0 ))
                 or (Rec.dFootage > finGzm.Old_Step[2]*4 ) then  begin
                  sql:='select Max(AGVDATA) as mx from D_' +Trim(FGzmid) +'_ThirdDP  where  phaseNumber =' +
                        IntTostr(Rec.did)+' and TypeData= ''' +typeValue +'''';

                  FAdoDataSet1.CommandText :=sql;
                  if FAdoDataSet1.Open then
                     MaxData:= FAdoDataSet1.FieldByName('mx').Asfloat;
                  FAdoDataSet1.Close ;
                   //
                  sql:='select id, phase_Endtime,footage from D_' +Trim(FGzmid) +'_ThirdDP  where  phaseNumber =' +IntTostr(Rec.did) +
                       ' and  AGVData >=' +floatToStr(MaxData) +' and TypeData= ''' +typeValue +'''';
                  FAdoDataSet1.CommandText :=sql;
                  if FAdoDataSet1.Open then begin
                      PrevStepEndTime:=FAdoDataSet1.FieldByName('phase_Endtime').AsDateTime;
                      PrevStepFootage:=FAdoDataSet1.FieldByName('footage').AsFloat;
                  end;
                  if (Rec.dFootage < finGzm.Old_Step[2]*5)  then begin
                     First_forcaseStep:=Rec.dFootage;
                  end else begin
                     First_forcaseStep:=Rec.dFootage-Rec.DsystemMinfootage+0.8;
                  end;

                  sql:=' update D_' +Trim(FGzmid) +'_ThirdDP  set ThirdJudge=1,forcasestep= '+
                       FormatFloat('0.00',First_forcaseStep) +
                       ' where id=' +FAdoDataSet1.FieldByName('id').AsString;
                  FAdoCommand.CommandText:=sql;
                  FAdoCommand.Execute ;
                  FAdoDataSet1.Close ;
              end else begin
                 PrevStepFootage:=0; PrevStepEndTime:=rec.dEndTime;
              end;
           end;

           //
           if PrevStepFootage >0 then begin
              Rec.ForeCase_step:=rec.dFootage-PrevStepFootage;
              // 如果在很长的时间内内有标记，把预测步距标记为-1 这种情况一般发生在 数据长时间无数的情况下
              if(Rec.ForeCase_step>FinGzm.Old_Step[2]*3) then Rec.ForeCase_step:=-1;

              Rec.stepStartTime:=PrevStepEndTime;

           end else begin
              Rec.ForeCase_step:=0;
              Rec.stepStartTime:=rec.dEndTime;
           end;
    end else begin
           Rec.ForeCase_step:=0;
           Rec.stepStartTime:=0;
    end;
end;

function TFourthThread.ForcaseDayJinChi(FGzmid, typeValue: string;
  PhaseNumber: integer): Boolean;
var
  sql:string;
  Downstep,upperStep:double;
begin
    Result:=false;
    sql:='select Sum(downfootage) as down_Step, Sum(upperfootage) as upper_Step  ' +
                 ' from  D_' +Trim(FGzmid) +'_footage '+
                 ' where  footday >=''' +FormatDateTime('yyyy-mm-dd hh:nn:ss',dFourRec.EndPresstime-1) +
                 ''' and  footday <=''' +FormatDateTime('yyyy-mm-dd hh:nn:ss',dFourRec.EndPresstime) +
                 ''' and processage >0 ' ;
      FAdoDataSet2.Close ;
      FAdoDataSet2.CommandText:=sql;
      if FAdoDataSet2.Open  then begin
          Downstep  := FAdoDataSet2.FieldByName('down_Step').AsFloat;
          upperStep := FAdoDataSet2.FieldByName('upper_Step').AsFloat;
      end;
      FAdoDataSet2.Close ;
      dFourRec.dayJinchi := Downstep+(UpperStep-Downstep)/RecArryNumber *(PhaseNumber-1);
      Result:=true;
end;

function TFourthThread.ForcaseOldPressure(FGzmid, typeValue: string;
  PhaseNumber: integer): Boolean;
var
  sql:string;
  ComPress_AGV,Steps_min,Steps_max:double;
  StartStep,EndStep,ComePressStep:double;
  CompFlag,Max_Data_id,Max_before_id:integer;
  BottomLine,Standardline,TopLine,Max_data,CompTemp:double;
  OldJudgeFlag:Boolean;
  CountComPress:integer;
begin
    Result:=false;
    Standardline:=300; //FinGzm.Old_Step[2]*3;
    BottomLine:=Standardline*(100-10)/100;  // 50
    TopLine:=Standardline*(100+10)/100;    //50
    //
    sql:='select max(ComePressLevel) as Max_C,AVG(ComePressLevel) as AGV_C,Count(id) as CN,min(end_steps) as Min_steps , ' +
       ' max(end_steps) as Max_steps  from   D_' +Trim(FGzmid) +'_forcase ' +
       '  where  process =0   and phaseNumber =' +  IntTostr(PhaseNumber) +' and typedata = '''+typeValue+ '''  ' ;
    FAdoDataSet1.Close;
    FAdoDataSet1.CommandText:=sql;
    if  FAdoDataSet1.Open then begin
        if FAdoDataSet1.FieldByName('CN').AsInteger< 2 then  begin
          Result:=true;     FAdoDataSet1.Close ;     exit;  //退出计算
        end;

        ComPress_AGV:= FAdoDataSet1.FieldByName('AGV_C').AsFloat;
        Steps_min:= FAdoDataSet1.FieldByName('Min_steps').AsFloat;
        Steps_max:= FAdoDataSet1.FieldByName('Max_steps').AsFloat;
    end;
    FAdoDataSet1.Close;
    // 查找已经计算过的平均值
    sql:='select AVG(ComePressLevel) as AGV_C,Count(id) as CN  from   D_' +Trim(FGzmid) +'_forcase ' +
       '  where  process >0    and phaseNumber =' +  IntTostr(PhaseNumber) +' and typedata = '''+typeValue+ '''  ' ;
    FAdoDataSet1.CommandText:=sql;
    if FAdoDataSet1.Open then begin
        ComPress_AGV:= FAdoDataSet1.FieldByName('AGV_C').AsFloat;
        CountComPress:=FAdoDataSet1.FieldByName('CN').AsInteger;
    end;
    FAdoDataSet1.Close;

    if (Steps_min > TopLine +FinGzm.Old_Step[2]*3 )  or
     ((Steps_min  < BottomLine) and (Steps_max < BottomLine))  then      OldJudgeFlag:=false
       else    OldJudgeFlag:=true;

    if (OldJudgeFlag) then   begin
        sql:='select * from   D_' +Trim(FGzmid) +'_forcase  where  end_steps>=  ' + FormatFloat('0.00',0) +
           ' and phaseNumber =' +  IntTostr(PhaseNumber) +' and typedata = '''+typeValue+
           ''' order by end_steps  ' ;
    end else begin
        sql:='select * from   D_' +Trim(FGzmid) +'_forcase  where  end_steps>=  ' + FormatFloat('0.00',Steps_min-FinGzm.Old_Step[2]*3) +
           ' and phaseNumber =' +  IntTostr(PhaseNumber) +' and typedata = '''+typeValue+
           ''' order by end_steps  ' ;
    end;

    FAdoDataSet1.CommandText:=sql;
    if FAdoDataSet1.Open then begin
        if FAdoDataSet1.RecordCount< 4 then  begin
          Result:=true;
          FAdoDataSet1.Close ;
          exit;;  //退出循环
        end;
        FAdoDataSet1.First ;
        StartStep:=FAdoDataSet1.FieldByName('start_steps').AsFloat;
        Max_data:=0; Max_Data_id:=0;Max_before_id:=0;
        while not FAdoDataSet1.Eof  do begin
          if FDisPose.FourthProcessStop then  break; //  循环退出机制 then
          EndStep:=FAdoDataSet1.FieldByName('end_steps').AsFloat;
          CompTemp:=FAdoDataSet1.FieldByName('ComePressLevel').AsFloat;
          // 把原来初次来压清除
          if (FAdoDataSet1.FieldByName('OldToPressure').AsInteger >1) and (OldJudgeFlag) then begin
               Max_Data_id:=FAdoDataSet1.FieldByName('id').AsInteger;
               Max_data:= FAdoDataSet1.FieldByName('AGVData').AsFloat;
               ComePressStep:=EndStep;
               self.UpdataForcaseData(FGzmid,Max_Data_id,0,0,0);
          end else if FAdoDataSet1.FieldByName('OldToPressure').AsInteger =1 then begin
               StartStep:=FAdoDataSet1.FieldByName('end_steps').AsFloat;
          end;

          // 标记普通或者周期来压
          if (EndStep-Startstep > FinGzm.Old_Step[2] *0.8)  and (CompTemp >= ComPress_AGV)
             and (FAdoDataSet1.FieldByName('OldToPressure').AsInteger < 1) then  begin
             ComePressStep:=EndStep-Startstep;
             CompFlag:=1;
             self.UpdataForcaseData(FGzmid,FAdoDataSet1.FieldByName('id').AsInteger,CompFlag,ComePressStep,
                MakeForCaseNextStep(FGzmid,typeValue,PhaseNumber,EndStep,ComePressStep));
             StartStep:=FAdoDataSet1.FieldByName('end_steps').AsFloat;
          end;
          //重新标注初次来压
          if (EndStep>=BottomLine )  and  (EndStep<=TopLine )   and (OldJudgeFlag)// and  (CompTemp >= ComPress_AGV)
              and (FAdoDataSet1.FieldByName('AGVData').AsFloat > Max_data)  then begin
                 Max_data:= FAdoDataSet1.FieldByName('AGVData').AsFloat;
                 Max_Data_id:=FAdoDataSet1.FieldByName('id').AsInteger;
                 ComePressStep:=EndStep;
          end;
          if (Max_Data_id >0) and (OldJudgeFlag)  then   begin
              if Max_before_id>0  then
                 self.UpdataForcaseData(FGzmid,Max_before_id,0,0,0);
              self.UpdataForcaseData(FGzmid,Max_Data_id,2,ComePressStep,0);
              Max_before_id:=Max_Data_id;
              Max_Data_id:=0;
              StartStep:=FAdoDataSet1.FieldByName('end_steps').AsFloat;
          end;
          // 更新 平均值
          ComPress_AGV:=(ComPress_AGV*CountComPress+FAdoDataSet1.FieldByName('ComePressLevel').AsInteger)/(CountComPress+1);
          CountComPress:=CountComPress+1;

          FAdoDataSet1.Next ;
        end;
    end;
    FAdoDataSet1.Close ;

     sql:='update D_' +Trim(FGzmid) +'_Forcase  set  process = 1' +
          ' where end_steps < ' +FormatFloat('0.00', EndStep)+ ' and process=0 ' +
          ' and phaseNumber =' +  IntTostr(PhaseNumber) +' and typedata = '''+typeValue+ '''  ' ;

     FAdoCommand.CommandText:=sql;
     FAdoCommand.Execute;

    Result:=true;

end;

function TFourthThread.ForcasePressIntensity(secondJudge, thirdJudge: double;
  OST: integer): Integer;
var
  PressIntenSity :integer;
  St,Et:double;
begin

  PressIntenSity:=0;
  if (dFourRec.eachsteps> dFourRec.AGVStep ) then  PressIntenSity:=PressIntenSity+1;
  if (dFourRec.CycleSecondJudge> dFourRec.AGVSecondJudge)then  PressIntenSity:=PressIntenSity+1;

    st:= dFourRec.thirdJ_AGV-(dFourRec.thirdJ_AGV-1)/3;
    et:= dFourRec.thirdJ_AGV+(dFourRec.thirdJ_Max-dFourRec.thirdJ_AGV)/3;
    if thirdJudge < st then   begin
       PressIntenSity:=PressIntenSity+1;
    end else if thirdJudge < et then  begin
       PressIntenSity:=PressIntenSity+2;
    end else begin
       PressIntenSity:=PressIntenSity+3;
    end;

   Result:= PressIntenSity;
end;

function TFourthThread.ReturnPressStartTime(secondJudge: double;OST:integer;DT:Tdatetime): Integer;
begin
   //判断返回值, 标注 来压显著阶段开始
    if (secondJudge > dFourRec.CycleSecondJudge) and (OST=0) then  begin
        Result:=1;   dFourRec.OutStandComePressStartTime:=DT;
    end else if (secondJudge < dFourRec.CycleSecondJudge) and (OST=1) then begin
        Result:=0;
    end else begin
        Result:=OST;
    end;
end;

function TFourthThread.ForCaseRockPress(FGzmid: string; var TotalCount: integer;
  var elapsedtime: string): Boolean;
var
  i,FootStep:integer;
  elapsedMilliseconds : cardinal;
  sql:string;
  UsedField:TSupportDataType;
begin
    // 支架 预测数据
    //=====
 Result:=true;
 FDisPose.SetFourthProcessStop(false);

 try
    totalnumber:=0;
    self.IntiArrayDrec;
     // 读取可用的字段数据类型
    if not FinGzm.FillDataType_SupportType(StrToint(FGzmbh)) then  exit;

    for i := 0 to FinGzm.IsUesedsupFieldcount-1 do  begin
        if FDisPose.FourthProcessStop then  break; //  循环退出机制
        UsedField:=TSupportDataType(GetEnumValue(TypeInfo(TSupportDataType),FinGzm.IsUesedsupFieldName[i]));
       if  (UsedField= FrontPressData) or  ( UsedField =BehindPressData ) or (UsedField =LeftPressData)
                   or (UsedField  =RightPressData ) then   begin
               //循环遍历 工作面划分的区域
               for FootStep := 1 to RecArryNumber do   begin
                    if FDisPose.FourthProcessStop then  break; //  循环退出机制
                     //分区段查找记录
                     ForcaseThirdTable(FGzmid,FinGzm.IsUesedsupFieldName[i],FootStep,0.8);
                     //分区段标记来压情况
                     ForcaseOldPressure(FGzmid,FinGzm.IsUesedsupFieldName[i],FootStep);
               end;
         end;
     end; //end for
 except
    Result:=false;
 end;
end;

function TFourthThread.ForCAseSelectCycleSecond(FGzmid, typeValue: string;
  PhaseNumber: integer; FootS, FootE:double): Boolean;
begin
     FAdoDataSet2.Close ;
     FAdoDataSet2.CommandText :=' select AVG(SecondJudge) as SCJ from  D_' +Trim(FGzmid) +'_ThirdDP '+
         ' where phaseNumber =' +  IntTostr(PhaseNumber) + '  and TypeData=''' + typeValue +'''' +
         ' and footage >=' +FormatFloat('0.00',FootS) + ' and   footage <='  +
         FormatFloat('0.00',FootE) ;
     if FAdoDataSet2.Open  then
        dFourRec.CycleSecondJudge:= FAdoDataSet2.FieldByName('SCJ').AsFloat;
     FAdoDataSet2.Close ;

     FAdoDataSet2.CommandText :=' select max(ForcaseNumber) as FN from  D_' +Trim(FGzmid) +'_ForCase '+
         ' where phaseNumber =' +  IntTostr(PhaseNumber);
     if FAdoDataSet2.Open  then
        dFourRec.ForcaseNumber:= FAdoDataSet2.FieldByName('FN').AsInteger+1;
     FAdoDataSet2.Close ;
end;

function TFourthThread.ForcaseSelectData(FGzmid, typeValue: string;
  PhaseNumber: integer; FootageInterval: double): Boolean;
var
   sql:string;
begin
    Result:=false;
    sql:='select AVG(SecondJudge) as SCJ  from  D_' +Trim(FGzmid) +'_ThirdDP '+
        ' where phaseNumber =' +  IntTostr(PhaseNumber) + '  and TypeData=''' + typeValue +'''' +
        ' and SecondJudge > 0  ';
    FAdoDataSet1.Close ;
    FAdoDataSet1.CommandText:=sql;
    if FAdoDataSet1.Open then
       dFourRec.AGVSecondJudge:= FAdoDataSet1.FieldByName('SCJ').AsFloat;
    FAdoDataSet1.Close ;

    sql:='select AVG(ThirdJudge) as AVG_T, Max(ThirdJudge) As MAX_T from  D_' +Trim(FGzmid) +'_ThirdDP '+
        ' where phaseNumber =' +  IntTostr(PhaseNumber) + '  and TypeData=''' + typeValue +'''' +
        ' and ThirdJudge > 0  ';
    FAdoDataSet1.Close ;
    FAdoDataSet1.CommandText:=sql;
    if FAdoDataSet1.Open then  begin
      dFourRec.thirdJ_AGV:=FAdoDataSet1.FieldByName('AVG_T').AsFloat;
      dFourRec.thirdJ_Max:=FAdoDataSet1.FieldByName('MAX_T').AsFloat;
    end;
    FAdoDataSet1.Close ;
    Result:=true;
end;

function TFourthThread.ForcaseThirdTable(FGzmid, typeValue: string;
         PhaseNumber:integer;FootageInterval:double): Boolean;
var
  sql:string;
  AGV_Step_All,Max_step,Min_step:double;

  Start,OutStandComePressState:integer;
begin
    Result:=false;
    //   查找 第二次与第三次判断数据
    ForcaseSelectData(FGzmid, typeValue, PhaseNumber,FootageInterval);

    sql:='select *  from   D_' +Trim(FGzmid) +'_ThirdDP  where  process <2 and ' +
       ' forCase_info_ed <1  and  footage > 0 and phaseNumber =' +  IntTostr(PhaseNumber) +
       ' and typedata = '''+typeValue+''' order by footage  ' ;
    FAdoDataSet1.CommandText:=sql;
    if FAdoDataSet1.Open then begin
        if FAdoDataSet1.RecordCount< 1 then  begin
          Result:=true;
          FAdoDataSet1.Close ;
          exit;;  //退出循环
        end;

        FAdoDataSet1.First;
        Start:=0;
        OutStandComePressState:=0;

       while not  FAdoDataSet1.Eof do begin
            if FDisPose.FourthProcessStop then  break; //  循环退出机制 then
            if start=0 then  begin       // 开始
               Start:=1;
               dFourRec.startfootage:=FAdoDataSet1.FieldByName('Footage').AsFloat;
               dFourRec.ComePressStarttime:=FAdoDataSet1.FieldByName('phase_startTime').AsDateTime;
               dFourRec.startSupid:=FAdoDataSet1.FieldByName('Startbh').AsInteger ;
               dFourRec.EndSupid:=FAdoDataSet1.FieldByName('endbh').AsInteger ;
            end;

            if  FAdoDataSet1.FieldByName('thirdjudge').AsInteger>0  then begin  //结束标记
               dFourRec.endfootage:=FAdoDataSet1.FieldByName('Footage').AsFloat;
               dFourRec.EndPresstime:=FAdoDataSet1.FieldByName('phase_EndTime').AsDateTime ;

               dFourRec.startfootage:=dFourRec.endfootage- FAdoDataSet1.FieldByName('ForCaseStep').AsFloat;
               dFourRec.eachsteps:=dFourRec.endfootage- dFourRec.startfootage;
               dFourRec.AGVStep:=FAdoDataSet1.FieldByName('UsedOLdStep').AsFloat;
               dFourRec.OutStandSupport:=FAdoDataSet1.FieldByName('SupString').AsString;
               dFourRec.AGVData:=FAdoDataSet1.FieldByName('AGVData').AsFloat;
               dFourRec.SupportBeforeMoveData:=FAdoDataSet1.FieldByName('AGVMovePress').AsFloat;
               dFourRec.generatetime :=now();
               Start:=0;
               //查找记录
               ForCAseSelectCycleSecond(FGzmid, typeValue,PhaseNumber, dFourRec.startfootage, dFourRec.endfootage);
               // 查找当天在该区域的进尺
               ForcaseDayJinChi(FGzmid,typeValue,PhaseNumber); //

               if  OutStandComePressState=0  then
                   dFourRec.OutStandComePressStartTime:=FAdoDataSet1.FieldByName('ForCaseStep_St').AsDateTime;
               // 判断本次来压的强度
                dFourRec.ComePressLevel:=ForcasePressIntensity (FAdoDataSet1.FieldByName('SecondJudge').AsInteger,
                    FAdoDataSet1.FieldByName('ThirdJudge').AsInteger,OutStandComePressState );
               //  保存数据
               SaveFourthProcessData(FGzmid, typeValue,PhaseNumber);
               //把来压状态清空
               OutStandComePressState:=0;
            end;

            //判断显著来压时刻
            OutStandComePressState:=ReturnPressStartTime(FAdoDataSet1.FieldByName('SecondJudge').AsInteger,
              OutStandComePressState, FAdoDataSet1.FieldByName('phase_startTime').AsDateTime);

           FAdoDataSet1.Next ;
        end; //end while

    end;
   FAdoDataSet1.Close;
   Result:=True;

end;

function TFourthThread.idDataValidity(dGzmid, typeValue: string; Minsupid,Maxsupid: integer;IntervalTime:double;
      Min_time,Max_time:TdateTime; Var R_Min_Time,R_Max_Time:TdateTime ): Boolean;
var
  Sql:string;
  FG:double;
  Xhbh,ZeroCount:integer;
  Flag:Boolean;
  LeftSupNO,RightSupNo,supportCount:Integer;
  MAX_T,i_Time:TdateTime;
begin
   Result:=False;
   //Max ***

    i_Time:=Min_time;
    Flag:=true;

 while (Flag) and (i_Time < Max_time) do  begin
    if FDisPose.ThirdProcessStop   then begin
        Result:=False;break;
    end;
    sql:='select Min(endtime) as ET,supportbh  from D_'+trim(dGzmid)+'_Seconddp  where process=0  and  Footage >0 and TypeData= '''+
                  typeValue+'''  and supportbh >='+ IntToStr(Minsupid) +  ' and  supportbh <='+ IntToStr(Maxsupid)  +
                  ' and endTime <= '''+FormatDateTime( 'yyyy-mm-dd hh:nn:ss',i_Time+IntervalTime) +'''' +
                  ' Group by supportbh order by Supportbh ';
    FAdoDataSet1.Close ;
    FAdoDataSet1.CommandText :=sql;
    if FAdoDataSet1.Open then begin
        LeftSupNO:=0;
        supportCount:=0;
        R_Min_Time:= Min_time;
        R_Max_Time :=FAdoDataSet1.FieldByName('ET').AsDateTime;
        while not FAdoDataSet1.Eof  do  begin
           if FDisPose.ThirdProcessStop   then  begin
              Flag:=false; break;
           end;
           if LeftSupNO <> FAdoDataSet1.FieldByName('supportbh').AsInteger Then begin
              supportCount:=supportCount+1;
              LeftSupNO:=FAdoDataSet1.FieldByName('supportbh').AsInteger;
              if R_Min_Time > FAdoDataSet1.FieldByName('ET').AsDateTime then
                 R_Min_Time:=FAdoDataSet1.FieldByName('ET').AsDateTime;
              if (R_Max_Time < FAdoDataSet1.FieldByName('ET').AsDateTime)  then
                  R_Max_Time:=FAdoDataSet1.FieldByName('ET').AsDateTime;

           end;
          if (supportCount >=(Maxsupid-Minsupid+1)/4)  or
             (LeftSupNO >Minsupid+(Maxsupid-Minsupid+1)/2)  then  begin
              break;
          end;
          FAdoDataSet1.Next;
        end;
    end;

    if (supportCount <(Maxsupid-Minsupid+1)/4)  then  begin
       i_Time:=i_Time+IntervalTime;
       continue;
    end;

    //  右侧
    sql:='select Min(endtime) as ET,supportbh  from D_'+trim(dGzmid)+'_Seconddp  where process=0  and  Footage >0 and TypeData= '''+
                  typeValue+'''  and supportbh >='+ IntToStr(Minsupid) +  ' and  supportbh <='+ IntToStr(Maxsupid)  +
                  ' and endTime <= '''+FormatDateTime( 'yyyy-mm-dd hh:nn:ss',i_Time+IntervalTime) +'''' +
                  ' Group by supportbh order by Supportbh desc';
    FAdoDataSet1.Close ;
    FAdoDataSet1.CommandText :=sql;
    if FAdoDataSet1.Open then begin
        supportCount:=0;
        RightSupNo:=0;
        FAdoDataSet1.First;
        while not FAdoDataSet1.EoF  do  begin
           if FDisPose.ThirdProcessStop   then  begin
              Flag:=false; break;
           end;
           if RightSupNo <> FAdoDataSet1.FieldByName('supportbh').AsInteger Then begin
              supportCount:=supportCount+1;
              RightSupNo:=FAdoDataSet1.FieldByName('supportbh').AsInteger;
              if R_Min_Time > FAdoDataSet1.FieldByName('ET').AsDateTime then
                 R_Min_Time:=FAdoDataSet1.FieldByName('ET').AsDateTime;
              if (R_Max_Time < FAdoDataSet1.FieldByName('ET').AsDateTime)  then
                  R_Max_Time:=FAdoDataSet1.FieldByName('ET').AsDateTime;

           end;
          if (supportCount >=(Maxsupid-Minsupid+1)/4) or
             (RightSupNo <Maxsupid-(Maxsupid-Minsupid+1)/2)   then  begin

             break;
          end;
          FAdoDataSet1.Next ;
        end;
    end;

    if (supportCount <(Maxsupid-Minsupid+1)/4)  then begin
       i_Time:=i_Time+IntervalTime;
       continue;
    end;
    // 退出标记
     Flag:=false;
     Result:=true;

    FAdoDataSet1.Close ;
 end;
end;



procedure TFourthThread.initPFourRec(pd: PFourRec);
begin
  pd.generatetime :=-1;
  pd.Phasenumber :=0;
  pd.ForcaseNumber :=0;
  pd.eachsteps :=0;
  pd.startfootage :=0;
  pd.endfootage :=0;
  pd.startSupid :=0;
  pd.EndSupid :=0;
  pd.ComePressStarttime :=-1;
  pd.EndPresstime :=-1;
  pd.OutStandComePressStartTime :=-1;
  pd.OutStandSupport :='';
  pd.AGVStep :=0;
  pd.dayJinchi :=0;
  pd.ComePressLevel :=0;
  pd.AGVSecondJudge :=0;
  pd.CycleSecondJudge :=0;
  pd.thirdJ_AGV :=0;
  pd.AGVData :=0;
  pd.SupportBeforeMoveData :=0;
  pd.OldToPressure :=0;
  pd.OldToPressureStep :=0;

end;

function TFourthThread.InsertDatabase(FGzmid, typeValue: string;
  DRec: PRec): Boolean;
var
  sql:string;
begin
   Result:=false;

   try
    FAdoCommand.MySqlConnection.BeginTrans ;
       //insert database
    sql:='insert into D_' +Trim(FGzmid) +'_ThirdDP  (footage,phaseNumber,startbh,endbh,' +
         'supNumber,Mindata,Maxdata,AGVdata,Fangcha,Maxweightsup,Pressweight,Firstjudge, '+
         'supString,typedata,RecordNumber,Phase_starttime,Phase_Endtime,maxweightValue,'+
         'forcasestep,forcasestep_st,forcasestep_et,Judgelevel,SecondJudge,thirdJudge,AGVMovePress,  '+
         'PressSupportNumber,PressSupportProportion, ' +
         'process,forCase_info_ed,UsedOldStep,EditOldStep,Start_footage,End_Footage,Generatetime ) values ( '+
         FormatFloat('0.00',DRec.dFootage )+' ,' +
         Inttostr(DRec.did )+' ,' + Inttostr(DRec.dSupStartBh )+' ,' +
         Inttostr(DRec.dSupEndBh )+' ,' +Inttostr(DRec.dSupNumber )+' ,' +
         Floattostr(DRec.dMinData )+' ,' + Floattostr(DRec.dMaxData )+' ,' +
         Floattostr(DRec.dAGvData )+' ,' + Floattostr(DRec.dAGvDataFangCha )+' ,' +
         intToStr(DRec.dmaxWightSupbh )+' ,' + Floattostr(DRec.dPressWeigth )+' ,' +
         intToStr(DRec.Firstjudge )+' ,''' +DRec.dString+''' ,''' +
         typeValue+''', '+intToStr(DRec.dRecordNumber)+ ',''' +
         FormatDateTime('yyyy-mm-dd hh:nn:ss',DRec.dStartTime)+''','''+
         FormatDateTime('yyyy-mm-dd hh:nn:ss',DRec.dEndTime)+''','+
         FloatToStr(DRec.MaxWeightValue)+','+ FormatFloat('0.00',DRec.ForeCase_step)+','''+
         FormatDateTime('yyyy-mm-dd hh:nn:ss',DRec.stepStartTime)+''','''+
         FormatDateTime('yyyy-mm-dd hh:nn:ss',DRec.dEndTime)+''','+
         Floattostr(DRec.judgeLeval  )+','+intToStr(DRec.secondJudge )+' ,' +
         intToStr(DRec.thirdjudge )+' ,' +  Floattostr(DRec.dAGVSupportMovePress )+','+
         intToStr(DRec.PressSupportNumber ) +','+ FormatFloat('0.00',DRec.PressSupportProportion) +','+
         IntToStr(ProcessTime)+',0,'+Floattostr(FinGzm.Old_Step[2])+',0, '+
         FormatFloat('0.00',DRec.StartFootage )+' ,' +FormatFloat('0.00',DRec.endfootage )+' ,''' +
         FormatDateTime('yyyy-mm-dd hh:nn:ss',DRec.Generatetime )+''''+
         ')';
      FAdoCommand.CommandText:=sql;
      FAdoCommand.Execute ;
      //
       //更新处理记录
      sql:=    ' update  D_'+trim(FGzmid)+'_Seconddp  set process= 1' +
               ' where  endTime <= '''+FormatDateTime( 'yyyy-mm-dd hh:nn:ss',DRec.dEndTime) +'''' +
               ' and supportbh >= ' + IntTostr(DRec.dSupStartBh) +
               ' and supportbh <= ' + IntToStr(DRec.dSupEndBh) +
               ' and TypeData= '''+typeValue+'''' ;
      FAdoCommand.CommandText:=sql;
      FAdoCommand.Execute ;
       //----
      totalnumber:=totalnumber+1;
      FAdoCommand.MySqlConnection.CommitTrans;
   finally
     Result:=true;
   end;
end;

procedure TFourthThread.insertOrUpdateData(Sql: string);
begin
      FAdoCommand.CommandText:=sql;
      FAdoCommand.Execute ;
end;

function TFourthThread.IntiArrayDrec: Boolean;
var
  SumSupportNumber:integer;
  MinSupBh,MaxSupbh,MidSupbh:integer;
  i,j:integer;

begin
      RecArryNumber:=FinGzm.RecArryNumber;
      for j := 1 to RecArryNumber do   begin
        dRecArry[j].dSupStartBh :=FinGzm.dRecArry[j][0] ;
        dRecArry[j].dSupEndBh  :=FinGzm.dRecArry[j][1];
        dRecArry[j].did :=j;
        dRecArry[j].dSupNumber :=dRecArry[j].dSupEndBh-dRecArry[j].dSupStartBh +1;
        dRecArry[j].PressSupportNumber :=0;
        dRecArry[j].dString:='';
      end;

end;


function TFourthThread.isUsedFootage(dGzmid, typeValue: string; Minsupid,
  Maxsupid: integer; Min_Time,Max_Time: TDateTime; var MinFootage,
  MaxFootage,AGVFootage: double): Boolean;
var
 sql:string;
begin
    Result:=True;
    sql:='select Min(Footage) as Min_F, max(Footage) as Max_F,AVG(Footage) as AGV_F from D_'+trim(dGzmid)+'_Seconddp' +
           ' where process=0  and  Footage >0 and TypeData= '''+ typeValue+''' ' +
           ' and supportbh >= '+ IntToStr(Minsupid) + ' and supportbh <= '+ IntToStr(Maxsupid)  +
           ' and endTime >= '''+FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Min_Time) +'''' +
           ' and endTime <= '''+FormatDateTime( 'yyyy-mm-dd hh:nn:ss',Max_Time) +'''' ;

    FAdoDataSet1.Close ;
    FAdoDataSet1.CommandText :=sql;
    if FAdoDataSet1.Open then begin
        MinFootage:= FAdoDataSet1.FieldByName('Min_F').AsFloat;
        MaxFootage:= FAdoDataSet1.FieldByName('Max_F').AsFloat;
        AGVFootage:= FAdoDataSet1.FieldByName('AGV_F').AsFloat;
    end;
    FAdoDataSet1.Close ;

end;

function TFourthThread.JudgeMAXFootageFalg(FGzmid, typeValue: string;
      PhaseNumber:integer;StartFootage,endFootage,FootageInterval:double): double;
var
  Sql:string ;
  tempfootage:double;
  inid:integer;
begin
    Result:=-1;
    Sql:=  'select id,AGVData,footage,SecondJudge,Forcasestep,AGVMovePress,ThirdJudge from D_' +Trim(FGzmid) +'_ThirdDP where Footage > ' +
              FormatFloat('0.00',StartFootage) + ' and Footage <='+  FormatFloat('0.00',endFootage) +
              ' and phaseNumber =' +IntTostr(PhaseNumber) + ' and TypeData= ''' +typeValue +
              ''' and secondjudge>0 order by AGVData desc ,AGVMovePress desc limit 5 ';
    FAdoDataSet2.Close ;
    FAdoDataSet2.CommandText:=sql;
    if FAdoDataSet2.Open  then
        while not FAdoDataSet2.eof do begin
           tempfootage:=FAdoDataSet2.FieldByName('footage').AsFloat;
           inid:= FAdoDataSet2.FieldByName('id').AsInteger;
           if (tempfootage-StartFootage) > FinGzm.Old_Step[2]*0.2 then  begin  // FinGzm.Old_Step[2]*0.4
             sql:=' update D_' +Trim(FGzmid) +'_ThirdDP  set ThirdJudge= 1 ' +
                 ' ,forcasestep= '+ FormatFloat('0.00',tempfootage-StartFootage)+
                 ' where id =' +intToStr(inid);

             FAdoCommand.CommandText:=sql;
             FAdoCommand.Execute ;
             Result:=tempfootage;
             break;
           end;
          FAdoDataSet2.Next;
        end;
    FAdoDataSet2.Close ;
end;

function TFourthThread.MakeForCaseNextStep(FGzmid, typeValue: string;
  PhaseNumber: integer; NowFootage,FirstStep: double): Double;
var
  SecondStep,ThirdStep:double;
  K_1,K_2,K_3: double;
  sql:string;
begin
   SecondStep:=0;ThirdStep:=0;
    sql:='select OldToPressureStep  from   D_' +Trim(FGzmid) +'_forcase  where  end_steps <  ' + FormatFloat('0.00',NowFootage) +
   ' and phaseNumber =' +  IntTostr(PhaseNumber) +' and typedata = '''+typeValue+
   '''  and OldToPressure=1  order by end_steps desc   ' ;
    FAdoDataSet2.Close ;
    FAdoDataSet2.CommandText:=sql;
    if FAdoDataSet2.Open  then begin
        if FAdoDataSet2.RecordCount <1 then  begin
            K_1:=1;K_2:=0;K_3:=0;
        end else if FAdoDataSet2.RecordCount =1 then begin
            K_1:=0.6;K_2:=0.4;K_3:=0;
        end else begin
            K_1:=0.5;K_2:=0.3;K_3:=0.2;
        end;
        while not FAdoDataSet2.eof do begin
           if FAdoDataSet2.RecNo =1 then  SecondStep:=FAdoDataSet2.FieldByName('OldToPressureStep').AsFloat;
           if FAdoDataSet2.RecNo =2 then  ThirdStep:=FAdoDataSet2.FieldByName('OldToPressureStep').AsFloat;
           if FAdoDataSet2.RecNo =3 then  break;
        FAdoDataSet2.Next;
        end;
    end;
    FAdoDataSet2.Close ;
    Result:=K_1* FirstStep+K_2* SecondStep+K_3*ThirdStep;
end;

function TFourthThread.RebalanceDataBase_Core(FGzmid,typeValue: string;
  var DRec: Prec): boolean;
var
  ReturnS,sql:string;
  RetuenFootage:double;
  ThirdJudgeCount:integer;
  Jdl,OLS:double;

begin
    Result:=False;
    //获得老顶基本运动参数，运动参数放入到 FinGzm的 Old_Step数组中
    ReturnS:=FinGzm.Get_PStope_OldInfo;
    //查找前一个来压的 判断水平与 步距
    SelectJudgeLevel(FGzmid,typeValue,Drec.did,Jdl,OLS ) ;

    if Jdl=0 then Drec.judgeLeval:=Pub_judgeLeval;
    if OLS>0  then  FinGzm.Old_Step[2]:= OLS;
    if not  RebalanceDataBase_First_FillData(FGzmid,typeValue,DRec) then  exit;
    // 第一次对周期来压关系的判断
    DRec.firstjudge := RebalanceDataBase_First_Judge(DRec);
    //第二次判断 周期来压 液压阀 压力等数据
    DRec.secondJudge := RebalanceDataBase_Second_Judge(DRec);
    // 第三次判断  通过均值系列判断 表明曲线出现翻转  忠实标注数据曲线拐点

    ThirdJudgeCount:=0;
   {
      （1）如果前一条记录的第二次判断 系数大于零
      （2）前一个记录的平均值大于当前平均 或者 前一个记录的末阻力大于当前末阻力

       处理方式：把前面的一条记录变成拐点
   }
   if ((DREc.prev_Record_SecondJudge >0) and
          ( (DRec.prev_Record_AGV_data>=DRec.dAGvData) or
            (DRec.prev_Record_BeforeMovePress > DRec.dAGVSupportMovePress)
          )
       ) then  begin
       //继续判断   查找 当前数据库中 前一条判断 是来压步距的 记录
       ThirdJudgeCount:= RebalanceDataBase_Third_Judge(FGzmid,typeValue,DRec);
       {如果判断的值 大于1 ，证明具备标注的条件，把该条记录进行 来压 标注}
       if ThirdJudgeCount >0  then   begin
           sql:=' update D_' +Trim(FGzmid) +'_ThirdDP  set ThirdJudge= '+ IntToStr( ThirdJudgeCount)+
                ' where id =' +intToStr(DRec.prev_Record_id);    // 这是判断放入第一条来压记录 标记
           FAdoCommand.CommandText:=sql;
           FAdoCommand.Execute ;
       end;

      {系统通过前面十个来压步距的均值来调整使用的来压步距}
      // EditOldStep(FGzmid,typeValue,DRec.did,DRec.dFootage);
   end;
     //本次 赋值为0
   DRec.thirdjudge :=0;
   Result:=true;
end;



function TFourthThread.RebalanceDataBase_First_FillData(FGzmid,
  typeValue: string; var DRec: Prec): boolean;
var
  Sql:String;
begin
   Result:=True;
   try
     sql:='select AVG(AGVData) as AGVData,AVG(FangCha) as AGVFangcha, AVG(Pressweight) as ' +
      ' AGVWeight ,AVG(Firstjudge) as FJ , AVG(secondJudge)as SF,AVG(AGVMovePress) as AVGMZL '+
      '  from D_' +  Trim(FGzmid) +'_ThirdDP where Footage >=' +
      FloatToStr(DRec.dFootage-FinGzm.Old_Step[2]*2) + ' and phaseNumber =' +IntTostr(DRec.did) +
      ' and TypeData= ''' +typeValue +'''';
     FAdoDataSet1.Close ;
     FAdoDataSet1.CommandText :=sql;
     if  FAdoDataSet1.Open then
        if  FAdoDataSet1.RecordCount>0  then  begin
            DRec.Prev_TwoStep_AGV_Data:= FAdoDataSet1.FieldByName('AGVData').Asfloat;
            DRec.Prev_TwoStep_AGV_Fangcha:= FAdoDataSet1.FieldByName('AGVFangcha').Asfloat;
            DRec.Prev_TwoStep_AGV_Weight:= FAdoDataSet1.FieldByName('AGVWeight').Asfloat;
            DRec.Prev_TwoStep_AGV_FirstJudge:=FAdoDataSet1.FieldByName('FJ').Asfloat;
            DRec.Prev_TwoStep_AGV_SecondJudge:=FAdoDataSet1.FieldByName('SF').Asfloat;
            DRec.Prev_TwoStep_AGV_BeforeMovePress:= FAdoDataSet1.FieldByName('AVGMZL').Asfloat;
         end;
     FAdoDataSet1.Close ;
     //
     sql:='select id,AGVData,FangCha,footage,SecondJudge,Forcasestep,AGVMovePress from D_' +Trim(FGzmid) +
           '_ThirdDP where generatetime <=''' +   FormatDateTime( 'yyyy-mm-dd hh:nn:ss',DRec.Generatetime) +'''' +
           ' and TypeData= ''' +typeValue +'''' +
           ' and phaseNumber =' +IntTostr(DRec.did) +  ' and secondJudge >0 '+
           ' order by footage desc limit 1 ';
     FAdoDataSet1.Close ;
     FAdoDataSet1.CommandText :=sql;
     if FAdoDataSet1.Open then
        if  FAdoDataSet1.RecordCount>0  then  begin
            DRec.prev_Record_id:=   FAdoDataSet1.FieldByName('id').AsInteger;
            DRec.prev_Record_AGV_data:= FAdoDataSet1.FieldByName('AGVData').Asfloat;
            DRec.prev_Record_Fangcha:= FAdoDataSet1.FieldByName('Fangcha').Asfloat;
            DRec.prev_Record_SecondJudge:=FAdoDataSet1.FieldByName('SecondJudge').AsInteger;
            DRec.prev_Record_ForeCaseStep:=FAdoDataSet1.FieldByName('Forcasestep').AsFloat;
            DRec.prev_Record_Footage:= FAdoDataSet1.FieldByName('Footage').Asfloat;
            DRec.prev_Record_BeforeMovePress:=FAdoDataSet1.FieldByName('AGVMovePress').Asfloat;
         end else begin
            DRec.prev_Record_AGV_data:=0;
            DRec.prev_Record_Fangcha:=0;
            DRec.prev_Record_SecondJudge:=0;
            DRec.prev_Record_BeforeMovePress:=0;
         end;
     FAdoDataSet1.Close
   except
     Result:=False;
   end;
end;

function TFourthThread.RebalanceDataBase_First_Judge( FRec: Prec): Integer;
var
  PressState:Integer;
begin
     //判断周期来压状态
     PressState:=0;
     if (FRec.dAGvData>= FRec.Prev_TwoStep_AGV_Data)  then  PressState:=PressState+1;
     if (FRec.dAGvData>=FRec.prev_Record_AGV_data)  then PressState:=PressState+1;
     if (FRec.dAGVSupportMovePress>FRec.dAGvData)  then PressState:=PressState+1;

     //权重判断
     if FRec.dPressWeigth >FRec.Prev_TwoStep_AGV_Weight then  PressState:=PressState+1;
     if FRec.dPressWeigth/FRec.MaxWeightValue > (1-FRec.judgeLeval) then
         PressState:=PressState+1;
     //方差判断
     if (FRec.dAGvDataFangCha< FRec.Prev_TwoStep_AGV_Fangcha) and (PressState>0 )  then
          Pressstate:= PressState+1;
     // 均值与老顶来压值
     if FRec.dAGvData >=FinGzm.Old_MPa[2]*(1-FRec.judgeLeval ) then
          Pressstate:= PressState+3;
     // 均值与直接顶来压值比较
     if FRec.dAGvData<=FinGzm.imm_MPa* (1+FRec.judgeLeval) then
          Pressstate:= PressState-1;

     Result:=PressState;
end;

function TFourthThread.RebalanceDataBase_Second_Judge(FRec: Prec): Integer;
var
  secondJudge:Integer;
begin
        secondJudge:= 0;
        {// 当前判断值大于前两个周期的判断均值}
        if FRec.firstjudge >= FRec.Prev_TwoStep_AGV_FirstJudge
            then   secondJudge:=1 ;
        {//当前末阻力大于前两个周期的 平均末阻力 }
        if (FRec.dAGVSupportMovePress > FRec.Prev_TwoStep_AGV_BeforeMovePress*(1+FRec.judgeLeval))
            then   secondJudge:=secondJudge+1;
        {//当前均值大于前两个周期均值的判断倍数}
        if FRec.dAGvData >= FRec.Prev_TwoStep_AGV_Data * (1+FRec.judgeLeval)
            then   secondJudge:=secondJudge+1;
        { // 最大值大于支架液压阀开启 的判断倍数}
        if (FRec.dMaxData>=Fingzm.Usedsupport.EndOpenLoad *(1-FRec.judgeLeval)) and
           (secondJudge>0)   then
               secondJudge:=secondJudge+1;
        {// 均值大于支架初撑力的倍数}
        if (FRec.dAGvData>=Fingzm.Usedsupport.initLoad *(1+FRec.judgeLeval))   and
           (secondJudge>0)  then
               secondJudge:=secondJudge+2;
        {//末阻力大于支架初撑力的倍数}
        if (FRec.dAGVSupportMovePress > Fingzm.Usedsupport.initLoad*(1+FRec.judgeLeval))  and
           (secondJudge>0)   then  secondJudge:=secondJudge+1;

        Result:=secondJudge;

end;

function TFourthThread.RebalanceDataBase_Third_Judge(FGzmid, typeValue: string;
  var FRec: Prec): Integer;
var
  sql:String;
  ThirdJudgeCount:Integer;
  PressFlag_id,PressFlag_ThirdJudge:integer;
  PressFlag_AGVData,PressFlag_BeforeMovePress:double;
  PressFlag_Footage,PressFlag_Forcasestep:double;
begin
  {查找当前时间 当前 区域 前 5 条进行 来压标注的记录数据}
  sql:='select id,AGVData,footage,SecondJudge,Forcasestep,AGVMovePress,ThirdJudge from D_' +Trim(FGzmid) +'_ThirdDP where '+
              ' generatetime < ''' +   FormatDateTime( 'yyyy-mm-dd hh:nn:ss',FRec.Generatetime) +'''' +
              ' and phaseNumber =' +IntTostr(FRec.did) +  ' and ThirdJudge >0 '+
              ' and TypeData= ''' +typeValue +''' order by footage desc limit 5 ';
 try
     FAdoDataSet1.Close ;
     FAdoDataSet1.CommandText :=sql;
     ThirdJudgeCount:=1;
     if FAdoDataSet1.Open then begin
        {处理第一条记录，把距离即将标注为来压记录最近的一条进行判断}
        if FAdoDataSet1.RecordCount >0  then begin
            FAdoDataSet1.First;
            PressFlag_id:=FAdoDataSet1.FieldByName('id').AsInteger;
            PressFlag_ThirdJudge:=FAdoDataSet1.FieldByName('ThirdJudge').AsInteger;
            PressFlag_AGVData:=FAdoDataSet1.FieldByName('AGVData').AsFloat;
            PressFlag_BeforeMovePress:=FAdoDataSet1.FieldByName('AGVMovePress').AsFloat;
            PressFlag_Footage:=FAdoDataSet1.FieldByName('footage').AsFloat;
            PressFlag_Forcasestep:=FAdoDataSet1.FieldByName('footage').AsFloat;
            {FGzmid,typeValue:string; FRec: Prec; RecordId,TJudgeCount: integer; Footage, MoveBeforeData, ForCaseStep,
             AGVData: Double}
            { 整合判断 记录 }
            ThirdJudgeCount:=RebalanceDataBase_Third_Judge_MerGeData(FGzmid, typeValue,FRec,PressFlag_id,
                        PressFlag_ThirdJudge,PressFlag_Footage,PressFlag_BeforeMovePress,PressFlag_Forcasestep,
                        PressFlag_AGVData);
        end;
        { 继续处理后面四条 记录
          （1） 主要是查找 该条记录 标注来压级别的数据
        }
       FAdoDataSet1.Next ;
       while not FAdoDataSet1.eof  do  begin
            PressFlag_ThirdJudge:=FAdoDataSet1.FieldByName('ThirdJudge').AsInteger;
            PressFlag_AGVData:=FAdoDataSet1.FieldByName('AGVData').AsFloat;
            PressFlag_BeforeMovePress:=FAdoDataSet1.FieldByName('AGVMovePress').AsFloat;
          if  (  (FRec.prev_Record_AGV_data > PressFlag_AGVData) or  (FRec.prev_Record_BeforeMovePress >PressFlag_BeforeMovePress) )
              and (ThirdJudgeCount <= PressFlag_ThirdJudge ) and (ThirdJudgeCount>0)    then  begin
                   ThirdJudgeCount:= FAdoDataSet1.FieldByName('ThirdJudge').AsInteger+1;
              end;
         FAdoDataSet1.Next ;
       end;
     end;
 finally
    FAdoDataSet1.Close ;
    Result:=ThirdJudgeCount;
 end;

end;

function TFourthThread.RebalanceDataBase_Third_Judge_MerGeData(FGzmid,typeValue:string;
  FRec: Prec; Prev_two_Id,Prev_two_ThreeJudgeCount:integer;Prev_two_Footage,
  Prev_two_MoveBeforeData,Prev_two_ForCaseStep,Prev_two_AGVData:Double): integer;
var
  ResultCount:integer;
  Temp_Footage:Double;
  Sql:string;
begin
//   {
//     RecordId,TJudgeCount: integer; Footage, MoveBeforeData, ForCaseStep,  AGVData: Double
//     传递过来的数据是 当前数据库中标注为来压 标记，并且距离 该条记录 距离最近的一条记录
//    // 与数据库中保存的最后一条来压记录比较, 确定 是否来压情况
//       (1) 最后一条记录的平均值大于 数据记录的平均值
//      （2）最后一条记录的 末阻力大于当前处理数据记录末阻力
//      （3） 如果 推进进尺大于一定的具体 可以进行标注
//      结论： 曲线拐点可能出现   ，可以进行标注
//      返回值大于0  就进行标志， 否则不标注
//   }
  ResultCount:=0;
//     { 2017年 12月
//      使用一种简单的判定方法，不做 进尺大小的判断
//      具体判断放在 第四步 的处理过程中
//      }
   if ( (FRec.prev_Record_AGV_data > Prev_two_AGVData ) or (FRec.prev_Record_BeforeMovePress > Prev_two_MoveBeforeData ) )  then begin
       ResultCount:= Prev_two_ThreeJudgeCount+1;
   end else begin
       ResultCount:=1;
   end;
  Result:=ResultCount;
//  try
//    if ( (FRec.prev_Record_AGV_data > Prev_two_AGVData ) or (FRec.prev_Record_BeforeMovePress > Prev_two_MoveBeforeData ) )  then begin
//        {该条记录满足标注为来压记录的条件}
//          if FRec.prev_Record_Footage- Prev_two_Footage >= FinGzm.Old_Step[2]*0.6 then   begin
//              {   两条来压标记 的进尺差大于 周期来压步距 的 0.6 倍 把 这条记录标记为 来压 标记
//                  并把来压标记在 前一个 标记的基础上 加 1
//                 //FinGzm.Old_Step[2]*0.6
//               }
//             ResultCount:= Prev_two_ThreeJudgeCount+1;
//          end else  if (FRec.prev_Record_Footage-Prev_two_Footage +Prev_two_ForCaseStep <= FinGzm.Old_Step[2]*2 ) then begin
//            {
//               这两个步距间距较小，但是可以把前一个清除，清除后，整体来压步距 要小于 2倍的 周期来压步距
//            }
//             FAdoCommand.MySqlConnection.BeginTrans ;
//            try
//               try
//                 ResultCount:=Prev_two_ThreeJudgeCount;
//                 sql:=' update D_' +Trim(FGzmid) +'_ThirdDP  set ThirdJudge= '+IntToStr( ResultCount) +
//                      ' ,forcasestep= '+ FormatFloat('0.00',FRec.prev_Record_Footage-Prev_two_Footage +
//                      Prev_two_ForCaseStep)+ ' where id =' +intToStr(FRec.prev_Record_id);
//                 FAdoCommand.CommandText:=sql;
//                 FAdoCommand.Execute ;
//                 sql:=' update D_' +Trim(FGzmid) +'_ThirdDP  set ThirdJudge= 0  where id =' +IntTostr(Prev_two_Id);
//                 FAdoCommand.CommandText:=sql;
//                 FAdoCommand.Execute ;
//               except
//                 FAdoCommand.MySqlConnection.RollbackTrans;
//               end;
//            finally
//              FAdoCommand.MySqlConnection.CommitTrans;
//            end;
//
//          end else begin
//            {
//               如果数据比较大,两者比较近,而且 合并大于1.5 倍的数据 // 添加一条记录
//
//            }
//             Temp_Footage:=JudgeMAXFootageFalg(FGzmid,typeValue,FRec.did,Prev_two_Footage - Prev_two_ForCaseStep,
//                                          Prev_two_Footage,FRec.dFootageInterval);
//             if Temp_Footage  <> Prev_two_Footage  then   begin
//                   sql:=' update D_' +Trim(FGzmid) +'_ThirdDP  set ThirdJudge= 0  where id ='  +IntTostr(Prev_two_Id);
//                   FAdoCommand.CommandText:=sql;
//                   FAdoCommand.Execute ;
//                   ResultCount:=Prev_two_ThreeJudgeCount;
//                   sql:=' update D_' +Trim(FGzmid) +'_ThirdDP  set ThirdJudge= '+IntToStr( ResultCount) +
//                        ' ,forcasestep= '+ FormatFloat('0.00',FRec.prev_Record_Footage  -Temp_Footage)+
//                        ' where id =' +intToStr(FRec.prev_Record_id);
//             end else begin
//                   ResultCount:=Prev_two_ThreeJudgeCount;
//                   sql:=' update D_' +Trim(FGzmid) +'_ThirdDP  set ThirdJudge= '+IntToStr( ResultCount) +
//                        ' ,forcasestep= '+ FormatFloat('0.00',FRec.prev_Record_Footage  -Temp_Footage )+
//                            ' where id =' +intToStr(FRec.prev_Record_id);
//             end;
//             // 合并 更新
//             FAdoCommand.CommandText:=sql;
//             FAdoCommand.Execute ;
//
//          end;
//    end else if (FRec.prev_Record_Footage- Prev_two_Footage > FinGzm.Old_Step[2]*1.5) then begin
//          {该条记录不满足标注为来压记录的条件，但是满足 推进距离大于周期来压 1.5 倍的条件 可以进行标注 }
//       if   JudgeMAXFootageFalg(FGzmid,typeValue,FRec.did, Prev_two_Footage,FRec.prev_Record_Footage, FRec.dFootageInterval)=-1 then
//             ResultCount:=1;  //
//    end;
//  finally
//     Result:=ResultCount;
//  end;

end;

procedure TFourthThread.RefreshThreadState;
begin
    uThirdProcessStop:=FDisPose.ThirdProcessStop;
end;

function TFourthThread.SaveFourthProcessData(FGzmid, typeValue: string;PhaseNumber:integer): Boolean;
var
 sql:string;
begin
   Result:=true;
   try
     FAdoCommand.MySqlConnection.BeginTrans ;
     sql:='insert into D_' +Trim(FGzmid) +'_Forcase  (phaseNumber,start_steps,end_steps,' +
           ' starttime,endtime,generatetime,each_steps,forcasenumber,dayfootage,process, '+
           ' OutStandStartTime,AgvStep,AGVSecondJudge,CycleSecondJudge,ComePressLevel,Startsupid,' +
           ' endsupid,OutStandSupport,typedata,AGVData,SupportBeforeMoveData,OldToPressure,OldToPressureStep ) '+
           ' values ( '+
           Inttostr(Phasenumber )+' ,' + FormatFloat('0.00',dFourRec.startfootage )+' ,' +
           FormatFloat('0.00',dFourRec.endfootage )+' ,''' + FormatDateTime('yyyy-mm-dd hh:nn:ss',dFourRec.ComePressStarttime)+
           ''','''+ FormatDateTime('yyyy-mm-dd hh:nn:ss',dFourRec.EndPresstime)+''','''+
           FormatDateTime('yyyy-mm-dd hh:nn:ss',dFourRec.generatetime)+''','+
           FormatFloat('0.00',dFourRec.eachsteps )+' ,' + Inttostr(dFourRec.ForcaseNumber )+ ',' +
           FormatFloat('0.00',dFourRec.dayJinchi) +',0,'''+FormatDateTime('yyyy-mm-dd hh:nn:ss',dFourRec.OutStandComePressStartTime)+
            ''','+ FloatToStr(dFourRec.AGVStep)+','+ FloatToStr(dFourRec.AGVSecondJudge)+','+
           FloatToStr(dFourRec.CycleSecondJudge)+','+intToStr(dFourRec.ComePressLevel)+','+
           IntToStr(dFourRec.startSupid)+','+ IntToStr(dFourRec.EndSupid)+','''+
           dFourRec.OutStandSupport +''','''+typeValue+''',' +
           FormatFloat('0.00',dFourRec.AGVdata) +',' + FormatFloat('0.00',dFourRec.SupportBeforeMoveData)+ ',' +
           IntToStr(dFourRec.OldToPressure)+',' + FormatFloat('0.00',dFourRec.OldToPressureStep) +
           ')';
     FAdoCommand.CommandText:=sql;
     FAdoCommand.Execute;
                 //
     sql:='update  D_' +Trim(FGzmid) +'_ThirdDP set   forCase_info_ed = 1 ,process=2'+
        ' where phaseNumber =' +  IntTostr(PhaseNumber) +  ' and footage <='+ FormatFloat('0.00',dFourRec.endfootage ) +
        ' and typedata = '''+typeValue+''' ' ;
     FAdoCommand.CommandText:=sql;
     FAdoCommand.Execute;
     FAdoCommand.MysqlConnection.CommitTrans;
   except
     Result:=false;
   end;
end;

function TFourthThread.SelectCountData(sql,Field1: string; var Value: double): Boolean;
begin
    Result:=False;
    FAdoDataSet1.Close ;
    FAdoDataSet1.CommandText :=sql;
    if FAdoDataSet1.Open then
      if  FAdoDataSet1.RecordCount>0  then  begin
        Value:= FAdoDataSet1.FieldByName(Field1).Asfloat;
        Result:=true;
      end;
     FAdoDataSet1.Close ;
end;

function TFourthThread.SelectEachPhase(FGzmid, typeValue: string; PhaseNumber:integer;IntervalTime: double): Boolean;
var
  sql:string;
//  MaxWeightSupbh:integer;
//  RetVaule,iFootStep:double;
//  Max_V,Min_V,Agv_V,Fangcha,Group_AGV:double;
//  maxWeight, Weight:double;
//  DownMinFootage,DownMaxFootage,UpperMinFootage,UpperMaxFootage:double;
    MinFootage,MaxFootage,AGVFootage:double;
//  MaxTime,MinTime:TdateTime;
//  temp_w:double;
  Gzm_Simple,Gzm_Difficult,Zk_str,SEorr:string;
  GetPStopeStr:String;
  Min_Time,Max_Time:TdateTime;
  Use_Min_time,Use_Max_time:TdateTime;
begin
       Result:=false;
       //  初始化处理过程的时间
       ProcessTime:=1;
       //判断该工作面支架是否都有数据
       if not selectPhaseComplete(FGzmid,typevalue,dRecArry[PhaseNUmber].dSupStartBh,
           dRecArry[PhaseNUmber].dSupEndBh) then  exit;
       {获得该区域有效支架的最大时间与最小时间}
       if not SelectMinMaxTime(FGzmid,typevalue,dRecArry[PhaseNUmber].dSupStartBh,
           dRecArry[PhaseNUmber].dSupEndBh,IntervalTime,Min_Time,Max_Time) then exit;

     while idDataValidity(FGzmid,typevalue,dRecArry[PhaseNUmber].dSupStartBh,
           dRecArry[PhaseNUmber].dSupEndBh,IntervalTime,Min_Time,Max_Time,Use_Min_time,Use_Max_time) do  begin

           if FDisPose.ThirdProcessStop   then  break;
         //获得步距
          isUsedFootage(FGzmid,typevalue,dRecArry[PhaseNUmber].dSupStartBh,dRecArry[PhaseNUmber].dSupEndBh,
             Use_Min_time,Use_Max_time,MinFootage,MaxFootage,AGVFootage ) ;

         FinGzm.RefreshFootage(MaxFootage);
         FinGzm.GetGzmZkStr(Gzm_Simple,Gzm_Difficult,Zk_str);
         FinGzm.MyP_stope.InitModel(Gzm_Simple,Zk_str,SEorr);
         GetPStopeStr:=FinGzm.Get_PStope_OldInfo ;
         // insert processlog
         if (FDisPose.writeProcessflag) and (totalnumber mod 10 =1) then  begin
              sql:=' insert into processlog (generatetime,DataNumber,gzmname,supportbh, threadid,Processtype) values (''' +
                    FormatDaTeTime('yyyy-mm-dd hh:nn:ss',now())+''','+IntToStr(totalnumber)+',''' +
                    Trim(FGzmid)+''','+ IntToStr(PhaseNUmber) +','+IntToStr(self.Handle)+',''ThirdProcess'')' ;
              FAdoCommand.CommandText:=sql;
              FAdoCommand.Execute;
         end;
          dRecArry[PhaseNUmber].did:=PhaseNUmber;
          dRecArry[PhaseNUmber].StartFootage:=MinFootage;
          dRecArry[PhaseNUmber].EndFootage:= MaxFootage;
          dRecArry[PhaseNUmber].dFootage :=AGVFootage;
          //填充数据
         if  FillDRec(FGzmid, typeValue, dRecArry[PhaseNUmber],Use_Min_time,Use_Max_time ) then begin
              //数据平衡
             RebalanceDataBase_Core(FGzmid,typeValue,dRecArry[PhaseNUmber]) ;
              //修订第一条记录
             FirstStepJudge(FGzmid,typeValue,dRecArry[PhaseNUmber]);
              //写入数据库
             InsertDatabase(FGzmid,typeValue,dRecArry[PhaseNUmber]);

         end;
         // 下一次循环
         Min_Time:=Use_Max_time;
     end;  //end while


     Result:=true;
end;

function TFourthThread.SelectJudgeLevel(FGzmid, typeValue: string;
  PhaseNumber: integer; var JudgeLevel,UsedOldstep:double): Boolean;
var
 Sql:string;

begin
    Result:=False;
    Sql:='select Judgelevel,UsedOldStep  from D_'+trim(FGzmid)+'_thirddp' +
         ' where phasenumber='+IntTostr(PhaseNumber)+' and TypeData= '''+typeValue+'''' +
         ' order by  footage desc limit 1 ';

    FAdoDataSet1.Close ;
    FAdoDataSet1.CommandText :=sql;
    if FAdoDataSet1.Open then
        if  FAdoDataSet1.RecordCount>0  then  begin
             JudgeLevel:= FAdoDataSet1.FieldByName('JudgeLevel').Asfloat;
             UsedOldstep := FAdoDataSet1.FieldByName('UsedOldStep').Asfloat;
             Result:=true;
         end else  begin
            JudgeLevel:=0;UsedOldstep:=0;
         end;
     FAdoDataSet1.Close ;
end;

function TFourthThread.selectMaxFootAge(FGzmid: string): double;
 var
   sql:string;
begin

end;

//end procedure

function TFourthThread.SelectMinFootAge(dGzmid:string;typeValue:string;Minsupid,Maxsupid:integer;
                               Var Minsupid_Minfootage,Minsupid_Maxfootage,MaxSupid_MinFootage,
                               MaxSupid_MaxFootage: double ):Boolean;
var
  Sql:string;
  FG:double;
  Minbh,Maxbh:integer;
begin
   Result:=False;
   //ProcessTime
   Minsupid_MinFootAge:=0; Minsupid_MaxFootAge:=0;
   Maxsupid_MinFootAge:=0; Maxsupid_MaxFootAge:=0;
   //Min ***
   for Minbh := MinSupid to Maxsupid do  begin
       sql:='select Min(Footage) as MinFootage, max(footage) as MaxFootage from D_'+trim(dGzmid)+'_Seconddp' +
           ' where process=0  and  Footage >0 and TypeData= '''+
            typeValue+''' and supportbh='+ IntToStr(Minbh);
        FAdoDataSet1.Close ;
        FAdoDataSet1.CommandText :=sql;
        if FAdoDataSet1.Open then
            if  FAdoDataSet1.RecordCount>0  then  begin
                FG:= FAdoDataSet1.FieldByName('MinFootage').Asfloat;
                Minsupid_MinFootAge:=trunc(FG);
                FG:=  FAdoDataSet1.FieldByName('MaxFootage').Asfloat;
                Minsupid_MaxFootage:=trunc(FG);

             end;
         FAdoDataSet1.Close ;
         if (Minsupid_MinFootAge >1) and  (Minsupid_MaxFootAge >1 )  and
            (Minsupid_MaxFootAge -Minsupid_MinFootAge >=1) then  break;

   end;
       if (Minsupid_MinFootAge <1 ) or  (Minsupid_MaxFootAge <1 )  or
            (Minsupid_MaxFootAge -Minsupid_MinFootAge <1) then exit;

   /// Max***
    Maxbh:= Maxsupid;
    while Maxbh >=Minsupid  do  begin
       sql:='select Min(Footage) as MinFootage, max(footage) as MaxFootage from D_'+trim(dGzmid)+'_Seconddp' +
           ' where process=0 and Footage >0 and TypeData= '''+typeValue+''' and supportbh='+ IntToStr(Maxbh);
        FAdoDataSet1.Close ;
        FAdoDataSet1.CommandText :=sql;
        if FAdoDataSet1.Open then
            if  FAdoDataSet1.RecordCount>0  then  begin
                FG:= FAdoDataSet1.FieldByName('MinFootage').Asfloat;
                Maxsupid_MinFootAge:=trunc(FG);
                FG:=  FAdoDataSet1.FieldByName('MaxFootage').Asfloat;
                Maxsupid_MaxFootage:=trunc(FG);

             end;
         FAdoDataSet1.Close ;
         if (Maxsupid_MinFootAge >1) and  (Maxsupid_MaxFootAge >1 )  and
            (Maxsupid_MaxFootAge -Maxsupid_MinFootAge >=1) then  break;
        Maxbh:=maxbh-1;
   end;
       if (Maxsupid_MinFootAge <1 ) or  (Maxsupid_MaxFootAge <1 )  or
            (Maxsupid_MaxFootAge -Maxsupid_MinFootAge <1) or
            (Maxbh<Minbh )    then exit;

    Result:=true;
end;




function TFourthThread.SelectMinMaxTime(dGzmid, typeValue: string; Minsupid,
  Maxsupid: integer; IntervalTime: double; var Min_Time,
  Max_Time: TdateTime): Boolean;
Var
 sql:string;
begin
    Result:=False;
   //Max ***
    sql:='select Min(EndTime) as Min_T, max(EndTime) as Max_T from D_'+trim(dGzmid)+'_Seconddp' +
           ' where process=0  and  Footage >0 and TypeData= '''+ typeValue+''' ' +
           ' and supportbh >= '+ IntToStr(Minsupid) + ' and supportbh <= '+ IntToStr(Maxsupid) ;
    FAdoDataSet1.Close ;
    FAdoDataSet1.CommandText :=sql;
    if FAdoDataSet1.Open then begin
        Min_Time:= FAdoDataSet1.FieldByName('Min_T').AsDateTime;
        Max_Time:= FAdoDataSet1.FieldByName('Max_t').AsDateTime;
    end;
    FAdoDataSet1.Close ;
    if Max_Time > Min_Time then    Result:=true;


end;

function TFourthThread.selectPhaseComplete(dGzmid,typeValue:string;
      PhaseStartSupNo,PhaseEndSupNo: integer): Boolean;
{
  判断区间支架数据有效的方法：
  （1）由于支架数据第二集计算是按照支架编号从小到大进行计算的，所以如果存在下一区域记录编号，
       证明该区域支架具备计算的条件
       还要满足该区域支架循循环还要满足支架记录的数量要满足一定的要求
       数量是支架数量的一倍
  （2）如果最后一个区域最后几个支架没有数据，满足计算的条件可以按照以下两个方法判断
    A: 该区域存在的支架移架记录大于 支架区域的数量的两倍
}
var
  sql:string;
begin
   Result:=False;
   if PhaseStartSupNo<FinGzm.SupStartNumber then  exit;
   if PhaseEndSupNo>FinGzm.SupEndUsedNumber then  exit;
  try
   sql:='select count(id) as NoCunt from D_'+trim(dGzmid)+'_Seconddp' +
       ' where process=0  and  Footage >0 and TypeData= '''+
        typeValue+''' and supportbh >='+ IntToStr(PhaseEndSupNo);
    FAdoDataSet1.Close ;
    FAdoDataSet1.CommandText :=sql;
    if  FAdoDataSet1.Open then
        if FAdoDataSet1.FieldByName('NoCunt').AsInteger > 0 then  begin
           FAdoDataSet1.Close ;
            sql:='select count(id) as NoCunt from D_'+trim(dGzmid)+'_Seconddp' +
                 ' where process=0  and  Footage >0 and TypeData= '''+
                  typeValue+''' and supportbh <'+ IntToStr(PhaseEndSupNo) +' and supportbh >=' +
                  IntToStr(PhaseStartSupNo) ;
              FAdoDataSet1.CommandText :=sql;
              if FAdoDataSet1.Open then
                if FAdoDataSet1.FieldByName('NoCunt').AsInteger >=(PhaseEndSupNo-PhaseStartSupNo) then
                    Result:=true;

        end else if PhaseEndSupNo=FinGzm.SupEndUsedNumber then  begin
            FAdoDataSet1.Close ;
            sql:='select count(id) as NoCunt from D_'+trim(dGzmid)+'_Seconddp' +
                 ' where process=0  and  Footage >0 and TypeData= '''+
                  typeValue+''' and supportbh <'+ IntToStr(PhaseEndSupNo) +' and supportbh >=' +
                  IntToStr(PhaseStartSupNo) ;
              FAdoDataSet1.CommandText :=sql;
              if FAdoDataSet1.Open then
                if FAdoDataSet1.FieldByName('NoCunt').AsInteger >=(PhaseEndSupNo-PhaseStartSupNo)*2 then
                    Result:=true;
        end;
  finally
     FAdoDataSet1.Close ;
  end;
end;

function TFourthThread.SelectProcessTime(FGzmid, typeValue: string;
  PhaseNumber: integer; var ProcessNumber: integer): Boolean;
var
 Sql:string;

begin
    Result:=False;
    Sql:='select Max(Process) as Procestimes  from D_'+trim(FGzmid)+'_thirddp' +
         ' where phasenumber='+IntTostr(PhaseNumber)+' and TypeData= '''+typeValue+'''';

    FAdoDataSet1.Close ;
    FAdoDataSet1.CommandText :=sql;
    if  FAdoDataSet1.Open then
        if  FAdoDataSet1.RecordCount>0  then  begin
            ProcessNumber:= FAdoDataSet1.FieldByName('Procestimes').Asinteger;
            if ProcessNumber=0 then  ProcessNumber:=1;
            Result:=true;
         end;
     FAdoDataSet1.Close ;
end;

function TFourthThread.SetThirdTableFiledNumber(FGzmid: string): Integer;
var
  Sql:string;

begin
   FAdoDataSet1.Close ;
   Result:=0;
   Sql:='select count(distinct TypeData) as FN form D_'+trim(FGzmid)+'_thirddp ';
  try
     FAdoDataSet1.CommandText :=sql;
     if  FAdoDataSet1.Open then
        Result:=FAdoDataSet1.FieldByName('FN').AsInteger;

  finally
     FAdoDataSet1.Close ;
  end;

end;

function TFourthThread.SetThirdTableFiledString(FGzmid,DataName: string): String;
{DataName 有 L_R_PressData,F_B_PressData, L_R_Disp,F_B_Disp,T_W_Pressdate }
var
  Sql,FieldValue:string;
  UsedField:TSupportDataType;
  TypeValue,LinkString: array [0..4] of String;
  CountN: Array [0..4] of integer;
  i:integer;
begin
   FAdoDataSet1.Close ;
   for I := 0 to 4 do    begin
      LinkString[i]:='';
      CountN[i]:=0;
   end;
   TypeValue[0]:='L_R_PressData';  TypeValue[1]:='F_B_PressData';
   TypeValue[2]:='L_R_Disp';  TypeValue[3]:='F_B_Disp';
   TypeValue[4]:='T_W_Pressdate';

   Sql:='select TypeData  form D_'+trim(FGzmid)+'_thirddp group by TypeData order by TypeData ';
  try
     FAdoDataSet1.CommandText :=sql;
     if  FAdoDataSet1.Open then
     while not FAdoDataSet1.Eof  do  begin
        FieldValue:=FAdoDataSet1.FieldByName('TypeData').AsString;
        UsedField:=TSupportDataType(GetEnumValue(TypeInfo(TSupportDataType),FieldValue));
       if (DataName= TypeValue[0]  ) and ( (UsedField =LeftPressData)  or (UsedField  =RightPressData ) ) then   begin
           if CountN[0] =0 then   begin
              LinkString[0]:=LinkString[0] + ' (TypeData = ''' + Trim(FieldValue) +''')';
           end else begin
              LinkString[0]:= ' or ' + LinkString[0] + ' (TypeData = ''' + Trim(FieldValue) +''')';
           end;
           CountN[0]:=CountN[0]+1;
       end else if (DataName= TypeValue[1]  )and ( (UsedField= FrontPressData) or   ( UsedField =BehindPressData ) ) then   begin
           if CountN[1] =0 then   begin
              LinkString[1]:=LinkString[1] + ' (TypeData = ''' + Trim(FieldValue) +''')';
           end else begin
              LinkString[1]:= ' or ' + LinkString[1] + ' (TypeData = ''' + Trim(FieldValue) +''')';
           end;
           CountN[1]:=CountN[1]+1;
       end else if (DataName= TypeValue[2]  )and ( (UsedField= LeftDisp) or   ( UsedField =RightDisp ) ) then   begin
           if CountN[2] =0 then   begin
              LinkString[2]:=LinkString[2] + ' (TypeData = ''' + Trim(FieldValue) +''')';
           end else begin
              LinkString[2]:= ' or ' + LinkString[2] + ' (TypeData = ''' + Trim(FieldValue) +''')';
           end;
           CountN[2]:=CountN[2]+1;
       end else if (DataName= TypeValue[3]  )and ( (UsedField= FrontDisp) or   ( UsedField =BehindDisp ) ) then   begin
           if CountN[3] =0 then   begin
              LinkString[3]:=LinkString[3] + ' (TypeData = ''' + Trim(FieldValue) +''')';
           end else begin
              LinkString[3]:= ' or ' + LinkString[3] + ' (TypeData = ''' + Trim(FieldValue) +''')';
           end;
           CountN[3]:=CountN[3]+1;
       end else if (DataName= TypeValue[4]  )and ( (UsedField= TheWallPressData)  ) then   begin
           if CountN[4] =0 then   begin
              LinkString[4]:=LinkString[4] + ' (TypeData = ''' + Trim(FieldValue) +''')';
           end else begin
              LinkString[4]:= ' or ' + LinkString[4] + ' (TypeData = ''' + Trim(FieldValue) +''')';
           end;
           CountN[4]:=CountN[4]+1;
       end;
       FAdoDataSet1.Next ;
     end;

     FAdoDataSet1.Close ;
     for I := 0 to 4 do begin
         if DataName= TypeValue[i] then
           if CountN[i] = 1  then begin
              Result:=LinkString[i];
           end else if CountN[i]>1 then  begin
              Result:='('+LinkString[i] +')';
           end;
     end;
  finally

  end;
end;

function TFourthThread.ThirdDisPosePressDate(FGzmid: string; var TotalCount: integer;
                  var elapsedtime:string): Boolean;   //数据核心处理程序
var
  PhaseStep,Field_i:integer;
  sql:string;
  UsedField:TSupportDataType;
  IntervalTime:double;
begin
     //=====
    Result:=true;
try
    totalnumber:=0;
    IntervalTime:=12/24; // 代表12小时
    self.IntiArrayDrec;  //初始化分区数组
    // 读取可用的字段数据类型
    if not FinGzm.FillDataType_SupportType(StrToint(FGzmbh)) then  exit;

    for Field_i := 0 to FinGzm.IsUesedsupFieldcount-1 do  begin
         if FDisPose.ThirdProcessStop then  break; //  循环退出机制
         UsedField:=TSupportDataType(GetEnumValue(TypeInfo(TSupportDataType),FinGzm.IsUesedsupFieldName[Field_i]));
         if  (UsedField= FrontPressData) or  ( UsedField =BehindPressData ) or (UsedField =LeftPressData)
                   or (UsedField  =RightPressData ) then   begin
               //循环遍历 工作面划分的区域
               for PhaseStep := 1 to RecArryNumber do   begin

                    if FDisPose.ThirdProcessStop then  break; //  循环退出机制
                    //填充数据
                    SelectEachPhase(FGzmid,FinGzm.IsUesedsupFieldName[Field_i],PhaseStep,IntervalTime) ;
               end;
         end;
//           if  (UsedField= FrontDisp) or  ( UsedField =BehindDisp ) or (UsedField =LeftDisp)
//                     or (UsedField  =RightDisp) then
//                 DisPoseDispData(FGzmbh, FinGzm.IsUesedsupFieldName[i]);
//           if  (UsedField= FirstDrillPress) or  ( UsedField =SecondDrillPress ) or (UsedField =ThirdDrillPress)
//                     or (UsedField  =FourthDrillPress )then
//                DisPoseDrillPress(FGzmbh, FinGzm.IsUesedsupFieldName[i]);
      end;


 except
    Result:=false;
 end;


end;

function TFourthThread.UpdataForcaseData(FGzmid: string; id, ComeFlag: integer;
  ComeStep,ForaseNextStep: double): Boolean;
var
 sql:string;
begin
    Result:=true;
   try
     sql:='update D_' +Trim(FGzmid) +'_Forcase  set  OldToPressure = ' + IntToStr(ComeFlag) +  ',' +
          ' OldToPressureStep = '+ FormatFloat('0.00',ComeStep) +  ',' +
          ' ForCaseNextStep= '+ FormatFloat('0.00',ForaseNextStep) +
          ' where  id= ' +IntToStr(id);

     FAdoCommand.CommandText:=sql;
     FAdoCommand.Execute;
   except
     Result:=false;
   end;
end;

function TFourthThread.WholeSupport_ForCaseRockPress(FGzmid: string;
  var TotalCount: integer; var elapsedtime: string): Boolean;
var
  i,FootStep:integer;
  elapsedMilliseconds : cardinal;
  sql:string;
  UsedField:TSupportDataType;
  GetFieldString:String;
begin
    // 支架整体预测数据
    //=====
   Result:=true;
   FDisPose.SetFourthProcessStop(false);

 try
    totalnumber:=0;
    IntiArrayDrec; // 划分区段
     // 读取可用的字段数据类型
    if not FinGzm.FillDataType_SupportType(StrToint(FGzmbh)) then  exit;

    ThirdTableFiledNumber:=SetThirdTableFiledNumber(FGzmid);

    if ThirdTableFiledNumber <1 then exit;
     {DataName 有 L_R_PressData,F_B_PressData, L_R_Disp,F_B_Disp,T_W_Pressdate }
    GetFieldString:=SetThirdTableFiledString(FGzmbh,'L_R_PressData');
    if length(Trim(GetFieldString))>0  then begin  // L_R_PressData

    end;
    GetFieldString:=SetThirdTableFiledString(FGzmbh,'F_B_PressData');
    if length(Trim(GetFieldString))>0  then begin  // F_B_PressData

    end;

     for i := 0 to FinGzm.IsUesedsupFieldcount-1 do  begin
        if FDisPose.FourthProcessStop then  break; //  循环退出机制
        UsedField:=TSupportDataType(GetEnumValue(TypeInfo(TSupportDataType),FinGzm.IsUesedsupFieldName[i]));
        {DataName 有 L_R_PressData,F_B_PressData, L_R_Disp,F_B_Disp,T_W_Pressdate }
       if  (UsedField= FrontPressData) or  ( UsedField =BehindPressData ) or (UsedField =LeftPressData)
                   or (UsedField  =RightPressData ) then   begin
               //循环遍历 工作面划分的区域
               for FootStep := 1 to RecArryNumber do   begin
                    if FDisPose.FourthProcessStop then  break; //  循环退出机制
                     //分区段查找记录
                     ForcaseThirdTable(FGzmid,FinGzm.IsUesedsupFieldName[i],FootStep,0.8);
                     //分区段标记来压情况
                     ForcaseOldPressure(FGzmid,FinGzm.IsUesedsupFieldName[i],FootStep);
               end;
         end;
     end; //end for
 except
    Result:=false;
 end;

end;

function TFourthThread.WholeSupport_ForcaseSelectData(FGzmid,FieldString: string;
  PhaseNumber: integer; FootageInterval: double): Boolean;
var
   sql:string;
begin
   Result:=true;
   try
        sql:='select AVG(SecondJudge) as SCJ  from  D_' +Trim(FGzmid) +'_ThirdDP '+
            ' where phaseNumber =' +  IntTostr(PhaseNumber) + ' and SecondJudge > 0  ' +
            ' and ' + FieldString ;
        FAdoDataSet1.Close ;
        FAdoDataSet1.CommandText:=sql;
        if FAdoDataSet1.Open then
           dFourRec.AGVSecondJudge:= FAdoDataSet1.FieldByName('SCJ').AsFloat;
        FAdoDataSet1.Close ;

        sql:='select AVG(ThirdJudge) as AVG_T, Max(ThirdJudge) As MAX_T from  D_' +Trim(FGzmid) +'_ThirdDP '+
            ' where phaseNumber =' +  IntTostr(PhaseNumber) + ' and ThirdJudge > 0  ' +
            ' and ' +FieldString;
        FAdoDataSet1.Close ;
        FAdoDataSet1.CommandText:=sql;
        if FAdoDataSet1.Open then  begin
          dFourRec.thirdJ_AGV:=FAdoDataSet1.FieldByName('AVG_T').AsFloat;
          dFourRec.thirdJ_Max:=FAdoDataSet1.FieldByName('MAX_T').AsFloat;
        end;
        FAdoDataSet1.Close ;
   except
     Result:=False;
   end;

end;

function TFourthThread.WholeSupport_ForcaseThirdTable(FGzmid,FieldString: string;
  PhaseNumber: integer; FootageInterval: double): Boolean;
var
  sql:string;
  AGV_Step_All,Max_step,Min_step:double;

  Start,OutStandComePressState:integer;
begin
    Result:=false;
    //   查找 第二次与第三次判断数据
  WholeSupport_ForcaseSelectData(FGzmid,FieldString, PhaseNumber,FootageInterval);
  try
    sql:='select *  from   D_' +Trim(FGzmid) +'_ThirdDP  where  process <2 and ' +
       ' forCase_info_ed <1  and  footage > 0 and phaseNumber =' +  IntTostr(PhaseNumber) +
       ' and  '+ FieldString  +' order by footage  ' ;

    FAdoDataSet1.CommandText:=sql;
    if FAdoDataSet1.Open then begin
        if FAdoDataSet1.RecordCount< 1 then  begin
          Result:=true;
          FAdoDataSet1.Close ;
          exit;;  //退出循环
        end;

      FAdoDataSet1.First;
      Start:=0;
      OutStandComePressState:=0;

      while not  FAdoDataSet1.Eof do begin
          if FDisPose.FourthProcessStop then  break; //  循环退出机制 then
          if start=0 then  begin       // 开始
             Start:=1;
             dFourRec.startfootage:=FAdoDataSet1.FieldByName('Footage').AsFloat;
             dFourRec.ComePressStarttime:=FAdoDataSet1.FieldByName('phase_startTime').AsDateTime;
             dFourRec.startSupid:=FAdoDataSet1.FieldByName('Startbh').AsInteger ;
             dFourRec.EndSupid:=FAdoDataSet1.FieldByName('endbh').AsInteger ;
          end;

          if  FAdoDataSet1.FieldByName('thirdjudge').AsInteger>0  then begin  //结束标记
//             dFourRec.endfootage:=FAdoDataSet1.FieldByName('Footage').AsFloat;
//             dFourRec.EndPresstime:=FAdoDataSet1.FieldByName('phase_EndTime').AsDateTime ;
//
//             dFourRec.startfootage:=dFourRec.endfootage- FAdoDataSet1.FieldByName('ForCaseStep').AsFloat;
//             dFourRec.eachsteps:=dFourRec.endfootage- dFourRec.startfootage;
//             dFourRec.AGVStep:=FAdoDataSet1.FieldByName('UsedOLdStep').AsFloat;
//             dFourRec.OutStandSupport:=FAdoDataSet1.FieldByName('SupString').AsString;
//             dFourRec.AGVData:=FAdoDataSet1.FieldByName('AGVData').AsFloat;
//             dFourRec.SupportBeforeMoveData:=FAdoDataSet1.FieldByName('AGVMovePress').AsFloat;
//             dFourRec.generatetime :=now();
//             Start:=0;
//             //查找记录
//             ForCAseSelectCycleSecond(FGzmid, typeValue,PhaseNumber, dFourRec.startfootage, dFourRec.endfootage);
//             // 查找当天在该区域的进尺
//             ForcaseDayJinChi(FGzmid,typeValue,PhaseNumber); //
//
//             if  OutStandComePressState=0  then
//                 dFourRec.OutStandComePressStartTime:=FAdoDataSet1.FieldByName('ForCaseStep_St').AsDateTime;
//             // 判断本次来压的强度
//              dFourRec.ComePressLevel:=ForcasePressIntensity (FAdoDataSet1.FieldByName('SecondJudge').AsInteger,
//                  FAdoDataSet1.FieldByName('ThirdJudge').AsInteger,OutStandComePressState );
//             //  保存数据
//             SaveFourthProcessData(FGzmid, typeValue,PhaseNumber);
//             //把来压状态清空
//             OutStandComePressState:=0;
          end;

          //判断显著来压时刻
          OutStandComePressState:=ReturnPressStartTime(FAdoDataSet1.FieldByName('SecondJudge').AsInteger,
            OutStandComePressState, FAdoDataSet1.FieldByName('phase_startTime').AsDateTime);

         FAdoDataSet1.Next ;
      end; //end while

    end;
   FAdoDataSet1.Close;
   Result:=True;

  finally

  end;



end;

end. // end unit
