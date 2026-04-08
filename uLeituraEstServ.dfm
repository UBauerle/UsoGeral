object FLeEstServ: TFLeEstServ
  Left = 254
  Top = 213
  Width = 716
  Height = 257
  Caption = 'Leitura estoque / Servi'#231'os'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Estoques: TTable
    DatabaseName = 'SISV4'
    TableName = 'Estoques.DB'
    Left = 24
    Top = 60
    object EstoquesItem: TStringField
      FieldName = 'Item'
      Size = 13
    end
    object EstoquesDescr: TStringField
      FieldName = 'Descr'
      Size = 45
    end
    object EstoquesDescrCmpl: TMemoField
      FieldName = 'DescrCmpl'
      BlobType = ftMemo
      Size = 10
    end
    object EstoquesUnid: TStringField
      FieldName = 'Unid'
      Size = 3
    end
    object EstoquesRefer: TStringField
      FieldName = 'Refer'
      Size = 25
    end
    object EstoquesGrupo: TSmallintField
      FieldName = 'Grupo'
    end
    object EstoquesImport: TSmallintField
      FieldName = 'Import'
    end
    object EstoquesQbLote: TBooleanField
      FieldName = 'QbLote'
    end
    object EstoquesDtCadas: TDateField
      FieldName = 'DtCadas'
    end
    object EstoquesForn01: TIntegerField
      FieldName = 'Forn01'
    end
    object EstoquesForn02: TIntegerField
      FieldName = 'Forn02'
    end
    object EstoquesForn03: TIntegerField
      FieldName = 'Forn03'
    end
    object EstoquesVMAnt: TCurrencyField
      FieldName = 'VMAnt'
    end
    object EstoquesQtdAnt: TBCDField
      FieldName = 'QtdAnt'
      Precision = 32
      Size = 3
    end
    object EstoquesE_Compra: TBCDField
      FieldName = 'E_Compra'
      Precision = 32
      Size = 3
    end
    object EstoquesE_Produc: TBCDField
      FieldName = 'E_Produc'
      Precision = 32
      Size = 3
    end
    object EstoquesE_Devol: TBCDField
      FieldName = 'E_Devol'
      Precision = 32
      Size = 3
    end
    object EstoquesE_Outras: TBCDField
      FieldName = 'E_Outras'
      Precision = 32
      Size = 3
    end
    object EstoquesE_Data: TDateField
      FieldName = 'E_Data'
    end
    object EstoquesS_Venda: TBCDField
      FieldName = 'S_Venda'
      Precision = 32
      Size = 3
    end
    object EstoquesS_Produc: TBCDField
      FieldName = 'S_Produc'
      Precision = 32
      Size = 3
    end
    object EstoquesS_Devol: TBCDField
      FieldName = 'S_Devol'
      Precision = 32
      Size = 3
    end
    object EstoquesS_Outras: TBCDField
      FieldName = 'S_Outras'
      Precision = 32
      Size = 3
    end
    object EstoquesS_Data: TDateField
      FieldName = 'S_Data'
    end
    object EstoquesQtdAtu: TBCDField
      FieldName = 'QtdAtu'
      Precision = 32
      Size = 3
    end
    object EstoquesVMAtu: TCurrencyField
      FieldName = 'VMAtu'
    end
    object EstoquesNPer: TIntegerField
      FieldName = 'NPer'
    end
    object EstoquesE_Acum: TBCDField
      FieldName = 'E_Acum'
      Precision = 32
      Size = 3
    end
    object EstoquesS_Acum: TBCDField
      FieldName = 'S_Acum'
      Precision = 32
      Size = 3
    end
    object EstoquesABCFin: TStringField
      FieldName = 'ABCFin'
      Size = 1
    end
    object EstoquesABCFCalc: TIntegerField
      FieldName = 'ABCFCalc'
    end
    object EstoquesABCQtd: TStringField
      FieldName = 'ABCQtd'
      Size = 1
    end
    object EstoquesABCQCalc: TIntegerField
      FieldName = 'ABCQCalc'
    end
    object EstoquesDDRep: TSmallintField
      FieldName = 'DDRep'
    end
    object EstoquesMin: TBCDField
      FieldName = 'Min'
      Precision = 32
      Size = 3
    end
    object EstoquesMax: TBCDField
      FieldName = 'Max'
      Precision = 32
      Size = 3
    end
    object EstoquesSTrib: TSmallintField
      FieldName = 'STrib'
    end
    object EstoquesSTribFE: TSmallintField
      FieldName = 'STribFE'
    end
    object EstoquesCFisc: TStringField
      FieldName = 'CFisc'
      Size = 2
    end
    object EstoquesLP01: TBCDField
      FieldName = 'LP01'
      Precision = 32
      Size = 3
    end
    object EstoquesLP02: TBCDField
      FieldName = 'LP02'
      Precision = 32
      Size = 3
    end
    object EstoquesLP03: TBCDField
      FieldName = 'LP03'
      Precision = 32
      Size = 3
    end
    object EstoquesLP04: TBCDField
      FieldName = 'LP04'
      Precision = 32
      Size = 3
    end
    object EstoquesLP05: TBCDField
      FieldName = 'LP05'
      Precision = 32
      Size = 3
    end
    object EstoquesLP06: TBCDField
      FieldName = 'LP06'
      Precision = 32
      Size = 3
    end
    object EstoquesEmbalag: TStringField
      FieldName = 'Embalag'
      Size = 15
    end
    object EstoquesEmbalQtd: TIntegerField
      FieldName = 'EmbalQtd'
    end
    object EstoquesAliqICM: TBCDField
      FieldName = 'AliqICM'
      Precision = 32
      Size = 2
    end
    object EstoquesAliqICMFE: TBCDField
      FieldName = 'AliqICMFE'
      Precision = 32
      Size = 2
    end
    object EstoquesEtiqsLst: TIntegerField
      FieldName = 'EtiqsLst'
    end
    object EstoquesCusto: TCurrencyField
      FieldName = 'Custo'
    end
    object EstoquesQtdCusto: TBCDField
      FieldName = 'QtdCusto'
      Precision = 32
      Size = 3
    end
    object EstoquesDtCusto: TDateField
      FieldName = 'DtCusto'
    end
    object EstoquesLPSugest: TBCDField
      FieldName = 'LPSugest'
      Precision = 32
      Size = 3
    end
    object EstoquesCFOP: TSmallintField
      FieldName = 'CFOP'
    end
    object EstoquesCFOPFE: TSmallintField
      FieldName = 'CFOPFE'
    end
    object EstoquesMarca: TSmallintField
      FieldName = 'Marca'
    end
    object EstoquesLPImpres: TBooleanField
      FieldName = 'LPImpres'
    end
    object EstoquesSTEst: TBCDField
      FieldName = 'STEst'
      Precision = 32
      Size = 2
    end
    object EstoquesSTFEst: TBCDField
      FieldName = 'STFEst'
      Precision = 32
      Size = 2
    end
    object EstoquesCSOSN: TSmallintField
      FieldName = 'CSOSN'
    end
    object EstoquesCSOSN_FE: TSmallintField
      FieldName = 'CSOSN_FE'
    end
    object EstoquesPrd_EAN: TStringField
      FieldName = 'Prd_EAN'
      Size = 14
    end
    object EstoquesPrd_ExTIPI: TStringField
      FieldName = 'Prd_ExTIPI'
      Size = 3
    end
    object EstoquesPrd_Genero: TStringField
      FieldName = 'Prd_Genero'
      Size = 4
    end
    object EstoquesICM_ModBC: TSmallintField
      FieldName = 'ICM_ModBC'
    end
    object EstoquesICM_PRedBC: TBCDField
      FieldName = 'ICM_PRedBC'
      Precision = 32
      Size = 2
    end
    object EstoquesICM_ModBCST: TSmallintField
      FieldName = 'ICM_ModBCST'
    end
    object EstoquesICM_PMVAST: TBCDField
      FieldName = 'ICM_PMVAST'
      Precision = 32
      Size = 2
    end
    object EstoquesICM_PRedBCST: TBCDField
      FieldName = 'ICM_PRedBCST'
      Precision = 32
      Size = 2
    end
    object EstoquesIPI: TBooleanField
      FieldName = 'IPI'
    end
    object EstoquesIPI_Classe: TStringField
      FieldName = 'IPI_Classe'
      Size = 5
    end
    object EstoquesIPI_CodEnquadr: TStringField
      FieldName = 'IPI_CodEnquadr'
      Size = 3
    end
    object EstoquesIPI_Trib: TBooleanField
      FieldName = 'IPI_Trib'
    end
    object EstoquesIPI_CST_E: TSmallintField
      FieldName = 'IPI_CST_E'
    end
    object EstoquesIPI_CST_S: TSmallintField
      FieldName = 'IPI_CST_S'
    end
    object EstoquesIPI_TribModo: TStringField
      FieldName = 'IPI_TribModo'
      Size = 1
    end
    object EstoquesIPI_AliqUnit: TBCDField
      FieldName = 'IPI_AliqUnit'
      Precision = 32
    end
    object EstoquesPIS: TBooleanField
      FieldName = 'PIS'
    end
    object EstoquesPIS_CST: TSmallintField
      FieldName = 'PIS_CST'
    end
    object EstoquesPIS_Aliq: TBCDField
      FieldName = 'PIS_Aliq'
      Precision = 32
      Size = 2
    end
    object EstoquesPIS_AliqUnit: TBCDField
      FieldName = 'PIS_AliqUnit'
      Precision = 32
    end
    object EstoquesCOF: TBooleanField
      FieldName = 'COF'
    end
    object EstoquesCOF_CST: TSmallintField
      FieldName = 'COF_CST'
    end
    object EstoquesCOF_Aliq: TBCDField
      FieldName = 'COF_Aliq'
      Precision = 32
      Size = 2
    end
    object EstoquesCOF_AliqUnit: TBCDField
      FieldName = 'COF_AliqUnit'
      Precision = 32
    end
    object EstoquesTribut_PRIOR: TBooleanField
      FieldName = 'Tribut_PRIOR'
    end
    object EstoquesEmbalPeso: TBCDField
      FieldName = 'EmbalPeso'
      Precision = 32
      Size = 3
    end
    object EstoquesPesoUnit: TBCDField
      FieldName = 'PesoUnit'
      Precision = 32
      Size = 3
    end
    object EstoquesNCM: TStringField
      FieldName = 'NCM'
      Size = 8
    end
    object EstoquesGrupoMO: TSmallintField
      FieldName = 'GrupoMO'
    end
    object EstoquesCodFCI: TSmallintField
      FieldName = 'CodFCI'
    end
    object EstoquesLocalizacao: TStringField
      FieldName = 'Localizacao'
      Size = 18
    end
    object EstoquesCEST_Seg: TStringField
      FieldName = 'CEST_Seg'
      Size = 2
    end
    object EstoquesCEST_Item: TStringField
      FieldName = 'CEST_Item'
      Size = 3
    end
    object EstoquesCEST_Esp: TStringField
      FieldName = 'CEST_Esp'
      Size = 2
    end
  end
end
