unit uFormDataT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, Lu_NoData_function;

type
  TuFormDataText = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    SaveDialog1: TSaveDialog;
    Panel2: TPanel;
    StringDataGrid: TStringGrid;
    Panel3: TPanel;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure initDataGrid(Sender:TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    TitleCaption:string; // ����ͷ
    procedure FillFyyd;
    procedure FillZCyl;
    procedure FillZj;
  public
    { Public declarations }
  end;



 function ShowDataText_inn(AHandle:THandle;ACaption:string):integer;stdcall;


implementation

uses F_Stope;

{$R *.dfm}
 //==============

 function ShowDataText_inn(AHandle:THandle;ACaption:string):integer;stdcall;
  var
       FormDataText: TuFormDataText;
   begin
        Application.Handle:=Ahandle;

        FormDataText:=TuFormDataText.Create(Application);
        try
        FormDataText.Caption:=ACaption;
        FormDataText.WindowState:= wsNormal;
        FormDataText.ParentWindow:=Ahandle;
        //       FormFyyd.drawtest();



       //��ģʽ������ʽ��ʾ����
       //  FormFyyd.ShowModal;
          FormDataText.Show;

        Result:=1;//����ֵ
        except
         FormDataText.Free;
     end;
     end;

 //=================model end
procedure TuFormDataText.BitBtn1Click(Sender: TObject);
var
   S_out:string;
begin
   s_out:=StringGridtoExcel(TitleCaption,self.StringDataGrid,10);
end;
procedure TuFormDataText.initDataGrid(Sender:TObject);
 var
    I,j :Integer;
 begin
      TitleCaption:='������:'+P_Stope.t_Gzm.S_Name+',��ױ��:'+IntToSTr(p_Stope.t_zk.Zk_No)+' �����˶���֧��ѹ�����ɱ���';
      self.Panel3.Caption :=TitleCaption;
      self.StringDataGrid.ColCount :=12;
      StringDataGrid.RowCount:=25;
      StringDataGrid.FixedCols:=0;
      StringDataGrid.FixedRows:=0;
      StringDataGrid.DefaultRowHeight:=18;
      StringDataGrid.ColWidths[0]:=30;
      StringDataGrid.ColWidths[1]:=150;
      StringDataGrid.ColWidths[2]:=40;
      StringDataGrid.ColWidths[5]:=10;
      StringDataGrid.ColWidths[6]:=150;
      StringDataGrid.ColWidths[7]:=40;
      StringDataGrid.ColWidths[10]:=10;
      StringDataGrid.ColWidths[11]:=30;
      StringDataGrid.RowHeights[15]:=5;
      
 end;

 procedure TuFormDataText.FillFyyd; //����˶�
 begin
      StringDataGrid.Cells[1,0]:='�ϸ��Ҳ��˶�����';
     //ֱ�Ӷ�
     StringDataGrid.Cells[1,2]:='ֱ�Ӷ�����';
          StringDataGrid.Cells[3,2]:= IntToStr(P_Stope.t_imm_r.Start_No-P_Stope.t_imm_r.Start_No+1);
          StringDataGrid.Cells[4,2]:='��';
     StringDataGrid.Cells[1,3]:='ֱ�Ӷ����';
          StringDataGrid.Cells[3,3]:= FormatFloat('0.00', P_Stope.t_imm_r.Immroof_M);
          StringDataGrid.Cells[4,3]:='��';
     StringDataGrid.Cells[1,4]:='ֱ�Ӷ����ο��䲽��';
          StringDataGrid.Cells[3,4]:= FormatFloat('0.00', P_Stope.t_imm_r.Immroof_C0);
          StringDataGrid.Cells[4,4]:='��';
     //�϶�
    StringDataGrid.Cells[1,6]:='�϶���������';
         if P_Stope.t_old.YL_struc=1 then begin
             StringDataGrid.Cells[3,6]:= '������';
         end else begin
             StringDataGrid.Cells[3,6]:= '������';
         end;
    StringDataGrid.Cells[1,7]:='�϶�����������ѹ����';
          StringDataGrid.Cells[2,7]:= '���';
          StringDataGrid.Cells[3,7]:= FormatFloat('0.00', P_Stope.t_old.YL_First_step[0]);
          StringDataGrid.Cells[4,7]:='��';
          StringDataGrid.Cells[2,8]:= '��С';
          StringDataGrid.Cells[3,8]:= FormatFloat('0.00', P_Stope.t_old.YL_First_step[1]);
          StringDataGrid.Cells[4,8]:='��' ;
          StringDataGrid.Cells[2,9]:= 'ƽ��';
          StringDataGrid.Cells[3,9]:= FormatFloat('0.00', P_Stope.t_old.YL_First_step[2]);
          StringDataGrid.Cells[4,9]:='��' ;
     StringDataGrid.Cells[1,10]:='�϶�����������ѹ����';
          StringDataGrid.Cells[2,10]:= '���';
          StringDataGrid.Cells[3,10]:= FormatFloat('0.00', P_Stope.t_old.YL_First_step[0]*0.4);
          StringDataGrid.Cells[4,10]:='��';
          StringDataGrid.Cells[2,11]:= '��С';
          StringDataGrid.Cells[3,11]:= FormatFloat('0.00', P_Stope.t_old.YL_First_step[1]*0.4);
          StringDataGrid.Cells[4,11]:='��' ;
          StringDataGrid.Cells[2,12]:= 'ƽ��';
          StringDataGrid.Cells[3,12]:= FormatFloat('0.00', P_Stope.t_old.YL_First_step[2]*0.4);
          StringDataGrid.Cells[4,12]:='��' ;
    StringDataGrid.Cells[1,14]:='�Ѷ�ƽ�⹰��󲨼���Χ';
          StringDataGrid.Cells[3,14]:= FormatFloat('0.00', P_Stope.t_Gzm.Hg_ldg);
          StringDataGrid.Cells[4,14]:='��';

 end;

 procedure TuFormDataText.FillZcyl; //��֧��ѹ��
  begin
     StringDataGrid.Cells[6,0]:='֧��ѹ���ֲ�����';
     //ֱ�Ӷ�
     StringDataGrid.Cells[6,2]:='֧��ѹ����ֵ����ú�ھ���';
          StringDataGrid.Cells[7,2]:= '��';
          StringDataGrid.Cells[8,2]:= FormatFloat('0.00', P_Stope.t_Gzm.ZCYL_s1[0]);
          StringDataGrid.Cells[9,2]:='��' ;
          StringDataGrid.Cells[7,3]:= '�²�';
          StringDataGrid.Cells[8,3]:= FormatFloat('0.00', P_Stope.t_Gzm.ZCYL_s1[1]);
          StringDataGrid.Cells[9,3]:='��' ;
          StringDataGrid.Cells[7,4]:= 'ǰ��';
          StringDataGrid.Cells[8,4]:= FormatFloat('0.00', P_Stope.t_Gzm.ZCYL_s1[2]);
          StringDataGrid.Cells[9,4]:='��' ;
          StringDataGrid.Cells[7,5]:= '�ϲ�';
          StringDataGrid.Cells[8,5]:= FormatFloat('0.00', P_Stope.t_Gzm.ZCYL_s1[3]);
          StringDataGrid.Cells[9,5]:='��' ;
     StringDataGrid.Cells[6,7]:='֧��ѹ����Ӧ����';
          StringDataGrid.Cells[8,7]:= FormatFloat('0.00', P_Stope.t_Gzm.ZCYL_s0);
          StringDataGrid.Cells[9,7]:='��' ;
     StringDataGrid.Cells[6,9]:='֧��ѹ��Ӱ�췶Χ';
          StringDataGrid.Cells[7,9]:= '��';
          StringDataGrid.Cells[8,9]:= FormatFloat('0.00', P_Stope.t_Gzm.ZCYL_sx[0]);
          StringDataGrid.Cells[9,9]:='��' ;
          StringDataGrid.Cells[7,10]:= '�²�';
          StringDataGrid.Cells[8,10]:= FormatFloat('0.00', P_Stope.t_Gzm.ZCYL_sx[1]);
          StringDataGrid.Cells[9,10]:='��' ;
          StringDataGrid.Cells[7,11]:= 'ǰ��';
          StringDataGrid.Cells[8,11]:= FormatFloat('0.00', P_Stope.t_Gzm.ZCYL_sx[2]);
          StringDataGrid.Cells[9,12]:='��' ;
          StringDataGrid.Cells[7,13]:= '�ϲ�';
          StringDataGrid.Cells[8,13]:= FormatFloat('0.00', P_Stope.t_Gzm.ZCYL_sx[3]);
          StringDataGrid.Cells[9,13]:='��' ;
  end;

  procedure TuFormDataText.FillZj; //��֧�ܲ���
  begin
       StringDataGrid.Cells[1,16]:='������Һѹ֧����Ҫ����';
       StringDataGrid.Cells[1,17]:='�϶�������ѹ֧���迹��';
          StringDataGrid.Cells[2,17]:= '���';
          StringDataGrid.Cells[3,17]:= FormatFloat('0.00', P_Stope.t_ZhiJia.Zj_JiSuan_C0_F[0]);
          StringDataGrid.Cells[4,17]:='KN';
          StringDataGrid.Cells[2,18]:= '��С';
          StringDataGrid.Cells[3,18]:= FormatFloat('0.00', P_Stope.t_ZhiJia.Zj_JiSuan_C0_F[1]);
          StringDataGrid.Cells[4,18]:='KN' ;
          StringDataGrid.Cells[2,19]:= 'ƽ��';
          StringDataGrid.Cells[3,19]:= FormatFloat('0.00', P_Stope.t_ZhiJia.Zj_JiSuan_C0_F[2]);
          StringDataGrid.Cells[4,19]:='KN' ;
      StringDataGrid.Cells[1,21]:='�϶�������ѹ֧��ѹǿ';
          StringDataGrid.Cells[2,21]:= '���';
          StringDataGrid.Cells[3,21]:= FormatFloat('0.00', P_Stope.t_ZhiJia.Zj_JiSuan_C0_P[0]);
          StringDataGrid.Cells[4,21]:='MPa';
          StringDataGrid.Cells[2,22]:= '��С';
          StringDataGrid.Cells[3,22]:= FormatFloat('0.00', P_Stope.t_ZhiJia.Zj_JiSuan_C0_P[1]);
          StringDataGrid.Cells[4,22]:='MPa' ;
          StringDataGrid.Cells[2,23]:= 'ƽ��';
          StringDataGrid.Cells[3,23]:= FormatFloat('0.00', P_Stope.t_ZhiJia.Zj_JiSuan_C0_P[2]);
          StringDataGrid.Cells[4,23]:='MPa' ;
       StringDataGrid.Cells[6,17]:='�϶�������ѹ֧���迹��';
          StringDataGrid.Cells[7,17]:= '���';
          StringDataGrid.Cells[8,17]:= FormatFloat('0.00', P_Stope.t_ZhiJia.Zj_JiSuan_Ci_F[0]);
          StringDataGrid.Cells[9,17]:='KN';
          StringDataGrid.Cells[7,18]:= '��С';
          StringDataGrid.Cells[8,18]:= FormatFloat('0.00', P_Stope.t_ZhiJia.Zj_JiSuan_Ci_F[1]);
          StringDataGrid.Cells[9,18]:='KN' ;
          StringDataGrid.Cells[7,19]:= 'ƽ��';
          StringDataGrid.Cells[8,19]:= FormatFloat('0.00', P_Stope.t_ZhiJia.Zj_JiSuan_Ci_F[2]);
          StringDataGrid.Cells[9,19]:='KN' ;
      StringDataGrid.Cells[6,21]:='�϶�������ѹ֧��ѹǿ';
          StringDataGrid.Cells[7,21]:= '���';
          StringDataGrid.Cells[8,21]:= FormatFloat('0.00', P_Stope.t_ZhiJia.Zj_JiSuan_Ci_P[0]);
          StringDataGrid.Cells[9,21]:='MPa';
          StringDataGrid.Cells[7,22]:= '��С';
          StringDataGrid.Cells[8,22]:= FormatFloat('0.00', P_Stope.t_ZhiJia.Zj_JiSuan_Ci_P[1]);
          StringDataGrid.Cells[9,22]:='MPa' ;
          StringDataGrid.Cells[7,23]:= 'ƽ��';
          StringDataGrid.Cells[8,23]:= FormatFloat('0.00', P_Stope.t_ZhiJia.Zj_JiSuan_Ci_P[2]);
          StringDataGrid.Cells[9,23]:='MPa' ;

  end;
procedure TuFormDataText.BitBtn2Click(Sender: TObject);
begin
     self.Close ;
end;

procedure TuFormDataText.FormCreate(Sender: TObject);
begin
       self.initDataGrid(Sender);
       FillFyyd;  //����˶�
       FillZcyl; // //��֧��ѹ��
       FillZj;   //��֧�ܲ���
end;

end.
