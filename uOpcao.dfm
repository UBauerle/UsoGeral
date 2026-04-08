object FuOpcao: TFuOpcao
  Left = 192
  Top = 127
  Width = 524
  Height = 236
  BorderIcons = [biSystemMenu]
  Caption = 'Indique a op'#231#227'o'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 508
    Height = 157
    Align = alClient
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LabTitulo: TLabel
      Left = 12
      Top = 8
      Width = 75
      Height = 20
      Caption = 'LabTitulo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabMens: TLabel
      Left = 40
      Top = 40
      Width = 56
      Height = 16
      Caption = 'LabMens'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 157
    Width = 508
    Height = 41
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      508
      41)
    object btUm: TBitBtn
      Left = 8
      Top = 8
      Width = 121
      Height = 25
      Caption = 'btUm'
      TabOrder = 1
      OnClick = btUmClick
      NumGlyphs = 2
    end
    object btDois: TBitBtn
      Left = 132
      Top = 8
      Width = 121
      Height = 25
      Caption = 'btDois'
      TabOrder = 2
      OnClick = btDoisClick
      NumGlyphs = 2
    end
    object btTres: TBitBtn
      Left = 256
      Top = 8
      Width = 121
      Height = 25
      Caption = 'btTres'
      TabOrder = 3
      OnClick = btTresClick
      NumGlyphs = 2
    end
    object btCancel: TBitBtn
      Left = 384
      Top = 8
      Width = 85
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Cancelar'
      TabOrder = 4
      OnClick = btCancelClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
        6666666FFFF6666666FF6619996666666996667888F66666688F666199966666
        99166667888F6666887F66661996666991666666788F666887F6666661996699
        166666666788FF887F666666619999916666666667888887F666666666199916
        666666666678887F6666666666999966666666666F8888F66666666669991996
        66666666F888788F66666666999161996666666F88876788F666666999166619
        966666F8887666788F6666999166666996666688876666678F66669916666661
        996666887666666788F66691666666661996668766666666788F666666666666
        6199666666666666678866666666666666666666666666666666}
      NumGlyphs = 2
    end
    object btNothing: TBitBtn
      Left = 476
      Top = 8
      Width = 21
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 0
    end
  end
end
