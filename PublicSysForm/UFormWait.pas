unit UFormWait;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.ComCtrls,uDrawGraphClass;

type
  TFormWait = class(TForm)
    Image1: TImage;
    WaitLabel: TLabel;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    DrawGzh:TDrawGrap;
    procedure DlThreadTerminate(Sender: TObject);
  end;
function CreateFromWait(AHandle:THandle):THandle;stdcall;
procedure CloseFromWait; stdcall;


var
  FormWait: TFormWait;


implementation

{$R *.dfm}


procedure CloseFromWait;stdcall;
begin
    if Assigned(FormWait) then
       FormWait.Close ;

end;



function CreateFromWait(AHandle:THandle):THandle;stdcall;
{

  Single 0 正常页面  1 全屏页面
}

begin
        if Assigned(FormWait) then  FreeAndNil(FormWait);
        Application.Handle :=AHandle;
        FormWait:=TFormWait.Create(nil);
        try
           with FormWait do begin
               ParentWindow:=Ahandle;
               Show;
               Repaint;
               Result:=FormWait.Handle ;//函数值
          end ;
        except
           FreeAndNil(FormWait);
        end;

end;

procedure TFormWait.DlThreadTerminate(Sender: TObject);
begin
   Close;
end;

procedure TFormWait.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
     if Assigned(FormWait) then
        freeAndNil(FormWait);
end;

procedure TFormWait.Timer1Timer(Sender: TObject);
begin
     ProgressBar1.StepIt ;


end;

end.
