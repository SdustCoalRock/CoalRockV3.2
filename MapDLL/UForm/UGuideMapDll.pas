unit UGuideMapDll;

interface

uses   ActiveX, Mtsobj, Mtx, ComObj, StdVcl,SysUtils, StrUtils,
       Windows,Messages,math,Classes,Vcl.Dialogs,
       UIGuideMapDll;

type
   TMapDLLBody = class (TDefine_MapDll)
        private
          Create_Public_Basic,Create_Public_Modul:Boolean;
          function  CreateClass:Boolean;
          procedure FreeCreatedClass;
       protected

           procedure OpenMapWindows(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer);override;
           procedure SetUsetInformation(UserID,UserName:Pansichar;Admin:Boolean);  override;
//
          //系统函数
           constructor Create; override;
           destructor Destroy; override;
   end; // end TMapDLLBody


implementation

{ TMapDLLBody }

uses UGudieMainForm, UMainDataModule, Lu_Public_BasicModual;

constructor TMapDLLBody.Create;
begin
  inherited;
  Create_Public_Basic:=False;
  Create_Public_Modul:=False;
  CreateClass;
end;

function TMapDLLBody.CreateClass: Boolean;
begin
   Result:=true;
    try

      if not Assigned(Public_Basic) then  begin
        Public_Basic:=TLu_BasicClass.Create('','ServerInfo.dll');
        Create_Public_Basic:=true;
      end;

       if not Assigned(MainDataModule )then    begin
          Create_Public_Modul:=true;
          MainDataModule:=TDataModule1.Create(nil) ;
          MainDataModule.ExMainPath :=Public_Basic.Get_MyModulePath ;
          if not MainDataModule.ConnectSystemDataBase then
              Result:=False;
      end;
    finally

    end;
end;

destructor TMapDLLBody.Destroy;
begin
     FreeCreatedClass;
     inherited;
end;

procedure TMapDLLBody.FreeCreatedClass;
{
  Create_Public:=true
   意思是 只有自己创建的才释放，不是自己创建的不用释放
   因为 全局的变量 只有一份
}
begin
   if Create_Public_Modul then
        if  Assigned(MainDataModule )then
         FreeAndNil(MainDataModule);

   if Create_Public_Basic then
       if  Assigned(Public_Basic) then
            FreeAndNil(Public_Basic);



end;

procedure TMapDLLBody.OpenMapWindows(AHandle: THandle; Caption: Pansichar;
  Width, Heigth: integer);
var
  SOut:String;
begin
  inherited;
   SOut:=strPas(Caption);
   CreateMapMianFrom(AHandle,Sout,Width,Heigth);
end;

procedure TMapDLLBody.SetUsetInformation(UserID, UserName: Pansichar;
  Admin: Boolean);
begin
  inherited;
    MainDataModule.ExUserName :=strPas(UserName);
    MainDataModule.ExUserID:=StrPas(UserID);
    MainDataModule.ExAdminBool:=Admin;
end;

end.
