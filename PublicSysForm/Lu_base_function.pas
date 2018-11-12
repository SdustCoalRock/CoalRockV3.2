//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//<<      �ļ�����Lu_base_function.pas
//<<      luleʹ�õĸ���Delphi�ļ�                            <<
//<<      ���ļ���Ҫ��¼�˸��˺���                   <<
//<<      �������ڣ�2011.8.12                                   <<
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

unit Lu_base_function;

interface
 //===============
 uses
  Windows, SysUtils, Classes, Messages, Controls, Forms, StdCtrls, ExtCtrls,
  ComCtrls ,math,ADODB,Grids,WordXP,COMobj,StrUtils,MySQLDataSet,Vcl.Graphics;

 //---����һ����ά�ַ�������࣬���ڷָ��
 type Str_DT_array=array of widestring;
 //��������
 type

  PMyRec = ^TMyRec;
     TMyRec = record
     BName: String;
     DName: String;
     XHeight:String;
   end;
  TMyPoint = packed record
    X : double;
    Y : double;
  end;

 //============
 //---��������
 //-----�ַ����ָ��        //��һ��Ϊ ���ָ���ַ������ڶ���Ϊ�ָ��ַ���������Ϊ�����±�
 function split(s: string; dot: char; out ret:Integer): Str_DT_array;
 //-----�ַ�ת����ֵ��������Ҫ������ַ��������⣩
 function StrToDouble_Lu(s:widestring):double;
 function StrToInt_lu(s:widestring):Integer;
 //---------
 //---------���������ѹ����ĺ���
 function FirstStep(mc,ms,qs,rs,qj:double):double;  //mc�涯�㣬ms֧�в��� qs ֧�в㿹��ǿ��, rs ֧�в����� ��qj���
 function NextStep(c,i,mc,ms,qs,rs,qj:double):double ;//c ��һ�εĲ��࣬i�ڼ��Σ�
 //�ж����ֵ����Сֵ
 function Select_max(a1,a2,a3,a4:double):double;
 function select_min(a1,a2,a3,a4:double):double;
 //���ComboBox
 function FullComBox(ComBox:TComboBox;Adodataset:TADODataSet;StrSql,Zd1,Zd2:AnsiString):Wordbool;stdcall;
 //
 function MySQlFillComBox(MySQlDataSet:TMyDataSet ;Combo: TComboBox; sql, str1, str2,str3: AnsiString):WordBool;stdcall;
 //
 function IsPtInPoly(ALon, ALat: double; APoints: array of TPoint): Boolean;
 function StringGridtoExcel(atitle: string; Astringgrid: Tstringgrid; Afontsize: integer):String;stdcall;
 function FindPointY(X,Y:Integer;t_List:TStringList;Leixing:integer):Integer;stdcall;
 //��������
 function Lu_spline(Px,Py:array of double;Num:integer; VAR lux,luy:array of double;var L_n:integer):Boolean;stdcall;

 //����ʵ�� UTF8String  to WideString ��ת��
 function DecodeUtf8Str(const S:UTF8String): WideString; var lenSrc,lenDst  : Integer;
 // һ��������д�����¼�ĺ���
 procedure MY_WriteLog(const DLL_path,data:Ansistring; FFM : Ansistring='FFQ' );
 // ��ȡģ���·��
 function Get_MyModulePath:WideString;
 //��ת��ӡ����
 procedure CanvasRotatedText(Canvas:TCanVas;px,py:integer;FontName:TFontName;FontSize:integer;Angle:integer;
           FontColor:TColor;StrOut:String);

var
   FsyncSQL:Trtlcriticalsection; // ����һ���칹���ռ� ,����������������
   MySQLTableNameList       :TStringlist;
implementation
 // =========================================================================================
 //��ת��ӡ����
procedure CanvasRotatedText(Canvas:TCanVas;px,py:integer;FontName:TFontName;FontSize:integer;
                      Angle:integer;FontColor:TColor;StrOut:String);
var
  lf:TLogFont;
  tf:TFont;
begin
      with Canvas do begin
              Font.Name :=FontName;
              Font.Size :=FontSize;
              Font.Color:=FontColor;
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
//--------------------------
function MySQlFillComBox(MySQlDataSet:TMyDataSet ;Combo: TComboBox; sql, str1, str2,str3: AnsiString):WordBool;stdcall;
var
    t_s1,t_s2,t_s3,S_tmp,s:ansistring;

begin
     MySQlDataSet.Close;
     Combo.Clear ;
     s_tmp:='0_All';
     combo.Items.Add(s_tmp);
     MySQlDataSet.CommandText:=sql;
     if MySQlDataSet.Open  then
       while not MySQlDataSet.eof do
       begin
           s_tmp:='';
          if str1<>'' then   begin
               t_s1:=Trim(MySQlDataSet.FieldByName(str1).AsString) ;
               s_tmp:=t_s1;
             end;

          if str2<>'' then  begin
               t_s2:=Trim(MySQlDataSet.FieldByName(str2).AsString) ;
               s_tmp:=s_tmp+'_'+t_s2;
           end;

           if str3<>'' then   begin
                t_s3:=Trim(MySQlDataSet.FieldByName(str3).AsString) ;
                s_tmp:=s_tmp+'_'+t_s3;

           end;
           combo.Items.Add(s_tmp);
           MySQlDataSet.Next ;
       end;
   MySQlDataSet.Close ;

       if combo.Items.Count >0 then
          combo.ItemIndex :=0;

 end;

 //---------------------------------------------------------------------------------------------
function Get_MyModulePath:WideString;
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

procedure MY_WriteLog(const DLL_path,data:Ansistring; FFM : Ansistring='FFQ' );
var
  fileName,textString:Ansistring;
  DirName:Ansistring;
  hFile,logFile:integer;
begin
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
   fileWrite(logFile,Pchar(textString)^,length(textString));
   fileclose(logfile);

end;
  //����ʵ�� UTF8String  to WideString ��ת��
 function DecodeUtf8Str(const S:UTF8String): WideString; var lenSrc,lenDst  : Integer;
 begin
   lenSrc  := Length(S);
   if(lenSrc=0)then Exit;
      lenDst  := MultiByteToWideChar(CP_UTF8, 0, Pointer(S),lenSrc, nil, 0);
      SetLength(Result, lenDst);
      MultiByteToWideChar(CP_UTF8, 0, Pointer(S),lenSrc, Pointer(Result), lenDst);
 end;

 //=======================
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
function Lu_spline(Px,Py:array of double;Num:integer; VAR lux,luy:array of double;var L_n:integer):Boolean;stdcall;
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


 {*------------------------------------------------------------------------------
  �ж�ָ�����ĵ��ڸ������ַ����� Y��λ��
  @param X   ָ�����X
  @param Y   ָ�����γ�� Y
  @param t_List  ָ�� ���꼯�ϵ�
  @return Y ���ڷ�Χ�� False ���ڷ�Χ��  ����Y��ֵ
------------------------------------------------------------------------------*  }
 function FindPointY(X,Y:Integer;t_List:TStringList;Leixing:integer):Integer;stdcall;
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

 end;   //end  function FindPointY
 //============
 {*------------------------------------------------------------------------------
  �ж�ָ���ľ�γ��������Ƿ�����ָ���Ķ����������
  @param ALon   ָ����ľ���
  @param ALat   ָ�����γ��
  @param APoints   ָ���������������ڵ�����
  @return True ���ڷ�Χ�� False ���ڷ�Χ��
------------------------------------------------------------------------------*}
function IsPtInPoly(ALon, ALat: double; APoints: array of TPoint): Boolean;
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
//---------���������ѹ����ĺ���
 function FirstStep(mc,ms,qs,rs,qj:double):double;  //mc�涯�㣬ms֧�в��� qs ֧�в㿹��ǿ��, rs ֧�в����� ��qj���
   var
     D_temp :double;
  begin
     D_temp:=sqrt((2.0*ms*ms*qs*1000)/((ms+mc)*rs*cos(qj/180.0*3.14159)));
     Result:=D_temp;
  end;
  //����������ѹ����
 function NextStep(c,i,mc,ms,qs,rs,qj:double):double ;//c ��һ�εĲ��࣬i�ڼ��Σ�
    begin
       if i=0 then
         begin
            Result:=-0.25*c+0.5*sqrt(0.25*c*c+1000*4*ms*ms*qs/(3*(ms+mc)*rs*cos(qj/180.0*3.14159))) ;
         end
       else
         begin
            Result:=-0.5*c+0.5*sqrt(c*c+1000*4*ms*ms*qs/(3*(ms+mc)*rs*cos(qj/180.0*3.14159))) ;
       end;
    end;
//-----�ַ����ָ��
//��һ��Ϊ ���ָ���ַ������ڶ���Ϊ�ָ��ַ���������Ϊ�����±�
 function split(s: string; dot: char; out ret:integer): Str_DT_array;
  var
       str:Str_DT_array;
       i,j:integer;
       S1:string;
  begin
     //  i:=1;
       j:=0;
   
      S1:=s;
        //-----------
        while Pos(dot, S1) > 0 do
         begin
             i:=pos(dot,s1)+1;
             s1[i-1] := chr(ord(dot)+1);
             j:=j+1;
         end;
       //------------
       ret:=j+1;
       SetLength(str,ret);
       i:=1;
       j:=0;

     
      while Pos(dot, s) > 0 do
       begin
          str[j]:=copy(s,i,pos(dot,s)-i);
          i:=pos(dot,s)+1;
          s[i-1] := chr(ord(dot)+1);
          j:=j+1;
      end;
       str[j]:=copy(s,i,strlen(PWideChar(s))-i+1);
       result:=str;
   end;
// --------�ַ���ת����������Ҫ������ַ�������������
function StrToDouble_Lu(s:widestring):double;
    begin
       try
            if length(trim(s))=0 then
                 begin
                  Result:=0.0;
                 end
            else
                 begin
                  Result:=strtofloat(trim(s));
                 end;
       except
                Result:=0.0;
       end;
 end;

function StrToInt_lu(s:widestring):Integer;
   begin
       try
         if length(trim(s))=0 then
                 begin
                  Result:=0;
                 end
            else
                 begin
                  Result:=strtoint(trim(s));
                end;
       except
                 Result:=0;
       end;
  end;
 //�ж����ֵ����Сֵ
 function Select_max(a1,a2,a3,a4:double):double;     //���ֵ
    var
      b  :array[0..3] of double;
       i :integer;
   begin
      b[0]:=a1;b[1]:=a2;b[2]:=a3;b[3]:=a4;
       Result:=b[0];
       for I := 1 to 3 do
          begin
             if b[i]>Result then
                  Result:=b[i];
          end;

   end;
 function select_min(a1,a2,a3,a4:double):double;   //��Сֵ
   var
       b  :array[0..3] of double;
       i :integer;
   begin
      b[0]:=a1;b[1]:=a2;b[2]:=a3;b[3]:=a4;
       Result:=b[0];
       for I := 1 to 3 do
          begin
             if b[i]<Result then
                  Result:=b[i];
          end;

   end;  //�������С�������
   //---------------------
function FullComBox(ComBox:TComboBox;Adodataset:TADODataSet;StrSql,Zd1,Zd2:AnsiString):Wordbool;
 begin
    Result:=True;
    try
       AdoDataset.Close();
       AdoDataSet.CommandText:=StrSql;
       AdoDataSet.Open();
         ComBox.Clear;
         AdoDataSet.First();
         while not AdoDataSet.Eof  do
            begin
               if Trim(zd2)='' then
                 begin
                   comBox.Items.Add(AdoDataSet.FieldByName(zd1).AsString );
                 end
               else
                 begin
                   comBox.Items.Add(AdoDataSet.FieldByName(zd1).AsString+'_'+AdoDataSet.FieldByName(zd2).AsString );
                 end;
               AdoDataSet.Next();
            end;

     except
      Result:=False;
    end;
 end;   //end  FullComBox

function StringGridtoExcel(atitle: string; Astringgrid: Tstringgrid; Afontsize: integer):String;stdcall;
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

end;  //end  TStringgridtoexcel
end. //��ģ�������־