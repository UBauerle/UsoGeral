unit uCriaArquivos;

interface

uses DBTables, SysUtils, Dialogs, Db, uGenericas, Classes, DateUtils;
     Function CriaTabelas_Venda(pPath,pPref:String;pDeletar:Boolean;var pMsg:String): Integer;
     Function TS_VerificaTabelas(pPath:String; var pMsg:String; pDebug:Boolean = False): Integer;
     Procedure VerificaTabelasVenda(pmtAnoIni:Integer; pmtDBPath:String; var tbVendas:TStringList; var tbVenDet:TStringList);

implementation

Function CriaTabelas_Venda(pPath,pPref:String;pDeletar:Boolean;var pMsg:String): Integer;
var i,nErr,nCodErr,wCod: Integer;
    dfName,Mensag: String;
    cTab: TTable;
const xNames: array [1..32] of String = (
{01...}       'Vendas.DB','Vendas.PX','Vendas.XG0','Vendas.XG1','Vendas.XG2','Vendas.XG3','Vendas.XG4',
                                      'Vendas.YG0','Vendas.YG1','Vendas.YG2','Vendas.YG3','Vendas.YG4',
{13...}       'VendLctos.DB','VendLctos.MB','VendLctos.PX','VendLctos.XG0','VendLctos.YG0',
                                                           'VendLctos.XG1','VendLctos.YG1',
{20...}       'VendNFe.DB','VendNFe.MB','VendNFe.PX',
{23...}       'VendNFis.DB','VendNFis.PX',
{25...}       'VendNFRef.DB','VendNFRef.PX',
{27...}       'VendPagto.DB','VendPagto.PX','VendPagto.XG0','VendPagto.YG0',
{31...}       'VendCard.DB','VendCard.PX'
              );
begin
  Result := 0;
  nErr   := 0;
  Mensag := '';
  pMsg   := pPath + pPref + ' ';
  pPath  := AjustaPathBarraFinal(pPath,True);
  if pDeletar
  then begin         // Excluir arquivos ?
    wCod    := 1;
    nCodErr := 0;
    for i := 1 to Length(xNames)
    do begin
      dfName := pPath + pPref + xNames[i];
      if FileExists(dfName)
      then if not DeleteFile(dfName)
           then begin
             nErr    := nErr + 1;
             nCodErr := nCodErr + wCod;
             Mensag  := Mensag + dfName + #13;
           end;
      wCod := wCod * 2;
    end;
    if nErr > 0
    then begin
      Mensag := Mensag + 'Código de erro:' + IntToStr(nCodErr) + #13;
      MessageDlg(IntToStr(nErr) + ' arquivos não puderam ser excluídos' + #13 + Mensag,
                 mtInformation,[mbOk],0);
      pMsg   := IntToStr(nErr) + ' arquivos não excluídos';
      Result := 1;
      Exit;
    end;
  end;

  nCodErr := 0;
  dfName := pPath + pPref + 'Vendas.DB';
  if not FileExists(dfName)
  then begin
    cTab := TTable.Create(nil);
    with cTab
    do begin
      Active             := False;
      DatabaseName       := AjustaPathBarraFinal(pPath,False);
      TableName          := pPref + 'Vendas';
      TableType          := ttDefault;
      FieldDefs.Clear;
      FieldDefs.Add('NrVenda',      ftInteger);
      FieldDefs.Add('Empresa',      ftSmallint);
      FieldDefs.Add('Data',         ftDate);
      FieldDefs.Add('Vend',         ftInteger);
      FieldDefs.Add('LPreco',       ftInteger);
      FieldDefs.Add('CmpCod',       ftInteger);
      FieldDefs.Add('CmpTp',        ftSmallint);
      FieldDefs.Add('CmpRzSoc',     ftString,    65);
      FieldDefs.Add('CmpTPes',      ftString,    1);
      FieldDefs.Add('CmpCNPJF',     ftString,    14);
      FieldDefs.Add('CmpIEST',      ftString,    15);
      FieldDefs.Add('CmpEnder',     ftString,    66);
      FieldDefs.Add('CmpENro',      ftString,    6);
      FieldDefs.Add('CmpECmpl',     ftString,    15);
      FieldDefs.Add('CmpEBair',     ftString,    30);
      FieldDefs.Add('CmpECEP',      ftString,    8);
      FieldDefs.Add('CmpECid',      ftString,    40);
      FieldDefs.Add('CmpEUF',       ftString,    2);
      FieldDefs.Add('CmpFone',      ftString,    18);
      FieldDefs.Add('VlrMerc',      ftCurrency);
      FieldDefs.Add('VlrServ',      ftCurrency);
      FieldDefs.Add('VlrDesc',      ftCurrency);
      FieldDefs.Add('VlrIPI',       ftCurrency);
      FieldDefs.Add('CFOP',         ftSmallint);
      FieldDefs.Add('AliqICM',      ftFloat,     2);
      FieldDefs.Add('BaseICM',      ftCurrency);
      FieldDefs.Add('VlrICM',       ftCurrency);
      FieldDefs.Add('VlrISS',       ftCurrency);
      FieldDefs.Add('BaseSTrib',    ftCurrency);
      FieldDefs.Add('VlrSTrib',     ftCurrency);
      FieldDefs.Add('VlrTotal',     ftCurrency);
      FieldDefs.Add('TrFisc',       ftSmallint);
      FieldDefs.Add('NrCF',         ftInteger);
      FieldDefs.Add('NrNF',         ftInteger);
      FieldDefs.Add('MdCobr',       ftString,    1);
      FieldDefs.Add('Comiss',       ftBoolean);
      FieldDefs.Add('VlrComiss',    ftCurrency);
      FieldDefs.Add('Lctos',        ftSmallint);
      FieldDefs.Add('Pagto',        ftSmallint);
      FieldDefs.Add('CCred',        ftString,    16);
      FieldDefs.Add('NParc',        ftSmallint);
      FieldDefs.Add('Banco',        ftSmallint);
      FieldDefs.Add('ProcSis',      ftBoolean);
      FieldDefs.Add('VlrReceb',     ftCurrency);
      FieldDefs.Add('VlrAdic',      ftCurrency);
      FieldDefs.Add('EstAtlz',      ftBoolean);
      FieldDefs.Add('CFOP2',        ftSmallint);
      FieldDefs.Add('RemFutur',     ftSmallint);
      FieldDefs.Add('ContRF',       ftString,    15);
      FieldDefs.Add('TpTrans',      ftSmallint);
      FieldDefs.Add('VlrFrete',     ftCurrency);
      FieldDefs.Add('SomaFre',      ftBoolean);
      FieldDefs.Add('VlrSegur',     ftCurrency);
      FieldDefs.Add('SomaSeg',      ftBoolean);
      FieldDefs.Add('VlrOutr',      ftCurrency);
      FieldDefs.Add('SomaOut',      ftBoolean);
      FieldDefs.Add('VctoDia',      ftSmallint);
      FieldDefs.Add('VctoIncr',     ftSmallint);
      FieldDefs.Add('ISS',          ftBoolean);
      FieldDefs.Add('PcISS',        ftFloat,     2);
      FieldDefs.Add('IRRF',         ftBoolean);
      FieldDefs.Add('PcIRRF',       ftFloat,     3);
      FieldDefs.Add('VlrIRRF',      ftCurrency);
      FieldDefs.Add('PrvSoc',       ftBoolean);
      FieldDefs.Add('PcPrvSoc',     ftFloat,     3);
      FieldDefs.Add('VlrPrvSoc',    ftCurrency);
      FieldDefs.Add('CSLL',         ftBoolean);
      FieldDefs.Add('PcCSLL',       ftBCD,       3);
      FieldDefs.Add('VlrCSLL',      ftCurrency);
      FieldDefs.Add('Cofins',       ftBoolean);
      FieldDefs.Add('PcCofins',     ftFloat,     3);
      FieldDefs.Add('VlrCofins',    ftCurrency);
      FieldDefs.Add('PisPasep',     ftBoolean);
      FieldDefs.Add('PcPisPasep',   ftFloat,     3);
      FieldDefs.Add('VlrPisPasep',  ftCurrency);
      FieldDefs.Add('PCMerc',       ftFloat,     2);
      FieldDefs.Add('PCServ',       ftFloat,     2);
      FieldDefs.Add('VLComMerc',    ftCurrency);
      FieldDefs.Add('VLComServ',    ftCurrency);
      FieldDefs.Add('OsOrig',       ftInteger);
      FieldDefs.Add('VlAFinanc',    ftCurrency);
      FieldDefs.Add('TpFrete',      ftSmallint);
      FieldDefs.Add('Benef',        ftBoolean);
      FieldDefs.Add('Totaliz',      ftSmallint);
      FieldDefs.Add('CondPgto',     ftSmallint);      // Indica se há ou não entrada (0-Sem entrada, <>0-Entrada) (Pagto 4,5,6)
      FieldDefs.Add('Envio',        ftBoolean);
      FieldDefs.Add('CredICMSST',   ftCurrency);
      FieldDefs.Add('TipoBenef',    ftSmallint);
      FieldDefs.Add('CRT',          ftString,    1);
      FieldDefs.Add('II_BaseCalc',  ftCurrency);
      FieldDefs.Add('II_Valor',     ftCurrency);
      FieldDefs.Add('II_VlrIOF',    ftCurrency);
      FieldDefs.Add('II_DespAduana',ftCurrency);
      FieldDefs.Add('II_PIS',       ftCurrency);
      FieldDefs.Add('II_Cofins',    ftCurrency);
      FieldDefs.Add('TLctos',       ftSmallint);
      FieldDefs.Add('TLctEsp',      ftSmallint);
      FieldDefs.Add('Aliq_UFDest',  ftFloat,     2);
      FieldDefs.Add('TotTribut',    ftCurrency);
      FieldDefs.Add('Finalidade',   ftString,    1);
      FieldDefs.Add('ModNF',        ftSmallint);
      FieldDefs.Add('FreteBsICM',   ftBoolean);
      FieldDefs.Add('ConsFinal',    ftSmallInt);
      FieldDefs.Add('Presenca',     ftSmallInt);
      FieldDefs.Add('CmpCidIBGE',   ftInteger);
      FieldDefs.Add('CmpUFIBGE',    ftSmallInt);
      FieldDefs.Add('CmpIMunic',    ftString,    15);
      FieldDefs.Add('SegurBsICM',   ftBoolean);
      FieldDefs.Add('DespeBsICM',   ftBoolean);
      FieldDefs.Add('PcDescGer',    ftFloat,     5);
      FieldDefs.Add('VlrICMSDeson', ftCurrency);
      FieldDefs.Add('TotTrbFed',    ftCurrency);
      FieldDefs.Add('TotTrbEst',    ftCurrency);
      FieldDefs.Add('TotTrbMun',    ftCurrency);
      FieldDefs.Add('CodDistrib',   ftSmallint);
      IndexDefs.Clear;
      IndexDefs.Add('','NrVenda',[ixPrimary,ixUnique]);
      IndexDefs.Add('CompradorVenda','CmpCod;NrVenda',[ixCaseInsensitive]);
      IndexDefs.Add('CRSocNV','CmpRzSoc;NrVenda', [ixCaseInsensitive]);
      IndexDefs.Add('NotaFiscal','NrNF;NrVenda', [ixCaseInsensitive]);
      IndexDefs.Add('DataNrOperacao','Data;NrVenda', [ixCaseInsensitive]);
//      IndexDefs.Add('CupomFiscal','NrCF;NrVenda', []);
      Try
        CreateTable;
        pMsg := pMsg +  'Vendas.DB criado  ';
      Except
        nErr    := nErr + 1;
        nCodErr := nCodErr + 1;
        Mensag  := Mensag + dfName + #13;
      End;
    end;
    cTab.Free;
  end
  else pMsg := pMsg + 'Vendas.DB existente  ';

  dfName := pPath + pPref + 'VendLctos.DB';
  if not FileExists(dfName)
  then begin
    cTab := TTable.Create(nil);
    with cTab
    do begin
      Active        := False;
      DatabaseName  := pPath;
      TableName     := pPref + 'VendLctos';
      TableType     := ttDefault;
      FieldDefs.Clear;
      FieldDefs.Add('NrVenda',      ftInteger);
      FieldDefs.Add('Seq',          ftSmallint);
      FieldDefs.Add('TpLcto',       ftSmallint);
      FieldDefs.Add('Codigo',       ftString,    13);
      FieldDefs.Add('Descr',        ftString,    45);
      FieldDefs.Add('Completa',     ftMemo,      10);
      FieldDefs.Add('Unidade',      ftString,    3);
      FieldDefs.Add('Quant',        ftBCD,       3);
      FieldDefs.Add('VlrUnit',      ftCurrency);
      FieldDefs.Add('TpDesc',       ftSmallint);
      FieldDefs.Add('VlrDesc',      ftCurrency);
      FieldDefs.Add('PercDesc',     ftBCD,       5);
      FieldDefs.Add('Total',        ftCurrency);
      FieldDefs.Add('CfIPI',        ftString,    2);
      FieldDefs.Add('AliqIPI',      ftBCD,       2);
      FieldDefs.Add('VlrIPI',       ftCurrency);
      FieldDefs.Add('STrib',        ftSmallint);
      FieldDefs.Add('BaseICM',      ftBCD,       4);
      FieldDefs.Add('VlrBaseICM',   ftCurrency);
      FieldDefs.Add('AliqICM',      ftBCD,       2);
      FieldDefs.Add('VlrICM',       ftCurrency);
      FieldDefs.Add('AliqISS',      ftBCD,       2);
      FieldDefs.Add('VlrISS',       ftCurrency);
      FieldDefs.Add('PcIcmSub',     ftBCD,       2);
      FieldDefs.Add('VlBIcmSub',    ftCurrency);
      FieldDefs.Add('VlIcmSub',     ftCurrency);
      FieldDefs.Add('CFIPIClie',    ftString,    12);
      FieldDefs.Add('Refer',        ftString,    25);
      FieldDefs.Add('QbLote',       ftBoolean);
      FieldDefs.Add('Lote',         ftString,    12);
      FieldDefs.Add('CFOP',         ftSmallint);
      FieldDefs.Add('Soma',         ftBoolean);
      FieldDefs.Add('ST_VlComp',    ftCurrency);
      FieldDefs.Add('ST_QtComp',    ftBCD,       3);
      FieldDefs.Add('ST_MVA',       ftBCD,       4);
      FieldDefs.Add('ST_BsICM',     ftCurrency);
      FieldDefs.Add('ST_VlICM',     ftCurrency);
      FieldDefs.Add('CST_IPI',      ftSmallint);
      FieldDefs.Add('CST_PIS',      ftSmallint);
      FieldDefs.Add('CST_COFINS',   ftSmallint);
      FieldDefs.Add('CSOSN',        ftSmallint);
      FieldDefs.Add('Imp_NrDoc',    ftString,    10);
      FieldDefs.Add('Imp_DtRegDI',  ftDate);
      FieldDefs.Add('Imp_LocDesemb',ftString,    60);
      FieldDefs.Add('Imp_UFDesemb', ftString,    2);
      FieldDefs.Add('Imp_DtDesemb', ftDate);
      FieldDefs.Add('Imp_NrAdicao', ftSmallint);
      FieldDefs.Add('Imp_SeqAdicao',ftSmallint);
      FieldDefs.Add('Imp_VlrDescDI',ftCurrency);
      FieldDefs.Add('Imp_BaseCalc', ftCurrency);
      FieldDefs.Add('Imp_DespAduana',ftCurrency);
      FieldDefs.Add('Imp_Aliq',     ftBCD,       3);
      FieldDefs.Add('Imp_VlrImposto',ftCurrency);
      FieldDefs.Add('Imp_VlrIOF',   ftCurrency);
      FieldDefs.Add('Imp_AliqPIS',  ftBCD,       3);
      FieldDefs.Add('Imp_VlrPIS',   ftCurrency);
      FieldDefs.Add('Imp_AliqCOFINS',ftBCD,      3);
      FieldDefs.Add('Imp_VlrCOFINS',ftCurrency);
      FieldDefs.Add('Imp_Indice',   ftBCD,       6);
      FieldDefs.Add('DescUnit',     ftInteger);
      FieldDefs.Add('LiqUnit',      ftInteger);
      FieldDefs.Add('PesoLiq',      ftBCD,       3);
      FieldDefs.Add('QtdEmb',       ftSmallint);
      FieldDefs.Add('PesoEmb',      ftBCD,       3);
      FieldDefs.Add('TotTribut',    ftCurrency);
      FieldDefs.Add('NCM',          ftString,    8);
      FieldDefs.Add('AliqSTICM',    ftBCD,       2);
      FieldDefs.Add('Pedido',       ftString,    12);
      FieldDefs.Add('SeqPedido',    ftString,    12);
      FieldDefs.Add('ICMSDeson',    ftBoolean);
      FieldDefs.Add('VlrDeson',     ftCurrency);
      FieldDefs.Add('TrbFed',       ftCurrency);
      FieldDefs.Add('TrbEst',       ftCurrency);
      FieldDefs.Add('TrbMun',       ftCurrency);
      FieldDefs.Add('UnidTrib',     ftString,    5);
      FieldDefs.Add('QtdTrib',      ftBCD,       3);
      FieldDefs.Add('IPIBcICMS',    ftBoolean);
      FieldDefs.Add('VlrFrete',     ftCurrency);
      FieldDefs.Add('VlrSeguro',    ftCurrency);
      FieldDefs.Add('VlrOutros',    ftCurrency);
      FieldDefs.Add('FreteBcICMS',  ftBoolean);
      IndexDefs.Clear;
      IndexDefs.Add('','NrVenda;Seq',[ixPrimary,ixUnique]);
      IndexDefs.Add('ItemVenda','Codigo;NrVenda;Seq', [ixCaseInsensitive]);
//      IndexDefs.Add('CFOPLcto','NrVenda;CFOP;Codigo;Seq', []);
      Try
        CreateTable;
        pMsg := pMsg + 'VendLctos.DB criado  ';
      Except
        nErr    := nErr + 1;
        nCodErr := nCodErr + 2;
        Mensag  := Mensag + dfName + #13;
      End;
    end;
    cTab.Free;
  end
  else pMsg := pMsg + 'VendLctos.DB existente  ';


  dfName := pPath + pPref + 'VendNFe.DB';
  if not FileExists(dfName)
  then begin
    cTab := TTable.Create(nil);
    with cTab
    do begin
      Active        := False;
      DatabaseName  := pPath;
      TableName     := pPref + 'VendNFe';
      TableType     := ttDefault;
      FieldDefs.Clear;
      FieldDefs.Add('NrVenda',      ftInteger);
      FieldDefs.Add('DtHr',         ftDateTime);
      FieldDefs.Add('Key',          ftString,    44);
      FieldDefs.Add('Oper',         ftString,    15);
      FieldDefs.Add('Msg',          ftString,    100);
      FieldDefs.Add('Rec',          ftString,    18);
      FieldDefs.Add('Prot',         ftString,    18);
      FieldDefs.Add('Texto',        ftMemo,      10);
      IndexDefs.Clear;
      IndexDefs.Add('','NrVenda;DtHr',[ixPrimary,ixUnique]);
      Try
        CreateTable;
        pMsg := pMsg + 'VendNFe.DB criado  ';
      Except
        nErr    := nErr + 1;
        nCodErr := nCodErr + 4;
        Mensag  := Mensag + dfName + #13;
      End;
    end;
    cTab.Free;
  end
  else pMsg := pMsg + 'VendNFe.DB existente';

  dfName := pPath + pPref + 'VendNFis.DB';
  if not FileExists(dfName)
  then begin
    cTab := TTable.Create(nil);
    with cTab
    do begin
      Active        := False;
      DatabaseName  := pPath;
      TableName     := pPref + 'VendNFis';
      TableType     := ttDefault;
      FieldDefs.Clear;
      FieldDefs.Add('NrVenda',      ftInteger);
      FieldDefs.Add('TrCod',        ftInteger);
      FieldDefs.Add('TrTp',         ftString,    1);
      FieldDefs.Add('TrNome',       ftString,    30);
      FieldDefs.Add('TrEnder',      ftString,    30);
      FieldDefs.Add('TrMun',        ftString,    20);
      FieldDefs.Add('TrUf',         ftString,    2);
      FieldDefs.Add('TrCnp',        ftString,    14);
      FieldDefs.Add('TrIEst',       ftString,    15);
      FieldDefs.Add('TrPlaca',      ftString,    8);
      FieldDefs.Add('TrPlUf',       ftString,    2);
      FieldDefs.Add('VolQtd',       ftSmallint);
      FieldDefs.Add('VolEsp',       ftString,    15);
      FieldDefs.Add('VolMar',       ftString,    10);
      FieldDefs.Add('VolNro',       ftString,    10);
      FieldDefs.Add('PBru',         ftBCD,       2);
      FieldDefs.Add('PLiq',         ftBCD,       2);
      FieldDefs.Add('CdTx1',        ftSmallint);
      FieldDefs.Add('Tx1',          ftString,    120);
      FieldDefs.Add('CdTx2',        ftSmallint);
      FieldDefs.Add('Tx2',          ftString,    120);
      FieldDefs.Add('IESubTrb',     ftString,    15);
      FieldDefs.Add('DtES',         ftDate);
      FieldDefs.Add('HrES',         ftString,    5);
      FieldDefs.Add('CdTx3',        ftSmallint);
      FieldDefs.Add('Tx3',          ftString,    120);
      FieldDefs.Add('EMailTransp',  ftString,    60);
      FieldDefs.Add('Aleatorio',    ftString,    9);
      FieldDefs.Add('DtHrES',       ftBoolean);
      FieldDefs.Add('ANTT',         ftString,    20);
      IndexDefs.Clear;
      IndexDefs.Add('','NrVenda',[ixPrimary,ixUnique]);
      Try
        CreateTable;
        pMsg := pMsg + 'VendNFis.DB criado  '
      Except
        nErr    := nErr + 1;
        nCodErr := nCodErr + 8;
        Mensag  := Mensag + dfName + #13;
      End;
    end;
    cTab.Free;
  end
  else pMsg := pMsg + 'VendNFis.DB existente  ';

  dfName := pPath + pPref + 'VendNFRef.DB';
  if not FileExists(dfName)
  then begin
    cTab := TTable.Create(nil);
    with cTab
    do begin
      Active        := False;
      DatabaseName  := pPath;
      TableName     := pPref + 'VendNFRef';
      TableType     := ttDefault;
      FieldDefs.Clear;
      FieldDefs.Add('NrVenda',      ftInteger);
      FieldDefs.Add('Seq',          ftSmallint);
      FieldDefs.Add('Tipo',         ftString,    5);
      FieldDefs.Add('DdKey',        ftString,    150);
      IndexDefs.Clear;
      IndexDefs.Add('','NrVenda;Seq',[ixPrimary,ixUnique]);
      Try
        CreateTable;
        pMsg := pMsg + 'VendNFRef.DB  criado  ';
      Except
        nErr    := nErr + 1;
        nCodErr := nCodErr + 16;
        Mensag  := Mensag + dfName + #13;
      End;
    end;
    cTab.Free;
  end
  else pMsg := pMsg + 'VendNFRef.DB existente  ';

  dfName := pPath + pPref + 'VendPagto.DB';
  if not FileExists(dfName)
  then begin
    cTab := TTable.Create(nil);
    with cTab
    do begin
      Active        := False;
      DatabaseName  := pPath;
      TableName     := pPref + 'VendPagto';
      TableType     := ttDefault;
      FieldDefs.Clear;
      FieldDefs.Add('NrVenda',      ftInteger);
      FieldDefs.Add('Seq',          ftSmallint);
      FieldDefs.Add('Vencto',       ftDate);
      FieldDefs.Add('Valor',        ftCurrency);
      FieldDefs.Add('Banco',        ftSmallint);
      FieldDefs.Add('NrCheque',     ftString,    16);
      FieldDefs.Add('Acesso',       ftInteger);
      IndexDefs.Clear;
      IndexDefs.Add('','NrVenda;Seq',[ixPrimary,ixUnique]);
      IndexDefs.Add('SeqDecresc','NrVenda;Seq',[ixDescending]);
      Try
        CreateTable;
        pMsg := pMsg + 'VendPagto.DB criado  ';
      Except
        nErr    := nErr + 1;
        nCodErr := nCodErr + 32;
        Mensag  := Mensag + dfName + #13;
      End;
    end;
    cTab.Free;
  end
  else pMsg := pMsg + 'VendPagto.DB existente  ';

  dfName := pPath + pPref + 'VendCard.DB';
  if not FileExists(dfName)
  then begin
    cTab := TTable.Create(nil);
    with cTab
    do begin
      Active        := False;
      DatabaseName  := pPath;
      TableName     := pPref + 'VendCard';
      TableType     := ttDefault;
      FieldDefs.Clear;
      FieldDefs.Add('NrVenda',ftInteger);             //  1  Nr. da operação
      FieldDefs.Add('Seq',ftSmallint);                //  2  Sequencia (Pagto com mais de um cartão)
      FieldDefs.Add('IndPag',ftSmallint);             //  3  Pagamento (0-A vista  1-Prazo)
      FieldDefs.Add('TPag',ftString,2);               //  4  Pagamento (01-Reais,03-CCred,04-CDeb,17-PIX,99-Outro)
      FieldDefs.Add('Valor',ftCurrency);              //  5  Valor da operação (do pagamento)
      FieldDefs.Add('TpIntegra',ftSmallint);          //  6  Tipo de integração (1-TEF 2-POS)
      FieldDefs.Add('Afiliacao',ftSmallint);          //  7  Afiliação (cfe tabela afiliações)
      FieldDefs.Add('CNPJ',ftString,14);              //  8  CNPJ (Cielo, Getnet, etc...)
      FieldDefs.Add('Bandeira',ftSmallint);           //  9  Bandeira (cfe.tabela)
      FieldDefs.Add('CAut',ftString,20);              // 10  Nr. da autorização (Retorno ACTEF) <-----------------------------------------
      FieldDefs.Add('NrCartao',ftString,16);          // 11  Nr. do cartão (Retorno ACTEF) <----------------------------------------------
      FieldDefs.Add('Parcelas',ftSmallint);           // 12  Nr. de parcelas
      FieldDefs.Add('VTroco',ftCurrency);             // 13  Valor do troco (se pagto REAIS)
      FieldDefs.Add('IdTerminal',ftString,20);        // 14  Identificação do terminal
      FieldDefs.Add('DataHora',ftDateTime);           // 15  Data/Hora da ocorrencia
      FieldDefs.Add('NroDocto',ftString,20);          // 16  Nro docto (Retorno ACTEF) <--------------------------------------------------
      FieldDefs.Add('CodVenda',ftString,20);          // 17  Cod venda (Retorno ACTEF) <--------------------------------------------------
      FieldDefs.Add('PrimParcela',ftSmallint);        // 18  Dias para a primeira parcela
      FieldDefs.Add('OutraBand',ftString,20);         // 19  Preencher se for outra bandeira ??
      IndexDefs.Clear;
      IndexDefs.Add('','NrVenda;Seq',[ixPrimary,ixUnique]);
      Try
        CreateTable;
        pMsg := pMsg + 'VendCard.DB criado  ';
      Except
        nErr    := nErr + 1;
        nCodErr := nCodErr + 32;
        Mensag  := Mensag + dfName + #13;
      End;
    end;
    cTab.Free;
  end
  else pMsg := pMsg + 'VendCard.DB existente  ';
  //

  if nErr > 0
  then begin
    nCodErr := nCodErr + 100;
    Mensag  := Mensag + #13 + 'Código de erro:' + IntToStr(nCodErr) + #13;
    MessageDlg(IntToStr(nErr) + ' arquivos locais não puderam ser criados' + #13 + Mensag + #13 +
               'Feche toda a aplicação e tente novamente',mtInformation,[mbOk],0);
    Result := 1;
  end;

end;


Function TS_VerificaTabelas(pPath:String; var pMsg:String; pDebug:Boolean = False): Integer;
var i,j,nErr,nRegs: Integer;
    dfName,Mensag: String;
    nKey: Integer;
    xKey: String;
    cTab: TTable;
    lVerif,lExiste: Boolean;
const xTabelas: array[1..12] of String = ('TS_Depend.DB',           // Tabela de dependentes (cadastro geral)
                                          'TS_DocsFiscais.DB',      // Documentos fiscais do sistema
                                          'TS_ECivil.DB',           // Estado civil
                                          'TS_Identidades.DB',      // Identidades
                                          'TS_MeiosPagto.DB',       // Meios pagto utilizados no caixa
                                          'TS_Moradia.DB',          // Moradia
                                          'TS_Sexo.DB',             // Sexo
                                          'TS_TpCadas.DB',          // Tipos de cadastro
                                          'TS_TpLocacao.DB',        // Locação
                                          'TS_TpPagRec.DB',         // Pagar / receber
                                          'TS_TpPessoa.DB',         // Pessoas Fisica/Juridica
                                          'TS_TpVenda.DB'           // Tipo de venda
                                         );
      xDados: array[1..12,1..12] of String =(
              ('S/parentesco','Conjuge','Filho(a)','Pais','Avós','Outro','*','*','*','*','*','*'),          // Dependentes
              ('NFe', 'NFCe', 'CF', 'CI', 'NFS', 'CIPec','CISrv','*','*','*','*','*'),                      // Docs fiscais
              ('Solteiro','Casado','Divorciado','Viúvo','Outro','*','*','*','*','*','*','*'),               // Estado civil
              ('RG','OAB','CRM','CREA','CRO','Titulo eleitor','CNH','Id.Militar','C.Reservista','C.Profissional','*','*'),  // Identidades
              ('Dinheiro R$', 'Cheque', 'C.Crédito AV','C.Crédito Parc','Crediário','Parcel/cobrança',      // Meios
               'Cheques Parc','Fat.mensal','','Antecipado','Cartão débito','Outro'),                        //    de Pagamento
              ('Casa própria','Aluguel','Outro','*','*','*','*','*','*','*','*','*'),                       // Moradia
              ('Feminino','Masculino','*','*','*','*','*','*','*','*','*','*'),                             // Sexo
              ('Fornecedor','Cliente','*','*','*','*','*','*','*','*','*','*'),                             // Tipos cadastro
              ('Diário','Semanal','Mensal','Trimestral','Semestral','Anual','*','*','*','*','*','*'),       // Locação
              ('Pagar','Receber','*','*','*','*','*','*','*','*','*','*'),                                  // Pagar / Receber
              ('Física','Jurídica','*','*','*','*','*','*','*','*','*','*'),                                // Pessoas
              ('Normal','Mercado Livre','Loja virtual','Outro','*','*','*','*','*','*','*','*')             // Tipo vendas
              );

      nDFis: array[1..12] of Integer = (55,65,97,98,10,11,12,0,0,0,0,0);                                    // Cod. Docs Fiscais
      nSexo: array[1..12] of String = ('F','M','*','*','*','*','*','*','*','*','*','*');                    // esp. sexo
      nDias: array[1..12] of Integer = (1,7,30,90,180,365,0,0,0,0,0,0);                                     // dias locação
      nFJur: array[1..12] of String = ('F','J','*','*','*','*','*','*','*','*','*','*');                    // esp. Fisica/Juridica

      existTabs: array[1..9] of String = ('TS_Cidades.DB','TS_COFINSST.DB','TS_EnquadramentosIPI.DB','TS_ErrosNFe.DB'
                               ,'TS_Estados.DB','TS_IPIST.DB','TS_Paises.DB','TS_PISST.DB', 'TS_NCMGeral.DB');


begin
  Result := 0;
  nErr   := 0;
  Mensag := '';
  //
  if pDebug then ShowMessage('TS_VerificaTabelas' + #13 + 'Path=' + pPath + #13 + IntToStr(Length(xTabelas)) + ' tabelas');
  for i := 1 to Length(xTabelas)
  do begin
    dfName            := AjustaPathBarraFinal(pPath,True) + xTabelas[i];
    cTab              := TTable.Create(nil);
    cTab.Active       := False;
    cTab.DatabaseName := pPath;
    cTab.TableName    := dfName;
    cTab.TableType    := ttDefault;
    lVerif            := True;
    if not FileExists(dfName)
    then begin
      cTab.FieldDefs.Clear;
      if (i=7) or (i=11)    // TS_Sexo   TS_TpPessoa
      then begin
        cTab.FieldDefs.Add('Cod',   ftString, 1);
        cTab.FieldDefs.Add('Descr', ftString, 10);
      end
      else begin
        cTab.FieldDefs.Add('Cod', ftSmallInt);
        cTab.FieldDefs.Add('Descr', ftString, 20);
      end;
      if i = 9             // TS_TpLocacao
         then cTab.FieldDefs.Add('Dias', ftSmallInt);
      cTab.IndexDefs.Clear;
      cTab.IndexDefs.Add('','Cod',[ixPrimary,ixUnique]);
      if i <> 9
        then cTab.IndexDefs.Add('Alfabetica','Descr;Cod',[]);
      Try
        cTab.CreateTable;
      Except
        nErr   := nErr + 1;
        Mensag := Mensag + dfName + #13;
        lVerif := False;
      End;
    end;

    // Verifica se tabela contém os registros necessários
    if lVerif
    then begin
      cTab.Active := False;
      // Determina qtd de registros por tabela
      nRegs := 0;
      for j := 1 to 12
      do if xDados[i,j] <> '*'
         then nRegs := nRegs + 1;
      Try
        cTab.Active := True;
      Except
        ShowMessage(cTab.TableName + ' - Erro de abertura');
        nRegs := 0;
      End;
      //
      for j := 1 to nRegs
      do begin
        nKey := -1;
        xKey := '';
        case i of
          1:nKey  := j-1;         // Dependentes
          2:nKey  := nDFis[j];    // Doctos fiscais
          7:xKey  := nFJur[j];    // Sexo
          11:xKey := nSexo[j];    //
          else nKey := j;
        end;
        if nKey > -1
           then lExiste := cTab.FindKey([nKey])
           else lExiste := cTab.FindKey([xKey]);
        if not lExiste
        then begin
          cTab.Append;
          if (i=7) or (i=11)
            then cTab.FieldByName('Cod').AsString  := xKey
            else cTab.FieldByName('Cod').AsInteger := nKey;
          cTab.FieldByName('Descr').AsString := xDados[i,j];
          if i = 9
             then cTab.FieldByName('Dias').AsInteger := nDias[j];
          Try
            cTab.Post;
          Except
          End;
        end;
      end;
    end;

    cTab.Active := False;
    cTab.Free;
  end;

  if pDebug then ShowMessage('TS_VerificaTabelas - 1 Final, vai iniciar fase 2');

  //
  // Verifica somente a existencia das tabelas
     { Cidades, COFINSST, EnquadramentoIPI.DB, ErrosNFe, Estados, IPIST, Paises.DB, PISST , NCMGeral.DB}
  cTab              := TTable.Create(nil);
  cTab.Active       := False;
  cTab.DatabaseName := pPath;
  for i := 1 to Length(existTabs)
  do begin
    dfName   := AjustaPathBarraFinal(pPath,True) + existTabs[i];
    if not FileExists(dfName)
    then begin
      Mensag := Mensag + dfName + '  Não existe' + #13;
      nErr   := nErr + 1;
    end
    else begin
      cTab.TableName := dfName;
      cTab.TableType := ttDefault;
      Try
        cTab.Active  := True;
        if cTab.RecordCount = 0
        then begin
          Mensag := Mensag + dfName + '  Vazio' + #13;
          nErr   := nErr + 1;
        end;
        cTab.Active  := False;
      Except
        Mensag := Mensag + dfName + '  Estrutura inválida' + #13;
        nErr   := nErr + 1
      End;
    end;
  end;
  cTab.Free;

  //
  pMsg   := Mensag;
  Result := nErr;
  if pDebug then ShowMessage('TS_VerificaTabelas - Final fase 2 - Fim');


end;


Procedure VerificaTabelasVenda(pmtAnoIni:Integer; pmtDBPath:String; var tbVendas:TStringList; var tbVenDet:TStringList);
var aa: Word;
    wPref: String;
    wMsg: String;
begin
  tbVendas.Clear;
  aa := pmtAnoIni;
  while aa <= YearOf(Date)
  do begin
    wPref := IntToStr(aa) + '_';
    if FileExists(pmtDBPath + wPref + 'Vendas.DB')
    then begin
      tbVendas.Add(wPref + 'Vendas.DB');
      tbVenDet.Add(wPref + 'Vend');
      if CriaTabelas_Venda(pmtDBPath,wPref,False,wMsg) <> 0
         then ShowMessage(wMsg);
    end;
    aa := aa + 1;
  end;
  tbVendas.Add('Vendas.DB');
  tbVenDet.Add('Vend');
  wPref := '';
  if CriaTabelas_Venda(pmtDBPath,wPref,False,wMsg) <> 0
     then ShowMessage(wMsg);
  tbVendas.Add('DiaVendas.DB');
  tbVenDet.Add('DiaVend');
  wPref := 'Dia';
  if CriaTabelas_Venda(pmtDBPath,wPref,False,wMsg) <> 0
     then ShowMessage(wMsg);

end;

end.
