unit UIGuideMapDll;


//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//<<      文件名：UIGuideMapDll                          <<
//<<      lulei使用的个人Delphi文件                            <<
//<<      该文件是主要实现支架地图  引用文件           <<
//<<      该文件与 dll文件一同发布，dll不需要注册使用          <<
//<<      创建日期：2018.1.10                                   <<
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

interface

uses  Classes;

type

   TDefine_MapDll = class (TObject)
     protected

     public

         procedure OpenMapWindows(AHandle:THandle;Caption:Pansichar;Width,Heigth:integer);virtual;abstract;
         procedure SetUsetInformation(UserID,UserName:Pansichar;Admin:Boolean);  virtual;abstract;
        //系统函数

        constructor Create; virtual;abstract;
   end;

   TClassStateMent_MapDll = class of TDefine_MapDll;

implementation

end.
