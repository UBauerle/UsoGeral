unit uFuncoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, DateUtils, DBGrids, Buttons, Grids, DBClient,
  ExtCtrls, WinINet, TLHelp32, Math, IniFiles, Printers, ShellApi, ComCtrls;

  Function  ObtemAlturaBarraTarefas: Integer;
  Function  ObtemConfiguracaoTela(var btarAlt,btarLrg:Integer; var maxAlt,maxLrg:Integer): String;
  Function  ObtemLimitesTela(var rTelaUtil:TRect; var pLrg,pAlt:Integer): String;
  Function  AjustaPathBarraFinal(pmtPath:String;pSN:Boolean): String;
  Procedure AtivaBlocodeNotas(pmtArqTxt:String);
  Procedure EncadeamentoExecutavel(pmtExec,pmtParm:String; pmtForma:String='WinExec'; pmtShow:Integer=1);
  Function  ValidaChaveNFe(pChave:String;pMsg:Boolean): Boolean;
  Procedure Form_Salva(pmtForm:TForm);
  Procedure Form_Define(pmtForm:TForm; pmtMax:Boolean=False);
  Procedure Form_DefineOrig(pmtForm:TForm; pTop,pLeft,pHeight,pWidth:Integer);
  Procedure Form_SimplesDefinicao(pmtForm:TForm; pHeight,pWidth:Integer);
  Procedure Form_DefineDimensaoMinima(pmtForm:TForm; pWidth,pHeight:Integer);
  Procedure Form_Imprime(pmtForm:TForm; pmtStretch:Boolean);
  Procedure Form_Centraliza(pmtForm:TForm; pHeight:Integer=0; pWidth:Integer=0);

  Procedure GravaLog(pLogFile:String; pOper:Integer; pUserApp,pUserSys,pInfo:String);
  Function  StringCompleta(pDado:String;pEDC,pCar:Char;pTam:Integer;pCorta:Boolean = True):String;
  Function  StringFiller(pCar:Char;pTam:Integer):String;
  Function  StringFillString(pCar:String;pTam:Integer): String;
  Function  StringValor(pArgum:String): Real;
  Function  TextoRetiraAcentuacao(pInfo:String;pMaiusc:Boolean = True):String;
  Function  RetiraCRLF(pInfo:String; pMaiusc:Boolean=True; pNewChr:Char=#32): String;

  Function  DefineMascaraJurFis(pJF:String;pChr:String = '0'): String;

  Function  DataJuliana(pmtData:TDateTime;pmtModo:Integer):Integer;
  Function  DataExtenso(pmtData:TDateTime;pmtExt:Boolean):String;
  Function  SemanaDoAno(pmtData:TDateTime):Integer;
  Function  ValidaHorario(pHora:String):Boolean;
  Function  MesesEntreDatas(pDtIni,pDtFin:TDateTime; var rMeses:Integer; var rDias:Integer): Integer;
  Procedure MesAnterior(var pDtIni: TDateTime; var pDtFin: TDateTime);
  Procedure MesCorrente(var pDtIni: TDateTime; var pDtFin: TDateTime; lDiaMax:Boolean = False);
  Procedure MesSeguinte(var pDtIni: TDateTime; var pDtFin: TDateTime; lDiaMax:Boolean = False);
  Function  MesProximoAnterior(pDtWrk: TDateTime; pMes:String = '+'): TDateTime;
  Function  AnoProximoAnterior(pDtWrk: TDateTime; pAno:String = '+'): TDateTime;
  Function  DataString(pData: TDateTime; pTam: Integer = 8): String;
  Function  StringData_DMA(pDtAMD: String; pEdit:Boolean = True): String;
  Function  DataHoraString(pDataHora: TDateTime; pTamAno:Integer=2; pForma:Integer=0): String;
  Function  HoraInteger(pHora:TDateTime): Integer;
  Function  IntegerHora(pHrInt:Integer): TDateTime;
  Function  IntegerHoraStr(pHrInt:Integer): String;
  Function  DataHoraInteger(pDtHr:TDateTime): Integer;
  Function  IntegerDataHora(pDtHr:Integer): TDateTime;
  Function  SegundosEmDias(pSeg:Integer;var rDd:Integer; var rHr:Integer; var rMi:Integer; var rSe:Integer): String;
  Procedure DefineMes(pModo:Integer; var dtIni:TDateTime; var dtFim:TDateTime);
  Procedure DefineMesDP(pModo:Integer; var dtIni:TDateTimePicker; var dtFim:TDateTimePicker);

  Function  EditaValorTexto(pTexto:String; pTam,pDec:Integer): String;

  Function  ValidaCNPJ(pCNPJ:String):Boolean;
  Function  ValidaCPF(pCPF:String):Boolean;
  Function  ValidaCNPJ_CPF(pInfo:String; pTpess:String=''; lSeq:Boolean=False): Boolean;
  Function  ValidaCNPJCPF_Ext(pInfo:String;pTpess:String=''): Boolean;
  Function  ValidaPIS(pPIS:String):Boolean;
  Function  ValidaCartaoCredito(pNrCart:String):Boolean;
  Function  EditaCNPJ_CPF(pDado:String;pTipo:String = 'X'):String;
  Function  EditaCEP(pDado:String):String;

  Function  ValidaInscricaoEstadual(pInscr,pUf:String;pMetodo:Integer=0;lMsg:Boolean=False):Integer;

  Function  ValidaPlacaVeiculo(pmtPlacas:String):Integer;
  Function  ValidaRenavam(pmtRenavam:String): Boolean;
  Function  ValidaUF(pmtSigla:String):Boolean;
  Function  CalculaDV11(pmtNro:String):String;
  Function  CalculaDVEAN13(pmtNro:String):String;
  Function  CalculaDVCodBar(pmtNro:String): String;
  Function  ValidaDVCodBar(pmtCodBar:String): Boolean;
  Function  ValidaFCI(pFCI:String;pMsg:Boolean):Boolean;
  Function  ValidaEMail(pEMailIn:String):Boolean;
  Function  ValidaTelefone(pNumero:String; var pNroUso:String): String;

  Function  VerificaConexao(pDrive,pPath,pPsw:String):Integer;
  Function  DSStateText(pState: TDataSetState): String;

  Function  DefineGrid(pGrid:TDBGrid; pLarg:Array of Real; pCol1,pCol2:Integer; pPerc:Boolean = True): TDBGrid;
  Procedure DestaqueGrid(pGrid:TDbGrid; pCor,pCorDest,pTit,pTitDest:TColor; pCol:Integer);
  Procedure DestacaLinhaGrid(pmtDbGrid:TDBGrid; pmtCor:TColor;
                             const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
  Procedure DefineColunasGrid(pGrid:TDBGrid; pLarg:Array of Integer);
  Function  ValidaComboBox(pmtComboBox:TComboBox;pmtIgual:Boolean=True;pmtMsg:Boolean=False): Boolean;

  Function  AbreviaNome(pNome:String;pTam:Integer):String;
  Function  PrepVlrECF(pValor:Real;pTam,pDec:Integer):String;
  Function  DataUTC(pDataHora: TDateTime):String;

  Function  Numerico(pDado:String): String;
  Function  AlfaNumerico(pDado:String;pUpper:Boolean=False): String;
  Function  Alfabetico(pDado:String): String;
  Function  AlfaNumericoEspecial(pDado:String;pUpper:Boolean=False;pValid:Integer=1): String;
  Function  ConjuntoEspecial(pDado:String;pValid:String;pUpperCase:Boolean=True): String;

  Function  TrocaCaracteres(var pDado:String; pCarac:String; pTroca:String): Boolean;
  Function  ValorTxt(pValor:Real;pTam,pPrec:Integer;pProcura:String=','): String;

  Function  Retira_CRLF(pDado:String): String;
  Function  RetiraEspacos(pDado:String;pUpper:Boolean): String;
  Function  FormataNomes(pmtTexto:String; pmtFormata:Boolean=False): String;
  Function  EditaFone(pDDd,pFone:String): String;
  Function  ValidaNumeroFone(pmtFone:String;var pmtRetorno:String;pmtExterior:Boolean = False): Boolean;
  Function  AjustaNumeroFone(var pmtFone:String): Boolean;
  Function  PrimeiroCaracterMaiusculo(pArgum:String): String;

  Function  ConexaoInternet(pMsg:Boolean): Boolean;
  Function  ConexaoInternet2(pMsg:Boolean): Boolean;
  Function  EditaChaveNFe(pArgum:String; pEditaVazio:Boolean = False): String;
  Function  DecodificaChaveNFe(pChaveNFe:String;
                               var rUF:String; var rAno:String; var rMes:String;
                               var rCNPJ:String; var rMod:String; var rSerie:String; var rNumero:String;
                               var rEmissao:String; var rCodNum:String; var rDV:String): Boolean;
  Function  ValidaTextoNFe(pTexto:String): Boolean;

  Function  ProcessoAtivo(pNomeProcesso:String;pMsg:Boolean): Boolean;
  Function  CarregaProcesso(pPathExec,pNomeProcesso:String): Boolean;
  Function  CopiaArquivo(pmtOrig,pmtDest:String;
                         pmtExclueOrigem: Boolean = False;
                         pmtExibeMsg: Boolean = False): Integer;

  Function  CalculaPercentual(pValor,pPerc:Real;pArred:Integer = 2):Real;
  Function  CalculaPercTrunca(pValor,pPerc:Real;pArred:Integer = 2):Real;
  Function  ObtemPorcentagem(pVlr100,pVlrInf:Real;pArred:Integer = 2):Real;
  Function  Potenciacao(pVlr:Real;pPot:Integer):Real;
  Function  Fatorial(pNro:Integer): Integer;
  Procedure CalculaParcelamento(pValorInicial:Real; pNrParc:Integer; pTaxa:Real; pTpTaxa:String;
                                var rAcrescimo:Real;   var rValorFinal:Real;
                                var rVlrPrimeira:Real; var rVlrParcela:Real);

  Function  CoeficienteParcela(pTxJur:Real;pNPer:Integer): Real;
  Function  DiaUtil(pmtData:TDateTime): Boolean;
  Function  CalculaValorAtual(pVlrEmissao,pVlrDesconto,pPcJuros,pVlrMulta,pVlrPago:Real;
                              pTipoJuros:Integer;
                              pDtVencto,pDtDesconto,pDtCalculo:TDateTime;
                              pConcDesc:Boolean = False): Real;

  Procedure CalculaParcelasRestantes(pmtParc,pmtMaxParc:Integer; pmtTotal:Real; var pmtValores: array of Real; var vlrSoma: Real);

  Procedure MontaTextosPesquisa(pmtTexto:String);
  Procedure CalculaParcelas(pParcMax,pParcAtu,pDec:Integer);
  Function  ContaArquivos(pDiretorio, pMascara:string): Integer;
  Function  AtribueArrayInteger(inpArray: array of Integer; var outArray: array of Integer): Boolean;
  Function  SN_Boolean(pArgum: String): Boolean;
  Function  Boolean_SN(pArgum: Boolean): String;
  Function  CalculaAlgoritmoSeguranca(pArgumento1,pArgumento2,pArgumento3,pArgumento4:String; pValidade:TDateTime):Integer;

  Function  ValorExtenso(Vlr:Real; Tam:Integer; lMF:Boolean):String;

  Function  CalculaDiasEntreDatas(pDtInicial,pDtFinal: TDateTime): Integer;
  Function  ArredondaTrunca(pValor:Real; pDec:Integer; ArredTrunc:String): Real;

  Function  TxtTpDocFiscal(pTpDoc:Integer; pAbrev:Boolean = True): String;
  Function  CalculaFatorImportacao(aliqImport,aliqIPI,aliqPIS,aliqCOFINS,aliqICM:Real): Real;
  Function  TruncaValor(pmtValor:Real; pmtDec:Integer = 2): Real;

  Function  DefineMascaraGeral(pN1:Integer; pN2:Integer = 0; pN3:Integer = 0; pN4:Integer = 0; pN5:Integer = 0): String;
  Function  ObtemDataHoraArquivo(pArquivo:String;var pDtHr:TDateTime): Boolean;

  Function  DataBaseState(wState:TDataSetState): String;
  Function  Obtem_UF_CNPJ(pKey:String; var rUF:String; var rCNPJ:String; var rMsg:String):Boolean;

  Procedure FormataArquivoIni(pArqIniName:String);
  Function  ExibeDebug(lExibe:Boolean; pIdMsg:String; var nOcorr: Integer): Integer;
  Function  ApagaLCK(pPath:String; pMsg:Boolean=False): Boolean;
  Function  ExisteCampoNoDataSet(pmtField:String; pmtDataSet:TDataSet): Boolean;

  Function  AtualizaLogFile(pmtFile:String; pmtLog:TStringList; pmtIniFim:Boolean = True): Boolean;
  Procedure DebugMensagem(pDebug:Boolean; pTexto:String);

  Function  TempoRestanteEstimado(pHrIni:TDateTime; pQtdMax:Integer; pQtdCorr:Integer; pMiliSeg:Boolean;
                                 var rDias: Integer;
                                 var rHoras: Integer;
                                 var rMinutos: Integer;
                                 var rSegundos: Integer;
                                 var rMiliSeg: Integer): String;

  Function  ObtemArquivos(pmtDiretorio:String; pmtExtensao:String; var Arquivos:TStringList): Boolean;
  Procedure Identificacao(pmtTexto:String; var pmtIdentif:String);

type
  TFuFuncoes = class(TForm)
    LabOperacao: TLabel;
    btOk: TBitBtn;
    btCanc: TBitBtn;
    edInfo: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure btCancClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    lSalvaForm,lDebug: Boolean;
    pathSalvaForm: String;
    txComp: array[1..10] of String;
    txSel: Integer;
    CP_vlParc: Array [0..36] of Real;        // Utilizado em CalculaParcelas
    

  end;

  // Declarações necessárias para validação de inscrição estadual (DllInscE32.DLL)
  // utilizado em ValidaInscricaoEstadual
  TCIEst = function(XInscr,UF:String):Integer; Stdcall;
  TVers  = function: Integer;Stdcall;

var
  FuFuncoes: TFuFuncoes;
  wIE,wDV,wMensagem: String;              // Variaveis para validação de Inscr.estadual
  AA,MM,DD: Word;

const
  DiasMes: array[1..12] of Integer = (31,28,31,30,31,30,31,31,30,31,30,31);
  xSiglas: array[1..27, 1..5] of String =
      (('AC', '13', '13', '',  'Acre'),             // Sigla, Tam1, Tam2, Carac.adic, Nome
       ('AL', '9',  '9',  '',  'Alagoas'),
       ('AP', '9',  '9',  '',  'Amapá'),
       ('AM', '9',  '9',  '',  'Amazonas'),
       ('BA', '8',  '9',  '',  'Bahia'),
       ('CE', '9',  '9',  '',  'Ceará'),
       ('DF', '13', '13', '',  'Distrito Federal'),
       ('ES', '9',  '9',  '',  'Espirito Santos'),
       ('GO', '9',  '9',  '',  'Goiás'),
       ('MA', '9',  '9',  '',  'Maranhão'),
       ('MT', '9',  '11', '',  'Mato Grosso'),
       ('MS', '9',  '9',  '',  'Mato Grosso do Sul'),
       ('MG', '13', '13', '',  'Minas Gerais'),
       ('PA', '9',  '9',  '',  'Pará'),
       ('PB', '9',  '9',  '',  'Paraíba'),
       ('PR', '10', '10', '',  'Paraná'),
       ('PE', '9',  '9',  '',  'Pernambuco'),
       ('PI', '9',  '9',  '',  'Piauí'),
       ('RJ', '8',  '8',  '',  'Rio de Janeiro'),
       ('RN', '9',  '10', '',  'Rio Grande do Norte'),
       ('RS', '10', '10', '',  'Rio Grande do Sul'),
       ('RO', '9',  '14', '',  'Rondônia'),
       ('RR', '9',  '9',  '',  'Roraima'),
       ('SC', '9',  '9',  '',  'Santa Catarina'),
       ('SP', '12', '13', 'P', 'São Paulo'),
       ('SE', '9',  '9',  '',  'Sergipe'),
       ('TO', '9',  '11', '',  'Tocantins'));
  xMsgFixo: String = 'Validação Inscrição Estadual';

implementation

{$R *.DFM}

// Obtem altura
Function ObtemAlturaBarraTarefas: Integer;
var rRect: TRect;
    rBarraTarefas: HWND;
begin
  rBarraTarefas := FindWindow('Shell_TrayWnd', nil);       // Localiza o Handle da barra de tarefas
  GetWindowRect(rBarraTarefas, rRect);                     // Pega o "retângulo" que envolve a barra e sua altura
  Result := rRect.Bottom - rRect.Top;   // Retorna a altura da barra

end;

// Obtem altura, largura e posição da barra de tarefas e a posição
Function  ObtemConfiguracaoTela(var btarAlt,btarLrg:Integer; var maxAlt,maxLrg:Integer): String;
var rRect: TRect;
    rBarraTarefas: HWND;
begin
  rBarraTarefas := FindWindow('Shell_TrayWnd', nil);       // Localiza o Handle da barra de tarefas
  GetWindowRect(rBarraTarefas, rRect);                     // Pega o "retângulo" que envolve a barra e sua altura
  if (rRect.Left = 0) and (rRect.Top > 0) and
     (rRect.Right = Screen.Width) and (rRect.Bottom = Screen.Height)
  then Result := 'B'     // Bottom
  else if (rRect.Left > 0) and (rRect.Top = 0) and
          (rRect.Right = Screen.Width) and (rRect.Bottom = Screen.Height)
       then Result := 'R'     // Right
       else if (rRect.Left = 0) and (rRect.Top = 0) and
               (rRect.Right = Screen.Width) and (rRect.Bottom > 0)
            then Result := 'T'     // Top
            else if (rRect.Left = 0) and (rRect.Top = 0) and
                    (rRect.Right > 0) and (rRect.Bottom = Screen.Height)
                 then Result := 'L'     // Left
                 else Result := 'N';    // Não tem
  btarAlt := rRect.Bottom - rRect.Top;     // Altura da barra de tarefas
  btarLrg := rRect.Right  - rRect.Left;    // Largura da barra de tarefas
  maxAlt  := Screen.Height;
  maxLrg  := Screen.Width;
  if (Result = 'B') or (Result = 'T')
     then maxAlt := Screen.Height - btarAlt;
  if (Result = 'L') or (Result = 'R')
     then maxLrg := Screen.Width - btarLrg;

end;


Function  ObtemLimitesTela(var rTelaUtil:TRect; var pLrg,pAlt:Integer): String;
var rBarraTarefas: HWND;
    rRect: TRect;
begin
  rBarraTarefas := FindWindow('Shell_TrayWnd', nil);       // Localiza o Handle da barra de tarefas
  GetWindowRect(rBarraTarefas, rRect);                     // Pega o "retângulo" que envolve a barra e sua altura
  if (rRect.Left = 0) and
     (rRect.Top > 0) and
     (rRect.Right = Screen.Width) and
     (rRect.Bottom = Screen.Height)
  then begin
    Result           := 'B';  // Bottom (Rodape)
    rTelaUtil.Left   := 0;
    rTelaUtil.Top    := 0;
    rTelaUtil.Right  := rRect.Right;
    rTelaUtil.Bottom := rRect.Top;
  end
  else if (rRect.Left > 0) and
          (rRect.Top = 0) and
          (rRect.Right = Screen.Width) and
          (rRect.Bottom = Screen.Height)
       then begin
         Result           := 'R';  // Right (Direita)
         rTelaUtil.Left   := 0;
         rTelaUtil.Top    := 0;
         rTelaUtil.Right  := rRect.Left;
         rTelaUtil.Bottom := rRect.Bottom;
       end
       else if (rRect.Left = 0) and
               (rRect.Top = 0) and
               (rRect.Right = Screen.Width) and
               (rRect.Bottom > 0)
            then begin
              Result           := 'T';   // Top (Topo)
              rTelaUtil.Left   := 0;
              rTelaUtil.Top    := rRect.Bottom;
              rTelaUtil.Right  := rRect.Right;
              rTelaUtil.Bottom := Screen.Height;
            end
            else if (rRect.Left = 0) and
                    (rRect.Top = 0) and
                    (rRect.Right > 0) and
                    (rRect.Bottom = Screen.Height)
                 then begin
                   Result           := 'L';   // Left (Esquerda)
                   rTelaUtil.Left   := rRect.Right;
                   rTelaUtil.Top    := 0;
                   rTelaUtil.Right  := Screen.Width;
                   rTelaUtil.Bottom := rRect.Bottom;
                 end
                 else begin      // Não tem barra de tarefas
                   Result           := 'N';   // Left (Esquerda)
                   rTelaUtil.Left   := 0;
                   rTelaUtil.Top    := 0;
                   rTelaUtil.Right  := Screen.Width;
                   rTelaUtil.Bottom := Screen.Height;
                 end;
  // Largura e Altura disponiveis
  pLrg := rTelaUtil.Right - rTelaUtil.Left;   // Largura máxima
  pAlt := rTelaUtil.Bottom - rTelaUtil.Top;  // Altura máxima
  // rTelaUtil= contem os quatro pontos da tela útil e as coordenadas de EsquerdaTopo  e  DireitaBottom
  // rTelaUtil.Left  rTelaUtil.Top  rTelaUtil.Right  rTelaUtil.Bottom: Integer
  // rTelaUtil.TopLeft  rTelaUtil.BottomRight: TPoint (x,y)

end;



Function AjustaPathBarraFinal(pmtPath:String;pSN:Boolean): String;
// pSN = True (SIM), colocar a barra final se não existir
//     = False (NAO), sem barra final, tirar se existir
var iMax: Integer;
begin
  Result := Trim(pmtPath);
  iMax := Length(Result);
  if iMax < 1
     then Exit;
  if Result[iMax] <> '\'
  then begin
    if pSN
    then Result := Result + '\'
  end
  else begin
    if not pSN
    then Result := Copy(Result,1,iMax-1)
  end;

end;


Procedure AtivaBlocodeNotas(pmtArqTxt:String);
var Comando: String;
begin
  if not FileExists(pmtArqTxt)
  then MessageDlg('Arquivo [' + pmtArqtxt + '] não encontrado',mtError,[mbOk],0)
  else begin
    Comando := 'NotePad.EXE ' + pmtArqTxt;
    if WinExec(PAnsiChar(Comando), SW_SHOWDEFAULT) < 31 then MessageDlg('NotePad não encontrado',mtWarning, [mbOK], 0);
  end;

end;


Procedure EncadeamentoExecutavel(pmtExec,pmtParm:String; pmtForma:String='WinExec'; pmtShow:Integer=1);
// pmtShow=0:Hide 1:Normal 3:Maximize
var wExt,wCmd,wPrm,wDir: String;
begin
  wCmd := pmtExec;
  wExt := ExtractFileExt(pmtExec);
  if Length(Trim(wExt)) = 0
  then begin
    wExt := '.exe';
    wCmd := pmtExec + wExt;
  end;
  if AnsiUpperCase(wExt) <> '.EXE'
  then begin
    MessageDlg(pmtExec + ' não é um executável',mtError,[mbOk],0);
    Exit;
  end;
  if not FileExists(wCmd)
  then begin
    MessageDlg(wCmd + ' não encontrado',mtError,[mbOk],0);
    Exit;
  end;
  if AnsiUpperCase(pmtForma) = 'WINEXEC'
  then begin
    if Length(Trim(pmtParm)) > 0 then wCmd := wCmd + ' ' + pmtParm;
    WinExec(PAnsiChar(wCmd),SW_SHOWNORMAL);
  end
  else begin
    wPrm := pmtParm;
    wDir := ExtractFilePath(Application.ExeName);
    ShellExecute(0,'open',pChar(wCmd),pChar(wPrm),pChar(wDir),pmtShow);
  end;

end;


Function ValidaChaveNFe(pChave:String;pMsg:Boolean): Boolean;
var i,Peso,tKey,dErr,Soma,cDV: Integer;
    MsgErr1,MsgErr2: String;
const rTit: String = 'Validação de chave de NFe' + #13;
{  Formação da chave da NFe (44 digitos no total)
   (02 dígitos) *** Código do Estado (UF) do emitente - Código IBGE
   (04 dígitos) *** Ano e mês da emissão da NF-e (no formato AAMM)
   (14 dígitos) *** CNPJ do emitente da NF-e (CNPJ da sua Empresa)
   (02 dígitos) *** Modelo do NF-e
   (03 dígitos) *** Série do NF-e
   (09 dígitos) *** Número da NF-e
   (09 dígitos) *** Código da NF-e - Número gerado pelo sistema
   (01 dígitos) *** Dígito verificador - DV (Cálculo no módulo 11). }
begin
  MsgErr1 := '';
  MsgErr2 := '';
  tKey := Length(Trim(pChave));
  if tKey <> 44 then MsgErr1 := 'Tamanho da chave (' + IntToStr(tKey) + ') inválido, deve ter 44 dígitos' + #13;
  dErr := 0;
  for i := 1 to Length(Trim(pChave))
  do if (pChave[i] < '0') or (pChave[i] > '9')
     then begin
       dErr := dErr + 1;
       MsgErr2 := MsgErr2 + IntToStr(i) + '  ';
     end;
  if dErr > 0 then MsgErr2 := IntToStr(dErr) + ' caracteres inválidos, nas posições: ' + MsgErr2 + #13;
  if (Length(MsgErr1) > 0) or (Length(MsgErr2) > 0)
  then begin
    if pMsg then MessageDlg(rTit + MsgErr1 + MsgErr2,mtError,[mbOk],0);
    Result := False;
    Exit;
  end;

  Peso := 4;
  Soma := 0;
  for i := 1 to 43
  do begin
    Soma := Soma + StrToInt(pChave[i]) * Peso;
    Peso := Peso - 1;
    if Peso < 2 then Peso := 9;
  end;
  cDV := Soma mod 11;
  if cDV < 2 then cDV := 0
             else cDV := 11 - cDV;
  if cDV <> StrToInt(pChave[44])
  then begin
    Result := False;
    MessageDlg(rTit + 'DV da chave inválido' + #13 +
               'Informado: ' + pChave[44] + '   Calculado: ' + IntToStr(cDV),
               mtError,[mbOk],0);
  end
  else Result := True;

end;


Procedure Form_Salva(pmtForm:TForm);
var wArqForm,wSection,wInfo: String;
    wForm: TIniFile;
begin
  if (not FuFuncoes.lSalvaForm)
     or (not DirectoryExists(FuFuncoes.pathSalvaForm))
     then Exit;
  wArqForm     := AjustaPathBarraFinal(FuFuncoes.pathSalvaForm, True) + '_' + pmtForm.Name + '.fml';
  if FileExists(wArqForm) then DeleteFile(wArqForm);
  wForm        := TIniFile.Create(wArqForm);
  wSection     := pmtForm.Name;
  wInfo        := 'alNone';
  if (pmtForm.Align = alClient)
     or ((pmtForm.Top < 0) or (pmtForm.Left < 0))
     then wInfo := 'alClient';
  //
  wForm.WriteString(wSection, 'Align',  wInfo);
  wForm.WriteInteger(wSection,'Top',    pmtForm.Top);
  wForm.WriteInteger(wSection,'Left',   pmtForm.Left);
  wForm.WriteInteger(wSection,'Width',  pmtForm.Width);
  wForm.WriteInteger(wSection,'Height', pmtForm.Height);
  wForm.Free;

end;


Procedure Form_Define(pmtForm:TForm; pmtMax:Boolean=False);
var wArqForm,wSection,wInfo: String;
    wForm: TIniFile;
begin
  if pmtMax
  then begin    // Define janela na dimensão máxima
    pmtForm.Align  := alClient;
    Exit;
  end;
  //
  if (not FuFuncoes.lSalvaForm)
     or (not DirectoryExists(FuFuncoes.pathSalvaForm))
     then Exit;
  wArqForm := AjustaPathBarraFinal(FuFuncoes.pathSalvaForm,True) + '_' + pmtForm.Name + '.fml';
  if not FileExists(wArqForm) then Exit;
  wForm        := TIniFile.Create(wArqForm);
  wSection     := pmtForm.Name;
  wInfo        := wForm.ReadString(wSection, 'Align',  'alNone');
  pmtForm.Position := poDesigned;
  if wInfo = 'alClient'
  then pmtForm.Align := alClient
  else begin
    pmtForm.Align  := alNone;
    pmtForm.Top    := wForm.ReadInteger(wSection,'Top',    30);
    pmtForm.Left   := wForm.ReadInteger(wSection,'Left',   40);
    pmtForm.Width  := wForm.ReadInteger(wSection,'Width',  Screen.Width - 80);
    pmtForm.Height := wForm.ReadInteger(wSection,'Height', Screen.Height - 80);
  end;
  wForm.Free;

end;


Procedure Form_DefineOrig(pmtForm:TForm; pTop,pLeft,pHeight,pWidth:Integer);
var wArqForm,xPos: String;
    barAlt,barLrg: Integer;
    nLargMax,nAltMax: Integer;
begin
  wArqForm := AjustaPathBarraFinal(FuFuncoes.pathSalvaForm,True) + '_' + pmtForm.Name + '.fml';
  if FileExists(wArqForm) then DeleteFile(wArqForm);

  xPos  := ObtemConfiguracaoTela(barAlt,barLrg,nAltMax,nLargMax);   //xPos := 'B'ottom,'R'ight,'T'op,'L'eft,'N'one
  if pHeight > nAltMax
     then pHeight := nAltMax;
  if pWidth > nLargMax
     then pWidth  := nLargMax;
  pTop  := (nAltMax - pHeight) div 2;
  pLeft := (nLargMax - pWidth) div 2;
  if xPos = 'T'
     then pTop := pTop + barAlt;
  if xPos = 'L'
     then pLeft := pLeft + barLrg;
  pmtForm.Align    := alNone;
  pmtForm.Top      := pTop;
  pmtForm.Left     := pLeft;
  pmtForm.Height   := pHeight;
  pmtForm.Width    := pWidth;
  pmtForm.Position := poDesigned;

  if FuFuncoes.lSalvaForm
     and DirectoryExists(FuFuncoes.pathSalvaForm)
  then Form_Salva(pmtForm);

end;


Procedure Form_SimplesDefinicao(pmtForm:TForm; pHeight,pWidth:Integer);
var wTop,wLeft: Integer;
begin
  pmtForm.Align  := alNone;
  wTop   := (Screen.Height - (pHeight + 40)) div 2;
  wLeft  := (Screen.Width - pWidth) div 2;
  pmtForm.Top    := wTop;
  pmtForm.Left   := wLeft;
  pmtForm.Height := pHeight;
  pmtForm.Width  := pWidth;

end;

Procedure Form_DefineDimensaoMinima(pmtForm:TForm; pWidth,pHeight:Integer);
begin
  if pmtForm.Width < pWidth then pmtForm.Width := pWidth;
  if pmtForm.Height < pHeight then pmtForm.Height := pHeight;

end;


Procedure Form_Imprime(pmtForm:TForm; pmtStretch:Boolean);
var wBMP: TBitMap;
    x, y, WDPI, HDPI: Integer;
    OldColor: TColor;
begin
  Screen.Cursor   := crHourGlass;
  OldColor        := pmtForm.Color;
  pmtForm.Color   := clWhite;
  pmtForm.Update;
  wBMP := pmtForm.GetFormImage;
  with Printer do
  begin
    Orientation := poLandscape;
    BeginDoc;
      HDPI   := PageHeight div 8;
      WDPI   := PageWidth div 8;
      if pmtStretch
      then begin      // Dimensiona para o tamanho da pagina
        x := PageWidth - Round(WDPI * 0.4);        {0.4" margem direita}
        y := PageHeight - Round(HDPI * 0.5);       {0.5" Altura do rodapé}
      end
      else begin
        if pmtForm.Width < 500
        then begin
          x := pmtForm.Width * 3;
          y := pmtForm.Height * 3;
        end
        else if pmtForm.Width < 1000
             then begin
               x := pmtForm.Width * 2;
               y := pmtForm.Height * 2;
             end
             else begin
               x := pmtForm.Width;
               y := pmtForm.Height;
             end;
      end;
      Canvas.StretchDraw(Rect(0, 0, x, y), wBMP);
      // Canvas.Draw(10, 10, wBMP);
    EndDoc;
  end;
  wBMP.Free;
  pmtForm.Color := OldColor;
  Screen.Cursor := crDefault;

end;

Procedure Form_Centraliza(pmtForm:TForm; pHeight:Integer=0; pWidth:Integer=0);
var wArqForm: String;
    nLargMax,nAltMax: Integer;
    rTelaUtil: TRect;
    xPosBarra: String;
begin
  if ((pHeight = 0) and (pWidth = 0))
     and ((not FuFuncoes.lSalvaForm) or (not DirectoryExists(FuFuncoes.pathSalvaForm)))
  then Exit;
  xPosBarra := ObtemLimitesTela(rTelaUtil, nLargMax, nAltMax);       // := 'B'ottom,'R'ight,'T'op,'L'eft,'N'one
  wArqForm  := AjustaPathBarraFinal(FuFuncoes.pathSalvaForm,True) + '_' + pmtForm.Name + '.fml';
  if FileExists(wArqForm) then DeleteFile(wArqForm);
  //
  pmtForm.Align := alNone;
  if pHeight > 0
     then pmtForm.Height := pHeight
     else pmtForm.Height := nAltMax;
  if pmtForm.Height > nAltMax
     then pmtForm.Height := nAltMax;
  if pWidth > 0
     then pmtForm.Width  := pWidth
     else pmtForm.Width  := nLargMax;
  if pmtForm.Width >= nLargMax
     then pmtForm.Width  := nLargMax;
  //
  pmtForm.Left  := rTelaUtil.Left + ((nLargMax - pmtForm.Width)  div 2);
  pmtForm.Top   := rTelaUtil.Top  + ((nAltMax  - pmtForm.Height) div 2);

end;


Procedure GravaLog(pLogFile:String; pOper:Integer; pUserApp,pUserSys,pInfo:String);
{
  pLogFile --> Nome completo do arquivo log
  pOper    --> 1-Inclusão, 2-Alteração, 3-Exclusão, 4-Cancelamento, 5-Outro
  pUserApp --> User do aplicativo
  pUserSys --> Usuario windows
  pInfo    --> Conteudo do log
}
var txtLog: TextFile;
    naL: Integer;
    linLog: String;
const xOper: array[1..5] of string = ('Inc','Alt','Exc','Can','<*>');
begin
  if FileExists(pLogFile)
  then naL := 0
  else begin
    naL := FileCreate(pLogFile);
    FileClose(naL);
  end;
  if naL < 0
  then begin
    MessageDlg('Não foi possível criar arquivo log' + #13
               + '[' + pLogFile + ']'
               ,mtWarning,[mbOk],0);
    Exit;
  end;
  if (pOper < 1) or (pOper > 4) then pOper := 5;
  linLog := '|' + xOper[pOper] + '|' +
            DateToStr(Date) + '-' + TimeToStr(Time) + '|' +
            Trim(pUserApp) + '|' +
            Trim(pUserSys) + '|' +
            Trim(pInfo) + '|';
  AssignFile(txtLog,pLogFile);
  Append(txtLog);
  WriteLn(txtLog,linLog);
  Close(txtLog);

end;


Function StringCompleta(pDado:String;pEDC,pCar:Char;pTam:Integer;pCorta:Boolean = True):String;
{
   Completa um string, com o tamanho informado
   pDado:   String a ser completado
   pEDC:    Esquerda, Direita ou Centrado
   pCar:    Caracter a ser usado para preencher
   pTam:    Tamanho a ser retornado
   Retorna um String
}
var wMd: String;
    wCentra: Boolean;
begin
  wMd := AnsiUpperCase(pEDC);
  wCentra := False;
  if wMd = 'C' then wCentra := True;
  Result := Trim(pDado);
  if Length(pCar) = 0
     then pCar := ' ';
  while Length(Result) < pTam
  do begin
    if wCentra
    then if wMd = 'E' then wMd := 'D'
                      else wMd := 'E';
    if wMd = 'E' then Result := pCar + Result
                 else Result := Result + pCar;
  end;
  if (Length(Result) > pTam) and pCorta
     then Result := Copy(Result,1,pTam);

end;

Function StringFiller(pCar:Char;pTam:Integer): String;
var i: Integer;
begin
  Result := '';
  if Length(pCar) = 0
     then pCar := ' ';
  for i := 1 to pTam
  do Result := Result + pCar;

end;


Function StringFillString(pCar:String;pTam:Integer): String;
var i: Integer;
begin
  Result := '';
  if Length(pCar) = 0
     then pCar := ' ';
  for i := 1 to pTam
  do Result := Result + pCar;

end;


Function StringValor(pArgum:String): Real;
var origSep,dSepar: Char;
begin
  Result  := 0;
  OrigSep := FormatSettings.DecimalSeparator;
  if OrigSep = ','
     then dSepar := '.'
     else dSepar := ',';
  Try
    Result := StrToFloat(pArgum);
  Except
    FormatSettings.DecimalSeparator := dSepar;
    Try
      Result := StrToFloat(pArgum);
    Except
    End;
    FormatSettings.DecimalSeparator := OrigSep;
  End;

end;

Function TextoRetiraAcentuacao(pInfo:String;pMaiusc:Boolean = True):String;
// pInfo: String a ser tratado
// pMaiusc:  True: Converte para maiúsculo    False: NÃO converte para maiúsculo
// Retorna o texto tratado
var wDado: String;
    i,j: Integer;
    troca,para: Boolean;
const xCompara: array[1..14] of string =
               ('ÁÀÄÂÃ','ÉÈËÊ','ÍÌÏÎ','ÓÒÖÔÕ','ÚÙÜÛ','Ç','Ñ',
                'áàäâã','éèëê','íìïî','óòöôõ','úùüû','ç','ñ');
      newChar: array[1..14] of char =
               ('A','E','I','O','U','C','N','a','e','i','o','u','c','n');
begin
  wDado := Trim(pInfo);
  if pMaiusc then wDado := AnsiUpperCase(wDado);
  // #32->'b'   #33->!    #35->#    #36->$    #37->%    #38->&
  // #40 a #95 -> ()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_
  // #97 a #119 -> abcdefghijklmnopqrstuvwxyz
  for i := 1 to Length(wDado)
  do begin
    if (wDado[i] < #32)          // anterior a 'branco'
       or (wDado[i] = #34)       // "
       or (wDado[i] = #39)       // '
       or (wDado[i] = #96)       // `
       or (wDado[i] = #120)      //
    then wDado[i] := ' ';
    if wDado[i] > #121
    then begin
      troca := False;
      para := False;
      j := 1;
      while not para
      do begin
        if Pos(wDado[i],xCompara[j]) > 0
        then begin
          wDado[i] := newChar[j];
          para := True;
          troca := True;
        end;
        j := j + 1;
        if j > 14 then para := True;
      end;
      if not troca then wDado[i] := ' ';
    end;
  end;
  Result := wDado;

end;


Function  RetiraCRLF(pInfo:String; pMaiusc:Boolean=True; pNewChr:Char=#32): String;
var i: Integer;
begin
  if pMaiusc then pInfo := AnsiUpperCase(pInfo);
  for i := 1 to Length(pInfo)
  do if (pInfo[i] = #13) or (pInfo[i] = #10)
     then pInfo[i] := pNewChr;
  Result := pInfo;

end;


Function DefineMascaraJurFis(pJF:String;pChr:String = '0'): String;
begin
  Result := '';
  if pChr = '0'
  then begin
    if AnsiUpperCase(pJF) = 'J'
    then Result := '00\.000\.000/0000-00;0; '
    else if AnsiUpperCase(pJF) = 'F'
         then Result := '000\.000\.000-00;0; ';
  end
  else begin
    if AnsiUpperCase(pJF) = 'J'
    then Result := '99\.999\.999/9999-99;0; '
    else if AnsiUpperCase(pJF) = 'F'
         then Result := '999\.999\.999-99;0; ';
  end;

end;


Function DataJuliana(pmtData:TDateTime;pmtModo:Integer):Integer;
{
  Retorna o nr. de dias, cfe pmtModo
  pmtModo = 0 -> Dias no ano  (ex. dia 35 do ano)
          = 1 -> Dias corridos desde 01/01/0000
}
var wAno,wMes,wDia: Word;
    i: Integer;
begin
  DecodeDate(pmtData,wAno,wMes,wDia);
  Result := wDia;                                                // Considera os dias do mes
  for i := 1 to wMes-1 do Result := Result + DiasMes[i];         // Soma os dias transcorridos de cada mes anterior ao atual
  if (wMes > 2) and IsLeapYear(wAno) then Result := Result + 1;  // Se mes > 02 e ano bissexto, soma 1 dia
  if (pmtModo > 0) and (wAno > 0)
  then Result := Result + Trunc((wAno-1) * 365.25);              // Se modo>0, soma os dias decorridos até o ano anterior

end;


Function DataExtenso(pmtData:TDateTime;pmtExt:Boolean):String;
var wAno,wMes,wDia: Word;
begin
  DecodeDate(pmtData,wAno,wMes,wDia);
  Result := IntToStr(wDia) + ' de ';
  if pmtExt then Result := Result + FormatSettings.LongMonthNames[wMes]
            else Result := Result + FormatSettings.ShortMonthNames[wMes];
  Result := Result + ' de ' + IntToStr(wAno);

end;


Function SemanaDoAno(pmtData:TDateTime):Integer;
// Retorna a semana do ano, que corresponde à data informada
var wAno,wMes,wDia: Word;
    wSIni: Integer;
begin
  DecodeDate(pmtData,wAno,wMes,wDia);
  wSIni := 0;
  if DayOfWeek(EncodeDate(wAno,1,1)) <= 4 then wSIni := 1;
  Result := (DayOfTheYear(pmtData) div 7) + wSIni;
  if Result > 52 then Result := 52;

end;


Function ValidaHorario(pHora:String):Boolean;
var Hr,Mn,Sg: Integer;
begin
  pHora := Trim(pHora);
  while Length(pHora) < 4
    do pHora := '0' + pHora;
  Hr := StrToIntDef(Copy(pHora,1,2),-1);
  Mn := 0;
  Sg := 0;
  case Length(Trim(pHora)) of
    4:Mn := StrToIntDef(Copy(phora,3,2),-1);
    5:Mn := StrToIntDef(Copy(phora,4,2),-1);
    6:begin
        Mn := StrToIntDef(Copy(phora,3,2),-1);
        Sg := StrToIntDef(Copy(phora,5,2),-1);
      end;
    8:begin
        Mn := StrToIntDef(Copy(phora,4,2),0);
        Sg := StrToIntDef(Copy(phora,6,2),0);
      end;
    else Hr := -1;

  end;

  if (Hr < 0) or (Hr > 24)
     or (Mn < 0) or (Mn > 59)
     or (Sg < 0) or (Sg > 59)
  then Result := False
  else Result := True;

end;


Function  MesesEntreDatas(pDtIni,pDtFin:TDateTime; var rMeses:Integer; var rDias:Integer): Integer;
var qtDias,iMes: Integer;
begin
  qtDias := DaysBetween(DateOf(pDtIni),DateOf(pDtFin)) * 100;    // dias entre datas (*100)
  iMes   := qtDias div 3043;                                     // meses
  rMeses := iMes;
  qtDias := qtDias - (iMes * 3043);
  rDias  := qtDias div 100;
  Result := iMes;
  if rDias > 15 then Result := iMes + 1;

end;


Procedure MesAnterior(var pDtIni: TDateTime; var pDtFin: TDateTime);
var AA,MM,DD: Word;
begin
  DecodeDate(pDtIni,AA,MM,DD);
  MM := MM - 1;
  if MM < 1
  then begin
    MM := 12;
    AA := AA - 1;
  end;
  pDtIni := EncodeDate(AA,MM,1);
  pDtFin := EncodeDate(AA,MM,DaysInMonth(pDtIni));

end;


Procedure MesCorrente(var pDtIni: TDateTime; var pDtFin: TDateTime; lDiaMax:Boolean = False);
var AA,MM,DD,DiaMax: Word;
begin
  DecodeDate(Date,AA,MM,DD);
  pDtIni := EncodeDate(AA,MM,1);
  DiaMax := DaysInMonth(pDtIni);
  if lDiaMAx
  then if DiaMax > DD
       then DiaMax := DD;
  pDtFin := EncodeDate(AA,MM,DiaMax);

end;


Procedure MesSeguinte(var pDtIni: TDateTime; var pDtFin: TDateTime; lDiaMax:Boolean = False);
var AA,MM,DD,DiaMax: Word;
    wDtAux: TDateTime;
begin
  DecodeDate(pDtIni,AA,MM,DD);
  MM := MM + 1;
  if MM > 12
  then begin
    MM := 1;
    AA := AA + 1;
  end;
  wDtAux := EncodeDate(AA,MM,1);
  if lDiaMax
  then if DateOf(wDtAux) > DateOf(Date)
       then Exit;
  //
  pDtIni := wDtAux;
  DiaMax := DaysInMonth(pDtIni);
  pDtFin := EncodeDate(AA,MM,DiaMax);
  if lDiaMAx
  then if DateOf(pDtFin) > DateOf(Date)
       then pDtFin := DateOf(Date);

end;


Function MesProximoAnterior(pDtWrk: TDateTime; pMes:String = '+'): TDateTime;
var AA,MM,DD,DiaMax: Word;
    wDtAux: TDateTime;
begin
  DecodeDate(pDtWrk,AA,MM,DD);
  if pMes = '+'
  then begin
    MM := MM + 1;
    if MM > 12
    then begin
      MM := 1;
      AA := AA + 1;
    end;
  end
  else begin
    MM := MM - 1;
    if MM < 1
    then begin
      MM := 12;
      AA := AA -1;
    end;
  end;
  DiaMax := DaysInMonth(EncodeDate(AA,MM,1));
  if DD > DiaMax
     then DD := DiaMax;
  Result := EncodeDate(AA,MM,DD);

end;


Function AnoProximoAnterior(pDtWrk: TDateTime; pAno:String = '+'): TDateTime;
var AA,MM,DD,DiaMax: Word;
    wDtAux: TDateTime;
begin
  DecodeDate(pDtWrk,AA,MM,DD);
  if pAno = '+'
     then AA := AA + 1
     else AA := AA -1;
  DiaMax := DaysInMonth(EncodeDate(AA,MM,1));
  if DD > DiaMax
     then DD := DiaMax;
  Result := EncodeDate(AA,MM,DD);

end;


Function  DataString(pData: TDateTime; pTam: Integer = 8): String;  // pTam=8 ou 6   (aaAAMMDD)
var wAno,wMes,wDia: Word;
    xAno,xMes,xDia: String;
begin
  DecodeDate(pData,wAno,wMes,wDia);
  xAno  := IntToStr(wAno);
  if wMes < 10
     then xMes := '0' + IntToStr(wMes)
     else xMes := IntToStr(wMes);
  if wDia < 10
     then xDia := '0' + IntToStr(wDia)
     else xDia := IntToStr(wDia);
  if pTam = 8
     then Result := xAno
     else Result := Copy(xAno,3,2);
  Result := Result + xMes + xDia;

end;


Function  StringData_DMA(pDtAMD: String; pEdit:Boolean = True): String;    // aaAAMMDD --> DD/MM/AAaa
var xSep: String;
begin
  if pEdit then xSep := '/'
           else xSep := '';
  if Length(pDtAMD) = 6
  then Result := Copy(pDtAMD,5,2) + xSep + Copy(pDtAMD,3,2) + xSep + Copy(pDtAMD,1,2)
  else if Length(pDtAMD) = 8
       then Result := Copy(pDtAMD,7,2) + xSep + Copy(pDtAMD,5,2) + xSep + Copy(pDtAMD,1,4)
       else Result := 'dd' + xSep + 'mm' + xSep + 'aaaa';

end;


Function  DataHoraString(pDataHora: TDateTime; pTamAno:Integer=2; pForma:Integer=0): String;
var wAno,wMes,wDia,wHor,wMin,wSeg,wMSe: Word;
    xAno,xMes,xDia,xHor,xMin,xSeg,xMSe: String;
begin
  DecodeDateTime(pDataHora,wAno,wMes,wDia,wHor,wMin,wSeg,wMSe);
  if wMes < 10
     then xMes := '0' + IntToStr(wMes)
     else xMes := IntToStr(wMes);
  if wDia < 10
     then xDia := '0' + IntToStr(wDia)
     else xDia := IntToStr(wDia);
  xAno  := IntToStr(wAno);
  if pTamAno = 2
     then xAno := Copy(xAno,3,2);
  if wHor < 10
     then xHor := '0' + IntToStr(wHor)
     else xHor := IntToStr(wHor);
  if wMin < 10
     then xMin := '0' + IntToStr(wMin)
     else xMin := IntToStr(wMin);
  if wSeg < 10
     then xSeg := '0' + IntToStr(wSeg)
     else xSeg := IntToStr(wSeg);
  xMSe := IntToStr(wMSe);
  while Length(xMSe) < 3
    do xMSe := '0' + xMSe;
  case pForma of
    1:Result := xDia + '/' + xMes + '/' + xAno + ' ' + xHor + ':' + xMin + ':' + xSeg;                // 17 ou 19 DD/MM/AA(AA) Hr:Mi:Se
    2:Result := xDia + '/' + xMes + '/' + xAno + ' ' + xHor + ':' + xMin + ':' + xSeg + ':' + xMSe;   // 21 ou 23 DD/MM/AA(AA) Hr:Mi:Se:MSe
    3:Result := xAno + xMes + xDia + '_' + xHor + xMin + xSeg + xMSe;                                 // 16 ou 18 AA(AA)MMDD_HrMiSeMSe
    else Result := xAno + xMes + xDia + '_' + xHor + xMin + xSeg + xMSe;                              // 13 ou 15 AA(AA)MMDD_HrMiSe(Default)
  end;

end;


Function  HoraInteger(pHora:TDateTime): Integer;
var Hr,Mi,Se,Ms: Word;
begin
  DecodeTime(pHora,Hr,Mi,Se,Ms);
  Result := (((Hr*3600) + (Mi*60) + Se) * 1000) + Ms;

end;


Function  IntegerHora(pHrInt:Integer): TDateTime;
var Auxil: Integer;
    Hr,Mi,Se,Ms: Word;
begin
  Auxil := pHrInt;
  Ms    := Auxil Mod 10000;
  Auxil := (Auxil - Ms) div 1000;
  Hr    := Auxil div 3600;
  Auxil := Auxil - (Hr * 3600);
  Mi    := Auxil div 60;
  Se    := Auxil - (Mi * 60);
  Result := EncodeTime(Hr,Mi,Se,Ms);

end;


Function  DataHoraInteger(pDtHr:TDateTime): Integer;
var wAA,wMM,wDD,wHr,wMn,wSe,wMS: Word;
begin
  DecodeDateTime(pDtHr,wAA,wMM,wDd,wHr,wMn,wSe,wMS);
  Result := (Trunc(pDtHr) * 86400) +    // Nro de dias da data X 86400 (24hr X 3600s)
            (wHr * 3600) +                  // Horas em segundos
            (wMn * 60) +                    // Minutos em segundos
            wSe;                            // Segundos

end;


Function  IntegerDataHora(pDtHr:Integer): TDateTime;
begin
  Result := pDtHr / 86400;

end;


Function  IntegerHoraStr(pHrInt:Integer): String;
var Auxil: Integer;
    Hr,Mi,Se,Ms: Word;
    xHr,xMi,xSe,xMs: String;
begin
  Auxil := pHrInt;
  Ms    := Auxil Mod 1000;
  Auxil := (Auxil - Ms) div 1000;
  Hr    := Auxil div 3600;
  Auxil := Auxil - (Hr * 3600);
  Mi    := Auxil div 60;
  Se    := Auxil - (Mi * 60);
  xHr   := IntToStr(Hr);
  if Hr < 10 then xHr := '0' + xHr;
  xMi   := IntToStr(Mi);
  if Mi < 10 then xMi := '0' + xMi;
  xSe   := IntToStr(Se);
  if Se < 10 then xSe := '0' + xSe;
  xMs   := IntToStr(Ms);
  if Ms < 10 then xMs := '0' + xMs;
  if Ms < 100 then xMs := '0' + xMs;
  Result := xHr + ':' + xMi + ':' + xSe + ':' + xMs;

end;

Function  SegundosEmDias(pSeg:Integer;var rDd:Integer; var rHr:Integer; var rMi:Integer; var rSe:Integer): String;
var nSegs: Integer;
begin
  Result := '';
  nSegs  := pSeg;
  rDd    := nSegs div 86400;      // Dias      86400 segundos = 1 dia
  nSegs  := nSegs mod 86400;      // Horas restantes
  rHr    := nSegs div 3600;       // Horas     3600 segundos = 1 hora
  nSegs  := nSegs mod 3600;       // Minutos restantes
  rMi    := nSegs div 60;         // Minutos   60 segundos = 1 minuto
  rSe    := nSegs mod 60;         // Segundos
  if rDd > 0
     then Result := Result + IntToStr(rDd) + ' Dd ';
  if rHr > 0
     then Result := Result + IntToStr(rHr) + ' Hr ';
  if rMi > 0
     then Result := Result + IntToStr(rMi) + ' Min ';
  if rSe > 0
     then Result := Result + IntToStr(rSe) + ' Seg ';


end;


Procedure DefineMes(pModo:Integer; var dtIni:TDateTime; var dtFim:TDateTime);
begin
  if pModo = 0
    then DecodeDate(Date,AA,MM,DD)        // Decodifica data atual
    else DecodeDate(dtIni,AA,MM,DD);      // Decodifica data inicial informada
  //
  if pModo < 0
  then begin       // Mes anterior
    MM := MM - 1;
    if MM = 0
    then begin
      MM := 12;
      AA := AA - 1;
    end;
  end
  else if pModo > 0
       then begin      // Próximo mes
         MM := MM + 1;
         if MM > 12
         then begin
           MM := 1;
           AA := AA + 1;
         end;
       end;
  dtIni := EncodeDate(AA,MM,1);
  dtFim := EncodeDate(AA,MM,DaysInMonth(dtIni));

end;


Procedure DefineMesDP(pModo:Integer; var dtIni:TDateTimePicker; var dtFim:TDateTimePicker);
begin
  if pModo = 0
    then DecodeDate(Date,AA,MM,DD)        // Decodifica data atual
    else DecodeDate(dtIni.Date,AA,MM,DD);      // Decodifica data inicial informada
  //
  if pModo < 0
  then begin       // Mes anterior
    MM := MM - 1;
    if MM = 0
    then begin
      MM := 12;
      AA := AA - 1;
    end;
  end
  else if pModo > 0
       then begin      // Próximo mes
         MM := MM + 1;
         if MM > 12
         then begin
           MM := 1;
           AA := AA + 1;
         end;
       end;
  dtIni.Date := EncodeDate(AA,MM,1);
  dtFim.Date := EncodeDate(AA,MM,DaysInMonth(dtIni.Date));

end;


Function  EditaValorTexto(pTexto:String; pTam,pDec:Integer): String;
var wVlr: Real;
begin
  wVlr   := StrToFloatDef(pTexto,0);
  Result := FloatToStrF(wVlr,ffNumber,pTam,pDec);

end;



Function ValidaCNPJ(pCNPJ:String):Boolean;
{
  Validação de CNPJ
  pCNPJ com 14 digitos (sem edição) ou com 18 caracteres (com edição)
  Retorna True se Ok, False em caso de erro
}
var i,wSoma,wRest,wD1,wD2: integer;
    wCgc: String;
    wDg: array[1..14] of integer;
begin
  if Length(Trim(pCNPJ)) = 0
  then begin
    Result := True;
    Exit;
  end;
  Result := False;
  if (Length(Trim(pCNPJ)) <> 14) and (Length(Trim(pCNPJ)) <> 18) then Exit;
  if Length(Trim(pCNPJ)) = 14
    then wCgc := pCNPJ            // Sem edição
    else wCgc := Copy(pCNPJ,1,2)+Copy(pCNPJ,4,3)+Copy(pCNPJ,8,3)+Copy(pCNPJ,12,4)+Copy(pCNPJ,17,2);  // Com edição
  for i := 1 to 14 do wDg[i] := StrToIntDef(wCgc[i],0);
  wSoma := wDg[1]*5 + wDg[2]*4 + wDg[3]*3 + wDg[4]*2 + wDg[5]*9 + wDg[6]*8 +
           wDg[7]*7 + wDg[8]*6 + wDg[9]*5 + wDg[10]*4 + wDg[11]*3 + wDg[12]*2;
  wRest := wSoma mod 11;
  if wRest > 1 then wD1 := 11 - wRest
               else wD1 := 0;
  wSoma:= wDg[1]*6 + wDg[2]*5 + wDg[3]*4 + wDg[4]*3 + wDg[5]*2 + wDg[6]*9 +
          wDg[7]*8 + wDg[8]*7 + wDg[9]*6 + wDg[10]*5 + wDg[11]*4 + wDg[12]*3 + wD1*2;
  wRest := wSoma mod 11;
  if wRest > 1 then wD2 := 11 - wRest
               else wD2 := 0;
  if (wD1 = wDg[13]) and (wD2 = wDg[14]) then Result := True;

end;


Function ValidaCPF(pCPF:String):Boolean;
{
  Validação de CPF
  pCNPJ com 11 digitos (sem edição) ou com 14 caracteres (com edição)
  Retorna True se Ok, False em caso de erro
}
var i,wSoma,wRest,wD1,wD2: integer;
    wCic: String;
    wDg: array[1..11] of integer;
begin
  if Length(Trim(pCPF)) = 0
  then begin
    Result := True;
    Exit;
  end;
  Result := False;
  if (Length(Trim(pCPF)) <> 11) and (Length(Trim(pCPF)) <> 14) then Exit;
  if Length(Trim(pCPF)) = 11
    then wCic := pCPF                         // Sem edição
    else wCic := Copy(pCPF,1,3)+Copy(pCPF,5,3)+Copy(pCPF,9,3)+Copy(pCPF,13,2);  // Com edição
  for i := 1 to 11 do wDg[i] := StrToIntDef(wCic[i],0);
  wSoma := wDg[1]*10 + wDg[2]*9 + wDg[3]*8 + wDg[4]*7 + wDg[5]*6 +
           wDg[6]*5 + wDg[7]*4 + wDg[8]*3 + wDg[9]*2;
  wRest := wSoma mod 11;
  if wRest > 1 then wD1 := 11 - wRest
               else wD1 := 0;
  wSoma := wDg[1]*11 + wDg[2]*10 + wDg[3]*9 + wDg[4]*8 + wDg[5]*7 +
           wDg[6]*6 + wDg[7]*5 + wDg[8]*4 + wDg[9]*3 + wD1*2;
  wRest := wSoma mod 11;
  if wRest > 1 then wD2 := 11 - wRest
               else wD2 := 0;
  if (wD1 = wDg[10]) and (wD2 = wDg[11]) then Result := True;

end;

//  Validação de CNPJ ou CPF, cfe. pTpess (J ou F)
Function ValidaCNPJ_CPF(pInfo:String; pTpess:String='';lSeq:Boolean=False): Boolean;
var xCNPJCPF,xNros: String;
    nP,i: Integer;
const xNr09: String = '01234567890123456789';
      xNr90: String = '98765432109876543210';
begin
  Result := True;
  if (Length(Trim(pTpess)) = 0)
     and (Length(Trim(pInfo)) = 0)
     then Exit;
  //
  xCNPJCPF := Numerico(pInfo);
  if Length(Trim(pTpess)) = 0
  then if Length(Trim(xCNPJCPF)) > 11
       then pTpess := 'J'
       else pTpess := 'F';
  //
  if AnsiUpperCase(pTpess) = 'J'
  then Result := ValidaCNPJ(xCNPJCPF)
  else if AnsiUpperCase(pTpess) = 'F'
       then Result := ValidaCPF(xCNPJCPF)
       else Result := False;
  //
  if lSeq
  then begin
    nP := 0;
    for i := 0 to 9
    do begin
      xNros := StringFillString(IntToStr(i), 6);            // 000000 111111 222222 ....
      nP    := nP + Pos(xNros,xCNPJCPF);
      xNros := Copy(xNr09,i+1,6);                           // 012345 123456 234567 ....
      nP    := nP + Pos(xNros,xCNPJCPF);
      xNros := Copy(xNr90,i+1,6);                           // 987654 876543 765432 ....
      nP    := nP + Pos(xNros,xCNPJCPF);
    end;
    if nP > 0
       then Result := False;
  end;

end;

//  Validação de CNPJ ou CPF, cfe. pTpess (J ou F), e não permite repetição de digitos ('nnnnnn')
Function ValidaCNPJCPF_Ext(pInfo:String;pTpess:String=''): Boolean;
var xCNPJCPF: String;
    i,cta: Integer;
begin
  Result := True;
  if (Length(Trim(pTpess)) = 0)
     and (Length(Trim(pInfo)) = 0)
     then Exit;
  //
  xCNPJCPF := Numerico(pInfo);
  if Length(Trim(pTpess)) = 0
  then if Length(Trim(xCNPJCPF)) > 11
       then pTpess := 'J'
       else pTpess := 'F';
  //
  if AnsiUpperCase(pTpess) = 'J'
  then Result := ValidaCNPJ(xCNPJCPF)
  else if AnsiUpperCase(pTpess) = 'F'
       then Result := ValidaCPF(xCNPJCPF)
       else Result := False;
  //
  cta   := 1;
  for i := 2 to 6
  do if Copy(xCNPJCPF,1,1) = Copy(xCNPJCPF,i,1)
     then cta := cta + 1;
  if cta = 6
     then Result := False;

end;


Function ValidaPIS(pPIS:String):Boolean;
{
  Validação de PIS, sempre com 11 digitos (sem edição)
  Retorna True se Ok, False em caso de erro
}
var i,wSoma,wDv: Integer;
    wDg: array[1..11] of Integer;
begin
  if Length(Trim(pPIS)) = 0
  then begin
    Result := True;
    Exit;
  end;
  Result := False;
  if Length(Trim(pPIS)) <> 11 then Exit;
  for i := 1 to 11 do wDg[i] := StrToIntDef(pPIS[i],0);
  wSoma := wDg[1]*3 + wDg[2]*2 + wDg[3]*9 + wDg[4]*8 + wDg[5]*7 +
           wDg[6]*6 + wDg[7]*5 + wDg[8]*4 + wDg[9]*3 + wDg[10]*2;
  wDv := 11 - (wSoma mod 11);
  if wDv > 9 then wDv := 0;
  if WDv <> wDg[11] then Result := False;

end;


Function ValidaCartaoCredito(pNrCart:String):Boolean;
//  Validação de nro. de Cartão de Crédito, sempre com 16 digitos (sem edição)
//   Retorna True se Ok, False em caso de erro
var wSoma,wFat,wVal,wDv,i: Integer;
    wDg: array[1..16] of Integer;
begin
  if Length(Trim(pNrCart)) = 0
  then begin
    Result := True;
    Exit;
  end;
  Result := False;
  if Length(Trim(pNrCart)) <> 16 then Exit;
  for i := 1 to 16 do wDg[i] := StrToIntDef(pNrCart[i],0);
  wSoma := 0;
  wFat := 2;
  for i := 1 to 15
  do begin
    wVal := wDg[i] * wFat;
    wSoma := wSoma + (wVal div 10) + (wVal mod 10);
    if wFat = 2 then wFat := 1
                else wFat := 2;
  end;
  wDv := (10-(wSoma mod 10)) mod 10;
  if wDv = wDg[16] then Result := True;

end;


Function EditaCNPJ_CPF(pDado:String;pTipo:String = 'X'):String;
{ Edita CPNJ ou CPF
     pDado: CNPJ ou CPF
     pTipo: 'J'urídica (CNPJ), 'F'isica (CPF), ou <> define pelo tamanho da string    }
begin
  Result := 'Inválido';
  pTipo := AnsiUpperCase(pTipo);
  if (pTipo <> 'J') and (pTipo <> 'F')
     then if Length(Trim(pDado)) <= 11
             then pTipo := 'F'
             else pTipo := 'J';
  while Length(pDado) < 14
     do pDado := '0' + pDado;
  if AnsiUpperCase(pTipo) = 'F'
     then Result := Copy(pDado,4,3) + '.' + Copy(pDado,7,3) + '.' +
                    Copy(pDado,10,3) + '-' + Copy(pDado,13,2)
     else Result := Copy(pDado,1,2) + '.' + Copy(pDado,3,3) + '.' +
                    Copy(pDado,6,3) + '/' + Copy(pDado,9,4) + '-' +
                    Copy(pDado,13,2);

end;

Function EditaCEP(pDado:String):String;
begin
  while Length(Trim(pDado)) < 8 do pDado := '0' + pDado;
  Result := Copy(pDado,1,2) + '.' + Copy(pDado,3,3) + '-' + Copy(pDado,6,3);

end;


Function ValidaSiglaUFCaracteresTamanho(var pInscricao:String; pSigla:String; var pIndUF:Integer): Boolean;
var valStr,wAuxil: String;
    i,tm1,tm2: Integer;
begin
  Result := False;
  tm1    := 0;
  tm2    := 0;
  pIndUF := 0;
  for i  := 1 to 27
  do if pSigla = xSiglas[i,1]
     then begin
       pIndUF := i;
       valStr := '0123456789' + xSiglas[i,4];
       tm1    := StrToInt(xSiglas[i,2]);
       tm2    := StrToInt(xSiglas[i,3]);
       Break;
     end;
  if pIndUF = 0
  then begin
    wMensagem := wMensagem + 'Sigla UF inválida: ' + pSigla + #13;
    Exit;
  end;
  wAuxil := '';
  for i  := 1 to Length(pInscricao)
  do if Pos(pInscricao[i],valStr) > 0
     then wAuxil := wAuxil + pInscricao[i];
  if (Length(wAuxil) <> tm1) and (Length(wAuxil) <> tm2)
  then begin
    wMensagem := wMensagem + 'Tamanho inválido, informado: ' + IntToStr(Length(wAuxil)) + '   exigido: ' + IntToStr(tm1);
    if tm2 <> tm1
       then wMensagem := wMensagem + ' ou ' + IntToStr(tm2);
    wMensagem := wMensagem + '   UF: ' + pSigla + #13;
    Exit;
  end;
  pInscricao := wAuxil;
  Result     := True;
  
end;


Function IE_CalcDV11(pInfo:String; peso:Integer; pMax:Integer = 9): String;
//  pInfo:  sequencia informada
//  peso:   valor do 1º peso
//  pMax:   peso máximo, default é 9
var nSoma,dv,i: Integer;
begin
  nSoma := 0;
  for i := 1 to Length(pInfo)
  do begin
    nSoma := nSoma + (StrToInt(pInfo[i]) * peso);
    peso  := peso - 1;
    if peso = 1
       then peso := pMax;
  end;
  dv := 11 - (nSoma mod 11);
  if (dv = 10) or (dv = 11)
    then dv := 0;
  Result := IntToStr(dv);

end;


Function IE_CalcDV10(pInfo:String; peso:Integer; pMax:Integer = 9): String;
//  pInfo:  sequencia informada
//  peso:   valor do 1º peso
//  pMax:   peso máximo, default é 9
var nSoma,dv,i: Integer;
begin
  nSoma := 0;
  for i := 1 to Length(pInfo)
  do begin
    nSoma := nSoma + (StrToInt(pInfo[i]) * peso);
    peso  := peso - 1;
    if peso = 1
       then peso := pMax;
  end;
  dv := 10 - (nSoma mod 10);
  if dv = 10
    then dv := 0;
  Result := IntToStr(dv);
end;


Function IE_CalcDVXX(pInfo:String; pPeso:Integer):String;
//  pInfo:  sequencia informada
//  pPeso:  peso inicial (1 ou 2)
//  Calcula DV alternando "peso" entre 1 e 2
var xVal: String;
    i,nSoma,Dg: Integer;
begin
  xVal   := '';
  for i := 1 to Length(pInfo)
  do begin
    xVal  := xVal + IntToStr(StrToInt(pInfo[i])*pPeso);
    pPeso := pPeso + 1;
    if pPeso > 2
       then pPeso := 1;
  end;
  nSoma := 0;
  for i := 1 to Length(xVal)
  do nSoma := nSoma + StrToInt(xVal[i]);
  dg := (((nSoma div 10) + 1) * 10) - nSoma;
  if dg = 10
     then dg := 0;
  Result := IntToStr(dg);
end;
//
Function IE_AC(pInscricao:String): String;       // 01 - Acre
begin
  Result := '';
  if Copy(pInscricao,1,2) <> '01'
  then begin
    wMensagem := wMensagem + '2 dig iniciais:' + Copy(pInscricao,1,2) + '  exigido:01' + #13;
    Exit;
  end;
  wIE    := Copy(pInscricao,1,11);
  wDV    := IE_CalcDV11(wIE, 4);                 // 1.digito
  wIE    := wIE + wDV;
  wDV    := IE_CalcDV11(wIE, 5);                 // 2.digito
  Result := wIE + wDV;
end;


Function IE_AL(pInscricao:String): String;       // 02 - Alagoas
var d3: String;
begin
  Result := '';
  if Copy(pInscricao,1,2) <> '24'
  then begin
    wMensagem := wMensagem + '2 dig iniciais:' + Copy(pInscricao,1,2) + '  exigido:24' + #13;
    Exit;
  end;
  d3  := Copy(pInscricao,3,1);
  if Pos(d3,'03578') = 0
  then begin
    wMensagem := wMensagem + '3º dig:' + d3 + '  exigido:0, 3, 5,7 ou 8' + #13;
    Exit;
  end;
  wIE    := Copy(pInscricao,1,8);
  wDV    := IE_CalcDV11(wIE, 9);
  Result := wIE + wDV;
end;


Function IE_AP(pInscricao:String): String;       // 03 - Amapa
var numIE,vPFix,vDFix: Integer;
    nSoma,dv: Integer;
begin
  Result := '';
  if Copy(pInscricao,1,2) <> '03'
  then begin
    wMensagem := wMensagem + '2 dig iniciais:' + Copy(pInscricao,1,2) + '  exigido:03' + #13;
    Exit;
  end;
  wIE    := Copy(pInscricao,1,8);
  numIE  := StrToIntDef(wIE,0);
  if (numIE >= 03000001) and (numIE <= 03017000)
  then begin
    vPFix := 5;
    vDFix := 0;
  end
  else if (numIE >= 03017001) and (numIE <= 03019022)
       then begin
         vPFix := 5;
         vDFix := 0;
       end
       else begin    // > 030219022
         vPFix := 0;
         vDFix := 0;
       end;
  //
  nSoma := vPFix +
           (9 * strToInt(wIE[1])) +
           (8 * strToInt(wIE[2])) +
           (7 * strToInt(wIE[3])) +
           (6 * strToInt(wIE[4])) +
           (5 * strToInt(wIE[5])) +
           (4 * strToInt(wIE[6])) +
           (3 * strToInt(wIE[7])) +
           (2 * strToInt(wIE[8]));
  dv := 11 - (nSoma mod 11);
  if dv = 10
  then dv := 0
  else if dv = 11
       then dv := vDFix;
  wDV    := IntToStr(dv);
  Result := wIE + wDV;
end;


Function IE_AM(pInscricao:String): String;       // 04 - Amazonas
var nSoma,resto: Integer;
begin
  Result := '';
  wIE    := Copy(pInscricao,1,8);
  nSoma  := (9 * strToInt(wIE[1])) +
            (8 * strToInt(wIE[2])) +
            (7 * strToInt(wIE[3])) +
            (6 * strToInt(wIE[4])) +
            (5 * strToInt(wIE[5])) +
            (4 * strToInt(wIE[6])) +
            (3 * strToInt(wIE[7])) +
            (2 * strToInt(wIE[8]));
  if nSoma < 11
  then wDV := IntToStr(11 - nSoma)
  else begin
    resto := nSoma mod 11;
    if resto <= 1
       then wDV := '0'
       else wDV := IntToStr(11 - resto);
  end;
  Result := wIE + wDV;
end;


Function IE_BA(pInscricao:String): String;       // 05 - Bahia
var D1,D2: String;
    nd: Integer;
begin
  Result := '';
  // IE com 8 dígitos
  if Length(Trim(pInscricao)) = 8
  then begin
    nd := StrToIntDef(Copy(pInscricao,1,1),0);      // 1.dígito da inscrição
    if (nd < 6) or (nd = 8)
    then begin
      wIE  := Copy(pInscricao,1,6);
      D2   := IE_CalcDV10(wIE,7,7);
      wIE  := wIE + D2;
      D1   := IE_CalcDV10(wIE,8,8);
    end
    else begin       // nd = 6, 7 ou 9
      wIE  := Copy(pInscricao,1,6);
      D2   := IE_CalcDV11(wIE,7,7);
      wIE  := wIE + D2;
      D1   := IE_CalcDV11(wIE,8,8);
    end;
    Result := Copy(pInscricao,1,6) + D1 + D2;
    Exit;
  end;
  // IE com 9 digitos
  nd := StrToIntDef(Copy(pInscricao,2,1),0);
  if (nd < 6) or (nd = 8)
  then begin
    wIE  := Copy(pInscricao,1,7);
    D2   := IE_CalcDV10(wIE,8,8);
    wIE  := wIE + D2;
    D1   := IE_CalcDV10(wIE,9,9);
  end
  else begin       // nd = 6, 7 ou 9
    wIE  := Copy(pInscricao,1,7);
    D2   := IE_CalcDV11(wIE,8,8);
    wIE  := wIE + D2;
    D1   := IE_CalcDV11(wIE,8,8);
  end;
  Result := Copy(pInscricao,1,7) + D1 + D2;
end;


Function IE_CE(pInscricao:String): String;       // 06 - Ceará
begin
  Result := '';
  wIE    := Copy(pInscricao,1,8);
  wDV    := IE_CalcDV11(wIE, 9);
  Result := wIE + wDV;
end;


Function IE_DF(pInscricao:String): String;       // 07 - Distrito Federal
begin
  Result := '';
  if Copy(pInscricao,1,2) <> '07'
  then begin
    wMensagem := wMensagem + '2 dig iniciais:' + Copy(pInscricao,1,2) + '  exigido:07' + #13;
    Exit;
  end;
  wIE    := Copy(pInscricao,1,11);
  wDV    := IE_CalcDV11(wIE, 4);                 // 1.digito
  wIE    := wIE + wDV;
  wDV    := IE_CalcDV11(wIE, 5);                 // 2.digito
  Result := wIE + wDV;
end;


Function IE_ES(pInscricao:String): String;       // 08 - Espirito Santo
begin
  Result := '';
  wIE    := Copy(pInscricao,1,8);
  wDV    := IE_CalcDV11(wIE, 9);
  Result := wIE + wDV;
end;


Function IE_GO(pInscricao:String): String;       // 09 - Goiás
var n2,nSoma,resto: Integer;
begin
  Result := '';
  n2     := StrToIntDef(Copy(pInscricao,1,2),0);
  if (n2 <> 10) and (n2 <> 11) and (n2 <> 15)
  then begin
    wMensagem := wMensagem + '2 dig iniciais:' + Copy(pInscricao,1,2) + '  exigido:10, 11 ou 15' + #13;
    Exit;
  end;
  wIE    := Copy(pInscricao,1,8);
  //if wIE = '11094402xx' then wDV := '0'               // Observação SINTEGRA
  nSoma  := (9 * strToInt(wIE[1])) +
            (8 * strToInt(wIE[2])) +
            (7 * strToInt(wIE[3])) +
            (6 * strToInt(wIE[4])) +
            (5 * strToInt(wIE[5])) +
            (4 * strToInt(wIE[6])) +
            (3 * strToInt(wIE[7])) +
            (2 * strToInt(wIE[8]));
  resto := nSoma mod 11;
  case resto of
    0:wDV := '0';
    1:if (wIE >= '10103105') and (wIE <= '10119997')
         then wDV := '1'
         else wDV := '0';
    else wDV := IntToStr(11-resto);
  end;
  Result := wIE + wDV;
end;


Function IE_MA(pInscricao:String): String;       // 10 - Maranhão
begin
  Result := '';
  if Copy(pInscricao,1,2) <> '12'
  then begin
    wMensagem := wMensagem + '2 dig iniciais:' + Copy(pInscricao,1,2) + '  exigido:12' + #13;
    Exit;
  end;
  wIE    := Copy(pInscricao,1,8);
  wDV    := IE_CalcDV11(wIE, 9);
  Result := wIE + wDV;
end;


Function IE_MT(pInscricao:String): String;       // 11 - Mato Grosso
begin
  Result := '';
  while Length(pInscricao) < 11
    do pInscricao := '0' + pInscricao;
//  if Length(pInscricao) = 9
//    then wIE := Copy(pInscricao,1,8)
//     else wIE := Copy(pInscricao,1,10);
  wIE    := Copy(pInscricao,1,10);
  wDV    := IE_CalcDV11(wIE, 3, 9);
  Result := wIE + wDV;
end;


Function IE_MS(pInscricao:String): String;       // 12 - Mato Grosso do Sul
begin
  Result := '';
  if Copy(pInscricao,1,2) <> '28'
  then begin
    wMensagem := wMensagem + '2 dig iniciais:' + Copy(pInscricao,1,2) + '  exigido:28' + #13;
    Exit;
  end;
  wIE    := Copy(pInscricao,1,8);
  wDV    := IE_CalcDV11(wIE, 9);
  Result := wIE + wDV;
end;


Function IE_MG(pInscricao:String): String;       // 13 - Minas Gerais
begin
  Result := '';
  // Primeiro digito
  wIE    := Copy(pInscricao,1,3) + '0' + COpy(pInscricao,4,8);
  wDV    := IE_CalcDVXX(wIE,1);
  wIE    := Copy(pInscricao,1,11) + wDV;
  // Segundo digito
  wDV    := IE_CalcDV11(wIE, 3, 11);
  Result := wIE + wDV;
end;


Function IE_PA(pInscricao:String): String;       // 14 - Pará
begin
  Result := '';
  if Copy(pInscricao,1,2) <> '15'
  then begin
    wMensagem := wMensagem + '2 dig iniciais:' + Copy(pInscricao,1,2) + '  exigido:15' + #13;
    Exit;
  end;
  wIE    := Copy(pInscricao,1,8);
  wDV    := IE_CalcDV11(wIE, 9);
  Result := wIE + wDV;
end;


Function IE_PB(pInscricao:String): String;       // 15 - Paraíba
begin
  Result := '';
  if Copy(pInscricao,1,2) <> '16'
  then begin
    wMensagem := wMensagem + '2 dig iniciais:' + Copy(pInscricao,1,2) + '  exigido:16' + #13;
    Exit;
  end;
  wIE    := Copy(pInscricao,1,8);
  wDV    := IE_CalcDV11(wIE, 9);
  Result := wIE + wDV;
end;


Function IE_PR(pInscricao:String): String;       // 16 - Paraná
begin
  Result := '';
  wIE    := Copy(pInscricao,1,8);
  wDV    := IE_CalcDV11(wIE, 3, 7);              // 1.digito
  wIE    := wIE + wDV;
  wDV    := IE_CalcDV11(wIE, 4, 7);              // 2.digito
  Result := wIE + wDV;
end;


Function IE_PE(pInscricao:String): String;       // 17 - Pernambuco
begin
  Result := '';
  wIE    := Copy(pInscricao,1,7);
  wDV    := IE_CalcDV11(wIE, 8, 8);              // 1.digito
  wIE    := wIE + wDV;
  wDV    := IE_CalcDV11(wIE, 9);                 // 2.digito
  Result := wIE + wDV;
end;


Function IE_PI(pInscricao:String): String;       // 18 - Piauí
begin
  Result := '';
  if Copy(pInscricao,1,2) <> '19'
  then begin
    wMensagem := wMensagem + '2 dig iniciais:' + Copy(pInscricao,1,2) + '  exigido:19' + #13;
    Exit;
  end;
  wIE    := Copy(pInscricao,1,8);
  wDV    := IE_CalcDV11(wIE, 9);                 // 1.digito
  Result := wIE + wDV;
end;


Function IE_RJ(pInscricao:String): String;       // 19 - Rio de Janeiro
begin
  Result := '';
  wIE    := Copy(pInscricao,1,7);
  wDV    := IE_CalcDV11(wIE, 2, 7);              // 1.digito
  Result := wIE + wDV;
end;


Function IE_RN(pInscricao:String): String;       // 20 - Rio Grande do Norte
var nSoma,resto: Integer;
begin
  Result := '';
  if Copy(pInscricao,1,2) <> '20'
  then begin
    wMensagem := wMensagem + '2 dig iniciais:' + Copy(pInscricao,1,2) + '  exigido:20' + #13;
    Exit;
  end;
  if Length(pInscricao) = 9
  then begin
    wIE := Copy(pInscricao,1,8);
    nSoma  := (9 * strToInt(wIE[1])) +
              (8 * strToInt(wIE[2])) +
              (7 * strToInt(wIE[3])) +
              (6 * strToInt(wIE[4])) +
              (5 * strToInt(wIE[5])) +
              (4 * strToInt(wIE[6])) +
              (3 * strToInt(wIE[7])) +
              (2 * strToInt(wIE[8]));
  end
  else begin
    wIE := Copy(pInscricao,1,9);
    nSoma  := (10 * strToInt(wIE[1])) +
               (9 * strToInt(wIE[2])) +
               (8 * strToInt(wIE[3])) +
               (7 * strToInt(wIE[4])) +
               (6 * strToInt(wIE[5])) +
               (5 * strToInt(wIE[6])) +
               (4 * strToInt(wIE[7])) +
               (3 * strToInt(wIE[8])) +
               (2 * strToInt(wIE[9]));
  end;
  nSoma := nSoma * 10;
  resto := nSoma mod 11;
  if resto = 10
     then wDV := '0'
     else wDV := IntToStr(resto);
  Result := wIE + wDV;
end;


Function IE_RS(pInscricao:String): String;      // 21 - Rio Grande do Sul
begin
  wIE    := Copy(pInscricao,1,9);
  wDV    := IE_CalcDV11(wIE, 2);
  Result := wIE + wDV;
end;


Function IE_RO(pInscricao:String): String;       // 22 - Rondonia
var dv,nSoma: Integer;
begin
  Result := '';
  if Length(pInscricao) = 9
  then begin
    wIE   := Copy(pInscricao,4,5);
    nSoma := (6 * strToInt(wIE[1])) +
             (5 * strToInt(wIE[2])) +
             (4 * strToInt(wIE[3])) +
             (3 * strToInt(wIE[4])) +
             (2 * strToInt(wIE[5]));
    wIE   := Copy(pInscricao,1,8);
  end
  else begin
    wIE   := Copy(pInscricao,1,13);
    nSoma := (6 * strToInt(wIE[1])) +
             (5 * strToInt(wIE[2])) +
             (4 * strToInt(wIE[3])) +
             (3 * strToInt(wIE[4])) +
             (2 * strToInt(wIE[5])) +
             (9 * strToInt(wIE[6])) +
             (8 * strToInt(wIE[7])) +
             (7 * strToInt(wIE[8])) +
             (6 * strToInt(wIE[9])) +
             (5 * strToInt(wIE[10])) +
             (4 * strToInt(wIE[11])) +
             (3 * strToInt(wIE[12])) +
             (2 * strToInt(wIE[13]));
  end;
  dv := 11 - (nSoma mod 11);
  if (dv = 10) or (dv = 11)
     then dv := dv - 10;
  wDV := IntToStr(dv);
  Result := wIE + wDV;
end;


Function IE_RR(pInscricao:String): String;       // 23 - Rondonia
var dv,nSoma: Integer;
begin
  Result := '';
  if Copy(pInscricao,1,2) <> '24'
  then begin
    wMensagem := wMensagem + '2 dig iniciais:' + Copy(pInscricao,1,2) + '  exigido:24' + #13;
    Exit;
  end;
  wIE    := Copy(pInscricao,1,8);
  nSoma  := (1 * strToInt(wIE[1])) +
            (2 * strToInt(wIE[2])) +
            (3 * strToInt(wIE[3])) +
            (4 * strToInt(wIE[4])) +
            (5 * strToInt(wIE[5])) +
            (6 * strToInt(wIE[6])) +
            (7 * strToInt(wIE[7])) +
            (8 * strToInt(wIE[8]));
  dv     := nSoma mod 9;
  wDV    := IntToStr(dv);
  Result := wIE + wDV;
end;


Function IE_SC(pInscricao:String): String;      // 24 - Santa Catarina
begin
  Result := '';
  wIE    := Copy(pInscricao,1,8);
  wDV    := IE_CalcDV11(wIE, 9);
  Result := wIE + wDV;
end;


Function IE_SP(var pInscricao:String): String;       // 25 - São Paulo
var dv,nSoma: Integer;
begin
  Result := '';
  if Length(pInscricao) = 12
  then begin
    // 1. DV
    wIE    := Copy(pInscricao,1,8);
    nSoma  := (1 * strToInt(wIE[1])) +
              (3 * strToInt(wIE[2])) +
              (4 * strToInt(wIE[3])) +
              (5 * strToInt(wIE[4])) +
              (6 * strToInt(wIE[5])) +
              (7 * strToInt(wIE[6])) +
              (8 * strToInt(wIE[7])) +
              (10 * strToInt(wIE[8]));
    dv     := nSoma mod 11;
    if dv = 10
       then dv := 0;
    wIE    := wIE + IntToStr(dv) + Copy(pInscricao,10,2);
    // 2. DV
    nSoma  := (3  * strToInt(wIE[1])) +
              (2  * strToInt(wIE[2])) +
              (10 * strToInt(wIE[3])) +
              (9  * strToInt(wIE[4])) +
              (8  * strToInt(wIE[5])) +
              (7  * strToInt(wIE[6])) +
              (6  * strToInt(wIE[7])) +
              (5  * strToInt(wIE[8])) +
              (4  * strToInt(wIE[9])) +
              (3  * strToInt(wIE[10])) +
              (2  * strToInt(wIE[11]));
    dv     := nSoma mod 11;
    if dv = 10
       then dv := 0;
    Result := wIE + IntToStr(dv);
    Exit;
  end;
  //
  if Copy(pInscricao,1,1) <> 'P'
  then begin
    wMensagem := wMensagem + 'IE SP com 13 dig  1º:' + Copy(pInscricao,1,1) + '  exigido:P' + #13;
    Exit;
  end;
  wIE   := Copy(pInscricao,2,8);
  nSoma := (1 * strToInt(wIE[1])) +
           (3 * strToInt(wIE[2])) +
           (4 * strToInt(wIE[3])) +
           (5 * strToInt(wIE[4])) +
           (6 * strToInt(wIE[5])) +
           (7 * strToInt(wIE[6])) +
           (8 * strToInt(wIE[7])) +
           (10 * strToInt(wIE[8]));
  dv    := nSoma mod 11;
  if dv = 10
     then dv := 0;
  pInscricao := Copy(pInscricao,1,10);        // Para comparar os 10 1os digitos
  Result     := Copy(pInscricao,1,1) + wIE + IntToStr(dv);
end;


Function IE_SE(pInscricao:String): String;      // 26 - Sergipe
begin
  Result := '';
  wIE    := Copy(pInscricao,1,8);
  wDV    := IE_CalcDV11(wIE, 9);
  Result := wIE + wDV;
end;


Function IE_TO(pInscricao:String): String;      // 27 - Tocantins
var x34: String;
begin
  Result := '';
  if Length(pInscricao) = 11
  then begin
    x34    := Copy(pInscricao,3,2);
    if (x34 <> '01') and (x34 <> '02') and (x34 <> '03') and (x34 <> '99')
    then begin
      wMensagem := wMensagem + 'IE TO dig3e4:' + x34 + '  exigido:01 02 03 99' + #13;
      Exit;
    end;
    wIE    := Copy(pInscricao,1,2) + Copy(pInscricao,5,6);
    wDV    := IE_CalcDV11(wIE, 9);
    Result := Copy(pInscricao,1,10) + wDV;
  end
  else begin     // 9 digitos
    wIE    := Copy(pInscricao,1,8);
    wDV    := IE_CalcDV11(wIE, 9);
    Result := Copy(pInscricao,1,8) + wDV;
  end;

end;


Function ValidaInscricaoEstadual(pInscr,pUf:String;pMetodo:Integer=0;lMsg:Boolean=False):Integer;
// pInscr:  Inscrição estadual
// pUf:     Sigla do estado
// pMetodo: Metodo de validação  0-Rotina própria     1-DLLInscE32
// lMsg:    Emite ou não mensagem de erro
// Retorna < 0 em case de Erro (Inscrição Estadual / UF inválida)
// 0: Ok    -1:Erro
var LibHandle: THandle;
    CIEst:     TCIEst;
    xIE: String;
    nInd: integer;
begin
  Result := -1;                           // Indicação de ERRO
  if (Length(Trim(pInscr)) = 0)
     or (Pos('ISENTO',AnsiUpperCase(pInscr)) > 0)
  then begin
    Result := 0;
    Exit;
  end;
  if not ValidaSiglaUFCaracteresTamanho(pInscr, pUF, nInd)
  then begin
    if lMsg
       then MessageDlg(xMsgFixo + #13#13 + wMensagem, mtError, [mbOK], 0);
    Exit;
  end;
  if pMetodo = 0
  then begin
    case nInd of
       1:xIE := IE_AC(pInscr);
       2:xIE := IE_AL(pInscr);
       3:xIE := IE_AP(pInscr);
       4:xIE := IE_AM(pInscr);
       5:xIE := IE_BA(pInscr);
       6:xIE := IE_CE(pInscr);
       7:xIE := IE_DF(pInscr);
       8:xIE := IE_ES(pInscr);
       9:xIE := IE_GO(pInscr);
      10:xIE := IE_MA(pInscr);
      11:xIE := IE_MT(pInscr);
      12:xIE := IE_MS(pInscr);
      13:xIE := IE_MG(pInscr);
      14:xIE := IE_PA(pInscr);
      15:xIE := IE_PB(pInscr);
      16:xIE := IE_PR(pInscr);
      17:xIE := IE_PE(pInscr);
      18:xIE := IE_PI(pInscr);
      19:xIE := IE_RJ(pInscr);
      20:xIE := IE_RN(pInscr);
      21:xIE := IE_RS(pInscr);
      22:xIE := IE_RO(pInscr);
      23:xIE := IE_RR(pInscr);
      24:xIE := IE_SC(pInscr);
      25:xIE := IE_SP(pInscr);
      26:xIE := IE_SE(pInscr);
      27:xIE := IE_TO(pInscr);
    end;
    while Length(xIE) > Length(pInscr)
      do pInscr := '0' + pInscr;
    if xIE <> pInscr
    then begin
      wMensagem := wMensagem + 'IE informada: ' + pInscr
                             + '   calculada: ' + xIE + '    UF: ' + pUF;
      if lMsg
         then MessageDlg('Inscrição inválida para a UF' + #13 + wMensagem,mtError,[mbOk],0);
    end
    else Result := 0;
    Exit;
  end;
  // Método DLLInscr32
  //
  Try
    LibHandle := LoadLibrary(PChar(Trim('DllInscE32')));
    if LibHandle <= HINSTANCE_ERROR
    then begin
      //MessageDlg('DllInscE32.DLL - Não carregada',mtError,[mbOk],0);
      Raise Exception.Create('DllInscE32.DLL - Não carregada');
      Result := -1;
    end
    else begin
      @CIEst := GetProcAddress(LibHandle,'ConsisteInscricaoEstadual');
      if @CIEst = nil
      then begin
        //MessageDlg('"ConsisteInscricaoEstadual" não encontrado em DllInscE32.DLL',mtError,[mbOk],0);
        Raise Exception.Create('"ConsisteInscricaoEstadual" não encontrado em DllInscE32.DLL');
        Result := -1;
      end
      else Result := CIEst(pInscr,pUf);
    end;
  Finally
    FreeLibrary(LibHandle);
  End;
  //

end;


Function ValidaPlacaVeiculo(pmtPlacas:String):Integer;
// Retorna 0:Ok  <>0: Erro
var wPlacas: String;
    i: Integer;
    xComp: String;
const xNum: String = '0123456789';
      xAlf: String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      xNAf: String = '0123456789ABCDEFGHIJ';
begin
  Result := 0;
  wPlacas := Trim(pmtPlacas);
  if (Length(wPlacas) < 7) or (Length(wPlacas) > 8)
  then begin
    Result := 8;
    Exit;
  end;
  if Length(wPlacas) = 7 then wPlacas := Copy(wPlacas,1,3) + '-' + Copy(wPlacas,4,4);
  for i := 1 to 3
  do if Pos(wPlacas[i],xAlf) = 0
     then begin
       Result := Result + 1;
       Break;
     end;
  if wPlacas[4] <> '-'
     then Result := Result + 2;
  for i := 5 to 8
  do begin
    xComp := xNum;
    if i = 6 then xComp := xNAf;
    if Pos(wPlacas[i],xComp) = 0
    then begin
      Result := Result + 4;
      Break;
    end;
  end;

end;


Function ValidaRenavam(pmtRenavam:String ): Boolean;
var soma,i,dgCalc: Integer;
    ndg: array[1..11] of integer;
begin
  Result := False;
  while Length(Trim(pmtRenavam)) < 11
    do pmtRenavam := '0' + pmtRenavam;
  if Length(Trim(pmtRenavam)) > 11
  then begin
    MessageDlg('Código RENAVAM deve ter no máximo 11 (onze) dígitos',mtError,[mbOk],0);
    Exit;
  end;
  if (pmtRenavam = '00888888888') or (pmtRenavam = '00999999999')
     or (pmtRenavam = '88888888888') or (pmtRenavam = '99999999999')
  then begin
    Result := True;
    Exit;
  end;
  soma  := 0;
  for i := 1 to 11
  do if (pmtRenavam[i] >= '0') and (pmtRenavam[i] <= '9')
     then begin
       soma   := soma + 1;
       ndg[i] := StrToInt(pmtRenavam[i]);
     end
     else Break;
  if soma <> 11
  then begin
    MessageDlg('Código RENAVAM com caracteres não numericos',mtError,[mbOk],0);
    Exit;
  end;
  //
  soma   := ndg[1]*3 + ndg[2]*2 + ndg[3]*9 + ndg[4]*8 + ndg[5]*7 + ndg[6]*6 + ndg[7]*5 + ndg[8]*4 + ndg[9]*3 + ndg[10]*2;
  // Soma := ndg[1]*9 + ndg[2]*8 + ndg[3]*7 + ndg[4]*6 + ndg[5]*5 + ndg[6]*4 + ndg[7]*3 + ndg[8]*2;


  dgCalc := 11 - (soma mod 11);
  if dgCalc > 9
     then dgCalc := 0;
  if dgCalc = ndg[11]         
     then Result := True;

end;


Function ValidaUF(pmtSigla:String):Boolean;
var i: Integer;
const siglasUF: array [1..28] of String = ('AC','AL','AM','AP','BA','CE','DF','ES','EX','GO',
                                           'MA','MG','MS','MT','PA','PB','PE','PI','PR','RJ',
                                           'RN','RO','RR','RS','SC','SE','SP','TO');
begin
  Result := False;
  for i := 1 to Length(siglasUF)
  do if pmtSigla = siglasUF[i]
     then begin
       Result := True;
       Break;
     end;

end;


Function CalculaDV11(pmtNro:String):String;
// pmtNro: String contendo o nr. para calcular o DV de modulo 11
// Retorna o Dígito verificador;
var fat,n,i,dc,dv: Integer;
begin
  fat := 9;
  dc := 0;
  for i := Length(pmtNro) downto 1
  do begin
    n := StrToInt(pmtNro[i]);
    dc := dc + (n * fat);
    fat := fat - 1;
    if fat < 2 then fat := 9;
  end;
  dv := dc mod 11;
  if dv = 10 then dv := 1;
  Result := IntToStr(dv);

end;

//
Function CalculaDVEAN13(pmtNro:String):String;
// Codigo: do ítem a calcular o DV. deve ter 12 digitos
// Retorna o dígito verificador, '*' em caso de erro de informação
var Dado: String;
    i,TPar,TImp,Total,Resto,Digito: Integer;
begin
  Result := '*';
  if Length(pmtNro) <> 12 then Exit;
  TPar := 0;
  for i := 1 to 12
  do if (pmtNro[i] > '9') or (pmtNro[i] < '0')
     then TPar := 1;
  if TPar <> 0 then Exit;

  TImp := StrToInt(Dado[1]) + StrToInt(Dado[3]) + StrToInt(Dado[5]) +
          StrToInt(Dado[7]) + StrToInt(Dado[9]) + StrToInt(Dado[11]);
  TPar := StrToInt(Dado[2]) + StrToInt(Dado[4]) + StrToInt(Dado[6]) +
          StrToInt(Dado[8]) + StrToInt(Dado[10]) + StrToInt(Dado[12]);
  Total := (TPar * 3) + TImp;
  Resto := Total Mod 10;
  if Resto = 0 then Digito := 0
               else Digito := 10 - resto;
  Result := IntToStr(Digito);

end;


Function CalculaDVCodBar(pmtNro:String):String;
// pmtNro: Codigo do ítem a calcular o DV, pode ter 7, 11, 12, 13, 16 ou 17 posições
//         GTIN-8, GTIN-12, GTIN-13, GTIN-14, GSIN, SSCC
// Retorna o dígito verificador, '*' em caso de erro de informação
var nTam,i,wSoma,wFat,wDig: Integer;
begin
  Result := '*';
  nTam   := Length(pmtNro);
  if (nTam < 7)
     or (nTam = 8)
     or (nTam = 9)
     or (nTam = 10)
     or (nTam = 14)
     or (nTam = 15)
     or (nTam > 17)
     then Exit;
  wSoma := 0;
  for i := 1 to Length(pmtNro)
  do if (pmtNro[i] > '9') or (pmtNro[i] < '0')
     then wSoma := wSoma + 1;
  if wSoma > 0 then Exit;
  //
  while Length(pmtNro) < 17
    do pmtNro := '0' + pmtNro;
  //
  wFat  := 3;
  for i := 1 to Length(pmtNro)
  do begin
    wSoma := wSoma + (StrToInt(pmtNro[i]) * wFat);
    if wFat = 3 then wFat := 1
                else wFat := 3;
  end;
  wDig  := wSoma Mod 10;
  if wDig <> 0
     then wDig := 10 - wDig;
  Result := IntToStr(wDig);

end;


Function ValidaDVCodBar(pmtCodBar:String):Boolean;
// pmtNro: Codigo do ítem a calcular o DV, deve ter 8, 12, 13, 14, 17 ou 18 posições
//         GTIN-8, GTIN-12, GTIN-13, GTIN-14, GSIN, SSCC
// Retorna True se o dv estiver correto, False em caso de erro
var nTam,i,wSoma,wFat,wDig: Integer;
begin
  Result := False;
  nTam   := Length(pmtCodBar);
  if (nTam < 8)
     or (nTam = 9)
     or (nTam = 10)
     or (nTam = 11)
     or (nTam = 15)
     or (nTam = 16)
     or (nTam > 18)
     then Exit;
  wSoma  := 0;
  for i  := 1 to Length(pmtCodBar)
  do if (pmtCodBar[i] > '9') or (pmtCodBar[i] < '0')
     then wSoma := wSoma + 1;
  if wSoma > 0 then Exit;
  //
  while Length(pmtCodBar) < 18
    do pmtCodBar := '0' + pmtCodBar;
  //
  wFat  := 3;
  for i := 1 to Length(pmtCodBar)-1
  do begin
    wSoma := wSoma + (StrToInt(pmtCodBar[i]) * wFat);
    if wFat = 3 then wFat := 1
                else wFat := 3;
  end;
  wDig  := wSoma Mod 10;
  if wDig <> 0
     then wDig := 10 - wDig;
  if wDig = StrToInt(pmtCodBar[18])
     then Result := True;

end;


//
Function ValidaFCI(pFCI:String;pMsg:Boolean):Boolean;
// FCI: 36 caracteres, 0 a 9, A a F e hífen
// nas pos. 9, 14, 19 e 24 : hífen
var wP: String;
    i: Integer;
    msgErro: String;
const xVal: String = ('0123456789ABCDEF');
begin
  Result := True;
  msgErro := '';
  if Length(Trim(pFCI)) = 0 then Exit;
  if Length(Trim(pFCI)) <> 36
  then msgErro := msgErro + 'Tamanho difere de 36 posições (' + IntToStr(Length(Trim(pFCI))) + ')' + #13;
  if ((pFCI[9]<>'-') or (pFCI[14]<>'-') or (pFCI[19]<>'-') or (pFCI[24]<>'-'))
  then msgErro := msgErro + 'Pos 9, 14, 19 ou 24 diferente de "-" (hífen)' + #13;
  wP := Trim(pFCI);
  for i := 1 to Length(wP)
  do if (i=9) or (i=14) or (i=19) or (i=24)
     then begin
       if wP[i] <> '-' then msgErro := msgErro + 'Pos ' + IntToStr(i) + ' [' + wP[i] +
                                                 '] deve conter "-" (hífen)' + #13;
     end
     else begin
       if Pos(wP[i],xVal) = 0
          then msgErro := msgErro + 'Pos ' + IntToStr(i) + ' [' + wP[i] +
                                    '] deve conter 0,1,2,3,4,5,6,7,8,9,A,B,C,D,E ou F' + #13;
     end;
  if Length(Trim(msgErro)) > 0
  then begin
    Result := False;
    if pMsg
    then MessageDlg('Erro na formação do código FCI' + #13#13 + msgErro + #13#13 +
                    'Reinforme...',mtError,[mbOk],0);
  end;

end;


Function ValidaEMail(pEMailIn:String):Boolean;
var wEMail: String;
    npArrob,npPto,npHif,npUnd,npBran: Integer;
    ctArrob,ctInval,i: integer;
const xValid: string = ('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.-_@ÇçÃã');
      xStInv: array[1..11] of String = ('..','.@','@.','.-','-.','._','_.','__@','@_','--@','@-');
begin
  Result  := False;
  wEMail  := Trim(pEMailIn);
  npArrob := Pos('@',wEMail);
  npPto   := Pos('.',wEMail);
  npUnd   := Pos('_',wEMail);
  npHif   := Pos('-',wEMail);
  npBran  := Pos(' ',wEMail);
  ctArrob := 0;
  ctInval := 0;
  if (Length(wEMail) = 0)                      // EMail NÃO informado
     or (npArrob <= 1)                         // @ inexistente ou na 1a.posição
     or (npArrob =  Length(wEMail))            // @ na ultima posição
     or (npPto <= 1)                           // . inexistente ou na 1a. posição
     or (npPto = Length(wEMail))               // . na ultima posição
     or (npUnd = 1)                            // _ na 1a. posição
     or (npUnd = Length(wEMail))               // _ na ultima posição
     or (npHif = 1)                            // - na 1a. posição
     or (npHif = Length(wEMail))               // - na ultima posição
     or (npBran > 0)                           // há branco no email
  then Exit;
  //
  for i := 1 to Length(wEMail)
  do if wEMail[i] = '@'
        then ctArrob := ctArrob + 1
        else if Pos(wEMail[i],xValid) = 0
             then ctInval := ctInval + 1;
  for i := 1 to Length(xStInv)
  do if Pos(xStInv[i],wEMail) > 0
        then ctInval := ctInval + 1;
  //
  if (ctArrob <> 1)
     or (ctInval > 0)
  then Exit;
  //
  Result := True;

end;


Function  ValidaTelefone(pNumero:String; var pNroUso:String): String;
begin
  Result  := '*';
  pNroUso := Numerico(pNumero);
  if Length(Trim(pNumero)) < 8 then Exit;
  if Length(Trim(pNroUso)) = 8
  then begin
    if pNroUso[1] = '9'
    then begin
      pNroUso := '9' + pNroUso;
      Result  := 'C';      // Celular
    end
    else Result := 'F';    // Fixo
  end
  else if Length(Trim(pNroUso)) = 9
          then Result := 'C';

end;


Function VerificaConexao(pDrive,pPath,pPsw:String):Integer;
{
   Verifica a conectividade com uma unidade remota
     pDrive: Drive remoto a ser conectado
     pPath: Caminho de conexão
     pPsw: Senha para conexão
     Retorno:  = 0 --> OK
              <> 0 --> Erro do sistema (Exceto 85 - conexão já existe)
}
var LinDd: String;
    PServer,PLetra,PSenha: PChar;
    Err: Word;
begin
  pDrive := AnsiUpperCase(pDrive);
  if (pDrive = 'LOCAL') or (pDrive = 'LOCAL:') or (pDrive = 'C') or (pDrive = 'C:')
  then begin
    Result := 0;
    Exit;
  end;
  PLetra := PChar(pDrive);
  PServer := PChar(pPath);
  PSenha := PChar(pPsw);
  Err := WNetAddConnection(PServer,PSenha,PLetra);
  if (Err = ERROR_ALREADY_ASSIGNED) or        // Já existe a conexão para a letra
     (Err = ERROR_DEVICE_ALREADY_REMEMBERED)
  then begin
    WNetCancelConnection(PLetra,True);
    Err := WNetAddConnection(PServer,PSenha,PLetra);
  end;
  if (Err = 0) or                      // Conexão OK
     (Err = ERROR_ALREADY_ASSIGNED)    // 'A letra do drive especificada já está conectada.'
  then begin
    Result := 0;
    Exit;
  end;

  Result := Err;
  case Err of
    ERROR_ACCESS_DENIED: LinDd := 'Acesso negado.';
    ERROR_BAD_DEV_TYPE: LinDd := 'O tipo de dispositivo e o tipo de recurso nao sao compatíveis.';
    ERROR_BAD_DEVICE: LinDd := 'Letra inválida.';
    ERROR_BAD_NET_NAME: LinDd := 'Nome do servidor nao é válido ou nao pode ser localizado.';
    ERROR_BAD_PROFILE: LinDd := 'Formato incorreto de parâmetros.';
    ERROR_CANNOT_OPEN_PROFILE: LinDd := 'Conexao permanente nao disponível.';
    ERROR_DEVICE_ALREADY_REMEMBERED: LinDd := 'Uma entrada para o dispositivo especificado já está no  perfil do usuário.';
    ERROR_EXTENDED_ERROR: LinDd := 'Erro de rede.';
    ERROR_INVALID_PASSWORD: LinDd := 'Senha especificada inválida.';
    ERROR_NO_NET_OR_BAD_PATH: LinDd := 'A operaçao nao foi concluída porque a rede nao foi inicializada  ou caminho é inválido.';
    ERROR_NO_NETWORK: LinDd := 'A rede nao está presente.';
    else LinDd := 'Erro indefinido';
  end;
  MessageDlg('Erro de conexão' + #13 +
             LinDd + '   Erro: [' + IntToSTr(Err) + ']' + #13 +
             'Servidor: ' + pPath + #13 +
             'Drive: ' + pDrive + #13 +
             'Senha: ' + pPsw + #13 +
             'Comunicação impossibilitada',mtError,[mbOk],0);

end;


Function DSStateText(pState: TDataSetState): String;
begin
  case pState of
    dsInactive:   Result := 'Inactive';
    dsBrowse:     Result := 'Browse';
    dsEdit:       Result := 'Edit';
    dsInsert:     Result := 'Insert';
    dsSetKey:     Result := 'SetKey';
    dsCalcFields: Result := 'CalcFields';
    dsFilter:     Result := 'Filter';
    dsNewValue:   Result := 'NewValue';
    dsOldValue:   Result := 'OldValue';
    dsCurValue:   Result := 'CurValue';
    dsBlockRead:  Result := 'BlockRead';
    dsInternalCalc: Result := 'InternalCalc';
    dsOpening:    Result := 'Opening';
    else          Result := 'Indefinido';
  end;

end;


Function DefineGrid(pGrid:TDBGrid; pLarg:Array of Real; pCol1,pCol2:Integer; pPerc:Boolean = True): TDBGrid;
var lrgMax,wSoma,i,ncVis,nIncr: Integer;
begin
  if pCol2 = 0
     then pCol2 := pCol1;
  ncVis := 0;
  for i := 0 to pGrid.Columns.Count-1
  do if pGrid.Columns[i].Visible
     then ncVis := ncVis + 1;
  if ncVis < 14
  then nIncr := 11
  else if ncVis < 22
       then nIncr := 12
       else if ncVis < 30
            then nIncr := 13
            else nIncr := 14;
  lrgMax := pGrid.ClientWidth - (nIncr + ncVis);
  wSoma  := 0;
  for i := 0 to Length(pLarg)-1
  do if (i <> pCol1) and (i <> pCol2) and pGrid.Columns[i].Visible
     then begin
       if pPerc
          then pGrid.Columns[i].Width := Round(lrgMax * pLarg[i])
          else pGrid.Columns[i].Width := Trunc(pLarg[i]);
       wSoma := wSoma + pGrid.Columns[i].Width;
     end;
  //
  if (pCol2 > 0) and (pCol2 <> pCol1)
  then begin
    pGrid.Columns[pCol2].Width := (lrgMax - wSoma) div 2;
    wSoma := wSoma + pGrid.Columns[pCol2].Width;
  end;
  pGrid.Columns[pCol1].Width := lrgMax - wSoma;
  //
  Result := pGrid;

end;


Procedure DestaqueGrid(pGrid:TDbGrid;pCor,pCorDest,pTit,pTitDest:TColor;pCol:Integer);
var i: Integer;
begin
  for i := 0 to pGrid.Columns.Count-1
  do begin
    pGrid.Columns[i].Color       := pCor;
    pGrid.Columns[i].Title.Color := pTit;
  end;
  pGrid.Columns[pCol].Color       := pCorDest;
  pGrid.Columns[pCol].Title.Color := pTitDest;

end;


Procedure DestacaLinhaGrid(pmtDbGrid:TDBGrid; pmtCor:TColor;
                             const Rect:TRect; DataCol:Integer; Column:TColumn; State:TGridDrawState);
begin
  with pmtDbGrid
  do begin
    if  DataSource.DataSet.State in [dsEdit, dsInsert, dsBrowse]
    then //Cor da linha selecionada
         if (Rect.Top = TStringGrid(pmtDbGrid).CellRect(DataCol,TStringGrid(pmtDbGrid).Row).Top)
            or( gdSelected in State)
         then begin
           Canvas.FillRect(Rect);
           Canvas.Brush.Color := pmtCor;
           DefaultDrawDataCell(Rect,Column.Field,State)
         end;
  end;

end;


Procedure DefineColunasGrid(pGrid:TDBGrid; pLarg:Array of Integer);
var i: Integer;
begin
  for i := 0 to pGrid.Columns.Count-1
  do pGrid.Columns[i].Width := pLarg[i];

end;

Function  ValidaComboBox(pmtComboBox:TComboBox;pmtIgual:Boolean=True;pmtMsg:Boolean=False): Boolean;
// pmtIgual  True='text' deve ser igual à um dos ítens   False='text' deve estar contido em um dos ítens
var i: Integer;
begin
  Result := False;
  i      := 0;
  while (i <  pmtComboBox.Items.Count) and (not Result)
  do begin
    if  pmtIgual
    then begin        // 'text' IGUAL
      if AnsiUpperCase(pmtComboBox.Text) = AnsiUpperCase(pmtComboBox.Items[i])
         then Result := True;
    end
    else begin
      if Pos(AnsiUpperCase(pmtComboBox.Text),AnsiUpperCase(pmtComboBox.Items[i])) > 0
         then Result := True;
    end;
    i := i + 1;
  end;
  if (not Result) and pmtMsg
     then MessageDlg('Indique uma alternativa válida',mtError,[mbOk],0);

end;



Function AbreviaNome(pNome:String;pTam:Integer):String;
// pNome: Nome a ser abreviado
// pTam: Tamanho a ser retornado
// Retorna String de tamanho Tam
var Partes: array of String;
    pbr,np: Integer;
    j,i,vez: Integer;
    Aux: String;
    Faz: Boolean;
const XFim: array[1..2] of String = ('. ',' ');
begin
  Result := pNome;
  if Length(Trim(pNome)) <= pTam
    then Exit;
  // Obtem as partes dos nomes
  Aux := pNome;
  pbr := 99;
  np := 0;
  while pbr > 0
  do begin
    np := np + 1;
    SetLength(Partes,np);
    pbr := Pos(' ',Aux);
    if pbr > 0
    then begin
      Partes[np-1] := Trim(Copy(Aux,1,pbr)) + ' ';
      Aux := Copy(Aux,pbr+1,Length(Aux)-pbr);
    end
    else Partes[np-1] := Trim(Aux);
  end;

  np := np - 1;      // Ultima parte do nome
  j := 1;            // Segundo nome (1. a ser abreviado)
  Vez := 1;          // Contagem de processos
  Faz := True;
  while Faz
  do begin
    if Length(Trim(Partes[j])) > 3
    then if Vez < 3 then Partes[j] := Copy(Partes[j],1,1) + XFim[Vez]
                    else Partes[j] := '';
    Aux := '';
    for i := 0 to np do Aux := Aux + Partes[i];
    if (Length(Aux) <= pTam) or (Vez = 3) then Faz := False;
    if Faz
    then begin
      j := j + 1;
      if j >= np
      then begin
        Vez := Vez + 1;
        j := 1;
      end;
    end;
  end;
  if (Vez = 3) and (Length(Trim(Aux)) > pTam)
  then begin
    Vez := 1;
    Faz := True;
    while Faz
    do begin
      Partes[0] := Copy(Partes[0],1,1) + XFim[Vez];
      Aux := '';
      for i := 0 to np do Aux := Aux + Partes[i];
      if (Length(Aux) <= pTam) or (Vez=2) then Faz := False;
      Vez := Vez + 1;
    end;
    if Length(Aux) > pTam then Aux := Copy(Aux,1,pTam);
  end;
  Result := Aux;

end;


Function PrepVlrECF(pValor:Real;pTam,pDec:Integer):String;
// pValor: Valor a ser passado ao ECF (Emissor de Cupons Fiscais)
// pTam: Tamanho em bytes a ser retornado
// pDec: Qtd de decimais
var ps: integer;
begin
  Result := FloatToStrF(pValor,ffFixed,pTam+1,pDec);
  ps := Pos('.',Result);
  while ps > 0
  do begin
    Delete(Result,ps,1);
    ps := Pos('.',Result);
  end;
  ps := Pos(',',Result);
  while ps > 0
  do begin
    Delete(Result,ps,1);
    ps := Pos(',',Result);
  end;
  while Length(Result) < pTam do Result := '0' + Result;

end;


Function DataUTC(pDataHora: TDateTime):String;
var AA,MM,DD,Hh,Mn,Se,Ms: Word;
    xAno,xMes,xDia,xHor,xMin,xSeg: String;
begin
  DecodeDateTime(pDataHora,AA,MM,DD,Hh,Mn,Se,Ms);
  xAno := IntToStr(AA);
  xMes := IntToStr(MM);
  xDia := IntToStr(DD);
  if (Hh = 0) and (Mn = 0) and (Se = 0)
     then DecodeTime(Now,Hh,Mn,Se,Ms);
  xHor := IntToStr(Hh);
  xMin := IntToSTr(Mn);
  xSeg := IntToStr(Se);
  while Length(Trim(xMes)) < 2 do xMes := '0' + xMes;
  while Length(Trim(xDia)) < 2 do xDia := '0' + xDia;
  while Length(Trim(xHor)) < 2 do xHor := '0' + xHor;
  while Length(Trim(xMin)) < 2 do xMin := '0' + xMin;
  while Length(Trim(xSeg)) < 2 do xSeg := '0' + xSeg;

  Result := xAno + '-' + xMes + '-' + xDia
           + 'T' + xHor + ':' + xMin + ':' + xSeg;

end;


Function Numerico(pDado:String): String;
var infDd: String;
    i: Integer;
begin
  infDd  := Trim(pDado);
  Result := '';
  for i  := 1 to Length(infDd)
  do begin
    if (infDd[i] >= '0') and (infDd[i] <= '9')
    then Result := Result + infDd[i];
  end;

end;


Function AlfaNumerico(pDado:String;pUpper:Boolean=False): String;
var infDd: String;
    i: Integer;
begin
  infDd := Trim(pDado);
  if pUpper then infDd := AnsiUpperCase(infDd);
  Result := '';
  for i := 1 to Length(infDd)
  do begin
    if ((infDd[i] >= '0') and (infDd[i] <= '9'))
       or ((infDd[i] >= 'A') and (infDd[i] <= 'Z'))
       or ((infDd[i] >= 'a') and (infDd[i] <= 'z'))
    then Result := Result + infDd[i];
  end;

end;

Function Alfabetico(pDado:String): String;
var infDd: String;
    i: Integer;
begin
  infDd := Trim(pDado);
  Result := '';
  for i := 1 to Length(infDd)
  do begin
    if ((infDd[i] >= 'A') and (infDd[i] <= 'Z'))
       or ((infDd[i] >= 'a') and (infDd[i] <= 'z'))
    then Result := Result + infDd[i];
  end;

end;


Function AlfaNumericoEspecial(pDado:String;pUpper:Boolean=False;pValid:Integer=1): String;
var infDd: String;
    i: Integer;
    xValid: String;
const wValidar1: String = ('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,@#$%&*()-+=:;\/_ ');
      wValidar2: String = ('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,-_ ');
begin
  Result := '';
  infDd  := Trim(pDado);
  if pUpper then infDd := AnsiUpperCase(infDd);
  if pValid = 1 then xValid := wValidar1
                else xValid := wValidar2;
  for i := 1 to Length(infDd)
  do if Pos(infDd[i],xValid) > 0
        then Result := Result + infDd[i];

end;


Function  ConjuntoEspecial(pDado:String;pValid:String;pUpperCase:Boolean=True): String;
var infDd: String;
    i: Integer;
begin
  infDd := Trim(pDado);
  if pUpperCase
     then infDd := AnsiUpperCase(infDd);
  Result := '';
  for i := 1 to Length(infDd)
  do if Pos(infDd[i],pValid) > 0
        then Result := Result + infDd[i];

end;

// Troca os caracteres contidos em pCarac pelos correspondentes em pTroca, Resultando o pDado alterado
Function  TrocaCaracteres(var pDado:String; pCarac:String; pTroca:String): Boolean;
var i,n: Integer;
begin
  Result := False;
  if Length(pCarac) <> Length(pTroca)
  then begin
    while Length(pCarac) > Length(pTroca)
    do pTroca := pTroca + '_';
    while Length(pTroca) > Length(pCarac)
    do pCarac := pCarac + '-';
  end;
  //
  for i := 1 to Length(Trim(pDado))
  do begin
    n := Pos(pDado[i], pCarac);
    if n > 0
      then pDado[i] := pTroca[n];
  end;

end;


// Edita valor, trocando ',' por '.'  (para dados da NFe, arquivo texto)
Function ValorTxt(pValor:Real;pTam,pPrec:Integer;pProcura:String=','): String;
var wAux: String;
    pPos: Integer;
    xTroca: Char;
begin
  if pProcura = '.'
  then xTroca := ','
  else begin
    pProcura := ',';
    xTroca   := '.';
  end;
  //
  wAux  := FloatToStrF(pValor, ffFixed, pTam, pPrec);
  pPos  := Pos(pProcura,wAux);
  while pPos > 0
  do begin
    wAux[pPos] := xTroca;
    pPos       := Pos(pProcura,wAux);
  end;
  Result := wAux;

end;


Function Retira_CRLF(pDado:String): String;
var i: Integer;
begin
  Result := '';
  for i := 1 to Length(pDado)
  do if (pDado[i] <> #13) and (pDado[i] <> #10)
     then Result := Result + pDado[i]
     else Result := Result + ' ';

end;


Function RetiraEspacos(pDado:String;pUpper:Boolean): String;
var i: Integer;
begin
  if pUpper then pDado := AnsiUpperCase(pDado);
  Result := '';
  for i := 1 to Length(pDado)
  do if pDado[i] <> ' '
     then Result := Result + pDado[i];

end;


Function FormataNomes(pmtTexto:String; pmtFormata:Boolean=False): String;
var np: Integer;
    txtAux,txtParc: String;
begin
  Result := '';
  txtAux := Trim(pmtTexto);
  np     := Pos(' ',txtAux);
  while np > 0
  do begin
    txtParc := Copy(txtAux,1,np);
    if pmtFormata
       then txtParc := AnsiUpperCase(Copy(txtParc,1,1)) + AnsiLowerCase(Copy(txtParc,2,Length(txtParc)-1));
    Result := Result + txtParc;
    txtAux := Trim(Copy(txtAux,np+1,Length(txtAux)-np));
    np     := Pos(' ',txtAux);
  end;
  if pmtFormata
     then txtAux := AnsiUpperCase(Copy(txtAux,1,1)) + AnsiLowerCase(Copy(txtAux,2,Length(txtAux)-1));
  Result := Result + txtAux;

end;


Function EditaFone(pDDd,pFone:String): String;
var wTam: Integer;
    xFone: String;
begin
  Result := '';
  if Length(Trim(pDDd)) > 0
  then Result := '(' + pDDd + ')';
  xFone := Trim(pFone);
  wTam := Length(xFone);
  case wTam of
    8:Result := Result + Copy(xFone,1,4) + '-' + Copy(xFone,5,4);
    9:Result := Result + Copy(xFone,1,5) + '-' + Copy(xFone,6,4);
    else Result := Result + xFone;
  end;

end;


Function  ValidaNumeroFone(pmtFone:String;var pmtRetorno:String;pmtExterior:Boolean = False): Boolean;
var wNroFone: String;
    nMais,i: Integer;
begin
  Result     := False;
  pmtRetorno := '';
  nMais      := 0;
  wNroFone   := '';
  for i := 1 to Length(pmtFone)
  do if (pmtFone[i] >= '0') and (pmtFone[i] <= '9')
     then wNroFone := wNroFone + pmtFone[i]
     else if pmtFone[i] = '+'
          then nMais      := nMais + 1                              // Conta "+"
          else pmtRetorno := pmtRetorno + pmtFone[i];               // Caracter inválido
  //
  if nMais > 1
     then pmtRetorno := pmtRetorno + '+';
  if Length(Trim(pmtRetorno)) > 0
  then begin
    pmtRetorno := 'Caracter[es] inválido[s] [' + pmtRetorno + '] [' + pmtFone + '] "0,1,2,3,4,5,6,7,8,9,+"';
    Exit;
  end;
  //
  if pmtExterior
  then begin
    Result := True;
    Exit;
  end;
  //
  case Length(Trim(wNroFone)) of
    8:if (wNroFone[1] < '2') or (wNroFone[1] > '5')
      then pmtRetorno := 'Telefone fixo inválido [' + wNroFone + '] iniciar por 2, 3, 4 ou 5';
    9:if (wNroFone[1] < '6') or (wNroFone[1] > '9')
      then pmtRetorno := 'Telefone móvel (celular) inválido [' + wNroFone + '] iniciar por 6, 7, 8 ou 9';
    else pmtRetorno := 'Número de telefone inválido [' + wNroFone + '] deve ter 8 ou 9 dígitos';
  end;
  //
  if Length(Trim(pmtRetorno)) = 0
  then begin
    Result  := True;
    Exit;
  end;

end;


Function  AjustaNumeroFone(var pmtFone:String): Boolean;
var wAuxil,wFone: String;
    i: Integer;
begin
  Result  := False;
  wAuxil  := Trim(pmtFone);
  wFone   := '';
  for i   := 1 to Length(wAuxil)
  do if Pos(wAuxil[i],'0123456789') > 0
     then wFone := wFone + wAuxil[i];
  if Length(wFone) > 9
     then wFone := Copy(wFone,1,9);
  if Length(wFone) = 7
  then pmtFone := '3' + wFone
  else if (Length(wFone) = 8)
          and ((wFone[1] >= '6') and (wFone[1] <= '9'))
          then pmtFone := '9' + wFone;
  Result    := True;

end;


Function  PrimeiroCaracterMaiusculo(pArgum:String): String;
var auxTxt: String;
begin
  Result := '';
  auxTxt := Trim(pArgum);
  if Length(auxTxt) = 0
     then Exit;
  Result := AnsiUpperCase(Copy(auxTxt,1,1)) + Copy(auxTxt,2,Length(auxTxt)-1);

end;


Function ConexaoInternet(pMsg:Boolean): Boolean;
var wFlags: Cardinal;
begin
  if not InternetGetConnectedState(@wFlags, 0)
  then begin
    Result := False;
    if pMsg
    then MessageDlg('Não há conexão ativa de internet' + #13
                    +'Revise sua conexão e tente novamente dentro de alguns instantes'
                    ,mtError,[mbOk],0);
  end
  else Result := True;

end;


Function ConexaoInternet2(pMsg:Boolean): Boolean;
var dwConnectionTypes: DWord;
begin
  dwConnectionTypes := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN + INTERNET_CONNECTION_PROXY;
  Result := InternetGetConnectedState(@dwConnectionTypes, 0);
  if not Result
  then if pMsg
       then MessageDlg('Não há conexão ativa de internet' + #13
                       +'Revise sua conexão e tente novamente dentro de alguns instantes'
                       ,mtError,[mbOk],0);

end;


Function EditaChaveNFe(pArgum:String; pEditaVazio:Boolean = False): String;
begin
  Result := Numerico(pArgum);
  if (Length(Trim(Result)) = 0)
     and (not pEditaVazio)
     then Exit;
  while Length(Result) < 44
  do Result := ' ' + Result;
  Result := Copy(Result,1,4) + '.'
            + Copy(Result,5,4) + '.'
            + Copy(Result,9,4) + '.'
            + Copy(Result,13,4) + '.'
            + Copy(Result,17,4) + '.'
            + Copy(Result,21,4) + '.'
            + Copy(Result,25,4) + '.'
            + Copy(Result,29,4) + '.'
            + Copy(Result,33,4) + '.'
            + Copy(Result,37,4) + '.'
            + Copy(Result,41,4);

end;


Function DecodificaChaveNFe(pChaveNFe:String;
                            var rUF:String; var rAno:String; var rMes:String;
                            var rCNPJ:String; var rMod:String; var rSerie:String; var rNumero:String;
                            var rEmissao:String; var rCodNum:String; var rDV:String): Boolean;
begin
  Result   := False;
  rUF      := '';
  rAno     := '';
  rMes     := '';
  rCNPJ    := '';
  rMod     := '';
  rSerie   := '';
  rNumero  := '';
  rEmissao := '';
  rCodNum  := '';
  rDV      := '';
  if Length(Trim(pChaveNFe)) = 44
  then begin
    rUF      := Copy(pChaveNFe,1,2);
    rAno     := Copy(pChaveNFe,3,2);
    rMes     := Copy(pChaveNFe,5,2);
    rCNPJ    := Copy(pChaveNfe,7,14);
    rMod     := Copy(pChaveNFe,21,2);
    rSerie   := Copy(pChaveNfe,23,3);
    rNumero  := Copy(pChaveNFe,26,9);
    rEmissao := Copy(pChaveNFe,35,1);
    rCodNum  := Copy(pChaveNFe,36,8);
    rDV      := Copy(pChaveNFe,44,1);
    Result  := True;
  end;

end;


Function ValidaTextoNFe(pTexto:String): Boolean;
var i: Integer;
const xValid: string = (' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_:=-');
begin
  Result := True;
  for i := 1 to Length(pTexto)
  do if Pos(pTexto[i],xValid) = 0
     then begin
       Result := False;
       Break;
     end;

end;


Function ProcessoAtivo(pNomeProcesso:String; pMsg:Boolean): Boolean;
const PROCESS_TERMINATE = $0001;
var vSnapShot: THandle;
    vProcessos: TProcessEntry32;
    wProc,xProcesso: String;
begin
  wProc := UpperCase(pNomeProcesso);
  Result := False;
  vSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  Try
    vProcessos.dwSize := sizeof(vProcessos);
    if not Process32First(vSnapShot, vProcessos)
       then Exit;
    Repeat
      xProcesso := vProcessos.szExeFile;
      if UpperCase(xProcesso) = wProc
         then Result := True;
      until not Process32Next(vSnapshot, vProcessos);
  Finally
    CloseHandle(vSnapshot);
  End;
  if (not Result) and pMsg
  then MessageDlg('Processo [ ' + pNomeprocesso + ' ] não está ativo no momento'
                  ,mtWarning,[mbOk],0);

end;


Function CarregaProcesso(pPathExec,pNomeProcesso:String): Boolean;
var cmdExec: String;
begin
  Result := False;
  cmdExec := AjustaPathBarraFinal(pPathExec,True) + pNomeProcesso;
  if not FileExists(cmdExec)
  then begin
    MessageDlg('Executável não encontrado' + #13
               + 'Verifique a existencia do executável' + #13
               + '[ ' + cmdExec + ' ]'
               ,mtError,[mbOk],0);
    Exit;
  end;
  EncadeamentoExecutavel(cmdExec,'');
  Result := True;

end;


Function CopiaArquivo(pmtOrig,pmtDest:String;
                      pmtExclueOrigem: Boolean = False;
                      pmtExibeMsg: Boolean = False): Integer;
var Origem,Destino: TFileStream;
begin
  Result := -1;
  if not FileExists(pmtOrig)
  then begin
    if pmtExibeMsg
    then MessageDlg('Origem [' + pmtOrig + '] não encontrada',mtError,[mbOk],0);
    Exit;
  end;
  //
  if FileExists(pmtDest)
  then Try
         DeleteFile(pmtDest);
       Except
         MessageDlg('Destino não pode ser substituído [' + pmtDest + ']',mtError,[mbOk],0);
         Exit;
       End;
  //
  Try
    Origem  := TFileStream.Create(pmtOrig,fmOpenRead);
    Destino := TFileStream.Create(pmtDest, fmCreate);
    Destino.CopyFrom(Origem, Origem.Size);
    Result  := 0;
  Except
    MessageDlg('Não foi possivel gerar copia do arquivo [' + pmtDest + ']',mtError,[mbOk],0);
  End;
  Try
    Origem.Free;
    Destino.Free;
  Except
  End;
  //
  if (Result = 0) and pmtExclueOrigem
  then Try
         DeleteFile(pmtOrig);
       Except
         Result := -1;
       End;

end;


Function CalculaPercentual(pValor,pPerc:Real;pArred:Integer = 2):Real;
// Retorna o valor correspondente ao percentual
// pValor: Valor a ser considerado
// pPerc:  Percentual a ser considerado
// pArred: Arredondamento (0 a 5) Default = 2
var wAux: Real;
const DArr: array[0..5] of Real = (0.5, 0.05, 0.005, 0.0005, 0.00005, 0.000005);
      Mult: array[0..5] of Integer = (1, 10, 100, 1000, 10000, 100000);
begin
  if (pValor = 0) or (pPerc = 0)
  then begin
    Result := 0;
    Exit;
  end;
  if pArred < 0
  then pArred := 0
  else if pArred > 5
       then pArred := 5;
  if pPerc = 100
     then wAux := pValor + DArr[pArred]
     else wAux   := ((pValor * pPerc) / 100) + DArr[pArred];
  wAux   := Int(wAux * Mult[pArred]);
  Result := wAux / Mult[pArred];
end;

Function CalculaPercTrunca(pValor,pPerc:Real;pArred:Integer = 2):Real;
// Retorna o valor correspondente ao percentual   ---  Rotina TRUNCA o calculo
// pValor: Valor a ser considerado
// pPerc:  Percentual a ser considerado
// pArred: Arredondamento (0 a 5) Default = 2
var wAux: Real;
    wInt: Integer;
const DArr: array[0..5] of Real = (0.5, 0.05, 0.005, 0.0005, 0.00005, 0.000005);
      Mult: array[0..5] of Integer = (1, 10, 100, 1000, 10000, 100000);
begin
  if (pValor = 0) or (pPerc = 0)
  then begin
    Result := 0;
    Exit;
  end;
  if pArred < 0
  then pArred := 0
  else if pArred > 5
       then pArred := 5;
  if pPerc = 100
     then wAux := pValor + DArr[pArred]
     else wAux   := ((pValor * pPerc) / 100) + DArr[pArred];
  wInt   := Trunc(wAux * Mult[pArred]);
  Result := wInt / Mult[pArred];
end;

Function  ObtemPorcentagem(pVlr100,pVlrInf:Real;pArred:Integer):Real;
// Retorna o percentual de pInf em relação à pVlr
// pVlr100: Valor a ser considerado (100%)
// pInf: Valor do qual deve ser obtido o %
// pArred: Arredondamento (0 a 5)
var wAux: Real;
const DArr: array[0..5] of Real = (0.5, 0.05, 0.005, 0.0005, 0.00005, 0.000005);
      Mult: array[0..5] of Integer = (1, 10, 100, 1000, 10000, 100000);
begin
  Result := 0;
  if (pVlr100 > 0) and (pVlrInf > 0)
  then begin
    if pArred < 0
    then pArred := 0
    else if pArred > 5
         then pArred := 5;
    wAux := ((pVlrInf * 100) / pVlr100) + DArr[pArred];
    wAux := Int(wAux * Mult[pArred]);
    Result := wAux / Mult[pArred];
  end;

end;



Function Potenciacao(pVlr:Real;pPot:Integer):Real;
// pVlr: Valor a ser elevado na potencia indicada
// pPot: Potencia
// Retorna Vlr elevado na potencia Pot
var i: Integer;
begin
  Result := 0;
  if pPot > 0
  then begin
    Result := pVlr;
    for i := 1 to (pPot-1) do Result := Result * pVlr;
  end;

end;


Function Fatorial(pNro:Integer): Integer;
begin
  Result := pNro;
  while pNro > 2
  do begin
    pNro := pnro - 1;
    Result := Result * pNro;
  end;

end;


Procedure CalculaParcelamento(pValorInicial:Real; pNrParc:Integer; pTaxa:Real; pTpTaxa:String;
                              var rAcrescimo:Real;   var rValorFinal:Real;
                              var rVlrPrimeira:Real; var rVlrParcela:Real);
{  pValorInicial: Valor inicial
   pNrParc:       Nr. de parcelas
   pTaxa:         Taxa de juros
   pTpTaxa:       Tipo de taxa (T)axa     - Taxa única (de serviço)
                               (M)ensal   - Juro simples mensal
                               (C)omposto - Juro composto mensal
   rAcrescimo:    Valor do acrescimo total
   rValorFinal:   Valor final (Inicial + Acrescimo)
   rVlrPrimeira:  Valor da 1a. parcela
   rVlrParcela:   Valor das demais parcelas  }
var iVlrFinal,iParcela,iPrimeira,iResto,iAcrescimo,iVlrInicial: Integer;
begin
  rAcrescimo   := 0;
  rValorFinal  := pValorInicial;
  rVlrPrimeira := pValorInicial;
  rVlrParcela  := 0;
  if pNrParc = 0
     then Exit;
  //
  if pTpTaxa = 'C'
  then begin        // Juro composto
    rValorFinal := pValorInicial * Power((1+(pTaxa/100)), pNrParc);
    rAcrescimo  := rValorFinal - pValorInicial;
  end
  else begin
    if pTpTaxa = 'T'
    then rAcrescimo := CalculaPercentual(pValorInicial, pTaxa, 2)               // Taxa de serviço
    else rAcrescimo := CalculaPercentual((pValorInicial * pNrParc), pTaxa, 2);  // Juro simples
    rValorFinal := pValorInicial + rAcrescimo;
  end;
  //
  // Calculo em valores inteiros
  iVlrInicial := Trunc(pValorInicial * 100);
  iVlrFinal   := Trunc(rValorFinal * 100);
  iAcrescimo  := Trunc(rAcrescimo * 100);
  if iAcrescimo <> (iVlrFinal - iVlrInicial)
     then iAcrescimo := iVlrFinal - iVlrInicial;
  iParcela     := iVlrFinal div pNrParc;
  iResto       := iVlrFinal mod pNrParc;
  iPrimeira    := iParcela + iResto;
  //
  rVlrPrimeira := iPrimeira / 100;
  rVlrParcela  := iParcela / 100;
  rAcrescimo   := iAcrescimo / 100;

end;



// Calcula Coeficiente para obtenção de valor de prestação
Function CoeficienteParcela(pTxJur:Real;pNPer:Integer): Real;
{  Parametros: pTxJur - Taxa de juros do período
               pNPer  - Nr. de períodos
   Retorno: Coeficiente de multiplicação com 6 (seis) decimais  (0.000000)   }
var wJur,wRet: Real;
    iRet: Integer;
begin
  if pTxJur = 0
  then begin
    Result := 0;
    Exit;
  end;
  wJur := pTxJur / 100;        // Taxa de juros (centesimal)
  wRet := wJur / (1-(1/Power((1+wJur),pNPer)));
  iRet := Trunc(wRet * 1000000);
  Result := iRet / 1000000;

end;


Function DiaUtil(pmtData:TDateTime): Boolean;
// Verifica se data é dia útil
// Parametros  pmtData: Data a ser verificada
//             pmtCadFer: True->Verifica no cadastro de feriados, False->Não verifica no cadastro de feriados
// Retorno: True->Dia útil        False->Não é dia útil
var wDiaSemana,i: Integer;
    wAa: Word;
const xDiaMes: array[1..8,1..2] of word = ((1,1),(21,4),(1,5),(7,9),(12,10),(2,11),(15,11),(25,12));   // Dias dos feriados fixos
//const xDia: array[1..8] of word = (1,21,1,7,12,2,15,25);   // Dias dos feriados fixos
//      xMes: array[1..8] of word = (1,4,5,9,10,11,11,12);   // Meses dos feriados fixos
begin
  Result := True;                                                // Dia útil...
  pmtData := DateOf(pmtData);                                    // Retira as informações fracionárias da data
  // Se dia da semana é Domingo(1) ou Sábado(7)
  // Feriados considerados: 01/01 1.Janeiro     21/04 Tiradentes    01/05 Trabalho      07/09 Independencia
  //                        12/10 NS Aparecida  02/11 Finados       15/11 Republica     25/12 Natal
  //                        NÃO considera FERIADOS VARIÁVEIS !!!
  //
  wDiaSemana := DayOfWeek(pmtData);                              // Dia da semana (1-Dom, 2-Seg...., 7-Sáb)
  if (wDiaSemana = 1) or (wDiaSemana = 7)
  then begin          // Domingo ou Sábado, não é dia útil
    Result := False;
    Exit;
  end;
  wAa := YearOf(pmtData);                                        // Ano da data
  for i := 1 to 8
  do if pmtData = EncodeDate(wAa,xDiaMes[i,2],xDiaMes[i,1])
     then begin
       Result := False;      // Feriado fixo, não é dia útil
       Break;
     end;

end;


Function CalculaValorAtual(pVlrEmissao,pVlrDesconto,pPcJuros,pVlrMulta,pVlrPago:Real;
                           pTipoJuros:Integer;
                           pDtVencto,pDtDesconto,pDtCalculo:TDateTime;
                           pConcDesc:Boolean = False): Real;
{
  Calculo da dívida atualizada de um documento, retornando valor
    Parametros:
       pVlrEmissao  -> Valor nominal do titulo, emissão
       pVlrDesconto -> Valor do desconto,
       pPcJuros     -> % de juros (cfe. Diario ou Mensal),
       pcVlrMulta   -> Valor da multa
       pVlrPago     -> Valor anteriormente pago ((capital+juros)-descontos)
       pTipoJuros   -> Tipo de juros (0-Sem juros, 1-Diario, 2-Mensal),
       pDtVencto    -> Data de vencimento considerado, verificar ANTES se é FERIADO
       pDtDesconto  -> Data limite para desconto,
       pDtCalculo   -> Data atual (para cálculo)
       pConcDesc    -> Conceder o desconto ?
    Resultado:
       Valor do titulo atualizado, considerando descontos, multa e juros
    Uso: VlrDivida :=  CalculaValorAtual(pVlrEmissao, pVlrDesconto, pPcJuros, pVlrPago,
                                         pTipoJuros,
                                         pDtVencto, pDtDesconto, pDtCalculo, False)
}

var nDias: Integer;
    wDesconto,wJuros: Real;
begin
  while not DiaUtil(pDtVencto)
    do pDtVencto := pDtVencto + 1;      // Se data NÃO é dia útil, adianta um dia na data de vencimento
  wDesconto   := 0;
  nDias       := 0;
  pDtVencto   := DateOf(pDtVencto);
  pDtCalculo  := DateOf(pDtCalculo);
  pDtDesconto := DateOf(pDtDesconto);
  if pDtCalculo > pDtVencto
  then nDias  := DaysBetween(pDtCalculo, pDtVencto)     // Operação APÓS o vencimento
  else begin                                            // Operação ATÉ o vencimento
    if pDtCalculo <= pDtDesconto
       then wDesconto := pVlrDesconto;
    pConcDesc := False;
  end;
  //Result := pVlrEmissao - (pVlrPago + wDesconto);     // Vlr. nominal no momento
  Result := pVlrEmissao - wDesconto;                    // Vlr. nominal no momento

  // Verifica se há juros (Tipo > 0) e se há atraso (nDias > 0)
  wJuros  := 0;
  if (pTipoJuros > 0) and (nDias > 0)
  then begin
    wJuros := CalculaPercentual(Result, pPcJuros, 2);
    if pTipoJuros = 2
       then wJuros := (Trunc((wJuros/30)*100) / 100) * nDias;
  end;
  Result := Result + wJuros;

  // Se houve atraso, considerar o valor da multa
  if nDias > 0 then Result := Result + pVlrMulta;

  // Se há concessão de desconto
  if pConcDesc then Result := Result - pVlrDesconto;

  // Valor final
  Result := Result - pVlrPago;

  if Result < 0 then Result := 0;

end;


procedure CalculaParcelasRestantes(pmtParc,pmtMaxParc:Integer; pmtTotal:Real; var pmtValores: array of Real; var vlrSoma: Real);
var i,nParc,iValor,iVlrParc,iResto,pMax: Integer;
    vlrUsado,vlrRestante: Real;
begin
  if pmtParc = pmtMaxParc
  then begin
    vlrUsado := 0;
    for i := 0 to pmtParc-2
      do vlrUsado := vlrUsado + pmtValores[i];
    pmtValores[pmtMaxParc-1] := pmtTotal - vlrUsado;
    vlrSoma := 0;
    for i := 0 to pmtParc-1
      do vlrSoma := vlrSoma + pmtValores[i];
    Exit;
  end;
  vlrUsado  := 0;
  pMax      := pmtParc-1;
  for i := 0 to pMax
    do vlrUsado := vlrUsado + pmtValores[i];
  vlrRestante := pmtTotal - vlrUsado;
  iValor      := Trunc(vlrRestante * 100);
  nParc       := pmtMaxParc - pmtParc;
  if nParc > 0
  then begin
    iVlrParc  := iValor div nParc;
    iResto    := iValor mod nParc;
  end
  else begin
    iVlrParc  := iValor;
    iResto    := 0;
  end;
  pMax  := pmtMaxParc-1;
  for i := pmtParc to pMax
  do begin
    pmtValores[i] := (iVlrParc + iResto) / 100;
    iResto        := 0;
  end;
  vlrSoma := 0;
  for i := 0 to pMax
    do vlrSoma := vlrSoma + pmtValores[i];

end;


Procedure MontaTextosPesquisa(pmtTexto:String);
var xTexto: String;
    i,np: Integer;
    carSeparador: String;
begin
  for i := 1 to Length(FuFuncoes.txComp)
      do FuFuncoes.txComp[i] := '';
  xTexto := Trim(pmtTexto);
  carSeparador := ' ';
  if Pos(';',xTexto) > 0
     then carSeparador := ';';
  i  := 1;
  np := Pos(carSeparador, xTexto);
  while np > 0
  do begin
     FuFuncoes.txComp[i] := Copy(xTexto,1,np-1);
     xTexto         := Trim(Copy(xTexto,np+1,Length(xTexto)-np));
     np             := Pos(carSeparador, xTexto);
     i              := i + 1;
     if i > Length(FuFuncoes.txComp)
        then np := 0;
  end;
  if (Length(xTexto) > 0) and (i < Length(FuFuncoes.txComp)+1)
     then FuFuncoes.txComp[i] := xTexto;
  FuFuncoes.txSel := 0;
  for i := 1 to Length(FuFuncoes.txComp)
  do if Length(FuFuncoes.txComp[i]) > 0
     then FuFuncoes.txSel := FuFuncoes.txSel + 1;

end;


Procedure CalculaParcelas(pParcMax,pParcAtu,pDec:Integer);
{
   pParcMax:  Nr.máximo de parcelas da operação
   pParcAtu:  Parcela atual informada
   pDec    :  Fator de arredondamento (1 a 6)
   os valores de cada parcela devem ser informados em FuFuncoes.CP_vlParc, até um máximo de 36 parcelas (0-Total)
}
var i,iFator,iSoma,iFalta: Integer;
    np,iParcela,iResto: Integer;
    iValores: array of Integer;
begin
  if pParcAtu > pParcMax
     then Exit;
  //
  case pDec of
    1: iFator := 10;
    2: iFator := 100;
    3: iFator := 1000;
    4: iFator := 10000;
    5: iFator := 100000;
    6: iFator := 1000000;
    else iFator := 100;
  end;
  //
  setLength(iValores, pParcMax);                          // Define array de trabalho
  for i := 0 to pParcMax
     do iValores[i] := Trunc(FuFuncoes.CP_vlParc[i] * iFator);
  //
  iSoma := 0;
  for i := 1 to pParcAtu                                  // Soma das parcelas informadas
     do iSoma := iSoma + iValores[i];
  //
  np := pParcMax - pParcAtu;                              // Nr. de parcelas faltantes
  iFalta := iValores[0] - iSoma;                          // Valor que falta a distribuir entre as parcelas posteriores
  if iFalta <= 0
     then Exit;
  //
  iParcela := iFalta div np;
  iResto   := iFalta mod np;
  for i := pParcAtu+1 to pParcMax
    do iValores[i] := iParcela;
  iValores[pParcMax] := iValores[pParcmax] + iResto;
  //
  for i := 0 to pParcMax
    do FuFuncoes.CP_vlParc[i] := iValores[i] / iFator;


end;


Function ContaArquivos(pDiretorio, pMascara:string): Integer;
var  wRec: TSearchRec;
     wFind,wCount: Integer;
begin
  wCount := 0;
  wFind  := SysUtils.FindFirst(pDiretorio+pMascara, faAnyFile, wRec);
  while wFind = 0
  do begin
    inc(wCount);
    wFind := SysUtils.FindNext(wRec)
  end;
  SysUtils.FindClose(wRec);
  Result := wCount;

end;


Function  AtribueArrayInteger(inpArray: array of Integer; var outArray: array of Integer): Boolean;
var i,j: Integer;
begin
  Result := False;
  if Length(outArray) < Length(inpArray)
     then Exit;
  j := Low(outArray);
  for i := Low(inpArray) to High(inpArray)
  do begin
    outArray[j] := inpArray[i];
    j           := j + 1;
  end;
  Result := True;

end;


Function  SN_Boolean(pArgum: String): Boolean;
begin
  if AnsiUpperCase(pArgum) = 'S'
     then Result := True
     else Result := False;

end;


Function  Boolean_SN(pArgum: Boolean): String;
begin
  if pArgum then Result := 'S'
            else Result := 'N';

end;


Function CalculaAlgoritmoSeguranca(pArgumento1,pArgumento2,pArgumento3,pArgumento4:String; pValidade:TDateTime):Integer;
// Calcula o algoritmo de segurança
// pArgumento1:  Empresa usuária
// pArgumento2:  Nome fantasia
// pArgumento3:  CNPJ
// pArgumento4:  Inscr.Estadual
// pValidade:    Data de validade
// Retorna o algoritmo calculado
var i,j,NPos: Integer;
    xString,wString,xMM,xDD,xAA: String;
begin
  xString := chr(255);
  for i :=  254 downto 1 do xString := xString + chr(i);
  xDD   := stringCompleta(IntToStr(DayOf(pValidade)),'E','0',2);
  xMM   := stringCompleta(IntToStr(MonthOf(pValidade)),'E','0',2);
  j     := YearOf(pValidade);
  if j < 2000
     then j := j + 2000;
  xAA   := IntToStr(j);
  wString := '**' + Trim(pArgumento1) + '**' + Trim(pArgumento2) +
             '**' + Trim(pArgumento3) + '**' + Trim(pArgumento4) +
             '**' + xDD + '/' + xMM + '/' + xAA + '**';
  Result  := 0;
  for i := 1 to Length(wString)
  do begin;
    nPos   := Pos(wString[i],xString);
    j      := (nPos*nPos) * 2;
    Result := Result + j;
  end;

end;


Function ValorExtenso(Vlr:Real; Tam:Integer; lMF:Boolean):String;
{ Parametros : Vlr  - a ser convertido (Real) (Max 999.999.999.999.999,99)
              Tam  - Tamanho do texto a ser retornado
              lMF  - True("DOIS")  False("DUAS")
  Retorno    : Valor por extenso     }
var partes: Array[1..6] of String;
    interm: Array[1..6] of String;
    Itext, Dtext, TxParc, TxFinal, ETx: String;
    VlInt, VlDec, PVirg:  Integer;
    ger, dun, cem, dez, uni, i, cond:  Integer;
    ValorInt:  Real;
    unicos: array[1..20] of String;
    dezena: Array[1..9] of String;
    centen: Array[1..9] of String;
    milsing: Array[1..6] of String;
    milplur: Array[1..6] of String;
    moneysing: array[1..2] of String;
    moneyplur: array[1..2] of String;

begin;
  Result := 'Valor INCORRETO! Superior a 999 trilhões';
  if Vlr > 999999999999999 then Exit;
  Itext := '';

  unicos[1] := 'um';
  unicos[2] := 'dois';
  unicos[3] := 'tres';
  unicos[4] := 'quatro';
  unicos[5] := 'cinco';
  unicos[6] := 'seis';
  unicos[7] := 'sete';
  unicos[8] := 'oito';
  unicos[9] := 'nove';
  unicos[10] :='dez';
  unicos[11] := 'onze';
  unicos[12] := 'doze';
  unicos[13] := 'treze';
  unicos[14] := 'quatorze';
  unicos[15] := 'quinze';
  unicos[16] := 'dezesseis';
  unicos[17] := 'dezessete';
  unicos[18] := 'dezoito';
  unicos[19] := 'dezenove';
  unicos[20] := 'vinte';

  dezena[1] := 'dez';
  dezena[2] := 'vinte';
  dezena[3] := 'trinta';
  dezena[4] := 'quarenta';
  dezena[5] := 'cinquenta';
  dezena[6] := 'sessenta';
  dezena[7] := 'setenta';
  dezena[8] := 'oitenta';
  dezena[9] := 'noventa';

  centen[1] := 'cem';
  centen[2] := 'duzentos';
  centen[3] := 'trezentos';
  centen[4] := 'quatrocentos';
  centen[5] := 'quinhentos';
  centen[6] := 'seiscentos';
  centen[7] := 'setecentos';
  centen[8] := 'oitocentos';
  centen[9] := 'novecentos';

  milsing[1] := ' trilhão';
  milsing[2] := ' bilhão';
  milsing[3] := ' milhão';
  milsing[4] := ' mil';
  milsing[5] := '';
  milsing[6] := '';

  milplur[1] := ' trilhões';
  milplur[2] := ' bilhões';
  milplur[3] := ' milhões';
  milplur[4] := ' mil';
  milplur[5] := '';
  milplur[6] := '';

  moneysing[1] := ' real';
  moneysing[2] := ' centavo';

  moneyplur[1] := ' reais';
  moneyplur[2] := ' centavos';

  if not lMF then
  begin
    moneysing[1] := '';
    moneysing[2] := ' centésimo';

    moneyplur[1] := '';
    moneyplur[2] := ' centésimos';

    unicos[1] := 'uma';
    unicos[2] := 'duas';

    centen[2] := 'duzentas';
    centen[3] := 'trezentas';
    centen[4] := 'quatrocentas';
    centen[5] := 'quinhentas';
    centen[6] := 'seiscentas';
    centen[7] := 'setecentas';
    centen[8] := 'oitocentas';
    centen[9] := 'novecentas';
  end;
  Itext := Trim(FloatToStr(Vlr));
  VlInt := length(Itext);
  PVirg := pos(',',Itext);
  if PVirg = 0 then PVirg := VlInt;
  VlDec := VlInt - PVirg;
  if VlDec = 0 then Itext := Itext + ',00';
  if VlDec = 1 then Itext := Itext + '0';
  if VlDec > 2 then
  begin
    Result := 'Valor INCORRETO! Mais de duas casas decimais !!!';
    Exit;
  end;
  PVirg := pos(',',Itext);
  Dtext := Copy(Itext, PVirg+1, 2);
  VlDec := StrToInt(Dtext);                   // Valor decimal do numero
  Itext := Copy(Itext, 1, PVirg-1);
  while length(Itext) < 15 do Itext := '0' + Itext;
  ValorInt := StrToFloat(Itext);              // Valor inteiro do numero
  partes[1] := Copy(Itext,1,3);
  partes[2] := Copy(Itext,4,3);
  partes[3] := Copy(Itext,7,3);
  partes[4] := Copy(Itext,10,3);
  partes[5] := Copy(Itext,13,3);
  partes[6] := '0' + Dtext;
  TxFinal := '';
  for i := 1 to 6 do
  begin
    interm[i] := '';
    ger := StrToInt(Partes[i]);           // Vlr. da parte (3 digitos)
    if ger > 0
    then begin
      TxParc := '';
      uni := StrToInt(Copy(Partes[i],3,1));  // Dig. unidade
      dez := StrToInt(Copy(Partes[i],2,1));  // Dig. dezena
      cem := StrToInt(Copy(Partes[i],1,1));  // Dig. centena
      dun := StrToInt(Copy(Partes[i],2,2));  // Dezena + Unidade
      cond := 3;
      if ger < 200 then cond := 2;
      if ger < 100 then cond := 1;
      if ger < 21  then cond := 0;
      if ger = 100 then cond := 3;
      case cond of
        0: TxParc := unicos[ger];        // Vlr. de 1 a 20
        1: begin                         // Vlr. de 21 a 99
             TxParc := dezena[dez];
             if uni > 0 then TxParc := TxParc + ' e ' + unicos[uni];
           end;
        2: begin                         // Vlr de 101 a 199
             TxParc := 'cento e ';
             if dun < 21                    // Dezena/Unidade < 21
             then TxParc := TxParc + unicos[dun]
             else begin                     // dezena/unidade > 20
                    TxParc := TxParc + dezena[dez];
                    if uni > 0 then TxParc := TxParc + ' e ' + unicos[uni];
                  end;
           end;
        3: begin                         // Vlr = 100 ou > 199
             TxParc := centen[cem];
             if dun > 20
             then begin
                    TxParc := TxParc + ' e ' + dezena[dez];
                    if uni > 0 then TxParc := TxParc + ' e ' + unicos[uni];
                  end
             else if dun > 0
                  then if dun < 21 then TxParc := TxParc + ' e ' + unicos[dun];
           end;
      end;
      interm[i] := TxParc;
      if ger = 1 then interm[i] := interm[i] + milsing[i]
                 else interm[i] := interm[i] + milplur[i];
    end;
  end;
  TxFinal := '';
  // Montagem do texto final
  // Tratativa da parte decimal (centavos/centesimos)
  if VlDec > 0 then if VlDec = 1 then TxFinal := moneysing[2]
                                 else TxFinal := moneyplur[2];
  TxFinal := interm[6] + TxFinal;
  // Tratativa da parte inteira
  if ValorInt > 0
  then begin
    if VlDec > 0 then TxFinal := ' e ' + TxFinal;
    if ValorInt = 1 then TxFinal := moneysing[1] + TxFinal
                    else TxFinal := moneyplur[1] + TxFinal;
    // Centena
    if length(interm[5]) > 0 then TxFinal := interm[5] + TxFinal;
    // Milhar
    if length(interm[4]) > 0 then
    begin
      ETx := '';
      if length(interm[5]) > 0 then ETx := ' e ';
      TxFinal := interm[4] + Etx + TxFinal;
    end;
    // Milhao
    if length(interm[3]) > 0 then
    begin
      Etx := '';
      if length(interm[4]) > 0 then ETx := ' e ';
      if length(interm[5]) > 0 then ETx := ' e ';
      TxFinal := interm[3] + Etx + TxFinal;
    end;
    // Bilhao
    if length(interm[2]) > 0 then
    begin
      Etx := '';
      if length(interm[3]) > 0 then ETx := ' e ';
      if length(interm[4]) > 0 then ETx := ' e ';
      if length(interm[5]) > 0 then ETx := ' e ';
      TxFinal := interm[2] + Etx + TxFinal;
    end;
    // Trilhao
    if length(interm[1]) > 0 then
    begin
      Etx := '';
      if length(interm[2]) > 0 then ETx := ' e ';
      if length(interm[3]) > 0 then ETx := ' e ';
      if length(interm[4]) > 0 then ETx := ' e ';
      if length(interm[5]) > 0 then ETx := ' e ';
      TxFinal := interm[1] + Etx + TxFinal;
    end;
    TxFinal := TxFinal + ' ';
  end;
  while Length(TxFinal) < Tam do TxFinal := TxFinal + '*';
  Result := TxFinal;

end;


Function  CalculaDiasEntreDatas(pDtInicial,pDtFinal: TDateTime): Integer;
begin
  // DaysBetween(pDtInicial, pDtFinal) --> Dias entre as duas datas
  // CompareDate(pDtInicial, pDtFinal) --> -1 se pDtInicial < pDtFinal
  //                                       0  se pDtInicial = pDtFinal
  //                                       +1 se pDtInicial > pDtFinal
  // Resultado > 0 : Data Inicial MAIOR que data final
  //           < 0 : Data inicial MENOR que data final
  //           = 0 : Datas iguais
  Result := DaysBetween(pDtInicial, pDtFinal) * CompareDate(pDtInicial, pDtFinal);

end;


Function ArredondaTrunca(pValor:Real; pDec:Integer; ArredTrunc:String): Real;
var wVlAux: Real;
const Fator: array[0..5] of integer = (1, 10, 100, 1000, 10000, 100000);
      Arred: array[0..5] of Real = (0.5, 0.05, 0.005, 0.0005, 0.00005, 0.000005);
begin
  if pDec < 0
     then pDec := 0
     else if pDec > 5
          then pDec := 5;
  if ArredTrunc = 'T'
    then wVlAux := Int(pValor * Fator[pDec])                       // Trunca
    else wVlAux := Int((pValor + Arred[pDec]) * Fator[pDec]);      // Arredonda
  Result := wVlAux / Fator[pDec];

end;


Function  TxtTpDocFiscal(pTpDoc:Integer; pAbrev:Boolean = True): String;
begin
  if pAbrev
  then begin
    case pTpDoc of
      0:Result    := '';
      1,99:Result := 'Mod 1';
      10:Result   := 'CI-M';
      11:Result   := 'CI-S';
      55:Result   := 'NFe';
      65:Result   := 'NFCe';
      97:Result   := 'CI-MS';
      98:Result   := 'NFSe';
      else Result := '*';
    end;
    Exit;
  end;
  case pTpDoc of
    0:Result    := 'S/Docto';
    1,99:Result := 'Modelo 1';
    10:Result   := 'CtleInt-Merc';
    11:Result   := 'CtleInt-Serv';
    55:Result   := 'NF Eletronica';
    65:Result   := 'NF Consumidor';
    97:Result   := 'CtleInt-Merc/Serv';
    98:Result   := 'NF Serviço';
    else Result := 'Indefinido';
  end;

end;


// Calcula fator/indice para calculo do PIS e Cofins das importações
Function CalculaFatorImportacao(aliqImport,aliqIPI,aliqPIS,aliqCOFINS,aliqICM:Real): Real;
var wAlqII,wAlqIPI,wAlqPIS,wAlqCof,wAlqICM: Real;
begin
  wAlqII  := aliqImport / 100;             // Imposto de importação
  wAlqIPI := aliqIPI /100;                 // Aliquota IPI
  wAlqPIS := aliqPIS / 100;                // Aliquota PIS
  wAlqCof := aliqCOFINS / 100;             // Aliquota Cofins
  wAlqICM := aliqICM / 100;                // Aliquota ICMS
  // Calcula 'Fator/Indice'  a ser aplicado para obter PIS e Cofins
  Result  := (1 + wAlqICM * (wAlqII + wAlqIPI * (1+wAlqII)) ) / ((1 - wAlqPIS - wAlqCof) * (1 - wAlqICM));

end;

// Trunca valor com 'n' casas decimais
Function  TruncaValor(pmtValor:Real; pmtDec:Integer = 2): Real;
var iVlr: Integer;
const iFat: array[0..6] of Integer = (1,10,100,1000,10000,100000,1000000);
begin
  iVlr := Round(pmtValor * iFat[pmtDec]);
  Result := iVlr / iFat[pmtDec];

end;
                   

Function DefineMascaraGeral(pN1:Integer; pN2:Integer = 0; pN3:Integer = 0; pN4:Integer = 0; pN5:Integer = 0): String;
var i: Integer;
begin
  Result := '';
  for i := 1 to pN1
    do Result := Result + '0';
  if pN2 > 0
  then begin
    Result := Result + '.';
    for i := 1 to pN2
    do Result := Result + '0';
    if pN3 > 0
    then begin
      Result := Result + '.';
      for i := 1 to pN3
      do Result := Result + '0';
      if pN4 > 0
      then begin
        Result := Result + '.';
        for i := 1 to pN4
        do Result := Result + '0';
        if pN5 > 0
        then begin
          Result := Result + '.';
          for i := 1 to pN5
          do Result := Result + '0';
        end;
      end;
    end;
  end;
  Result := Result + ';0; ';         // Salva constantes (.)

end;


Function ObtemDataHoraArquivo(pArquivo:String;var pDtHr:TDateTime): Boolean;
begin
  Result := False;
  pDtHr  := Now();
  if not FileExists(pArquivo)
     then Exit;
  pDtHr  := FileDateToDateTime(FileAge(pArquivo));
  Result := True;

end;


Function DataBaseState(wState:TDataSetState): String;
begin
  case wState of
    dsInactive:     Result := 'Inativo';
    dsBrowse:       Result := 'Browse';
    dsEdit:         Result := 'Edição';
    dsInsert:       Result := 'Inserção';
    dsSetKey:       Result := 'SetKey';
    dsCalcFields:   Result := 'CalcFields';
    dsFilter:       Result := 'Filtrado';
    dsNewValue:     Result := 'NewValue';
    dsOldValue:     Result := 'OldValue';
    dsCurValue:     Result := 'CurValue';
    dsBlockRead:    Result := 'BlockRead';
    dsInternalCalc: Result := 'InternalCalc';
    dsOpening:      Result := 'Opening';
    else Result := 'Desconhecido';
  end;

end;

// Obtem UF e CNPJ da chave de nfe
Function Obtem_UF_CNPJ(pKey:String; var rUF:String; var rCNPJ:String; var rMsg:String):Boolean;
var i,n: Integer;
const tbIBGE: array [1..27,1..2] of String = (('11','RR'),
                                              ('12','AC'),
                                              ('13','AM'),
                                              ('14','RO'),
                                              ('15','PA'),
                                              ('16','AP'),
                                              ('17','TO'),
                                              ('21','MA'),
                                              ('22','PI'),
                                              ('23','CE'),
                                              ('24','RN'),
                                              ('25','PB'),
                                              ('26','PE'),
                                              ('27','AL'),
                                              ('28','SE'),
                                              ('29','BA'),
                                              ('31','MG'),
                                              ('32','ES'),
                                              ('33','RJ'),
                                              ('35','SP'),
                                              ('41','PR'),
                                              ('42','SC'),
                                              ('43','RS'),
                                              ('50','MS'),
                                              ('51','MT'),
                                              ('52','GO'),
                                              ('53','DF'));
begin
  rMsg   := '';
  Result := False;
  if not ValidaChaveNFe(pKey,False)
  then begin
    rMsg := 'Chave inválida';
    Exit;
  end;
  rCNPJ := Copy(pKey,7,14);
  if not ValidaCNPJ(rCNPJ)
  then begin
    rMsg  := 'CNPJ inválido';
    Exit;
  end;
  rUF   := Copy(pKey,1,2);
  n     := -1;
  for i := 1 to 28
  do if rUF = tbIBGE[i,1]
     then begin
       n   := i;
      rUF := tbIBGE[i,2];
      Break;
     end;
  if n > 0
     then Result := True
     else rMsg := 'UF inválida';

end;


Procedure FormataArquivoIni(pArqIniName:String);
var TIniList,TFinList: TStringList;
    wLinha: String;
    i:Integer;
begin
  TIniList := TStringList.Create;
  TFinList := TStringList.Create;
  TIniList.LoadFromFile(pArqIniName);
  for i := 0 to TIniList.Count-1
  do begin
    wLinha := TIniList.Strings[i];
    if Length(Trim(wLinha)) > 0
    then begin
      if (i > 0) and (Pos('[',wLinha) = 1)
         then TFinList.Add('');
      TFinList.Add(wLinha);
    end;
  end;
  TFinList.SaveToFile(pArqIniName);
  TIniList.Free;
  TFinList.Free;

end;


Function  ExibeDebug(lExibe:Boolean; pIdMsg:String; var nOcorr: Integer): Integer;
begin
  Result := 0;
  if not lExibe then Exit;
  ShowMessage('Debug ' + Application.ExeName + #13
             +'Msg: ' + pIdMsg + ' [Ocorr=' + IntToStr(nOcorr) + ']');
  Result := nOcorr + 1;

end;


Function  ApagaLCK(pPath:String; pMsg:Boolean=False): Boolean;
var wfName: String;
    wErros: String;
begin
  Result := False;
  pPath  := AjustaPathBarraFinal(pPath, True);
  wErros := '';
  wfName := pPath + 'PARADOX.LCK';
  if FileExists(wfName)
  then if not SysUtils.DeleteFile(wfName)
       then wErros := wErros + wfName + #13;
  wfName := pPath + 'PDOXUSR.LCK';
  if FileExists(wfName)
  then if not SysUtils.DeleteFile(wfName)
       then wErros := wErros + wfName + #13;
  if Length(Trim(wErros)) > 0
  then MessageDlg('Falha na exclusão de arquivos' + #13 + wErros +
                  'Feche a aplicação e tente novamente em instantes',
                   mtError,[mbOk],0)
  else Result := True;

end;


Function  ExisteCampoNoDataSet(pmtField:String; pmtDataSet:TDataSet): Boolean;
var i: Integer;
    wField: String;
begin
  Result   := False;
  pmtField := AnsiUpperCase(pmtField);
  for i := 0 to pmtDataSet.Fields.Count-1
  do begin
    wField := AnsiUpperCase(pmtDataSet.Fields[i].FieldName);
    if pmtField = wField
    then begin
      Result := True;
      Break;
    end;
  end;

end;


Function  AtualizaLogFile(pmtFile:String; pmtLog:TStringList; pmtIniFim:Boolean = True): Boolean;
var LogOriginal: TStringList;
    i: Integer;
begin
  LogOriginal := TStringList.Create;
  Logoriginal.Clear;
  if FileExists(pmtFile)
     then LogOriginal.LoadFromFile(pmtFile);
  if pmtIniFim
  then begin            // Novo log no inicio
    pmtLog.Add(' ');
    for i := 0 to LogOriginal.Count-1
    do pmtLog.Add(Logoriginal[i]);
    pmtLog.SaveToFile(pmtFile);
  end
  else begin            // Novo log no final
    LogOriginal.Add(' ');
    for i := 0 to pmtLog.Count
    do LogOriginal.Add(pmtLog[i]);
    LogOriginal.SaveToFile(pmtFile);
  end;
  LogOriginal.Free;
  Result  := True;

end;


Procedure DebugMensagem(pDebug:Boolean; pTexto:String);
begin
  if pDebug
     then ShowMessage(pTexto);

end;


Function TempoRestanteEstimado(pHrIni:TDateTime; pQtdMax:Integer; pQtdCorr:Integer; pMiliSeg:Boolean;
                               var rDias: Integer;
                               var rHoras: Integer;
                               var rMinutos: Integer;
                               var rSegundos: Integer;
                               var rMiliSeg: Integer): String;
{  pHrIni:     DataHora de inicio
   pQtdMax:    Quantidade máxima a processar
   pQtqCorr:   Quantidade já processada
   pMiliSeg:   Exibe ou não milisegundos
   rDias:      Dias restantes
   rHoras:     Horas restantes
   rMinutos:   Minutos restantes
   rSegundos:  Segundos restantes
   rMiliSeg:   Milisegundos restantes
   Result:     Texto restante estimado (DD Hr Mi Se Ms)  }
var inicioMS,atualMS,decorrido,necessario,restante: Int64;
    xDias,xHoras,xMinutos,xSegundos,xMiliSeg: String;
    dd,mm,aa,hr,mi,se,ms: Word;
const DiaMS: Integer = 86400000;     // Milisegundos em um dia
      HoraMS: Integer = 3600000;     // Milisegundos em uma hora
      MinutoMS: Integer = 60000;     // Milisegundos em um minuto
      SegundoMS: Integer = 1000;     // Milisegundos em um segundo (óbvio)
begin
  inicioMS   := Trunc(pHrIni) * DiaMS;
  DecodeDateTime(pHrIni,aa,mm,dd,hr,mi,se,ms);
  inicioMS   := inicioMS + (hr * HoraMS) + (mi * MinutoMS) + (se * SegundoMS) + ms;  // Inicio em milisegundos
  atualMS    := Trunc(Now) * DiaMS;
  DecodeDateTime(Now,aa,mm,dd,hr,mi,se,ms);
  atualMS    := atualMS + (hr * HoraMS) + (mi * MinutoMS) + (se * SegundoMS) + ms;  // Atual em milisegundos
  //
  decorrido  := atualMS - inicioMS;                       // Tempo decorrido (MS)
  necessario := Trunc((decorrido * pQtdMax) / pQtdCorr);  // Tempo necessario (MS)
  restante   := necessario - decorrido;                   // Tempo necessario restante (MS)
  //
  rdias      := restante div DiaMS;                  // Dias necessarios
  restante   := restante mod DiaMS;                  // MS restantes
  rHoras     := restante div HoraMS;                 // Horas necessarias
  restante   := restante mod HoraMS;                 // MS restantes
  rMinutos   := restante div MinutoMS;               // Minutos restantes
  restante   := restante mod MinutoMS;               // MS restantes
  rSegundos  := restante div SegundoMS;              // Segundos restantes
  rMiliSeg   := restante mod SegundoMS;              // MS restantes
  //
  xDias         := '';
  xHoras        := '';
  xMinutos      := '00:';
  xSegundos     := '00';
  xMiliSeg      := '000';
  if rDias > 0
     then xDias := IntToStr(rDias) + 'd ';
  if rHoras > 0
  then begin
    xHoras := IntToStr(rHoras) + ':';
    if rHoras < 10 then xHoras := '0' + xHoras;
  end;
  if rMinutos > 0
  then begin
    xMinutos := IntToStr(rMinutos) + ':';
    if rMinutos < 10 then xMinutos := '0' + xMinutos;
  end;
  if rSegundos > 0
  then begin
    xSegundos := IntToStr(rSegundos);
    if rSegundos < 10 then xSegundos := '0' + xSegundos;
  end;
  if rMiliSeg > 0
  then begin
    xMiliSeg := IntToStr(rMiliSeg);
    if rMiliSeg < 10
       then xMiliSeg := '00' + xMiliSeg
       else if rMiliSeg < 100
            then xMiliSeg := '0' + xMiliSeg;
  end;
  if pMiliSeg
     then xSegundos := xSegundos + ':' + xMiliSeg;

  Result := xDias + xHoras + xMinutos + xSegundos;

end;


Function  ObtemArquivos(pmtDiretorio:String; pmtExtensao:String; var Arquivos:TStringList): Boolean;
var Arq: TSearchRec;
    Ret: Integer;
    lTodos: Boolean;
    wrkExt: String;
begin
  Result := False;
  if not DirectoryExists(pmtDiretorio)
  then begin
    MessageDlg('Diretório inexistente' + #13 + '[ ' + pmtDiretorio + ' ]',mtError,[mbOk],0);
    Exit;
  end;
  pmtExtensao := Trim(pmtExtensao);
  if Length(pmtExtensao) = 0
     then pmtExtensao := '*';
  if pmtExtensao = '*'
  then begin
    wrkExt := pmtExtensao;
    lTodos := True;
  end
  else begin
    wrkExt := '.' + pmtExtensao;
    lTodos := False;
  end;
  Arquivos.Clear;
  Ret := FindFirst(pmtDiretorio + '*.' + pmtExtensao, faAnyFile, Arq);
  while Ret = 0
  do begin
    if Pos('.',Arq.Name) > 1
    then if lTodos
            or (ExtractFileExt(Arq.Name) = wrkExt)
         then Arquivos.Add(pmtDiretorio + Arq.Name);
    Ret := FindNext(Arq);
  end;
  FindClose(Arq);
  Result := True;

end;


Procedure Identificacao(pmtTexto:String; var pmtIdentif:String);
begin
  with FuFuncoes
  do begin
    LabOperacao.Caption := pmtTexto;
    edInfo.Text         := pmtIdentif;
    FuFuncoes.ShowModal;
    pmtIdentif          := edInfo.Text;
  end;

end;


procedure TFuFuncoes.FormCreate(Sender: TObject);
begin
  lSalvaForm    := False;
  pathSalvaForm := '';

end;

procedure TFuFuncoes.btOkClick(Sender: TObject);
begin
  FuFuncoes.Close;
  
end;

procedure TFuFuncoes.btCancClick(Sender: TObject);
begin
  edInfo.Text := '';
  FuFuncoes.Close;

end;

end.
