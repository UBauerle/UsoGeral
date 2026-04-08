object FCidadesIBGE: TFCidadesIBGE
  Left = 237
  Top = 117
  Width = 740
  Height = 640
  Caption = 'Munic'#237'pios: C'#243'digo IBGE e CEP'
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
    Width = 724
    Height = 3
    Align = alTop
    BevelOuter = bvNone
    Color = clMaroon
    TabOrder = 0
  end
  object PanCtle: TPanel
    Left = 0
    Top = 493
    Width = 724
    Height = 89
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      724
      89)
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
      Left = 124
      Top = 40
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
      DataSource = SCidades
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      TabOrder = 0
    end
    object CbOrdem: TComboBox
      Left = 124
      Top = 16
      Width = 169
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = 'CbOrdem'
      OnChange = CbOrdemChange
      Items.Strings = (
        'IBGE - UF / Cidade'
        'IBGE - Cidade / UF'
        'Alfab'#233'tica - Cidade / UF'
        'CEP ')
    end
    object EdLocaliz: TEdit
      Left = 124
      Top = 52
      Width = 209
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 2
      Text = 'EDLOCALIZ'
      OnChange = EdLocalizChange
    end
    object btUsarSair: TBitBtn
      Left = 628
      Top = 8
      Width = 87
      Height = 37
      Anchors = [akTop, akRight]
      Caption = 'Utilizar && Sair'
      TabOrder = 4
      OnClick = btUsarSairClick
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
    object GroupBox1: TGroupBox
      Left = 340
      Top = 1
      Width = 177
      Height = 87
      Caption = 'Sele'#231#227'o'
      TabOrder = 3
      object Label1: TLabel
        Left = 8
        Top = 28
        Width = 55
        Height = 13
        Alignment = taRightJustify
        Caption = 'Estado/UF:'
      end
      object Label16: TLabel
        Left = 13
        Top = 52
        Width = 50
        Height = 13
        Caption = 'C'#243'd.IBGE:'
      end
      object cbUFs: TComboBox
        Left = 68
        Top = 24
        Width = 97
        Height = 21
        CharCase = ecUpperCase
        ItemHeight = 13
        TabOrder = 0
        Text = 'CBUFS'
        OnChange = cbUFsChange
      end
      object cbIBGE: TComboBox
        Left = 68
        Top = 48
        Width = 97
        Height = 21
        ItemHeight = 13
        ItemIndex = 2
        TabOrder = 1
        Text = 'Com c'#243'digo'
        OnChange = cbIBGEChange
        Items.Strings = (
          'Todos'
          'Sem c'#243'digo'
          'Com c'#243'digo')
      end
    end
    object btNothing: TBitBtn
      Left = 14
      Top = 52
      Width = 25
      Height = 25
      Caption = '...'
      TabOrder = 5
      TabStop = False
    end
    object btSair: TBitBtn
      Left = 628
      Top = 52
      Width = 87
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Sair'
      TabOrder = 6
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
    object btTamOrig: TBitBtn
      Left = 73
      Top = 46
      Width = 35
      Height = 35
      Anchors = [akLeft, akBottom]
      TabOrder = 7
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
  object Grid: TDBGrid
    Left = 0
    Top = 3
    Width = 724
    Height = 350
    Align = alClient
    DataSource = SCidades
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
        Expanded = False
        FieldName = 'Nome'
        Title.Caption = 'Nome da cidade / munic'#237'pio'
        Width = 237
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'UF'
        Title.Alignment = taCenter
        Title.Caption = 'Sig'
        Width = 28
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'UFIBGE'
        Title.Alignment = taCenter
        Title.Caption = 'Est'
        Width = 28
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ZC_CodIBGE'
        Title.Alignment = taCenter
        Title.Caption = 'IBGE'
        Width = 56
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ZC_UFCodIBGE'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'd.IBGE'
        Width = 76
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CEP'
        Title.Alignment = taCenter
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Vlr1'
        Title.Alignment = taRightJustify
        Title.Caption = 'Tx/Vlr 1'
        Width = 81
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Vlr2'
        Title.Alignment = taRightJustify
        Title.Caption = 'Tx/Vlr 2'
        Width = 81
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Vlr3'
        Title.Alignment = taRightJustify
        Title.Caption = 'Tx/Vlr 3'
        Width = 81
        Visible = True
      end>
  end
  object PanManut: TPanel
    Left = 0
    Top = 353
    Width = 724
    Height = 140
    Align = alBottom
    Enabled = False
    TabOrder = 3
    DesignSize = (
      724
      140)
    object LabAcao: TLabel
      Left = 666
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
      Left = 8
      Top = 8
      Width = 129
      Height = 13
      Caption = 'Nome da cidade/munic'#237'pio'
    end
    object Label4: TLabel
      Left = 316
      Top = 8
      Width = 40
      Height = 13
      Caption = 'Sigla UF'
    end
    object Label5: TLabel
      Left = 440
      Top = 8
      Width = 47
      Height = 13
      Caption = 'C'#243'd IBGE'
    end
    object Label6: TLabel
      Left = 68
      Top = 48
      Width = 21
      Height = 13
      Caption = 'CEP'
    end
    object Label7: TLabel
      Left = 176
      Top = 48
      Width = 69
      Height = 13
      Caption = 'Taxas/Valores'
    end
    object Label8: TLabel
      Left = 252
      Top = 48
      Width = 9
      Height = 13
      Caption = '1)'
    end
    object Label9: TLabel
      Left = 344
      Top = 48
      Width = 9
      Height = 13
      Caption = '2)'
    end
    object Label10: TLabel
      Left = 436
      Top = 48
      Width = 9
      Height = 13
      Caption = '3)'
    end
    object Label11: TLabel
      Left = 12
      Top = 72
      Width = 63
      Height = 13
      Caption = 'Observa'#231#245'es'
    end
    object Label12: TLabel
      Left = 84
      Top = 72
      Width = 9
      Height = 13
      Caption = '1)'
    end
    object Label13: TLabel
      Left = 84
      Top = 94
      Width = 9
      Height = 13
      Caption = '2)'
    end
    object Label14: TLabel
      Left = 84
      Top = 116
      Width = 9
      Height = 13
      Caption = '3)'
    end
    object Label15: TLabel
      Left = 380
      Top = 8
      Width = 43
      Height = 13
      Caption = 'Est IBGE'
    end
    object EdCidade: TDBEdit
      Left = 8
      Top = 20
      Width = 301
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Nome'
      DataSource = SCidades
      TabOrder = 0
    end
    object EdCodIBGE: TDBEdit
      Left = 440
      Top = 20
      Width = 53
      Height = 21
      DataField = 'CodIBGE'
      DataSource = SCidades
      MaxLength = 5
      TabOrder = 3
    end
    object BtOk: TBitBtn
      Left = 628
      Top = 80
      Width = 87
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Ok'
      TabOrder = 11
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
      Left = 628
      Top = 108
      Width = 87
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Cancelar'
      TabOrder = 12
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
    object dbSigla: TDBLookupComboBox
      Left = 316
      Top = 20
      Width = 57
      Height = 21
      DataField = 'UF'
      DataSource = SCidades
      KeyField = 'Sigla'
      ListField = 'Sigla'
      ListSource = STSUFs
      TabOrder = 1
    end
    object DBEdit1: TDBEdit
      Left = 96
      Top = 44
      Width = 73
      Height = 21
      DataField = 'CEP'
      DataSource = SCidades
      MaxLength = 5
      TabOrder = 4
    end
    object DBEdit2: TDBEdit
      Left = 264
      Top = 44
      Width = 73
      Height = 21
      DataField = 'Vlr1'
      DataSource = SCidades
      TabOrder = 5
    end
    object DBEdit3: TDBEdit
      Left = 356
      Top = 44
      Width = 73
      Height = 21
      DataField = 'Vlr2'
      DataSource = SCidades
      TabOrder = 6
    end
    object DBEdit4: TDBEdit
      Left = 448
      Top = 44
      Width = 73
      Height = 21
      DataField = 'Vlr3'
      DataSource = SCidades
      TabOrder = 7
    end
    object DBEdit5: TDBEdit
      Left = 96
      Top = 68
      Width = 425
      Height = 21
      DataField = 'Obs1'
      DataSource = SCidades
      TabOrder = 8
    end
    object DBEdit6: TDBEdit
      Left = 96
      Top = 90
      Width = 425
      Height = 21
      DataField = 'Obs2'
      DataSource = SCidades
      TabOrder = 9
    end
    object DBEdit7: TDBEdit
      Left = 96
      Top = 112
      Width = 425
      Height = 21
      DataField = 'Obs3'
      DataSource = SCidades
      TabOrder = 10
    end
    object DBEdit8: TDBEdit
      Left = 380
      Top = 20
      Width = 53
      Height = 21
      DataField = 'UFIBGE'
      DataSource = SCidades
      Enabled = False
      MaxLength = 5
      TabOrder = 2
    end
  end
  object MenuPrinc: TMainMenu
    Left = 176
    Top = 76
    object Cidades1: TMenuItem
      Caption = '&Cidades'
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
    end
  end
  object TSUFs: TTable
    DatabaseName = 'SISV4'
    TableName = 'TS_Estados.db'
    Left = 17
    Top = 54
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
  end
  object STSUFs: TDataSource
    DataSet = TSUFs
    Left = 49
    Top = 54
  end
  object Cidades: TTable
    OnCalcFields = CidadesCalcFields
    DatabaseName = 'SISV4'
    OnFilterRecord = CidadesFilterRecord
    IndexName = 'Alfabetica'
    TableName = 'TS_Cidades.DB'
    Left = 17
    Top = 119
    object CidadesUFIBGE: TSmallintField
      FieldName = 'UFIBGE'
    end
    object CidadesCodIBGE: TIntegerField
      FieldName = 'CodIBGE'
    end
    object CidadesNome: TStringField
      FieldName = 'Nome'
      Size = 60
    end
    object CidadesUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object CidadesCEP: TStringField
      FieldName = 'CEP'
      EditMask = '00\.000\-999;0; '
      Size = 8
    end
    object CidadesVlr1: TCurrencyField
      FieldName = 'Vlr1'
      DisplayFormat = ',0.00'
      EditFormat = '0.00'
    end
    object CidadesVlr2: TCurrencyField
      FieldName = 'Vlr2'
      DisplayFormat = ',0.00'
      EditFormat = '0.00'
    end
    object CidadesVlr3: TCurrencyField
      FieldName = 'Vlr3'
      DisplayFormat = ',0.00'
      EditFormat = '0.00'
    end
    object CidadesObs1: TStringField
      FieldName = 'Obs1'
      Size = 80
    end
    object CidadesObs2: TStringField
      FieldName = 'Obs2'
      Size = 80
    end
    object CidadesObs3: TStringField
      FieldName = 'Obs3'
      Size = 80
    end
    object CidadesZC_CodIBGE: TStringField
      FieldKind = fkCalculated
      FieldName = 'ZC_CodIBGE'
      Size = 5
      Calculated = True
    end
    object CidadesZC_UFCodIBGE: TStringField
      FieldKind = fkCalculated
      FieldName = 'ZC_UFCodIBGE'
      Size = 7
      Calculated = True
    end
    object CidadesZC_CEP: TStringField
      FieldKind = fkCalculated
      FieldName = 'ZC_CEP'
      Size = 10
      Calculated = True
    end
  end
  object SCidades: TDataSource
    DataSet = Cidades
    Left = 49
    Top = 119
  end
end
