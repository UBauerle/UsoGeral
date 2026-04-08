unit uExibeErros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;
  Procedure ExibeErros(pmtLista:TStringList; pmtLeft:Integer=20; pmtTop:Integer=40; pmtCreate:Boolean=False);

type
  TFuExibeErros = class(TForm)
    Panel1: TPanel;
    LabMsg: TLabel;
    Panel2: TPanel;
    Memo1: TMemo;
    btFechar: TBitBtn;
    procedure btFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuExibeErros: TFuExibeErros;

implementation

{$R *.dfm}

Procedure ExibeErros(pmtLista:TStringList;
                     pmtLeft:Integer=20;
                     pmtTop:Integer=40;
                     pmtCreate:Boolean=False);
var i: Integer;
    wLarg,wAlt: Integer;
const wDif: Integer = 40;
begin
  if pmtCreate
     then FuExibeErros  := TFuExibeErros.Create(nil);
  with FuExibeErros
  do begin
    Left  := pmtLeft;
    Top   := pmtTop;
    Memo1.Lines.Clear;
    wLarg := 300;
    for i := 0 to pmtLista.Count-1
    do begin
      LabMsg.Caption := pmtLista[i];
      if (LabMsg.Width + wDif) > wLarg
         then wLarg := LabMsg.Width + wDif;
      Memo1.Lines.Add(pmtLista[i]);
    end;
    FuExibeErros.Width  := wLarg;
    wAlt  := Round((Memo1.Lines.Count-1) * 16.5) + 96;
    if wAlt < 200
    then wAlt := 200
    else if wAlt > 320
         then wAlt := 320;
    FuExibeErros.Height := wAlt;
    Show;
  end;

end;

procedure TFuExibeErros.btFecharClick(Sender: TObject);
begin
  FuExibeErros.Close;

end;

end.
