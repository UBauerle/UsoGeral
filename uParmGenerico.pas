unit uParmGenerico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables;
  Function LeituraParametro(pTableName:String; pArgumento:String; pDefault:String=''): String;

type
  TFuParmGenerico = class(TForm)
    TbParam: TTable;
    TbParamParametro: TStringField;
    TbParamConteudo: TStringField;
    TbParamComentario: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuParmGenerico: TFuParmGenerico;


implementation

{$R *.dfm}

Function VerificaArquivoParametro(pArquivo:String): Boolean;
var cTab: TTable;
begin
  Result := True;
  if FileExists(pArquivo) then Exit;
  //
  cTab := TTable.Create(nil);
  cTab.Active := False;
  //cTab.DatabaseName := ExtractFilePath(pTableName);
  cTab.TableName := pArquivo;
  cTab.TableType := ttDefault;
  cTab.FieldDefs.Clear;
  cTab.FieldDefs.Add('Parametro', ftString, 40);
  cTab.FieldDefs.Add('Conteudo', ftString, 120);
  cTab.FieldDefs.Add('Comentario', ftString, 200);
  cTab.IndexDefs.Clear;
  cTab.IndexDefs.Add('','Parametro',[ixPrimary,ixUnique]);
  Try
    cTab.CreateTable;
  Except
    Result := False;
  End;
  cTab.Free;

end;


Function LeituraParametro(pTableName:String; pArgumento:String; pDefault:String=''): String;
begin
  Result := pDefault;
  if not VerificaArquivoParametro(pTableName)
  then begin
    MessageDlg('Tabela ' + pTableName + ' inexistente' + #13 +
               'Retorno adotado [' + Result + '] (Default)',
               mtInformation,[mbOk],0);
    Exit;
  end;
  //
  FuParmGenerico := TFuParmGenerico.Create(nil);
  with FuParmGenerico
  do begin
    TbParam.TableName := pTableName;
    TbParam.Active := True;
    if TbParam.FindKey([pArgumento])
    then Result := TbParamConteudo.AsString
    else MessageDlg('Parametro [' + pArgumento + '] não encontrado' + #13 +
                    'Retorno adotado [' + Result + '] (Default)',
                    mtInformation,[mbOk],0);
    TbParam.Active := False;
  end;
  FuParmGenerico.Free;

end;

end.
