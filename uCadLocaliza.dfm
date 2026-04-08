object FuCadLocaliza: TFuCadLocaliza
  Left = 224
  Top = 120
  Width = 586
  Height = 566
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Pesquisa de cadastro'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object PanBot: TPanel
    Left = 0
    Top = 416
    Width = 570
    Height = 95
    Align = alBottom
    Caption = ' '
    ParentColor = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    DesignSize = (
      570
      95)
    object LabNRegs: TLabel
      Left = 8
      Top = 78
      Width = 51
      Height = 13
      Caption = 'LabNRegs'
    end
    object Label4: TLabel
      Left = 192
      Top = 8
      Width = 42
      Height = 13
      Caption = 'Localizar'
    end
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 166
      Height = 13
      Caption = 'Ordem de apresenta'#231#227'o dos dados'
    end
    object Label2: TLabel
      Left = 512
      Top = 8
      Width = 28
      Height = 13
      Caption = 'E/OU'
    end
    object ImgTamOrig: TImage
      Left = 272
      Top = 65
      Width = 24
      Height = 24
      Hint = 'Restaura tamanho e posi'#231#227'o original da janela'
      ParentShowHint = False
      Picture.Data = {
        07544269746D617076020000424D760200000000000076000000280000002000
        000020000000010004000000000000020000C40E0000C40E0000100000000000
        0000000000000000800000800000008080008000000080008000808000008080
        8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00FFFFFFFFFFFFFFF07FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0007FFFFFFFFFF
        FFFFFFFFFFFFFFFFF000007FFFFFFFFFFFFFFFFFFFFFFFFF00000007FFFFFFFF
        FFFFFFFFFFFFFFF0000000007FFFFFFFFFFFFFFFFFFFFF000000000007FFFFFF
        FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFF
        FFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFF0000000000000000FFFF
        FFFFFFFFF0FF00FFFFFFFFFFFF00FF7FFFFFFFFF00FF00FFFFFFFFFFFF00FF07
        FFFFFFF000FF00FFFFFFFFFFFF00FF007FFFFF0000FF00FFFFFFFFFFFF00FF00
        07FFF000000000FFFFFFFFFFFF000000007F0000000000FFFFFFFFFFFF000000
        00077000000000FFFFFFFFFFFF0000000007F700000000FFFFFFFFFFFF000000
        007FFF7000FF00FFFFFFFFFFFF00FF0007FFFFF700FF00FFFFFFFFFFFF00FF00
        7FFFFFFF00FF00FFFFFFFFFFFF00FF07FFFFFFFFF0FF00FFFFFFFFFFFF00FF7F
        FFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFF0000000000000000FFFF
        FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFF
        FFFFFFFFFFFFFF000000000007FFFFFFFFFFFFFFFFFFFFF0000000007FFFFFFF
        FFFFFFFFFFFFFFFF00000007FFFFFFFFFFFFFFFFFFFFFFFFF000007FFFFFFFFF
        FFFFFFFFFFFFFFFFFF0007FFFFFFFFFFFFFFFFFFFFFFFFFFFFF07FFFFFFFFFFF
        FFFF}
      ShowHint = True
      Stretch = True
      Transparent = True
      OnDblClick = ImgTamOrigDblClick
    end
    object Nav: TDBNavigator
      Left = 8
      Top = 48
      Width = 96
      Height = 25
      DataSource = SCad
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      Hints.Strings = (
        'In'#237'cio'
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
    object edLocaliza: TEdit
      Left = 192
      Top = 20
      Width = 313
      Height = 21
      Hint = 'Texto a ser localizado'
      CharCase = ecUpperCase
      TabOrder = 1
      Text = 'EDLOCALIZA'
      OnChange = edLocalizaChange
      OnExit = edLocalizaExit
      OnKeyDown = edLocalizaKeyDown
    end
    object cbOrdem: TComboBox
      Left = 8
      Top = 20
      Width = 173
      Height = 21
      Hint = 'Indica a ordem de apresenta'#231#227'o dos dados'
      ItemHeight = 13
      TabOrder = 0
      Text = 'Nome / Raz'#227'o Social'
      OnChange = cbOrdemChange
      Items.Strings = (
        'C'#243'digo'
        'Nome / Raz'#227'o Social'
        'CNPJ / CPF'
        'Nome fantasia')
    end
    object cbEOu: TComboBox
      Left = 512
      Top = 20
      Width = 49
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = '--'
      OnChange = cbEOuChange
      Items.Strings = (
        '--'
        'E'
        'OU')
    end
    object btUtilizar: TBitBtn
      Left = 326
      Top = 64
      Width = 113
      Height = 25
      Hint = 'Utilizar o cadastro apontado'
      Anchors = [akRight, akBottom]
      Caption = '&Utilizar e sair'
      TabOrder = 4
      OnClick = btUtilizarClick
      Glyph.Data = {
        F2010000424DF201000000000000760000002800000024000000130000000100
        0400000000007C01000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333334433333
        3333333333388F3333333333000033334224333333333333338338F333333333
        0000333422224333333333333833338F33333333000033422222243333333333
        83333338F3333333000034222A22224333333338F33F33338F33333300003222
        A2A2224333333338F383F3338F33333300003A2A222A222433333338F8333F33
        38F33333000034A22222A22243333338833333F3338F333300004222A2222A22
        2433338F338F333F3338F3330000222A3A2224A22243338F3838F338F3338F33
        0000A2A333A2224A2224338F83338F338F3338F300003A33333A2224A2224338
        333338F338F3338F000033333333A2224A2243333333338F338F338F00003333
        33333A2224A2233333333338F338F83300003333333333A2224A333333333333
        8F338F33000033333333333A222433333333333338F338F30000333333333333
        A224333333333333338F38F300003333333333333A223333333333333338F8F3
        000033333333333333A3333333333333333383330000}
      NumGlyphs = 2
    end
    object btCancelar: TBitBtn
      Left = 446
      Top = 64
      Width = 113
      Height = 25
      Hint = 'Cancelar a opera'#231#227'o'
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancelar e &Sair'
      TabOrder = 5
      OnClick = btCancelarClick
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
  object Grid: TDBGrid
    Left = 0
    Top = 0
    Width = 570
    Height = 416
    Hint = 'Conte'#250'do do cadastro'
    Align = alClient
    DataSource = SCad
    FixedColor = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = btUtilizarClick
    Columns = <
      item
        Expanded = False
        FieldName = 'RzSocial'
        Title.Caption = 'Raz'#227'o Social / Nome fantasia'
        Width = 210
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fantasia'
        Title.Caption = 'Apelido/Nome fantasia'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ZC_CNPJ'
        Title.Caption = 'CNPJ/F'
        Width = 71
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'Codigo'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'digo'
        Width = 52
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 511
    Width = 570
    Height = 17
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
  end
  object Cad: TTable
    AfterRefresh = CadAfterRefresh
    OnCalcFields = CadCalcFields
    DatabaseName = 'SISV4'
    OnFilterRecord = CadFilterRecord
    IndexName = 'RazaoSocial'
    TableName = 'Cad_Geral.DB'
    Left = 28
    Top = 48
    object CadCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object CadTp: TSmallintField
      FieldName = 'Tp'
    end
    object CadRzSocial: TStringField
      FieldName = 'RzSocial'
      Size = 65
    end
    object CadTPes: TStringField
      FieldName = 'TPes'
      Size = 1
    end
    object CadCNPJF: TStringField
      FieldName = 'CNPJF'
      Size = 14
    end
    object CadEntrLograd: TStringField
      FieldName = 'EntrLograd'
      Size = 45
    end
    object CadEntrNro: TStringField
      FieldName = 'EntrNro'
      Size = 6
    end
    object CadEntrCompl: TStringField
      FieldName = 'EntrCompl'
      Size = 15
    end
    object CadEntrBairro: TStringField
      FieldName = 'EntrBairro'
      Size = 30
    end
    object CadEntrCEP: TStringField
      FieldName = 'EntrCEP'
      EditMask = '99\.999\-999;0; '
      Size = 8
    end
    object CadEntrCidade: TStringField
      FieldName = 'EntrCidade'
      Size = 40
    end
    object CadEntrUF: TStringField
      FieldName = 'EntrUF'
      Size = 2
    end
    object CadCont1Nome: TStringField
      FieldName = 'Cont1Nome'
      Size = 30
    end
    object CadCont1Fone1: TStringField
      FieldName = 'Cont1Fone1'
      EditMask = '!99999-9999;0; '
      Size = 10
    end
    object CadCont1Fone2: TStringField
      FieldName = 'Cont1Fone2'
      EditMask = '!99999-9999;0; '
      Size = 10
    end
    object CadDtCadast: TDateField
      FieldName = 'DtCadast'
    end
    object CadCont1DDD: TStringField
      FieldName = 'Cont1DDD'
      Size = 8
    end
    object CadFantasia: TStringField
      FieldName = 'Fantasia'
      Size = 30
    end
    object CadDesign: TStringField
      FieldName = 'Design'
      Size = 10
    end
    object CadIEST: TStringField
      FieldName = 'IEST'
      Size = 15
    end
    object CadIESTUF: TStringField
      FieldName = 'IESTUF'
      Size = 2
    end
    object CadIMunic: TStringField
      FieldName = 'IMunic'
      Size = 15
    end
    object CadEMail: TStringField
      FieldName = 'EMail'
      Size = 50
    end
    object CadEMailNFe: TStringField
      FieldName = 'EMailNFe'
      Size = 50
    end
    object CadRefCom: TMemoField
      FieldName = 'RefCom'
      BlobType = ftMemo
      Size = 10
    end
    object CadObserv: TMemoField
      FieldName = 'Observ'
      BlobType = ftMemo
      Size = 10
    end
    object CadZC_CNPJ: TStringField
      FieldKind = fkCalculated
      FieldName = 'ZC_CNPJ'
      Size = 18
      Calculated = True
    end
  end
  object SCad: TDataSource
    DataSet = Cad
    Left = 64
    Top = 48
  end
end
