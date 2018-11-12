//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//<<      �ļ�����Lu_Mk_base_class.pas                          <<
//<<      ¬��־ʹ�õĸ���Delphi�ļ�                            <<
//<<      ���ļ���Ҫ����Ϊú��Com���ʹ�õ�                     <<
//<<      �������ڣ�2011.8.12                                   <<
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

unit Lu_Mk_base_Class;

interface

uses
  Windows, SysUtils, Classes, Messages, Controls, Forms, StdCtrls, ExtCtrls,
  ComCtrls,math,IniFiles,Jpeg,Graphics,Dialogs,Lu_Public_BasicModual;

type 

 //������ʯ��,Ϊ TRock
   TRock =class(Tobject)
   
    public
      R_Name  :WideString;    //��ʯ����
      R_h     :double;        //��ʯ���
      R_kyqd  : double;       // ��ѹǿ��
      R_klqd  : double;       // ����ǿ��
      R_fchd  :double;        // �ֲ���
      R_k_Rock: double;      // ��ʯ����ϵ��
      R_r      : double;     //  ��ʯ����
      PNG_Change:integer;   //�Ҳ��Ƿ��������
      R_kjqd :double;//����ǿ��
      R_MinH :double; //�Ҳ���С���
      R_MaxH :double;  // �Ҳ������
      R_sffc :bool;//     �Ƿ�ֲ�
      R_sfhsc:bool;//     �Ƿ�ˮ
      Tuli:TMemoryStream; //ͼ��
      MCId:integer; //ú���id���
           end;

 //�����Ҳ��� TYc_Rcok
  TYc_Rock =class(TRock)

    public
      //�ⲿ�������
      Yc_No       :integer;    //�Ҳ���
      M_Kc_YandN  :bool;      // �Ƿ��ǿ���ú��
      L_qx_xiashan   :double ;    //��б�����ѶϹ���ɽ������б�����ߵĳ���
      L_qx_shangshan   :double ;    //��б�����ѶϹ���ɽ������б�����ߵĳ���
      L_Tj        :double;     //�ƽ������ѶϹ����߾����ú������ľ���
      //�ڲ��������
      Step0      :double;    //����ÿһ���Ҳ�ĳ�����ѹ����
      step_i     : array [0..4] of double ; // ����ÿһ���Ҳ��1-4��������ѹ���� ����0 �� Ϊ �ȶ����ڲ���
      Sa : array [0..2] of double ;     //  ��¼�����³��� 0 Ϊ��ʼ�³� 1Ϊ �����³���0.95  2 Ϊ �ȶ��³�  0.85


    public
       procedure Step_Rock(h,Rc,r:double);

                end;

  //����������
   TYL_beam =class (Tobject)
      public
        Start_YC_No :  integer;    //
        End_Yc_NO   :  integer;    //
        Ztc_ms      :double;       //֧�в�ĺ��
        Sdc_mc      :double;       //�涯��ĺ��
        Step_0_Compr    :  double;     //  �����涯��
        Step_i_Compr    :  array[0..5] of double;     //    �±�0 Ϊ �ȶ����࣬1-5 Ϊ��һ�ε���5��������ѹ
        Step_0_Simple   :  double;     //  �������涯��
        step_i_simple   :  array[0..5] of double;     //   �±�0 Ϊ �ȶ����࣬1-5 Ϊ��һ�ε���5��������ѹ
     //   is_init         :  bool ; //��¼�Ƿ񱻳�ʼ��
        end;

  //��������� TZk
   TZk_bore =class(Tobject)
     public
            Zk_No       :integer;             // ��ױ��
            Zk_Yc_Count :integer;            // �Ҳ����
            Zk_name     : WideString;        // �������
            Yc_Rock    :array of TYc_Rock;   // �Ҳ����飨��̬���飬�±�Ϊ�Ҳ�Ĳ�����
          //  Beam_Def_count    :integer;      //��������������ĸ���
            Beam_Def  :array[0..4] of TYL_beam;   //��������������Ķ�̬����
           // Beam_step_count   :integer;     //  ����ڲ��������ĸ���
            Beam_step :array[0..4] of TYL_beam;  // ����ڲ������Ķ�̬����
            main_coal  :  integer;  // �ô�Ϊ�Ҳ�����ı��
            is_init    :bool  ;
            Zk_ldg_end_no:integer;//  // �ô�Ϊ�ѶϹ��Ҳ���ֹ�� �Ҳ�������
           // 20160830
            Mineid:integer;



        function Init(s_zk:wideString;out sEorr:Widestring):WordBool;
        function ReturnSa(zk:TZk_bore):wideString;  stdcall;
        function ReturnCxbj(zk:TZk_bore):wideString;  stdcall;
        function Return_ZkCs:widestring; stdcall;
        destructor Destroy ;override;
   end;

  //���幤������ TG_stope
  TG_stope =class

       public
        S_Name   :WideString;         //  1����������
        S_No     :WideString;         // 2 ��������
        S_mc_name:WideString;         // 3 ����ú������
        S_Cg_h   :double;             // 4 ������ɸ�
        S_cmfs   :WideString;         // 5 ��ú��ʽ
        S_Fm_h   :double;             // 6 ��ú�߶�
        S_qj     :double;             // 7 ú�����
        S_mcsd_h :double;             // 8 ������
        S_L_qx   :double;             // 9 ��������б��
        S_Sx_zx  :double;             // 10 ����������
        S_Jc_L   :double;             // 11 �������ۼƽ���
        S_f_PS   :double;             // 12  ú�������ϵ��
        S_M_mcj  :double;             // 13  ú�����Ħ����
        S_M_njl  :double;             // 14  ú����ھ���
        S_Bsb    :double;             // 15  ý��Ĳ��ɱ�
        S_K_zcfz :double;             // 16  ֧��ѹ����ֵϵ��
        S_Dblb   :Widestring;         // 17   �����涥�����
        ZCYL_sx  :array[0..3] of double; //18 ֧��ѹ���ķ�Χ   0 ������ǰ���� 1 �·� 2 ��  3 �Ϸ�
        ZCYL_s0  :double;             // 19  ��Ӧ�����ķ�Χ
        ZCYL_s1  :array[0..3] of double;//20 ֧��ѹ���߷�ķ�Χ 0Ϊ������ǰ����󷽣�1Ϊ ����������
        Hg_ldg   :double;              // 21 ֧��ѹ���ѶϹ�
        is_init  :bool ;               // 22
        mbcsnl_l :double;              //23 ú��ɥʧ֧�������ľ���
        Dz_yxfx     :integer;             // 24  1	ˮƽ�ƽ�   		2	��б�ƽ�  3	��б�ƽ�
        Dz_JYHD	   :integer;            // 25   1	������  	2	һ�����   3	�к����     	4	�޺����
        Dz_DCGZ     :integer;            //26 	1	���ʹ������    	2	��б�Ჿ     3	��б�Ჿ   4	�ϲ��ܼ�������Ӱ���ƽ�   5	�ϲ��ܼ���Ӱ���ƽ�  6	���켫�临��
        Dz_WSFC	   :integer;            // 27   1	��˹�����ϵ�   	2	����˹���ֲ�����  3	����˹
        Dz_TopWater :integer;            // 28  	1	������ˮ  	2	��ˮ����붥���Զ  	3	��ˮ����붥��Ͻ�   4	������͸ˮ�¹�   	5	����
        Dz_BottomWater: Integer;          // 29 	1	�װ���ˮԴ   2	�װ���ˮԴ����Զ  3	�װ���ˮԴ���Ͻ�   4	�������װ�ͻ���¹�    5	����
        Dz_HeoStress	:integer;           //  30  1	������ˮƽӦ��  2	ˮƽӦ��С�ڴ�ֱӦ��  3	ˮƽӦ���봹ֱӦ���൱  4	ˮƽӦ�����ڴ�ֱӦ��1.5������
        Dz_Kyxx       :Integer;          // 31  	1	��ѹ���ֲ�����   2	�п�ѹ���֣���Ӱ������  3	��ѹ���ֽϾ��ң�Ӱ����  4	�����������¹�
        Dz_HangDaoSup :integer;          //32   	1	�����������Ҫ֧��  	2	�����ê��֧��   3	�������֧��������������  	4	������Σ��׹ģ���ȫӰ��С  5	������ٱ��Σ��׹ģ�����Ӱ�찲ȫ
        CK_Upkc       :integer;          //33      �Ͻ쿪�����     0 δ��  1 �Բ�
        CK_UpMz       :double;           //34       �Ͻ�ú��
        CK_downkc     :integer;          //35     �½쿪��       0 δ��  1 �Բ�
        CK_downmz     :double;          // 36    �½�úס
        S_DayStep_speed: double;       //  37  ���������ƽ��ٶ�
        S_Sh_UP       :double;         //  38  �������ϱ߽����
        S_Sh_Down     :double;         //  39  �������±߽����
        S_SX_qj       :double;         //  40  �������ƽ��������
        UP_Ckq        :Integer;         // 41 �������Ϸ��Ƿ���ڲɿ���
        UP_CKQ_Kc_H   :double;         // 42 �ɿ����Ĳɸ�
        UP_CKQ_JuLI   :double;         //43 �ɿ�������ù�����ľ���
        Mc_FdBs       :double;         //44 ú��ķŴ������������˶�ʱʹ��
        Ci_xs         :double;         // 45  ������ѹ�������ϵ��
        yklh          :integer;        // 46�Ƿ���ʵʩ��Ч�ؿ����0 ���� 1 ����  2 ��Ҫ��������  3 ��Ҫ�����װ� 
        yklh_hpct_h   :double;         // 47  �ؿ����� ���Գ���ĸ߶�
        yklh_tc_lu_w:    double;          //  48 �ؿ��������ǽ��� ¼�� ����
        yklh_tc_js_w:    double;          //  49 �ؿ��������ǽ���  ���� ����
        S_AGV_MCH    :double;        //50 ú��ƽ�����
        S_Mtyd       :Integer;         // 51ú��Ӳ��,��Ӧ���Ǳ�� 1(0.8);2(0.8-1.5) 3(1.5-2.5) 4(2.5 ����)
        DZ_Zhqk      : integer;       // 52 ֧����� 1  ����֧��  2 �۲�֧��
        S_CMFS_INteger: integer;     //53��ú����  �����ֱ�ʾ 1_�ڲ� 2_�ղ�  3_�۲�(һ�β�ȫ��) 4_�Ŷ�ú 5_�ֲ㿪��(�Ϸֲ�) 6_�ֲ㿪��(�·ֲ�)

         function Init(str:wideString;out sEorr:Widestring):WordBool;
         function Init_GZM_simple(str:wideString;out sEorr:Widestring):WordBool;
         function Init_GZM_Difficult(str:wideString;out sEorr:Widestring):WordBool;
         function Return_Zcyl(Version:WideString;JinChi:double;zk:Tzk_bore):Widestring;//���ز�ú�������֧��ѹ��

      end;

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
        YL_First_step     : array[0..2] of double;    //������ѹ����  0 Ϊ���ֵ��1Ϊ��Сֵ��2Ϊƽ��ֵ
        YL_Zhouqi_step    : array[0..2] of double;    //������ѹ����  0 Ϊ���ֵ��1Ϊ��Сֵ��2Ϊƽ��ֵ
        is_init      :bool;
        Old_leibie       :Integer; // �϶����
        diban_leobie     :Integer; //�װ����

       function init(s_gzm: TG_stope; s_zk: TZk_bore;t_imm:Timmediate_roof; out sEorr: WideString):wordbool ;
       function Get_Parameter(s_gzm: TG_stope;zk:Tzk_bore;t_imm:Timmediate_roof;Version:Widestring):WideString;
       function Return_C0(zk:Tzk_bore):wideString;  stdcall; //���������ĳ�����ѹ����
       function Return_ldg(zk:Tzk_bore;s_gzm: TG_stope;t_imm:Timmediate_roof;Gzmjc:double;Version:WideString):wideString;  stdcall; //�����ѶϹ��ı߽�

      end;
   // //����֧����
  TZJ_Class=class
      public
         Zj_Name: WideString;    //֧�ܵ�����
         ZJ_Tu_Bianhao:widestring; //֧��ͼ�����
         Zj_BianHao:WideString;  //֧�ܵı��
         Zj_XingHao:WideString;   //֧�ܵ��ͺ�
         Zj_Lizhu_count: Integer;  //֧����������
         Zj_toall_F:double;       //֧�������迹��
         zj_toall_P:double;       //֧��֧��ǿ��
         Zj_suoliang:double;      //֧���������
         Zj_Max_h:double;         //֧�����߶�
         Zj_min_h:double;         //֧����С�߶�
         Zj_KongdingJU:double;    //֧�ܿض���
         Zj_zhongxinju:double;    //֧�����ľ�
         Zj_hlzyd:double;        //�������õ�
         Zj_hubang_h:double;      //֧�ܻ���߶�
         Zj_hubang_jishu:integer;  //֧�ܻ��Ｖ��
         zj_hubang_F:double;     //֧�ܻ�������
         zj_hubang_P:double;     //֧�ܻ���ǿ��
         Zj_JiSuan_suoliang: double;// ֧�ܼ��������
         Zj_JiSuan_C0_F: array[0..2] of double;// ������ѹʱ֧�ܼ��������  0 ���ֵ 1 ��Сֵ 2 ƽ��ֵ
         Zj_JiSuan_C0_P: array[0..2] of double;// ������ѹʱ֧�ܼ����֧��ǿ��  0 ���ֵ 1 ��Сֵ 2 ƽ��ֵ
         Zj_JiSuan_Ci_F: array[0..2] of double;// ������ѹʱ֧�ܼ��������  0 ���ֵ 1 ��Сֵ 2 ƽ��ֵ
         Zj_JiSuan_Ci_P: array[0..2] of double;// ����ѹʱ֧�ܼ����֧��ǿ��  0 ���ֵ 1 ��Сֵ 2 ƽ��ֵ
         Zj_Jisuan_SL: array[0..2] of double;// ֧�ܼ��������  0 ���ֵ 1 ��Сֵ 2 ƽ��ֵ
         Zj_JiSuan_hubang_H: array[0..5] of double;// ֧�ܼ��㻥��߶�   '(0)Ϊ���л����棬(1)Ϊ��Ħ���Ǽ���,(2)Ϊѹ�˼���,(3)Ϊú���������� ,(4)֧�ܹ���������ʽ����
         Zj_JiSuan_hubang_P: array[0..2] of double;// ֧�ܼ��㻥��ǿ��   0 ���ֵ 1 ��Сֵ 2 ƽ��ֵ
         JG_jx:widestring;     //  ���ͽṹ
         JG_Dl:widestring;     //  �����ṹ
         JG_Dz:widestring;     // �����ṹ
         JG_slg:widestring;     // �����ɽṹ
         JG_ty:widestring;     // ���ƽṹ
         JG_Fm:widestring;     // ��ú�ṹ
         JG_Wl:widestring;     // β���ṹ
         JG_Qc:widestring;     // ǰ����β���໤��
         JG_Ct:widestring;     // ���ƽṹ
         JG_Dt:widestring;     //�׵��ṹ
         JG_Ql:widestring;     //ǰ���ṹ
         ZJ_JianYi_Type:Widestring;  //֧�ܵ�ѡ���ͺ�
         zhiJia_F_xs  :double; // ֧�������޶�ϵ��
         zhijia_L_xs  :double; // ֧�������޶�ϵ��
         zhijia_hb_Q_xs :double;// ֧�ܻ���ǿ���޶�ϵ��
         Zj_DBFD_xs:  array[1..9] of double;// ���治ͬ���� ����
         OcxPath:widestring; //Ocx·��
         Zj_imm_p:double; // ֧��֧��ֱ�Ӷ���ѹǿ
         Zj_old_C0_p:array[0..2] of double;// ������ѹʱ֧�ܼ����֧��ǿ��  0 ���ֵ 1 ��Сֵ 2 ƽ��ֵ
         Zj_old_Ci_p:array[0..2] of double;// ������ѹʱ֧�ܼ����֧��ǿ��  0 ���ֵ 1 ��Сֵ 2 ƽ��ֵ
         Zj_Lz_Diameter:double; //������ֱ��



         function Init(str:wideString;out sEorr:Widestring):WordBool; //��ʼ��֧��
         function Cal_Sup_Para(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString; //����֧�ܲ�sh
         function DzXd_Cal_sup_para(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString; //  ���ݵ��������޶�֧�ܵĻ�������
         function Return_zj_Para(Version:WideString):WideString;   //����֧�ܲ���
         function SpliJG(str:widestring;out sEorr:widestring):WordBool; //��ִ���֧�ܽṹ�ַ���
         function ReadZhijia_XS(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString; //����֧�ܲ�sh
         procedure Draw_zhiJia(Image:TImage;x1,y1,x2,y2,mc_h:double;lizhushu,jia_type:integer);// jia_type 1 �۲�  2 �۷�

  end;

   // //�����������ʾ�����
  TCal_Show=class
      public
        Zomm_D: double; //1 ͼ����ʾ����
        model_l:integer; //  2 �Ҳ���ʾ�Ŀ�ʼ����  0 ȫ��  1  �������²�  2 1-2 ������
        model_start_yc: integer; // 3 ģ���Ҳ㿪ʼ�Ĳ���
        hcd_bl: double; //  4 ��������ʾ����

        function DrawFyyd(Image_Out:TImage;JinChi,X_pan_move:double;Tuxing,disp_two_tu,disp_ylg:integer;NQ_step:String;gzm:TG_stope;Zk:Tzk_bore;ZhiJia:TZJ_Class;imm:TImmediate_roof;old:Told_roof):Integer;

        function DrawZcyl(Image:TImage;P1,P2:TPoint;zcyl:Str_Dt_array;bl:double;left_right:bool):WordBool;
        // �ⲿimage  ����   X ƽ��   ͼ��   �������� ����
        function Draw_YLG(Image:TImage;L1,L2,R1,R2:TStringList):WordBool;// ��֧��ѹ��ƽ�⹰

       
  end;

 TMainClass_PStope= Class
    public
       t_Gzm:TG_Stope;     //������
       t_zk:Tzk_bore;     //���
       t_imm_r:TImmediate_roof; //ֱ�Ӷ�
       t_old:Told_roof;    //�϶�
       t_ZhiJia:TZJ_Class;  //֧��
       t_Cal_show:TCal_Show;

      function InitModel(GzmStr,ZkStr:String;Var sEorr:String):Boolean;
      function Get_Stope_info:string;
      procedure Set_Old_Step(MaxValue, MinValue, AGVVale: Double); safecall;
      function Get_Edit_ZkCS: WideString; safecall;

      constructor Create;
      destructor Destroy;override;
 End;

      //��������֮��ĺ���

      //����֧��ѹ��
    function Cal_Zcyl(zk:Tzk_bore;imm:TImmediate_roof;gzm:TG_stope;old_r:Told_roof;out S_zcyl: wideString):wordbool;
    // �����ѶϹ��ı߽�
    function Cal_Ldg(zk:Tzk_bore;gzm:TG_stope;imm:TImmediate_roof;old_r:Told_roof;gzmjc:double;out S_ldg:widestring):wordbool;
    //  �����˶����ɵ���
    function Return_Fyyd(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString;


 implementation

// uses uMainFun;



  //\\\\\\\\\\\\\\\\\\\\\\\


//----- ú�������Ķ������
//--------��ʼ����������
  function TG_stope.Init(str: WideString;out sEorr:Widestring):wordbool;
     var
           temp1,temp2 :Str_Dt_array;
           i,Count1,Count2:integer;
      begin
        Result:=true;

      try
            temp1:=Public_Basic.split(str,':',Count1);
          
            if UpperCase(temp1[0])='GZM' then begin
                self.Init_GZM_simple(str,sEorr);
            end else if UpperCase(temp1[0])='GZM_D' then begin
                self.Init_GZM_Difficult(str,sEorr);
            end else begin
               Result:=False;
               sEorr:='�����汨ͷGZM����!';
               Public_Basic.My_WriteLog('Eorr:Init �����汨ͷGZM����!','[TG_stope]');
               exit;
            end;

      except
              Result:=False;
              sEorr:='���ݸ�ʽ����/';
              Public_Basic.My_WriteLog('Eorr:Init ���ݸ�ʽ����/!','[TG_stope]');
              exit;
       end;

   end;
   //---------------------------------------  ��ʼ����������ڶ��θ��ӵ�

  function TG_stope.Init_GZM_difficult(str: WideString;out sEorr:Widestring):wordbool;
     var
           temp1,temp2 :Str_Dt_array;
           i,Count1,Count2:integer;
      begin
        Result:=true;

      try
           temp1:=Public_Basic.split(str,':',Count1);
           temp2:=Public_Basic.split(temp1[1],',',Count2);
           if count2<27 then
               begin
               Result:=False;
               sEorr:='����ϸ����ļ�!';
               Public_Basic.My_WriteLog('Eorr:Init_GZM_difficult count2<27','[TG_stope]');
               exit;
              end;
         for i :=low(temp2) to high(temp2) do
           begin
             if length(temp2[i])=0 then continue;
                  case i of
                     0: self.S_No        :=Trim(StringReplace(temp2[i],#13#10,'',[]));
                     1: self.S_Name      :=Trim(StringReplace(temp2[i],#13#10,'',[]));
                     2: self.S_Mc_name   :=Trim(StringReplace(temp2[i],#13#10,'',[]));
                     3: self.S_cg_h      :=Public_Basic.strTodouble_lu(temp2[i]);
                     4: self.S_cmfs      :=Trim(StringReplace(temp2[i],#13#10,'',[]));
                     5: self.S_DayStep_speed  :=Public_Basic.strTodouble_lu(temp2[i]);
                     6: self.S_qj        :=Public_Basic.strTodouble_lu(temp2[i]);
                     7: self.S_SX_qj     :=Public_Basic.strTodouble_lu(temp2[i]);
                     8: self.S_Sh_UP     :=Public_Basic.strTodouble_lu(temp2[i]);
                     9: self.S_Sh_Down   :=Public_Basic.strTodouble_lu(temp2[i]);
                     10: self.S_mcsd_h   :=Public_Basic.strTodouble_lu(temp2[i]);
                     11: self.S_L_qx     :=Public_Basic.strTodouble_lu(temp2[i]);
                     12: self.S_Sx_zx    :=Public_Basic.strTodouble_lu(temp2[i]);
                     13:
                        begin
                         self.S_f_PS     :=Public_Basic.strTodouble_lu(temp2[i]);
                         if S_f_PS<1.1 then  begin
                             self.S_M_mcj:=20;
                             self.S_Bsb:=0.35;
                             self.S_M_njl:=10;
                             self.S_K_zcfz:=1.7-0.1*(self.S_Cg_h-4);
                          end else if S_f_PS<2.1 then  begin
                             self.S_M_mcj:=24;
                             self.S_Bsb:=0.3;
                             self.S_M_njl:=23;
                             self.S_K_zcfz:=2.0-0.1*(self.S_Cg_h-4);
                         end else if S_f_PS<3.1 then  begin
                             self.S_M_mcj:=28;
                             self.S_Bsb:=0.25;
                             self.S_M_njl:=40;
                             self.S_K_zcfz:=2.3-0.1*(self.S_Cg_h-4);
                         end else begin
                             self.S_M_mcj:=32;
                             self.S_Bsb:=0.2;
                             self.S_M_njl:=60;
                             self.S_K_zcfz:=2.6-0.1*(self.S_Cg_h-4);

                         end;

                        end;
                     14: self.Dz_yxfx    :=strToInt(temp2[i]);
                     15: self.Dz_JYHD    :=strToInt(temp2[i]);
                     16: self.Dz_DCGZ    :=strToInt(temp2[i]);
                     17: self.Dz_WSFC    :=strToInt(temp2[i]);
                     18: self.Dz_TopWater     :=strToInt(temp2[i]);
                     19: self.Dz_BottomWater  :=strToInt(temp2[i]);
                     20: self.Dz_HeoStress    :=strToInt(temp2[i]);
                     21: self.Dz_Kyxx    :=strToInt(temp2[i]);
                     22: self.Dz_HangDaoSup   :=strToInt(temp2[i]);
                     23: self.CK_Upkc   :=strToInt(temp2[i]);
                     24: self.CK_UpMz   :=Public_Basic.strTodouble_lu(temp2[i]);
                     25: self.CK_downkc :=strToInt(temp2[i]);
                     26: self.CK_downmz :=Public_Basic.strTodouble_lu(temp2[i]);
                  end;
             end; //endfor
              temp1:=nil;temp2:=nil;
      except
              Result:=False;
              sEorr:='���ݸ�ʽ����/';
              Public_Basic.My_WriteLog('Eorr:Init_GZM_difficult ���ݸ�ʽ����/','[TG_stope]');
              exit;
       end;

         //-------------
         if S_cg_h=0 then    // �жϲ�ú�߶�
           begin
             Result:=False;
             sEorr:=sEorr+'��ú�߶�/';
            end else begin
               if S_cg_h<2 then begin
                    Mc_FdBs:=1.5;
                end else begin
                    Mc_FdBs:=1;
                end;
            end;

        if S_No='' then //�жϹ�������
           begin
             Result:=False;
             sEorr:=sEorr+'��������/';
             end;
         if S_Mc_name='' then //�ж�ú������
           begin
             Result:=False;
             sEorr:=sEorr+'ú��/';
            end;
         if S_cmfs='' then  // �жϲ�ú����
           begin
             Result:=False;
             sEorr:=sEorr+'��ú��ʽ(�۲�/�۷�/�ղ�)/';
           end;
         if S_l_qx=0 then    // �жϹ��������б����
           begin
             Result:=False;
             sEorr:=sEorr+'��б����/';
           end;
         if S_sx_zx=0 then    // �жϹ��������б����
           begin
             Result:=False;
             sEorr:=sEorr+'�ƽ�����/';
           end;
         if S_mcsd_h=0 then    // �жϹ������������
           begin
             Result:=False;
             sEorr:=sEorr+'������!';
           end;
          if S_f_ps=0 then    // �ж�ú�������ϵ��
           begin
             Result:=False;
             sEorr:=sEorr+'����ϵ��!';
           end;
         if Result then 
             self.is_init:=True
   end;
   //---------------------------------------  ��ʼ����������ԭ��d

   function TG_stope.Init_GZM_Simple(str: WideString;out sEorr:Widestring):wordbool;
     var
           temp1,temp2 :Str_Dt_array;
           i,Count1,Count2:integer;
      begin
        Result:=true;

      try
            temp1:=Public_Basic.split(str,':',Count1);

            if UpperCase(temp1[0])<>'GZM' then
             begin
               Result:=False;
               sEorr:='�����汨ͷGZM����!';
               Public_Basic.My_WriteLog('Eorr:Init_GZM_Simple �����汨ͷGZM����!','[TG_stope]');
               exit;
             end;

           temp2:=Public_Basic.split(temp1[1],',',Count2);
           if count2<17 then
               begin
               Result:=False;
               sEorr:='����ϸ����ļ�!';
               Public_Basic.My_WriteLog('Eorr:Init_GZM_Simple count2<17','[TG_stope]');
               exit;
              end;
         for i :=low(temp2) to high(temp2) do
           begin
             if length(temp2[i])=0 then continue;
                  case i of
                     0: S_No  :=Trim(temp2[i]);
                     1: S_Name:=Trim(temp2[i]);
                     2: S_Mc_name :=Trim(temp2[i]);
                     3: S_cg_h  :=Public_Basic.strTodouble_lu(temp2[i]);
                     4: S_cmfs  :=Trim(temp2[i]);
                     5: S_fm_h  :=Public_Basic.strTodouble_lu(temp2[i]);
                     6: S_qj    :=Public_Basic.strTodouble_lu(temp2[i]);
                     7: S_mcsd_h:=Public_Basic.strTodouble_lu(temp2[i]);
                     8: S_l_qx  :=Public_Basic.strTodouble_lu(temp2[i]);
                     9: S_sx_zx :=Public_Basic.strTodouble_lu(temp2[i]);
                     10: S_jc_l :=Public_Basic.strTodouble_lu(temp2[i]);
                     11: S_f_ps :=Public_Basic.strTodouble_lu(temp2[i]);
                     12: S_M_mcj:=Public_Basic.strTodouble_lu(temp2[i]);
                     13: S_M_njl:=Public_Basic.strTodouble_lu(temp2[i]);
                     14: S_Bsb  :=Public_Basic.strTodouble_lu(temp2[i]);
                     15: S_K_zcfz:=Public_Basic.strTodouble_lu(temp2[i]);
                     16: S_Dblb :=Trim(temp2[i]);
                  end;
             end; //endfor
              temp1:=nil;temp2:=nil;
         except
              Result:=False;
              sEorr:='���ݸ�ʽ����/';
              Public_Basic.My_WriteLog('Eorr:Init_GZM_Simple ���ݸ�ʽ����/','[TG_stope]');
              exit;
       end;

         //-------------
         if S_cg_h=0 then    // �жϲ�ú�߶�
           begin
            S_cg_h:=2.5;
            end;
        if S_No='' then //�жϹ�������
           begin
              S_No:='�¹�����';
             end;
         if S_Mc_name='' then //�ж�ú������
           begin
             S_Mc_name:='1';
            end;
         if S_cmfs='' then  // �жϲ�ú����
           begin
             S_cmfs:='2';
           end;
         if S_l_qx=0 then    // �жϹ��������б����
           begin
             S_l_qx:=180;
           end;
         if S_sx_zx=0 then    // �жϹ��������б����
           begin
             S_sx_zx:=1000;
           end;
         if S_mcsd_h=0 then    // �жϹ������������
           begin
             S_mcsd_h:=500;
           end;
          if S_f_ps=0 then    // �ж�ú�������ϵ��
           begin
             S_f_ps:=1.5;
           end;
         if Result then 
             self.is_init:=True ;

         if S_f_PS<1.1 then  begin
             self.S_M_mcj:=20;
             self.S_Bsb:=0.35;
             self.S_M_njl:=10;
             self.S_K_zcfz:=1.7-0.1*(self.S_Cg_h-4);
         end else if S_f_PS<2.1 then  begin
             self.S_M_mcj:=24;
             self.S_Bsb:=0.3;
             self.S_M_njl:=23;
             self.S_K_zcfz:=2.0-0.1*(self.S_Cg_h-4);
         end else if S_f_PS<3.1 then  begin
             self.S_M_mcj:=28;
             self.S_Bsb:=0.25;
             self.S_M_njl:=40;
             self.S_K_zcfz:=2.3-0.1*(self.S_Cg_h-4);
         end else begin
             self.S_M_mcj:=32;
             self.S_Bsb:=0.2;
             self.S_M_njl:=60;
             self.S_K_zcfz:=2.6-0.1*(self.S_Cg_h-4);
         end;
   end;



 //--------��ʼ�������
function Tzk_bore.Init(S_Zk: WideString; out sEorr: WideString):wordbool;
   var
       yc1,yc2,yc3,yc4 :Str_Dt_array;
       i,Count1,Count2,count3,count4:integer;
       Mc_count:integer;
   begin
        Result:=true;
        MC_count:=0;
       try

            yc1:=Public_Basic.split(S_zk,':',Count1);   //��Zk�ı�ʶ��������
            if UpperCase(yc1[0])<>'ZK' then
             begin
               Result:=False;
               sEorr:='��ױ�ͷZK����!';
               Public_Basic.My_WriteLog('Eorr:Init ��ױ�ͷZK����!','[Tzk_bore]');
               exit;
             end;
             //----
             yc2:=Public_Basic.split(yc1[1],';',Count2);   //����׻�����Ϣ���Ҳ���Ϣ������
             yc3:=Public_Basic.split(yc2[0],',',Count3);   //yc3[0]Ϊ��ױ�ţ�yc3[1]Ϊ��׺����Ҳ�Ĳ���

              self.Zk_No:=Public_Basic.StrToInt_lu(yc3[0]);       //  ����ױ�Ÿ�ֵ
              self.Zk_Yc_Count:=Public_Basic.StrToInt_lu(yc3[1]);  //  ���Ҳ����������ֵ
             //--- �˶��Ҳ������Ϣ���ô�����Ϣ��ʵ����ʯ��Ϣ�ȶ�
//              if Count2-1<>zk_yc_count then
//                 begin
//                  Result:=False;
//                  sEorr:='�Ҳ������Ϣ��������ϸ�鿴!';
//                  exit;
//                 end;

            SetLength(self.Yc_Rock ,self.Zk_Yc_Count+2);  //���¶�����׺��е��Ҳ����
              // �����Ҳ㶯̬����
             for i :=0 to Zk_Yc_Count do
             begin
              if Yc_Rock[i]=nil then
                  Yc_Rock[i]:=TYc_rock.Create;
             end;

            for i :=low(yc2)+1 to high(yc2) do
               begin
                  yc4:=Public_Basic.split(yc2[i],',',Count4);   //���Ҳ�Ļ�������������
                  if high(yc4)<6 then   continue;
                  if i>Zk_Yc_Count then   Zk_Yc_Count:=i;
                  if Yc_Rock[i-1]=nil then   Yc_Rock[i-1]:=TYc_rock.Create;
                    self.Yc_Rock[i-1].Yc_No  :=Public_Basic.StrToInt_lu(yc4[0]);
                    self.Yc_Rock[i-1].R_Name :=Trim(StringReplace(yc4[1],#13#10,'',[]));
                    self.Yc_Rock[i-1].R_h    :=Public_Basic.StrTodouble_lu(yc4[2]);
                    self.Yc_Rock[i-1].R_kyqd :=Public_Basic.StrTodouble_lu(yc4[3]);
                    self.Yc_Rock[i-1].R_klqd :=Public_Basic.StrTodouble_lu(yc4[4]);

                    if Public_Basic.strtoint_lu(yc4[6])=0 then  begin
                          self.Yc_Rock[i-1].R_fchd :=Public_Basic.StrTodouble_lu(yc4[2]);  //������ֲ㣬�ֲ���Ϊ���Ҳ�ĺ��
                          self.Yc_Rock[i-1].R_sffc :=false;
                        end  else   begin
                          self.Yc_Rock[i-1].R_fchd :=Public_Basic.StrTodouble_lu(yc4[5]);
                           self.Yc_Rock[i-1].R_sffc:=true;
                        end;
                    if high(yc4)<7 then  continue;
                       self.Yc_Rock[i-1].R_k_Rock :=Public_Basic.StrTodouble_lu(yc4[7]);
                    if high(yc4)<8 then  continue;
                        self.Yc_Rock[i-1].R_r     :=Public_Basic.StrTodouble_lu(yc4[8]);
                    if high(yc4)<9 then  continue;
                    if Public_Basic.strtoint_lu(yc4[9])=0 then
                        begin
                          self.Yc_Rock[i-1].M_Kc_YandN := False;
                        end
                      else
                        begin
                           self.Yc_Rock[i-1].M_Kc_YandN := True;
                           inc(Mc_count);
                           self.main_coal:=i-1;
                        end;

                     //------�����ж�
                       if Yc_Rock[i-1].R_h =0 then    // �ж��Ҳ�ĺ��
                             begin
                                Yc_Rock[i-1].R_h:=2;
                             end;

                      if Yc_Rock[i-1].R_klqd  =0 then    // �ж��Ҳ� ����ǿ��
                             begin
                               Yc_Rock[i-1].R_klqd:=3;
                             end;
                       if Yc_Rock[i-1].R_kyqd =0 then    // �ж��Ҳ� ��ѹǿ��
                             begin
                               Yc_Rock[i-1].R_kyqd:=30;
                             end;
                      if Yc_Rock[i-1].R_r  =0 then    // �ж��Ҳ� ����
                             begin
                               Yc_Rock[i-1].R_r:=2.5;
                             end;
                      
                       //�����Ҳ�Ĳ���
                         self.Yc_Rock[i-1].Step_Rock(Yc_Rock[i-1].R_h,Yc_Rock[i-1].R_klqd ,Yc_Rock[i-1].R_r );
                      
                     yc4:=nil;
               end;   //forѭ������
         except
              Result:=False;
              sEorr:='���ݸ�ʽ��������ϸ�鿴!';
              Public_Basic.My_WriteLog('Eorr:Init ���ݸ�ʽ��������ϸ�鿴!','[Tzk_bore]');
         end;
          //  ������̬����
          for I := 0 to 4 do
            begin

              if  self.beam_def[i] = nil then begin
                   self.Beam_Def[i]:=TYL_beam.Create;
                   self.Beam_Def[i].Start_YC_No:=0;
                   self.Beam_Def[i].End_Yc_NO :=0;
              end;
              if  self.beam_step[i]= nil then begin
                  self.Beam_step[i]:=TYL_beam.Create ;
                  self.Beam_step[i].Start_YC_No :=0;
                  self.Beam_step[i].End_Yc_NO:=0;
              end;
                 
             end;

          self.is_init :=True;   
   end;   //- ������������ǣ�

  //
destructor TZk_bore.Destroy;
 var
  i:integer;
begin
    try
      for I :=0 to Zk_Yc_Count-1 do    FreeAndNil(Yc_Rock[i]); ;
      for I := 0 to 3 do   FreeAndNil(Beam_Def[i]);
      for I := 0 to 3 do   FreeAndNil(Beam_step[i]);
    except
      on e:exception do begin
         Public_Basic.My_WriteLog('Eorr:Destroy'+e.message,'[Tzk_bore]');
      end;

    end;
      inherited Destroy;
end;
//=======�Ҳ㲽�����ģ��
  procedure Tyc_Rock.Step_Rock(h: Double; Rc: Double; r: Double);
  var
    k:integer;
  begin
       if r=0 then
          r:=25 ;
        self.Step0:=sqrt(1000*2*h*rc/r);  // ��һ�β���
         // 1-4 Ϊ4�����ڲ���  0 Ϊ�ȶ�����
         //NextStep(c,i,mc,ms,qs,rs,qj:double):double ;//c ��һ�εĲ��࣬i�ڼ���
          for k := 1 to 4 do
             begin
                if k=1 then   begin
                       step_i[k]:=Public_Basic.NextStep(Step0,0,0,R_h ,R_klqd,R_r,0);
                end  else  begin
                       step_i[k]:=Public_Basic.NextStep(step_i[k-1],k-1,0,R_h ,R_klqd,R_r,0);
                 end;
             end ;
           step_i[0]:=Step0*0.4;
     end;   //  Tyc_Rock.Step_Rock  ��������

 //���������ṹ
function TImmediate_roof.Cal_beam(S_gzm: TG_stope; s_zk: TZk_bore;out sEorr:widestring):wordbool ;
  var
     i,j,k :integer;
     YL_h:double;
     m,q,c_i: array of double;
     mq : double;
begin
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
    for j := 0 to i  do
      begin
        if j=i then
          begin
             m[j]:=Yl_h;
          end
        else
         begin
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
       s_zk.Beam_Def[k].Sdc_mc :=0;
       for j := i-1 downto 0   do
         begin
           if k>3  then break;
           if  mq < 1.15*1.15*1.15*1.15*m[j]*m[j]*q[j] then
               begin
                 s_zk.Beam_Def[k].End_Yc_NO :=j+1;
                 inc(k);
                 s_zk.Beam_Def[k].Sdc_mc :=0;
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
       s_zk.Beam_step[k].Sdc_mc :=0;
       for j := i-1 downto 0   do
         begin
           if k>3  then break;
           if  mq < 1.15 *c_i[j] then
               begin
                 s_zk.Beam_step[k].End_Yc_NO :=j+1;
                 inc(k);
                 s_zk.Beam_step[k].Sdc_mc :=0;
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
                 s_zk.Beam_Def[j].Step_0_Compr:=Public_Basic.Firststep(s_zk.Beam_Def[j].Sdc_mc ,
                               s_zk.Beam_Def[j].Ztc_ms ,s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_klqd,
                               s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_r,s_gzm.S_qj);
                 s_zk.Beam_Def[j].Step_i_Compr[0]:=0.4*s_zk.Beam_Def[j].Step_0_Compr;
                    for k := 1 to 5 do
                       begin
                          if k=1 then
                               begin
                               s_zk.Beam_Def[j].Step_i_Compr[k]:=Public_Basic.NextStep(s_zk.Beam_Def[j].Step_0_Compr,
                                           k-1,s_zk.Beam_Def[j].Sdc_mc ,s_zk.Beam_Def[j].Ztc_ms ,
                                           s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_klqd,
                                           s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_r,s_gzm.S_qj);
                               end
                           else
                                begin
                               s_zk.Beam_Def[j].Step_i_Compr[k]:=Public_Basic.NextStep(s_zk.Beam_Def[j].Step_i_Compr[k-1],k-1,
                                             s_zk.Beam_Def[j].Sdc_mc ,s_zk.Beam_Def[j].Ztc_ms ,
                                             s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_klqd,
                                             s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_r,s_gzm.S_qj);

                           end;
                       end;
                 //�������涯���㷨
                 s_zk.Beam_Def[j].Step_0_Simple:=Public_Basic.Firststep(0 ,s_zk.Beam_Def[j].Ztc_ms ,
                                  s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_klqd,
                                  s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_r,s_gzm.S_qj);
                 s_zk.Beam_Def[j].Step_i_Simple[0]:=0.4*s_zk.Beam_Def[j].Step_0_Simple;
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
                               s_zk.Beam_Def[j].Step_i_Simple[k]:=Public_Basic.NextStep(s_zk.Beam_Def[j].Step_i_Simple[k-1],
                                              k-1,0 ,s_zk.Beam_Def[j].Ztc_ms ,s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_klqd,
                                              s_zk.Yc_Rock[s_zk.Beam_Def[j].Start_YC_No].R_r,s_gzm.S_qj);

                           end;
                       end;
              end;
           //����beam_step�����ĳ�����ѹ����
           if s_zk.Beam_step[j].Ztc_ms >0  then
              begin
                 //�����涯����㷨
                 s_zk.Beam_step[j].Step_0_Compr:=Public_Basic.Firststep(s_zk.Beam_step[j].Sdc_mc ,s_zk.Beam_step[j].Ztc_ms ,
                                 s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_klqd,
                                 s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_r,s_gzm.S_qj);
                 s_zk.Beam_step[j].Step_i_Compr[0]:=0.4*s_zk.Beam_step[j].Step_0_Compr;
                    for k := 1 to 5 do
                       begin
                          if k=1 then
                               begin
                               s_zk.Beam_step[j].Step_i_Compr[k]:=Public_Basic.NextStep(s_zk.Beam_step[j].Step_0_Compr,k-1,
                                                  s_zk.Beam_step[j].Sdc_mc ,s_zk.Beam_step[j].Ztc_ms ,
                                                  s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_klqd,
                                                  s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_r,s_gzm.S_qj);
                               end
                           else
                                begin
                               s_zk.Beam_step[j].Step_i_Compr[k]:=Public_Basic.NextStep(s_zk.Beam_step[j].Step_i_Compr[k-1],k-1,
                                            s_zk.Beam_step[j].Sdc_mc ,s_zk.Beam_step[j].Ztc_ms ,
                                            s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_klqd,
                                            s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_r,s_gzm.S_qj);

                           end;
                       end;
                 //�������涯���㷨
                 s_zk.Beam_step[j].Step_0_Simple:=Public_Basic.Firststep(0 ,s_zk.Beam_step[j].Ztc_ms ,
                                         s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_klqd,
                                         s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_r,s_gzm.S_qj);
                 s_zk.Beam_step[j].step_i_simple[0]:=0.4*s_zk.Beam_step[j].Step_0_Simple;
                    for k := 1 to 5 do
                       begin
                          if k=1 then
                               begin
                               s_zk.Beam_step[j].step_i_simple[k]:=Public_Basic.NextStep(s_zk.Beam_step[j].Step_0_Compr,
                                               k-1,s_zk.Beam_step[j].Sdc_mc ,s_zk.Beam_step[j].Ztc_ms ,
                                               s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_klqd,
                                               s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_r,s_gzm.S_qj);
                               end
                           else
                                begin
                               s_zk.Beam_step[j].step_i_simple[k]:=Public_Basic.NextStep(s_zk.Beam_step[j].Step_i_Compr[k-1],
                                               k-1,s_zk.Beam_step[j].Sdc_mc ,s_zk.Beam_step[j].Ztc_ms ,
                                               s_zk.Yc_Rock[s_zk.Beam_step[j].Start_YC_No].R_klqd,
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
  end;  //   TImmediate_roof.Cal_beam �����ı��
  //����ֱ�Ӷ�
function TImmediate_roof.Cal_Immediate_roof(S_gzm: TG_stope; s_zk: TZk_bore;safe_h:double;out sEorr:widestring) :wordbool;
    //����ֱ�Ӷ�������s_gzm���������   s_zk��׶���  saft_h����ֱ�Ӷ��İ�ȫ����  s����eorr�����ַ���
 var
        i,j:integer;
        SA:double;
        j_count:bool;
 begin
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
         on e:exception do begin
           Result:=False;
           sEorr:='ֱ�Ӷ��������';
           Public_Basic.My_WriteLog('Eorr:.Cal_Immediate_roof_'+e.message,'[TImmediate_roof]');
         end;
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
          // sEorr:='start:'+FloatToStr(self.Start_No)+':end'+ FloatToStr(self.End_No)+':ʣ��'+FloatToStr(self.Surplus_h)+':���'+FloatToStr(self.Immroof_M);
    end; // TImmediate_roof.Cal_Immediate_roof  ��������
  //=================================================================
 //��ʼ����������
function TImmediate_roof.init(s_gzm: TG_stope; s_zk: TZk_bore;safe_h:double;out sEorr:widestring):wordbool ;
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
        //--------------����Ŷ�ú�Ĳ���
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
    end; // TYL_beam.init ��������
  //-��ʼ���϶�����
  function Told_roof.init(s_gzm: TG_stope; s_zk: TZk_bore;t_imm:Timmediate_roof; out sEorr: WideString) :wordbool;
    var
      i,j:integer;
      Dn,N:double ; //Dn :�϶���ѹǿ�ȣ�N ֱ�Ӷ����ϵ��
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
         Dn:=self.YL_First_step[0]-15*N+42.9*s_gzm.S_Cg_h;
         if Dn<=80.5  then begin
             self.Old_leibie :=1;
             s_gzm.Ci_xs:=0.4;
         end else if Dn<=128.4 then begin
             self.Old_leibie :=2;
             s_gzm.Ci_xs:=0.35;
         end else if Dn<=188.3 then begin
             self.Old_leibie :=3;
             s_gzm.Ci_xs:=0.3;
         end else if Dn<=248 then begin
             self.Old_leibie :=4;
             s_gzm.Ci_xs:=0.3;
         end else begin
             self.Old_leibie :=5;
             s_gzm.Ci_xs:=0.288;
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
        self.YL_start :=s_zk.Beam_Def[0].Start_YC_No ;
     for I := 0 to 4 do
         begin
             self.YL_start :=s_zk.Beam_Def[i].Start_YC_No ;
             if s_zk.Beam_Def[i].End_Yc_NO =s_zk.Beam_step[i].End_Yc_NO  then   //����������벽�� �����Ҳ���ͬ
                begin
                   self.YL_max_End := s_zk.Beam_Def[i].End_Yc_NO;
                   self.YL_min_End := s_zk.Beam_Def[i].End_Yc_NO;
                   self.YL_max_m :=self.YL_max_m +s_zk.Beam_Def[i].Ztc_ms+s_zk.Beam_Def[i].Sdc_mc;
                   self.YL_min_m :=self.YL_min_m +s_zk.Beam_Def[i].Ztc_ms+s_zk.Beam_Def[i].Sdc_mc;
                end  else  begin
                     if s_zk.Beam_Def[i].End_Yc_NO < s_zk.Beam_step[i].End_Yc_NO  then    // ������� С�� �벽�� �����Ҳ�
                         begin
                             self.YL_max_End := s_zk.Beam_Def[i].End_Yc_NO;
                             self.YL_min_End := s_zk.Beam_step[i].End_Yc_NO;
                             self.YL_max_m :=self.YL_max_m + s_zk.Beam_Def[i].Ztc_ms+s_zk.Beam_Def[i].Sdc_mc;
                             self.YL_min_m :=self.YL_min_m + s_zk.Beam_step[i].Ztc_ms+s_zk.Beam_step[i].Sdc_mc;
                          end  else  begin                                    // ������� ���� �벽�� �����Ҳ���ͬ
                             self.YL_max_End := s_zk.Beam_step[i].End_Yc_NO;
                             self.YL_min_End := s_zk.Beam_def[i].End_Yc_NO;
                             self.YL_min_m :=self.YL_min_m + s_zk.Beam_Def[i].Ztc_ms+s_zk.Beam_Def[i].Sdc_mc;
                             self.YL_max_m :=self.YL_max_m + s_zk.Beam_step[i].Ztc_ms+s_zk.Beam_step[i].Sdc_mc;
                         end;      //    if s_zk.Beam_Def[0].End_Yc_NO < s_zk.Beam_step[0].End_Yc_NO  then

                end;  //  if s_zk.Beam_Def[0].End_Yc_NO =s_zk.Beam_step[0].End_Yc_NO  then
                 if self.YL_min_m > s_gzm.S_Cg_h then   begin   //�����λ������С�����ܳ�֮Ϊһ�������������������
                       j:=i;
                       break;
                    end;
                 if (YL_max_m+t_imm.Immroof_M)>s_gzm.S_Cg_h*10 then   begin  //�������ĺ���������ж�
                       j:=i;
                       break;
                    end; 


          end; //end for


           // ��λ����������ѹ�������ֵ
           self.YL_First_step[0]:=Public_Basic.select_max(s_zk.Beam_Def[j].Step_0_Compr,s_zk.Beam_Def[j].Step_0_Simple ,
                            s_zk.Beam_step[j].Step_0_Compr ,s_zk.Beam_step[j].Step_0_Simple);
           // ��λ����������ѹ������Сֵ
           self.YL_First_step[1]:=Public_Basic.select_min(s_zk.Beam_Def[j].Step_0_Compr,s_zk.Beam_Def[j].Step_0_Simple ,
                            s_zk.Beam_step[j].Step_0_Compr ,s_zk.Beam_step[j].Step_0_Simple);
           // ��λ����������ѹ����ƽ��ֵ
           self.YL_First_step[2]:=0.25*(s_zk.Beam_Def[j].Step_0_Compr + s_zk.Beam_Def[j].Step_0_Simple +
                                    s_zk.Beam_step[j].Step_0_Compr + s_zk.Beam_step[j].Step_0_Simple);

            // ��λ����������ѹ�������ֵ
           self.YL_Zhouqi_step[0]:=YL_First_step[0] *s_gzm.Ci_xs;
            // ��λ����������ѹ������Сֵ
           self.YL_Zhouqi_step[1]:=self.YL_First_step[1]*s_gzm.Ci_xs;
            // ��λ����������ѹ����ƽ��ֵ
           self.YL_Zhouqi_step[2]:=self.YL_First_step[2]*s_gzm.Ci_xs;

          //�ж��϶������Ľṹ
          if self.YL_max_m >10  then
              begin
                  self.YL_struc :=1;
              end
            else
              begin
                   if j>0 then
                     begin
                        self.YL_struc :=1;
                     end
                    else
                    begin
                      self.YL_struc :=2;
                    end;
              end;   //end if

       { //�жϵװ������ ���װ��������  1�� ��7.22   2��7.22��10.80  3��  10.80��15.21
        //4��   15.21��22.84   5��  22.84��41.79      6�� ��41.79
        //ͨ���װ�Ŀ�ѹǿ���ж� }
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
       
   end; //   Told_roof.init ��������
  //====================
   //����ֱ�Ӷ��Ļ�������
  function TImmediate_roof.Get_Parameter(zk:Tzk_bore;Version:widestring) :WideString;
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
       S_out:=S_out+' ֱ�Ӷ����ϲ��Ҳ���'+':';
           S_out:=S_out+IntToStr(zk.Yc_Rock[self.End_No].Yc_No )+';';
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
  //======================
    //�����Ҳ��˶��������ͼƬ
  function TImmediate_roof.Get_YC_Png(zk:Tzk_bore;s_gzm: TG_stope;t_imm:Timmediate_roof;JinChi:double):wideString;  stdcall;
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
  //======================

  //�����Ҳ�ĳ�����ѹ����
function Told_roof.Return_C0(zk:Tzk_bore):wideString;  stdcall;
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

       // Cal_Ldg(zk:Tzk_bore;gzm:TG_stope;imm:TImmediate_roof;gzmjc:double;out S_ldg:widestring):wordbool
        Cal_Ldg(zk,s_gzm,t_imm,self,gzmjc,S_out);
        S_out:='';
        if Version='1.0' then begin ////�����ѶϹ��ı߽�
              for I :=0  to zk.main_coal-1 do
               begin

                   S_out:=S_out+IntToStr(zk.Yc_Rock[i].Yc_No)+','+ FormatFloat('0.00',zk.Yc_Rock[i].L_qx_xiashan )+',';
                   S_out:=S_out+ FormatFloat('0.00',zk.Yc_Rock[i].L_qx_shangshan )+',';
                   S_out:=S_out+ FormatFloat('0.00',zk.Yc_Rock[i].L_Tj )+';';

                end;//enf for
               Result:=S_out;
        end else if Version='2.0' then  begin
               S_out:=FormatFloat('0.00',s_gzm.Hg_ldg );
               Result:=S_out;
        end;
    end;
  //�����϶��Ļ�������
 function Told_roof.Get_Parameter(s_gzm: TG_stope; zk: TZk_bore;t_imm:Timmediate_roof;Version:widestring):wideString;
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
                 S_out:=S_out+  #13+'   �����н���:  ';


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
  end; //�϶�����ģ��
  //====================================
  //����֧��ѹ������
 function Cal_Zcyl(zk:Tzk_bore;imm:TImmediate_roof;gzm:TG_stope;old_r :Told_roof;out S_ZCYl:WideString):wordbool;
  var
    Zcyl_s1: double;//����֧��ѹ���ĵķ�ֵ����ú�ڵľ���
    ZCyl_s0 :double;// ��Ӧ�����ľ���
    Mbcsnl_l:double;//ú��ɥʧ֧�������ľ���
  begin
     if not gzm.is_init or not imm.is_init or not zk.is_init then
       begin
         Result:=False;
         Exit;
       end;
     mbcsnl_l:=2*zk.Yc_Rock[zk.main_coal].R_kyqd*1000/(gzm.S_mcsd_h *zk.Yc_Rock[imm.Start_No].R_r);
      if imm.Immroof_M=0 then    begin
           mbcsnl_l:=mbcsnl_l/gzm.S_Cg_h;
      end else begin
           mbcsnl_l:=mbcsnl_l/(imm.Immroof_M* zk.Yc_Rock[imm.Start_No].R_r )/gzm.S_Cg_h;
      end;
     if mbcsnl_l<5  then   mbcsnl_l:=5;
     if mbcsnl_l>imm.Immroof_C0 then  mbcsnl_l:= imm.Immroof_C0;
     
     gzm.mbcsnl_l:=mbcsnl_l;
     //0  ֵ ��ֵ
     if gzm.S_M_mcj=0 then    gzm.S_M_mcj:=25;
     if gzm.S_M_njl=0 then    gzm.S_M_njl:=4000;
     if gzm.S_mcsd_h=0 then   gzm.S_mcsd_h:=500;
     if gzm.S_K_zcfz=0  then  gzm.S_K_zcfz:=2.5;
     
     zcyl_s1:=gzm.S_Cg_h*gzm.S_Bsb/2/tan(gzm.S_M_mcj/180*3.14159)/(1-gzm.S_Bsb ) *2;
     zcyl_s1:=zcyl_s1*ln(gzm.S_K_zcfz*gzm.S_mcsd_h*tan(gzm.S_M_mcj/180*3.14159)* 2.5 *10/gzm.S_M_njl +1);

     zcyl_s0:=sqrt(old_r.YL_First_step[2]*0.3*0.5*gzm.S_L_qx*zcyl_s1/gzm.S_K_zcfz/gzm.S_mcsd_h);



     //�жϸ�ֵ  20140103

                     //ͨ��ú�����޶�����
                if  zcyl_s1<3 then   begin
                    if gzm.S_Cg_h>3 then begin
                       gzm.ZCYL_s1[2]:=zcyl_s1*3;    //ͨ��ú�����޶�����
                    end else begin
                       gzm.ZCYL_s1[2]:=zcyl_s1*gzm.S_Cg_h;
                    end;
                end else begin
                       gzm.ZCYL_s1[2]:=zcyl_s1;
                end;
              if zcyl_s0>gzm.ZCYL_s1[2] then  zcyl_s0:= gzm.ZCYL_s1[2]*0.4;

              if  ZCYL_s0<1 then  begin
                     if gzm.S_Cg_h>3 then begin
                       gzm.ZCYL_s0 := zcyl_s0*3;    //ͨ��ú�����޶�����
                    end else begin
                       gzm.ZCYL_s0 := zcyl_s0*gzm.S_Cg_h;
                    end;
                end else begin
                    gzm.ZCYL_s0 := zcyl_s0;
                end;


     if zcyl_s1<1.5 then  zcyl_s1:=1.5;//ǿ����Сֵ
     if zcyl_s0<1 then  zcyl_s0:=1; //ǿ����Сֵ
     if zcyl_s1<zcyl_s0 then  zcyl_s1:=2*zcyl_s0; //  //ǿ����Сֵ

          gzm.ZCYL_s1[0]:=gzm.ZCYL_s1[2]*1.2;
          gzm.ZCYL_s1[1]:=gzm.ZCYL_s1[2]*(1+sin(gzm.S_qj/180*3.14159));
          gzm.ZCYL_s1[2]:=gzm.ZCYL_s1[2];
          gzm.ZCYL_s1[3]:=gzm.ZCYL_s1[2]*(1-sin(gzm.S_qj/180*3.14159));

         if gzm.S_f_PS <2  then
            begin
                gzm.ZCYL_sx[0]:= gzm.ZCYL_s1[0]*5;
                gzm.ZCYL_sx[1]:= gzm.ZCYL_s1[1]*5;
                gzm.ZCYL_sx[2]:= gzm.ZCYL_s1[2]*5;
                gzm.ZCYL_sx[3]:= gzm.ZCYL_s1[3]*5;
            end
          else
            begin
                gzm.ZCYL_sx[0]:= gzm.ZCYL_s1[0]*4;
                gzm.ZCYL_sx[1]:= gzm.ZCYL_s1[1]*4;
                gzm.ZCYL_sx[2]:= gzm.ZCYL_s1[2]*4;
                gzm.ZCYL_sx[3]:= gzm.ZCYL_s1[3]*4;
            end;


       Result:=true;

  end; //����֧��ѹ�������ĺ���



 // ���ز�ú�������֧��ѹ��
function TG_stope.Return_Zcyl(Version:WideString;JinChi:Double;zk:Tzk_bore):Widestring;//���ز�ú�������֧��ѹ��
  var
    Str_temp:WideString;
    Str_s1_2:double;
    K1,K2 :double; //����Ӧ������ֵ ��С
    s0,s1 :double; // ����Ӧ������Χ
    JinC_sul:double;//ʣ����ߵı���
  begin
      Str_temp:='';
    //��ʼ����ú��ɥʧ֧�������ľ���
      if JinChi<5 then JinChi:=5;

      if JinChi < self.mbcsnl_l  then  begin
          K1:=0;
          if self.S_f_PS>1.5 then   begin     //ͨ��ú��Ӳ�����ж�֧�ŷ�ֵ
               K2:= 1+ sqrt(JinChi/40/3);  //��Ӧ�����ķ�ֵ    úӲ ֧�ŷ�ֵ��60������
          end else if self.S_f_PS>1 then begin
               K2:= 1+ sqrt(JinChi/50/3);  //��Ӧ�����ķ�ֵ   ú�е� ֧�ŷ�ֵ��100������
          end else begin
               K2:= 1+ sqrt(JinChi/60/3);  //��Ӧ�����ķ�ֵ   ú�� ֧�ŷ�ֵ��120������
          end;

          if K2<1.05 then k2:=1.05;

          if Version='1.0' then begin

                 Str_temp:='0;'+FormatFloat('0.00',K2)+';'; // k1,k2
                 Str_temp:=Str_temp+'0,0,0,0;' ; //S0 ���ĸ���
                 Str_temp:=Str_temp+'0,0,0,0;' ; //S1 ���ĸ���
                 Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0]* JinChi/self.S_L_qx)+','; //Sx ���ĸ���   �����۴�
                 Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[1]* JinChi/self.S_L_qx)+','; //Sx ���ĸ���   ��˳�۴�
                 Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[2]* JinChi/self.S_L_qx)+','; //Sx ���ĸ���   ������ǰ����
                 Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[3]* JinChi/self.S_L_qx)+';'; //Sx ���ĸ���   ��˳�۴�
                 Result:=Str_temp;
            end else if Version='2.0' then  begin     //�����ۺ�����
                 Str_temp:='0;0;'+FormatFloat('0.00',K2)+';0;';    //k1,S0,K2,s1,
                 Str_temp:=Str_temp+FormatFloat('0.0',(k2-1)*40)+';';  //sx
                 Result:=Str_temp;
            end;   //end if Version='1.0' then begin

      end else begin
           if Jinchi<=self.S_L_qx  then   begin      //һ�μ���֮��
               // K1:=0.8*Jinchi/self.S_L_qx;     // ��Ӧ������ֵ��С
                K1:=0.8;
                s0:=self.ZCYL_s0*(JinChi-self.mbcsnl_l)/self.S_L_qx;      // ��Ӧ������Χ
                if self.S_f_PS>1.5 then   begin     //ͨ��ú��Ӳ�����ж�֧�ŷ�ֵ
                     K2:= 1+ sqrt(JinChi/40/3);  //��Ӧ�����ķ�ֵ    úӲ ֧�ŷ�ֵ��60������
                end else if self.S_f_PS>1 then begin
                     K2:= 1+ sqrt(JinChi/50/3);  //��Ӧ�����ķ�ֵ   ú�е� ֧�ŷ�ֵ��100������
                end else begin
                     K2:= 1+ sqrt(JinChi/60/3);  //��Ӧ�����ķ�ֵ   ú�� ֧�ŷ�ֵ��120������
                end;
                S1:=self.ZCYL_s1[2]* JinChi/self.S_L_qx;      // ��Ӧ������Χ
                if S1<S0 then  s1:=2*S0;
                
                  if K2>2.5 then  K2:=2.5;   //���ֵǿ��
                  if Version='1.0' then begin
                       Str_s1_2:=0;
                       Str_temp:=FormatFloat('0.00',K1)+';';   // k1
                       Str_temp:=Str_temp+FormatFloat('0.00',K2)+';'; // k2
                       Str_temp:=Str_temp+FormatFloat('0.0',s0)+','; // so �����ۺ�
                       Str_temp:=Str_temp+FormatFloat('0.0',s0*(1+sin(self.S_qj/180*3.14159)))+','; // so  ��˳�۴�
                       //�жϳ�����ѹ����
                       if JinChi<zk.Yc_Rock[zk.main_coal-1].Step0-s0 then begin
                            Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                            Str_s1_2:=s0+s1;  // s1 ������ǰ����
                        end else if JinChi<=zk.Yc_Rock[zk.main_coal-1].Step0 then begin
                            Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                            Str_s1_2:=s0+s1-(JinChi-zk.Yc_Rock[zk.main_coal-1].Step0 );  // s1 ������ǰ����
                       end;  //end   if JinChi<zk.Yc_Rock[zk.main_coal-1].Step0-s0 then begin

                      JinC_sul:=JinChi-zk.Yc_Rock[zk.main_coal-1].Step0;

                       while JinC_sul>0 do   begin
                                if JinC_sul<zk.Yc_Rock[zk.main_coal-1].Step0*0.3-s0 then begin
                                      Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                                      Str_s1_2:=s0+s1;  // s1 ������ǰ����
                                   end else if JinC_sul<=zk.Yc_Rock[zk.main_coal-1].Step0*0.3 then begin
                                      Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                                      Str_s1_2:=s0+s1-(JinC_sul-zk.Yc_Rock[zk.main_coal-1].Step0*0.3 );  // s1 ������ǰ����

                                 end;  //end  if JinC_sul<zk.Yc_Rock[zk.main_coal-1].Step0*0.3-s0 then begin
                                 JinC_sul:=JinC_sul-zk.Yc_Rock[zk.main_coal-1].Step0*0.3;

                       end;  //end while do

                       Str_temp:=Str_temp+FormatFloat('0.0',s0*(1-sin(self.S_qj/180*3.14159)))+';'; // s0  ��˳�۴�

                       Str_temp:=Str_temp+FormatFloat('0.0',s1)+','; // s1 �����ۺ�
                       Str_temp:=Str_temp+FormatFloat('0.0',s1*(1+sin(self.S_qj/180*3.14159)))+','; // s1  ��˳�۴�
                       Str_temp:=Str_temp+FormatFloat('0.0',Str_s1_2)+','; // s1  s1 ������ǰ����
                       Str_temp:=Str_temp+FormatFloat('0.0',s1*(1-sin(self.S_qj/180*3.14159)))+';'; // s1  ��˳�۴�


                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0]* JinChi/self.S_L_qx)+','; //Sx ���ĸ���   �����۴�
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[1]* JinChi/self.S_L_qx)+','; //Sx ���ĸ���   ��˳�۴�
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[2]* JinChi/self.S_L_qx)+','; //Sx ���ĸ���   ������ǰ����
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[3]* JinChi/self.S_L_qx)+';'; //Sx ���ĸ���   ��˳�۴�
                       Result:=Str_temp;
                  end else if Version='2.0' then  begin     //�����ۺ�����
                       Str_temp:=FormatFloat('0.00',K1)+';';    //k1
                       Str_temp:=Str_temp+FormatFloat('0.0',s0)+';';  //s0
                       Str_temp:=Str_temp+FormatFloat('0.00',k2)+';';  //s0
                       Str_temp:=Str_temp+FormatFloat('0.0',s1)+';';  //s1
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0]* JinChi/self.S_L_qx)+';';  //sx
                       Result:=Str_temp;
                  end;   //end if Version='1.0' then begin

           end else if Jinchi<=self.S_L_qx*2  then begin     //һ�μ���֮����μ���֮��
                K1:=0.8;     // ��Ӧ������ֵ��С
                s0:=self.ZCYL_s0;      // ��Ӧ������Χ
                if self.S_f_PS>1.5 then   begin     //ͨ��ú��Ӳ�����ж�֧�ŷ�ֵ
                     K2:= 1+ sqrt(JinChi/40/3);  //��Ӧ�����ķ�ֵ    úӲ ֧�ŷ�ֵ��60������
                end else if self.S_f_PS>1 then begin
                     K2:= 1+ sqrt(JinChi/50/3);  //��Ӧ�����ķ�ֵ   ú�е� ֧�ŷ�ֵ��100������
                end else begin
                     K2:= 1+ sqrt(JinChi/60/3);  //��Ӧ�����ķ�ֵ   ú�� ֧�ŷ�ֵ��120������
                end;

                S1:=self.ZCYL_s1[2];      // ��Ӧ������Χ
                if K2>2.5 then  K2:=2.5;   //���ֵǿ��
                if Version='1.0' then begin
                       Str_s1_2:=0;
                       Str_temp:=FormatFloat('0.00',K1)+';';   // k1
                       Str_temp:=Str_temp+FormatFloat('0.00',K2)+';'; // k2
                       Str_temp:=Str_temp+FormatFloat('0.0',s0)+','; // so �����ۺ�
                       Str_temp:=Str_temp+FormatFloat('0.0',s0*(1+0.5*(Jinchi-self.S_L_qx)/self.S_L_qx)*(1+sin(self.S_qj/180*3.14159)))+','; // so  ��˳�۴�
                       //�жϳ�����ѹ����
                       if JinChi<zk.Yc_Rock[zk.main_coal-1].Step0-s0 then begin
                            Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                            Str_s1_2:=s0+s1;  // s1 ������ǰ����
                        end else if JinChi<=zk.Yc_Rock[zk.main_coal-1].Step0 then begin
                            Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                            Str_s1_2:=s0+s1-(JinChi-zk.Yc_Rock[zk.main_coal-1].Step0 );  // s1 ������ǰ����
                       end;  //end   if JinChi<zk.Yc_Rock[zk.main_coal-1].Step0-s0 then begin

                      JinC_sul:=JinChi-zk.Yc_Rock[zk.main_coal-1].Step0;
                       while JinC_sul>0 do   begin
                                if JinC_sul<zk.Yc_Rock[zk.main_coal-1].Step0*0.3-s0 then begin
                                      Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                                      Str_s1_2:=s0+s1;  // s1 ������ǰ����
                                   end else if JinC_sul<=zk.Yc_Rock[zk.main_coal-1].Step0*0.3 then begin
                                      Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                                      Str_s1_2:=s0+s1-(JinC_sul-zk.Yc_Rock[zk.main_coal-1].Step0*0.3 );  // s1 ������ǰ����

                                 end;  //end  if JinC_sul<zk.Yc_Rock[zk.main_coal-1].Step0*0.3-s0 then begin
                                 JinC_sul:=JinC_sul-zk.Yc_Rock[zk.main_coal-1].Step0*0.3;

                       end;  //end while do

                       Str_temp:=Str_temp+FormatFloat('0.0',s0*(1+0.5*(Jinchi-self.S_L_qx)/self.S_L_qx)*(1-sin(self.S_qj/180*3.14159)))+';'; // s0  ��˳�۴�

                       Str_temp:=Str_temp+FormatFloat('0.0',s1)+','; // s1 �����ۺ�
                       Str_temp:=Str_temp+FormatFloat('0.0',s1*(1+0.5*(Jinchi-self.S_L_qx)/self.S_L_qx)*(1+sin(self.S_qj/180*3.14159)))+','; // s1  ��˳�۴�
                       Str_temp:=Str_temp+FormatFloat('0.0',Str_s1_2)+','; // s1  s1 ������ǰ����
                       Str_temp:=Str_temp+FormatFloat('0.0',s1*(1+0.5*(Jinchi-self.S_L_qx)/self.S_L_qx)*(1-sin(self.S_qj/180*3.14159)))+';'; // s1  ��˳�۴�


                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0])+','; //Sx ���ĸ���   �����۴�
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[1]*(1+0.5*(Jinchi-self.S_L_qx)/self.S_L_qx))+','; //Sx ���ĸ���   ��˳�۴�
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[2])+','; //Sx ���ĸ���   ������ǰ����
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[3]*(1+0.5*(Jinchi-self.S_L_qx)/self.S_L_qx))+';'; //Sx ���ĸ���   ��˳�۴�
                       Result:=Str_temp;
                 end else if Version='2.0' then  begin     //�����ۺ�����
                       Str_temp:=FormatFloat('0.00',K1)+';';    //k1
                       Str_temp:=Str_temp+FormatFloat('0.0',s0)+';';  //s0
                       Str_temp:=Str_temp+FormatFloat('0.00',k2)+';';  //s0
                       Str_temp:=Str_temp+FormatFloat('0.0',s1)+';';  //s0
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0])+';';  //sx
                       Result:=Str_temp;
                 end;   //end if Version='1.0' then begin
           end else begin
                  K1:=0.8;     // ��Ӧ������ֵ��С
                s0:=self.ZCYL_s0;      // ��Ӧ������Χ
                K2:= 1+ JinChi*JinChi*0.5*0.5/self.S_mcsd_h;  //��Ӧ�����ķ�ֵ
                S1:=self.ZCYL_s1[2];      // ��Ӧ������Χ
                if K2>2.5 then  K2:=2.5;   //���ֵǿ��
                if Version='1.0' then begin
                       Str_s1_2:=0;
                       Str_temp:=FormatFloat('0.0',K1)+';';   // k1
                       Str_temp:=Str_temp+FormatFloat('0.00',K2)+';'; // k2
                       Str_temp:=Str_temp+FormatFloat('0.0',s0)+','; // so �����ۺ�
                       Str_temp:=Str_temp+FormatFloat('0.0',s0*(1.5)*(1+sin(self.S_qj/180*3.14159)))+','; // so  ��˳�۴�
                       //�жϳ�����ѹ����
                       if JinChi<zk.Yc_Rock[zk.main_coal-1].Step0-s0 then begin
                            Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                            Str_s1_2:=s0+s1;  // s1 ������ǰ����
                        end else if JinChi<=zk.Yc_Rock[zk.main_coal-1].Step0 then begin
                            Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                            Str_s1_2:=s0+s1-(JinChi-zk.Yc_Rock[zk.main_coal-1].Step0 );  // s1 ������ǰ����
                       end;  //end   if JinChi<zk.Yc_Rock[zk.main_coal-1].Step0-s0 then begin

                      JinC_sul:=JinChi-zk.Yc_Rock[zk.main_coal-1].Step0;
                       while JinC_sul>0 do   begin
                                if JinC_sul<zk.Yc_Rock[zk.main_coal-1].Step0*0.3-s0 then begin
                                      Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                                      Str_s1_2:=s0+s1;  // s1 ������ǰ����
                                   end else if JinC_sul<=zk.Yc_Rock[zk.main_coal-1].Step0*0.3 then begin
                                      Str_temp:=Str_temp+'0,'; // s0  ������ǰ����
                                      Str_s1_2:=s0+s1-(JinC_sul-zk.Yc_Rock[zk.main_coal-1].Step0*0.3 );  // s1 ������ǰ����

                                 end;  //end  if JinC_sul<zk.Yc_Rock[zk.main_coal-1].Step0*0.3-s0 then begin
                                 JinC_sul:=JinC_sul-zk.Yc_Rock[zk.main_coal-1].Step0*0.3;
                                 
                       end;  //end while do

                       Str_temp:=Str_temp+FormatFloat('0.0',s0*(1.5)*(1-sin(self.S_qj/180*3.14159)))+';'; // s0  ��˳�۴�

                       Str_temp:=Str_temp+FormatFloat('0.0',s1)+','; // s1 �����ۺ�
                       Str_temp:=Str_temp+FormatFloat('0.0',s1*(1.5)*(1+sin(self.S_qj/180*3.14159)))+','; // s1  ��˳�۴�
                       Str_temp:=Str_temp+FormatFloat('0.0',Str_s1_2)+','; // s1  s1 ������ǰ����
                       Str_temp:=Str_temp+FormatFloat('0.0',s1*(1.5)*(1-sin(self.S_qj/180*3.14159)))+';'; // s1  ��˳�۴�


                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0])+','; //Sx ���ĸ���   �����۴�
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[1]*1.5)+','; //Sx ���ĸ���   ��˳�۴�
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[2])+','; //Sx ���ĸ���   ������ǰ����
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[3]*1.5)+';'; //Sx ���ĸ���   ��˳�۴�
                       Result:=Str_temp;
                 end else if Version='2.0' then  begin     //�����ۺ�����
                       Str_temp:=FormatFloat('0.0',K1)+';';    //k1
                       Str_temp:=Str_temp+FormatFloat('0.0',s0)+';';  //s0
                       Str_temp:=Str_temp+FormatFloat('0.0',k2)+';';  //s0
                       Str_temp:=Str_temp+FormatFloat('0.0',s1)+';';  //s0
                       Str_temp:=Str_temp+FormatFloat('0.0',self.ZCYL_sx[0])+';';  //sx
                       Result:=Str_temp;
                 end;   //end if Version='1.0' then begin
           end; // end   if Jinchi<=self.S_L_qx
      end;  //end   if gzm.S_Jc_L > mbcsnl_l then  begin  
 end;



 // �����ѶϹ��ı߽�
function Cal_Ldg(zk:Tzk_bore;gzm:TG_stope;imm:TImmediate_roof;old_r:Told_roof;gzmjc:double;out S_ldg:widestring):wordbool;
  var
    i:integer;
    a0,ai,C,b1,a_t: double; //֧��ѹ��ƽ�⹰���ھ��һ��
    cyxs: double;//��ѹϵ��
    hg  : double;//�ѶϹ��ĸ߶�
    f   :double;//����ϵ��
    K   :double;//��ȫϵ��
    s0  :double;//֧��ѹ����ֵ
    TemP:double;//��ʱ����
    nsj:double; //���������� �Ƕ�
  begin
     try
      if not gzm.is_init or  not zk.is_init then
       begin
         Result:=False;
         Exit;
       end;
         K:=2.5;    //��ȫϵ��
        // nsj:=25;   // �Ҳ������ĽǶ�Ϊ25��
        if gzmjc>gzm.S_L_qx then  begin
             s0:=gzm.ZCYL_s0;
             ai:=s0+gzm.S_L_qx/2;
        end else  if gzmjc> gzm.mbcsnl_l then begin
             s0:=gzm.ZCYL_s0*(gzmjc/gzm.S_L_qx);;
             ai:=s0+gzmjc/2;
        end else begin
             s0:=0;
             ai:=s0+gzmjc/2;
        end;
            a0:=gzm.S_L_qx;
            hg:=0;   //�ѶϹ��߸���ֵ
       //��ʼ������ֵ
           for I := zk.main_coal-1 downto 0 do
             begin
                  zk.Yc_Rock[i].L_qx_xiashan:=-100;
                   zk.Yc_Rock[i].L_qx_shangshan :=-100;
                   zk.Yc_Rock[i].L_Tj:=-100;
             end;
     //TemP:= K*gzm.S_L_qx*cos(gzm.S_qj/180*3.1415926)*cos(gzm.S_qj/180*3.1415926);
     //        Trmp:=TemP/(2*cos(gzm.S_qj/180*3.1415926)*k-2*f*sin(gzm.S_qj/180*3.1415926));

       for I := zk.main_coal-1 downto 0 do
         begin
         if i>=imm.End_No  then  begin
                 ai:=ai;
                 hg:=hg+zk.Yc_Rock[i].R_h;
          end else begin
               //ǿ���˳�����
              if ai*2<zk.Yc_Rock[i].Step0 then begin
                old_r.yl_max_End:=i;
                break;
              end;
              hg:=hg+zk.Yc_Rock[i].R_h;
              if (zk.Yc_Rock[i].R_kyqd <0.5) then begin
                 f:=0.1;
              end else begin
                 f:= zk.Yc_Rock[i].R_kyqd/10;
              end;
                 nsj:=16+3*f;
                 TemP:= K*a0*cos(gzm.S_qj/180*3.1415926)*cos(gzm.S_qj/180*3.1415926);
                 Temp:=TemP/(2*cos(gzm.S_qj/180*3.1415926)*k-2*f*sin(gzm.S_qj/180*3.1415926));

              b1:=k*ai/2/f;

             if b1<zk.Yc_Rock[i].R_h then  begin
                  ai:=0;
                end else  begin
                  a_t:=sqrt(f*ai*(b1-zk.Yc_Rock[i].R_h) );

                  if a_t<ai then
                        if zk.Yc_Rock[i].R_h*tan(nsj/180*3.14159)<ai-a_t then  begin
                           ai:=ai-zk.Yc_Rock[i].R_h*tan(nsj/180*3.14159);
                        end else begin
                           ai:=a_t;
                        end;

                end;  //end if  b1<zk.Yc_Rock[i].R_h
          end; //end if    i<imm.End_No
              //�ּ��ж��Ҳ��������

             if gzmjc>gzm.S_L_qx  then  begin
                   zk.Yc_Rock[i].L_qx_xiashan:=gzm.S_L_qx/2-ai/cos(gzm.S_qj/180*3.1415926)+s0;
                   zk.Yc_Rock[i].L_qx_shangshan :=gzm.S_L_qx/2-ai*(1+ sin(gzm.S_qj/180*3.14159))+s0;
                   zk.Yc_Rock[i].L_Tj:=gzm.S_L_qx/2+s0-ai;
             end else begin
                   zk.Yc_Rock[i].L_qx_xiashan:=gzmjc/2-ai*(1-sin(gzm.S_qj/180*3.14159))+s0;
                   zk.Yc_Rock[i].L_qx_shangshan :=gzmjc/2-ai*(1+ sin(gzm.S_qj/180*3.14159))+s0;
                   zk.Yc_Rock[i].L_Tj:=gzmjc/2+s0-ai;  

             end;


          end;//enf for
             //�ѹ��߸��蹤�������
             gzm.Hg_ldg :=hg;
             zk.Zk_ldg_end_no:=i+1;
             S_ldg:=FormatFloat('0.0',hg)+';';

             Result:=true;
          // �ж������������
             for I := zk.main_coal-1 downto 0 do
               begin
                    zk.Yc_Rock[i].PNG_Change :=0;
               end;

            for I := zk.main_coal-1 downto 0 do
             begin
                     if i> imm.End_No then  begin
                          if gzmjc <gzm.S_L_qx  then
                            begin
                               if (gzmjc-2*zk.Yc_Rock[i].L_Tj)<zk.Yc_Rock[i].Step0  then
                                  begin
                                      break;
                                  end else begin
                                      zk.Yc_Rock[i].PNG_Change :=1;
                                  end;

                            end else begin
                               zk.Yc_Rock[i].PNG_Change :=1;
                            end;
                     end else begin
                         break;
                     end;

             end;


          //--------����Ҫ�Ķ�������
           for I := 0  to zk.Zk_Yc_Count  do
             begin
               S_ldg:=S_ldg+IntToStr(zk.Yc_Rock[i].Yc_No)+',';
               S_ldg:=S_ldg+(zk.Yc_Rock[i].R_Name)+',';
               S_ldg:=S_ldg+FormatFloat('0.0',zk.Yc_Rock[i].R_h)+',';
               S_ldg:=S_ldg+FormatFloat('0.0',zk.Yc_Rock[i].L_qx_xiashan )+',';
               S_ldg:=S_ldg+FormatFloat('0.0',zk.Yc_Rock[i].L_qx_shangshan)+',';
               S_ldg:=S_ldg+FormatFloat('0.0',zk.Yc_Rock[i].L_Tj )+';';

             end;
     except
        Result:=False;
     end;  //end try

  end;
  //�����˶����ɵ���
  function Return_Fyyd(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString;
   var
     S_Ret,S_ldg:WideString;
     i:integer;
  begin
     //��������Ϣ
      Cal_Ldg(Zk,gzm,imm,old,gzm.S_Jc_L,S_ldg);
      S_Ret:=S_Ret+'Gzm:';
      S_Ret:=S_Ret+gzm.S_Name+',';
  //    S_Ret:=S_Ret+gzm.S_Cg_h+';';
     // ��׻�����Ϣ
      S_Ret:=S_Ret+'zk:';
      S_Ret:=S_Ret+zk.Zk_name +',';
      S_Ret:=S_Ret+IntToStr(zk.Zk_Yc_Count) +',';
      S_Ret:=S_Ret+InttoStr(zk.main_coal) +'*';
      for I := 0 to zk.Zk_Yc_Count -1 do
        begin
           S_Ret:=S_Ret+InTtoStr(zk.Yc_Rock[i].Yc_No )+',';
           S_Ret:=S_Ret+zk.Yc_Rock[i].R_Name+',' ;
           S_Ret:=S_Ret+FormatFloat('0.0',zk.Yc_Rock[i].R_h )+',';
           S_Ret:=S_Ret+FormatFloat('0.0',zk.Yc_Rock[i].R_kyqd )+',';
           S_Ret:=S_Ret+FormatFloat('0.0',zk.Yc_Rock[i].R_klqd )+',';
           S_Ret:=S_Ret+FormatFloat('0.0',zk.Yc_Rock[i].R_r )+',';
           S_Ret:=S_Ret+FormatFloat('0.0',zk.Yc_Rock[i].Step0 )+',';
           S_Ret:=S_Ret+FormatFloat('0.0',zk.Yc_Rock[i].L_qx_xiashan  )+',';
           S_Ret:=S_Ret+FormatFloat('0.0',zk.Yc_Rock[i].L_qx_shangshan  )+',';
           S_Ret:=S_Ret+FormatFloat('0.0',zk.Yc_Rock[i].L_Tj  )+'*';
        end;
      S_Ret:=S_Ret+';';
      S_Ret:=S_Ret+'YL:';
    {  for I := 0 to 4 do
         begin
          if zk.Beam_Def[0]. then
          
         end;
     }


    Result:=S_Ret;


  end;
  // ����ÿ���Ҳ�ĳ���ֵ
  function Tzk_bore.ReturnSa(zk:TZk_bore): WideString;
  var
     S_Out:WideString;
     i,j:integer;
     Sa_temp: array [0..2] of double;
  begin
      S_out:='';
      for j := 0 to 2 do
           Sa_temp[j]:=zk.Yc_Rock[zk.Zk_ldg_end_no].Sa[j];

      for I :=0  to zk.main_coal do
       begin
           if i<zk.Zk_ldg_end_no then
             begin
                S_out:=S_out+IntToStr(zk.Yc_Rock[i].Yc_No)+',' ;
                S_out:=S_out+FormatFloat('0.0',Sa_temp[0]*0.5 )+',';
                S_out:=S_out+FormatFloat('0.0',Sa_temp[1]*0.5 )+',';
                S_out:=S_out+FormatFloat('0.0',Sa_temp[2]*0.5 )+';';
             end else begin
                S_out:=S_out+IntToStr(zk.Yc_Rock[i].Yc_No)+',' ;
                S_out:=S_out+FormatFloat('0.0',zk.Yc_Rock[i].Sa[0])+',';
                S_out:=S_out+FormatFloat('0.0',zk.Yc_Rock[i].Sa[1] )+',';
                S_out:=S_out+FormatFloat('0.0',zk.Yc_Rock[i].Sa[2])+';';
             end;

       end;
       Result:=S_out;

  end;
function TZk_bore.Return_ZkCs: widestring;
Var
  EStr:WideString;
  i:integer;
begin
   EStr:='';
   for I := 0 to Zk_Yc_Count-1 do
       EStr:= EStr+IntToStr(Yc_Rock[i].Yc_No)+','
             + FormatFloat('0.00',Yc_Rock[i].R_klqd)+';';
   Result:=EStr;
end;

//���ؿ����Ҳ��Ӱ�췶Χ
  function Tzk_bore.ReturnCxbj(zk: TZk_bore): WideString;
  begin

  end;
  //===============================================
  //===��ʼ��֧��
function TZJ_Class.Init(str:wideString;out sEorr:Widestring):WordBool;
var
           temp1,temp2 :Str_Dt_array;
           i,Count1,Count2:integer;
begin
        Result:=true;
        sEorr:='֧�ܳ�ʼ���ɹ�!';
        if trim(str)='' then begin
            str:='ZJ:�۲�,ZY13000/25/50,1.75,5,2.6,2,2.5,13000,1.46,2,.5,';  
        end;
      try
            temp1:=Public_Basic.split(str,':',Count1);

            if UpperCase(temp1[0])<>'ZJ' then
             begin
               Result:=False;
               sEorr:='֧�ܱ�ͷZJ����!';
               exit;
             end;

           temp2:=Public_Basic.split(temp1[1],',',Count2);
           if count2<12 then
               begin
               Result:=False;
               sEorr:='����ϸ����ļ�!';
               exit;
              end;
         for i :=low(temp2) to high(temp2) do
           begin
             if length(temp2[i])=0 then continue;
                  case i of
                     0: Zj_XingHao :=Trim(temp2[i]);
                     1: ZJ_BianHao:=Trim(temp2[i]);
                     2: ZJ_Zhongxinju :=Public_Basic.strTodouble_lu(temp2[i]);
                     3: ZJ_KongDingJU  :=Public_Basic.strTodouble_lu(temp2[i]);
                     4: Zj_Hlzyd  :=Public_Basic.strTodouble_lu(temp2[i]);
                     5: ZJ_Lizhu_count  :=Public_Basic.strToInt_lu(temp2[i]);
                     6: ZJ_suoliang    :=Public_Basic.strTodouble_lu(temp2[i]);
                     7: ZJ_toall_F:=Public_Basic.strTodouble_lu(temp2[i]);
                     8: ZJ_toall_P  :=Public_Basic.strTodouble_lu(temp2[i]);
                     9: ZJ_Hubang_h :=Public_Basic.strTodouble_lu(temp2[i]);
                     10: ZJ_Hubang_p :=Public_Basic.strTodouble_lu(temp2[i]);
                     11: Zj_Lz_Diameter:= Public_Basic.strTodouble_lu(temp2[i]);
                  end;
             end; //endfor
              temp1:=nil;temp2:=nil;
              //���֧�����߶�����С�߶�
              temp2:=Public_Basic.split(ZJ_Name,'/',Count2);
              if Count2>2 then    begin
                 ZJ_Min_h :=Public_Basic.StrTodouble_lu(Trim(temp2[1]));
                 ZJ_Max_h :=ZJ_min_h+ ZJ_suoliang;

              end;
              if Trim(ZJ_Name)<> '����' then   begin

                       if ZJ_Zhongxinju=0  then //�ж�֧�����ľ�
                         begin
                           Result:=False;
                           sEorr:=sEorr+'֧�����ľ�/';
                          end;
                       if ZJ_KongDingJU=0  then  // �ж�֧�ܿض���
                         begin
                           Result:=False;
                           sEorr:=sEorr+'֧�ܿض���/';
                         end;
                       if Zj_Hlzyd=0  then  // �ж�֧�ܺ������õ�
                         begin
                           Result:=False;
                           sEorr:=sEorr+'�������õ�/';
                         end;
              end; //end    if Trim(ZJ_Name)<> '����' then   begin
         except
              Result:=False;
              sEorr:='���ݸ�ʽ����/';
              exit;
       end;
         zhiJia_F_xs :=1;   // ֧��֧��ǿ���޶�ϵ��
         zhijia_L_xs :=1;; // ֧�������޶�ϵ��
         zhijia_hb_Q_xs :=1;// ֧�ܻ���ǿ���޶�ϵ��

   end;

   //  ��ִ���֧�ܽṹ����
 function TZJ_Class.SpliJG(str:widestring;out sEorr:widestring):WordBool;
  var
           temp1 :Str_Dt_array;
           i,Count1:integer;
  begin
        Result:=true;
        sEorr:='֧�ܲ�ֳɹ�!';
      try
            temp1:=Public_Basic.split(str,',',Count1);
         if count1<11 then
               begin
               Result:=False;
               sEorr:='����ϸ����ļ�!';
               exit;
              end;
         for i :=low(temp1) to high(temp1) do
           begin
                  if length(temp1[i])=0 then continue;
                  case i of
                     0: self.JG_jx   :=Trim(temp1[i]);
                     1: self.JG_Dl   :=Trim(temp1[i]);
                     2: self.JG_Dz   :=Trim(temp1[i]);
                     3: self.JG_slg  :=Trim(temp1[i]);
                     4: self.JG_ty   :=Trim(temp1[i]);
                     5: self.JG_Fm   :=Trim(temp1[i]);
                     6: self.JG_Wl   :=Trim(temp1[i]);
                     7: self.JG_Qc   :=Trim(temp1[i]);
                     8: self.JG_Ct   :=Trim(temp1[i]);
                     9: self.JG_Dt   :=Trim(temp1[i]);
                     10: self.JG_Ql  :=Trim(temp1[i]);

                  end;

             end; //endfor
         except
              Result:=False;
              sEorr:='���ݸ�ʽ����/';
              exit;
        end;  //end try
         if Trim(self.JG_Dl)='DL1' then  //�½Ӷ���
           begin
                 if  self.Zj_JiSuan_Ci_F[0]>=10000 then   begin
                      if  JG_jx='JX1' then   begin
                          self.ZJ_JianYi_Type:='112';
                      end else if  JG_jx='JX2' then begin
                          self.ZJ_JianYi_Type:='122';
                      end; //endif JG_jx='JX1'
                 end else begin
                      if  JG_jx='JX1' then   begin
                          self.ZJ_JianYi_Type:='212';
                      end else if  JG_jx='JX2' then begin
                          self.ZJ_JianYi_Type:='222';
                      end; //endif JG_jx='JX1'
                 end;  //  if  self.Zj_JiSuan_Ci_F[0]>=10000
           end else begin //esle if Trim(self.JG_Dl)='DL1' then  // ����
                  if  self.Zj_JiSuan_Ci_F[0]>=10000 then   begin
                      if  JG_jx='JX1' then   begin
                          self.ZJ_JianYi_Type:='111';
                      end else if  JG_jx='JX2' then begin
                          self.ZJ_JianYi_Type:='121';
                      end; //endif JG_jx='JX1'
                 end else begin
                      if  JG_jx='JX1' then   begin
                          self.ZJ_JianYi_Type:='211';
                      end else if  JG_jx='JX2' then begin
                          self.ZJ_JianYi_Type:='221';
                      end; //endif JG_jx='JX1'
                 end;  //  if  self.Zj_JiSuan_Ci_F[0]>=10000

           end;  //end if  Trim(self.JG_Dl)='DL1'



        //���ʵ� ���ڸ�
            if  JG_jx='JX3' then   begin
                self.ZJ_JianYi_Type:='JX3';
            end else if  JG_jx='JX4' then   begin
                self.ZJ_JianYi_Type:='JX4';
            end;

   end;
   //��ȡ֧�ܵ�ϵ��
  function TZJ_Class.ReadZhijia_XS(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString; //����֧�ܲ�sh
   var
      pIniFile:     TIniFile;
      i:integer;
      in_Zj_DBFD_xs:  array [1..4] of array[1..9] of double;// ���治ͬ���� ����
      ZhijiaXiu_count:integer;
   begin
          if not FileExists(OcxPath +'\ZhijiaCs_lulei.dat') then   begin
              pIniFile := Tinifile.create(OcxPath+'\ZhijiaCs_lulei.dat');
                 // I
                  in_Zj_DBFD_xs[1][1] :=0.25;
                  in_Zj_DBFD_xs[1][2] :=0.5;
                  in_Zj_DBFD_xs[1][3] :=0.5;
                  in_Zj_DBFD_xs[1][4] :=1;
                  in_Zj_DBFD_xs[1][6] :=0.3;
                  in_Zj_DBFD_xs[1][7] :=0.6;
                  in_Zj_DBFD_xs[1][8] :=0.6;
                  in_Zj_DBFD_xs[1][9] :=1.1;


                   // II

                  in_Zj_DBFD_xs[2][1] :=0.25;
                  in_Zj_DBFD_xs[2][2] :=0.5;
                  in_Zj_DBFD_xs[2][3] :=0.5;
                  in_Zj_DBFD_xs[2][4] :=0.8;
                  in_Zj_DBFD_xs[2][6] :=0.4;
                  in_Zj_DBFD_xs[2][7] :=0.6;
                  in_Zj_DBFD_xs[2][8] :=0.6;
                  in_Zj_DBFD_xs[2][9] :=1;

                   // III
                  in_Zj_DBFD_xs[3][1] :=0.1;
                  in_Zj_DBFD_xs[3][2] :=0.3;
                  in_Zj_DBFD_xs[3][3] :=0.6;
                  in_Zj_DBFD_xs[3][4] :=1;
                  in_Zj_DBFD_xs[3][6] :=0.2;
                  in_Zj_DBFD_xs[3][7] :=0.4;
                  in_Zj_DBFD_xs[3][8] :=0.6;
                  in_Zj_DBFD_xs[3][9] :=1;


                  // IV
                  in_Zj_DBFD_xs[4][1] :=0.2;
                  in_Zj_DBFD_xs[4][2] :=0.5;
                  in_Zj_DBFD_xs[4][3] :=0.6;
                  in_Zj_DBFD_xs[4][4] :=1;
                  in_Zj_DBFD_xs[4][6] :=0.2;
                  in_Zj_DBFD_xs[4][7] :=0.4;
                  in_Zj_DBFD_xs[4][8] :=0.6;
                  in_Zj_DBFD_xs[4][9] :=1;

              pIniFile.Free;
          end else begin
                  pIniFile := Tinifile.create(OcxPath+'\ZhijiaCs_lulei.dat');
                  for I := 1 to 9 do  begin
                     // I
                     if i=5 then   continue;
                     in_Zj_DBFD_xs[1][i]:=pIniFile.ReadFloat('I',IntToStr(i),0);
                        // II
                     in_Zj_DBFD_xs[2][i]:=pIniFile.ReadFloat('II',IntToStr(i),0);
                        // III
                     in_Zj_DBFD_xs[3][i]:=pIniFile.ReadFloat('III',IntToStr(i),0);
                        // III
                     in_Zj_DBFD_xs[4][i]:=pIniFile.ReadFloat('IV',IntToStr(i),0);
                  end;
              pIniFile.Free;
          end;
          //  ��������
           //�жϹ���
           if old.Old_leibie<3 then  begin
                ZhijiaXiu_count:=1;
           end else if old.Old_leibie =3 then  begin
                ZhijiaXiu_count:=2;
           end else begin
                ZhijiaXiu_count:=3;
           end;

            if gzm.S_mcsd_h< 200 then  begin
                ZhijiaXiu_count:=4;
            end;


           for I := 1 to 9 do begin

               Zj_DBFD_xs[i]:=in_Zj_DBFD_xs[ZhijiaXiu_count][i];


           end;
   end;

 //����֧�ܻ�������
   function TZJ_Class.Cal_Sup_Para(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString;
   var
     Imm_F     :double ; //֧��֧��ֱ�Ӷ�����
     Imm_P     :double;  //֧��֧��ֱ�Ӷ���ѹǿ
     Imm_f_z   :double; //ֱ�Ӷ�������ϵ��
     Imm_ls    :double;//ֱ�Ӷ�����������
     Old_C0_F  :array[0..2] of double; // �϶�������ѹʱ֧�ܵ�����  0  ���ֵ 1 ��Сֵ 2 ƽ��ֵ
     Old_Ci_F  :array[0..2] of double;  // �϶�������ѹʱ֧�ܵ�����  0  ���ֵ 1 ��Сֵ 2 ƽ��ֵ
     Old_C0_L  :array[0..2] of double; // �϶�������ѹʱ֧�ܵ�����   0  ���ֵ 1 ��Сֵ 2 ƽ��ֵ
     Old_Ci_L  :array[0..2] of double;  // �϶�������ѹʱ֧�ܵ�����  0  ���ֵ 1 ��Сֵ 2 ƽ��ֵ
     YLFDXS    : double;//��ͬ�ṹ�������ķֵ�ϵ��
     sResult   :WideString;//���ؽ��ֵ
     MBphgd_t  :array[0..5] of Double ;//'(0)Ϊ���л����棬(1)Ϊ��Ħ���Ǽ���,(2)Ϊѹ�˼���,(3)Ϊú���������� ,(4)֧�ܹ���������ʽ����
     ZjGzzu    :double; //������֧�ܵĹ�������
     Q1,Q2,Q3,Q0:double;// ���㻥��ǿ���������Ǳ��� Q1 ֱ�Ӷ����غ� Q2 ǰ��֧��ѹ�����غ� Q3 �϶�ͨ�����������ݵ��غ�  Q0 ú�ڳе��غ�
     i:integer;
   begin
      //����֧�����д���
      if Trim(ZJ_Name)= '����' then   begin
        Exit;
      end;
      //��֤֧���Ƿ񱻳�ʼ��
      if length(Trim(Zj_XingHao))<1 then  begin   //��֤֧���Ƿ񱻳�ʼ��
          ZJ_Zhongxinju:=1.5 ;//��֧�����ľำĬ��ֵ
          ZJ_KongdingJu:=5 ;//��֧�ܿض��ำĬ��ֵ
          ZJ_hlzyd:=3 ;//��֧�ܺ������õ㸳Ĭ��ֵ

      end; //end  length(Trim(Zj_XingHao))>0
       //��ʼ��֧���޶�����
        self.DzXd_Cal_sup_para(gzm,zk,imm,old);
        //��ȡ�ļ�
        self.ReadZhijia_XS(gzm,zk,imm,old);
      //����֧�ܵ�����ϵ��
      if gzm.S_Fm_h> 1 then  begin   //20150506 edit
          Imm_ls:=0;
      end else begin
             if Imm.Immroof_C0*0.3>ZJ_Kongdingju then  begin  //�ж�֧�ܿض�����ֱ�Ӷ����ڿ���Ĺ�ϵ
                  if Imm.Immroof_C0*0.3- ZJ_Kongdingju > gzm.S_Cg_h then  begin
                     Imm_ls:=(gzm.S_Cg_h)+ imm.Immroof_M/2*tan(30/180*3.14159);
                  end else begin
                     Imm_ls:=( Imm.Immroof_C0*0.3- ZJ_Kongdingju)+ imm.Immroof_M/2*tan(30/180*3.14159);
                  end;
             end else begin
                  Imm_ls:=imm.Immroof_M/2*tan(30/180*3.14159);
             end;
      end;



       Imm_f_z :=ZJ_KongDingJu*Power(1*Imm_ls/ZJ_Kongdingju,2)/2/ZJ_hlzyd;
       //����֧��֧��ֱ�Ӷ�����Ҫ����
         //201505060edit
         if gzm.S_Fm_h> 1 then  begin   //20150506 edit
            Imm_P:= Imm.Immroof_M *25 * Imm_f_z/ZJ_KongDingJu*(ZJ_KongDingJu-gzm.S_Fm_h*tan(30/180*3.14159));          //  ֱ�Ӷ���ѹǿ
         end else begin
            Imm_P:= Imm.Immroof_M *25 * Imm_f_z;          //  ֱ�Ӷ���ѹǿ
         end;

         Imm_F:= ZJ_Kongdingju * ZJ_ZhongxinJu *Imm_P ;
         zj_imm_p:=Imm_P/1000;
         {
           2013��12��Ϊ֣��ú�����ƶ�����ϵ��׼��
           ��1��������Ӧ������ �ǵ������ṹ������֧�ܵ���ѹ����  �ڳ�����ѹ�׶�  ϵ���ݶ�Ϊ 0.25 ����������ѹ�׶� ϵ���ݶ�Ϊ 0.5
                                �������ṹ������֧�ܵ�֧������  �ڳ�����ѹ�׶�  ϵ���ݶ�Ϊ 0.5 ����������ѹ�׶� ϵ���ݶ�Ϊ 0.8
           ��2��������Ӧ������ �ǵ������ṹ������֧�ܵ���ѹ����  �ڳ�����ѹ�׶�  ϵ���ݶ�Ϊ 0.4 ����������ѹ�׶� ϵ���ݶ�Ϊ 0.6
                                �������ṹ������֧�ܵ�֧������  �ڳ�����ѹ�׶�  ϵ���ݶ�Ϊ 0.6 ����������ѹ�׶� ϵ���ݶ�Ϊ 1

         }
       //�ж���Ӧ����������
       if gzm.ZCYL_s0>1 then   begin        //     1----  ����Ӧ����
            if old.YL_struc =1 then begin   //   begin  2----�������ṹ
                //�϶�������ѹ
                        //ѹ��
                        YLFDXS :=Zj_DBFD_xs[1];
                        Old_C0_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS;    //�������ֵ
                        YLFDXS :=Zj_DBFD_xs[1];
                        Old_C0_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS;  //������Сֵ
                        YLFDXS :=Zj_DBFD_xs[1];
                        Old_C0_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS;  //����ƽ��ֵ
                        //����
                        Old_C0_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[1];  //�������ֵ
                        Old_C0_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[0];  //������ Сֵ
                        Old_C0_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[2];  //����ƽ��ֵ

                //�϶�������ѹ
                        YLFDXS :=Zj_DBFD_xs[2];
                        Old_Ci_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS*0.408;    //�������ֵ
                        YLFDXS :=Zj_DBFD_xs[2];
                        Old_Ci_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS*0.408;  //������Сֵ
                        YLFDXS :=Zj_DBFD_xs[2];
                        Old_Ci_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS*0.408;  //����ƽ��ֵ

                         //����
                        Old_Ci_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[1]*0.408);  //�������ֵ
                        Old_Ci_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[0]*0.408);  //������Сֵ
                        Old_Ci_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[2]*0.408);  //����ƽ��ֵ


               end else begin // else 2         //�������ṹ

                      //�϶�������ѹ
                        //ѹ��
                        YLFDXS :=Zj_DBFD_xs[3];
                        Old_C0_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS;    //�������ֵ
                        YLFDXS :=Zj_DBFD_xs[3];
                        Old_C0_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS;  //������Сֵ
                        YLFDXS :=Zj_DBFD_xs[3];
                        Old_C0_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS;  //����ƽ��ֵ
                        //����
                        Old_C0_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[1];  //�������ֵ
                        Old_C0_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[0];  //������ Сֵ
                        Old_C0_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[2];  //����ƽ��ֵ

                    //�϶�������ѹ
                        YLFDXS :=Zj_DBFD_xs[4];
                        Old_Ci_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS*0.408;    //�������ֵ
                        YLFDXS :=Zj_DBFD_xs[4];
                        Old_Ci_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS*0.408;  //������Сֵ
                        YLFDXS :=Zj_DBFD_xs[4];
                        Old_Ci_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS*0.408;  //����ƽ��ֵ

                         //����
                        Old_Ci_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[1]*0.408);  //�������ֵ
                        Old_Ci_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[0]*0.408);  //������Сֵ
                        Old_Ci_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[2]*0.408);  //����ƽ��ֵ



                end;    //  end 2
       end else begin            //����Ӧ����
               if old.YL_struc =1 then begin   //    �������ṹ    begin  3
                //�϶�������ѹ
                        //ѹ��
                        YLFDXS :=Zj_DBFD_xs[6];
                        Old_C0_F[0] := Imm_F+ old.YL_max_m *old.YL_First_step[0]*25* Zj_zhongxinju*YLFDXS;    //�������ֵ
                        YLFDXS :=Zj_DBFD_xs[6];
                        Old_C0_F[1] := Imm_F+ old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS;  //������Сֵ
                        YLFDXS :=Zj_DBFD_xs[6];
                        Old_C0_F[2] := Imm_F+ old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS;  //����ƽ��ֵ
                        //����
                        Old_C0_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[1];  //�������ֵ
                        Old_C0_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[0];  //������ Сֵ
                        Old_C0_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[2];  //����ƽ��ֵ

                //�϶�������ѹ
                        YLFDXS :=Zj_DBFD_xs[7];
                        Old_Ci_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS*0.408;    //�������ֵ
                        YLFDXS :=Zj_DBFD_xs[7];
                        Old_Ci_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS*0.408;  //������Сֵ
                        YLFDXS :=Zj_DBFD_xs[7];
                        Old_Ci_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS*0.408;  //����ƽ��ֵ

                         //����
                        Old_Ci_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[1]*0.408);  //�������ֵ
                        Old_Ci_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[0]*0.408);  //������Сֵ
                        Old_Ci_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[2]*0.408);  //����ƽ��ֵ


               end else begin // //�������ṹ        else 3

                      //�϶�������ѹ
                        //ѹ��
                        YLFDXS :=Zj_DBFD_xs[8];
                        Old_C0_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS;    //�������ֵ
                        YLFDXS :=Zj_DBFD_xs[8];
                        Old_C0_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS;  //������Сֵ
                        YLFDXS :=Zj_DBFD_xs[8];
                        Old_C0_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS;  //����ƽ��ֵ
                        //����
                        Old_C0_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[1];  //�������ֵ
                        Old_C0_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[0];  //������ Сֵ
                        Old_C0_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/old.YL_First_step[2];  //����ƽ��ֵ

                    //�϶�������ѹ
                        YLFDXS :=Zj_DBFD_xs[9];
                        Old_Ci_F[0] :=Imm_F+ old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*YLFDXS*0.408;    //�������ֵ
                        YLFDXS :=Zj_DBFD_xs[9];
                        Old_Ci_F[1] := Imm_F+old.YL_min_m *old.YL_First_step[1]*25* Zj_zhongxinju*YLFDXS*0.408;  //������Сֵ
                        YLFDXS :=Zj_DBFD_xs[9];
                        Old_Ci_F[2] := Imm_F+old.YL_min_m *old.YL_First_step[2]*25* Zj_zhongxinju*YLFDXS*0.408;  //����ƽ��ֵ

                         //����
                        Old_Ci_L[0] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[1]*0.408);  //�������ֵ
                        Old_Ci_L[1] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[0]*0.408);  //������Сֵ
                        Old_Ci_L[2] :=(gzm.S_Cg_h+gzm.S_Fm_h)*(gzm.ZCYL_s0+ZJ_hlzyd)/(old.YL_First_step[2]*0.408);  //����ƽ��ֵ



            end;      //end 3

       end;  //end   if gzm.ZCYL_s0<1    end  1
        //���������ѹ����ѹǿ��ֵ
        Zj_jisuan_C0_F[0]:=Old_C0_F[0]*zhiJia_F_xs; Zj_jisuan_C0_F[1]:=Old_C0_f[1]*zhiJia_F_xs;  Zj_jisuan_C0_F[2]:=Old_C0_f[2]*zhiJia_F_xs;  //���  ��С ƽ��
        Zj_jisuan_Ci_F[0]:=Old_Ci_F[0]*zhiJia_F_xs; Zj_jisuan_Ci_F[1]:=Old_Ci_f[1]*zhiJia_F_xs;  Zj_jisuan_Ci_F[2]:=Old_Ci_f[2]*zhiJia_F_xs;  //���  ��С ƽ��
        // ǿ�ƴ���  20160506
         if  Zj_jisuan_C0_F[2]>22000 then
              for I := 0 to 2 do
                 Zj_jisuan_C0_F[i]:=Zj_jisuan_C0_F[i]*(22000/Zj_jisuan_C0_F[2]);


          if  Zj_jisuan_Ci_F[2]>18000 then
               for I := 0 to 2 do
                 Zj_jisuan_Ci_F[i]:=Zj_jisuan_Ci_F[i]*(18000/Zj_jisuan_Ci_F[2]);

          if  gzm.S_Fm_h>0 then begin
            for I := 0 to 2 do
             begin
                       Zj_jisuan_C0_F[i]:=Zj_jisuan_C0_F[i]*(1-gzm.S_Fm_h/(gzm.S_Fm_h+gzm.S_Cg_h));
                       Zj_jisuan_Ci_F[i]:=Zj_jisuan_Ci_F[i]*(1-gzm.S_Fm_h/(gzm.S_Fm_h+gzm.S_Cg_h));

             end;

         end;

         //===============================20150506
        //֧�ܵ�֧��ǿ�� ����
        Zj_jisuan_C0_p[0]:= Zj_jisuan_C0_F[0]/zj_kongdingju/zj_zhongxinju/1000;
           zj_old_C0_p[0]:= Zj_jisuan_C0_p[0]-zj_imm_p;
        Zj_jisuan_C0_p[1]:= Zj_jisuan_C0_F[1]/zj_kongdingju/zj_zhongxinju/1000;
           zj_old_C0_p[1]:= Zj_jisuan_C0_p[1]-zj_imm_p;
        Zj_jisuan_C0_p[2]:= Zj_jisuan_C0_F[2]/zj_kongdingju/zj_zhongxinju/1000;
           zj_old_C0_p[2]:= Zj_jisuan_C0_p[2]-zj_imm_p;
         //֧�ܵ�֧��ǿ��  ����
        Zj_jisuan_Ci_p[0]:= Zj_jisuan_Ci_F[0]/zj_kongdingju/zj_zhongxinju/1000;
            zj_old_Ci_p[0]:= Zj_jisuan_Ci_p[0]-zj_imm_p;
        Zj_jisuan_Ci_p[1]:= Zj_jisuan_Ci_F[1]/zj_kongdingju/zj_zhongxinju/1000;
            zj_old_Ci_p[1]:= Zj_jisuan_Ci_p[1]-zj_imm_p;
        Zj_jisuan_Ci_p[2]:= Zj_jisuan_Ci_F[2]/zj_kongdingju/zj_zhongxinju/1000;
            zj_old_Ci_p[2]:= Zj_jisuan_Ci_p[2]-zj_imm_p;

        //֧�ܵ�����
        Zj_jisuan_sl[0]:=Old_Ci_L[0]*zhiJia_L_xs;
        Zj_jisuan_sl[1]:=Old_Ci_L[1]*zhiJia_L_xs;
        Zj_jisuan_sl[2]:=Old_Ci_L[2]*zhiJia_L_xs;
       //====================����Ϊ����ú��Ƭ�������
         //(0)Ϊ���л��������
            MBphgd_t[0] := Tan((45 + gzm.S_M_mcj / 2) / 180 * 3.14159) * gzm.ZCYL_s1[0];
         //(1)Ϊ��Ħ���Ǽ���
            MBphgd_t[1] := Tan(gzm.S_M_mcj / 180 * 3.14159) * gzm.ZCYL_s1[0];
         //(2)Ϊѹ�˼���
            MBphgd_t[2] := 0.35 * gzm.S_Cg_h;
         //(3)ú��������������
            MBphgd_t[3] := 2 * gzm.S_M_njl * Tan((45 + gzm.S_M_mcj / 2) / 180 * 3.14159) / 15000;
        // (4) ֧�ܹ���״̬ú��߶ȼ���

            if Zj_toall_F<100 then  begin    //�ô�������ҪΪ��ֹ֧��¼����ֵ̫С�����е��쳣����
                 ZjGzzu:=Zj_jisuan_ci_p[2]; //ʹ��ƽ��ֵ���м���
            end else begin
                 ZjGzzu:=Zj_toall_p;
            end;

            MBphgd_t[4]:= Sqr(gzm.S_M_njl* gzm.S_M_njl * 4 - 2 * ZjGzzu * 1000 * Tan((45 - gzm.S_M_mcj / 2) / 180 * 3.14159));
            if MBphgd_t[1]> gzm.S_Cg_h/2 then MBphgd_t[1]:=0.5*gzm.S_Cg_h;
            if MBphgd_t[4]> gzm.S_Cg_h/2 then MBphgd_t[4]:=0.5*gzm.S_Cg_h;
        //��֧�ܵĻ���߶ȸ�ֵ
           zj_jisuan_hubang_h[0]:=MBphgd_t[0];  //   //(0)Ϊ���л��������
           zj_jisuan_hubang_h[1]:=MBphgd_t[1];  //   //(1)Ϊ��Ħ���Ǽ���
           zj_jisuan_hubang_h[2]:=MBphgd_t[2];       //(2)Ϊѹ�˼���
           zj_jisuan_hubang_h[3]:=MBphgd_t[3];       //(3)ú��������������
           zj_jisuan_hubang_h[4]:=MBphgd_t[4];       // (4) ֧�ܹ���״̬ú��߶ȼ���
       //ú�ڻ���ǿ�ȼ���
           Q1:= Imm_P;
           if(gzm.ZCYL_s1[0]=0) then begin
                  Q2:= gzm.ZCYL_s0 * gzm.ZCYL_s0 / 2 * gzm.S_K_zcfz * gzm.S_Cg_h * 25 ;
           end else begin
                  Q2:= gzm.ZCYL_s0 * gzm.ZCYL_s0 / 2 / gzm.ZCYL_s1[0]   * gzm.S_K_zcfz * gzm.S_Cg_h * 25 ;
           end;


           Q3:= old.YL_max_m*old.YL_First_step[0]*25*Zj_zhongxinju*0.5*0.3;
           Q0:=Q1+Q2+Q3-ZjGzzu*1000*Zj_zhongxinju*zj_kongdingju*cos(70.0/180*3.1415926);
           if Q0<0 then  Q0:=0;      //ǿ�ƴ���
           if Q0>500 then  Q0:=500;  //ǿ�ƴ���
           
             Zj_jisuan_hubang_p[2]:=(Q0+0.5*gzm.ZCYL_s0*MBphgd_t[2]*15)/1000/MBphgd_t[2]*self.zhijia_hb_Q_xs;
             //Zj_jisuan_hubang_p[2]:=0.12;

   end;
    //---------------------------------
 function TZJ_Class.DzXd_Cal_sup_para(gzm:TG_Stope;Zk:Tzk_bore;imm:TImmediate_roof;old:Told_roof):WideString; //  ���ݵ��������޶�֧�ܵĻ�������
  var
     s_out:widestring;
     Yl_stuct:integer;
     imm_m,Imm_c0,old_h_Max,Old_h_Min,old_l_max,old_l_min,Old_l_avg:double;
  begin
     //���ݵ��������޶����ʲ���
      zhiJia_F_xs:=1;zhijia_L_xs:=1; //��ʼ��ϵ��
      if  gzm.S_cmfs='4' then begin       //��ú��ʽ  �Ŷ�ú
          zhiJia_F_xs:=zhiJia_F_xs*1; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1.1;// �����޶�ϵ��
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// ����ǿ���޶�
      end;
      //�޸�ֵ����
      yL_stuct:=old.YL_struc;
      imm_m:=imm.Immroof_M;
      imm_c0:=imm.Immroof_C0 ;
      old_h_max:=old.YL_max_m ;
      old_h_min:=old.YL_min_m ;
      old_l_max:= old.YL_First_step[0] ;
      old_l_min:= old.YL_First_step[1] ;
      old_l_avg:= old.YL_First_step[2] ;

      imm.init(gzm,zk,0.5,s_out);    //��ʼ��ֱ�Ӷ�
      old.init(gzm,zk,imm,s_out);  //��ʼ���϶�
     // cal_zcyl(zk,imm,gzm,old,s_out);     //����֧��ѹ��
     // cal_ldg(zk,gzm,imm,200,s_out);  ;     //�����ѶϹ�
      //��ֵ�������        
      old.YL_struc     :=yL_stuct;
      imm.Immroof_M  :=imm_m ;
      imm.Immroof_C0 :=imm_c0 ;
      old.YL_max_m     :=old_h_min ;
      old.YL_First_step[0] :=old_l_max ;
      old.YL_First_step[1] :=old_l_min;
      old.YL_First_step[2] :=old_l_avg  ;

      if  gzm.Dz_yxfx = 1 then begin       //��б
          zhiJia_F_xs:=zhiJia_F_xs*1.05; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *0.95;// �����޶�ϵ��
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.1;// ����ǿ���޶�
      end else if gzm.Dz_yxfx = 2 then begin                          // ��б
          zhiJia_F_xs:=zhiJia_F_xs*0.95; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1.05;// �����޶�ϵ��
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*0.95;// ����ǿ���޶�
      end;

      if  gzm.Dz_JYHD  =1 then begin       //���Һ��    ������
          zhiJia_F_xs:=zhiJia_F_xs*3; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1;// �����޶�ϵ��
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// ����ǿ���޶�
      end else if gzm.Dz_JYHD = 2 then begin            // һ�����
          zhiJia_F_xs:=zhiJia_F_xs*1.5; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1;// �����޶�ϵ��
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// ����ǿ���޶�
      end;

      if  gzm.Dz_DCGZ  =1 then begin       //���ʹ�����
          zhiJia_F_xs:=zhiJia_F_xs*0.95; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1.05;   //
      end else if gzm.Dz_DCGZ >3  then begin            // ��ַ���츴��
          zhiJia_F_xs:=zhiJia_F_xs*1.05; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1;// �����޶�ϵ��
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// ����ǿ���޶�
      end;

      if  gzm.Dz_TopWater  =2  then begin       //����ˮ
          zhiJia_F_xs:=zhiJia_F_xs*1.05; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1;   //
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// ����ǿ���޶�
      end else if gzm.Dz_TopWater =4  then begin            //
          zhiJia_F_xs:=zhiJia_F_xs*1.05; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1;// �����޶�ϵ��
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// ����ǿ���޶�
      end;

      if  gzm.Dz_BottomWater  =2  then begin       //�װ�ˮ
          zhiJia_F_xs:=zhiJia_F_xs*0.95; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1;   //
      end else if gzm.Dz_BottomWater =4  then begin            //
          zhiJia_F_xs:=zhiJia_F_xs*0.95; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1;// �����޶�ϵ��
      end;

     
      if  gzm.Dz_Kyxx =3  then begin       //��ѹ����
          zhiJia_F_xs:=zhiJia_F_xs*1.05; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1.05;   //
      end else if gzm.Dz_Kyxx =4  then begin            //
          zhiJia_F_xs:=zhiJia_F_xs*1.1; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1.05;// �����޶�ϵ��
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// ����ǿ���޶�
      end;

      if  gzm.Dz_HangDaoSup =4  then begin       //���֧��
          zhiJia_F_xs:=zhiJia_F_xs*0.95; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1.05;   //
      end else if gzm.Dz_HangDaoSup=5  then begin            //
          zhiJia_F_xs:=zhiJia_F_xs*0.9; //�����޶�ϵ��
          zhijia_L_xs:=zhijia_L_xs *1.05;// �����޶�ϵ��
          zhijia_hb_Q_xs:= zhijia_hb_Q_xs*1.05;// ����ǿ���޶�
      end;

      if gzm.UP_Ckq =2 then  begin
         if gzm.UP_CKQ_JuLI < imm.Immroof_M then  begin
             imm.Immroof_M:=imm.Immroof_M+gzm.UP_CKQ_Kc_H*3;
         end else  if gzm.UP_CKQ_JuLI <gzm.Hg_ldg  then begin
             zhiJia_F_xs:=zhiJia_F_xs*1.1; //�����޶�ϵ��
             zhijia_L_xs:=zhijia_L_xs *1;// �����޶�ϵ��
         end; 
      end;

     
  end;
    // //����֧�ܲ���
 function TZJ_Class.Return_zj_Para(Version:WideString):WideString;   //����֧�ܲ���
     var
         RStr:Widestring;
         i:integer;
     begin
       if Version='1.0'  then begin
             Rstr:='  �϶�������ѹʱ:';
             for I := 0 to 2 do  begin    //��Ϲ������� ��λKN
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_c0_F[i])+'KN��';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_c0_F[i])+'KN��';
                end;

             end;
             for I := 0 to 2 do  begin    //��Ϲ���ǿ�� ��λMPa
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_c0_P[i])+'MPa��';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_c0_P[i])+'MPa��';
                end;

             end;

              Rstr:=Rstr+#13+'     �϶�������ѹʱ:';
             for I := 0 to 2 do  begin    //��Ϲ������� ��λKN
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_ci_F[i])+'KN��';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_ci_F[i])+'KN��';
                end;

             end;
             for I := 0 to 2 do  begin    //��Ϲ���ǿ�� ��λMPa
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_ci_P[i])+'MPa��';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_ci_P[i])+'MPa��';
                end;

             end;
           {  Rstr:=Rstr+'����߶�:';
              for I := 0 to 4 do  begin    //��ϻ���߶� ��λm
                if i<>4 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_hubang_H[i])+'m,';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_hubang_H[i])+'m#';
                end;

             end;
              Rstr:=Rstr+'����ǿ��:';
              Rstr:=Rstr+ FormatFloat('0.0', Zj_jisuan_hubang_p[2])+'MPa#';
             }

       end; //end 1.0

      if Version='2.0'  then begin
          Rstr:='';
           for I := 0 to 2 do  begin    //��Ϲ������� ��λKN
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_c0_F[i])+',';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_c0_F[i])+';';
                end;

             end;
             for I := 0 to 2 do  begin    //��Ϲ���ǿ�� ��λMPa
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_c0_P[i])+',';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_c0_P[i])+';';
                end;

             end;


             for I := 0 to 2 do  begin    //��Ϲ������� ��λKN
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_ci_F[i])+',';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_ci_F[i])+';';
                end;

             end;
             for I := 0 to 2 do  begin    //��Ϲ���ǿ�� ��λMPa
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_ci_P[i])+',';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.00',zj_jisuan_ci_P[i])+';';
                end;

             end;

              for I := 0 to 4 do  begin    //��ϻ���߶� ��λm
                if i<>4 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_hubang_H[i])+',';
                end else begin
                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_hubang_H[i])+';';
                end;

             end;

               for I := 0 to 2 do  begin    //��ϻ���ǿ�� ��λMPa
                if i<>2 then  begin
                   Rstr:=Rstr+ FormatFloat('0.0', Zj_jisuan_hubang_p[i])+',';
                end else begin
                    Rstr:=Rstr+ FormatFloat('0.0', Zj_jisuan_hubang_p[i])+';';
                end;

              end;


      end;  //end 2.0

       if Version='3.0'  then begin
                   Rstr:='';

                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_c0_F[2])+',';

                   Rstr:=Rstr+ FormatFloat('0.0',zj_jisuan_ci_F[2])+'';
       end;
       
       Result:=Rstr;
 end; //end function

 // ��֧��
 
procedure TZJ_Class.Draw_zhiJia(Image:TImage;x1,y1,x2,y2,mc_h:double;lizhushu,jia_type:integer);// jia_type 1 �۲�  2 �۷�
 var
    zJ_H,zJ_w :double;
     Points: array[0..3] of TPoint;
     bitmap1:Tbitmap;//����λͼ bitmap1
 begin
  //=====================
   zj_w:=x2-x1;
    zj_h:=y2-y1;

    if jia_type=1  then begin    //�۲�֧��
        //������    �۲�֧��
        Image.Canvas.Pen.Width :=1;
        Image.Canvas.Pen.Color :=$000000;
        Image.Canvas.MoveTo(trunc(x1+zj_w/60*27),trunc(y2));
        Image.Canvas.LineTo(trunc(x2-zj_w/60*3),trunc(y2));
        Image.Canvas.LineTo(trunc(x2-zj_w/60*3),trunc(y2-zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*13),trunc(y2-zj_H/60*12)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*20),trunc(y2-zj_H/60*8)) ;
        Image.Canvas.LineTo(trunc(x1+zj_w/60*27),trunc(y2-zj_H/60*8)) ;
        Image.Canvas.LineTo(trunc(x1+zj_w/60*27),trunc(y2));
        //������֧��  �۲�֧��
        Image.Canvas.Pen.Width :=1;
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*3),trunc(y2-zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*1),trunc(y2-zj_H/60*20)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*2),trunc(y2-zj_H/60*20)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*4),trunc(y2-zj_H/60*6)) ;

        Image.Canvas.MoveTo(trunc(x2-zj_w/60*13),trunc(y2-zj_H/60*12)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*6),trunc(y2-zj_H/60*30)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*5),trunc(y2-zj_H/60*28)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y2-zj_H/60*11)) ;
        //������   �۲�֧��
        Image.Canvas.MoveTo(trunc(x2),trunc(y2-zj_H/60*20)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*13),trunc(y2-zj_H/60*58)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*15),trunc(y2-zj_H/60*56)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*2),trunc(y2-zj_H/60*18)) ;
        Image.Canvas.LineTo(trunc(x2),trunc(y2-zj_H/60*20)) ;
        ////������   �۲�֧��
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*12),trunc(y1)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y1+zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y1)) ;

        if mc_h>2.5 then  begin
             //������  �۲�֧��
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*58),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*58),trunc(y1+zj_H/30*2)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*2)) ;
            // //����  �۲�֧��
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*58),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1+zj_H/30*13)) ;
            Image.Canvas.LineTo(trunc(x1+zj_w/60*1),trunc(y1+zj_H/30*13)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*57),trunc(y1+zj_H/30*2)) ;

        end else begin
             //������  �۲�֧��
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1+zj_H/30*2)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*2)) ;
        end;
         //����  �۲�֧��
        if lizhushu=2 then  begin  // ������   �۲�֧��
           if mc_h>=4.0 then  begin  // ˫����  �۲�֧��
                 // ����Ͳ  �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*23);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*27);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*31);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*27);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // ����Ͳ  �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*27.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*31.5);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*34.5);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*30.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // ����Ͳ  �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*32);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*34);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*36);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*34);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end else begin  // // ������   �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*23);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*27);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*31);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*27);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // ����Ͳ    �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*28);       Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*31);       Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*33);       Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*30);       Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end;    //end  if zj_h> 40 then  begin  // ˫����  �۲�֧��

        end else begin   // ������  �۲�֧��
               if mc_h>=4.0 then  begin  // ˫����  �۲�֧��
                 // ��������Ͳ �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*14);                  Points[0].Y:=trunc(y2-zj_H/60*9);
                 Points[1].X:=trunc(x2-zj_w/60*14);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*18);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*18);                  Points[3].Y:=trunc(y2-zj_H/60*9);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // ����������Ͳ  �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*14.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*14.5);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*17.5);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*17.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // ����������Ͳ �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*15);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*15);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*17);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*17);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);
                 // ǰ������Ͳ  �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*26);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*29);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*33);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*30);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // ǰ������Ͳ   �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*29.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*32);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*35);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*32.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // ǰ������Ͳ �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*32.5);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*34);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*36);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*34.5);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end else begin  // // ������  �۲�֧��
                 // ���� ����Ͳ   �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*14);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*14);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*18);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*18);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // ���� ����Ͳ  �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*15);       Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*15);       Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*17);       Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*17);       Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);
                  // ǰ������Ͳ   �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*26);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*29);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*33);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*30);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                  Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                    // ǰ������Ͳ �۲�֧��
                 Points[0].X:=trunc(x2-zj_w/60*30);                  Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*32);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*34);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*32);                  Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end;    //end  if zj_h> 40 then  begin  // ˫����
        end;  //end ������Ŀ
        //��������ʯ   �۲�֧��
        //�϶�        �۲�֧��
         {  Points[0].X:=trunc(x2-zj_w/60*8);                  Points[0].Y:=trunc(y1);
           Points[1].X:=trunc(x2-zj_w/60*10);                 Points[1].Y:=trunc(y2-zj_H/60*50);
           Points[2].X:=trunc(x2);                            Points[2].Y:=trunc(y2-zj_H/60*20);
           Points[3].X:=trunc(x2);                            Points[3].Y:=trunc(y1);
           Image.Canvas.Brush.Bitmap:=nil;
           Image.Canvas.Polygon(Points) ;
           bitmap1:=Tbitmap.Create;//����λͼ bitmap1
          // if  fileexists(dll_Path+'\BmpSi\��ʯ.Bmp') then  begin
          //            bitmap1.LoadFromFile(dll_Path+'\BmpFZ\��ʯ.Bmp');//װ��ͼ���ļ�
           bitmap1.LoadFromFile('C:\��ʯ.Bmp');//װ��ͼ���ļ�
           Image.Canvas.Brush.Bitmap:=bitmap1;
           Image.Canvas.FloodFill( Points[0].X+3,Points[0].Y+1,$000000,fsBorder);
           Image.Canvas.Brush.Bitmap:=nil;
            //�¶�   �۲�֧��
           Points[0].X:=Points[2].X;                         Points[0].Y:=Points[2].Y;
           Points[1].X:=trunc(x2-zj_w/60*3);                 Points[1].Y:=trunc(y2-zj_H/60*6);
           Points[2].X:=trunc(x2-zj_w/60*3);                 Points[2].Y:=trunc(y2);
           Points[3].X:=trunc(x2);                           Points[3].Y:=trunc(y2);
           Image.Canvas.Polygon(Points) ;
           bitmap1:=Tbitmap.Create;//����λͼ bitmap1
           bitmap1.LoadFromFile(dll_Path+'\BmpSi\��ʯ.Bmp');//װ��ͼ���ļ�

           Image.Canvas.Brush.Bitmap:=bitmap1;
           Image.Canvas.FloodFill( Points[2].X+1,Points[2].Y-1,$000000,fsBorder);
           Image.Canvas.Brush.Bitmap:=nil;
           bitmap1.free;
         }  
           //���ΰ����ͻ�
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*40),trunc(y2));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*52),trunc(y2));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*52),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y2-zj_H/60*1));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*41),trunc(y2-zj_H/60*1));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*41),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*40),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*40),trunc(y2));
    end else begin     //�۷�
          //������   //�۷�
        Image.Canvas.Pen.Width :=1;
        Image.Canvas.Pen.Color :=$000000;
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*40),trunc(y2));
        Image.Canvas.LineTo(trunc(x2-zj_w/60*13),trunc(y2));
        Image.Canvas.LineTo(trunc(x2-zj_w/60*13),trunc(y2-zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*16),trunc(y2-zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*16),trunc(y2-zj_H/60*9)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*20),trunc(y2-zj_H/60*9)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*20),trunc(y2-zj_H/60*12)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*23),trunc(y2-zj_H/60*12)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*24),trunc(y2-zj_H/60*8)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*40),trunc(y2-zj_H/60*8)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*40),trunc(y2));
        //������֧��   //�۷�
        Image.Canvas.Pen.Width :=1;
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*16),trunc(y2-zj_H/60*9)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*11),trunc(y2-zj_H/60*25)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y2-zj_H/60*25)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*17),trunc(y2-zj_H/60*9)) ;

        Image.Canvas.MoveTo(trunc(x2-zj_w/60*21),trunc(y2-zj_H/60*11)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*16),trunc(y2-zj_H/60*35)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*17),trunc(y2-zj_H/60*35)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*22),trunc(y2-zj_H/60*12)) ;
        //������   //�۷�
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*9),trunc(y2-zj_H/60*25)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*23),trunc(y2-zj_H/60*58)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*25),trunc(y2-zj_H/60*56)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*11),trunc(y2-zj_H/60*23)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*9),trunc(y2-zj_H/60*25)) ;
        //��β��   //�۷�
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*9),trunc(y2-zj_H/60*25)) ;
       // Image.Canvas.MoveTo(trunc(x2-zj_w/60*9),trunc(y2-zj_H/60*19)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*0),trunc(y2-zj_H/60*4)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*0),trunc(y2-zj_H/60*2)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*11),trunc(y2-zj_H/60*25)) ;
       ////������   //�۷�
        Image.Canvas.MoveTo(trunc(x2-zj_w/60*22),trunc(y1)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*22),trunc(y1+zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/60*6)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1)) ;
        Image.Canvas.LineTo(trunc(x2-zj_w/60*22),trunc(y1)) ;
         if mc_h>2.5 then  begin
             //������  //�۷�
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*58),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*58),trunc(y1+zj_H/30*2)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*2)) ;
            // //����   //�۷�
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*58),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1+zj_H/30*13)) ;
            Image.Canvas.LineTo(trunc(x1+zj_w/60*1),trunc(y1+zj_H/30*13)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*57),trunc(y1+zj_H/30*2)) ;

        end else begin
             //������   //�۷�
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*1)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*51),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1)) ;
            Image.Canvas.LineTo(trunc(x1),trunc(y1+zj_H/30*2)) ;
            Image.Canvas.LineTo(trunc(x2-zj_w/60*50),trunc(y1+zj_H/30*2)) ;
        end;


         //����   //�۷�
        if lizhushu=2 then  begin  // ������   //�۷�
           if mc_h>=4.0 then  begin  // ˫����  //�۷�
                 // ����Ͳ  //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*29);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*33);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*37);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*33);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // ����Ͳ //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*33.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*37.5);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*40.5);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*36.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // ����Ͳ   //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*38);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*40);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*42);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*40);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end else begin  // // ������  //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*29);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*33);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*37);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*33);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // ����Ͳ  //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*34);       Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*37);       Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*39);       Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*36);       Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end;    //end  if zj_h> 40 then  begin  // ˫���� //�۷�

        end else begin   // ������  //�۷�
               if mc_h>=4.0 then  begin  // ˫����    //�۷�
                 // ��������Ͳ  //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*24);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*24);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*28);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*28);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // ����������Ͳ   //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*24.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*24.5);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*27.5);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*27.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // ����������Ͳ   //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*25);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*25);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*27);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*27);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);
                 // ǰ������Ͳ  //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*34);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*37);                  Points[1].Y:=trunc(y2-zj_H/60*28);
                 Points[2].X:=trunc(x2-zj_w/60*41);                  Points[2].Y:=trunc(y2-zj_H/60*28);
                 Points[3].X:=trunc(x2-zj_w/60*38);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$000000;
                 Image.canvas.Polygon(points);

                  // ǰ������Ͳ   //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*37.5);                  Points[0].Y:=trunc(y2-zj_H/60*28);
                 Points[1].X:=trunc(x2-zj_w/60*40);                  Points[1].Y:=trunc(y2-zj_H/60*46);
                 Points[2].X:=trunc(x2-zj_w/60*43);                  Points[2].Y:=trunc(y2-zj_H/60*46);
                 Points[3].X:=trunc(x2-zj_w/60*40.5);                  Points[3].Y:=trunc(y2-zj_H/60*28);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // ǰ������Ͳ  //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*40.5);                  Points[0].Y:=trunc(y2-zj_H/60*46);
                 Points[1].X:=trunc(x2-zj_w/60*42);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*44);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*42.5);                  Points[3].Y:=trunc(y2-zj_H/60*46);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end else begin  // // ������ //�۷�
                 // ���� ����Ͳ //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*24);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*24);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*28);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*28);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                 Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                   // ���� ����Ͳ  //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*25);       Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*25);       Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*27);       Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*27);       Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);
                  // ǰ������Ͳ //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*34);                  Points[0].Y:=trunc(y2-zj_H/60*8);
                 Points[1].X:=trunc(x2-zj_w/60*37);                  Points[1].Y:=trunc(y2-zj_H/60*35);
                 Points[2].X:=trunc(x2-zj_w/60*41);                  Points[2].Y:=trunc(y2-zj_H/60*35);
                 Points[3].X:=trunc(x2-zj_w/60*38);                  Points[3].Y:=trunc(y2-zj_H/60*8);
                  Image.canvas.Brush.Color:=$008000;
                 Image.canvas.Polygon(points);

                    // ǰ������Ͳ  //�۷�
                 Points[0].X:=trunc(x2-zj_w/60*38);                  Points[0].Y:=trunc(y2-zj_H/60*35);
                 Points[1].X:=trunc(x2-zj_w/60*40);                  Points[1].Y:=trunc(y2-zj_H/60*54);
                 Points[2].X:=trunc(x2-zj_w/60*42);                  Points[2].Y:=trunc(y2-zj_H/60*54);
                 Points[3].X:=trunc(x2-zj_w/60*40);                  Points[3].Y:=trunc(y2-zj_H/60*35);
                 Image.canvas.Brush.Color:=$0000FF;
                 Image.canvas.Polygon(points);

            end;    //end  if zj_h> 40 then  begin  // ˫����    //�۷�
        end;  //end ������Ŀ  //�۷�
        //��������ʯ  //�۷�
        //�϶�
           //������   //�۷�
         {  Points[0].X:=trunc(x2-zj_w/60*22);                  Points[0].Y:=trunc(y1);
           Points[1].X:=trunc(x2-zj_w/60*22);                 Points[1].Y:=trunc(y2-zj_H/60*55);
           Points[2].X:=trunc(x2);                            Points[2].Y:=trunc(y2-zj_H/60*4);
           Points[3].X:=trunc(x2);                            Points[3].Y:=trunc(y1);
           Image.Canvas.Brush.Bitmap:=nil;
           Image.Canvas.Polygon(Points) ;
           bitmap1:=Tbitmap.Create;//����λͼ bitmap1
           bitmap1.LoadFromFile(dll_Path+'\BmpSi\ú.Bmp');//װ��ͼ���ļ�

           Image.Canvas.Brush.Bitmap:=bitmap1;
           Image.Canvas.FloodFill( Points[0].X+3,Points[0].Y+1,$000000,fsBorder);
           Image.Canvas.Brush.Bitmap:=nil;
           bitmap1.Free;  }
            //���ΰ����ͻ�
            Image.Canvas.MoveTo(trunc(x2-zj_w/60*45),trunc(y2));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*55),trunc(y2));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*55),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*54),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*54),trunc(y2-zj_H/60*1));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*46),trunc(y2-zj_H/60*1));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*46),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*45),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*45),trunc(y2));

            Image.Canvas.MoveTo(trunc(x2-zj_w/60*2),trunc(y2));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y2));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*12),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*11),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*11),trunc(y2-zj_H/60*1));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*3),trunc(y2-zj_H/60*1));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*3),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*2),trunc(y2-zj_H/60*3));
            Image.Canvas.LineTo(trunc(x2-zj_w/60*2),trunc(y2));


    end;   //end  //�۷�

 //=============
end;
 //==========================
 function TCal_show.DrawZcyl(Image:TImage;P1,P2:TPoint;zcyl:Str_Dt_array;bl:double;left_right:bool):WordBool;  //��֧��ѹ������
  var
   Zcyl_d :array [0..4] of double;
   px,py: array [0..21] of double;
   Lu_x,Lu_y: array [0..300] of double;
   Num,Lu_n,i:integer;
   L_x,L_y:double;
   Y_bl: double;
   l_x_fort,sub_x:double;
   while_false:bool;
 begin
     L_y:=P2.y-P1.y;
     for I := 0 to 4 do  begin
        Zcyl_d[i]:=StrToFloat(zcyl[i]);  
     end;
     if left_right then  bl:=-bl;

      Y_bl:=L_y/zcyl_d[2];
            px[0]:=P2.X;                     py[0]:=P2.y;
            px[1]:=P2.X-zcyl_d[1]*bl/2;      py[1]:=P2.y-(zcyl_d[0]*Y_bl);
            px[2]:=P2.X-zcyl_d[1]*bl;        py[2]:=P2.y-(zcyl_d[0]*Y_bl/3);
            px[3]:=P2.X-zcyl_d[3]*bl/2;      py[3]:=P2.y-(zcyl_d[2]*Y_bl*3/6);
            px[4]:=P2.X-zcyl_d[3]*bl*2/3;    py[4]:=P2.y-(zcyl_d[2]*Y_bl*5/6);
            px[5]:=P2.X-zcyl_d[3]*bl;        py[5]:=P2.y-(zcyl_d[2]*Y_bl);
            px[6]:= px[5]-(zcyl_d[4]-zcyl_d[3])*bl*1/12;     py[6]:=P2.y-(((zcyl_d[2]-1)*5/6+1)*Y_bl);
            px[7]:= px[5]-(zcyl_d[4]-zcyl_d[3])*bl*2/12;      py[7]:=P2.y-(((zcyl_d[2]-1)*9/12+1)*Y_bl);
            px[8]:= px[5]-(zcyl_d[4]-zcyl_d[3])*bl*3/12;     py[8]:=P2.y-(((zcyl_d[2]-1)*8/12+1)*Y_bl);
            px[9]:= px[5]-(zcyl_d[4]-zcyl_d[3])*bl*4/12;      py[9]:=P2.y-(((zcyl_d[2]-1)*7/12+1)*Y_bl);
            px[10]:=px[5]-(zcyl_d[4]-zcyl_d[3])*bl*5/12;    py[10]:=P2.y-(((zcyl_d[2]-1)*6/12+1)*Y_bl);
            px[11]:= px[5]-(zcyl_d[4]-zcyl_d[3])*bl*6/12;      py[11]:=P2.y-(((zcyl_d[2]-1)*5/12+1)*Y_bl);
            px[12]:= px[5]-(zcyl_d[4]-zcyl_d[3])*bl*7/12;      py[12]:=P2.y-(((zcyl_d[2]-1)*4/12+1)*Y_bl);
            px[13]:= px[5]-(zcyl_d[4]-zcyl_d[3])*bl*8/12;      py[13]:=P2.y-(((zcyl_d[2]-1)*3/12+1)*Y_bl);
            px[14]:= px[5]-(zcyl_d[4]-zcyl_d[3])*bl*9/12;      py[14]:=P2.y-(((zcyl_d[2]-1)*2/12+1)*Y_bl);
            px[15]:= px[5]-(zcyl_d[4]-zcyl_d[3])*bl*10/12;      py[15]:=P2.y-(((zcyl_d[2]-1)*1/12+1)*Y_bl);
            px[16]:= px[5]-(zcyl_d[4]-zcyl_d[3])*bl*11/12;    py[16]:=P2.y-(1*Y_bl);
            px[17]:= P2.X-zcyl_d[4]*bl;         py[17]:=P2.y-(1*Y_bl);
            
            if left_right then   begin
                  if Px[17]> P1.x then   Px[17]:= P1.x ;
            end else begin
                  if Px[17]< P1.x then   Px[17]:= P1.x ;
            end;              

           Public_Basic.lu_spline(px,py,18,lu_x,Lu_y,Lu_n);
           Image.Canvas.Pen.Color:=clred;
           Image.Canvas.MoveTo(trunc(lu_x[0]),trunc(lu_y[0]));
           for I := 1 to lu_n-1 do begin
               Image.Canvas.LineTo(trunc(lu_x[i]),trunc(lu_y[i]))
           end;
           Image.Canvas.LineTo(p1.x,trunc(py[4])) ;
       //��֧��ѹ���ߵ� ��ֱ��ͷ
        l_x_fort:=lu_x[0];
       for i := 0 to lu_n-1 do begin
          sub_x:=abs(lu_x[i]-l_x_fort);
          if sub_x>=8 then  begin
             Image.Canvas.MoveTo(trunc(lu_x[i]),trunc(lu_y[i]));
             Image.Canvas.LineTo(trunc(lu_x[i]),p2.y);
             l_x_fort:=lu_x[i];
          end;
       end;
       while_false:=true;
       while while_false do  begin
          if left_right then  begin
           if l_x_fort<p1.x then begin
             Image.Canvas.MoveTo(trunc(l_x_fort),trunc(lu_y[Lu_n-1]));
             Image.Canvas.LineTo(trunc(l_x_fort),p2.y);
             l_x_fort:=l_x_fort+8;
           end else begin
             while_false:=false;
           end;
          end else begin
               if l_x_fort>p1.x then begin
                 Image.Canvas.MoveTo(trunc(l_x_fort),trunc(lu_y[Lu_n-1]));
                 Image.Canvas.LineTo(trunc(l_x_fort),p2.y);
                 l_x_fort:=l_x_fort-8;
               end else begin
                 while_false:=false;
               end;
          end;

       end;


     result:=true;
 end;
 //====================================================
 {



 }
  function TCal_show.Draw_YLG(Image:TImage;L1,L2,R1,R2:TStringList):WordBool;
  var
     i,j,k,t :integer;
     p1x,p1y: array [0..60] of double;
     p2x,p2y: array [0..60] of double;
     p1_x,p1_y,p2_x,P2_y: array [0..300] of double;
     while_t:bool;
     count1,count2,Lu_1,LU_2 :integer;
     temp1,temp2 :Str_Dt_array;
     LD_1,lD_2:double;
     LD_1_C,Ld_2_c: integer;
  begin
       while_t:=true;  t:=1;
       while while_t do  begin
          if L1.Count/t>29 then  begin
            t:=t+1;
          end else begin
            while_t:=false;
          end;

       end; //end while
     k:=0;
     for i := 0 to round(L1.Count/t) -1 do  begin
         if i mod t =0  then begin
             temp1:=Public_Basic.split(L1[i],',',Count1);
                 p1x[k]:=strTofloat(temp1[0]);
                 p1y[k]:=strTofloat(temp1[1]);

             temp2:=Public_Basic.split(L2[i],',',Count2);
                 p2x[k]:=strTofloat(temp2[0]);
                 p2y[k]:=strTofloat(temp2[1]);

             K:=K+1;
         end;
     end;


     for j := 0 to round(R1.Count/t) -1 do  begin
         if j mod t =0  then begin
             temp1:=Public_Basic.split(R1[j],',',Count1);
                 p1x[k]:=strTofloat(temp1[0]);
                 p1y[k]:=strTofloat(temp1[1]);

             temp2:=Public_Basic.split(R2[j],',',Count2);
                 p2x[k]:=strTofloat(temp2[0]);
                 p2y[k]:=strTofloat(temp2[1]);
             K:=K+1;
         end;
     end;
     // spline
     Public_Basic.lu_spline(p1x,p1y,K,p1_x,p1_y,Lu_1);
     Public_Basic.lu_spline(p2x,p2y,K,p2_x,p2_y,Lu_2);
     //������
      Image.Canvas.Pen.Color:=clRed;
      Image.Canvas.MoveTo(trunc(p1_x[0]),trunc(p1_y[0]));
     for i := 0 to Lu_1 - 1 do  begin
        Image.Canvas.LineTo(trunc(p1_x[i]),trunc(p1_y[i]));
     end;
       Image.Canvas.MoveTo(trunc(p2_x[0]),trunc(p2_y[0]));
     for i := 0 to Lu_2 - 1 do  begin
        Image.Canvas.LineTo(trunc(p2_x[i]),trunc(p2_y[i]));
     end;
     //������
      Image.Canvas.Pen.Color:=clgreen;
     LD_1_C:=0;
     for I := 1 to Lu_1  - 1 do   begin
         LD_1:=sqrt((p1_x[i]-P1_x[LD_1_C]) *(p1_x[i]-P1_x[LD_1_C])+(p1_y[i]-P1_y[LD_1_C])*(p1_y[i]-P1_y[LD_1_C]));
         if LD_1>10  then   begin
               LD_2_C:=I;
               for j :=  I to Lu_2 - 1 do  begin
                    LD_2:=sqrt((p2_x[j]-P2_x[LD_2_C]) *(p2_x[j]-P2_x[LD_2_C])+(p2_y[j]-P2_y[LD_2_C])*(p2_y[j]-P2_y[LD_2_C]));
                    if Ld_2 >10 then  begin
                       Image.Canvas.MoveTo(trunc(p1_x[i]),trunc(p1_y[i]));
                       Image.Canvas.lineto(trunc(p2_x[j]),trunc(p2_y[j]));
                       LD_1_C:=i;
                       break;
                    end;
               end; //end for j
         end;

     end;  // end for i

     Image.Canvas.Pen.Color:=clblack;
  end;


//==================================================
  {*------
   ���ƽ���ģ�⿪��
   @Image_Out:TImage;   //�ⲿ��ʾͼƬ�� image
    @JinChi,            �ۼƵĽ���
    @X_pan_move:double;  ͼƬƽ�Ƶ�����
    @Tuxing,             �Ҳ����ͼ�ε�����  1 Ϊ ��׼ 1 Ϊ����
    @disp_two_tu,        ��ʾ����ͼ  0 ֻ��ʾ �ƽ����� 1 ��ʾ �ƽ���������б����
    @disp_ylg:integer;    �Ƿ���ʾ֧��ѹ����  0 ����ʾ 1 ��ʾ
    @NQ_step:String;      ���������ķ�ʽ  �������벽�෨
    @gzm:TG_stope;         ���������
    @Zk:Tzk_bore;           ��׵���
   @ ZhiJia:TZJ_Class;      ֧�ܵ���
   @ imm:TImmediate_roof;   ֱ�Ӷ�����
   @ old:Told_roof          �϶�����
    @ return                ����ֵΪ ͼƬ��ƽ������ ��   X_pan_move
  }
function TCal_show.DrawFyyd(Image_Out:TImage;JinChi,X_pan_move:double;Tuxing,disp_two_tu,disp_ylg:integer;NQ_step:String;gzm:TG_stope;Zk:Tzk_bore;ZhiJia:TZJ_Class;imm:TImmediate_roof;old:Told_roof):Integer;//��������֮��ĺ���
   var
     Y_text_H,Y_text_bl :double;     //��Y �������ָ߶�  �����
     Y_tu_H,Y_tu_Bl :double;     //  �� ����ͼ�θ߶�  �����
     X_wid,X_bl: double; // x ������ܿ��� �����
     ShiYong_bl:double; //��ͼ��ʹ�õı���
     i,j,k     :integer;   //  ��ʱ����
     TitleText :Widestring; //����
     Pointxy,Point_t_P,P_i_j_1,Point_wk  :Array [0..3] of TPoint; //  ���������α���    4����
     Point_Six_P,Point_Six_P_2,Point_Six_Right  :Array [0..5] of TPoint; //  ���Ʋ�����ͼ���������   6����
     bitmap,BitM   :tbitmap;//����λͼ����
     Image_Inn:TImage;

     s_out:Widestring;//
     ZtPoint :Array [0..3] of Tpoint;//֧�в��������

     TopBlank,BottomBlank: integer;  //ͼƬ���µĿհ�
     LeftBlank,RightBlank:integer;   // ͼƬ���ҵĿհ�

     Yc_End_Nu :integer; //   ������һ���Ҳ�ı��
     Left_Baoliu_wid,Right_Baoliu_wid: double; //ͼ��������Ҳౣ��ͼ�εĿ���
     XianShi_kc_wid:double; //��ʾ����ú��Ŀ���
     t_Rec     :TRect;// ��Ϊ���֧�ܵĹ���
     temp_zcyl_sx:double; //��ʱ����֧��ѹ���ֲ���Χ
     jpg: TJPEGImage;
     Zj_lizhu,zc_fd: integer; //��¼֧���������ú����
     ZhiJIa_Zl_xs:double;//֧������ϵ��
     temp1 :Str_Dt_array;  //�ʷ���֧��
     Count1:integer;     //�ʷ���֧�ܱ���
     inn_left_y0,inn_left_y2,inn_left_x2,inn_right_y0,inn_right_y2,inn_Right_x2 :integer;  //��¼inn ����λ��
     out_right_y0,out_left_y0,out_left_y1:integer;  //��¼out����λ��
     Old_Beam:array[0..4] of TYL_beam; //�����������ʽ
     dll_Path:widestring; //�ؼ�
     HanziHeight:Integer;//���ֵĸ߶�
     Yl_name_count:Integer; //�����ĸ���
     Table_Title_H:integer;//��ͷ�ĸ߶�
     tu_max_width:integer; //�������Ŀ���
     X_move_Pix:Integer;//  ������X�����ƶ���ֵ
     X_Text_height:integer;//X������ ���֤θ߶�
     YanCengQingJiao,JinChi_sup,Used_h,Step0:double; //�Ҳ���ǣ�����ʣ�����
     ganshi_Y0,ganshi_Y1,ganshi_Y2,ganshi_right_x4,ganshi_Count:integer;// ��¼��ʯ��ֹ���Ҳ���
     ganshi_h:double; //��¼��ʯ�ĸ߶�
     YockLiang_Suo,while_j_sup_jinchi,Rock_sa,step_i:double; //���������ľ���
     while_j,while_image:wordbool;//while ѭ������
     Zjd_Wt: integer; //ֱ�Ӷ���λ̬
     Image_fill_P:TPoint;//ͼ�����ĵ�
     break_i_105:integer;//break_i_105
     Sink_Sa_used: double;//����Ƕȼ�����³���
     t_Str_Fir,t_Str_sec:TStringList;// �ַ�����
     Y_min,Sink_leixing: integer; //�±�ΪС�ñ���
     Zcyl_l_p1,zcyl_l_P2,Zcyl_R_p1,zcyl_R_P2:TPoint; //֧��ѹ���ߵ�����
     alert_p1,alert_p2 :TPoint; //Ԥ���� ��λ������
     Alert_str:string ;// Ԥ�������
     YLG_L1,YLG_L2,YLG_R1,YLG_R2:TStringList;//��¼ ѹ���� ������
begin

  //ȡ��Dll����·��
      dll_Path:=zhijia.OcxPath ;
     // ShowMessage(dll_Path);
      bitmap:=Tbitmap.Create;  //����λͼ bitmap1
      bitM:=Tbitmap.Create;
      t_Str_Fir:=TStringList.Create ;
      t_Str_sec:=TStringList.Create;
      YLG_L1:=TStringList.Create;
      YLG_L2:=TStringList.Create;
      YLG_R1:=TStringList.Create;
      YLG_R2:=TStringList.Create;
      //��ʼ��ѹ���� ����
      YLG_L1.Clear ; YLG_L2.Clear ;YLG_R2.Clear ;YLG_R2.Clear ;
      //��ʼ��֧������ϵ��
      if JinChi<zk.Yc_Rock[old.YL_start].Step0 then  begin
          ZhiJIa_Zl_xs:=1;
      end else begin
           if ZhiJia.zj_toall_P < ZhiJia.Zj_imm_p *1.5 then  begin
                ZhiJIa_Zl_xs:=0.7;
            end  else  if ZhiJia.zj_toall_P < ZhiJia.Zj_JiSuan_Ci_P[2] then  begin
                ZhiJIa_Zl_xs:=0.8;
            end else if ZhiJia.zj_toall_P < ZhiJia.Zj_JiSuan_C0_P[2] then  begin
                ZhiJIa_Zl_xs:=0.9;
            end else begin
                ZhiJIa_Zl_xs:=1;
            end;
      end;

       //������
      if NQ_step='1' then begin   //1 ���� �㷨
            TitleText:=Gzm.S_Name+',���:'+zk.Zk_name+' ���(�����㷨):֧��������ϵͼ';
            for I := 0 to 4 do
               Old_beam[i]:=zk.Beam_Def[i] ;
      end else begin          //�����㷨
            TitleText:=Gzm.S_Name+',���:'+zk.Zk_name+' ���(�����㷨):֧��������ϵͼ';
             for I := 0 to 4 do
                Old_beam[i]:=zk.Beam_step[i] ;
      end;
     TitleText:=Gzm.S_Name+',���:'+zk.Zk_name+' ���(�����㷨):֧��������ϵͼ';

      //�ж������ĸ߶�
      if old.YL_struc =1 then  begin    // ������
           for k := 1 downto 0 do
             if Old_beam[k].End_Yc_NO >0 then begin
                   Yc_End_Nu:=Old_beam[k].End_Yc_NO;
                   Yl_name_count:=k+1;
                   break;
              end;  //end if
      end else begin          //������
          for k := 1 downto 0 do
             if Old_beam[k].End_Yc_NO >0 then begin
                   Yc_End_Nu:=Old_beam[k].End_Yc_NO;
                   Yl_name_count:=k+1;
                   break;
              end;  //end if
      end;
    //��ʼ��������ʼ
    if model_l=0 then    begin
       model_start_yc:=0;
    end else if  model_l=1 then    begin
       if old.yl_max_End-2 >0  then  begin
          model_start_yc:=old.yl_max_End-2;
       end else begin
          model_start_yc:=0;
       end;
    end else if  model_l=2 then    begin
          model_start_yc:=Yc_End_Nu;
    end;
      //ShowMessage(IntTostr(model_start_yc));
     //�հױ߽��ʼ��
     TopBlank:=trunc(Image_out.Height/30)+40 ;BottomBlank:=trunc(Image_out.Height/30)+20;
     LeftBlank:=trunc(Image_out.Width/30)+120;RightBlank:=trunc(Image_out.Width/30)+50;
     HanziHeight:=15; Table_Title_H:=15;X_Text_height:=30;
     ganshi_Count:=0;
     X_move_pix:=Trunc(X_pan_move);



      Y_tu_H:=0;
       Yl_name_count:=1;
      for I:=zk.main_coal downto model_start_yc do  begin
            Yl_name_count:=Yl_name_count+1;
            if I=zk.main_coal then  begin
                 Y_tu_H:=Y_tu_H+zk.Yc_Rock[i].R_h*gzm.Mc_FdBs;
            end else begin
                 if i<old.yl_max_End -2 then    begin
                    Y_tu_H:=Y_tu_H+zk.Yc_Rock[i].R_h*hcd_bl;
                 end else begin
                    Y_tu_H:=Y_tu_H+zk.Yc_Rock[i].R_h;
                 end;


            end;
      end; //end for i

       //�жϿɲ�ú���Ƿ����һ��
      if zk.main_coal<zk.Zk_Yc_Count-1 then  begin
                 Y_tu_H:=Y_tu_H+zk.Yc_Rock[ zk.main_coal+1].R_h;
             end else begin
                 Y_tu_H:=Y_tu_H+3; //Ĭ��3�׵ķ�ɰ��
             end;
       // �������
           
           while_j:=true;
           while while_j do  begin
                if Image_out.Height-TopBlank-BottomBlank-X_Text_height-40-Table_Title_H-(Yl_name_count)*HanziHeight< 0 then  begin
                    HanziHeight:=HanziHeight-1;
                end else begin
                    while_j:=false;
                end;

          end;

       Y_Text_Bl:=(Image_out.Height-TopBlank-BottomBlank-X_Text_height-40-Table_Title_H-(Yl_name_count)*HanziHeight)/Y_tu_H;



      Y_tu_BL:=(Image_out.Height-TopBlank-BottomBlank-X_Text_height-40)/Y_tu_H;
   //   Y_Text_Bl:=(Image_out.Height-TopBlank-BottomBlank-X_Text_height-40-(zk.Zk_Yc_Count-Yc_End_Nu+2)*HanziHeight)/Y_tu_H;
     //���image
      Image_out.Picture.Graphic:=nil;
        Image_out.Canvas.Refresh;
        Image_out.Canvas.FillRect(Image_out.ClientRect); 

      //�ɸߴ�������Ҳ�߶ȵĴ���   2016.505
        if zk.Yc_Rock[zk.main_coal].R_h< gzm.S_Cg_h then   gzm.S_Cg_h:=zk.Yc_Rock[zk.main_coal].R_h  ;


      //д����
      Image_out.Canvas.Font.Size := 18;
      Image_out.Canvas.TextOut(trunc(Image_out.Width/2-300),trunc(10),TitleText);
     //��������

       Image_out.Canvas.MoveTo(LeftBlank,TopBlank-Table_Title_H+40);
       Image_out.Canvas.LineTo(LeftBlank,Image_out.Height-BottomBlank-X_Text_height);
       Image_out.Canvas.LineTo(LeftBlank-120,Image_out.Height-BottomBlank-X_Text_height);

       Image_out.Canvas.MoveTo(LeftBlank-120,TopBlank-Table_Title_H+40-1);
       Image_out.Canvas.LineTo(LeftBlank-120,Image_out.Height-BottomBlank-X_Text_height);
       Image_out.Canvas.MoveTo(LeftBlank-60,TopBlank-Table_Title_H-1+40);
       Image_out.Canvas.LineTo(LeftBlank-60,Image_out.Height-BottomBlank-X_Text_height);
       Image_out.Canvas.MoveTo(LeftBlank-30,TopBlank-Table_Title_H-1+40);
       Image_out.Canvas.LineTo(LeftBlank-30,Image_out.Height-BottomBlank-X_Text_height);
       Image_out.Canvas.MoveTo(LeftBlank-120,TopBlank-Table_Title_H-1+40);
       Image_out.Canvas.LineTo(LeftBlank,TopBlank-Table_Title_H-1+40);   

      //===�Ҳ�����

       Image_out.Canvas.Font.Size := 9;
       Image_out.Canvas.TextOut(LeftBlank-118,TopBlank-Table_Title_H+40,'�Ҳ�����');
       Image_out.Canvas.TextOut(LeftBlank-58,TopBlank-Table_Title_H+40,'���');
       //x����ı���
       X_bl:=(Image_out.Width-LeftBlank-RightBlank)/(Old_beam[0].Step_0_Simple+Old_beam[0].step_i_simple[1]+gzm.ZCYL_sx[0]+gzm.ZCYL_sx[2]);

         shiyong_bl:=Y_tu_BL* self.Zomm_D ;
         if Y_Text_Bl>shiyong_bl  then    Y_Text_Bl:=shiyong_bl ;

       tu_max_width:=trunc((gzm.ZCYL_sx[0]+gzm.ZCYL_sx[1]+gzm.S_L_qx*3)*shiyong_bl);  
         //����Image_inn
         Image_inn:=TImage.Create(nil);
         Image_inn.Width :=tu_max_width;
         Image_inn.Height :=Image_out.Height-topBlank-BottomBlank;
         //Image_inn.Picture.Graphic.assign(nil);
         Image_inn.Picture.Graphic:=nil;
         Image_inn.Canvas.Refresh;
         Image_inn.Canvas.FillRect(Image_inn.ClientRect);
         image_inn.Canvas.Pen.Color :=clBlack;  
         Image_inn.Canvas.MoveTo(0,Image_inn.Height);  // ����
         Image_inn.Canvas.LineTo(Image_inn.Width ,Image_inn.Height);
         //�ʷ�֧��ѹ�� ��ֵ
          temp1:=Public_Basic.split(Gzm.Return_Zcyl('2.0',Jinchi,zk),';',Count1);
          bitmap.FreeImage;
         //���װ�
         if  zk.main_coal=zk.Zk_Yc_Count-1  then  begin // û�еװ�
                Pointxy[0].X :=0;
                Pointxy[0].Y :=Image_inn.Height-X_Text_height-trunc(3*shiyong_bl);
                Pointxy[1].X :=Image_inn.Width;
                Pointxy[1].Y :=Pointxy[0].Y;
                Pointxy[2].X :=Pointxy[1].X  ;
                Pointxy[2].Y :=Image_inn.Height-X_Text_height;
                Pointxy[3].X :=Pointxy[0].X ;
                Pointxy[3].Y :=Pointxy[2].Y ;
                Image_inn.Canvas.Brush.Bitmap:=nil;
             //���ͼ��
                if Tuxing=0 then   begin
                  if  fileexists(dll_Path+'\BmpSi\��ɰ��.Bmp') then  begin
                      bitmap.LoadFromFile(dll_Path+'\BmpSi\��ɰ��.Bmp');//װ��ͼ���ļ�
                  end else begin
                      bitmap.LoadFromFile(dll_Path+'\BmpSi\NULL.Bmp');
                  end;

                end else begin
                    if  fileexists(dll_Path+'\BmpFz\��ɰ��.Bmp') then  begin
                      bitmap.LoadFromFile(dll_Path+'\BmpFZ\��ɰ��.Bmp');//װ��ͼ���ļ�
                    end else begin
                      bitmap.LoadFromFile(dll_Path+'\BmpFz\NULL.Bmp');
                    end;

                end;
                Image_out.Canvas.MoveTo(LeftBlank-120,trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-3*Y_Text_Bl));
                Image_out.Canvas.LineTo(LeftBlank-30,trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-3*Y_Text_Bl));
                Image_out.Canvas.TextOut(LeftBlank-118,trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-3*Y_Text_Bl/2),'��ɰ��');
                Image_out.Canvas.TextOut(LeftBlank-58,trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-3*Y_Text_Bl/2),'3');
                //��б��
                Image_out.Canvas.MoveTo(LeftBlank-30,trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-3*Y_Text_Bl));
                Image_out.Canvas.LineTo(LeftBlank, Image_out.Height-BottomBlank-X_Text_height-trunc(3*shiyong_bl));
                out_left_y0:=trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-3*Y_Text_Bl);
                out_left_y1:= Image_out.Height-BottomBlank-X_Text_height-trunc(3*shiyong_bl);
            end else begin    //�Ҳ�¼���еװ�
                if zk.Yc_Rock[zk.main_coal+1].R_h <3 then zk.Yc_Rock[zk.main_coal+1].R_h:=3;
                Pointxy[0].X :=0 ;
                Pointxy[0].Y :=Image_inn.Height-X_Text_height-trunc(zk.Yc_Rock[zk.main_coal+1].R_h*shiyong_bl);
                Pointxy[1].X :=Image_inn.Width ;
                Pointxy[1].Y :=Pointxy[0].Y;
                Pointxy[2].X :=Pointxy[1].X  ;
                Pointxy[2].Y :=Image_inn.Height-X_Text_height;
                Pointxy[3].X :=Pointxy[0].X ;
                Pointxy[3].Y :=Pointxy[2].Y ;
                Image_inn.Canvas.Brush.Bitmap:=nil;
             //���ͼ��
                if Tuxing=0 then   begin
                  if  fileexists(dll_Path+'\BmpSi\'+zk.Yc_Rock[zk.main_coal+1].R_Name+'.Bmp') then  begin
                      bitmap.LoadFromFile(dll_Path+'\BmpSi\'+zk.Yc_Rock[zk.main_coal+1].R_Name+'.Bmp');//װ��ͼ���ļ�
                  end else begin
                      bitmap.LoadFromFile(dll_Path+'\BmpSi\NULL.Bmp');
                  end;

                end else begin
                    if  fileexists(dll_Path+'\BmpFZ\'+zk.Yc_Rock[zk.main_coal+1].R_Name+'.Bmp') then  begin
                      bitmap.LoadFromFile(dll_Path+'\BmpFZ\'+zk.Yc_Rock[zk.main_coal+1].R_Name+'.Bmp');//װ��ͼ���ļ�
                    end else begin
                      bitmap.LoadFromFile(dll_Path+'\BmpFz\NULL.Bmp');
                    end;

                end;
                Image_out.Canvas.MoveTo(LeftBlank-120,trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-zk.Yc_Rock[zk.main_coal+1].R_h*Y_Text_Bl));
                Image_out.Canvas.LineTo(LeftBlank-30,trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-zk.Yc_Rock[zk.main_coal+1].R_h*Y_Text_Bl));
                Image_out.Canvas.TextOut(LeftBlank-118,trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-zk.Yc_Rock[zk.main_coal+1].R_h*Y_Text_Bl/2),zk.Yc_Rock[zk.main_coal+1].R_Name);
                Image_out.Canvas.TextOut(LeftBlank-58,trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-zk.Yc_Rock[zk.main_coal+1].R_h*Y_Text_Bl/2),FormatFloat('0.0',zk.Yc_Rock[zk.main_coal+1].R_h));
                //��б��
                Image_out.Canvas.MoveTo(LeftBlank-30,trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-zk.Yc_Rock[zk.main_coal+1].R_h*Y_Text_Bl));
                Image_out.Canvas.LineTo(LeftBlank, Image_out.Height-BottomBlank-X_Text_height-trunc(zk.Yc_Rock[zk.main_coal+1].R_h*shiyong_bl));
                out_left_y0:=trunc(Image_out.Height-BottomBlank-X_Text_height-hanziheight-zk.Yc_Rock[zk.main_coal+1].R_h*Y_Text_Bl);
                out_left_y1:=Image_out.Height-BottomBlank-X_Text_height-trunc(zk.Yc_Rock[zk.main_coal+1].R_h*shiyong_bl);
            end; //end   if  Yc_Xiabiao = zk.main_coal  then  begin // û�еװ�
             //������û�еװ壬�����
             Image_inn.Canvas.Polygon(Pointxy) ;
             Image_inn.Canvas.Brush.Bitmap:=bitmap;
               if   (Pointxy[2].Y-Pointxy[1].Y>4)  then
                    Image_inn.Canvas.FloodFill(Trunc((Pointxy[0].X+Pointxy[1].X)/2),Trunc((Pointxy[1].Y+Pointxy[2].Y)/2),clBlack,fsBorder);
              inn_left_y0:=  Pointxy[0].Y;
                 //���װ�б��
                Pointxy[0].X := Image_out.Width -RightBlank ;
                Pointxy[0].Y :=Image_out.Height-BottomBlank-Image_inn.Height+Pointxy[0].Y ;
                Pointxy[3].X := Pointxy[0].X ;
                Pointxy[3].Y := Image_out.Height-BottomBlank-X_Text_height ;

                Pointxy[1].X := Pointxy[0].X+40 ;
                Pointxy[1].Y := Pointxy[0].Y-40;

                Pointxy[2].X := Pointxy[3].X+40 ;
                Pointxy[2].Y := Pointxy[3].Y-40;
                Image_out.Canvas.Polygon(Pointxy) ;
                Image_out.Canvas.Brush.Bitmap:=bitmap;   // ͼƬ�ǵװ��ͼƬ
                 if   (Pointxy[2].Y-Pointxy[1].Y>4)  then
                        Image_Out.Canvas.FloodFill(Trunc(Pointxy[0].X+1),Trunc((Pointxy[0].Y+Pointxy[3].Y)/2),clBlack,fsBorder);
                Image_out.Canvas.Brush.Bitmap:=nil;
                out_right_y0:=Pointxy[0].Y ;
                //��־X ������
                 for I := 0 to round((gzm.S_L_qx*3)/10)-1 do
                 begin
                     image_inn.Canvas.MoveTo (trunc((gzm.ZCYL_sx[2]+i*10)*shiyong_bl),image_inn.Height-X_Text_height);
                     image_inn.Canvas.LineTo (trunc((gzm.ZCYL_sx[2]+i*10)*shiyong_bl),image_inn.Height-X_Text_height+5);
                     Image_inn.Canvas.TextOut(trunc((gzm.ZCYL_sx[2]+i*10)*shiyong_bl)+1,image_inn.Height-X_Text_height,Inttostr(i*10));
                 end;


           //ú��
            //��ú��
                    //���ͼ��
                   bitmap.FreeImage;
                   bitmap.LoadFromFile(dll_Path+'\BmpSi\ú.Bmp');//װ��ͼ���ļ�


                    //���
                      Point_Six_P[5].X :=0;
                           Point_Six_P[5].Y := inn_left_y0 ;
                      Point_Six_P[3].X :=Point_Six_P[5].X +trunc(gzm.ZCYL_sx[2]*shiyong_bl);
                           Point_Six_P[3].Y :=Point_Six_P[5].Y;
                      Point_Six_P[4].X :=Point_Six_P[3].X -trunc(StrToFloat(temp1[1])*shiyong_bl);
                           Point_Six_P[4].Y :=Point_Six_P[5].Y;
                      Point_Six_P[0].X :=Point_Six_P[5].X;
                           Point_Six_P[0].Y :=Point_Six_P[5].Y-trunc(gzm.S_Cg_h*gzm.Mc_FdBs*shiyong_bl);;
                      Point_Six_P[1].X :=Point_Six_P[4].X;
                           Point_Six_P[1].Y :=Point_Six_P[0].Y;
                      Point_Six_P[2].X :=Point_Six_P[3].X;
                           Point_Six_P[2].Y :=Point_Six_P[3].Y-trunc(gzm.S_Cg_h*ZhiJIa_Zl_xs*gzm.Mc_FdBs*shiyong_bl);;


                     Image_inn.Canvas.Brush.Bitmap:=nil;
                      Image_inn.Canvas.Polygon(Point_Six_P) ;
                      Image_inn.Canvas.Brush.Bitmap:=bitmap;    //ú��� ͼ��
                         if   (Point_Six_P[4].Y-Point_Six_P[1].Y>4)  then
                              Image_inn.Canvas.FloodFill(Trunc((Point_Six_P[0].X+Point_Six_P[3].X)/2),Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2),clBlack,fsBorder);
                      Image_inn.Canvas.Brush.Bitmap:=nil;
                       //

                      //��д���ѹ��������
                      if zk.Yc_Rock[zk.main_coal].R_h<= gzm.S_Cg_h then  begin
                            YLG_L1.Add(InttoStr(Point_Six_P[1].X)+','+InttoStr(Point_Six_P[1].Y) );
                            YLG_L2.Add(InttoStr(Point_Six_P[1].X-trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[1].Y) );
                      end;

                   //��֧��
                     if Gzm.S_cmfs='4' then begin
                          zc_fd :=2;
                     end else begin
                          zc_fd :=1;
                     end;
                     if ZhiJia.JG_jx='JX2' then begin
                         zj_lizhu:=2;
                     end else begin
                         zj_lizhu:=4;
                     end;
                   
                      zhijia.Draw_zhiJia(Image_inn,
                                      Point_Six_P[2].X+trunc((jinchi+zhijia.Zj_KongdingJU)*shiyong_bl),
                                      Point_Six_P[2].Y,
                                      Point_Six_P[3].X+trunc(jinchi*shiyong_bl),
                                      Point_Six_P[3].Y,
                                      Gzm.S_Cg_h, zj_lizhu, zc_fd);

                     ganshi_right_x4:=Point_Six_P[3].X+trunc((jinchi-zhijia.Zj_KongdingJU)*shiyong_bl);

                     //���ݽ���ȷ��X���ƶ�����   ��Ļ�����ƶ�
                      while  Image_out.Width-LeftBlank-RightBlank-Point_Six_P[2].X-trunc((jinchi+zhijia.Zj_KongdingJU)*shiyong_bl)+X_move_pix< Image_out.Width /30 do
                             X_move_pix:=X_move_pix+trunc(Image_out.Width/5);
                     //���ݽ���ȷ��X���ƶ�����   ��Ļ�����ƶ�
                      while  Image_out.Width-LeftBlank-RightBlank-Point_Six_P[2].X-trunc((jinchi+zhijia.Zj_KongdingJU)*shiyong_bl)+X_move_pix > Image_out.Width /30*22 do
                             X_move_pix:=X_move_pix-trunc(Image_out.Width/5);



                     //�Ҳ�ú��
                      Point_Six_P[5].X :=Image_inn.Width  ;
                            Point_Six_P[5].Y := inn_left_y0 ;
                      Point_Six_P[3].X :=Point_Six_P[2].X+trunc((jinchi+zhijia.Zj_KongdingJU)*shiyong_bl);
                           Point_Six_P[3].Y :=Point_Six_P[5].Y;
                      Point_Six_P[4].X :=Point_Six_P[3].X +trunc(StrToFloat(temp1[1])*shiyong_bl);
                           Point_Six_P[4].Y :=Point_Six_P[5].Y;
                      Point_Six_P[0].X :=Point_Six_P[5].X;
                           Point_Six_P[0].Y :=Point_Six_P[5].Y-trunc(gzm.S_Cg_h*gzm.Mc_FdBs*shiyong_bl);;
                      Point_Six_P[1].X :=Point_Six_P[4].X;
                           Point_Six_P[1].Y :=Point_Six_P[0].Y;
                      Point_Six_P[2].X :=Point_Six_P[3].X;
                           Point_Six_P[2].Y :=Point_Six_P[3].Y-trunc(gzm.S_Cg_h*ZhiJIa_Zl_xs*gzm.Mc_FdBs*shiyong_bl);

                      Image_inn.Canvas.Brush.Bitmap:=nil;
                      Image_inn.Canvas.Polygon(Point_Six_P) ;
                      Image_inn.Canvas.Brush.Bitmap:=bitmap;
                         if   (Point_Six_P[4].Y-Point_Six_P[1].Y>4)  then
                              Image_inn.Canvas.FloodFill(Trunc((Point_Six_P[0].X+Point_Six_P[3].X)/2),Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2),clBlack,fsBorder);
                      Image_inn.Canvas.Brush.Bitmap:=nil;

                     //��� 2016.6.5
                       //��д�Ҳ�ѹ��������
                        if zk.Yc_Rock[zk.main_coal].R_h<= gzm.S_Cg_h then  begin
                              YLG_R1.add(InttoStr(Point_Six_P[4].X)+','+InttoStr(Point_Six_P[2].Y) );
                              YLG_R2.add(InttoStr(Point_Six_P[4].X+trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[2].Y) );
                             
                        end;

                      inn_left_y0:=Point_Six_P[0].Y ;inn_left_y2:=Point_Six_P[2].Y;
                      ganshi_Y0:=Point_Six_P[5].Y;

                       //image_out ��ע
                       // ��ú��б��
                      Pointxy[3].X := Image_out.Width -RightBlank;
                      Pointxy[3].Y := out_right_y0;
                      Pointxy[0].X :=  Pointxy[3].X;
                      Pointxy[0].Y := Pointxy[3].Y -trunc(zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*shiyong_bl);
                      Pointxy[1].X := Pointxy[0].X+40 ;
                      Pointxy[1].Y := Pointxy[0].Y-40;

                      Pointxy[2].X := Pointxy[3].X+40 ;
                      Pointxy[2].Y := Pointxy[3].Y-40;
                      Image_out.Canvas.Polygon(Pointxy) ;
                      Image_out.Canvas.Brush.Bitmap:=bitmap; //ú���ͼƬ
                       if   (Pointxy[2].Y-Pointxy[1].Y>4)  then
                              Image_Out.Canvas.FloodFill(Trunc(Pointxy[0].X+1),Trunc((Pointxy[0].Y+Pointxy[3].Y)/2),clBlack,fsBorder);
                      Image_out.Canvas.Brush.Bitmap:=nil;
                      Image_out.Canvas.MoveTo(LeftBlank-120,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*Y_Text_Bl));
                      Image_out.Canvas.LineTo(LeftBlank-30,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*Y_Text_Bl));
                      Image_out.Canvas.TextOut(LeftBlank-118,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*Y_Text_Bl/2),'ú');
                      Image_out.Canvas.TextOut(LeftBlank-58,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*Y_Text_Bl/2),FormatFloat('0.0',zk.Yc_Rock[zk.main_coal].R_h));
                      //��б��
                      Image_out.Canvas.MoveTo(LeftBlank-30,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*Y_Text_Bl));
                      Image_out.Canvas.LineTo(LeftBlank, Out_left_y1-trunc(zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*shiyong_bl));
                      out_left_y0:=trunc(Out_left_y0-hanziheight-zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*Y_Text_Bl);
                      out_left_y1:=Out_left_y1-trunc(zk.Yc_Rock[zk.main_coal].R_h*gzm.Mc_FdBs*shiyong_bl);
                  for I:=zk.main_coal-1 downto model_start_yc do  begin
                      // ��б��
                      Pointxy[3].X := Image_out.Width -RightBlank;
                      Pointxy[3].Y := Pointxy[0].Y;
                      Pointxy[0].X := Pointxy[3].X;
                      if i<old.yl_max_End-2 then  begin
                           Pointxy[0].Y := Pointxy[3].Y -trunc(zk.Yc_Rock[i].R_h*hcd_bl*shiyong_bl);
                      end else begin
                           Pointxy[0].Y := Pointxy[3].Y -trunc(zk.Yc_Rock[i].R_h*shiyong_bl);
                      end;

                      Pointxy[1].X := Pointxy[0].X+40 ;
                      Pointxy[1].Y := Pointxy[0].Y-40;

                      Pointxy[2].X := Pointxy[3].X+40 ;
                      Pointxy[2].Y := Pointxy[3].Y-40;

                      bitmap.FreeImage;
                       if Tuxing=0 then   begin
                           if  fileexists(dll_Path+'\BmpSi\'+zk.Yc_Rock[i].R_Name+'.Bmp') then  begin
                               bitmap.LoadFromFile(dll_Path+'\BmpSi\'+zk.Yc_Rock[i].R_Name+'.Bmp');//װ��ͼ���ļ�
                            end else begin
                               bitmap.LoadFromFile(dll_Path+'\BmpSi\NULL.Bmp');
                            end;
                       end else begin
                            if  fileexists(dll_Path+'\BmpFZ\'+zk.Yc_Rock[i].R_Name+'.Bmp') then  begin
                                bitmap.LoadFromFile(dll_Path+'\BmpFZ\'+zk.Yc_Rock[i].R_Name+'.Bmp');//װ��ͼ���ļ�
                            end else begin
                                bitmap.LoadFromFile(dll_Path+'\BmpFz\NULL.Bmp');
                            end;
                       end;
                      Image_out.Canvas.Brush.Bitmap:=nil;
                      Image_out.Canvas.Polygon(Pointxy) ;
                      Image_out.Canvas.Brush.Bitmap:=bitmap;
                       if   (Pointxy[2].Y-Pointxy[1].Y>4)  then
                              Image_Out.Canvas.FloodFill(Trunc(Pointxy[0].X+1),Trunc((Pointxy[0].Y+Pointxy[3].Y)/2),clBlack,fsBorder);
                      //������һ�� ��б��
                        if i=model_start_yc then  begin

                            Pointxy[2].X := Pointxy[0].X ;
                            Pointxy[2].Y := Pointxy[0].Y ;
                            Pointxy[3].X := Pointxy[2].X-5 ;
                            Pointxy[3].Y := Pointxy[2].Y ;

                            Pointxy[0].X := Pointxy[3].X ;
                            Pointxy[0].Y := Pointxy[1].Y;

                               Image_out.Canvas.Brush.Bitmap:=nil;
                               Image_out.Canvas.Polygon(Pointxy) ;
                               Image_out.Canvas.Brush.Bitmap:=bitmap;
                                if   (Pointxy[2].Y-Pointxy[1].Y>4)  then
                                      Image_out.Canvas.FloodFill(Trunc(Pointxy[0].X+1),Trunc((Pointxy[0].Y+Pointxy[3].Y)/2),clBlack,fsBorder);

                        end;
                   if i<old.yl_max_End-2 then  begin
                      Image_out.Canvas.MoveTo(LeftBlank-120,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*hcd_bl*Y_Text_Bl));
                      Image_out.Canvas.LineTo(LeftBlank-30,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*hcd_bl*Y_Text_Bl));
                      //д�Ҳ������
                      Image_out.Canvas.TextOut(LeftBlank-118,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*hcd_bl*Y_Text_Bl/2),zk.Yc_Rock[i].R_Name);
                      Image_out.Canvas.TextOut(LeftBlank-58,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*hcd_bl*Y_Text_Bl/2),FormatFloat('0.0',zk.Yc_Rock[i].R_h));
                      //��б��
                      Image_out.Canvas.MoveTo(LeftBlank-30,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*hcd_bl*Y_Text_Bl));
                      Image_out.Canvas.LineTo(LeftBlank, Out_left_y1-trunc(zk.Yc_Rock[i].R_h*hcd_bl*shiyong_bl));
                      out_left_y0:=trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*hcd_bl*Y_Text_Bl);
                      out_left_y1:=Out_left_y1-trunc(zk.Yc_Rock[i].R_h*hcd_bl*shiyong_bl);
                   end else begin
                      Image_out.Canvas.MoveTo(LeftBlank-120,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*Y_Text_Bl));
                      Image_out.Canvas.LineTo(LeftBlank-30,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*Y_Text_Bl));
                     //д�Ҳ������
                      Image_out.Canvas.TextOut(LeftBlank-118,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*Y_Text_Bl/2),zk.Yc_Rock[i].R_Name);
                      Image_out.Canvas.TextOut(LeftBlank-58,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*Y_Text_Bl/2),FormatFloat('0.0',zk.Yc_Rock[i].R_h));
                      //��б��
                      Image_out.Canvas.MoveTo(LeftBlank-30,trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*Y_Text_Bl));
                      Image_out.Canvas.LineTo(LeftBlank, Out_left_y1-trunc(zk.Yc_Rock[i].R_h*shiyong_bl));
                      out_left_y0:=trunc(Out_left_y0-hanziheight-zk.Yc_Rock[i].R_h*Y_Text_Bl);
                      out_left_y1:=Out_left_y1-trunc(zk.Yc_Rock[i].R_h*shiyong_bl);
                   end;// end if
                 end; // end for i := 0 to List.Count - 1 do

            //����ú
               bitmap.FreeImage;
               bitM.FreeImage;
               ganshi_h:=0;
            if (zk.Yc_Rock[zk.main_coal].R_h-Gzm.S_Cg_h)>=0.5 then begin     //����ж�ú
                  //��ඥú
                    bitM.LoadFromFile(dll_Path+'\BmpSi\ú.Bmp');//װ��ͼ���ļ�
                    Point_Six_P[5].X :=0;
                         Point_Six_P[5].Y :=inn_left_y0;
                      Point_Six_P[3].X :=Point_Six_P[5].X +trunc(gzm.ZCYL_sx[2]*shiyong_bl);
                           Point_Six_P[3].Y :=inn_left_y2;
                      Point_Six_P[4].X :=Point_Six_P[3].X -trunc(StrToFloat(temp1[1])*shiyong_bl);
                           Point_Six_P[4].Y :=Point_Six_P[5].Y;
                      Point_Six_P[0].X :=Point_Six_P[5].X;
                           Point_Six_P[0].Y :=Point_Six_P[5].Y-trunc((zk.Yc_Rock[zk.main_coal].R_h-Gzm.S_Cg_h)*gzm.Mc_FdBs*shiyong_bl);
                      Point_Six_P[1].X :=Point_Six_P[4].X;
                           Point_Six_P[1].Y :=Point_Six_P[0].Y;
                      Point_Six_P[2].X :=Point_Six_P[3].X;
                           Point_Six_P[2].Y :=Point_Six_P[3].Y-trunc((zk.Yc_Rock[zk.main_coal].R_h-Gzm.S_Cg_h)*ZhiJIa_Zl_xs*gzm.Mc_FdBs*shiyong_bl);

                      Image_inn.Canvas.Brush.Bitmap:=nil;
                      Image_inn.Canvas.Polygon(Point_Six_P) ;
                      Image_inn.Canvas.Brush.Bitmap:=bitM;
                       if  (Point_Six_P[4].Y-Point_Six_P[1].Y>4)  then
                            Image_inn.Canvas.FloodFill(Trunc((Point_Six_P[0].X+Point_Six_P[3].X)/2),Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2),clBlack,fsBorder);
                       //��д���ѹ��������
                      YLG_L1.Add(InttoStr(Point_Six_P[1].X)+','+InttoStr(Point_Six_P[1].Y) );
                      YLG_L2.Add(InttoStr(Point_Six_P[1].X-trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[1].Y));

                      //�Ҳඥú
                     //֧���Ϸ�����
                                    Point_Six_P[5].X :=Image_inn.Width  ;
                                          Point_Six_P[5].Y := inn_left_y0;
                                    Point_Six_P[3].X :=Point_Six_P[2].X+trunc((Jinchi+zhijia.Zj_KongdingJU/60*22)*shiyong_bl);
                                         Point_Six_P[3].Y :=Point_Six_P[3].Y;
                                    Point_Six_P[4].X :=Point_Six_P[3].X +trunc(StrToFloat(temp1[1])*shiyong_bl);
                                         Point_Six_P[4].Y :=Point_Six_P[5].Y;
                                    Point_Six_P[0].X :=Point_Six_P[5].X;
                                         Point_Six_P[0].Y :=Point_Six_P[5].Y-trunc((zk.Yc_Rock[zk.main_coal].R_h-Gzm.S_Cg_h)*gzm.Mc_FdBs*shiyong_bl);
                                    Point_Six_P[1].X :=Point_Six_P[4].X;
                                         Point_Six_P[1].Y :=Point_Six_P[0].Y;
                                    Point_Six_P[2].X :=Point_Six_P[3].X;
                                         Point_Six_P[2].Y :=Point_Six_P[3].Y-trunc((zk.Yc_Rock[zk.main_coal].R_h-Gzm.S_Cg_h)*ZhiJIa_Zl_xs*gzm.Mc_FdBs*shiyong_bl);


                                   Image_inn.Canvas.Brush.Bitmap:=nil;
                                    Image_inn.Canvas.Polygon(Point_Six_P) ;
                                    Image_inn.Canvas.Brush.Bitmap:=bitM;    //ú��� ͼ��
                                       if   (Point_Six_P[4].Y-Point_Six_P[1].Y>4)  then
                                            Image_inn.Canvas.FloodFill(Trunc((Point_Six_P[0].X+Point_Six_P[3].X)/2),Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2),clBlack,fsBorder);
                                    Image_inn.Canvas.Brush.Bitmap:=nil;

                                      // ֧�ܺ󱳲���
                                      Point_Six_P_2[0].X :=Point_Six_P[3].X ;
                                          Point_Six_P_2[0].Y :=Point_Six_P[3].Y;

                                      Point_Six_P_2[5].X :=Point_Six_P[2].X ;
                                          Point_Six_P_2[5].Y :=Point_Six_P[2].Y;


                                      Point_Six_P_2[1].X :=Point_Six_P_2[0].X-trunc((zhijia.Zj_KongdingJU/60*22)*shiyong_bl); ;
                                          Point_Six_P_2[1].Y :=Point_Six_P[3].Y+trunc(gzm.S_Cg_h*gzm.Mc_FdBs*shiyong_bl);;
                                      Point_Six_P_2[4].X :=Point_Six_P_2[1].X ;
                                          Point_Six_P_2[4].Y :=Point_Six_P_2[5].Y;

                                      Point_Six_P_2[2].X :=Point_Six_P_2[1].X+trunc((zhijia.Zj_KongdingJU/60*3)*shiyong_bl); ;
                                          Point_Six_P_2[2].Y :=Point_Six_P_2[1].Y-trunc(gzm.S_Cg_h*0.75*gzm.Mc_FdBs*shiyong_bl);

                                      Point_Six_P_2[3].X :=Point_Six_P_2[2].X-trunc((zk.Yc_Rock[zk.main_coal].R_h-gzm.S_Cg_h)*0.95*0.2*shiyong_bl);
                                          Point_Six_P_2[3].Y :=Point_Six_P_2[2].Y-trunc((zk.Yc_Rock[zk.main_coal].R_h-gzm.S_Cg_h)*0.95*shiyong_bl);

                                       Image_inn.Canvas.Brush.Bitmap:=nil;
                                    Image_inn.Canvas.Polygon(Point_Six_P_2) ;
                                    Image_inn.Canvas.Brush.Bitmap:=bitM;    //ú��� ͼ��
                                       if   (Point_Six_P_2[1].Y-Point_Six_P_2[4].Y>3)  then
                                            Image_inn.Canvas.FloodFill(Trunc((Point_Six_P_2[0].X+Point_Six_P_2[3].X)/2),Trunc((Point_Six_P_2[1].Y+Point_Six_P_2[4].Y)/2),clBlack,fsBorder);
                                    Image_inn.Canvas.Brush.Bitmap:=nil;
                                 

                     //��д�Ҳ�ѹ��������
                      YLG_R1.Insert(0,InttoStr(Point_Six_P[4].X)+','+InttoStr(Point_Six_P[2].Y) );
                      YLG_R2.insert(0,InttoStr(Point_Six_P[4].X+trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[2].Y) );

                     inn_left_y0:=Point_Six_P[0].Y ;inn_left_y2:=Point_Six_P[2].Y;
                     ganshi_Count:=1;  ganshi_h :=zk.Yc_Rock[zk.main_coal].R_h-Gzm.S_Cg_h-Gzm.S_Fm_h;
                     ganshi_right_x4:=Point_Six_P[2].X-trunc((zhijia.Zj_KongdingJU/60*22)*shiyong_bl);
              end;
               //���ֱ�Ӷ�
               inn_left_y0:=Point_Six_P[0].Y ;inn_left_y2:=Point_Six_P[2].Y;
               inn_right_y0:=Point_Six_P[0].Y ;inn_right_y2:=Point_Six_P[2].Y;
               inn_left_x2 :=trunc(gzm.ZCYL_sx[2]*shiyong_bl);  inn_Right_x2 :=trunc((Jinchi+gzm.ZCYL_sx[2])*shiyong_bl);
               ganshi_y1:=Point_Six_P[0].Y; YockLiang_Suo:=0;//first
               zcyl_L_P2.X:=inn_left_x2;   zcyl_l_P2.Y:=inn_left_y2;

               zcyl_R_P2.X:=trunc((Jinchi+gzm.ZCYL_sx[2]+zhijia.Zj_KongdingJU)*shiyong_bl);   zcyl_R_P2.Y:=inn_Right_y2;

               Zjd_Wt :=0;//ֱ�Ӷ���λ̬��
                  for I := imm.Start_No  downto imm.End_No do
                     begin
                        //
                        Step0:=zk.Yc_Rock[i].Step0;
                        if (i=imm.End_No) and (imm.Surplus_h>0) then    begin
                            used_h:= zk.Yc_Rock[i].R_h-imm.Surplus_h;
                            Step0:=sqrt(1000*2*used_h*zk.Yc_Rock[i].R_klqd/zk.Yc_Rock[i].R_r);
                        end else begin
                            used_h:= zk.Yc_Rock[i].R_h;
                        end;
                         //���ͼ��
                           bitM.FreeImage;
                           if Tuxing=0 then   begin
                              if  fileexists(dll_Path+'\BmpSi\'+zk.Yc_Rock[i].R_Name+'.Bmp') then  begin
                                  bitM.LoadFromFile(dll_Path+'\BmpSi\'+zk.Yc_Rock[i].R_Name+'.Bmp');//װ��ͼ���ļ�
                              end else begin
                                  bitM.LoadFromFile(dll_Path+'\BmpSi\NULL.Bmp');
                              end;

                             end else begin
                                if  fileexists(dll_Path+'\BmpFZ\'+zk.Yc_Rock[i].R_Name+'.Bmp') then  begin
                                  bitM.LoadFromFile(dll_Path+'\BmpFZ\'+zk.Yc_Rock[i].R_Name+'.Bmp');//װ��ͼ���ļ�
                                end else begin
                                  bitM.LoadFromFile(dll_Path+'\BmpFz\NULL.Bmp');
                                end;
                            end;

                        if jinChi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-2*YockLiang_Suo< Step0 * 0.95  then  begin
                            break;
                        end else if  jinChi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-2*YockLiang_Suo<= Step0*1.05  then   begin
                           //���

                             Point_Six_P[5].X :=0;
                                 Point_Six_P[5].Y :=inn_left_y0;

                             Point_Six_P[3].X :=inn_left_x2-trunc((StrToFloat(temp1[1])+YockLiang_Suo)*shiyong_bl);
                                 if StrToFloat(temp1[3])>0 then begin
                                      Point_Six_P[3].Y :=inn_left_y2-trunc((inn_left_y2-inn_left_y0)*(StrToFloat(temp1[3])-StrToFloat(temp1[1]))/StrToFloat(temp1[3]));
                                 end else begin
                                      Point_Six_P[3].Y :=inn_left_y2;
                                 end;
                             Point_Six_P[0].X :=Point_Six_P[5].X;
                                   Point_Six_P[0].Y :=Point_Six_P[5].Y-trunc(used_h*shiyong_bl);
                             Point_Six_P[2].X :=Point_Six_P[3].X;
                                   Point_Six_P[2].Y :=Point_Six_P[3].Y-trunc(used_h*shiyong_bl);
                              Point_Six_P[4].X :=inn_left_x2 -trunc(StrToFloat(temp1[1])*shiyong_bl);
                                   Point_Six_P[4].Y :=Point_Six_P[5].Y;
                              Point_Six_P[1].X :=Point_Six_P[4].X;
                                   Point_Six_P[1].Y :=Point_Six_P[0].Y;

                               Image_inn.Canvas.Polygon(Point_Six_P) ;
                               Image_inn.Canvas.Brush.Bitmap:=bitM;
                               Image_fill_P.x :=Trunc((Point_Six_P[5].X+Point_Six_P[3].X)/2); Image_fill_P.y:= Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2);
                                 while_image:=true;
                                 k:=0;
                                 while while_image  do begin
                                      if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_Six_P) then begin
                                         Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                         while_image:=false;
                                      end else begin
                                          K:=K+1;
                                          Image_fill_P.x :=Point_Six_P[5].X+K; Image_fill_P.y:=  Point_Six_P[5].Y-1;
                                          if K>5 then  while_image:=false;

                                      end;

                                 end;   //end while

                              Image_inn.Canvas.Brush.Bitmap:=nil;
                               //��д���ѹ��������
                              YLG_L1.Add(InttoStr(Point_Six_P[1].X)+','+InttoStr(Point_Six_P[1].Y) );
                              YLG_L2.Add(InttoStr(Point_Six_P[1].X-trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[1].Y) );
                             // if i=Yc_End_Nu then  begin
                                    Point_wk[3].X := Point_Six_P[0].X ;
                                    Point_wk[3].Y := Point_Six_P[0].Y;
                                    Point_wk[2].X := Point_Six_P[2].X; 
                                    Point_wk[2].Y := Point_Six_P[2].Y;

                                    Point_wk[0].X := Point_wk[3].X+40 ;
                                    Point_wk[0].Y := Point_wk[3].Y-40;
                                    Point_wk[1].X := Point_wk[2].X+40;
                                    Point_wk[1].Y := Point_wk[2].Y-40;
                                      Image_inn.Canvas.Brush.Bitmap:=nil;
                                      Image_inn.Canvas.Polygon(Point_wk);
                                      Image_inn.Canvas.Brush.Bitmap:=bitM;
                                        //ͼ�����
                                         Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                         while_image:=true;
                                         k:=0;
                                         while while_image  do begin
                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                 while_image:=false;
                                              end else begin
                                                  K:=K+1;
                                                  Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                  if K>5 then  while_image:=false;
                                              end;

                                         end; // end while

                             // end;  //end  if i=Yc_End_Nu then  begin
                              //2015.6014 ��ת4247�Ƶ�4103  ��/
                            // ganshi_right_x4:= inn_left_x2+trunc((jinchi-zhijia.Zj_KongdingJU)*shiyong_bl);
                              ganshi_right_x4:= inn_left_x2+trunc((jinchi)*shiyong_bl);

                              inn_left_y0:=Point_Six_P[0].Y ;inn_left_y2:=Point_Six_P[2].Y;inn_left_x2 := Point_Six_P[2].X ;
                             //��һ��
                               JinChi_sup:=Jinchi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-step0*0.95;
                               YanCengQingJiao:=(arctan(used_h/Step0))*10*JinChi_sup/(Step0*1.05);

                              Pointxy[0].X :=Point_Six_P[3].X-trunc(0.5*used_h*sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[0].Y :=Point_Six_P[3].Y-trunc((0.5*used_h-0.5*used_h*Cos(YanCengQingJiao))*shiyong_bl);
                              Pointxy[1].X :=Pointxy[0].X +trunc(Used_h* sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[1].Y :=Pointxy[0].Y -trunc(Used_h* cos(YanCengQingJiao)*shiyong_bl);
                              Pointxy[2].X :=Pointxy[1].X +trunc(0.5*step0* cos(YanCengQingJiao)*shiyong_bl);
                              Pointxy[2].Y :=Pointxy[1].Y +trunc(0.5*step0* sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[3].X :=Pointxy[2].X -trunc(Used_h* sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[3].Y :=Pointxy[2].Y +trunc(Used_h* cos(YanCengQingJiao)*shiyong_bl);
                                Image_inn.Canvas.Brush.Bitmap:=nil;
                                Image_inn.Canvas.Polygon(Pointxy);
                                Image_inn.Canvas.Brush.Bitmap:=bitM;
                               //ͼ�����
                                 Image_fill_P.x :=Trunc((Pointxy[0].X+Pointxy[2].X)/2); Image_fill_P.y:= Trunc((Pointxy[0].Y+Pointxy[2].Y)/2);
                                 while_image:=true;
                                 k:=0;
                                 while while_image  do begin
                                      if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Pointxy) then begin
                                         Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                         while_image:=false;
                                      end else begin
                                          K:=K+1;
                                          Image_fill_P.x :=Pointxy[0].X+K; Image_fill_P.y:=  Pointxy[0].Y-1;
                                          if K>5 then  while_image:=false;

                                      end;

                                 end;  //end while
                                 Image_inn.Canvas.Brush.Bitmap:=nil;

                                    // if i=Yc_End_Nu then  begin
                                    Point_wk[3].X := Pointxy[1].X ;
                                    Point_wk[3].Y := Pointxy[1].Y;
                                    Point_wk[2].X := Pointxy[2].X; ;
                                    Point_wk[2].Y := Pointxy[2].Y;

                                    Point_wk[0].X := Point_wk[3].X+40 ;
                                    Point_wk[0].Y := Point_wk[3].Y-40;
                                    Point_wk[1].X := Point_wk[2].X+40;
                                    Point_wk[1].Y := Point_wk[2].Y-40;
                                      Image_inn.Canvas.Brush.Bitmap:=nil;
                                      Image_inn.Canvas.Polygon(Point_wk);
                                      Image_inn.Canvas.Brush.Bitmap:=bitM;
                                        //ͼ�����
                                         Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                         while_image:=true;
                                         k:=0;
                                         while while_image  do begin
                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                 while_image:=false;
                                              end else begin
                                                  K:=K+1;
                                                  Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                  if K>5 then  while_image:=false;
                                              end;

                                         end; // end while

                             // end;  //end  if i=Yc_End_Nu then  begin

                              //�Ҳ�
                                Point_Six_P[5].X :=Image_inn.Width;
                                     Point_Six_P[5].Y :=inn_right_y0;
                                Point_Six_P[3].X :=inn_Right_x2+trunc((step0-StrToFloat(temp1[1])*2-Jinchi-YockLiang_Suo)*shiyong_bl);
                               //  Point_Six_P[3].X :=inn_Right_x2+trunc((zhijia.Zj_KongdingJU+step0-StrToFloat(temp1[1])*2-Jinchi-YockLiang_Suo)*shiyong_bl);


                               if StrToFloat(temp1[3])>0 then begin
                                      Point_Six_P[3].Y :=inn_right_y2-trunc((inn_left_y2-inn_left_y0)*(StrToFloat(temp1[3])-StrToFloat(temp1[1]))/StrToFloat(temp1[3]));
                                 end else begin
                                      Point_Six_P[3].Y :=inn_right_y2;
                                 end;

                                Point_Six_P[0].X :=Point_Six_P[5].X;
                                   Point_Six_P[0].Y :=Point_Six_P[5].Y-trunc(used_h*shiyong_bl);
                                Point_Six_P[2].X :=Point_Six_P[3].X;
                                   Point_Six_P[2].Y :=Point_Six_P[3].Y-trunc(used_h*shiyong_bl);

                                Point_Six_P[4].X :=Point_Six_P[3].X +trunc((zhijia.Zj_KongdingJU+StrToFloat(temp1[3]))*shiyong_bl);
                                     Point_Six_P[4].Y :=Point_Six_P[5].Y;
                                Point_Six_P[1].X :=Point_Six_P[4].X;
                                     Point_Six_P[1].Y :=Point_Six_P[0].Y;

                              Image_inn.Canvas.Polygon(Point_Six_P) ;
                              Image_inn.Canvas.Brush.Bitmap:=bitM;
                              Image_fill_P.x :=Trunc((Point_Six_P[5].X+Point_Six_P[3].X)/2); Image_fill_P.y:= Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2);
                                   while_image:=true;
                                   k:=0;
                                   while while_image  do begin
                                        if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_Six_P) then begin
                                           Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                           while_image:=false;
                                        end else begin
                                            K:=K+1;
                                            Image_fill_P.x :=Point_Six_P[5].X+K; Image_fill_P.y:=  Point_Six_P[5].Y-1;
                                            if K>5 then  while_image:=false;

                                        end;

                                   end;  //end while
                                   Image_inn.Canvas.Brush.Bitmap:=nil;
                                    //��д�Ҳ�ѹ��������
                                   YLG_R1.Insert(0,InttoStr(Point_Six_P[4].X)+','+InttoStr(Point_Six_P[2].Y) );
                                   YLG_R2.insert(0,InttoStr(Point_Six_P[4].X+trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[2].Y) );
                                 // if i=Yc_End_Nu then  begin
                                    Point_wk[3].X := Point_Six_P[2].X ;
                                    Point_wk[3].Y := Point_Six_P[2].Y;
                                    Point_wk[2].X := Point_Six_P[0].X;
                                    Point_wk[2].Y := Point_Six_P[0].Y;

                                    Point_wk[0].X := Point_wk[3].X+40 ;
                                    Point_wk[0].Y := Point_wk[3].Y-40;
                                    Point_wk[1].X := Point_wk[2].X+40;
                                    Point_wk[1].Y := Point_wk[2].Y-40;
                                      Image_inn.Canvas.Brush.Bitmap:=nil;
                                      Image_inn.Canvas.Polygon(Point_wk);
                                      Image_inn.Canvas.Brush.Bitmap:=bitM;
                                        //ͼ�����
                                         Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                         while_image:=true;
                                         k:=0;
                                         while while_image  do begin
                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                 while_image:=false;
                                              end else begin
                                                  K:=K+1;
                                                  Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                  if K>5 then  while_image:=false;
                                              end;

                                         end; // end while

                             // end;  //end  if i=Yc_End_Nu then  begin

                             inn_right_y0:=Point_Six_P[0].Y ;inn_right_y2:=Point_Six_P[2].Y;inn_Right_x2 := Point_Six_P[2].X -trunc(zhijia.Zj_KongdingJU*shiyong_bl);
                             ganshi_y1:=Point_Six_P[5].Y;
                             //2015.6014 ת�Ƶ� 4103 ��/
                             //ganshi_right_x4:= inn_left_x1+trunc((jinchi-zhijia.Zj_KongdingJU)*shiyong_bl);
                               //�ڶ���

                              Pointxy[0].X :=Point_Six_P[3].X+trunc(0.5*used_h*sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[0].Y :=Point_Six_P[3].Y-trunc((0.5*used_h-0.5*used_h*Cos(YanCengQingJiao))*shiyong_bl);
                              Pointxy[1].X :=Pointxy[0].X -trunc(Used_h* sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[1].Y :=Pointxy[0].Y -trunc(Used_h* cos(YanCengQingJiao)*shiyong_bl);
                              Pointxy[2].X :=Pointxy[2].X;
                              Pointxy[2].Y :=Pointxy[2].Y;
                              Pointxy[3].X :=Pointxy[2].X +trunc(Used_h* sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[3].Y :=Pointxy[3].Y ;
                                Image_inn.Canvas.Brush.Bitmap:=nil;
                                Image_inn.Canvas.Polygon(Pointxy);
                                Image_inn.Canvas.Brush.Bitmap:=bitM;
                                Image_fill_P.x :=Trunc((Pointxy[0].X+Pointxy[3].X)/2); Image_fill_P.y:= Trunc((Pointxy[3].Y+Pointxy[2].Y)/2);
                                 while_image:=true;
                                 k:=0;
                                 while while_image  do begin
                                      if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Pointxy) then begin
                                         Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                         while_image:=false;
                                      end else begin
                                          K:=K+1;
                                          Image_fill_P.x :=Pointxy[0].X-K; Image_fill_P.y:=  Pointxy[0].Y-1;
                                          if K>5 then  while_image:=false;

                                      end;

                                 end;

                                 // if i=Yc_End_Nu then  begin
                                    Point_wk[3].X := Pointxy[2].X ;
                                    Point_wk[3].Y := Pointxy[2].Y;
                                    Point_wk[2].X := Pointxy[1].X; ;
                                    Point_wk[2].Y := Pointxy[1].Y;

                                    Point_wk[0].X := Point_wk[3].X+40 ;
                                    Point_wk[0].Y := Point_wk[3].Y-40;
                                    Point_wk[1].X := Point_wk[2].X+40;
                                    Point_wk[1].Y := Point_wk[2].Y-40;
                                      Image_inn.Canvas.Brush.Bitmap:=nil;
                                      Image_inn.Canvas.Polygon(Point_wk);
                                      Image_inn.Canvas.Brush.Bitmap:=bitM;
                                        //ͼ�����
                                         Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                         while_image:=true;
                                         k:=0;
                                         while while_image  do begin
                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                 while_image:=false;
                                              end else begin
                                                  K:=K+1;
                                                  Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                  if K>5 then  while_image:=false;
                                              end;

                                         end; // end while

                             // end;  //end  if i=Yc_End_Nu then  begin
                                Image_inn.Canvas.Brush.Bitmap:=nil;
                                //��ֹѭ��
                                 Zjd_Wt:=1;
                        end else begin
                              //���
                             if Zjd_Wt=1 then   break;   // ����²�û�г������ϲ���ֳ������˳�

                             Point_Six_P[5].X :=0;
                                 Point_Six_P[5].Y :=inn_left_y0;

                             Point_Six_P[3].X :=inn_left_x2;
                                 if StrToFloat(temp1[3])>0 then begin
                                      Point_Six_P[3].Y :=inn_left_y2-trunc((inn_left_y2-inn_left_y0)*(StrToFloat(temp1[3])-StrToFloat(temp1[1]))/StrToFloat(temp1[3]));
                                 end else begin
                                      Point_Six_P[3].Y :=inn_left_y2;
                                 end;
                             Point_Six_P[0].X :=Point_Six_P[5].X;
                                   Point_Six_P[0].Y :=Point_Six_P[5].Y-trunc(used_h*shiyong_bl);
                                   YockLiang_Suo:=YockLiang_Suo+used_h*tan(25/180*3.1415926);
                             Point_Six_P[2].X :=Point_Six_P[3].X+trunc(used_h*tan(25/180*3.1415926)*shiyong_bl);
                                   Point_Six_P[2].Y :=Point_Six_P[3].Y-trunc(used_h*shiyong_bl);
                              Point_Six_P[4].X :=inn_left_x2 -trunc(StrToFloat(temp1[3])*shiyong_bl);
                                   Point_Six_P[4].Y :=Point_Six_P[5].Y;
                              Point_Six_P[1].X :=Point_Six_P[4].X;
                                   Point_Six_P[1].Y :=Point_Six_P[0].Y;

                              Image_inn.Canvas.Polygon(Point_Six_P) ;
                              Image_inn.Canvas.Brush.Bitmap:=bitM;
                              Image_fill_P.x :=Trunc((Point_Six_P[5].X+Point_Six_P[3].X)/2); Image_fill_P.y:= Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2);
                                   while_image:=true;
                                   k:=0;
                                   while while_image  do begin
                                        if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_Six_P) then begin
                                           Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                           while_image:=false;
                                        end else begin
                                            K:=K+1;
                                            Image_fill_P.x :=Point_Six_P[5].X+K; Image_fill_P.y:=  Point_Six_P[5].Y-1;
                                            if K>5 then  while_image:=false;

                                        end;

                                   end; //end; //end while
                              Image_inn.Canvas.Brush.Bitmap:=nil;
                                   //��д���ѹ��������
                              YLG_L1.Add(InttoStr(Point_Six_P[1].X)+','+InttoStr(Point_Six_P[1].Y) );
                              YLG_L2.Add(InttoStr(Point_Six_P[1].X-trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[1].Y) );
                         

                              inn_left_y0:=Point_Six_P[0].Y ;inn_left_y2:=Point_Six_P[2].Y;inn_left_x2 := Point_Six_P[2].X ;

                              //�Ҳ�
                               Point_Six_P[5].X :=Image_inn.Width;
                                     Point_Six_P[5].Y :=inn_right_y0;
                                Point_Six_P[3].X :=inn_Right_x2;
                                 if StrToFloat(temp1[3])>0 then begin
                                      Point_Six_P[3].Y :=inn_right_y2-trunc((inn_left_y2-inn_left_y0)*(StrToFloat(temp1[3])-StrToFloat(temp1[1]))/StrToFloat(temp1[3]));
                                 end else begin
                                      Point_Six_P[3].Y :=inn_right_y2;
                                 end;
                                Point_Six_P[0].X :=Point_Six_P[5].X;
                                   Point_Six_P[0].Y :=Point_Six_P[5].Y-trunc(used_h*shiyong_bl);
                                Point_Six_P[2].X :=Point_Six_P[3].X-trunc(used_h*tan(25/180*3.1415926)*shiyong_bl);
                                   Point_Six_P[2].Y :=Point_Six_P[3].Y-trunc(used_h*shiyong_bl);

                                Point_Six_P[4].X :=Point_Six_P[3].X +trunc((zhijia.Zj_KongdingJU+StrToFloat(temp1[3]))*shiyong_bl);
                                     Point_Six_P[4].Y :=Point_Six_P[5].Y;
                                Point_Six_P[1].X :=Point_Six_P[4].X;
                                     Point_Six_P[1].Y :=Point_Six_P[0].Y;

                              Image_inn.Canvas.Polygon(Point_Six_P) ;
                              Image_inn.Canvas.Brush.Bitmap:=bitM;
                              Image_fill_P.x :=Trunc((Point_Six_P[5].X+Point_Six_P[3].X)/2); Image_fill_P.y:= Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2);
                                   while_image:=true;
                                   k:=0;
                                   while while_image  do begin
                                        if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_Six_P) then begin
                                           Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                           while_image:=false;
                                        end else begin
                                            K:=K+1;
                                            Image_fill_P.x :=Point_Six_P[5].X+K; Image_fill_P.y:=  Point_Six_P[5].Y-1;
                                            if K>5 then  while_image:=false;

                                        end;

                                   end;  //end; //end while
                             Image_inn.Canvas.Brush.Bitmap:=nil;
                              //��д�Ҳ�ѹ��������
                             YLG_R1.Insert(0,InttoStr(Point_Six_P[4].X)+','+InttoStr(Point_Six_P[2].Y) );
                             YLG_R2.insert(0,InttoStr(Point_Six_P[4].X+trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[2].Y) );

                             inn_right_y0:=Point_Six_P[0].Y ;inn_right_y2:=Point_Six_P[2].Y;inn_Right_x2 := Point_Six_P[2].X ;
                             ganshi_y1:=Point_Six_P[0].Y;
                             ganshi_right_x4:= Point_Six_P[3].X;
                            // ganshi_right_x4:= Point_Six_P[3].X-trunc(zhijia.Zj_KongdingJU*shiyong_bl);
                             ganshi_h:=ganshi_h+zk.Yc_Rock[i].R_k_Rock*used_h;

                        end;
                            if i<=imm.Start_No  then  ganshi_Count:=2;
                     end;  //end for   i
                        ganshi_h:=ganshi_h+gzm.S_Cg_h*(gzm.Mc_FdBs-1) ;

                   //�� ֱ�Ӷ��� �ڵ�ǰ�ƽ������� �������Ҳ�
                  if (i> imm.End_No) or(i=imm.End_No) then  begin
                       for j := i downto imm.End_No do  begin
                            Pointxy[0].X :=0 ;
                              if (j=imm.End_No) and (imm.Surplus_h>0) then    begin
                                  Pointxy[0].Y :=inn_left_y0-trunc((zk.Yc_Rock[j].R_h-imm.Surplus_h)*shiyong_bl);
                              end else begin
                                  Pointxy[0].Y :=inn_left_y0-trunc((zk.Yc_Rock[j].R_h)*shiyong_bl);
                              end;
                            Pointxy[1].X :=Image_inn.Width ;
                            Pointxy[1].Y :=Pointxy[0].Y;
                            Pointxy[2].X :=Pointxy[1].X  ;
                            Pointxy[2].Y :=inn_left_y0;
                            Pointxy[3].X :=Pointxy[0].X ;
                            Pointxy[3].Y :=Pointxy[2].Y ;
                            Image_inn.Canvas.Brush.Bitmap:=nil;
                         //���ͼ��
                            bitM.FreeImage;
                            if Tuxing=0 then   begin
                              if  fileexists(dll_Path+'\BmpSi\'+zk.Yc_Rock[j].R_Name+'.Bmp') then  begin
                                  bitM.LoadFromFile(dll_Path+'\BmpSi\'+zk.Yc_Rock[j].R_Name+'.Bmp');//װ��ͼ���ļ�
                              end else begin
                                  bitM.LoadFromFile(dll_Path+'\BmpSi\NULL.Bmp');
                              end;

                            end else begin
                                if  fileexists(dll_Path+'\BmpFZ\'+zk.Yc_Rock[j].R_Name+'.Bmp') then  begin
                                  bitM.LoadFromFile(dll_Path+'\BmpFZ\'+zk.Yc_Rock[j].R_Name+'.Bmp');//װ��ͼ���ļ�
                                end else begin
                                  bitM.LoadFromFile(dll_Path+'\BmpFz\NULL.Bmp');
                                end;

                            end; // end if Tuxing
                                Image_inn.Canvas.Brush.Bitmap:=nil;
                                Image_inn.Canvas.Polygon(Pointxy);
                                Image_inn.Canvas.Brush.Bitmap:=bitM;
                                Image_fill_P.x :=Trunc((Pointxy[0].X+Pointxy[1].X)/2); Image_fill_P.y:= Trunc((Pointxy[3].Y+Pointxy[0].Y)/2);
                                 while_image:=true;
                                 k:=0;
                                 while while_image  do begin
                                      if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Pointxy) then begin
                                         Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                         while_image:=false;
                                      end else begin
                                          K:=K+1;
                                          Image_fill_P.x :=Pointxy[3].X+K; Image_fill_P.y:=  Pointxy[3].Y-1;
                                          if K>5 then  while_image:=false;

                                      end;
                                 end; //end while
                                 Image_inn.Canvas.Brush.Bitmap:=nil;
                           
                            inn_left_y0:=Pointxy[0].Y;
                           //����в������Ҳ㣬�϶�û�����
                            Zjd_Wt:=1;
                       end;  //end for j

                         
                  end;  // end if  i



               //���϶�
                 YockLiang_Suo:=0; Rock_sa:=0; //�϶������������� �³���ֵΪ0
                 inn_Left_x2:= trunc(gzm.ZCYL_sx[2]*shiyong_bl)-trunc(StrToFloat(temp1[1])*shiyong_bl);
                 inn_Right_x2:= trunc((gzm.ZCYL_sx[2]+Jinchi+zhijia.Zj_KongdingJU+StrToFloat(temp1[3]))*shiyong_bl);
                 ganshi_y2:=0; break_i_105:=0;
                 zcyl_l_P1.X:=0;   zcyl_l_P1.Y:=zcyl_l_P2.Y-trunc(gzm.S_Cg_h*gzm.Mc_FdBs*strtofloat(temp1[2])*shiyong_bl);
                 zcyl_R_P1.X:=Image_inn.Width;   zcyl_R_P1.Y:=zcyl_l_P1.Y;

                 Sink_leixing:=1;
                 for I := Old_beam[0].Start_YC_No downto model_start_yc do   begin

                        if Zjd_Wt=1 then  break; //���ֱ�Ӷ�û�г�����ϡ��϶���������

                        Step0:=zk.Yc_Rock[i].Step0;
                        if (i=imm.End_No) and (imm.Surplus_h>0) then    begin
                            used_h:= imm.Surplus_h;
                        end else begin
                            used_h:= zk.Yc_Rock[i].R_h;
                        end;
                       //���ͼ��
                       bitM.FreeImage;
                       if Tuxing=0 then   begin
                          if  fileexists(dll_Path+'\BmpSi\'+zk.Yc_Rock[i].R_Name+'.Bmp') then  begin
                              bitM.LoadFromFile(dll_Path+'\BmpSi\'+zk.Yc_Rock[i].R_Name+'.Bmp');//װ��ͼ���ļ�
                          end else begin
                              bitM.LoadFromFile(dll_Path+'\BmpSi\NULL.Bmp');
                          end;

                         end else begin
                            if  fileexists(dll_Path+'\BmpFZ\'+zk.Yc_Rock[i].R_Name+'.Bmp') then  begin
                              bitM.LoadFromFile(dll_Path+'\BmpFZ\'+zk.Yc_Rock[i].R_Name+'.Bmp');//װ��ͼ���ļ�
                            end else begin
                              bitM.LoadFromFile(dll_Path+'\BmpFz\NULL.Bmp');
                            end;
                        end;
                        //
                        if i<old.yl_max_End then   break;
                        
                        if jinChi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-2*YockLiang_Suo< Step0 * 0.95  then  begin
                            break;
                        end else  begin
                            //��� �϶�
                             //���� ȷ��������³�ֵ
                             if  break_i_105 =0  then  begin
                                 if jinChi+zhijia.Zj_KongdingJU < gzm.S_L_qx then  begin
                                    rock_sa:=zk.Yc_Rock[i].Sa[0];
                                 end else if jinChi+zhijia.Zj_KongdingJU < gzm.S_L_qx *2  then  begin
                                    rock_sa:=zk.Yc_Rock[i].Sa[1];
                                 end else begin
                                    rock_sa:=zk.Yc_Rock[i].Sa[2];
                                 end;
                             end;

                             Sink_Sa_used:= used_h;
                             //��� �϶�
                             Point_Six_P[5].X :=0;
                                 Point_Six_P[5].Y :=inn_left_y0;

                             Point_Six_P[3].X :=inn_left_x2+trunc(YockLiang_Suo*shiyong_bl);
                                 if StrToFloat(temp1[3])>0 then begin
                                      Point_Six_P[3].Y :=inn_left_y2-trunc((inn_left_y2-inn_left_y0)*(StrToFloat(temp1[3])-StrToFloat(temp1[1]))/StrToFloat(temp1[3]));
                                 end else begin
                                      Point_Six_P[3].Y :=inn_left_y2;
                                 end;

                             Point_Six_P[3].Y:=Public_Basic.FindPointY (Point_Six_P[3].X,Point_Six_P[3].Y,t_str_sec,1);

                             Point_Six_P[0].X :=Point_Six_P[5].X;
                                   Point_Six_P[0].Y :=Point_Six_P[5].Y-trunc(used_h*shiyong_bl);
                             Point_Six_P[2].X :=Point_Six_P[3].X;
                                   Point_Six_P[2].Y :=Point_Six_P[3].Y-trunc(used_h*shiyong_bl);
                              Point_Six_P[4].X :=Point_Six_P[3].X -trunc(StrToFloat(temp1[3])*shiyong_bl);
                                   Point_Six_P[4].Y :=Point_Six_P[5].Y;
                              Point_Six_P[1].X :=Point_Six_P[4].X;
                                   Point_Six_P[1].Y :=Point_Six_P[0].Y;

                             //��������һ�㣬 //���㻭�������
                            //  if i=Yc_End_Nu then  begin
                                    Point_wk[3].X := Point_Six_P[0].X ;
                                    Point_wk[3].Y := Point_Six_P[0].Y;
                                    Point_wk[2].X := Point_Six_P[2].X; ;
                                    Point_wk[2].Y := Point_Six_P[2].Y;

                                    Point_wk[0].X := Point_wk[3].X+40 ;
                                    Point_wk[0].Y := Point_wk[3].Y-40;
                                    Point_wk[1].X := Point_wk[2].X+40;
                                    Point_wk[1].Y := Point_wk[2].Y-40;
                                      Image_inn.Canvas.Brush.Bitmap:=nil;
                                      Image_inn.Canvas.Polygon(Point_wk);
                                      Image_inn.Canvas.Brush.Bitmap:=bitM;
                                        //ͼ�����
                                       Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                       while_image:=true;
                                       k:=0;
                                       while while_image  do begin
                                            if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                               Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                               while_image:=false;
                                            end else begin
                                                K:=K+1;
                                                Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                if K>5 then  while_image:=false;
                                            end;

                                       end; // end while

                             // end;   end  if i=Yc_End_Nu then  begin

                              //�������ж�
                              Image_inn.Canvas.Polygon(Point_Six_P) ;
                              //����   t_Str_Fir
                              t_Str_Fir.Add(IntTostr( Point_Six_P[0].X )+','+IntTostr( Point_Six_P[0].Y ));
                              t_Str_Fir.Add(IntTostr( Point_Six_P[1].X )+','+IntTostr( Point_Six_P[1].Y ));
                              t_Str_Fir.Add(IntTostr( Point_Six_P[2].X )+','+IntTostr( Point_Six_P[2].Y ));


                              Image_inn.Canvas.Brush.Bitmap:=bitM;
                               //ͼ�����
                                 Image_fill_P.x :=Trunc((Point_Six_P[5].X+Point_Six_P[3].X)/2); Image_fill_P.y:= Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2);
                                 while_image:=true;
                                 k:=0;
                                 while while_image  do begin
                                      if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_Six_P) then begin
                                         Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                         while_image:=false;
                                      end else begin
                                          K:=K+1;
                                          Image_fill_P.x :=Point_Six_P[5].X+K; Image_fill_P.y:=  Point_Six_P[5].Y-1;
                                          if K>5 then  while_image:=false;

                                      end;

                                 end;
                                 Image_inn.Canvas.Brush.Bitmap:=nil;
                                      //��д���ѹ��������
                              YLG_L1.Add(InttoStr(Point_Six_P[2].X)+','+InttoStr(Point_Six_P[2].Y) );
                              YLG_L2.Add(InttoStr(Point_Six_P[2].X-trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[2].Y) );

                              //��һ�� �϶�
                               JinChi_sup:=Jinchi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[3])-2*YockLiang_Suo-step0*0.95;
                               if 10*JinChi_sup<Step0*1.05 then   begin
                                    YanCengQingJiao:=(arctan(Rock_sa/Step0))*10*JinChi_sup/(Step0*1.05);
                                    Sink_leixing:=0;
                               end else begin
                                    YanCengQingJiao:=arctan(Rock_sa/Step0*2);
                                    Sink_leixing:=1;
                               end;

                              Pointxy[0].X :=Point_Six_P[3].X-trunc(0.5*Sink_Sa_used*sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[0].Y :=Point_Six_P[3].Y-trunc((0.5*Sink_Sa_used-0.5*Sink_Sa_used*Cos(YanCengQingJiao))*shiyong_bl);
                              Pointxy[1].X :=Pointxy[0].X +trunc(Sink_Sa_used* sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[1].Y :=Pointxy[0].Y -trunc(Sink_Sa_used* cos(YanCengQingJiao)*shiyong_bl);
                              Pointxy[2].X :=Pointxy[1].X +trunc(0.5*step0* cos(YanCengQingJiao)*shiyong_bl);
                              Pointxy[2].Y :=Pointxy[1].Y +trunc(0.5*step0* sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[3].X :=Pointxy[2].X -trunc(Sink_Sa_used* sin(YanCengQingJiao)*shiyong_bl);
                              Pointxy[3].Y :=Pointxy[2].Y +trunc(Sink_Sa_used* cos(YanCengQingJiao)*shiyong_bl);
                              //�ж��±�  //�������ж�
                                Y_min :=Public_Basic.FindPointY(Pointxy[3].X,Pointxy[3].Y,t_str_sec,Sink_leixing);
                                  Pointxy[2].Y:=Pointxy[2].Y -(Pointxy[3].Y-Y_min);
                                  Pointxy[3].Y:=Y_min;

                                Image_inn.Canvas.Brush.Bitmap:=nil;
                                Image_inn.Canvas.Polygon(Pointxy);
                                   //����   t_Str_Fir
                              t_Str_Fir.Add(IntTostr( Pointxy[1].X )+','+IntTostr( Pointxy[1].Y ));
                              t_Str_Fir.Add(IntTostr( Pointxy[2].X )+','+IntTostr( Pointxy[2].Y ));

                                Image_inn.Canvas.Brush.Bitmap:=bitM;
                                //ͼ�����
                                 Image_fill_P.x :=Trunc((Pointxy[0].X+Pointxy[2].X)/2); Image_fill_P.y:= Trunc((Pointxy[2].Y+Pointxy[3].Y)/2);
                                 while_image:=true;
                                 k:=0;
                                 while while_image  do begin
                                      if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Pointxy) then begin
                                         Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                         while_image:=false;
                                      end else begin
                                          K:=K+1;
                                          Image_fill_P.x :=Pointxy[0].X+K; Image_fill_P.y:=  Pointxy[0].Y-1;
                                          if K>5 then  while_image:=false;

                                      end;

                                 end;
                                  //��������һ�㣬 //���㻭�������
                            // if i=Yc_End_Nu then  begin
                                    Point_wk[3].X := Pointxy[1].X ;
                                    Point_wk[3].Y := Pointxy[1].Y;
                                    Point_wk[2].X := Pointxy[2].X; ;
                                    Point_wk[2].Y := Pointxy[2].Y;

                                    Point_wk[0].X := Point_wk[3].X+40 ;
                                    Point_wk[0].Y := Point_wk[3].Y-40;
                                    Point_wk[1].X := Point_wk[2].X+40;
                                    Point_wk[1].Y := Point_wk[2].Y-40;
                                      Image_inn.Canvas.Brush.Bitmap:=nil;
                                      Image_inn.Canvas.Polygon(Point_wk);
                                      Image_inn.Canvas.Brush.Bitmap:=bitM;
                                        //ͼ�����
                                         Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                         while_image:=true;
                                         k:=0;
                                         while while_image  do begin
                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                 while_image:=false;
                                              end else begin
                                                  K:=K+1;
                                                  Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                  if K>5 then  while_image:=false;
                                              end;

                                         end; // end while

                            //  end;  end  if i=Yc_End_Nu then  begin
                                 Image_inn.Canvas.Brush.Bitmap:=nil;
                                //�ж��³�ֵ
                                  if used_h>rock_sa  then  begin
                                      break_i_105:=105;
                                      rock_sa:=(Pointxy[2].Y-Pointxy[1].Y)/shiyong_bl;
                                  end;
                               //�ж���ʯ�ĸ߶�
                                   if I = Old_beam[0].Start_YC_No then  begin
                                     ganshi_y2:=Pointxy[3].Y;
                                   end;
                               //Ԥ�õڶ���
                                 Point_t_P[2].X :=Pointxy[2].X;
                                 Point_t_P[2].Y :=Pointxy[2].Y;
                                 Point_t_P[3].X :=Pointxy[3].X+trunc(Sink_Sa_used* sin(YanCengQingJiao)*shiyong_bl);
                                 Point_t_P[3].Y :=Pointxy[3].Y;

                                 Point_Six_P[3].X :=inn_Left_x2+trunc((step0+YockLiang_Suo)*shiyong_bl);
                                 if StrToFloat(temp1[3])>0 then begin
                                      Point_Six_P[3].Y :=inn_right_y2-trunc((inn_left_y2-inn_left_y0)*(StrToFloat(temp1[3])-StrToFloat(temp1[1]))/StrToFloat(temp1[3]));
                                 end else begin
                                      Point_Six_P[3].Y :=inn_right_y2;
                                 end;

                                   //�ڶ��� �϶�
                                Point_t_P[0].X  :=Point_Six_P[3].X+trunc(0.5*Sink_Sa_used*sin(YanCengQingJiao)*shiyong_bl);
                                Point_t_P[0].Y :=Point_Six_P[3].Y-trunc((0.5*Sink_Sa_used-0.5*Sink_Sa_used*Cos(YanCengQingJiao))*shiyong_bl);
                                Point_t_P[1].X :=Point_t_P[0].X -trunc(Sink_Sa_used* sin(YanCengQingJiao)*shiyong_bl);
                                Point_t_P[1].Y :=Point_t_P[0].Y -trunc(Sink_Sa_used* cos(YanCengQingJiao)*shiyong_bl);


                                 // ������ѹ�������
                                 if jinChi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-2*YockLiang_Suo  >= Step0*1.05  then begin

                                     while_j:=true; j:=1;
                                     while_j_sup_jinchi:=jinChi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-2*YockLiang_Suo - Step0 ;
                                     Point_Six_P[3].X :=inn_Left_x2+trunc((step0+YockLiang_Suo)*shiyong_bl);
                                     while while_j do
                                      begin
                                          if j<=4 then  begin
                                             while_j_sup_jinchi:= while_j_sup_jinchi-zk.Yc_Rock[i].step_i[j]*0.95;
                                             step_i:=zk.Yc_Rock[i].step_i[j];
                                          end else begin
                                             while_j_sup_jinchi:= while_j_sup_jinchi-zk.Yc_Rock[i].step_i[0]*0.95;
                                             step_i:=zk.Yc_Rock[i].step_i[0];
                                          end;

                                            if while_j_sup_jinchi<0  then begin
                                                  if j>1 then  begin

                                                    Image_inn.Canvas.Brush.Bitmap:=nil;
                                                     //�ж��±�
                                                     Y_min :=Public_Basic.FindPointY(P_i_j_1[3].X,P_i_j_1[3].Y,t_str_sec,Sink_leixing);
                                                        P_i_j_1[2].Y:=P_i_j_1[2].Y -(P_i_j_1[3].Y-Y_min);
                                                        P_i_j_1[3].Y:=Y_min;
                                                     Image_inn.Canvas.Polygon(P_i_j_1);
                                                    //  //����   t_Str_Fir
                                                    t_Str_Fir.Add(IntTostr( P_i_j_1[1].X )+','+IntTostr( P_i_j_1[1].Y ));
                                                    t_Str_Fir.Add(IntTostr( P_i_j_1[2].X )+','+IntTostr( P_i_j_1[2].Y ));
                                                    Image_inn.Canvas.Brush.Bitmap:=bitM;
                                                     //ͼ�����
                                                     Image_fill_P.x :=Trunc((P_i_j_1[0].X+P_i_j_1[2].X)/2); Image_fill_P.y:= Trunc((P_i_j_1[0].Y+P_i_j_1[2].Y)/2);
                                                     while_image:=true;
                                                     k:=0;
                                                     while while_image  do begin
                                                          if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,P_i_j_1) then begin
                                                             Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                             while_image:=false;
                                                          end else begin
                                                              K:=K+1;
                                                              Image_fill_P.x :=P_i_j_1[0].X+K; Image_fill_P.y:=  P_i_j_1[0].Y-1;
                                                              if K>5 then  while_image:=false;
                                                          end;

                                                     end; // end while
                                                         //��������һ�㣬 //���㻭�������
                                                         // if i=Yc_End_Nu then  begin
                                                                Point_wk[3].X := P_i_j_1[1].X ;
                                                                Point_wk[3].Y := P_i_j_1[1].Y;
                                                                Point_wk[2].X := P_i_j_1[2].X; ;
                                                                Point_wk[2].Y := P_i_j_1[2].Y;

                                                                Point_wk[0].X := Point_wk[3].X+40 ;
                                                                Point_wk[0].Y := Point_wk[3].Y-40;
                                                                Point_wk[1].X := Point_wk[2].X+40;
                                                                Point_wk[1].Y := Point_wk[2].Y-40;
                                                                  Image_inn.Canvas.Brush.Bitmap:=nil;
                                                                  Image_inn.Canvas.Polygon(Point_wk);
                                                                  Image_inn.Canvas.Brush.Bitmap:=bitM;
                                                                    //ͼ�����
                                                                         Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                                                         while_image:=true;
                                                                         k:=0;
                                                                         while while_image  do begin
                                                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                                                 while_image:=false;
                                                                              end else begin
                                                                                  K:=K+1;
                                                                                  Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                                                  if K>5 then  while_image:=false;
                                                                              end;

                                                                         end; // end while

                                                         // end;   end  if i=Yc_End_Nu then  begin
                                                     Image_inn.Canvas.Brush.Bitmap:=nil;
                                                  end; //end if j>1
                                                 // while over
                                                 while_j:=false;
                                                 break;

                                            end else begin
                                                   if 10*while_j_sup_jinchi<step_i*1.05 then   begin
                                                        YanCengQingJiao:=(arctan(Rock_sa/step_i))*5*while_j_sup_jinchi/(step_i*1.05);
                                                        Sink_leixing:=0;
                                                   end else begin
                                                        YanCengQingJiao:=arctan(Rock_sa/step_i);
                                                        Sink_leixing:=1;
                                                   end;
                                                   Point_Six_P[3].X :=Point_Six_P[3].X+trunc(step_i*shiyong_bl);
                                                  // Point_t_P
                                                   Pointxy[0].X :=Point_Six_P[3].X+trunc(0.5*Sink_Sa_used*sin(YanCengQingJiao)*shiyong_bl);
                                                   Pointxy[0].Y :=Point_Six_P[3].Y-trunc((0.5*Sink_Sa_used-0.5*Sink_Sa_used*Cos(YanCengQingJiao))*shiyong_bl);
                                                   Pointxy[1].X :=Pointxy[0].X -trunc(Sink_Sa_used* sin(YanCengQingJiao)*shiyong_bl);
                                                   Pointxy[1].Y :=Pointxy[0].Y -trunc(Sink_Sa_used* cos(YanCengQingJiao)*shiyong_bl);
                                                   Pointxy[2].X :=Pointxy[1].X -trunc(step_i* cos(YanCengQingJiao)*shiyong_bl);
                                                   Pointxy[2].Y :=Pointxy[1].Y +trunc(step_i* sin(YanCengQingJiao)*shiyong_bl);
                                                   Pointxy[3].X :=Pointxy[2].X +trunc(Sink_Sa_used* sin(YanCengQingJiao)*shiyong_bl);
                                                   Pointxy[3].Y :=Pointxy[2].Y +trunc(Sink_Sa_used* cos(YanCengQingJiao)*shiyong_bl);
                                                     //�ж��±�
                                                           Y_min :=Public_Basic.FindPointY(Pointxy[3].X,Pointxy[3].Y,t_str_sec,Sink_leixing);
                                                           Pointxy[2].Y:=Pointxy[2].Y -(Pointxy[3].Y-Y_min);
                                                           Pointxy[3].Y:=Y_min;

                                                    //�޶� �ڶ���
                                                    if j=1 then  begin
                                                         Point_t_P[0].X :=Pointxy[3].X;;
                                                         Point_t_P[0].Y :=Pointxy[3].Y;
                                                         Point_t_P[1].X :=Pointxy[2].X;
                                                         Point_t_P[1].Y :=Pointxy[2].Y;
                                                    end else begin
                                                         P_i_j_1[0].X :=Pointxy[3].X;;
                                                         P_i_j_1[0].Y :=Pointxy[3].Y;
                                                         P_i_j_1[1].X :=Pointxy[2].X;
                                                         P_i_j_1[1].Y :=Pointxy[2].Y;
                                                          Image_inn.Canvas.Brush.Bitmap:=nil;
                                                          //�ж��±�
                                                           Y_min :=Public_Basic.FindPointY(P_i_j_1[3].X,P_i_j_1[3].Y,t_str_sec,Sink_leixing);
                                                           P_i_j_1[2].Y:=P_i_j_1[2].Y -(P_i_j_1[3].Y-Y_min);
                                                           P_i_j_1[3].Y:=Y_min;
                                                           Image_inn.Canvas.Polygon(P_i_j_1);
                                                            //  //����   t_Str_Fir
                                                            t_Str_Fir.Add(IntTostr( P_i_j_1[2].X )+','+IntTostr( P_i_j_1[2].Y ));
                                                            t_Str_Fir.Add(IntTostr( P_i_j_1[1].X )+','+IntTostr( P_i_j_1[1].Y ));
                                                           Image_inn.Canvas.Brush.Bitmap:=bitM;
                                                             //ͼ�����
                                                             Image_fill_P.x :=Trunc((P_i_j_1[0].X+P_i_j_1[2].X)/2); Image_fill_P.y:= Trunc((P_i_j_1[0].Y+P_i_j_1[2].Y)/2);
                                                             while_image:=true;
                                                             k:=0;
                                                             while while_image  do begin
                                                                  if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,P_i_j_1) then begin
                                                                     Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                                     while_image:=false;
                                                                  end else begin
                                                                      K:=K+1;
                                                                      Image_fill_P.x :=P_i_j_1[0].X+K; Image_fill_P.y:=  P_i_j_1[0].Y;
                                                                      if K>5 then  while_image:=false;
                                                                  end;

                                                             end; // end while
                                                             //��������һ�㣬 //���㻭�������
                                                             // if i=Yc_End_Nu then  begin
                                                                    Point_wk[3].X := P_i_j_1[1].X ;
                                                                    Point_wk[3].Y := P_i_j_1[1].Y;
                                                                    Point_wk[2].X := P_i_j_1[2].X; ;
                                                                    Point_wk[2].Y := P_i_j_1[2].Y;

                                                                    Point_wk[0].X := Point_wk[3].X+40 ;
                                                                    Point_wk[0].Y := Point_wk[3].Y-40;
                                                                    Point_wk[1].X := Point_wk[2].X+40;
                                                                    Point_wk[1].Y := Point_wk[2].Y-40;
                                                                      Image_inn.Canvas.Brush.Bitmap:=nil;
                                                                      Image_inn.Canvas.Polygon(Point_wk);
                                                                      Image_inn.Canvas.Brush.Bitmap:=bitM;
                                                                       //ͼ�����
                                                                         Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                                                         while_image:=true;
                                                                         k:=0;
                                                                         while while_image  do begin
                                                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                                                 while_image:=false;
                                                                              end else begin
                                                                                  K:=K+1;
                                                                                  Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                                                  if K>5 then  while_image:=false;
                                                                              end;

                                                                         end; // end while

                                                              //end;  //end  if i=Yc_End_Nu then  begin
                                                             Image_inn.Canvas.Brush.Bitmap:=nil;
                                                    end;


                                                   //
                                                   if while_j_sup_jinchi< step_i* 0.1 then  begin
                                                       Image_inn.Canvas.Brush.Bitmap:=nil;
                                                       //�ж��±�
                                                           Y_min :=Public_Basic.FindPointY(Pointxy[3].X,Pointxy[3].Y,t_str_sec,Sink_leixing);
                                                              Pointxy[2].Y:=Pointxy[2].Y -(Pointxy[3].Y-Y_min);
                                                              Pointxy[3].Y:=Y_min;
                                                        Image_inn.Canvas.Polygon(Pointxy);
                                                         //  //����   t_Str_Fir
                                                        t_Str_Fir.Add(IntTostr(Pointxy[1].X)+','+IntTostr(Pointxy[1].Y ));
                                                        t_Str_Fir.Add(IntTostr(Pointxy[2].X )+','+IntTostr( Pointxy[2].Y ));
                                                         Image_inn.Canvas.Brush.Bitmap:=bitM;
                                                        //ͼ�����
                                                       Image_fill_P.x :=Trunc((Pointxy[0].X+Pointxy[2].X)/2); Image_fill_P.y:= Trunc((Pointxy[0].Y+Pointxy[2].Y)/2);
                                                       while_image:=true;
                                                       k:=0;
                                                       while while_image  do begin
                                                            if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Pointxy) then begin
                                                               Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                               while_image:=false;
                                                            end else begin
                                                                K:=K+1;
                                                                Image_fill_P.x :=Pointxy[0].X+K; Image_fill_P.y:=  Pointxy[0].Y;
                                                                if K>5 then  while_image:=false;

                                                            end;

                                                       end;
                                                       //��������һ�㣬 //���㻭�������
                                                        //  if i=Yc_End_Nu then  begin
                                                                Point_wk[3].X := Pointxy[1].X ;
                                                                Point_wk[3].Y := Pointxy[1].Y;
                                                                Point_wk[2].X := Pointxy[2].X; ;
                                                                Point_wk[2].Y := Pointxy[2].Y;

                                                                Point_wk[0].X := Point_wk[3].X+40 ;
                                                                Point_wk[0].Y := Point_wk[3].Y-40;
                                                                Point_wk[1].X := Point_wk[2].X+40;
                                                                Point_wk[1].Y := Point_wk[2].Y-40;
                                                                  Image_inn.Canvas.Brush.Bitmap:=nil;
                                                                  Image_inn.Canvas.Polygon(Point_wk);
                                                                  Image_inn.Canvas.Brush.Bitmap:=bitM;
                                                                    //ͼ�����
                                                                         Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                                                         while_image:=true;
                                                                         k:=0;
                                                                         while while_image  do begin
                                                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                                                 while_image:=false;
                                                                              end else begin
                                                                                  K:=K+1;
                                                                                  Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                                                  if K>5 then  while_image:=false;
                                                                              end;

                                                                         end; // end while

                                                       //   end;   // end  if i=Yc_End_Nu then  begin
                                                       Image_inn.Canvas.Brush.Bitmap:=nil;
                                                       //while over
                                                       while_j:=false;
                                                       break;
                                                   end else begin
                                                       P_i_j_1[0].X:=  Pointxy[0].X ; P_i_j_1[0].Y:=  Pointxy[0].Y ;
                                                       P_i_j_1[1].X:=  Pointxy[1].X ; P_i_j_1[1].Y:=  Pointxy[1].Y ;
                                                       P_i_j_1[2].X:=  Pointxy[2].X ; P_i_j_1[2].Y:=  Pointxy[2].Y ;
                                                       P_i_j_1[3].X:=  Pointxy[3].X ; P_i_j_1[3].Y:=  Pointxy[3].Y ;
                                                       j:=j+1;
                                                   end;


                                            end;  //end if while_j_sup_jinchi<0  then begin


                                      end; // end while
                               end;  // end if  jinChi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-2*YockLiang_Suo  > Step0*1.05  then begin
                                    //��ֵ

                                 //inn_left_x2 := Point_Six_P[2].X ;
                                      //draw �Ҳ� �϶�
                                 Point_Six_P[5].X :=Image_inn.Width;
                                      Point_Six_P[5].Y :=inn_left_y0;
                                 if StrToFloat(temp1[3])>0 then begin
                                      Point_Six_P[3].Y :=inn_right_y2-trunc((inn_left_y2-inn_left_y0)*(StrToFloat(temp1[3])-StrToFloat(temp1[1]))/StrToFloat(temp1[3]));
                                 end else begin
                                      Point_Six_P[3].Y :=inn_right_y2;
                                 end;

                            end ;//end    if jinChi+zhijia.Zj_KongdingJU+2*StrToFloat(temp1[1])-2*YockLiang_Suo< Step0 * 0.95  then  begin
                                  // ���ڶ���
                                         Image_inn.Canvas.Brush.Bitmap:=nil;
                                          //�ж��±�
                                         Y_min :=Public_Basic.FindPointY(Point_t_P[3].X,Point_t_P[3].Y,t_str_sec,Sink_leixing);
                                            Point_t_P[2].Y:=Point_t_P[2].Y -(Point_t_P[3].Y-Y_min);
                                            Point_t_P[3].Y:=Y_min;

                                         Image_inn.Canvas.Polygon(Point_t_P);
                                           //  //����   t_Str_Fir
                                          t_Str_Fir.Insert(5,IntTostr( Point_t_P[2].X )+','+IntToStr( Point_t_P[2].Y ));
                                          t_Str_Fir.Insert(6,IntTostr( Point_t_P[1].X )+','+IntToStr( Point_t_P[1].Y ));

                                         Image_inn.Canvas.Brush.Bitmap:=bitM;

                                         //ͼ�����
                                         Image_fill_P.x :=Trunc((Point_t_P[0].X+Point_t_P[2].X)/2); Image_fill_P.y:= Trunc((Point_t_P[0].Y+Point_t_P[2].Y)/2);
                                         while_image:=true;
                                         k:=0;
                                         while while_image  do begin
                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_t_P) then begin
                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                 while_image:=false;
                                              end else begin
                                                  K:=K+1;
                                                  Image_fill_P.x :=Point_t_P[0].X-K; Image_fill_P.y:=  Point_t_P[0].Y-1;
                                                  if K>5 then  while_image:=false;

                                              end;

                                         end;
                                          //��������һ�㣬 //���㻭�������
                                                       //   if i=Yc_End_Nu then  begin
                                                                Point_wk[3].X := Point_t_P[2].X ;
                                                                Point_wk[3].Y := Point_t_P[2].Y;
                                                                Point_wk[2].X := Point_t_P[1].X; ;
                                                                Point_wk[2].Y := Point_t_P[1].Y;

                                                                Point_wk[0].X := Point_wk[3].X+40 ;
                                                                Point_wk[0].Y := Point_wk[3].Y-40;
                                                                Point_wk[1].X := Point_wk[2].X+40;
                                                                Point_wk[1].Y := Point_wk[2].Y-40;
                                                                  Image_inn.Canvas.Brush.Bitmap:=nil;
                                                                  Image_inn.Canvas.Polygon(Point_wk);
                                                                  Image_inn.Canvas.Brush.Bitmap:=bitM;
                                                                   //ͼ�����
                                                                         Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                                                         while_image:=true;
                                                                         k:=0;
                                                                         while while_image  do begin
                                                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                                                 while_image:=false;
                                                                              end else begin
                                                                                  K:=K+1;
                                                                                  Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                                                  if K>5 then  while_image:=false;
                                                                              end;

                                                                         end; // end while

                                                         // end;   //end  if i=Yc_End_Nu then  begin
                                                       Image_inn.Canvas.Brush.Bitmap:=nil;
                                         Image_inn.Canvas.Brush.Bitmap:=nil;

                                  //draw �Ҳ� �϶�
                                 Point_Six_P[0].X :=Point_Six_P[5].X;
                                       Point_Six_P[0].Y :=Point_Six_P[5].Y-trunc(used_h*shiyong_bl);
                                 Point_Six_P[2].X :=Point_Six_P[3].X;
                                       Point_Six_P[2].Y :=Point_Six_P[3].Y-trunc(used_h*shiyong_bl);
                                  Point_Six_P[4].X :=Point_Six_P[3].X + trunc((StrToFloat(temp1[3])-StrToFloat(temp1[1]))*shiyong_bl);
                                       Point_Six_P[4].Y :=Point_Six_P[5].Y;
                                  Point_Six_P[1].X :=Point_Six_P[4].X;
                                       Point_Six_P[1].Y :=Point_Six_P[0].Y;

                                  Image_inn.Canvas.Polygon(Point_Six_P) ;
                                    //  //����   t_Str_Fir
                                  t_Str_Fir.Add(IntTostr( Point_Six_P[2].X )+','+IntTostr( Point_Six_P[2].Y ));
                                  t_Str_Fir.Add(IntTostr( Point_Six_P[1].X )+','+IntTostr( Point_Six_P[1].Y ));
                                  t_Str_Fir.Add(IntTostr( Point_Six_P[0].X )+','+IntTostr( Point_Six_P[0].Y ));

                                  Image_inn.Canvas.Brush.Bitmap:=bitM;
                                               if  (Point_Six_P[4].Y-Point_Six_P[1].Y>4)  then
                                                    Image_inn.Canvas.FloodFill(Trunc((Point_Six_P[0].X+Point_Six_P[3].X)/2),Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2),clBlack,fsBorder);
                                 Image_inn.Canvas.Brush.Bitmap:=nil;
                                    //��д�Ҳ�ѹ��������
                                  YLG_R1.Insert(0,InttoStr(Point_Six_P[2].X)+','+InttoStr(Point_Six_P[2].Y) );
                                  YLG_R2.insert(0,InttoStr(Point_Six_P[2].X+trunc(StrToFloat(temp1[4])*shiyong_bl))+','+InttoStr(Point_Six_P[2].Y) );

                                  //��������һ�㣬 //���㻭�������
                             // if i=Yc_End_Nu then  begin
                                    Point_wk[3].X := Point_Six_P[2].X ;
                                    Point_wk[3].Y := Point_Six_P[2].Y;
                                    Point_wk[2].X := Point_Six_P[0].X; ;
                                    Point_wk[2].Y := Point_Six_P[0].Y;

                                    Point_wk[0].X := Point_wk[3].X+40 ;
                                    Point_wk[0].Y := Point_wk[3].Y-40;
                                    Point_wk[1].X := Point_wk[2].X+40;
                                    Point_wk[1].Y := Point_wk[2].Y-40;
                                      Image_inn.Canvas.Brush.Bitmap:=nil;
                                      Image_inn.Canvas.Polygon(Point_wk);
                                      Image_inn.Canvas.Brush.Bitmap:=bitM;
                                        //ͼ�����
                                         Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                         while_image:=true;
                                         k:=0;
                                         while while_image  do begin
                                              if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                                 Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                                 while_image:=false;
                                              end else begin
                                                  K:=K+1;
                                                  Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                  if K>5 then  while_image:=false;
                                              end;

                                         end; // end while

                             // end;  //end  if i=Yc_End_Nu then  begin

                            //���������һ�������
                             YockLiang_Suo:=YockLiang_Suo+used_h*tan(25/180*3.1415926);
                             inn_left_y0:=Point_Six_P[0].Y ;inn_left_y2:=Point_Six_P[2].Y; inn_right_y2:= inn_left_y2;

                             t_str_sec.Clear;
                             t_str_sec.Text:=t_str_fir.Text;
                             s_out:=t_str_sec.Text;
                             t_str_fir.Clear ;

                 end; //end for i

                   //�϶� �� �ڵ�ǰ�ƽ������� �������Ҳ�
                  if i>= 0 then  begin
                       for j := i downto model_start_yc do  begin
                            Pointxy[0].X :=0 ;

                              if (j=imm.End_No) and (imm.Surplus_h>0) then    begin
                                  used_h :=imm.Surplus_h;
                              end else begin
                                  used_h:=zk.Yc_Rock[j].R_h;
                              end;


                            if j<old.yl_max_End -2  then    begin
                                Pointxy[0].Y :=inn_left_y0-trunc((used_h*hcd_bl)*shiyong_bl);
                             end else begin
                                Pointxy[0].Y :=inn_left_y0-trunc((used_h)*shiyong_bl);
                             end;

                            Pointxy[1].X :=Image_inn.Width ;
                            Pointxy[1].Y :=Pointxy[0].Y;
                            Pointxy[2].X :=Pointxy[1].X  ;
                            Pointxy[2].Y :=inn_left_y0;
                            Pointxy[3].X :=Pointxy[0].X ;
                            Pointxy[3].Y :=Pointxy[2].Y ;
                            Image_inn.Canvas.Brush.Bitmap:=nil;
                         //���ͼ��
                            bitM.FreeImage;
                            if Tuxing=0 then   begin
                              if  fileexists(dll_Path+'\BmpSi\'+zk.Yc_Rock[j].R_Name+'.Bmp') then  begin
                                  bitM.LoadFromFile(dll_Path+'\BmpSi\'+zk.Yc_Rock[j].R_Name+'.Bmp');//װ��ͼ���ļ�
                              end else begin
                                  bitM.LoadFromFile(dll_Path+'\BmpSi\NULL.Bmp');
                              end;

                            end else begin
                                if  fileexists(dll_Path+'\BmpFZ\'+zk.Yc_Rock[j].R_Name+'.Bmp') then  begin
                                  bitM.LoadFromFile(dll_Path+'\BmpFZ\'+zk.Yc_Rock[j].R_Name+'.Bmp');//װ��ͼ���ļ�
                                end else begin
                                  bitM.LoadFromFile(dll_Path+'\BmpFz\NULL.Bmp');
                                end;

                            end; // end if Tuxing
                                Image_inn.Canvas.Brush.Bitmap:=nil;
                                Image_inn.Canvas.Polygon(Pointxy);
                                Image_inn.Canvas.Brush.Bitmap:=bitM;
                                 if   (Pointxy[2].Y-Pointxy[1].Y>4)  then
                                        Image_inn.Canvas.FloodFill(Trunc((Pointxy[0].X+Pointxy[2].X)/2),Trunc((Pointxy[0].Y+Pointxy[2].Y)/2),clBlack,fsBorder);
                                Image_inn.Canvas.Brush.Bitmap:=nil;

                            //��������һ�㣬 //���㻭�������
                            //  if j=Yc_End_Nu then  begin
                                    Point_wk[3].X := Pointxy[0].X ;
                                    Point_wk[3].Y := Pointxy[0].Y;
                                    Point_wk[2].X := Pointxy[1].X ;
                                    Point_wk[2].Y := Pointxy[1].Y;

                                    Point_wk[0].X := Point_wk[3].X+40 ;
                                    Point_wk[0].Y := Point_wk[3].Y-40;
                                    Point_wk[1].X := Point_wk[2].X+40;
                                    Point_wk[1].Y := Point_wk[2].Y-40;
                                      Image_inn.Canvas.Brush.Bitmap:=nil;
                                      Image_inn.Canvas.Polygon(Point_wk);
                                      Image_inn.Canvas.Brush.Bitmap:=bitM;
                                         //ͼ�����
                                       Image_fill_P.x :=Trunc((Point_wk[0].X+Point_wk[2].X)/2); Image_fill_P.y:= Trunc((Point_wk[0].Y+Point_wk[2].Y)/2);
                                       while_image:=true;
                                       k:=0;
                                       while while_image  do begin
                                            if Public_Basic.IsPtInPoly (Image_fill_P.x,Image_fill_P.y,Point_wk) then begin
                                               Image_inn.Canvas.FloodFill(Image_fill_P.x ,Image_fill_P.y,clBlack,fsBorder);
                                               while_image:=false;
                                            end else begin
                                                K:=K+1;
                                                Image_fill_P.x :=Point_wk[0].X+K; Image_fill_P.y:=  Point_wk[0].Y;
                                                if K>5 then  while_image:=false;
                                            end;

                                       end; // end while

                             // end;  end  if i=Yc_End_Nu then  begin

                           inn_left_y0:=Pointxy[0].Y;
                       end;  //end for j

                         
                  end;  // end if  i   }

               // �� ������ʯ
                     if ganshi_Count>0 then  begin
                            Point_Six_P[0].X :=trunc(gzm.ZCYL_sx[2]*shiyong_bl)+2;
                                 Point_Six_P[0].Y :=ganshi_y0;
                                 if ganshi_y2>0 then   begin
                                     Point_Six_P[1].Y:=ganshi_y0+trunc((ganshi_y2-ganshi_y0)*0.5);
                                     Point_Six_P[2].Y:=ganshi_y2;

                                 end else begin
                                     Point_Six_P[1].Y :=ganshi_y0-trunc(ganshi_h*0.5*shiyong_bl);
                                     Point_Six_P[2].Y :=ganshi_y0-trunc(ganshi_h*shiyong_bl);
                                 end;

                            Point_Six_P[1].X := Point_Six_P[0].X+trunc((Point_Six_P[0].Y -Point_Six_P[1].Y )*tan(10/180*3.14159));

                            Point_Six_P[4].X :=ganshi_right_x4-trunc((Point_Six_P[0].Y -Point_Six_P[1].Y )*tan(15/180*3.14159));;
                                 Point_Six_P[4].Y :=Point_Six_P[1].Y ;

                            Point_Six_P[2].X :=Point_Six_P[1].X+trunc((Point_Six_P[1].Y -Point_Six_P[2].Y )*tan(30/180*3.14159));
                            Point_Six_P[3].X :=Point_Six_P[4].X-trunc((Point_Six_P[1].Y -Point_Six_P[2].Y )*tan(30/180*3.14159));
                                 Point_Six_P[3].Y :=Point_Six_P[2].Y;

                            Point_Six_P[5].X :=ganshi_right_x4;
                                 Point_Six_P[5].Y :=Point_Six_P[0].Y;

                            Image_inn.Canvas.Brush.Bitmap:=nil;
                            Image_inn.Canvas.Polygon(Point_Six_P) ;
                             //���ͼ��
                             bitM.FreeImage;
                              if Tuxing=0 then   begin
                                if  fileexists(dll_Path+'\BmpSi\��ʯ.Bmp') then  begin
                                    bitM.LoadFromFile(dll_Path+'\BmpSi\��ʯ.Bmp');//װ��ͼ���ļ�
                                end else begin
                                    bitM.LoadFromFile(dll_Path+'\BmpSi\NULL.Bmp');
                                end;

                               end else begin
                                  if  fileexists(dll_Path+'\BmpFZ\��ʯ.Bmp') then  begin
                                    bitM.LoadFromFile(dll_Path+'\BmpFZ\��ʯ.Bmp');//װ��ͼ���ļ�
                                  end else begin
                                    bitM.LoadFromFile(dll_Path+'\BmpFz\NULL.Bmp');
                                  end;
                              end;
                            Image_inn.Canvas.Brush.Bitmap:=bitM;
                               if  (Point_Six_P[0].Y-Point_Six_P[2].Y>4)  then
                                    Image_inn.Canvas.FloodFill(Trunc((Point_Six_P[0].X+Point_Six_P[3].X)/2),Trunc((Point_Six_P[1].Y+Point_Six_P[4].Y)/2),clBlack,fsBorder);

                            Image_inn.Canvas.Brush.Bitmap:=nil;  
                    end;
        //��֧��ѹ����
        //���
        drawZcyl(Image_inn,zcyl_l_p1,zcyl_L_p2,temp1,shiyong_bl,false);
        drawZcyl(Image_inn,zcyl_R_p1,zcyl_R_p2,temp1,shiyong_bl,true);
        //֧��ѹ��ƽ�⹰
        if disp_ylg=1 then  begin
           draw_ylg(Image_inn,YLG_L1,YLG_L2,YLG_R1,YLG_R2);

        end;
      
      StretchBlt(Image_out.Canvas.Handle,LeftBlank+1,topBlank+1,Image_out.Width-RightBlank-leftBlank-1,Image_out.Height-BottomBlank-TopBlank-1,Image_inn.Canvas.Handle,X_move_pix,1,Image_out.Width-RightBlank-LeftBlank-1,Image_inn.Height-1,SRCCOPY);
     // bitblt(Image_out.Canvas.Handle,LeftBlank+1,topBlank+1,Image_out.Width-RightBlank-leftBlank-1,Image_out.Height-BottomBlank-TopBlank-1,Image_inn.Canvas.Handle,+X_move_pix,1,SRCCOPY);

      bitmap.Free;
      bitM.free;
      Image_inn.Free;
      result:=X_move_pix;
      FreeAndnil(t_Str_Fir);
      FreeAndnil(t_Str_sec);
      FreeAndnil(YLG_L1);
      FreeAndnil(YLG_L2);
      FreeAndnil(YLG_R1);
      FreeAndnil(YLG_R2);
      //�� ֧��ѹ������
    
end; //end procedure draw_fyyd



{ TMainClass_PStope }

constructor TMainClass_PStope.Create;
begin
       t_Gzm:=TG_Stope.Create ;     //������
       t_zk:=Tzk_bore.Create ;     //���
       t_imm_r:=TImmediate_roof.Create; //ֱ�Ӷ�
       t_old:=Told_roof.Create;    //�϶�
       t_ZhiJia:=TZJ_Class.Create;  //֧��
       t_Cal_show:=TCal_Show.Create;
end;

destructor TMainClass_PStope.Destroy;

begin
   freeAndNil(t_Gzm);     //������
   freeAndNil(t_zk) ;     //���
   freeAndNil(t_imm_r) ; //ֱ�Ӷ�
   freeAndNil(t_old) ;    //�϶�
   freeAndNil(t_ZhiJia) ;  //֧��
   freeAndNil(t_Cal_show);
   inherited Destroy;
end;

function TMainClass_PStope.Get_Edit_ZkCS: WideString;
begin
   Result:=t_zk.Return_ZkCs;
end;

function TMainClass_PStope.Get_Stope_info: string;
var
  EStr:String;
  MPa_Xs,kongding_s,liz_s,D:double;
begin
    kongding_s:=t_ZhiJia.Zj_KongdingJU*t_ZhiJia.Zj_zhongxinju;
    //����������ֱ��
    if t_ZhiJia.Zj_Lz_Diameter=0 then begin
       D:=320 ;
    end  else D:=t_ZhiJia.Zj_Lz_Diameter;
    liz_s:=0.25*3.1415926*(D/1000)*(D/1000);
    if t_ZhiJia.Zj_Lizhu_count=0 then  t_ZhiJia.Zj_Lizhu_count:=2;
    MPa_Xs:= t_ZhiJia.zj_toall_P* kongding_s/liz_s/t_ZhiJia.Zj_Lizhu_count;  //�����MPaϵ��

    EStr:=FormatFloat('0.00',t_old.YL_Zhouqi_step[0])+',' + //������ѹ�������ֵ
          FormatFloat('0.00',t_old.YL_Zhouqi_step[1])+',' + //������ѹ����Сֵ
          FormatFloat('0.00',t_old.YL_Zhouqi_step[2])+',' + //������ѹ����ƽ��ֵ
          FormatFloat('0.00',t_ZhiJia.Zj_imm_p*MPa_Xs )+',' + //ֱ�Ӷ�֧��ǿ��
          FormatFloat('0.00',t_ZhiJia.Zj_JiSuan_Ci_P[0]*MPa_Xs )+',' + //�϶�֧��ǿ�����ֵ
          FormatFloat('0.00',t_ZhiJia.Zj_JiSuan_Ci_P[1]*MPa_Xs )+',' + //�϶�֧��ǿ����Сֵ
          FormatFloat('0.00',t_ZhiJia.Zj_JiSuan_Ci_P[2]*MPa_Xs )+',' + //�϶�֧��ǿ��ƽ��ֵ
          ' ' ;
   Result:=Estr;

end;

function TMainClass_PStope.InitModel(GzmStr, ZkStr: String;Var sEorr:String): Boolean;
Var
  StrE:wideString;
begin
     Result:=false;
     if (not (t_Gzm.Init(GzmStr,StrE))  or  (not T_Zk.Init(ZkStr,StrE)))   then  begin
       //MyMainFun.WriteLog('Eorr: GetGzmZkStr/UsedDrill.Zk_Yc_Count<1','[TGZM]');
       exit;
     end;

      //��������
     if not T_imm_r.init(T_gzm,t_zk,0.5,StrE) then   exit;
     if not t_old.init(t_Gzm,t_zk,t_imm_r,StrE) then  exit;
     Cal_Zcyl(t_zk,t_imm_r,t_gzm,t_old,StrE);
     Cal_Ldg(t_zk,t_gzm,t_imm_r,t_old,t_gzm.S_L_qx*1.5,StrE);
     sEorr:=StrE;
     Result:=true;
end;

procedure TMainClass_PStope.Set_Old_Step(MaxValue, MinValue, AGVVale: Double);
var
   Flag:Boolean;
   StepD:double;
   AddOrMin,i,AdjustCount:integer;
   sEorr:widestring;
begin
    Flag:=true;
    StepD:=0.5;
    AddOrMin:=0;
    if AGVVale< t_old.YL_Zhouqi_step[2]*0.9 then  AGVVale:= t_old.YL_Zhouqi_step[2]*0.9 ;
    if AGVVale > t_old.YL_Zhouqi_step[2]*1.1 then  AGVVale:= t_old.YL_Zhouqi_step[2]*1.1 ;
    AdjustCount:=0; //���ڴ���,��ֹѭ��
    while Flag do  begin
        if AGVVale >t_old.YL_Zhouqi_step[2]+0.5 then  begin   //ʵ�ʾ��볬���������
           if AddOrMin=-1 then   StepD:=StepD/2;
           AddOrMin:=1; AdjustCount:=AdjustCount+1;

            for I := t_old.YL_min_End+1 to t_old.YL_start do
               t_zk.Yc_Rock[i].R_klqd:=t_zk.Yc_Rock[i].R_klqd+StepD;

        end else  if AGVVale <t_old.YL_Zhouqi_step[2]-0.5  then  begin     //ʵ�ʾ���С�ڼ������
          if AddOrMin=1 then   StepD:=StepD/2;
           AddOrMin:=-1; AdjustCount:=AdjustCount+1;
            for I := t_old.YL_min_End+1 to t_old.YL_start do
               t_zk.Yc_Rock[i].R_klqd:=t_zk.Yc_Rock[i].R_klqd-StepD;
        end else  begin
           Flag:=False;
        end;

         //���¼���
          T_imm_r.init(T_gzm,t_zk,0.5,sEorr);  //  ֱ�Ӷ�����
          t_old.init(t_Gzm,t_zk,t_imm_r,sEorr); //   �϶�����
          t_zhijia.Cal_Sup_Para(T_gzm,t_zk,T_imm_r,t_old);// ֧�ܼ���
          Cal_Zcyl(t_zk,t_imm_r,t_gzm,t_old,sEorr);  //����֧��ѹ���ֲ�
          Cal_Ldg(t_zk,t_gzm,t_imm_r,t_old,t_gzm.S_L_qx*1.5,sEorr);//�����Ѷϴ��߶�
       // ��ֹ��������ֹ������ѭ��
       if AdjustCount >10  then Flag:=False;
    end;
end;

end.       //��ģ�������ǣ����ܸ��ģ�������
