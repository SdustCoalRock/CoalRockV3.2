unit MapFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MapX, ExtCtrls, CommCtrl;

type
  TMyMap = class(TMapX)
  protected
    procedure MapXOnMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer); override;
  end;

  TfrmMap = class(TForm)
    Panel1: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FFileName: string;
    FMyMap: TMyMap;
  public
    { Public declarations }
    procedure OpenMapFile(AFileName: string);
    procedure AfterConstruction; override;
    property FileName: string read FFileName write FFileName;
    property MyMap: TMyMap read FMyMap;
  end;

var
  frmMap: TfrmMap;

implementation

uses MapX_LuLeiImpl;



{$R *.dfm}

{ TfrmMap }


procedure TfrmMap.FormCreate(Sender: TObject);
begin
  FMyMap:= TMyMap.Create(Panel1);
end;

procedure TfrmMap.FormClose(Sender: TObject; var Action: TCloseAction);
var
  Index: Integer;
begin
  //�ͷŵ�ͼ�ؼ�
  FMyMap.Free;
  //�ҵ�������cxTabControl1�е�����
 { Index := frmMain.cxTabControl1.Tabs.IndexOfObject(Self);
  if Index > -1 then
    frmMain.cxTabControl1.Tabs.Delete(Index);
  //ˢ�����������Ϣ
  frmMain.cxTabControl1Change(nil); }
  Action:= caFree;
end;

procedure TfrmMap.AfterConstruction;
begin
  inherited;
  //���崴������󻯴���
 // if MapX_LuLei.MDIChildCount = 1 then
  begin
    ShowWindow(Handle, SW_HIDE);
    ShowWindow(Handle, SW_MAXIMIZE);
  end;
end;

procedure TfrmMap.FormActivate(Sender: TObject);
var
  Index: Integer;
begin
 { Index := frmMain.cxTabControl1.Tabs.IndexOfObject(Self);
  if (Index > -1) MapX_LuLeiand (Index <> frmMain.cxTabControl1.TabIndex) then
  begin
    frmMain.cxTabControl1.TabIndex := Index;
    frmMain.cxTabControl1Change(nil);
  end; }
end;

procedure TfrmMap.OpenMapFile(AFileName: string);
begin
  if FFileName <> AFileName then
  begin
    FMyMap.OpenFile(AFileName);
    FFileName:= AFileName;
  end;
end;

{ TMyMap }

procedure TMyMap.MapXOnMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
 { MapX_LuLei.StatusBar1.Panels[1].Text:= '��ǰ����: X= '+FloatToStr(MouseX)+' Y= '+FloatToStr(MouseY);
  //������Ϣ��ʾ����
  //ShowMessage(CurrentTool);
  if (FeatureUnderMouse <> nil) and (CurrentTool in [mttPointSelectTool]) then
  begin
    if hToolTip = 0 then hToolTip:= MapX.CreateToolTipWindow(MapHandle);
    //SendMessage(hToolTip, TTM_DELTOOL, 0, LPARAM(@AToolInfo));
    MapX.AddToolTip(MapHandle, @AToolInfo, 1, '���ƣ����'+#13+'�Ա���', '��ʾ����',0,0);

  end
  else
    SendMessage(hToolTip, TTM_DELTOOL, 0, LPARAM(@AToolInfo));   }
end;

end.
