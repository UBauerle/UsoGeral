unit uMensagem;

interface

uses
  Messages, StdCtrls, Buttons, Controls, ExtCtrls,
  Graphics, Classes, Forms, SysUtils;
  Function msgSistema(pErrAvsConfInfo:Integer;pTit,pMens:String;pBotoes,pFoco:Integer;
                      pCapSim:String = '&Sim'; pCapNao:String = '&Não'; pCapCanc:String = '&Cancelar'):Integer;

type
  TFuMensagem = class(TForm)
    PanBotoes: TPanel;
    MemoText: TMemo;
    LabAuxil: TLabel;
    btSim: TBitBtn;
    btNao: TBitBtn;
    btCanc: TBitBtn;
    Image3: TImage;
    Image2: TImage;
    Image1: TImage;
    Image4: TImage;
    procedure FormCreate(Sender: TObject);
    procedure btSimClick(Sender: TObject);
    procedure btNaoClick(Sender: TObject);
    procedure btCancClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    wRetorno: Integer;

  end;

var
  FuMensagem: TFuMensagem;
  wFoco: Integer;

implementation

{$R *.DFM}

// ----------   Mensagens de erros e avisos -------------------------------
Function msgSistema(pErrAvsConfInfo:Integer;pTit,pMens:String;pBotoes,pFoco:Integer;
                    pCapSim:String = '&Sim'; pCapNao:String = '&Não'; pCapCanc:String = '&Cancelar'):Integer;
// pTipo: 1-Erro; 2-Aviso; 3-Confirmação; 4-Informação)
// pTit: Titulo da mensagem
// pMens: Mensagem
// pBotoes: Botões (1-Sim, 2-Não, 4-Cancelar) (1+2+4)
// pFoco: Foco em qual botão ? (1-Sim,2-Não,3-Cancelar)
// pCapSim,pCapNao,pCapCanc: 'Caption' dos botoes Sim, Nao e Cancelar
// Retorno: 1-Sim; 2-Não; 3-Cancela
// Se tipo = 4: Informa, somente botão SIM, com texto Ok
var fPos,iTam: Integer;
const wCap: array[1..4] of String = ('ERRO !','Aviso','Confirmação','Informação');
      nBot: array[1..7] of Integer = (1,1,2,1,2,2,3);
begin
  FuMensagem := TFuMensagem.Create(nil);
  with FuMensagem
  do begin
    if (pErrAvsConfInfo < 1) or (pErrAvsConfInfo > 4) then pErrAvsConfInfo := 4;
    Caption := wCap[pErrAvsConfInfo] + ' - ' + pTit;
    case pErrAvsConfInfo of
      1:Image1.Visible := True;
      2:Image2.Visible := True;
      3:Image3.Visible := True;
      4:begin
          Image4.Visible := True;
          pBotoes := 1;
          pFoco := 1;
          btSim.Caption := '&Ok';
        end;
    end;
    MemoText.Lines.Clear;

    fPos := Pos(Chr(13),pMens);
    iTam := 215;
    while fPos > 0
    do begin
      if fPos = 1
        then LabAuxil.Caption := ''
        else LabAuxil.Caption := Copy(pMens,1,fPos-1);
      if LabAuxil.Width > iTam
        then iTam := LabAuxil.Width;
      MemoText.Lines.Add(LabAuxil.Caption);
      pMens := Copy(pMens,fPos+1,Length(pMens)-fPos);
      fPos := Pos(Chr(13),pMens);
    end;
    LabAuxil.Caption := pMens;
    if LabAuxil.Width > iTam
      then iTam := LabAuxil.Width;
    MemoText.Lines.Add(LabAuxil.Caption);
    MemoText.Width := iTam + 24;
    if MemoText.Lines.Count > 20
    then begin
      MemoText.Height := 322;
      MemoText.ScrollBars := ssVertical;
    end
    else if MemoText.Lines.Count > 4
           then MemoText.Height := 65 + ((MemoText.Lines.Count-4) * 16);

    Width := MemoText.Width + 70;
    if Width < 400
      then Width := 400;
    Height := MemoText.Height + 90;
    if Height < 165
      then Height := 165;

    // 'caption' dos botões
    if Length(Trim(pCapSim)) = 0 then pCapSim := '&Sim';
    if Length(Trim(pCapNao)) = 0 then pCapNao := '&Não';
    if Length(Trim(pCapCanc)) = 0 then pCapCanc:= '&Cancelar';
    btSim.Caption   := pCapSim;
    btNao.Caption   := pCapNao;
    btCanc.Caption  := pCapCanc;

    // Define quantos botões são visíveis (nVis)
    if pBotoes < 1
    then pBotoes := 1
    else if pBotoes > 7
         then pBotoes := 7;

    if nBot[pBotoes] = 1
    then fPos := PanBotoes.Width div 2                              // (FuMensagem.ClientWidth - 87) div 2
    else if nBot[pBotoes] = 2
         then fPos := (PanBotoes.Width - 235) div 2                 // (FuMensagem.ClientWidth - 187) div 2
         else fPos := (PanBotoes.Width - 345) div 2;                // (FuMensagem.ClientWidth - 287) div 2;

    // Define quais botoes são visiveis e sua posição (fPos = 1a. posição)
    btSim.Visible    := False;
    btNao.Visible    := False;
    btCanc.Visible   := False;
    if (pBotoes=1) or (pBotoes=3) or (pBotoes=5) or (pBotoes=7)
    then begin
      btSim.Left     := fPos;
      fPos           := fPos + (btSim.Width + 5);
      btSim.Visible  := True;
    end;
    if (pBotoes=2) or (pBotoes=3) or (pBotoes=6) or (pBotoes=7)
    then begin
      btNao.Left     := fPos;
      fPos           := fPos + (btNao.Width + 5);
      btNao.Visible  := True;
    end;
    if (pBotoes>3)
    then begin
      btCanc.Left    := fPos;
      btCanc.Visible := True;
    end;
    wFoco := pFoco;

  end;
  FuMensagem.ShowModal;
  Result := FuMensagem.wRetorno;
  FuMensagem.Free;

end;


procedure TFuMensagem.FormCreate(Sender: TObject);
begin
  Image1.Top := 4;  Image1.Left := 4;  Image1.Visible := False;
  Image2.Top := 4;  Image2.Left := 4;  Image2.Visible := False;
  Image3.Top := 4;  Image3.Left := 4;  Image3.Visible := False;
  Image4.Top := 4;  Image4.Left := 4;  Image4.Visible := False;
  LabAuxil.Caption := '';
  MemoText.Width := 215;
  MemoText.Height := 65;
  MemoText.ScrollBars := ssNone;
  Height := 165;
  Width := 360;
  wRetorno := 3;

end;

procedure TFuMensagem.btSimClick(Sender: TObject);
begin
  wRetorno := 1;
  FuMensagem.Close;

end;

procedure TFuMensagem.btNaoClick(Sender: TObject);
begin
  wRetorno := 2;
  FuMensagem.Close;

end;

procedure TFuMensagem.btCancClick(Sender: TObject);
begin
  wRetorno := 3;
  FuMensagem.Close;

end;

procedure TFuMensagem.FormActivate(Sender: TObject);
begin
  if wFoco = 1
  then btSim.SetFocus
  else if wFoco = 2
       then btNao.SetFocus
       else btCanc.SetFocus;

end;

end.
