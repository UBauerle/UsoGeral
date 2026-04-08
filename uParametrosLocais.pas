unit uParametrosLocais;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, Db, DBTables, Buttons, ExtCtrls, Mask;
  Procedure ParametrosLocais;

type
  TFuParametrosLocais = class(TForm)
    PanCtl: TPanel;
    BtOk: TBitBtn;
    BtCanc: TBitBtn;
    SParams: TDataSource;
    Params: TTable;
    ParamsPrc: TBooleanField;
    ParamsPed: TBooleanField;
    ParamsNF: TBooleanField;
    ParamsCF: TBooleanField;
    ParamsContr: TBooleanField;
    ParamsCarne: TBooleanField;
    ParamsCBarras: TBooleanField;
    ParamsEstoq: TBooleanField;
    ParamsCRcPg: TBooleanField;
    ParamsDrvRem: TStringField;
    PanSenha: TPanel;
    Label2: TLabel;
    edSenha: TMaskEdit;
    PanInfo: TPanel;
    Label1: TLabel;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    ParamsDescItem: TBooleanField;
    ParamsLctoDesc: TBooleanField;
    ParamsSenhaLctDesc: TStringField;
    DBCheckBox10: TDBCheckBox;
    DBCheckBox11: TDBCheckBox;
    EdSenDesc: TDBEdit;
    Label3: TLabel;
    Padrao: TTable;
    PadraoDescMax: TBCDField;
    PadraoMaxPcParc: TSmallintField;
    PadraoMaxPcCred: TSmallintField;
    PadraoMaxPcCCre: TSmallintField;
    PadraoMaxPcChe: TSmallintField;
    PadraoPedido: TSmallintField;
    PadraoEmiteNF: TBooleanField;
    PadraoEmiteCF: TBooleanField;
    PadraoAtlzEst: TBooleanField;
    PadraoAtlzCRec: TBooleanField;
    PadraoViasCtto: TSmallintField;
    PadraoEmiteCarne: TBooleanField;
    PadraoCodBarras: TSmallintField;
    LabPathLocal: TLabel;
    ParamsTotVlMin: TCurrencyField;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    Image1: TImage;
    procedure BtOkClick(Sender: TObject);
    procedure BtCancClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edSenhaChange(Sender: TObject);
    procedure edSenhaExit(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuParametrosLocais: TFuParametrosLocais;
  nVezes: Integer;

implementation

uses uIniGeral;

{$R *.DFM}

Procedure ParametrosLocais;
begin
  FuParametrosLocais := TFuParametrosLocais.Create(nil);
  with FuParametrosLocais
  do begin
    Padrao.DatabaseName  := FuIniGeral.wInicial.DatabasePath;
    Params.DatabaseName  := FuIniGeral.wInicial.PathLocal;
    edSenha.Text         := '';
    LabPathLocal.Caption := FuIniGeral.wInicial.PathLocal;
    nVezes := 0;
    ShowModal;
  end;
  FuParametrosLocais.Release;

end;


procedure TFuParametrosLocais.BtOkClick(Sender: TObject);
begin
  Params.Post;
  FuParametrosLocais.Close;

end;

procedure TFuParametrosLocais.BtCancClick(Sender: TObject);
begin
  EdSenha.Text := 'CANCELADOXX';
  if Params.Active then Params.Cancel;
  FuParametrosLocais.Close;

end;

procedure TFuParametrosLocais.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Padrao.Active := False;
  Params.Active := False;

end;

procedure TFuParametrosLocais.edSenhaChange(Sender: TObject);
begin
  if Length(edSenha.Text) = 11 then SelectNext((Sender as TwinControl),True,True);

end;

procedure TFuParametrosLocais.edSenhaExit(Sender: TObject);
begin
  if Length(Trim(EdSenha.Text)) = 0 then Exit;
  if (edSenha.Text <> 'SUPER MOUSE') and
     (edSenha.Text <> 'ULRICHMARIO') and
     (edSenha.Text <> 'BARBARIDADE') and
     (edSenha.Text <> 'ECJUVENTUDE') and
     (edSenha.Text <> 'KRYPTONITA')
  then begin
    nVezes := nVezes + 1;
    if nVezes > 4
    then begin
      PanSenha.Enabled := False;
      BtCanc.SetFocus;
    end
    else EdSenha.SetFocus;
    Exit;
  end;

  PanSenha.Enabled := False;
  Params.Active    := True;
  if Params.RecordCount = 0
  then begin
    Params.Append;
    ParamsPrc.AsBoolean         := True;
    ParamsPed.AsBoolean         := True;
    ParamsNF.AsBoolean          := False;
    ParamsCF.AsBoolean          := False;
    ParamsContr.AsBoolean       := False;
    ParamsCarne.AsBoolean       := False;
    ParamsEstoq.AsBoolean       := False;
    ParamsCRcPg.AsBoolean       := False;
    ParamsCBarras.AsBoolean     := False;
    ParamsDescItem.AsBoolean    := True;
    ParamsLctoDesc.AsBoolean    := True;
    ParamsSenhaLctDesc.AsString := '';
    Params.Post;
  end;
  Params.Edit;
  Padrao.Active := True;
  if Padrao.RecordCount = 0
  then begin
    MessageDlg('Parametros gerais está VAZIO',mtError,[mbOk],0);
    BtCanc.SetFocus;
    Exit;
  end;

  if (PadraoMaxPcParc.AsInteger = 0) and
     (PadraoMaxPcCred.AsInteger = 0) and
     (PadraoMaxPcCCre.AsInteger = 0) and
     (PadraoMaxPcChe.AsInteger  = 0)
  then begin
    ParamsPrc.AsBoolean := False;
    DBCheckBox1.Enabled := False;
  end;
  if PadraoPedido.AsInteger = 0
  then begin
    ParamsPed.AsBoolean := False;
    DBCheckBox2.Enabled := False;
  end;
  if not PadraoEmiteNF.AsBoolean
  then begin
    ParamsNF.AsBoolean  := False;
    DBCheckBox3.Enabled := False;
  end;
  if not PadraoEmiteCF.AsBoolean
  then begin
    ParamsCF.AsBoolean  := False;
    DBCheckBox4.Enabled := False;
  end;
  if PadraoViasCtto.AsInteger = 0
  then begin
    ParamsContr.AsBoolean := False;
    DBCheckBox5.Enabled   := False;
  end;
  if not PadraoEmiteCarne.AsBoolean
  then begin
    ParamsCarne.AsBoolean := False;
    DBCheckBox6.Enabled   := False;
  end;
  if not PadraoAtlzEst.AsBoolean
  then begin
    ParamsEstoq.AsBoolean := False;
    DbCheckBox7.Enabled := False;
  end;
  if not PadraoAtlzCRec.AsBoolean
  then begin
    ParamsCRcPg.AsBoolean := False;
    DbCheckBox8.Enabled   := False;
  end;
  if PadraoCodBarras.AsInteger = 0
  then begin
    ParamsCBarras.AsBoolean := False;
    DbCheckBox9.Enabled     := False;
  end;
  if PadraoDescMax.AsFloat = 0
  then begin
    ParamsDescItem.AsBoolean    := False;
    DbCheckBox10.Enabled        := False;
    ParamsLctoDesc.AsBoolean    := False;
    DbCheckBox11.Enabled        := False;
    ParamsSenhaLctDesc.AsString := '******';
    EdSenDesc.Enabled           := False;
  end;
  PanInfo.Visible := True;
  BtOk.Enabled    := True;

end;

procedure TFuParametrosLocais.Image1Click(Sender: TObject);
begin
  if edSenDesc.PasswordChar = '#'
     then edSenDesc.PasswordChar := #0
     else edSenDesc.PasswordChar := '#';

end;

end.
