unit UFormZhijia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, ComCtrls,Jpeg,PngImage,StrUtils,
  math ,PStope_WorKFace,PStope_Immediate,PStope_SupportClass ;

type
  TFormZhiJia = class(TForm)
    Panel3: TPanel;
    PageControl1: TPageControl;
    TabSheetDz: TTabSheet;
    TabSheetZj: TTabSheet;
    StringGridDZ: TStringGrid;
    StringGridZJ: TStringGrid;
    Panel5: TPanel;
    Panel6: TPanel;
    Button1: TButton;
    Button2: TButton;
    TabSheetFY: TTabSheet;
    StringGridFy: TStringGrid;
    Button3: TButton;
    TabSheet_Canshu: TTabSheet;
    StringGrid_ZJCS: TStringGrid;
 
    procedure FormShow(Sender: TObject);

    procedure StringGridDZSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    

    procedure StringGridFySelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGridZJSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);


    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDeactivate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure StringGridDZKeyPress(Sender: TObject; var Key: Char);
    procedure StringGridFyKeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid_ZJCSKeyPress(Sender: TObject; var Key: Char);
    procedure StringGridZJKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    DllFileName:string;
    ComboDz_psxs_12,ComboDz_cmfs_4,ComboDz_yxfx_16,ComboDz_jyhd,ComboDz_dcgz,ComboDz_WsFc : TComboBox;
    ComboDz_TopWater,ComboDz_BottomWater,ComboDz_HeoStress,ComboDz_kyxx,ComboDz_HangDaoSup :TComboBox;
    ComBo_YlJg,Combo_nYLc,Combo_ckq,combo_imm_leibie,combo_old_leibie,combo_diban_leibie,combo_fdm_leibie:TComboBox;

     t_Gzm:TG_Stope;     //������
     t_zk:Tzk_bore;     //���
     t_imm_r:TImmediate_roof; //ֱ�Ӷ�
     t_old:Told_roof;    //�϶�
     t_ZhiJia:TZJ_Class;  //֧��
     ShowScreen:integer;
    
    Procedure initGzmDCGrid(Sender:TObject);
    Procedure initzjGrid(Sender:TObject);
    procedure initFyydGrid(Sender:TObject);
    procedure InitYLCanshuGrid(Sender:TObject);
    procedure CreateCanshuFile(FileName:string);
    procedure ReadFileFillCanshuGrid(FileName:string);
    procedure SaveDataToFile(FileNAme:string);

    procedure Edit_Cs(Sender:Tobject); //�޶�����
    procedure SetFromWidthAndHeigth(flag:integer);
    procedure FromSaveToBmp(pic_path:string);


    procedure SetBasicClass;
  public
    { Public declarations }
     Mc_FdBs: double;
  end;
var
   FormZhiJia:TFormZhiJia;

 function ShowZhiJia_inn(AHandle:THandle;ACaption:string;Wid,Hig,Flag:integer):integer;stdcall;

implementation

uses  Main_PStope, Lu_Public_BasicModual,System.IniFiles;


{$R *.dfm}
function ShowZhiJia_inn(AHandle:THandle;ACaption:string;Wid,Hig,Flag:integer):integer;stdcall;

begin
    if Assigned(FormZhiJia) then   FreeAndNil(FormZhiJia);

    FormZhiJia:=TFormZhiJia.Create(nil);
    try
        with FormZhiJia do  begin
            Caption:=ACaption;
            WindowState:= wsNormal;
            ParentWindow:=Ahandle;
            if Hig >Height then
               Top :=Round((Hig-Height)/2)
            else  Top :=0;
            if Wid> Width then
               Left:=Round((Wid-Width)/2)
            else  Left:=0;
            SetFromWidthAndHeigth(Flag);
        end;
        Result:=1;//����ֵ
    except
        FreeAndNil(FormZhiJia);
    end;
end;
 //============



//===================
procedure TFormZhiJia.initGzmDCGrid(Sender:TObject);
 Var
    I,j :Integer;
    UseCol,useRow:integer;
    vRect:    TRect;
begin
    //��ʼ������stringgrid
    StringGridDZ.ColCount :=9;
    if StringGridDZ.Height/20<20 then begin
        StringGridDZ.RowCount :=20;
    end else begin
        StringGridDZ.RowCount :=trunc(StringGridDZ.Height/20);
    end;

    StringGridDZ.FixedCols:=0;
    StringGridDZ.FixedRows:=1;
    StringGridDZ.DefaultRowHeight:=18;
    StringGridDZ.ColWidths[4]:=50;
    StringGridDZ.ColWidths[0]:=30;        StringGridDZ.ColWidths[5]:=30;
    StringGridDZ.ColWidths[1]:=120;       StringGridDZ.ColWidths[6]:=120;
    StringGridDZ.ColWidths[2]:=trunc(StringGridDZ.Width/2)-210;
        StringGridDZ.ColWidths[7]:=trunc(StringGridDZ.Width/2)-210;
    StringGridDZ.ColWidths[3]:=10;       StringGridDZ.ColWidths[8]:=10;

    StringGridDZ.Canvas.Font.Size:=8;
    StringGridDZ.Cells[0,0]:='���';     StringGridDZ.Cells[5,0]:='���';
    StringGridDZ.Cells[1,0]:='����';     stringGridDZ.Cells[6,0]:='����';
    StringGridDZ.Cells[2,0]:='ȡֵ';     StringGridDZ.Cells[7,0]:='ȡֵ';

      StringGridDZ.Cells[1,1]:='�����������Ϣ';
      StringGridDZ.Cells[0,2]:='1';
      StringGridDZ.Cells[1,2]:='����������';
      StringGridDZ.Cells[2,2]:=t_Gzm.S_Name;
      StringGridDZ.Cells[0,3]:='2';
      StringGridDZ.Cells[1,3]:='��������';
      StringGridDZ.Cells[2,3]:=t_Gzm.S_No;
      StringGridDZ.Cells[0,4]:='3';
      StringGridDZ.Cells[1,4]:='����ú��';
      StringGridDZ.Cells[2,4]:=t_Gzm.S_mc_name;
      StringGridDZ.Cells[0,5]:='4';
      StringGridDZ.Cells[1,5]:='��ú��ʽ';
         if ComboDz_cmfs_4=nil then begin
                vRect := StringGridDZ.CellRect(2, 4);
                ComboDz_cmfs_4 := TComboBox.Create(StringGridDZ);
                ComboDz_cmfs_4.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_cmfs_4.BoundsRect := vRect;
                ComboDz_cmfs_4.Color :=clBtnFace;
                ComboDz_cmfs_4.Visible := true;
               // ComboDz_cmfs_4.OnClick:=Combo_Gzm_cmfs_4;

                ComboDz_cmfs_4.Style :=csDropDownList;
                ComboDz_cmfs_4.Items.Clear;
                ComboDz_cmfs_4.Items.Add('�ڲ�');// 1	cqcsb	cmfa	1	�ڲ�
                ComboDz_cmfs_4.Items.Add('�ղ�');//    2	cqcsb	cmfa	2	�ղ�
                ComboDz_cmfs_4.Items.Add('�۲�');//    3	cqcsb	cmfa	3	�۲ɣ���ȫ�ߣ�
                ComboDz_cmfs_4.Items.Add('�Ŷ�ú����');//    4	cqcsb	cmfa	4	�Ŷ�ú����
                ComboDz_cmfs_4.Items.Add('�ֲ㿪���Ϸֲ�');//    5	cqcsb	cmfa	4	�ֲ㿪���Ϸֲ�
                ComboDz_cmfs_4.Items.Add('�ֲ㿪���·ֲ�');//    6	cqcsb	cmfa	4	�ֲ㿪���Ϸֲ�
               
                 for I := 0 to ComboDz_cmfs_4.Items.Count - 1 do
                    begin
                       if ComboDz_cmfs_4.Items[i] =Trim(StringReplace(t_Gzm.S_cmfs,#13#10,'',[])) then  begin
                          ComboDz_cmfs_4.ItemIndex:=i;
                          break;
                       end;
                    end;
                 if i>ComboDz_cmfs_4.Items.Count - 1 then  begin
                    if Public_BAsic.strToInt_lu(t_Gzm.S_cmfs)>0 then begin
                          ComboDz_cmfs_4.ItemIndex:=Public_BAsic.strToInt_lu(t_Gzm.S_cmfs)-1;
                    end else  begin
                          ComboDz_cmfs_4.ItemIndex:=0;
                    end;
                 end;


         end;
      StringGridDZ.Cells[0,6]:='5';
      StringGridDZ.Cells[1,6]:='���ɸ߶�(m)';
      StringGridDZ.Cells[2,6]:=FormatFloat('0.00',t_Gzm.S_Cg_h);
      StringGridDZ.Cells[0,7]:='6';
      StringGridDZ.Cells[1,7]:='��ú�߶�(m)';
      StringGridDZ.Cells[2,7]:=FormatFloat('0.00',t_Gzm.S_Fm_h);
      StringGridDZ.Cells[0,8]:='7';
      StringGridDZ.Cells[1,8]:='���(��)';
      StringGridDZ.Cells[2,8]:=FormatFloat('0.00',t_Gzm.S_qj);
      StringGridDZ.Cells[0,9]:='8';
      StringGridDZ.Cells[1,9]:='������(m)';
      StringGridDZ.Cells[2,9]:=FormatFloat('0.00',t_Gzm.S_mcsd_h);
      StringGridDZ.Cells[0,10]:='9';
      StringGridDZ.Cells[1,10]:='��б��(m)';
      StringGridDZ.Cells[2,10]:=FormatFloat('0.00',t_Gzm.S_L_qx);
      StringGridDZ.Cells[0,11]:='10';
      StringGridDZ.Cells[1,11]:='����(m)';
      StringGridDZ.Cells[2,11]:=FormatFloat('0.00',t_Gzm.S_Sx_zx);
      StringGridDZ.Cells[0,12]:='11';
      StringGridDZ.Cells[1,12]:='�ۼƽ���(m)';
      StringGridDZ.Cells[2,12]:=FormatFloat('0.00',t_Gzm.S_Jc_L);
      StringGridDZ.Cells[0,13]:='12';
      StringGridDZ.Cells[1,13]:='����ϵ��';
       if ComboDz_psxs_12=nil then begin
                vRect := StringGridDZ.CellRect(2, 12);
                ComboDz_psxs_12 := TComboBox.Create(StringGridDZ);
                ComboDz_psxs_12.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_psxs_12.BoundsRect := vRect;
                ComboDz_psxs_12.Color :=clBtnFace;
                ComboDz_psxs_12.Visible := true;
               // ComboDz_psxs_12.OnClick:=Combo_Gzm_psxs_12;

                ComboDz_psxs_12.Style :=csDropDownList;
                ComboDz_psxs_12.Items.Add('����ϵ��0.8����');// ����ϵ��0.8����
                ComboDz_psxs_12.Items.Add('����ϵ��0.8-1.5֮��');   // 6	cqcsb	mtyd	2	����ϵ��0.8-1.5֮��
                ComboDz_psxs_12.Items.Add('����ϵ��1.5-2.5֮��');   // 7	cqcsb	mtyd	3	����ϵ��1.5-2.5֮��
                ComboDz_psxs_12.Items.Add('��ϵ��2.5����');   // 8	cqcsb	mtyd	4	����ϵ��2.5����1

                   if t_Gzm.S_f_PS =1then begin
                       ComboDz_psxs_12.ItemIndex:=0;
                       t_Gzm.S_M_njl:=10;
                       t_Gzm.S_M_mcj:=20;
                       t_Gzm.S_Bsb:=0.35;
                       t_Gzm.S_K_zcfz:=1.6-0.1*(t_Gzm.S_Cg_h-4);
                   end else if t_Gzm.S_f_PS=2 then begin
                       ComboDz_psxs_12.ItemIndex:=1;
                       t_Gzm.S_M_njl:=30;
                       t_Gzm.S_M_mcj:=25;
                       t_Gzm.S_Bsb:=0.3;
                       t_Gzm.S_K_zcfz:=2.0-0.1*(t_Gzm.S_Cg_h-4);
                   end else if t_Gzm.S_f_PS=3 then begin
                       ComboDz_psxs_12.ItemIndex:=2;
                       t_Gzm.S_M_njl:=50;
                       t_Gzm.S_M_mcj:=30;
                       t_Gzm.S_Bsb:=0.25;
                       t_Gzm.S_K_zcfz:=2.3-0.1*(t_Gzm.S_Cg_h-4);
                   end else begin
                       ComboDz_psxs_12.ItemIndex:=3;
                       t_Gzm.S_M_njl:=100;
                       t_Gzm.S_M_mcj:=35;
                       t_Gzm.S_Bsb:=0.2;
                       t_Gzm.S_K_zcfz:=2.6-0.1*(t_Gzm.S_Cg_h-4);
                   end;

         end;

      StringGridDZ.Cells[0,14]:='13';
      StringGridDZ.Cells[1,14]:='ú��Ħ����';
      StringGridDZ.Cells[2,14]:=FormatFloat('0.00',t_Gzm.S_M_mcj);
      StringGridDZ.Cells[0,15]:='14';
      StringGridDZ.Cells[1,15]:='���ɱ�';
      StringGridDZ.Cells[2,15]:=FormatFloat('0.00',t_Gzm.S_Bsb);
      StringGridDZ.Cells[0,16]:='15';
      StringGridDZ.Cells[1,16]:='��б��б';    //ComboDz_yxfx_16
      if ComboDz_yxfx_16=nil then begin
                vRect := StringGridDZ.CellRect(2, 15);
                ComboDz_yxfx_16 := TComboBox.Create(StringGridDZ);
                ComboDz_yxfx_16.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_yxfx_16.BoundsRect := vRect;
                ComboDz_yxfx_16.Color :=clBtnFace;
                ComboDz_yxfx_16.Visible := true;
               // ComboDz_yxfx_16.OnClick:=Combo_Gzm_yxfx_16;

                ComboDz_yxfx_16.Style :=csDropDownList;
                ComboDz_yxfx_16.Items.Add('ˮƽ�ƽ�');// 1	ˮƽ�ƽ�
                ComboDz_yxfx_16.Items.Add('��б�ƽ�');
                ComboDz_yxfx_16.Items.Add('��б�ƽ�');
                 if t_Gzm.Dz_yxfx>0 then begin
                          ComboDz_yxfx_16.ItemIndex:=t_Gzm.Dz_yxfx-1;
                 end else begin
                          ComboDz_yxfx_16.ItemIndex:=0;
                 end;


         end;
     // ���� �ǵڶ���
      UseCol:=5;useRow:=-15;
      StringGridDZ.Cells[0+UseCol,17+useRow]:='16';
      StringGridDZ.Cells[1+UseCol,17+useRow]:='���Һ��';    //ComboDz_yxfx_16
      if ComboDz_jyhd=nil then begin
                vRect := StringGridDZ.CellRect(2+UseCol, 16+useRow);
                ComboDz_jyhd := TComboBox.Create(StringGridDZ);
                ComboDz_jyhd.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_jyhd.BoundsRect := vRect;
                ComboDz_jyhd.Color :=clBtnFace;
                ComboDz_jyhd.Visible := true;
               // ComboDz_jyhd.OnClick:=Combo_Gzm_jyhd;

                ComboDz_jyhd.Style :=csDropDownList;
                ComboDz_jyhd.Items.Add('������');//
                ComboDz_jyhd.Items.Add('һ�����');
                ComboDz_jyhd.Items.Add('�к����');
                ComboDz_jyhd.Items.Add('�޺����');
                 if t_Gzm.Dz_JYHD>0 then begin
                          ComboDz_jyhd.ItemIndex:=t_Gzm.Dz_JYHD-1;
                 end else begin
                          ComboDz_jyhd.ItemIndex:=0;
                 end;
         end;

      StringGridDZ.Cells[0+UseCol,18+useRow]:='17';
      StringGridDZ.Cells[1+UseCol,18+useRow]:='���ʹ���';    //ComboDz_yxfx_16
      if ComboDz_DCGZ=nil then begin
                vRect := StringGridDZ.CellRect(2+UseCol, 17+useRow);
                ComboDz_DCGZ := TComboBox.Create(StringGridDZ);
                ComboDz_DCGZ.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_DCGZ.BoundsRect := vRect;
                ComboDz_DCGZ.Color :=clBtnFace;
                ComboDz_DCGZ.Visible := true;
                //ComboDz_DCGZ.OnClick:=Combo_Gzm_dcgz;

                ComboDz_DCGZ.Style :=csDropDownList;
                ComboDz_DCGZ.Items.Add('���ʹ������');//
                ComboDz_DCGZ.Items.Add('��б�Ჿ');
                ComboDz_DCGZ.Items.Add('��б�Ჿ');
                ComboDz_DCGZ.Items.Add('�ϲ��ܼ�������Ӱ���ƽ�');
                ComboDz_DCGZ.Items.Add('�ϲ��ܼ���Ӱ���ƽ�');
                ComboDz_DCGZ.Items.Add('���켫�临��');
                if t_Gzm.Dz_DCGZ>0 then begin
                          ComboDz_DCGZ.ItemIndex:=(t_Gzm.Dz_DCGZ)-1;
                end else begin
                          ComboDz_DCGZ.ItemIndex:=0;
                 end;
         end;

     StringGridDZ.Cells[0+UseCol,19+useRow]:='18';
     StringGridDZ.Cells[1+UseCol,19+useRow]:='��˹����';    //ComboDz_yxfx_16
      if ComboDz_WSFC=nil then begin
                vRect := StringGridDZ.CellRect(2+UseCol, 18+useRow);
                ComboDz_WSFC := TComboBox.Create(StringGridDZ);
                ComboDz_WSFC.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_WSFC.BoundsRect := vRect;
                ComboDz_WSFC.Color :=clBtnFace;
                ComboDz_WSFC.Visible := true;
                //ComboDz_WSFC.OnClick:=Combo_Gzm_WSFC;

                ComboDz_WSFC.Style :=csDropDownList;
                ComboDz_WSFC.Items.Add('��˹�����ϵ�');//
                ComboDz_WSFC.Items.Add('����˹���ֲ�����');
                ComboDz_WSFC.Items.Add('����˹');
                if (t_Gzm.Dz_WSFC)>0 then begin
                          ComboDz_WSFC.ItemIndex:=(t_Gzm.Dz_WSFC)-1;
                end else begin
                          ComboDz_WSFC.ItemIndex:=0;
                 end;
         end;

     StringGridDZ.Cells[0+UseCol,20+useRow]:='19';
     StringGridDZ.Cells[1+UseCol,20+useRow]:='���庬ˮ';    //ComboDz_yxfx_16
      if ComboDz_TopWater=nil then begin
                vRect := StringGridDZ.CellRect(2+UseCol, 19+useRow);
                ComboDz_TopWater := TComboBox.Create(StringGridDZ);
                ComboDz_TopWater.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_TopWater.BoundsRect := vRect;
                ComboDz_TopWater.Color :=clBtnFace;
                ComboDz_TopWater.Visible := true;
               // ComboDz_TopWater.OnClick:=Combo_Gzm_TopWater;

                ComboDz_TopWater.Style :=csDropDownList;
                ComboDz_TopWater.Items.Add('������ˮ');//
                ComboDz_TopWater.Items.Add('��ˮ����붥��Ͻ�');
                ComboDz_TopWater.Items.Add('��ˮ����붥���Զ');
                ComboDz_TopWater.Items.Add('������͸ˮ�¹�');
                ComboDz_TopWater.Items.Add('����');
                if (t_Gzm.Dz_TopWater)>0 then begin
                          ComboDz_TopWater.ItemIndex:=(t_Gzm.Dz_TopWater)-1;
                end else begin
                          ComboDz_TopWater.ItemIndex:=0;
                 end;
         end;

     StringGridDZ.Cells[0+UseCol,21+useRow]:='20';
     StringGridDZ.Cells[1+UseCol,21+useRow]:='�װ庬ˮ';    //ComboDz_yxfx_16
      if ComboDz_BottomWater=nil then begin
                vRect := StringGridDZ.CellRect(2+UseCol, 20+useRow);
                ComboDz_BottomWater := TComboBox.Create(StringGridDZ);
                ComboDz_BottomWater.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_BottomWater.BoundsRect := vRect;
                ComboDz_BottomWater.Color :=clBtnFace;
                ComboDz_BottomWater.Visible := true;
               // ComboDz_BottomWater.OnClick:=Combo_Gzm_BottomWater;

                ComboDz_BottomWater.Style :=csDropDownList;
                ComboDz_BottomWater.Items.Add('�װ���ˮԴ');//
                ComboDz_BottomWater.Items.Add('�װ���ˮԴ����Զ');
                ComboDz_BottomWater.Items.Add('�װ���ˮԴ���Ͻ�');
                ComboDz_BottomWater.Items.Add('�������װ�ͻ���¹�');
                ComboDz_BottomWater.Items.Add('����');
                if (t_Gzm.Dz_BottomWater)>0 then begin
                          ComboDz_BottomWater.ItemIndex:=(t_Gzm.Dz_BottomWater)-1;
                end else begin
                          ComboDz_BottomWater.ItemIndex:=0;
                 end;
         end;

     StringGridDZ.Cells[0+UseCol,22+useRow]:='21';
     StringGridDZ.Cells[1+UseCol,22+useRow]:='ˮƽӦ��';    //ComboDz_yxfx_16
      if ComboDz_HeoStress=nil then begin
                vRect := StringGridDZ.CellRect(2+UseCol, 21+useRow);
                ComboDz_HeoStress := TComboBox.Create(StringGridDZ);
                ComboDz_HeoStress.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_HeoStress.BoundsRect := vRect;
                ComboDz_HeoStress.Color :=clBtnFace;
                ComboDz_HeoStress.Visible := true;
              //  ComboDz_HeoStress.OnClick:=Combo_Gzm_HeoStress;

                ComboDz_HeoStress.Style :=csDropDownList;
                ComboDz_HeoStress.Items.Add('������ˮƽӦ��');//
                ComboDz_HeoStress.Items.Add('ˮƽӦ��С�ڴ�ֱӦ��');
                ComboDz_HeoStress.Items.Add('ˮƽӦ���봹ֱӦ���൱');
                ComboDz_HeoStress.Items.Add('ˮƽӦ�����ڴ�ֱӦ��1.5������');
                if (t_Gzm.Dz_HeoStress)>0 then begin
                          ComboDz_HeoStress.ItemIndex:=(t_Gzm.Dz_HeoStress)-1;
                 end else begin
                          ComboDz_HeoStress.ItemIndex:=0;
                 end;
         end;

     StringGridDZ.Cells[0+UseCol,23+useRow]:='22';
     StringGridDZ.Cells[1+UseCol,23+useRow]:='��ѹ����';    //ComboDz_yxfx_16
      if ComboDz_kyxx=nil then begin
                vRect := StringGridDZ.CellRect(2+UseCol, 22+useRow);
                ComboDz_kyxx := TComboBox.Create(StringGridDZ);
                ComboDz_kyxx.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_kyxx.BoundsRect := vRect;
                ComboDz_kyxx.Color :=clBtnFace;
                ComboDz_kyxx.Visible := true;
               // ComboDz_kyxx.OnClick:=Combo_Gzm_Kyxx;

                ComboDz_kyxx.Style :=csDropDownList;
                ComboDz_kyxx.Items.Add('��ѹ���ֲ�����');
                ComboDz_kyxx.Items.Add('�п�ѹ���֣���Ӱ������');
                ComboDz_kyxx.Items.Add('��ѹ���ֽϾ��ң�Ӱ������');
                ComboDz_kyxx.Items.Add('�����������¹�');
                if (t_Gzm.Dz_Kyxx)>0 then begin
                          ComboDz_kyxx.ItemIndex:=(t_Gzm.Dz_Kyxx)-1;
                 end else begin
                          ComboDz_kyxx.ItemIndex:=0;
                 end;
         end;

     StringGridDZ.Cells[0+UseCol,24+useRow]:='23';
     StringGridDZ.Cells[1+UseCol,24+useRow]:='���֧��';    //ComboDz_yxfx_16
      if ComboDz_HangDaoSup=nil then begin
                vRect := StringGridDZ.CellRect(2+UseCol, 23+useRow);
                ComboDz_HangDaoSup := TComboBox.Create(StringGridDZ);
                ComboDz_HangDaoSup.Parent := StringGridDZ.Parent;
                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
                ComboDz_HangDaoSup.BoundsRect := vRect;
                ComboDz_HangDaoSup.Color :=clBtnFace;
                ComboDz_HangDaoSup.Visible := true;
               // ComboDz_HangDaoSup.OnClick:=Combo_Gzm_HangDaoSup;

                ComboDz_HangDaoSup.Style :=csDropDownList;
                ComboDz_HangDaoSup.Items.Add('�����������Ҫ֧��');
                ComboDz_HangDaoSup.Items.Add('�����ê��֧��');
                ComboDz_HangDaoSup.Items.Add('�������֧��������������');
                ComboDz_HangDaoSup.Items.Add('������Σ��׹ģ���ȫӰ��С');
                ComboDz_HangDaoSup.Items.Add('��������ٱ��Σ��׹ģ�����Ӱ�찲ȫ');
                 if (t_Gzm.Dz_HangDaoSup)>0 then begin
                          ComboDz_HangDaoSup.ItemIndex:=(t_Gzm.Dz_HangDaoSup)-1;
                  end else begin
                          ComboDz_HangDaoSup.ItemIndex:=0;
                  end;
         end;

        //���ƽ��ٶ�
      StringGridDZ.Cells[0+UseCol,25+useRow]:='24';
      StringGridDZ.Cells[1+UseCol,25+useRow]:='���ƽ��ٶ�(m)';
      StringGridDZ.Cells[2+UseCol,25+useRow]:=FormatFloat('0.00',t_Gzm.S_DayStep_speed);
//      StringGridDZ.Cells[0+UseCol,26]:='24';
//      StringGridDZ.Cells[1+UseCol,26]:='�Ͻ翪��';
//
//      StringGridDZ.Cells[0+UseCol,27]:='25';
//      StringGridDZ.Cells[1+UseCol,27]:='�Ͻ�ú��';
//      if t_Gzm.CK_Upkc=1 then  begin
//             StringGridDZ.Cells[2+UseCol,27]:=FormatFloat('0.00',t_Gzm.CK_UpMz);
//             StringGridDZ.Cells[2+UseCol,26]:='�Ѳ�';
//      end else begin
//             StringGridDZ.Cells[2+UseCol,27]:='0';
//             StringGridDZ.Cells[2+UseCol,26]:='δ��';
//      end;
//
//      StringGridDZ.Cells[0+UseCol,28]:='26';
//      StringGridDZ.Cells[1+UseCol,28]:='�½翪��';
//
//      StringGridDZ.Cells[0+UseCol,29]:='27';
//      StringGridDZ.Cells[1+UseCol,29]:='�½�ú��';
//      if t_Gzm.CK_Downkc=1 then  begin
//             StringGridDZ.Cells[2+UseCol,29]:=FormatFloat('0.00',t_Gzm.CK_DownMz);
//             StringGridDZ.Cells[2+UseCol,28]:='�Ѳ�';
//      end else begin
//             StringGridDZ.Cells[2+UseCol,29]:='0';
//             StringGridDZ.Cells[2+UseCol,28]:='δ��';
//      end;

     //�Ƿ���ڲɿ���
//      StringGridDZ.Cells[0,31]:='29';
//      StringGridDZ.Cells[1,31]:='�������Ϸ��Ƿ���ڲɿ���';
//      StringGridDZ.Cells[0,32]:='30';
//      StringGridDZ.Cells[1,32]:='�ɿ����ɸ�';
//      StringGridDZ.Cells[2,32]:='0';
//      StringGridDZ.Cells[0,33]:='31';
//      StringGridDZ.Cells[1,33]:='����';
//      StringGridDZ.Cells[2,33]:='0';
//       if Combo_ckq=nil then begin
//                vRect := StringGridDZ.CellRect(2, 30);
//                Combo_ckq := TComboBox.Create(StringGridDZ);
//                Combo_ckq.Parent := StringGridDZ.Parent;
//                     OffsetRect(vRect, StringGridDZ.left+1, StringGridDZ.Top+StringGridDZ.DefaultRowHeight*1);
//                Combo_ckq.BoundsRect := vRect;
//                Combo_ckq.Color :=clBtnFace;
//                Combo_ckq.Visible := true;
//              //  Combo_ckq.OnClick:=Combo_Gzm_HangDaoSup;
//
//                Combo_ckq.Style :=csDropDownList;
//                Combo_ckq.Items.Add('û�вɿ���');
//                Combo_ckq.Items.Add('���ڲɿ���');
//
//                 if (t_Gzm.UP_Ckq)>0 then begin
//                          Combo_ckq.ItemIndex:=1;
//                           StringGridDZ.Cells[2,32]:=FormatFloat('0.00',t_Gzm.UP_CKQ_Kc_H);
//                           StringGridDZ.Cells[2,33]:=FormatFloat('0.00',t_Gzm.UP_CKQ_JuLI);
//                  end else begin
//                          Combo_ckq.ItemIndex:=0;
//                  end;
//         end;
end;
procedure TFormZhiJia.InitYLCanshuGrid(Sender: TObject);
var
  i:integer;
begin
    StringGrid_ZJCS.FixedCols:=1;
    StringGrid_ZJCS.FixedRows:=2;
    StringGrid_ZJCS.ColCount :=8;
    StringGrid_ZJCS.RowCount :=20;
    StringGrid_ZJCS.DefaultRowHeight:=25;
    StringGrid_ZJCS.DefaultRowHeight:=18;

    StringGrid_ZJCS.ColWidths[0]:=20;
    StringGrid_ZJCS.ColWidths[1]:=80;
    StringGrid_ZJCS.ColWidths[2]:=80;
    StringGrid_ZJCS.ColWidths[3]:=100;
    for I := 4 to 7 do
        StringGrid_ZJCS.ColWidths[i]:=trunc((StringGrid_ZJCS.Width-300)/4) ;

    StringGridZJ.Canvas.Font.Size:=8;
    StringGrid_ZJCS.Cells[0,0]:='��';
        StringGrid_ZJCS.Cells[0,1]:='��';
    StringGrid_ZJCS.Cells[1,0]:='��Ӧ��';
        StringGrid_ZJCS.Cells[1,1]:='�����';
    StringGrid_ZJCS.Cells[2,0]:='������';
        StringGrid_ZJCS.Cells[2,1]:='��״��';
    StringGrid_ZJCS.Cells[3,0]:='������';
        StringGrid_ZJCS.Cells[3,1]:='ѹ���';
    StringGrid_ZJCS.Cells[4,0]:='���Ҷ�';
        StringGrid_ZJCS.Cells[4,1]:='��ȡֵ';
    StringGrid_ZJCS.Cells[5,0]:='һ�㶥';
        StringGrid_ZJCS.Cells[5,1]:='��ȡֵ';
    StringGrid_ZJCS.Cells[6,0]:='��Ӳ��';
        StringGrid_ZJCS.Cells[6,1]:='��ȡֵ';
    StringGrid_ZJCS.Cells[7,0]:='ǳ����';
        StringGrid_ZJCS.Cells[7,1]:='������';

    for I := 0 to 12 do   begin
        if ( i mod 6 =3 )then  StringGrid_ZJCS.Cells[1,i+2]:='  Ӧ';
        if i mod 3 =0 then  continue;

        if (i div 6 =0) and ( i mod 6 =1 )then begin
            StringGrid_ZJCS.Cells[1,i+2]:='  ��';
        end else if  (i div 6 =1) and ( i mod 6 =1 )then begin
            StringGrid_ZJCS.Cells[1,i+2]:='  ��';
        end;
        //
        if ( i mod 6 =2 )then  StringGrid_ZJCS.Cells[1,i+2]:='  ��';

        if ( i mod 6 =4 )then  StringGrid_ZJCS.Cells[1,i+2]:='  ��';
        if ( i mod 6 =5 )then  StringGrid_ZJCS.Cells[1,i+2]:='  ��';

        if ( i mod 6 =1 )then  StringGrid_ZJCS.Cells[2,i+2]:='  ��';
        if ( i mod 6 =2 )then  StringGrid_ZJCS.Cells[2,i+2]:=' ����';
        if ( i mod 6 =4 )then  StringGrid_ZJCS.Cells[2,i+2]:='  ��';
        if ( i mod 6 =5 )then  StringGrid_ZJCS.Cells[2,i+2]:=' ����';

        if ( i mod 3 =1 )then  StringGrid_ZJCS.Cells[3,i+2]:='������ѹ';
        if ( i mod 3 =2 )then  StringGrid_ZJCS.Cells[3,i+2]:='������ѹ';
    end;

end;

//======
 Procedure TFormZhiJia.initzjGrid(Sender:TObject);
 var
   UseCol,useRow:integer;
 begin
       //��ʼ��֧��stringgrid
    StringGridZJ.ColCount :=9;
    if StringGridZJ.Height/20<20  then  begin
         StringGridZJ.RowCount :=20;
    end else begin
         StringGridZJ.RowCount :=trunc(StringGridZJ.Height/20);
    end;
    StringGridZJ.FixedCols:=0;
    StringGridZJ.FixedRows:=1;
    StringGridZJ.DefaultRowHeight:=18;
    StringGridZJ.ColWidths[4]:=50;
    StringGridZJ.ColWidths[0]:=30;        StringGridZJ.ColWidths[5]:=30;
    StringGridZJ.ColWidths[1]:=120;       StringGridZJ.ColWidths[6]:=120;
    StringGridZJ.ColWidths[2]:=trunc(StringGridZJ.Width/2)-230;
        StringGridZJ.ColWidths[7]:=trunc(StringGridZJ.Width/2)-230;
    StringGridZJ.ColWidths[3]:=30;       StringGridZJ.ColWidths[8]:=30;

    StringGridZJ.Canvas.Font.Size:=8;
    StringGridZJ.Cells[0,0]:='���';     StringGridZJ.Cells[5,0]:='���';
    StringGridZJ.Cells[1,0]:='����';     StringGridZJ.Cells[6,0]:='����';
    StringGridZJ.Cells[2,0]:='ȡֵ';     StringGridZJ.Cells[7,0]:='ȡֵ';



    StringGridZJ.Canvas.Font.Size:=8;

    //-- FormatFloat('0.00',P_Stope.t_Gzm.CK_DownMz);
    StringGridZJ.Cells[0,1]:='1';
    StringGridZJ.Cells[1,1]:='֧�ܱ��';
    StringGridZJ.Cells[2,1]:=t_ZhiJia.Zj_BianHao;
    //----
    StringGridZJ.Cells[0,2]:='2';
    StringGridZJ.Cells[1,2]:='֧���ͺ�';
    StringGridZJ.Cells[2,2]:=t_ZhiJia.Zj_XingHao;
      //----
    StringGridZJ.Cells[0,3]:='3';
    StringGridZJ.Cells[1,3]:='֧����������';
    StringGridZJ.Cells[2,3]:=IntToStr(t_ZhiJia.Zj_Lizhu_count);
    StringGridZJ.Cells[3,3]:='��';
      //----
    StringGridZJ.Cells[0,4]:='4';
    StringGridZJ.Cells[1,4]:='֧�ܿض���';
    StringGridZJ.Cells[2,4]:=FormatFloat('0.00',t_ZhiJia.Zj_KongdingJU);
    StringGridZJ.Cells[3,4]:='��';
      //----
    StringGridZJ.Cells[0,5]:='5';
    StringGridZJ.Cells[1,5]:='֧�����ľ�';
    StringGridZJ.Cells[2,5]:=FormatFloat('0.00',t_ZhiJia.Zj_zhongxinju);
    StringGridZJ.Cells[3,5]:='��';
     //----
    StringGridZJ.Cells[0,6]:='6';
    StringGridZJ.Cells[1,6]:='֧�ܺ������õ�';
    StringGridZJ.Cells[2,6]:=FormatFloat('0.00',t_ZhiJia.Zj_hlzyd);
    StringGridZJ.Cells[3,6]:='��';
     //----
    StringGridZJ.Cells[0,7]:='7';
    StringGridZJ.Cells[1,7]:='֧������迹��';
    StringGridZJ.Cells[2,7]:=FormatFloat('0.00',t_ZhiJia.Zj_toall_F);
    StringGridZJ.Cells[3,7]:='KN';
    //----
    StringGridZJ.Cells[0,8]:='8';
    StringGridZJ.Cells[1,8]:='��ѹԤ������迹��';
    StringGridZJ.Cells[2,8]:=FormatFloat('0.00',t_ZhiJia.Zj_JiSuan_C0_F[0]);
    StringGridZJ.Cells[3,8]:='KN';
      //----
    StringGridZJ.Cells[0,9]:='9';
    StringGridZJ.Cells[1,9]:='��ѹԤ����С�迹��';
    StringGridZJ.Cells[2,9]:=FormatFloat('0.00',t_ZhiJia.Zj_JiSuan_C0_F[1]);
    StringGridZJ.Cells[3,9]:='KN';
      //----
    StringGridZJ.Cells[0,10]:='10';
    StringGridZJ.Cells[1,10]:='��ѹԤ�ƺ����迹��';
    StringGridZJ.Cells[2,10]:=FormatFloat('0.00',t_ZhiJia.Zj_JiSuan_C0_F[2]);
    StringGridZJ.Cells[3,10]:='KN';
      //----
    StringGridZJ.Cells[0,11]:='11';
    StringGridZJ.Cells[1,11]:='��ѹԤ������迹��';
    StringGridZJ.Cells[2,11]:=FormatFloat('0.00',t_ZhiJia.Zj_JiSuan_Ci_F[0]);
    StringGridZJ.Cells[3,11]:='KN';
      //----
    StringGridZJ.Cells[0,12]:='12';
    StringGridZJ.Cells[1,12]:='��ѹԤ����С�迹��';
    StringGridZJ.Cells[2,12]:=FormatFloat('0.00',t_ZhiJia.Zj_JiSuan_Ci_F[1]);
    StringGridZJ.Cells[3,12]:='KN';
      //----
    StringGridZJ.Cells[0,13]:='13';
    StringGridZJ.Cells[1,13]:='��ѹԤ�ƺ����迹��';
    StringGridZJ.Cells[2,13]:=FormatFloat('0.00',t_ZhiJia.Zj_JiSuan_Ci_F[2]);
    StringGridZJ.Cells[3,13]:='KN';
      //----
    StringGridZJ.Cells[0,14]:='14';
    StringGridZJ.Cells[1,14]:='֧�����ǿ��';
    StringGridZJ.Cells[2,14]:=FormatFloat('0.00',t_ZhiJia.Zj_toall_P);
    StringGridZJ.Cells[3,14]:='MPa';
    //----
    StringGridZJ.Cells[0,15]:='15';
    StringGridZJ.Cells[1,15]:='��ѹԤ�����ǿ��';
    StringGridZJ.Cells[2,15]:=FormatFloat('0.00',t_ZhiJia.Zj_JiSuan_C0_P[0]);
    StringGridZJ.Cells[3,15]:='MPa';
      //----
    // �ڶ���
     UseCol:=5;useRow:=-15;
    StringGridZJ.Cells[0+UseCol,16+useRow]:='16';
    StringGridZJ.Cells[1+UseCol,16+useRow]:='��ѹԤ����Сǿ��';
    StringGridZJ.Cells[2+UseCol,16+useRow]:=FormatFloat('0.00',t_ZhiJia.Zj_JiSuan_C0_P[1]);
    StringGridZJ.Cells[3+UseCol,16+useRow]:='MPa';
      //----
    StringGridZJ.Cells[0+UseCol,17+useRow]:='17';
    StringGridZJ.Cells[1+UseCol,17+useRow]:='��ѹԤ�ƺ���ǿ��';
    StringGridZJ.Cells[2+UseCol,17+useRow]:=FormatFloat('0.00',t_ZhiJia.Zj_JiSuan_C0_P[2]);
    StringGridZJ.Cells[3+UseCol,17+useRow]:='MPa';
      //----
    StringGridZJ.Cells[0+UseCol,18+useRow]:='18';
    StringGridZJ.Cells[1+UseCol,18+useRow]:='��ѹԤ�����ǿ��';
    StringGridZJ.Cells[2+UseCol,18+useRow]:=FormatFloat('0.00',t_ZhiJia.Zj_JiSuan_Ci_P[0]);
    StringGridZJ.Cells[3+UseCol,18+useRow]:='MPa';
      //----
    StringGridZJ.Cells[0+UseCol,19+useRow]:='19';
    StringGridZJ.Cells[1+UseCol,19+useRow]:='��ѹԤ����Сǿ��';
    StringGridZJ.Cells[2+UseCol,19+useRow]:=FormatFloat('0.00',t_ZhiJia.Zj_JiSuan_Ci_P[1]);
    StringGridZJ.Cells[3+UseCol,19+useRow]:='MPa';
      //----
    StringGridZJ.Cells[0+UseCol,20+useRow]:='20';
    StringGridZJ.Cells[1+UseCol,20+useRow]:='��ѹԤ�ƺ���ǿ��';
    StringGridZJ.Cells[2+UseCol,20+useRow]:=FormatFloat('0.00',t_ZhiJia.Zj_JiSuan_Ci_P[2]);
    StringGridZJ.Cells[3+UseCol,20+useRow]:='MPa';
      //----

    StringGridZJ.Cells[0+UseCol,21+useRow]:='21';
    StringGridZJ.Cells[1+UseCol,21+useRow]:='֧���������';
    StringGridZJ.Cells[2+UseCol,21+useRow]:=FormatFloat('0.00',t_ZhiJia.Zj_suoliang*1000);
    StringGridZJ.Cells[3+UseCol,21+useRow]:='mm';
    //----
    StringGridZJ.Cells[0+UseCol,22+useRow]:='22';
    StringGridZJ.Cells[1+UseCol,22+useRow]:='Ԥ���������';
    StringGridZJ.Cells[2+UseCol,22+useRow]:=FormatFloat('0.00',t_ZhiJia.Zj_Jisuan_SL[0]*1000);
    StringGridZJ.Cells[3+UseCol,22+useRow]:='mm';
      //----
    StringGridZJ.Cells[0+UseCol,23+useRow]:='23';
    StringGridZJ.Cells[1+UseCol,23+useRow]:='Ԥ����С����';
    StringGridZJ.Cells[2+UseCol,23+useRow]:=FormatFloat('0.00',t_ZhiJia.Zj_Jisuan_SL[1]*1000);
    StringGridZJ.Cells[3+UseCol,23+useRow]:='mm';
      //----
    StringGridZJ.Cells[0+UseCol,24+useRow]:='24';
    StringGridZJ.Cells[1+UseCol,24+useRow]:='Ԥ�ƺ�������';
    StringGridZJ.Cells[2+UseCol,24+useRow]:=FormatFloat('0.00',t_ZhiJia.Zj_Jisuan_SL[2]*1000);
    StringGridZJ.Cells[3+UseCol,24+useRow]:='mm';
    //===========

       //===========
    StringGridZJ.Cells[0+UseCol,26+useRow]:='25';
    StringGridZJ.Cells[1+UseCol,26+useRow]:='�е�ֱ�Ӷ���ǿ��';
    StringGridZJ.Cells[2+UseCol,26+useRow]:=FormatFloat('0.00',t_ZhiJia.Zj_imm_p);
    StringGridZJ.Cells[3+UseCol,26+useRow]:='MPa';
      //----
          //===========
    StringGridZJ.Cells[0+UseCol,27+useRow]:='26';
    StringGridZJ.Cells[1+UseCol,27+useRow]:='�е��ϳ�ѹƽ��ǿ��';
    StringGridZJ.Cells[2+UseCol,27+useRow]:=FormatFloat('0.00',t_ZhiJia.Zj_old_C0_p[2]);
    StringGridZJ.Cells[3+UseCol,27+useRow]:='MPa';
      //----
    StringGridZJ.Cells[0+UseCol,28+useRow]:='27';
    StringGridZJ.Cells[1+UseCol,28+useRow]:='�е��϶�����ƽ��ǿ��';
    StringGridZJ.Cells[2+UseCol,28+useRow]:=FormatFloat('0.00',t_ZhiJia.Zj_old_Ci_p[2]);
    StringGridZJ.Cells[3+UseCol,28+useRow]:='MPa';
      //----

 end;
procedure TFormZhiJia.ReadFileFillCanshuGrid(FileName: string);
var
  pIniFile:     TIniFile;
  i:integer;
begin
      if not FileExists(Public_Basic.Get_MyModulePath+FileName) then   begin
         self.CreateCanshuFile(FileName);
      end;

      pIniFile := Tinifile.create(Public_Basic.Get_MyModulePath+'ZhijiaCs_lulei.dll');
      for I := 3 to 13 do  begin
         // I
         if (i-2) mod 3=0 then   continue;

          StringGrid_ZJCS.Cells[4,i]:=format('%1.2f',[pIniFile.ReadFloat('I',IntToStr(i),0)]);
            // II
          StringGrid_ZJCS.Cells[5,i]:=format('%1.2f',[pIniFile.ReadFloat('II',IntToStr(i),0)]);
            // III
          StringGrid_ZJCS.Cells[6,i]:=format('%1.2f',[pIniFile.ReadFloat('III',IntToStr(i),0)]);
            // III
          StringGrid_ZJCS.Cells[7,i]:=format('%1.2f',[pIniFile.ReadFloat('IV',IntToStr(i),0)]);


      end;
      pIniFile.Free;

end;

//-------------
procedure TFormZhiJia.initFyydGrid(Sender:TObject);
var
    vRect:    TRect;
begin
    //��ʼ�������˶�����stringGrid
    StringGridFy.ColCount :=4;
    if StringGridFy.Height/20<30  then  begin
         StringGridFy.RowCount :=30;
    end else begin
         StringGridFy.RowCount :=trunc(StringGridFy.Height/20);
    end;
    StringGridFy.FixedCols:=0;
    StringGridFy.FixedRows:=1;
    StringGridFy.DefaultRowHeight:=18;
    StringGridFy.ColWidths[0]:=80;
    StringGridFy.ColWidths[1]:=StringGridFy.Width-400;
    StringGridFy.ColWidths[2]:=200;
    StringGridFy.ColWidths[3]:=100;

    StringGridFy.Canvas.Font.Size:=8;
    StringGridFy.Cells[0,0]:='���';
    StringGridFy.Cells[1,0]:='����';
    StringGridFy.Cells[2,0]:='ȡֵ';


    StringGridFy.Canvas.Font.Size:=8;

    //-- FormatFloat('0.00',P_Stope.t_Gzm.CK_DownMz);
    StringGridFy.Cells[0,1]:='1';
    StringGridFy.Cells[1,1]:='����ṹ';
      if Combo_YlJg=nil then begin
                vRect := StringGridFy.CellRect(2, 0);
                Combo_YlJg := TComboBox.Create(StringGridFY);
                Combo_YlJg.Parent := StringGridFY.Parent;
                     OffsetRect(vRect, StringGridFY.left+1, StringGridFY.Top+StringGridFY.DefaultRowHeight*1);
                Combo_YlJg.BoundsRect := vRect;
                Combo_YlJg.Color :=clBtnFace;
                Combo_YlJg.Visible := true;
               // Combo_YlJg.OnClick:=Combo_YlJg_Fy_1;

                Combo_YlJg.Style :=csDropDownList;
                Combo_YlJg.Items.Add('�������ṹ');// 1	ˮƽ�ƽ�
                Combo_YlJg.Items.Add('�������ṹ');

                 if t_old.YL_struc=1  then begin
                          Combo_YlJg.ItemIndex:=0;
                 end else begin
                          Combo_YlJg.ItemIndex:=1;
                 end;


         end;
    //
    StringGridFy.Cells[0,2]:='2';
    StringGridFy.Cells[1,2]:='�Ƿ�����Ӧ����';
      if Combo_nylc=nil then begin
                vRect := StringGridFy.CellRect(2, 1);
                Combo_nylc := TComboBox.Create(StringGridFY);
                Combo_nylc.Parent := StringGridFY.Parent;
                     OffsetRect(vRect, StringGridFY.left+1, StringGridFY.Top+StringGridFY.DefaultRowHeight*1);
                Combo_nylc.BoundsRect := vRect;
                Combo_nylc.Color :=clBtnFace;
                Combo_nylc.Visible := true;

                Combo_nylc.Style :=csDropDownList;
                Combo_nylc.Items.Add('����Ӧ����');// 1	ˮƽ�ƽ�
                Combo_nylc.Items.Add('����Ӧ����');

                 if t_Gzm.ZCYL_s0>1  then begin
                          Combo_nylc.ItemIndex:=1;
                 end else begin
                          Combo_nylc.ItemIndex:=0;
                 end;


         end;

    //----
    StringGridFy.Cells[0,3]:='3';
    StringGridFy.Cells[1,3]:='ֱ�Ӷ��߶�';
    StringGridFy.Cells[2,3]:=FormatFloat('0.00',t_imm_r.Immroof_M);
    StringGridFy.Cells[3,3]:='��';
      //----
    StringGridFy.Cells[0,4]:='4';
    StringGridFy.Cells[1,4]:='ֱ�Ӷ����ο��䲽��';
    StringGridFy.Cells[2,4]:=FormatFloat('0.00',t_imm_r.Immroof_C0);
    StringGridFy.Cells[3,4]:='��';
      //----
    StringGridFy.Cells[0,5]:='5';
    StringGridFy.Cells[1,5]:='�϶����߶�';
    StringGridFy.Cells[2,5]:=FormatFloat('0.00',t_old.YL_max_m);
    StringGridFy.Cells[3,5]:='��';
      //----
    StringGridFy.Cells[0,6]:='6';
    StringGridFy.Cells[1,6]:='�϶���С�߶�';
    StringGridFy.Cells[2,6]:=FormatFloat('0.00',t_old.YL_min_m);
    StringGridFy.Cells[3,6]:='��';
      //-----
    StringGridFy.Cells[0,7]:='7';
    StringGridFy.Cells[1,7]:='�϶�������ѹ��󲽾�';
    StringGridFy.Cells[2,7]:=FormatFloat('0.00',t_old.YL_First_step[0]);
    StringGridFy.Cells[3,7]:='��';
      //-----
    StringGridFy.Cells[0,8]:='8';
    StringGridFy.Cells[1,8]:='�϶�������ѹ��С����';
    StringGridFy.Cells[2,8]:=FormatFloat('0.00',t_old.YL_First_step[1]);
    StringGridFy.Cells[3,8]:='��';
      //-----
    StringGridFy.Cells[0,9]:='9';
    StringGridFy.Cells[1,9]:='�϶�������ѹƽ������';
    StringGridFy.Cells[2,9]:=FormatFloat('0.00',t_old.YL_First_step[2]);
    StringGridFy.Cells[3,9]:='��';
      //-------
    StringGridFy.Cells[0,10]:='10';
    StringGridFy.Cells[1,10]:='�϶�������ѹ��󲽾�';
    StringGridFy.Cells[2,10]:=FormatFloat('0.00',t_old.YL_First_step[0]*0.408);
    StringGridFy.Cells[3,10]:='��';
      //-----
    StringGridFy.Cells[0,11]:='11';
    StringGridFy.Cells[1,11]:='�϶�������ѹ��С����';
    StringGridFy.Cells[2,11]:=FormatFloat('0.00',t_old.YL_First_step[1]*0.408);
    StringGridFy.Cells[3,11]:='��';
      //-----
    StringGridFy.Cells[0,12]:='12';
    StringGridFy.Cells[1,12]:='�϶�������ѹƽ������';
    StringGridFy.Cells[2,12]:=FormatFloat('0.00',t_old.YL_First_step[2]*0.408);
    StringGridFy.Cells[3,12]:='��';
     //
       //
    StringGridFy.Cells[0,13]:='13';
    StringGridFy.Cells[1,13]:='ֱ�Ӷ����';
      if Combo_imm_leibie=nil then begin
                vRect := StringGridFy.CellRect(2,12);
                Combo_imm_leibie := TComboBox.Create(StringGridFY);
                Combo_imm_leibie.Parent := StringGridFY.Parent;
                     OffsetRect(vRect, StringGridFY.left+1, StringGridFY.Top+StringGridFY.DefaultRowHeight*1);
                Combo_imm_leibie.BoundsRect := vRect;
                Combo_imm_leibie.Color :=clBtnFace;
                Combo_imm_leibie.Visible := true;

                Combo_imm_leibie.Style :=csDropDownList;
                Combo_imm_leibie.Items.Add('1a �����ȶ�');//
                Combo_imm_leibie.Items.Add('1b �ϲ��ȶ�');
                Combo_imm_leibie.Items.Add('2a �����ȶ�');//
                Combo_imm_leibie.Items.Add('2b �����ȶ�');
                Combo_imm_leibie.Items.Add('3  ���ȶ�����');//
                Combo_imm_leibie.Items.Add('4  ��ǳ��ȶ�����'); //
                Combo_imm_leibie.ItemIndex:=t_imm_r.Imm_leibie-1;
     end;

    //----
           //
    StringGridFy.Cells[0,14]:='14';
    StringGridFy.Cells[1,14]:='�϶����';
      if Combo_old_leibie=nil then begin
                vRect := StringGridFy.CellRect(2, 13);
                Combo_old_leibie := TComboBox.Create(StringGridFY);
                Combo_old_leibie.Parent := StringGridFY.Parent;
                     OffsetRect(vRect, StringGridFY.left+1, StringGridFY.Top+StringGridFY.DefaultRowHeight*1);
                Combo_old_leibie.BoundsRect := vRect;
                Combo_old_leibie.Color :=clBtnFace;
                Combo_old_leibie.Visible := true;

                Combo_old_leibie.Style :=csDropDownList;
                Combo_old_leibie.Items.Add('I    ������');//
                Combo_old_leibie.Items.Add('II   ����');
                Combo_old_leibie.Items.Add('III  ǿ��');//
                Combo_old_leibie.Items.Add('IVa  �ǳ�ǿ��');
                Combo_old_leibie.Items.Add('IVb  �ǳ�ǿ��');//


                     Combo_old_leibie.ItemIndex:=t_old.Old_leibie-1;
     end;

    //----
            //
    StringGridFy.Cells[0,15]:='15';
    StringGridFy.Cells[1,15]:='�װ����';
      if Combo_diban_leibie=nil then begin
                vRect := StringGridFy.CellRect(2, 14);
                Combo_diban_leibie := TComboBox.Create(StringGridFY);
                Combo_diban_leibie.Parent := StringGridFY.Parent;
                     OffsetRect(vRect, StringGridFY.left+1, StringGridFY.Top+StringGridFY.DefaultRowHeight*1);
                Combo_diban_leibie.BoundsRect := vRect;
                Combo_diban_leibie.Color :=clBtnFace;
                Combo_diban_leibie.Visible := true;

                Combo_diban_leibie.Style :=csDropDownList;
                Combo_diban_leibie.Items.Add('I    ����');//
                Combo_diban_leibie.Items.Add('II   ����');
                Combo_diban_leibie.Items.Add('IIIa ����');//
                Combo_diban_leibie.Items.Add('IIIb ����');
                Combo_diban_leibie.Items.Add('IV   ��Ӳ');//
                Combo_diban_leibie.Items.Add('V   ��Ӳ');//

                Combo_diban_leibie.ItemIndex:=t_old.diban_leobie-1;
     end;
     //
     StringGridFy.Cells[0,16]:='16';
     StringGridFy.Cells[1,16]:='��úð����';
      if Combo_fdm_leibie=nil then begin
                vRect := StringGridFy.CellRect(2, 15);
                Combo_fdm_leibie := TComboBox.Create(StringGridFY);
                Combo_fdm_leibie.Parent := StringGridFY.Parent;
                     OffsetRect(vRect, StringGridFY.left+1, StringGridFY.Top+StringGridFY.DefaultRowHeight*1);
                Combo_fdm_leibie.BoundsRect := vRect;
                Combo_fdm_leibie.Color :=clBtnFace;
                Combo_fdm_leibie.Visible := true;

                Combo_fdm_leibie.Style :=csDropDownList;
                Combo_fdm_leibie.Items.Add('���Ŷ�');//
                Combo_fdm_leibie.Items.Add('1�� �ɷ��Ժ�');
                Combo_fdm_leibie.Items.Add('2�� �ɷ��ԽϺ�');//
                Combo_fdm_leibie.Items.Add('3�� �ɷ���һ��');
                Combo_fdm_leibie.Items.Add('4�� �ɷ��Բ�');//
                Combo_fdm_leibie.Items.Add('5��  �ѷ�');//

                Combo_fdm_leibie.ItemIndex:=t_imm_r.FDm_leibie;
     end;


end;
///
procedure TFormZhiJia.SaveDataToFile(FileNAme: string);
var
  pIniFile:     TIniFile;
  i:integer;
begin
    if not FileExists(Public_Basic.Get_MyModulePath+FileNAme) then exit;
    pIniFile := Tinifile.create(Public_Basic.Get_MyModulePath+FileNAme);
    for I := 3 to 13 do  begin

       if (i-2) mod 3 =0 then   continue;
        // I
        pIniFile.WriteFloat('I',IntToStr(i),StrToFloat(self.StringGrid_ZJCS.Cells[4,i]));

        // II
        pIniFile.WriteFloat('II',IntToStr(i),StrToFloat(self.StringGrid_ZJCS.Cells[5,i]));

          // III
        pIniFile.WriteFloat('III',IntToStr(i),StrToFloat(self.StringGrid_ZJCS.Cells[6,i]));

          // III
        pIniFile.WriteFloat('IV',IntToStr(i),StrToFloat(self.StringGrid_ZJCS.Cells[7,i]));


    end;

     pIniFile.Free;

end;

procedure TFormZhiJia.SetBasicClass;
begin
   t_Gzm:=ExPstopeClass.Ex_Gzm ;
   t_zk:=ExPstopeClass.Ex_zk ;
   t_imm_r:=ExPstopeClass.Ex_imm_r ;
   t_old:=ExPstopeClass.Ex_old ;
   t_zhijia:=ExPstopeClass.Ex_ZhiJia ;
end;

procedure TFormZhiJia.SetFromWidthAndHeigth(flag: integer);
begin
    if Flag=1  then  begin
       ShowScreen:=1;
       Show;
   end else begin
       ShowScreen:=0;
       Show;
   end;
end;

procedure TFormZhiJia.StringGridDZKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9','.',#8]) then key:=#0
end;

procedure TFormZhiJia.StringGridDZSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
       if ACol=0 then  StringGridDZ.Options :=StringGridZJ.Options -[goEditing];
       if ACol=1 then  StringGridDZ.Options :=StringGridZJ.Options -[goEditing];
       if ACol=2 then  StringGridDZ.Options :=StringGridZJ.Options +[goEditing];

 // if (ACol = 1) and (ACol = 2) then CanSelect := False;  //��һ�еڶ��в���ѡ
end;

procedure TFormZhiJia.StringGridFyKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9','.',#8]) then key:=#0;
end;

procedure TFormZhiJia.StringGridFySelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
       if ACol=0 then  StringGridFY.Options :=StringGridZJ.Options -[goEditing];
       if ACol=1 then  StringGridFY.Options :=StringGridZJ.Options -[goEditing];
       if ACol=2 then  StringGridFY.Options :=StringGridZJ.Options +[goEditing];
end;

procedure TFormZhiJia.StringGridZJKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9','.',#8]) then key:=#0;
end;

procedure TFormZhiJia.StringGridZJSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
       if ACol=0 then  StringGridZJ.Options :=StringGridZJ.Options -[goEditing];
       if ACol=1 then  StringGridZJ.Options :=StringGridZJ.Options -[goEditing];
       if ACol=2 then  StringGridZJ.Options :=StringGridZJ.Options +[goEditing];
end;

procedure TFormZhiJia.StringGrid_ZJCSKeyPress(Sender: TObject; var Key: Char);
begin
      if not (key in ['0'..'9','.',#8]) then key:=#0;
end;

procedure TFormZhiJia.BitBtn3Click(Sender: TObject);
begin
      self.Close ;
end;

procedure TFormZhiJia.Button1Click(Sender: TObject);

begin
         SaveDataToFile(DllFileName);
         Edit_Cs(Sender);
         t_ZhiJia.Cal_Sup_Para(T_gzm,t_zk,T_imm_r,t_old);
         initzjGrid(Sender);
         InitYLCanshuGrid(Sender);
         TabSheetZj.Show;
end;
procedure TFormZhiJia.Button2Click(Sender: TObject);
begin
        CreateCanshuFile(DllFileName);
        ReadFileFillCanshuGrid(DllFileName);

        initGzmDCGrid(Sender);
        initzjGrid(Sender);
        initFyydGrid(Sender);

end;


procedure TFormZhiJia.Button3Click(Sender: TObject);
begin
   Close;
end;

procedure TFormZhiJia.CreateCanshuFile(FileName: string);
var
  pIniFile:     TIniFile;
  i:integer;
begin
   if FileExists(Public_Basic.Get_MyModulePath+FileName) then
      DeleteFile(Public_Basic.Get_MyModulePath+FileName);

      pIniFile := Tinifile.create(Public_Basic.Get_MyModulePath+FileName);
     // I
      pIniFile.WriteFloat('I','3',0.25);
      pIniFile.WriteFloat('I','4',0.5);
      pIniFile.WriteFloat('I','6',0.5);
      pIniFile.WriteFloat('I','7',1);

      pIniFile.WriteFloat('I','9',0.3);
      pIniFile.WriteFloat('I','10',0.6);
      pIniFile.WriteFloat('I','12',0.6);
      pIniFile.WriteFloat('I','13',1.1);
       // II
      pIniFile.WriteFloat('II','3',0.25);
      pIniFile.WriteFloat('II','4',0.5);
      pIniFile.WriteFloat('II','6',0.5);
      pIniFile.WriteFloat('II','7',0.8);

      pIniFile.WriteFloat('II','9',0.4);
      pIniFile.WriteFloat('II','10',0.6);
      pIniFile.WriteFloat('II','12',0.6);
      pIniFile.WriteFloat('II','13',1);
       // III
      pIniFile.WriteFloat('III','3',0.1);
      pIniFile.WriteFloat('III','4',0.3);
      pIniFile.WriteFloat('III','6',0.6);
      pIniFile.WriteFloat('III','7',1);

      pIniFile.WriteFloat('III','9',0.2);
      pIniFile.WriteFloat('III','10',0.4);
      pIniFile.WriteFloat('III','12',0.6);
      pIniFile.WriteFloat('III','13',1);
      // IV
      pIniFile.WriteFloat('IV','3',0.8);
      pIniFile.WriteFloat('IV','4',1.5);
      pIniFile.WriteFloat('IV','6',1);
      pIniFile.WriteFloat('IV','7',2);

      pIniFile.WriteFloat('IV','9',1);
      pIniFile.WriteFloat('IV','10',1.8);
      pIniFile.WriteFloat('IV','12',1);
      pIniFile.WriteFloat('IV','13',2);
      pIniFile.Free;


end;

// �޶�����

 procedure TFormZhiJia.Edit_Cs(Sender:Tobject);
 begin
     t_Gzm.S_cmfs:=IntToStr(self.ComboDz_cmfs_4.ItemIndex+1); //��ú��ʽ
     if self.ComboDz_cmfs_4.ItemIndex=3 then
       begin
          t_Gzm.S_Fm_h:=StrToFloat(self.StringGridDZ.Cells[2,7]);// ��ú�߶�
       end else begin
          t_Gzm.S_Fm_h:=0;
       end;

     t_Gzm.S_Cg_h:=StrToFloat(self.StringGridDZ.Cells[2,6]);//���ɸ߶�
     t_Gzm.S_qj:= StrToFloat(self.StringGridDZ.Cells[2,8]);//���
     t_Gzm.S_mcsd_h:= StrToFloat(self.StringGridDZ.Cells[2,9]);//������
     t_Gzm.S_L_qx:= StrToFloat(self.StringGridDZ.Cells[2,10]);//   ����
     t_Gzm.S_Jc_L:= StrToFloat(self.StringGridDZ.Cells[2,12]);//   �ۼƽ���
     t_Gzm.S_f_PS:=(self.ComboDz_psxs_12.ItemIndex+1); //����ϵ��
             if t_Gzm.S_f_PS =1then begin
                       t_Gzm.S_M_njl:=10;
                       t_Gzm.S_M_mcj:=20;
                       t_Gzm.S_Bsb:=0.35;
                       t_Gzm.S_K_zcfz:=1.6-0.1*(t_Gzm.S_Cg_h-4);
                   end else if t_Gzm.S_f_PS=2 then begin
                       t_Gzm.S_M_njl:=30;
                       t_Gzm.S_M_mcj:=25;
                       t_Gzm.S_Bsb:=0.3;
                       t_Gzm.S_K_zcfz:=2.0-0.1*(t_Gzm.S_Cg_h-4);
                   end else if t_Gzm.S_f_PS=3 then begin
                       t_Gzm.S_M_njl:=50;
                       t_Gzm.S_M_mcj:=30;
                       t_Gzm.S_Bsb:=0.25;
                       t_Gzm.S_K_zcfz:=2.3-0.1*(t_Gzm.S_Cg_h-4);
                   end else begin
                       t_Gzm.S_M_njl:=100;
                       t_Gzm.S_M_mcj:=35;
                       t_Gzm.S_Bsb:=0.2;
                       t_Gzm.S_K_zcfz:=2.6-0.1*(t_Gzm.S_Cg_h-4);
                   end;
     t_Gzm.Dz_yxfx:=(self.ComboDz_yxfx_16.ItemIndex+1); // ��б��б
     t_Gzm.Dz_JYHD:=(self.ComboDz_jyhd.ItemIndex+1); // ���Һ��
     t_Gzm.Dz_DCGZ:=(self.ComboDz_dcgz.ItemIndex+1); // ���ʹ���
     t_Gzm.Dz_WSFC:=(self.ComboDz_WsFc.ItemIndex+1); //  ��˹����
     t_Gzm.Dz_TopWater:=(self.ComboDz_TopWater.ItemIndex+1); //  ����ˮ
     t_Gzm.Dz_BottomWater:=(self.ComboDz_BottomWater.ItemIndex+1); // �װ�ˮ
     t_Gzm.Dz_HeoStress:=(self.ComboDz_HeoStress.ItemIndex+1); // ˮƽӦ��
     t_Gzm.Dz_Kyxx:=(self.ComboDz_kyxx.ItemIndex+1); //  ��ѹ����
     t_Gzm.Dz_HangDaoSup:=(self.ComboDz_HangDaoSup.ItemIndex+1); // ���֧��
     t_Gzm.S_DayStep_speed:=Public_Basic.StrToDouble_Lu(StringGridDZ.Cells[7,10])  ;// ���ƽ��ٶ�

//     if  StrToFloat(StringGridDZ.Cells[2,27])> 0 then  begin                  // //�Ͻ�ú��
//          t_Gzm.CK_UpMz:=StrToFloat( StringGridDZ.Cells[2,27]);
//          t_Gzm.CK_Upkc:=1;
//     end else begin
//          t_Gzm.CK_UpMz:=0;
//          t_Gzm.CK_Upkc:=0;
//     end;
//
//     if  StrToFloat(StringGridDZ.Cells[2,29])>0 then  begin                 //�½�ú��
//          t_Gzm.CK_downmz:=StrToFloat( StringGridDZ.Cells[2,29]);
//          t_Gzm.CK_downkc:=1;
//     end else begin
//          t_Gzm.CK_downmz:=0;
//          t_Gzm.CK_downkc:=0;
//     end;
//     //
//          t_Gzm.UP_Ckq:=Combo_ckq.ItemIndex;      //�ϸ��Ҳ��Ƿ���ڲɿ���
//              if (t_Gzm.UP_Ckq)>0 then begin
//                           t_Gzm.UP_CKQ_Kc_H:=StrToFloat(StringGridDZ.Cells[2,32]);
//                           t_Gzm.UP_CKQ_JuLI:=StrTofloat(StringGridDZ.Cells[2,33]);
//              end else begin
//                        t_Gzm.UP_CKQ_Kc_H:=0;
//                        t_Gzm.UP_CKQ_JuLI:=0;
//              end;

    //
      t_old.YL_struc:=self.ComBo_YlJg.ItemIndex+1;  //    �����ṹ
     { if (t_Gzm.ZCYL_s0<1) and (self.Combo_nYLc.ItemIndex=1) then   //��Ӧ����
          t_Gzm.ZCYL_s0:=1.5;
      if (t_Gzm.ZCYL_s0>1) and (self.Combo_nYLc.ItemIndex=0) then
          t_Gzm.ZCYL_s0:=0.5;
      }
    //
    t_imm_r.Immroof_M:=StrToFloat(StringGridFy.Cells[2,3]);//  ֱ�Ӷ��߶�
    t_imm_r.Immroof_C0:=StrToFloat(StringGridFy.Cells[2,4]);//  ֱ�Ӷ����ο��䲽��
    t_old.YL_max_m := StrToFloat(StringGridFy.Cells[2,5]);//  �϶����߶�
    t_old.YL_min_m := StrToFloat(StringGridFy.Cells[2,6]);// �϶���С�߶�
    t_old.YL_First_step[0] := StrToFloat(StringGridFy.Cells[2,7]);// �϶�������ѹ��󲽾�
    t_old.YL_First_step[1] := StrToFloat(StringGridFy.Cells[2,8]);// �϶�������ѹ��С����
    t_old.YL_First_step[2] := StrToFloat(StringGridFy.Cells[2,9]);// �϶�������ѹƽ������
    t_imm_r.Imm_leibie:=Combo_imm_leibie.ItemIndex+1;  // ֱ�Ӷ����
    t_old.Old_leibie:= Combo_old_leibie.ItemIndex+1;   //  �϶����
    t_old.diban_leobie:=Combo_diban_leibie.ItemIndex+1;       // �װ����'
    t_imm_r.FDm_leibie:=Combo_fdm_leibie.ItemIndex;          //  ��úð����

    t_ZhiJia.Zj_KongdingJU:= StrToFloat(StringGridZj.Cells[2,4]);// ֧�ܿض���
    t_ZhiJia.Zj_zhongxinju:= StrToFloat(StringGridZj.Cells[2,5]);// ֧�����ľ�
    t_ZhiJia.Zj_hlzyd:= StrToFloat(StringGridZj.Cells[2,6]);// ֧�ܺ������õ�
    t_ZhiJia.Zj_toall_F:= StrToFloat(StringGridZj.Cells[2,7]);// ֧���������

 end;
procedure TFormZhiJia.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
   pic_Path:string;

begin
   Pic_Path  :=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\OneCoal'+'_2_1.BMP';
   if ShowScreen=1 then begin
     FromSaveToBmp(Pic_Path);
   end;

     if Assigned(FormZhiJia) then   FreeAndNil(FormZhiJia);
end;

procedure TFormZhiJia.FormCreate(Sender: TObject);

begin
  DllFileName:='ZhijiaCs_lulei.dll';
  SetBasicClass;
end;

procedure TFormZhiJia.FormDeactivate(Sender: TObject);
begin
    if Assigned(ComboDz_psxs_12) then  FreeAndNil(ComboDz_psxs_12);
    if Assigned(ComboDz_cmfs_4) then  FreeAndNil(ComboDz_cmfs_4);
    if Assigned(ComboDz_yxfx_16) then  FreeAndNil(ComboDz_yxfx_16);
    if Assigned(ComboDz_jyhd) then  FreeAndNil(ComboDz_jyhd);
    if Assigned(ComboDz_dcgz) then  FreeAndNil(ComboDz_dcgz);
    if Assigned(ComboDz_WsFc) then  FreeAndNil(ComboDz_WsFc);
    if Assigned(ComboDz_TopWater) then  FreeAndNil(ComboDz_TopWater);
    if Assigned(ComboDz_BottomWater) then  FreeAndNil(ComboDz_BottomWater);
    if Assigned(ComboDz_HeoStress) then  FreeAndNil(ComboDz_HeoStress);
    if Assigned(ComboDz_kyxx) then  FreeAndNil(ComboDz_kyxx);
    if Assigned(ComboDz_HangDaoSup) then  FreeAndNil(ComboDz_HangDaoSup);

    if Assigned(ComBo_YlJg) then  FreeAndNil(ComBo_YlJg);
    if Assigned(Combo_nYLc) then  FreeAndNil(Combo_nYLc);
    if Assigned(Combo_ckq) then  FreeAndNil(Combo_ckq);
    if Assigned(combo_imm_leibie) then  FreeAndNil(combo_imm_leibie);
    if Assigned(combo_old_leibie) then  FreeAndNil(combo_old_leibie);
    if Assigned(combo_diban_leibie) then  FreeAndNil(combo_diban_leibie);
    if Assigned(combo_fdm_leibie) then  FreeAndNil(combo_fdm_leibie);

end;

// end


procedure TFormZhiJia.FormResize(Sender: TObject);
begin
     //�仯����
      if StringGridDZ.Height/20<30 then begin
        StringGridDZ.RowCount :=30;
        end else begin
            StringGridDZ.RowCount :=trunc(StringGridDZ.Height/20);
        end;
end;

procedure TFormZhiJia.FormShow(Sender: TObject);
var
  i,Count1:integer;
  temp1 :Str_Dt_array;
begin
        InitYLCanshuGrid(Sender);
        {�п��ܸ��������Ľṹ����}
        ReadFileFillCanshuGrid(DllFileName);

        initGzmDCGrid(Sender);
        initzjGrid(Sender);
        initFyydGrid(Sender);
        TabSheetZj.Show;
end;

procedure TFormZhiJia.FromSaveToBmp(pic_path: string);
var
    BitRect: TRect;
    Bitmap: TBitmap;
    FScreenCanvas: TCanvas;
begin
      Bitmap := TBitmap.Create;
   try
      Bitmap.SetSize(Self.ClientWidth, Self.ClientHeight);
      BitRect.Left := 0;
      BitRect.Top := 0;
      BitRect.Right := BitRect.Left + Bitmap.Width;
      BitRect.Bottom := BitRect.Top + Bitmap.Height;
      FScreenCanvas := TCanvas.Create;
      FScreenCanvas.Handle := Self.Canvas.Handle;
      Bitmap.Canvas.Lock;
      Bitmap.Canvas.CopyRect(BitRect, FScreenCanvas, Self.ClientRect);
      Bitmap.Canvas.Unlock;
      Bitmap.SaveToFile(pic_path);
   finally
     Bitmap.Free;
   end;


end;

end.