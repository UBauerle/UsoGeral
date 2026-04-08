object FuExclueArquivos: TFuExclueArquivos
  Left = 258
  Top = 117
  Width = 267
  Height = 553
  BorderIcons = [biSystemMenu]
  Caption = 'Exclus'#227'o de arquivos'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 45
    Width = 259
    Height = 403
    Align = alClient
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object FLBox: TFileListBox
    Left = 8
    Top = 68
    Width = 217
    Height = 361
    ItemHeight = 13
    TabOrder = 0
    Visible = False
  end
  object Memo2: TMemo
    Left = 4
    Top = 192
    Width = 197
    Height = 169
    Lines.Strings = (
      'Memo2')
    TabOrder = 2
    Visible = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 505
    Width = 259
    Height = 21
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
  end
  object Panel2: TPanel
    Left = 0
    Top = 448
    Width = 259
    Height = 57
    Align = alBottom
    TabOrder = 4
    DesignSize = (
      259
      57)
    object LabInform: TLabel
      Left = 8
      Top = 5
      Width = 85
      Height = 13
      Caption = 'Pesquisando...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BtExclus: TBitBtn
      Left = 6
      Top = 24
      Width = 117
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Excluir arquivos'
      TabOrder = 0
      OnClick = BtExclusClick
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
      Left = 130
      Top = 24
      Width = 117
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Cancelar'
      TabOrder = 1
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
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 259
    Height = 45
    Align = alTop
    TabOrder = 5
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 53
      Height = 13
      Caption = 'Caminho:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 24
      Width = 53
      Height = 13
      Caption = 'M'#225'scara:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabPath: TLabel
      Left = 64
      Top = 8
      Width = 40
      Height = 13
      Caption = 'LabPath'
    end
    object LabMasc: TLabel
      Left = 64
      Top = 24
      Width = 44
      Height = 13
      Caption = 'LabMasc'
    end
    object LabAuxil: TLabel
      Left = 172
      Top = 12
      Width = 40
      Height = 13
      Caption = 'LabAuxil'
    end
  end
end
