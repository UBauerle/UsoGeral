unit uCriaArquivosLocais;

interface

uses DBTables, SysUtils, Dialogs, Db;

  Function CriaTabelasLocais_Venda(pPath:String; pVUniDec:Integer = 2; pDebug:Boolean = False; pAplicacao:String = 'SISV'): Integer;
  Function CriaCaixaLocal(pPathLocal,pPathDados:String; pNrCaixa:Integer; pDebug:Boolean = False): Integer;
  Function CriaLocVendaResum(pPath:String; pDebug:Boolean = False): Integer;
  Function CriaNotasFiscaisEmitidas(pPath:String; pDebug:Boolean = False): Integer;
  Function CriaEtiquetasProdutos(pPath:String; pDebug:Boolean = False): Integer;

implementation


Function CriaTabelasLocais_Venda(pPath:String;
                                 pVUniDec:Integer = 2;
                                 pDebug:Boolean = False;
                                 pAplicacao:String = 'SISV'): Integer;
var i,nErr,np: Integer;
    dfName,Mensag: String;
    cTab: TTable;
    xNames: array[1..17] of String;
const xArqLck: array[1..2] of String = ('Paradox.lck','PdoxUsrs.lck');
      xSisv: array [1..17] of String = ('LocVendas.DB','LocVendas.PX','LocVendas.MB',
                                        'LocVLctos.DB','LocVLctos.PX','LocVLctos.MB',
                                        'LocVNFe.DB','LocVNFe.PX','LocVNFe.MB',
                                        'LocVNFisc.DB','LocVNFisc.PX',
                                        'LocVNFRef.DB','LocVNFRef.PX',
                                        'LocVPagto.DB','LocVPagto.PX',
                                        'LocVCard.DB','LocVCard.PX');
      xRCar: array [1..17] of String = ('LRCVendas.DB','LRCVendas.PX','LRCVendas.MB',
                                        'LRCVLctos.DB','LRCVLctos.PX','LRCVLctos.MB',
                                        'LRCVNFe.DB','LRCVNFe.PX','LRCVNFe.MB',
                                        'LRCVNFisc.DB','LRCVNFisc.PX',
                                        'LRCVNFRef.DB','LRCVNFRef.PX',
                                        'LRCVPgtos.DB','LRCVPgtos.PX',
                                        'LRCVCard.DB','LRCVCard.PX');
begin
  if pDebug then ShowMessage('CriaTabelasLocais_Venda - Início' + #13 + 'Path=' + pPath);
  if AnsiUpperCase(pAplicacao) = 'RVCAR'
  then begin
    for i := 1 to 17
    do xNames[i] := xRCar[i];
  end
  else begin
    for i := 1 to 17
    do xNames[i] := xSisv[i];
  end;
  //
  Result    := 0;
  nErr      := 0;
  Mensag    := '';
  //
  if pVUniDec < 2
     then pVUniDec := 2
     else if pVUniDec > 5
          then pVUniDec := 5;
  for i := 1 to Length(xNames)
  do begin
    dfName := pPath + xNames[i];
    if FileExists(dfName)
    then if not DeleteFile(dfName)
         then begin
           nErr := nErr + 1;
           Mensag := Mensag + dfName + #13;
         end;
  end;
  if nErr > 0
  then begin
    MessageDlg(IntToStr(nErr) + ' arquivos locais não puderam ser excluídos' + #13 + Mensag + #13 +
               'Path=' + pPath + #13 +
               'Feche toda a aplicação e tente novamente',mtInformation,[mbOk],0);
    Result := 1;
    Exit;
  end;
  //
  // Vendas
  if pDebug then ShowMessage('CriaTabelasLocais_Venda - (Vendas)  ' + xNames[1] + #13 + 'Path=' + pPath);
  cTab    := TTable.Create(nil);
  with cTab
  do begin
    Active       := False;
    DatabaseName := pPath;
    np           := Pos('.',xNames[1]);
    TableName    := Copy(xNames[1],1,np-1);
    TableType    := ttDefault;
    if pDebug then ShowMessage('CriaTabelasLocais_Venda - (Vendas)' + #13 +
                               cTab.DatabaseName + #13 +
                               cTab.TableName);
    FieldDefs.Clear;
    if pDebug then ShowMessage('CriaTabelasLocais_Venda - (Vendas)  FieldDefs.Clear  Ok');
    FieldDefs.Add('NrVenda', ftInteger);            // 1
    FieldDefs.Add('Empresa',ftSmallint);            // 2
    FieldDefs.Add('Data',ftDate);                   // 3
    FieldDefs.Add('Vend',ftInteger);                // 4
    FieldDefs.Add('LPreco',ftInteger);              // 5
    FieldDefs.Add('CmpCod',ftInteger);              // 6
    FieldDefs.Add('CmpTp',ftSmallint);              // 7
    FieldDefs.Add('CmpRzSoc',ftString,65);          // 8
    FieldDefs.Add('CmpTPes',ftString,1);            // 9
    FieldDefs.Add('CmpCNPJF',ftString,14);          // 10
    FieldDefs.Add('CmpIEST',ftString,15);           // 11
    FieldDefs.Add('CmpEnder',ftString,66);          // 12
    FieldDefs.Add('CmpENro',ftString,6);            // 13
    FieldDefs.Add('CmpECmpl',ftString,15);          // 14
    FieldDefs.Add('CmpEBair',ftString,30);          // 15
    FieldDefs.Add('CmpECEP',ftString,8);            //  6
    FieldDefs.Add('CmpECid',ftString,40);           //  7
    FieldDefs.Add('CmpEUF',ftString,2);             //  8
    FieldDefs.Add('CmpFone',ftString,18);           //  9
    FieldDefs.Add('VlrMerc',ftCurrency);            // 20
    if pDebug then ShowMessage('CriaTabelasLocais_Venda - (Vendas)  Field 20 Ok');
    FieldDefs.Add('VlrServ',ftCurrency);            // 21
    FieldDefs.Add('VlrDesc',ftCurrency);            //  2
    FieldDefs.Add('VlrIPI',ftCurrency);             //  3
    FieldDefs.Add('CFOP',ftSmallint);               //  4
    FieldDefs.Add('AliqICM',ftBCD,2);               //  5
    FieldDefs.Add('BaseICM',ftCurrency);            //  6
    FieldDefs.Add('VlrICM',ftCurrency);             //  7
    FieldDefs.Add('VlrISS',ftCurrency);             //  8
    FieldDefs.Add('BaseSTrib',ftCurrency);          //  9
    FieldDefs.Add('VlrSTrib',ftCurrency);           // 30
    FieldDefs.Add('VlrTotal',ftCurrency);           //  1
    FieldDefs.Add('TrFisc',ftSmallint);             //  2
    FieldDefs.Add('NrCF',ftInteger);                //  3
    FieldDefs.Add('NrNF',ftInteger);                //  4
    FieldDefs.Add('MdCobr',ftString,1);             //  5
    FieldDefs.Add('Comiss',ftBoolean);              //  6
    FieldDefs.Add('VlrComiss',ftCurrency);          //  7
    FieldDefs.Add('Lctos',ftSmallint);              //  8
    FieldDefs.Add('Pagto',ftSmallint);              //  9
    FieldDefs.Add('CCred',ftString,16);             // 40
    if pDebug then ShowMessage('CriaTabelasLocais_Venda - (Vendas)  Field 40 Ok');
    FieldDefs.Add('NParc',ftSmallint);              //  1
    FieldDefs.Add('Banco',ftSmallint);              //  2
    FieldDefs.Add('ProcSis',ftBoolean);             //  3
    FieldDefs.Add('VlrReceb',ftCurrency);           //  4
    FieldDefs.Add('VlrAdic',ftCurrency);            //  5
    FieldDefs.Add('EstAtlz',ftBoolean);             //  6
    FieldDefs.Add('CFOP2',ftSmallint);              //  7
    FieldDefs.Add('RemFutur',ftSmallint);           //  8
    FieldDefs.Add('ContRF',ftString,15);            //  9
    FieldDefs.Add('TpTrans',ftSmallint);            // 50
    FieldDefs.Add('VlrFrete',ftCurrency);           //  1
    FieldDefs.Add('SomaFre',ftBoolean);             //  2
    FieldDefs.Add('VlrSegur',ftCurrency);           //  3
    FieldDefs.Add('SomaSeg',ftBoolean);             //  4
    FieldDefs.Add('VlrOutr',ftCurrency);            //  5
    FieldDefs.Add('SomaOut',ftBoolean);             //  6
    FieldDefs.Add('VctoDia',ftSmallint);            //  7
    FieldDefs.Add('VctoIncr',ftSmallint);           //  8
    FieldDefs.Add('ISS',ftBoolean);                 //  9
    FieldDefs.Add('PcISS',ftBCD,2);                 // 60
    if pDebug then ShowMessage('CriaTabelasLocais_Venda - (Vendas)  Field 60 Ok');
    FieldDefs.Add('IRRF',ftBoolean);                //  1
    FieldDefs.Add('PcIRRF',ftBCD,3);                //  2
    FieldDefs.Add('VlrIRRF',ftCurrency);            //  3
    FieldDefs.Add('PrvSoc',ftBoolean);              //  4
    FieldDefs.Add('PcPrvSoc',ftBCD,3);              //  5
    FieldDefs.Add('VlrPrvSoc',ftCurrency);          //  6
    FieldDefs.Add('CSLL',ftBoolean);                //  7
    FieldDefs.Add('PcCSLL',ftBCD,3);                //  8
    FieldDefs.Add('VlrCSLL',ftCurrency);            //  9
    FieldDefs.Add('Cofins',ftBoolean);              // 70
    FieldDefs.Add('PcCofins',ftBCD,3);              //  1
    FieldDefs.Add('VlrCofins',ftCurrency);          //  2
    FieldDefs.Add('PisPasep',ftBoolean);            //  3
    FieldDefs.Add('PcPisPasep',ftBCD,3);            //  4
    FieldDefs.Add('VlrPisPasep',ftCurrency);        //  5
    FieldDefs.Add('PCMerc',ftBCD,2);                //  6
    FieldDefs.Add('PCServ',ftBCD,2);                //  7
    FieldDefs.Add('VLComMerc',ftCurrency);          //  8
    FieldDefs.Add('VLComServ',ftCurrency);          //  9
    FieldDefs.Add('OsOrig',ftInteger);              // 80
    if pDebug then ShowMessage('CriaTabelasLocais_Venda - (Vendas)  Field 80 Ok');
    FieldDefs.Add('VlAFinanc',ftCurrency);          //  1
    FieldDefs.Add('TpFrete',ftSmallint);            //  2
    FieldDefs.Add('Benef',ftBoolean);               //  3
    FieldDefs.Add('Totaliz',ftSmallint);            //  4
    FieldDefs.Add('CondPgto',ftSmallint);           //  5 - // Indica se há ou não entrada (0-Sem entrada, <>0-Entrada) (Pagto 4,5,6)
    FieldDefs.Add('Envio',ftBoolean);               //  6
    FieldDefs.Add('CredICMSST',ftCurrency);         //  7
    FieldDefs.Add('TipoBenef',ftSmallint);          //  8
    FieldDefs.Add('CRT',ftString,1);                //  9
    FieldDefs.Add('II_BaseCalc',ftCurrency);        // 90
    FieldDefs.Add('II_Valor',ftCurrency);           //  1
    FieldDefs.Add('II_VlrIOF',ftCurrency);          //  2
    FieldDefs.Add('II_DespAduana',ftCurrency);      //  3
    FieldDefs.Add('II_PIS',ftCurrency);             //  4
    FieldDefs.Add('II_Cofins',ftCurrency);          //  5
    FieldDefs.Add('TLctos',ftSmallint);             //  6
    FieldDefs.Add('TLctEsp',ftSmallint);            //  7
    FieldDefs.Add('Aliq_UFDest',ftBCD,2);           //  8
    FieldDefs.Add('TotTribut',ftCurrency);          //  9
    FieldDefs.Add('Finalidade',ftString,1);         // 100
    if pDebug then ShowMessage('CriaTabelasLocais_Venda - (Vendas)  Field 100 Ok');
    FieldDefs.Add('ModNF',ftSmallint);              // 101
    FieldDefs.Add('FreteBsICM',ftBoolean);          // 102
    FieldDefs.Add('ConsFinal',ftSmallInt);          //   3
    FieldDefs.Add('Presenca',ftSmallInt);           //   4
    FieldDefs.Add('CmpCidIBGE',ftInteger);          //   5
    FieldDefs.Add('CmpUFIBGE',ftSmallInt);          // 106
    FieldDefs.Add('CmpIMunic',ftString,15);         // 107
    FieldDefs.Add('SegurBsICM',ftBoolean);          // 108
    FieldDefs.Add('DespeBsICM',ftBoolean);          // 109
    FieldDefs.Add('PcDescGer',ftBCD,5);             // 110
    FieldDefs.Add('VlrICMSDeson',ftCurrency);       // 111
    FieldDefs.Add('TotTrbFed',ftCurrency);          //   2
    FieldDefs.Add('TotTrbEst',ftCurrency);          //   3
    FieldDefs.Add('TotTrbMun',ftCurrency);          // 114
    FieldDefs.Add('CodDistrib',ftSmallInt);         // 115
    if pDebug then ShowMessage('CriaTabelasLocais_Venda - (Vendas)  Field 115 Ok');
    IndexDefs.Clear;
    IndexDefs.Add('','NrVenda',[ixPrimary,ixUnique]);
    if pDebug then ShowMessage('CriaTabelasLocais_Venda - (Vendas)  IndexDefs.Clear Ok');
    Try
      cTab.CreateTable;
      if pDebug then ShowMessage('Criou LocVendas');
    Except
      nErr := nErr + 1;
      Mensag := Mensag + xNames[1] + #13;
      if pDebug then ShowMessage(Mensag);
    End;
  end;
  cTab.Free;
  //
  // Lançamentos
  if pDebug then ShowMessage('CriaTabelasLocais_Venda - (Lançamentos)  ' + xNames[4] + #13 + 'Path=' + pPath);
  cTab := TTable.Create(nil);
  with cTab
  do begin
    Active       := False;
    DatabaseName := pPath;
    np           := Pos('.',xNames[4]);
    TableName    := Copy(xNames[4],1,np-1);
    TableType    := ttDefault;
    FieldDefs.Clear;
    FieldDefs.Add('NrVenda',ftInteger);             // 1
    FieldDefs.Add('Seq',ftSmallint);                // 2
    FieldDefs.Add('TpLcto',ftSmallint);             // 3
    FieldDefs.Add('Codigo',ftString,13);            // 4
    FieldDefs.Add('Descr',ftString,45);             // 5
    FieldDefs.Add('Completa',ftMemo,10);            // 6
    FieldDefs.Add('Unidade',ftString,3);            // 7
    FieldDefs.Add('Quant',ftBCD,3);                 // 8 - Qtd de decimais definidas entre 3 e 5
    if pVUniDec <= 2
       then FieldDefs.Add('VlrUnit',ftCurrency)        // 9 - até 2 casas decimais é Currency
       else FieldDefs.Add('VlrUnit',ftFloat);          // 9 - Valor unitario com mais de 2 casas decimais (max. 5)
    FieldDefs.Add('TpDesc',ftSmallint);             // 10
    FieldDefs.Add('VlrDesc',ftCurrency);            // 11
    FieldDefs.Add('PercDesc',ftBCD,5);              // 12
    FieldDefs.Add('Total',ftCurrency);              // 13
    FieldDefs.Add('CfIPI',ftString,2);              // 14
    FieldDefs.Add('AliqIPI',ftBCD,2);               // 15
    FieldDefs.Add('VlrIPI',ftCurrency);             // 16
    FieldDefs.Add('STrib',ftSmallint);              // 17
    FieldDefs.Add('BaseICM',ftBCD,4);               // 18
    FieldDefs.Add('VlrBaseICM',ftCurrency);         // 19
    FieldDefs.Add('AliqICM',ftBCD,2);               // 20
    FieldDefs.Add('VlrICM',ftCurrency);             // 21
    FieldDefs.Add('AliqISS',ftBCD,2);               // 22
    FieldDefs.Add('VlrISS',ftCurrency);             // 23
    FieldDefs.Add('PcIcmSub',ftBCD,2);              // 24
    FieldDefs.Add('VlBIcmSub',ftCurrency);          // 25
    FieldDefs.Add('VlIcmSub',ftCurrency);           // 26
    FieldDefs.Add('CFIPIClie',ftString,12);         // 27
    FieldDefs.Add('Refer',ftString,25);             // 28
    FieldDefs.Add('QbLote',ftBoolean);              // 29
    FieldDefs.Add('Lote',ftString,12);              // 30
    FieldDefs.Add('CFOP',ftSmallint);               // 31
    FieldDefs.Add('Soma',ftBoolean);                // 32
    FieldDefs.Add('ST_VlComp',ftCurrency);          // 33
    FieldDefs.Add('ST_QtComp',ftBCD,3);             // 34
    FieldDefs.Add('ST_MVA',ftBCD,4);                // 35
    FieldDefs.Add('ST_BsICM',ftCurrency);           // 36
    FieldDefs.Add('ST_VlICM',ftCurrency);           // 37
    FieldDefs.Add('CST_IPI',ftSmallint);            // 38
    FieldDefs.Add('CST_PIS',ftSmallint);            // 39
    FieldDefs.Add('CST_COFINS',ftSmallint);         // 40
    FieldDefs.Add('CSOSN',ftSmallint);              // 41
    FieldDefs.Add('Imp_NrDoc',ftString,10);         // 42
    FieldDefs.Add('Imp_DtRegDI',ftDate);            // 43
    FieldDefs.Add('Imp_LocDesemb',ftString,60);     // 44
    FieldDefs.Add('Imp_UFDesemb',ftString,2);       // 45
    FieldDefs.Add('Imp_DtDesemb',ftDate);           // 46
    FieldDefs.Add('Imp_NrAdicao',ftSmallint);       // 47
    FieldDefs.Add('Imp_SeqAdicao',ftSmallint);      // 48
    FieldDefs.Add('Imp_VlrDescDI',ftCurrency);      // 49
    FieldDefs.Add('Imp_BaseCalc',ftCurrency);       // 50
    FieldDefs.Add('Imp_DespAduana',ftCurrency);     // 51
    FieldDefs.Add('Imp_Aliq',ftBCD,3);              // 52
    FieldDefs.Add('Imp_VlrImposto',ftCurrency);     // 53
    FieldDefs.Add('Imp_VlrIOF',ftCurrency);         // 54
    FieldDefs.Add('Imp_AliqPIS',ftBCD,3);           // 55
    FieldDefs.Add('Imp_VlrPIS',ftCurrency);         // 56
    FieldDefs.Add('Imp_AliqCOFINS',ftBCD,3);        // 57
    FieldDefs.Add('Imp_VlrCOFINS',ftCurrency);      // 58
    FieldDefs.Add('Imp_Indice',ftBCD,6);            // 59
    FieldDefs.Add('DescUnit',ftInteger);            // 60
    FieldDefs.Add('LiqUnit',ftInteger);             // 61
    FieldDefs.Add('PesoLiq',ftBCD,3);               // 62
    FieldDefs.Add('QtdEmb',ftSmallint);             // 63
    FieldDefs.Add('PesoEmb',ftBCD,3);               // 64
    FieldDefs.Add('TotTribut',ftCurrency);          // 65
    FieldDefs.Add('NCM',ftString,8);                // 66
    FieldDefs.Add('AliqSTICM',ftBCD,2);             // 67
    FieldDefs.Add('Pedido',ftString,12);            // 68
    FieldDefs.Add('SeqPedido',ftString,12);         // 69
    FieldDefs.Add('ICMSDeson',ftBoolean);           // 70
    FieldDefs.Add('VlrDeson',ftCurrency);           // 71
    FieldDefs.Add('TrbFed',ftCurrency);             // 72
    FieldDefs.Add('TrbEst',ftCurrency);             // 73
    FieldDefs.Add('TrbMun',ftCurrency);             // 74
    FieldDefs.Add('UnidTrib',ftString,5);           // 75
    FieldDefs.Add('QtdTrib',ftBCD,3);               // 76
    FieldDefs.Add('IPIBcICMS',ftBoolean);           // 77
    FieldDefs.Add('VlrFrete',ftCurrency);           // 78
    FieldDefs.Add('VlrSeguro',ftCurrency);          // 79
    FieldDefs.Add('VlrOutros',ftCurrency);          // 80
    FieldDefs.Add('FreteBcICMS',ftBoolean);         // 81
    IndexDefs.Clear;
    IndexDefs.Add('','NrVenda;Seq',[ixPrimary,ixUnique]);
    Try
      CreateTable;
    Except
      nErr := nErr + 1;
      Mensag := Mensag + xNames[4] + #13;
    End;
  end;
  cTab.Free;
  //
  // Informações NFeletronica
  if pDebug then ShowMessage('CriaTabelasLocais_Venda - (NFEletronica)  ' + xNames[7] + #13 + 'Path=' + pPath);
  cTab := TTable.Create(nil);
  with cTab
  do begin
    Active       := False;
    DatabaseName := pPath;
    np           := Pos('.',xNames[7]);
    TableName    := Copy(xNames[7],1,np-1);
    TableType    := ttDefault;
    FieldDefs.Clear;
    FieldDefs.Add('NrVenda',ftInteger);             // 1
    FieldDefs.Add('DtHr',ftDateTime);               // 2
    FieldDefs.Add('Key',ftString,44);               // 3
    FieldDefs.Add('Oper',ftString,15);              // 4
    FieldDefs.Add('Msg',ftString,100);              // 5
    FieldDefs.Add('Rec',ftString,18);               // 6
    FieldDefs.Add('Prot',ftString,18);              // 7
    FieldDefs.Add('Texto',ftMemo, 10);              // 8
    IndexDefs.Clear;
    IndexDefs.Add('','NrVenda;DtHr',[ixPrimary,ixUnique]);
    Try
      CreateTable;
    Except
      nErr := nErr + 1;
      Mensag := Mensag + xNames[7] + #13;
    End;
  end;
  cTab.Free;
  //
  // Informações NFiscal
  if pDebug then ShowMessage('CriaTabelasLocais_Venda - (NFiscal)  ' + xNames[10] + #13 + 'Path=' + pPath);
  cTab := TTable.Create(nil);
  with cTab
  do begin
    Active       := False;
    DatabaseName := pPath;
    np           := Pos('.',xNames[10]);
    TableName    := Copy(xNames[10],1,np-1);
    TableType    := ttDefault;
    FieldDefs.Clear;
    FieldDefs.Add('NrVenda',ftInteger);             // 1
    FieldDefs.Add('TrCod',ftInteger);               // 2
    FieldDefs.Add('TrTp',ftString,1);               // 3
    FieldDefs.Add('TrNome',ftString,30);            // 4
    FieldDefs.Add('TrEnder',ftString,30);           // 5
    FieldDefs.Add('TrMun',ftString,20);             // 6
    FieldDefs.Add('TrUf',ftString,2);               // 7
    FieldDefs.Add('TrCnp',ftString,14);             // 8
    FieldDefs.Add('TrIEst',ftString,15);            // 9
    FieldDefs.Add('TrPlaca',ftString,8);            // 10
    FieldDefs.Add('TrPlUf',ftString,2);             // 11
    FieldDefs.Add('VolQtd',ftSmallint);             // 12
    FieldDefs.Add('VolEsp',ftString,15);            // 13
    FieldDefs.Add('VolMar',ftString,10);            // 14
    FieldDefs.Add('VolNro',ftString,10);            // 15
    FieldDefs.Add('PBru',ftBCD,2);                  // 16
    FieldDefs.Add('PLiq',ftBCD,2);                  // 17
    FieldDefs.Add('CdTx1',ftSmallint);              // 18
    FieldDefs.Add('Tx1',ftString,120);              // 19
    FieldDefs.Add('CdTx2',ftSmallint);              // 20
    FieldDefs.Add('Tx2',ftString,120);              // 21
    FieldDefs.Add('IESubTrb',ftString,15);          // 22
    FieldDefs.Add('DtES',ftDate);                   // 23
    FieldDefs.Add('HrES',ftString,5);               // 24
    FieldDefs.Add('CdTx3',ftSmallint);              // 25
    FieldDefs.Add('Tx3',ftString,120);              // 26
    FieldDefs.Add('EMailTransp',ftString,60);       // 27
    FieldDefs.Add('Aleatorio',ftString,9);          // 28
    FieldDefs.Add('DtHrES',ftBoolean);              // 29
    FieldDefs.Add('ANTT',ftString,20);              // 30
    IndexDefs.Clear;
    IndexDefs.Add('','NrVenda',[ixPrimary,ixUnique]);
    Try
      CreateTable;
    Except
      nErr := nErr + 1;
      Mensag := Mensag + xNames[10] + #13;
    End;
  end;
  cTab.Free;
  //
  // Notas Fiscais Relacionadas
  if pDebug then ShowMessage('CriaTabelasLocais_Venda - (NFRelacionadas)  ' + xNames[12] + #13 + 'Path=' + pPath);
  cTab := TTable.Create(nil);
  with cTab
  do begin
    Active       := False;
    DatabaseName := pPath;
    np           := Pos('.',xNames[12]);
    TableName    := Copy(xNames[12],1,np-1);
    TableType    := ttDefault;
    FieldDefs.Clear;
    FieldDefs.Add('NrVenda',ftInteger);             // 1
    FieldDefs.Add('Seq',ftSmallint);                // 2
    FieldDefs.Add('Tipo',ftString,5);               // 3
    FieldDefs.Add('DdKey',ftString,150);            // 4
    IndexDefs.Clear;
    IndexDefs.Add('','NrVenda;Seq',[ixPrimary,ixUnique]);
    Try
      CreateTable;
    Except
      nErr := nErr + 1;
      Mensag := Mensag + xNames[12] + #13;
    End;
  end;
  cTab.Free;
  //
  // Pagamentos/parcelas
  if pDebug then ShowMessage('CriaTabelasLocais_Venda - (Pagamentos)  ' + xNames[14] + #13 + 'Path=' + pPath);
  cTab := TTable.Create(nil);
  with cTab
  do begin
    Active       := False;
    DatabaseName := pPath;
    np           := Pos('.',xNames[14]);
    TableName    := Copy(xNames[14],1,np-1);
    TableType    := ttDefault;
    FieldDefs.Clear;
    FieldDefs.Add('NrVenda',ftInteger);             // 1
    FieldDefs.Add('Seq',ftSmallint);                // 2
    FieldDefs.Add('Vencto',ftDate);                 // 3
    FieldDefs.Add('Valor',ftCurrency);              // 4
    FieldDefs.Add('Banco',ftSmallint);              // 5
    FieldDefs.Add('NrCheque',ftString,16);          // 6
    FieldDefs.Add('Acesso',ftInteger);              // 7
    IndexDefs.Clear;
    IndexDefs.Add('','NrVenda;Seq',[ixPrimary,ixUnique]);
    Try
      CreateTable;
    Except
      nErr := nErr + 1;
      Mensag := Mensag + xNames[14] + #13;
    End;
  end;
  cTab.Free;

  // Pagamento com cartão crédito/débito
  if pDebug then ShowMessage('CriaTabelasLocais_Venda - (PgCartoes)  ' + xNames[16] + #13 + 'Path=' + pPath);
  cTab := TTable.Create(nil);
  with cTab
  do begin
    Active       := False;
    DatabaseName := pPath;
    np           := Pos('.',xNames[16]);
    TableName    := Copy(xNames[16],1,np-1);
    TableType    := ttDefault;
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
    Except
      nErr := nErr + 1;
      Mensag := Mensag + xNames[16] + #13;
    End;
  end;
  cTab.Free;

  //
  if nErr > 0
  then begin
    MessageDlg(IntToStr(nErr) + ' arquivos locais não puderam ser criados' + #13 + Mensag + #13 +
               'Path=' + pPath + #13 +
               'Feche toda a aplicação e tente novamente',mtInformation,[mbOk],0);
    Result := 1;
  end;
  if pDebug then ShowMessage('CriaTabelasLocais_Venda - Final' + #13 + 'Path=' + pPath);

end;

//
Function CriaCaixaLocal(pPathLocal,pPathDados:String; pNrCaixa:Integer; pDebug:Boolean = False): Integer;
var nErr: Integer;
    fName,Mensag,xNro: String;
    cTab: TTable;
begin
  if pDebug then ShowMessage('CriaCaixaLocal - Início' + #13 + 'PathLocal=' + pPathLocal + #13 + 'PathDados=' + pPathDados);
  Result := 0;
  nErr   := 0;
  Mensag := '';
  xNro   := IntToStr(pNrCaixa);
  while Length(xNro) < 2 do xNro := '0' + xNro;
  //
  // Arquivo Atendimentos diarios
  fName := pPathDados + 'DiarioAtend.DB';
  if pDebug then ShowMessage('CriaCaixaLocal - fName=' + fName);
  if not FileExists(fName)
  then begin
    if pDebug then ShowMessage('Criando ' + fName + ' 01');
    cTab := TTable.Create(nil);
    if pDebug then ShowMessage('Criando ' + fName + ' 02');
    with cTab
    do begin
      if pDebug then ShowMessage('Criando ' + fName + ' 03');
      Active          := False;
      DatabaseName    := pPathDados;
      TableName       := 'DiarioAtend';
      TableType       := ttDefault;
      FieldDefs.Clear;
      FieldDefs.Add('Data',           ftDate);
      FieldDefs.Add('Vendedor',       ftInteger);
      FieldDefs.Add('Quant',          ftSmallint);
      FieldDefs.Add('Valor',          ftCurrency);
      FieldDefs.Add('Ligacoes',       ftSmallint);
      FieldDefs.Add('Cadastros',      ftSmallint);
      FieldDefs.Add('AtendSV',        ftSmallint);
      FieldDefs.Add('Crediarios',     ftSmallint);
      FieldDefs.Add('VlrLigacoes',    ftCurrency);
      FieldDefs.Add('VlrCrediarios',  ftCurrency);

      IndexDefs.Clear;
      IndexDefs.Add('','Data;Vendedor',[ixPrimary,ixUnique]);
      if pDebug then ShowMessage('Criando ' + fName + ' 04');
      Try
        CreateTable;
      Except
        nErr := nErr + 1;
        Mensag := Mensag + fName + #13;
      End;
    end;
    cTab.Free;
    if pDebug then ShowMessage('Criando ' + fName + ' Free');
  end;
  //
  // Arquivo Ctle Caxia
  fName := pPathDados + 'CtleCaixas.DB';
  if pDebug then ShowMessage('CriaCaixaLocal - fName=' + fName);
  if not FileExists(fName)
  then begin
    if pDebug then ShowMessage('Criando ' + fName + ' 01');
    cTab := TTable.Create(nil);
    if pDebug then ShowMessage('Criando ' + fName + ' 02');
    with cTab
    do begin
      if pDebug then ShowMessage('Criando ' + fName + ' 03');
      Active          := False;
      DatabaseName    := pPathDados;
      TableName       := 'CtleCaixas';
      TableType       := ttDefault;
      FieldDefs.Clear;
      FieldDefs.Add('NrCaixa',        ftSmallint);
      FieldDefs.Add('NrOperacao',     ftInteger);
      IndexDefs.Clear;
      IndexDefs.Add('','NrCaixa',[ixPrimary,ixUnique]);
      if pDebug then ShowMessage('Criando ' + fName + ' 04');
      Try
        CreateTable;
      Except
        nErr := nErr + 2;
        Mensag := Mensag + fName + #13;
      End;
    end;
    cTab.Free;
    if pDebug then ShowMessage('Criando ' + fName + ' Free');
  end;
  //
  // Registro de caixa
  fName := pPathLocal + 'CaixaReg' + xNro + '.DB';
  if pDebug then ShowMessage('CriaCaixaLocal - fName=' + fName);
  if not FileExists(fName)
  then begin
    if pDebug then ShowMessage('Criando ' + fName + ' 01');
    cTab := TTable.Create(nil);
    if pDebug then ShowMessage('Criando ' + fName + ' 02');
    with cTab
    do begin
      if pDebug then ShowMessage('Criando ' + fName + ' 03');
      Active          := False;
      DatabaseName    := pPathLocal;
      TableName       := 'CaixaReg' + xNro;
      TableType       := ttDefault;
      FieldDefs.Clear;
      FieldDefs.Add('Data',           ftDate);
      FieldDefs.Add('SaldoInicial',   ftCurrency);
      FieldDefs.Add('VlrOpCx',        ftCurrency);
      FieldDefs.Add('VlrNFe',         ftCurrency);
      FieldDefs.Add('VlrNFCe',        ftCurrency);
      FieldDefs.Add('VlrNFSe',        ftCurrency);
      FieldDefs.Add('VlrDocInt',      ftCurrency);
      FieldDefs.Add('VlrInval',       ftCurrency);
      FieldDefs.Add('QtdOpCx',        ftSmallint);
      FieldDefs.Add('QtdNFe',         ftSmallint);
      FieldDefs.Add('QtdNFCe',        ftSmallint);
      FieldDefs.Add('QtdNFSe',        ftSmallint);
      FieldDefs.Add('QtdDocInt',      ftSmallint);
      FieldDefs.Add('QtdInval',       ftSmallint);
      FieldDefs.Add('VlrReais',       ftCurrency);
      FieldDefs.Add('VlrCheques',     ftCurrency);
      FieldDefs.Add('VlrAVCartao',    ftCurrency);
      FieldDefs.Add('VlrPcCartao',    ftCurrency);
      FieldDefs.Add('VlrCrediario',   ftCurrency);
      FieldDefs.Add('VlrParcel',      ftCurrency);
      FieldDefs.Add('VlrPcCheq',      ftCurrency);
      FieldDefs.Add('VlrFatMens',     ftCurrency);
      FieldDefs.Add('VlrSemCobr',     ftCurrency);
      FieldDefs.Add('VlrAntecipado',  ftCurrency);
      FieldDefs.Add('VlrCDebito',     ftCurrency);
      FieldDefs.Add('VlrPIX',         ftCurrency);
      FieldDefs.Add('VlrParcelZero',  ftCurrency);
      FieldDefs.Add('VlrCrediarZero', ftCurrency);
      FieldDefs.Add('VlrCartaoZero',  ftCurrency);
      FieldDefs.Add('VlrInvalido',    ftCurrency);
      FieldDefs.Add('QtdReais',       ftSmallint);
      FieldDefs.Add('QtdCheques',     ftSmallint);
      FieldDefs.Add('QtdAVCartao',    ftSmallint);
      FieldDefs.Add('QtdPcCartao',    ftSmallint);
      FieldDefs.Add('QtdCrediario',   ftSmallint);
      FieldDefs.Add('QtdParcel',      ftSmallint);
      FieldDefs.Add('QtdPcCheq',      ftSmallint);
      FieldDefs.Add('QtdFatMens',     ftSmallint);
      FieldDefs.Add('QtdSemCobr',     ftSmallint);
      FieldDefs.Add('QtdAntecipado',  ftSmallint);
      FieldDefs.Add('QtdCDebito',     ftSmallint);
      FieldDefs.Add('QtdPIX',         ftSmallint);
      FieldDefs.Add('QtdParcelZero',  ftSmallint);
      FieldDefs.Add('QtdCrediarZero', ftSmallint);
      FieldDefs.Add('QtdCartaoZero',  ftSmallint);
      FieldDefs.Add('QtdInvalido',    ftSmallint);
      FieldDefs.Add('VlrSaidas',      ftCurrency);
      FieldDefs.Add('QtdSaidas',      ftSmallint);
      FieldDefs.Add('VlrCReceber',    ftCurrency);
      FieldDefs.Add('QtdCReceber',    ftSmallint);
      FieldDefs.Add('SaldoFinal'     ,ftCurrency);
      FieldDefs.Add('VlrMerc'        ,ftCurrency);
      FieldDefs.Add('VlrServ'        ,ftCurrency);
      FieldDefs.Add('VlrCancelam'    ,ftCurrency);
      FieldDefs.Add('QtdCancelam'    ,ftSmallint);
      IndexDefs.Clear;
      IndexDefs.Add('','Data',[ixPrimary,ixUnique]);
      if pDebug then ShowMessage('Criando ' + fName + ' 04');
      Try
        CreateTable;
      Except
        nErr := nErr + 4;
        Mensag := Mensag + fName + #13;
      End;
    end;
    cTab.Free;
    if pDebug then ShowMessage('Criando ' + fName + ' Free');
  end;
  //
  // Lançamentos de caixa
  fName := pPathLocal + 'CaixaLct' + xNro + '.DB';
  if pDebug then ShowMessage('CriaCaixaLocal - fName=' + fName);
  if not FileExists(fName)
  then begin
    cTab := TTable.Create(nil);
    with cTab
    do begin
      Active          := False;
      DatabaseName    := pPathLocal;
      TableName       := 'CaixaLct' + xNro;
      TableType       := ttDefault;
      FieldDefs.Add('Data'        ,ftDate);
      FieldDefs.Add('Seq'         ,ftSmallint);
      FieldDefs.Add('Hora'        ,ftInteger);
      FieldDefs.Add('Oper'        ,ftSmallint);
      FieldDefs.Add('Doc'         ,ftSmallint);
      FieldDefs.Add('DocNro'      ,ftString, 12);
      FieldDefs.Add('Histor'      ,ftString, 60);
      FieldDefs.Add('Tipo'        ,ftSmallint);
      FieldDefs.Add('Valor'       ,ftCurrency);
      FieldDefs.Add('Saldo'       ,ftCurrency);
      FieldDefs.Add('Autom'       ,ftBoolean);
      FieldDefs.Add('EmpFil'      ,ftSmallint);
      FieldDefs.Add('DocParc'     ,ftString, 2);
      FieldDefs.Add('DocAcesso'   ,ftInteger);
      FieldDefs.Add('TpEntrada'   ,ftSmallint);
      FieldDefs.Add('NroOperacao' ,ftInteger);
      FieldDefs.Add('CodVendedor' ,ftSmallint);
      IndexDefs.Clear;
      IndexDefs.Add('','Data;Seq;Hora',[ixPrimary,ixUnique]);
      Try
        CreateTable;
      Except
        nErr := nErr + 8;
        Mensag := Mensag + fName + #13;
      End;
    end;
    cTab.Free;
  end;
  //
  // Arquivo vendas encerradas (Balcao Simples)
  fName := pPathDados + 'BSFinal.DB';
  if pDebug then ShowMessage('CriaCaixaLocal - fName=' + fName);
  if not FileExists(fName)
  then begin
    if pDebug then ShowMessage('Criando ' + fName + ' 01');
    cTab := TTable.Create(nil);
    if pDebug then ShowMessage('Criando ' + fName + ' 02');
    with cTab
    do begin
      if pDebug then ShowMessage('Criando ' + fName + ' 03');
      Active          := False;
      DatabaseName    := pPathDados;
      TableName       := 'BSFinal';
      TableType       := ttDefault;
      FieldDefs.Clear;
      FieldDefs.Add('Data',           ftDate);
      FieldDefs.Add('NrOperacao',     ftInteger);
      FieldDefs.Add('TpDoc',          ftSmallint);
      FieldDefs.Add('Status',         ftBoolean);
      IndexDefs.Clear;
      IndexDefs.Add('','Data;NrOperacao',[ixPrimary,ixUnique]);
      if pDebug then ShowMessage('Criando ' + fName + ' 04');
      Try
        CreateTable;
      Except
        nErr := nErr + 16;
        Mensag := Mensag + fName + #13;
      End;
    end;
    cTab.Free;
    if pDebug then ShowMessage('Criando ' + fName + ' Free');
  end;

  //
  if nErr > 0
  then begin
    MessageDlg('Arquivos locais não puderam ser criados (cod=' + IntToStr(nErr) + ')' + #13
               + Mensag + #13
               + 'Feche toda a aplicação, remova os arquivos atualmente existentes e tente novamente'
               ,mtInformation,[mbOk],0);
    Result := 1;
  end;

end;


Function CriaLocVendaResum(pPath: String; pDebug:Boolean = False): Integer;
var nErr: Integer;
    fName,Mensag: String;
    cTab: TTable;
begin
  if pDebug then ShowMessage('CriaLocVendaResum - Início');
  Result := 0;
  nErr   := 0;
  Mensag := '';
  //
  fName := pPath + 'LocVendaResum.DB';
  if pDebug then ShowMessage('CriaLocVendaResum - fName=' + fName);
  if not FileExists(fName)
  then begin
    if pDebug then ShowMessage('Criando ' + fName + ' 01');
    cTab := TTable.Create(nil);
    if pDebug then ShowMessage('Criando ' + fName + ' 02');
    with cTab
    do begin
      if pDebug then ShowMessage('Criando ' + fName + ' 03');
      Active          := False;
      DatabaseName    := pPath;
      TableName       := 'LocVendaResum';
      TableType       := ttDefault;
      FieldDefs.Clear;
      FieldDefs.Add('Data'           ,ftDate);
      FieldDefs.Add('NFCF'           ,ftInteger);
      FieldDefs.Add('NVenda'         ,ftInteger);
      FieldDefs.Add('TpDoc'          ,ftSmallint);
      FieldDefs.Add('VlMerc'         ,ftCurrency);
      FieldDefs.Add('VlServ'         ,ftCurrency);
      FieldDefs.Add('VlTotal'        ,ftCurrency);
      IndexDefs.Clear;
      IndexDefs.Add('','Data;NFCF;NVenda',[ixPrimary,ixUnique]);
      if pDebug then ShowMessage('Criando ' + fName + ' 04');
      Try
        CreateTable;
      Except
        nErr := nErr + 1;
        Mensag := Mensag + TableName + #13;
      End;
    end;
    cTab.Free;
    if pDebug then ShowMessage('Criando ' + fName + ' Free');

  end;
  //
  if nErr > 0
  then begin
    MessageDlg('Arquivo "LocVendaResum.DB" não pode ser criado (cod=' + IntToStr(nErr) + ')' + #13
               + pPath + '  ' + Mensag + #13
               + 'Remova o arquivo atualmente existente, feche toda a aplicação e tente novamente'
               ,mtInformation,[mbOk],0);
    Result := 1;
  end;

end;


Function CriaNotasFiscaisEmitidas(pPath:String; pDebug:Boolean = False): Integer;
var i,nErr: Integer;
    fName,Mensag: String;
    cTab: TTable;
const xExt: array [1..8] of String = ('DB','PX','XG0','YG0','XG1','YG1','XG2','YG2');
begin
  if pDebug then ShowMessage('CriaNotasFiscaisEmitidas - Início');
  Result := 0;
  nErr   := 0;
  Mensag := '';
  //
  if pDebug then ShowMessage('CriaNotasFiscaisEmitidas - Excluindo - LocNFEmitDet.DB');
  for i := 1 to Length(xExt)
  do begin
    fName := pPath + 'LocNFEmitDet.' + xExt[i];
    if FileExists(fName)
    then Try
           DeleteFile(fName);
         Except
           nErr   := nErr + 1;
           Mensag := Mensag + fName + #13;
         End;
  end;
  if pDebug then ShowMessage('CriaNotasFiscaisEmitidas - Excluindo - LocNFEmitTot.DB');
  for i := 1 to Length(xExt)
  do begin
    fName := pPath + 'LocNFEmitTot.' + xExt[i];
    if FileExists(fName)
    then Try
           DeleteFile(fName);
         Except
           nErr   := nErr + 1;
           Mensag := Mensag + fName + #13;
         End;
  end;
  if nErr > 0
  then begin
    MessageDlg('Não foi possível excluir arquivos(s):' + #13 + Mensag + #13
               + 'Feche a aplicação, remova os arquivos manualmente e tente novamente'
               ,mtInformation,[mbOk],0);
    Result := 1;
    Exit;
  end;
  //
  fName := pPath + 'LocNFEmitDet.DB';
  if pDebug then ShowMessage('Criando ' + fName + ' 01');
  cTab := TTable.Create(nil);
  with cTab
  do begin
    Active          := False;
    DatabaseName    := pPath;
    TableName       := 'LocNFEmitDet';
    TableType       := ttDefault;
    FieldDefs.Clear;
    FieldDefs.Add('EmpFil'         ,ftSmallint);
    FieldDefs.Add('TpDoc'          ,ftSmallint);
    FieldDefs.Add('NrDoc'          ,ftInteger);
    FieldDefs.Add('CFOP'           ,ftInteger);
    FieldDefs.Add('TrFisc'         ,ftSmallint);
    FieldDefs.Add('NrOperacao'     ,ftInteger);
    FieldDefs.Add('Data'           ,ftDate);
    FieldDefs.Add('Cliente'        ,ftInteger);
    FieldDefs.Add('RzSocial'       ,ftString ,65);
    FieldDefs.Add('TpPess'         ,ftString ,1);
    FieldDefs.Add('CNPJ'           ,ftString ,14);
    FieldDefs.Add('UF'             ,ftString, 2);
    FieldDefs.Add('VlMerc'         ,ftCurrency);
    FieldDefs.Add('BsICM'          ,ftCurrency);
    FieldDefs.Add('VlICM'          ,ftCurrency);
    FieldDefs.Add('BsICMST'        ,ftCurrency);
    FieldDefs.Add('VlICMST'        ,ftCurrency);
    FieldDefs.Add('VlIPI'          ,ftCurrency);
    FieldDefs.Add('VlServ'         ,ftCurrency);
    FieldDefs.Add('VlISS'          ,ftCurrency);
    FieldDefs.Add('VlDesc'         ,ftCurrency);
    FieldDefs.Add('VlTotal'        ,ftCurrency);
    FieldDefs.Add('TpTrans'        ,ftSmallint);
    IndexDefs.Clear;
    IndexDefs.Add('','EmpFil;TpDoc;NrDoc',[ixPrimary,ixUnique]);
    if pDebug then ShowMessage('Criando ' + fName + ' 02');
    Try
      CreateTable;
    Except
      nErr := nErr + 1;
      Mensag := Mensag + TableName + #13;
    End;
    cTab.Free;
    if pDebug then ShowMessage('Criado ' + fName + ' Free');

  end;
  //
  fName := pPath + 'LocNFEmitTot.DB';
  if pDebug then ShowMessage('Criando ' + fName + ' 01');
  cTab := TTable.Create(nil);
  with cTab
  do begin
    Active          := False;
    DatabaseName    := pPath;
    TableName       := 'LocNFEmitTot';
    TableType       := ttDefault;
    FieldDefs.Clear;
    FieldDefs.Add('TpDoc'        ,ftSmallint);
    FieldDefs.Add('VlrSaiTotal'  ,ftCurrency);
    FieldDefs.Add('QtdSaiTotal'  ,ftInteger);
    FieldDefs.Add('VlrSaiValid'  ,ftCurrency);
    FieldDefs.Add('QtdSaiValid'  ,ftInteger);
    FieldDefs.Add('VlrSaiCance'  ,ftCurrency);
    FieldDefs.Add('QtdSaiCance'  ,ftInteger);
    FieldDefs.Add('VlrSaiVenda'  ,ftCurrency);
    FieldDefs.Add('QtdSaiVenda'  ,ftInteger);
    FieldDefs.Add('VlrSaiOutra'  ,ftCurrency);
    FieldDefs.Add('QtdSaiOutra'  ,ftInteger);
    FieldDefs.Add('VlrEntTotal'  ,ftCurrency);
    FieldDefs.Add('QtdEntTotal'  ,ftInteger);
    FieldDefs.Add('VlrEntValid'  ,ftCurrency);
    FieldDefs.Add('QtdEntValid'  ,ftInteger);
    FieldDefs.Add('VlrEntCance'  ,ftCurrency);
    FieldDefs.Add('QtdEntCance'  ,ftInteger);
    FieldDefs.Add('VlrEntCompr'  ,ftCurrency);
    FieldDefs.Add('QtdEntCOmpr'  ,ftInteger);
    FieldDefs.Add('VlrEntOutra'  ,ftCurrency);
    FieldDefs.Add('QtdEntOutra'  ,ftInteger);
    FieldDefs.Add('QtdEspTotal'  ,ftInteger);
    FieldDefs.Add('QtdEspValid'  ,ftInteger);
    FieldDefs.Add('QtdEspEntra'  ,ftCurrency);
    FieldDefs.Add('QtdEspSaida'  ,ftInteger);
    IndexDefs.Clear;
    IndexDefs.Add('','TpDoc',[ixPrimary,ixUnique]);
    if pDebug then ShowMessage('Criando ' + fName + ' 02');
    Try
      CreateTable;
    Except
      nErr := nErr + 2;
      Mensag := Mensag + TableName + #13;
    End;
    cTab.Free;
    if pDebug then ShowMessage('Criado ' + fName + ' Free');

  end;
  //
  if nErr > 0
  then begin
    MessageDlg('Arquivos temporários não puderam ser criado (cod=' + IntToStr(nErr) + ')' + #13
               + pPath + '  ' + Mensag + #13
               + 'Remova o arquivo atualmente existente, feche toda a aplicação e tente novamente'
               ,mtInformation,[mbOk],0);
    Result := 1;
  end;

end;


Function CriaEtiquetasProdutos(pPath:String; pDebug:Boolean = False): Integer;
var i,nErr: Integer;
    fName,Mensag: String;
    cTab: TTable;
const xFiles: array [1..2] of String = ('Etiquetas.DB','EtiqPrint.DB');
begin
  if pDebug then ShowMessage('CriaEtiquetasProdutos - Início');
  Result := 0;
  nErr   := 0;
  Mensag := '';
  //
  if pDebug then ShowMessage('CriaEtiquetasProdutos - Excluindo');
  for i := 1 to 2
  do begin
    fName  := pPath + xFiles[i];
    if FileExists(fName)
    then Try
           DeleteFile(fName);
           Except
             nErr   := nErr + 1;
             Mensag := Mensag + fName + #13;
           End;
  end;
  if nErr > 0
  then begin
    MessageDlg('Não foi possível excluir arquivos(s):' + #13 + Mensag + #13
               + 'Feche a aplicação, remova os arquivos manualmente e tente novamente'
               ,mtInformation,[mbOk],0);
    Result := 1;
    Exit;
  end;
  //
  fName := pPath + xFiles[1];
  if pDebug then ShowMessage('Criando ' + fName + ' 01');
  cTab := TTable.Create(nil);
  with cTab
  do begin
    Active          := False;
    DatabaseName    := pPath;
    TableName       := 'Etiquetas';
    TableType       := ttDefault;
    FieldDefs.Clear;
    FieldDefs.Add('Item'       ,ftString, 13);
    FieldDefs.Add('Descricao'  ,ftString, 50);
    FieldDefs.Add('Unidade'    ,ftString, 3);
    FieldDefs.Add('Preco'      ,ftCurrency);
    FieldDefs.Add('Quant'      ,ftSmallint);
    FieldDefs.Add('Observ'     ,ftMemo,   10);
    IndexDefs.Clear;
    if pDebug then ShowMessage('Criando ' + fName + ' 02');
    Try
      CreateTable;
    Except
      nErr := nErr + 1;
      Mensag := Mensag + TableName + #13;
    End;
    cTab.Free;
    if pDebug then ShowMessage('Criado ' + fName + ' Free');
  end;
  //
  fName := pPath + 'EtiqPrint.DB';
  if pDebug then ShowMessage('Criando ' + fName + ' 01');
  cTab := TTable.Create(nil);
  with cTab
  do begin
    Active          := False;
    DatabaseName    := pPath;
    TableName       := 'EtiqPrint';
    TableType       := ttDefault;
    FieldDefs.Clear;
    FieldDefs.Add('Item'       ,ftString, 13);
    FieldDefs.Add('Descricao'  ,ftString, 50);
    FieldDefs.Add('Unidade'    ,ftString, 3);
    FieldDefs.Add('Preco'      ,ftCurrency);
    FieldDefs.Add('Observ'     ,ftMemo,   10);
    IndexDefs.Clear;
    if pDebug then ShowMessage('Criando ' + fName + ' 02');
    Try
      CreateTable;
    Except
      nErr := nErr + 2;
      Mensag := Mensag + TableName + #13;
    End;
    cTab.Free;
    if pDebug then ShowMessage('Criado ' + fName + ' Free');
  end;
  //
  if nErr > 0
  then begin
    MessageDlg('Arquivos temporários não puderam ser criado (cod=' + IntToStr(nErr) + ')' + #13
               + pPath + '  ' + Mensag + #13
               + 'Remova o arquivo atualmente existente, feche toda a aplicação e tente novamente'
               ,mtInformation,[mbOk],0);
    Result := 1;
  end;

end;


end.
