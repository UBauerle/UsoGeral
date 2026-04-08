object FCadWork: TFCadWork
  Left = 244
  Top = 195
  Width = 452
  Height = 439
  BorderIcons = []
  Caption = 'Atualizar c'#243'digo de Pa'#237's'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 436
    Height = 401
    Align = alClient
    TabOrder = 0
    DesignSize = (
      436
      401)
    object Gauge1: TGauge
      Left = 8
      Top = 22
      Width = 420
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Progress = 0
    end
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 62
      Height = 13
      Caption = 'Processando'
    end
    object LabConta: TLabel
      Left = 382
      Top = 8
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'LabConta'
    end
    object BtOk: TBitBtn
      Left = 311
      Top = 52
      Width = 117
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Ok'
      TabOrder = 0
      Visible = False
      OnClick = BtOkClick
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
    object btInterrupt: TBitBtn
      Left = 186
      Top = 52
      Width = 117
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Interromper'
      TabOrder = 1
      Visible = False
      OnClick = btInterruptClick
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
    object Memo1: TMemo
      Left = 8
      Top = 192
      Width = 417
      Height = 37
      Lines.Strings = (
        'Memo1')
      TabOrder = 2
    end
    object DbRichTextRefCom: TDBRichEdit
      Left = 8
      Top = 232
      Width = 417
      Height = 37
      DataField = 'RefCom'
      DataSource = DMG.SCadastro
      TabOrder = 3
    end
    object DbRichTextObserv: TDBRichEdit
      Left = 8
      Top = 312
      Width = 417
      Height = 37
      DataField = 'Observ'
      DataSource = DMG.SCadastro
      TabOrder = 4
    end
    object DbMemoRefCom: TDBMemo
      Left = 8
      Top = 272
      Width = 417
      Height = 37
      DataField = 'RefCom'
      DataSource = DMG.SCadastro
      TabOrder = 5
    end
    object DbMemoObserv: TDBMemo
      Left = 8
      Top = 352
      Width = 417
      Height = 37
      DataField = 'Observ'
      DataSource = DMG.SCadastro
      TabOrder = 6
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 24
    Top = 28
  end
end
