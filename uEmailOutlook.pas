unit uEmailOutlook;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComObj;
  procedure EnviarEMail_Outlook(pAssunto,pTexto,pDestin:string; pAnexos:array of string);

type
  TFuEmailOutlook = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuEmailOutlook: TFuEmailOutlook;

implementation

{$R *.dfm}


procedure EnviarEMail_Outlook(pAssunto,pTexto,pDestin:string; pAnexos:array of string);
var
  MM, MS : Variant;
  i : integer;
begin
  Try
    MS := CreateOleObject('MSMAPI.MAPISession');
  Except
    MessageDlg('Erro na criação de MSMAPI.MAPISession',mtError,[mbOk],0);
    Exit;
  End;
  
  try
    MM := CreateOleObject('MSMAPI.MAPIMessages');
    try
      MS.DownLoadMail := False;
      MS.NewSession := False;
      MS.LogonUI := True;
      MS.SignOn;
      MM.SessionID := MS.SessionID;

      MM.Compose;

      MM.RecipIndex := 0;
      MM.RecipAddress := pDestin;
      MM.MsgSubject := pAssunto;
      MM.MsgNoteText := pTexto;

      for i := Low(pAnexos) to High(pAnexos) do
      begin
        MM.AttachmentIndex := i;
        MM.AttachmentPathName := pAnexos[i];
      end;
      MM.Send(True);
      MS.SignOff;
    finally
      VarClear(MS);
    end;
  finally
    VarClear(MM);
  end;
end;



//==============================================================================
//  http://www.swissdelphicenter.ch/en/showcode.php?id=1808
//
//  Shellexecute(Handle,'open','mailto:aaaa@bbb.com?subject&body=body
//  text&CC=aaaa&bcc=dddd&attach=FileName',nil,nil,SW_SHOW)
//  only works with outlook, not for outlook express,
//  but the method below can send attachment to outlook express
//
//  SendMail('Subject', 'Body'#13#10'Second', 'BillGates@Microsoft.com',
//    ['C:\Winnt\explorer.exe', 'C:\winnt\win.ini']);
//==============================================================================


end.
