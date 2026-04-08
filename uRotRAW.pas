unit uRotRAW;

interface

uses
  Dialogs, SysUtils, Printers, Winspool, Windows;
  Function CurrPrinter(Tp:Integer): String;
  Procedure ImprimeTextoRaw(NomePrinter,Arq,Relat: String);

implementation

function CurrPrinter(Tp:Integer): String;
var Device: array[0..255] of char;
    Driver: array[0..255] of char;
    Porta: array[0..255] of char;
    hDMode: THandle;
begin
  Printer.GetPrinter(Device,Driver,Porta,hDMode);
  case Tp of
    1: Result := Device;
    2: Result := Driver;
    3: Result := Porta;
    4: Result := IntToStr(hDMode);
  end;
end;


Procedure ImprimeTextoRaw(NomePrinter,Arq,Relat:String);
var Handle: THandle;
    N: dWord;
    DocInfo1: TDocInfo1;
begin
  if not(OpenPrinter(PChar(Nomeprinter),Handle,nil))
  then begin
    MessageDlg('Erro ' + IntToStr(GetLastError),mtError,[mbOk],0);
    Exit;
  end;
  with DocInfo1 do
  begin
    PDocName := PChar(Relat);
    POutPutFile := nil;
    PDataType := 'RAW';
  end;
  StartDocPrinter(Handle,1,@DocInfo1);
  StartPagePrinter(Handle);
  WritePrinter(Handle,PChar(arq),Length(arq),N);
  EndPagePrinter(Handle);
  EndDocPrinter(Handle);

  ClosePrinter(Handle);

end;

end.

