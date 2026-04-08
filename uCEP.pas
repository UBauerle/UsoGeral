unit uCEP;

interface

uses
  IniFiles,SysUtils,Windows,Forms,Dialogs,ShellAPI;
  Function Busca_CEP(pmtCEP:String; var CEP:String; var Lograd:String;var Bairro:String; var Munic:String; var UF:String; var IBGE:String):Boolean;
  Function Busca_Logradouro(var CEP:String; var Lograd:String;var Bairro:String; var Munic:String; var UF:String; var IBGE:String):Boolean;

var
  wArqExe,wArqRet: String;
  wComando,wParametro: String;
  hWnd: THandle;

implementation

Function Busca_CEP(pmtCEP:String; var CEP:String; var Lograd:String;var Bairro:String; var Munic:String; var UF:String; var IBGE:String):Boolean;
var nTimeOut: Integer;
    wIni: TIniFile;
begin
  Result  := False;
  wArqExe := ExtractFilePath(Application.ExeName) + 'rACBrCEP.Exe';
  wArqRet := ExtractFilePath(Application.ExeName) + 'ACBrCEP_Ret.ini';
  if not FileExists(wArqExe)
  then begin
    MessageDlg(wArqExe + ' : não encontrado',mtError,[mbOk],0);
    Exit;
  end;
  if FileExists(wArqRet)
     then DeleteFile(PChar(wArqRet));
  wComando := wArqExe;
  wParametro := pmtCEP;
  ShellExecute(hWnd,'open',PChar(wComando),PChar(wParametro),'',SW_SHOWDEFAULT);
  //WinExec(PChar(wComando), SW_SHOWDEFAULT);
  nTimeOut := 0;
  while (not FileExists(wArqRet)) and (nTimeOut < 121)
  do begin
    sleep(500);
    nTimeOut := nTimeOut + 1;
  end;
  if nTimeOut > 120
  then begin
    CEP    := '99999999';
    Lograd := 'Tempo de espera excedido';
    Bairro := '';
    Munic  := '';
    UF     := '';
    IBGE   := '';
  end
  else begin
    wIni   := TIniFile.Create(wArqRet);
    CEP    := wIni.ReadString('Retorno','CEP','99999999');
    Lograd := wIni.ReadString('Retorno','Logradouro','Nenhum endereço encontrado *');
    Bairro := wIni.ReadString('Retorno','Bairro','');
    Munic  := wIni.ReadString('Retorno','Municipio','');
    UF     := wIni.ReadString('Retorno','SiglaUF','');
    IBGE   := wIni.ReadString('Retorno','IBGE','');
  end;
  if CEP = '99999999'
    then MessageDlg('CEP informado ' + Copy(pmtCEP,1,2) + '.' + Copy(pmtCEP,3,3) + '-' + Copy(pmtCEP,6,3) + ' ' + Lograd,mtError,[mbOk],0)
    else Result := True;

end;


Function Busca_Logradouro(var CEP:String; var Lograd:String;var Bairro:String; var Munic:String; var UF:String; var IBGE:String):Boolean;
var nTimeOut: Integer;
    wIni: TIniFile;
begin
  Result  := False;
  wArqExe := ExtractFilePath(Application.ExeName) + 'rACBrCEP.Exe';
  wArqRet := ExtractFilePath(Application.ExeName) + 'ACBrCEP_Ret.ini';
  if not FileExists(wArqExe)
  then begin
    MessageDlg(wArqExe + ' : não encontrado',mtError,[mbOk],0);
    Exit;
  end;
  if FileExists(wArqRet)
     then DeleteFile(PChar(wArqRet));

  wComando := wArqExe;
  wParametro := '';
  ShellExecute(hWnd,'open',PChar(wComando),PChar(wParametro),'',SW_SHOWDEFAULT);
//  WinExec(PAnsiChar(wComando), SW_SHOWDEFAULT);

  nTimeOut := 0;
  while (not FileExists(wArqRet)) and (nTimeOut < 241)
  do begin
    sleep(500);
    nTimeOut := nTimeOut + 1;
  end;
  if nTimeOut > 240
  then begin
    CEP    := '9999999';
    Lograd := 'Tempo de espera excedido';
    Bairro := 'Timeout';
    Munic  := '';
    UF     := '';
    IBGE   := '';
  end
  else begin
    wIni   := TIniFile.Create(wArqRet);
    CEP    := wIni.ReadString('Retorno','CEP','');
    Lograd := wIni.ReadString('Retorno','Logradouro','Nenhum endereço encontrado *');
    Bairro := wIni.ReadString('Retorno','Bairro','');
    Munic  := wIni.ReadString('Retorno','Municipio','');
    UF     := wIni.ReadString('Retorno','SiglaUF','');
    IBGE   := wIni.ReadString('Retorno','IBGE','');
  end;
  if CEP = '99999999'
     then MessageDlg('Nenhum endereço localizado ou ' + Lograd + ' ' + Bairro,mtError,[mbOk],0)
     else Result := True

end;


end.
