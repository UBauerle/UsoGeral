unit uAjuda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;
  Procedure uExibeAjuda(pLeft,pTop:Integer;pTitulo,pTexto:String);
  Procedure uOcultaAjuda;

type
  TFuAjuda = class(TForm)
    Panel1: TPanel;
    LabTitulo: TLabel;
    LabInform: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuAjuda: TFuAjuda;

implementation

{$R *.dfm}

Procedure uExibeAjuda(pLeft,pTop:Integer;pTitulo,pTexto:String);
var nLarg,nAlt: Integer;
begin
  if not Assigned(FuAjuda) then FuAjuda := TFuAjuda.Create(nil);
  FuAjuda.Left   := pLeft;
  FuAjuda.Top    := pTop;
  FuAjuda.Width  := Screen.Width;
  FuAjuda.Height := 256;
  with FuAjuda
  do begin
    LabTitulo.Caption := pTitulo;
    LabInform.Caption := pTexto;
    nLarg := LabTitulo.Width;
    if LabInform.Width > nLarg
       then nLarg := LabInform.Width;
    nLarg := nLarg + 16;
    nAlt  := LabInform.Top + LabInform.Height + 12;
    FuAjuda.Width  := nLarg;
    FuAjuda.Height := nAlt;
    FuAjuda.Show;
  end;

end;


Procedure uOcultaAjuda;
begin
  if Assigned(FuAjuda) then FuAjuda.Hide;

end;

end.
