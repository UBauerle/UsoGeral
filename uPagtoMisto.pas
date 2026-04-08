unit uPagtoMisto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, DBCtrls, ExtCtrls, Grids, DBGrids,
  Buttons, Mask;
  Function PagamentoMisto(pmtMaxPgt:Integer=5): Boolean;
type
  TFuPagtoMisto = class(TForm)
    PanRodape: TPanel;
    NavPgts: TDBNavigator;
    LabNRegs: TLabel;
    PanTopo: TPanel;
    Panel1: TPanel;
    Label3: TLabel;
    Panel2: TPanel;
    Label4: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    LabEspecif: TLabel;
    LabRestante: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    btMais: TBitBtn;
    btMenos: TBitBtn;
    btSalvar: TBitBtn;
    PanLcto: TPanel;
    dbMeios: TDBRadioGroup;
    Label1: TLabel;
    Label2: TLabel;
    btConfValor: TBitBtn;
    btCancValor: TBitBtn;
    DBText1: TDBText;
    edValor: TDBEdit;
    btAlterar: TBitBtn;
    btNothing: TBitBtn;
    DBGrid1: TDBGrid;
    DBText2: TDBText;
    DBText3: TDBText;
    btCancPgMisto: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure btMenosClick(Sender: TObject);
    procedure btMaisClick(Sender: TObject);
    procedure btConfValorClick(Sender: TObject);
    procedure btCancValorClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btCancPgMistoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuPagtoMisto: TFuPagtoMisto;
  valorTotal,valorEspec,valorRest: Currency;
  maxPgtos,wOper: Integer;
  wResult: Boolean;
  wVlr: array[1..5] of Currency;
  wTPag: array[1..5] of String;

implementation

uses uMensagem, uIniGeral, CaixaLiteDados;

{$R *.dfm}

Function PagamentoMisto(pmtMaxPgt:Integer=5): Boolean;
var i: Integer;
begin
  wResult := False;
  maxPgtos := pmtMaxPgt;
  for i := 1 to 5 do
  begin
    wVlr[i] := 0;
    wTPag[i] := '';
  end;
  i := 0;
  CxDM.VendCard.First;
  while not CxDM.VendCard.Eof do
  begin
    i := i + 1;
    wVlr[i] := CxDM.VendCardValor.AsCurrency;
    wTPag[i] := CxDM.VendCardTPag.AsString;
    CxDM.VendCard.Next;
  end;
  valorTotal := CxDM.VendasZC_VlrTotalParcel.AsCurrency;

  FuPagtoMisto.ShowModal;

  if not wResult then
  begin
    CxDM.VendCard.First;
    while not CxDM.VendCard.Eof
      do CxDM.VendCard.Delete;
    for i := 1 to 5 do
      if wVlr[i] > 0 then
      begin
        CxDM.VendCard.Append;
        CxDM.VendCardSeq.AsInteger := i;
        CxDM.VendCardValor.AsCurrency := wVlr[i];
        CxDM.VendCardTPag.AsString := wTPag[i];
        CxDM.VendCard.Post;
      end;
  end;
  Result := wResult;

end;


Procedure RecalculaExibeValores(pmtSeq:Integer; pmtRecalc:Boolean; pmtExibe:Boolean);
begin
  with FuPagtoMisto
  do begin
    if pmtRecalc
    then begin
      valorEspec := 0;
      CxDM.VendCard.First;
      while not CxDM.VendCard.Eof
      do begin
        valorEspec := valorEspec + CxDM.VendCardValor.AsCurrency;
        CxDM.VendCard.Next;
      end;
      valorRest := valorTotal - valorEspec;
    end;
    if pmtExibe
    then begin
      if valorEspec < valorTotal
      then begin
        Panel3.Color := clYellow;
        LabEspecif.Font.Color := clWindowText;
        Panel4.Color := clRed;
        LabRestante.Font.Color := clWhite;
      end
        else begin                 // valorEspec = valorTotal
        Panel3.Color := clLime;
        LabEspecif.Font.Color := clWindowText;
        Panel4.Color := Panel2.Color;
        LabRestante.Font.Color := clWindowText;
      end;
      LabEspecif.Caption := FloatToStrF(valorEspec,ffNumber,15,2);
      LabRestante.Caption := FloatToStrF(valorRest,ffNumber,15,2);
    end;
    LabNRegs.Caption := IntToStr(CxDM.VendCard.RecordCount) + ' registros';
    if pmtSeq <> 0
       then CxDM.VendCard.FindKey([CxDM.VendasNrVenda.AsInteger,pmtSeq]);
  end;

end;


Procedure AjustaTela(pmtModo:Boolean);
begin
  with FuPagtoMisto
  do begin
    PanLcto.Enabled := pmtModo;
    btConfValor.Visible := pmtModo;
    btCancValor.Visible := pmtModo;
    if pmtModo then pmtModo := False
               else pmtModo := True;
    PanRodape.Enabled := pmtModo;
    NavPgts.Enabled := pmtModo;
    btMais.Enabled := pmtModo;
    btMenos.Enabled := pmtModo;
    btAlterar.Enabled := pmtModo;
    btSalvar.Enabled := pmtModo;
    btCancPgMisto.Enabled := pmtModo;
  end;

end;



procedure TFuPagtoMisto.FormActivate(Sender: TObject);
begin
  RecalculaExibeValores(0, True, True);
  btMais.SetFocus;

end;

procedure TFuPagtoMisto.FormCreate(Sender: TObject);
begin
  Label3.Color := clTeal;
  Label4.Color := clTeal;
  Label5.Color := clTeal;
  Label6.Color := clTeal;

  end;

procedure TFuPagtoMisto.btMenosClick(Sender: TObject);
begin
  if CxDM.VendCard.RecordCount = 0 then Exit;
  if msgSistema(3,'Exclusão','Excluir lançamento de pagamento ?' + #13#13 +
                  'Seq: ' + CxDM.VendCardSeq.AsString +
                  '   Valor: ' + FloatToStrF(CxDM.VendCardValor.AsCurrency,ffNumber,15,2) + #13 +
                  'Meio de pagamento: ' +  CxDM.VendCardZC_TPag.AsString,3,2) = 1
  then begin
    CxDM.VendCard.Delete;
    RecalculaExibeValores(0, True, True);
  end;
  btNothing.SetFocus;

end;

procedure TFuPagtoMisto.btMaisClick(Sender: TObject);
var nSeq: Integer;
begin
  if CxDM.VendCard.RecordCount = maxPgtos
  then begin
    msgSistema(2,'Limite de pagamentos','São permitidos até ' + IntToStr(maxPgtos),1,1,'Ok');
    Exit;
  end;
  if CxDM.VendCard.RecordCount = 0 then nSeq := 1
  else begin
    CxDM.VendCard.Last;
    nSeq := CxDM.VendCardSeq.AsInteger + 1
  end;
  wOper := 1;
  CxDM.VendCard.Append;
  CxDM.VendCardNrVenda.AsInteger := CxDM.VendasNrVenda.AsInteger;
  CxDM.VendCardSeq.AsInteger := nSeq;
  CxDM.VendCardValor.AsCurrency := valorRest;
  CxDM.VendCardTPag.AsString := '03';  // Cartão de crédito
  CxDM.VendCardTpIntegra.AsInteger := CxDM.VendasZL_IntegracaoTEFPOS.AsInteger;
  if CxDM.VendCardTpIntegra.AsInteger <> 1        // Se não for TEF
     then CxDM.VendCardTpIntegra.AsInteger := 2;    // Considera POS, mesmo que não utilize
  AjustaTela(True);
  edValor.SetFocus;

end;

procedure TFuPagtoMisto.btConfValorClick(Sender: TObject);
begin
  if (valorEspec + CxDM.VendCardValor.AsCurrency) > valorTotal
  then begin
    msgSistema(1,'Valor excedente','Valor informado EXCEDE ao valor total' + #13#13 + 'Reinforme',1,1,'Reinformar');
    edValor.SetFocus;
    Exit;
  end;
  CxDM.VendCard.Post;
  RecalculaExibeValores(CxDM.VendCardSeq.AsInteger, True, True);
  AjustaTela(False);
  if valorEspec = valorTotal
  then btSalvar.SetFocus
  else if wOper = 1
       then btMais.SetFocus
       else btNothing.SetFocus;


end;

procedure TFuPagtoMisto.btCancPgMistoClick(Sender: TObject);
begin
  wResult := False;
  FuPagtoMisto.Close;

end;

procedure TFuPagtoMisto.btCancValorClick(Sender: TObject);
begin
  CxDM.VendCard.Cancel;
  RecalculaExibeValores(0, True, True);
  AjustaTela(False);
  if wOper = 1
     then btMais.SetFocus
     else btNothing.SetFocus;

end;

procedure TFuPagtoMisto.btSalvarClick(Sender: TObject);
begin
  if valorEspec <> valorTotal
  then begin
    msgSistema(1,'Diferença de valores',
                 'Há diferença entre o valor da operação e o valor especificado' + #13#13 +
                 'Verifique os valores',1,1);
    btMais.SetFocus;
    Exit;
  end;
  if CxDM.VendCard.RecordCount < 2
  then begin
    msgSistema(1,'Meios de pagamento',
                 'Há somente UM registro de pagamento especificado' + #13 +
                 'Sendo pagamento MISTO deve haver no mínimo dois lançamentos indicados' + #13 +
                 'Complemente a informação por favor',1,1);
    btMais.SetFocus;
    Exit;
  end;
  wResult := True;
  FuPagtoMisto.Close;

end;

procedure TFuPagtoMisto.btAlterarClick(Sender: TObject);
begin
  if CxDM.VendCard.RecordCount = 0 then Exit;
  Try
    CxDM.VendCard.Edit;
  Except
    Exit;
  End;
  wOper := 2;
  valorEspec := valorEspec - CxDM.VendCardValor.AsCurrency;
  AjustaTela(True);
  edValor.SetFocus;

end;

end.
