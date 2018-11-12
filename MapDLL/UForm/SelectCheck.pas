unit SelectCheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons, DB, ADODB, ImgList, System.ImageList;

type
  TuFormSelect = class(TForm)
    Label1: TLabel;
    EqualMemo: TMemo;
    Label2: TLabel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    ButEquqll: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    BitBtn14: TBitBtn;
    ButClear: TBitBtn;
    Label3: TLabel;
    UsedFieldGrid: TStringGrid;
    BitBtn1: TBitBtn;
    ImageList1: TImageList;
    ButRun: TBitBtn;
    BitBtn16: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure ButClearClick(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure UsedFieldGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ButEquqllClick(Sender: TObject);
    procedure EqualMemoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn16Click(Sender: TObject);
    procedure ButRunClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    Excel_field,Field_name : Array [0..80] of string;
    procedure FillFieldName;
    procedure initstringGrid;
    procedure AddEqualText(FiledOrValue,Str:String);
  public
    { Public declarations }
    ExHAndle:THandle;
    Exwid,Exhid:integer;
    RunSql:string;
  end;

var
  uFormSelect: TuFormSelect;

function CreateSelectForm(AHandle:THandle;ACaption:string;Wid,Hi:integer):integer;stdcall;

implementation

uses   InforFrm, UMainDataModule;

{$R *.dfm}

function CreateSelectForm(AHandle:THandle;ACaption:string;Wid,Hi:integer):integer;stdcall;
 begin
       if Assigned(uFormSelect) then  FreeANdNil(uFormSelect);
        uFormSelect:=TuFormSelect.Create(nil);
        try
           with uFormSelect do begin
               Caption:=ACaption;
               WindowState:= wsNormal;
               ParentWindow:=Ahandle;
               ExHAndle:=Ahandle;
               Exwid:=wid;
               Exhid:=hi;
               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

                Show;
                SetFocus;
                Result:=1;//����ֵ
          end ;
        except
           FreeAndNil(uFormSelect);
        end;
 end;

procedure TuFormSelect.AddEqualText(FiledOrValue,Str:String);
begin
   EqualMemo.SetFocus;
   if FiledOrValue='Field' then  begin
      EqualMemo.Text:=copy(EqualMemo.Text,1,EqualMemo.SelStart )+
                     ' '+Str+
         copy(EqualMemo.Text,EqualMemo.SelStart,length(EqualMemo.Text)-EqualMemo.SelStart);
      EqualMemo.SelStart := length(EqualMemo.Text);
   end else if FiledOrValue='CommandFh' then begin
      EqualMemo.Text:=copy(EqualMemo.Text,1,EqualMemo.SelStart )+
                     ' '+Str+ ''' ''' +
         copy(EqualMemo.Text,EqualMemo.SelStart,length(EqualMemo.Text)-EqualMemo.SelStart);
      EqualMemo.SelStart :=length(EqualMemo.Text)-2;
      EqualMemo.SelLength:=0;
   end else if FiledOrValue='KuoHao' then begin
      EqualMemo.Text:=copy(EqualMemo.Text,1,EqualMemo.SelStart )+
                     ' '+Str+
         copy(EqualMemo.Text,EqualMemo.SelStart,length(EqualMemo.Text)-EqualMemo.SelStart);
      EqualMemo.SelStart :=length(EqualMemo.Text)-2;
      EqualMemo.SelLength:=0;
   end else if FiledOrValue='AndOr' then begin
      EqualMemo.Text:=copy(EqualMemo.Text,1,EqualMemo.SelStart )+
                     ' '+Str+
         copy(EqualMemo.Text,EqualMemo.SelStart,length(EqualMemo.Text)-EqualMemo.SelStart);
      EqualMemo.SelStart :=length(EqualMemo.Text);
      EqualMemo.SelLength:=0;
    end else if FiledOrValue='Like' then begin
      EqualMemo.Text:=copy(EqualMemo.Text,1,EqualMemo.SelStart )+
                     ' like  ''%%''' +
         copy(EqualMemo.Text,EqualMemo.SelStart,length(EqualMemo.Text)-EqualMemo.SelStart);
      EqualMemo.SelStart :=length(EqualMemo.Text)-2;
      EqualMemo.SelLength:=0;
     end else if FiledOrValue='Between' then begin
      EqualMemo.Text:=copy(EqualMemo.Text,1,EqualMemo.SelStart )+
                     ' between and '+
         copy(EqualMemo.Text,EqualMemo.SelStart,length(EqualMemo.Text)-EqualMemo.SelStart);
      EqualMemo.SelStart :=length(EqualMemo.Text)-5;
      EqualMemo.SelLength:=0;
   end;

  
end;

procedure TuFormSelect.BitBtn10Click(Sender: TObject);
begin
    AddEqualText('CommandFh',' ');
end;

procedure TuFormSelect.BitBtn11Click(Sender: TObject);
begin
     AddEqualText('AndOr',' not ');
end;

procedure TuFormSelect.BitBtn12Click(Sender: TObject);
begin
    AddEqualText('KuoHao','( )');
end;

procedure TuFormSelect.BitBtn13Click(Sender: TObject);
begin
   AddEqualText('Between','');
end;

procedure TuFormSelect.BitBtn14Click(Sender: TObject);
begin
    EqualMemo.Text := copy(EqualMemo.Text,1,length(EqualMemo.Text)-1);
    EqualMemo.SetFocus;
    EqualMemo.SelStart := length(EqualMemo.Text);
end;

procedure TuFormSelect.BitBtn16Click(Sender: TObject);
begin
  Close;
end;

procedure TuFormSelect.BitBtn1Click(Sender: TObject);
Var
 sql:string;
 wStr:string;
begin
    sql:='select * from mapbh  ';
    if length(Trim(self.EqualMemo.Text))>5 then  begin
      Sql:=sql+ self.EqualMemo.Text;
    end else begin
       wStr:='��¼���ѯ������';
       MessageBox(0, Pwidechar(wstr),'��ʾ',MB_OK + MB_ICONQUESTION);
       exit;
    end;
    MainDataModule.MyDataSet.Close;
    MainDataModule.MyDataSet.CommandText :=sql;
    try
       MainDataModule.MyDataSet.Open;
    except
        wStr:='Sql ����﷨��������ϸ�������ԣ�';
        MessageBox(0, Pwidechar(wstr),'��ʾ',MB_OK + MB_ICONQUESTION);
        exit;
    end;
    MainDataModule.MyDataSet.close;
    RunSql:= EqualMemo.Text;
    ButRun.Enabled :=true;
end;

procedure TuFormSelect.BitBtn2Click(Sender: TObject);
begin
   AddEqualText('CommandFh',' <> ');
end;

procedure TuFormSelect.BitBtn3Click(Sender: TObject);
begin
  AddEqualText('CommandFh',' > ');
end;

procedure TuFormSelect.BitBtn4Click(Sender: TObject);
begin
   AddEqualText('CommandFh',' >= ');
end;

procedure TuFormSelect.BitBtn5Click(Sender: TObject);
begin
AddEqualText('CommandFh',' < ');
end;

procedure TuFormSelect.BitBtn6Click(Sender: TObject);
begin
     AddEqualText('CommandFh',' <= ');
end;

procedure TuFormSelect.BitBtn7Click(Sender: TObject);
begin
   AddEqualText('AndOr',' and ');
end;

procedure TuFormSelect.BitBtn8Click(Sender: TObject);
begin
    AddEqualText('AndOr',' Or ');
end;

procedure TuFormSelect.BitBtn9Click(Sender: TObject);
begin
    AddEqualText('Like','');
end;

procedure TuFormSelect.ButEquqllClick(Sender: TObject);
begin
     AddEqualText('CommandFh',' = ');
end;

procedure TuFormSelect.ButRunClick(Sender: TObject);
begin
   OpenSelectResult(ExHandle,'��ѯ���',Runsql,Exwid,Exhid);
end;

procedure TuFormSelect.EqualMemoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    ShowMessage(IntTostr(EqualMemo.SelStart));
end;

procedure TuFormSelect.ButClearClick(Sender: TObject);
begin
    EqualMemo.Text :=' where ' ;
   // EqualMemo.Text :='  ' ;
    EqualMemo.SelStart := length(EqualMemo.Text);
end;

procedure TuFormSelect.FillFieldName;
begin
          Excel_field[1]:='bh';           Field_name[1]:='���';
          Excel_field[2]:='Tu_bh';        Field_name[2]:='ͼ���';
          Excel_field[3]:='ZJ_Type';      Field_name[3]:='֧���ͺ�';
          Excel_field[4]:='ZJ_name';      Field_name[4]:='֧������';
          Excel_field[5]:='ZJ_D_name';    Field_name[5]:='֧�����������';
          Excel_field[6]:='Mt_address';   Field_name[6]:='ú������';
          Excel_field[7]:='Mc_ZJ_name';   Field_name[7]:='ú����';
          Excel_field[8]:='Gzm_l';        Field_name[8]:='������б��';
          Excel_field[9]:='Gzm_h';        Field_name[9]:='�ɸ�';
          Excel_field[10]:='Mc_name';     Field_name[10]:='ú������';
          Excel_field[11]:='Mc_h';        Field_name[11]:='ú��߶�';
          Excel_field[12]:='Mc_f';        Field_name[12]:='ú��Ӳ��';
          Excel_field[13]:='Mc_qj';       Field_name[13]:='ú�����';
          Excel_field[14]:='Top_attr';    Field_name[14]:='����״̬';
          Excel_field[15]:='Bottom_attr'; Field_name[15]:='�װ�״̬';
          Excel_field[16]:='Ws_attr';     Field_name[16]:='��˹״̬';
          Excel_field[17]:='Ky_attr';     Field_name[17]:='��ѹ���';
          Excel_field[18]:='Useed_attr';  Field_name[18]:='ʹ�����';
          Excel_field[19]:='chanliang';   Field_name[19]:='����';
          Excel_field[20]:='Memo_bz';     Field_name[20]:='��ע';
          Excel_field[21]:='Zj_D_zhong';  Field_name[21]:='֧���������';
          Excel_field[22]:='Zj_s_zhong';  Field_name[22]:='֧�ܳ���';
          Excel_field[23]:='Zj_p';        Field_name[23]:='֧������';
          Excel_field[24]:='Zj_h_min';    Field_name[24]:='��͸߶�';
          Excel_field[25]:='Zj_h_max';    Field_name[25]:='���߶�';
          Excel_field[26]:='Zj_zxj';      Field_name[26]:='���ľ�';
          Excel_field[27]:='Zj_qlz';      Field_name[27]:='ǰ����';
          Excel_field[28]:='zj_hlz';      Field_name[28]:='������';
          Excel_field[29]:='Zj_kzfs';     Field_name[29]:='���Ʒ�ʽ';
          Excel_field[30]:='Mj_type';     Field_name[30]:='ú���ͺ�';
          Excel_field[31]:='mj_Gt_d';     Field_name[31]:='��Ͳֱ��';
          Excel_field[32]:='mj_js';       Field_name[32]:='����';
          Excel_field[33]:='Front_GB_type';  Field_name[33]:='ǰ���ΰ���ͺ�';
          Excel_field[34]:='Front_lc_w';     Field_name[34]:='ǰ����ۿ���';
          Excel_field[35]:='behind_gb_type'; Field_name[35]:='�󲿹ΰ���ͺ�';
          Excel_field[36]:='behind_lc_w';    Field_name[36]:='����ۿ��';
          Excel_field[37]:='liang_duanju';   Field_name[37]:='���˾�';
          Excel_field[38]:='Tuiyidian_juli';          Field_name[38]:='���Ƶ����ú�ھ���';
          Excel_field[39]:='Front_behind_lc_zxj';     Field_name[39]:='ǰ��������ľ�';
          Excel_field[40]:='pt_guomei_h';             Field_name[40]:='��ú�߶�';
          Excel_field[41]:='zj_js_h';     Field_name[41]:='������';
          Excel_field[42]:='Zj_Dl';       Field_name[42]:='����ǰ���ṹ';
          Excel_field[43]:='Zj_Ql';       Field_name[43]:='ǰ���ṹ';
          Excel_field[44]:='Zj_Dl_Yhl';   Field_name[44]:='�������ڻ�����ϵ';
          Excel_field[45]:='Zj_chb';      Field_name[45]:='�໤��ṹ';
          Excel_field[46]:='Zj_slg';      Field_name[46]:='�����˽ṹ';
          Excel_field[47]:='Zj_ty';       Field_name[47]:='���ƽṹ';
          Excel_field[48]:='Zj_td';       Field_name[48]:='̧�׽ṹ';
          Excel_field[49]:='Zj_ty_d';     Field_name[49]:='���Ƹ׾�';
          Excel_field[50]:='Zj_yl_d';     Field_name[50]:='ǰ���׾�';
          Excel_field[51]:='zj_wl_d';     Field_name[51]:='β���׾�';
          Excel_field[52]:='zj_cb_d';     Field_name[52]:='���׾�';
          Excel_field[53]:='Zj_ct_d';     Field_name[53]:='���Ƹ׾�';
          Excel_field[54]:='Zj_td_d';     Field_name[54]:='̧�׸׾�';
          Excel_field[55]:='Zj_yihg_d';   Field_name[55]:='һ������׾�';
          Excel_field[56]:='Zj_ss_d';     Field_name[56]:='�����׾�';
          Excel_field[57]:='zj_dt_d';     Field_name[57]:='�����׾�';
          Excel_field[58]:='zj_lhl_d';    Field_name[58]:='������׾�';


            //2014�� ����

          Excel_field[59]:='B_SF';       Field_name[59]:='ʡ��';
          Excel_field[60]:='B_DJS';   Field_name[60]:='�ؼ���';
          Excel_field[61]:='B_XJS';      Field_name[61]:='�ؼ���';
          Excel_field[62]:='B_ZHQD';      Field_name[62]:='֧��ǿ��';
          Excel_field[63]:='B_DBBY';       Field_name[63]:='�װ��ѹ';
          Excel_field[64]:='B_H';       Field_name[64]:='����';
          Excel_field[65]:='B_YSL';     Field_name[65]:='ӿˮ��';
          Excel_field[66]:='B_JHDM';     Field_name[66]:='�������';
          Excel_field[67]:='B_FHDM';     Field_name[67]:='�������';
          Excel_field[68]:='B_CMJCJ';     Field_name[68]:='��ú������';
          Excel_field[69]:='B_GBJCJ';     Field_name[69]:='�ΰ������';
          Excel_field[70]:='B_PSJXH';     Field_name[70]:='������ͺ�';
          Excel_field[71]:='B_PSJCJ';   Field_name[71]:='���������';
          Excel_field[72]:='B_RHYB';     Field_name[72]:='�黯Һ��';
          Excel_field[73]:='B_RHYCJ';     Field_name[73]:='�黯Һ����';

                                          Field_name[74]:='�Ƿ��ע';

                                          Field_name[75]:='����';
                                          Field_name[76]:='γ��';
     //
end;

procedure TuFormSelect.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if Assigned(uFormSelect) then  FreeANdNil(uFormSelect);
end;

procedure TuFormSelect.FormCreate(Sender: TObject);
begin
    self.initstringGrid;
    ButClear.Click ;
end;

procedure TuFormSelect.initstringGrid;
var
  i:integer;
begin
      UsedFieldGrid.FixedCols:=1;
      UsedFieldGrid.FixedRows:=1;
      UsedFieldGrid.ColCount :=3;
      UsedFieldGrid.RowCount:=75;
      UsedFieldGrid.DefaultRowHeight:=18;
      UsedFieldGrid.ColWidths[0]:=30;    UsedFieldGrid.Cells[0,0]:='���';
      UsedFieldGrid.ColWidths[1]:=100;   UsedFieldGrid.Cells[1,0]:='�ֶ�˵��';
      UsedFieldGrid.ColWidths[2]:=100;   UsedFieldGrid.Cells[2,0]:='�ֶα�ʶ';
      //
      FillFieldName;
      //
      for i := 2 to 73 do  begin
          UsedFieldGrid.Cells[0,i-1] := intToStr(i-1);
          UsedFieldGrid.Cells[1,i-1] := Field_name[i];
          UsedFieldGrid.Cells[2,i-1] := Excel_field[i];
      end;

end;

procedure TuFormSelect.UsedFieldGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  GetStr:String;
begin
     GetStr:= UsedFieldGrid.Cells[2,ARow];
     AddEqualText('Field',GetStr);
end;

end.