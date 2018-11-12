object FormZhiJia: TFormZhiJia
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'FormZhiJia'
  ClientHeight = 432
  ClientWidth = 707
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
  Position = poDesigned
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 697
    Height = 432
    Align = alLeft
    BevelOuter = bvLowered
    Caption = 'Panel5'
    TabOrder = 0
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 695
      Height = 395
      Align = alClient
      BevelInner = bvLowered
      TabOrder = 0
      object PageControl1: TPageControl
        Left = 2
        Top = 2
        Width = 691
        Height = 391
        ActivePage = TabSheetFY
        Align = alClient
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object TabSheetDz: TTabSheet
          Caption = #22320#36136#20449#24687
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 403
          ExplicitHeight = 597
          object StringGridDZ: TStringGrid
            Left = 0
            Top = 0
            Width = 683
            Height = 363
            Align = alClient
            Color = clBtnFace
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
            ScrollBars = ssVertical
            TabOrder = 0
            OnKeyPress = StringGridDZKeyPress
            OnSelectCell = StringGridDZSelectCell
            ExplicitWidth = 403
            ExplicitHeight = 597
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
          object StringGridFy: TStringGrid
            Left = 0
            Top = 0
            Width = 683
            Height = 363
            Align = alClient
            Color = clBtnFace
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goAlwaysShowEditor]
            ScrollBars = ssNone
            TabOrder = 0
            OnKeyPress = StringGridFyKeyPress
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
          ExplicitWidth = 403
          ExplicitHeight = 597
          object StringGridZJ: TStringGrid
            Left = 0
            Top = 0
            Width = 683
            Height = 363
            Align = alClient
            Color = clBtnFace
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goAlwaysShowEditor]
            ScrollBars = ssNone
            TabOrder = 0
            OnKeyPress = StringGridZJKeyPress
            OnSelectCell = StringGridZJSelectCell
            ExplicitWidth = 819
            ExplicitHeight = 479
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
        object TabSheet_Canshu: TTabSheet
          Caption = #35745#31639#21442#25968
          ImageIndex = 3
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 403
          ExplicitHeight = 597
          object StringGrid_ZJCS: TStringGrid
            Left = 0
            Top = 0
            Width = 683
            Height = 363
            Align = alClient
            Color = clBtnFace
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goAlwaysShowEditor]
            ScrollBars = ssNone
            TabOrder = 0
            OnKeyPress = StringGrid_ZJCSKeyPress
            ExplicitWidth = 403
            ExplicitHeight = 597
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
      Top = 396
      Width = 695
      Height = 35
      Align = alBottom
      BevelOuter = bvLowered
      TabOrder = 1
      object Button1: TButton
        Left = 17
        Top = 6
        Width = 184
        Height = 25
        Caption = #24212'   '#29992
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 262
        Top = 6
        Width = 187
        Height = 25
        Caption = #37325'   '#32622
        TabOrder = 1
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 504
        Top = 6
        Width = 185
        Height = 25
        Caption = #36864'   '#20986
        TabOrder = 2
        OnClick = Button3Click
      end
    end
  end
end
