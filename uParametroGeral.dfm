object FuParametroGeral: TFuParametroGeral
  Left = 277
  Top = 161
  Width = 704
  Height = 492
  BorderIcons = [biSystemMenu]
  Caption = 'Parametros gen'#233'ricos'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000FFFFFFFFFFFFFF0000000
    00000000000FFFFFFFFFFFFFF0000000000000000000FFFFFFFFFFFFF0000000
    0000E00BFBFB0FFFFFFFFFFFF00000000000E0BFBF000FFFF0FFFFFFF0000000
    0000E0FBFBFBF0F00FFFFFFFF00000000000E0BFBF00000B0FFF000FF0000000
    0000E0FBFBFBFBF0FFFFFFFFF00000000000E0BF0000000FFFFFFFFFF0000000
    0000000BFB00B0F000FF000FF000000000000000000B0FFFFFFFFFFFF0000000
    0000000000B0FFFFFFFFFFFFF0000000000000000B0FF00000FF000FF0000000
    00000000B00FFFFFFFFFFFFFF000000000000009000FFFFFFFFFFFFFF0000000
    00000000000F000000FF000FF000000000000000000FFFFFFFFFFFFFF0000000
    00000000000FFFFFFFFFFFFFF000000000000000000F000000000000F0000000
    00000000000FFFFFFFFFFFFFF000000000000000000F000000000000F0000000
    00000000000FFFFFFFFFFFFFF000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0003FFFC0003FFFC
    0003FF200003FF000003FF000003FF000003FF000003FF000003FF000003FF00
    0003FFE00003FFF80003FFF00003FFE00003FFC40003FFEC0003FFFC0003FFFC
    0003FFFC0003FFFC0003FFFC0003FFFC0003FFFC0003FFFFFFFFFFFFFFFF}
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object PanBottom: TPanel
    Left = 0
    Top = 413
    Width = 688
    Height = 41
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      688
      41)
    object btOk: TBitBtn
      Left = 466
      Top = 8
      Width = 105
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Ok'
      Default = True
      TabOrder = 0
      OnClick = btOkClick
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
    object btCanc: TBitBtn
      Left = 576
      Top = 8
      Width = 105
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&Cancelar'
      TabOrder = 1
      OnClick = btCancClick
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 688
    Height = 413
    ActivePage = tbComercial
    Align = alClient
    TabOrder = 1
    object tbEstoques: TTabSheet
      Caption = 'Estoques'
      object GbCodif: TGroupBox
        Left = 8
        Top = 8
        Width = 569
        Height = 185
        Caption = 'Forma'#231#227'o do c'#243'digo interno'
        TabOrder = 0
        object Lable64: TLabel
          Left = 12
          Top = 32
          Width = 107
          Height = 16
          Caption = 'Tamanho (3 a 13):'
        end
        object Label65: TLabel
          Left = 200
          Top = 32
          Width = 95
          Height = 16
          Caption = 'Divis'#245'es (1 a 4):'
        end
        object Label1: TLabel
          Left = 416
          Top = 12
          Width = 142
          Height = 13
          Caption = 'N'#227'o utilizado - Consulte IniSys'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 416
          Top = 28
          Width = 111
          Height = 13
          Caption = 'Estoques/RegEntradas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 416
          Top = 44
          Width = 67
          Height = 13
          Caption = 'Cadastro & Uso'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object GbDiv1: TGroupBox
          Left = 8
          Top = 68
          Width = 133
          Height = 109
          Caption = 'Divis'#227'o 1'
          TabOrder = 2
          object Label66: TLabel
            Left = 4
            Top = 24
            Width = 61
            Height = 16
            Caption = 'Tamanho:'
          end
          object DbMasc1: TDBRadioGroup
            Left = 5
            Top = 48
            Width = 120
            Height = 53
            Caption = 'Mascara'
            DataField = 'TCodIt1'
            DataSource = SPrmGer
            Items.Strings = (
              'Numerica'
              'AlfaNumerica')
            TabOrder = 1
            TabStop = True
            Values.Strings = (
              'N'
              'A')
          end
          object dbDiv1: TDBComboBox
            Left = 72
            Top = 20
            Width = 53
            Height = 24
            DataField = 'TCodD1'
            DataSource = SPrmGer
            ItemHeight = 16
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
              '13')
            TabOrder = 0
          end
        end
        object GbDiv2: TGroupBox
          Left = 148
          Top = 68
          Width = 133
          Height = 109
          Caption = 'Divis'#227'o 2'
          TabOrder = 3
          object Label70: TLabel
            Left = 4
            Top = 24
            Width = 61
            Height = 16
            Caption = 'Tamanho:'
          end
          object DbMasc2: TDBRadioGroup
            Left = 5
            Top = 48
            Width = 120
            Height = 53
            Caption = 'Mascara'
            DataField = 'TCodIt2'
            DataSource = SPrmGer
            Items.Strings = (
              'Num'#233'rica'
              'AlfaNum'#233'rica')
            TabOrder = 1
            TabStop = True
            Values.Strings = (
              'N'
              'A')
          end
          object dbDiv2: TDBComboBox
            Left = 72
            Top = 20
            Width = 53
            Height = 24
            DataField = 'TCodD2'
            DataSource = SPrmGer
            ItemHeight = 16
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
              '13')
            TabOrder = 0
          end
        end
        object GbDiv3: TGroupBox
          Left = 288
          Top = 68
          Width = 133
          Height = 109
          Caption = 'Divis'#227'o 3'
          TabOrder = 4
          object Label72: TLabel
            Left = 4
            Top = 24
            Width = 61
            Height = 16
            Caption = 'Tamanho:'
          end
          object DbMasc3: TDBRadioGroup
            Left = 5
            Top = 48
            Width = 120
            Height = 53
            Caption = 'Mascara'
            DataField = 'TCodIt3'
            DataSource = SPrmGer
            Items.Strings = (
              'Num'#233'rica'
              'AlfaNum'#233'rica')
            TabOrder = 1
            TabStop = True
            Values.Strings = (
              'N'
              'A')
          end
          object dbDiv3: TDBComboBox
            Left = 72
            Top = 20
            Width = 53
            Height = 24
            DataField = 'TCodD3'
            DataSource = SPrmGer
            ItemHeight = 16
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
              '13')
            TabOrder = 0
          end
        end
        object GbDiv4: TGroupBox
          Left = 428
          Top = 68
          Width = 133
          Height = 109
          Caption = 'Divis'#227'o 4'
          TabOrder = 5
          object Label74: TLabel
            Left = 4
            Top = 24
            Width = 61
            Height = 16
            Caption = 'Tamanho:'
          end
          object DbMasc4: TDBRadioGroup
            Left = 5
            Top = 48
            Width = 120
            Height = 53
            Caption = 'Mascara'
            DataField = 'TCodIt4'
            DataSource = SPrmGer
            Items.Strings = (
              'Num'#233'rica'
              'AlfaNum'#233'rica')
            TabOrder = 1
            TabStop = True
            Values.Strings = (
              'N'
              'A')
          end
          object dbDiv4: TDBComboBox
            Left = 72
            Top = 20
            Width = 53
            Height = 24
            DataField = 'TCodD4'
            DataSource = SPrmGer
            ItemHeight = 16
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
              '13')
            TabOrder = 0
          end
        end
        object dbTamCod: TDBComboBox
          Left = 124
          Top = 28
          Width = 53
          Height = 24
          DataField = 'TCodTam'
          DataSource = SPrmGer
          ItemHeight = 16
          Items.Strings = (
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
            '13')
          TabOrder = 0
        end
        object dbDivCod: TDBComboBox
          Left = 300
          Top = 28
          Width = 41
          Height = 24
          DataField = 'TCodDiv'
          DataSource = SPrmGer
          ItemHeight = 16
          Items.Strings = (
            '1'
            '2'
            '3'
            '4')
          TabOrder = 1
          OnExit = dbDivCodExit
        end
      end
      object GroupBox2: TGroupBox
        Left = 156
        Top = 200
        Width = 321
        Height = 145
        Caption = 'Margem para pre'#231'o de venda'
        TabOrder = 2
        object Label2: TLabel
          Left = 8
          Top = 112
          Width = 84
          Height = 16
          Caption = 'Porcentagem:'
        end
        object Memo2: TMemo
          Left = 8
          Top = 44
          Width = 301
          Height = 57
          TabStop = False
          Lines.Strings = (
            'Margem padr'#227'o. Percentual a ser aplicado no'
            'custo da mercadoria para obten'#231#227'o  do pre'#231'o'
            'de venda sugerido')
          ReadOnly = True
          TabOrder = 1
        end
        object DBCheckBox12: TDBCheckBox
          Left = 8
          Top = 20
          Width = 273
          Height = 17
          Caption = 'Calcular pre'#231'os de venda (sugestao)  '
          DataField = 'PrecoSugestao'
          DataSource = SPrmGer
          TabOrder = 0
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object edMarg: TDBEdit
          Left = 96
          Top = 108
          Width = 89
          Height = 24
          TabStop = False
          DataField = 'MargSugestao'
          DataSource = SPrmGer
          TabOrder = 2
        end
      end
      object DbCodBarras: TDBRadioGroup
        Left = 8
        Top = 200
        Width = 141
        Height = 77
        Caption = 'C'#243'digo de barras'
        DataField = 'CodBarras'
        DataSource = SPrmGer
        Items.Strings = (
          'N'#227'o utiliza'
          #205'tem (c'#243'digo)'
          'Referencia')
        TabOrder = 1
        TabStop = True
        Values.Strings = (
          '0'
          '1'
          '2')
      end
    end
    object tbComercial: TTabSheet
      Caption = 'Opera'#231#245'es comerciais'
      ImageIndex = 1
      object GroupBox7: TGroupBox
        Left = 12
        Top = 124
        Width = 261
        Height = 85
        Caption = 'Faturamento mensal'
        TabOrder = 1
        object DBCheckBox4: TDBCheckBox
          Left = 8
          Top = 24
          Width = 237
          Height = 17
          Caption = 'Sempre emitir pedido p/ Fat.mensal'
          DataField = 'PedFM'
          DataSource = SPrmGer
          TabOrder = 0
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object DBCheckBox5: TDBCheckBox
          Left = 8
          Top = 52
          Width = 237
          Height = 17
          Caption = 'Exibir venda fatur. mensal no caixa'
          DataField = 'PedFMExib'
          DataSource = SPrmGer
          TabOrder = 1
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
      end
      object GroupBox3: TGroupBox
        Left = 12
        Top = 16
        Width = 261
        Height = 105
        Caption = 'Uso de dados'
        TabOrder = 0
        object Label36: TLabel
          Left = 120
          Top = 41
          Width = 117
          Height = 16
          Alignment = taRightJustify
          Caption = 'M'#225'x. Lanctos (LITE)'
        end
        object DBBanco: TDBRadioGroup
          Left = 8
          Top = 24
          Width = 101
          Height = 69
          Caption = 'BD Vendas'
          DataField = 'BDVend'
          DataSource = SPrmGer
          Items.Strings = (
            'Lite'
            'Full')
          TabOrder = 0
          Values.Strings = (
            'L'
            'F')
        end
        object EdLctosMax: TDBEdit
          Left = 120
          Top = 57
          Width = 93
          Height = 24
          DataField = 'MaxLctos'
          DataSource = SPrmGer
          TabOrder = 1
        end
      end
      object DbFinaliz: TDBRadioGroup
        Left = 468
        Top = 16
        Width = 205
        Height = 105
        Caption = 'Tratativa fiscal / Final da venda'
        DataField = 'TratFiscal'
        DataSource = SPrmGer
        Items.Strings = (
          'No caixa'
          'NFCe (CF)'
          'NFe'
          'CF E NF (..)')
        TabOrder = 3
        Values.Strings = (
          '0'
          '1'
          '2'
          '3')
      end
      object GroupBox1: TGroupBox
        Left = 276
        Top = 16
        Width = 189
        Height = 193
        Caption = 'Pedidos'
        TabOrder = 2
        object Label15: TLabel
          Left = 12
          Top = 144
          Width = 165
          Height = 16
          Caption = 'Identifica'#231#227'o/Denomina'#231#227'o'
        end
        object DBPedido: TDBRadioGroup
          Left = 12
          Top = 20
          Width = 169
          Height = 117
          Caption = 'Tipo de pedido'
          DataField = 'Pedido'
          DataSource = SPrmGer
          Items.Strings = (
            'RAW'
            'WIN'
            'MiniPrinter/Bobina'
            'MiniPrinter/Windows'
            'N'#227'o emite pedidos')
          TabOrder = 0
          Values.Strings = (
            '1'
            '2'
            '3'
            '4'
            '0')
        end
        object EdIdPed: TDBEdit
          Left = 12
          Top = 160
          Width = 169
          Height = 24
          DataField = 'IdPed'
          DataSource = SPrmGer
          TabOrder = 1
        end
      end
      object DbRGParcel: TDBRadioGroup
        Left = 468
        Top = 124
        Width = 205
        Height = 85
        Caption = 'Modo de parcelamento'
        DataField = 'MdParcel'
        DataSource = SPrmGer
        Items.Strings = (
          '&0 - Dias'
          '&1 - Datas')
        TabOrder = 4
        Values.Strings = (
          '0'
          '1')
      end
      object gbListaPadrao: TGroupBox
        Left = 12
        Top = 220
        Width = 225
        Height = 53
        Caption = 'Lista de pre'#231'os padr'#227'o'
        TabOrder = 5
        object EdLPrec: TDBLookupComboBox
          Left = 8
          Top = 21
          Width = 209
          Height = 24
          DataField = 'LPrec'
          DataSource = SPrmGer
          KeyField = 'Seq'
          ListField = 'Ident'
          ListSource = SPrecos
          TabOrder = 0
        end
      end
      object gbSenhaVenda: TGroupBox
        Left = 244
        Top = 220
        Width = 145
        Height = 101
        Caption = 'Senha para vendas'
        TabOrder = 6
        object LabSenha: TLabel
          Left = 8
          Top = 52
          Width = 108
          Height = 13
          Caption = 'Senha para vendas ....'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object edSenha: TDBEdit
          Left = 28
          Top = 20
          Width = 73
          Height = 28
          DataField = 'SenhaVendas'
          DataSource = SPrmGer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          PasswordChar = '#'
          TabOrder = 0
          OnDblClick = edSenhaDblClick
        end
      end
      object gbDescMaximo: TGroupBox
        Left = 392
        Top = 220
        Width = 129
        Height = 57
        Caption = 'Desconto m'#225'ximo'
        TabOrder = 7
        object edDescMax: TDBEdit
          Left = 12
          Top = 20
          Width = 73
          Height = 28
          DataField = 'DescMax'
          DataSource = SPrmGer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnDblClick = edSenhaDblClick
        end
      end
      object gbAliqISS: TGroupBox
        Left = 528
        Top = 220
        Width = 129
        Height = 57
        Caption = 'Aliquota ISS'
        TabOrder = 8
        object edAliqISS: TDBEdit
          Left = 12
          Top = 20
          Width = 73
          Height = 28
          DataField = 'SenhaVendas'
          DataSource = SPrmGer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnDblClick = edSenhaDblClick
        end
      end
    end
  end
  object PrmGer: TTable
    DatabaseName = 'SISV4'
    TableName = 'Parametros.DB'
    Left = 557
    Top = 361
    object PrmGerICM_UF: TBCDField
      FieldName = 'ICM_UF'
      DisplayFormat = '0.00'
      EditFormat = '0.00'
      Precision = 32
      Size = 2
    end
    object PrmGerICM_FUF: TBCDField
      FieldName = 'ICM_FUF'
      DisplayFormat = '0.00'
      EditFormat = '0.00'
      Precision = 32
      Size = 2
    end
    object PrmGerFormaReajuste: TSmallintField
      FieldName = 'FormaReajuste'
    end
    object PrmGerPcUltReajuste: TBCDField
      FieldName = 'PcUltReajuste'
      DisplayFormat = '0.000'
      EditFormat = '0.000'
      Precision = 32
      Size = 3
    end
    object PrmGerFReajEx: TStringField
      FieldKind = fkCalculated
      FieldName = 'FReajEx'
      Size = 15
      Calculated = True
    end
    object PrmGerCFOP_EE: TSmallintField
      FieldName = 'CFOP_EE'
    end
    object m: TSmallintField
      FieldName = 'CFOP_FE'
    end
    object PrmGerSTrib_UF: TSmallintField
      FieldName = 'STrib_UF'
    end
    object PrmGerSTrib_FUF: TSmallintField
      FieldName = 'STrib_FUF'
    end
    object PrmGerTCodTam: TSmallintField
      FieldName = 'TCodTam'
    end
    object PrmGerTCodDiv: TSmallintField
      FieldName = 'TCodDiv'
    end
    object PrmGerTCodD1: TSmallintField
      FieldName = 'TCodD1'
    end
    object PrmGerTCodIt1: TStringField
      FieldName = 'TCodIt1'
      Size = 1
    end
    object PrmGerTCodD2: TSmallintField
      FieldName = 'TCodD2'
    end
    object PrmGerTCodIt2: TStringField
      FieldName = 'TCodIt2'
      Size = 1
    end
    object PrmGerTCodD3: TSmallintField
      FieldName = 'TCodD3'
    end
    object PrmGerTCodIt3: TStringField
      FieldName = 'TCodIt3'
      Size = 1
    end
    object PrmGerTCodD4: TSmallintField
      FieldName = 'TCodD4'
    end
    object PrmGerTCodIt4: TStringField
      FieldName = 'TCodIt4'
      Size = 1
    end
    object PrmGerPrecoSugestao: TBooleanField
      FieldName = 'PrecoSugestao'
    end
    object PrmGerMargSugestao: TBCDField
      FieldName = 'MargSugestao'
      DisplayFormat = '0.00000 %'
      EditFormat = '0.00000'
      Precision = 32
      Size = 5
    end
    object PrmGerQbLote: TSmallintField
      FieldName = 'QbLote'
    end
    object PrmGerSimplesRS: TBooleanField
      FieldName = 'SimplesRS'
    end
    object PrmGerTDocParc: TSmallintField
      FieldName = 'TDocParc'
    end
    object PrmGerTDocCred: TSmallintField
      FieldName = 'TDocCred'
    end
    object PrmGerCobrParc: TStringField
      FieldName = 'CobrParc'
      Size = 1
    end
    object PrmGerBancParc: TStringField
      FieldName = 'BancParc'
      Size = 8
    end
    object PrmGerCobrCred: TStringField
      FieldName = 'CobrCred'
      Size = 1
    end
    object PrmGerBancCred: TStringField
      FieldName = 'BancCred'
      Size = 8
    end
    object PrmGerPedido: TSmallintField
      FieldName = 'Pedido'
    end
    object PrmGerIdPed: TStringField
      FieldName = 'IdPed'
      Size = 15
    end
    object PrmGerJurosMM: TBCDField
      FieldName = 'JurosMM'
      Precision = 32
      Size = 2
    end
    object PrmGerTDocCheque: TSmallintField
      FieldName = 'TDocCheque'
    end
    object PrmGerMaxLctos: TSmallintField
      FieldName = 'MaxLctos'
    end
    object PrmGerLPrec: TSmallintField
      FieldName = 'LPrec'
    end
    object PrmGerQtdDec: TStringField
      FieldName = 'QtdDec'
      Size = 1
    end
    object PrmGerVlrDec: TStringField
      FieldName = 'VlrDec'
      Size = 1
    end
    object PrmGerCodBarras: TSmallintField
      FieldName = 'CodBarras'
    end
    object PrmGerPedFM: TBooleanField
      FieldName = 'PedFM'
    end
    object PrmGerPedFMExib: TBooleanField
      FieldName = 'PedFMExib'
    end
    object PrmGerTratFiscal: TStringField
      FieldName = 'TratFiscal'
      Size = 1
    end
    object PrmGerMdParcel: TSmallintField
      FieldName = 'MdParcel'
    end
    object PrmGerBDVend: TStringField
      FieldName = 'BDVend'
      Size = 1
    end
    object PrmGerSenhaVendas: TStringField
      FieldName = 'SenhaVendas'
      Size = 6
    end
    object PrmGerDescMax: TBCDField
      FieldName = 'DescMax'
      DisplayFormat = '0.00 %'
      EditFormat = '0.00 %'
      Precision = 32
      Size = 2
    end
    object PrmGerAliqISS: TBCDField
      FieldName = 'AliqISS'
      DisplayFormat = '0.00 %'
      EditFormat = '0.00 %'
      Precision = 32
      Size = 2
    end
  end
  object SPrmGer: TDataSource
    DataSet = PrmGer
    Left = 589
    Top = 361
  end
  object Precos: TTable
    DatabaseName = 'SISV4'
    Filter = 'Ativa = True'
    Filtered = True
    TableName = 'LPrecoID.DB'
    Left = 468
    Top = 359
    object PrecosSeq: TSmallintField
      FieldName = 'Seq'
    end
    object PrecosIdent: TStringField
      FieldName = 'Ident'
      Size = 15
    end
    object PrecosComent: TStringField
      FieldName = 'Coment'
      Size = 50
    end
    object PrecosNDec: TSmallintField
      FieldName = 'NDec'
    end
    object PrecosAtiva: TBooleanField
      FieldName = 'Ativa'
    end
  end
  object SPrecos: TDataSource
    DataSet = Precos
    Left = 500
    Top = 360
  end
end
