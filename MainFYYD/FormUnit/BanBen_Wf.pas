unit BanBen_Wf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TBanBen = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Label6: TLabel;
    Image1: TImage;
    Image2: TImage;
    Shape1: TShape;
    VerFiyMemo: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure GetVersion;
    function GetVersionString(FileName: string): string;   //得到文件版本
    function   GetFileCreationTime(const   Filename:   string):   TDateTime;  //获应用程序时间

  public
    { Public declarations }

  end;

var
  BanBen: TBanBen;

implementation

{$R *.dfm}

uses Lu_Public_BasicModual, MainForm;
//确定
procedure TBanBen.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TBanBen.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    if Assigned(BanBen) then     FreeAndNil(BanBen);
end;

procedure TBanBen.FormShow(Sender: TObject);
var
  test:Boolean;
begin
    //更新版本信息
    GetVersion;
    test:=MainCForm.GetTestState;
    VerFiyMemo.Clear ;
    if Public_Basic.Licensing then  begin
       VerFiyMemo.Lines.Add('欢迎使用授权软件：');
       VerFiyMemo.Lines.Add('本软件授权于：'+Public_Basic.UseUnitName );
       VerFiyMemo.Lines.Add('');
       VerFiyMemo.Lines.Add('   您在使用过程中有任何问题，请咨询山东科技大学宋振骐院士技术团队');
       VerFiyMemo.Lines.Add('系统日期：'+FormatDatetime('YYYY-MM-DD',now()));
    end else begin
       VerFiyMemo.Lines.Add('请您使用正版授权软件！');
       VerFiyMemo.Lines.Add('正版授权后将会有更好的技术支持！');
       VerFiyMemo.Lines.Add('');
       VerFiyMemo.Lines.Add('软件技术团队为：'+Public_Basic.UseUnitName );
       VerFiyMemo.Lines.Add('系统日期：'+FormatDatetime('YYYY-MM-DD',now()));
    end;

    if test then begin
       VerFiyMemo.Clear ;
       VerFiyMemo.Lines.Add('欢迎您来测试软件：');
       VerFiyMemo.Lines.Add('本软件开发团队为：'+Public_Basic.UseUnitName );
       VerFiyMemo.Lines.Add('');
       VerFiyMemo.Lines.Add('   您在使用过程中有任何问题，请咨询山东科技大学宋振骐院士技术团队');
       VerFiyMemo.Lines.Add('系统日期：'+FormatDatetime('YYYY-MM-DD',now()));
    end;

end;

function TBanBen.GetFileCreationTime(const Filename: string): TDateTime;
var
      Data:   TWin32FindData;
      H:   THandle;
      FT:   TFileTime;
      I:   Integer;
begin
  {
            Data.ftCreationTime:   TFileTime;   //创建时间
            Data.ftLastAccessTime:   TFileTime; //最后访问时间
            Data.ftLastWriteTime:   TFileTime;  //最后修改时间
   }
      H   :=   FindFirstFile(PCHAR(Filename),   Data);
      if   H   <>   INVALID_HANDLE_VALUE   then   begin
          try
              FileTimeToLocalFileTime(Data.ftLastWriteTime,   FT);
              FileTimeToDosDateTime(FT,   LongRec(I).Hi,   LongRec(I).Lo);
              Result   :=   FileDateToDateTime(I);
          finally
              Windows.FindClose(H);
          end
      end   else   begin
          Result   :=   0;
      end;

end;

procedure TBanBen.GetVersion;
var
  cap,Ver:string;
begin
   ver:=MainCForm.GetCaptionAndVersion(cap);
   Label1.Caption :='软件名称:'+Cap;
   Label2.Caption :='软件版本:'+GetVersionString('CoalRockPress.exe');
   Label3.Caption :='系统更新日期：'+FormatDateTime('YYYY-MM-DD',GetFileCreationTime('CoalRockPress.exe'));
end;

function TBanBen.GetVersionString(FileName: string): string;
var
     VerInfoSize: DWORD;
     VerInfo: Pointer;
     VerValueSize: DWORD;
     Dummy: DWORD;
     VerValue: PVSFixedFileInfo;
begin
     Result := '';
     VerInfoSize := GetFileVersionInfoSize(PChar(FileName), Dummy);
     if VerInfoSize = 0 then Exit;
     GetMem(VerInfo, VerInfoSize);
     GetFileVersionInfo(PChar(FileName), 0, VerInfoSize, VerInfo);
     VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
     Result := IntToStr(VerValue^.dwFileVersionMS shr 16) + '.' +
     IntToStr(VerValue^.dwFileVersionMS and $FFFF) + '.' +
     IntToStr(VerValue^.dwFileVersionLS shr 16) + '.' +
     IntToStr(VerValue^.dwFileVersionLS and $FFFF);
     FreeMem(VerInfo);
end;

end.
