unit uVersaoPgm;

interface

uses Winapi.Windows, System.SysUtils;
     function GetApplicationVersion: string;

implementation


function GetApplicationVersion: string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
begin
  Result := '';
  VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);   // Obtém o tamanho da informação de versão
  if VerInfoSize > 0 then
  begin
    GetMem(VerInfo, VerInfoSize);                 // Aloca memória para a informação de versão
    Try
      if GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo) then           // Obtém a informação de versão
      begin
        if VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize) then            // Extrai o valor da versão
        begin
          with VerValue^ do
          begin
            Result := IntToStr(dwFileVersionMS shr 16) + '.' +
                      IntToStr(dwFileVersionMS and $FFFF) + '.' +
                      IntToStr(dwFileVersionLS shr 16) + '.' +
                      IntToStr(dwFileVersionLS and $FFFF);
          end;
        end;
      end;
    finally
      FreeMem(VerInfo, VerInfoSize);         // Libera a memória alocada
    end;
  end;

end;


end.
