unit uExtenso;

interface
  Uses SysUtils;
  Function ValorExtenso(Vlr:Real;Tam:Integer;Xmf:Boolean):String;


implementation

Function ValorExtenso(Vlr:Real;Tam:Integer;Xmf:Boolean):String;
{ Parametros : Vlr  - a ser convertido (Real) (Max 999.999.999.999.999,99)
              Tam  - Tamanho do texto a ser retornado
              Xmf  - True("DOIS")  False("DUAS")
  Retorno    : Valor por extenso     }
var partes: Array[1..6] of String;
    interm: Array[1..6] of String;
    Itext, Dtext, TxParc, TxFinal, ETx: String;
    VlInt, VlDec, PVirg:  Integer;
    ger, dun, cem, dez, uni, i, cond:  Integer;
    ValorInt:  Real;
    unicos: array[1..20] of String;
    dezena: Array[1..9] of String;
    centen: Array[1..9] of String;
    milsing: Array[1..6] of String;
    milplur: Array[1..6] of String;
    moneysing: array[1..2] of String;
    moneyplur: array[1..2] of String;

begin;
  Result := 'Valor INCORRETO! Superior a 999 trilhões';
  if Vlr > 999999999999999 then Exit;
  Itext := '';

  unicos[1] := 'um';
  unicos[2] := 'dois';
  unicos[3] := 'tres';
  unicos[4] := 'quatro';
  unicos[5] := 'cinco';
  unicos[6] := 'seis';
  unicos[7] := 'sete';
  unicos[8] := 'oito';
  unicos[9] := 'nove';
  unicos[10] :='dez';
  unicos[11] := 'onze';
  unicos[12] := 'doze';
  unicos[13] := 'treze';
  unicos[14] := 'quatorze';
  unicos[15] := 'quinze';
  unicos[16] := 'dezesseis';
  unicos[17] := 'dezessete';
  unicos[18] := 'dezoito';
  unicos[19] := 'dezenove';
  unicos[20] := 'vinte';

  dezena[1] := 'dez';
  dezena[2] := 'vinte';
  dezena[3] := 'trinta';
  dezena[4] := 'quarenta';
  dezena[5] := 'cinquenta';
  dezena[6] := 'sessenta';
  dezena[7] := 'setenta';
  dezena[8] := 'oitenta';
  dezena[9] := 'noventa';

  centen[1] := 'cem';
  centen[2] := 'duzentos';
  centen[3] := 'trezentos';
  centen[4] := 'quatrocentos';
  centen[5] := 'quinhentos';
  centen[6] := 'seiscentos';
  centen[7] := 'setecentos';
  centen[8] := 'oitocentos';
  centen[9] := 'novecentos';

  milsing[1] := ' trilhão';
  milsing[2] := ' bilhão';
  milsing[3] := ' milhão';
  milsing[4] := ' mil';
  milsing[5] := '';
  milsing[6] := '';

  milplur[1] := ' trilhões';
  milplur[2] := ' bilhões';
  milplur[3] := ' milhões';
  milplur[4] := ' mil';
  milplur[5] := '';
  milplur[6] := '';

  moneysing[1] := ' real';
  moneysing[2] := ' centavo';

  moneyplur[1] := ' reais';
  moneyplur[2] := ' centavos';

  if not Xmf then
  begin
    moneysing[1] := '';
    moneysing[2] := ' centésimo';

    moneyplur[1] := '';
    moneyplur[2] := ' centésimos';

    unicos[1] := 'uma';
    unicos[2] := 'duas';

    centen[2] := 'duzentas';
    centen[3] := 'trezentas';
    centen[4] := 'quatrocentas';
    centen[5] := 'quinhentas';
    centen[6] := 'seiscentas';
    centen[7] := 'setecentas';
    centen[8] := 'oitocentas';
    centen[9] := 'novecentas';
  end;
  Itext := Trim(FloatToStr(Vlr));
  VlInt := length(Itext);
  PVirg := pos(',',Itext);
  if PVirg = 0 then PVirg := VlInt;
  VlDec := VlInt - PVirg;
  if VlDec = 0 then Itext := Itext + ',00';
  if VlDec = 1 then Itext := Itext + '0';
  if VlDec > 2 then
  begin
    Result := 'Valor INCORRETO! Mais de duas casas decimais !!!';
    Exit;
  end;
  PVirg := pos(',',Itext);
  Dtext := Copy(Itext, PVirg+1, 2);
  VlDec := StrToInt(Dtext);                   // Valor decimal do numero
  Itext := Copy(Itext, 1, PVirg-1);
  while length(Itext) < 15 do Itext := '0' + Itext;
  ValorInt := StrToFloat(Itext);              // Valor inteiro do numero
  partes[1] := Copy(Itext,1,3);
  partes[2] := Copy(Itext,4,3);
  partes[3] := Copy(Itext,7,3);
  partes[4] := Copy(Itext,10,3);
  partes[5] := Copy(Itext,13,3);
  partes[6] := '0' + Dtext;
  TxFinal := '';
  for i := 1 to 6 do
  begin
    interm[i] := '';
    ger := StrToInt(Partes[i]);           // Vlr. da parte (3 digitos)
    if ger > 0
    then begin
      TxParc := '';
      uni := StrToInt(Copy(Partes[i],3,1));  // Dig. unidade
      dez := StrToInt(Copy(Partes[i],2,1));  // Dig. dezena
      cem := StrToInt(Copy(Partes[i],1,1));  // Dig. centena
      dun := StrToInt(Copy(Partes[i],2,2));  // Dezena + Unidade
      cond := 3;
      if ger < 200 then cond := 2;
      if ger < 100 then cond := 1;
      if ger < 21  then cond := 0;
      if ger = 100 then cond := 3;
      case cond of
        0: TxParc := unicos[ger];        // Vlr. de 1 a 20
        1: begin                         // Vlr. de 21 a 99
             TxParc := dezena[dez];
             if uni > 0 then TxParc := TxParc + ' e ' + unicos[uni];
           end;
        2: begin                         // Vlr de 101 a 199
             TxParc := 'cento e ';
             if dun < 21                    // Dezena/Unidade < 21
             then TxParc := TxParc + unicos[dun]
             else begin                     // dezena/unidade > 20
                    TxParc := TxParc + dezena[dez];
                    if uni > 0 then TxParc := TxParc + ' e ' + unicos[uni];
                  end;
           end;
        3: begin                         // Vlr = 100 ou > 199
             TxParc := centen[cem];
             if dun > 20
             then begin
                    TxParc := TxParc + ' e ' + dezena[dez];
                    if uni > 0 then TxParc := TxParc + ' e ' + unicos[uni];
                  end
             else if dun > 0
                  then if dun < 21 then TxParc := TxParc + ' e ' + unicos[dun];
           end;
      end;
      interm[i] := TxParc;
      if ger = 1 then interm[i] := interm[i] + milsing[i]
                 else interm[i] := interm[i] + milplur[i];
    end;
  end;
  TxFinal := '';
  // Montagem do texto final
  // Tratativa da parte decimal (centavos/centesimos)
  if VlDec > 0 then if VlDec = 1 then TxFinal := moneysing[2]
                                 else TxFinal := moneyplur[2];
  TxFinal := interm[6] + TxFinal;
  // Tratativa da parte inteira
  if ValorInt > 0
  then begin
    if VlDec > 0 then TxFinal := ' e ' + TxFinal;
    if ValorInt = 1 then TxFinal := moneysing[1] + TxFinal
                    else TxFinal := moneyplur[1] + TxFinal;
    // Centena
    if length(interm[5]) > 0 then TxFinal := interm[5] + TxFinal;
    // Milhar
    if length(interm[4]) > 0 then
    begin
      ETx := '';
      if length(interm[5]) > 0 then ETx := ' e ';
      TxFinal := interm[4] + Etx + TxFinal;
    end;
    // Milhao
    if length(interm[3]) > 0 then
    begin
      Etx := '';
      if length(interm[4]) > 0 then ETx := ' e ';
      if length(interm[5]) > 0 then ETx := ' e ';
      TxFinal := interm[3] + Etx + TxFinal;
    end;
    // Bilhao
    if length(interm[2]) > 0 then
    begin
      Etx := '';
      if length(interm[3]) > 0 then ETx := ' e ';
      if length(interm[4]) > 0 then ETx := ' e ';
      if length(interm[5]) > 0 then ETx := ' e ';
      TxFinal := interm[2] + Etx + TxFinal;
    end;
    // Trilhao
    if length(interm[1]) > 0 then
    begin
      Etx := '';
      if length(interm[2]) > 0 then ETx := ' e ';
      if length(interm[3]) > 0 then ETx := ' e ';
      if length(interm[4]) > 0 then ETx := ' e ';
      if length(interm[5]) > 0 then ETx := ' e ';
      TxFinal := interm[1] + Etx + TxFinal;
    end;
    TxFinal := TxFinal + ' ';
  end;
  while Length(TxFinal) < Tam do TxFinal := TxFinal + '*';
  Result := TxFinal;

end;


end.
