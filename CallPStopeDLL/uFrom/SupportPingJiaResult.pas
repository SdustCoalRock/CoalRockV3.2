unit SupportPingJiaResult;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,adodb, StdCtrls, ExtCtrls, Grids;

type
  TZJSelect = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
    procedure sort(var A: array of string);
  public
    { Public declarations }
    dl:string;
    Procedure getZhiJiaPar(Sender: TObject);
    procedure InputDinbanQingkuan;
    procedure GetZhijiaCanshu;
  end;

var
  ZJSelect: TZJSelect;

implementation

uses D3Unit;

{$R *.dfm}

procedure TZJSelect.Button1Click(Sender: TObject);
 var
    str,jxjg,JX:string;
    arrayStr:TStrings;
    zjStr:string;
begin
    arrayStr:=TStringList.Create;
    arrayStr.Delimiter:=':';
    if self.RadioButton1.Checked then
    begin
       arrayStr.DelimitedText:= RadioButton1.Caption;
       jxjg:= SplitString(arrayStr[0],'(')[0];
       if jxjg='四柱正四连杆' then
         JX:='JX1';
       if jxjg='两柱正四连杆' then
          JX:='JX2';
       if jxjg='单绞点' then
         JX:='JX3';
       if jxjg='单摆杆' then
          JX:='JX4';
    end;
    if self.RadioButton2.Checked then
    begin
       arrayStr.DelimitedText:= RadioButton2.Caption;
       jxjg:=SplitString(arrayStr[0],'(')[0];
       if jxjg='四柱正四连杆' then
         JX:='JX1';
       if jxjg='两柱正四连杆' then
          JX:='JX2';
       if jxjg='单绞点' then
         JX:='JX3';
       if jxjg='单摆杆' then
          JX:='JX4';
    end;
     str:=JX+',';
    if self.RadioButton3.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton3.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
        dl:= SplitString(SplitString(arrayStr[0],'(')[1],')')[0];
    end;
    if self.RadioButton4.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton4.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
        dl:= SplitString(SplitString(arrayStr[0],'(')[1],')')[0];
    end;
    if self.RadioButton5.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton5.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton6.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton6.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton9.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton9.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton10.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton10.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton11.Checked then
    begin
       arrayStr.DelimitedText:= RadioButton11.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton12.Checked then
    begin
       arrayStr.DelimitedText:= RadioButton12.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton13.Checked then
    begin
       arrayStr.DelimitedText:= RadioButton13.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton14.Checked then
    begin
       arrayStr.DelimitedText:= RadioButton14.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton15.Checked then
    begin
       arrayStr.DelimitedText:= RadioButton15.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton16.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton16.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton17.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton17.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton18.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton18.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton19.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton19.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton20.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton20.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton21.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton21.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton22.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton22.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton23.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton23.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton24.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton24.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;

     MainCForm.zhijiaParam:=str;
     MainCForm.C_Stope1.Input_ZhiJia_canshu(str);
     MainCForm.ADODataSet1.Close;
     MainCForm.ADODataSet1.CommandText:='select * from zjxhb where xh='''+MainCForm.zjxh+'''';
     MainCForm.ADODataSet1.Open;
     MainCForm.ADODataSet1.First;
     zjStr:='ZJ:'+MainCForm.ADODataSet1.FieldByName('lx').AsString+','
            +MainCForm.zjxh+','+MainCForm.ADODataSet1.FieldByName('zjkd').AsString+','
            +MainCForm.ADODataSet1.FieldByName('kdj').AsString+','
            +MainCForm.ADODataSet1.FieldByName('hld').AsString+','
            +MainCForm.ADODataSet1.FieldByName('zjmd').AsString+','
            +MainCForm.ADODataSet1.FieldByName('ysl').AsString+','
            +MainCForm.ADODataSet1.FieldByName('zcl').AsString+','
            +MainCForm.ADODataSet1.FieldByName('zhqd').AsString+','
            +MainCForm.ADODataSet1.FieldByName('hbgd').AsString+','
            +MainCForm.ADODataSet1.FieldByName('hbqd').AsString+',';

    // MainCForm.C_Stope1.Init_ZhiJia(zjStr);
    // ShowMessage(MainCForm.C_Stope1.Get_Ocx_path);
     MainCForm.C_Stope1.ShowZhijia(MainCForm.Panel1.Handle,'支架选型',0);
end;

procedure TZJSelect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action := caFree;
     MainCForm.OpenWinCount:=MainCForm.OpenWinCount-1;
     MainCForm.Caption :=  MainCForm.MainCaption;
     ZJSelect :=nil;
end;

procedure TZJSelect.FormCreate(Sender: TObject);
begin
      InputDinbanQingkuan;
      GetZhijiaCanshu;
end;
// 计算支架直奔参数
procedure TZJSelect.GetZhijiaCanshu;
var
    tjStr,jgName,resultStr,maxR,minR:string;
   // arrayMax,arrayMin:TStrings;
    ADOQuery,ADOQueryJG,ADOQueryJgsx,ADOQueryAve,ADOQueryLb,ADOQueryValue,ADOQueryJgsxMax,ADOQueryJgsxMin: TADOQuery;
    jgId,jgsxId,lbsxId:string;
    I,n,II:integer;
    average,result:single;
    arrayValue:array of string;
     arrayStr,arrayMax,arrayMin:TStrings;
begin

     tjStr:= MainCForm.C_Stope1.Get_kcjstj('1.0');arrayMax:=TStringList.Create;
     arrayMax.Delimiter:='_';

     arrayMin:=TStringList.Create;
     arrayMin.Delimiter:='_';
     //--------
     arrayStr:=TStringList.Create;
     arrayStr.Delimiter:=',';

     arrayStr.DelimitedText:=tjStr;
     


     ADOQueryJG:= TADOQuery.Create(nil);
     ADOQueryJG.Connection:=MainCForm.ADOConnection1;
     ADOQueryAve:= TADOQuery.Create(nil);
     ADOQueryAve.Connection:=MainCForm.ADOConnection1;
     ADOQueryLb:= TADOQuery.Create(nil);
     ADOQueryLb.Connection:=MainCForm.ADOConnection1;
     ADOQueryValue:= TADOQuery.Create(nil);
     ADOQueryValue.Connection:=MainCForm.ADOConnection1;
     ADOQueryJgsx:= TADOQuery.Create(nil);
     ADOQueryJgsx.Connection:=MainCForm.ADOConnection1;
     ADOQueryJgsxMax:= TADOQuery.Create(nil);
     ADOQueryJgsxMax.Connection:=MainCForm.ADOConnection1;
     ADOQueryJgsxMin:= TADOQuery.Create(nil);
     ADOQueryJgsxMin.Connection:=MainCForm.ADOConnection1;
     ADOQueryJG.SQL.Clear;
     ADOQueryJG.SQL.Add('select jg.Jg_id,jg.jg_name  from Weight_Jg as jg ');
     ADOQueryJG.Open;
     while not ADOQueryJG.Eof do
     begin
          jgId:= ADOQueryJG.FieldByName('Jg_id').AsString;
          jgName:=ADOQueryJG.FieldByName('jg_name').AsString;
          ADOQueryJgsx.SQL.Clear;
          ADOQueryJgsx.SQL.Add('select Jgsx_id from Weight_Jgsx where Jg_id='+jgId);
          ADOQueryJgsx.Open;
          SetLength(arrayValue,ADOQueryJgsx.RecordCount);
          n:=0;
          while not ADOQueryJgsx.Eof do
          begin
            jgsxId:=ADOQueryJgsx.FieldByName('Jgsx_id').AsString;
            Result:=0;
            for I := 0 to arrayStr.Count - 2 do
             begin
               if arrayStr[I]<>'0' then
                begin
                  ADOQueryAve.SQL.Clear;
                  ADOQueryAve.SQL.Add('select * from Weight_Average where Jg_id='+jgId+' and Lb_id='+inttostr(I+1));
                  ADOQueryAve.Open;
                  ADOQueryAve.First;
                  average:=ADOQueryAve.FieldByName('Average').AsFloat;
                  ADOQueryLb.SQL.Clear;
                  ADOQueryLb.SQL.Add('select * from Weight_Lbsx where Lb_id='+inttostr(I+1)+' and Lbsx_shunxu='+arrayStr[I]);
                  ADOQueryLb.Open;
                  ADOQueryLb.First;
                  lbsxId:= ADOQueryLb.FieldByName('Lbsx_id').AsString;
                  ADOQueryValue.SQL.Clear;
                  ADOQueryValue.SQL.Add('select Value from Weight_Value where Lbsx_id='+lbsxId+' and Jgsx_id='+jgsxId);
                  ADOQueryValue.Open;
                  ADOQueryValue.First;
                  result:=result+ADOQueryValue.FieldByName('Value').AsFloat*average;
               end;
             end;
             resultStr:=jgsxId+'_'+floattostr(result);
             arrayValue[n]:=resultStr;
             n:=n+1;
             ADOQueryJgsx.Next;
           end;
           Sort(arrayValue);
           maxR:=arrayValue[0];
           minR:=arrayValue[1];
           arrayMax.DelimitedText:=maxR;
          ADOQueryJgsxMax.SQL.Clear;
          ADOQueryJgsxMax.SQL.Add('select Jgsx_name,Jgsx_count from Weight_Jgsx where Jgsx_id='+arrayMax[0]);
          ADOQueryJgsxMax.Open;
          ADOQueryJgsxMax.First;
          arrayMin.DelimitedText:=minR;
          ADOQueryJgsxMin.SQL.Clear;
          ADOQueryJgsxMin.SQL.Add('select Jgsx_name,Jgsx_count from Weight_Jgsx where Jgsx_id='+arrayMin[0]);
          ADOQueryJgsxMin.Open;
          ADOQueryJgsxMin.First;
           case strtoint(jgId) of
            1:begin
                //  self.RadioButton1.Caption:=ADOQueryJgsxMax.FieldByName('Jgsx_name').AsString+'('+ADOQueryJgsxMax.FieldByName('Jgsx_count').AsString+')'+':'+FormatFloat('#.##',strtofloat(arrayMax[1]));
                //  self.RadioButton2.Caption:=ADOQueryJgsxMin.FieldByName('Jgsx_name').AsString+'('+ADOQueryJgsxMin.FieldByName('Jgsx_count').AsString+')'+':'+FormatFloat('#.##',strtofloat(arrayMin[1]));
                 self.RadioButton1.Caption:=ADOQueryJgsxMax.FieldByName('Jgsx_name').AsString
                                           +'   :'+FormatFloat('#.##',strtofloat(arrayMax[1]));
                 self.RadioButton2.Caption:=ADOQueryJgsxMin.FieldByName('Jgsx_name').AsString
                                           +'   :'+FormatFloat('#.##',strtofloat(arrayMin[1]));
            end;
            2:begin
                  self.RadioButton3.Caption:=ADOQueryJgsxMax.FieldByName('Jgsx_name').AsString
                                            +'('+ADOQueryJgsxMax.FieldByName('Jgsx_count').AsString+')'
                                            +'  :'+FormatFloat('#.##',strtofloat(arrayMax[1]));
                  self.RadioButton4.Caption:=ADOQueryJgsxMin.FieldByName('Jgsx_name').AsString
                                            +'('+ADOQueryJgsxMin.FieldByName('Jgsx_count').AsString+')'
                                            +'  :'+FormatFloat('#.##',strtofloat(arrayMin[1]));
                  dl:= SplitString(SplitString(RadioButton3.Caption,'(')[1],')')[0];
            end;
            3:begin
                  self.RadioButton5.Caption:=ADOQueryJgsxMax.FieldByName('Jgsx_name').AsString
                                            +'('+ADOQueryJgsxMax.FieldByName('Jgsx_count').AsString+')'
                                            +'  :'+FormatFloat('#.##',strtofloat(arrayMax[1]));
                  self.RadioButton6.Caption:=ADOQueryJgsxMin.FieldByName('Jgsx_name').AsString
                                            +'('+ADOQueryJgsxMin.FieldByName('Jgsx_count').AsString+')'
                                            +'  :'+FormatFloat('#.##',strtofloat(arrayMin[1]));
            end;
            4:begin
                  self.RadioButton9.Caption:=ADOQueryJgsxMax.FieldByName('Jgsx_name').AsString
                                            +'('+ADOQueryJgsxMax.FieldByName('Jgsx_count').AsString+')'
                                            +'  :'+FormatFloat('#.##',strtofloat(arrayMax[1]));
                  self.RadioButton10.Caption:=ADOQueryJgsxMin.FieldByName('Jgsx_name').AsString
                                            +'('+ADOQueryJgsxMin.FieldByName('Jgsx_count').AsString+')'
                                            +'  :'+FormatFloat('#.##',strtofloat(arrayMin[1]));
            end;
            5:begin
                  self.RadioButton11.Caption:=ADOQueryJgsxMax.FieldByName('Jgsx_name').AsString
                                            +'('+ADOQueryJgsxMax.FieldByName('Jgsx_count').AsString+')'
                                            +'  :'+FormatFloat('#.##',strtofloat(arrayMax[1]));
                  self.RadioButton12.Caption:=ADOQueryJgsxMin.FieldByName('Jgsx_name').AsString
                                            +'('+ADOQueryJgsxMin.FieldByName('Jgsx_count').AsString+')'
                                            +'  :'+FormatFloat('#.##',strtofloat(arrayMin[1]));
            end;
            6:begin
                  self.RadioButton13.Caption:=ADOQueryJgsxMax.FieldByName('Jgsx_name').AsString
                                            +'('+ADOQueryJgsxMax.FieldByName('Jgsx_count').AsString+')'
                                            +'  :'+FormatFloat('#.##',strtofloat(arrayMax[1]));
                  self.RadioButton14.Caption:=ADOQueryJgsxMin.FieldByName('Jgsx_name').AsString
                                            +'('+ADOQueryJgsxMin.FieldByName('Jgsx_count').AsString+')'
                                            +'  :'+FormatFloat('#.##',strtofloat(arrayMin[1]));
            end;
            7:begin
                  self.RadioButton15.Caption:=ADOQueryJgsxMax.FieldByName('Jgsx_name').AsString
                                            +'('+ADOQueryJgsxMax.FieldByName('Jgsx_count').AsString+')'
                                            +':'+FormatFloat('#.##',strtofloat(arrayMax[1]));
                  self.RadioButton16.Caption:=ADOQueryJgsxMin.FieldByName('Jgsx_name').AsString
                                            +'('+ADOQueryJgsxMin.FieldByName('Jgsx_count').AsString+')'
                                            +'  :'+FormatFloat('#.##',strtofloat(arrayMin[1]));
            end;
            8:begin
                  self.RadioButton17.Caption:=ADOQueryJgsxMax.FieldByName('Jgsx_name').AsString
                                            +'('+ADOQueryJgsxMax.FieldByName('Jgsx_count').AsString+')'
                                            +'  :'+FormatFloat('#.##',strtofloat(arrayMax[1]));
                  self.RadioButton18.Caption:=ADOQueryJgsxMin.FieldByName('Jgsx_name').AsString
                                            +'('+ADOQueryJgsxMin.FieldByName('Jgsx_count').AsString+')'
                                            +'  :'+FormatFloat('#.##',strtofloat(arrayMin[1]));
            end;
            9:begin
                  self.RadioButton19.Caption:=ADOQueryJgsxMax.FieldByName('Jgsx_name').AsString
                                            +'('+ADOQueryJgsxMax.FieldByName('Jgsx_count').AsString+')'
                                            +'  :'+FormatFloat('#.##',strtofloat(arrayMax[1]));
                  self.RadioButton20.Caption:=ADOQueryJgsxMin.FieldByName('Jgsx_name').AsString
                                            +'('+ADOQueryJgsxMin.FieldByName('Jgsx_count').AsString+')'
                                            +'  :'+FormatFloat('#.##',strtofloat(arrayMin[1]));
            end;
            10:begin
                  self.RadioButton21.Caption:=ADOQueryJgsxMax.FieldByName('Jgsx_name').AsString
                                            +'('+ADOQueryJgsxMax.FieldByName('Jgsx_count').AsString+')'
                                            +'  :'+FormatFloat('#.##',strtofloat(arrayMax[1]));
                  self.RadioButton22.Caption:=ADOQueryJgsxMin.FieldByName('Jgsx_name').AsString
                                            +'('+ADOQueryJgsxMin.FieldByName('Jgsx_count').AsString+')'
                                            +'  :'+FormatFloat('#.##',strtofloat(arrayMin[1]));
            end;
            11:begin
                  self.RadioButton23.Caption:=ADOQueryJgsxMax.FieldByName('Jgsx_name').AsString
                                            +'('+ADOQueryJgsxMax.FieldByName('Jgsx_count').AsString+')'
                                            +'  :'+FormatFloat('#.##',strtofloat(arrayMax[1]));
                  self.RadioButton24.Caption:=ADOQueryJgsxMin.FieldByName('Jgsx_name').AsString
                                            +'('+ADOQueryJgsxMin.FieldByName('Jgsx_count').AsString+')'
                                            +'  :'+FormatFloat('#.##',strtofloat(arrayMin[1]));
            end;

           end;
          ADOQueryJG.Next;
     end;
end;

procedure    TZJSelect.Sort(var A: array of string);
var
  I, J : Integer;
  T:string;
  AJ,AJ1:string;
  arrayJ,arrayJ1:TStrings;
begin
     arrayJ:=TStringList.Create;
     arrayJ.Delimiter:='_';
     arrayJ1:=TStringList.Create;
     arrayJ1.Delimiter:='_';
  for I := High(A) downto Low(A) do
  begin
    for J := 0 to length(A) - 2 do
    begin
       arrayJ.DelimitedText:=A[J];
      arrayJ1.DelimitedText:=A[J + 1];
       AJ:=arrayJ[1];  AJ1:=arrayJ1[1];
      if strtofloat(AJ) <strtofloat(AJ1)  then
      begin
        T := A[J];
        A[J] := A[J + 1];
        A[J + 1] := T;
      end;
    end;
   end;

end;
procedure TZJSelect.getZhiJiaPar(Sender: TObject);
var
    str,jxjg,JX:string;
    arrayStr:TStrings;
begin
     arrayStr:=TStringList.Create;
    arrayStr.Delimiter:=':';
    if self.RadioButton1.Checked then
    begin
       arrayStr.DelimitedText:= RadioButton1.Caption;
       jxjg:= SplitString(arrayStr[0],'(')[0];
       if jxjg='四柱正四连杆' then
         JX:='JX1';
       if jxjg='两柱正四连杆' then
          JX:='JX2';
       if jxjg='单绞点' then
         JX:='JX3';
       if jxjg='单摆杆' then
          JX:='JX4';
    end;
    if self.RadioButton2.Checked then
    begin
       arrayStr.DelimitedText:= RadioButton2.Caption;
       jxjg:=SplitString(arrayStr[0],'(')[0];
       if jxjg='四柱正四连杆' then
         JX:='JX1';
       if jxjg='两柱正四连杆' then
          JX:='JX2';
       if jxjg='单绞点' then
         JX:='JX3';
       if jxjg='单摆杆' then
          JX:='JX4';
    end;
     str:=JX+',';
    if self.RadioButton3.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton3.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
        dl:= SplitString(SplitString(arrayStr[0],'(')[1],')')[0];
    end;
    if self.RadioButton4.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton4.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
        dl:= SplitString(SplitString(arrayStr[0],'(')[1],')')[0];
    end;
    if self.RadioButton5.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton5.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton6.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton6.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton9.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton9.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton10.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton10.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton11.Checked then
    begin
       arrayStr.DelimitedText:= RadioButton11.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton12.Checked then
    begin
       arrayStr.DelimitedText:= RadioButton12.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton13.Checked then
    begin
       arrayStr.DelimitedText:= RadioButton13.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton14.Checked then
    begin
       arrayStr.DelimitedText:= RadioButton14.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton15.Checked then
    begin
       arrayStr.DelimitedText:= RadioButton15.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton16.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton16.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton17.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton17.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton18.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton18.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton19.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton19.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton20.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton20.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton21.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton21.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton22.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton22.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton23.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton23.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
    if self.RadioButton24.Checked then
    begin
        arrayStr.DelimitedText:= RadioButton24.Caption;
        str:=str+ SplitString(arrayStr[0],'(')[0]+',';
    end;
     MainCForm.zhijiaParam:=str;
end;

procedure TZJSelect.InputDinbanQingkuan;
var
    tjStr:string;
    arrayStr:TStrings;
    ADOQuery: TADOQuery;
    I:integer;
begin

     tjStr:= MainCForm.C_Stope1.Get_kcjstj('1.0');
     arrayStr:=TStringList.Create;
     arrayStr.Delimiter:=',';
     arrayStr.DelimitedText:=tjStr;
     ADOQuery:= TADOQuery.Create(nil);
     ADOQuery.Connection:=MainCForm.ADOConnection1;
     self.StringGrid1.ColCount :=9;
     self.StringGrid1.RowCount :=2;
     self.StringGrid1.Cells [1,0]:='直接顶类别';
     self.StringGrid1.Cells [2,0]:='基本顶类别';
     self.StringGrid1.Cells [3,0]:='底板类别';
     self.StringGrid1.Cells [4,0]:='工作阻力/kn';
     self.StringGrid1.Cells [5,0]:='采高/m';
     self.StringGrid1.Cells [6,0]:='矿井瓦斯';
     self.StringGrid1.Cells [7,0]:='冒放性类别';
     self.StringGrid1.Cells [8,0]:='煤层倾角';
     self.StringGrid1.Cells [0,1]:='开采条件';
     self.StringGrid1.ColWidths[1]:=90;
     self.StringGrid1.ColWidths[2]:=90;
     self.StringGrid1.ColWidths[3]:=91;
     self.StringGrid1.ColWidths[4]:=91;
     self.StringGrid1.ColWidths[5]:=91;
     self.StringGrid1.ColWidths[6]:=91;
     self.StringGrid1.ColWidths[7]:=91;
     self.StringGrid1.ColWidths[8]:=91;
     self.StringGrid1.ColWidths[0]:=81;
     for I := 0 to arrayStr.Count - 2 do
        begin
            ADOQuery.SQL.Clear;
            ADOQuery.SQL.Add('select * from Weight_Lbsx where Lb_id='+inttostr(I+1)+' and Lbsx_shunxu='+arrayStr[I]);
            ADOQuery.Open;
            ADOQuery.First;
            self.StringGrid1.Cells [I+1,1]:=ADOQuery.FieldByName('Lbsx_name').AsString;
            ADOQuery.Next;
        end;
     ADOQuery.Close;
end;

end.
