object FuSenhaGenerica: TFuSenhaGenerica
  Left = 449
  Top = 240
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Senha de acesso'
  ClientHeight = 327
  ClientWidth = 191
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 191
    Height = 286
    Align = alClient
    TabOrder = 0
    object LabSenha: TLabel
      Left = 12
      Top = 20
      Width = 115
      Height = 16
      Alignment = taCenter
      Caption = 'Informe a senha '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabAviso: TLabel
      Left = 12
      Top = 72
      Width = 147
      Height = 16
      Caption = 'x tentativas restantes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object imgSenha: TImage
      Left = 161
      Top = 20
      Width = 16
      Height = 16
      Picture.Data = {
        07544269746D6170F6000000424DF60000000000000076000000280000001000
        000010000000010004000000000080000000C40E0000C40E0000100000000000
        0000000000000000800000800000008080008000000080008000808000008080
        8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF87777778FFFFFF877877778778FFF878F877778F878F87FFF777777F
        FF7877FFF780077FFF7787FFF8F7477FFF78F778F870008F877FFF8778777787
        78FFFFFF87700778FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF}
      Stretch = True
      Transparent = True
      OnClick = imgSenhaClick
    end
    object Label1: TLabel
      Left = 156
      Top = 100
      Width = 28
      Height = 16
      Caption = 'Dica'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = Label1Click
    end
    object LabSenhas: TLabel
      Left = 16
      Top = 124
      Width = 69
      Height = 16
      Caption = 'LabSenhas'
      Visible = False
    end
    object edSenha: TMaskEdit
      Left = 12
      Top = 36
      Width = 165
      Height = 28
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 32
      ParentFont = False
      PasswordChar = '#'
      TabOrder = 0
      Text = '123456789012345'
      OnExit = edSenhaExit
      OnKeyDown = edSenhaKeyDown
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 286
    Width = 191
    Height = 41
    Align = alBottom
    TabOrder = 1
    object btSair: TBitBtn
      Left = 23
      Top = 8
      Width = 141
      Height = 25
      Caption = '&Prosseguir'
      TabOrder = 0
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
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 148
    Top = 156
  end
end
