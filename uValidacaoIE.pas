unit uValidacaoIE;

interface

uses Sysutils,Dialogs;
  Function ValidacaoInscricaoEstadual(pInscricao:String; pSiglaUF:String; pMsg:Boolean = False): Boolean;


var wInscricao,wMensagem: String;
    wMsg: Boolean;
    wIE,wDV: String;

const xSiglas: array[1..27, 1..5] of String =
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
       ('MT', '11', '11', '',  'Mato Grosso'),
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
       ('TO', '11', '11', '',  'Tocantins'));

      xMsgFixo: String = 'Validação Inscrição Estadual';


implementation


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
  Result := IntToStr(dg);
end;


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
  x34    := Copy(pInscricao,3,2);
  if (x34 <> '01') and (x34 <> '02') and (x34 <> '03') and (x34 <> '99')
  then begin
    wMensagem := wMensagem + 'IE TO dig3e4:' + x34 + '  exigido:01 02 03 99' + #13;
    Exit;
  end;
  wIE    := Copy(pInscricao,1,2) + Copy(pInscricao,5,6);
  wDV    := IE_CalcDV11(wIE, 9);
  Result := Copy(pInscricao,1,10) + wDV;
end;


Function ValidacaoInscricaoEstadual(pInscricao:String; pSiglaUF:String; pMsg:Boolean = False): Boolean;
var nIndUF: Integer;
    xIE: String;
begin
  Result    := False;
  wMensagem := '';
  if (Length(Trim(pInscricao)) = 0) or (Pos('ISE',AnsiUpperCase(pInscricao)) > 0)
  then begin
    Result := True;
    Exit;
  end;
  if not ValidaSiglaUFCaracteresTamanho(pInscricao, pSiglaUF, nIndUF)
  then begin
    if pMsg
       then MessageDlg(xMsgFixo + #13#13 + wMensagem, mtError, [mbOK], 0);
    Exit;
  end;
  //
  case nIndUF of
     1:xIE := IE_AC(pInscricao);
     2:xIE := IE_AL(pInscricao);
     3:xIE := IE_AP(pInscricao);
     4:xIE := IE_AM(pInscricao);
     5:xIE := IE_BA(pInscricao);
     6:xIE := IE_CE(pInscricao);
     7:xIE := IE_DF(pInscricao);
     8:xIE := IE_ES(pInscricao);
     9:xIE := IE_GO(pInscricao);
    10:xIE := IE_MA(pInscricao);
    11:xIE := IE_MT(pInscricao);
    12:xIE := IE_MS(pInscricao);
    13:xIE := IE_MG(pInscricao);
    14:xIE := IE_PA(pInscricao);
    15:xIE := IE_PB(pInscricao);
    16:xIE := IE_PR(pInscricao);
    17:xIE := IE_PE(pInscricao);
    18:xIE := IE_PI(pInscricao);
    19:xIE := IE_RJ(pInscricao);
    20:xIE := IE_RN(pInscricao);
    21:xIE := IE_RS(pInscricao);
    22:xIE := IE_RO(pInscricao);
    23:xIE := IE_RR(pInscricao);
    24:xIE := IE_SC(pInscricao);
    25:xIE := IE_SP(pInscricao);
    26:xIE := IE_SE(pInscricao);
    27:xIE := IE_TO(pInscricao);
  end;
  if xIE <> pInscricao
  then begin
    wMensagem := wMensagem +
                 'IE informada: ' + pInscricao + '   calculada: ' + xIE + '    UF: ' + pSiglaUF;
    if pMsg
       then MessageDlg('Inscrição inválida para a UF' + #13 + wMensagem,mtError,[mbOk],0);
  end
  else Result := True;

end;


end.

