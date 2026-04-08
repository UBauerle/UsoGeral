unit uCronometro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Gauges, StdCtrls, Buttons;
  Procedure Cronometro(pStat:Boolean; pTop: Integer = 100;
                                      pLeft: Integer = 800;
                                      pTempo: Integer = 45);

type
  TFuCronometro = class(TForm)
    Barra: TGauge;
    Timer1: TTimer;
    LabErro: TLabel;
    btErro: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btErroClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuCronometro: TFuCronometro;
  fTime: Boolean;
  tMaximo,tConta: Integer;

implementation

{$R *.dfm}

Procedure Cronometro(pStat:Boolean; pTop: Integer = 100;
                                    pLeft: Integer = 800;
                                    pTempo: Integer = 45);
begin
  if pStat
  then begin
    fTime               := True;
    tMaximo             := pTempo;
    tConta              := 0;
    FuCronometro        := TFuCronometro.Create(nil);
    FuCronometro.Top    := pTop;
    FuCronometro.Left   := pLeft;
    FuCronometro.Width  := 240;
    FuCronometro.Height := 45;
    FuCronometro.btErro.Visible  := False;
    FuCronometro.LabErro.Visible := False;
    FuCronometro.Barra.MinValue  := 0;
    FuCronometro.Barra.MaxValue  := pTempo;
    FuCronometro.Show;
  end
  else begin
    FuCronometro.Timer1.Enabled := False;
    FuCronometro.Close;
    FuCronometro.Free;
  end;

end;


procedure TFuCronometro.FormShow(Sender: TObject);
begin
  if not fTime then Exit;
  fTime := False;
  Timer1.Enabled := True;

end;

procedure TFuCronometro.Timer1Timer(Sender: TObject);
begin
  Barra.Progress  := Barra.Progress + 1;
  Application.ProcessMessages;
  tConta          := tConta + 1;
  if tConta > tMaximo
  then begin
    FuCronometro.Timer1.Enabled  := False;
    FuCronometro.Height          := FuCronometro.Height + 55;
    FuCronometro.LabErro.Visible := True;
    FuCronometro.btErro.Visible  := True;
    FuCronometro.btErro.SetFocus;
  end;


end;

procedure TFuCronometro.btErroClick(Sender: TObject);
begin
  FuCronometro.Close;
  FuCronometro.Free;

end;

end.
