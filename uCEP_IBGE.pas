unit uCEP_IBGE;

interface

uses
  Windows, SysUtils, uGenericas, uACBrCEP;
  Function CEP_IBGE(pCEP:String; pACBrServ:Integer; var retUF:Integer; var retMun:Integer): Boolean;


implementation


Function CEP_IBGE(pCEP:String; pACBrServ:Integer; var retUF:Integer; var retMun:Integer): Boolean;
var vCepCEP,vCepLog,vCepBai,vCepMun,vCepUF: String;
    vIbgeUF,vIbgeMun: Integer;
begin
  Result  := False;
  retUF   := 0;
  retMun  := 0;
  vCepCEP := Numerico(pCEP);
  if ACBrCEP_Busca(pACBrServ,vCepCEP,vCepLog,vCepBai,vCepMun,vCepUF,vIbgeUF,vIbgeMun,'InfoCEP')
  then begin
    retUF   := vIbgeUF;
    retMun  := StrToIntDef(Copy(IntToStr(vIbgeMun),3,5),0);
  end;

end;


end.
 