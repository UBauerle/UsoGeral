object FuCertificados: TFuCertificados
  Left = 234
  Top = 124
  Width = 984
  Height = 402
  BorderIcons = [biSystemMenu]
  Caption = 'Verifica validade dos certificados'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 968
    Height = 284
    Align = alClient
    TabOrder = 1
    object Grid: TDBGrid
      Left = 1
      Top = 1
      Width = 966
      Height = 282
      Align = alClient
      DataSource = STbEF
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = GridDrawColumnCell
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Cod'
          Title.Alignment = taCenter
          Width = 31
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Denom'
          Title.Caption = 'Empresa / Filial'
          Width = 351
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CNPJ'
          Width = 132
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ValCertif'
          Title.Caption = 'Validade'
          Width = 148
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ZC_DiasExib'
          Title.Alignment = taCenter
          Title.Caption = 'Dias'
          Width = 45
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ZC_Situacao'
          Title.Caption = 'Situa'#231#227'o'
          Visible = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 284
    Width = 968
    Height = 80
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      968
      80)
    object LabMsgProx: TLabel
      Left = 12
      Top = 8
      Width = 340
      Height = 20
      Caption = 'certificados a vencer nos pr'#243'ximos 30 dias'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Visible = False
    end
    object LabMsgNorm: TLabel
      Left = 12
      Top = 32
      Width = 189
      Height = 16
      Caption = 'certificados em situa'#231#227'o normal'
      Visible = False
    end
    object LabMsgVenc: TLabel
      Left = 12
      Top = 52
      Width = 127
      Height = 16
      Caption = 'certificados vencidos'
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clAqua
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Visible = False
    end
    object btProsseg: TBitBtn
      Left = 792
      Top = 44
      Width = 153
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Prosseguir'
      TabOrder = 0
      OnClick = btProssegClick
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
  end
  object TbEF: TTable
    OnCalcFields = TbEFCalcFields
    DatabaseName = 'SISV4'
    TableName = 'Tb02EFi.DB'
    Left = 816
    Top = 184
    object TbEFCod: TSmallintField
      FieldName = 'Cod'
    end
    object TbEFDenom: TStringField
      FieldName = 'Denom'
      Size = 50
    end
    object TbEFCNPJ: TStringField
      FieldName = 'CNPJ'
      EditMask = '00.000.000/0000-00;0;_'
      Size = 14
    end
    object TbEFValCertif: TDateTimeField
      FieldName = 'ValCertif'
    end
    object TbEFZC_Dias: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'ZC_Dias'
      Calculated = True
    end
    object TbEFZC_Situacao: TStringField
      FieldKind = fkCalculated
      FieldName = 'ZC_Situacao'
      Size = 30
      Calculated = True
    end
    object TbEFZC_DiasExib: TStringField
      FieldKind = fkCalculated
      FieldName = 'ZC_DiasExib'
      Size = 4
      Calculated = True
    end
  end
  object STbEF: TDataSource
    DataSet = TbEF
    Left = 848
    Top = 184
  end
end
