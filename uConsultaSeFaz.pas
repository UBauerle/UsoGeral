unit uConsultaSeFaz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IniFiles, ShellApi, Dialogs,
  StdCtrls;
  Function ConsultaSeFaz(pmtCNPJ:String; pmtTPess:String; pmtUF:String;
                         var RetIE:String; var RetSit:Integer; var RetCtr:Integer ): Boolean;

type
  TFuConsultaSeFaz = class(TForm)
    Label1: TLabel;
    LabSeFaz: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuConsultaSeFaz: TFuConsultaSeFaz;

implementation

uses uIniGeral, uGenericas;

{$R *.dfm}

Function ConsultaSeFaz(pmtCNPJ:String; pmtTPess:String; pmtUF:String;
                       var RetIE:String; var RetSit:Integer; var RetCtr:Integer ): Boolean;
var i,nUF,tamIE: Integer;
    gLink,cmdACNFe,wParametro: String;
    cta: Integer;
    wIniFile,arqRetorno: String;
    wIni: TIniFile;
    lEspera: Boolean;
    Lista: TStringList;
    codRet,txtRet,arqXML: String;
    pI,pF: Integer;
    hWnd: THandle;
// Retornos:   True: Consulta bem sucedida    False; Falha na consulta
//     RetIE=  Inscrição estadual
//     RetSit= Situação '0-Não habilitado'  '1-Habilitado'
//     RetCtr= Tipo de contribuinte '0-Contribuinte'  '1-Contribuinte isento'  '2-Não contribuinte'  (Deduzido de RetSit - Retorna somente 0 ou 2)
const xSiglas: array[1..27, 1..4] of String =
      (('RR', '11', '9',  'Roraima'),          // Sigla, CodIBGE, Tam.maximo, Nome
       ('AC', '12', '13', 'Acre'),
       ('AM', '13', '9',  'Amazonas'),
       ('RO', '14', '14', 'Rondônia'),
       ('PA', '15', '9',  'Pará'),
       ('AP', '16', '9',  'Amapá'),
       ('TO', '17', '11', 'Tocantins'),
       ('MA', '21', '9',  'Maranhão'),
       ('PI', '22', '9',  'Piauí'),
       ('CE', '23', '9',  'Ceará'),
       ('RN', '24', '10', 'Rio Grande do Norte'),
       ('PB', '25', '9',  'Paraíba'),
       ('PE', '26', '9',  'Pernambuco'),
       ('AL', '27', '9',  'Alagoas'),
       ('SE', '28', '9',  'Sergipe'),
       ('BA', '29', '9',  'Bahia'),
       ('MG', '31', '13', 'Minas Gerais'),
       ('ES', '32', '9',  'Espirito Santos'),
       ('RJ', '33', '8',  'Rio de Janeiro'),
       ('SP', '35', '13', 'São Paulo'),
       ('PR', '41', '10', 'Paraná'),
       ('SC', '42', '9',  'Santa Catarina'),
       ('RS', '43', '10', 'Rio Grande do Sul'),
       ('MS', '50', '9',  'Mato Grosso do Sul'),
       ('MT', '51', '11', 'Mato Grosso'),
       ('GO', '52', '9',  'Goiás'),
       ('DF', '53', '13', 'Distrito Federal'));
begin
  Result := False;  //
  retIE  := '';     // Retorno  IE inexistente
  retSit := 0;      // Situação Não habilitado
  retCtr := 2;      // Não contribuinte
  nUF    := 99;
  for i := 1 to 27
  do begin
    if xSiglas[i,1] = pmtUF
    then begin
      nUF   := StrToIntDef(xSiglas[i,2],0);
      tamIE := StrToIntDef(xSiglas[i,3],10);
      Break;
    end;
  end;
  if nUF = 99
  then begin
    MessageDlg('Sigla UF [ ' + pmtUF + ' ] não encontrada',mtError,[mbOk],0);
    Exit;
  end;
  //
  cmdACNFe := FuIniGeral.appPath + FuIniGeral.wInicial.OpES_NFeEmiss + '.Exe';
  if (not FileExists(cmdACNFe)) or         // Não existe ACNFe
     (Length(Trim(pmtCNPJ)) = 0) or        // Não tem CNPJ informado
     (nUF = 0) or                          // Não tem UF informada
     (pmtTPess <> 'J') or                  // Não é JURIDICA
     (not FuIniGeral.wInicial.DadosSeFaz)  // Não obtem dados da SeFaz
  then begin
    case nUF of
      43:gLink := FuIniGeral.wInicial.LinkSeFazRS;            // RS
      else gLink := '';
    end;
    if Length(Trim(gLink)) > 0
       then ShellExecute(hWnd, 'open', pChar(gLink), '', '', 1)
       else MessageDlg('Link não informado [ ' + pmtUF + ' ]',mtInformation,[mbOk],0);
    Exit;
  end;
  //
  wIniFile := ChangeFileExt(cmdACNFe,'.INI');
  if not FileExists(wIniFile)
  then begin
    MessageDlg('Arquivo [ ' + wIniFile + ' ] não encontrado',mtError,[mbOk],0);
    Exit;
  end;

  FuConsultaSeFaz := TFuConsultaSeFaz.Create(nil);
  FuConsultaSeFaz.LabSeFaz.Caption := 'SeFaz   ' + pmtUF;
  FuConsultaSeFaz.Show;
  Application.ProcessMessages;

  wIni := TIniFile.Create(wIniFile);
  arqRetorno := wIni.ReadString('Geral', 'ArquivoSaidaPadrao', 'C:\DadosNFe\Saida.Txt');
  arqXML := wIni.ReadString('Geral', 'PathSalvar', 'C:\DadosNFe\Trans\');
  if FileExists(arqRetorno) then DeleteFile(arqRetorno);
  cmdACNFe := FuIniGeral.appPath + FuIniGeral.wInicial.OpES_NFeEmiss + '.Exe';
  wParametro := '/CONSULTARCADASTRO ' + IntToStr(nUF) + ' ' + pmtCNPJ;
  ShellExecute(hWnd,'open',PChar(cmdACNFe),PChar(wParametro),'',SW_SHOWDEFAULT);
  //WinExec(pChar(cmdACNFe),sw_hide);   //sw_Normal);   //showNormal);
  cta     := 0;
  lEspera := True;
  while lEspera
  do begin
    if FileExists(arqRetorno)
    then lEspera := False
    else begin
      cta := cta + 1;
      if cta > 20
      then lEspera := False
      else sleep(500);
    end;
  end;
  if cta > 20
  then begin
    MessageDlg('Não houve resposta à consulta no SeFaz',mtError,[mbOk],0);
    FuConsultaSeFaz.Close;
    FuConsultaSeFaz.Free;
    Exit;
  end;
  //
  // Retorno no ACNFe
  Lista := TStringList.Create;
  Lista.LoadFromFile(arqRetorno);
  codRet := Copy(Lista[0],39,3);
  txtRet := Copy(Lista[0],43,41);
  arqXML := AjustaPathBarraFinal(arqXML,True) + Trim(Copy(Lista[0],84,130));
  Lista.Free;
  if (codRet <> '111') and (codRet <> '112')
  then begin
    MessageDlg('CNPJ/CPF [ ' + pmtCNPJ + ' ] não encontrado na UF' + #13 + 'Codigo=' + codRet,mtError,[mbOk],0);
    FuConsultaSeFaz.Close;
    FuConsultaSeFaz.Free;
    Exit;
  end;
  //
  Lista := TStringList.Create;
  Lista.LoadFromFile(arqXML);
  gLink := Lista[0];
  Lista.Free;
  pI := Pos('<IE>',gLink);
  if pI = 0
  then begin
    MessageDlg('IE não encontrada',mtError,[mbOk],0);
    FuConsultaSeFaz.Close;
    FuConsultaSeFaz.Free;
    Exit;
  end;
  pI := pI + 4;
  pF := Pos('</IE>',gLink);
  RetIE := Copy(gLink,pI,(pF-pI));
  RetIE := stringCompleta(RetIE,'E','0',tamIE);
  //
  pI := Pos('<cSit>',gLink);
  if pI > 0
  then begin
    pI := pI + 6;
    pF := Pos('</cSit',gLink);
    RetSit := StrToIntDef(Copy(gLink,pI,(pF-pI)),0);
  end;
  //
  if RetSit = 1             // Habilitado
     then RetCtr := 0;        // Contribuinte
  //
  FuConsultaSeFaz.Close;
  FuConsultaSeFaz.Free;
  Result := True;

end;

end.
