unit UICallPstope;

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//<<      �ļ�����UICallPstope.pas                          <<
//<<      luleiʹ�õĸ���Delphi�ļ�                            <<
//<<      ���ļ���PstopeDll.dll delphi  �����ļ�           <<
//<<      ���ļ��� dll�ļ�һͬ������dll����Ҫע��ʹ��          <<
//<<      �������ڣ�2018.1.10                                   <<
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

interface

uses  Classes;

type

   TDefine_CallPStope = class (TObject)
     protected

     public

          //�ⲿ����
         function TestOK(Str:Pansichar):Pansichar;  virtual;abstract;
         procedure SetStatuesCaption(Value:PansiChar);  virtual;abstract;
         procedure SetUsetInformation(UserID,UserName:Pansichar;Admin:Boolean); virtual;abstract;
         function CallPStope:Boolean;  virtual;abstract;
         procedure OpenFyyd(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer);virtual;abstract;
          procedure OpenZCYL(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer);virtual;abstract;
         procedure SetReCallPStope(Value:Boolean);virtual;abstract;
         procedure OpenDTFZ(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer);virtual;abstract;
         procedure SetDTFZ_JinChi(Value:Integer);virtual;abstract;
         procedure OpenEditPstope(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer);virtual;abstract;
         procedure GetReportSupport(AHandle:THandle);virtual;abstract;
         procedure GetReportYKlh(AHandle:THandle);virtual;abstract;

         function  SetFyyd_Bmp(AHandle:THandle):PansiChar;virtual;abstract;
         procedure OpenSupportWeigth(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer);virtual;abstract;
         procedure DispCalEavResult(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer);virtual;abstract;
         procedure OpenSupportSubject(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer);virtual;abstract;
        
        
         function  Get_Zcyl(const Version: Pansichar; JinChi: Double): Pansichar;virtual;abstract;
         function  VerFityUserName(Var DWName:Pansichar):Boolean;Virtual;abstract;
         procedure SendEmail(address,Password,UType:Pansichar);Virtual;abstract;
         //��ȡ����ڲ����ݵ�rtf�ļ�
         function  GetDrillWord:Pansichar;Virtual;abstract;
         // ��ȡͼƬ

         procedure GEtDTFZBMP(AHandle:THandle);Virtual;abstract;
          procedure GetZCYLBMP(AHandle:THandle);Virtual;abstract;
         function  Get_immediate_roof(Version:Pansichar): Pansichar;Virtual;abstract;
         function  Get_Old_roof(Version:Pansichar): Pansichar;   Virtual;abstract;
         function  Get_judge_KCJSTC:Pansichar;Virtual;abstract;
         //��������
          function GetWinFormIsExsit(WinName:Pansichar):Boolean;Virtual;abstract;
          procedure CloseActiveForm(FormStr:Pansichar); Virtual;abstract;


         //ϵͳ����
        constructor Create; virtual;abstract;
   end;

   TClassStateMent_CallPStope = class of TDefine_CallPStope;

implementation

end.