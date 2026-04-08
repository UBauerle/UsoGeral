unit uIniEMailLocal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, ExtCtrls, StdCtrls, Buttons, ImgList;
Procedure ConfiguraEMailLocal(pArqIniEMail: String = '';
  pMinMax: Boolean = False);

type
  TFuIniEMailLocal = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabArqIni: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edNome: TEdit;
    edEMail: TEdit;
    edPorta: TEdit;
    edHost: TEdit;
    edUsuario: TEdit;
    edSenha: TEdit;
    edRemetente: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    edPathReg: TEdit;
    edMsg0: TEdit;
    edMsg1: TEdit;
    edMsg2: TEdit;
    edMsg3: TEdit;
    edMsg4: TEdit;
    edMsg5: TEdit;
    edMsg6: TEdit;
    edMsg7: TEdit;
    edMsg8: TEdit;
    edMsg9: TEdit;
    rgEnvio: TRadioGroup;
    rgAutent: TRadioGroup;
    edCopia: TEdit;
    gbACBrAut: TGroupBox;
    cbSSL: TCheckBox;
    cbTLs: TCheckBox;
    btGravar: TBitBtn;
    btCancelar: TBitBtn;
    ImgOn: TImage;
    ImgOff: TImage;
    procedure FormActivate(Sender: TObject);
    procedure ImgOnClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure ImgOffClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuIniEMailLocal: TFuIniEMailLocal;
  wIniFileName: String;
  wIniFile: TIniFile;

implementation

uses uGenericas;

{$R *.dfm}

Procedure ConfiguraEMailLocal(pArqIniEMail: String = '';
  pMinMax: Boolean = False);
begin
  wIniFileName := pArqIniEMail;
  if Length(Trim(wIniFileName)) = 0 then
    wIniFileName := ExtractFilePath(Application.ExeName) + 'CfgEMail.ini';
  FuIniEMailLocal := TFuIniEMailLocal.Create(nil);
  with FuIniEMailLocal do
  begin
    if pMinMax then
      BorderIcons := [biSystemMenu, biMinimize, biMaximize]
    else
      BorderIcons := [biSystemMenu];
    ImgOn.Top := edSenha.Top + 2;
    ImgOn.Left := edSenha.Left + edSenha.Width + 4;
    ImgOn.Visible := True;
    ImgOff.Top := ImgOn.Top;
    ImgOff.Left := ImgOn.Left;
    ImgOff.Visible := False;
    ShowModal;
  end;
  FuIniEMailLocal.Free;

end;

procedure TFuIniEMailLocal.FormActivate(Sender: TObject);
begin
  if not FileExists(wIniFileName) then
  begin
    wIniFile := TIniFile.Create(wIniFileName);
    wIniFile.WriteString('Origem', 'Nome', 'Testes Cia Ltda');
    wIniFile.WriteString('Origem', 'Email', 'emailteste@testes.com.br');
    wIniFile.WriteInteger('Origem', 'Porta', 587);
    wIniFile.WriteString('Origem', 'Host', 'smtp.testes.com.br');
    wIniFile.WriteString('Origem', 'Usuario', 'emailteste@testes.com.br');
    wIniFile.WriteString('Origem', 'Senha', 'senhadoemail');
    wIniFile.WriteString('Origem', 'Remetente', 'Usuário local');
    // Nome do remetente
    wIniFile.WriteString('Origem', 'RegPath', 'C:\WorkEnvios');
    // Path dos registros de envios
    wIniFile.WriteString('Origem', 'Msg0', '');
    wIniFile.WriteString('Origem', 'Msg1', '');
    wIniFile.WriteString('Origem', 'Msg2', '');
    wIniFile.WriteString('Origem', 'Msg3', '');
    wIniFile.WriteString('Origem', 'Msg4', '');
    wIniFile.WriteString('Origem', 'Msg5', '');
    wIniFile.WriteString('Origem', 'Msg6', '');
    wIniFile.WriteString('Origem', 'Msg7', '');
    wIniFile.WriteString('Origem', 'Msg8', '');
    wIniFile.WriteString('Origem', 'Msg9', '');
    wIniFile.WriteString('Origem', 'Envio', '0');
    // 0-ACBr  1-Indy  2-Monitor  3-Soft
    wIniFile.WriteString('Origem', 'Autenticacao', '0');
    // 0-satDefault, 1-satNone, 2-satSASL
    wIniFile.WriteString('Origem', 'SSL', 'S');
    wIniFile.WriteString('Origem', 'TLS', 'N');
    wIniFile.WriteString('Copia', 'Email', 'NOCOPY');
    wIniFile.Free;
  end;
  LabArqIni.Caption := wIniFileName;
  wIniFile := TIniFile.Create(wIniFileName);
  edNome.Text := wIniFile.ReadString('Origem', 'Nome', 'Testes Cia Ltda');
  edEMail.Text := wIniFile.ReadString('Origem', 'Email',
    'emailteste@testes.com.br');
  edPorta.Text := IntToStr(wIniFile.ReadInteger('Origem', 'Porta', 587));
  edHost.Text := wIniFile.ReadString('Origem', 'Host', 'smtp.testes.com.br');
  edUsuario.Text := wIniFile.ReadString('Origem', 'Usuario',
    'emailteste@testes.com.br');
  edSenha.Text := wIniFile.ReadString('Origem', 'Senha', 'senhadoemail');
  edRemetente.Text := wIniFile.ReadString('Origem', 'Remetente',
    'Usuário local');
  edPathReg.Text := wIniFile.ReadString('Origem', 'RegPath', 'C:\WorkEnvios');
  edMsg0.Text := wIniFile.ReadString('Origem', 'Msg0', '');
  edMsg1.Text := wIniFile.ReadString('Origem', 'Msg1', '');
  edMsg2.Text := wIniFile.ReadString('Origem', 'Msg2', '');
  edMsg3.Text := wIniFile.ReadString('Origem', 'Msg3', '');
  edMsg4.Text := wIniFile.ReadString('Origem', 'Msg4', '');
  edMsg5.Text := wIniFile.ReadString('Origem', 'Msg5', '');
  edMsg6.Text := wIniFile.ReadString('Origem', 'Msg6', '');
  edMsg7.Text := wIniFile.ReadString('Origem', 'Msg7', '');
  edMsg8.Text := wIniFile.ReadString('Origem', 'Msg8', '');
  edMsg9.Text := wIniFile.ReadString('Origem', 'Msg9', '');
  rgEnvio.ItemIndex := wIniFile.ReadInteger('Origem', 'Envio', 0);
  // 0-ACBr  1-Indy  2-Monitor  3-Soft
  rgAutent.ItemIndex := wIniFile.ReadInteger('Origem', 'Autenticacao', 0);
  // 0-satDefault, 1-satNone, 2-satSASL
  if wIniFile.ReadString('Origem', 'SSL', 'S') = 'S' then
    cbSSL.Checked := True
  else
    cbSSL.Checked := False;
  if wIniFile.ReadString('Origem', 'TLS', 'S') = 'S' then
    cbTLs.Checked := True
  else
    cbTLs.Checked := False;
  edCopia.Text := wIniFile.ReadString('Copia', 'Email', '');

end;

procedure TFuIniEMailLocal.ImgOnClick(Sender: TObject);
begin
  edSenha.PasswordChar := #0;
  ImgOn.Visible := False;
  ImgOff.Visible := True;

end;

procedure TFuIniEMailLocal.btCancelarClick(Sender: TObject);
begin
  FuIniEMailLocal.Close;

end;

procedure TFuIniEMailLocal.btGravarClick(Sender: TObject);
begin
  wIniFile := TIniFile.Create(wIniFileName);
  wIniFile.WriteString('Origem', 'Nome', edNome.Text);
  wIniFile.WriteString('Origem', 'Email', edEMail.Text);
  wIniFile.WriteInteger('Origem', 'Porta', StrToIntDef(edPorta.Text, 587));
  wIniFile.WriteString('Origem', 'Host', edHost.Text);
  wIniFile.WriteString('Origem', 'Usuario', edUsuario.Text);
  wIniFile.WriteString('Origem', 'Senha', edSenha.Text);
  wIniFile.WriteString('Origem', 'Remetente', edRemetente.Text);
  wIniFile.WriteString('Origem', 'RegPath', edPathReg.Text);
  wIniFile.WriteString('Origem', 'Msg0', edMsg0.Text);
  wIniFile.WriteString('Origem', 'Msg1', edMsg1.Text);
  wIniFile.WriteString('Origem', 'Msg2', edMsg2.Text);
  wIniFile.WriteString('Origem', 'Msg3', edMsg3.Text);
  wIniFile.WriteString('Origem', 'Msg4', edMsg4.Text);
  wIniFile.WriteString('Origem', 'Msg5', edMsg5.Text);
  wIniFile.WriteString('Origem', 'Msg6', edMsg6.Text);
  wIniFile.WriteString('Origem', 'Msg7', edMsg7.Text);
  wIniFile.WriteString('Origem', 'Msg8', edMsg8.Text);
  wIniFile.WriteString('Origem', 'Msg9', edMsg9.Text);
  wIniFile.WriteInteger('Origem', 'Envio', rgEnvio.ItemIndex);
  wIniFile.WriteInteger('Origem', 'Autenticacao', rgAutent.ItemIndex);
  wIniFile.WriteString('Origem', 'SSL', Boolean_SN(cbSSL.Checked));
  wIniFile.WriteString('Origem', 'TLS', Boolean_SN(cbTLs.Checked));
  wIniFile.WriteString('Copia', 'Email', edCopia.Text);
  wIniFile.Free;
  FuIniEMailLocal.Close;

end;

procedure TFuIniEMailLocal.ImgOffClick(Sender: TObject);
begin
  edSenha.PasswordChar := '*';
  ImgOn.Visible := True;
  ImgOff.Visible := False;

end;

end.
