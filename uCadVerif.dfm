object FuCadVerif: TFuCadVerif
  Left = 342
  Top = 118
  Width = 465
  Height = 472
  BorderIcons = [biSystemMenu]
  Caption = 'Verifica'#231#227'o de cadastro'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 449
    Height = 279
    Align = alClient
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
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 279
    Width = 449
    Height = 97
    Align = alBottom
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 70
      Height = 13
      Caption = 'Processo geral'
    end
    object Gau1: TGauge
      Left = 8
      Top = 22
      Width = 433
      Height = 17
      ForeColor = clGreen
      Progress = 0
    end
    object LabTotal: TLabel
      Left = 397
      Top = 8
      Width = 42
      Height = 13
      Alignment = taRightJustify
      Caption = 'LabTotal'
    end
    object LabMax: TLabel
      Left = 401
      Top = 48
      Width = 38
      Height = 13
      Alignment = taRightJustify
      Caption = 'LabMax'
      Visible = False
    end
    object Gau2: TGauge
      Left = 8
      Top = 62
      Width = 433
      Height = 17
      ForeColor = clNavy
      Progress = 0
      Visible = False
    end
    object LabProcess: TLabel
      Left = 8
      Top = 48
      Width = 74
      Height = 13
      Caption = 'Tabela/Arquivo'
      Visible = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 417
    Width = 449
    Height = 17
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
  end
  object Panel3: TPanel
    Left = 0
    Top = 376
    Width = 449
    Height = 41
    Align = alBottom
    TabOrder = 3
    DesignSize = (
      449
      41)
    object btProcesso: TBitBtn
      Left = 18
      Top = 8
      Width = 119
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = '&Iniciar processo'
      TabOrder = 0
      OnClick = btProcessoClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333999993333333333F88888FFF333333999999999
        33333338888F3388FF33339933808399933333883338FF388FF3399333000339
        993338833388833388F3393333808333993338F33338333338FF993333333333
        399388F333333333388F993333303333399388F33338F333388F993333808333
        399388F333388F33388F993333101333399388F333888F33388F993333000333
        399388FF33888F3338833993330003333933383FF3888F3338F3399933000333
        99333883FF888F338833339993808339933333883FF8FFF88333333999999999
        3333333888333888333333333999993333333333388888333333}
      NumGlyphs = 2
    end
    object btCancel: TBitBtn
      Left = 166
      Top = 8
      Width = 119
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Cancelar'
      TabOrder = 1
      OnClick = btCancelClick
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
    object btSair: TBitBtn
      Left = 312
      Top = 8
      Width = 119
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Sair'
      TabOrder = 2
      OnClick = btSairClick
      OnEnter = btSairEnter
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
  end
  object VCadas: TTable
    DatabaseName = 'SISV4'
    TableName = 'Cad_Geral.DB'
    Left = 236
    Top = 48
    object VCadasCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object VCadasRzSocial: TStringField
      FieldName = 'RzSocial'
      Size = 50
    end
    object VCadasFantasia: TStringField
      FieldName = 'Fantasia'
      Size = 30
    end
  end
  object VDep: TTable
    DatabaseName = 'SISV4'
    TableName = 'Cad_GerPessoal.DB'
    Left = 296
    Top = 48
    object VDepCodigo: TIntegerField
      FieldName = 'Codigo'
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 312
    Top = 140
  end
  object Titulos: TTable
    DatabaseName = 'SISV4'
    Filtered = True
    OnFilterRecord = TitulosFilterRecord
    TableName = 'Titulos.DB'
    Left = 16
    Top = 172
    object TitulosPagRec: TStringField
      FieldName = 'PagRec'
      Size = 1
    end
    object TitulosNro: TIntegerField
      FieldName = 'Nro'
    end
    object TitulosParc: TStringField
      FieldName = 'Parc'
      Size = 2
    end
    object TitulosPortador: TIntegerField
      FieldName = 'Portador'
    end
    object TitulosValor: TCurrencyField
      FieldName = 'Valor'
    end
    object TitulosDtVencto: TDateField
      FieldName = 'DtVencto'
    end
    object TitulosTpJur: TSmallintField
      FieldName = 'TpJur'
    end
    object TitulosPcJur: TBCDField
      FieldName = 'PcJur'
      Precision = 32
    end
    object TitulosVlDesc: TCurrencyField
      FieldName = 'VlDesc'
    end
    object TitulosPgtCapital: TCurrencyField
      FieldName = 'PgtCapital'
    end
    object TitulosPgtJuros: TCurrencyField
      FieldName = 'PgtJuros'
    end
    object TitulosPgtDesc: TCurrencyField
      FieldName = 'PgtDesc'
    end
    object TitulosMultaVlr: TCurrencyField
      FieldName = 'MultaVlr'
    end
    object TitulosSituacao: TSmallintField
      FieldName = 'Situacao'
    end
    object TitulosDtDesc: TDateField
      FieldName = 'DtDesc'
    end
    object TitulosPgtData: TDateField
      FieldName = 'PgtData'
    end
    object TitulosTpDoc: TSmallintField
      FieldName = 'TpDoc'
    end
  end
  object CadFSit: TTable
    DatabaseName = 'SISV4'
    TableName = 'Cad_GerSitFin.DB'
    Left = 60
    Top = 172
    object CadFSitCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object CadFSitDtHrCalc: TDateTimeField
      FieldName = 'DtHrCalc'
    end
    object CadFSitCPagVencVlr: TCurrencyField
      FieldName = 'CPagVencVlr'
    end
    object CadFSitCPagVencTits: TSmallintField
      FieldName = 'CPagVencTits'
    end
    object CadFSitCPagAVenVlr: TCurrencyField
      FieldName = 'CPagAVenVlr'
    end
    object CadFSitCPagAVenTits: TSmallintField
      FieldName = 'CPagAVenTits'
    end
    object CadFSitCPagVlrTotal: TCurrencyField
      FieldName = 'CPagVlrTotal'
    end
    object CadFSitCPagQtTotal: TSmallintField
      FieldName = 'CPagQtTotal'
    end
    object CadFSitCPagVlrQuit: TCurrencyField
      FieldName = 'CPagVlrQuit'
    end
    object CadFSitCPagTtQuit: TSmallintField
      FieldName = 'CPagTtQuit'
    end
    object CadFSitCPagDiasAtraso: TIntegerField
      FieldName = 'CPagDiasAtraso'
    end
    object CadFSitCPagMaiorAtraso: TSmallintField
      FieldName = 'CPagMaiorAtraso'
    end
    object CadFSitCPagTotAtraso: TSmallintField
      FieldName = 'CPagTotAtraso'
    end
    object CadFSitCRecVencVlr: TCurrencyField
      FieldName = 'CRecVencVlr'
    end
    object CadFSitCRecVencTits: TSmallintField
      FieldName = 'CRecVencTits'
    end
    object CadFSitCRecAVenVlr: TCurrencyField
      FieldName = 'CRecAVenVlr'
    end
    object CadFSitCRecAVenTits: TSmallintField
      FieldName = 'CRecAVenTits'
    end
    object CadFSitCRecVlrTotal: TCurrencyField
      FieldName = 'CRecVlrTotal'
    end
    object CadFSitCRecQtTotal: TSmallintField
      FieldName = 'CRecQtTotal'
    end
    object CadFSitCRecVlrQuit: TCurrencyField
      FieldName = 'CRecVlrQuit'
    end
    object CadFSitCRecTtQuit: TSmallintField
      FieldName = 'CRecTtQuit'
    end
    object CadFSitCRecDiasAtraso: TIntegerField
      FieldName = 'CRecDiasAtraso'
    end
    object CadFSitCRecMaiorAtraso: TSmallintField
      FieldName = 'CRecMaiorAtraso'
    end
    object CadFSitCRecTotAtraso: TSmallintField
      FieldName = 'CRecTotAtraso'
    end
    object CadFSitSaldo: TCurrencyField
      FieldName = 'Saldo'
    end
  end
  object CadPess: TTable
    DatabaseName = 'SISV4'
    TableName = 'Cad_GerPessoal.DB'
    Left = 108
    Top = 172
    object CadPessCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object CadPessCredLimite: TCurrencyField
      FieldName = 'CredLimite'
    end
    object CadPessCredUtilizado: TCurrencyField
      FieldName = 'CredUtilizado'
    end
    object CadPessUltCompra: TDateField
      FieldName = 'UltCompra'
    end
  end
end
