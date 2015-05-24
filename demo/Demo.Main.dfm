object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object memLog: TMemo
    Left = 8
    Top = 8
    Width = 505
    Height = 283
    Lines.Strings = (
      'memLog')
    TabOrder = 0
  end
  object btnGo: TButton
    Left = 544
    Top = 40
    Width = 75
    Height = 25
    Caption = 'btnGo'
    TabOrder = 1
    OnClick = btnGoClick
  end
  object btnCalc: TButton
    Left = 544
    Top = 71
    Width = 75
    Height = 25
    Caption = 'btnCalc'
    TabOrder = 2
    OnClick = btnCalcClick
  end
end
