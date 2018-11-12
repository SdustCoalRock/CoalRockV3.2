unit ProgForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TFormProg = class(TForm)
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    Label1: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormProg: TFormProg;
  function OpenFromProg(AHandle:THandle;ACaption:string;Wid,Hi:integer):integer;stdcall;

implementation

{$R *.dfm}
function OpenFromProg(AHandle:THandle;ACaption:string;Wid,Hi:integer):integer;stdcall;
 begin
       if Assigned(FormProg) then  FreeANdNil(FormProg);

        FormProg:=TFormProg.Create(nil);
        try
           with FormProg do begin
               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

                Show;
                SetFocus;
                Result:=1;//º¯ÊýÖµ
          end ;
        except
           FreeAndNil(FormProg);
        end;
 end;

procedure TFormProg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if Assigned(FormProg) then  FreeANdNil(FormProg);

end;

end.
