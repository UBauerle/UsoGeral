unit uMsgSimples;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;
  Function SysMensagem(pAcao: String; pMensagem: String;
                       pCaptions:Array of String;
                       pDefault:Integer): Integer;

type
  TFuMsgSimples = class(TForm)
    PanAcao: TPanel;
    PanWrk: TPanel;
    LabAcao: TLabel;
    Mensagem: TMemo;
    PanRodape: TPanel;
    btUm: TBitBtn;
    btDois: TBitBtn;
    btTres: TBitBtn;
    procedure btUmClick(Sender: TObject);
    procedure btDoisClick(Sender: TObject);
    procedure btTresClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuMsgSimples: TFuMsgSimples;
  wRetorno: Integer;

implementation

{$R *.dfm}

Function SysMensagem(pAcao: String; pMensagem: String;
                     pCaptions:Array of String;
                     pDefault:Integer): Integer;
// Left,pTop: Posicao da tela
// pAcao:     Titulo / Ação
// pMensagem: Mensagem
// pCaptions:Array of String: Caption dos botoes 1,2,3. Se branco, não exibe o botão
// Retorno: 1, 2 ou 3
var nPos: Integer;
begin
  wRetorno := 1;
  FuMsgSimples := TFuMsgSimples.Create(nil);
  with FuMsgSimples do
  begin
    LabAcao.Caption := pAcao;
    Mensagem.Text := '';
    nPos := Pos(chr(13),pMensagem);
    while nPos > 0 do
    begin
      Mensagem.Lines.Add(Copy(pMensagem,1,nPos-1));
      pMensagem := Copy(pMensagem,nPos+1,Length(pMensagem)-nPos);
      nPos := Pos(chr(13),pMensagem);
    end;
    Mensagem.Lines.Add(pMensagem);
    btUm.Caption := '';
    btDois.Caption := '';
    btTres.Caption := '';
    if Length(pCaptions) >= 3 then
      btTres.Caption := pCaptions[2];
    if Length(pCaptions) >= 2 then
      btDois.Caption := pCaptions[1];
    if Length(pCaptions) >= 1 then
      btUm.Caption := pCaptions[0];
    if btUm.Caption = '' then
      btUm.Visible := False;
    if btDois.Caption = '' then
      btDois.Visible := False;
    if btTres.Caption = '' then
      btTres.Visible := False;
    ShowModal;
  end;
  FuMsgSimples.Free;
  Result := wRetorno;

end;


procedure TFuMsgSimples.btDoisClick(Sender: TObject);
begin
  wRetorno := 2;
  FuMsgSimples.Close;

end;

procedure TFuMsgSimples.btTresClick(Sender: TObject);
begin
  wRetorno := 3;
  FuMsgSimples.Close;

end;

procedure TFuMsgSimples.btUmClick(Sender: TObject);
begin
  wRetorno := 1;
  FuMsgSimples.Close;

end;

end.
