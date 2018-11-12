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
    function GetVersionString(FileName: string): string;   //�õ��ļ��汾
    function   GetFileCreationTime(const   Filename:   string):   TDateTime;  //��Ӧ�ó���ʱ��

  public
    { Public declarations }

  end;

var
  BanBen: TBanBen;

implementation

{$R *.dfm}

uses Lu_Public_BasicModual, MainForm;
//ȷ��
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
    //���°汾��Ϣ
    GetVersion;
    test:=MainCForm.GetTestState;
    VerFiyMemo.Clear ;
    if Public_Basic.Licensing then  begin
       VerFiyMemo.Lines.Add('��ӭʹ����Ȩ�����');
       VerFiyMemo.Lines.Add('�������Ȩ�ڣ�'+Public_Basic.UseUnitName );
       VerFiyMemo.Lines.Add('');
       VerFiyMemo.Lines.Add('   ����ʹ�ù��������κ����⣬����ѯɽ���Ƽ���ѧ������Ժʿ�����Ŷ�');
       VerFiyMemo.Lines.Add('ϵͳ���ڣ�'+FormatDatetime('YYYY-MM-DD',now()));
    end else begin
       VerFiyMemo.Lines.Add('����ʹ��������Ȩ�����');
       VerFiyMemo.Lines.Add('������Ȩ�󽫻��и��õļ���֧�֣�');
       VerFiyMemo.Lines.Add('');
       VerFiyMemo.Lines.Add('��������Ŷ�Ϊ��'+Public_Basic.UseUnitName );
       VerFiyMemo.Lines.Add('ϵͳ���ڣ�'+FormatDatetime('YYYY-MM-DD',now()));
    end;

    if test then begin
       VerFiyMemo.Clear ;
       VerFiyMemo.Lines.Add('��ӭ�������������');
       VerFiyMemo.Lines.Add('����������Ŷ�Ϊ��'+Public_Basic.UseUnitName );
       VerFiyMemo.Lines.Add('');
       VerFiyMemo.Lines.Add('   ����ʹ�ù��������κ����⣬����ѯɽ���Ƽ���ѧ������Ժʿ�����Ŷ�');
       VerFiyMemo.Lines.Add('ϵͳ���ڣ�'+FormatDatetime('YYYY-MM-DD',now()));
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
            Data.ftCreationTime:   TFileTime;   //����ʱ��
            Data.ftLastAccessTime:   TFileTime; //������ʱ��
            Data.ftLastWriteTime:   TFileTime;  //����޸�ʱ��
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
   Label1.Caption :='�������:'+Cap;
   Label2.Caption :='����汾:'+GetVersionString('CoalRockPress.exe');
   Label3.Caption :='ϵͳ�������ڣ�'+FormatDateTime('YYYY-MM-DD',GetFileCreationTime('CoalRockPress.exe'));
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
