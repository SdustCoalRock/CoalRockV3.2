object InPutExcel: TInPutExcel
  Left = 0
  Top = 0
  Caption = 'InPutExcel'
  ClientHeight = 397
  ClientWidth = 764
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 8
    Top = 8
    Width = 537
    Height = 321
    TabOrder = 0
  end
  object ADOCExcel: TADOConnection
    Left = 392
    Top = 8
  end
  object ADODataSetExcel: TADODataSet
    Connection = ADOCExcel
    Parameters = <>
    Left = 424
    Top = 8
  end
end
