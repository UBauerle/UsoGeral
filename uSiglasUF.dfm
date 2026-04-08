object FuSiglasUF: TFuSiglasUF
  Left = 233
  Top = 123
  Width = 631
  Height = 640
  Caption = 'Estados: C'#243'digo IBGE, Siglas UF, Tributa'#231#227'o ICMS e Faixas de CEP'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MenuUF
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 486
    Width = 615
    Height = 96
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      615
      96)
    object LabNRegs: TLabel
      Left = 12
      Top = 36
      Width = 51
      Height = 13
      Caption = 'LabNRegs'
    end
    object imgEdit: TImage
      Left = 416
      Top = 12
      Width = 32
      Height = 32
      Picture.Data = {
        07544269746D617076020000424D760200000000000076000000280000002000
        0000200000000100040000000000000200000000000000000000100000000000
        0000000000000000800000800000008080008000000080008000808000008080
        8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000FFFFF
        FFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFF
        FFFFF0FFFFFFFFFFFF00FFFFFF0FFFFFFFFFF0FFFFFFFFFFFF00077FFF0FFFFF
        FFFFF0FFFFFFFFFFFFF077F0FF0FFFFFFFFFF0FFFFFFFFFFFFF77F000FFFFFFF
        FFFFF0F0000000000FF7F00000FFFFFFFFFFF0FFFFFFFFFFFFFF0000000FFFFF
        FFFFF0FFFFFFFFFFFFFFF0000000FFFFFFFFF0F0000000000000FF0000000FFF
        FFFFF0FFFFFFFFFFFFFFFFF0000000FFFFFFF0FFFFFFFFFFFFFFFFFF0000000F
        FFFFF0F0000000000000FFFFF0000000FFFFF0FFFFFFFFFFFFFFFFFFFF000000
        0FFFF0FFFFFFFFFFFFFFFFFFFFF0000000FFF0F0000000000000000FFFFF0000
        000FF0FFFFFFFFFFFFFFFFFFFF0FF00000FFF0FFFFFFFFFFFFFFFFFFFF0FFF00
        0FFFF0F0000000000000000FFF0FFFF0FFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFF
        FFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0FFFFFFFFFFFFF00000000FFFFF
        FFFFF0FFFFFFFFFFFFF0FFFFF0FFFFFFFFFFF0FFFFFFFFFFFFF0FFFF0FFFFFFF
        FFFFF0FFFFFFFFFFFFF0FFF0FFFFFFFFFFFFF0FFFFFFFFFFFFF0FF0FFFFFFFFF
        FFFFF0FFFFFFFFFFFFF0F0FFFFFFFFFFFFFFF0FFFFFFFFFFFFF00FFFFFFFFFFF
        FFFFF000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF}
      Stretch = True
      Transparent = True
      OnClick = imgEditClick
    end
    object imgShow: TImage
      Left = 452
      Top = 12
      Width = 32
      Height = 32
      Picture.Data = {
        07544269746D617076020000424D760200000000000076000000280000002000
        0000200000000100040000000000000200000000000000000000100000000000
        0000000000000000800000800000008080008000000080008000808000008080
        8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000FFFFF
        FFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFF
        FFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFF
        FFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFF
        FFFFF0F0000000000000000FFF0FFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFF
        FFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0F0000000000000000FFF0FFFFF
        FFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFF
        FFFFF0F0000000000000000FFF0FFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFF
        FFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0F0000000000000000FFF0FFFFF
        FFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFF
        FFFFF0F0000000000000000FFF0FFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFF
        FFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFFFFFFF0FFFFFFFFFFFFF00000000FFFFF
        FFFFF0FFFFFFFFFFFFF0FFFFF0FFFFFFFFFFF0FFFFFFFFFFFFF0FFFF0FFFFFFF
        FFFFF0FFFFFFFFFFFFF0FFF0FFFFFFFFFFFFF0FFFFFFFFFFFFF0FF0FFFFFFFFF
        FFFFF0FFFFFFFFFFFFF0F0FFFFFFFFFFFFFFF0FFFFFFFFFFFFF00FFFFFFFFFFF
        FFFFF000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF}
      Stretch = True
      Transparent = True
      Visible = False
      OnClick = imgShowClick
    end
    object Nav: TDBNavigator
      Left = 8
      Top = 8
      Width = 96
      Height = 25
      DataSource = STSUFs
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      Hints.Strings = (
        'In'#237'cio'
        'Anterior'
        'Pr'#243'ximo'
        'Final'
        'Inserir'
        'Excluir'
        'Editar'
        'Gravar'
        'Cancelar'
        'Atualizar')
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object RGOrdem: TRadioGroup
      Left = 108
      Top = 4
      Width = 213
      Height = 65
      Caption = 'Apresenta'#231#227'o'
      Columns = 2
      Items.Strings = (
        '&C'#243'd. IBGE'
        'Sigla &UF'
        '&Alfab'#233'tica'
        '&Faixa CEP')
      TabOrder = 1
      OnClick = RGOrdemClick
    end
    object BtSair: TBitBtn
      Left = 484
      Top = 16
      Width = 93
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Sair'
      TabOrder = 2
      OnClick = BtSairClick
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
      Left = 583
      Top = 16
      Width = 25
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 3
    end
    object StatusBar1: TStatusBar
      Left = 1
      Top = 76
      Width = 613
      Height = 19
      Panels = <
        item
          Text = 'Opera'#231#227'o'
          Width = 50
        end
        item
          Text = 'Edi'#231#227'o'
          Width = 50
        end
        item
          Width = 50
        end>
    end
    object btTamOrig: TBitBtn
      Left = 352
      Top = 10
      Width = 35
      Height = 35
      Anchors = [akLeft, akBottom]
      TabOrder = 5
      TabStop = False
      OnClick = btTamOrigClick
      Glyph.Data = {
        9E000000424D9E000000000000003E0000002800000018000000180000000100
        01000000000060000000C40E0000C40E0000020000000000000000000000FFFF
        FF00FFE7FF00FFC3FF00FF81FF00FF00FF00FE007F00FFC3FF00FC003F00F400
        2F00E4FF2700C4FF230080FF010000FF000000FF000080FF0100C4FF2300E4FF
        2700F4002F00FC003F00FFC3FF00FE007F00FF00FF00FF81FF00FFC3FF00FFE7
        FF00}
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 615
    Height = 3
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel3'
    Color = clMaroon
    TabOrder = 1
  end
  object Grid: TDBGrid
    Left = 0
    Top = 3
    Width = 615
    Height = 361
    Align = alClient
    DataSource = STSUFs
    FixedColor = clMoneyGreen
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = GridDblClick
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IBGE'
        Title.Alignment = taCenter
        Width = 32
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'Sigla'
        Title.Alignment = taCenter
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Denom'
        Title.Caption = 'Denomina'#231#227'o'
        Width = 140
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AliqICM'
        Title.Alignment = taRightJustify
        Title.Caption = '% Interest'
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AliqICMInt'
        Title.Alignment = taRightJustify
        Title.Caption = '% Interna'
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AliqFCP'
        Title.Alignment = taRightJustify
        Title.Caption = '% FCP'
        Width = 56
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CEPMin'
        Title.Alignment = taCenter
        Title.Caption = 'CEP Inicial'
        Width = 80
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CEPMax'
        Title.Alignment = taCenter
        Title.Caption = 'CEP Final'
        Width = 80
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ZC_DifAl'
        Title.Alignment = taCenter
        Title.Caption = 'DifAl'
        Width = 32
        Visible = True
      end>
  end
  object PanManut: TPanel
    Left = 0
    Top = 364
    Width = 615
    Height = 122
    Align = alBottom
    Enabled = False
    TabOrder = 3
    DesignSize = (
      615
      122)
    object LabAcao: TLabel
      Left = 555
      Top = 8
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
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 47
      Height = 13
      Caption = 'C'#243'd IBGE'
    end
    object Label2: TLabel
      Left = 64
      Top = 8
      Width = 31
      Height = 13
      Caption = 'SIGLA'
    end
    object Label3: TLabel
      Left = 108
      Top = 8
      Width = 66
      Height = 13
      Caption = 'Denomina'#231#227'o'
    end
    object EdIBGE: TDBEdit
      Left = 8
      Top = 20
      Width = 45
      Height = 21
      DataField = 'IBGE'
      DataSource = STSUFs
      TabOrder = 0
    end
    object EdUF: TDBEdit
      Left = 64
      Top = 20
      Width = 33
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Sigla'
      DataSource = STSUFs
      TabOrder = 1
    end
    object EDenom: TDBEdit
      Left = 108
      Top = 20
      Width = 153
      Height = 21
      DataField = 'Denom'
      DataSource = STSUFs
      TabOrder = 2
    end
    object BtOk: TBitBtn
      Left = 516
      Top = 60
      Width = 93
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Ok'
      TabOrder = 7
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
      Left = 516
      Top = 88
      Width = 93
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Cancelar'
      TabOrder = 8
      Visible = False
      OnClick = BtCancClick
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
    object GroupBox1: TGroupBox
      Left = 8
      Top = 44
      Width = 145
      Height = 69
      Caption = 'Aliquotas ICM'
      TabOrder = 4
      object Label4: TLabel
        Left = 11
        Top = 20
        Width = 64
        Height = 13
        Alignment = taRightJustify
        Caption = 'Interestadual:'
      end
      object Label5: TLabel
        Left = 39
        Top = 44
        Width = 36
        Height = 13
        Alignment = taRightJustify
        Caption = 'Interna:'
      end
      object EdICM: TDBEdit
        Left = 80
        Top = 16
        Width = 49
        Height = 21
        DataField = 'AliqICM'
        DataSource = STSUFs
        TabOrder = 0
      end
      object EdCMInt: TDBEdit
        Left = 80
        Top = 40
        Width = 49
        Height = 21
        DataField = 'AliqICMInt'
        DataSource = STSUFs
        TabOrder = 1
      end
    end
    object GroupBox2: TGroupBox
      Left = 264
      Top = 44
      Width = 125
      Height = 69
      Caption = 'Faixa C.E.P.'
      TabOrder = 6
      object Label6: TLabel
        Left = 8
        Top = 20
        Width = 28
        Height = 13
        Alignment = taRightJustify
        Caption = 'Inicio:'
      end
      object Label7: TLabel
        Left = 17
        Top = 44
        Width = 19
        Height = 13
        Alignment = taRightJustify
        Caption = 'Fim:'
      end
      object EdCEPIni: TDBEdit
        Left = 40
        Top = 16
        Width = 77
        Height = 21
        DataField = 'CEPMin'
        DataSource = STSUFs
        TabOrder = 0
      end
      object EdCEPFin: TDBEdit
        Left = 40
        Top = 40
        Width = 77
        Height = 21
        DataField = 'CEPMax'
        DataSource = STSUFs
        TabOrder = 1
      end
    end
    object GroupBox3: TGroupBox
      Left = 156
      Top = 44
      Width = 101
      Height = 69
      Caption = 'Aliquota FCP'
      TabOrder = 5
      object LabFCP: TLabel
        Left = 4
        Top = 40
        Width = 89
        Height = 13
        Alignment = taCenter
        Caption = 'Fundo de combate'
      end
      object edFCP: TDBEdit
        Left = 24
        Top = 16
        Width = 49
        Height = 21
        DataField = 'AliqFCP'
        DataSource = STSUFs
        TabOrder = 0
      end
    end
    object dbDifal: TDBCheckBox
      Left = 272
      Top = 20
      Width = 169
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Calcular DifAl (Vendas com ST)'
      DataField = 'DifAl'
      DataSource = STSUFs
      TabOrder = 3
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
  end
  object MenuUF: TMainMenu
    Left = 168
    Top = 224
    object Estados1: TMenuItem
      Caption = '&Estados'
      object Incluir1: TMenuItem
        Caption = '&Incluir'
        OnClick = Incluir1Click
      end
      object Alterar1: TMenuItem
        Caption = '&Alterar'
        OnClick = Alterar1Click
      end
      object Excluir1: TMenuItem
        Caption = '&Excluir'
        OnClick = Excluir1Click
      end
    end
    object Sair1: TMenuItem
      Caption = '&Sair'
      OnClick = BtSairClick
    end
  end
  object TSUFs: TTable
    OnCalcFields = TSUFsCalcFields
    DatabaseName = 'SISV4'
    TableName = 'TS_Estados.db'
    Left = 25
    Top = 34
    object TSUFsIBGE: TSmallintField
      FieldName = 'IBGE'
    end
    object TSUFsSigla: TStringField
      FieldName = 'Sigla'
      Size = 2
    end
    object TSUFsDenom: TStringField
      FieldName = 'Denom'
    end
    object TSUFsAliqICM: TBCDField
      FieldName = 'AliqICM'
      DisplayFormat = '0.00 %'
      EditFormat = '0.00'
      Precision = 32
      Size = 2
    end
    object TSUFsAliqICMInt: TBCDField
      FieldName = 'AliqICMInt'
      DisplayFormat = '0.00 %'
      EditFormat = '0.00'
      Precision = 32
      Size = 2
    end
    object TSUFsCEPMin: TStringField
      FieldName = 'CEPMin'
      EditMask = '00\.000\-999;0; '
      Size = 8
    end
    object TSUFsCEPMax: TStringField
      FieldName = 'CEPMax'
      EditMask = '00\.000\-999;0; '
      Size = 8
    end
    object TSUFsAliqFCP: TBCDField
      FieldName = 'AliqFCP'
      DisplayFormat = '0.00 %'
      EditFormat = '0.00'
      Precision = 32
      Size = 2
    end
    object TSUFsDifAl: TBooleanField
      FieldName = 'DifAl'
    end
    object TSUFsZC_DifAl: TStringField
      FieldKind = fkCalculated
      FieldName = 'ZC_DifAl'
      Size = 3
      Calculated = True
    end
  end
  object STSUFs: TDataSource
    DataSet = TSUFs
    Left = 61
    Top = 34
  end
end
