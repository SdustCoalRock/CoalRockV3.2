unit ReportWord;

interface
uses
  System.SysUtils,Vcl.ExtCtrls,
  unWord_Lu,PStope_GzmGuidClass;

type
    TWordReport = class(TMyWord)

    private

        innWord:TMyWord;
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
        procedure AddExsitSupport_7(inGzm:TGzm);
        //------------------
        procedure AddYklhInfo_5(inGzm:TGzm);
        procedure AddYklhInfo_5_2;

        procedure Add_disclaimer(Xhstr:String);

       //
        procedure DeleteBmPFile;
        function  isExsitBmpFile(BmpFile:string):Boolean;
        function  Report_Zcyl(inGzm:TGzm):Boolean;
    public
        procedure ReportZhijia(AHandle:THandle;inGzm:TGzm); //��ӡ֧�ܱ���
        procedure ReportYklh(AHandle:THandle;inGzm:TGzm);//  ��ӡ�ؿ�����
        function  ReportDrillInfoToWordFile(inGzm:TGzm):String;

         constructor Create;
         destructor  Destroy;

    end;


implementation

{ TWordReport }

uses UMainDataModule, MainCallUnit, Lu_Public_BasicModual,IOUtils,
  SupportWeightClass;
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
begin
     with innWord do begin
          AddReturn();   //��һ������
          SetFont('����',15,false,false);
          AlignLine(1);
          SetHeading('���������Ϣ',2);// �½�
          AddReturn();
           //����
          SetFont('����',13,false,false);
          AlignLine(0);
          WriteText('    �ôβ���ʹ�õ��������Ϊ��'+inGzm.UsedDrill.Zk_name +
                    '�������¼���Ҳ㣺'+IntToStr(inGzm.UsedDrill.Zk_Yc_Count)+'�㡣'+#13,0);

          AlignLine(1);
          SetFont('����',10,true,false);
          AddTable(6,inGzm.UsedDrill.Zk_Yc_Count);
          WriteText('�Ҳ����',0);   MoveRight(1);
          WriteText('�Ҳ�����',0);   MoveRight(1);
          WriteText('����(��)',0);   MoveRight(1);
          WriteText('��ʯ����',0);   MoveRight(1);
          WriteText('��ѹMPa',0);    MoveRight(1);
          WriteText('����MPa',0);    MoveRight(1);

          SetFont('����',10,false,false);
          for I := 0 to inGzm.UsedDrill.Zk_Yc_Count-1 do   begin
              WriteText(inttoStr(i+1),0);                       MoveRight(1);
              WriteText(inGzm.UsedDrill.Yc_Rock[i].R_Name,0);   MoveRight(1);
              WriteText(FormatFloat('#.##',inGzm.UsedDrill.Yc_Rock[i].R_h),0);      MoveRight(1);
              WriteText(FormatFloat('#.##',inGzm.UsedDrill.Yc_Rock[i].R_r),0);      MoveRight(1);
              WriteText(FormatFloat('#.##',inGzm.UsedDrill.Yc_Rock[i].R_kyqd),0);   MoveRight(1);
              WriteText(FormatFloat('#.##',inGzm.UsedDrill.Yc_Rock[i].R_klqd),0);   MoveRight(1);
          end;
          MoveDown(inGzm.UsedDrill.Zk_Yc_Count);

     end;
end;

procedure TWordReport.AddExsitSupport_7(inGzm:TGzm);
var
  Sout,t_sql:String;
  s_temp:Str_DT_array;
  C1:integer;
  max_P,min_P:double;
begin
//*************
    with innWord do begin
          AlignLine(0);
          AddReturn();   //��һ������
          SetFont('����',15,false,false);
          SetHeading('�ߡ�֧��ѡ��',2);// �½�
          AddReturn();
           //����
          SetFont('����',13,false,false);
          SetFont('����',13,false,false);

          Sout:=StrPas(Main_CallPStope.UsePStope.Get_Support_P('3.0'));
          s_temp:=Public_Basic.split(Sout,',',C1);
          if C1>1 then begin
             max_P:=Public_Basic.StrToDouble_Lu(s_temp[0]) ;
             min_P:=Public_Basic.StrToDouble_Lu(s_temp[1]) ;
          end;
         t_sql:='select bh,Tu_bh,ZJ_Type from MapBh where Zj_P>='''+
               floattostr(min_P)+''' and Zj_P<='''+floattostr(max_P)+''' and Zj_h_min <'''+
               floattostr(inGzm.S_Cg_h-0.5)+''' and Zj_h_max > '''+floattostr(inGzm.S_Cg_h+0.2)+'''';
         AlignLine(0) ;
         MainDataModule.MyDataSet.Close ;
         MainDataModule.MyDataSet.CommandText :=t_sql;
         C1:=1;
         try
             MainDataModule.MyDataSet.Open ;
             if MainDataModule.MyDataSet.RecordCount >0 then begin
                WriteText('�������Ƶ�Һѹ֧�ܣ�',0); AddReturn();
                while not MainDataModule.MyDataSet.Eof  do begin
                   WriteText( '�ڡ�'+intToStr(C1)+'��֧��    '+
                             MainDataModule.MyDataSet.FieldByName('Tu_bh').AsString +'  ' +
                             MainDataModule.MyDataSet.FieldByName('ZJ_Type').AsString,0 );
                    AddReturn();
                   MainDataModule.MyDataSet.Next ;
                end;
             end else begin
                WriteText('���ݿ��в��������Ƶ�Һѹ֧�ܣ�',0); AddReturn();
             end;
         finally
            MainDataModule.MyDataSet.Close ;
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
             AddPicture(Pic_Path+'NQF.JPG',0);
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
          WriteText('   ֱ�Ӷ��˶�������'+StrPas(Main_CallPStope.UsePStope.Get_immediate_roof('1.0')),0);
          AddReturn();
          WriteText('   �϶��˶�������'+StrPas(Main_CallPStope.UsePStope.Get_Old_roof('1.0')),0);
          AddReturn();
          {Ϊ�ؿ����ﶨ��}
          if ReportType='Yklh' then begin
              SetFont('����',13,false,false);
              SetHeading('3����ѹ���ֲ�����',3);
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
   Pic_Path:=Public_Basic.Get_MyModulePath+'saveBmp\FYYD\';
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
             selectedid:= t_SupWeigth.WorkFaceInfo.Child_Second[i].selected ;
             WriteText(t_SupWeigth.WorkFaceInfo.Child_Second[i].Child_Third[selectedid].Name ,0);
             if i<7 then   MoveRight(1);

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
          WriteText(StrPas(Main_CallPStope.UsePStope.Get_Support_P('1.0')),0);

          AddReturn();

          AlignLine(0);
          SetFont('����',13,false,false);
          SetHeading('3��֧�����ר�ҽ���ṹѡ��',3);

          AddReturn();
          SetFont('����',10,true,false);
          AddTable(1,1);
          for I := 0 to t_SupWeigth.SupportInfo.Child_count-1 do  begin
            selectedid:=t_SupWeigth.SupportInfo.Child_Second[i].Selected;
            MainDataModule.MySqliteDataBase.GetBMPToSQlite(
                t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[selectedid].id,'3',Image1.Picture.Bitmap  );
             Image1.Width :=Image1.Picture.Bitmap.Width ;
             Image1.Height :=Image1.Picture.Bitmap.Height ;

             if Public_Basic.Licensing  then  Public_Basic.AddSingleTextWaterFormImage(Image1)
               else Public_Basic.AddMultTextWaterFormImage(Image1);

            Image1.Picture.SaveToFile(Pic_Path+'Supp.bmp');
            AlignLine(0);
            DispStr:=IntToStr(i+1)+'��'+t_SupWeigth.SupportInfo.Child_Second[i].Name+
                     ' ѡ��: '+ t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[selectedid].BianMa+'��'+
                      t_SupWeigth.SupportInfo.Child_Second[i].Child_Third[selectedid].Name   +'��' ;
            WriteText(DispStr,0);  MoveRight(1);
            AlignLine(1);
            if self.isExsitBmpFile(Pic_Path+'Supp.bmp') then
               AddPicture(Pic_Path+'Supp.bmp',1);
            if i< t_SupWeigth.SupportInfo.Child_count-1 then
               MoveRight(1);

          end;
          MoveDown(1);

    end;
   finally
      Image1.Free;
   end;
end;

procedure TWordReport.AddSupSubject_6(inGzm: TGzm);
var
 i:integer;
begin
     with innWord do begin
          AlignLine(0);
          MoveDown(1);
          AddReturn();   //��һ������
          SetFont('����',15,false,false);
          SetHeading('����ע������',2);// �½�
          AddReturn();
           //����

          SetFont('����',13,false,false);
          for I := 0 to t_SupSubject.Data_Count-1 do  begin
             WriteText('    '+t_SupSubject.DataClass[i],0);
             AddReturn();
          end;

     end;
end;

procedure TWordReport.ADDWorkFaceInFo_1(inGzm: TGzm);
var
  str:string;
begin
  with innWord do begin
      AlignLine(0);
      AddReturn();   //��һ������
      SetFont('����',14,false,false);
      SetHeading('һ�������������Ϣ',2);// �½�
      AddReturn();
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
          SetHeading('�ġ��ɳ����ɸ����˶�ģ��',2);// �½�
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
  Image1:TImage;
  Pic_Path,DispStr:string;
begin
   Image1 := TImage.Create(nil);
   Pic_Path:=Public_Basic.Get_MyModulePath+'saveBmp\FYYD\';
   try
    with innWord do begin
          AlignLine(0);
          AddReturn();   //��һ������
          SetFont('����',15,false,false);
          SetHeading('�塢�ؿ���������Է�������',2);// �½�
          AddReturn();
           //����
          SetFont('����',13,false,false);
          SetHeading('1�������涥��ֲ���Ϣ',2);
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
             selectedid:= t_SupWeigth.WorkFaceInfo.Child_Second[i].selected ;
             WriteText(t_SupWeigth.WorkFaceInfo.Child_Second[i].Child_Third[selectedid].Name ,0);
             if i<7 then   MoveRight(1);

          end;

          MoveDown(1);

          AddReturn();
        // ����5.2 ��������
         AddYklhInfo_5_2;



    end;
   finally
      Image1.Free;
   end;

end;

procedure TWordReport.AddYklhInfo_5_2;
begin
    with innWord do begin
          AlignLine(0);
          SetFont('����',13,false,false);
          SetHeading('2���ؿ���������Է�������',3);
          AddReturn();
          AlignLine(0);
          SetFont('����',13,false,false);
          WriteText(Main_CallPStope.UsePStope.Get_kcjstj('2.0') ,0);
            AddReturn();
          SetFont('����',13,false,false);
          SetHeading('3���ؿ��������ǽ����Ҫ����',3);
            AddReturn();
          AlignLine(0);
          SetFont('����',13,false,false);
          WriteText(Main_CallPStope.Return_Yklh_SupportParam('1.0'),0 );
            AddReturn();
          SetFont('����',13,false,false);
          SetHeading('4���������֧������',3);
            AddReturn();
          SetFont('����',13,false,false);
          WriteText(Main_CallPStope.Return_Yklh_HangDao_Zhihu_Support('1.0'),0 );
            AddReturn();
          SetFont('����',13,false,false);
          SetHeading('5������Ч������',3);
            AddReturn();
          SetFont('����',13,false,false);
          WriteText(Main_CallPStope.Return_Yklh_Jinjixiaoyi('1.0'),0 );
            AddReturn();
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

constructor TWordReport.Create;
begin
    CreateWordClass;
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
end;

procedure TWordReport.FreeMyWordClass();
begin
     if Assigned(innWord) then  FreeAndNil(innWord);

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

function TWordReport.isExsitBmpFile(BmpFile: string): Boolean;
begin
    Result:=False;
    while not FileExists(BmpFile) do  sleep(100);
    Result:=true;

end;

function TWordReport.ReportDrillInfoToWordFile(inGzm: TGzm): String;
var
  str:string;
  fileName,textString:Ansistring;
  DirName:Ansistring;
  Dll_Path:AnsiString;
  i:integer;
begin
   Result:='';
   //
   CreateWordClass();
   innWord.OpenWord('');
   //
   Dll_Path:=Public_Basic.Get_MyModulePath;
   DirName:=DLL_path+'\InputData\WorkDace_'+IntTostr(inGzm.Gzmbh)+'\D000.rtf';
    with innWord do begin
           //����
        if inGzm.UsedDrill.Zk_Yc_Count> 0 then begin
            SetFont('����',12,false,false);
            AlignLine(0);
            WriteText('    �ôβ���ʹ�õ��������Ϊ��'+inGzm.UsedDrill.Zk_name +
                      '�������¼���Ҳ㣺'+IntToStr(inGzm.UsedDrill.Zk_Yc_Count)+'�㡣'+#13 ,0);

            AlignLine(1);
            SetFont('����',8,true,false);
            WriteText('��1-2 ����Ҳ���Ϣ��',0);
            AddReturn();
            SetFont('����',10,False,false);
            AddTable(6,inGzm.UsedDrill.Zk_Yc_Count);
            WriteText('�Ҳ����',0);   MoveRight(1);
            WriteText('�Ҳ�����',0);   MoveRight(1);
            WriteText('����(��)',0);   MoveRight(1);
            WriteText('��ʯ����',0);   MoveRight(1);
            WriteText('��ѹMPa',0);    MoveRight(1);
            WriteText('����MPa',0);    MoveRight(1);

            SetFont('����',12,false,false);
            for I := 0 to inGzm.UsedDrill.Zk_Yc_Count-1 do   begin
                WriteText(inttoStr(i+1),0);                       MoveRight(1);
                WriteText(inGzm.UsedDrill.Yc_Rock[i].R_Name,0);   MoveRight(1);
                WriteText(FormatFloat('#.##',inGzm.UsedDrill.Yc_Rock[i].R_h),0);      MoveRight(1);
                WriteText(FormatFloat('#.##',inGzm.UsedDrill.Yc_Rock[i].R_r),0);      MoveRight(1);
                WriteText(FormatFloat('#.##',inGzm.UsedDrill.Yc_Rock[i].R_kyqd),0);   MoveRight(1);
                WriteText(FormatFloat('#.##',inGzm.UsedDrill.Yc_Rock[i].R_klqd),0);   MoveRight(1);
            end;

            MoveDown(inGzm.UsedDrill.Zk_Yc_Count);
            Save(DirName);
            //close;
            Result:=DirName;
        end;

     end;

    FreeMyWordClass;
end;

procedure TWordReport.ReportYklh(AHandle:THandle;inGzm:TGzm);
begin
       CreateWordClass();
       innWord.OpenWord('');
       DeleteBmPFile; {ɾ���ļ���}
       {��ǰ���ã�Ϊ�ļ�����Ԥ��ʱ��}
       Main_CallPStope.UsePStope.GetFyydBmp(AHandle);
       Main_CallPStope.UsePStope.GetDTFZBmp(AHandle);
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
       Main_CallPStope.UsePStope.GetFyydBmp(AHandle);
       Main_CallPStope.UsePStope.GetDTFZBmp(AHandle);
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
       AddExsitSupport_7(inGzm);
       //��������
       Add_disclaimer('��');
       FreeMyWordClass();
end;

function TWordReport.Report_Zcyl(inGzm:TGzm): Boolean;
 var
   s_temp:Str_DT_array;
   C1:integer;
begin
//*************
     s_temp:=Public_Basic.split(Main_CallPStope.UsePStope.Get_Zcyl('2.0',inGzm.S_Jc_L),';',C1);
     if C1> 4 then  begin
         {��Ӧ������ֵk1;��Ӧ����s0; ��Ӧ������ֵk2; ֧��ѹ����ֵ����ú�ھ���s1; ��Ӧ����Χsx; }
         with innWord do begin
             WriteText('    ��Ӧ������ֵ'+s_temp[0],0);
                AddReturn();
             WriteText('    ��Ӧ����'+s_temp[1]+'��',0);
                 AddReturn();
             WriteText('    ��Ӧ������ֵ'+s_temp[2],0);
                 AddReturn();
             WriteText('    ֧��ѹ����ֵ����ú�ھ���'+s_temp[3]+'��',0);
                  AddReturn();
             WriteText('    ��Ӧ����Χ'+s_temp[4]+'��',0) ;
                 AddReturn();
         end;

     end;
end;

end.