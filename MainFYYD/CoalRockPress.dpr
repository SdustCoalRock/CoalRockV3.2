program CoalRockPress;

uses
  system.sysUtils,
  windows,

  Vcl.Forms,
  BanBen_Wf in 'FormUnit\BanBen_Wf.pas' {BanBen},
  FormMonitor in 'FormUnit\FormMonitor.pas' {MonitorForm},
  Login in 'FormUnit\Login.pas' {loginForm},
  MainForm in 'FormUnit\MainForm.pas' {MainCForm},
  ShowOtherForm in 'FormUnit\ShowOtherForm.pas' {Form2},
  Start in 'FormUnit\Start.pas' {Kcover},
  Lu_Public_BasicModual in '..\PublicSysForm\Lu_Public_BasicModual.pas',
  UICallPstope in '..\UsedForm\UICallPstope.pas',
  UIGuideMapDll in '..\UsedForm\UIGuideMapDll.pas',
  UIPStopeGuidUnit in '..\UsedForm\UIPStopeGuidUnit.pas',
  uIRockPress in '..\UsedForm\uIRockPress.pas',
  UIWinFrame in '..\UsedForm\UIWinFrame.pas',
  VerFityDataComm in '..\PublicSysForm\VerFityDataComm.pas';

{$R *.res}

const mypro='TMainCForm';//��������
   var handle:integer;
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Kcover:=TKcover.Create(Application);
  Kcover.Show;
  Kcover.Update;

  handle:=findwindow(mypro,nil);
  if handle<>0 then
   begin
      messagebox(0,'������������,���˳�!','����!',0);
      halt;
   end;


  Kcover.Hide;
  Kcover.Free;
  //


 //
   Application.CreateForm(TMainCForm, MainCForm);
  // Application.CreateForm(TloginForm, loginForm);
  if MainCForm.SystemVersion ='SHENDONG' then  begin
     {����ǿ�ѹ������ֱ�ӵ�¼}
      Public_Basic.WriteLoginInfo('UserInFormation','0','Admin','1');
      MainCForm.SetUserInfo('0','Admin',true);
      Application.Run;
  end else begin
     {������ǿ�ѹ������������֤��¼}
       if  MainCForm.Longin_i=2 then     begin
         loginForm:=TloginForm.Create(Application);
         loginForm.ShowModal;
      end;

      //=============================
       //�����¼�ɹ� MainCForm.Longin_i ����,�����˳�
       {MainCForm.Longin_i=1 Ϊ��64 λ���ε�}
      if MainCForm.Longin_i=1 then   begin
          Application.Run;
      end else begin
        Application.Terminate;
        exit;

      end;

  end;


end.