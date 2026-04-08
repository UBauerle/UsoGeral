unit uWhatsApp;

interface
  Uses SysUtils,Classes,Dialogs,DateUtils;
  Function WAPP_EnviaMensagem(pPathWAPP,pAnexo,pPathEnvio,pNroWhats,pAssunto:String;
                              pCliente:Integer;
                              pDtHrUtl:TDateTime;
                              pMensagem:TStringList): Boolean;

implementation


Function WABarraFinal(pmtPath:String;pYes:Boolean=True): String;
// pYes = True  (SIM), colocar a barra final se não existir
//      = False (NAO), sem barra final, tirar se existir
var iMax: Integer;
begin
  Result := Trim(pmtPath);
  iMax   := Length(Result);
  if iMax < 1 then Exit;
  if pYes
  then begin
    if Result[iMax] <> '\'
       then Result := Result + '\';
  end
  else begin
    if Result[iMax] = '\'
       then Result := Copy(Result,1,iMax-1);
  end;

end;

Function WADtHrStr(pDtHr:TDateTime): String;
var wAno,wMes,wDia,wHor,wMin,wSeg,wMSe: Word;
    xAno,xMes,xDia,xHor,xMin,xSeg,xMSe: String;
begin
  DecodeDateTime(pDtHr,wAno,wMes,wDia,wHor,wMin,wSeg,wMSe);
  xAno := IntToStr(wAno);
  if Length(xAno) = 2 then xAno := '20' + xAno;
  xMes := IntToStr(wMes);
  if Length(xMes) = 1 then xMes := '0' + xMes;
  xDia := IntToStr(wDia);
  if Length(xDia) = 1 then xDia := '0' + xDia;
  xHor := IntToStr(wHor);
  if Length(xHor) = 1 then xHor := '0' + xHor;
  xMin := IntToStr(wMin);
  if Length(xMin) = 1 then xMin := '0' + xMin;
  xSeg := IntToStr(wSeg);
  if Length(xSeg) = 1 then xSeg := '0' + xSeg;
  xMSe := IntToStr(wMSe);
  while Length(xMSe) < 3
    do xMSe := '0' + xMSe;
  Result := xAno + xMes + xDia + xHor + xMin + xSeg + xMSe;

end;


Function WAPP_EnviaMensagem(pPathWAPP,pAnexo,pPathEnvio,pNroWhats,pAssunto:String;
                            pCliente:Integer;
                            pDtHrUtl:TDateTime;
                            pMensagem:TStringList): Boolean;
{
 pPathWAPP:  Pasta onde o arquivo de envio whats será gravado (WAPOficina) (Nr, Arquivo, etc)
 pAnexo:     Arquivo anexo (pode ser .Txt ou .PDF), Se for .Txt -> Transformar em mensagem
 pPathEnvio: Pasta que o WAPOficina reconhece (fisicamente é o mesmo pPathWAPP)
 pNroWhats:  Nro para onde será enviado
 pAssunto:   Assunto/Mensagem (Tópico)
 pCliente:   Código do cliente, se houver
 pDtHrUtl:   Data e Hora utilizada (Data + Hora (HHMMSSMSe)
 pMensagem:  Mensagem completa (TStringList)
 Retorno:    True / False
 Grava um arquivo para o 'monitor' whats contendo (.ini):
    contato  (nr. whats)
    Anexo    (arquivo anexo)
    mensagem (Assunto)
    linhas   (qtd de linhas da mensagem)
    LinMsgxx (Cada uma das linhas da mensagem completa)
    Cliente  (Codigo do cliente)
    DataHora (data/hora do envio)
}
var whatsFile,anexoDest,anexoMon: String;
    lWait: Boolean;
    nCount,nLin: Integer;
    linAuxil: String;
    Origem,Destino: TFileStream;
    wStrList: TStringList;
begin
  Result     := False;
  pPathWAPP  := WABarraFinal(pPathWAPP);
  whatsFile  := pPathWAPP + 'Envio.Txt';
  pPathEnvio := WABarraFinal(pPathEnvio);
  lWait      := FileExists(whatsFile);
  nCount     := 0;
  while lWait
  do begin
    Sleep(250);
    lWait  := FileExists(WhatsFile);
    nCount := nCount + 1;
    if nCount > 8
       then lWait := False;
  end;
  if FileExists(whatsFile)
  then if not DeleteFile(whatsFile)
       then begin
         MessageDlg('uWhatsApp - Erro' + #13 +
                    'Não foi possível excluir arquivo' + #13 +
                    '[ ' + WhatsFile + ' ]' + #13 +
                    'Envio não efetuado',mtError,[mbOk],0);
         Exit;
       end;
  // Anexo
  anexoDest := '';
  if FileExists(pAnexo)
  then begin
    anexoDest := pPathWAPP + ExtractFileName(pAnexo);
    anexoMon  := pPathEnvio + ExtractFileName(pAnexo);
    nCount    := 0;
    lWait     := FileExists(anexoDest);
    while lWait
    do begin
      if DeleteFile(anexoDest)
      then lWait := False
      else begin
        nCount    := nCount + 1;
        anexoDest := pPathWAPP + IntToStr(nCount) + ExtractFileName(pAnexo);
        anexoMon  := pPathEnvio + IntToStr(nCount) + ExtractFileName(pAnexo);
      end;
      if nCount > 20
      then begin
        lWait     := False;
        anexoDest := '';
      end;
    end;
    if Length(Trim(anexoDest)) > 0
    then Try
           Origem  := TFileStream.Create(pAnexo, fmOpenRead);
           Destino := TFileStream.Create(anexoDest, fmCreate);
           Destino.CopyFrom(Origem,Origem.Size);
           Destino.Free;
           Origem.Free;
         Except
           MessageDlg('WhatsApp - Erro: Impossível criar arquivo anexo' + #13 +
                      '[ ' + anexoDest + ' ]' + #13 +
                      'Arquivo NÃO anexado',mtError,[mbOk],0);
           anexoDest := '';
         End;
  end;
  // Arquivo para "monitor whatsapp"
  anexoDest := WABarraFinal(pPathEnvio) + ExtractFileName(pAnexo);   // Identificação para envio (monitor wapp)
  wStrList  := TStringList.Create;
  wStrList.Add('[WhatsApp]');
  wStrList.Add('Contato='  + pNroWhats);
  wStrList.Add('Anexo='    + anexoMon);
  wStrList.Add('Mensagem=' + pAssunto);
  wStrList.Add('Linhas=' + IntToStr(pMensagem.Count));
  for nLin := 0 to pMensagem.Count-1
  do begin
    linAuxil := pMensagem[nLin];
    wStrList.Add('LinMsg' + IntToStr(nLin)+ '=' + linAuxil);
  end;
  wStrList.Add('Cliente='  + IntToStr(pCliente));
  wStrList.Add('DataHora=' + WADtHrStr(pDtHrUtl));
  Try
    wStrList.SaveToFile(whatsFile);
    Result := True;
  Except
    MessageDlg('WhatsApp - Erro: Impossível gravar arquivo envio' + #13 +
               '[ ' + whatsFile + ' ]' + #13 +
               'Envio não pode ser concluído',mtError,[mbOk],0);
  End;
  wStrList.Free;

end;


end.
