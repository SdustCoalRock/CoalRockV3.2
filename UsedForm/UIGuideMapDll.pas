unit UIGuideMapDll;


//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//<<      �ļ�����UIGuideMapDll                          <<
//<<      luleiʹ�õĸ���Delphi�ļ�                            <<
//<<      ���ļ�����Ҫʵ��֧�ܵ�ͼ  �����ļ�           <<
//<<      ���ļ��� dll�ļ�һͬ������dll����Ҫע��ʹ��          <<
//<<      �������ڣ�2018.1.10                                   <<
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

interface

uses  Classes;

type

   TDefine_MapDll = class (TObject)
     protected

     public

         procedure OpenMapWindows(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer);virtual;abstract;
         procedure SetUsetInformation(UserID,UserName:Pansichar;Admin:Boolean);  virtual;abstract;
        //ϵͳ����

        constructor Create; virtual;abstract;
   end;

   TClassStateMent_MapDll = class of TDefine_MapDll;

implementation

end.
