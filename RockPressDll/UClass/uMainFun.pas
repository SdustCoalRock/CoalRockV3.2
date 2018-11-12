//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//<<      �ļ�����uMainform.pas
//<<      ¬��־ʹ�õĸ���Delphi�ļ�                            <<
//<<      ���ļ���Ҫ��¼�˸��˺���                   <<
//<<      �������ڣ�2016.5.12                                   <<
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



unit uMainFun;

interface
uses
  Winapi.Windows, SysUtils, Classes, Messages, Controls, Forms, StdCtrls, ExtCtrls,
  ComCtrls ,math,Grids,WordXP,COMobj,SQLiteTable3,StrUtils,Vcl.Dialogs,
  UMainDataModule, uDisPoseData, PStope_GzmGuidClass,
 // uThread, UsecondThread,  uThirdthread,uFourththread,  FootageThread,  UInputThread,
  SyncObjs,Lu_Public_BasicModual,
  Activex;

type
  TMainForm =class (TObject)
  private
        Create_Public_Basic,Create_Public_Modul:Boolean; // �Ƿ񴴽���ȫ�ֵ�����ģ��
        judgelegal: Boolean ;
        StepOrTime:string;
        function TestDataBaseParameter(const Dtype, IP, User, Password,  Path: WideString): WordBool;  safecall;

         // first t0 fourth   start
        procedure FirstDisPoseData; safecall;
        procedure SecondDisposeData; safecall;
        procedure ThirdDisposeData; safecall;
        procedure FourthDisposeData; safecall;
        procedure AppointFootage; safecall;
        procedure ServiceOnDuty(TimeCount:Integer);safecall;
        // first t0 fourth   stop
        // 1Ϊϵͳ �����˳�����Ҫ����,2 Ϊ �ⲿ�����˳�
        procedure InitFirstDisposeData; safecall;
        function IsValidObject(const Obj: TObject): Boolean;
        function isActiveThread:Boolean;

  public

         //  ��Ҫ�Ĺ����� ����������ݿ⣬�������ݿ⣻������������ݿ⣬�������ݿ⣬������������ݱ���������ɺ��������ݿ⣬����

          function InitService(MySQLAddress : string; MySQLPort : Integer;
            UserName : string; Password : string) : Boolean;

          //  �������� ��Ҫ����һ�������̣߳���������ص����ݷ�������
          procedure StartService;
          //  ���Է����Ƿ��������� �ж����ݵ��߳��Ƿ����
          function IsServiceRunning : Boolean;
          //  ֹͣ���� ֹͣ�̵߳ķ���
          procedure StopService;
          // input footage data
          function InputFootAge(MineName,WorkFacName:string; tDay: TDateTime; DownDayFootAge,
                   SumDownFootAge, UpperDayFootAge, SumUpperFootAge: Double): WordBool;    safecall;
          function RealTimeFootAge(MineName,WorkFacName:string;supportbh: Integer;
                        Generatetime:TdateTime;RealDataValue:double):Wordbool;
          //input Support data
          function SetSupportDataType(FirstType:integer;FirstDataTopLine :Double;
                                      SecondType:integer;SecondDataTopline:double;
                                      ThirdType:integer;ThirdDataTopLine:double;
                                      FouthType:integer;FourthDataTopLine:double): WordBool;
          function SetSupportDataType_GZM(MineName,WorkFacName:string;StartTime:TdateTime;
                                      FirstType:integer;FirstDataTopLine :Double;
                                      SecondType:integer;SecondDataTopline:double;
                                      ThirdType:integer;ThirdDataTopLine:double;
                                      FouthType:integer;FourthDataTopLine:double): WordBool;
          //�������1 �������룬�������-1 ֹͣ���룬���ݿ��м�¼̫�࣬��ȴ�1��������
          function Inputdata(MineName,WorkFacName:string;supportbh: Integer;  const datatime: WideString; V1, V2, V3,
                             V4: Double): Integer; safecall;
          //  ֧����Ϣ
          //  ����ֵ��Լ����ִ�гɹ�Ϊ�գ�����Ϊʧ�ܵ�ԭ��
          function RefreshSupport(SupportInfo : string) : string;
          //  ɾ��֧����Ϣ
          function DeleteSupport(SupportInfo : string) : Boolean;


           //  ���������Ϣ
          //  ����ֵ��Լ����ִ�гɹ�Ϊ�գ�����Ϊʧ�ܵ�ԭ��
          function RefreshDrillInfo(DrillInfo : string) : string;
          //  ɾ�������Ϣ
          function DeleteDrill(DrillInfo : string) : Boolean;


            //  ���¹�����
          //  ����ֵ��Լ����ִ�гɹ�Ϊ�գ�����Ϊʧ�ܵ�ԭ��
          function RefreshWorkface(WorkfaceInfo : string) : string;
          //  ɾ��������
          function DeleteWorkface(WorkfaceInfo : string) : Boolean;

           //  ú��
           //  ����ֵ��Լ����ִ�гɹ�Ϊ�գ�����Ϊʧ�ܵ�ԭ��
          function RefreshCoalPillar( CoalPillarInfo : string) : string;
          function DeleteCoalPillar( CoalPillarInfo : string) : Boolean;


          //  �ɿ���

          //  ����ֵ��Լ����ִ�гɹ�Ϊ�գ�����Ϊʧ�ܵ�ԭ��
          function RefreshMineOutArea( MineOutAreaInfo : string) : string;
          function DeleteMineOutArea( MineOutAreaInfo : string) : Boolean;


          //  �ϲ�
           //  ����ֵ��Լ����ִ�гɹ�Ϊ�գ�����Ϊʧ�ܵ�ԭ��
          function RefreshFault( FaultInfo : string) : string;
          function DeleteFault( FaultInfo : string) : Boolean;


          //  ����빤�����
          //  ����ֵ��Լ����ִ�гɹ�Ϊ�գ�����Ϊʧ�ܵ�ԭ��
          function WorkfaceSelectDrill( DrillsInfo : string) : string;
          //  ֧���빤�����
          //  ����ֵ��Լ����ִ�гɹ�Ϊ�գ�����Ϊʧ�ܵ�ԭ��
          function WorkfaceSelectSupport( SupportsInfo : string) : string;


          //  ���ݹ�����
          //  ����ֵ��Լ����ִ�гɹ�Ϊ�գ�����Ϊʧ�ܵ�ԭ��
          function BackupWorkface(MineName,WorkfaceName : string; ToFolder : string) : string;
          //  �ָ�������
          //  ����ֵ��Լ����ִ�гɹ�Ϊ�գ�����Ϊʧ�ܵ�ԭ��
          function RestoreWorkface(MineName,WorkfaceName : string;FromFolder : string) : string;


          //  ������
          //  ����ֵΪxml��ʽ���ַ���
          function GetForcastResult(var pdata: pansichar; var len:integer) : Boolean;
          function GetHistoryResult_Time(MineName,WorkfaceName : string; StartTime : TDateTime; StopTime : TDateTime) : string;
          function GetHistoryResult_Foot(MineName,WorkfaceName : string; StartFootage ,StopFootage : double) : string;

          //
          function GetInputDataMaxDatetime(MineName,WorkfaceName : string):TDateTime;
          function GetSupportMoveInfo_Time(MineName,WorkfaceName : string;
                                      startTime,endTime:TDateTime;Supportbh:integer):string;
          function GetSupportMoveInfo_Foot(MineName,WorkfaceName : string;
                                      startfootage,endfootage:double;Supportbh:integer):string;

          // 20180411
          procedure  SetStatusCaption(Value:String);
          procedure  SetLicenseing(Value:Boolean;UName:string);

           constructor Create;
           destructor Destroy;override;
          //��־�ļ�
           function Get_DllPath: WideString; safecall;
           procedure WriteLog(const data:Ansistring; FFM : Ansistring='FFQ');
           procedure CreateXmLSavepath;
           Procedure SetJudgelegal(Value:Boolean);
           function  CreateClass:Boolean;
           function  FreeClass:Boolean;
           //

  end;

// ======================
//ȫ�ֱ���
   var
   MyMainFun:TMainForm; // �ⲿ���Ե���
   ServeiceStopState:Integer; // 0 �������� 1 �ڲ�����ֹͣ  2 ������ֹͣ 3 �ⲿ���� ֹͣ
  // FsyncSQL:Trtlcriticalsection;
   FsyncWriteIni:Trtlcriticalsection;
   FsyncWritelog:Trtlcriticalsection;
   ReturnForCase:string;
   PublicWriteLog:Boolean;
  //��������
    function  GetProcessThreadExist( const ProcessName: WideString): WordBool;
    procedure inn_StartService;   //��������
    function  IsExistFirstThread( threadNumber:integer): Boolean;   // �����ĺ���
    procedure manageFDP;   // �����ĺ���  ��һ�����ݴ���
    procedure StopProcess; //ֹͣ����

implementation
// �ֲ����������ޱ�����ʹ��

var   //��������
        dllPath :string;
        uDisposeData:TDisPoseData;
        uExGzm:TGzm;
        hFirstThread: THandle;
//        hSecondThread:TSecondThread;
//        //�ѽ��ߴ���������������Ľ���,��һ������Ϊ���ߵ��ۼ�,����secondDpʹ��
//
//        hFootAgeThread:TFootAgeThread;
        hService,hStopService:THandle;
//        // ���±���Ϊ ʹ�ò���������ж��жϷ��뷽��
//        hthirdThread: TThirdThread;
//        hFourthThread: TThirdThread;
//        //���±���Ϊ ʹ��ʱ��������ж��жϷ��뷽��
//        Time_thirdThread: TFourthThread;
//        Time_FourthThread: TFourthThread;
        //


//        hGetHisForcaseResule:THistroyForCaseREsult;
//        hForCaseThread:TGetForCaseResult;
//        hSupportMoveThread:TReturnSupportMoveInfo;
        FthreadNumber:integer;
//        MultThreadFirstProcess:array [0..10] of TFirstDisPoseThread;
       // Lu_Stope



//============================================

 //��ȡ�̵߳��Ƿ����
function GetProcessThreadExist( const ProcessName: WideString): WordBool;
var
    ExitCode: DWord;
    Name:String;
    i:integer;
    FirstThread:Boolean;
begin
    Name:=UpperCase(ProcessName);
    if Name='FIRSTPROCESS' then    begin  //FirstProcess
        GetExitCodeThread(hFirstThread, ExitCode);
    end;

//    if Name='SECONDPROCESS' then   //second thread
//        if Assigned(hSecondThread) then
//          GetExitCodeThread(hSecondThread.Handle, ExitCode);
//
//    if Name='THIRDPROCESS' then   begin  //Third thread
//        if Assigned(hThirdThread) then
//            GetExitCodeThread(hThirdThread.Handle, ExitCode);
//         if Assigned(Time_ThirdThread) then
//            GetExitCodeThread(Time_ThirdThread.Handle, ExitCode);
//    end;
//
//    if Name='FOUTHPROCESS' then   begin //fourth thread
//         if Assigned(hFourthThread) then
//            GetExitCodeThread(hFourthThread.Handle, ExitCode);
//         if Assigned(Time_FourthThread) then
//            GetExitCodeThread(Time_FourthThread.Handle, ExitCode);
//    end;
//
//
//    if  Name='APPOINTFOOTAGE' then     //the FootAge
//         if Assigned(hFootAgeThread) then
//          GetExitCodeThread(hFootAgeThread.Handle, ExitCode);
//
//    if  Name='STARTSERVICE' then     //the �����߳�
//          GetExitCodeThread(hservice, ExitCode);
//    if  Name='STOPPROCESS' then     //the StopProcess
//          GetExitCodeThread(hStopservice, ExitCode);
//
//    if  Name='FORCASE' then    //forcase
//        if Assigned(hForCaseThread) then
//          GetExitCodeThread(hForCaseThread.Handle, ExitCode);
//    if  Name='HISTORYRESULT' then    //hGetHisForcaseResule
//        if Assigned(hGetHisForcaseResule) then
//          GetExitCodeThread(hGetHisForcaseResule.Handle, ExitCode);
//   if  Name='SUPPORTMOVEINFO' then    //SupportMoveIfo
//        if Assigned(hSupportMoveThread) then
//          GetExitCodeThread(hSupportMoveThread.Handle, ExitCode);
//


    //  ͳһ����
    if ExitCode = STILL_ACTIVE then
       Result:=true
     else
       Result:=False;


end;
//
procedure inn_StartService;   //��������
var
  ss,tt :string;
  Str_V:String;
  PausedOrStop,TN:integer;// 0 ����  1 paused 2 stop
  St:TdateTime;
  sCount:integer;
  Inn_Dtype,inn_ip,inn_user,inn_Pass,inn_path,Port:String;
  ID:DWORD;
begin
//    ServeiceStopState:=0;
//   // ShowMessage('serveOk');
//  //  uDisposeData.StopserviceCommand:=1;
//    //��ע��������
//    uDisposeData.WriteIniProcess(now(),0);
//    //��ȡ������Ϣ
//    uDisposeData.ReadServerinfo(Inn_Dtype,Inn_Ip,Inn_User,Inn_Pass,Inn_Path,port);
//    uMyDataModule.SetExDataType(Inn_Dtype);
//    uMyDataModule.SetExDBaseInfo(inn_Ip,inn_User,inn_Pass);
//    uMyDataModule.SetMySqlPort(Port);
//     //  �������ݿ�
//    if not uMyDataModule.ConnectedData(Inn_Dtype,uMyDataModule.DataBaseName) then  exit;
//    // split supportDatatype
//
////    if not uDisposeData.ReadiniSV(uDisposeData.FirstValue,uDisposeData.SecondValue,
////                      uDisposeData.ThirdValue,uDisposeData.FourthValue) then  exit;
////    uExGzm.setSupportType(uDisposeData.FirstValue,uDisposeData.SecondValue,
////                      uDisposeData.ThirdValue,uDisposeData.FourthValue);
//
//
//    //-------
//    uDisposeData.DataIniTimeInterval:=uDisposeData.ReadIniTimeInterval; // ʱ�������
//    uDisposeData.TimeInterValSupportData:=uDisposeData.ReadiniDataNeverDisCTime;  // ʱ�䲻��ϼ��
//    if uDisposeData.DataIniTimeInterval =0  then  uDisposeData.DataIniTimeInterval:=1;
//    // �Ѽ���ʱ������FGZM��ֵ
//    uExGzm.SetDateintervalTime(uDisposeData.DataIniTimeInterval);
//    //------
//    if uDisposeData.TimeInterValSupportData=0  then  uDisposeData.TimeInterValSupportData:=2;
//     uDisposeData.SetDateNeverDiscontime(uDisposeData.TimeInterValSupportData) ;
//    //start
//     scount:=0;
//     if PublicWriteLog then
//        MY_WriteLog(Get_MyModulePath,'SerVice Start','[TServiceStop]');
//    while   ServeiceStopState < 1 do   begin
//         //ֹͣ0.1 ��
//         sleep(100);
//          //Read ProcessState to PausedOrstop
//          uDisposeData.ReadIniProcess(st,PausedOrstop,TN) ;
//          if PausedOrstop=0 then  begin
//             ServeiceStopState:=0;
//          end else if PausedOrstop >0 then  begin
//             ServeiceStopState:=3;
//          end;
//          //�����ķ���ṹ
//          if not uMyDataModule.Connected  then  begin    //ͨ��ѭ�� �������ݿ�
//                 uMyDataModule.ConnectedData(Inn_Dtype,uMyDataModule.DataBaseName);
//          end  else begin
//            if scount mod (10*60)=0 then begin//60 ���ӷ���һ�μ���
//                if not  GetProcessThreadExist('FIRSTPROCESS') then begin
//                        MyMainFun.InitFirstDisposeData;
//                        MyMainFun.FirstDisPoseData;   {��һ�δ���}
//                end;
//                if not  GetProcessThreadExist('SECONDPROCESS') then
//                        MyMainFun.SecondDisposeData ;  {�ڶ��δ�������}
//                if (not  GetProcessThreadExist('APPOINTFOOTAGE')) then
//                        MyMainFun.AppointFootage ;   {�����������,�����SeconpDP���ݱ���}
//                if not  GetProcessThreadExist('THIRDPROCESS') then
//                        MyMainFun.ThirdDisposeData ; {�����δ�������,�ҵ���ѹ����}
//                if not  GetProcessThreadExist('FOUTHPROCESS') then
//                        MyMainFun.FourthDisposeData ;  {���Ĵδ�������,Ԥ��Ԥ��}
//
//            end;
//            if scount > (10*60*10) then begin //2 Сʱ��������
//                 ServeiceStopState:=1;
//                 hStopService:=CreateThread(nil, 0, @StopProcess, nil, 0, ID);
//                 if PublicWriteLog then
//                    MY_WriteLog(Get_MyModulePath,'SerVice Stop','[TServiceStop]');
//            end;
//
//            // MyMainFun.ServiceOnDuty(Scount);
//
//          end;
//          Scount:=scount+1;   //����
//   end;  //end while
//    //uDisposeData.StopserviceCommand:=0;
end;  //end inn_service


//-------
function IsExistFirstThread( threadNumber:integer): Boolean;  // �����ĺ���
var
    exitCode: DWord;
begin
//       if Assigned(MultThreadFirstProcess[threadNumber]) then
//          GetExitCodeThread(MultThreadfirstProcess[threadNumber].Handle, exitCode);
//       if exitCode = STILL_ACTIVE then begin
//          Result:=True;
//       end else begin
//          Result:=False;
//       end;
end;

procedure manageFDP;   // �����ĺ���  ��һ�����ݴ���
var
   i,j,ListGzm:integer;
   MinBh,Maxbh,RecordNumber: Integer;
   CurrentBh:integer;
   MyDataConn:TMySqlConnection;
   DataSetGzm:TMyDataSet;
   DataCommand:TMyCommand;
   FGzmbh:string;
   GzmList:TStringlist;
   Sql:string;
   Bc_Count,SC_Count:integer;
begin
   MyDataConn:=TMySqlConnection.Create(nil);
   MyDataConn.Open(MainDataModule.EXDataIP,MainDataModule.Port,MainDataModule.ExUser,
                    MainDataModule.EXPassword,MainDataModule.DataBaseName);

   DataSetGzm:=TMyDataSet.Create(nil);
   DataSetGzm.MySqlConnection:=MyDataConn;
   DataCommand:=TMyCommand.Create(nil);
   DataCommand.MySqlConnection:= MyDataConn;
   GzmList:=TStringlist.Create ;
   DataSetGzm.Close ;
   DataSetGzm.CommandText:='select cqid from cqcsb where qyzt=1';
   if DataSetGzm.Open then
         while not DataSetGzm.Eof  do  begin
             GzmList.Add(Trim(IntToStr(DataSetGzm.FieldByName('cqid').AsInteger)));
             DataSetGzm.Next ;
         end; //end while not DataSetGzm.Eof
   DataSetGzm.Close ;

    //----
  try

    for ListGzm := 0 to GzmList.Count - 1 do  begin
        FGzmbh:=GzmList[ListGzm];

        if uDisposeData.FirstProcessStop  then  break;
        uDisposeData.SelectBasicRecordNumber(MyDataConn,FGzmbh,Minbh,Maxbh,RecordNumber) ;
        uDisposeData.setGzmbm(FGzmbh);
        if RecordNumber <1 then  Continue;
        FthreadNumber:=Public_Basic.ReadiniThreadNumber;
        if FthreadNumber >10 then  FthreadNumber:=10;
        if FthreadNumber <1 then  FthreadNumber:=1;

        CurrentBh:=Minbh;
        if uDisposeData.FirstProcessStop  then  break;
       while CurrentBh<=MaxBh do  begin
           if uDisposeData.FirstProcessStop  then  break;
           //select supportbh is exsit
            Sql:=' select  count(id) as BC  from D_'+Trim(FGzmbh)+'_BasicData  '+
                 ' where supportbh ='+intTostr(CurrentBh);
            DataSetGzm.Close;
            DataSetGzm.CommandText :=sql;
            if DataSetGzm.Open  then  begin
               Bc_Count:=DataSetGzm.FieldByName('BC').AsInteger;
            end else begin
               Break;
            end;
            DataSetGzm.Close;
            Sql:=' select  count(id) as SC  from D_'+Trim(FGzmbh)+'_Strokedata  '+
                 ' where supportbh ='+intTostr(CurrentBh);

            DataSetGzm.CommandText :=sql;
            if DataSetGzm.Open  then  begin
               SC_Count:=DataSetGzm.FieldByName('SC').AsInteger;
            end else begin
               break;
            end;
            DataSetGzm.Close;
            if (Bc_Count< 3)  and (SC_Count< 10) then    begin
               CurrentBh:=CurrentBh+1;
               continue;
            end;
            //�жϸ�֧���Ƿ񱻱���ʹ��  // slect SelectProcessRecorderUsed
            sql:='select  Used from D_'+FGzmbh+'_ProcessRecord where '+
                 ' SupportBh =' +intToStr(CurrentBh);
             DataSetGzm.Close;
             DataSetGzm.CommandText:=Sql;
            if  DataSetGzm.Open then   begin
                 if (DataSetGzm.RecordCount>0) and (DataSetGzm.FieldByName('Used').AsInteger =1) then begin
                    CurrentBh:=CurrentBh+1;
                    continue;
                 end;
            end else begin
              break;
            end;
            DataSetGzm.Close;
            //into �̼߳���
//            for I := 0 to FthreadNumber - 1 do  begin
              for I := 0 to 1 - 1 do  begin
                if uDisposeData.FirstProcessStop  then  break;
                if IsExistFirstThread(i)  then   continue;
                //ռ�ñ��
                DataCommand.CommandText:= 'update D_'+Trim(FGzmBh)+'_Processrecord  set used=1  where supportbh= '+
                                       IntToStr(CurrentBh);

                DataCommand.Execute ;
               // �����߳�
//                MultThreadFirstProcess[i]:=TFirstDisPoseThread.Create(uDisposeData,  FGzmbh,
//                                          uMyDataModule.GetExDataType,CurrentBh) ;
//                MultThreadFirstProcess[i].Resume;
//                CurrentBh:=CurrentBh+1;
                break;
            end; // end  I := 0 to FthreadNumber - 1 do

       end; // end   while


    end;  //end for

  finally
   FreeAndNil(GzmList);
   DataSetGzm.Free ;
   DataCommand.Free;
  
  end;
   MyDataConn.Close ;
   MyDataConn.Free ;
end;//�����ĺ���


{ TMainForm }
//=============================================================================
procedure TMainForm.AppointFootage;
begin
//   try
//        uDisposeData.AppointFootageStop :=false;
//        hFootAgeThread:=TFootAgeThread.Create(uDisposeData, 'AppointFootage' ) ;
//   finally
//        hFootAgeThread.Resume;
//   end;
end;

function TMainForm.BackupWorkface(MineName,WorkfaceName , ToFolder: string): string;
var
  Gzmbh,Mineid:integer;
begin
//    Result:='';
//    Mineid:=uExGzm.SelKuangjingBianHao(MineName);
//    Gzmbh:=uExGzm.IsExistWorkFace(Mineid,WorkfaceName);
//    uExGzm.setGzmNumber(Gzmbh);
//    if uExGzm.ReadData then  begin
//       Result:= uExGzm.BackupWorkface(ToFolder) ;
//    end else begin
//       uExGzm.MakeGzmIsVail(0);
//    end;

end;



constructor TMainForm.Create;
begin
    inherited create;
 //  CoInitialize(Nil);
    Create_Public_Basic:=False;
    Create_Public_Modul:=False; // �Ƿ񴴽���ȫ�ֵ�����ģ��
    if not Assigned(Public_Basic) then  begin
       Public_Basic:=TLu_BasicClass.Create('','ServerInfo.dll');
       Create_Public_Basic:=true;
    end;

     if not Assigned(MainDataModule )then    begin
        MainDataModule:=TDataModule1.Create(nil) ;
        MainDataModule.ExMainPath :=Public_Basic.Get_MyModulePath ;
        MainDataModule.ConnectSystemDataBase;
        Create_Public_Modul:=true;
     end;


    Try
        Get_dllPath; {���·��}
        CreateClass ;
    Finally

    End;


end;
function TMainForm.CreateClass: Boolean;
var
  temp_Name:string;
begin
  //��ʼ��   ��Ҫ�Ǵ����������
 Result:=true;
 try


//
//      if not Assigned(uDisposeData) then    begin
//         uDisposeData:=TDisPoseData.Create(MainDataModule);
//      end;
//
//       if not Assigned(uExGzm) then
//          uExGzm:=TGzm.Create(MainDataModule.ExConn);
//
//      judgelegal:=False;
//      ServeiceStopState:=0;
//
//      //��׼�Ƿ��¼������¼
//      uDisposeData.writeProcessflag:=Public_Basic.ReadiniSaveProcesslog; //����¼  ϵͳĬ�ϼ�¼
//      // �������жϰ��ղ��໹�ǰ���ʱ��
//      StepOrTime:='Time';  // 'Step'


      PublicWriteLog:=true;


 except
   on e:exception do begin
        Public_Basic.MY_WriteLog('CreateClass:'+e.Message,'[TServiceStop]');
        Result:=false;
   end;

 end;
end;

procedure TMainForm.CreateXmLSavepath;
var
  XmlPath:string;
begin
     XmlPath:=Get_DllPath+'\XmlSavePath\';
    if not DirectoryExists(XmlPath) then begin
       ForceDirectories(XmlPath);
    end;
end;

function TMainForm.DeleteCoalPillar(CoalPillarInfo: string): Boolean;
begin
    if uExGzm.ReadCoalPliiarXml(CoalPillarInfo,'Delete')='' then
       Result:=true else Result:=false;
end;

function TMainForm.DeleteDrill(DrillInfo: string): Boolean;
begin
   if uExGzm.ReadDrillInfo(DrillInfo,'Delete')='' then
       Result:=true else Result:=false;
end;




function TMainForm.DeleteFault(FaultInfo: string): Boolean;
begin
      if uExGzm.ReadFaultXml(FaultInfo,'Delete')='' then
       Result:=true else Result:=false;
end;

function TMainForm.DeleteMineOutArea(MineOutAreaInfo: string): Boolean;
begin
     if uExGzm.ReadMineOutAreaXml(MineOutAreaInfo,'Delete')='' then
       Result:=true else Result:=false;
end;

function TMainForm.DeleteSupport(SupportInfo: string): Boolean;
begin
    if  uExGzm.ReadSupportInfo(SupportInfo,'Delete')='' then
        Result:=true else Result:=false;

end;

function TMainForm.DeleteWorkface(WorkfaceInfo: string): Boolean;
var
  event:string;
  gzmid:integer;
begin
    Result:=False;
    if uExGzm.ReadWorkFaceXml(WorkfaceInfo,'Delete',event,gzmid)='' then  begin
       Result:=true;
    end;
end;

destructor TMainForm.Destroy;
begin
 try
  // StopService;
   FreeClass;
   // �漰��ȫ�ֱ������ͷ�  �Լ��������Լ��ͷ�
   if  Create_Public_Modul then
      if Assigned(MainDataModule) then   FreeAndNil(MainDataModule);
   if Create_Public_Basic then
       if Assigned(Public_Basic) then   FreeAndNil(Public_Basic);

  // CoUninitialize;
 finally
   inherited Destroy;
 end;
end;

procedure TMainForm.FirstDisPoseData;
var
  ID: DWORD;
begin
   try
       // initFirstDisposeData;
        uDisposeData.FirstProcessStop:=false;
        if not  judgelegal then  exit;
        hFirstThread := CreateThread(nil, 0, @manageFDP, nil, 0, ID);
   except
        TerminateThread(hFirstThread,ID);
   end;


end;

procedure TMainForm.FourthDisposeData;
begin
//   if StepOrTime='Step'  then  begin
//        try
//            uDisposeData.SetFourthProcessStop(false);
//            hFourthThread:=TThirdThread.Create(uDisposeData,uMyDataModule.GetExDataType,'Forcase') ;
//        finally
//            hFourthThread.Resume;
//        end;
//   end else if StepOrTime='Time'  then  begin
//        try
//            uDisposeData.SetFourthProcessStop(false);
//            Time_FourthThread:=TFourthThread.Create(uDisposeData,uMyDataModule.GetExDataType,'Forcase') ;
//        finally
//            Time_FourthThread.Resume;
//        end;
//   end;
end;



function TMainForm.FreeClass: Boolean;
begin
 Result:=True;
 try

    if Assigned(uExGzm) then
          FreeAndNil(uExGzm) ;
    if Assigned(uDisposeData) then
          FreeAndNil(uDisposeData) ;


 except
     on e:exception do begin
        Public_Basic.MY_WriteLog('FreeClass:'+e.Message,'[TServiceStop]');
     end;
 end;


end;

function TMainForm.GetForcastResult(var pdata: pansichar; var len:integer) : Boolean;
begin
//   Result:=False;
//   try
//    if GetProcessThreadExist('FORCASE') then exit;
//    uDisposeData.inReturnForCase:='';
//    try
//        hForCaseThread:=TGetForCaseResult.Create(uDisposeData) ;
//    finally
//        hForCaseThread.Resume;
//    end;
//   except
//      On e:exception do begin
//        WriteLog('Eorr:GetForcastResult Thread'+e.Message,'[TGetForCaseResult]');
//      end;
//   end;
//   while length(trim(uDisposeData.inReturnForCase))<=0 do  sleep(10);
//
//    Pdata:=PansiChar(AnsiString(uDisposeData.inReturnForCase));
//    Len:=length(uDisposeData.inReturnForCase);
//    Result:=true;
end;


function TMainForm.GetHistoryResult_Foot(MineName, WorkfaceName: string;
  StartFootage, StopFootage: double): string;
var
  St,Ed:String;
begin
//    Result:='';
//    uDisposeData.OutInputFootSt:=startFootage;
//    uDisposeData.OutInputFootEd:=StopFootage;
//
//    st:=FormatDateTime('yyyy-mm-dd', -1);
//    Ed:=FormatDateTime('yyyy-mm-dd', -1);
//    uDisposeData.HistoryResult:='';
//
//    if startFootage < 0  then  uDisposeData.OutInputFootSt:=0;
//    if StopFootage  < 1 then   exit;
//
//    if GetProcessThreadExist('HISTORYRESULT') then exit;
//    uDisposeData.HistoryResult:='';
//    try
//        hGetHisForcaseResule:=THistroyForCaseResult.Create(uDisposeData,MineName,
//                              WorkfaceName,st,ed ) ;
//    finally
//        hGetHisForcaseResule.Resume;
//    end;
//
//   while length(trim(uDisposeData.HistoryResult))<=0 do  sleep(10);
//   Result:=uDisposeData.HistoryResult;

end;

function TMainForm.GetHistoryResult_Time(MineName, WorkfaceName: string;
  StartTime, StopTime: TDateTime): string;
var
  St,Ed:String;
begin
//    Result:='';
//    st:=FormatDateTime('yyyy-mm-dd', StartTime);
//    Ed:=FormatDateTime('yyyy-mm-dd', StopTime);
//    uDisposeData.HistoryResult:='';
//    if (StartTime < 40000) or  (StopTime <40000) then  exit;
//    if GetProcessThreadExist('HISTORYRESULT') then exit;
//    try
//       hGetHisForcaseResule:=THistroyForCaseResult.Create(uDisposeData,MineName,
//                              WorkfaceName,st,ed ) ;
//    finally
//      hGetHisForcaseResule.Resume;
//    end;
//
//   while length(trim(uDisposeData.HistoryResult))<=0 do  sleep(10);
//   Result:=uDisposeData.HistoryResult;

end;

function TMainForm.GetInputDataMaxDatetime(MineName,WorkfaceName : string): TDateTime;
var
 Mineid,Gzmbh:Integer;
begin
//    Mineid:=uExGzm.SelKuangjingBianHao(MineName);
//    Gzmbh:=uExGzm.IsExistWorkFace(Mineid,WorkfaceName);
//    if Gzmbh=-1 then  begin
//       Result:=1;
//       exit;
//    end;
//
//    Result:= uDisposeData.GetInputDataMaxDatetime(Mineid,Gzmbh);
end;




function TMainForm.GetSupportMoveInfo_Foot(MineName, WorkfaceName: string;
  startfootage, endfootage: double; Supportbh: integer): string;
begin
//    Result:='';
//    uDisposeData.OutInputTimeSt:= -1;
//    uDisposeData.OutInputTimeEd:= -1;
//    if GetProcessThreadExist('SUPPORTMOVEINFO') then exit;
//    uDisposeData.inSupportMoveInfo:='';
//    try
//      hSupportMoveThread:=TReturnSupportMoveInfo.Create(uDisposeData,MineName,
//                              WorkfaceName,startfootage,endfootage,Supportbh ) ;
//
//    finally
//      hSupportMoveThread.Resume;
//    end;
//
//    while length(trim(uDisposeData.inSupportMoveInfo))<=0 do
//       sleep(10);
//
//    Result:=uDisposeData.inSupportMoveInfo;
end;

function TMainForm.GetSupportMoveInfo_Time(MineName, WorkfaceName: string;
  startTime, endTime: TDateTime; Supportbh: integer): string;
var
  SF,EF:double;
begin
//    Result:='';
//    if (startTime < 40000 ) or (endTime <40000) then exit;
//    uDisposeData.OutInputTimeSt:= startTime;
//    uDisposeData.OutInputTimeEd:= endTime;
//    SF:=-1;EF:=-1;
//    if GetProcessThreadExist('SUPPORTMOVEINFO') then exit;
//    uDisposeData.inSupportMoveInfo:='';
//    try
//      hSupportMoveThread:=TReturnSupportMoveInfo.Create(uDisposeData,MineName,
//                              WorkfaceName,SF,EF,Supportbh ) ;
//
//    finally
//      hSupportMoveThread.Resume;
//    end;
//
//    while length(trim(uDisposeData.inSupportMoveInfo))<=0 do
//       sleep(10);
//
//    Result:=uDisposeData.inSupportMoveInfo;
end;

function TMainForm.Get_DllPath: WideString;
var
   ModuleName:WideString;
   i:integer;
begin
          SetLength(ModuleName, 255);
          GetModuleFileName(HInstance, PwideChar(ModuleName), Length(ModuleName));
          dllPath:=Trim(PwideChar(ModuleName)) ;
          i:=Pos('\',ReverseString(dllPath));

          dllPath:=Copy(dllPath,1,Length(dllPath)-i+1);
          Result:=dllPath;

end;

function TMainForm.InitService(MySQLAddress: string; MySQLPort: Integer;
  UserName, Password: string): Boolean;
{
  Note��
  //  ��Ҫ�Ĺ����� ����������ݿ⣬�������ݿ⣻������������ݿ⣬�������ݿ⣬������������ݱ���
  //������ɺ��������ݿ⣬����
}

begin
     if not MainDataModule.ConnectSystemDataBase then
        Result:=False;
end;

function TMainForm.Inputdata(MineName, WorkFacName: string; supportbh: Integer;
  const datatime: WideString; V1, V2, V3, V4: Double): Integer;
var
  Gzmbh,Mineid:integer;
  eltime:string;
begin
     Result:=-1;
     uDisposeData.inputStarttime :=0;
     if uDisposeData.PressDataBeginTrans =0 then
        uDisposeData.InputData_Begintrans;

     uDisposeData.InputTimer.Enabled :=true;
   try
        Mineid:=uDisposeData.SelKuangjingId(MineName);
        Gzmbh:=uDisposeData.SelectWorkFaceid(Mineid,WorkfacName);
        { TODO : �����趨 }
        if Gzmbh =-1  then   exit;

        if not uDisposeData.SelectBasicDataCount(IntToStr(Gzmbh)) then begin //������ݿ�������10������¼
           if not IsServiceRunning then StartService; //�������û����������������
        end else begin    //�������¼����
          if IntToStr(Gzmbh)<> uDisposeData.uDisPoseGzmBh then begin  //�������������
             uDisposeData.InputData_CommitTrans(eltime);
             uDisposeData.setGzmbm(IntToStr(Gzmbh));
             uDisposeData.InputData_Begintrans;
          end;
          uDisposeData.InPutdata(Supportbh,dataTime,v1,v2,V3,v4,uDisposeData.InputData_elapsedtime);
          Result:=1;
        end;
   except
     on e:exception do begin
        MyMainFun.WriteLog('Eorr:Create Thread FALSE  '+e.Message,'[InputFootage]');
        Result:=-1;
     end;
   end;
end;

function TMainForm.InputFootAge(MineName,WorkFacName: string; tDay: TDateTime;
  DownDayFootAge, SumDownFootAge, UpperDayFootAge,
  SumUpperFootAge: Double): WordBool;
var
  Gzmbh,Mineid:integer;
begin
   Result:=false;
    try
        Mineid:=uDisposeData.InputFootSelKuangjingId(MineName);
        if Mineid<0  then   exit;
        Gzmbh:=uDisposeData.InputFootSelectWorkFaceid(Mineid,WorkfacName);
        if Gzmbh =-1  then  exit;
        if uDisposeData.InputFootage(IntToStr(Gzmbh),tDay,DownDayFootAge,
                  sumdownfootage,upperdayfootage,sumupperfootage,1) then
           Result:=true;
        uDisposeData.InputFootDataConn.Close;
    except
     on e:exception do begin
        MyMainFun.WriteLog('Eorr:Create Thread FALSE  '+e.Message,'[InputFootage]');
     end;
    end;
end;

function TMainForm.isActiveThread: Boolean;
var
  i:integer;
  FirstThread:Boolean;
begin
    Result:=true;
    FirstThread:=False;

//    for I := 0 to FthreadNumber - 1 do  begin
//        if IsExistFirstThread(i)  then  begin
//          MultThreadFirstProcess[i].Terminate ;
//          if PublicWriteLog then
//             MY_WriteLog(Get_MyModulePath,'IsExistFirstThread['+IntTostr(i)+']','[TServiceStop]');
//             FirstThread:=true;
//        end;
//    end;

    if FirstThread then  exit;

    if GetProcessThreadExist('FIRSTPROCESS') then exit;

    if GetProcessThreadExist('SECONDPROCESS') then exit;

    if GetProcessThreadExist('THIRDPROCESS') then exit;

    if GetProcessThreadExist('FOUTHPROCESS') then exit;

    if GetProcessThreadExist('APPOINTFOOTAGE') then exit;

    if uDisposeData.RealFootAgeBeginTrans >0 then exit;

    if uDisposeData.PressDataBeginTrans>0 then  exit;

    Result:=false;


end;

function TMainForm.IsServiceRunning: Boolean;
begin
     Result:=GetProcessThreadExist('STARTSERVICE');
end;



function TMainForm.IsValidObject(const Obj: TObject): Boolean;
begin
  try
    Result := PInteger(Integer(Obj.ClassType)+vmtSelfPtr)^ = Integer(Obj.ClassType);
  except
    Result := False;
  end;

end;

function TMainForm.RealTimeFootAge(MineName, WorkFacName: string;
  supportbh: Integer; Generatetime: TdateTime; RealDataValue: double): Wordbool;
var
  Gzmbh,Mineid:integer;
begin
   Result:=true;
   // ���ݳ�����ϴ
    if RealDataValue <50 then  exit;
   try
        Mineid:=uDisposeData.RealSelKuangjingId(MineName);
        Gzmbh:=uDisposeData.RealSelectWorkFaceid(Mineid,WorkfacName);
        if Gzmbh =-1  then  exit;
        if uDisposeData.RealFootageBeginTrans =0 then   begin
          uDisposeData.setGzmbm(IntToStr(Gzmbh));
          uDisposeData.RealFootage_Begintrans;
        end;
       uDisposeData.RealFootageTimer.Enabled :=true;
       //----------
        if not uDisposeData.SelectStokeData(IntToStr(Gzmbh)) then  begin  //������ݿ�������10������¼
           Result:=false;
           if not IsServiceRunning then
                 StartService; //�������û����������������
        end else begin
          if IntToStr(Gzmbh)<> uDisposeData.uDisPoseGzmBh then begin  //�������������
             uDisposeData.RealFootage_CommitTrans;
             uDisposeData.setGzmbm(IntToStr(Gzmbh));
             uDisposeData.RealFootage_Begintrans;
          end;
          uDisposeData.RealTimeFootAge(Gzmbh,supportbh,Generatetime,RealDataValue) ;

        end;
   except
        on e:exception do begin
           MyMainFun.WriteLog('Eorr: Create thread FALSE  '+e.Message,'[RealTimeFootAge]');
           Result:=false;
        end;
   end;

end;

function TMainForm.RefreshCoalPillar(CoalPillarInfo: string): string;
begin
      Result:=uExGzm.ReadCoalPliiarXml(CoalPillarInfo,'Refresh');
end;

function TMainForm.RefreshDrillInFo(DrillInfo: string): string;
begin
     Result:=uExGzm.ReadDrillInfo(DrillInfo,'Refresh');
end;

function TMainForm.RefreshFault(FaultInfo: string): string;
begin
     Result:=uExGzm.ReadFaultXml(FaultInfo,'Refresh');
end;

function TMainForm.RefreshMineOutArea(MineOutAreaInfo: string): string;
begin
    Result:=uExGzm.ReadMineOutAreaXml(MineOutAreaInfo,'Refresh');
end;

function TMainForm.RefreshSupport(SupportInfo: string): string;
begin
    Result:=uExGzm.ReadSupportInfo(SupportInfo,'Refresh');
end;

function TMainForm.RefreshWorkface(WorkfaceInfo: string): string;
var
  event:string;
  sr:String;
  gzmid,i:integer;
begin
    Sr:=uExGzm.ReadWorkFaceXml(WorkfaceInfo,'Refresh',event,gzmid);
    if( event='Insert') and (Sr='') and (gzmid >0) then  begin
       uExGzm.setGzmNumber(gzmid);
       if uExGzm.InputGzmData(gzmid) then   begin
             MainDataModule.CreateMySqlTable('2',inttostr(gzmid),'');
             for  I := uExGzm.SupStartNumber to   uExGzm.SupEndNumber  do  begin
                 MainDataModule.CreateMySqlTable('3',inttostr(gzmid),IntToStr(i));
             end;
       end else begin
           Result:='���ݳ�ʼ��ʧ��';
           exit;
       end;
    end;
    Result:=Sr;
end;

function TMainForm.RestoreWorkface(MineName,WorkfaceName ,FromFolder: string): string;
var
  Gzmbh,Mineid,i:integer;
begin
//    Result:='';
//    Mineid:=uExGzm.SelKuangjingBianHao(MineName);
//    Gzmbh:=uExGzm.IsExistWorkFace(Mineid,WorkfaceName);
//    uExGzm.setGzmNumber(Gzmbh);
//    if uExGzm.ReadData then   begin
//       uMyDataModule.CreateMySqlTable('2',inttostr(Gzmbh),'');
//       for I := uExGzm.SupStartNumber to   uExGzm.SupEndNumber  do
//           uMyDataModule.CreateMySqlTable('3',inttostr(Gzmbh),IntToStr(i));
//       //
//       Result:= uExGzm.RestoreWorkface (FromFolder) ;
//    end else begin
//      uExGzm.MakeGzmIsVail(0);
//    end;
end;

procedure TMainForm.SecondDisposeData;
begin
//     try
//         uDisposeData.SetSecondProcessStop(false);
//         hSecondThread:=TSecondThread.Create(uDisposeData,uMyDataModule.GetExDataType ) ;
//     finally
//         hSecondThread.Resume;
//     end;

end;

procedure TMainForm.ServiceOnDuty(TimeCount: Integer);
begin
  // ���� secondProcess ��������б���ֹͣ
//       if TimeCount mod 6000=0 then //10 ���ӷ���һ�μ���
//                if not  GetProcessThreadExist('SECONDPROCESS') then
//                        MyMainFun.SecondDisposeData;
//
//       if TimeCount mod 6000=0 then //10 ���ӷ���һ�μ���
//                if not  GetProcessThreadExist('APPOINTFOOTAGE') then
//                        MyMainFun.AppointFootage;
//
//       if TimeCount mod 6000=0 then //10 ���ӷ���һ�μ���
//                if not  GetProcessThreadExist('THIRDPROCESS') then
//                        MyMainFun.ThirdDisposeData;
//       if TimeCount mod 6000=0 then //10 ���ӷ���һ�μ���
//                if not  GetProcessThreadExist('FOUTHPROCESS') then
//                        MyMainFun.FourthDisposeData;
 ///////////////////////////////////////////////////////////////////////////////////////////////////
       if not  GetProcessThreadExist('SECONDPROCESS') and (TimeCount mod 3000< 5  )  then  begin
               SecondDisposeData ;  exit;
      end else if (TimeCount mod 3000>1500) and ( GetProcessThreadExist('SECONDPROCESS'))  then  begin
            uDisposeData.SetSecondProcessStop(true);
      end else if( GetProcessThreadExist('SECONDPROCESS')) then begin
           exit;
      end;

      if  (not  GetProcessThreadExist('APPOINTFOOTAGE')) and ( not  GetProcessThreadExist('SECONDPROCESS') )
            and ( TimeCount mod 3000 <1600   )      then  begin
                MyMainFun.AppointFootage ;  exit;
      end else if GetProcessThreadExist('APPOINTFOOTAGE') and (TimeCount mod 3000> 2000)   then  begin
                uDisposeData.SetAppointFootageStop(true);
      end else  if GetProcessThreadExist('APPOINTFOOTAGE')  then begin
              exit;
      end;
//
      //
//
      if  (not  GetProcessThreadExist('THIRDPROCESS')) and ( not  GetProcessThreadExist('APPOINTFOOTAGE'))
             and (not  GetProcessThreadExist('SECONDPROCESS'))  and( TimeCount mod 3000 < 2050)  then  begin
              MyMainFun.ThirdDisposeData ;  exit;
      end else if GetProcessThreadExist('THIRDPROCESS') and (TimeCount mod 3000>2500)     then  begin
             uDisposeData.SetThirdProcessStop(true);
      end else  if GetProcessThreadExist('THIRDPROCESS')  then begin
           exit;
      end;
      //
      if  (not  GetProcessThreadExist('FOUTHPROCESS')) and (not  GetProcessThreadExist('THIRDPROCESS'))
          and (not   GetProcessThreadExist('APPOINTFOOTAGE') )  and (not  GetProcessThreadExist('SECONDPROCESS'))
          and (TimeCount mod 3000 < 2550 )       then  begin
                MyMainFun.FourthDisposeData ;  exit;
      end else if GetProcessThreadExist('FOUTHPROCESS') and (TimeCount mod 3000> 2998)  then  begin
                uDisposeData.SetFourthProcessStop(true);
      end else  if GetProcessThreadExist('FOUTHPROCESS')  then begin
            exit;
      end;
end;

procedure TMainForm.SetJudgelegal(Value: Boolean);
begin
   judgelegal:=Value;
end;

procedure TMainForm.SetLicenseing(Value: Boolean;UName:string);
begin

    if Value then  begin
       public_Basic.licensing :=true;
       public_Basic.UseUnitName:=UName;
    end else begin
       public_Basic.licensing  :=False;
       public_Basic.UseUnitName:='ɽ���Ƽ���ѧ�����뼼���Ŷ�';
    end;

end;

procedure TMainForm.SetStatusCaption(Value: String);
begin
   Public_Basic.SetStatusCaption(Value);
end;

function TMainForm.SetSupportDataType(FirstType: integer;
  FirstDataTopLine: Double; SecondType: integer; SecondDataTopline: double;
  ThirdType: integer; ThirdDataTopLine: double; FouthType: integer;
  FourthDataTopLine: double): WordBool;
begin
    //
    Result:=False;
 try
    if uDisposeData.InsertAllWorkFaceTypeData(FirstType,FirstDataTopLine,SecondType,SecondDataTopline,
            ThirdType,ThirdDataTopLine,FouthType,FourthDataTopLine) then
         Result:=true;
 finally

 end;
end;

function TMainForm.SetSupportDataType_GZM(MineName, WorkFacName: string;StartTime:TdateTime;
  FirstType: integer; FirstDataTopLine: Double; SecondType: integer;
  SecondDataTopline: double; ThirdType: integer; ThirdDataTopLine: double;
  FouthType: integer; FourthDataTopLine: double): WordBool;
var
  MineId,Gzmid:integer;
begin
  Result:=False;
  try
     Mineid:=uDisposeData.SelKuangjingId(MineName);
     if Mineid<0 then  exit;
     Gzmid:=uDisposeData.SelectWorkFaceid(Mineid,WorkfacName);
     if Gzmid <0 then exit;
     if  uDisposeData.SplitWorkFaceDataType(Gzmid,FirstType,FirstDataTopLine,SecondType,SecondDataTopline,
            ThirdType,ThirdDataTopLine,FouthType,FourthDataTopLine,StartTime) then
         Result:=true;
  finally

  end;

end;

procedure TMainForm.StartService;
var
  ID: DWORD;
begin
    if not  judgelegal then  exit;
       hService := CreateThread(nil, 0, @inn_StartService, nil, 0, ID);
end;


procedure TMainForm.initFirstDisposeData;
var
   i:integer;
   DataSetGzm:TMyDataSet;
   DataCommand:TMyCommand;
   Sql,FGzmid:string;

begin
  try
   DataSetGzm:=TMyDataSet.Create(nil);
   DataSetGzm.MySqlConnection:=MainDataModule.ExConn;
   DataCommand:=TMyCommand.Create(nil);
   DataCommand.MySqlConnection:= MainDataModule.ExConn;

   uDisposeData.SetFirstProcessStop(true);

   //����߳�ռ�ñ��
   DataSetGzm.Close ;
   DataSetGzm.CommandText:='select cqid from cqcsb where qyzt=1';
   if DataSetGzm.Open then
       while not DataSetGzm.Eof  do  begin
          FGzmid:=Trim(IntToStr(DataSetGzm.FieldByName('cqid').AsInteger));
          DataCommand.CommandText :='update D_'+FGZMid+'_ProcessRecord  set used=0';
          DataCommand.Execute ;
          DataSetGzm.Next ;
       end;
   DataSetGzm.Close ;
   DataSetGzm.Free ;
   DataCommand.Free ;
  except
    on e:exception do begin
     writeLog('Eorr:initFirstDisposeData '+e.Message ,'[FirstDisposeData]');
    end;
  end;

end;




procedure TMainForm.StopService;
begin
   ServeiceStopState:=3;
   StopProcess;
end;


function TMainForm.TestDataBaseParameter(const Dtype, IP, User, Password,
  Path: WideString): WordBool;
var
   uPass:Boolean;
   Inn_Dtype:String;
begin
      Inn_Dtype:=UpperCase(Dtype);
      MainDataModule.SetExDataType(Inn_Dtype);
      MainDataModule.SetExDBaseInfo(Ip,User,Password);
     if (Inn_Dtype= 'SQLSERVER') or(Inn_Dtype= 'SQL SERVER') then  begin
         uPass:= MainDataModule.TestServer(Inn_Dtype) ;
     end else if (Inn_Dtype= 'MYSQL') or (Inn_Dtype= 'MY SQL') then  begin
         uPass:= MainDataModule.TestMySql(Inn_Dtype) ;
     end;

     if uPass then begin
        Result:=true;
     end else begin
        Result:=false;
     end;

end;

procedure TMainForm.ThirdDisposeData;
begin
//   if StepOrTime='Step'  then  begin
//          try
//           uDisposeData.SetThirdProcessStop(false);
//           hthirdThread:=TThirdThread.Create(uDisposeData,uMyDataModule.GetExDataType,'ThirdThread') ;
//          finally
//           hthirdThread.Resume;
//          end;
//   end else if StepOrTime='Time'  then begin
//          try
//           uDisposeData.SetThirdProcessStop(false);
//           Time_thirdThread:=TFourthThread.Create(uDisposeData,uMyDataModule.GetExDataType,'ThirdThread') ;
//          finally
//           Time_thirdThread.Resume;
//          end;
//   end;

end;



function TMainForm.WorkfaceSelectDrill(DrillsInfo: string): string;
begin
     Result:=uExGzm.ReadWorkFaceSelectDrill('',DrillsInfo);
end;

function TMainForm.WorkfaceSelectSupport(SupportsInfo: string): string;
begin
     Result:=uExGzm.ReadWorkFaceSelectsupport('',SupportsInfo);
end;

procedure TMainForm.WriteLog(const data:Ansistring; FFM : Ansistring='FFQ' );
var
  fileName,textString:Ansistring;
  DirName:Ansistring;
  hFile,logFile:integer;
begin
   DirName:=Get_DllPath+'\Err\'+FormatDateTime('yyyy-mm-dd',Now())+'\';
    if not DirectoryExists(DirName) then begin
       ForceDirectories(DirName);
    end;
   fileName:=Ansistring(FormatDateTime('yyyy-mm-dd',Now())) + FFM +'.txt';
   fileName:=DirName+fileName;
   if not(FileExists(fileName)) then begin
       hFile:=FileCreate(fileName,fmOutput);
       FileClose(hFile);
   end;
   logFile:=FileOpen(filename,fmOpenwrite or fmShareDenyWrite);
   FileSeek(logfile,0,2);
   textString:=formatdateTime('hh:mm:ss:zzz',Now())+'  ' +data + #13 +#10 ;
   fileWrite(logFile,Pchar(textString)^,length(textString));
   fileclose(logfile);

end;
// ȫ�ֵ��� ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure StopProcess;
 // 1Ϊϵͳ �����˳�����Ҫ����,2 Ϊ �ⲿ�����˳�
 var
   ss:string  ;
   ID:DWORD;
begin
 try
    Public_Basic.WriteIniProcess(now(),ServeiceStopState);
    uDisposeData.SetFirstProcessStop(true);

    while MyMainFun.isActiveThread do    begin
      if uDisposeData.RealFootAgeBeginTrans >0 then   begin
           uDisposeData.RealFootAge_CommitTrans;
           uDisposeData.RealFootageTimer.Enabled :=False;
      end;
      if uDisposeData.PressDataBeginTrans>0 then  begin
          uDisposeData.InputData_CommitTrans(ss) ;
          uDisposeData.InputTimer.Enabled :=False;
      end;

       uDisposeData.SetSecondProcessStop(true);
       uDisposeData.SetThirdProcessStop(true);
       uDisposeData.SetFourthProcessStop(true);
       uDisposeData.SetAppointFootageStop(true);
       Sleep(500);
    end;
    //
    if ServeiceStopState=1 then begin  //������ڲ���������� 5�������
      {���������������������Timer�ؼ� Ƶ���ͷ� ����ʱ����� �ռ䲻���ã�����ԭ��û�и����}
       //MyMainFun.FreeClass; // ���� ��
       Sleep(5000*4);
       //MyMainFun.CreateClass; //���´�����
        // ��������
       if PublicWriteLog then
          Public_Basic.MY_WriteLog('StartService_StopProcess','[TServiceStop]');
       MyMainFun.SetJudgelegal(true);
       MyMainFun.StartService;
       //hService := CreateThread(nil, 0, @inn_StartService, nil, 0, ID);
    end;
 except
     on e:exception do begin
        Public_Basic.MY_WriteLog('StopProcess:'+e.Message,'[TServiceStop]');
     end;

 end;

end;

// ��ʼ��
initialization  {��Ԫ��ʼ������}
  //�����ٽ���

   initializecriticalsection(FsyncWriteIni);
   initializecriticalsection(FsyncWritelog);

finalization    {��Ԫ�˳�ʱ�Ĵ���}
    //ɾ���ٽ���

    DeleteCriticalSection(FsyncWriteIni);
    DeleteCriticalSection(FsyncWritelog);

end.