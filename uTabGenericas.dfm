object FTabGener: TFTabGener
  Left = 267
  Top = 146
  BorderIcons = [biSystemMenu]
  Caption = 'Tabelas comuns....'
  ClientHeight = 521
  ClientWidth = 539
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000008
    888880BBBBBB08888880000000000008888880BBBBBB08888880000000000008
    888880BBBBBB088888800000000000000000000000000000000088800000000B
    BBBBB08888880BBBBBB088808000000BBBBBB08888880BBBBBB088800000000B
    BBBBB08888880BBBBBB000008880000000000000000000000000BBB088800008
    888880BBBBBB08888880BBB088800008888880BBBBBB08888880BBB000000008
    888880BBBBBB088888800000BBB00000000000000000000000008880BBB0000B
    BBBBB08888880BBBBBB08880BBB0000BBBBBB08888880BBBBBB088800000000B
    BBBBB08888880BBBBBB000008880000000000000000000000000BBB088800008
    888880BBBBBB08888880BBB088800008888880BBBBBB08888880BBB000000008
    888880BBBBBB088888800000BBB00000000000000000000000008880BBB0000B
    BBBBB08888880BBBBBB08880BBB0000BBBBBB08888880BBBBBB088800000000B
    BBBBB08888880BBBBBB000008880000000000000000000000000BBB088800000
    000BBBBBB08888880BBBBBB088800000000BBBBBB08888880BBBBBB000000000
    000000000000000000000000BBB000000000000BBBBBB08888880BBBBBB00000
    0000000BBBBBB08888880BBBBBB000000000000000000000000000000000FFFF
    FFFFC00000FFC00000FFC00000FFC000000FC0000003C0000003C0000000C000
    0000C0000000C0000000C0000000C0000000C0000000C0000000C0000000C000
    0000C0000000C0000000C0000000C0000000C0000000C0000000C0000000C000
    0000C0000000FC000000FC000000FC000000FFC00000FFC00000FFC00000}
  Menu = Menu
  OldCreateOrder = False
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  DesignSize = (
    539
    521)
  PixelsPerInch = 96
  TextHeight = 13
  object PanCtl: TPanel
    Left = 0
    Top = 443
    Width = 539
    Height = 78
    Align = alBottom
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    DesignSize = (
      539
      78)
    object LabLocalizar: TLabel
      Left = 116
      Top = 52
      Width = 45
      Height = 13
      Caption = 'Localizar:'
    end
    object LabNRegs: TLabel
      Left = 48
      Top = 36
      Width = 51
      Height = 13
      Caption = 'LabNRegs'
    end
    object btTamOrig: TSpeedButton
      Left = 344
      Top = 6
      Width = 35
      Height = 35
      Glyph.Data = {
        9E000000424D9E000000000000003E0000002800000018000000180000000100
        01000000000060000000C40E0000C40E0000020000000000000000000000FFFF
        FF00FFE7FF00FFC3FF00FF81FF00FF00FF00FE007F00FFC3FF00FC003F00F400
        2F00E4FF2700C4FF230080FF010000FF000000FF000080FF0100C4FF2300E4FF
        2700F4002F00FC003F00FFC3FF00FE007F00FF00FF00FF81FF00FFC3FF00FFE7
        FF00}
      OnClick = btTamOrigClick
    end
    object BtSair: TBitBtn
      Left = 390
      Top = 8
      Width = 142
      Height = 25
      Hint = 'Finalizar'
      Anchors = [akRight, akBottom]
      Caption = '&Sair'
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
      TabOrder = 2
      OnClick = BtSairClick
    end
    object RgOrdem: TRadioGroup
      Left = 117
      Top = 5
      Width = 172
      Height = 38
      Caption = 'Ordem dos dados'
      Columns = 2
      Items.Strings = (
        'Num'#233'rica'
        'Alfab'#233'tica')
      TabOrder = 0
      Visible = False
      OnClick = RgOrdemClick
    end
    object edLocaliz: TEdit
      Left = 164
      Top = 48
      Width = 161
      Height = 21
      TabOrder = 1
      Text = 'edLocaliz'
      OnChange = edLocalizChange
    end
    object Nav: TDBNavigator
      Left = 8
      Top = 8
      Width = 96
      Height = 25
      DataSource = STabWrk
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      Hints.Strings = (
        'Primeiro '
        'Anterior'
        'Pr'#243'ximo'
        #218'ltimo'
        'Insert record'
        'Delete record'
        'Edit record'
        'Post edit'
        'Cancel edit'
        'Refresh data')
      TabOrder = 3
    end
    object cbDestaq: TCheckBox
      Left = 438
      Top = 40
      Width = 91
      Height = 17
      Anchors = [akRight, akBottom]
      Caption = 'Destacar linha'
      TabOrder = 4
      OnClick = cbDestaqClick
    end
  end
  object PanManut: TPanel
    Left = 0
    Top = 350
    Width = 539
    Height = 93
    Align = alBottom
    Enabled = False
    ParentColor = True
    TabOrder = 1
    DesignSize = (
      539
      93)
    object LabAcao: TLabel
      Left = 471
      Top = 4
      Width = 61
      Height = 16
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Consulta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 8
      Top = 12
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 64
      Top = 12
      Width = 125
      Height = 13
      Caption = 'Denomina'#231#227'o / Descri'#231#227'o'
    end
    object LabAbrev: TLabel
      Left = 64
      Top = 48
      Width = 54
      Height = 13
      Caption = 'Abreviatura'
    end
    object EdCod: TDBEdit
      Left = 8
      Top = 24
      Width = 48
      Height = 21
      Hint = 'C'#243'digo do registro na tabela'
      DataField = 'Cod'
      DataSource = STabWrk
      Enabled = False
      TabOrder = 0
    end
    object EdDenom: TDBEdit
      Left = 64
      Top = 24
      Width = 281
      Height = 21
      Hint = 'Denomina'#231#227'o / descri'#231#227'o'
      DataField = 'Denom'
      DataSource = STabWrk
      TabOrder = 1
    end
    object EdAbrev: TDBEdit
      Left = 64
      Top = 60
      Width = 100
      Height = 21
      Hint = 'Abreviatura'
      CharCase = ecUpperCase
      DataField = 'Abrev'
      DataSource = STabWrk
      TabOrder = 2
      OnDblClick = EdAbrevDblClick
      OnKeyDown = EdAbrevKeyDown
    end
    object DbFixa: TDBCheckBox
      Left = 172
      Top = 62
      Width = 125
      Height = 17
      Caption = 'Fixa....'
      DataField = 'Fixa'
      DataSource = STabWrk
      TabOrder = 3
      Visible = False
    end
    object BtOk: TBitBtn
      Left = 457
      Top = 21
      Width = 75
      Height = 25
      Hint = 'Confirma os dados'
      Anchors = [akRight, akBottom]
      Caption = '&Ok'
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
      TabOrder = 4
      Visible = False
      OnClick = BtOkClick
    end
    object BtCanc: TBitBtn
      Left = 390
      Top = 53
      Width = 142
      Height = 25
      Hint = 'Cancela as informa'#231#245'es'
      Anchors = [akRight, akBottom]
      Caption = '&Cancelar/Finalizar'
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
      TabOrder = 5
      Visible = False
      OnClick = BtCancClick
    end
    object dbFPgto: TDBCheckBox
      Left = 300
      Top = 62
      Width = 81
      Height = 17
      Caption = 'Folha pagto'
      DataField = 'Pessoal'
      DataSource = STabWrk
      TabOrder = 6
      Visible = False
    end
  end
  object Grid: TDBGrid
    Left = 0
    Top = 3
    Width = 539
    Height = 347
    Hint = 'Conte'#250'do da tabela'
    Align = alClient
    DataSource = STabWrk
    FixedColor = clMoneyGreen
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = GridDrawColumnCell
    OnDblClick = Alterar1Click
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'Cod'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'digo'
        Width = 48
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Denom'
        Title.Caption = 'Denomina'#231#227'o / Descri'#231#227'o'
        Width = 262
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Abrev'
        Title.Caption = 'Abreviatura'
        Width = 100
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ZC_Fixa'
        Title.Alignment = taCenter
        Title.Caption = 'Inform'
        Width = 83
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 539
    Height = 3
    Align = alTop
    BevelOuter = bvNone
    Color = clMaroon
    TabOrder = 3
  end
  object Memo1: TMemo
    Left = 159
    Top = 213
    Width = 376
    Height = 121
    Anchors = [akRight, akBottom]
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clAqua
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    Visible = False
  end
  object TabWrk: TTable
    AfterRefresh = TabWrkAfterRefresh
    OnCalcFields = TabWrkCalcFields
    DatabaseName = 'SISV'
    FieldDefs = <
      item
        Name = 'Cod'
        DataType = ftSmallint
      end
      item
        Name = 'Denom'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Abrev'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'Fixa'
        DataType = ftBoolean
      end
      item
        Name = 'KPlano'
        DataType = ftString
        Size = 12
      end
      item
        Name = 'Pessoal'
        DataType = ftBoolean
      end>
    StoreDefs = True
    TableName = 'Tb07RDe.DB'
    Left = 160
    Top = 42
    object TabWrkCod: TSmallintField
      FieldName = 'Cod'
    end
    object TabWrkDenom: TStringField
      FieldName = 'Denom'
      Size = 50
    end
    object TabWrkAbrev: TStringField
      FieldName = 'Abrev'
      Size = 15
    end
    object TabWrkFixa: TBooleanField
      FieldName = 'Fixa'
    end
    object TabWrkKPlano: TStringField
      FieldName = 'KPlano'
      Size = 12
    end
    object TabWrkPessoal: TBooleanField
      FieldName = 'Pessoal'
    end
    object TabWrkZC_Fixa: TStringField
      FieldKind = fkCalculated
      FieldName = 'ZC_Fixa'
      Calculated = True
    end
  end
  object STabWrk: TDataSource
    DataSet = TabWrk
    Left = 194
    Top = 42
  end
  object Menu: TMainMenu
    Left = 76
    Top = 80
    object Topico: TMenuItem
      Caption = 'Topico'
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
      object N1: TMenuItem
        Caption = '-'
      end
      object Imprimir1: TMenuItem
        Caption = 'Im&primir'
        ShortCut = 16464
        OnClick = Imprimir1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object RetirarIndicador1: TMenuItem
        Caption = 'Retirar indicador'
        OnClick = RetirarIndicador1Click
      end
    end
    object Sair1: TMenuItem
      Caption = '&Sair'
      OnClick = BtSairClick
    end
  end
  object CadEstoq: TTable
    DatabaseName = 'SISV'
    FieldDefs = <
      item
        Name = 'Item'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'Descr'
        DataType = ftString
        Size = 45
      end
      item
        Name = 'DescrCmpl'
        DataType = ftMemo
        Size = 10
      end
      item
        Name = 'Unid'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'Refer'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'Grupo'
        DataType = ftSmallint
      end
      item
        Name = 'Import'
        DataType = ftSmallint
      end
      item
        Name = 'QbLote'
        DataType = ftBoolean
      end
      item
        Name = 'DtCadas'
        DataType = ftDate
      end
      item
        Name = 'Forn01'
        DataType = ftInteger
      end
      item
        Name = 'Forn02'
        DataType = ftInteger
      end
      item
        Name = 'Forn03'
        DataType = ftInteger
      end
      item
        Name = 'VMAnt'
        DataType = ftCurrency
      end
      item
        Name = 'QtdAnt'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'E_Compra'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'E_Produc'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'E_Devol'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'E_Outras'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'E_Data'
        DataType = ftDate
      end
      item
        Name = 'S_Venda'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'S_Produc'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'S_Devol'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'S_Outras'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'S_Data'
        DataType = ftDate
      end
      item
        Name = 'QtdAtu'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'VMAtu'
        DataType = ftCurrency
      end
      item
        Name = 'NPer'
        DataType = ftInteger
      end
      item
        Name = 'E_Acum'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'S_Acum'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'ABCFin'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ABCFCalc'
        DataType = ftInteger
      end
      item
        Name = 'ABCQtd'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ABCQCalc'
        DataType = ftInteger
      end
      item
        Name = 'DDRep'
        DataType = ftSmallint
      end
      item
        Name = 'Min'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'Max'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'STrib'
        DataType = ftSmallint
      end
      item
        Name = 'STribFE'
        DataType = ftSmallint
      end
      item
        Name = 'CFisc'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'LP01'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'LP02'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'LP03'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'LP04'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'LP05'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'LP06'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'Embalag'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'EmbalQtd'
        DataType = ftInteger
      end
      item
        Name = 'AliqICM'
        DataType = ftBCD
        Precision = 32
        Size = 2
      end
      item
        Name = 'AliqICMFE'
        DataType = ftBCD
        Precision = 32
        Size = 2
      end
      item
        Name = 'EtiqsLst'
        DataType = ftInteger
      end
      item
        Name = 'Custo'
        DataType = ftCurrency
      end
      item
        Name = 'QtdCusto'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'DtCusto'
        DataType = ftDate
      end
      item
        Name = 'LPSugest'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'CFOP'
        DataType = ftSmallint
      end
      item
        Name = 'CFOPFE'
        DataType = ftSmallint
      end
      item
        Name = 'Marca'
        DataType = ftSmallint
      end
      item
        Name = 'LPImpres'
        DataType = ftBoolean
      end
      item
        Name = 'STEst'
        DataType = ftBCD
        Precision = 32
        Size = 2
      end
      item
        Name = 'STFEst'
        DataType = ftBCD
        Precision = 32
        Size = 2
      end
      item
        Name = 'Prd_EAN'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'Prd_ExTIPI'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'Prd_Genero'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'ICM_ModBC'
        DataType = ftSmallint
      end
      item
        Name = 'ICM_PRedBC'
        DataType = ftBCD
        Precision = 32
        Size = 2
      end
      item
        Name = 'ICM_ModBCST'
        DataType = ftSmallint
      end
      item
        Name = 'ICM_PMVAST'
        DataType = ftBCD
        Precision = 32
        Size = 2
      end
      item
        Name = 'ICM_PRedBCST'
        DataType = ftBCD
        Precision = 32
        Size = 2
      end
      item
        Name = 'IPI'
        DataType = ftBoolean
      end
      item
        Name = 'IPI_Classe'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'IPI_CodEnquadr'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'IPI_Trib'
        DataType = ftBoolean
      end
      item
        Name = 'IPI_CST_E'
        DataType = ftSmallint
      end
      item
        Name = 'IPI_CST_S'
        DataType = ftSmallint
      end
      item
        Name = 'IPI_TribModo'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'PIS'
        DataType = ftBoolean
      end
      item
        Name = 'PIS_CST'
        DataType = ftSmallint
      end
      item
        Name = 'PIS_Aliq'
        DataType = ftBCD
        Precision = 32
        Size = 2
      end
      item
        Name = 'PIS_AliqUnit'
        DataType = ftBCD
        Precision = 32
        Size = 4
      end
      item
        Name = 'COF'
        DataType = ftBoolean
      end
      item
        Name = 'COF_CST'
        DataType = ftSmallint
      end
      item
        Name = 'COF_Aliq'
        DataType = ftBCD
        Precision = 32
        Size = 2
      end
      item
        Name = 'COF_AliqUnit'
        DataType = ftBCD
        Precision = 32
        Size = 4
      end
      item
        Name = 'Tribut_PRIOR'
        DataType = ftBoolean
      end
      item
        Name = 'EmbalPeso'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'PesoUnit'
        DataType = ftBCD
        Precision = 32
        Size = 3
      end
      item
        Name = 'NCM'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'GrupoMO'
        DataType = ftSmallint
      end>
    IndexDefs = <
      item
        Name = 'CadEstoqIndex1'
        Fields = 'Item'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'Referencia'
        Fields = 'Refer'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'F1Descr'
        Fields = 'Forn01;Descr'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'F2Descr'
        Fields = 'Forn02;Descr'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'F3Descr'
        Fields = 'Forn03;Descr'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'GrupoDescr'
        Fields = 'Grupo;Descr'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'Descricao'
        Fields = 'Descr'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'ReferDescr'
        Fields = 'Refer;Descr'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'GrupoItem'
        Fields = 'Grupo;Item'
        Options = [ixCaseInsensitive]
      end>
    StoreDefs = True
    TableName = 'Estoques.DB'
    Left = 268
    Top = 42
    object CadEstoqItem: TStringField
      FieldName = 'Item'
      Size = 13
    end
    object CadEstoqDescr: TStringField
      FieldName = 'Descr'
      Size = 45
    end
  end
end
