//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//<<      �ļ�����GzmClass.pas                          <<
//<<      luleiʹ�õĸ���Delphi�ļ�                            <<
//<<      ���ļ���Ҫ����Ϊ��ѹ���ݷ���ʹ��                     <<
//<<      �������ڣ�2016.5.12                                   <<
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<




unit PStope_GzmGuidClass;

interface

uses
  Windows, SysUtils, Classes, Messages, Controls, Forms, StdCtrls, ExtCtrls,
  ComCtrls,math,IniFiles,Jpeg,Graphics,Dialogs,RockPressBasicClass,
  UMainDataModule,StrUtils,NativeXml, TypInfo,Vcl.Grids;
  //SQLiteTable3

  type

  TGzmLocation =(nLeft,nRight,nFront,nbehind,nTop,nBottom);  //����ǰ������
  TGeostruct  =(nfault,nMineOutarea,nCoalpillar);    //�ϲ�   �ɿ���  ú��
  TSupportDataType =(NullPressData,FrontPressData,BehindPressData,LeftPressData,RightPressData,
                     FrontDisp,BehindDisp,LeftDisp,RightDisp,TheWallPressData,TheDrillPress,UsedData);


// ���弸�����ݽṹ�����ڴ洢Xml���������
  TRockPressAnalysis =record
     Oneday_daoshu:integer;  // ÿ�������
     TwoDao_IntervalTime:integer; //�������ʱ��
     OneDao_step:double;      //ÿ��������
     ManulInput_Interval_support:integer; //�ֶ�¼��֧�ܼ��
     AnalysisSenstive:integer;  // ��ѹ����������
     Continue_SupNumber:integer; // ֧�ܳ�������
     conTinue_DaoNumber:integer;   // ��ѹ���� ����
     Min_Pt:double;//������ѹ����Сѹǿ
     ColorString:String;  //�����õ���ɫ�嵥
     StepGroundFilled:integer;//������ͼ��䷽ʽ
     StepFillIsTran:integer; //�Ƿ�͸�����  0 ͸�� 1 ��͸��
     StepFillLineWide:integer; //�����������
     StepFillColor:TColor;//��ѹ���������ɫ
     SetpFillTran:Integer;//��ѹ�������͸����
     SelectedFillColor:TColor;//ѡ������������ɫ
     OldStepPhaseString:String;//��������� ���ַ���
     JudgeMInQD:double;//�ж���ѹ����Сǿ��
     NearColorLineUp_DownValue:double;// ��ɫ�ж��Ĳ�ֵ
     NearTwoStepDaoValue:double;//���ڲ�����ж�ֵ
     NearTwoStepAGvData_BS:double; //���ڲ���ľ�ֵϵ��
     Jindao_DataType:integer;// ���ݲɼ�����   0 ���������ɼ� 1 ���ݶ�ʱ�ɼ�
     JinDao_Basic:integer; // 0 ��ͷ 1 �м� 2 ��β
     JinDao_Support:Integer;// �����жϵ�����֧�ܱ��
     JinDao_Time:Integer;//0 ĩ����ʱ�� 1 ������ʱ�� 2 ���ֵʱ��
  end;
  PWorkFace =^TWorkFacePD;
  TWorkFacePD= packed record
      Minename:string;
      WorkFaceName:string;   //2
      CoalSeamName:string;    //3
      CoalMiningHeigth:double; //4
      CoalMiningMethod:string;  //5
      CoalseamAngle:double;  //7
      AVGBuriedDepth:double;  //11
      WorkFaceLength:double;  //12
      TowardDistance:double;   //13
      Coalhardness:double;   //14
      SupStartNumber:integer;  //29
      supEndNumber:Integer;    //30
      SupDirection:integer;    //31
      TransportRoadwayFirstDrillPressLocation:double;
      TransportRoadwaySecondDrillPressLocation:double;
      PathwayRoadWayFirstDrillPressLocation:double;
      PathwayRoadWaySecondDrillPressLocation:double;

  end;



 //����ϲ������
 TFault =class
    Name        :string;    //   �ϲ������
    Mineid      :integer;  // ��id
    faulttype   :integer;    //  �ϲ������  1 ���ϲ� 2 ��ϲ�
    divide      :double;     //  �ϲ�����
    MinToOffCut :double;     //  �ϲ���뿪�����������
    MaxToOffCut :double;     //  �ϲ���뿪����������
    location    :TGzmLocation;// �ϲ��뿪���۵�λ�÷�ʽ
    safedistance:double;      //Ԥ���İ�ȫ����
    gzmbh:integer;//��������   2016-6-12

    function  forcase(FaultNumber:integer;jinChi:double;t_Gzm:TG_Stope;
               uOldComePress:Boolean;var ChildRoot:TXmlNode):Boolean;

 end;
 //����ɿ�����
  TMineOutArea =class
    Name        :string;    //   �ɿ���������
    Mineid      :  integer;  // ��id
    Gzmid       : integer;   // ������id
    location    :TGzmLocation;// �ɿ����뿪���۵�λ�÷�ʽ
    Outtime     : TdateTime;    //  ����ʱ��
    width      :double;     //  �������Ŀ���
    length :double;     //  �ɿ�������
    heigth :double;     //  �ɿ������ɸ߶�
    dis_left,dis_right,dis_front,dis_behind,dis_top,dis_bottom :double; //�òɿ�������ù���������λ�ã���Щֵ����Ϊ��
    safedistance:double;      //Ԥ���İ�ȫ����

    function  forcase(ArraOutNumber:integer;jinChi:double;t_Gzm:TG_Stope;
               uOldComePress:Boolean;var ChildRoot:TXmlNode):Boolean;
 end;

 //����ú����
  TCoalPillar =class
    Mineid      :  integer;  // ��id
    Name        :string;    //   ú��������
    location    :TGzmLocation;// ú���뿪���۵�λ�÷�ʽ
    width      :double;     //  ú���Ŀ���
    length :double;     //  ú������
    heigth :double;     //  ú�����ɸ߶�
    dis_left,dis_right,dis_front,dis_behind,dis_top,dis_bottom :double; //��ú������ù���������λ�ã���Щֵ����Ϊ��
    safedistance:double;      //Ԥ���İ�ȫ����
    gzmidbh:integer;//��������   2016-6-12

    function  forcase(CoalPillarNumber:integer;jinChi:double;t_Gzm:TG_Stope;
               uOldComePress:Boolean;var ChildRoot:TXmlNode):Boolean;
 end;
 //�����깤������������λ�ù�ϵ
 TWorkFaceBuillDrill=class
    NO             :integer; //��ʼ˳��
    Zkid           :integer; // ��ױ��
    Gzmid          :integer; //��������
    startdistance  :double;  // ��ʼ����
    enddistance    :double;  //  ��������

 end;
 //�����깤������������λ�ù�ϵ
 TWorkFaceBuillSupport=class(TSupportStep)
    NO              :integer; //��ʼ˳��
    Supportid       :integer; // ֧�ܱ��
    startsupportNo  :integer;  // ��ʼ֧�ܱ��
    endsupportNo    :integer;  //  ����֧�ܱ��
 end;



  TGzmBasic =class(TG_stope)
       S_Agv_mch:double;//  ú�����
        //
       //
       Old_Step:array  [0..3] of double;//������������ѹ���࣬0 ���  1 ��С 2 ƽ��
       imm_MPa:double;  // ֱ�Ӷ��γɵĵ�MPaֵ
       Old_MPa:array  [0..3] of double; //  �϶��γɵ�MPaֵ  0 ���  1 ��С 2 ����

        //��������

        MyExConn:TMySqlConnection;
   end;

  TGzm = class(TGzmBasic)
      KuangJingId  :integer;       //�󾮱��
      Gzmbh        :integer ;         //  ��������
      used         :integer;         //  ʹ��״̬  0 δʹ��  1 ����ʹ�� 2 �Ѿ�ͣ�ɣ������Ѿ�����
      cFault       :integer;         //   �ܱ߶ϲ����Ŀ
      cMineOutArea :integer;        //    �ܱ߲ɿ�����Ŀ
      cCoalPillar  :integer;        //    �ܱ�ú����Ŀ
      FootStepParameters:String; //�洢��������߲��� �ö��Ÿ��� ���������������ʱ�䣬��������
      RockPressAnalysisParameters:String; //�洢�������ѹ�������õ���Ҫ����
      RockPressAnalysis:TRockPressAnalysis ;// ��ѹ������Ҫ����
      ColorString:String;// �����ɫ�ַ���

      Fault  :array of TFault;     //      ��̬���� ��¼ �ܱ߶ϲ���Ϣ
      MineOutArea :array of TMineOutArea; // ��̬���� ��¼ �ܱ߲ɿ�����Ϣ
      CoalPillar  :array of TCoalPillar;  // ��̬���� ��¼ �ܱ�ú����Ϣ
      FirstValueType: TSupportDataType;  //   ��һ����������
      SecondValueType:  TSupportDataType;  //  �ڶ�����������
      ThirdValueType:  TSupportDataType;  //   ��������������
      FouthValueType:  TSupportDataType;  //   ���ĸ���������
      SupStartNumber: integer;//֧�ܿ�ʼ���
      SupEndNumber:integer;  //֧����ֹ���
      SupEndUsedNumber:integer; //
      RecArryNumber:integer;// �����������Ϣ
      dRecArry:array [0..8,0..2] of Integer; // ��ע����֧���±�
      SupNumberDirection:integer;// ֧�ܱ�ŵķ��� ����to ��� Ϊ 0�� ���to ���� Ϊ1
      IsUesedsupFieldName: array [0..15] of string; //���õ��ֶ�����
      IsUesedsupFieldcount:integer; //  ���õ��ֶ���Ŀ
      DateintervalTime:integer;//֧�����ݼ�����С����������ӣ�
      OpenFormName:string ;//�򿪴�������
      unname:string;//�򿪵���ú��Ĵ���  2016-6-14
      TransportRoadwayFirstDrillPressLocation:double;   //�������һ�����Ӧ����λ��
      TransportRoadwaySecondDrillPressLocation:double; //������ڶ������Ӧ����λ��
      PathwayRoadWayFirstDrillPressLocation:double;   //������һ�����Ӧ����λ��
      PathwayRoadWaySecondDrillPressLocation:double; //�����ڶ������Ӧ����λ��

      // ����빤����ڹ�ϵ
      UsedDrill:TZk_bore;//�����
      UsedDrillNo:integer;//��ױ��
      BuilledDrillNumber:integer;
      BuilledDrillType: array of TWorkfaceBuillDrill;
      //֧���빤����Ĺ�ϵ
      Usedsupport  :TWorkFaceBuillSupport; //������ʹ��֧��
      UsedSupportNO:integer; //������֧�ܱ��
      SupportName:String;// ֧������
      BuilledSupportNumber:integer;
      BuilledSupportType:array of TWorkFaceBuillSupport;
      //
  
     
     function GetUsedInfo:integer;  // ��øù�����usedʹ����Ϣ
     procedure setUsedInfo(Biaozhi:integer) ;// ���øù������ڲ�ʹ����Ϣ
     procedure CreatFault;     // �����ϲ�
     procedure CreateMineOutArea;  // �����ɿ���
     procedure CreateCaolPillar; // ����ú��
     procedure SetDateintervalTime(Value:integer);//�������ݼ����� ����
     function GetDateintervalTime:integer;//��� �������ݼ����� ����
     procedure SetDillNumber(Value:integer);//������ױ��
     procedure setGzmNumber(Value:integer);// ���ù�������
     //��ʼ��������֧���������±�
     function IntiArrayDrec:Boolean;


     function  FillDataType_SupportType(Gzmbh:integer):Boolean; //����Ѿ��ù����ֶ�����
     procedure SetSupportType(First,Second,Third,Fouth:integer); //����֧���ͺ�
     // function SplitString(const source, ch: string): TStringList;

     function ReadData:Boolean; //��ȡ��������Ϣ
     function RefreshFootage(Footage:Double):Boolean; //ˢ�½�����Ϣ

     //----------
     function  InputGzmData(uGzmBh:integer):Boolean;
     function  InputGzmFalut(uGzmBh:integer):Boolean;   //�ϲ�
     function  InputGzmAreaOut(uGzmBh:integer):Boolean;  //�ɿ���
     function  InputGzmCoalPillar(uGzmbh:integer):Boolean;   //ú��
     function  InputGzmSupport(Inn_support:TWorkFaceBuillSupport):Boolean;
     function  FillGzmBulidInfo:Boolean;   // ��乤��������
     function  InputGzmYc(innD:Tzk_bore):Boolean;
     function  WorkFaceBulidDrill:Boolean;
     Function  WorkFaceBulidSupport:Boolean;
     //TRockPressAnalysis
     function  UpdataFootStepParameters(strValue,supportNumber:string):Boolean;
     function  UpdateRockPressParameters(strValue:String):Boolean;
     function  UpdateColorString(StrValue:string):Boolean;
     function  splitFootStepParameters :Boolean;
     function  SplitRockPressParameters :Boolean;
     function  SplitColorString:Boolean;
     function  ClearMemo1Parameters:Boolean;
     function  ClearMemo2Parameters:Boolean;
     function  ClearColorString:Boolean;
     //-------
     function GetGzmZkStr(var GzmStr_S,Gzmstr_D,ZkStr:string): Boolean;
     function GetSupportStr(Var SupStr:String):Boolean;
     // ��ҪΪ ���ݱ���ʹ��
     function GetWorkFaceToText:String;
     function GetWorkFaceBuildZkToText(cqid:integer):String;
     function GetDrillInfoToText(inzk:Tzk_bore):String;
     function GetSupportInfoToText(insu:TWorkFaceBuillSupport):String;

     // readxml  Gzm
     function ReadWorkFaceXml(XmlString:String;UpdateOrInsert:string;
              Var event :string;var Newid :integer):String;
     function WriteWorkFaceXml:string;
     function IsExistWorkFace(Mineid:integer;WorkFaceName:String):integer;
     function InsertWorkFaceDataBase(dRec:PWorkFace ;var NewId:integer):Boolean;
     function InsertWorkFaceFullData(var NewId:integer):Boolean;
     function UpdateWorkFaceDataBase(dRec:PWorkFace):Boolean;
     function UpdateWorkFaceFullData(Gzmid:integer):Boolean;
     function SelecCoalSeamid(CoalSeamName:String;MineId:integer):integer;
     function ReturnCoalSeamName(CoalSeamid:integer):String;
     Function SelKuangjingBianHao(KuangjingName:String):integer; overload;
     function SelKuangJingBianHao(KuangjingName,jituanName:string;Jituan:integer):integer;overload;
     function SelJituanBianhao(JituanName:string):integer;
     function ReturnCoalmethodName(bh:integer):String;
     function RetrunCoalmethodbh(Name:string):integer;
     function DeleteGzmInfo(mineid:integer;dRec:PWorkFace;Var Newid:integer):Boolean;
     //readxml Zk
     function ReadDrillInfo(XmlString:String;RefreahOrDelete:string):String;
     function WriteDrillxml:string;
     function IsExistDrillInfo(DrillName:string):integer;
     function InsertDrillDataBase(innD:Tzk_bore):Boolean;
     function InsertDrillFullDAta(innD:Tzk_bore):Boolean;
     function UpdateDrillDateBase(innD:Tzk_bore):Boolean;
     function UpdateDrillFullDAta(innD:Tzk_bore):Boolean;
     function DeleteDrillInfo(innD:Tzk_bore):Boolean;
     // createBuilldWorkface
     function WriteWorkfaceSelectDrill(WorkFaceName:string):String;
     function ReadWorkFaceSelectDrill(WorkFaceName,DrillsInfo:String):String;
     function CheckWorkFaceLinkDrillYresOrNo(Gzmid,zkid:integer):Boolean;    //�ж�ú���һ����
     function InsertWorkfaceSelectDrillDataBase(gzmid:integer):Boolean; overload;
     function InsertWorkfaceSelectDrillDataBase:Boolean;overload;
     // read support
     function WriteSupportXml:string;
     function isExistSupportName(SupportName:string):integer;
     function ReadSupportInfo(SupportInfo:string;UpdateOrInsert:string):String;
     function InsertSupportToDataBase(insupport:TSupportStep):Boolean;
     function UpdateSupportToDataBase(insupport:TSupportStep):Boolean;
     function Deletesupport(insupport:TSupportStep):Boolean;
     // create Workface buill support
     function writeWorkFaceSelectSupport(WorkFaceName:string):string;
     function ReadWorkFaceSelectsupport(WorkFaceName,supportInfo:String):String;
     function InsertWorkfaceSelectSupportDataBase(gzmid:integer):Boolean;
     // create xml coalPliiar
     function WriteCoalPillarXml:String;
     function ReadCoalPliiarXml(CoalPillarInfo,UpdateOrInsert:string):string;
     function isCoalPillarExist(WorkFaceName,CoalPillarName:string):integer;
     function InsertCoalPillarToDataBase(nCoalPillar:TCoalPillar):Boolean;
     function UpdateCoalPillarToDataBase(nCoalPillar:TCoalPillar):Boolean;
     function DeleteColPillar(nCoalPillar:TCoalPillar):Boolean;
     //create xml fault
     function WriteFaultXml:String;
     function ReadFaultXml(FaultInfo,UpdateOrInsert:string):string;
     function isFaultExist(WorkFaceName,FaultName:string):integer;
     function InsertFaultToDataBase(nFault:TFault):Boolean;
     function UpdateFaultToDataBase(nFault:TFault):Boolean;
     function DeleteFault(nFault:TFault):Boolean;
     //Create xml mineOutArea
     function WriteMineOutAreaXml:String;
     function ReadMineOutAreaXml(MineOutAreaInfo,UpdateOrInsert:string):string;
     function isMineOutAreaExist(WorkFaceName,MineOutAreaName:string):integer;
     function InsertMineOutAreaToDataBase(nMineOutArea:TMineOutArea):Boolean;
     function UpdateMineOutAreaToDataBase(nMineOutArea:TMineOutArea):Boolean;
     function DeleteMineOutArea(nMineOutArea:TMineOutArea):Boolean;
     //create xml Userinfo
     function isExsitUserName(UserName:string):integer;
     function insertUserIntoDataBase(UN,UP,UD,UT:string):Boolean;
     function UpdateUserInfoDataBase(id:integer;UP,UD,UT:string) :Boolean;
     //Footage     2018 03 08
     function Manual_InputFootage(tDay: Tdatetime; DownDayFootage, SumDownFootage, EditDownFootage,
                            UpperDayFootage, SumUpperFootage,EditUpperFootage: double;Jindao,Flag:integer):Boolean;
     function DeleteAllFootageData(EndTime:String):Boolean;
     function ReadFootageDataToStringGrid(StrGrid:TstringGrid;EndTime:String):Boolean;   //��ȡ������������ά��
     function ReadFootageDataToRockDataGrid(StrGrid1,StrGrid2,StrGridShodow:TstringGrid;
                      MinDaoshu:integer):Boolean;   //��ȡ������������ά��
     function GetModifyFootageMaxDateTime(Flag:integer):TDateTime;

     function ReturnMaxFootAgeTime:TdateTime;
     function ReturnMinFootAgeTime:TdateTime;
     function ReturnDaoShuBasicTime(Dt:TdateTime):Integer;
     function ReturnMaxDao:integer;
     function ReturnDataTimeFromDao(DaoShu:integer):TDateTime;
     function ReturnCycleStepMaxValue(Str_td:string;Sb:integer;Var MaxTd:TdateTime;var MaxDAta:Double):Boolean;
     function ReturnBalanceFootage(Daoshu,supportbh:Integer):double;
     function ReturnUpperAndDownFootage(Daoshu:Integer;var downFootage,Upperfootage:double):Boolean;
     //manualInputRockPressData     2018 03 08
     function ReadRockPressDataToStrGrid(StrGrid1,StrGrid2,StrGridShodow:TStringGrid;
              MinDaoshu,Unit_Flag,ValueType:integer):Boolean;
     function SaveRockPressDataToDataBase(td:String;JinDao,SupportNo,ValueType:integer;
              Data:Double;Mem:String):Boolean;
     function SaveMultPressDataToDAteBase(td:String;JinDao,SupportNo:integer;
              Data0,Data1,Data2,Data3,Data4,Data5:Double;Mem:String):Boolean;
     function UpdateRockPressDataToDataBase(JinDao,SupportNo,ValueType:integer;Memo:String;
                             Data:Double):Boolean;
     function UpdataRockPress_Process(timeorProcess:integer;strDate:string;Flag:integer):Boolean;

     function DeleteRockPressData(daoshu,supportbh,Flag:integer):Boolean;     //
     function DeleteFromSupportMoveInfoAllData:Boolean;
     function ReturnRockPressDataMaxDaoshu:Integer;
     function ReturnManualInputPressDataField(Value:integer):String;

  //Flag:integer д����  1 Ϊ ���ⲿ¼����ߣ�2 �Զ��������     3 �޶������
          //ɾ�����ݿ�
     function DropWorkFaceBasicTable(Gzmid:integer):Boolean;  //ɾ���빤������ص����ݱ�
     function DropWorkFaceSupportTable(Gzmid:integer):Boolean;   // ɾ���빤���� ֧����ص�����
      //  Ԥ������
     procedure forcastsafe(var ChildRoot:TXmlNode); // Ԥ�������Ϣ
     function GetNowFootAge(Var SumDownFootage,SumUpperFootage:double):Boolean;
     function GetOldComePress(JInchi:double):Boolean;// �ж���ѹ״̬
      //�ѹ�����ı�ɲ���ʹ�õ�����
     function MakeGzmIsVail(Value:integer):Boolean;

      //
     constructor Create(ExConn:TMySqlConnection);
     destructor Destroy;



  private
     function InputGzmZk(innD: Tzk_bore): Boolean;
  end;

implementation

{ TFault }

uses Lu_Public_BasicModual;

//uses uMainFun;


{ TFault }

function TFault.forcase(FaultNumber:integer;jinChi: double; t_Gzm: TG_Stope;
        uOldComePress:Boolean;  var ChildRoot: TXmlNode):Boolean;
var
  ChildChildRoot,ChildChildChildRoot:TXmlNode;
  ICount:integer;
  MinDis,MaxDis:double;
  DiplayStr:string;
begin
     // nLeft,nRight,nFront,nbehind,nTop,nBottom
     Result:=false;
     ChildChildRoot:=ChildRoot.NodeNew('');
     ChildChildRoot.Name:=UTF8String('FaultWaringNo:'+IntToStr(FaultNumber));
     ICount:=1;
     if location = nLeft then  begin
         if self.MinToOffCut < t_gzm.ZCYL_s1[1]  then  begin
             Result:=true;
              ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
              ChildChildChildRoot.Name:=UTF8String(intTostr(iCount));
              ChildChildChildRoot.Value :=UTF8String('��ࡾ'+self.Name+'���ϲ���빤����̫����ע�����');
              iCount:=iCount+1;
         end else if (self.MinToOffCut > t_gzm.ZCYL_s1[1] ) and  (self.MinToOffCut < t_gzm.ZCYL_sx[1])
            and (self.maxToOffCut  < t_gzm.ZCYL_sx[1] )then   begin
               Result:=true;
               ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
               ChildChildChildRoot.Name:=UTF8String(intTostr(iCount));
               ChildChildChildRoot.Value :=UTF8String('��ࡾ'+self.Name+
                         '���ϲ�Թ���������в��ʩ����ע��ϲ��빤��������λ��');
               iCount:=iCount+1;
         end;
      end else if self.location = nRight then  begin
         if self.MinToOffCut < t_gzm.ZCYL_s1[3]  then  begin
              Result:=true;
              ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
              ChildChildChildRoot.Name:=UTF8String(intTostr(iCount));
              ChildChildChildRoot.Value :=UTF8String('�Ҳࡾ'+self.Name+'���ϲ���빤����̫����ע�����');
              iCount:=iCount+1;
         end else if (self.MinToOffCut > t_gzm.ZCYL_s1[3] ) and  (self.MinToOffCut < t_gzm.ZCYL_sx[3])
            and (self.maxToOffCut  < t_gzm.ZCYL_sx[3] )then   begin
               Result:=true;
               ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
               ChildChildChildRoot.Name:=UTF8String(intTostr(iCount));
               ChildChildChildRoot.Value :=UTF8String('�Ҳࡾ'+self.Name+
                          '���ϲ�Թ���������в��ʩ����ע��ϲ��빤��������λ��');
               iCount:=iCount+1;
            end;
      end else if self.location = nFront then  begin
             MinDis:=self.MinToOffCut-jinchi;
             MaxDis:=self.MaxToOffCut-jinchi;
             Result:=true;
             if safedistance<5 then  safedistance:=20;

             if (MinDis >0) and  (MinDis<t_gzm.ZCYL_sx[3])  and(MinDis >self.safedistance)
                 then  begin
                  if self.faulttype =1 then  begin
                     DiplayStr:=' ��������ǰ����'+self.Name+'���ϲ�Σ������'+ '�öϲ�Ϊ���ϲ㣬�ϲ����Ϊ'+
                        FormatFloat('0.0',divide)+'�ף�'+'�ʵ�����������Ƕȣ�ƽ���ƹ�������';
                  end else if self.faulttype =2 then begin
                     DiplayStr:=' ��������ǰ����'+self.Name+'���ϲ�Σ������'+ '�öϲ�Ϊ��ϲ㣬�ϲ����Ϊ'+
                        FormatFloat('0.0',divide)+'�ף�'+'�ʵ�����������Ƕȣ�ƽ���ƹ�������';
                  end else begin
                     Result:=false;
                  end;
                  if Result  then  begin
                        ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                        ChildChildChildRoot.Name:=UTF8String(intTostr(iCount));
                        ChildChildChildRoot.Value :=UTF8String(DiplayStr);
                        iCount:=iCount+1;
                  end;
              end else if ( (MinDis >0) and  (MinDis<t_gzm.ZCYL_sx[3])  and(MinDis < safedistance) ) or
                  ((MinDis <=0) and (MaxDis>-safedistance)  )  then   begin

                    if self.faulttype =1 then  begin
                     DiplayStr:=' �Ѿ����롾'+self.Name+'���ϲ�Σ������'+ '�öϲ�Ϊ���ϲ㣬�ϲ����Ϊ'+
                        FormatFloat('0.0',divide)+'�ף�'+'�ʵ�����������Ƕȣ�ƽ���ƹ�������';
                      end else if self.faulttype =2 then begin
                         DiplayStr:=' �Ѿ����롾'+self.Name+'���ϲ�Σ������'+ '�öϲ�Ϊ��ϲ㣬�ϲ����Ϊ'+
                            FormatFloat('0.0',divide)+'�ף�'+'�ʵ�����������Ƕȣ�ƽ���ƹ�������';
                      end else begin
                         Result:=false;
                      end;
                      if Result  then  begin
                            ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                            ChildChildChildRoot.Name:=UTF8String(intTostr(iCount));
                            ChildChildChildRoot.Value :=UTF8String(DiplayStr);
                            iCount:=iCount+1;
                     end;
                end
         end else if self.location = nbehind then  begin
               if self.MinToOffCut+jinchi < t_gzm.ZCYL_s1[2]  then  begin
                    Result:=true;
                    ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name:=UTF8String(intTostr(iCount));
                    ChildChildChildRoot.Value :=UTF8String('���桾'+self.Name+'���ϲ�Կ�������в��ע�����');
                    iCount:=iCount+1;
                end;

         end; // ����


end;

{ TGzm }



function TGzm.CheckWorkFaceLinkDrillYresOrNo(Gzmid, zkid: integer): Boolean;
var
  sql:string;
  MeiCengId:integer;
  Gzm_DataSet1:TMyDataSet;
begin
   Result:=false;
   Gzm_DataSet1:=TMyDataSet.Create(nil);
   Gzm_DataSet1.MySqlConnection:= MyExConn;
    try
        sql:=' select mcid from cqcsb where cqid= ' +intToStr(gzmid);
        Gzm_DataSet1.Close;
        Gzm_DataSet1.CommandText :=sql;
      if  Gzm_DataSet1.Open then begin
        if Gzm_DataSet1.RecordCount>0 then begin
            MeiCengId:= Gzm_DataSet1.FieldByName('mcid').AsInteger;
        end;
      end;
        Gzm_DataSet1.Close;
        sql:=' select mcid from zkycb where zkid= ' +intToStr(zkid) + ' and mcid > 0';
        Gzm_DataSet1.Close;
        Gzm_DataSet1.CommandText :=sql;
      if  Gzm_DataSet1.Open then  begin
        while not  Gzm_DataSet1.Eof  do  begin
           if MeiCengId= Gzm_DataSet1.FieldByName('mcid').AsInteger then begin
               Result:=true;
               break;
           end;
           Gzm_DataSet1.Next;
        end;
      end;

    finally
       Gzm_DataSet1.Close;
       Gzm_DataSet1.free;
    end;

end;

function TGzm.ClearColorString: Boolean;
begin
   RockPressAnalysis.ColorString:='';

end;

function TGzm.ClearMemo1Parameters: Boolean;
begin
     RockPressAnalysis.Oneday_daoshu:=10 ;
     RockPressAnalysis.TwoDao_IntervalTime:=90 ;
     RockPressAnalysis.OneDao_step:=0.865 ;
     RockPressAnalysis.ManulInput_Interval_support:=5;

end;

function TGzm.ClearMemo2Parameters: Boolean;
begin
     RockPressAnalysis.OldStepPhaseString:='';
     RockPressAnalysis.AnalysisSenstive:=0 ;
    // RockPressAnalysis.Continue_SupNumber:=0 ;
    // RockPressAnalysis.conTinue_DaoNumber:=0 ;
    // RockPressAnalysis.Min_Pt:=0 ;
     RockPressAnalysis.StepGroundFilled:=0 ;
     RockPressAnalysis.StepFillIsTran:=0;
     RockPressAnalysis.StepFillLineWide:=0 ;
     RockPressAnalysis.StepFillColor:=0 ;
     RockPressAnalysis.SetpFillTran:=0 ;
     RockPressAnalysis.SelectedFillColor:= 0 ;
end;

constructor TGzm.Create(ExConn:TMySqlConnection);
begin

     MyExConn:=ExConn;
     DateintervalTime:=1;
     Usedsupport:=TWorkFaceBuillSupport.Create;
     //��ʼ�����ڲ���
     self.SupStartNumber:=1;
     self.SupEndNumber:=122;
     self.SupNumberDirection:=0;
     //
      UsedDrill:=TZk_bore.Create;//�����

end;

procedure TGzm.CreateCaolPillar;
begin

end;

procedure TGzm.CreateMineOutArea;
begin

end;


procedure TGzm.CreatFault;
begin

end;

function TGzm.DeleteAllFootageData(EndTime:String): Boolean;
Var
   CSql:String;
   MyCommand:TMyCommand;
begin
    Result:=false;
   try
    MyCommand:=TMyCommand.create(nil);
    MyCommand.MySqlConnection:= MyExConn;

    CSql:='delete from d_'+IntTostr(Gzmbh) +'_footage where  footday >=' + EndTime   ;

    MyCommand.CommandText:=Csql;
    MyCommand.Execute ;

      Result:=true;
   finally
     FreeAndNil(MyCommand);
   end;

end;

function TGzm.DeleteColPillar(nCoalPillar:TCoalPillar): Boolean;
var
 gzmid:integer;
 Gzm_Command1:TMyCommand;
begin
   Result:=false;
   Gzm_Command1:=TMyCommand.Create(nil);
   Gzm_Command1.MySqlConnection:= MyExConn;
   gzmId:=nCoalPillar.gzmidbh ;
    try
       Gzm_Command1.CommandText:=' delete from mz_coalPillar   WHERE gzmid = '+Trim(inttostr(gzmId))+
            ' and mzName =  ''' +nCoalPillar.Name+'''';
       Gzm_Command1.Execute ;

   finally
       Result:=true;
   end;
end;

function TGzm.DeleteDrillInfo(innD:Tzk_bore): Boolean;
var
  zkid,i:integer;
  Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TMycommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn;
    Result:=false;
     try
      Gzm_Command1.MySqlConnection.BeginTrans;
      zkid:=IsExistDrillInfo(innd.Zk_name);
      //delete zkycb
      Gzm_Command1.CommandText:=' delete from zkycb where  zkid= '+IntToStr(Zkid) ;
      Gzm_Command1.Execute ;

      //delete zkb
      Gzm_Command1.CommandText:=' delete from zkb  where zkName='''+innd.Zk_name +'''';
      Gzm_Command1.Execute ;
      //delete WorkFaceBuillDrill
      Gzm_Command1.CommandText:=' delete from WorkFaceBuillDrill  where zkid='+IntToStr(Zkid) ;
      Gzm_Command1.Execute ;

      //������дɾ����¼
    except
        Result:=false;
        Gzm_Command1.MySqlConnection.RollbackTrans;
        exit;
    end;
       Result:=true;
       Gzm_Command1.MySqlConnection.CommitTrans;
       Gzm_command1.free;
end;

function TGzm.DeleteFault(nFault:TFault): Boolean;
var
 gzmid:integer;
 Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TMycommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn;
    Gzm_Command1:=TMycommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn;
   Result:=false;
   gzmId:=nFault.gzmbh;
   try
       Gzm_Command1.CommandText:=' delete from dc_Fault   WHERE gzmid = '+Trim(inttostr(gzmId))+
            ' and dcName =  ''' +nFault.Name+'''';
       Gzm_Command1.Execute ;
   finally
       Result:=true;
   end;
   Gzm_Command1.free;

end;

function TGzm.DeleteFromSupportMoveInfoAllData: Boolean;
Var
   Sql:String;
   MyCommand:TMyCommand;
begin
    Result:=false;
   try
    MyCommand:=TMyCommand.create(nil);
    MyCommand.MySqlConnection:= MyExConn;

    Sql:='delete from d_'+IntTostr(Gzmbh) +'_SupportMoveInfo ';

      MyCommand.CommandText:=sql;
      MyCommand.Execute ;

      Result:=true;
   finally
     FreeAndNil(MyCommand);
   end;

end;

function TGzm.DeleteGzmInfo(Mineid:integer;dRec:PWorkFace;Var Newid:integer): Boolean;
var
 gzmid:integer;
  Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TMycommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn;
    try
      gzmid:=self.IsExistWorkFace(kuangjingid,dRec.WorkFaceName) ;
      Newid:=gzmid;
      self.setGzmNumber(gzmid);
      self.ReadData;
      Gzm_Command1.MySqlConnection.BeginTrans;
      self.DropWorkFaceBasicTable(gzmid);     //ɾ��������
      self.DropWorkFaceSupportTable(gzmid);   //ɾ��֧�ܱ�
      Gzm_Command1.CommandText:='delete from cqcsb  where cqName='''+dRec.WorkFaceName +'''' +
                                ' and kid =' +IntToSTr(mineid);
      Gzm_Command1.Execute ;

      Gzm_Command1.CommandText:=' delete from WorkFaceBuillDrill  where gzmid='+IntToStr(gzmid) ;
      Gzm_Command1.Execute ;

      //������дɾ����¼
    except
        Result:=false;
        Gzm_Command1.MySqlConnection.RollbackTrans;
        exit;
    end;
       Result:=true;
       Gzm_Command1.MySqlConnection.CommitTrans;
    Gzm_Command1.free;
end;

function TGzm.DeleteMineOutArea(nMineOutArea:TMineOutArea): Boolean;
var
 gzmid:integer;
 Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TMycommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn;
   Result:=false;
   gzmId:=nMineOutArea.Gzmid ;
    try
       Gzm_Command1.CommandText:=' delete from ckq_MineOutArea   WHERE gzmid = '+Trim(inttostr(gzmId))+
            ' and ckqName =  ''' +nMineOutArea.Name+'''';
       Gzm_Command1.Execute ;

   finally
       Result:=true;
       Gzm_Command1.free;
   end;
end;

function TGzm.Deletesupport(insupport:TSupportStep): Boolean;
var
  supportid:integer;
  Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TMycommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn;

    try
      supportid:=self.isExistSupportName(insupport.Zj_Name) ;
      Gzm_Command1.MySqlConnection.BeginTrans;
      Gzm_Command1.CommandText:='delete from zjxhb  where id='+ intToStr(supportid);
      Gzm_Command1.Execute ;

      Gzm_Command1.CommandText:='delete from workFacebuillSupport  where supportid='+ intToStr(supportid);
      Gzm_Command1.Execute ;

      //������дɾ����¼
    except
        Result:=false;
        Gzm_Command1.MySqlConnection.RollbackTrans;
        exit;
    end;
       Result:=true;
       Gzm_Command1.MySqlConnection.CommitTrans;
    Gzm_command1.free;
end;

function TGzm.DeleteRockPressData(daoshu, supportbh,Flag: integer): Boolean;
{
   Flag =0 ���ȫ����¼
   Flag =1 ��� ��ǰ��������ǰ֧�� ��¼
   Flag =2 ��� �ȵ�ǰ������ ��� ������¼
   Flag =3 ��� process=0 �ļ�¼
}
Var
   Sql:String;
   MyCommand:TMyCommand;
begin
    Result:=false;
   try
    MyCommand:=TMyCommand.create(nil);
    MyCommand.MySqlConnection:= MyExConn;
    // ������� ��ǰ��¼
      if Flag =0  then  begin
         Sql:='delete from d_'+IntTostr(Gzmbh) +'_ManualInputPressData ';
      end else if Flag =1  then  begin
         Sql:='delete from d_'+IntTostr(Gzmbh) +'_ManualInputPressData  where  Daoshu = ' +IntTostr(daoshu) +
               ' and  Supportbh = ' +  IntTostr(supportbh);
      end else if Flag =2  then  begin
         Sql:='delete from d_'+IntTostr(Gzmbh) +'_ManualInputPressData  where  Daoshu > ' +IntTostr(daoshu) ;
      end else if Flag =3  then  begin
         Sql:='delete from d_'+IntTostr(Gzmbh) +'_ManualInputPressData  where  process = 0 ' ;
      end;
      MyCommand.CommandText:=sql;
      MyCommand.Execute ;

      Result:=true;
   finally
     FreeAndNil(MyCommand);
   end;


end;

destructor TGzm.Destroy;
 var
  i:integer;
begin 
   for I := 0 to cFault-1 do   FreeandNil(Fault[i]);
   for I := 0 to cCoalPillar-1 do  FreeandNil(CoalPillar[i]);
   for I := 0 to cMineOutArea-1 do  FreeandNil(MineOutArea[i]);
   for I := 0 to BuilledDrillNumber -1 do   FreeandNil(BuilledDrillType[i]) ;
   for I := 0 to BuilledsupportNumber -1 do   FreeandNil(BuilledSupportType[i]) ;

   FreeAndNil(Usedsupport) ;
   FreeAndNil(UsedDrill) ;
   inherited Destroy;
end;




function TGzm.DropWorkFaceBasicTable(Gzmid:integer): Boolean;
var
  Gzm_Command1:TMyCommand;
  StrList:TStringList;
  i:integer;
  t_sql:string;
begin
   try
     Gzm_Command1:=TMycommand.create(nil);
     Gzm_Command1.MySqlConnection:= MyExConn;
     StrList:=TStringList.Create;
     MainDataModule.MySqliteDataBase.GetWorkFaceGenerateTable(IntTostr(Gzmid),'2',StrList) ;
     for I := 0 to StrList.Count -1  do  begin
         t_sql:='DROP TABLE '+StrList[i]+'';
         Gzm_Command1.CommandText :=t_sql;
         Gzm_Command1.Execute ;

     end;
    finally
      Result:=true;
      Gzm_command1.free;
      StrList.Free;
    end;
end;

function TGzm.DropWorkFaceSupportTable(Gzmid:integer): Boolean;
var
  Gzm_Command1:TMyCommand;
  StrList:TStringList;
  i:integer;
  t_sql:string;
begin
   try
     Gzm_Command1:=TMycommand.create(nil);
     Gzm_Command1.MySqlConnection:= MyExConn;
     StrList:=TStringList.Create;
     MainDataModule.MySqliteDataBase.GetWorkFaceGenerateTable(IntTostr(Gzmid),'3',StrList) ;
     for I := 0 to StrList.Count -1  do  begin
         t_sql:='DROP TABLE '+StrList[i]+'';
         Gzm_Command1.CommandText :=t_sql;
         Gzm_Command1.Execute ;

     end;
    finally
      Result:=true;
      Gzm_command1.free;
      StrList.Free;
    end;
end;

function TGzm.FillDataType_SupportType(Gzmbh: integer): Boolean;
var
  Gzm_DataSet1:TMyDataSet;
  Sql:string;
 // First,Second,Third,Fouth:integer;
  RecorN,Temp_C:Integer;
  ValueType: TSupportDataType;  //   ��һ����������
begin
    Result:=False;
    IsUesedsupFieldcount:=0;

    Gzm_DataSet1:=TMyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn;
    Sql:=' select DataType from GzmdataType  where cqid= '+ intToStr(Gzmbh) +
         ' Group by DataType  order by datatype';
    RecorN:=0;
 //   First:=0;Second:=0;Third:=0;Fouth:=0;
 try
    Gzm_DataSet1.CommandText :=sql;
    if Gzm_DataSet1.Open  then
      while not Gzm_DataSet1.Eof  do begin
         Temp_C:=Gzm_DataSet1.FieldByName('DataType').AsInteger;
         if Temp_C >0 then begin
             ValueType:=TSupportDataType(Temp_C);
             IsUesedsupFieldName[RecorN]:=
               GetEnumName(TypeInfo(TSupportDataType),ord(ValueType ));
             RecorN:=RecorN+1;
         end;
        Gzm_DataSet1.Next ;
      end;
    //
    if RecorN >0 then  begin
       IsUesedsupFieldcount:=RecorN;
       Result:=true;
    end;

 finally
    Gzm_DataSet1.Close ;
    FreeAndNil(Gzm_DataSet1);
 end;

end;

function TGzm.FillGzmBulidInfo: Boolean;
begin
    Result:=False;
    if WorkFaceBulidDrill then  begin
        WorkFaceBulidSupport;
        Result:=true;
    end;


end;


procedure TGzm.forcastsafe(var ChildRoot:TXmlNode);
var
  SumDownFootage,SumUpperFootage,jinchi:double;
  Abutment_S2,Abutment_S1,Abutment_S0:double;
  Gzm_S,Gzm_D,Zkstr,SEorr:string;
  i:integer;
  ResultF:Boolean;
begin
//     ResultF:=false;
//     // ��õ�ǰ���������ֵ
//     if not GetNowFootAge(SumDownFootage,SumUpperFootage)   then  exit;
//     jinchi:= (SumDownFootage+SumUpperFootage)/2;
//      //��ȡ�������
//     if  not self.ReadData  then exit;
//      //ˢ�¹���������
//     if not  RefreshFootage(jinchi)then  exit;
//     //  ��ȡ�����ַ���
//     if not GetGzmZkStr(Gzm_S,Gzm_D,ZkStr)  then exit;
//    // ��ʼ��P_stop
//    //  if not MyP_stope.InitModel(Gzm_S,Zkstr,Seorr)  then  exit;
//      //����϶�����
//     //   self.Get_PStope_OldInfo ;
//     //�����ѹ���
//   //   self.OldComePress :=self.GetOldComePress(jinchi);
//     //�ж϶ϲ�
//     for I := 0 to self.cFault-1 do
//          if Fault[i].forcase(i+1,jinchi,MyP_stope.t_Gzm,OldComePress,ChildRoot) then
//              ResultF:=true;
//     //
//      //�жϲɿ���
//     for I := 0 to self.cMineOutArea-1  do
//         if self.MineOutArea[i].forcase (i+1,jinchi,MyP_stope.t_Gzm,OldComePress,ChildRoot) then
//              ResultF:=true;
//
//     //�ж�ú��
//     for I := 0 to self.cCoalPillar-1 do
//          if self.CoalPillar[i].forcase(i+1,jinchi,MyP_stope.t_Gzm,OldComePress,ChildRoot) then
//              ResultF:=true;
//     //

end;

function TGzm.GetDateintervalTime: integer;
begin
     if DateintervalTime>1  then    Result:=DateintervalTime
                            else   Result:=1;
end;

function TGzm.GetDrillInfoToText(inzk:Tzk_bore): String;
var
  ZKStr:string;
  I:integer;
begin
     ZKStr:='ZK:' + InttoStr(inzk.Zk_No) + ', ' + //  1
                   inzk.Zk_name   +',' + // 2
                   InttoStr(inzk.Zk_Yc_Count)+'&' ; //

     for I := 0 to inzk.Zk_Yc_Count - 1 do  begin
       ZKStr:=ZKStr+ IntToStr(inzk.Yc_Rock[i].Yc_No ) +','  + // 1
                     inzk.Yc_Rock[i].R_Name +',' + // 2
                     FormatFloat('.##',inzk.Yc_Rock[i].R_MinH )+',' + //  3
                     FormatFloat('.##',inzk.Yc_Rock[i].R_MaxH )+',' + //  4
                     FormatFloat('.##',inzk.Yc_Rock[i].R_h )+',' + //  5
                     FormatFloat('.##',inzk.Yc_Rock[i].R_kyqd)+',' + //  6
                     FormatFloat('.##',inzk.Yc_Rock[i].R_klqd)+',' + // 7
                     FormatFloat('.##',inzk.Yc_Rock[i].R_kjqd)+',' + // 8
                     FormatFloat('.##',inzk.Yc_Rock[i].R_fchd)+',' ; //  9
           if inzk.Yc_Rock[i].R_sffc then  ZKStr:=ZKStr+'1,'    //10
              else  ZKStr:=ZKStr+'0,';
           ZKStr:=ZKStr+FormatFloat('.##',inzk.Yc_Rock[i].R_k_Rock)+',' + // 11
                        FormatFloat('.##',inzk.Yc_Rock[i].R_r)+',' ; //  12
           if (inzk.Yc_Rock[i].M_Kc_YandN)  then  begin
              ZKStr:=ZKStr+'1,' +                            //13
              ReturnCoalSeamName(inzk.Yc_Rock[i].MCId)+','; // 14�Ƿ�ɲ�
           end  else  begin                                           // �ɲ�ú��
              ZKStr:=ZKStr+'0,0,';
           end;
           if inzk.Yc_Rock[i].R_sfhsc then   ZKStr:=ZKStr+'1,'
            else  ZKStr:=ZKStr+'0,'   ;                        //15 �Ƿ�ˮ��

          ZKStr:=ZKStr+ inzk.Yc_Rock[i].BMP_File+'&'  //16    ͼƬ
      end;
     Result:=ZkStr+';';
end;

function TGzm.GetUsedInfo: integer;
begin

end;


function TGzm.GetWorkFaceBuildZkToText(cqid:integer): String;
var
  I:integer;
  Gzm_DataSet2:TMyDataSet;
  WandZk:string;
begin
    Gzm_DataSet2:=TMyDataSet.create(nil);
    Gzm_DataSet2.MySqlConnection:= MyExConn;
    WandZk:='WZ:';
   //
     try
       Gzm_DataSet2.Close();
       Gzm_DataSet2.CommandText:='SELECT Z.ZkName,W.startdistance,W.enddistance,C.cqname '
               + ' FROM WorkFaceBuillDrill  as W , zkb as  z ,cqcsb as C '
               +'  WHERE W.gzmid = '+inttostr(cqid) + ' and z.zkid=W.zkid  and C.cqid=W.gzmid';
       if  (Gzm_DataSet2.Open) and (Gzm_DataSet2.RecordCount>0)  then begin
           WandZk:=WandZk+IntTostr(Gzm_DataSet2.RecordCount)+'&' ;

           while not Gzm_DataSet2.Eof  do  begin
                 WandZk:=WandZk+ Gzm_DataSet2.FieldByName('cqname').AsString +',';
                 WandZk:=WandZk+ Gzm_DataSet2.FieldByName('ZkName').AsString +',';
                 WandZk:=WandZk+Gzm_DataSet2.FieldByName('startdistance').AsString+',';
                 WandZk:=WandZk+ Gzm_DataSet2.FieldByName('enddistance').AsString+'&';
                 Gzm_DataSet2.Next;
            end;
       end;
     finally
        Gzm_DataSet2.Close();
        FreeAndNil(Gzm_DataSet2);
        Result:=WandZk+';';
     end;

end;

function TGzm.GetWorkFaceToText: String;
var
 GZMStr_D:string;
begin
     GZMStr_D:='GZM:';
     GZMStr_D:=GZMStr_D+IntToStr(Gzmbh) +',';    //1  ��������
     GZMStr_D:=GZMStr_D+self.S_Name +',';  //2 'cqname'

    // GZMStr_D:=GZMStr_D+self.S_mc_name  +',';    //3 'mcid'
     GZMStr_D:=GZMStr_D+ ReturnCoalSeamName(Public_Basic.StrToInt_lu(S_mc_name))+',';

     GZMStr_D:=GZMStr_D+FormatFloat('.##',self.S_Cg_h)+',';    //4  Kch
     GZMStr_D:=GZMStr_D+IntToStr(S_CMFS_INteger)+',';    //5  cmfa'
     GZMStr_D:=GZMStr_D+FormatFloat('.##',self.S_DayStep_speed)+',';  //6 speed
//
     GZMStr_D:=GZMStr_D+FormatFloat('.##',self.S_qj )+',';    //7 qxqj
     GZMStr_D:=GZMStr_D+FormatFloat('.##',self.S_SX_qj )+',';    //8 zxqj
     GZMStr_D:=GZMStr_D+FormatFloat('.##',self.S_Sh_UP)+',';    //9  sh1
     GZMStr_D:=GZMStr_D+FormatFloat('.##',self.S_Sh_Down)+',';    //10 sh2
     GZMStr_D:=GZMStr_D+FormatFloat('.##',self.S_mcsd_h)+',';    //11  gc
     GZMStr_D:=GZMStr_D+FormatFloat('.##',self.S_L_qx)+',';  //12  qxc
     GZMStr_D:=GZMStr_D+FormatFloat('.##',self.S_Sx_zx)+',';    //13 zxc
     GZMStr_D:=GZMStr_D+FormatFloat('.##',self.S_f_PS)+',';    //14  mtyd

     GZMStr_D:=GZMStr_D+Inttostr(self.Dz_yxfx)+',';    //15  yxfx
     GZMStr_D:=GZMStr_D+Inttostr(self.Dz_JYHD )+',';    //16  jyhd
     GZMStr_D:=GZMStr_D+Inttostr(self.Dz_DCGZ )+',';    //17  dcgz
     GZMStr_D:=GZMStr_D+Inttostr(self.Dz_WSFC )+',';    //18   wsfc
     GZMStr_D:=GZMStr_D+Inttostr(self.Dz_TopWater )+',';    //19  Topwater
     GZMStr_D:=GZMStr_D+Inttostr(self.Dz_BottomWater)+',';  //20  bottomwater
     GZMStr_D:=GZMStr_D+Inttostr(self.Dz_HeoStress )+',';    //21 heoStress
     GZMStr_D:=GZMStr_D+Inttostr(self.Dz_Kyxx)+',';    //22 KYxx

     GZMStr_D:=GZMStr_D+Inttostr(self.Dz_HangDaoSup)+',';    //23  hangdaoSup
     GZMStr_D:=GZMStr_D+'0,0,0,0,';    //24   UPKc   //25   UPMz  //26  downKC  //27  downmz
     GZMStr_D:=GZMStr_D+ FormatFloat('.##',self.S_Jc_L)+',';    //28 �ۻ�����
     GZMStr_D:=GZMStr_D+ Inttostr(self.SupStartNumber)+',';    //29 ֧�ܿ�ʼ���
     GZMStr_D:=GZMStr_D+ Inttostr(self.SupEndNumber)+',';    //30  ֧�ܽ������
     GZMStr_D:=GZMStr_D+ Inttostr(self.SupNumberDirection)+',';    //31 ֧�ܷ���
     GZMStr_D:=GZMStr_D+ self.ZjName +',';    //32 ֧���ͺ�
     GZMStr_D:=GZMStr_D+ FormatFloat('.##',S_Agv_mch)  +';';    //33 ú�����

     Result:=GZMStr_D;
end;

function TGzm.Manual_InputFootage(tDay: Tdatetime; DownDayFootage, SumDownFootage,
  EditDownFootage, UpperDayFootage, SumUpperFootage, EditUpperFootage: double;
  Jindao,Flag: integer): Boolean;
Var
   CSql:String;
   MyCommand:TMyCommand;
begin
    Result:=false;
   try
    MyCommand:=TMyCommand.create(nil);
    MyCommand.MySqlConnection:= MyExConn;
    CSql:='insert into d_'+IntTostr(Gzmbh) +'_footage ( footday,Daoshu,downfootage,sumdownfootage,EditDownFootage, '+
              ' upperfootage,sumupperfootage,EditUpperFootage,processage) values (' +
              ''''+ FormatDateTime( 'yyyy-mm-dd hh:nn:ss',tDay)+''','+ IntTostr(JinDao) +',' +
              FormatFloat('0.000',DownDayFootage)+','+ FormatFloat('0.00',SumDownFootage)+','+ FormatFloat('0.00',EditDownFootage)+','+
              FormatFloat('0.000',UpperDayFootage)+','+ FormatFloat('0.00',SumUpperFootage)+ ','+ FormatFloat('0.00',EditUpperFootage)+','+
              IntToStr(Flag)+')';
      MyCommand.CommandText:=Csql;
      MyCommand.Execute ;
      Result:=true;
   finally
     FreeAndNil(MyCommand);
   end;



end;

function TGzm.InputGzmAreaOut(uGzmBh: integer): Boolean;
var
   Gzm_DataSet1:TMyDataSet;
begin
    Gzm_DataSet1:=TMyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn;
    result:=false;
 try
    try
        Gzm_DataSet1.Close;
        Gzm_DataSet1.CommandText :='select * from ckq_mineoutarea where gzmid =  '+inttostr(uGzmbh)+' order by id';
        cMineOutArea:=0;
        if  Gzm_DataSet1.Open then begin
            while not Gzm_DataSet1.Eof do begin
                 cMineOutArea:=cMineOutArea+1;
                  SetLength(MineOutArea,cMineOutArea);
                  MineOutArea[cMineOutArea-1]:= TMineOutArea.Create;

                  MineOutArea[cMineOutArea-1].Name :=Gzm_DataSet1.FieldByName('ckqName').AsString;
                  MineOutArea[cMineOutArea-1].location  :=TGzmLocation(GetEnumValue(TypeInfo(TGzmLocation),Gzm_DataSet1.FieldByName('location').AsString));
                  MineOutArea[cMineOutArea-1].Outtime  :=Gzm_DataSet1.FieldByName('Outtime').AsDateTime;
                  MineOutArea[cMineOutArea-1].width  :=Gzm_DataSet1.FieldByName('width').AsFloat;
                  MineOutArea[cMineOutArea-1].length  :=Gzm_DataSet1.FieldByName('length').AsFloat;
                  MineOutArea[cMineOutArea-1].heigth  :=Gzm_DataSet1.FieldByName('heigth').AsFloat;

                  MineOutArea[cMineOutArea-1].dis_left  :=Gzm_DataSet1.FieldByName('dis_left').AsFloat;
                  MineOutArea[cMineOutArea-1].dis_right  :=Gzm_DataSet1.FieldByName('dis_right').AsFloat;
                  MineOutArea[cMineOutArea-1].dis_front  :=Gzm_DataSet1.FieldByName('dis_front').AsFloat;
                  MineOutArea[cMineOutArea-1].dis_behind  :=Gzm_DataSet1.FieldByName('dis_behind').AsFloat;
                  MineOutArea[cMineOutArea-1].dis_top  :=Gzm_DataSet1.FieldByName('dis_top').AsFloat;
                  MineOutArea[cMineOutArea-1].dis_bottom  :=Gzm_DataSet1.FieldByName('dis_bottom').AsFloat;

                  MineOutArea[cMineOutArea-1].safedistance  :=Gzm_DataSet1.FieldByName('safedistance').AsFloat;
                  MineOutArea[cMineOutArea-1].gzmid  :=Gzm_DataSet1.FieldByName('gzmid').AsInteger;
                  Gzm_DataSet1.Next;
            end;
        end;
           result:=true;
      finally
         Gzm_DataSet1.Close;
         Gzm_DataSet1.free;

     end;
 except
   On e:exception do begin
        Public_Basic.MY_WriteLog('Eorr: InputGzmAreaOut'+e.Message,'[TGZM]');
   end;

 end;

end;

function TGzm.InputGzmCoalPillar(uGzmbh: integer): Boolean;
var
    Gzm_DataSet1:TMyDataSet;
begin
    Gzm_DataSet1:=TMyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn;
    result:=false;
    Gzm_DataSet1.Close;
 try
    try
      Gzm_DataSet1.CommandText :='select * from mz_coalpillar  where gzmid =  '+inttostr(uGzmbh)+' order by id';
      if  Gzm_DataSet1.Open then begin
        cCoalPillar:=0;
        while not Gzm_DataSet1.Eof  do begin
              cCoalPillar:=cCoalPillar+1;
              SetLength(CoalPillar,cCoalPillar);
              CoalPillar[cCoalPillar-1]:= TCoalPillar.Create;

              CoalPillar[cCoalPillar-1].Name :=Gzm_DataSet1.FieldByName('MzName').AsString;
              CoalPillar[cCoalPillar-1].location  :=TGzmLocation(GetEnumValue(TypeInfo(TGzmLocation),Gzm_DataSet1.FieldByName('location').AsString));

              CoalPillar[cCoalPillar-1].width  :=Gzm_DataSet1.FieldByName('width').AsFloat;
              CoalPillar[cCoalPillar-1].length  :=Gzm_DataSet1.FieldByName('length').AsFloat;
              CoalPillar[cCoalPillar-1].heigth  :=Gzm_DataSet1.FieldByName('heigth').AsFloat;

              CoalPillar[cCoalPillar-1].dis_left  :=Gzm_DataSet1.FieldByName('dis_left').AsFloat;
              CoalPillar[cCoalPillar-1].dis_right  :=Gzm_DataSet1.FieldByName('dis_right').AsFloat;
              CoalPillar[cCoalPillar-1].dis_front  :=Gzm_DataSet1.FieldByName('dis_front').AsFloat;
              CoalPillar[cCoalPillar-1].dis_behind  :=Gzm_DataSet1.FieldByName('dis_behind').AsFloat;
              CoalPillar[cCoalPillar-1].dis_top  :=Gzm_DataSet1.FieldByName('dis_top').AsFloat;
              CoalPillar[cCoalPillar-1].dis_bottom  :=Gzm_DataSet1.FieldByName('dis_bottom').AsFloat;

              CoalPillar[cCoalPillar-1].safedistance  :=Gzm_DataSet1.FieldByName('safedistance').AsFloat;
              CoalPillar[cCoalPillar-1].gzmidbh  :=Gzm_DataSet1.FieldByName('gzmid').AsInteger;

              Gzm_DataSet1.Next;
          end ;
      end;

    finally
      Gzm_DataSet1.Close;
      Gzm_DataSet1.free;
      result:=true;
     end;
 except
   On e:exception do begin
        Public_Basic.MY_WriteLog('Eorr: InputGzmCoalPillar'+e.Message,'[TGZM]');
   end;

 end;
end;

function TGzm.InputGzmData(uGzmBh: integer): Boolean;
Var
  s:string;
  Cmff:integer;
  Gzm_DataSet1:TMyDataSet;
  Gzm_DataSet2:TMyDataSet;
begin
 try
   try
    Gzm_DataSet1:=TMyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn;
    Gzm_DataSet2:=TMyDataSet.create(nil);
    Gzm_DataSet2.MySqlConnection:= MyExConn;
    Result:=false;

    Gzm_DataSet1.Close();
    Gzm_DataSet1.CommandText:='select * from cqcsb where cqID='+inttostr(uGzmbh);
    if Gzm_DataSet1.Open then
       if Gzm_DataSet1.RecordCount > 0 then begin
            S_No:=inttostr(Gzm_DataSet1.FieldByName('cqid').AsInteger );    // ��ȡ���

            //InputGzm.S_No:=(Gzm_DataSet1.FieldByName('cqid')).AsString ;    // ��ȡ���
            KuangJingId:=Gzm_DataSet1.FieldByName('kid').AsInteger;  // �������
            S_Name:=Gzm_DataSet1.FieldByName('cqname').AsString;     // ��������

            S_mc_name:=Gzm_DataSet1.FieldByName('mcid').AsString;    //ú����


            Gzm_DataSet2.Close();
            Gzm_DataSet2.CommandText:='select * from meiceng where ID='+S_mc_name;
            if Gzm_DataSet2.Open then
             if Gzm_DataSet2.recordcount>0  then
                s:=Gzm_DataSet2.FieldByName('MeiCengMing').AsString;    //ú������
            Gzm_DataSet2.Close();
            self.S_Sh_UP:=Gzm_DataSet1.FieldByName('sh1').AsFloat;    //�Ͻ����
        //
            self.S_Sh_Down:=Gzm_DataSet1.FieldByName('sh2').AsFloat;   //c6: �½����'
            self.S_mcsd_h:=Gzm_DataSet1.FieldByName('gc').AsFloat;//ƽ�����
            self.S_Sx_zx:=Gzm_DataSet1.FieldByName('zxc').AsFloat;//���򳤶�
            self.S_L_qx:=Gzm_DataSet1.FieldByName('qxc').AsFloat;//����
            self.S_SX_qj:=Gzm_DataSet1.FieldByName('zxqj').AsFloat;//�������
            self.S_qj:=Gzm_DataSet1.FieldByName('qxqj').AsFloat;//�������
            self.S_Agv_mch:=Gzm_DataSet1.FieldByName('mch').AsFloat;//ú�����
            S_Cg_h:=Gzm_DataSet1.FieldByName('kch').AsFloat;//���ɸ߶�
            s_fm_h:= S_Agv_mch-s_cg_h;                          //��ú�߶�
            //����״̬
            self.S_Dblb:='3';

            Cmff:=Gzm_DataSet1.FieldByName('cmfa').Asinteger;  // ��ú����
            self.S_CMFS_INteger :=Cmff;
            if Cmff = 0  then begin
               self.S_cmfs := '�ڲ�';
            end else if Cmff = 1 then begin
               self.S_cmfs := '�ղ�';
            end else if Cmff = 2  then begin
               self.S_cmfs := '�۲�';
            end else if Cmff = 3  then begin
               self.S_cmfs := '�Ŷ�ú';
            end else if Cmff = 4  then begin
               self.S_cmfs := '�ֲ㿪��(�Ϸֲ�)';
            end else if Cmff = 5  then begin
               self.S_cmfs := '�ֲ㿪��(�·ֲ�)';
            end;

            self.S_f_PS:=Gzm_DataSet1.FieldByName('mtyd').AsInteger;// ú��Ӳ��
            self.S_DayStep_speed:=Gzm_DataSet1.FieldByName('speed').AsFloat;//�ƽ��ٶ�
            self.Dz_yxfx :=Gzm_DataSet1.FieldByName('yxfx').AsInteger;//��б��Щ
            zjName:=Gzm_DataSet1.FieldByName('zjxh').Asstring;     //  c18: ֧���ͺ�
            self.Dz_DCGZ:=Gzm_DataSet1.FieldByName('dcgz').AsInteger;//�������
            self.Dz_JYHD:=Gzm_DataSet1.FieldByName('jyhd').AsInteger;//���Һ��
            //self.Dz_HangDaoSup:=Gzm_DataSet1.FieldByName('zhqk').AsInteger;//֧�����
            self.Dz_WSFC:=Gzm_DataSet1.FieldByName('wsfc').AsInteger;//��˹����
            self.Dz_TopWater:=Gzm_DataSet1.FieldByName('topwater').AsInteger;//����ˮԴ
            self.Dz_BottomWater:=Gzm_DataSet1.FieldByName('bottomwater').AsInteger;//�װ�ˮԴ
            self.Dz_HeoStress:=Gzm_DataSet1.FieldByName('heostress').AsInteger;//ˮƽӦ��
            self.Dz_Kyxx:=Gzm_DataSet1.FieldByName('kyxx').AsInteger;// ��ѹ����
            self.Dz_HangDaoSup:=Gzm_DataSet1.FieldByName('hangdaosup').AsInteger;//���֧��
            self.CK_UpMz:=Gzm_DataSet1.FieldByName('upmz').AsFloat;//�߽�ú��
            self.CK_Upkc:=Gzm_DataSet1.FieldByName('upkc').AsInteger;//�ϱ߽�ɿ�
            self.CK_downmz:=Gzm_DataSet1.FieldByName('downmz').AsFloat;//�±߽�ú��
            self.CK_downkc:=Gzm_DataSet1.FieldByName('downkc').AsInteger;//�±߽�ɿ�
            //:=FormatFloat('.##',Gzm_DataSet1.FieldByName('kczt').AsFloat);//����״̬
            S_Jc_L:=Gzm_DataSet1.FieldByName('kccd').AsFloat;//���ɳ���

            SupStartNumber:=Gzm_DataSet1.FieldByName('SupStartNumber').AsInteger;  // ֧�ܿ�ʼ
            SupEndNumber:=Gzm_DataSet1.FieldByName('SupEndNumber').AsInteger;  //֧�ܽ���
            SupEndUsedNumber:=SupEndNumber;
            SupNumberDirection:=Gzm_DataSet1.FieldByName('SupNumberDirection').AsInteger;  //����
            used:=Gzm_DataSet1.FieldByName('qyzt').AsInteger -1;  //������״̬
            TransportRoadwayFirstDrillPressLocation:= Gzm_DataSet1.FieldByName('TRFirstDrillPress').AsFloat;
            TransportRoadwaySecondDrillPressLocation:= Gzm_DataSet1.FieldByName('TRSecondDrillPress').AsFloat;
            PathwayRoadWayFirstDrillPressLocation:= Gzm_DataSet1.FieldByName('PRFirstDrillPress').AsFloat;
            PathwayRoadWaySecondDrillPressLocation:= Gzm_DataSet1.FieldByName('PRSecondDrillPress').AsFloat;
            FootStepParameters:=Gzm_DataSet1.FieldByName('Memo1').AsString;  // ���ߵ���Ҫ����
            RockPressAnalysisParameters:= Gzm_DataSet1.FieldByName('Memo2').AsString;  // ��ѹ������Ҫ����
            ColorString:=Gzm_DataSet1.FieldByName('ColorString').AsString;  // ��ѹ������Ҫ����
            result :=true;
         end;
    finally
        Gzm_Dataset1.free;
        Gzm_Dataset2.free;
    end;
 except
    On e:exception do begin
        Public_Basic.MY_WriteLog('Eorr: InputGzmData'+e.Message,'[TGZM]');
    end;
 end;



end;

function TGzm.InputGzmFalut(uGzmBh: integer): Boolean;
var
   Gzm_DataSet1:TMyDataSet;
begin
    Gzm_DataSet1:=TMyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn;
    Result:=false;
 try
  try
   Gzm_DataSet1.Close;
   Gzm_DataSet1.CommandText :='select * from dc_fault where gzmid =  '+inttostr(uGzmbh)+' order by id';
    if Gzm_DataSet1.Open then begin
       cFault:=0;
       while not Gzm_DataSet1.Eof  do begin
          cFault:=cFault+1;
          SetLength(Fault,cFault);
          Fault[cFault-1]:=TFault.Create;

          Fault[cFault-1].Name :=Gzm_DataSet1.FieldByName('dcName').AsString;
          Fault[cFault-1].faulttype  :=Gzm_DataSet1.FieldByName('faulttype').AsInteger;
          Fault[cFault-1].divide   :=Gzm_DataSet1.FieldByName('divide').AsFloat;
          Fault[cFault-1].MinToOffCut  :=Gzm_DataSet1.FieldByName('MinToOffCut').AsFloat;
          Fault[cFault-1].MaxToOffCut   :=Gzm_DataSet1.FieldByName('MaxToOffCut').AsFloat;
          Fault[cFault-1].location :=TGzmLocation(GetEnumValue(TypeInfo(TGzmLocation),Gzm_DataSet1.FieldByName('location').AsString));

          Fault[cFault-1].safedistance  :=Gzm_DataSet1.FieldByName('safedistance').AsFloat;
          Fault[cFault-1].gzmbh  :=Gzm_DataSet1.FieldByName('gzmid').AsInteger;
          Gzm_DataSet1.Next;
       end;
    end;
    Result:=true;
  finally
     Gzm_DataSet1.Close;
     Gzm_DataSet1.free;
  end;
 except
    On e:exception do begin
        Public_Basic.MY_WriteLog('Eorr: InputGzmFalut'+e.Message,'[TGZM]');
    end;
 end;


end;

function TGzm.InputGzmSupport(Inn_support:TWorkFaceBuillSupport): Boolean;
var
   Gzm_DataSet1:TMyDataSet;
begin
    Gzm_DataSet1:=TMyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn;

    result:=false;
    Gzm_DataSet1.Close();
    if Inn_support.Supportid >0 then  begin
        Gzm_DataSet1.CommandText:='SELECT * FROM zjxhb WHERE  id = '+IntToStr(Inn_support.Supportid);
    end else if Inn_support.Zj_Name <>'' then begin
        Gzm_DataSet1.CommandText:='SELECT * FROM zjxhb WHERE  xh = '''+trim(Inn_support.Zj_Name )+'''';
    end else begin
       exit;
    end;
  if  Gzm_DataSet1.Open then
    if Gzm_DataSet1.RecordCount > 0 then begin
       Inn_support.Zj_Name:=Gzm_DataSet1.FieldByName('xh').AsString;// ֧�ܵ�����
       Inn_support.Zj_BianHao:=Gzm_DataSet1.FieldByName('id').AsString;  //֧�ܵı��
       Inn_support.Zj_leixing:=Gzm_DataSet1.FieldByName('lx').AsString;//֧�ܵ��ͺ�
       Inn_support.Zj_Lizhu_count:=Gzm_DataSet1.FieldByName('zjmd').AsInteger;  //֧����������
       Inn_support.Zj_toall_F:=Gzm_DataSet1.FieldByName('zcl').AsFloat;       //֧�������迹��
       Inn_support.zj_toall_P:=Gzm_DataSet1.FieldByName('zhqd').AsFloat;       //֧��֧��ǿ��
       Inn_support.Zj_suoliang:=Gzm_DataSet1.FieldByName('ysl').AsFloat;      //֧���������
       Inn_support.Zj_KongdingJU:=Gzm_DataSet1.FieldByName('kdj').AsFloat;    //֧�ܿض���
       Inn_support.Zj_zhongxinju:=Gzm_DataSet1.FieldByName('zjkd').AsFloat;    //֧�����ľ�
       Inn_support.Zj_hlzyd:=Gzm_DataSet1.FieldByName('hld').AsFloat;        //�������õ�
       Inn_support.Zj_hubang_h:=Gzm_DataSet1.FieldByName('hbgd').AsFloat;      //֧�ܻ���߶�
       Inn_support.zj_hubang_P:=Gzm_DataSet1.FieldByName('hbqd').AsFloat;     //֧�ܻ���ǿ��
       Inn_support.Lz_Diameter:=Gzm_DataSet1.FieldByName('lzgj').AsFloat;//�����׾�
       Inn_support.initLoad := Gzm_DataSet1.FieldByName('zjczl').AsFloat;     //   ������
       Inn_support.EndOpenLoad := Gzm_DataSet1.FieldByName('yyfkqqd').AsFloat; //  Һѹ������
       result:=true;

    end;
    Gzm_DataSet1.Close();
    Gzm_DataSet1.free;


end;

function TGzm.InputGzmYc(innD:Tzk_bore): Boolean;
var
    zkbzkid:string;
    c_count:integer;
    booll1,booll2:integer;
    Gzm_DataSet2:TMyDataSet;
begin
    Gzm_DataSet2:=TMyDataSet.create(nil);
    Gzm_DataSet2.MySqlConnection:= MyExConn;
    Result:=false;
    Gzm_DataSet2.Close();
    Gzm_DataSet2.CommandText:='select * from zkycb where zkID = '+INTTOSTR(innD.Zk_No)+
                  ' order by yczkid ';
  if  Gzm_DataSet2.Open  then begin
     innD.Zk_Yc_Count:= Gzm_DataSet2.RecordCount;
     Gzm_DataSet2.First ;
     c_count:=1;
      while not Gzm_DataSet2.Eof do begin
        SetLength(innD.Yc_Rock,c_count);
        innD.Yc_Rock[c_count-1]:= TYc_Rock.Create;
        innD.Yc_Rock[c_count-1].Yc_No:=Gzm_DataSet2.FieldByName('Yczkid').AsInteger; //�Ҳ���
        innD.Yc_Rock[c_count-1].R_Name:=Gzm_DataSet2.FieldByName('ysmc').AsString; //�Ҳ�����
        innD.Yc_Rock[c_count-1].R_MaxH :=Gzm_DataSet2.FieldByName('maxhd').AsFloat; //�����
        innD.Yc_Rock[c_count-1].R_MinH :=Gzm_DataSet2.FieldByName('minhd').AsFloat; //��С���
        innD.Yc_Rock[c_count-1].R_h :=Gzm_DataSet2.FieldByName('hd').AsFloat; //����
        innD.Yc_Rock[c_count-1].R_kyqd :=Gzm_DataSet2.FieldByName('kyqd').AsFloat; //��ѹ
        innD.Yc_Rock[c_count-1].R_klqd :=Gzm_DataSet2.FieldByName('klqd').AsFloat; //����
        innD.Yc_Rock[c_count-1].R_kjqd :=Gzm_DataSet2.FieldByName('kjqd').AsFloat; //����
        innD.Yc_Rock[c_count-1].R_fchd :=Gzm_DataSet2.FieldByName('fchd').AsFloat; //�ֲ���
        innD.Yc_Rock[c_count-1].BMP_File:=Gzm_DataSet2.FieldByName('BmpFile').AsString;//ͼ���ļ�
        booll1:=Gzm_DataSet2.FieldByName('sffc').AsInteger; //�Ƿ�ֲ�
        if booll1 = 0 then begin
          innD.Yc_Rock[c_count-1].R_sffc := false;
        end else begin
          innD.Yc_Rock[c_count-1].R_sffc := true;
        end;
        if Gzm_DataSet2.FieldByName('sfhsc').AsInteger =0 then    begin
           innD.Yc_Rock[c_count-1].R_sfhsc:=False;
        end else begin
           innD.Yc_Rock[c_count-1].R_sfhsc:=true;
        end;

        innD.Yc_Rock[c_count-1].R_k_Rock :=Gzm_DataSet2.FieldByName('szxs').AsFloat; //����ϵ��

        innD.Yc_Rock[c_count-1].R_r :=Gzm_DataSet2.FieldByName('rz').AsFloat; //����
        booll2:=0;
        booll2:=Gzm_DataSet2.FieldByName('mcID').AsInteger; //�Ƿ񱾴ο���ú��
        innD.Yc_Rock[c_count-1].MCId :=booll2;
        if booll2 = 0 then begin
           innD.Yc_Rock[c_count-1].M_Kc_YandN := false;
        end else begin
           innD.Yc_Rock[c_count-1].M_Kc_YandN := true;
        end;
        c_count:=c_count+1;
        Gzm_DataSet2.Next;
      end; //end while

  end;

  Gzm_DataSet2.Close ;
  Gzm_DataSet2.free;
  result:=true;
end;



function TGzm.InputGzmZk(innD: Tzk_bore): Boolean;
begin

end;

function TGzm.InsertCoalPillarToDataBase(nCoalPillar:TCoalPillar): Boolean;
var
   sql:string;
   i:integer;
   Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TMycommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn;
      Result:=false;
     try
       sql := 'insert into Mz_coalpillar (gzmid,mzName,location,width,length,heigth,dis_left,dis_right,dis_front, '+
                     ' dis_behind,dis_top,dis_bottom,safedistance ) values (' +
                    intTostr(nCoalPillar.gzmidbh) +','''+nCoalPillar.Name+''','''+
                    GetEnumName(TypeInfo(TGzmLocation),ord(nCoalPillar.location ))+''',' +
                    Formatfloat('0.00',nCoalPillar.width) + ','+ Formatfloat('0.00',nCoalPillar.length) + ','+
                    Formatfloat('0.00',nCoalPillar.heigth) + ','+ Formatfloat('0.00',nCoalPillar.dis_left) + ','+
                    Formatfloat('0.00',nCoalPillar.dis_right) + ','+ Formatfloat('0.00',nCoalPillar.dis_front) + ','+
                    Formatfloat('0.00',nCoalPillar.dis_behind) + ','+ Formatfloat('0.00',nCoalPillar.dis_top) + ','+
                    Formatfloat('0.00',nCoalPillar.dis_bottom) + ','+ Formatfloat('0.00',nCoalPillar.safedistance) + ')';
        Gzm_command1.CommandText:=sql;
        Gzm_Command1.Execute ;
     finally
      Result:=true;
      Gzm_Command1.free;
     end;


end;

function TGzm.InsertDrillDataBase(innD: Tzk_bore): Boolean;
var
  sql:string;
  zkid,i:integer;
   Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TMycommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn;
     Result:=false;
     sql:=' insert into zkb (kid,zkname ) values ( ' +
               IntToStr(innD.Mineid ) +',''' +Trim(innd.Zk_name) +''')';
          Gzm_command1.CommandText:=sql;
          Gzm_Command1.Execute ;

     zkid:=IsExistDrillInfo(innd.Zk_name);
     if Zkid= -1  then  exit;
     Gzm_command1.MySqlConnection.BeginTrans ;
     try
         for I := 0 to innD.Zk_Yc_Count-1 do  begin

             sql := 'insert into zkycb (kid,zkid,yczkid,ysmc,hd,kyqd,klqd,rz,mcid,szxs) values (' +
                    intTostr(innD.Mineid) +','+InttoStr(Zkid)+','+InttoStr(innD.Yc_Rock[i].Yc_No)+',''' +
                    innD.Yc_Rock[i].R_Name +''','+ Formatfloat('0.00',innD.Yc_Rock[i].R_h) +
                    ','+Formatfloat('0.00',innD.Yc_Rock[i].R_kyqd)+',' + Formatfloat('0.00',innD.Yc_Rock[i].R_klqd)+
                    ','+Formatfloat('0.00',innD.Yc_Rock[i].R_r)+','+ intTostr(innD.Yc_Rock[i].MCId)+','+
                    '1.3) ' ;
              Gzm_command1.CommandText:=sql;
              Gzm_Command1.Execute ;

         end;
          Gzm_command1.MySqlConnection.CommitTrans;
   except
        Gzm_command1.MySqlConnection.RollbackTrans ;
        exit;
   end;
    Gzm_Command1.free;
    Result:=true;
end;

function TGzm.InsertDrillFullDAta(innD: Tzk_bore): Boolean;
var
  sql,sffc,sfhsc:string;
  zkid,i:integer;
   Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TMycommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn;
     Result:=false;
     sql:=' insert into zkb (kid,zkname ) values ( ' +
               IntToStr(innD.Mineid ) +',''' +Trim(innd.Zk_name) +''')';
          Gzm_command1.CommandText:=sql;
          Gzm_Command1.Execute ;

     zkid:=IsExistDrillInfo(innd.Zk_name);
     if Zkid= -1  then  exit;
     Gzm_command1.MySqlConnection.BeginTrans ;
     try
         for I := 0 to innD.Zk_Yc_Count-1 do  begin
              if innD.Yc_Rock[i].R_sffc then   sffc:='1' else sffc:='0' ;
              if innD.Yc_Rock[i].R_sfhsc then  sfhsc :='1' else sfhsc:='0';
              sql := 'insert into zkycb (kid,zkid,yczkid,ysmc,minhd,maxhd,hd,kyqd,klqd,kjqd,rz,mcid,BmpFile'
                    + ',szxs,sffc,fchd,sfhsc) values ('
                    + intTostr(innD.Mineid) +','+InttoStr(Zkid)+','+InttoStr(innD.Yc_Rock[i].Yc_No)+','''
                    + innD.Yc_Rock[i].R_Name +''','+ Formatfloat('0.00',innD.Yc_Rock[i].R_MinH) +','
                    + Formatfloat('0.00',innD.Yc_Rock[i].R_MaxH) +','+  Formatfloat('0.00',innD.Yc_Rock[i].R_h) +','
                    + Formatfloat('0.00',innD.Yc_Rock[i].R_kyqd)+',' + Formatfloat('0.00',innD.Yc_Rock[i].R_klqd)+ ','
                    + Formatfloat('0.00',innD.Yc_Rock[i].R_kjqd)+','+Formatfloat('0.00',innD.Yc_Rock[i].R_r)+','
                    + intTostr(innD.Yc_Rock[i].MCId)+',''' +innD.Yc_Rock[i].BMP_File +''','
                    + Formatfloat('0.00',innD.Yc_Rock[i].R_k_Rock) + ','+ sffc + ','
                    + Formatfloat('0.00',innD.Yc_Rock[i].R_fchd)+ ','+ sfhsc
                    + ') ' ;
              Gzm_command1.CommandText:=sql;
              Gzm_Command1.Execute ;

         end;
          Gzm_command1.MySqlConnection.CommitTrans;
   except
        Gzm_command1.MySqlConnection.RollbackTrans ;
        exit;
   end;
    Gzm_Command1.free;
    Result:=true;

end;

function TGzm.InsertFaultToDataBase(nFault: TFault): Boolean;
var
   sql:string;
   i:integer;
   Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TMycommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn;
      Result:=false;
     try
       sql := 'insert into dc_Fault (gzmid,dcName,location,faulttype,divide,MinToOffCut,MaxToOffCut,safedistance ) values (' +
                    intTostr(nFault.gzmbh) +','''+nFault.Name+''','''+
                    GetEnumName(TypeInfo(TGzmLocation),ord(nFault.location ))+''',' +
                    intToStr(nFault.faulttype) + ','+ Formatfloat('0.00',nFault.divide) + ','+
                    Formatfloat('0.00',nFault.MinToOffCut) + ','+ Formatfloat('0.00',nFault.MaxToOffCut) + ','+
                    Formatfloat('0.00',nFault.safedistance) + ')';
        Gzm_command1.CommandText:=sql;
        Gzm_Command1.Execute ;

     finally
       Gzm_command1.free;
       Result:=true;
     end;


end;

function TGzm.InsertMineOutAreaToDataBase(nMineOutArea: TMineOutArea): Boolean;
var
   sql:string;
   i:integer;
   Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TMycommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn;
     Result:=false;
     try
       sql := 'insert into ckq_MineOutArea (gzmid,ckqName,location,outTime,width,length,heigth,dis_left,dis_right,dis_front, '+
                     ' dis_behind,dis_top,dis_bottom,safedistance ) values (' +
                    intTostr(nMineOutArea.gzmid) +','''+nMineOutArea.Name+''','''+
                    GetEnumName(TypeInfo(TGzmLocation),ord(nMineOutArea.location ))+''',''' +
                    FormatDateTime('yyyy-mm-dd hh:nn:ss',nMineOutArea.Outtime)+''',' +
                    Formatfloat('0.00',nMineOutArea.width) + ','+ Formatfloat('0.00',nMineOutArea.length) + ','+
                    Formatfloat('0.00',nMineOutArea.heigth) + ','+ Formatfloat('0.00',nMineOutArea.dis_left) + ','+
                    Formatfloat('0.00',nMineOutArea.dis_right) + ','+ Formatfloat('0.00',nMineOutArea.dis_front) + ','+
                    Formatfloat('0.00',nMineOutArea.dis_behind) + ','+ Formatfloat('0.00',nMineOutArea.dis_top) + ','+
                    Formatfloat('0.00',nMineOutArea.dis_bottom) + ','+ Formatfloat('0.00',nMineOutArea.safedistance) + ')';
        Gzm_command1.CommandText:=sql;
        Gzm_Command1.Execute ;

     finally
       Gzm_command1.free;
       Result:=true;
     end;


end;

function TGzm.InsertSupportToDataBase(insupport: TSupportStep): Boolean;
var
   sql:string;
   Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TMycommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn;
     Result:=false;
     sql:=' insert into zjxhb (xh,lx,zjmd,zcl,zhqd,ysl,kdj,zjkd,hld,lzgj,zjczl,yyfkqqd,hbgd,hbqd ) values ( ''' +
         insupport.Zj_Name +''',''' +insupport.Zj_leixing +''',' +IntToStr(insupport.Zj_Lizhu_count)  +
         ', ' +Formatfloat('0.00',insupport.Zj_toall_F) +','+ Formatfloat('0.00',insupport.Zj_toall_P)   +
         ', ' +Formatfloat('0.00',insupport.Zj_suoliang) +','+ Formatfloat('0.00',insupport.Zj_KongdingJU)   +
         ', ' +Formatfloat('0.00',insupport.Zj_zhongxinju) +','+ Formatfloat('0.00',insupport.Zj_hlzyd)   +
         ', ' +Formatfloat('0.00',insupport.Lz_Diameter) +','+ Formatfloat('0.00',insupport.initLoad)   +
         ', ' +Formatfloat('0.00',insupport.EndOpenLoad) +','+ Formatfloat('0.00',insupport.Zj_hubang_h)   +
         ','+ Formatfloat('0.00',insupport.zj_hubang_P)   +
          ')';

   try
    Gzm_command1.CommandText:=sql;
    Gzm_Command1.Execute ;

   finally
      Result:=true;
      Gzm_command1.free;
   end;
end;

function TGzm.insertUserIntoDataBase(UN, UP, UD, UT: string): Boolean;
var
   sql:string;
   Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TMycommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn;
     Result:=false;
     try
       Sql:='insert into UserInfo (UserName,User_Password,User_Type,Used) Values( ''' +
           UN+''','''+UP+''',' +UT +','+UD+')';
        Gzm_command1.CommandText:=sql;
        Gzm_Command1.Execute ;

     finally
       Gzm_command1.free;
       Result:=true;
     end;


end;

function TGzm.InsertWorkFaceDataBase(dRec: PWorkFace;var NewId:integer): Boolean;
var
 sql:string;
   meicengid :integer;
   Cmff:integer;
   Gzm_Command1:TMyCommand;
   Gzm_DataSet1:TMyDataset;
begin
    Gzm_Command1:=TMycommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn;
    Gzm_DataSet1:=TmyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn;
    {
      WorkFaceName:string;
      CoalSeamName:string;
      CoalMiningHeigth:double;
      CoalMiningMethod:string;
      CoalseamAngle:double;
      AVGBuriedDepth:double;
      WorkFaceLength:double;
      TowardDistance:double;
      Coalhardness:double;
    }
     Result:=false;
     MeiCengid:=SelecCoalSeamid(dRec.CoalSeamName,kuangjingid);
     Cmff:=RetrunCoalmethodbh(dRec.CoalMiningMethod);
     sql:=' insert into cqcsb (kid,cqName,mcid,cmfa,qxqj,qxc,zxc,mtyd,gc,kch,supstartNumber,supEndNumber, '+
          ' supNumberDirection,TRFirstDrillPress, TRSecondDrillPress,PRFirstDrillPress,PrSecondDrillPress,qyzt) values ( ' +
         IntToStr(kuangjingId) +',''' +dRec.WorkFaceName +''',' +IntToStr(MeiCengid)  +
         ', ' +dRec.CoalMiningMethod+','  +Formatfloat('0.00',dRec.CoalseamAngle) +',' +
         Formatfloat('0.00',dRec.WorkFaceLength) +','+ Formatfloat('0.00',dRec.TowardDistance) +
         ',' +Formatfloat('0.0',dRec.Coalhardness)+ ','+ Formatfloat('0.00',dRec.AVGBuriedDepth )+
         ','+Formatfloat('0.0',dRec.CoalMiningHeigth)+ ','+ intToStr(dRec.SupStartNumber )+
         ','+IntToSTr(dRec.supEndNumber)+ ','+ intToStr(dRec.SupDirection )+
         ',' +Formatfloat('0.0',dRec.TransportRoadwayFirstDrillPressLocation)+
         ','+ Formatfloat('0.00',dRec.TransportRoadwaySecondDrillPressLocation )+
         ',' +Formatfloat('0.0',dRec.PathwayRoadWayFirstDrillPressLocation)+
         ','+ Formatfloat('0.00',dRec.PathwayRoadWaySecondDrillPressLocation )+
         ',1)';
   try
      Gzm_command1.CommandText:=sql;
      Gzm_Command1.Execute ;

    // ���Ҹù�������
      NewId :=0;
      Gzm_DataSet1.Close ;
      sql:= 'select cqid  from cqcsb where kid= ' +IntToStr(kuangjingId) +
                                 ' and  cqName ='''+ dRec.WorkFaceName +'''';
      Gzm_DataSet1.CommandText := sql;
      if  Gzm_DataSet1.Open then
         if Gzm_DataSet1.RecordCount >0 then
              NewId:=Gzm_DataSet1.FieldByName('cqid').AsInteger;
   finally
      Result:=true;
      Gzm_command1.free;
      Gzm_Dataset1.free;
   end;

end;

function TGzm.InsertWorkFaceFullData(var NewId: integer): Boolean;
var
   sql:string;
   meicengid :integer;
   Cmff:integer;
   Gzm_Command1:TMyCommand;
   Gzm_DataSet1:TMyDataset;
begin
    Gzm_Command1:=TMycommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn;
    Gzm_DataSet1:=TmyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn;

    Result:=false;
    //                          1  2      3    4    5   6      7    8   9   10 11  12   13   14
    sql:=' insert into cqcsb (kid,cqName,mcid,kch,cmfa,speed,qxqj,zxqj,sh1,sh2,gc,qxc,zxc,mtyd ,'
         //  15    16   17   18   19        20          21       22    23   (24-27 ������)
          + 'yxfx,jyhd,dcgz,wsfc,topwater,bottomwater,heostress,kyxx,hangdaosup, '
          //  28    29            30               31             32   33
          + 'kccd,supstartNumber,supEndNumber,supNumberDirection,zjxh,mch)values ( '
          +  IntTostr(KuangJingId ) +', '''+   self.S_Name + ''','   //1 , 2
          +  S_mc_name +','+ FormatFloat('0.00',S_Cg_h) + ','  // 3,4
          +  IntTostr(S_CMFS_INteger)  + ',' +  FormatFloat('0.00',S_DayStep_speed) + ','// 5,6
          +  FormatFloat('0.00',S_qj) + ',' +  FormatFloat('0.00',S_SX_qj) + ','// 7,8
          +  FormatFloat('0.00',S_Sh_UP) + ',' +  FormatFloat('0.00',S_Sh_Down) + ','// 9,10
          +  FormatFloat('0.00',S_mcsd_h) + ',' +  FormatFloat('0.00',S_L_qx) + ','// 11,12
          +  FormatFloat('0.00',S_Sx_zx) + ',' +  FormatFloat('0.00',S_f_PS) + ','// 13,14
          +  IntTostr(Dz_yxfx) + ','+IntTostr(Dz_JYHD) + ','+ IntTostr(Dz_DCGZ) + ','  // 15,16,17
          +  IntTostr(Dz_WSFC) + ','+IntTostr(Dz_TopWater) + ','+ IntTostr(Dz_BottomWater) + ','  // 18,19,20
          +  IntTostr(Dz_HeoStress) + ','+IntTostr(Dz_Kyxx) + ','+ IntTostr(Dz_HangDaoSup) + ','  // 21,22 ,23
          +  FormatFloat('0.00',S_Jc_L) + ','   +  IntTostr(SupStartNumber) + ',' //28,29
          +  IntTostr(SupEndUsedNumber) + ','+IntTostr(SupNumberDirection) +',' //30,31
          +  '''' +ZjName+ ''','+ FormatFloat('.##',S_Agv_mch)      //32,33 ú�����
          + ')' ;

   try
      Gzm_command1.CommandText:=sql;
      Gzm_Command1.Execute ;

    // ���Ҹù�������
      NewId :=0;
      Gzm_DataSet1.Close ;
      sql:= 'select cqid  from cqcsb where kid= ' +IntToStr(kuangjingId) +
                                 ' and  cqName ='''+ S_Name +'''';
      Gzm_DataSet1.CommandText := sql;
      if  Gzm_DataSet1.Open then
         if Gzm_DataSet1.RecordCount >0 then
              NewId:=Gzm_DataSet1.FieldByName('cqid').AsInteger;

   finally
      Result:=true;
      Gzm_command1.free;
      Gzm_Dataset1.free;
   end;

end;

function TGzm.InsertWorkfaceSelectDrillDataBase(gzmid:integer): Boolean;
var
  Sql,pStr:string;
   i:integer;
   Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TMycommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn;
    Result:=false;
    try
         Gzm_command1.MySqlConnection.BeginTrans ;
         sql:= 'delete from workfacebuillDrill where  gzmid =' +IntToStr(gzmid)  ;
         Gzm_command1.CommandText:=sql;
         Gzm_Command1.Execute ;
          //
         sql:=' insert into workfacebuillDrill (gzmid,zkid,startdistance,enddistance) values ';
         pStr:= '(' +  IntToStr(gzmid)+' ,';
          for I :=0 to self.BuilledDrillNumber -1 do  begin
              sql:=sql+pStr+ intToStr(BuilledDrillType[i].zkid)+',' +
                   Formatfloat('0.00',self.BuilledDrillType[i].startdistance ) + ',' +
                   Formatfloat('0.00',self.BuilledDrillType[i].enddistance  ) +'),' ;
          end;
         sql:=Leftstr(sql,length(sql)-1); //ȥ�����Ķ���
         Gzm_command1.CommandText:=sql;
         Gzm_Command1.Execute ;

    except
       Gzm_command1.MySqlConnection.RollbackTrans ;
       exit;
    end;
       Gzm_command1.MySqlConnection.CommitTrans ;
       Gzm_command1.free;
       Result:=true
end;

function TGzm.InsertWorkfaceSelectDrillDataBase: Boolean;
var
   Sql,pStr:string;
   i:integer;
   Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TMycommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn;
    Result:=false;
    try
              //
         pStr:=' insert into workfacebuillDrill (gzmid,zkid,startdistance,enddistance) values (' ;
          for I :=0 to self.BuilledDrillNumber -1 do  begin
              if BuilledDrillType[i].Gzmid < 1 then   continue;
              // delete
                 Gzm_command1.CommandText:='delete from workfacebuillDrill where gzmid = '  + intToStr(BuilledDrillType[i].Gzmid )
                    + ' and  zkid =' + intToStr(BuilledDrillType[i].zkid) ;
                 Gzm_Command1.Execute ;
              //
              sql:=pStr + intToStr(BuilledDrillType[i].Gzmid )+','
                   + intToStr(BuilledDrillType[i].zkid)+','
                   + Formatfloat('0.00',self.BuilledDrillType[i].startdistance ) + ','
                   + Formatfloat('0.00',self.BuilledDrillType[i].enddistance  ) +')' ;
              Gzm_command1.CommandText:=sql;
              Gzm_Command1.Execute ;
          end;
    except

       exit;
    end;
       Gzm_command1.free;
       Result:=true

end;

function TGzm.InsertWorkfaceSelectSupportDataBase(gzmid:integer): Boolean;
var
   Sql,pStr:string;
   i:integer;
   Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TMycommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn;
   Result:=false;
    try
         Gzm_command1.MySqlConnection.BeginTrans ;
         sql:= 'delete from workfacebuillSupport where  gzmid =' +IntToStr(gzmid)  ;
         Gzm_command1.CommandText:=sql;
         Gzm_Command1.Execute ;
        //
         sql:=' insert into workfacebuillSupport (gzmid,Supportid,startSupportNo,endSupportNo) values ';
         pStr:= '(' +  IntToStr(gzmid)+' ,';
          for I :=0 to self.BuilledSupportNumber -1 do  begin
              sql:=sql+pStr+ IntToStr( self.BuilledSupportType[i].Supportid)  + ',' +
                    Formatfloat('0.00',self.BuilledSupportType[i].startSupportNo ) + ',' +
                    Formatfloat('0.00',self.BuilledSupportType[i].endSupportNo  ) +'),' ;
          end;
         sql:=Leftstr(sql,length(sql)-1); //ȥ�����Ķ���
         Gzm_command1.CommandText:=sql;
         Gzm_Command1.Execute ;

    except
       Gzm_command1.MySqlConnection.RollbackTrans ;
       exit;
    end;
       Gzm_command1.MySqlConnection.CommitTrans ;
       Gzm_Command1.free;
       Result:=true

end;

function TGzm.IntiArrayDrec: Boolean;
var
    MinSupbh,MaxSupbh:integer;
    SumSupportNumber, MidSupbh:integer;
begin
      Result:=false;
      // �����������Ϣ
       if S_L_qx/25 >=10 then    RecArryNumber:=7
       else      RecArryNumber:=5;
         //init Minsupbh,maxsupbh
          MinSupbh:=SupStartNumber ;
          MaxSupbh:=SupEndUsedNumber;
          SumSupportNumber:=Maxsupbh-MinSupbh+1;
          MidSupbh:=trunc((Maxsupbh-Minsupbh+1)/2);
         if MaxSupbh <50  then   exit;
         if Old_Step[2] <5 then  Old_Step[2]:=15;

         //����֧������
          dRecArry[1][0] :=MinSupbh;
          dRecArry[1][1] :=dRecArry[1][0]+ Trunc(2*Old_Step[2]/Usedsupport.Zj_zhongxinju);

          if RecArryNumber=5 then      begin
               dRecArry[3][0] :=MidSupbh-Round(2* Old_Step[2]/Usedsupport.Zj_zhongxinju);
               dRecArry[3][1] :=MidSupbh+Round(2* Old_Step[2]/Usedsupport.Zj_zhongxinju);

               dRecArry[2][0] :=dRecArry[1][1]+1;
               dRecArry[2][1] :=dRecArry[3][0]-1;

               dRecArry[5][1] :=MaxSupbh;
               dRecArry[5][0] :=dRecArry[5][1]-Trunc(2*Old_Step[2]/Usedsupport.Zj_zhongxinju);

               dRecArry[4][0]:=dRecArry[3][1]+1;
               dRecArry[4][1]:=dRecArry[5][0]-1;

          end   else if RecArryNumber=7 then    begin

               dRecArry[4][0] :=MidSupbh-Round(2* Old_Step[2]/Usedsupport.Zj_zhongxinju);
               dRecArry[4][1] :=MidSupbh+Round(2* Old_Step[2]/Usedsupport.Zj_zhongxinju);

               dRecArry[2][0] :=dRecArry[1][1]+1;
               dRecArry[2][1] :=dRecArry[2][0]+Round((dRecArry[4][0]-dRecArry[1][1])/2);

               dRecArry[3][0] :=dRecArry[2][1]+1;
               dRecArry[3][1] :=dRecArry[4][0]-1;


               dRecArry[7][1] :=MaxSupbh;
               dRecArry[7][0] :=dRecArry[7][1]-Trunc(Old_Step[2]/Usedsupport.Zj_zhongxinju);

               dRecArry[6][1] :=dRecArry[7][0]-1;
               dRecArry[6][0] :=dRecArry[6][1]-Round((dRecArry[7][0]-dRecArry[4][1])/2);

               dRecArry[5][0] :=dRecArry[4][1]+1;
               dRecArry[5][1] :=dRecArry[6][0]-1;
          end;
       Result:=true;
end;

function TGzm.isCoalPillarExist(WorkFaceName, CoalPillarName: string): integer;
var
 gzmid:integer;
  Gzm_DataSet1:TMydataset;
begin
    Result:=-1;
    CoalPillarName:=UpperCase(CoalPillarName);
    Gzm_DataSet1:=TmyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn ;
      gzmid:=self.IsExistWorkFace(kuangjingid,WorkFaceName);
   try
      Gzm_DataSet1.Close;
      Gzm_DataSet1.CommandText:='select id  from mz_coalpillar where gzmid='+InttoStr(gzmid) +
                                ' and mzName = ''' + CoalPillarName +'''' ;
     if Gzm_DataSet1.Open then
      if Gzm_DataSet1.RecordCount>0 then
         Result:=Gzm_DataSet1.FieldByName('id').AsInteger;
   finally
     Gzm_DataSet1.Close;
     Gzm_Dataset1.free;
   end;
end;

function TGzm.IsExistDrillInfo(DrillName: string): integer;
var
    Gzm_DataSet1:TMydataset;
begin
    DrillName:=UpperCase(DrillName);
    Gzm_DataSet1:=TmyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn ;
   try
     Result:=-1;
      Gzm_DataSet1.Close;
      Gzm_DataSet1.CommandText:='select zkid,kid  from zkb  where zkName='''+Trim(DrillName) +'''';
      if Gzm_DataSet1.Open then
          if Gzm_DataSet1.RecordCount>0 then  begin
             Result:=Gzm_DataSet1.FieldByName('zkid').AsInteger;
             kuangjingid:= Gzm_DataSet1.FieldByName('kid').AsInteger;
          end;

   finally
     Gzm_DataSet1.Close;
     Gzm_dataSet1.Free;
   end;

end;

function TGzm.isExistSupportName(SupportName: string): integer;
var
    Gzm_DataSet1:TMydataset;
begin
    SupportName:=UpperCase(SupportName);
    Gzm_DataSet1:=TmyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn ;
    Result:=-1;
     try
      Gzm_DataSet1.Close;
      Gzm_DataSet1.CommandText:='select id  from zjxhb  where xh='''+SupportName +'''';
      if Gzm_DataSet1.Open then
        if Gzm_DataSet1.RecordCount>0 then
         Result:=Gzm_DataSet1.FieldByName('id').AsInteger;
     finally
       Gzm_DataSet1.Close;
       Gzm_Dataset1.free;

     end;
end;

function TGzm.IsExistWorkFace(Mineid:integer;WorkFaceName: String): integer;
var
    Gzm_DataSet1:TMydataset;
begin
    WorkFaceName:=UpperCase(WorkFaceName);
    Gzm_DataSet1:=TmyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn ;
    Result:=-1;
    try
      Gzm_DataSet1.Close;
      Gzm_DataSet1.CommandText:='select kid,cqid,cqName from cqcsb  where cqName='''+WorkFaceName +'''' +
                                ' and  kid =' +IntToStr(Mineid);
      if  Gzm_DataSet1.Open then
          if Gzm_DataSet1.RecordCount>0 then  begin
             Result:=Gzm_DataSet1.FieldByName('cqid').AsInteger;
             kuangjingid:= Gzm_DataSet1.FieldByName('kid').AsInteger;
          end;
    finally
        Gzm_DataSet1.Close;
        Gzm_dataSet1.free;
    end;

end;

function TGzm.isExsitUserName(UserName: string): integer;
var
    Gzm_DataSet1:TMydataset;
    sql:string;
begin
    UserName:=UpperCase(UserName);
    Gzm_DataSet1:=TmyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn ;
    Result:=-1;
    try
      Gzm_DataSet1.Close;
      sql:='select * from  userInfo where UserName= '''+UpperCase(UserName)+'''';
      Gzm_DataSet1.CommandText :=sql;
      if  Gzm_DataSet1.Open then
          if Gzm_DataSet1.RecordCount>0 then  begin
             Result:=Gzm_DataSet1.FieldByName('id').AsInteger;
          end;
    finally
        Gzm_DataSet1.Close;
        Gzm_dataSet1.free;
    end;

end;

function TGzm.isFaultExist(WorkFaceName, FaultName: string): integer;
var
 gzmid:integer;
  Gzm_DataSet1:TMydataset;
begin
    FaultName:=UpperCase(FaultName);
    Gzm_DataSet1:=TmyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn ;
    gzmid:=self.IsExistWorkFace(kuangjingid,WorkFaceName);
    Result:=-1;
   try
      Gzm_DataSet1.Close;
      Gzm_DataSet1.CommandText:='select id  from dc_Fault where gzmid='+InttoStr(gzmid) +
                                ' and dcName = ''' + FaultName +'''' ;
      if Gzm_DataSet1.Open then
         if Gzm_DataSet1.RecordCount>0 then
         Result:=Gzm_DataSet1.FieldByName('id').AsInteger;

   finally
      Gzm_DataSet1.Close;
      Gzm_Dataset1.free;
   end;

end;

function TGzm.isMineOutAreaExist(WorkFaceName,   MineOutAreaName: string): integer;
var
 gzmid:integer;
 Gzm_DataSet1:TMydataset;
begin
    MineOutAreaName:=UpperCase(MineOutAreaName);
    Gzm_DataSet1:=TmyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn ;
      gzmid:=self.IsExistWorkFace(kuangjingid,WorkFaceName);
      Result:=-1;
   try
      Gzm_DataSet1.Close;
      Gzm_DataSet1.CommandText:='select id  from ckq_MineOutArea where gzmid='+InttoStr(gzmid) +
                                ' and ckqName = ''' + MineOutAreaName +'''' ;
      if Gzm_DataSet1.Open then
         if Gzm_DataSet1.RecordCount>0 then
         Result:=Gzm_DataSet1.FieldByName('id').AsInteger;
   finally
     Gzm_DataSet1.Close;
     Gzm_Dataset1.free;
    end;

end;

function TGzm.MakeGzmIsVail(Value: integer): Boolean;
var
 Gzm_Command:TMyCommand;
begin
  Result:=False;
    Gzm_Command:=TMyCommand.create(nil);
    Gzm_Command.MySqlConnection:= MyExConn ;

   try
      Gzm_Command.CommandText:='update Cqcsb set qyzt =' + intToStr(Value);
      Gzm_Command.Execute ;
   finally
      Result:=true;
   end;
    Gzm_Command.free;
end;

function TGzm.GetGzmZkStr(var GzmStr_S,Gzmstr_D, ZkStr: string): Boolean;
var
   mcbhid:string;//˽��ú��id
   i:integer;
   iskc:string;
begin
     Result:=false;
     //Gzm_s
     GzmStr_S:='Gzm:';
     GzmStr_S:=GzmStr_S+IntToStr(Gzmbh) +',';    //1  ��������
     GzmStr_S:=GzmStr_S+self.S_Name +',';  //2 '����������'
     GzmStr_S:=GzmStr_S+self.S_mc_name  +',';    //3 '����ú��'

     GzmStr_S:=GzmStr_S+FormatFloat('.##',self.S_Cg_h)+',';    //4  ��ú�߶�
     GzmStr_S:=GzmStr_S+IntToStr(S_CMFS_INteger)+',';    //5  ��ú��ʽ'
     GzmStr_S:=GzmStr_S+FormatFloat('.##',self.S_Fm_h)+',';  //6 ��ú�߶�
//
     GzmStr_S:=GzmStr_S+FormatFloat('.##',self.S_qj )+',';    //7 ú�����
     GzmStr_S:=GzmStr_S+FormatFloat('.##',self.S_mcsd_h)+',';    //8  ƽ������
     GzmStr_S:=GzmStr_S+FormatFloat('.##',self.S_L_qx)+',';  //9  ��б����*
     GzmStr_S:=GzmStr_S+FormatFloat('.##',self.S_Sx_zx)+',';    //10 �ƽ�����
     GzmStr_S:=GzmStr_S+FormatFloat('.##',self.S_Jc_L)+',';    //11 �ۻ�����
     GzmStr_S:=GzmStr_S+FormatFloat('.##',self.S_f_PS)+',';    //12  ú������ϵ��

     GzmStr_S:=GzmStr_S+FormatFloat('.##',self.S_M_mcj)+',';    //13  ú����Ħ����
     GzmStr_S:=GzmStr_S+FormatFloat('.##',self.S_M_njl )+',';    //14  ú���ھ���
     GzmStr_S:=GzmStr_S+FormatFloat('.##',self.S_Bsb )+',';    //15 ú�岴�ɱ�
     GzmStr_S:=GzmStr_S+FormatFloat('.##',self.S_K_zcfz )+',';    //16  ֧��ѹ����ֵ
     GzmStr_S:=GzmStr_S+self.S_Dblb +',';    //17  ��������r

     //Gzm_D
     GZMStr_D:='GZM_D:';
     GZMStr_D:=GZMStr_D+IntToStr(Gzmbh) +',';    //1  ��������
     GZMStr_D:=GZMStr_D+self.S_Name +',';  //2 'cqname'
     GZMStr_D:=GZMStr_D+self.S_mc_name  +',';    //3 'mcid'

     GZMStr_D:=GZMStr_D+FormatFloat('.##',self.S_Cg_h)+',';    //4  Kch
     GZMStr_D:=GZMStr_D+IntToStr(S_CMFS_INteger)+',';    //5  cmfa'
     GZMStr_D:=GZMStr_D+FormatFloat('.##',self.S_DayStep_speed)+',';  //6 speed
//
     GZMStr_D:=GZMStr_D+FormatFloat('.##',self.S_qj )+',';    //7 qxqj
     GZMStr_D:=GZMStr_D+FormatFloat('.##',self.S_SX_qj )+',';    //8 zxqj
     GZMStr_D:=GZMStr_D+FormatFloat('.##',self.S_Sh_UP)+',';    //9  sh1
     GZMStr_D:=GZMStr_D+FormatFloat('.##',self.S_Sh_Down)+',';    //10 sh2
     GZMStr_D:=GZMStr_D+FormatFloat('.##',self.S_mcsd_h)+',';    //11  gc
     GZMStr_D:=GZMStr_D+FormatFloat('.##',self.S_L_qx)+',';  //12  qxc
     GZMStr_D:=GZMStr_D+FormatFloat('.##',self.S_Sx_zx)+',';    //13 zxc
     GZMStr_D:=GZMStr_D+FormatFloat('.##',self.S_f_PS)+',';    //14  mtyd

     GZMStr_D:=GZMStr_D+Inttostr(self.Dz_yxfx)+',';    //15  yxfx
     GZMStr_D:=GZMStr_D+Inttostr(self.Dz_JYHD )+',';    //16  jyhd
     GZMStr_D:=GZMStr_D+Inttostr(self.Dz_DCGZ )+',';    //17  dcgz
     GZMStr_D:=GZMStr_D+Inttostr(self.Dz_WSFC )+',';    //18   wsfc
     GZMStr_D:=GZMStr_D+Inttostr(self.Dz_TopWater )+',';    //19  Topwater
     GZMStr_D:=GZMStr_D+Inttostr(self.Dz_BottomWater)+',';  //20  bottomwater
     GZMStr_D:=GZMStr_D+Inttostr(self.Dz_HeoStress )+',';    //21 heoStress
     GZMStr_D:=GZMStr_D+Inttostr(self.Dz_Kyxx)+',';    //22 KYxx

     GZMStr_D:=GZMStr_D+Inttostr(self.Dz_HangDaoSup)+',';    //23  hangdaoSup
     GZMStr_D:=GZMStr_D+'0,0,0,0,';    //24   UPKc   //25   UPMz  //26  downKC  //27  downmz
     GZMStr_D:=GZMStr_D+ FormatFloat('.##',self.S_Jc_L)+'';    //28 �ۻ�����

      // zk
      if UsedDrill.Zk_Yc_Count <1 then begin
          Public_Basic.MY_WriteLog('Eorr: GetGzmZkStr/UsedDrill.Zk_Yc_Count<1','[TGZM]');
          exit;
      end;
      ZKStr:='ZK:' + InttoStr(UsedDrill.Zk_No) + ', ' + //  1
                   UsedDrill.Zk_name   +',' + // 2
                   InttoStr(self.UsedDrill.Zk_Yc_Count)+';' ; //

     for I := 0 to UsedDrill.Zk_Yc_Count - 1 do  begin
       ZKStr:=ZKStr+ IntToStr(UsedDrill.Yc_Rock[i].Yc_No ) +','  + // 1
                     UsedDrill.Yc_Rock[i].R_Name +',' + // 2
                     FormatFloat('.##',UsedDrill.Yc_Rock[i].R_h )+',' + //  3
                     FormatFloat('.##',UsedDrill.Yc_Rock[i].R_kyqd)+',' + //  4
                     FormatFloat('.##',UsedDrill.Yc_Rock[i].R_klqd)+',' + //  5
                     FormatFloat('.##',UsedDrill.Yc_Rock[i].R_fchd)+',' ; //  6
           if UsedDrill.Yc_Rock[i].R_sffc then  ZKStr:=ZKStr+'1,'    //7
              else  ZKStr:=ZKStr+'0,';
           ZKStr:=ZKStr+FormatFloat('.##',UsedDrill.Yc_Rock[i].R_k_Rock)+',' + // 8
                        FormatFloat('.##',UsedDrill.Yc_Rock[i].R_r)+',' ; //  9
           if (UsedDrill.Yc_Rock[i].M_Kc_YandN) and
                  (UsedDrill.Yc_Rock[i].MCId = StrToint(S_mc_name) )  then  begin   //10
                  ZKStr:=ZKStr+'1,';
           end else begin
               ZKStr:=ZKStr+'0,' ;
           end;
          ZKStr:=ZKStr+ UsedDrill.Yc_Rock[i].BMP_File+';'  //11
      end;
     Result:=true;
end;

function TGzm.GetModifyFootageMaxDateTime(Flag:integer): TDateTime;
Var
   CSql:String;
   MyDataSet:TMyDataSet;

begin
   Result:=-1;

   try
    MyDataSet:=TMyDataSet.create(nil);
    MyDataSet.MySqlConnection:= MyExConn;
     if Flag=0 then  begin
        CSql:= ' select Max(Footday) as TDA from  d_'+IntTostr(Gzmbh) +'_footage where processage >=0  ';
     end else if Flag=1 then  begin
        CSql:= ' select Max(Footday) as TDA from  d_'+IntTostr(Gzmbh) +'_footage where processage =1  ';
     end;



      MyDataSet.Close ;
      MyDataSet.CommandText :=CSql;
      if MyDataSet.Open  then
         if MyDataSet.RecordCount >0  then
         Result:= MyDataSet.FieldByName('TDA').AsDateTime;

   finally
     MyDataSet.Close ;
     FreeAndNil(MyDataSet);
   end;


end;

function TGzm.GetNowFootAge(var SumDownFootage,
  SumUpperFootage: double): Boolean;
var
  sql:string;
  Gzm_DataSet1:TMydataset;
begin
    Gzm_DataSet1:=TmyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn ;
    Result:=false;
    SumDownFootage:=0; SumUpperFootage:=0;
     try
       sql:='select Sumdownfootage, Sumupperfootage  from  D_' +Trim(intToStr(Gzmbh)) +'_footage '+
               ' where  footday <=''' +FormatDateTime('yyyy-mm-dd hh:nn:ss',now) +
               ''' and processage >0 order by footday desc limit 1 ' ;
        Gzm_DataSet1.Close ;
        Gzm_DataSet1.CommandText:=sql;
        if Gzm_DataSet1.Open then
            if Gzm_DataSet1.RecordCount>0 then  begin
               SumDownFootage:=Gzm_DataSet1.FieldByName('Sumdownfootage').AsFloat;
               SumUpperFootage:=Gzm_DataSet1.FieldByName('Sumupperfootage').AsFloat;
            end;

        Gzm_DataSet1.Close ;
        if (SumDownFootage>0) and (SumUpperFootage>0) then Result:=true;
        Gzm_DataSet1.free;
     except
       on e:exception do begin
        Public_Basic.MY_WriteLog('Eorr:GetNowFootAge,'+sql+e.Message,'[TGZM]');
       end;
     end;
end;

function TGzm.GetOldComePress(JInchi: double): Boolean;
var
  Jinc,uStep:integer;
begin
     jinc:=round(JInchi);
     uStep:=round(self.Old_Step[2]);
     if (jinc mod uStep <1 ) or (jinc mod uStep> uStep-1)
         then  result:=true
         else  result:=false

end;

function TGzm.GetSupportInfoToText(insu: TWorkFaceBuillSupport): String;
Var
   StrTemp:String;
begin
        if insu.Zj_Name='' then  exit;

        StrTemp:=insu.Zj_leixing+',';   //����        1
        StrTemp:=StrTemp+insu.Zj_Name+','; //�ͺ�      2
        StrTemp:=StrTemp+FormatFloat('.##',insu.Zj_zhongxinju)+','; //  ֧�����ľ�   3
        StrTemp:=StrTemp+FormatFloat('.##',insu.Zj_KongdingJU)+','; //  �ض���    4
        StrTemp:=StrTemp+FormatFloat('.##',insu.Zj_hlzyd)+','; //  �������õ�    5
        StrTemp:=StrTemp+IntToStr(insu.Zj_Lizhu_count)+','; //  ��������        6
        StrTemp:=StrTemp+FormatFloat('.##',insu.Zj_suoliang)+','; //  ����ѹ����   7
        StrTemp:=StrTemp+FormatFloat('.##',insu.Zj_toall_F)+','; //  �迹��      8
        StrTemp:=StrTemp+FormatFloat('.##',insu.zj_toall_P)+','; //  ֧��ǿ��     9
        StrTemp:=StrTemp+FormatFloat('.##',insu.Zj_hubang_h)+','; // ����߶�     10
        StrTemp:=StrTemp+FormatFloat('.##',insu.zj_hubang_P)+','; //  ����ǿ��    11
        StrTemp:=StrTemp+FormatFloat('.##',insu.Lz_Diameter)+','; //  ����ֱ��    12
        StrTemp:=StrTemp+FormatFloat('.##',insu.initLoad)+','; //  ������    13
        StrTemp:=StrTemp+FormatFloat('.##',insu.EndOpenLoad)+','; //  Һѹ������    14
        Result:=StrTemp;
end;

function TGzm.GetSupportStr(var SupStr: String): Boolean;
Var
   StrTemp:String;

begin
       Result:=False;
       if Usedsupport.Zj_Name='' then  exit;

        StrTemp:='ZJ:'+Usedsupport.Zj_leixing+',';   //����
        StrTemp:=StrTemp+Usedsupport.Zj_Name+','; //�ͺ�
        StrTemp:=StrTemp+FormatFloat('.##',Usedsupport.Zj_zhongxinju)+','; //  ֧�����ľ�
        StrTemp:=StrTemp+FormatFloat('.##',Usedsupport.Zj_KongdingJU)+','; //  �ض���
        StrTemp:=StrTemp+FormatFloat('.##',Usedsupport.Zj_hlzyd)+','; //  �������õ�
        StrTemp:=StrTemp+IntToStr(Usedsupport.Zj_Lizhu_count)+','; //  ��������
        StrTemp:=StrTemp+FormatFloat('.##',Usedsupport.Zj_suoliang)+','; //  ����ѹ����
        StrTemp:=StrTemp+FormatFloat('.##',Usedsupport.Zj_toall_F)+','; //  �迹��
        StrTemp:=StrTemp+FormatFloat('.##',Usedsupport.zj_toall_P)+','; //  ֧��ǿ��
        StrTemp:=StrTemp+FormatFloat('.##',Usedsupport.Zj_hubang_h)+','; // ����߶�
        StrTemp:=StrTemp+FormatFloat('.##',Usedsupport.zj_hubang_P)+','; //  ����ǿ��
        StrTemp:=StrTemp+FormatFloat('.##',Usedsupport.Lz_Diameter)+','; //  ����ֱ��

        SupStr:=StrTemp;
       Result:=true;
end;

function TGzm.ReadCoalPliiarXml( CoalPillarInfo,UpdateOrInsert: string):String;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
   ChildChildRoot,ChildChildChildRoot:TXmlNode;
   inn_CoalPillat:array of TCoalPillar;
   i:integer;
   gzmid:integer;
   ss:Boolean;
   WkF:String;
begin
    MyXml:=TNativeXml.Create(nil);
    MyXml.ReadFromString(CoalPillarInfo);
    RootNode := MyXml.Root.NodeFindOrCreate('Custom');
    kuangjingid :=self.SelKuangjingBianHao(UTF8ToString(RootNode.NodeFindOrCreate('MineName').Value));
    ChildRoot:= RootNode.NodeFindOrCreate('WorkFaceName');
    WkF:= ChildRoot.Value ;
    gzmid :=self.IsExistWorkFace(kuangjingid,WkF) ;
    if gzmid=-1 then   begin
       Result:='��������Ϣû���ҵ�';
       exit;
    end;

    cCoalPillar:= ChildRoot.ChildContainerCount;
    Setlength(inn_CoalPillat ,cCoalPillar);

     for I := 0 to cCoalPillar-1 do    begin
          inn_CoalPillat[i]:=TCoalPillar.Create ;

          ChildChildRoot:=ChildRoot.NodeFindOrCreate('CoalPillarNo:'+Trim(intToStr(i+1)));
          inn_CoalPillat[i].Mineid:=kuangjingid;
          inn_CoalPillat[i].gzmidbh:=gzmid;
          inn_CoalPillat[i].Name:= UTF8ToString(ChildChildRoot.NodeFindOrCreate('CoalPillarName').Value);
          inn_CoalPillat[i].location := TGzmLocation(GetEnumValue(TypeInfo(TGzmLocation),ChildChildRoot.NodeFindOrCreate('location').Value));
          inn_CoalPillat[i].width:= ChildChildRoot.NodeFindOrCreate('CoalPillarWidth').ValueAsFloat;
          inn_CoalPillat[i].length:= ChildChildRoot.NodeFindOrCreate('CoalPillarlength').ValueAsFloat;
          inn_CoalPillat[i].heigth := ChildChildRoot.NodeFindOrCreate('CoalPillarHeigth').ValueAsFloat;
          inn_CoalPillat[i].dis_left:= ChildChildRoot.NodeFindOrCreate('DistanceLeftSide').ValueAsFloat;
          inn_CoalPillat[i].dis_right:= ChildChildRoot.NodeFindOrCreate('DistanceRightSide').ValueAsFloat;
          inn_CoalPillat[i].dis_front:= ChildChildRoot.NodeFindOrCreate('DistanceFrontSide').ValueAsFloat;
          inn_CoalPillat[i].dis_behind:= ChildChildRoot.NodeFindOrCreate('DistanceBehindSide').ValueAsFloat;
          inn_CoalPillat[i].dis_top:= ChildChildRoot.NodeFindOrCreate('DistanceTopCoalSeam').ValueAsFloat;
          inn_CoalPillat[i].dis_bottom:= ChildChildRoot.NodeFindOrCreate('DistanceUnderCoalSeam').ValueAsFloat;
          inn_CoalPillat[i].safedistance:= ChildChildRoot.NodeFindOrCreate('ForCaseSaftDistance').ValueAsFloat;

           if (self.isCoalPillarExist (WkF,inn_CoalPillat[i].Name ) = -1) and
                (UpdateOrInsert='Refresh') then  begin
               SS:=self.InsertCoalPillarToDataBase(inn_CoalPillat[i]) ;
           end else if (self.isCoalPillarExist (WkF,inn_CoalPillat[i].Name ) >0 ) and
                (UpdateOrInsert='Refresh') then begin
               SS:=self.UpdateCoalPillarToDataBase(inn_CoalPillat[i]) ;
           end else if (self.isCoalPillarExist (WkF,inn_CoalPillat[i].Name ) >0 ) and
                (UpdateOrInsert='Delete') then begin
               SS:=self.DeleteColPillar(inn_CoalPillat[i]) ;
           end;
            if ss then   begin
               Result:=''
            end  else  begin
              Result:='���ݶ�д����';
              exit;
            end;
     end;

    Result:='';
     for I := 0 to cCoalPillar-1 do
           inn_CoalPillat[i].Free ;
     cCoalPillar:=0;
     MyXml.Free;

end;

function TGzm.ReadData: Boolean;
Var
  GzmStr,ZkStr,SupStr:String;
begin
     Result:=false;
     if not InputGzmData(Gzmbh)  then begin
          Public_Basic.MY_WriteLog('Eorr: ReadData/InputGzmData','[TGZM]');
          exit;
     end;
    if  not InputGzmFalut(Gzmbh)  then begin
          Public_Basic.MY_WriteLog('Eorr: ReadData/InputGzmFalut','[TGZM]');
          exit;
    end;
     if  not InputGzmAreaOut(Gzmbh) then begin
          Public_Basic.MY_WriteLog('Eorr: ReadData/InputGzmAreaOut','[TGZM]');
          exit;
    end;
    if   not InputGzmCoalPillar(Gzmbh)then begin
          Public_Basic.MY_WriteLog('Eorr: ReadData/InputGzmCoalPillar','[TGZM]');
          exit;
    end;
    if(not self.FillGzmBulidInfo) then  begin
         Public_Basic.MY_WriteLog('Eorr: ReadData/FillGzmBulidInfo','[TGZM]');
          exit;
    end;
    if (not IntiArrayDrec ) then begin
         Public_Basic.MY_WriteLog('Eorr: ReadData/IntiArrayDrec','[TGZM]');
          exit;
    end;

//     if not InputGzmData(Gzmbh) then exit;
//     if not InputGzmFalut(Gzmbh) then exit;
//     if not InputGzmAreaOut(Gzmbh) then exit;
//     if not InputGzmCoalPillar(Gzmbh) then exit;
//            //ͨ������Ϣȷ����� ��֧�ܵ�λ��
//     if not  self.FillGzmBulidInfo then exit;
//             // ֧���Ѿ�������ϡ������Ҫ refreshfootageˢ��
     Result:=true;

end;

function TGzm.ReadDrillInfo(XmlString, RefreahOrDelete: string): String;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
   ChildChildRoot,ChildChildChildRoot:TXmlNode;
   inn_D:Tzk_bore;
   i:integer;
   CoalName,CoalSeamName:String;
   ss:Boolean;
begin
    inn_D:=Tzk_bore.Create;
    MyXml:=TNativeXml.Create(nil);
    MyXml.ReadFromString(Xmlstring);
    RootNode := MyXml.Root.NodeFindOrCreate('Custom');
    CoalName :=Trim(Uppercase(UTF8ToString(RootNode.NodeFindOrCreate('MineName').Value)));
    inn_d.Mineid :=self.SelKuangjingBianHao(CoalName);
    inn_d.Zk_name:= Trim(Uppercase(UTF8ToString(RootNode.NodeFindOrCreate('DrillName').Value)));

    ChildRoot:= RootNode.NodeFindOrCreate('DrillName');
    inn_d.Zk_Yc_Count:= ChildRoot.ChildContainerCount;
     //
      Setlength(inn_D.Yc_Rock ,inn_d.Zk_Yc_Count);
    //

     for I := 0 to inn_d.Zk_Yc_Count-1 do    begin
          inn_D.Yc_Rock[i]:=TYc_Rock.Create ;
          ChildChildRoot:=ChildRoot.NodeFindOrCreate('DrillNO:'+intToStr(i+1));
          inn_D.Yc_Rock[i].R_Name:=UTF8ToString(ChildChildRoot.NodeFindOrCreate('YockName').Value);
          inn_D.Yc_Rock[i].R_h:=ChildChildRoot.NodeFindOrCreate('YockThickness').ValueAsFloat;
          inn_D.Yc_Rock[i].R_kyqd:=ChildChildRoot.NodeFindOrCreate('YockComrressStrength').ValueAsFloat;
          inn_D.Yc_Rock[i].R_klqd:=ChildChildRoot.NodeFindOrCreate('YockTensileStrength').ValueAsFloat;
          inn_D.Yc_Rock[i].R_r:=ChildChildRoot.NodeFindOrCreate('YockBulkDensity').ValueAsFloat;
           if ChildChildRoot.NodeFindOrCreate('YockMinableSeam').ValueAsInteger=1 then
              inn_D.Yc_Rock[i].M_Kc_YandN:=true else inn_D.Yc_Rock[i].M_Kc_YandN:=False;
          CoalSeamName:= UTF8ToString(ChildChildRoot.NodeFindOrCreate('CoalSeamName').Value);
          if (inn_D.Yc_Rock[i].M_Kc_YandN) and (length(Trim(CoalSeamName))>0 )  then begin
             inn_D.Yc_Rock[i].MCId:=self.SelecCoalSeamid(CoalSeamName,inn_d.Mineid);
          end else if   (inn_D.Yc_Rock[i].M_Kc_YandN) and (length(Trim(CoalSeamName))<1 ) then  begin
             Result:= 'û�и��ɲ�ú��¼��ú����';
             exit;
          end else begin
              inn_D.Yc_Rock[i].MCId:=0;
          end;
     end;
    //
//    if (self.IsExistDrillInfo (inn_d.Zk_name ) = -1) and (UpdateOrInsert='insert' )then  begin
//         SS:=self.InsertDrillDataBase(inn_D) ;
//     end else if (IsExistDrillInfo(inn_d.Zk_name )>0 ) and (UpdateOrInsert='update' ) then begin
//         SS:=self.UpdateDrillDateBase(inn_D);
//     end;
    if (self.IsExistDrillInfo (inn_d.Zk_name ) = -1)  and (UpperCase(RefreahOrDelete)='REFRESH')then  begin
         SS:=self.InsertDrillDataBase(inn_D) ;
     end else if (IsExistDrillInfo(inn_d.Zk_name )>0) and (UpperCase(RefreahOrDelete)='REFRESH')  then begin
         SS:=self.UpdateDrillDateBase(inn_D);
     end else if (IsExistDrillInfo(inn_d.Zk_name )>0) and (UpperCase(RefreahOrDelete)='DELETE')  then begin
         SS:=self.DeleteDrillInfo(inn_D);
     end;
     //�����ж�
     if ss then    Result:=''
     else   Result:='���ݶ�д����';

    Result:='';
    // free
    inn_D.Free ;
end;

function TGzm.ReadFaultXml( FaultInfo, UpdateOrInsert: string): string;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
   ChildChildRoot,ChildChildChildRoot:TXmlNode;
   inn_Fault:array of TFault;
   i:integer;
   gzmid:integer;
   ss:Boolean;
   WkF,Faulttype:String;
begin
    MyXml:=TNativeXml.Create(nil);
    MyXml.ReadFromString(FaultInfo);
    RootNode := MyXml.Root.NodeFindOrCreate('Custom');
    Kuangjingid :=self.SelKuangjingBianHao(UTF8ToString(RootNode.NodeFindOrCreate('MineName').Value));
    ChildRoot:= RootNode.NodeFindOrCreate('WorkFaceName');
    WkF:= ChildRoot.Value ;
    gzmid :=self.IsExistWorkFace(kuangjingid,WkF) ;
    if gzmid=-1 then   begin
       Result:='��������Ϣû���ҵ�';
       exit;
    end;

    cFault:= ChildRoot.ChildContainerCount;
    Setlength(inn_Fault ,cFault);

     for I := 0 to cFault-1 do    begin
          inn_Fault[i]:=TFault.Create ;

          ChildChildRoot:=ChildRoot.NodeFindOrCreate('FaultNo:'+Trim(intToStr(i+1)));
          inn_Fault[i].Mineid:=Kuangjingid;
          inn_Fault[i].gzmbh:=gzmid;

          inn_Fault[i].Name:= UTF8ToString(ChildChildRoot.NodeFindOrCreate('FaultName').Value);
          inn_Fault[i].location := TGzmLocation(GetEnumValue(TypeInfo(TGzmLocation),ChildChildRoot.NodeFindOrCreate('location').Value));
          Faulttype:= ChildChildRoot.NodeFindOrCreate('FaultType').value;
          if Faulttype='���ϲ�' then   begin
              inn_Fault[i].faulttype:=1;
          end else begin
              inn_Fault[i].faulttype:=2;
          end;

          inn_Fault[i].divide:= ChildChildRoot.NodeFindOrCreate('FaultDivide').ValueAsFloat;
          inn_Fault[i].MinToOffCut:= ChildChildRoot.NodeFindOrCreate('MinToOpenCutLine').ValueAsFloat;
          inn_Fault[i].MaxToOffCut := ChildChildRoot.NodeFindOrCreate('MaxToOpenCutLine').ValueAsFloat;
          inn_Fault[i].safedistance:= ChildChildRoot.NodeFindOrCreate('ForCaseSaftDistance').ValueAsFloat;

           if (self.isFaultExist (WkF,inn_Fault[i].Name ) = -1) and (UpdateOrInsert='Refresh' ) then  begin
               SS:=self.InsertFaultToDataBase(inn_Fault[i]) ;
           end else if (self.isFaultExist (WkF,inn_Fault[i].Name ) >0 ) and (UpdateOrInsert='Refresh' ) then begin
               SS:=self.UpdateFaultToDataBase(inn_Fault[i]) ;
           end else if (self.isFaultExist (WkF,inn_Fault[i].Name ) >0 ) and (UpdateOrInsert='Delete' ) then begin
               SS:=self.DeleteFault(inn_Fault[i]) ;
           end;
            if ss then   begin
               Result:=''
            end  else  begin
              Result:='���ݶ�д����';
              exit;
            end;
     end;

    Result:='';
     for I := 0 to cFault-1 do
           inn_Fault[i].Free ;
     cFault:=0;
     MyXml.Free;


end;

function TGzm.ReadFootageDataToRockDataGrid(StrGrid1,
         StrGrid2,StrGridShodow: TstringGrid;MinDaoshu:integer): Boolean;
Var
   CSql:String;
   MyDataSet:TMyDataSet;
   Row:integer;
begin
    Result:=false;

   try
    MyDataSet:=TMyDataSet.create(nil);
    MyDataSet.MySqlConnection:= MyExConn;

      CSql:= ' select * from  d_'+IntTostr(Gzmbh) +'_footage where processage>=0 '+
             ' and  Daoshu>= ' +IntTostr(MinDaoshu) +
             ' order by Daoshu';
      MyDataSet.Close ;
      MyDataSet.CommandText :=CSql;
      Row:=2;
      if MyDataSet.Open  then
         if MyDataSet.RecordCount >0  then
         while not MyDataSet.Eof  do  begin
            StrGrid1.Cells[0,Row]:=IntTostr(Row-1);
            StrGrid1.Cells[1,Row]:=FormatDateTime('yyyy-mm-dd HH:nn:ss',MyDataSet.FieldByName('footday').AsDateTime);
            StrGrid1.Cells[2,Row]:=IntToStr(MyDataSet.FieldByName('Daoshu').AsInteger);
            StrGrid1.Cells[3,Row]:=FormatFloat('0.00',MyDataSet.FieldByName('sumdownfootage').AsFloat);

            StrGrid2.Cells[1,Row]:=IntToStr(MyDataSet.FieldByName('Daoshu').AsInteger);
            StrGrid2.Cells[0,Row]:=FormatFloat('0.00',MyDataSet.FieldByName('sumdownfootage').AsFloat);

            Row:=Row+1;
            StrGrid1.RowCount:=Row+2;
            StrGrid2.RowCount:=Row+2;
            StrGridShodow.RowCount:=Row+2;

            MyDataSet.Next ;
         end;

      MyDataSet.Close ;
      Result:=true;
   finally
     FreeAndNil(MyDataSet);
   end;


end;

function TGzm.ReadFootageDataToStringGrid(StrGrid: TstringGrid;EndTime:String): Boolean;
Var
   CSql:String;
   MyDataSet:TMyDataSet;
   Row:integer;
begin
    Result:=false;
    { footday,Daoshu,downfootage,sumdownfootage,EditDownFootage, '+
              ' upperfootage,sumupperfootage,EditUpperFootage,processage}
   try
    MyDataSet:=TMyDataSet.create(nil);
    MyDataSet.MySqlConnection:= MyExConn;

      CSql:= ' select * from  d_'+IntTostr(Gzmbh) +'_footage where processage=1  ' +
         ' and footday > ' + EndTime + '  order by Daoshu';
      MyDataSet.Close ;
      MyDataSet.CommandText :=CSql;
      Row:=2;
      if MyDataSet.Open  then
         if MyDataSet.RecordCount >0  then
         while not MyDataSet.Eof  do  begin
            StrGrid.Cells[0,Row]:=IntTostr(Row-1);
            StrGrid.Cells[1,Row]:=FormatDateTime('yyyy-mm-dd HH:nn:ss',MyDataSet.FieldByName('footday').AsDateTime);
            StrGrid.Cells[2,Row]:=IntToStr(MyDataSet.FieldByName('Daoshu').AsInteger);
            StrGrid.Cells[3,Row]:=FormatFloat('0.000',MyDataSet.FieldByName('downfootage').AsFloat);
            StrGrid.Cells[4,Row]:=FormatFloat('0.00',MyDataSet.FieldByName('sumdownfootage').AsFloat);
            if MyDataSet.FieldByName('EditDownFootage').AsFloat=0 then begin
               StrGrid.Cells[5,Row]:='';
            end else begin
               StrGrid.Cells[5,Row]:=FormatFloat('0.00',MyDataSet.FieldByName('EditDownFootage').AsFloat);
            end;
            //
            if MyDataSet.FieldByName('EditUpperFootage').AsFloat=0 then begin
               StrGrid.Cells[7,Row]:='';
            end else begin
               StrGrid.Cells[7,Row]:=FormatFloat('0.00',MyDataSet.FieldByName('EditUpperFootage').AsFloat);
            end;
            StrGrid.Cells[8,Row]:=FormatFloat('0.00',MyDataSet.FieldByName('sumupperfootage').AsFloat);
            StrGrid.Cells[9,Row]:=FormatFloat('0.000',MyDataSet.FieldByName('upperfootage').AsFloat);
            StrGrid.Cells[10,Row]:=IntToStr(MyDataSet.FieldByName('Daoshu').AsInteger);

            Row:=Row+1;
            StrGrid.RowCount:=Row+2;
            MyDataSet.Next ;
         end;

      MyDataSet.Close ;
      Result:=true;
   finally
     FreeAndNil(MyDataSet);
   end;

end;

function TGzm.ReadMineOutAreaXml(MineOutAreaInfo,
  UpdateOrInsert: string): string;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
   ChildChildRoot,ChildChildChildRoot:TXmlNode;
   inn_MineOutArea:array of TMineOutArea;
   i:integer;
   gzmid:integer;
   ss:Boolean;
   WkF:String;
begin
    MyXml:=TNativeXml.Create(nil);
    MyXml.ReadFromString(MineOutAreaInfo);
    RootNode := MyXml.Root.NodeFindOrCreate('Custom');
    kuangjingid :=self.SelKuangjingBianHao(UTF8ToString(RootNode.NodeFindOrCreate('MineName').Value));
    ChildRoot:= RootNode.NodeFindOrCreate('WorkFaceName');
    WkF:= ChildRoot.Value ;
    gzmid :=self.IsExistWorkFace(kuangjingid,WkF) ;
    if gzmid=-1 then   begin
       Result:='��������Ϣû���ҵ�';
       exit;
    end;

    cMineOutArea:= ChildRoot.ChildContainerCount;
    Setlength(inn_MineOutArea ,cMineOutArea);

     for I := 0 to cMineOutArea-1 do    begin
          inn_MineOutArea[i]:=TMineOutArea.Create ;

          ChildChildRoot:=ChildRoot.NodeFindOrCreate('MineOutAreaNo:'+Trim(intToStr(i+1)));
          inn_MineOutArea[i].Mineid:=kuangjingid;
          inn_MineOutArea[i].Gzmid:=gzmid;
          inn_MineOutArea[i].Name:= UTF8ToString(ChildChildRoot.NodeFindOrCreate('MineOutAreaName').Value);
          inn_MineOutArea[i].location := TGzmLocation(GetEnumValue(TypeInfo(TGzmLocation),ChildChildRoot.NodeFindOrCreate('location').Value));
          inn_MineOutArea[i].Outtime:= ChildChildRoot.NodeFindOrCreate('MineOutAreaOuttime').ValueAsDateTime;
          inn_MineOutArea[i].width:= ChildChildRoot.NodeFindOrCreate('MineOutAreaWidth').ValueAsFloat;
          inn_MineOutArea[i].length:= ChildChildRoot.NodeFindOrCreate('MineOutArealength').ValueAsFloat;
          inn_MineOutArea[i].heigth := ChildChildRoot.NodeFindOrCreate('MineOutAreaHeigth').ValueAsFloat;
          inn_MineOutArea[i].dis_left:= ChildChildRoot.NodeFindOrCreate('DistanceLeftSide').ValueAsFloat;
          inn_MineOutArea[i].dis_right:= ChildChildRoot.NodeFindOrCreate('DistanceRightSide').ValueAsFloat;
          inn_MineOutArea[i].dis_front:= ChildChildRoot.NodeFindOrCreate('DistanceFrontSide').ValueAsFloat;
          inn_MineOutArea[i].dis_behind:= ChildChildRoot.NodeFindOrCreate('DistanceBehindSide').ValueAsFloat;
          inn_MineOutArea[i].dis_top:= ChildChildRoot.NodeFindOrCreate('DistanceTopCoalSeam').ValueAsFloat;
          inn_MineOutArea[i].dis_bottom:= ChildChildRoot.NodeFindOrCreate('DistanceUnderCoalSeam').ValueAsFloat;
          inn_MineOutArea[i].safedistance:= ChildChildRoot.NodeFindOrCreate('ForCaseSaftDistance').ValueAsFloat;

          if (self.isMineOutAreaExist (WkF,inn_MineOutArea[i].Name ) = -1)
               and (UpdateOrInsert='Refresh') then  begin
               SS:=self.InsertMineOutAreaToDataBase(inn_MineOutArea[i]) ;
           end else if (self.isMineOutAreaExist (WkF,inn_MineOutArea[i].Name ) >0 )
               and  (UpdateOrInsert='Refresh') then begin
               SS:=self.UpdateMineOutAreaToDataBase(inn_MineOutArea[i]) ;
           end else if (self.isMineOutAreaExist (WkF,inn_MineOutArea[i].Name ) >0 )
               and  (UpdateOrInsert='Delete') then begin
               SS:=self.DeleteMineOutArea(inn_MineOutArea[i]) ;
           end;
            if ss then   begin
               Result:=''
            end  else  begin
              Result:='���ݶ�д����';
              exit;
            end;
     end;

    Result:='';
     for I := 0 to cMineOutArea-1 do
           inn_MineOutArea[i].Free ;
     cMineOutArea:=0;
     MyXml.Free;


end;

function TGzm.ReadRockPressDataToStrGrid(StrGrid1,StrGrid2,StrGridShodow: TStringGrid;
                 MinDaoshu,Unit_Flag,ValueType:integer): Boolean;
Var
   CSql:String;
   MyDataSet:TMyDataSet;
   Row,Col:integer;
   FieldStr:String;
begin
   Result:=false;
   FieldStr:=self.ReturnManualInputPressDataField(ValueType);
   try
    MyDataSet:=TMyDataSet.create(nil);
    MyDataSet.MySqlConnection:= MyExConn;

      CSql:= ' select * from  d_'+IntTostr(Gzmbh) +'_ManualInputPressData  ' +
             ' where  Daoshu >= ' +IntToStr(MinDaoshu) +
             ' order by Daoshu,supportbh';
      MyDataSet.Close ;
      MyDataSet.CommandText :=CSql;
      Row:=2;Col:=4;
      if MyDataSet.Open  then
         if MyDataSet.RecordCount >0  then
         while not MyDataSet.Eof  do  begin
            if Public_Basic.StrToInt_lu(StrGrid1.Cells[2,Row])<>MyDataSet.FieldByName('Daoshu').AsInteger then begin
               Row:=Row+1;Col:=4;
            end;

            while Col<  StrGrid1.ColCount do
                if (Public_Basic.StrToInt_lu(StrGrid1.Cells[2,Row])=MyDataSet.FieldByName('Daoshu').AsInteger )  then  begin
                    if Public_Basic.StrToInt_lu(StrGrid1.Cells[Col,1])=MyDataSet.FieldByName('Supportbh').AsInteger    then   begin
                        if Unit_Flag=1 then begin
                            StrGrid1.Cells[Col,Row]:=FormatFloat('0.00',MyDataSet.FieldByName(FieldStr).AsFloat);
                        end else if Unit_Flag=2 then begin
                            StrGrid1.Cells[Col,Row]:=FormatFloat('0.00',MyDataSet.FieldByName(FieldStr).AsFloat*10);
                        end;
                       if Trim(MyDataSet.FieldByName('Memo1').AsString)<>'' then
                           StrGrid2.Cells[Col,Row]:=MyDataSet.FieldByName('Memo1').AsString;
                       Col:=Col+1;
                       break;
                    end else begin
                       Col:=Col+1;
                    end;

                end else begin
                   break;
                end;

            if Row>= StrGrid1.RowCount-1 then  break;
            MyDataSet.Next ;
         end;

      MyDataSet.Close ;
      Result:=true;
   finally
     FreeAndNil(MyDataSet);
   end;


end;

function TGzm.ReadSupportInfo(SupportInfo: string;UpdateOrInsert:string): String;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
   inn_S:TSupportStep;
   i:integer;
   CoalName,CoalSeamName:String;
   ss:Boolean;
begin

    inn_S:=TSupportStep.Create;
    MyXml:=TNativeXml.Create(nil);
    MyXml.ReadFromString(SupportInfo);
    RootNode := MyXml.Root.NodeFindOrCreate('Custom');
    CoalName :=UTF8ToString(RootNode.NodeFindOrCreate('MineName').Value);

    inn_S.Zj_Name:= UTF8ToString(RootNode.NodeFindOrCreate('SupportName').Value);
    inn_S.Zj_leixing:= UTF8ToString(RootNode.NodeFindOrCreate('SupportType').Value);
    inn_S.Zj_Lizhu_count:= RootNode.NodeFindOrCreate('SupportColumnNumber').ValueAsInteger;
    inn_S.Zj_toall_F:= RootNode.NodeFindOrCreate('MaxResistance').ValueAsFloat;
    inn_S.zj_toall_P:= RootNode.NodeFindOrCreate('MaxStrength').ValueAsFloat;
    inn_S.Zj_suoliang:= RootNode.NodeFindOrCreate('MaxDropOff').ValueAsFloat;
    inn_S.Zj_KongdingJU:= RootNode.NodeFindOrCreate('SupportedRoofSpan').ValueAsFloat;
    inn_S.Zj_zhongxinju:= RootNode.NodeFindOrCreate('SupportCenterdistance').ValueAsFloat;
    inn_S.Zj_hlzyd:= RootNode.NodeFindOrCreate('ResultantForcePoint').ValueAsFloat;
    inn_S.Lz_Diameter:= RootNode.NodeFindOrCreate('ColumnDiameter').ValueAsFloat;
    inn_S.initLoad:= RootNode.NodeFindOrCreate('SupportInitLoad').ValueAsFloat;
    inn_S.EndOpenLoad:= RootNode.NodeFindOrCreate('SupportEndOpenLoad').ValueAsFloat;

   if (self.isExistSupportName(inn_S.Zj_Name ) = -1) and (UpdateOrInsert='Refresh' )then  begin
         SS:=self.InsertSupportToDataBase(inn_S);
     end else if (isExistSupportName(inn_S.Zj_Name )>0 ) and (UpdateOrInsert='Refresh' ) then begin
        SS:=self.UpdateSupportToDataBase(inn_S);
     end else if (isExistSupportName(inn_S.Zj_Name )>0 ) and (UpdateOrInsert='Delete' ) then begin
        SS:=self.Deletesupport(inn_S);
     end;

   inn_s.Free ;
   MyXml.Free;

end;

function TGzm.ReadWorkFaceSelectDrill(WorkFaceName, DrillsInfo: String): String;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
   ChildChildRoot:TXmlNode;
   i,gzmid:integer;
   CoalName,DrillName:String;
   ss:Boolean;
begin
   Result:='';
   MyXml:=TNativeXml.Create(nil);
    MyXml.ReadFromString(DrillsInfo);
    RootNode := MyXml.Root.NodeFindOrCreate('Custom');
    CoalName :=Trim(Uppercase(UTF8ToString(RootNode.NodeFindOrCreate('MineName').Value)));
    kuangjingId:= SelKuangjingBianHao(CoalName);

    S_Name :=Trim(Uppercase(UTF8ToString(RootNode.NodeFindOrCreate('WorkFaceName').Value)));
    gzmid:=IsExistWorkFace(kuangjingId,S_Name);
    if gzmid=-1 then    begin
        Result:='û�в鵽'+S_Name +'��������Ϣ';
        exit;
    end;

    ChildRoot:=RootNode.NodeFindOrCreate('WorkFaceName');
    BuilledDrillNumber :=ChildRoot.ChildContainerCount;
    Setlength(self.BuilledDrillType ,BuilledDrillNumber);
    for I :=0 to BuilledDrillNumber-1 do  begin
         BuilledDrillType[i]:=TWorkFaceBuillDrill.Create;
         ChildChildRoot:=ChildRoot.NodeFindOrCreate('DrillName_'+inttoStr(i+1));
         DrillName:=Trim(Uppercase(UTF8ToString(ChildChildRoot.Value )));
         BuilledDrillType[i].zkid :=self.IsExistDrillInfo(DrillName) ;
         if BuilledDrillType[i].NO =-1  then   begin
            Result:='û�в鵽'+DrillName+'�����Ϣ';
            exit;
         end;
        if  not CheckWorkFaceLinkDrillYresOrNo(Gzmid,BuilledDrillType[i].zkid ) then  begin
            Result:='������ú����Ϣ�����ú����Ϣ��ƥ��';
            exit;
        end;
        BuilledDrillType[i].NO :=i+1;
        BuilledDrillType[i].startdistance :=ChildChildRoot.NodeFindOrCreate('startdistance').ValueAsFloat;
        BuilledDrillType[i].enddistance :=ChildChildRoot.NodeFindOrCreate('enddistance').ValueAsFloat;

    end;
     if BuilledDrillNumber >0 then
       if not  self.InsertWorkfaceSelectDrillDataBase(gzmid) then begin
          Result:='���ݴ洢����';
          exit;
       end;

    MyXml.Free;
    Result:='';

end;

function TGzm.ReadWorkFaceSelectsupport(WorkFaceName,
  supportInfo: String): String;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
   ChildChildRoot:TXmlNode;
   i,gzmid:integer;
   CoalName,supportName:String;
   ss:Boolean;
begin
   Result:='';
   MyXml:=TNativeXml.Create(nil);
    MyXml.ReadFromString(supportInfo);
    RootNode := MyXml.Root.NodeFindOrCreate('Custom');
    CoalName :=UTF8ToString(RootNode.NodeFindOrCreate('MineName').Value);
    kuangjingId:= SelKuangjingBianHao(CoalName);

    S_Name :=UTF8ToString(RootNode.NodeFindOrCreate('WorkFaceName').Value);
    gzmid:=IsExistWorkFace(kuangjingId,S_Name);
    if gzmid=-1 then    begin
        Result:='û�в鵽'+S_Name +'��������Ϣ';
        exit;
    end;

    ChildRoot:=RootNode.NodeFindOrCreate('WorkFaceName');
    BuilledSupportNumber :=ChildRoot.ChildContainerCount;
    Setlength(self.BuilledSupportType ,BuilledSupportNumber);
    for I :=0 to BuilledSupportNumber-1 do  begin
         BuilledSupportType[i]:=TWorkFaceBuillSupport.Create;
         ChildChildRoot:=ChildRoot.NodeFindOrCreate('SupportName_'+inttoStr(i+1));
         supportName:=UTF8ToString(ChildChildRoot.Value );
         BuilledSupportType[i].Supportid :=self.isExistSupportName(supportName);
         if BuilledSupportType[i].NO =-1  then   begin
            Result:='û�в鵽'+supportName+'֧����Ϣ';
            exit;
         end;

        BuilledSupportType[i].NO :=i+1;
        BuilledSupportType[i].startSupportNo :=ChildChildRoot.NodeFindOrCreate('startSupportNo').ValueAsInteger;
        BuilledSupportType[i].endSupportNo :=ChildChildRoot.NodeFindOrCreate('endSupportNo').ValueAsInteger;
    end;
     if BuilledSupportNumber >0 then
       if not  self.InsertWorkfaceSelectSupportDataBase(gzmid) then begin
          Result:='���ݴ洢����';
          exit;
       end;

    MyXml.Free;
    Result:='';


end;

function TGzm.ReadWorkFaceXml(XmlString:String;UpdateOrInsert:string;
          Var event :string;var Newid :integer): string;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
   dRec:PWorkFace;
   SS:Boolean;
begin
     Result:=''; Newid:=0;
     MyXml:=TNativeXml.Create(nil);
     MyXml.ReadFromString(Xmlstring);
     new(dRec);
     RootNode := MyXml.Root.NodeFindOrCreate('Custom');
     dRec.MineName       :=Trim(UpperCase(UTF8ToString(RootNode.NodeFindOrCreate('MineName').Value)));
     dRec.WorkFaceName       :=Trim(UpperCase(UTF8ToString(RootNode.NodeFindOrCreate('WorkFaceName').Value)));
     dRec.CoalSeamName       :=Trim(UpperCase(UTF8ToString(RootNode.NodeFindOrCreate('CoalSeamName').Value)));
     dRec.CoalMiningHeigth   :=RootNode.NodeFindOrCreate('CoalMiningHeigth').ValueAsFloat ;
     dRec.CoalMiningMethod   :=UTF8ToString(RootNode.NodeFindOrCreate('CoalMiningMethod').Value);
     dRec.CoalseamAngle      :=RootNode.NodeFindOrCreate('CoalseamAngle').ValueAsFloat ;
     dRec.AVGBuriedDepth     :=RootNode.NodeFindOrCreate('AVGBuriedDepth').ValueAsFloat ;;
     dRec.WorkFaceLength     :=RootNode.NodeFindOrCreate('WorkFaceLength').ValueAsFloat ;
     dRec. TowardDistance    :=RootNode.NodeFindOrCreate('TowardDistance').ValueAsFloat ;
     dRec. Coalhardness      :=RootNode.NodeFindOrCreate('Coalhardness').ValueAsFloat ;
     dRec.SupStartNumber     :=RootNode.NodeFindOrCreate('SupportStartNumber').ValueAsInteger ;
     dRec.supEndNumber       :=RootNode.NodeFindOrCreate('SupportEndNumber').ValueAsInteger;
     dRec.SupDirection       :=RootNode.NodeFindOrCreate('SupportDirection').ValueAsInteger;
     dRec.TransportRoadwayFirstDrillPressLocation
                             :=RootNode.NodeFindOrCreate('TransportRoadwayFirstDrillPressLocation').ValueAsFloat ;
     dRec.TransportRoadwaySecondDrillPressLocation
                             :=RootNode.NodeFindOrCreate('TransportRoadwaySecondDrillPressLocation').ValueAsFloat ;
     dRec.PathwayRoadWayFirstDrillPressLocation
                             :=RootNode.NodeFindOrCreate('PathwayRoadWayFirstDrillPressLocation').ValueAsFloat ;
     dRec.PathwayRoadWaySecondDrillPressLocation
                             :=RootNode.NodeFindOrCreate('PathwayRoadWaySecondDrillPressLocation').ValueAsFloat ;


     kuangjingId:= SelKuangjingBianHao(dRec.Minename);
     if kuangjingId=-1 then begin
         Result:='�������ƶ�д����';
         exit; //��д���� �˳�
     end;

     if (IsExistWorkFace(kuangjingId,dRec.WorkFaceName ) = -1) and (UpdateOrInsert='Refresh' )then  begin
         SS:=self.InsertWorkFaceDataBase(dRec,Newid) ; event:='Insert' ;
     end else if (IsExistWorkFace(kuangjingId,dRec.WorkFaceName )>0 ) and (UpdateOrInsert='Refresh' ) then begin
         SS:=self.UpdateWorkFaceDataBase(dRec);  event:='Update' ;
     end else if (IsExistWorkFace(kuangjingId,dRec.WorkFaceName )>0 ) and (UpdateOrInsert='Delete' ) then begin
         SS:=self.DeleteGzmInfo(kuangjingId,dRec,Newid); event:='Delete';
     end;
     //�����ж�
     if ss then    Result:=''
     else   Result:='���ݶ�д����';

      MyXml.Free;
      dispose(dRec);
end;

function TGzm.RefreshFootage(Footage: Double): Boolean;
// ˢ�²����֣��������
var
  i:integer;
  Gzm_DataSet1:TMydataset;
begin
  Gzm_DataSet1:=TmyDataSet.create(nil);
  Gzm_DataSet1.MySqlConnection:= MyExConn ;
   Result:=False;
try
   if self.BuilledDrillNumber=0 then begin
     Public_Basic.MY_WriteLog('Eorr: RefreshFootage/BuilledDrillNumber=0','[TGZM]');
     exit;
   end;
   UsedDrillNo:=0;
   for I := 0 to BuilledDrillNumber-1 do
       if (Footage >=self.BuilledDrillType[i].startdistance ) and (Footage < self.BuilledDrillType[i].enddistance ) then  begin
          self.UsedDrillNo:=BuilledDrillType[i].Zkid;
          break;
       end;
   // Ĭ�ϵ�һ�����
  if UsedDrillNo<1 then  UsedDrillNo :=BuilledDrillType[BuilledDrillNumber-1].Zkid;

    try
      Gzm_DataSet1.Close();
      Gzm_DataSet1.CommandText:='SELECT * FROM zkb WHERE zkID = '+inttostr(UsedDrillNo);
      if Gzm_DataSet1.Open then
          if Gzm_DataSet1.RecordCount > 0 then begin
                UsedDrill.Zk_No:=Gzm_DataSet1.FieldByName('zkid').AsInteger;   //���id
                UsedDrill.Zk_name:=Gzm_DataSet1.FieldByName('zkName').AsString; //�������
                Gzm_DataSet1.Close();
                if not self.InputGzmYc(UsedDrill) then    exit;
          end;
      Result:=true;
    finally
      Gzm_DataSet1.Close();
      Gzm_DataSet1.free;
    end;
except
   On e:exception do begin
      Public_Basic.MY_WriteLog('Eorr: RefreshFootage'+e.Message,'[TGZM]');
    end;

end;

end;


function TGzm.RetrunCoalmethodbh(Name: string): integer;
begin
           if Name= '�ڲ�' then begin
               Result:=0;
            end else if Name= '�ղ�' then begin
               Result:=1;
            end else if Name= '�۲�'  then begin
               Result:=2;
            end else if Name= '�Ŷ�ú'  then begin
               Result:=3;
            end else if Name= '�ֲ㿪��(�Ϸֲ�)' then begin
               Result:=4;
            end else if Name= '�ֲ㿪��(�·ֲ�)'  then begin
               Result:=5;
            end else begin
                Result:=6;
            end;
end;

function TGzm.ReturnBalanceFootage(Daoshu,supportbh: Integer): double;
Var
   CSql:String;
   MyDataSet:TMyDataSet;
   S_Footage:double;
   DownFootage,UpperFootage:double;
begin
   S_Footage:= Daoshu*0.865;
    { footday,Daoshu,downfootage,sumdownfootage,EditDownFootage, '+
              ' upperfootage,sumupperfootage,EditUpperFootage,processage}
   try
    MyDataSet:=TMyDataSet.create(nil);
    MyDataSet.MySqlConnection:= MyExConn;

      CSql:= ' select * from  d_'+IntTostr(Gzmbh) +'_footage where processage>=0  and Daoshu= ' +IntToStr(Daoshu);
      MyDataSet.Close ;
      MyDataSet.CommandText :=CSql;

      if MyDataSet.Open  then
         if MyDataSet.RecordCount >0  then  begin
            DownFootage:=MyDataSet.FieldByName('sumdownfootage').AsFloat;
            UpperFootage:=MyDataSet.FieldByName('sumupperfootage').AsFloat;
            if SupEndNumber-SupStartNumber =0 then begin
               SupEndNumber:=200;SupStartNumber:=1;
            end;
            S_Footage:=DownFootage+(UpperFootage-DownFootage) /(SupEndNumber-SupStartNumber ) *  supportbh;
         end;

      MyDataSet.Close ;
      Result:=S_Footage;
   finally
     FreeAndNil(MyDataSet);
   end;


end;

function TGzm.ReturnCoalmethodName(bh: integer): String;
var
   s1cmfs:string;
begin
         if bh = 0  then begin
               s1cmfs := '�ڲ�';
            end else if bh = 1 then begin
               s1cmfs := '�ղ�';
            end else if bh = 2  then begin
               s1cmfs := '�۲�';
            end else if bh = 3  then begin
               s1cmfs := '�Ŷ�ú';
            end else if bh = 4  then begin
               s1cmfs := '�ֲ㿪��(�Ϸֲ�)';
            end else if bh = 5  then begin
               s1cmfs := '�ֲ㿪��(�·ֲ�)';
            end else begin
               s1cmfs := '��������';
            end;
        Result:=s1cmfs;
end;

function TGzm.ReturnCoalSeamName(CoalSeamid: integer): String;
var
  Gzm_DataSet1:TMydataset;
begin
    Gzm_DataSet1:=TmyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn ;
   try
     Result:='';
      Gzm_DataSet1.Close;
      Gzm_DataSet1.CommandText:='select Meicengming from meiceng where id ='+IntToStr(CoalSeamid)  ;
      if Gzm_DataSet1.Open then
        if Gzm_DataSet1.RecordCount>0 then
         Result:=Gzm_DataSet1.FieldByName('Meicengming').AsString;

   finally
     Gzm_DataSet1.Close;
     Gzm_Dataset1.free;
   end;

end;




function TGzm.ReturnCycleStepMaxValue(Str_td:string; Sb: integer;
  var MaxTd: TdateTime; var MaxDAta: Double): Boolean;
var
   MyDataSet:TMyDataSet;
   sql:string;
begin
   Result:=False;
   try
      MyDataSet:=TMyDataSet.create(nil);
      MyDataSet.MySqlConnection:= MyExConn;
       MyDataSet.Close ;
      Sql:=' select * from  D_'+IntToStr(Gzmbh)+'_SupportMoveInfo ' +
        ' where supportbh =' + IntTostr(sb) + ' and  EndTime >= ' + Str_td  +
        ' and StartTime <= ' +Str_td + ' order by endtime';
       MyDataSet.CommandText :=sql;

       if (MyDataSet.Open ) and (MyDataSet.RecordCount >0) then  begin
          MaxTd:=MyDataSet.FieldByName('Max_Valuetime').AsDateTime;
          MaxData:=MyDataSet.FieldByName('Max_Value').AsFloat;
          Result:=true;
       end  else begin
           MyDataSet.Close ;
           Sql:=' select * from  D_'+IntToStr(Gzmbh)+'_SupportMoveInfo ' +
                ' where supportbh =' + IntTostr(sb) + ' and  EndTime <= ' + Str_td  +
                '  order by endtime';
           MyDataSet.CommandText :=sql;

           if (MyDataSet.Open ) and (MyDataSet.RecordCount >0) then  begin
              MaxTd:=MyDataSet.FieldByName('Max_Valuetime').AsDateTime;
              MaxData:=MyDataSet.FieldByName('Max_Value').AsFloat;
              Result:=true;
           end;
       end;

   finally
      MyDataSet.Close ;
      FreeAndNil(MyDataSet);
   end;

end;

function TGzm.ReturnDaoShuBasicTime(Dt: TdateTime): Integer;
Var
   CSql,Strdt:String;
   MyDataSet:TMyDataSet;
   Row,Col:integer;
begin
   Result:=1;
   try
    MyDataSet:=TMyDataSet.create(nil);
    MyDataSet.MySqlConnection:= MyExConn;
      Strdt:=Public_Basic.ReturnDateTimeString(MainDataModule.DataType ,Dt);
      CSql:= ' select Daoshu   from  d_'+IntTostr(Gzmbh) +'_footage where processage>=0  ' +
          ' and footday <= ' + Strdt +' order by Daoshu desc' ;
      MyDataSet.Close ;
      MyDataSet.CommandText :=CSql;
      if MyDataSet.Open  then
         if MyDataSet.RecordCount >0  then
            Result:=MyDataSet.FieldByName('Daoshu').AsInteger;

      MyDataSet.Close ;
   finally
     FreeAndNil(MyDataSet);
   end;
end;

function TGzm.ReturnDataTimeFromDao(DaoShu: integer): TDateTime;
Var
   CSql:String;
   MyDataSet:TMyDataSet;
begin
   Result:=1;
   try
    MyDataSet:=TMyDataSet.create(nil);
    MyDataSet.MySqlConnection:= MyExConn;
      CSql:= ' select footday   from  d_'+IntTostr(Gzmbh) +'_footage where processage>=0  ' +
          ' and Daoshu <= ' + IntTostr(Daoshu) +' order by footday desc' ;
      MyDataSet.Close ;
      MyDataSet.CommandText :=CSql;
      if MyDataSet.Open  then
         if MyDataSet.RecordCount >0  then  begin
            Result:=MyDataSet.FieldByName('footday').AsDateTime;
         end else begin
            MyDataSet.Close ;
            CSql:= ' select footday   from  d_'+IntTostr(Gzmbh) +'_footage where processage>=0  ' +
                     ' and Daoshu >= ' + IntTostr(Daoshu) +' order by footday ' ;
            MyDataSet.Close ;
            MyDataSet.CommandText :=CSql;
            if MyDataSet.Open  then
               if MyDataSet.RecordCount >0  then  begin
                  Result:=MyDataSet.FieldByName('footday').AsDateTime;
               end;

         end;
   finally
      MyDataSet.Close ;
      FreeAndNil(MyDataSet);
   end;

end;

function TGzm.ReturnManualInputPressDataField(Value: integer): String;
begin
    if Value=0 then  begin
       Result:='Max_Value';
    end else if Value=1 then  begin
       Result:='AGV_Value';
    end else if Value=2 then  begin
       Result:='CCL_Value';
    end else if Value=3 then  begin
       Result:='MzL_Value';
    end else if Value=4 then  begin
       Result:='Same_Value';
    end else if Value=5 then  begin
       Result:='PressData';
    end;

end;

function TGzm.ReturnMaxDao: integer;
Var
   CSql:String;
   MyDataSet:TMyDataSet;
begin
   Result:=1;
   try
    MyDataSet:=TMyDataSet.create(nil);
    MyDataSet.MySqlConnection:= MyExConn;
      CSql:= ' select max(daoshu) as MaxD  from  d_'+IntTostr(Gzmbh) +'_ManualInputPressData ';
      MyDataSet.Close ;
      MyDataSet.CommandText :=CSql;
      if MyDataSet.Open  then
         if MyDataSet.RecordCount >0  then
            Result:=MyDataSet.FieldByName('MaxD').AsInteger;

      MyDataSet.Close ;
   finally
     FreeAndNil(MyDataSet);
   end;
end;

function TGzm.ReturnMaxFootAgeTime: TdateTime;
Var
   CSql:String;
   MyDataSet:TMyDataSet;
   Row,Col:integer;
begin
    Result:=Now;
   try
    MyDataSet:=TMyDataSet.create(nil);
    MyDataSet.MySqlConnection:= MyExConn;

      CSql:= ' select Max(footday) as FTD  from  d_'+IntTostr(Gzmbh) +'_footage where processage>=0 ';
      MyDataSet.Close ;
      MyDataSet.CommandText :=CSql;

      if MyDataSet.Open  then
         if MyDataSet.RecordCount >0  then
            Result:=MyDataSet.FieldByName('FTD').AsDateTime;

      MyDataSet.Close ;
   finally
     FreeAndNil(MyDataSet);
   end;

end;

function TGzm.ReturnMinFootAgeTime: TdateTime;
Var
   CSql:String;
   MyDataSet:TMyDataSet;
   Row,Col:integer;
begin
    Result:=Now;
   try
    MyDataSet:=TMyDataSet.create(nil);
    MyDataSet.MySqlConnection:= MyExConn;

      CSql:= ' select Min(footday) as FTD  from  d_'+IntTostr(Gzmbh) +'_footage where processage>=0 ';
      MyDataSet.Close ;
      MyDataSet.CommandText :=CSql;

      if MyDataSet.Open  then
         if MyDataSet.RecordCount >0  then
            Result:=MyDataSet.FieldByName('FTD').AsDateTime;

      MyDataSet.Close ;
   finally
     FreeAndNil(MyDataSet);
   end;

end;

function TGzm.ReturnRockPressDataMaxDaoshu: Integer;
Var
   CSql:String;
   MyDataSet:TMyDataSet;
   Row,Col:integer;
begin
    Result:=0;
   try
    MyDataSet:=TMyDataSet.create(nil);
    MyDataSet.MySqlConnection:= MyExConn;

      CSql:= ' select Max(DaoShu) as SN from  d_'+IntTostr(Gzmbh) +'_ManualInputPressData ';
      MyDataSet.Close ;
      MyDataSet.CommandText :=CSql;

      if MyDataSet.Open  then
         if MyDataSet.RecordCount >0  then
            Result:=MyDataSet.FieldByName('SN').AsInteger;

      MyDataSet.Close ;
   finally
     FreeAndNil(MyDataSet);
   end;


end;

function TGzm.ReturnUpperAndDownFootage(Daoshu: Integer; var  downFootage,
  Upperfootage: double): Boolean;
Var
   CSql:String;
   MyDataSet:TMyDataSet;
   S_Footage:double;
begin
    { footday,Daoshu,downfootage,sumdownfootage,EditDownFootage, '+
              ' upperfootage,sumupperfootage,EditUpperFootage,processage}
   Result:=False;
   try
    MyDataSet:=TMyDataSet.create(nil);
    MyDataSet.MySqlConnection:= MyExConn;

      CSql:= ' select * from  d_'+IntTostr(Gzmbh) +'_footage where processage>=0  and Daoshu= ' +IntToStr(Daoshu);
      MyDataSet.Close ;
      MyDataSet.CommandText :=CSql;

      if MyDataSet.Open  then
         if MyDataSet.RecordCount >0  then  begin
            DownFootage:=MyDataSet.FieldByName('sumdownfootage').AsFloat;
            UpperFootage:=MyDataSet.FieldByName('sumupperfootage').AsFloat;
            Result:=true;
         end;

      MyDataSet.Close ;

   finally
     FreeAndNil(MyDataSet);
   end;

end;

function TGzm.UpdateFaultToDataBase(nFault: TFault): Boolean;
var
   Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TmyCommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn ;
   Result:=false;
   Gzm_Command1.MySqlConnection.BeginTrans;
   try
       Gzm_Command1.CommandText:=' delete  from  dc_Fault   WHERE gzmid = '+Trim(inttostr(nFault.gzmbh))+
            ' and dcName =  ''' +nFault.Name+'''';
       Gzm_Command1.Execute ;
       self.InsertFaultToDataBase(nFault) ;
   finally
       Gzm_Command1.MySqlConnection.CommitTrans ;
       Result:=true;
   end;
   Gzm_Command1.free;
end;

function TGzm.UpdateMineOutAreaToDataBase(nMineOutArea: TMineOutArea): Boolean;
var
   Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TmyCommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn ;
   Result:=false;
   Gzm_Command1.MySqlConnection.BeginTrans;
   try
       Gzm_Command1.CommandText:=' delete  from  ckq_MineOutArea   WHERE gzmid = '+Trim(inttostr(nMineOutArea.gzmid))+
            ' and ckqName =  ''' +nMineOutArea.Name+'''';
       Gzm_Command1.Execute ;
       self.InsertMineOutAreaToDataBase(nMineOutArea) ;
   finally
       Gzm_Command1.MySqlConnection.CommitTrans ;
       Result:=true;
   end;
   Gzm_command1.free;
end;

function TGzm.UpdateRockPressDataToDataBase(JinDao, SupportNo,
         ValueType: integer;Memo:String; Data: Double): Boolean;
Var
   Sql,Sql1:String;
   MyCommand:TMyCommand;
   MyDataSet:TMyDataSet ;
   FieldStr:String;
begin
    Result:=false;
    FieldStr:=ReturnManualInputPressDataField(ValueType);
    //��������
    MyDataSet:=TMyDataSet.create(nil);
    MyDataSet.MySqlConnection:= MyExConn;
    Sql1:='select count(id) as CN from d_'+IntTostr(Gzmbh) +'_ManualInputPressData '+
          ' where Daoshu= ' + inttoStr(JinDao) + ' and Supportbh = '+ IntTostr(SupportNo);
    try
        MyDataSet.Close ;
        MyDataSet.CommandText :=sql1;
        if MyDataSet.Open  then begin
           if MyDataSet.FieldByName('CN').AsInteger<1 then   begin
              MyDataSet.Close ;
              FreeAndNil(MyDataSet);
              exit;
           end;
        end;
    finally
      Result:=False;
    end;

   try
    MyCommand:=TMyCommand.create(nil);
    MyCommand.MySqlConnection:= MyExConn;
      Sql:='update d_'+IntTostr(Gzmbh) +'_ManualInputPressData set ' + FieldStr + ' = ' + FormatFloat('0.00',Data)  +
           ' , Memo1 =''' +Memo+ '''' +
           ' where Daoshu= ' + inttoStr(JinDao) + ' and Supportbh = '+ IntTostr(SupportNo);

      MyCommand.CommandText:=sql;
      MyCommand.Execute ;
      Result:=true;
   finally
     FreeAndNil(MyCommand);
   end;

end;

function TGzm.UpdateRockPressParameters(strValue: String): Boolean;
var
  sql:string;
  Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TmyCommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn ;
    Result:=false;
    if length(Trim(strValue))> 198 then  exit;

    sql:=' update cqcsb  set Memo2 =''' +strValue  + '''' +
          ' where cqid='  +IntTostr(Gzmbh)  ;
   try
    Gzm_command1.CommandText:=sql;
    Gzm_Command1.Execute ;

   finally
      Result:=true;
   end;
   Gzm_command1.free;


end;

function TGzm.UpdateSupportToDataBase(insupport: TSupportStep): Boolean;
var
   sql:string;
   supportid:integer;
   Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TmyCommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn ;
     Result:=false;
     supportid:=self.isExistSupportName(insupport.Zj_Name);
     sql:=' update zjxhb set lx ='''+ insupport.Zj_leixing  +''', zjmd= ' + IntToStr(insupport.Zj_Lizhu_count)  +
          ', zcl=' +Formatfloat('0.00',insupport.Zj_toall_F) +', zhqd='+ Formatfloat('0.00',insupport.Zj_toall_P)   +
         ',ysl= ' +Formatfloat('0.00',insupport.Zj_suoliang) +',kdj='+ Formatfloat('0.00',insupport.Zj_KongdingJU)   +
         ', zjkd=' +Formatfloat('0.00',insupport.Zj_zhongxinju) +',hld='+ Formatfloat('0.00',insupport.Zj_hlzyd)   +
         ', lzgj=' +Formatfloat('0.00',insupport.Lz_Diameter) +',zjczl='+ Formatfloat('0.00',insupport.initLoad)   +
         ', yyfkqqd=' +Formatfloat('0.00',insupport.EndOpenLoad) + ',hbgd='+ Formatfloat('0.00',insupport.Zj_hubang_h)   +
         ', hbqd=' +Formatfloat('0.00',insupport.zj_hubang_P) +
         ' where id= ' + IntToStr(supportid) ;
   try
    Gzm_command1.CommandText:=sql;
    Gzm_Command1.Execute ;

   finally
      Result:=true;
   end;
   Gzm_command1.free;
end;

function TGzm.UpdateUserInfoDataBase(id: integer; UP, UD, UT: string): Boolean;
var
   sql:string;
   Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TMycommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn;
     Result:=false;
     try
         Sql:='update UserInfo  set User_Password = '''+  UP+''','+
                             'User_Type = '+ UT +  ',used ='  +UD +
              '  where id ='+ InttoStr(id);
         Gzm_command1.CommandText:=sql;
         Gzm_Command1.Execute ;

     finally
       Gzm_command1.free;
       Result:=true;
     end;

end;

function TGzm.WorkFaceBulidDrill: Boolean;
var
  I:integer;
  Gzm_DataSet2:TMyDataSet;
begin
    Gzm_DataSet2:=TMyDataSet.create(nil);
    Gzm_DataSet2.MySqlConnection:= MyExConn;
    Result:=false;
    //����ԭ�������
    for I := 0 to BuilledDrillNumber -1 do
            FreeandNil(BuilledDrillType[i]) ;

   //
     try
       Gzm_DataSet2.Close();
       Gzm_DataSet2.CommandText:='SELECT * FROM WorkFaceBuillDrill WHERE gzmid = '+inttostr(Gzmbh);
       if  (Gzm_DataSet2.Open) and (Gzm_DataSet2.RecordCount>0)  then begin
           self.BuilledDrillNumber := Gzm_DataSet2.RecordCount ;
           setlength(self.BuilledDrillType,BuilledDrillNumber);
           i:=0;
           while not Gzm_DataSet2.Eof  do  begin

                 BuilledDrillType[i]:=TWorkfaceBuillDrill.Create ;
                 BuilledDrillType[i].NO:=i+1;
                 BuilledDrillType[i].Zkid:= Gzm_DataSet2.FieldByName('zkid').ASinteger;
                 BuilledDrillType[i].startdistance:= Gzm_DataSet2.FieldByName('startdistance').AsFloat;
                 BuilledDrillType[i].enddistance:= Gzm_DataSet2.FieldByName('enddistance').AsFloat;
                 Gzm_DataSet2.Next;
                 i:=i+1;
            end;
            Result:=true;
       end;
     finally
        Gzm_DataSet2.Close();
        FreeAndNil(Gzm_DataSet2);
     end;
end;

function TGzm.WorkFaceBulidSupport: Boolean;
var
   i, maxsup,MaxSupNumber:integer;
   Gzm_DataSet2:TMyDataSet;
begin
    Gzm_DataSet2:=TMyDataSet.create(nil);
    Gzm_DataSet2.MySqlConnection:= MyExConn;
    Result:=false;
    //����ԭ����֧��
    for I := 0 to BuilledsupportNumber -1 do
          FreeandNil(BuilledSupportType[i]) ;
   //
     try
           Gzm_DataSet2.Close();
           Gzm_DataSet2.CommandText:='SELECT * FROM WorkFaceBuillsupport WHERE gzmid = ' +inttostr(Gzmbh);
       if (Gzm_DataSet2.Open) and (Gzm_DataSet2.RecordCount>0) then begin
           self.BuilledSupportNumber:= Gzm_DataSet2.RecordCount ;
           setlength(self.BuilledSupportType,BuilledSupportNumber);
           i:=0; maxsup:=0;MaxSupNumber:=0;
           while not Gzm_DataSet2.Eof  do  begin

                 BuilledSupportType[i]:=TWorkFaceBuillSupport.Create ;
                 BuilledSupportType[i].NO:=i+1;
                 BuilledSupportType[i].Supportid:= Gzm_DataSet2.FieldByName('supportid').ASinteger;
                 BuilledSupportType[i].startsupportNo:= Gzm_DataSet2.FieldByName('startsupportno').AsInteger;
                 BuilledSupportType[i].endsupportNo:= Gzm_DataSet2.FieldByName('endsupportno').AsInteger;
                 self.InputGzmSupport(BuilledSupportType[i]); // ����֧��

                 if Maxsup < BuilledSupportType[i].endsupportNo-BuilledSupportType[i].startsupportNo +1 then  begin
                    Maxsup:= BuilledSupportType[i].endsupportNo-BuilledSupportType[i].startsupportNo +1;
                    UsedSupportNO:=BuilledSupportType[i].Supportid ;
                    Usedsupport.Supportid :=UsedSupportNO;
                    self.InputGzmSupport(self.Usedsupport);
                 end;
                 // Ѱ��֧�����ֵ
                 if BuilledSupportType[i].endsupportNo > MaxSupNumber then  begin
                    MaxSupNumber:= BuilledSupportType[i].endsupportNo;
                 end;
                 Gzm_DataSet2.Next;
                 i:=i+1;
            end;
            // Ϊ֧��ʹ������� ��ֵ
            SupEndUsedNumber:= MaxSupNumber;
            Result:=true;
       end else begin  // ���û�а�֧������
           UsedSupportNO:=0;
           Usedsupport.Supportid :=UsedSupportNO;
           Usedsupport.Zj_Name:=ZjName;
           InputGzmSupport(Usedsupport);
           Result:=true;
       end;

     finally
        Gzm_DataSet2.Close();
        Gzm_DataSet2.free;
     end;

end;

function TGzm.WriteCoalPillarXml: String;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
   ChildChildRoot,ChildChildChildRoot: TXmlNode;
   i:integer;
begin
     MyXml:=TNativeXml.CreateName(UTF8String('�������ܱ�ú����Ϣά��')) ;
     RootNode:= MyXml.root.NodeNew('');
         RootNode.Name:='Custom';

     ChildRoot:=RootNode.NodeNew('');
        ChildRoot.Name:=UTF8String('MineName');   //
        ChildRoot.Value:= UTF8String('��Ȫ����');
     ChildRoot:=RootNode.NodeNew('');
        ChildRoot.Name:=UTF8String('WorkFaceName');   // workfacename
        ChildRoot.Value:= UTF8String(s_Name+'_new');

      for I := 0 to self.cCoalPillar-1 do   begin
             ChildChildRoot:=ChildRoot.NodeNew('');
                  ChildChildRoot.Name:=UTF8String('CoalPillarNo:'+Trim(intToStr(i+1)));
                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('CoalPillarName');
                    ChildChildChildRoot.Value := UTF8String(self.CoalPillar[i].Name+'_1' );
                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('location');
                    ChildChildChildRoot.Value := UTF8String(GetEnumName(TypeInfo(TGzmLocation),ord(CoalPillar[i].location )));

                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('CoalPillarWidth');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',CoalPillar[i].width));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('CoalPillarlength');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',CoalPillar[i].length));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('CoalPillarHeigth');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',CoalPillar[i].heigth));

                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('DistanceLeftSide');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',CoalPillar[i].dis_left));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('DistanceRightSide');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',CoalPillar[i].dis_right));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('DistanceFrontSide');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',CoalPillar[i].dis_front));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('DistanceBehindSide');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',CoalPillar[i].dis_behind));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('DistanceTopCoalSeam');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',CoalPillar[i].dis_top));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('DistanceUnderCoalSeam');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',CoalPillar[i].dis_bottom));

                ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('ForCaseSaftDistance');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',CoalPillar[i].safedistance));

        end;

    MyXml.XmlFormat := xfReadable;
    MyXml.SaveToFile('D:\CoalPillar.xml');
    Result:=Myxml.WriteToString ;
    MyXml.Free;

end;

function TGzm.WriteDrillxml: string;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
   ChildChildRoot,ChildChildChildRoot:TXmlNode;
   inn_D:Tzk_bore;
   i:integer;
begin
    inn_D:=Tzk_bore.Create;
    inputGzmzk(inn_D);
    InputGzmYc(inn_D);

    MyXml:=TNativeXml.CreateName(UTF8String('��������׻�����Ϣ¼��')) ;
    RootNode:= MyXml.root.NodeNew('');
        RootNode.Name:='Custom';
    ChildRoot:=RootNode.NodeNew('');
        ChildRoot.Name:=UTF8String('MineName');   // workfacename
        ChildRoot.Value:= UTF8String('��Ȫ����');
     ChildRoot:=RootNode.NodeNew('');
        ChildRoot.Name:=UTF8String('DrillName');   // workfacename
        ChildRoot.Value:= UTF8String(inn_d.Zk_name+'New');
    //
        for I := 0 to inn_d.Zk_Yc_Count-1 do   begin
             ChildChildRoot:=ChildRoot.NodeNew('');
                  ChildChildRoot.Name:=UTF8String('DrillNO:'+intToStr(i+1));
                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('YockName');
                    ChildChildChildRoot.Value := UTF8String(inn_d.Yc_Rock[i].R_Name);
                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('YockThickness');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',inn_d.Yc_Rock[i].R_h));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('YockComrressStrength');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',inn_d.Yc_Rock[i].R_kyqd));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('YockTensileStrength');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',inn_d.Yc_Rock[i].R_klqd));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('YockBulkDensity');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',inn_d.Yc_Rock[i].R_r));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('YockMinableSeam');
                    if  inn_d.Yc_Rock[i].M_Kc_YandN then    ChildChildChildRoot.Value := UTF8String('1')
                       else ChildChildChildRoot.Value := UTF8String('0') ;
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('CoalSeamName');
                    ChildChildChildRoot.Value := UTF8String(self.ReturnCoalSeamName(inn_d.Yc_Rock[i].MCId ));

        end;

    MyXml.XmlFormat := xfReadable;
    MyXml.SaveToFile('D:\DrillInfo.xml');
    Result:=Myxml.WriteToString ;
    MyXml.Free ;
    inn_D.Free ;

end;

function TGzm.WriteFaultXml: String;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
   ChildChildRoot,ChildChildChildRoot: TXmlNode;
   i:integer;
begin
     MyXml:=TNativeXml.CreateName(UTF8String('�������ܱ߶ϲ���Ϣά��')) ;
     RootNode:= MyXml.root.NodeNew('');
         RootNode.Name:='Custom';

     ChildRoot:=RootNode.NodeNew('');
        ChildRoot.Name:=UTF8String('MineName');   //
        ChildRoot.Value:= UTF8String('��Ȫ����');
     ChildRoot:=RootNode.NodeNew('');
        ChildRoot.Name:=UTF8String('WorkFaceName');   // workfacename
        ChildRoot.Value:= UTF8String(s_Name+'_new');

      for I := 0 to self.cFault-1 do   begin
             ChildChildRoot:=ChildRoot.NodeNew('');
                  ChildChildRoot.Name:=UTF8String('FaultNo:'+Trim(intToStr(i+1)));
                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('FaultName');
                    ChildChildChildRoot.Value := UTF8String(self.Fault[i].Name+'_1' );
                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('location');
                    ChildChildChildRoot.Value := UTF8String(GetEnumName(TypeInfo(TGzmLocation),ord(Fault[i].location )));

                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('Faulttype');
                    if  Fault[i].faulttype=1 then begin
                         ChildChildChildRoot.Value := UTF8String('���ϲ�');
                    end else begin
                         ChildChildChildRoot.Value := UTF8String('��ϲ�');
                    end;
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('FaultDivide');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',Fault[i].divide));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('MinToOpenCutLine');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',Fault[i].MinToOffCut));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('MaxToOpenCutLine');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',Fault[i].MaxToOffCut));

                ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('ForCaseSaftDistance');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',Fault[i].safedistance));

        end;

    MyXml.XmlFormat := xfReadable;
    MyXml.SaveToFile('D:\Fault.xml');
    Result:=Myxml.WriteToString ;
    MyXml.Free;

end;

function TGzm.WriteMineOutAreaXml: String;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
   ChildChildRoot,ChildChildChildRoot: TXmlNode;
   i:integer;
begin
     MyXml:=TNativeXml.CreateName(UTF8String('�������ܱ߲ɿ�����Ϣά��')) ;
     RootNode:= MyXml.root.NodeNew('');
         RootNode.Name:='Custom';

     ChildRoot:=RootNode.NodeNew('');
        ChildRoot.Name:=UTF8String('MineName');   //
        ChildRoot.Value:= UTF8String('��Ȫ����');
     ChildRoot:=RootNode.NodeNew('');
        ChildRoot.Name:=UTF8String('WorkFaceName');   // workfacename
        ChildRoot.Value:= UTF8String(s_Name+'_new');

      for I := 0 to self.cMineOutArea-1 do   begin
             ChildChildRoot:=ChildRoot.NodeNew('');
                  ChildChildRoot.Name:=UTF8String('MineOutAreaNo:'+Trim(intToStr(i+1)));
                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('MineOutAreaName');
                    ChildChildChildRoot.Value := UTF8String(self.MineOutArea[i].Name+'_1' );
                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('location');
                    ChildChildChildRoot.Value := UTF8String(GetEnumName(TypeInfo(TGzmLocation),ord(MineOutArea[i].location )));

                  ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('MineOutAreaOuttime');
                    ChildChildChildRoot.Value := UTF8String(FormatDateTime('yyyy-mm-dd hh:nn:ss',self.MineOutArea[i].Outtime ));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('MineOutAreaWidth');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',MineOutArea[i].width));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('MineOutArealength');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',MineOutArea[i].length));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('MineOutAreaHeigth');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',MineOutArea[i].heigth));

                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('DistanceLeftSide');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',MineOutArea[i].dis_left));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('DistanceRightSide');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',MineOutArea[i].dis_right));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('DistanceFrontSide');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',MineOutArea[i].dis_front));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('DistanceBehindSide');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',MineOutArea[i].dis_behind));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('DistanceTopCoalSeam');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',MineOutArea[i].dis_top));
                 ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('DistanceUnderCoalSeam');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',MineOutArea[i].dis_bottom));

                ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                    ChildChildChildRoot.Name := UTF8String('ForCaseSaftDistance');
                    ChildChildChildRoot.Value := UTF8String(FormatFloat('0.00',MineOutArea[i].safedistance));

        end;

    MyXml.XmlFormat := xfReadable;
    MyXml.SaveToFile('D:\MineOutArea.xml');
    Result:=Myxml.WriteToString ;
    MyXml.Free;
end;

function TGzm.WriteSupportXml: string;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;

begin
     MyXml:=TNativeXml.CreateName(UTF8String('֧�ܻ�����Ϣ¼��')) ;
     RootNode:= MyXml.root.NodeNew('');
         RootNode.Name:='Custom';

 {    ChildRoot:=RootNode.NodeNew('');
        ChildRoot.Name:=UTF8String('MineName');   //
        ChildRoot.Value:= UTF8String('��Ȫ����');

     ChildRoot:=RootNode.NodeNew('');
        ChildRoot.Name:=UTF8String('SupportName');   //   ֧������
        ChildRoot.Value:= UTF8String(Usedsupport.Zj_Name+'New');

     ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('SupportType');      //�ͺ� �۲� �Ŷ�ú
       ChildRoot.Value:= UTF8String(Usedsupport.Zj_leixing);

      ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('SupportColumnNumber');    //��������
       ChildRoot.Value:= UTF8String(intToStr(Usedsupport.Zj_Lizhu_count));

      ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('MaxResistance');    //֧�������迹��
       ChildRoot.Value:= UTF8String(FormatFloat('0.00',Usedsupport.Zj_toall_F));

     ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('MaxStrength');    //֧��֧��ǿ��
       ChildRoot.Value:= UTF8String(FormatFloat('0.00',Usedsupport.zj_toall_P));

     ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('MaxDropOff');    //֧���������
       ChildRoot.Value:= UTF8String(FormatFloat('0.00',Usedsupport.Zj_suoliang));

     ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('SupportedRoofSpan');    //֧�ܿض���
       ChildRoot.Value:= UTF8String(FormatFloat('0.00',Usedsupport.Zj_KongdingJU));

     ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('SupportCenterdistance');    //֧�����ľ�
       ChildRoot.Value:= UTF8String(FormatFloat('0.00',Usedsupport.Zj_zhongxinju));

     ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('ResultantForcePoint');    //�������õ�
       ChildRoot.Value:= UTF8String(FormatFloat('0.00',Usedsupport.Zj_hlzyd));

     ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('ColumnDiameter');    //�����׾�
       ChildRoot.Value:= UTF8String(FormatFloat('0.00',Usedsupport.Lz_Diameter));

    ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('SupportInitLoad');    //������
       ChildRoot.Value:= UTF8String(FormatFloat('0.00',Usedsupport.initLoad));

    ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('SupportEndOpenLoad');    //Һѹ������
       ChildRoot.Value:= UTF8String(FormatFloat('0.00',Usedsupport.EndOpenLoad));
  }
    MyXml.XmlFormat := xfReadable;
    MyXml.SaveToFile('D:\Support.xml');
    Result:=Myxml.WriteToString ;
    MyXml.Free;
end;

function TGzm.WriteWorkfaceSelectDrill(WorkFaceName: string): String;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
   ChildChildRoot,ChildChildChidNode:TXmlNode;

begin
    MyXml:=TNativeXml.CreateName(UTF8String('�����������λ�ù�ϵ')) ;
    RootNode:= MyXml.root.NodeNew('');
        RootNode.Name:='Custom';
    ChildRoot:=RootNode.NodeNew('');
        ChildRoot.Name:=UTF8String('MineName');   // workfacename
        ChildRoot.Value:= UTF8String('��Ȫ����');
     ChildRoot:=RootNode.NodeNew('');
        ChildRoot.Name:=UTF8String('WorkFaceName');   // workfacename
        ChildRoot.Value:= UTF8String(WorkFaceName);
       //��һ��
        ChildChildRoot:=ChildRoot.NodeNew('');
           ChildChildRoot.Name:=UTF8String('DrillName_1');
           ChildChildRoot.Value:=UTF8String('1309���');
             ChildChildChidNode:=ChildChildRoot.NodeNew('');
                 ChildChildChidNode.Name:=UTF8String('startdistance');
                 ChildChildChidNode.Value:=UTF8String('0');
             ChildChildChidNode:=ChildChildRoot.NodeNew('');
                 ChildChildChidNode.Name:=UTF8String('enddistance');
                 ChildChildChidNode.Value:=UTF8String('300');
      // �ڶ���
       ChildChildRoot:=ChildRoot.NodeNew('');
           ChildChildRoot.Name:=UTF8String('DrillName_2');
           ChildChildRoot.Value:=UTF8String('1309���new');
             ChildChildChidNode:=ChildChildRoot.NodeNew('');
                 ChildChildChidNode.Name:=UTF8String('startdistance');
                 ChildChildChidNode.Value:=UTF8String('300');
             ChildChildChidNode:=ChildChildRoot.NodeNew('');
                 ChildChildChidNode.Name:=UTF8String('enddistance');
                 ChildChildChidNode.Value:=UTF8String('1000');

    MyXml.XmlFormat := xfReadable;
    MyXml.SaveToFile('D:\workFaceBuildDrill.xml');
    Result:=Myxml.WriteToString ;
    MyXml.Free ;

end;

function TGzm.writeWorkFaceSelectSupport(WorkFaceName: string): string;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
   ChildChildRoot,ChildChildChidNode:TXmlNode;

begin
    MyXml:=TNativeXml.CreateName(UTF8String('��������֧��λ�ù�ϵ')) ;
    RootNode:= MyXml.root.NodeNew('');
        RootNode.Name:='Custom';
    ChildRoot:=RootNode.NodeNew('');
        ChildRoot.Name:=UTF8String('MineName');   // workfacename
        ChildRoot.Value:= UTF8String('��Ȫ����');
     ChildRoot:=RootNode.NodeNew('');
        ChildRoot.Name:=UTF8String('WorkFaceName');   // workfacename
        ChildRoot.Value:= UTF8String(WorkFaceName);
       //��һ��
        ChildChildRoot:=ChildRoot.NodeNew('');
           ChildChildRoot.Name:=UTF8String('SupportName_1');
           ChildChildRoot.Value:=UTF8String('ZY6400/17/31D');
             ChildChildChidNode:=ChildChildRoot.NodeNew('');
                 ChildChildChidNode.Name:=UTF8String('startsupportNO');
                 ChildChildChidNode.Value:=UTF8String('1');
             ChildChildChidNode:=ChildChildRoot.NodeNew('');
                 ChildChildChidNode.Name:=UTF8String('endsupportNo');
                 ChildChildChidNode.Value:=UTF8String('5');
      // �ڶ���
       ChildChildRoot:=ChildRoot.NodeNew('');
           ChildChildRoot.Name:=UTF8String('SupportName_2');
           ChildChildRoot.Value:=UTF8String('ZY6400/17/31DNew');
             ChildChildChidNode:=ChildChildRoot.NodeNew('');
                 ChildChildChidNode.Name:=UTF8String('startsupportNO');
                 ChildChildChidNode.Value:=UTF8String('6');
             ChildChildChidNode:=ChildChildRoot.NodeNew('');
                 ChildChildChidNode.Name:=UTF8String('endsupportNo');
                 ChildChildChidNode.Value:=UTF8String('117');
        // ������
       ChildChildRoot:=ChildRoot.NodeNew('');
           ChildChildRoot.Name:=UTF8String('SupportName_3');
           ChildChildRoot.Value:=UTF8String('ZY6400/17/31D');
             ChildChildChidNode:=ChildChildRoot.NodeNew('');
                 ChildChildChidNode.Name:=UTF8String('startsupportNO');
                 ChildChildChidNode.Value:=UTF8String('118');
             ChildChildChidNode:=ChildChildRoot.NodeNew('');
                 ChildChildChidNode.Name:=UTF8String('endsupportNo');
                 ChildChildChidNode.Value:=UTF8String('122');

    MyXml.XmlFormat := xfReadable;
    MyXml.SaveToFile('D:\workFaceBuildSupport.xml');
    Result:=Myxml.WriteToString ;
    MyXml.Free ;
end;

function TGzm.WriteWorkFaceXml: string;
var
   MyXml:TNativeXml;
   RootNode :TXmlNode;
   ChildRoot:TXmlNode;
begin
     MyXml:=TNativeXml.CreateName(UTF8String('��ú�����������Ϣ¼��')) ;
   //  MyXml:=TNativeXml.Create(nil);

     RootNode:= MyXml.root.NodeNew('');
         RootNode.Name:='Custom';

     ChildRoot:=RootNode.NodeNew('');
        ChildRoot.Name:=UTF8String('MineName');   // workfacename
        ChildRoot.Value:= UTF8String('��Ȫ����');

     ChildRoot:=RootNode.NodeNew('');
        ChildRoot.Name:=UTF8String('WorkFaceName');   // workfacename
        ChildRoot.Value:= UTF8String(s_Name);

     ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('CoalSeamName');
       ChildRoot.Value:= UTF8String(self.S_mc_name);

     ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('CoalMiningHeigth');
       ChildRoot.Value:= UTF8String(FormatFloat('0.00',self.S_Cg_h));

     ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('CoalMiningMethod');
       ChildRoot.Value:= UTF8String('2');

     ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('CoalseamAngle');
       ChildRoot.Value:= UTF8String(FormatFloat('0.00',self.S_qj ));
     ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('AVGBuriedDepth ');
       ChildRoot.Value:= UTF8String(FormatFloat('0.00',self.S_mcsd_h));

     ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('WorkFaceLength ');
       ChildRoot.Value:= UTF8String(FormatFloat('0.00',self.S_L_qx));

     ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('TowardDistance');
       ChildRoot.Value:= UTF8String(FormatFloat('0.00',self.S_Sx_zx));
    ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('Coalhardness');
       ChildRoot.Value:= UTF8String(FormatFloat('0.00',self.S_f_PS));
    ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('SupportStartNumber');
       ChildRoot.Value:= UTF8String(intToStr(self.SupStartNumber));
    ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('SupportEndNumber');
       ChildRoot.Value:= UTF8String(IntToStr(self.SupEndNumber));
    ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('SupportDirection');
       ChildRoot.Value:= UTF8String(IntToStr(self.SupNumberDirection));
    ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('TransportRoadwayFirstDrillPressLocation');
       ChildRoot.Value:= UTF8String(FormatFloat('0.00',self.TransportRoadwayFirstDrillPressLocation));
    ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('TransportRoadwaySecondDrillPressLocation');
       ChildRoot.Value:= UTF8String(FormatFloat('0.00',self.TransportRoadwaySecondDrillPressLocation));
    ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('PathwayRoadWayFirstDrillPressLocation');
       ChildRoot.Value:= UTF8String(FormatFloat('0.00',self.PathwayRoadWayFirstDrillPressLocation));
    ChildRoot:=RootNode.NodeNew('');
       ChildRoot.Name:=UTF8String('PathwayRoadWaySecondDrillPressLocation');
       ChildRoot.Value:= UTF8String(FormatFloat('0.00',self.PathwayRoadWaySecondDrillPressLocation));


    MyXml.XmlFormat := xfReadable;
    MyXml.SaveToFile('D:\workFace.xml');
    Result:=Myxml.WriteToString ;
    MyXml.Free ;

end;

//end procedure

function TGzm.SaveMultPressDataToDAteBase(td: String; JinDao,
  SupportNo: integer; Data0, Data1, Data2, Data3, Data4,Data5: Double;
  Mem: String): Boolean;
Var
   Sql:String;
   MyCommand:TMyCommand;
begin
    Result:=false;
   try
    MyCommand:=TMyCommand.create(nil);
    MyCommand.MySqlConnection:= MyExConn;
      Sql:='insert into d_'+IntTostr(Gzmbh) +'_ManualInputPressData (generatetime,Daoshu,Supportbh, ' +
            'Max_Value,AGV_Value,MzL_Value,Same_Value,CCl_Value,Pressdata,Memo1) values (' +
              '''' +td +''',' +
              IntTostr(JinDao) +',' +  IntTostr(SupportNo) +',' +
              FormatFloat('0.00',Data0)+','  +  FormatFloat('0.00',Data1)+','  +
              FormatFloat('0.00',Data2)+','  +  FormatFloat('0.00',Data3)+','  +
              FormatFloat('0.00',Data4)+','  +  FormatFloat('0.00',Data5)+','  +
              '''' + Mem+ ''')';
      MyCommand.CommandText:=sql;
      MyCommand.Execute ;
      Result:=true;
   finally
     FreeAndNil(MyCommand);
   end;

end;

function TGzm.SaveRockPressDataToDataBase(td:String; JinDao,
  SupportNo,ValueType: integer; Data: Double; Mem: String): Boolean;
Var
   Sql,FieldStr:String;
   MyCommand:TMyCommand;
begin
    Result:=false;
     FieldStr:=ReturnManualInputPressDataField(ValueType);
   try
    MyCommand:=TMyCommand.create(nil);
    MyCommand.MySqlConnection:= MyExConn;
      Sql:='insert into d_'+IntTostr(Gzmbh) +'_ManualInputPressData (generatetime,Daoshu,Supportbh,'+FieldStr+',Memo1) values (' +
              '''' +td +''',' +
              IntTostr(JinDao) +',' +  IntTostr(SupportNo) +',' + FormatFloat('0.00',Data)+','  +
              '''' + Mem+ ''')';
      MyCommand.CommandText:=sql;
      MyCommand.Execute ;
      Result:=true;
   finally
     FreeAndNil(MyCommand);
   end;


end;

function TGzm.SelecCoalSeamid(CoalSeamName:String;MineId:integer): Integer;
var
  Gzm_DataSet1:TMydataset;
  Gzm_Command1:TMyCommand;
begin
    Result:=-1;
    Gzm_DataSet1:=TmyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn ;
    Gzm_Command1:=TMyCommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn ;
    try
      Gzm_DataSet1.Close;
      Gzm_DataSet1.CommandText:='select id from meiceng where MeiCengming='''+CoalSeamName +'''' +
                   ' and kuangjingbianhao =' + intTostr(MineId) ;
      if Gzm_DataSet1.Open then
          if Gzm_DataSet1.RecordCount>0 then  begin
             Result:=Gzm_DataSet1.FieldByName('id').AsInteger;
          end else begin
            Gzm_Command1.CommandText:=' insert into meiceng (meicengMing,kuangjingbianhao ) values (''' +
                 CoalSeamName +''' , ' + intTostr(MineId) +' )' ;
            Gzm_Command1.Execute ;
            Gzm_DataSet1.Close;
            Gzm_DataSet1.CommandText:='select id from meiceng  where MeiCengming='''+CoalSeamName +'''' ;
            Gzm_DataSet1.Open;
            if Gzm_DataSet1.RecordCount>0 then begin
                 Result:=Gzm_DataSet1.FieldByName('id').AsInteger;
            end;
          end;
    finally
       Gzm_DataSet1.Close;
       Gzm_DataSet1.free;
       Gzm_Command1.free;
    end;


end;

function TGzm.SelJituanBianhao(JituanName: string): integer;
var
  Gzm_DataSet1:TMydataset;
  Gzm_Command1:TMyCommand;
begin
    Result:=-1;
    JituanName:=UpperCase(JituanName);
    Gzm_DataSet1:=TmyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn ;
    Gzm_Command1:=TMyCommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn ;
    try
      Gzm_DataSet1.Close;
      Gzm_DataSet1.CommandText:='select id,DwName from jituanName  where DwName='''+JituanName +'''';
     if  Gzm_DataSet1.Open then
          if Gzm_DataSet1.RecordCount>0 then  begin
            Result:=Gzm_DataSet1.FieldByName('id').AsInteger;
          end else begin
              Gzm_Command1.CommandText:=' insert into jituanName (DwName) values ('''+
                                       JituanName+''')';
              Gzm_Command1.Execute ;
              Gzm_DataSet1.Close;
              Gzm_DataSet1.CommandText:='select id,DwName from jituanName  where DwName='''+JituanName +'''';
              if Gzm_DataSet1.Open then
              if Gzm_DataSet1.RecordCount>0 then
                  Result:=Gzm_DataSet1.FieldByName('id').AsInteger;
          end;

    finally
        Gzm_DataSet1.Close;
        Gzm_DataSet1.free;
        Gzm_Command1.free;
    end;


end;

function TGzm.SelKuangjingBianHao(KuangjingName,jituanName: string;
  Jituan: integer): integer;
var
  Gzm_DataSet1:TMydataset;
  Gzm_Command1:TMyCommand;
begin
    Result:=-1;
    KuangjingName:=UpperCase(KuangjingName);
    Gzm_DataSet1:=TmyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn ;
    Gzm_Command1:=TMyCommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn ;
    try
      Gzm_DataSet1.Close;
      Gzm_DataSet1.CommandText:='select id,Meikuangming from Kuangjingxinxibiao  where MeikuangMing='''+KuangjingName +'''';
     if  Gzm_DataSet1.Open then
          if Gzm_DataSet1.RecordCount>0 then  begin
            Result:=Gzm_DataSet1.FieldByName('id').AsInteger;
          end else begin
              Gzm_Command1.CommandText:=' insert into Kuangjingxinxibiao (Meikuangming,jituanName,jituanid) values ('''+
                               KuangjingName+''','''+jituanName+''','+IntToStr(Jituan)+')';
              Gzm_Command1.Execute ;
              Gzm_DataSet1.Close;
              Gzm_DataSet1.CommandText:='select id,Meikuangming from Kuangjingxinxibiao  where MeikuangMing='''+KuangjingName +'''';
              if Gzm_DataSet1.Open then
              if Gzm_DataSet1.RecordCount>0 then
                  Result:=Gzm_DataSet1.FieldByName('id').AsInteger;
          end;

    finally
        Gzm_DataSet1.Close;
        Gzm_DataSet1.free;
        Gzm_Command1.free;
    end;

end;

function TGzm.SelKuangjingBianHao(KuangjingName: String): integer;
var
  Gzm_DataSet1:TMydataset;
  Gzm_Command1:TMyCommand;
begin
    Result:=-1;
    KuangjingName:=UpperCase(KuangjingName);
    Gzm_DataSet1:=TmyDataSet.create(nil);
    Gzm_DataSet1.MySqlConnection:= MyExConn ;
    Gzm_Command1:=TMyCommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn ;
    try
      Gzm_DataSet1.Close;
      Gzm_DataSet1.CommandText:='select id,Meikuangming from Kuangjingxinxibiao  where MeikuangMing='''+KuangjingName +'''';
     if  Gzm_DataSet1.Open then
          if Gzm_DataSet1.RecordCount>0 then  begin
            Result:=Gzm_DataSet1.FieldByName('id').AsInteger;
          end else begin
              Gzm_Command1.CommandText:=' insert into Kuangjingxinxibiao (Meikuangming) values ('''+
                                       KuangjingName+''')';
              Gzm_Command1.Execute ;
              Gzm_DataSet1.Close;
              Gzm_DataSet1.CommandText:='select id,Meikuangming from Kuangjingxinxibiao  where MeikuangMing='''+KuangjingName +'''';
              if Gzm_DataSet1.Open then
              if Gzm_DataSet1.RecordCount>0 then
                  Result:=Gzm_DataSet1.FieldByName('id').AsInteger;
          end;

    finally
        Gzm_DataSet1.Close;
        Gzm_DataSet1.free;
        Gzm_Command1.free;
    end;

end;

procedure TGzm.SetDateintervalTime(Value: integer);
begin
        if Value >1  then   DateintervalTime:=Value
           else    DateintervalTime:=1;
        //write ini
        //InDataLink.WriteIniReadIniTimeInterval(DateintervalTime);

end;

procedure TGzm.SetDillNumber(Value: integer);
begin
    UsedDrillNo:=Value;
end;

procedure TGzm.setGzmNumber(Value: integer);
begin
    Gzmbh :=value;
end;

procedure TGzm.setSupportType(First, Second, Third, Fouth: Integer);
begin
     FirstValuetype:=TSupportDataType(First);
     SecondValuetype:=TSupportDataType(Second);
     ThirdValuetype:=TSupportDataType(Third);
     FouthValuetype:=TSupportDataType(Fouth);

     IsUesedsupFieldcount:=0;
     if First >0  then  begin
           IsUesedsupFieldName[IsUesedsupFieldcount]:=
               GetEnumName(TypeInfo(TSupportDataType),ord(FirstValuetype ));
           IsUesedsupFieldcount:=IsUesedsupFieldcount+1;
     end;

    if Second >0   then begin
           IsUesedsupFieldName[IsUesedsupFieldcount]:=
             GetEnumName(TypeInfo(TSupportDataType),ord(SecondValuetype ));
           IsUesedsupFieldcount:=IsUesedsupFieldcount+1;
    end;

     if Third >0  then begin
           IsUesedsupFieldName[IsUesedsupFieldcount]:=
             GetEnumName(TypeInfo(TSupportDataType),ord(ThirdValuetype ));
           IsUesedsupFieldcount:=IsUesedsupFieldcount+1;
     end;
           
     if Fouth >0  then begin
           IsUesedsupFieldName[IsUesedsupFieldcount]:=
               GetEnumName(TypeInfo(TSupportDataType),ord(FouthValuetype ));
           IsUesedsupFieldcount:=IsUesedsupFieldcount+1;
     end;
    // InDataLink.WriteiniSV(First,Second,Third,Fouth);
end;

procedure TGzm.setUsedInfo(Biaozhi: integer);
begin

end;

function TGzm.SplitColorString: Boolean;
begin
   RockPressAnalysis.ColorString:=ColorString;
end;

function TGzm.splitFootStepParameters: Boolean;
var
   s_temp,S2:Str_DT_array;
   C1,C2:integer;
begin
   Result:=False;
   if FootStepParameters='' then  exit;
   s_temp:=Public_Basic.split(FootStepParameters,'&',C1);
         S2:=Public_Basic.split(s_temp[0],',',C2);
         if C2>7 then  begin
             RockPressAnalysis.Oneday_daoshu:=Public_Basic.StrToInt_lu(S2[0]) ;
             RockPressAnalysis.TwoDao_IntervalTime:=Public_Basic.StrToInt_lu(S2[1]) ;
             RockPressAnalysis.OneDao_step:=Public_Basic.StrToDouble_Lu(S2[2]) ;
             if Public_Basic.StrToInt_lu(S2[3])>0 then
                RockPressAnalysis.ManulInput_Interval_support:=Public_Basic.StrToInt_lu(S2[3]) ;
             RockPressAnalysis.JinDao_Basic:=Public_Basic.StrToInt_lu(S2[4]) ;
             RockPressAnalysis.JinDao_Support:=Public_Basic.StrToInt_lu(S2[5]) ;
             RockPressAnalysis.JinDao_Time:=Public_Basic.StrToInt_lu(S2[6]) ;
             RockPressAnalysis.Jindao_DataType:=Public_Basic.StrToInt_lu(S2[7]) ;
             Result:=true;
         end;

         if C1>1 then  begin
            RockPressAnalysis.ColorString:=s_temp[1];
         end else begin
            RockPressAnalysis.ColorString:='';
         end;


end;

function TGzm.SplitRockPressParameters: Boolean;
var
   S1,S2:Str_DT_array;
   C1,C2:integer;
begin
   Result:=False;
   if RockPressAnalysisParameters='' then  exit;
   S1:=Public_Basic.split(RockPressAnalysisParameters,'&',C1);
   if C1>1 then  begin
      RockPressAnalysis.OldStepPhaseString:=S1[1];
   end else begin
      RockPressAnalysis.OldStepPhaseString:='';
   end;
   S2:=Public_Basic.split(S1[0],',',C2);
   if C2>14  then  begin
       if Public_Basic.StrToDouble_Lu(S2[0]) >0 then
           Usedsupport.initLoad:=Public_Basic.StrToDouble_Lu(S2[0]) ;
       if Public_Basic.StrToDouble_Lu(S2[1]) >0 then
           Usedsupport.EndOpenLoad:=Public_Basic.StrToDouble_Lu(S2[1]) ;
       RockPressAnalysis.AnalysisSenstive:=Public_Basic.StrToInt_lu(S2[2]) ;

       if  RockPressAnalysis.AnalysisSenstive <> 3 then begin
           RockPressAnalysis.Continue_SupNumber:=Public_Basic.StrToInt_lu(S2[3]) ;
           RockPressAnalysis.conTinue_DaoNumber:=Public_Basic.StrToInt_lu(S2[4]) ;
           RockPressAnalysis.Min_Pt:=Public_Basic.StrToDouble_Lu(S2[5]) ;
       end;
       RockPressAnalysis.StepGroundFilled:=Public_Basic.StrToInt_lu(S2[6]) ;
       RockPressAnalysis.StepFillIsTran:=Public_Basic.StrToInt_lu(S2[7]) ;
       RockPressAnalysis.StepFillLineWide:=Public_Basic.StrToInt_lu(S2[8]) ;
       RockPressAnalysis.StepFillColor:=Public_Basic.StrToInt_lu(S2[9]) ;
       RockPressAnalysis.SetpFillTran:= Public_Basic.StrToInt_lu(S2[10]) ;
       RockPressAnalysis.SelectedFillColor:= Public_Basic.StrToInt_lu(S2[11]) ;
       RockPressAnalysis.JudgeMInQD :=Public_Basic.StrToDouble_Lu(S2[12]) ;
       // �������� �������� ֱ��
       Usedsupport.Zj_Lizhu_count:=Public_Basic.StrToInt_lu(S2[13]) ;
       if Public_Basic.StrToDouble_Lu(S2[14])>0  then
          Usedsupport.Lz_Diameter:=Public_Basic.StrToDouble_Lu(S2[14]) ;

       Result:=true;
   end;



end;

{
function TGzm.SplitString(const source, ch: string): TStringList;
var
  temp, t2: string;
  i: integer;
begin
  result := TStringList.Create;
  temp := source;
  i := pos(ch, source);
  while i <> 0 do
  begin
    t2 := copy(temp, 0, i - 1);
    if (t2 <> '') then
      result.Add(t2);
    delete(temp, 1, i - 1 + Length(ch));
    i := pos(ch, temp);
  end;
  result.Add(temp);
end;
}
function TGzm.UpdateWorkFaceDataBase(dRec: PWorkFace): Boolean;
var
  MeiCengid,Cmff:integer;
  sql:string;
  Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TmyCommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn ;
     Result:=false;
     MeiCengid:=SelecCoalSeamid(dRec.CoalSeamName,kuangjingid);
     //Cmff:=RetrunCoalmethodbh(dRec.CoalMiningMethod);
     sql:=' update cqcsb  set mcid =' +IntToStr(MeiCengid)  +',kid='+IntToStr(kuangjingId) +',' +
          ' cmfa = ' + dRec.CoalMiningMethod +',qxqj =' +Formatfloat('0.00',dRec.CoalseamAngle) +
          ', qxc =' + Formatfloat('0.00',dRec.WorkFaceLength)+ ', zxc= '  +
          Formatfloat('0.00',dRec.TowardDistance) +', mtyd ='  +Formatfloat('0.0',dRec.Coalhardness) +
          ',gc=' +Formatfloat('0',dRec.AVGBuriedDepth)  +',kch='+ Formatfloat('0.0',dRec.CoalMiningHeigth) +
          ',supstartNumber= '+IntToSTr(dRec.SupStartNumber) +
          ',supEndNumber='+ IntToSTr(dRec.supEndNumber) +
          ' ,supNumberDirection='+IntToSTr(dRec.SupDirection) +
          ',TRFirstDrillPress= '+Formatfloat('0.00',dRec.TransportRoadwayFirstDrillPressLocation) +
          ',TRSecondDrillPress= '+Formatfloat('0.00',dRec.TransportRoadwaySecondDrillPressLocation) +
          ',PRFirstDrillPress= '+Formatfloat('0.00',dRec.PathwayRoadWayFirstDrillPressLocation) +
          ',PrSecondDrillPress= '+Formatfloat('0.00',dRec.PathwayRoadWaySecondDrillPressLocation) +
          ',qyzt=1'+
          ' where cqName='''  + dRec.WorkFaceName +'''';
   try
    Gzm_command1.CommandText:=sql;
    Gzm_Command1.Execute ;

   finally
      Result:=true;
   end;
   Gzm_command1.free;
end;

function TGzm.UpdateWorkFaceFullData(Gzmid:integer): Boolean;
var
  sql:string;
  Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TmyCommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn ;
    Result:=false;
    sql:=' update   cqcsb  set  '
          +  ' cqName = '''+ S_Name + ''','     //2
          +  ' mcid   = ' +  S_mc_name +',' //3
          +  ' kch    = ' +   FormatFloat('0.00',S_Cg_h) + ',' //4
          +  ' cmfa   = ' +   IntTostr(S_CMFS_INteger)  + ',' //5
          +  ' speed  = ' +   FormatFloat('0.00',S_DayStep_speed) + ',' //6
          +  ' qxqj   = ' +   FormatFloat('0.00',S_qj) + ',' //7
          +  ' zxqj   = ' +   FormatFloat('0.00',S_SX_qj) + ',' //8
          +  ' sh1    = ' +   FormatFloat('0.00',S_Sh_UP) + ',' //9
          +  ' sh2    = ' +   FormatFloat('0.00',S_Sh_Down) + ',' //10
          +  ' gc     = ' +   FormatFloat('0.00',S_mcsd_h) + ',' //11
          +  ' qxc    = ' +   FormatFloat('0.00',S_L_qx) + ',' //12
          +  ' zxc    = ' +   FormatFloat('0.00',S_Sx_zx) + ',' //13
          +  ' mtyd   = ' +   FormatFloat('0.00',S_f_PS) + ',' //14

          +  ' yxfx   = ' +   IntTostr(Dz_yxfx)  + ',' //15
          +  ' jyhd   = ' +   IntTostr(Dz_JYHD)  + ',' //16
          +  ' dcgz   = ' +   IntTostr(Dz_DCGZ)  + ',' //17
          +  ' wsfc   = ' +   IntTostr(Dz_WSFC)  + ',' //18
          +  ' topwater    = ' +   IntTostr(Dz_TopWater)  + ',' //19
          +  ' bottomwater = ' +   IntTostr(Dz_BottomWater)  + ',' //20
          +  ' heostress   = ' +   IntTostr(Dz_HeoStress)  + ',' //21
          +  ' kyxx   = ' +   IntTostr(Dz_Kyxx)  + ',' //22
          +  ' hangdaosup  = ' +   IntTostr(Dz_HangDaoSup)  + ',' //23
          +  ' kccd   = ' +   FormatFloat('0.00',S_Jc_L) + ',' //28
          +  ' supstartNumber = ' +   IntTostr(SupStartNumber)  + ',' //29
          +  ' supEndNumber   = ' +   IntTostr(SupEndUsedNumber)  + ',' //30
          +  ' supNumberDirection   = ' +   IntTostr(SupNumberDirection) +','  //31
          +  ' zjxh = '''+ ZjName  + ''','   //32
          +  ' mch  =' +FormatFloat('.##',S_Agv_mch)           //33
          +  ' where kid = '+  IntTostr(KuangJingId )  + ' and cqid = ' +  inttoStr(Gzmid);
   try
    Gzm_command1.CommandText:=sql;
    Gzm_Command1.Execute ;

   finally
      Result:=true;
   end;
   Gzm_command1.free;
end;

function TGzm.UpdataFootStepParameters(strValue,supportNumber: string): Boolean;
var
  sql:string;
  Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TmyCommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn ;
    Result:=false;
    if length(Trim(strValue))> 198 then  exit;

    sql:=' update cqcsb  set Memo1 =''' +strValue  + ''' ,SupEndNumber = ' + supportNumber +
          ' where cqid='  +IntTostr(Gzmbh)  ;
   try
    Gzm_command1.CommandText:=sql;
    Gzm_Command1.Execute ;

   finally
      Result:=true;
   end;
   Gzm_command1.free;

end;

function TGzm.UpdataRockPress_Process(timeorProcess: integer; strDate: string;
  Flag: integer): Boolean;
  {
     timeorProcess: =0  ������ ����ʱ�������и���      =1 �����Ǹ��� ��������и���



  }
var
  Gzm_Command1:TMyCommand;
  SQL:String;
begin
    Gzm_Command1:=TmyCommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn ;
   Result:=false;

   try
       if timeorProcess=0  then  begin
          Sql:='update d_'+IntTostr(Gzmbh) +'_ManualInputPressData set process = '+ IntToStr(Flag)+
               ' where generatetime >= ' +strDate ;
       end else if timeorProcess=1 then  begin
          Sql:='update d_'+IntTostr(Gzmbh) +'_ManualInputPressData set process = '+ IntToStr(Flag)+
               ' where process=0 ' ;
       end;

      Gzm_Command1.CommandText:=sql;
      Gzm_Command1.Execute ;
      Result:=true;

   finally
      FreeAndNil(Gzm_Command1);
   end;


end;

function TGzm.UpdateCoalPillarToDataBase(nCoalPillar:TCoalPillar): Boolean;
var
  Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TmyCommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn ;
   Result:=false;
   Gzm_Command1.MySqlConnection.BeginTrans;
   try
       Gzm_Command1.CommandText:=' delete  from  mz_coalPillar   WHERE gzmid = '+Trim(inttostr(nCoalPillar.gzmidbh))+
            ' and mzName =  ''' +nCoalPillar.Name+'''';
       Gzm_Command1.Execute ;

        self.InsertCoalPillarToDataBase(nCoalPillar) ;
   finally
       Gzm_Command1.MySqlConnection.CommitTrans ;
       Result:=true;
   end;
   Gzm_command1.free;
end;


function TGzm.UpdateColorString(StrValue: string): Boolean;
var
  sql:string;
  Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TmyCommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn ;
    Result:=false;
    if length(Trim(strValue))> 198 then  exit;

    sql:=' update cqcsb  set ColorString =''' +strValue  + '''' +
          ' where cqid='  +IntTostr(Gzmbh)  ;
   try
    Gzm_command1.CommandText:=sql;
    Gzm_Command1.Execute ;

   finally
      Result:=true;
   end;
   Gzm_command1.free;


end;

function TGzm.UpdateDrillDateBase(innD: Tzk_bore): Boolean;
var
  sql:string;
  zkid,i:integer;
  Gzm_Command1:TMyCommand;
begin
    Gzm_Command1:=TmyCommand.create(nil);
    Gzm_Command1.MySqlConnection:= MyExConn ;
     Result:=false;
     zkid:=IsExistDrillInfo(innd.Zk_name);
     Gzm_Command1.CommandText:=' delete from zkycb where  zkid= '+IntToStr(Zkid) +
                             ' and kid= ' +IntToStr(innd.Mineid) ;
     Gzm_Command1.Execute ;

     //insert
     Gzm_command1.MySqlConnection.BeginTrans ;
     try
         for I := 0 to innD.Zk_Yc_Count-1 do  begin
             sql := 'insert into zkycb (kid,zkid,yczkid,ysmc,hd,kyqd,klqd,rz,mcid,szxs) values (' +
                    intTostr(innD.Mineid) +','+InttoStr(Zkid)+','+InttoStr(innD.Yc_Rock[i].Yc_No)+',''' +
                    innD.Yc_Rock[i].R_Name +''','+ Formatfloat('0.00',innD.Yc_Rock[i].R_h) +
                    ','+Formatfloat('0.00',innD.Yc_Rock[i].R_kyqd)+',' + Formatfloat('0.00',innD.Yc_Rock[i].R_klqd)+
                    ','+Formatfloat('0.00',innD.Yc_Rock[i].R_r)+','+ intTostr(innD.Yc_Rock[i].MCId)+','+
                    '1.3) ' ;
              Gzm_command1.CommandText:=sql;
              Gzm_Command1.Execute ;

         end;
          Gzm_command1.MySqlConnection.CommitTrans;
   except
        Gzm_command1.MySqlConnection.RollbackTrans ;
        exit;
   end;
    Result:=true;
    Gzm_command1.free;

end;

function TGzm.UpdateDrillFullDAta(innD: Tzk_bore): Boolean;
var
  sql:string;
  zkid,i:integer;
  Gzm_Command1:TMyCommand;
  sffc,sfhsc:string;
begin
     Gzm_Command1:=TmyCommand.create(nil);
     Gzm_Command1.MySqlConnection:= MyExConn ;
     Result:=false;
     zkid:=IsExistDrillInfo(innd.Zk_name);
     Gzm_Command1.CommandText:=' delete from zkycb where  zkid= '+IntToStr(Zkid) +
                             ' and kid= ' +IntToStr(innd.Mineid) ;
     Gzm_Command1.Execute ;

     //insert
     try
         for I := 0 to innD.Zk_Yc_Count-1 do  begin
              if innD.Yc_Rock[i].R_sffc then   sffc:='1' else sffc:='0' ;
              if innD.Yc_Rock[i].R_sfhsc then  sfhsc :='1' else sfhsc:='0';
              sql := 'insert into zkycb (kid,zkid,yczkid,ysmc,minhd,maxhd,hd,kyqd,klqd,kjqd,rz,mcid,BmpFile'
                    + ',szxs,sffc,fchd,sfhsc) values ('
                    + intTostr(innD.Mineid) +','+InttoStr(Zkid)+','+InttoStr(innD.Yc_Rock[i].Yc_No)+','''
                    + innD.Yc_Rock[i].R_Name +''','+ Formatfloat('0.00',innD.Yc_Rock[i].R_MinH) +','
                    + Formatfloat('0.00',innD.Yc_Rock[i].R_MaxH) +','+  Formatfloat('0.00',innD.Yc_Rock[i].R_h) +','
                    + Formatfloat('0.00',innD.Yc_Rock[i].R_kyqd)+',' + Formatfloat('0.00',innD.Yc_Rock[i].R_klqd)+ ','
                    + Formatfloat('0.00',innD.Yc_Rock[i].R_kjqd)+','+Formatfloat('0.00',innD.Yc_Rock[i].R_r)+','
                    + intTostr(innD.Yc_Rock[i].MCId)+',''' +innD.Yc_Rock[i].BMP_File +''','
                    + Formatfloat('0.00',innD.Yc_Rock[i].R_k_Rock) + ','+ sffc + ','
                    + Formatfloat('0.00',innD.Yc_Rock[i].R_fchd) +','+sfhsc
                    + ') ' ;
              Gzm_command1.CommandText:=sql;
              Gzm_Command1.Execute ;

         end;

   except
       exit;
   end;
    Result:=true;
    Gzm_command1.free;
end;

{ TCoalPillar }





{ TMineOutArea }

function TMineOutArea.forcase(ArraOutNumber: integer; jinChi: double;
       t_Gzm: TG_Stope;uOldComePress:Boolean; var ChildRoot: TXmlNode): Boolean;
var
  ChildChildRoot,ChildChildChildRoot:TXmlNode;
  ICount:integer;
  MinDis,MaxDis:double;
  DiplayStr:string;
begin
     // nLeft,nRight,nFront,nbehind,nTop,nBottom
     Result:=false;
     ChildChildRoot:=ChildRoot.NodeNew('');
     ChildChildRoot.Name:=UTF8String('MineAreaOutWaringNo:'+IntToStr(ArraOutNumber));
     ICount:=1;
     if safedistance <0  then   safedistance:=20;

     if  location = nLeft then  begin
            if (dis_left > t_gzm.ZCYL_sx[1] )  and(dis_left <2*t_gzm.ZCYL_sx[1]) then  begin
                Result:=true;
                ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                ChildChildChildRoot.Name:=UTF8String(intTostr(iCount));
                ChildChildChildRoot.Value :=UTF8String('��ࡾ'+self.Name+'���ɿ����Կ�����������ʱ�̹�ע����ú��ѹ���仯'+
                              '��ֹú���ĳ����');
                iCount:=iCount+1;
            end else if (dis_left <= t_gzm.ZCYL_sx[1] )  and ((dis_left > self.safedistance) or
                      ((dis_left >2* t_gzm.ZCYL_s1[1]) ))  and  uOldComePress then  begin

                  if (t_gzm.S_f_PS>=5) or (t_gzm.S_mcsd_h >500)  then   begin
                      Result:=true;
                  end else begin
                      Result:=true;
                  end;
                  if Result then  begin
                        ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                        ChildChildChildRoot.Name:=UTF8String(intTostr(iCount));
                        ChildChildChildRoot.Value :=UTF8String('��ࡾ'+self.Name+'����в�ù��������ú�壬�ڹ�����������ѹ�ڼ�'+
                                '��ֹ���������ú��ĳ����');
                        iCount:=iCount+1;
                  end;
            end ;
      end else if self.location = nRight then  begin
          if (dis_right > t_gzm.ZCYL_sx[3] )  and(dis_right <2*t_gzm.ZCYL_sx[3]) then  begin
              Result:=true;
              ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
              ChildChildChildRoot.Name:=UTF8String(intTostr(iCount));
              ChildChildChildRoot.Value :=UTF8String('�Ҳࡾ'+self.Name+'���ɿ����Կ�����������ʱ�̹�ע����ú��ѹ���仯'+
                            '��ֹú���ĳ����');
              iCount:=iCount+1;
          end else if (dis_right <= t_gzm.ZCYL_sx[3] )  and ((dis_right > self.safedistance) or
                    ((dis_right >2* t_gzm.ZCYL_s1[3]) )) and uOldComePress then  begin

                if (t_gzm.S_f_PS>=5) or (t_gzm.S_mcsd_h >500)  then   begin
                    Result:=true;
                end else begin
                    Result:=false;
                end;
                if Result then  begin
                      ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                      ChildChildChildRoot.Name:=UTF8String(intTostr(iCount));
                      ChildChildChildRoot.Value :=UTF8String('�Ҳࡾ'+self.Name+'���ɿ�����в�������Ҳ�ú�壬�ڹ�����������ѹ�ڼ�'+
                              '��ֹ�������Ҳ�ú��ĳ����');
                      iCount:=iCount+1;
                end;
          end;
       end else if self.location = nFront then  begin
          if (dis_Front-jinchi >0) and ( dis_Front-jinchi > t_gzm.ZCYL_sx[3] )
               and(dis_Front-jinchi  < 2*t_gzm.ZCYL_sx[3]) and uOldComePress then  begin
              Result:=true;
              ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
              ChildChildChildRoot.Name:=UTF8String(intTostr(iCount));
              ChildChildChildRoot.Value :=UTF8String('ͣ���߸�����'+self.Name+'���ɿ�����вǰ��ú�壬ʱ��ǰ��ú��ѹ���仯'+
                            '�ر�����������ѹ�ڼ䣬��ֹ������ǰ��ú��ĳ����');
              iCount:=iCount+1;
          end else if (dis_Front-jinchi >0)  and (dis_Front-jinchi <= t_gzm.ZCYL_sx[3] )  and
                    ((dis_Front-jinchi > self.safedistance) or   ((dis_Front-jinchi >2* t_gzm.ZCYL_s1[3]) )) then  begin
                if (t_gzm.S_f_PS>=5) or (t_gzm.S_mcsd_h >500)  then   begin
                    Result:=true;
                end else begin
                    Result:=false;
                end;
                if Result then  begin
                      ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                      ChildChildChildRoot.Name:=UTF8String(intTostr(iCount));
                      ChildChildChildRoot.Value :=UTF8String('��'+self.Name+'���ɿ�����вǰ��ú�壬'+
                            '��ǿ��ǰ��ú����м�ļ�⣬��ȡ���з���Ԥ��ǰ��ú��ĳ����');
                      iCount:=iCount+1;
                end;
          end;
        end else if self.location = nbehind then  begin
          if (dis_Behind+jinchi< t_gzm.ZCYL_sx[3] ) and ( dis_Behind+jinchi > 2* t_gzm.ZCYL_s1[2] )
                  and uOldComePress  then  begin
              Result:=true;
              ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
              ChildChildChildRoot.Name:=UTF8String(intTostr(iCount));
              ChildChildChildRoot.Value :=UTF8String('�����۸�����'+self.Name+'���ɿ����Թ�������Ӱ�죬���϶�������ѹ�ڼ�'+
                            '�ʵ��ӿ��ƽ��ٶȣ�Ԥ�����������շ���ú�����');
              iCount:=iCount+1;
           end;
        end else if self.location = ntop then  begin
          if (dis_Top > t_gzm.S_Cg_h*4  ) and (dis_Top < t_gzm.S_Cg_h*10  )  and uOldComePress then  begin
              Result:=true;
              ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
              ChildChildChildRoot.Name:=UTF8String(intTostr(iCount));
              ChildChildChildRoot.Value :=UTF8String('������ڡ�'+self.Name+'���ɿ���,����ѹ�������ٶȽϿ죬ע��������ѹ�ڼ� '+
                                '�ʵ��ӿ��ƽ��ٶȣ�Ԥ��֧��ѹ������');
              iCount:=iCount+1;
           end else if (dis_Top <= t_gzm.S_Cg_h*4  ) then  begin
              Result:=true;
              ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
              ChildChildChildRoot.Name:=UTF8String(intTostr(iCount));
              ChildChildChildRoot.Value :=UTF8String('������ڡ�'+self.Name+'���ɿ���,����ѹ�������ٶȽϿ죬ƽ���ƽ��ٶ�'+
                                           'Ԥ��֧��ѹ������');
              iCount:=iCount+1;
           end;
       end else if self.location = nBottom then  begin
          if (dis_Bottom > self.heigth *3  ) and (self.width > heigth *3 )
                and(self.width < t_gzm.S_L_qx  )  and  uOldComePress then  begin
              Result:=true;
              ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
              ChildChildChildRoot.Name:=UTF8String(intTostr(iCount));
              ChildChildChildRoot.Value :=UTF8String('�װ���ڡ�'+self.Name+'���ɿ���,�ù�����ʵ�п��ɱ�����Ŀ��ɷ���'+
                                '�����㿪��״̬һ�㣬��עú���ص�����ѹ���仯');
              iCount:=iCount+1;
           end else if (dis_Bottom < self.heigth *3  )and  uOldComePress then  begin
              Result:=true;
              ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
              ChildChildChildRoot.Name:=UTF8String(intTostr(iCount));
              ChildChildChildRoot.Value :=UTF8String('�װ���ڡ�'+self.Name+'���ɿ���,�װ岻�ȶ���ע��֧����̬');
              iCount:=iCount+1;
           end;

     end; // ����   if self.location = nLeft

end;

{ TCoalPillar }

function TCoalPillar.forcase(CoalPillarNumber: integer; jinChi: double;
  t_Gzm: TG_Stope; uOldComePress: Boolean; var ChildRoot: TXmlNode): Boolean;
var
  ChildChildRoot,ChildChildChildRoot:TXmlNode;
  ICount:integer;
  MinDis,MaxDis:double;
  DiplayStr:string;
begin
     // nLeft,nRight,nFront,nbehind,nTop,nBottom
     Result:=false;
     ChildChildRoot:=ChildRoot.NodeNew('');
     ChildChildRoot.Name:=UTF8String('CoalPillarWaringNo:'+IntToStr(CoalPillarNumber));
     ICount:=1;
     if safedistance <0  then   safedistance:=20;
     if self.location = nLeft then  begin
            if (dis_left > t_gzm.ZCYL_sx[1] )  and(dis_left <2*t_gzm.ZCYL_sx[1]) then  begin
                Result:=true;
                ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                ChildChildChildRoot.Name:=UTF8String(intTostr(iCount));
                ChildChildChildRoot.Value :=UTF8String('��ࡾ'+self.Name+'��ú���Կ�����������ʱ�̹�ע����ú��ѹ���仯'+
                              '��ֹú���ĳ����');
                iCount:=iCount+1;
            end else if (dis_left <= t_gzm.ZCYL_sx[1] )  and ((dis_left > self.safedistance) or
                      ((dis_left >2* t_gzm.ZCYL_s1[1]) ))  and  uOldComePress then  begin

                  if (t_gzm.S_f_PS>=5) or (t_gzm.S_mcsd_h >500)  then   begin
                      Result:=true;
                  end else begin
                      Result:=true;
                  end;
                  if Result then  begin
                        ChildChildChildRoot:= ChildChildRoot.NodeNew('') ;
                        ChildChildChildRoot.Name:=UTF8String(intTostr(iCount));
                        ChildChildChildRoot.Value :=UTF8String('��ࡾ'+self.Name+'����в�ù��������ú�壬�ڹ�����������ѹ�ڼ�'+
                                '��ֹ���������ú��ĳ����');
                        iCount:=iCount+1;
                  end;
            end ;
     end;
end;

end.