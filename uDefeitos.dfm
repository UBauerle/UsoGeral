object FuDefeitos: TFuDefeitos
  Left = 232
  Top = 104
  BorderIcons = [biSystemMenu]
  Caption = 'Defeitos'
  ClientHeight = 449
  ClientWidth = 591
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
  Position = poDesigned
  ShowHint = True
  OnClose = FormClose
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    591
    449)
  PixelsPerInch = 96
  TextHeight = 13
  object PanCtl: TPanel
    Left = 0
    Top = 372
    Width = 591
    Height = 77
    Align = alBottom
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    DesignSize = (
      591
      77)
    object BtSair: TBitBtn
      Left = 484
      Top = 24
      Width = 96
      Height = 25
      Hint = 'Finalizar'
      Anchors = [akTop, akRight]
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
      TabOrder = 3
      OnClick = BtSairClick
    end
    object RgSelec: TRadioGroup
      Left = 237
      Top = 1
      Width = 116
      Height = 75
      Align = alLeft
      Caption = 'Sele'#231#227'o'
      Items.Strings = (
        'Sem sele'#231#227'o'
        'Relatados'
        'Constatados')
      TabOrder = 2
      OnClick = RgSelecClick
    end
    object RgOrdem: TRadioGroup
      Left = 137
      Top = 1
      Width = 100
      Height = 75
      Align = alLeft
      Caption = 'Ordem'
      Items.Strings = (
        'Num'#233'rica'
        'Alfabetica')
      TabOrder = 1
      OnClick = RgOrdemClick
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 136
      Height = 75
      Align = alLeft
      TabOrder = 0
      object LabNRegs: TLabel
        Left = 8
        Top = 31
        Width = 51
        Height = 13
        Caption = 'LabNRegs'
      end
      object Nav: TDBNavigator
        Left = 8
        Top = 5
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
        TabOrder = 0
      end
    end
  end
  object PanManut: TPanel
    Left = 0
    Top = 281
    Width = 591
    Height = 91
    Align = alBottom
    Enabled = False
    TabOrder = 1
    DesignSize = (
      591
      91)
    object LabAcao: TLabel
      Left = 519
      Top = 8
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
      Left = 114
      Top = 11
      Width = 36
      Height = 13
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 99
      Top = 35
      Width = 51
      Height = 13
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object edCod: TDBEdit
      Left = 152
      Top = 8
      Width = 48
      Height = 21
      Hint = 'C'#243'digo do registro na tabela'
      Color = 15138559
      DataField = 'Codigo'
      DataSource = STabWrk
      TabOrder = 1
    end
    object edDescr: TDBEdit
      Left = 152
      Top = 30
      Width = 424
      Height = 21
      Hint = 'Denomina'#231#227'o / descri'#231#227'o'
      CharCase = ecUpperCase
      Color = 15138559
      DataField = 'Descr'
      DataSource = STabWrk
      TabOrder = 2
    end
    object DbRgTipo: TDBRadioGroup
      Left = 1
      Top = 1
      Width = 92
      Height = 89
      Align = alLeft
      Caption = 'Tipo'
      Color = clBtnFace
      DataField = 'Tipo'
      DataSource = STabWrk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        '&1-Relatado'
        '&2-Constatado')
      ParentColor = False
      ParentFont = False
      TabOrder = 0
      Values.Strings = (
        '1'
        '2')
      OnEnter = DbRgTipoEnter
      OnExit = DbRgTipoExit
    end
    object BtOk: TBitBtn
      Left = 357
      Top = 57
      Width = 75
      Height = 25
      Hint = 'Confirma os dados'
      Anchors = [akTop, akRight]
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
      TabOrder = 3
      Visible = False
      OnClick = BtOkClick
    end
    object BtCanc: TBitBtn
      Left = 438
      Top = 57
      Width = 142
      Height = 25
      Hint = 'Cancela as informa'#231#245'es'
      Anchors = [akTop, akRight]
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
      TabOrder = 4
      Visible = False
      OnClick = BtCancClick
    end
  end
  object Grid: TDBGrid
    Left = 0
    Top = 0
    Width = 591
    Height = 281
    Hint = 'Conte'#250'do da tabela'
    Align = alClient
    DataSource = STabWrk
    DrawingStyle = gdsClassic
    FixedColor = clMoneyGreen
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = Alterar1Click
    Columns = <
      item
        Expanded = False
        FieldName = 'ZC_Tipo'
        Title.Caption = 'Tipo'
        Width = 86
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Codigo'
        Width = 48
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descr'
        Title.Caption = 'Descri'#231#227'o'
        Width = 466
        Visible = True
      end>
  end
  object Memo1: TMemo
    Left = 283
    Top = 120
    Width = 297
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
    TabOrder = 3
    Visible = False
  end
  object TabWrk: TTable
    AfterRefresh = TabWrkAfterRefresh
    OnCalcFields = TabWrkCalcFields
    DatabaseName = 'SISV'
    OnFilterRecord = TabWrkFilterRecord
    FieldDefs = <
      item
        Name = 'Tipo'
        DataType = ftSmallint
      end
      item
        Name = 'Codigo'
        DataType = ftSmallint
      end
      item
        Name = 'Descr'
        DataType = ftString
        Size = 80
      end>
    IndexDefs = <
      item
        Name = 'TabWrkIndex1'
        Fields = 'Tipo;Codigo'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'Alfabetica'
        Fields = 'Tipo;Descr'
        Options = [ixCaseInsensitive]
      end>
    StoreDefs = True
    TableName = 'Tb18Defeitos.db'
    Left = 12
    Top = 142
    object TabWrkTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object TabWrkCodigo: TSmallintField
      FieldName = 'Codigo'
    end
    object TabWrkDescr: TStringField
      FieldName = 'Descr'
      Size = 80
    end
    object TabWrkZC_Tipo: TStringField
      FieldKind = fkCalculated
      FieldName = 'ZC_Tipo'
      Size = 10
      Calculated = True
    end
  end
  object STabWrk: TDataSource
    DataSet = TabWrk
    Left = 42
    Top = 142
  end
  object Menu: TMainMenu
    Left = 60
    Top = 52
    object Defeitos1: TMenuItem
      Caption = '&Defeitos'
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
        Visible = False
      end
      object Imprimir1: TMenuItem
        Caption = 'Im&primir'
        ShortCut = 16464
        Visible = False
        OnClick = Imprimir1Click
      end
    end
    object Sair1: TMenuItem
      Caption = '&Sair'
      OnClick = BtSairClick
    end
  end
end
