unit uMsgSystemAPP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;
  Function msgSystemYN(pTitulo:String;
                       pMens:String;
                       pYesNo:Boolean = False): Boolean;
type
  TFuMsgSystemAPP = class(TForm)
    panBotoes: TPanel;
    Panel2: TPanel;
    LabAuxil: TLabel;
    btYes: TBitBtn;
    btNo: TBitBtn;
    LabTitulo: TLabel;
    MemoTxt: TMemo;
    procedure btYesClick(Sender: TObject);
    procedure btNoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuMsgSystemAPP: TFuMsgSystemAPP;
  wResposta: Boolean;

implementation

{$R *.dfm}

Function msgSystemYN(pTitulo:String;
                     pMens:String;
                     pYesNo:Boolean = False): Boolean;
var fPos,wTam,nAuxil: Integer;
begin
  FuMsgSystemAPP  := TFuMsgSystemAPP.Create(nil);
  with FuMsgSystemAPP
  do begin
    LabTitulo.Caption := pTitulo;
    wTam              := LabTitulo.Width;
    MemoTxt.Lines.Clear;
    MemoTxt.Lines.Add('');
    fPos := Pos(Chr(13),pMens);
    while fPos > 0
    do begin
      if fPos = 1
        then LabAuxil.Caption := ''
        else LabAuxil.Caption := Copy(pMens,1,fPos-1);
      if LabAuxil.Width > wTam
        then wTam := LabAuxil.Width;
      MemoTxt.Lines.Add(LabAuxil.Caption);
      pMens := Copy(pMens,fPos+1,Length(pMens)-fPos);
      fPos := Pos(Chr(13),pMens);
    end;
    MemoTxt.Lines.Add(pMens);
    nAuxil := (MemoTxt.Lines.Count * 27);
    if nAuxil < 102 then nAuxil := 102;
    FuMsgSystemApp.Height := LabTitulo.Height + nAuxil + panBotoes.Height + 36;
    FuMsgSystemAPP.width  := wTam + 16;
    if FuMsgSystemAPP.Width < 386 then FuMsgSystemAPP.Width := 386;
    if FuMsgSystemAPP.Height < 222 then FuMsgSystemAPP.Height := 222;
    wResposta  := pYesNo;
    ShowModal;
    Result := wResposta;
    Free;
  end;

end;

procedure TFuMsgSystemAPP.btYesClick(Sender: TObject);
begin
  wResposta := True;
  FuMsgSystemAPP.Close;

end;

procedure TFuMsgSystemAPP.btNoClick(Sender: TObject);
begin
  wResposta := False;
  FuMsgSystemAPP.Close;

end;

procedure TFuMsgSystemAPP.FormShow(Sender: TObject);
begin
  if wResposta then btYes.SetFocus
               else btNo.SetFocus;

end;

end.
