object FormZJCS: TFormZJCS
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #25903#26550#35745#31639#21442#25968#35774#35745
  ClientHeight = 428
  ClientWidth = 727
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 160
    Top = 8
    Width = 300
    Height = 19
    Margins.Bottom = 0
    Caption = #25903#26550#20998#25285#32769#39030#23721#26753#37325#37327#27604#20363#21442#25968#34920
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = #20223#23435'_GB2312'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StringGrid_ZJCS: TStringGrid
    Left = 8
    Top = 48
    Width = 585
    Height = 361
    Color = clBtnFace
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goAlwaysShowEditor]
    ScrollBars = ssNone
    TabOrder = 0
    ColWidths = (
      64
      64
      64
      64
      64)
    RowHeights = (
      24
      24
      24
      24
      24)
  end
  object Button1: TButton
    Left = 616
    Top = 96
    Width = 103
    Height = 33
    Caption = #21462#28040#26412#27425#20462#25913
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 616
    Top = 160
    Width = 103
    Height = 33
    Caption = #24212#29992#20462#25913#21442#25968
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 616
    Top = 223
    Width = 103
    Height = 33
    Caption = #24674#22797#31995#32479#21021#22987#20540
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 616
    Top = 287
    Width = 103
    Height = 33
    Caption = #36864#20986#20462#25913#30028#38754
    TabOrder = 4
    OnClick = Button4Click
  end
end
