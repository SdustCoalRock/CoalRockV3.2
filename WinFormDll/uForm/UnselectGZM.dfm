object selectGZM: TselectGZM
  Left = 0
  Top = 0
  Caption = #26356#25442#35745#31639#22320#36136#20449#24687
  ClientHeight = 322
  ClientWidth = 790
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object But_OK: TButton
    Left = 519
    Top = 285
    Width = 165
    Height = 29
    Caption = #25968#25454#19968#33268#24615#39564#35777
    TabOrder = 0
    OnClick = But_OKClick
  end
  object But_Close: TButton
    Left = 712
    Top = 280
    Width = 57
    Height = 29
    Caption = #20851#38381
    TabOrder = 1
    OnClick = But_CloseClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 24
    Width = 161
    Height = 290
    Caption = #29028#30719#20449#24687
    TabOrder = 2
    object TVMk: TTreeView
      Left = 2
      Top = 41
      Width = 157
      Height = 247
      Align = alClient
      Images = ImageList1
      Indent = 19
      TabOrder = 0
      OnClick = TVMkClick
    end
    object PanelMk: TPanel
      Left = 2
      Top = 15
      Width = 157
      Height = 26
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 176
    Top = 27
    Width = 162
    Height = 287
    Caption = #37319#29028#24037#20316#38754#20449#24687
    TabOrder = 3
    object TVGzm: TTreeView
      Left = 2
      Top = 41
      Width = 158
      Height = 244
      Align = alClient
      Images = ImageList1
      Indent = 19
      TabOrder = 0
      OnClick = TVGzmClick
    end
    object PanelGzM: TPanel
      Left = 2
      Top = 15
      Width = 158
      Height = 26
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
  object GroupBox3: TGroupBox
    Left = 344
    Top = 27
    Width = 169
    Height = 287
    Caption = #30456#20851#38075#23380#20449#24687
    TabOrder = 4
    object TVZk: TTreeView
      Left = 2
      Top = 41
      Width = 165
      Height = 244
      Align = alClient
      Images = ImageList1
      Indent = 19
      TabOrder = 0
      OnClick = TVZkClick
      ExplicitLeft = 3
      ExplicitTop = 47
    end
    object PanelZK: TPanel
      Left = 2
      Top = 15
      Width = 165
      Height = 26
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 518
    Top = 65
    Width = 249
    Height = 170
    TabOrder = 5
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 247
      Height = 168
      Margins.Bottom = 0
      Align = alClient
      Font.Charset = GB2312_CHARSET
      Font.Color = clTeal
      Font.Height = -24
      Font.Name = #26999#20307'_GB2312'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
      ExplicitWidth = 13
      ExplicitHeight = 24
    end
  end
  object Button1: TButton
    Left = 576
    Top = 24
    Width = 190
    Height = 26
    Caption = #25171#24320#24037#20316#38754#32465#23450#38075#23380#30028#38754
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = Button1Click
  end
  object ImageList1: TImageList
    BlendColor = clWindow
    BkColor = clSilver
    DrawingStyle = dsTransparent
    Left = 524
    Top = 8
    Bitmap = {
      494C01010500E003A80210001000C0C0C000FF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FDFDFDFFC0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000FEFEFEFFB0B1B3FF55AABAFFF7F7F7FFC0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000FDFDFDFFAEAFB1FF00D1F9FF4DEAFDFF2FACC4FFF2F2F2FFC0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000FCFC
      FCFFABADAFFF00D9FAFF00D1F9FF48EAFDFF00DCFBFF1BB7D6FFEDEDEEFFC0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000FBFBFBFFAAAB
      ADFF00E0FBFF00D9FAFF00D1F9FF60EDFEFF00DDFBFF00D8FAFF0EBFE5FFE3E4
      E4FFC0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000FAFAFAFFA8A9ABFF70F3
      FEFF00E0FBFF00D9FAFF00D1F9FF6DEFFEFF00DDFBFF00D8FAFF00D2FAFF06C4
      EEFFD8D9DAFFC0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000A5A6A9FF7DF8FEFF70F3
      FEFF2DE6FCFF00D9FAFF00D1F9FF74F0FEFF00DDFBFF00D8FAFF00D2FAFF00CD
      F9FF02C4F4FFD1D2D3FFC0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C00090FBFFFF83F8FFFF76F3
      FEFF6DEEFDFF00D9FAFF00D1F9FF84F1FEFF20E2FCFF00D8FAFF00D2FAFF00CD
      F9FF00C8F8FF00C2F7FFEBECECFFC0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C00097FBFFFF8AF9FFFF7DF4
      FEFF70EEFDFF06DAFBFF00D1F9FF8CF3FEFF81EFFEFF00D8FAFF00D3FAFF00CE
      F9FF00C8F8FF00C3F8FFE6E6E7FFC0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000A3CACDFF8AF9FFFF7DF4
      FEFF70EEFDFF68E9FDFF00D1F9FF26D7FBFF8CF0FEFF23DEFBFF00D3FAFF00CE
      F9FF00C8F8FF00C3F8FFE6E6E7FFC0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000A3CACDFF83F4
      FEFF76EFFDFF70EAFDFF53E0FBFF00CAF9FF01C6F9FF8AEEFDFF02D4FBFF00CE
      F9FF00C9F8FF00C4F8FFE6E6E7FFC0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000A2C8
      CCFF76EFFDFF70EAFDFF63E3FCFF4EDBFBFF00C5F8FF00C3F8FF79E7FDFF02CF
      FAFF00C9F8FF00C4F8FFE6E6E7FFC0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C0008EC4CFFF5CDDFCFF4FD7FBFF2BCDFAFF18CBFAFF8CEA
      FDFF2BD2FAFF00C4F8FFEBECECFFC0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000F1F1F2FF55D9FBFF48D4FAFFF4F5F5FF95E0
      EFFF8CE7FCFF84E3FCFFF3F3F3FFC0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000AFC7CEFFC0C0C000C0C0
      C00094D9E9FF8CE5FCFFF3F3F3FFC0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00097D1E1FFF5F6F6FFC0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000808080008080800C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00008080800BD790000734900000808
      0800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000000
      000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      00000000000000000000C0C0C000C0C0C0008486840000860000008600000086
      0000008600000086000000860000008600000086000000860000008600000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00008080800BD790000DE96000052300000BD79
      000008080800C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000000
      840000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      00000000840000008400C0C0C000C0C0C0008486840000860000008600000086
      0000008600000086000000860000008600000086000000860000008600000086
      000000000000C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000000000000000C0C0
      C000C0C0C000C0C0C0000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C0000808080073007300DE960000DE960000523000009461
      0000080808007B797B00C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C7C60084868400008600000086
      0000008600000086000000860000008600000086000000860000008600000086
      00000086000000000000C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000C0C0C000C0C0C00000000000C0C0C000C0C0C000C0C0
      C00000000000C0C0C0000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000080808003900BD0073007300DE960000DE960000523000009461
      0000080808006B696B007B797B00C0C0C000C6C7C6000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60084868400008600000086
      0000008600000086000000860000008600000086000000860000008600000086
      0000008600000086000000000000C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C0000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000080808003900BD000000DE0073007300DE960000DE960000523000009461
      0000080808006B696B007B797B00C0C0C000C6C7C6000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C6008486840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000086
      000000860000008600000086000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C0000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000FFFF00000000000000000000C0C0C000C0C0C000C0C0C0000808
      0800180052000000DE000000DE0073007300DE960000DE960000523000009461
      0000080808007B797B00C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C00000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000C0C0C00000008400C0C0C000C0C0C000C6C7C60084868400008684000086
      8400008684000086840000868400008684000086840000868400008684000000
      0000848684008486840084868400C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000FFFF00000000000000000000C0C0C000C0C0C0000808080000DF
      DE00180052000000DE000000DE0073007300DE960000DE960000523000009461
      000008080800C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C00000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000C0C0C00000008400C0C0C000C0C0C000C6C7C60084868400008684000086
      8400008684000086840000868400008684000086840000868400008684000086
      840000000000C6C7C600C6C7C600C6C7C6000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C000C0C0
      C000C0C0C000FFFF00000000000000000000C0C0C0000808080000DFDE0000FF
      FF00180052000000DE000000DE0073007300DE960000DE960000523000009461
      000008080800C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C00000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000C0C0C00000008400C0C0C000C0C0C000C6C7C600C6C7C600848684000086
      8400008684000086840000868400008684000086840000868400008684000086
      84000086840000000000C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000FFFF00000000000000000000C0C0C0000808080000FFFF000071
      7300180052000000DE000020730073007300DE960000BD790000523000009461
      000008080800C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C00000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000C0C0C00000008400C0C0C000C0C0C000C6C7C600C6C7C600848684000086
      8400008684000086840000868400008684000086840000868400008684000086
      8400008684000086840000000000C6C7C600C0C0C000C0C0C000000000000000
      000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000C0C0
      C000C0C0C000C0C0C0000000000000000000C0C0C000080808000096940000DF
      DE0018005200002073000000BD0073007300BD79000094610000734900009461
      000008080800C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000000
      840000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      00000000840000008400C0C0C000C0C0C0008486840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000086
      840000868400008684000086840000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000808080000DF
      DE00080808000000BD00003094007300730094610000BD790000BD7900007349
      000008080800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      000000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C000C0C0C000C6C7C60084868400C6C7C600C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000848684008486840084868400C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000808
      080008080800080808000000BD0008080800BD790000DE960000DE960000BD79
      000008080800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000FF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000FF00C0C0C000C0C0C000C6C7C6008486840084868400C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000080808000808080008080800BD790000BD7900000808
      0800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000868400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000868400C0C0C000C0C0C000C6C7C600C6C7C60084868400C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000808080008080800C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7C600C6C7C600C6C7C6008486
      8400848684008486840084868400848684008486840084868400848684008486
      8400848684008486840000000000C6C7C600424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FEFF000000000000F87F000000000000
      F03F000000000000E01F000000000000C00F0000000000008007000000000000
      8003000000000000800100000000000080010000000000008001000000000000
      C001000000000000E001000000000000FC01000000000000FE01000000000000
      FFB1000000000000FFF9000000000000FFFFFFFF9FCF0000FFFFFF9F9FCF0000
      FFFFFF0F87C30000FFFFFE0787C30000FF1CFC0300000000FA00F80100000000
      FEF0F00100000000FC78E00397CB0000F3F8C00797CB00000F78800797CB0000
      F3F0800797CB0000C7DC800787C30000FFFFC007E7F31FE0FFFFE007F7FB1FF0
      FFFFFC0FF7FB1FF8FFFFFF9FFFFF000000000000000000000000000000000000
      000000000000}
  end
end