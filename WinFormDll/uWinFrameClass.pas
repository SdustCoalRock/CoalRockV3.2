
unit uWinFrameClass;

interface

uses   ActiveX, Mtsobj, Mtx, ComObj, StdVcl,SysUtils, StrUtils,
       Windows,Messages,math,Classes,UIWinFrame,Vcl.Dialogs,
       DataService,Vcl.ExtCtrls;

type
   TWinFrameBasicClass = class (TDefine_WinFrame)
     private
          Create_Public_Basic,Create_Public_Modul:Boolean; // 是否创建了全局的数据模块
          MY_DataService:TDataService;
          function FreeOpenFrom:WordBool; safecall;
          function CreateDataModule:Boolean;

     protected
           //createWindows
           function CreateZkBasic(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer):THandle; override;
           function CreateSupport(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer):THandle; override;
           function CreateZkDetail(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer):THandle; override;
           function CreateGzmLinkZk(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer):THandle; override;
           function CreateCoalName(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer):THandle; override;
           function CreateWorkFace(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer):THandle; override;
           function CreateGZMFileName(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer):THandle; override;
           function CreatePressBmp(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer):THandle;  override;

           function CreateCADImage(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer):THandle; override;
           function CreateUserinfo(AHandle:THandle;Caption,Name:Pansichar;Width,Heigth:integer):THandle; override;
           procedure CreateUserAdmin(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer); override;
           function CreateConfiDataBase(AHandle:THandle;Caption:Pansichar;Width,Heigth,config:integer):THandle; override;
           procedure CreateBmpToSqlite(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer); override;
           procedure CreateSelectedWorkFaceINFo(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer); override;
           function CreatYklh_Form(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer):THandle; override;
           function ShowMapForm(AHandle:THandle;Caption:Pansichar;Width,Heigth,single:integer):THandle; override;
           function CreateOpenWordFrom(AHandle:THandle;Caption:Pansichar;Width,Heigth,single:integer):THandle; override;

           procedure SetMapAllMarker;override;
           procedure SetMapDispScal(Value:integer);override;
           //
           procedure SetUsetInformation(UserID,UserName:Pansichar;Admin:Boolean);  override;

           function  ConnectDataBase(DataType,DataBaseName,MySQLAddress : Pansichar; MySQLPort : Integer;
                          UserName : Pansichar; Password : Pansichar) : WordBool; override;
           function  RecallConnectDataBase:Boolean; override;
           //数据服务
           function ReturnUserList(DataType:integer):Pansichar;override;
           function UserPasswordVifty(User_Id, Password: Pansichar): Boolean;override;
           function GetWinFormIsExsit(WinName:Pansichar):Boolean;override;
           procedure CloseActiveForm(FormStr:Pansichar); override;
           function GetMainFormVersion(const Version:integer;var BmpFile:Pansichar):Pansichar; override;
           function GetImageFromDataBase(tableName,Imagefield,FileField,idName:Pansichar;idValue:integer):Pansichar; override;
           function GetMeiKuangInFormation:Pansichar; override;  //
           function GetWorkFaceDataType(workFaceid:integer):integer; override; //获得工作面数据类型
           function GEtWorkFaceBhList(Mkid:integer):Pansichar;override;   //获得工作面信息列表
           function verificationGzmLinkZk(Gzmid,Zkid:integer):Boolean; override;// 验证选中的工作面与钻孔是否配对
           procedure GetMinAndMaxJinDao(MinD,MaxD:integer); override;
          //
           function FreeWindows(Str: Pansichar):Boolean; override;
           procedure SetStatuesCaption(Value:PansiChar); override;
          //系统函数
           constructor Create; override;
           destructor Destroy; override;
   end; // end TRockPressure

var   //公共变量
        dllPath :string;

implementation

{ TRockPressure }

uses  UncoalName, UnEditGzk,  UnZkBasic, UnZkGzmLink, UnDetail,
  RockPressBasicClass, UnEditZJ, CADImage, UMainDataModule, UUserIfo, UUserManager,
  UnselectGZM,  UBMPToDataBase, Lu_Public_BasicModual,
  UdataBaseManager, uFormYKlhCslu, UFormEditWordFile, UGuidMap, UOpenWordFile;


procedure TWinFrameBasicClass.CloseActiveForm(FormStr:Pansichar);
Var
  WinStr:String;
begin
  inherited;
   WinStr:=UpperCase(StrPas(FormStr));
   if WinStr='USERINFO' then  begin
      if Assigned(User_Manager) then User_Manager.Close ;
   end else if WinStr='CONFIGDATABASE' then begin
      if Assigned(FormDataManager) then  FormDataManager.Close ;
   end else if WinStr='CALLMECHANICALMODEL' then  begin
      if Assigned(selectGZM) then  selectGZM.Close ;
   end else if WinStr='WORKFACEINFO' then  begin
      if Assigned(innGzmForm) then innGzmForm.Close ;
   end else if WinStr='DRILLDETAILINFO' then begin
      if Assigned(ZkDetail_inn) then  ZkDetail_inn.Close ;
   end else  if WinStr='OPENWORD' then  begin //'OPENWORD'
      if Assigned(FromOpenFile) then  FromOpenFile.Close ;

   end else if WinStr='ALL' then begin
       if Assigned(selectGZM) then  selectGZM.Close;
       if Assigned(ZkBasicForm) then  FreeAndNil(ZkBasicForm);
       if Assigned(innCoalName) then  FreeAndNil(innCoalName);
       if Assigned(Form_MapMain) then  Form_MapMain.Close ;
       if Assigned(innGzmForm) then FreeAndNil(innGzmForm);
       if  Assigned(ZkDetail_inn) then  FreeAndNil(ZkDetail_inn);
       if Assigned(FromOpenFile) then  FromOpenFile.Close ;
   end;






  
end;

function TWinFrameBasicClass.ConnectDataBase(DataType,DataBaseName,MySQLAddress: Pansichar;
  MySQLPort: Integer; UserName, Password: Pansichar): WordBool;
    {
      Note：  连接主数据库
   }
var
    Snapip,SnapPort:String;
    snapData,RetResult:Boolean;
    IPAdd,User,PassW,DataBase,sDaTaType:String;
begin
    Result:=FALSE;
    IPAdd:=StrPas(MySQLAddress);
    User:=StrPas(UserName);
    PassW:=StrPas(Password);
    sDAtaType:=StrPas(DataType);
    DataBase:=StrPas(DataBaseNAme);
    //把数值放入记录中
    MainDataModule.SaveDataInotRecord( IPAdd,
                                       User,
                                       PassW,
                                       IntToStr(MySQLPort),
                                       DataBase );
   snapData:=Public_Basic.ReadSnapData(Snapip,SnapPort);
   if snapData then   begin
      RetResult:=MainDataModule.SetSystemSnapDataBase(sDAtaType,DataBase,Snapip,true,SnapPort);
      if not RetResult then
         RetResult:=MainDataModule.SetSystemSnapDataBase(sDAtaType,DataBase,IPAdd,False,'0');
   end else begin
      RetResult:=MainDataModule.SetSystemSnapDataBase(sDAtaType,DataBase,IPAdd,False,'0');
   end;

   Result:=RetResult;
end;

constructor TWinFrameBasicClass.Create;
begin
  inherited;
  Create_Public_Basic:=False;
  Create_Public_Modul:=False;
  CreateDataModule;

end;

procedure TWinFrameBasicClass.CreateBmpToSqlite(AHandle: THandle;
  Caption: Pansichar;Width,Heigth:integer);
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);
   CreateBmpIntoDataBase(AHandle,SOut,Width,Heigth);
end;

function TWinFrameBasicClass.CreateCADImage(AHandle: THandle;
                    Caption: Pansichar;Width,Heigth:integer):THandle;
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);
   Result:=CreateCADImage_Inn(AHandle,SOut,Width,Heigth);
end;

function TWinFrameBasicClass.CreateCoalName(AHandle: THandle; Caption: Pansichar;
          Width,Heigth:integer):THandle;
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);
    Result:=CreatecoalName_inn(AHandle,Sout,Width,Heigth) ;
end;

function TWinFrameBasicClass.CreateConfiDataBase(AHandle: THandle;
  Caption: Pansichar;Width,Heigth,config:integer):THandle;
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);
   Result:= CreateDataBase_Manager(AHandle,Sout,Width,Heigth,config) ;
end;

function TWinFrameBasicClass.CreateDataModule: Boolean;
begin

   if not  Assigned(Public_Basic) then  begin
      Public_Basic:=TLu_BasicClass.Create('','serverinfo.dll');
       Create_Public_Basic:=true;
   end;

   if not Assigned(MainDataModule) then begin
      MainDataModule:=TDataModule1.Create(nil);
      Create_Public_Modul:=true;
      MainDataModule.ExMainPath:=Public_Basic.Get_MyModulePath;
   end;
  
   if not Assigned(My_DataService) then
      MY_DataService:=TDataService.Create ;

end;

function TWinFrameBasicClass.CreateGzmLinkZk(AHandle: THandle;
               Caption: Pansichar;Width,Heigth:integer):THandle;
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);
   Result:=CreateBgz_inn(AHandle,Sout,Width,Heigth);
end;

function TWinFrameBasicClass.CreateOpenWordFrom(AHandle: THandle;
  Caption: Pansichar; Width, Heigth, single: integer): THandle;
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);
   Result:=CreateOpenWord(AHandle,Sout,Width,Heigth,single);
end;

function TWinFrameBasicClass.CreatePressBmp(AHandle: THandle;
           Caption: Pansichar;Width,Heigth,Flag:integer):THandle;
var
  SOut:String;
begin
  inherited;
//   SOut:=strPas(Caption);
//
//   Result:=CreateDraw_Pressure(AHandle,Sout,Width,Heigth,Flag);

end;

procedure TWinFrameBasicClass.CreateSelectedWorkFaceINFo(AHandle: THandle;
  Caption: Pansichar;Width,Heigth,Flag:integer);
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);
   CreateSelectGzmZkzinfo(AHandle,Sout,Width,Heigth,Flag);

end;

function TWinFrameBasicClass.CreateSupport(AHandle: THandle; Caption: Pansichar;
             Width,Heigth:integer):THandle;
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);
   Result:=CreateZj_inn(AHandle,Sout,Width,Heigth);
end;

procedure TWinFrameBasicClass.CreateUserAdmin(AHandle: THandle;
  Caption: Pansichar;Width,Heigth:integer);
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);
   CreateUserManager(AHandle,Sout,Width,Heigth) ;
end;

function TWinFrameBasicClass.CreateUserinfo(AHandle: THandle; Caption,
  Name: Pansichar;Width,Heigth:integer):THandle;
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);
   Result:=CreateUserInfo_inn(AHandle,Sout,strPas(Name),Width,Heigth) ;
end;

function TWinFrameBasicClass.CreateWorkFace(AHandle:THandle;
             Caption: Pansichar;Width,Heigth:integer):THandle;
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);
   Result:=CreateGzm_inn(AHandle,Sout,Width,Heigth);
end;

function TWinFrameBasicClass.CreateGzmFileName(AHandle: THandle;
  Caption: Pansichar; Width, Heigth: integer): THandle;
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);
   Result:=CreateWorkFaceFileName(AHandle,Sout,Width,Heigth);

end;

function TWinFrameBasicClass.CreateZkBasic(AHandle: THandle;
     Caption: Pansichar;Width,Heigth:integer):THandle;
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);
   Result:=CreateZk_inn(AHandle,Sout,Width,Heigth);
end;

function TWinFrameBasicClass.CreateZkDetail(AHandle: THandle;
      Caption: Pansichar;Width,Heigth:integer):THandle;
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);
   Result:=CreateDrillDetail_inn(AHandle,Sout,Width,Heigth);
end;

function TWinFrameBasicClass.CreatYklh_Form(AHandle: THandle;
  Caption: Pansichar; Width, Heigth: integer):THandle;
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);
   Result:=CreateYklhForm(AHandle,Sout,Width,Heigth);
end;

destructor TWinFrameBasicClass.Destroy;
begin
  FreeOpenFrom;
  // 涉及到全局变量的释放
  
   if  Create_Public_Modul then
      if Assigned(MainDataModule) then   FreeAndNil(MainDataModule);

   if Create_Public_Basic then
       if Assigned(Public_Basic) then   FreeAndNil(Public_Basic);

  inherited;
end;

function TWinFrameBasicClass.FreeOpenFrom: WordBool;
{
  局部变量的释放
}
begin
    Result:=false;
    try
      if Assigned(innCoalName)   then    FreeAndNil(innCoalName);
      if Assigned(innGzmForm)    then    FreeAndNil(innGzmForm);
      if Assigned(ZkBasicForm)   then    FreeAndNil(ZkBasicForm);
      if Assigned(ZkDetail_inn)  then    FreeAndNil(ZkDetail_inn);
      if Assigned(ZkGzmLink)     then    FreeAndNil(ZkGzmLink);
      if Assigned(ZkZJ_inn)      then    FreeAndNil(ZkZJ_inn);
      if Assigned(MY_DataService) then   FreeAndNil(MY_DataService);
    except
        exit;
    end;
    Result:=true;
end;



function TWinFrameBasicClass.FreeWindows(Str: Pansichar): Boolean;
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Str);
   if (SOut='UserINFoDisPlay') and   (assigned(User_Manager)) then
      FreeAndNil(User_Manager);

end;

function TWinFrameBasicClass.GetImageFromDataBase(tableName, Imagefield,
  FileField, idName: Pansichar; idValue: integer): Pansichar;
var
  ipath:string;
  Myimage:TImage;
begin
    ipath:=public_Basic.Get_MyModulePath +'SaveBmp\FYYD\CoalBmp.JPG';
    Result:='';
    Myimage:=TImage.Create(nil);
    try
        if MY_DataService.GetImageFromDataBase(strPas(tableName),strPas(Imagefield), strPas(FileField),
                            strPas(idName),idValue,Myimage.Picture.Bitmap) then  begin
           Myimage.Picture.SaveToFile(iPath) ;
           Result:=PansiChar(AnsiString(ipath));
        end;
    finally
       FreeAndNil(Myimage);
    end;

end;

function TWinFrameBasicClass.GetMainFormVersion(const Version: integer;
  var BmpFile: Pansichar): Pansichar;
begin
   Result:=MY_DAtaService.GetMainFormVersion(Version,BmpFile);
end;

function TWinFrameBasicClass.GetMeiKuangInFormation: Pansichar;
begin
    Result:=MY_DAtaService.GetMeiKuangInformation;
end;

procedure TWinFrameBasicClass.GetMinAndMaxJinDao(MinD, MaxD: integer);
begin
  inherited;
  if Assigned(FromOpenFile) then begin
     FromOpenFile.ExMinDao:=MinD;
     FromOpenFile.ExMaxDao:=MaxD;
  end;
end;

function TWinFrameBasicClass.GetWinFormIsExsit(WinName: Pansichar): Boolean;
Var
  WinStr:String;
begin
   Result:=False;
   WinStr:=UpperCase(StrPas(WinName));
   if WinStr='USERINFO' then
      if Assigned(User_Manager) then  Result:=true;
   if WinStr='CONFIGDATABASE' then
      if Assigned(FormDataManager) then  Result:=true;
   if WinStr='CALLMECHANICALMODEL' then  //'CallMechanicalModel'
      if Assigned(selectGZM) then  Result:=true;
   if WinStr='WORKFACEINFO' then  //'WorkFaceInfo'
      if Assigned(innGzmForm) then  Result:=true;
   if WinStr='DRILLDETAILINFO' then  //'DrillDetailInfo'
      if Assigned(ZkDetail_inn) then  Result:=true;
   if WinStr='OPENWORD' then  //'OPENWORD'
      if Assigned(FromOpenFile) then  Result:=true;
    if WinStr='ZKBASIC' then  //'ZkBasicForm'
      if Assigned(ZkBasicForm) then  Result:=true;
end;

function TWinFrameBasicClass.GEtWorkFaceBhList(Mkid: integer): Pansichar;
Var
  SOut:WideString;
begin
    SOut:=MY_DataService.GetWorkFaceBhList(Mkid);
    Result:=PansiChar(AnsiString(SOut));

end;

function TWinFrameBasicClass.GetWorkFaceDataType(workFaceid:integer): integer;
begin
   Result:=MY_DataService.GetWorkFaceDataType(workFaceid);
end;

function TWinFrameBasicClass.RecallConnectDataBase: Boolean;
begin
   Result:=MainDataModule.ConnectSystemDataBase;
end;

function TWinFrameBasicClass.ReturnUserList(DataType: integer): Pansichar;
Var
  SOut:WideString;
begin
    SOut:=MY_DataService.GetUserNameList(IntToStr(DataType));
    Result:=PansiChar(AnsiString(SOut));
end;



procedure TWinFrameBasicClass.SetMapAllMarker;
begin
  inherited;
  if Assigned(Form_MapMain) then  begin
     Form_MapMain.ExAddmarker;
  end;

end;

procedure TWinFrameBasicClass.SetMapDispScal(Value: integer);
begin
  inherited;
  if Assigned(Form_MapMain) then  begin
     Form_MapMain.SetMapDisplayScale(Value);
  end;
end;

procedure TWinFrameBasicClass.SetStatuesCaption(Value: PansiChar);
begin
  inherited;
    Public_Basic.SetStatusCaption(StrPas(Value));
end;

procedure TWinFrameBasicClass.SetUsetInformation(UserID, UserName: Pansichar;Admin:Boolean);
begin
  inherited;
      MainDataModule.ExUserName :=strPas(UserName);
      MainDataModule.ExUserID:=StrPas(UserID);
      MainDataModule.ExAdminBool:=Admin;
end;


function TWinFrameBasicClass.ShowMapForm(AHandle: THandle; Caption: Pansichar;
  Width, Heigth, single: integer): THandle;
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);
   Result:=CreateMapFrom(AHandle,Sout,Width,Heigth,single);
end;

function TWinFrameBasicClass.UserPasswordVifty(User_Id,
  Password: Pansichar): Boolean;
begin
    Result:=MY_DAtaService.UserPasswordVifty(strPas(User_id),strPas(Password));
end;

function TWinFrameBasicClass.verificationGzmLinkZk(Gzmid,
  Zkid: integer): Boolean;
begin
   Result:=False;
   if Gzmid <=0 then   exit;
   if Zkid <=0 then    exit;

   Result:= MY_DAtaService.GzmAndZkIsEffective(intTostr(Gzmid),intTostr(Zkid)) ;
end;

//// 初始化
//initialization  {单元初始化代码}
//  //创建临界区
//   initializecriticalsection(FsyncSQL);
//   MySQLTableNameList:=TStringlist.Create;
//
//finalization    {单元退出时的代码}
//    //删除临界区
//    DeleteCriticalSection(FsyncSQL);
//    FreeAndNil(MySQLTableNameList);

end.

