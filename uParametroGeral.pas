unit uParametroGeral;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, ExtCtrls, Mask, Buttons, Db, DBTables, ComCtrls;
  Procedure ConfiguraParametroGeral;

type
  TFuParametroGeral = class(TForm)
    PanBottom: TPanel;
    btOk: TBitBtn;
    btCanc: TBitBtn;
    PageControl1: TPageControl;
    tbEstoques: TTabSheet;
    GbCodif: TGroupBox;
    Lable64: TLabel;
    Label65: TLabel;
    GbDiv1: TGroupBox;
    Label66: TLabel;
    DbMasc1: TDBRadioGroup;
    GbDiv2: TGroupBox;
    Label70: TLabel;
    DbMasc2: TDBRadioGroup;
    GbDiv3: TGroupBox;
    Label72: TLabel;
    DbMasc3: TDBRadioGroup;
    GbDiv4: TGroupBox;
    Label74: TLabel;
    DbMasc4: TDBRadioGroup;
    GroupBox2: TGroupBox;
    Memo2: TMemo;
    DBCheckBox12: TDBCheckBox;
    dbTamCod: TDBComboBox;
    dbDivCod: TDBComboBox;
    dbDiv1: TDBComboBox;
    dbDiv2: TDBComboBox;
    dbDiv3: TDBComboBox;
    dbDiv4: TDBComboBox;
    tbComercial: TTabSheet;
    GroupBox7: TGroupBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DbCodBarras: TDBRadioGroup;
    GroupBox3: TGroupBox;
    DBBanco: TDBRadioGroup;
    Label36: TLabel;
    EdLctosMax: TDBEdit;
    DbFinaliz: TDBRadioGroup;
    GroupBox1: TGroupBox;
    Label15: TLabel;
    DBPedido: TDBRadioGroup;
    EdIdPed: TDBEdit;
    DbRGParcel: TDBRadioGroup;
    Label2: TLabel;
    edMarg: TDBEdit;
    gbListaPadrao: TGroupBox;
    EdLPrec: TDBLookupComboBox;
    gbSenhaVenda: TGroupBox;
    edSenha: TDBEdit;
    LabSenha: TLabel;
    PrmGer: TTable;
    PrmGerICM_UF: TBCDField;
    PrmGerICM_FUF: TBCDField;
    PrmGerFormaReajuste: TSmallintField;
    PrmGerPcUltReajuste: TBCDField;
    PrmGerFReajEx: TStringField;
    PrmGerCFOP_EE: TSmallintField;
    m: TSmallintField;
    PrmGerSTrib_UF: TSmallintField;
    PrmGerSTrib_FUF: TSmallintField;
    PrmGerTCodTam: TSmallintField;
    PrmGerTCodDiv: TSmallintField;
    PrmGerTCodD1: TSmallintField;
    PrmGerTCodIt1: TStringField;
    PrmGerTCodD2: TSmallintField;
    PrmGerTCodIt2: TStringField;
    PrmGerTCodD3: TSmallintField;
    PrmGerTCodIt3: TStringField;
    PrmGerTCodD4: TSmallintField;
    PrmGerTCodIt4: TStringField;
    PrmGerPrecoSugestao: TBooleanField;
    PrmGerMargSugestao: TBCDField;
    PrmGerQbLote: TSmallintField;
    PrmGerSimplesRS: TBooleanField;
    PrmGerTDocParc: TSmallintField;
    PrmGerTDocCred: TSmallintField;
    PrmGerCobrParc: TStringField;
    PrmGerBancParc: TStringField;
    PrmGerCobrCred: TStringField;
    PrmGerBancCred: TStringField;
    PrmGerPedido: TSmallintField;
    PrmGerIdPed: TStringField;
    PrmGerJurosMM: TBCDField;
    PrmGerTDocCheque: TSmallintField;
    PrmGerMaxLctos: TSmallintField;
    PrmGerLPrec: TSmallintField;
    PrmGerQtdDec: TStringField;
    PrmGerVlrDec: TStringField;
    PrmGerCodBarras: TSmallintField;
    PrmGerPedFM: TBooleanField;
    PrmGerPedFMExib: TBooleanField;
    PrmGerTratFiscal: TStringField;
    PrmGerMdParcel: TSmallintField;
    PrmGerBDVend: TStringField;
    PrmGerSenhaVendas: TStringField;
    SPrmGer: TDataSource;
    Precos: TTable;
    PrecosSeq: TSmallintField;
    PrecosIdent: TStringField;
    PrecosComent: TStringField;
    PrecosNDec: TSmallintField;
    PrecosAtiva: TBooleanField;
    SPrecos: TDataSource;
    gbDescMaximo: TGroupBox;
    edDescMax: TDBEdit;
    PrmGerDescMax: TBCDField;
    gbAliqISS: TGroupBox;
    edAliqISS: TDBEdit;
    PrmGerAliqISS: TBCDField;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure btOkClick(Sender: TObject);
    procedure btCancClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdDivCodExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbDivCodExit(Sender: TObject);
    procedure edSenhaDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuParametroGeral: TFuParametroGeral;
  lDisp,fTime: Boolean;

implementation

uses uGenericas, uMensagem, uIniGeral;

{$R *.DFM}

Procedure ConfiguraParametroGeral;
begin
  FuParametroGeral := TFuParametroGeral.Create(nil);
  with FuParametroGeral
  do begin
    PrmGer.DatabaseName := FuIniGeral.wInicial.DatabaseName;
    Precos.DatabaseName := FuIniGeral.wInicial.DatabaseName;
    PrmGer.Active       := True;
    Precos.Active       := True;
    FuParametroGeral.ShowModal;
    PrmGer.Active       := False;
    Precos.Active       := False;
  end;
  FuParametroGeral.Free;

end;


procedure TFuParametroGeral.btOkClick(Sender: TObject);
var wMsg: String;
    tSoma: Integer;
begin
  wMsg := '';
  if (PrmGerTCodTam.AsInteger < 3)
     or (PrmGerTCodTam.AsInteger > 13)
  then wMsg := 'Tamanho do código inválido (3 a 13)' + #13;
  if (PrmGerTCodDiv.AsInteger < 1)
     or (PrmGerTCodDiv.AsInteger > 4)
  then wMsg := wMsg + 'Quantidade de divisões no código inválida (1 a 4)' + #13;
  tSoma := PrmGerTCodD1.AsInteger + PrmGerTCodD2.AsInteger
           + PrmGerTCodD3.AsInteger + PrmGerTCodD4.AsInteger;
  if tSoma <> PrmGerTCodTam.AsInteger
  then begin
    wMsg := wMsg + 'Somatório dos tamanhos das divisões difere do tamanho total' + #13
            + 'Soma   D1:' + PrmGerTCodD1.AsString;
    if PrmGerTCodDiv.AsInteger > 1
    then begin
      if PrmGerTCodD2.AsInteger > 0
         then wMsg := wMsg + ' + ' + 'D2:' + PrmGerTCodD2.AsString;
      if PrmGerTCodD3.AsInteger > 0
         then wMsg := wMsg + ' + ' + 'D3:' + PrmGerTCodD3.AsString;
      if PrmGerTCodD4.AsInteger > 0
         then wMsg := wMsg + ' + ' + 'D4:' + PrmGerTCodD4.AsString;
      wMsg := wMsg + ' = ' + IntToStr(tSoma) + '      Tamanho total = ' + PrmGerTCodTam.AsString;
    end;
    wMsg := wMsg + #13;
  end;
  if Pos(PrmGerTCodIt1.AsString,'AN') = 0
     then wMsg := wMsg + 'Mascara divisão #1 não informada' + #13;
  if (PrmGerTCodDiv.AsInteger > 1)
     and (Pos(PrmGerTCodIt2.AsString,'AN') = 0)
     then wMsg := wMsg + 'Mascara divisão #2 não informada' + #13;
  if (PrmGerTCodDiv.AsInteger > 2)
     and (Pos(PrmGerTCodIt3.AsString,'AN') = 0)
     then wMsg := wMsg + 'Mascara divisão #3 não informada' + #13;
  if (PrmGerTCodDiv.AsInteger > 3)
     and (Pos(PrmGerTCodIt3.AsString,'AN') = 0)
     then wMsg := wMsg + 'Mascara divisão #4 não informada' + #13;

  if (PrmGerMargSugestao.AsFloat <= 1)
     or (PrmGerMargSugestao.AsFloat >= 2000)
  then wMsg := wMsg + 'Margem para preço de venda inválida (1 a 2000)' + #13;

  if Length(Trim(wMsg)) > 0
  then begin
    msgSistema(4,'Codificação dos estoques'
                ,wMsg + #13 + 'Reinforme...'
                ,1,1);
    PageControl1.ActivePageIndex := 0;
    dbTamCod.SetFocus;
    Exit;
  end;
  PrmGer.Post;
  FuParametroGeral.Close;

end;

procedure TFuParametroGeral.btCancClick(Sender: TObject);
begin
  if lDisp
     then PrmGer.Cancel;
  FuParametroGeral.Close;

end;

procedure TFuParametroGeral.FormCreate(Sender: TObject);
begin
  fTime := True;
  LabSenha.Caption := 'Senha para vendas com' + #13
                      + 'preços abaixo do mínimo' + #13
                      + 'permitido';

end;

procedure TFuParametroGeral.EdDivCodExit(Sender: TObject);
begin
  GbDiv4.Enabled := False;
  if PrmGerTCodDiv.AsInteger > 3 then GbDiv4.Enabled := True;
  if not GbDiv4.Enabled
  then begin
    PrmGerTCodD4.AsInteger := 0;
    PrmGerTCodIt4.AsInteger := -1;
  end;
  GbDiv3.Enabled := False;
  if PrmGerTCodDiv.AsInteger > 2 then GbDiv3.Enabled := True;
  if not GbDiv3.Enabled
  then begin
    PrmGerTCodD3.AsInteger := 0;
    PrmGerTCodIt3.AsInteger := -1;
  end;
  GbDiv2.Enabled := False;
  if PrmGerTCodDiv.AsInteger > 1 then GbDiv2.Enabled := True;
  if not GbDiv2.Enabled
  then begin
    PrmGerTCodD2.AsInteger := 0;
    PrmGerTCodIt2.AsInteger := -1;
  end;

end;

procedure TFuParametroGeral.FormActivate(Sender: TObject);
begin
  if not fTime
     then Exit;
  fTime := False;
  lDisp := True;
  if PrmGer.RecordCount = 0
     then PrmGer.Append
     else lDisp := GenRecordLock(PrmGer,True);
  tbEstoques.Enabled := lDisp;
  tbComercial.Enabled := lDisp;
  btOk.Enabled := lDisp;
  btCanc.SetFocus;

end;

procedure TFuParametroGeral.dbDivCodExit(Sender: TObject);
begin
  gbDiv4.Enabled := True;
  gbDiv3.Enabled := True;
  gbDiv2.Enabled := True;
  if PrmGerTCodDiv.AsInteger < 4
  then begin
    PrmGerTCodD4.Clear;
    PrmGerTCodIt4.Clear;
    gbDiv4.Enabled := False;
  end;
  if PrmGerTCodDiv.AsInteger < 3
  then begin
    PrmGerTCodD3.Clear;
    PrmGerTCodIt3.Clear;
    gbDiv3.Enabled := False;
  end;
  if PrmGerTCodDiv.AsInteger < 2
  then begin
    PrmGerTCodD2.Clear;
    PrmGerTCodIt2.Clear;
    gbDiv2.Enabled := False;
    PrmGerTCodD1.AsInteger := PrmGerTCodTam.AsInteger;
  end;

end;

procedure TFuParametroGeral.edSenhaDblClick(Sender: TObject);
begin
  DebugMensagem(FuIniGeral.wInicial.LDebug,'Senha [' + PrmGerSenhaVendas.AsString + ']');
    
end;

end.
