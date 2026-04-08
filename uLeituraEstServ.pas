unit uLeituraEstServ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables;

type
  TFLeEstServ = class(TForm)
    Estoques: TTable;
    EstoquesItem: TStringField;
    EstoquesDescr: TStringField;
    EstoquesDescrCmpl: TMemoField;
    EstoquesUnid: TStringField;
    EstoquesRefer: TStringField;
    EstoquesGrupo: TSmallintField;
    EstoquesImport: TSmallintField;
    EstoquesQbLote: TBooleanField;
    EstoquesDtCadas: TDateField;
    EstoquesForn01: TIntegerField;
    EstoquesForn02: TIntegerField;
    EstoquesForn03: TIntegerField;
    EstoquesVMAnt: TCurrencyField;
    EstoquesQtdAnt: TBCDField;
    EstoquesE_Compra: TBCDField;
    EstoquesE_Produc: TBCDField;
    EstoquesE_Devol: TBCDField;
    EstoquesE_Outras: TBCDField;
    EstoquesE_Data: TDateField;
    EstoquesS_Venda: TBCDField;
    EstoquesS_Produc: TBCDField;
    EstoquesS_Devol: TBCDField;
    EstoquesS_Outras: TBCDField;
    EstoquesS_Data: TDateField;
    EstoquesQtdAtu: TBCDField;
    EstoquesVMAtu: TCurrencyField;
    EstoquesNPer: TIntegerField;
    EstoquesE_Acum: TBCDField;
    EstoquesS_Acum: TBCDField;
    EstoquesABCFin: TStringField;
    EstoquesABCFCalc: TIntegerField;
    EstoquesABCQtd: TStringField;
    EstoquesABCQCalc: TIntegerField;
    EstoquesDDRep: TSmallintField;
    EstoquesMin: TBCDField;
    EstoquesMax: TBCDField;
    EstoquesSTrib: TSmallintField;
    EstoquesSTribFE: TSmallintField;
    EstoquesCFisc: TStringField;
    EstoquesLP01: TBCDField;
    EstoquesLP02: TBCDField;
    EstoquesLP03: TBCDField;
    EstoquesLP04: TBCDField;
    EstoquesLP05: TBCDField;
    EstoquesLP06: TBCDField;
    EstoquesEmbalag: TStringField;
    EstoquesEmbalQtd: TIntegerField;
    EstoquesAliqICM: TBCDField;
    EstoquesAliqICMFE: TBCDField;
    EstoquesEtiqsLst: TIntegerField;
    EstoquesCusto: TCurrencyField;
    EstoquesQtdCusto: TBCDField;
    EstoquesDtCusto: TDateField;
    EstoquesLPSugest: TBCDField;
    EstoquesCFOP: TSmallintField;
    EstoquesCFOPFE: TSmallintField;
    EstoquesMarca: TSmallintField;
    EstoquesLPImpres: TBooleanField;
    EstoquesSTEst: TBCDField;
    EstoquesSTFEst: TBCDField;
    EstoquesCSOSN: TSmallintField;
    EstoquesCSOSN_FE: TSmallintField;
    EstoquesPrd_EAN: TStringField;
    EstoquesPrd_ExTIPI: TStringField;
    EstoquesPrd_Genero: TStringField;
    EstoquesICM_ModBC: TSmallintField;
    EstoquesICM_PRedBC: TBCDField;
    EstoquesICM_ModBCST: TSmallintField;
    EstoquesICM_PMVAST: TBCDField;
    EstoquesICM_PRedBCST: TBCDField;
    EstoquesIPI: TBooleanField;
    EstoquesIPI_Classe: TStringField;
    EstoquesIPI_CodEnquadr: TStringField;
    EstoquesIPI_Trib: TBooleanField;
    EstoquesIPI_CST_E: TSmallintField;
    EstoquesIPI_CST_S: TSmallintField;
    EstoquesIPI_TribModo: TStringField;
    EstoquesIPI_AliqUnit: TBCDField;
    EstoquesPIS: TBooleanField;
    EstoquesPIS_CST: TSmallintField;
    EstoquesPIS_Aliq: TBCDField;
    EstoquesPIS_AliqUnit: TBCDField;
    EstoquesCOF: TBooleanField;
    EstoquesCOF_CST: TSmallintField;
    EstoquesCOF_Aliq: TBCDField;
    EstoquesCOF_AliqUnit: TBCDField;
    EstoquesTribut_PRIOR: TBooleanField;
    EstoquesEmbalPeso: TBCDField;
    EstoquesPesoUnit: TBCDField;
    EstoquesNCM: TStringField;
    EstoquesGrupoMO: TSmallintField;
    EstoquesCodFCI: TSmallintField;
    EstoquesLocalizacao: TStringField;
    EstoquesCEST_Seg: TStringField;
    EstoquesCEST_Item: TStringField;
    EstoquesCEST_Esp: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TRegEstoq = class
  private
    FE_Acum: TBCDField;
    FQtdCusto: TBCDField;
    FICM_PRedBCST: TBCDField;
    FSTEst: TBCDField;
    FLPSugest: TBCDField;
    FPIS_AliqUnit: TBCDField;
    FLP01: TBCDField;
    FMax: TBCDField;
    FLP06: TBCDField;
    FPIS_Aliq: TBCDField;
    FPesoUnit: TBCDField;
    FLP05: TBCDField;
    FS_Acum: TBCDField;
    FCOF_AliqUnit: TBCDField;
    FCOF_Aliq: TBCDField;
    FAliqICMFE: TBCDField;
    FS_Produc: TBCDField;
    FE_Devol: TBCDField;
    FLP04: TBCDField;
    FSTFEst: TBCDField;
    FICM_PRedBC: TBCDField;
    FS_Devol: TBCDField;
    FEmbalPeso: TBCDField;
    FE_Outras: TBCDField;
    FICM_PMVAST: TBCDField;
    FIPI_AliqUnit: TBCDField;
    FQtdAtu: TBCDField;
    FE_Produc: TBCDField;
    FMin: TBCDField;
    FAliqICM: TBCDField;
    FLP02: TBCDField;
    FS_Outras: TBCDField;
    FE_Compra: TBCDField;
    FS_Venda: TBCDField;
    FLP03: TBCDField;
    FQtdAnt: TBCDField;
    FCOF: TBooleanField;
    FPIS: TBooleanField;
    FQbLote: TBooleanField;
    FIPI: TBooleanField;
    FTribut_PRIOR: TBooleanField;
    FIPI_Trib: TBooleanField;
    FLPImpres: TBooleanField;
    FVMAnt: TCurrencyField;
    FVMAtu: TCurrencyField;
    FCusto: TCurrencyField;
    FDtCusto: TDateField;
    FDtCadas: TDateField;
    FE_Data: TDateField;
    FS_Data: TDateField;
    FForn01: TIntegerField;
    FEmbalQtd: TIntegerField;
    FNPer: TIntegerField;
    FForn03: TIntegerField;
    FABCFCalc: TIntegerField;
    FEtiqsLst: TIntegerField;
    FABCQCalc: TIntegerField;
    FForn02: TIntegerField;
    FDescrCmpl: TMemoField;
    FIPI_CST_E: TSmallintField;
    FImport: TSmallintField;
    FPIS_CST: TSmallintField;
    FCFOP: TSmallintField;
    FCSOSN_FE: TSmallintField;
    FCodFCI: TSmallintField;
    FCFOPFE: TSmallintField;
    FICM_ModBC: TSmallintField;
    FCSOSN: TSmallintField;
    FIPI_CST_S: TSmallintField;
    FICM_ModBCST: TSmallintField;
    FSTribFE: TSmallintField;
    FCOF_CST: TSmallintField;
    FGrupoMO: TSmallintField;
    FSTrib: TSmallintField;
    FDDRep: TSmallintField;
    FGrupo: TSmallintField;
    FMarca: TSmallintField;
    FCFisc: TStringField;
    FIPI_Classe: TStringField;
    FCEST_Seg: TStringField;
    FRefer: TStringField;
    FUnid: TStringField;
    FABCQtd: TStringField;
    FPrd_EAN: TStringField;
    FIPI_TribModo: TStringField;
    FCEST_Esp: TStringField;
    FIPI_CodEnquadr: TStringField;
    FPrd_Genero: TStringField;
    FItem: TStringField;
    FABCFin: TStringField;
    FDescr: TStringField;
    FCEST_Item: TStringField;
    FEmbalag: TStringField;
    FPrd_ExTIPI: TStringField;
    FLocalizacao: TStringField;
    FNCM: TStringField;
  protected
  public
    Property Item: TStringField read FItem write FItem;
    Property Descr: TStringField read FDescr write FDescr;
    Property DescrCmpl: TMemoField read FDescrCmpl write FDescrCmpl;
    Property Unid: TStringField read FUnid write FUnid;
    Property Refer: TStringField read FRefer write FRefer;
    Property Grupo: TSmallintField read FGrupo write FGrupo;
    Property Import: TSmallintField read FImport write FImport;
    Property QbLote: TBooleanField read FQbLote write FQbLote;
    Property DtCadas: TDateField read FDtCadas write FDtCadas;
    Property Forn01: TIntegerField read FForn01 write FForn01;
    Property Forn02: TIntegerField read FForn02 write FForn02;
    Property Forn03: TIntegerField read FForn03 write FForn03;
    Property VMAnt: TCurrencyField read FVMAnt write FVMAnt;
    Property QtdAnt: TBCDField read FQtdAnt write FQtdAnt;
    Property E_Compra: TBCDField read FE_Compra write FE_Compra;
    Property E_Produc: TBCDField read FE_Produc write FE_Produc;
    Property E_Devol: TBCDField read FE_Devol write FE_Devol;
    Property E_Outras: TBCDField read FE_Outras write FE_Outras;
    Property E_Data: TDateField read FE_Data write FE_Data;
    Property S_Venda: TBCDField read FS_Venda write FS_Venda;
    Property S_Produc: TBCDField read FS_Produc write FS_Produc;
    Property S_Devol: TBCDField read FS_Devol write FS_Devol;
    Property S_Outras: TBCDField read FS_Outras write FS_Outras;
    Property S_Data: TDateField read FS_Data write FS_Data;
    Property QtdAtu: TBCDField read FQtdAtu write FQtdAtu;
    Property VMAtu: TCurrencyField read FVMAtu write FVMAtu;
    Property NPer: TIntegerField read FNPer write FNPer;
    Property E_Acum: TBCDField read FE_Acum write FE_Acum;
    Property S_Acum: TBCDField read FS_Acum write FS_Acum;
    Property ABCFin: TStringField read FABCFin write FABCFin;
    Property ABCFCalc: TIntegerField read FABCFCalc write FABCFCalc;
    Property ABCQtd: TStringField read FABCQtd write FABCQtd;
    Property ABCQCalc: TIntegerField read FABCQCalc write FABCQCalc;
    Property DDRep: TSmallintField read FDDRep write FDDRep;
    Property Min: TBCDField read FMin write FMin;
    Property Max: TBCDField read FMax write FMax;
    Property STrib: TSmallintField read FSTrib write FSTrib;
    Property STribFE: TSmallintField read FSTribFE write FSTribFE;
    Property CFisc: TStringField read FCFisc write FCFisc;
    Property LP01: TBCDField read FLP01 write FLP01;
    Property LP02: TBCDField read FLP02 write FLP02;
    Property LP03: TBCDField read FLP03 write FLP03;
    Property LP04: TBCDField read FLP04 write FLP04;
    Property LP05: TBCDField read FLP05 write FLP05;
    Property LP06: TBCDField read FLP06 write FLP06;
    Property Embalag: TStringField read FEmbalag write FEmbalag;
    Property EmbalQtd: TIntegerField read FEmbalQtd write FEmbalQtd;
    Property AliqICM: TBCDField read FAliqICM write FAliqICM;
    Property AliqICMFE: TBCDField read FAliqICMFE write FAliqICMFE;
    Property EtiqsLst: TIntegerField read FEtiqsLst write FEtiqsLst;
    Property Custo: TCurrencyField read FCusto write FCusto;
    Property QtdCusto: TBCDField read FQtdCusto write FQtdCusto;
    Property DtCusto: TDateField read FDtCusto write FDtCusto;
    Property LPSugest: TBCDField read FLPSugest write FLPSugest;
    Property CFOP: TSmallintField read FCFOP write FCFOP;
    Property CFOPFE: TSmallintField read FCFOPFE write FCFOPFE;
    Property Marca: TSmallintField read FMarca write FMarca;
    Property LPImpres: TBooleanField read FLPImpres write FLPImpres;
    Property STEst: TBCDField read FSTEst write FSTEst;
    Property STFEst: TBCDField read FSTFEst write FSTFEst;
    Property CSOSN: TSmallintField read FCSOSN write FCSOSN;
    Property CSOSN_FE: TSmallintField read FCSOSN_FE write FCSOSN_FE;
    Property Prd_EAN: TStringField read FPrd_EAN write FPrd_EAN;
    Property Prd_ExTIPI: TStringField read FPrd_ExTIPI write FPrd_ExTIPI;
    Property Prd_Genero: TStringField read FPrd_Genero write FPrd_Genero;
    Property ICM_ModBC: TSmallintField read FICM_ModBC write FICM_ModBC;
    Property ICM_PRedBC: TBCDField read FICM_PRedBC write FICM_PRedBC;
    Property ICM_ModBCST: TSmallintField read FICM_ModBCST write FICM_ModBCST;
    Property ICM_PMVAST: TBCDField read FICM_PMVAST write FICM_PMVAST;
    Property ICM_PRedBCST: TBCDField read FICM_PRedBCST write FICM_PRedBCST;
    Property IPI: TBooleanField read FIPI write FIPI;
    Property IPI_Classe: TStringField read FIPI_Classe write FIPI_Classe;
    Property IPI_CodEnquadr: TStringField read FIPI_CodEnquadr write FIPI_CodEnquadr;
    Property IPI_Trib: TBooleanField read FIPI_Trib write FIPI_Trib;
    Property IPI_CST_E: TSmallintField read FIPI_CST_E write FIPI_CST_E;
    Property IPI_CST_S: TSmallintField read FIPI_CST_S write FIPI_CST_S;
    Property IPI_TribModo: TStringField read FIPI_TribModo write FIPI_TribModo;
    Property IPI_AliqUnit: TBCDField read FIPI_AliqUnit write FIPI_AliqUnit;
    Property PIS: TBooleanField read FPIS write FPIS;
    Property PIS_CST: TSmallintField read FPIS_CST write FPIS_CST;
    Property PIS_Aliq: TBCDField read FPIS_Aliq write FPIS_Aliq;
    Property PIS_AliqUnit: TBCDField read FPIS_AliqUnit write FPIS_AliqUnit;
    Property COF: TBooleanField read FCOF write FCOF;
    Property COF_CST: TSmallintField read FCOF_CST write FCOF_CST;
    Property COF_Aliq: TBCDField read FCOF_Aliq write FCOF_Aliq;
    Property COF_AliqUnit: TBCDField read FCOF_AliqUnit write FCOF_AliqUnit;
    Property Tribut_PRIOR: TBooleanField read FTribut_PRIOR write FTribut_PRIOR;
    Property EmbalPeso: TBCDField read FEmbalPeso write FEmbalPeso;
    Property PesoUnit: TBCDField read FPesoUnit write FPesoUnit;
    Property NCM: TStringField read FNCM write FNCM;
    Property GrupoMO: TSmallintField read FGrupoMO write FGrupoMO;
    Property CodFCI: TSmallintField read FCodFCI write FCodFCI;
    Property Localizacao: TStringField read FLocalizacao write FLocalizacao;
    Property CEST_Seg: TStringField read FCEST_Seg write FCEST_Seg;
    Property CEST_Item: TStringField read FCEST_Item write FCEST_Item;
    Property CEST_Esp: TStringField read FCEST_Esp write FCEST_Esp;

  published
  end;


  Function LeEstoque(pKey:String): TRegEstoq;

var
  FLeEstServ: TFLeEstServ;

implementation

uses uGenericas;


{$R *.dfm}



Function LeEstoque(pKey:String): TRegEstoq;
var lIndex: array[1..2] of String;
    i: Integer;
begin
  if FGen.wInicial.ECadas = 'C'
  then begin
    lIndex[1] := '';
    lIndex[2] := 'Referencia';
  end
  else begin
    lIndex[1] := 'Referencia';
    lIndex[2] := '';
  end;
  FLeEstServ.Estoques.Active := True;
  //Result.Item := '***';
  //Result.Refer := '***';
  for i := 1 to 2
  do begin
    FLeEstServ.Estoques.IndexName := lIndex[1];
    if FLeEstServ.Estoques.FindKey([pKey])
    then begin
      Result.Item := FLeEstServ.EstoquesItem;
      Result.Descr := FLeEstServ.EstoquesDescr;

      Break;
    end;
  end;





end;


end.
