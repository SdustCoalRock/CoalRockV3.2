object FormZhiJia: TFormZhiJia
  Left = 0
  Top = 0
  Caption = 'FormZhiJia'
  ClientHeight = 580
  ClientWidth = 1028
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010002002020100000000000E80200002600000010101000000000002801
    00000E0300002800000020000000400000000100040000000000800200000000
    0000000000000000000000000000000000000000800000800000008080008000
    0000800080008080000080808000C0C0C0000000FF0000FF000000FFFF00FF00
    0000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCCC
    CCCCCFFFFFFFFFFFFFFFFFFFFFFFCFFFFFFFFCCCCCCCCCCFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFCCCCCCCCCCCFFFFFFFFFFFFFFFFFFFFFFCCCFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFFCFFCFCFFFFFFFFFFFF
    FFFFFFFFFFCFFCFFFFCFFFFFFFFFFFFFFFFFFFFFFCFFCFFFFCFCFFFFFFFFFFFF
    FFFFFFFFCFFCFFFFCFFFFFFFFFFFFFFFFFFFFFFFCFFCFFFCFFFFFFFFFFFFFFFF
    FFFFFFFFCFFCCFCFFFFFFFFFFFFFFFFFFFFFFFFFCFFCCCFFFFFFFFFFFFFFFFFF
    FFFFFFFFFCCCFCCFFFFFFFFFFFFFFFFFFFFFFFFFCCCFFFCCFFFFFFFFFFFFFFFF
    FFFFFFFFCFFCCFFCFFFFFFFFFFFFFFFFFFFFFFFCFFCFFFFCFFFFFFFFFFFFFFFF
    FFFFFFCCCCCCCFFCFFFFFFFFFFFFFFFFFFFFCCCCFCFCCFCCFFFFFFFFFFFFFFFF
    FFFFFCFFFFCFFFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFCCCFFFFFFFFFFFFFFFEEFFFFFFFFFFFCFCCCFFFFFFFFFFFFEFEEEF
    FFFFFFFFFFFCCCFFFFFFFFFFFEEEEEEEEFFFFFFFFCCCCCFFFFFFFFFFEEEEEEEE
    EEFFFFFFFFCCCFFFFFFFFFFEEEEEEEEEEEEFFFFFFFFFFFFFFFFFFFEEEEEEEEBB
    EEEEFFFFFEEFFFFFFFFFFEEEEEEEEBBBBEEEEFFEEEEEEFFFFFFFEEEEEEEEEBBB
    BEEEEEEEEEEEEEEFFFFEEEEEEEEEEEBBEEEEEEEEEEEEEEEEFFEEEEEEEEEEEEEE
    EEEEEEEEEEEEEEEEEEEEEEEEEEEE000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000280000001000000020000000010004000000
    0000C00000000000000000000000000000000000000000000000000080000080
    00000080800080000000800080008080000080808000C0C0C0000000FF0000FF
    000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00CCCCCFFFFFFFFFFFCFFF
    CCCCCCCCCFFFFFFFFFFFCCFFFFFFFFFFFFFCFCCCFFFFFFFFFFCFCFCCFFFFFFFF
    FFCCCCFFFFFFFFFFFFCFFCFFFFFFFFFFFFCFCCFFFFFFFFFFFCCFFCFFFFFFFFFF
    CCCCCCFFFFFFFFFFFFFCCFFFFFFFEEFFFFFCCFFFFFEEEEEFFFCCCFFFFEEEEBEE
    FFEEFFFFEEEEBBBEEEEEEEFEEEEEEBEEEEEEEEEEEEEE00000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    00000000000000000000000000000000000000000000}
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1028
    Height = 40
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object Label12: TLabel
      Left = 112
      Top = 8
      Width = 48
      Height = 13
      Margins.Bottom = 0
      Caption = #26550#22411#23637#31034
    end
    object ComboZtjx: TComboBox
      Left = 166
      Top = 1
      Width = 435
      Height = 21
      Style = csDropDownList
      DropDownCount = 30
      TabOrder = 0
      OnChange = ComboZtjxChange
    end
    object BitBtn3: TBitBtn
      Left = 684
      Top = 1
      Width = 79
      Height = 33
      Caption = #36864#20986#26174#31034
      Glyph.Data = {
        36060000424D3606000000000000360000002800000020000000100000000100
        18000000000000060000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFF0F5F382A99B3E7A640F5A3E0F5A3E447E6988AD9FEEF3F1FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F2F29595955C5C5C34
        34343434346161619A9A9AF0F0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFBCD1C92B6F562176542A87603091683091682A866021775420674DB9CF
        C7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C6C64D4D4D4B4B4B58585860
        60606060605858584C4C4C434343C4C4C4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        A4C2B72775562D866237956E37956E37956E37956E37956E37956E2E86621964
        48B8CFC6FFFFFFFFFFFFFFFFFFFFFFFFB3B3B34E4E4E59595966666666666666
        66666666666666666666665A5A5A3E3E3EC3C3C3FFFFFFFFFFFFFFFFFFE1EBE7
        216B4E39916C409B75409B7574B79BA2CEBCA2CEBC74B79B3E9A743E9A74348C
        68297054EEF4F2FFFFFFFFFFFFE6E6E64646466565656D6D6D6D6D6D959595B8
        B8B8B8B8B89595956C6C6C6C6C6C6060604C4C4CF1F1F1FFFFFFFFFFFF7FAA99
        6EA68FAFD6C6AFD6C6AFD6C669A28B2E775A2E775A69A28B79BAA0459F7B459F
        7B3C8A6B8CB3A3FFFFFFFFFFFF9494948A8A8AC2C2C2C2C2C2C2C2C285858552
        52525252528585859999997272727272726363639F9F9FFFFFFFFFFFFF3F8368
        267354267354267354267354639A84EAF1EEEAF1EE639A8469A58D4DA5834DA5
        83489D7C4E8D74FFFFFFFFFFFF6161614C4C4C4C4C4C4C4C4C4C4C4C7E7E7EED
        EDEDEDEDED7E7E7E8787877979797979797272726D6D6DFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8F0ED39836556AA8A56AA
        8A59AB8C2F7C5CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFECECEC5E5E5E808080808080828282555555FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFF7FAF979AC96FFFFFFEBF2EF3A86665FB0925FB0
        926FB79C388363FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F892
        9292FFFFFFEEEEEE6060608787878787879393935D5D5DFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFE2EDE85A9A7E489373D4E5DD68A3894F9E7F67B69A67B6
        9A80BDA65C9B80FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7E7E77A7A7A6D
        6D6DDCDCDC8585857676768E8E8E8E8E8E9E9E9E7B7B7BFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC3DBD047917059A6885CA98C4795745CA98C70BBA170BBA181C3
        AC82B9A297C1AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCF6C6C6C7F7F7F82
        82826E6E6E828282959595959595A2A2A29D9D9DACACACFFFFFFFFFFFFFFFFFF
        FCFDFD9CC6B354A18168B39878C1A978C1A978C1A978C1A978C1A986C8B293C9
        B5459370E8F2EDFFFFFFFFFFFFFFFFFFFCFCFCB1B1B17A7A7A8D8D8D9C9C9C9C
        9C9C9C9C9C9C9C9C9C9C9CA7A7A7AEAEAE6C6C6CEDEDEDFFFFFFFFFFFFFCFDFD
        7EB69D7DB89FA1D3C385C8B37FC6B07FC6B07FC6B085C9B4A0D5C4B1D8CA78B5
        9CB7D6C8FFFFFFFFFFFFFFFFFFFCFCFC9A9A9A9A9A9ABABABAA6A6A6A2A2A2A2
        A2A2A2A2A2A7A7A7BABABAC4C4C4969696C6C6C6FFFFFFFFFFFFFFFFFFFFFFFF
        E3EFEA6AAC8E83BDA4C2E3D99ED5C5ACDCCDC9E8DFC2E3D992C6B14F9D79B4D5
        C6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E98B8B8BA0A0A0D2D2D2B9B9B9C4
        C4C4D8D8D8D2D2D2ACACAC767676C4C4C4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFAFCFBA3CDBA51A17BA3D1BF87C1A853A37E5BA68393C4ADE6F1ECFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBB8B8B8797979BABABAA4
        A4A47B7B7B808080ABABABEBEBEBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFD4E8DF69AF8E57A782F8FBFAFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDEDEDE8C8C8C7F
        7F7FF9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFF7FAF995C8B0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8AE
        AEAEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = BitBtn3Click
    end
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = -1
    Width = 89
    Height = 35
    Caption = #22270#29255#21478#23384#20026
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      8888880000000000000880330000008803088033000000880308803300000088
      0308803300000000030880333333333333088033000000003308803088888888
      0308803088888888030880308888888803088030888888880308803088888888
      0008803088888888080880000000000000088888888888888888}
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 599
    Top = 1
    Width = 79
    Height = 33
    Caption = #20462#25913#21442#25968
    NumGlyphs = 2
    TabOrder = 2
    OnClick = BitBtn2Click
  end
  object Panel4: TPanel
    Left = 0
    Top = 554
    Width = 1028
    Height = 26
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 3
  end
  object Panel5: TPanel
    Left = 0
    Top = 40
    Width = 326
    Height = 514
    Align = alLeft
    BevelOuter = bvLowered
    Caption = 'Panel5'
    TabOrder = 4
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 324
      Height = 477
      Align = alClient
      BevelInner = bvLowered
      TabOrder = 0
      object PageControl1: TPageControl
        Left = 2
        Top = 2
        Width = 320
        Height = 473
        ActivePage = TabSheetFY
        Align = alClient
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object TabSheetDz: TTabSheet
          Caption = #22320#36136#20449#24687
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object StringGridDZ: TStringGrid
            Left = 0
            Top = 0
            Width = 312
            Height = 445
            Align = alClient
            Color = clBtnFace
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
            ScrollBars = ssNone
            TabOrder = 0
            OnSelectCell = StringGridDZSelectCell
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
        end
        object TabSheetFY: TTabSheet
          Caption = #35206#23721#36816#21160
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object StringGridFy: TStringGrid
            Left = 0
            Top = 0
            Width = 312
            Height = 445
            Align = alClient
            Color = clBtnFace
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goAlwaysShowEditor]
            ScrollBars = ssNone
            TabOrder = 0
            OnSelectCell = StringGridFySelectCell
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
        end
        object TabSheetZj: TTabSheet
          Caption = #25903#26550#20449#24687
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object StringGridZJ: TStringGrid
            Left = 0
            Top = 0
            Width = 312
            Height = 445
            Align = alClient
            Color = clBtnFace
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goAlwaysShowEditor]
            ScrollBars = ssNone
            TabOrder = 0
            OnSelectCell = StringGridZJSelectCell
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
        end
      end
    end
    object Panel6: TPanel
      Left = 1
      Top = 478
      Width = 324
      Height = 35
      Align = alBottom
      BevelOuter = bvLowered
      TabOrder = 1
      object Button1: TButton
        Left = 17
        Top = 5
        Width = 87
        Height = 25
        Caption = #24212'   '#29992
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 110
        Top = 4
        Width = 91
        Height = 25
        Caption = #37325'   '#32622
        TabOrder = 1
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 207
        Top = 4
        Width = 91
        Height = 25
        Caption = #36864'   '#20986
        TabOrder = 2
        OnClick = Button3Click
      end
    end
  end
  object PageControl2: TPageControl
    Left = 326
    Top = 40
    Width = 555
    Height = 514
    ActivePage = TabSheet1
    Align = alClient
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    TabPosition = tpBottom
    OnChange = PageControl2Change
    object TabSheet1: TTabSheet
      Caption = #23616#37096#32467#26500
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Image1: TImage
        Left = 0
        Top = 0
        Width = 547
        Height = 488
        Align = alClient
        ExplicitLeft = 80
        ExplicitTop = 64
        ExplicitWidth = 161
        ExplicitHeight = 289
      end
      object PanelZoom: TPanel
        Left = 0
        Top = 0
        Width = 547
        Height = 488
        Align = alClient
        Caption = 'PanelZoom'
        TabOrder = 0
        Visible = False
        object ImageZoom: TImage
          Left = 1
          Top = 1
          Width = 545
          Height = 486
          Align = alClient
          Proportional = True
          OnDblClick = ImageZoomDblClick
          ExplicitLeft = 3
          ExplicitTop = 0
          ExplicitWidth = 456
          ExplicitHeight = 343
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #25972#20307#32467#26500
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object ImageZT: TImage
        Left = 0
        Top = 37
        Width = 547
        Height = 451
        Align = alClient
        Proportional = True
        ExplicitLeft = 2
        ExplicitTop = 43
        ExplicitWidth = 464
        ExplicitHeight = 454
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 547
        Height = 37
        Align = alTop
        BevelOuter = bvLowered
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  object Panel7: TPanel
    Left = 881
    Top = 40
    Width = 147
    Height = 514
    Align = alRight
    TabOrder = 6
    object Label2: TLabel
      Left = 5
      Top = 47
      Width = 48
      Height = 13
      Margins.Bottom = 0
      Caption = #39030#26753#32467#26500
    end
    object Label3: TLabel
      Left = 5
      Top = 90
      Width = 48
      Height = 13
      Margins.Bottom = 0
      Caption = #24213#24231#32467#26500
    end
    object Label4: TLabel
      Left = 5
      Top = 130
      Width = 60
      Height = 13
      Margins.Bottom = 0
      Caption = #22235#36830#26438#32467#26500
    end
    object Label5: TLabel
      Left = 5
      Top = 170
      Width = 48
      Height = 13
      Margins.Bottom = 0
      Caption = #25512#31227#32467#26500
    end
    object Label6: TLabel
      Left = 5
      Top = 210
      Width = 48
      Height = 13
      Margins.Bottom = 0
      Caption = #25918#29028#32467#26500
    end
    object Label7: TLabel
      Left = 5
      Top = 250
      Width = 60
      Height = 13
      Margins.Bottom = 0
      Caption = #23614#26753#21315#26020#39030
    end
    object Label8: TLabel
      Left = 5
      Top = 290
      Width = 96
      Height = 13
      Margins.Bottom = 0
      Caption = #21069#26753#12289#23614#26753#20391#25252#26495
    end
    object Label9: TLabel
      Left = 5
      Top = 330
      Width = 48
      Height = 13
      Margins.Bottom = 0
      Caption = #20391#25512#32467#26500
    end
    object Label10: TLabel
      Left = 5
      Top = 378
      Width = 48
      Height = 13
      Margins.Bottom = 0
      Caption = #24213#35843#32467#26500
    end
    object Label11: TLabel
      Left = 5
      Top = 422
      Width = 48
      Height = 13
      Margins.Bottom = 0
      Caption = #21069#26753#32467#26500
    end
    object Label1: TLabel
      Left = 5
      Top = 6
      Width = 48
      Height = 13
      Margins.Bottom = 0
      Caption = #26550#22411#32467#26500
    end
    object Combojx: TComboBox
      Left = 13
      Top = 22
      Width = 121
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = CombojxChange
      Items.Strings = (
        #22235#26609#27491#22235#36830#26438
        #20004#26609#27491#22235#36830#26438
        #21333#32478#28857
        #21333#25670#26438)
    end
    object ComboDl: TComboBox
      Left = 13
      Top = 63
      Width = 121
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      OnChange = ComboDlChange
      Items.Strings = (
        #38128#25509#39030#26753
        #25972#20307#20280#32553#39030#26753
        #25972#20307#25252#24110
        #25972#20307#20280#32553#25252#24110)
    end
    object ComboDz: TComboBox
      Left = 13
      Top = 103
      Width = 121
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      OnChange = ComboDzChange
      Items.Strings = (
        #20840#23553#24213
        #21322#23553#24213#65291#26080#25260#24213
        #21322#23553#24213#65291#25260#24213
        #24320#26723#65291#25260#24213
        #24320#26723#65291#26080#25260#24213)
    end
    object ComboSlg: TComboBox
      Left = 13
      Top = 143
      Width = 121
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      OnChange = ComboSlgChange
      Items.Strings = (
        #21069#21452#21518#21452
        #21069#21333#21518#21452
        #21069#21452#21518#21333)
    end
    object ComboTy: TComboBox
      Left = 13
      Top = 183
      Width = 121
      Height = 21
      Style = csDropDownList
      TabOrder = 4
      OnChange = ComboTyChange
      Items.Strings = (
        #20498#35013#65291#38271#25512#26438
        #20498#25512#65291#38128#25509#25512#26438
        #27491#35013#65291#30701#25512#26438)
    end
    object ComboFm: TComboBox
      Left = 13
      Top = 223
      Width = 121
      Height = 21
      Style = csDropDownList
      TabOrder = 5
      OnChange = ComboFmChange
      Items.Strings = (
        #19977#31665#22411#26080#27963#20391#26495
        #19977#31665#22411#65291#27963#20391#26495
        #20116#31665#22411#26080#27963#20391#26495
        #20116#31665#22411#65291#27963#20391#26495
        #20845#31665#22411)
    end
    object ComboWLqjD: TComboBox
      Left = 13
      Top = 263
      Width = 121
      Height = 21
      Style = csDropDownList
      TabOrder = 6
      OnChange = ComboWLqjDChange
      Items.Strings = (
        #27491#35013
        #20498#35013)
    end
    object ComboChb: TComboBox
      Left = 13
      Top = 303
      Width = 121
      Height = 21
      Style = csDropDownList
      TabOrder = 7
      OnChange = ComboChbChange
      Items.Strings = (
        #21069#26753#12289#23614#26753#26080#20391#25252#26495
        #21069#26753#12289#23614#26753#26377#20391#25252#26495)
    end
    object ComboCt: TComboBox
      Left = 13
      Top = 346
      Width = 121
      Height = 21
      Style = csDropDownList
      TabOrder = 8
      OnChange = ComboCtChange
      Items.Strings = (
        #20391#25512#21315#26020#39030#65291#24377#31783
        #20391#25512#21315#26020#39030#65291#26080#24377#31783
        #21452#20391#25512#21315#26020#39030)
    end
    object ComboDt: TComboBox
      Left = 13
      Top = 394
      Width = 121
      Height = 21
      Style = csDropDownList
      TabOrder = 9
      OnChange = ComboDtChange
      Items.Strings = (
        #21333#21315#26020#39030
        #24213#35843#26753#65291#24213#35843#21315#26020#39030
        #24213#35843#26753#65291#24213#35843#21315#26020#39030#65291#23548#26438)
    end
    object ComboQl: TComboBox
      Left = 13
      Top = 435
      Width = 121
      Height = 21
      Style = csDropDownList
      TabOrder = 10
      OnChange = ComboQlChange
      Items.Strings = (
        #20280#32553#65291#25252#24110
        #26377#25252#24110#26080#20280#32553#26753)
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'JPG'
    Filter = '*.JPG'
    Left = 552
  end
end
