{******************************************************************************}
{                                                                              }
{       TExtStringGrid component.                                              }
{                                                                              }
{       版权所有 (C) 2005 NiceWolf                                             }
{                                                                              }
{       Email: axcom@163.com                                                   }
{******************************************************************************}
{   实现对StringGird控件的扩展：                                               }
{       + 列属性(顔色\对齐方式\字体\标题...)                                   }
{       + 单元格属性（顔色\字体\对齐方式）                                     }
{       + 支持多表头显示(类似DBGridEh的那种表头)                               }
{       + 任意单元格合并、拆分                                                 }
{       + 分组显示功能                                                         }
{       + 行、列锁定                                                           }
{       . 表格线满格显示                                                       }
{       . 行列Visible属性                                                      }
{       + 表格背景图片                                                         }
{       . 支持自动折行显示，可动态调整显示行高/列宽                            }
{       . 对每行数据提供状态管理(Modified,Inserted,Deleted,Unmodified)，可     }
{         帮助C/S类程序实现数据管理。                                          }
{       . 通过DynaFetchData,LoadData,OnFetchData,Update, 实现对Items类的处理   }
{       + 动态追加、插入、删除行列                                             }
{       + 数据排序显示                                                         }
{       . 数据行过滤显示;                                                      }
{       . 增强的单元格编辑器：Text,RichEdit,CheckBox,ComboBox,IntUpDn ...      }
{       . 单元格图片+文本显示(类似BitBtn显示)                                  }
{ + 表示已实现功能 . 为尚未完成功能                                            }
{******************************************************************************}
unit EStringGrid; {Extend StringGrid}

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
  contnrs;

type
  TColumnValue = (cvColor, cvWidth, cvFont, cvHAlignment, cvVAlignment,
    cvReadOnly,
    cvTitleCaption, cvTitleAlignment, cvTitleFont);
  TColumnValues = set of TColumnValue;

const
  ColumnTitleValues = [cvTitleCaption..cvTitleFont];

  StrCellEditorError: string = 'Cell Editor not of type TCellEditor';
  StrCellEditorAssigned: string = '%s is allready assigned to %s';

type
  EBlockOverlap = class(Exception);
  EOutOfRange = class(Exception);
  TExtHAlign = (a_left, a_center, a_right);
  TExtVAlign = (a_top, a_middle, a_bottom);
  TTextAttr = (EditControl, EndEllipsis, ExpandTabs);
  TTextAttrs = set of TTextAttr;

  TColumnFormat = (cfString, cfNumber, cfDate);

  TGridDataState = (gdsModified, gdsInserted, gdsDeleted, gdsUnmodified);

  TGridOptionEx = (sgoAppendRow, sgoInsertRow, sgoDeleteRow, sgoTitle3D,
    sgoFixed3D,
    sgoData3D, sgoEnterAsTab);
  TGridOptionsEx = set of TGridOptionEx;

  TGridUpdateEvent = procedure(Sender: TObject; ARow: integer; AState:
    TGridDataState) of object;

  TMouseEnterEvent = procedure(Sender: TObject; Shift: TShiftState; X, Y:
    Integer) of object;
  TMouseLeaveEvent = procedure(Sender: TObject; Shift: TShiftState; X, Y:
    Integer) of object;
  TMouseClickEvent = procedure(Sender: TObject; Button: TMouseButton; Shift:
    TShiftState;
    X, Y, CellX, CellY: Integer) of object;

  TAllowEndEditEvent = procedure(Sender: TObject; var Key: Word; Shift: TShiftState; var EndEdit: boolean) of object;

  TColumnProperties = class;
  TExtStringGrid = class;

  ECellEditorError = class(Exception);

  TCellEditor = class(TComponent)     // Base class for all cell editors
  private
    FGridLastChar: Integer;
    FDefaultText: string;
    FGrid: TExtStringGrid;
    FReferences: integer;
    FAllowEndEditEvent: TAllowEndEditEvent;
    function GetGrid: TExtStringGrid;
  protected
    procedure Attatch(AGrid: TExtStringGrid); virtual;
    procedure Detach; virtual;
    procedure GridWndDestroying; virtual;
    property DefaultText: String read FDefaultText write FDefaultText;
    property GridLastChar: Integer read FGridLastChar;
  public
    destructor destroy; override;
    procedure init; virtual;
    procedure StartEdit; virtual; abstract;
    procedure EndEdit; virtual; abstract;
    procedure Draw(Rect: TRect); virtual; abstract;
    procedure Clear; virtual; abstract;
    procedure SetCellText(Value: string); virtual;
    procedure SendGridKey(Key: Word; Shift: TShiftState);
    property Grid: TExtStringGrid read GetGrid;
    property References: integer read FReferences;
  published
    property AllowEndEditEvent: TAllowEndEditEvent read FAllowEndEditEvent write FAllowEndEditEvent;
  end;

  TWinControlInterface = class(TWinControl)
  public
    property Caption;           // This class gains access to otherwise
    property Color;             // protected members by a forced typecast.
    property Ctl3D;             // This allows a kind of a friend relationship.
    property DragCursor;
    property DragMode;
    property Font;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property Text;
  end;

  TMetaCellEditor = class(TCellEditor)  // Base class for meta components
  protected
    FEditor: TWinControl;
    procedure Attatch(AGrid: TExtStringGrid); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function InitEditor(AOwner: TComponent): TWinControl; virtual;
    function GetEditor: TWinControlInterface; virtual;
    procedure GridWndDestroying; override;
    procedure loaded; override;
  public
    destructor Destroy; override;
    function  GetCellText: string; virtual;
    procedure init; override;
    procedure StartEdit; override;
    procedure EndEdit; override;
    procedure Draw(Rect: TRect); override;
    procedure Clear; override;
    property Editor: TWinControlInterface read GetEditor;
  end;

  TColumnTitle = class(TPersistent)
  private
    FColumn: TColumnProperties;
    FCaption: string;
    FFont: TFont;
    FAlignment: TAlignment;
    procedure FontChanged(Sender: TObject);
    function GetAlignment: TAlignment;
    function GetCaption: string;
    function GetFont: TFont;
    function IsAlignmentStored: Boolean;
    function IsFontStored: Boolean;
    function IsCaptionStored: Boolean;
    procedure SetAlignment(Value: TAlignment);
    procedure SetFont(Value: TFont);
    procedure SetCaption(const Value: string); virtual;
  protected
    fMultiTitleHeights: array of integer;
    procedure RefreshDefaultFont;
  public
    constructor Create(Column: TColumnProperties);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function DefaultAlignment: TAlignment;
    function DefaultColor: TColor;
    function DefaultFont: TFont;
    function DefaultCaption: string;
    procedure RestoreDefaults; virtual;
  published
    property Alignment: TAlignment read GetAlignment write SetAlignment stored
      IsAlignmentStored;
    property Caption: string read GetCaption write SetCaption stored
      IsCaptionStored;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
  end;

  TColumnProperties = class(TCollectionItem)
  private
    FInternalCol: Longint;
    FColWidth: Integer; //保存隐藏前的宽度
    FAssignedValues: TColumnValues;
    FPopupMenu: TPopupMenu;
    FTitle: TColumnTitle;
    FGroupIndex: integer;
    Ffont: TFont;
    Fcolor: TColor;
    FHAlign: TAlignment;
    FVAlign: TTextLayout;
    FReadOnly: Boolean;
    FWordWrap: Boolean;
    FAutoRowHeight: Boolean;
    FAutoColWidth: Boolean;
    FEndEllipsis: Boolean;
    FVisible: Boolean;
    FEditor: TCellEditor;
    procedure FontChanged(Sender: TObject);
    function IsHAlignmentStored: Boolean;
    function IsVAlignmentStored: Boolean;
    function IsColorStored: Boolean;
    function IsFontStored: Boolean;
    function IsReadOnlyStored: Boolean;
    procedure Setfont(const Value: TFont);
    procedure Setcolor(const Value: TColor);
    procedure SetHAlign(const Value: TAlignment);
    procedure SetVAlign(const Value: TTextLayout);
    procedure SetTitle(const Value: TColumnTitle);
    function GetReadOnly: Boolean;
    procedure SetReadOnly(const Value: Boolean);
    procedure SetPopupMenu(const Value: TPopupMenu);
    procedure SetWidth(const Value: Integer);
    function GetWidth: Integer;
    procedure SetVisible(const Value: Boolean);
    procedure SetAutoColWidth(const Value: Boolean);
    procedure SetAutoRowHeight(const Value: Boolean);
    procedure SetWordWrap(const Value: Boolean);
    procedure SetEditor(const Value: TCellEditor);
  protected
    function GetGrid: TExtStringGrid;
    procedure RefreshDefaultFont;
  public
    parentfont, locked, parentcolor, parentalign: Boolean;
    FCellProps: TObjectList;
    constructor Create(Collection: TCollection); override;
    destructor destroy; override;
    procedure Clear;
    procedure Assign(Source: TPersistent); override;
    function DefaultHAlignment: TAlignment;
    function DefaultVAlignment: TTextLayout;
    function DefaultColor: TColor;
    function DefaultFont: TFont;
    function DefaultReadOnly: Boolean;
    function DefaultWidth: Integer;
    procedure RestoreDefaults; virtual;
    procedure ShowEditor(ARow: integer); virtual;
    property Grid: TExtStringGrid read GetGrid;
    property AssignedValues: TColumnValues read FAssignedValues;
  published
    property Editor: TCellEditor read FEditor write SetEditor;
    property Title: TColumnTitle read FTitle write SetTitle;
    property font: TFont read Ffont write Setfont stored IsFontStored;
    property color: TColor read Fcolor write Setcolor stored IsColorStored;
    property HAlign: TAlignment read FHAlign write SetHAlign stored
      IsHAlignmentStored;
    property VAlign: TTextLayout read FVAlign write SetVAlign stored
      IsVAlignmentStored;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly stored
      IsReadOnlyStored;
    property PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
    property InternalCol: LongInt read FInternalCol;
    property WordWrap: Boolean read FWordWrap write SetWordWrap;
    property EndEllipsis: Boolean read FEndEllipsis write FEndEllipsis;
    property Width: Integer read GetWidth write SetWidth;
    property GroupIndex: integer read FGroupIndex write FGroupIndex;
    property AutoRowHeight: Boolean read FAutoRowHeight write SetAutoRowHeight
      default False;
    property AutoColWidth: Boolean read FAutoColWidth write SetAutoColWidth
      default False;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  TColumnPropClass = class of TColumnProperties;

  TExtStringGridColumns = class(TCollection)
  private
    FGrid: TExtStringGrid;
    function GetColumn(Index: Integer): TColumnProperties;
    procedure SetColumn(Index: Integer; Value: TColumnProperties);
  protected
    function GetOwner: TPersistent; override; {D3}
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Grid: TExtStringGrid; ColumnClass: TColumnPropClass);
    function Add: TColumnProperties;
    property Grid: TExtStringGrid read FGrid;
    property Items[Index: Integer]: TColumnProperties read GetColumn write
      SetColumn; default;
  end;

  TLineProperties = class(TObject)
  private
  public
    Loaded: Boolean;
    State: TGridDataState;
    RowHeight: Integer; //保存隐藏前的高度
    constructor Create;
  end;

  TCellProperties = class(TObject)
  private
    FGrid: TExtStringGrid;
    Fcolor: TColor;
    FHAlign: TAlignment;
    FVAlign: TTextLayout;
    Ffont: TFont;
    FGroupBitmap: TBitmap;
    FGBitmapFresh: boolean;
    FEditor: TCellEditor;
    procedure Setcolor(const Value: TColor);
    procedure Setfont(const Value: TFont);
    procedure SetHAlign(const Value: TAlignment);
    procedure SetVAlign(const Value: TTextLayout);
    procedure OnFontChange(Sender: TObject);
    procedure SetEditor(const Value: TCellEditor);
  public
    locked, merged, grouped: boolean;
    parentfont, parentcolor, parentalign: boolean;
    block: TGridRect;
    constructor Create(AOwner: TExtStringGrid);
    destructor Destroy; override;
    procedure MakeBitmap;
    property font: TFont read Ffont write Setfont;
    property color: TColor read Fcolor write Setcolor;
    property GroupBitmap: TBitmap read FGroupBitmap;
    property HAlign: TAlignment read FHAlign write SetHAlign;
    property VAlign: TTextLayout read FVAlign write SetVAlign;
    property Editor: TCellEditor read FEditor write SetEditor;
  end;

  TFixedFont = class(TPersistent)
  private
    FFixedFont: TFont;
    FUseFixed: Boolean;
    FParentAlign: Boolean;
    FAlignHoriz: TAlignment;
    FAlignVert: TTextLayout;
    procedure SetAlignHoriz(const Value: TAlignment);
    procedure SetAlignVert(const Value: TTextLayout);
    procedure SetFont(const Value: TFont);
  protected
    {}
  public
    constructor Create;
    destructor Destroy; override;
  published
    property FixedFont: TFont read FFixedFont write SetFont;
    property UseFixedFont: Boolean read FUseFixed write FUseFixed;
    property ParentAlign: Boolean read FParentAlign write FParentAlign;
    property AlignHoriz: TAlignment read FAlignHoriz write SetAlignHoriz;
    property AlignVert: TTextLayout read FAlignVert write SetAlignVert;
  end;

  TLockedCell = class(TPersistent)
  private
    FBackColor: TColor;
    FFont: TFont;
    FUseLockedFont: Boolean;
    procedure SetBackColor(const Value: TColor);
    procedure SetForeColor(const Value: TColor);
    function GetForeColor: TColor;
    procedure SetUseLockedFont(const Value: Boolean);
    procedure SetFont(const Value: TFont);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(const Source: TLockedCell); reintroduce;
  published
    property ForeColor: TColor read GetForeColor write SetForeColor;
    property BackColor: TColor read FBackColor write SetBackColor;
    property LockedFont: TFont read FFont write SetFont;
    property UseLockedFont: Boolean read FUseLockedFont write
      SetUseLockedFont;
  end;

  TDrawEditorEvent = procedure (Sender: TObject; ACol, ARow: Longint; Editor: TCellEditor) of object;

  TCompareProc = function(Sender: TExtStringGrid; SortCol, row1, row2: integer):
    Integer;
  TSwapProc = procedure(Sender: TExtStringGrid; SortCol, row1, row2: integer);

  TExtStringGrid = class(TStringGrid)
  private
    FLastChar: integer;
    FLayoutFlag: integer;
    FBGImage: TBitmap;
    FBeforeInsert: TNotifyEvent;
    FBeforeDelete: TNotifyEvent;
    FOnUserChanged: TNotifyEvent;
    FOptionsEx: TGridOptionsEx;
    FCachedUpdates: Boolean;
    FLineProps: TObjectList;
    FUseMultiTitle: Boolean;
    FOnCancelUpdate: TGridUpdateEvent;
    FOnUpdateRecord: TGridUpdateEvent;
    FFixedLineColor: TColor;
    FGridLineColor: TColor;
    FSelectedTextColor: TColor;
    FSelectedColor: TColor;
    FTitleColor: TColor;
    { Private declarations }
    FOnMouseEnter: TMouseEnterEvent;
    FOnMouseLeave: TMouseLeaveEvent;
    FCurrentCol, FCurrentRow: Integer;
    FEditingCol, FEditingRow: integer;
    FFixedFont: TFixedFont;
    FTextHAlign: TAlignment;
    FTextVAlign: TTextLayout;
    FOnCellClick: TMouseClickEvent;
    FOnFixedCellClick: TMouseClickEvent;
    FLockedCell: TLockedCell;
    FOnAfterDrawCell: TDrawCellEvent;
    FPaintLock: integer;
    FColumnProps: TExtStringGridColumns;
    FTextOptions: TTextAttrs;
    FOnBeforeDrawCell: TDrawCellEvent;
    FOnDrawEditor: TDrawEditorEvent;
    function GetLineProps(ARow: integer): TLineProperties;
    function GetCellProps(ACol, ARow: integer): TCellProperties;
    function GetCellColor(ACol, ARow: integer): TColor;
    function GetCellFont(ACol, ARow: integer): TFont;
    function GetCellLocked(ACol, ARow: integer): boolean;
    procedure SetCellColor(ACol, ARow: integer; const Value: TColor);
    procedure SetCellFont(ACol, ARow: integer; const Value: TFont);
    procedure SetCellLocked(ACol, ARow: integer; const Value: boolean);
    procedure CheckIndexRange(Acol, ARow: integer);
    function GetCellHAlignment(ACol, ARow: integer): TAlignment;
    function GetCellVAlignment(ACol, ARow: integer): TTextLayout;
    procedure SetAlignHoriz(const Value: TAlignment);
    procedure SetAlignVert(const Value: TTextLayout);
    procedure SetCellHAlignment(ACol, ARow: integer;
      const Value: TAlignment);
    procedure SetCellVAlignment(ACol, ARow: integer;
      const Value: TTextLayout);
    procedure SetOnCellClick(const Value: TMouseClickEvent);
    procedure SetOnFixedCellClick(const Value: TMouseClickEvent);
    procedure SetColCount(const Value: Integer);
    procedure SetRowCount(const Value: Integer);
    function GetRowCount: integer;
    function GetColCount: Integer;
    procedure SetOnAfterDrawCell(const Value: TDrawCellEvent);
    procedure SetTextOptions(const Value: TTextAttrs);
    procedure SetOnBeforeDrawCell(const Value: TDrawCellEvent);
    procedure SetLockedCell(const Value: TLockedCell);
    function GetColumnProps(Index: integer): TColumnProperties;
    function ResizeGroupBitmap(CellProps: TCellProperties): TRect;
    procedure CopyGroup(ACol, ARow: longint; mRect: TRect;
      GroupProp: TCellProperties);
    function MakeCellProp(ACol, ARow: LongInt): TCellProperties;
    procedure QuickSort(col, bottom, top: integer; compare: TCompareProc; swap:
      TSwapProc);
    function GetSelectedIndex: Integer;
    procedure DrawBackground(rect: TRect; AState: TGridDrawState);
    procedure SetSelectedIndex(const Value: Integer);
    procedure SetColumnCount(NewCount: LongInt);
    procedure SetColumns(const Value: TExtStringGridColumns);
    procedure SetBGImage(newImg: TBitmap);
    procedure SetCachedUpdates(const Value: Boolean);
    procedure SetUseMultiTitle(const Value: Boolean);
    procedure SetFixedLineColor(const Value: TColor);
    procedure SetGridLineColor(const Value: TColor);
    procedure SetSelectedColor(const Value: TColor);
    procedure SetSelectedTextColor(const Value: TColor);
    procedure SetFixedFont(const Value: TFixedFont);
    procedure SetFTitleColor(const Value: TColor);
    procedure SetOptionsEx(const Value: TGridOptionsEx);
  protected
    FCellEditor: TCellEditor;
    fMultiTitleHeight: integer;
    function CreateColumns: TExtStringGridColumns; dynamic;
    procedure SizeChanged(OldColCount, OldRowCount: Longint); override;
    procedure CalcTitleHeight;
    { Protected declarations }
    procedure DrawCell(ACol, ARow: Longint; mRect: TRect;
      AState: TGridDrawState); override;
    function MouseCoord(X, Y: Integer): TGridCoord;
    function CanEditModify: Boolean; override;
    function CanEditShow: Boolean; override;
    procedure TopLeftChanged; override;
    procedure DrawEditor(ACol, ARow: integer); virtual;
    procedure MouseDown(Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
    procedure DestroyWnd; override;
    procedure WMCommand(var Message: TWMCommand); message WM_COMMAND;
    procedure WMChar(var Msg: TWMChar); message WM_CHAR;
    procedure Paint; override;
    { Event triggers: }
    procedure TriggerMouseEnterEvent(Shift: TShiftState; X, Y: Integer);
      virtual;
    procedure TriggerMouseLeaveEvent(Shift: TShiftState; X, Y: Integer);
      virtual;
    function SelectCell(ACol, ARow: Longint): Boolean; override;
    procedure ColumnMoved(FromIndex, ToIndex: LongInt); override;
    procedure RowMoved(FromIndex, ToIndex: LongInt); override;
    procedure ColWidthsChanged; override;
    procedure RowHeightsChanged; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DefaultHandler(var Msg); override;
    procedure Clear;
    procedure ClearColumnProps;
    procedure GroupCells(left, top, right, bottom: integer);
    procedure UngroupCells(ACol, ARow: integer);
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure LockPaint; // provides a way to stop painting
    procedure UnlockPaint;
    procedure Update; override;
    procedure CancelUpdates;
    procedure AppendRow;
    procedure InsertRow(ARow: LongInt);
    procedure DeleteRow(ARow: LongInt); override;
    procedure Sort(Col: Integer); overload;
    procedure Sort(Col: integer; compare: TCompareProc; swap: TSwapProc); overload;
    property CellEditor: TCellEditor read FCellEditor;
    property LineProperties[ARow: integer]: TLineProperties read
    GetLineProps;
    property CellProperties[ACol, ARow: integer]: TCellProperties read
    GetCellProps;
    property CellFont[ACol, ARow: integer]: TFont read GetCellFont write
    SetCellFont;
    property CellLocked[ACol, ARow: integer]: boolean read GetCellLocked
    write SetCellLocked;
    property CellColor[ACol, ARow: integer]: TColor read GetCellColor write
    SetCellColor;
    property CellHAlignment[ACol, ARow: integer]: TAlignment read
    GetCellHAlignment write SetCellHAlignment;
    property CellVAlignment[ACol, ARow: integer]: TTextLayout read
    GetCellVAlignment write SetCellVAlignment;
    property ColumnProperties[Index: integer]: TColumnProperties read
    GetColumnProps;
    property SelectedIndex: Integer read GetSelectedIndex write
      SetSelectedIndex;
  published
    { Published properties and events }
    property Ctl3D;
    property Columns: TExtStringGridColumns read FColumnProps write SetColumns;
    property BGImage: TBitmap read fBGImage write SetBGImage;
    property UseMultiTitle: Boolean read FUseMultiTitle write SetUseMultiTitle;
    property CachedUpdates: Boolean read FCachedUpdates write SetCachedUpdates;
    property FixedLineColor: TColor read FFixedLineColor write
      SetFixedLineColor;
    property GridLineColor: TColor read FGridLineColor write SetGridLineColor
      default clSilver;
    property SelectedColor: TColor read FSelectedColor write SetSelectedColor
      default clHighlight;
    property SelectedTextColor: TColor read FSelectedTextColor write
      SetSelectedTextColor default clHighlightText;
    property TitleColor: TColor read FTitleColor write SetFTitleColor;
    property LastChar: Integer read FLastChar write FLastChar;

    // default cell horiz & vert alignment
    property AlignHoriz: TAlignment read FTextHAlign write SetAlignHoriz;
    property AlignVert: TTextLayout read FTextVAlign write SetAlignVert;
    property ColCount read GetColCount write SetColCount;
    property RowCount read GetRowCount write SetRowCount;
    property LockedCell: TLockedCell read FLockedCell write SetLockedCell;
    property OptionsEx: TGridOptionsEx read FOptionsEx write SetOptionsEx default
      [sgoTitle3D, sgoFixed3D];
    property FixedFont: TFixedFont read FFixedFont write SetFixedFont;

    property OnCancelUpdate: TGridUpdateEvent read FOnCancelUpdate write
      FOnCancelUpdate;
    property OnUpdateRecord: TGridUpdateEvent read FOnUpdateRecord write
      FOnUpdateRecord;
    property BeforeDelete: TNotifyEvent read FBeforeDelete write FBeforeDelete;
    property BeforeInsert: TNotifyEvent read FBeforeInsert write FBeforeInsert;
    property OnUserChanged: TNotifyEvent read FOnUserChanged write
      FOnUserChanged;
    property TextOptions: TTextAttrs read FTextOptions write SetTextOptions;
    property OnMouseEnter: TMouseEnterEvent read FOnMouseEnter write
      FOnMouseEnter;
    property OnMouseLeave: TMouseLeaveEvent read FOnMouseLeave write
      FOnMouseLeave;
    property OnFixedCellClick: TMouseClickEvent read FOnFixedCellClick write
      SetOnFixedCellClick;
    property OnCellClick: TMouseClickEvent read FOnCellClick write
      SetOnCellClick;
    property OnAfterDrawCell: TDrawCellEvent read FOnAfterDrawCell write
      SetOnAfterDrawCell;
    property OnBeforeDrawCell: TDrawCellEvent read FOnBeforeDrawCell write
      SetOnBeforeDrawCell;
    property OnDrawEditor: TDrawEditorEvent read FOnDrawEditor write FOnDrawEditor;
  end;

implementation

type
  TWinControlCracker = class(TWinControl);

function WriteText(ACanvas: TCanvas; // Canvas
  ARect: TRect; // Draw rect and ClippingRect
  FillRect: Boolean; // Fill rect Canvas.Brash.Color
  DX, DY: Integer; // InflateRect(Rect, -DX, -DY) for text
  Text: string; // Draw text
  Alignment: TAlignment; // Text alignment
  Layout: TTextLayout; // Text layout
  MultyL: Boolean; // Word break
  EndEllipsis: Boolean; // Truncate long text by ellipsis
  LeftMarg, // Left margin
  RightMarg: Integer; // Right margin
  RightToLeftReading: Boolean;
  CalcHeight: Boolean = False): Integer;
const
  AlignFlags: array[TAlignment] of Integer =
  (DT_LEFT or DT_EXPANDTABS or DT_NOPREFIX,
    DT_RIGHT or DT_EXPANDTABS or DT_NOPREFIX,
    DT_CENTER or DT_EXPANDTABS or DT_NOPREFIX);
  RTL: array[Boolean] of Integer = (0, DT_RTLREADING);
var
  rect1: TRect;
  txth, DrawFlag, Left, TextWidth: Integer;
  lpDTP: TDrawTextParams;
  B: TRect;
begin
  if (FillRect = True) then
    ACanvas.FillRect(ARect);

  DrawFlag := 0;
  if (MultyL = True) then
    DrawFlag := DrawFlag or DT_WORDBREAK;
  if (EndEllipsis = True) then
    DrawFlag := DrawFlag or DT_END_ELLIPSIS;
  DrawFlag := DrawFlag or AlignFlags[Alignment];

  rect1.Left := 0;
  rect1.Top := 0;
  rect1.Right := 0;
  rect1.Bottom := 0;
  rect1 := ARect;

  lpDTP.cbSize := SizeOf(lpDTP);
  lpDTP.uiLengthDrawn := Length(Text);
  lpDTP.iLeftMargin := LeftMarg;
  lpDTP.iRightMargin := RightMarg;

  InflateRect(rect1, -DX, -DY);

  if (Layout <> tlTop) {and (MultyL = True)} then
    txth := DrawTextEx(ACanvas.Handle, PChar(Text), Length(Text),
      rect1, DrawFlag or DT_CALCRECT, @lpDTP)
  else
    txth := 0;
  rect1 := ARect;
  InflateRect(rect1, -DX, -DY);

  case Layout of
    tlTop: ;
    tlBottom: rect1.top := rect1.Bottom - txth;
    tlCenter: rect1.top := rect1.top + ((rect1.Bottom - rect1.top) div 2) - (txth
      div 2);
  end;

  if DX > 0 then
    rect1.Bottom := rect1.Bottom + 1;
  if CalcHeight then
    DrawFlag := DrawFlag or DT_CALCRECT;
  Result := DrawTextEx(ACanvas.Handle, PChar(Text), Length(Text), rect1,
    DrawFlag, @lpDTP);
end;

function CompareProc(Sender: TExtStringGrid; SortCol, row1, row2: integer):
  Integer;
begin
  with Sender do
  begin
    result := AnsiCompareStr(Cells[SortCol, row1], Cells[SortCol, row2]);
    if result <> 0 then
    begin
      // Put empty cells to the back
      if (Cells[SortCol, row1] = '') then
        result := 1
      else if (Cells[SortCol, row2] = '') then
        result := -1
    end
    else
      // Force a decision -> stability!
      result := row1 - row2;
  end;
end;

procedure SwapProc(Sender: TExtStringGrid; SortCol, row1, row2: integer);
var
  s: string;
  o: TObject;
begin
  with Sender do
  begin
    s := Cells[SortCol, row1];
    o := Objects[SortCol, row1];
    Cells[SortCol, row1] := Cells[SortCol, row2];
    Objects[SortCol, row1] := Objects[SortCol, row2];
    Cells[SortCol, row2] := s;
    Objects[SortCol, row2] := o;
  end;
end;

procedure LSwapProc(Sender: TExtStringGrid; ColCount, row1, row2: integer);
var
  s: string;
  o: TObject;
  i: Integer;
begin
  for i:=0 to ColCount-1 do
    SwapProc(Sender,i,row1, row2);
  with Sender do
  begin
    //LineProperties[];
  end;
end;

{ TCellEditor }

destructor TCellEditor.destroy;
var
  c: integer;
begin
  if Grid <> nil then
    with Grid do
      if Columns <> nil then
        for c := 0 to Columns.count - 1 do
          if Columns[c].Editor = self then         // Remove references to this instance
            Columns[c].Editor := nil;

  inherited destroy;
end;

procedure TCellEditor.init;
begin
  // empty
end;

function TCellEditor.GetGrid: TExtStringGrid;
begin
  result := FGrid;
end;

procedure TCellEditor.Attatch(AGrid: TExtStringGrid);
begin
  if AGrid = FGrid then begin
    Inc(FReferences);
    exit;
  end;

  if FGrid <> nil then
    raise ECellEditorError.Create(Format(StrCellEditorAssigned, [Name, FGrid.Name]));

  FGrid := AGrid;
  Inc(FReferences);
end;

procedure TCellEditor.Detach;
begin
  Dec(FReferences);
  if FReferences = 0 then
    FGrid := nil;
end;

procedure TCellEditor.GridWndDestroying;
begin
end;

procedure TCellEditor.SetCellText(Value: string);
begin
  with Grid do
    SetEditText(FEditingCol, FEditingRow, Value);
end;

procedure TCellEditor.SendGridKey(Key: Word; Shift: TShiftState);
begin
  Grid.KeyDown(Key, Shift);
  Grid.SetFocus;
end;

{ TMetaCellEditor }

procedure TMetaCellEditor.loaded;
begin
  inherited loaded;
  Init;
end;

destructor TMetaCellEditor.Destroy;
begin
  FEditor.free;            // FEdit propably set to nil by notification
  inherited Destroy;       // method. So FEdit has been freed already
end;

procedure TMetaCellEditor.init;
begin
  if csDesigning in ComponentState then
    FEditor := nil
  else begin
    try
      FEditor := InitEditor(Owner);
      if FEditor = nil then
        raise ECellEditorError.Create(StrCellEditorError);

      FEditor.FreeNotification(self);  // Notify me if FEditor gets freed by someone
      if Owner<>nil then
        (Owner as TWinControl).InsertControl(FEditor);
    except
      raise ECellEditorError.Create(StrCellEditorError);
    end;
  end;
end;

procedure TMetaCellEditor.Draw(Rect: TRect);
begin
  if FEditor = nil then
    exit;

  with FEditor do begin
    left := Rect.left;
    top := Rect.top;
    width := Rect.right - Rect.left;
    height := Rect.bottom - Rect.top;
    visible := true;
    SetFocus;
  end;
end;

procedure TMetaCellEditor.Clear;
begin
  FEditor.visible := false;
  Grid.FCellEditor := nil;         // Private fields in same unit are friends,
end;                               // so I can accss this here

procedure TMetaCellEditor.Attatch(AGrid: TExtStringGrid);
begin
  inherited Attatch(AGrid);
  if not (csDesigning in ComponentState) and (FEditor <> nil) and (Grid <> nil) then
    windows.SetParent(FEditor.Handle, Grid.Handle);
end;

procedure TMetaCellEditor.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation <> opRemove) or (FEditor = nil) then
    exit;

  if FEditor.ClassName = AComponent.ClassName then
    FEditor := nil;
end;

function TMetaCellEditor.InitEditor(AOwner: TComponent): TWinControl;
begin
  result := nil;
end;

function TMetaCellEditor.GetEditor: TWinControlInterface;
begin
  result := TWinControlInterface(FEditor);
end;

procedure TMetaCellEditor.GridWndDestroying;
begin
  if FEditor <> nil then
    TWinControlCracker(FEditor).DestroyWnd;
end;

function TMetaCellEditor.GetCellText: string;
begin
  with Grid do
  begin
    Result := GetEditText(FEditingCol, FEditingRow);
    if Result='' then Result := DefaultText;
  end;
end;

procedure TMetaCellEditor.EndEdit;
begin
  Grid.FLastChar := 0;
end;

procedure TMetaCellEditor.StartEdit;
begin
  if (FEditor = nil) or (Grid = nil) then
    init;
end;

{ TCellProperties }

constructor TCellProperties.create(AOwner: TExtStringGrid);
begin
  FGrid := AOwner;
  locked := false;
  merged := false;
  grouped := false;
  parentfont := true;
  parentcolor := true;
  parentalign := true;
  ffont := TFont.Create;
  Ffont.OnChange := OnFontChange;
  fvalign := tlTop;
  fhalign := taLeftJustify;
  FGroupBitmap := nil;
  FEditor := nil;
end;

destructor TCellProperties.destroy;
begin
  ffont.Free;
  if Assigned(FGroupBitmap) then
    FGroupBitmap.free;
  inherited;
end;

procedure TCellProperties.MakeBitmap;
begin
  if not Assigned(FGroupBitmap) then
    FGroupBitmap := TBitmap.Create;
  FGBitmapFresh := false;
end;

procedure TCellProperties.OnFontChange(Sender: TObject);
begin
  parentfont := False;
end;

procedure TCellProperties.Setcolor(const Value: TColor);
begin
  Fcolor := Value;
  parentcolor := false;
end;

procedure TCellProperties.SetEditor(const Value: TCellEditor);
begin
  if FEditor = Value then
    exit;

  if Value <> nil then
    Value.Attatch(FGrid);
  if FEditor <> nil then
    FEditor.Detach;

  FEditor := Value;
end;

procedure TCellProperties.Setfont(const Value: TFont);
begin
  Ffont.assign(Value);
  parentfont := false;
end;

procedure TCellProperties.SetHAlign(const Value: TAlignment);
begin
  FHAlign := Value;
  parentalign := false;
end;

procedure TCellProperties.SetVAlign(const Value: TTextLayout);
begin
  FVAlign := Value;
  parentalign := false;
end;

{ TColumnTitle }

constructor TColumnTitle.Create(Column: TColumnProperties);
begin
  inherited Create;
  FColumn := Column;
  FFont := TFont.Create;
  FFont.Assign(DefaultFont);
  FFont.OnChange := FontChanged;
end;

destructor TColumnTitle.Destroy;
begin
  FFont.Free;
  inherited Destroy;
end;

procedure TColumnTitle.Assign(Source: TPersistent);
begin
  if Source is TColumnTitle then
  begin
    if cvTitleAlignment in TColumnTitle(Source).FColumn.FAssignedValues then
      Alignment := TColumnTitle(Source).Alignment;
    {    if cvTitleColor in TColumnTitle(Source).FColumn.FAssignedValues then
          Color := TColumnTitle(Source).Color;}
    if cvTitleCaption in TColumnTitle(Source).FColumn.FAssignedValues then
      Caption := TColumnTitle(Source).Caption;
    if cvTitleFont in TColumnTitle(Source).FColumn.FAssignedValues then
      Font := TColumnTitle(Source).Font;
  end
  else
    inherited Assign(Source);
end;

function TColumnTitle.DefaultAlignment: TAlignment;
begin
  Result := taLeftJustify;
end;

function TColumnTitle.DefaultColor: TColor;
var
  Grid: TExtStringGrid;
begin
  Grid := FColumn.GetGrid;
  if Assigned(Grid) then
    Result := Grid.FixedColor
  else
    Result := clBtnFace;
end;

function TColumnTitle.DefaultFont: TFont;
var
  Grid: TExtStringGrid;
begin
  Grid := FColumn.GetGrid;
  if Assigned(Grid) then
    Result := Grid.font //Grid.TitleFont
  else
    Result := FColumn.Font;
end;

function TColumnTitle.DefaultCaption: string;
begin
  Result := '';
end;

procedure TColumnTitle.FontChanged(Sender: TObject);
begin
  Include(FColumn.FAssignedValues, cvTitleFont);
  FColumn.Changed(True);
end;

function TColumnTitle.GetAlignment: TAlignment;
begin
  if cvTitleAlignment in FColumn.FAssignedValues then
    Result := FAlignment
  else
    Result := DefaultAlignment;
end;

function TColumnTitle.GetCaption: string;
begin
  if cvTitleCaption in FColumn.FAssignedValues then
    Result := FCaption
  else
    Result := DefaultCaption;
end;

function TColumnTitle.GetFont: TFont;
var
  Save: TNotifyEvent;
  Def: TFont;
begin
  if not (cvTitleFont in FColumn.FAssignedValues) then
  begin
    Def := DefaultFont;
    if (FFont.Handle <> Def.Handle) or (FFont.Color <> Def.Color) then
    begin
      Save := FFont.OnChange;
      FFont.OnChange := nil;
      FFont.Assign(DefaultFont);
      FFont.OnChange := Save;
    end;
  end;
  Result := FFont;
end;

function TColumnTitle.IsAlignmentStored: Boolean;
begin
  Result := (cvTitleAlignment in FColumn.FAssignedValues) and
    (FAlignment <> DefaultAlignment);
end;

function TColumnTitle.IsFontStored: Boolean;
begin
  Result := (cvTitleFont in FColumn.FAssignedValues);
end;

function TColumnTitle.IsCaptionStored: Boolean;
begin
  Result := (cvTitleCaption in FColumn.FAssignedValues) and
    (FCaption <> DefaultCaption);
end;

procedure TColumnTitle.RefreshDefaultFont;
var
  Save: TNotifyEvent;
begin
  if (cvTitleFont in FColumn.FAssignedValues) then
    Exit;
  Save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    FFont.Assign(DefaultFont);
  finally
    FFont.OnChange := Save;
  end;
end;

procedure TColumnTitle.RestoreDefaults;
var
  FontAssigned: Boolean;
begin
  FontAssigned := cvTitleFont in FColumn.FAssignedValues;
  FColumn.FAssignedValues := FColumn.FAssignedValues - ColumnTitleValues;
  FCaption := '';
  RefreshDefaultFont;
  FColumn.Changed(FontAssigned);
end;

procedure TColumnTitle.SetAlignment(Value: TAlignment);
begin
  if (cvTitleAlignment in FColumn.FAssignedValues) and (Value = FAlignment) then
    Exit;
  FAlignment := Value;
  Include(FColumn.FAssignedValues, cvTitleAlignment);
  FColumn.Changed(False);
end;

procedure TColumnTitle.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
  if FColumn.Grid.UseMultiTitle then
    FColumn.Grid.CalcTitleHeight;
end;

procedure TColumnTitle.SetCaption(const Value: string);
begin
  if (cvTitleCaption in FColumn.FAssignedValues) and (Value = FCaption) then
    Exit;
  FCaption := Value;
  if FColumn.Grid.UseMultiTitle then
    FColumn.Grid.CalcTitleHeight;
  Include(FColumn.FAssignedValues, cvTitleCaption);
  FColumn.Changed(False);
end;

{ TColumnProperties }

procedure TColumnProperties.Assign(Source: TPersistent);
begin
  if Source is TColumnProperties then
  begin
    if Assigned(Collection) then
      Collection.BeginUpdate;
    try
      RestoreDefaults;
      if cvColor in TColumnProperties(Source).AssignedValues then
        Color := TColumnProperties(Source).Color;
      if cvFont in TColumnProperties(Source).AssignedValues then
        Font := TColumnProperties(Source).Font;
      if cvHAlignment in TColumnProperties(Source).AssignedValues then
        HAlign := TColumnProperties(Source).HAlign;
      if cvVAlignment in TColumnProperties(Source).AssignedValues then
        VAlign := TColumnProperties(Source).VAlign;
      if cvReadOnly in TColumnProperties(Source).AssignedValues then
        ReadOnly := TColumnProperties(Source).ReadOnly;
      Title := TColumnProperties(Source).Title;
      PopupMenu := TColumnProperties(Source).PopupMenu;
    finally
      if Assigned(Collection) then
        Collection.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TColumnProperties.Clear;
begin
  Color := clWindow;
  HAlign := taLeftJustify;
  VAlign := tlTop;
  locked := False;
  Width := 64;
  parentcolor := True;
  parentfont := True;
  parentalign := True;
  if Assigned(FCellProps) then
  begin
    FCellProps.Free;
    FCellProps := nil;
  end;
end;

constructor TColumnProperties.create;
var
  Grid: TExtStringGrid;
begin
  Grid := nil;
  if Assigned(Collection) and (Collection is TExtStringGridColumns) then
    Grid := TExtStringGridColumns(Collection).Grid;
  try
    inherited Create(Collection);
    FVisible := True;
    FTitle := TColumnTitle.Create(Self);
    FFont := TFont.Create;
    FFont.Assign(DefaultFont);
    FFont.OnChange := FontChanged;
    FCellProps := nil;
    Clear;
  finally
    if (Grid <> nil) then
    begin
      grid.setcolumncount(Grid.columns.count);
      if not (csDesigning in Grid.ComponentState) then
        FInternalCol := Grid.columns.count - 1;
    end;
  end;
end;

function TColumnProperties.DefaultHAlignment: TAlignment;
begin
  Result := taLeftJustify;
end;

function TColumnProperties.DefaultVAlignment: TTextLayout;
begin
  Result := tlTop;
end;

function TColumnProperties.DefaultColor: TColor;
var
  Grid: TExtStringGrid;
begin
  Grid := GetGrid;
  if Assigned(Grid) then
    Result := Grid.Color
  else
    Result := clWindow;
end;

function TColumnProperties.DefaultFont: TFont;
var
  Grid: TExtStringGrid;
begin
  Grid := GetGrid;
  if Assigned(Grid) then
    Result := Grid.Font
  else
    Result := FFont;
end;

function TColumnProperties.DefaultReadOnly: Boolean;
var
  Grid: TExtStringGrid;
begin
  Grid := GetGrid;
  if Assigned(Grid) then
    Result := not (goEditing in Grid.options)
  else
    Result := true;
end;

function TColumnProperties.DefaultWidth: Integer;
begin
  if GetGrid = nil then
  begin
    Result := 64;
    Exit;
  end;
  with GetGrid do
  begin
    Result := DefaultColWidth;
  end;
end;

destructor TColumnProperties.destroy;
begin
  FTitle.Free;
  FFont.Free;
  if Assigned(FCellProps) then
    FCellProps.Free;
  with Grid do
    if FLayoutFlag = 0 then
      SetColumnCount(ColCount - 1);
  inherited;
end;

procedure TColumnProperties.FontChanged(Sender: TObject);
begin
  Title.RefreshDefaultFont;
  Changed(False);
end;

function TColumnProperties.GetGrid: TExtStringGrid;
begin
  if Assigned(Collection) and (Collection is TExtStringGridColumns) then
    Result := TExtStringGridColumns(Collection).Grid
  else
    Result := nil;
end;

function TColumnProperties.GetReadOnly: Boolean;
begin
  if cvReadOnly in FAssignedValues then
    Result := FReadOnly
  else
    Result := DefaultReadOnly;
end;

function TColumnProperties.IsColorStored: Boolean;
begin
  Result := (cvColor in FAssignedValues) and (FColor <> DefaultColor);
end;

function TColumnProperties.IsFontStored: Boolean;
begin
  Result := (cvFont in FAssignedValues);
end;

function TColumnProperties.IsHAlignmentStored: Boolean;
begin
  Result := (cvHAlignment in FAssignedValues) and (HAlign <> DefaultHAlignment);
end;

function TColumnProperties.IsVAlignmentStored: Boolean;
begin
  Result := (cvVAlignment in FAssignedValues) and (VAlign <> DefaultVAlignment);
end;

function TColumnProperties.IsReadOnlyStored: Boolean;
begin
  Result := (cvReadOnly in FAssignedValues) and (FReadOnly <> DefaultReadOnly);
end;

procedure TColumnProperties.RefreshDefaultFont;
var
  Save: TNotifyEvent;
begin
  if cvFont in FAssignedValues then
    Exit;
  Save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    FFont.Assign(DefaultFont);
  finally
    FFont.OnChange := Save;
  end;
end;

procedure TColumnProperties.RestoreDefaults;
var
  FontAssigned: Boolean;
begin
  FontAssigned := cvFont in FAssignedValues;
  FTitle.RestoreDefaults;
  FAssignedValues := [];
  RefreshDefaultFont;
  Changed(FontAssigned);
end;

procedure TColumnProperties.Setcolor(const Value: TColor);
begin
  Fcolor := Value;
  Include(FAssignedValues, cvColor);
  Changed(False);
  parentcolor := False;
end;

procedure TColumnProperties.Setfont(const Value: TFont);
begin
  Ffont.Assign(Value);
  Include(FAssignedValues, cvFont);
  Changed(False);
  parentfont := False;
end;

procedure TColumnProperties.SetHAlign(const Value: TAlignment);
begin
  FHAlign := Value;
  Include(FAssignedValues, cvHAlignment);
  Changed(False);
  parentalign := False;
end;

procedure TColumnProperties.SetReadOnly(const Value: Boolean);
begin
  if (cvReadOnly in FAssignedValues) and (Value = FReadOnly) then
    Exit;
  FReadOnly := Value;
  Include(FAssignedValues, cvReadOnly);
  Changed(False);
end;

procedure TColumnProperties.SetTitle(const Value: TColumnTitle);
begin
  FTitle.Assign(Value);
end;

procedure TColumnProperties.SetVAlign(const Value: TTextLayout);
begin
  FVAlign := Value;
  Include(FAssignedValues, cvVAlignment);
  Changed(False);
  parentalign := False;
end;

procedure TColumnProperties.SetPopupMenu(const Value: TPopupMenu);
begin
  FPopupMenu := Value;
  if Value <> nil then
    Value.FreeNotification(GetGrid);
end;

function TColumnProperties.GetWidth: Integer;
begin
  Result := {FColWidth} Grid.ColWidths[Index];
end;

procedure TColumnProperties.SetWidth(const Value: Integer);
begin
  FColWidth := Value;
  if Grid.ColWidths[Index] = Value then
    exit;
  if Visible then
  begin
    Grid.ColWidths[Index] := Value;
    //if Grid.UseMultiTitle and Assigned(Grid.Parent) and (Value > 0) then
    //  Grid.CalcTitleHeight;
  end;
end;

procedure TColumnProperties.SetVisible(const Value: Boolean);
begin
  if FVisible = Value then
    exit;
  FVisible := Value;
  if not (csDesigning in Grid.ComponentState) then
    if FVisible then
    begin
      Grid.ColWidths[Index] := FColWidth;
    end
    else
    begin
      FColWidth := Grid.ColWidths[Index];
      Grid.ColWidths[Index] := -1;
    end;
  Changed(False);
end;

procedure TColumnProperties.SetAutoRowHeight(const Value: Boolean);
begin
  FAutoRowHeight := Value;
end;

procedure TColumnProperties.SetAutoColWidth(const Value: Boolean);
begin
  FAutoColWidth := Value;
  FWordWrap := not FAutoColWidth;
end;

procedure TColumnProperties.SetWordWrap(const Value: Boolean);
begin
  FWordWrap := Value;
  FAutoColWidth := not FWordWrap;
end;

procedure TColumnProperties.SetEditor(const Value: TCellEditor);
begin
  if FEditor = Value then
    exit;

  if Value <> nil then
    Value.Attatch(Grid);
  if FEditor <> nil then
    FEditor.Detach;

  FEditor := Value;
end;

procedure TColumnProperties.ShowEditor(ARow: integer);
var
  Rect: TRect;

  procedure AdjustRect;
  begin
    with Grid do begin
      Rect.TopLeft := Grid.ScreenToClient(ClientToScreen(Rect.TopLeft));
      Rect.BottomRight := Grid.ScreenToClient(ClientToScreen(Rect.BottomRight));
    end;
  end;

begin
  with Grid do begin
    if FEditor <> nil then begin
      Rect := CellRect(Index, ARow);
      AdjustRect;

      if (FEditor is TMetaCellEditor) then
        with (FEditor as TMetaCellEditor).Editor do begin
          Color := FColor;
          Font := FFont;
        end;

      if not IsRectEmpty(Rect) then
        FEditor.Draw(Rect);
    end;
  end;
end;

{ TExtStringGrid }

procedure TExtStringGrid.AppendRow;
begin
  if assigned(FBeforeInsert) then
    FBeforeInsert(self);
  RowCount := RowCount + 1;
  invalidateRow(Rowcount - 1);
  SelectCell(Col, Rowcount - 1);
end;

procedure TExtStringGrid.InsertRow(ARow: Integer);
var
  I, L: LongInt;
begin
  if assigned(FBeforeInsert) then
    FBeforeInsert(self);
  RowCount := RowCount + 1;
  for I := RowCount - 1 downto ARow do
  begin
    for L := 0 to ColCount - 1 do
      cells[L, I] := cells[L, I - 1];
    RowHeights[I] := RowHeights[I - 1];
  end;
  RowHeights[ARow] := DefaultRowHeight;
  for L := 0 to Colcount - 1 do
    cells[L, Row] := '';
end;

procedure TExtStringGrid.DeleteRow(ARow: Integer);
var
  I, L: LongInt;
begin
  if assigned(FBeforeDelete) then
    FBeforeDelete(self);
  if (RowCount > FixedRows + 1) then
  begin
    if CachedUpdates then
    begin
      LineProperties[ARow].RowHeight := RowHeights[ARow];
      RowHeights[ARow] := -1;
    end
    else
    begin
      for I := ARow to RowCount - 1 do
      begin
        for L := 0 to ColCount - 1 do
          cells[L, I] := cells[L, I + 1];
        RowHeights[I] := RowHeights[I - 1];
      end;
      for L := 0 to Colcount - 1 do
        cells[L, RowCount - 1] := '';
      RowCount := RowCount - 1;
    end;
  end
  else
    for L := FixedCols to ColCount - 1 do
      cells[L, ARow] := '';
  InvalidateEditor;
end;

function TExtStringGrid.CanEditModify: Boolean;
var
  cellprops: TCellProperties;
begin
  cellprops := CellProperties[Col, Row];
  if (cellprops <> nil) then
  begin // don't allow merged cells to be edited
    if (cellprops.merged) or (Cellprops.locked) then
      result := false
    else
      result := inherited CanEditModify;
  end
  else if ColumnProperties[Col].locked then
    Result := false
  else
    result := inherited CanEditModify;
end;

function TExtStringGrid.CanEditShow: Boolean;
var
  CellProps: TCellProperties;
begin
  CellProps := CellProperties[Col, Row];
  if (cellprops <> nil) then
  begin // don't allow merged cells to be edited
    if (cellprops.merged) or (Cellprops.locked) then
      result := false
    else
      result := inherited CanEditShow;
  end
  else if ColumnProperties[Col].locked then
    Result := false
  else
    Result := inherited CanEditShow;

  if CellProps.Editor <> nil then
    FCellEditor := CellProps.Editor
  else
  if Columns[Col].Editor <> nil then
    FCellEditor := Columns[Col].Editor
  else
    FCellEditor := nil;

  if Result and Focused and (Row >= FixedRows) then
    if FCellEditor <> nil then begin
      FCellEditor := Columns[Col].Editor;
      FCellEditor.FGridLastChar := FLastChar;
      FEditingCol := Col;
      FEditingRow := Row;
      FCellEditor.StartEdit;
      DrawEditor(Col, Row);
    end;

  Result := False;
end;

procedure TExtStringGrid.CheckIndexRange(ACol, ARow: integer);
begin
  if ((ACol >= 0) and (ACol < ColCount)
    and (ARow >= 0) and (ARow < RowCount)) then
    exit
  else
    raise EOutOfRange.CreateFmt('Grid coords [%d,%d] out of range', [ACol,
      ARow]);
end;

procedure TExtStringGrid.Clear;
var
  i: integer;
begin
  LockPaint;
  for i := 0 to ColCount - 1 do
  begin
    ColumnProperties[i].Clear;
    Cols[i].Clear;
  end;
  UnlockPaint;
end;

procedure TExtStringGrid.ClearColumnProps;
var
  i: integer;
begin
  for i := 0 to ColCount - 1 do
    ColumnProperties[i].Clear;
end;

procedure TExtStringGrid.ColumnMoved(FromIndex, ToIndex: Integer);
var
  oList: TObjectList;
  i: integer;
begin
  Columns.Items[FromIndex].Index := ToIndex;

  oList := ColumnProperties[FromIndex].FCellProps;
  if FromIndex < ToIndex then
  begin
    for i := FromIndex to ToIndex - 1 do
      ColumnProperties[i].FCellProps := ColumnProperties[i +
        1].FCellProps;
  end
  else
    for i := ToIndex to FromIndex - 1 do
      ColumnProperties[i + 1].FCellProps :=
        ColumnProperties[i].FCellProps;
  ColumnProperties[ToIndex].FCellProps := oList;

  inherited;
  if UseMultiTitle then CalcTitleHeight;
end;

procedure TExtStringGrid.CopyGroup(ACol, ARow: Integer; mRect: TRect;
  GroupProp: TCellProperties);
var
  i: integer;
  r: TRect;
  DrawInfo: TGridDrawInfo;
begin
  if groupProp.GroupBitmap = nil then
    Exit;

  CalcDrawInfo(DrawInfo);
  with DrawInfo do
  begin
    r.left := Horz.EffectiveLineWidth;
    r.top := Vert.EffectiveLineWidth;

    if (groupProp.block.Right <> ACol) then
      Inc(mRect.Right, Horz.EffectiveLineWidth);
    if (groupProp.block.Bottom <> ARow) then
      Inc(mRect.Bottom, Vert.EffectiveLineWidth);
    for i := groupProp.block.Left to ACol - 1 do
      Inc(r.left, Horz.GetExtent(i) + Horz.EffectiveLineWidth);
    for i := groupProp.block.Top to ARow - 1 do
      Inc(r.top, Vert.GetExtent(i) + Vert.EffectiveLineWidth);
    r.right := r.Left + mRect.Right - mRect.left;
    r.Bottom := r.top + mRect.Bottom - mRect.top;
    // need next two statements to ensure r is a valid rect within the
    // bitmap
    if r.Bottom > groupProp.GroupBitmap.Height then
      r.Bottom := groupProp.GroupBitmap.Height;
    if r.Right > groupProp.GroupBitmap.Width then
      r.Right := groupProp.GroupBitmap.Width;
  end; // now r is rect on bitmap holding contents of cell
  Canvas.CopyMode := cmSrcCopy;
  Canvas.CopyRect(mRect, groupProp.GroupBitmap.Canvas, r);
end;

constructor TExtStringGrid.Create(AOwner: TComponent);
{ Creates an object of type TExtStringGrid, and initializes properties. }
var
  o: TGridOptions;
begin
  inherited Create(AOwner);
  FCurrentCol := -1;
  FCurrentRow := -1;
  FixedCols := 1;
  FixedRows := 1;
  DefaultDrawing := false;
  VirtualView := true;
  o := Options;
  Exclude(o, goRangeSelect);
  Options := o;
  FTextHAlign := taLeftJustify;
  FTextVAlign := tlTop;
  FFixedFont := TFixedFont.Create;
  FLockedCell := TLockedCell.Create;
  FLockedCell.BackColor := clGreen;
  FPaintLock := 0;

  FTitleColor := FixedColor;
  FOptionsEx := [sgoTitle3D, sgoFixed3D];
  FCachedUpdates := False;
  FLineProps := TObjectList.Create;
  FBGImage := TBitmap.create;
  FLayoutFlag := 2;
  FColumnProps := CreateColumns;
  FLayoutFlag := 0;
  SizeChanged(ColCount, RowCount);
  inherited DefaultRowHeight := 17;
end;

function TExtStringGrid.CreateColumns: TExtStringGridColumns;
begin
  Result := TExtStringGridColumns.Create(Self, TColumnProperties);
end;

procedure TExtStringGrid.DefaultHandler(var Msg);
var
  P: TPopupMenu;
  Cell: TGridCoord;
begin
  inherited DefaultHandler(Msg);
  if TMessage(Msg).Msg = wm_RButtonUp then
    with TWMRButtonUp(Msg) do
    begin
      Cell := MouseCoord(XPos, YPos);
      if (Cell.X < 0) or (Cell.Y < 0) then
        Exit;
      P := Columns[Cell.X].PopupMenu;
      if (P <> nil) and P.AutoPopup then
      begin
        SendCancelMode(nil);
        P.PopupComponent := Self;
        with ClientToScreen(SmallPointToPoint(Pos)) do
          P.Popup(X, Y);
        Result := 1;
      end;
    end;
end;

destructor TExtStringGrid.Destroy;
begin
  Clear;
  FFixedFont.Free;
  FLockedCell.Free;
  FLayoutFlag := 2;
  FColumnProps.Free;
  FColumnProps := nil;
  fBGImage.free;
  FLineProps.Free;
  inherited Destroy;
end;

procedure TExtStringGrid.DrawBackground(rect: TRect;
  AState: TGridDrawState);
var
  rMode: TCopyMode;
  srect, drect, irect: trect;
  XCnt, YCnt, X, Y: Integer;
begin
  if (fbgImage.width > 0) and (fbgImage.height > 0) then
  begin
    rmode := Canvas.copymode;
    //if (gdSelected in AState) then canvas.copymode := cmNotSrcCopy;
    if (gdSelected in AState) and
      (not (gdFocused in AState) or
      ([goDrawFocusSelected, goRowSelect] * Options <> [])) then
      canvas.copymode := cmNotSrcCopy;

    XCnt := (Clientwidth) div fBGImage.width;
    YCnt := (Clientheight) div fBGImage.height;

    for x := 0 to XCnt do
    begin
      for y := 0 to YCnt do
      begin
        drect.left := x * fbgImage.width;
        drect.top := y * fbgImage.height;
        drect.right := drect.left + fbgImage.width;
        drect.bottom := drect.top + fbgImage.height;

        if Intersectrect(irect, rect, drect) then
        begin
          srect := irect;
          while srect.left >= fbgimage.width do
            offsetrect(srect, -fbgimage.width, 0);
          while srect.top >= fbgimage.height do
            offsetrect(srect, 0, -fbgimage.height);
          canvas.copyrect(irect, fbgimage.canvas, srect);
        end;
      end;
    end;
    Canvas.copymode := rmode;
  end;
end;

procedure TExtStringGrid.DrawCell(ACol, ARow: Integer; mRect: TRect;
  AState: TGridDrawState);
  procedure DefaultDraw(X1, Y1, X2, Y2: Integer; Ctl3D: Boolean);
  var
    I: Integer;
  begin
    with Canvas do
    begin
      if gdFixed in AState {Fixed part} then
      begin
        Brush.Style := bsSolid;
        if ARow < FixedRows then
          Brush.Color := TitleColor
        else
          Brush.Color := FixedColor;
        Pen.Style := psClear;
        Rectangle(X1 - 1, Y1 - 1, X2 + 2, Y2 + 2);
        if goFixedVertLine in Options then
        begin
          if Ctl3D then
          begin
            Pen.Style := psSolid;
            Pen.Color := clBtnShadow;
            MoveTo(X2 - 1, Y1 - 1);
            LineTo(X2 - 1, Y2 + 1);
            Pen.Color := clWindow;
            MoveTo(X1, Y1 - 1);
            LineTo(X1, Y2 + 1);
          end;
          Pen.Style := psSolid;
          Pen.Color := clBlack;
          MoveTo(X2, Y1 - 1);
          LineTo(X2, Y2 + 1);
          MoveTo(X1 - 1, Y1 - 1);
          LineTo(X1 - 1, Y2 + 1);
        end;

        if goFixedHorzLine in Options then
        begin
          if Ctl3D then
          begin
            Pen.Style := psSolid;
            Pen.Color := clBtnShadow;
            MoveTo(X1 + 1, Y2 - 1);
            LineTo(X2 + 1, Y2 - 1);
            Pen.Color := clWindow;
            MoveTo(X1 - 1, Y1);
            LineTo(X2 + 1, Y1);
          end;
          Pen.Style := psSolid;
          Pen.Color := clBlack;
          MoveTo(X1 - 1, Y2);
          LineTo(X2 + 1, Y2);
          MoveTo(X1 - 1, Y1 - 1);
          LineTo(X2 + 1, Y1 - 1);
        end;

        if goFixedVertLine in Options then
        begin
          Pen.Style := psSolid;
          Pen.Color := clBlack;
          MoveTo(X2, Y1 - 1);
          LineTo(X2, Y2 + 1);
          MoveTo(X1 - 1, Y1 - 1);
          LineTo(X1 - 1, Y2 + 1);
        end;
      end
      else
      begin { working part }
        Pen.Style := psClear;
        Brush.Style := bsSolid;
        Brush.Color := Color;
        Rectangle(X1, Y1, X2 + 1, Y2 + 1);
        Pen.Style := psSolid;
        Pen.Color := clSilver;
        if goVertLine in Options then
        begin
          MoveTo(X2, Y1);
          LineTo(X2, Y2);
          if (ACol <> LeftCol) and (ARow <> TopRow) then
          begin
            MoveTo(X1 - 1, Y1 - 1);
            LineTo(X1 - 1, Y2);
          end;
          if (ACol = ColCount - 1) then
          begin
            MoveTo(X2, Y1 - 1);
            LineTo(X2, Y2 + 1);
          end;
        end;
        if goHorzLine in Options then
        begin
          MoveTo(X1, Y2);
          LineTo(X2, Y2);
          if (ACol <> LeftCol) and (ARow <> TopRow) then
          begin
            MoveTo(X1 - 1, Y1 - 1);
            LineTo(X1 - 1, Y2);
            MoveTo(X1 - 1, Y1 - 1);
            LineTo(X2, Y1 - 1);
          end;
        end;

        if gdFocused in AState then
        begin
          if (goDrawFocusSelected in Options) then
          begin
            Pen.Style := psClear;
            Brush.Style := bsSolid;
            Brush.Color := clHighLight;
            Rectangle(X1, Y1, X2 + 1, Y2 + 1);
            Pen.Style := psSolid;
            Pen.Style := psSolid;
            Pen.Color := clSilver;
            for I := X1 to X2 - 1 do
            begin
              if not Odd(I) then
                Pixels[I, Y1 + 0] := clBlack
              else
                Pixels[I, Y1 + 0] := Color;
              if not Odd(I) then
                Pixels[I, Y2 - 1] := clBlack
              else
                Pixels[I, Y2 - 1] := Color;
            end;
            for I := Y1 to Y2 - 1 do
            begin
              if not Odd(I) then
                Pixels[X1 + 0, I] := clBlack
              else
                Pixels[X1 + 0, I] := Color;
              if not Odd(I) then
                Pixels[X2 - 1, I] := clBlack
              else
                Pixels[X2 - 1, I] := Color;
            end;
          end
          else
          begin
            Pen.Style := psClear;
            Brush.Style := bsSolid;
            Brush.Color := Color;
            Rectangle(X1, Y1, X2 + 1, Y2 + 1);
            Pen.Style := psSolid;
            Pen.Color := clSilver;
            for I := X1 to X2 - 1 do
            begin
              if not Odd(I) then
                Pixels[I, Y1 + 0] := clBlack
              else
                Pixels[I, Y1 + 0] := Color;
              if not Odd(I) then
                Pixels[I, Y2 - 1] := clBlack
              else
                Pixels[I, Y2 - 1] := Color;
            end;
            for I := Y1 to Y2 - 1 do
            begin
              if not Odd(I) then
                Pixels[X1 + 0, I] := clBlack
              else
                Pixels[X1 + 0, I] := Color;
              if not Odd(I) then
                Pixels[X2 - 1, I] := clBlack
              else
                Pixels[X2 - 1, I] := Color;
            end;
          end;
        end;
        if [gdSelected] = AState then
        begin
          if (goRangeSelect in Options) then
          begin
            Pen.Style := psClear;
            Brush.Style := bsSolid;
            Brush.Color := clHighLight;
            Rectangle(X1, Y1, X2 + 1, Y2 + 1);
            Pen.Style := psSolid;
          end
          else
          begin
            Pen.Style := psClear;
            Brush.Style := bsSolid;
            Brush.Color := clHighLight;
            Rectangle(X1, Y1, X2 + 1, Y2 + 1);
            Pen.Style := psSolid;
            Pen.Color := clSilver;
            for I := X1 to X2 - 1 do
            begin
              if not Odd(I) then
                Pixels[I, Y1 + 0] := clBlack
              else
                Pixels[I, Y1 + 0] := Color;
              if not Odd(I) then
                Pixels[I, Y2 - 1] := clBlack
              else
                Pixels[I, Y2 - 1] := Color;
            end;
            for I := Y1 to Y2 - 1 do
            begin
              if not Odd(I) then
                Pixels[X1 + 0, I] := clBlack
              else
                Pixels[X1 + 0, I] := Color;
              if not Odd(I) then
                Pixels[X2 - 1, I] := clBlack
              else
                Pixels[X2 - 1, I] := Color;
            end;
          end;
        end;
      end;
      Pen.Style := psSolid;
      Pen.Color := clBlack;
      Brush.Style := bsClear;
    end;
  end;
var
  X1, X2: Integer;
  Y1, Y2: Integer;
  I, W: Integer;
  ColLeft: Integer;
  ColRight: Integer;
  cellprop: TCellProperties;
  colProp: TColumnProperties;
  ARect, WRect: TRect;
  halign: TAlignment;
  valign: TTextLayout;
  CellText, s: string;
  vgap, hgap: integer;
  uFormat: Cardinal;
  nFont: TFont;
  nColor: TColor;
  PaintCanvas: TCanvas;
  HasBG: boolean;
  M, N: integer;
  TitleHeights: array of Integer;
  CellMerged: Boolean;
begin
  if (RowHeights[ARow] <= 0) or (ColWidths[ACol] <= 0) then
    Exit;

  CellProp := CellProperties[ACol, ARow];
  ColProp := ColumnProperties[ACol];
  HasBG := (assigned(fBGImage) and (fBGImage.width > 0) and (fBGImage.height >
    0));
  ARect := mRect;

  if Assigned(FOnBeforeDrawCell) then
    FOnBeforeDrawCell(Self, ACol, ARow, mRect, AState);

  if (gdFixed in AState) and (ARow = 0{< FixedRows}) then //Title
  begin
    X1 := ARect.Left;
    Y1 := ARect.Top;
    X2 := ARect.Right;
    Y2 := ARect.Bottom;
    WRect.Left := X1 + 1;
    WRect.Top := Y1 + 1;
    WRect.Right := X2 - 1;
    WRect.Bottom := Y2 - 1;
    //
    nColor := TitleColor;
    nFont := ColProp.Title.Font;
    hAlign := ColProp.Title.Alignment;
    vAlign := tlCenter;
    CellText := colProp.Title.Caption;
    Canvas.Brush.Color := nColor;
    Canvas.Font := nFont;
    if UseMultiTitle and (Pos('|', CellText) > 0) then
    begin
      S := CellText;
      SetLength(TitleHeights, Length(ColProp.Title.fMultiTitleHeights));
      for I := 0 to Length(ColProp.Title.fMultiTitleHeights) - 1 do
        TitleHeights[i] := ColProp.Title.fMultiTitleHeights[I];
      {------------------------
      W := 1;
      for I := Length(CellText) downto 1 do
        if CellText[I] = '|' then
          Inc(W)
        else if W = 1 then
          Delete(S, I, 1);
      SetLength(TitleHeights, W);
      for I := 0 to W - 1 do
        TitleHeights[i] := ColProp.Title.fMultiTitleHeights[I];
      for I := ACol - 1 downto 0 do
        if Pos(S, Columns[I].Title.Caption) = 1 then
          for n := 0 to W - 1 do
          begin
            if Columns[I].Title.fMultiTitleHeights[n] > TitleHeights[n] then
              TitleHeights[n] := Columns[I].Title.fMultiTitleHeights[n];
          end
        else
          Break;
      for I := ACol + 1 to ColCount - 1 do
        if Pos(S, Columns[I].Title.Caption) = 1 then
          for n := 0 to W - 1 do
          begin
            if Columns[I].Title.fMultiTitleHeights[n] > TitleHeights[n] then
              TitleHeights[n] := Columns[I].Title.fMultiTitleHeights[n];
          end
        else
          Break;
      M :=0;
      for n:=0 to W-1 do
        M := M + TitleHeights[n] + GridLineWidth;
      if M<RowHeights[0] then
        TitleHeights[W-1] := TitleHeights[W-1] + (RowHeights[0]-M);
      ------------------------}
      for M := Length(TitleHeights) - 1 downto 0 do
      begin
        if M = Length(TitleHeights) - 1 then
          hAlign := taCenter;

        S := CellText;
        if Pos('|', CellText) > 0 then
          for I := Length(CellText) downto 1 do
          begin
            if (CellText[I] = '|') then
            begin
              S := Copy(CellText, I + 1, Length(CellText) - I);
              Delete(CellText, I, Length(CellText) - I + 1);
              Break;
            end;
          end
        else
          CellText := '';
        with Canvas do
        begin
          X1 := ARect.Left;
          X2 := ARect.Right;
          Y1 := {ARect.Top} ARect.Bottom;
          Y2 := ARect.Bottom;
          if M = 0 then
            Y1 := ARect.Top
          else
          begin
            for i := M to Length(TitleHeights) - 1 do
              Y1 := Y1 - TitleHeights[i] - GridLineWidth;
            Y1 := Y1 + GridLineWidth;
          end;
          for i := M + 1 to Length(TitleHeights) - 1 do
            Y2 := Y2 - TitleHeights[i] - GridLineWidth;
          { XXXXXXXXXXXXXXXXXXXXXXXXXXXX}
          ColLeft := 0;
          for I := ACol - 1 downto 0 do
            if (Pos(CellText + '|' + S + '|', Columns[I].Title.Caption) <> 1)
              and
              (Pos(CellText + S + '|', Columns[I].Title.Caption) <> 1) //then
            {If Pos(CellText+'|',Cells[I, ARow])<>1} then
            begin
              ColLeft := I + 1;
              Break;
            end;
          W := 0;
          if ColLeft < LeftCol then
          begin
            for I := LeftCol - 1 downto ColLeft do
              W := W + ColWidths[I];
            X1 := W;
            W := 0;
            for I := 1 to FixedCols do
              W := W + ColWidths[I - 1];
            X1 := W - X1 + 1;
          end
          else
          begin
            WRect := CellRect(ColLeft, ARow);
            X1 := WRect.Left;
          end;

          ColRight := ColCount - 1;
          for I := ACol + 1 to ColCount - 1 do
            if (Pos(CellText + '|' + S + '|', Columns[I].Title.Caption) <> 1)
              and
              (Pos(CellText + S + '|', Columns[I].Title.Caption) <> 1) //then
            {If (Pos(CellText+'|',Cells[I, ARow])<>1)} then
            begin
              ColRight := I - 1;
              Break;
            end;
          if ColRight > LeftCol + VisibleColCount - 1 then
          begin
            WRect := CellRect(LeftCol + VisibleColCount - 1, ARow);
            W := WRect.Right;
            for I := LeftCol + VisibleColCount to ColRight do
              W := W + ColWidths[I];
            X2 := W;
          end
          else
          begin
            WRect := CellRect(ColRight, ARow);
            X2 := WRect.Right;
          end;

          DefaultDraw(X1, Y1, X2, Y2, sgoTitle3D in OptionsEx);
          WRect.Left := X1 + 1;
          WRect.Top := Y1 + 1;
          WRect.Right := X2 - 1;
          WRect.Bottom := Y2 - 1;
          WriteText(Canvas, WRect, True, 2, 2, S, hAlign, vAlign, True,
            False, 0, 0, UseRightToLeftReading);
          {WRect := CellRect(LeftCol, ARow);
          if X1 < WRect.Left then
          begin
            for I := 0 to FixedRows - 1 do
              DrawCell(I, ARow, CellRect(I, ARow), [gdFixed]);
          end;}
          { XXXXXXXXXXXXXXXXXXXXXXXXXXXX}
        end; { With Casvas }
      end;
    end
    else
    begin
      DefaultDraw(X1, Y1, X2, Y2, (sgoTitle3D in OptionsEx));
      WriteText(Canvas, ARect, True, 2, 2, CellText, hAlign, vAlign, True,
        False, 0, 0, UseRightToLeftReading);
    end;
    if Assigned(OnDrawCell) then
      OnDrawCell(self, ACol, ARow, mRect, AState);
    if Assigned(FOnAfterDrawCell) then
      FOnAfterDrawCell(Self, ACol, ARow, mRect, AState);
  end //title
  else
  begin //data
    nColor := ColProp.Color;
    nFont := ColProp.Font;
    hAlign := ColProp.FHAlign;
    vAlign := ColProp.FVAlign;
    CellText := Cells[ACol, ARow];
    CellMerged := (cellprop <> nil) and (cellprop.merged);
    if (not colProp.parentfont) then
      nFont := colProp.Font;
    if (not colProp.parentcolor) then
      nColor := colProp.Color;
    if (not colProp.parentAlign) then
    begin
      halign := colProp.HAlign;
      valign := colProp.VAlign;
    end;
    PaintCanvas := Canvas;
    if CellMerged then
    begin
      // properties of top left cell = region
      cellprop := CellProperties[cellprop.block.left, cellprop.block.top];
      if (cellprop.block.left = ACol) and (cellprop.block.Top = ARow) then
      begin
        ARect := ResizeGroupBitmap(cellprop);
          // current cell is top-left of group
        cellprop.FGBitmapFresh := false;
        PaintCanvas := cellprop.GroupBitmap.Canvas;
        if HasBG and (ACol >= FixedCols) and (ARow >= FixedRows) then
        begin
          WRect := Rect(mRect.Left, mRect.Top, mRect.Left + ARect.Right,
            mRect.Top + ARect.Bottom);
          DrawBackground(WRect, []);
          WRect := Rect(WRect.Left - GridLineWidth, WRect.Top - GridLineWidth,
            WRect.Right, WRect.Bottom);
          PaintCanvas.CopyMode := cmSrcCopy;
          PaintCanvas.CopyRect(ARect, Canvas, WRect);
        end;
      end;
    end;

    if (cellprop <> nil) then
    begin
      if (not cellProp.parentFont) then
        nFont := cellProp.Font;
      if (not cellProp.parentColor) then
        nColor := cellProp.Color;
      if (not cellProp.parentalign) then
      begin
        halign := cellprop.HAlign;
        valign := cellprop.VAlign;
      end;
    end;
    if CellMerged and (cellprop.FGBitmapFresh) then
      // copy rect from bitmap onto screen;
      CopyGroup(ACol, ARow, mRect, cellprop)
    else
    begin
      // only draw stuff if not merged or if merge bitmap is not fresh

      if not CellMerged and (colProp.GroupIndex > 0) and (ARow>=FixedRows) and (CellText <> '') then
      begin
        S := CellText;
        X1 := ARect.Left;
        X2 := ARect.Right;           
        Y1 := ARect.Top;
        Y2 := ARect.Bottom;
        { XXXXXXXXXXXXXXXXXXXXXXXXXXXX}
        ColLeft := FixedRows; //RowTop
        for I := ARow - 1 downto FixedRows do
        begin
          if Cells[ACol, I] <> S then
          begin
            ColLeft := I + 1;
            Break;
          end
          else
          begin
            for n := ACol - 1 downto 0 do
              if (Columns[n].GroupIndex <> ColProp.GroupIndex) then
                Break
              else if Cells[n, I] <> Cells[n, ARow] then
              begin
                ColLeft := I + 1;
                Break;
              end;
          end;
          if ColLeft <> FixedRows then
            Break;
        end;
        W := 0;
        if ColLeft < TopRow then
        begin
          for I := TopRow - 1 downto ColLeft do
            W := W + RowHeights[I];
          Y1 := W;
          W := 0;
          for I := 1 to FixedRows do
            W := W + RowHeights[I - 1];
          Y1 := W - Y1 + 1;
        end
        else
        begin
          WRect := CellRect(ACol, ColLeft);
          Y1 := WRect.Top;
        end;

        ColRight := RowCount - 1;
        for I := ARow to RowCount - 1 do
        begin
          if Cells[ACol, I] <> S then
          begin
            ColRight := I - 1;
            Break;
          end
          else
          begin
            for n := ACol - 1 downto 0 do
              if (Columns[n].GroupIndex <> ColProp.GroupIndex) then
                Break
              else if Cells[n, I] <> Cells[n, ARow] then
              begin
                ColRight := I - 1;
                Break;
              end;
          end;
          if ColRight <> RowCount - 1 then
            Break;
        end;
        if ColRight > TopRow + VisibleRowCount - 1 then
        begin
          WRect := CellRect(ACol, TopRow + VisibleRowCount - 1);
          W := WRect.Bottom;
          for I := TopRow + VisibleRowCount to ColRight do
            W := W + RowHeights[I];
          Y2 := W;
        end
        else
        begin
          WRect := CellRect(ACol, ColRight);
          Y2 := WRect.Bottom;
        end;
        ARect.Left := X1;
        ARect.Top := Y1;
        ARect.Right := X2;
        ARect.Bottom := Y2;
        { XXXXXXXXXXXXXXXXXXXXXXXXXXXX}
        CellProp := CellProperties[ACol, ColLeft];
        if (cellprop <> nil) then
        begin
          if (not cellProp.parentFont) then
            nFont := cellProp.Font;
          if (not cellProp.parentColor) then
            nColor := cellProp.Color;
          if (not cellProp.parentalign) then
          begin
            halign := cellprop.HAlign;
            valign := cellprop.VAlign;
          end;
        end;
      end;

      // now assign colors and fonts
      PaintCanvas.Font.Assign(nFont);
      PaintCanvas.Brush.Color := nColor;

      // locked overrides color & font
      if ((cellprop <> nil) and (cellprop.locked)) or
        (colprop.locked) then
      begin
        PaintCanvas.Brush.Color := FLockedCell.BackColor;
        if FLockedCell.UseLockedFont then
          PaintCanvas.Font := FLockedCell.LockedFont // use all font attributes
        else
          PaintCanvas.Font.Color := FLockedCell.LockedFont.Color;
            // just change font color
      end;

      // focussed overrides all brush colors
      if (gdSelected in AState) and
        (not (gdFocused in AState) or
        ([goDrawFocusSelected, goRowSelect] * Options <> [])) then
      begin
        PaintCanvas.Brush.Color := clHighlight;
        PaintCanvas.Font.Color := clHighlightText;
      end;

      // check if cell is a fixed cell
      if gdFixed in AState then
      begin
        PaintCanvas.brush.color := fixedcolor;
        if sgoFixed3D in OptionsEx then
        begin
          DrawEdge(PaintCanvas.Handle, ARect, BDR_RAISEDINNER,
            BF_BOTTOMRIGHT);
          DrawEdge(PaintCanvas.Handle, ARect, BDR_RAISEDINNER, BF_TOPLEFT);
          InflateRect(ARect, -1, -1);
          PaintCanvas.FillRect(ARect);
          InflateRect(ARect, -1, -1);
        end
        else
        begin
          PaintCanvas.FillRect(ARect);
          InflateRect(ARect, -2, -2);
        end;
        if FixedFont.UseFixedFont then
          PaintCanvas.Font := FixedFont.FixedFont;
        if (not FixedFont.ParentAlign) then
        begin
          halign := FixedFont.AlignHoriz;
          valign := FixedFont.AlignVert;
        end;
      end
      else
      begin
        // blank out cell region
        if HasBG and (ACol >= FixedCols) and (ARow >= FixedRows) then
          DrawBackground(mRect, AState)
        else if sgoData3D in OptionsEx then
        begin
          DrawEdge(PaintCanvas.Handle, ARect, BDR_RAISEDINNER,
            BF_BOTTOMRIGHT);
          DrawEdge(PaintCanvas.Handle, ARect, BDR_RAISEDINNER, BF_TOPLEFT);
          InflateRect(ARect, -1, -1);
          PaintCanvas.FillRect(ARect);
          InflateRect(ARect, -1, -1);
        end else
        begin
          PaintCanvas.FillRect(ARect);
        end;
        if gdFocused in AState then
          PaintCanvas.DrawFocusRect(Arect); // put focus rectangle around
        if not (sgoData3D in OptionsEx) then
          InflateRect(ARect, -2, -2);
      end;

      if HasBG then
        PaintCanvas.Brush.Style := bsClear;

      WriteText(PaintCanvas, ARect, not HasBG, 0, 0, CellText, HAlign, VAlign,
        Columns[ACol].WordWrap,
        Columns[ACol].EndEllipsis, 0, 0, UseRightToLeftReading);

      if CellMerged then
      begin
        cellprop.FGBitmapFresh := true;
        CopyGroup(ACol, ARow, mRect, cellprop);
      end;
    end;
  end;

  if Assigned(FOnAfterDrawCell) then
    FOnAfterDrawCell(Self, ACol, ARow, mRect, AState);
end;

function TExtStringGrid.GetCellColor(ACol, ARow: integer): TColor;
var
  cellprop: TCellProperties;
  colProp: TColumnProperties;
begin
  CheckIndexRange(ACol, ARow);
  cellprop := CellProperties[ACol, ARow];
  colProp := ColumnProperties[ACol];
  if (cellprop <> nil) and (not cellprop.Parentcolor) then
    result := cellprop.color
  else if (not colProp.parentcolor) then
    Result := colProp.Color
  else
    result := Color; // default is color of grid
end;

function TExtStringGrid.GetCellFont(ACol, ARow: integer): TFont;
var
  cellprop: TCellProperties;
  colProp: TColumnProperties;
begin
  CheckIndexRange(ACol, ARow);
  cellprop := CellProperties[ACol, ARow];
  colProp := ColumnProperties[ACol];
  if not Assigned(cellprop) then
    cellprop := MakeCellProp(ACol, ARow);
  if not cellprop.ParentFont then
    result := cellprop.Font
  else if (not colProp.parentfont) then
    Result := colProp.Font
  else
    result := Font; // default is grid font
end;

function TExtStringGrid.GetCellHAlignment(ACol, ARow: integer): TAlignment;
var
  cellprop: TCellProperties;
  colProp: TColumnProperties;
begin
  CheckIndexRange(ACol, ARow);
  colProp := ColumnProperties[ACol];
  cellprop := CellProperties[ACol, ARow];
  if (cellprop <> nil) then
    result := cellprop.HAlign
  else if (not colProp.parentalign) then
    Result := colProp.HAlign
  else
    result := AlignHoriz; // grid default
end;

function TExtStringGrid.GetCellLocked(ACol, ARow: integer): boolean;
var
  cellprop: TCellProperties;
  colProp: TColumnProperties;
begin
  CheckIndexRange(ACol, ARow);
  cellprop := CellProperties[ACol, ARow];
  colProp := ColumnProperties[ACol];
  if (cellprop <> nil) then
    result := cellprop.locked
  else
    result := colprop.locked;
end;

function TExtStringGrid.GetCellProps(ACol, ARow: integer): TCellProperties;
begin
  CheckIndexRange(ACol, ARow); // raise exception if out of range
  if ColumnProperties[ACol]<>nil then 
  with ColumnProperties[ACol] do
    if (Assigned(FCellProps)) and (ARow < FCellProps.Count) then
      result := TCellProperties(FCellProps[ARow])
    else
      result := nil;
  if Result = nil then
    Result := MakeCellProp(ACol, ARow);
end;

function TExtStringGrid.GetCellVAlignment(ACol, ARow: integer): TTextLayout;
var
  cellprop: TCellProperties;
  colProp: TColumnProperties;
begin
  CheckIndexRange(ACol, ARow);
  cellprop := CellProperties[ACol, ARow];
  colProp := ColumnProperties[ACol];
  if (cellprop <> nil) then
    result := cellprop.vAlign
  else if (not colProp.parentalign) then
    Result := colProp.VAlign
  else
    result := AlignVert; // grid default
end;

function TExtStringGrid.GetColCount: Integer;
begin
  result := inherited ColCount;
end;

function TExtStringGrid.GetColumnProps(Index: integer): TColumnProperties;
begin
  if Index<FColumnProps.Count then
    Result := TColumnProperties(FColumnProps[Index])
  else
    Result := nil;
end;

function TExtStringGrid.GetRowCount: integer;
begin
  result := inherited RowCount;
end;

function TExtStringGrid.GetSelectedIndex: Integer;
begin
  Result := Col;
end;

procedure TExtStringGrid.GroupCells(left, top, right, bottom: integer);
var
  i, j: integer;
  cellprops: TCellProperties;
  block: TGridRect;
begin
  CheckIndexRange(left, top); // raise exception if exceed bounds
  CheckIndexRange(right, bottom);
  HideEditor; // in case editor is in group's block
  begin
    block.left := left;
    block.right := right;
    block.top := top;
    block.bottom := bottom;
    // check for overlap with other merge
    for i := left to right do
      for j := top to bottom do
      begin
        cellprops := CellProperties[i, j];
        if (cellprops <> nil) and (cellprops.merged) then
        begin
          // error - overlap of blocks
              //raise EBlockOverlap.Create('Blocks overlap!');
          UngroupCells(i, j);
          GroupCells(left, top, right, bottom);
          Exit;
        end;
      end;
    // OK, no overlap
    for i := left to right do
      for j := top to bottom do
      begin
        cellprops := CellProperties[i, j];
        if cellprops = nil then
          cellprops := MakeCellProp(i, j);
        cellprops.merged := true;
        cellprops.block := block;
      end;
  end;
  Refresh;
end; { GroupCells }

procedure TExtStringGrid.LockPaint;
begin
  Inc(FPaintLock);
end;

function TExtStringGrid.MakeCellProp(ACol, ARow: Integer): TCellProperties;
begin
  with ColumnProperties[ACol] do
  begin
    if not Assigned(FCellProps) then
      FCellProps := TObjectList.Create;
    if FCellProps.Count <= ARow then
      FCellProps.Count := ARow + 1;
    if not Assigned(FCellProps[ARow]) then
      FCellProps[ARow] := TCellProperties.Create(Self);
    result := TCellProperties(FCellProps[ARow]);
  end;
end;

function TExtStringGrid.MouseCoord(X, Y: Integer): TGridCoord;
var
  cellprops: TCellProperties;
begin
  // get actual co-ordinate
  result := inherited MouseCoord(X, Y);
  // check if cell the mouse is over is part of a merge
  // then change Coord.X, Y to top-left of merge
  if (result.X < 0) or (result.Y < 0) then
    exit;
  cellprops := CellProperties[Result.X, Result.Y];
  if (cellprops <> nil) and (cellprops.merged) then
  begin
    result.X := cellprops.block.Left;
    result.Y := cellprops.block.Top;
  end;
end;

procedure TExtStringGrid.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  c, r: LongInt;
  s: TGridRect;
  coord: TGridCoord;
begin
  MouseToCell(X, Y, c, r);
  if (goAlwaysShowEditor in Options) and (c >= FixedCols) and (r >= FixedRows) then begin
    if FCellEditor <> nil then
      FCellEditor.EndEdit;
  end;

  if SelectCell(c, r) then begin
    if FCellEditor <> nil then
      FCellEditor.Clear;

    if (c >= FixedCols) and (r >= FixedRows) then begin
      s.left := c;
      s.Right := c;
      s.Top := r;
      s.Bottom := r;
      Selection := s;
    end;
  end;

  inherited;
  if (FCellEditor = nil) and not (goAlwaysShowEditor in Options) then
    EditorMode := false;

  coord := MouseCoord(X, Y);
  if (coord.X >= 0) and (coord.Y >= 0) then
  begin
    if ((coord.X < FixedCols) or (coord.Y < FixedRows)) then
    begin
      if Assigned(FOnFixedCellClick) then
        FOnFixedCellClick(self, button, shift, x, y, coord.X, coord.Y);
    end
    else if Assigned(FOnCellClick) then
      FOnCellClick(self, button, shift, x, y, coord.X, coord.Y);
  end;
end;

procedure TExtStringGrid.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Coord: TGridCoord;
begin
  inherited;
  Coord := MouseCoord(X, Y);

  if (FCurrentCol <> Coord.X) or (FCurrentRow <> Coord.Y) then
  begin
    if (FCurrentCol > -1) and (FCurrentRow > -1) then
      TriggerMouseLeaveEvent(Shift, FCurrentCol, FCurrentRow);
    if (Coord.X > -1) and (Coord.Y > -1) then
      TriggerMouseEnterEvent(Shift, Coord.X, Coord.Y);
    FCurrentCol := Coord.X;
    FCurrentRow := Coord.Y;
  end;
end; { MouseMove }

procedure TExtStringGrid.Paint;
var
  i, endx, endy: integer;
begin
  if (FPaintLock = 0) then
  begin
    inherited Paint;
    if assigned(fBGImage) and (fbgImage.width > 0) and (fbgImage.height > 0)
      then
    begin
      endx := 0;
      for I := 0 to FixedCols - 1 do
        inc(endx, (colwidths[i] + 1));
      for I := LeftCol to colcount - 1 do
        inc(endx, (colwidths[i] + 1));
      endy := 0;
      for I := 0 to FixedRows - 1 do
        inc(endy, (Rowheights[i] + 1));
      for I := TopRow to Rowcount - 1 do
        inc(endy, (Rowheights[i] + 1));

      if endX < clientwidth then
        DrawBackground(rect(endx + 1, 0, clientwidth, endy), []);
      if endy < clientheight then
        DrawBackground(rect(0, endy, clientwidth, clientheight), []);
    end;
  end;
end;

function TExtStringGrid.ResizeGroupBitmap(CellProps: TCellProperties): TRect;
var
  i: integer;
  hsize, vsize: integer;
  c: TCellProperties;
  DrawInfo: TGridDrawInfo;
begin
  Result := Rect(0, 0, 0, 0); //blank result
  if (not CellProps.merged) then
    exit;
  c := CellProperties[Cellprops.block.Left, CellProps.block.Top];
  c.MakeBitmap;
  CalcDrawInfo(DrawInfo);
  with DrawInfo do
  begin
    hsize := 0;
    vsize := 0;
    for i := c.block.Left to c.block.Right do
      Inc(hsize, Horz.GetExtent(i) + Horz.EffectiveLineWidth);
    Dec(hsize, Horz.EffectiveLineWidth); // remove width of final grid line
    for i := c.block.Top to c.block.Bottom do
      Inc(vsize, Vert.GetExtent(i) + Vert.EffectiveLineWidth);
    Dec(vsize, Vert.EffectiveLineWidth); // remove width of bottom grid line
    c.GroupBitmap.Height := vsize;
    c.GroupBitmap.Width := hsize;
    result := Rect(0, 0, hsize, vsize);
  end;
end;

procedure TExtStringGrid.RowMoved(FromIndex, ToIndex: Integer);
var
  fromcell, tocell: TCellProperties;
  i, j: integer;
begin
  GetLineProps(FromIndex);
  GetLineProps(ToIndex);
  FLineProps.Move(FromIndex, ToIndex);

  for i := 0 to ColCount - 1 do
  begin
    fromCell := CellProperties[i, FromIndex];
    toCell := CellProperties[i, ToIndex];
    if (fromCell <> nil) or (toCell <> nil) then
    begin
      with ColumnProperties[i].FCellProps do
      begin
        if FromIndex < ToIndex then
        begin
          if Count < ToIndex then
            Count := ToIndex + 1;
          for j := FromIndex to ToIndex - 1 do
            items[j] := items[j + 1];
        end
        else
        begin
          if Count < FromIndex then
            Count := FromIndex + 1;
          for j := ToIndex to FromIndex - 1 do
            items[j + 1] := items[j];
        end;
        items[ToIndex] := fromCell;
      end;
    end;
  end;
  inherited;
end;

function TExtStringGrid.SelectCell(ACol, ARow: Integer): Boolean;
var
  c: TCellProperties;
begin
  FLastChar := 0;
  c := CellProperties[ACol, ARow];
  if (c <> nil) and ((c.merged) or (c.grouped)) then
    result := false
  else
    result := inherited SelectCell(ACol, ARow);
end;

procedure TExtStringGrid.SetAlignHoriz(const Value: TAlignment);
begin
  FTextHAlign := Value;
  Invalidate;
end;

procedure TExtStringGrid.SetAlignVert(const Value: TTextLayout);
begin
  FTextVAlign := Value;
  Invalidate;
end;

procedure TExtStringGrid.SetBGImage(newImg: TBitmap);
begin
  fBGImage.assign(newImg);
  invalidate;
end;

procedure TExtStringGrid.SetCellColor(ACol, ARow: integer;
  const Value: TColor);
var
  cellprop: TCellProperties;
begin
  CheckIndexRange(ACol, ARow);
  cellprop := CellProperties[ACol, ARow];
  if (cellprop = nil) then
    cellprop := MakeCellProp(ACol, ARow);
  if CellProp.merged then
    cellprop := CellProperties[cellprop.block.Left, cellprop.block.top];
  cellprop.color := Value;
  InvalidateCell(ACol, ARow);
end;

procedure TExtStringGrid.SetCellFont(ACol, ARow: integer;
  const Value: TFont);
var
  cellprop: TCellProperties;
begin
  CheckIndexRange(ACol, ARow);
  cellprop := CellProperties[ACol, ARow];
  if (cellprop = nil) then
    cellprop := MakeCellProp(ACol, ARow);
  if CellProp.merged then
    cellprop := CellProperties[cellprop.block.Left, cellprop.block.top];

  cellprop.font.Assign(Value);
  InvalidateCell(ACol, ARow);
end;

procedure TExtStringGrid.SetCellHAlignment(ACol, ARow: integer;
  const Value: TAlignment);
var
  cellprop: TCellProperties;
begin
  CheckIndexRange(ACol, ARow);
  cellprop := CellProperties[ACol, ARow];
  if (cellprop = nil) then
    cellprop := MakeCellProp(ACol, ARow);
  if CellProp.merged then
    cellprop := CellProperties[cellprop.block.Left, cellprop.block.top];

  cellprop.halign := Value;
  InvalidateCell(ACol, ARow);
end;

procedure TExtStringGrid.SetCellLocked(ACol, ARow: integer;
  const Value: boolean);
var
  cellprop: TCellProperties;
begin
  CheckIndexRange(ACol, ARow);
  cellprop := CellProperties[ACol, ARow];
  if (cellprop = nil) then
    cellprop := MakeCellProp(ACol, ARow);
  if CellProp.merged then
    cellprop := CellProperties[cellprop.block.Left, cellprop.block.top];

  cellprop.locked := Value;
  InvalidateCell(ACol, ARow);
end;

procedure TExtStringGrid.SetCellVAlignment(ACol, ARow: integer;
  const Value: TTextLayout);
var
  cellprop: TCellProperties;
begin
  CheckIndexRange(ACol, ARow);
  cellprop := CellProperties[ACol, ARow];
  if (cellprop = nil) then
    cellprop := MakeCellProp(ACol, ARow);
  if CellProp.merged then
    cellprop := CellProperties[cellprop.block.Left, cellprop.block.top];

  cellprop.valign := Value;
  InvalidateCell(ACol, ARow);
end;

procedure TExtStringGrid.SetColCount(const Value: Integer);
var
  i: integer;
begin
  if Value < ColCount then
  begin
    for i := Value to ColCount - 1 do
      Cols[i].Clear;
  end;
  {if Value > ColCount then
      for i := ColCount to Value - 1 do
          FColumnProps.Add(TColumnProperties.Create);
  if Value < ColCount then
  begin
      for i := Value to ColCount - 1 do
          Cols[i].Clear;
      FColumnProps.Count := Value;
  end;}
  inherited ColCount := Value;
end;

procedure TExtStringGrid.SetColumnCount(NewCount: Integer);
begin
  if (FLayoutFlag > 0) or (csLoading in ComponentState) then
    exit;
  inc(FLayoutFlag);
  ColCount := NewCount;
  dec(FLayoutFlag);
end;

procedure TExtStringGrid.SetColumns(const Value: TExtStringGridColumns);
begin
  Columns.Assign(Value);
end;

procedure TExtStringGrid.SetLockedCell(const Value: TLockedCell);
begin
  FLockedCell.Assign(Value);
end;

procedure TExtStringGrid.SetOnAfterDrawCell(const Value: TDrawCellEvent);
begin
  FOnAfterDrawCell := Value;
end;

procedure TExtStringGrid.SetOnBeforeDrawCell(const Value: TDrawCellEvent);
begin
  FOnBeforeDrawCell := Value;
end;

procedure TExtStringGrid.SetOnCellClick(const Value: TMouseClickEvent);
begin
  FOnCellClick := Value;
end;

procedure TExtStringGrid.SetOnFixedCellClick(
  const Value: TMouseClickEvent);
begin
  FOnFixedCellClick := Value;
end;

procedure TExtStringGrid.SetRowCount(const Value: Integer);
var
  i, j: integer;
begin
  if Value < RowCount then
  begin
    for i := Value to RowCount - 1 do
    begin
      for j := 0 to ColCount - 1 do
        with ColumnProperties[j] do
          if Assigned(FCellProps) and (FCellProps.Count > Value) then
            FCellProps.Count := Value;
      Rows[i].Clear;
    end;
  end;
  inherited RowCount := Value;
end;

procedure TExtStringGrid.SetSelectedIndex(const Value: Integer);
begin
  Col := Value;
end;

procedure TExtStringGrid.SetTextOptions(const Value: TTextAttrs);
begin
  FTextOptions := Value;
  Refresh;
end;

procedure TExtStringGrid.SizeChanged(OldColCount, OldRowCount: Integer);
begin
  if not (csLoading in ComponentState) and (FLayoutFlag = 0) then
  begin
    inc(FLayoutFlag);
    while Columns.count > ColCount do
      Columns[ColCount].destroy;
    while Columns.count < ColCount do
      Columns.add;
    dec(FLayoutFlag);
  end;
end;

procedure TExtStringGrid.TopLeftChanged;
begin
  HideEditor;
  inherited;
  if assigned(fBGImage) and (fbgImage.width > 0) and (fbgImage.height > 0) then
    invalidatergn(handle, 0, false);

  if FCellEditor <> nil then
    DrawEditor(Col, Row);
end;

procedure TExtStringGrid.TriggerMouseEnterEvent(Shift: TShiftState; X, Y:
  Integer);
{ Triggers the OnMouseEnter event.  }
begin
  if assigned(FOnMouseEnter) then
    FOnMouseEnter(Self, Shift, X, Y);
end; { TriggerMouseEnterEvent }

procedure TExtStringGrid.TriggerMouseLeaveEvent(Shift: TShiftState; X, Y:
  Integer);
{ Triggers the OnMouseLeave event. }
begin
  if assigned(FOnMouseLeave) then
    FOnMouseLeave(Self, Shift, X, Y);
end; { TriggerMouseLeaveEvent }

procedure TExtStringGrid.UngroupCells(ACol, ARow: integer);
var
  i, j: integer;
  cellprops, c: TCellProperties;
begin
  CheckIndexRange(ACol, ARow);
  cellprops := CellProperties[ACol, ARow];
  if (cellprops <> nil) and (cellprops.merged) then
    for i := cellprops.block.Left to cellprops.block.Right do
      for j := cellprops.block.Top to cellprops.block.Bottom do
      begin
        c := CellProperties[i, j];
        if (c <> nil) then
          c.merged := false;
      end;
  Refresh;
end;

procedure TExtStringGrid.UnlockPaint;
begin
  if (FPaintLock > 0) then
    Dec(FPaintLock);
  if (FPaintLock = 0) then
    Repaint;
end;

procedure TExtStringGrid.SetCachedUpdates(const Value: Boolean);
var
  i: integer;
begin
  FCachedUpdates := Value;
  //对记录行标志的处理
  //if FCachedUpdates then
  for i := 0 to FLineProps.Count - 1 do
    LineProperties[i].State := gdsUnmodified;
end;

procedure TExtStringGrid.CancelUpdates;
var
  i: integer;
begin
  if not CachedUpdates then
    Exit;
  FCachedUpdates := False;
  for i := FLineProps.Count - 1 downto 0 do
  begin
    if LineProperties[i].State = gdsUnmodified then
      Continue;
    if Assigned(FOnCancelUpdate) then
      FOnCancelUpdate(Self, i, LineProperties[i].State);
    if LineProperties[i].State = gdsDeleted then
      RowHeights[i] := LineProperties[i].RowHeight;
    if LineProperties[i].State = gdsInserted then
      DeleteRow(i);
    LineProperties[i].State := gdsUnmodified;
  end;
  FCachedUpdates := True;
end;

procedure TExtStringGrid.Update;
var
  i: integer;
begin
  if not CachedUpdates then
    Exit;
  FCachedUpdates := False;
  for i := FLineProps.Count - 1 downto 0 do
  begin
    if LineProperties[i].State = gdsUnmodified then
      Continue;
    if Assigned(FOnUpdateRecord) then
      FOnUpdateRecord(Self, i, LineProperties[i].State);
    if LineProperties[i].State = gdsDeleted then
      DeleteRow(i);
    LineProperties[i].State := gdsUnmodified;
  end;
  FCachedUpdates := True;
end;

function TExtStringGrid.GetLineProps(ARow: integer): TLineProperties;
var
  i: integer;
begin
  CheckIndexRange(0, ARow);
  if FLineProps.Count <= ARow then
    FLineProps.Count := ARow + 1;
  if not Assigned(FLineProps[ARow]) then
    FLineProps[ARow] := TLineProperties.Create;
  result := TLineProperties(FLineProps[ARow]);
end;

procedure TExtStringGrid.SetUseMultiTitle(const Value: Boolean);
begin
  FUseMultiTitle := Value;
  if FUseMultiTitle then
    CalcTitleHeight
  else
    RowHeights[0] := DefaultRowHeight;
  Invalidate;
end;

procedure TExtStringGrid.SetFixedLineColor(const Value: TColor);
begin
  FFixedLineColor := Value;
  Invalidate;
end;

procedure TExtStringGrid.SetGridLineColor(const Value: TColor);
begin
  FGridLineColor := Value;
  Invalidate;
end;

procedure TExtStringGrid.SetSelectedColor(const Value: TColor);
begin
  FSelectedColor := Value;
  Invalidate;
end;

procedure TExtStringGrid.SetSelectedTextColor(const Value: TColor);
begin
  FSelectedTextColor := Value;
  Invalidate;
end;

procedure TExtStringGrid.Sort(Col: Integer);
begin
  Sort(Col,nil,nil);
end;

procedure TExtStringGrid.Sort(col: integer; compare: TCompareProc;
  swap: TSwapProc);
begin
  if not assigned(compare) then
    compare := CompareProc;

  if not assigned(swap) then
    swap := LSwapProc;

  quickSort(col, FixedRows, RowCount - 1, compare, swap);
end;

procedure TExtStringGrid.QuickSort(col, bottom, top: integer;
  compare: TCompareProc; swap: TSwapProc);
var
  up, down, pivot: integer;
begin
  down := top;
  up := bottom;
  pivot := (top + bottom) div 2;

  repeat
    while compare(self, col, up, pivot) < 0 do
      inc(up);

    while compare(self, col, down, pivot) > 0 do
      dec(down);

    if up <= down then
    begin
      swap(self, ColCount{col}, up, down);
      if pivot = up then
        pivot := down
      else if pivot = down then
        pivot := up;
      inc(up);
      dec(down);
    end;
  until up > down;

  if bottom < down then
    quickSort(col, bottom, down, compare, swap);

  if up < top then
    QuickSort(col, up, top, compare, swap);
end;

procedure TExtStringGrid.SetFixedFont(const Value: TFixedFont);
begin
  FFixedFont.Assign(Value);
end;

procedure TExtStringGrid.SetFTitleColor(const Value: TColor);
begin
  FTitleColor := Value;
  Invalidate;
end;

procedure TExtStringGrid.CalcTitleHeight;
var
  i, H, Index: integer;
  n, W: integer;
  TitleRows, TitleHeights: Integer;
  s, sTitle: string;
  str: string;
begin
  fMultiTitleHeight := DefaultRowHeight;
  for Index := 0 to Columns.Count - 1 do
  begin
    SetLength(Columns[Index].Title.fMultiTitleHeights, 0);
    TitleRows := 0;
    TitleHeights := 0;
    sTitle := Columns[index].Title.Caption + '|';
    str := '';
    s := '';
    for i := 1 to Length(sTitle) do
    begin
      if sTitle[i] = '|' then
      begin
        Inc(TitleRows);
        Canvas.Font := Columns[Index].Title.Font;
        W := ColWidths[Index];
        for n := Index - 1 downto 0 do
          if (Pos(str + '|' + S + '|', Columns[n].Title.Caption) = 1) or
            (Pos(str + S + '|', Columns[n].Title.Caption) = 1) then
            W := W + Columns[n].Width
          else
            Break;
        for n := Index + 1 to Columns.Count - 1 do
          if (Pos(str + '|' + S + '|', Columns[n].Title.Caption) = 1) or
            (Pos(str + S + '|', Columns[n].Title.Caption) = 1) then
            W := W + Columns[n].Width
          else
            Break;
        H := 4 + WriteText(Canvas,
          Rect(0, 0, W - 4, 0),
          False,
          2, 2, s,
          Columns[Index].Title.Alignment, tlCenter,
          True, False, 0, 0, UseRightToLeftReading,
          True);
        if H < DefaultRowHeight then
          H := DefaultRowHeight;
        TitleHeights := TitleHeights + H + GridLineWidth;
        if TitleRows > Length(Columns[Index].Title.fMultiTitleHeights) then
        begin
          SetLength(Columns[Index].Title.fMultiTitleHeights, TitleRows);
          Columns[Index].Title.fMultiTitleHeights[TitleRows - 1] := H;
        end;
        if str = '' then
          str := s
        else
          str := str + '|' + s;
        s := '';
      end
      else
        s := s + sTitle[i];
    end;
    if TitleHeights > fMultiTitleHeight then
      fMultiTitleHeight := TitleHeights;
  end;

  if RowHeights[0] > 0 then
    //if fMultiTitleHeight > RowHeights[0] then
      RowHeights[0] := fMultiTitleHeight;

  for Index := 0 to Columns.Count - 1 do
  begin
    sTitle := Columns[index].Title.Caption;
    s := sTitle;
    W := 1;
    for I := Length(sTitle) downto 1 do
      if sTitle[I] = '|' then
        Inc(W)
      else if W = 1 then
        Delete(S, I, 1);
    for I := Index - 1 downto 0 do
      if Pos(S, Columns[I].Title.Caption) = 1 then
        for n := 0 to W - 1 do
        begin
          if Columns[I].Title.fMultiTitleHeights[n] > Columns[Index].Title.fMultiTitleHeights[n] then
            Columns[Index].Title.fMultiTitleHeights[n] := Columns[I].Title.fMultiTitleHeights[n];
        end
      else
        Break;
    for I := Index + 1 to ColCount - 1 do
      if Pos(S, Columns[I].Title.Caption) = 1 then
        for n := 0 to W - 1 do
        begin
          if Columns[I].Title.fMultiTitleHeights[n] > Columns[Index].Title.fMultiTitleHeights[n] then
            Columns[Index].Title.fMultiTitleHeights[n] := Columns[I].Title.fMultiTitleHeights[n];
        end
      else
        Break;
    H :=0;
    for n:=0 to W-1 do
      H := H + Columns[Index].Title.fMultiTitleHeights[n] + GridLineWidth;
    if H<RowHeights[0] then
      Columns[Index].Title.fMultiTitleHeights[W-1] := Columns[Index].Title.fMultiTitleHeights[W-1] + (RowHeights[0]-H);
  end;
end;

procedure TExtStringGrid.SetOptionsEx(const Value: TGridOptionsEx);
begin
  FOptionsEx := Value;
  Invalidate;
end;

procedure TExtStringGrid.ColWidthsChanged;
begin
  if UseMultiTitle and Assigned(Parent) then
    CalcTitleHeight;
  inherited;
end;

procedure TExtStringGrid.RowHeightsChanged;
begin
  inherited;
end;

procedure TExtStringGrid.DrawEditor(ACol, ARow: integer);
var
  Rect: TRect;

  procedure AdjustRect;
  begin
    Rect.TopLeft := Self.ScreenToClient(ClientToScreen(Rect.TopLeft));
    Rect.BottomRight := Self.ScreenToClient(ClientToScreen(Rect.BottomRight));
  end;
begin
  {if Columns[ACol].Editor = nil then
    exit;

  if assigned(FOnDrawEditor) then
    OnDrawEditor(self, ACol, ARow, Columns[ACol].Editor)
  else
    Columns[ACol].ShowEditor(ARow);}
  if FCellEditor = nil then Exit;

  if Assigned(FOnDrawEditor) then
    OnDrawEditor(self, ACol, ARow, FCellEditor)
  else begin
      Rect := CellRect(ACol, ARow);
      AdjustRect;

      if (FCellEditor is TMetaCellEditor) then
        with (FCellEditor as TMetaCellEditor).Editor do begin
          Color := Columns[ACol].Color;
          Font := Columns[ACol].Font;
        end;

      if not IsRectEmpty(Rect) then
        FCellEditor.Draw(Rect);
  end;
end;

procedure TExtStringGrid.DestroyWnd;
var
  c: integer;
begin
  for c := 0 to Columns.count - 1 do
    if Columns[c].FEditor <> nil then
      Columns[c].FEditor.GridWndDestroying;

  inherited DestroyWnd;
end;

procedure TExtStringGrid.WMCommand(var Message: TWMCommand);
var
  Control: TWinControl;
begin
  Control := FindControl(Message.Ctl);
  if Control is TCheckBox then
    with TMessage(Message) do
      Result := Control.Perform(Msg + CN_BASE, WParam, LParam)
  else
    inherited;
end;

procedure TExtStringGrid.WMChar(var Msg: TWMChar);
begin
  if (goEditing in Options) and (char(Msg.CharCode) in [#32..#255]) then
    LastChar := Msg.CharCode
  else
    LastChar := 0;

  inherited;
end;

{ TFixedFont }

constructor TFixedFont.Create;
begin
  inherited;
  FFixedFont := TFont.Create;
  FUseFixed := False;
  FParentAlign := True;
  FAlignHoriz := taLeftJustify;
  FAlignVert := tlTop;
end;

destructor TFixedFont.Destroy;
begin
  FFixedFont.Free;
  inherited;
end;

procedure TFixedFont.SetAlignHoriz(const Value: TAlignment);
begin
  FAlignHoriz := Value;
  FParentAlign := False;
end;

procedure TFixedFont.SetAlignVert(const Value: TTextLayout);
begin
  FAlignVert := Value;
  FParentAlign := False;
end;

procedure TFixedFont.SetFont(const Value: TFont);
begin
  FFixedFont.Assign(Value);
end;

{ TLockedCell }

procedure TLockedCell.Assign(const Source: TLockedCell);
begin
  FFont.Assign(Source.FFont);
  FBackColor := Source.FBackColor;
  FUseLockedFont := Source.FUseLockedFont;
end;

constructor TLockedCell.Create;
begin
  inherited;
  FFont := TFont.Create;
  FBackColor := clWindow;
  FUseLockedFont := False;
end;

destructor TLockedCell.Destroy;
begin
  FFont.Free;
  inherited;
end;

function TLockedCell.GetForeColor: TColor;
begin
  Result := FFont.Color;
end;

procedure TLockedCell.SetBackColor(const Value: TColor);
begin
  FBackColor := Value;
end;

procedure TLockedCell.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TLockedCell.SetForeColor(const Value: TColor);
begin
  FFont.Color := Value;
end;

procedure TLockedCell.SetUseLockedFont(const Value: Boolean);
begin
  FUseLockedFont := Value;
end;

{ TExtStringGridColumns }

function TExtStringGridColumns.Add: TColumnProperties;
begin
  Result := TColumnProperties(inherited Add);
end;

constructor TExtStringGridColumns.Create(Grid: TExtStringGrid;
  ColumnClass: TColumnPropClass);
begin
  inherited Create(ColumnClass);
  FGrid := Grid;
end;

function TExtStringGridColumns.GetColumn(Index: Integer): TColumnProperties;
begin
  Result := TColumnProperties(inherited Items[Index]);
end;

function TExtStringGridColumns.GetOwner: TPersistent;
begin
  Result := FGrid;
end;

procedure TExtStringGridColumns.SetColumn(Index: Integer; Value:
  TColumnProperties);
begin
  Items[Index].Assign(Value);
end;

procedure TExtStringGridColumns.Update(Item: TCollectionItem);
begin
  if (FGrid = nil) or (csLoading in FGrid.ComponentState) then
    Exit;

  if (csDesigning in FGrid.ComponentState) then
    FGrid.invalidate
  else
    FGrid.invalidatecol(FGrid.SelectedIndex);
end;

{ TLineProperties }

constructor TLineProperties.Create;
begin
  Loaded := False;
  State := gdsUnmodified;
  RowHeight := 0;
end;

end.

