unit uProcessos;

interface
  uses Windows, TLHelp32, SysUtils, Dialogs;
  Function exProcessoAtivo(pExeName:String; pExibMsg:Boolean; pAlter:Boolean): Integer;
  Function exKillProcess(pExeName:String; pExibMsg:Boolean): Boolean;
  Function exVerificaFinalizaProcesso(pExeName:String; pExibMsg:Boolean; pAlter:Boolean): Boolean;
  Function ProcessosConflitantes(pAplicacao:String; pConflitos:array of String):Boolean;
  Function VerificaPreRequisitos(pPreReq: array of String; pPath, pExec: String): Boolean;
  Function ProcessoAtivo(pExeName:String): Boolean;

implementation


Function exProcessoAtivo(pExeName:String; pExibMsg:Boolean; pAlter:Boolean): Integer;
// Parametros  pExeName: Nome do processo (executavel)
//             pExibMsg: True-Exibe mensagem, False-Não exibe mensagem
//             pAlter:   True-Permite outro processo,  False-NÃO permite outro processo
//
// Retorno     0-Processo não existe
//             3-Anteriormente ATIVO, finalizar TODAS as instancias do processo                  (mbYes)
//             4-Anteriormente ATIVO, não finalizar nenhuma instancia do processo e inicia novo  (mbNo)
//             5-Anteriormente ATIVO, abortar processo atual (não inicia)                        (mbAbort)
// Valores de retorno de MessageDlg
// Obs: Se processo anteriormente ativo e NÃO exibe mensagem o retorno será 5 (mbAbort)
var wAplic,wMensag: String;
begin
  Result := 0;
  CreateMutex(nil,False,PChar(pExeName));
  if GetLastError = ERROR_ALREADY_EXISTS
  then begin
    wAplic := UpperCase(pExeName);
    if Pos('.EXE',wAplic) = 0
       then wAplic := wAplic + '.EXE';
    wMensag := 'Verificação' + #13 + wAplic + ' em execução' + #13#13;
    if pExibMsg
    then begin
      if pAlter then wMensag := wMensag + 'Finalizar todas as instancias anteriores do processo ?'
                else wMensag := wMensag + 'Finalizar instancias anteriores ?';
      if pAlter then
        Result := MessageDlg(wMensag,mtConfirmation,[mbYes,mbNo,mbAbort],0,mbYes,['Sim','Não','Abortar'])
      else
        Result := MessageDlg(wMensag,mtConfirmation,[mbYes,mbAbort],0,mbYes,['Sim','Abortar']);
    end
    else begin
      if pAlter then Result := 5          // Permite instancias anteriores
                else Result := 3;         // Encerra TODAS as instancias anteriores
    end;
  end;

end;


Function exKillProcess(pExeName:String; pExibMsg:Boolean): Boolean;
var
  ContinueLoop: Boolean;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
  ctaProc,i,nKills,nErros: Integer;
  nProcessos: array[0..299] of Integer;
  procExeFileName,procExeFile: String;

begin
  Result := True;
  pExeName := UpperCase(pExeName);
  for i := 0 to 299
    do nProcessos[i] := -1;
  //
  ctaProc := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  while ContinueLoop
  do begin
    procExeFileName := UpperCase(ExtractFileName(FProcessEntry32.szExeFile));
    procExeFile := UpperCase(FProcessEntry32.szExeFile);
    if (procExeFileName = pExeName)
      or (procExeFile = pExeName)
    then begin
      nProcessos[ctaProc] := FProcessEntry32.th32ProcessID;
      ctaProc := ctaProc + 1;
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    if ctaProc > 99
    then begin
      ctaProc := 99;
      ContinueLoop := False;
    end;
  end;
  //
  nKills := 0;
  nErros := 0;
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  while ContinueLoop
  do begin
    for i := 0 to ctaProc-2
    do if FProcessEntry32.th32ProcessID = nProcessos[i]
       then begin
         Try
           TerminateProcess(OpenProcess(PROCESS_TERMINATE,
                            BOOL(0),
                            FProcessEntry32.th32ProcessID),
                            0);
           nKills := nKills + 1;
         Except
           nErros := nErros + 1;
         End;
         Break;
       end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
  if nErros > 0
  then begin
    Result := False;
    MessageDlg('Verificação de processos' + #13 +
               IntToStr(nErros) + ' processo(s) NÃO finalizado(s) [' + pExeName + ']',
               mtError,[mbOk],0);
  end
  else if pExibMsg         // nKills > 0
       then MessageDlg('Verificação de processos' + #13 +
                       IntToStr(nKills) + ' processo(s) finalizado(s) [' + pExeName + ']',
                       mtInformation,[mbOk],0);

end;


Function exVerificaFinalizaProcesso(pExeName:String; pExibMsg:Boolean; pAlter:Boolean): Boolean;
// Parametros  pExeName: Nome do processo (executavel)
//             pExibMsg: True-Exibe mensagem, False-Não exibe mensagem
//             pAlter:   True-Permite outro processo,  False-NÃO permite outro processo
// Retorno     True   processo pode ser iniciado
//             False  processo NÃO pode ser iniciado
var nAcao: Integer;
begin
  nAcao := exProcessoAtivo(pExeName, pExibMsg, pAlter);
  case nAcao of
    3:Result := exKillProcess(pExeName, pExibMsg);
    0,4:Result := True;
    else Result := False;       // 5:
  end;

end;


{ -- Original
function killtask(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;
// Uso: killtask('notepad.exe');
--------------- }

Function ProcessosConflitantes(pAplicacao:String; pConflitos:array of String):Boolean;
var i,nConf: Integer;
    wMsg,wAtivo: String;
    nHand: THandle;
begin
  Result := False;
  nConf  := 0;
  wMsg   := '';
  for i  := 0 to Length(pConflitos)-1
  do begin
    wAtivo := pConflitos[i];
    nHand  := FindWindow(nil,PChar(wAtivo));
    if nHand <> 0
    then begin
      nConf := nConf + 1;
      wMsg  := wMsg + '[ ' + wAtivo + ' ]' + #13;
    end;
  end;
  if nConf = 0
  then Result := True
  else begin
    wMsg := 'Aplicação [ ' + pAplicacao + ' ]' + #13
            + 'Não pode ser executada, há ' + IntToStr(nConf) + ' processo(s) conflitante(s) ativo(s)' + #13
            + wMsg + #13
            + 'Feche o(s) processo(s) indicado(s) e reinicie a aplicação atual';
    MessageBox(0,PChar(wMsg),'ERRO',MB_ICONSTOP);
  end;
{
   MessageDlg('Aplicação [ ' + pAplicacao + ' ]' + #13
                  + 'Não pode ser executada, há ' + IntToStr(nConf) + ' processo(s) conflitante(s) ativo(s)' + #13
                  + wMsg + #13
                  + 'Feche o(s) processo(s) indicado(s) e reinicie a aplicação atual'
                  ,mtError,[mbOk],0);
}
end;


Function  VerificaPreRequisitos(pPreReq: array of String; pPath, pExec: String): Boolean;
// pPreReq: array com os pré-requisitos necessários (DLLs, Ini, etc)  ex: ['libeay32.dll','ssleay32.dll','cfgemail.ini','xyz.dll']
// pExec:   nome do executável
// pPath:   path de onde o executável é ativado
var i,nErros: Integer;
    wArqPReq: String;
    wMsg: String;
begin
  Result := True;
  nErros := 0;
  wMsg   := '';
  for i := 0 to Length(pPreReq)-1
  do begin
    wArqPReq := pPath + pPreReq[i];
    if not FileExists(wArqPReq)
    then begin
      wMsg   := wMsg + '[ ' + wArqPReq + ' ]' + #13;
      nErros := nErros + 1;
    end;
  end;
  if nErros > 0
  then begin
    wMsg := 'Pré-requisitos não encontrados [' + IntToStr(nErros) + ']' + #13
         + wMsg + #13
         + 'DLL / Ini obrigatórias no diretório do executavel' + #13
         + 'Executável: ' + pPath + pExec + #13 
         + 'Sistema não iniciado, avise o suporte';
    MessageBox(0,PChar(wMsg),'ERRO',MB_OK);
    Result := False;
  end;

end;



Function ProcessoAtivo(pExeName:String): Boolean;
// Parametros  pExeName: Nome do processo (executavel)
// Retorno     True: Processo existe
//             False: Processo NÃO existe
begin
  Result := False;
  CreateMutex(nil,False,PChar(pExeName));
  if GetLastError = ERROR_ALREADY_EXISTS then
    Result := True;

end;


end.
