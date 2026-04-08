unit uPlacasRenavam;

interface

uses SysUtils;
Function CriticaPlacas(pmtPlacas:String): Integer;
Function CriticaRenavam(pmtNum:String ): Boolean;

implementation

//
Function CriticaPlacas(pmtPlacas:String): Integer;
var wPlacas: String;
    wCarac: array[1..8] of String;
    i: Integer;
    errAlf,errNum,errHif: Boolean;
begin
  Result := 0;
  wPlacas := Trim(pmtPlacas);
  if (Length(wPlacas) < 7) or (Length(wPlacas) > 8)
  then begin
    Result := 8;
    Exit;
  end;
  if Length(wPlacas) = 7 then wPlacas := Copy(wPlacas,1,3) + '-' + Copy(wPlacas,4,4);
  for i := 1 to Length(wPlacas) do wCarac[i] := Copy(wPlacas,i,1);
  errAlf := False;
  errNum := False;
  errHif := False;
  for i := 1 to 3 do if (wCarac[i] < 'A') or (wCarac[i] > 'Z') then errAlf := True;
  if wCarac[4] <> '-' then errHif := True;
  for i := 5 to 8 do if (wCarac[i] < '0') or (wCarac[i] > '9') then errNum := True;
  if errAlf then Result := Result + 1;
  if errHif then Result := Result + 2;
  if errNum then Result := Result + 4;

end;
//
Function CriticaRenavam(pmtNum:String ): Boolean;
var soma,i,dgCalc: Integer;
    ndg: array[1..9] of integer;
begin
  Result := True;
  if Length(Trim(pmtNum)) <> 9 then Result := False
  else for i := 1 to 9
       do if (pmtNum[i] < '0') or (pmtNum[i] > '9') then Result := False
                                                    else ndg[i] := StrToInt(pmtNum[i]);
  if not Result then Exit;
  Soma := ndg[1]*9 + ndg[2]*8 + ndg[3]*7 + ndg[4]*6 + ndg[5]*5 + ndg[6]*4 + ndg[7]*3 + ndg[8]*2;
  dgCalc := 11 - (soma mod 11);
  if (dgCalc = 1) or (dgCalc  = 10) then dgCalc := 0;
  if dgCalc <> ndg[9] then Result := False;

end;



end.
