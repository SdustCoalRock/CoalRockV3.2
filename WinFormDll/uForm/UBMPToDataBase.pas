unit UBMPToDataBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ExtDlgs,
  Vcl.ComCtrls, System.ImageList, Vcl.ImgList,UMainDataModule;

type
 pBMPSave =^TBmpSaveINfo;
  TBmpSaveINfo=packed record
    lx:integer;
    FileName:string;
    Bianma:string;
    Memo:string;
  end;

  TFormBmpDataBase = class(TForm)
    PageControl1: TPageControl;
    SaveBMP: TTabSheet;
    EditBMP: TTabSheet;
    Image1: TImage;
    Label2: TLabel;
    BMPTreeView: TTreeView;
    Button3: TButton;
    StatusBar1: TStatusBar;
    ImageList1: TImageList;
    Panel1: TPanel;
    Image2: TImage;
    Button4: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Label3: TLabel;
    Panel4: TPanel;
    Button2: TButton;
    Panel5: TPanel;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox1: TComboBox;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BMPTreeViewClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure EditBMPShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Memo1Click(Sender: TObject);
  private
    { Private declarations }
    FileName,ExtName:String;
    Bmp_Id:string;
    pBmp:pBMPSave;
    procedure OptionTip(Str:String);
    procedure MainTreeView(TreeView: TTreeView);
    procedure UserView(TreeView: TTreeView;XNode: TTreeNode;DataType:String);
    procedure UserZhijiaChlidView(TreeView: TTreeView;XNode: TTreeNode;DataType:String);
    procedure GetRootNodes(RNode:TTreeNode;InImageIndex:Integer);//得到所有根节点

    function  CheckSaveInput:Boolean;
  public
    { Public declarations }
  end;

var
  FormBmpDataBase: TFormBmpDataBase;
function CreateBmpIntoDataBase(AHandle:THandle;ACaption:string;Wid,Hi:integer):integer;stdcall;
implementation

{$R *.dfm}

uses  SQLiteTable3,pngimage,Jpeg, Lu_Public_BasicModual;

//内部初始化工作面函数
function CreateBmpIntoDataBase(AHandle:THandle;ACaption:string;Wid,Hi:integer):integer;stdcall;

begin
        if Assigned(FormBmpDataBase) then FreeAndNil(FormBmpDataBase);

        FormBmpDataBase:=TFormBmpDataBase.Create(nil);
        try
            with FormBmpDataBase do begin
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
           FreeAndNil(FormBmpDataBase);
        end;
end;
procedure TFormBmpDataBase.Button1Click(Sender: TObject);
var
   Png:TPngObject;
   jpg: TJPEGImage;
   FileHandle:integer;
begin
    self.OpenPictureDialog1.Execute() ;

    FileHandle := FileOpen(openpicturedialog1.FileName, 0);
    if GetFileSize(FileHandle, nil) >300000 then begin
       messagebox(self.Handle,'文件大于300K，请压缩后再来！','系统提示',MB_ICONINFORMATION+mb_ok);
       FileClose(FileHandle);
       exit;
    end;
    FileClose(FileHandle);

    Edit1.Text := OpenPictureDialog1.FileName;
    FileName:=ExtractFileName(OpenPictureDialog1.FileName);
    ExtName:=UpperCase(ExtractFileExt(openpicturedialog1.FileName ));


   if ExtName='.PNG' then begin
      Png:=TPngObject.Create;
      png.LoadFromFile(Edit1.Text);
      Image1.Picture.Bitmap.Assign(PNG);
      Png.Free ;
   end else if ExtName='.BMP' then begin
      Image1.Picture.LoadFromFile(Edit1.Text);
   end else if ExtName='.JPG' then begin
      jpg := TJPEGImage.Create;
      jpg.LoadFromFile(Edit1.Text);
      Image1.Picture.Bitmap.Assign(jpg); // 因为 img 控件是基于bmp的
      jpg.Free;
   end else begin
      exit;
   end;
   Button2.Enabled :=true;

end;

procedure TFormBmpDataBase.Button2Click(Sender: TObject);
var
   Fs:TFileStream;
begin
  if not CheckSaveInput then  exit;

   try
      FS := TFileStream.Create(Edit1.Text,fmOpenRead);

      if  not MainDataModule.MySqliteDataBase.SaveBmpToSqlite(FileName,IntTostr(ComboBox1.ItemIndex+1),
                          FS,pBmp.Bianma,pBmp.Memo )  then begin
          messagebox(self.Handle,'数据存储失败！','系统提示',MB_ICONINFORMATION+mb_ok);
      end else begin
          messagebox(self.Handle,'数据存储成功！','系统提示',MB_ICONINFORMATION+mb_ok);
          OptionTip('数据存储成功');
      end;
   finally
      FS.Free ;
      Memo1.Clear ;
   end;
   Button2.Enabled :=false;
end;

procedure TFormBmpDataBase.Button3Click(Sender: TObject);
Var
    SQL,t_s:String;
    sltb1: TSQLIteTable;
begin

   t_s:='你确定要删除【'+Bmp_Id+'】图片么?';
    if Application.MessageBox(Pwidechar(t_s),'提示',MB_OKCANCEL+MB_ICONQUESTION) =2 then  exit;
    //
   try
       sql:= ' delete from  ImageStore where image_id= '+Bmp_Id ;
       MainDataModule.Maindb.ExecSQL(sql);
   finally
       sltb1.Free;
       MainTreeView(BmpTreeView);
   end;
end;

function TFormBmpDataBase.CheckSaveInput: Boolean;
var
   s_temp:Str_DT_array;
   C1:integer;
   CaptionName:string;
begin

    Result:=false;
    if ComboBox1.ItemIndex <0 then  begin
         messagebox(self.Handle,'请选择图片类别！ ','系统提示',mb_iconerror+mb_ok);
         exit;
    end else   if (ComboBox1.ItemIndex=0)  then begin    //简单图例
         s_temp:=Public_Basic.split(ComboBox2.Text,'_',C1);
         if s_temp[0]='' then exit;
         pBmp.lx :=1;
         pBmp.Bianma :=s_temp[0];
         pBmp.Memo :=s_temp[1];
    end else    if (ComboBox1.ItemIndex=1)  then begin   //仿真图例
         s_temp:=Public_Basic.split(ComboBox2.Text,'_',C1);
         if s_temp[0]='' then exit;
         pBmp.lx :=2;
         pBmp.Bianma :=s_temp[0];
         pBmp.Memo :=s_temp[1];
    end else   if (ComboBox1.ItemIndex=2)  then begin   //支架图例
         s_temp:=Public_Basic.split(ComboBox3.Text,'_',C1);
         if s_temp[0]='' then exit;
         pBmp.lx :=3;
         pBmp.Bianma :=s_temp[0];
         pBmp.Memo :=s_temp[1];
    end else if  (ComboBox1.ItemIndex=3)  then begin   //背景图例
         pBmp.lx :=4;
         pBmp.Bianma :='0';
         pBmp.Memo :=ExtractFileName(Edit1.Text);
    end else if  (ComboBox1.ItemIndex=4)  then begin   //其他图例
         pBmp.lx :=5;
         pBmp.Bianma :='0';
         pBmp.Memo :=ExtractFileName(Edit1.Text);
    end;


   if Trim(Memo1.Text )<>'' then
       pBmp.Memo:=Memo1.Text;
    Result:=true;
end;

procedure TFormBmpDataBase.ComboBox1Change(Sender: TObject);
begin
   if (ComboBox1.ItemIndex =0) or (ComboBox1.ItemIndex =1) then  begin  // 0 简单图例 1 仿真图例
          MainDataModule.MySqliteDataBase.SqliteComboList(ComboBox2,
                       'select id,gfmc,tuli from BasicYock   order by id','id','gfmc','tuli'); //简单图例
          ComboBox3.Enabled :=False;
   end else if (ComboBox1.ItemIndex =2)  then  begin //液压支架图例
          ComboBox3.Enabled :=true;
          MainDataModule.MySqliteDataBase.SqliteComboList(ComboBox2,
                       'select id,TypeName,CaptionName from SupportWeight where  DataType=''bjjg''' +
                       '  order by id','id','CaptionName','TypeName'); //支架类型

   end else begin
        ComboBox2.Clear ;
        ComboBox3.Clear ;
   end;


end;

procedure TFormBmpDataBase.ComboBox2Change(Sender: TObject);
var
   s_temp:Str_DT_array;
   C1:integer;
   CaptionName:string;
begin
    s_temp:=Public_Basic.split(ComboBox2.Text,'_',C1);
    if s_temp[2]='' then exit;
     CaptionName:=s_temp[2];
    MainDataModule.MySqliteDataBase.SqliteComboList(ComboBox3,
                   'select id,TypeName,CaptionName from SupportWeight where DataType='''+
                    CaptionName+'''   order by id','id','TypeName','CaptionName'); //支架类型
end;

procedure TFormBmpDataBase.EditBMPShow(Sender: TObject);
begin
    MainTreeView(BmpTreeView);
end;

procedure TFormBmpDataBase.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
   if assigned(FormBmpDataBase) then  FreeAndNil(FormBmpDataBase);


end;

procedure TFormBmpDataBase.FormCreate(Sender: TObject);
begin
    PubLic_Basic.InitStatusBar (self.StatusBar1);
    ComboBox1.ItemIndex:=0;
    New(pBmp);
    Memo1.Clear ;
    Memo2.Clear;
end;

procedure TFormBmpDataBase.FormDestroy(Sender: TObject);
begin
    Dispose(pBmp);
end;



procedure TFormBmpDataBase.GetRootNodes(RNode: TTreeNode;
  InImageIndex: Integer);
var
   vNode:TTreeNode;
begin
  vNode:=RNode.getFirstChild;
  While vNode<>nil do
  begin
      vNode.ImageIndex:=InImageIndex;
      vNode:=vNode.GetNextChild(vNode);

  end;
end;

procedure TFormBmpDataBase.MainTreeView(TreeView: TTreeView);
var
  StrDisp: Array  [0..6] of String;
  RecData: PMyRec;
  xNode,xNodeJing:TTreeNode;
  i:Integer;
begin
    StrDisp[1] :='简单岩层图例';
    StrDisp[2] :='仿真岩层图例';
    StrDisp[3] :='支架结构图例';
    StrDisp[4] :='背景图片图例';
    StrDisp[5] :='其他方面图例';


        //树图初始化
    TreeView.Items.Clear;
    for i := 1 to 5 do begin
          New(RecData);
          RecData^.BName:='-1';
          RecData^.DName:='ROOT';
          RecData^.XHeight:=IntTostr(i);
          xNode:=TreeView.Items.AddObject(nil,StrDisp[i],RecData);
          Xnode.ImageIndex:=0;
          UserView(TreeView,xNode,IntTostr(i));
          Xnode.Expanded;
    end;


end;

procedure TFormBmpDataBase.Memo1Click(Sender: TObject);
begin
    Memo1.SetFocus ;
end;

procedure TFormBmpDataBase.OptionTip(Str: String);
begin
    self.StatusBar1.Panels[0].Text :=str;
end;

procedure TFormBmpDataBase.BMPTreeViewClick(Sender: TObject);
var
  NodeSelected: TTreeNode;

begin
if (BMPTreeView.Selected = nil) or (PMyRec(BMPTreeView.Selected.Data)^.DName = 'ROOT')   then  begin
     Exit;
   end;

    NodeSelected:=BMPTreeView.Selected;

    if (NodeSelected=nil) then        exit;

    if PMyRec(NodeSelected.Data)^.BName='-2' then begin

          Bmp_Id:= PMyRec(NodeSelected.Data)^.XHeight;
          GetRootNodes(NodeSelected.Parent,0);
         // BMPTreeView.Selected.SelectedIndex:=4;

          BMPTreeView.Selected.ImageIndex:= BMPTreeView.Selected.SelectedIndex;

          MainDataModule.MySqliteDataBase.GetBMPToSQlite(PMyRec(NodeSelected.Data)^.XHeight,
                   Image2.Picture.Bitmap);


         
          self.Memo2.Text :=MainDataModule.MySqliteDataBase.GEtBMPMemoFromsqlite(PMyRec(NodeSelected.Data)^.XHeight) ;

    end else begin
        BMPTreeView.Selected.SelectedIndex:=1;

    end;

end;

procedure TFormBmpDataBase.UserView(TreeView: TTreeView; XNode: TTreeNode;
  DataType: String);
var
   RecData: PMyRec;
   XNodeChild:TTreeNode;
   sltb1: TSQLIteTable;
   Sql:String;
   Falg:string;
begin
    if (DataType='1') or (DataType='2') then begin
       Sql:= 'SELECT Im.image_id as id ,BY.gfmc as IMF  from ImageStore as IM,BasicYock as BY ' +
             ' where Im.DataType ='+DataType +' and IM.bianma=BY.id   order by iM.image_id';
       Falg:='-2';
    end else if (DataType='3') then begin
       Sql:= 'SELECT Sw.id ,SW.TypeName AS TN ,Sw.CaptionName as IMF  from SupportWeight as SW ' +
             ' where SW.DataType=''bjjg''   order by id';
       Falg:='-1';
    end else  begin

       Sql:= 'SELECT image_id as id ,imageFileName as IMF  from ImageStore ' +
             ' where DataType ='+DataType +'   order by image_id';
       Falg:='-2';
    end;

   try
     sltb1:=MainDataModule.Maindb.GetTable(sql);

     while not sltb1.Eof do begin
           New(RecData);
           RecData^.BName:=Falg;
           RecData^.DName:=Trim(utf8decode(sltb1.FieldByName['IMF']));
           RecData^.XHeight:=Trim(sltb1.FieldByName['id']);
           XNodeChild:=TreeView.Items.AddChildObject(xNode,Trim(RecData^.DName),RecData);
          if DataType='3' then
             UserZhijiaChlidView(TreeView,XNodeChild,Trim(sltb1.FieldByName['TN']));
           XNodeChild.ImageIndex:=0;
           XNodeChild.SelectedIndex:=4;
        sltb1.Next ;
     end ;
   finally
    sltb1.Free;
   end;

end;

procedure TFormBmpDataBase.UserZhijiaChlidView(TreeView: TTreeView;
  XNode: TTreeNode; DataType: String);
var
   RecData: PMyRec;
   XNodeChild:TTreeNode;
   sltb1: TSQLIteTable;
   Sql:String;
begin

     Sql:= 'SELECT Im.Image_id as id ,SW.TypeName as IMF  from ImageStore as IM,SupportWeight as SW ' +
             ' where SW.DataType ='''+DataType +''' and IM.bianma=SW.id   order by iM.image_id';


   try
     sltb1:=MainDataModule.Maindb.GetTable(sql);

     while not sltb1.Eof do begin
           New(RecData);
           RecData^.BName:='-2';
           RecData^.DName:=Trim(utf8decode(sltb1.FieldByName['IMF']));
           RecData^.XHeight:=Trim(sltb1.FieldByName['id']);
           XNodeChild:=TreeView.Items.AddChildObject(xNode,Trim(RecData^.DName),RecData);
           XNodeChild.ImageIndex:=0;
        sltb1.Next ;
     end ;
   finally
    sltb1.Free;
   end;

end;

end.
