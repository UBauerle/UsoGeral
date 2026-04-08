unit uEdicaoTexto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;
  Procedure EditarTexto(pmtArqIni:String);
  Procedure VisualizarTexto(pmtArqIni:String; pmtTamFonte:Integer = 10);

type
  TFuEdicaoTexto = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    btSalvar: TBitBtn;
    btSalvarSair: TBitBtn;
    btCanc: TBitBtn;
    LabLinha: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    LabQtd: TLabel;
    Label1: TLabel;
    LabTamFonte: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btSalvarSairClick(Sender: TObject);
    procedure btCancClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Memo1Exit(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuEdicaoTexto: TFuEdicaoTexto;
  wArqTxt,wOperacao: String;
  lSalvar: Boolean;
  wOriginal: TStringList;
  //linOrig,carOrig: Integer;
  //linMemo,carMemo: Integer;

implementation

{$R *.dfm}

Procedure EditarTexto(pmtArqIni:String);
begin
  FuEdicaoTexto := TFuEdicaoTexto.Create(nil);
  with FuEdicaoTexto
  do begin
    Caption              := 'Editar arquivo [ ' + pmtArqIni + ' ]';
    wArqTxt              := pmtArqIni;
    btSalvar.Visible     := True;
    btSalvarSair.Visible := True;
    btCanc.Caption       := '&Abandonar alterações';
    Memo1.Font.Size      := 10;
    Memo1.ReadOnly       := False;
    wOperacao            := 'E';
    LabTamFonte.Caption  := IntToStr(Memo1.Font.Size);
    ShowModal;
    Release;
  end;
  FuEdicaoTexto.Free;

end;


Procedure VisualizarTexto(pmtArqIni:String; pmtTamFonte:Integer = 10);
begin
  if not FileExists(pmtArqIni)
  then begin
    MessageDlg('Arquivo [ ' + pmtArqIni + ' ] não encontrado', mtError, [mbOk], 0);
    Exit;
  end;
  FuEdicaoTexto := TFuEdicaoTexto.Create(nil);
  with FuEdicaoTexto
  do begin
    Caption              := 'Visualizar arquivo [ ' + pmtArqIni + ' ]';
    wArqTxt              := pmtArqIni;
    btSalvar.Visible     := False;
    btSalvarSair.Visible := False;
    btCanc.Caption       := '&Fechar / Sair';
    Memo1.Font.Size      := pmtTamFonte;
    Memo1.ReadOnly       := True;
    wOperacao            := 'V';
    LabTamFonte.Caption  := IntToStr(Memo1.Font.Size);
    ShowModal;
  end;
  FuEdicaoTexto.Free;
  
end;


procedure TFuEdicaoTexto.FormActivate(Sender: TObject);
var i,nw: integer;
begin
  LabQtd.Caption     := '';
  FuEdicaoTexto.Top    := 40;
  FuEdicaoTexto.Left   := 0;
  FuEdicaoTexto.Width  := Screen.Width;
  FuEdicaoTexto.Height := 200;
  Memo1.Visible      := False;
  wOriginal          := TStringList.Create;
  wOriginal.LoadFromFile(wArqTxt);
  Memo1.Lines.Clear;
  Memo1.Lines.LoadFromFile(wArqTxt);
  Application.ProcessMessages;
  nw    := 50;
  for i := 0 to Memo1.Lines.Count-1
  do begin
    LabLinha.Caption := Memo1.Lines[i];
    if LabLinha.Width > nw then nw := LabLinha.Width;
  end;
  nw := nw + 80;
  if nw > Screen.Width
     then nw := Screen.Width;
  if nw < 780
     then nw := 780;
  FuEdicaoTexto.Width   := nw;
  if wOperacao = 'V'
     then FuEdicaoTexto.Left := (Screen.Width - FuEdicaoTexto.Width) div 2
     else FuEdicaoTexto.Left := 12;
  FuEdicaoTexto.Height := Screen.Height - 120;
  LabQtd.Caption := IntToStr(Memo1.Lines.Count) + ' linhas';
  Memo1.Visible  := True;

end;

procedure TFuEdicaoTexto.btSalvarClick(Sender: TObject);
begin
  Memo1.Lines.SaveToFile(wArqTxt);
  Memo1.Lines.LoadFromFile(wArqTxt);

end;

procedure TFuEdicaoTexto.btSalvarSairClick(Sender: TObject);
begin
  btSalvarClick(nil);
  FuEdicaoTexto.Close;

end;

procedure TFuEdicaoTexto.btCancClick(Sender: TObject);
begin
  if wOperacao = 'E'
  then wOriginal.SaveToFile(wArqtxt);
  lSalvar := False;
  FuEdicaoTexto.Close;

end;

procedure TFuEdicaoTexto.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  if (wOperacao = 'E') and lSalvar
  then if MessageDlg('Salvar alterações ?',mtConfirmation,[mbYes,mbNo],0) = mrYes
          then Memo1.Lines.SaveToFile(wArqTxt);
  wOriginal.Free;

end;

procedure TFuEdicaoTexto.Memo1Exit(Sender: TObject);
var i: Integer;
begin
  lSalvar  := False;
  if Memo1.Lines.Count <> wOriginal.Count
  then lSalvar := True
  else begin
    for i := 0 to Memo1.Lines.Count-1
    do if Memo1.Lines[i] <> wOriginal[i]
       then begin
         lSalvar := True;
         Break;
       end;
  end;

end;

procedure TFuEdicaoTexto.Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  lSalvar := True;
  if (Key = VK_Delete) or
     (Key = VK_Return)
  then LabQtd.Caption := IntToStr(Memo1.Lines.Count) + ' linhas';

end;

procedure TFuEdicaoTexto.SpeedButton1Click(Sender: TObject);
begin
  if Memo1.Font.Size > 5
  then begin
    Memo1.Font.Size := Memo1.Font.Size - 1;
    Memo1.Refresh;
    LabTamFonte.Caption  := IntToStr(Memo1.Font.Size);
  end;

end;

procedure TFuEdicaoTexto.SpeedButton2Click(Sender: TObject);
begin
  if Memo1.Font.Size < 24
  then begin
    Memo1.Font.Size := Memo1.Font.Size + 1;
    Memo1.Refresh;
    LabTamFonte.Caption  := IntToStr(Memo1.Font.Size);
  end;

end;

end.
