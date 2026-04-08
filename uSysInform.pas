unit uSysInform;

interface
  Uses SysUtils, Types, Windows;
  Function SysInformation(var vSysUser,vCompName:String; var vUserStat: Integer): Boolean;

implementation

Function SysInformation(var vSysUser,vCompName:String; var vUserStat: Integer): Boolean;
var nSize: dWord;
    wAchou: Boolean;
    lpBuffer : Array[0..20] of Char;
    cNome: PChar;

begin
  Result      := True;
  nSize       := 120;
  if GetUserName(lpBuffer,nSize)
  then begin
    vSysUser  := lpBuffer;
    vUserStat := 0;
  end
  else begin
    vSysUser  := 'Inválido';
    vUserStat := GetLastError();
    Result    := False;
  end;
  //
  nSize       := 40;
  Try
    GetMem(cNome,nSize);
    if GetComputerName(cNome,nSize) then vCompName := cNome
                                    else vCompName := 'Não informado';
  Except
    vCompName := 'Não identificado';
    Result    := False;
//  Finally
//    FreeMem(cNome,nSize);
  End;
  FreeMem(cNome,nSize);

end;


end.
 