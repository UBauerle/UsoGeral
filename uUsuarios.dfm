object FuUsuarios: TFuUsuarios
  Left = 338
  Top = 189
  Width = 280
  Height = 240
  BorderIcons = [biSystemMenu]
  Caption = 'Usu'#225'rio'
  Color = 14470087
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000FFFFFFFFF00000000000000000000000FFFFFFFFF0000
    0000000000000000000FFFFFFFFF0000000000000000000000FFFFFFFFFF0000
    00000000000000000FFFFFFFFFFF0000000000000FFFFFF0000FFFFFFFFF0000
    000000000FFFFFFFFFF00FFFFFFF00000000000000FFFFFFFFFFF0FFFFFF0000
    0000000000FFFFFFFFFFFFFFFFFF00000000000000000FFFFFFFFFFFFFFF0000
    0000000000FFF0FFFFFFFFFFFFFF00000000000000FFFFFFFFFFFFFFFFFF0000
    000000000FFFFFFFFFFFFFFFFFFF0000000000000FFFFFFFFFFFFFFFFFFF0000
    0000000000FFFFFFF0FFFFFFFFFF0000000000FFFF0FFFFF0FFFFFFFF0FF0000
    000000FFFFFFFFF0FFFFFFFF0F0F00000000000FFFFFFFF0FFFFFFFFFF0F0000
    0000000FFFFFFF0FFFFFFFFF0F0F000000000000FFFFFF0FFFFFFFF0FF0F0000
    00000000FFFFFF0FFFFFFFFF0F0F0000000000000FFFFFFFFFFF0000FF0F0000
    000000000FFFFFFFFFF07770FFF000000000000000F00FFFFFF0777700070000
    0000000000FF00FFFF07777777770000000000000FF00FFFFF07777777770000
    000000000F00FFFFF077777777770000000000000FFFFFFF0777777777770000
    000000000000FFF07777777777770000000000000FFFFF007777777777770000
    000000000FFFF0077777777777770000000000000FFFF077777777777777FFFF
    FC00FFFFFC00FFFFFC00FFFFF000FFF81800FFF00000FFF00000FFF80000FFF8
    0000FFF80000FFF80000FFF00000FFF00000FFF00000FFC00000FF800000FF80
    0000FF800000FFC00000FFE00000FFE00000FFF00000FFF00000FFF80000FFF8
    0000FFF00000FFF00000FFF00000FFF00000FFF00000FFF00000FFF00000}
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 16
  object PanCtl: TPanel
    Left = 0
    Top = 153
    Width = 264
    Height = 49
    Align = alBottom
    Color = 12893333
    TabOrder = 1
    object btOk: TBitBtn
      Left = 16
      Top = 12
      Width = 105
      Height = 25
      Hint = 'Confirma a utiliza'#231#227'o do sistema'
      Caption = '&Ok'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btOkClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object btCancel: TBitBtn
      Left = 140
      Top = 12
      Width = 105
      Height = 25
      Hint = 'Cancela a utiliza'#231#227'o'
      Caption = '&Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btCancelClick
      Kind = bkCancel
    end
  end
  object PanUser: TPanel
    Left = 0
    Top = 0
    Width = 264
    Height = 153
    Align = alClient
    BevelInner = bvLowered
    Color = 14142668
    TabOrder = 0
    object Label1: TLabel
      Left = 32
      Top = 26
      Width = 63
      Height = 20
      Caption = 'Usu'#225'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 42
      Top = 62
      Width = 53
      Height = 20
      Caption = 'Senha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabMsg: TLabel
      Left = 12
      Top = 95
      Width = 64
      Height = 20
      Hint = 'Mensagem de arro'
      Caption = 'LabMsg'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object edUsuar: TMaskEdit
      Left = 100
      Top = 20
      Width = 125
      Height = 32
      Hint = 'Identifica'#231#227'o do usu'#225'rio'
      Color = 14876412
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      Text = 'edUsuar'
      OnChange = edUsuarChange
      OnExit = edUsuarExit
    end
    object EdSenha: TMaskEdit
      Left = 100
      Top = 56
      Width = 89
      Height = 32
      Hint = 'Senha do usu'#225'rio'
      Color = 14876412
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 6
      ParentFont = False
      PasswordChar = '#'
      TabOrder = 1
      Text = 'EdSenha'
      OnChange = EdSenhaChange
    end
  end
  object Usuarios: TTable
    DatabaseName = 'SISV4'
    TableName = 'Usuarios.DB'
    Left = 116
    Top = 100
    object UsuariosUser: TStringField
      FieldName = 'User'
      Size = 10
    end
    object UsuariosNome: TStringField
      FieldName = 'Nome'
      Size = 40
    end
    object UsuariosSenha: TStringField
      FieldName = 'Senha'
      Size = 6
    end
    object UsuariosTipo: TSmallintField
      FieldName = 'Tipo'
    end
  end
  object Acessos: TTable
    DatabaseName = 'SISV4'
    TableName = 'UsuAcessos.DB'
    Left = 156
    Top = 100
    object AcessosUser: TStringField
      FieldName = 'User'
      Size = 10
    end
    object AcessosOper: TSmallintField
      FieldName = 'Oper'
    end
  end
  object Operacoes: TTable
    DatabaseName = 'SISV4'
    TableName = 'Operacoes.DB'
    Left = 212
    Top = 100
    object OperacoesNumer: TIntegerField
      FieldName = 'Numer'
    end
    object OperacoesIdentif: TStringField
      FieldName = 'Identif'
      Size = 40
    end
    object OperacoesDescr: TMemoField
      FieldName = 'Descr'
      BlobType = ftMemo
      Size = 10
    end
    object OperacoesUsoWrk: TBooleanField
      FieldName = 'UsoWrk'
    end
  end
end
