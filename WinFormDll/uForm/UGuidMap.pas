unit UGuidMap;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,ComObj,System.StrUtils,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids,
  Vcl.OleCtrls, SHDocVw,mshtml,ActiveX, Vcl.Menus, Vcl.AppEvnts;

type
  TForm_MapMain = class(TForm)
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ToolButton3: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ImageList1: TImageList;
    PanelLeft: TPanel;
    PageControl1: TPageControl;
    TabSheetDz: TTabSheet;
    SG_WBZ: TStringGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    TabSheetZj: TTabSheet;
    SG_YBZ: TStringGrid;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    PanelMap: TPanel;
    Splitter1: TSplitter;
    StatusBar1: TStatusBar;
    OpenDialog1: TOpenDialog;
    WebBrowser: TWebBrowser;
    Timer1: TTimer;
    ToolButton14: TToolButton;
    Panel_Text: TPanel;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    Popup_Map: TPopupMenu;
    Pop_LoadAll: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Pop_Open: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    SelectEdit: TEdit;
    Button1: TButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SG_WBZSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure SG_YBZSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Pop_LoadAllClick(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure SelectEditClick(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
  private
    { Private declarations }
    Mapx_Out_in,MarkOrSelect:Boolean;
    wholeScreen,LoadwebT:Boolean;
    SelectRad:string;
    MyJingdu,Myweidu: string;
    Click_Jd,Click_Wd,Click_Coalid:string;
    SelectbZj_bh, Select_J,Select_M,Select_A:string;

    procedure loadexcel(rowCount,colCount:integer; fileName:String; var grid:TStringGrid);
    procedure initPanelLeft;
    procedure InitSG_StringGrid;
    procedure InitPanleMap;

    function  CreateClass:Boolean;
    procedure OptionTip(Str:String);
    function  MarkerSupportMap(coalbh,jd,wd,Jituan,MeiKuang,Address:string):Boolean;
    procedure MapVisual(Value:Boolean);
    function searchByStationName(AName:string):Boolean;
    //baidu Map
     procedure AppMsg(var Msg: TagMsg; var Handled: Boolean);
     procedure GetWebContent();
     procedure loadweb();
     procedure ClearMapMarker;
     procedure AddAllMarker;
     procedure SetLocalMarker;

     procedure MakeWindowsSingle(Single: integer);
     Procedure DispMapPop(Px,Py:Integer);//��ʾMapPop���ƿ�ݲ˵�
     procedure GenerateJPEGfromBrowser(browser: iWebBrowser2;
                                  jpegFQFilename: string; srcHeight:
                                  integer; srcWidth: integer;
                                  tarHeight: integer; tarWidth: integer);
      procedure SaveWebBrowserToBmp;

  public
    { Public declarations }
     procedure ExAddmarker;
     procedure SetMapDisplayScale(Value:integer);
  end;

var
  Form_MapMain: TForm_MapMain;
  function CreateMapFrom(AHandle:THandle;ACaption:string;Wid,Hi,single:integer):integer;stdcall;

  //========
   const
  Doc1: string = '<html>'
  + '<head>'
  + '<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />'
  + '<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />'
  + '<title>BAIDU MAP</title>'
  + '<style type="text/css">'
  + 'html{height:100%}' + 'body{height:100%;margin:0px;padding:0px}'
  + '#container{height:100%}'
  + '</style>'
  + '<script type="text/javascript"src="http://api.map.baidu.com/api?v=2.0 & '
  + ' ak=e6DTW515NZFjXnFxhrGiUGhfm83DewTN"></script>'
  + '</head>'

  + '<body>'
  + '  <style="background:#0000FF"></style>'
  + '  <div id="container"></div>'
  +'   <div id="centerweidu" style="visibility:hidden; display:none"></div>'
  +'   <div id="centerjingdu" style="visibility:hidden; display:none"></div>'
  +'   <div id="weidutemp" style="visibility:hidden;display:none"></div>'
  +'   <div id="jingdutemp" style="visibility:hidden;display:none"></div>'
  +'   <div id="weidu" style="visibility:hidden;display:none"></div>'
  +'   <div id="jingdu" style="visibility:hidden;display:none"></div>'
  +'   <div id="Distance" style="visibility:hidden;display:none"></div>'
  +'   <div id="Coalid" style="visibility:hidden;display:none"></div>'

  +    '<script language="JavaScript" type="text/javascript">'
  +       'var map = new BMap.Map("container");'  // ������ͼʵ��
  +       'map.addControl(new BMap.NavigationControl());'
  +       'map.addControl(new BMap.ScaleControl());'
  +       'map.addControl(new BMap.OverviewMapControl());'
  +       'map.addControl(new BMap.MapTypeControl(BMAP_ANCHOR_BOTTOM_RIGHT));'   // ����ע���ӵ���ͼ��
  +       'map.enableScrollWheelZoom();'                  // ���ù��ַŴ���С��
  +       'map.enableKeyboard();'                         // ���ü��̲�����
  +       'var centerpoint = new BMap.Point(120.128294,36.005593);' // ����������  126.666431, 45.764502
  +       'marker = new BMap.Marker(centerpoint);'        // ������ע
  +       'map.addOverlay(marker);'
  +       'var label = new BMap.Label("ɽ���Ƽ���ѧ",{offset:new BMap.Size(20,-10)});'
  +       'marker.setLabel(label);'
//  +       'var centerpoint = new BMap.Point(113.774579,34.712104);'  //  ��������������õ�ͼ����
  +       ' map.centerAndZoom("̫ԭ", 5);' // ��ʼ����ͼ���������ĵ�����͵�ͼ����'

  +       ' map.addEventListener("mousemove", function(e){'
  +       ' document.getElementById("weidutemp").innerHTML = e.point.lng;'
  +       ' document.getElementById("jingdutemp").innerHTML =  e.point.lat;});'

  +       ' map.addEventListener("click", function(f){'
  +       ' document.getElementById("weidu").innerHTML = f.point.lng;'
  +       ' document.getElementById("jingdu").innerHTML =  f.point.lat;});'
  +       ' map.setMapStyle({style:"light"});' // ��ͼ���  midnight    bluish  dark   light

  +       'map.addEventListener("click", function(e){  ' //����¼�
  +       'if(!e.overlay){'
  +       '      var myIcon = new BMap.Icon("http://api.map.baidu.com/img/markers.png", new BMap.Size(23, 25), {  '
  +       '                      offset: new BMap.Size(10, 25),'   // ָ����λλ��
  +       '                      imageOffset: new BMap.Size(0, 0 - 10 * 25) ' // ����ͼƬƫ��
  +       '                   });  '
  +       '      var marker=new BMap.Marker(e.point,{icon:myIcon});  '
  +       '      map.removeOverlay(preMarker);'
  +       '      map.addOverlay(marker);   '
  +       '     preMarker=marker;    }});'

  + '</script>'
  + '</body>'

  //===============
  +'<script>'

  +   'function SetLocalPoint(){'    //��ע��ַ����
  +       'centerpoint=new BMap.Point(120.128294,36.005593);'
  +       'var marker = new BMap.Marker(centerpoint);'
  +       'map.addOverlay(marker);'
  +       'var label = new BMap.Label("ɽ���Ƽ���ѧ",{offset:new BMap.Size(20,-10)});'
  +       'marker.setLabel(label);'
  +       ' map.centerAndZoom(centerpoint, 15);' // ��ʼ����ͼ���������ĵ�����͵�ͼ����'
  +     '}'

  +   'function SetCenterView(newlng,newlat){'    //������ͼ��������
  +        ' centerpoint=new BMap.Point(newlng,newlat);'
  +        ' map.centerAndZoom(centerpoint, 15);' // ��ʼ����ͼ���������ĵ�����͵�ͼ����'
  +'    }'

  +    ' function searchByStationName(AddrName) {  ' //�������Ʋ��������
  +      '������map.centerAndZoom(AddrName, 15); '
  +      '}'

  +    ' function SetDisplayScale(bl) {  ' //������ʾ����
  +      ' map.centerAndZoom("����", bl);' // ��ʼ����ͼ���������ĵ�����͵�ͼ����'
  +      '}'

  +    'function SetMeiKuangAddr(bh,newlng,newlat,Jituan,MeiKuang,AddressText){'
  +          'centerpoint=new BMap.Point(newlng,newlat);'
  +          'var marker = new BMap.Marker(centerpoint);'
  +          'map.addOverlay(marker);'
  +          'var label = new BMap.Label(Jituan,{offset:new BMap.Size(20,-10)});'
  +          'marker.setLabel(label);'
  +          'marker.setTitle(MeiKuang);'
  +          'marker.addEventListener("click",getAttr);  '
  +          'function getAttr(){   '
	+               '  var p = marker.getPosition();     '  //��ȡmarker��λ��
	+               '  alert("��ǰ�����" + Jituan+ " ��" + MeiKuang + "  λ�ڡ�"+AddressText+"��");'
 	+               '  document.getElementById("Coalid").innerHTML = bh;'  //�õ�ú����
  +             ' }'
  +      'map.panTo(centerpoint);'
  +      '}'

  +  ' function  clearOverlays() {'   //�����ر�
  +       ' map.clearOverlays(); }'


  +  ' function SearchSupport(newlng,newlat,RedLen) {'      // ָ���뾶��Բ
  +        ' var centerpoint=new BMap.Point(newlng,newlat);'
  +        ' map.enableScrollWheelZoom(); '
	+        ' map.centerAndZoom(centerpoint,15);  '
  +        ' var circle = new BMap.Circle(centerpoint,RedLen,{fillColor:"blue", '
  +           '              strokeWeight: 1 ,fillOpacity: 0.3, strokeOpacity: 0.3});  '
  +        '   map.addOverlay(circle); '
  +        '  var local =  new BMap.LocalSearch(map, {renderOptions: {map: map, autoViewport: false}}); '
  +        '   local.searchNearby("",centerpoint,RedLen);  '
  +        '}'


  +   'function PrintLine(newlng,newlat,oldlng,oldlat,biaoji){'
  +           'var point = new BMap.Point(newlng,newlat);' // ����������
  +           'map.panTo(point);'
  +           'var polyline = new BMap.Polyline(['
  +           'new BMap.Point(oldlng,oldlat),'
  +           'new BMap.Point(point.lng, point.lat)'
  +           '], {strokeColor:"blue", strokeWeight:4, strokeOpacity:0.5});'
  +           'map.addOverlay(polyline);'
  +        '}'

  +   'function GetCenter(){'
  +       ' var center = map.getCenter();'
  +       ' document.getElementById("centerweidu").innerHTML = center.lng;'
  +       ' document.getElementById("centerjingdu").innerHTML = center.lat;'
  +       '}'

  +    'function Distance(newlng,newlat){'
  +       'var pointA=centerpoint;'
  +       'var pointB=new BMap.Point(newlng,newlat);'
  +       'document.getElementById("Distance").innerHTML = map.getDistance(pointA,pointB);'
  +       'alert(''�����ǣ�''+map.getDistance(pointA,pointB)+'' �ס�'');'

  +      '}'
  + '</script>'

  + '</html>';
  //==================
implementation

{$R *.dfm}

uses Lu_Public_BasicModual, UMainDataModule;

{ TForm2 }

function CreateMapFrom(AHandle:THandle;ACaption:string;Wid,Hi,single:integer):integer;stdcall;
 begin
       if Assigned(Form_MapMain) then  FreeANdNil(Form_MapMain);

        Form_MapMain:=TForm_MapMain.Create(nil);
        try
           with Form_MapMain do begin
               Caption:=ACaption;
               WindowState:= wsMaximized;
               ParentWindow:=Ahandle;
              
               if Hi >Height then
                   Top :=Round((Hi-Height)/3)  else   Top :=0;
               if Wid> Width then
                   Left:=Round((Wid-Width)/2)  else   Left:=0;

                Show;
                MakeWindowsSingle(Single);
                SetFocus;
                Result:=1;//����ֵ
          end ;
        except
           FreeAndNil(Form_MapMain);
        end;
 end;

procedure TForm_MapMain.AddAllMarker;
var
  i:integer;
  bh,Jituan,KuangM,Jd,wd,Addr:string;
begin

    for I := 1 to SG_YBZ.RowCount-1 do  begin
      bh :=Trim(SG_YBZ.Cells[0,i]);
      KuangM:=Trim(SG_YBZ.Cells[1,i]);
      Jituan:=Trim(SG_YBZ.Cells[2,i]);
      jd:=Trim(SG_YBZ.Cells[3,i]);
      wd:=Trim(SG_YBZ.Cells[4,i]);
      Addr:=Trim(SG_YBZ.Cells[5,i]);
      if public_Basic.StrToInt_lu(bh) >0 then   begin
         MarkerSupportMap(bh,jd,wd,Jituan,KuangM,Addr);
      end;
    end;

    SetMapDisplayScale(5);
end;

procedure TForm_MapMain.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
var
  mPoint:TPoint;
begin
    if IsChild(WebBrowser.Handle ,Msg.hwnd ) and
        ((Msg.message = WM_RBUTTONDOWN ) or (MSg.message =WM_RBUTTONUP)) then  begin
           GetCurSorPos(mPoint);
           DispMapPop(mPoint.X ,mPoint.Y);
           Handled:=True;
        end;

end;

procedure TForm_MapMain.AppMsg(var Msg: TagMsg; var Handled: Boolean);
var
  mPoint: TPoint;
begin
  if IsChild(WebBrowser.Handle, Msg.Hwnd) and (Msg.Message = WM_MOUSEMOVE) then
  begin
    GetCursorPos(mPoint);
    GetWebContent;
    Handled := True;
  end;
end;

procedure TForm_MapMain.BitBtn1Click(Sender: TObject);
var
  sql:string;
begin
  if (Click_Jd <> '') and (Click_wd <> '') then   begin
     if MarkerSupportMap(SelectbZj_bh,Click_Jd,Click_wd,Select_J,Select_M,Select_A) then begin
         Panel_Text.Caption  :='';
         Select_M:='';
         sql:='update KuangJingXinXiBiao set mapxbz=1 ,Jingdu='''+Click_Jd+''',weidu='''+Click_wd;
         sql:=sql +''' where id='+SelectbZj_bh;
         MainDataModule.MyCommand.CommandText:=sql;
         MainDataModule.MyCommand.Execute(MainDataModule.ExUser);
         BitBtn1.Enabled :=false;
         InitSG_StringGrid;
     end;
  end;
  ExAddmarker;
end;

procedure TForm_MapMain.BitBtn2Click(Sender: TObject);
var
 s_sql:widestring;
begin
   if  Application.MessageBox('��ȷ��Ҫɾ����ͼ��עô��','������ʾ',MB_ICONQUESTION+MB_OkCancel+MB_DEFBUTTON2)=idCancel then
        exit;
   s_sql:='update KuangJingXinXiBiao set mapxbz=0 where id='+SelectbZj_bh;
   MainDataModule.MyCommand.CommandText:=s_sql;
   MainDataModule.MyCommand.Execute(MainDataModule.ExUser);
   InitSG_StringGrid;
   ClearMapMarker ;
   SetLocalMarker;
   AddAllMarker;
   BitBtn2.Enabled :=false;
end;

procedure TForm_MapMain.Button1Click(Sender: TObject);
begin
   searchByStationName(Trim(selectEdit.Text));
end;

procedure TForm_MapMain.ClearMapMarker;
begin
   WebBrowser.OleObject.Document.parentWindow.execScript ('clearOverlays()', 'JavaScript');
end;

function TForm_MapMain.CreateClass: Boolean;
begin

end;

procedure TForm_MapMain.DispMapPop(Px, Py: Integer);
begin
   if wholeScreen then  begin
      if Click_Coalid <>'' then  begin
         Pop_Open.Enabled :=true;
      end else begin
         Pop_Open.Enabled :=False;
      end;
      Popup_Map.Popup(px,py);
   end;
end;

procedure TForm_MapMain.ExAddmarker;
begin
    ClearMapMarker ;
    SetLocalMarker;
    AddAllMarker;
end;

procedure TForm_MapMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   Timer1.Enabled :=False;
   if Assigned(Form_MapMain) then  FreeANdNil(Form_MapMain);
end;

procedure TForm_MapMain.FormCreate(Sender: TObject);
begin
  LoadwebT:=False;
  SelectRad:='1000';

end;

procedure TForm_MapMain.FormShow(Sender: TObject);
begin
   PubLic_Basic.InitStatusBar(self.StatusBar1);
   Mapx_Out_in:= MainDataModule.ExAdminBool;
   MarkOrSelect:=false;
   initPanelLeft;
   InitSG_StringGrid;
   InitPanleMap;
   MapVisual(true);

end;

procedure TForm_MapMain.GenerateJPEGfromBrowser(browser: iWebBrowser2;
  jpegFQFilename: string; srcHeight, srcWidth, tarHeight, tarWidth: integer);
var
  sourceDrawRect: TRect;
  targetDrawRect: TRect;
  sourceBitmap  : TBitmap;
  targetBitmap  : TBitmap;
  aViewObject   : IViewObject;
begin { GenerateJPEGfromBrowser }
  sourceBitmap := TBitmap.Create;
  targetBitmap := TBitmap.Create;
 try
    try
      sourceDrawRect := Rect(0, 0, srcWidth, srcHeight);
      sourceBitmap.Width := srcWidth;
      sourceBitmap.Height := srcHeight;

      aViewObject := browser as IViewObject;

      if aViewObject=nil then    Exit;

      OleCheck(aViewObject.Draw(DVASPECT_CONTENT, 1, nil, nil,
                               Form_MapMain.Handle,
                               sourceBitmap.Canvas.Handle,
                               @sourceDrawRect, nil, nil, 0));

      targetDrawRect := Rect(0, 0, tarWidth, tarHeight);
      targetBitmap.Height := tarHeight;
      targetBitmap.Width := tarWidth;
      targetBitmap.Canvas.StretchDraw(targetDrawRect, sourceBitmap);

      targetBitmap.SaveToFile(jpegFQFilename)
    finally

      sourceBitmap.Free;
      targetBitmap.Free
    end; { try }

  except
    // error handler code  end; { try }
end; { GenerateJPEGfromBrowser }

end;

procedure TForm_MapMain.GetWebContent;
var
  html: IHTMLDocument2; // ������ҳԪ��
  submitbutton: OleVariant; // ���尴ť
  centerweidu, centerjingdu, weidu, jingdu, weidutemp,
  jingdutemp,Coalid: IHTMLElement; // ������ҳ����Ԫ��
begin
  try
    html := self.WebBrowser.Document as IHTMLDocument2;
    centerweidu := html.all.item('centerweidu', 0) as IHTMLElement;
    centerjingdu := html.all.item('centerjingdu', 0) as IHTMLElement;
    weidu := html.all.item('weidu', 0) as IHTMLElement;
    jingdu := html.all.item('jingdu', 0) as IHTMLElement;
    weidutemp := html.all.item('weidutemp', 0) as IHTMLElement;
    jingdutemp := html.all.item('jingdutemp', 0) as IHTMLElement;
    Coalid:= html.all.item('Coalid', 0) as IHTMLElement;

    if weidutemp <>nil  then
       Myjingdu:= weidutemp.innerText;
    if jingdutemp<>nil then
       Myweidu:= jingdutemp.innerText;
    if weidu<> nil then
       Click_Jd:=weidu.innerText;
    if jingdu <> nil then
       Click_Wd:= jingdu.innerText;
    if Coalid <> nil then
       Click_Coalid:= Coalid.innerText else Click_Coalid:='';

    if (Click_Jd<>'') and (Select_M <>'') and (MarkOrSelect) then
        Panel_Text.Caption  :='��ǰ��λú��Ϊ��' +Select_J+ '  ' + Select_M+ ';   ' +
             ' ��ǰ����λ��Ϊ����'+Click_Jd +',  ά��'+Click_Wd;
    if (Click_Jd<>'') and (Select_M <>'') and (not MarkOrSelect) then
        Panel_Text.Caption  :='��ǰ��־���ĵ㾭�ȣ�'+Click_Jd +',  ά��'+Click_Wd +
                    '��ע�뾶Ϊ��'+self.SelectRad +' ��';

    StatusBar1.Panels[1].Text:='����:'+MyJingdu +'   ά��:' +MyWeidu;
  except
  end;
end;



procedure TForm_MapMain.initPanelLeft;
begin
      self.PanelLeft.Visible:=true;
      SG_WBZ.ColCount :=4;
      SG_WBZ.FixedCols:=1;
      SG_WBZ.FixedRows:=1;
      SG_WBZ.DefaultRowHeight:=18;
      SG_WBZ.ColWidths[0]:=30;    SG_WBZ.Cells[0,0]:='���';
      SG_WBZ.ColWidths[1]:=80;    SG_WBZ.Cells[1,0]:='ú������';
      SG_WBZ.ColWidths[2]:=80;    SG_WBZ.Cells[2,0]:='���Ź�˾';
      SG_WBZ.ColWidths[3]:=80;    SG_WBZ.Cells[3,0]:='ú���ַ';

      SG_YBZ.ColCount :=6;
      SG_YBZ.FixedCols:=1;
      SG_YBZ.FixedRows:=1;
      SG_YBZ.DefaultRowHeight:=18;
      SG_YBZ.ColWidths[0]:=30;    SG_YBZ.Cells[0,0]:='���';
      SG_YBZ.ColWidths[1]:=80;    SG_YBZ.Cells[1,0]:='���Ź�˾';
      SG_YBZ.ColWidths[2]:=80;    SG_YBZ.Cells[2,0]:='ú������';
      SG_YBZ.ColWidths[3]:=80;    SG_YBZ.Cells[3,0]:='����';
      SG_YBZ.ColWidths[4]:=80;    SG_YBZ.Cells[4,0]:='γ��';
end;



procedure TForm_MapMain.InitPanleMap;
begin
  PanelMap.Align:=alClient;
  loadweb;
  Click_Jd := '';
  Click_wd := '';
  timer1.Enabled := True;
end;

procedure TForm_MapMain.InitSG_StringGrid;
var
    I,J:integer;
    bh,Str:widestring;

begin
     for I := 1 to SG_WBZ.RowCount - 1 do
         for j := 0 to SG_WBZ.ColCount - 1 do
                SG_WBZ.Cells[j,i]:='';
       for I := 1 to SG_YBZ.RowCount - 1 do
         for j := 0 to SG_YBZ.ColCount - 1 do
                SG_YBZ.Cells[j,i]:='';

      MainDataModule.MyDataSet.Close();
      MainDataModule.MyDataSet.CommandText:='select id,Meikuangming,JituanName,Memo1 from KuangJingXinXiBiao where mapXbz=0  ';
      MainDataModule.MyDataSet.Open();
      if MainDataModule.MyDataSet.RecordCount >0 then  begin
         Sg_WBZ.RowCount:=MainDataModule.MyDataSet.RecordCount+2;
      end;

      i:=1;
      while not MainDataModule.MyDataSet.Eof  do begin
            self.SG_WBZ.Cells[0,i]:=MainDataModule.MyDataSet.FieldByName('id').AsString;
            self.SG_WBZ.Cells[1,i]:=MainDataModule.MyDataSet.FieldByName('Meikuangming').AsString;
            self.SG_WBZ.Cells[2,i]:=MainDataModule.MyDataSet.FieldByName('JituanName').AsString;
            self.SG_WBZ.Cells[3,i]:=MainDataModule.MyDataSet.FieldByName('Memo1').AsString;
            MainDataModule.MyDataSet.Next;
            i:=i+1;
          end;
      MainDataModule.MyDataSet.Close();
      MainDataModule.MyDataSet.CommandText:='select id,Meikuangming,JituanName,Memo1,Jingdu,Weidu from KuangJingXinXiBiao where mapXbz=1 ';
      MainDataModule.MyDataSet.Open();
      if MainDataModule.MyDataSet.RecordCount >0 then  begin
         Sg_YBZ.RowCount:=MainDataModule.MyDataSet.RecordCount+2;
      end;
      i:=1;
      while not MainDataModule.MyDataSet.Eof  do    begin
            self.SG_YBZ.Cells[0,i]:=MainDataModule.MyDataSet.FieldByName('id').AsString;
            bh:= MainDataModule.MyDataSet.FieldByName('id').AsString;;
            self.SG_YBZ.Cells[1,i]:=MainDataModule.MyDataSet.FieldByName('Meikuangming').AsString;
            self.SG_YBZ.Cells[2,i]:=MainDataModule.MyDataSet.FieldByName('JituanName').AsString;
            str:= bh+'|'+MainDataModule.MyDataSet.FieldByName('JituanName').AsString+'|'+MainDataModule.MyDataSet.FieldByName('Meikuangming').AsString;
            SG_YBZ.Cells[3,i]:=MainDataModule.MyDataSet.FieldByName('Jingdu').AsString;
            SG_YBZ.Cells[4,i]:=MainDataModule.MyDataSet.FieldByName('weidu').AsString;
            SG_YBZ.Cells[5,i]:=MainDataModule.MyDataSet.FieldByName('Memo1').AsString;;
            i:=i+1;
            MainDataModule.MyDataSet.Next;

          end;
          StatusBar1.Panels.Items[1].Text :='' ;
       MainDataModule.MyDataSet.Close();


end;

procedure TForm_MapMain.loadexcel(rowCount, colCount: integer; fileName: String;
  var grid: TStringGrid);

begin


end;

procedure TForm_MapMain.loadweb;
var
  sl: TStringList;
  ms: TMemoryStream;
begin
  self.WebBrowser.Silent := True;
  WebBrowser.Navigate('about:blank'); (WebBrowser.Document as IHTMLDocument2)
  .URL := 'http://127.0.0.1/';
  while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;
  if Assigned(WebBrowser.Document) then
  begin
    sl := TStringList.Create;
    try
      ms := TMemoryStream.Create;
      try
        sl.Text := Doc1;
        sl.SaveToStream(ms);
        ms.Seek(0, 0); (WebBrowser.Document as IPersistStreamInit)
        .Load(TStreamAdapter.Create(ms));
      finally
        ms.Free;
      end;
    finally
      sl.Free;
    end;
  end;


end;

procedure TForm_MapMain.MakeWindowsSingle(Single: integer);
begin
    if Single=0 then  begin
         BorderStyle:=BsSizeable;
         CoolBar1.Visible :=true;
         StatusBar1.Visible :=true;
         PageControl1.Visible:=true;
         PanelLeft.Visible:=true;
         Panel_Text.Visible:=true;
         wholeScreen:=False;
    end else begin
         BorderStyle:=BsNone;
         CoolBar1.Visible :=False;
         StatusBar1.Visible :=False;
         PanelLeft.Visible:=False;
         PageControl1.Visible:=False;
         WindowState:= wsMaximized;
         Panel_Text.Visible:=False;
         wholeScreen:=true;
    end;

end;

procedure TForm_MapMain.MapVisual(Value: Boolean);
begin

       self.PanelMap.Visible :=Value;
       self.PanelLeft.Visible :=Value;



end;

function TForm_MapMain.MarkerSupportMap(coalbh,jd,wd,Jituan,MeiKuang,Address:string):Boolean;
var
  DispLab:string;
begin
  Result:=true;
   try
      DispLab:=MeiKuang;
      WebBrowser.OleObject.Document.parentWindow.execScript
      ('SetMeiKuangAddr('  + coalbh + ','+ jd + ',' + wd + ','''+DispLab+''','''+MeiKuang+''','''+Address+''')', 'JavaScript');

   except
      Result:=False;
   end;
end;

procedure TForm_MapMain.OptionTip(Str: String);
begin
  self.StatusBar1.Panels[0].Text :=str;
end;


procedure TForm_MapMain.Pop_LoadAllClick(Sender: TObject);
begin
    ClearMapMarker ;
    SetLocalMarker;
    AddAllMarker;

end;

procedure TForm_MapMain.SaveWebBrowserToBmp;
var
  IDoc1: IHTMLDocument2;
  Web  : iWebBrowser2;
  tmpX, tmpY : integer;
  Pic_Path:string;
begin { TForm1.Button2Click }
  Pic_Path:=Public_Basic.Get_MyModulePath+'saveBmp\CoalBMP\MainBmp.BMP';

  with WebBrowser do   begin
    Document.QueryInterface(IHTMLDocument2, IDoc1);
    Web := ControlInterface;
    tmpX := Height;
    tmpY := Width;
    Height := OleObject.Document.Body.getAttribute('scrollHeight', 0) + GetSystemMetrics(SM_CXVSCROLL)+3;// .ParentWindow.Screen.Height+1000;
    Width := OleObject.Document.Body.getAttribute('scrollwidth', 0) + GetSystemMetrics(SM_CXVSCROLL)+3;//.ParentWindow.Screen.Width;
    GenerateJPEGfromBrowser(Web, Pic_Path,
                            Height, Width,
                            Height, Width);
    Height := tmpX;
    Width := tmpY;

  end; { with WebBrowser1 }

end;

function TForm_MapMain.searchByStationName(AName: string): Boolean;
begin
   Result:=true;
   try
      WebBrowser.OleObject.Document.parentWindow.execScript
      ('searchByStationName(''' + AName +''')', 'JavaScript');

   except
      Result:=False;
   end;
end;

procedure TForm_MapMain.SelectEditClick(Sender: TObject);
begin
   SelectEdit.SetFocus;
end;

procedure TForm_MapMain.SetLocalMarker;
begin
   //��ע��ַ����
    WebBrowser.OleObject.Document.parentWindow.execScript ('SetLocalPoint()', 'JavaScript');
end;

procedure TForm_MapMain.SetMapDisplayScale(Value: integer);
begin
    WebBrowser.OleObject.Document.parentWindow.execScript
           ('SetDisplayScale(' + intTostr(Value) + ')', 'JavaScript');
end;

procedure TForm_MapMain.SG_WBZSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
    MarkOrSelect:=true;
    SelectbZj_bh :=Trim(SG_WBZ.Cells[0,ARow]);
    Select_M:=Trim(SG_WBZ.Cells[1,ARow]);
    Select_J:=Trim(SG_WBZ.Cells[2,ARow]);
    Select_A:=Trim(SG_WBZ.Cells[3,ARow]);
     if  length(trim(SelectbZj_bh))>0 then begin
         BitBtn1.Enabled :=Mapx_Out_in;
         Click_jd:='';Click_wd:='';
         SelectEdit.Text := Select_M;
//         if not searchByStationName(Select_M) then
//           if not  searchByStationName(Select_J) then
//              searchByStationName(Select_A) ;
     end;
end;

procedure TForm_MapMain.SG_YBZSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  jd,wd:string;
begin
     jd:='';wd:='';
     SelectbZj_bh :=Trim(SG_YBZ.Cells[0,ARow]);
     if  length(trim(SelectbZj_bh))>0 then begin
         BitBtn2.Enabled :=Mapx_Out_in;
         jd :=Trim(SG_YBZ.Cells[3,ARow]);
         wd :=Trim(SG_YBZ.Cells[4,ARow]);
         if (jd<> '') and (wd<>'') then
         WebBrowser.OleObject.Document.parentWindow.execScript
           ('SetCenterView(' + jd + ',' + wd + ')', 'JavaScript');

     end;
end;

procedure TForm_MapMain.Timer1Timer(Sender: TObject);
begin
     GetWebContent;
end;

procedure TForm_MapMain.ToolButton11Click(Sender: TObject);
begin
  if not self.PanelMap.Visible  then
     MapVisual(true);
  MarkOrSelect:=false;
  if (Click_Jd <> '') and (Click_wd <> '') then     begin
      self.WebBrowser.OleObject.Document.parentWindow.execScript
      ('SearchSupport(' + Click_Jd + ',' + Click_wd + ', '+ SelectRad+')', 'JavaScript');
  end;


end;

procedure TForm_MapMain.ToolButton12Click(Sender: TObject);
begin
   ClearMapMarker ;
end;

procedure TForm_MapMain.ToolButton13Click(Sender: TObject);
begin
    ExAddmarker;
end;

procedure TForm_MapMain.ToolButton14Click(Sender: TObject);
begin
  Close;
end;

procedure TForm_MapMain.ToolButton1Click(Sender: TObject);
begin
//   self.MapVisual(false);
 
end;

procedure TForm_MapMain.ToolButton2Click(Sender: TObject);
begin
  // self.SaveIntoDataBase;

end;

procedure TForm_MapMain.ToolButton4Click(Sender: TObject);
begin
   InitPanleMap;
   MapVisual(true);

end;

procedure TForm_MapMain.ToolButton5Click(Sender: TObject);
begin
    SelectRad:=InputBox('��ѯ�뾶¼��', '��¼���ѯ�뾶���ף�', '1000') ;
    if Public_basic.StrToDouble_Lu(SelectRad)  <100 then
      SelectRad:='1000';

end;

procedure TForm_MapMain.ToolButton6Click(Sender: TObject);
begin
   AddAllMarker;
end;

procedure TForm_MapMain.ToolButton7Click(Sender: TObject);
begin
    SetLocalMarker;
end;

end.


