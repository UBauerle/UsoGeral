object FuDdSISV: TFuDdSISV
  Left = 270
  Top = 354
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'FFuGenericas....'
  ClientHeight = 226
  ClientWidth = 463
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object gbUFMun: TGroupBox
    Left = 0
    Top = 0
    Width = 463
    Height = 177
    Align = alTop
    Caption = 'Indique dados corretos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      463
      177)
    object Label1: TLabel
      Left = 8
      Top = 20
      Width = 106
      Height = 16
      Caption = 'Sigla UF (Estado)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 64
      Width = 57
      Height = 16
      Caption = 'Munic'#237'pio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object cbUFs: TComboBox
      Left = 8
      Top = 36
      Width = 273
      Height = 24
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 0
      Text = 'CBUFS'
      OnExit = cbUFsExit
    end
    object cbMunic: TComboBox
      Left = 8
      Top = 80
      Width = 443
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 1
      Text = 'CBMUNIC'
    end
    object btCancel: TBitBtn
      Left = 8
      Top = 140
      Width = 113
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = '&Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btCancelClick
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
    object btOk: TBitBtn
      Left = 378
      Top = 140
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Ok'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btOkClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        55555555555555555555555550055555555555555FF555555555555552005555
        5555555557FF5555555555552220555555555555777F55555555555522200555
        55555555777FF5555555555222220555555555577777F5555555552220220055
        555555777777FF5555555222052220555555577775777F555555220555522005
        5555777555577FF5555555555552220555555555555777F55555555555552200
        55555555555577FF5555555555555220055555555555577FF555555555555522
        0055555555555577FF5555555555555220005555555555577FFF555555555555
        5220555555555555577F55555555555555555555555555555555}
      NumGlyphs = 2
    end
  end
  object Feriados: TTable
    DatabaseName = 'SISV4'
    TableName = 'TbFeriad.DB'
    Left = 12
    Top = 176
    object FeriadosData: TDateField
      FieldName = 'Data'
    end
  end
  object VlRefs: TTable
    DatabaseName = 'SISV4'
    TableName = 'TbVlRef.DB'
    Left = 44
    Top = 176
    object VlRefsVlrData: TDateField
      FieldName = 'VlrData'
    end
    object VlRefsVlr01: TBCDField
      FieldName = 'Vlr01'
      Precision = 32
    end
    object VlRefsVlr02: TBCDField
      FieldName = 'Vlr02'
      Precision = 32
    end
    object VlRefsVlr03: TBCDField
      FieldName = 'Vlr03'
      Precision = 32
    end
    object VlRefsVlr04: TBCDField
      FieldName = 'Vlr04'
      Precision = 32
    end
    object VlRefsVlr05: TBCDField
      FieldName = 'Vlr05'
      Precision = 32
    end
  end
  object UFSiglas: TTable
    DatabaseName = 'SISV4'
    TableName = 'TS_Estados.db'
    Left = 168
    Top = 176
    object UFSiglasIBGE: TSmallintField
      FieldName = 'IBGE'
    end
    object UFSiglasSigla: TStringField
      FieldName = 'Sigla'
      Size = 2
    end
    object UFSiglasDenom: TStringField
      FieldName = 'Denom'
    end
    object UFSiglasAliqICM: TBCDField
      FieldName = 'AliqICM'
      Precision = 32
      Size = 2
    end
    object UFSiglasAliqICMInt: TBCDField
      FieldName = 'AliqICMInt'
      Precision = 32
      Size = 2
    end
    object UFSiglasCEPMin: TStringField
      FieldName = 'CEPMin'
      Size = 8
    end
    object UFSiglasCEPMax: TStringField
      FieldName = 'CEPMax'
      Size = 8
    end
  end
  object Cidades: TTable
    DatabaseName = 'SISV4'
    Filtered = True
    OnFilterRecord = CidadesFilterRecord
    TableName = 'TS_Cidades.DB'
    Left = 224
    Top = 176
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
      Size = 8
    end
    object CidadesVlr1: TCurrencyField
      FieldName = 'Vlr1'
    end
    object CidadesVlr2: TCurrencyField
      FieldName = 'Vlr2'
    end
    object CidadesVlr3: TCurrencyField
      FieldName = 'Vlr3'
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
  end
end
