unit MyStringGrid;

interface
uses
   Winapi.Windows,System.SysUtils,Winapi.Messages,  System.Classes,Vcl.Graphics,
   Vcl.Controls,Vcl.Forms , Vcl.Dialogs, Vcl.Menus,  Vcl.StdCtrls,Vcl.ExtCtrls,
   System.Contnrs,Vcl.Grids;


type
  TAllowEndEditEvent = procedure(Sender: TObject; var Key: Word; Shift: TShiftState; var EndEdit: boolean) of object;



  TMYStringGrid = class(TStringGrid)

  private
      procedure SetCellVAlignment(ACol, ARow: integer;   const Value: TTextLayout);
      function GetCellVAlignment(ACol, ARow: integer): TTextLayout;
  public
      property CellVAlignment[ACol, ARow: integer]: TTextLayout read
       GetCellVAlignment write SetCellVAlignment;
  end;


  TCellEditor = class(TComponent)     // Base class for all cell editors
  private
    FGridLastChar: Integer;
    FDefaultText: string;
    FGrid: TStringGrid;
    FReferences: integer;
    FAllowEndEditEvent: TAllowEndEditEvent;
    function GetGrid: TMYStringGrid;
  protected
    procedure Attatch(AGrid: TMYStringGrid); virtual;
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
    property Grid: TMYStringGrid read GetGrid;
    property References: integer read FReferences;
  published
    property AllowEndEditEvent: TAllowEndEditEvent read FAllowEndEditEvent write FAllowEndEditEvent;
  end;




   TCellProperties = class(TObject)
  private
    FGrid: TMYStringGrid;
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
    constructor Create(AOwner: TMYStringGrid);
    destructor Destroy; override;
    procedure MakeBitmap;
    property font: TFont read Ffont write Setfont;
    property color: TColor read Fcolor write Setcolor;
    property GroupBitmap: TBitmap read FGroupBitmap;
    property HAlign: TAlignment read FHAlign write SetHAlign;
    property VAlign: TTextLayout read FVAlign write SetVAlign;
    property Editor: TCellEditor read FEditor write SetEditor;
  end;

  TColumnProperties = class(TCollectionItem)
  private
    FInternalCol: Longint;

    FHAlign: TAlignment;
    FVAlign: TTextLayout;


    procedure SetHAlign(const Value: TAlignment);
    procedure SetVAlign(const Value: TTextLayout);
    function IsHAlignmentStored: Boolean;
    function IsVAlignmentStored: Boolean;
  protected

    procedure RefreshDefaultFont;
  public
    parentfont, locked, parentcolor, parentalign: Boolean;
    FCellProps: TObjectList;
    constructor Create(Collection: TCollection); override;
    destructor destroy; override;
    procedure Clear;

  published

    property HAlign: TAlignment read FHAlign write SetHAlign stored
      IsHAlignmentStored;
    property VAlign: TTextLayout read FVAlign write SetVAlign stored
      IsVAlignmentStored;

  end;


implementation

{ TMYStringGrid }

function TMYStringGrid.GetCellVAlignment(ACol, ARow: integer): TTextLayout;
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

procedure TMYStringGrid.SetCellVAlignment(ACol, ARow: integer;
  const Value: TTextLayout);
begin
end;

end.