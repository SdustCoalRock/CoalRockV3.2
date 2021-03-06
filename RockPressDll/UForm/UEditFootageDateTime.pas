unit UEditFootageDateTime;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TuEditFootageDate = class(TForm)
    GB_DateTimePicker: TGroupBox;
    DatePicker: TDateTimePicker;
    TimePicker: TDateTimePicker;
    Button1: TButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetDateTimePickerDisplay(DTStr:String);  //显示时间对话框
    function CloseDataTimePickDisplay:String;  // 关闭时间对话框
  end;

function CreateEditTime(AHandle:THandle;Pt:TPoint;DTS:String):integer;stdcall;

var
  uEditFootageDate: TuEditFootageDate;

implementation

{$R *.dfm}

uses Lu_Public_BasicModual, UFormModifyJinDao;

function CreateEditTime(AHandle:THandle;Pt:TPoint;DTS:String):integer;
begin
       Result:=0;//函数值

        uEditFootageDate:=TuEditFootageDate.Create(nil);
        try
            uEditFootageDate.WindowState:= wsNormal;
            uEditFootageDate.ParentWindow:=Ahandle;
            uEditFootageDate.Top:=Pt.y ;
            uEditFootageDate.Left :=pt.x;
            uEditFootageDate.SetDateTimePickerDisplay(DTS);
            uEditFootageDate.Show;

            Result:=1;//函数值
        except
            FreeAndNil(uEditFootageDate);
        end;
end;

{ TuEditFootageDate }

procedure TuEditFootageDate.Button1Click(Sender: TObject);
begin
   Close;
end;

function TuEditFootageDate.CloseDataTimePickDisplay: String;
var
  inDateTimeStr:string;
begin
   inDateTimeStr:=FormatDateTime('yyyy-mm-dd',DatePicker.DateTime);
   inDateTimeStr:=inDateTimeStr +' '+ FormatDateTime('HH:mm:ss',TimePicker.DateTime);
   ModifyJinDao_From.Return_CallEditDateTime(inDateTimeStr);
   Result:=inDateTimeStr;

end;

procedure TuEditFootageDate.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
     CloseDataTimePickDisplay;
     if Assigned(uEditFootageDate) then  FreeAndNil(uEditFootageDate);
end;

procedure TuEditFootageDate.SetDateTimePickerDisplay(DTStr: String);
begin
   DatePicker.DateTime  :=StrToDateTime(DTStr,Public_Basic.FSetting);
   TimePicker.DateTime :=StrToDateTime(DTStr,Public_Basic.FSetting);
   GB_DateTimePicker.Visible:=true;

end;

end.
