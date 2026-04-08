unit uIniGeral;

interface

uses
  Windows, SysUtils, DB, Classes, DBTables, Forms, IniFiles, Dialogs, DateUtils,
  Graphics,
  Controls, StdCtrls;

Procedure Gera_IniEstacao(pmtNomeArq: String);
Procedure Gera_IniGeral(pmtNomeArq: String);
Procedure Inicializacao_Simples(pSalvaForm: Boolean = False);
Procedure Inicializacao(pModulos: String = ''; pIniEstacao: String = '');
Procedure SalvaParametrosIni(pLocal, pGeral: Boolean; pModulos: String = '';
  pArqIniEstacao: String = '');
Function ExecutaAbortaProcesso(pExeName: String; var pmtUser: String): Boolean;
Procedure SalvaUsuarioProcesso(pExeName: String; pmtUser: String);
Procedure GravaSerial(pmtNomeArq: String; pmtSerial: String);

type
  TInicializa = class
  private
    FDesconecta: Boolean;
    FSysUserStat: Integer;
    FSenha: String;
    FCaminho: String;
    FPathRelatorios: String;
    FParametros: String;
    FDriveRemoto: String;
    FSistema: String;
    FSysUser: String;
    FUsuario: String;
    FPathLocal: String;
    FSysComputerName: String;
    FEmpresa: String;
    FDatabaseName: String;
    FCadasLogFile: String;
    FDatabasePath: String;
    FLiteFull: String;
    FAtualizaCadastro: Boolean;
    FCodEF: Integer;
    FCidade: String;
    FEstado: String;
    FECadas: String;
    FEApres: String;
    FEstoqLogFile: String;
    FEObRefer: Boolean;
    FEObGrupo: Boolean;
    FEDupRefer: Boolean;
    FEDupDescr: Boolean;
    FEntr_EF: Integer;
    FEntr_ExibeCalc: Boolean;
    FEntr_AtlzCP: Boolean;
    FEntr_CPDoc: Integer;
    FesCofins: Boolean;
    FesPIS: Boolean;
    FesIPITrib: Boolean;
    FesIPI: Boolean;
    FesModoBCST: Integer;
    FesIPIEnt: Integer;
    FesModoBC: Integer;
    FesIPISai: Integer;
    FesPISST: Integer;
    FesCofinsST: Integer;
    FesPISVlUnit: Real;
    FesPISAliq: Real;
    FesRedBC: Real;
    FesCofinsAliq: Real;
    FesMVA: Real;
    FesRedBCST: Real;
    FesCofinsVlUnit: Real;
    FesIPIClasse: String;
    FesNCM: String;
    FesIPIEnq: String;
    FesIPIModo: String;
    FesGenero: String;
    FesExTIPI: String;
    FPreviewOSLoja: Boolean;
    FLPP: Integer;
    FTecnicos: Integer;
    FLObs04: String;
    FLObs01: String;
    FOSLogFile: String;
    FLObs10: String;
    FLObs08: String;
    FLObs06: String;
    FLObs09: String;
    FEmissao: Integer;
    FLCab2: String;
    FLObs07: String;
    FOSCondPagto: String;
    FLObs05: String;
    FLCab1: String;
    FLObs02: String;
    FLCab3: String;
    FLObs03: String;
    FCFOP_VendaST: Integer;
    FCFOP_Servico: Integer;
    FCFOP_Venda: Integer;
    FCFOP_Servico_FE: Integer;
    FCFOP_Venda_FE: Integer;
    FCFOP_VendaST_FE: Integer;
    FRegEspICMS: Boolean;
    FListaPreco: Integer;
    FAliqISS: Real;
    FAlTTServic: Real;
    FAlTTMercad: Real;
    FAliqICMS: Real;
    FAliqPIS: Real;
    FAliqCOFINS: Real;
    FCodRegTrib: String;
    FPeriodoCC: Integer;
    FEmpregLogFile: String;
    FTranspLogFile: String;
    FDetRubricas: Boolean;
    FPcDesc: Real;
    FPcJuros: Real;
    FCobranca: Integer;
    FTpJuros: Integer;
    FDocReceb: Integer;
    FDocPagar: Integer;
    FPagRecLogFile: String;
    FPcMulta: Real;
    FDuplIEST: Boolean;
    FDuplCNPJ: Boolean;
    FDiasFuturos: Integer;
    FNroDocObrigatorio: Boolean;
    FDtCalcSaldoFluxo: TDateTime;
    FPathAuxiliar: String;
    FELPreco: Boolean;
    FSenhaExclus: String;
    FEntr_Detal: Boolean;
    FLoc_IdGrupo: String;
    FLoc_Pr3: String;
    FLoc_Pr1: String;
    FLoc_Pr4: String;
    FLoc_Pr5: String;
    FLoc_Pr2: String;
    FLoc_IdOperacao: String;
    FLoc_PathContratos: String;
    FLoc_Margem: Real;
    FLoc_HrDevol: String;
    FLoc_Financeiro: Boolean;
    FEntr_CritBases: Boolean;
    FAGB_Assinala: Boolean;
    FAGB_MetrPadrao: Integer;
    FAGB_DispMinimo: Integer;
    FAGB_LogoPrint: String;
    FAGB_LogoTela: String;
    FAGB_ImgFundo: String;
    FAGB_DdProd: String;
    FAGB_DdLocais: String;
    FAGB_Quadro: String;
    FAGB_GrupoEstoque: Integer;
    FOF_OSEspCliente: String;
    FOF_OSEspComss: Real;
    FOF_PrazoPadrao: Integer;
    FEntr_CalcBsIsenta: Boolean;
    FOF_PlanilhaPadrao: String;
    FEMPorta: String;
    FEMOrigem: String;
    FEMUsario: String;
    FEMHost: String;
    FEMNome: String;
    FEMSenha: String;
    FOF_Prestador: String;
    FOF_LPreco: Integer;
    FAGB_OPLegendas: Boolean;
    FAGB_DdImport: String;
    {
      FAGB_BobA: String;
      FAGB_BobC: String;
      FAGB_BobB: String;
      FAGB_BobD: String;
      FAGB_Tubete: Integer;
      FAGB_FatorCliche: Real;
      FAGB_Margem: Real;
    }
    FPathExec: String;
    FServClie: String;
    FSalvaForm: Boolean;
    FEntr_AdotaPreco: Boolean;
    FFonteTam: Integer;
    FFonteNome: String;
    FLDebug: Boolean;
    FEP_Ins1: Integer;
    FEP_Ins2: Integer;
    FEP_Ins3: Integer;
    FEP_Ins4: Integer;
    FEP_Ins5: Integer;
    FEP_Valorizacao: Integer;
    FEnvNFE_PathDestino: String;
    FEnvNFE_Arquivos: String;
    FEnvNFE_Compressao: String;
    FEnvNFE_Envio: String;
    FEnvNFE_Destinatario: String;
    FPathEstacaoTrabalho: String;
    FEP_DiasCalculo: Integer;
    FEP_DecVlr: Integer;
    FEP_DecQtd: Integer;
    FEntr_DocEntr: Integer;
    FPathRemessas: String;
    FOpES_DuplSrv: Boolean;
    FOpES_DuplMat: Boolean;
    FOpES_Vendedor: Boolean;
    FOpES_LctPrior: String;
    FOpES_DescrCompl: Boolean;
    FOpES_DescItem: Boolean;
    FOpES_Negativo: Boolean;
    FOpES_GrupoBloq7: Integer;
    FOpES_GrupoBloq1: Integer;
    FOpES_GrupoBloq9: Integer;
    FOpES_GrupoBloq2: Integer;
    FOpES_GrupoBloq3: Integer;
    FOpES_GrupoBloq6: Integer;
    FOpES_GrupoBloq0: Integer;
    FOpES_GrupoBloq5: Integer;
    FOpES_GrupoBloq8: Integer;
    FOpES_GrupoBloq4: Integer;
    FOpES_PgmOS: String;
    FImagemFundo: String;
    FGerNotasFiscais: String;
    FGerOrdemInicial: Integer;
    FFFood_LstObserv: Boolean;
    FFFood_DescAutom: Boolean;
    FFFood_UsaFluxos: Boolean;
    FFFood_Configura: Boolean;
    FFFood_Cadastro: Boolean;
    FFFood_LstSenha: Boolean;
    FFFood_Desconto: Boolean;
    FFFood_IniciaTurno: Boolean;
    FFFood_NomeObrig: Boolean;
    FFFood_ECFS_TimeOut: Integer;
    FFFood_Imprime_Int: Integer;
    FFFood_ECFS_Foco: Integer;
    FFFood_CaixaNr: String;
    FFFood_LPPadrao: Integer;
    FFFood_Imprime_Cli: Integer;
    FFFood_ECFS_VlRec: Integer;
    FFFood_ECFS_Valores: Integer;
    FFFood_Emite_CF: Integer;
    FFFood_TamSenha: Integer;
    FFFood_Aliq07: String;
    FFFood_Aliq17: String;
    FFFood_ECFS_Nome: String;
    FFFood_Aliq12: String;
    FFFood_Cad_Fecha: String;
    FFFood_ECFS_CodProd: String;
    FFFood_SenConfig: String;
    FFFood_Aliq04: String;
    FFFood_Cad_Relac: String;
    FFFood_Cad_EmPag: String;
    FFFood_Modulos: String;
    FFFood_Cad_Aglut: String;
    FFFood_Aliq25: String;
    FFFood_Aliq18: String;
    FFFood_ECFS_Descr: String;
    FFFood_Cad_Obsrv: String;
    FNrEstacao: String;
    FFFood_Cab04: String;
    FFFood_LogoPrint: String;
    FFFood_Cab03: String;
    FFFood_Cab02: String;
    FFFood_Cab01: String;
    FFFood_AvFinal: Integer;
    FFFood_Preview: Boolean;
    FFFood_LogoCozin: String;
    FFFood_PrintDialog: Boolean;
    FBalcaoPgmOS1: String;
    FOpES_LCab1: String;
    FOpES_LCab3: String;
    FOpES_LCab2: String;
    FOpES_LCab4: String;
    FOpES_PedDialog: Boolean;
    FOpES_PedPreview: Boolean;
    FOpES_LProm: String;
    FOpES_PedLogo: String;
    FOpES_PedEntreVias: Boolean;
    FOpES_NomeCliente: Boolean;
    FEntr_PathLeXML: String;
    FCadClass3: String;
    FCadClass2: String;
    FCadClass1: String;
    FFFood_NCM: String;
    FFFood_CFOP: String;
    FUsaPlanoContas: Boolean;
    FPathRetornos: String;
    FPathSalvaRetornos: String;
    FRetProcesso: Integer;
    FSerial: String;
    FImpressoraPedidos: String;
    FViasPedidos: Integer;
    FPreviewPedidos: Boolean;
    FCxLocal: Boolean;
    FCxLocalNro: Integer;
    FCaixaDoc: Integer;
    FCxLocalPreview: Boolean;
    FCxLocalImpressora: String;
    FCxLocalTpImpress: String;
    FCxLocalEF: Integer;
    FFFood_NDAvanco: Integer;
    FRefreshTimer: Integer;
    FEmitePedidos: Boolean;
    FCxPathCaixa: String;
    FEMEnvio: string;
    FOpES_MC5464: Boolean;
    FGerNotasBenef: String;
    FOpES_TimeOut: Integer;
    FOpES_DtHrSaida: Boolean;
    FOpES_HrVeraoFin: TDateTime;
    FOpES_HrVeraoIni: TDateTime;
    FGerAlternaDados: Boolean;
    FGerReplicaDados: Boolean;
    FOpES_Crediario: Boolean;
    FOpES_VolDefault: Integer;
    FOpES_VolMarca: String;
    FOpES_VolEspecie: String;
    FOpES_SomaQtd: Boolean;
    FOpES_FatorPB: Real;
    FOpES_AVFluxo: Boolean;
    FOpES_RubrAVFluxo: Integer;
    FOpES_Frete: Integer;
    FEMAssunto: String;
    FEMNomeDest: String;
    FEMEMailDest: String;
    FGerEnvioXMLDanfe: String;
    FOpES_SenhaCancel: String;
    FFFood_PrinterId: String;
    FLSalvaParam: Boolean;
    FCxExclusivo: Boolean;
    FOpES_ModoBCICMVenda: Integer;
    FOpES_VendaPrefer: String;
    FEDescrCase: String;
    FEDiasValidade: Integer;
    FProxyUser: string;
    FUrlNCM: String;
    FProxyPass: string;
    FProxyPort: string;
    FProxyHost: String;
    FLSuporte: Boolean;
    FGerEstRegistro: Boolean;
    FGerEstMovimentacao: Boolean;
    FGerEstCadastro: Boolean;
    FGerServicos: Boolean;
    FEntr_CPRubr: Integer;
    FLDownLoadNFe: Boolean;
    FLLeituraNFe: Boolean;
    FVisProcesso: Boolean;
    FPathAlter03: String;
    FPathAlter04: String;
    FPathAlter05: String;
    FPathAlter02: String;
    FPathAlter01: String;
    FLFluxoFinanceiro: Boolean;
    FEntr_DifEF: Boolean;
    FValorDec: Integer;
    FQuantDec: Integer;
    FOpES_RestauraNFe: Boolean;
    FOpES_NFeEmiss: String;
    FSysPath: String;
    FDiferDocumentos: Boolean;
    FOpES_PathCfgIni: String;
    FOpES_DiasLimpeza: Integer;
    FSrvCodEspec: Boolean;
    FSrvCodTam: Integer;
    FEstCodDiv: Integer;
    FEstCodTam: Integer;
    FEstDiv2Tam: Integer;
    FEstDiv1Tam: Integer;
    FEstDiv4Tam: Integer;
    FEstDiv3Tam: Integer;
    FEstDiv2Tip: String;
    FEstDiv3Tip: String;
    FEstDiv1Tip: String;
    FEstDiv4Tip: String;
    FLinPolegada: Integer;
    FBalcaoCondPagto: Boolean;
    FOpES_PedAvLin: Integer;
    FGerAtualizaData: Boolean;
    FOpES_NFeLotes: Boolean;
    FOpES_NFComplDd: Boolean;
    FCxNFServ: Boolean;
    FCxNFElet: Boolean;
    FCxPedido: Boolean;
    FCxNFCons: Boolean;
    FCxFatMens: Boolean;
    FCxNovaOper: Boolean;
    FCxExclOper: Boolean;
    FCxAltOper: Boolean;
    FCxCancOper: Boolean;
    FCxOrdServ: Boolean;
    FLExibQtdLPrecos: Boolean;
    FCxCondPagto: String;
    FSeparadorDecimal: String;
    FPcCredParc: Real;
    FPcDebito: Real;
    FPcCredAV: Real;
    FAvancoEnter: Boolean;
    FSaltaTrib: Boolean;
    FSaltaPed: Boolean;
    FPrioridadeST: Boolean;
    FLiteMax: Integer;
    FCxFazTroco: Boolean;
    FFFood_RAW: Boolean;
    FFFood_Cab3RAW: String;
    FFFood_Cab2RAW: String;
    FFFood_Cab1RAW: String;
    FFFood_Cab4RAW: String;
    FFFood_IdPedRAW: String;
    FesNVE: string;
    FesCEST: String;
    FCxExibeOrcam: Boolean;
    FCxTempoMsg: Integer;
    FCxTpOper: Integer;
    FCxOperDFe: Boolean;
    FCxPathExGeren: String;
    FCxPathExBalcao: String;
    FFFood_TotTrib: Integer;
    FFFood_DescrSTItens: String;
    FFFood_DescrItens: String;
    FFFood_DescrUnica: String;
    FFFood_CodSTItens: String;
    FFFood_CodUnica: String;
    FFFood_CodItens: String;
    FFFood_PedUsoNFe: Boolean;
    FLGridLinDestaq: Boolean;
    FCorLinDestaq: TColor;
    FFFood_VisDANFE: Boolean;
    FFFood_NFePrinter: String;
    FOpES_CalcSTVend: Boolean;
    FLeituraAuto: Boolean;
    FOF_AtzCadas: Boolean;
    FOF_OSIE_EmiteNF: Boolean;
    FOF_OSAC_EmiteNF: Boolean;
    FOF_RubSrv: Integer;
    FOF_AparAC: Integer;
    FOF_SrvIAC: Integer;
    FOF_RubSrvAC: Integer;
    FOF_RubPecAC: Integer;
    FOF_RubPec: Integer;
    FOF_OSIEImagem: String;
    FOF_OSACImagem: String;
    FOF_LPPadrao: Integer;
    FOF_RubApaAC: Integer;
    FEntr_ExProcesso: Boolean;
    FOSUtiliza: Boolean;
    FOF_Utiliza: Boolean;
    FRvCar_MC5464: Boolean;
    FRvCar_UsaFCP: Boolean;
    FRvCar_HrVerao: Boolean;
    FRvCar_DigRenavam: Integer;
    FRvCar_CFOPDevolOUF: Integer;
    FRvCar_CFOPDevolUF: Integer;
    FRvCar_ModoNFe: Integer;
    FRvCar_CFOPVendaUF: Integer;
    FRvCar_CFOPEntraOUF: Integer;
    FRvCar_CFOPEntraUF: Integer;
    FRvCar_CFOPVendaOUF: Integer;
    FRvCar_TimeOut: Integer;
    FRvCar_ImgLogo: String;
    FRvCar_Inf8: String;
    FRvCar_ImgFundo: String;
    FRvCar_ModBC: Integer;
    FRvCar_Inf0: String;
    FRvCar_ModBCST: Integer;
    FRvCar_Inf6: String;
    FRvCar_Inf7: String;
    FRvCar_VerNFe: String;
    FRvCar_PathCfg: String;
    FRvCar_Inf4: String;
    FRvCar_Inf3: String;
    FRvCar_ExeNFe: String;
    FRvCar_Inf1: String;
    FRvCar_Inf9: String;
    FRvCar_Inf2: String;
    FRvCar_Inf5: String;
    FRvCar_HVIni: TDateTime;
    FRvCar_HVFin: TDateTime;
    FRvCar_Tag1: String;
    FRvCar_Tag9: String;
    FRvCar_Tag8: String;
    FRvCar_Tag0: String;
    FRvCar_Tag3: String;
    FRvCar_Tag2: String;
    FRvCar_Tag6: String;
    FRvCar_Tag5: String;
    FRvCar_Tag4: String;
    FRvCar_Tag7: String;
    FCxDocInterno: Boolean;
    FOF_TxLinBranca: Real;
    FOF_TxArCond: Real;
    FCxTimer: Boolean;
    FCxTempoTimer: Integer;
    FEntr_PesqRefer: Boolean;
    FCxConfCtrlX: Boolean;
    FCxViasDocInt: Integer;
    FOpES_VlrQtd: Boolean;
    // FOrdemPesqEstoq: Integer;
    // FModoPesqCadas: Integer;
    FPadraoPesqAlfa: Integer;
    FDescBoletos: Boolean;
    FRemBolAutom: Boolean;
    FCsg1_AltPreco: Boolean;
    FCsg1_EstNeg: Boolean;
    FCsg1_QtdLct: Boolean;
    FCsg1_Campo: Integer;
    FCsg1_StopVTotal: Boolean;
    FCsg1_RepItem: Boolean;
    FCsg1_Consolid: Boolean;
    FIdEstacao: String;
    FCorPrtDestaq: TColor;
    FCsg1_Logo10x7: String;
    FCsg1_Empresa: Integer;
    FRecibos: Boolean;
    FRecSimples: Boolean;
    FLinPrtDestaq: Integer;
    FEstEtiquetas: Boolean;
    FEstExpCodBar: Integer;
    FEstPathWrk: String;
    FAMSemestral: Boolean;
    FCsg1_LstSitu: Boolean;
    FCsg1_TpDoc: Integer;
    FOpES_PedId: String;
    FEstProdCusto: Boolean;
    FPedidosNegrito: Boolean;
    FOF_LGMar2: Integer;
    FOF_LGGrp3: Integer;
    FOF_LGGrp4: Integer;
    FOF_LGGrp2: Integer;
    FOF_LGMar1: Integer;
    FOF_LGGrp1: Integer;
    FGerViasNFCe: Integer;
    FGerAtlzEstoques: Boolean;
    FOpES_CodClieNFe: Boolean;
    FOpES_UnQtdTrib: Boolean;
    FOpES_ExibeBoletos: Boolean;
    FDocCrediar: Integer;
    FDocCheque: Integer;
    FIntegVendOS: Boolean;
    FDtLimiteSeFaz: TDateTime;
    FFFood_ComplMesa: Boolean;
    FOF_ServEspTec: Boolean;
    FSysDtMinima: TDateTime;
    FGerBolEmpFil: Boolean;
    FTipoVenda: Boolean;
    FRvCar_ValRenavam: Boolean;
    FRvCar_CEST: String;
    FRvCar_NVE: String;
    FRvCar_cBenef: String;
    FOF_PrintTaxa: Boolean;
    FCorColumnDestaq: TColor;
    FCorHeaderDestaq: TColor;
    FEntr_AdotaCFOP: Boolean;
    FOpES_EstOS1: Boolean;
    FOpES_EstOS2: Boolean;
    FPedidoPadrao: Integer;
    FConfirmaVias: Boolean;
    FOpES_PedAvPix: Integer;
    FOpES_SenhaDesc: String;
    FCorBoxDestaq: TColor;
    FOF_OSAC_AltClie: Boolean;
    FOF_OSIE_AltClie: Boolean;
    FOF_OSACGarantia: Integer;
    FOF_OSIEGarantia: Integer;
    FOF_OSIEUltAtend: Integer;
    FOF_OSACEmail: Boolean;
    FOF_OSACCNPJ: Boolean;
    FOF_OSIECNPJ: Boolean;
    FOF_OSIEEmail: Boolean;
    FEMAnexo: String;
    FEMEnviado: Boolean;
    FEMCodClie: Integer;
    FEMNrDoc: Integer;
    FEMTpDoc: Integer;
    FEMHistorico: String;
    FEMAgendar: Boolean;
    FEMDtAgenda: TDateTime;
    FValidarIE: Integer;
    FOF_ACVend03: String;
    FOF_ACVend05: String;
    FOF_ACVend04: String;
    FOF_ACVend02: String;
    FOF_ACVend01: String;
    FOF_ACCodV01: Integer;
    FOF_ACCodV02: Integer;
    FOF_ACCodV03: Integer;
    FOF_ACCodV04: Integer;
    FOF_ACCodV05: Integer;
    FEmpFilOS1: Integer;
    FAteVenOS2: Integer;
    FEmpFilOS2: Integer;
    FAteVenOS1: Integer;
    FOF_ScanACDiv: Integer;
    FOF_ScanIEDiv: Integer;
    FOF_ScanACPath: String;
    FOF_ScanIEPath: String;
    FOF_LogOSIE: String;
    FOF_LogOSAC: String;
    FSrvCodNA: String;
    FFFood_FinBalcao: Integer;
    FFFood_IniBalcao: Integer;
    FFFood_AvExtra: Integer;
    FFFood_TicketSimples: Boolean;
    FFFood_Kiosk: Boolean;
    FFFood_PathIntegr: String;
    FFFood_Emite_CFTele: Integer;
    FFFood_KioskCoord: Boolean;
    FFFood_KioskMaxProd: Integer;
    FFFood_KioskMaxItens: Integer;
    FAteVenVendas: Integer;
    FEmpFilVendas: Integer;
    FCFOP_Uso: String;
    FFFood_Exportacao: Boolean;
    FFFood_CancPedido: Boolean;
    FSalvaAnexo: Boolean;
    FBol_DialogPrint: Boolean;
    FBol_Denom: Integer;
    FBol_Copias: Integer;
    FBol_PathPDF: String;
    FBol_Impressora: String;
    FBol_OutraDenom: String;
    FFFood_PedRelacNFe: Boolean;
    FEMailHomolog: String;
    FBol_ExcluePDF: Boolean;
    FInicioOperacao: Integer;
    FLctosOperacao: Integer;
    FExibeQtdDisp: Boolean;
    FRvCar_Encad: Integer;
    FEstMagazine: Boolean;
    FEstAssTecnica: Boolean;
    FTpDescBalcao: Integer;
    FPcCrediario: Real;
    FVlrMinDesc: Real;
    FPcMaxDesc: Real;
    FBalcaoFreteVlrAdic: Boolean;
    FUsaTabCartoes: Boolean;
    FPcCheques: Real;
    FCartMax: Integer;
    FCredMax: Integer;
    FChqMax: Integer;
    FBolMax: Integer;
    FMensCrediario: Boolean;
    FMensCredParc: Boolean;
    FMensCheques: Boolean;
    FPrazoMedio: Boolean;
    FMensParcelam: Boolean;
    FPcParcelam: Real;
    FMsgOSLoja1: String;
    FPrinterOSLoja: String;
    FMsgOSLoja2: String;
    FCxDocCobranca: Boolean;
    FCxTipoCobranca: Integer;
    FCxRecebimentos: Boolean;
    FGerBolPrinterLocal: Boolean;
    FGerBolIdPrinterLocal: String;
    FOF_OSIEMinLin: Integer;
    FOpES_PedTotTribut: Boolean;
    FMargemDireita: Integer;
    FMargemEsquerda: Integer;
    FPedidoLocal: Integer;
    FTxtConfDivida: String;
    FImprimeConfDiv: Boolean;
    FOpES_TpVendedor: Integer;
    FCadastroUnico: Boolean;
    FOpES_DirNFeNFCeDifer: Boolean;
    FFFood_ViasTele: Integer;
    FFFood_ViasBalMesa: Integer;
    FFFLocal_NFCe: Boolean;
    FFFLocal_Balcao: Boolean;
    FFFLocal_NFe: Boolean;
    FFFLocal_GerDFe: Boolean;
    FFFLocal_Tele: Boolean;
    FFFLocal_Mesas: Boolean;
    FCxDescAdic: Boolean;
    FTotalNFe: Boolean;
    FFFLocal_SecTp: Integer;
    FFFLocal_VPrinc: Integer;
    FFFLocal_VSec: Integer;
    FFFLocal_PrinterSec: String;
    FFFLocal_Printer: String;
    FGerBolPreview: Boolean;
    FOpES_Atendimentos: Boolean;
    FDiasIsencao: Integer;
    FBalcaoAtualizaCaixa: Boolean;
    FBalcaoEmiteDFeDInt: Boolean;
    FFFood_CaixaUnico: Boolean;
    FFFood_CaixaPathId: String;
    FMagazine: Boolean;
    FLiberaCred: Boolean;
    FUFIBGE: String;
    FMunIBGE: String;
    FPathEstruturas: String;
    FCreditoCC: String;
    FDebitoCC: String;
    FUtilizaCC: Boolean;
    FInfSaldoCC: Boolean;
    FCxCCorrCliente: Boolean;
    FAdotaDtAtual: Boolean;
    FCxUltimoReg: Boolean;
    FcpAliqSN: Real;
    FcpAliqLP: Real;
    FcpCFixos: Real;
    FcpMargem: Real;
    FcpTaxFin: Real;
    FOpES_ClieBalcao: Boolean;
    FUsaWhatsApp: Boolean;
    FPathWhatsApp: String;
    FNrWhatsCliente: String;
    FEMDtHrEnvio: TDateTime;
    FEMModoEnvio: String;
    FLinkSINTEGRA: String;
    FLinkSPC: String;
    FPathWAEnvio: String;
    FAlteraEmpFil: Boolean;
    FBalcaoPgmOS2: String;
    FEstMarcaEF: Integer;
    FPathArqMorto: String;
    FGerUsaDLL: Boolean;
    FBSLPreco: Boolean;
    FBSVendedor: Boolean;
    FBSEmpFil: Boolean;
    FBSSeqCompl: Boolean;
    FBSSeqDescricao: Boolean;
    FBSSeqCodProd: Boolean;
    FBSSeqUnid: Boolean;
    FBSSeqVlUnit: Boolean;
    FBSSeqBtOK: Boolean;
    FBSSeqQuant: Boolean;
    FBSInicio: Integer;
    FBSAvEnter: Boolean;
    FBSCliente: Boolean;
    FBSOpDescrCompl: Boolean;
    FBSOrcamentos: Boolean;
    FBSUtiliza: Boolean;
    FBSTimeWait: Integer;
    FCxSitOperIni: Integer;
    FBKSCliente: Boolean;
    FBKSCondPg: Boolean;
    FBKSNomeClie: Boolean;
    FBKSNFCe: Boolean;
    FMecRenavam: Boolean;
    FMecChassi: Boolean;
    FOpES_UFST: String;
    FTamPagTerm: Integer;
    FCompra_Id: String;
    FCompra_Abrev: String;
    FCompra_Menu: String;
    FCompra_QtdDec: Integer;
    FCompra_UnitDec: Integer;
    FProcRetornos: Boolean;
    FEstAltPrecos: Boolean;
    FBMagProd: Boolean;
    FBMagOper: Boolean;
    FBMagDime: Boolean;
    FBMagParm: Boolean;
    FBMagPreco: Boolean;
    FCxDocAutom: Boolean;
    FOF_OSEspCFOPDev: Integer;
    FOF_OSEspCadas: Integer;
    FOF_OSEspEmpFil: Integer;
    FLinkSeFazRS: String;
    FLinksUtiliza: Boolean;
    FDadosSeFaz: Boolean;
    FOF_OSEspTeste: Boolean;
    FDFeLogFile: String;
    FEstSubGrupo: Boolean;
    FDetPathRemessas: Integer;
    FCFOP_NCVenda: Integer;
    FCFOP_NCVendaST_FE: Integer;
    FCFOP_NCVendaST: Integer;
    FCFOP_NCVenda_FE: Integer;
    FOpES_CadasCPF: Boolean;
    FOpES_DdLiber: Integer;
    FOpES_VlrMax: Real;
    FOpES_OrcId: String;
    FEUsaRefer2: Boolean;
    FEExibUltCusto: Boolean;
    FEstValidEAN: Boolean;
    FOpES_HistDFe: Boolean;
    FCxFech: Boolean;
    FCxAten: Boolean;
    FCxLcts: Integer;
    FTxtCarnet1: String;
    FTxtCarnet2: String;
    FOpES_DistribObrigatorio: Boolean;
    FIdAtacadista: String;
    FIdDistribuidor: String;
    FOpES_MsgDifal: Boolean;
    FEstBkupPath: String;
    FEstBkupMes: Boolean;
    FTxtConfDividaBob: String;
    FTpCarneCrediar: Integer;
    FEstBarrasPrinter: String;
    FEstBarrasA4: string;
    FBKSFinaliz: Integer;
    FBKSLcts: Integer;
    FOpES_UFDifAl: String;
    FEmpFilCrediar: Integer;
    FOpES_PesqItemDestaq: Boolean;
    FGerTEFPOS: Integer;
    FGerIdTerminal: String;
    FTxtPgto3: String;
    FTxtPgto1: String;
    FTxtPgto2: String;
    FPadraoDebito: Integer;
    FPadraoCredito: Integer;
    FBKSTroco: Boolean;
    FBKSDesconto: Boolean;
    FEstSelPromo: Boolean;
    FUsaEsquemaCores: Boolean;
    FColunaNegrito: Boolean;
    FEstEtiqAlt24: Real;
    FFFood_TransFinal: Boolean;
    FBalcaoPgmOS3: String;
    FLDebugNFe: Boolean;
    FEstMesExclus: Integer;
    FOPES_HideShow: Integer;
    FCxCancelCartao: Boolean;
    FGerValParcMin: Real;
    FOpES_PgtoMistoTEF: Boolean;
    FTamDetBobina: Integer;
    FImprimeEntrada: Boolean;
    FArqSaidaACNFe: String;
    FCxTimerDtHr: Boolean;
    FcpMVACusto: Boolean;

  protected
  public
    // [Conexao]
    property IdEstacao: String read FIdEstacao write FIdEstacao;
    property DriveRemoto: String read FDriveRemoto write FDriveRemoto;
    property Caminho: String read FCaminho write FCaminho;
    property Senha: String read FSenha write FSenha;
    property Desconecta: Boolean read FDesconecta write FDesconecta;
    property Usuario: String read FUsuario write FUsuario;
    property SalvaForm: Boolean read FSalvaForm write FSalvaForm;
    property ServClie: String read FServClie write FServClie;
    property FonteNome: String read FFonteNome write FFonteNome;
    property FonteTam: Integer read FFonteTam write FFonteTam;
    property ImagemFundo: String read FImagemFundo write FImagemFundo;

    // [Dados]
    property Parametros: String read FParametros write FParametros;
    property PathLocal: String read FPathLocal write FPathLocal;
    property ArqSaidaACNFe: String read FArqSaidaACNFe write FArqSaidaACNFe;
    property PathRelatorios: String read FPathRelatorios write FPathRelatorios;
    property LinPolegada: Integer read FLinPolegada write FLinPolegada;
    property PathEstacaoTrabalho: String read FPathEstacaoTrabalho
      write FPathEstacaoTrabalho;
    property NrEstacao: String read FNrEstacao write FNrEstacao;
    property LDebug: Boolean read FLDebug write FLDebug;
    property LDebugNFe: Boolean read FLDebugNFe write FLDebugNFe;
    property LSalvaParam: Boolean read FLSalvaParam write FLSalvaParam;
    property LSuporte: Boolean read FLSuporte write FLSuporte;
    property LDownLoadNFe: Boolean read FLDownLoadNFe write FLDownLoadNFe;
    property LLeituraNFe: Boolean read FLLeituraNFe write FLLeituraNFe;
    property LFluxoFinanceiro: Boolean read FLFluxoFinanceiro
      write FLFluxoFinanceiro;
    property LExibQtdLPrecos: Boolean read FLExibQtdLPrecos
      write FLExibQtdLPrecos;
    property LGridLinDestaq: Boolean read FLGridLinDestaq write FLGridLinDestaq;
    property CorLinDestaq: TColor read FCorLinDestaq write FCorLinDestaq;
    property CorPrtDestaq: TColor read FCorPrtDestaq write FCorPrtDestaq;
    property LinPrtDestaq: Integer read FLinPrtDestaq write FLinPrtDestaq;
    property CorHeaderDestaq: TColor read FCorHeaderDestaq
      write FCorHeaderDestaq;
    property CorColumnDestaq: TColor read FCorColumnDestaq
      write FCorColumnDestaq;
    property CorBoxDestaq: TColor read FCorBoxDestaq write FCorBoxDestaq;
    property UsaEsquemaCores: Boolean read FUsaEsquemaCores
      write FUsaEsquemaCores;
    property ColunaNegrito: Boolean read FColunaNegrito write FColunaNegrito;
    property UsaWhatsApp: Boolean read FUsaWhatsApp write FUsaWhatsApp;
    property PathWhatsApp: String read FPathWhatsApp write FPathWhatsApp;
    property TamPagTerm: Integer read FTamPagTerm write FTamPagTerm;

    // [Pedidos]
    property EmitePedidos: Boolean read FEmitePedidos write FEmitePedidos;
    property ImpressoraPedidos: String read FImpressoraPedidos
      write FImpressoraPedidos;
    property ViasPedidos: Integer read FViasPedidos write FViasPedidos;
    property PreviewPedidos: Boolean read FPreviewPedidos write FPreviewPedidos;
    property PedidosNegrito: Boolean read FPedidosNegrito write FPedidosNegrito;
    property MargemEsquerda: Integer read FMargemEsquerda write FMargemEsquerda;
    property MargemDireita: Integer read FMargemDireita write FMargemDireita;
    property PedidoLocal: Integer read FPedidoLocal write FPedidoLocal;

    // [Caixa]
    property CxLocal: Boolean read FCxLocal write FCxLocal;
    property CxLocalNro: Integer read FCxLocalNro write FCxLocalNro;
    property CxLocalEF: Integer read FCxLocalEF write FCxLocalEF;
    property CxLocalTpImpress: String read FCxLocalTpImpress
      write FCxLocalTpImpress;
    property CxLocalPreview: Boolean read FCxLocalPreview write FCxLocalPreview;
    property CxLocalImpressora: String read FCxLocalImpressora
      write FCxLocalImpressora;
    property CxPathCaixa: String read FCxPathCaixa write FCxPathCaixa;
    property CxPathExBalcao: String read FCxPathExBalcao write FCxPathExBalcao;
    property CxPathExGeren: String read FCxPathExGeren write FCxPathExGeren;
    property CxExclusivo: Boolean read FCxExclusivo write FCxExclusivo;
    property CxPedido: Boolean read FCxPedido write FCxPedido;
    property CxNFElet: Boolean read FCxNFElet write FCxNFElet;
    property CxNFCons: Boolean read FCxNFCons write FCxNFCons;
    property CxNFServ: Boolean read FCxNFServ write FCxNFServ;
    property CxOperDFe: Boolean read FCxOperDFe write FCxOperDFe;
    property CxFatMens: Boolean read FCxFatMens write FCxFatMens;
    property CxCancOper: Boolean read FCxCancOper write FCxCancOper;
    property CxExclOper: Boolean read FCxExclOper write FCxExclOper;
    property CxNovaOper: Boolean read FCxNovaOper write FCxNovaOper;
    property CxTpOper: Integer read FCxTpOper write FCxTpOper;
    property CxAltOper: Boolean read FCxAltOper write FCxAltOper;
    property CxOrdServ: Boolean read FCxOrdServ write FCxOrdServ;
    property CxCondPagto: String read FCxCondPagto write FCxCondPagto;
    property CxFazTroco: Boolean read FCxFazTroco write FCxFazTroco;
    property CxExibeOrcam: Boolean read FCxExibeOrcam write FCxExibeOrcam;
    property CxTempoMsg: Integer read FCxTempoMsg write FCxTempoMsg;
    property CxDocInterno: Boolean read FCxDocInterno write FCxDocInterno;
    property CxTimer: Boolean read FCxTimer write FCxTimer;
    property CxDocCobranca: Boolean read FCxDocCobranca write FCxDocCobranca;
    property CxTipoCobranca: Integer read FCxTipoCobranca write FCxTipoCobranca;
    property CxDocAutom: Boolean read FCxDocAutom write FCxDocAutom;
    property CxRecebimentos: Boolean read FCxRecebimentos write FCxRecebimentos;
    property CxTempoTimer: Integer read FCxTempoTimer write FCxTempoTimer;
    property CxConfCtrlX: Boolean read FCxConfCtrlX write FCxConfCtrlX;
    property CxViasDocInt: Integer read FCxViasDocInt write FCxViasDocInt;
    property CxDescAdic: Boolean read FCxDescAdic write FCxDescAdic;
    property CxCCorrCliente: Boolean read FCxCCorrCliente write FCxCCorrCliente;
    property CxUltimoReg: Boolean read FCxUltimoReg write FCxUltimoReg;
    property CxSitOperIni: Integer read FCxSitOperIni write FCxSitOperIni;
    property CxCancelCartao: Boolean read FCxCancelCartao write FCxCancelCartao;
    property CxLcts: Integer read FCxLcts write FCxLcts;
    property CxFech: Boolean read FCxFech write FCxFech;
    property CxAten: Boolean read FCxAten write FCxAten;
    property CxTimerDtHr: Boolean read FCxTimerDtHr write FCxTimerDtHr;

    // FastFood - Local
    property FFLocal_Balcao: Boolean read FFFLocal_Balcao write FFFLocal_Balcao;
    property FFLocal_Tele: Boolean read FFFLocal_Tele write FFFLocal_Tele;
    property FFLocal_Mesas: Boolean read FFFLocal_Mesas write FFFLocal_Mesas;
    property FFLocal_NFCe: Boolean read FFFLocal_NFCe write FFFLocal_NFCe;
    property FFLocal_NFe: Boolean read FFFLocal_NFe write FFFLocal_NFe;
    property FFLocal_GerDFe: Boolean read FFFLocal_GerDFe write FFFLocal_GerDFe;
    property FFLocal_Printer: String read FFFLocal_Printer
      write FFFLocal_Printer;
    property FFLocal_VPrinc: Integer read FFFLocal_VPrinc write FFFLocal_VPrinc;
    property FFLocal_PrinterSec: String read FFFLocal_PrinterSec
      write FFFLocal_PrinterSec;
    property FFLocal_VSec: Integer read FFFLocal_VSec write FFFLocal_VSec;
    property FFLocal_SecTp: Integer read FFFLocal_SecTp write FFFLocal_SecTp;

    // Balcao simples/Kiosk/Magazine - Local
    property BSUtiliza: Boolean read FBSUtiliza write FBSUtiliza;
    property BSEmpFil: Boolean read FBSEmpFil write FBSEmpFil;
    property BSVendedor: Boolean read FBSVendedor write FBSVendedor;
    property BSLPreco: Boolean read FBSLPreco write FBSLPreco;
    property BSCliente: Boolean read FBSCliente write FBSCliente;
    property BSInicio: Integer read FBSInicio write FBSInicio;
    property BSSeqCodProd: Boolean read FBSSeqCodProd write FBSSeqCodProd;
    property BSSeqDescricao: Boolean read FBSSeqDescricao write FBSSeqDescricao;
    property BSSeqUnid: Boolean read FBSSeqUnid write FBSSeqUnid;
    property BSSeqQuant: Boolean read FBSSeqQuant write FBSSeqQuant;
    property BSSeqVlUnit: Boolean read FBSSeqVlUnit write FBSSeqVlUnit;
    property BSSeqCompl: Boolean read FBSSeqCompl write FBSSeqCompl;
    property BSSeqBtOK: Boolean read FBSSeqBtOK write FBSSeqBtOK;
    property BSAvEnter: Boolean read FBSAvEnter write FBSAvEnter;
    property BSOpDescrCompl: Boolean read FBSOpDescrCompl write FBSOpDescrCompl;
    property BSOrcamentos: Boolean read FBSOrcamentos write FBSOrcamentos;
    property BSTimeWait: Integer read FBSTimeWait write FBSTimeWait;

    property BKSCliente: Boolean read FBKSCliente write FBKSCliente;
    property BKSNomeClie: Boolean read FBKSNomeClie write FBKSNomeClie;
    property BKSCondPg: Boolean read FBKSCondPg write FBKSCondPg;
    property BKSDesconto: Boolean read FBKSDesconto write FBKSDesconto;
    property BKSTroco: Boolean read FBKSTroco write FBKSTroco;
    property BKSNFCe: Boolean read FBKSNFCe write FBKSNFCe;
    property BKSLcts: Integer read FBKSLcts write FBKSLcts;
    property BKSFinaliz: Integer read FBKSFinaliz write FBKSFinaliz;

    property BMagOper: Boolean read FBMagOper write FBMagOper;
    property BMagProd: Boolean read FBMagProd write FBMagProd;
    property BMagDime: Boolean read FBMagDime write FBMagDime;
    property BMagParm: Boolean read FBMagParm write FBMagParm;
    property BMagPreco: Boolean read FBMagPreco write FBMagPreco;

    // [Gerenciador]
    property GerNotasFiscais: String read FGerNotasFiscais
      write FGerNotasFiscais;
    property GerNotasBenef: String read FGerNotasBenef write FGerNotasBenef;
    property GerAlternaDados: Boolean read FGerAlternaDados
      write FGerAlternaDados;
    property GerReplicaDados: Boolean read FGerReplicaDados
      write FGerReplicaDados;
    property GerOrdemInicial: Integer read FGerOrdemInicial
      write FGerOrdemInicial;
    property GerEnvioXMLDanfe: String read FGerEnvioXMLDanfe
      write FGerEnvioXMLDanfe;
    property GerEstCadastro: Boolean read FGerEstCadastro write FGerEstCadastro;
    property GerEstMovimentacao: Boolean read FGerEstMovimentacao
      write FGerEstMovimentacao;
    property GerEstRegistro: Boolean read FGerEstRegistro write FGerEstRegistro;
    property GerServicos: Boolean read FGerServicos write FGerServicos;
    property GerAtualizaData: Boolean read FGerAtualizaData
      write FGerAtualizaData;
    property GerViasNFCe: Integer read FGerViasNFCe write FGerViasNFCe;
    property GerAtlzEstoques: Boolean read FGerAtlzEstoques
      write FGerAtlzEstoques;
    property GerBolPrinterLocal: Boolean read FGerBolPrinterLocal
      write FGerBolPrinterLocal;
    property GerBolIdPrinterLocal: String read FGerBolIdPrinterLocal
      write FGerBolIdPrinterLocal;
    property GerBolPreview: Boolean read FGerBolPreview write FGerBolPreview;
    property GerUsaDLL: Boolean read FGerUsaDLL write FGerUsaDLL;
    property GerTEFPOS: Integer read FGerTEFPOS write FGerTEFPOS;
    property GerIdTerminal: String read FGerIdTerminal write FGerIdTerminal;
    property GerValParcMin: Real read FGerValParcMin write FGerValParcMin;

    // [Balcao]
    property BalcaoCondPagto: Boolean read FBalcaoCondPagto
      write FBalcaoCondPagto;
    property BalcaoFreteVlrAdic: Boolean read FBalcaoFreteVlrAdic
      write FBalcaoFreteVlrAdic;
    property BalcaoEmiteDFeDInt: Boolean read FBalcaoEmiteDFeDInt
      write FBalcaoEmiteDFeDInt;
    property BalcaoAtualizaCaixa: Boolean read FBalcaoAtualizaCaixa
      write FBalcaoAtualizaCaixa;
    property SeparadorDecimal: String read FSeparadorDecimal
      write FSeparadorDecimal;
    property AvancoEnter: Boolean read FAvancoEnter write FAvancoEnter;
    property SaltaTrib: Boolean read FSaltaTrib write FSaltaTrib;
    property SaltaPed: Boolean read FSaltaPed write FSaltaPed;
    property InicioOperacao: Integer read FInicioOperacao write FInicioOperacao;
    property LctosOperacao: Integer read FLctosOperacao write FLctosOperacao;
    property TpDescBalcao: Integer read FTpDescBalcao write FTpDescBalcao;
    property BalcaoPgmOS1: String read FBalcaoPgmOS1 write FBalcaoPgmOS1;
    property BalcaoPgmOS2: String read FBalcaoPgmOS2 write FBalcaoPgmOS2;
    property BalcaoPgmOS3: String read FBalcaoPgmOS3 write FBalcaoPgmOS3;

    // Venda e Ordens de serviço
    property EmpFilVendas: Integer read FEmpFilVendas write FEmpFilVendas;
    property AteVenVendas: Integer read FAteVenVendas write FAteVenVendas;
    property AlteraEmpFil: Boolean read FAlteraEmpFil write FAlteraEmpFil;
    property EmpFilOS1: Integer read FEmpFilOS1 write FEmpFilOS1;
    property AteVenOS1: Integer read FAteVenOS1 write FAteVenOS1;
    property EmpFilOS2: Integer read FEmpFilOS2 write FEmpFilOS2;
    property AteVenOS2: Integer read FAteVenOS2 write FAteVenOS2;

    // ---Informações obtidas no uso (não fazem parte do .ini)
    property SysUser: String read FSysUser write FSysUser;
    property SysUserStat: Integer read FSysUserStat write FSysUserStat;
    property SysComputerName: String read FSysComputerName
      write FSysComputerName;
    property SysPath: String read FSysPath write FSysPath;

    // EMail / WhatsApp
    property EMEMailDest: String read FEMEMailDest write FEMEMailDest;
    property EMAssunto: String read FEMAssunto write FEMAssunto;
    property EMNomeDest: String read FEMNomeDest write FEMNomeDest;
    property EMAnexo: String read FEMAnexo write FEMAnexo;
    property EMEnviado: Boolean read FEMEnviado write FEMEnviado;
    property EMDtHrEnvio: TDateTime read FEMDtHrEnvio write FEMDtHrEnvio;
    property EMModoEnvio: String read FEMModoEnvio write FEMModoEnvio;
    property EMCodClie: Integer read FEMCodClie write FEMCodClie;
    property NrWhatsCliente: String read FNrWhatsCliente write FNrWhatsCliente;

    property EMNrDoc: Integer read FEMNrDoc write FEMNrDoc;
    property EMTpDoc: Integer read FEMTpDoc write FEMTpDoc;
    property EMHistorico: String read FEMHistorico write FEMHistorico;
    property EMAgendar: Boolean read FEMAgendar write FEMAgendar;
    property EMDtAgenda: TDateTime read FEMDtAgenda write FEMDtAgenda;
    property SysDtMinima: TDateTime read FSysDtMinima write FSysDtMinima;
    property SalvaAnexo: Boolean read FSalvaAnexo write FSalvaAnexo;

    // [Identificacao]
    property Sistema: String read FSistema write FSistema;
    property Empresa: String read FEmpresa write FEmpresa;

    // [Dados]
    property DatabaseName: String read FDatabaseName write FDatabaseName;
    property DatabasePath: String read FDatabasePath write FDatabasePath;
    property LiteFull: String read FLiteFull write FLiteFull;
    property LiteMax: Integer read FLiteMax write FLiteMax;
    property PathAuxiliar: String read FPathAuxiliar write FPathAuxiliar;
    property SenhaExclus: String read FSenhaExclus write FSenhaExclus;
    property Serial: String read FSerial write FSerial;
    property PathExec: String read FPathExec write FPathExec;
    property PathEstruturas: String read FPathEstruturas write FPathEstruturas;
    property PathArqMorto: String read FPathArqMorto write FPathArqMorto;

    // [EMail]
    property EMNome: String read FEMNome write FEMNome;
    property EMOrigem: String read FEMOrigem write FEMOrigem;
    property EMPorta: String read FEMPorta write FEMPorta;
    property EMHost: String read FEMHost write FEMHost;
    property EMUsario: String read FEMUsario write FEMUsario;
    property EMSenha: String read FEMSenha write FEMSenha;
    property EMEnvio: string read FEMEnvio write FEMEnvio;

    // [Internet]
    property ProxyHost: String read FProxyHost write FProxyHost;
    property ProxyPass: string read FProxyPass write FProxyPass;
    property ProxyPort: string read FProxyPort write FProxyPort;
    property ProxyUser: string read FProxyUser write FProxyUser;
    property UrlNCM: String read FUrlNCM write FUrlNCM;

    // [Padroes]
    property RefreshTimer: Integer read FRefreshTimer write FRefreshTimer;
    property Magazine: Boolean read FMagazine write FMagazine;
    property CodEF: Integer read FCodEF write FCodEF;
    property Cidade: String read FCidade write FCidade;
    property Estado: String read FEstado write FEstado;
    property MunIBGE: String read FMunIBGE write FMunIBGE;
    property UFIBGE: String read FUFIBGE write FUFIBGE;

    property ValorDec: Integer read FValorDec write FValorDec;
    property QuantDec: Integer read FQuantDec write FQuantDec;
    property CadastroUnico: Boolean read FCadastroUnico write FCadastroUnico;
    property AtualizaCadastro: Boolean read FAtualizaCadastro
      write FAtualizaCadastro;
    property CadasLogFile: String read FCadasLogFile write FCadasLogFile;
    property TranspLogFile: String read FTranspLogFile write FTranspLogFile;
    property EmpregLogFile: String read FEmpregLogFile write FEmpregLogFile;
    property PagRecLogFile: String read FPagRecLogFile write FPagRecLogFile;
    property DFeLogFile: String read FDFeLogFile write FDFeLogFile;
    property PeriodoCC: Integer read FPeriodoCC write FPeriodoCC;
    property CadClass1: String read FCadClass1 write FCadClass1;
    property CadClass2: String read FCadClass2 write FCadClass2;
    property CadClass3: String read FCadClass3 write FCadClass3;
    property CaixaDoc: Integer read FCaixaDoc write FCaixaDoc;
    property PcCredAV: Real read FPcCredAV write FPcCredAV;
    property PcCredParc: Real read FPcCredParc write FPcCredParc;
    property MensCredParc: Boolean read FMensCredParc write FMensCredParc;
    property PcDebito: Real read FPcDebito write FPcDebito;
    property PcCrediario: Real read FPcCrediario write FPcCrediario;
    property MensCrediario: Boolean read FMensCrediario write FMensCrediario;
    property PcParcelam: Real read FPcParcelam write FPcParcelam;
    property MensParcelam: Boolean read FMensParcelam write FMensParcelam;
    property PcCheques: Real read FPcCheques write FPcCheques;
    property MensCheques: Boolean read FMensCheques write FMensCheques;
    property PrazoMedio: Boolean read FPrazoMedio write FPrazoMedio;
    property UsaTabCartoes: Boolean read FUsaTabCartoes write FUsaTabCartoes;
    property VlrMinDesc: Real read FVlrMinDesc write FVlrMinDesc;
    property PcMaxDesc: Real read FPcMaxDesc write FPcMaxDesc;
    property BolMax: Integer read FBolMax write FBolMax;
    property CredMax: Integer read FCredMax write FCredMax;
    property CartMax: Integer read FCartMax write FCartMax;
    property ChqMax: Integer read FChqMax write FChqMax;
    property LeituraAuto: Boolean read FLeituraAuto write FLeituraAuto;
    property PadraoPesqAlfa: Integer read FPadraoPesqAlfa write FPadraoPesqAlfa;
    property DescBoletos: Boolean read FDescBoletos write FDescBoletos;
    property RemBolAutom: Boolean read FRemBolAutom write FRemBolAutom;
    property GerBolEmpFil: Boolean read FGerBolEmpFil write FGerBolEmpFil;
    property PedidoPadrao: Integer read FPedidoPadrao write FPedidoPadrao;
    property ConfirmaVias: Boolean read FConfirmaVias write FConfirmaVias;
    property ExibeQtdDisp: Boolean read FExibeQtdDisp write FExibeQtdDisp;
    property ValidarIE: Integer read FValidarIE write FValidarIE;
    property IdAtacadista: String read FIdAtacadista write FIdAtacadista;
    property IdDistribuidor: String read FIdDistribuidor write FIdDistribuidor;
    property Recibos: Boolean read FRecibos write FRecibos;
    property RecSimples: Boolean read FRecSimples write FRecSimples;
    property AMSemestral: Boolean read FAMSemestral write FAMSemestral;
    property IntegVendOS: Boolean read FIntegVendOS write FIntegVendOS;
    property TotalNFe: Boolean read FTotalNFe write FTotalNFe;
    property DtLimiteSeFaz: TDateTime read FDtLimiteSeFaz write FDtLimiteSeFaz;
    property TipoVenda: Boolean read FTipoVenda write FTipoVenda;
    property AdotaDtAtual: Boolean read FAdotaDtAtual write FAdotaDtAtual;
    property EMailHomolog: String read FEMailHomolog write FEMailHomolog;

    // [Financeiro]
    property DetRubricas: Boolean read FDetRubricas write FDetRubricas;
    property TpJuros: Integer read FTpJuros write FTpJuros;
    property PcJuros: Real read FPcJuros write FPcJuros;
    property PcDesc: Real read FPcDesc write FPcDesc;
    property PcMulta: Real read FPcMulta write FPcMulta;
    property Cobranca: Integer read FCobranca write FCobranca;
    property DocPagar: Integer read FDocPagar write FDocPagar;
    property DocReceb: Integer read FDocReceb write FDocReceb;
    property DocCrediar: Integer read FDocCrediar write FDocCrediar;
    property DocCheque: Integer read FDocCheque write FDocCheque;
    property DuplCNPJ: Boolean read FDuplCNPJ write FDuplCNPJ;
    property DuplIEST: Boolean read FDuplIEST write FDuplIEST;
    property DiasFuturos: Integer read FDiasFuturos write FDiasFuturos;
    property NroDocObrigatorio: Boolean read FNroDocObrigatorio
      write FNroDocObrigatorio;
    property DiferDocumentos: Boolean read FDiferDocumentos
      write FDiferDocumentos;
    property PathRemessas: String read FPathRemessas write FPathRemessas;
    property DetPathRemessas: Integer read FDetPathRemessas
      write FDetPathRemessas;
    property ProcRetornos: Boolean read FProcRetornos write FProcRetornos;
    property PathRetornos: String read FPathRetornos write FPathRetornos;
    property PathSalvaRetornos: String read FPathSalvaRetornos
      write FPathSalvaRetornos;
    property RetProcesso: Integer read FRetProcesso write FRetProcesso;
    property VisProcesso: Boolean read FVisProcesso write FVisProcesso;
    property PathAlter01: String read FPathAlter01 write FPathAlter01;
    property PathAlter02: String read FPathAlter02 write FPathAlter02;
    property PathAlter03: String read FPathAlter03 write FPathAlter03;
    property PathAlter04: String read FPathAlter04 write FPathAlter04;
    property PathAlter05: String read FPathAlter05 write FPathAlter05;
    property UsaPlanoContas: Boolean read FUsaPlanoContas write FUsaPlanoContas;
    property TpCarneCrediar: Integer read FTpCarneCrediar write FTpCarneCrediar;
    property TamDetBobina: Integer read FTamDetBobina write FTamDetBobina;
    property EmpFilCrediar: Integer read FEmpFilCrediar write FEmpFilCrediar;
    property ImprimeConfDiv: Boolean read FImprimeConfDiv write FImprimeConfDiv;
    property ImprimeEntrada: Boolean read FImprimeEntrada write FImprimeEntrada;
    property TxtConfDivida: String read FTxtConfDivida write FTxtConfDivida;
    property TxtConfDividaBob: String read FTxtConfDividaBob
      write FTxtConfDividaBob;
    property TxtCarnet1: String read FTxtCarnet1 write FTxtCarnet1;
    property TxtCarnet2: String read FTxtCarnet2 write FTxtCarnet2;
    property DiasIsencao: Integer read FDiasIsencao write FDiasIsencao;
    property LiberaCred: Boolean read FLiberaCred write FLiberaCred;
    property UtilizaCC: Boolean read FUtilizaCC write FUtilizaCC;
    property CreditoCC: String read FCreditoCC write FCreditoCC;
    property DebitoCC: String read FDebitoCC write FDebitoCC;
    property InfSaldoCC: Boolean read FInfSaldoCC write FInfSaldoCC;
    property TxtPgto1: String read FTxtPgto1 write FTxtPgto1;
    property TxtPgto2: String read FTxtPgto2 write FTxtPgto2;
    property TxtPgto3: String read FTxtPgto3 write FTxtPgto3;

    // Boletos
    property Bol_PathPDF: String read FBol_PathPDF write FBol_PathPDF;
    property Bol_Denom: Integer read FBol_Denom write FBol_Denom;
    property Bol_OutraDenom: String read FBol_OutraDenom write FBol_OutraDenom;
    property Bol_Impressora: String read FBol_Impressora write FBol_Impressora;
    property Bol_Copias: Integer read FBol_Copias write FBol_Copias;
    property Bol_DialogPrint: Boolean read FBol_DialogPrint
      write FBol_DialogPrint;
    property Bol_ExcluePDF: Boolean read FBol_ExcluePDF write FBol_ExcluePDF;

    // Estoques
    property EstoqLogFile: String read FEstoqLogFile write FEstoqLogFile;
    property ECadas: String read FECadas write FECadas;
    property EApres: String read FEApres write FEApres;
    property EObRefer: Boolean read FEObRefer write FEObRefer;
    property EObGrupo: Boolean read FEObGrupo write FEObGrupo;
    property EDupDescr: Boolean read FEDupDescr write FEDupDescr;
    property ELPreco: Boolean read FELPreco write FELPreco;
    property EDupRefer: Boolean read FEDupRefer write FEDupRefer;
    property EUsaRefer2: Boolean read FEUsaRefer2 write FEUsaRefer2;
    property EExibUltCusto: Boolean read FEExibUltCusto write FEExibUltCusto;
    property EDescrCase: String read FEDescrCase write FEDescrCase;
    property EDiasValidade: Integer read FEDiasValidade write FEDiasValidade;
    property EstCodTam: Integer read FEstCodTam write FEstCodTam;
    property EstCodDiv: Integer read FEstCodDiv write FEstCodDiv;
    property EstDiv1Tam: Integer read FEstDiv1Tam write FEstDiv1Tam;
    property EstDiv1Tip: String read FEstDiv1Tip write FEstDiv1Tip;
    property EstDiv2Tam: Integer read FEstDiv2Tam write FEstDiv2Tam;
    property EstDiv2Tip: String read FEstDiv2Tip write FEstDiv2Tip;
    property EstDiv3Tam: Integer read FEstDiv3Tam write FEstDiv3Tam;
    property EstDiv3Tip: String read FEstDiv3Tip write FEstDiv3Tip;
    property EstDiv4Tam: Integer read FEstDiv4Tam write FEstDiv4Tam;
    property EstDiv4Tip: String read FEstDiv4Tip write FEstDiv4Tip;
    property EstEtiquetas: Boolean read FEstEtiquetas write FEstEtiquetas;
    property EstEtiqAlt24: Real read FEstEtiqAlt24 write FEstEtiqAlt24;
    property EstExpCodBar: Integer read FEstExpCodBar write FEstExpCodBar;
    property EstPathWrk: String read FEstPathWrk write FEstPathWrk;
    property EstBarrasPrinter: String read FEstBarrasPrinter
      write FEstBarrasPrinter;
    property EstBarrasA4: string read FEstBarrasA4 write FEstBarrasA4;
    property EstProdCusto: Boolean read FEstProdCusto write FEstProdCusto;
    property EstMagazine: Boolean read FEstMagazine write FEstMagazine;
    property EstAssTecnica: Boolean read FEstAssTecnica write FEstAssTecnica;
    property EstSelPromo: Boolean read FEstSelPromo write FEstSelPromo;
    property EstMesExclus: Integer read FEstMesExclus write FEstMesExclus;
    property EstMarcaEF: Integer read FEstMarcaEF write FEstMarcaEF;
    property EstAltPrecos: Boolean read FEstAltPrecos write FEstAltPrecos;
    property EstSubGrupo: Boolean read FEstSubGrupo write FEstSubGrupo;
    property EstValidEAN: Boolean read FEstValidEAN write FEstValidEAN;
    property EstBkupMes: Boolean read FEstBkupMes write FEstBkupMes;
    property EstBkupPath: String read FEstBkupPath write FEstBkupPath;

    // [Servicos]
    property SrvCodEspec: Boolean read FSrvCodEspec write FSrvCodEspec;
    property SrvCodTam: Integer read FSrvCodTam write FSrvCodTam;
    property SrvCodNA: String read FSrvCodNA write FSrvCodNA;

    // [Estoques_Entradas / Compras]
    property Entr_EF: Integer read FEntr_EF write FEntr_EF;
    property Entr_ExibeCalc: Boolean read FEntr_ExibeCalc write FEntr_ExibeCalc;
    property Entr_AtlzCP: Boolean read FEntr_AtlzCP write FEntr_AtlzCP;
    property Entr_CPDoc: Integer read FEntr_CPDoc write FEntr_CPDoc;
    property Entr_CPRubr: Integer read FEntr_CPRubr write FEntr_CPRubr;
    property Entr_DocEntr: Integer read FEntr_DocEntr write FEntr_DocEntr;
    property Entr_Detal: Boolean read FEntr_Detal write FEntr_Detal;
    property Entr_CritBases: Boolean read FEntr_CritBases write FEntr_CritBases;
    property Entr_CalcBsIsenta: Boolean read FEntr_CalcBsIsenta
      write FEntr_CalcBsIsenta;
    property Entr_AdotaPreco: Boolean read FEntr_AdotaPreco
      write FEntr_AdotaPreco;
    property Entr_AdotaCFOP: Boolean read FEntr_AdotaCFOP write FEntr_AdotaCFOP;
    property Entr_PathLeXML: String read FEntr_PathLeXML write FEntr_PathLeXML;
    property Entr_DifEF: Boolean read FEntr_DifEF write FEntr_DifEF;
    property Entr_ExProcesso: Boolean read FEntr_ExProcesso
      write FEntr_ExProcesso;
    property Entr_PesqRefer: Boolean read FEntr_PesqRefer write FEntr_PesqRefer;

    // [Estoques_Compras]
    property Compra_Id: String read FCompra_Id write FCompra_Id;
    property Compra_Abrev: String read FCompra_Abrev write FCompra_Abrev;
    property Compra_Menu: String read FCompra_Menu write FCompra_Menu;
    property Compra_QtdDec: Integer read FCompra_QtdDec write FCompra_QtdDec;
    property Compra_UnitDec: Integer read FCompra_UnitDec write FCompra_UnitDec;

    // [Estoques_Tributacao]
    property esModoBC: Integer read FesModoBC write FesModoBC;
    property esRedBC: Real read FesRedBC write FesRedBC;
    property esModoBCST: Integer read FesModoBCST write FesModoBCST;
    property esMVA: Real read FesMVA write FesMVA;
    property esRedBCST: Real read FesRedBCST write FesRedBCST;

    property esIPIEnt: Integer read FesIPIEnt write FesIPIEnt;
    property esIPISai: Integer read FesIPISai write FesIPISai;
    property esIPIClasse: String read FesIPIClasse write FesIPIClasse;
    property esIPIEnq: String read FesIPIEnq write FesIPIEnq;
    property esIPIModo: String read FesIPIModo write FesIPIModo;
    property esNCM: String read FesNCM write FesNCM;
    property esGenero: String read FesGenero write FesGenero;
    property esExTIPI: String read FesExTIPI write FesExTIPI;
    property esIPI: Boolean read FesIPI write FesIPI;
    property esIPITrib: Boolean read FesIPITrib write FesIPITrib;
    property esCEST: String read FesCEST write FesCEST;
    property esNVE: string read FesNVE write FesNVE;

    property esPISST: Integer read FesPISST write FesPISST;
    property esPISAliq: Real read FesPISAliq write FesPISAliq;
    property esPISVlUnit: Real read FesPISVlUnit write FesPISVlUnit;
    property esPIS: Boolean read FesPIS write FesPIS;

    property esCofinsST: Integer read FesCofinsST write FesCofinsST;
    property esCofinsAliq: Real read FesCofinsAliq write FesCofinsAliq;
    property esCofinsVlUnit: Real read FesCofinsVlUnit write FesCofinsVlUnit;
    property esCofins: Boolean read FesCofins write FesCofins;

    // Custos & Preços
    property cpMargem: Real read FcpMargem write FcpMargem;
    property cpCFixos: Real read FcpCFixos write FcpCFixos;
    property cpAliqSN: Real read FcpAliqSN write FcpAliqSN;
    property cpAliqLP: Real read FcpAliqLP write FcpAliqLP;
    property cpTaxFin: Real read FcpTaxFin write FcpTaxFin;
    property cpMVACusto: Boolean read FcpMVACusto write FcpMVACusto;

    // [Vendas]
    property CFOP_Venda: Integer read FCFOP_Venda write FCFOP_Venda;
    property CFOP_VendaST: Integer read FCFOP_VendaST write FCFOP_VendaST;
    property CFOP_Servico: Integer read FCFOP_Servico write FCFOP_Servico;
    property CFOP_NCVenda: Integer read FCFOP_NCVenda write FCFOP_NCVenda;
    property CFOP_NCVendaST: Integer read FCFOP_NCVendaST write FCFOP_NCVendaST;
    property CFOP_Venda_FE: Integer read FCFOP_Venda_FE write FCFOP_Venda_FE;
    property CFOP_VendaST_FE: Integer read FCFOP_VendaST_FE
      write FCFOP_VendaST_FE;
    property CFOP_Servico_FE: Integer read FCFOP_Servico_FE
      write FCFOP_Servico_FE;
    property CFOP_NCVenda_FE: Integer read FCFOP_NCVenda_FE
      write FCFOP_NCVenda_FE;
    property CFOP_NCVendaST_FE: Integer read FCFOP_NCVendaST_FE
      write FCFOP_NCVendaST_FE;
    property CFOP_Uso: String read FCFOP_Uso write FCFOP_Uso;
    property PrioridadeST: Boolean read FPrioridadeST write FPrioridadeST;

    // [Operacoes]
    Property OpES_NomeCliente: Boolean read FOpES_NomeCliente
      write FOpES_NomeCliente;
    property OpES_Vendedor: Boolean read FOpES_Vendedor write FOpES_Vendedor;
    property OpES_DuplMat: Boolean read FOpES_DuplMat write FOpES_DuplMat;
    property OpES_DuplSrv: Boolean read FOpES_DuplSrv write FOpES_DuplSrv;
    property OpES_LctPrior: String read FOpES_LctPrior write FOpES_LctPrior;
    property OpES_DescrCompl: Boolean read FOpES_DescrCompl
      write FOpES_DescrCompl;
    property OpES_DescItem: Boolean read FOpES_DescItem write FOpES_DescItem;
    property OpES_GrupoBloq0: Integer read FOpES_GrupoBloq0
      write FOpES_GrupoBloq0;
    property OpES_GrupoBloq1: Integer read FOpES_GrupoBloq1
      write FOpES_GrupoBloq1;
    property OpES_GrupoBloq2: Integer read FOpES_GrupoBloq2
      write FOpES_GrupoBloq2;
    property OpES_GrupoBloq3: Integer read FOpES_GrupoBloq3
      write FOpES_GrupoBloq3;
    property OpES_GrupoBloq4: Integer read FOpES_GrupoBloq4
      write FOpES_GrupoBloq4;
    property OpES_GrupoBloq5: Integer read FOpES_GrupoBloq5
      write FOpES_GrupoBloq5;
    property OpES_GrupoBloq6: Integer read FOpES_GrupoBloq6
      write FOpES_GrupoBloq6;
    property OpES_GrupoBloq7: Integer read FOpES_GrupoBloq7
      write FOpES_GrupoBloq7;
    property OpES_GrupoBloq8: Integer read FOpES_GrupoBloq8
      write FOpES_GrupoBloq8;
    property OpES_GrupoBloq9: Integer read FOpES_GrupoBloq9
      write FOpES_GrupoBloq9;
    property OpES_Negativo: Boolean read FOpES_Negativo write FOpES_Negativo;
    property OpES_CalcSTVend: Boolean read FOpES_CalcSTVend
      write FOpES_CalcSTVend;
    property OpES_PgmOS: String read FOpES_PgmOS write FOpES_PgmOS;
    property OpES_LCab1: String read FOpES_LCab1 write FOpES_LCab1;
    property OpES_LCab2: String read FOpES_LCab2 write FOpES_LCab2;
    property OpES_LCab3: String read FOpES_LCab3 write FOpES_LCab3;
    property OpES_LCab4: String read FOpES_LCab4 write FOpES_LCab4;
    property OpES_LProm: String read FOpES_LProm write FOpES_LProm;
    property OpES_PedId: String read FOpES_PedId write FOpES_PedId;
    property OpES_OrcId: String read FOpES_OrcId write FOpES_OrcId;
    property OpES_PedPreview: Boolean read FOpES_PedPreview
      write FOpES_PedPreview;
    property OpES_PedDialog: Boolean read FOpES_PedDialog write FOpES_PedDialog;
    property OpES_PedEntreVias: Boolean read FOpES_PedEntreVias
      write FOpES_PedEntreVias;
    property OpES_PedTotTribut: Boolean read FOpES_PedTotTribut
      write FOpES_PedTotTribut;
    property OpES_PedLogo: String read FOpES_PedLogo write FOpES_PedLogo;
    property OpES_PedAvLin: Integer read FOpES_PedAvLin write FOpES_PedAvLin;
    property OpES_PedAvPix: Integer read FOpES_PedAvPix write FOpES_PedAvPix;
    property OpES_MC5464: Boolean read FOpES_MC5464 write FOpES_MC5464;
    property OpES_ModoBCICMVenda: Integer read FOpES_ModoBCICMVenda
      write FOpES_ModoBCICMVenda;
    property OpES_TimeOut: Integer read FOpES_TimeOut write FOpES_TimeOut;
    property OpES_DtHrSaida: Boolean read FOpES_DtHrSaida write FOpES_DtHrSaida;
    property OpES_CodClieNFe: Boolean read FOpES_CodClieNFe
      write FOpES_CodClieNFe;
    property OpES_HrVeraoIni: TDateTime read FOpES_HrVeraoIni
      write FOpES_HrVeraoIni;
    property OpES_HrVeraoFin: TDateTime read FOpES_HrVeraoFin
      write FOpES_HrVeraoFin;
    property OpES_Crediario: Boolean read FOpES_Crediario write FOpES_Crediario;
    property OpES_VolDefault: Integer read FOpES_VolDefault
      write FOpES_VolDefault;
    property OpES_VolEspecie: String read FOpES_VolEspecie
      write FOpES_VolEspecie;
    property OpES_VolMarca: String read FOpES_VolMarca write FOpES_VolMarca;
    property OpES_SomaQtd: Boolean read FOpES_SomaQtd write FOpES_SomaQtd;
    property OpES_Frete: Integer read FOpES_Frete write FOpES_Frete;
    property OpES_FatorPB: Real read FOpES_FatorPB write FOpES_FatorPB;
    property OpES_AVFluxo: Boolean read FOpES_AVFluxo write FOpES_AVFluxo;
    property OpES_ClieBalcao: Boolean read FOpES_ClieBalcao
      write FOpES_ClieBalcao;
    property OpES_RubrAVFluxo: Integer read FOpES_RubrAVFluxo
      write FOpES_RubrAVFluxo;
    property OpES_SenhaCancel: String read FOpES_SenhaCancel
      write FOpES_SenhaCancel;
    property OpES_SenhaDesc: String read FOpES_SenhaDesc write FOpES_SenhaDesc;
    property OpES_VendaPrefer: String read FOpES_VendaPrefer
      write FOpES_VendaPrefer;
    property OpES_RestauraNFe: Boolean read FOpES_RestauraNFe
      write FOpES_RestauraNFe;
    property OpES_NFeEmiss: String read FOpES_NFeEmiss write FOpES_NFeEmiss;
    property OPES_HideShow: Integer read FOPES_HideShow write FOPES_HideShow;
    property OpES_PathCfgIni: String read FOpES_PathCfgIni
      write FOpES_PathCfgIni;
    property OpES_DirNFeNFCeDifer: Boolean read FOpES_DirNFeNFCeDifer
      write FOpES_DirNFeNFCeDifer;
    property OpES_DiasLimpeza: Integer read FOpES_DiasLimpeza
      write FOpES_DiasLimpeza;
    property OpES_TpVendedor: Integer read FOpES_TpVendedor
      write FOpES_TpVendedor;
    property OpES_Atendimentos: Boolean read FOpES_Atendimentos
      write FOpES_Atendimentos;
    property OpES_PgtoMistoTEF: Boolean read FOpES_PgtoMistoTEF
      write FOpES_PgtoMistoTEF;
    property OpES_NFeLotes: Boolean read FOpES_NFeLotes write FOpES_NFeLotes;
    property OpES_ExibeBoletos: Boolean read FOpES_ExibeBoletos
      write FOpES_ExibeBoletos;
    property OpES_NFComplDd: Boolean read FOpES_NFComplDd write FOpES_NFComplDd;
    property OpES_VlrQtd: Boolean read FOpES_VlrQtd write FOpES_VlrQtd;
    property OpES_UnQtdTrib: Boolean read FOpES_UnQtdTrib write FOpES_UnQtdTrib;
    property OpES_PesqItemDestaq: Boolean read FOpES_PesqItemDestaq
      write FOpES_PesqItemDestaq;
    property OpES_EstOS1: Boolean read FOpES_EstOS1 write FOpES_EstOS1;
    property OpES_EstOS2: Boolean read FOpES_EstOS2 write FOpES_EstOS2;
    property OpES_UFST: String read FOpES_UFST write FOpES_UFST;
    property OpES_CadasCPF: Boolean read FOpES_CadasCPF write FOpES_CadasCPF;
    property OpES_DdLiber: Integer read FOpES_DdLiber write FOpES_DdLiber;
    property OpES_VlrMax: Real read FOpES_VlrMax write FOpES_VlrMax;
    property OpES_HistDFe: Boolean read FOpES_HistDFe write FOpES_HistDFe;
    property OpES_DistribObrigatorio: Boolean read FOpES_DistribObrigatorio
      write FOpES_DistribObrigatorio;
    property OpES_MsgDifal: Boolean read FOpES_MsgDifal write FOpES_MsgDifal;
    property OpES_UFDifAl: String read FOpES_UFDifAl write FOpES_UFDifAl;

    // [OSLoja]  Ordens de Serviço - Benhur Peças
    property OSUtiliza: Boolean read FOSUtiliza write FOSUtiliza;
    property OSLogFile: String read FOSLogFile write FOSLogFile;
    property OSCondPagto: String read FOSCondPagto write FOSCondPagto;
    property Tecnicos: Integer read FTecnicos write FTecnicos;
    property Emissao: Integer read FEmissao write FEmissao;
    property PreviewOSLoja: Boolean read FPreviewOSLoja write FPreviewOSLoja;
    property LPP: Integer read FLPP write FLPP;
    property LCab1: String read FLCab1 write FLCab1;
    property LCab2: String read FLCab2 write FLCab2;
    property LCab3: String read FLCab3 write FLCab3;
    property LObs01: String read FLObs01 write FLObs01;
    property LObs02: String read FLObs02 write FLObs02;
    property LObs03: String read FLObs03 write FLObs03;
    property LObs04: String read FLObs04 write FLObs04;
    property LObs05: String read FLObs05 write FLObs05;
    property LObs06: String read FLObs06 write FLObs06;
    property LObs07: String read FLObs07 write FLObs07;
    property LObs08: String read FLObs08 write FLObs08;
    property LObs09: String read FLObs09 write FLObs09;
    property LObs10: String read FLObs10 write FLObs10;
    property PrinterOSLoja: String read FPrinterOSLoja write FPrinterOSLoja;
    property MsgOSLoja1: String read FMsgOSLoja1 write FMsgOSLoja1;
    property MsgOSLoja2: String read FMsgOSLoja2 write FMsgOSLoja2;

    // Dados obtidos internamente
    property AlTTMercad: Real read FAlTTMercad write FAlTTMercad;
    property AlTTServic: Real read FAlTTServic write FAlTTServic;
    property RegEspICMS: Boolean read FRegEspICMS write FRegEspICMS;
    property CodRegTrib: String read FCodRegTrib write FCodRegTrib;
    property AliqICMS: Real read FAliqICMS write FAliqICMS;
    property AliqPIS: Real read FAliqPIS write FAliqPIS;
    property AliqCOFINS: Real read FAliqCOFINS write FAliqCOFINS;
    property AliqISS: Real read FAliqISS write FAliqISS;
    property ListaPreco: Integer read FListaPreco write FListaPreco;
    property DtCalcSaldoFluxo: TDateTime read FDtCalcSaldoFluxo
      write FDtCalcSaldoFluxo;

    // [Locacoes_Equipamentos]
    property Loc_IdGrupo: String read FLoc_IdGrupo write FLoc_IdGrupo;
    property Loc_IdOperacao: String read FLoc_IdOperacao write FLoc_IdOperacao;
    property Loc_Pr1: String read FLoc_Pr1 write FLoc_Pr1;
    property Loc_Pr2: String read FLoc_Pr2 write FLoc_Pr2;
    property Loc_Pr3: String read FLoc_Pr3 write FLoc_Pr3;
    property Loc_Pr4: String read FLoc_Pr4 write FLoc_Pr4;
    property Loc_Pr5: String read FLoc_Pr5 write FLoc_Pr5;
    property Loc_PathContratos: String read FLoc_PathContratos
      write FLoc_PathContratos;
    property Loc_Margem: Real read FLoc_Margem write FLoc_Margem;
    property Loc_HrDevol: String read FLoc_HrDevol write FLoc_HrDevol;
    property Loc_Financeiro: Boolean read FLoc_Financeiro write FLoc_Financeiro;

    //
    property AGB_DdProd: String read FAGB_DdProd write FAGB_DdProd;
    property AGB_DdLocais: String read FAGB_DdLocais write FAGB_DdLocais;
    property AGB_Assinala: Boolean read FAGB_Assinala write FAGB_Assinala;
    property AGB_ImgFundo: String read FAGB_ImgFundo write FAGB_ImgFundo;
    property AGB_LogoTela: String read FAGB_LogoTela write FAGB_LogoTela;
    property AGB_LogoPrint: String read FAGB_LogoPrint write FAGB_LogoPrint;
    property AGB_Quadro: String read FAGB_Quadro write FAGB_Quadro;
    property AGB_OPLegendas: Boolean read FAGB_OPLegendas write FAGB_OPLegendas;
    property AGB_DispMinimo: Integer read FAGB_DispMinimo write FAGB_DispMinimo;
    property AGB_MetrPadrao: Integer read FAGB_MetrPadrao write FAGB_MetrPadrao;
    property AGB_GrupoEstoque: Integer read FAGB_GrupoEstoque
      write FAGB_GrupoEstoque;
    property AGB_DdImport: String read FAGB_DdImport write FAGB_DdImport;
    {
      property AGB_BobA:         String  read FAGB_BobA         write FAGB_BobA;
      property AGB_BobB:         String  read FAGB_BobB         write FAGB_BobB;
      property AGB_BobC:         String  read FAGB_BobC         write FAGB_BobC;
      property AGB_BobD:         String  read FAGB_BobD         write FAGB_BobD;
      property AGB_Tubete:       Integer read FAGB_Tubete       write FAGB_Tubete;
      property AGB_FatorCliche:  Real    read FAGB_FatorCliche  write FAGB_FatorCliche;
      property AGB_Margem:       Real    read FAGB_Margem       write FAGB_Margem;
    }
    // [OficinaDoFrio] Oficina do Frio - ATecnica
    property OF_Utiliza: Boolean read FOF_Utiliza write FOF_Utiliza;
    property OF_LPPadrao: Integer read FOF_LPPadrao write FOF_LPPadrao;
    property OF_AtzCadas: Boolean read FOF_AtzCadas write FOF_AtzCadas;
    property OF_RubPec: Integer read FOF_RubPec write FOF_RubPec;
    property OF_RubSrv: Integer read FOF_RubSrv write FOF_RubSrv;
    property OF_OSIE_EmiteNF: Boolean read FOF_OSIE_EmiteNF
      write FOF_OSIE_EmiteNF;
    property OF_OSIE_AltClie: Boolean read FOF_OSIE_AltClie
      write FOF_OSIE_AltClie;
    property OF_OSIEImagem: String read FOF_OSIEImagem write FOF_OSIEImagem;
    property OF_OSIEGarantia: Integer read FOF_OSIEGarantia
      write FOF_OSIEGarantia;
    property OF_OSIEUltAtend: Integer read FOF_OSIEUltAtend
      write FOF_OSIEUltAtend;
    property OF_OSIECNPJ: Boolean read FOF_OSIECNPJ write FOF_OSIECNPJ;
    property OF_OSIEEmail: Boolean read FOF_OSIEEmail write FOF_OSIEEmail;
    property OF_RubPecAC: Integer read FOF_RubPecAC write FOF_RubPecAC;
    property OF_RubSrvAC: Integer read FOF_RubSrvAC write FOF_RubSrvAC;
    property OF_RubApaAC: Integer read FOF_RubApaAC write FOF_RubApaAC;
    property OF_OSAC_EmiteNF: Boolean read FOF_OSAC_EmiteNF
      write FOF_OSAC_EmiteNF;
    property OF_OSAC_AltClie: Boolean read FOF_OSAC_AltClie
      write FOF_OSAC_AltClie;
    property OF_OSACImagem: String read FOF_OSACImagem write FOF_OSACImagem;
    property OF_OSACGarantia: Integer read FOF_OSACGarantia
      write FOF_OSACGarantia;
    property OF_SrvIAC: Integer read FOF_SrvIAC write FOF_SrvIAC;
    property OF_AparAC: Integer read FOF_AparAC write FOF_AparAC; // 1031
    property OF_OSACCNPJ: Boolean read FOF_OSACCNPJ write FOF_OSACCNPJ;
    property OF_OSACEmail: Boolean read FOF_OSACEmail write FOF_OSACEmail;
    property OF_LogOSAC: String read FOF_LogOSAC write FOF_LogOSAC;
    property OF_TxLinBranca: Real read FOF_TxLinBranca write FOF_TxLinBranca;
    property OF_TxArCond: Real read FOF_TxArCond write FOF_TxArCond;
    property OF_ServEspTec: Boolean read FOF_ServEspTec write FOF_ServEspTec;
    property OF_PrintTaxa: Boolean read FOF_PrintTaxa write FOF_PrintTaxa;
    property OF_LogOSIE: String read FOF_LogOSIE write FOF_LogOSIE;
    property OF_OSIEMinLin: Integer read FOF_OSIEMinLin write FOF_OSIEMinLin;
    property OF_ScanIEPath: String read FOF_ScanIEPath write FOF_ScanIEPath;
    property OF_ScanIEDiv: Integer read FOF_ScanIEDiv write FOF_ScanIEDiv;
    property OF_ScanACPath: String read FOF_ScanACPath write FOF_ScanACPath;
    property OF_ScanACDiv: Integer read FOF_ScanACDiv write FOF_ScanACDiv;

    // [OF_LG] Oficina do Frio - ATecnica - Instalações LG
    property OF_LGGrp1: Integer read FOF_LGGrp1 write FOF_LGGrp1;
    property OF_LGGrp2: Integer read FOF_LGGrp2 write FOF_LGGrp2;
    property OF_LGGrp3: Integer read FOF_LGGrp3 write FOF_LGGrp3;
    property OF_LGGrp4: Integer read FOF_LGGrp4 write FOF_LGGrp4;
    property OF_LGMar1: Integer read FOF_LGMar1 write FOF_LGMar1;
    property OF_LGMar2: Integer read FOF_LGMar2 write FOF_LGMar2;

    // [OF_OSEspecial]   Oficina do Frio - Especial Magazine Luiza
    property OF_LPreco: Integer read FOF_LPreco write FOF_LPreco;
    property OF_OSEspCliente: String read FOF_OSEspCliente
      write FOF_OSEspCliente;
    property OF_OSEspComss: Real read FOF_OSEspComss write FOF_OSEspComss;
    property OF_PrazoPadrao: Integer read FOF_PrazoPadrao write FOF_PrazoPadrao;
    property OF_PlanilhaPadrao: String read FOF_PlanilhaPadrao
      write FOF_PlanilhaPadrao;
    property OF_Prestador: String read FOF_Prestador write FOF_Prestador;
    property OF_OSEspCFOPDev: Integer read FOF_OSEspCFOPDev
      write FOF_OSEspCFOPDev;
    property OF_OSEspCadas: Integer read FOF_OSEspCadas write FOF_OSEspCadas;
    property OF_OSEspEmpFil: Integer read FOF_OSEspEmpFil write FOF_OSEspEmpFil;
    property OF_OSEspTeste: Boolean read FOF_OSEspTeste write FOF_OSEspTeste;

    // [OF_VendedorAC]  Oficina do Frio - Vendedores
    property OF_ACVend01: String read FOF_ACVend01 write FOF_ACVend01;
    property OF_ACVend02: String read FOF_ACVend02 write FOF_ACVend02;
    property OF_ACVend03: String read FOF_ACVend03 write FOF_ACVend03;
    property OF_ACVend04: String read FOF_ACVend04 write FOF_ACVend04;
    property OF_ACVend05: String read FOF_ACVend05 write FOF_ACVend05;
    property OF_ACCodV01: Integer read FOF_ACCodV01 write FOF_ACCodV01;
    property OF_ACCodV02: Integer read FOF_ACCodV02 write FOF_ACCodV02;
    property OF_ACCodV03: Integer read FOF_ACCodV03 write FOF_ACCodV03;
    property OF_ACCodV04: Integer read FOF_ACCodV04 write FOF_ACCodV04;
    property OF_ACCodV05: Integer read FOF_ACCodV05 write FOF_ACCodV05;

    //
    property EP_Ins1: Integer read FEP_Ins1 write FEP_Ins1;
    property EP_Ins2: Integer read FEP_Ins2 write FEP_Ins2;
    property EP_Ins3: Integer read FEP_Ins3 write FEP_Ins3;
    property EP_Ins4: Integer read FEP_Ins4 write FEP_Ins4;
    property EP_Ins5: Integer read FEP_Ins5 write FEP_Ins5;
    property EP_Valorizacao: Integer read FEP_Valorizacao write FEP_Valorizacao;
    property EP_DiasCalculo: Integer read FEP_DiasCalculo write FEP_DiasCalculo;
    property EP_DecQtd: Integer read FEP_DecQtd write FEP_DecQtd;
    property EP_DecVlr: Integer read FEP_DecVlr write FEP_DecVlr;

    // [EnvioXMLDanfe]
    property EnvNFE_PathDestino: String read FEnvNFE_PathDestino
      write FEnvNFE_PathDestino;
    property EnvNFE_Envio: String read FEnvNFE_Envio write FEnvNFE_Envio;
    property EnvNFE_Arquivos: String read FEnvNFE_Arquivos
      write FEnvNFE_Arquivos;
    property EnvNFE_Compressao: String read FEnvNFE_Compressao
      write FEnvNFE_Compressao;
    property EnvNFE_Destinatario: String read FEnvNFE_Destinatario
      write FEnvNFE_Destinatario;

    // Padrão afiliações - cartões / pagtos mistos
    property PadraoCredito: Integer read FPadraoCredito write FPadraoCredito;
    property PadraoDebito: Integer read FPadraoDebito write FPadraoDebito;

    // Links
    property PathWAEnvio: String read FPathWAEnvio write FPathWAEnvio;
    property LinksUtiliza: Boolean read FLinksUtiliza write FLinksUtiliza;
    property LinkSPC: String read FLinkSPC write FLinkSPC;
    property LinkSINTEGRA: String read FLinkSINTEGRA write FLinkSINTEGRA;
    property LinkSeFazRS: String read FLinkSeFazRS write FLinkSeFazRS;
    property DadosSeFaz: Boolean read FDadosSeFaz write FDadosSeFaz;

    // [FastFood]
    property FFood_Modulos: String read FFFood_Modulos write FFFood_Modulos;
    property FFood_Configura: Boolean read FFFood_Configura
      write FFFood_Configura;
    property FFood_UsaFluxos: Boolean read FFFood_UsaFluxos
      write FFFood_UsaFluxos;
    property FFood_LstSenha: Boolean read FFFood_LstSenha write FFFood_LstSenha;
    property FFood_TamSenha: Integer read FFFood_TamSenha write FFFood_TamSenha;
    property FFood_LstObserv: Boolean read FFFood_LstObserv
      write FFFood_LstObserv;
    property FFood_IniciaTurno: Boolean read FFFood_IniciaTurno
      write FFFood_IniciaTurno;
    property FFood_CaixaNr: String read FFFood_CaixaNr write FFFood_CaixaNr;
    property FFood_LPPadrao: Integer read FFFood_LPPadrao write FFFood_LPPadrao;
    property FFood_NomeObrig: Boolean read FFFood_NomeObrig
      write FFFood_NomeObrig;
    property FFood_Cadastro: Boolean read FFFood_Cadastro write FFFood_Cadastro;
    property FFood_Desconto: Boolean read FFFood_Desconto write FFFood_Desconto;
    property FFood_DescAutom: Boolean read FFFood_DescAutom
      write FFFood_DescAutom;
    property FFood_Imprime_Cli: Integer read FFFood_Imprime_Cli
      write FFFood_Imprime_Cli;
    property FFood_Imprime_Int: Integer read FFFood_Imprime_Int
      write FFFood_Imprime_Int;
    property FFood_Emite_CF: Integer read FFFood_Emite_CF write FFFood_Emite_CF;
    property FFood_Emite_CFTele: Integer read FFFood_Emite_CFTele
      write FFFood_Emite_CFTele;
    property FFood_Preview: Boolean read FFFood_Preview write FFFood_Preview;
    property FFood_PrintDialog: Boolean read FFFood_PrintDialog
      write FFFood_PrintDialog;
    property FFood_PrinterId: String read FFFood_PrinterId
      write FFFood_PrinterId;
    property FFood_ViasBalMesa: Integer read FFFood_ViasBalMesa
      write FFFood_ViasBalMesa;
    property FFood_ViasTele: Integer read FFFood_ViasTele write FFFood_ViasTele;
    property FFood_ComplMesa: Boolean read FFFood_ComplMesa
      write FFFood_ComplMesa;
    property FFood_CancPedido: Boolean read FFFood_CancPedido
      write FFFood_CancPedido;
    property FFood_Exportacao: Boolean read FFFood_Exportacao
      write FFFood_Exportacao;
    property FFood_Cab01: String read FFFood_Cab01 write FFFood_Cab01;
    property FFood_Cab02: String read FFFood_Cab02 write FFFood_Cab02;
    property FFood_Cab03: String read FFFood_Cab03 write FFFood_Cab03;
    property FFood_Cab04: String read FFFood_Cab04 write FFFood_Cab04;
    property FFood_LogoPrint: String read FFFood_LogoPrint
      write FFFood_LogoPrint;
    property FFood_LogoCozin: String read FFFood_LogoCozin
      write FFFood_LogoCozin;
    property FFood_AvFinal: Integer read FFFood_AvFinal write FFFood_AvFinal;
    property FFood_SenConfig: String read FFFood_SenConfig
      write FFFood_SenConfig;
    property FFood_Cad_Obsrv: String read FFFood_Cad_Obsrv
      write FFFood_Cad_Obsrv;
    property FFood_Cad_Aglut: String read FFFood_Cad_Aglut
      write FFFood_Cad_Aglut;
    property FFood_Cad_Fecha: String read FFFood_Cad_Fecha
      write FFFood_Cad_Fecha;
    property FFood_Cad_EmPag: String read FFFood_Cad_EmPag
      write FFFood_Cad_EmPag;
    property FFood_Cad_Relac: String read FFFood_Cad_Relac
      write FFFood_Cad_Relac;
    property FFood_ECFS_Nome: String read FFFood_ECFS_Nome
      write FFFood_ECFS_Nome;
    property FFood_ECFS_Descr: String read FFFood_ECFS_Descr
      write FFFood_ECFS_Descr;
    property FFood_ECFS_CodProd: String read FFFood_ECFS_CodProd
      write FFFood_ECFS_CodProd;
    property FFood_ECFS_Foco: Integer read FFFood_ECFS_Foco
      write FFFood_ECFS_Foco;
    property FFood_ECFS_VlRec: Integer read FFFood_ECFS_VlRec
      write FFFood_ECFS_VlRec;
    property FFood_ECFS_TimeOut: Integer read FFFood_ECFS_TimeOut
      write FFFood_ECFS_TimeOut;
    property FFood_ECFS_Valores: Integer read FFFood_ECFS_Valores
      write FFFood_ECFS_Valores;
    property FFood_Aliq25: String read FFFood_Aliq25 write FFFood_Aliq25;
    property FFood_Aliq18: String read FFFood_Aliq18 write FFFood_Aliq18;
    property FFood_Aliq17: String read FFFood_Aliq17 write FFFood_Aliq17;
    property FFood_Aliq12: String read FFFood_Aliq12 write FFFood_Aliq12;
    property FFood_Aliq07: String read FFFood_Aliq07 write FFFood_Aliq07;
    property FFood_Aliq04: String read FFFood_Aliq04 write FFFood_Aliq04;
    property FFood_CFOP: String read FFFood_CFOP write FFFood_CFOP;
    property FFood_NCM: String read FFFood_NCM write FFFood_NCM;
    property FFood_NDAvanco: Integer read FFFood_NDAvanco write FFFood_NDAvanco;
    property FFood_TotTrib: Integer read FFFood_TotTrib write FFFood_TotTrib;
    property FFood_RAW: Boolean read FFFood_RAW write FFFood_RAW;
    property FFood_Cab1RAW: String read FFFood_Cab1RAW write FFFood_Cab1RAW;
    property FFood_Cab2RAW: String read FFFood_Cab2RAW write FFFood_Cab2RAW;
    property FFood_Cab3RAW: String read FFFood_Cab3RAW write FFFood_Cab3RAW;
    property FFood_Cab4RAW: String read FFFood_Cab4RAW write FFFood_Cab4RAW;
    property FFood_IdPedRAW: String read FFFood_IdPedRAW write FFFood_IdPedRAW;
    property FFood_DescrUnica: String read FFFood_DescrUnica
      write FFFood_DescrUnica;
    property FFood_CodUnica: String read FFFood_CodUnica write FFFood_CodUnica;
    property FFood_DescrSTItens: String read FFFood_DescrSTItens
      write FFFood_DescrSTItens;
    property FFood_CodSTItens: String read FFFood_CodSTItens
      write FFFood_CodSTItens;
    property FFood_DescrItens: String read FFFood_DescrItens
      write FFFood_DescrItens;
    property FFood_CodItens: String read FFFood_CodItens write FFFood_CodItens;
    property FFood_PedRelacNFe: Boolean read FFFood_PedRelacNFe
      write FFFood_PedRelacNFe;
    property FFood_PedUsoNFe: Boolean read FFFood_PedUsoNFe
      write FFFood_PedUsoNFe;
    property FFood_VisDANFE: Boolean read FFFood_VisDANFE write FFFood_VisDANFE;
    property FFood_NFePrinter: String read FFFood_NFePrinter
      write FFFood_NFePrinter;
    property FFood_AvExtra: Integer read FFFood_AvExtra write FFFood_AvExtra;
    property FFood_IniBalcao: Integer read FFFood_IniBalcao
      write FFFood_IniBalcao;
    property FFood_FinBalcao: Integer read FFFood_FinBalcao
      write FFFood_FinBalcao;
    property FFood_TicketSimples: Boolean read FFFood_TicketSimples
      write FFFood_TicketSimples;
    property FFood_TransFinal: Boolean read FFFood_TransFinal
      write FFFood_TransFinal;
    property FFood_Kiosk: Boolean read FFFood_Kiosk write FFFood_Kiosk;
    property FFood_PathIntegr: String read FFFood_PathIntegr
      write FFFood_PathIntegr;
    property FFood_KioskCoord: Boolean read FFFood_KioskCoord
      write FFFood_KioskCoord;
    property FFood_KioskMaxProd: Integer read FFFood_KioskMaxProd
      write FFFood_KioskMaxProd;
    property FFood_KioskMaxItens: Integer read FFFood_KioskMaxItens
      write FFFood_KioskMaxItens;
    property FFood_CaixaUnico: Boolean read FFFood_CaixaUnico
      write FFFood_CaixaUnico;
    property FFood_CaixaPathId: String read FFFood_CaixaPathId
      write FFFood_CaixaPathId;

    // NFeRvCar
    property RvCar_ImgFundo: String read FRvCar_ImgFundo write FRvCar_ImgFundo;
    property RvCar_ImgLogo: String read FRvCar_ImgLogo write FRvCar_ImgLogo;
    property RvCar_Inf0: String read FRvCar_Inf0 write FRvCar_Inf0;
    property RvCar_Inf1: String read FRvCar_Inf1 write FRvCar_Inf1;
    property RvCar_Inf2: String read FRvCar_Inf2 write FRvCar_Inf2;
    property RvCar_Inf3: String read FRvCar_Inf3 write FRvCar_Inf3;
    property RvCar_Inf4: String read FRvCar_Inf4 write FRvCar_Inf4;
    property RvCar_Inf5: String read FRvCar_Inf5 write FRvCar_Inf5;
    property RvCar_Inf6: String read FRvCar_Inf6 write FRvCar_Inf6;
    property RvCar_Inf7: String read FRvCar_Inf7 write FRvCar_Inf7;
    property RvCar_Inf8: String read FRvCar_Inf8 write FRvCar_Inf8;
    property RvCar_Inf9: String read FRvCar_Inf9 write FRvCar_Inf9;
    property RvCar_Tag0: String read FRvCar_Tag0 write FRvCar_Tag0;
    property RvCar_Tag1: String read FRvCar_Tag1 write FRvCar_Tag1;
    property RvCar_Tag2: String read FRvCar_Tag2 write FRvCar_Tag2;
    property RvCar_Tag3: String read FRvCar_Tag3 write FRvCar_Tag3;
    property RvCar_Tag4: String read FRvCar_Tag4 write FRvCar_Tag4;
    property RvCar_Tag5: String read FRvCar_Tag5 write FRvCar_Tag5;
    property RvCar_Tag6: String read FRvCar_Tag6 write FRvCar_Tag6;
    property RvCar_Tag7: String read FRvCar_Tag7 write FRvCar_Tag7;
    property RvCar_Tag8: String read FRvCar_Tag8 write FRvCar_Tag8;
    property RvCar_Tag9: String read FRvCar_Tag9 write FRvCar_Tag9;

    property RvCar_ModoNFe: Integer read FRvCar_ModoNFe write FRvCar_ModoNFe;
    property RvCar_Encad: Integer read FRvCar_Encad write FRvCar_Encad;
    property RvCar_VerNFe: String read FRvCar_VerNFe write FRvCar_VerNFe;
    property RvCar_ExeNFe: String read FRvCar_ExeNFe write FRvCar_ExeNFe;
    property RvCar_TimeOut: Integer read FRvCar_TimeOut write FRvCar_TimeOut;
    property RvCar_HrVerao: Boolean read FRvCar_HrVerao write FRvCar_HrVerao;
    property RvCar_HVIni: TDateTime read FRvCar_HVIni write FRvCar_HVIni;
    property RvCar_HVFin: TDateTime read FRvCar_HVFin write FRvCar_HVFin;
    property RvCar_PathCfg: String read FRvCar_PathCfg write FRvCar_PathCfg;
    property RvCar_ModBC: Integer read FRvCar_ModBC write FRvCar_ModBC;
    property RvCar_ModBCST: Integer read FRvCar_ModBCST write FRvCar_ModBCST;
    property RvCar_UsaFCP: Boolean read FRvCar_UsaFCP write FRvCar_UsaFCP;
    property RvCar_DigRenavam: Integer read FRvCar_DigRenavam
      write FRvCar_DigRenavam;
    property RvCar_ValRenavam: Boolean read FRvCar_ValRenavam
      write FRvCar_ValRenavam;
    property RvCar_MC5464: Boolean read FRvCar_MC5464 write FRvCar_MC5464;
    property RvCar_NVE: String read FRvCar_NVE write FRvCar_NVE;
    property RvCar_CEST: String read FRvCar_CEST write FRvCar_CEST;
    property RvCar_cBenef: String read FRvCar_cBenef write FRvCar_cBenef;
    property RvCar_CFOPVendaUF: Integer read FRvCar_CFOPVendaUF
      write FRvCar_CFOPVendaUF;
    property RvCar_CFOPDevolUF: Integer read FRvCar_CFOPDevolUF
      write FRvCar_CFOPDevolUF;
    property RvCar_CFOPEntraUF: Integer read FRvCar_CFOPEntraUF
      write FRvCar_CFOPEntraUF;
    property RvCar_CFOPVendaOUF: Integer read FRvCar_CFOPVendaOUF
      write FRvCar_CFOPVendaOUF;
    property RvCar_CFOPDevolOUF: Integer read FRvCar_CFOPDevolOUF
      write FRvCar_CFOPDevolOUF;
    property RvCar_CFOPEntraOUF: Integer read FRvCar_CFOPEntraOUF
      write FRvCar_CFOPEntraOUF;

    // Consignações
    property Csg1_Empresa: Integer read FCsg1_Empresa write FCsg1_Empresa;
    property Csg1_QtdLct: Boolean read FCsg1_QtdLct write FCsg1_QtdLct;
    property Csg1_EstNeg: Boolean read FCsg1_EstNeg write FCsg1_EstNeg;
    property Csg1_AltPreco: Boolean read FCsg1_AltPreco write FCsg1_AltPreco;
    property Csg1_Campo: Integer read FCsg1_Campo write FCsg1_Campo;
    property Csg1_StopVTotal: Boolean read FCsg1_StopVTotal
      write FCsg1_StopVTotal;
    property Csg1_RepItem: Boolean read FCsg1_RepItem write FCsg1_RepItem;
    property Csg1_Consolid: Boolean read FCsg1_Consolid write FCsg1_Consolid;
    property Csg1_Logo10x7: String read FCsg1_Logo10x7 write FCsg1_Logo10x7;
    property Csg1_LstSitu: Boolean read FCsg1_LstSitu write FCsg1_LstSitu;
    property Csg1_TpDoc: Integer read FCsg1_TpDoc write FCsg1_TpDoc;

    // Mecanico
    property MecChassi: Boolean read FMecChassi write FMecChassi;
    property MecRenavam: Boolean read FMecRenavam write FMecRenavam;

  published

  end;

  TFuIniGeral = class(TForm)
    IniMemo: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    wInicial: TInicializa;
    appPath, appName, appUser, appAcessos, appOperPath: String;
    appHelpFile: String;
    appDebug: Boolean;
    appWMax, appHMax: Integer;
    eMail_Dest, eMail_Assunto: String;
    decForm: array [0 .. 4] of String;
    txtCondPagto: array [0 .. 18] of String;
    txtCPagAbrev: array [0 .. 18] of String;
    strCondPagto: String;
    maxCondPagto: Integer;
    txtTrFiscal: array [0 .. 12] of String;
    txtMsgEnvio: TStringList;

  end;

var
  FuIniGeral: TFuIniGeral;

implementation

uses uGenericas;

{$R *.DFM}

Procedure FormataArquivoIni(pArqIniName: String);
var
  TIniList, TFinList: TStringList;
  wLinha: String;
  i: Integer;
begin
  TIniList := TStringList.Create;
  TFinList := TStringList.Create;
  TIniList.LoadFromFile(pArqIniName);
  for i := 0 to TIniList.Count - 1 do
  begin
    wLinha := TIniList.Strings[i];
    if (i > 0) and (Pos('[', wLinha) = 1) then
      TFinList.Add('');
    TFinList.Add(wLinha);
  end;
  TFinList.SaveToFile(pArqIniName);
  TIniList.Free;
  TFinList.Free;

end;

Procedure Gera_IniEstacao(pmtNomeArq: String);
var
  wIni: TIniFile;
begin
  wIni := TIniFile.Create(pmtNomeArq);
  wIni.WriteString('Conexao', 'IdEstacao', 'ESTACAO1');
  wIni.Free;

end;

Procedure Gera_IniGeral(pmtNomeArq: String);
var
  wIni: TIniFile;
begin
  wIni := TIniFile.Create(pmtNomeArq);
  wIni.WriteString('Identificacao', 'Sistema', 'SISV');
  wIni.Free;

end;

Procedure Inicializacao_Simples(pSalvaForm: Boolean = False);
begin
  FormatSettings.DecimalSeparator := ',';
  FuIniGeral.wInicial := TInicializa.Create;
  FuIniGeral.wInicial.SalvaForm := pSalvaForm; // False;
  FuIniGeral.wInicial.EMEMailDest := '';
  FuIniGeral.wInicial.EMAssunto := '';
  FuIniGeral.wInicial.EMNomeDest := '';
  FuIniGeral.wInicial.EMEnviado := False;
  FuIniGeral.wInicial.SeparadorDecimal := ',';
  FuIniGeral.wInicial.SysDtMinima := StrToDate('01/01/1900');
  if not Assigned(FuIniGeral.txtMsgEnvio) then
    FuIniGeral.txtMsgEnvio := TStringList.Create;

end;

Procedure Inicializacao(pModulos: String = ''; pIniEstacao: String = '');
var
  wIniName: String;
  wIni: TIniFile;
  lpBuffer: Array [0 .. 20] of Char;
  nSize: dWord;
  wAchou: Boolean;
  cNome: PChar;
  wAux: String;
begin
  FormatSettings.DecimalSeparator := ',';
  FuIniGeral.txtCondPagto[0] := '0 - À vista (R$)';
  FuIniGeral.txtCondPagto[1] := '1 - À vista (Cheque)';
  FuIniGeral.txtCondPagto[2] := '2 - Cartão de crédito'; // a vista
  FuIniGeral.txtCondPagto[3] := '3 - Cartão de crédito - Parcelado';
  FuIniGeral.txtCondPagto[4] := '4 - Crediário';
  FuIniGeral.txtCondPagto[5] := '5 - Parcelamento - Cobrança';
  FuIniGeral.txtCondPagto[6] := '6 - Cheque - (Parcelado/Pré)';
  FuIniGeral.txtCondPagto[7] := '7 - Faturamento mensal';
  FuIniGeral.txtCondPagto[8] := '8 - Sem cobrança';
  FuIniGeral.txtCondPagto[9] := '9 - Antecipado';
  FuIniGeral.txtCondPagto[10] := 'D - Cartão de Débito';
  FuIniGeral.txtCondPagto[11] := 'P - PIX';
  FuIniGeral.txtCondPagto[12] := 'Z - Parcelado Juros ZERO';
  FuIniGeral.txtCondPagto[13] := 'C - Crediário Juros ZERO';
  FuIniGeral.txtCondPagto[14] := 'Y - C.Crédito Parc Juros ZERO';
  FuIniGeral.txtCondPagto[15] := 'V - À vista MISTO (R$/Cart/PIX)';
  FuIniGeral.txtCondPagto[16] := 'T - Conta corrente';
  FuIniGeral.txtCondPagto[17] := 'B - Transf/Depósito bancário';
  FuIniGeral.txtCondPagto[18] := '? - Inválido';
  FuIniGeral.maxCondPagto := Length(FuIniGeral.txtCondPagto) - 2;

  FuIniGeral.txtCPagAbrev[0] := 'R$';
  FuIniGeral.txtCPagAbrev[1] := 'Chq AV';
  FuIniGeral.txtCPagAbrev[2] := 'CCred'; // a vista
  FuIniGeral.txtCPagAbrev[3] := 'CCr Pc';
  FuIniGeral.txtCPagAbrev[4] := 'Crediar';
  FuIniGeral.txtCPagAbrev[5] := 'Cobr Pc';
  FuIniGeral.txtCPagAbrev[6] := 'Chq Pre';
  FuIniGeral.txtCPagAbrev[7] := 'FatMens';
  FuIniGeral.txtCPagAbrev[8] := 'S/Cobr';
  FuIniGeral.txtCPagAbrev[9] := 'Antecip';
  FuIniGeral.txtCPagAbrev[10] := 'C Deb';
  FuIniGeral.txtCPagAbrev[11] := 'PIX';
  FuIniGeral.txtCPagAbrev[12] := 'ParcJ0';
  FuIniGeral.txtCPagAbrev[13] := 'CredJ0';
  FuIniGeral.txtCPagAbrev[14] := 'CCrJ0';
  FuIniGeral.txtCPagAbrev[15] := 'AV Esp';
  FuIniGeral.txtCPagAbrev[16] := 'C.Corr';
  FuIniGeral.txtCPagAbrev[17] := 'Tr/Dp Ban';
  FuIniGeral.txtCPagAbrev[18] := 'Inval';
  FuIniGeral.strCondPagto := '0123456789DPZCYVTB_';
  //
  FuIniGeral.txtTrFiscal[0] := 'Pendente';
  FuIniGeral.txtTrFiscal[1] := 'DFi'; // CF
  FuIniGeral.txtTrFiscal[2] := 'NF';
  FuIniGeral.txtTrFiscal[3] := 'DFi'; // CF + NF
  FuIniGeral.txtTrFiscal[4] := 'Cancelado';
  FuIniGeral.txtTrFiscal[5] := 'DFi Cancel';
  FuIniGeral.txtTrFiscal[6] := 'NF Cancel';
  FuIniGeral.txtTrFiscal[7] := 'DFi Cancel';
  FuIniGeral.txtTrFiscal[8] := 'Doc Interno';
  FuIniGeral.txtTrFiscal[9] := '9-Inval';
  FuIniGeral.txtTrFiscal[10] := '10-Inval';
  FuIniGeral.txtTrFiscal[11] := '11-Inval';
  FuIniGeral.txtTrFiscal[12] := '12-DI Canc';
  //
  if not Assigned(FuIniGeral.txtMsgEnvio) then
    FuIniGeral.txtMsgEnvio := TStringList.Create;
  //
  FuIniGeral.wInicial := TInicializa.Create;
  // .ini de conexão e identificação dos parametros gerais do sistema  (Estacao.ini)
  if Length(Trim(pIniEstacao)) > 0 then
    wIniName := pIniEstacao
  else
    wIniName := FuIniGeral.appPath + 'Estacao.ini';

  // ShowMessage('Ini Local=' + wIniName);
  if not SysUtils.FileExists(wIniName) then
    Gera_IniEstacao(wIniName);
  wIni := TIniFile.Create(wIniName);
  with FuIniGeral do
  begin
    wInicial.SysPath := AjustaPathBarraFinal
      (ExtractFilePath(Application.ExeName), True);
    // [Conexao]
    wInicial.IdEstacao := wIni.ReadString('Conexao', 'IdEstacao', 'ESTACAO999');
    wInicial.DriveRemoto := wIni.ReadString('Conexao', 'Drive', 'C:');
    if Pos('LOCAL', AnsiUpperCase(wInicial.DriveRemoto)) > 0 then
      wInicial.DriveRemoto := 'C:';
    wInicial.Caminho := wIni.ReadString('Conexao', 'Path', '');
    wInicial.Senha := wIni.ReadString('Conexao', 'Senha', '');
    if wIni.ReadString('Conexao', 'Desconecta', 'N') = 'S' then
      wInicial.Desconecta := True
    else
      wInicial.Desconecta := False;

    wInicial.Usuario := wIni.ReadString('Conexao', 'Usuario', '');
    if Length(Trim(wInicial.Usuario)) = 0 then
      wInicial.Usuario := appUser;
    if Length(Trim(wInicial.Usuario)) = 0 then
      wInicial.Usuario := 'NoUser';

    if wIni.ReadString('Conexao', 'SalvaForm', 'N') = 'S' then
      wInicial.SalvaForm := True
    else
      wInicial.SalvaForm := False;
    wInicial.ServClie := wIni.ReadString('Conexao', 'ServidorCliente', 'Serv');
    wInicial.FonteNome := wIni.ReadString('Conexao', 'FonteTexto',
      'Courier New');
    wInicial.FonteTam := wIni.ReadInteger('Conexao', 'FonteTam', 10);
    wInicial.ImagemFundo := wIni.ReadString('Conexao', 'ImagemFundo', '');

    // [Dados]
    wInicial.Parametros := wIni.ReadString('Dados', 'Parametros',
      appPath + 'Sisv.ini');
    wInicial.PathLocal := wIni.ReadString('Dados', 'PathLocal',
      appPath + 'Local');
    if not DirectoryExists(wInicial.PathLocal) then
      Try
        CreateDir(wInicial.PathLocal);
      Except
        MessageDlg('Falha - ' + wInicial.PathLocal, mtError, [mbOk], 0);
      End;
    wInicial.PathLocal := AjustaPathBarraFinal(wInicial.PathLocal, True);
    wInicial.ArqSaidaACNFe := wInicial.PathLocal + 'Saida_' +
      FuIniGeral.wInicial.NrEstacao + '.Txt'; // <----------------
    wInicial.PathRelatorios := wIni.ReadString('Dados', 'PathRelatorios',
      appPath + 'Rels');
    if not DirectoryExists(wInicial.PathRelatorios) then
      Try
        CreateDir(wInicial.PathRelatorios);
      Except
        MessageDlg('Falha - ' + wInicial.PathRelatorios, mtError, [mbOk], 0);
      End;
    wInicial.PathRelatorios := AjustaPathBarraFinal
      (wInicial.PathRelatorios, True);
    wInicial.LinPolegada := wIni.ReadInteger('Dados', 'LPP', 6);
    wInicial.PathEstacaoTrabalho := wIni.ReadString('Dados',
      'PathEstacaoTrabalho', appPath + 'WrkNFe');
    if not DirectoryExists(wInicial.PathEstacaoTrabalho) then
      Try
        CreateDir(wInicial.PathEstacaoTrabalho)
      Except
        MessageDlg('Falha - ' + wInicial.PathEstacaoTrabalho, mtError,
          [mbOk], 0);
      End;
    wInicial.PathEstacaoTrabalho := AjustaPathBarraFinal
      (wInicial.PathEstacaoTrabalho, True);
    wInicial.NrEstacao := wIni.ReadString('Dados', 'NrEstacao', '01');
    if wIni.ReadString('Dados', 'Debug', 'N') = 'S' then
      wInicial.LDebug := True
    else
      wInicial.LDebug := appDebug;
    if wIni.ReadString('Dados', 'DebugNFe', 'N') = 'S' then
      wInicial.LDebugNFe := True
    else
      wInicial.LDebugNFe := appDebug;
    if wIni.ReadString('Dados', 'SalvaParam', 'N') = 'S' then
      wInicial.LSalvaParam := True
    else
      wInicial.LSalvaParam := False;
    if wIni.ReadString('Dados', 'Suporte', 'N') = 'S' then
      wInicial.LSuporte := True
    else
      wInicial.LSuporte := False;
    if wIni.ReadString('Dados', 'DownLoadNFe', 'N') = 'S' then
      wInicial.LDownLoadNFe := True
    else
      wInicial.LDownLoadNFe := False;
    if wIni.ReadString('Dados', 'LeituraNFe', 'N') = 'S' then
      wInicial.LLeituraNFe := True
    else
      wInicial.LLeituraNFe := False;
    if wIni.ReadString('Dados', 'FluxoFinanceiro', 'N') = 'S' then
      wInicial.LFluxoFinanceiro := True
    else
      wInicial.LFluxoFinanceiro := False;
    if wIni.ReadString('Dados', 'QtdLPreco', 'N') = 'S' then
      wInicial.LExibQtdLPrecos := True
    else
      wInicial.LExibQtdLPrecos := False;
    if wIni.ReadString('Dados', 'GridLinDestaq', 'N') = 'S' then
      wInicial.LGridLinDestaq := True
    else
      wInicial.LGridLinDestaq := False;
    wInicial.CorLinDestaq :=
      StringToColor(wIni.ReadString('Dados', 'GridCorDestaq', '$00DFDF00'));
    wInicial.CorPrtDestaq :=
      StringToColor(wIni.ReadString('Dados', 'PrintCorDestaq', '$00E6E6E6'));
    wInicial.LinPrtDestaq := wIni.ReadInteger('Dados', 'PrintLinDestaq', 3);
    wInicial.CorHeaderDestaq :=
      StringToColor(wIni.ReadString('Dados', 'GridHeaderDestaq', '$00C1DDC1'));
    wInicial.CorColumnDestaq :=
      StringToColor(wIni.ReadString('Dados', 'GridColumnDestaq', '$00DADAD3'));
    wInicial.CorBoxDestaq := StringToColor(wIni.ReadString('Dados', 'BoxDestaq',
      '$00FCF7F3'));
    if wIni.ReadString('Dados', 'UsaEsquemaCores', 'N') = 'S' then
      wInicial.UsaEsquemaCores := True
    else
      wInicial.UsaEsquemaCores := False;
    if wIni.ReadString('Dados', 'ColunaNegrito', 'N') = 'S' then
      wInicial.ColunaNegrito := True
    else
      wInicial.ColunaNegrito := False;

    if wIni.ReadString('Dados', 'UsaWhatsApp', 'N') = 'S' then
    begin
      wInicial.UsaWhatsApp := True;
      wInicial.PathWhatsApp := wIni.ReadString('Dados', 'PathWhatsApp',
        'C:\WhatsApp\Envios');
    end
    else
    begin
      wInicial.UsaWhatsApp := False;
      wInicial.PathWhatsApp := '';
    end;
    wInicial.TamPagTerm := wIni.ReadInteger('Dados', 'TamPagTermica', 240);

    // [Pedidos]
    if wIni.ReadString('Pedidos', 'EmitePedidos', 'N') = 'S' then
      wInicial.EmitePedidos := True
    else
      wInicial.EmitePedidos := False;
    wInicial.ImpressoraPedidos := wIni.ReadString('Pedidos', 'Impressora',
      'Nenhuma');
    wInicial.ViasPedidos := wIni.ReadInteger('Pedidos', 'Vias', 1);
    if wIni.ReadString('Pedidos', 'Preview', 'N') = 'S' then
      wInicial.PreviewPedidos := True
    else
      wInicial.PreviewPedidos := False;
    if wIni.ReadString('Pedidos', 'Negrito', 'N') = 'S' then
      wInicial.PedidosNegrito := True
    else
      wInicial.PedidosNegrito := False;
    wInicial.MargemEsquerda := wIni.ReadInteger('Pedidos', 'MargemEsquerda', 3);
    wInicial.MargemDireita := wIni.ReadInteger('Pedidos', 'MargemDireita', 0);
    wInicial.PedidoLocal := wIni.ReadInteger('Pedidos', 'PedidoLocal', 0);

    // [CaixaLocal]
    if wIni.ReadString('CaixaLocal', 'Caixa', 'N') = 'S' then
      wInicial.CxLocal := True
    else
      wInicial.CxLocal := False;
    wInicial.CxLocalNro := wIni.ReadInteger('CaixaLocal', 'Numero', 0);
    wInicial.CxLocalEF := wIni.ReadInteger('CaixaLocal', 'EFPadrao', 1);
    wInicial.CxLocalTpImpress := wIni.ReadString('CaixaLocal',
      'TipoImpressao', 'Term');
    if wIni.ReadString('CaixaLocal', 'Preview', 'N') = 'S' then
      wInicial.CxLocalPreview := True
    else
      wInicial.CxLocalPreview := False;
    wInicial.CxLocalImpressora := wIni.ReadString('CaixaLocal', 'Impressora',
      'Nenhuma');
    wInicial.CxPathCaixa := AjustaPathBarraFinal(wIni.ReadString('CaixaLocal',
      'PathCaixa', '\Local\'), True);
    wInicial.CxPathExBalcao := AjustaPathBarraFinal
      (wIni.ReadString('CaixaLocal', 'PathExecBalcao', ''), True);
    wInicial.CxPathExGeren := AjustaPathBarraFinal(wIni.ReadString('CaixaLocal',
      'PathExecGeren', ''), True);

    if wIni.ReadString('CaixaLocal', 'CaixaExclusivo', 'N') = 'S' then
      wInicial.CxExclusivo := True
    else
      wInicial.CxExclusivo := False;
    if wIni.ReadString('CaixaLocal', 'Pedidos', 'N') = 'S' then
      wInicial.CxPedido := True
    else
      wInicial.CxPedido := False;
    if wIni.ReadString('CaixaLocal', 'NFElet', 'N') = 'S' then
      wInicial.CxNFElet := True
    else
      wInicial.CxNFElet := False;
    if wIni.ReadString('CaixaLocal', 'NFCons', 'N') = 'S' then
      wInicial.CxNFCons := True
    else
      wInicial.CxNFCons := False;
    if wIni.ReadString('CaixaLocal', 'NFServ', 'N') = 'S' then
      wInicial.CxNFServ := True
    else
      wInicial.CxNFServ := False;
    if wIni.ReadString('CaixaLocal', 'OperacoesDFe', 'N') = 'S' then
      wInicial.CxOperDFe := True
    else
      wInicial.CxOperDFe := False;
    if wIni.ReadString('CaixaLocal', 'FatMensal', 'N') = 'S' then
      wInicial.CxFatMens := True
    else
      wInicial.CxFatMens := False;
    if wIni.ReadString('CaixaLocal', 'CancelaOper', 'N') = 'S' then
      wInicial.CxCancOper := True
    else
      wInicial.CxCancOper := False;
    if wIni.ReadString('CaixaLocal', 'ExclueOper', 'N') = 'S' then
      wInicial.CxExclOper := True
    else
      wInicial.CxExclOper := False;
    if wIni.ReadString('CaixaLocal', 'NovaOper', 'N') = 'S' then
      wInicial.CxNovaOper := True
    else
      wInicial.CxNovaOper := False;
    wInicial.CxTpOper := wIni.ReadInteger('CaixaLocal', 'TipoOper', 1);
    if wIni.ReadString('CaixaLocal', 'AlteraOper', 'N') = 'S' then
      wInicial.CxAltOper := True
    else
      wInicial.CxAltOper := False;
    if wIni.ReadString('CaixaLocal', 'OrdemServico', 'N') = 'S' then
      wInicial.CxOrdServ := True
    else
      wInicial.CxOrdServ := False;
    wInicial.CxCondPagto := wIni.ReadString('CaixaLocal', 'CondPagto',
      '012356DPZ');
    wInicial.CxFazTroco := SN_Boolean(wIni.ReadString('CaixaLocal',
      'FazTroco', 'N'));
    wInicial.CxExibeOrcam := SN_Boolean(wIni.ReadString('CaixaLocal',
      'ExibeOrcam', 'N'));
    wInicial.CxTempoMsg := wIni.ReadInteger('CaixaLocal', 'TempoExib', 30);
    wInicial.CxDocInterno := SN_Boolean(wIni.ReadString('CaixaLocal',
      'DocInterno', 'N'));
    wInicial.CxViasDocInt := wIni.ReadInteger('CaixaLocal',
      'ViasDocInterno', 1);
    wInicial.CxDocCobranca :=
      SN_Boolean(wIni.ReadString('CaixaLocal', 'DocCobranca', 'N'));
    wInicial.CxTipoCobranca := wIni.ReadInteger('CaixaLocal',
      'TipoCobranca', 0);
    wInicial.CxDocAutom := SN_Boolean(wIni.ReadString('CaixaLocal',
      'DocAutomatico', 'N'));
    wInicial.CxRecebimentos :=
      SN_Boolean(wIni.ReadString('CaixaLocal', 'Recebimentos', 'N'));
    wInicial.CxTimer := SN_Boolean(wIni.ReadString('CaixaLocal',
      'TimerAviso', 'N'));
    wInicial.CxTempoTimer := wIni.ReadInteger('CaixaLocal', 'TempoAviso', 30);
    wInicial.CxConfCtrlX := SN_Boolean(wIni.ReadString('CaixaLocal',
      'ConfirmaDocX', 'S'));
    wInicial.CxDescAdic := SN_Boolean(wIni.ReadString('CaixaLocal',
      'DescAdicional', 'S'));
    wInicial.CxCCorrCliente :=
      SN_Boolean(wIni.ReadString('CaixaLocal', 'CCorrCliente', 'N'));
    wInicial.CxUltimoReg := SN_Boolean(wIni.ReadString('CaixaLocal',
      'UltimoRegistro', 'S'));
    wInicial.CxSitOperIni := wIni.ReadInteger('CaixaLocal',
      'SituacaoInicial', 0);
    wInicial.CxCancelCartao :=
      SN_Boolean(wIni.ReadString('CaixaLocal', 'CancelaCartao', 'N'));
    wInicial.CxLcts := wIni.ReadInteger('CaixaLocal', 'Lancamentos', 0);
    wInicial.CxFech := SN_Boolean(wIni.ReadString('CaixaLocal',
      'LstFecham', 'N'));
    wInicial.CxAten := SN_Boolean(wIni.ReadString('CaixaLocal',
      'LstAtend', 'N'));
    wInicial.CxTimerDtHr := SN_Boolean(wIni.ReadString('CaixaLocal',
      'TimerDataHora', 'N'));

    // [Gerenciador]
    wInicial.GerNotasFiscais := wIni.ReadString('Gerenciador', 'NotasFiscais',
      'ESC'); // 'E'letronica, 'S'erviço, 'C'onsumidor, 'P'apel
    wInicial.GerNotasBenef := wIni.ReadString('Gerenciador', 'NotasBenef',
      '12'); // Mod. 1, 2 (Ctle)
    wInicial.GerAlternaDados :=
      SN_Boolean(wIni.ReadString('Gerenciador', 'AlternaDados', 'N'));
    wInicial.GerReplicaDados :=
      SN_Boolean(wIni.ReadString('Gerenciador', 'ReplicaDados', 'N'));
    wInicial.GerOrdemInicial := wIni.ReadInteger('Gerenciador', 'Ordem', 0);
    if wInicial.GerOrdemInicial > 4 then
      wInicial.GerOrdemInicial := 0; // Nr.Operacao
    wInicial.GerEnvioXMLDanfe := wIni.ReadString('Gerenciador',
      'EnvioXMLDanfe', '');
    wInicial.GerEstCadastro :=
      SN_Boolean(wIni.ReadString('Gerenciador', 'EstCadas', 'S'));
    wInicial.GerEstMovimentacao :=
      SN_Boolean(wIni.ReadString('Gerenciador', 'EstMovto', 'N'));
    wInicial.GerEstRegistro :=
      SN_Boolean(wIni.ReadString('Gerenciador', 'EstRegis', 'N'));
    wInicial.GerServicos := SN_Boolean(wIni.ReadString('Gerenciador',
      'Servicos', 'N'));
    wInicial.GerAtualizaData :=
      SN_Boolean(wIni.ReadString('Gerenciador', 'AtualizaData', 'N'));
    wInicial.GerViasNFCe := wIni.ReadInteger('Gerenciador', 'ViasNFCe', 1);
    wInicial.GerAtlzEstoques :=
      SN_Boolean(wIni.ReadString('Gerenciador', 'AtualizaEstoques', 'N'));
    wInicial.GerBolPrinterLocal :=
      SN_Boolean(wIni.ReadString('Gerenciador', 'BoletoPrtLocal', 'N'));
    wInicial.GerBolIdPrinterLocal := wIni.ReadString('Gerenciador',
      'BoletoIdPrtLocal', '');
    wInicial.GerBolPreview := SN_Boolean(wIni.ReadString('Gerenciador',
      'BoletoPreview', 'N'));
    wInicial.GerUsaDLL := SN_Boolean(wIni.ReadString('Gerenciador',
      'UsaDLL', 'S'));
    wInicial.GerTEFPOS := wIni.ReadInteger('Gerenciador', 'UsoTEFPOS', 0);
    wInicial.GerIdTerminal := wIni.ReadString('Gerenciador', 'IdTerminal',
      'Term00');
    wInicial.GerValParcMin := wIni.ReadFloat('Gerenciador', 'ValParcMin', 5);

    // [Balcao]
    wInicial.BalcaoPgmOS1 := wIni.ReadString('Balcao', 'PgmOS1', '');
    wInicial.BalcaoPgmOS2 := wIni.ReadString('Balcao', 'PgmOS2', '');
    wInicial.BalcaoPgmOS3 := wIni.ReadString('Balcao', 'PgmOS3', '');
    wInicial.BalcaoCondPagto :=
      SN_Boolean(wIni.ReadString('Balcao', 'CondPagto', 'N'));
    wInicial.BalcaoFreteVlrAdic :=
      SN_Boolean(wIni.ReadString('Balcao', 'FreteVlrAdic', 'N'));
    wInicial.BalcaoEmiteDFeDInt :=
      SN_Boolean(wIni.ReadString('Balcao', 'EmiteDFeDInt', 'N'));
    wInicial.BalcaoAtualizaCaixa :=
      SN_Boolean(wIni.ReadString('Balcao', 'AtualizaCaixa', 'N'));
    wInicial.SeparadorDecimal := wIni.ReadString('Balcao', 'SeparadorDecimal',
      FormatSettings.DecimalSeparator);
    // FormatSettings.DecimalSeparator (Delphi 10)
    wInicial.AvancoEnter :=
      SN_Boolean(wIni.ReadString('Balcao', 'AvancoEnter', 'N'));
    wInicial.SaltaTrib := SN_Boolean(wIni.ReadString('Balcao',
      'SaltaTrib', 'N'));
    wInicial.SaltaPed := SN_Boolean(wIni.ReadString('Balcao', 'SaltaPed', 'N'));
    wInicial.EmpFilVendas := wIni.ReadInteger('Balcao', 'EmpFilVendas', 1);
    wInicial.AteVenVendas := wIni.ReadInteger('Balcao', 'AteVenVendas', 0);
    wInicial.AlteraEmpFil :=
      SN_Boolean(wIni.ReadString('Balcao', 'AlteraEmpFil', 'N'));
    wInicial.InicioOperacao := wIni.ReadInteger('Balcao', 'InicioOperacao', 0);
    wInicial.LctosOperacao := wIni.ReadInteger('Balcao', 'LctosOperacao', 3);
    wInicial.TpDescBalcao := wIni.ReadInteger('Balcao', 'TpDescBalcao', 0);

    //
    wInicial.EmpFilOS1 := wIni.ReadInteger('OrdemServico', 'EmpFil1', 1);
    wInicial.AteVenOS1 := wIni.ReadInteger('OrdemServico', 'AteVen1', 0);
    wInicial.EmpFilOS2 := wIni.ReadInteger('OrdemServico', 'EmpFil2', 1);
    wInicial.AteVenOS2 := wIni.ReadInteger('OrdemServico', 'AteVen2', 0);
    //
    if AnsiUpperCase(wIni.ReadString('FastFood', 'Balcao', 'N')) = 'S' then
      wInicial.FFLocal_Balcao := True
    else
      wInicial.FFLocal_Balcao := False;
    if AnsiUpperCase(wIni.ReadString('FastFood', 'Tele', 'N')) = 'S' then
      wInicial.FFLocal_Tele := True
    else
      wInicial.FFLocal_Tele := False;
    if AnsiUpperCase(wIni.ReadString('FastFood', 'Mesas', 'N')) = 'S' then
      wInicial.FFLocal_Mesas := True
    else
      wInicial.FFLocal_Mesas := False;
    if AnsiUpperCase(wIni.ReadString('FastFood', 'NFCe', 'N')) = 'S' then
      wInicial.FFLocal_NFCe := True
    else
      wInicial.FFLocal_NFCe := False;
    if AnsiUpperCase(wIni.ReadString('FastFood', 'NFe', 'N')) = 'S' then
      wInicial.FFLocal_NFe := True
    else
      wInicial.FFLocal_NFe := False;
    if AnsiUpperCase(wIni.ReadString('FastFood', 'GerDFe', 'N')) = 'S' then
      wInicial.FFLocal_GerDFe := True
    else
      wInicial.FFLocal_GerDFe := False;
    wInicial.FFLocal_Printer := wIni.ReadString('FastFood', 'Impressora', '');
    wInicial.FFLocal_VPrinc := wIni.ReadInteger('FastFood', 'Vias', 1);
    wInicial.FFLocal_PrinterSec := wIni.ReadString('FastFood',
      'ImpressoraSecundaria', wInicial.FFLocal_Printer);
    wInicial.FFLocal_VSec := wIni.ReadInteger('FastFood', 'ViasSec',
      wInicial.FFLocal_VPrinc);
    wInicial.FFLocal_SecTp := wIni.ReadInteger('FastFood', 'TipoSecundario', 1);
    // 0-Pedido  1-Cozinha
    //
    wInicial.BSUtiliza := SN_Boolean(wIni.ReadString('BalcaoSimples',
      'Utiliza', 'N'));
    wInicial.BSEmpFil := SN_Boolean(wIni.ReadString('BalcaoSimples',
      'EmpFil', 'N'));
    wInicial.BSVendedor := SN_Boolean(wIni.ReadString('BalcaoSimples',
      'Vendedor', 'N'));
    wInicial.BSLPreco := SN_Boolean(wIni.ReadString('BalcaoSimples',
      'LPreco', 'N'));
    wInicial.BSCliente := SN_Boolean(wIni.ReadString('BalcaoSimples',
      'Cliente', 'N'));
    wInicial.BSInicio := wIni.ReadInteger('BalcaoSimples', 'Inicio', 4);
    // 0-EmpFil 1-Vendedor 2-LPreço 3-Cliente 4-Inclusão Lcto
    wInicial.BSSeqCodProd := SN_Boolean(wIni.ReadString('BalcaoSimples',
      'CodProd', 'S'));
    wInicial.BSSeqDescricao := SN_Boolean(wIni.ReadString('BalcaoSimples',
      'Descricao', 'N'));
    wInicial.BSSeqUnid := SN_Boolean(wIni.ReadString('BalcaoSimples',
      'Unidade', 'N'));
    wInicial.BSSeqQuant := SN_Boolean(wIni.ReadString('BalcaoSimples',
      'Quantidade', 'S'));
    wInicial.BSSeqVlUnit := SN_Boolean(wIni.ReadString('BalcaoSimples',
      'VlUnitario', 'N'));
    wInicial.BSSeqCompl := SN_Boolean(wIni.ReadString('BalcaoSimples',
      'Completa', 'N'));
    wInicial.BSSeqBtOK := SN_Boolean(wIni.ReadString('BalcaoSimples',
      'BtOK', 'N'));
    wInicial.BSAvEnter := SN_Boolean(wIni.ReadString('BalcaoSimples',
      'AvancoEnter', 'N'));
    wInicial.BSOpDescrCompl := SN_Boolean(wIni.ReadString('BalcaoSImples',
      'OpcCompleta', 'N'));
    wInicial.BSOrcamentos := SN_Boolean(wIni.ReadString('BalcaoSImples',
      'Orcamentos', 'N'));
    wInicial.BSTimeWait := wIni.ReadInteger('BalcaoSimples', 'TimeWait', 10);
    if wInicial.BSTimeWait < 1 then
      wInicial.BSTimeWait := 1;
    wInicial.BKSCliente := SN_Boolean(wIni.ReadString('BalcaoSimples',
      'ClienteKiosk', 'N'));
    wInicial.BKSNomeClie := SN_Boolean(wIni.ReadString('BalcaoSimples',
      'NomeClieKiosk', 'N'));
    wInicial.BKSCondPg := SN_Boolean(wIni.ReadString('BalcaoSimples',
      'CondPgKiosk', 'N'));
    wInicial.BKSDesconto := SN_Boolean(wIni.ReadString('BalcaoSimples',
      'DescKiosk', 'N'));
    wInicial.BKSTroco := SN_Boolean(wIni.ReadString('BalcaoSimples',
      'TrocoKiosk', 'N'));
    wInicial.BKSNFCe := SN_Boolean(wIni.ReadString('BalcaoSimples',
      'NFCeKiosk', 'N'));
    wInicial.BKSLcts := wIni.ReadInteger('BalcaoSimples', 'KioskLcts', 1);
    wInicial.BKSFinaliz := wIni.ReadInteger('BalcaoSimples', 'KioskFinal', 0);

    wInicial.EMEMailDest := '';
    wInicial.EMAssunto := '';
    wInicial.EMNomeDest := '';

    wInicial.BMagOper := SN_Boolean(wIni.ReadString('BalcaoMag',
      'Operacoes', 'N'));
    wInicial.BMagProd := SN_Boolean(wIni.ReadString('BalcaoMag',
      'Produtos', 'N'));
    wInicial.BMagDime := SN_Boolean(wIni.ReadString('BalcaoMag',
      'Dimensionar', 'N'));
    wInicial.BMagParm := SN_Boolean(wIni.ReadString('BalcaoMag',
      'Parametros', 'N'));
    wInicial.BMagPreco := SN_Boolean(wIni.ReadString('BalcaoMag',
      'AlteraPreco', 'N'));

  end;
  wIni.Free;
  //
  // Estabelece conexão com o drive remoto - Retorna diferente de ZERO em caso de erro
  if VerificaConexao(FuIniGeral.wInicial.DriveRemoto,
    FuIniGeral.wInicial.Caminho, FuIniGeral.wInicial.Senha) <> 0 then
  begin
    MessageDlg('Conexão não foi estabelecida' + #13 + 'Inicialização falhou',
      mtError, [mbOk], 0);
    Exit;
  end;

  with FuIniGeral do
  begin
    // Info do S.Operacional - Usuário logado
    nSize := 120;
    wAchou := GetUserName(lpBuffer, nSize);
    if wAchou then
    begin
      wInicial.SysUser := lpBuffer;
      wInicial.SysUserStat := 0;
    end
    else
    begin
      wInicial.SysUser := 'Invalido';
      wInicial.SysUserStat := GetLastError();
    end;
    // Info do S.Operacional - Computador
    wInicial.SysComputerName := 'Não identificado';
    nSize := 40;
    Try
      GetMem(cNome, nSize);
      if GetComputerName(cNome, nSize) then
        wInicial.SysComputerName := cNome
      else
        wInicial.SysComputerName := '<< Não informado >>';
    Finally
      FreeMem(cNome, nSize);
    End;
  end;

  // IniGeral    .ini de parametrização (unico para todas as estações)
  wIniName := FuIniGeral.wInicial.Parametros;

  // ShowMessage('Ini Geral=' + wIniName);

  if not FileExists(wIniName) then
    Gera_IniGeral(wIniName);
  wIni := TIniFile.Create(wIniName);
  with FuIniGeral do
  begin
    if Length(Trim(appUser)) = 0 then
      appUser := wInicial.Usuario;

    wInicial.Sistema := wIni.ReadString('Identificacao', 'Sistema', 'SISV');
    wInicial.Empresa := wIni.ReadString('Identificacao', 'Empresa',
      'Demonstração Ltda.');
    wInicial.DatabaseName := wIni.ReadString('Dados', 'DatabaseName', 'SISV4');
    wInicial.DatabasePath := wIni.ReadString('Dados', 'DatabasePath',
      '\SISV\Dados');
    if Pos(':', wInicial.DatabasePath) = 0 then
      wInicial.DatabasePath := wInicial.DriveRemoto + wInicial.DatabasePath;
    wInicial.DatabasePath := AjustaPathBarraFinal(wInicial.DatabasePath, True);
    wInicial.LiteFull := wIni.ReadString('Dados', 'LiteFull', 'F');
    wInicial.LiteMax := wIni.ReadInteger('Dados', 'LiteMax', 2000);
    wInicial.PathAuxiliar := wIni.ReadString('Dados', 'PathAuxiliar',
      'C:\Auxiliar');
    wInicial.PathAuxiliar := AjustaPathBarraFinal(wInicial.PathAuxiliar, True);
    wInicial.SenhaExclus := wIni.ReadString('Dados', 'SenhaExclus',
      'SUPERMOUSE');
    wInicial.Serial := wIni.ReadString('Dados', 'Serial', '99990001234');
    wInicial.PathExec := wIni.ReadString('Dados', 'PathExec', 'C:\Aplicativo');
    wInicial.PathExec := AjustaPathBarraFinal(wInicial.PathExec, True);
    wInicial.PathEstruturas := wIni.ReadString('Dados', 'PathEstruturas',
      'C:\Aplicativo');
    wInicial.PathEstruturas := AjustaPathBarraFinal
      (wInicial.PathEstruturas, True);
    wInicial.PathArqMorto := wIni.ReadString('Dados', 'PathArqMorto',
      'C:\ArqMorto');
    wInicial.PathArqMorto := AjustaPathBarraFinal(wInicial.PathArqMorto, True);

    wInicial.EMNome := wIni.ReadString('EMail', 'Nome', 'Nome da empresa');
    wInicial.EMOrigem := wIni.ReadString('EMail', 'Email',
      'email@provedor.com.br');
    wInicial.EMPorta := wIni.ReadString('EMail', 'Porta', '587');
    wInicial.EMHost := wIni.ReadString('EMail', 'Host', 'smtp.provedor.com.br');
    wInicial.EMUsario := wIni.ReadString('EMail', 'Usuario',
      'usuario do email');
    wInicial.EMSenha := wIni.ReadString('EMail', 'Senha', 'senha1234');
    wInicial.EMEnvio := wIni.ReadString('EMail', 'Envio', 'Indy'); // ou 'ACBR'

    wInicial.ProxyHost := wIni.ReadString('Internet', 'ProxyHost', '');
    wInicial.ProxyPass := wIni.ReadString('Internet', 'ProxyPass', '');
    wInicial.ProxyPort := wIni.ReadString('Internet', 'ProxyPort', '8080');
    wInicial.ProxyUser := wIni.ReadString('Internet', 'ProxyUser', '');
    wInicial.UrlNCM := wIni.ReadString('Internet', 'URLConsultaNCM',
      'http://www4.receita.fazenda.gov.br/simulador/PesquisarNCM.jsp?');

    wInicial.PathWAEnvio := wIni.ReadString('Links', 'PathWAEnvio', 'W:\');
    // Envio WhatsApp
    wInicial.LinksUtiliza :=
      SN_Boolean(wIni.ReadString('Links', 'UtilizaLinks', 'S'));
    wInicial.LinkSPC := wIni.ReadString('Links', 'SPC',
      'https://sistema.spc.org.br/spc/controleacesso/autenticacao/entry.action');
    wInicial.LinkSINTEGRA := wIni.ReadString('Links', 'SINTEGRA',
      'http://www.sintegra.gov.br');
    wInicial.LinkSeFazRS := wIni.ReadString('Links', 'SeFazRS',
      'https://www.sefaz.rs.gov.br/consultas/contribuinte');
    wInicial.DadosSeFaz :=
      SN_Boolean(wIni.ReadString('Links', 'DadosSeFaz', 'S'));

    // Padroes
    wInicial.RefreshTimer := wIni.ReadInteger('Padroes', 'Refresh', 30);
    if (wInicial.RefreshTimer > 0) and (wInicial.RefreshTimer < 15) then
      wInicial.RefreshTimer := 15;
    wInicial.Magazine := SN_Boolean(wIni.ReadString('Padroes',
      'Magazine', 'N'));
    wInicial.CodEF := wIni.ReadInteger('Padroes', 'EmpresaFilial', 1);
    wInicial.Cidade := wIni.ReadString('Padroes', 'Cidade', 'Caxias do Sul');
    wInicial.Estado := wIni.ReadString('Padroes', 'Estado', 'RS');
    wInicial.MunIBGE := wIni.ReadString('Padroes', 'MunIBGE', '05108');
    wInicial.UFIBGE := wIni.ReadString('Padroes', 'UFIBGE', '43');
    wInicial.ValorDec := wIni.ReadInteger('Padroes', 'ValorDecimais', 2);
    wInicial.QuantDec := wIni.ReadInteger('Padroes', 'QuantDecimais', 2);
    wInicial.CadastroUnico :=
      SN_Boolean(wIni.ReadString('Padroes', 'CadastroUnico', 'S'));
    wInicial.AtualizaCadastro :=
      SN_Boolean(wIni.ReadString('Padroes', 'AtualizaCadastro', 'N'));
    wInicial.CadasLogFile := wIni.ReadString('Padroes', 'CadasLogFile',
      'C:\SISV\Dados\LogCadastro.log');
    wInicial.TranspLogFile := wIni.ReadString('Padroes', 'TranspLogFile',
      'C:SISV\Dados\LogTransport.log');
    wInicial.EmpregLogFile := wIni.ReadString('Padroes', 'EmpregLogFile',
      'C:\SISV\Dados\LogEmpregad.log');
    wInicial.PagRecLogFile := wIni.ReadString('Padroes', 'PagRecLogFile',
      'C:\SISV\Dados\LogPagRec.log');
    wInicial.DFeLogFile := wIni.ReadString('Padroes', 'DFeLogFile',
      'C:\DadosNFe\LogDFe.log');
    wInicial.PeriodoCC := wIni.ReadInteger('Padroes',
      'PeriodoContaCorrente', 90);
    wInicial.CadClass1 := wIni.ReadString('Padroes', 'CadClass1',
      'Padrão - Atacadista,Varejista,Cons.Final');
    wInicial.CadClass2 := wIni.ReadString('Padroes', 'CadClass2',
      'Fabricante de veiculos,máquinas e autopeças');
    wInicial.CadClass3 := wIni.ReadString('Padroes', 'CadClass3', '');
    wInicial.CaixaDoc := wIni.ReadInteger('Padroes', 'CaixaDoc', 1);
    wInicial.PcCredAV := wIni.ReadFloat('Padroes', 'PcCredAVista', 0);
    wInicial.PcCredParc := wIni.ReadFloat('Padroes', 'PcCredParcel', 0);
    wInicial.MensCredParc :=
      SN_Boolean(wIni.ReadString('Padroes', 'MensCredParc', 'N'));
    wInicial.PcDebito := wIni.ReadFloat('Padroes', 'PcDebito', 0);
    wInicial.PcCrediario := wIni.ReadFloat('Padroes', 'PcCrediario', 0);
    wInicial.MensCrediario :=
      SN_Boolean(wIni.ReadString('Padroes', 'MensCrediario', 'N'));
    wInicial.PcParcelam := wIni.ReadFloat('Padroes', 'PcParcelam', 0);
    wInicial.MensParcelam :=
      SN_Boolean(wIni.ReadString('Padroes', 'MensParcelam', 'N'));
    wInicial.PcCheques := wIni.ReadFloat('Padroes', 'PcCheques', 0);
    wInicial.MensCheques :=
      SN_Boolean(wIni.ReadString('Padroes', 'MensCheques', 'N'));
    wInicial.PrazoMedio := SN_Boolean(wIni.ReadString('Padroes',
      'PrazoMedio', 'N'));
    wInicial.UsaTabCartoes :=
      SN_Boolean(wIni.ReadString('Padroes', 'UsaTabCartoes', 'N'));
    wInicial.VlrMinDesc := wIni.ReadFloat('Padroes', 'VlrMinDesc', 100.00);
    wInicial.PcMaxDesc := wIni.ReadFloat('Padroes', 'PcMaxDesc', 20.00);
    wInicial.BolMax := wIni.ReadInteger('Padroes', 'BolMax', 6);
    wInicial.CredMax := wIni.ReadInteger('Padroes', 'CredMax', 6);
    wInicial.CartMax := wIni.ReadInteger('Padroes', 'CartMax', 6);
    wInicial.ChqMax := wIni.ReadInteger('Padroes', 'ChqMax', 6);
    wInicial.LeituraAuto :=
      SN_Boolean(wIni.ReadString('Padroes', 'LeituraAuto', 'N'));
    wInicial.PadraoPesqAlfa := wIni.ReadInteger('Padroes',
      'PesquisaAlfabetica', 0);
    wInicial.DescBoletos :=
      SN_Boolean(wIni.ReadString('Padroes', 'DescBoletos', 'N'));
    wInicial.RemBolAutom :=
      SN_Boolean(wIni.ReadString('Padroes', 'RemBolAutom', 'N'));
    wInicial.GerBolEmpFil :=
      SN_Boolean(wIni.ReadString('Padroes', 'GerBolEmpFil', 'N'));
    wInicial.Recibos := SN_Boolean(wIni.ReadString('Padroes', 'Recibos', 'N'));
    wInicial.RecSimples := SN_Boolean(wIni.ReadString('Padroes',
      'RecSimples', 'N'));
    wInicial.AMSemestral :=
      SN_Boolean(wIni.ReadString('Padroes', 'AMSemestral', 'N'));
    wInicial.IntegVendOS :=
      SN_Boolean(wIni.ReadString('Padroes', 'IntegVendOS', 'N'));
    wInicial.TotalNFe := SN_Boolean(wIni.ReadString('Padroes',
      'TotalNFe', 'N'));
    wInicial.DtLimiteSeFaz :=
      StrToDate(wIni.ReadString('Padroes', 'DtLimiteSeFaz', '01/12/2019'));
    wInicial.TipoVenda := SN_Boolean(wIni.ReadString('Padroes',
      'TipoVenda', 'N'));
    wInicial.AdotaDtAtual :=
      SN_Boolean(wIni.ReadString('Padroes', 'AdotaDataAtual', 'N'));
    wInicial.PedidoPadrao := wIni.ReadInteger('Padroes', 'PedidoPadrao', 0);
    wInicial.ConfirmaVias :=
      SN_Boolean(wIni.ReadString('Padroes', 'ConfirmaVias', 'N'));
    wInicial.ExibeQtdDisp :=
      SN_Boolean(wIni.ReadString('Padroes', 'ExibeQtdDisponivel', 'N'));
    wInicial.ValidarIE := wIni.ReadInteger('Padroes', 'ValidarIE', 1);
    wInicial.IdAtacadista := wIni.ReadString('Padroes', 'IdAtacadista',
      'Atacadista');
    wInicial.IdDistribuidor := wIni.ReadString('Padroes', 'IdDistribuidor',
      'Distribuidor');
    wInicial.EMailHomolog := wIni.ReadString('Padroes', 'EMailHomolog',
      'softcon.cx@gmail.com');
    //
    // Financeiro
    wInicial.DetRubricas := SN_Boolean(wIni.ReadString('Financeiro',
      'DetRubricas', 'N'));
    wAux := AnsiUpperCase(wIni.ReadString('Financeiro', 'Juros', 'M'));
    if wAux = 'D' then
      wInicial.TpJuros := 1
    else if wAux = 'M' then
      wInicial.TpJuros := 2
    else
      wInicial.TpJuros := 0;
    wInicial.PcJuros := wIni.ReadFloat('Financeiro', 'PercJuros', 5);
    wInicial.PcDesc := wIni.ReadFloat('Financeiro', 'PercDesc', 5);
    wInicial.PcMulta := wIni.ReadFloat('Financeiro', 'PercMulta', 3);
    wAux := AnsiUpperCase(wIni.ReadString('Financeiro', 'Cobranca', 'B'));
    if wAux = 'C' then
      wInicial.Cobranca := 0
    else if wAux = 'B' then
      wInicial.Cobranca := 1
    else if wAux = 'J' then
      wInicial.Cobranca := 2
    else
      wInicial.Cobranca := 3;
    wInicial.DocPagar := wIni.ReadInteger('Financeiro', 'DocPagar', 1);
    wInicial.DocReceb := wIni.ReadInteger('Financeiro', 'DocReceber', 1);
    wInicial.DocCrediar := wIni.ReadInteger('Financeiro', 'DocCrediario', 1);
    wInicial.DocCheque := wIni.ReadInteger('Financeiro', 'DocCheque', 1);
    wInicial.DuplCNPJ := SN_Boolean(wIni.ReadString('Financeiro',
      'DuplicataCNPJ', 'N'));
    wInicial.DuplIEST := SN_Boolean(wIni.ReadString('Financeiro',
      'DuplicataIEst', 'N'));
    wInicial.DiasFuturos := wIni.ReadInteger('Financeiro', 'DiasFuturos', 30);
    wInicial.NroDocObrigatorio :=
      SN_Boolean(wIni.ReadString('Financeiro', 'NroDocObrigatorio', 'N'));
    wInicial.DiferDocumentos :=
      SN_Boolean(wIni.ReadString('Financeiro', 'DiferDocumentos', 'N'));
    wInicial.PathRemessas := wIni.ReadString('Financeiro', 'PathRemessas',
      'C:\Remessas');
    if not DirectoryExists(wInicial.PathRemessas) then
      Try
        CreateDir(wInicial.PathRemessas);
      Except
        MessageDlg('Falha - ' + wInicial.PathRemessas, mtError, [mbOk], 0);
      End;
    wInicial.PathRemessas := AjustaPathBarraFinal(wInicial.PathRemessas, True);
    wInicial.DetPathRemessas := wIni.ReadInteger('Financeiro',
      'DetPathRemessas', 0);
    wInicial.ProcRetornos := SN_Boolean(wIni.ReadString('Financeiro',
      'Retornos', 'N'));
    wInicial.PathRetornos := wIni.ReadString('Financeiro', 'PathRetornos',
      'C:\Retornos');
    if not DirectoryExists(wInicial.PathRetornos) then
      Try
        CreateDir(wInicial.PathRetornos);
      Except
        MessageDlg('Falha - ' + wInicial.PathRetornos, mtError, [mbOk], 0);
      End;
    wInicial.PathRetornos := AjustaPathBarraFinal(wInicial.PathRetornos, True);
    wInicial.PathSalvaRetornos := wIni.ReadString('Financeiro',
      'PathSalvaRetornos', 'C:\Retornos\Salvos');
    if not DirectoryExists(wInicial.PathSalvaRetornos) then
      Try
        CreateDir(wInicial.PathSalvaRetornos)
      Except
        MessageDlg('Falha - ' + wInicial.PathSalvaRetornos, mtError, [mbOk], 0);
      End;
    wInicial.PathSalvaRetornos := AjustaPathBarraFinal
      (wInicial.PathSalvaRetornos, True);
    wInicial.RetProcesso := wIni.ReadInteger('Financeiro', 'Processo', 2);
    wInicial.VisProcesso := SN_Boolean(wIni.ReadString('Financeiro',
      'VisualizaProcesso', 'N'));
    wInicial.PathAlter01 := wIni.ReadString('Financeiro', 'PathRetorno01', '');
    wInicial.PathAlter02 := wIni.ReadString('Financeiro', 'PathRetorno02', '');
    wInicial.PathAlter03 := wIni.ReadString('Financeiro', 'PathRetorno03', '');
    wInicial.PathAlter04 := wIni.ReadString('Financeiro', 'PathRetorno04', '');
    wInicial.PathAlter05 := wIni.ReadString('Financeiro', 'PathRetorno05', '');
    wInicial.UsaPlanoContas :=
      SN_Boolean(wIni.ReadString('Financeiro', 'UsaPlanoContas', 'N'));
    wInicial.TpCarneCrediar := wIni.ReadInteger('Financeiro',
      'TipoCarneCrediario', 0);
    wInicial.TamDetBobina := wIni.ReadInteger('Financeiro',
      'TamDetBobina', 126);
    wInicial.EmpFilCrediar := wIni.ReadInteger('Financeiro', 'EFPadrao', 1);
    wInicial.ImprimeConfDiv :=
      SN_Boolean(wIni.ReadString('Financeiro', 'ImprimeConfDiv', 'N'));
    wInicial.ImprimeEntrada :=
      SN_Boolean(wIni.ReadString('Financeiro', 'ImprimeEntrada', 'N'));
    wInicial.TxtConfDivida := wIni.ReadString('Financeiro',
      'TxtConfDivida', '');
    wInicial.TxtConfDividaBob := wIni.ReadString('Financeiro',
      'TxtConfDividaBob', '');
    wInicial.TxtCarnet1 := wIni.ReadString('Financeiro', 'TxtCarnet1', '');
    wInicial.TxtCarnet2 := wIni.ReadString('Financeiro', 'TxtCarnet2', '');
    wInicial.DiasIsencao := wIni.ReadInteger('Financeiro', 'DiasIsencao', 0);
    wInicial.LiberaCred := SN_Boolean(wIni.ReadString('Financeiro',
      'LiberaCred', 'N'));
    wInicial.UtilizaCC := SN_Boolean(wIni.ReadString('Financeiro',
      'UtilizaCC', 'N'));
    wInicial.CreditoCC := wIni.ReadString('Financeiro', 'CreditoCC', 'Cred CC');
    wInicial.DebitoCC := wIni.ReadString('Financeiro', 'DebitoCC', 'Deb CC');
    wInicial.InfSaldoCC := SN_Boolean(wIni.ReadString('Financeiro',
      'InfSaldoCC', 'N'));
    wInicial.TxtPgto1 := wIni.ReadString('Financeiro', 'TxtPgto1',
      '** Documento NÃO fiscal **');
    wInicial.TxtPgto2 := wIni.ReadString('Financeiro', 'TxtPgto2',
      'Recebimento de carnet de crediário');
    wInicial.TxtPgto3 := wIni.ReadString('Financeiro', 'TxtPgto3', '');

    wInicial.Bol_PathPDF := wIni.ReadString('Boletos', 'PathPDF',
      'C:\BoletosPDF');
    wInicial.Bol_Denom := wIni.ReadInteger('Boletos', 'Denominacao', 2);
    wInicial.Bol_OutraDenom := wIni.ReadString('Boletos', 'OutraDenominacao',
      'Boleto');
    wInicial.Bol_Impressora := wIni.ReadString('Boletos', 'Impressora',
      'Default');
    wInicial.Bol_Copias := wIni.ReadInteger('Boletos', 'Copias', 0);
    wInicial.Bol_DialogPrint :=
      SN_Boolean(wIni.ReadString('Boletos', 'DialogoImpressao', 'N'));
    wInicial.Bol_ExcluePDF :=
      SN_Boolean(wIni.ReadString('Boletos', 'ExcluePDF', 'N'));

    // Estoques
    wInicial.EstoqLogFile := wIni.ReadString('Estoques', 'LogFile',
      'C:\SISV\Dados\Estoques.log');
    wInicial.ECadas := AnsiUpperCase(wIni.ReadString('Estoques',
      'Cadastro', 'C'));
    wInicial.EApres := AnsiUpperCase(wIni.ReadString('Estoques',
      'Apresentacao', 'D'));
    wInicial.EObRefer := SN_Boolean(wIni.ReadString('Estoques',
      'ObrigReferencia', 'N'));
    wInicial.EObGrupo := SN_Boolean(wIni.ReadString('Estoques',
      'ObrigGrupo', 'N'));
    wInicial.EDupDescr := SN_Boolean(wIni.ReadString('Estoques',
      'DupDescricao', 'N'));
    wInicial.EDupRefer := SN_Boolean(wIni.ReadString('Estoques',
      'DupReferencia', 'N'));
    wInicial.EUsaRefer2 := SN_Boolean(wIni.ReadString('Estoques',
      'UsaReferencia2', 'N'));
    wInicial.EExibUltCusto :=
      SN_Boolean(wIni.ReadString('Estoques', 'ExibeUltCusto', 'N'));
    wInicial.ELPreco := SN_Boolean(wIni.ReadString('Estoques',
      'ListaPreco', 'N'));
    wInicial.EDescrCase := AnsiUpperCase(wIni.ReadString('Estoques',
      'Descricao', 'Normal'));
    wInicial.EDiasValidade := wIni.ReadInteger('Estoques', 'DiasValidade', 45);
    wInicial.EstCodTam := wIni.ReadInteger('Estoques', 'TamanhoCodigo', 6);
    wInicial.EstCodDiv := wIni.ReadInteger('Estoques', 'Divisoes', 1);
    wInicial.EstDiv1Tam := wIni.ReadInteger('Estoques', 'Div1Tamanho', 6);
    wInicial.EstDiv1Tip := wIni.ReadString('Estoques', 'Div1Tipo', 'N');
    wInicial.EstDiv2Tam := wIni.ReadInteger('Estoques', 'Div2Tamanho', 0);
    wInicial.EstDiv2Tip := wIni.ReadString('Estoques', 'Div2Tipo', 'N');
    wInicial.EstDiv3Tam := wIni.ReadInteger('Estoques', 'Div3Tamanho', 0);
    wInicial.EstDiv3Tip := wIni.ReadString('Estoques', 'Div3Tipo', 'N');
    wInicial.EstDiv4Tam := wIni.ReadInteger('Estoques', 'Div4Tamanho', 0);
    wInicial.EstDiv4Tip := wIni.ReadString('Estoques', 'Div4Tipo', 'N');
    wInicial.EstEtiquetas :=
      SN_Boolean(wIni.ReadString('Estoques', 'Etiquetas', 'N'));
    wInicial.EstEtiqAlt24 := wIni.ReadFloat('Estoques', 'AlturaEtiq24', 33.000);
    wInicial.EstExpCodBar := wIni.ReadInteger('Estoques', 'ExpCodBar', 0);
    wInicial.EstMagazine := SN_Boolean(wIni.ReadString('Estoques',
      'Magazine', 'N'));
    wInicial.EstAssTecnica :=
      SN_Boolean(wIni.ReadString('Estoques', 'AssTecnica', 'N'));
    wInicial.EstSelPromo := SN_Boolean(wIni.ReadString('Estoques',
      'SelPromo', 'N'));
    wInicial.EstMesExclus := wIni.ReadInteger('Estoques', 'MesesExclusao', 24);

    wInicial.EstPathWrk := wIni.ReadString('Estoques', 'PathWrk',
      'C:\SISV\Local\');
    wInicial.EstPathWrk := AjustaPathBarraFinal(wInicial.EstPathWrk, True);
    wInicial.EstBarrasPrinter := wIni.ReadString('Estoques',
      'BarrasPrinter', 'ARGOX');
    wInicial.EstBarrasA4 := wIni.ReadString('Estoques', 'BarrasA4', '');
    wInicial.EstProdCusto :=
      SN_Boolean(wIni.ReadString('Estoques', 'ProducaoCustos', 'N'));
    wInicial.EstMarcaEF := wIni.ReadInteger('Estoques', 'MarcaEF', 0);
    wInicial.EstAltPrecos :=
      SN_Boolean(wIni.ReadString('Estoques', 'AlteraPrecos', 'N'));
    wInicial.EstSubGrupo := SN_Boolean(wIni.ReadString('Estoques',
      'SubGrupos', 'N'));
    wInicial.EstValidEAN := SN_Boolean(wIni.ReadString('Estoques',
      'ValidaEAN', 'N'));
    wInicial.EstBkupMes := SN_Boolean(wIni.ReadString('Estoques',
      'BKupMes', 'S'));
    wInicial.EstBkupPath := wIni.ReadString('Estoques', 'BkupPath',
      'C:\BkUpEstoques\');
    wInicial.EstBkupPath := AjustaPathBarraFinal(wInicial.EstBkupPath, True);

    if AnsiUpperCase(wIni.ReadString('Servicos', 'CodigoEstoque', 'S')) = 'N'
    then
    begin
      wInicial.SrvCodEspec := False;
      // Não há codificação diferente para serviços
      wInicial.SrvCodTam := wInicial.EstCodTam;
      // Tamanho do código é igual ao código de estoques
      wInicial.SrvCodNA := 'X';
      // Mascara segue os mesmos critérios do código de estoques
    end
    else
    begin
      wInicial.SrvCodEspec := True; // Codificação diferente para serviços
      wInicial.SrvCodTam := wIni.ReadInteger('Servicos', 'CodigoTamanho', 5);
      // Tamanho do código (deve ser igual ou menor que estoques)
      wInicial.SrvCodNA := wIni.ReadString('Servicos', 'CodigoNumAlfa', 'N');
      // 'N'umerico ou 'Alfanumérico'
      // Numerico: alinha pela direita e preenche com zeros à esquerda, Alfanumerico: alinha pela esquerda
    end;
    // Estoques - Entradas
    wInicial.Entr_EF := wIni.ReadInteger('Estoques_Entradas',
      'EmpresaFilial', 1);
    wInicial.Entr_ExibeCalc := SN_Boolean(wIni.ReadString('Estoques_Entradas',
      'ExibeCalculo', 'N'));
    wInicial.Entr_AtlzCP := SN_Boolean(wIni.ReadString('Estoques_Entradas',
      'CP_Atualiza', 'N'));
    wInicial.Entr_CPDoc := wIni.ReadInteger('Estoques_Entradas',
      'CP_Documento', 1);
    wInicial.Entr_CPRubr := wIni.ReadInteger('Estoques_Entradas',
      'CP_Rubrica', 1);
    wInicial.Entr_DocEntr := wIni.ReadInteger('Estoques_Entradas',
      'DocEntrada', 2);
    wInicial.Entr_Detal := SN_Boolean(wIni.ReadString('Estoques_Entradas',
      'Detalhamento', 'N'));
    wInicial.Entr_CritBases := SN_Boolean(wIni.ReadString('Estoques_Entradas',
      'CriticaBases', 'N'));
    wInicial.Entr_CalcBsIsenta :=
      SN_Boolean(wIni.ReadString('Estoques_Entradas', 'CalcBaseIsenta', 'N'));
    wInicial.Entr_AdotaPreco := SN_Boolean(wIni.ReadString('Estoques_Entradas',
      'AdotarPreco', 'N'));
    wInicial.Entr_AdotaCFOP := SN_Boolean(wIni.ReadString('Estoques_Entradas',
      'AdotarCFOP', 'N'));
    wInicial.Entr_PathLeXML := AjustaPathBarraFinal
      (wIni.ReadString('Estoques_Entradas', 'PathLeXML',
      'C:\NF_Fornecedores'), True);
    wInicial.Entr_DifEF := SN_Boolean(wIni.ReadString('Estoques_Entradas',
      'DiferEmpresas', 'N'));
    wInicial.Entr_ExProcesso := SN_Boolean(wIni.ReadString('Estoques_Entradas',
      'ExibeProcesso', 'N'));
    wInicial.Entr_PesqRefer := SN_Boolean(wIni.ReadString('Estoques_Entradas',
      'PesqReferencia', 'N'));

    // Estoques - Compras
    wInicial.Compra_Id := wIni.ReadString('Estoques_Compras', 'Identificacao',
      'Ordem de compra');
    wInicial.Compra_Abrev := wIni.ReadString('Estoques_Compras',
      'Abreviatura', 'OC');
    wInicial.Compra_Menu := wIni.ReadString('Estoques_Compras', 'IdMenu',
      '&Ordem de compra');
    wInicial.Compra_QtdDec := wIni.ReadInteger('Estoques_Compras',
      'DecQuantidade', 2);
    wInicial.Compra_UnitDec := wIni.ReadInteger('Estoques_Compras',
      'DecUnitario', 2);

    // Tributação padrão dos ítens de estoque
    wInicial.esModoBC := wIni.ReadInteger('Estoques_Tributacao',
      'ICM_ModoBC', 3);
    wInicial.esRedBC := wIni.ReadFloat('Estoques_Tributacao', 'ICM_RedBC', 0);
    wInicial.esModoBCST := wIni.ReadInteger('Estoques_Tributacao',
      'ICM_ModoBCST', 5);
    wInicial.esMVA := wIni.ReadFloat('Estoques_Tributacao', 'ICM_MVA', 0);
    wInicial.esRedBCST := wIni.ReadFloat('Estoques_Tributacao',
      'ICM_RedBCST', 0);
    wInicial.esIPI := SN_Boolean(wIni.ReadString('Estoques_Tributacao',
      'IPI_Sujeito', 'N'));
    wInicial.esIPIClasse := wIni.ReadString('Estoques_Tributacao',
      'IPI_Classe', '00000');
    wInicial.esIPIEnq := wIni.ReadString('Estoques_Tributacao',
      'IPI_Enquadramento', '999');
    wInicial.esIPITrib := SN_Boolean(wIni.ReadString('Estoques_Tributacao',
      'IPI_Tributavel', 'N'));
    wInicial.esIPIEnt := wIni.ReadInteger('Estoques_Tributacao',
      'IPI_STEntrada', 49);
    wInicial.esIPISai := wIni.ReadInteger('Estoques_Tributacao',
      'IPI_STSaida', 99);
    wInicial.esIPIModo := AnsiUpperCase(wIni.ReadString('Estoques_Tributacao',
      'IPI_Modo', 'V'));
    wInicial.esNCM := wIni.ReadString('Estoques_Tributacao', 'NCM', '01010101');
    wInicial.esGenero := wIni.ReadString('Estoques_Tributacao',
      'Genero', '0101');
    wInicial.esExTIPI := wIni.ReadString('Estoques_Tributacao',
      'ExTIPI', '123');
    wInicial.esCEST := wIni.ReadString('Estoques_Tributacao', 'CEST',
      '0100600');
    wInicial.esNVE := wIni.ReadString('Estoques_Tributacao', 'NVE', '');
    wInicial.esPIS := SN_Boolean(wIni.ReadString('Estoques_Tributacao',
      'PIS_Trb', 'N'));
    wInicial.esPISST := wIni.ReadInteger('Estoques_Tributacao', 'PIS_ST', 99);
    wInicial.esPISAliq := wIni.ReadFloat('Estoques_Tributacao', 'PIS_Aliq', 0);
    wInicial.esPISVlUnit := wIni.ReadFloat('Estoques_Tributacao',
      'PIS_Unit', 0);
    wInicial.esCofins := SN_Boolean(wIni.ReadString('Estoques_Tributacao',
      'Cofins_Trb', 'N'));
    wInicial.esCofinsST := wIni.ReadInteger('Estoques_Tributacao',
      'Cofins_ST', 99);
    wInicial.esCofinsAliq := wIni.ReadFloat('Estoques_Tributacao',
      'Cofins_Aliq', 0);
    wInicial.esCofinsVlUnit := wIni.ReadFloat('Estoques_Tributacao',
      'Cofins_Unit', 0);

    wInicial.CFOP_Venda := wIni.ReadInteger('Vendas_CFOP', 'Venda', 5102);
    wInicial.CFOP_VendaST := wIni.ReadInteger('Vendas_CFOP', 'VendaST', 5405);
    wInicial.CFOP_Servico := wIni.ReadInteger('Vendas_CFOP', 'Servico', 5933);
    wInicial.CFOP_NCVenda := wIni.ReadInteger('Vendas_CFOP', 'NCVenda', 5102);
    wInicial.CFOP_NCVendaST := wIni.ReadInteger('Vendas_CFOP',
      'NCVendaST', 5405);

    wInicial.CFOP_Venda_FE := wIni.ReadInteger('Vendas_CFOP', 'Venda_FE', 6102);
    wInicial.CFOP_VendaST_FE := wIni.ReadInteger('Vendas_CFOP',
      'VendaST_FE', 6404);
    wInicial.CFOP_Servico_FE := wIni.ReadInteger('Vendas_CFOP',
      'Servico_FE', 6933);
    wInicial.CFOP_NCVenda_FE := wIni.ReadInteger('Vendas_CFOP',
      'NCVenda_FE', 6108);
    wInicial.CFOP_NCVendaST_FE := wIni.ReadInteger('Vendas_CFOP',
      'NCVendasST_FE', 6404);

    wInicial.CFOP_Uso := wIni.ReadString('Vendas_CFOP', 'UsoProdOper',
      'Produto');
    wInicial.PrioridadeST := SN_Boolean(wIni.ReadString('Vendas_CFOP',
      'PrioridadeST', 'N'));

    wInicial.cpMargem := wIni.ReadFloat('CustosPrecos', 'Margem', 80);
    wInicial.cpCFixos := wIni.ReadFloat('CustosPrecos', 'CustosFixos', 16);
    wInicial.cpAliqSN := wIni.ReadFloat('CustosPrecos', 'Simples', 5);
    wInicial.cpAliqLP := wIni.ReadFloat('CustosPrecos', 'LucroPresumido', 12);
    wInicial.cpTaxFin := wIni.ReadFloat('CustosPrecos', 'TaxaFinanceira', 4);
    wInicial.cpMVACusto := SN_Boolean(wIni.ReadString('CustosPrecos',
      'MVACusto', 'N'));

    wInicial.OpES_NomeCliente :=
      SN_Boolean(wIni.ReadString('Operacoes', 'NomeCliente', 'N'));
    wInicial.OpES_Vendedor :=
      SN_Boolean(wIni.ReadString('Operacoes', 'Vendedor', 'N'));
    wInicial.OpES_DuplMat := SN_Boolean(wIni.ReadString('Operacoes',
      'DuplicMaterial', 'N'));
    wInicial.OpES_DuplSrv := SN_Boolean(wIni.ReadString('Operacoes',
      'DuplicServico', 'N'));
    wInicial.OpES_LctPrior := wIni.ReadString('Operacoes',
      'LctoPrioritario', 'M');
    wInicial.OpES_DescrCompl :=
      SN_Boolean(wIni.ReadString('Operacoes', 'DescricaoCompleta', 'N'));
    wInicial.OpES_DescItem :=
      SN_Boolean(wIni.ReadString('Operacoes', 'DescontoItem', 'N'));
    wInicial.OpES_GrupoBloq0 := wIni.ReadInteger('Operacoes', 'GrupoBloq0', -1);
    wInicial.OpES_GrupoBloq1 := wIni.ReadInteger('Operacoes', 'GrupoBloq1', -1);
    wInicial.OpES_GrupoBloq2 := wIni.ReadInteger('Operacoes', 'GrupoBloq2', -1);
    wInicial.OpES_GrupoBloq3 := wIni.ReadInteger('Operacoes', 'GrupoBloq3', -1);
    wInicial.OpES_GrupoBloq4 := wIni.ReadInteger('Operacoes', 'GrupoBloq4', -1);
    wInicial.OpES_GrupoBloq5 := wIni.ReadInteger('Operacoes', 'GrupoBloq5', -1);
    wInicial.OpES_GrupoBloq6 := wIni.ReadInteger('Operacoes', 'GrupoBloq6', -1);
    wInicial.OpES_GrupoBloq7 := wIni.ReadInteger('Operacoes', 'GrupoBloq7', -1);
    wInicial.OpES_GrupoBloq8 := wIni.ReadInteger('Operacoes', 'GrupoBloq8', -1);
    wInicial.OpES_GrupoBloq9 := wIni.ReadInteger('Operacoes', 'GrupoBloq9', -1);
    wInicial.OpES_Negativo :=
      SN_Boolean(wIni.ReadString('Operacoes', 'EstoqueNegativo', 'N'));
    wInicial.OpES_CalcSTVend :=
      SN_Boolean(wIni.ReadString('Operacoes', 'CalculaSTVenda', 'N'));
    wInicial.OpES_PgmOS := wIni.ReadString('Operacoes', 'PgmOS', 'NI');
    wInicial.OpES_LCab1 := wIni.ReadString('Operacoes', 'PedidoCab1',
      'Cab lin #1');
    wInicial.OpES_LCab2 := wIni.ReadString('Operacoes', 'PedidoCab2',
      'Cab lin #2');
    wInicial.OpES_LCab3 := wIni.ReadString('Operacoes', 'PedidoCab3',
      'Cab lin #3');
    wInicial.OpES_LCab4 := wIni.ReadString('Operacoes', 'PedidoCab4',
      'Cab lin #4');
    wInicial.OpES_LProm := wIni.ReadString('Operacoes', 'PedidoProm',
      'Linha promocional');
    wInicial.OpES_PedId := wIni.ReadString('Operacoes', 'PedidoIdent',
      'Pedido');
    wInicial.OpES_OrcId := wIni.ReadString('Operacoes', 'OrcamIdent',
      'Orçamento');
    wInicial.OpES_PedPreview :=
      SN_Boolean(wIni.ReadString('Operacoes', 'PedidoPreview', 'N'));
    wInicial.OpES_PedDialog :=
      SN_Boolean(wIni.ReadString('Operacoes', 'PedidoDialog', 'N'));
    wInicial.OpES_PedEntreVias :=
      SN_Boolean(wIni.ReadString('Operacoes', 'PedidoEntreVias', 'N'));
    wInicial.OpES_PedTotTribut :=
      SN_Boolean(wIni.ReadString('Operacoes', 'PedidoTotTribut', 'N'));
    wInicial.OpES_PedLogo := wIni.ReadString('Operacoes', 'PedidoLogo', '');
    wInicial.OpES_PedAvLin := wIni.ReadInteger('Operacoes',
      'PedidoAvLinhas', 5);
    wInicial.OpES_PedAvPix := wIni.ReadInteger('Operacoes',
      'PedidoAvPixels', 1);
    wInicial.OpES_MC5464 := SN_Boolean(wIni.ReadString('Operacoes',
      'MC5464', 'S'));
    wInicial.OpES_ModoBCICMVenda := wIni.ReadInteger('Operacoes',
      'ModoBCICM', 3);
    // Modo BCICMS       BCICMSST   (VENDBASEICM)
    // 0  VlrProd       VlrProd
    // 1  VlrProd       VlrProd+IPI
    // 2  VlrProd+IPI   VlrProd
    // 3  VlrProd+IPI   VlrProd+IPI
    wInicial.OpES_TimeOut := wIni.ReadInteger('Operacoes', 'TimeOut', 45);
    wInicial.OpES_DtHrSaida :=
      SN_Boolean(wIni.ReadString('Operacoes', 'DtHrSaida', 'N'));
    wInicial.OpES_CodClieNFe :=
      SN_Boolean(wIni.ReadString('Operacoes', 'CodCliente', 'N'));
    wInicial.OpES_HrVeraoIni := wIni.ReadDate('Operacoes', 'HrVeraoIni', Date);
    wInicial.OpES_HrVeraoFin := wIni.ReadDate('Operacoes', 'HrVeraoFin', Date);
    wInicial.OpES_Crediario :=
      SN_Boolean(wIni.ReadString('Operacoes', 'Crediario', 'N'));
    wInicial.OpES_VolDefault := wIni.ReadInteger('Operacoes', 'VolDefault', 1);
    wInicial.OpES_VolEspecie := wIni.ReadString('Operacoes',
      'VolEspecie', 'Caixa');
    wInicial.OpES_VolMarca := wIni.ReadString('Operacoes', 'VolMarca',
      'S/Marca');
    wInicial.OpES_SomaQtd := SN_Boolean(wIni.ReadString('Operacoes',
      'SomaQuantidade', 'N'));
    wInicial.OpES_Frete := wIni.ReadInteger('Operacoes', 'Frete', 1);
    wInicial.OpES_FatorPB := wIni.ReadFloat('Operacoes', 'FatorPesoBruto', 1.5);
    wInicial.OpES_AVFluxo := SN_Boolean(wIni.ReadString('Operacoes',
      'AVFluxo', 'N'));
    wInicial.OpES_ClieBalcao :=
      SN_Boolean(wIni.ReadString('Operacoes', 'ClienteBalcao', 'N'));
    wInicial.OpES_RubrAVFluxo := wIni.ReadInteger('Operacoes',
      'RubAVFluxo', 999);
    wInicial.OpES_SenhaCancel := wIni.ReadString('Operacoes',
      'SenhaCancel', '');
    wInicial.OpES_SenhaDesc := wIni.ReadString('Operacoes', 'SenhaDesc', '');
    wInicial.OpES_VendaPrefer := wIni.ReadString('Operacoes',
      'VendaPreferencial', 'Contribuinte');
    wInicial.OpES_RestauraNFe :=
      SN_Boolean(wIni.ReadString('Operacoes', 'RestauraNFe', 'N'));
    wInicial.OpES_NFeEmiss := wIni.ReadString('Operacoes', 'NFeEmiss', 'ACNFe');
    wInicial.OPES_HideShow := wIni.ReadInteger('Operacoes', 'HideShow', 0);
    wInicial.OpES_PathCfgIni := AjustaPathBarraFinal
      (wIni.ReadString('Operacoes', 'PathCfgIni', 'C:\DadosNFe'), True);
    wInicial.OpES_DirNFeNFCeDifer :=
      SN_Boolean(wIni.ReadString('Operacoes', 'DirNFeNFCeDifer', 'N'));
    wInicial.OpES_DiasLimpeza := wIni.ReadInteger('Operacoes',
      'DiasLimpeza', 7);
    wInicial.OpES_TpVendedor := wIni.ReadInteger('Operacoes', 'TpVendedor', 6);
    wInicial.OpES_Atendimentos :=
      SN_Boolean(wIni.ReadString('Operacoes', 'Atendimentos', 'N'));
    wInicial.OpES_PgtoMistoTEF :=
      SN_Boolean(wIni.ReadString('Operacoes', 'PgtoMistoTEF', 'S'));
    wInicial.OpES_NFeLotes :=
      SN_Boolean(wIni.ReadString('Operacoes', 'NFeLotes', 'N'));
    wInicial.OpES_ExibeBoletos :=
      SN_Boolean(wIni.ReadString('Operacoes', 'ExibeBoletos', 'N'));
    wInicial.OpES_NFComplDd :=
      SN_Boolean(wIni.ReadString('Operacoes', 'ComplementaDados', 'N'));
    wInicial.OpES_VlrQtd := SN_Boolean(wIni.ReadString('Operacoes',
      'CalcVlrQtd', 'N'));
    wInicial.OpES_UnQtdTrib :=
      SN_Boolean(wIni.ReadString('Operacoes', 'UnQtdTribut', 'N'));
    wInicial.OpES_PesqItemDestaq :=
      SN_Boolean(wIni.ReadString('Operacoes', 'AssinalaLinhaItem', 'S'));
    wInicial.OpES_EstOS1 := SN_Boolean(wIni.ReadString('Operacoes',
      'OS1Estoques', 'N'));
    wInicial.OpES_EstOS2 := SN_Boolean(wIni.ReadString('Operacoes',
      'OS2Estoques', 'N'));
    wInicial.OpES_UFST := wIni.ReadString('Operacoes', 'UFST',
      'AM;MA;MG;PA;PR;RJ;SC;SP');
    wInicial.OpES_CadasCPF :=
      SN_Boolean(wIni.ReadString('Operacoes', 'CadastraCPF', 'N'));
    wInicial.OpES_DdLiber := wIni.ReadInteger('Operacoes',
      'DiasLiberacao', 180);
    wInicial.OpES_VlrMax := wIni.ReadFloat('Operacoes',
      'VlrMaxSemIdent', 10000);
    wInicial.OpES_HistDFe := SN_Boolean(wIni.ReadString('Operacoes',
      'AtlzHistDFe', 'N'));
    wInicial.OpES_DistribObrigatorio :=
      SN_Boolean(wIni.ReadString('Operacoes', 'DistribuidorObrigatorio', 'N'));
    wInicial.OpES_MsgDifal :=
      SN_Boolean(wIni.ReadString('Operacoes', 'MsgDifal', 'N'));
    wInicial.OpES_UFDifAl := wIni.ReadString('Operacoes', 'UFDifAl',
      'SC,RJ,MG,GO,PR,SP');

    // OS Benhur Peças
    wInicial.OSUtiliza := SN_Boolean(wIni.ReadString('OSLoja', 'Utiliza', 'N'));
    wInicial.OSLogFile := wIni.ReadString('OSLoja', 'LogFile',
      '\Local\LogOSLoja2.log');
    wInicial.OSCondPagto := wIni.ReadString('OSLoja', 'CondPagto', '0123456');
    wInicial.Tecnicos := wIni.ReadInteger('OSLoja', 'Tecnicos', 7);
    wInicial.Emissao := wIni.ReadInteger('OSLoja', 'Emissao', 1);
    // Matr, Graf, Term, Escolha
    wInicial.PreviewOSLoja :=
      SN_Boolean(wIni.ReadString('OSLoja', 'Preview', 'S'));
    wInicial.LPP := wIni.ReadInteger('OSLoja', 'LPP', 6);
    wInicial.LCab1 := wIni.ReadString('OSLoja', 'LCab1', '...');
    wInicial.LCab2 := wIni.ReadString('OSLoja', 'LCab2',
      '95.020-360 Rua Ernesto Alves, 2337 Caxias do Sul  RS');
    wInicial.LCab3 := wIni.ReadString('OSLoja', 'LCab3',
      'Fone (54) 4009-4300   E-Mail: benhur@benhur.srv.br');
    wInicial.LObs01 := wIni.ReadString('OSLoja', 'LObs01',
      '1-Os aparelhos só serão entregues mediante a apresentação desta.');
    wInicial.LObs02 := wIni.ReadString('OSLoja', 'LObs02',
      '2-Só efetuamos consertos com pagamento A VISTA');
    wInicial.LObs03 := wIni.ReadString('OSLoja', 'LObs03',
      '3-Garantimos por 90 dias somente mao-de-obra');
    wInicial.LObs04 := wIni.ReadString('OSLoja', 'LObs04',
      '4-Autorizo o conserto do objeto constante deste documento e declaro estar ciente e de acord em retirá-lo impreterivelmente até');
    wInicial.LObs05 := wIni.ReadString('OSLoja', 'LObs05',
      '  30 dias a contar desta data.  Após este prazo autorizo a referida firma, a dispor do objeto da forma que melhor lhe convier,');
    wInicial.LObs06 := wIni.ReadString('OSLoja', 'LObs06',
      '  conforme disposto no art.1275 do Código Civil Brasileiro, sem prejuízo do art. 1278, a fim de ressarcir envetuais prejuízos.');
    wInicial.LObs07 := wIni.ReadString('OSLoja', 'LObs07',
      '5-Orçamento válido por 10 dias');
    wInicial.LObs08 := wIni.ReadString('OSLoja', 'LObs08', '');
    wInicial.LObs09 := wIni.ReadString('OSLoja', 'LObs09',
      'Concordo que ate R$__________________________ o conserto seja efetuado sem previo orçamento.');
    wInicial.LObs10 := wIni.ReadString('OSLoja', 'LObs10', '');
    wInicial.PrinterOSLoja := wIni.ReadString('OSLoja', 'PrinterOSLoja', '');
    wInicial.MsgOSLoja1 := wIni.ReadString('OSLoja', 'MsgOSLoja1', '');
    wInicial.MsgOSLoja2 := wIni.ReadString('OSLoja', 'MsgOSLoja2', '');

    // Locação de equipamentos (JJN)
    wInicial.Loc_IdGrupo := wIni.ReadString('Locacoes_Equipamentos', 'IdGrupo',
      'Equipamentos');
    wInicial.Loc_IdOperacao := wIni.ReadString('Locacoes_Equipamentos',
      'IdOperacoes', 'Locações');
    wInicial.Loc_Pr1 := wIni.ReadString('Locacoes_Equipamentos', 'IdPreco1',
      'Diario');
    wInicial.Loc_Pr2 := wIni.ReadString('Locacoes_Equipamentos', 'IdPreco2',
      'Semanal');
    wInicial.Loc_Pr3 := wIni.ReadString('Locacoes_Equipamentos', 'IdPreco3',
      'Mensal');
    wInicial.Loc_Pr4 := wIni.ReadString('Locacoes_Equipamentos', 'IdPreco4',
      'Horario');
    wInicial.Loc_Pr5 := wIni.ReadString('Locacoes_Equipamentos',
      'IdPreco5', '*');
    wInicial.Loc_PathContratos := wIni.ReadString('Locacoes_Equipamentos',
      'PathContratos', 'C:\Contratos');
    if not DirectoryExists(wInicial.Loc_PathContratos) then
      Try
        CreateDir(wInicial.Loc_PathContratos);
      Except
        MessageDlg('Falha - ' + wInicial.Loc_PathContratos, mtError, [mbOk], 0);
      End;
    wInicial.Loc_Margem := wIni.ReadFloat('Locacoes_Equipamentos',
      'Margem', 20);
    wInicial.Loc_HrDevol := wIni.ReadString('Locacoes_Equipamentos',
      'HoraDevol', '16:00');
    wInicial.Loc_Financeiro :=
      SN_Boolean(wIni.ReadString('Locacoes_Equipamentos', 'Financeiro', 'N'));

    // AGB - Gabatech
    wInicial.AGB_DdProd := wIni.ReadString('AGB_Producao', 'DdProduc',
      'C:\DadosProducao');
    wInicial.AGB_DdLocais := wIni.ReadString('AGB_Producao', 'DdLocais',
      'C:\DadosLocais');
    wInicial.AGB_DdImport := wIni.ReadString('AGB_Producao', 'DdImportacao',
      'C:\SISV4\Dados');
    if AnsiUpperCase(wIni.ReadString('AGB_Producao', 'Assinala', 'N')) = 'S'
    then
      wInicial.AGB_Assinala := True
    else
      wInicial.AGB_Assinala := False;
    wInicial.AGB_ImgFundo := wIni.ReadString('AGB_Producao', 'ImagemFundo',
      'Fundo.bmp');
    wInicial.AGB_LogoTela := wIni.ReadString('AGB_Producao', 'LogoTela',
      'SysLogo.bmp');
    wInicial.AGB_LogoPrint := wIni.ReadString('AGB_Producao', 'LogoPrint',
      'PrtLogo.bmp');
    wInicial.AGB_Quadro := wIni.ReadString('AGB_Producao', 'QuadroDiario',
      'Quadro.bmp');
    if AnsiUpperCase(wIni.ReadString('AGB_Producao', 'Legendas', 'N')) = 'S'
    then
      wInicial.AGB_OPLegendas := True
    else
      wInicial.AGB_OPLegendas := False;
    wInicial.AGB_DispMinimo := wIni.ReadInteger('AGB_Producao',
      'DispMinimo', 2);
    wInicial.AGB_MetrPadrao := wIni.ReadInteger('AGB_Producao',
      'MetrPadrao', 1000);
    wInicial.AGB_GrupoEstoque := wIni.ReadInteger('AGB_Producao',
      'GrupoEstoque', 99);

    {
      wInicial.AGB_BobA        := wIni.ReadString('AGB_VendasExternas','ImgBobA','');
      wInicial.AGB_BobB        := wIni.ReadString('AGB_VendasExternas','ImgBobB','');
      wInicial.AGB_BobC        := wIni.ReadString('AGB_VendasExternas','ImgBobC','');
      wInicial.AGB_BobD        := wIni.ReadString('AGB_VendasExternas','ImgBobD','');
      wInicial.AGB_Tubete      := wIni.ReadInteger('AGB_VendasExternas','Tubete',25);
      wInicial.AGB_FatorCliche := wIni.ReadFloat('AGB_VendasExternas','FatorCliche', 0.11);
      wInicial.AGB_Margem      := wIni.ReadFloat('AGB_VendasExternas','Margem', 25.00);
    }

    // Oficina do Frio
    if AnsiUpperCase(wIni.ReadString('OficinaDoFrio', 'Utiliza', 'N')) = 'S'
    then
      wInicial.OF_Utiliza := True
    else
      wInicial.OF_Utiliza := False;
    wInicial.OF_LPPadrao := wIni.ReadInteger('OficinaDoFrio',
      'LPrecoPadrao', 1);
    if AnsiUpperCase(wIni.ReadString('OficinaDoFrio', 'AtualizaCadastro', 'N'))
      = 'S' then
      wInicial.OF_AtzCadas := True
    else
      wInicial.OF_AtzCadas := False;
    wInicial.OF_RubPec := wIni.ReadInteger('OficinaDoFrio', 'RubPecaIE', 1);
    wInicial.OF_RubSrv := wIni.ReadInteger('OficinaDoFrio', 'RubServIE', 2);
    if AnsiUpperCase(wIni.ReadString('OficinaDoFrio', 'GeraVendaIE', 'N')) = 'S'
    then
      wInicial.OF_OSIE_EmiteNF := True
    else
      wInicial.OF_OSIE_EmiteNF := False;
    if AnsiUpperCase(wIni.ReadString('OficinaDoFrio', 'AltClienteIE', 'N')) = 'S'
    then
      wInicial.OF_OSIE_AltClie := True
    else
      wInicial.OF_OSIE_AltClie := False;
    wInicial.OF_OSIEImagem := wIni.ReadString('OficinaDoFrio', 'LogoOSIE', '');
    wInicial.OF_OSIEGarantia := wIni.ReadInteger('OficinaDoFrio',
      'GarantiaIE', 90);
    wInicial.OF_OSIEUltAtend := wIni.ReadInteger('OficinaDoFrio',
      'Atendimentos', 1);
    if AnsiUpperCase(wIni.ReadString('OficinaDoFrio', 'CNPJOSIE', 'N')) = 'S'
    then
      wInicial.OF_OSIECNPJ := True
    else
      wInicial.OF_OSIECNPJ := False;
    if AnsiUpperCase(wIni.ReadString('OficinaDoFrio', 'EMailOSIE', 'N')) = 'S'
    then
      wInicial.OF_OSIEEmail := True
    else
      wInicial.OF_OSIEEmail := False;
    wInicial.OF_RubPecAC := wIni.ReadInteger('OficinaDoFrio', 'RubPecaAC', 1);
    wInicial.OF_RubSrvAC := wIni.ReadInteger('OficinaDoFrio', 'RubServAC', 2);
    wInicial.OF_RubApaAC := wIni.ReadInteger('OficinaDoFrio', 'RubAparAC', 4);
    if AnsiUpperCase(wIni.ReadString('OficinaDoFrio', 'GeraVendaAC', 'N')) = 'S'
    then
      wInicial.OF_OSAC_EmiteNF := True
    else
      wInicial.OF_OSAC_EmiteNF := False;
    if AnsiUpperCase(wIni.ReadString('OficinaDoFrio', 'AltClienteAC', 'N')) = 'S'
    then
      wInicial.OF_OSAC_AltClie := True
    else
      wInicial.OF_OSAC_AltClie := False;
    wInicial.OF_OSACImagem := wIni.ReadString('OficinaDoFrio', 'LogoOSAC', '');
    wInicial.OF_OSACGarantia := wIni.ReadInteger('OficinaDoFrio',
      'GarantiaAC', 365);
    wInicial.OF_AparAC := wIni.ReadInteger('OficinaDoFrio', 'CodAparAC', 1031);
    wInicial.OF_SrvIAC := wIni.ReadInteger('OficinaDoFrio', 'CodServAC', 1533);
    if AnsiUpperCase(wIni.ReadString('OficinaDoFrio', 'CNPJOSAC', 'N')) = 'S'
    then
      wInicial.OF_OSACCNPJ := True
    else
      wInicial.OF_OSACCNPJ := False;
    if AnsiUpperCase(wIni.ReadString('OficinaDoFrio', 'EMailOSAC', 'N')) = 'S'
    then
      wInicial.OF_OSACEmail := True
    else
      wInicial.OF_OSACEmail := False;
    wInicial.OF_TxLinBranca := wIni.ReadFloat('OficinaDoFrio',
      'TxLinhaBranca', 70);
    wInicial.OF_TxArCond := wIni.ReadFloat('OficinaDoFrio',
      'TxArCondicionado', 100);
    if AnsiUpperCase(wIni.ReadString('OficinaDoFrio', 'ServEspTec', 'N')) = 'S'
    then
      wInicial.OF_ServEspTec := True
    else
      wInicial.OF_ServEspTec := False;
    if AnsiUpperCase(wIni.ReadString('OficinaDoFrio', 'PrintTaxa', 'N')) = 'S'
    then
      wInicial.OF_PrintTaxa := True
    else
      wInicial.OF_PrintTaxa := False;
    wInicial.OF_LogOSIE := wIni.ReadString('OficinaDoFrio', 'LogOSIE',
      'C:\SISV\Dados\LogOSIE.log');
    wInicial.OF_OSIEMinLin := wIni.ReadInteger('OficinaDoFrio',
      'MinimoLinhas', 6);
    wInicial.OF_LogOSAC := wIni.ReadString('OficinaDoFrio', 'LogOSAC',
      'C:\SISV\Dados\LogOSAC.log');
    wInicial.OF_ScanIEPath := wIni.ReadString('OficinaDoFrio', 'ScanIEPath',
      'C:\Imagens\IE');
    wInicial.OF_ScanIEDiv := wIni.ReadInteger('OficinaDoFrio', 'ScanIEDiv', 0);
    wInicial.OF_ScanACPath := wIni.ReadString('OficinaDoFrio', 'ScanACPath',
      'C:\Imagens\AC');
    wInicial.OF_ScanACDiv := wIni.ReadInteger('OficinaDoFrio', 'ScanACDiv', 0);

    wInicial.OF_LGGrp1 := wIni.ReadInteger('OF_LG', 'Grupo1', 88);
    wInicial.OF_LGGrp2 := wIni.ReadInteger('OF_LG', 'Grupo2', 157);
    wInicial.OF_LGGrp3 := wIni.ReadInteger('OF_LG', 'Grupo3', 0);
    wInicial.OF_LGGrp4 := wIni.ReadInteger('OF_LG', 'Grupo4', 0);
    wInicial.OF_LGMar1 := wIni.ReadInteger('OF_LG', 'Marca1', 88);
    wInicial.OF_LGMar2 := wIni.ReadInteger('OF_LG', 'Marca2', 0);

    wInicial.OF_OSEspCliente := wIni.ReadString('OF_OSEspecial', 'Cliente',
      'Cliente/Nome do cliente');
    wInicial.OF_OSEspComss := wIni.ReadFloat('OF_OSEspecial', 'Comissao', 2);
    wInicial.OF_PrazoPadrao := wIni.ReadInteger('OF_OSEspecial',
      'PrazoPadrao', 7);
    wInicial.OF_PlanilhaPadrao := wIni.ReadString('OF_OSEspecial',
      'PlanilhaPadrao', 'C:\PlanilhaPadrao.xls');
    wInicial.OF_Prestador := wIni.ReadString('OF_OSEspecial', 'Prestador',
      'Nome do prestador de serviços');
    wInicial.OF_LPreco := wIni.ReadInteger('OF_OSEspecial', 'LPreco', 1);
    wInicial.OF_OSEspCFOPDev := wIni.ReadInteger('OF_OSEspecial',
      'CFOPDevolucao', 5916);
    wInicial.OF_OSEspCadas := wIni.ReadInteger('OF_OSEspecial', 'CodCadas', 0);
    wInicial.OF_OSEspEmpFil := wIni.ReadInteger('OF_OSEspecial', 'EmpFil', 0);
    wInicial.OF_OSEspTeste := SN_Boolean(wIni.ReadString('OF_OSEspecial',
      'Teste', 'N'));

    wInicial.OF_ACVend01 := wIni.ReadString('OF_VendedorAC', 'ACVend01',
      'Vendedor1');
    wInicial.OF_ACCodV01 := wIni.ReadInteger('OF_VendedorAC', 'ACCodV01', 0);
    wInicial.OF_ACVend02 := wIni.ReadString('OF_VendedorAC', 'ACVend02',
      'Vendedor2');
    wInicial.OF_ACCodV02 := wIni.ReadInteger('OF_VendedorAC', 'ACCodV02', 0);
    wInicial.OF_ACVend03 := wIni.ReadString('OF_VendedorAC', 'ACVend03',
      'Vendedor3');
    wInicial.OF_ACCodV03 := wIni.ReadInteger('OF_VendedorAC', 'ACCodV03', 0);
    wInicial.OF_ACVend04 := wIni.ReadString('OF_VendedorAC', 'ACVend04',
      'Vendedor4');
    wInicial.OF_ACCodV04 := wIni.ReadInteger('OF_VendedorAC', 'ACCodV04', 0);
    wInicial.OF_ACVend05 := wIni.ReadString('OF_VendedorAC', 'ACVend05',
      'Vendedor5');
    wInicial.OF_ACCodV05 := wIni.ReadInteger('OF_VendedorAC', 'ACCodV05', 0);

    // Estrutura de produtos
    wInicial.EP_Ins1 := wIni.ReadInteger('Estruturas', 'GrpInsumo1', -1);
    wInicial.EP_Ins2 := wIni.ReadInteger('Estruturas', 'GrpInsumo2', -1);
    wInicial.EP_Ins3 := wIni.ReadInteger('Estruturas', 'GrpInsumo3', -1);
    wInicial.EP_Ins4 := wIni.ReadInteger('Estruturas', 'GrpInsumo4', -1);
    wInicial.EP_Ins5 := wIni.ReadInteger('Estruturas', 'GrpInsumo5', -1);
    wInicial.EP_Valorizacao := wIni.ReadInteger('Estruturas', 'Valorizacao', 1);
    wInicial.EP_DiasCalculo := wIni.ReadInteger('Estruturas',
      'DiasCalculo', 60);
    wInicial.EP_DecQtd := wIni.ReadInteger('Estruturas', 'DecQtd', 5);
    wInicial.EP_DecVlr := wIni.ReadInteger('Estruturas', 'DecVlr', 3);

    // Compactação e envio XML e PDF das NFe
    wInicial.EnvNFE_PathDestino := wIni.ReadString('EnvioXMLDanfe',
      'PathDestino', 'C:\');
    wInicial.EnvNFE_Envio := AnsiUpperCase(wIni.ReadString('EnvioXMLDanfe',
      'Envio', 'Interno'));
    wInicial.EnvNFE_Arquivos := AnsiUpperCase(wIni.ReadString('EnvioXMLDanfe',
      'Arquivos', 'XML PDF'));
    wInicial.EnvNFE_Compressao :=
      UpperCase(wIni.ReadString('EnvioXMLDanfe', 'Compressao', 'RAR'));
    wInicial.EnvNFE_Destinatario := wIni.ReadString('EnvioXMLDanfe',
      'Destinatario', 'softcon.cx@gmail.com');

    // Padrões afiliação - cartões
    wInicial.PadraoCredito := wIni.ReadInteger('AfiliacaoCartao', 'Credito', 1);
    wInicial.PadraoDebito := wIni.ReadInteger('AfiliacaoCartao', 'Debito', 1);

    // FastFood
    wInicial.FFood_Modulos := wIni.ReadString('FastFood', 'Modulos', 'BMTNXG');
    if wIni.ReadString('FastFood', 'Configura', 'N') = 'S' then
      wInicial.FFood_Configura := True
    else
      wInicial.FFood_Configura := False;
    if wIni.ReadString('FastFood', 'UsaFluxos', 'N') = 'S' then
      wInicial.FFood_UsaFluxos := True
    else
      wInicial.FFood_UsaFluxos := False;
    if wIni.ReadString('FastFood', 'LstSenha', 'N') = 'S' then
      wInicial.FFood_LstSenha := True
    else
      wInicial.FFood_LstSenha := False;
    wInicial.FFood_TamSenha := wIni.ReadInteger('FastFood', 'TamSenha', 3);
    if wIni.ReadString('FastFood', 'LstObserv', 'N') = 'S' then
      wInicial.FFood_LstObserv := True
    else
      wInicial.FFood_LstObserv := False;
    if wIni.ReadString('FastFood', 'IniciaTurno', 'N') = 'S' then
      wInicial.FFood_IniciaTurno := True
    else
      wInicial.FFood_IniciaTurno := False;
    wInicial.FFood_CaixaNr := wIni.ReadString('FastFood', 'CaixaNr', '01');
    wInicial.FFood_LPPadrao := wIni.ReadInteger('FastFood', 'LPPadrao', 1);
    if wIni.ReadString('FastFood', 'NomeObrig', 'N') = 'S' then
      wInicial.FFood_NomeObrig := True
    else
      wInicial.FFood_NomeObrig := False;
    if wIni.ReadString('FastFood', 'Cadastro', 'N') = 'S' then
      wInicial.FFood_Cadastro := True
    else
      wInicial.FFood_Cadastro := False;
    if wIni.ReadString('FastFood', 'Desconto', 'N') = 'S' then
      wInicial.FFood_Desconto := True
    else
      wInicial.FFood_Desconto := False;
    if wIni.ReadString('FastFood', 'DescAutom', 'N') = 'S' then
      wInicial.FFood_DescAutom := True
    else
      wInicial.FFood_DescAutom := False;
    wInicial.FFood_Imprime_Cli := wIni.ReadInteger('FastFood',
      'Imprime_Cli', 2);
    wInicial.FFood_Imprime_Int := wIni.ReadInteger('FastFood',
      'Imprime_Int', 2);
    wInicial.FFood_Emite_CF := wIni.ReadInteger('FastFood', 'EMITE_CF', 2);
    wInicial.FFood_Emite_CFTele := wIni.ReadInteger('FastFood',
      'EMITE_CFTele', 2);

    if wIni.ReadString('FastFood', 'Preview', 'S') = 'S' then
      wInicial.FFood_Preview := True
    else
      wInicial.FFood_Preview := False;
    if wIni.ReadString('FastFood', 'PrintDialog', 'S') = 'S' then
      wInicial.FFood_PrintDialog := True
    else
      wInicial.FFood_PrintDialog := False;
    if wIni.ReadString('FastFood', 'ComplMesa', 'N') = 'S' then
      wInicial.FFood_ComplMesa := True
    else
      wInicial.FFood_ComplMesa := False;
    if wIni.ReadString('FastFood', 'CancPedido', 'N') = 'S' then
      wInicial.FFood_CancPedido := True
    else
      wInicial.FFood_CancPedido := False;
    if wIni.ReadString('FastFood', 'Exportacao', 'N') = 'S' then
      wInicial.FFood_Exportacao := True
    else
      wInicial.FFood_Exportacao := False;
    wInicial.FFood_PrinterId := wIni.ReadString('FastFood',
      'PrinterId', 'Term');
    wInicial.FFood_ViasBalMesa := wIni.ReadInteger('FastFood',
      'ViasBalMesa', 1);
    wInicial.FFood_ViasTele := wIni.ReadInteger('FastFood', 'ViasTele', 1);
    wInicial.FFood_Cab01 := wIni.ReadString('FastFood', 'Cab01',
      '1a.linha cabeçalho');
    wInicial.FFood_Cab02 := wIni.ReadString('FastFood', 'Cab02',
      '2a.linha cabeçalho');
    wInicial.FFood_Cab03 := wIni.ReadString('FastFood', 'Cab03',
      '3a.linha cabeçalho');
    wInicial.FFood_Cab04 := wIni.ReadString('FastFood', 'Cab04',
      '4a.linha cabeçalho');
    wInicial.FFood_LogoPrint := wIni.ReadString('FastFood', 'LogoPrint',
      'C:\LogoFastFood');
    wInicial.FFood_LogoCozin := wIni.ReadString('FastFood', 'LogoCozin',
      'C:\LogoCozinha');
    wInicial.FFood_AvFinal := wIni.ReadInteger('FastFood', 'Avanco', 12);

    wInicial.FFood_SenConfig :=
      AnsiUpperCase(wIni.ReadString('FastFood', 'SenConfig', 'SENHA1'));
    wInicial.FFood_Cad_Obsrv := wIni.ReadString('FastFood', 'Cad_Obsrv',
      'Observações / Próximo de:');
    wInicial.FFood_Cad_Aglut := wIni.ReadString('FastFood', 'Cad_Aglut',
      'Responsável');
    wInicial.FFood_Cad_Fecha := wIni.ReadString('FastFood', 'Cad_Fecha',
      'Depend/Empreg');
    wInicial.FFood_Cad_EmPag := wIni.ReadString('FastFood',
      'Cad_EmPag', 'Resp');
    wInicial.FFood_Cad_Relac := wIni.ReadString('FastFood', 'Cad_Relac',
      'Relação');
    wInicial.FFood_ECFS_Nome := wIni.ReadString('FastFood', 'ECFS_Nome',
      'Consumidor'); // xDocFiscal
    wInicial.FFood_ECFS_Descr := wIni.ReadString('FastFood', 'ECFS_Descr',
      'Despesa / refeição');
    wInicial.FFood_ECFS_CodProd := wIni.ReadString('FastFood', 'ECFS_CodProd',
      'REF001');
    wInicial.FFood_ECFS_Foco := wIni.ReadInteger('FastFood', 'ECFS_Foco', 1);
    wInicial.FFood_ECFS_VlRec := wIni.ReadInteger('FastFood', 'ECFS_VlRec', 2);
    wInicial.FFood_ECFS_TimeOut := wIni.ReadInteger('FastFood',
      'ECFS_TimeOut', 250);
    wInicial.FFood_ECFS_Valores := wIni.ReadInteger('FastFood',
      'ECFS_Valores', 20);
    wInicial.FFood_Aliq25 := wIni.ReadString('FastFood', 'Aliq25', '04');
    // Aliquota no ECF
    wInicial.FFood_Aliq18 := wIni.ReadString('FastFood', 'Aliq18', '01');
    wInicial.FFood_Aliq17 := wIni.ReadString('FastFood', 'Aliq17', '02');
    wInicial.FFood_Aliq12 := wIni.ReadString('FastFood', 'Aliq12', '03');
    wInicial.FFood_Aliq07 := wIni.ReadString('FastFood', 'Aliq07', '05');
    wInicial.FFood_Aliq04 := wIni.ReadString('FastFood', 'Aliq04', '06');

    wInicial.FFood_CFOP := wIni.ReadString('FastFood', 'CFOP', '5102');
    wInicial.FFood_NCM := wIni.ReadString('FastFood', 'NCM', '21069090');
    wInicial.FFood_NDAvanco := wIni.ReadInteger('FastFood', 'NDAvanco', 10);
    wInicial.FFood_TotTrib := wIni.ReadInteger('FastFood', 'Tributacao', 0);
    if wIni.ReadString('FastFood', 'PrintRAW', 'N') = 'S' then
      wInicial.FFood_RAW := True
    else
      wInicial.FFood_RAW := False;
    wInicial.FFood_Cab1RAW := wIni.ReadString('FastFood', 'RawCab1',
      'Linha 1 de cabeçalho');
    wInicial.FFood_Cab2RAW := wIni.ReadString('FastFood', 'RawCab2',
      'Linha 2 de cabeçalho');
    wInicial.FFood_Cab3RAW := wIni.ReadString('FastFood', 'RawCab3',
      'Linha 3 de cabeçalho');
    wInicial.FFood_Cab4RAW := wIni.ReadString('FastFood', 'RawCab4',
      'Linha 4 de cabeçalho');
    wInicial.FFood_IdPedRAW := wIni.ReadString('FastFood', 'RawTicket',
      'Id Pedido');
    wInicial.FFood_DescrUnica := wIni.ReadString('FastFood', 'DescrUnica',
      'Refeições');
    wInicial.FFood_CodUnica := wIni.ReadString('FastFood', 'CodUnica',
      'COM001');
    wInicial.FFood_DescrSTItens := wIni.ReadString('FastFood', 'Bebidas',
      'Bebidas e Alimentos industrializados');
    wInicial.FFood_CodSTItens := wIni.ReadString('FastFood', 'CodBeb',
      'BEB001');
    wInicial.FFood_DescrItens := wIni.ReadString('FastFood', 'Refeicoes',
      'Lanches e Petiscos');
    wInicial.FFood_CodItens := wIni.ReadString('FastFood', 'CodRef', 'LAN001');
    if wIni.ReadString('FastFood', 'PedUsoNFe', 'N') = 'S' then
      wInicial.FFood_PedUsoNFe := True
    else
      wInicial.FFood_PedUsoNFe := False;
    if wIni.ReadString('FastFood', 'PedRelacNFe', 'S') = 'S' then
      wInicial.FFood_PedRelacNFe := True
    else
      wInicial.FFood_PedRelacNFe := False;
    if wIni.ReadString('FastFood', 'PreviewDanfe', 'N') = 'S' then
      wInicial.FFood_VisDANFE := True
    else
      wInicial.FFood_VisDANFE := False;
    wInicial.FFood_NFePrinter := wIni.ReadString('FastFood', 'NFePrinter', '');
    wInicial.FFood_AvExtra := wIni.ReadInteger('FastFood', 'AvancoExtra', 0);
    wInicial.FFood_IniBalcao := wIni.ReadInteger('FastFood', 'InicioBalcao', 0);
    // 0-Cliente  1-Item incluir
    wInicial.FFood_FinBalcao := wIni.ReadInteger('FastFood', 'FinalBalcao', 0);
    // 0-Cliente  1-Valor recebido
    if wIni.ReadString('FastFood', 'TicketSimples', 'N') = 'S' then
      wInicial.FFood_TicketSimples := True
    else
      wInicial.FFood_TicketSimples := False;
    if wIni.ReadString('FastFood', 'TransacaoFinal', 'N') = 'S' then
      wInicial.FFood_TransFinal := True
    else
      wInicial.FFood_TransFinal := False;
    if wIni.ReadString('FastFood', 'Kiosk', 'N') = 'S' then
      wInicial.FFood_Kiosk := True
    else
      wInicial.FFood_Kiosk := False;
    wInicial.FFood_PathIntegr := wIni.ReadString('FastFood', 'PathIntegr',
      wInicial.DatabasePath);
    if wIni.ReadString('FastFood', 'KioskCoord', 'N') = 'S' then
      wInicial.FFood_KioskCoord := True
    else
      wInicial.FFood_KioskCoord := False;
    wInicial.FFood_KioskMaxProd := wIni.ReadInteger('FastFood',
      'KioskMaxProd', 12);
    wInicial.FFood_KioskMaxItens := wIni.ReadInteger('FastFood',
      'KioskMaxItens', 20);
    if wIni.ReadString('FastFood', 'CaixaUnico', 'N') = 'S' then
      wInicial.FFood_CaixaUnico := True
    else
      wInicial.FFood_CaixaUnico := False;
    wInicial.FFood_CaixaPathId := wIni.ReadString('FastFood',
      'CaixaPathId', '');

    // NFe RvCar
    wInicial.RvCar_ImgFundo := wIni.ReadString('NfeRvCar', 'ImagemFundo',
      'C:\RVCar\Executaveis\Fundo_NFeRvCar.jpg');
    wInicial.RvCar_ImgLogo := wIni.ReadString('NfeRvCar', 'ImagemLogo',
      'C:\RVCar\Executaveis\LogoNFe.jpg');
    wInicial.RvCar_Inf0 := wIni.ReadString('NfeRvCar', 'Inf0', 'ANO FAB:');
    wInicial.RvCar_Tag0 := wIni.ReadString('NfeRvCar', 'Tag0', '<ANOFAB>');
    wInicial.RvCar_Inf1 := wIni.ReadString('NfeRvCar', 'Inf1', 'ANO MOD:');
    wInicial.RvCar_Tag1 := wIni.ReadString('NfeRvCar', 'Tag1', '<ANOMOD>');
    wInicial.RvCar_Inf2 := wIni.ReadString('NfeRvCar', 'Inf2', 'COR:');
    wInicial.RvCar_Tag2 := wIni.ReadString('NfeRvCar', 'Tag2', '<COR>');
    wInicial.RvCar_Inf3 := wIni.ReadString('NfeRvCar', 'Inf3', 'Nr Chassi:');
    wInicial.RvCar_Tag3 := wIni.ReadString('NfeRvCar', 'Tag3', '<CHASSI>');
    wInicial.RvCar_Inf4 := wIni.ReadString('NfeRvCar', 'Inf4', 'Combustivel:');
    wInicial.RvCar_Tag4 := wIni.ReadString('NfeRvCar', 'Tag4', '<COMB>');
    wInicial.RvCar_Inf5 := wIni.ReadString('NfeRvCar', 'Inf5', 'Marca:');
    wInicial.RvCar_Tag5 := wIni.ReadString('NfeRvCar', 'Tag5', '<MARCA>');
    wInicial.RvCar_Inf6 := wIni.ReadString('NfeRvCar', 'Inf6', 'Modelo:');
    wInicial.RvCar_Tag6 := wIni.ReadString('NfeRvCar', 'Tag6', '<MODELO>');
    wInicial.RvCar_Inf7 := wIni.ReadString('NfeRvCar', 'Inf7', 'Renavam:');
    wInicial.RvCar_Tag7 := wIni.ReadString('NfeRvCar', 'Tag7', '<RENVAM>');
    wInicial.RvCar_Inf8 := wIni.ReadString('NfeRvCar', 'Inf8', '');
    wInicial.RvCar_Tag8 := wIni.ReadString('NfeRvCar', 'Tag8', '');
    wInicial.RvCar_Inf9 := wIni.ReadString('NfeRvCar', 'Inf9', '');
    wInicial.RvCar_Tag9 := wIni.ReadString('NfeRvCar', 'Tag9', '');
    wInicial.RvCar_ModoNFe := wIni.ReadInteger('NfeRvCar', 'ModoNFe', 0);
    wInicial.RvCar_Encad := wIni.ReadInteger('NFeRvCar', 'Encadeamento', 0);
    wInicial.RvCar_VerNFe := wIni.ReadString('NfeRvCar', 'VersaoNFe', 'Indef');
    wInicial.RvCar_ExeNFe := wIni.ReadString('NfeRvCar', 'ExecNFe', 'ACNFe');
    wInicial.RvCar_TimeOut := wIni.ReadInteger('NfeRvCar', 'TimeOut', 90);
    if wIni.ReadString('NfeRvCar', 'HorarioVerao', 'N') = 'S' then
      wInicial.RvCar_HrVerao := True
    else
      wInicial.RvCar_HrVerao := False;
    wInicial.RvCar_HVIni := wIni.ReadDate('NfeRvCar', 'HV_Inicio',
      DateOf(Date + 3650));
    wInicial.RvCar_HVFin := wIni.ReadDate('NfeRvCar', 'HV_Final',
      DateOf(Date + 3770));
    wInicial.RvCar_PathCfg := wIni.ReadString('NfeRvCar', 'PathConfigsNFe',
      'C:\RVCar\Executaveis');
    wInicial.RvCar_ModBC := wIni.ReadInteger('NfeRvCar', 'ModBC', 3);
    wInicial.RvCar_ModBCST := wIni.ReadInteger('NfeRvCar', 'ModBCST', 3);
    wInicial.RvCar_DigRenavam := wIni.ReadInteger('NfeRvCar', 'DigRenavam', 10);
    if wIni.ReadString('NFeRvCar', 'ValRenavam', 'S') = 'S' then
      wInicial.RvCar_ValRenavam := True
    else
      wInicial.RvCar_ValRenavam := False;
    if wIni.ReadString('NFeRvCar', 'MC5464', 'S') = 'S' then
      wInicial.RvCar_MC5464 := True
    else
      wInicial.RvCar_MC5464 := False;
    wInicial.RvCar_NVE := wIni.ReadString('NFeRvCar', 'NVE', '');
    wInicial.RvCar_CEST := wIni.ReadString('NFeRvCar', 'CEST', '2500600');
    wInicial.RvCar_cBenef := wIni.ReadString('NFeRvCar', 'cBenef', 'RS051620');
    wInicial.RvCar_CFOPVendaUF := wIni.ReadInteger('NFeRvCar_CFOP_UF',
      'VENDA', 5102);
    wInicial.RvCar_CFOPDevolUF := wIni.ReadInteger('NFeRvCar_CFOP_UF',
      'DEVOL', 5913);
    wInicial.RvCar_CFOPEntraUF := wIni.ReadInteger('NFeRvCar_CFOP_UF',
      'ENTRA', 1102);
    wInicial.RvCar_CFOPVendaOUF := wIni.ReadInteger('NFeRvCar_CFOP_OutraUF',
      'VENDA', 6102);
    wInicial.RvCar_CFOPDevolOUF := wIni.ReadInteger('NFeRvCar_CFOP_OutraUF',
      'DEVOL', 6913);
    wInicial.RvCar_CFOPEntraOUF := wIni.ReadInteger('NFeRvCar_CFOP_OutraUF',
      'ENTRA', 2102);

    // Consignacoes - 1  (Happy Semi-Joias)
    wInicial.Csg1_Empresa := wIni.ReadInteger('Consig1', 'Empresa', 1);
    if wIni.ReadString('Consig1', 'LctUnitario', 'N') = 'S' then
      wInicial.Csg1_QtdLct := True
    else
      wInicial.Csg1_QtdLct := False;
    if wIni.ReadString('Consig1', 'EstNegativo', 'N') = 'S' then
      wInicial.Csg1_EstNeg := True
    else
      wInicial.Csg1_EstNeg := False;
    if wIni.ReadString('Consig1', 'AltPreco', 'N') = 'S' then
      wInicial.Csg1_AltPreco := True
    else
      wInicial.Csg1_AltPreco := False;
    wInicial.Csg1_Campo := wIni.ReadInteger('Consig1', 'CampoInfo', 3);
    if wIni.ReadString('Consig1', 'StopVTotal', 'N') = 'S' then
      wInicial.Csg1_StopVTotal := True
    else
      wInicial.Csg1_StopVTotal := False;
    if wIni.ReadString('Consig1', 'RepItem', 'N') = 'S' then
      wInicial.Csg1_RepItem := True
    else
      wInicial.Csg1_RepItem := False;
    if wIni.ReadString('Consig1', 'Consolid', 'N') = 'S' then
      wInicial.Csg1_Consolid := True
    else
      wInicial.Csg1_Consolid := False;
    wInicial.Csg1_Logo10x7 := wIni.ReadString('Consig1', 'Logo10x7', '');
    if wIni.ReadString('Consig1', 'LstSitu', 'N') = 'S' then
      wInicial.Csg1_LstSitu := True
    else
      wInicial.Csg1_LstSitu := False;
    wInicial.Csg1_TpDoc := wIni.ReadInteger('Consig1', 'TpDoc', 1);

    // Mecanico
    if wIni.ReadString('Mecanico', 'Chassi', 'N') = 'S' then
      wInicial.MecChassi := True
    else
      wInicial.MecChassi := False;
    if wIni.ReadString('Mecanico', 'Renavam', 'N') = 'S' then
      wInicial.MecRenavam := True
    else
      wInicial.MecRenavam := False;

  end;

  wIni.Free;
  if Length(Trim(FuIniGeral.appPath)) = 0 then
    FuIniGeral.appPath := FuIniGeral.wInicial.DatabasePath;
  //
  FGen.lSalvaForm := FuIniGeral.wInicial.SalvaForm;
  FGen.pathSalvaForm := FuIniGeral.wInicial.PathLocal;
  FGen.LDebug := FuIniGeral.wInicial.LDebug;
  FGen.LDebugNFe := FuIniGeral.wInicial.LDebugNFe;

end;

Procedure SalvaParametrosIni(pLocal, pGeral: Boolean; pModulos: String = '';
  pArqIniEstacao: String = '');
var
  wIniName: String;
  wIni: TIniFile;
  wAux: String;
  wModulos: String;
begin
  if Pos('IniSys', FuIniGeral.appName) = 0 then
    if not FuIniGeral.wInicial.LSalvaParam then
      Exit;
  //
  wModulos := AnsiUpperCase(pModulos);
  if Length(Trim(wModulos)) = 0 then
    wModulos := 'TODOS';
  {
    em pModulos:  Se vazio, brancos ou Todos -> Grava TODOS os blocos de parametros
    Separar as informações de pModo por espaços (Ex: EPed ECaixa S   )
    Parametros locais (Estacao.Ini)
    Blocos [Conexao][Dados]..........Sempre serão salvos
    [Pedidos].................EPED
    [CaixaLocal]..............ECAIXA
    [Gerenciador][Balcao].....EGEREN
    Parametros gerais (SISV.Ini)
    Blocos [Identificacao][Dados][EMail][Padroes] ................Sempre serão salvos
    [Financeiro]...........................................FINANC
    [Estoques][Estoques_Entradas][Estoques_Tributacao].....ESTOQUES
    [Vendas_CFOP][Operacoes]...............................VENDAS
    [OSLoja]...............................................OSLOJA
    [Locacoes_Equipamentos]................................LOCEQUIP
    [AGB_PRODUCAO].........................................AGB
    [
    [OF_OSEspecial]........................................OFRIO
    [Estruturas]...........................................ESTRUTURAS
    [EnvioXMLDANFE]........................................ENVIOXMLDANFE
    [ACBrMonitor][Boletos_ACBr][ACBr_CEP]..................ACBR
    [FastFood].............................................FASTFOOD
    [RvCar]................................................NFeRvCar
  }
  with FuIniGeral do
  begin
    if pLocal then
    begin
      if Pos('IniSys', FuIniGeral.appName) > 0 then
      begin
        wIniName := pArqIniEstacao;
        DeleteFile(wIniName);
      end
      else
        wIniName := appPath + 'Estacao.ini';
      wIni := TIniFile.Create(wIniName);
      wIni.WriteString('Conexao', 'IdEstacao', wInicial.IdEstacao);
      wIni.WriteString('Conexao', 'Drive', wInicial.DriveRemoto);
      wIni.WriteString('Conexao', 'Path', wInicial.Caminho);
      wIni.WriteString('Conexao', 'Senha', wInicial.Senha);
      wIni.WriteString('Conexao', 'Desconecta',
        Boolean_SN(wInicial.Desconecta));
      wIni.WriteString('Conexao', 'Usuario', wInicial.Usuario);
      wIni.WriteString('Conexao', 'SalvaForm', Boolean_SN(wInicial.SalvaForm));
      wIni.WriteString('Conexao', 'ServidorCliente', wInicial.ServClie);
      wIni.WriteString('Conexao', 'FonteTexto', wInicial.FonteNome);
      wIni.WriteInteger('Conexao', 'FonteTam', wInicial.FonteTam);
      wIni.WriteString('Conexao', 'ImagemFundo', wInicial.ImagemFundo);

      wIni.WriteString('Dados', 'Parametros', wInicial.Parametros);
      wIni.WriteString('Dados', 'PathLocal', wInicial.PathLocal);
      wIni.WriteString('Dados', 'PathRelatorios', wInicial.PathRelatorios);
      wIni.WriteInteger('Dados', 'LPP', wInicial.LinPolegada);
      wIni.WriteString('Dados', 'PathEstacaoTrabalho',
        wInicial.PathEstacaoTrabalho);
      wIni.WriteString('Dados', 'NrEstacao', wInicial.NrEstacao);
      wIni.WriteString('Dados', 'Debug', Boolean_SN(wInicial.LDebug));
      wIni.WriteString('Dados', 'DebugNFe', Boolean_SN(wInicial.LDebugNFe));
      wIni.WriteString('Dados', 'SalvaParam', Boolean_SN(wInicial.LSalvaParam));
      wIni.WriteString('Dados', 'Suporte', Boolean_SN(wInicial.LSuporte));
      wIni.WriteString('Dados', 'DownLoadNFe',
        Boolean_SN(wInicial.LDownLoadNFe));
      wIni.WriteString('Dados', 'LeituraNFe', Boolean_SN(wInicial.LLeituraNFe));
      wIni.WriteString('Dados', 'FluxoFinanceiro',
        Boolean_SN(wInicial.LFluxoFinanceiro));
      wIni.WriteString('Dados', 'QtdLPreco',
        Boolean_SN(wInicial.LExibQtdLPrecos));
      wIni.WriteString('Dados', 'GridLinDestaq',
        Boolean_SN(wInicial.LGridLinDestaq));
      wIni.WriteString('Dados', 'GridCorDestaq',
        ColorToString(wInicial.CorLinDestaq));
      wIni.WriteString('Dados', 'PrintCorDestaq',
        ColorToString(wInicial.CorPrtDestaq));
      wIni.WriteInteger('Dados', 'PrintLinDestaq', wInicial.LinPrtDestaq);
      wIni.WriteString('Dados', 'GridHeaderDestaq',
        ColorToString(wInicial.CorHeaderDestaq));
      wIni.WriteString('Dados', 'GridColumnDestaq',
        ColorToString(wInicial.CorColumnDestaq));
      wIni.WriteString('Dados', 'BoxDestaq',
        ColorToString(wInicial.CorBoxDestaq));
      wIni.WriteString('Dados', 'UsaEsquemaCores',
        Boolean_SN(wInicial.UsaEsquemaCores));
      wIni.WriteString('Dados', 'ColunaNegrito',
        Boolean_SN(wInicial.ColunaNegrito));
      wIni.WriteString('Dados', 'UsaWhatsApp',
        Boolean_SN(wInicial.UsaWhatsApp));
      wIni.WriteString('Dados', 'PathWhatsApp', wInicial.PathWhatsApp);
      wIni.WriteString('Dados', 'PathWAEnvio', wInicial.PathWAEnvio);
      wIni.WriteInteger('dados', 'TamPagTermica', wInicial.TamPagTerm);

      if (wModulos = 'TODOS') or (Pos('EPED', wModulos) > 0) then
      begin
        wIni.WriteString('Pedidos', 'EmitePedidos',
          Boolean_SN(wInicial.EmitePedidos));
        wIni.WriteString('Pedidos', 'Impressora', wInicial.ImpressoraPedidos);
        wIni.WriteInteger('Pedidos', 'Vias', wInicial.ViasPedidos);
        wIni.WriteString('Pedidos', 'Preview',
          Boolean_SN(wInicial.PreviewPedidos));
        wIni.WriteString('Pedidos', 'Negrito',
          Boolean_SN(wInicial.PedidosNegrito));
        wIni.WriteInteger('Pedidos', 'MargemEsquerda', wInicial.MargemEsquerda);
        wIni.WriteInteger('Pedidos', 'MargemDireita', wInicial.MargemDireita);
        wIni.WriteInteger('Pedidos', 'PedidoLocal', wInicial.PedidoLocal);
      end;

      if (wModulos = 'TODOS') or (Pos('ECAIXA', wModulos) > 0) then
      begin
        wIni.WriteString('CaixaLocal', 'Caixa', Boolean_SN(wInicial.CxLocal));
        wIni.WriteInteger('CaixaLocal', 'Numero', wInicial.CxLocalNro);
        wIni.WriteInteger('CaixaLocal', 'EFPadrao', wInicial.CxLocalEF);
        wIni.WriteString('CaixaLocal', 'TipoImpressao',
          wInicial.CxLocalTpImpress);
        wIni.WriteString('CaixaLocal', 'Preview',
          Boolean_SN(wInicial.CxLocalPreview));
        wIni.WriteString('CaixaLocal', 'Impressora',
          wInicial.CxLocalImpressora);
        wIni.WriteString('CaixaLocal', 'PathCaixa', wInicial.CxPathCaixa);
        wIni.WriteString('CaixaLocal', 'PathExecBalcao',
          wInicial.CxPathExBalcao);
        wIni.WriteString('CaixaLocal', 'PathExecGeren', wInicial.CxPathExGeren);
        wIni.WriteString('CaixaLocal', 'CaixaExclusivo',
          Boolean_SN(wInicial.CxExclusivo));
        wIni.WriteString('CaixaLocal', 'Pedidos',
          Boolean_SN(wInicial.CxPedido));
        wIni.WriteString('CaixaLocal', 'NFElet', Boolean_SN(wInicial.CxNFElet));
        wIni.WriteString('CaixaLocal', 'NFCons', Boolean_SN(wInicial.CxNFCons));
        wIni.WriteString('CaixaLocal', 'NFServ', Boolean_SN(wInicial.CxNFServ));
        wIni.WriteString('CaixaLocal', 'OperacoesDFe',
          Boolean_SN(wInicial.CxOperDFe));
        wIni.WriteString('CaixaLocal', 'FatMensal',
          Boolean_SN(wInicial.CxFatMens));
        wIni.WriteString('CaixaLocal', 'CancelaOper',
          Boolean_SN(wInicial.CxCancOper));
        wIni.WriteString('CaixaLocal', 'ExclueOper',
          Boolean_SN(wInicial.CxExclOper));
        wIni.WriteString('CaixaLocal', 'NovaOper',
          Boolean_SN(wInicial.CxNovaOper));
        wIni.WriteInteger('CaixaLocal', 'TipoOper', wInicial.CxTpOper);
        wIni.WriteString('CaixaLocal', 'AlteraOper',
          Boolean_SN(wInicial.CxAltOper));
        wIni.WriteString('CaixaLocal', 'OrdemServico',
          Boolean_SN(wInicial.CxOrdServ));
        wIni.WriteString('CaixaLocal', 'CondPagto', wInicial.CxCondPagto);
        wIni.WriteString('CaixaLocal', 'FazTroco',
          Boolean_SN(wInicial.CxFazTroco));
        wIni.WriteString('CaixaLocal', 'ExibeOrcam',
          Boolean_SN(wInicial.CxExibeOrcam));
        wIni.WriteInteger('CaixaLocal', 'TempoExib', wInicial.CxTempoMsg);
        wIni.WriteString('CaixaLocal', 'DocInterno',
          Boolean_SN(wInicial.CxDocInterno));
        wIni.WriteInteger('CaixaLocal', 'ViasDocInterno',
          FuIniGeral.wInicial.CxViasDocInt);
        wIni.WriteString('CaixaLocal', 'DocCobranca',
          Boolean_SN(wInicial.CxDocCobranca));
        wIni.WriteInteger('CaixaLocal', 'TipoCobranca',
          FuIniGeral.wInicial.CxTipoCobranca);
        wIni.WriteString('CaixaLocal', 'DocAutomatico',
          Boolean_SN(wInicial.CxDocAutom));
        wIni.WriteString('CaixaLocal', 'Recebimentos',
          Boolean_SN(wInicial.CxRecebimentos));
        wIni.WriteString('CaixaLocal', 'TimerAviso',
          Boolean_SN(wInicial.CxTimer));
        wIni.WriteInteger('CaixaLocal', 'TempoAviso', wInicial.CxTempoTimer);
        wIni.WriteString('CaixaLocal', 'ConfirmaDocX',
          Boolean_SN(wInicial.CxConfCtrlX));
        wIni.WriteString('CaixaLocal', 'DescAdicional',
          Boolean_SN(wInicial.CxDescAdic));
        wIni.WriteString('CaixaLocal', 'CCorrCliente',
          Boolean_SN(wInicial.CxCCorrCliente));
        wIni.WriteString('CaixaLocal', 'UltimoRegistro',
          Boolean_SN(wInicial.CxUltimoReg));
        wIni.WriteInteger('CaixaLocal', 'SituacaoInicial',
          wInicial.CxSitOperIni);
        wIni.WriteString('CaixaLocal', 'CancelaCartao',
          Boolean_SN(wInicial.CxCancelCartao));
        wIni.WriteInteger('CaixaLocal', 'Lancamentos', wInicial.CxLcts);
        wIni.WriteString('CaixaLocal', 'LstFecham',
          Boolean_SN(wInicial.CxFech));
        wIni.WriteString('CaixaLocal', 'LstAtend', Boolean_SN(wInicial.CxAten));
        wIni.WriteString('CaixaLocal', 'TimerDataHora',
          Boolean_SN(wInicial.CxTimerDtHr));
      end;

      if (wModulos = 'TODOS') or (Pos('EGEREN', wModulos) > 0) then
      begin
        wIni.WriteString('Gerenciador', 'NotasFiscais',
          wInicial.GerNotasFiscais);
        wIni.WriteString('Gerenciador', 'NotasBenef', wInicial.GerNotasBenef);
        wIni.WriteString('Gerenciador', 'AlternaDados',
          Boolean_SN(wInicial.GerAlternaDados));
        wIni.WriteString('Gerenciador', 'ReplicaDados',
          Boolean_SN(wInicial.GerReplicaDados));
        wIni.WriteInteger('Gerenciador', 'Ordem', wInicial.GerOrdemInicial);
        wIni.WriteString('Gerenciador', 'EnvioXMLDanfe',
          wInicial.GerEnvioXMLDanfe);
        wIni.WriteString('Gerenciador', 'EstCadas',
          Boolean_SN(wInicial.GerEstCadastro));
        wIni.WriteString('Gerenciador', 'EstMovto',
          Boolean_SN(wInicial.GerEstMovimentacao));
        wIni.WriteString('Gerenciador', 'EstRegis',
          Boolean_SN(wInicial.GerEstRegistro));
        wIni.WriteString('Gerenciador', 'Servicos',
          Boolean_SN(wInicial.GerServicos));
        wIni.WriteString('Gerenciador', 'AtualizaData',
          Boolean_SN(wInicial.GerAtualizaData));
        wIni.WriteInteger('Gerenciador', 'ViasNFCe', wInicial.GerViasNFCe);
        wIni.WriteString('Gerenciador', 'AtualizaEstoques',
          Boolean_SN(wInicial.GerAtlzEstoques));
        wIni.WriteString('Gerenciador', 'BoletoPrtLocal',
          Boolean_SN(wInicial.GerBolPrinterLocal));
        wIni.WriteString('Gerenciador', 'BoletoIdprtLocal',
          wInicial.GerBolIdPrinterLocal);
        wIni.WriteString('Gerenciador', 'BoletoPreview',
          Boolean_SN(wInicial.GerBolPreview));
        wIni.WriteString('Gerenciador', 'UsaDLL',
          Boolean_SN(wInicial.GerUsaDLL));
        wIni.WriteInteger('Gerenciador', 'UsoTEFPOS', wInicial.GerTEFPOS);
        wIni.WriteString('Gerenciador', 'IdTerminal', wInicial.GerIdTerminal);
        wIni.WriteFloat('Gerenciador', 'ValParcMin', wInicial.GerValParcMin);

        wIni.WriteString('Balcao', 'PgmOS1', wInicial.BalcaoPgmOS1);
        wIni.WriteString('Balcao', 'PgmOS2', wInicial.BalcaoPgmOS2);
        wIni.WriteString('Balcao', 'PgmOS3', wInicial.BalcaoPgmOS3);
        wIni.WriteString('Balcao', 'CondPagto',
          Boolean_SN(wInicial.BalcaoCondPagto));
        wIni.WriteString('Balcao', 'FreteVlrAdic',
          Boolean_SN(wInicial.BalcaoFreteVlrAdic));
        wIni.WriteString('Balcao', 'EmiteDFeDInt',
          Boolean_SN(wInicial.BalcaoEmiteDFeDInt));
        wIni.WriteString('Balcao', 'AtualizaCaixa',
          Boolean_SN(wInicial.BalcaoAtualizaCaixa));
        wIni.WriteString('Balcao', 'SeparadorDecimal',
          wInicial.SeparadorDecimal);
        wIni.WriteString('Balcao', 'AvancoEnter',
          Boolean_SN(wInicial.AvancoEnter));
        wIni.WriteString('Balcao', 'SaltaTrib', Boolean_SN(wInicial.SaltaTrib));
        wIni.WriteString('Balcao', 'SaltaPed', Boolean_SN(wInicial.SaltaPed));
        wIni.WriteInteger('Balcao', 'EmpFilVendas', wInicial.EmpFilVendas);
        wIni.WriteString('Balcao', 'AlteraEmpFil',
          Boolean_SN(wInicial.AlteraEmpFil));
        wIni.WriteInteger('Balcao', 'AteVenVendas', wInicial.AteVenVendas);
        wIni.WriteInteger('Balcao', 'InicioOperacao', wInicial.InicioOperacao);
        wIni.WriteInteger('Balcao', 'LctosOperacao', wInicial.LctosOperacao);
        wIni.WriteInteger('Balcao', 'TpDescBalcao', wInicial.TpDescBalcao);

        wIni.WriteInteger('OrdemServico', 'EmpFil1', wInicial.EmpFilOS1);
        wIni.WriteInteger('OrdemServico', 'AteVen1', wInicial.AteVenOS1);
        wIni.WriteInteger('OrdemServico', 'EmpFil2', wInicial.EmpFilOS2);
        wIni.WriteInteger('OrdemServico', 'AteVen2', wInicial.AteVenOS2);

        wIni.WriteString('FastFood', 'Balcao',
          Boolean_SN(wInicial.FFLocal_Balcao));
        wIni.WriteString('FastFood', 'Tele', Boolean_SN(wInicial.FFLocal_Tele));
        wIni.WriteString('FastFood', 'Mesas',
          Boolean_SN(wInicial.FFLocal_Mesas));
        wIni.WriteString('FastFood', 'NFCe', Boolean_SN(wInicial.FFLocal_NFCe));
        wIni.WriteString('FastFood', 'NFe', Boolean_SN(wInicial.FFLocal_NFe));
        wIni.WriteString('FastFood', 'GerDFe',
          Boolean_SN(wInicial.FFLocal_GerDFe));
        wIni.WriteString('FastFood', 'Impressora', wInicial.FFLocal_Printer);
        wIni.WriteInteger('FastFood', 'Vias', wInicial.FFLocal_VPrinc);
        wIni.WriteString('FastFood', 'ImpressoraSecundaria',
          wInicial.FFLocal_PrinterSec);
        wIni.WriteInteger('FastFood', 'ViasSec', wInicial.FFLocal_VSec);
        wIni.WriteInteger('FastFood', 'TipoSecundario', wInicial.FFLocal_SecTp);

        wIni.WriteString('BalcaoSimples', 'Utiliza',
          Boolean_SN(wInicial.BSUtiliza));
        wIni.WriteString('BalcaoSimples', 'EmpFil',
          Boolean_SN(wInicial.BSEmpFil));
        wIni.WriteString('BalcaoSimples', 'Vendedor',
          Boolean_SN(wInicial.BSVendedor));
        wIni.WriteString('BalcaoSimples', 'LPreco',
          Boolean_SN(wInicial.BSLPreco));
        wIni.WriteString('BalcaoSimples', 'Cliente',
          Boolean_SN(wInicial.BSCliente));
        wIni.WriteInteger('BalcaoSimples', 'Inicio', wInicial.BSInicio);
        wIni.WriteString('BalcaoSimples', 'CodProd',
          Boolean_SN(wInicial.BSSeqCodProd));
        wIni.WriteString('BalcaoSimples', 'Descricao',
          Boolean_SN(wInicial.BSSeqDescricao));
        wIni.WriteString('BalcaoSimples', 'Unidade',
          Boolean_SN(wInicial.BSSeqUnid));
        wIni.WriteString('BalcaoSimples', 'Quantidade',
          Boolean_SN(wInicial.BSSeqQuant));
        wIni.WriteString('BalcaoSimples', 'VlUnitario',
          Boolean_SN(wInicial.BSSeqVlUnit));
        wIni.WriteString('BalcaoSimples', 'Completa',
          Boolean_SN(wInicial.BSSeqCompl));
        wIni.WriteString('BalcaoSimples', 'BtOK',
          Boolean_SN(wInicial.BSSeqBtOK));
        wIni.WriteString('BalcaoSimples', 'AvancoEnter',
          Boolean_SN(wInicial.BSAvEnter));
        wIni.WriteString('BalcaoSimples', 'OpcCompleta',
          Boolean_SN(wInicial.BSOpDescrCompl));
        wIni.WriteString('BalcaoSimples', 'Orcamentos',
          Boolean_SN(wInicial.BSOrcamentos));
        wIni.WriteInteger('BalcaoSimples', 'TimeWait', wInicial.BSTimeWait);
        wIni.WriteString('BalcaoSimples', 'ClienteKiosk',
          Boolean_SN(wInicial.BKSCliente));
        wIni.WriteString('BalcaoSimples', 'NomeClieKiosk',
          Boolean_SN(wInicial.BKSNomeClie));
        wIni.WriteString('BalcaoSimples', 'CondPgKiosk',
          Boolean_SN(wInicial.BKSCondPg));
        wIni.WriteString('BalcaoSimples', 'DescKiosk',
          Boolean_SN(wInicial.BKSDesconto));
        wIni.WriteString('BalcaoSimples', 'TrocoKiosk',
          Boolean_SN(wInicial.BKSTroco));
        wIni.WriteString('BalcaoSimples', 'NFCeKiosk',
          Boolean_SN(wInicial.BKSNFCe));
        wIni.WriteInteger('BalcaoSimples', 'KioskLcts', wInicial.BKSLcts);
        wIni.WriteInteger('BalcaoSimples', 'KioskFinal', wInicial.BKSFinaliz);

        wIni.WriteString('BalcaoMag', 'Operacoes',
          Boolean_SN(wInicial.BMagOper));
        wIni.WriteString('BalcaoMag', 'Produtos',
          Boolean_SN(wInicial.BMagProd));
        wIni.WriteString('BalcaoMag', 'Dimensionar',
          Boolean_SN(wInicial.BMagDime));
        wIni.WriteString('BalcaoMag', 'Parametros',
          Boolean_SN(wInicial.BMagParm));
        wIni.WriteString('BalcaoMag', 'AlteraPreco',
          Boolean_SN(wInicial.BMagPreco));

      end;

      wIni.Free;
      FormataArquivoIni(wIniName);

    end;
    //
    if pGeral then
    begin
      wIniName := FuIniGeral.wInicial.Parametros;
      if Pos('IniSys', FuIniGeral.appName) > 0 then
        DeleteFile(wIniName);
      wIni := TIniFile.Create(wIniName);
      // SysUser, SysUserStat, SysComputerName:  Dados internos, não salvar

      wIni.WriteString('Identificacao', 'Sistema', wInicial.Sistema);
      wIni.WriteString('Identificacao', 'Empresa', wInicial.Empresa);
      wIni.WriteString('Dados', 'DatabaseName', wInicial.DatabaseName);
      wIni.WriteString('Dados', 'DatabasePath', wInicial.DatabasePath);
      wIni.WriteString('Dados', 'LiteFull', wInicial.LiteFull);
      wIni.WriteInteger('Dados', 'LiteMax', wInicial.LiteMax);
      wIni.WriteString('Dados', 'PathAuxiliar', wInicial.PathAuxiliar);
      wIni.WriteString('Dados', 'SenhaExclus', wInicial.SenhaExclus);
      wIni.WriteString('Dados', 'Serial', wInicial.Serial);
      wIni.WriteString('Dados', 'PathExec', wInicial.PathExec);
      wIni.WriteString('Dados', 'PathEstruturas', wInicial.PathEstruturas);
      wIni.WriteString('Dados', 'PathArqMorto', wInicial.PathArqMorto);
      wIni.WriteString('EMail', 'Nome', wInicial.EMNome);
      wIni.WriteString('EMail', 'Email', wInicial.EMOrigem);
      wIni.WriteString('EMail', 'Porta', wInicial.EMPorta);
      wIni.WriteString('EMail', 'Host', wInicial.EMHost);
      wIni.WriteString('EMail', 'Usuario', wInicial.EMUsario);
      wIni.WriteString('EMail', 'Senha', wInicial.EMSenha);
      wIni.WriteString('EMail', 'Envio', wInicial.EMEnvio);
      wIni.WriteString('Internet', 'ProxyHost', wInicial.ProxyHost);
      wIni.WriteString('Internet', 'ProxyPass', wInicial.ProxyPass);
      wIni.WriteString('Internet', 'ProxyPort', wInicial.ProxyPort);
      wIni.WriteString('Internet', 'ProxyUser', wInicial.ProxyUser);
      wIni.WriteString('Internet', 'URLConsultaNCM', wInicial.UrlNCM);

      wIni.WriteString('Links', 'PathWAEnvio', wInicial.PathWAEnvio);
      wIni.WriteString('Links', 'UtilizaLinks',
        Boolean_SN(wInicial.LinksUtiliza));
      wIni.WriteString('Links', 'SPC', wInicial.LinkSPC);
      wIni.WriteString('Links', 'SINTEGRA', wInicial.LinkSINTEGRA);
      wIni.WriteString('Links', 'SeFazRS', wInicial.LinkSeFazRS);
      wIni.WriteString('Links', 'DadosSeFaz', Boolean_SN(wInicial.DadosSeFaz));

      wIni.WriteInteger('Padroes', 'Refresh', wInicial.RefreshTimer);
      wIni.WriteString('Padroes', 'Magazine', Boolean_SN(wInicial.Magazine));
      wIni.WriteInteger('Padroes', 'EmpresaFilial', wInicial.CodEF);
      wIni.WriteString('Padroes', 'Cidade', wInicial.Cidade);
      wIni.WriteString('Padroes', 'Estado', wInicial.Estado);
      wIni.WriteString('Padroes', 'MunIBGE', wInicial.MunIBGE);
      wIni.WriteString('Padroes', 'UFIBGE', wInicial.UFIBGE);
      wIni.WriteInteger('Padroes', 'ValorDecimais', wInicial.ValorDec);
      wIni.WriteInteger('Padroes', 'QuantDecimais', wInicial.QuantDec);
      wIni.WriteString('Padroes', 'CadastroUnico',
        Boolean_SN(wInicial.CadastroUnico));
      wIni.WriteString('Padroes', 'AtualizaCadastro',
        Boolean_SN(wInicial.AtualizaCadastro));
      wIni.WriteString('Padroes', 'CadasLogFile', wInicial.CadasLogFile);
      wIni.WriteString('Padroes', 'TranspLogFile', wInicial.TranspLogFile);
      wIni.WriteString('Padroes', 'EmpregLogFile', wInicial.EmpregLogFile);
      wIni.WriteString('Padroes', 'PagRecLogFile', wInicial.PagRecLogFile);
      wIni.WriteString('Padroes', 'DFeLogFile', wInicial.DFeLogFile);
      wIni.WriteInteger('Padroes', 'PeriodoContaCorrente', wInicial.PeriodoCC);
      wIni.WriteString('Padroes', 'CadClass1', wInicial.CadClass1);
      wIni.WriteString('Padroes', 'CadClass2', wInicial.CadClass2);
      wIni.WriteString('Padroes', 'CadClass3', wInicial.CadClass3);
      wIni.WriteInteger('Padroes', 'CaixaDoc', wInicial.CaixaDoc);
      wIni.WriteFloat('Padroes', 'PcCredAVista', wInicial.PcCredAV);
      wIni.WriteFloat('Padroes', 'PcCredParcel', wInicial.PcCredParc);
      wIni.WriteString('Padroes', 'MensCredParc',
        Boolean_SN(wInicial.MensCredParc));
      wIni.WriteFloat('Padroes', 'PcDebito', wInicial.PcDebito);
      wIni.WriteFloat('Padroes', 'PcCrediario', wInicial.PcCrediario);
      wIni.WriteString('Padroes', 'MensCrediario',
        Boolean_SN(wInicial.MensCrediario));
      wIni.WriteFloat('Padroes', 'PcParcelam', wInicial.PcParcelam);
      wIni.WriteString('Padroes', 'MensParcelam',
        Boolean_SN(wInicial.MensParcelam));
      wIni.WriteFloat('Padroes', 'PcCheques', wInicial.PcCheques);
      wIni.WriteString('Padroes', 'MensCheques',
        Boolean_SN(wInicial.MensCheques));
      wIni.WriteString('Padroes', 'PrazoMedio',
        Boolean_SN(wInicial.PrazoMedio));
      wIni.WriteString('Padroes', 'UsaTabCartoes',
        Boolean_SN(wInicial.UsaTabCartoes));
      wIni.WriteFloat('Padroes', 'VlrMinDesc', wInicial.VlrMinDesc);
      wIni.WriteFloat('Padroes', 'PcMaxDesc', wInicial.PcMaxDesc);
      wIni.WriteInteger('Padroes', 'BolMax', wInicial.BolMax);
      wIni.WriteInteger('Padroes', 'CredMax', wInicial.CredMax);
      wIni.WriteInteger('Padroes', 'CartMax', wInicial.CartMax);
      wIni.WriteInteger('Padroes', 'ChqMax', wInicial.ChqMax);
      wIni.WriteString('Padroes', 'LeituraAuto',
        Boolean_SN(wInicial.LeituraAuto));
      wIni.WriteInteger('Padroes', 'PesquisaAlfabetica',
        wInicial.PadraoPesqAlfa);
      wIni.WriteString('Padroes', 'DescBoletos',
        Boolean_SN(wInicial.DescBoletos));
      wIni.WriteString('Padroes', 'RemBolAutom',
        Boolean_SN(wInicial.RemBolAutom));
      wIni.WriteString('Padroes', 'GerBolEmpFil',
        Boolean_SN(wInicial.GerBolEmpFil));
      wIni.WriteString('Padroes', 'Recibos', Boolean_SN(wInicial.Recibos));
      wIni.WriteString('Padroes', 'RecSimples',
        Boolean_SN(wInicial.RecSimples));
      wIni.WriteString('Padroes', 'AMSemestral',
        Boolean_SN(wInicial.AMSemestral));
      wIni.WriteString('Padroes', 'IntegVendOS',
        Boolean_SN(wInicial.IntegVendOS));
      wIni.WriteString('Padroes', 'TotalNFe', Boolean_SN(wInicial.TotalNFe));
      wIni.WriteString('Padroes', 'DtLimiteSeFaz',
        DateToStr(wInicial.DtLimiteSeFaz));
      wIni.WriteString('Padroes', 'TipoVenda', Boolean_SN(wInicial.TipoVenda));
      wIni.WriteString('Padroes', 'AdotaDataAtual',
        Boolean_SN(wInicial.AdotaDtAtual));
      wIni.WriteInteger('Padroes', 'PedidoPadrao', wInicial.PedidoPadrao);
      wIni.WriteString('Padroes', 'ConfirmaVias',
        Boolean_SN(wInicial.ConfirmaVias));
      wIni.WriteString('Padroes', 'ExibeQtdDisponivel',
        Boolean_SN(wInicial.ExibeQtdDisp));
      wIni.WriteInteger('Padroes', 'ValidarIE', wInicial.ValidarIE);
      wIni.WriteString('Padroes', 'IdAtacadista', wInicial.IdAtacadista);
      wIni.WriteString('Padroes', 'IdDistribuidor', wInicial.IdDistribuidor);
      wIni.WriteString('Padroes', 'EMailHomolog', wInicial.EMailHomolog);

      if (wModulos = 'TODOS') or (Pos('FINANC', wModulos) > 0) then
      begin
        wIni.WriteString('Financeiro', 'DetRubricas',
          Boolean_SN(wInicial.DetRubricas));
        case wInicial.TpJuros of
          1:
            wAux := 'D';
          2:
            wAux := 'M';
        else
          wAux := '';
        end;
        wIni.WriteString('Financeiro', 'Juros', wAux);
        wIni.WriteFloat('Financeiro', 'PercJuros', wInicial.PcJuros);
        wIni.WriteFloat('Financeiro', 'PercDesc', wInicial.PcDesc);
        wIni.WriteFloat('Financeiro', 'PercMulta', wInicial.PcMulta);
        case wInicial.Cobranca of
          0:
            wAux := 'C';
          1:
            wAux := 'B';
          2:
            wAux := 'J';
        else
          wAux := 'C';
        end;
        wIni.WriteString('Financeiro', 'Cobranca', wAux);
        wIni.WriteInteger('Financeiro', 'DocPagar', wInicial.DocPagar);
        wIni.WriteInteger('Financeiro', 'DocReceber', wInicial.DocReceb);
        wIni.WriteInteger('Financeiro', 'DocCrediario', wInicial.DocCrediar);
        wIni.WriteInteger('Financeiro', 'DocCheque', wInicial.DocCheque);
        wIni.WriteString('Financeiro', 'DuplicataCNPJ',
          Boolean_SN(wInicial.DuplCNPJ));
        wIni.WriteString('Financeiro', 'DuplicataIEst',
          Boolean_SN(wInicial.DuplIEST));
        wIni.WriteInteger('Financeiro', 'DiasFuturos', wInicial.DiasFuturos);
        wIni.WriteString('Financeiro', 'NroDocObrigatorio',
          Boolean_SN(wInicial.NroDocObrigatorio));
        wIni.WriteString('Financeiro', 'DiferDocumentos',
          Boolean_SN(wInicial.DiferDocumentos));
        wIni.WriteString('Financeiro', 'PathRemessas', wInicial.PathRemessas);
        wIni.WriteInteger('Financeiro', 'DetPathRemessas',
          wInicial.DetPathRemessas);
        wIni.WriteString('Financeiro', 'Retornos',
          Boolean_SN(wInicial.ProcRetornos));
        wIni.WriteString('Financeiro', 'UsaPlanoContas',
          Boolean_SN(wInicial.UsaPlanoContas));
        wIni.WriteString('Financeiro', 'PathRetornos', wInicial.PathRetornos);
        wIni.WriteString('Financeiro', 'PathSalvaRetornos',
          wInicial.PathSalvaRetornos);
        wIni.WriteInteger('Financeiro', 'Processo', wInicial.RetProcesso);
        wIni.WriteString('Financeiro', 'VisualizaProcesso',
          Boolean_SN(wInicial.VisProcesso));
        wIni.WriteString('Financeiro', 'PathRetorno01', wInicial.PathAlter01);
        wIni.WriteString('Financeiro', 'PathRetorno02', wInicial.PathAlter02);
        wIni.WriteString('Financeiro', 'PathRetorno03', wInicial.PathAlter03);
        wIni.WriteString('Financeiro', 'PathRetorno04', wInicial.PathAlter04);
        wIni.WriteString('Financeiro', 'PathRetorno05', wInicial.PathAlter05);
        wIni.WriteInteger('Financeiro', 'TipoCarneCrediario',
          wInicial.TpCarneCrediar);
        wIni.WriteInteger('Financeiro', 'TamDetBobina', wInicial.TamDetBobina);

        wIni.WriteInteger('Financeiro', 'EFPadrao', wInicial.EmpFilCrediar);
        wIni.WriteString('Financeiro', 'ImprimeConfDiv',
          Boolean_SN(wInicial.ImprimeConfDiv));
        wIni.WriteString('Financeiro', 'ImprimeEntrada',
          Boolean_SN(wInicial.ImprimeEntrada));

        wIni.WriteString('Financeiro', 'TxtConfDivida', wInicial.TxtConfDivida);
        wIni.WriteString('Financeiro', 'TxtConfDividaBob',
          wInicial.TxtConfDividaBob);
        wIni.WriteString('Financeiro', 'TxtCarnet1', wInicial.TxtCarnet1);
        wIni.WriteString('Financeiro', 'TxtCarnet2', wInicial.TxtCarnet2);
        wIni.WriteInteger('Financeiro', 'DiasIsencao', wInicial.DiasIsencao);
        wIni.WriteString('Financeiro', 'LiberaCred',
          Boolean_SN(wInicial.LiberaCred));
        wIni.WriteString('Financeiro', 'UtilizaCC',
          Boolean_SN(wInicial.UtilizaCC));
        wIni.WriteString('Financeiro', 'CreditoCC', wInicial.CreditoCC);
        wIni.WriteString('Financeiro', 'DebitoCC', wInicial.DebitoCC);
        wIni.WriteString('Financeiro', 'InfSaldoCC',
          Boolean_SN(wInicial.InfSaldoCC));
        wIni.WriteString('Financeiro', 'TxtPgto1', wInicial.TxtPgto1);
        wIni.WriteString('Financeiro', 'TxtPgto2', wInicial.TxtPgto2);
        wIni.WriteString('Financeiro', 'TxtPgto3', wInicial.TxtPgto3);

        wIni.WriteString('Boletos', 'PathPDF', wInicial.Bol_PathPDF);
        wIni.WriteInteger('Boletos', 'Denominacao', wInicial.Bol_Denom);
        wIni.WriteString('Boletos', 'OutraDenominacao',
          wInicial.Bol_OutraDenom);
        wIni.WriteString('Boletos', 'Impressora', wInicial.Bol_Impressora);
        wIni.WriteInteger('Boletos', 'Copias', wInicial.Bol_Copias);
        wIni.WriteString('Boletos', 'DialogoImpressao',
          Boolean_SN(wInicial.Bol_DialogPrint));
        wIni.WriteString('Boletos', 'ExcluePDF',
          Boolean_SN(wInicial.Bol_ExcluePDF));

      end;
      if (wModulos = 'TODOS') or (Pos('ESTOQ', wModulos) > 0) then
      begin
        wIni.WriteString('Estoques', 'LogFile', wInicial.EstoqLogFile);
        wIni.WriteString('Estoques', 'Cadastro', wInicial.ECadas);
        wIni.WriteString('Estoques', 'Apresentacao', wInicial.EApres);
        wIni.WriteString('Estoques', 'ObrigReferencia',
          Boolean_SN(wInicial.EObRefer));
        wIni.WriteString('Estoques', 'ObrigGrupo',
          Boolean_SN(wInicial.EObGrupo));
        wIni.WriteString('Estoques', 'DupDescricao',
          Boolean_SN(wInicial.EDupDescr));
        wIni.WriteString('Estoques', 'ListaPreco',
          Boolean_SN(wInicial.ELPreco));
        wIni.WriteString('Estoques', 'DupReferencia',
          Boolean_SN(wInicial.EDupRefer));
        wIni.WriteString('Estoques', 'UsaReferencia2',
          Boolean_SN(wInicial.EUsaRefer2));
        wIni.WriteString('Estoques', 'ExibeUltCusto',
          Boolean_SN(wInicial.EExibUltCusto));
        wIni.WriteString('Estoques', 'Descricao', wInicial.EDescrCase);
        wIni.WriteInteger('Estoques', 'DiasValidade', wInicial.EDiasValidade);
        wIni.WriteInteger('Estoques', 'TamanhoCodigo', wInicial.EstCodTam);
        wIni.WriteInteger('Estoques', 'Divisoes', wInicial.EstCodDiv);
        wIni.WriteInteger('Estoques', 'Div1Tamanho', wInicial.EstDiv1Tam);
        wIni.WriteString('Estoques', 'Div1Tipo', wInicial.EstDiv1Tip);
        wIni.WriteInteger('Estoques', 'Div2Tamanho', wInicial.EstDiv2Tam);
        wIni.WriteString('Estoques', 'Div2Tipo', wInicial.EstDiv2Tip);
        wIni.WriteInteger('Estoques', 'Div3Tamanho', wInicial.EstDiv3Tam);
        wIni.WriteString('Estoques', 'Div3Tipo', wInicial.EstDiv3Tip);
        wIni.WriteInteger('Estoques', 'Div4Tamanho', wInicial.EstDiv4Tam);
        wIni.WriteString('Estoques', 'Div4Tipo', wInicial.EstDiv4Tip);
        wIni.WriteString('Estoques', 'Etiquetas',
          Boolean_SN(wInicial.EstEtiquetas));
        wIni.WriteFloat('Estoques', 'AlturaEtiq24', wInicial.EstEtiqAlt24);
        wIni.WriteInteger('Estoques', 'ExpCodBar', wInicial.EstExpCodBar);
        wIni.WriteString('Estoques', 'Magazine',
          Boolean_SN(wInicial.EstMagazine));
        wIni.WriteString('Estoques', 'AssTecnica',
          Boolean_SN(wInicial.EstAssTecnica));
        wIni.WriteString('Estoques', 'SelPromo',
          Boolean_SN(wInicial.EstSelPromo));
        wIni.WriteInteger('Estoques', 'MesesExclusao', wInicial.EstMesExclus);

        wIni.WriteString('Estoques', 'PathWrk', wInicial.EstPathWrk);
        wIni.WriteString('Estoques', 'BarrasPrinter',
          wInicial.EstBarrasPrinter);
        wIni.WriteString('Estoques', 'BarrasA4', wInicial.EstBarrasA4);
        wIni.WriteString('Estoques', 'ProducaoCustos',
          Boolean_SN(wInicial.EstProdCusto));
        wIni.WriteInteger('Estoques', 'MarcaEF', wInicial.EstMarcaEF);
        wIni.WriteString('Estoques', 'AlteraPrecos',
          Boolean_SN(wInicial.EstAltPrecos));
        wIni.WriteString('Estoques', 'SubGrupos',
          Boolean_SN(wInicial.EstSubGrupo));
        wIni.WriteString('Estoques', 'ValidaEAN',
          Boolean_SN(wInicial.EstValidEAN));
        wIni.WriteString('Estoques', 'BKupMes',
          Boolean_SN(wInicial.EstBkupMes));
        wIni.WriteString('Estoques', 'BKupPath', wInicial.EstBkupPath);

        wIni.WriteString('Servicos', 'CodigoEstoque',
          Boolean_SN(wInicial.SrvCodEspec));
        wIni.WriteInteger('Servicos', 'CodigoTamanho', wInicial.SrvCodTam);
        wIni.WriteString('Servicos', 'CodigoNumAlfa', wInicial.SrvCodNA);

        wIni.WriteInteger('Estoques_Entradas', 'EmpresaFilial',
          wInicial.Entr_EF);
        wIni.WriteString('Estoques_Entradas', 'ExibeCalculo',
          Boolean_SN(wInicial.Entr_ExibeCalc));
        wIni.WriteString('Estoques_Entradas', 'CP_Atualiza',
          Boolean_SN(wInicial.Entr_AtlzCP));
        wIni.WriteInteger('Estoques_Entradas', 'CP_Documento',
          wInicial.Entr_CPDoc);
        wIni.WriteInteger('Estoques_Entradas', 'CP_Rubrica',
          wInicial.Entr_CPRubr);
        wIni.WriteInteger('Estoques_Entradas', 'DocEntrada',
          wInicial.Entr_DocEntr);
        wIni.WriteString('Estoques_Entradas', 'Detalhamento',
          Boolean_SN(wInicial.Entr_Detal));
        wIni.WriteString('Estoques_Entradas', 'CriticaBases',
          Boolean_SN(wInicial.Entr_CritBases));
        wIni.WriteString('Estoques_Entradas', 'CalcBaseIsenta',
          Boolean_SN(wInicial.Entr_CalcBsIsenta));
        wIni.WriteString('Estoques_Entradas', 'AdotarPreco',
          Boolean_SN(wInicial.Entr_AdotaPreco));
        wIni.WriteString('Estoques_Entradas', 'AdotarCFOP',
          Boolean_SN(wInicial.Entr_AdotaCFOP));
        wIni.WriteString('Estoques_Entradas', 'PathLeXML',
          wInicial.Entr_PathLeXML);
        wIni.WriteString('Estoques_Entradas', 'DiferEmpresas',
          Boolean_SN(wInicial.Entr_DifEF));
        wIni.WriteString('Estoques_Entradas', 'ExibeProcesso',
          Boolean_SN(wInicial.Entr_ExProcesso));
        wIni.WriteString('Estoques_Entradas', 'PesqReferencia',
          Boolean_SN(wInicial.Entr_PesqRefer));

        wIni.WriteString('Estoques_Compras', 'Identificacao',
          wInicial.Compra_Id);
        wIni.WriteString('Estoques_Compras', 'Abreviatura',
          wInicial.Compra_Abrev);
        wIni.WriteString('Estoques_Compras', 'IdMenu', wInicial.Compra_Menu);
        wIni.WriteInteger('Estoques_Compras', 'DecQuantidade',
          wInicial.Compra_QtdDec);
        wIni.WriteInteger('Estoques_Compras', 'DecUnitario',
          wInicial.Compra_UnitDec);

        wIni.WriteInteger('Estoques_Tributacao', 'ICM_ModoBC',
          wInicial.esModoBC);
        wIni.WriteFloat('Estoques_Tributacao', 'ICM_RedBC', wInicial.esModoBC);
        wIni.WriteInteger('Estoques_Tributacao', 'ICM_ModoBCST',
          wInicial.esModoBCST);
        wIni.WriteFloat('Estoques_Tributacao', 'ICM_MVA', wInicial.esMVA);
        wIni.WriteFloat('Estoques_Tributacao', 'ICM_RedBCST',
          wInicial.esRedBCST);
        wIni.WriteString('Estoques_Tributacao', 'IPI_Sujeito',
          Boolean_SN(wInicial.esIPI));
        wIni.WriteString('Estoques_Tributacao', 'IPI_Classe',
          wInicial.esIPIClasse);
        wIni.WriteString('Estoques_Tributacao', 'IPI_Enquadramento',
          wInicial.esIPIEnq);
        wIni.WriteString('Estoques_Tributacao', 'IPI_Tributavel',
          Boolean_SN(wInicial.esIPITrib));
        wIni.WriteInteger('Estoques_Tributacao', 'IPI_STEntrada',
          wInicial.esIPIEnt);
        wIni.WriteInteger('Estoques_Tributacao', 'IPI_STSaida',
          wInicial.esIPISai);
        wIni.WriteString('Estoques_Tributacao', 'IPI_Modo', wInicial.esIPIModo);
        wIni.WriteString('Estoques_Tributacao', 'NCM', wInicial.esNCM);
        wIni.WriteString('Estoques_Tributacao', 'Genero', wInicial.esGenero);
        wIni.WriteString('Estoques_Tributacao', 'ExTIPI', wInicial.esExTIPI);
        wIni.WriteString('Estoques_Tributacao', 'CEST', wInicial.esCEST);
        wIni.WriteString('Estoques_Tributacao', 'NVE', wInicial.esNVE);
        wIni.WriteString('Estoques_Tributacao', 'PIS_Trb',
          Boolean_SN(wInicial.esPIS));
        wIni.WriteInteger('Estoques_Tributacao', 'PIS_ST', wInicial.esPISST);
        wIni.WriteFloat('Estoques_Tributacao', 'PIS_Aliq', wInicial.esPISAliq);
        wIni.WriteFloat('Estoques_Tributacao', 'PIS_Unit',
          wInicial.esPISVlUnit);
        wIni.WriteString('Estoques_Tributacao', 'Cofins_Trb',
          Boolean_SN(wInicial.esCofins));
        wIni.WriteInteger('Estoques_Tributacao', 'Cofins_ST',
          wInicial.esCofinsST);
        wIni.WriteFloat('Estoques_Tributacao', 'Cofins_Aliq',
          wInicial.esCofinsAliq);
        wIni.WriteFloat('Estoques_Tributacao', 'Cofins_Unit',
          wInicial.esCofinsVlUnit);
      end;

      if (wModulos = 'TODOS') or (Pos('VENDAS', wModulos) > 0) then
      begin
        wIni.WriteInteger('Vendas_CFOP', 'Venda', wInicial.CFOP_Venda);
        wIni.WriteInteger('Vendas_CFOP', 'VendaST', wInicial.CFOP_VendaST);
        wIni.WriteInteger('Vendas_CFOP', 'Servico', wInicial.CFOP_Servico);
        wIni.WriteInteger('Vendas_CFOP', 'NCVenda', wInicial.CFOP_NCVenda);
        wIni.WriteInteger('Vendas_CFOP', 'NCVendaST', wInicial.CFOP_NCVendaST);
        wIni.WriteInteger('Vendas_CFOP', 'Venda_FE', wInicial.CFOP_Venda_FE);
        wIni.WriteInteger('Vendas_CFOP', 'VendaST_FE',
          wInicial.CFOP_VendaST_FE);
        wIni.WriteInteger('Vendas_CFOP', 'Servico_FE',
          wInicial.CFOP_Servico_FE);
        wIni.WriteInteger('Vendas_CFOP', 'NCVenda_FE',
          wInicial.CFOP_NCVenda_FE);
        wIni.WriteInteger('Vendas_CFOP', 'NCVendasST_FE',
          wInicial.CFOP_NCVendaST_FE);
        wIni.WriteString('Vendas_CFOP', 'UsoProdOper', wInicial.CFOP_Uso);
        wIni.WriteString('Vendas_CFOP', 'PrioridadeST',
          Boolean_SN(wInicial.PrioridadeST));
        //
        wIni.WriteFloat('CustosPrecos', 'Margem', wInicial.cpMargem);
        wIni.WriteFloat('CustosPrecos', 'CustosFixos', wInicial.cpCFixos);
        wIni.WriteFloat('CustosPrecos', 'Simples', wInicial.cpAliqSN);
        wIni.WriteFloat('CustosPrecos', 'LucroPresumido', wInicial.cpAliqLP);
        wIni.WriteFloat('CustosPrecos', 'TaxaFinanceira', wInicial.cpTaxFin);
        wIni.WriteString('CustosPrecos', 'MVACusto',
          Boolean_SN(wInicial.cpMVACusto));
        // Operações de comercialização
        wIni.WriteString('Operacoes', 'NomeCliente',
          Boolean_SN(wInicial.OpES_NomeCliente));
        wIni.WriteString('Operacoes', 'Vendedor',
          Boolean_SN(wInicial.OpES_Vendedor));
        wIni.WriteString('Operacoes', 'DuplicMaterial',
          Boolean_SN(wInicial.OpES_DuplMat));
        wIni.WriteString('Operacoes', 'DuplicServico',
          Boolean_SN(wInicial.OpES_DuplSrv));
        wIni.WriteString('Operacoes', 'LctoPrioritario',
          wInicial.OpES_LctPrior);
        wIni.WriteString('Operacoes', 'DescricaoCompleta',
          Boolean_SN(wInicial.OpES_DescrCompl));
        wIni.WriteString('Operacoes', 'DescontoItem',
          Boolean_SN(wInicial.OpES_DescItem));
        wIni.WriteInteger('Operacoes', 'GrupoBloq0', wInicial.OpES_GrupoBloq0);
        wIni.WriteInteger('Operacoes', 'GrupoBloq1', wInicial.OpES_GrupoBloq1);
        wIni.WriteInteger('Operacoes', 'GrupoBloq2', wInicial.OpES_GrupoBloq2);
        wIni.WriteInteger('Operacoes', 'GrupoBloq3', wInicial.OpES_GrupoBloq3);
        wIni.WriteInteger('Operacoes', 'GrupoBloq4', wInicial.OpES_GrupoBloq4);
        wIni.WriteInteger('Operacoes', 'GrupoBloq5', wInicial.OpES_GrupoBloq5);
        wIni.WriteInteger('Operacoes', 'GrupoBloq6', wInicial.OpES_GrupoBloq6);
        wIni.WriteInteger('Operacoes', 'GrupoBloq7', wInicial.OpES_GrupoBloq7);
        wIni.WriteInteger('Operacoes', 'GrupoBloq8', wInicial.OpES_GrupoBloq8);
        wIni.WriteInteger('Operacoes', 'GrupoBloq9', wInicial.OpES_GrupoBloq9);
        //
        wIni.WriteString('Operacoes', 'EstoqueNegativo',
          Boolean_SN(wInicial.OpES_Negativo));
        wIni.WriteString('Operacoes', 'CalculaSTVenda',
          Boolean_SN(wInicial.OpES_CalcSTVend));
        wIni.WriteString('Operacoes', 'PgmOS', wInicial.OpES_PgmOS);
        //
        wIni.WriteString('Operacoes', 'PedidoCab1', wInicial.OpES_LCab1);
        wIni.WriteString('Operacoes', 'PedidoCab2', wInicial.OpES_LCab2);
        wIni.WriteString('Operacoes', 'PedidoCab3', wInicial.OpES_LCab3);
        wIni.WriteString('Operacoes', 'PedidoCab4', wInicial.OpES_LCab4);
        wIni.WriteString('Operacoes', 'PedidoProm', wInicial.OpES_LProm);
        wIni.WriteString('Operacoes', 'PedidoIdent', wInicial.OpES_PedId);
        wIni.WriteString('Operacoes', 'OrcamIdent', wInicial.OpES_OrcId);
        wIni.WriteString('Operacoes', 'PedidoPreview',
          Boolean_SN(wInicial.OpES_PedPreview));
        wIni.WriteString('Operacoes', 'PedidoDialog',
          Boolean_SN(wInicial.OpES_PedDialog));
        wIni.WriteString('Operacoes', 'PedidoEntreVias',
          Boolean_SN(wInicial.OpES_PedEntreVias));
        wIni.WriteString('Operacoes', 'PedidoTotTribut',
          Boolean_SN(wInicial.OpES_PedTotTribut));
        wIni.WriteString('Operacoes', 'PedidoLogo', wInicial.OpES_PedLogo);
        wIni.WriteInteger('Operacoes', 'PedidoAvLinhas',
          wInicial.OpES_PedAvLin);
        wIni.WriteInteger('Operacoes', 'PedidoAvPixels',
          wInicial.OpES_PedAvPix);
        wIni.WriteString('Operacoes', 'MC5464',
          Boolean_SN(wInicial.OpES_MC5464));
        wIni.WriteInteger('Operacoes', 'ModoBCICM',
          wInicial.OpES_ModoBCICMVenda);
        wIni.WriteInteger('Operacoes', 'TimeOut', wInicial.OpES_TimeOut);
        wIni.WriteString('Operacoes', 'DtHrSaida',
          Boolean_SN(wInicial.OpES_DtHrSaida));
        wIni.WriteString('Operacoes', 'CodCliente',
          Boolean_SN(wInicial.OpES_CodClieNFe));
        wIni.WriteDate('Operacoes', 'HrVeraoIni', wInicial.OpES_HrVeraoIni);
        wIni.WriteDate('Operacoes', 'HrVeraoFin', wInicial.OpES_HrVeraoFin);
        wIni.WriteString('Operacoes', 'Crediario',
          Boolean_SN(wInicial.OpES_Crediario));
        wIni.WriteInteger('Operacoes', 'VolDefault', wInicial.OpES_VolDefault);
        wIni.WriteString('Operacoes', 'VolEspecie', wInicial.OpES_VolEspecie);
        wIni.WriteString('Operacoes', 'VolMarca', wInicial.OpES_VolMarca);
        wIni.WriteString('Operacoes', 'SomaQuantidade',
          Boolean_SN(wInicial.OpES_SomaQtd));
        wIni.WriteInteger('Operacoes', 'Frete', wInicial.OpES_Frete);
        wIni.WriteFloat('Operacoes', 'FatorPesoBruto', wInicial.OpES_FatorPB);
        wIni.WriteString('Operacoes', 'AVFluxo',
          Boolean_SN(wInicial.OpES_AVFluxo));
        wIni.WriteString('Operacoes', 'ClienteBalcao',
          Boolean_SN(wInicial.OpES_ClieBalcao));
        wIni.WriteInteger('Operacoes', 'RubAVFluxo', wInicial.OpES_RubrAVFluxo);
        wIni.WriteString('Operacoes', 'SenhaCancel', wInicial.OpES_SenhaCancel);
        wIni.WriteString('Operacoes', 'SenhaDesc', wInicial.OpES_SenhaDesc);
        wIni.WriteString('Operacoes', 'VendaPreferencial',
          wInicial.OpES_VendaPrefer);
        wIni.WriteString('Operacoes', 'RestauraNFe',
          Boolean_SN(wInicial.OpES_RestauraNFe));
        wIni.WriteString('Operacoes', 'NFeEmiss', wInicial.OpES_NFeEmiss);
        wIni.WriteInteger('Operacoes', 'HideShow', wInicial.OPES_HideShow);
        wIni.WriteString('Operacoes', 'PathCfgIni', wInicial.OpES_PathCfgIni);
        wIni.WriteString('Operacoes', 'DirNFeNFCeDifer',
          Boolean_SN(wInicial.OpES_DirNFeNFCeDifer));
        wIni.WriteInteger('Operacoes', 'DiasLimpeza',
          wInicial.OpES_DiasLimpeza);
        wIni.WriteInteger('Operacoes', 'TpVendedor', wInicial.OpES_TpVendedor);
        wIni.WriteString('Operacoes', 'Atendimentos',
          Boolean_SN(wInicial.OpES_Atendimentos));
        wIni.WriteString('Operacoes', 'PgtoMistoTEF',
          Boolean_SN(wInicial.OpES_PgtoMistoTEF));
        wIni.WriteString('Operacoes', 'NFeLotes',
          Boolean_SN(wInicial.OpES_NFeLotes));
        wIni.WriteString('Operacoes', 'ExibeBoletos',
          Boolean_SN(wInicial.OpES_ExibeBoletos));
        wIni.WriteString('Operacoes', 'ComplementaDados',
          Boolean_SN(wInicial.OpES_NFComplDd));
        wIni.WriteString('Operacoes', 'CalcVlrQtd',
          Boolean_SN(wInicial.OpES_VlrQtd));
        wIni.WriteString('Operacoes', 'UnQtdTribut',
          Boolean_SN(wInicial.OpES_UnQtdTrib));
        wIni.WriteString('Operacoes', 'AssinalaLinhaItem',
          Boolean_SN(wInicial.OpES_PesqItemDestaq));
        wIni.WriteString('Operacoes', 'OS1Estoques',
          Boolean_SN(wInicial.OpES_EstOS1));
        wIni.WriteString('Operacoes', 'OS2Estoques',
          Boolean_SN(wInicial.OpES_EstOS2));
        wIni.WriteString('Operacoes', 'UFST', wInicial.OpES_UFST);
        wIni.WriteString('Operacoes', 'CadastraCPF',
          Boolean_SN(wInicial.OpES_CadasCPF));
        wIni.WriteInteger('Operacoes', 'DiasLiberacao', wInicial.OpES_DdLiber);
        wIni.WriteFloat('Operacoes', 'VlrMaxSemIdent', wInicial.OpES_VlrMax);
        wIni.WriteString('Operacoes', 'AtlzHistDFe',
          Boolean_SN(wInicial.OpES_HistDFe));
        wIni.WriteString('Operacoes', 'DistribuidorObrigatorio',
          Boolean_SN(wInicial.OpES_DistribObrigatorio));
        wIni.WriteString('Operacoes', 'MsgDifal',
          Boolean_SN(wInicial.OpES_MsgDifal));
        wIni.WriteString('Operacoes', 'UFDifAl', wInicial.OpES_UFDifAl);

      end;
      // AltTTMercad, AltTTServic, RegEspICMS, CodRegTrib, AliqICMS, AliqPIS, AliqCofins, AliqISS, ListaPreco: Dados internos
      // DtCalcSaldoFluxo: Dado interno

      //
      // OS - Loja Benhur Peças
      if (wModulos = 'TODOS') or (Pos('OSLOJA', wModulos) > 0) then
      begin
        wIni.WriteString('OSLoja', 'Utiliza', Boolean_SN(wInicial.OSUtiliza));
        wIni.WriteString('OSLoja', 'LogFile', wInicial.OSLogFile);
        wIni.WriteString('OSLoja', 'CondPagto', wInicial.OSCondPagto);
        wIni.WriteInteger('OSLoja', 'Tecnicos', wInicial.Tecnicos);
        wIni.WriteInteger('OSLoja', 'Emissao', wInicial.Emissao);
        wIni.WriteString('OSLoja', 'Preview',
          Boolean_SN(wInicial.PreviewOSLoja));
        wIni.WriteInteger('OSLoja', 'LPP', wInicial.LPP);
        wIni.WriteString('OSLoja', 'LCab1', wInicial.LCab1);
        wIni.WriteString('OSLoja', 'LCab2', wInicial.LCab2);
        wIni.WriteString('OSLoja', 'LCab3', wInicial.LCab3);
        wIni.WriteString('OSLoja', 'LObs01', wInicial.LObs01);
        wIni.WriteString('OSLoja', 'LObs02', wInicial.LObs02);
        wIni.WriteString('OSLoja', 'LObs03', wInicial.LObs03);
        wIni.WriteString('OSLoja', 'LObs04', wInicial.LObs04);
        wIni.WriteString('OSLoja', 'LObs05', wInicial.LObs05);
        wIni.WriteString('OSLoja', 'LObs06', wInicial.LObs06);
        wIni.WriteString('OSLoja', 'LObs07', wInicial.LObs07);
        wIni.WriteString('OSLoja', 'LObs08', wInicial.LObs08);
        wIni.WriteString('OSLoja', 'LObs09', wInicial.LObs09);
        wIni.WriteString('OSLoja', 'LObs10', wInicial.LObs10);
        wIni.WriteString('OSLoja', 'PrinterOSLoja', wInicial.PrinterOSLoja);
        wIni.WriteString('OSLoja', 'MsgOSLoja1', wInicial.MsgOSLoja1);
        wIni.WriteString('OSLoja', 'MsgOSLoja2', wInicial.MsgOSLoja2);
      end;

      // Locação de equipamentos
      if (wModulos = 'TODOS') or (Pos('LOCEQUIP', wModulos) > 0) then
      begin
        wIni.WriteString('Locacoes_Equipamentos', 'IdGrupo',
          wInicial.Loc_IdGrupo);
        wIni.WriteString('Locacoes_Equipamentos', 'IdOperacoes',
          wInicial.Loc_IdOperacao);
        wIni.WriteString('Locacoes_Equipamentos', 'IdPreco1', wInicial.Loc_Pr1);
        wIni.WriteString('Locacoes_Equipamentos', 'IdPreco2', wInicial.Loc_Pr2);
        wIni.WriteString('Locacoes_Equipamentos', 'IdPreco3', wInicial.Loc_Pr3);
        wIni.WriteString('Locacoes_Equipamentos', 'IdPreco4', wInicial.Loc_Pr4);
        wIni.WriteString('Locacoes_Equipamentos', 'IdPreco5', wInicial.Loc_Pr5);
        wIni.WriteString('Locacoes_Equipamentos', 'PathContratos',
          wInicial.Loc_PathContratos);
        wIni.WriteFloat('Locacoes_Equipamentos', 'Margem', wInicial.Loc_Margem);
        wIni.WriteString('Locacoes_Equipamentos', 'HoraDevol',
          wInicial.Loc_HrDevol);
        wIni.WriteString('Locacoes_Equipamentos', 'Financeiro',
          Boolean_SN(wInicial.Loc_Financeiro));
      end;

      // AGB - Gabatech
      if (wModulos = 'TODOS') or (Pos('AGB', wModulos) > 0) then
      begin
        wIni.WriteString('AGB_Producao', 'DdProduc', wInicial.AGB_DdProd);
        wIni.WriteString('AGB_Producao', 'DdLocais', wInicial.AGB_DdLocais);
        wIni.WriteString('AGB_Producao', 'DdImportacao', wInicial.AGB_DdImport);
        wIni.WriteString('AGB_Producao', 'Assinala',
          Boolean_SN(wInicial.AGB_Assinala));
        wIni.WriteString('AGB_Producao', 'ImagemFundo', wInicial.AGB_ImgFundo);
        wIni.WriteString('AGB_Producao', 'LogoTela', wInicial.AGB_LogoTela);
        wIni.WriteString('AGB_Producao', 'LogoPrint', wInicial.AGB_LogoPrint);
        wIni.WriteString('AGB_Producao', 'QuadroDiario', wInicial.AGB_Quadro);
        wIni.WriteString('AGB_Producao', 'Legendas',
          Boolean_SN(wInicial.AGB_OPLegendas));
        wIni.WriteInteger('AGB_Producao', 'DispMinimo',
          wInicial.AGB_DispMinimo);
        wIni.WriteInteger('AGB_Producao', 'MetrPadrao',
          wInicial.AGB_MetrPadrao);
        wIni.WriteInteger('AGB_Producao', 'GrupoEstoque',
          wInicial.AGB_GrupoEstoque);
        {
          wIni.WriteString('AGB_VendasExternas',  'ImgBobA',           wInicial.AGB_BobA);
          wIni.WriteString('AGB_VendasExternas',  'ImgBobB',           wInicial.AGB_BobB);
          wIni.WriteString('AGB_VendasExternas',  'ImgBobC',           wInicial.AGB_BobC);
          wIni.WriteString('AGB_VendasExternas',  'ImgBobD',           wInicial.AGB_BobD);
          wIni.WriteInteger('AGB_VendasExternas', 'Tubete',            wInicial.AGB_Tubete);
          wIni.WriteFloat('AGB_VendasExternas',   'FatorCliche',       wInicial.AGB_FatorCliche);
          wIni.WriteFloat('AGB_VendasExternas',   'Margem',            wInicial.AGB_Margem);
        }
      end;

      // Oficina do Frio
      if (wModulos = 'TODOS') or (Pos('OFRIO', wModulos) > 0) then
      begin
        wIni.WriteString('OficinaDoFrio', 'Utiliza',
          Boolean_SN(wInicial.OF_Utiliza));
        wIni.WriteInteger('OficinaDoFrio', 'LPrecoPadrao',
          wInicial.OF_LPPadrao);
        wIni.WriteString('OficinaDoFrio', 'AtualizaCadastro',
          Boolean_SN(wInicial.OF_AtzCadas));
        wIni.WriteInteger('OficinaDoFrio', 'RubPecaIE', wInicial.OF_RubPec);
        wIni.WriteInteger('OficinaDoFrio', 'RubServIE', wInicial.OF_RubSrv);
        wIni.WriteString('OficinaDoFrio', 'GeraVendaIE',
          Boolean_SN(wInicial.OF_OSIE_EmiteNF));
        wIni.WriteString('OficinaDoFrio', 'AltClienteIE',
          Boolean_SN(wInicial.OF_OSIE_AltClie));
        wIni.WriteString('OficinaDoFrio', 'LogoOSIE', wInicial.OF_OSIEImagem);
        wIni.WriteInteger('OficinaDoFrio', 'GarantiaIE',
          wInicial.OF_OSIEGarantia);
        wIni.WriteInteger('OficinaDoFrio', 'Atendimentos',
          wInicial.OF_OSIEUltAtend);
        wIni.WriteString('OficinaDoFrio', 'CNPJOSIE',
          Boolean_SN(wInicial.OF_OSIECNPJ));
        wIni.WriteString('OficinaDoFrio', 'EMailOSIE',
          Boolean_SN(wInicial.OF_OSIEEmail));
        wIni.WriteInteger('OficinaDoFrio', 'RubPecaAC', wInicial.OF_RubPecAC);
        wIni.WriteInteger('OficinaDoFrio', 'RubServAC', wInicial.OF_RubSrvAC);
        wIni.WriteInteger('OficinaDoFrio', 'RubAparAC', wInicial.OF_RubApaAC);
        wIni.WriteString('OficinaDoFrio', 'GeraVendaAC',
          Boolean_SN(wInicial.OF_OSAC_EmiteNF));
        wIni.WriteString('OficinaDoFrio', 'AltClienteAC',
          Boolean_SN(wInicial.OF_OSAC_AltClie));
        wIni.WriteString('OficinaDoFrio', 'LogoOSAC', wInicial.OF_OSACImagem);
        wIni.WriteInteger('OficinaDoFrio', 'GarantiaAC',
          wInicial.OF_OSACGarantia);
        wIni.WriteInteger('OficinaDoFrio', 'CodAparAC', wInicial.OF_AparAC);
        wIni.WriteInteger('OficinaDoFrio', 'CodServAC', wInicial.OF_SrvIAC);
        wIni.WriteString('OficinaDoFrio', 'CNPJOSAC',
          Boolean_SN(wInicial.OF_OSACCNPJ));
        wIni.WriteString('OficinaDoFrio', 'EMailOSAC',
          Boolean_SN(wInicial.OF_OSACEmail));
        wIni.WriteFloat('OficinaDoFrio', 'TxLinhaBranca',
          wInicial.OF_TxLinBranca);
        wIni.WriteFloat('OficinaDoFrio', 'TxArCondicionado',
          wInicial.OF_TxArCond);
        wIni.WriteString('OficinaDoFrio', 'ServEspTec',
          Boolean_SN(wInicial.OF_ServEspTec));
        wIni.WriteString('OficinaDoFrio', 'PrintTaxa',
          Boolean_SN(wInicial.OF_PrintTaxa));
        wIni.WriteFloat('OficinaDoFrio', 'TxLinhaBranca',
          wInicial.OF_TxLinBranca);
        wIni.WriteFloat('OficinaDoFrio', 'TxArCondicionado',
          wInicial.OF_TxArCond);
        wIni.WriteString('OficinaDoFrio', 'ServEspTec',
          Boolean_SN(wInicial.OF_ServEspTec));
        wIni.WriteString('OficinaDoFrio', 'PrintTaxa',
          Boolean_SN(wInicial.OF_PrintTaxa));
        wIni.WriteString('OficinaDoFrio', 'LogOSIE', wInicial.OF_LogOSIE);
        wIni.WriteInteger('OficinaDoFrio', 'MinimoLinhas',
          wInicial.OF_OSIEMinLin);
        wIni.WriteString('OficinaDoFrio', 'LogOSAC', wInicial.OF_LogOSAC);
        wIni.WriteString('OficinaDoFrio', 'ScanIEPath', wInicial.OF_ScanIEPath);
        wIni.WriteInteger('OficinaDoFrio', 'ScanIEDiv', wInicial.OF_ScanIEDiv);
        wIni.WriteString('OficinaDoFrio', 'ScanACPath', wInicial.OF_ScanACPath);
        wIni.WriteInteger('OficinaDoFrio', 'ScanACDiv', wInicial.OF_ScanACDiv);
        //
        wIni.WriteInteger('OF_LG', 'Grupo1', wInicial.OF_LGGrp1);
        wIni.WriteInteger('OF_LG', 'Grupo2', wInicial.OF_LGGrp2);
        wIni.WriteInteger('OF_LG', 'Grupo3', wInicial.OF_LGGrp3);
        wIni.WriteInteger('OF_LG', 'Grupo4', wInicial.OF_LGGrp4);
        wIni.WriteInteger('OF_LG', 'Marca1', wInicial.OF_LGMar1);
        wIni.WriteInteger('OF_LG', 'Marca2', wInicial.OF_LGMar2);
        //
        wIni.WriteString('OF_OSEspecial', 'Cliente', wInicial.OF_OSEspCliente);
        wIni.WriteFloat('OF_OSEspecial', 'Comissao', wInicial.OF_OSEspComss);
        wIni.WriteInteger('OF_OSEspecial', 'PrazoPadrao',
          wInicial.OF_PrazoPadrao);
        wIni.WriteString('OF_OSEspecial', 'PlanilhaPadrao',
          wInicial.OF_PlanilhaPadrao);
        wIni.WriteString('OF_OSEspecial', 'Prestador', wInicial.OF_Prestador);
        wIni.WriteInteger('OF_OSEspecial', 'LPreco', wInicial.OF_LPreco);
        wIni.WriteInteger('OF_OSEspecial', 'CFOPDevolucao',
          wInicial.OF_OSEspCFOPDev);
        wIni.WriteInteger('OF_OSEspecial', 'CodCadas', wInicial.OF_OSEspCadas);
        wIni.WriteInteger('OF_OSEspecial', 'EmpFil', wInicial.OF_OSEspEmpFil);
        wIni.WriteString('OF_OSEspecial', 'Teste',
          Boolean_SN(wInicial.OF_OSEspTeste));
        //
        wIni.WriteString('OF_VendedorAC', 'ACVend01', wInicial.OF_ACVend01);
        wIni.WriteInteger('OF_VendedorAC', 'ACCodV01', wInicial.OF_ACCodV01);
        wIni.WriteString('OF_VendedorAC', 'ACVend02', wInicial.OF_ACVend02);
        wIni.WriteInteger('OF_VendedorAC', 'ACCodV02', wInicial.OF_ACCodV02);
        wIni.WriteString('OF_VendedorAC', 'ACVend03', wInicial.OF_ACVend03);
        wIni.WriteInteger('OF_VendedorAC', 'ACCodV03', wInicial.OF_ACCodV03);
        wIni.WriteString('OF_VendedorAC', 'ACVend04', wInicial.OF_ACVend04);
        wIni.WriteInteger('OF_VendedorAC', 'ACCodV04', wInicial.OF_ACCodV04);
        wIni.WriteString('OF_VendedorAC', 'ACVend05', wInicial.OF_ACVend05);
        wIni.WriteInteger('OF_VendedorAC', 'ACCodV05', wInicial.OF_ACCodV05);

      end;

      // Estrutura de produtos
      if (wModulos = 'TODOS') or (Pos('ESTRUT', wModulos) > 0) then
      begin
        wIni.WriteInteger('Estruturas', 'GrpInsumo1', wInicial.EP_Ins1);
        wIni.WriteInteger('Estruturas', 'GrpInsumo2', wInicial.EP_Ins2);
        wIni.WriteInteger('Estruturas', 'GrpInsumo3', wInicial.EP_Ins3);
        wIni.WriteInteger('Estruturas', 'GrpInsumo4', wInicial.EP_Ins4);
        wIni.WriteInteger('Estruturas', 'GrpInsumo5', wInicial.EP_Ins5);
        wIni.WriteInteger('Estruturas', 'Valorizacao', wInicial.EP_Valorizacao);
        wIni.WriteInteger('Estruturas', 'DiasCalculo', wInicial.EP_DiasCalculo);
        wIni.WriteInteger('Estruturas', 'DecQtd', wInicial.EP_DecQtd);
        wIni.WriteInteger('Estruturas', 'DecVlr', wInicial.EP_DecVlr);
      end;

      // Compactação e envio XML e PDF das NFe
      if (wModulos = 'TODOS') or (Pos('ENVIOX', wModulos) > 0) then
      begin
        wIni.WriteString('EnvioXMLDanfe', 'PathDestino',
          wInicial.EnvNFE_PathDestino);
        wIni.WriteString('EnvioXMLDanfe', 'Envio', wInicial.EnvNFE_Envio);
        wIni.WriteString('EnvioXMLDanfe', 'Arquivos', wInicial.EnvNFE_Arquivos);
        wIni.WriteString('EnvioXMLDanfe', 'Compressao',
          wInicial.EnvNFE_Compressao);
        wIni.WriteString('EnvioXMLDanfe', 'Destinatario',
          wInicial.EnvNFE_Destinatario);
      end;

      // Padrões afiliação - cartões
      wIni.WriteInteger('AfiliacaoCartao', 'Credito', wInicial.PadraoCredito);
      wIni.WriteInteger('AfiliacaoCartao', 'Debito', wInicial.PadraoDebito);

      // Fast Food
      if (wModulos = 'TODOS') or (Pos('FASTF', wModulos) > 0) then
      begin
        wIni.WriteString('FastFood', 'Modulos', wInicial.FFood_Modulos);
        wIni.WriteString('FastFood', 'Configura',
          Boolean_SN(wInicial.FFood_Configura));
        wIni.WriteString('FastFood', 'UsaFluxos',
          Boolean_SN(wInicial.FFood_UsaFluxos));
        wIni.WriteString('FastFood', 'LstSenha',
          Boolean_SN(wInicial.FFood_LstSenha));
        wIni.WriteInteger('FastFood', 'TamSenha', wInicial.FFood_TamSenha);
        wIni.WriteString('FastFood', 'LstObserv',
          Boolean_SN(wInicial.FFood_LstObserv));
        wIni.WriteString('FastFood', 'IniciaTurno',
          Boolean_SN(wInicial.FFood_IniciaTurno));
        wIni.WriteString('FastFood', 'CaixaNr', wInicial.FFood_CaixaNr);
        wIni.WriteInteger('FastFood', 'LPPadrao', wInicial.FFood_LPPadrao);
        wIni.WriteString('FastFood', 'NomeObrig',
          Boolean_SN(wInicial.FFood_NomeObrig));
        wIni.WriteString('FastFood', 'Cadastro',
          Boolean_SN(wInicial.FFood_Cadastro));
        wIni.WriteString('FastFood', 'Desconto',
          Boolean_SN(wInicial.FFood_Desconto));
        wIni.WriteString('FastFood', 'DescAutom',
          Boolean_SN(wInicial.FFood_DescAutom));
        wIni.WriteInteger('FastFood', 'Imprime_Cli',
          wInicial.FFood_Imprime_Cli);
        wIni.WriteInteger('FastFood', 'Imprime_Int',
          wInicial.FFood_Imprime_Int);
        wIni.WriteInteger('FastFood', 'EMITE_CF', wInicial.FFood_Emite_CF);
        wIni.WriteInteger('FastFood', 'EMITE_CFTele',
          wInicial.FFood_Emite_CFTele);
        wIni.WriteString('FastFood', 'Preview',
          Boolean_SN(wInicial.FFood_Preview));
        wIni.WriteString('FastFood', 'PrintDialog',
          Boolean_SN(wInicial.FFood_PrintDialog));
        wIni.WriteString('FastFood', 'ComplMesa',
          Boolean_SN(wInicial.FFood_ComplMesa));
        wIni.WriteString('FastFood', 'CancPedido',
          Boolean_SN(wInicial.FFood_CancPedido));
        wIni.WriteString('FastFood', 'Exportacao',
          Boolean_SN(wInicial.FFood_Exportacao));
        wIni.WriteString('FastFood', 'PrinterId', wInicial.FFood_PrinterId);
        wIni.WriteInteger('FastFood', 'ViasBalMesa',
          wInicial.FFood_ViasBalMesa);
        wIni.WriteInteger('FastFood', 'ViasTele', wInicial.FFood_ViasTele);
        wIni.WriteString('FastFood', 'Cab01', wInicial.FFood_Cab01);
        wIni.WriteString('FastFood', 'Cab02', wInicial.FFood_Cab02);
        wIni.WriteString('FastFood', 'Cab03', wInicial.FFood_Cab03);
        wIni.WriteString('FastFood', 'Cab04', wInicial.FFood_Cab04);
        wIni.WriteString('FastFood', 'LogoPrint', wInicial.FFood_LogoPrint);
        wIni.WriteString('FastFood', 'LogoCozin', wInicial.FFood_LogoCozin);
        wIni.WriteInteger('FastFood', 'Avanco', wInicial.FFood_AvFinal);
        wIni.WriteString('FastFood', 'SenConfig', wInicial.FFood_SenConfig);
        wIni.WriteString('FastFood', 'Cad_Obsrv', wInicial.FFood_Cad_Obsrv);
        wIni.WriteString('FastFood', 'Cad_Aglut', wInicial.FFood_Cad_Aglut);
        wIni.WriteString('FastFood', 'Cad_Fecha', wInicial.FFood_Cad_Fecha);
        wIni.WriteString('FastFood', 'Cad_EmPag', wInicial.FFood_Cad_EmPag);
        wIni.WriteString('FastFood', 'Cad_Relac', wInicial.FFood_Cad_Relac);
        wIni.WriteString('FastFood', 'ECFS_Nome', wInicial.FFood_ECFS_Nome);
        // xDocFiscal
        wIni.WriteString('FastFood', 'ECFS_Descr', wInicial.FFood_ECFS_Descr);
        wIni.WriteString('FastFood', 'ECFS_CodProd',
          wInicial.FFood_ECFS_CodProd);
        wIni.WriteInteger('FastFood', 'ECFS_Foco', wInicial.FFood_ECFS_Foco);
        wIni.WriteInteger('FastFood', 'ECFS_VlRec', wInicial.FFood_ECFS_VlRec);
        wIni.WriteInteger('FastFood', 'ECFS_TimeOut',
          wInicial.FFood_ECFS_TimeOut);
        wIni.WriteInteger('FastFood', 'ECFS_Valores',
          wInicial.FFood_ECFS_Valores);
        wIni.WriteString('FastFood', 'Aliq25', wInicial.FFood_Aliq25);
        // Aliquota no ECF
        wIni.WriteString('FastFood', 'Aliq18', wInicial.FFood_Aliq18);
        wIni.WriteString('FastFood', 'Aliq17', wInicial.FFood_Aliq17);
        wIni.WriteString('FastFood', 'Aliq12', wInicial.FFood_Aliq12);
        wIni.WriteString('FastFood', 'Aliq07', wInicial.FFood_Aliq07);
        wIni.WriteString('FastFood', 'Aliq04', wInicial.FFood_Aliq04);
        wIni.WriteString('FastFood', 'CFOP', wInicial.FFood_CFOP);
        wIni.WriteString('FastFood', 'NCM', wInicial.FFood_NCM);
        wIni.WriteInteger('FastFood', 'NDAvanco', wInicial.FFood_NDAvanco);
        wIni.WriteInteger('FastFood', 'Tributacao', wInicial.FFood_TotTrib);
        wIni.WriteString('FastFood', 'PrintRAW',
          Boolean_SN(wInicial.FFood_RAW));
        wIni.WriteString('FastFood', 'RawCab1', wInicial.FFood_Cab1RAW);
        wIni.WriteString('FastFood', 'RawCab2', wInicial.FFood_Cab2RAW);
        wIni.WriteString('FastFood', 'RawCab3', wInicial.FFood_Cab3RAW);
        wIni.WriteString('FastFood', 'RawCab4', wInicial.FFood_Cab4RAW);
        wIni.WriteString('FastFood', 'RawTicket', wInicial.FFood_IdPedRAW);
        wIni.WriteString('FastFood', 'DescrUnica', wInicial.FFood_DescrUnica);
        wIni.WriteString('FastFood', 'CodUnica', wInicial.FFood_CodUnica);
        wIni.WriteString('FastFood', 'Bebidas', wInicial.FFood_DescrSTItens);
        wIni.WriteString('FastFood', 'CodBeb', wInicial.FFood_CodSTItens);
        wIni.WriteString('FastFood', 'Refeicoes', wInicial.FFood_DescrItens);
        wIni.WriteString('FastFood', 'CodRef', wInicial.FFood_CodItens);
        wIni.WriteString('FastFood', 'PedRelacNFe',
          Boolean_SN(wInicial.FFood_PedRelacNFe));
        wIni.WriteString('FastFood', 'PedUsoNFe',
          Boolean_SN(wInicial.FFood_PedUsoNFe));
        wIni.WriteString('FastFood', 'PreviewDanfe',
          Boolean_SN(wInicial.FFood_VisDANFE));
        wIni.WriteString('FastFood', 'NFePrinter', wInicial.FFood_NFePrinter);
        wIni.WriteInteger('FastFood', 'AvancoExtra', wInicial.FFood_AvExtra);
        wIni.WriteInteger('FastFood', 'InicioBalcao', wInicial.FFood_IniBalcao);
        wIni.WriteInteger('FastFood', 'FinalBalcao', wInicial.FFood_FinBalcao);
        wIni.WriteString('FastFood', 'TicketSimples',
          Boolean_SN(wInicial.FFood_TicketSimples));
        wIni.WriteString('FastFood', 'TransacaoFinal',
          Boolean_SN(wInicial.FFood_TransFinal));
        wIni.WriteString('FastFood', 'Kiosk', Boolean_SN(wInicial.FFood_Kiosk));
        wIni.WriteString('FastFood', 'PathIntegr', wInicial.FFood_PathIntegr);
        wIni.WriteString('FastFood', 'KioskCoord',
          Boolean_SN(wInicial.FFood_KioskCoord));
        wIni.WriteInteger('FastFood', 'KioskMaxProd',
          wInicial.FFood_KioskMaxProd);
        wIni.WriteInteger('FastFood', 'KioskMaxItens',
          wInicial.FFood_KioskMaxItens);
        wIni.WriteString('FastFood', 'CaixaUnico',
          Boolean_SN(wInicial.FFood_CaixaUnico));
        wIni.WriteString('FastFood', 'CaixaPathId', wInicial.FFood_CaixaPathId);
      end;

      // NFeRvCar
      if (wModulos = 'TODOS') or (Pos('RVCAR', wModulos) > 0) then
      begin
        wIni.WriteString('NfeRvCar', 'ImagemFundo', wInicial.RvCar_ImgFundo);
        wIni.WriteString('NfeRvCar', 'ImagemLogo', wInicial.RvCar_ImgLogo);
        wIni.WriteString('NfeRvCar', 'Inf0', wInicial.RvCar_Inf0);
        wIni.WriteString('NfeRvCar', 'Inf1', wInicial.RvCar_Inf1);
        wIni.WriteString('NfeRvCar', 'Inf2', wInicial.RvCar_Inf2);
        wIni.WriteString('NfeRvCar', 'Inf3', wInicial.RvCar_Inf3);
        wIni.WriteString('NfeRvCar', 'Inf4', wInicial.RvCar_Inf4);
        wIni.WriteString('NfeRvCar', 'Inf5', wInicial.RvCar_Inf5);
        wIni.WriteString('NfeRvCar', 'Inf6', wInicial.RvCar_Inf6);
        wIni.WriteString('NfeRvCar', 'Inf7', wInicial.RvCar_Inf7);
        wIni.WriteString('NfeRvCar', 'Inf8', wInicial.RvCar_Inf8);
        wIni.WriteString('NfeRvCar', 'Inf9', wInicial.RvCar_Inf9);
        wIni.WriteString('NfeRvCar', 'Tag0', wInicial.RvCar_Tag0);
        wIni.WriteString('NfeRvCar', 'Tag1', wInicial.RvCar_Tag1);
        wIni.WriteString('NfeRvCar', 'Tag2', wInicial.RvCar_Tag2);
        wIni.WriteString('NfeRvCar', 'Tag3', wInicial.RvCar_Tag3);
        wIni.WriteString('NfeRvCar', 'Tag4', wInicial.RvCar_Tag4);
        wIni.WriteString('NfeRvCar', 'Tag5', wInicial.RvCar_Tag5);
        wIni.WriteString('NfeRvCar', 'Tag6', wInicial.RvCar_Tag6);
        wIni.WriteString('NfeRvCar', 'Tag7', wInicial.RvCar_Tag7);
        wIni.WriteString('NfeRvCar', 'Tag8', wInicial.RvCar_Tag8);
        wIni.WriteString('NfeRvCar', 'Tag9', wInicial.RvCar_Tag9);
        wIni.WriteInteger('NfeRvCar', 'ModoNFe', wInicial.RvCar_ModoNFe);
        wIni.WriteInteger('NFeRvCar', 'Encadeamento', wInicial.RvCar_Encad);
        wIni.WriteString('NfeRvCar', 'VersaoNFe', wInicial.RvCar_VerNFe);
        wIni.WriteString('NfeRvCar', 'ExecNFe', wInicial.RvCar_ExeNFe);
        wIni.WriteInteger('NfeRvCar', 'TimeOut', wInicial.RvCar_TimeOut);
        wIni.WriteString('NfeRvCar', 'HorarioVerao',
          Boolean_SN(wInicial.RvCar_HrVerao));
        wIni.WriteDate('NfeRvCar', 'HV_Inicio', wInicial.RvCar_HVIni);
        wIni.WriteDate('NfeRvCar', 'HV_Final', wInicial.RvCar_HVFin);
        wIni.WriteString('NfeRvCar', 'PathConfigsNFe', wInicial.RvCar_PathCfg);
        wIni.WriteInteger('NfeRvCar', 'ModBC', wInicial.RvCar_ModBC);
        wIni.WriteInteger('NfeRvCar', 'ModBCST', wInicial.RvCar_ModBCST);
        wIni.WriteInteger('NfeRvCar', 'DigRenavam', wInicial.RvCar_DigRenavam);
        wIni.WriteString('NFeRvCar', 'ValRenavam',
          Boolean_SN(wInicial.RvCar_ValRenavam));
        wIni.WriteString('NFeRvCar', 'MC5464',
          Boolean_SN(wInicial.RvCar_MC5464));
        wIni.WriteString('NFeRvCar', 'NVE', wInicial.RvCar_NVE);
        wIni.WriteString('NFeRvCar', 'CEST', wInicial.RvCar_CEST);
        wIni.WriteString('NFeRvCar', 'cBenef', wInicial.RvCar_cBenef);
        wIni.WriteInteger('NFeRvCar_CFOP_UF', 'VENDA',
          wInicial.RvCar_CFOPVendaUF);
        wIni.WriteInteger('NFeRvCar_CFOP_UF', 'DEVOL',
          wInicial.RvCar_CFOPDevolUF);
        wIni.WriteInteger('NFeRvCar_CFOP_UF', 'ENTRA',
          wInicial.RvCar_CFOPEntraUF);
        wIni.WriteInteger('NFeRvCar_CFOP_OutraUF', 'VENDA',
          wInicial.RvCar_CFOPVendaOUF);
        wIni.WriteInteger('NFeRvCar_CFOP_OutraUF', 'DEVOL',
          wInicial.RvCar_CFOPDevolOUF);
        wIni.WriteInteger('NFeRvCar_CFOP_OutraUF', 'ENTRA',
          wInicial.RvCar_CFOPEntraOUF);
      end;

      // Consignacoes - 1  (Happy Semi-Joias)
      if (wModulos = 'TODOS') or (Pos('CONSIG1', wModulos) > 0) // Consig1 = HSJ
      then
      begin
        wIni.WriteInteger('Consig1', 'Empresa', wInicial.Csg1_Empresa);
        wIni.WriteString('Consig1', 'LctUnitario',
          Boolean_SN(wInicial.Csg1_QtdLct));
        wIni.WriteString('Consig1', 'EstNegativo',
          Boolean_SN(wInicial.Csg1_EstNeg));
        wIni.WriteString('Consig1', 'AltPreco',
          Boolean_SN(wInicial.Csg1_AltPreco));
        wIni.WriteInteger('Consig1', 'CampoInfo', wInicial.Csg1_Campo);
        wIni.WriteString('Consig1', 'StopVTotal',
          Boolean_SN(wInicial.Csg1_StopVTotal));
        wIni.WriteString('Consig1', 'RepItem',
          Boolean_SN(wInicial.Csg1_RepItem));
        wIni.WriteString('Consig1', 'Consolid',
          Boolean_SN(wInicial.Csg1_Consolid));
        wIni.WriteString('Consig1', 'Logo10x7', wInicial.Csg1_Logo10x7);
        wIni.WriteString('Consig1', 'LstSitu',
          Boolean_SN(wInicial.Csg1_LstSitu));
        wIni.WriteInteger('Consig1', 'TpDoc', wInicial.Csg1_TpDoc);
      end;

      // Mecanico
      wIni.WriteString('Mecanico', 'Chassi', Boolean_SN(wInicial.MecChassi));
      wIni.WriteString('Mecanico', 'Renavam', Boolean_SN(wInicial.MecRenavam));

      wIni.Free;
      FormataArquivoIni(wIniName);

    end;

  end;

end;

Function ExecutaAbortaProcesso(pExeName: String; var pmtUser: String): Boolean;
var
  wIni: TIniFile;
  wIniFile, wInf: String;
begin
  Result := True;
  wIniFile := ChangeFileExt(pExeName, '.Txt');
  wIni := TIniFile.Create(wIniFile);
  if not FileExists(wIniFile) then
  begin
    wIni.WriteString('Execucao', 'ExecutaAborta', 'A');
    wIni.WriteString('Execucao', 'Usuario', '');
  end;
  wInf := wIni.ReadString('Execucao', 'ExecutaAborta', 'A');
  pmtUser := wIni.ReadString('Execucao', 'Usuario', '');
  if Pos('E', wInf) = 0 then
    Result := False;
  wIni.Free;

end;

Procedure SalvaUsuarioProcesso(pExeName: String; pmtUser: String);
var
  wIni: TIniFile;
  wIniFile: String;
begin
  wIniFile := ChangeFileExt(pExeName, '.Txt');
  wIni := TIniFile.Create(wIniFile);
  wIni.WriteString('Execucao', 'Usuario', pmtUser);
  wIni.Free;

end;

Procedure GravaSerial(pmtNomeArq: String; pmtSerial: String);
var
  wIni: TIniFile;
  wIniFile: String;
begin
  wIniFile := pmtNomeArq;
  wIni := TIniFile.Create(wIniFile);
  wIni.WriteString('Dados', 'Serial', pmtSerial);
  wIni.Free;

end;

procedure TFuIniGeral.FormCreate(Sender: TObject);
begin
  decForm[0] := '0';
  decForm[1] := '0.0';
  decForm[2] := '0.00';
  decForm[3] := '0.000';
  decForm[4] := '0.0000';
  IniMemo.Font.Size := 8;
  IniMemo.Visible := False;
  IniMemo.Width := 1024;

end;

end.
