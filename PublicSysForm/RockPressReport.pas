unit RockPressReport;

interface
uses
  Winapi.Windows,System.SysUtils,Vcl.ExtCtrls,unWord_Lu,PStope_GzmGuidClass ,
  uDrawGraphClass,Word2000, Vcl.ComCtrls,System.Classes,Vcl.Forms,
  UICallPstope, UMakeRuleClass;

type
    TWordReport = class(TMyWord)

    private
        ExHandle:THandle;
        iDwGrap:TDrawGrap;
        iCallPStope:TDefine_CallPStope; // �ɿ��㷨��
        innWord:TMyWord;
        SencentId:integer;
        ReportInputData:TDataFrequency;
        Second_Tab_id,third_Tab_id,Fhird_Tu_id:integer;
        fuLu_Tu_id:integer;
        Yu_Start_id,Yu_End_id:integer;//��ͼ��ʼ��������
        ForCaseTuid:integer;// Ԥ��ͼ���
        PinPutuid,TongjiTuid :integer;//����Ƶ��ͼ��� ͳ��ͼ ���
        Subject_Str:TStringList; //�����ַ���
        ForceExit:Boolean;
        MainPanel:TPanel; // WordPanel
        function  Get_Cmff(id:integer):String;         //��ú����
        function  Get_Coal_F(id:integer):String;       //ú��Ӧ��
        function  Get_JYHD(id:integer):String;           //���Һ��
        function  Get_HangDao_Stress(id:integer):String; //���ѹ��
        function  Get_HangDao_support(id:integer):String; //���֧����ʽ
        function  Get_support_type(id:integer):String; //֧���ͺ�
        function  Get_DZGZ(id:integer):String;  //���ʹ���
        function  Get_WSFC(id:integer):String;  //��˹����
        function  Get_TopWater(id:integer):String;  //����ˮԴ
        function  Get_BottomWater(id:integer):String;  //�ذ�ˮԴ
        function  Get_RockPress(id:integer):String;  //��ѹ���
        function  Get_YxFx(id:integer):String;  //��б�븩б
        // main Myword
        Procedure CreateWordClass();
        procedure FreeMyWordClass();
        procedure AddDocmentTitle(CoalName,WorkFaceName,ReportType:String);
        procedure ADDWorkFaceInFo_1(inGzm:TGzm);
        procedure ADDDrilleInFo_2(inGzm:TGzm);
        procedure AddFYYDInfo_3(inGzm:TGzm;ReportType:String);
        procedure AddYDFZInfo_4(inGzm:TGzm);
        procedure AddSupportInfo_5(inGzm:TGzm);
        procedure AddSupSubject_6(inGzm:TGzm);

        //------------------
        procedure AddYklhInfo_5(inGzm:TGzm);
        procedure AddYklhInfo_5_2;

        procedure Add_disclaimer(Xhstr:String);

       //
        procedure DeleteBmPFile;
        function  isExsitBmpFile(BmpFile:string):Boolean;
        function  Report_Zcyl(inGzm:TGzm):Boolean;
        //report ��ѹ����
        procedure Add_Kyfx_Cover(CoalName, WorkFaceName:String);    // �����������
        procedure Add_WorkFace_BasicInformation(inGzm:TGZM);
        procedure ADD_Abstric; // ժҪ
        procedure ADD_Fuhaoshuming;// ����˵��
        procedure Add_FYYD_2(inGzm:TGZM);
        // ������
        procedure Add_Second_Secents(inGZm:TGzm);
        procedure Add_Second_QianYan;
        procedure Add_Second_First_main(P_Str:string;inGZm:TGzm);// 3.1 ���ݷ�������
        procedure Add_Second_First(P_Str:string;inGZm:TGzm);// 3.1  ��Ҫ��������
        procedure Add_Second_Two_Table_1(P_Str:string;inGZm:TGzm;phaseNumber:integer);// 3.2.*   ��������ͳ�Ʒ�����
        function  Add_Second_Two_Table_fulu_Bmp(PhaseNumber:Integer):string;// ����¼���� ͼ��
        procedure Add_Second_Two_Table_2(P_Str:string;inGZm:TGzm;phaseNumber:integer); //3.2.*   ͳ�ƽ������
        procedure Add_Second_Two_Jielun(P_Str:string;inGZm:TGzm);// 3.3 ����
        // ������
        procedure Add_Third_Secents(inGZm:TGzm);
        procedure Add_Third_QianYan; // ������ά�����������




        procedure Add_Third_one_Main(P_Str:string;inGZm:TGzm);// 3.2 ���س���
        procedure Add_Third_one_First(P_Str:string;inGZm:TGzm);// 3.2.1  ��������Ҫ����
        Procedure ADd_Third_one_First_Table(P_Str:string;Modify:integer);// ���ӱ���
        procedure Add_Third_one_First_Table_Chlid(phaseNumber:integer;OneStepIn: TcomprehensiveOldStep;
           sup_st,sup_ed:integer;itab:Table; var come_i,iRow:integer);// Ϊ���ӱ������

        procedure Add_Third_two_Main(P_Str:string;inGZm:TGzm);// 3.3  �ֽ׶���ѹ��Ϣ ͨ��
        procedure Add_Third_two_one(phaseNumber,P_c,modify:integer;P_Str:string;inGZm:TGzm);// 3.3  ��������ѹ��Ϣ ͨ��
        function  Add_Third_two_Main_Chlid_Add_fulu_Bmp(PhaseNumber:Integer):string;// ����¼���� ͼ��

        procedure Add_fourth_Secents(inGZm:TGzm);// �������������
        procedure Add_fourth_QianYan; // ���۵�ǰ��
        procedure Add_fourth_one(P_Str:string;inGZm:TGzm);// 5.1 ����
        procedure Add_fourth_two(P_Str:string;inGZm:TGzm);// 5.2 ����
        procedure Add_fourth_three(P_Str:string;inGZm:TGzm);// 5.3 ����
        procedure Add_Fourth_Four(P_Str:string;inGZm:TGzm);//5.4 Ԥ��


        procedure ProDisposeFiveDataType;
        procedure Add_Fulu_TuFirstToFive;//�� ��¼ǰ�������ͼ�������ˡ�
        function  ReturnDataTypeName(Value:integer):String;

        // ��������
        procedure Add_Support_Information(inGzm:TGzm);
        function  ReturnTimeToChinese(dt:TdateTime):String;

        procedure Add_Contents;// ����Ŀ¼
        procedure ADD_Fulu;//������¼
        procedure ADd_HouJi;//�������
        procedure Add_FuLuTu(tuOrTable,id :integer;title,Memo,FileName:string);
        function  ReturnFileName(FileType:String;L_Min,L_Max:integer;DataType,lx:integer):String;
        procedure InsertPageSetupWater(Path:string);
        procedure ChangePictureWidth(Path:string) ;


    public

        procedure ReportZhijia(AHandle:THandle;inGzm:TGzm); //��ӡ֧�ܱ���
        procedure ReportYklh(AHandle:THandle;inGzm:TGzm);//  ��ӡ�ؿ�����
        //
        procedure SetDrawGraph(iDw:TDrawGrap;iCallP:TDefine_CallPStope);

        function ReportAnsysisRockPress(AHandle:THandle;inGzm:TGZM;ExWord:Boolean):Boolean;
        procedure SetReportExit(Value:Boolean);
        procedure SetWordPanel(iPanel:TPanel);
        procedure ReSize;
        procedure KillWord;

        constructor Create;
        destructor  Destroy;

    end;


implementation

{ TWordReport }

uses UMainDataModule, Lu_Public_BasicModual,IOUtils, UForm_ContourGraph,
  UForm_Brand_Bar, UForm_LineGraph, RockPresstool,math,TypInfo,
  UForm_phaseGraph_Tongji;
Procedure CreateWordClass(MyUseWord:TMyWord);
begin

end;

procedure TWordReport.AddDocmentTitle(CoalName, WorkFaceName,ReportType: String );
var
  title:String;
  i:integer;
begin
    with innWord do begin
         if ReportType='Support' then  begin
            title:=CoalName+'��'+WorkFaceName+'��Һѹ֧��ѡ�ͱ���';
         end else if ReportType='Yklh' then begin
            title:=CoalName+'��'+WorkFaceName+'���ؿ����＼������';
         end;

         SetFont('����_GB2312',18,false,false);
         AlignLine(1);  //����
         SetHeading(title,1); //�������

    end;
end;

procedure TWordReport.ADDDrilleInFo_2( inGzm: TGzm);
var
  str:string;
  i:integer;
  tab:Table;
begin

    with innWord do begin
           //����
        if inGzm.UsedDrill.Zk_Yc_Count> 0 then begin
            SetFont('����',12,false,false);
            AlignLine(0);
            WriteText('    �ôβ���ʹ�õ��������Ϊ��'+inGzm.UsedDrill.Zk_name +
                      '�������¼���Ҳ㣺'+IntToStr(inGzm.UsedDrill.Zk_Yc_Count)+'�㡣'+#13,1);

            AlignLine(1);
            SetFont('����',11,true,false);
            SetHeading('��1-2��'+inGzm.UsedDrill.Zk_name+'������Ҳ���Ϣ��',4);
            SetFont('����',11,false,false);
            tab:=AddTable(6,1);
            SetFont('����',11,true,false);
            InsertRow(tab,1,1);  AlignLine(1);
            WriteText('�Ҳ����',0);   MoveRight(1);   SetFont('����',11,true,false);   AlignLine(1);
            WriteText('�Ҳ�����',0);   MoveRight(1);   SetFont('����',11,true,false);   AlignLine(1);
            WriteText('����(��)',0);   MoveRight(1);   SetFont('����',11,true,false);   AlignLine(1);
            WriteText('��ʯ����',0);   MoveRight(1);   SetFont('����',11,true,false);   AlignLine(1);
            WriteText('��ѹMPa',0);    MoveRight(1);   SetFont('����',11,true,false);   AlignLine(1);
            WriteText('����MPa',0);
            SetFont('����',11,False,false);
            for I := 0 to inGzm.UsedDrill.Zk_Yc_Count-1 do   begin
                InsertRow(tab,1,1);    MoveRight(1); AlignLine(1);
                WriteText(inttoStr(i+1),0);                      AlignLine(1);  MoveRight(1);
                WriteText(inGzm.UsedDrill.Yc_Rock[i].R_Name,0);   AlignLine(1);  MoveRight(1);
                WriteText(FormatFloat('#.##',inGzm.UsedDrill.Yc_Rock[i].R_h),0);   AlignLine(1);    MoveRight(1);
                WriteText(FormatFloat('#.##',inGzm.UsedDrill.Yc_Rock[i].R_r),0);   AlignLine(1);    MoveRight(1);
                WriteText(FormatFloat('#.##',inGzm.UsedDrill.Yc_Rock[i].R_kyqd),0);   AlignLine(1); MoveRight(1);
                WriteText(FormatFloat('#.##',inGzm.UsedDrill.Yc_Rock[i].R_klqd),0);   AlignLine(1);
            end;

            MoveDown(1); MoveDown(1); //��������

        end;

     end;

end;


procedure TWordReport.AddFYYDInfo_3(inGzm: TGzm;ReportType:String);
var
  Pic_Path:Ansistring;
begin
    Pic_Path:=Public_Basic.Get_MyModulePath+'saveBmp\FYYD\';
    with innWord do begin
          AlignLine(0);
          AddReturn();   //��һ������
          SetFont('����',15,false,false);
          SetHeading('���������˶�����',2);// �½�
          AddReturn();
           //����
          SetFont('����',13,false,false);
          SetHeading('1�������㷨',3);
          AddReturn();
          AlignLine(1);
          SetFont('����',10,true,false);
          AddTable(1,6);
          if self.isExsitBmpFile(Pic_Path+'NQF.JPG') then
             AddPicture(Pic_Path+'NQF.JPG',1);
          MoveRight(1);
          WriteText('ͼ3.1 �����˶����������㷨ͼʾ',0);
          MoveRight(1);
          if self.isExsitBmpFile(Pic_Path+'BJF.JPG') then
             AddPicture(Pic_Path+'BJF.JPG',1);
          MoveRight(1);
          WriteText('ͼ3.2 �����˶����ɲ����㷨ͼʾ',0);
          MoveRight(1);
           if self.isExsitBmpFile(Pic_Path+'ZHSF.JPG') then
             AddPicture(Pic_Path+'ZHSF.JPG',1);
          MoveRight(1);
          WriteText('ͼ3.3 �����˶������ۺ��㷨ͼʾ',0);
          MoveDown(1);

          AddReturn();

          AlignLine(0);

          SetFont('����',13,false,false);
          SetHeading('2�������˶�����',3);
          AddReturn();
          SetFont('����',13,false,false);
//          WriteText('   ֱ�Ӷ��˶�������'+StrPas(Main_CallPStope.UsePStope.Get_immediate_roof('1.0')));
//          AddReturn();
//          WriteText('   �϶��˶�������'+StrPas(Main_CallPStope.UsePStope.Get_Old_roof('1.0')));
          AddReturn();
          {Ϊ�ؿ����ﶨ��}
          if ReportType='Yklh' then begin
              SetFont('����',13,false,false);
              SetHeading('3��֧��ѹ���ֲ�����',3);
              AddReturn();
              SetFont('����',13,false,false);
              Report_Zcyl(inGzm);
          end;
    end;
end;

procedure TWordReport.AddSupportInfo_5(inGzm: TGzm);
var
  i,selectedid:integer;
  Image1:TImage;
  Pic_Path,DispStr:string;
begin
   Image1 := TImage.Create(nil);

   try
    with innWord do begin
          AlignLine(0);
          AddReturn();   //��һ������
          SetFont('����',15,false,false);
          SetHeading('�塢֧��ѡ��',2);// �½�
          AddReturn();
           //����
          SetFont('����',13,false,false);
          SetHeading('1����������Ӱ��ֵ',3);
          AddReturn();
          AlignLine(1);
          SetFont('����',10,true,false);
          AddTable(8,2);
          WriteText('ֱ�Ӷ����',0);MoveRight(1);
          WriteText('���������',0);MoveRight(1);
          WriteText('�װ����',0);MoveRight(1);
          WriteText('��������/KN',0);MoveRight(1);
          WriteText('�ɸ�/m',0);MoveRight(1);
          WriteText('����˹',0);MoveRight(1);
          WriteText('ð�������',0);MoveRight(1);
          WriteText('ú�����',0);MoveRight(1);
          for I := 0 to 7 do  begin

          end;

          MoveDown(1);

          AddReturn();

          AlignLine(0);
          SetFont('����',13,false,false);
          SetHeading('2��ע������',3);
          AddReturn();
          SetFont('����',13,false,false);
          WriteText('Һѹ֧���������㽨��ֵ��',0);
          AddReturn();

          MoveDown(1);

    end;
   finally
      Image1.Free;
   end;
end;

procedure TWordReport.AddSupSubject_6(inGzm: TGzm);
begin
end;

procedure TWordReport.ADDWorkFaceInFo_1(inGzm: TGzm);
var
  str:string;
begin
  with innWord do begin
      AlignLine(0);
      AddReturn();   //��һ������
        //����
      SetFont('����',13,false,false);
      str:='  ģ�⿪�ɹ���������Ϊ��'+inGzm.S_Name+'��ú��ƽ�����Ϊ' +
                  FormatFloat('#.##',inGzm.S_Agv_mch) +'��, �趨���ɸ߶�Ϊ' +
                  FormatFloat('#.##',inGzm.S_Cg_h)+'��, ��ú������' +
                  Get_Cmff(inGzm.S_CMFS_INteger)+ ',�������Ͻ������'+FormatFloat('#.##',inGzm.S_Sh_UP)+
                  '��,�½������'+FormatFloat('#.##',inGzm.S_Sh_Down)+'�ף�ƽ��������'   +
                  FormatFloat('#.##',inGzm.S_mcsd_h)+'��';
      WriteText(str,0);
      AddReturn();
      str:='  �ù������ƽ�������'+FormatFloat('#.##',inGzm.S_Sx_zx )+'�ף�'+
                '��б������'+FormatFloat('#.##',inGzm.S_L_qx)+'�ף�'   +
                'ú��Ӳ����'+Get_Coal_F(round(inGzm.S_f_PS))+',���Һ����'+Get_JYHd(inGzm.Dz_JYHD)+
                ',ÿ���ƽ�'+FormatFloat('#.##',inGzm.S_DayStep_speed)+'�����ҡ�' ;

      WriteText(Str,0);
      AddReturn();

      Str:='  �ô�ģ�����ʹ�õ�Һѹ֧�ܲ���Ϊ:'+
                '���ľࣺ'+ FormatFloat('#.##',inGzm.Usedsupport.Zj_zhongxinju) +  '��,'+
                '�ض��ࣺ'+ FormatFloat('#.##',inGzm.Usedsupport.Zj_KongdingJU) +  '��,'+
                '�������õ㣺'+ FormatFloat('#.##',inGzm.Usedsupport.Zj_hlzyd)  +  '��,'+
                '����������'+ IntTostr(inGzm.Usedsupport.Zj_Lizhu_count) +  '����';
      WriteText(Str,0);
      AddReturn();
  end;
end;

procedure TWordReport.AddYDFZInfo_4(inGzm: TGzm);
var
  Pic_Path:Ansistring;
begin
    Pic_Path:=Public_Basic.Get_MyModulePath+'saveBmp\FYYD\';
    with innWord do begin
          AlignLine(1);
          AddReturn();   //��һ������
          SetFont('����',15,false,false);
          SetHeading('�ġ��ɳ����ɸ����˶�ģ��',1);// �½�
          AddReturn();
           //����
          AlignLine(1);
          SetFont('����',10,true,false);
          AddTable(1,12);
          if self.isExsitBmpFile(Pic_Path+'IMM0.JPG') then
             AddPicture(Pic_Path+'IMM0.JPG',1);
          MoveRight(1);
          WriteText('ͼ4.1 ����ģ���ʼ״̬ͼ',0);
          MoveRight(1);
          if self.isExsitBmpFile(Pic_Path+'IMM1.JPG') then
             AddPicture(Pic_Path+'IMM1.JPG',1);
          MoveRight(1);
          WriteText('ͼ4.2 ֱ�Ӷ����ο���ʾ��ͼ',0);
          MoveRight(1);
          if self.isExsitBmpFile(Pic_Path+'IMM2.JPG') then
             AddPicture(Pic_Path+'IMM2.JPG',1);
          MoveRight(1);
          WriteText('ͼ4.3 ����ð���γ�ʾ��ͼ',0);
          MoveRight(1);
          if self.isExsitBmpFile(Pic_Path+'IMM3.JPG') then
             AddPicture(Pic_Path+'IMM3.JPG',1);
          MoveRight(1);
          WriteText('ͼ4.4 �϶�������ѹʾ��ͼ',0);
          MoveRight(1);
          if self.isExsitBmpFile(Pic_Path+'IMM4.JPG') then
             AddPicture(Pic_Path+'IMM4.JPG',1);
          MoveRight(1);
          WriteText('ͼ4.5 �϶�������ѹʾ��ͼ',0);
          MoveRight(1);
          if self.isExsitBmpFile(Pic_Path+'IMM5.JPG') then
             AddPicture(Pic_Path+'IMM5.JPG',1);
          MoveRight(1);
          WriteText('ͼ4.6 �ɶ����������˶�ʾ��ͼ',0);
          MoveDown(1);

    end;

end;

procedure TWordReport.AddYklhInfo_5(inGzm: TGzm);
var
  i,selectedid:integer;
   s_temp:Str_DT_array;
   C1:integer;
   S_out:Pansichar;
   Tab:Table;
   Str_S:array [0..7] of string;
begin
    S_out:= iCallPStope.Get_judge_KCJSTC;
    s_temp:=Public_Basic.split(StrPas(S_out),';',C1);
    Str_S[0]:= 'ֱ�Ӷ����';   Str_S[1]:= '���������'; Str_S[2]:= '�װ����';
    Str_S[3]:= '��������/KN';   Str_S[4]:= '�ɸ�/m'; Str_S[5]:= '����˹';
    Str_S[6]:= 'ð�������';   Str_S[7]:= 'ú�����';
   try
    with innWord do begin
          SetFont('����',11,true,false);AlignLine(1);
          SetHeading('��'+IntTostr(SencentId)+'-2'+'��'+MainDataModule.WorkFace_Name+'�����桿�ɶ������жϷ�����',4);

          SetFont('����',10,false,false);
          Tab:=AddTable(2,9);
          setTableColumsWidth(Tab,1,60);
          setTableColumsWidth(Tab,2,60);
          SetFont('����',11,true,false) ; AlignLine(1);
          WriteText('��Ŀ����',0);
          Moveright(1);AlignLine(1); SetFont('����',11,true,false) ;
          WriteText('��ֵ',0);  Moveright(1);AlignLine(0);
          AlignLine(0);
          for I := 0 to 7 do  begin
             SetFont('����',11,false,false);
             WriteText(Str_S[i],1);
             MoveRight(1);AlignLine(1);
             SetFont('����',11,false,false);
             WriteText(s_temp[i],1);  
             if i<7 then  begin
                MoveRight(1); AlignLine(0);
             end;
          end;

          MoveDown(1);

          AddReturn();

    end;
   finally

   end;

end;

procedure TWordReport.AddYklhInfo_5_2;
begin

end;

procedure TWordReport.ADD_Abstric;
var
   title,istr:String;
   Steps:integer;
begin
    title:='ժ  Ҫ';
   with innWord do begin
        SetFont('����_GB2312',16,true,false);
        AddReturn();
        AlignLine(1);  //����
        WriteText(title,0); //�������   ������Ϊ1
        AddReturn();
        istr:='   �����ṩ�Ŀ�ѹ��ȷ���������ɽ���Ƽ���ѧ������Ժʿ�����ġ�ʵ�ÿ�ɽѹ�����ơ�����Ϊ������׫д�ġ�'+
              '��ѹ����ı�д��ѭ�ԡ��Ҳ��˶�Ϊ���ġ��ĺ�������������ѹ�����Ų鷽ʽ��ѭ��Ѱ�Ҵ����֡���ע�쳣�㡱�Ĺ���˼·,' +
              '��������ģ�ͼ��㡢����ͳ�Ʒ���������ѹ����ά������ϵȷ����������ںϹ��������ڵĵ����������ɶ��������ɽѹ��ʵʱ������ݣ�'+
              '�γɵ�һƪ��Ƕȡ����������Ŀ��Ŀ�ѹ�������档' ;
        SetFont('����',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
        // ������������
        ReportInputData.FillDataFromDataBase(iDwGrap.FGzm.Gzmbh, -1,-1,
                                        iDwGrap.DataTimeAndFootAge.StartTime,
                                        iDwGrap.DataTimeAndFootAge.EndTime);
        Steps:=iDwGrap.Auto_Judge_OldStep.GetComeStepCount(10) +
                iDwGrap.Auto_Judge_OldStep.GetComeStepCount(9) +
                iDwGrap.Auto_Judge_OldStep.GetComeStepCount(8) +
                iDwGrap.Auto_Judge_OldStep.GetComeStepCount(5);

       istr:='   �������'+ MainDataModule.Coal_Name+'ú��'+MainDataModule.WorkFace_Name+'�����桿�ɶ������������������ѹʵʱ����չ�������ݷ�����' +
              '����������Ϊ'+IntToStr(Round(ReportInputData.TotalCount/10000/5))+'����,������ѹ����������'+InttoStr(Steps) +'�������У���ѹ������������'+
              intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(10))+'������ѹ������������'+
              intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(9))+'������ѹ�����쳣����'+
              intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(8)+iDwGrap.Auto_Judge_OldStep.GetComeStepCount(5))+'����'+
              '����ѹ����水����б�����Ϊ' + intTostr(iDwGrap.Auto_Judge_OldStep.PhaseNumber)+'�����򣬰�������Ļ��ֶԸ����������'+
              '��ͬ��ѹǿ�ȵ��ж�����������'+ intTostr((iDwGrap.Auto_Judge_OldStep.PhaseNumber-2)*3) +'����ѹǿ�ȵ�Ԥ����' ;
       SetFont('����',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();

        istr:='   ����ѹ����������ȫ�ɼ�����Զ����ɣ��ڼ�����Զ�������������У������ܶ����е���������㵽��'+
              '�������ʹ�ù����з����нϴ�ļ�����������������ʱͨ�漼�������Ŷ�,�����Ŷӽ�����������뽨��������������' +
              '�������ƣ���Ĳ�����Ǽ�������������';
        SetFont('����',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();

        istr:='   ��������ø�Ϊ���ơ���רҵ�������Ի��ı��棬����ϵ���������Ŷ�(LGZ2050@163.COM)չ����Ⱥ�����';
        SetFont('����',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();

        istr:='   ��ú��Ŀ�֪�ɸ���ɿ������ҹ�ͬ��Ը!';
        SetFont('����',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();

        istr:='   �Ƽ��˰����Ƽ�ǿ�󡢰�ȫ���������ǵĹ�ͬĿ��!';
        SetFont('����',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();


   end;
end;

procedure TWordReport.Add_Contents;
var
   title:String;
begin
    with innWord do begin
        GotoBookMark('mulu');
        title:='Ŀ  ¼';
        SetFont('����_GB2312',18,true,false);
        AlignLine(1);  //����
        WriteText(title,0); //�������   ������Ϊ1
        AddReturn();
        InsertContents(1,3,0);
        //----
        insertPage(0);
        title:='�����嵥';
        SetFont('����_GB2312',16,true,false);
        AlignLine(1);  //����
        WriteText(title,0); //�������   ������Ϊ1
        InsertContents(4,4,0);
        //------
        insertPage(0);
        title:='ͼ���嵥';
        SetFont('����_GB2312',16,true,false);
        AlignLine(1);  //����
        WriteText(title,0); //�������   ������Ϊ1
        InsertContents(5,5,0);

    end;
end;

procedure TWordReport.Add_disclaimer(Xhstr:String);
begin
     with innWord do begin
          AlignLine(1);
          AddReturn();   //��һ������
          SetFont('����',15,false,false);
          SetHeading(Xhstr+ '�����佨��',2);// �½�
          AddReturn();
           //����
          AlignLine(0);
          SetFont('����',13,false,false);
          WriteText('    ��������Ҫ��ʹ�������״ͼ����Ϣ,������ʯ��ѧ�������õ��Ǿ���ֵ,�����Ľ��۽����ο�, ' +
                    ' �����ȷ���Բ�ú��������ʵ���Ե�����,��Ҫ��ǿ�ֳ���ѹ�۲�У���ؼ�������',0);

     end;
end;

procedure TWordReport.Add_Fourth_Four(P_Str: string; inGZm: TGzm);
var
  istr,tStr:String;
  Jie_id,i,N:integer;
  AGV_D,ADV_C:double;
begin
  with innWord do begin
     SetHeading(P_Str+'.4 �����漴����ѹԤ��Ԥ��',2);// �½�
     istr:='   ������ά����ַ������Թ�������һ����ѹ����Ԥ�����£�';
     SetFont('����',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
     Jie_id:=0;
     //��������� ��ֵ
     tStr:=''; istr:='';
     for I := 0 to high(iDWGrap.Auto_Judge_OldStep.ExSteps ) do  begin
         if (iDWGrap.Auto_Judge_OldStep.ExSteps[i].ModifyData =3 ) and
            (iDWGrap.Auto_Judge_OldStep.ExSteps[i].ForcaseId=1 )  then    // �����˶� Ԥ������
            if (iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.EndSup-iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.StartSup > 2)  and
               (iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.End_AGVFootage-iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.Start_AGVFootage>1)   and
               (iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.WholeQD>0)  and (iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.AreaQD > 0) then begin

                  inc(Jie_id);
                  istr:='   ('+intTostr(Jie_id)+ ')��ѹ��������Ԥ�⣺֧�ܷ�Χ'+ intTostr(iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.StartSup ) +
                        '-'+intTostr(iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.EndSup ) +',���߷�Χ��'+
                        FormatFloat('0.00',iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.Start_AGVFootage) +'-' +
                        FormatFloat('0.00',iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.End_AGVFootage) +'�ף���ѹǿ��ϵ��'+
                        FormatFloat('0.00',iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.WholeQD) +',��ѹ���ǿ��'+
                        FormatFloat('0.00',iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.AreaQD) +',��ע�������';
                  SetFont('����',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
               end;
     end;

     for I := 0 to high(iDWGrap.Auto_Judge_OldStep.ExSteps ) do  begin
         if (iDWGrap.Auto_Judge_OldStep.ExSteps[i].ModifyData =3 ) and
            (iDWGrap.Auto_Judge_OldStep.ExSteps[i].ForcaseId=2 )  then   // �����˶� Ԥ������
            if (iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.EndSup-iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.StartSup > 2)  and
               (iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.End_AGVFootage-iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.Start_AGVFootage>1)   and
               (iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.WholeQD>0)  and (iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.AreaQD > 0) then begin

                  inc(Jie_id);
                  istr:='   ('+intTostr(Jie_id)+ ')��ѹ��������Ԥ�⣺֧�ܷ�Χ'+ intTostr(iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.StartSup ) +
                        '-'+intTostr(iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.EndSup ) +',���߷�Χ��'+
                        FormatFloat('0.00',iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.Start_AGVFootage) +'-' +
                        FormatFloat('0.00',iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.End_AGVFootage) +'�ף���ѹǿ��ϵ��'+
                        FormatFloat('0.00',iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.WholeQD) +',��ѹ���ǿ��'+
                        FormatFloat('0.00',iDWGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.AreaQD) +',��ע�������';
                  SetFont('����',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
               end;
     end;
  end;


     
end;

procedure TWordReport.Add_fourth_one(P_Str: string; inGZm: TGzm);
var
  istr:String;
  Jie_id:integer;
begin
  with innWord do begin
     SetHeading(P_Str+'.1 ��������ģ�͵ķ������',2);// �½�
     istr:='   ����ʵ�ÿ�ɽѹ���������۽���ģ�ͷ����Ŀ��ý�����£�';
     SetFont('����',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
     Jie_id:=0;
     inc(Jie_id);
     istr:='   ('+intTostr(Jie_id)+')ֱ�Ӷ�������'+ StrPas(iCallPStope.Get_immediate_roof('1.0'));
     SetFont('����',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
     inc(Jie_id);
     istr:='   ('+intTostr(Jie_id)+')�϶�������'+ StrPas(iCallPStope.Get_Old_roof('1.0'));
     SetFont('����',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
     inc(Jie_id);
     istr:='   ('+intTostr(Jie_id)+')֧��ѹ��������'+ StrPas(iCallPStope.Get_Zcyl('4.0',400));
     SetFont('����',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
  end;
end;

procedure TWordReport.Add_fourth_QianYan;
var
 istr:string;
begin
    with innWord do begin
        SetFont('����',12,False,False);
        istr:='   ���ο�ѹ������������ɽ���Ƽ���ѧ������Ժʿ�����ġ�ʵ�ÿ�ɽѹ�����ơ�����Ϊ��������д�ģ�'+
              '���α�����Ҫ������������������������';
        WriteText(istr,1);  AddReturn();

        istr:='   ��һ�����á�ʵ�ÿ�ɽѹ�����ơ����ۣ���ϲ�ú���������������Ϣ���ܱ�����Ҳ���ϸ��Ϣ���ԡ�'+MainDataModule.WorkFace_Name+
              '����������ϸ��Ҳ��˶�������֧��ѹ���ֲ����ɽ��������۲���ķ��������ݡ�';
        WriteText(istr,1); AddReturn();
        istr:='   �ڶ�������ͳ��ѧ���������п�ѹʵʱ������ݽ����˶����������������������ѹ�������Ե�����';
        WriteText(istr,1); AddReturn();
        istr:='   ������������ά����Ŀ�ѹ���������Թ�����ʵʱ������ݽ������������';
        WriteText(istr,1);AddReturn();

        istr:='   ϵͳͨ���������ݵ�ʵ��������ó����»������ۣ�';
        WriteText(istr,1); AddReturn();
    end;

end;

procedure TWordReport.Add_fourth_Secents(inGZm: TGzm);
{ ��ʵ�ǵ������}
var
  Str_Secents:String;
  tab:Table;
begin
   third_Tab_id:=0;
   Subject_Str.Clear ;
   Str_Secents:=intTostr(SencentId);
    with innWord do begin
      AlignLine(0); Addreturn();
      SetFont('����',16,true,false);
      SetHeading(Str_Secents+' '+MainDataModule.WorkFace_Name +'��ѹ��������',1);// �½�
      SetFont('����',11,false,false);
      //ǰ��
      Add_fourth_QianYan;
      public_Basic.WriteMakeWordPercent(true,91);
      // ��һ��ʵ�ÿ�ɽѹ������ ����
      Add_fourth_one(Str_Secents,inGZm);
      public_Basic.WriteMakeWordPercent(true,92);
      //�ڶ��� ����ͳ��ѧ��������
      Add_fourth_two(Str_Secents,inGZm);
      public_Basic.WriteMakeWordPercent(true,93);
      //������ ��������ķ�������
      Add_fourth_three(Str_Secents,inGZm);
      public_Basic.WriteMakeWordPercent(true,94);
      // ��ѹ����Ԥ��
      Add_Fourth_Four(Str_Secents,inGZm);
    end;

end;

procedure TWordReport.Add_fourth_three(P_Str: string; inGZm: TGzm);
var
  istr:String;
  Jie_id,P,P_Count:integer;
  AGV_D,ADV_C:double;
begin
   with innWord do begin
     SetHeading(P_Str+'.3 ������ά����ķ��������ķ������',2);// �½�
     istr:='   ������ά����ַ������Թ������ѹʵʱ������ݽ��з�����������£�';
     SetFont('����',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();

     iDwGrap.Auto_Judge_OldStep.GetComeStepInfo(10,AGV_D,ADV_C) ;
     if (AGV_D>0) and (ADV_C>0)  then  begin
         inc(Jie_id);
         istr:='   ('+intTostr(Jie_id)+')���������������ѹ����������'+intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(10)) +'��,'+
               'ƽ������Ϊ��'+FormatFloat('0.00' , AGV_D)+'����ƽ������Ϊ��'+ FormatFloat('0.00' , ADV_C)+'��';
         SetFont('����',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
     end;

     iDwGrap.Auto_Judge_OldStep.GetComeStepInfo(9,AGV_D,ADV_C) ;
     if (AGV_D>0) and (ADV_C>0)  then  begin
         inc(Jie_id);
         istr:='   ('+intTostr(Jie_id)+')���������������ѹ�������ԣ�'+intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(9)) +'��,'+
               'ƽ������Ϊ��'+FormatFloat('0.00' , AGV_D)+'����ƽ������Ϊ��'+ FormatFloat('0.00' , ADV_C)+'��';
         SetFont('����',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
     end;

     //��������� ��ֵ
     for P := 0 to iDWGrap.Auto_Judge_OldStep.PhaseNumber -1 do  begin
         P_Count:=0;
         P_Count:=iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(10) ;
         iDwGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepsInfo(10,AGV_D,ADV_C) ;
         if P_Count>0 then  begin
            inc(Jie_id);
            istr:='   ('+intTostr(Jie_id)+')������ڡ�'+Public_Basic.GetChineseNumber(P+1)+'��'+
               '���䣬Һѹ֧�ܱ�ŷ�Χ��'+IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].StartsupBh ) +'-'+
                IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].EndSupBh ) +'����,'+
               '�������ѹ����������'+intTostr(P_Count) +'��,'+
               'ƽ������Ϊ��'+FormatFloat('0.00' , AGV_D)+'����ƽ������Ϊ��'+ FormatFloat('0.00' , ADV_C)+'��';

            SetFont('����',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
         end;
         //----------------
         P_Count:=0;
         P_Count:=iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(9) ;
         iDwGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepsInfo(9,AGV_D,ADV_C) ;
         if P_Count>0 then  begin
            inc(Jie_id);
            istr:='   ('+intTostr(Jie_id)+')������ڡ�'+Public_Basic.GetChineseNumber(P+1)+'��'+
               '���䣬Һѹ֧�ܱ�ŷ�Χ��'+IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].StartsupBh ) +'-'+
                IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].EndSupBh ) +'����,'+
               '�������ѹ�������ԣ�'+intTostr(P_Count) +'��,'+
               'ƽ������Ϊ��'+FormatFloat('0.00' , AGV_D)+'����ƽ������Ϊ��'+ FormatFloat('0.00' , ADV_C)+'��';

            SetFont('����',12,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
         end;

     end;
   end;


end;

procedure TWordReport.Add_fourth_two(P_Str: string; inGZm: TGzm);
var
  istr:String;
begin
    with innWord do begin
     SetHeading(P_Str+'.2 ����ͳ��ѧ���������ķ������',2);// �½�
     Add_Second_Two_Jielun(P_Str,inGZm);
    end;
end;

procedure TWordReport.ADD_Fuhaoshuming;
var
   title,istr:String;
   Steps:integer;
begin
    title:='����˵��';
   with innWord do begin
        SetFont('����_GB2312',15,true,false);
        AddReturn();
        AlignLine(1);  //����
        WriteText(title,0); //�������   ������Ϊ1
        AddReturn();
        istr:='ֱ�Ӷ�:' ;
        SetFont('����',10,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();
        istr:='�϶�:' ;
        SetFont('����',10,false,false);  AlignLine(0); WriteText(istr,1);   AddReturn();


   end;

end;

procedure TWordReport.ADD_Fulu;
var
  title:String;
begin

    with innWord do begin
        GotoBookMark('fulu');
        title:='��¼X';
        SetFont('����',14,true,false);
        AlignLine(0);  //�������
        SetHeading(title,1);
    end;

end;

procedure TWordReport.Add_FuLuTu(tuOrTable,id :integer;title,Memo,FileName:string);
{tuOrTable   0 ��ʾ ����ͼ
             1  ��ʾ���Ǳ�
}
var
  R_str:String;
  tab:Table;
begin
    with innWord do begin
        GotoBookMark('fulu');
        MoveEnd(0);
        Tab:=AddTable(1,1);
        AlignLine(1);
        if tuOrTable=0  then  begin // ͼ
           if id =1 then  begin
             AddPicture(FileName,0.95);
           end else begin
             AddPicture(FileName,1);
           end;
            moveDown(1);
           SetFont('����',10,true,false); AlignLine(1);
           SetHeading('ͼX-'+InttoStr(id)+' ' +title,5);
           if length(Memo) >0  then   begin
              SetFont('����',10,true,false); AlignLine(1);WriteText(Memo,0);
           end;

        end;
       TableBorders(tab,0,0);

       insertpage(0);
    end;


end;

procedure TWordReport.Add_Fulu_TuFirstToFive;
var
   PathFile:string;
   i:integer;
   DataTypeStr:string;

begin
     // �Ѹ�¼��ͼ�� ��������

     fuLu_Tu_id:=0;
     with innword do begin
         //��һ��ͼ
        Yu_Start_id:=1;
         for I := 0 to 5 do  begin
               if ForceExit then   exit;
               if i=2 then  continue; // ������ ����
               if (i=5) and (not MainDataModule.SelectRockPressDataNumber(5,iDwGrap.FGzm.Gzmbh)) then  continue;

               DataTypeStr:=ReturnDataTypeName(i);
               PathFile:=ReturnFileName('YT',iDwGrap.DataTimeAndFootAge.Graph_MinDao,
                                             iDwGrap.DataTimeAndFootAge.Graph_MaxDao,i,1);
               if PathFile<>'' then  begin
                  inc(fuLu_Tu_id);
                  ChangePictureWidth(PathFile);
                  Add_FuLuTu(0,fuLu_Tu_id,
                        '��'+MainDataModule.WorkFace_Name+'�����桿Һѹ֧��ѭ����'+DataTypeStr+'��ԭʼ����ѹ����ͼ',
                         '',PathFile);
               end;
                //�ڶ���ͼ
               PathFile:=ReturnFileName('YT',iDwGrap.DataTimeAndFootAge.Graph_MinDao,
                                             iDwGrap.DataTimeAndFootAge.Graph_MaxDao,i,0);
               if PathFile<>'' then  begin
                  inc(fuLu_Tu_id);
                  ChangePictureWidth(PathFile);
                  Add_FuLuTu(0,fuLu_Tu_id,
                        '��'+MainDataModule.WorkFace_Name+'�����桿ѭ����'+DataTypeStr+'����ѹ�������������Զ��궨ͼ',
                          '(��ѹ�����ж��ٽ��ߡ�'+FormatFloat('0.00',iDwGrap.GetStepJudgeLevel(i)*iDwGrap.ColorValue.UnitValue)+'��'+
                          iDwGrap.ColorValue.UntiName +  '��ѹ�����ֱ�ֵΪ��'+FormatFloat('0.0',iDwGrap.GetStepJudgeRatio(i))+'%��)',
                          PathFile);
               end;

               //������ͼ
               PathFile:=ReturnFileName('YT',iDwGrap.DataTimeAndFootAge.Graph_MinDao,
                                             iDwGrap.DataTimeAndFootAge.Graph_MaxDao,i,2);
               if PathFile<>'' then  begin
                  inc(fuLu_Tu_id);
                  ChangePictureWidth(PathFile);
                  Add_FuLuTu(0,fuLu_Tu_id, '��'+MainDataModule.WorkFace_Name+'�����桿ѭ����'+DataTypeStr+'����ѹ�������������ۺϱ궨ͼ ',
                               ' (���ۺ�ɫ����ѹ�������� ����ɫ����ѹ�������� ����ɫ����ѹ�����쳣)', PathFile);
               end;
              public_Basic.WriteMakeWordPercent(true,20+i);
         end;
          Yu_End_id:=fuLu_Tu_id;
        //������ͼ  �� ƽ��ֵ��Ԥ�� ��Ӧ����
          PathFile:=ReturnFileName('YB',iDwGrap.DataTimeAndFootAge.Graph_MaxDao-20,
                                         iDwGrap.DataTimeAndFootAge.Graph_MaxDao+80,1,2);
          DataTypeStr:=ReturnDataTypeName(1);
           if PathFile<>'' then  begin
              inc(fuLu_Tu_id);
              ChangePictureWidth(PathFile);
              Add_FuLuTu(0,fuLu_Tu_id, '��'+MainDataModule.WorkFace_Name+'�����桿ѭ����'+DataTypeStr+'����ѹ������������Ԥ�����ͼ ' ,
                             '(����ɫ����ѹ�������� ����ɫ����ѹ��������)' , PathFile);
              ForCaseTuid:= fuLu_Tu_id;
           end else begin
              ForCaseTuid:=-1;
           end;

         // ���� ֱ��ͼ
          CreateBand_Bar(ExHandle,'',0,0,2);
          iDwGrap.BarMarks.Fromcontour:=true;;//��������ͼ�д�������
          if Assigned(Form_Band_Bar) then  begin
              Form_Band_Bar.InitForm(iDwGrap) ;
              Form_Band_Bar.SetOpenFormVar('',
                                    true, //�ⲿ����������
                                    true// �Ƿ�򿪹��߲˵�
                                    );

          end;
         FormPressTool.Close ;
         Form_Band_Bar.RefreshBarSeries(-1);
         Form_Band_Bar.Main_panel.Refresh;
         PathFile:=Form_Band_Bar.AutoSaveOnesupportOneBMP(-1);
         if PathFile<>'' then  begin
            inc(fuLu_Tu_id);
            ChangePictureWidth(PathFile);
            Add_FuLuTu(0,fuLu_Tu_id, '��'+MainDataModule.WorkFace_Name+'�����桿Һѹ֧��ѹ��Ƶ�׷���ͼ',
                     '����ͼ��ȫ������ȫ�����ݷ���ͼ������12��ͼ�����ѡ��12��֧�ܵ�ѹ��Ƶ�׷���ͼ',PathFile);
            PinPutuid:= fuLu_Tu_id;
         end else begin
            PinPutuid:=-1;
         end;
         Form_Band_Bar.Close ;
         // ���� ͳ��ͼ TongjiTuid
         CreateTongJiXueGraph(ExHandle,'',0,0,0);
         TongjiTuid:=-1;
         if Assigned(Form_TongJIGraph) then  begin
           Form_TongJIGraph.WindowState:=wsNormal;
           Form_TongJIGraph.InitForm(iDwGrap) ;
           Form_TongJIGraph.RefreshChartGraph;
           Form_TongJIGraph.Close ;
           PathFile  :=Public_Basic.Get_MyModulePath+'saveBmp\KYFX\TongJi.BMP';
           inc(fuLu_Tu_id);
           ChangePictureWidth(PathFile);
           Add_FuLuTu(0,fuLu_Tu_id, '��'+MainDataModule.WorkFace_Name+'�����桿ͳ�Ʒ���������ѹ�ж�ͼ',
                     '��ɫΪ��������֧��ѹ����ֵ�ߣ���ɫΪ��ѹ���������Ż�����',PathFile);
           TongjiTuid:= fuLu_Tu_id;
         end;

     end;


end;

procedure TWordReport.Add_FYYD_2(inGzm: TGZM);
{
   ���ӿ�ѹ�������� ֪ʶ
}
var
  str:string;
  fileName,textString:Ansistring;
  DirName:Ansistring;
  Dll_Path:AnsiString;
  tab:Table;
begin
   Dll_Path:=Public_Basic.Get_MyModulePath;
   DirName:=DLL_path+'\InputData\WorkDace_'+IntTostr(inGzm.Gzmbh)+'\';
    with innWord do begin
      AlignLine(0);
      SetFont('����',16,true,false);
      SetHeading(IntTostr(SencentId)+' ʵ�ÿ�ɽѹ���������ۼ�ʵ��Ӧ��',1);// �½�
      SetFont('����',12,false,false);
      insertotherfile(Dll_Path+'BJTP\A00'+IntTostr(SencentId)+'.rtf');
      public_Basic.WriteMakeWordPercent(true,36);
      //---------------------
      // �ڶ���
      SetFont('����',14,false,false);
      SetHeading(IntTostr(SencentId)+'.2 �ɳ��ռ�ṹģ�Ͷԡ�'+MainDataModule.WorkFace_Name+'�����桿�������',2);// �½�
      str:='   ' + MainDataModule.WorkFace_Name + '�����渽�������Ϊ��'+ MainDataModule.Drill_Name+'�����,'+
           '���ݹ���������׵����ݣ�����ʵ�ÿ�ɽѹ���������۽��м��������������£�';
      SetFont('����',12,false,false);  AlignLine(0); WriteText(str,1);
      AddReturn();
      //2.2.1
      SetFont('����',12,false,false);
      SetHeading(IntTostr(SencentId)+'.2.1��'+MainDataModule.WorkFace_Name+'�����桿����ṹ�������',3);// �½�
      str:='   ����ʵ�ÿ�ɽѹ���������ۣ���������Ҳ����ݶԲ�ú������Ķ���ṹ���з�������Ҫ�����ּ��㷽����';
      SetFont('����',12,false,false);  AlignLine(0); WriteText(str,1);   AddReturn();
      str:='   ��һ���������㷨:�����ڼ����Ҳ�ṹ��ϵʱ�������Ҳ�����ֵ�������㣬���ַ����Զ���Ƚ������Ҳ������Խ�ǿ��';
      WriteText(str,1);   AddReturn();
      str:='   �ڶ��ֲ�����㷨:�����ڼ����Ҳ�ṹ��ϵʱ�������Ҳ���е���ѹ����������㣬���ַ����Զ�����Լ�Ӳ�Ҳ��н�ǿ����Ӧ�ԡ�';
      SetFont('����',12,false,false);  AlignLine(0); WriteText(str,1);  AddReturn();
      str:='   ���ּ��㷽����ͼ'+IntTostr(SencentId)+'-8,'+IntTostr(SencentId)+'-9��ʾ��ͼ' +
             IntTostr(SencentId)+ '-10Ϊ�����㷨���ۺ���ʾ��';
      SetFont('����',12,false,false);  AlignLine(0); WriteText(str,1);  AddReturn();
      tab:=AddTable(1,1);
      TableBorders(tab,0,0);  //�ѱ߿�Ϊ 0
      AlignLine(1);
      if self.isExsitBmpFile(Dll_Path+'SaveBmp\FYYD\NQF.JPG') then
         AddPicture(Dll_Path+'SaveBmp\FYYD\NQF.JPG',1);
      MoveDown(1);
      public_Basic.WriteMakeWordPercent(true,37);
      SetFont('����',11,true,false);AlignLine(1);
      SetHeading('ͼ'+IntTostr(SencentId)+'-8'+' ��'+MainDataModule.WorkFace_Name+'�����桿����ṹ�����㷨ͼʾ',5);
      AddReturn();
      tab:=AddTable(1,1);
      TableBorders(tab,0,0);  //�ѱ߿�Ϊ 0
      AlignLine(1);
      if self.isExsitBmpFile(Dll_Path+'SaveBmp\FYYD\BJF.JPG') then
         AddPicture(Dll_Path+'SaveBmp\FYYD\BJF.JPG',1);
      MoveDown(1);
      public_Basic.WriteMakeWordPercent(true,38);

      SetFont('����',11,true,false);AlignLine(1);
      SetHeading('ͼ'+IntTostr(SencentId)+'-9'+' ��'+MainDataModule.WorkFace_Name+'�����桿����ṹ�����㷨ͼʾ',5);
      AddReturn();
      tab:=AddTable(1,1);
      TableBorders(tab,0,0);  //�ѱ߿�Ϊ 0
      AlignLine(1);
       if self.isExsitBmpFile(Dll_Path+'SaveBmp\FYYD\ZHSF.JPG') then
         AddPicture(Dll_Path+'SaveBmp\FYYD\ZHSF.JPG',1);
      MoveDown(1);
      SetFont('����',11,true,false);AlignLine(1);
      SetHeading('ͼ'+IntTostr(SencentId)+'-10'+'��'+MainDataModule.WorkFace_Name+'�����桿����ṹ�ۺ��㷨ͼʾ',5);
      AddReturn();
      public_Basic.WriteMakeWordPercent(true,39);
      //
      str:='   ����ʵ�ÿ�ɽѹ���������ۣ��ۺ��жϵ�ֱ�Ӷ��������£�';
      SetFont('����',12,false,false);  AlignLine(0); WriteText(str,1);   AddReturn();
      str:='   '+ StrPas(iCallPStope.Get_immediate_roof('1.0'));
      SetFont('����',12,false,false);  AlignLine(0); WriteText(str,1);   AddReturn();
      str:='   ����ʵ�ÿ�ɽѹ���������ۣ��ۺ��жϵ��϶��������£�';
      SetFont('����',12,false,false);  AlignLine(0); WriteText(str,1);   AddReturn();
      str:='   '+ StrPas(iCallPStope.Get_Old_roof('1.0'));
      SetFont('����',12,false,false);  AlignLine(0); WriteText(str,1);
      AddReturn();
      //2.2.2
      SetFont('����',12,false,false);
      SetHeading(IntTostr(SencentId)+'.2.2��'+MainDataModule.WorkFace_Name+'�����桿�ϸ��Ҳ��˶�����ģ��',3);// �½�
      str:='   ����ʵ�ÿ�ɽѹ���������ۣ��Ըù����治ͬ���ߴ��Ķ����˶�״̬����ģ�⣬ģ������ͼ'+IntTostr(SencentId)+
            '-11--'+IntTostr(SencentId)+'-16��';
      SetFont('����',12,false,false);  AlignLine(0); WriteText(str,1);   AddReturn();

      tab:=AddTable(1,1);
      TableBorders(tab,0,0);  //�ѱ߿�Ϊ 0
      AlignLine(1);
      public_Basic.WriteMakeWordPercent(true,40);

      if self.isExsitBmpFile(Dll_Path+'SaveBmp\FYYD\IMM0.JPG') then
         AddPicture(Dll_Path+'SaveBmp\FYYD\IMM0.JPG',1);
      MoveDown(1);
      SetFont('����',11,true,false);AlignLine(1);
      SetHeading('ͼ'+IntTostr(SencentId)+'-11'+'��'+MainDataModule.WorkFace_Name+'�����桿����ģ���ʼ״̬ͼ',5);
      AddReturn();
      tab:=AddTable(1,1);
      TableBorders(tab,0,0);  //�ѱ߿�Ϊ 0
      AlignLine(1);
      if self.isExsitBmpFile(Dll_Path+'SaveBmp\FYYD\IMM1.JPG') then
         AddPicture(Dll_Path+'SaveBmp\FYYD\IMM1.JPG',1);
      MoveDown(1);
      SetFont('����',11,true,false);AlignLine(1);
      SetHeading('ͼ'+IntTostr(SencentId)+'-12'+'��'+MainDataModule.WorkFace_Name+'�����桿ֱ�Ӷ����ο���ʾ��ͼ',5);
      AddReturn();
      tab:=AddTable(1,1);
      TableBorders(tab,0,0);  //�ѱ߿�Ϊ 0
      AlignLine(1);
      if self.isExsitBmpFile(Dll_Path+'SaveBmp\FYYD\IMM2.JPG') then
         AddPicture(Dll_Path+'SaveBmp\FYYD\IMM2.JPG',1);
      MoveDown(1);
      SetFont('����',11,true,false);AlignLine(1);
      SetHeading('ͼ'+IntTostr(SencentId)+'-13'+'��'+MainDataModule.WorkFace_Name+'�����桿����ð������γ�ʾ��ͼ',5);
      AddReturn();
      tab:=AddTable(1,1);
      TableBorders(tab,0,0);  //�ѱ߿�Ϊ 0
      AlignLine(1);
      if self.isExsitBmpFile(Dll_Path+'SaveBmp\FYYD\IMM3.JPG') then
         AddPicture(Dll_Path+'SaveBmp\FYYD\IMM3.JPG',1);
      MoveDown(1);
      SetFont('����',11,true,false);AlignLine(1);
      SetHeading('ͼ'+IntTostr(SencentId)+'-14'+'��'+MainDataModule.WorkFace_Name+'�����桿�϶�������ѹʾ��ͼ',5);
      AddReturn();
      tab:=AddTable(1,1);
      TableBorders(tab,0,0);  //�ѱ߿�Ϊ 0
      AlignLine(1);
      if self.isExsitBmpFile(Dll_Path+'SaveBmp\FYYD\IMM4.JPG') then
         AddPicture(Dll_Path+'SaveBmp\FYYD\IMM4.JPG',1);
      MoveDown(1);
      SetFont('����',11,true,false);AlignLine(1);
      SetHeading('ͼ'+IntTostr(SencentId)+'-15'+'��'+MainDataModule.WorkFace_Name+'�����桿�϶�������ѹʾ��ͼ',5);
      AddReturn();
      tab:=AddTable(1,1);
      TableBorders(tab,0,0);  //�ѱ߿�Ϊ 0
      AlignLine(1);
      if self.isExsitBmpFile(Dll_Path+'SaveBmp\FYYD\IMM5.JPG') then
         AddPicture(Dll_Path+'SaveBmp\FYYD\IMM5.JPG',1);
      MoveDown(1);
      SetFont('����',11,true,false);AlignLine(1);
      SetHeading('ͼ'+IntTostr(SencentId)+'-16'+'��'+MainDataModule.WorkFace_Name+'�����桿�ɶ����������˶�ʾ��ͼ',5);
      AddReturn();
      public_Basic.WriteMakeWordPercent(true,43);

      str:='   ͨ��ͼ'+IntTostr(SencentId)+'-14--ͼ'+IntTostr(SencentId)+'-16���Էǳ������Ŀ�����'+
            MainDataModule.WorkFace_Name+'���������϶���λ'+
            '�����ӿ�ʼ�Ѷϵ������Ѷϵ��˶�״̬����ϸ���Ҳ��˶�״̬���Ե������в鿴��';
      SetFont('����',12,false,false);  AlignLine(0); WriteText(str,1);   AddReturn();
      //2.2.3
      SetFont('����',12,false,false);
      SetHeading(IntTostr(SencentId)+'.2.3��'+MainDataModule.WorkFace_Name+'�����桿֧��ѹ���ֲ��������',3);// �½�
      str:='   ����ͼ'+IntTostr(SencentId)+'-3��ͼ'+IntTostr(SencentId)+'-7�����Ĳ�ú�������ܱ�֧��ѹ����ת�ƹ��ɣ�' +
            '����ʵ�ÿ�ɽѹ���������۶� '+ '��'+MainDataModule.WorkFace_Name+
            '���������֧��ѹ���ֲ����ɽ��м��㣬�õ�������'+IntTostr(SencentId)+'-1 ��ʾ����ά��̬ͼ��ͼ'+
            'ͼ'+IntTostr(SencentId)+'-17 ��ʾ';
      SetFont('����',12,false,false);  AlignLine(0); WriteText(str,1);   AddReturn();
      Report_Zcyl(inGzm);

      AddReturn();
      tab:=AddTable(1,1);
      TableBorders(tab,0,0);  //�ѱ߿�Ϊ 0
      AlignLine(1);
      if self.isExsitBmpFile(Dll_Path+'SaveBmp\FYYD\ZCYL.Bmp') then
         AddPicture(Dll_Path+'SaveBmp\FYYD\ZCYL.Bmp',1);
      MoveDown(1);
      SetFont('����',11,true,false);AlignLine(1);
      SetHeading('ͼ'+IntTostr(SencentId)+'-17'+'��'+MainDataModule.WorkFace_Name+'�����桿֧��ѹ����ά��̬ʾ��ͼ',5);
      AddReturn();
      //2.2.4
      SetFont('����',12,false,false);
      SetHeading(IntTostr(SencentId)+'.2.4��'+MainDataModule.WorkFace_Name+'�����桿�ɶ������������',3);// �½�
      AddYklhInfo_5(inGzm);
    end;

end;


procedure TWordReport.ADd_HouJi;
var
  title:String;
begin

    with innWord do begin
        GotoBookMark('houji');
        title:='���';
        SetFont('����',14,true,false);
        AlignLine(0);  //�������
        SetHeading(title,1);
    end;
end;

procedure TWordReport.Add_Kyfx_Cover(CoalName, WorkFaceName:string);
var
  title:String;
  i:integer;
  Pic_Path:string;
  tab:Table;
begin

    Pic_Path:=Public_Basic.Get_MyModulePath;
    with innWord do begin

        for I := 0 to 2 do    AddReturn();
        title:=CoalName+'ú��'+WorkFaceName+'������';
        SetFont('����',18,true,false);   AlignLine(1);      WriteText(title,1); //�������   ������Ϊ1
        AddReturn(); AddReturn();
        SetFont('����',28,true,false);   AlignLine(1);      WriteText('��ɽѹ����ȷ�������',1); //�������   ������Ϊ1
        SetFont('����',18,true,false);

        for I := 0 to 2 do      AddReturn();

         // ����ͼ��
         tab:=AddTable(3,1); moveright(1);
         TableBorders(tab,0,0);
         if self.isExsitBmpFile(Pic_Path+'BJTP\cover1.jpg') then
             AddPicture(Pic_Path+'BJTP\cover1.jpg',1);
         MoveDown(1);


        for I := 0 to 1 do
            AddReturn();

       // ����������Ϣ
         SetFont('����',12,true,false);
         AlignLine(1);  //����
         tab:=AddTable(2,6);
         TableBorders(tab,0,0);
         setTableColumsWidth(tab,1,35);
         setTableColumsWidth(tab,2,95);
         SetFont('����',12,true,false);   AlignLine(0);    WriteText('���ݷ���ʱ��:',1);  moveright(1);
              title:='  ��'+FormatDatetime('MM-DD HH:NN:SS',iDWGrap.DataTimeAndFootAge.StartTime  )+'��-��'+
                    FormatDatetime('MM-DD HH:NN:SS',iDWGrap.DataTimeAndFootAge.EndTime ) +'��';
              for I := strlen(PwideChar(title)) to 85 do     title:=title+' ';
              SetFont('����',12,false,true);   AlignLine(0);    WriteText(title,1);  moveright(1);
         SetFont('����',12,true,false);   AlignLine(0);    WriteText('���ݷ�������:',1);  moveright(1);
              title:='  �ӵڡ�'+IntToStr(iDWGrap.DataTimeAndFootAge.Graph_MinDao  )+'����-�ڡ�'+
                      IntToStr(iDWGrap.DataTimeAndFootAge.Graph_MaxDao ) +'����';
              for I := strlen(PwideChar(title)) to 85 do     title:=title+' ';
              SetFont('����',12,false,true);   AlignLine(0);    WriteText(title,1);  moveright(1);
         SetFont('����',12,true,false);   AlignLine(0);    WriteText('���ݷ�������:',1);  moveright(1);
              title:='  �ӵڡ�'+FormatFloat('0.0',iDWGrap.DataTimeAndFootAge.DownStartFootage  )+'����-�ڡ�'+
                      FormatFloat('0.0',iDWGrap.DataTimeAndFootAge.DownEndFootage ) +'����';
              for I := strlen(PwideChar(title)) to 85 do     title:=title+' ';
              SetFont('����',12,false,true);   AlignLine(0);    WriteText(title,1);  moveright(1);
        SetFont('����',12,true,false);   AlignLine(0);    WriteText('������Ƶ�λ:',1);  moveright(1);
              title:='  '+MainDataModule.Coal_Name+'ú�������ƿ�ѹ������';
              for I := strlen(PwideChar(title)) to 85 do     title:=title+' ';
              SetFont('����',12,false,true);   AlignLine(0);    WriteText(title,1);  moveright(1);
        SetFont('����',12,true,false);   AlignLine(0);    WriteText('����֧���Ŷ�:',1);  moveright(1);
              title:='  '+'ɽ���Ƽ���ѧ������Ժʿ�����Ŷ�';
              for I := strlen(PwideChar(title)) to 85 do     title:=title+' ';
              SetFont('����',12,false,true);   AlignLine(0);    WriteText(title,1);  moveright(1);
        SetFont('����',12,true,false);   AlignLine(0);    WriteText('�������ʱ��:',1);  moveright(1);
              title:='  '+ReturnTimeToChinese(now);
              for I := strlen(PwideChar(title)) to 85 do     title:=title+' ';
              SetFont('����',12,false,true);   AlignLine(0);    WriteText(title,1);
        movedown(1);

    end;


end;

procedure TWordReport.Add_Second_Secents(inGZm: TGzm);
{ ��ʵ�ǵ�����}

var
  Str_Secents,istr:String;
  tab:Table;
  i:integer;
begin
   Second_Tab_id:=0;
   //fuLu_Tu_id:=5; // ǰ������ͼ ��Ԥ��   (����������Ԥ���ˣ�
   Subject_Str.Clear ;
   Str_Secents:=intTostr(SencentId);
    with innWord do begin
      AlignLine(0); Addreturn();
      SetFont('����',16,true,false);
      SetHeading(Str_Secents+' ��ѹʵʱ����ͳ��ѧ��������',1);// �½�
      SetFont('����',11,false,false);
      //ǰ��
      Add_Second_QianYan;
//      // ������ ��һ��
       Add_Second_First_main(Str_Secents,inGZm);
//      //������ �ڶ���
        SetFont('����',12,false,false);
        SetHeading(Str_Secents+'.2 ��ѹ�������ͳ��ѧ��������',2);// �½�
        SetFont('����',12,False,False);
        istr:='    Ϊ��������ͳ�ƣ����ο�ѹ������������ÿ��֧�ܵ�һ��ѭ����������Ϊ��׼���п�ѹ������' +
               '��ȡÿ��֧�ܡ�ÿ��ѭ���ĳ�������ĩ���������ֵ��ƽ��ֵ��ĳһʱ��֧��˲����ֵ���������ݣ�' +
               '�ڷ����������ݵ�ͳ��ѧ���������ϣ������ݽ��д�͸�������ںϣ�Ѱ�ҿ�ѹ������ݵ�������ϵ������������'+
               Str_Secents+'-2����'+Str_Secents+'-'+intTostr(iDwGrap.Auto_Judge_OldStep.PhaseNumber*2+1) +'��';
        WriteText(istr,1); AddReturn();
        if TongjiTuid>0 then  begin
            istr:='    ͳ�Ʒ�������ѹ��������ѹ����ֵ�������Ż������總¼ ͼ X-'+IntTostr(TongjiTuid)+'��ʾ��';
             WriteText(istr,1); AddReturn();

        end;
        public_Basic.WriteMakeWordPercent(true,47);
//
        Second_Tab_id:=1;
         for I := 0 to iDwGrap.Auto_Judge_OldStep.PhaseNumber-1 do  begin
            SetHeading(Str_Secents+'.2.'+IntTostr(i+1)+' �ڡ�'+Public_Basic.GetChineseNumber(i+1)+'�������ѹʵ������ͳ��ѧ��������',3);// �½�
            SetFont('����',12,False,False);
            //ͳ��ѧ���ݷ���
            Add_Second_Two_Table_1(Str_Secents,inGZm,i) ;
            // ͳ�����ݽ������
            Add_Second_Two_Table_2(Str_Secents,inGZm,i) ;
            public_Basic.WriteMakeWordPercent(true,47+3*i);
         end;

        // ������ ����
      SetHeading(Str_Secents+'.3 ��ѹʵʱ���ݷ������',2);// �½�
      Add_Second_Two_Jielun(Str_Secents,inGZm);

    end;

end;

procedure TWordReport.Add_Support_Information(inGzm: TGzm);
var
  str:string;
  i:integer;
begin

    with innWord do begin
         AlignLine(1);
         SetFont('����',11,True,false);
         WriteText('��1-3 '+inGzm.SupportName+'Һѹ֧����Ҫ��������',0);
         AddReturn();
         SetFont('����',11,true,false);
         AddTable(4,7);
          WriteText('��������',0);   MoveRight(1);   WriteText('����ֵ',0);   MoveRight(1);
              WriteText('��������',0);   MoveRight(1);   WriteText('����ֵ',0);   MoveRight(1);
          SetFont('����',11,False,false);
          WriteText('֧������',0);   MoveRight(1);
               WriteText(inGzm.Usedsupport.Zj_leixing,0);   MoveRight(1);
          WriteText('֧���ͺ�',0);   MoveRight(1);
               WriteText(inGzm.Usedsupport.Zj_Name,0);   MoveRight(1);
          WriteText('֧�����ľࣨ�ף�',0);   MoveRight(1);
               WriteText(FormatFloat('.##',inGzm.Usedsupport.Zj_zhongxinju),0);   MoveRight(1);
          WriteText('֧�ܿض��ࣨ�ף�',0);   MoveRight(1);
               WriteText(FormatFloat('.##',inGzm.Usedsupport.Zj_KongdingJU),0);   MoveRight(1);
          WriteText('�������õ㣨�ף�',0);   MoveRight(1);
               WriteText(FormatFloat('.##',inGzm.Usedsupport.Zj_hlzyd),0);   MoveRight(1);
          WriteText('��������������',0);   MoveRight(1);
               WriteText(IntToStr(inGzm.Usedsupport.Zj_Lizhu_count),0);   MoveRight(1);
          WriteText('�����������ף�',0);   MoveRight(1);
               WriteText(FormatFloat('.##',inGzm.Usedsupport.Zj_suoliang),0);   MoveRight(1);
          WriteText('֧���迹����KN��',0);   MoveRight(1);
               WriteText(FormatFloat('.##',inGzm.Usedsupport.Zj_toall_F),0);   MoveRight(1);
          WriteText('֧��ǿ�ȣ�MPa��',0);   MoveRight(1);
               WriteText(FormatFloat('.##',inGzm.Usedsupport.zj_toall_P),0);   MoveRight(1);
          WriteText('����߶ȣ��ף�',0);   MoveRight(1);
               WriteText(FormatFloat('.##',inGzm.Usedsupport.Zj_hubang_h),0);   MoveRight(1);

          WriteText('����ǿ�ȣ�MPa��',0);   MoveRight(1);
               WriteText(FormatFloat('.##',inGzm.Usedsupport.zj_hubang_P),0);   MoveRight(1);
          WriteText('�����׾������ף�',0);   MoveRight(1);
               WriteText(FormatFloat('0',inGzm.Usedsupport.Lz_Diameter),0);

         MoveDown(1);
    end;

end;

procedure TWordReport.Add_Third_QianYan;
var
 istr:string;
begin
    with innWord do begin
        SetFont('����',12,False,False);
//         istr:='   ��ά���淽�����񻪼�����ú̿��˾���������ܺ���߹��ڶ����ѹ����' +
//             '�Ļ������ܽ������һ�ֻ��ڡ�Ѱ�Ҵ����֡���ע�쳣�㡱�Ŀ�ѹ����������'+
//             '�÷�������������ͼֱ�ۡ��������㡢�������ȫ�桢�͹۵��ص㡣';
          istr:='   ��ά���淽����ɽ���Ƽ���ѧ������Ժʿ��ѹ���������Ŷ��ڶ����ѹ����' +
             '�Ļ������ܽ������һ�ֻ��ڡ�Ѱ�Ҵ����֡���ע�쳣�㡱�Ŀ�ѹ����������'+
             '�÷�������������ͼֱ�ۡ��������㡢�������ȫ�桢�͹۵��ص㡣';
        WriteText(istr,1);  AddReturn();
         istr:='   ������ά���淽������Ҫע���������������';
        WriteText(istr,1); AddReturn();
         istr:='   ��һ�������ú�������ѹ���ݹ��ɵ����������ǻ���ʱ���������ģ�Ҳ���ǿ��԰ѱ仯�����ݲɼ�������';
        WriteText(istr,1); AddReturn();
         istr:='   �ڶ������蹤������б����Ⱦ���ɼ�ѹ�����ݣ�Ҳ����Һѹ֧�ܵ�֧�ܼ����ȣ�' +
              '���� ���5�� �����ɼ���5��10,15,20��.����';
        WriteText(istr,1); AddReturn();
         istr:='   ���������蹤�����ѹ���ݷ����Խ���Ϊ�������յ㣨Ҳ���������ݷ����У�' +
              '�����趨����һ��֧�ܵĽ�����ʶ��Ϊ��������������Ļ������գ���';
        WriteText(istr,1);AddReturn();

         istr:='   ���ģ���ѹ�����ж��Գ���ĳһ�ض�ֵΪ�ο��ģ���һ��ѡ���Ŀ�������ķ����У��òο�ֵ�޷��ı�'+
               '�����ڹ������ƽ������У����װ����Ա仯�ϴ�Ĳ�ú�����棬Һѹ֧��ѹ��ֵ�仯�ϴ󣬲�������ѹ��ֵ��' +
               '��ƫ�ͻ���ƫ�ߣ�������Ҫ��С���ݷ���������������ѡ��������������Ϊ���װ���������ȶ�����';
        WriteText(istr,1); AddReturn();

         istr:='   ���壺��Ѱ�Ҵ����֡���ע�쳣�㡱��ѹ���ַ���Ҫ��һ�������ݶ������䣬��С�����������ѡ����50�����ϡ�';
        WriteText(istr,1); AddReturn();
    end;
end;

procedure TWordReport.Add_Third_Secents(inGZm: TGzm);
{ ��ʵ�ǵ�����}
var
  Str_Secents:String;
  tab:Table;
begin
   third_Tab_id:=0;
   Subject_Str.Clear ;
   Str_Secents:=intTostr(SencentId);
    with innWord do begin
      AlignLine(0); Addreturn();
      SetFont('����',16,true,false);
      SetHeading(Str_Secents+' ������ά����������Կ�ѹʵʱ���ݽ��з���',1);// �½�
      SetFont('����',11,false,false);
      //ǰ��
      Add_Third_QianYan;
      public_Basic.WriteMakeWordPercent(true,61);
      // ������ ��һ��
      Add_Third_one_Main(Str_Secents,inGZm);
//      //�ڶ��� ���߸���Ľ�
      Add_Third_two_Main(Str_Secents,inGZm);

    end;
end;

procedure TWordReport.Add_Third_one_Main(P_Str: string; inGZm: TGzm);
var
 istr:string;
begin

     with innWord do begin
          // �ڶ���
         SetFont('����',14,false,false);
         SetHeading(P_Str+'.1 '+'��ú�������ѹ����������������',2);// �½�
         istr:='    ��������Ŀ�ɽѹ��������˼����ǡ�Ѱ�Ҵ����֡���ע�쳣�㡱��'+
               '���η����ڶ����ݽ����˶���Ԥ�еĻ����ϣ��õ������ѹ���ֹ������¡�';
         SetFont('����',12,False,False);
         WriteText(istr,1);  AddReturn();

         istr:='    ���ο�ѹ�����У�����ȡ��ѹ������������' +
             '��'+intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(10))+'��������ѹ������������'+
             '��'+intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(9))+'������ֲ���ѹ�쳣��'+
             '��'+intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(8)+iDwGrap.Auto_Judge_OldStep.GetComeStepCount(5)+
               iDwGrap.Auto_Judge_OldStep.GetComeStepCount(6))+ '���� ' +
             '(��ϸ���ݼ���'+P_Str+'.'+intToStr(Third_Tab_id+1)+'-'+P_Str+'.'+intToStr(Third_Tab_id+3)+')��' ;
         SetFont('����',12,False,False);
         WriteText(istr,1);  AddReturn();
          // ˵��
         istr:='    �������ݷ�����ͼ����Ϣ����ο���¼��ͼ��X-'+IntToStr(Yu_Start_id)+'-'+'X-'+IntToStr(Yu_End_id)+ '��' +
              '�������ݷ����ֱ�����ֵ��ƽ��ֵ��ĩ������˲��ѹ��ֵ�����˵���������';
         SetFont('����',12,False,False);
         WriteText(istr,1);  AddReturn();
         // ��һС��
         Add_Third_one_First(P_Str,inGZm);
         public_Basic.WriteMakeWordPercent(true,65);
     end ;



end;

procedure TWordReport.Add_Third_one_First(P_Str: string; inGZm: TGzm);
var
  tab:Table;
  R_Str,PathFile:String;
begin
    R_Str:=' ';
    with innWord do begin
         SetFont('����',12,false,false);
         SetHeading(P_Str+'.1.1 ��ú�������ѹ��������������������',3);// �½�
         //
         R_Str:='    �������ݷ����У�����ȡ��ѹ������������' +
             '��'+intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(10))+'�������' +
             P_Str+'-'+intToStr(Third_Tab_id+1)+ '��ʾ��';
         SetFont('����',12,False,False);
         WriteText(R_Str,1);  AddReturn();
         // ����
         SetFont('����',11,true,false);AlignLine(1);
         inc(third_Tab_id);
         SetHeading('��'+P_Str+'-'+intToStr(Third_Tab_id)+'��'+MainDataModule.WorkFace_Name+
                   '�����桿���������ѹ�����������ݱ�',4);
         ADd_Third_one_First_Table(P_Str,10);

         R_Str:='    ��ע��[����ϵ��]��ָͨ������ѹ�����ֵ������������ѹ��ƽ��ֵ�ı�ֵ��'+
                  '[��ֵϵ��]��ָͨ������ѹ��ƽ��ֵ������������ѹ��ƽ��ֵ�ı�ֵ�� ' +
                  '[���ϵ��]��ָͨ���������ֵ��������������ƽ������ı�ֵ��' +
                  '[�ۺ�ϵ��]��ָͨ����������ϵ�����ֵϵ���ĳ˻����Ժ�������ͬ';
           SetFont('����',8,false,false) ; AlignLine(0); WriteText(R_Str,0);
         Addreturn();
         //
         SetFont('����',12,false,false);
         SetHeading(P_Str+'.1.2 ��ú�������ѹ��������������������',3);// �½�

         R_Str:='    �������ݷ����У�����ȡ' +
             '��'+intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(9))+'����һ����ѹ��Ϣ��' +
             P_Str+'-'+intToStr(Third_Tab_id+1)+ '��ʾ��';
         SetFont('����',12,False,False);
         WriteText(R_Str,1);  AddReturn();

         SetFont('����',11,true,false);AlignLine(1);
         inc(third_Tab_id);
         SetHeading('��'+P_Str+'-'+intToStr(Third_Tab_id)+'��'+MainDataModule.WorkFace_Name+
                   '�����桿���������ѹ�����������ݱ�',4);
         ADd_Third_one_First_Table(P_Str,9);
         Addreturn();
          //
         SetFont('����',12,false,false);
         SetHeading(P_Str+'.1.3 ��ú������ֲ���ѹ�����쳣������������',3);// �½�
         //
         R_Str:='    �������ݷ����У�����ȡ' +
             '��'+intTostr(iDwGrap.Auto_Judge_OldStep.GetComeStepCount(8)+iDwGrap.Auto_Judge_OldStep.GetComeStepCount(5)+
               iDwGrap.Auto_Judge_OldStep.GetComeStepCount(6))+'���ξֲ���ѹ�����쳣��Ϣ��' +
             P_Str+'-'+intToStr(Third_Tab_id+1)+ '��ʾ��';
         SetFont('����',12,False,False);
         WriteText(R_Str,1);  AddReturn();

         SetFont('����',11,true,false);AlignLine(1);
         inc(third_Tab_id);
         SetHeading('��'+P_Str+'-'+intToStr(Third_Tab_id)+'��'+MainDataModule.WorkFace_Name+
                   '�����桿�ֲ���ѹ�����쳣���ݱ�',4);
         ADd_Third_one_First_Table(P_Str,-1);

         Addreturn();
    end;
end;

procedure TWordReport.ADd_Third_one_First_Table(P_Str: string; Modify: integer);
var
  i,i_Row,N,come_c:integer;
  R_Str,t_str:string;
  tab:Table;
  Ex_Stepid:integer;
begin
      R_Str:=' ';
      with innWord do begin
           SetFont('����',11,false,false) ;
           AlignLine(0);
           Tab:=AddTable(8,1);
           setTableColumsWidth(Tab,1,25);  setTableColumsWidth(Tab,2,15);
           setTableColumsWidth(Tab,3,25);  setTableColumsWidth(Tab,4,15);
           setTableColumsWidth(Tab,5,25);  setTableColumsWidth(Tab,6,15);
           setTableColumsWidth(Tab,7,25);  setTableColumsWidth(Tab,8,15);
           //��ͷ
           i_Row:=0; come_c:=0;
           for I := 0 to length(iDwGrap.Auto_Judge_OldStep.ExSteps)-1 do begin
              if Modify>0  then   begin
                 if iDwGrap.Auto_Judge_OldStep.ExSteps[i].ModifyData <> Modify  then
                    continue;
              end else  begin
                 if (iDwGrap.Auto_Judge_OldStep.ExSteps[i].ModifyData <> 5 ) and
                    (iDwGrap.Auto_Judge_OldStep.ExSteps[i].ModifyData <> 8 ) and
                    (iDwGrap.Auto_Judge_OldStep.ExSteps[i].ModifyData <> 6 ) then
                    continue;
              end;

              if not((iDwGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.EndDao>iDwGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.StartDao ) and
                 (iDwGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.EndSup>iDwGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo.StartSup )) then
                     continue;
             // ������д�����
             Add_Third_one_First_Table_Chlid(-1,iDwGrap.Auto_Judge_OldStep.ExSteps[i].OneStepInfo,
                                             -1,-1,tab,come_c,i_Row);
           end;
           TableBorders(tab,1,1);
           MoveDown(1); MoveDown(1);
      end;

end;

procedure TWordReport.Add_Second_First(P_Str: string; inGZm: TGzm);
var
  tab:Table;
  i,Row_st,D_JIndao,N_C:integer;
  Di_Day:double;
  R_Str:String;
begin
    R_Str:=' '; N_C:=0;
    with innWord do begin

       AddReturn();
       SetFont('����',10,false,false) ;
       AlignLine(0);
       Tab:=AddTable(7,19);
       setTableColumsWidth(Tab,1,30);  setTableColumsWidth(Tab,2,15);
       setTableColumsWidth(Tab,3,25);  setTableColumsWidth(Tab,4,15);
       setTableColumsWidth(Tab,5,25);  setTableColumsWidth(Tab,6,20);
       setTableColumsWidth(Tab,7,20);
          // ��1��   ������ �����������
       TableCellMerge(Tab,1,1,7,1);
       SetFont('����',10,true,false) ; AlignLine(1); WriteText('��ѹ����������弼�������������',0); Moveright(1);

        // ��2��
       SetFont('����',10,true,false) ; AlignLine(0); WriteText('���ݷ���ʱ��',0); Moveright(1);
       SetFont('����',10,true,false) ; AlignLine(1); WriteText('��ʼ',0); Moveright(1);
       SetFont('����',10,False,false) ; AlignLine(1);
                     WriteText(FormatDateTime('YYYY-MM-DD',iDWGrap.DataTimeAndFootAge.StartTime),0); Moveright(1);
       SetFont('����',10,true,false) ; AlignLine(1); WriteText('����',0); Moveright(1);
       SetFont('����',10,False,false) ; AlignLine(1);
                     WriteText(FormatDateTime('YYYY-MM-DD',iDWGrap.DataTimeAndFootAge.EndTime),0); Moveright(1);
       SetFont('����',10,true,false) ; AlignLine(1); WriteText('��ʱ(��)',0); Moveright(1);
       SetFont('����',10,False,false) ; AlignLine(1);
       Di_Day:= iDWGrap.DataTimeAndFootAge.EndTime-iDWGrap.DataTimeAndFootAge.StartTime;
                WriteText(IntToStr(round(Di_Day)),0); Moveright(1);
         // ��3��   ��
       SetFont('����',10,true,false) ; AlignLine(0); WriteText('���ݷ�������',0); Moveright(1);
       SetFont('����',10,true,false) ; AlignLine(1); WriteText('��ʼ',0); Moveright(1);
       SetFont('����',10,False,false) ; AlignLine(1);
                     WriteText(IntToStr(iDWGrap.DataTimeAndFootAge.Graph_MinDao),0); Moveright(1);
       SetFont('����',10,true,false) ; AlignLine(1); WriteText('����',0); Moveright(1);
       SetFont('����',10,False,false) ; AlignLine(1);
                     WriteText(IntToStr(iDWGrap.DataTimeAndFootAge.Graph_MaxDao),0); Moveright(1);
       SetFont('����',10,true,false) ; AlignLine(1); WriteText('���(��)',0); Moveright(1);
       SetFont('����',10,False,false) ; AlignLine(1);
               D_JIndao:=iDWGrap.DataTimeAndFootAge.Graph_MaxDao-iDWGrap.DataTimeAndFootAge.Graph_MinDao +1;
                     WriteText(IntToStr(D_JIndao),0); Moveright(1);
          if D_JIndao >=80 then  begin
              inc(N_c);
              R_Str:=R_Str+'  ('+IntTostr(N_c)+') ���ݽ�����Χѡ��Ϻã������ڶԿ�ѹ���ֹ��ɵ��жϡ�' +#13#10;
          end else if D_JIndao >=40 then  begin
              inc(N_c);
              R_Str:=R_Str+'  ('+IntTostr(N_c)+') ���ݽ�����Χѡ���С����ѹ���ֹ��ɵ�Ԥ�����Ƭ���ԡ�' +#13#10;
          end else begin
              inc(N_c);
              R_Str:=R_Str+'  ('+IntTostr(N_c)+') ���ݽ�����Χѡ��̫С�������ڿ�ѹ���ֹ��ɵ��жϡ�' +#13#10;
              Subject_Str.Add('31'); { ��ѹ������� ���弼����������}
              Subject_Str.Add('�ù���������ѹ�����ݽ�����Χѡ��̫С��������Ӱ����ѹ���ɵ��жϣ�����ѡ����80����Χ���⡣');
          end;

         // ��4��   ����
       SetFont('����',10,true,false) ; AlignLine(0); WriteText('���ݷ�������',0); Moveright(1);
       SetFont('����',10,true,false) ; AlignLine(1); WriteText('��ʼ',0); Moveright(1);
       SetFont('����',10,False,false) ; AlignLine(1);
                     WriteText(FormatFloat('0.00',iDWGrap.DataTimeAndFootAge.DownStartFootage),0); Moveright(1);
       SetFont('����',10,true,false) ; AlignLine(1); WriteText('����',0); Moveright(1);
       SetFont('����',10,False,false) ; AlignLine(1);
                     WriteText(FormatFloat('0.00',iDWGrap.DataTimeAndFootAge.DownEndFootage),0); Moveright(1);
       SetFont('����',10,true,false) ; AlignLine(1); WriteText('���(��)',0); Moveright(1);
       SetFont('����',10,False,false) ; AlignLine(1);
                     WriteText(FormatFloat('0.00',iDWGrap.DataTimeAndFootAge.DownEndFootage-iDWGrap.DataTimeAndFootAge.DownStartFootage ),0); Moveright(1);
         // ��5��   ֧������
       TableCellMerge(Tab,2,5,3,5);
       SetFont('����',10,true,false) ; AlignLine(0); WriteText('�۲�֧����',0); Moveright(1);
       SetFont('����',10,False,false) ; AlignLine(1);
                    WriteText(IntTostr(iDWGrap.FGzm.SupEndNumber),0); Moveright(1);
       SetFont('����',10,FALSE,false) ; AlignLine(1);  WriteText('��',0); Moveright(1);
       SetFont('����',10,true,false) ; AlignLine(1);  WriteText('�������ݼ��',0); Moveright(1);
       SetFont('����',10,False,false) ; AlignLine(1);
            WriteText(IntToStr(iDwGrap.FGzm.RockPressAnalysis.ManulInput_Interval_support ),0); Moveright(1);
       SetFont('����',10,False,false) ; AlignLine(1);  WriteText('��',0); Moveright(1);
       if iDwGrap.FGzm.RockPressAnalysis.ManulInput_Interval_support < 3 then    begin
           inc(N_c);
           R_Str:=R_Str+'   ('+IntTostr(N_c)+') ֧������̫�ܣ�һ�������ͼ��ˢ���ٶ�;' +
                  ' ��һ���棬̫�ܵ����ݲ�����ȫ�����ݵķ�����һ���Լ��5��Ϊ���š�' +#13#10;
           Subject_Str.Add('31'); { ��ѹ������� ���弼����������}
           Subject_Str.Add('�Կ�ѹ���ݽ���ȫ�ַ���ʱ��û�б�Ҫ��ȫ������������������5������Ч����ѡ�');
       end;

        // ��6��   ֧������
        // ������������
       ReportInputData.FillDataFromDataBase(inGZm.Gzmbh, -1,-1,
                                        iDwGrap.DataTimeAndFootAge.StartTime,
                                        iDwGrap.DataTimeAndFootAge.EndTime);
       TableCellMerge(Tab,2,6,4,6);   TableCellMerge(Tab,3,6,5,6);
       SetFont('����',10,true,false) ; AlignLine(0); WriteText('������������',0); Moveright(1);
       SetFont('����',10,False,false) ; AlignLine(1);
                    WriteText(IntToStr(Round(ReportInputData.TotalCount/10000/5))+'����',0); Moveright(1);

       SetFont('����',10,False,false) ; AlignLine(0);  WriteText('˵��:��Լ5����һ������',0); Moveright(1);
        // ��7��   ֧������
       TableCellMerge(Tab,2,7,5,7);
       SetFont('����',9,true,false) ; AlignLine(2); WriteText('����:��Ч����',0); Moveright(1);
       SetFont('����',10,False,false) ; AlignLine(1);
              WriteText(IntToStr(Round(ReportInputData.ReturnNotEddirctCount /10000/5))+
                        '����(��ֵС��10MPa)',0); Moveright(1);
       SetFont('����',10,true,false) ; AlignLine(1); WriteText('ռ��(%)',0); Moveright(1);
       SetFont('����',10,False,false) ; AlignLine(1);
              WriteText(FormatFloat('0',ReportInputData.ReturnNotEffiectBl )+'%',0); Moveright(1);
        //
        if ReportInputData.ReturnNotEffiectBl > 8 then  begin
           inc(N_c);
           R_Str:=R_Str+'   ('+IntTostr(N_c)+') ��������������Խϲ���ǿ���ֳ��۲����ݵĹ�����' +#13#10;
           Subject_Str.Add('31');
           Subject_Str.Add('���ݷ��������ڣ�������������Խϲ��һ����ǿ�Կ�ѹ������ݵĹ�����');
        end else  if ReportInputData.ReturnNotEffiectBl >4 then  begin
           inc(N_c);
           R_Str:=R_Str+'   ('+IntTostr(N_c)+') ���������������һ�㣬�ֳ���ѹ�۲�������иĽ��Ŀռ䡣' +#13#10;
        end else begin
           inc(N_c);
           R_Str:=R_Str+'   ('+IntTostr(N_c)+') �ֳ���ѹ���ݱ������ã����߿�ѹ�豸����״������������' +#13#10;
        end;

         // ��8��   ֧������
       TableCellMerge(Tab,1,8,7,8);
       SetFont('����',10,true,false) ; AlignLine(1); WriteText('��֧�ܱ�ŷ�������п�ѹ���������仮�����',0); Moveright(1);
         // ��9��   ֧������
       TableCellMerge(Tab,1,9,2,9); TableCellMerge(Tab,2,9,5,9);
       SetFont('����',10,true,false) ; AlignLine(0); WriteText('���仮������',0); Moveright(1);
       SetFont('����',10,False,false) ; AlignLine(1);
           WriteText(IntTostr(iDwGrap.Auto_Judge_OldStep.PhaseNumber)  ,0); Moveright(1);

       SetFont('����',10,False,false) ; AlignLine(1);  WriteText('��',0); Moveright(1);
       Row_st:=10;
       for I := 0 to iDwGrap.Auto_Judge_OldStep.PhaseNumber-1 do  begin
            TableCellMerge(Tab,2,Row_st,3,Row_st);  TableCellMerge(Tab,4,Row_st,5,Row_st);
            SetFont('����',10,true,false) ; AlignLine(0); WriteText('�ڡ�'+IntToStr(i+1)+'������',0); Moveright(1);
            SetFont('����',10,true,false) ; AlignLine(0); WriteText('��ʼ֧����',0); Moveright(1);
            SetFont('����',10,False,false) ; AlignLine(1);
                     WriteText(IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].StartsupBh),0); Moveright(1);
            SetFont('����',10,true,false) ; AlignLine(0); WriteText('����֧�ܱ��',0); Moveright(1);
            SetFont('����',10,False,false) ; AlignLine(1);
                     WriteText(IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].EndSupBh),0); Moveright(1);
            // ������һ��
            inc( Row_st);
              // ������������
            ReportInputData.FillDataFromDataBase(inGZm.Gzmbh,iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].StartsupBh,
                                        iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].EndSupBh,
                                        iDwGrap.DataTimeAndFootAge.StartTime,
                                        iDwGrap.DataTimeAndFootAge.EndTime);
            TableCellMerge(Tab,1,Row_st,2,Row_st);
            SetFont('����',9,true,false) ; AlignLine(2); WriteText('���У���������',0); Moveright(1);
            SetFont('����',9,false,false) ; AlignLine(1); WriteText(IntToStr(Round(ReportInputData.TotalCount/10000/5))+'����',0); Moveright(1);
            SetFont('����',9,true,false) ; AlignLine(0); WriteText('��Ч��',0); Moveright(1);
            SetFont('����',9,false,false) ; AlignLine(1);
                 WriteText(IntToStr(Round(ReportInputData.ReturnEddirctCount/10000/5))+'����',0); Moveright(1);
            SetFont('����',9,true,false) ; AlignLine(0); WriteText('ռ��(%)',0); Moveright(1);
            SetFont('����',9,false,false) ; AlignLine(1);
                 WriteText(FormatFloat('0',ReportInputData.ReturnEffiectBl )+'%',0); Moveright(1);

            if ReportInputData.ReturnNotEffiectBl > 8 then  begin
               inc(N_c);
               R_Str:=R_Str+'   ('+IntTostr(N_c)+') �ڡ�'+intToSTr(i+1)+'�������ѹ���ݵ������Խϲ���ǿ���ֳ��۲����ݵĹ�����' +#13#10;
               Subject_Str.Add('32');
               Subject_Str.Add('�ڡ�'+intToSTr(i+1)+'������(Һѹ֧�ܷ�Χ:'+IntTostr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].StartsupBh)
                                  +'-'+IntTostr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].StartsupBh)+'��)������ݵ������Խϲ���ǿ�Կ�ѹ������ݵĹ�����');
            end else  if ReportInputData.ReturnNotEffiectBl >4 then  begin
               inc(N_c);
               R_Str:=R_Str+'   ('+IntTostr(N_c)+') �ڡ�'+intToSTr(i+1)+'�������ѹ���ݵ�������һ�㣬�ֳ���ѹ�۲�������иĽ��Ŀռ䡣' +#13#10;
            end;
            // ������һ��
            inc( Row_st);
       end;
       MoveDown(1);
       TableBorders(tab,1,1);

       SetFont('����',12,false,false) ; AlignLine(0);
       WriteText('   ��ע:��¼��ͼX-'+IntTostr(PinPutuid)+'����չʾ��ȫ�������ѹ����Ƶ��ͼ��������ʾ�����ѡȡ��12��֧�ܵ�ѹ��Ƶ��ͼ��',1);
       AddReturn();

       R_Str:='   ͨ����'+P_Str+'-1 �ķ������ݣ��Կ�ѹ������������������¡�'+IntTostr(N_c)+'���㿴����' +#13#10 + R_Str;
       SetFont('����',12,false,false) ; AlignLine(0);
       WriteText(R_Str,1);
       AddReturn();
    end;

end;

procedure TWordReport.Add_Second_First_Main (P_Str:string;inGZm: TGzm);
var
 istr:string;
begin

     with innWord do begin
         SetFont('����',14,false,false);
         SetHeading(P_Str+'.1 '+'��ú�������ѹ�������ͳ��ѧ��������',2);// �½�
         SetFont('����',12,False,False);
         istr:='    ��ѡ������������Һѹ֧�ܵļ�����ݽ��м����������������ݵ���������ز���������'+P_Str+'.1��ʾ��';
         WriteText(istr,1); AddReturn();

         SetFont('����',11,true,false);AlignLine(1);
         WriteText('��'+P_Str+'.1 ��ѹ����������弼������������',0);
          // ������ ��һ��  ��һС��
         Add_Second_First(P_Str,inGZm);


     end ;




end;

procedure TWordReport.Add_Second_QianYan;
var
 istr:string;
begin
    with innWord do begin
        SetFont('����',12,False,False);

        istr:='   �����ᵽ��ͳ�Ʒ���������Ҫָͳ��ѧ�е�������ϵ����������';
        WriteText(istr,1);  AddReturn();
         istr:='   ������ϵ��������������ͳ��ѧ�������ķ����Կ�ѹ���ݵ��������֣� '  +
               '�������ݵĹ�ģ��ˮƽ���ٶȡ��ṹ����������֮�����ϵ���з����ķ����� ' +
               '��Աȷ�������ƽ���ͱ�����������ۺ����۷��������ṹ��������ƽ�����������̬�����������ط���������ط������ȡ���';
        WriteText(istr,1); AddReturn();
         istr:='   ���½���Ҫ��ʵʱ��ѹ���ݽ����˾�ֵ�������׼���λ������������ȡ�ƫ�ȡ���������Ȳ������з�����'+
               '����ͳ��ѧ����Ѱ�ҿ�ѹ����֮������ڹ�ϵ';
        WriteText(istr,1); AddReturn();

    end;

end;

procedure TWordReport.Add_Second_Two_Table_2(P_Str: string; inGZm: TGzm;phaseNumber:integer);
var
  k,Sub_id,iRow:integer;
  Tab:Table;
  Str_Out,istr:string;
begin
   {ChangeThreeArrayContourGrid}
    with innWord do begin //
         SetFont('����',12,False,False);
         inc(Second_Tab_id);
         if iDWGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array_Count< 1 then  begin
            istr:='    �ڸ�����û�м��������Ե���ѹ��Ϣ��';
            WriteText(istr,1); AddReturn();
            exit;
         end;
         istr:='    �Ա�'+P_Str+'-'+IntTostr(Second_Tab_id-1)+'���ݽ�������ѹ�����ж�'+
               '������'+P_Str+'-'+IntTostr(Second_Tab_id) +'��ʾ';
         WriteText(istr,1); AddReturn();

         SetFont('����',11,true,false);AlignLine(1);
         SetHeading('��'+P_Str+'-'+IntTostr(Second_Tab_id)+' ��'+Public_Basic.GetChineseNumber(phaseNumber+1)+'���䡾'+
                    IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].StartsupBh) +'-'+
                    IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].EndSupBh) +'����֧�ܿ�ѹ�������������',4);
         SetFont('����',10,false,false) ;
         AlignLine(0);
         iRow:=3;
         Tab:=AddTable(11,iRow);
         setTableColumsWidth(Tab,1,15);  setTableColumsWidth(Tab,2,15);
         setTableColumsWidth(Tab,3,15);  setTableColumsWidth(Tab,4,15);
         setTableColumsWidth(Tab,5,15);  setTableColumsWidth(Tab,6,15);
         setTableColumsWidth(Tab,7,15);  setTableColumsWidth(Tab,8,15);
         setTableColumsWidth(Tab,9,15);  setTableColumsWidth(Tab,10,15);
          // �ϲ���Ԫ��

         TableCellMerge(Tab,7,1,11,1);
         TableCellMerge(Tab,1,1,6,1);
         TableCellMerge(Tab,9,2,11,2);
         TableCellMerge(Tab,7,2,8,2);
         TableCellMerge(Tab,4,2,6,2);
         TableCellMerge(Tab,2,2,3,2);



         SetFont('����',9,true,false) ; AlignLine(1); WriteText('��ѹ������Ϣ',0); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('������ѹ������Ϣ',0); Moveright(1); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('��ʼ',0); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('����',0); Moveright(1);

         SetFont('����',9,true,false) ; AlignLine(1); WriteText('��ʼ',0); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('����',0); Moveright(1);


         SetFont('����',9,true,false) ; AlignLine(1); WriteText('���',0); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('����',0); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('����m',0); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('����',0); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('����m',0); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('����m',0); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('����',0); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('����m',0); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('����',0); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('����m',0); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('����m',0); Moveright(1);

         for k := 0 to   iDWGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array_Count -1 do  begin
//             insertRow(Tab,0,1);inc(iRow); MoveDown(1);
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(intTostr(k+1),0);  Moveright(1);
             SetFont('����',9,false,false) ; AlignLine(1); //��ʼ����
                WriteText(FormatFloat('0',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_Start_JinD),0); Moveright(1);
              SetFont('����',9,false,false) ; AlignLine(1);  //��ʼ����
                WriteText(FormatFloat('0.0',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_Start_FG),0); Moveright(1);
              SetFont('����',9,false,false) ; AlignLine(1);  //��������
                WriteText(FormatFloat('0',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_End_JinD),0); Moveright(1);
             SetFont('����',9,false,false) ; AlignLine(1);  //��������
                WriteText(FormatFloat('0.0',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_End_FG),0); Moveright(1);
             SetFont('����',9,false,false) ; AlignLine(1);  //�����ֵ
                WriteText(FormatFloat('0.0',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_End_FG -
                             iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_Start_FG),0); Moveright(1);

             SetFont('����',9,false,false) ; AlignLine(1); //������ʼ����
                WriteText(FormatFloat('0',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_U_st_JinD),0); Moveright(1);
             SetFont('����',9,false,false) ; AlignLine(1);  //������ʼ����
                WriteText(FormatFloat('0.0',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_U_st_FG),0); Moveright(1);

             SetFont('����',9,false,false) ; AlignLine(1);  //������������
                WriteText(FormatFloat('0',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_U_Ed_JinD),0); Moveright(1);
             SetFont('����',9,false,false) ; AlignLine(1);  //������������
                WriteText(FormatFloat('0.0',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_U_Ed_FG),0); Moveright(1);
             SetFont('����',9,false,false) ; AlignLine(1);  //���������ֵ
                WriteText(FormatFloat('0.0',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_U_Ed_FG -
                             iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Step_Array[k].Get_U_st_FG),0);Moveright(1);

         end;

          // ������Ԫ��
         MoveDown(1);
         TableBorders(tab,1,1);
         AddReturn();

    end;
end;

procedure TWordReport.Add_Second_Two_Jielun(P_Str: string; inGZm: TGzm);
var
  i,k,Jie_id:integer;
  istr:string;
  V_count:integer;
  AGV_Dao,AGV_JinChi,T_A_D,T_A_C:double;
  Totalcount:integer;
begin
  with innWord do begin //
      SetFont('����',12,False,False);
      istr:='   ͨ��ǰ������ͳ��ѧ�ķ����������з������ù�����ʵ�ʿ��ɹ����п�ѹ������£�';
      WriteText(istr,1);  AddReturn();
      Jie_id:=0;
      T_A_D:=0;T_A_C:=0; V_count:=0;  Totalcount:=0;
      for I := 0 to iDwGrap.Auto_Judge_OldStep.PhaseNumber-1 do  begin
         if iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].Step_Array_Count>0 then  begin
            inc(Jie_id);
            istr:='   ('+intTostr(Jie_id)+') ��'+Public_Basic.GetChineseNumber(i+1)+'���䡾'+IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].StartsupBh) +'-'+
                  IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].EndSupBh) +'����֧�ܾ�����'+
                  intTostr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].Step_Array_Count) +'���˶����ڣ�';
            AGV_Dao:=0;AGV_JinChi:=0;
            for k := 0 to   iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].Step_Array_Count -1 do  begin
                AGV_Dao:=AGV_Dao+ iDwGrap.Auto_Judge_OldStep.PhaseSteps[i].Step_Array[k].Get_End_JinD -
                             iDwGrap.Auto_Judge_OldStep.PhaseSteps[i].Step_Array[k].Get_Start_JinD;
                AGV_JinChi:=AGV_JinChi+iDwGrap.Auto_Judge_OldStep.PhaseSteps[i].Step_Array[k].Get_End_FG -
                             iDwGrap.Auto_Judge_OldStep.PhaseSteps[i].Step_Array[k].Get_Start_FG;
                inc(Totalcount);
            end;
            AGV_Dao:=AGV_Dao/iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].Step_Array_Count;
            AGV_JinChi:=AGV_JinChi/iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].Step_Array_Count;
            inc(V_count);
            T_A_D:=T_A_D+AGV_Dao;
            T_A_C:=T_A_C+AGV_JinChi;
            istr:=istr+'�˶�����ƽ������Ϊ��'+FormatFloat('0.00' , AGV_Dao)+'����ƽ������Ϊ��'+
                  FormatFloat('0.00' , AGV_JinChi)+'��';
            WriteText(istr,1);  AddReturn();
         end else begin
           inc(Jie_id);
           istr:='   ('+intTostr(Jie_id)+') ��'+Public_Basic.GetChineseNumber(i+1)+'���䡾'+IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].StartsupBh) +'-'+
                  IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[i].EndSupBh) +'����֧��û�и�Ӧ����ϸ�������˶���';
           WriteText(istr,1);  AddReturn();
         end;
      end;

      if V_count>0 then begin
          inc(Jie_id);
          istr:='   ('+intTostr(Jie_id)+') ����ͳ��ѧ��������������������'+
                 FormatFloat('0' ,iDwGrap.DataTimeAndFootAge.Graph_MinDao) +'����' + FormatFloat('0' ,iDwGrap.DataTimeAndFootAge.Graph_MaxDao)+
                 '��֮���ѹ�����ݣ���Ӧ������ѹ�����֡�'+intTostr(Totalcount)+'���Σ�ƽ������Ϊ' +FormatFloat('0.00' , T_A_D/V_count)+'����ƽ������Ϊ��'+
                  FormatFloat('0.00' , T_A_C/V_count)+'��';
          WriteText(istr,1);  AddReturn();
      end;
  end;
end;

procedure TWordReport.Add_Second_Two_Table_1(P_Str: string; inGZm: TGzm;phaseNumber:integer);
var
  k,Sub_id:integer;
  Tab:Table;
  Str_Out,istr:string;
begin
   {ChangeThreeArrayContourGrid}
    with innWord do begin
//
         AddReturn();
         SetFont('����',12,False,False);
         inc(Second_Tab_id);
         istr:='    ��'+P_Str+'-'+IntTostr(Second_Tab_id)+'�ǶԵڡ�'+IntTostr(phaseNumber+1)+'�����������'+
               '����ͳ��ѧ����������';
         WriteText(istr,1); AddReturn();

         SetFont('����',11,true,false);AlignLine(1);
         SetHeading('��'+P_Str+'-'+IntTostr(Second_Tab_id)+' ��'+Public_Basic.GetChineseNumber(phaseNumber+1)+'���䡾'+
                    IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].StartsupBh) +'-'+
                    IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].EndSupBh) +'����֧��ͳ��ѧ��������',4);
         SetFont('����',10,false,false) ;
         AlignLine(0);
         Tab:=AddTable(6,18);
         setTableColumsWidth(Tab,1,30);  setTableColumsWidth(Tab,2,25);
         setTableColumsWidth(Tab,3,25);  setTableColumsWidth(Tab,4,25);
         setTableColumsWidth(Tab,5,25);  setTableColumsWidth(Tab,6,25);
         //��һ��
         SetFont('����',9,true,false) ; AlignLine(0); WriteText('������',0); Moveright(1);
                SetFont('����',9,False,false) ; AlignLine(1); WriteText(InttoStr(phaseNumber+1),0); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(0); WriteText('��ʼ֧�ܱ��',0); Moveright(1);
                SetFont('����',9,False,false) ; AlignLine(1);
                WriteText(IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].StartsupBh),0); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(0); WriteText('����֧�ܱ��',0); Moveright(1);
                SetFont('����',9,False,false) ; AlignLine(1);
                WriteText(IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].EndSupBh),0); Moveright(1);
         // �ڶ���
         TableCellMerge(Tab,1,2,6,2); Moveright(1);
         //������
         //�����ͷ
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('��Ŀ����',0); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('ѭ�����ֵ',0); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('ѭ��ƽ��ֵ',0); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('ѭ��������',0); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('ѭ��ĩ����',0); Moveright(1);
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('ͬһʱ��ֵ',0); Moveright(1);
         // ���������(�ӵ������� ��һ�е� ���ݣ�
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('ƽ����',0); MoveDown(1);   // ��4 ��
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('��׼���',0); MoveDown(1);  // ��5 ��
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('��λ��',0); MoveDown(1);  // ��6 ��
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('����',0); MoveDown(1);    // ��7 ��
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('��׼��',0); MoveDown(1);  // ��8 ��
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('����',0); MoveDown(1);   // ��9 ��
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('���',0); MoveDown(1);   // ��10 ��
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('ƫ��',0); MoveDown(1);   // ��11 ��
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('����',0); MoveDown(1);   // ��12��
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('��Сֵ',0); MoveDown(1);   // ��13 ��
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('���ֵ',0); MoveDown(1);   // ��14 ��
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('���',0); MoveDown(1);     // ��15��
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('�۲���',0); MoveDown(1);   // ��16 ��
         SetFont('����',9,true,false) ; AlignLine(1); WriteText('���Ŷ�(95.0%)',0);  // ��17 ��
         // ���ݷ���
         Str_Out:=''; Sub_id:=0;
         for k := 0 to 4 do   begin // ������������
             MoveRight(1);  MoveUp(13);
             iDwGrap.ChangeThreeArrayContourGrid(iDwGrap.ColorValue.UnitType ,K);
             if iDwGrap.ColorValue.UnitType =1 then  begin
                iDwGrap.Auto_Judge_OldStep.CalCulatePhaseStatistical_Data(iDwGrap.MyContourDoubleGrid,iDwGrap.FilledContourData,1);
             end else begin
                iDwGrap.Auto_Judge_OldStep.CalCulatePhaseStatistical_Data(iDwGrap.MyContourDoubleGrid,iDwGrap.FilledContourData,10);
             end;
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_AGV),0); MoveDown(1);   // ��4 ��
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_Standard_erro),0); MoveDown(1);   // ��5 ��
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_Median),0); MoveDown(1);   // ��6 ��
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_Model),0); MoveDown(1);   // ��7 ��
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_Standard_Deviation),0); MoveDown(1);   // ��8 ��
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_Variance),0); MoveDown(1);   // ��9 ��
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_peakedness),0); MoveDown(1);   // ��10 ��
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_bs),0); MoveDown(1);   // ��11 ��
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_max_Min),0); MoveDown(1);   // ��12 ��
              SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_Min_Data),0); MoveDown(1);   // ��13 ��
              SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_Max_Data),0); MoveDown(1);   // ��14 ��
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_ToTal),0); MoveDown(1);   // ��15 ��
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(IntTostr(iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_Count),0); MoveDown(1);   // ��16 ��
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(FormatFloat('0.00',iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Statistical_data.Get_ZXQD95),0);   // ��17 ��

         end;
         // ��18��
          TableCellMerge(Tab,1,18,6,18); MoveDown(1);
          SetFont('����',9,False,false) ; AlignLine(0);
                WriteText(Add_Second_Two_Table_fulu_Bmp(phaseNumber),0);
          // ������Ԫ��
          MoveDown(1); TableBorders(tab,1,1);
          AddReturn();

    end;
end;

function TWordReport.Add_Second_Two_Table_fulu_Bmp(PhaseNumber:Integer):string;
{
   ComeStep  False  ������ǰ��� ͳ�����֣�û����ѹ�������Ϣ ��Ҫʵ��  Ƶ��ͼ  ѹ����������ͼ
             true   �����Ǻ����  ��ѹ��������  Ҫ��ʾ ��ѹ�������Ϣ�� ��Ҫʵ����ѹ��������
}
var
   PathFile,iStr:String;
begin
   // �Ѹ�¼��ͼ�� ��������
    iStr:='   ��ע��';
    innword.createBookMark('tempPosition' );
    try
       //��ֱ��ͼģʽ
         CreateBand_Bar(ExHandle,'',0,0,2);
          iDwGrap.BarMarks.Fromcontour:=true;;//��������ͼ�д�������
          if Assigned(Form_Band_Bar) then  begin
              Form_Band_Bar.InitForm(iDwGrap) ;
              iDwGrap.Auto_Judge_OldStep.PhaseSteps[PhaseNumber].SetSupportInval_ExUsed(iDwGrap.FGzm.RockPressAnalysis.ManulInput_Interval_support) ;
              iDwGrap.GraphClass.SupportList :=iDwGrap.Auto_Judge_OldStep.PhaseSteps[PhaseNumber].returnSupportList ;
              Form_Band_Bar.SetOpenFormVar(iDwGrap.GraphClass.SupportList,
                                    true, //�ⲿ����������
                                    true// �Ƿ�򿪹��߲˵�
                                    );

          end;
         FormPressTool.Close ;
         Form_Band_Bar.RefreshBarSeries(PhaseNumber);
         Form_Band_Bar.Main_panel.Refresh;
         PathFile:=Form_Band_Bar.AutoSaveOnesupportOneBMP(PhaseNumber+1);
         ChangePictureWidth(PathFile);
         if PathFile<>'' then  begin
            inc(fuLu_Tu_id);
            Add_FuLuTu(0,fuLu_Tu_id,
                  '��'+MainDataModule.WorkFace_Name+'�����桿��'+Public_Basic.GetChineseNumber(PhaseNumber+1)+
                   '�����Һѹ֧��ѹ��Ƶ��ͼ', '',PathFile);
            iStr:=iStr+'ѹ��Ƶ��ͼ����¼ͼ X-'+IntToStr(fuLu_Tu_id) +',';
         end;
         Form_Band_Bar.Close ;


     // �� ����ͼ ���ƽ���
        CreateLineGraph(ExHandle,'',0,0,2);
        iDwGrap.GraphClass.CycleDataEfficient:=False;//��������ͼ�д�������
        Form_LineGraph.SetOpenFormVar(Form_ContourGraph.DrawGzm,
                                      iDwGrap.Auto_Judge_OldStep.PhaseSteps[PhaseNumber].returnSupportList,
                                      true, // �Ƿ��в�����Ϣ
                                      true// �Ƿ�򿪹��߲˵�
                                      );
        FormPressTool.Close ;
        Form_LineGraph.Main_Line_DrawClass.GraphClass.YAxisType :=5; // ����������
        Form_LineGraph.RefreshMyGraphChart(true);
        PathFile:=Form_LineGraph.SaveChartToBmp;
        ChangePictureWidth(PathFile);
         if PathFile<>'' then  begin
            inc(fuLu_Tu_id);
            Add_FuLuTu(0,fuLu_Tu_id,
                  '��'+MainDataModule.WorkFace_Name+'�����桿��'+Public_Basic.GetChineseNumber(PhaseNumber+1)+
                   '����Һѹ֧��ѹ������ͼ(6Y)', '(6��Y�����ᣬÿ����������ʾ����֧�ܵ�ѹ������)',PathFile);
            iStr:=iStr+'ѹ������ͼ���������ᣩ����¼ͼ X-'+IntToStr(fuLu_Tu_id) +',';
         end;

       Form_LineGraph.Main_Line_DrawClass.GraphClass.YAxisType :=1;
       Form_LineGraph.DrawLineGraph.NextDataDisp:=0; // ��һ��
       Form_LineGraph.DrawLineGraph.MarkerStep:=FALSE;
       Form_LineGraph.RefreshMyGraphChart(true);
       PathFile:=Form_LineGraph.SaveChartToBmp;
       ChangePictureWidth(PathFile);
       if PathFile<>'' then  begin
          inc(fuLu_Tu_id);
          Add_FuLuTu(0,fuLu_Tu_id,
                '��'+MainDataModule.WorkFace_Name+'�����桿��'+Public_Basic.GetChineseNumber(PhaseNumber+1)+
                 '����Һѹ֧��ѹ������ͼ��1��', '(�ĸ������ᣬÿ����������ʾһ�����ߣ���һ��)',PathFile);
          iStr:=iStr+'ѹ������ͼ1����¼ͼ X-'+IntToStr(fuLu_Tu_id) +',';
       end;
       //
       Form_LineGraph.DrawLineGraph.NextDataDisp:=1; // �ڶ���
       Form_LineGraph.DrawLineGraph.MarkerStep:=FALSE;
       Form_LineGraph.RefreshMyGraphChart(true);
       PathFile:=Form_LineGraph.SaveChartToBmp;
       ChangePictureWidth(PathFile);
       if PathFile<>'' then  begin
          inc(fuLu_Tu_id);
          Add_FuLuTu(0,fuLu_Tu_id,
                '��'+MainDataModule.WorkFace_Name+'�����桿��'+Public_Basic.GetChineseNumber(PhaseNumber+1)+
                  '����Һѹ֧��ѹ������ͼ��2��', '(�ĸ������ᣬÿ����������ʾһ�����ߣ��ڶ���)',PathFile);
          iStr:=iStr+'ѹ������ͼ2����¼ͼ X-'+IntToStr(fuLu_Tu_id) +',';
       end;

       Form_LineGraph.DrawLineGraph.NextDataDisp:=2; // ������
       Form_LineGraph.DrawLineGraph.MarkerStep:=FALSE;
       Form_LineGraph.RefreshMyGraphChart(true);
       PathFile:=Form_LineGraph.SaveChartToBmp;
       ChangePictureWidth(PathFile);
       if PathFile<>'' then  begin
          inc(fuLu_Tu_id);
          Add_FuLuTu(0,fuLu_Tu_id,
                '��'+MainDataModule.WorkFace_Name+'�����桿��'+Public_Basic.GetChineseNumber(PhaseNumber+1)+
                '����Һѹ֧��ѹ������ͼ��3��', '(�ĸ������ᣬÿ����������ʾһ�����ߣ�������)',PathFile);
          iStr:=iStr+'ѹ������ͼ3����¼ͼX-'+IntToStr(fuLu_Tu_id) +'��';
       end;
       Form_LineGraph.Close ;


    finally

    end;
    // ��ǩ�ٻ���
    innword.GotoBookMark('tempPosition');
   //ɾ������ǩ
    innword.DeleteBookMark('tempPosition');
    Result:=iStr;
end;

procedure TWordReport.Add_Third_two_Main(P_Str: string; inGZm: TGzm);
var
  istr,PathFile:string;
  P_c,P,ComeStep:integer;
  th_id:integer;
begin
    P_c:=1;
    with innWord do begin
         for P := 0 to iDWGrap.Auto_Judge_OldStep.PhaseNumber -1 do  begin
             inc(P_c);
             SetFont('����',14,false,false);
             SetHeading(P_Str+'.'+IntTostr(P_c )+' '+'��ú�������ѹ����' +
                    '�ڡ�'+Public_Basic.GetChineseNumber(P+1)+'��������������',2);// �½�
              istr:='    Ϊʹ��ѹ�������и�ǿ������ԣ����չ������ѹ���ֹ��ɵĲ��죬�ѹ����水Һѹ֧�ܱ�Ż���Ϊ' +
                    intTostr(iDWGrap.Auto_Judge_OldStep.PhaseNumber) +'���������䣬��������������������ѹ���ֹ��ɡ�' ;
             SetFont('����',12,False,False);
             WriteText(istr,1);  AddReturn();
             istr:='    ������Ϊ���ֵĵ�'+Public_Basic.GetChineseNumber(P+1)+'�����䣬�������Һѹ֧�ܱ�ŷ�ΧΪ�ڡ�'+
                IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].StartsupBh ) +'���ܵ��ڡ�'+
                IntToStr(iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].EndSupBh ) +'���ܡ�';
             SetFont('����',12,False,False);
             WriteText(istr,1);  AddReturn();
             //
             th_id:=0;
             ComeStep:=iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(10);
             if ComeStep>0  then   begin
                 inc(th_id);
                 SetFont('����',12,false,false);
                 SetHeading(P_Str+'.'+IntTostr(P_c )+'.'+IntTostr(th_id)+' �ڡ�'+Public_Basic.GetChineseNumber(P+1)+
                           '�������ѹ���������������',3);// �½�
                 istr:='    ���������ݷ��������õ���ѹ������������'+IntTostr(ComeStep)+'������������Ϣ����'+
                      P_Str+'-'+intToStr(Third_Tab_id+1)+ '��';
                 SetFont('����',12,False,False);
                 WriteText(istr,1);  AddReturn();

                 SetFont('����',11,true,false);AlignLine(1);
                 inc(third_Tab_id);
                 SetHeading('��'+P_Str+'-'+intToStr(Third_Tab_id)+' �ڡ�'+Public_Basic.GetChineseNumber(P+1)+
                           '�������ѹ��������������Ϣ��',4);
                 Add_Third_two_one(p,P_c,10,P_Str,inGZm);
             end;
            //----------
             ComeStep:=iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(9);
             if ComeStep>0  then   begin
                 inc(th_id);
                 SetFont('����',12,false,false);
                 SetHeading(P_Str+'.'+IntTostr(P_c )+'.'+IntTostr(th_id)+' �ڡ�'+Public_Basic.GetChineseNumber(P+1)+
                           '�������ѹ���������������',3);// �½�
                 istr:='    ���������ݷ��������õ���ѹ������������'+IntTostr(ComeStep)+'������������Ϣ����'+
                      P_Str+'-'+intToStr(Third_Tab_id+1)+ '��';
                 SetFont('����',12,False,False);
                 WriteText(istr,1);  AddReturn();

                 SetFont('����',11,true,false);AlignLine(1);
                 inc(third_Tab_id);
                 SetHeading('��'+P_Str+'-'+intToStr(Third_Tab_id)+' �ڡ�'+Public_Basic.GetChineseNumber(P+1)+
                           '�������ѹ��������������Ϣ��',4);
                  Add_Third_two_one(p,P_c,9,P_Str,inGZm);
             end;
            //----------
             ComeStep:=iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(8)+
                       iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(5)+
                       iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(6);
             if ComeStep>0  then   begin
                 inc(th_id);
                 SetFont('����',12,false,false);
                 SetHeading(P_Str+'.'+IntTostr(P_c )+'.'+IntTostr(th_id)+' �ڡ�'+Public_Basic.GetChineseNumber(P+1)+
                           '������ֲ���ѹ�쳣�������',3);// �½�
                 istr:='    ���������ݷ��������õ��ֲ���ѹ�쳣��Ϣ��'+IntTostr(ComeStep)+'������������Ϣ����'+
                      P_Str+'-'+intToStr(Third_Tab_id+1)+ '��';
                 SetFont('����',12,False,False);
                 WriteText(istr,1);  AddReturn();

                 SetFont('����',11,true,false);AlignLine(1);
                 inc(third_Tab_id);
                 SetHeading('��'+P_Str+'-'+intToStr(Third_Tab_id)+' �ڡ�'+Public_Basic.GetChineseNumber(P+1)+
                           '������ֲ���ѹ�쳣������Ϣ��',4);
                 Add_Third_two_one(p,P_c,-1,P_Str,inGZm);
             end;

              //----------
             ComeStep:=iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(30) +
                       iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(27);
             if ComeStep>0  then   begin
                 inc(th_id);
                 SetFont('����',12,false,false);
                 SetHeading(P_Str+'.'+IntTostr(P_c )+'.'+IntTostr(th_id)+' �ڡ�'+Public_Basic.GetChineseNumber(P+1)+
                           '������δ�������ѹ����Ԥ�����',3);// �½�
                 ComeStep:=iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(30);
                 if ComeStep > 0 then  begin
                     istr:='    ���ÿ�ɽѹ�������Ե�'+Public_Basic.GetChineseNumber(P+1)+'���䶥���˶��������Ԥ������� ' +
                           'ϵͳԤ���ѹ������������'+IntTostr(ComeStep)+'����Ϣ��������Ϣ����'+
                          P_Str+'-'+intToStr(Third_Tab_id+1)+ ',ͼ����Ϣ��ͼX-'+IntTostr(4)+'��ͼ�к�ɫ����ΪԤ���ѹ������������'+
                          ' ��ɫ����ΪԤ���ѹ�����������򣩡�';
                     SetFont('����',12,False,False);
                     WriteText(istr,1);  AddReturn();

                     SetFont('����',11,true,false);AlignLine(1);
                     inc(third_Tab_id);
                     SetHeading('��'+P_Str+'-'+intToStr(Third_Tab_id)+' �ڡ�'+Public_Basic.GetChineseNumber(P+1)+
                           '������δ�������ѹ��������Ԥ����Ϣ��',4);
                     AddReturn();
                     Add_Third_two_one(p,P_c,30,P_Str,inGZm);
                 end;

                 ComeStep:=iDWGrap.Auto_Judge_OldStep.PhaseSteps[p].GetComeStepCount(27);
                 if ComeStep > 0 then  begin
                     istr:='    ���ÿ�ɽѹ�����ۣ��Ե�'+Public_Basic.GetChineseNumber(P+1)+'���䶥���˶��������Ԥ������� ' +
                           'ϵͳԤ���ѹ������������'+IntTostr(ComeStep)+'������������Ϣ����'+
                          P_Str+'-'+intToStr(Third_Tab_id+1)+ '��';
                     SetFont('����',12,False,False);
                     WriteText(istr,1);  AddReturn();

                     SetFont('����',11,true,false);AlignLine(1);
                     inc(third_Tab_id);
                     SetHeading('��'+P_Str+'-'+intToStr(Third_Tab_id)+' �ڡ�'+Public_Basic.GetChineseNumber(P+1)+
                           '������δ�������ѹ��������Ԥ����Ϣ��',4);
                     AddReturn();
                     Add_Third_two_one(p,P_c,27,P_Str,inGZm);
                 end;
             end;

            SetFont('����',12,false,false);AlignLine(0);
            WriteText( Add_Third_two_Main_Chlid_Add_fulu_Bmp(p) ,1);
            AddReturn();
            public_Basic.WriteMakeWordPercent(true,65+5*p);
         end;
    end;
end;

procedure TWordReport.Add_Third_two_one(phaseNumber,P_c,modify: integer;
  P_Str: string; inGZm: TGzm);
var
  i,i_Row,come_c:integer;
  tab:Table;
begin
    with innWord do begin
       SetFont('����',11,false,false) ;
       AlignLine(0);
       Tab:=AddTable(8,1);
       setTableColumsWidth(Tab,1,25);  setTableColumsWidth(Tab,2,15);
       setTableColumsWidth(Tab,3,25);  setTableColumsWidth(Tab,4,15);
       setTableColumsWidth(Tab,5,25);  setTableColumsWidth(Tab,6,15);
       setTableColumsWidth(Tab,7,25);  setTableColumsWidth(Tab,8,15);
           //��ͷ
       i_Row:=0; come_c:=0;
       for I := 0 to high(iDWGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Steps) do  begin
              if Modify>0  then   begin
                 if iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Steps[i].ModifyData <> Modify  then
                    continue;
              end else  begin
                 if (iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Steps[i].ModifyData <> 5 ) and
                    (iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Steps[i].ModifyData <> 8 ) and
                    (iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Steps[i].ModifyData <> 6 ) then
                    continue;
              end;

              if not((iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Steps[i].EndDao>iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Steps[i].StartDao ) and
                 (iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Steps[i].EndSup>iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Steps[i].StartSup )) then
                     continue;
             // ������д�����
             Add_Third_one_First_Table_Chlid(phaseNumber+1,iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].Steps[i],
                                            iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].StartsupBh,
                                            iDwGrap.Auto_Judge_OldStep.PhaseSteps[phaseNumber].EndSupBh,
                                            tab,come_c,i_Row);
       end;
       TableBorders(tab,1,1);
       MoveDown(1); MoveDown(1);


    end;
end;

function TWordReport.Add_Third_two_Main_Chlid_Add_fulu_Bmp(
  PhaseNumber: Integer): string;
var
   PathFile,iStr:String;
begin
   // �Ѹ�¼��ͼ�� ��������
    iStr:='   ��ע��';
    innword.createBookMark('tempPosition' );
    try

     // �� ����ͼ ���ƽ���
        CreateLineGraph(ExHandle,'',0,0,2);
        iDwGrap.GraphClass.CycleDataEfficient:=False;//��������ͼ�д�������
        Form_LineGraph.SetOpenFormVar(Form_ContourGraph.DrawGzm,
                                      iDwGrap.Auto_Judge_OldStep.PhaseSteps[PhaseNumber].returnSupportList,
                                      true, // �Ƿ��в�����Ϣ
                                      true// �Ƿ�򿪹��߲˵�
                                      );
        FormPressTool.Close ;
        Form_LineGraph.Main_Line_DrawClass.GraphClass.YAxisType :=4; // 4��������
        Form_LineGraph.DrawLineGraph.MarkerStep:=true;
        Form_LineGraph.RefreshMyGraphChart(true);
        PathFile:=Form_LineGraph.SaveChartToBmp;
         if PathFile<>'' then  begin
            inc(fuLu_Tu_id);
            ChangePictureWidth(PathFile);
            Add_FuLuTu(0,fuLu_Tu_id,
                  '��'+MainDataModule.WorkFace_Name+'�����桿��'+Public_Basic.GetChineseNumber(PhaseNumber+1)+
                   '����Һѹ֧�ܿ�ѹ���ֱ�עͼ��4Y��', '(�ĸ������ᣬÿ����������ʾ��ʾ��������)',PathFile);
            iStr:=iStr+'��ѹ���ֱ�עͼ���������ᣩ����¼ͼX-'+IntToStr(fuLu_Tu_id) +',';
         end;

       Form_LineGraph.Main_Line_DrawClass.GraphClass.YAxisType :=1;
       Form_LineGraph.DrawLineGraph.NextDataDisp:=0; // ��һ��
       Form_LineGraph.DrawLineGraph.MarkerStep:=true;
       Form_LineGraph.RefreshMyGraphChart(true);
       PathFile:=Form_LineGraph.SaveChartToBmp;
       if PathFile<>'' then  begin
          inc(fuLu_Tu_id);
          ChangePictureWidth(PathFile);
          Add_FuLuTu(0,fuLu_Tu_id,
                '��'+MainDataModule.WorkFace_Name+'�����桿��'+Public_Basic.GetChineseNumber(PhaseNumber+1)+
                '�����ѹ���ֱ�עͼ��1��', '(�ĸ������ᣬÿ����������ʾһ�����ߣ���һ��)',PathFile);
          iStr:=iStr+'��ѹ���ֱ�עͼ1����¼ͼX-'+IntToStr(fuLu_Tu_id) +'��';
       end;
       //
       Form_LineGraph.DrawLineGraph.NextDataDisp:=1; // �ڶ���
       Form_LineGraph.DrawLineGraph.MarkerStep:=true;
       Form_LineGraph.RefreshMyGraphChart(true);
       PathFile:=Form_LineGraph.SaveChartToBmp;
       if PathFile<>'' then  begin
          inc(fuLu_Tu_id);
          ChangePictureWidth(PathFile);
          Add_FuLuTu(0,fuLu_Tu_id,
                '��'+MainDataModule.WorkFace_Name+'�����桿��'+Public_Basic.GetChineseNumber(PhaseNumber+1)+
                 '�����ѹ���ֱ�עͼ��2��', '(�ĸ������ᣬÿ����������ʾһ�����ߣ��ڶ���)',PathFile);
           iStr:=iStr+'��ѹ���ֱ�עͼ2����¼ͼX-'+IntToStr(fuLu_Tu_id) +';';
       end;

       Form_LineGraph.DrawLineGraph.NextDataDisp:=2; // ������
       Form_LineGraph.DrawLineGraph.MarkerStep:=true;
       Form_LineGraph.RefreshMyGraphChart(true);
       PathFile:=Form_LineGraph.SaveChartToBmp;
       if PathFile<>'' then  begin
          inc(fuLu_Tu_id);
          ChangePictureWidth(PathFile);
          Add_FuLuTu(0,fuLu_Tu_id,
                '��'+MainDataModule.WorkFace_Name+'�����桿��'+Public_Basic.GetChineseNumber(PhaseNumber+1)+
                '�����ѹ���ֱ�עͼ��3��', '(�ĸ������ᣬÿ����������ʾһ�����ߣ�������)',PathFile);
          iStr:=iStr+'��ѹ���ֱ�עͼ3����¼ͼX-'+IntToStr(fuLu_Tu_id) +'��';
       end;
       Form_LineGraph.Close ;


    finally

    end;
    // ��ǩ�ٻ���
    innword.GotoBookMark('tempPosition');
   //ɾ������ǩ
    innword.DeleteBookMark('tempPosition');
    Result:=iStr;

end;

procedure TWordReport.Add_Third_one_First_Table_Chlid(phaseNumber:integer;OneStepIn: TcomprehensiveOldStep;
       sup_st,sup_ed:integer;   itab: Table;var come_i,iRow:integer);
var
  t_str,R_Str:string;
  Ex_Stepid,N:integer;
begin
 //����һ��
     with innWord do begin
             insertRow(itab,0,1);inc( iRow);Moveright(1);
             inc(come_i);
             TableCellMerge(itab,2,iRow,8,iRow);
             SetFont('����',9,true,false) ; AlignLine(1); WriteText(InttoStr(come_i),0); Moveright(1);
             if phaseNumber >0 then   begin
                   if OneStepIn.ModifyData =10 then  begin
                      t_str:='��'+Public_Basic.GetChineseNumber(phaseNumber)+
                             '����(֧�ܷ�Χ:'+IntTostr(sup_st) +'-'+IntTostr(sup_ed)+')'+
                             '�ڡ�'+InttoStr(come_i)+'������ѹ������������ͨ��';
                   end else if OneStepIn.ModifyData =9 then  begin
                      t_str:='��'+Public_Basic.GetChineseNumber(phaseNumber)+'����(֧�ܷ�Χ:'+
                              '����(֧�ܷ�Χ:'+IntTostr(sup_st) +'-'+IntTostr(sup_ed)+')'+
                             '�ڡ�'+InttoStr(come_i)+'������ѹ������������ͨ��';
                   end else if OneStepIn.ModifyData =8 then  begin
                      t_str:='��'+Public_Basic.GetChineseNumber(phaseNumber)+'����(֧�ܷ�Χ:'+
                              '����(֧�ܷ�Χ:'+IntTostr(sup_st) +'-'+IntTostr(sup_ed)+')'+
                             '�ڡ�'+InttoStr(come_i)+'������ѹ�ֲ���ѹ�������Ե�ͨ��';
                   end else if (OneStepIn.ModifyData =5) or (OneStepIn.ModifyData =6) then  begin
                      t_str:='��'+Public_Basic.GetChineseNumber(phaseNumber)+'����(֧�ܷ�Χ:'+
                             '����(֧�ܷ�Χ:'+IntTostr(sup_st) +'-'+IntTostr(sup_ed)+')'+
                             '�ڡ�'+InttoStr(come_i)+'������ѹ�����쳣��ͨ��';
                   end else  if OneStepIn.ModifyData =30 then  begin
                      t_str:='��'+Public_Basic.GetChineseNumber(phaseNumber)+'����(֧�ܷ�Χ:'+
                              '����(֧�ܷ�Χ:'+IntTostr(sup_st) +'-'+IntTostr(sup_ed)+')'+
                             '�ڡ�'+InttoStr(come_i)+'����Ԥ�����������Ŀ�ѹ������������';
                   end else  if OneStepIn.ModifyData =27 then  begin
                      t_str:='��'+Public_Basic.GetChineseNumber(phaseNumber)+'����(֧�ܷ�Χ:'+
                             '����(֧�ܷ�Χ:'+IntTostr(sup_st) +'-'+IntTostr(sup_ed)+')'+
                             '�ڡ�'+InttoStr(come_i)+'����Ԥ�����������Ŀ�ѹ������������';
                   end;

             end else begin
                  if OneStepIn.ModifyData =10 then  begin
                      t_str:='�ڡ�'+InttoStr(come_i)+'������ѹ������������ͨ��';
                   end else if OneStepIn.ModifyData =9 then  begin
                      t_str:='�ڡ�'+InttoStr(come_i)+'������ѹ������������ͨ��';
                   end else if OneStepIn.ModifyData =8 then  begin
                      t_str:='�ڡ�'+InttoStr(come_i)+'������ѹ�ֲ���ѹ�������Ե�ͨ��';
                   end else if (OneStepIn.ModifyData =5) or (OneStepIn.ModifyData =6) then  begin
                      t_str:='�ڡ�'+InttoStr(come_i)+'������ѹ�����쳣��ͨ��';
                   end else  if OneStepIn.ModifyData =3 then  begin
                      t_str:='�ڡ�'+InttoStr(come_i)+'����Ԥ�����������Ŀ�ѹ������������';
                   end;
             end;

             SetFont('����',9,false,false) ; AlignLine(0); WriteText(t_str,0);
             insertRow(itab,0,1); inc( iRow);  Moveright(1);
             // ��һ��
             SetFont('����',9,true,false) ; AlignLine(0); WriteText('��ʼ��С����',0); Moveright(1);
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(IntTostr(OneStepIn.StartDao),0); Moveright(1);

             SetFont('����',9,true,false) ; AlignLine(0); WriteText('����������',0); Moveright(1);
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(IntTostr(OneStepIn.EndDao),0); Moveright(1);

             SetFont('����',9,true,false) ; AlignLine(0); WriteText('�����˶�����',0); Moveright(1);
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(formatFloat('0',OneStepIn.End_AGVDao-OneStepIn.Start_AGVDao),0); Moveright(1);
             SetFont('����',9,true,false) ; AlignLine(0); WriteText('��ʼ֧�ܱ��',0); Moveright(1);
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(IntTostr(OneStepIn.StartSup),0);
              //����һ��
             insertRow(itab,0,1); inc( iRow);  Moveright(1);
             SetFont('����',9,true,false) ; AlignLine(0); WriteText('��ʼ����(��)',0); Moveright(1);
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(formatFloat('0.00',OneStepIn.Start_AGVFootage),0); Moveright(1);

             SetFont('����',9,true,false) ; AlignLine(0); WriteText('��������(��)',0); Moveright(1);
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(formatFloat('0.00',OneStepIn.End_AGVFootage),0); Moveright(1);

             SetFont('����',9,true,false) ; AlignLine(0); WriteText('�����˶�����',0); Moveright(1);
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(formatFloat('0.00',OneStepIn.End_AGVFootage-OneStepIn.Start_AGVFootage),0); Moveright(1);

             SetFont('����',9,true,false) ; AlignLine(0); WriteText('����֧�ܱ��',0); Moveright(1);
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(IntTostr(OneStepIn.EndSup),0);
             //��һ��
             insertRow(itab,0,1);inc( iRow);Moveright(1);
             SetFont('����',9,true,false) ; AlignLine(0); WriteText('����ϵ��',0); Moveright(1);
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(formatFloat('0.00',OneStepIn.NormalQd),0); Moveright(1);

             SetFont('����',9,true,false) ; AlignLine(0); WriteText('��ֵϵ��',0); Moveright(1);
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(formatFloat('0.00',OneStepIn.AGVDataQD),0); Moveright(1);

             SetFont('����',9,true,false) ; AlignLine(0); WriteText('���ϵ��',0); Moveright(1);
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(formatFloat('0.00',OneStepIn.AreaQD),0); Moveright(1);

             SetFont('����',9,true,false) ; AlignLine(0); WriteText('�ۺ�ϵ��',0); Moveright(1);
             SetFont('����',9,false,false) ; AlignLine(1);
                WriteText(formatFloat('0.00',OneStepIn.WholeQD),0);
//             //��һ��

               if OneStepIn.FindNextStep   then  begin
              {���������һ����ѹԤ��}
                  insertRow(itab,0,1);inc( iRow);Moveright(1);
                  SetFont('����',9,true,false) ; AlignLine(0); WriteText('��һ�β���',0); Moveright(1);
                  SetFont('����',9,false,false) ; AlignLine(1);
                  WriteText(formatFloat('0.00',OneStepIn.Step_Move_AGV_Footage),0); Moveright(1);

                  SetFont('����',9,true,false) ; AlignLine(0); WriteText('�����˶�����',0); Moveright(1);
                  SetFont('����',9,false,false) ; AlignLine(1);
                  WriteText(formatFloat('0.00',OneStepIn.Step_Obvious_Footage[2]),0); Moveright(1);



                  SetFont('����',9,true,false) ; AlignLine(0); WriteText('�ȶ��˶�����',0); Moveright(1);
                  SetFont('����',9,false,false) ; AlignLine(1);
                  WriteText(formatFloat('0.00',OneStepIn.Step_Continue_Footage),0); Moveright(1);

                  Moveright(1);

              end;
              //��һ��
               R_Str:='';
               for N := 0 to OneStepIn.NextStepCount -1 do   begin
                   if N >0  then R_Str:= R_Str + #13#10 +'';
                   Ex_Stepid:=iDwGrap.Auto_Judge_OldStep.ReturnExStepidFromInn_Stepid(
                                    OneStepIn.NextStepClassID[N]);
                   if sup_st>0  then  begin
                      R_Str:= R_Str + '��['+IntTostr(N+1)+']����    ������Χ��'+
                          IntTostr(iDwGrap.Auto_Judge_OldStep.ExSteps[Ex_Stepid].OneStepInfo.StartDao)+ '-'+
                          IntTostr(iDwGrap.Auto_Judge_OldStep.ExSteps[Ex_Stepid].OneStepInfo.EndDao) +', ֧�ܷ�Χ��' +
                          IntTostr(max(iDwGrap.Auto_Judge_OldStep.ExSteps[Ex_Stepid].OneStepInfo.StartSup,sup_st))+ '-'+
                          IntTostr(Min(iDwGrap.Auto_Judge_OldStep.ExSteps[Ex_Stepid].OneStepInfo.EndSup,sup_ed))  ;
                   end else begin
                     R_Str:= R_Str + '��['+IntTostr(N+1)+']����    ������Χ��'+
                          IntTostr(iDwGrap.Auto_Judge_OldStep.ExSteps[Ex_Stepid].OneStepInfo.StartDao)+ '-'+
                          IntTostr(iDwGrap.Auto_Judge_OldStep.ExSteps[Ex_Stepid].OneStepInfo.EndDao) +', ֧�ܷ�Χ��' +
                          IntTostr(iDwGrap.Auto_Judge_OldStep.ExSteps[Ex_Stepid].OneStepInfo.StartSup)+ '-'+
                          IntTostr(iDwGrap.Auto_Judge_OldStep.ExSteps[Ex_Stepid].OneStepInfo.EndSup)  ;
                   end;
               end;

               if length(R_Str)> 0 then  begin
                  //��һ��
                  insertRow(itab,0,1);inc( iRow); Moveright(1);
                  TableCellMerge(itab,2,iRow,8,iRow);
                  SetFont('����',9,true,false) ; AlignLine(0); WriteText('������ѹ����',0); Moveright(1);
                  SetFont('����',9,false,false) ; AlignLine(0); WriteText(R_Str,0);

               end;

               if length(OneStepIn.SupportString) >0  then begin
                  insertRow(itab,0,1);inc( iRow); Moveright(1);
                  TableCellMerge(itab,1,iRow,2,iRow); TableCellMerge(itab,2,iRow,7,iRow);
                  SetFont('����',9,true,false) ; AlignLine(0); WriteText('��ѹ��������֧�ܱ��:',0); Moveright(1);
                  t_str:='';
                  R_Str:=OneStepIn.SupportString;
                  while length(R_Str) > 70 do   begin
                       t_str:= t_str+ copy(R_Str,1,70) +#13#10;
                       R_Str:=copy(R_Str,71,length(R_Str)-70);
                  end;
                  t_str:= t_str+ R_Str;
                  SetFont('����',9,false,false) ; AlignLine(0); WriteText(t_str,0);
               end;
     end;

end;

procedure TWordReport.Add_WorkFace_BasicInformation(inGzm: TGZM);
var
  str:string;
  Richedit1:Trichedit;
  fileName,textString:Ansistring;
  DirName:Ansistring;
  Dll_Path:AnsiString;

begin
   Dll_Path:=Public_Basic.Get_MyModulePath;
   DirName:=DLL_path+'\InputData\WorkDace_'+IntTostr(inGzm.Gzmbh)+'\';

  try
    Richedit1:=Trichedit.CreateParented(ExHandle);
    with innWord do begin
      AlignLine(0);
      SetFont('����',16,true,false);
      SetHeading(IntTostr(SencentId)+' ��������ʼ���������',1);// �½�
         SetFont('����',14,false,false);
         SetHeading(IntTostr(SencentId)+'.1 ��������ʼ���������',2);// �½�
         SetFont('����',12,false,false);
         SetHeading(IntTostr(SencentId)+'.1.1 ������ſ�������˵����',3);// �½�
         if MainDataModule.ReadRichTextFromDataBase(RichEdit1.Lines,'GZMBASIC','rtf',
                         inGzm.Gzmbh ,101,-1,-1) then begin
             RichEdit1.Lines.SaveToFile(DirName+'B001.rtf');
             AlignLine(1);
             SetFont('����',11,true,false);
             SetHeading('��1-1 ������زɵ���˵����',4);
             AlignLine(0);
             SetFont('����',11,false,false);
             insertotherfile(DirName+'B001.rtf');
         end else begin
              // ��д��������д�� ��ʽ
             ADDWorkFaceInFo_1(inGzm);
         end;
         //-----------------
         if ForceExit then   exit;
         public_Basic.WriteMakeWordPercent(true,31);
         //
         AddReturn();
         SetFont('����',12,false,false);
         SetHeading(IntTostr(SencentId)+'.1.2 ���װ��Ҳ����Է���',3);// �½�
         SetFont('����',12,false,false);
         if MainDataModule.ReadRichTextFromDataBase(RichEdit1.Lines,'GZMBASIC','rtf',
                         inGzm.Gzmbh ,102,-1,-1) then begin
            RichEdit1.Lines.SaveToFile(DirName+'B002.rtf');
            insertotherfile(DirName+'B002.rtf');
             //��������Ҳ����
            ADDDrilleInFo_2(inGzm);
         end else begin
            //��������Ҳ����
            ADDDrilleInFo_2(inGzm);
         end;
         //-----------------
         if ForceExit then   exit;
         public_Basic.WriteMakeWordPercent(true,32);
         //-----------------------
         SetFont('����',12,false,false);
         SetHeading(IntTostr(SencentId)+'.1.3 ���ʹ������',3);// �½�
         SetFont('����',10,false,false);
         if MainDataModule.ReadRichTextFromDataBase(RichEdit1.Lines,'GZMBASIC','rtf',
                         inGzm.Gzmbh ,103,-1,-1) then begin
            RichEdit1.Lines.SaveToFile(DirName+'B003.rtf');
            insertotherfile(DirName+'B003.rtf');
         end else begin
             SetFont('����',12,False,true);
             WriteText('��û��¼��ù�������ʹ��죬�뵽���ϲ�¼���油¼��',0);
         end;
         AddReturn();

       //-----------------
         if ForceExit then   exit;
         public_Basic.WriteMakeWordPercent(true,33);
       //-----------------------  // �ڶ���
      SetFont('����',14,false,false);
      SetHeading(IntTostr(SencentId)+'.2 ֧����Ϣ',2);// �½�
         SetFont('����',12,false,false);
         SetHeading(IntTostr(SencentId)+'.2.1 ����֧��',3);// �½�
         Add_Support_Information(inGzm);
         SetFont('����',12,false,false);
         if MainDataModule.ReadRichTextFromDataBase(RichEdit1.Lines,'GZMBASIC','rtf',
                         inGzm.Gzmbh ,201,-1,-1) then begin
            RichEdit1.Lines.SaveToFile(DirName+'B004.rtf');
            insertotherfile(DirName+'B004.rtf');
         end else begin
            SetFont('����',12,False,true);
            WriteText('��û��¼��ù���������֧�����뵽���ϲ�¼���油¼��',0);
         end;

         SetFont('����',12,false,false);
         AddReturn();
         SetHeading('1.2.2 ����֧��',3);// �½�
         SetFont('����',12,false,false);
         if MainDataModule.ReadRichTextFromDataBase(RichEdit1.Lines,'GZMBASIC','rtf',
                         inGzm.Gzmbh ,202,-1,-1) then begin
            RichEdit1.Lines.SaveToFile(DirName+'B005.rtf');
            insertotherfile(DirName+'B005.rtf');
         end else  begin
            SetFont('����',12,False,true);
            WriteText('��û��¼��ù���������֧�����뵽���ϲ�¼���油¼��',0);
         end;

         //-----------------
         if ForceExit then   exit;
         public_Basic.WriteMakeWordPercent(true,34);
         //-----------------------

         SetFont('����',12,false,false);
         AddReturn();
         SetHeading(IntTostr(SencentId)+'.2.3 ȷ��֧��ǿ��',3);// �½�
         SetFont('����',12,false,false);
         if MainDataModule.ReadRichTextFromDataBase(RichEdit1.Lines,'GZMBASIC','rtf',
                         inGzm.Gzmbh ,203,-1,-1) then begin
            RichEdit1.Lines.SaveToFile(DirName+'B006.rtf');
            insertotherfile(DirName+'B006.rtf');
         end else begin
           SetFont('����',12,False,true);
           WriteText('��û��¼��ù�����ȷ��֧��ǿ�ȣ��뵽���ϲ�¼���油¼��',0);
         end;
     end;
  finally
     FreeandNil(RichEdit1);
  end;
end;

procedure TWordReport.ChangePictureWidth(Path: string);
var
  in_imge,imag:Timage;
begin
    imag:=Timage.Create(nil);
    imag.Width :=1600;
    imag.Height :=880;
    in_imge:=Timage.Create(nil);
    try
       in_imge.Picture.LoadFromFile(Path);
       in_imge.Stretch:=true;

       imag.Canvas.StretchDraw(imag.ClientRect,in_imge.Picture.Graphic);
       imag.Picture.SaveToFile(Path);

    finally
       in_imge.Free;
       imag.Free;
    end;

end;

constructor TWordReport.Create;
begin
    CreateWordClass;
    // ����report������
    ReportInputData:=TDataFrequency.Create ;
    Subject_Str:=TStringList.Create ;
end;

procedure TWordReport.CreateWordClass;
begin
    if not Assigned(innWord) then
         innWord:= TMyWord.Create;



end;

procedure TWordReport.DeleteBmPFile;
var
 BmpPath:WideString;
begin
    BmpPath:=Public_Basic.Get_MyModulePath+'SaveBmp\FYYD\';
    if  DirectoryExists(BmpPath) then
        TDirectory.Delete(BmpPath, true);
    ForceDirectories(BmpPath);
end;

destructor TWordReport.Destroy;
begin
   FreeMyWordClass;
   if Assigned(ReportInputData) then
      FreeAndNil(ReportInputData);
   if Assigned(Subject_Str) then
      FreeAndNil(Subject_Str);
end;

procedure TWordReport.FreeMyWordClass();
begin
   try
     if Assigned(innWord) then FreeandNil(innWord);
   finally

   end;

end;

function TWordReport.Get_BottomWater(id: integer): String;
begin
  case id of
     1: Result:='�װ���ˮ';
     2: Result:='�װ���ˮԴ����Զ';
     3: Result:='�װ���ˮԴ���Ͻ�';
     4: Result:='�������װ�ͻ���¹�';
     else  Result:='����';
  end;
end;

function TWordReport.Get_Cmff(id: integer): String;
begin
    case id of
       1: Result:='�ڲ�';
       2: Result:='�ղ�';
       3: Result:='�۲�';
       else Result:='�Ŷ�ú';
    end;
end;

function TWordReport.Get_Coal_F(id: integer): String;
begin
   case id of
         1: Result:='����ϵ��0.8����';
         2: Result:='����ϵ��0.8-1.5֮��';
         3: Result:='����ϵ��1.5-2.5֮��';
         else Result:='����ϵ��2.5����';
   end;
end;

function TWordReport.Get_DZGZ(id: integer): String;
begin
   case id of
       1: Result:='���ʹ������';
       2: Result:='��б�Ჿ';
       3: Result:='��б�Ჿ';
       4: Result:='�ϲ��ܼ�������Ӱ���ƽ�';
       5: Result:='�ϲ��ܼ���Ӱ���ƽ�';
       6: Result:='���ʼ��临��';
   end;
end;

function TWordReport.Get_HangDao_Stress(id: integer): String;
begin
   case id  of
       1: Result:='������ˮƽӦ��';
       2: Result:='ˮƽӦ��С�ڴ�ֱӦ��';
       3: Result:='ˮƽӦ���봹ֱӦ���൱';
       else Result:='ˮƽӦ�����ڴ�ֱӦ��1.5������';
   end;
end;

function TWordReport.Get_HangDao_support(id: integer): String;
begin
   case id of
       1: Result:='�����������Ҫ֧��';
       2: Result:='�����Ҫ�򵥵�ê��֧��';
       3: Result:='�������֧��������������';
       4: Result:='������Σ��׹ģ�����С';
       else Result:='������ٱ��Σ��׹ģ�����Ӱ������';
   end;
end;

function TWordReport.Get_JYHD(id: integer): String;
begin
   case id of
     1: Result:='���Ҳ�ϱ�';
     2: Result:='���Ҳ�һ��';
     3: Result:='���Ҳ�Ϻ�';
     else Result:='���Ҳ�޺�';
   end;
end;

function TWordReport.Get_RockPress(id: integer): String;
begin
   case id of
       1: Result:='��ѹ���ֲ�����';
       2: Result:='�п�ѹ���֣���Ӱ������';
       3: Result:='��ѹ���ֽо��ң�Ӱ������';
       4: Result:='�����������¹�';
   end;
end;

function TWordReport.Get_support_type(id: integer): String;
begin
   case id of
      1: Result:='����֧��';
      2: Result:='�۲�Һѹ֧��';
   end;
end;

function TWordReport.Get_TopWater(id: integer): String;
begin
   case id of
     1: Result:='������ˮ';
     2: Result:='��ˮ����붥���Զ';
     3: Result:='��ˮ����붥��Ͻ�';
     4: Result:='������͸ˮ�¹�';
     else  Result:='����';

  end;
end;

function TWordReport.Get_WSFC(id: integer): String;
begin
  case id of
      1: Result:='��˹�����ϵ�';
      2: Result:='����˹�����ֲ�����';
      3: Result:='����˹';
  end;
end;

function TWordReport.Get_YxFx(id: integer): String;
begin
   case id of
      1: Result:='ˮƽ�ƽ�';
      2: Result:='��б�ƽ�';
      3: Result:='��б�ƽ�';
   end;
end;

procedure TWordReport.InsertPageSetupWater(path:string);
begin
   with innword do begin
       InsetWaterBmp(path+'BJTP\water.bmp',path+'BJTP\login.ico',30,85,105,70);
   end;
end;

function TWordReport.isExsitBmpFile(BmpFile: string): Boolean;
begin
    Result:=False;
    while not FileExists(BmpFile) do  sleep(100);
    Result:=true;

end;

procedure TWordReport.KillWord;
var
 ProcessID: Hwnd;
begin
   if gWaveHwnd<>0 then   begin
     //OpenProcess(PROCESS_ALL_ACCESS, False, ProcessID);
    TerminateProcess(gWaveHwnd,4);
   end;

end;

procedure TWordReport.ProDisposeFiveDataType;
var
  i,percent:integer;
  useDataType:TCycleData;
  pi:PTypeInfo;
begin
   useDataType:=iDwGrap.CloudClass.Yuntu_CycleData;
   pi:=  TypeInfo(TCycleData);
   percent:=2;
    for I := 0 to 5 do  begin
      if ForceExit then   exit;
      if i=2 then  continue; // ������ ����
      if (i=5) and (not MainDataModule.SelectRockPressDataNumber(5,iDwGrap.FGzm.Gzmbh)) then  continue;
      if i=ord(useDataType) then continue;

      iDwGrap.CloudClass.Yuntu_CycleData:=TCycleData(GetEnumValue(pi,GetEnumName(pi,i))) ;
      CreateRockPressTool(Application.Handle,'��ͼ��ʾ�������ý���',
                         Form_ContourGraph.Width ,Form_ContourGraph.Height,1);
      FormPressTool.RecallDataSet ;
      FormPressTool.Close ;
      Form_ContourGraph.But_Start_KYFX.Click ;
          // ������ʾ
      if Assigned(Form_ContourGraph) then
           Form_ContourGraph.setContourChartMin_MaxToBmp(
              iDwGrap.DataTimeAndFootAge.Graph_MaxDao-20,
              iDwGrap.DataTimeAndFootAge.Graph_MaxDao+80
              ) ;
        // �ٰ���ͼ ������
      if Assigned(Form_ContourGraph) then
           Form_ContourGraph.setContourChartMin_MaxToBmp(
              iDwGrap.DataTimeAndFootAge.Graph_MinDao,
              iDwGrap.DataTimeAndFootAge.Graph_MaxDao
              ) ;
       public_Basic.WriteMakeWordPercent(true,3+percent*i);
    end;
    // ��ͼ�η�����
    if ForceExit then   exit;
      iDwGrap.CloudClass.Yuntu_CycleData:=useDataType;
      CreateRockPressTool(Application.Handle,'��ͼ��ʾ�������ý���',
                         Form_ContourGraph.Width ,Form_ContourGraph.Height,1);
      FormPressTool.RecallDataSet ;
      FormPressTool.Close ;
      Form_ContourGraph.But_Start_KYFX.Click ;
        // ������ʾ
    if ForceExit then   exit;
    if Assigned(Form_ContourGraph) then
         Form_ContourGraph.setContourChartMin_MaxToBmp(
            iDwGrap.DataTimeAndFootAge.Graph_MaxDao-20,
            iDwGrap.DataTimeAndFootAge.Graph_MaxDao+80
            ) ;
      // �ٰ���ͼ ������
    if ForceExit then   exit;
    if Assigned(Form_ContourGraph) then
         Form_ContourGraph.setContourChartMin_MaxToBmp(
            iDwGrap.DataTimeAndFootAge.Graph_MinDao,
            iDwGrap.DataTimeAndFootAge.Graph_MaxDao
            ) ;
    public_Basic.WriteMakeWordPercent(true,15);
end;

function TWordReport.ReportAnsysisRockPress(AHandle: THandle; inGzm: TGZM;ExWord:Boolean):Boolean;
var
  i:integer;
  pic_path,SaveFile,tmp:string;
  HeadValue,FootValue1,FootValue2:string;
begin
     Result:=False;
  try
     ExHandle:=AHandle;
     Pic_Path:=Public_Basic.Get_MyModulePath;
     DeleteBmPFile; {ɾ���ļ���}
       {��ǰ���ã�Ϊ�ļ�����Ԥ��ʱ��}
      // ��ѹ�۲ⱨ��  ��ǰ��
     CreateWordClass();

     innWord.OpenWord('');
     if ExWord then   begin   // ������ⲿ����
        innWord.SetParentWindow(MainPanel);
        innWord.SetZoomPercentage(75);
     end;

      //
     iCallPStope.SetFyyd_Bmp(AHandle);//�Ѹ����˶�����ͼƬ�γ���
     iCallPStope.GetDTFZBmp(AHandle); // �Ѷ�̬����ͼƬ�γ���
     iCallPStope.GetZCYLBMP(AHandle); // ��֧��ѹ���ֲ�����ͼƬ�γ���
     SencentId:=0;   fuLu_Tu_id:=0;
     HeadValue:='    '+MainDataModule.Coal_Name+'ú��'+MainDataModule.WorkFace_Name+'�����桿��ѹ��ȷ�������';
     FootValue1:=  MainDataModule.Coal_Name+'ú�������ƿ�ѹ���������' ;
     FootValue2:=  'ɽ���Ƽ���ѧ������Ժʿ�����ŶӼ���';
     // ��ͼ�α�����
     public_Basic.WriteMakeWordPercent(true,2);
     ProDisposeFiveDataType;
     if ForceExit then   exit;

      with  innWord do begin
          //����ҳüҳ��  0 ��ͬ 1 ��ͬ
          SetHeadFootSame(1);//Ҳָҳüҳ�Ų�ͬ
          //��ƴд�������
          CloseCheckGrammar(False);
          // ����ҳ�߾�
          setpagemargin(25,20,25,20);
           // ���ӷ���
          Add_Kyfx_Cover(MainDataModule.Coal_Name,MainDataModule.WorkFace_Name);
           //����ժҪ
          insertPage(2);
          ADD_Abstric;
          insertPage(2);
         // ADD_Fuhaoshuming;// ���ӷ���˵��
            //������һҳ
          insertPage(2);
          //����Ŀ¼���
          createBookMark('mulu' );
          //-----
               // ����ˮӡ
          InsertPageSetupWater(Pic_Path);
          insertpageHead('Ŀ¼',HeadValue);
          insertpageFoot(FootValue1,FootValue2);

          // ����ҳ�� �������������
          insertPagenum(1);
          public_Basic.WriteMakeWordPercent(true,20);
          // ��������
          insertPage(2);
          createBookMark('zhengwen' );
          AddReturn();
          insertPagenum(1);
           // ���븽¼
          insertPage(2);
          createBookMark('fulu' );
          SetPageOrient(1);
          insertPagenum(0);
          ADD_Fulu;
          if ForceExit then   exit;
          Add_Fulu_TuFirstToFive; // �Ѹ�¼ǰ�������ͼ��������
          public_Basic.WriteMakeWordPercent(true,30);
          if ForceExit then   exit;
           // ������
//          insertPage(2);
//          createBookMark('houji' );
//          SetPageOrient(0);
//          insertPagenum(0);
//          ADd_HouJi;
//
//           �ҵ����Ĳ���
          GotoBookMark('zhengwen');
          if ForceExit then   exit;

          if iDwGrap.GraphClass.ReportFirst  then  begin
             inc(SencentId);
             Add_WorkFace_BasicInformation(inGzm);
             insertPage(0);
          end;
        public_Basic.WriteMakeWordPercent(true,35);

////         // ����ʵ�ÿ�ѹѹ���������� �ڶ���
          if ForceExit then   exit;
           if iDwGrap.GraphClass.ReportSecond  then  begin
                 inc(SencentId);
                 Add_FYYD_2(inGzm);
                 insertPage(0);
           end;
         public_Basic.WriteMakeWordPercent(true,45);

         // ��������� ͳ�����ݷ�����Ԫ
         inc(SencentId);
         if ForceExit then   exit;
         Add_Second_Secents(inGzm);
         insertPage(0);
         public_Basic.WriteMakeWordPercent(true,60);
//          ��������� ������������ݷ�����Ԫ
         inc(SencentId);
         if ForceExit then   exit;
         Add_Third_Secents(inGzm);
         insertPage(0);
         public_Basic.WriteMakeWordPercent(true,90);
          // ��������� ����
         inc(SencentId);
         if ForceExit then   exit;
         Add_fourth_Secents(inGzm);
         insertPage(0);
         public_Basic.WriteMakeWordPercent(true,95);
     end;

      //����Ŀ¼
     Add_Contents;
     //����Ϊ�ļ�
     tmp:=pic_path+'SaveBmp\KYJG\Report_' +Trim(IntTostr(inGzm.Gzmbh))+'_' +
                 FormatDateTime('yyyymmddHHNNSS',now());
     SaveFile:=tmp+'.Doc' ;
     public_Basic.WriteMakeWordPercent(true,98);
     innWord.Save(SaveFile) ;
     SaveFile:=tmp+'.mht' ;
     innWord.SaveAs(SaveFile) ;
     public_Basic.WriteMakeWordPercent(False,0);
  finally
     Result:=True;
  end;
     // �ͷ���
//     FreeMyWordClass;
end;

procedure TWordReport.ReportYklh(AHandle:THandle;inGzm:TGzm);
begin
       CreateWordClass();
       innWord.OpenWord('');
       DeleteBmPFile; {ɾ���ļ���}
       {��ǰ���ã�Ϊ�ļ�����Ԥ��ʱ��}
//       Main_CallPStope.UsePStope.GetFyydBmp(AHandle);
//       Main_CallPStope.UsePStope.GetDTFZBmp(AHandle);
       // ���ӱ���
       AddDocmentTitle(MainDataModule.Coal_Name,MainDataModule.WorkFace_Name,
                       'Yklh');
      //���ӹ�������Ϣ
       ADDWorkFaceInFo_1(inGzm);
       //������׻�����Ϣ
       ADDDrilleInFo_2(inGzm);
       //���Ӹ����˶�����
       AddFYYDInfo_3(inGzm,'Yklh');
       //���Ӳɶ�ģ�����
       AddYDFZInfo_4(inGzm);
       //����֧��ѡ��
       AddYklhInfo_5(inGzm);
       //����֧��ר�������
//       AddSupSubject_6(inGzm);
//       //�����Ѵ���Һѹ֧����Ϣ
//       AddExsitSupport_7(inGzm);
       //��������
       Add_disclaimer('��');
       FreeMyWordClass();
end;

procedure TWordReport.ReportZhijia(AHandle:THandle;inGzm:TGzm);
begin
       CreateWordClass();
       innWord.OpenWord('');
       DeleteBmPFile; {ɾ���ļ���}
       {��ǰ���ã�Ϊ�ļ�����Ԥ��ʱ��}
//       Main_CallPStope.UsePStope.GetFyydBmp(AHandle);
//       Main_CallPStope.UsePStope.GetDTFZBmp(AHandle);
       // ���ӱ���
       AddDocmentTitle(MainDataModule.Coal_Name,MainDataModule.WorkFace_Name,
                       'Support' );
      //���ӹ�������Ϣ
       ADDWorkFaceInFo_1(inGzm);
       //������׻�����Ϣ
       ADDDrilleInFo_2(inGzm);
       //���Ӹ����˶�����
       AddFYYDInfo_3(inGzm,'Support');
       //���Ӳɶ�ģ�����
       AddYDFZInfo_4(inGzm);
       //����֧��ѡ��
       AddSupportInfo_5(inGzm);
       //����֧��ר�������
       AddSupSubject_6(inGzm);
       //�����Ѵ���Һѹ֧����Ϣ
//       AddExsitSupport_7(inGzm);
       //��������
       Add_disclaimer('��');
       FreeMyWordClass();
end;

function TWordReport.Report_Zcyl(inGzm:TGzm): Boolean;
 var
   s_temp:Str_DT_array;
   C1:integer;
   S_out:Pansichar;
   Tab:Table;
begin
//*************
     S_out:= iCallPStope.Get_Zcyl('2.0',
           iDwGrap.DataTimeAndFootAge.DownEndFootage );
     s_temp:=Public_Basic.split(StrPas(S_out),';',C1);
     if C1> 4 then  begin
         {��Ӧ������ֵk1;��Ӧ����s0; ��Ӧ������ֵk2; ֧��ѹ����ֵ����ú�ھ���s1; ��Ӧ����Χsx; }
         with innWord do begin
             SetFont('����',11,true,false);AlignLine(1);
             SetHeading('��'+IntTostr(SencentId)+'-1'+'��'+MainDataModule.WorkFace_Name+'�����桿֧��ѹ���ֲ����������',4);
             SetFont('����',11,false,false) ;
             Tab:=AddTable(2,6);
             setTableColumsWidth(Tab,1,60);
             setTableColumsWidth(Tab,2,60);
             AlignLine(1);
             SetFont('����',11,true,false) ;
             WriteText('��Ŀ����',0);
             Moveright(1);AlignLine(1); SetFont('����',11,true,false) ;
             WriteText('��ֵ',0);

             SetFont('����',11,False,false) ;
             Moveright(1);  AlignLine(0);
             WriteText('��Ӧ������Χ���ף�',0);
             Moveright(1);AlignLine(1);
             WriteText(s_temp[1],0);

             Moveright(1);  AlignLine(0);
             WriteText('��Ӧ����Ӧ������ϵ��',0);
             Moveright(1);AlignLine(1);
             WriteText(s_temp[0],0);

             Moveright(1);  AlignLine(0);
             WriteText('��Ӧ������Χ���ף�',0);
             Moveright(1);AlignLine(1);
             WriteText(s_temp[4],0);

             Moveright(1);  AlignLine(0);
             WriteText('��Ӧ����Ӧ������ϵ��',0);
             Moveright(1);AlignLine(1);
             WriteText(s_temp[2],0);

             Moveright(1);  AlignLine(0);
             WriteText('ѹ����ֵ��ú�ھ��루�ף�',0);
             Moveright(1);AlignLine(1);
             WriteText(s_temp[3],0);
             MoveDown(1);

         end;

     end;
end;

procedure TWordReport.ReSize;
begin
  try
      if Assigned(innWord) then
         innWord.Resize(MAinPanel);
  finally

  end;
end;

function TWordReport.ReturnDataTypeName(Value: integer): String;
begin
    if Value=0 then  begin
        Result:='���ֵ'
    end else  if Value=1 then  begin
        Result:='ƽ��ֵ' ;
    end else  if Value=2 then  begin
        Result:='������' ;
    end else  if Value=3 then  begin
        Result:='ĩ����' ;
    end else  if Value=4 then  begin
        Result:='˲��ֵ' ;
    end else  if Value=5 then  begin
        Result:='�ֶ�¼��ֵ' ;
    end;

end;

function TWordReport.ReturnFileName(FileType: String; L_Min, L_Max,
  DataType,lx: integer): String;
{
   FileType ���� ͼƬ�ļ� �ı�� YT LN  Bar
   L_Min  >= 0 ����   ��С����
   L_Max  >=0 ���� ������
   lx  ����ͼƬ �������� 0 1 2
}
var
  SearchRec: TSearchRec;
  found: integer;
  DirName:Ansistring;
  Dll_Path:AnsiString;
  s1,stemp:Str_DT_array;
  C1:integer;
begin
   Dll_Path:=Public_Basic.Get_MyModulePath;
   DirName:=DLL_path+'SaveBmp\KYFX\'+IntTostr(iDwGrap.FGzm.Gzmbh);
   Result:='';
  found := FindFirst(DirName + '\' + '*.bmp', faAnyFile, SearchRec);
  while found = 0 do   begin
    if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') and
      (SearchRec.Attr <> faDirectory) then  begin
        s1:=Public_Basic.split(SearchRec.Name,'.',C1);
        if C1>=1 then  begin
          stemp:=Public_Basic.split(S1[0],'_',C1);
          if C1>=1 then
            if Uppercase(stemp[0])=Uppercase(FileType) then
               if (L_Min >=0 ) and (C1>=2) and (stemp[1]= intTostr(L_Min) )   then
                   if  (L_Max >=0 ) and (C1>=3) and (stemp[2]= intTostr(L_Max) )   then   begin
                       { ���� YT ���ļ�}
                        if (lx>=0) and (C1>=4) and (stemp[3]= intTostr(DataType) ) and (stemp[4]= intTostr(lx) ) then begin
                            Result:=DirName+'\'+SearchRec.Name;
                            break;
                        end;
                   end else begin
                      {����Bar �ļ�}
                      Result:=DirName+'\'+SearchRec.Name;
                      break;
                   end;
        end;
      end;

      found := FindNext(SearchRec);
  end;

  FindClose(SearchRec);

end;

function TWordReport.ReturnTimeToChinese(dt: TdateTime): String;
var
  YYYY,MM,DD,i,Qt,tm:integer;
  St:String;
begin
   YYYY:=Public_Basic.StrToInt_lu(FormatDateTime('YYYY',dt));
   st:='';  Qt:=1000;
   for I := 4 downto 1 do  begin
     tm:=YYYY div Qt;
     YYYY:= YYYY mod Qt;
     St:=St+ public_Basic.GetChineseNumber(tm);
     Qt:=Qt div 10;
   end;
   St:=St+ '��';

   MM:=Public_Basic.StrToInt_lu(FormatDateTime('MM',dt));
   St:=St+public_Basic.GetChineseNumber(mm) +'��';

   DD:=Public_Basic.StrToInt_lu(FormatDateTime('DD',dt));

   tm:=DD div 10;
     if tm>0 then
        St:=St+ public_Basic.GetChineseNumber(tm);
   DD:= DD mod 10;
   St:=St+ public_Basic.GetChineseNumber(DD) +'��';
   Result:=st;
end;


procedure TWordReport.SetDrawGraph(iDw:TDrawGrap;iCallP:TDefine_CallPStope);
begin
   iDwGrap:=iDw;
   iCallPStope:=iCallP;
end;

procedure TWordReport.SetReportExit(Value: Boolean);
begin
    ForceExit:=Value;
end;

procedure TWordReport.SetWordPanel(iPanel: TPanel);
begin
   MainPanel:=iPanel;
end;

end.