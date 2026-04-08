unit uAguarde;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;
  Procedure AguardeMsg(pmtAbre: Boolean;
                       pmtLeft,pmtTop: Integer;
                       pmtMsg: String);

type
  TFuAguarde = class(TForm)
    Panel1: TPanel;
    LabInform: TLabel;
    LabAguarde: TLabel;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuAguarde: TFuAguarde;
  wTempo: Integer;

implementation

{$R *.dfm}

Procedure AguardeMsg(pmtAbre: Boolean;
                     pmtLeft,pmtTop: Integer;
                     pmtMsg: String);
var wLeft,wTop: Integer;
begin
  if not pmtAbre
  then begin
    if wTempo > 0
    then begin
      FuAguarde.Timer1.Enabled := False;
      FuAguarde.Close;
      FuAguarde.Release;
    end;
    Exit;
  end;
  FuAguarde := TFuAguarde.Create(nil);
  FuAguarde.LabInform.Caption := pmtMsg;
  FuAguarde.Width := FuAguarde.LabInform.Width + 36;
  if FuAguarde.Width < 210
     then FuAguarde.Width := 210;
  wLeft := pmtLeft;
  wTop  := pmtTop;
  if (wLeft = 0) and (wTop = 0)
  then begin
    wLeft := (Screen.Width - FuAguarde.Width) div 2;
    wTop  := (Screen.Height - FuAguarde.Height) div 2;
  end;
  FuAguarde.Left := wLeft;
  FuAguarde.Top  := wTop;
  FuAguarde.Show;

end;


procedure TFuAguarde.Timer1Timer(Sender: TObject);
begin
  wTempo := wTempo - 1;
  if wTempo <= 0
  then begin
    FuAguarde.Close;
    FuAguarde.Release;
  end
  else begin
    LabAguarde.Caption := 'Aguarde... ' + IntToStr(wTempo);
    Application.ProcessMessages;
  end;

end;

procedure TFuAguarde.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled := False;

end;

procedure TFuAguarde.FormCreate(Sender: TObject);
begin
  Timer1.Enabled := True;
  wTempo := 10;
  LabAguarde.Caption := 'Aguarde... ' + IntToStr(wTempo);

end;

end.
