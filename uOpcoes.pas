unit uOpcoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;
  Function OpcoesDiv(pmtTitulo:String; pmtPosTit:Alignment; pmtOpcoes:array of String): Integer;

type
  TFuOpcoes = class(TForm)
    rgOpcoes: TRadioGroup;
    LabTitulo: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuOpcoes: TFuOpcoes;

implementation

{$R *.dfm}

Function OpcoesDiv(pmtTitulo:String; pmtPosTit:Alignment; pmtTitOpc:String; pmtOpcoes:array of String): Integer;
var i: Integer;
begin
  FuOpcoes := TFuOpcoes.Create(nil);
  with FuOpcoes
  do begin
    Height   := (Length(pmtOpcoes) * 20) + 40;
    Width    := Screen.Width div 4;
    Position := poDesktop;
    LabTitulo.Caption := pmtTitulo;
    LabTitulo.Align   := pmtPosTit;
    rgOpcoes.Caption  := pmtTitOpc;

  wit


end.
