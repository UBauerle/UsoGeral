unit uUsuarios;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons, ExtCtrls, Db, DBTables;
  Function ObtemUsuario(pmtDBName:String = 'SISV4'): String;
  Function AcessoSimples(pmtUsuar:String;pmtNFun:Integer;pmtMsg:Boolean;pmtDBName:String = 'SISV4'): Boolean;

type
  TFuUsuarios = class(TForm)
    PanCtl: TPanel;
    btOk: TBitBtn;
    btCancel: TBitBtn;
    PanUser: TPanel;
    Label1: TLabel;
    edUsuar: TMaskEdit;
    Label2: TLabel;
    EdSenha: TMaskEdit;
    Usuarios: TTable;
    UsuariosUser: TStringField;
    UsuariosNome: TStringField;
    UsuariosSenha: TStringField;
    UsuariosTipo: TSmallintField;
    LabMsg: TLabel;
    Acessos: TTable;
    AcessosUser: TStringField;
    AcessosOper: TSmallintField;
    Operacoes: TTable;
    OperacoesNumer: TIntegerField;
    OperacoesIdentif: TStringField;
    OperacoesDescr: TMemoField;
    OperacoesUsoWrk: TBooleanField;
    procedure btOkClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure edUsuarChange(Sender: TObject);
    procedure edUsuarExit(Sender: TObject);
    procedure EdSenhaChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FuUsuarios: TFuUsuarios;
  nErros: Integer;

implementation

{$R *.DFM}

Function ObtemUsuario(pmtDBName:String = 'SISV4'): String;
begin
  FuUsuarios := TFuUsuarios.Create(nil);
  with FuUsuarios
  do begin
    Operacoes.DatabaseName  := pmtDBName;
    Usuarios.DatabaseName   := pmtDBName;
    Acessos.DatabaseName    := pmtDBName;
    Try
      Usuarios.Active       := True;
    Except
      MessageDlg('Arquivo "Usuarios" inexistente ou inválido' + #13
                 +'Usuarios.DatabaseName=' + Usuarios.DatabaseName + #13
                 +'Usuarios.TableName=' + Usuarios.TableName + #13
                 +'Informe ao suporte' + #13#13
                 +'Rotina cancelada'
                 ,mtError,[mbOk],0);
      Result := '';
      Exit;
    End;
    edUsuar.Text    := '';
    edSenha.Text    := '';
    nErros          := 0;
    ShowModal;
    Usuarios.Active := False;
    Result          := edUsuar.Text;
  end;
  FuUsuarios.Free;

end;


Function AcessoSimples(pmtUsuar:String;pmtNFun:Integer;pmtMsg:Boolean;pmtDBName:String = 'SISV4'): Boolean;
{  pmtUsuar: Usuario a ser verificado
   pmtNFun: Operação a ser verificada
   pmtMsg: True:Exibe mensagem de erro,  False: NÃO exibe msg de erro      }
var txtFuncao: String;
begin
  Result         := False;
  if AnsiUpperCase(pmtUsuar) = 'DEBUG'
  then begin
    Result := True;           // Debug é considerado usuário (liberado para todas as operações)
    Exit;
  end;

  FuUsuarios     := TFuUsuarios.Create(nil);
  with FuUsuarios
  do begin
    Usuarios.DatabaseName   := pmtDBName;
    Acessos.DatabaseName    := pmtDBName;
    Operacoes.DatabaseName  := pmtDBName;
    Usuarios.Active         := True;
    if not Usuarios.FindKey([pmtUsuar])
    then begin
      MessageDlg('Usuário inexistente  [ ' + pmtUsuar + ' ]',mtError,[mbOk],0);
      Usuarios.Active := False;
      Exit;
    end;
    if UsuariosTipo.AsInteger = 1
    then begin
      Usuarios.Active := False;
      Result          := True;           // Super usuário (liberado para todas as operações)
      Exit;
    end;
    Acessos.Active    := True;
    if Acessos.FindKey([pmtUsuar,pmtNFun])
    then begin
      Usuarios.Active := False;
      Acessos.Active  := False;
      Result          := True;
      Exit;
    end;
    Operacoes.Active  := True;
    if not Operacoes.FindKey([pmtNFun])
    then begin
      if pmtNFun = 9999
      then begin
        Operacoes.Append;
        OperacoesNumer.AsInteger  := 9999;
        OperacoesIdentif.AsString := 'Manutenção operações e usuários';
        OperacoesDescr.AsString   := 'Manutenção de operações e usuários do sistema';
        Operacoes.Post;
        txtFuncao                 := OperacoesIdentif.AsString;
      end
      else txtFuncao := 'Operação desconhecida'
    end
    else txtFuncao := OperacoesIdentif.AsString;
    Operacoes.Active  := False;
    Acessos.Active    := False;
    Usuarios.Active   := False;
    if pmtMsg
    then MessageDlg('Acesso não permitido' + #13
                    +'Usuário [ ' + pmtUsuar + ' ]' + #13
                    +'Operação [ ' + IntToStr(pmtNFun) + ' - ' + txtFuncao + ' ]'
                    ,mtError,[mbOk],0);
  end;
  FuUsuarios.Free;

end;



procedure TFuUsuarios.btOkClick(Sender: TObject);
var tpErro: Integer;
const xTpErro: array[1..3] of String = ('Usuário inexistente','Senha inválida','Tentativas excedidas');
begin
  LabMsg.Visible  := False;
  Application.ProcessMessages;
  tpErro := 0;
  if not Usuarios.FindKey([edUsuar.Text])
  then tpErro := 1
  else if Trim(edSenha.Text) <> Trim(UsuariosSenha.AsString)
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
  FuUsuarios.Close;

end;

procedure TFuUsuarios.btCancelClick(Sender: TObject);
begin
  edUsuar.Text     := '';
  FuUsuarios.Close;

end;

procedure TFuUsuarios.edUsuarChange(Sender: TObject);
begin
  if Length(Trim(edUsuar.Text)) = 10 then edSenha.SetFocus;

end;

procedure TFuUsuarios.edUsuarExit(Sender: TObject);
begin
  edUsuar.Text := AnsiUpperCase(Copy(edUsuar.Text,1,1)) +
                  AnsiLowerCase(Copy(edUsuar.Text,2,Length(Trim(edUsuar.Text))-1));

end;

procedure TFuUsuarios.EdSenhaChange(Sender: TObject);
begin
  if Length(Trim(edSenha.Text)) = 6 then btOk.SetFocus;

end;

end.
