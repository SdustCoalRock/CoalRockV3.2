unit PStope_Immediate;

interface

uses
  Windows, SysUtils, Classes, Messages, Controls, Forms, StdCtrls, ExtCtrls,
  ComCtrls,math,IniFiles,Jpeg,Graphics,Dialogs,Lu_Public_BasicModual
  ,PStope_WorKFace
  ;

type
   //����ֱ�Ӷ� ��
    TImmediate_roof=class
      Public
          Start_No  :integer;   //    ֱ�Ӷ���ʼ �Ҳ������±�
          End_No    :integer;    //   ֱ�Ӷ����� �Ҳ������±�
          Surplus_h :double;     //   �ֲ���ʣ��߶�
          Immroof_M  :double;   //    ֱ�Ӷ����ۻ��߶�
          Immroof_C0  :double;   //   ֱ�Ӷ��ĳ�����ѹ����
          is_init     :bool;      //  ֱ�Ӷ��Ƿ��ʼ��
          Imm_leibie      :Integer;//  ֱ�Ӷ����
          FDm_leibie      :Integer;//��úð�������

        function Cal_Immediate_roof(S_gzm: TG_stope; s_zk: TZk_bore;safe_h:double;out sEorr:widestring) :wordbool;
                //����ֱ�Ӷ�������s_gzm���������   s_zk��׶���  saft_h����ֱ�Ӷ��İ�ȫ����  s����eorr�����ַ���
        function Cal_beam(S_gzm: TG_stope; s_zk: TZk_bore;out sEorr:widestring):wordbool ;
                //�������������ԣ���������䵽������ڡ�


        function init(s_gzm: TG_stope; s_zk: TZk_bore;safe_h:double;out sEorr:widestring):wordbool ;
        function Get_Parameter(zk:Tzk_bore;Version:widestring):wideString;  stdcall;
        function Get_YC_Png(zk:Tzk_bore;s_gzm: TG_stope;t_imm:Timmediate_roof;JinChi:double):wideString;  stdcall;



        end;

  //�����϶���
  TOld_roof=class
      public
        YL_struc: integer;//����϶��Ľṹ�� 1 Ϊ��������2 Ϊ������
        YL_start :integer;    //  �϶���ʼ�Ҳ�
        yl_max_End : integer;  //�϶��������Ҳ�
        YL_min_End   :integer;    //  �϶���С�����Ҳ�
        YL_max_m     :double;     //  �϶����߶�
        YL_min_m     :double;     //  �϶���С�߶�
        YL_First_step     : array[0..2] of double;    //�ۺ�����������ѹ����  0 Ϊ���ֵ��1Ϊ��Сֵ��2Ϊƽ��ֵ
        YL_Zhouqi_step    : array[0..2] of double;    //�ۺ�����������ѹ����  0 Ϊ���ֵ��1Ϊ��Сֵ��2Ϊƽ��ֵ
        YL_YL_first_step     : array[0..5,0..2] of double;    //�������ۺϳ�����ѹ����  0 Ϊ���ֵ��1Ϊ��Сֵ��2Ϊƽ��ֵ
        YL_YL_Zhouqi_step    : array[0..5,0..2] of double; //�����ۺ�������ѹ����  0 Ϊ���ֵ��1Ϊ��Сֵ��2Ϊƽ��ֵ
        YL_YL_M              : array[0..5,0..2] of double; //�����ۺϺ��  0 Ϊ���ֵ��1Ϊ��Сֵ��2Ϊƽ��ֵ
        YL_Step_struct: integer; // ���෨ �����ṹ
        YL_Dep_struct:integer; // �ѶϷ� �����ṹ
        is_init      :bool;
        Old_leibie       :Integer; // �϶����
        diban_leobie     :Integer; //�װ����

       function init(s_gzm: TG_stope; s_zk: TZk_bore;t_imm:Timmediate_roof; out sEorr: WideString):wordbool ;
       function Get_Parameter(s_gzm: TG_stope;zk:Tzk_bore;t_imm:Timmediate_roof;Version:Widestring):WideString;
       function Return_C0(zk:Tzk_bore):wideString;  stdcall; //���������ĳ�����ѹ����
       function Return_ldg(zk:Tzk_bore;s_gzm: TG_stope;t_imm:Timmediate_roof;Gzmjc:double;Version:WideString):wideString;  stdcall; //�����ѶϹ��ı߽�
       function ReturnCoalSa(zk:Tzk_bore):widestring; stdcall ;
      end;


implementation

{ TImmediate_roof }

function TImmediate_roof.Cal_beam(S_gzm: TG_stope; s_zk: TZk_bore;
  out sEorr: widestring): wordbool;
 var
     i,j,k :integer;
     YL_h:double;
     m,q,c_i: array of double;
     mq : double;
begin
    //�����϶���ʼ��λ��
  //�����϶���ʼ��λ��
     Result:=true;
  try
    if self.Surplus_h =0 then
        begin
           i:=self.End_No-1;
           YL_h:=s_zk.Yc_Rock[i].R_h;
        end
     else
        begin
           i:=self.End_No;
           Yl_h:=self.Surplus_h;
           s_zk.Yc_Rock[End_No].Step_Rock(Surplus_h,s_zk.Yc_Rock[End_No].R_klqd,s_zk.Yc_Rock[End_No].R_r);
     end;
    //��ʼ����̬����
    setlength(m,i+1);
    setlength(q,i+1);
    setlength(c_i,i+1);
    for j := 0 to i  do   begin
        if j=i then  begin
            m[j]:=Yl_h;
        end else if s_zk.Yc_Rock[j].R_sffc then begin
            m[j]:=s_zk.Yc_Rock[j].R_fchd ;
        end else  begin
             m[j]:=s_zk.Yc_Rock[j].R_h ;
        end;

         q[j]:=s_zk.Yc_Rock[j].R_klqd;
         c_i[j]:=s_zk.Yc_Rock[j].Step0 ;
      end;
     // �ж�����������
       mq:=m[i]*m[i]*q[i];
       k:=0;
       s_zk.Beam_Def[k].Start_YC_No :=i;
       s_zk.Beam_Def[k].Ztc_ms :=m[i];
       s_zk.Beam_Def[k].Sdc_mc :=s_zk.Yc_Rock[i].R_h-m[i];
       for j := i-1 downto 0   do
         begin
           if k>3  then break;
           if  mq < 1.15*1.15*1.15*1.15*m[j]*m[j]*q[j] then
               begin
                 s_zk.Beam_Def[k].End_Yc_NO :=j+1;
                 inc(k);
                 s_zk.Beam_Def[k].Sdc_mc :=s_zk.Yc_Rock[j].R_h-m[j];
                 if k>4  then break;
                 s_zk.Beam_Def[k].Start_YC_No :=j;
                 s_zk.Beam_Def[k].Ztc_ms :=m[j];
                 mq :=m[j]*m[j]*q[j];
                end  else  begin
                  s_zk.Beam_Def[k].Sdc_mc:=s_zk.Beam_Def[k].Sdc_mc+m[j];
                  s_zk.Beam_Def[k].End_Yc_NO :=j;
               end;
        end;// ������end

     //�жϲ��������
      mq:=c_i[i];
      k:=0;
       s_zk.Beam_step[k].Start_YC_No :=i;
       s_zk.Beam_step[k].Ztc_ms :=m[i];
       s_zk.Beam_step[k].Sdc_mc :=s_zk.Yc_Rock[i].R_h-m[i];
       for j := i-1 downto 0   do
         begin
           if k>3  then break;
           if  mq < 1.15 *c_i[j] then
               begin
                 s_zk.Beam_step[k].End_Yc_NO :=j+1;
                 inc(k);
                 s_zk.Beam_step[k].Sdc_mc :=s_zk.Yc_Rock[j].R_h-m[j];
                 if k>4  then break;
                 s_zk.Beam_step[k].Start_YC_No:=j;
                 s_zk.Beam_step[k].Ztc_ms :=m[j];
                 mq :=c_i[j];
               end
            else
               begin
                 s_zk.Beam_step[k].Sdc_mc:=s_zk.Beam_step[k].Sdc_mc+m[j];
                 s_zk.Beam_step[k].End_Yc_NO :=j;
               end;
        end;// �����end

         if s_zk.Beam_Def[0].End_Yc_NO =0 then   s_zk.Beam_Def[0].End_Yc_NO :=1;
         if s_zk.Beam_step[0].End_Yc_NO =0 then  s_zk.Beam_step[0].End_Yc_NO :=1;       //


       //������������Ĳ��࣬��������
       for j := 0 to 4 do
         begin
           //����beam_def�����ĳ�����ѹ����

           if s_zk.Beam_Def[j].Ztc_ms >0  then
              begin
                 //�����涯����㷨
                 s_zk.Beam_Def[j].Step_0_Compr:=Public_Basic.Firststep(s_zk.Beam_Def[j].Sdc_mc ,s_zk.Beam_Def[j].Ztc_ms ,
                                           s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_klqd,
                                           s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_r,s_gzm.S_qj);
                 s_zk.Beam_Def[j].Step_i_Compr[0]:=0.3*s_zk.Beam_Def[j].Step_0_Compr;
                    for k := 1 to 5 do
                       begin
                          if k=1 then
                               begin
                               s_zk.Beam_Def[j].Step_i_Compr[k]:=Public_Basic.NextStep(s_zk.Beam_Def[j].Step_0_Compr,k-1,s_zk.Beam_Def[j].Sdc_mc ,
                                              s_zk.Beam_Def[j].Ztc_ms ,s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_klqd,
                                              s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_r,s_gzm.S_qj);
                               end
                           else
                                begin
                               s_zk.Beam_Def[j].Step_i_Compr[k]:=Public_Basic.NextStep(s_zk.Beam_Def[j].Step_i_Compr[k-1],k-1,
                                               s_zk.Beam_Def[j].Sdc_mc ,s_zk.Beam_Def[j].Ztc_ms ,s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_klqd,
                                               s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_r,s_gzm.S_qj);

                           end;
                       end;
                 //�������涯���㷨
                 s_zk.Beam_Def[j].Step_0_Simple:=Public_Basic.Firststep(0 ,s_zk.Beam_Def[j].Ztc_ms ,s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_klqd,
                                              s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_r,s_gzm.S_qj);
                 s_zk.Beam_Def[j].Step_i_Simple[0]:=0.3*s_zk.Beam_Def[j].Step_0_Simple;
                    for k := 1 to 5 do
                       begin
                          if k=1 then
                               begin
                               s_zk.Beam_Def[j].Step_i_Simple[k]:=Public_Basic.NextStep(s_zk.Beam_Def[j].Step_0_Simple,k-1,0 ,
                                              s_zk.Beam_Def[j].Ztc_ms ,s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_klqd,
                                              s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_r,s_gzm.S_qj);
                               end
                           else
                                begin
                               s_zk.Beam_Def[j].Step_i_Simple[k]:=Public_Basic.NextStep(s_zk.Beam_Def[j].Step_i_Simple[k-1],k-1,0 ,
                                                s_zk.Beam_Def[j].Ztc_ms ,s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_klqd,
                                                s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_r,s_gzm.S_qj);

                           end;
                       end;
              end;
           //����beam_step�����ĳ�����ѹ����
           if s_zk.Beam_step[j].Ztc_ms >0  then
              begin
                 //�����涯����㷨
                 s_zk.Beam_step[j].Step_0_Compr:=Public_Basic.Firststep(s_zk.Beam_step[j].Sdc_mc ,s_zk.Beam_step[j].Ztc_ms ,
                                    s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_klqd,s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_r,s_gzm.S_qj);
                 s_zk.Beam_step[j].Step_i_Compr[0]:=0.3*s_zk.Beam_step[j].Step_0_Compr;
                    for k := 1 to 5 do
                       begin
                          if k=1 then
                               begin
                               s_zk.Beam_step[j].Step_i_Compr[k]:=Public_Basic.NextStep(s_zk.Beam_step[j].Step_0_Compr,k-1,s_zk.Beam_step[j].Sdc_mc ,
                                                s_zk.Beam_step[j].Ztc_ms ,s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_klqd,
                                                s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_r,s_gzm.S_qj);
                               end
                           else
                                begin
                               s_zk.Beam_step[j].Step_i_Compr[k]:=Public_Basic.NextStep(s_zk.Beam_step[j].Step_i_Compr[k-1],k-1,
                                                s_zk.Beam_step[j].Sdc_mc ,s_zk.Beam_step[j].Ztc_ms ,s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_klqd,
                                                s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_r,s_gzm.S_qj);

                           end;
                       end;
                 //�������涯���㷨
                 s_zk.Beam_step[j].Step_0_Simple:=Public_Basic.Firststep(0 ,s_zk.Beam_step[j].Ztc_ms ,s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_klqd,
                                              s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_r,s_gzm.S_qj);
                 s_zk.Beam_step[j].step_i_simple[0]:=0.3*s_zk.Beam_step[j].Step_0_Simple;
                    for k := 1 to 5 do
                       begin
                          if k=1 then
                               begin
                               s_zk.Beam_step[j].step_i_simple[k]:=Public_Basic.NextStep(s_zk.Beam_step[j].Step_0_Compr,k-1,s_zk.Beam_step[j].Sdc_mc ,
                                                          s_zk.Beam_step[j].Ztc_ms ,s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_klqd,s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_r,s_gzm.S_qj);
                               end
                           else
                                begin
                               s_zk.Beam_step[j].step_i_simple[k]:=Public_Basic.NextStep(s_zk.Beam_step[j].Step_i_Compr[k-1],k-1,s_zk.Beam_step[j].Sdc_mc ,
                                                   s_zk.Beam_step[j].Ztc_ms ,s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_klqd,
                                                   s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_r,s_gzm.S_qj);

                           end;
                       end;   //end k
              end;  //end if  t_zk


         end;   //end for  j
    except
      on e:exception do begin
        Result:=False ;
        sEorr:='������������';
        Public_Basic.My_WriteLog('Eorr:.Cal_beam_'+e.message,'[TImmediate_roof]');
      end;
   end;  //end try

end;

function TImmediate_roof.Cal_Immediate_roof(S_gzm: TG_stope; s_zk: TZk_bore;
  safe_h: double; out sEorr: widestring): wordbool;
 //����ֱ�Ӷ�������s_gzm���������   s_zk��׶���  saft_h����ֱ�Ӷ��İ�ȫ����  s����eorr�����ַ���
var
        i,j:integer;
        SA:double;
        j_count:bool;
 begin
  //�ѷŶ�ú���ݼ������
      if S_gzm.S_cmfs='4' then
         S_gzm.S_Fm_h:= s_zk.Yc_Rock[s_zk.main_coal].R_h -S_gzm.S_Cg_h
         else S_gzm.S_Fm_h:=0;
      if S_gzm.S_Fm_h<0 then S_gzm.S_Fm_h:=0;

     //
     i:=s_zk.main_coal-1;  // ��¼ú���Ϸ���һ���Ҳ�������±�
     self.Immroof_C0:=s_zk.Yc_Rock[i].Step0;//����ֱ�Ӷ��ĵ�һ����ѹ���ࡣ
     SA:=s_gzm.S_Cg_h+s_gzm.S_Fm_h;   //�����ʼ�³�����
     self.Immroof_M:=s_zk.Yc_Rock[s_zk.main_coal].R_h-Sa; //�Ѷ�ú�ĺ�ȼ���
     Result:=true;
     self.Surplus_h :=0;
     //ֱ�Ӷ���һ�δ���
     if SA<s_zk.Yc_Rock[i].R_h then
         if s_zk.Yc_Rock[i].R_sffc then   begin
            s_zk.Yc_Rock[i].Step_Rock(s_zk.Yc_Rock[i].R_fchd,s_zk.Yc_Rock[i].R_klqd,s_zk.Yc_Rock[i].R_r  );
            self.Immroof_C0:=s_zk.Yc_Rock[i].Step0;// �޶�ֱ�Ӷ���һ����ѹ���ࡣ
         end;

     try
         self.Start_No:=i;     // ��ʼ��ֱ�Ӷ���ʼ�Ҳ������±�
          while i>0 do
            begin
             //��Ӳ����ǿ���Դ���
             if (s_zk.Yc_Rock[i].Step0 >120) and (not s_zk.Yc_Rock[i].R_sffc)then
               begin
                  self.End_No:=i+1;
                  self.is_init:=true;
                 // sEorr:='start:'+FloatToStr(self.Start_No)+':end'+ FloatToStr(self.End_No)+':ʣ��'+FloatToStr(self.Surplus_h)+':���'+FloatToStr(self.Immroof_M);
                  exit;
               end;

             if SA>=s_zk.Yc_Rock[i].R_h  then    //�³��ռ���ڱ��Ҳ�ĸ߶�
                  begin
                     self.Immroof_M:=self.Immroof_M+s_zk.Yc_Rock[i].R_h;  // ֱ�Ӷ��߶��ۼ�
                     SA:=SA-(s_zk.Yc_Rock[i].R_k_Rock-1)* s_zk.Yc_Rock[i].R_h;  // �Ҳ��³��ռ����
                     dec(i);
                  end   else  begin     //  //�³��ռ�С�ڱ��Ҳ�ĸ߶�
                      j:=0;
                      j_count:=true;
                      while J_count do      //�ֲ�ѭ��
                        begin

                           if  s_zk.Yc_Rock[i].R_fchd =0 then  begin //��ֹ��ѭ������

                              J_count:=False;
                              self.End_No:=i+1;
                              self.Surplus_h :=0;
                              i:=0;
                            end else if  s_zk.Yc_Rock[i].R_h>j*s_zk.Yc_Rock[i].R_fchd then   begin   //  �Ҳ��ȴ��ڷֲ���ۼƺ��
                                  if  SA>=S_zk.Yc_Rock[i].R_fchd - safe_h  then    begin   //   �Ҳ���³��ռ���ڱ��ηֲ���

                                           self.Immroof_M :=self.Immroof_M + S_zk.Yc_Rock[i].R_fchd;
                                           SA:=SA-(s_zk.Yc_Rock[i].R_k_Rock-1)* s_zk.Yc_Rock[i].R_fchd;
                                           inc(j);
                                   end  else  begin      //   �Ҳ���³��ռ�С�ڱ��ηֲ���  ֱ�Ӷ��������
                                         J_count:=False;
                                         if j=0  then begin
                                            self.End_No:=i+1;
                                            self.Surplus_h :=0;
                                            i:=0;
                                          end else begin
                                            self.End_No:=i;
                                            self.Surplus_h :=s_zk.Yc_Rock[i].R_h -s_zk.Yc_Rock[i].R_fchd*j;
                                            i:=0;
                                         end;

                                  end;  //end     if  SA>S_zk.Yc_Rock[i].R_fchd +safe_h
                            end  else  begin    //  �Ҳ���С�ڷֲ���ۼƺ��
                                J_count:=False;
                                self.Immroof_M:=self.Immroof_M+(s_zk.Yc_Rock[i].R_h-(j)*s_zk.Yc_Rock[i].R_fchd );
                                SA:=SA-(s_zk.Yc_Rock[i].R_k_Rock-1)* (s_zk.Yc_Rock[i].R_h-(j)*s_zk.Yc_Rock[i].R_fchd );
                                dec(i);
                            end ;//end if  s_zk.Yc_Rock[i].R_h>j*s_zk.Yc_Rock[i].R_fchd

                       end; //end while J_count=True

                  end; //end if   SA>=s_zk.Yc_Rock[i-1].R_h

            end;//----end  while i>0

          except
            Result:=False;
            sEorr:='ֱ�Ӷ��������';

        end;  //end try
           //ʣ��ǽ���ж�
            if (Surplus_h>0) and (Surplus_h <1)   then Surplus_h:=0;
           //ʣ���ȴ����㣬���¼��㱾�Ҳ�ĳ�����ѹ����
           if Surplus_h>0  then
              s_zk.Yc_Rock[End_No].Step_Rock(Surplus_h,s_zk.Yc_Rock[End_No].R_klqd ,s_zk.Yc_Rock[End_No].R_r );
            //����ÿһ���Ҳ���³��ռ�
           s_zk.Yc_Rock[self.Start_No].Sa[0]:=S_gzm.S_Cg_h+s_gzm.S_Fm_h;
           s_zk.Yc_Rock[self.Start_No].Sa[1]:=S_gzm.S_Cg_h+s_gzm.S_Fm_h;
           s_zk.Yc_Rock[self.Start_No].Sa[2]:=S_gzm.S_Cg_h+s_gzm.S_Fm_h;

          for I := self.Start_No-1  downto 0 do
             begin
                 if i>=self.End_No-1  then  begin
                    s_zk.Yc_Rock[i].Sa[0]:= s_zk.Yc_Rock[i+1].Sa[0]-(s_zk.Yc_Rock[i+1].R_k_Rock-1)* s_zk.Yc_Rock[i+1].R_h;  // �Ҳ��³��ռ����
                    s_zk.Yc_Rock[i].Sa[1]:= s_zk.Yc_Rock[i+1].Sa[1]-(s_zk.Yc_Rock[i+1].R_k_Rock*0.95-1)* s_zk.Yc_Rock[i+1].R_h;  // �Ҳ��³��ռ����
                    s_zk.Yc_Rock[i].Sa[2]:= s_zk.Yc_Rock[i+1].Sa[2]-(s_zk.Yc_Rock[i+1].R_k_Rock*0.85-1)* s_zk.Yc_Rock[i+1].R_h;  // �Ҳ��³��ռ����

                    if s_zk.Yc_Rock[i].Sa[0]<=0 then s_zk.Yc_Rock[i].Sa[0]:=0.5; // ֱ�Ӷ�
                    if s_zk.Yc_Rock[i].Sa[1]<=0 then s_zk.Yc_Rock[i].Sa[1]:=0.8; //  ֱ�Ӷ�
                    if s_zk.Yc_Rock[i].Sa[2]<=0 then s_zk.Yc_Rock[i].Sa[2]:=1;  //ֱ�Ӷ�
                  end else begin
                    s_zk.Yc_Rock[i].Sa[0]:= s_zk.Yc_Rock[i+1].Sa[0]; // �϶�
                    s_zk.Yc_Rock[i].Sa[1]:= s_zk.Yc_Rock[i+1].Sa[1]; // �϶�
                    s_zk.Yc_Rock[i].Sa[2]:= s_zk.Yc_Rock[i+1].Sa[2];  // �϶�

                 end;  //end ifi>=self
             end; //end for i
end; // TImmediate_roof.Cal_Immediate_roof  ��������

function TImmediate_roof.Get_Parameter(zk: Tzk_bore;
  Version: widestring): wideString;
 Var
       S_out:WideString;
 begin
   if not self.is_init  then
      begin
         S_out:='ֱ�Ӷ���ʼ��ʧ��!';
         exit;
      end;

    if Version='1.0' then begin
       S_out:='ֱ�Ӷ��߶�'+':';
           S_out:=S_out+FormatFloat('0.00',self.Immroof_M)+';';
       S_out:=S_out+' ֱ�Ӷ����ο��䲽��'+':';
           S_out:=S_out+FormatFloat('0.00',self.Immroof_C0 )+'��; ';
       S_out:=S_out+' ֱ�Ӷ����ϲ��Ҳ�Ϊ'+':';
           S_out:=S_out+(zk.Yc_Rock[self.End_No].R_Name )+';';
       S_out:=S_out+' ֱ�Ӷ��Ҳ����'+':';
           S_out:=S_out+IntToStr(self.Start_No-self.End_No+1 )+'��;';

       Result:=S_out;
    end else if Version='2.0'  then  begin
       S_out:='';
           S_out:=S_out+FormatFloat('0.00',self.Immroof_M)+';';
           S_out:=S_out+FormatFloat('0.00',self.Immroof_C0 )+';';
           S_out:=S_out+IntToStr(zk.Yc_Rock[self.End_No].Yc_No )+';';
           S_out:=S_out+IntToStr(self.Start_No-self.End_No+1 )+';';

       Result:=S_out;
    end;

end;

function TImmediate_roof.Get_YC_Png(zk: Tzk_bore; s_gzm: TG_stope;
  t_imm: Timmediate_roof; JinChi: double): wideString;
 Var
       S_out:WideString;
       i :integer;
 begin
       if not self.is_init  then
          begin
             S_out:='ֱ�Ӷ���ʼ��ʧ��!';
             exit;
          end;
       S_out:='';
       //t_get_result.

       //  Cal_Ldg(zk,s_gzm,t_imm,JinChi,S_out);
       S_out:='';
       for I :=0  to zk.main_coal-1 do
         begin
             S_out:=S_out+IntToStr(zk.Yc_Rock[i].Yc_No)+',';
             S_out:=S_out+IntToStr(zk.Yc_Rock[i].PNG_Change) +';';

         end;


       Result:=S_out;

end;

function TImmediate_roof.init(s_gzm: TG_stope; s_zk: TZk_bore; safe_h: double;
  out sEorr: widestring): wordbool;
 begin
          //---�ж����Ƿ񴴽�
       try
          self.is_init:=False;
          Result:=True;
          if s_gzm=nil  then
           begin
             sEorr:='û�г�ʼ�����������!';
             Result:=False;
             Public_Basic.My_WriteLog('Eorr:.�������ഴ������!','[TImmediate_roof]');
              exit;
           end;
         if s_zk=nil then
             begin
              sEorr:='û�г�ʼ����ײ���!';
              Result:=False;
              Public_Basic.My_WriteLog('Eorr:.����ഴ������!','[TImmediate_roof]');
              exit;
             end;
         if not s_gzm.is_init then
            begin
             sEorr:='û�г�ʼ�����������!';
              Result:=False;
              Public_Basic.My_WriteLog('Eorr:���������ʼ������!','[TImmediate_roof]');
              exit;
            end;
         if not s_zk.is_init then
            begin
              sEorr:='û�г�ʼ�����������!';
              Result:=False;
              Public_Basic.My_WriteLog('Eorr:.������ʼ������!','[TImmediate_roof]');
              exit;
            end;

          //�ɸߴ�������Ҳ�߶ȵĴ���   2016.505
          if s_zk.Yc_Rock[s_zk.main_coal].R_h< s_gzm.S_Cg_h then
               s_gzm.S_Cg_h:=s_zk.Yc_Rock[s_zk.main_coal].R_h  ;//--------------����Ŷ�ú�Ĳ���
           if s_gzm.S_cmfs='4' then begin
              s_gzm.S_Fm_h:=s_zk.Yc_Rock[s_zk.main_coal].R_h-s_gzm.S_Cg_h;
           end;
        //--------------
           if not self.Cal_Immediate_roof(s_gzm,s_zk,safe_h,sEorr) then     //����ֱ�Ӷ�
             begin
               Result:=False;
               Public_Basic.My_WriteLog('Eorr:.ֱ�Ӷ��������!','[TImmediate_roof]');
               exit;
             end;
           if not  self.Cal_beam(s_gzm,s_zk,sEorr) then     //���������Ľṹ
             begin
               Result:=False;
               Public_Basic.My_WriteLog('Eorr:.�����жϴ���!','[TImmediate_roof]');
               exit;
             end;
         //�ж�ֱ�Ӷ������
          if self.Immroof_C0<=4 then  begin
              self.Imm_leibie:=1;
          end else if self.Immroof_C0<=8 then  begin
              self.Imm_leibie:=2;
          end else if self.Immroof_C0<=18 then  begin
              self.Imm_leibie:=3;
          end else if self.Immroof_C0<=32 then  begin
              self.Imm_leibie:=4;
          end else begin
              self.Imm_leibie:=5;
          end;
        //�ж϶�úð����
         if s_gzm.S_cmfs='4' then  begin
               if s_gzm.S_f_PS =1 then begin
                  self.FDm_leibie :=1;
               end else if ((s_gzm.S_f_PS =2) and (s_gzm.Dz_DCGZ >3)) then begin
                  self.FDm_leibie :=1;
               end else if ((s_gzm.S_f_PS =2) and (s_gzm.Dz_DCGZ <4)) then begin
                  self.FDm_leibie :=2;
               end else if ((s_gzm.S_f_PS =3) and (s_gzm.Dz_DCGZ >3)) then begin
                  self.FDm_leibie :=3;
               end else if ((s_gzm.S_f_PS =3) and (s_gzm.Dz_DCGZ <4)) then begin
                  self.FDm_leibie :=4;
               end else  begin
                 self.FDm_leibie :=5;
               end;
         end else begin
             self.FDm_leibie :=0;
         end;

       except
         on e:exception do begin
           Result:=False;
           sEorr:='���ݸ�ʽ����';
           Public_Basic.My_WriteLog('Eorr:.init_'+e.message,'[TImmediate_roof]');
         end;

        end;
         if Result then
            self.is_init:=true;

end;

{ TOld_roof }

function TOld_roof.Get_Parameter(s_gzm: TG_stope; zk: Tzk_bore;
  t_imm: Timmediate_roof; Version: Widestring): WideString;
 Var
     S_out:WideString;
  begin
      if not self.is_init  then
          begin
             S_out:='�϶���ʼ��ʧ��!';
             exit;
          end;
      if Version='1.0' then   begin
                S_out:='�϶��ۺ������Ľṹ'+':';
                    if self.YL_struc=1 then
                         begin
                          S_out:=S_out+'������'+';';
                          end
                     else
                          begin
                          S_out:=S_out+'������'+';';
                      end;
                 S_out:=S_out+' �϶���λ���������'+':';
                     S_out:=S_out+FormatFloat('0.00',self.YL_max_m )+'��;';
                 S_out:=S_out+' �϶���λ�������β����ƽ��ֵΪ'+':';
                     S_out:=S_out+FormatFloat('0.00',self.YL_First_step[2])+'��;';
                 S_out:=S_out+' �϶���λ�������ڲ����ƽ��ֵ'+':';
                     S_out:=S_out+FormatFloat('0.00',self.YL_Zhouqi_step[2])+'��;';
                 if t_imm.Surplus_h >0 then
                     begin
                     S_out:=S_out+' �϶���λ������֧�в���ֱ�Ӷ����ϲ�����ͬ��'+Trim(zk.Yc_Rock[self.YL_start].R_Name)+'�Ҳ㣬�϶����ú��Ϊ(��)'+':';
                          S_out:=S_out+FormatFloat('0.00',t_imm.Surplus_h )+';';
                     end;
                 S_out:=S_out+' $�����н���:  ';


                 if self.YL_struc=2 then
                    begin
                       S_out:=S_out+'    �Բ�ú������Ӱ��Ƚϴ���Ҳ��Ǿ���ú�㶥���Ϸ� '+':';
                          S_out:=S_out+FormatFloat('0.00',t_imm.Immroof_M+self.YL_min_m );
                          S_out:=S_out+'��,���Ϊ'+FormatFloat('0.00',zk.Yc_Rock[self.YL_min_End-1].R_h)+'�׵�'+Trim(zk.Yc_Rock[self.YL_min_End-1].R_Name)+',';
                          S_out:=S_out+'������ѹ����Ϊ'+FormatFloat('0.00',zk.Yc_Rock[self.YL_min_End-1].Step0 )+'(+/-1.5)��,';
                          S_out:=S_out+'������ѹ����Ϊ'+FormatFloat('0.00',zk.Yc_Rock[self.YL_min_End-1].Step0 *s_gzm.Ci_xs)+'(+/-1.5)��,';
                          S_out:=S_out+' �빤����ע�����'+'��';
                    end  else    begin
                      S_out:=S_out+'�Բ�ú������Ӱ��Ƚϴ���Ҳ��Ǿ���ú�㶥���Ϸ� '+':';
                          S_out:=S_out+FormatFloat('0.00',t_imm.Immroof_M );
                          S_out:=S_out+'��,���Ϊ'+FormatFloat('0.00',zk.Yc_Rock[self.YL_start].R_h)+'�׵�'+Trim(zk.Yc_Rock[self.YL_start].R_Name)+',';
                          S_out:=S_out+'������ѹ����Ϊ'+FormatFloat('0.00',self.YL_First_step[2] )+'(+/-1.5)��,';
                          S_out:=S_out+'������ѹ����Ϊ'+FormatFloat('0.00',self.YL_Zhouqi_step[2])+'(+/-1.5)��,';
                          S_out:=S_out+' �빤����ע�����'+'��';

                     end;

                  Result:=S_out;
      end else if Version='3.0' then begin
             S_out:='';
                    if self.YL_struc=1 then
                         begin
                          S_out:=S_out+'������'+';';
                          end
                     else
                          begin
                          S_out:=S_out+'������'+';';
                      end;
                      S_out:=S_out+FormatFloat('0.00',self.YL_max_m )+';';   //�����
                      S_out:=S_out+FormatFloat('0.00',self.YL_min_m )+';';
                      S_out:=S_out+FormatFloat('0.00',self.YL_First_step[0])+';'+FormatFloat('0.00',self.YL_First_step[1])+';'+FormatFloat('0.00',self.YL_First_step[2])+';';  // �϶���λ�������β�������/��С/ƽ��ֵ(��)'+':';
                      S_out:=S_out+FormatFloat('0.00',self.YL_Zhouqi_step[0])+';'+FormatFloat('0.00',self.YL_Zhouqi_step[1])+';'+FormatFloat('0.00',self.YL_Zhouqi_step[2])+';'; //    S_out:=S_out+'�϶���λ�������ڲ�������/��С/ƽ��ֵ(��)'+':';
              Result:=S_out;
       end else if Version='4.0' then begin
             S_out:='';
                    S_out:=S_out+FormatFloat('0.00',self.YL_Zhouqi_step[2]); //    S_out:=S_out+'�϶���λ�������ڲ����/ƽ��ֵ(��)'+':';
             Result:=S_out;

      end;
end;

function TOld_roof.init(s_gzm: TG_stope; s_zk: TZk_bore; t_imm: Timmediate_roof;
  out sEorr: WideString): wordbool;
var
  i,j:integer;
  Dn,N:double ; //Dn :�϶���ѹǿ�ȣ�N ֱ�Ӷ����ϵ��
  TotalH:double;
  MaxStep:integer;
begin
       is_init:=true;

       if not t_imm.is_init  then
            begin
              sEorr:='û�г�ʼ��ֱ�Ӷ�����!';
              Result:=False;
              exit;
            end;
   //2016.5.5
     //�жϻ����������� �����������������
     //ͨ�� Dn=L0-15.2N+42.9M �ķ�ʽ�ж�
     //Dn�ķ��� 1��  Dn<=80.5  2�� 80.5~128.4   3��  128.4~188.3   4��   188.3  248   5�� 250
         N:=t_imm.Immroof_M/s_gzm.S_Cg_h;
         Dn:=self.YL_First_step[0]-15.2*N+42.9*s_gzm.S_Cg_h;
         if Dn<=80.5  then begin
             self.Old_leibie :=1;
             s_gzm.Ci_xs:=0.4;
             s_gzm.dynamic_factor:=1.1;
         end else if Dn<=128.4 then begin
             self.Old_leibie :=2;
             s_gzm.Ci_xs:=0.35;
             s_gzm.dynamic_factor:=1.2;
         end else if Dn<=188.3 then begin
             self.Old_leibie :=3;
             s_gzm.Ci_xs:=0.3;
             s_gzm.dynamic_factor:=1.3;
         end else if Dn<=248 then begin
             self.Old_leibie :=4;
             s_gzm.Ci_xs:=0.3;
             s_gzm.dynamic_factor:=1.5;
         end else begin
             self.Old_leibie :=5;
             s_gzm.Ci_xs:=0.288;
             s_gzm.dynamic_factor:=1.7;
         end;
         //���¼����Ҳ�����ڲ���
         for I := 0 to s_zk.Zk_Yc_Count-1 do begin
            s_zk.Yc_Rock[i].step_i[0]:=s_gzm.Ci_xs* s_zk.Yc_Rock[i].Step0;
         end;
          //���¼������������ڲ���
        for I := 0 to 4 do   begin
          s_zk.Beam_Def[i].Step_i_Compr[0]:= s_zk.Beam_Def[i].Step_0_Compr*s_gzm.Ci_xs;
          s_zk.Beam_Def[i].step_i_simple[0]:= s_zk.Beam_Def[i].Step_0_Simple*s_gzm.Ci_xs;
          s_zk.Beam_step[i].Step_i_Compr[0]:= s_zk.Beam_step[i].Step_0_Compr*s_gzm.Ci_xs;
          s_zk.Beam_step[i].step_i_simple[0]:= s_zk.Beam_step[i].Step_0_Simple*s_gzm.Ci_xs;

        end;

     //============================================================================


   try
        //�ж��϶���λ����
        self.YL_max_m:=0;
        self.YL_min_m:=0;
        j:=0;
        TotalH:=0;
     self.YL_start :=s_zk.Beam_Def[0].Start_YC_No ;
     //�����������ṹ
     for I := 0 to 4 do  begin
         TotalH:=TotalH+ s_zk.Beam_Def[i].Ztc_ms+s_zk.Beam_Def[i].Sdc_mc;
         //�ܸ߶��޶�
         if TotalH > 7 *s_gzm.S_Cg_h  then
            break;
         //����޶�
         if (s_zk.Beam_Def[i].Ztc_ms >s_gzm.S_Cg_h*1.2) or
            (s_zk.Beam_Def[i].Ztc_ms+s_zk.Beam_Def[i].Sdc_mc > s_gzm.S_Cg_h*3) then
             break;

     end;

     self.YL_Max_end:=s_zk.Beam_Def[i].End_Yc_NO;
     self.yl_max_m:= TotalH;
     if I>0 then  YL_Dep_struct:=I+1 else  YL_Dep_struct:=1;

     //���෨�����ṹ
     TotalH:=0;
     for I := 0 to 4 do  begin
         TotalH:=TotalH+ s_zk.Beam_step[i].Ztc_ms+s_zk.Beam_step[i].Sdc_mc;
         //�ܸ߶��޶�
         if TotalH > 7*s_gzm.S_Cg_h  then
            break;
         //����޶�
         if (s_zk.Beam_step[i].Ztc_ms >s_gzm.S_Cg_h*1.2) or
            (s_zk.Beam_step[i].Ztc_ms+s_zk.Beam_step[i].Sdc_mc > s_gzm.S_Cg_h*3) then
             break;
     end;
     //���ղ���ȷ��
       if s_zk.Beam_step[i].End_Yc_NO < self.YL_max_end then   begin
           YL_min_end:=YL_max_end;
           YL_max_end:=s_zk.Beam_step[i].End_Yc_NO;
       end else begin
           YL_min_end:=i;
           YL_max_end:=s_zk.Beam_step[i].End_Yc_NO;
       end;
       // ǿ�Ƹı��Ҳ�Ĳ���
       if YL_min_end=0 then  YL_min_end:=1;

       //
       if TotalH>yl_max_m then   begin
          yl_min_m:=yl_max_m;
          yl_max_m:= TotalH;
       end else begin
          yl_min_m:= TotalH;
       end;
     //�����빤����Ĺ�ϵ
     if I>0 then  YL_Step_struct:=I+1  else YL_step_struct:=1;
     //�ۺ������ṹ
     if  (YL_Step_struct >=2) or  (YL_Dep_struct >=2) then
               self.YL_struc :=2 else   self.YL_struc :=1;

     for i:= 0 to 4 do   begin
         if (i+1 > YL_Step_struct) and (i+1 > YL_Dep_struct) then  begin
            break;
         end else  if (i+1 <YL_Step_struct) and (i+1 > YL_Dep_struct) then begin
            YL_YL_First_step [i][0]:=max(s_zk.Beam_step[i].Step_0_Simple,
                                         s_zk.Beam_step[i].Step_0_Compr );
            YL_YL_First_step [i][1]:=min(s_zk.Beam_step[i].Step_0_Simple,
                                         s_zk.Beam_step[i].Step_0_Compr );

            YL_YL_First_step [i][2]:=(s_zk.Beam_step[i].Step_0_Simple+
                                         s_zk.Beam_step[i].Step_0_Compr )/2;
            //
            YL_YL_M[i][0]:= s_zk.Beam_step[i].Ztc_ms+s_zk.Beam_step[i].Sdc_mc;
            YL_YL_M[i][1]:=YL_YL_M[i][0];
            YL_YL_M[i][2]:=YL_YL_M[i][0];

         end else if (i+1 >YL_Step_struct) and (i+1 < YL_Dep_struct) then begin
            YL_YL_First_step [i][0]:=max(s_zk.Beam_Def[i].Step_0_Simple,
                                         s_zk.Beam_Def[i].Step_0_Compr );
            YL_YL_First_step [i][1]:=min(s_zk.Beam_Def[i].Step_0_Simple,
                                         s_zk.Beam_Def[i].Step_0_Compr );

            YL_YL_First_step [i][2]:=(s_zk.Beam_Def[i].Step_0_Simple+
                                         s_zk.Beam_Def[i].Step_0_Compr )/2;
            //
            //
            YL_YL_M[i][0]:= s_zk.Beam_Def[i].Ztc_ms+s_zk.Beam_Def[i].Sdc_mc;
            YL_YL_M[i][1]:=YL_YL_M[i][0];
            YL_YL_M[i][2]:=YL_YL_M[i][0];
         end else begin
            YL_YL_First_step [i][0]:=Public_Basic.select_max(s_zk.Beam_Def[i].Step_0_Compr,
                              s_zk.Beam_Def[i].Step_0_Simple ,
                              s_zk.Beam_step[i].Step_0_Compr ,
                              s_zk.Beam_step[i].Step_0_Simple);
            YL_YL_First_step [i][1]:=Public_Basic.select_min(s_zk.Beam_Def[i].Step_0_Compr,
                              s_zk.Beam_Def[i].Step_0_Simple ,
                              s_zk.Beam_step[i].Step_0_Compr ,
                              s_zk.Beam_step[i].Step_0_Simple);
            YL_YL_First_step [i][2]:=(s_zk.Beam_Def[i].Step_0_Compr+
                              s_zk.Beam_Def[i].Step_0_Simple +
                              s_zk.Beam_step[i].Step_0_Compr +
                              s_zk.Beam_step[i].Step_0_Simple)/4;
            //
            YL_YL_M[i][0]:= max(s_zk.Beam_Def[i].Ztc_ms+s_zk.Beam_Def[i].Sdc_mc,
                                s_zk.Beam_step[i].Ztc_ms+s_zk.Beam_step[i].Sdc_mc);
            YL_YL_M[i][1]:= max(s_zk.Beam_Def[i].Ztc_ms+s_zk.Beam_Def[i].Sdc_mc,
                                s_zk.Beam_step[i].Ztc_ms+s_zk.Beam_step[i].Sdc_mc);
            YL_YL_M[i][2]:=(YL_YL_M[i][0]+YL_YL_M[i][1])/2;

         end;
           self.YL_YL_Zhouqi_step[i][0]:=  YL_YL_First_step [i][0]*s_gzm.Ci_xs;
           self.YL_YL_Zhouqi_step[i][1]:=  YL_YL_First_step [i][1]*s_gzm.Ci_xs;
           self.YL_YL_Zhouqi_step[i][2]:=  YL_YL_First_step [i][2]*s_gzm.Ci_xs;
     end;

       // �ж������������ۺϵ���ѹ����
       if (YL_YL_Zhouqi_step[0][2] > YL_YL_Zhouqi_step[1][2]) and
          (YL_YL_M[0][2] > YL_YL_M[1][2]*1.5 )   then  j:=0
          else j:=1;

       // ��һ����������ѹ�������ֵ
       if j=0 then  begin
          self.YL_First_step[0]:=YL_YL_First_step [0][0] ;
          self.YL_First_step[1]:=YL_YL_First_step [0][1] ;
          self.YL_First_step[2]:=YL_YL_First_step [0][2] ;
       end else begin
          self.YL_First_step[0]:=(YL_YL_First_step [1][0]+YL_YL_First_step [0][0] )/2 ;
          self.YL_First_step[1]:=(YL_YL_First_step [1][1]+YL_YL_First_step [0][1] )/2  ;
          self.YL_First_step[2]:=(YL_YL_First_step [1][2]+YL_YL_First_step [0][2] )/2  ;
       end;
        // ��λ����������ѹ�������ֵ
       self.YL_Zhouqi_step[0]:=YL_First_step[0] *s_gzm.Ci_xs;
        // ��λ����������ѹ������Сֵ
       self.YL_Zhouqi_step[1]:=self.YL_First_step[1]*s_gzm.Ci_xs;
        // ��λ����������ѹ����ƽ��ֵ
       self.YL_Zhouqi_step[2]:=self.YL_First_step[2]*s_gzm.Ci_xs;



        //�жϵװ������ ���װ��������  1�� ��7.22   2��7.22��10.80  3��  10.80��15.21   4��   15.21��22.84   5��  22.84��41.79      6�� ��41.79
        //ͨ���װ�Ŀ�ѹǿ���ж�
        if s_zk.Yc_Rock[s_zk.main_coal+1].R_kyqd <= 7.22 then  begin
           self.diban_leobie :=1;
        end else  if s_zk.Yc_Rock[s_zk.main_coal+1].R_kyqd <= 10.8 then  begin
           self.diban_leobie :=2;
        end else  if s_zk.Yc_Rock[s_zk.main_coal+1].R_kyqd <= 15.21 then  begin
           self.diban_leobie :=3;
        end else  if s_zk.Yc_Rock[s_zk.main_coal+1].R_kyqd <= 22.84 then  begin
           self.diban_leobie :=4;
        end else  if s_zk.Yc_Rock[s_zk.main_coal+1].R_kyqd <= 41.79 then  begin
           self.diban_leobie :=5;
        end else  begin
           self.diban_leobie :=6;
        end;

      except
         Result:=False;
         Is_init:=false;
         sEorr:='�϶�������ʧ�ܣ�';
     end;   //end try
        Result:=true;
           // sEorr:='�϶���ʼ���ɹ���';
end;
  //�����Ҳ�ĳ�����ѹ����
function TOld_roof.ReturnCoalSa(zk: Tzk_bore): widestring;
begin
   result:=FormatFloat('0.00',zk.Yc_Rock[self.YL_start].Sa[0]);
end;

function TOld_roof.Return_C0(zk: Tzk_bore): wideString;
 var
       S_out:WideString;
       i:integer;
    begin
        S_out:='';
        for I := 0 to zk.Zk_Yc_Count-1   do
         begin
           S_out:=S_out+IntToStr(zk.Yc_Rock[i].Yc_No)+','+ FormatFloat('0.00',zk.Yc_Rock[i].Step0 )+';';
         end;
         Result:=S_out;
    end;
   //�����϶����ѶϹ��߽�
function Told_roof.Return_ldg(zk:Tzk_bore;s_gzm: TG_stope;t_imm:Timmediate_roof;Gzmjc:double;Version:WideString):wideString;  stdcall;
var
       S_out:WideString;
       i:integer;
begin
       { TODO : ����δ���� }
      // PS_DealWith.Cal_Ldg(zk,s_gzm,t_imm,self,gzmjc,S_out);
//        S_out:='';
//        if Version='1.0' then begin ////�����ѶϹ��ı߽�
//              for I :=0  to zk.main_coal-1 do
//               begin
//
//                   S_out:=S_out+IntToStr(zk.Yc_Rock[i].Yc_No)+','+ FormatFloat('0.00',zk.Yc_Rock[i].L_qx_xiashan )+',';
//                   S_out:=S_out+ FormatFloat('0.00',zk.Yc_Rock[i].L_qx_shangshan )+',';
//                   S_out:=S_out+ FormatFloat('0.00',zk.Yc_Rock[i].L_Tj )+';';
//
//                end;//enf for
//               Result:=S_out;
//        end else if Version='2.0' then  begin
//               S_out:=FormatFloat('0.00',s_gzm.Hg_ldg );
//               Result:=S_out;
//        end;

end;



end.