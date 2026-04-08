unit uDataHora;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles;
  Function VerificaDataHora(pPath,pExec,pAcao:String): Boolean;
  Procedure GravaDataHora(pPath:String);

type
  TFDataHora = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FDataHora: TFDataHora;
  wIni: TIniFile;

implementation

uses uGenericas;

{$R *.dfm}

Function VerificaDataHora(pPath,pExec,pAcao:String): Boolean;
// pPath: Path do executável
// pExec: Nome do executável
// pAcao: 'A'visar, 'C'ancelar execução
var wArquivo,wMens: String;
    wDtHr,sysDH: TDateTime;
begin
  Result    := True;
  wArquivo  := AjustaPathBarraFinal(pPath,True) + 'SystemDtHr.ini';
  if not FileExists(wArquivo)
     then Exit;
  wIni     := TIniFile.Create(wArquivo);
  wDtHr    := wIni.ReadDateTime('System','DataHora',Now-1);
  wIni.Free;
  sysDH    := Now;
  if sysDH < wDtHr
  then begin
    wMens := 'Data/Hora do sistema ANTERIOR à última utilização' + #13
           + 'Última utilização [' + DateTimeToStr(wDtHr) + ']' + #13
           + 'Data/Hora sistema [' + DateTimeToStr(sysDH) + ']' + #13
           + 'Informe ao administrador do sistema' + #13#13;
    if AnsiUpperCase(pAcao) = 'A'
    then begin
      wMens := wMens + 'Após o uso corrija a data/hora do sistema';
      MessageBox(0,PChar(wMens),'Aviso',MB_ICONWARNING);
    end
    else begin
      wMens := wMens + 'Rotina atual [' + pExec + '] CANCELADA' + #13
             + 'Corrija a data/hora do sistema ou delete o arquivo [' + wArquivo + '] e tente novamente';
      MessageBox(0,PChar(wMens),'ERRO',MB_ICONSTOP);
      Result := False;
    end;
  end;

end;


Procedure GravaDataHora(pPath:String);
// pPath: Path do executável
var wArquivo,wMens: String;
begin
  wArquivo  := AjustaPathBarraFinal(pPath,True) + 'SystemDtHr.ini';
  wIni      := TIniFile.Create(wArquivo);
  wIni.WriteDateTime('System','DataHora',Now);
  wIni.Free;

end;

end.
