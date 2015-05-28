object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Main'
  ClientHeight = 299
  ClientWidth = 618
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object memLog: TMemo
    Left = 8
    Top = 8
    Width = 505
    Height = 283
    TabOrder = 0
  end
  object btnGo: TButton
    Left = 519
    Top = 8
    Width = 91
    Height = 25
    Caption = 'Demo1'
    TabOrder = 1
    OnClick = btnDemo1Click
  end
  object btnCalc: TButton
    Left = 519
    Top = 70
    Width = 91
    Height = 25
    Caption = 'Demo 3'
    TabOrder = 2
    OnClick = btnDemo3Click
  end
  object Button1: TButton
    Left = 519
    Top = 39
    Width = 91
    Height = 25
    Caption = 'Demo 2'
    TabOrder = 3
    OnClick = btnDemo2Click
  end
  object btnUpdate: TButton
    Left = 519
    Top = 125
    Width = 91
    Height = 25
    Caption = 'Update Demo'
    TabOrder = 4
    OnClick = btnUpdateClick
  end
end
