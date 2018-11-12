unit MapTuCVisi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Commctrl, ComCtrls, StdCtrls,IniFiles;

type
  TMapFormVisi = class(TForm)
    TreeView1: TTreeView;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure TreeView1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TreeView1GetSelectedIndex(Sender: TObject; Node: TTreeNode);
    procedure TreeView1GetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
       procedure tvToggleCheckbox(TreeView: TTreeView;Node: TTreeNode;isclick:boolean =false);
       procedure SetChecked(Node: TTreeNode; Checked: Boolean);
       function IsChecked(Node: TTreeNode): Boolean;
  public
    { Public declarations }
    Path :widestring;
  end;

var
  MapFormVisi: TMapFormVisi;

implementation

uses MapX_LuLeiImpl;

{$R *.dfm}
Const
 TVIS_CHECKED = $2000;

procedure TMapFormVisi.Button1Click(Sender: TObject);
 var
      i:integer;
      sonNode:TTreeNode;
begin
       // TreeView1.Items.Count
      for  i := 0 to TreeView1.Items.Count-1 do
        begin
            sonNode:=TreeView1.Items[i];
            SetChecked(sonNode, false);
        end;
end;

procedure TMapFormVisi.Button2Click(Sender: TObject);
 var
      i:integer;
      sonNode:TTreeNode;
begin
       // TreeView1.Items.Count
      for  i := 0 to TreeView1.Items.Count-1 do
        begin
            sonNode:=TreeView1.Items[i];
            SetChecked(sonNode, true);
        end;
end;

procedure TMapFormVisi.Button3Click(Sender: TObject);
begin
    MapFormVisi.Close;
end;

procedure TMapFormVisi.Button4Click(Sender: TObject);
 var
   I:integer;
   pIniFile:     TIniFile;
   Node: TTreeNode;
begin
    pIniFile := Tinifile.create(Path+'ChinaMap\mapx_lulei.dat');//打开 1.ini 文件
    //showMessage(Path+'ChinaMap\mapx_lulei.dat');
    for I := 1 to TreeView1.Items.Count  do
       begin
           Node:= TreeView1.Items[i-1];
           if IsChecked(Node) then begin
              FMap.Layers[i].Visible :=true;
               pIniFile.WriteString('TCVis',Trim(FMap.Layers[i].Name), 'true');
           end else begin
              FMap.Layers[i].Visible :=False;
               pIniFile.WriteString('TCVis',Trim(FMap.Layers[i].Name), 'false');
           end;
       end;
      pIniFile.Free;
      MapFormVisi.Close;
end;

procedure TMapFormVisi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action:=caFree;
end;

procedure TMapFormVisi.FormCreate(Sender: TObject);
var
  i:integer;
  sonNode:TTreeNode;
begin
    SetWindowLong(TreeView1.Handle, GWL_STYLE, GetWindowLong(TreeView1.Handle, GWL_STYLE) or $00000100);
    TreeView1.Items.Clear;
    for I := 1 to FMap.Layers.Count do
    begin
       sonNode:= self.TreeView1.Items.Add(nil,FMap.Layers.Item[i].Name );
       if FMap.Layers.Item[i].Visible  then  begin
            SetChecked(sonNode, true);
       end else begin
            SetChecked(sonNode, false);
       end;
        sonNode.ImageIndex :=1;
        sonNode.SelectedIndex:=2;

    end;
end;

function TMapFormVisi.IsChecked(Node: TTreeNode): Boolean;
 var
      TvItem :TTVItem;
 begin
       TvItem.Mask := TVIF_STATE;
       TvItem.hItem := Node.ItemId;
       TreeView_GetItem(Node.TreeView.Handle, TvItem);
       Result := (TvItem.State and TVIS_CHECKED) = TVIS_CHECKED;
 end;
 //让 某个节点被 选中
procedure TMapFormVisi.SetChecked(Node: TTreeNode; Checked: Boolean);
 var
     TvItem :TTVItem;
 begin
       FillChar(TvItem, SizeOf(TvItem), 0);
       with TvItem do begin
             hItem := Node.ItemId;
             Mask := TVIF_STATE;
             StateMask := TVIS_STATEIMAGEMASK;
             if Checked then
             TvItem.State :=TVIS_CHECKED
       else
             TvItem.State :=TVIS_CHECKED shr 1;
             TreeView_SetItem(Node.TreeView.Handle, TvItem);
       end;
 end; 


// 对节点中所有 子节点 都 选中或 未选中 状态
procedure TMapFormVisi.tvToggleCheckbox(TreeView: TTreeView;
 Node: TTreeNode ;isclick :boolean=false);
 var
        CurNode, ParentNode, GrandSonNode,sonNode: TTreeNode;
         flg1: boolean;
 begin
      CurNode :=node;
       with TreeView do begin
       if IsChecked(CurNode) then //
          begin
              sonNode := CurNode.GetFirstChild; //遍历子树,选中 则子节点 全部 为选中；
                 while sonNode<>nil do
                     begin
                         SetChecked(sonNode, true);
                         tvToggleCheckbox(TreeView,sonNode,true);
                         sonNode := sonNode.GetNextSibling;
                      end;  // end while

 

          ParentNode:= CurNode.Parent; //父；
          if ParentNode<>nil then
           begin
               if not isChecked(parentNode) then begin
                   GrandSonNode := ParentNode.GetFirstChild; //遍历子树；
                   flg1 := false;
                   while GrandSonNode<>nil do
                     begin
                           if (not IsChecked(GrandSonNode)) then //true,有未选中
                                    flg1 := true;
                            if flg1 then //已有、退出loop;
                                   GrandSonNode := nil
                            else
                                   GrandSonNode := GrandSonNode.GetNextSibling;
                            end; // end if flg1
                            SetChecked(ParentNode, not flg1);
                            tvToggleCheckbox(TreeView,ParentNode,false);
                   end;  //end while
                 end; // end  if not isChecked(parentNode)不等于空
          end else if not IsChecked(CurNode) then
             begin
                ParentNode := CurNode.Parent; //父；
                if ParentNode<>nil then
                 begin
                       if isChecked(parentNode) then begin
                           SetChecked(ParentNode, false);
                           tvToggleCheckbox(TreeView,ParentNode);
                      end;
                 end; //end parentnode

                if (isclick) then begin
                   sonNode := CurNode.GetFirstChild; //遍历子树,未选中 则子节点 全部 为未选中；
                        while sonNode<>nil do
                         begin
                               SetChecked(sonNode, false);
                               tvToggleCheckbox(TreeView,sonNode,true);
                               sonNode := sonNode.GetNextSibling;
                         end;
                   end;  // end if  if (isclick) then begin

         end;    //end  if ParentNode<>nil then
     end;   //end  if IsChecked(CurNode) then //
 end;



procedure TMapFormVisi.TreeView1Click(Sender: TObject);
 var
       P:TPoint;
       treenode :TTreeNode;
 begin
           GetCursorPos(P);
           P := TreeView1.ScreenToClient(P);
           if (htOnStateIcon in TreeView1.GetHitTestInfoAt(P.X,P.Y)) then begin
                   treenode := TreeView1.GetNodeAt(P.X,P.Y);
                   tvToggleCheckbox(TreeView1,treenode ,true);
           end;

 end;

procedure TMapFormVisi.TreeView1GetImageIndex(Sender: TObject; Node: TTreeNode);
begin
      Node.SelectedIndex :=1;
end;

procedure TMapFormVisi.TreeView1GetSelectedIndex(Sender: TObject;
  Node: TTreeNode);
begin
      Node.SelectedIndex :=2;
end;

end.
