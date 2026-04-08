unit uCDSUsuarios;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons, ExtCtrls, IniFiles, DB, DBClient;
  Function  CDSObtemPath(var pmtPath:String): Boolean;
  Function  CDSObtemUsuario(var pmtAcessos:String;
                            var pmtPath:String): String;
  Function  CDSAcesso(pmtNroFuncao:Integer;
                      pmtArrayAcessos:String;
                      pmtPathOper:String;
                      pmtMsgem:Boolean=True): Boolean;
  Procedure CDSUsuarioAcessos(pmtUser:String;
                              var pmtPath:String;
                              var pmtAcessos:String);
  Function  CDSVerificaAcesso(pmtUser:String;pmtOper:array of Integer;pmtAcessos:String;pmtMsg:Boolean): Boolean;

type
  TFuCDSUsuar = class(TForm)
    PanCtl: TPanel;
    btOk: TBitBtn;
    btCancel: TBitBtn;
    PanUser: TPanel;
    Label1: TLabel;
    edUsuar: TMaskEdit;
    Label2: TLabel;
    EdSenha: TMaskEdit;
    LabMsg: TLabel;
    CDUsuarios: TClientDataSet;
    CDOperacoes: TClientDataSet;
    CDUsuariosUser: TStringField;
    CDUsuariosNome: TStringField;
    CDUsuariosSenha: TStringField;
    CDUsuariosTipo: TSmallintField;
    CDUsuariosOper: TStringField;
    CDOperacoesNumer: TIntegerField;
    CDOperacoesIdentif: TStringField;
    CDOperacoesDescr: TMemoField;
    CDOperacoesUsoWrk: TBooleanField;
    procedure btOkClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure edUsuarChange(Sender: TObject);
    procedure edUsuarExit(Sender: TObject);
    procedure EdSenhaChange(Sender: TObject);
    procedure edUsuarKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FuCDSUsuar: TFuCDSUsuar;
  appPath,arqIni,arqUser,arqOper: String;
  nErros: Integer;
  lstUsers: TStringList;
  wIni: TIniFile;

implementation

{$R *.DFM}

Function CDSObtemPath(var pmtPath:String): Boolean;
{  pmtPath:  Path de USUARIOS.XML
    Result:  True->Ok    False->Erro   }
var iMax: Integer;
begin
  Result     := False;
  pmtPath    := 'C:\SISV4\Dados\';;
  appPath    := ExtractFilePath(Application.ExeName);
  arqIni     := appPath + 'Estacao.ini';
  if FileExists(arqIni)
  then begin
    wIni   := TIniFile.Create(arqIni);
    arqIni := wIni.ReadString('Dados','Parametros', appPath + 'Sisv.ini');      // Ini geral do sistema
    wIni.Free;
    if FileExists(arqIni)
    then begin
      wIni    := TIniFile.Create(arqIni);
      pmtPath := wIni.ReadString('Dados','DatabasePath', 'C:\SISV4\Dados\');
      iMax    := length(pmtPath);
      if (pmtPath[iMax] <> '\') and (pmtPath[iMax] <> '/')
         then pmtPath := pmtPath + '\';
      wIni.Free;
    end
    else begin
      MessageDlg(arqIni + #13 + 'Arquivo de configuração não encontrado',
                 mtError,[mbOk],0);
      Exit;
    end;
  end
  else begin
    MessageDlg(arqIni + #13 + 'Arquivo de inicializacao não encontrado',
               mtError,[mbOk],0);
    Exit;
  end;
  arqUser  := pmtPath + 'Usuarios.XML';
  if FileExists(arqUser)
  then Result := True
  else MessageDlg('Arquivo de usuários  [ ' + arqUser + ' ] não encontrado' + #13 +
               'Processo não iniciado',mtError,[mbOk],0);

end;



Function CDSObtemUsuario(var pmtAcessos:String;
                         var pmtPath:String): String;
{  pmtAcessos: Variavel de retorno: Acessos do usuario (1-2048)
   pmtPath:    Variavel de retorno: Path dos dados de usuarios e operacoes
   Result:     Usuario  (brancos = ERRO)   }
var i: Integer;
begin
  Result     := '';
  pmtAcessos := '';
  for i := 1 to 2048 do pmtAcessos := pmtAcessos + '.';
  if not CDSObtemPath(pmtPath)
     then Exit;
  //
  FuCDSUsuar := TFuCDSUsuar.Create(nil);
  with FuCDSUsuar
  do begin
    CDUsuarios.FileName := pmtPath + 'Usuarios.XML';
    CDUsuarios.Active   := True;
    edUsuar.Text        := '';
    edSenha.Text        := '';
    lstUsers            := TStringList.Create;
    CDUsuarios.First;
    while not CDUsuarios.Eof
    do begin
      lstUsers.Add(CDUsuariosUser.AsString + ' [' + CDUsuariosSenha.AsString + ']');
      CDUsuarios.Next;
    end;
    CDUsuarios.First;
    ShowModal;
    if Length(Trim(FuCDSUsuar.edUsuar.Text)) > 0
    then begin
      pmtAcessos       := FuCDSUsuar.CDUsuariosOper.AsString;
      if CDUsuariosTipo.AsInteger = 1
      then begin
        pmtAcessos := '';
        for i := 1 to 2048
        do pmtAcessos := pmtAcessos + 'S';
      end;
      Result           := edUsuar.Text;
    end;
    CDUsuarios.Active  := False;
    lstUsers.Free;
  end;
  FuCDSUsuar.Free;

end;


Function  CDSAcesso(pmtNroFuncao:Integer;
                    pmtArrayAcessos:String;
                    pmtPathOper:String;
                    pmtMsgem:Boolean=True): Boolean;
{  pmtNroFuncao:     Operação a ser verificada
   pmtArrayAcessos:  Acessos do usuário atual (1 a 2048)
   pmtPathOper:      Path dos dados de usuários e operações
   pmtMsgem:         True: Exibe msg    False: NÃO exibe msg
   Result:      True->Tem acesso   False->Não tem acesso    }
var arqOper,wTxtOper: String;
begin
  Result := False;
  if pmtArrayAcessos[pmtNroFuncao] = 'S'
  then begin
    Result := True;
    Exit;
  end;
  if not pmtMsgem then Exit;
  arqOper := pmtPathOper + 'Operacoes.XML';
  if not FileExists(arqOper) then Exit;
  //
  FuCDSusuar := TFuCDSusuar.Create(nil);
  wTxtOper   := '(' + IntToStr(pmtNroFuncao) + ') ';
  with FuCDSUsuar
  do begin
    CDOperacoes.FileName := pmtPathOper + 'Operacoes.XML';
    CDOperacoes.Active   := True;
    if CDOperacoes.FindKey([pmtNroFuncao])
       then wTxtOper := wTxtOper + CDOperacoesIdentif.AsString
       else wTxtOper := wTxtOper + 'não especificada';
    CDOperacoes.Close;
    MessageDlg('Acesso não permitido' + #13#13 + wTxtOper,mtError,[mbOk],0);
  end;
  FuCDSUsuar.Free;

end;


Procedure CDSUsuarioAcessos(pmtUser:String;var pmtPath:String;var pmtAcessos:String);
{  pmtUser:     Usuário
   pmtPath:     Path dos dados de usuários e operações
   pmtAcessos:  Acessos do usuário atual (1 a 2048)
   Result:      True->Encontrado   False->Não encontrado    }
var arqUsuar: String;
    i: Integer;
begin
  //if Length(Trim(pmtAcessos)) = 2048 then Exit;
  pmtAcessos := '';
  for i := 1 to 2048 do pmtAcessos := pmtAcessos + '.';
  if not CDSObtemPath(pmtPath) then Exit;
  arqUsuar   := pmtPath + 'Usuarios.XML';
  if not FileExists(arqUsuar) then Exit;
  //
  FuCDSusuar := TFuCDSusuar.Create(nil);
  with FuCDSUsuar
  do begin
    CDUsuarios.FileName := pmtPath + 'Usuarios.XML';
    CDUsuarios.Active   := True;
    if CDUsuarios.FindKey([pmtUser])
       then pmtAcessos  := FuCDSUsuar.CDUsuariosOper.AsString;
    if CDUsuariosTipo.AsString = '1'
    then begin
      pmtAcessos := '';
      for i := 1 to 2048
      do pmtAcessos := pmtAcessos + 'S';
    end;
    CDUsuarios.Close;
  end;
  FuCDSUsuar.Free;

end;


Function  CDSVerificaAcesso(pmtUser:String;pmtOper:array of Integer;pmtAcessos:String;pmtMsg:Boolean): Boolean;
var i: Integer;
begin
  Result := False;
  if Length(Trim(pmtUser)) = 0
  then begin
    //MessageDlg('Usuário não definido',mtError,[mbOk],0);
    Exit;
  end;
  for i := 0 to Length(pmtOper)-1
  do if pmtAcessos[pmtOper[i]] = 'S'
     then begin
       Result := True;
       Break;
     end;
  if (not Result) and pmtMsg
     then MessageDlg('Acesso não permitido, execução cancelada' + #13#13 +
                     'Usuário: ' + pmtUser + #13 +
                     'Aplicação: ' + ExtractFileName(Application.ExeName) + #13 +
                     '[ ' + Application.ExeName + ' ]',mtError,[mbOk],0);

end;


procedure TFuCDSUsuar.btOkClick(Sender: TObject);
var tpErro: Integer;
const xTpErro: array[1..3] of String = ('Usuário inexistente','Senha inválida','Tentativas excedidas');
begin
  if Length(Trim(edUsuar.Text)) = 0
  then begin
    btCancelClick(nil);
    Exit;
  end;
  LabMsg.Visible  := False;
  Application.ProcessMessages;
  tpErro := 0;
  if not CDUsuarios.FindKey([edUsuar.Text])
  then tpErro := 1
  else if Trim(edSenha.Text) <> Trim(CDUsuariosSenha.AsString)
       then tpErro := 2;
  if tpErro > 0
  then begin
    nErros := nErros + 1;
    if nErros > 3
       then tpErro := 3;
    LabMsg.Caption := xTpErro[tpErro];
    LabMsg.Visible := True;
    if tpErro = 1
    then edUsuar.SetFocus
    else if tpErro = 2
         then edSenha.SetFocus
         else begin
           edUsuar.Text     := '';
           edUsuar.Enabled  := False;
           edSenha.Text     := '';
           edSenha.Enabled  := False;
           btOk.Enabled     := False;
           btCancel.Caption := '&Finalizar';
           btCancel.SetFocus;
         end;
    Exit;
  end;
  FuCDSUsuar.Close;

end;

procedure TFuCDSUsuar.btCancelClick(Sender: TObject);
begin
  edUsuar.Text     := '';
  FuCDSUsuar.Close;

end;

procedure TFuCDSUsuar.edUsuarChange(Sender: TObject);
begin
  if Length(Trim(edUsuar.Text)) = 10 then edSenha.SetFocus;

end;

procedure TFuCDSUsuar.edUsuarExit(Sender: TObject);
begin
  edUsuar.Text := AnsiUpperCase(Copy(edUsuar.Text,1,1)) +
                  AnsiLowerCase(Copy(edUsuar.Text,2,Length(edUsuar.Text)-1));

end;

procedure TFuCDSUsuar.EdSenhaChange(Sender: TObject);
begin
  if Length(Trim(edSenha.Text)) = 6 then btOk.SetFocus;

end;

procedure TFuCDSUsuar.edUsuarKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var wMsg: String;
    i: Integer;
begin
  if ((ssAlt in Shift) and (Key = VK_F12))
    or ((ssCtrl in Shift) and (Key = VK_F12))
  then begin
    wMsg := 'Usuários' + #13;
    for i := 0 to lstUsers.Count-1
      do wMsg := wMsg + #13 + lstUsers[i];
    MessageDlg('Segredo máximo' + #13 + wMsg,mtInformation,[mbOk],0);
  end;

{  TShiftState
   ssShift   The Shift key is held down.
   ssAlt     The Alt key is held down.
   ssCtrl    The Ctrl key is held down.
   ssLeft    The left mouse button is held down.
   ssRight   The right mouse button is held down.
   ssMiddle  The middle mouse button is held down.
   ssDouble  The mouse was double-clicked.    }

end;

end.
