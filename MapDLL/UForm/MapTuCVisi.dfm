object MapFormVisi: TMapFormVisi
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #22320#22270#22270#23618#26174#31034#19982#38544#34255#25805#20316
  ClientHeight = 547
  ClientWidth = 296
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TreeView1: TTreeView
    Left = 0
    Top = 0
    Width = 193
    Height = 547
    Align = alLeft
    Indent = 19
    TabOrder = 0
    OnClick = TreeView1Click
    OnGetImageIndex = TreeView1GetImageIndex
    OnGetSelectedIndex = TreeView1GetSelectedIndex
  end
  object Button1: TButton
    Left = 199
    Top = 64
    Width = 70
    Height = 25
    Caption = #20840#37096#38544#34255
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 199
    Top = 112
    Width = 70
    Height = 25
    Caption = #20840#37096#26174#31034
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 199
    Top = 152
    Width = 70
    Height = 25
    Caption = #21462#28040
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 199
    Top = 200
    Width = 70
    Height = 25
    Caption = #24212#29992
    TabOrder = 4
    OnClick = Button4Click
  end
end
