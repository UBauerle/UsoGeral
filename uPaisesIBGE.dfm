object FPaisesIBGE: TFPaisesIBGE
  Left = 250
  Top = 120
  Width = 492
  Height = 580
  Caption = 'Manuten'#231#227'o - Pa'#237'ses IBGE'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MenuPrinc
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 476
    Height = 3
    Align = alTop
    BevelOuter = bvNone
    Color = clMaroon
    TabOrder = 0
  end
  object PanCtle: TPanel
    Left = 0
    Top = 460
    Width = 476
    Height = 62
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      476
      62)
    object LabNRegs: TLabel
      Left = 12
      Top = 36
      Width = 51
      Height = 13
      Caption = 'LabNRegs'
    end
    object Label2: TLabel
      Left = 124
      Top = 4
      Width = 34
      Height = 13
      Alignment = taRightJustify
      Caption = 'Ordem:'
    end
    object LabLocaliz: TLabel
      Left = 224
      Top = 4
      Width = 45
      Height = 13
      Alignment = taRightJustify
      Caption = 'Localizar:'
    end
    object Nav: TDBNavigator
      Left = 12
      Top = 8
      Width = 96
      Height = 25
      DataSource = SPaises
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      TabOrder = 0
    end
    object CbOrdem: TComboBox
      Left = 124
      Top = 16
      Width = 93
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = 'CbOrdem'
      OnChange = CbOrdemChange
      Items.Strings = (
        'C'#243'digo'
        'Alfab'#233'tica')
    end
    object EdLocaliz: TEdit
      Left = 224
      Top = 16
      Width = 129
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 2
      Text = 'EDLOCALIZ'
      OnChange = EdLocalizChange
    end
    object btSair: TBitBtn
      Left = 356
      Top = 12
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Sair'
      TabOrder = 3
      OnClick = btSairClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333388888888888F333301BBBBBBBB033333883F3333338F3333011BBBBBBB
        0333338F83F333338F33330111BBBBBB0333338F383F33338F333301110BBBBB
        0333338F338F33338F333301110BBBBB0333338F338F33338F333301110BBBBB
        0333338F338F33338F3F3301110BBBBB0393338F338F33338FF83301110BBBBB
        0993338F338F3F338F883301110BB9BB9993338F338FF8F3F883330111B0B9B9
        9933338F338838FF88333301110BB9999333338F338F38F88F333301110BB999
        0333338F3F8F38888F333301E10BB9999933338F8F8F388888333301EE0BBBBB
        0333338F888FFFFF8F3333000000000003333388888888888333}
      NumGlyphs = 2
    end
    object btNothing: TBitBtn
      Left = 442
      Top = 12
      Width = 25
      Height = 25
      Caption = '...'
      TabOrder = 4
      TabStop = False
    end
  end
  object Grid: TDBGrid
    Left = 0
    Top = 3
    Width = 476
    Height = 376
    Align = alClient
    DataSource = SPaises
    FixedColor = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'Cod'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Pais'
        Title.Caption = 'Denomina'#231#227'o do pa'#237's'
        Width = 369
        Visible = True
      end>
  end
  object PanManut: TPanel
    Left = 0
    Top = 379
    Width = 476
    Height = 81
    Align = alBottom
    Enabled = False
    TabOrder = 3
    DesignSize = (
      476
      81)
    object LabAcao: TLabel
      Left = 418
      Top = 0
      Width = 50
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Consulta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 68
      Top = 8
      Width = 66
      Height = 13
      Caption = 'Denomina'#231#227'p'
    end
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 47
      Height = 13
      Caption = 'C'#243'd IBGE'
    end
    object edCodigo: TDBEdit
      Left = 8
      Top = 20
      Width = 53
      Height = 21
      DataField = 'Cod'
      DataSource = SPaises
      MaxLength = 5
      TabOrder = 0
    end
    object BtOk: TBitBtn
      Left = 288
      Top = 49
      Width = 87
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Ok'
      TabOrder = 2
      Visible = False
      OnClick = BtOkClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      NumGlyphs = 2
    end
    object BtCanc: TBitBtn
      Left = 380
      Top = 49
      Width = 87
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Cancelar'
      TabOrder = 3
      Visible = False
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
    object edDenom: TDBEdit
      Left = 68
      Top = 20
      Width = 365
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Pais'
      DataSource = SPaises
      TabOrder = 1
    end
  end
  object MenuPrinc: TMainMenu
    Left = 176
    Top = 76
    object Pais1: TMenuItem
      Caption = '&Pais'
      object Incluir1: TMenuItem
        Caption = '&Incluir'
        ShortCut = 16457
        OnClick = Incluir1Click
      end
      object Alterar1: TMenuItem
        Caption = '&Alterar'
        ShortCut = 16449
        OnClick = Alterar1Click
      end
      object Excluir1: TMenuItem
        Caption = '&Excluir'
        ShortCut = 16453
        OnClick = Excluir1Click
      end
    end
    object Sair: TMenuItem
      Caption = '&Sair'
      OnClick = btSairClick
    end
  end
  object Paises: TTable
    DatabaseName = 'SISV4'
    TableName = 'TS_Paises.DB'
    Left = 17
    Top = 54
    object PaisesCod: TSmallintField
      FieldName = 'Cod'
    end
    object PaisesPais: TStringField
      FieldName = 'Pais'
      Size = 50
    end
  end
  object SPaises: TDataSource
    DataSet = Paises
    Left = 49
    Top = 54
  end
end
