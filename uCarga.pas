unit uCarga;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls;

type
  TFCarga = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    LabCor: TLabel;
    edInfo: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdInfo1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCarga: TFCarga;
  rCor: array[0..99] of TColor;
  nCor: Integer;

implementation

{$R *.DFM}


procedure TFCarga.FormShow(Sender: TObject);
begin
  FCarga.Color   := rCor[nCor];
  LabCor.Caption := IntToStr(nCor);
  FCarga.Top     := Screen.Height div 4;
  FCarga.Left    := Screen.Width  div 4;
  if Length(Trim(edInfo.Text)) = 0
     then edInfo.Text := ChangeFileExt(ExtractFileName(Application.ExeName),'');
  Application.ProcessMessages;

end;


procedure TFCarga.FormCreate(Sender: TObject);
var i: Integer;
    p3,p2,p1: Integer;
begin
  p3 := 63;
  p2 := 255;
  p1 := 255;
  for i := 0 to Length(rCor)-1
  do begin
    rCor[i] := (p3 * (256 * 256)) + (p2 * 256) + p1;
    p3 := p3 - 1;
    if p3 < 0 then p3 := 63;
    p2 := p2 - 1;
    if p2 < 0 then p2 := 255;
    p1 := p1 - 1;
    if p1 < 0 then p1 := 255;
  end;
  Randomize;
  nCor := Random(Length(rCor));
  edInfo.Text := '';

end;

procedure TFCarga.EdInfo1Change(Sender: TObject);
begin
  Application.ProcessMessages;
  
end;

end.
