unit UIPStopeGuidUnit;

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//<<      �ļ�����UIPStopeGuidUnit.pas                          <<
//<<      luleiʹ�õĸ���Delphi�ļ�                            <<
//<<      ���ļ���PstopeDll.dll delphi  �����ļ�           <<
//<<      ���ļ��� dll�ļ�һͬ������dll����Ҫע��ʹ��          <<
//<<      �������ڣ�2018.1.10                                   <<
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

interface

uses  Classes;

type

   TDefine_PstopeGuid = class (TObject)
     protected

     public

          //�ⲿ����
        function init_model(const Gzm, zk,Zhijia: Pansichar): Boolean; virtual;abstract;
        procedure OpenFyyd(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer);virtual;abstract;
        procedure GetFyydBmp(AHandle:THandle);virtual;abstract;
        procedure OpenDTFZ(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer);virtual;abstract;
        procedure OpenZCYL(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer);virtual;abstract;
        procedure GetZCYLBmp(AHandle:THandle);virtual;abstract;
        procedure SetDTFZ_JinChi(Value:integer);virtual;abstract;
        procedure GetDTFZBmp(AHandle:THandle);virtual;abstract;
        function  Get_immediate_roof(Version:Pansichar): Pansichar ;virtual;abstract;
        function  Get_Old_roof(Version:Pansichar): Pansichar ;virtual;abstract;
        function Get_kcjstj(const Version: Pansichar): Pansichar; virtual;abstract;
        function  Get_Support_P(Version:Pansichar): Pansichar ;virtual;abstract;
        procedure OpenEditPStopindows(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer);virtual;abstract;

        function  Get_yklh_ctcs(const Version: Pansichar; width, Hd_wideth, Hd_heigth: Single): Pansichar; virtual;abstract;
        function  Get_yklh_fzzh(const Version: Pansichar): Pansichar; virtual;abstract;
        function  Get_yklh_JJxy(const Version: Pansichar; M_dj, Mzhu_w, T_cong_sj,
                     N_Speed,YK_Speed,HD_Wh_P,HD_JN_P,Coal_ZH_P: Single): Pansichar;virtual;abstract;
        function  Get_Zcyl(const Version: Pansichar; JinChi: Double): Pansichar;virtual;abstract;
        function  VerFityUserName(Var DWName:Pansichar):Boolean;virtual;abstract;
        function GetWinFormIsExsit(WinName:Pansichar):Boolean;virtual;abstract;
         procedure CloseActiveForm(FormStr:Pansichar); virtual;abstract;
         //ϵͳ����
        constructor Create; virtual;abstract;
   end;

   TClassStateMent_PStopeGuid = class of TDefine_PstopeGuid;

implementation

end.