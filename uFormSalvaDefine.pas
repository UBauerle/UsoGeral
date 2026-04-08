unit uFormSalvaDefine;

interface
  uses Forms, StdCtrls, SysUtils, Controls, Dialogs;
  Procedure Form_Salva(pmtForm:TForm);
  Procedure Form_Define(pmtForm:TForm);

implementation

Procedure Form_Salva(pmtForm:TForm);
var wArqForm: String;
    wMemo: TMemo;
    wTam: Integer;
begin
  wArqForm := ExtractFilePath(Application.ExeName) + pmtForm.Name + '.fml';
  wMemo := TMemo.Create(nil);
  wMemo.Lines.Clear;
  wMemo.Lines.Add('Align, Top, Left, Width, Height');
  if pmtForm.Align = alClient then wMemo.Lines.Add('ALL')
  else begin
    wMemo.Lines.Add('NONE');
    wMemo.Lines.Add(IntToStr(pmtForm.Top));
    wMemo.Lines.Add(IntToStr(pmtForm.Left));
    wMemo.Lines.Add(IntToStr(pmtForm.Width));
    wMemo.Lines.Add(IntToStr(pmtForm.Height));
  end;
  Try
    wMemo.Lines.SaveToFile(wArqForm);
  Except
    MessageDlg('Não foi possível salvar a configuração da tela' + #13
               + 'Tela/Formulário: ' + pmtForm.Name + #13
               + 'Destino: ' + wArqForm
               ,mtInformation,[mbOk],0);
  End;
  wMemo.Free;

end;


Procedure Form_Define(pmtForm:TForm);
// Se não existir definição anterior, mantém os dados originais do formulário
var wArqForm: String;
    wMemo: TMemo;
begin
  wArqForm := ExtractFilePath(Application.ExeName) + pmtForm.Name + '.fml';
  wMemo := TMemo.Create(nil);
  wMemo.Lines.LoadFromFile(wArqForm);
  if wMemo.Lines[1] = 'ALL'
  then pmtForm.Align := alClient
  else begin
    pmtForm.Align := alNone;
    pmtForm.Top := StrToIntDef(wMemo.Lines[2],60);
    pmtForm.Left := StrToIntDef(wMemo.Lines[3],40);
    pmtForm.Width := StrToIntDef(wMemo.Lines[4],Screen.Width-120);
    pmtForm.Height := StrToIntDef(wMemo.Lines[5],Screen.Height-80);
  end;
  wMemo.Free;

end;


end.
