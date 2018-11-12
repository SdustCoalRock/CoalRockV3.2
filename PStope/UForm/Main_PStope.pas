//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//<<      �ļ�����Main_PStope.pas
//<<      ¬��־ʹ�õĸ���Delphi�ļ�                            <<
//<<      ���ļ���Ҫ��¼�˸��˺���                   <<
//<<      �������ڣ�2018.1.12                                   <<
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

unit Main_PStope;


interface
uses
  Winapi.Windows, SysUtils, Classes, Messages, Controls, Forms, StdCtrls, ExtCtrls,
  ComCtrls ,math,Grids,WordXP,COMobj,SQLiteTable3,StrUtils,Vcl.Dialogs, Activex
  ,PStope_WorKFace,PStope_Immediate,PStope_SupportClass ,PStope_DealWith
  ,Pstope_ShowWindows, uLuSqliteDealWith
    ;
type
  TEXPstopeClass =class
  private
      Create_Public:Boolean;
      MainPath:WideString;
      Init_Enabled:Boolean;
       // ����
      function ConfirmReg: WordBool; stdcall;
      function CreateMainClass:Boolean;
      procedure FreeMainClass;
      function  GetMinaPath:widestring;

  public
      //��Ҫ��
       Ex_Gzm:TG_Stope;     //������
       Ex_zk:Tzk_bore;     //���
       Ex_imm_r:TImmediate_roof; //ֱ�Ӷ�
       Ex_old:Told_roof;    //�϶�
       Ex_ZhiJia:TZJ_Class;  //֧��
       Ex_Cal_show:TCal_Show; //�������
       MySqliteTable:TSqliteADOData;
       My_DealWith:TPStope_DealWith;

       SystemLabel:WideString;
      function  Ex_InitModel(const Gzm, zk,zhijia: WideString;Var Sout:Widestring): Boolean; safecall;
      function  Init_ZhiJia(const ZJ: WideString): WideString; safecall;
      function  Get_immediate_roof(Version:string): string ;
      function  Get_Old_roof(Version:string): string;
      function  Get_kcjstj(const Version: WideString): WideString; safecall;
      function  Get_Support_P(Version:string): string ;
      function  Get_yklh_ctcs(const Version: WideString; width, Hd_wideth,
                            Hd_heigth: Single): WideString; safecall;
      function  Get_yklh_fzzh(const Version: WideString): WideString; safecall;
      function  Get_yklh_JJxy(const Version: WideString;  M_dj, Mzhu_w, T_cong_sj,
                     N_Speed,YK_Speed,HD_Wh_P,HD_JN_P,Coal_ZH_P: Single): WideString; safecall;
      function  Get_Zcyl(const Version: WideString; JinChi: Double): WideString;  safecall;
      function  GetLicensingState(Var UseUnitName:string):Boolean;
      function  GetZoom(JinChi:double):Double;

      property DLLPath:widestring read GetMinaPath ;
      //ϵͳ����
      constructor Create;
      destructor Destroy;
  end;


 var
  ExPstopeClass:TEXPstopeClass;
implementation


{ TMainForm }

uses Lu_Public_BasicModual, VerFityDataComm;

function TEXPstopeClass.ConfirmReg: WordBool;
begin
    { TODO 1 -oluleisoft -c�Ż��޸� : ConfirmReg ����û��д������ }
   Result:=true;
end;

constructor TEXPstopeClass.Create;
begin
   inherited create;
   Create_Public:=FALSE;
    MainPath:=Public_Basic.Get_MyModulePath;
    SystemLabel:='�й���ѧԺ������Ժʿ�Ŷ�';
    // ����ȫ�ֱ����Ĵ�������
    if not Assigned(Public_Basic) then begin
        Public_Basic:=TLu_BasicClass.Create('','serverinfo.dll');
        Create_Public:=true;
    end;


    {��������}
    CreateMainClass;
end;

function TEXPstopeClass.CreateMainClass: Boolean;
{
  �����漰�� ���Ǿֲ�����
}

begin
  Result:=True;
  try
     if not Assigned(Ex_Gzm) then
          Ex_Gzm:=TG_Stope.Create ;     //������
     if not Assigned(Ex_zk) then
          Ex_zk:=Tzk_bore.Create;     //���
     if not Assigned(Ex_imm_r) then
          Ex_imm_r:=TImmediate_roof.Create; //ֱ�Ӷ�
     if not Assigned(Ex_old) then
          Ex_old:=Told_roof.Create;    //�϶�
     if not Assigned(Ex_ZhiJia) then
          Ex_ZhiJia:=TZJ_Class.Create;  //֧��
     if not Assigned(Ex_Cal_show) then
          Ex_Cal_show:=TCal_Show.Create; //��ʾ������
     if not Assigned(MySqliteTable) then
          MySqliteTable:=TSqliteADOData.Create('CoalBasicDataBase.db');
      if not Assigned(MY_DealWith) then
          MY_DealWith:=TPStope_DealWith.Create ;     //����������
  except
     Result:=False;
  end;
end;

destructor TEXPstopeClass.Destroy;
begin
    FreeMainClass;

    if Create_Public then  begin
      if  Assigned(Public_Basic) then
            FreeAndNil(Public_Basic);
    end;
    inherited Destroy;
end;

function TEXPstopeClass.Ex_InitModel(const Gzm, zk,zhijia: WideString;Var Sout:Widestring): Boolean;
var
  sEorr:Widestring;
begin
     sEorr:='';
     Result:=False;
     Init_Enabled:=False;
     if not ConfirmReg then  begin
         Sout:='�ؼ����°汾,����£�';  exit;
     end;
    //ȡ��Dll����·��

     if  not Ex_Gzm.Init(gzm,sEorr) then   begin
         Sout:='�������ʼ��ʧ��:'+sEorr;  exit;
     end;

     if not EX_zk.Init(zk,sEorr) then    begin
         Sout:='��׳�ʼ��ʧ��:'+sEorr;     exit;
     end;
     if not Ex_imm_r.init(Ex_gzm,Ex_zk,0.5,sEorr) then   begin
         Sout:='ֱ�Ӷ�����ʧ��:'+sEorr; exit;
     end;

     if not Ex_old.init(EX_Gzm,Ex_zk,EX_imm_r,sEorr) then   begin
         Sout:='�϶�����ʧ��'+sEorr; exit;
     end ;
     //��ʼ��֧��
     Init_Enabled:=true;
     //��ʼ��
     self.Init_ZhiJia(zhijia);
    //����֧��ѹ���ֲ�
     My_DealWith.Cal_Zcyl(Ex_zk,Ex_imm_r,Ex_gzm,Ex_old,sEorr);
     //�����Ѷϴ��߶�
     MY_DealWith.Cal_Ldg(Ex_zk,Ex_gzm,Ex_imm_r,Ex_old,Ex_gzm.S_L_qx*1.5,sEorr);
     //��ʼ��������
     Ex_Cal_show.Zoom:=1.0;
     //��ʼ������  P_Stope.gzm_jC:=7;
     Result:=true;

end;

procedure TEXPstopeClass.FreeMainClass;
begin
    if  Assigned(Ex_Gzm) then
          FreeAndNil(Ex_Gzm);     //������
     if  Assigned(Ex_zk) then
          FreeAndNil(Ex_zk);     //���
     if  Assigned(Ex_imm_r) then
          FreeAndNil(Ex_imm_r);   //ֱ�Ӷ�
     if  Assigned(Ex_old) then
          FreeAndNil(Ex_old);     //�϶�
     if  Assigned(Ex_ZhiJia) then
          FreeAndNil(Ex_ZhiJia);   //֧��
     if  Assigned(Ex_Cal_show) then
          FreeAndNil(Ex_Cal_show);  //��ʾ������
     if  Assigned(MY_DealWith) then
          FreeAndNil(MY_DealWith);       //����������

     if not Assigned(MySqliteTable) then
          FreeAndNil(MySqliteTable);
end;

function TEXPstopeClass.GetLicensingState(var UseUnitName: string): Boolean;
var
  UtName,Pss:string;
  VFQ:TMyVerFity;
begin
   Result:=False;
   Public_Basic.GetVifFityInfo(UtName,Pss) ;
   VFQ:=TMyVerFity.Create;

      if VFQ.VerFityPassword( UtName,Pss) then  begin
         Result:=true;
         Public_Basic.Licensing :=true;
      end else begin
         UtName:='ɽ���Ƽ���ѧ�����뼼���Ŷ�';
         Public_Basic.Licensing :=False;
      end;
      Public_Basic.UseUnitName:=UtName;
      UseUnitName:=UtName;
    VFQ.Free ;
end;

function TEXPstopeClass.GetMinaPath: widestring;
begin
   Result:=MainPath;
end;

function TEXPstopeClass.GetZoom(JinChi: double): Double;
var
   i,start_yc:integer;
   name_count:integer;
   Y_tu_H,tem_Zoom:double;
begin
      name_count:=0;  Y_tu_H:=0;
       if Ex_old.yl_max_End-2 >0  then  begin
          start_yc:=Ex_old.yl_max_End-2;
       end else begin
          start_yc:=0;
       end;

      for I:=EX_zk.main_coal downto start_yc do  begin
            name_count:=name_count+1;
            if I=EX_zk.main_coal then  begin
                 Y_tu_H:=Y_tu_H+EX_zk.Yc_Rock[i].R_h*Ex_gzm.Mc_FdBs;
            end else begin
                 if i<Ex_old.yl_max_End -2 then    begin
                    Y_tu_H:=Y_tu_H+Ex_ZK.Yc_Rock[i].R_h;
                 end else begin
                    Y_tu_H:=Y_tu_H+Ex_ZK.Yc_Rock[i].R_h;
                 end;
            end;
      end; //end for i


    if JinChi>0 then begin
       tem_Zoom:= Y_tu_H*2/JinChi ;
       Result:= tem_Zoom/3;
    end else begin
       Result:=1;
    end;
end;

function TEXPstopeClass.Get_immediate_roof(Version: string): string;
begin
   Result:=Ex_imm_r.Get_Parameter(Ex_zk,Version);

end;

function TEXPstopeClass.Get_kcjstj(const Version: WideString): WideString;
var
  s_out,temp:widestring;
  lei_tem:widestring;

begin
   Result:='';
   if not Init_Enabled then  exit;

   if Version='1.0' then   begin  //��ɸ�֧����Ϣ���ַ���

        s_out:='';
        s_out:=IntToStr(Ex_imm_r.Imm_leibie)+','; //  ֱ�Ӷ�
        s_out:=s_out+IntToStr(Ex_old.Old_leibie)+',' ;// ������
        s_out:=s_out+IntToStr(Ex_old.diban_leobie)+',' ;// �װ�
        // �жϹ�������
        if Ex_ZhiJia.Zj_JiSuan_Ci_F[0]<= 2400 then   begin
            lei_tem:='1';
        end else if Ex_ZhiJia.Zj_JiSuan_Ci_F[0]<= 3000 then   begin
            lei_tem:='2';
        end else if Ex_ZhiJia.Zj_JiSuan_Ci_F[0]<= 3800 then   begin
            lei_tem:='3';
        end else if Ex_ZhiJia.Zj_JiSuan_Ci_F[0]<= 4800 then   begin
            lei_tem:='4';
        end else if Ex_ZhiJia.Zj_JiSuan_Ci_F[0]<= 6200 then   begin
            lei_tem:='5';
        end else if Ex_ZhiJia.Zj_JiSuan_Ci_F[0]<= 8000 then   begin
            lei_tem:='6';
        end else if Ex_ZhiJia.Zj_JiSuan_Ci_F[0]<= 10000 then   begin
            lei_tem:='7';
        end else if Ex_ZhiJia.Zj_JiSuan_Ci_F[0]<= 15000 then   begin
            lei_tem:='8';
        end else if Ex_ZhiJia.Zj_JiSuan_Ci_F[0]<= 20000 then   begin
            lei_tem:='9';
        end else begin
            lei_tem:='10';
        end;

        s_out:=s_out+lei_tem+',' ;//  ��������
        // �жϲɸ�
        if Ex_Gzm.S_Cg_h<=2.5 then   begin
            lei_tem:='1';
        end else if Ex_Gzm.S_Cg_h<=3.0then   begin
            lei_tem:='2';
        end else if Ex_Gzm.S_Cg_h<=3.5 then   begin
            lei_tem:='3';
        end else if Ex_Gzm.S_Cg_h<=4.0 then   begin
            lei_tem:='4';
        end else if Ex_Gzm.S_Cg_h<=4.5 then   begin
            lei_tem:='5';
        end else if Ex_Gzm.S_Cg_h<=6  then   begin
            lei_tem:='6';
        end else if Ex_Gzm.S_Cg_h<=8  then   begin
            lei_tem:='7';
        end else begin
            lei_tem:='8';
        end;
        s_out:=s_out+lei_tem+',' ;//  �ɸ�
         // �ж���˹
        if Ex_Gzm.Dz_WSFC=1 then   begin
            lei_tem:='3';
        end else if Ex_Gzm.Dz_WSFC=2 then   begin
            lei_tem:='2';
        end else  begin
            lei_tem:='1';
        end;
        s_out:=s_out+lei_tem+',' ;//  ��˹
        s_out:=s_out+ IntToStr(Ex_imm_r.FDm_leibie)+',' ;//  ð����
        // �ж�ú�����
        if Ex_Gzm.S_qj<8 then   begin
            lei_tem:='1';
        end else if Ex_Gzm.S_qj<25 then   begin
            lei_tem:='2';
        end else if Ex_Gzm.S_qj<45 then   begin
            lei_tem:='3';
        end else begin
            lei_tem:='4';
        end;
        s_out:=s_out+lei_tem+',' ;//  ú�����
        Result:=S_out;
   end else if Version='2.0' then   begin   //�ؿ�������ж��ַ���
          s_out:=''; //temp:='   ʵʩ��Ч���Գ���Ŀ����Է�����'+#13+#10;
          temp:='';
          if  Ex_imm_r.Imm_leibie<=2  then  begin
              Ex_Gzm.yklh :=0;
              temp:=temp+'   �ù����������������Χ�ҽ��������ʺϲ��ø�Ч�ؿ�����ķ�����';
          end else if Ex_old.diban_leobie <=2 then begin
              Ex_Gzm.yklh:=0;
              temp:=temp+'   �ù�������������װ�Χ�ҽ��������ʺϲ��ø�Ч�ؿ�����ķ�����';
          end else if Ex_Gzm.S_qj >=35 then begin
              Ex_Gzm.yklh:=0;
              temp:=temp+'   �ù�����ú����ǽϴ󣬲��ʺϲ��ø�Ч�ؿ�����ķ�����';
          end else if (Ex_old.Old_leibie>=4) and (Ex_Gzm.S_Cg_h<=3.0)  then begin
              Ex_Gzm.yklh:=2;
              temp:=temp+'   �ù��������ʵʩ��Ч�ؿ�����ķ�����';
              temp:=temp+'������Ƚϼ�Ӳ������ʹ�ø�Ч�ؿ������Ϊ�˱������Գ�����,';
              temp:=temp+'��Ҫǿ�ƴ������壬����������ඥ������ж�������';
          end else if (Ex_Gzm.S_Cg_h<=3.5)  then begin
              Ex_Gzm.yklh:=1;
              temp:=temp+'   �ù��������ʵʩ��Ч�ؿ�����ķ�����';
              temp:=temp+'����Ҫ��ǿǽ�������߶ȵ���֤�����ǽ���ʩ������������������ѹ��Χ֮�����,';
              temp:=temp+'�����ھ����˶��ȶ�ǰ����Ҫ��������ǿ����֧����';
          end else if (Ex_Gzm.S_Cg_h>3.5)  then begin
              Ex_Gzm.yklh:=1;
              temp:=temp+'   �ù��������ʵʩ��Ч�ؿ�����ķ�����';
              temp:=temp+'��Ҫ�����ؿ������Ķ�ú��Ҫ���б��������������ʵ��ӿ�������ʩ���ٶȣ�';
              temp:=temp+'��ʹ����御����֧�ŵ����ã�����������ε��ٶ�����ȡ�';
          end else if Ex_old.diban_leobie <3 then begin
              Ex_Gzm.yklh:=3;
              temp:=temp+'   �ù��������ʵʩ��Ч�ؿ�����ķ�����';
              temp:='�������ڵװ���Խ�����Ҫ�Եװ��ѹ�뿹ѹǿ�Ƚ��������֤��';
              temp:=temp+'Ϊ������������ԣ���Ҫʱ����Ҫ�Զ������ǿ�ƴ�����';
          end;

          if Ex_Gzm.yklh>=1 then begin
              temp:=temp+#13+#10+ '   ��ǰ֧����Ϊ��߹�������ƽ��ٶ��Լ�ά������������ԣ���Ҫ���ؿ�������������';
              temp:=temp+ '��ǰ֧������ǰ֧���ľ���Ҫ����������'+FormatFloat('0.00',Ex_Gzm.ZCYL_s1[0]*2 )+'�����ϡ�';

          end;

        s_out:=temp;
        Result:=S_out;
   end;

end;

function TEXPstopeClass.Get_Old_roof(Version: string): string;
begin
    Result:= Ex_old.Get_Parameter(Ex_Gzm,Ex_Zk,Ex_imm_r,Version);
end;

function TEXPstopeClass.Get_Support_P(Version: string): string;
begin
    Result:= Ex_Zhijia.Return_zj_Para(Version);
end;

function TEXPstopeClass.Get_yklh_ctcs(const Version: WideString; width,
  Hd_wideth, Hd_heigth: Single): WideString;
  {�ؿ����� ���� ����ǽ����Ҫ������width, ���������   Hd_wideth �������, Hd_heigth: ����߶� }
var
   imm_P,imm_f,total_wideth:double;
   s_out:widestring;
   jianyi_hd_wide:double;
begin
    s_out:='';
    if width=0 then width:=2;
    if Hd_wideth=0 then Hd_wideth:=3;
    if Hd_heigth=0 then Hd_heigth:=3;


    Ex_Gzm.yklh_hpct_h:= Hd_heigth;
    Ex_Gzm.yklh_tc_lu_w:= width;

    if (Version='1.0') and (Ex_Gzm.yklh >0) then   begin

      if width<(hd_heigth*0.5) then begin
         s_out:=s_out+'   �������Ƚ�С���������ӵ�'+FormatFloat('0.00',hd_heigth*0.5)+'�����ϡ�';
      end else if  width >(hd_heigth*1.2) then begin
         s_out:=s_out+'   �������Ƚϴ󣬽�����ٵ�'+FormatFloat('0.00',hd_heigth*1.2)+'�����ڡ�';
      end else begin
          s_out:=s_out+'   �����������У�';
      end;
       // ���� ����ǽ�� ����
      if (Ex_old.Old_leibie>4) then begin
          jianyi_hd_wide:=0.4 *hd_heigth;
      end else  if (Ex_old.Old_leibie=4) then begin
          jianyi_hd_wide:=0.6 *hd_heigth;
      end else  if (Ex_old.Old_leibie=3) then begin
          jianyi_hd_wide:=0.8*hd_heigth;
      end else  if (Ex_old.Old_leibie<3) then begin
          jianyi_hd_wide:=1 *hd_heigth;
      end;
      //
      Ex_Gzm.yklh_tc_js_w:= jianyi_hd_wide;

      s_out:=s_out+'�������Գ�����Ŀ���Ϊ��'+FormatFloat('0.00',jianyi_hd_wide)+'�ס�';

      //Ԥ�����Գ�����ȵļ���
       total_wideth:= width+Hd_wideth;
               //  ֱ�Ӷ���ѹǿ   KPa
      Imm_F:= total_wideth * 1 *Ex_ZhiJia.Zj_imm_p ;   //  ֱ�Ӷ�����
      imm_P:=Imm_F/width;    //ֱ�Ӷ���ѹǿ Mpa

      s_out:=s_out+'�����Գ����Ԥ����� '+FormatFloat('0.00',width)+' �׽���ʩ���������ĳ�ʼ֧��ǿ����ﵽ'
                   +FormatFloat('0.00',imm_P*1.2)+'MPa,����������֧��ǿ����ﵽ'
                   +FormatFloat('0.00',Ex_Gzm.S_mcsd_h*25/1000*2)+'MPa��' ;  // 2 Ϊѹ��ϵ��

      //�������Գ�����ȵļ���
       total_wideth:= jianyi_hd_wide+Hd_wideth;
       Imm_F:= total_wideth * 1 *Ex_ZhiJia.Zj_imm_p ;   //  ֱ�Ӷ�����
       imm_P:=Imm_F/jianyi_hd_wide;     //ֱ�Ӷ���ѹǿ Mpa

      s_out:=s_out+'�����Գ���ռ������ '+FormatFloat('0.00',jianyi_hd_wide)+' �׽���ʩ���������ĳ�ʼ֧��ǿ����ﵽ'
                   +FormatFloat('0.00',imm_P*1.5)+'MPa,����������֧��ǿ����ﵽ'
                   +FormatFloat('0.00',Ex_Gzm.S_mcsd_h*25/1000*2)+'MPa��' ; // 2 Ϊѹ��ϵ��

    end else begin  //end   if Version='1.0' then   begin

         s_out:='��������ʺϽ��и�Ч�ؿ����';
    end;

    Result:= s_out;
end;

function TEXPstopeClass.Get_yklh_fzzh(const Version: WideString): WideString;
{�ؿ����� ���ظ���֧������}
var
  s_out:widestring;
begin
    s_out:='';
    if (Version='1.0') and (Ex_Gzm.yklh >0) then   begin
       if Ex_Gzm.Dz_HangDaoSup=2  then  begin
          s_out:='   ���������Ƚ��������������������ê����ê����ǿһ��֧����';
       end else if Ex_Gzm.Dz_HangDaoSup=3  then  begin
          s_out:='   ��������������пɣ�������ԭ��ê��֧���Ļ����ϣ������ǿһ��ê����';
       end else begin
          s_out:='   ������������Խϲ���鿪չ������֧���Ŀ����о���';
       end;

    end else begin  //end   if Version='1.0' then   begin

         s_out:='   ��������ʺϽ��и�Ч�ؿ����';
    end;

    Result:= s_out;

end;

function TEXPstopeClass.Get_yklh_JJxy(const Version: WideString;  M_dj, Mzhu_w, T_cong_sj,
                     N_Speed,YK_Speed,HD_Wh_P,HD_JN_P,Coal_ZH_P: Single): WideString;
  {�ؿ����� ���ؾ���Ч��
     M_dj  ú�ĵ���, Mzhu_w  ú������, T_cong_sj ����ɱ�
      N_Speed  �������ƽ��ٶ� ,YK_Speed   �����ƽ��ٶ�,
      HD_Wh_P  ���ά���ɱ�,HD_JN_P  �������ɱ�,Coal_ZH_P ��ú�ۺϳɱ�
     }
var
    s_out:widestring;
    M_lifang,ganshi_lifang_lu,ganshi_lifang_js,hd_h:double;
    xiaoyi_lu,xiaoyi_js:double;
begin
    s_out:='';
    if M_dj=0 then  M_dj:=500;
    if Mzhu_w=0 then Mzhu_w:=15;
    if T_cong_sj=0 then  T_cong_sj:=130;

    if Ex_Gzm.yklh_hpct_h=0 then  begin
       Ex_Gzm.yklh_hpct_h:=3.0;
    end;

    if (Version='1.0') and (Ex_Gzm.yklh >0) then   begin
        M_lifang:=Ex_Gzm.S_Sx_zx*Mzhu_w*Ex_Gzm.S_Cg_h;
        ganshi_lifang_lu:= Ex_Gzm.S_Sx_zx*Ex_Gzm.yklh_tc_lu_w*Ex_Gzm.yklh_hpct_h;
        ganshi_lifang_js:= Ex_Gzm.S_Sx_zx*Ex_Gzm.yklh_tc_js_w*Ex_Gzm.yklh_hpct_h;
        xiaoyi_lu:= (M_lifang*1.5* M_dj- ganshi_lifang_lu*T_cong_sj)/10000;
        xiaoyi_js:= (M_lifang*1.5* M_dj- ganshi_lifang_js*T_cong_sj)/10000;
        s_out:='    �ù�����ʵʩ�ؿ�������Զ��ú̿ '+FormatFloat('0.00',M_lifang*1.5/10000)+' ��֣�'
              +'����¼�������Ŀ��ȼ���ɽ�Լ�� ' +FormatFloat('0.00',xiaoyi_lu)+' ��Ԫ;'
              +'��������ģ����������Ŀ��ȼ���ɽ�Լ��' +FormatFloat('0.00',xiaoyi_js)+' ��Ԫ��' ;
    end else begin  //end   if Version='1.0' then   begin
         s_out:='    ��������ʺϽ��и�Ч�ؿ����';
    end;

    Result:= s_out;

end;

function TEXPstopeClass.Get_Zcyl(const Version: WideString;
  JinChi: Double): WideString;
var
  s_out:string;
  hr,ci,l0:double;
begin
    s_out:='';

     if (Version='1.0') or (Version='2.0') then begin
        s_out:=Ex_gzm.Return_Zcyl(Version,JinChi,Ex_zk);
     end else if (Version='3.0') then  begin
        hr:=(Ex_Gzm.S_mcsd_h*25 )/1000;
        ci:=Ex_old.YL_First_step[2]*0.4;
        l0:= Ex_Gzm.S_L_qx;
        if 0.5*l0>3*ci then  begin
            s_out:=FormatFloat('0.00',hr*0.2) +',' +
                   FormatFloat('0.00',hr*0.8) +',' +
                   FormatFloat('0.00',hr*1) +',' +
                   FormatFloat('0.00',hr*1.2) +',' +
                   FormatFloat('0.00',hr*1.5) ;
        end else if 0.5*l0>2*ci then  begin
            s_out:=FormatFloat('0.00',hr*0.2) +',' +
                   FormatFloat('0.00',hr*0.9) +',' +
                   FormatFloat('0.00',hr*1.3) +',' +
                   FormatFloat('0.00',hr*1.5) +',' +
                   FormatFloat('0.00',hr*1.5) ;
        end else if 0.5*l0>ci then  begin
            s_out:=FormatFloat('0.00',hr*0.5) +',' +
                   FormatFloat('0.00',hr*1) +',' +
                   FormatFloat('0.00',hr*1.2) +',' +
                   FormatFloat('0.00',hr*1.2) +',' +
                   FormatFloat('0.00',hr*1.2) ;
        end else begin
            s_out:=FormatFloat('0.00',hr*0.8) +',' +
                   FormatFloat('0.00',hr*1) +',' +
                   FormatFloat('0.00',hr*1.1) +',' +
                   FormatFloat('0.00',hr*1.1) +',' +
                   FormatFloat('0.00',hr*1.1) ;
        end;
     end else if (Version='4.0') then  begin
         s_out:=Ex_gzm.Return_Zcyl(Version,JinChi,Ex_zk);
     end;
      Result:= s_out;
end;

function TEXPstopeClass.Init_ZhiJia(const ZJ: WideString): WideString;
var
    sR:widestring;
    ModuleName:WideString;
begin
     Result:='False';
     if not InIt_enabled   then exit;

     Ex_zhijia.OcxPath :=MainPath;
     EX_zhijia.Init(ZJ,sR);
     Ex_zhijia.Cal_Sup_Para(Ex_gzm,Ex_zk,Ex_imm_r,Ex_old);

     Result:=sR;
end;

end.