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
  //释放地图控件
  FMyMap.Free;
  //找到窗体在cxTabControl1中的索引
 { Index := frmMain.cxTabControl1.Tabs.IndexOfObject(Self);
  if Index > -1 then
    frmMain.cxTabControl1.Tabs.Delete(Index);
  //刷新主窗体的信息
  frmMain.cxTabControl1Change(nil); }
  Action:= caFree;
end;

procedure TfrmMap.AfterConstruction;
begin
  inherited;
  //窗体创建后最大化窗体
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
 { MapX_LuLei.StatusBar1.Panels[1].Text:= '当前坐标: X= '+FloatToStr(MouseX)+' Y= '+FloatToStr(MouseY);
  //气泡信息提示功能
  //ShowMessage(CurrentTool);
  if (FeatureUnderMouse <> nil) and (CurrentTool in [mttPointSelectTool]) then
  begin
    if hToolTip = 0 then hToolTip:= MapX.CreateToolTipWindow(MapHandle);
    //SendMessage(hToolTip, TTM_DELTOOL, 0, LPARAM(@AToolInfo));
    MapX.AddToolTip(MapHandle, @AToolInfo, 1, '名称：你好'+#13+'性别：男', '提示标题',0,0);

  end
  else
    SendMessage(hToolTip, TTM_DELTOOL, 0, LPARAM(@AToolInfo));   }
end;

end.
