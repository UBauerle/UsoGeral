unit uMsgInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;
  Function MsgInformacao(pErroConfAviso:Integer;
                         pTitulo:String;
                         pMensagem:String;
                         pCapBotoes:array of String;
                         pFoco:Integer;
                         pTempo:Integer=0;
                         pEsq:Integer=0;
                         pTop:Integer=0): Integer;

type
  TFuMsgInfo = class(TForm)
    PanBotoes: TPanel;
    PanMensagem: TPanel;
    btSim: TBitBtn;
    btNao: TBitBtn;
    btCancel: TBitBtn;
    LabTitulo: TLabel;
    Timer1: TTimer;
    MemMsg: TMemo;
    LabTmp: TLabel;
    LabTexto: TLabel;
    procedure btSimClick(Sender: TObject);
    procedure btNaoClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuMsgInfo: TFuMsgInfo;
  wErroConfAviso,wTempo,wFoco,wResp: Integer;

implementation

{$R *.dfm}

Function MsgInformacao(pErroConfAviso:Integer;
                       pTitulo:String;
                       pMensagem:String;
                       pCapBotoes:array of String;
                       pFoco:Integer;
                       pTempo:Integer=0;
                       pEsq:Integer=0;
                       pTop:Integer=0): Integer;
var nPos,wLarg,i,nTam: Integer;
    txtLines: TStringList;
begin
  // pErroConfAvisoo: 1-Erro; 2-Confirmação; 3-Aviso
  // pFoco: 1-Sim, 2-Não, 3-Cancela
  // Result: 0:Indefinido  1:Sim, 2:Nao, 3:Cancela
  Result := 0;
  wErroConfAviso := pErroConfAviso;
  wFoco := 1;
  wTempo := pTempo;
  wResp := 0;
  FuMsgInfo  := TFuMsgInfo.Create(nil);
  with FuMsgInfo
  do begin
    btSim.Font.Style := [];
    btSim.Visible := True;
    btNao.Visible := False;
    btNao.Font.Style := [];
    btCancel.Visible := False;
    btCancel.Font.Style := [];
    //
    case wErroConfAviso of
      1:begin
         Caption := '< E R R O >';
         PanMensagem.Color := $002B40FF;   // Vermelho
         if pCapBotoes[0] <> ''  then
           btSim.Caption := pCapBotoes[0]
         else
           btSim.Caption := '&Ok';
        end;
      2:begin
         Caption := '< Confirmação >';
         PanMensagem.Color := $0041FCF2;   // Amarelo
         if pCapBotoes[0] <> ''  then
           btSim.Caption := pCapBotoes[0]
         else
           btSim.Caption := '&Sim';
         if pCapBotoes[1] <> ''  then
           btNao.Caption := pCapBotoes[1]
         else
           btNao.Caption := '&Não';
         btNao.Visible := True;
         if pCapBotoes[2] <> ''  then
         begin
           btCancel.Caption := pCapBotoes[2];
           btCancel.Visible := True;
         end;
         wFoco := pFoco;
      end;
      3:begin
         PanMensagem.Color := $0050FF15;   // Verde
         Caption := '< Aviso >';
         if pCapBotoes[0] <> ''  then
           btSim.Caption := pCapBotoes[0]
         else
           btSim.Caption := '&Ok';
      end;
      else begin
         PanMensagem.Color := $00FAFAFA;   // Branco (quase)
         Caption := '< Atenção >';
         btSim.Caption := '&Ok';
      end;
    end;
    PanBotoes.Color := PanMensagem.Color;
    if (pEsq = 0) and (pTop = 0) then
      Position := poScreenCenter
    else begin
      Left := pEsq;
      Top := pTop;
      Position := poDesigned;
    end;
    //
    LabTitulo.Caption := pTitulo;
    LabTexto.Font.Name := MemMsg.Font.Name;
    LabTexto.Font.Size := MemMsg.Font.Size;
    wLarg := 350;
    txtLines := TStringList.Create;
    nPos := Pos(#13,pMensagem);
    while nPos > 0 do
    begin
      LabTexto.Caption := Copy(pMensagem,1,nPos-1);
      if LabTexto.Width > wLarg then
        wLarg := LabTexto.Width;
      txtLines.Add(LabTexto.Caption);
      pMensagem := Copy(pMensagem,nPos+1,Length(pMensagem)-nPos);
      nPos := Pos(#13,pMensagem);
    end;
    LabTexto.Caption := pMensagem;
    if LabTexto.Width > wLarg then
      wLarg := LabTexto.Width;
    txtLines.Add(pMensagem);
    //
    FuMsgInfo.Width := wLarg + 36;
    if FuMsgInfo.Width < 400 then
      FuMsgInfo.Width := 400;
    MemMsg.Lines.Clear;
    //MemMsg.Width := FuMsgInfo.Width - 24;
    for i := 0 to txtLines.Count-1 do
      MemMsg.Lines.Add(txtLines[i]);
    txtLines.Free;
    //
    nTam := 120;
    if btNao.Visible then
      nTam := nTam + 120;
    if btCancel.Visible then
      nTam := nTam + 120;
    nPos := (FuMsgInfo.Width - nTam) div 2;   // Left do botão mais à esquerda
    btSim.Left := nPos;
    nPos := nPos + btSim.Width + 6;
    if btNao.Visible then
    begin
      btNao.Left := nPos;
      nPos := nPos + btNao.Width + 6;
    end;
    if btCancel.Visible then
      btCancel.Left := nPos;
    //
    ShowModal;
  end;
  FuMsgInfo.Free;
  Result := wResp;

end;

procedure TFuMsgInfo.btSimClick(Sender: TObject);
begin
  wResp := 1;
  FuMsgInfo.Close;

end;

procedure TFuMsgInfo.btNaoClick(Sender: TObject);
begin
  wResp := 2;
  FuMsgInfo.Close;

end;

procedure TFuMsgInfo.btCancelClick(Sender: TObject);
begin
  wResp := 3;
  FuMsgInfo.Close;

end;

procedure TFuMsgInfo.FormShow(Sender: TObject);
begin
  case wFoco of
    1:begin
        btSim.SetFocus;
        btSim.Font.Style := [fsBold];
      end;
    2:begin
        btNao.SetFocus;
        btNao.Font.Style := [fsBold];
      end;
    3:begin
        btCancel.SetFocus;
        btCancel.Font.Style := [fsBold];
      end;
  end;
  if wTempo > 0 then
  begin
    LabTmp.Caption := IntToStr(wTempo);
    LabTmp.Visible := True;
    Timer1.Enabled := True;
  end;

end;

procedure TFuMsgInfo.Timer1Timer(Sender: TObject);
begin
  wTempo := wTempo - 1;
  LabTmp.Caption := IntToStr(wTempo);
  if wTempo = 0 then
  begin
    wResp := wFoco;
    FuMsgInfo.Close;
  end;

end;

end.
