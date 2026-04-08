unit uProjParcelamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask, Buttons, DB, DBClient, DBCtrls;
  Procedure ProjecaoParcelamento(pValorInicial:Currency;
                                 pTxCCred,pTxCrediar,pTxBoleto,pTxCheque:Real;
                                 pTxInicio: Integer;
                                 pPrzMedio:Boolean);

type
  TFuProjParcelamento = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btSimular: TBitBtn;
    btSair: TBitBtn;
    CDSProj: TClientDataSet;
    dbValor: TDBEdit;
    SCDSProj: TDataSource;
    CDSProjVlrInicial: TCurrencyField;
    CDSProjVlrEntrada: TCurrencyField;
    CDSProjNrParcel: TSmallintField;
    CDSProjVlrFinal: TCurrencyField;
    CDSProjVlrParcela: TCurrencyField;
    dbEntrada: TDBEdit;
    dbParcelas: TDBComboBox;
    CDSProjFormaParc: TSmallintField;
    CDSProjVlrJuros: TCurrencyField;
    gbFinal: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    dbForma: TDBRadioGroup;
    LabParcelas: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure btSimularClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbParcelasExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuProjParcelamento: TFuProjParcelamento;
  wTaxas: array[0..3] of Real;
  wFormaIni: Integer;
  lPrzMedio: Boolean;

implementation

uses uGenericas;

{$R *.dfm}

Procedure ProjecaoParcelamento(pValorInicial:Currency;
                               pTxCCred,pTxCrediar,pTxBoleto,pTxCheque:Real;
                               pTxInicio: Integer;
                               pPrzMedio:Boolean);
// pValorInicial: Valor a ser financiado
// pTxCCred:    Cartão de crédito     Taxas a serem informadas na 'chamada'
// pTxCrediar:  Crediário
// pTxBoleto:   Boleto
// pTxCheque:   Cheques
// pTxInicio:   Padrão de inicio (0..3) cfe Cartão, crediario...
// pPrzMedio:   Calculo das parcelas considerando Prazo Medio ou não

var lOk: Boolean;
begin
  FuProjParcelamento := TFuProjParcelamento.Create(nil);
  wTaxas[0]   := pTxCCred;
  wTaxas[1]   := pTxCrediar;
  wTaxas[2]   := pTxBoleto;
  wTaxas[3]   := pTxCheque;
  wFormaIni   := pTxInicio;
  lPrzMedio   := pPrzMedio;
  lOk := True;
  with FuProjParcelamento
  do begin
    CDSProj.Active := False;
    CDSProj.FieldDefs.Clear;
    CDSProj.FieldDefs.Add('VlrInicial', ftCurrency);             // Valor inicial
    CDSProj.FieldDefs.Add('VlrEntrada', ftCurrency);             // Entrada
    CDSProj.FieldDefs.Add('NrParcel',   ftInteger);              // Parcelas
    CDSProj.FieldDefs.Add('FormaParc',  ftInteger);              // 0..3
    CDSProj.FieldDefs.Add('VlrJuros',   ftCurrency);             // Valor dos juros  
    CDSProj.FieldDefs.Add('VlrFinal',   ftCurrency);             // Valor final
    CDSProj.FieldDefs.Add('VlrParcela', ftCurrency);             // Parcela
    CDSProj.IndexDefs.Clear;
    Try
      CDSProj.CreateDataSet;
    Except
      MessageDlg('Impossível criar DataSet',mtError,[mbOk],0);
      lOk := False;
    End;
    if lOk
    then begin
      CDSProj.Active  := True;
      CDSProj.Append;
      CDSProjVlrInicial.AsCurrency  := pValorInicial;
      CDSProjVlrEntrada.AsCurrency  := 0;
      CDSProjNrParcel.AsInteger     := 2;
      CDSProjFormaParc.AsInteger    := pTxInicio;
      CDSProjVlrFinal.Clear;
      CDSProjVlrParcela.Clear;
      LabParcelas.Caption           := '';
      ShowModal;
      CDSProj.Active  := False;
    end;
  end;
  FuProjParcelamento.Free;

end;

procedure TFuProjParcelamento.FormActivate(Sender: TObject);
begin
  Form_Define(FuProjParcelamento);
  dbEntrada.SetFocus;

end;

procedure TFuProjParcelamento.btSairClick(Sender: TObject);
begin
  CDSProj.Cancel;
  FuProjParcelamento.Close;

end;

procedure TFuProjParcelamento.btSimularClick(Sender: TObject);
var jurMens,jurDiar: Real;
    i,iValor,nParcel,nPgtos,iPrcIni,iVlPrc,iResto,somaDias,prazoMedio,wDias: Integer;
    wVlr: array[1..24] of Real;
    wJur: array[1..24] of Real;
    wInicial,wEntrada,wVlrAux,somaJuros,vlrJur: Currency;

begin
  nParcel := CDSProjNrParcel.AsInteger;
  nPgtos  := CDSProjNrParcel.AsInteger;
  if (CDSProjVlrEntrada.AsCurrency > 0)
     then nPgtos := nPgtos + 1;
  if (nPgtos < 1) or (nPgtos > 24)
  then begin
    MessageDlg('Indique a quantidade de parcelas (1 a 24)',mtError,[mbOk],0);
    dbParcelas.SetFocus;
    Exit;
  end;
  if (dbForma.ItemIndex < 0) or (dbForma.ItemIndex > 3)
  then begin
    MessageDlg('Indique a forma de parcelamento',mtError,[mbOk],0);
    dbForma.SetFocus;
    Exit;
  end;
  //
  CDSProj.Post;
  CDSProj.Edit;
  wInicial := CDSProjVlrInicial.AsCurrency;
  wEntrada := CDSProjVlrEntrada.AsCurrency;
  jurMens  := wTaxas[dbForma.ItemIndex];
  jurDiar  := Round((jurMens / 30) * 1000000);
  jurDiar  := jurDiar / 1000000;
  for i := 1 to 24
  do begin
    wVlr[i] := 0;
    wJur[i] := 0;
  end;
  wVlrAux := (wInicial - wEntrada) * 100;
  iValor  := Round(wVlrAux);                    // Valor INTEIRO (a ser parcelado)
  iPrcIni := 1;
  if wEntrada > 0
  then begin              // Operação COM entrada
    iPrcIni := 2;
    wVlr[1] := wEntrada;
    wJur[1] := 0;
  end;
  iVlPrc  := iValor div nParcel;                         // Valor parcela INTEIRO
  iResto  := iValor mod nParcel;                         // Resto INTEIRO (será somado na PRIMEIRA parcela APÓS entrada)
  // Valores das parcelas SEM os acrescimos
  wVlr[iPrcIni] := (iVlPrc + iResto) / 100;              // 1a. parcela com o resto
  for i := iPrcIni+1 to nPgtos
    do wVlr[i] := iVlPrc / 100;
  //
  somaDias := 0;
  wDias    := 30;
  for i := iPrcIni to nPgtos
  do begin
    somaDias := somaDias + wDias;
    wDias    := wDias + 30;
  end;
  prazoMedio := somaDias div nPgtos;
  //
  if lPrzMedio
  then begin
    somaJuros := (CalculaPercentual(wVlr[iPrcIni], (jurDiar * prazoMedio), 2)) * nParcel;
  end
  else begin
    somaJuros := 0;
    wDias     := 30;
    for i := iPrcIni to nPgtos
    do begin
      vlrJur    := CalculaPercentual(wVlr[i], (jurDiar * wDias), 2);
      somaJuros := somaJuros + vlrJur;
      wDias     := wDias + 30;
    end;
    iValor    := Round(somaJuros * 100);
    somaJuros := iValor / 100;
  end;
  CDSProjVlrJuros.AsCurrency   := somaJuros;
  CDSProjVlrFinal.AsCurrency   := CDSProjVlrInicial.AsCurrency + somaJuros;
  CDSProjVlrParcela.AsCurrency := (CDSProjVlrFinal.AsCurrency - CDSProjVlrEntrada.AsCurrency) / nParcel;
  CDSProj.Post;
  CDSProj.Edit;
  //
  gbFinal.Visible := True;

end;

procedure TFuProjParcelamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form_Salva(FuProjParcelamento);
  
end;

procedure TFuProjParcelamento.dbParcelasExit(Sender: TObject);
begin
  LabParcelas.Caption := '';
  if CDSProjVlrEntrada.AsCurrency > 0
     then LabParcelas.Caption := dbParcelas.Text + ' + Entrada'
     else LabParcelas.Caption := '';
     
end;

end.
