object FuMsgTimer: TFuMsgTimer
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'FuMsgTimer'
  ClientHeight = 142
  ClientWidth = 801
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  DesignSize = (
    801
    142)
  TextHeight = 16
  object LabMsg: TLabel
    Left = 8
    Top = 12
    Width = 49
    Height = 16
    Caption = 'LabMsg'
  end
  object LabTmp: TLabel
    Left = 742
    Top = 118
    Width = 51
    Height = 16
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    Caption = 'LabTmp'
  end
end
