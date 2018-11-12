unit ECText;

//{$INCLUDE Versions.inc}

interface

uses
  Windows,
  SysUtils,
  Messages,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Menus,
  StdCtrls,
  ExtCtrls,
  Grids,
  contnrs,
  EStringGrid,
  Buttons;

type
  TInplaceSpeedButton = class(TSpeedButton)
{$IFDEF REQUESTALIGN_FIXED}
  protected
    procedure RequestAlign; override;
{$ENDIF}
  end;

  TEditInplace = class(TCustomEdit)
  private
    FCellEditor: TCellEditor;
    FButton: TSpeedButton;
  protected
{$IFDEF REQUESTALIGN_FIXED}
    procedure RequestAlign; override;
{$ENDIF}
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure KeyPress(var Key: Char); override;
    procedure DoExit; override;
    procedure CreateWnd; override;
  public
    constructor Create(AOwner: TComponent; CellEditor: TCellEditor); {$IFDEF HAS_REINTRODUCE} reintroduce; {$ENDIF} virtual;
    destructor Destroy; override;
    property Button: TSpeedButton read FButton;
  end;

  TEditCellEditor = class(TMetaCellEditor)
  private
    FhasElipsis: boolean;
    FOnElipsisClick: TNotifyEvent;
    FElipsisCaption: string;
    function getElipsisCaption: string;
    function getOnElipsisClick: TNotifyEvent;
    procedure setElipsisCaption(const Value: string);
    procedure setOnElipsisClick(const Value: TNotifyEvent);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function InitEditor(AOwner: TComponent): TWinControl; override;
  public
    procedure StartEdit; override;
    procedure EndEdit; override;
    procedure Clear; override;
    procedure Draw(Rect: TRect); override;
  published
    property DefaultText;
    property hasElipsis: boolean read FhasElipsis write FhasElipsis;
    property OnElipsisClick: TNotifyEvent read getOnElipsisClick write setOnElipsisClick;
    property ElipsisCaption: string read getElipsisCaption write setElipsisCaption;
  end;

implementation

////////////////////////////////////////////////////////////////////////////////
// TInplaceSpeedButton
//

{$IFDEF REQUESTALIGN_FIXED}
procedure TInplaceSpeedButton.RequestAlign;
begin
// Empty. Don't call inherited this disallows alignment
end;
{$ENDIF}

////////////////////////////////////////////////////////////////////////////////
// TEditInplace
//

{$IFDEF REQUESTALIGN_FIXED}
procedure TEditInplace.RequestAlign;
begin
// Empty. Don't call inherited this disallows alignment
end;
{$ENDIF}

procedure TEditInplace.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE;
end;

procedure TEditInplace.KeyDown(var Key: Word; Shift: TShiftState);
var
  AllowEndEdit: boolean;
begin
  AllowEndEdit := false;
  if Key in [VK_RETURN, VK_TAB, VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT] then begin
    case Key of
      VK_RETURN: AllowEndEdit := true;
      VK_UP:     AllowEndEdit := true;
      VK_DOWN:   AllowEndEdit := true;
      VK_LEFT:   AllowEndEdit := (SelLength = 0) and (SelStart = 0);
      VK_RIGHT:  AllowEndEdit := (SelLength = 0) and (SelStart >= length(Text));
      VK_TAB:    AllowEndEdit := goTabs in FCellEditor.Grid.Options
    end;
  end;

  if assigned(FCellEditor.AllowEndEditEvent) then
    FCellEditor.AllowEndEditEvent(self, Key, Shift, AllowEndEdit);
  if AllowEndEdit then begin
    DoExit;
    FCellEditor.SendGridKey(Key, Shift);
    Key := 0;
  end;
  if Key <> 0 then
    inherited KeyDown(Key, Shift);
end;

procedure TEditInplace.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if goTabs in FCellEditor.Grid.Options then
    Message.Result := Message.Result or DLGC_WANTTAB;
end;

procedure TEditInplace.KeyPress(var Key: Char);
begin
  if Key = #13 then begin
    FCellEditor.Grid.SetFocus;
    Key := #0;
  end
  else if Key = #9 then
    Key := #0;

  if Key <> #0 then
    inherited KeyPress(Key);
end;

procedure TEditInplace.DoExit;
begin
  FCellEditor.EndEdit;
  FCellEditor.Clear;
  inherited DoExit;
end;

procedure TEditInplace.CreateWnd;
begin
  inherited CreateWnd;
  if FCellEditor.grid <> nil then begin
    if FButton <> nil then
      FButton.Parent := FCellEditor.Grid;
    windows.SetParent(Handle, FCellEditor.Grid.Handle);
  end;
end;

constructor TEditInplace.Create(AOwner: TComponent; CellEditor: TCellEditor);
begin
  inherited Create(AOwner);
  FCellEditor := CellEditor;
  if TEditCellEditor(FCellEditor).FhasElipsis then begin
    FButton := TInplaceSpeedButton.Create(AOwner);
    with FButton do begin
      visible := false;
      TabStop := false;
      OnClick := TEditCellEditor(FCellEditor).FOnElipsisClick;
      Caption := TEditCellEditor(FCellEditor).FElipsisCaption;
    end;
  end;
  visible := false;
  Ctl3d := false;
  BorderStyle := bsNone;
  ParentCtl3D := False;
  TabStop := False;
end;

destructor TEditInplace.Destroy;
begin
  FButton.free;
  inherited;
end;

////////////////////////////////////////////////////////////////////////////////
// TEditCellEditor
//

procedure TEditCellEditor.Draw(Rect: TRect);
var
  R: TRect;
begin
  if FEditor = nil then
    exit;

  if FhasElipsis then
    Rect.Right := Rect.Right - Rect.Bottom + Rect.Top;

  inherited Draw(Rect);
  with FEditor do begin
    R := Classes.Rect(2, 2, Width - 2, Height);
    SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@R));
  end;

  if FhasElipsis then
    with TEditInplace(FEditor) do begin
      Button.left := Rect.right;
      Button.top := Rect.Top;
      Button.height := Rect.bottom - Rect.Top;
      Button.width := Rect.bottom - Rect.Top;
      Button.visible := true;
    end;
end;

procedure TEditCellEditor.Clear;
begin
  inherited Clear;
  if FhasElipsis then
    TEditInplace(FEditor).Button.visible := false;
end;

function TEditCellEditor.getElipsisCaption: string;
begin
  if FEditor = nil then
    result := FElipsisCaption
  else
    result := TEditInplace(FEditor).Button.Caption;
end;

procedure TEditCellEditor.setElipsisCaption(const Value: string);
begin
  if FEditor = nil then
    FElipsisCaption := Value
  else
    TEditInplace(FEditor).Button.Caption := Value;
end;

function TEditCellEditor.getOnElipsisClick: TNotifyEvent;
begin
  if FEditor = nil then
    result := FOnElipsisClick
  else
    result := TEditInplace(FEditor).Button.OnClick;
end;

procedure TEditCellEditor.setOnElipsisClick(const Value: TNotifyEvent);
begin
  if FEditor = nil then
    FOnElipsisClick := Value
  else
    TEditInplace(FEditor).Button.OnClick := Value;
end;

procedure TEditCellEditor.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation <> opRemove) or (FEditor = nil) then
    exit;

  if AComponent = TEditInplace(FEditor).Button then
    TEditInplace(FEditor).FButton := nil;
end;

function TEditCellEditor.InitEditor(AOwner: TComponent): TWinControl;
var
  Inplace: TEditInplace;
begin
  Inplace := TEditInplace.Create(AOwner, self);
  result := Inplace;

  if FhasElipsis then
    try
      if Inplace = nil then
        raise ECellEditorError.Create(StrCellEditorError);
       Inplace.FreeNotification(self);  // Notify me if FButton gets freed by someone
       if AOwner<>nil then
      (AOwner as TWinControl).InsertControl(Inplace.Button);
    except
      raise ECellEditorError.Create(StrCellEditorError);
    end;
end;

procedure TEditCellEditor.StartEdit;
var
  s: string;
begin
  inherited;

  with FEditor as TEditInplace do begin
    if GridLastChar <> 0 then begin
      Text := Char(GridLastChar);
      SelStart := 1;
      SelLength:= 0;
    end
    else
      Text := GetCellText;
  end;
end;

procedure TEditCellEditor.EndEdit;
begin
  if (FEditor <> nil) and (Grid <> nil) then
  begin
    SetCellText((FEditor as TEditInplace).Text);
  end;
  inherited;
end;

end.
