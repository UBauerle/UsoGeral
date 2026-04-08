unit uProcess2;

interface
  Uses Winapi.Windows, SysUtils, TlHelp32;
  Function ProcessExists(ProcessName: string): Boolean;
  {
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
   TlHelp32;
  }
implementation

function ProcessExists(ProcessName: string): Boolean;
var
  Snapshot: THandle;
  ProcessEntry: TProcessEntry32;
begin
  Result := False;
  Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if Snapshot = 0 then Exit;

  ProcessEntry.dwSize := SizeOf(TProcessEntry32);
  if Process32First(Snapshot, ProcessEntry) then
  begin
    repeat
      if (UpperCase(ExtractFileName(ProcessEntry.szExeFile)) = UpperCase(ProcessName)) then
      begin
        Result := True;
        Break;
      end;
    until not Process32Next(Snapshot, ProcessEntry);
  end;
  CloseHandle(Snapshot);

end;


end.
