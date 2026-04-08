object FuCepLocalidade: TFuCepLocalidade
  Left = 251
  Top = 131
  Width = 605
  Height = 563
  Caption = 'Pesquisa por Localidade'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 589
    Height = 448
    Align = alClient
    TabOrder = 0
    object Grid: TDBGrid
      Left = 1
      Top = 1
      Width = 587
      Height = 446
      Align = alClient
      DataSource = SCidades
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Nome'
          Title.Caption = 'Cidade / Localidade'
          Width = 417
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'UF'
          Title.Alignment = taCenter
          Width = 30
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ZC_CEP'
          Title.Alignment = taCenter
          Title.Caption = 'CEP'
          Width = 89
          Visible = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 448
    Width = 589
    Height = 77
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      589
      77)
    object Localizar: TLabel
      Left = 141
      Top = 12
      Width = 57
      Height = 16
      Alignment = taRightJustify
      Caption = 'Localizar:'
    end
    object Label1: TLabel
      Left = 177
      Top = 40
      Width = 21
      Height = 16
      Alignment = taRightJustify
      Caption = 'UF:'
    end
    object Label2: TLabel
      Left = 240
      Top = 40
      Width = 136
      Height = 16
      Caption = '(vazio para todas UFs)'
    end
    object Nav: TDBNavigator
      Left = 12
      Top = 8
      Width = 120
      Height = 25
      DataSource = SCidades
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      TabOrder = 3
    end
    object edtUF: TEdit
      Left = 204
      Top = 38
      Width = 30
      Height = 22
      AutoSize = False
      CharCase = ecUpperCase
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
      OnChange = edtUFChange
    end
    object edtLocalidade: TEdit
      Left = 204
      Top = 10
      Width = 235
      Height = 22
      AutoSize = False
      CharCase = ecUpperCase
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      OnChange = edtLocalidadeChange
    end
    object cbSelect: TCheckBox
      Left = 448
      Top = 12
      Width = 101
      Height = 17
      Caption = 'Selecionar'
      TabOrder = 2
      OnClick = cbSelectClick
    end
    object btUtiliz: TBitBtn
      Left = 12
      Top = 40
      Width = 95
      Height = 25
      Caption = '&Utilizar'
      TabOrder = 4
      OnClick = btUtilizClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        55555555555555555555555550055555555555555FF55555555555555C005555
        5555555557FF555555555555CCC0555555555555777F555555555555CCC00555
        55555555777FF5555555555CCCCC0555555555577777F555555555CCC0CC0055
        555555777777FF5555555CCC05CCC0555555577775777F555555CC05555CC005
        5555777555577FF555555555555CCC0555555555555777F5555555555555CC00
        55555555555577FF5555555555555CC0055555555555577FF5555555555555CC
        0055555555555577FF5555555555555CC0005555555555577FFF555555555555
        5CC0555555555555577F55555555555555555555555555555555}
      NumGlyphs = 2
    end
    object btCancel: TBitBtn
      Left = 476
      Top = 40
      Width = 95
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Cancelar'
      TabOrder = 5
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
  end
  object Cidades: TTable
    OnCalcFields = CidadesCalcFields
    DatabaseName = 'SISV4'
    Filtered = True
    OnFilterRecord = CidadesFilterRecord
    IndexName = 'Alfabetica'
    TableName = 'TS_Cidades.DB'
    Left = 493
    Top = 67
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
    object CidadesZC_CEP: TStringField
      FieldKind = fkCalculated
      FieldName = 'ZC_CEP'
      Size = 10
      Calculated = True
    end
  end
  object SCidades: TDataSource
    DataSet = Cidades
    Left = 521
    Top = 67
  end
end
