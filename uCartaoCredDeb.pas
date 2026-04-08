unit uCartaoCredDeb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, DBTables, Mask, DBCtrls;
  Function TransacaoCartao(pmtDBPath,pmtTabName,pmtTerminal:String;
                           pmtNrOper,pmtSeq,pmtParcelas,pmtTpCartao,pmtIntegracao:Integer;
                           pmtPadraoCred,pmtPadraoDeb:Integer;
                           pmtValor:Currency;
                           pmtGhost:Boolean;
                           pmtMaxParcel:Integer=12;
                           pmtConfValor:Real=0;
                           pmtValParcMin:Real=5): Boolean;


type
  TFTransCartao = class(TForm)
    Panel1: TPanel;
    btOk: TBitBtn;
    btCancelar: TBitBtn;
    Panel2: TPanel;
    Label3: TLabel;
    dbAutorizacao: TDBEdit;
    edTerminal: TDBEdit;
    edDataHora: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    TbBand: TTable;
    TbBandCod: TSmallintField;
    TbBandDenom: TStringField;
    TbBandAbrev: TStringField;
    dbIntegracao: TDBRadioGroup;
    Label2: TLabel;
    dbBandeira: TDBLookupComboBox;
    STbBand: TDataSource;
    dbTpCartao: TDBRadioGroup;
    LabParcelas: TLabel;
    dbParcelas: TDBComboBox;
    Label7: TLabel;
    dbAfiliacao: TDBLookupComboBox;
    TbAfil: TTable;
    STbAfil: TDataSource;
    TbAfilCod: TSmallintField;
    TbAfilAfiliacao: TStringField;
    TbAfilCNPJ: TStringField;
    VendCard: TTable;
    SVendCard: TDataSource;
    TbAfilDisp: TBooleanField;
    TbBandDisp: TBooleanField;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DBText1: TDBText;
    LabValor: TLabel;
    dbPrimParcela: TDBRadioGroup;
    gbVlrParcela: TGroupBox;
    PanVlrParcela: TPanel;
    VendCardNrVenda: TIntegerField;
    VendCardSeq: TSmallintField;
    VendCardIndPag: TSmallintField;
    VendCardTPag: TStringField;
    VendCardValor: TCurrencyField;
    VendCardTpIntegra: TSmallintField;
    VendCardAfiliacao: TSmallintField;
    VendCardCNPJ: TStringField;
    VendCardBandeira: TSmallintField;
    VendCardCAut: TStringField;
    VendCardNrCartao: TStringField;
    VendCardParcelas: TSmallintField;
    VendCardVTroco: TCurrencyField;
    VendCardIdTerminal: TStringField;
    VendCardDataHora: TDateTimeField;
    VendCardNroDocto: TStringField;
    VendCardCodVenda: TStringField;
    VendCardPrimParcela: TSmallintField;
    VendCardOutraBand: TStringField;
    GroupBox3: TGroupBox;
    DBText2: TDBText;
    procedure btCancelarClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure dbTpCartaoChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbIntegracaoChange(Sender: TObject);
    procedure dbParcelasExit(Sender: TObject);
    procedure dbAfiliacaoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbPrimParcelaExit(Sender: TObject);
    procedure dbIntegracaoEnter(Sender: TObject);
    procedure dbIntegracaoExit(Sender: TObject);
    procedure dbTpCartaoEnter(Sender: TObject);
    procedure dbTpCartaoExit(Sender: TObject);
    procedure dbPrimParcelaEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTransCartao: TFTransCartao;
  wrkResultado: Boolean;
  wPadraoCred,wPadraoDeb: Integer;
  wMaxParcel: Integer;
  vlrTotal,vlrParcela,vlrParcMin: Currency;

implementation

uses uGenericas, uMensagem;

{$R *.dfm}

Function TransacaoCartao(pmtDBPath,pmtTabName,pmtTerminal:String;
                         pmtNrOper,pmtSeq,pmtParcelas,pmtTpCartao,pmtIntegracao:Integer;
                         pmtPadraoCred,pmtPadraoDeb:Integer;
                         pmtValor:Currency;
                         pmtGhost:Boolean;
                         pmtMaxParcel:Integer=12;
                         pmtConfValor:Real=0;
                         pmtValParcMin:Real=5): Boolean;
{  Parametros
   pmtDBPath:     Path dos dados
   pmtTabName:    Nome da tabelas (VendCard.DB, TE_PedsCard.DB, DiaVendCard.DB, etc
   pmtTerminal:   Identificação do terminal (PINPAD)
   pmtNrOper:     Nro da operação (Venda, Pedido, etc)
   pmtParcelas:   Quantidade de parcelas (1 a nn)
   pmtTpCartao:   Tipo de cartão (3-Crédito, 4-Débito)
   pmtIntegracao: 1-TEF    2-POS
   pmtPadraoCred: Afiliacao padrao de crédito
   pmtPadraoDeb:  Afiliacao padrao de débito
   pmtValor:      Valor da operação
   pmtMaxParcel:  Nr. máximo de parcelas
   pmtConfValor:  Valor limite (segurança)
}
var wMsg: String;
    i: Integer;
begin
  Result := False;
  if ((pmtTpCartao <> 3) and (pmtTpCartao <> 4)) or (pmtValor = 0)
  then begin
    Result := True;
    Exit;
  end;
  vlrParcMin := pmtValParcMin;
  //
  if (pmtConfValor <> 0) and (pmtValor > pmtConfValor)
  then if msgSistema(3,'Confirmação de valor',
                       'O valor da transação excede o limite de segurança' + #13#13 +
                       'Valor da transação: R$ ' + FloatToStrF(pmtValor,ffNumber,15,2) +
                       '       limite de segurança: R$ ' + FloatToStrF(pmtConfValor,ffNumber,15,2) + #13#13 +
                       'Confirme a realização da transação',
                       3,2) <> 1
       then Exit;
  //
  wPadraoCred := pmtPadraoCred;
  wPadraoDeb := pmtPadraoDeb;
  wMaxParcel := pmtMaxParcel;
  wMsg := '';
  //FTransCartao := TFTransCartao.Create(nil);
  with FTransCartao
  do begin
    TbBand.DatabaseName := pmtDBPath;
    Try
      TbBand.Active := True;
    Except
      wMsg := wMsg + '[ ' + pmtDBPath + '  ' + TbBand.TableName + ' ]' + #13;
    End;
    TbAfil.DatabaseName := pmtDBPath;
    Try
      TbAfil.Active := True;
    Except
      wMsg := wMsg + '[ ' + pmtDBPath + '  ' + TbAfil.TableName + ' ]' + #13;
    End;
    VendCard.DatabaseName := pmtDBPath;
    VendCard.TableName := pmtTabName;
    Try
      VendCard.Active := True;
    Except
      wMsg := wMsg + '[ ' + pmtDBPath + '  ' + VendCard.TableName + ' ]' + #13;
    End;

    if Length(Trim(wMsg)) > 0
    then begin
      MessageDlg('Falha de abertura' + #13 + wMsg,mtError,[mbOk],0);
      TbBand.Active := False;
      TbAfil.Active := False;
      VendCard.Active := False;
      FTransCartao.Free;
      Result := False;
      Exit;
    end;
    //
    dbParcelas.Items.Clear;
    for i := 1 to wMaxParcel
      do dbParcelas.Items.Add(IntToStr(i));             // stringCompleta(IntToStr(i),'E','0',2));
    if VendCard.FindKey([pmtNrOper,pmtSeq])
    then VendCard.Edit
    else begin
      VendCard.Append;
      VendCardNrVenda.AsInteger := pmtNrOper;
      VendCardSeq.AsInteger := pmtSeq;
      VendCardTpIntegra.AsInteger := pmtIntegracao;    // 1-TEF  2-POS
      VendCardParcelas.AsInteger := pmtParcelas;
      VendCardTPag.AsString := stringCompleta(IntToStr(pmtTpCartao),'E','0',2);      // 03-Credito   04-Débito
      VendCardValor.AsCurrency := pmtValor;
      if pmtTpCartao = 3
         then VendCardAfiliacao.AsInteger := pmtPadraoCred
         else VendCardAfiliacao.AsInteger := pmtPadraoDeb;
    end;
    VendCardIdTerminal.AsString := pmtTerminal;
    VendCardDataHora.AsDateTime := Now;
    LabValor.Caption := 'R$ ' + FloatToStrF(pmtValor,ffNumber,15,2);
    vlrTotal := pmtValor;
    vlrParcela := pmtValor;
    if pmtParcelas > 1
      then vlrParcela := vlrTotal / pmtParcelas;
    PanVlrParcela.Caption := 'R$ ' + FloatToStrF(vlrParcela,ffNumber,15,2);

    if pmtMaxParcel <= 1
    then begin
      dbParcelas.Visible := False;
      LabParcelas.Visible := False;
      PanVlrParcela.Visible := False;
    end;

    ShowModal;
    TbBand.Active := False;
    TbAfil.Active := False;
    VendCard.Active := False;
  end;
  Result := wrkResultado;
  if wrkResultado
     then pmtGhost := True;

  //FTransCartao.Free;

end;

Procedure TrataBanricompras;
begin
  with TFTransCartao
  do begin


  end;

end;


procedure TFTransCartao.btCancelarClick(Sender: TObject);
begin
//  CxDM.VendCard.Cancel;
  wrkResultado := False;
  FTransCartao.Close;

end;

procedure TFTransCartao.btOkClick(Sender: TObject);
var wMsg: String;
begin
  wMsg := '';
  if VendCardAfiliacao.AsInteger = 0
     then wMsg := wMsg + 'Afiliação não informada' + #13;
  if VendCardTpIntegra.AsInteger = 2
  then begin        // POS
    if VendCardBandeira.AsInteger = 0
       then wMsg := wMsg + 'Bandeira não informada' + #13;
    if VendCardCAut.AsString = ''
       then wMsg := wMsg + 'Autorização não informada' + #13;
  end
  else begin        // TEF
    VendCardBandeira.AsInteger := 0;
    VendCardCAut.AsString := '';
  end;
  if (VendCardParcelas.AsInteger < 1) or (VendCardParcelas.AsInteger > wMaxParcel)
    then wMsg := wMsg + 'Nr. de parcelas inválido (1 a ' + IntToStr(wMaxParcel) + ')' + #13;

  if VendCardParcelas.AsInteger > 1
  then if vlrParcela < vlrParcMin
       then wMsg := wMsg + '==============' + #13 +
                           'Valor da parcela inválido, inferior à R$ ' + FloatToStrF(vlrParcMin,ffNumber,15,2) + #13 +
                           '==============' + #13;
  if Length(Trim(wMsg)) > 0
  then begin
    MessageDlg('Erro(s) detectado(s), reinforme' + #13 + wMsg,mtError,[mbOk],0);
    dbBandeira.SetFocus;
    Exit;
  end;
  //
  if (VendCardTPag.AsString = '04')             // Cartão de débito
     and (VendCardAfiliacao.AsInteger = 4)      // VERO (Banrisul)
  then begin
    if VendCardPrimParcela.AsInteger = 0
       then FTransCartao.VendCardIndPag.AsInteger := 0          // Primeira parcela À VISTA, demais parcelas a cada 30 dias (se houver)
       else FTransCartao.VendCardIndPag.AsInteger := 1;         // Primeira parcela 30 DD, demais parcelas a cada 30 dias após a 1a.
  end
  else begin           // Cartão crédito/débito,  Afiliação <> VERO
    VendCardIndPag.AsInteger := VendCardPrimParcela.AsInteger;
    if VendCardParcelas.AsInteger > 1
       then VendCardIndPag.AsInteger := 1;           // 0-A vista   1-Prazo/Parcelado
  end;
  //
  VendCardIdTerminal.AsString := edTerminal.Text;
  VendCard.Post;
  wrkResultado := True;
  FTransCartao.Close;

end;


procedure TFTransCartao.dbTpCartaoChange(Sender: TObject);
begin
  if (VendCard.State <> dsEdit) and (VendCard.State <> dsInsert) then Exit;
  if VendCardParcelas.AsInteger = 0
     then VendCardParcelas.AsInteger := 1;
  //
  dbPrimParcela.Visible := False;         // Faz a tratativa do banricompras
  VendCardPrimParcela.AsInteger := 0;     // 1a.parcela à vista (sempre)
  if dbTpCartao.ItemIndex = 0
  then begin           // Cartão de crédito
    VendCardAfiliacao.AsInteger := wPadraoCred;
    dbParcelas.Enabled := True;
    Exit;
  end;
  // Cartão de débito
  if VendCardParcelas.AsInteger = 0
     then VendCardParcelas.AsInteger := 1;
  VendCardAfiliacao.AsInteger := wPadraoDeb;
  dbParcelas.Enabled := False;
  if wPadraoDeb =  4      // Vero (Banrisul / Banricompras)
  then begin
    dbPrimParcela.Visible := True;
    dbParcelas.Enabled := True;
  end;

end;

procedure TFTransCartao.FormActivate(Sender: TObject);
begin
  dbTpCartaoChange(nil);    // Se cartão de crédito(3) ou débito(4)
  
end;

procedure TFTransCartao.dbIntegracaoChange(Sender: TObject);
var lDisp: Boolean;
begin
  lDisp := True;
  if dbIntegracao.ItemIndex = 0
     then lDisp := False;     // TEF - Não disponibiliza os dados abaixo indicados
  dbBandeira.Enabled := lDisp;
  dbAutorizacao.Enabled := lDisp;
  edTerminal.Enabled := lDisp;
  edDataHora.Enabled := lDisp;

end;

procedure TFTransCartao.dbParcelasExit(Sender: TObject);
begin
  if dbPrimParcela.Visible and                     // Banricompras visivel
     (dbPrimParcela.ItemIndex > 1)                 // Parcelado
  then begin
    if VendCardParcelas.AsInteger < 2              // Nr. de parcelas
    then begin
      MessageDlg('Banricompras parcelado deve ter duas ou mais parcelas, reinforme',mtError,[mbOk],0);
      dbParcelas.SetFocus;
      Exit;
    end;
    if dbPrimParcela.ItemIndex = 0
       then VendCardIndPag.AsInteger := 0   // 1a.parcela a vista
       else VendCardIndPag.AsInteger := 1;  // 1a.parcela 30 dd
  end;
  //
  vlrParcela := vlrTotal / VendCardParcelas.AsInteger;
  PanVlrParcela.Caption := 'R$ ' + FloatToStrF(vlrParcela,ffNumber,15,2);
  Application.ProcessMessages;
  
end;

procedure TFTransCartao.dbAfiliacaoExit(Sender: TObject);
begin
  if (VendCard.State <> dsEdit) and (VendCard.State <> dsInsert) then Exit;
  if dbTpCartao.ItemIndex = 0
  then begin           // Cartão de crédito   (VendCardTpCartao = 03)
    dbParcelas.Enabled := True;
    VendCardPrimParcela.AsInteger := 0;
    dbPrimParcela.Visible := False;
    if dbIntegracao.ItemIndex = 0
      then dbParcelas.SetFocus      // TEF
      else dbBandeira.SetFocus;     // POS
    Exit;
  end;
  // Cartão de débito   (VendCardTpCartao = 04)
  if VendCardParcelas.AsInteger = 0
       then VendCardParcelas.AsInteger := 1;
  dbParcelas.Enabled := False;
  dbPrimParcela.Visible := False;
  if VendCardAfiliacao.AsInteger =  4      // Vero (Banrisul / Banricompras)
  then begin
    dbParcelas.Enabled := True;
    VendCardPrimParcela.AsInteger := 0;    // 1a.parcela à vista
    dbPrimParcela.Visible := True;
    dbPrimParcela.SetFocus;
    Exit;
  end;
  if dbIntegracao.ItemIndex = 0
  then begin      // TEF
    if dbParcelas.Enabled
       then dbParcelas.SetFocus
       else btOk.SetFocus;
  end
  else dbBandeira.SetFocus;     // POS

end;

procedure TFTransCartao.FormCreate(Sender: TObject);
begin
  Height := 620;
  Width := 542;

end;

procedure TFTransCartao.dbPrimParcelaExit(Sender: TObject);
begin
// 0-Deb av;  1-Deb 30 dd;  2-Parcelado(1a.av);  3-Parcelado(1a.30dd);
// Específico para BANRICOMPRAS
// ItemIndex e Valor do campo iguais (0 a 3)
  dbPrimParcela.Color := Panel2.Color;
  if dbPrimParcela.ItemIndex < 2
  then begin                // Débito a vista ou 30 dd
    if dbPrimParcela.ItemIndex = 0
       then VendCardIndPag.AsInteger := 0         // AV
       else VendCardIndPag.AsInteger := 1;        // 30 Dd
    VendCardParcelas.AsInteger := 1;
    dbParcelas.Enabled := False;
  end
  else dbParcelas.Enabled := True;

end;

procedure TFTransCartao.dbIntegracaoEnter(Sender: TObject);
begin
  dbIntegracao.Color := clCream;
  
end;

procedure TFTransCartao.dbIntegracaoExit(Sender: TObject);
begin
  dbIntegracao.Color := Panel2.Color;
  
end;

procedure TFTransCartao.dbTpCartaoEnter(Sender: TObject);
begin
  dbTpCartao.Color := clCream;
  
end;

procedure TFTransCartao.dbTpCartaoExit(Sender: TObject);
begin
  dbTpCartao.Color := Panel2.Color;
  
end;

procedure TFTransCartao.dbPrimParcelaEnter(Sender: TObject);
begin
  dbPrimParcela.Color := clCream;
  
end;

end.
