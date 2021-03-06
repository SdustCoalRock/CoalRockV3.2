unit uCallSupportWeigth;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,ComObj,Vcl.Grids,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  System.ImageList, Vcl.ImgList;

type
  TFormSupweigth= class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ImageList1: TImageList;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    AddButton: TToolButton;
    EditTest1: TToolButton;
    SaveButton: TToolButton;
    EditTest2: TToolButton;
    ExitButton: TToolButton;
    EDitTest3: TToolButton;
    Panel3: TPanel;
    Button1: TButton;
    StatusBar1: TStatusBar;
    Left_GB: TGroupBox;
    Memo_WorkFace: TMemo;
    Panel4: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EDitTest3Click(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure EditTest1Click(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }

    MyStringGrid:TStringGrid;


    procedure CreatePublic;
    procedure InitStringGrod;
    procedure FillStringGrid;
    function  GetSupportWigthRows:integer;
    function  GetSupportWigthCols:integer;
    procedure SetRowHead;
    procedure SetColHead;
    procedure loadexcel(inrows, incols:integer; fileName:String);{ Private declarations }
    procedure SaveDataIntoClass;
    procedure OptionTip(Str: String);
    procedure DataClassDisptoStringGrid;
    //
    procedure OpenInputDataWindows;
    procedure DispComprehensiveEvaluationResult;
    // DispComprehe
    procedure ADjustPanel2;

  public
    { Public declarations }
  end;

var
  InSuPW: TFormSupweigth;

  function ShowSupportWeight(AHandle:THandle;ACaption:string;Wid,Hi:integer):integer;stdcall;
  function Show_DCE_Result(AHandle:THandle;ACaption:string;Wid,Hi:integer):integer;stdcall;
implementation

{$R *.dfm}

uses Lu_Public_BasicModual, MainCallUnit;
function ShowSupportWeight(AHandle:THandle;ACaption:string;Wid,Hi:integer):integer;stdcall;

begin
    if Assigned(InSuPW) then   FreeAndNil(InSuPW);
    InSuPW:=TFormSupweigth.Create(nil);
    try
       with InSuPW do begin
            Caption:=ACaption;
            WindowState:= wsNormal;
            ParentWindow:=Ahandle;
            if Hi >Height then
              Top :=Round((Hi-Height)/3)
            else   Top :=0;
            if Wid> Width then
                Left:=Round((Wid-Width)/2)
            else  Left:=0;
            //---------------
             OpenInputDataWindows;
            Show;
       end;
        Result:=1;//函数值
    except
         InSuPW.Free;
     end;
end;
 function Show_DCE_Result(AHandle:THandle;ACaption:string;Wid,Hi:integer):integer;stdcall;
begin
    if Assigned(InSuPW) then   FreeAndNil(InSuPW);
    InSuPW:=TFormSupweigth.Create(nil);
    try
       with InSuPW  do  begin
            Caption:=ACaption;
            WindowState:= wsNormal;
            ParentWindow:=Ahandle;
            if Hi >Height then
              Top :=Round((Hi-Height)/3)
            else   Top :=0;
            if Wid> Width then
                Left:=Round((Wid-Width)/2)
            else  Left:=0;
            //---------------
            DispComprehensiveEvaluationResult;

            Show;
       end;
        Result:=1;//函数值
    except
         InSuPW.Free;
     end;
end;
//===========
procedure TFormSupweigth.AddButtonClick(Sender: TObject);
var
  i:integer;
begin
//        //可编辑
//     if not assigned(ed) then  begin
//        ed:= TEditCellEditor.Create(MyStringGrid);
//        for i:=1 to MyStringGrid.ColCount-1 do
//             MyStringGrid.Columns[i].Editor := ed;
//        ed.
//     end;

    t_SupWeigth.ExtractDataFromDataBase;
    DataClassDisptoStringGrid;
end;

procedure TFormSupweigth.ADjustPanel2;
var
  Left1,left2,left3:integer;
  Top1,Top2,Top3,top4:integer;
  width1,height1:integer;
begin
    Left1:=10;
    Width1:=trunc((Panel4.Width-60)/3);
    Height1:=trunc((Panel4.Height -40)/4);
    left2:=left1+width1+20;
    left3:=left2+width1+20;
    top1:=5;
    top2:=top1+Height1+10;
    top3:=top2+Height1+10;
    top4:=top3+Height1+10;



end;

procedure TFormSupweigth.CreatePublic;
begin
//    t_SupWeigth.FillSupportWeight ; //填 参数数据
//    t_SupWeigth.FillCoeFFicientData;//填系数数据
    MyStringGrid:=TStringGrid.Create(nil) ;
    InitStringGrod;
    FillStringGrid;
end;

procedure TFormSupweigth.DataClassDisptoStringGrid;
var
  i:integer;
  Row,Col:Integer;
begin
    for i := 0 to t_SupWeigth.Data_Value_Count-1 do   begin
        Row:=t_SupWeigth.Data_Value[i].RowNumber;
        Col:=t_SupWeigth.Data_Value[i].ColNumber;
        MyStringGrid.Cells[Col,Row]:= FormatFloat('0.00',t_SupWeigth.Data_Value[i].value);
    end;


end;

procedure TFormSupweigth.DispComprehensiveEvaluationResult;
begin
   Panel1.Visible :=False;
     Panel3.Visible :=true;
   Panel3.Align :=alClient;
   EditTest1.Visible :=False;
   EditTest2.Visible :=False;
   EditTest3.Visible :=False;
end;

procedure TFormSupweigth.EditTest1Click(Sender: TObject);
var
 i,j:integer;
 Firstid,Secondid:integer;
 Get_Kcjscs:AnsiString;
begin
   // 主要是测试综合计算数据的正确性，测试使用
    Get_Kcjscs:=strpas(Main_CallPStope.UsePStope.Get_kcjstj('1.0'));
    t_SupWeigth.WithoutOptionMakeResult(Get_Kcjscs);
    self.SetRowHead ;
    self.SetColHead ;
    for i := 0 to t_SupWeigth.SupportInfo.Child_count-1 do
         for j:=0 to t_SupWeigth.SupportInfo.Child_Second[i].Child_Count -1 do
            MyStringGrid.Cells[t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[j].ColNumber ,
               5]:= FormatFloat('0.00',t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[j].AGV_Value);

//   //打印最后结果
    for i := 0 to t_SupWeigth.SupportInfo.Child_count-1 do begin
        Firstid:= t_SupWeigth.SupportInfo.Child_Second[i].Firstid;
        Secondid:=t_SupWeigth.SupportInfo.Child_Second[i].Secondid;
        MyStringGrid.Cells[t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[Firstid].ColNumber ,6]:=
          FormatFloat('0.00',t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[Firstid].AGV_Value);
        MyStringGrid.Cells[t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[Secondid].ColNumber ,7]:=
          FormatFloat('0.00',t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[Secondid].AGV_Value);
    end;

end;

procedure TFormSupweigth.ExitButtonClick(Sender: TObject);
begin
   Close;
end;

procedure TFormSupweigth.FillStringGrid;
begin
    SetRowHead;
    SetColHead;
end;

procedure TFormSupweigth.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
   if Assigned(FormSupportweight) then   FreeAndNil(FormSupportweight);
end;

procedure TFormSupweigth.FormCreate(Sender: TObject);
begin
     CreatePublic;
end;

procedure TFormSupweigth.FormDestroy(Sender: TObject);
begin
     if assigned(MyStringGrid) then  FreeAndNil(MyStringGrid);

end;

procedure TFormSupweigth.FormResize(Sender: TObject);
begin
     ADjustPanel2;
end;

procedure TFormSupweigth.FormShow(Sender: TObject);
begin
    PubLic_Basic.InitStatusBar(self.StatusBar1);

end;

function TFormSupweigth.GetSupportWigthCols: integer;
var
  Col,i,j:Integer;
begin
   Col:=5;
    for i := 0 to t_SupWeigth.SupportInfo.Child_count-1 do
        Col:= Col+t_SupWeigth.SupportInfo.Child_Second[i].Child_count;
    if Col < 6 then  Result:=6
       else   Result:=Col;
end;

function TFormSupweigth.GetSupportWigthRows: integer;
var
  Row,i,j:Integer;
begin
    Row:=5;
    for i := 0 to t_SupWeigth.WorkFaceInfo.Child_count-1 do
        Row:= Row+t_SupWeigth.WorkFaceInfo.Child_Second[i].Child_count;
    Result:=Row;

end;

procedure TFormSupweigth.InitStringGrod;
var
  i,j,k:integer;
begin
  with MyStringGrid do begin
         Parent:=Panel1;
         Align :=alClient ;
         RowCount :=GetSupportWigthRows;
         ColCount :=GetSupportWigthCols;
         FixedCols:=3;
         FixedRows:=4;
         Cells[round(ColCount/2),0]:=t_SupWeigth.SupportInfo.Name;
         Cells[3,2]:=t_SupWeigth.SupportInfo.Name;

         j:=length(trim(t_SupWeigth.WorkFaceInfo.Name));
         K:= Round(GetSupportWigthRows /9 );
         for I := 2 to 7 do begin
             Cells[0,5+k*(i-1)+1]:=Copy(Trim(t_SupWeigth.WorkFaceInfo.Name),(i)-1,1);
         end;
         Cells[1,3]:=t_SupWeigth.WorkFaceInfo.Name;
         ColWidths[0]:=20;
         ColWidths[1]:=80;
         ColWidths[2]:=120;

     end;

     MyStringGrid.Options:=MyStringGrid.Options +[goEditing];

end;

procedure TFormSupweigth.loadexcel(inrows, incols: integer;
  fileName: String);
var
   v:variant;
   i,j:integer;
begin
   with MyStringGrid do begin
         RowCount:=inrows;
         ColCount:=incols;
         v:=createoleobject('Excel.Application');//创建OLE对象
         try
           V.workBooks.Open(fileName);
           //for i:=1 to rowCount do
           for j:=4 to inrows do  begin
                 for i:=3 to incols do   begin
                      Cells[i,j]:=v.workbooks[1].sheets[1].cells[j,i];
                 end;
           end;
              v.workbooks[1].close;
         finally
           v.quit;
         end
   end;

end;

procedure TFormSupweigth.OpenInputDataWindows;
begin
   Panel3.Visible :=False;
   Panel1.Visible :=true;
   Panel1.Align :=alClient;
   EditTest1.Visible :=False;
   EditTest2.Visible :=False;
   EditTest3.Visible :=False;
end;

procedure TFormSupweigth.OptionTip(Str: String);
begin
  self.StatusBar1.Panels[0].Text :=str;
end;

procedure TFormSupweigth.SaveButtonClick(Sender: TObject);
begin
   OptionTip('正在保存数据，耐心等待！');
   SaveDataIntoClass;
end;

procedure TFormSupweigth.SaveDataIntoClass;
var
  R_i,R_j,C_i,C_j:integer;
  Cell_Value:double;
begin
    for R_i := 0 to t_SupWeigth.WorkFaceInfo.Child_count-1 do
       for R_j := 0 to t_SupWeigth.WorkFaceInfo.Child_Second[R_i].Child_count-1 do
          for C_i := 0 to t_SupWeigth.SupportInfo.Child_count-1 do
            for C_j := 0 to t_SupWeigth.SupportInfo.Child_Second[C_i].Child_Count-1 do  begin
               Cell_Value:=  public_Basic.StrTodouble_lu(
                           MyStringGrid.Cells[t_SupWeigth.SupportInfo.Child_Second[C_i].Child_Third[C_j].ColNumber,
                                              t_SupWeigth.WorkFaceInfo.Child_Second[R_i].Child_Third[R_j].RowNumber]
                            );

               if Cell_Value >0 then
                       t_SupWeigth.AddDataValue(
                          t_SupWeigth.WorkFaceInfo.Child_Second[R_i].Child_Third[R_j].id,
                          t_SupWeigth.SupportInfo.Child_Second[C_i].Child_Third[C_j].id,
                          t_SupWeigth.WorkFaceInfo.Child_Second[R_i].Child_Third[R_j].RowNumber,
                          t_SupWeigth.SupportInfo.Child_Second[C_i].Child_Third[C_j].ColNumber,
                          Cell_Value);


            end;

    t_SupWeigth.SaveDataIntoDataBase ;

    OptionTip('保存数据成功，耐心等待！');
end;

procedure TFormSupweigth.SetColHead;
var
  i,j:integer;
  Cols:Integer;
begin
    Cols:=3;
//    MyStringGrid.LockPaint;

    for I := 0 to t_SupWeigth.SupportInfo.Child_count-1   do  begin
        MyStringGrid.Cells[Cols,1]:=t_SupWeigth.SupportInfo.Child_Second[i].Name;
        for j := 0 to t_SupWeigth.SupportInfo.Child_Second[i].Child_count-1 do   begin
               MyStringGrid.Cells[Cols,2]:=t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[j].BianMa;
               MyStringGrid.Cells[Cols,3]:=t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[j].Name;
               t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[j].ColNumber :=Cols;
               Cols:=Cols+1;
        end;

    end;
//    MyStringGrid.UnlockPaint;;

end;

procedure TFormSupweigth.SetRowHead;
var
  i,j:integer;
  Rows:Integer;
begin
    Rows:=4;


    for I := 0 to t_SupWeigth.WorkFaceInfo.Child_count-1   do  begin
        MyStringGrid.Cells[1,Rows]:=t_SupWeigth.WorkFaceInfo.Child_Second[i].Name;
        for j := 0 to t_SupWeigth.WorkFaceInfo.Child_Second[i].Child_count-1 do   begin
               MyStringGrid.Cells[2,Rows]:=t_SupWeigth.WorkFaceInfo.Child_Second[i].Child_Third[j].Name;
               t_SupWeigth.WorkFaceInfo.Child_Second[i].Child_Third[j].RowNumber:= Rows;
               Rows:=Rows+1;
        end;

    end;
//    MyStringGrid.UnlockPaint;;


end;

procedure TFormSupweigth.EDitTest3Click(Sender: TObject);
begin
    // 主要是用于从本地xls中导入数据，测试使用
    OptionTip('正在提取数据，耐心等待！');
    self.loadexcel(self.GetSupportWigthRows,self.GetSupportWigthCols,'d:\123.xls');

end;

end.
