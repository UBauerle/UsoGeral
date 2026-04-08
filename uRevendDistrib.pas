unit uRevendDistrib;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ExtCtrls, Grids, DBGrids, StdCtrls, Buttons, DBCtrls, Db, DBTables, Mask,
   ToolWin, ComCtrls;
   Function PesqRevendDistrib(pmtDBName,pmtCidade,pmtUF:String; pmtPesq:Boolean; pmtRevDistr:String): Integer;

type
  TFurevendDistrib = class(TForm)
    PanBot: TPanel;
    Nav: TDBNavigator;
    Cad: TTable;
    SCad: TDataSource;
    LabNRegs: TLabel;
    CadSeq: TTable;
    CadSeqCodigo: TIntegerField;
    LabLocaliz: TLabel;
    EdLocaliz: TEdit;
    ToolBar1: TToolBar;
    BtUse: TBitBtn;
    BtInclus: TBitBtn;
    BtAlter: TBitBtn;
    BtExclus: TBitBtn;
    BtCanc: TBitBtn;
    Grid: TDBGrid;
    Label1: TLabel;
    CbOrdem: TComboBox;
    CadCodigo: TIntegerField;
    CadRzSocial: TStringField;
    CadTPes: TStringField;
    CadCNPJ: TStringField;
    CadIEST: TStringField;
    CadIESTUF: TStringField;
    CadDtCadast: TDateField;
    CadLograd: TStringField;
    CadNro: TStringField;
    CadCompl: TStringField;
    CadBairro: TStringField;
    CadCEP: TStringField;
    CadCidade: TStringField;
    CadUF: TStringField;
    CadContNome: TStringField;
    CadDDD: TStringField;
    CadFone1: TStringField;
    CadFone2: TStringField;
    CadEMail: TStringField;
    CadWebSite: TStringField;
    CadCnpjEx: TStringField;
    Panel1: TPanel;
    procedure BtUseClick(Sender: TObject);
    procedure BtCancClick(Sender: TObject);
    procedure EdLocalizChange(Sender: TObject);
    procedure BtInclusClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure CadAfterRefresh(DataSet: TDataSet);
    procedure BtAlterClick(Sender: TObject);
    procedure BtExclusClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CbOrdemChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    wOper,wLastCod,wBotoes,wRetorno: Integer;
    nKCod: Integer;
    xKRzSoc,xKCGC: String;
    wCidade,wUF,wCadas: String;

  end;

var
  FurevendDistrib: TFurevendDistrib;

const
  XOrd: array[0..2] of string = ('','RazaoSocial','CGCCIC');
  XIdP: array[0..2] of String = ('Código','Nome/Razão social','CNPJ/CIC');

implementation

uses uGenericas, PesqRevManut, uMensagem;

{$R *.DFM}

Function PesqRevendDistrib(pmtDBName,pmtCidade,pmtUF:String; pmtPesq:Boolean; pmtRevDistr:String): Integer;
{
   pmtDBName    Databasename
   pmtCidade    Cidade/Municipio padrão
   pmtUF        Estado padrão
   pmtPesq      True->Pesquisa    False->Manutenção
   pmtRevDistr  'R'evendedores (Lojas)  ou 'D'istribuidores (produtos da empresa)
   Retorno      Código de cadastro ou ZERO em caso de erro/cancelamento
}
begin
  FPesqRevend   := TFPesqRevend.Create(nil);
  FPesqRevManut := TFPesqRevManut.Create(nil);
  with FPesqRevend
  do begin
    FPesqRevend.Caption   := 'Cadastro de ';
    if pmtRevDistr = 'R'
    then begin
      Cad.TableName       := 'Revendedores.DB';
      CadSeq.TableName    := 'Revendedores.DB';
      FPesqRevend.Caption := FPesqRevend.Caption + 'Revendedores';
      wCadas              := 'REVENDEDOR';
    end
    else begin
      Cad.TableName       := 'Distribuidores.DB';
      CadSeq.TableName    := 'Distribuidores.DB';
      FPesqRevend.Caption := FPesqRevend.Caption + 'Distribuidores';
      wCadas              := 'DISTRIBUIDOR';
    end;
    Cad.DatabaseName    := pmtDBName;
    CadSeq.DatabaseName := pmtDBName;
    btUse.Visible       := pmtPesq;
    wBotoes             := 5;
    if not pmtPesq
    then begin
      btCanc.Caption    := '&Sair';
      wBotoes           := 4;
    end;
    FPesqRevend.ShowModal;
    Result              := FPesqRevend.wRetorno;
  end;
  FPesqRevManut.Free;
  FPesqRevend.Free;

end;


procedure TFurevendDistrib.BtUseClick(Sender: TObject);
begin
  wRetorno := CadCodigo.AsInteger;
  FPesqRevend.Close;

end;

procedure TFurevendDistrib.BtCancClick(Sender: TObject);
begin
  wRetorno := 0;
  FPesqRevend.Close;

end;

procedure TFurevendDistrib.EdLocalizChange(Sender: TObject);
begin
  if not Cad.Active then Exit;
  if CbOrdem.ItemIndex = 0
    then Cad.FindNearest([StrToIntDef(EdLocaliz.Text,0)])   // Código
    else Cad.FindNearest([Trim(EdLocaliz.Text)]);

end;

procedure TFurevendDistrib.BtInclusClick(Sender: TObject);
begin
  nKCod         := CadCodigo.AsInteger;
  xKRzSoc       := CadRzSocial.AsString;
  xKCGC         := CadCNPJ.AsString;
  CadSeq.Active := True;
  CadSeq.Last;
  wLastCod      := CadSeqCodigo.AsInteger + 1;
  CadSeq.Active := False;
  wOper         := 1;
  FPesqRevManut.ShowModal;
  case CbOrdem.ItemIndex of
    0:EdLocaliz.Text := IntToStr(nKCod);
    1:EdLocaliz.Text := xKRzSoc;
    2:EdLocaliz.Text := xKCGC;
  end;

end;


procedure TFurevendDistrib.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Cad.Active := False;
  Form_Salva(FPesqRevend);

end;

procedure TFurevendDistrib.CadCalcFields(DataSet: TDataSet);
begin
  CadCnpjEx.AsString := EditaCNPJ_CPF(CadCNPJ.AsString,CadTPes.AsString);

end;

procedure TFurevendDistrib.FormCreate(Sender: TObject);
begin
  LabNRegs.Caption := '';
  CbOrdem.ItemIndex := -1;
  LabLocaliz.Caption := XIdP[1];

end;

procedure TFurevendDistrib.CadAfterRefresh(DataSet: TDataSet);
begin
  LabNRegs.Caption := IntToStr(Cad.RecordCount) + ' registros';

end;

procedure TFurevendDistrib.BtAlterClick(Sender: TObject);
begin
  if Cad.RecordCount = 0 then Exit;
  if not GenRecordLock(Cad,True) then Exit;
  nKCod   := CadCodigo.AsInteger;
  xKRzSoc := CadRzSocial.AsString;
  xKCGC   := CadCNPJ.AsString;
  wOper   := 2;
  FPesqRevManut.ShowModal;
  case CbOrdem.ItemIndex of
    0:EdLocaliz.Text := IntToStr(nKCod);
    1:EdLocaliz.Text := xKRzSoc;
    2:EdLocaliz.Text := xKCGC;
  end;

end;

procedure TFurevendDistrib.BtExclusClick(Sender: TObject);
begin
  if Cad.RecordCount = 0 then Exit;
  if msgSistema(3,'Exclusão de ' + wCadas,
                  'Razão social: ' + CadRzSocial.AsString + #13 +
                  'Confirme',3,2) <> 1 then Exit;


  if not GenRecordLock(Cad,True) then Exit;
  Cad.Delete;
  LabNRegs.Caption := IntToStr(Cad.RecordCount) + ' registros';

end;

procedure TFurevendDistrib.FormResize(Sender: TObject);
var wLg,wLgCanc: Integer;
const wLrg: array[0..11] of Real = (0.33, 0.10, 0.04, 0.12, 0.03, 0.06, 0.06, 0.12, 0.04, 0.08, 0.08, 0.03);
begin
  if FPesqRevend.Width < 597 then FPesqRevend.Width := 597;
  if FPesqRevend.Height < 541 then FPesqRevend.Height := 541;
  wLg := (ToolBar1.Width-21) div wBotoes;
  wLgCanc := (ToolBar1.Width-21) - ((wLg * (wBotoes-1)) + wBotoes);
  if btUse.Visible then btUse.Width := wLg
                   else btUse.Width := 0;
  if wLg > 200
  then begin
    wLg := 200;
    wLgCanc := 200;
  end;
  btInclus.Width := wLg;
  btAlter.Width := wLg;
  btExclus.Width := wLg;
  btCanc.Width := wLgCanc;
  Grid := DefineGrid(Grid, wlrg, 0, 0);

end;

procedure TFurevendDistrib.CbOrdemChange(Sender: TObject);
const Tam: array [0..2] of Integer = (72,248,120);
begin
  if not Cad.Active then Exit;
  LabLocaliz.Caption := 'Localizar por ' + XIdP[CbOrdem.ItemIndex];
  EdLocaliz.Text := '';
  EdLocaliz.Width := Tam[CbOrdem.ItemIndex];
  Cad.IndexName := XOrd[CbOrdem.ItemIndex];
  Cad.Refresh;

end;

procedure TFurevendDistrib.FormShow(Sender: TObject);
begin
  CbOrdem.ItemIndex := 1;
  EdLocaliz.Text := '';
  Form_Define(FPesqRevend);
  FPesqRevend.FormResize(nil);
  Cad.IndexName := XOrd[CbOrdem.ItemIndex];
  Cad.Filtered := False;
  Cad.Active := True;
  Cad.Refresh;
  Cad.First;
  LabNRegs.Caption := IntToStr(Cad.RecordCount) + ' registros';
  EdLocaliz.SetFocus;

end;

end.
