unit uValidadeNfe;

interface
  uses SysUtils, Dialogs;
  Function ValidaChaveNFe(pChave:String; pMsg:Boolean): Boolean;

implementation

Function ValidaChaveNFe(pChave:String; pMsg:Boolean): Boolean;
var i,Peso,tKey,dErr,Soma,cDV: Integer;
    MsgErr1,MsgErr2: String;
const rTit: String = 'Validação de chave de NFe' + #13;
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


end.
