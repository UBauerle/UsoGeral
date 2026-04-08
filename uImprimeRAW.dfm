object FLstRel: TFLstRel
  Left = 186
  Top = 107
  Width = 260
  Height = 225
  BorderIcons = [biSystemMenu]
  Caption = 'Impress'#227'o de relat'#243'rio'
  Color = 14876412
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LabArq: TLabel
    Left = 12
    Top = 12
    Width = 171
    Height = 16
    Caption = 'Nome do arquivo a listar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabAviso: TLabel
    Left = 12
    Top = 32
    Width = 130
    Height = 13
    Caption = 'Arquivo INEXISTENTE'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label1: TLabel
    Left = 16
    Top = 64
    Width = 43
    Height = 13
    Caption = 'C'#243'pias:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 146
    Width = 244
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    Color = 14470087
    TabOrder = 0
    DesignSize = (
      244
      41)
    object BtLst: TBitBtn
      Left = 20
      Top = 8
      Width = 95
      Height = 25
      Caption = '&Imprimir'
      TabOrder = 0
      OnClick = BtLstClick
    end
    object BtCanc: TBitBtn
      Left = 136
      Top = 8
      Width = 95
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Cancelar'
      TabOrder = 1
      OnClick = BtCancClick
    end
  end
  object CbDelete: TCheckBox
    Left = 16
    Top = 116
    Width = 177
    Height = 17
    Caption = '&Excluir ap'#243's a impress'#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object CbCopias: TComboBox
    Left = 60
    Top = 60
    Width = 53
    Height = 21
    ItemHeight = 13
    TabOrder = 1
    Text = 'CbCopias'
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
      '13'
      '14'
      '15'
      '16'
      '17'
      '18'
      '19'
      '20')
  end
  object CbEject: TCheckBox
    Left = 16
    Top = 96
    Width = 221
    Height = 17
    Caption = 'Ejetar &pagina ao final da impress'#227'o'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 2
  end
end
