library LibWinFrame;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.SysUtils,
  System.Classes,
  uWinFrameClass in 'uWinFrameClass.pas',
  PublicUnit in 'Frame\PublicUnit.pas',
  UncoalName in 'uForm\UncoalName.pas' {ZkCoalName},
  UnEditGzk in 'uForm\UnEditGzk.pas' {ZkGzmForm},
  UnDetail in 'uForm\UnDetail.pas' {ZkDetailForm},
  UnWjfl_Zry in 'uForm\UnWjfl_Zry.pas' {Wjfl},
  UnCkq in 'uForm\UnCkq.pas' {Cqk},
  UnDc in 'uForm\UnDc.pas' {Dc},
  UnMz in 'uForm\UnMz.pas' {Mz},
  UnEditZJ in 'uForm\UnEditZJ.pas' {ZkZJForm},
  UnZkBasic in 'uForm\UnZkBasic.pas' {ZkBasicForm},
  UnZkGzmLink in 'uForm\UnZkGzmLink.pas' {ZkGzmLink},
  ControlGraph in 'UWinClass\ControlGraph.pas',
  CADImage in 'uForm\CADImage.pas' {CADBMP},
  mysql in '..\PublicSysForm\mysql.pas',
  SQLite3 in '..\PublicSysForm\SQLite3.pas',
  sqlite3udf in '..\PublicSysForm\sqlite3udf.pas',
  SQLiteTable3 in '..\PublicSysForm\SQLiteTable3.pas',
  UIWinFrame in '..\UsedForm\UIWinFrame.pas',
  UMainDataModule in '..\PublicSysForm\UMainDataModule.pas' {DataModule1: TDataModule},
  UnTxMc in 'uForm\UnTxMc.pas' {TxMcForm},
  UUserIfo in 'uForm\UUserIfo.pas' {User_Manager},
  UUserManager in 'uForm\UUserManager.pas' {FormUserManager},
  UnselectGZM in 'uForm\UnselectGZM.pas',
  PStope_GzmGuidClass in '..\PublicSysForm\PStope_GzmGuidClass.pas',
  RockPressBasicClass in '..\PublicSysForm\RockPressBasicClass.pas',
  Lu_Mk_base_Class in '..\PublicSysForm\Lu_Mk_base_Class.pas',
  UBMPToDataBase in 'uForm\UBMPToDataBase.pas' {FormBmpDataBase},
  UdataBaseManager in 'uForm\UdataBaseManager.pas' {FormDataManager},
  Lu_Public_BasicModual in '..\PublicSysForm\Lu_Public_BasicModual.pas',
  DataService in 'UWinClass\DataService.pas',
  uLuDataAdo in '..\PublicSysForm\uLuDataAdo.pas',
  uLuSqliteDealWith in '..\PublicSysForm\uLuSqliteDealWith.pas',
  HanzhiExtractPy in '..\PublicSysForm\HanzhiExtractPy.pas' {Form1},
  uFormYKlhCslu in 'uForm\uFormYKlhCslu.pas' {FormYKLH_jingji},
  VerFityDataComm in '..\PublicSysForm\VerFityDataComm.pas',
  MYProperty in '..\PublicSysForm\MYProperty.pas',
  uDrawGraphClass in '..\PublicSysForm\uDrawGraphClass.pas',
  StopWatch in '..\PublicSysForm\StopWatch.pas',
  UMakeRuleClass in '..\RockPressDll\UClass\UMakeRuleClass.pas',
  UFormWait in '..\PublicSysForm\UFormWait.pas' {FormWait},
  UFormEditWordFile in 'uForm\UFormEditWordFile.pas' {FormFileEdit},
  UGuidMap in 'uForm\UGuidMap.pas' {Form_MapMain},
  UOpenWordFile in 'uForm\UOpenWordFile.pas' {FromOpenFile};

{$R *.res}
 function TuseWin:TClassStateMent_WinFrame;
  begin
      Result:=TWinFrameBasicClass;
  end;

exports
   TuseWin;

begin
end.
