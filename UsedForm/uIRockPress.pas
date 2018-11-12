//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//<<      �ļ�����uRockPressClass.pas                          <<
//<<      luleiʹ�õĸ���Delphi�ļ�                            <<
//<<      ���ļ���pressureClass.dll delphi  �����ļ�           <<
//<<      ���ļ��� dll�ļ�һͬ������dll����Ҫע��ʹ��          <<
//<<      �������ڣ�2016.5.12                                   <<
//<<      2017.11.9  �����ݵĲ����㷨���˸���
//<<      2017.12.4  �޸��˽ӿں������ַ�����                  <<
//<<      ������RealTimeFootAge ��   Inputdata �ķ���ֵ       <<
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


unit uIRockPress;

interface

uses  Classes;

type

   TDefine_RockPress = class (TObject)
     protected

     public
           //20180411
            procedure SetStatuesCaption(Value:PansiChar); virtual;abstract;
            function CreateBatInputD(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer):THandle; virtual;abstract;
            function CreateEditFootage_Data(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer):THandle;  virtual;abstract;
            function  CreateRockPressGraph(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer):THandle;  virtual;abstract;
            function  CreateEditJinDao(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer):THandle;  virtual;abstract;
            function  CreateRockLineGraph(AHandle:THandle;Caption:Pansichar;Width,Heigth,Flag:integer):THandle;  virtual;abstract;
            procedure SetPublic_BasicLicending(Value:Boolean;UName:Pansichar);  virtual;abstract;
            procedure CloseRockPressTool; virtual;abstract;

            //
            function GetWinFormIsExsit(WinName:Pansichar):Boolean;virtual;abstract;
            function CloseActiveForm(FormStr:Pansichar):Boolean; virtual;abstract;
            function SetOpenFormChangeParentPanel(WinName:Pansichar;AHandle:THandle):Boolean; virtual;abstract;
            function OpenConTourChildForm(WinName:Pansichar;AHandle:THandle;Width,Heigth:integer):Boolean; virtual;abstract;
            procedure GetMinAndMaxJinDao(var MinD,MaxD:integer); virtual;abstract;
         //ϵͳ����
          constructor Create; virtual;abstract;
   end;

   TClassStateMent_RockPress = class of TDefine_RockPress;

implementation
    //no context
{ TIRockPress }


end.