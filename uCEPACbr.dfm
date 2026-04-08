object FuCEPACBr: TFuCEPACBr
  Left = 217
  Top = 116
  Width = 961
  Height = 400
  BorderIcons = [biSystemMenu]
  Caption = 'Endere'#231'o - CEP (ACBrMonitor)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    945
    362)
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 4
    Top = 8
    Width = 135
    Height = 16
    Caption = 'Indique o endere'#231'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabTexto: TLabel
    Left = 168
    Top = 272
    Width = 56
    Height = 14
    Caption = 'LabTexto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object cbEnderecos: TCheckListBox
    Left = 4
    Top = 28
    Width = 936
    Height = 292
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
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
    ParentFont = False
    TabOrder = 2
  end
  object MemoCmd: TMemo
    Left = 20
    Top = 60
    Width = 909
    Height = 89
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'MemoCmd')
    ParentFont = False
    TabOrder = 0
    Visible = False
  end
  object MemoRet: TMemo
    Left = 20
    Top = 156
    Width = 909
    Height = 89
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'MemoRet')
    ParentFont = False
    TabOrder = 1
    Visible = False
  end
  object btOk: TBitBtn
    Left = 48
    Top = 327
    Width = 107
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&Ok'
    TabOrder = 3
    OnClick = btOkClick
  end
  object btCancel: TBitBtn
    Left = 776
    Top = 327
    Width = 107
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Cancelar'
    TabOrder = 4
    OnClick = btCancelClick
  end
end
