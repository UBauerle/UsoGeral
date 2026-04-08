unit uSenhaGenerica;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, StdCtrls, Buttons,
  ExtCtrls, DateUtils, Mask, Graphics, Dialogs;
  Function SenhaGenerica: String;

type
  TFuSenhaGenerica = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btSair: TBitBtn;
    LabSenha: TLabel;
    edSenha: TMaskEdit;
    LabAviso: TLabel;
    imgSenha: TImage;
    Label1: TLabel;
    LabSenhas: TLabel;
    Timer1: TTimer;
    procedure btSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edSenhaExit(Sender: TObject);
    procedure imgSenhaClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure edSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuSenhaGenerica: TFuSenhaGenerica;
  nConta,nTempo,wAlt: Integer;

implementation


{$R *.dfm}

Function SenhaGenerica: String;
begin
  FuSenhaGenerica  := TFuSenhaGenerica.Create(nil);
  FuSenhaGenerica.ShowModal;
  Result           := FuSenhaGenerica.edSenha.Text;
  FuSenhaGenerica.Release;

end;


procedure TFuSenhaGenerica.btSairClick(Sender: TObject);
begin
  FuSenhaGenerica.Close;

end;

procedure TFuSenhaGenerica.FormShow(Sender: TObject);
begin
  Height       := 195;
  edSenha.Text := '';
  nConta       := 5;
  edSenha.SetFocus;

end;

procedure TFuSenhaGenerica.edSenhaExit(Sender: TObject);
begin
  if Length(Trim(edSenha.Text)) = 0
     then FuSenhaGenerica.Close;
  if (edSenha.Text = 'Kryptonita')
     or (edSenha.Text = 'Supermouse')
     or (edSenha.Text = DateToStr(DateOf(Now)))
     or (edSenha.Text = 'Sup0rt3')
     or (edSenha.Text = 'Valhalla')
     or (edSenha.Text = 'Olimpo')
     or (edSenha.Text = 'Superstar')
  then begin
    LabAviso.Visible := False;
    btSair.SetFocus;
    btSairClick(nil);
    Exit;
  end;
  nConta := nConta - 1;
  if nConta > 0
  then begin
    LabAviso.Caption := IntToStr(nConta) + ' tentativas restantes';
    LabAviso.Visible := True;
    edSenha.Text     := '';
    edSenha.SetFocus;
    Exit;
  end;
  LabAviso.Caption := 'Tentativas esgotadas' + #13 + ' ROTINA CANCELADA';
  LabAviso.Visible := True;
  edSenha.Text     := '';
  btSair.Caption   := '&Finalizar';
  btSair.SetFocus;

end;

procedure TFuSenhaGenerica.imgSenhaClick(Sender: TObject);
begin
  if edSenha.PasswordChar = '#'
     then edSenha.PasswordChar := #0
     else edSenha.PasswordChar := '#';

end;

procedure TFuSenhaGenerica.Label1Click(Sender: TObject);
begin
  MessageDlg('Super herói hoje',mtInformation,[mbOk],0);
  
end;

procedure TFuSenhaGenerica.edSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = vk_Escape)
     or ((Key = vk_Return) and (Length(Trim(edSenha.Text)) = 0))
  then begin
    edSenha.Text := '';
    SelectNext((Sender as TwinControl),True,True);
  end;
  if ((ssAlt in Shift) and (Key = VK_F12))
    or ((ssCtrl in Shift) and (Key = VK_F12))
  then begin
    wAlt                   := FuSenhaGenerica.Height;    // 195
    LabSenhas.Caption      := 'Kryptonita' + #13 +
                              'Supermouse' + #13 +
                              'Valhalla' + #13 +
                              'Olimpo' + #13 +
                              'Sup0rt3' + #13 +
                              'Superstar' + #13 +
                              DateToStr(DateOf(Now)) + #13;
    LabSenhas.Visible      := True;
    FuSenhaGenerica.Height := 365;
    Application.ProcessMessages;
    nTempo                 := 4;
    Timer1.Enabled := True;
  end;


end;

procedure TFuSenhaGenerica.Timer1Timer(Sender: TObject);
begin
  LabSenhas.Caption := LabSenhas.Caption + IntToStr(nTempo-1) + ' ';
  Application.ProcessMessages;
  nTempo            := nTempo - 1;
  if nTempo = 0
  then begin
    LabSenhas.Visible      := False;
    FuSenhaGenerica.Height := wAlt;
  end;

end;

end.
