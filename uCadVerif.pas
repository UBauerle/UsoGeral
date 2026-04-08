unit uCadVerif;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, DB, DBTables, Gauges, ExtCtrls, DateUtils;
  Procedure uVerificaCadastro(pDBName:String);
  Function  uCalculaSaldoPortador(pDBName:String; pPortador:Integer; var vCredDisp:Currency;
                                                  var vRecVenc:Currency; var nRecVenc:Integer): Real;


type
  TFuCadVerif = class(TForm)
    Memo1: TMemo;
    VCadas: TTable;
    VDep: TTable;
    VDepCodigo: TIntegerField;
    VCadasCodigo: TIntegerField;
    VCadasRzSocial: TStringField;
    VCadasFantasia: TStringField;
    Panel1: TPanel;
    Label1: TLabel;
    Gau1: TGauge;
    LabTotal: TLabel;
    LabMax: TLabel;
    Gau2: TGauge;
    LabProcess: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    btProcesso: TBitBtn;
    btCancel: TBitBtn;
    btSair: TBitBtn;
    Timer1: TTimer;
    Titulos: TTable;
    TitulosPagRec: TStringField;
    TitulosNro: TIntegerField;
    TitulosParc: TStringField;
    TitulosPortador: TIntegerField;
    TitulosValor: TCurrencyField;
    TitulosDtVencto: TDateField;
    TitulosTpJur: TSmallintField;
    TitulosPcJur: TBCDField;
    TitulosVlDesc: TCurrencyField;
    TitulosPgtCapital: TCurrencyField;
    TitulosPgtJuros: TCurrencyField;
    TitulosPgtDesc: TCurrencyField;
    TitulosMultaVlr: TCurrencyField;
    CadFSit: TTable;
    CadFSitCodigo: TIntegerField;
    CadFSitDtHrCalc: TDateTimeField;
    CadFSitCPagVencVlr: TCurrencyField;
    CadFSitCPagVencTits: TSmallintField;
    CadFSitCPagAVenVlr: TCurrencyField;
    CadFSitCPagAVenTits: TSmallintField;
    CadFSitCPagVlrTotal: TCurrencyField;
    CadFSitCPagQtTotal: TSmallintField;
    CadFSitCPagVlrQuit: TCurrencyField;
    CadFSitCPagTtQuit: TSmallintField;
    CadFSitCPagDiasAtraso: TIntegerField;
    CadFSitCPagMaiorAtraso: TSmallintField;
    CadFSitCPagTotAtraso: TSmallintField;
    CadFSitCRecVencVlr: TCurrencyField;
    CadFSitCRecVencTits: TSmallintField;
    CadFSitCRecAVenVlr: TCurrencyField;
    CadFSitCRecAVenTits: TSmallintField;
    CadFSitCRecVlrTotal: TCurrencyField;
    CadFSitCRecQtTotal: TSmallintField;
    CadFSitCRecVlrQuit: TCurrencyField;
    CadFSitCRecTtQuit: TSmallintField;
    CadFSitCRecDiasAtraso: TIntegerField;
    CadFSitCRecMaiorAtraso: TSmallintField;
    CadFSitCRecTotAtraso: TSmallintField;
    CadFSitSaldo: TCurrencyField;
    TitulosSituacao: TSmallintField;
    TitulosDtDesc: TDateField;
    TitulosPgtData: TDateField;
    CadPess: TTable;
    CadPessCodigo: TIntegerField;
    CadPessCredLimite: TCurrencyField;
    CadPessCredUtilizado: TCurrencyField;
    CadPessUltCompra: TDateField;
    TitulosTpDoc: TSmallintField;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btSairClick(Sender: TObject);
    procedure btProcessoClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btSairEnter(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TitulosFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuCadVerif: TFuCadVerif;
  lCancel: Boolean;
  wUsar: array[1..10] of Boolean;
  wTempo: Integer;
  wPortador: Integer;
  filTitCancel: Boolean;


const
  TbName: array[1..8] of String = ('Cad_GerPessoal.DB',
                                   'Cad_GerSitFin.DB',
                                   'Cad_GerEnder.DB',
                                   'Cad_GerHistor.DB',
                                   'Cad_GerApar.DB',
                                   'Cad_GerServ.DB',
                                   'Cad_GerDepend.DB',
                                   'Cad_GerCCor.DB');

implementation

uses uGenericas, uIniGeral;


{$R *.dfm}


Procedure uVerificaCadastro(pDBName:String);
begin
  FuCadVerif                     := TFuCadVerif.Create(nil);
  FuCadVerif.VCadas.DatabaseName := pDBName;
  FuCadVerif.VDep.DatabaseName   := pDBName;
  FuCadVerif.ShowModal;
  FuCadVerif.Free;

end;


Function  uCalculaSaldoPortador(pDBName:String; pPortador:Integer; var vCredDisp:Currency;
                                var vRecVenc:Currency; var nRecVenc:Integer): Real;
// pDBName:   DatabaseName
// pPortador: Código do portador
// vCredDisp: Valor do crédito disponível
// vRecVenc:  Valor a receber vencido
// nRecVenc:  Qtd de titulos a receber vencidos
// Result:    Saldo entre Pagar & Receber
var Qtds: array[1..2,1..5] of Integer;          // 1-Pagar 2-Receber  | 1-Vencidos 2-Vencer 3-Total 4-Quitado 5-Cancelados
    Vlrs: array[1..2,1..5] of Real;             //
    DiasAtr: array[1..2,1..2] of Integer;       //                    | 1-Aberto   2-Quitados  (Somatório dos dias de atraso)
    Atraso: array[1..2,1..2] of Integer;        //                    | 1-Aberto   2-Quitados  (Quantidade de titulos)
    MaiorAtraso: array[1..2,1..2] of Integer;   // Maior atraso ocorrido (1-Pagar  2-Receber)  |  1-Aberto  2-Quitados
    i,j,ipr,nDias: Integer;
    dtCompar: TDateTime;
    wVlrDiv,wVlrPg: Real;
    dtVenctoCalc: TDateTime;
begin
  filTitCancel := True;   // Considera titulos cancelados
  vCredDisp    := 0;      // Credito disponível
  vRecVenc     := 0;      // Valor a receber vencido
  nRecVenc     := 0;      // Titulos vencidos
  wPortador    := pPortador;
  FuCadVerif   := TFuCadVerif.Create(nil);
  with FuCadVerif
  do begin
    CadFSit.DatabaseName  := pDBName;
    CadFSit.Active        := True;
    CadPess.DatabaseName  := pDBName;
    CadPess.Active        := True;
    Titulos.DatabaseName  := pDBName;
    Titulos.IndexName     := 'PNroParc';
    Titulos.Filtered      := True;
    Titulos.Active        := True;
    for i := 1 to 2
    do begin
      for j := 1 to 5
      do begin
        Qtds[i,j] := 0;
        Vlrs[i,j] := 0;
      end;
      for j := 1 to 2
      do begin
        DiasAtr[i,j]     := 0;
        Atraso[i,j]      := 0;
        MaiorAtraso[i,j] := 0;
      end;
    end;
    dtCompar := DateOf(Date);
    //
    // Portador, PagRec, Situação: Filtro de titulos
    Titulos.First;
    Titulos.Refresh;
    while not Titulos.Eof
    do begin
      ipr := StrToInt(TitulosPagRec.AsString);      // Pagar/receber
      case TitulosSituacao.AsInteger of
        0,1:begin                // 0-Aberto    1-Parcialmente quitado
            wVlrPg       := (TitulosPgtCapital.AsFloat + TitulosPgtJuros.AsFloat) - TitulosPgtDesc.AsFloat;
            dtVenctoCalc := DateOf(TitulosDtVencto.AsDateTime);
            if TitulosTpDoc.AsInteger = FuIniGeral.wInicial.DocCrediar
               then dtVenctoCalc := dtVenctoCalc + FuIniGeral.wInicial.DiasIsencao;
            wVlrDiv := CalculaValorAtual(TitulosValor.AsFloat,
                                         TitulosVlDesc.AsFloat,
                                         TitulosPcJur.AsFloat,
                                         TitulosMultaVlr.AsFloat,
                                         wVlrPg,
                                         TitulosTpJur.AsInteger,
                                         dtVenctoCalc,
                                         TitulosDtDesc.AsDateTime,
                                         dtCompar);
            if DateOf(TitulosDtVencto.AsDateTime) < dtCompar
            then begin             // Titulos vencidos
              nDias := DaysBetween(dtCompar,TitulosDtVencto.AsDateTime);
              if nDias > MaiorAtraso[ipr,1]
                 then MaiorAtraso[ipr,1] := nDias;
              DiasAtr[ipr,1] := DiasAtr[ipr,1] + nDias;                                       // Somatório dos dias de atraso (titulos em aberto)
              Atraso[ipr,1]  := Atraso[ipr,1] + 1;                                            // Quantidade de titulos em atraso (titulos em aberto)
              Qtds[ipr,1]    := Qtds[ipr,1] + 1;           // Titulos vencidos
              Vlrs[ipr,1]    := Vlrs[ipr,1] + wVlrDiv;     // Valor vencido
            end
            else begin         // Titulos a vencer
              Qtds[ipr,2]  := Qtds[ipr,2] + 1;           // Titulos a vencer
              Vlrs[ipr,2]  := Vlrs[ipr,2] + wVlrDiv;     // Valor a vencer
            end;
            Qtds[ipr,3]  := Qtds[ipr,3] + 1;             // Titulos pendentes (Vencidos + Vencer)
            Vlrs[ipr,3]  := Vlrs[ipr,3] + wVlrDiv;       // Total pendente
          end;   // end 0,1
        2:begin              // Quitado
            wVlrPg := (TitulosPgtCapital.AsFloat + TitulosPgtJuros.AsFloat) - TitulosPgtDesc.AsFloat;
            Qtds[ipr,4] := Qtds[ipr,4] + 1;              // Titulos pagos
            Vlrs[ipr,4] := Vlrs[ipr,4] + wVlrPg;         // Total pago
            if CompareDate(TitulosPgtData.AsDateTime,TitulosDtVencto.AsDateTime) > 0
            then begin         // Pago com atraso
              nDias := DaysBetween(TitulosPgtData.AsDateTime,TitulosDtVencto.AsDateTime);
              if nDias > MaiorAtraso[ipr,2]
                 then MaiorAtraso[ipr,2] := nDias;       // Maior atraso em pagamentos
              Atraso[ipr,2]  := Atraso[ipr,2] + 1;       // Qtd de atrasos em pagamentos
              DiasAtr[ipr,2] := DiasAtr[ipr,2] + nDias;  // Somatorio dos dias de atraso em pagamentos
            end;
          end;        // End quitados
        else begin    // Cancelados
          Qtds[ipr,5]  := Qtds[ipr,5] + 1;
          Vlrs[ipr,5]  := Vlrs[ipr,5] + TitulosValor.AsFloat;
        end;
      end;
      Titulos.Next;
    end;
    Titulos.Active  := False;
    //
    if not CadFSit.FindKey([wPortador])
    then begin
      CadFSit.Append;
      CadFSitCodigo.AsInteger    := wPortador;
    end
    else CadFSit.Edit;
    CadFSitDtHrCalc.AsDateTime       := now;
    CadFSitCPagVencVlr.AsCurrency    := Vlrs[1,1];         // A pagar - Vencido - valor
    CadFSitCPagVencTits.AsInteger    := Qtds[1,1];         //                   - titulos
    CadFSitCPagAVenVlr.AsCurrency    := Vlrs[1,2];         //         - A Vencer - valor
    CadFSitCPagAVenTits.AsInteger    := Qtds[1,2];         //                    - titulos
    CadFSitCPagVlrTotal.AsCurrency   := Vlrs[1,3];         //         - Total em aberto - valor
    CadFSitCPagQtTotal.AsInteger     := Qtds[1,3];         //                           - titulos
    CadFSitCPagVlrQuit.AsCurrency    := Vlrs[1,4];         //         - Valor quitado
    CadFSitCPagTtQuit.AsInteger      := Qtds[1,4];         //         - Titulos quitados
    CadFSitCPagDiasAtraso.AsInteger  := DiasAtr[1,2];      //         - Dias de atraso (Soma dos dias)
    CadFSitCPagMaiorAtraso.AsInteger := MaiorAtraso[1,2];  //         - Maior atraso ocorrido
    CadFSitCPagTotAtraso.AsInteger   := Atraso[1,2];       //         - Pagamentos efetuados com atraso

    CadFSitCRecVencVlr.AsCurrency    := Vlrs[2,1];         // A receber - Vencido - valor
    CadFSitCRecVencTits.AsInteger    := Qtds[2,1];         //                     - titulos
    CadFSitCRecAVenVlr.AsCurrency    := Vlrs[2,2];         //           - A Vencer - valor
    CadFSitCRecAVenTits.AsInteger    := Qtds[2,2];         //                      - titulos
    CadFSitCRecVlrTotal.AsCurrency   := Vlrs[2,3];         //           - Total em aberto - valor
    CadFSitCRecQtTotal.AsInteger     := Qtds[2,3];         //                             - titulos
    CadFSitCRecVlrQuit.AsCurrency    := Vlrs[2,4];         //           - Valor quitado
    CadFSitCRecTtQuit.AsInteger      := Qtds[2,4];         //           - Titulos quitados
    CadFSitCRecDiasAtraso.AsInteger  := DiasAtr[2,2];      //           - Dias de atraso (Soma dos dias)  (nos pagtos)
    CadFSitCRecMaiorAtraso.AsInteger := MaiorAtraso[2,2];  //           - Maior atraso ocorrido
    CadFSitCRecTotAtraso.AsInteger   := Atraso[2,2];       //           - Pagamentos com atraso

    CadFSitSaldo.AsCurrency := Vlrs[2,3] - Vlrs[1,3];      // Saldo (Total a receber - Total a pagar)
    CadFSit.Post;

    //
    if not CadPess.FindKey([wPortador])
    then begin
      CadPess.Append;
      CadPessCodigo.AsInteger      := wPortador;
      CadPessCredLimite.AsCurrency := 0;
    end
    else CadPess.Edit;
    CadPessCredUtilizado.AsCurrency := Vlrs[2,3];
    CadPess.Post;
    //
    vCredDisp  := CadPessCredLimite.AsCurrency - CadPessCredUtilizado.AsCurrency;
    vRecVenc   := CadFSitCRecVencVlr.AsCurrency;
    nRecVenc   := CadFSitCRecVencTits.AsInteger;
    //
    CadPess.Active := False;
    CadFSit.Active := False;
    Titulos.Active := False;
  end;
  Result := Vlrs[2,3] - Vlrs[1,3];   // Saldo (Total a receber - Total a pagar)
  FuCadVerif.Free;

end;



procedure TFuCadVerif.FormActivate(Sender: TObject);
var i: Integer;
    wInfo: String;
begin
  filTitCancel  := False;       // Não considera titulos cancelados
  Memo1.Lines.Clear;
  Memo1.Lines.Add('Verificação do cadastro');
  VCadas.Active := True;
  Gau1.Progress := 0;
  Gau1.MaxValue := VCadas.RecordCount;
  for i := 1 to Length(TbName)
  do begin
    VDep.TableName  := TbName[i];
    wUsar[i]        := True;
    Try
      VDep.Active   := True;
      Gau1.MaxValue := Gau1.MaxValue + VDep.RecordCount;
      wInfo         := IntToStr(VDep.RecordCount) + ' registros';
    Except
      wUsar[i]      := False;
      wInfo         := 'Inexistente ou inválido (' + VDep.DatabaseName + ')';
    End;
    VDep.Active     := False;
    Memo1.Lines.Add(TbName[i] + '...' + wInfo);
  end;
  LabTotal.Caption   := IntToStr(Gau1.MaxValue);
  btProcesso.Enabled := True;
  btCancel.Enabled   := False;
  Memo1.Lines.Add(' ');

end;

procedure TFuCadVerif.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  VCadas.Active      := False;
  VDep.Active        := False;
  LabProcess.Visible := False;
  LabMax.Visible     := False;
  Gau2.Visible       := False;
  Timer1.Enabled     := False;

end;

procedure TFuCadVerif.btSairClick(Sender: TObject);
begin
  FuCadVerif.Close;

end;

procedure TFuCadVerif.btProcessoClick(Sender: TObject);
var i,j,NDel: Integer;
    Texto: String;
    lProx: Boolean;
begin
  btCancel.Enabled   := True;
  btSair.Enabled     := False;
  btProcesso.Enabled := False;
  lCancel            := False;
  LabProcess.Caption := '';
  LabProcess.Visible := True;
  LabMax.Caption     := '';
  LabMax.Visible     := True;
  Gau2.Visible       := True;
  VCadas.First;
  Gau2.Progress      := 0;
  Gau2.MaxValue      := VCadas.RecordCount;
  // Exclue registros sem razão social
  while not VCadas.Eof
  do begin
    Gau1.Progress := Gau1.Progress + 1;
    Gau2.Progress := Gau2.Progress + 1;
    if Length(Trim(VCadasRzSocial.AsString)) > 0 then VCadas.Next
                                                 else VCadas.Delete;
  end;
  //
  for i := 1 to Length(TbName)
  do begin
    if wUsar[i]
    then begin
      VDep.TableName     := TbName[i];
      VDep.Active        := True;
      NDel               := 0;
      LabProcess.Caption := VDep.TableName;
      LabMax.Caption     := IntToStr(VDep.RecordCount);
      Gau2.Progress      := 0;
      Gau2.MaxValue      := VDep.RecordCount;
      Application.ProcessMessages;
      Texto              := VDep.TableName + ': ' + IntToStr(VDep.RecordCount) + ' registros';
      VDep.First;
      while (not VDep.Eof) and (not lCancel)
      do begin
        lProx := True;
        if not VCadas.FindKey([VDepCodigo.AsInteger])
        then begin
          NDel := NDel + 1;
          VDep.Delete;
          lProx := False;
        end;
        if lProx
           then VDep.Next;
        Gau1.Progress := Gau1.Progress + 1;
        Gau2.Progress := Gau2.Progress + 1;
      end;
      if NDel > 0 then Texto := Texto + '  -  ' + IntToStr(NDel) + ' excluidos';
      if not lCancel then Memo1.Lines.Add(Texto);
      VDep.Active := False;
    end;
    if lCancel
    then for j := i to Length(TbName)
         do wUsar[j] := False;
  end;
  if not lCancel
     then Memo1.Lines.Add('Processo finalizado');
  btCancel.Enabled := False;
  btSair.Enabled   := True;
  btSair.SetFocus;

end;

procedure TFuCadVerif.btCancelClick(Sender: TObject);
begin
  lCancel := True;
  Memo1.Lines.Add('Processo interrompido pelo usuário');

end;

procedure TFuCadVerif.btSairEnter(Sender: TObject);
begin
  btSair.Caption := '&Sair (5)';
  Timer1.Enabled := True;

end;

procedure TFuCadVerif.Timer1Timer(Sender: TObject);
begin
  btSair.Caption := '&Sair (' + IntToStr(wTempo) + ')';
  wTempo := wTempo - 1;
  if wTempo < -1 then FuCadVerif.Close;

end;

procedure TFuCadVerif.FormCreate(Sender: TObject);
begin
  wTempo := 4;

end;

procedure TFuCadVerif.TitulosFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept := False;
  if TitulosPortador.AsInteger <> wPortador                               // Não é do portador
     then Exit;
  if (TitulosPagRec.AsString <> '1') and (TitulosPagRec.AsString <> '2')  // Não é pagar nem receber
     then Exit;
  if not filTitCancel
  then if TitulosSituacao.AsInteger > 2                                   // Titulos CANCELADO
       then Exit;
  Accept := True;

end;

end.
