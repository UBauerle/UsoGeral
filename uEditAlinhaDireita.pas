unit uEditAlinhaDireita;
 
interface
 
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TEditAlinh = class(TEdit)
  private
    FAlinhamento  : TAlignment;
    procedure SetAlinhamento(const Value: TAlignment); 
 
  protected
    procedure CreateParams(var Params: TCreateParams); override;
 
  public
  published
    property Alinhamento: TAlignment   read FAlinhamento   write SetAlinhamento;
  end;

procedure Register;
 
implementation
 
procedure Register;
begin
  RegisterComponents('edRigth', [TEditAlinh]);
end;
 
procedure TEditAlinh.CreateParams(var Params: TCreateParams);
const Alinhamentos: array[TAlignment] of Longint = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
 
  Params.Style := Params.Style or Alinhamentos[FAlinhamento];
end;
 
procedure TEditAlinh.SetAlinhamento(const Value: TAlignment);
begin
  FAlinhamento := Value;
  RecreateWnd;
end;
 
end.
 