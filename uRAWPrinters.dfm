object FuRAWPrinters: TFuRAWPrinters
  Left = 194
  Top = 103
  Width = 478
  Height = 216
  BorderIcons = [biSystemMenu]
  Caption = 'Indique impressora a utilizar'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 134
    Width = 462
    Height = 44
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      462
      44)
    object btOk: TBitBtn
      Left = 12
      Top = 8
      Width = 121
      Height = 28
      Caption = '&Ok'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btOkClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555005555
        5555555555FF55555555555555A0055555555555558FF555555555555AAA0555
        555555555888F55555555555AAAAA0555555555588888F555555555AAA5AAA05
        55555558885888F55555550AA555AAA0555555F88555888F555550A555555AAA
        05555F8555555888F55555555500555AA0055555558855588FF5555555200555
        AAA5555555788555888555555222055555555555577785555555555522222055
        5555555577777855555555522252220555555557775777855555550225552220
        5555558775557778555550255555522205555875555557778555555555555552
        2005555555555557788555555555555522255555555555557775}
      NumGlyphs = 2
    end
    object BtCanc: TBitBtn
      Left = 329
      Top = 8
      Width = 121
      Height = 28
      Anchors = [akTop, akRight]
      Caption = '&Cancelar '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BtCancClick
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
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 462
    Height = 134
    Align = alClient
    TabOrder = 1
    DesignSize = (
      462
      134)
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 460
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = 'Impressoras dispon'#237'veis'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object cbImpress: TComboBox
      Left = 12
      Top = 29
      Width = 437
      Height = 28
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 20
      ParentFont = False
      TabOrder = 0
      Text = 'cbImpress'
    end
    object BtPadr: TBitBtn
      Left = 272
      Top = 80
      Width = 176
      Height = 28
      Anchors = [akTop, akRight]
      Caption = '&Impressora Padr'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BtPadrClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        0003377777777777777308888888888888807F33333333333337088888888888
        88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
        8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
        8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
    end
  end
end
