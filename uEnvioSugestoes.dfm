object FuEnvioSugestoes: TFuEnvioSugestoes
  Left = 196
  Top = 106
  Width = 849
  Height = 480
  Caption = 'Envio Melhorias e Sugestoes'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RLSugestoes: TRLReport
    Left = 8
    Top = 8
    Width = 794
    Height = 1123
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 67
      BandType = btHeader
      object RLTexto: TRLMemo
        Left = 8
        Top = 48
        Width = 705
        Height = 16
      end
      object RLPanel1: TRLPanel
        Left = 0
        Top = 0
        Width = 718
        Height = 37
        Align = faTop
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = True
        Borders.FixedBottom = True
        object RLLabel1: TRLLabel
          Left = 0
          Top = 0
          Width = 176
          Height = 16
          Align = faLeftTop
          Caption = 'Sugestoes e melhorias'
        end
        object RLLabEmp: TRLLabel
          Left = 0
          Top = 19
          Width = 72
          Height = 16
          Align = faLeftOnly
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabSis: TRLLabel
          Left = 646
          Top = 0
          Width = 72
          Height = 16
          Align = faRightTop
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabDTHR: TRLLabel
          Left = 638
          Top = 19
          Width = 80
          Height = 16
          Align = faRightOnly
          Alignment = taRightJustify
        end
      end
    end
  end
end
