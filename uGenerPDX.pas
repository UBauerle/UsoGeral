unit uGenerPDX;

interface

uses
  Windows, SysUtils, Dialogs, DBTables, DB, DBClient, Classes;
  Function  GenRecordLock(pTabela:TTable;pMsg:Boolean): Boolean;                                                      // Ok
  Function  DataBaseState(wState:TDataSetState): String;                                                              // Ok
  Function  DSStateText(pState: TDataSetState): String;                                                               // Só existe aqui
  Function  uInicializaRegistro(pTable: TTable): Boolean;                                                             // Ok
  Function  uTransfereDados(pTbInput, pTbOutput: TTable; pnFieldInit:Integer = 0): Boolean;                           // Ok
  Function  uTransfDdNrCampo(pTbInput, pTbOutput: TTable): Boolean;                                                   // Ok
  Function  uTransfDd_DataSetTTable(pDSInput: TClientDataSet; pTbOutput: TTable; pnFieldInit:Integer = 0): Boolean;   // Ok
  Function  uTransfDd_TTableDataSet(pTbInput: TTable; pDSOutput: TClientDataSet): Boolean;                            // Ok
  Function  ExisteCampoNaTabela(pmtField:String; pmtTable:TTable): Boolean;                                           // Ok
  Function  ExisteCampoNoDataSet(pmtField:String; pmtDataSet:TDataSet): Boolean;                                      // Ok
  Function  CriaTabelaParadox(pmtStruct,pmtPath,pmtTabName:String;lExcluir:Boolean=True): Boolean;                    // Ok
  Function  RefreshCountRecord(pmtTable:TTable; pmtPos:String=''): String;                                            // Ok
  Function  CarregaRegistro(pTable:TTable; var pMemReg:Array of Variant; var pMemField: Array of String): Boolean;    // Ok
  Function  GravaRegistro(pTable:TTable; var pMemReg:Array of Variant; var pMemField: Array of String): Boolean;      // Ok
  Function  ApagaLCK(pPath:String; pMsg:Boolean=False): Boolean;

var
  wMsg: String;

implementation

Function GenRecordLock(pTabela:TTable;pMsg:Boolean): Boolean;
begin
  Try
    pTabela.Edit;
    Result := True;
  Except
    pTabela.Cancel;
    Result := False;
    if pMsg then MessageDlg('GenRecordLock - Bloqueio de registro' + #13 +
                            'Arquivo: ' + pTabela.TableName + #13 +
                            'Registro em uso por outro usuário, tente novamente dentro de instantes',mtWarning,[mbOk],0);
  End;

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


Function uInicializaRegistro(pTable: TTable): Boolean;
var i: Integer;
begin
{
FieldKind
fkData          Field represents a physical field in a database table
fkCalculated	  Field is calculated in an OnCalcFields event handler
fkLookup	      Field is a lookup field. (Not implemented for fields on unidirectional datasets)
fkInter nalCalc	Field is calculated but values are stored in the dataset.
fkAggregate	    Field represents a maintained aggregate in a client dataset.
}
  Result := False;
  for i  := 0 to pTable.FieldCount-1
  do begin
    if (not pTable.Fields[i].Calculated) and (not pTable.Fields[i].Lookup)
    then begin
      case pTable.FieldDefs[i].DataType of
        ftString:      pTable.Fields[i].AsString   := '';
        ftSmallint:    pTable.Fields[i].AsInteger  := 0;
        ftInteger:     pTable.Fields[i].AsInteger  := 0;
        ftWord:        pTable.Fields[i].AsInteger  := 0;
        ftBoolean:     pTable.Fields[i].AsBoolean  := False;
        ftFloat:       pTable.Fields[i].AsInteger  := 0;
        ftCurrency:    pTable.Fields[i].AsInteger  := 0;
        ftBCD:         pTable.Fields[i].AsFloat    := 0;
        ftDate:        pTable.Fields[i].Clear;
        ftTime:        pTable.Fields[i].Clear;
        ftDateTime:    pTable.Fields[i].Clear;
        ftBytes:       pTable.Fields[i].Clear;
        ftVarBytes:    pTable.Fields[i].Clear;
        ftBlob:        pTable.Fields[i].Clear;
        ftMemo:        pTable.Fields[i].Clear;
        ftGraphic:     pTable.Fields[i].Clear;
        ftFmtMemo:     pTable.Fields[i].Clear;
        ftParadoxOle:  pTable.Fields[i].Clear;
        ftDBaseOle:    pTable.Fields[i].Clear;
        ftTypedBinary: pTable.Fields[i].Clear;
        ftFixedChar:   pTable.Fields[i].AsString   := '';    //Clear;
        ftWideString:  pTable.Fields[i].AsString   := '';    //Clear;
        ftLargeint:    pTable.Fields[i].AsInteger  := 0;
        else if pTable.Fields[i].DataType <> ftAutoInc
                then pTable.Fields[i].Clear;
      end;
    end;
  end;
  Result := True;

end;


Function uTransfereDados(pTbInput, pTbOutput: TTable; pnFieldInit:Integer = 0): Boolean;
var i,nFInic,nErros: Integer;
    wFieldName: String;
begin
  Result  := False;
  nErros  := 0;
  nFInic  := pnFieldInit;
  for i   := nFInic to pTbInput.FieldCount-1
  do begin
    if (not pTbInput.Fields[i].Calculated) and (not pTbInput.Fields[i].Lookup)
    then begin
      wFieldName := pTbInput.Fields[i].FieldName;
      if ExisteCampoNaTabela(wFieldName, pTbOutput)
      then Try
             pTbOutput.FieldByName(wFieldName).AsVariant  := pTbInput.FieldByName(wFieldName).AsVariant;
           Except
             nErros := nErros + 1;
           End;
    end;
  end;
  if nErros = 0
     then Result := True;

end;


Function uTransfDdNrCampo(pTbInput, pTbOutput: TTable): Boolean;
var i,nErros: Integer;
begin
  Result  := False;
  nErros  := 0;
  for i   := 0 to pTbInput.FieldCount-1
  do begin
    if (not pTbInput.Fields[i].Calculated)
       and (not pTbInput.Fields[i].Lookup)
    then begin
      Try
        pTbOutput.Fields[i].AsVariant  := pTbInput.Fields[i].AsVariant;
      Except
        nErros := nErros + 1;
      End;
    end;
  end;
  if nErros = 0
     then Result := True;

end;


Function uTransfDd_DataSetTTable(pDSInput: TClientDataSet; pTbOutput: TTable; pnFieldInit:Integer = 0): Boolean;
var i,nFInic,nErros: Integer;
    wFieldName: String;
begin
  Result  := False;
  nErros  := 0;
  nFInic  := pnFieldInit;
  for i   := nFInic to pDSInput.FieldCount-1
  do begin
    if (not pDSInput.Fields[i].Calculated) and (not pDSInput.Fields[i].Lookup)   // pDSInput.Fields[i].FieldKind = fkData
    then begin
      wFieldName := pDSInput.Fields[i].FieldName;
      if ExisteCampoNaTabela(wFieldName, pTbOutput)
      then Try
             pTbOutput.FieldByName(wFieldName).AsVariant  := pDSInput.FieldByName(wFieldName).AsVariant;
           Except
             nErros := nErros + 1;
           End;
    end;
  end;
  if nErros = 0
     then Result := True;

end;


Function uTransfDd_TTableDataSet(pTbInput: TTable; pDSOutput: TClientDataSet): Boolean;
var i,nErros: Integer;
    wFieldName: String;
begin
  Result  := False;
  nErros  := 0;
  for i   := 0 to pTbInput.FieldCount-1
  do begin
    if (not pTbInput.Fields[i].Calculated) and (not pTbInput.Fields[i].Lookup)   // pTbInput.Fields[i].FieldKind = fkData
    then begin
      wFieldName := pTbInput.Fields[i].FieldName;
      if ExisteCampoNoDataSet(wFieldName, pDSOutput)
      then Try
             pDSOutput.FieldByName(wFieldName).AsVariant  := pTbInput.FieldByName(wFieldName).AsVariant;
           Except
             nErros := nErros + 1;
           End;
    end;
  end;
  if nErros = 0
     then Result := True;

end;


Function  ExisteCampoNaTabela(pmtField:String; pmtTable:TTable): Boolean;
var i: Integer;
    wField: String;
begin
  Result   := False;
  pmtField := AnsiUpperCase(pmtField);
  for i := 0 to pmtTable.Fields.Count-1
  do begin
    wField := AnsiUpperCase(pmtTable.Fields[i].FieldName);
    if pmtField = wField
    then begin
      Result := True;
      Break;
    end;
  end;

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


Function CriaTabelaParadox(pmtStruct,pmtPath,pmtTabName:String;lExcluir:Boolean=True): Boolean;
var wEstrutura: TStringList;
    wCampos,wTipo,wTam,wPrec,wIdxNome,wIdxCampos,xArquivos: TStringList;
    wArqID: String;
    i,j,nP,nErros,nTam,nPrec: Integer;
    xLinha,xDado: String;
    lPriKey,lMemField: Boolean;
    nSecKey: Integer;
    cTab: TTable;
const xTipos: array[1..16] of String = ('String', 'ShortInt', 'Int', 'Word', 'Boolean', 'Float', 'Currency', 'BCD',
                                        'Date', 'Time', 'DateTime', 'Bytes', 'VarBytes', 'Blob', 'Memo', 'Graphic');
begin
  Result := False;
  if not FileExists(pmtStruct)
  then begin
    MessageDlg('Definição de estrutura não encontrada' + #13 + '     [ ' + pmtStruct + ' ]',mtError,[mbOK],0);
    Exit;
  end;
  if not DirectoryExists(pmtPath)
  then begin
    MessageDlg('Diretorio inexistente: ' + pmtPath,mtError,[mbOk],0);
    Exit;
  end;
  wArqId     := IncludeTrailingPathDelimiter(pmtPath) + pmtTabName + '.' ;
  wEstrutura := TStringList.Create;
  wEstrutura.LoadFromFile(pmtStruct);
  wCampos    := TStringList.Create;     // Nomes dos campos
  wTipo      := TStringList.Create;     // Tipos de dados
  wTam       := TStringList.Create;     // Tamanho
  wPrec      := TStringList.Create;     // Precisao
  wIdxNome   := TStringList.Create;     // Nomes dos índices
  wIdxCampos := TStringList.Create;     // Campos que compoem o indice;
  lPriKey    := False;                  // Indicador de chave primaria
  nSecKey    := 0;                      // Indicador de quantos indices secundarios existem
  lMemField  := False;                  // Indicador se há campos 'Memo'
  for i := 0 to wEstrutura.Count-1
  do begin
    xLinha := wEstrutura[i];
    nP     := Pos(';',xLinha);
    xDado  := Copy(xLinha,1,nP-1);
    xLinha := Copy(xLinha,nP+1,Length(xLinha)-nP);
    if xDado = '<Idx>'
    then begin             // Tratativa de indice
      nP     := Pos(';',xLinha);
      xDado  := Copy(xLinha,1,nP-1);
      xLinha := Copy(xLinha,nP+1,Length(xLinha)-nP);
      if xDado = 'Primary key'
         then lPriKey := True
         else nSecKey := nSecKey + 1;
      wIdxNome.Add(xDado);                              // Nome do indice
      wIdxCampos.Add(xLinha);                           // Campos do índice
    end
    else begin                     // Tratativa de campos
      // Nome do campo
      wCampos.Add(xDado);
      // Tipo de dado
      nP     := Pos(';',xLinha);
      xDado  := Copy(xLinha,1,nP-1);
      xLinha := Copy(xLinha,np+1,Length(xLinha)-nP);
      wTipo.Add(xDado);
      if (xDado = 'Memo') or (xDado = 'Blob') or (xDado = 'Graphic')
          then lMemField := True;
      // Tamanho (Size)
      nP     := Pos(';',xLinha);
      xDado  := Copy(xLinha,1,nP-1);
      xLinha := Copy(xLinha,np+1,Length(xLinha)-nP);
      wTam.Add(xDado);
      // Precisão (Precision)
      xDado  := xLinha;
      wPrec.Add(xDado);
    end;
  end;
  //
  // Define arquivos a serem excluidos
  nErros := 0;
  if lExcluir
  then begin
    xLinha     := '';
    xArquivos  := TStringList.Create;
    xArquivos.Add(wArqId + 'DB');
    if lMemField then xArquivos.Add(wArqId + 'MB');
    if lPriKey then xArquivos.Add(wArqId + 'PX');
    for i := 0 to nSecKey-1
      do xArquivos.Add(wArqID + 'XG' + IntToStr(i));
    for i := 0 to nSecKey-1
      do xArquivos.Add(wArqId + 'YG' + IntToStr(i));
    for i := 0 to xArquivos.Count-1
    do Try
         DeleteFile(xArquivos[i]);
       Except
         nErros := nErros + 1;
         xLinha := xLinha + xArquivos[i] + #13;
       End;
    xArquivos.Free;
    if nErros > 0
    then MessageDlg('Falha na exclusão de arquivos' + #13 + xLinha,mtError,[mbOk],0);
  end;
  if nErros > 0
  then begin
    wEstrutura.Free;
    wCampos.Free;
    wTipo.Free;
    wTam.Free;
    wPrec.Free;
    wIdxNome.Free;
    wIdxCampos.Free;
    Exit;
  end;
  // Cria Arquivo
  cTab              := TTable.Create(nil);
  with cTab
  do begin
    Active       := False;
    DatabaseName := pmtPath;
    TableName    := pmtTabName + '.DB';
    TableType    := ttDefault;
    FieldDefs.Clear;
    IndexDefs.Clear;
    for i := 0 to wCampos.Count-1
    do begin
      nTam  := StrToIntDef(wTam[i],0);
      nPrec := StrToIntDef(wPrec[i],0);
      nP    := 0;
      for j := 1 to Length(xTipos)
      do if wTipo[i] = xTipos[j]
         then begin
           nP := j;
           Break;
         end;
      case nP of
         1:FieldDefs.Add(wCampos[i],ftString,nTam);                       // String
         2:FieldDefs.Add(wCampos[i],ftSmallint);                          // ShorInt
         3:FieldDefs.Add(wCampos[i],ftInteger);                           // Int
         4:FieldDefs.Add(wCampos[i],ftWord);                              // Word
         5:FieldDefs.Add(wCampos[i],ftBoolean);                           // Boolean
         6:FieldDefs.Add(wCampos[i],ftFloat);                             // Float
         7:FieldDefs.Add(wCampos[i],ftCurrency);                          // Currency
         8:FieldDefs.Add(wCampos[i],ftBCD,nTam);                          // BCD
         9:FieldDefs.Add(wCampos[i],ftDate);                              // Date
        10:FieldDefs.Add(wCampos[i],ftTime);                              // Time'
        11:FieldDefs.Add(wCampos[i],ftDateTime);                          // DateTime
        12:FieldDefs.Add(wCampos[i],ftBytes);                             // Bytes
        13:FieldDefs.Add(wCampos[i],ftVarBytes);                          // VarBytes
        14:FieldDefs.Add(wCampos[i],ftBlob,nTam);                         // Blob
        15:FieldDefs.Add(wCampos[i],ftMemo,nTam);                         // Memo
        16:FieldDefs.Add(wCampos[i],ftGraphic,nTam);                      // Graphic
      end;
    end;
    //
    for i := 0 to wIdxNome.Count-1
    do begin
      xDado  := wIdxNome[i];
      xLinha := wIdxCampos[i];
      if xDado = 'Primary key'
         then IndexDefs.Add('',wIdxCampos[i],[ixPrimary,ixUnique])
         else IndexDefs.Add(wIdxNome[i],wIdxCampos[i],[ixCaseInsensitive]);
    end;
    //
    Try
      CreateTable;
      Result := True;
    Except
      MessageDlg('Falha na criação da tabela' + #13 +
                 'Diretório=' + pmtPath + #13 +
                 'Tabela=' + pmtTabName,
                 mtError,[mbOk],0);
    End;
  end;
  cTab.Free;
  wEstrutura.Free;
  wCampos.Free;
  wTipo.Free;
  wTam.Free;
  wPrec.Free;
  wIdxNome.Free;
  wIdxCampos.Free;

end;


Function RefreshCountRecord(pmtTable:TTable; pmtPos:String=''): String;
var nRegs: Integer;
begin
  Result := 'Tabela fechada';
  if pmtTable.Active
  then begin
    pmtTable.Refresh;
    if (pmtPos = 'I') or (pmtPos = 'i')
    then pmtTable.First
    else if (pmtPos = 'F') or (pmtPos = 'f')
         then pmtTable.Last;
    nRegs := pmtTable.RecordCount;
    if nRegs = 0
       then Result := 'Não há registros'
       else Result := IntToStr(pmtTable.RecordCount) + ' registros';
  end;

end;


Function  CarregaRegistro(pTable:TTable; var pMemReg:Array of Variant; var pMemField: Array of String): Boolean;
var nField,i,j: Integer;
begin
  Result := False;
  nField := pTable.Fields.Count;
  if nField > 255
     then nField := 255;
  for i := 0 to nField-1
  do pMemField[i] := '';
  //
  j := 0;
  for i := 0 to nField-1
  do if pTable.Fields[i].FieldKind = fkData
     then begin
       pMemField[j] := pTable.Fields[i].FieldName;
       pMemReg[j]   := pTable.Fields[i].AsVariant;
       j := j + 1;
     end;
  //
  Result := True;

end;


Function  GravaRegistro(pTable:TTable; var pMemReg:Array of Variant; var pMemField: Array of String): Boolean;
var nField,i,j: Integer;
    wFields: String;
begin
  Result := False;
  nField := pTable.Fields.Count;
  if nField > 255
     then nField := 255;
  //
  for i := 0 to Length(pMemField)-1
  do begin
    for j := 0 to nField-1
    do if pMemField[i] = pTable.Fields[j].FieldName
       then begin
         pTable.Fields[j].AsVariant := pMemReg[i];
         Break;
       end;
  end;
  //
  Result := True;

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


end.
