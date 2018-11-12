﻿//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//<<      文件名：Call_PStope.pas
//<<      卢国志使用的个人Delphi文件                            <<
//<<      该文件主要实现对DLLPStope的调用                  <<
//<<      创建日期：2018.1.12                                   <<
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
unit MainCallUnit ;

interface
uses
  Winapi.Windows, SysUtils, Classes, Messages, Controls, Forms, StdCtrls, ExtCtrls,
  ComCtrls ,math,Grids,WordXP,COMobj,StrUtils,Vcl.Dialogs, Activex
  , UIPStopeGuidUnit, PStope_GzmGuidClass,ReportWord,
   IdIPWatch, IdMessage, IdTCPConnection, IdTCPClient,
   IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP
  ;
Type
  pRYklh =^TYklh;
  TYklh=packed record
     tCoalprice:double;  //   吨煤单价
     YLmzwid:double;      //  预留煤柱宽度
     CtWallPrice:double;// 墙体成本
     CtwallH:double;     // 充填墙体高度
     YLHangDaoWid:double;// 预留巷道宽度
     HangDaoCtWid:double;//充填体预设宽度

     NormalSpeed:double; // 不沿空留巷推进速度
     NormalMzwid:double;  // 不沿空留巷煤柱宽度
     YklhSpeed:double;  // 沿空留巷后推进速度
     HangDaoWeiHuprice:double;   // 巷道维护价格
     CoalHangJueJinPrice:double; // 煤巷掘进价格
     ZongHePrice:double;     // 采煤综合成本
     CTWallBehindJuli:double;   //充填体滞后距离
  end;
  TMainCallPStope =Class
    private
       CreateSuccess:Boolean;
       FGzm:TGzm;
       Report:TWordReport;
       inFootage:Double;
       pYklh:pRYklh;
       Create_Public:Boolean;//是否创建了全局变量

       procedure SetFootage(Value:Double);
       function GetFootage:Double;
       procedure FrillYklh_Record;
        function inGetComputerName:string;
        function GetComputerIP(name:string):string;
        function GetIPAddrss:string;
    protected
       property Footage:double read GetFootage write SetFootage;
    public

      UsePStope:TDefine_PstopeGuid;
      //使用函数
      function  InitPStope:Boolean;
      function  CreateClass:Boolean;
      function  GetCreateSuccess:Boolean;
      procedure ReportSupportInfo(AHandle:THandle);
      procedure ReportYklhInfo(AHandle:THandle);
      procedure SetSupportWeightFillData;
      procedure RecallSupportSubject;
      function  Return_Yklh_SupportParam(Version:string):widestring;
      function  Return_Yklh_HangDao_Zhihu_Support(Version:string):widestring;
      function  Return_Yklh_Jinjixiaoyi(Version:string):widestring;
      procedure SendEmail(address,Password,UType:string);
      function  GetDrillWordRtf:widestring;
      function  Return_WorkFace_kcjstj:widestring;

      //系统函数
      constructor Create;
      destructor  Destroy;
  End;

 Var
  Main_CallPStope: TMainCallPStope;

implementation



uses UMainDataModule, Lu_Public_BasicModual, SupportWeightClass, VMProtectSDK;

{引用  'LibPStope.dll'， 为 LibPstope:UsePStope 服务}

function TPstopeGuid:TClassStateMent_PStopeGuid; external 'LibPStope.dll' ;


{ TCallPStope }

constructor TMainCallPStope.Create;
begin
    Create_Public:=False;
    {'LibPStope.dll'的外部类}
    CreateSuccess:=CreateClass;
    new(pYklh);

end;

function TMainCallPStope.CreateClass: Boolean;
begin
    Result:=true;
    try
      if not Assigned(UsePStope) then
          UsePStope:=TPstopeGuid.Create ;
      if not Assigned(FGzm) then
          FGzm:=TGzm.Create(MainDataModule.ExConn);
      if not Assigned(Report) then
          Report:=TWordReport.Create ;
      if not Assigned(t_SupWeigth) then    begin
          t_SupWeigth:=TSupportWeight.Create ;
      end;
      if not Assigned(t_supSubject) then
         t_supSubject:= TWorkFace_Subject.Create ;

    except
       Result:=False;
    end;

end;

destructor TMainCallPStope.Destroy;
begin
     if Assigned(UsePStope) then     FreeAndNil(UsePStope);
     if Assigned(FGzm)    then      FreeAndNil(FGzm);
     if Assigned(Report)  then     FreeAndNil(Report);
     if Assigned(t_supSubject) then  FreeAndNil(t_supSubject);
     if Assigned(t_SupWeigth) then  FreeAndNil(t_SupWeigth);
     // 为什么没有释放 数据模块 就是因为 动态库中的 数据模块是全局 不需要重复创建
     dispose(pYklh);

end;

procedure TMainCallPStope.FrillYklh_Record;
begin
        MainDataModule.MyDataSet.Close();
        MainDataModule.MyDataSet.CommandText:='select * from YKLH_benefits where gzmid='+MainDataModule.WorkFace_id ;
       try
        if (MainDataModule.MyDataSet.Open) and (MainDataModule.MyDataSet.RecordCount>0 )  then begin
            pYklh.TCoalprice:= MainDataModule.MyDataSet.FieldByName('TCoalprice').AsFloat;  //   吨煤单价
            pYklh.CtWallPrice:=MainDataModule.MyDataSet.FieldByName('CtWallPrice').AsFloat; // 墙体成本
            pYklh.CtwallH:=  MainDataModule.MyDataSet.FieldByName('CtwallH').AsFloat;         // 充填墙体高度
            pYklh.YLHangDaoWid:= MainDataModule.MyDataSet.FieldByName('YLHangDaoWid').AsFloat;// 预留巷道宽度
            pYklh.HangDaoCtWid :=  MainDataModule.MyDataSet.FieldByName('HangDaoCtWid').AsFloat;//充填体预设宽度

            pYklh.NormalSpeed:= MainDataModule.MyDataSet.FieldByName('NormalSpeed').AsFloat; // 不沿空留巷推进速度
            pYklh.NormalMzwid:=  MainDataModule.MyDataSet.FieldByName('NormalMzwid').AsFloat;  // 不沿空留巷煤柱宽度
            pYklh.YklhSpeed:= MainDataModule.MyDataSet.FieldByName('YklhSpeed').AsFloat;   // 沿空留巷后推进速度
            pYklh.HangDaoWeiHuprice:= MainDataModule.MyDataSet.FieldByName('HangDaoWeiHuprice').AsFloat;   // 巷道维护价格
            pYklh.CoalHangJueJinPrice:= MainDataModule.MyDataSet.FieldByName('CoalHangJueJinPrice').AsFloat;  // 煤巷掘进价格
            pYklh.ZongHePrice:=  MainDataModule.MyDataSet.FieldByName('ZongHePrice').AsFloat;      // 采煤综合成本
            pYklh.CTWallBehindJuli:= MainDataModule.MyDataSet.FieldByName('CTWallBehindJuli').AsFloat;    //充填体滞后距离

        end;
       finally
           MainDataModule.MyDataSet.Close();
       end;

end;

function TMainCallPStope.GetComputerIP(name: string): string;
var
  IdIPWatch1:TIdIPWatch;
begin
    IdIPWatch1:=TIdIPWatch.Create();
    result:=IdIPWatch1.LocalIP;
    FreeAndNil(IdIPWatch1);
end;

function TMainCallPStope.GetCreateSuccess: Boolean;
begin
     Result:=CreateSuccess;
end;

function TMainCallPStope.GetDrillWordRtf: widestring;
begin
   Result:=widestring(Report.ReportDrillInfoToWordFile(FGzm) );
end;

function TMainCallPStope.GetFootage: Double;
begin
    Result:=inFootage;
end;

function TMainCallPStope.GetIPAddrss: string;
var
   xml : OleVariant;
   r:string;
   p1,p2 : Integer;
begin
   CoInitialize(nil);
   try
       xml := CreateOleObject('Microsoft.XMLHTTP');
       xml.Open('GET','http://www.net.cn/static/customercare/yourIP.asp', False);
    //   xml.Open('GET','http://www.china.com', False);
       xml.Send;
       r := xml.responseText;
       p1:=Pos('<h2>',r); // 找到 h2 标签
       p2:=Pos('</h2>',r);   // 找到 h2 结束标签
       Result := Copy(r, p1+4, p2-p1-4);
   finally
     CoUnInitialize;
   end;

end;

function TMainCallPStope.inGetComputerName: string;
var
    ComputerName: array[0..MAX_COMPUTERNAME_LENGTH+1] of char;
    Size: Cardinal;
begin
    result:='';
    Size := MAX_COMPUTERNAME_LENGTH+1;
    GetComputerName(ComputerName, Size);
    Result:=StrPas(ComputerName);

end;

function TMainCallPStope.InitPStope: Boolean;
Var
  Gzm_simple,Gzm_Difficult,Zk_Str:String;
  ZhiJia:string;
begin
    Result :=False;
    MainDataModule.ReadPublicUsedMkInfoFromFile;
    FGzm.setGzmNumber(Public_Basic.StrToInt_lu(MainDataModule.WorkFace_id));
    if not FGzm.ReadData then begin
        Public_Basic.MY_WriteLog('ReadData is Eorr!','[TCallPStope]') ;
        exit;
    end;
    //获得工作面录入进尺
    if Fgzm.S_Jc_L <Fgzm.S_L_qx  then Footage:= Fgzm.S_L_qx ;
    if not Fgzm.RefreshFootage(Footage)  then begin
       Public_Basic.MY_WriteLog('RefreshFootage is Eorr!','[TCallPStope]') ;
       exit;
    end;

    // GetGzmZkStr
    if not FGzm.GetGzmZkStr(Gzm_simple,Gzm_Difficult,Zk_Str)  then begin
       Public_Basic.MY_WriteLog('GetGzmZkStr is Eorr!','[TCallPStope]') ;
       exit;
    end;
    //GetzhijiaStr
    if not FGzm.GetSupportStr(ZhiJia)  then begin
       Public_Basic.MY_WriteLog('No Bulling Support Information!','[TCallPStope]') ;
       ZhiJia:='ZJ:综采,ZY13000/25/50,1.75,5,2.6,2,2.5,13000,1.46,2,.5,';
    end;

    if not UsePStope.init_model (PansiChar(AnsiString(Gzm_Difficult))
                   ,PansiChar(AnsiString(Zk_Str)),PansiChar(AnsiString(ZhiJia))) then begin
       Public_Basic.MY_WriteLog('LibPStope init_model is Eorr!','[TCallPStope]') ;
       exit;
    end;

    Result:=True;
end;



procedure TMainCallPStope.RecallSupportSubject;
var
   kcjscj:String;
begin
    kcjscj:=strpas(Main_CallPStope.UsePStope.Get_kcjstj('1.0'));
    t_SupSubject.WithoutOptionMakeResult(kcjscj);
end;

procedure TMainCallPStope.ReportSupportInfo(AHandle:THandle);
begin
     Report.ReportZhijia(AHandle,Fgzm);
end;

procedure TMainCallPStope.ReportYklhInfo(AHandle: THandle);
begin
    Report.ReportYklh(AHandle,Fgzm);
end;

function TMainCallPStope.Return_WorkFace_kcjstj: widestring;
var
 i,selectedid:integer;
 s_Out:string;
begin
    s_Out:='';
    for I := 0 to 7 do  begin
        selectedid:= t_SupWeigth.WorkFaceInfo.Child_Second[i].selected ;
         s_Out:=s_Out+t_SupWeigth.WorkFaceInfo.Child_Second[i].Child_Third[selectedid].Name +';';
    end;
    Result:= s_Out;
end;

function TMainCallPStope.Return_Yklh_HangDao_Zhihu_Support(
  Version: string): widestring;
begin
   Result:=StrPas(UsePStope.Get_yklh_fzzh(PansiChar(Ansistring(Version))));
end;


function TMainCallPStope.Return_Yklh_Jinjixiaoyi(Version: string): widestring;
{
     1 M_dj  煤的单价,   2  Mzhu_w  煤柱宽度,   3 T_cong_sj 充填成本
     4  N_Speed  不留巷推进速度 ,5   YK_Speed   留巷推进速度,
     6   HD_Wh_P  巷道维护成本, 7   HD_JN_P  巷道掘进成本, 8  Coal_ZH_P 采煤综合成本
}
begin
   Result:=StrPas(UsePStope.Get_yklh_JJxy(PansiChar(Ansistring(Version)),pYklh.tCoalprice,pYklh.YLmzwid ,
       pYklh.CtWallPrice,pYklh.NormalSpeed ,pYklh.YklhSpeed ,pYklh.HangDaoWeiHuprice,
       pYklh.CoalHangJueJinPrice ,pYklh.ZongHePrice   ));
end;

function TMainCallPStope.Return_Yklh_SupportParam(Version: string): widestring;
begin
   self.FrillYklh_Record;
   Result:=StrPas(UsePStope.Get_yklh_ctcs(PansiChar(Ansistring(Version)), pyklh.HangDaoCtWid,
                     pYklh.YLHangDaoWid,pYklh.CtwallH));
end;

procedure TMainCallPStope.SendEmail(address, Password,UType: string);
var
 str,sql,wherestr:string;
 i,j:integer;
 IdSMTP1:TIdSMTP;
 IdMessage1:TIdMessage;
begin
    IdSMTP1:=TIdSMTP.Create();
    IdMessage1:=TIdMessage.Create();

    try
      IdSMTP1.AuthType:=satDefault;
      IdSMTP1.Username:=address;   //服务器上的用户名 
      IdSMTP1.Password:=Password;  //服务器上的密码  
      IdSMTP1.Host:='smtp.163.com';//服务器SMTP地址  
      IdSMTP1.Port:=25; //服务器端口 
      IdSMTP1.Connect;
      str:='';
      //电脑信息
      str:=inGetComputerName+',';
      str:=str+GetComputerIP('')+',';
      str:=str+self.GetIPAddrss +';';
   except
      exit;
   end;


    str:=str+'_正在使用系统';
    IdMessage1.Clear ;
    IdMessage1.ContentType :='text';
    IdMessage1.Encoding:=mePlainText;// meMIME;
    IdMessage1.CharSet:='gb2312';
   // IdMessage1.Subject:=FormatDatetime('yyyy-mm-dd hh:nn:ss',now);
    IdMessage1.Subject:='来自:'+inGetComputerName+'['+UType+']信件';
    IdMessage1.Recipients.EMailAddresses:=address;
    IdMessage1.Body.Add(str);
    if length(str)< 10 then  begin
      IdSMTP1.Disconnect();
      exit;
    end;

    IdMessage1.From.address   := address;
    IdMessage1.Priority   :=   mphigh;
   try
    VMProtectBegin('RockPress');
        IdSMTP1.Authenticate;
        IdSMTP1.Send(IdMessage1);
    VMProtectEnd;
        IdSMTP1.Disconnect();
   finally
//     sql:='update studentinfo set sended =1 where id in ( '  ;
//     wherestr:='';
//     for I := 2 to self.StringGrid1.RowCount-1 do begin
//         if   StringGrid1.Cells[0,i]='0' then
//             wherestr:=wherestr+StringGrid1.Cells[1,i]+',';
//     end;
//      wherestr:=Copy(wherestr,1,Length(wherestr)-1);
//     try
//      if length(wherestr)>0 then  begin
//         wherestr:=wherestr+')';
//         MainClass.Maindb.ExecSQL(sql+wherestr);
//      end;
//
//
//     end;
     FreeAndNil(IdSMTP1);
     FreeANdnil(IdMessage1);
   end;

end;

procedure TMainCallPStope.SetFootage(Value: Double);
begin
   inFootage:=Value;

end;

procedure TMainCallPStope.SetSupportWeightFillData;
var
   kcjscj:String;
begin
    kcjscj:=strpas(Main_CallPStope.UsePStope.Get_kcjstj('1.0'));
    t_SupWeigth.WithoutOptionMakeResult(kcjscj);
    t_SupSubject.WithoutOptionMakeResult(kcjscj);
end;

end.