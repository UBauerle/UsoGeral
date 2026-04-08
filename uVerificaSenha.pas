unit uVerificaSenha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ExtCtrls;
  Function VerificaSenha(pmtSenha:String;pmtTentativas:Integer=5; pmtMotivo:String='Informe a senha'):Boolean;

type
  TFuVerificaSenha = class(TForm)
    LabMotivo: TLabel;
    EdSenha: TMaskEdit;
    btOk: TBitBtn;
    btCancelar: TBitBtn;
    LabInfo: TLabel;
    Image1: TImage;
    LabConta: TLabel;
    procedure btOkClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FuVerificaSenha: TFuVerificaSenha;
  wRetorno: Boolean;
  pwdChar: Char;
  nTentativas,nMaximo: Integer;
  senhaInform: String;

implementation

{$R *.dfm}

Function VerificaSenha(pmtSenha:String;pmtTentativas:Integer=5;pmtMotivo:String='Informe a senha'):Boolean;
begin
  // FuIniGeral.wInicial.OpES_SenhaDesc   .OPES_SenhaCancel   .byJG_Senha   .EMSenha
  if Length(Trim(pmtSenha)) = 0
  then begin
    Result := True;
    Exit;
  end;
  FuVerificaSenha := TFuVerificaSenha.Create(nil);
  with FuVerificaSenha
  do begin
    senhaInform       := Trim(pmtSenha);
    Caption           := 'Verificação de senha';
    LabMotivo.Caption := pmtMotivo;
    LabConta.Caption  := '';
    pwdChar           := edSenha.PasswordChar;
    edSenha.Text      := '';
    wRetorno          := False;
    LabInfo.Visible   := False;
    nTentativas       := 0;
    nMaximo           := pmtTentativas;
    if (pmtTentativas = 0) or (pmtTentativas > 50)
       then nMaximo := 50;
    ShowModal;
    Result            := wRetorno;
  end;

end;

procedure TFuVerificaSenha.btOkClick(Sender: TObject);
begin
  LabInfo.Visible := False;
  if Trim(EdSenha.Text) <> senhaInform
  then begin
    nTentativas      := nTentativas + 1;
    LabConta.Caption := IntToStr(nTentativas) + '/' + IntToStr(nMaximo);
    LabInfo.Visible  := True;
    if nTentativas >= nMaximo
    then begin
      MessageDlg('Excesso de tentativas, rotina cancelada',mtError,[mbOk],0);
      btCancelarClick(nil);
    end
    else EdSenha.SetFocus;
    Exit;
  end;
  wRetorno := True;
  FuVerificaSenha.Close;

end;

procedure TFuVerificaSenha.btCancelarClick(Sender: TObject);
begin
  FuVerificaSenha.Close;

end;

procedure TFuVerificaSenha.FormShow(Sender: TObject);
begin
  EdSenha.SetFocus;

end;

procedure TFuVerificaSenha.Image1Click(Sender: TObject);
begin
  if pwdChar = '#' then pwdChar := #0
                   else pwdChar := '#';
  edSenha.PasswordChar := pwdChar;
     
end;

end.
