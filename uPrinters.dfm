object FuPrinters: TFuPrinters
  Left = 328
  Top = 212
  Width = 570
  Height = 536
  Caption = 'Indique impressora...'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object PanFormaImpressao: TPanel
    Left = 100
    Top = 32
    Width = 281
    Height = 129
    BevelOuter = bvNone
    TabOrder = 0
    Visible = False
    object rgForma: TRadioGroup
      Left = 45
      Top = 12
      Width = 156
      Height = 109
      Caption = 'Forma de impress'#227'o'
      Items.Strings = (
        '&Gr'#225'fica'
        '&Matricial'
        '&T'#233'rmica'
        '&Cancelar')
      TabOrder = 0
      OnClick = rgFormaClick
    end
  end
  object PanRelatorio: TPanel
    Left = 0
    Top = 0
    Width = 554
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PanRelatorio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object gbPrinters: TGroupBox
    Left = 19
    Top = 187
    Width = 485
    Height = 126
    Caption = 'Impressoras dispon'#237'veis'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Visible = False
    DesignSize = (
      485
      126)
    object CbImpress: TComboBox
      Left = 12
      Top = 25
      Width = 460
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 16
      TabOrder = 0
      Text = 'CbImpress'
    end
    object btPadrao: TBitBtn
      Left = 11
      Top = 88
      Width = 201
      Height = 28
      Anchors = [akLeft, akBottom]
      Caption = '&Impressora Padr'#227'o'
      TabOrder = 1
      OnClick = btPadraoClick
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
    object btOkPrinter: TBitBtn
      Left = 372
      Top = 88
      Width = 97
      Height = 25
      Hint = ' '
      Anchors = [akRight, akBottom]
      Caption = '&Ok'
      Default = True
      TabOrder = 2
      OnClick = btOkPrinterClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object btCancelPrinter: TBitBtn
      Left = 268
      Top = 88
      Width = 97
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Cancelar'
      TabOrder = 3
      OnClick = btCancelPrinterClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
  object PanImpressao: TPanel
    Left = 56
    Top = 316
    Width = 409
    Height = 173
    BevelOuter = bvNone
    TabOrder = 3
    Visible = False
    DesignSize = (
      409
      173)
    object Label1: TLabel
      Left = 37
      Top = 60
      Width = 46
      Height = 16
      Caption = 'C'#243'pias:'
    end
    object LabPrinter: TLabel
      Left = 88
      Top = 8
      Width = 72
      Height = 16
      Caption = 'LabPrinter'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabPorta: TLabel
      Left = 88
      Top = 32
      Width = 64
      Height = 16
      Caption = 'LabPorta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 12
      Top = 8
      Width = 71
      Height = 16
      Caption = 'Impressora:'
    end
    object Label4: TLabel
      Left = 48
      Top = 32
      Width = 35
      Height = 16
      Caption = 'Porta:'
    end
    object CbCopias: TComboBox
      Left = 88
      Top = 56
      Width = 53
      Height = 24
      ItemHeight = 16
      TabOrder = 0
      Text = 'CbCopias'
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
    object CbEject: TCheckBox
      Left = 12
      Top = 92
      Width = 280
      Height = 17
      Caption = 'Ejetar &pagina ao final da impress'#227'o'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object CbDelete: TCheckBox
      Left = 12
      Top = 116
      Width = 280
      Height = 17
      Caption = '&Excluir ap'#243's a impress'#227'o'
      TabOrder = 2
    end
    object btCancelImpressao: TBitBtn
      Left = 200
      Top = 140
      Width = 97
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Cancelar'
      TabOrder = 3
      OnClick = btCancelImpressaoClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object btImprimir: TBitBtn
      Left = 304
      Top = 140
      Width = 97
      Height = 25
      Hint = ' '
      Anchors = [akRight, akBottom]
      Caption = '&Imprimir'
      Default = True
      TabOrder = 4
      OnClick = btImprimirClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
    end
  end
end
