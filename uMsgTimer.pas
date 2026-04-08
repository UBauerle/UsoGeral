unit uMsgTimer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;
  Procedure msgTimer(pMsg:String;pTmp:Integer=3);

type
  TFuMsgTimer = class(TForm)
    LabMsg: TLabel;
    LabTmp: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuMsgTimer: TFuMsgTimer;

implementation

{$R *.dfm}

Procedure msgTimer(pMsg:String;pTmp:Integer=3);
begin
  if pTmp < 3 then
    pTmp := 3
  else
    if pTmp > 20 then
      pTmp := 20;
  FuMsgTimer := TFuMsgTimer.Create(nil);
  with FuMsgTimer do
  begin
    Caption := 'Mensagem do sistema';
    LabMsg.Caption := pMsg;
    Width := LabMsg.Width + 40;
    Height := LabMsg.Height + 60;
    if Width < 240 then
      Width := 240;
    if Height < 120 then
      Height := 120;
    Show;
    while pTmp > 0 do
    begin
      LabTmp.Caption := IntToStr(pTmp);
      Application.ProcessMessages;
      sleep(1000);
      pTmp := pTmp - 1;
    end;
    Close;

  end;
  FuMsgTimer.Free;

end;
end.
