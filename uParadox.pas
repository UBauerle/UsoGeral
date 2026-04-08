unit uParadox;

interface

uses Sysutils, Bde;

Function ParadoxChangeNetDir(pDiretorio:String): Boolean;
Function ParadoxActualNetDir: String;
Function ParadoxDeletePdoxUsrs(pDiretorio:String): Boolean;

implementation


Function ParadoxChangeNetDir(pDiretorio:String): Boolean;
var
  hCur: hDBICur;
  Config: CFGDesc;
  Cont: Boolean;
begin
  Result := False;
  if DbiInit(nil) = DBIERR_NONE
  then begin
    hCur := nil;
    if DbiOpenCfgInfoList(nil, dbiREADWRITE, cfgPersistent, '\DRIVERS\PARADOX\INIT', hCur) = DBIERR_NONE
    then begin
      if DbiSetToBegin(hCur) = DBIERR_NONE
      then begin
        Cont := True;
        while Cont do
        begin
          if (DbiGetNextRecord(hCur, dbiWRITELOCK, @Config, nil)  <> DBIERR_NONE)
          then Cont := False
          else if StrIComp(Config.szNodeName, 'NET DIR') = 0
               then begin
                 StrPCopy(Config.szValue, pDiretorio);
                 DbiModifyRecord(hCur, @Config, True);
                 Cont := False;
                 Result := True;
               end;
        end;
      end;
    end;
    DbiExit();
  end;

end;


Function ParadoxActualNetDir: String;
var
  hCur: hDBICur;
  Config: CFGDesc;
  Cont: Boolean;
begin
  if DbiInit(nil) = DBIERR_NONE
  then begin
    hCur := nil;
    if DbiOpenCfgInfoList(nil, dbiREADWRITE, cfgPersistent, '\DRIVERS\PARADOX\INIT', hCur) = DBIERR_NONE
    then begin
      if DbiSetToBegin(hCur) = DBIERR_NONE
      then begin
        Cont := True;
        while Cont do
        begin
          if (DbiGetNextRecord(hCur, dbiWRITELOCK, @Config, nil)  <> DBIERR_NONE)
          then Cont := False
          else if StrIComp(Config.szNodeName, 'NET DIR') = 0
               then begin
                 Result := Config.szValue;
                 Cont := False;
               end;
        end;
      end;
    end;
    DbiExit();
  end;

end;


Function ParadoxDeletePdoxUsrs(pDiretorio:String): Boolean;
var fPdox: string;
begin
  fPdox := pDiretorio + '\PDOXUSRS.NET';
  Result := True;
  if FileExists(fPdox)
  then Try
         DeleteFile(fPdox);
       Except
         Result := False;
       End;

end;


end.
