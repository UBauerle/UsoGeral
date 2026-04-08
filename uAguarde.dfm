object FuAguarde: TFuAguarde
  Left = 401
  Top = 231
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Aguarde........'
  ClientHeight = 102
  ClientWidth = 374
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 20
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 374
    Height = 102
    Align = alClient
    BevelInner = bvLowered
    BevelWidth = 2
    Color = 12189695
    TabOrder = 0
    DesignSize = (
      374
      102)
    object LabInform: TLabel
      Left = 8
      Top = 16
      Width = 73
      Height = 20
      Caption = 'LabInform'
    end
    object LabAguarde: TLabel
      Left = 237
      Top = 56
      Width = 121
      Height = 29
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = 'Aguarde.....'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 164
    Top = 28
  end
end
