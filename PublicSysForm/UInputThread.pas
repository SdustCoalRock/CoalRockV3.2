unit UInputThread;
interface
uses
     windows,Classes,uDisposeData,GzmClass,MySQLDataSet,SysUtils,uDataModule,System.TypInfo,SyncObjs,
     Winapi.ActiveX   ;
type
  // 预警信息实时线程
  TGetForCaseResult=class(TThread)
   private
     inMySqlConnection:TMySqlConnection;
     Fdp:TDisposeData;
   protected
     procedure Execute ;override;
     function SelKuangjingBianHao(KuangjingName: String): integer;
     function IsExistWorkFace(Mineid:integer;WorkFaceName: String): integer;
     function GetForcastResult(inGzmList:TStringlist):AnsiString;
     function GetMaxFootAge(Gzmid:integer;startbh,Endbh:integer;
              var min_Footage,max_footage:double):Boolean;
      procedure FCConnectMySQL;
   public
      destructor Destroy; override;
      constructor  Create(uObjusers:TDisposeData);
  end;
 // 历史预警信息线程
 THistroyForCaseREsult= class(TThread)
   private
     HFdp:TDisposeData;
     inMySqlConnection:TMySqlConnection;
     MineName,WorkfaceName : string;
     StartTime : TDateTime; StopTime : TDateTime;
     inStartFoot,inEndFoot:double;
     function SelKuangjingBianHao(KuangjingName: String): integer;
     function IsExistWorkFace(Mineid:integer;WorkFaceName: String): integer;
     function GetHistoryResult(Gzmid:integer; StartTime,  StopTime: TDateTime): string;
     function GetHistoryResult_Foot(Gzmid:integer; StartFoot,  StopFoot: Double): string;
     function FootageToDate(Gzmbh:integer;FG: double;Str:String): TDateTime;
     function DatetimeToFootage(Gzmbh: integer; Dt: TdateTime; Str: String): double;
     procedure HFConnectMySQL;
   protected
      procedure Execute ;override;
   public
      destructor Destroy; override;
      constructor  Create(uObjusers: TDisposeData;  vMineName: string;
           vWorkfaceName: string; vStartTime, vStopTime: String);

  end;
 //返回工作面支架移动信息线程
 TReturnSupportMoveInfo=class(TThread)
   private
     Fndp:TDisposeData;
     inMySqlConnection:TMySqlConnection;
     MineName,WorkfaceName : string;
     startfootage,endfootage:double;
     StartTime,EndTime:TdateTime;
     zjbh:integer;
     function SelKuangjingBianHao(KuangjingName: String): integer;
     function IsExistWorkFace(Mineid:integer;WorkFaceName: String): integer;
     function GetSupportMoveInfo(Gzmid:integer;supbh:integer): string;
     procedure SetOutString(Gzmbh:integer;Supbh:integer);
     procedure ConnectMySQL;
     function DatetimeToFootage(Gzmbh: integer; Dt: TdateTime; Str: String): double;
   protected
      procedure Execute ;override;
   public
      OutExString:String;
      destructor Destroy; override;
      constructor  Create(uObjusers: TDisposeData;  vMineName: string; vWorkfaceName: string;
                          vstartfootage,vendfootage:double;vSupportbh:integer);
 end;


implementation
uses NativeXml;


{ THistroyForCaseREsult }

constructor THistroyForCaseREsult.Create(uObjusers: TDisposeData;  vMineName: string;
           vWorkfaceName: string; vStartTime, vStopTime: String);
var
   FSetting : TFormatSettings;
begin
   Inherited  Create(true) ;
   CoInitialize(Nil);
   FreeOnTerminate := True;
   //
       FSetting.ShortDateFormat:='yyyy-mm-ss' ;
       FSetting.DateSeparator :='-';
       FSetting.ShortTimeFormat :='hh:nn:ss';
       FSetting.TimeSeparator :=':';
       FSetting.DecimalSeparator :='.';

   //
    HFdp:=uObjusers;
    MineName:=vMineName;
    WorkfaceName:=vWorkfaceName;
    StartTime :=StrToDateTime(vStartTime,FSetting);
    StopTime :=StrToDateTime(vStopTime,FSetting);
    inMySqlConnection:=TMySqlConnection.Create(nil);
    if StartTime <40000 then begin
       inStartFoot:= HFdp.OutInputFootSt;
       inEndFoot:= HFdp.OutInputFootEd;
    end else begin
       inStartFoot:=-1;
       inEndFoot:=-1;
    end;

end;

function THistroyForCaseREsult.DatetimeToFootage(Gzmbh: integer; Dt: TdateTime;
  Str: String): double;
var
  sql:string;
  Df,UF,MF:double;
  DataSet1:TMydataset;
begin
    Result:=0;
    DataSet1:=TmyDataSet.create(nil);
    DataSet1.MySqlConnection:=inMySQlConnection;
    HFConnectMySql;
    if Gzmbh <1  then exit;

   DataSet1.Close;
   Sql:='select sumDownFootage,SumUpperFootage from d_'+IntToStr(Gzmbh)+'_Footage ' +
        ' where FootDay <= '''+FormatDateTime('yyyy-mm-dd hh:nn:ss',dt)+''' order by Footday desc';
   DataSet1.Close ;
   DataSet1.CommandText :=sql;
   if DataSet1.Open  then
       if DataSet1.RecordCount >0 then  begin
          Df:=DataSet1.FieldByName('sumDownFootage').AsFloat;
          Uf:=DataSet1.FieldByName('SumUpperFootage').AsFloat ;
          if Str='Upper' then  begin
             Result:=UF;
          end else if Str='Down' then  begin
             Result:=DF;
          end else begin
             if DF> Uf then  Result:=DF  else Result:=UF;
          end;
          exit;
       end;

   //如果这个时间内没有记录,找最小的一条记录
   Sql:='select sumDownFootage,SumUpperFootage from d_'+IntToStr(Gzmbh)+'_Footage ' +
        ' order by Footday ';
   DataSet1.Close ;
   DataSet1.CommandText :=sql;
   if DataSet1.Open  then
       if DataSet1.RecordCount >0 then  begin
          Df:=DataSet1.FieldByName('sumDownFootage').AsFloat;
          Uf:=DataSet1.FieldByName('SumUpperFootage').AsFloat ;
          if Str='Upper' then  begin
             Result:=UF;
          end else if Str='Down' then  begin
             Result:=DF;
          end else begin
             if DF> Uf then  Result:=DF  else Result:=UF;
          end;
          exit;
       end;
   DataSet1.Close ;
   DataSet1.Free;
end;

destructor THistroyForCaseREsult.Destroy;
begin
  FreeAndNil(inMySqlConnection);
  CoUninitialize;
  inherited;
end;

procedure THistroyForCaseREsult.Execute;
 var
   Gzmbh,Mineid,i:integer;
   St,Ed:TdateTime;
begin
  inherited;
    HFdp.HistoryResult:='';
    Mineid:=SelKuangjingBianHao(MineName);
    if Mineid<0 then  exit;
    Gzmbh:=IsExistWorkFace(Mineid,WorkfaceName);
    if Gzmbh<0 then   exit;
    if (StartTime <40000) and (inEndFoot>0)  then  begin
      // st:=FootageToDate(Gzmbh,StartFoot,'');
      // Ed:=FootageToDate(Gzmbh,EndFoot,'');
       HFdp.HistoryResult:=GetHistoryResult_Foot(Gzmbh, inStartFoot,  inEndFoot);
    end else begin
       HFdp.HistoryResult:=GetHistoryResult(Gzmbh, StartTime,  StopTime);
    end;


end;

function THistroyForCaseREsult.FootageToDate(Gzmbh: integer; FG: double;Str:String): TDateTime;
var
  sql:string;
  DD,UD:TdateTime;
  Gzm_DataSet1:TMydataset;
begin
   Result:=0;
   Gzm_DataSet1:=TmyDataSet.create(nil);
   Gzm_DataSet1.MySqlConnection:=inMySQLConnection;
   HFConnectMySql;

   DD:=-1;UD:=-1;
   if Gzmbh <1  then exit;

   Gzm_DataSet1.Close;

   Sql:='select Footday from d_'+IntToStr(Gzmbh)+'_Footage ' +
        ' where sumDownFootage <= '+FormatFloat('0.00',FG)+' order by FootDay desc';
   Gzm_DataSet1.Close ;
   Gzm_DataSet1.CommandText :=sql;
   if Gzm_DataSet1.Open  then
       if Gzm_DataSet1.RecordCount >0 then begin
          DD:=Gzm_DataSet1.FieldByName('Footday').AsDateTime;
       end;

   Sql:='select Footday from d_'+IntToStr(Gzmbh)+'_Footage ' +
        ' where sumUpperFootage <= '+FormatFloat('0.00',FG)+' order by FootDay desc';
   Gzm_DataSet1.Close ;
   Gzm_DataSet1.CommandText :=sql;
   if Gzm_DataSet1.Open  then
       if Gzm_DataSet1.RecordCount >0 then begin
          UD:=Gzm_DataSet1.FieldByName('Footday').AsDateTime;
       end;
   Gzm_DataSet1.Close ;
   if (UD > 40000 )or ( DD > 40000)  then  begin
       if str='Upper' then begin
          Result:=UD;
       end else if str='Down' then begin
          Result:=DD;
       end else begin
          if (UD < DD ) then  Result:=UD  else Result:=DD;
       end;
       exit;
   end;
   //如果没有查到记录   就找第一条记录
   Sql:='select Footday from d_'+IntToStr(Gzmbh)+'_Footage ' +
        ' order by FootDay ';
   Gzm_DataSet1.Close ;
   Gzm_DataSet1.CommandText :=sql;
   if Gzm_DataSet1.Open  then
       if Gzm_DataSet1.RecordCount >0 then begin
          Result:=Gzm_DataSet1.FieldByName('Footday').AsDateTime;
       end;
   Gzm_DataSet1.Close ;
   Gzm_DataSet1.Free;
end;

function THistroyForCaseREsult.GetHistoryResult(Gzmid: integer; StartTime,
  StopTime: TDateTime): string;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
   ChildChildRoot,ChildChildChildRoot: TXmlNode;
   t:integer;
   sql:string;
   fileName:string;
   ExDataSet1:TMyDataSet;
begin
  try
      ExDataSet1:=TMyDataSet.Create(nil);
      ExDataSet1.MySqlConnection:=inMySQLConnection;
      HFConnectMySql;

     MyXml:=TNativeXml.CreateName(UTF8String('矿山压力预警信息返回结果')) ;
    // FinGzm:=TGzm.Create(Fdp.FinDataModule.ExConn);
     RootNode:= MyXml.root.NodeNew('');
     RootNode.Name:='Custom';
    // FinGzm.InputGzmData(Gzmid) ;
     ChildRoot:=RootNode.NodeNew('');
     ChildRoot.Name:=UTF8String('WorkFaceName');   // workfacename
     ChildRoot.Value:= UTF8String(WorkfaceName);
     //
       sql:=' select * from  D_' +Trim(IntToStr(Gzmid)) +'_Forcase '+
            ' where  StartTime >=''' +FormatDateTime('yyyy-mm-dd hh:nn:ss',StartTime) + ''' '+
            ' and endtime <=''' +FormatDateTime('yyyy-mm-dd hh:nn:ss',StopTime) + ''' '+
            ' order by generatetime ';
       ExDataSet1.Close;
       ExDataSet1.CommandText:=sql;
     if ExDataSet1.Open then
        while not  ExDataSet1.Eof do begin
            ChildChildRoot:=ChildRoot.NodeNew('');
             ChildChildRoot.Name:=UTF8String('ForCaseNo:'+ intToStr(ExDataSet1.RecNo));
                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('预警性质'); // 预警性质
                  ChildChildChildRoot.Value :=UTF8String('压力数据分析预测');

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('预警产生时间');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('generatetime').AsString);


                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('预警区间');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('PhaseNumber').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('支架开始编号');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('StartSupid').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('支架终止编号');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('EndSupid').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('该区间预报次数');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('ForCaseNumber').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('周期运动步距开始进尺');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('Start_Steps').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('周期运动步距结束进尺') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('end_Steps').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('周期运动步距') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('each_steps').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('近期运动步距') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('AGVStep').AsString);


                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('顶板运动剧烈开始') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('OutStandStartTime').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('顶板运动结束时刻') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('endtime').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('顶板运动级别') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('ComePresslevel').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('支架压力显现明显序号') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('OutStandSupport').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('老顶运动显著程度') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('OldToPressure').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('老顶运动显著步距') ;
                  if ExDataSet1.FieldByName('OldToPressure').AsInteger >0  then   begin
                     ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('OldToPressureStep').AsString);
                  end else begin
                     ChildChildChildRoot.Value :=UTF8String('0');
                  end;
             ExDataSet1.Next;
            end;
         ExDataSet1.Close;
         ExDataSet1.free;

    MyXml.XmlFormat := xfReadable;

    fileName:=HFdp.Get_DllPath+'XmlSavePath' ;
    if not(DirectoryExists(fileName)) then begin
       ForceDirectories(fileName);
    end;
    MyXml.SaveToFile(fileName+'\HistoryResult.xml');
//    Result:=Myxml.WriteToString ;
    Result:='HistoryResult.xml';
//    FinGzm.Free ;
    MyXml.Free ;
  except
   On e:exception do begin
        HFdp.WriteLog('Eorr: GetHistoryResult '+e.Message,'[THistroyForCaseREsult]');
   end;
  end;
end;

function THistroyForCaseREsult.GetHistoryResult_Foot(Gzmid: integer; StartFoot,
  StopFoot: Double): string;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
   ChildChildRoot,ChildChildChildRoot: TXmlNode;
   t:integer;
   sql:string;
   fileName:string;
   ExDataSet1:TMyDataSet;
begin
  try
      ExDataSet1:=TMyDataSet.Create(nil);
      ExDataSet1.MySqlConnection:=inMySQLConnection;
      HFConnectMySql;

     MyXml:=TNativeXml.CreateName(UTF8String('矿山压力预警信息返回结果')) ;
    // FinGzm:=TGzm.Create(Fdp.FinDataModule.ExConn);
     RootNode:= MyXml.root.NodeNew('');
     RootNode.Name:='Custom';
    // FinGzm.InputGzmData(Gzmid) ;
     ChildRoot:=RootNode.NodeNew('');
     ChildRoot.Name:=UTF8String('WorkFaceName');   // workfacename
     ChildRoot.Value:= UTF8String(WorkfaceName);
     //
       sql:=' select * from  D_' +Trim(IntToStr(Gzmid)) +'_Forcase '+
            ' where  end_Steps >= ' +FormatFloat('0.00',StartFoot) +
            ' and end_Steps <= ' + FormatFloat('0.00',StopFoot) +
            ' order by phaseNumber,ForCaseNumber ';
       ExDataSet1.Close;
       ExDataSet1.CommandText:=sql;
     if ExDataSet1.Open then
        while not  ExDataSet1.Eof do begin
            ChildChildRoot:=ChildRoot.NodeNew('');
             ChildChildRoot.Name:=UTF8String('ForCaseNo:'+ intToStr(ExDataSet1.RecNo));
                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('预警性质'); // 预警性质
                  ChildChildChildRoot.Value :=UTF8String('压力数据分析预测');

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('预警产生时间');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('generatetime').AsString);


                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('预警区间');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('PhaseNumber').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('支架开始编号');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('StartSupid').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('支架终止编号');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('EndSupid').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('该区间预报次数');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('ForCaseNumber').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('周期运动步距开始进尺');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('Start_Steps').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('周期运动步距结束进尺') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('end_Steps').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('周期运动步距') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('each_steps').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('近期运动步距') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('AGVStep').AsString);


                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('顶板运动剧烈开始') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('OutStandStartTime').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('顶板运动结束时刻') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('endtime').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('顶板运动级别') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('ComePresslevel').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('支架压力显现明显序号') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('OutStandSupport').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('老顶运动显著程度') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('OldToPressure').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('老顶运动显著步距') ;
                  if ExDataSet1.FieldByName('OldToPressure').AsInteger >0  then   begin
                     ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('OldToPressureStep').AsString);
                  end else begin
                     ChildChildChildRoot.Value :=UTF8String('0');
                  end;
             ExDataSet1.Next;
            end;
         ExDataSet1.Close;
         ExDataSet1.free;

    MyXml.XmlFormat := xfReadable;

    fileName:=HFdp.Get_DllPath+'XmlSavePath' ;
    if not(DirectoryExists(fileName)) then begin
       ForceDirectories(fileName);
    end;
    MyXml.SaveToFile(fileName+'\HistoryResult.xml');
//    Result:=Myxml.WriteToString ;
    Result:='HistoryResult.xml';
//    FinGzm.Free ;
    MyXml.Free ;
  except
   On e:exception do begin
        HFdp.WriteLog('Eorr: GetHistoryResult '+e.Message,'[THistroyForCaseREsult]');
   end;
  end;

end;

procedure THistroyForCaseREsult.HFConnectMySQL;
begin
     if not inMySqlConnection.connected then  begin
             inMySqlConnection.Open(HFdp.FinDataModule.EXDataIP,HFdp.FinDataModule.Port,
                      HFdp.FinDataModule.ExUser,HFdp.FinDataModule.EXPassword,HFdp.FinDataModule.DataBaseName);
   end;
end;

function THistroyForCaseREsult.IsExistWorkFace(Mineid: integer;
  WorkFaceName: String): integer;
var
    Gzm_DataSet1:TMydataset;
begin
    Result:=-1;
try
    Gzm_DataSet1:=TmyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= inMySQLConnection;
    HFConnectMySql;
    try
      Gzm_DataSet1.Close;
      Gzm_DataSet1.CommandText:='select kid,cqid,cqName from cqcsb  where cqName='''+WorkFaceName +'''' +
                                ' and  kid =' +IntToStr(Mineid);
      if Gzm_DataSet1.Open then
          if Gzm_DataSet1.RecordCount>0 then
              Result:=Gzm_DataSet1.FieldByName('cqid').AsInteger;

      Gzm_DataSet1.Close;
    finally
      Gzm_dataSet1.free;
    end;
except
   On e:exception do begin
        HFdp.WriteLog('Eorr: IsExistWorkFace '+e.Message,'[THistroyForCaseREsult]');
   end;
end;
end;

function THistroyForCaseREsult.SelKuangjingBianHao(
  KuangjingName: String): integer;
var
  Gzm_DataSet1:TMydataset;
begin
    Result:=-1;
    KuangjingName:=Uppercase(KuangjingName);
 try
    Gzm_DataSet1:=TmyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:=inMySQLConnection;
    HFConnectMySql;
    try
      Gzm_DataSet1.Close;
      Gzm_DataSet1.CommandText:='select id,Meikuangming from Kuangjingxinxibiao  where MeikuangMing='''+KuangjingName +'''';
      if Gzm_DataSet1.Open then
         if Gzm_DataSet1.RecordCount>0 then
        Result:=Gzm_DataSet1.FieldByName('id').AsInteger;

    finally
     Gzm_DataSet1.Close;
     Gzm_DataSet1.free;

    end;
 except
   On e:exception do begin
        HFdp.WriteLog('Eorr: SelKuangjingBianHao'+e.Message,'[THistroyForCaseREsult]');
   end;
 end;

end;

{ TGetForCaseResult }

constructor TGetForCaseResult.Create(uObjusers: TDisposeData);
begin
   Inherited  Create(true) ;
   CoInitialize(Nil);
   FreeOnTerminate := True;
   //
   Fdp:=uObjusers;
   inMySqlConnection:=TMySqlConnection.Create(nil) ;
end;

destructor TGetForCaseResult.Destroy;
begin
  FreeAndNil(inMySqlConnection);
  CoUninitialize;
  inherited;
end;

procedure TGetForCaseResult.Execute;
 var
  i,t:integer;
  GzmList:TStringlist;
  FGzmid:integer;
  inDataSet1:TMyDataset;

begin
   inherited;
   Fdp.inReturnForCase:='';
   inDataSet1:=TMyDataSet.Create(nil);
   inDataSet1.MySqlConnection :=inMySqlConnection;
   FCConnectMySQL;
   GzmList:=TStringlist.Create ;
   inDataSet1.Close ;
   inDataSet1.CommandText:=' select cqid from cqcsb where qyzt=1 ';
   if inDataSet1.Open then
       while not inDataSet1.Eof  do  begin
          GzmList.Add(Trim(IntToStr(inDataSet1.FieldByName('cqid').AsInteger)));
          inDataSet1.Next ;
       end; //end while not DataSetGzm.Eof
   inDataSet1.Close ;
   Fdp.inReturnForCase:=GetForcastResult(GzmList);
   FreeAndNil(GzmList) ;
   inDataSet1.Free ;

end;

procedure TGetForCaseResult.FCConnectMySQL;
begin
   if not inMySqlConnection.connected then  begin
             inMySqlConnection.Open(Fdp.FinDataModule.EXDataIP,Fdp.FinDataModule.Port,
                      Fdp.FinDataModule.ExUser,Fdp.FinDataModule.EXPassword,Fdp.FinDataModule.DataBaseName);
   end;
end;

function TGetForCaseResult.GetForcastResult(inGzmList: TStringlist): AnsiString;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
   ChildChildRoot,ChildChildChildRoot: TXmlNode;
   t,Fgzmid:integer;
   sql:string;
   FinGzm:TGzm;
   maxTime:TdateTime;
   Min_footAge,Max_Footage:double;
   I,WarningNumber: Integer;
   End_footage,AVS:double;
   ExDataSet1:TMyDataSet;
   ExCommand1:TMyCommand;
   fileName:ansiString;
   hFile:integer;
begin
  MyXml:=TNativeXml.CreateName(UTF8String('矿山压力预警信息返回结果')) ;
     //
  try
     FinGzm:=TGzm.Create(inMySQLConnection);
     ExDataSet1:=TMyDataSet.Create(nil);
     ExDataSet1.MySqlConnection:=inMySQLConnection;
     ExCommand1:=TMyCommand.Create(nil) ;
     ExCommand1.MySqlConnection :=inMySQLConnection;
     FCConnectMysql;
     //
     RootNode:= MyXml.root.NodeNew('');
         RootNode.Name:='Custom';
     for t := 0 to inGzmList.Count - 1 do  begin
         FGzmid:=StrToInt(inGzmList[t]);
         FinGzm.setGzmNumber(FGzmid);
         FinGzm.InputGzmData(FGzmid) ;
         if not  FinGzm.ReadData then begin
            FinGzm.MakeGzmIsVail(0);
            continue;
         end;
         ChildRoot:=RootNode.NodeNew('');
         ChildRoot.Name:=UTF8String('WorkFaceName');   // workfacename
         ChildRoot.Value:= UTF8String(FinGzm.S_Name);

         //
         sql:=' select * from  D_' +Trim(IntToStr(FGzmid)) +'_Forcase where process <2 order by generatetime desc, phaseNumber ';
        // sql:=' select * from  D_' +Trim(IntToStr(FGzmid)) +'_Forcase  order by generatetime desc, phaseNumber ';
         ExDataSet1.Close;
         ExDataSet1.CommandText:=sql;
       if  ExDataSet1.Open then begin
           maxTime:=ExDataSet1.FieldByName('generatetime').AsDateTime;
           while not  ExDataSet1.Eof do begin
             ChildChildRoot:=ChildRoot.NodeNew('');
             ChildChildRoot.Name:=UTF8String('ForCaseNo:'+ intToStr(ExDataSet1.RecNo));
                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('预警性质'); // 预警性质
                  ChildChildChildRoot.Value :=UTF8String('压力数据分析预测');

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('预警产生时间');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('generatetime').AsString);


                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('预警区间');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('PhaseNumber').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('支架开始编号');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('StartSupid').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('支架终止编号');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('EndSupid').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('该区间预报次数');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('ForCaseNumber').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                  ChildChildChildRoot.Name:=UTF8String('周期运动步距开始进尺');
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('Start_Steps').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('周期运动步距结束进尺') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('end_Steps').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('周期运动步距') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('each_steps').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('近期运动步距') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('AGVStep').AsString);


                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('顶板运动剧烈开始') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('OutStandStartTime').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('顶板运动结束时刻') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('endtime').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('顶板运动级别') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('ComePresslevel').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('支架压力显现明显序号') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('OutStandSupport').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('老顶运动显著程度') ;
                  ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('OldToPressure').AsString);

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('');
                  ChildChildChildRoot.Name:=UTF8String('老顶运动显著步距') ;
                  if ExDataSet1.FieldByName('OldToPressure').AsInteger >0  then   begin
                     ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('OldToPressureStep').AsString);
                  end else begin
                     ChildChildChildRoot.Value :=UTF8String('0');
                  end;
              ExDataSet1.Next;
            end;
       end;
         ExDataSet1.Close;
           //
         sql:=' update  D_' +Trim(IntToStr(FGzmid)) +'_Forcase set process =2   where  generatetime <= ''' +
            FormatDateTime('yyyy-mm-dd hh:nn:ss',maxTime)+  '''';

         ExCommand1.CommandText:=sql;
         ExCommand1.Execute;

            // FinDataModule.ExCommand1.Execute  ;
         // 未来预测
             WarningNumber:=0;
             for I := 1 to FinGzm.RecArryNumber do  begin
                  if not GetMaxFootAge(FGzmid,FinGzm.dRecArry[i][0],FinGzm.dRecArry[i][1],Min_footAge,Max_Footage ) then  continue;
                  sql:=' select * from  D_' +Trim(IntToStr(FGzmid)) +'_Forcase where phaseNumber= ' +intToStr (i) +
                       ' and  OldToPressure =1 ' +
                       ' order by  endtime desc limit 1';
                   ExDataSet1.Close ;
                   ExDataSet1.CommandText:=sql;
                if ExDataSet1.Open  then  begin
                   if ExDataSet1.RecordCount<1 then continue;
                    End_footage:=ExDataSet1.FieldByName('end_steps').AsFloat;
                    AVS:=ExDataSet1.FieldByName('OldToPressureStep').AsFloat;
                    if AVS <=0 then continue ;

                   if (( End_footage >= Min_footAge)  and (End_footage<= Max_Footage))  then begin
                       ChildChildRoot:=ChildRoot.NodeNew('');
                       WarningNumber:=WarningNumber+1;
                       ChildChildRoot.Name:=UTF8String('WarningNo:'+ intToStr(WarningNumber));
                       ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                       ChildChildChildRoot.Name:=UTF8String('预警性质');
                       ChildChildChildRoot.Value :=UTF8String('正在来压');

                       ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                       ChildChildChildRoot.Name:=UTF8String('所在阶段');
                       ChildChildChildRoot.Value :=UTF8String(IntToStr(i));

                       ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                       ChildChildChildRoot.Name:=UTF8String('当前阶段最小进尺');
                       ChildChildChildRoot.Value :=UTF8String(FormatFloat('0.00',Min_footAge));

                       ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                       ChildChildChildRoot.Name:=UTF8String('当前阶段最大进尺');
                       ChildChildChildRoot.Value :=UTF8String(FormatFloat('0.00',Max_Footage));

                       ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                       ChildChildChildRoot.Name:=UTF8String('支架开始编号');
                       ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('StartSupid').AsString);

                       ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                       ChildChildChildRoot.Name:=UTF8String('支架终止编号');
                       ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('EndSupid').AsString);

                       ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                       ChildChildChildRoot.Name:=UTF8String('来压经过距离');
                       ChildChildChildRoot.Value :=UTF8String(FormatFloat('0.00',End_footage-Min_footAge));

                       ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                       ChildChildChildRoot.Name:=UTF8String('预计工作面继续推进');
                       ChildChildChildRoot.Value :=UTF8String(FormatFloat('0.00',Max_Footage-End_footage));

                       ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                       ChildChildChildRoot.Name:=UTF8String('顶板来压级别');
                       ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('ComePresslevel').AsString);

                   end else begin
                         ChildChildRoot:=ChildRoot.NodeNew('');
                         WarningNumber:=WarningNumber+1;
                         ChildChildRoot.Name:=UTF8String('WarningNo:'+ intToStr(WarningNumber));
                         ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                         ChildChildChildRoot.Name:=UTF8String('预警性质');
                         ChildChildChildRoot.Value :=UTF8String('前方预警');

                         ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                         ChildChildChildRoot.Name:=UTF8String('所在阶段');
                         ChildChildChildRoot.Value :=UTF8String(IntToStr(i));

                         ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                         ChildChildChildRoot.Name:=UTF8String('当前阶段最小进尺');
                         ChildChildChildRoot.Value :=UTF8String(FormatFloat('0.00',Min_footAge));

                         ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                         ChildChildChildRoot.Name:=UTF8String('当前阶段最大进尺');
                         ChildChildChildRoot.Value :=UTF8String(FormatFloat('0.00',Max_Footage));

                         ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                         ChildChildChildRoot.Name:=UTF8String('支架开始编号');
                         ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('StartSupid').AsString);

                         ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                         ChildChildChildRoot.Name:=UTF8String('支架终止编号');
                         ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('EndSupid').AsString);

                         ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                         ChildChildChildRoot.Name:=UTF8String('预计来压推进距离');
                         ChildChildChildRoot.Value :=UTF8String(FormatFloat('0',End_footage + AVS));

                         ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                         ChildChildChildRoot.Name:=UTF8String('预计最近推进距离');
                         ChildChildChildRoot.Value :=UTF8String(FormatFloat('0',End_footage + AVS-MAX_footAge));

                         ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                         ChildChildChildRoot.Name:=UTF8String('预计最远推进距离');
                         ChildChildChildRoot.Value :=UTF8String(FormatFloat('0',End_footage + AVS-Min_footAge));

                         ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                         ChildChildChildRoot.Name:=UTF8String('顶板来压级别');
                         ChildChildChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('ComePresslevel').AsString);

                   end;
                end; // end if open
               ExDataSet1.Close ;
             end; // end  for
     end; // end for i Gzm_list
             //   煤柱 采空区 断层预警
    FinGzm.forcastsafe(ChildRoot);
   //  end; //end t

    MyXml.XmlFormat := xfReadable;
    fileName:=Fdp.Get_DllPath+'XmlSavePath' ;
    if not(DirectoryExists(fileName)) then begin
       ForceDirectories(fileName);
    end;
    MyXml.SaveToFile(fileName+'\ForCase.xml');
    Result:=Myxml.WriteToString ;
   // Result:=fileName+'\ForCase.xml'; //2017.12.1 返回文件路径

    Exdataset1.Free ;
    ExCommand1.Free ;
   // FinGzm.Free ;
    MyXml.Free ;
  except
      On e:exception do begin
        Fdp.WriteLog('Eorr: GetForcastResult'+e.Message,'[TForCaseResult]');
      end;
  end;

end;

function TGetForCaseResult.GetMaxFootAge(Gzmid, startbh, Endbh: integer;
  var min_Footage, max_footage: double): Boolean;
var
  sql:string;
  DataSet1:TMyDataSet;
begin
    Result:=True;
    DataSet1:=TMyDataSet.Create(nil);
    DataSet1.MySqlConnection:=inMySqlConnection;

    sql:='select max(footage) as Max_F from  D_' +Trim(inTToStr(Gzmid)) +'_secondDp '+
               ' where  Supportbh = '+IntToStr(Endbh) ;
    DataSet1.Close ;
    DataSet1.CommandText:=sql;
    if DataSet1.Open then
        if(DataSet1.RecordCount>0) and ( DataSet1.FieldByName('Max_F').AsFloat > 0 ) then   begin
           max_footage:= DataSet1.FieldByName('Max_F').AsFloat;
        end else begin
           max_footage:=0;
           Result:=false;
        end;

    sql:='select max(footage) as Max_F from  D_' +Trim(inTToStr(Gzmid)) +'_secondDp '+
               ' where  Supportbh = '+IntToStr(Startbh) ;
    DataSet1.Close ;
    DataSet1.CommandText:=sql;
   if  DataSet1.Open  then
        if (DataSet1.RecordCount>0) and (DataSet1.FieldByName('Max_F').AsFloat > 0 ) then   begin
           if  max_footage < DataSet1.FieldByName('Max_F').AsFloat then begin
               min_Footage:=max_footage;
               max_footage:=DataSet1.FieldByName('Max_F').AsFloat;
           end else begin
               min_Footage:=DataSet1.FieldByName('Max_F').AsFloat;
           end;
        end else begin
          min_Footage:=0;
          Result:=false;
        end;
    DataSet1.Close ;
    DataSet1.Free ;
end;

function TGetForCaseResult.IsExistWorkFace(Mineid: integer;
  WorkFaceName: String): integer;
var
    Gzm_DataSet1:TMydataset;
begin
    Result:=-1;
    Gzm_DataSet1:=TmyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= inMySQLConnection;
    FCConnectMysql;
    try
      Gzm_DataSet1.Close;
      Gzm_DataSet1.CommandText:='select kid,cqid,cqName from cqcsb  where cqName='''+WorkFaceName +'''' +
                                ' and  kid =' +IntToStr(Mineid);
      if  Gzm_DataSet1.Open then
          if Gzm_DataSet1.RecordCount>0 then  begin
           Result:=Gzm_DataSet1.FieldByName('cqid').AsInteger;
           Gzm_DataSet1.Close;
         end;
    except
      On e:exception do begin
        Fdp.WriteLog('Eorr: IsExistWorkFace'+e.Message,'[TForCaseResult]');
      end;
    end;
    Gzm_dataSet1.free;
end;

function TGetForCaseResult.SelKuangjingBianHao(KuangjingName: String): integer;
var
  Gzm_DataSet1:TMydataset;
begin
  Result:=-1;
  KuangjingName:=Uppercase(KuangjingName);
  try
    Gzm_DataSet1:=TmyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:=inMySQLConnection;
    FCConnectMysql;
    try
      Gzm_DataSet1.Close;
      Gzm_DataSet1.CommandText:='select id,Meikuangming from Kuangjingxinxibiao  where MeikuangMing='''+KuangjingName +'''';
      if Gzm_DataSet1.Open then
          if Gzm_DataSet1.RecordCount>0 then  begin
            Result:=Gzm_DataSet1.FieldByName('id').AsInteger;
          end;
    finally
     Gzm_DataSet1.Close;
     Gzm_DataSet1.free;
    end;
  except
   On e:exception do begin
        Fdp.WriteLog('Eorr: SelKuangjingBianHao'+e.Message,'[TForCaseResult]');
   end;
  end;
end;

{ TReturnSupportMoveInfo }

procedure TReturnSupportMoveInfo.ConnectMySQL;
begin
   if not inMySqlConnection.connected then  begin
             inMySqlConnection.Open(Fndp.FinDataModule.EXDataIP,Fndp.FinDataModule.Port,
                      Fndp.FinDataModule.ExUser,Fndp.FinDataModule.EXPassword,Fndp.FinDataModule.DataBaseName);
   end;
end;

constructor TReturnSupportMoveInfo.Create(uObjusers: TDisposeData; vMineName,
  vWorkfaceName: string;  vstartfootage,vendfootage:double;vSupportbh:integer);
begin
  Inherited  Create(true) ;
  CoInitialize(Nil);
   FreeOnTerminate := True;
   Fndp:=uObjusers;
   MineName:=vMineName;
   WorkfaceName:=vWorkfaceName;
   StartFootage:= vStartfootage;
   EndFootage:=vEndFootage;
   zjbh:=vSupportBh;
   inMySqlConnection:=TMySqlConnection.Create(nil);
   if (StartFootage <0 ) or (EndFootage <0 )  then   begin
      StartTime:=Fndp.OutInputTimeSt;
      EndTime:=Fndp.OutInputTimeEd;
   end else begin
      StartTime:=-1; EndTime:=-1;
   end;

end;

function TReturnSupportMoveInfo.DatetimeToFootage(Gzmbh: integer; Dt: TdateTime;
  Str: String): double;
var
  sql:string;
  Df,UF,MF:double;
  DataSet1:TMydataset;
begin
    Result:=0;
    DataSet1:=TmyDataSet.create(nil);
    DataSet1.MySqlConnection:=inMySQlConnection;
    ConnectMySQL;
    if Gzmbh <1  then exit;

   DataSet1.Close;
   Sql:='select sumDownFootage,SumUpperFootage from d_'+IntToStr(Gzmbh)+'_Footage ' +
        ' where FootDay <= '''+FormatDateTime('yyyy-mm-dd hh:nn:ss',dt)+''' order by Footday desc';
   DataSet1.Close ;
   DataSet1.CommandText :=sql;
   if DataSet1.Open  then
       if DataSet1.RecordCount >0 then  begin
          Df:=DataSet1.FieldByName('sumDownFootage').AsFloat;
          Uf:=DataSet1.FieldByName('SumUpperFootage').AsFloat ;
          if Str='Upper' then  begin
             Result:=UF;
          end else if Str='Down' then  begin
             Result:=DF;
          end else begin
             if DF> Uf then  Result:=DF  else Result:=UF;
          end;
          exit;
       end;

   //如果这个时间内没有记录,找最小的一条记录
   Sql:='select sumDownFootage,SumUpperFootage from d_'+IntToStr(Gzmbh)+'_Footage ' +
        ' order by Footday ';
   DataSet1.Close ;
   DataSet1.CommandText :=sql;
   if DataSet1.Open  then
       if DataSet1.RecordCount >0 then  begin
          Df:=DataSet1.FieldByName('sumDownFootage').AsFloat;
          Uf:=DataSet1.FieldByName('SumUpperFootage').AsFloat ;
          if Str='Upper' then  begin
             Result:=UF;
          end else if Str='Down' then  begin
             Result:=DF;
          end else begin
             if DF> Uf then  Result:=DF  else Result:=UF;
          end;
          exit;
       end;
   DataSet1.Close ;
   DataSet1.Free;
end;

destructor TReturnSupportMoveInfo.Destroy;
begin
  FreeAndNil(inMySqlConnection);
  CoUninitialize;
  inherited;
end;

procedure TReturnSupportMoveInfo.Execute;
 var
  Mineid,gzmbh:integer;
begin
  inherited;
    Mineid:=SelKuangjingBianHao(MineName);
    if Mineid<0 then  exit;
    Gzmbh:=IsExistWorkFace(Mineid,WorkfaceName);
    if Gzmbh<0 then   exit;
    SetOutString(gzmbh,zjbh);
end;


function TReturnSupportMoveInfo.GetSupportMoveInfo(Gzmid: integer;supbh:integer): string;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
   ChildChildRoot,ChildChildChildRoot: TXmlNode;
   FourthChildRoot: TXmlNode;

   i:integer;
   sql:string;
   ExDataSet1:TMyDataSet;
   FinGzm:TGzm;
   RecordNO,FirstC,SecondC,ThirdC,FourthC:Integer;
   CCl,mzl:double;
   fileName:String;
begin
  try
    ExDataSet1:=TMyDataSet.Create(nil);
    ExDataSet1.MySqlConnection:=inMySQlConnection;
    FinGzm:=TGzm.Create(inMySQlConnection);
    FinGzm.InputGzmData(Gzmid);
    //
    ConnectMySQL; // 测试数据库连接
     MyXml:=TNativeXml.CreateName(UTF8String('矿山压力预警信息返回结果')) ;
     RootNode:= MyXml.root.NodeNew('');
     RootNode.Name:='Custom';
     ChildRoot:=RootNode.NodeNew('');
     ChildRoot.Name:=UTF8String('WorkFaceName');   // workfacename
     ChildRoot.Value:= UTF8String(WorkfaceName);
     //
     sql:=' select phaseNumber,startbh,endbh from  D_' +Trim(IntToStr(Gzmid)) +'_thirddp '+
          ' Group by phaseNumber order by phaseNumber  ';
     ExDataSet1.Close;
     ExDataSet1.CommandText:=sql;
   if ExDataSet1.Open then  begin
     ChildChildRoot:=ChildRoot.NodeNew('');
     ChildChildRoot.Name:=UTF8String('PhaseInfo');
      while not  ExDataSet1.Eof do begin
        ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
        ChildChildChildRoot.Name:=UTF8String('PhaseNO:'+ExDataSet1.FieldByName('phaseNumber').AsString);


        FourthChildRoot:= ChildChildChildRoot.NodeNew('') ;
        FourthChildRoot.Name:=UTF8String('StartSupport');
        FourthChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('startbh').AsString);

        FourthChildRoot:= ChildChildChildRoot.NodeNew('') ;
        FourthChildRoot.Name:=UTF8String('EndSupport');
        FourthChildRoot.Value :=UTF8String(ExDataSet1.FieldByName('endbh').AsString);
        ExDataSet1.Next ;
      end;
   end;
     ExDataSet1.Close;
     // 支架循环信息
     FirstC:=0;SecondC:=0;

    sql:=' select TypeData,footage,supportStartPress,SupportBeforeMovePress,Max_value,Min_value,AGV_cycle_Value '+
     ' from  D_' +Trim(IntToStr(Gzmid)) +'_Seconddp '+ ' where  supportbh ='+IntToStr(supbh) +
     ' and footage >= '+FormatFloat('0.00',StartFootage) +' and footage <= '+ FormatFloat('0.00',EndFootage) +
     ' order by starttime,TypeData ';
     ExDataSet1.Close;
     ExDataSet1.CommandText:=sql;
     if ExDataSet1.Open then begin
       ExDataSet1.First ;
       if ExDataSet1.RecordCount>0 then begin
           ChildChildRoot:=ChildRoot.NodeNew('');
           ChildChildRoot.Name:=UTF8String('SupportNo:'+ intToStr(supbh));
           RecordNO:=1;
           ChildChildChildRoot:=ChildChildRoot.NodeNew('');
           ChildChildChildRoot.Name:=UTF8String('MoveNo:'+ intToStr(RecordNO));
              FourthChildRoot:= ChildChildChildRoot.NodeNew('') ;
              FourthChildRoot.Name:=UTF8String('FootAge');
              FourthChildRoot.Value :=UTF8String(FormatFloat('0.00',ExDataSet1.FieldByName('Footage').AsFloat));
          while not  ExDataSet1.Eof do begin
             if ExDataSet1.FieldByName('TypeData').AsString='LeftPressData' then     FirstC:=FirstC+1;
             if ExDataSet1.FieldByName('TypeData').AsString='RightPressData' then    SecondC:=SecondC+1;
             if (FirstC=2) or (SecondC=2) then  begin
                 RecordNO:=RecordNO+1;
                 ChildChildChildRoot:=ChildChildRoot.NodeNew('');
                 ChildChildChildRoot.Name:=UTF8String('MoveNo:'+ intToStr(RecordNO));
                    FourthChildRoot:= ChildChildChildRoot.NodeNew('') ;
                    FourthChildRoot.Name:=UTF8String('FootAge');
                    FourthChildRoot.Value :=UTF8String(FormatFloat('0.00',ExDataSet1.FieldByName('Footage').AsFloat));
                 if FirstC=2 then  begin FirstC:=1; SecondC:=0; end;
                 if SecondC=2 then begin SecondC:=1; FirstC:=0; end;

             end;
              FourthChildRoot:= ChildChildChildRoot.NodeNew('') ;

              CCl:=ExDataSet1.FieldByName('supportStartPress').AsFloat;
              mzl:=ExDataSet1.FieldByName('SupportBeforeMovePress').AsFloat;
              if Mzl<CCl then mzl:=ExDataSet1.FieldByName('Max_Value').AsFloat;

              FourthChildRoot.Name:=UTF8String(ExDataSet1.FieldByName('TypeData').AsString+'_SupportStartPress');
              FourthChildRoot.Value :=UTF8String(FormatFloat('0.00',ccl));

              FourthChildRoot:= ChildChildChildRoot.NodeNew('') ;
              FourthChildRoot.Name:=UTF8String(ExDataSet1.FieldByName('TypeData').AsString+'_SupportBeforeMovePress');
              FourthChildRoot.Value :=UTF8String(FormatFloat('0.00',mzl));

              ExDataSet1.Next ;
          end;
       end;
     end;

     ExDataSet1.Close;
     ExDataSet1.free;

    MyXml.XmlFormat := xfReadable;
    fileName:=Fndp.Get_DllPath+'XmlSavePath' ;
    if not(DirectoryExists(fileName)) then begin
       ForceDirectories(fileName);
    end;
   
    MyXml.SaveToFile(fileName+'\ReturnSupportMoveInfo_'+IntToStr(supbh) +'.xml');
//    Result:=Myxml.WriteToString ;
    Result:='ReturnSupportMoveInfo_'+IntToStr(supbh) +'.xml';
    FreeAndNil(FinGzm);
    MyXml.Free ;
  except
   On e:exception do begin
        Fndp.WriteLog('Eorr: ReturnSupportMoveInfo '+e.Message,'[TReturnSupportMoveInfo]');
   end;
  end;
end;

function TReturnSupportMoveInfo.IsExistWorkFace(Mineid: integer;
     WorkFaceName: String): integer;
var
    Gzm_DataSet1:TMydataset;
begin
    Result:=-1;
try
    Gzm_DataSet1:=TmyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= inMySQlConnection;
    ConnectMySQL;
    try
      Gzm_DataSet1.Close;
      Gzm_DataSet1.CommandText:='select kid,cqid,cqName from cqcsb  where cqName='''+WorkFaceName +'''' +
                                ' and  kid =' +IntToStr(Mineid);
      if Gzm_DataSet1.Open then
         if Gzm_DataSet1.RecordCount>0 then
            Result:=Gzm_DataSet1.FieldByName('cqid').AsInteger;

      Gzm_DataSet1.Close;
    finally
      Gzm_dataSet1.free;
    end;
except
   On e:exception do begin
        Fndp.WriteLog('Eorr: IsExistWorkFace '+e.Message,'[TReturnSupportMoveInfo]');
   end;
end;
end;

function TReturnSupportMoveInfo.SelKuangjingBianHao(
  KuangjingName: String): integer;
var
  DataSet1:TMydataset;
begin
    Result:=-1;
    KuangjingName:=Uppercase(KuangjingName);
 try
    DataSet1:=TmyDataSet.create(nil);
    DataSet1.MySqlConnection:=inMySQlConnection;
    ConnectMySQL;
    try
      DataSet1.Close;
      DataSet1.CommandText:='select id,Meikuangming from Kuangjingxinxibiao  where MeikuangMing='''+KuangjingName +'''';
      if DataSet1.Open then
        if DataSet1.RecordCount>0 then
           Result:=DataSet1.FieldByName('id').AsInteger;

    finally
     DataSet1.Close;
     DataSet1.free;
    end;
 except
   On e:exception do begin
        Fndp.WriteLog('Eorr: SelKuangjingBianHao'+e.Message,'[TReturnSupportMoveInfo]');
   end;
 end;
end;

procedure TReturnSupportMoveInfo.SetOutString(Gzmbh:integer;Supbh:integer);
begin
   if StartTime >40000 then begin
      StartFootage:=DatetimeToFootage(Gzmbh,StartTime,'') ;
      EndFootage:=DatetimeToFootage(Gzmbh,EndTime,'') ;
   end;
   Fndp.inSupportMoveInfo:=GetSupportMoveInfo(Gzmbh,supbh);
end;

end.
