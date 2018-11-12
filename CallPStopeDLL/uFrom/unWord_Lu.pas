unit unWord_Lu;
(*
By ¬��־ ��д 2013.09.06 Email:lgz2050@163.com
*)
interface
uses Word2000, ActiveX, Variants, Dialogs, SysUtils;
type
    TMyWord = class(TObject)
    private

        procedure connectword();
    public
        FWord: TWordApplication;        //word����
        FDoc: TWordDocument;            //�ĵ�����
        //�ļ��Ƿ���ʾ
        procedure WordVis(Vis:Boolean);
        //���ĵ�
        procedure OpenWord(sFileName:string);
        //����
        procedure AddReturn();
        //��������
        procedure SetFont(FontName: string; FontSize: Integer;
                   FontBold: Boolean = False; FontUnderline: Boolean = False);
        //�������
        function AddTable(Col, Row: Integer): Table;
        //���ñ���ɫ
        procedure SetTableBack(BackColor: ToleEnum);
        //�������
        procedure MoveDown(num: Integer = 1);
        //ѡ������
        procedure SelectDown(num: Integer = 1);
        //�������
        procedure Moveup();
        //�������
        procedure MoveRight(num: Integer = 1);
        //ѡ������
        procedure SelectRight(num: Integer = 1);
        //д��
        procedure WriteText(Text: string);
        //����ʽ����һ�м�¼
        //��AddLine "��ע","����"
        //AddLine 'kk',"���� 1"
        procedure SetHeading(ititle:string;Level:integer);
        procedure AlignLine(Align: ToleEnum);
        //�����ҳ��
        procedure insertPage();
        //�������ҳ��
        procedure insertPagenum();
        //��������
        procedure insertDate();
        //���ñ���һ�п���
        procedure SetTable(PTable: Table; ColumnIdx: Integer; Width: Integer);
        //���ñ���һ�и߶�
        procedure SetTableheight(PTable: Table; RowIdx: Integer; height:
        Integer);
        //����Ŀ¼
        procedure InsertContents();
        //������ǩ
        procedure createBookMark(BookMarkName: string);
        //�ƶ�����ǩ
        procedure GotoBookMark(BookMarkName: string);
        //ճ��
        procedure paste();
        //�滻
        procedure Replace(Source, Target: string);
        //����
        procedure Save(FileName: string);
        //����ͼƬ
        procedure AddPicture(FileName: string);
        //�Ƶ����
        procedure MoveEnd();
        //�ϲ�
        procedure CellsMerge();
        //�ر�Word
        procedure Close;
        constructor Create;
        destructor Destroy; override;
end;


implementation

constructor TMyWord.Create();
begin
    inherited Create;
    Connectword();

end;
 
procedure TMyWord.connectword();
var
B: Boolean;
begin
   B := False;
   if (FWord = nil) then
            B := True
    else   begin
        try
        FDoc.Activate;
        except
            B := True;
        end;
 
    end;
 
    if not B then Exit;
    FWord := TWordApplication.Create(nil); //word����
    FDoc := TWordDocument.Create(nil);  //�ĵ�����

end;
procedure TMyWord.OpenWord(sFileName:string);
var
  //���ļ��Ĳ���
  FileName,CfCversions,ReadOnly,AddToRctFiles,PswDocument,PswTemplate,Revert,
  WPswDocument,WPswTemplate,Format,Encoding,Visible,OpenAndRepair,
  DocumentDirection,NoEncodingDialog,XMLTransform:OleVariant;
  docinx:OleVariant;
begin

// ===== ���ļ� =====
        docinx:=1;
        FWord.Visible := false;
        FileName:=sFileName;
        CfCversions :=  false;
        ReadOnly:=False;
        AddToRctFiles:= false;
        PswDocument:= '';
        PswTemplate:= '';
        Revert:=true;
        WPswDocument:= '';//�ĵ�����
        WPswTemplate:= '';//ģ������
        Format:= EmptyParam;
        Encoding:= '';
        Visible:=true;
        OpenAndRepair:= EmptyParam;
        DocumentDirection:= EmptyParam;
        NoEncodingDialog:= EmptyParam;
        XMLTransform:=EmptyParam;
  if sFileName='' then  begin //�������ĵ�
      FWord.Connect;
      FDoc.Activate;

  end else begin   //���ĵ�
     {
      const FileName: OleVariant; const ConfirmConversions: OleVariant;
                  const ReadOnly: OleVariant; const AddToRecentFiles: OleVariant;
                  const PasswordDocument: OleVariant; const PasswordTemplate: OleVariant;
                  const Revert: OleVariant; const WritePasswordDocument: OleVariant;
                  const WritePasswordTemplate: OleVariant; const Format: OleVariant;
                  const Encoding: OleVariant; const Visible: OleVariant;
                  const OpenAndRepair: OleVariant; const DocumentDirection: OleVariant;
                  const NoEncodingDialog: OleVariant; const XMLTransform: OleVariant


     }

       FWord.Documents.open(FileName,CfCversions,ReadOnly,AddToRctFiles,PswDocument,
       PswTemplate,Revert,WPswDocument,WPswTemplate,Format,Encoding,Visible
          );
//       ,OpenAndRepair,DocumentDirection,NoEncodingDialog,XMLTransform);
         FDoc.ConnectTo(FWord.documents.Item(docinx));

      // 
  end;

   FWord.Visible := true;


 end;
destructor TMyWord.Destroy;
begin
    //
    //FDoc.SaveAs('c:/1.doc');
    FDoc.Free;
    FWord.Disconnect;
    //�˳�һ���˳�word,by yl 2005.2.2
    //FWord.Quit;
    //FWord.Free;
    inherited Destroy;
end;
procedure TMyWord.WordVis(Vis:Boolean);
begin
     FWord.Visible:=Vis;
end;
procedure TMyWord.AddReturn();
begin
    try
    FWord.Selection.TypeParagraph;
    except
        AddReturn();
    end;
 
end;
 
procedure TMyWord.SetFont(FontName: string; FontSize: Integer; FontBold:
Boolean
= False; FontUnderline: Boolean = False);
begin
    try
    //connectword();
      FWord.Selection.Font.Name := FontName;
      FWord.Selection.Font.Size := FontSize;
      if FontBold then
      FWord.Selection.Font.Bold := wdToggle;
      if FontUnderline then
      FWord.Selection.Font.Underline := wdUnderlineSingle;
    except
        SetFont(FontName, FontSize, FontBold, FontUnderline);
    end;
 
end;
 
procedure TMyWord.SetHeading(ititle: string; Level: integer);
 {   Level = 1 һ������ ����  �Ӻ�
             2 �������� left  �Ӻ�
             3 �������� left  �Ӻ�
             4 �ļ�����  ����  ��
             5 �弶����  ����  ͼ
             10 ����
   FontSize �����ֺ�
   Alin ���з�ʽ 0 left 1 center  2 right
   }

var
  outStyle: Style;
  v: olevariant;
  FSize,Alin,Spac,Bld:integer;
  Style_index:integer;
begin

    if (Level=4) or (Level=5) then  begin  //
       FSize:=10;
       Bld:=1;
       Alin:=1;
       Spac:=0;
    end else if (Level=1) then  begin
       FSize:=16;
       Bld:=1;
       Alin:=1;
       Spac:=13;
    end else if (Level=2) then  begin
       FSize:=16;
       Bld:=1;
       Alin:=0;
       Spac:=13;
    end else begin  // ������������������
       FSize:=14;
       Bld:=1;
       Alin:=0;
       Spac:=13;
    end;

    if ititle='��¼X' then  begin
       FSize:=14;
       Bld:=1;
       Alin:=0;
       Spac:=0;
    end;

    //Ѱ�ұ��������
    Style_index:=ReturnHeadingIndex(Level);

    WriteText(ititle,0);                       //����һ��
    try
         outStyle := FWord.ActiveDocument.Styles.Item(Style_index);
         outStyle.Font.Size :=FSize;
         outStyle.Font.Bold:= Bld;
         v := outStyle;
         FWord.Selection.Set_Style(v);
    except
         outStyle := FWord.ActiveDocument.Styles.Item(Style_index);
         outStyle.Font.Size :=FSize;
         outStyle.Font.Bold :=Bld;
         v := outStyle;
         FWord.Selection.Set_Style(v);
    end;
   FWord.Selection.ParagraphFormat.Alignment :=Alin;
   FWord.Selection.ParagraphFormat.SpaceBefore :=Spac;
   FWord.Selection.ParagraphFormat.SpaceAfter :=Spac;
   FWord.Selection.Typeparagraph;

end;

//�������
function TMyWord.AddTable(Col, Row: Integer): Table;
var
DefaultTable: olevariant;
begin
    try
    connectword();
    DefaultTable := 1;
    Result := FDoc.Tables.Add(FWord.Selection.Range, Row, Col, DefaultTable,
    EmptyParam);
    except
        ShowMessage(Format('��%d,��%d', [Col, Row]));
        AddTable(Col, Row);
    end;
 
end;
 
//���ñ���ɫ
procedure TMyWord.SetTableBack(BackColor: ToleEnum);
begin
    try
    //connectword();
    FWord.Selection.Cells.Shading.BackgroundPatternColor := BackColor;
    except
        SetTableBack(BackColor);
    end;
 
end;
 
//ѡ������
procedure TMyWord.SelectDown(num: Integer = 1);
var
Unit_: olevariant;
Count: olevariant;
Extend: olevariant;
begin
    try
    //connectword();
    Count := num;
    Unit_ := wdLine;
    Extend := wdExtend;
    FWord.Selection.MoveDown(Unit_, Count, Extend);
    except
        MoveDown();
    end;
 
end;
 
//�������
procedure TMyWord.MoveDown(num: Integer = 1);
var
Unit_: olevariant;
Count: olevariant;
Extend: olevariant;
begin
    try
    //connectword();
    Count := num;
    Unit_ := wdLine;
    FWord.Selection.MoveDown(Unit_, Count, Extend);
    except
        MoveDown();
    end;
 
end;
 
//�������
procedure TMyWord.Moveup();
var
Unit_: olevariant;
Count: olevariant;
Extend: olevariant;
begin
    Unit_ := wdLine;
    Count := 1;
    FWord.Selection.Moveup(Unit_, Count, Extend);
end;
 
//ѡ������
procedure TMyWord.SelectRight(num: Integer = 1);
var
Unit_: olevariant;
Count: olevariant;
Extend: olevariant;
begin
    try
    //connectword();
    Unit_ := wdCharacter;
    Count := num;
    Extend := wdExtend;
    FWord.Selection.MoveRight(Unit_, Count, Extend);
    except
        MoveRight();
    end;
 
end;
 
//�������
procedure TMyWord.MoveRight(num: Integer = 1);
var
Unit_: olevariant;
Count: olevariant;
Extend: olevariant;
begin
    try
    //connectword();
       Unit_ := wdCell;
       Count := num;
       FWord.Selection.MoveRight(Unit_, Count, Extend);
    except
        MoveRight();
    end;
 
end;
 
//д��
procedure TMyWord.WriteText(Text: string);
begin
    try
    //connectword();
    FWord.Selection.TypeText(Text);
    except                              //��ֹ����ʧ��
        WriteText(Text);
    end;
 
end;

procedure TMyWord.AlignLine(Align: ToleEnum);
begin
    FWord.Selection.ParagraphFormat.Alignment := Align;
end;
 
//�����ҳ��
procedure TMyWord.insertPage();
var
_Type: olevariant;
begin
    _Type := 7;
    FWord.Selection.InsertBreak(_Type);
end;
 
//��������
procedure TMyWord.insertDate();
var
DateTimeFormat: olevariant;
InsertAsField: olevariant;
InsertAsFullWidth: olevariant;
DateLanguage: olevariant;
CalendarType: olevariant;
begin
    try
    InsertAsField := False;
    InsertAsFullWidth := False;
    DateTimeFormat := 'yyyy''��''M''��''d''��''';
    DateLanguage := wdSimplifiedChinese;
    CalendarType := wdCalendarWestern;
    FWord.Selection.InsertDateTime(DateTimeFormat, InsertAsField,
    InsertAsFullWidth, DateLanguage, CalendarType);
    except
        insertDate();
    end;
 
end;
 
//����ҳ��
procedure TMyWord.insertPagenum();
var
PSection: Section;
PageNumberAlignment: olevariant;
FirstPage: olevariant;
begin
    PSection := FWord.Selection.Sections.Item(1);
    PageNumberAlignment := 1;           //�м�
    FirstPage := True;
    PSection.Footers.Item(wdHeaderFooterPrimary).PageNumbers.Add(PageNumberAlignment, FirstPage);
end;
 
//���ñ���һ�и߶�
procedure TMyWord.SetTableheight(PTable: Table; RowIdx: Integer; height:
Integer);
var
Prow: Row;
begin
    Prow := PTable.Rows.Item(RowIdx);
    Prow.SetHeight(height, wdAdjustNone);
end;
 
//���ñ���һ�п���
procedure TMyWord.SetTable(PTable: Table; ColumnIdx: Integer; Width:
Integer);
begin
    PTable.Columns.Item(ColumnIdx).SetWidth(Width, wdAdjustNone);
end;
 
//����Ŀ¼
procedure TMyWord.InsertContents();
var
    pRange:WordRange;
    UseHeadingStyles: olevariant;
    UpperHeadingLevel: olevariant;
    LowerHeadingLevel: olevariant;
    UseFields: olevariant;
    TableID: olevariant;
    RightAlignPageNumbers: olevariant;
    IncludePageNumbers: olevariant;
    AddedStyles: olevariant; UseHyperlinks: olevariant;
    HidePageNumbersInWeb: olevariant;
begin
//    with FWord.ActiveDocument do
//    begin
//        pRange := FWord.Selection.Range;
//        RightAlignPageNumbers := True;
//        UseHeadingStyles := True;
//        UpperHeadingLevel := 1;
//        LowerHeadingLevel := 3;
//        IncludePageNumbers := True;
//        UseHyperlinks := True;
//        HidePageNumbersInWeb := True;
//        TablesOfContents.Add
//           (   pRange, UseHeadingStyles,
//              UpperHeadingLevel,
//              LowerHeadingLevel,
//              UseFields,
//              TableID,
//              RightAlignPageNumbers,
//              IncludePageNumbers,
//              AddedStyles, UseHyperlinks,
//              HidePageNumbersInWeb
//           );
//        TablesOfContents.Item(1).TabLeader := wdTabLeaderDots;
//        TablesOfContents.Format := wdIndexIndent;
//    end;
//
end;
 
//������ǩ
procedure TMyWord.createBookMark(BookMarkName: string);
var
pRange: olevariant;
begin
    pRange := FWord.Selection.Range;
    with FWord.ActiveDocument.Bookmarks do
    begin
        Add(BookMarkName, pRange);
        DefaultSorting := wdSortByName;
        ShowHidden := False;
    end;
 
end;
 
//�ƶ�����ǩ
procedure TMyWord.GotoBookMark(BookMarkName: string);
var
What: olevariant;
Which: olevariant;
Count: olevariant;
Name: olevariant;
begin
    What := wdGoToBookmark;
    Name := 'BEGIN';
    FWord.Selection.GoTo_(What,
    Which,
    Count,
    Name)
end;
 
//ճ��
procedure TMyWord.paste();
begin
    FWord.Selection.paste;
end;
 
//�滻
procedure TMyWord.Replace(Source, Target: string);
var
FindText: olevariant;
PWrap: olevariant;
ReplaceWith: olevariant;
Replace: olevariant;
begin
    FWord.Selection.Find.ClearFormatting;
    FWord.Selection.Find.Replacement.ClearFormatting;
    FindText := Source;
    PWrap := wdFindContinue;
    ReplaceWith := Target;
    Replace := wdReplaceAll;
    with FWord.Selection.Find do
    begin
        {Text := source;
        Replacement.Text := Target;
        forward := True;
        Wrap := wdFindContinue;
        Format := False;
        MatchCase := False;
        MatchWholeWord := False;
        MatchByte := True;
        MatchWildcards := False;
        MatchSoundsLike := False;
        MatchAllWordForms := False;
        }
        Execute(FindText, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
        EmptyParam,
        EmptyParam, PWrap, EmptyParam, ReplaceWith, Replace, EmptyParam,
        EmptyParam, EmptyParam, EmptyParam);
    end;
 
end;
 
//����
procedure TMyWord.Save(FileName: string);
var
OFilename: olevariant;
begin
    OFilename := FileName;
    FDoc.SaveAs(OFilename);
end;
 
//����ͼƬ
procedure TMyWord.AddPicture(FileName: string);
var
LinkToFile, SaveWithDocument, Range: olevariant;
//index: olevariant;
begin
    //index := 0;
    //Range := FDoc.Bookmarks.Item(index).Range;
    //Range:=Fdoc.GoTo_;
    Range := Self.FWord.Selection.Range;
    LinkToFile := False;
    SaveWithDocument := True;
    FWord.Selection.InlineShapes.AddPicture(FileName, LinkToFile,
    SaveWithDocument, Range)
end;
 
//�Ƶ����
procedure TMyWord.MoveEnd();
var
Unit_: olevariant;
Extend: olevariant;
begin
    Unit_ := wdStory;
    Extend := wdMove;
    FWord.Selection.EndKey(Unit_, Extend);
end;
 
//�ϲ�
procedure TMyWord.CellsMerge();
begin
    FWord.Selection.Cells.Merge;
end;
 
procedure TMyWord.Close;
begin
  FWord.Quit ;

end;

initialization
finalization
{ if FMyWord <> nil then
FMyWord.Free;
}
end.