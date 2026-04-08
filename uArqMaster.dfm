object FuArqMaster: TFuArqMaster
  Left = 316
  Top = 225
  Width = 431
  Height = 284
  BorderIcons = [biSystemMenu]
  Caption = 'Dados de inicializa'#231#227'o do sistema - Certificados de origem'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object panRodape: TPanel
    Left = 0
    Top = 205
    Width = 415
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      415
      41)
    object btGravar: TBitBtn
      Left = 221
      Top = 8
      Width = 93
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Gravar'
      TabOrder = 0
      OnClick = btGravarClick
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
    object btCancelar: TBitBtn
      Left = 317
      Top = 8
      Width = 93
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Cancelar'
      TabOrder = 1
      OnClick = btCancelarClick
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
  end
  object gbUsuario: TGroupBox
    Left = 0
    Top = 0
    Width = 415
    Height = 205
    Align = alClient
    Caption = 'Usu'#225'rio principal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label3: TLabel
      Left = 8
      Top = 32
      Width = 64
      Height = 13
      Alignment = taRightJustify
      Caption = 'Raz'#227'o social:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 29
      Top = 56
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = 'Fantasia:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 29
      Top = 80
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = 'CNPJ (*):'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 45
      Top = 104
      Width = 27
      Height = 13
      Alignment = taRightJustify
      Caption = 'UF(*):'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 12
      Top = 128
      Width = 60
      Height = 13
      Alignment = taRightJustify
      Caption = 'I.Estadual(*):'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 140
      Top = 160
      Width = 46
      Height = 16
      Caption = 'Serial:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 296
      Top = 92
      Width = 95
      Height = 13
      Caption = '(*)  Dados opcionais'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object EdRSoc: TDBEdit
      Left = 76
      Top = 28
      Width = 317
      Height = 21
      DataField = 'Empresa'
      DataSource = SMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object EdFant: TDBEdit
      Left = 76
      Top = 52
      Width = 185
      Height = 21
      DataField = 'Fantasia'
      DataSource = SMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object EdCGC: TDBEdit
      Left = 76
      Top = 76
      Width = 137
      Height = 21
      DataField = 'CGC'
      DataSource = SMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object EdUF: TDBEdit
      Left = 76
      Top = 100
      Width = 29
      Height = 21
      DataField = 'UF'
      DataSource = SMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object EDIest: TDBEdit
      Left = 76
      Top = 124
      Width = 137
      Height = 21
      DataField = 'InscEst'
      DataSource = SMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object EdSer: TDBEdit
      Left = 188
      Top = 156
      Width = 105
      Height = 24
      DataField = 'Serial'
      DataSource = SMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
  end
  object Master: TTable
    DatabaseName = 'UBSGeral'
    TableName = 'UBMaster.DB'
    Left = 324
    Top = 120
    object MasterEmpresa: TStringField
      FieldName = 'Empresa'
      Size = 50
    end
    object MasterFantasia: TStringField
      FieldName = 'Fantasia'
    end
    object MasterCGC: TStringField
      FieldName = 'CGC'
      EditMask = '99\.999\.999\/9999-99;0; '
      Size = 14
    end
    object MasterInscEst: TStringField
      FieldName = 'InscEst'
      Size = 15
    end
    object MasterUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object MasterSerial: TStringField
      FieldName = 'Serial'
      EditMask = '0000\-000\-0000;0; '
      Size = 11
    end
    object MasterDtValid: TDateField
      FieldName = 'DtValid'
    end
    object MasterAlgor: TIntegerField
      FieldName = 'Algor'
    end
  end
  object SMaster: TDataSource
    DataSet = Master
    Left = 360
    Top = 120
  end
end
