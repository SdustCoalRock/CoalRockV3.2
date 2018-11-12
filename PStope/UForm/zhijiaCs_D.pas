unit zhijiaCs_D;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls,IniFiles;

type
  TFormZJCS = class(TForm)
    StringGrid_ZJCS: TStringGrid;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
     DllFileName:string;
     procedure InItGrid_Zjcs ();
     procedure CreateFile(FileName:string);
     procedure ReadFileFillStrinGrid(FileName:string);
  public
    { Public declarations }
  end;

function ShowCalSupCanshu_inn(AHandle:THandle;ACaption:string;Wid,Hi:integer):integer;stdcall;

var
  FormZJCS: TFormZJCS;

implementation
{$R *.dfm}

uses Lu_Public_BasicModual;

function ShowCalSupCanshu_inn(AHandle:THandle;ACaption:string;Wid,Hi:integer):integer;stdcall;

begin
        if Assigned(FormZJCS) then FreeAndNil(FormZJCS);

        FormZJCS:=TFormZJCS.Create(nil);
        try
            with FormZJCS do begin
               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;

               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

                Show;
                SetFocus;
                Result:=1;//函数值
          end ;
        except
           FreeAndNil(FormZJCS);
        end;
 end;
 //============
procedure TFormZJCS.Button1Click(Sender: TObject);
var
  pIniFile:     TIniFile;
  i:integer;
begin
    if not FileExists(Public_Basic.Get_MyModulePath+DllFileName) then exit;

    pIniFile := Tinifile.create(Public_Basic.Get_MyModulePath+DllFileName);
    for I := 1 to 9 do  begin

      if i=5 then   continue;
         //I
       self.StringGrid_ZJCS.Cells[2,i]:=format('%1.1f',[pIniFile.ReadFloat('I',IntToStr(i),0)]);
          // II
       self.StringGrid_ZJCS.Cells[3,i]:=format('%1.1f',[pIniFile.ReadFloat('II',IntToStr(i),0)]);
          // III
       self.StringGrid_ZJCS.Cells[4,i]:=format('%1.1f',[pIniFile.ReadFloat('III',IntToStr(i),0)]);
          // III
       self.StringGrid_ZJCS.Cells[5,i]:=format('%1.1f',[pIniFile.ReadFloat('IV',IntToStr(i),0)]);

    end;
    pIniFile.Free;

end;

procedure TFormZJCS.Button2Click(Sender: TObject);
var
  pIniFile:     TIniFile;
  i:integer;
begin
    if not FileExists(Public_Basic.Get_MyModulePath+DllFileName) then exit;
    pIniFile := Tinifile.create(Public_Basic.Get_MyModulePath+DllFileName);
    for I := 1 to 9 do  begin

       if i=5 then   continue;
        // I
        pIniFile.WriteFloat('I',IntToStr(i),StrToFloat(self.StringGrid_ZJCS.Cells[2,i]));

        // II
        pIniFile.WriteFloat('II',IntToStr(i),StrToFloat(self.StringGrid_ZJCS.Cells[3,i]));

          // III
        pIniFile.WriteFloat('III',IntToStr(i),StrToFloat(self.StringGrid_ZJCS.Cells[4,i]));

          // III
        pIniFile.WriteFloat('IV',IntToStr(i),StrToFloat(self.StringGrid_ZJCS.Cells[5,i]));


    end;

     pIniFile.Free;

end;

procedure TFormZJCS.Button3Click(Sender: TObject);
begin
   self.CreateFile(DllFileName);
   self.ReadFileFillStrinGrid(DllFileName);
end;

procedure TFormZJCS.Button4Click(Sender: TObject);
begin
     close;
end;

procedure TFormZJCS.CreateFile(FileName: string);
var
  pIniFile:     TIniFile;
  i:integer;
begin
   if FileExists(Public_Basic.Get_MyModulePath+FileName) then
      DeleteFile(Public_Basic.Get_MyModulePath+FileName);

      pIniFile := Tinifile.create(Public_Basic.Get_MyModulePath+'ZhijiaCs_lulei.dll');
     // I
      pIniFile.WriteFloat('I','1',0.25);
      pIniFile.WriteFloat('I','2',0.5);
      pIniFile.WriteFloat('I','3',0.5);
      pIniFile.WriteFloat('I','4',1);

      pIniFile.WriteFloat('I','6',0.3);
      pIniFile.WriteFloat('I','7',0.6);
      pIniFile.WriteFloat('I','8',0.6);
      pIniFile.WriteFloat('I','9',1.1);
       // II
      pIniFile.WriteFloat('II','1',0.25);
      pIniFile.WriteFloat('II','2',0.5);
      pIniFile.WriteFloat('II','3',0.5);
      pIniFile.WriteFloat('II','4',0.8);

      pIniFile.WriteFloat('II','6',0.4);
      pIniFile.WriteFloat('II','7',0.6);
      pIniFile.WriteFloat('II','8',0.6);
      pIniFile.WriteFloat('II','9',1);
       // III
      pIniFile.WriteFloat('III','1',0.1);
      pIniFile.WriteFloat('III','2',0.3);
      pIniFile.WriteFloat('III','3',0.6);
      pIniFile.WriteFloat('III','4',1);

      pIniFile.WriteFloat('III','6',0.2);
      pIniFile.WriteFloat('III','7',0.4);
      pIniFile.WriteFloat('III','8',0.6);
      pIniFile.WriteFloat('III','9',1);
      // IV
      pIniFile.WriteFloat('IV','1',0.8);
      pIniFile.WriteFloat('IV','2',1.5);
      pIniFile.WriteFloat('IV','3',1);
      pIniFile.WriteFloat('IV','4',2);

      pIniFile.WriteFloat('IV','6',1);
      pIniFile.WriteFloat('IV','7',1.8);
      pIniFile.WriteFloat('IV','8',1);
      pIniFile.WriteFloat('IV','9',2);
      pIniFile.Free;


end;

procedure TFormZJCS.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    if Assigned(FormZJCS) then FreeAndNil(FormZJCS);
end;

procedure TFormZJCS.FormCreate(Sender: TObject);

begin
    DllFileName:='ZhijiaCs_lulei.dll';
    InItGrid_Zjcs;
    ReadFileFillStrinGrid(DllFileName);
end;

procedure TFormZJCS.InItGrid_Zjcs ;
begin
    StringGrid_ZJCS.ColCount :=6;
    StringGrid_ZJCS.RowCount :=10;
    StringGrid_ZJCS.DefaultRowHeight:=25;

    
    StringGrid_ZJCS.FixedCols:=1;
    StringGrid_ZJCS.FixedRows:=1;
   
    StringGrid_ZJCS.ColWidths[0]:=30;
    StringGrid_ZJCS.ColWidths[1]:=200;
    StringGrid_ZJCS.ColWidths[2]:=80;
    StringGrid_ZJCS.ColWidths[3]:=80;
    StringGrid_ZJCS.ColWidths[4]:=80;
    StringGrid_ZJCS.ColWidths[5]:=100;

    StringGrid_ZJCS.Canvas.Font.Size:=8;
    StringGrid_ZJCS.Cells[0,0]:='序号';
    StringGrid_ZJCS.Cells[1,0]:='项目';
    StringGrid_ZJCS.Cells[2,0]:='软弱岩层取值';
    StringGrid_ZJCS.Cells[3,0]:='一般岩层取值';
    StringGrid_ZJCS.Cells[4,0]:='坚硬岩层取值';
    StringGrid_ZJCS.Cells[5,0]:='浅埋薄基岩取值';

    // 行的信息
    StringGrid_ZJCS.Cells[0,1]:='1';
    StringGrid_ZJCS.Cells[0,2]:='2';
    StringGrid_ZJCS.Cells[0,3]:='3';
    StringGrid_ZJCS.Cells[0,4]:='4';
    StringGrid_ZJCS.Cells[0,6]:='5';
    StringGrid_ZJCS.Cells[0,7]:='6';
    StringGrid_ZJCS.Cells[0,8]:='7';
    StringGrid_ZJCS.Cells[0,9]:='8';

    StringGrid_ZJCS.Cells[1,1]:='[有内应力场][单岩梁结构][初次来压]';
    StringGrid_ZJCS.Cells[1,2]:='[有内应力场][单岩梁结构][周期来压]';
    StringGrid_ZJCS.Cells[1,3]:='[有内应力场][多岩梁结构][初次来压]';
    StringGrid_ZJCS.Cells[1,4]:='[有内应力场][多岩梁结构][周期来压]';
    StringGrid_ZJCS.Cells[1,6]:='[无内应力场][单岩梁结构][初次来压]';
    StringGrid_ZJCS.Cells[1,7]:='[无内应力场][单岩梁结构][周期来压]';
    StringGrid_ZJCS.Cells[1,8]:='[无内应力场][多岩梁结构][初次来压]';
    StringGrid_ZJCS.Cells[1,9]:='[无内应力场][多岩梁结构][周期来压]';
end;


procedure TFormZJCS.ReadFileFillStrinGrid(FileName: string);
var
  pIniFile:     TIniFile;
  i:integer;
begin
      if not FileExists(Public_Basic.Get_MyModulePath+FileName) then   begin
         self.CreateFile(FileName);
      end;

      pIniFile := Tinifile.create(Public_Basic.Get_MyModulePath+'ZhijiaCs_lulei.dll');
      for I := 1 to 9 do  begin
         // I
         if i=5 then   continue;

         self.StringGrid_ZJCS.Cells[2,i]:=format('%1.2f',[pIniFile.ReadFloat('I',IntToStr(i),0)]);
            // II
         self.StringGrid_ZJCS.Cells[3,i]:=format('%1.2f',[pIniFile.ReadFloat('II',IntToStr(i),0)]);
            // III
         self.StringGrid_ZJCS.Cells[4,i]:=format('%1.2f',[pIniFile.ReadFloat('III',IntToStr(i),0)]);
            // III
         self.StringGrid_ZJCS.Cells[5,i]:=format('%1.2f',[pIniFile.ReadFloat('IV',IntToStr(i),0)]);


      end;
      pIniFile.Free;



end;

end.
