object DrawBmp_From: TDrawBmp_From
  Left = 0
  Top = 0
  Caption = 'Draw_Pressure'
  ClientHeight = 671
  ClientWidth = 1295
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 652
    Width = 1295
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end>
  end
  object Main_PageControl: TPageControl
    Left = 0
    Top = 43
    Width = 1256
    Height = 609
    ActivePage = TabSheet9
    Align = alClient
    OwnerDraw = True
    TabOrder = 1
    TabPosition = tpBottom
    OnDrawTab = Main_PageControlDrawTab
    object TabSheet8: TTabSheet
      Caption = #30719#21387#23454#26102#25968#25454#25163#21160#32500#25252
      object PageControl4: TPageControl
        Left = 0
        Top = 0
        Width = 1248
        Height = 583
        ActivePage = TabSheet10
        Align = alClient
        MultiLine = True
        OwnerDraw = True
        TabOrder = 0
        OnDrawTab = PageControl4DrawTab
        object TabSheet10: TTabSheet
          Caption = #24037#20316#38754#36827#23610#25968#25454#32500#25252
          object FootageGrid: TStringGrid
            Left = 291
            Top = 26
            Width = 414
            Height = 321
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
            TabOrder = 0
            OnDrawCell = FootageGridDrawCell
            OnMouseDown = FootageGridMouseDown
            OnSelectCell = FootageGridSelectCell
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
          object FootageToolPanel: TPanel
            Left = 0
            Top = 0
            Width = 225
            Height = 555
            Align = alLeft
            TabOrder = 1
            object GroupBox7: TGroupBox
              Left = 0
              Top = 0
              Width = 217
              Height = 546
              Caption = #30719#21387#25968#25454#24405#20837#22522#26412#20449#24687
              TabOrder = 0
              object Label9: TLabel
                Left = 5
                Top = 27
                Width = 84
                Height = 13
                Caption = #27599#22825#25512#36827#30340#20992#25968
              end
              object Label10: TLabel
                Left = 5
                Top = 54
                Width = 72
                Height = 13
                Caption = #20004#20992#38388#38548#26102#38388
              end
              object Label11: TLabel
                Left = 175
                Top = 54
                Width = 24
                Height = 13
                Caption = #20998#38047
              end
              object Label12: TLabel
                Left = 187
                Top = 27
                Width = 12
                Height = 13
                Caption = #20992
              end
              object Label13: TLabel
                Left = 5
                Top = 86
                Width = 60
                Height = 13
                Caption = #27599#20992#36827#23610#25968
              end
              object Label14: TLabel
                Left = 187
                Top = 81
                Width = 12
                Height = 13
                Caption = #31859
              end
              object Label15: TLabel
                Left = 5
                Top = 118
                Width = 108
                Height = 13
                Caption = #24037#20316#38754#28082#21387#25903#26550#25968#37327
              end
              object Label16: TLabel
                Left = 187
                Top = 145
                Width = 12
                Height = 13
                Caption = #26550
              end
              object Label17: TLabel
                Left = 5
                Top = 164
                Width = 144
                Height = 13
                Caption = #25163#21160#24405#20837#21387#21147#25968#25454#25903#26550#38388#38548
              end
              object Label18: TLabel
                Left = 187
                Top = 186
                Width = 12
                Height = 13
                Caption = #26550
              end
              object Label30: TLabel
                Left = 3
                Top = 284
                Width = 156
                Height = 13
                Caption = #33258#21160#21028#23450#36827#20992#25968#20381#25454#25903#26550#32534#21495
              end
              object Label39: TLabel
                Left = 187
                Top = 306
                Width = 12
                Height = 13
                Caption = #26550
              end
              object ComboFootSteps: TComboBox
                Left = 95
                Top = 24
                Width = 66
                Height = 21
                ItemIndex = 9
                TabOrder = 0
                Text = '10'
                Items.Strings = (
                  '1'
                  '2'
                  '3'
                  '4'
                  '5'
                  '6'
                  '7'
                  '8'
                  '9'
                  '10'
                  '11'
                  '12'
                  '13'
                  '14'
                  '15'
                  '16'
                  '17'
                  '18'
                  '19'
                  '20')
              end
              object ComboBoxStepTime: TComboBox
                Left = 96
                Top = 51
                Width = 65
                Height = 21
                ItemIndex = 3
                TabOrder = 1
                Text = '90'
                Items.Strings = (
                  '30'
                  '45'
                  '60'
                  '90'
                  '120'
                  '180'
                  '240'
                  '300'
                  '360'
                  '420'
                  ''
                  '')
              end
              object Footsteps_L: TEdit
                Left = 95
                Top = 78
                Width = 66
                Height = 21
                TabOrder = 2
                Text = '0.865'
                OnClick = Footsteps_LClick
                OnKeyPress = Footsteps_LKeyPress
              end
              object Button6: TButton
                Left = 72
                Top = 431
                Width = 142
                Height = 25
                Caption = #20445#23384#20026#35813#24037#20316#38754#40664#35748#20540
                TabOrder = 3
                OnClick = Button6Click
              end
              object Button7: TButton
                Left = 72
                Top = 462
                Width = 142
                Height = 25
                Caption = #24674#22797#21040#20462#25913#20043#21069#30340#20540
                TabOrder = 4
                OnClick = Button7Click
              end
              object Edit_SupportNumber: TEdit
                Left = 95
                Top = 137
                Width = 66
                Height = 21
                TabOrder = 5
                Text = '200'
                OnClick = Edit_SupportNumberClick
                OnKeyPress = Edit_SupportNumberKeyPress
              end
              object Edit_interVal_support: TEdit
                Left = 96
                Top = 183
                Width = 65
                Height = 21
                TabOrder = 6
                Text = '5'
                OnChange = Edit_interVal_supportChange
                OnKeyPress = Edit_interVal_supportKeyPress
              end
              object RG_JD_Basic: TRadioGroup
                Left = 0
                Top = 210
                Width = 196
                Height = 63
                Caption = #33258#21160#20998#26512#25968#25454#36827#20992#21028#23450#20381#25454
                Columns = 3
                ItemIndex = 1
                Items.Strings = (
                  #26426#22836
                  #20013#38388
                  #26426#23614)
                TabOrder = 7
                OnClick = RG_JD_BasicClick
              end
              object Edit_JD_support: TEdit
                Left = 96
                Top = 303
                Width = 65
                Height = 21
                TabOrder = 8
                Text = '5'
                OnChange = Edit_interVal_supportChange
                OnClick = Edit_JD_supportClick
                OnKeyPress = Edit_interVal_supportKeyPress
              end
              object RG_JD_Time: TRadioGroup
                Left = 3
                Top = 330
                Width = 214
                Height = 95
                Caption = #26412#27425#36827#20992#30636#38388#20540#25235#21462#26102#21051
                ItemIndex = 0
                Items.Strings = (
                  #31227#26550#21069#26411#38459#21147#26102#21051
                  #31227#26550#21518#21021#25745#21147#26102#21051
                  #26412#27425#24490#29615#26368#22823#20540#26102#21051)
                TabOrder = 9
              end
            end
          end
        end
        object TabSheet11: TTabSheet
          Caption = #24037#20316#38754#30719#21387#21387#21147#25968#25454#32500#25252
          ImageIndex = 1
          object RockDataGrid: TStringGrid
            Left = 171
            Top = 88
            Width = 689
            Height = 321
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
            ScrollBars = ssHorizontal
            TabOrder = 0
            OnDrawCell = RockDataGridDrawCell
            OnMouseDown = RockDataGridMouseDown
            OnSelectCell = RockDataGridSelectCell
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
          object RockDataRightGrid: TStringGrid
            Left = 520
            Top = 88
            Width = 324
            Height = 321
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
            ScrollBars = ssHorizontal
            TabOrder = 1
            OnDrawCell = RockDataRightGridDrawCell
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
          object ScrollBar1: TScrollBar
            Left = 1219
            Top = 49
            Width = 21
            Height = 506
            Align = alRight
            Kind = sbVertical
            PageSize = 0
            TabOrder = 2
            OnChange = ScrollBar1Change
          end
          object RG_Rock_DataType: TRadioGroup
            Left = 0
            Top = 0
            Width = 1240
            Height = 49
            Align = alTop
            Caption = #35831#36873#25321#21152#36733#25968#25454#31867#22411' '
            Columns = 5
            ItemIndex = 3
            Items.Strings = (
              #27599#27425#36827#20992#26368#22823#20540
              #27599#27425#36827#20992#24179#22343#20540
              #27599#27425#36827#20992#26411#38459#21147
              #27599#27425#36827#20992#30636#38388#25235#21462#25968#20540
              #25163#21160#24405#20837#25968#25454)
            TabOrder = 3
            OnClick = RG_Rock_DataTypeClick
          end
          object RockDataGrid_Edit: TStringGrid
            Left = 880
            Top = 88
            Width = 245
            Height = 120
            TabOrder = 4
            Visible = False
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
    object TabSheet9: TTabSheet
      Caption = #30719#23665#21387#21147#32508#21512#25968#25454#20998#26512
      ImageIndex = 1
      object ChartPageControl: TPageControl
        Left = 265
        Top = 0
        Width = 681
        Height = 583
        ActivePage = TabSheet3
        Align = alClient
        OwnerDraw = True
        TabOrder = 0
        TabPosition = tpBottom
        OnDrawTab = ChartPageControlDrawTab
        object TabSheet3: TTabSheet
          Caption = #20108#32500#21387#21147#20113#22270
          object ContourChart: TChart
            Left = 0
            Top = 0
            Width = 673
            Height = 557
            AllowPanning = pmHorizontal
            BackWall.Brush.Gradient.Direction = gdBottomTop
            BackWall.Brush.Gradient.EndColor = clWhite
            BackWall.Brush.Gradient.StartColor = 15395562
            BackWall.Brush.Gradient.Visible = True
            BackWall.Transparent = False
            Foot.Font.Color = clBlue
            Foot.Font.Name = 'Verdana'
            Gradient.Direction = gdBottomTop
            Gradient.EndColor = clWhite
            Gradient.MidColor = 15395562
            Gradient.StartColor = 15395562
            Gradient.Visible = True
            LeftWall.Color = 14745599
            Legend.Alignment = laTop
            Legend.CheckBoxesStyle = cbsRadio
            Legend.DividingLines.Color = clDefault
            Legend.Font.Name = 'Verdana'
            Legend.Inverted = True
            Legend.LegendStyle = lsValues
            Legend.Shadow.Transparency = 0
            Legend.Symbol.Continuous = True
            Legend.TextStyle = ltsValue
            Legend.TextSymbolGap = 0
            MarginBottom = 10
            MarginLeft = 20
            MarginRight = 20
            MarginTop = 10
            MarginUnits = muPixels
            RightWall.Color = 14745599
            ScrollMouseButton = mbLeft
            Title.Font.Name = 'Verdana'
            Title.Text.Strings = (
              'TChart')
            BottomAxis.Axis.Color = 4210752
            BottomAxis.Grid.Color = 11119017
            BottomAxis.LabelsFormat.Font.Name = 'Verdana'
            BottomAxis.SubAxes = <
              item
                Automatic = False
                AutomaticMaximum = False
                AutomaticMinimum = False
                ExactDateTime = False
                Grid.Visible = False
                Horizontal = True
                OtherSide = False
                Maximum = 5.000000000000000000
                Minimum = 1.000000000000000000
              end>
            BottomAxis.TicksInner.Color = 11119017
            BottomAxis.Title.Font.Name = 'Verdana'
            DepthAxis.Axis.Color = 4210752
            DepthAxis.Grid.Color = 11119017
            DepthAxis.LabelsFormat.Font.Name = 'Verdana'
            DepthAxis.TicksInner.Color = 11119017
            DepthAxis.Title.Font.Name = 'Verdana'
            DepthTopAxis.Axis.Color = 4210752
            DepthTopAxis.Grid.Color = 11119017
            DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
            DepthTopAxis.TicksInner.Color = 11119017
            DepthTopAxis.Title.Font.Name = 'Verdana'
            LeftAxis.Axis.Color = 4210752
            LeftAxis.Grid.Color = 11119017
            LeftAxis.Grid.DrawAlways = True
            LeftAxis.LabelsFormat.Font.Name = 'Verdana'
            LeftAxis.TicksInner.Color = 11119017
            LeftAxis.Title.Font.Name = 'Verdana'
            Panning.InsideBounds = True
            Panning.MouseWheel = pmwNone
            RightAxis.Axis.Color = 4210752
            RightAxis.Grid.Color = 11119017
            RightAxis.LabelsFormat.Font.Name = 'Verdana'
            RightAxis.TicksInner.Color = 11119017
            RightAxis.Title.Font.Name = 'Verdana'
            TopAxis.Automatic = False
            TopAxis.AutomaticMaximum = False
            TopAxis.AutomaticMinimum = False
            TopAxis.Axis.Color = 4210752
            TopAxis.ExactDateTime = False
            TopAxis.Grid.Color = 11119017
            TopAxis.LabelsFormat.Font.Name = 'Verdana'
            TopAxis.Maximum = 5.000000000000000000
            TopAxis.MaximumRound = True
            TopAxis.Minimum = 1.000000000000000000
            TopAxis.TicksInner.Color = 11119017
            TopAxis.Title.Font.Name = 'Verdana'
            View3D = False
            Zoom.MouseButton = mbMiddle
            ZoomWheel = pmwNormal
            OnGetAxisLabel = ContourChartGetAxisLabel
            Align = alClient
            BevelInner = bvLowered
            BevelOuter = bvLowered
            TabOrder = 0
            OnMouseDown = ContourChartMouseDown
            OnMouseMove = ContourChartMouseMove
            DefaultCanvas = 'TGDIPlusCanvas'
            ColorPaletteIndex = 13
            object ContourSeries: TContourSeries
              CellPen.Color = -1560281088
              CellPen.Width = 0
              Filled = True
              Marks.Transparent = True
              EndColor = clRed
              IrregularGrid = True
              MidColor = clLime
              NumXValues = 5
              NumZValues = 5
              PaletteStyle = psCustom
              Pen.Width = 0
              Pointer.HorizSize = 2
              Pointer.InflateMargins = True
              Pointer.Pen.Visible = False
              Pointer.Style = psRectangle
              Pointer.VertSize = 2
              Pointer.Visible = False
              Smoothing.Interpolate = True
              StartColor = clWhite
              Transparency = 2
              UsePalette = True
              XValues.Name = 'X'
              XValues.Order = loNone
              YPosition = 0.259433832982765700
              YValues.Name = 'Y'
              YValues.Order = loNone
              ZValues.Name = 'Z'
              ZValues.Order = loNone
              CustomPalette = {
                20000000419AF39F49D8E2BF7F7FFE000BAB25A3ED17E1BF858BFD00A977AF4C
                23AFDEBF8B97FB003D9913536B2EDBBF91A3F800D0BA7759B3ADD7BF97AFF400
                64DCDB5FFB2CD4BF9DBAEF00F8FD3F6643ACD0BFA3C5E800173F48D91657CABF
                A9CFE1003E8210E6A655C3BFAFD8D800CA8AB1E56DA8B8BFB5E1CF00322284FE
                1B4BA5BFBAE8C500C4446B398FEA8A3FC0EFBA004AE29CCD3160B13FC5F4AF00
                FC5B0CB41163BF3FCAF8A300D6EA3DCDF8B2C63FCFFB9700AFA775C068B4CD3F
                D4FD8B0044B2D659EC5AD23FD8FE7F00B0907253A4DBD53FDDFD72001D6F0E4D
                5C5CD93FE1FB6600894DAA4614DDDC3FE5F85A00FB152320E62EE03FE8F44E00
                3105F11C42EFE13FEBEF430067F4BE199EAFE33FEFE838009DE38C16FA6FE53F
                F1E12E00D4D25A135630E73FF4D825000AC22810B2F0E83FF6CF1C0040B1F60C
                0EB1EA3FF8C5150076A0C4096A71EC3FFABA0E00AC8F9206C631EE3FFBAF0900
                E27E600322F2EF3FFCA305000C3717003FD9F03FFD970200A72E7EFE6CB9F13F
                FD8B0000}
            end
            object LineSeries: TLineSeries
              Cursor = crHandPoint
              Marks.Callout.Length = 0
              Brush.BackColor = clDefault
              ClickableLine = False
              Pointer.HorizSize = 5
              Pointer.InflateMargins = True
              Pointer.Style = psDonut
              Pointer.VertSize = 5
              Pointer.Visible = True
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
            object ContourChart_Cursor: TCursorTool
              ClickTolerance = 1
              FollowMouse = True
              XValue = 2.997105643994211000
              YValue = 3.000000000000000000
              object TAnnotationTool
                Shape.Alignment = taCenter
                Shape.CustomPosition = True
                Shape.Left = 335
                Shape.Shadow.Visible = False
                Shape.Text = '2.997'
                Shape.TextAlignment = taCenter
                Shape.Top = 504
                TextAlignment = taCenter
              end
            end
            object DragPoint: TDragPointTool
              Series = LineSeries
              OnEndDrag = DragPointEndDrag
              OnStartDrag = DragPointStartDrag
            end
            object DragMark: TDragMarksTool
            end
          end
        end
        object TabSheet4: TTabSheet
          Caption = #19977#32500#21387#21147#20113#22270
          ImageIndex = 1
          object ThreeDimContourChart: TChart
            Left = 0
            Top = 0
            Width = 673
            Height = 557
            BackWall.Brush.Gradient.Direction = gdBottomTop
            BackWall.Brush.Gradient.EndColor = clWhite
            BackWall.Brush.Gradient.StartColor = 15395562
            BackWall.Brush.Gradient.Visible = True
            BackWall.Transparent = False
            Foot.Font.Color = clBlue
            Foot.Font.Name = 'Verdana'
            Gradient.Direction = gdBottomTop
            Gradient.EndColor = clWhite
            Gradient.MidColor = 15395562
            Gradient.StartColor = 15395562
            Gradient.Visible = True
            LeftWall.Color = 14745599
            Legend.Font.Name = 'Verdana'
            Legend.Shadow.Transparency = 0
            RightWall.Color = 14745599
            Title.Font.Name = 'Verdana'
            Title.Text.Strings = (
              'TChart')
            BottomAxis.Axis.Color = 4210752
            BottomAxis.Grid.Color = 11119017
            BottomAxis.LabelsFormat.Font.Name = 'Verdana'
            BottomAxis.SubAxes = <
              item
                Grid.Visible = False
                Horizontal = True
                OtherSide = False
              end>
            BottomAxis.TicksInner.Color = 11119017
            BottomAxis.Title.Font.Name = 'Verdana'
            DepthAxis.Axis.Color = 4210752
            DepthAxis.Grid.Color = 11119017
            DepthAxis.LabelsFormat.Font.Name = 'Verdana'
            DepthAxis.TicksInner.Color = 11119017
            DepthAxis.Title.Font.Name = 'Verdana'
            DepthTopAxis.Axis.Color = 4210752
            DepthTopAxis.Grid.Color = 11119017
            DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
            DepthTopAxis.TicksInner.Color = 11119017
            DepthTopAxis.Title.Font.Name = 'Verdana'
            LeftAxis.Axis.Color = 4210752
            LeftAxis.Grid.Color = 11119017
            LeftAxis.LabelsFormat.Font.Name = 'Verdana'
            LeftAxis.TicksInner.Color = 11119017
            LeftAxis.Title.Font.Name = 'Verdana'
            RightAxis.Axis.Color = 4210752
            RightAxis.Grid.Color = 11119017
            RightAxis.LabelsFormat.Font.Name = 'Verdana'
            RightAxis.TicksInner.Color = 11119017
            RightAxis.Title.Font.Name = 'Verdana'
            TopAxis.Axis.Color = 4210752
            TopAxis.Grid.Color = 11119017
            TopAxis.LabelsFormat.Font.Name = 'Verdana'
            TopAxis.TicksInner.Color = 11119017
            TopAxis.Title.Font.Name = 'Verdana'
            Align = alClient
            TabOrder = 0
            DefaultCanvas = 'TGDIPlusCanvas'
            ColorPaletteIndex = 0
          end
        end
        object TabSheet5: TTabSheet
          Caption = #21387#21147#26354#32447#21464#21270#22270
          ImageIndex = 2
          object DrawGraph: TImage
            Left = 0
            Top = 0
            Width = 673
            Height = 557
            Align = alClient
            Stretch = True
            ExplicitLeft = 144
            ExplicitTop = 135
            ExplicitWidth = 105
            ExplicitHeight = 105
          end
        end
        object TabSheet14: TTabSheet
          Caption = #30719#21387#20998#26512#32467#26524#23637#31034
          ImageIndex = 3
          object PageControl_Result: TPageControl
            Left = 0
            Top = 0
            Width = 673
            Height = 557
            ActivePage = TabSheet20
            Align = alClient
            MultiLine = True
            OwnerDraw = True
            TabOrder = 0
            OnDrawTab = PageControl_ResultDrawTab
            object TabSheet20: TTabSheet
              Caption = #26469#21387#27493#36317#23637#31034
              OnResize = TabSheet20Resize
              object Splitter2: TSplitter
                Left = 0
                Top = 363
                Width = 665
                Height = 3
                Cursor = crVSplit
                Align = alTop
                ExplicitWidth = 186
              end
              object GB_Result_Memo: TGroupBox
                Left = 0
                Top = 0
                Width = 665
                Height = 363
                Align = alTop
                Caption = #26469#21387#27493#36317#28165#21333
                TabOrder = 0
                object Memo_Result: TMemo
                  Left = 2
                  Top = 15
                  Width = 661
                  Height = 346
                  Align = alClient
                  Lines.Strings = (
                    'Memo_Result')
                  ScrollBars = ssBoth
                  TabOrder = 0
                  OnClick = Memo_ResultClick
                  OnMouseDown = Memo_ResultMouseDown
                end
              end
              object GroupBox13: TGroupBox
                Left = 0
                Top = 366
                Width = 665
                Height = 163
                Align = alClient
                Caption = #26469#21387#27493#36317#34920#26684#23637#31034
                TabOrder = 1
                object StringGrid_Result: TStringGrid
                  Left = 2
                  Top = 15
                  Width = 661
                  Height = 146
                  Align = alClient
                  FixedColor = clGradientActiveCaption
                  TabOrder = 0
                  OnMouseDown = StringGrid_ResultMouseDown
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
            object TabSheet21: TTabSheet
              Caption = #21387#21147#39057#29575#20998#26512
              ImageIndex = 1
              object Panel2: TPanel
                Left = 88
                Top = 112
                Width = 441
                Height = 233
                Caption = #21151#33021#27491#22312#24320#21457#65292#32784#24515#31561#24453#19968#19979#65281
                TabOrder = 0
              end
            end
            object TabSheet22: TTabSheet
              Caption = #20998#21306#32479#35745#20998#26512
              ImageIndex = 2
              object Panel3: TPanel
                Left = 96
                Top = 120
                Width = 441
                Height = 233
                Caption = #21151#33021#27491#22312#24320#21457#65292#32784#24515#31561#24453#19968#19979#65281
                TabOrder = 0
              end
            end
            object TabSheet23: TTabSheet
              Caption = #30719#21387#20998#26512#25253#21578
              ImageIndex = 3
              object Panel4: TPanel
                Left = 104
                Top = 131
                Width = 441
                Height = 233
                Caption = #21151#33021#27491#22312#24320#21457#65292#32784#24515#31561#24453#19968#19979#65281
                TabOrder = 0
              end
            end
          end
        end
      end
      object RightPageControl: TPageControl
        Left = 954
        Top = 0
        Width = 294
        Height = 583
        ActivePage = TabSheet13
        Align = alRight
        TabOrder = 1
        object TabSheet12: TTabSheet
          Caption = #20027#35201#25805#20316
          object Splitter1: TSplitter
            Left = 0
            Top = 429
            Width = 286
            Height = 3
            Cursor = crVSplit
            Align = alTop
            ExplicitTop = 172
            ExplicitWidth = 129
          end
          object GB_KYFX_Top: TGroupBox
            Left = 0
            Top = 36
            Width = 286
            Height = 393
            Align = alTop
            Caption = #20998#26512#26469#21387#32467#26524
            TabOrder = 0
            object TreeView1: TTreeView
              Left = 2
              Top = 15
              Width = 282
              Height = 376
              Align = alClient
              Images = ImageList2
              Indent = 19
              TabOrder = 0
              OnClick = TreeView1Click
              OnCollapsed = TreeView1Collapsed
              OnExpanding = TreeView1Expanding
              OnMouseDown = TreeView1MouseDown
            end
          end
          object GB_KYFX_Bottom: TGroupBox
            Left = 0
            Top = 432
            Width = 286
            Height = 123
            Align = alClient
            Caption = #20998#26512#26085#24535
            TabOrder = 1
            object GB_KY_Memo1: TMemo
              Left = 2
              Top = 15
              Width = 282
              Height = 106
              Align = alClient
              Lines.Strings = (
                'GB_KY_Memo1')
              ScrollBars = ssVertical
              TabOrder = 0
              OnClick = GB_KY_Memo1Click
            end
          end
          object ToolBar1: TToolBar
            Left = 0
            Top = 0
            Width = 286
            Height = 36
            AutoSize = True
            ButtonHeight = 36
            ButtonWidth = 55
            Caption = 'ToolBar1'
            Images = ImageList1
            ParentShowHint = False
            ShowCaptions = True
            ShowHint = True
            TabOrder = 2
            object But_Kyfx_Start: TToolButton
              Left = 0
              Top = 0
              Hint = #24320#22987#25968#25454#20998#26512
              Caption = #24320#22987#20998#26512
              ImageIndex = 9
              OnClick = But_Kyfx_StartClick
            end
            object But_Kyfx_FillMap: TToolButton
              Left = 55
              Top = 0
              Hint = #25226#36827#23610#32467#26524#26631#27880#22312#20113#22270#19978
              Caption = #21306#22495#22635#22270
              Enabled = False
              ImageIndex = 14
              OnClick = But_Kyfx_FillMapClick
            end
            object But_Kyfx_Depth_Fx: TToolButton
              Left = 110
              Top = 0
              Hint = #30719#21387#25968#25454#28145#23618#20998#26512
              Caption = #28145#24230#25366#25496
              Enabled = False
              ImageIndex = 25
              OnClick = But_Kyfx_Depth_FxClick
            end
            object ToolButton3: TToolButton
              Left = 165
              Top = 0
              Width = 8
              Caption = 'ToolButton3'
              ImageIndex = 2
              Style = tbsSeparator
            end
            object But_Kyfx_SaveBmp: TToolButton
              Left = 173
              Top = 0
              Hint = #25253#20462#35746#30340#27493#36317#20449#24687#20445#23384#21040#25968#25454#24211
              Caption = #25968#25454#20445#23384
              ImageIndex = 2
              OnClick = But_Kyfx_SaveBmpClick
            end
            object But_Kyfx_Report: TToolButton
              Left = 228
              Top = 0
              Hint = #25171#21360#30719#21387#35266#27979#25253#21578
              Caption = #30719#21387#25253#21578
              ImageIndex = 3
            end
          end
        end
        object TabSheet13: TTabSheet
          Caption = #20998#26512#21442#25968
          ImageIndex = 1
          object GroupBox5: TGroupBox
            Left = 0
            Top = 0
            Width = 286
            Height = 160
            Align = alTop
            Caption = #21028#26029#26469#21387#20027#35201#21442#25968#35774#32622
            Color = clBtnFace
            ParentBackground = False
            ParentColor = False
            TabOrder = 0
            object PageCon_JudgeStep: TPageControl
              Left = 2
              Top = 15
              Width = 282
              Height = 143
              ActivePage = TabSheet17
              Align = alClient
              MultiLine = True
              TabOrder = 0
              TabPosition = tpRight
              object TabSheet17: TTabSheet
                Caption = #22522#26412#21442#25968
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                OnShow = TabSheet17Show
                object Label20: TLabel
                  Left = 19
                  Top = 13
                  Width = 72
                  Height = 13
                  Margins.Bottom = 0
                  Caption = #25903#26550#21021#25745#21387#24378
                  WordWrap = True
                end
                object Lab_Unit1: TLabel
                  Left = 200
                  Top = 13
                  Width = 16
                  Height = 13
                  Margins.Bottom = 0
                  BiDiMode = bdLeftToRight
                  Caption = 'Bar'
                  ParentBiDiMode = False
                  WordWrap = True
                end
                object Label22: TLabel
                  Left = 16
                  Top = 85
                  Width = 84
                  Height = 13
                  Margins.Bottom = 0
                  Caption = #30719#21387#20998#26512#25935#24863#24230
                  WordWrap = True
                end
                object Lab_Unit2: TLabel
                  Left = 200
                  Top = 47
                  Width = 16
                  Height = 13
                  Margins.Bottom = 0
                  BiDiMode = bdLeftToRight
                  Caption = 'Bar'
                  ParentBiDiMode = False
                  WordWrap = True
                end
                object Label21: TLabel
                  Left = 18
                  Top = 47
                  Width = 84
                  Height = 13
                  Margins.Bottom = 0
                  Caption = #25903#26550#28082#21387#38400#24320#21551
                  WordWrap = True
                end
                object Edit_StartPt: TEdit
                  Left = 120
                  Top = 12
                  Width = 74
                  Height = 21
                  TabOrder = 0
                  Text = 'Edit_StartPt'
                  OnClick = Edit_StartPtClick
                  OnKeyPress = Edit_StartPtKeyPress
                end
                object ComboBox_KY_Lmd: TComboBox
                  Left = 120
                  Top = 82
                  Width = 97
                  Height = 21
                  Style = csDropDownList
                  TabOrder = 1
                  OnChange = ComboBox_KY_LmdChange
                  Items.Strings = (
                    #25935#24863#24230#39640
                    #25935#24863#24230#36739#39640
                    #25935#24863#24230#19968#33324
                    #25935#24863#24230#20302)
                end
                object Edit_EndPt: TEdit
                  Left = 119
                  Top = 47
                  Width = 75
                  Height = 21
                  TabOrder = 2
                  Text = 'Edit_StartPt'
                  OnClick = Edit_EndPtClick
                  OnKeyPress = Edit_EndPtKeyPress
                end
              end
              object TabSheet18: TTabSheet
                Caption = #35814#32454#21442#25968
                ImageIndex = 1
                object Label24: TLabel
                  Left = 3
                  Top = 6
                  Width = 144
                  Height = 13
                  Margins.Bottom = 0
                  Caption = #21028#26029#26469#21387#26368#23569#36830#32493#25903#26550#25968#37327
                  WordWrap = True
                end
                object Label28: TLabel
                  Left = 223
                  Top = 3
                  Width = 12
                  Height = 13
                  Margins.Bottom = 0
                  BiDiMode = bdLeftToRight
                  Caption = #26550
                  ParentBiDiMode = False
                  WordWrap = True
                end
                object Label25: TLabel
                  Left = 3
                  Top = 30
                  Width = 144
                  Height = 13
                  Margins.Bottom = 0
                  Caption = #21028#23450#26469#21387#26368#23569#36830#32493#25512#36827#20992#25968
                  WordWrap = True
                end
                object Label36: TLabel
                  Left = 3
                  Top = 92
                  Width = 144
                  Height = 26
                  Margins.Bottom = 0
                  Caption = #21028#23450#21608#26399#26469#21387#27493#36317#26368#20302#24378#24230#31995#25968
                  WordWrap = True
                end
                object Label26: TLabel
                  Left = 3
                  Top = 59
                  Width = 132
                  Height = 13
                  Margins.Bottom = 0
                  Caption = #22280#23450#26469#21387#21306#22495#26368#20302#21387#21147#20540
                  WordWrap = True
                end
                object Label23: TLabel
                  Left = 224
                  Top = 30
                  Width = 12
                  Height = 13
                  Margins.Bottom = 0
                  BiDiMode = bdLeftToRight
                  Caption = #20992
                  ParentBiDiMode = False
                  WordWrap = True
                end
                object Lab_Unit3: TLabel
                  Left = 224
                  Top = 57
                  Width = 16
                  Height = 13
                  Margins.Bottom = 0
                  BiDiMode = bdLeftToRight
                  Caption = 'Bar'
                  ParentBiDiMode = False
                  WordWrap = True
                end
                object Edit_Sup_Con: TEdit
                  Left = 166
                  Top = 3
                  Width = 51
                  Height = 21
                  TabOrder = 0
                  Text = 'Edit_Sup_Con'
                  OnClick = Edit_Sup_ConClick
                  OnKeyPress = Edit_Sup_ConKeyPress
                end
                object Edit_Foot_Con: TEdit
                  Left = 167
                  Top = 30
                  Width = 51
                  Height = 21
                  TabOrder = 1
                  Text = 'Edit_Foot_Con'
                  OnClick = Edit_Foot_ConClick
                  OnKeyPress = Edit_Foot_ConKeyPress
                end
                object Edit_Min_Pt: TEdit
                  Left = 170
                  Top = 57
                  Width = 48
                  Height = 21
                  TabOrder = 2
                  Text = 'Edit_Min_Pt'
                  OnClick = Edit_Min_PtClick
                  OnKeyPress = Edit_Min_PtKeyPress
                end
                object Edit_MinQd: TEdit
                  Left = 168
                  Top = 84
                  Width = 49
                  Height = 21
                  TabOrder = 3
                  Text = 'Edit_Min_Pt'
                  OnClick = Edit_Min_PtClick
                  OnKeyPress = Edit_Min_PtKeyPress
                end
              end
            end
          end
          object GroupBox8: TGroupBox
            Left = 0
            Top = 160
            Width = 286
            Height = 174
            Align = alTop
            Caption = #26469#21387#27493#36317#22280#23450#26174#31034#36873#39033
            Color = clBtnFace
            ParentBackground = False
            ParentColor = False
            TabOrder = 1
            object Label_FillColor: TLabel
              Left = 16
              Top = 95
              Width = 36
              Height = 26
              Caption = #22806#26694#32447#26465#39068#33394
              WordWrap = True
            end
            object Label29: TLabel
              Left = 144
              Top = 135
              Width = 36
              Height = 26
              Caption = #21322#36879#26126#25968#20540
              WordWrap = True
            end
            object Label31: TLabel
              Left = 144
              Top = 95
              Width = 36
              Height = 26
              Caption = #22806#26694#32447#26465#23485#24230
              WordWrap = True
            end
            object Label27: TLabel
              Left = 16
              Top = 135
              Width = 36
              Height = 26
              Caption = #36873#20013#22635#20805#39068#33394
              WordWrap = True
            end
            object Edit_Step_TranC: TEdit
              Left = 209
              Top = 135
              Width = 56
              Height = 21
              TabOrder = 0
              Text = 'Edit_StartPt'
              OnClick = Edit_Step_TranCClick
              OnKeyPress = Edit_EndPtKeyPress
            end
            object StepColorBox: TColorBox
              Left = 63
              Top = 95
              Width = 66
              Height = 22
              TabOrder = 1
            end
            object RG_Step_Fill: TRadioGroup
              Left = 2
              Top = 49
              Width = 282
              Height = 40
              Align = alTop
              Caption = #27493#36317#22280#23450#22635#20805#26041#24335
              Columns = 2
              ItemIndex = 0
              Items.Strings = (
                #36879#26126#22635#20805
                #21322#36879#26126#22635#20805)
              TabOrder = 2
              OnClick = RG_Step_FillClick
            end
            object Edit_Fill_Line_Wide: TEdit
              Left = 208
              Top = 95
              Width = 57
              Height = 21
              TabOrder = 3
              Text = 'Edit_StartPt'
              OnClick = Edit_Fill_Line_WideClick
              OnKeyPress = Edit_EndPtKeyPress
            end
            object RG_Step_Ground_Fill: TRadioGroup
              Left = 2
              Top = 15
              Width = 282
              Height = 34
              Align = alTop
              Caption = #32972#26223#20113#22270#22635#20805#26041#24335
              Columns = 2
              ItemIndex = 0
              Items.Strings = (
                #39068#33394#22635#20805
                #32447#26694#32467#26500)
              TabOrder = 4
            end
            object SelectedColorBox: TColorBox
              Left = 63
              Top = 135
              Width = 66
              Height = 22
              TabOrder = 5
            end
          end
          object GroupBox9: TGroupBox
            Left = 0
            Top = 510
            Width = 286
            Height = 45
            Align = alBottom
            Color = clBtnFace
            ParentBackground = False
            ParentColor = False
            TabOrder = 2
            object Button8: TButton
              Left = 3
              Top = 17
              Width = 73
              Height = 25
              Caption = #24212#29992#20998#26512
              TabOrder = 0
              OnClick = Button8Click
            end
            object Button9: TButton
              Left = 192
              Top = 17
              Width = 81
              Height = 25
              Caption = #20445#23384#20026#40664#35748
              TabOrder = 1
              OnClick = Button9Click
            end
            object Button10: TButton
              Left = 95
              Top = 17
              Width = 74
              Height = 25
              Caption = #25764#38144#20462#25913
              TabOrder = 2
              OnClick = Button10Click
            end
          end
          object GroupBox11: TGroupBox
            Left = 0
            Top = 334
            Width = 286
            Height = 152
            Align = alTop
            Caption = #30719#21387#20998#26512#38454#27573#21010#20998
            Color = clBtnFace
            ParentBackground = False
            ParentColor = False
            TabOrder = 3
            object Label37: TLabel
              Left = 11
              Top = 20
              Width = 72
              Height = 13
              Caption = #38454#27573#21010#20998#25968#30446
            end
            object CB_PhaseNumber: TComboBox
              Left = 131
              Top = 12
              Width = 152
              Height = 21
              Style = csDropDownList
              ItemIndex = 1
              TabOrder = 0
              Text = '5'
              OnChange = CB_PhaseNumberChange
              Items.Strings = (
                '3'
                '5'
                '7')
            end
            object StringGridPhase: TStringGrid
              Left = 3
              Top = 39
              Width = 280
              Height = 110
              BiDiMode = bdLeftToRight
              ColCount = 6
              Ctl3D = True
              FixedCols = 0
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
              ParentBiDiMode = False
              ParentCtl3D = False
              ScrollBars = ssNone
              TabOrder = 1
              OnDrawCell = StringGridColorGroupDrawCell
              OnSelectCell = StringGridColorGroupSelectCell
              ColWidths = (
                64
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
        object TabSheet19: TTabSheet
          Caption = #21046#20316#21442#25968
          ImageIndex = 2
          object GroupBox2: TGroupBox
            Left = 0
            Top = 0
            Width = 286
            Height = 216
            Align = alTop
            Caption = #25805#20316#36873#39033
            TabOrder = 0
            object RG_Option_DispProDao: TRadioGroup
              Left = 2
              Top = 115
              Width = 282
              Height = 50
              Align = alTop
              Caption = #26159#21542#26174#31034#36827#20992#21306#22495#20043#22806#30340#26469#21387#20449#24687
              Color = clBtnFace
              Columns = 2
              ItemIndex = 0
              Items.Strings = (
                #26174#31034#26469#21387#27493#36317
                #19981#26174#31034#26469#21387#27493#36317)
              ParentBackground = False
              ParentColor = False
              TabOrder = 0
            end
            object RG_Option_Forcase: TRadioGroup
              Left = 2
              Top = 165
              Width = 282
              Height = 50
              Align = alTop
              Caption = #26159#21542#26174#31034#21387#21147#39044#27979
              Color = clBtnFace
              Columns = 2
              ItemIndex = 0
              Items.Strings = (
                #26174#31034#39044#27979
                #19981#26174#31034#39044#27979)
              ParentBackground = False
              ParentColor = False
              TabOrder = 1
            end
            object RG_Option_DispSave_MidDao: TRadioGroup
              Left = 2
              Top = 15
              Width = 282
              Height = 50
              Align = alTop
              Caption = #23545#36827#20992#20869#24050#32463#23384#20648#30340#21306#22495#26159#21542#37325#26032#20998#26512
              Color = clBtnFace
              Columns = 2
              ItemIndex = 1
              Items.Strings = (
                #37325#26032#20998#26512
                #19981#37325#26032#20998#26512)
              ParentBackground = False
              ParentColor = False
              TabOrder = 2
            end
            object RG_Option_QYorStep: TRadioGroup
              Left = 2
              Top = 65
              Width = 282
              Height = 50
              Align = alTop
              Caption = #24050#23384#20648#30340#25968#25454#26174#31034#21306#22495#20113#22270#36824#26159#26469#21387#27493#36317
              Color = clBtnFace
              Columns = 2
              ItemIndex = 1
              Items.Strings = (
                #21306#22495#20113#22270
                #26469#21387#27493#36317)
              ParentBackground = False
              ParentColor = False
              TabOrder = 3
            end
          end
          object Panel1: TPanel
            Left = 0
            Top = 526
            Width = 286
            Height = 29
            Align = alBottom
            Caption = #21047#26032#26469#21387#27493#36317#20113#22270
            ParentBackground = False
            TabOrder = 1
            OnClick = Panel1Click
          end
          object RG_Print_Option: TRadioGroup
            Left = 0
            Top = 216
            Width = 286
            Height = 50
            Align = alTop
            Caption = #26159#21542#36755#20986#36827#20992#33539#22260#22806#30340#26469#21387#20449#24687
            Color = clBtnFace
            Columns = 2
            ItemIndex = 1
            Items.Strings = (
              #36755#20986
              #19981#36755#20986)
            ParentBackground = False
            ParentColor = False
            TabOrder = 2
          end
          object RG_Print_Disp: TRadioGroup
            Left = 0
            Top = 266
            Width = 286
            Height = 50
            Align = alTop
            Caption = #30719#21387#20998#26512#32467#26524#25968#25454#26174#31034#26041#24335
            Color = clBtnFace
            Columns = 2
            ItemIndex = 1
            Items.Strings = (
              #20542#26012#26041#21521#25972#20307#26174#31034
              #20542#26012#26041#21521#20998#27573#26174#31034)
            ParentBackground = False
            ParentColor = False
            TabOrder = 3
          end
        end
      end
      object RightVisiblePanel: TPanel
        Left = 946
        Top = 0
        Width = 8
        Height = 583
        Align = alRight
        Caption = '>>'
        TabOrder = 2
        OnClick = RightVisiblePanelClick
      end
      object LeftVisiblePanel: TPanel
        Left = 257
        Top = 0
        Width = 8
        Height = 583
        Align = alLeft
        Caption = '<<'
        TabOrder = 3
        OnClick = LeftVisiblePanelClick
      end
      object LeftPageControl: TPageControl
        Left = 0
        Top = 0
        Width = 257
        Height = 583
        ActivePage = TabSheet7
        Align = alLeft
        OwnerDraw = True
        TabOrder = 4
        OnDrawTab = LeftPageControlDrawTab
        object TabSheet1: TTabSheet
          Caption = #21442#25968#36873#25321
          object GB_ContourAxis: TGroupBox
            Left = 0
            Top = 378
            Width = 249
            Height = 88
            Align = alTop
            Color = clBtnFace
            ParentBackground = False
            ParentColor = False
            TabOrder = 0
            object Lab_Axis: TLabel
              Left = 34
              Top = 61
              Width = 84
              Height = 13
              Caption = #26174#31034#22266#23450#20992#25968#20026
            end
            object Label38: TLabel
              Left = 204
              Top = 61
              Width = 12
              Height = 13
              Margins.Bottom = 0
              Caption = #20992
              WordWrap = True
            end
            object RG_XAxis: TRadioGroup
              Left = 2
              Top = 15
              Width = 245
              Height = 40
              Align = alTop
              Caption = #27178#22352#26631#26174#31034#27604#20363
              Columns = 2
              ItemIndex = 1
              Items.Strings = (
                #33258#36866#24212#26174#31034#27604#20363
                #26174#31034#22266#23450#36827#20992#25968)
              TabOrder = 0
              OnClick = RG_XAxisClick
            end
            object Edit_Axis: TEdit
              Left = 124
              Top = 61
              Width = 74
              Height = 21
              TabOrder = 1
              Text = '100'
              OnClick = Edit_AxisClick
              OnKeyPress = Edit_AxisKeyPress
            end
          end
          object PageControl_timeOrDao: TPageControl
            Left = 0
            Top = 0
            Width = 249
            Height = 219
            ActivePage = TabSheet15
            Align = alTop
            MultiLine = True
            TabOrder = 1
            TabPosition = tpLeft
            object TabSheet15: TTabSheet
              Caption = #36827#20992#36873#25321
              object GroupBox10: TGroupBox
                Left = 0
                Top = 0
                Width = 221
                Height = 211
                Align = alClient
                Color = clBtnFace
                ParentBackground = False
                ParentColor = False
                TabOrder = 0
                object Label32: TLabel
                  Left = 6
                  Top = 66
                  Width = 84
                  Height = 13
                  Margins.Bottom = 0
                  Caption = #25968#25454#24320#22987#36827#20992#25968
                  WordWrap = True
                end
                object Label33: TLabel
                  Left = 3
                  Top = 116
                  Width = 84
                  Height = 13
                  Margins.Bottom = 0
                  Caption = #25968#25454#32467#26463#36827#20992#25968
                  WordWrap = True
                end
                object Label34: TLabel
                  Left = 193
                  Top = 92
                  Width = 12
                  Height = 13
                  Margins.Bottom = 0
                  Caption = #20992
                  WordWrap = True
                end
                object Label35: TLabel
                  Left = 193
                  Top = 123
                  Width = 12
                  Height = 13
                  Margins.Bottom = 0
                  Caption = #20992
                  WordWrap = True
                end
                object Edit_StartDao: TEdit
                  Left = 89
                  Top = 89
                  Width = 85
                  Height = 21
                  TabOrder = 0
                  Text = 'Edit_StartDao'
                  OnClick = Edit_StartDaoClick
                  OnKeyPress = Edit_StartDaoKeyPress
                end
                object Edit_EndDao: TEdit
                  Left = 89
                  Top = 132
                  Width = 85
                  Height = 21
                  TabOrder = 1
                  Text = 'Edit_EndDao'
                  OnClick = Edit_EndDaoClick
                  OnKeyPress = Edit_EndDaoKeyPress
                end
                object BitBtn7: TBitBtn
                  Left = 89
                  Top = 159
                  Width = 96
                  Height = 25
                  Caption = #25968#25454#32852#26597#24212#29992
                  TabOrder = 2
                  OnClick = BitBtn7Click
                end
                object RG_DaoOrFootage: TRadioGroup
                  Left = 2
                  Top = 15
                  Width = 217
                  Height = 45
                  Align = alTop
                  Caption = #25968#25454#26597#35810#26041#24335
                  Columns = 2
                  ItemIndex = 0
                  Items.Strings = (
                    #29992#36827#20992#26597#35810#25968#25454
                    #29992#36827#23610#26597#35810#25968#25454)
                  TabOrder = 3
                end
              end
            end
            object TabSheet16: TTabSheet
              Caption = #36827#23610#36873#25321
              ImageIndex = 1
              object GB_DateTime: TGroupBox
                Left = 3
                Top = 3
                Width = 249
                Height = 190
                Color = clCream
                Enabled = False
                ParentBackground = False
                ParentColor = False
                TabOrder = 0
                object Label2: TLabel
                  Left = 13
                  Top = 20
                  Width = 72
                  Height = 13
                  Margins.Bottom = 0
                  Caption = #25968#25454#24320#22987#26102#38388
                  WordWrap = True
                end
                object Label4: TLabel
                  Left = 13
                  Top = 47
                  Width = 72
                  Height = 13
                  Margins.Bottom = 0
                  Caption = #25968#25454#24320#22987#36827#23610
                  WordWrap = True
                end
                object Label5: TLabel
                  Left = 177
                  Top = 47
                  Width = 12
                  Height = 13
                  Margins.Bottom = 0
                  Caption = #31859
                  WordWrap = True
                end
                object Label6: TLabel
                  Left = 13
                  Top = 105
                  Width = 72
                  Height = 13
                  Margins.Bottom = 0
                  Caption = #25968#25454#32467#26463#26102#38388
                  WordWrap = True
                end
                object Label7: TLabel
                  Left = 13
                  Top = 132
                  Width = 72
                  Height = 13
                  Margins.Bottom = 0
                  Caption = #25968#25454#32467#26463#36827#23610
                  WordWrap = True
                end
                object Label8: TLabel
                  Left = 177
                  Top = 132
                  Width = 12
                  Height = 13
                  Margins.Bottom = 0
                  Caption = #31859
                  WordWrap = True
                end
                object StartDateTime: TDateTimePicker
                  Left = 91
                  Top = 20
                  Width = 112
                  Height = 21
                  Date = 42994.399148148150000000
                  Time = 42994.399148148150000000
                  TabOrder = 0
                  OnClick = StartDateTimeClick
                end
                object StartEdit: TEdit
                  Left = 91
                  Top = 47
                  Width = 80
                  Height = 21
                  TabOrder = 1
                  OnClick = StartEditClick
                  OnKeyPress = StartEditKeyPress
                end
                object BitBtn1: TBitBtn
                  Left = 13
                  Top = 74
                  Width = 72
                  Height = 25
                  Caption = #26102#38388#26597#36827#23610
                  TabOrder = 2
                  OnClick = BitBtn1Click
                end
                object BitBtn3: TBitBtn
                  Left = 128
                  Top = 74
                  Width = 75
                  Height = 25
                  Caption = #36827#23610#26597#26102#38388
                  TabOrder = 3
                  OnClick = BitBtn3Click
                end
                object EndDateTime: TDateTimePicker
                  Left = 91
                  Top = 105
                  Width = 112
                  Height = 21
                  Date = 42994.399148148150000000
                  Time = 42994.399148148150000000
                  TabOrder = 4
                  OnClick = EndDateTimeClick
                end
                object EndEdit: TEdit
                  Left = 91
                  Top = 132
                  Width = 80
                  Height = 21
                  TabOrder = 5
                  Text = 'EndEdit'
                  OnClick = EndEditClick
                  OnKeyPress = EndEditKeyPress
                end
                object BitBtn4: TBitBtn
                  Left = 13
                  Top = 159
                  Width = 72
                  Height = 25
                  Caption = #26102#38388#26597#36827#23610
                  TabOrder = 6
                  OnClick = BitBtn4Click
                end
                object BitBtn2: TBitBtn
                  Left = 128
                  Top = 159
                  Width = 75
                  Height = 25
                  Caption = #36827#23610#26597#26102#38388
                  TabOrder = 7
                  OnClick = BitBtn2Click
                end
              end
            end
          end
          object RadioGroup_DownFootage: TRadioGroup
            Left = 0
            Top = 297
            Width = 249
            Height = 40
            Align = alTop
            Caption = #26426#22836#22352#26631#26631#27880#24418#24335
            Color = clBtnFace
            Columns = 2
            ItemIndex = 1
            Items.Strings = (
              #24320#37319#26102#38388
              #32047#35745#36827#23610)
            ParentBackground = False
            ParentColor = False
            TabOrder = 2
          end
          object RG_Yun_Cycle: TRadioGroup
            Left = 0
            Top = 219
            Width = 249
            Height = 78
            Align = alTop
            Caption = #25903#26550#26174#31034#21387#21147#25968#25454
            Color = clBtnFace
            Columns = 2
            ItemIndex = 3
            Items.Strings = (
              #26368#22823#20540
              #24179#22343#20540
              #26411#38459#21147
              #21516#19968#26102#21051#25235#21462#20540
              #25163#21160#24405#20837)
            ParentBackground = False
            ParentColor = False
            TabOrder = 3
            OnClick = RG_Yun_CycleClick
          end
          object RadioGroup_UpperFootage: TRadioGroup
            Left = 0
            Top = 337
            Width = 249
            Height = 41
            Align = alTop
            Caption = #26426#23614#22352#26631#26631#27880#24418#24335
            Color = clBtnFace
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              #24320#37319#26102#38388
              #32047#35745#36827#23610)
            ParentBackground = False
            ParentColor = False
            TabOrder = 4
          end
        end
        object TabSheet2: TTabSheet
          Caption = #20113#22270#36873#39033
          ImageIndex = 1
          object GroupBox3: TGroupBox
            Left = 0
            Top = 0
            Width = 249
            Height = 129
            Align = alTop
            Caption = #20113#22270#26174#31034#36873#39033
            Color = clBtnFace
            ParentBackground = False
            ParentColor = False
            TabOrder = 0
            object RG_Yun_Main: TRadioGroup
              Left = 2
              Top = 15
              Width = 245
              Height = 50
              Align = alTop
              Caption = #25903#26550#23454#26102#21387#21147#25968#25454
              Color = clBtnFace
              Columns = 2
              Items.Strings = (
                #21387#21147#22788#29702#25968#25454
                #23454#26102#24490#29615#25968#25454
                #25163#21160#22788#29702#25968#25454)
              ParentBackground = False
              ParentColor = False
              TabOrder = 0
              Visible = False
              OnClick = RG_Yun_MainClick
            end
            object RG_Yun_DataType: TRadioGroup
              Left = 2
              Top = 65
              Width = 245
              Height = 50
              Align = alTop
              Caption = #28082#21387#25903#26550#21387#21147#26174#31034#36873#25321
              Color = clBtnFace
              Columns = 2
              Items.Strings = (
                #21069#26609#21387#21147
                #21518#26609#21387#21147
                #24038#26609#21387#21147
                #21491#26609#21387#21147)
              ParentBackground = False
              ParentColor = False
              TabOrder = 1
              Visible = False
            end
          end
          object GB_Contour_Color: TGroupBox
            Left = 0
            Top = 129
            Width = 249
            Height = 192
            Align = alTop
            Caption = #20113#22270#39068#33394#36873#39033
            Color = clBtnFace
            ParentBackground = False
            ParentColor = False
            TabOrder = 1
            object Label19: TLabel
              Left = 3
              Top = 20
              Width = 72
              Height = 13
              Caption = #35831#36873#25321#20998#32452#25968
            end
            object CB_Box_ColorGroup: TComboBox
              Left = 81
              Top = 20
              Width = 152
              Height = 21
              Style = csDropDownList
              TabOrder = 0
              OnChange = CB_Box_ColorGroupChange
              Items.Strings = (
                '3'
                '4'
                '5'
                '6'
                '7'
                '8'
                '9'
                '10')
            end
            object StringGridColorGroup: TStringGrid
              Left = 0
              Top = 47
              Width = 246
              Height = 114
              BiDiMode = bdLeftToRight
              ColCount = 6
              Ctl3D = True
              FixedCols = 0
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
              ParentBiDiMode = False
              ParentCtl3D = False
              ScrollBars = ssNone
              TabOrder = 1
              OnDrawCell = StringGridColorGroupDrawCell
              OnSelectCell = StringGridColorGroupSelectCell
              ColWidths = (
                64
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
            object ColorGroupButton: TButton
              Left = 144
              Top = 167
              Width = 103
              Height = 26
              Caption = #39068#33394#24212#29992#20445#23384
              TabOrder = 2
              OnClick = ColorGroupButtonClick
            end
            object Button1: TButton
              Left = 3
              Top = 167
              Width = 103
              Height = 26
              Caption = #24674#22797#21040#19978#27425#20445#23384
              TabOrder = 3
              OnClick = Button1Click
            end
          end
        end
        object TabSheet6: TTabSheet
          Caption = #26354#32447#36873#39033
          ImageIndex = 2
          object RG_Graph_Main: TRadioGroup
            Left = 0
            Top = 0
            Width = 249
            Height = 65
            Align = alTop
            Caption = #21387#21147#26354#32447#26174#31034#25968#25454#31867#22411
            Items.Strings = (
              #20542#26012#26041#21521#21306#38388#25968#25454
              #21333#20010#28082#21387#25903#26550#25968#25454)
            TabOrder = 0
            OnClick = RG_Graph_MainClick
          end
          object GroupBox1: TGroupBox
            Left = 0
            Top = 208
            Width = 249
            Height = 237
            Align = alClient
            Caption = #21333#20010#28082#21387#25903#26550#32534#21495#36873#25321
            TabOrder = 1
            object CheckListBox_Support: TCheckListBox
              Left = 2
              Top = 15
              Width = 245
              Height = 220
              Align = alClient
              Columns = 2
              ItemHeight = 13
              Items.Strings = (
                '1'#21495#26550
                '2'#21495#26550
                '')
              TabOrder = 0
              OnClick = CheckListBox_SupportClick
            end
          end
          object GB_Graph_L: TGroupBox
            Left = 0
            Top = 125
            Width = 249
            Height = 83
            Align = alTop
            Caption = #24037#20316#38754#20542#26012#26041#21521#21306#38388#21010#20998
            TabOrder = 2
            object CheckListBox_phase: TCheckListBox
              Left = 2
              Top = 15
              Width = 245
              Height = 58
              Align = alTop
              Columns = 2
              ItemHeight = 13
              Items.Strings = (
                #31532#19968#21306#38388
                #31532#20108#21306#38388
                #31532#19977#21306#38388
                #31532#22235#21306#38388
                #31532#20116#21306#38388
                #31532#20845#21306#38388
                #31532#19971#21306#38388)
              TabOrder = 0
              OnClick = CheckListBox_phaseClick
            end
          end
          object GroupBox4: TGroupBox
            Left = 0
            Top = 445
            Width = 249
            Height = 110
            Align = alBottom
            Caption = #26354#32447#30011#22270#25805#20316
            TabOrder = 3
            object BitBtn5: TBitBtn
              Left = 2
              Top = 74
              Width = 86
              Height = 25
              Caption = #21047#26032#22270#29255
              TabOrder = 0
              OnClick = BitBtn5Click
            end
            object BitBtn6: TBitBtn
              Left = 112
              Top = 72
              Width = 86
              Height = 25
              Caption = #20445#23384#22270#29255
              TabOrder = 1
            end
            object Memo_info: TMemo
              Left = 2
              Top = 15
              Width = 245
              Height = 53
              Align = alTop
              Color = clMoneyGreen
              TabOrder = 2
            end
          end
          object GB_Graph_DataType: TGroupBox
            Left = 0
            Top = 65
            Width = 249
            Height = 60
            Align = alTop
            Caption = #28082#21387#25903#26550#21387#21147#26174#31034#36873#25321
            Color = clWhite
            ParentBackground = False
            ParentColor = False
            TabOrder = 4
            object CheckListBox_DataType: TCheckListBox
              Left = 2
              Top = 15
              Width = 245
              Height = 33
              Align = alTop
              Columns = 2
              ItemHeight = 13
              Items.Strings = (
                #21069#26609#21387#21147
                #21518#26609#21387#21147
                #24038#26609#21387#21147
                #21491#26609#21387#21147)
              TabOrder = 0
              OnClick = CheckListBox_phaseClick
            end
          end
        end
        object TabSheet7: TTabSheet
          Caption = #22270#24418#25805#20316
          ImageIndex = 3
          object GroupBox6: TGroupBox
            Left = 0
            Top = 0
            Width = 249
            Height = 161
            Align = alTop
            Caption = #19977#32500#20113#22270#26174#31034#25805#20316
            TabOrder = 0
            object Button2: TButton
              Left = 0
              Top = 16
              Width = 96
              Height = 25
              Caption = #39034#26102#38024#26059#36716
              TabOrder = 0
              OnClick = Button2Click
            end
            object Button3: TButton
              Left = 93
              Top = 16
              Width = 111
              Height = 25
              Caption = #36870#26102#38024#26059#36716
              TabOrder = 1
              OnClick = Button3Click
            end
            object Button4: TButton
              Left = 0
              Top = 47
              Width = 96
              Height = 25
              Caption = #19978#20208'5'#24230
              TabOrder = 2
              OnClick = Button4Click
            end
            object Button5: TButton
              Left = 93
              Top = 47
              Width = 111
              Height = 25
              Caption = #19979#20463'5'#24230
              TabOrder = 3
              OnClick = Button5Click
            end
          end
        end
      end
    end
  end
  object Panel_ProcessBar: TPanel
    Left = 1256
    Top = 43
    Width = 39
    Height = 609
    Align = alRight
    TabOrder = 2
    Visible = False
    object FirstPGBar: TProgressBar
      Left = 1
      Top = 1
      Width = 18
      Height = 607
      Align = alLeft
      Orientation = pbVertical
      Smooth = True
      TabOrder = 0
    end
    object SecondPGBar: TProgressBar
      Left = 19
      Top = 1
      Width = 18
      Height = 607
      Align = alLeft
      Orientation = pbVertical
      Smooth = True
      TabOrder = 1
    end
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 1295
    Height = 43
    Align = alTop
    BevelOuter = bvLowered
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 3
    Visible = False
    DesignSize = (
      1295
      43)
    object Label_DataPress_Unit: TLabel
      Left = 1088
      Top = 19
      Width = 142
      Height = 16
      Anchors = [akTop, akRight]
      Caption = 'Label_DataPress_Unit'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object GB_DW: TGroupBox
      Left = 1
      Top = 1
      Width = 808
      Height = 41
      Align = alLeft
      Caption = #21333#20301#20449#24687#36873#25321
      Color = clSkyBlue
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      Visible = False
      object Label3: TLabel
        Left = 459
        Top = 20
        Width = 60
        Height = 13
        Margins.Bottom = 0
        Caption = #24037#20316#38754#21517#31216
        WordWrap = True
      end
      object Label1: TLabel
        Left = 233
        Top = 20
        Width = 48
        Height = 13
        Margins.Bottom = 0
        Caption = #30719#20117#21517#31216
      end
      object Label45: TLabel
        Left = 3
        Top = 20
        Width = 48
        Height = 13
        Margins.Bottom = 0
        Caption = #38598#22242#20844#21496
      end
      object JITuanCombo: TComboBox
        Left = 57
        Top = 17
        Width = 149
        Height = 21
        Style = csDropDownList
        DropDownCount = 20
        ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 0
        OnChange = JITuanComboChange
      end
      object ComboKName: TComboBox
        Left = 287
        Top = 17
        Width = 154
        Height = 21
        Style = csDropDownList
        DropDownCount = 20
        ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 1
        OnChange = ComboKNameChange
      end
      object GzmCombo: TComboBox
        Left = 551
        Top = 17
        Width = 178
        Height = 21
        Style = csDropDownList
        DropDownCount = 20
        ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 2
        OnChange = GzmComboChange
      end
    end
  end
  object TreePopu: TPopupMenu
    Images = ImageList1
    Left = 935
    Top = 4
    object TreePop_Start: TMenuItem
      Caption = #25968#25454#24320#22987#20998#26512
      ImageIndex = 9
    end
    object TreePop_Fill: TMenuItem
      Caption = #27493#36317#22635#20805#20113#22270
      ImageIndex = 14
      OnClick = TreePop_FillClick
    end
    object TreePop_depth: TMenuItem
      Caption = #35268#24459#28145#23618#20998#26512
      ImageIndex = 25
      OnClick = TreePop_depthClick
    end
    object TreePop_save: TMenuItem
      Caption = #25968#25454#24211#20445#23384#25968#25454
      ImageIndex = 2
      OnClick = TreePop_saveClick
    end
    object TreePop_Report: TMenuItem
      Caption = #30719#21387#35266#27979#25253#21578
      ImageIndex = 3
      OnClick = TreePop_ReportClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object TreePop_Delete: TMenuItem
      Caption = #21024#38500#35813#21306#22495
      ImageIndex = 65
      OnClick = TreePop_DeleteClick
    end
    object TreePop_Recall: TMenuItem
      Caption = #24674#22797#35813#21306#22495
      ImageIndex = 7
      OnClick = TreePop_RecallClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object TreePop_Refresh: TMenuItem
      Caption = #21047#26032#22270#24418
      ImageIndex = 60
      OnClick = TreePop_RefreshClick
    end
    object TreePop_Close: TMenuItem
      Caption = #20851#38381#26412#24037#20855#26639
      ImageIndex = 38
      OnClick = TreePop_CloseClick
    end
    object N20: TMenuItem
      Caption = '-'
    end
  end
  object PopMemu_Footage: TPopupMenu
    Images = ImageList1
    Left = 751
    Top = 76
    object Pop_Foot_Auto: TMenuItem
      Caption = #33258#21160#37319#38598#36827#23610#20992#25968
      ImageIndex = 61
      OnClick = Pop_Foot_AutoClick
    end
    object Pop_Foot_UpdateDao: TMenuItem
      Caption = #26356#26032#21518#38754#30340#20992#25968
      ImageIndex = 28
      OnClick = Pop_Foot_UpdateDaoClick
    end
    object N24: TMenuItem
      Caption = '-'
    end
    object Pop_Foot_oneday: TMenuItem
      Caption = #28155#21152#19979#19968#22825#20992#25968
      ImageIndex = 66
      OnClick = Pop_Foot_onedayClick
    end
    object Pop_Foot_AddStep: TMenuItem
      Caption = #28155#21152#19979#19968#20992
      ImageIndex = 1
      OnClick = Pop_Foot_AddStepClick
    end
    object Pop_Foot_InsertStep: TMenuItem
      Caption = #25554#20837#19968#20992#25968#25454
      ImageIndex = 9
      OnClick = Pop_Foot_InsertStepClick
    end
    object Pop_Foot_DeleteStep: TMenuItem
      Caption = #21024#38500#24403#21069#20992#25968#25454
      ImageIndex = 4
      OnClick = Pop_Foot_DeleteStepClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Pop_Foot_EditTime: TMenuItem
      Caption = #32534#36753#36827#23610#30340#26102#38388
      ImageIndex = 11
      OnClick = Pop_Foot_EditTimeClick
    end
    object Pop_Foot_UpdateTime: TMenuItem
      Caption = #26356#26032#21518#38754#30340#26102#38388
      ImageIndex = 30
      OnClick = Pop_Foot_UpdateTimeClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object Pop_Foot_Update_PartData: TMenuItem
      Caption = #20462#35746#33267#19978#19968#27425#24405#20837#36827#23610
      ImageIndex = 10
      OnClick = Pop_Foot_Update_PartDataClick
    end
    object Pop_Foot_Update_allData: TMenuItem
      Caption = #20462#35746#20197#21069#20840#37096#36827#23610
      ImageIndex = 58
      OnClick = Pop_Foot_Update_allDataClick
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object Pop_Foot_Paste: TMenuItem
      Caption = #31896#36148#22797#21046#36807#26469#25968#25454
      ImageIndex = 6
      OnClick = Pop_Foot_PasteClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Pop_Foot_Save: TMenuItem
      Caption = #20445#23384#21040#25968#25454#24211
      ImageIndex = 2
      OnClick = Pop_Foot_SaveClick
    end
    object Pop_Foot_Refresh: TMenuItem
      Caption = #21047#26032#25968#25454
      ImageIndex = 60
      OnClick = Pop_Foot_RefreshClick
    end
    object Pop_Foot_DeleteAll: TMenuItem
      Caption = #28165#38500#25152#26377#35760#24405
      ImageIndex = 65
      OnClick = Pop_Foot_DeleteAllClick
    end
  end
  object ImageList1: TImageList
    BlendColor = clWindow
    BkColor = clSilver
    DrawingStyle = dsTransparent
    Left = 596
    Top = 16
    Bitmap = {
      494C01014600E003DC0310001000C0C0C000FF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002001000001002000000000000020
      0100000000000000000000000000000000000A588E9F1090E9FF1090E9FF1090
      E9FF1090E9FF1090E9FF1090E9FF1090E9FF1090E9FF1090E9FF1090E9FF1090
      E9FF1090E9FF1090E9FF1090E9FF1090E9FF000000004F6676FF304F65BF0C13
      19480000001E0000001B0000001700000013000000100000000C000000090000
      0006000000030000000100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001395EBFF059CF4FF029BF4FF069C
      F5FF0A9EF5FF0DA0F5FF10A1F5FF13A9F7FF14B4F8FF12A2F6FF10A1F5FF0DA0
      F5FF0A9EF5FF069CF5FF029BF4FF4BB6F6FF00000000416178E7E9F7FDFF8ABE
      DAFF6592B8FF4E7997FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001799ECFF7CCCF9FF0A9EF5FF10A1
      F5FF14A3F6FF19A5F6FF1CA6F7FF23A0C3FF0E1C1DFF21AFF8FF1CA6F7FF19A5
      F6FF14A3F6FF10A1F5FF0C9FF5FF7EC7F5FF000000000E161D33E3F2F8FFBAE0
      EEFF84B4D4FF327CAFFF0034578C000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000D4A70783BABF0FF1AA5F6FF1BA6
      F7FF21A9F7FF27ABF8FF2BADF8FF309DD7FF293439FF2FAFF8FF2BADF8FF27AB
      F8FF21A9F7FF1BA6F7FF6FC7F9FF1C9EEEFF00000000000000008EADC1FFE3F5
      FCFF4C94BAFF41ACE6FF1F89D0FF0034578C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000020A2F0FFB1E0FCFF28AB
      F8FF30AFF9FF36B1F9FF3BB4FAFF45BDFBFF51CBFBFF3EB5FAFF3BB4FAFF36B1
      F9FF30AFF9FF2BACF8FF52B7F4FF125B88900000000000000000284254964773
      91FF5DC9F9FF5ECBFAFF4EB5EAFF1F89D0FF0034578C00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000071D2B2D28A8F1FF45B7
      F9FF3EB5FAFF46B8FBFF4CBAFBFF63CDFCFF22373CFF4FBCFBFF4CBAFBFF46B8
      FBFF3EB5FAFFB0E1FDFF25A7F1FF000000000000000000000000000000000773
      BBFF319BE2FF67D0F9FF65D0FAFF5ABDEDFF1F89D0FF0034578C000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002498D6E1ABDF
      FBFF4EBBFBFF55BFFCFF5CC1FCFF78D0F8FF222B2DFF60C3FDFF5CC1FCFF55BF
      FCFF57BFFBFF33B0F4FF0C33474B000000000000000000000000000000000000
      00000772BAFF319CE2FF70D6FBFF6CD5FBFF64C4EFFF1F89D0FF0034578C0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002DB1
      F5FF7DCFFDFF64C5FDFF6BC8FEFF84C3E3FF1F2223FF6FCAFEFF6BC8FEFF64C5
      FDFFBCE7FCFF2DB1F5FF00000000000000000000000000000000000000000000
      0000000000000773BBFF329CE2FF7BDBFDFF74D9FDFF71CAF1FF1F89D0FF0034
      578C000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000237E
      ABB18AD6FAFF72CBFEFF78CEFFFF92BDD7FF1C1C1CFF7FD1FFFF78CEFFFF87D3
      FEFF32B5F6FF0000000000000000000000000000000000000000000000000000
      000000000000000000000773BBFF339DE3FF87E0FDFF7DDEFDFF7CD0F2FF1F89
      D0FF0034578C0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000036B9F8FFB5E4FFFF88D4FFFF94B2C3FF232323FF98DAFFFF88D4FFFF99DC
      FCFF2889B8BD0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000773BBFF339DE3FF90E5FEFF84E3FEFF82D3
      F1FF1F89D0FF20435DBB00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001D607E815ECAFAFFA0DDFFFF90A7B3FF292929FFB1E3FFFFC0E8FFFF3ABD
      F9FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000773BBFF349EE3FF96E9FDFF8CE8
      FEFF5F5F5FFF7A7A7AFF2C2E3386000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003DC1FBFFDDF3FFFFC2E9FFFFCCEDFFFFC3E9FFFF75D4FCFF2574
      9799000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000773BBFF37A0E4FF6868
      68FFBABABAFF959595FF929292FF00030D150000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000F2E3B3C45C7FCFFCFEEFFFFDCF2FFFFE8F7FFFF41C5FCFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000336789FFBBBB
      BBFFFFFFFFFFC3C3C3FF2A3A8FFF002AA4FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003DB8E8EACEF0FFFFDDF3FFFF50CDFDFF1847595A0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006262
      62FFC7C7C7FF8391AFFF3E6DF1FF002AA1FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000046CCFEFF4FCEFEFF41BEECED000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000F205195063AC0FF0330AAFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000040B0D0D00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C0006060B4FF5E5EB1FFC0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      00030000000A4E240077B65A08FFBD6516FFBF681AFFBC6517FF894000C70603
      0017000000050000000300000000000000000000000000000000000000FF0000
      00FF000000FF7B391BFF7B391BFF7B391BFF7B391BFF7B391BFF7B391BFF7B39
      1BFF7B391BFF7B391BFF7B391BFF00000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0006363CBFF0B0BA8FF0C0CA4FF02029EFF02029EFF0C0CA4FF0B0BA9FF6363
      CBFFC0C0C000C0C0C000C0C0C000C0C0C000000000000000000000000000391B
      0051BD671AFFBD5A03FFBC5800FFBD5901FFBD5901FFBC5800FFBC5800FFC064
      13FF833D00BA0000000000000000000000000000000000000000060606FF0000
      00FF060606FF9E5736FF9E5736FF9E5736FF9E5736FF9E5736FF9E5736FF9E57
      36FF9E5736FF9E5736FFBD8D76FF00000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0002C2C
      B7FF0808A4FF0000A4FF0000A6FF0000A8FF0000A8FF0000A7FF0000A5FF0808
      A5FF2C2CB7FFC0C0C000C0C0C000C0C0C00000000000000000004A230069C46E
      22FFBF5B03FFC05D04FFC15E05FFC25F05FFC25F05FFC15E05FFC05D04FFBF5B
      03FFBE5C05FFB75C0CFF00000000000000000000000000000000080808FF0000
      00FF080808FF9E5736FF9E5736FF9E5736FF9F5838FF9F5938FFA05939FF9F59
      38FF9F5838FF9E5736FFBD8D76FFEDEDEDFFC0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0003232BAFF0404
      A8FF0000ACFF3333BFFF0000B4FF0000B5FF0000B6FF0A0AB8FF5050C9FF0000
      AEFF0404ABFF3232BBFFC0C0C000C0C0C0000000000000000000C97B35FFC25F
      05FFC56207FFC86409FFC9660AFFFFFFFFFFFFFFFFFFFFFFFFFFC86409FFC562
      07FFC25F05FFC1620CFF763700A80000000000000000000000000A0A0AFF0000
      00FF0A0A0AFF9F5838FFA15B3AFFA35D3CFFA55F3EFFA7603FFFA7603FFFA760
      3FFFA55F3EFFA35D3CFFBF8F79FFF4F4F4FFC0C0C000E7D7AD00E7D7CE00DEA6
      4200EFCF6B00FFF7EF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C0006060CCFF1010B1FF0000
      B3FF6161D3FFFBFBFEFF7979DEFF0000C5FF0C0CC8FFB6B6EEFFFEFEFEFF7070
      D9FF0000B6FF1010B4FF6060CCFFC0C0C000000000008D4200C9C7660DFFC966
      0AFFCD6A0CFFCF6D0EFFD16F10FFFFFFFFFFFFFFFFFFFFFFFFFFCF6D0EFFCD6A
      0CFFC9660AFFC56207FFCD823EFF0000000000000000000000000C0C0CFF0000
      00FF0C0C0CFFA55E3DFFA86140FFAB6443FFAD6646FFC38D75FFBE846AFFAF67
      47FFAD6646FFAB6443FFC4937DFFFCFCFCFFE7CFA500B57100006B491000C679
      0000E79E0000E7A61800F7E7BD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C0002828BCFF0000B7FF4848
      D1FFFCFCFEFFFFFFFFFFFFFFFFFF7B7BE8FFB3B3F2FFFFFFFFFFFFFFFFFFFEFE
      FEFF3C3CD1FF0000BCFF2828BDFFC0C0C00000000000CE8542FFCC6A0CFFD16F
      0FFFD57312FFD87714FFDA7916FFFFFFFFFFFFFFFFFFFFFFFFFFD87714FFD573
      12FFD16F0FFFCC6A0CFFCB6E17FF6E33009C00000000000000000F0F0FFF0000
      00FF0F0F0FFFAC6444FFB06848FFB97557FFDBB6A6FFB97151FFB97251FFB971
      51FFB76F4FFFB46C4CFFCA9883FF00000000E7C79C00C67900007B590000BD71
      0000E79E0000DE960000EFCF8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C0002B2BC5FF0000C3FF0C0C
      D0FFBABAF4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7A
      ECFF0000D2FF0000C9FF2B2BC9FFC0C0C0000D060012DD9856FFD37111FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFD37111FFCE6B0DFFB75C0BFF0000000000000000111111FF0000
      00FF111111FFB36C4BFFB97151FFF7EEEAFFD4A38DFFD7A48EFFF8EFEBFFC37B
      5BFFD8AB97FFBD7655FFD09E89FFEDEDEDFFF7E7CE00CE860000AD790000AD69
      0000DE9E0000DE960000EFC76300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007979D5FF2828CDFF0000CFFF0000
      DAFF0B0BE4FFB8B8F9FFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFFFF7878F5FF0000
      E6FF0000DFFF0000D5FF2727D2FF7A7AD7FF2A14003CE19C57FFDA7916FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFDA7916FFD47211FFC37127FF0000000000000000131313FF0000
      00FF131313FFBA7453FFC17A59FFE3BEAEFFF2E0D8FFCD8564FFE6C2B1FFCD85
      64FFF2E0D8FFC77F5FFFD6A48EFFF4F4F4FFFFFFFF00D69E3100D68E0000AD71
      0000D6960000DE9E0000E7AE2900FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007A7AD8FF2E2ED7FF0000DAFF0000
      E5FF0A0AEEFFB2B2FBFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFFFF7777F9FF0000
      F1FF0000E9FF0000E0FF2E2EDCFF7C7CD9FF180B0021E8AD6FFFE0811CFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFE0811CFFDC7F1FFFC46C1CFF0000000000000000151515FF0000
      00FF151515FFC37B5BFFCA8262FFF6E9E3FFE1B09AFFDEA489FFF0D6C9FFD68F
      6EFFECCDBEFFD08867FFDBAA94FFFCFCFCFFFFFFFF00E7C78C00D68E0000CE8E
      0000CE8E0000DE9E0000DE9E0000E7CF9C00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C0004D4DE2FF0000E3FF0A0A
      EEFFB7B7FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7979
      FAFF0000F1FF0000E8FF4D4DE7FFC0C0C00000000000E4AA70FFE68924FFEC91
      2AFFF09833FFF49E3BFFF6A546FFFFFFFFFFFFFFFFFFFFFFFFFFF49E3BFFF098
      33FFEC912AFFE68822FFE79E52FF8B480AB40000000000000000171717FF0000
      00FF171717FFCA8262FFD28969FFE1AC93FFE2A88FFFDD9778FFDE9879FFF2D8
      CDFFDB9475FFD7906FFFE0AF99FF00000000FFFFFF00FFF7EF00DE9E2100DE96
      0000D6960000DE9E0000DE9E0000CE9E2100C6BEBD00DEDFDE00E7E7E700E7E7
      E700E7E7E700DED7CE00DEB65A00F7E7BD00C0C0C0005E5EE2FF0C0CEAFF6C6C
      F7FFFFFFFFFFFFFFFFFFFEFEFFFFA8A8FFFFD1D1FFFFFFFFFFFFFFFFFFFFFFFF
      FFFF6767FAFF0C0CF0FF6060E6FFC0C0C00000000000D0731BFFEFA95AFFF097
      32FFF4A03DFFF8AC51FFFBB765FFFFFFFFFFFFFFFFFFFFFFFFFFF8AC51FFF4A0
      3DFFF09732FFEA902AFFF0C18EFF0C06010F00000000000000001A1A1AFF0000
      00FF1A1A1AFFD08867FFD7906FFFDC9677FFE5A487FFF9E9E1FFF7DFD4FFE8A5
      87FFE39E7FFFDC9677FFE4B39DFFEDEDEDFFFFFFFF00FFFFFF00F7DFAD00DE9E
      0000DE960000DE9E0000E7A60000DE960000DEB66300CECFD600C6C7C600BDBE
      C600C6AE8C00CE962900C6790000EFCF9400C0C0C0007575E2FF5050F3FF0909
      F7FFB2B2FEFFFEFEFFFFB1B1FFFF7A7AFFFF8787FFFFDBDBFFFFFFFFFFFFC4C4
      FFFF1818FBFF5050F7FF7878E5FFC0C0C0000000000007040109F5C795FFF4A4
      48FFF8AA4DFFFBBA6BFFFDC888FFFFFFFFFFFFFFFFFFFFFFFFFFFBBA6BFFF8AA
      4DFFF39C38FFF4BA79FFE18224FF0000000000000000000000001C1C1CFF0000
      00FF1C1C1CFFD38C6CFFDB9475FFE39E7FFFECAB8EFFF1B49AFFF3B89EFFF1B4
      9AFFECAB8EFFE39E7FFFE7B6A1FFF4F4F4FFFFFFFF00FFFFFF00FFFFFF00EFD7
      8400DE9E0000DE960000DE9E0000E7A61000DE960000D6AE5A00E7E7E700F7F7
      FF00D6AE6B00C6710000CE860000F7E7C600C0C0C000C0C0C0006A6AECFF4444
      FBFF2929FFFF8E8EFFFF7A7AFFFFA0A0FFFFAAAAFFFF9595FFFFBABAFFFF4242
      FFFF4D4DFEFF6D6DEFFFC0C0C000C0C0C0000000000000000000824C1590FAD6
      ABFFFABC73FFFCC480FFFED5A4FFFEE1BDFFFEE1BDFFFED5A4FFFCC480FFF9B3
      5FFFF8C487FFF4A859FF000000000000000000000000000000001E1E1EFF0000
      00FF1E1E1EFFD68F6EFFDD9778FFE8A587FFF1B49AFFF8C1A8FFFAC5AEFFF8C1
      A8FFF1B49AFFE8A587FFE8B8A3FFFCFCFCFFFFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F7D78C00E7A60800DE960000DEA62100E7BE4A00E7A61800E7B64200F7D7
      9C00CE8E2100C6790000E7C77300FFFFFF00C0C0C000C0C0C000C0C0C0007777
      F4FF7A7AFFFF6767FFFF8383FFFFAAAAFFFFB7B7FFFF9999FFFF7C7CFFFF8888
      FFFF7D7DF6FFC0C0C000C0C0C000C0C0C0000000000000000000000000008552
      1D8AFDD3A3FFFEE1BEFFFEE3C1FFFFEBD4FFFFEAD3FFFEE0BAFFFEDAAFFFFDDF
      BAFFFEAC55FF0000000000000000000000000000000000000000202020FF0000
      00FF202020FFD99676FFE09D80FFEBAC91FFF4BCA3FFFAC9B2FFFFD1BCFFFAC9
      B2FFF4BCA3FFEBAC91FFE9BAA5FF00000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7EFBD00EFBE4200DE9E0000DEA62100EFC76B00E7B65200CE86
      0000CE8E0000EFCF8C00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C0009090F7FFA3A3FDFFB8B8FFFFC2C2FFFFC7C7FFFFC2C2FFFFACACFDFF9797
      F8FFC0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      000000000000CF934ECFFFDAADFFFFEDD9FFFFF1E0FFFFE6CAFFFFCB8CFF6648
      2666000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF7B391BFF7B391BFF7B391BFF7B391BFF7B391BFF7B391BFF7B39
      1BFF7B391BFF7B391BFF7B391BFF00000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFF700F7E7BD00EFCF7300E7BE5200E7BE6300E7BE
      6300F7DFB500FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000BFBFFCFFC0C0FDFFC2C2FDFFC4C4FDFFC0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000BF0000
      00FF000000FF7B391BFF7B391BFF7B391BFF7B391BFF7B391BFF7B391BFF7B39
      1BFF7B391BFF7B391BFF4822109600000000C0C0C000C0C0C000C0C0C000C0C0
      C000F7F7F700D6D7D600B5BEBD00ADBEB500CECFCE00EFEFEF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000DEE7
      DE0073A68C003196630021965A00108E4A00108642004A9E7300B5CFBD00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FF000000FF000000FF000000FF000000FF000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C7C600C6C7C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF00C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000EFEFEF00F7F7F700EFEFEF00F7FFFF00C0C0C000C0C0C000F7F7F700EFEF
      EF00EFF7F700F7F7F700C0C0C000C0C0C000C0C0C000C0C0C000B5DFC60039AE
      73004AB67B004AB684004AB684004AB6840031AE7300089E520000964A0073BE
      9400F7FFFF00C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000F7FFFF00EFF7F700F7F7F700C0C0C000C0C0C000C0C0C000C0C0C000EFF7
      F700EFF7F700F7FFFF00C0C0C000C0C0C000C0C0C000C6E7D60029A66B0042B6
      7B007BC7A500A5D7BD009CD7B50073C79C004AB6840042B6840010A66300009E
      52007BC79C00C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FF000000FF00
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6C7C60000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000FF000000
      FF000000FF0000FFFF0000000000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000CEC7BD00D6CFC600C0C0C000C0C0C000FFFFFF00C0C0C000E7E7
      DE00BDB6AD00F7F7EF00C0C0C000C0C0C000F7FFF70042AE7B006BC79C00F7FF
      F700C0C0C000C0C0C000C0C0C000C0C0C000DEEFE70063BE8C0039BE840000AE
      6B00009E5A00C6E7D600C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF00FF000000FF00
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000840000FFFF000000FF000000FF000000
      FF0000FFFF000086840000000000C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C0009C968C008471630084695A00BDB6AD00C0C0C000C0C0C000E7E7E7007361
      52008C796B008C797300C0C0C000C0C0C000B5DFC60073C79C00C0C0C000F7EF
      E700C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000F7FFF70052BE8C0010BE
      7B0000B66B0063C79400C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C7C60000000000C6C7C60000FF
      FF0000FFFF0000FFFF0000FFFF00008684000000FF000000FF000000FF0000FF
      FF0000FFFF0000000000FFFFFF00C6C7C600C0C0C000C0C0C000DEDFD600C6C7
      BD0073615A00B5A69C00A5968C0084796B00CEC7BD00C6BEB500A59E94006B61
      5200DECFC60073695A00C6BEB500D6D7CE00A5DFBD00E7F7EF00F7EFE700BD61
      2900E7CFB500C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00094D7B50000B6
      730000C7840021B67300D6EFE700C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C7C600FFFFFF000000000000FF
      FF0000FFFF0000FFFF0000FFFF000000FF000000FF000000FF000000FF0000FF
      FF000086840000000000C6C7C600C6C7C600C0C0C000E7DFDE005A4131005238
      2100AD9694006B5142007359520094797B00523018004A301800735952008C71
      6B00524131009C8E7B006B51390063493900DEF7EF00FFFFFF00CE794A00B551
      0800BD693100FFEFEF00C0C0C000C0C0C000C0C0C000E7F7EF0039BE7B0029CF
      9C0010D7940029CF940052C78400F7FFF700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C7C600C6C7C600FFFFFF000000
      000000FFFF00000084000000FF000000FF000000FF000000FF000000000000FF
      FF0000000000C6C7C600C6C7C600C6C7C600C0C0C000D6D7D600423021004220
      08004A38210063514200634942004A30180042281800422810004A3018006B59
      42006B594A005A4939004230100063493900C0C0C000DEA68400C6612100BD61
      1000BD611800D6966300FFFFF700C0C0C000C0C0C000C0C0C000ADE7C60052D7
      A5006BEFCE0042D79400CEEFDE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C7C600C6C7C600C6C7C6000000
      0000C6C7C6000000FF000000FF000000FF000000FF0000FFFF0000FFFF000000
      0000FFFFFF00C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000BDB6AD008471
      5A008C71630084715A0084715A008C7963008C79630084796B005A4931003928
      1000422810004A3018004A28100084716300FFF7F700DEA67B00CE713100C669
      2100C6692100D6966300F7EFE700C0C0C000C0C0C000C0C0C000C0C0C00073D7
      A5006BDFAD0094E7C600C0C0C000F7D7C600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FF000000FF000000FF000000FF000000FFFFFF00FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C7C600C6C7C600C6C7C600FFFF
      FF000000FF000000FF000000FF000000FF0000FFFF0000FFFF00008684000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000F7F7DE00E7B6
      2900E7BE2900E7B63100E7BE2900EFB62900E7B62900F7D78C00A5A69C00B5B6
      AD00C6C7C600C6C7BD006B514A00CEC7BD00C0C0C000C0C0C000DE8E5A00D686
      3900CE692100E7B69400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000E7F7
      EF0084DFB500C0C0C000EFD7BD00EFBEA500FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C7C600C6C7C600C6C7C600C6C7
      C6000000FF000000FF000000FF0000FFFF000000000000FFFF0000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000F7F7EF00E7C7
      6B00E7AE0800E7AE2100E7AE2100E7AE1800E7AE1000F7C76B00BDB6B500C0C0
      C000C0C0C000948E8400AD9E9400C0C0C000C0C0C000C0C0C000EFBE9400DE96
      5200D6864200D6793100F7CFB500C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000F7E7D600E78E5200F7E7D600FFFF0000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C7C600C6C7C600C6C7C6000000
      FF000000FF000000FF00C6C7C60000FFFF0000FFFF0000000000FFFFFF00C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000F7EFD600E7D7
      A500EFC75A00E7AE1800E7AE2100E7AE2100E7A61800F7CF7300ADA6A500B5AE
      A500A59E94009C968C00C0C0C000C0C0C000C0C0C000C0C0C000FFF7EF00E796
      5A00EFAE7300E7965200E7863900EFB68400FFEFDE00FFFFF700FFFFF700FFEF
      E700F7C7A500E7864200EFAE7B00C0C0C000FFFF0000FFFF0000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFF0000FFFF0000C6C7C600C6C7C6000000FF000000
      FF000000FF00FFFFFF000000000000FFFF000086840000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600F7FFF700C0C0C000EFEFBD00DEAE
      1000F7DFB500E7C75200E7AE0800E7AE1800D6A60800EFCF6300E7DFDE00B5B6
      AD00CEC7C600FFFFF700C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFDF
      C600F7A66B00F7BE9400F7B68400EFA66B00EF9E5A00EF9E6300EFA66B00EFA6
      6B00EFA66B00F7A67300FFFFF700C0C0C000FFFF0000FFFF0000FFFF0000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFF0000FFFF0000FFFF0000C6C7C6000000FF000000FF000000
      FF00C6C7C600C6C7C600FFFFFF000000000000000000C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000F7EFD600EFBE
      5200EFC75A00F7E7C600E7CF8400EFBE4A00E7BE4A00EFD79400C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000FFE7D600F7AE7300FFB68400FFCFA500FFCFA500FFCFA500FFC79C00F7AE
      7300F7BE8C00FFFFF700C0C0C000C0C0C00000FFFF0000FFFF00FFFF0000FFFF
      0000FFFFFF00FFFF0000FFFF0000FFFF0000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFF0000FFFF0000FFFF0000FFFF0000C6C7C600C6C7C6000000FF00C6C7
      C600C6C7C600C6C7C600C6C7C600FFFFFF00C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000FFD7BD00FFBE8C00FFB68400FFBE8C00FFC79C00FFE7
      D600C0C0C000C0C0C000C0C0C000C0C0C000FFFF000000FFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFFFF00FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0006B696B00424142004A49
      4A00B5B6B500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C0006361630052515200A5A6A5006B69
      6B0042414200DEDFDE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C00042414200A5A6A500FFFFFF00C0C0
      C00042414200BDBEBD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000000
      000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      00000000000000000000C0C0C000C0C0C0004A494A006B696B00DEDFDE009C9E
      9C0042414200C6C7C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00052515200525152005251
      5200525152005251520052515200525152005251520052515200525152005251
      5200525152005251520052515200C0C0C000C0C0C00000000000000000000000
      840000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      00000000840000008400C0C0C000C0C0C000B5B6B5004A494A00424142004241
      420084868400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000CECFCE00ADAEAD00ADAEAD00ADAE
      AD00ADAEAD00ADAEAD00ADAEAD00ADAEAD00ADAEAD00ADAEAD00ADAEAD00ADAE
      AD00ADAEAD00ADAEAD00ADAEAD00CECFCE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00C6C7C60042414200A5A6
      A500FFFFFF00FFFFFF00C6C7C6007371730073717300C6C7C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000424142005A595A00DEDF
      DE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A5A6A5004A494A004A494A004A49
      4A004A494A004A494A004A494A004A494A004A494A004A494A004A494A004A49
      4A004A494A004A494A004A494A00A5A6A500C6C7C6000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600FFFFFF00FFFFFF0042414200D6D7
      D600FFFFFF00C6C7C60042414200525152005251520042414200C6C7C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004A494A0042414200424142009496
      9400FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEDFDE006B696B0063616300CECF
      CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF004A494A009C9E9C00C6C7C600BDBE
      BD00BDBEBD00BDBEBD00BDBEBD00BDBEBD00BDBEBD00BDBEBD00BDBEBD00BDBE
      BD00BDBEBD00C6C7C6009C9E9C004A494A00C6C7C6000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600FFFFFF00FFFFFF00424142006361
      630073717300525152005A595A00EFEFEF00EFEFEF005A595A00525152007371
      73007B797B00B5B6B500FFFFFF00FFFFFF00636163004241420042414200C0C0
      C000FFFFFF00FFFFFF00FFFFFF00FFFFFF007B797B0042414200424142006361
      6300FFFFFF00FFFFFF00FFFFFF00FFFFFF004A494A00ADAEAD00DEDFDE00D6D7
      D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7
      D600D6D7D600DEDFDE00ADAEAD004A494A00C0C0C0000000000000000000C0C0
      C00000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000C0C0C00000008400C0C0C000C0C0C000FFFFFF00FFFFFF00B5B6B5007B79
      7B0073717300525152005A595A00EFEFEF00EFEFEF005A595A00525152007371
      73006361630042414200FFFFFF00FFFFFF00E7E7E700ADAEAD007B797B005A59
      5A00E7E7E700FFFFFF00FFFFFF00FFFFFF007B797B0042414200424142007371
      7300FFFFFF00FFFFFF00FFFFFF00FFFFFF004A494A00ADAEAD00D6D7D600D6D7
      D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7
      D600D6D7D600D6D7D600ADAEAD004A494A00C0C0C0000000000000000000C0C0
      C00000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000C0C0C00000008400C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C7C60042414200525152005251520042414200C6C7C600FFFF
      FF00D6D7D60042414200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007371
      73006B696B00FFFFFF00FFFFFF00ADAEAD00525152008C8E8C006B696B006361
      6300F7F7F700FFFFFF00FFFFFF00FFFFFF004A494A00ADAEAD00D6D7D600D6D7
      D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7
      D600D6D7D600D6D7D600ADAEAD004A494A00C0C0C0000000000000000000C0C0
      C00000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000C0C0C00000008400C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C6007B797B007B797B00C6C7C600FFFFFF00FFFF
      FF00A5A6A50042414200D6D7D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E7
      E700525152005A595A006B696B0052515200C6C7C600FFFFFF00EFEFEF005251
      52009C9E9C00FFFFFF00FFFFFF00FFFFFF004A494A00ADAEAD00D6D7D600D6D7
      D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7
      D600D6D7D600D6D7D600ADAEAD004A494A00C0C0C0000000000000000000C0C0
      C00000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000C0C0C00000008400C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008486
      840042414200424142004A494A00B5B6B500FFFFFF00FFFFFF00FFFFFF00FFFF
      FF006B696B0042414200424142007B797B00FFFFFF00FFFFFF00FFFFFF00BDBE
      BD0042414200D6D7D600FFFFFF00FFFFFF004A494A00ADAEAD00D6D7D600D6D7
      D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7
      D600D6D7D600D6D7D600ADAEAD004A494A00C0C0C00000000000000000000000
      840000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      00000000840000008400C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECFCE004241
      42009C9E9C00DEDFDE006B696B004A494A00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF006B696B00424142004241420084868400FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848684005A595A00ADAEAD00E7E7E7004A494A00ADAEAD00D6D7D600D6D7
      D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7D600D6D7
      D600D6D7D600D6D7D600ADAEAD004A494A00C0C0C000C0C0C000C0C0C0000000
      000000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BDBEBD004241
      4200C0C0C000FFFFFF00A5A6A50042414200FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00DEDFDE007B797B0084868400EFEFEF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A5A6A5004241420042414200636163004A494A00B5B6B500DEDFDE00DEDF
      DE00DEDFDE00DEDFDE00DEDFDE00DEDFDE00DEDFDE00DEDFDE00DEDFDE00DEDF
      DE00DEDFDE00DEDFDE00B5B6B5004A494A00C0C0C000C0C0C000C0C0C000C0C0
      C0000000FF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000FF00C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEDFDE004241
      42006B696B00A5A6A5005251520063616300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF009496940042414200424142004A494A004A494A008C8E8C00B5B6B500ADAE
      AD00ADAEAD00ADAEAD00ADAEAD00ADAEAD00ADAEAD00ADAEAD00ADAEAD00ADAE
      AD00ADAEAD00B5B6B5008C8E8C004A494A00C0C0C000C0C0C000C0C0C000C0C0
      C00000868400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000868400C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B5B6
      B5004A494A00424142006B696B00C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00DEDFDE005A595A0042414200C0C0C000ADAEAD004A494A004A494A004A49
      4A004A494A004A494A004A494A004A494A004A494A004A494A004A494A004A49
      4A004A494A004A494A004A494A00ADAEAD00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFF7F700CEC7AD00FFFFFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF004A494A00CECFCE00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000808080008080800C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C0008486420084864200C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000F7F7F700D6C78C00BDA65200F7EFEF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF0042414200C6C7C600C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00008080800BD790000734900000808
      0800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00084862100F7CFA50084864200C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000F7F7F700CEBE8C00F7CF6300CEB64A00F7EFEF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000A5A6A500A5A6A500A5A6A500A5A6
      A500B5B6B500F7F7F700C0C0C000FFFFFF0042414200C6C7C600C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00008080800BD790000DE96000052300000BD79
      000008080800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00084862100C6C74200F7CFA50084864200C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000F7F7F700CEBE8400E7C75A00F7C74A00CEAE4A00F7F7FF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00073717300525152005A595A004A49
      4A0042414200C6C7C600C0C0C000E7E7E70042414200C6C7C600C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C0000808080073007300DE960000DE960000523000009461
      0000080808007B797B00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00084862100C6C74200C6C74200C6C763008486
      4200C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000F7F7
      FF00CEBE8400E7C75200EFB64200EFB64200CEA64200C6BEA500CEC7AD00CEC7
      AD00CEC7AD00CEC7AD00C6BEA500E7DFD600C0C0C000C0C0C000C0C0C000A5A6
      A50042414200C6C7C600F7F7F7007B797B0042414200D6D7D600C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000080808003900BD0073007300DE960000DE960000523000009461
      0000080808006B696B007B797B00C0C0C000C0C0C000F7CFA500F7CFA500F7CF
      A500F7CFA500F7CFA500F7CFA500F7CFA500C6A64200C6A64200C6C74200C6C7
      630084864200C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000F7F7FF00CEBE
      8400E7BE5200EFB64A00E7AE4200E7AE4200EFB65200E7BE6300E7C76B00E7C7
      6B00E7C76B00E7C76B00DEBE5A00C6BE9400C0C0C000C0C0C000C0C0C000ADAE
      AD004241420094969400636163004A494A00BDBEBD00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000080808003900BD000000DE0073007300DE960000DE960000523000009461
      0000080808006B696B007B797B00C0C0C000C0C0C000F7CFA500C6C76300C6C7
      4200C6C74200C6C74200C6C74200C6C74200C6A64200C6A64200C6A64200C6C7
      4200C6C7630084864200C0C0C000C0C0C000C0C0C000F7F7FF00CEB68400E7BE
      5200EFBE5200E7AE4200E7AE4200E7AE4200E7AE4200E7B64200E7B64200E7B6
      4A00E7B64A00E7B64A00E7BE4A00CEC79C00C0C0C000C0C0C000C0C0C000ADAE
      AD0042414200424142005A595A00DEDFDE00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000808
      0800180052000000DE000000DE0073007300DE960000DE960000523000009461
      0000080808007B797B00C0C0C000C0C0C000C0C0C000F7CFA500C6C74200C6C7
      4200C6C74200C6C74200C6C74200C6C74200C6C74200C6C74200C6C74200C6C7
      4200C6C76300C6C7630084864200C0C0C000F7F7F700CEB68400E7C75A00EFBE
      5A00E7B64A00EFB64A00EFB64A00EFB64A00EFB64A00EFB64A00EFB64A00EFB6
      4A00EFB64A00EFB64A00E7BE5200CEC79C00C0C0C000C0C0C000C0C0C000D6D7
      D60042414200424142005A595A00E7E7E700DEDFDE00BDBEBD00BDBEBD00CECF
      CE00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000808080000DF
      DE00180052000000DE000000DE0073007300DE960000DE960000523000009461
      000008080800C0C0C000C0C0C000C0C0C000C0C0C000F7CFA500C6C76300C6C7
      6300C6C76300C6C76300C6C76300C6C76300C6C76300C6C76300C6C76300C6C7
      6300C6C76300F7CFA500F7CFA500C0C0C000F7F7F700CEB67B00F7D76B00FFD7
      6300FFC75A00FFC75200FFC75200FFC75200FFC75200FFC75200FFC75200FFC7
      5200FFC75200FFCF5A00EFC75A00CEC79C00C0C0C000D6D7D600E7E7E700C0C0
      C0009496940042414200424142007B797B00525152004A494A004A494A006361
      6300C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000808080000DFDE0000FF
      FF00180052000000DE000000DE0073007300DE960000DE960000523000009461
      000008080800C0C0C000C0C0C000C0C0C000C0C0C000F7CFA500C6C76300C6C7
      6300C6C76300C6C76300C6C76300C6C76300C6C76300C6C76300C6C76300C6C7
      6300F7CFA500F7CFA500C0C0C000C0C0C000C0C0C000F7F7F700CEBE8400F7D7
      6B00FFD76B00FFCF5A00FFCF5A00FFCF5A00FFCF6300FFCF6300FFD76300FFD7
      6300FFD76300FFD76300F7CF6300CEC7A500C0C0C000737173006B696B00FFFF
      FF00F7F7F70063616300424142004241420042414200C6C7C600C0C0C000F7F7
      F700C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000808080000FFFF000071
      7300180052000000DE000020730073007300DE960000BD790000523000009461
      000008080800C0C0C000C0C0C000C0C0C000C0C0C000F7CFA500F7CFA500F7CF
      A500F7CFA500F7CFA500F7CFA500F7CFA500C6C76300C6C76300C6C76300F7CF
      A500F7CFA500C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000F7F7F700CEBE
      8400F7D77300FFDF7300FFCF6300FFD76300FFD77300F7D77B00F7D77B00F7D7
      8400F7D78400F7D78400E7CF7B00C6BE9C00C0C0C000D6D7D600424142009496
      9400C0C0C000ADAEAD00424142004241420042414200CECFCE00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000080808000096940000DF
      DE0018005200002073000000BD0073007300BD79000094610000734900009461
      000008080800C0C0C000C0C0C000C0C0C000C0C0C00084864200848642008486
      420084864200848642008486420084864200F7CFA500F7CFA500F7CFA500F7CF
      A500C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000F7F7
      F700CEBE8400F7D77B00FFDF7B00FFDF7300CEB66300C6B69C00CEC7AD00CEC7
      AD00CEC7AD00CEC7AD00C6BEA500E7DFCE00C0C0C000C0C0C000ADAEAD004241
      42006361630063616300424142004241420042414200CECFCE00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000808080000DF
      DE00080808000000BD00003094007300730094610000BD790000BD7900007349
      000008080800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00084864200F7CFA500F7CFA500F7CFA500C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000F7F7F700CEBE8400F7DF8400FFEF9400CEB67300F7F7FF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00ADAE
      AD0063616300636163006B696B006B696B006B696B00BDBEBD00F7F7F700C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000808
      080008080800080808000000BD0008080800BD790000DE960000DE960000BD79
      000008080800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00084864200F7CFA500F7CFA500C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000F7F7F700CEBE8400F7E79400CEBE8C00F7EFEF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000949694004241420063616300E7E7
      E700C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000080808000808080008080800BD790000BD7900000808
      0800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00084864200F7CFA500C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000F7F7F700D6BE8C00BDA66300F7EFEF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF00525152004241420042414200C6C7
      C600C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000808080008080800C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00084864200C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFF7F700CEC7A500FFFFFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000ADAEAD005251520084868400F7F7
      F700C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7C600C6BEC600C6C7
      C600C6BEC600C6C7C600BDC7C600BDC7C600BDC7C600C6BEC600C6C7BD00C6C7
      C600BDC7C600BDBEC600BDC7C600C0C0C0000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000000
      0000000000000000000000000000000000000000080000000000000000000000
      0800080000000000000000000000C0C0C000C6C7C60008081000080008000800
      0800000000000000000000000000000000000808080000000000080000000800
      0000080800000800080010081000C0C0C0008486840000860000008600000086
      0000008600000086000000860000008600000086000000860000008600000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000BDBEBD0000000000EFEFEF00EFEF
      EF0000000000EFEFEF0000000000EFEFEF0000000000E7EFF70000000000EFEF
      EF0000000000EFF7EF00BDBEC600C0C0C000CECFD60000000800EFE7F700EFE7
      EF0000000000EFEFE70000000000EFEFEF0000000800E7E7EF0008080000E7E7
      EF0000080800E7E7F700E7E7EF00C0C0C0008486840000860000008600000086
      0000008600000086000000860000008600000086000000860000008600000086
      000000000000C6C7C600C6C7C600C6C7C600C0C0C00000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000BDB6BD0000000000F7EFF700EFEF
      EF0008080800D6D7D60000000800EFEFEF0008100800EFEFF70000080800E7EF
      EF0000080000E7EFEF00B5BEBD00C0C0C000CECFCE0008000800F7F7F700F7F7
      F70008080800D6CFD60000080800E7E7E70018101800EFE7EF0010080800FFEF
      F70008000800F7E7FF00F7EFF700C0C0C000C6C7C60084868400008600000086
      0000008600000086000000860000008600000086000000860000008600000086
      00000086000000000000C6C7C600C6C7C60000000000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDBEBD0000000000FFFFFF00EFEF
      F700EFEFEF00EFEFF70000000000EFEFF700EFEFEF00EFEFE70008081000F7EF
      EF00EFEFEF00F7F7F700C6CFB500C0C0C000CECFCE0000080000FFFFEF00EFEF
      E700EFEFEF00EFEFEF0000080000E7FFEF00F7EFEF00F7F7EF0008080000EFEF
      EF00E7EFE700EFEFF700F7F7EF00C0C0C000C6C7C60084868400008600000086
      0000008600000086000000860000008600000086000000860000008600000086
      0000008600000086000000000000C6C7C60000000000C0C0C000C0C0C000C0C0
      C0000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000000000B5B6B50000000000FFFFFF00EFEF
      EF00E7EFEF00EFF7EF00EFEFEF00FFFFFF00EFF7F700FFFFF700F7F7EF00F7EF
      F700EFEFFF00EFEFF700C6C7BD00C0C0C000C6CFD60000000800FFF7F700FFF7
      F700F7E7F700EFEFFF00D6DFE700EFFFFF00FFF7F700FFF7FF00FFEFF700F7EF
      FF00EFEFF700F7EFFF00EFEFEF00C0C0C0008486840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000086
      00000086000000860000008600000000000000000000C0C0C000C0C0C0000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000000000B5BEBD0000000000F7FFF700FFFF
      FF00FFFFFF00EFFFF700DEE7DE00F7F7F700F7FFEF00F7EFE700EFE7D600E7DF
      DE00F7F7FF00EFF7FF00B5B6B500C0C0C000D6CFCE0008000800F7F7FF00F7FF
      FF00FFFFFF00FFF7EF00DEEFDE00DEF7E700FFFFEF00EFEFDE00E7E7DE00DEDF
      D600FFFFFF00F7F7FF00EFEFEF00C0C0C000C6C7C60084868400008684000086
      8400008684000086840000868400008684000086840000868400008684000000
      0000848684008486840084868400C6C7C600C0C0C00000000000C0C0C0000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000000000B5BEB50008000000FFFFFF00F7FF
      F700FFFFF700E7CFC60008080000FFF7FF00FFFFEF0018080000211000001808
      0800F7EFF700EFEFF700EFF7EF00C0C0C000D6D7D60000000000F7FFFF00F7FF
      FF00FFFFFF00D6C7C60000100800EFFFF700FFFFE70021100000291000002108
      0000FFF7F700F7EFF700F7F7EF00C0C0C000C6C7C60084868400008684000086
      8400008684000086840000868400008684000086840000868400008684000086
      840000000000C6C7C600C6C7C600C6C7C600C0C0C000000000000000000000FF
      FF000000000000FFFF0000FFFF00008684000086840000FFFF000086840000FF
      FF000086840000FFFF0000FFFF0000000000B5BEB50000000000E7FFFF00E7F7
      EF00FFEFEF001008080000000000FFF7FF00FFFFEF00FFFFF700F7EFE7001000
      0000FFF7FF00EFEFF700C6C7C600C0C0C000C6CFCE0008100800F7FFFF00EFEF
      EF00F7E7E7001808100000000000F7F7FF00F7FFF700F7F7EF00F7E7EF000800
      0800F7F7FF00E7EFFF00E7EFF700C0C0C000C6C7C600C6C7C600848684000086
      8400008684000086840000868400008684000086840000868400008684000086
      84000086840000000000C6C7C600C6C7C600C0C0C000C0C0C000C0C0C0000000
      000000FFFF0000FFFF0000FFFF00008684000086840000FFFF00008684000086
      84000086840000FFFF0000FFFF0000000000B5B6B50008000800EFF7FF00F7FF
      FF00FFFFF700C69EA50000000000FFF7FF00F7F7F70000000000080808000000
      0800F7EFF700F7EFFF00BDBEBD00C0C0C000C6CFCE003130310000000000F7FF
      F700FFF7F700B5A6AD0008000800FFF7FF00EFFFEF0008080800100808001000
      0000F7EFF700F7EFFF00EFEFF700C0C0C000C6C7C600C6C7C600848684000086
      8400008684000086840000868400008684000086840000868400008684000086
      8400008684000086840000000000C6C7C600C0C0C000C0C0C000C0C0C0000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000000000ADBEBD0000000800EFF7FF00EFFF
      FF00FFF7FF00E7EFEF00F7F7F700FFF7FF00F7F7FF00EFEFFF00E7EFF700EFEF
      FF00FFF7FF00F7EFF700BDB6BD00C0C0C000CECFD600CECFD600313839000000
      0000FFF7F700FFEFF700E7E7EF00FFFFFF00EFFFF700E7F7F700E7EFEF00F7FF
      FF00F7F7FF00F7EFFF00EFF7F700C0C0C0008486840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000086
      840000868400008684000086840000000000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000000000B5BEBD0000000000F7EFF700EFEF
      EF00EFEFEF00F7EFEF00EFEFF700F7EFF700F7F7F700EFEFEF00EFEFF700EFEF
      F700EFEFEF00F7EFEF00EFEFEF00C0C0C000D6CFD600D6CFD600C6CFCE003130
      310008000000F7EFEF00EFF7F700E7E7EF00F7F7F700E7E7F700E7EFF700E7E7
      F700EFE7EF00FFEFFF00F7E7F700C0C0C000C6C7C60084868400C6C7C600C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000848684008486840084868400C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDB6B50000000000000000000000
      0000000000000000000000000000000000000000000008000000000000000000
      0000000000000000000000000000C0C0C000CECFD600D6CFD600CECFD600CECF
      D600393039000000000000000000000008000800000008000000000000000000
      0000080000000800000018101000C0C0C000C6C7C6008486840084868400C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000BDC7BD00C6C7C600C6CFCE00CED7
      D600D6CFCE00D6CFD600CECFCE00D6CFD600D6CFCE00CECFD600CECFD600CECF
      D600CED7D600CECFD600C6CFCE00C0C0C000C6C7C600C6C7C60084868400C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7C600C6C7C600C6C7C6008486
      8400848684008486840084868400848684008486840084868400848684008486
      8400848684008486840000000000C6C7C600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000FFFFFF00FFFFFF00C0C0
      C000FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000C6C7C6000000
      000000000000C6C7C6000000000000000000C6C7C600C6C7C600000000000000
      0000C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7C600000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C60000000000080808008C8E8C000000
      000000000000080808008C8E8C0000000000000000008C8E8C00080808000808
      08008C8E8C00080808000000000008080800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60084868400000000000000
      0000C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C600C6C7C6000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60084868400000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C6008C8E8C00C6C7C600C6C7C600C6C7
      C600C6C7C600BDBEBD00BDBEBD00C6C7C600C6C7C60084868400000000000000
      0000C6C7C600C6C7C60008080800BDBEBD00C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000000000008486
      8400C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C60000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000000000008486
      8400C6C7C60000000000C6C7C600C6C7C60008080800C6C7C600C6C7C600BDBE
      BD00BDBEBD00C6C7C600BDBEBD00BDBEBD00C6C7C60000000000000000007B79
      7B00BDBEBD00BDBEBD008C8E8C00BDBEBD00C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C000C0C0C000C0C0C000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600848684000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600848684000000000000000000C6C7
      C600C6C7C600C6C7C60000000000C6C7C60000000000C6C7C600BDBEBD00CECF
      CE00C6C7C600BDBEBD00C6C7C600C6C7C600848684000000000000000000C6C7
      C600CECFCE00BDBEBD0000000000CECFCE00C0C0C000C0C0C000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7
      C600C6C7C60000000000C6C7C600C6C7C600000000000000000084868400C6C7
      C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C60000000000C6C7C600C6C7C600000000000000000084868400C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C6009C9E9C00BDBEBD00C6C7C600BDBE
      BD00C6C7C60000000000BDBEBD00C6C7C60000000000000000007B797B00BDBE
      BD00BDBEBD00C6C7C60008080800C6C7C600C0C0C000C0C0C000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000848684000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000848684000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C6000000000008080800BDBEBD00C6C7C600BDBE
      BD00BDBEBD0000000000000000007B797B000000000000000000B5B6B500CECF
      CE00BDBEBD00C6C7C6008C8E8C00C6C7C600C0C0C00000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000C0C0C000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000000000000000000084868400C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000000000000000000084868400C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C6000000000008080800BDBEBD00BDBEBD00C6C7
      C600C6C7C6000000000000000000000000000000000084868400BDBEBD00BDBE
      BD00C6C7C600C6C7C60008080800C6C7C600C0C0C00000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000C0C0C00000000000C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000000000000000000000000000000000000000
      0000C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000000000000000000000000000000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C6008C8E8C00C6C7C600BDBEBD00C6C7
      C600BDBEBD000000000000000000000000000000000000000000000000000000
      0000C6C7C600BDBEBD0008080800BDBEBD00C0C0C00000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000C0C0C00000000000C6C7C600C6C7C600C6C7
      C600C6C7C600000000000000000000000000000000000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7
      C600C6C7C600000000000000000000000000000000000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C6000000000008080800BDBEBD00C6C7C600BDBE
      BD00C6C7C600000000000000000000000000000000000000000000000000BDBE
      BD00BDBEBD00CECFCE008C8E8C00C6C7C600C0C0C00000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000C0C0C000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C6000000000008080800C6C7C600BDBEBD00C6C7
      C600C6C7C6000000000000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600BDBEBD0000000800C6BEC600C0C0C000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7
      C600C6C7C60000000000000000000000000000000000C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C60000000000000000000000000000000000C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C60000000000C6C7C6009C969C00B5B6BD00C6C7C600BDBE
      BD00BDBEBD0000000000000000000000000000000000C6C7C600BDBEBD00C6C7
      C600BDBEBD0008080800B5B6B500C6C7C600C0C0C000C0C0C000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7
      C600C6C7C600000000000000000000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C60000000000C6C7C60000000000C6C7C600C6C7
      C600C6C7C600000000000000000000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000800B5B6B500C6C7
      C600B5B6B500000000000000000000000000C6C7C600B5B6B500C6C7C600BDBE
      BD0008080800B5B6B500B5B6B500BDBEC600C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      000000000000C0C0C000C0C0C000C0C0C000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7
      C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C60000000000C6C7C600C6C7C600BDBEBD00C6C7C60008000800BDBE
      BD00C6C7C6000000000000000000C6C7C600BDBEBD00CECFCE00BDBEBD000000
      0000B5B6B500BDBEBD00BDBEBD00BDBEC600C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7
      C600C6C7C60000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C600C6C7C6000000
      0000C6C7C60000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C60000000000C6C7C600C6C7C600C6C7C600C6C7CE00BDBEC600BDBEBD000808
      0800C6C7C60000000000BDBEBD00BDBEBD00C6C7C600BDBEBD0000000000B5B6
      B500CECFCE00BDBEBD00B5B6B500C6BEC600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00000000000C6C7C600000000000000
      0000C6C7C6000000000000000000C6C7C6000000000000000000C6C7C6000000
      000000000000C6C7C6000000000000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C6000000000000000000C6C7C6000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6BEC600BDBEBD00C6C7C600BDBE
      C6000800080000000000080808008C8E8C000000000008080800B5B6B500BDBE
      BD00C6C7C600C6BEC600BDBEBD00BDBEC600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600000000000000000000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600000000000000000000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000000000000000000000000000000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600000000008486
      8400C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600000000000000000000000000000000000000000000000000C6C7C600C6C7
      C600000000000000000000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600000000000000000000000000000000000000000000000000C6C7C600C6C7
      C600000000000000000000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C60000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60084868400000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600000000000000
      000084868400C6C7C600C0C0C000C6C7C600C0C0C00084868400000000000000
      00000000000000000000C6C7C600C6C7C600C6C7C600C6C7C600000000000000
      000084868400C6C7C600C0C0C000C6C7C600C0C0C00084868400000000000000
      00000000000000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C6000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000000000008486
      8400C6C7C600C6C7C600C6C7C600C6C7C600C6C7C6000000000084868400C6C7
      C600C6C7C600C0C0C000C6C7C600C0C0C000C6C7C600C0C0C000C6C7C6008486
      840000000000C6C7C600C6C7C600C6C7C600C6C7C6000000000084868400C6C7
      C600C6C7C600C0C0C000C6C7C600C0C0C000C6C7C600C0C0C000C6C7C6008486
      840000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600848684000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7
      C600C6C7C600C6C7C6000000000000000000C0C0C000C6C7C600C0C0C000C6C7
      C60000000000C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C6C7C600C0C0C000C6C7
      C60000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C60000000000C6C7C600C6C7C600000000000000000084868400C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C6000000000084868400C6C7C600C6C7
      C600C6C7C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7C600C0C0
      C0008486840000000000C6C7C600C6C7C6000000000084868400C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0
      C0008486840000000000C6C7C600C6C7C600C6C7C60000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000848684000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C6000000000000000000C6C7C600C6C7C600C0C0C000C6C7
      C600C0C0C00000000000C6C7C600C6C7C60000000000C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C6C7
      C600C0C0C00000000000C6C7C600C6C7C60000000000C0C0C000C0C0C000C0C0
      C00000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000000000000000000084868400C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C6000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C6C7C60000000000C6C7C600C6C7C60000000000C6C7C600C6C7C6000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C6C7C60000000000C6C7C600C6C7C60000000000C0C0C000C0C0C0000000
      000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000000000000000000000000000000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C6C7C6000000
      000000000000000000000000000000000000000000000000000000000000C6C7
      C600C0C0C00000000000C6C7C600C6C7C60000000000C6C7C600C6C7C6000000
      000000000000000000000000000000000000000000000000000000000000C6C7
      C600C0C0C00000000000C6C7C600C6C7C600C6C7C6000000000000000000C6C7
      C60000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600000000000000000000000000000000000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C0C0C000C6C7
      C600C6C7C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7C600C0C0
      C000C6C7C60000000000C6C7C600C6C7C60000000000C6C7C600C0C0C000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0
      C000C6C7C60000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C6000000
      0000C0C0C000C0C0C00000000000C0C0C000C0C0C00000000000C0C0C000C0C0
      C00000000000C0C0C000C0C0C00000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C6000000000084868400C0C0C000C0C0
      C000C6C7C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7C600C6C7
      C6008486840000000000C6C7C600C6C7C6000000000084868400C0C0C000C0C0
      C000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C6008486840000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C6000000
      0000C0C0C000C0C0C00000000000C0C0C000C0C0C00000000000C0C0C000C0C0
      C0000000000000000000C0C0C00000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C60000000000000000000000000000000000C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C0C0
      C000C0C0C000C0C0C0000000000000000000C6C7C600C6C7C600C6C7C600C6C7
      C60000000000C6C7C600C6C7C600C6C7C600C6C7C60000000000C6C7C600C0C0
      C000C0C0C000C0C0C000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C60000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C0C0
      C000C0C0C0000000000000000000C0C0C000C0C0C00000000000C0C0C000C0C0
      C00000000000C6C7C60000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600000000000000000000000000C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C6000000000084868400C6C7
      C600C0C0C000C0C0C000C0C0C000C0C0C000C6C7C600C6C7C600C6C7C6008486
      840000000000C6C7C600C6C7C600C6C7C600C6C7C6000000000084868400C6C7
      C600C0C0C000C0C0C000C0C0C000C0C0C000C6C7C600C6C7C600C6C7C6008486
      840000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C60000000000C0C0
      C000C0C0C0000000000000000000C0C0C000C0C0C00000000000C0C0C000C0C0
      C00000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600000000000000
      000084868400C6C7C600C6C7C600C6C7C600C6C7C60084868400000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600000000000000
      000084868400C6C7C600C6C7C600C6C7C600C6C7C60084868400000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C6000000
      000000000000C6C7C60000000000C0C0C000C0C0C00000000000000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C60000000000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600000000000000000000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600000000000000000000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00018516B00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00042084200C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000844142004A1818004A1818004A181800C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C0004A2818004A281800C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00018516B0018516B00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0004208
      420042084200C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000734142004A18
      18004A1818008C383100944139008C4139004A1818004A1818004A1818004A18
      18004A1818004A1818004A1818004A181800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C0004A281800EFE7E700EFE7E7004A281800C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00018516B003186AD0029618C00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000420842009C38
      8C0042084200420842004208420042084200C0C0C000734142008C383100AD49
      4200A5494200A54142009C414200944139004A181800EF797300EF797300EF79
      7300EF797300EF797300EF7973004A181800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0004A281800EFE7E7008418000084180000EFE7E7004A281800C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00029618C0018516B0018516B0018516B001879BD0018516B00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000B59E8C004A2818004A2818004A28
      18004A2818004A2818004A2818004A28180094694A0042084200B549AD00AD41
      A5009C388C008C307B007B28730042084200C0C0C00073414200B5494A00B549
      4A00AD494200AD494200A5414200944139004A18180000300000003000000030
      00000030000010410800EF7973004A181800C0C0C000C0C0C000C0C0C000C0C0
      C0004A281800EFE7E70084180000F7693100F761290084180000EFE7E7004A28
      1800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0002961
      8C0018516B003186AD003186AD003186AD003186AD001886C6003186AD001851
      6B00C0C0C000C0C0C000C0C0C000C0C0C000B59E8C00CEB6AD00A58E7B00A58E
      7B00A58E7B00A58E7B00A58E7B00D6BEAD0042084200C68EBD00B549AD00B549
      AD00AD41A5009C388C009430840042084200C0C0C00073414200BD514A00B549
      4A00B5494A00A54142009C413900944139004A18180000300000003000000030
      00000049000018511000EF7973004A181800C0C0C000C0C0C000C0C0C0004A28
      1800EFE7E70084180000B5795A00B5795A00B5795A00B5795A0084180000EFE7
      E7004A281800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00018516B003186
      AD003196CE0031A6E70031A6EF002996DE002196DE002196E700218ED6001886
      C60018516B00C0C0C000C0C0C000C0C0C000B59E8C00A58E7B00D6BEAD00D6BE
      AD00D6BEAD00D6BEAD00D6BEAD00D6BEAD00D6BEAD008C287B00C68EBD00B549
      AD00BD61AD00BD61AD00BD61AD0042084200C0C0C00073414200BD514A00BD51
      4A00B5515200D6A69C00844142008C3839004A18180000410000003000000041
      00000061080018591000EF7973004A181800C0C0C000C0C0C0004A281800EFEF
      E70084180000F7865200FFFFFF00FFFFFF00FFFFFF00FFFFFF00944929008418
      0000EFE7E7004A281800C0C0C000C0C0C000C0C0C00018516B003186AD004AB6
      EF004AB6EF004AB6EF0042B6EF000818210000102100299EEF002196E700218E
      DE001886C60018516B00C0C0C000C0C0C000B59E8C00E7D7CE00A58E7B00E7D7
      CE00E7D7CE00E7D7CE00E7D7CE00E7D7CE00E7D7CE00E7D7CE008C287B00C68E
      BD008C287B008C287B008C287B008C287B00C0C0C00073414200C6515200C651
      4A00D6A69C00FFEFEF00D6A69C008C4139004A18180000490000004100001051
      08000071100018511000EF7973004A181800C0C0C0004A281800EFE7E7008418
      0000F79E6B00F7966300F7865200FFFFFF00FFFFFF0094492900F7693100F761
      290084180000EFE7E7004A281800C0C0C00029618C003186AD0052C7EF005AC7
      EF005AC7EF0052C7EF0052BEEF0018495A0018415A0031A6EF00299EEF002196
      E700218EDE001879C60018516B00C0C0C000B59E8C00E7DFD600E7DFD600A58E
      7B00F7F7EF00F7F7EF00F7F7EF00F7F7EF00F7F7EF00F7F7EF00F7F7EF008C28
      7B008C287B0094694A00C0C0C000C0C0C000C0C0C00073414200CE515200C651
      5200C6595200D6A69C00B55152009C4142004A1818000049000073611000C68E
      290018590800C68E2900EF7973004A18180084180000F7F7F700BD410000FFB6
      8C00FFA67B00F79E6B00F7966300FFFFFF00FFFFFF0094492900F7713900F769
      3100F761290084180000EFE7E7004A28180018516B0052B6DE0063CFEF006BCF
      EF006BCFEF0063CFEF005AC7EF0052B6E70042AEE70039AEEF0031A6EF00219E
      EF002196E700218ED60018619C0029618C00B59E8C00F7F7EF00F7F7EF00A58E
      7B00A58E7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF0094694A00A58E7B00F7F7
      EF008C287B0094694A00C0C0C000C0C0C000C0C0C00073414200CE595200CE59
      5200C6515200C6515200BD514A009C4942004A18180052611000F7AE6300F7AE
      6300F7AE6300F7AE6300EF7973004A18180084180000FFFFFF00BD410000FFB6
      8C00FFB68C00FFA67B00F79E6B00FFFFFF00FFFFFF0094492900F7794200F771
      3900F769310084180000EFE7E7004A28180018516B006BCFE70073DFEF007BDF
      EF007BDFEF0073DFEF006BD7EF003986940021516B0042B6EF0031AEEF00299E
      EF002196E700218EDE001871AD0018516B00B59E8C00FFFFFF00A58E7B00BDE7
      FF00A5DFFF00A58E7B00A58E7B00A58E7B00A58E7B004AB6FF0039AEFF009469
      4A00F7F7EF004A281800C0C0C000C0C0C000C0C0C00073414200D6595A00D659
      5200CE595200C6515200C6515200A54942004A181800F7AE6300F7AE6300F7AE
      6300F7AE6300F7AE6300EF7973004A181800C0C0C00084180000FFFFF700BD41
      0000FFB68C00FFB68C00FFFFFF00FFFFFF00FFFFFF0094492900F7865200F779
      420084180000EFE7E7004A281800C0C0C00018516B0073D7E70084E7EF008CE7
      EF008CE7EF0084E7EF0073DFEF005AB6D6001028310021516B0039A6E70029A6
      EF002196E700218EDE001886C60018516B00B59E8C00A58E7B00D6EFFF00D6EF
      FF00BDE7FF00A5DFFF0094D7FF0084CFFF006BC7FF005ABEFF004AB6FF0039AE
      FF0094694A004A281800C0C0C000C0C0C000C0C0C00073414200DE595A00D659
      5A00D6595200CE595200C6515200A54942004A181800F7AE6300F7AE6300F7AE
      63009C9E8C00108EF700EF7973004A181800C0C0C000C0C0C00084180000FFFF
      FF00BD410000FFB68C00FFB68C00B5795A00B5795A00F7966300F78652008418
      0000EFE7E7004A281800C0C0C000C0C0C00018516B006BCFDE008CE7EF008CEF
      EF008CE7EF007BD7D60063B6C6006BCFE70039799400000000001851730031A6
      EF002196E700218EDE001871AD0018516B00B59E8C00D6EFFF00D6EFFF00D6EF
      FF00D6EFFF00BDE7FF00A5DFFF0094D7FF0084CFFF006BC7FF005ABEFF004AB6
      FF0039AEFF004A281800C0C0C000C0C0C000C0C0C00073414200DE595A00DE59
      5A00D6595A00D6595A00CE595200A54942004A181800F7AE6300F7AE63009C9E
      8C0010A6F700108EF700EF7973004A181800C0C0C000C0C0C000C0C0C0008418
      0000FFFFFF00BD410000FFB68C00FFFFFF00FFFFFF009449290084180000EFE7
      E7004A281800C0C0C000C0C0C000C0C0C00029618C004296AD008CE7EF008CEF
      EF008CEFEF0029494A00000000005AB6CE004AA6BD00000000000828390031A6
      EF002196E700218ED60018619C0029618C00C0C0C000B59E9400D6EFFF00D6EF
      FF00D6EFFF00D6EFFF00BDE7FF00A5DFFF0094D7FF0084CFFF006BC7FF005ABE
      FF005A382900C0C0C000C0C0C000C0C0C000C0C0C00073414200D6595A00DE59
      5A00DE595A00D6595A00D6595A00AD4942004A181800F7AE63009C9E8C0008B6
      F70008B6F70010A6F700EF7973004A181800C0C0C000C0C0C000C0C0C000C0C0
      C00084180000FFFFFF00BD410000FFFFFF00FFFFFF0084180000EFE7E7004A28
      1800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00018516B004A96AD0084DF
      E7008CE7EF00529694001020210031616B00082021000008100029719C0031A6
      EF00218EDE001879C60018516B00C0C0C000C0C0C000C0C0C000B5A69400D6EF
      FF00D6EFFF00D6EFFF00D6EFFF00BDE7FF00A5DFFF0094D7FF0084CFFF004A28
      1800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0009C514A007341
      4200B5514A00B5514A00C6515200A54942004A18180073414200734142007341
      420073414200734142007341420073414200C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00084180000FFFFF700BD410000BD410000EFE7E7004A281800C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00029618C001851
      6B0063B6C6006BCFDE0052A6BD004296AD00398EAD003996BD00319ED6002179
      BD0018516B0029618C00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000B59E
      8C00D6EFFF00D6EFFF00D6EFFF00D6EFFF00BDE7FF00A5DFFF004A281800C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0009C514A0073414200B5514A00B5514A004A181800C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00084180000FFFFFF00F7F7F7004A281800C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00029618C0018516B0018516B0018516B0018516B0018516B0018516B002961
      8C00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000B59E8C00B59E8C00B59E8C00B59E8C00B59E8C00B59E8C00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C0009C514A007341420073414200C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C0008418000084180000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00010181800C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00084868400848684008486840084868400848684008486
      840084868400848684008486840084868400C0C0C000C0C0C000C0C0C0008486
      8400848684008486840084868400848684008486840084868400848684008486
      840084868400848684008486840084868400C0C0C00010181800004973001018
      1800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0007341
      420073414200C0C0C000C0C0C000C0C0C000946142008C5942007B4129007338
      21006328100063281000C0C0C000C0C0C000C0C0C000946142008C5942007B41
      2900733821006328100063281000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00084868400C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C60084868400C0C0C000C0C0C000C0C0C000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600848684000049730042BEF7001896C6000049
      730010181800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00073414200CE96
      9400EFD7D600C6616300C0C0C000C0C0C00094614200FFFFFF00DEBEA500BD8E
      73009459390063281000C0C0C000C0C0C000C0C0C00094614200FFFFFF00DEBE
      A500BD8E73009459390063281000C0C0C000C0C0C000C0C0C000C0C0C0008486
      840084868400FF000000C6C7C600FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFF
      FF0000FFFF00FFFFFF00C6C7C60084868400C0C0C000C0C0C000C0C0C000C6C7
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C60084868400C0C0C0000049730042BEF7001896
      C6000049730010181800C0C0C000C0C0C000C0C0C00073414200CE969400F7EF
      EF00C6616300C0C0C000C0C0C000C0C0C00094614200FFFFFF00DEBEA500BD8E
      7300A561420063281000C0C0C000C0C0C000C0C0C00094614200FFFFFF00DEBE
      A500BD8E7300A561420063281000C0C0C000C0C0C000C0C0C00084868400FF00
      0000FF000000FF000000C6C7C600FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C60084868400C0C0C000C0C0C000FF000000C6C7
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C60084868400C0C0C000C0C0C0000049730042BE
      F7001896C6000049730010181800C0C0C00073414200CE969400F7EFEF00C661
      6300C0C0C000C0C0C000C0C0C000C0C0C00094614200FFFFFF00DEBEA500BD8E
      7300A561420063281000C0C0C000C0C0C000C0C0C00094614200FFFFFF00DEBE
      A500BD8E7300A561420063281000C0C0C000C0C0C00084868400FF000000FF00
      0000FF000000FF000000C6C7C600FFFFFF0000FFFF0084868400848684008486
      8400C6C7C600FFFFFF00C6C7C60084868400C0C0C000FF000000848684008486
      8400848684008486840084868400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C60084868400C0C0C000C0C0C000C0C0C0000049
      730042BEF7001896C6000049730073414200CE969400F7EFEF00C6616300C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00094614200FFFFFF00DEBEA500BD8E
      7300A561420063281000C0C0C000C0C0C000C0C0C00094614200FFFFFF00DEBE
      A500BD8E7300A561420063281000C0C0C000C0C0C00084868400FF000000FF00
      0000FF000000FF000000C6C7C600FFFFFF0084868400FF000000FF000000FF00
      000084868400FFFFFF00C6C7C6008486840084868400FF000000848684008486
      8400FF000000FF000000FF000000FF00000084868400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C60084868400C0C0C000C0C0C000C0C0C000C0C0
      C0000049730042BEF70073414200CE969400F7EFEF00C6616300C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000946142008C5131008C5131007B38
      18007B381800632810006328100052281000946142008C5131008C5131007B38
      18007B3818006328100063281000C0C0C00084868400FF000000FF000000FF00
      0000FF000000FF000000C6C7C600FFFFFF0084868400C6C7C60084868400FF00
      000084868400FFFFFF00C6C7C60084868400848684008486840084868400FF00
      0000FF000000C6C7C600C6C7C60084868400FF00000084868400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C60084868400C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00073414200CE969400F7EFEF00C661630010181800C0C0C000C0C0
      C000C0C0C000C661630073414200C0C0C000D6B6940094614200E7CFBD00E7CF
      BD00BD8E6B0094593900632810008C51310094614200E7CFBD00E7CFBD00BD8E
      6B00945939006328100073414200C0C0C00084868400FF000000FF000000FF00
      00008486840084868400C6C7C600FFFFFF0084868400FFFFFF00C6C7C6008486
      840084868400FFFFFF00C6C7C6008486840084868400C6C7C60084868400FF00
      000084868400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C60084868400C0C0C000C0C0C000C0C0C000C0C0
      C00073414200CE969400F7EFEF00C66163001896C6000049730010181800C0C0
      C000C0C0C000C6616300FFFFFF0073414200C0C0C00094614200FFFFFF00EFE7
      DE00EFC7B5009459390063281000BD86730094614200FFFFFF00EFE7DE00EFC7
      B5009459390073414200C0C0C000C0C0C00084868400FF000000FF0000008486
      84008486840084868400C6C7C600FFFFFF0000FFFF0084868400848684008486
      8400C6C7C600FFFFFF00C6C7C60084868400C0C0C0008486840000FFFF00FF00
      0000FF000000FF000000FF000000FF000000FF00000084868400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C60084868400C0C0C00073414200734142007341
      4200CE969400F7EFEF00C66163000049730042BEF7001896C600734142007341
      42006B4931006B594A00C6616300C6616300C0C0C000C0C0C000946142008C51
      31007B41290063281000632810008C513100946142008C5131007B4129006328
      100063281000C0C0C000C0C0C000C0C0C00084868400FF000000FF0000008486
      84008486840084868400C6C7C600FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFF
      FF0084868400848684008486840084868400C0C0C000C0C0C0008486840000FF
      FF00FF000000FFFFFF00FFFFFF0084868400FF00000084868400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C6008486840073414200F7EFEF00E7C7C600CE96
      9400EFD7D600C6616300C0C0C000C0C0C00000497300C6616300E7C7C600D6A6
      A500CE9694006B594A00C0C0C000C0C0C000C0C0C000C0C0C00094614200FFFF
      FF00D6B69C009459390063281000C0C0C00094614200FFFFFF00D6B69C009459
      390063281000C0C0C000C0C0C000C0C0C00084868400FF000000FF000000C6C7
      C6008486840084868400C6C7C600FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C7C600FFFFFF00C6C7C600C0C0C000C0C0C000C0C0C000C0C0C0008486
      840000FFFF00FF000000FF000000FF00000084868400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C6008486840073414200C6616300C6616300C661
      6300E7C7C600C6616300C0C0C000C0C0C000C0C0C000C6616300F7EFEF00E7C7
      C600D6A6A500C6616300C0C0C000C0C0C000C0C0C000C0C0C000946142008C51
      31007B412900632810008C513100C0C0C000946142008C5131007B4129006328
      10008C513100C0C0C000C0C0C000C0C0C000C0C0C000C6C7C600FF000000FF00
      0000FFFFFF00C6C7C600C6C7C600FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFF
      FF00C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7
      C600FF000000FF000000FF00000084868400FFFFFF00FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C7C6008486840073414200C0C0C000C0C0C000C661
      6300E7C7C600C6616300C0C0C000C0C0C000C0C0C000C6616300FFFFFF00F7EF
      EF00C6616300C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0009461
      4200FFFFFF0063281000C0C0C000C0C0C000C0C0C00094614200FFFFFF006328
      1000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7C600FF000000FFFF
      FF00C6C7C600FFFFFF00C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C60084868400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7
      C600FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FFFFFF00FFFFFF00FFFF
      FF0084868400848684008486840084868400C0C0C000C0C0C000C0C0C0007341
      4200F7EFEF00C6616300C0C0C0007341420073414200EFD7D600FFFFFF00C661
      6300C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0009461
      4200946142008C513100C0C0C000C0C0C000C0C0C00094614200946142008C51
      3100C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7C600FF00
      0000FF000000C6C7C600FFFFFF00C6C7C6008486840084868400848684008486
      840084868400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C7C600FFFFFF00C6C7C600C0C0C000C0C0C000C0C0C000C6616300C661
      6300C6616300C0C0C000C6616300C6616300C6616300C6616300C6616300C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7
      C600C6C7C600FF000000FF000000FFFFFF00C6C7C60084868400848684008486
      8400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C7C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B004A28
      18004A2818004A2818004A2818004A2818004A2818004A2818004A2818004A28
      18004A2818004A2818004A281800C0C0C000C0C0C000C0C0C000BD9E8C004A28
      18004A2818004A2818004A2818004A2818004A2818004A2818004A2818004A28
      18004A2818004A2818004A281800C0C0C000C0C0C00031417B0008204200A58E
      7B004A2818004A2818004A2818004A2818004A2818004A2818004A2818004A28
      18004A2818004A2818004A2818004A281800C0C0C0001896C600004173000041
      7300004173000041730000417300004173000041730000417300004173000041
      730000417300004173000041730000417300C0C0C000C0C0C000A58E7B00EFDF
      DE00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E
      7B00A58E7B00A58E7B004A281800C0C0C000C0C0C000C0C0C000BD9E8C00EFDF
      DE00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E
      7B00A58E7B00A58E7B004A281800C0C0C00031417B003179DE0031417B000820
      4200EFDFDE00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E
      7B00A58E7B00A58E7B00A58E7B004A281800C0C0C0001896C600A5DFFF00A5DF
      FF00A5DFFF00A5DFFF00A5DFFF0094D7F7007BC7EF0063BEE70052B6DE0042AE
      D60031A6CE002196C6001896C60000417300C0C0C000C0C0C000A58E7B00EFE7
      DE00EFDFDE00E7DFD600E7D7CE00DECFC600DECFC600D6C7BD00D6BEB500D6BE
      AD00D6BEAD00A58E7B004A281800C0C0C000C0C0C000C0C0C000BD9E8C00EFE7
      DE00EFDFDE00E7DFD600E7D7CE00DECFC600DECFC600D6C7BD00D6BEB500D6BE
      AD00D6BEAD00A58E7B004A281800C0C0C0002186DE0084CFF7002971D6003141
      7B0008204200EFDFDE00E7DFD600E7D7CE00DECFC600DECFC600D6C7BD00D6BE
      B500D6BEAD00D6BEAD00A58E7B004A281800C0C0C0001896C600A5DFFF000049
      7300A5DFFF0000497300A5DFFF000049730094D7F7000049730063BEE7000049
      730042AED600004973002196C60000417300C0C0C000C0C0C000A58E7B00F7EF
      E700EFE7DE00EFDFDE00E7DFD600E7D7CE00DECFC600DECFC600D6865200D686
      5200D6BEAD00A58E7B004A281800C0C0C000C0C0C000C0C0C000BD9E8C00F7EF
      E700EFE7DE004A2818004A2818004A2818004A2818004A281800D6C7BD00D6BE
      B500D6BEAD00A58E7B004A281800C0C0C000C0C0C0002186DE0084CFF7004A79
      BD008479840094696B0094696B0094696B0094696B00DECFC600DECFC60000A6
      10000041000000410000A58E7B004A281800C0C0C0001896C6001896C6000061
      94001896C600006194001896C600006194001896C600006194001896C6000061
      94001896C600006194001896C6001896C600C0C0C000C0C0C000A58E7B00F7EF
      EF00F7EFE700EFE7DE00EFDFDE00E7DFD600E7D7CE00DECFC600DECFC600D6C7
      BD00D6BEB500A58E7B004A281800C0C0C000C0C0C000C0C0C000BD9E8C00F7EF
      EF00F7EFE7004A281800FFFFFF005269FF005269FF004A281800DECFC600D6C7
      BD00D6BEB500A58E7B004A281800C0C0C000C0C0C000C0C0C0002186DE009C9E
      A50094696B006BD794009CE7BD006BD79400FFF7D60094696B00DECFC60000A6
      10004AF7840000410000A58E7B004A281800BD4942007B2000007B2000007B20
      00007B2000007B2000007B2000007B2000007B2000007B2000007B200000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00F7F7
      F700DE966B00DE966300DE966300DE8E5A00DE8E5A00E7D7CE00D6865200D686
      5200D6C7BD00A58E7B004A281800C0C0C000C0C0C000C0C0C000BD9E8C00F7F7
      F700F7EFEF004A2818005269FF000018F7003141FF004A281800DECFC600DECF
      C600D6C7BD00A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0C0009469
      6B00EFD7AD006BD794006BD794006BD79400FFFFF700FFFFEF0094696B0000A6
      100000A6100000A61000A58E7B004A281800BD494200EF9E5A00EF8E4A00E786
      4200E7793900E7712900080808008441420084414200BD494200C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00F7F7F700F7EFEF00F7EFE700EFE7DE00EFDFDE00E7DFD600E7D7CE00DECF
      C600DECFC600A58E7B004A281800C0C0C000C0C0C000C0C0C000BD9E8C00FFFF
      FF00F7F7F7004A2818000018F700FFFFFF000018F7003141FF00E7D7CE00DECF
      C600DECFC600A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0C0009469
      6B00FFE7B500FFD79400FFBE8C00FFEFCE00FFF7DE00FFEFCE0094696B00E7D7
      CE009C300000DECFC600A58E7B004A281800BD494200F7A66B007B2000007B20
      00007B2000007B200000BD868400FFFFF7000086BD0008080800C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00DE9E6B00DE966B00DE966B00DE966300DE966300EFDFDE00DE8E5A00D68E
      5A00DECFC600A58E7B004A281800C0C0C000C0C0C000C0C0C000BD9E8C00FFFF
      FF00FFFFFF004A2818004A2818004A2818004A2818000018F7003141FF00E7D7
      CE00DECFC600A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0C0009469
      6B00F7EFBD00FFDFB500FFBE8C00FFBE8C00FFBE8C00FFBE8C0094696B009C30
      00009C300000DECFC600A58E7B004A281800BD494200F7B67B007B200000C0C0
      C000BD494200EF8E4200BD8684000086BD0031AED6000086BD0008080800C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFF7F700F7F7EF00F7EFEF00EFE7E700EFE7DE00E7DF
      D600E7D7CE00A58E7B004A281800C0C0C000C0C0C000C0C0C000BD9E8C00FFFF
      FF00FFFFFF00FFFFFF00FFF7F700F7F7EF00F7EFEF00EFE7E7000018F700E7DF
      D600E7D7CE00A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0C0009469
      6B00E7D7BD00FFFFFF00FFE7B500FFCF8C00FFBE8C00F7E7B50094696B00EFE7
      DE00E7DFD600E7D7CE00A58E7B004A281800BD494200F7B67B007B200000BD49
      4200EF9E6300EF965200BD4942000086BD007BDFF70031AED6000086BD000808
      0800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00DE9E6B00DE9E6B00DE9E6B00DE966B00DE966B00F7EFEF00DE966300DE8E
      5A00E7DFD600A58E7B004A281800C0C0C000C0C0C000C0C0C000BD9E8C00FFFF
      FF00FFFFFF004A2818004A2818004A2818004A2818004A281800EFE7E700EFE7
      DE00E7DFD600A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0C000A58E
      7B0094696B00E7D7C600FFEFBD00FFE7B500EFD7AD0094696B00F7EFEF00EFE7
      E700EFE7DE00E7DFD600A58E7B004A281800BD494200F7B67B00BD494200F7B6
      7B00F7AE6B00BD494200C0C0C000C0C0C0000086BD007BDFF70031AED6000086
      BD0008080800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7F7EF00F7EFEF00EFE7
      E700A58E7B00A58E7B004A281800C0C0C000C0C0C000C0C0C000BD9E8C00FFFF
      FF00FFFFFF004A281800FFFFFF005269FF005269FF004A281800F7EFEF00EFE7
      E700CEAE9C00A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0C000A58E
      7B00FFFFFF0094696B0094696B0094696B0094696B001030FF0000087300F7EF
      EF00EFE7E700A58E7B00A58E7B004A281800BD494200F7B67B00F7B67B00F7B6
      7B00BD494200C0C0C000C0C0C000C0C0C000C0C0C0000086BD007BDFF70031AE
      D6000086BD0008080800C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00DE9E6B00DE9E6B00DE9E6B00DE9E6B00DE9E6B00FFF7F700F7F7EF00A58E
      7B004A2818004A2818004A281800C0C0C000C0C0C000C0C0C000BD9E8C00FFFF
      FF00FFFFFF004A2818005269FF000018F7003141FF004A281800F7F7EF00BD9E
      8C004A2818004A2818004A281800C0C0C000C0C0C000C0C0C000C0C0C000A58E
      7B00FFFFFF00FFFFFF00FFFFFF000010AD006371FF003959FF001030FF000008
      7300A58E7B004A2818004A2818004A281800BD494200F7B67B00F7B67B00BD49
      4200C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000086BD007BDF
      F70031AED6006361630000008400C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700A58E
      7B00EFE7DE00D6BEAD004A281800C0C0C000C0C0C000C0C0C000BD9E8C00FFFF
      FF00FFFFFF004A2818000018F700FFFFFF000018F7003141FF00FFF7F700BD9E
      8C00EFE7DE00D6BEAD004A281800C0C0C000C0C0C000C0C0C000C0C0C000A58E
      7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF000010AD006371FF000010AD00FFF7
      F700A58E7B00EFE7DE00D6BEAD004A281800BD494200F7B67B00BD494200C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000086
      BD00C6A694005A7184000000840000008400C0C0C000C0C0C000A58E7B00FFFF
      FF00DE9E6B00DE9E6B00FFFFFF00DE9E6B00DE9E6B00FFFFFF00DE9E6B00A58E
      7B00D6BEAD004A281800C0C0C000C0C0C000C0C0C000C0C0C000BD9E8C00FFFF
      FF00FFFFFF004A2818004A2818004A2818004A2818000018F7003141FF00BD9E
      8C00D6BEAD004A281800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E
      7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000010AD00FFFFFF00FFFF
      FF00A58E7B00D6BEAD004A281800C0C0C000BD494200BD494200C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000018F7005271FF000018F70000008400C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A58E
      7B004A281800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000BD9E8C00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000018F700BD9E
      8C004A281800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E
      7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A58E7B004A281800C0C0C000C0C0C000BD494200C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000018F7000018F700C0C0C000C0C0C000C0C0C000A58E7B00A58E
      7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E
      7B00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000BD9E8C00BD9E
      8C00BD9E8C00BD9E8C00BD9E8C00BD9E8C00BD9E8C00BD9E8C00BD9E8C00BD9E
      8C00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E
      7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E
      7B00A58E7B00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0004A2818004A28
      18004A2818004A2818004A2818004A2818004A2818004A2818004A2818004A28
      18004A2818004A2818004A281800C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000B54918008C2000008C2000008C2000008C2000008C20
      00008C2000008C200000C0C0C000C0C0C000C0C0C000B59E8C00F7EFE700A58E
      7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E
      7B00A58E7B00A58E7B00A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000840000008400000084000000840000008400000084000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008C1800008C18
      00008C1800008C180000B5491800FFC78C00FFC78C00FFC78C00FFBE7B00FFAE
      6300FF9E39008C200000C0C0C000C0C0C000C0C0C000B59E8C00F7F7EF00F7EF
      E700EFE7E700EFE7DE00E7DFD600E7D7CE00E7D7CE00DECFC600DEC7BD00D6C7
      B500D6BEB500D6BEAD00A58E7B004A2818000000000000000000000000000000
      000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008C180000C0C0
      C000C0C0C000C0C0C000B5491800B5491800B5491800B5491800B5491800B549
      1800B5491800B5491800C0C0C000C0C0C000C0C0C000B59E8C00FFF7F700F7F7
      EF00F7EFE700841800008418000084180000E7D7CE00E7D7CE00841800008418
      000084180000D6BEB500A58E7B004A28180000000000FFFFFF00000000000000
      000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FFFF
      FF00000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008C180000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000B59E8C00FFFFFF00FFF7
      F700F7F7EF00F7EFE70084180000EFE7DE00E7DFD600E7D7CE00E7D7CE008418
      0000DEC7BD00D6C7B500A58E7B004A28180000000000FFFFFF00000000000000
      000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FFFF
      FF00000000000000000000000000C0C0C0000000000000000000000000008486
      840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000848684000000000000000000C0C0C000C0C0C000C0C0C0008C180000C0C0
      C000C0C0C000C0C0C000B54918008C2000008C2000008C2000008C2000008C20
      00008C2000008C200000C0C0C000C0C0C000C0C0C000B59E8C00108610000071
      000010860800F7F7F70042A64200841800008418000084180000841800008418
      0000DECFC600DEC7BD00A58E7B004A2818000000000000000000000000000000
      0000000000000000000000000000C0C0C0000000000000000000000000000000
      0000000000000000000000000000C0C0C00084868400FFFFFF00FFFFFF000000
      0000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0C0008C1800008C18
      00008C1800008C180000B5491800FFC78C00FFC78C00FFC78C00FFBE7B00FFAE
      6300FF9E39008C200000C0C0C000C0C0C000C0C0C000B59E8C00C6E7C6000079
      0000EFF7EF00FFFFF700F7F7F70008860800841800009CC79400EFDFDE008418
      0000E7D7CE00DECFC600A58E7B004A2818000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000C0C0C00084868400FFFFFF0000000000FFFF
      FF000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0C0008C180000C0C0
      C000C0C0C000C0C0C000B5491800B5491800B5491800B5491800B5491800B549
      1800B5491800B5491800C0C0C000C0C0C000C0C0C000B59E8C00FFFFFF0052B6
      52008CCF8C00FFFFFF00B5DFAD00007100002996290084180000EFE7DE008418
      0000E7DFD600E7D7CE00A58E7B004A2818000000000000000000FFFFFF000000
      00000000000000000000C0C0C0000000000000000000FFFFFF00000000000000
      0000000000000000000000000000C0C0C00084868400FFFFFF00000000000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0C0008C180000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000B59E8C00FFFFFF00CEEF
      CE00007100000071000000710000007100008CC78400F7EFEF00841800008418
      0000EFDFDE00E7DFD600A58E7B004A2818000000000000000000FFFFFF000000
      00000000000000000000C0C0C0000000000000000000FFFFFF00000000000000
      0000000000000000000000000000C0C0C00084868400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0C0008C180000C0C0
      C000C0C0C000C0C0C000B54918008C2000008C2000008C2000008C2000008C20
      00008C2000008C200000C0C0C000C0C0C000C0C0C000B59E8C00FFFFFF00FFFF
      FF0029962900C6E7C6000079000000790000EFF7EF00F7F7F700F7EFEF008418
      0000EFE7DE00EFDFDE00A58E7B004A281800C0C0C00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C00084868400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0C0008C1800008C18
      00008C1800008C180000B5491800FFC78C00FFC78C00FFC78C00FFBE7B00FFAE
      6300FF9E39008C200000C0C0C000C0C0C000C0C0C000B59E8C00FFFFFF00FFFF
      FF0094D79400188E18000071000042A64200FFFFFF00FFFFF700F7F7F700F7EF
      EF00EFEFE700EFE7DE00A58E7B004A281800C0C0C000C0C0C00000000000FFFF
      FF00000000000000000000000000C0C0C00000000000FFFFFF00000000000000
      000000000000C0C0C000C0C0C000C0C0C00084868400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF0000000000FFFFFF000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0C0008C180000C0C0
      C000C0C0C000C0C0C000B5491800B5491800B5491800B5491800B5491800B549
      1800B5491800B5491800C0C0C000C0C0C000C0C0C000B59E8C00FFFFFF00FFFF
      FF00FFFFFF000886080000710000ADDFAD00FFFFFF00FFFFFF00FFFFF700F7F7
      F700F7EFEF00EFEFE700A58E7B004A281800C0C0C000C0C0C000000000000000
      0000000000000000000000000000C0C0C0000000000000000000000000000000
      000000000000C0C0C000C0C0C000C0C0C00084868400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0C0008C180000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000B59E8C00FFFFFF00FFFF
      FF00FFFFFF005AB65A0008860800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFF7F700F7F7EF00A58E7B004A281800C0C0C000C0C0C000C0C0C0000000
      00000000000000000000C0C0C000C0C0C000C0C0C00000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C00084868400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C0C0C000B54918008C1800008C1800008C18
      00008C1800008C1800008C1800008C180800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000B59E8C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFF7F700F7F7EF004A281800C0C0C000C0C0C000C0C0C0000000
      0000FFFFFF0000000000C0C0C000C0C0C000C0C0C00000000000FFFFFF000000
      0000C0C0C000C0C0C000C0C0C000C0C0C00084868400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C0C0C000B5491800FFC78C00FFC78C00FFC7
      8C00FFBE7B00FFAE6300FF9E39008C180000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000B59E8C00B59E
      8C00B59E8C00B59E8C00B59E8C00B59E8C00B59E8C00B59E8C00B59E8C00B59E
      8C00B59E8C00B59E8C00B59E8C00C0C0C000C0C0C000C0C0C000C0C0C0000000
      00000000000000000000C0C0C000C0C0C000C0C0C00000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C0008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000840000008400000084000000C0C0C000B5491800B5491800B5491800B549
      1800B5491800B5491800B5491800B5491800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000840000008400000084000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      000000000000C0C0C000C0C0C0000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000840000008400
      000084000000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00084000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008400
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00084000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      000000000000C0C0C000C0C0C0000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      000000000000C0C0C000C0C0C0000000000000000000C0C0C000840000008400
      0000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000084000000
      840000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000008400C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      8400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000008400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      000000000000C0C0C000C0C0C0000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000084000000
      8400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      00000000000000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000000000000000000084868400C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000084868400C0C0C000848684000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000848684000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000000000000000000084868400C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000848684000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000084868400C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000848684000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000000084868400C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000C0C0C0000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000084868400848684008486840084868400848684008486
      840084868400848684008486840000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C000C0C0C00084000000C0C0
      C00084000000C0C0C000C0C0C000C0C0C000840000008400000084000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      000000000000FF00000084868400FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFF
      FF0000FFFF00FFFFFF008486840000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00084000000C0C0
      C00084000000C0C0C000C0C0C000C0C0C000840000008400000084000000C0C0
      C000C0C0C0000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C00000000000FF00
      0000FF000000FF00000084868400FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFF
      FF00FFFFFF00FFFFFF008486840000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00084000000C0C0
      C00084000000C0C0C000C0C0C000C0C0C000840000008400000084000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FF000000FF00
      0000FF000000FF00000084868400FFFFFF0000FFFF0084000000840000008400
      000084868400FFFFFF008486840000000000C0C0C000C0C0C000C0C0C0000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C000C0C0C00084000000C0C0
      C00084000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FF000000FF00
      0000FF000000FF00000084868400FFFFFF0084860000FF000000FF000000FF00
      000084000000FFFFFF008486840000000000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000C0C0C000C0C0C00000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000848684008400000084000000C0C0
      C00084000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FF000000FF000000FF00
      0000FF000000FF00000084868400FFFFFF00848600008486840000860000FF00
      000084000000FFFFFF008486840000000000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000C0C0C000C0C0C00000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000840000008400000084000000C0C0
      C00084000000C0C0C000C0C0C000C0C0C000840000008400000084000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FF000000FF000000FF00
      0000008600000086000084868400FFFFFF0084860000FFFFFF00848684000086
      000084000000FFFFFF008486840000000000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000C0C0C000C0C0C00000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000000
      0000000000000000000000000000C0C0C000840000008400000084000000C0C0
      C00084000000C0C0C000C0C0C000C0C0C000840000008400000084000000C0C0
      C000C0C0C0000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C00000000000FF000000FF0000000086
      0000008600000086000084868400FFFFFF0000FFFF0084860000848600008486
      000084868400FFFFFF008486840000000000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008486840084000000840000008400
      00008400000084000000C0C0C000C0C0C000840000008400000084000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FF000000FF0000000086
      0000008600000086000084868400FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFF
      FF0000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000C0C0C000C0C0C00000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FF000000FF000000C0C0
      C000008600000086000084868400FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFF
      FF0084868400FFFFFF0084868400C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000C0C0C000C0C0C00000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00084868400FF000000FF00
      0000FFFFFF00C0C0C00084868400FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFF
      FF008486840084868400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000C0C0C000C0C0C00000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000840000008400000084000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00084868400FF000000FFFF
      FF00C0C0C000FFFFFF0084868400848684008486840084868400848684008486
      84008486840000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000840000008400000084000000C0C0
      C000C0C0C0000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C00084868400FF00
      0000FF000000C0C0C000FFFFFF00C0C0C0000086000000860000008600000086
      000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000840000008400000084000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008486
      840084868400FF000000FF000000FFFFFF00C0C0C00000860000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0008486840084868400848684008486840084868400C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0004A2818004A28
      18004A2818004A2818004A2818004A2818004A2818004A2818004A2818004A28
      18004A2818004A2818004A281800C0C0C000C0C0C00000410000004100000041
      0000004100000041000000410000004100000041000000410000004100000041
      00000041000000410000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000BD280000A5381000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000B59E8C00F7EFE700A58E
      7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E
      7B00A58E7B00A58E7B00A58E7B004A281800C0C0C000C0C0C000299E29004AEF
      4A0031D7310029CF290018B6180010AE1000109E1000088E080000860000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000BD280000CE4918009C411800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000C0C0
      C00000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00000000000C0C0C000B59E8C00F7F7EF00F7EF
      E700EFE7E700EFE7DE00E7DFD600E7D7CE00E7D7CE00DECFC600DEC7BD00D6C7
      B500D6BEB500D6BEAD00A58E7B004A281800C0C0C000C0C0C000C0C0C0000041
      000000410000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000BD280000CE4918009C411800C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000C0C0
      C000C0C0C000C0C0C000000000008486000000000000C0C0C000000000000000
      000000000000C0C0C0000000000000000000C0C0C000B59E8C00FFF7F700F7F7
      EF00F7EFE700841800008418000084180000E7D7CE00E7D7CE00841800008418
      000084180000D6BEB500A58E7B004A281800C0C0C000C0C0C000C0C0C0000041
      000008A6100000410000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000BD28
      0000CE4918009C411800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000C0C0
      C000C0C0C000C0C0C000000000008486000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00000000000C0C0C000B59E8C00FFFFFF00FFF7
      F700F7F7EF00F7EFE70084180000EFE7DE00E7DFD600E7D7CE00E7D7CE008418
      0000DEC7BD00D6C7B500A58E7B004A281800C0C0C000C0C0C000C0C0C0009C69
      4A0021C7210008A6100000410000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6411800C641
      1800EF713900D6592900C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000000000000000000000000000848600008486000000000000000000000000
      000000000000000000000000000000000000C0C0C000B59E8C00108610000071
      000010860800F7F7F70042A64200841800008418000084180000841800008418
      0000DECFC600DEC7BD00A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0
      C0009C694A0021C7210008A6100000410000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000BD280000EF71
      39009C411800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000C0C0
      C000C0C0C000000000008486000084860000000000008486000000000000C0C0
      C000C0C0C000C0C0C000C0C0C00000000000C0C0C000B59E8C00C6E7C6000079
      0000EFF7EF00FFFFF700F7F7F70008860800841800009CC79400EFDFDE008418
      0000E7D7CE00DECFC600A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0009C694A0021C7210008A6100010860000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6411800F79E7300EF71
      39009C411800C0C0C000C0C0C000C0C0C0008418000084180000841800008418
      00008418000084180000B5491800C0C0C00000000000C0C0C000C0C0C000C0C0
      C00000000000848600000000000084860000000000008486000000000000C0C0
      C0000000000000000000C0C0C00000000000C0C0C000B59E8C00FFFFFF0052B6
      52008CCF8C00FFFFFF00B5DFAD00007100002996290084180000EFE7DE008418
      0000E7DFD600E7D7CE00A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C0009C694A00CEE7C600FFDF840084414200C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000BD280000F79E7300EF71
      39009C411800C0C0C000C0C0C000C0C0C000C0C0C00084180000F79E7300EF71
      3900EF713900EF713900B5491800C0C0C0000000000000000000C0C0C000C0C0
      C000000000008486000000000000848600000000000000000000C0C0C0000000
      000000FFFF0000FFFF000000000000000000C0C0C000B59E8C00FFFFFF00CEEF
      CE00007100000071000000710000007100008CC78400F7EFEF00841800008418
      0000EFDFDE00E7DFD600A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C0009C694A00FFFFB500FFDF840084414200C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000BD280000F79E7300EF71
      39009C411800C0C0C000C0C0C000C0C0C000C0C0C00084180000DE693900DE71
      4200DE714A00EF713900B5491800C0C0C000000000000000000000000000C0C0
      C000C0C0C00000000000000000008486000000000000C0C0C000C0C0C0000000
      000000FFFF0000FFFF000000000000000000C0C0C000B59E8C00FFFFFF00FFFF
      FF0029962900C6E7C6000079000000790000EFF7EF00F7F7F700F7EFEF008418
      0000EFE7DE00EFDFDE00A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0009C694A00FFFFB500FFDF84008441
      42001010100010081000C0C0C000C0C0C000C0C0C000C6411800F79E7300EF71
      3900C651290084180000C0C0C000C0C0C00084180000C6512900DE714200DE71
      4A00F79E7300EF713900B5491800C0C0C0000000000000000000000000000000
      0000C0C0C000C0C0C000000000008486000000000000C0C0C000C0C0C000C0C0
      C0000000000000000000C0C0C00000000000C0C0C000B59E8C00FFFFFF00FFFF
      FF0094D79400188E18000071000042A64200FFFFFF00FFFFF700F7F7F700F7EF
      EF00EFEFE700EFE7DE00A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0009C694A00FFFFB5001810
      18002928290018101800C0C0C000C0C0C000C0C0C000D6592900F7864A00F79E
      7300EF713900C65129008418000084180000C6512900DE714200DE714A00C651
      2900B5491800F79E7300B5491800C0C0C000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00000000000C0C0C000B59E8C00FFFFFF00FFFF
      FF00FFFFFF000886080000710000ADDFAD00FFFFFF00FFFFFF00FFFFF700F7F7
      F700F7EFEF00EFEFE700A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000292829004238
      420042384200292829001810180010081000C0C0C000C0C0C000C6411800F786
      4A00F79E7300DE613100DE693900DE694200DE714200DE714A00C6512900B549
      1800C0C0C000B5491800B5491800C0C0C0000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00000000000C0C0C000B59E8C00FFFFFF00FFFF
      FF00FFFFFF005AB65A0008860800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFF7F700F7F7EF00A58E7B004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000292829002928
      290042384200423842002928290010101000C0C0C000C0C0C000C0C0C000D659
      2900C6411800F79E7300F79E7300F79E7300F79E7300F79E7300B5491800C0C0
      C000C0C0C000C0C0C000B5491800C0C0C00000000000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000B59E8C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFF7F700F7F7EF004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00029282900423842002928290010101000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000F7511800B5491800B5491800B5491800F7511800C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000B59E8C00B59E
      8C00B59E8C00B59E8C00B59E8C00B59E8C00B59E8C00B59E8C00B59E8C00B59E
      8C00B59E8C00B59E8C00B59E8C00C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000292829002928290018101800C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000BD3808008418000084180000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000D69673007B2808007B2808007B2808007B28
      08007B2808007B2808007B2808007B280800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C69694004A2818004A2818004A2818004A2818004A28
      18004A2818004A2818004A2818004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000E7612900BD380800BD380800BD38080084180000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000D6967300F7DFCE00F7D7C600EFCFBD00EFC7
      AD00EFBEA500E7B69400E7B694007B280800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C6969400EFE7DE00B5968400B5968400B5968400B596
      8400B5968400B5968400B59684004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000A5381000BD280000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000E7612900BD380800E7612900EF8E5A0084180000C0C0C000C0C0C000BD38
      0800BD3808008C300000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000D6967300F7E7DE00F7DFCE00F7D7C600EFCF
      BD00EFCFB500EFC7A500EFBE9C007B280800C0C0C00000285200002852000028
      52000028520000285200C6969400F7EFE700EFE7DE00E7DFD600E7D7CE00DECF
      C600DEC7BD00D6BEB500B59684004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0009C411800CE491800BD280000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000E7612900BD380800C0C0C000EF8E5A0084180000C0C0C000BD380800BD38
      08008C3000008C3000008C300000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000D6967300FFF7EF00C6693900C6693900C669
      3900C6693900C6693900EFC7A5007B2808000071BD005ACFEF000071BD000071
      BD000071BD000071BD00C6969400F7F7EF00CE862900CE862900CE862900CE86
      2900CE862900DEC7BD00B59684004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0009C411800CE491800BD28
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000E7612900EF8E5A008C3000008C30000084180000C0C0C000BD380800E761
      2900EF8E5A008C30000084180000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000D6967300FFFFFF00FFF7F700FFEFE700F7E7
      D600F7DFCE00F7D7BD00EFCFB5007B2808000071BD006BD7EF005ACFEF0052C7
      E7004ABEE70042BEE700C6969400FFFFFF00FFF7F700F7EFEF00EFE7E700E7DF
      D600E7D7CE00DECFC600B59684004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0009C411800CE49
      1800BD280000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000E7612900EF8E5A008C3000008418000084180000BD380800C0C0
      C000E76129008C30000084180000C0C0C000C6A694005A4129005A4129005A41
      29005A4129005A4129005A412900D6967300FFFFFF00C6693900C6693900C669
      3900C6693900C6693900F7D7BD007B2808000071BD0073DFF7006BD7EF005ACF
      EF0052C7E7004ABEE700C6969400FFFFFF00CE862900CE862900CE862900CE86
      2900CE862900E7D7CE00B59684004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000D6592900EF71
      3900C6411800C6411800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000E7612900842800008C30100084180000BD3808008C30
      00008418000084180000C0C0C000C0C0C000C6A69400EFE7DE00E7DFD600E7D7
      CE00DECFBD00D6C7B500D6BEAD00D6967300FFFFFF00FFFFFF00FFFFFF00FFF7
      F700FFEFE700F7E7D600F7DFCE007B2808000071BD007BE7F70073DFF7006BD7
      EF005ACFEF0052C7E700C6969400FFFFFF00FFFFFF00FFFFFF00FFF7F700F7EF
      EF00EFE7E700E7DFD600B59684004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0009C41
      1800EF713900BD280000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00052413900A58E7B008C412100841800008418
      0000BD380800C0C0C000C0C0C000C0C0C000C6A69400F7EFE700EFE7DE00E7DF
      D600E7D7CE00DECFC600DEC7BD00D6967300FFFFFF00C6693900C6693900FFFF
      FF00D69673009438100094381000943810000071BD007BE7F7007BE7F70073DF
      F7006BD7EF005ACFEF00C6969400FFFFFF00CE862900CE862900CE862900FFF7
      F700F7EFEF00C69694004A2818004A281800C0C0C000B5491800841800008418
      000084180000841800008418000084180000C0C0C000C0C0C000C0C0C0009C41
      1800EF713900D6592900C6512900C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00052413900C6B6AD00BD9E8C0052413900C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6A69400F7F7EF00D6966B00D696
      6B00D6966B00D6966B00D6966B00D6967300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D6967300EFE7DE0094381000C0C0C0000071BD007BE7F7007BE7F7007BE7
      F70073DFF7006BD7EF00C6969400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFF7F700C6969400FFFFFF004A281800C0C0C000B5491800EF713900EF71
      3900EF713900EF71390084180000C0C0C000C0C0C000C0C0C000C0C0C0009C41
      1800EF713900D6592900BD280000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00052413900D6C7BD0052413900D6BEAD0052413900C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6A69400FFFFFF00FFF7F700F7EF
      EF00EFE7E700E7DFD600E7D7CE00D6967300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E7967300B5491800C0C0C000C0C0C0000071BD007BE7F7007BE7F7007BE7
      F7007BE7F70073DFF700C6969400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C69694004A281800C0C0C000C0C0C000B5491800EF713900DE71
      4A00DE714200DE69390084180000C0C0C000C0C0C000C0C0C000C0C0C0009C41
      1800EF713900D6592900BD280000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00052413900E7DFD6005241390094796300E7D7CE0052413900C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6A69400FFFFFF00D6966B00D696
      6B00D6966B00D6966B00D6966B00D6967300D6967300D6967300D6967300D696
      7300D6967300C0C0C000C0C0C000C0C0C0000071BD007BE7F7007BE7F7007BE7
      F7007BE7F7007BE7F700C6969400C6969400C6969400C6969400C6969400C696
      9400C6969400C6969400C0C0C000C0C0C000C0C0C000B5491800EF713900F79E
      7300DE714A00DE714200C651290084180000C0C0C000C0C0C00084180000F79E
      7300EF713900D6592900C6411800C0C0C000C0C0C000C0C0C000C0C0C0009479
      6300FFFFFF0052413900C0C0C00094796300E7DFD60052413900C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6A69400FFFFFF00FFFFFF00FFFF
      FF00FFF7F700F7EFEF00EFE7E700E7DFD6004A281800C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000071BD007BE7F7007BE7F7000041
      8400002852000028520000285200002852000028520000285200002852000071
      BD0000285200C0C0C000C0C0C000C0C0C000C0C0C000B5491800F79E7300B549
      1800F79E7300DE714A00DE714200C65129008418000084180000F79E7300EF71
      3900EF713900D6592900C6512900C0C0C000C0C0C000C0C0C000C0C0C0009479
      630052413900C0C0C000C0C0C00094796300F7EFE70052413900C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6A69400FFFFFF00D6966B00D696
      6B00FFFFFF00C6A694004A2818004A2818004A281800C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000071BD007BE7F7007BE7F7000041
      84007BE7F70052C7E7000028520052C7E70031AEDE000079BD00002852000071
      BD0000285200C0C0C000C0C0C000C0C0C000C0C0C000B5491800B5491800C0C0
      C000B5491800F79E7300DE714A00DE714200DE694200DE693900DE613100EF71
      3900D6592900C6411800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0009479
      6300C0C0C000C0C0C000C0C0C00094796300FFFFFF0052413900C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6A69400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6A69400EFE7DE004A281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000071BD007BE7F7007BE7F7007BE7
      F700004184007BE7F700002852000028520052C7E700002852004ABEE7004ABE
      E70000285200C0C0C000C0C0C000C0C0C000C0C0C000B5491800C0C0C000C0C0
      C000C0C0C000B5491800F79E7300F79E7300F79E7300F79E7300EF713900C641
      1800C6512900C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C0009479630052413900C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6A69400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6A694004A281800C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000071BD000071BD000071
      BD000071BD00004184007BE7F7007BE7F700002852000071BD000071BD000071
      BD00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000F7511800B5491800B5491800B5491800F7511800C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00094796300C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C6A69400C6A69400C6A69400C6A6
      9400C6A69400C6A69400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000418400004184000041840000418400C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B004A28
      18004A2818004A2818004A2818004A2818004A2818004A2818004A2818004A28
      18004A2818004A2818004A281800C0C0C000C0C0C000C0C0C000522818005228
      1800522818005228180052281800522818005228180052281800522818005228
      180052281800522818005228180052281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00EFDF
      DE00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E
      7B00A58E7B00A58E7B004A281800C0C0C000C0C0C000C6515200C6797B00BD71
      730052412900AD9E9400B5AEA500BDB6AD00BDB6AD00BDB6AD00BDB6AD007359
      4A007B2829007B2829007B28290052281800C0C0C0006B4131006B4131006B41
      31006B4131006B4131006B4131006B4131006B4131006B4131006B4131006B41
      3100C0C0C000C0C0C000C0C0C000C0C0C0006B79840000417300004173000041
      7300004173000041730000417300004173000041730000417300004173000041
      7300C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00EFE7
      DE00EFDFDE00E7DFD600E7D7CE00DECFC600DECFC600D6C7BD00D6BEB500D6BE
      AD00D6BEAD00A58E7B004A281800C0C0C000C0C0C000C6515200CE8E8400C679
      7B00524129001808080042302900FFFFFF00FFFFFF00FFFFFF00EFDFD6007359
      4A007B2829007B2829007B282900522818008C716300FFFFFF00A58E7B00A58E
      7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E
      7B006B413100C0C0C000C0C0C000C0C0C0006B7984006B798400108EC6000079
      BD000079BD000079BD000079BD000079BD000079BD000079BD000079BD000041
      7300C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00F7EF
      E700EFE7DE00EFDFDE00E7DFD600E7D7CE00DECFC600DECFC600D6C7BD00D6BE
      B500D6BEAD00A58E7B004A281800C0C0C000C0C0C000C6515200D6968C00CE8E
      8400524129000000000021100800FFFFFF00F7EFEF00EFDFD600DEBEAD007359
      4A00843031007B2829007B282900522818008C716300FFFFFF00FFFFFF00FFFF
      FF00FFF7EF00F7EFDE00F7DFCE00F7D7BD00EFCFB50010204200E7BE9400A58E
      7B006B4131006B413100C0C0C000C0C0C0006B7984006B7984005AAEC60042CF
      F70042CFF70039C7EF0031BEEF0029B6EF0021B6E70021AEE70018A6E7000079
      BD0000417300C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00F7EF
      EF00F7EFE700EFE7DE00EFDFDE00E7DFD600E7D7CE00DECFC600DECFC600D6C7
      BD00D6BEB500A58E7B004A281800C0C0C000C0C0C000C6515200DE9E9400D696
      8C00524129005241290052412900524129005241290052412900524129005241
      29008C383900843031007B282900522818008C716300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFF7EF00F7EFDE00F7DFCE00F7D7BD00299E3100EFC7A500A58E
      7B008C716300946142006B413100C0C0C0006B7984004AD7F7006B79840052C7
      E7004ACFF70042CFF70039C7EF0031BEEF0029BEEF0029B6E70021AEE70010A6
      E70000417300C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00F7F7
      F700F7EFEF00F7EFE700EFE7DE00EFDFDE00E7DFD600E7D7CE00DECFC600DECF
      C600D6C7BD00A58E7B004A281800C0C0C000C0C0C000C6515200E7AEA500E7A6
      9C00D6969400CE8E8C00C6867B00BD717300B5696B00AD615A00A55952009C51
      4A00944142008C38390084303100522818008C716300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFF7EF00F7EFDE00F7DFCE00F7D7BD00EFCFB500EFC7
      A5008C716300A5795A006B413100C0C0C0006B79840063E7F7006B7984005AB6
      CE004AD7F7004AD7F70042CFF70039C7EF0031BEEF0029BEEF0029B6E70021AE
      E7000079BD0000417300C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00F7F7F700F7EFEF00F7EFE700EFE7DE00EFDFDE00E7DFD600E7D7CE00DECF
      C600DECFC600A58E7B004A281800C0C0C000C0C0C000C6515200EFB6AD00E7AE
      A500E7A69C00D6969400CE8E8C00C6867B00C6797300BD716B00B5696300AD59
      5A009C514A00944142008C383900522818008C7163008C7163008C7163008C71
      63008C7163008C7163008C7163008C7163008C7163008C7163006B4131006B41
      31008C716300B5866B006B413100C0C0C0006B7984006BEFF7004AD7F7006B79
      840052C7E7004AD7F7004AD7F70042CFF70039C7EF0031BEEF0029BEEF0029B6
      E70018A6DE0000417300C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00F7F7F700F7EFEF00F7EFE700EFE7DE00EFDFDE00E7DFD600E7D7
      CE00DECFC600A58E7B004A281800C0C0C000C0C0C000C6515200EFB6AD00EFB6
      AD00BD494200BD494200BD494200BD494200BD494200BD494200BD494200BD49
      4200BD494200A55152009C494A00522818008C716300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7EF00F7EFDE00F7DFCE00F7D7
      BD008C716300C69E7B006B413100C0C0C0006B79840073F7F7006BEFF7006B79
      84005AB6CE004AD7F7004AD7F7004AD7F70042CFF70039C7F70031BEEF0029BE
      EF0021B6E7000079BD0000417300C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFF7F700F7F7EF00F7EFEF00EFE7E700EFE7DE00E7DF
      D600E7D7CE00A58E7B004A281800C0C0C000C0C0C000C6515200EFB6AD00BD49
      4200FFF7EF00F7EFE700EFE7DE00EFDFCE00E7D7C600E7CFBD00DEC7B500DEBE
      AD00DEBEAD00BD494200A551520052281800C0C0C0008C7163008C7163008C71
      63008C7163008C7163008C7163008C7163008C7163008C7163008C7163008C71
      6300CEA684007B695A006B413100C0C0C0006B7984007BF7F70073F7F7004AD7
      F7006B7984006B7984006B7984006B7984006B7984006B7984006B7984006B79
      84006B7984006B7984006B798400C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7F7EF00F7EFEF00EFE7E700EFE7
      DE00E7DFD600A58E7B004A281800C0C0C000C0C0C000C6515200EFB6AD00BD49
      4200FFFFFF00FFF7F700F7EFEF00F7E7DE00EFDFD600E7D7CE00E7CFC600DEC7
      BD00DEBEAD00BD494200AD595A0052281800C0C0C000C6969400C6969400FFFF
      FF00FFFFFF00FFFFFF00FFF7F700F7F7EF00F7EFEF00EFEFE700EFE7DE006B41
      310094796300CEA684006B413100C0C0C0006B7984007BF7F7007BF7F70073F7
      F7004AD7F7004AD7F7004AD7F7004AD7F7004AD7F7004AD7F7004AD7F7004AD7
      F7006B798400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7F7EF00F7EFEF00EFE7
      E700A58E7B00A58E7B004A281800C0C0C000C0C0C000C6515200EFB6AD00BD49
      4200FFFFFF00FFFFFF00FFF7F700F7EFEF00F7E7DE00EFDFD600E7D7CE00E7CF
      C600DEC7BD00BD494200B569630052281800C0C0C000C0C0C000C0C0C000C696
      9400FFFFFF00C6A69400C6A69400C6A69400C6A69400C6A69400EFEFE7006B41
      31006B4131006B4131006B413100C0C0C0006B7984007BF7F7007BF7F7007BF7
      F70073F7F7004AD7F7006B7984006B7984006B7984006B7984006B7984006B79
      840084180000841800008418000084180000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7F7EF00A58E
      7B004A2818004A2818004A281800C0C0C000C0C0C000C6515200EFB6AD00BD49
      4200FFFFFF00FFFFFF00FFFFFF00FFF7F700F7EFEF00F7E7DE00EFDFD600E7D7
      CE00E7CFC600BD494200BD716B0052281800C0C0C000C0C0C000C0C0C000C696
      9400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7F7EF00F7EFEF00EFEF
      E7006B413100C0C0C000C0C0C000C0C0C0006B7984007BF7F7007BF7F7007BF7
      F7007BF7F7006B798400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00084180000DE8E6B0084180000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700A58E
      7B00EFE7DE00D6BEAD004A281800C0C0C000C0C0C000C6515200EFB6AD00BD49
      4200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7EFEF00F7E7DE00EFDF
      D600E7D7CE00BD494200C6797B0052281800C0C0C000C0C0C000C0C0C000C0C0
      C000C6969400FFFFFF00C6A69400C6A69400C6A69400C6A69400C6A69400F7EF
      EF006B4131006B413100C0C0C000C0C0C000C0C0C0006B7984006B7984006B79
      84006B798400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000AD5121008418000084180000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A58E
      7B00D6BEAD004A281800C0C0C000C0C0C000C0C0C000C6515200EFB6AD00BD49
      4200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7EFEF00F7E7
      DE00EFDFD600BD4942000000000052281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C6969400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7F7
      EF00F7EFEF006B413100C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00084180000AD512100C0C0
      C000AD51210084180000C0C0C00084180000C0C0C000C0C0C000A58E7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A58E
      7B004A281800C0C0C000C0C0C000C0C0C000C0C0C000C6515200EFB6AD00BD49
      4200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7EF
      EF00F7E7DE00BD494200BD716B0052281800C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C6969400C6969400C6969400C6969400C6969400C6969400C696
      9400C6969400C6969400C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000841800008418
      000084180000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000A58E7B00A58E
      7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E7B00A58E
      7B00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C6515200C6515200C651
      5200C6515200C6515200C6515200C6515200C6515200C6515200C6515200C651
      5200C6515200C6515200C6515200C6515200C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000424D3E000000000000003E000000
      2800000040000000200100000100010000000000000900000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFE7F00000000FFFFF00F00000000
      FFFFE00700000000FFFFC0030000000080008001000000000000800100000000
      0000800100000000000000000000000000000000000000000000800100000000
      000080010000000000008001000000000000C003000000000000E00700000000
      0000F00F000000000000FC3F00000000F03F00000000FFFFE01F00000000F0C3
      C00700000000F1E3800700000000F9A30F0300000000F0C32F8300000000C000
      07C1000000008000038000000000800081C000000000C00001E200000000C000
      C3E400000000C019C1F800000000C003C001000000004003E00100000000C03F
      F00300000000FFFFFC0F00000000FFFF8000FFFFFFFF9FCF0000FFFFFFFF9FCF
      1000FFFFFFFF87C30000FFFF800187C30000FFFF000000000000800000000000
      000000000000000000001000000097CB00000000000097CB00000000000097CB
      00000000000097CB00000000000087C3000000000000E7F3000800000000F7FB
      000000000000F7FB000100010000FFFFFFFFFFFFFE3FFE3FFF9FFE7FFC3FFE3F
      FF0FFE3FF83F023FFE07FE1FF03F023FFC03FE0FE000E03FF8018007C000E07F
      F00180038000E0FFE00380010000E00FC00780010000900F800780038000802F
      80078007C000883F8007800FE000C03FC007FE1FF03FC01FE007FE3FF83FFF0F
      FC0FFE7FFC3FFE0FFF9FFEFFFE3FFF0FFFFFFFFFFFFF0000FFFFFFFF80010000
      FFFF800100010000FFFF000100010000BFFF0001000100007000000100010000
      70000001000100006000000100010000A0000001000100008000000100010000
      E000000100010000E000000100010000F000000100011FE0F000000100011FF0
      FFFFFFFF00011FF8FFFFFFFFFFFF0000000000009182FFFF000000000000FC3F
      000000000000F00F000000000000E007000000000000C003000000000000C003
      0000000000008001000000000000800100000000000080010000000000008001
      000000000000C003000000000000C003000000000000E007000000000000F00F
      000000000000FC3F000000000000FFFF00000000000000000000000000000000
      0000000007F00000028002800FF80000054005401FF8000000A000A01FFC0000
      001000103FFC00000028002877FC00000010001067FE00000008000807F60000
      201020100DB60000300030000DB200001C001C0019B000000F000F0019B00000
      00000000018000000000000000000000FF7FFFF7F87FFE7FFF3FFFE7C000FC3F
      FF1FFFC08000F81FF81F00008000F00FE00F00008000E007C00700008000C003
      8003000080008001000100038000000000000003800000000000000380008001
      000000038000C003000000038000E007000080078000F00F8001C00FC000F81F
      C003E01FF07FFC3FF00FF03FFC7FFE7FDFFFFFFFFC00E0008FE70381F800E000
      07C30381E000E00083870381C000C000C10F038180008000E01F038180000000
      F03F000100000000F839000100000000F0188003000080008000C0070000C000
      0303C1070001E0000383C1078003E0006387E38F8003E000E20FE38FC007E001
      C41FFFFFE00FE003FFFFFFFFF83FE007FFFFC001C00180008000C001C0010000
      8000C001C00100008000C001C00180008000C001C001C000001FC001C001E000
      003FC001C001E000003FC001C001E000101FC001C001E000000FC001C001E000
      0307C001C001E0000783C001C001E0000FC1C001C001E0001FE0C003C003E001
      3FF0C007C007E0037FF9C00FC00FE007C001FFFFFFFFFC038000FFFFF81FC003
      800007C1F81FDC03800007C1F00FDFFF800007C10001DC03800001010001C003
      800000010001DC03800002010001DFFF800002010001DC03800080030001C003
      8000C1070001DC038000C1070001DFFF8000E38F000100FF8000E38F000100FF
      C001E38F000100FFFFFFFFFF0001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFF0030003FFFFFFFFFFFFFFFFE67FFFC700030003F0FFFFDF
      FFFFFFFFF9FFFFEFF0030003F0FFFFF7FFFFFFFFE67FE64F00030003FFC7F0FF
      FFFFFFFFFFDFF9FFF0030003FFEFF0FFFFFFFFFFFFF7E67F00030003FFCFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFE00FFFFFFFFFFFFFFFFF003FC00FE07FF83FFFFFFFFFF8FFF11F00030003
      F8FFF39FFFFFFFFFFC7FF39F003FC00FFC7FF39FFFFFFFFFFE3FF39F00030003
      FE3FF39FFFFFFFFFFF1FF39F003FC00FFE0FE10FFFFFFFFFFFFFFFFF00030003
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC00FFFFFFFFFFFFF800FFFF
      81D71FFFE000FFFFFFD71803C000FFFFFFD71FFF8000E01F81D7FFFF8000F18F
      FF17FFFF0000F18FFF171FFF0000F18F811718030000F01FFF031FFF0000F18F
      FFFFFFFF1001F18F8003FFFF8403F18FFFFF1FFF8803E01FFFFF1803C507FFFF
      F8031FFFE08FFFFFFFFFFFFFF83FFFFFFFFFFFFFC0018003FCFFC0008000C01F
      F8FFD0FE8000E7FFF1FFDC448000E3FFE3FFDC7E8000E1FFC3FFC0008000F0FF
      C7FFD81E8000F87F870170128000FC3F878130208000FE1F878118608000FF03
      83010C728000FF8380011EFE8000FFC0C0093FFE8000FFC0E01D60008000FFF0
      F83FFFFFC001FFF1FFFFFFFFFFFFFFFFF8FFFE00FC00FFFFF07FFE00FC00FF3F
      F063FE008000FF1FF241FE000000FF8FF041FE000000FFC7F81100000000FFC3
      FC0300000000FFE3FE070000000080E1FC3F0001000081E1F83F0003000181E1
      F03F0007000380C1E23F007F00078001E63F007F00079003EE3F00FF0007B807
      FE7F01FF800FFC1FFEFF03FFF87FFFFFFFFFC001C000FFFFFFFFC0018000800F
      000FC00180000007000FC001800000030007C001800000010007C00180000001
      0003C001800000010003C001800000010001C001800080010001C00180008001
      0007C0018000E0010000C0018000E00703F8C0018000F00387F8C0038000F803
      FF92C0078000F803FFC7C00F8000FFFF00000000000000000000000000000000
      000000000000}
  end
  object PopupMenu_RockData: TPopupMenu
    Images = ImageList1
    Left = 848
    Top = 79
    object Pop_Rock_Refresh: TMenuItem
      Caption = #21047#26032#25968#25454
      ImageIndex = 60
      OnClick = Pop_Rock_RefreshClick
    end
    object N7: TMenuItem
      Caption = #26356#25442#25968#25454#21333#20301
      ImageIndex = 59
      OnClick = N7Click
    end
    object N12: TMenuItem
      Caption = '-'
    end
    object Pop_Rock_Auto: TMenuItem
      Caption = #21152#36733#23548#20837#25968#25454
      ImageIndex = 61
      OnClick = Pop_Rock_AutoClick
    end
    object Pop_Rock_Paste: TMenuItem
      Caption = #31896#36148#21387#21147#25968#25454
      ImageIndex = 5
      OnClick = Pop_Rock_PasteClick
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object Pop_Rock_Disp_50: TMenuItem
      Caption = #26174#31034#26368#36817'50'#31859#25968#25454
      ImageIndex = 30
      OnClick = Pop_Rock_Disp_50Click
    end
    object Pop_Rock_Disp_300: TMenuItem
      Caption = #26174#31034#26368#36817'300'#31859#25968#25454
      ImageIndex = 31
      OnClick = Pop_Rock_Disp_300Click
    end
    object Pop_Rock_Disp_All: TMenuItem
      Caption = #26174#31034#20840#37096#21387#21147#25968#25454
      ImageIndex = 58
      OnClick = Pop_Rock_Disp_AllClick
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object Pop_Rock_Input_Memo: TMenuItem
      Caption = #28155#21152#30719#21387#26174#29616
      ImageIndex = 66
      OnClick = Pop_Rock_Input_MemoClick
    end
    object Pop_Rock_Disp_Memo: TMenuItem
      Caption = #26597#30475#30719#21387#26174#29616
      ImageIndex = 25
      OnClick = Pop_Rock_Disp_MemoClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object Pop_Rock_Save: TMenuItem
      Caption = #20445#23384#21040#25968#25454#24211
      ImageIndex = 2
      OnClick = Pop_Rock_SaveClick
    end
    object Pop_Rock_SaveExcel: TMenuItem
      Caption = #25968#25454#21478#23384#20026'Excel'
      ImageIndex = 10
      OnClick = Pop_Rock_SaveExcelClick
    end
    object N14: TMenuItem
      Caption = '-'
    end
    object Pop_Rock_DeleteOne: TMenuItem
      Caption = #21024#38500#24403#21069#34892#25968#25454
      ImageIndex = 4
      OnClick = Pop_Rock_DeleteOneClick
    end
    object Pop_Rock_DeletaAll: TMenuItem
      Caption = #21024#38500#20840#37096#25968#25454
      ImageIndex = 65
      OnClick = Pop_Rock_DeletaAllClick
    end
  end
  object ColorDialog1: TColorDialog
    Left = 640
    Top = 8
  end
  object ContourPop_Main: TPopupMenu
    Images = ImageList1
    Left = 817
    Top = 9
    object ContourPop_refreshchart: TMenuItem
      Caption = #21047#26032#25972#20010#22270#24418
      ImageIndex = 60
      OnClick = ContourPop_refreshchartClick
    end
    object N18: TMenuItem
      Caption = '-'
    end
    object ContourPop_EditMap: TMenuItem
      Caption = #32534#36753#36873#20013#30340#22270#24418
      ImageIndex = 11
      OnClick = ContourPop_EditMapClick
    end
    object ContourPop_SaveEditMap: TMenuItem
      Caption = #20445#23384#20462#25913#30340#22270#24418
      ImageIndex = 2
      OnClick = ContourPop_SaveEditMapClick
    end
    object ContourPop_UndoEdit: TMenuItem
      Caption = #21462#28040#21018#25165#30340#20462#25913
      ImageIndex = 7
      OnClick = ContourPop_UndoEditClick
    end
    object ContourPop_Delete: TMenuItem
      Caption = #21024#38500#36873#25321#30340#21306#22495
      ImageIndex = 65
      OnClick = ContourPop_DeleteClick
    end
    object N15: TMenuItem
      Caption = '-'
    end
    object ContourPop_LeftTool: TMenuItem
      Caption = #20851#38381#24038#20391#24037#20855#26639
      ImageIndex = 54
      OnClick = ContourPop_LeftToolClick
    end
    object ContourPop_RightTool: TMenuItem
      Caption = #25171#24320#21491#20391#24037#20855#26639
      ImageIndex = 53
      OnClick = ContourPop_RightToolClick
    end
    object N16: TMenuItem
      Caption = '-'
    end
    object ContourPop_Shizhi: TMenuItem
      Caption = #25171#24320#21313#23383#20809#26631#32447
      ImageIndex = 42
      RadioItem = True
      OnClick = ContourPop_ShizhiClick
    end
    object ContourPop_LeftZoom: TMenuItem
      Caption = #21551#21160#24038#38190#25918#22823#21151#33021
      ImageIndex = 40
      OnClick = ContourPop_LeftZoomClick
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object ContourPop_loadData: TMenuItem
      Caption = #21387#21147#25968#25454#21152#36733
      ImageIndex = 31
      OnClick = ContourPop_loadDataClick
    end
    object ContourPop_ChangUnit: TMenuItem
      Caption = #25968#25454#21333#20301#36716#25442
      ImageIndex = 59
      OnClick = ContourPop_ChangUnitClick
    end
    object contourPop_KYFX: TMenuItem
      Caption = #30719#21387#25968#25454#28145#23618#20998#26512
      ImageIndex = 28
      OnClick = ContourPop_KyFXClick
    end
    object N17: TMenuItem
      Caption = '-'
    end
    object contourPop_Disp_Step: TMenuItem
      Caption = #26174#31034#26469#21387#27493#36317#26631#24535
      ImageIndex = 55
      OnClick = contourPop_Disp_StepClick
    end
    object N13: TMenuItem
      Caption = '-'
    end
    object ContourPop_Save_Bmp: TMenuItem
      Caption = #22270#29255#20445#23384
      ImageIndex = 30
      OnClick = ContourPop_Save_BmpClick
    end
  end
  object ImageList2: TImageList
    BkColor = 15790320
    Left = 344
    Top = 65528
    Bitmap = {
      494C010107004400C80110001000F0F0F000FF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000C0C0C000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000C0C0C00080808000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000000000000000000000000000F0F0
      F000F0F0F000F0F0F0000000000000000000F0F0F00080808000000000000000
      0000008000000000000000000000008000000000000000000000008000000000
      000000000000F0F0F00080808000F0F0F000F0F0F000F0F0F000F0F0F0000000
      FF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0000000FF000000
      FF00F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F00000000000F0F0F000C0C0C00000000000C0C0C000C0C0C000C0C0
      C00000000000C0C0C0000000000000000000F0F0F00080808000000000000000
      0000008000000000000000000000008000000000000000000000008000000000
      000000000000F0F0F00080808000F0F0F000F0F0F000F0F0F000F0F0F0000000
      FF000000FF00F0F0F000F0F0F000F0F0F000F0F0F0000000FF000000FF000000
      FF00F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F00000000000F0F0F000F0F0F000F0F0F000F0F0
      F000C0C0C000C0C0C0000000000000000000F0F0F00080808000008000000080
      0000008000000080000000800000008000000080000000800000008000000080
      000000800000F0F0F00080808000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F0000000FF000000FF00F0F0F000F0F0F0000000FF000000FF000000FF00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000C0C0C0000000000000000000F0F0F000F0F0F000F0F0
      F000F0F0F000FFFF00000000000000000000F0F0F00080808000000000000000
      0000008000000000000000000000008000000000000000000000008000000000
      000000000000F0F0F00080808000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0000000FF000000FF000000FF000000FF000000FF00F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F0000000000000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000FFFF00000000000000000000F0F0F00080808000000000000000
      0000F0F0F0000000000000000000F0F0F0000000000000000000F0F0F0000000
      000000000000F0F0F00080808000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F0000000FF000000FF000000FF00F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F0F0F000F0F0F000F0F0F000F0F0F00000000000F0F0F000F0F0F000F0F0
      F000F0F0F000FFFF00000000000000000000F0F0F00080808000008000000080
      000000800000F0F0F000F0F0F00000800000008000000080000000800000F0F0
      F000F0F0F000F0F0F00080808000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0000000FF000000FF000000FF000000FF00F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000C0C0C00000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F00000000000FFFF00000000000000000000F0F0F00080808000000000000000
      0000008000000000000000000000008000000000000000000000008000000000
      000000000000F0F0F00080808000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F0000000FF000000FF000000FF00F0F0F0000000FF000000FF00F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000000000000000
      000000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00000000000F0F0
      F000F0F0F000F0F0F0000000000000000000F0F0F00080808000000000000000
      0000008000000000000000000000008000000000000000000000008000000000
      000000000000F0F0F00080808000F0F0F000F0F0F000F0F0F000F0F0F0000000
      FF000000FF000000FF00F0F0F000F0F0F000F0F0F0000000FF000000FF00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F0F0F00080808000F0F0F000F0F0F000F0F0F0000000FF000000
      FF000000FF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0000000FF000000
      FF00F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00080808000F0F0F000F0F0F000F0F0F000F0F0F0000000
      FF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000FDFDFDFFF0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000E6E6E6FFACACACFF7B7B7BFF878787FFBFBFBFFFF5F5F5FFF0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000FEFEFEFFB0B1B3FF55AABAFFF7F7F7FFF0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000DDD8
      D4FFC37A34FFF2AA5DFFFACE98FFFFE2B8FFFACE98FFF2A95DFFB9702BFF7974
      70FFF6F6F6FFF0F0F000F0F0F000F0F0F000F0F0F000F3F3F3FFCFCFCFFFCFCF
      CFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCF
      CFFFCFCFCFFFD0D0D0FFF4F4F4FFF0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000FDFDFDFFAEAFB1FF00D1F9FF4DEAFDFF2FACC4FFF2F2F2FFF0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000CCA27BFFF2A9
      5DFFFAD19BFFFBD7A6FFFCDCAEFFFDDEB1FFFCDCAEFFFBD7A6FFF9D19CFFF2A9
      5DFF8B613AFFE4E4E4FFF0F0F000F0F0F000F0F0F00008A0D7FF08A0D7FF08A0
      D7FF08A0D7FF08A0D7FF08A0D7FF08A0D7FF08A0D7FF08A0D7FF08A0D7FF08A0
      D7FF08A0D7FF0B9BCEFFD2D2D2FFF0F0F000F0F0F000F0F0F000F0F0F000FCFC
      FCFFABADAFFF00D9FAFF00D1F9FF48EAFDFF00DCFBFF1BB7D6FFEDEDEEFFF0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000DAB088FFF2B068FFF6C6
      8BFFF9CD95FFFAD39EFFFBD6A4FF461E00FFFAD6A4FFFAD29EFFF8CD95FFF6C6
      8BFFF2B068FF8B613AFFF6F6F6FFF0F0F000F0F0F00008A0D7FF2FD5FEFF30D5
      FEFF30D4FEFF2ED5FFFF2CD4FEFF28D3FFFF24D3FEFF1DD1FEFF18D0FEFF12CE
      FFFF0DCDFEFF0B9BCEFFD2D2D2FFF0F0F000F0F0F000F0F0F000FBFBFBFFAAAB
      ADFF00E0FBFF00D9FAFF00D1F9FF60EDFEFF00DDFBFF00D8FAFF0EBFE5FFE3E4
      E4FFF0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F00000000000C0C0C00000000000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000FAF5F1FFEF9F4DFFF4BB7AFFF5C2
      83FFF6C68CFFF8CC93FFF8CF98FF461E00FFF9CE98FFF8CC93FFF7C78CFFF5C2
      83FFF3BB7AFFEF9F4CFF797470FFF0F0F000F0F0F00008A0D7FF39D7FFFF3BD6
      FFFF3BD7FFFF39D7FFFF36D6FEFF31D5FFFF2BD3FEFF25D3FFFF1FD1FFFF17D0
      FEFF11CEFEFF0B9BCEFFD2D2D2FFF0F0F000F0F0F000FAFAFAFFA8A9ABFF70F3
      FEFF00E0FBFF00D9FAFF00D1F9FF6DEFFEFF00DDFBFF00D8FAFF00D2FAFF06C4
      EEFFD8D9DAFFF0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F0000000000000FF00008080800080808000C0C0
      C00000000000F0F0F000F0F0F000F0F0F000DF9651FFF1B36DFFF3B873FFF4BC
      7BFFF5C182FFF6C588FFF7C78CFF461E00FFF6C78CFFF6C488FFF5C182FFF3BC
      7BFFF2B874FFF1B46CFFB9702BFFF5F5F5FFF0F0F00008A0D7FF56DDFFFF45D9
      FFFF45D9FFFF43D9FFFF3FD8FEFF3AD7FFFF33D6FFFF2CD4FEFF24D3FEFF1CD1
      FFFF16CFFEFF0B9BCEFFD2D2D2FFF0F0F000F0F0F000A5A6A9FF7DF8FEFF70F3
      FEFF2DE6FCFF00D9FAFF00D1F9FF74F0FEFF00DDFBFF00D8FAFF00D2FAFF00CD
      F9FF02C4F4FFD1D2D3FFF0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F0000000000000FF0000C0C0C00000FF0000000000008080
      800080808000C0C0C00000000000F0F0F000ED973FFFF1B068FFF1B36DFFF2B7
      73FFF3BB78FFF4BE7DFFF5BF80FF461E00FFF5C080FFF4BD7DFFF3BB78FFF2B8
      72FFF1B46DFFF1B168FFED963FFFBFBFBFFFF0F0F00008A0D7FF81E6FFFF5DDE
      FEFF4EDBFFFF4DDBFFFF48DAFEFF41D9FFFF3BD7FFFF32D5FFFF2AD3FFFF22D2
      FFFF19D0FEFF0B9BCEFFD2D2D2FFF0F0F000F0F0F00090FBFFFF83F8FFFF76F3
      FEFF6DEEFDFF00D9FAFF00D1F9FF84F1FEFF20E2FCFF00D8FAFF00D2FAFF00CD
      F9FF00C8F8FF00C2F7FFEBECECFFF0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0000000000000FF0000C0C0C00000FF000000FF000000FF000000FF
      0000000000008080800000000000F0F0F000EFA759FFF0B067FFF0B068FFF2BA
      79FFF5C792FFF5C995FFF6CA98FF745640FFF6CB98FFF5C996FFF4C791FFF2BA
      7AFFF0B168FFF0B066FFEFA759FF878787FFF0F0F00008A0D7FF96E9FFFF94E9
      FEFF6FE2FFFF54DCFEFF50DBFFFF49DAFFFF41D8FFFF38D6FEFF2ED4FFFF26D3
      FFFF1CD1FFFF0B9BCEFFD2D2D2FFF0F0F000F0F0F00097FBFFFF8AF9FFFF7DF4
      FEFF70EEFDFF06DAFBFF00D1F9FF8CF3FEFF81EFFEFF00D8FAFF00D3FAFF00CE
      F9FF00C8F8FF00C3F8FFE6E6E7FFF0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F0000000000000FF0000C0C0C00000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000000000F0F0F000F0B066FFF1B36BFF7E624DFF7F64
      4FFF7F644FFF7F644FFF7F644FFF7F644FFF7F644FFF7F644FFF7F644FFF7F64
      4FFF7E624DFFF1B36BFFF0B065FF7B7B7BFFF0F0F00008A0D7FFAAEEFFFFA8ED
      FFFFA1ECFEFF8DE8FFFF5DDDFEFF4EDBFEFF46D9FEFF3CD7FFFF32D6FFFF29D3
      FFFF1FD2FEFF0B9BCEFFD2D2D2FFF0F0F000F0F0F000A3CACDFF8AF9FFFF7DF4
      FEFF70EEFDFF68E9FDFF00D1F9FF26D7FBFF8CF0FEFF23DEFBFF00D3FAFF00CE
      F9FF00C8F8FF00C3F8FFE6E6E7FFF0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F00000FF0000C0C0C00000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF0000F0F0F000F0F0F000EFA95CFFF6CC9FFFF6CC9EFFF6CC
      9EFFF6CD9EFFF6CD9EFFF6CD9EFF8A715EFFF6CC9FFFF6CC9EFFF6CC9EFFF6CC
      9EFFF6CC9FFFF6CD9EFFEFA95CFFACACACFFF0F0F00008A0D7FFBCF1FFFFB9F1
      FFFFB2EFFFFFA6EDFFFF9CEBFFFF92E9FFFF6AE1FFFF3ED7FFFF35D6FFFF2BD4
      FFFF21D2FEFF0B9BCEFFD2D2D2FFF0F0F000F0F0F000F0F0F000A3CACDFF83F4
      FEFF76EFFDFF70EAFDFF53E0FBFF00CAF9FF01C6F9FF8AEEFDFF02D4FBFF00CE
      F9FF00C9F8FF00C4F8FFE6E6E7FFF0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000C0C0C00000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF0000F0F0F000F0F0F000F0F0F000F0A65DFFF6D2A8FFF6D1A8FFF6D2
      A8FFF6D2A8FFF6D2A7FFF6D2A8FF957E6DFFF6D2A7FFF6D1A8FFF6D2A8FFF6D1
      A8FFF6D2A7FFF6D2A7FFF0A65DFFE6E6E6FFF0F0F000F0F0F00010A9DFFFAFEB
      FCFFBFF2FFFFB5F0FFFFB0EEFFFFAEEFFFFFAFEEFFFFB0EFFFFFAAEEFFFF99EA
      FEFF79E4FEFF0B9BCEFFD2D2D2FFF0F0F000F0F0F000F0F0F000F0F0F000A2C8
      CCFF76EFFDFF70EAFDFF63E3FCFF4EDBFBFF00C5F8FF00C3F8FF79E7FDFF02CF
      FAFF00C9F8FF00C4F8FFE6E6E7FFF0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0000000000000FF000000FF000000FF000000FF000000FF000000FF
      0000F0F0F000F0F0F000F0F0F000F0F0F000EDA560FFF7D6B1FFF7D6B1FFF7D6
      B0FFF7D6B0FFF7D6B1FFF7D6B0FFA08B7CFFF7D6B0FFF7D6B0FFF7D6B1FFF7D6
      B0FFF7D6B0FFF7D6B1FFC37A34FFF0F0F000F0F0F000F0F0F00076E1FFFF4CCF
      FFFF23B4FAFF0EA8EAFF09A2D9FF08A0D7FF08A0D7FF08A0D7FF08A0D7FF08A0
      D7FF08A0D7FF0D9DD0FFF4F4F4FFF0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F0008EC4CFFF5CDDFCFF4FD7FBFF2BCDFAFF18CBFAFF8CEA
      FDFF2BD2FAFF00C4F8FFEBECECFFF0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F0000000000000FF000000FF000000FF0000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000FEF9F5FFF3B87DFFF8DBB9FFF8DA
      B9FFF8DBB9FFF8DBB9FFF8DBB9FFAA988AFFF8DAB9FFF8DAB9FFF8DBB9FFF8DB
      B9FFF8DBB9FFF3B97DFFDDD8D4FFF0F0F000F0F0F000F0F0F000A8EEFFFF9FEB
      FFFF8CE8FEFF6ADEFFFF22A5D0FF31B0D9FF31B1D9FF32B2DAFF32B2DAFF32B3
      DAFF32B3DBFFE3E3E3FFF0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F1F1F2FF55D9FBFF48D4FAFFF4F5F5FF95E0
      EFFF8CE7FCFF84E3FCFFF3F3F3FFF0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00000000000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F6CCA4FFF6CC9FFFF9DE
      C1FFF9DFC1FFF9DFC1FFF9DEC1FFB4A397FFF9DFC1FFF9DFC1FFF9DFC1FFF9DF
      C1FFF6CDA0FFCCA27BFFF0F0F000F0F0F000F0F0F000F0F0F00045BEE3FF09AC
      DDFF09ACDDFF70C1D9FFF9F9F9FFF0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000AFC7CEFFF0F0F000F0F0
      F00094D9E9FF8CE5FCFFF3F3F3FFF0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F6CCA4FFF4BE
      86FFF9E2C7FFF9E2C7FFF9E2C7FFF9E2C7FFF9E2C7FFF9E2C7FFF9E2C7FFF4BE
      86FFD9AF87FFF0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F00097D1E1FFF5F6F6FFF0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000FEF9
      F5FFEDA560FFF2B677FFF8D6B2FFFAE4CAFFF8D6B2FFF2B677FFDF9651FFFAF5
      F1FFF0F0F000F0F0F000F0F0F000F0F0F000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFFFFFFFFF0000
      FFFF0001FFFF0000FFFFBFF9FFFF0000FF1C8005EFCF0000FA008005E78F0000
      FEF08005F31F0000FC788005F83F0000F3F88925FC7F00000F78861DF87F0000
      F3F08005F13F0000C7DC8005E39F0000FFFF8005C7CF0000FFFF8001EFFF0000
      FFFF8003FFFF0000FFFFFFFFFFFF0000FFFFFEFFFFFFF81FFFFFF87FFFFFE007
      8001F03FFFFFC0038001E01FFFFF80018001C00FFF1F000180018007FE070000
      80018003FC01000080018001F801000080018001F001000080018001F0030000
      8001C001F0070000C001E001F80F0001C001FC01FE1F0001C003FE01FFBF8003
      C1FFFFB1FFFFC007FFFFFFF9FFFFE00F00000000000000000000000000000000
      000000000000}
  end
  object SavePictureDialog1: TSavePictureDialog
    DefaultExt = 'bmp'
    Filter = '.bmp|*.bmp'
    Left = 680
    Top = 8
  end
  object PopMenu_Result: TPopupMenu
    Images = ImageList1
    Left = 984
    Top = 8
    object ResultPop_Print_Phase: TMenuItem
      Caption = #20998#38454#27573#26174#31034#27493#36317
      ImageIndex = 27
      OnClick = ResultPop_Print_PhaseClick
    end
    object ResultPop_Print_whole: TMenuItem
      Caption = #25972#20307#26174#31034#27493#36317
      ImageIndex = 58
      OnClick = ResultPop_Print_wholeClick
    end
    object N22: TMenuItem
      Caption = '-'
    end
    object ResultPop_SaveTxt: TMenuItem
      Caption = #20445#23384#20026'TXT'#25991#20214
      ImageIndex = 2
      OnClick = ResultPop_SaveTxtClick
    end
    object N19: TMenuItem
      Caption = '-'
    end
    object ResultPop_SaveExcel: TMenuItem
      Caption = #20445#23384#20026'Excel'#25991#20214
      ImageIndex = 10
      OnClick = ResultPop_SaveExcelClick
    end
    object N21: TMenuItem
      Caption = '-'
    end
    object ResultPop_OpenLefttool: TMenuItem
      Caption = #25171#24320#24038#20391#24037#20855#26639
      ImageIndex = 54
      OnClick = ResultPop_OpenLefttoolClick
    end
    object N23: TMenuItem
      Caption = '-'
    end
    object ResultPop_OpenRightTool: TMenuItem
      Caption = #25171#24320#21491#20391#24037#20855#26639
      ImageIndex = 53
      OnClick = ResultPop_OpenRightToolClick
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 520
    Top = 8
  end
end