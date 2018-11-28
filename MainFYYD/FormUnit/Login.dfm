object loginForm: TloginForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #31995#32479#30331#24405
  ClientHeight = 359
  ClientWidth = 623
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 623
    Height = 359
    Margins.Left = 0
    Align = alClient
    Color = clGradientActiveCaption
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 195
      Top = 78
      Width = 48
      Height = 13
      Margins.Bottom = 0
      Caption = #29992#25143#31867#21035
    end
    object Label2: TLabel
      Left = 195
      Top = 163
      Width = 27
      Height = 13
      Margins.Bottom = 0
      Caption = #23494' '#30721
    end
    object Lab_UsedDataType: TLabel
      Left = 208
      Top = 16
      Width = 8
      Height = 16
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #20223#23435
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 195
      Top = 118
      Width = 48
      Height = 13
      Margins.Bottom = 0
      Caption = #29992#25143#21517#31216
    end
    object Label_Version: TLabel
      Left = 248
      Top = 281
      Width = 151
      Height = 24
      Caption = #29256#26412#32534#21495#65306'V3.2'
      Color = clGradientActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Edit_Password: TEdit
      Left = 264
      Top = 160
      Width = 284
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      PasswordChar = '*'
      TabOrder = 2
      Text = '123'
      OnClick = Edit_PasswordClick
      OnKeyPress = Edit_PasswordKeyPress
    end
    object Button1: TButton
      Left = 264
      Top = 222
      Width = 162
      Height = 25
      Caption = #30331#24405
      TabOrder = 3
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 432
      Top = 222
      Width = 116
      Height = 25
      Caption = #36864#20986
      TabOrder = 6
      OnClick = Button2Click
    end
    object ComboUserType: TComboBox
      Left = 264
      Top = 75
      Width = 284
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = #31649#29702#21592
      OnChange = ComboUserTypeChange
      OnClick = ComboUserTypeClick
      Items.Strings = (
        #31649#29702#21592
        #19968#33324#29992#25143)
    end
    object Button3: TButton
      Left = 432
      Top = 285
      Width = 121
      Height = 26
      Caption = #27880#20876#26032#29992#25143
      TabOrder = 5
      OnClick = Button3Click
    end
    object ComboUserName: TComboBox
      Left = 264
      Top = 115
      Width = 284
      Height = 21
      Style = csDropDownList
      DropDownCount = 20
      TabOrder = 1
      OnChange = ComboUserNameChange
    end
    object BitBtn1: TBitBtn
      Left = 26
      Top = 285
      Width = 127
      Height = 25
      Caption = #36828#31243#25968#25454#24211#37197#32622'...'
      TabOrder = 4
      OnClick = BitBtn1Click
    end
    object Monotor_RG: TRadioGroup
      Left = 26
      Top = 54
      Width = 150
      Height = 124
      Caption = #30417#25511#30028#38754#26174#31034#36873#25321
      Items.Strings = (
        #19981#26174#31034#20219#20309#30417#25511#30028#38754
        #39318#26174#31034#20840#22269#30417#25511#30028#38754
        #39318#26174#31034#29028#30719#30417#25511#30028#38754)
      TabOrder = 7
      OnClick = Monotor_RGClick
    end
    object RockPress_RG: TRadioGroup
      Left = 26
      Top = 184
      Width = 150
      Height = 81
      Caption = #29028#30719#30719#21387#30417#25511#23548#33322#36873#25321
      ItemIndex = 1
      Items.Strings = (
        #30719#21387#20998#26512#22810#39029#38754#23548#33322
        #30719#21387#20998#26512#27969#31243#22270#23548#33322)
      TabOrder = 8
      OnClick = Monotor_RGClick
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer1Timer
    Left = 344
    Top = 16
  end
end
