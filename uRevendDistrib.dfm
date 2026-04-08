object FurevendDistrib: TFurevendDistrib
  Left = 233
  Top = 105
  Width = 1096
  Height = 566
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Cadastro de revendedores'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanBot: TPanel
    Left = 0
    Top = 424
    Width = 1080
    Height = 87
    Align = alBottom
    Caption = ' '
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object LabNRegs: TLabel
      Left = 8
      Top = 38
      Width = 51
      Height = 13
      Caption = 'LabNRegs'
    end
    object LabLocaliz: TLabel
      Left = 304
      Top = 8
      Width = 60
      Height = 13
      Caption = 'Localizar por'
    end
    object Label1: TLabel
      Left = 112
      Top = 8
      Width = 166
      Height = 13
      Caption = 'Ordem de apresenta'#231#227'o dos dados'
    end
    object Nav: TDBNavigator
      Left = 8
      Top = 8
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
      TabOrder = 2
    end
    object EdLocaliz: TEdit
      Left = 304
      Top = 20
      Width = 248
      Height = 21
      Hint = 'Nome, c'#243'digo, CNPJ/F a ser pesquisado'
      TabOrder = 1
      Text = 'EdLocaliz'
      OnChange = EdLocalizChange
    end
    object ToolBar1: TToolBar
      Left = 1
      Top = 56
      Width = 1078
      Height = 30
      Align = alBottom
      ButtonHeight = 25
      Caption = 'ToolBar1'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 3
      DesignSize = (
        1078
        28)
      object BtUse: TBitBtn
        Left = 0
        Top = 2
        Width = 181
        Height = 25
        Hint = 'Utilizar o cadastro apontado'
        Anchors = [akRight, akBottom]
        Caption = '&Utilizar e sair'
        TabOrder = 0
        OnClick = BtUseClick
        Kind = bkAll
      end
      object BtInclus: TBitBtn
        Left = 181
        Top = 2
        Width = 168
        Height = 25
        Hint = 'Novo cadastro'
        Anchors = [akRight, akBottom]
        Caption = '&Cadastrar'
        TabOrder = 1
        OnClick = BtInclusClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33333333FF33333333FF333993333333300033377F3333333777333993333333
          300033F77FFF3333377739999993333333333777777F3333333F399999933333
          33003777777333333377333993333333330033377F3333333377333993333333
          3333333773333333333F333333333333330033333333F33333773333333C3333
          330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
          993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
          333333333337733333FF3333333C333330003333333733333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
      end
      object BtAlter: TBitBtn
        Left = 349
        Top = 2
        Width = 192
        Height = 25
        Hint = 'Novo cadastro'
        Anchors = [akRight, akBottom]
        Caption = '&Alterar'
        TabOrder = 2
        OnClick = BtAlterClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
          000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
          00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
          F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
          0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
          FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
          FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
          0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
          00333377737FFFFF773333303300000003333337337777777333}
        NumGlyphs = 2
      end
      object BtExclus: TBitBtn
        Left = 541
        Top = 2
        Width = 160
        Height = 25
        Hint = 'Novo cadastro'
        Anchors = [akRight, akBottom]
        Caption = '&Excluir'
        TabOrder = 3
        OnClick = BtExclusClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333399
          993333333333337777339333333339993333F333FFFFF777FF33999900009990
          03338FFF777777777F33399999FF99FF03333777FF3377337F333309999999FF
          0333337777F777337F33330FF999900F0333337F377773337F33330FFFF999FF
          0333337F33377F337F33330F0099999F0333337F337777F37F33330FFF99F99F
          0333337F337737F37F33330F0F99F0990333337F3377338F7F33330FF99FFF99
          0333337F3773338F7F33330F999F00990333337F7773338F7F33339999FFFFF9
          9333337777FFFFF7FF3339999000000993333777777777777F33999333333339
          99337773333333377F3393333333333399337333333333337F33}
        NumGlyphs = 2
      end
      object BtCanc: TBitBtn
        Left = 701
        Top = 2
        Width = 160
        Height = 25
        Hint = 'Cancelar a opera'#231#227'o'
        Anchors = [akLeft, akBottom]
        Caption = 'Cancelar e &Sair'
        TabOrder = 4
        OnClick = BtCancClick
        Kind = bkCancel
      end
    end
    object CbOrdem: TComboBox
      Left = 112
      Top = 20
      Width = 185
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'CbOrdem'
      OnChange = CbOrdemChange
      Items.Strings = (
        'C'#243'digo'
        'Nome / Raz'#227'o Social'
        'CNPJ / CIC')
    end
  end
  object Grid: TDBGrid
    Left = 0
    Top = 0
    Width = 1080
    Height = 424
    Hint = 'Conte'#250'do do cadastro'
    Align = alClient
    DataSource = SCad
    FixedColor = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = BtUseClick
    Columns = <
      item
        Expanded = False
        FieldName = 'RzSocial'
        Title.Caption = 'Raz'#227'o Social'
        Width = 280
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CnpjEx'
        Title.Caption = 'CNPJ'
        Width = 100
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'Codigo'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'digo'
        Width = 42
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Cidade'
        Width = 112
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DDD'
        Title.Alignment = taCenter
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fone1'
        Title.Caption = 'Fone #1'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fone2'
        Title.Caption = 'Fone #2'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Lograd'
        Title.Caption = 'Logradouro'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nro'
        Title.Caption = 'Numero'
        Width = 44
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Compl'
        Title.Caption = 'Complemento'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Bairro'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UF'
        Width = 28
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 511
    Width = 1080
    Height = 17
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
  end
  object Cad: TTable
    AfterRefresh = CadAfterRefresh
    OnCalcFields = CadCalcFields
    DatabaseName = 'SISV4'
    IndexName = 'RazaoSocial'
    TableName = 'Revendedores.DB'
    Left = 20
    Top = 60
    object CadCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object CadRzSocial: TStringField
      FieldName = 'RzSocial'
      Size = 50
    end
    object CadTPes: TStringField
      FieldName = 'TPes'
      Size = 1
    end
    object CadCNPJ: TStringField
      FieldName = 'CNPJ'
      EditMask = '00\.000\.000/0000-00;0; '
      Size = 14
    end
    object CadIEST: TStringField
      FieldName = 'IEST'
      Size = 15
    end
    object CadIESTUF: TStringField
      FieldName = 'IESTUF'
      Size = 2
    end
    object CadDtCadast: TDateField
      FieldName = 'DtCadast'
    end
    object CadLograd: TStringField
      FieldName = 'Lograd'
      Size = 45
    end
    object CadNro: TStringField
      FieldName = 'Nro'
      Size = 6
    end
    object CadCompl: TStringField
      FieldName = 'Compl'
      Size = 15
    end
    object CadBairro: TStringField
      FieldName = 'Bairro'
      Size = 30
    end
    object CadCEP: TStringField
      FieldName = 'CEP'
      EditMask = '99\.999\-999;0; '
      Size = 8
    end
    object CadCidade: TStringField
      FieldName = 'Cidade'
      Size = 40
    end
    object CadUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object CadContNome: TStringField
      FieldName = 'ContNome'
      Size = 30
    end
    object CadDDD: TStringField
      FieldName = 'DDD'
      Size = 8
    end
    object CadFone1: TStringField
      FieldName = 'Fone1'
      EditMask = '!99999-9999;0; '
      Size = 10
    end
    object CadFone2: TStringField
      FieldName = 'Fone2'
      EditMask = '!99999-9999;0; '
      Size = 10
    end
    object CadEMail: TStringField
      FieldName = 'EMail'
      Size = 60
    end
    object CadWebSite: TStringField
      FieldName = 'WebSite'
      Size = 80
    end
    object CadCnpjEx: TStringField
      FieldKind = fkCalculated
      FieldName = 'CnpjEx'
      Size = 18
      Calculated = True
    end
  end
  object SCad: TDataSource
    DataSet = Cad
    Left = 48
    Top = 60
  end
  object CadSeq: TTable
    DatabaseName = 'SISV4'
    TableName = 'Revendedores.DB'
    Left = 212
    Top = 64
    object CadSeqCodigo: TIntegerField
      FieldName = 'Codigo'
    end
  end
end
