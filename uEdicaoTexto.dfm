object FuEdicaoTexto: TFuEdicaoTexto
  Left = 536
  Top = 203
  BorderIcons = [biSystemMenu]
  Caption = 'Editar .ini'
  ClientHeight = 441
  ClientWidth = 565
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 12
    Top = 12
    Width = 314
    Height = 32
    Caption = 'Carrengando, aguarde...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 380
    Width = 565
    Height = 61
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      565
      61)
    object LabLinha: TLabel
      Left = 4
      Top = 36
      Width = 64
      Height = 16
      Caption = 'LabLinha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object SpeedButton1: TSpeedButton
      Left = 8
      Top = 10
      Width = 23
      Height = 22
      Caption = 'F-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 40
      Top = 10
      Width = 23
      Height = 22
      Caption = 'F+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton2Click
    end
    object LabQtd: TLabel
      Left = 521
      Top = 36
      Width = 35
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'LabQtd'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LabTamFonte: TLabel
      Left = 72
      Top = 12
      Width = 85
      Height = 16
      Caption = 'LabTamFonte'
    end
    object btSalvar: TBitBtn
      Left = 128
      Top = 8
      Width = 95
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Salvar'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        33333FFFFFFFFFFFFFFF000000000000000077777777777777770F7777777777
        77707F3F3333333333370F988888888888707F733FFFFFFFF3370F8800000000
        88707F337777777733370F888888888888707F333FFFFFFFF3370F8800000000
        88707F337777777733370F888888888888707F333333333333370F8888888888
        88707F333333333333370FFFFFFFFFFFFFF07FFFFFFFFFFFFFF7000000000000
        0000777777777777777733333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btSalvarClick
    end
    object btSalvarSair: TBitBtn
      Left = 229
      Top = 8
      Width = 124
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Salvar e sai&r'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333FFFFFFFFFFFFFFF000000000000000088888888888888880F8888888888
        88808F3F3333333333380F977777777777808F833FFFFFFFF3380F7700000000
        77808F338888888833380F777777777777808F333FFFFFFFF3380F7709000000
        77808F338888888833380F777977777777808F333F33333333380F7799977777
        77808F333F33333333380FFF999FFFFFFFF08FFFF8FFFFFFFFF8000999990000
        00008888F8F8888888883339999933333333333F888F33333333339999999333
        333333F88888F3333333339999999333333333FFF8FFF3333333333399933333
        33333333F8F33333333333339993333333333333F8F333333333}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btSalvarSairClick
    end
    object btCanc: TBitBtn
      Left = 356
      Top = 8
      Width = 200
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Abandonar altera'#231#245'es'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
        66666666666666666666650666666666650677F66666666667F6655066666666
        5506777F6666666677F66550666666655506677F6666666777F6655506666655
        50666777F66666777F66665550066555066666777FF66777F666666555505550
        66666667777F777F666666665555550666666666777777F66666666666555506
        66666666667777F66666666665555550666666666777777F6666666655505555
        06666666777F7777F6666665550666555066666777F666777F66665550666665
        550666777F66666777F665550666666655066777F666666677F6655506666666
        65066777F666666667F666666666666666666666666666666666}
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btCancClick
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 565
    Height = 380
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'Memo1'
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
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '20'
      '21'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
    OnExit = Memo1Exit
    OnKeyDown = Memo1KeyDown
  end
end
