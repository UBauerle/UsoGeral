unit uSeguranca;

interface

uses SysUtils, Dialogs, DateUtils;
   Function CalculaAlgoritmo(pRazaoSocial,pFantasia,pCNPJ,pIEstadual: String; pValidade: TDateTime): Integer;
   Function VerificaValidSeguranca(pValidade:TDateTime; pAlgInformado,pAlgCalculado,pNDias:Integer; lMsg:Boolean):Integer;

implementation

// Calcula o algoritmo de segurança, considerando
//        pRazaoSocial: Razão social
//        pFantasia:    Nome fantasia
//        pCNPJ:        CNPJ
//        pIEstadual:   Inscrição Estadual
//        pValidade:    Data de validade
// Retorna o algoritmo calculado
Function CalculaAlgoritmo(pRazaoSocial,pFantasia,pCNPJ,pIEstadual: String; pValidade: TDateTime): Integer;
var i,j,nPos: Integer;
    xString,wString: String;
begin
  xString := chr(255);
  for i :=  254 downto 1
    do xString := xString + chr(i);
  wString := '**' + Trim(pRazaoSocial)
           + '**' + Trim(pFantasia)
           + '**' + Trim(pCNPJ)
           + '**' + Trim(pIEstadual)
           + '**' + DateToStr(pValidade) + '**';
  Result := 0;
  for i  := 1 to Length(wString)
  do begin;
    nPos   := Pos(wString[i],xString);
    j      := (nPos*nPos) * 2;
    Result := Result + j;
  end;

end;


Function VerificaValidSeguranca(pValidade:TDateTime; pAlgInformado,pAlgCalculado,pNDias:Integer; lMsg:Boolean): Integer;
// Faz a verificação de segurança do sistema
// pValidade:       Data de validade
// pAlgInformado:   Algoritmo informado (o que está no arq. master ou correspondente)
// pAlgCalculado:   Algoritmo calculado anteriormente (obtido dos dados do master)
// pNDias:          Dias para aviso de validade expirando...
// lMsg:            Emite ou não mensagem
// Retorna: 0: Ok
//          1: Faltam 'n' dias para expirar a validade
//          2: Algoritmo violado
//          3: Validade expirada
var   nDias: Real;
      wMsg: String;
begin
  Result := 0;
  wMsg   := 'Sistema FINALIZADO';
  if pAlgInformado <> pAlgCalculado
  then begin
    Result := 2;
    if lMsg
       then MessageDlg('Algoritmo VIOLADO' + #13 + wMsg,mtError,[mbOk],0);
    Exit;
  end;
  //
  if DateOf(Date) > DateOf(pValidade)
  then begin
    Result := 3;
    if lMsg
       then MessageDlg('Validade EXPIRADA' + #13 + wMsg,mtError,[mbOK],0);
    Exit;
  end;
  //
  nDias := DaysBetween(DateOf(pValidade),DateOf(Date));
  if nDias <= pNDias
  then begin
    MessageDlg('Validade do sistema' + #13 +
               'Faltam ' + FloatToStr(nDias) + ' dia(s) para que a validade do sistema se esgote' + #13 +
               'Entre em contato com o seu fornecedor ou comunique ao suporte',
               mtWarning,[mbOk],0);
    Result := 1;
  end;

end;

end.
