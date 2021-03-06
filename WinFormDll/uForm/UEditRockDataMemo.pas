unit UEditRockDataMemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls
  ,UMainDataModule
  ;

type
  TFormEditRockDataMemo = class(TForm)
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    SaveMemoButton: TButton;
    Button1: TButton;
    GroupBox2: TGroupBox;
    Splitter1: TSplitter;
    Memo2: TMemo;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SaveMemoButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Memo1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Memo2DblClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Memo2Click(Sender: TObject);
  private
    { Private declarations }
     MySqlDataSet1:TMyDataSet;
     MyCommand1:TMyCommand;
     procedure FillKyxx_Used_Phsae;
     procedure DeleteKyxx_Used_Phase(Str:String);
     procedure InsertKyxx_Used_Phase(str:string);
     procedure SelectLine(Mem:TMemo;ln:integer) ;
     procedure ScrollToLine(Mem: TMemo; ln: Integer);
  public
    { Public declarations }
    procedure SetMemoValue(Caption,STD:String);
    procedure  ReturnEditMemo;
  end;
  function CreateEditRockDataMemo(AHandle:THandle;Wid,Hi:integer;Cap,STD:String):integer;stdcall;
var
  FormEditRockDataMemo: TFormEditRockDataMemo;

implementation

{$R *.dfm}

uses UPressureGraph;
function CreateEditRockDataMemo(AHandle:THandle;Wid,Hi:integer;Cap,STD:String):integer;
begin
       Result:=0;//函数值

        FormEditRockDataMemo:=TFormEditRockDataMemo.Create(nil);
        try
           with FormEditRockDataMemo do begin
                WindowState:= wsNormal;
                ParentWindow:=Ahandle;
                if Hi >FormEditRockDataMemo.Height then
                       FormEditRockDataMemo.Top :=Round((Hi-FormEditRockDataMemo.Height)/3)
                       else   FormEditRockDataMemo.Top :=0;
                if Wid> FormEditRockDataMemo.Width then
                       FormEditRockDataMemo.Left:=Round((Wid-FormEditRockDataMemo.Width)/2)
                       else   FormEditRockDataMemo.Left:=0;

                SetMemoValue(Caption,STD);
                Show;
           end;

            Result:=1;//函数值
        except
            FreeAndNil(FormEditRockDataMemo);
        end;
end;

{ TFormEditRockDataMemo }

procedure TFormEditRockDataMemo.Button1Click(Sender: TObject);
begin
   Memo1.Clear ;
end;

procedure TFormEditRockDataMemo.Button2Click(Sender: TObject);
var
  inn_Line:integer;
begin
   inn_Line:=SendMessage(Memo1.Handle,EM_LineFromChar,Memo1.SelStart,0) ;
   Memo1.Lines.Delete(inn_Line) ;
end;

procedure TFormEditRockDataMemo.Button3Click(Sender: TObject);
var
  inn_Line:integer;
begin
   inn_Line:=SendMessage(Memo1.Handle,EM_LineFromChar,Memo1.SelStart,0) ;
   if Memo1.Lines[inn_Line].Trim<>'' then
      InsertKyxx_Used_Phase(Memo1.Lines[inn_Line].Trim);
   FillKyxx_Used_Phsae;
end;

procedure TFormEditRockDataMemo.Button4Click(Sender: TObject);
var
  inn_Line:integer;
begin
   inn_Line:=SendMessage(Memo2.Handle,EM_LineFromChar,Memo2.SelStart,0) ;
    if Memo2.Lines[inn_Line].Trim<>'' then
       DeleteKyxx_Used_Phase(Memo2.Lines[Inn_Line].Trim) ;
   FillKyxx_Used_Phsae;

end;

procedure TFormEditRockDataMemo.DeleteKyxx_Used_Phase(Str: String);
begin
   MyCommand1.CommandText :='delete from Kyxx_Used_Phase where Used_Phase =''' +
                                 Str+ '''';
   MyCommand1.Execute ;
end;

procedure TFormEditRockDataMemo.FillKyxx_Used_Phsae;
begin
    Memo2.Clear ;
    MySqlDataSet1.Close ;
    try
        MySqlDataSet1.CommandText :='select * from Kyxx_Used_Phase ';
        MySqlDataSet1.Open ;
        while not MySqlDataSet1.Eof  do  begin
          Memo2.Lines.Add(MySqlDataSet1.FieldByName('Used_Phase').AsString  );
          MySqlDataSet1.Next ;
        end;
    finally
      MySqlDataSet1.Close ;
    end;
end;

procedure TFormEditRockDataMemo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
   ReturnEditMemo;
   if Assigned(FormEditRockDataMemo) then  FreeAndNil(FormEditRockDataMemo);
end;

procedure TFormEditRockDataMemo.FormCreate(Sender: TObject);
begin
    MySqlDataSet1:=TMyDataSet.Create(nil);
    MySqlDataSet1.MySqlConnection :=MainDataModule.ExConn;

    MyCommand1:=TMyCommand.Create (nil);
    MyCommand1.MySqlConnection :=MainDataModule.ExConn;
end;

procedure TFormEditRockDataMemo.FormDestroy(Sender: TObject);
begin
    FreeAndNil(MySqlDataSet1);
    FreeAndNil(MyCommand1);
end;

procedure TFormEditRockDataMemo.FormShow(Sender: TObject);
begin
   FillKyxx_Used_Phsae;
end;

procedure TFormEditRockDataMemo.InsertKyxx_Used_Phase(str: string);
begin
   MyCommand1.CommandText :='insert into  Kyxx_Used_Phase ( Used_Phase  ) values (''' +
                                 Str+ ''')';
   MyCommand1.Execute ;
end;

procedure TFormEditRockDataMemo.Memo1Click(Sender: TObject);
var
  inn_Line:integer;
begin
    Memo1.SetFocus;
    inn_Line:=SendMessage(Memo1.Handle,EM_LineFromChar,Memo1.SelStart,0) ;
    SelectLine(Memo1,inn_Line);
    ScrollToLine(Memo1,inn_Line);  //将水平的滚动条滚到最左边
    SendMessage(Memo1.Handle, WM_HSCROLL, SB_LEFT, 0);
end;

procedure TFormEditRockDataMemo.Memo2Click(Sender: TObject);
var
  inn_Line:integer;
begin
   Memo2.SetFocus;
   inn_Line:=SendMessage(Memo2.Handle,EM_LineFromChar,Memo2.SelStart,0) ;

    SelectLine(Memo2,inn_Line);
    ScrollToLine(Memo2,inn_Line);  //将水平的滚动条滚到最左边
    SendMessage(Memo2.Handle, WM_HSCROLL, SB_LEFT, 0);
end;

procedure TFormEditRockDataMemo.Memo2DblClick(Sender: TObject);
var
  inn_Line:integer;
begin
   inn_Line:=SendMessage(Memo2.Handle,EM_LineFromChar,Memo2.SelStart,0) ;
   if Memo2.Lines[inn_Line].Trim <> '' then
       Memo1.Lines.Add(Memo2.Lines[inn_Line]);
end;

procedure TFormEditRockDataMemo.ReturnEditMemo;
var
 Retu_Str:string;
begin
    if length(Memo1.Text)> 192  then  begin
        Retu_Str:=Copy(Memo1.Text,0,190)
    end else if length(Trim(Memo1.Text))<2 then begin
         Retu_Str:='';
    end else  begin
         Retu_Str:= Memo1.Text;
    end;
    DrawBmp_From.Return_CallEditRockPressMemo(Retu_Str);
end;

procedure TFormEditRockDataMemo.SaveMemoButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TFormEditRockDataMemo.ScrollToLine(Mem: TMemo; ln: Integer);
begin
     SendMessage(Mem.Handle, EM_LINESCROLL, 0, -Mem.Lines.Count);
     SendMessage(Mem.Handle, EM_LINESCROLL, 0, ln - 1)
end;

procedure TFormEditRockDataMemo.SelectLine(Mem: TMemo; ln: integer);
begin
  Mem.SelStart := SendMessage(Mem.Handle, EM_LINEINDEX, ln - 1, 0);
  Mem.SelLength := Length(Mem.Lines[ln - 1]);
end;

procedure TFormEditRockDataMemo.SetMemoValue(Caption, STD: String);
begin
    GroupBox1.Caption :=Caption;
    Memo1.Text :=STD;
end;

end.
