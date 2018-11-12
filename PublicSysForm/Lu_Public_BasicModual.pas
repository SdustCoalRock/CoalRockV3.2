//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//<<      �ļ�����Lu_base_function.pas
//<<      luleʹ�õĸ���Delphi�ļ�                            <<
//<<      ���ںö����õ��ú�����Ҫ���������ഴ��ǰ������      <<
//<<      �������ڣ�2018.1.12                                   <<
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

unit Lu_Public_BasicModual;

interface
 //===============
 uses
  Windows, SysUtils, Classes, Messages, Controls, Forms, StdCtrls, ExtCtrls,
  ComCtrls ,math,Grids,WordXP,COMobj,StrUtils,Vcl.Graphics,IniFiles;

 //---����һ����ά�ַ�������࣬���ڷָ��
 type Str_DT_array=array of widestring;


 //��������
 type
  Rec_StringMereg=Record
     FromCol:integer;
     FromRow:integer;
     ToCol:integer;
     ToRow:integer;
  End;

  Rec_StringToExcel_Array =Array of Rec_StringMereg;



  PMyRec = ^TMyRec;
     TMyRec = record
     BName: String;
     DName: String;
     XHeight:String;
   end;

   TMYPoint=record
     x:integer;
     Y:integer;
     PrvId:Integer;
     Nextid:integer;
   end;

 TIni = class(TObject)
    fIniReader: TiniFile;
    fpath: string;
    fIsOpen: boolean;
  public
    //�õ�Config.ini�ļ��е�������Ϣ
    constructor Create(MinPath,FileName: string );
    procedure iniClose(FileName: string  );
    function iniIsOpen(FileName: string ): boolean;               //�Ƿ�Ini �ļ�����
    function iniGetStr(ID: string; secName: string ): string;
    function iniGetInt(ID: string; secName: string ): integer;
    function iniGetFloat(ID: string; secName: string ): Double;
    function iniSetStr(newValue: string; ID: string; secName: string): boolean;
  end;


  TIniObj = class(Tini)
    DataType: string;
    SrvIP: string;
    DataBaseName: string;
    UserName: String;
    PassWord: String;
    FilePath: String;
    ServerPause: integer;
    StartTime: String;
    totalNumber: integer;
    SupDTV1:Integer;
    SuPDTV2:integer;
    SupDTV3:integer;
    SupDTv4:integer;
    TimeInterval:integer;
    DataNeverDisCTime:integer;
    ThreadNumber:Integer;

  public
    procedure LoadIni;
    procedure SaveIni(sDatType,sIP,sDName,sUN,sPw,sFP,sPause,sStart,StolN,
                      sV1,sV2,Sv3,Sv4,TIV,TDec: string);
  end;
 //�ⲿʹ�� ��������
 TLu_BasicClass=Class
   private
      In_UseUnitName:string;  {ʹ�õ�λ���}
      in_Licensing:Boolean;  {�����Ƿ�ͨ��}

      FReadIni:TIniObj;
      inFilePath:string;
      inFileNmae:string;
      StatUsBarRightStr:String;
      procedure WriteIniReadIniTimeInterval(Vaule: Integer);
      procedure SetUseUnitName(Value:string);
      function  GetUseUnitName:string;
      procedure SetLicensing(Value:Boolean);
      function  GetLicensing:Boolean;

   public
       FSetting:TFormatSettings;  //���ڸ�ʽת��
       //-----�ַ����ָ��        //��һ��Ϊ ���ָ���ַ������ڶ���Ϊ�ָ��ַ���������Ϊ�����±�
       function split(s: string; dot: char; out ret:Integer): Str_DT_array;
       //-----�ַ�ת����ֵ��������Ҫ������ַ��������⣩
       function StrToDouble_Lu(s:widestring):double;
       function StrToInt_lu(s:widestring):Integer;

       function FirstStep(mc,ms,qs,rs,qj:double):double;  //mc�涯�㣬ms֧�в��� qs ֧�в㿹��ǿ��, rs ֧�в����� ��qj���
       function NextStep(c,i,mc,ms,qs,rs,qj:double):double ;//c ��һ�εĲ��࣬i�ڼ��Σ�
       //�ж����ֵ����Сֵ
       function Select_max(a1,a2,a3,a4:double):double;
       function select_min(a1,a2,a3,a4:double):double;
       function IsPtInPoly(ALon, ALat: double; APoints: array of TPoint): Boolean;
       function StringGridtoExcel(atitle: string; Astringgrid: Tstringgrid; Afontsize: integer):String;stdcall;
       function StringGridToExcel_MegerCell(Disp:Boolean;atitle: string; Astringgrid: Tstringgrid;
                               Afontsize: integer;arry:Rec_StringToExcel_Array;Path:string):String;stdcall;
       function FindPointY(X,Y:Integer;t_List:TStringList;Leixing:integer):Integer;stdcall;
       //��������
       function Lu_spline(Px,Py:array of double;Num:integer; VAR lux,luy:array of double;var L_n:integer):Boolean;stdcall;

       //����ʵ�� UTF8String  to WideString ��ת��
       function DecodeUtf8Str(const S:UTF8String): WideString; var lenSrc,lenDst  : Integer;
       // һ��������д�����¼�ĺ���
       procedure MY_WriteLog(const data:Ansistring; FFM : Ansistring='FFQ' );
       // ��ȡģ���·��
       function Get_MyModulePath:WideString;
       //��ת��ӡ����
       procedure CanvasRotatedText(Canvas:TCanVas;px,py:integer;FontName:TFontName;FontSize:integer;Angle:integer;
                 FontColor:TColor;StrOut:String);
       //===================
        // control ini
      function SaveIniFile(sData, sIp,sUser, SPw,sPath,Port:string):boolean;  // ���� ini����
      function ReadIniProcess(var sttime:TDateTime;Var Paused,totalNumber:integer):Boolean;  //  ��ȡini��������
      Procedure WriteIniProcess(StTime:TdateTime;Paused:integer); // дini��������
      Procedure WriteiniTotalNumber(TotalN:integer); // дini��������
      procedure ReadServerinfo(var S1, S2, S3,S4,S5,S6: string);  //�� ���ݿ�����
      function ReadIniTimeInterval:integer;   // ��ini����ʱ����
      procedure WriteIniTimeInterval(Vaule:Integer); //дini����ʱ����
      function ReadiniDataNeverDisCTime:Integer;  //�� iniʱ�䲻��ϼ��
      procedure WriteIniDAtaNeverDisCTime(Value:integer);// дiniʱ�䲻��ϼ��
      function ReadiniThreadNumber:integer;     //   ���̵߳�����
      procedure WriteINiThreadNumber(Value:integer); // д�̵߳�����
      function ReadiniTotalNumber:integer; //����¼
      procedure WriteIniSaveProcesslog(Value:Boolean);// д�Ƿ񱣴洦����¼
      function ReadiniSaveProcesslog:Boolean;// ���Ƿ񱣴洦����¼
      procedure WriteSYStemDataBaseName(Value:string);// д���ݿ�������
      function ReadSYStemDataBaseName:String;// �����ݿ�������
      procedure WriteDisplayWholeScreen(Value:integer);//д�Ƿ�ȫ����ʾ
      function ReadDisplayWholeScreen:integer;//���Ƿ�ȫ����ʾ
      procedure WriteSnapData(Value:Boolean;ip,Port:string);//д�Ƿ�ʹ�õ�����
      function  ReadSnapData(var snapIP,SnapPort:String):Boolean;// ���Ƿ�ʹ�õ���������
      procedure WriteUpdateCoalBmp(Value:Boolean); // д���±��ؿ�ͼ�ļ�
      function  ReadUpdataCoalBmp:Boolean; // �����±��ؿ�ͼ�ļ�
      procedure WriteMakeWordPercent(state:Boolean;Percent:integer); // �� ��ӡ����� ����д��ȥ
      function  ReadMakeWordPercent(Var Percent:integer):Boolean; // �Ѵ�ӡ����Ľ��ȶ�����
     //
      {��д�������ͱ��}
      function Gzm_ReadiniSV(Gzmbh:String;var V1,V2,V3,V4:Integer):Boolean;
      procedure Gzm_WriteiniSV(Gzmbh:string;V1,V2,V3,V4:Integer);
      function ReadiniSV(Setting:string;var V1,V2,V3,V4:Integer):Boolean;  // ��ȡini��si�ĸ�����ֵ
      Procedure WriteiniSV(Setting:string;V1,V2,V3,V4:Integer);//дini��si�ĸ�����ֵ
      function CreateIniFile:Boolean;
      // 2018.1.1
      function ReadMySqlDataBase(DataTypeString: string;
                    var IP,UserName,Password,Port,DataBaseName:string):Boolean;
      function WriteMYSQLDataBase(DataTypeString: string;
                    IP,UserName,Password,Port,DataBaseName:string):Boolean;
      function ReadDataBaseType(var DataType:string):Boolean;
      function WriteDataBaseType(DataType:String):Boolean;
      function ReadUsedMeiKuangInfo(SetString:String;var mkid,mkName,gzmid,
                     GzmName,zkid,ZkName:string):Boolean;
      function WriteUsedMeiKuanginfo(SetString, mkid,mkName,gzmid,GzmName,zkid,ZkName:string):Boolean;
      function WriteLoginInfo(SetString,UserName,UserId,Admin:String):Boolean;
      function ReadLoginInfo(Setstring:String;Var UserName,UserId,Admin:string):Boolean;
      //
      function ReadMainFormVersion(var Captionid:integer; var Version:string):Integer;
      procedure WriteMainFormVersion(CaptionID,Version:String);
      //VerFity Password
      procedure WriteVirFityPassword(UN,Password:string);
      function  GetVifFityInfo(Var Name,PerString :string):Boolean;
      //TestAndVersion
      Procedure WriteTestAndOriginal(Test_Str:String);
      function GetTestInfomation:String;
      // set StatusBar    // ������ƺ���
      procedure InitStatusBar(StatusBar: TStatusBar);
      procedure SetStatusCaption(Value:String);
      //Add waterBMP
      procedure AddSingleTextWaterFormImage(Imag:TImage);
      procedure AddSingleTextWaterFromFile(FileName:String);
      procedure AddMultTextWaterFormImage(Imag:TImage);
      procedure AddMultTextWaterFormFile(FileName:String);
      function  GetChineseNumber(Value:Integer):String;
      function  LoadWaterFile(FileNAme:String;Imag:Timage):Boolean;
      //�������ݿ����Ͳ�ͬ�����������Ͳ����ַ�����ͬ
      function ReturnDateTimeString(DataType:String;dt:TdateTime):String;
      procedure ScreenSnap(pt1,pt2:Tpoint; pic_path: string);
      // �����ķ���
      property UseUnitName:String  read GetUseUnitName write SetUseUnitName;
      property Licensing:Boolean  read GetLicensing write SetLicensing;


      constructor Create(FilePath,FileName:string);
      destructor Destroy;override;
 End;

 VAR
   Public_Basic:TLu_BasicClass;
//   FsyncSQL:Trtlcriticalsection; // ����һ���칹���ռ� ,����������������
//   MySQLTableNameList       :TStringlist;  // ΪMYSQl���ݿ� ��ռʹ�õ��ַ�����
implementation




procedure TLu_BasicClass.AddSingleTextWaterFormImage(Imag: TImage);
var
  TextLeft,TextTop:integer;
begin
    Imag.Picture.Bitmap.Canvas.Font.Size :=18 ;
    Imag.Picture.Bitmap.Canvas.Font.Name :='����';
    Imag.Picture.Bitmap.Canvas.Brush.Style := bsClear;
    Imag.Picture.Bitmap.Canvas.Font.Color :=clGray;
    TextLeft:=Round((Imag.Width-(length(UseUnitName)*Imag.Picture.Bitmap.Canvas.Font.Size))/2)-20;
    TextTop:=Round(Imag.Height/2)-10;
    Imag.Picture.Bitmap.Canvas.TextOut(TextLeft,TextTop,Trim(UseUnitName));
end;

procedure TLu_BasicClass.AddSingleTextWaterFromFile(FileName: string);
var
  Image1:Timage;
begin
   Image1:=Timage.Create(nil);
   try
      LoadWaterFile(FileName,Image1);
      AddSingleTextWaterFormImage(Image1);
      Image1.Picture.SaveToFile(FileName);
   finally
     FreeAndNil(Image1);
   end;

end;

procedure TLu_BasicClass.CanvasRotatedText(Canvas: TCanVas; px, py: integer;
  FontName: TFontName; FontSize, Angle: integer; FontColor: TColor;
  StrOut: String);
var
  lf:TLogFont;
  tf:TFont;
begin

      with Canvas do begin
              Font.Name :=FontName;
              Font.Size :=FontSize;
              Font.Color:=FontColor;
              Brush.style :=bsClear;
              tf:=TFont.Create ;
              tf.Assign(Font);
              GetObject(tf.Handle,sizeof(lf),@lf);
              lf.lfEscapement :=Angle*10;
              lf.lfOrientation :=Angle*10;
              tf.Handle :=CreateFontIndirect(lf);
              Font.Assign(tf);
              tf.Free ;

              textout(px,py,StrOut );
      end;

end;

constructor TLu_BasicClass.Create(FilePath, FileName: string);
begin
   inFilePath:=Filepath;
   if inFilePath='' then
      inFilePath:=self.Get_MyModulePath ;
   inFileNmae:=FileName;
   FReadIni:=TIniObj.Create(inFilepath,inFileNmae);
   StatUsBarRightStr:='������Ժʿ�Ŷ��з� CopyRight (2016-2018)';
    //���ڸ�ʽת��
       FSetting.ShortDateFormat:='yyyy-mm-ss' ;
       FSetting.DateSeparator :='-';
       FSetting.ShortTimeFormat :='HH:mm:ss';
       FSetting.TimeSeparator :=':';
       FSetting.DecimalSeparator :='.';
end;

function TLu_BasicClass.CreateIniFile: Boolean;
begin
   Result:=false;
   self.WriteIniDAtaNeverDisCTime(2);
   self.WriteINiThreadNumber(10);
   self.WriteSYStemDataBaseName('RockPress');
   self.WriteIniSaveProcesslog(false);
   self.WriteIniReadIniTimeInterval(1);
   Result:=true;
end;

function TLu_BasicClass.DecodeUtf8Str(const S: UTF8String): WideString;
 {//����ʵ�� UTF8String  to WideString ��ת��}
begin
   lenSrc  := Length(S);
   if(lenSrc=0)then Exit;
    lenDst  := MultiByteToWideChar(CP_UTF8, 0, Pointer(S),lenSrc, nil, 0);
    SetLength(Result, lenDst);
    MultiByteToWideChar(CP_UTF8, 0, Pointer(S),lenSrc, Pointer(Result), lenDst);
end;

destructor TLu_BasicClass.Destroy;
begin
  if Assigned(FReadIni) then  FreeAndNil(FReadIni);
  inherited;
end;

function TLu_BasicClass.FindPointY(X, Y: Integer; t_List: TStringList;
  Leixing: integer): Integer;

 {*------------------------------------------------------------------------------
  �ж�ָ�����ĵ��ڸ������ַ����� Y��λ��
  @param X   ָ�����X
  @param Y   ָ�����γ�� Y
  @param t_List  ָ�� ���꼯�ϵ�
  @return Y ���ڷ�Χ�� False ���ڷ�Χ��  ����Y��ֵ
------------------------------------------------------------------------------*  }
var
   I,t,max,min,count1,count2 ,X_1,Y_1:integer;
   temp1,temp2 :Str_Dt_array;
   while_T:Boolean;
 begin
      if t_List.Count<1  then  begin
        result:=Y;
        exit;
      end;

      max:=t_List.Count - 1;
      Min:=0;
      while_T:=true;
      t:=trunc((max+min)/2);

      while while_T do  begin
          temp1:=split(t_list[t],',',Count1);
           X_1:=StrToInt(temp1[0]);
           if X_1<10 then begin
              result:=Y;
              while_T:=false;
              exit;
           end;
          if X_1 < X then begin
               min:=t;
           end else if X_1 = X then begin
               Min:=t;
               Max:=t+1;
           end else begin
               Max:=t;
           end;
           if max-min <2 then   begin
              while_T:=false;
           end  else begin
              t:=trunc((max+min)/2);
           end;
      end;  // end while

         temp1:=split(t_list[min],',',Count1);
         temp2:=split(t_list[Max],',',Count1);

         Y_1:=StrToInt(temp2[1])+ trunc((StrToInt(temp2[0])-X)*(StrToInt(temp1[1])-StrToInt(temp2[1]))/(StrToInt(temp2[0])-StrToInt(temp1[0])));
         if Y < y_1 then   begin
            if leixing=1 then begin
               result:=Y_1;
            end else begin
               result:=Y;
            end;
         end else begin
             result:=Y_1;
         end;

end;

function TLu_BasicClass.FirstStep(mc, ms, qs, rs, qj: double): double;
var
     D_temp :double;
begin
     D_temp:=sqrt((2.0*ms*ms*qs*1000)/((ms+mc)*rs*cos(qj/180.0*3.14159)));
     Result:=D_temp;
end;

function TLu_BasicClass.GetChineseNumber(Value: Integer): String;
var
  istr:string;
begin
    istr:='';
    if Value=0 then   begin
        istr:='��';
    end else if Value=1 then   begin
        istr:='һ';
    end else if Value=2 then   begin
        istr:='��';
    end else if Value=3 then   begin
        istr:='��';
    end else if Value=4 then   begin
        istr:='��';
    end else if Value=5 then   begin
        istr:='��';
    end else if Value=6 then   begin
        istr:='��';
    end else if Value=7 then   begin
        istr:='��';
    end else if Value=8 then   begin
        istr:='��';
    end else if Value=9 then   begin
        istr:='��';
    end else if Value=10 then   begin
        istr:='ʮ';
    end else if Value=11 then   begin
        istr:='ʮһ';
    end else if Value=12 then   begin
        istr:='ʮ��';
    end;
   Result:=istr;
end;

function TLu_BasicClass.GetLicensing: Boolean;
begin
   Result:=in_Licensing;
end;

function TLu_BasicClass.GetTestInfomation: String;
var
 DataTypeString:string;
begin
    DataTypeString:='Use Unit Information';
    try
         if  not assigned(fReadini) then
                 fReadini.Create(inFilepath,inFileNmae) ;
         Result:=Trim(fReadini.iniGetStr('Original',DataTypeString));

    finally

    end;
end;

function TLu_BasicClass.GetUseUnitName: string;
begin
    Result:=In_UseUnitName;
end;

function TLu_BasicClass.GetVifFityInfo(Var Name,PerString :string):Boolean;
var
 DataTypeString:string;
begin
    DataTypeString:='Use Unit Information';
    Result:=False;
     try
         if  not assigned(fReadini) then
                 fReadini.Create(inFilepath,inFileNmae) ;
         Name:=Trim(fReadini.iniGetStr('Name',DataTypeString));
         PerString:=Trim(fReadini.iniGetStr('Permission',DataTypeString));

    finally
      Result:=true;
    end;

end;

function TLu_BasicClass.Get_MyModulePath: WideString;
var
   ModuleName,dllPath:WideString;
   i:integer;
begin
          SetLength(ModuleName, 255);
          GetModuleFileName(HInstance, PwideChar(ModuleName), Length(ModuleName));
          dllPath:=Trim(PwideChar(ModuleName)) ;
          i:=Pos('\',ReverseString(dllPath));

          dllPath:=Copy(dllPath,1,Length(dllPath)-i+1);
          Result:=dllPath;
end;

function TLu_BasicClass.Gzm_ReadiniSV(Gzmbh: String; var V1, V2, V3,
  V4: Integer): Boolean;
var
 Setting:String;
begin
  Result:=False;
   if Trim(Gzmbh)<>'' then  begin
      Setting:='SupDataType['+Trim(Gzmbh) +']';
      if not  ReadiniSV(setting,V1,V2,V3,V4) then begin
          if ReadiniSV('SupDataType[0]',V1,V2,V3,V4) then  Result:=true;
      end else begin
         Result:=true;
      end;
   end else begin
      Setting:='SupDataType[0]';
      if  ReadiniSV(setting,V1,V2,V3,V4)  then  Result:=true;
   end;
end;

procedure TLu_BasicClass.Gzm_WriteiniSV(Gzmbh: string; V1, V2, V3, V4: Integer);
var
 Setting:String;
begin
   if Trim(Gzmbh)<>'' then  begin
      Setting:='SupDataType['+Trim(Gzmbh) +']';
   end else begin
      Setting:='SupDataType[0]';
   end;
   WriteiniSV(setting,V1,V2,V3,V4);
end;

procedure TLu_BasicClass.InitStatusBar(StatusBar: TStatusBar);
var
  S_left:integer;
begin
    S_left:=Round(StatusBar.Width/3);

    if S_left < 100 then    begin
       StatusBar.Panels[2].Width := 100;
    end else begin
       StatusBar.Panels[2].Width := S_left;
    end;


    StatusBar.Panels[0].Width := S_left;
    StatusBar.Panels[1].Width := StatusBar.Width-
           StatusBar.Panels[0].Width - StatusBar.Panels[2].Width;

    StatusBar.Panels[0].Alignment :=taLeftJustify;
    StatusBar.Panels[2].Alignment :=taRightJustify;

    StatusBar.Panels[2].Text:=  StatUsBarRightStr  ;
end;

function TLu_BasicClass.IsPtInPoly(ALon, ALat: double;
  APoints: array of TPoint): Boolean;
{*------------------------------------------------------------------------------
  �ж�ָ���ľ�γ��������Ƿ�����ָ���Ķ����������
  @param ALon   ָ����ľ���
  @param ALat   ָ�����γ��
  @param APoints   ָ���������������ڵ�����
  @return True ���ڷ�Χ�� False ���ڷ�Χ��
------------------------------------------------------------------------------*}
var
  iSum, iCount, iIndex: Integer;
  dLon1, dLon2, dLat1, dLat2, dLon: double;
begin
  Result := False;
  if (Length(APoints) < 3) then
  begin
    Result := False;
    Exit;
  end;
  iSum := 0;
  iCount := Length(APoints);
  for iIndex :=0 to iCount - 1 do
  begin
    if (iIndex = iCount - 1) then
    begin
      dLon1 := APoints[iIndex].X;
      dLat1 := APoints[iIndex].Y;
      dLon2 := APoints[0].X;
      dLat2 := APoints[0].Y;
    end
    else
    begin
      dLon1 := APoints[iIndex].X;
      dLat1 := APoints[iIndex].Y;
      dLon2 := APoints[iIndex + 1].X;
      dLat2 := APoints[iIndex + 1].Y;
    end;
    if ((ALat >= dLat1) and (ALat < dLat2)) or ((ALat>=dLat2) and (ALat < dLat1)) then
    begin
      if (abs(dLat1 - dLat2) > 0) then
      begin
        dLon := dLon1 - ((dLon1 -dLon2) * (dLat1 -ALat)) / (dLat1 - dLat2);
        if (dLon < ALon) then
          Inc(iSum);
      end;
    end;

  end;
  if (iSum mod 2 <> 0) then
    Result := True;

end;

function TLu_BasicClass.LoadWaterFile(FileNAme: String; Imag: Timage): Boolean;
var
  BMP:TBitMap  ;
  wic : TWICImage;
begin
     // ���ͼƬ
      Imag.Picture.Graphic:=nil;
      Imag.Canvas.Refresh;
      Imag.Canvas.FillRect(Imag.ClientRect);
    // ����ͼƬ
     wic := TWICImage.Create;
     wic.LoadFromFile(FileName);
     bmp:=TBitMap.Create ;
     bmp.Assign(wic);

     Imag.Width:=bmp.Width ;
     Imag.Height:=bmp.Height;
     //Image1.Picture.Bitmap:=bmp;
     bmp.SaveToFile(FileNAme);
     Imag.Picture.LoadFromFile(FileNAme);
     Bmp.Free ;
     wic.Free ;

end;

function TLu_BasicClass.Lu_spline(Px, Py: array of double; Num: integer;
  var lux, luy: array of double; var L_n: integer): Boolean;
  {*------------------------------------------------------------------------------
  ��������
  @param PX    ���� X ���꼯��
  @param PY   ���� Y ���꼯��
  @param Num  ����������
  @param LuX   ���� X  ���꼯��
  @param LuY   ���� Y ���꼯��
  @param L_N   ���� ������
  @return  �ɹ�

  ע�⣺ �������ݵĸ��� ��С�� 60����һ��30������ ���
  �������ݵ��±� Ϊ 0- Num-1
  ���� ���ݵ��±� Ϊ 0- Lu_n -1
 ------------------------------------------------------------------------------*  }
var
    fx,fy:array [0..300] of double;  //
    l,a,d:array [0..100] of double;  //
    cx,cy,qx,qy,r,vx,vy : array [0..100] of double; //
    i,j,m :integer;
    k,t,t1,t2,t3,l2,l3,p1x,p1y,p2x,p2y,by,bx:double;
    x1,y1,c1,c2,u: double;
    ppx,ppy:double;
    closed:Wordbool;
    PNum:Integer;
begin

     l_n:=0;
     if Num >=  58 then begin
        result:=false;
        exit;
     end else if Num=1  then begin
        l_n:=0;
        result:=false;
        exit;
     end;
     for I := Num downto 1 do begin
         px[I]:=px[I-1];
         py[I]:=py[I-1];
     end;

     PNum:=Num;

     if pNum <6 then   begin
         m:=30;
     end else if  pNum <10 then begin
         m:=20;
     end else if  pNum <30 then begin
         m:=10;
     end else begin
         m:=5;
     end;

     closed:=false;

     if (px[1]=px[pnum])  and (py[1]=py[pnum])then   begin
         px[0]:=px[pNum-1];  py[0]:=py[pNum-1];

         pNum:=pNum+1;
         px[pNum]:=Px[2]; py[pNum]:=Py[2];
         pNum:=pNum+1;
         for I := pNum downto 1 do  begin
            px[i]:=px[i-1];  py[i]:=py[i-1];
         end;

         closed:=true;
     end;

     for I := 1 to PNum-1 do  begin
        x1:=px[i+1]-px[i]; y1:=py[i+1]-py[i];
        l[i]:=sqrt(x1*x1+y1*y1);
        if l[i]=0 then  l[i]:=1;

     end;

     for I := 2 to pNum-1 do   begin
       a[i]:=l[i]/(l[i]+l[i-1]);
       d[i]:=1-a[i];
       c1:=a[i]/l[i-1];
       c2:=d[i]/l[i];
       cx[i]:=3*(c1*(px[i]-px[i-1])+c2*(px[i+1]-px[i]));
       cy[i]:=3*(c1*(py[i]-py[i-1])+c2*(py[i+1]-py[i]));
     end;

     a[1]:=-1;d[1]:=2;a[pNum]:=2;d[pNum]:=-1;

     cx[1]:=4*(px[2]-px[1])/l[1];
     cy[1]:=4*(py[2]-py[1])/l[1];

     cx[pNum]:=4*(px[pNum]-px[pNum-1])/l[pNum-1];
     cy[pNum]:=4*(py[pNum]-py[pNum-1])/l[pNum-1];

     qx[0]:=0;r[0]:=0;qy[0]:=0;

     for I := 1 to pNum - 1 do   begin
        u:=a[i]*r[i-1]+2;
        if u=0 then  u:=1;
        qx[i]:=(cx[i]-a[i]*qx[i-1])/u;
        qy[i]:=(cy[i]-a[i]*qy[i-1])/u;
        r[i]:=-d[i]/u;

     end;

     u:=a[pNum]*r[pNum-1]+2;
     if u=0 then u:=1;
     vx[pNum]:=(Cx[pNum]-a[pNum]*qx[pNum-1])/u;
     Vy[pNum]:=(CY[pNum]-a[pNum]*qY[pNum-1])/u;

     for i:=pNum-1  downto 1 do    begin
         Vx[i]:=qx[i]+r[i]*vx[i+1];
         Vy[i]:=qy[i]+r[i]*vy[i+1];
     end;
     //L_n:=0 ;    Lux �±�� 0 ��ʼ
     if Closed then   begin
         Lux[L_n]:=Px[2];
         Luy[L_n]:=Py[2];
     end else begin
         Lux[L_n]:=Px[1];
         Luy[L_n]:=Py[1];
     end;

     for i :=1 to pNum- 1 do  begin
        ppx:=Px[i+1]-Px[i];
         ppy:=Py[i+1]-Py[i];
        l2:=l[i]*l[i];
        l3:=l2*l[i];
        p1x:=3*ppx/l2-(vx[i+1]+2*vx[i])/l[i];
        p2x:=-2*ppx/l3+(vx[i+1]+vx[i])/l2;

        p1y:=3*ppy/l2-(vy[i+1]+2*vy[i])/l[i];
        p2y:=-2*ppy/l3+(vy[i+1]+vy[i])/l2;

        k:=l[i]/m;

        if closed then    begin
           if (i<>1) and (i<>pNum-1)  then begin
                for j:= 1 to  m do  begin
                    t:=k*j;
                    t2:=t*t;
                    t3:=t2*t;
                    fx[j]:=px[i]+vx[i]*t+p1x*t2+p2x*t3;
                    fy[j]:=py[i]+vy[i]*t+p1y*t2+p2y*t3;

                    l_n:=l_n+1;
                     Lux[L_n]:=fx[j];
                     Luy[L_n]:=fy[j];

                end;  //end for

           end;

        end else begin // end else if closed
                for j:= 1 to  m do  begin
                    t:=k*j;
                    t2:=t*t;
                    t3:=t2*t;
                    fx[j]:=px[i]+vx[i]*t+p1x*t2+p2x*t3;
                    fy[j]:=py[i]+vy[i]*t+p1y*t2+p2y*t3;

                    l_n:=l_n+1;
                     Lux[L_n]:=fx[j];
                     Luy[L_n]:=fy[j];
                end;  //end for
        end;  //end if closed
     end;  //end for

     if closed then  begin
        for I :=2  to pNum-1 do     begin

            px[i-1]:=px[i];
            py[i-1]:=py[i];
        end; //end for
        pNum:=pNum-2;
     end;
     l_n:=l_n+1;  // ���ݶ�һ���� �±� �� 0 ��ʼ �� lu_n
     result:=true;

end;

procedure TLu_BasicClass.MY_WriteLog(const data: Ansistring;
  FFM: Ansistring);
var
  fileName,textString:Ansistring;
  DirName:Ansistring;
  hFile,logFile:integer;
  Dll_Path:AnsiString;
begin
   Dll_Path:=self.Get_MyModulePath;

   DirName:=DLL_path+'\Err\'+FormatDateTime('yyyy-mm-dd',Now())+'\';
    if not DirectoryExists(DirName) then begin
       ForceDirectories(DirName);
    end;
   fileName:=Ansistring(FormatDateTime('yyyy-mm-dd',Now())) + FFM +'.txt';
   fileName:=DirName+fileName;
   if not(FileExists(fileName)) then begin
       hFile:=FileCreate(fileName,fmOutput);
       FileClose(hFile);
   end;
   logFile:=FileOpen(filename,fmOpenwrite or fmShareDenyWrite);
   FileSeek(logfile,0,2);
   textString:=formatdateTime('hh:mm:ss:zzz',Now())+'  ' +data + #13 +#10 ;
   fileWrite(logFile,Pwidechar(textString)^,length(textString));
   fileclose(logfile);

end;

function TLu_BasicClass.NextStep(c, i, mc, ms, qs, rs, qj: double): double;
begin
  if i=0 then  begin
     Result:=-0.25*c+0.5*sqrt(0.25*c*c+1000*4*ms*ms*qs/(3*(ms+mc)*rs*cos(qj/180.0*3.14159))) ;
  end  else    begin
     Result:=-0.5*c+0.5*sqrt(c*c+1000*4*ms*ms*qs/(3*(ms+mc)*rs*cos(qj/180.0*3.14159))) ;
  end;
end;

function TLu_BasicClass.ReadDataBaseType(var DataType: string): Boolean;
begin
  Result:=False;
  try
   if  not assigned(fReadini) then
           fReadini.Create(inFilepath,inFileNmae) ;
   DataType:=Trim(fReadini.iniGetStr('UsedDataType','Setting'));
   Result:=true;
  finally

  end;

end;

function TLu_BasicClass.ReadDisplayWholeScreen: integer;
var
  Value:integer;
begin
   if  not assigned(fReadini) then
         fReadini.Create(inFilepath,inFileNmae) ;

   Result:= fReadini.iniGetint('WholeScreen','Setting');


end;

function TLu_BasicClass.ReadiniDataNeverDisCTime: Integer;
begin
    if  not assigned(fReadini) then
             fReadini.Create(inFilepath,inFileNmae) ;
     Result:= fReadini.iniGetint('DataNeverDisCTime','setting');

end;

function TLu_BasicClass.ReadIniProcess(var sttime: TDateTime; var Paused,
  totalNumber: integer): Boolean;
var
   FSetting : TFormatSettings;
begin
    //���ڸ�ʽת��
   FSetting.ShortDateFormat:='yyyy-mm-ss' ;
   FSetting.DateSeparator :='-';
   FSetting.ShortTimeFormat :='hh:nn:ss';
   FSetting.TimeSeparator :=':';
   FSetting.DecimalSeparator :='.';

   if  not assigned(fReadini) then
       fReadini.Create(inFilepath,inFileNmae) ;
   sttime:=StrToDateTime(fReadini.iniGetStr('StartTime','Processing'),FSetting);
   Paused:=fReadini.iniGetInt('ServerPause','Processing');
   totalNumber:=fReadini.iniGetInt('totalNumber','Processing');
   Result:=true;
end;

function TLu_BasicClass.ReadiniSaveProcesslog: Boolean;
var
  Value:integer;
begin
  Result:=false;

   if  not assigned(fReadini) then
         fReadini.Create(inFilepath,inFileNmae) ;
   Value:= fReadini.iniGetint('WriteProcessflag','Setting');
   if Value =1 then   Result:=true;

end;

function TLu_BasicClass.ReadiniSV(Setting: string; var V1, V2, V3,
  V4: Integer): Boolean;
begin
   Result:=FALSE;
      if  not assigned(fReadini) then
             fReadini.Create(inFilepath,inFileNmae) ;
      V1:= fReadini.iniGetint('SupDTV1',Setting);
      V2:= fReadini.iniGetint('SuPDTV2',Setting);
      V3:= fReadini.iniGetint('SupDTV3',Setting);
      V4:= fReadini.iniGetint('SupDTV4',Setting);
   if V1+V2+V3+V4 >0  then   Result:=true;
end;

function TLu_BasicClass.ReadiniThreadNumber: integer;
begin
   if  not assigned(fReadini) then
             fReadini.Create(inFilepath,inFileNmae) ;
      Result:= fReadini.iniGetint('ThreadNumber','Setting');
end;

function TLu_BasicClass.ReadIniTimeInterval: integer;
begin

   if  not assigned(fReadini) then
           fReadini.Create(inFilepath,inFileNmae) ;
    Result:= fReadini.iniGetint('TimeInterval','Setting');

end;

function TLu_BasicClass.ReadiniTotalNumber: integer;
begin
   if  not assigned(fReadini) then
             fReadini.Create(inFilepath,inFileNmae) ;
      Result:= fReadini.iniGetint('TotalNumber','Setting');

end;

function TLu_BasicClass.ReadLoginInfo(Setstring:String;Var UserName,UserId,Admin:string): Boolean;
begin
    try
     if  not assigned(fReadini) then
             fReadini.Create(inFilepath,inFileNmae) ;
         UserName:=Trim(fReadini.iniGetStr('UserName',Setstring));
         UserId:= Trim(fReadini.iniGetStr('UserID',Setstring));
         Admin:=Trim(fReadini.iniGetStr('Admin',Setstring));

    finally
      Result:=true;
    end;
end;

function TLu_BasicClass.ReadMainFormVersion (var Captionid:integer;var Version:string):Integer;
var
 Setstring:string;
begin
    Setstring:='Version';
    Result:=0;
    try
     if  not assigned(fReadini) then
             fReadini.Create(inFilepath,inFileNmae) ;
         Captionid:=fReadini.iniGetInt('CaptionID',Setstring);
         Version:=fReadini.iniGetstr('Version',Setstring);

    finally
        Result:=Captionid;
    end;
end;

function TLu_BasicClass.ReadMakeWordPercent(var Percent: integer): Boolean;
var
  Value:integer;
begin
   {
     'WriteWordState','WriteWord');
       fReadini.iniSetStr(intTostr(Percent), 'WriteWordPercent','WriteWord');
   }

  Result:=false; Percent:=0;
   if  not assigned(fReadini) then
         fReadini.Create(inFilepath,inFileNmae) ;
   Value:= fReadini.iniGetint('WriteWordState','WriteWord');
   if Value =1 then begin
      Percent:= fReadini.iniGetint('WriteWordPercent','WriteWord');
      Result:=true;
   end;

end;

function TLu_BasicClass.ReadMySqlDataBase(DataTypeString: string; var IP,
  UserName, Password, Port, DataBaseName: string): Boolean;
begin
    try
     if  not assigned(fReadini) then
             fReadini.Create(inFilepath,inFileNmae) ;
     Ip:=Trim(fReadini.iniGetStr('SrvIP',DataTypeString));
     UserName:=Trim(fReadini.iniGetStr('UserName',DataTypeString));
     Password:=Trim(fReadini.iniGetStr('PassWord',DataTypeString));
     Port:=Trim(fReadini.iniGetStr('Port',DataTypeString));
     DataBaseName:=Trim(fReadini.iniGetStr('DataBaseName',DataTypeString));
    finally
      Result:=true;
    end;

end;

procedure TLu_BasicClass.ReadServerinfo(var S1, S2, S3, S4, S5, S6: string);
begin
      {DataType: string;
    SrvIP: string;
    DataBaseName: string;
    UserName: String;
    PassWord: String;
    FilePath: String;
    ServerPause: integer;
    StartTime: String;
    totalNumber: integer;}

     if  not assigned(fReadini) then
             fReadini.Create(inFilepath,inFileNmae) ;
     s1:=Trim(fReadini.iniGetStr('DataType','DataBase'));
     s2:=Trim(fReadini.iniGetStr('SrvIP','DataBase'));
     s3:=Trim(fReadini.iniGetStr('UserName','DataBase'));
     s4:=Trim(fReadini.iniGetStr('PassWord','DataBase'));
     s5:=Trim(fReadini.iniGetStr('FilePath','DataBase'));
     s6:=Trim(fReadini.iniGetStr('Port','DataBase'));


end;

function TLu_BasicClass.ReadSnapData(var SnapIp,SnapPort: String): Boolean;
var
  Value:integer;
begin
  {'UseSnapData','setting');
       fReadini.iniSetStr('0', 'UseSnapPort','setting');}

  Result:=false;SnapPort:='0';

   if  not assigned(fReadini) then
         fReadini.Create(inFilepath,inFileNmae) ;
   Value:= fReadini.iniGetint('UseSnapData','Setting');
   if Value =1 then begin
      SnapPort:= fReadini.iniGetStr('UseSnapPort','Setting');
      SnapIp:= fReadini.iniGetStr('UseSnapIP','Setting');
      if SnapIp <> '0' then
         Result:=true;
   end;


end;

function TLu_BasicClass.ReadSYStemDataBaseName: String;
begin
       if  not assigned(fReadini) then
             fReadini.Create(inFilepath,inFileNmae) ;
       Result:=Trim(fReadini.iniGetStr('DataBaseName','DataBase'));

end;

function TLu_BasicClass.ReadUpdataCoalBmp: Boolean;
var
  Value:integer;
begin
  Result:=false;

   if  not assigned(fReadini) then
         fReadini.Create(inFilepath,inFileNmae) ;
   Value:= fReadini.iniGetint('UpdateCoalBmp','Setting');
   if Value =1 then   Result:=true;
end;

function TLu_BasicClass.ReadUsedMeiKuangInfo(SetString: String; var mkid,
  mkName, gzmid, GzmName, zkid, ZkName: string): Boolean;
begin

     if  not assigned(fReadini) then
             fReadini.Create(inFilepath,inFileNmae) ;
     mkid:=Trim(fReadini.iniGetStr('Coalid',SetString));
     mkName:=Trim(fReadini.iniGetStr('CoalName',SetString));
     gzmid:=Trim(fReadini.iniGetStr('WorkFaceid',SetString));
     gzmName:=Trim(fReadini.iniGetStr('WorkFaceName',SetString));
     zkid:=Trim(fReadini.iniGetStr('Drillid',SetString));
     zkName:=Trim(fReadini.iniGetStr('DrillName',SetString));

end;

function TLu_BasicClass.ReturnDateTimeString(DataType: String;
  dt: TdateTime): String;
  {Access ���˵��� ���ڸ�ʽҪ����}
Var
  StrDt:String;
begin

   if Uppercase(DataType)='ACCESS' then begin
      StrDt:=FormatDateTime('yyyy-mm-dd HH.nn.ss',dt);
      REsult:='#'+StrDt+'#' ;
   end else begin
      StrDt:=FormatDateTime('yyyy-mm-dd HH:nn:ss',dt);
      REsult:=''''+StrDt+'''' ;
   end;

end;

function TLu_BasicClass.SaveIniFile(sData, sIp, sUser, SPw, sPath,
  Port: string): boolean;
begin
   Result:=true;
   if  not assigned(fReadini) then
       fReadini.Create(inFilepath,inFileNmae) ;
   fReadini.iniSetStr(trim(sData), 'DataType','DataBase');
   fReadini.iniSetStr(trim(sIP), 'SrvIP','DataBase');
   fReadini.iniSetStr(trim(sUser), 'UserName','DataBase');
   fReadini.iniSetStr(trim(sPw), 'PassWord','DataBase');
   fReadini.iniSetStr(trim(sPath), 'FilePath','DataBase');
   fReadini.iniSetStr(trim(Port), 'Port','DataBase');

end;

procedure TLu_BasicClass.ScreenSnap(pt1,pt2:Tpoint; pic_path: string);
var
    RectWidth,RectHeight:integer;
    SourceDC,DestDC,Bhandle:integer;
    Bitmap:TBitmap;
    Stream:TMemoryStream;
    leftPos,RightPos,BottomPos,TopPos:integer;
begin
      leftPos:= pt1.X;
      rightPos:=pt2.X;
      BottomPos:=pt2.Y;
      TopPos:=pt1.Y;
      //===========
      RectWidth:=RightPos-LeftPos;
      RectHeight:=BottomPos-TopPos;
      SourceDC:=CreateDC('DISPLAY','','',nil);
      DestDC:=CreateCompatibleDC(SourceDC);
      Bhandle:=CreateCompatibleBitmap(SourceDC,
      RectWidth,RectHeight);
      SelectObject(DestDC,Bhandle);
      BitBlt(DestDC,0,0,RectWidth,RectHeight,SourceDC,
             LeftPos,TopPos,SRCCOPY);
      Bitmap:=TBitmap.Create;
      Bitmap.Handle:=BHandle;
      Stream := TMemoryStream.Create;
      Bitmap.SaveToStream(Stream);
      Stream.Free;
      try
        Bitmap.SaveToFile(pic_path);
      finally
        Bitmap.Free;
        DeleteDC(DestDC);
        ReleaseDC(Bhandle,SourceDC);
      end;


end;

function TLu_BasicClass.Select_max(a1, a2, a3, a4: double): double;
var
   b  :array[0..3] of double;
   i :integer;
begin
    b[0]:=a1;b[1]:=a2;b[2]:=a3;b[3]:=a4;
    Result:=b[0];
   for I := 1 to 3 do
     if b[i]>Result then  Result:=b[i];
end;

function TLu_BasicClass.select_min(a1, a2, a3, a4: double): double;
var
   b  :array[0..3] of double;
   i :integer;
begin
   b[0]:=a1;b[1]:=a2;b[2]:=a3;b[3]:=a4;
   Result:=b[0];
   for I := 1 to 3  do
         if b[i]<Result then     Result:=b[i];
end;

procedure TLu_BasicClass.SetLicensing(Value: Boolean);
begin
   in_Licensing:=Value;
end;

procedure TLu_BasicClass.SetStatusCaption(Value: String);
begin
   StatUsBarRightStr:=Value;
end;

procedure TLu_BasicClass.SetUseUnitName(Value: string);
begin
    In_UseUnitName:=Value;
end;

function TLu_BasicClass.split(s: string; dot: char; out ret: Integer): Str_DT_array;
 var
       str:Str_DT_array;
       i,j:integer;
       S1:string;
begin
     j:=0;
     S1:=s;
     while Pos(dot, S1) > 0 do   begin
         i:=pos(dot,s1)+1;
         s1[i-1] := chr(ord(dot)+1);
         j:=j+1;
     end;
     //------------
     ret:=j+1;
     SetLength(str,ret);
     i:=1;
     j:=0;

    while Pos(dot, s) > 0 do   begin
        str[j]:=copy(s,i,pos(dot,s)-i);
        i:=pos(dot,s)+1;
        s[i-1] := chr(ord(dot)+1);
        j:=j+1;
    end;

    str[j]:=copy(s,i,strlen(PWideChar(s))-i+1);
    result:=str;

end;

function TLu_BasicClass.StringGridtoExcel(atitle: string;
  Astringgrid: Tstringgrid; Afontsize: integer): String;
var
     xlapp, xlsheet: variant;
     row, CCC, nnn, jjj: integer;
     s_out:String;
begin
  try
    xlapp := createoleobject('excel.application');
  except
    s_out:='not found excel in your system, so can not create file!';
    exit;
  end;
  try
    ccc := Astringgrid.ColCount;

    xlapp.workbooks.add; //�����¹�����
    xlapp.visible := false;
    xlsheet := xlapp.activesheet;
    xlapp.activewindow.windowstate := 2;
    xlapp.range[xlsheet.cells[1, 1], xlsheet.cells[1, ccc]].MERGE;
    xlsheet.cells[1, 1].value := Atitle; //ҳͷ��һ�У�
    xlsheet.cells[1, 1].HorizontalAlignment := -4108;

    row := 2;
    for jjj := 0 to Astringgrid.RowCount - 1 do
    begin
      for nnn := 1 to ccc do
        xlsheet.cells[row, nnn] := trim(Astringgrid.Cells[nnn - 1, row - 2]);
      xlsheet.rows[row].RowHeight := 18;
      inc(row);
    end;

    xlapp.visible := true;
        //��ʽ����

    xlapp.range[xlsheet.cells[row, 1], xlsheet.cells[row, 13]].WrapText := True;
    xlapp.range[xlsheet.cells[row, 1], xlsheet.cells[row, 13]].HorizontalAlignment := -4108;

    xlsheet.pagesetup.headerMargin := 1 / 0.035; //ҳü�����˱߾�1cm
    xlsheet.pagesetup.footerMargin := 0.6 / 0.035; //ҳ�ŵ��׶˱߾�1cm
    xlsheet.pagesetup.topMargin := 1 / 0.035; //���߾�1cm
    XLSHEET.pagesetup.bottomMargin := 1.3 / 0.035; //�ױ߾�1cm
    xlsheet.pagesetup.leftMargin := 0.5 / 0.035; //��߾�1cm
    xlsheet.pagesetup.rightMargin := 0.5 / 0.035; //�ұ߾�1cm
  //  xlsheet.pagesetup.leftfooter := '�Ʊ�: ' + Puboptername;
    xlsheet.pagesetup.centerfooter := ''; //ҳ��
    xlsheet.pagesetup.rightfooter := '��&Pҳ/��&Nҳ';
    xlsheet.pagesetup.leftHeader := '';
    xlsheet.pagesetup.orientation := 1; //����
    xlsheet.pagesetup.printtitlerows := '$1:$1';
    xlsheet.rows[1].font.name := '����'; //���õ�һ����������
    xlsheet.rows[1].font.bold := true;
    xlsheet.rows[1].font.size := 16;
    xlsheet.rows[1].RowHeight := 28;

    for nnn := 1 to ccc do
    begin
      xlsheet.columns[nnn].columnwidth := Astringgrid.ColWidths[nnn - 1] * 0.1188;
    end;

    for nnn := 1 to 4 do begin
      xlapp.range[xlsheet.cells[2, 1], xlsheet.cells[row - 1, CCC]].borders[nnn].linestyle := 1;
      xlapp.range[xlsheet.cells[2, 1], xlsheet.cells[row - 1, CCC]].borders[nnn].weight := 1;
    end;

    xlapp.range[xlsheet.cells[2, 1], xlsheet.cells[row - 1, CCC]].font.size := Afontsize;
    xlapp.range[xlsheet.cells[2, 1], xlsheet.cells[row - 1, ccc]].WrapText := True;

    varclear(xlsheet);
    varclear(xlapp);

  except
    on E: Exception do
    begin
      xlapp.quit;
      s_out:='Eorr';
    end;
  end;

end;

function TLu_BasicClass.StringGridToExcel_MegerCell(Disp:Boolean;atitle: string;
  Astringgrid: Tstringgrid; Afontsize: integer;
  arry: Rec_StringToExcel_Array;Path:string): String;
var
     xlapp, xlsheet: variant;
     row, CCC, nnn, jjj: integer;
     s_out,Meger_Str:String;
     i,t,k:integer;
begin
  try
    xlapp := createoleobject('excel.application');
  except
    s_out:='not found excel in your system, so can not create file!';
    exit;
  end;
  try
    ccc := Astringgrid.ColCount;

    xlapp.workbooks.add; //�����¹�����
    xlapp.visible := false;
    xlsheet := xlapp.activesheet;
    xlapp.activewindow.windowstate := 2;
    //�ϲ����ⵥԪ��
    xlapp.range[xlsheet.cells[1, 1], xlsheet.cells[1, ccc]].MERGE;
    xlsheet.cells[1, 1].value := Atitle; //ҳͷ��һ�У�
    xlsheet.cells[1, 1].HorizontalAlignment := -4108;
    xlsheet.cells[1, 1].font.size := Afontsize+4;
    // �ϲ�������Ԫ��
     for I := 0 to High(arry) do  begin
         xlapp.range[
                     xlsheet.cells[arry[i].FromRow+2,arry[i].FromCol+1 ],
                     xlsheet.cells[arry[i].ToRow+2,arry[i].ToCol+1 ]
                     ].MERGE;
         // ���䷽ʽ
        xlsheet.cells[arry[i].FromRow+2,arry[i].FromCol+1].HorizontalAlignment := -4108;
        Meger_Str:='';
        for t := arry[i].FromCol to arry[i].ToCol do
          for k := arry[i].FromRow to arry[i].ToRow do
              Meger_Str:= Meger_Str+ Astringgrid.Cells[t,k] ;

        xlsheet.cells[arry[i].FromRow+2,arry[i].FromCol+1].value := Meger_Str; //ҳͷ��һ�У�
     end;
    //

    row := 2;
    for jjj := 0 to Astringgrid.RowCount - 1 do
    begin
      for nnn := 1 to ccc do  begin
         if trim(xlsheet.cells[row, nnn])='' then
            xlsheet.cells[row, nnn] := trim(Astringgrid.Cells[nnn - 1, row - 2]);
            xlsheet.cells[row, nnn].HorizontalAlignment := -4108;
      end;
      xlsheet.rows[row].RowHeight := 18;
      inc(row);
    end;

     if Disp then  xlapp.visible := true;
        //��ʽ����

    xlapp.range[xlsheet.cells[row, 1], xlsheet.cells[row, 13]].WrapText := True;
    xlapp.range[xlsheet.cells[row, 1], xlsheet.cells[row, 13]].HorizontalAlignment := -4108;

    xlsheet.pagesetup.headerMargin := 1 / 0.035; //ҳü�����˱߾�1cm
    xlsheet.pagesetup.footerMargin := 0.6 / 0.035; //ҳ�ŵ��׶˱߾�1cm
    xlsheet.pagesetup.topMargin := 1 / 0.035; //���߾�1cm
    XLSHEET.pagesetup.bottomMargin := 1.3 / 0.035; //�ױ߾�1cm
    xlsheet.pagesetup.leftMargin := 0.5 / 0.035; //��߾�1cm
    xlsheet.pagesetup.rightMargin := 0.5 / 0.035; //�ұ߾�1cm
  //  xlsheet.pagesetup.leftfooter := '�Ʊ�: ' + Puboptername;
    xlsheet.pagesetup.centerfooter := ''; //ҳ��
    xlsheet.pagesetup.rightfooter := '��&Pҳ/��&Nҳ';
    xlsheet.pagesetup.leftHeader := '';
    xlsheet.pagesetup.orientation := 1; //����
    xlsheet.pagesetup.printtitlerows := '$1:$1';
    xlsheet.rows[1].font.name := '����'; //���õ�һ����������
    xlsheet.rows[1].font.bold := true;
    xlsheet.rows[1].font.size := 16;
    xlsheet.rows[1].RowHeight := 28;

    for nnn := 1 to ccc do
    begin
      xlsheet.columns[nnn].columnwidth := Astringgrid.ColWidths[nnn - 1] * 0.1188;
    end;

    for nnn := 1 to 4 do begin
      xlapp.range[xlsheet.cells[2, 1], xlsheet.cells[row - 1, CCC]].borders[nnn].linestyle := 1;
      xlapp.range[xlsheet.cells[2, 1], xlsheet.cells[row - 1, CCC]].borders[nnn].weight := 1;
    end;

    xlapp.range[xlsheet.cells[2, 1], xlsheet.cells[row - 1, CCC]].font.size := Afontsize;
    xlapp.range[xlsheet.cells[2, 1], xlsheet.cells[row - 1, ccc]].WrapText := True;

    //if (not Disp) and (Path <>'')  then   xlapp.workbooks(1).SaveAs(Path);

    varclear(xlsheet);
    varclear(xlapp);

   
  except
    on E: Exception do
    begin
      xlapp.quit;
      s_out:='Eorr';
    end;
  end;

end;

function TLu_BasicClass.StrToDouble_Lu(s: widestring): double;
begin
    if s='NAN' then  s:='0';

    try
          if length(trim(s))=0 then  begin
                Result:=0.0;
          end  else   begin
                Result:=strtofloat(trim(s));
          end;
     except
         Result:=0.0;
     end;
end;

function TLu_BasicClass.StrToInt_lu(s: widestring): Integer;
begin
   if s='NAN' then  s:='0';
   try
     if length(trim(s))=0 then  begin
         Result:=0;
     end  else   begin
         Result:=strtoint(trim(s));
     end;
   except
         Result:=0;
   end;
end;

function TLu_BasicClass.WriteDataBaseType(DataType: String): Boolean;
begin
   Result:=true;
     if  not assigned(fReadini) then
              fReadini.Create(inFilepath,inFileNmae) ;
      fReadini.iniSetStr(trim(DataType), 'UsedDataType','Setting');
end;

procedure TLu_BasicClass.WriteDisplayWholeScreen(Value: integer);
begin
    if  not  assigned(fReadini) then
             fReadini.Create(inFilepath,inFileNmae) ;

       fReadini.iniSetStr(IntTostr(Value), 'WholeScreen','setting');


end;

procedure TLu_BasicClass.WriteIniDAtaNeverDisCTime(Value: integer);
begin
   if  not  assigned(fReadini) then
             fReadini.Create(inFilepath,inFileNmae) ;

    fReadini.iniSetStr(trim(IntToStr(Value)), 'DataNeverDisCTime','setting');
end;

procedure TLu_BasicClass.WriteIniProcess(StTime: TdateTime; Paused: integer);
begin
   if  not assigned(fReadini) then
           fReadini.Create(inFilepath,inFileNmae) ;
   if( StTime > 1000)  then
         fReadini.iniSetStr(FormatDateTime('yyyy-mm-dd hh:nn:ss',StTime),'StartTime','Processing');
   fReadini.iniSetStr(Trim(IntToStr(Paused)),'ServerPause','Processing');
end;

procedure TLu_BasicClass.WriteIniReadIniTimeInterval(Vaule: Integer);
begin

  if  not assigned(fReadini) then
         fReadini.Create(inFilepath,inFileNmae);
   fReadini.iniSetStr(trim(InttoStr(Vaule)), 'TimeInterval','setting');

end;

procedure TLu_BasicClass.WriteIniSaveProcesslog(Value: Boolean);
var
  KK:integer;
begin
    if Value then  KK:=1 else KK:=0;

    if  not assigned(fReadini) then
           fReadini.Create(inFilepath,inFileNmae) ;
     fReadini.iniSetStr(trim(InttoStr(KK)), 'WriteProcessflag','setting');


end;

procedure TLu_BasicClass.WriteiniSV(Setting: string; V1, V2, V3, V4: Integer);
begin
   if  not assigned(fReadini) then
             fReadini.Create(inFilepath,inFileNmae) ;
    fReadini.iniSetStr(trim(intToStr(V1)), 'SupDTV1',Setting);
    fReadini.iniSetStr(trim(inttostr(V2)), 'SupDTV2',Setting);
    fReadini.iniSetStr(trim(inttostr(V3)), 'SupDTV3',Setting);
    fReadini.iniSetStr(trim(inttostr(V4)), 'SupDTV4',Setting);
end;

procedure TLu_BasicClass.WriteINiThreadNumber(Value: integer);
begin
   if  not  assigned(fReadini) then
       fReadini.Create(inFilepath,inFileNmae) ;

     fReadini.iniSetStr(trim(IntToStr(Value)), 'ThreadNumber','setting');
end;

procedure TLu_BasicClass.WriteIniTimeInterval(Vaule: Integer);
begin
   if  not assigned(fReadini) then
             fReadini.Create(inFilepath,inFileNmae);
       fReadini.iniSetStr(trim(InttoStr(Vaule)), 'TimeInterval','setting');

end;

procedure TLu_BasicClass.WriteiniTotalNumber(TotalN: integer);
begin

  if  not assigned(fReadini) then
         fReadini.Create(inFilepath,inFileNmae) ;
   fReadini.iniSetStr(Trim(IntToStr(TotalN)),'TotalNumber','Processing');


end;

function TLu_BasicClass.WriteLoginInfo(SetString,UserName,UserId,Admin:String): Boolean;
begin
    Result:=true;
     if  not assigned(fReadini) then
              fReadini.Create(inFilepath,inFileNmae) ;
     fReadini.iniSetStr(trim(UserName), 'UserName',SetString);
     fReadini.iniSetStr(trim(UserId), 'UserId',SetString);
     fReadini.iniSetStr(trim(Admin), 'Admin',SetString);

end;

procedure TLu_BasicClass.WriteMainFormVersion(CaptionID,Version:String);
var
 SetString:string;
begin
   SetString:='Version';
   if  not assigned(fReadini) then
              fReadini.Create(inFilepath,inFileNmae) ;
     if Trim(CaptionID) <>'' then
        fReadini.iniSetStr(CaptionID, 'CaptionID',SetString);
     if Trim(Version) <>'' then
        fReadini.iniSetStr(Version, 'Version',SetString);
     fReadini.iniSetStr('֣ú��ʹ��', 'First',SetString);
     fReadini.iniSetStr('�����˶�����', 'Second',SetString);
     fReadini.iniSetStr('��ѹ��̬����', 'Third',SetString);
     fReadini.iniSetStr('��Ժʿģ��ƽ̨', 'Fouth',SetString);
     fReadini.iniSetStr('����ά�����ѹ����', 'FiFth',SetString);
end;

procedure TLu_BasicClass.WriteMakeWordPercent(state: Boolean; Percent: integer);
begin
    if  not  assigned(fReadini) then
             fReadini.Create(inFilepath,inFileNmae) ;
    if state then begin
       fReadini.iniSetStr('1', 'WriteWordState','WriteWord');
       fReadini.iniSetStr(intTostr(Percent), 'WriteWordPercent','WriteWord');
    end else begin
       fReadini.iniSetStr('0', 'WriteWordState','WriteWord');
    end;
end;

function TLu_BasicClass.WriteMYSQLDataBase(DataTypeString, IP, UserName,
  Password, Port, DataBaseName: string): Boolean;
begin
   Result:=true;
     if  not assigned(fReadini) then
              fReadini.Create(inFilepath,inFileNmae) ;
     fReadini.iniSetStr(trim(IP), 'SrvIP',DataTypeString);
     fReadini.iniSetStr(trim(UserName), 'UserName',DataTypeString);
     fReadini.iniSetStr(trim(Password), 'PassWord',DataTypeString);
     fReadini.iniSetStr(trim(Port), 'Port',DataTypeString);
     fReadini.iniSetStr(trim(DataBaseName), 'DataBaseName',DataTypeString);
end;

procedure TLu_BasicClass.WriteSnapData(Value: Boolean; ip,Port: string);
begin
    if  not  assigned(fReadini) then
             fReadini.Create(inFilepath,inFileNmae) ;
    if Value then begin
       fReadini.iniSetStr('1', 'UseSnapData','setting');
       fReadini.iniSetStr(Ip , 'UseSnapIP','setting');
       fReadini.iniSetStr(Port, 'UseSnapPort','setting');
    end else begin
       fReadini.iniSetStr('0', 'UseSnapData','setting');
    end;
end;

procedure TLu_BasicClass.WriteSYStemDataBaseName(Value: string);
begin
  if  not assigned(fReadini) then
             fReadini.Create(inFilepath,inFileNmae) ;
       fReadini.iniSetStr(Value, 'DataBaseName','DataBase');
end;

procedure TLu_BasicClass.WriteTestAndOriginal(Test_Str: String);
var
 DataTypeString:string;
begin
    DataTypeString:='Use Unit Information';
   if  not assigned(fReadini) then
              fReadini.Create(inFilepath,inFileNmae) ;
     fReadini.iniSetStr(Test_Str, 'Original',DataTypeString);


end;

procedure TLu_BasicClass.WriteUpdateCoalBmp(Value: Boolean);
begin
    if  not  assigned(fReadini) then
             fReadini.Create(inFilepath,inFileNmae) ;
    if Value then begin
       fReadini.iniSetStr('1', 'UpdateCoalBmp','setting');
    end else begin
       fReadini.iniSetStr('0', 'UpdateCoalBmp','setting');
    end;
end;

function TLu_BasicClass.WriteUsedMeiKuanginfo(SetString, mkid, mkName, gzmid,
  GzmName, zkid, ZkName: string): Boolean;
begin
  Result:=true;
     if  not assigned(fReadini) then
              fReadini.Create(inFilepath,inFileNmae) ;
     fReadini.iniSetStr(trim(mkid), 'Coalid',SetString);
     if mkName <> '' then      fReadini.iniSetStr(trim(mkName), 'CoalName',SetString);
     fReadini.iniSetStr(trim(gzmid), 'WorkFaceid',SetString);
     if gzmName <> '' then  fReadini.iniSetStr(trim(gzmName), 'WorkFaceName',SetString);
     fReadini.iniSetStr(trim(zkid), 'Drillid',SetString);
     if zkNAme <> '' then fReadini.iniSetStr(trim(zkNAme), 'DrillName',SetString);
end;

procedure TLu_BasicClass.WriteVirFityPassword(UN, Password:string);
var
 DataTypeString:string;
begin
    DataTypeString:='Use Unit Information';
   if  not assigned(fReadini) then
              fReadini.Create(inFilepath,inFileNmae) ;
     fReadini.iniSetStr(UN, 'Name',DataTypeString);
     fReadini.iniSetStr(Password, 'Permission',DataTypeString);
end;

{ TIni }

constructor TIni.Create(MinPath, FileName: string);
begin
   try
    fpath := MinPath;
    fIniReader := TiniFile.Create(fpath + FileName);
    fIsOpen := true;
  except
    fIsOpen := false;
  end;
end;

procedure TIni.iniClose(FileName: string);
begin
  finiReader.Free;
  fIsOpen := false;
end;

function TIni.iniGetFloat(ID, secName: string): Double;
begin
  Result := strtoFloat(finiReader.ReadString(secName, ID, '0'));
end;

function TIni.iniGetInt(ID, secName: string): integer;
begin
  Result := strtoint(finiReader.ReadString(secName, ID, '0'));
end;

function TIni.iniGetStr(ID, secName: string): string;
begin
  Result := finiReader.ReadString(secName, ID, '0');
end;

function TIni.iniIsOpen(FileName: string): boolean;
begin
  if finiReader.FileName = FileName then
    Result := fIsOpen
  else
    Result := false;
end;

function TIni.iniSetStr(newValue, ID, secName: string): boolean;
begin
  try
    finiReader.WriteString(secName, ID, NewValue);
    Result := true;
  except
    Result := false;
  end;
end;

{ TIniObj }

procedure TIniObj.LoadIni;
begin
    DataType:= iniGetStr('DataType','Setting');
    SrvIP:= iniGetStr('SrvIP','Setting');
    DataBaseName:= iniGetStr('DataBaseName','Setting');
    UserName:= iniGetStr('UserName','Setting');
    PassWord:= iniGetStr('PassWord','Setting');
    FilePath:= iniGetStr('FilePath','Setting');
    SupDTV1:= iniGetint('SupDTV1','Setting');
    SuPDTV2:= iniGetint('SuPDTV2','Setting');
    SupDTV3:= iniGetint('SupDTV3','Setting');
    SupDTV4:= iniGetint('SupDTV4','Setting');
    TimeInterval:= iniGetint('TimeInterval','Setting');
    DataNeverDisCTime:= iniGetint('DataNeverDisCTime','Setting');

    ServerPause:= iniGetint('Port','Processing');
    StartTime:= iniGetStr('StartTime','Processing');
    totalNumber:= iniGetint('totalNumber','Processing');

end;

procedure TIniObj.SaveIni(sDatType, sIP, sDName, sUN, sPw, sFP, sPause, sStart,
  StolN, sV1, sV2, Sv3, Sv4, TIV, TDec: string);
begin
    iniSetStr(trim(sDatType), 'DataType','Setting');
    iniSetStr(trim(sIP), 'SrvIP','Setting');
    iniSetStr(trim(sDName), 'DataBaseName','Setting');
    iniSetStr(trim(sUN), 'UserName','Setting');
    iniSetStr(trim(sPw), 'PassWord','Setting');
    iniSetStr(trim(sFP), 'FilePath','Setting');
    iniSetStr(trim(sV1), 'SupDTV1','Setting');
    iniSetStr(trim(sV2), 'SupDTV2','setting');
    iniSetStr(trim(sV3), 'SupDTV3','setting');
    iniSetStr(trim(sV4), 'SupDTV4','setting');
    iniSetStr(trim(TIV), 'TimeInterval','setting');
    iniSetStr(trim(TDec), 'DataNeverDisCTime','setting');


    iniSetStr(trim(sPause), 'ServerPause','Processing');
    iniSetStr(trim(sStart), 'StartTime','Processing');
    iniSetStr(trim(StolN), 'totalNumber','Processing');
end;



procedure TLu_BasicClass.AddMultTextWaterFormFile(FileName:string);
var
  Image1:Timage;
begin
   Image1:=Timage.Create(nil);
   try
      LoadWaterFile(FileName,Image1);
      AddMultTextWaterFormImage(Image1);
      Image1.Picture.SaveToFile(FileName);
   finally
     FreeAndNil(Image1);
   end;
end;

procedure TLu_BasicClass.AddMultTextWaterFormImage(Imag: TImage);
var
  TextLeft,TextTop,Textlength:integer;
  TL,TT:integer;
  i,j,k,t,cc:integer;
begin
    Imag.Picture.Bitmap.Canvas.Font.Size :=14 ;
    Imag.Picture.Bitmap.Canvas.Font.Name :='����';
    Imag.Picture.Bitmap.Canvas.Brush.Style := bsClear;
    Imag.Picture.Bitmap.Canvas.Font.Color :=clGray;
    TextLeft:=20;
    TextTop:=10;
    Textlength:= length(UseUnitName)*Imag.Picture.Bitmap.Canvas.Font.Size;
    cc:= trunc(imag.Width/Textlength);
    if CC <2  then  CC:=2;
    CC:=3;
    for I := 1 to CC  do  begin
        TL:=round(imag.Width/8 * I*2)- Textlength div 2;
        for j := 1 to 3 do  begin
           t:=Random(20);
           TextLeft:=TL+round(imag.Width/80* (t -10));
           TT:=round(imag.Height/8  * 2*j);
           TextTop:=TT+round(imag.Height/80* (t -10));
           CanvasRotatedText(Imag.Picture.Bitmap.Canvas,TextLeft+Textlength div 2,TextTop,
              Imag.Picture.Bitmap.Canvas.Font.Name,14, Random(180), clGray, Trim(UseUnitName));
        end;
    end;
end;

end. //��ģ�������־
