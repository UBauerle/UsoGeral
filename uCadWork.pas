unit uCadWork;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Gauges, ExtCtrls, Dateutils, DBCtrls,
  ComCtrls;
  Procedure CodigoPais;
  Procedure RetiraIndicacaoICMSST;
  Function  CalculaSaldoPortador(pPortador:Integer;pGrava:Boolean): Real;
  Procedure CalculoGeralSaldos;
  Procedure CorrigeTelefones;
  Procedure RetiraEdicaoInscrEstadual;
  Procedure AssinalaEnquadramentoFiscal;
  Procedure AjustaTipoContribuinte;
  Procedure VerificaCodigosIBGE;
  Procedure AjustaIndicadores(pmtInfAdic,pmtBalcao,pmtRelCods,pmtOrdProds:Integer;pmtRefCom,pmtObserv,pmtSemIE,pmtComIE:Boolean);

type
  TFCadWork = class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    Gauge1: TGauge;
    Label1: TLabel;
    BtOk: TBitBtn;
    LabConta: TLabel;
    btInterrupt: TBitBtn;
    Memo1: TMemo;
    DbRichTextRefCom: TDBRichEdit;
    DbRichTextObserv: TDBRichEdit;
    DbMemoRefCom: TDBMemo;
    DbMemoObserv: TDBMemo;
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtOkClick(Sender: TObject);
    procedure btInterruptClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCadWork: TFCadWork;
  Tempo,wOper: Integer;
  wInterrupt: Boolean;
  lAdic,lVend,lRelProd: Boolean;
  nOrdProd: Integer;
  lProcInfAdic,lProcBalcao,lProcRelProd,lProcOrdProd: Boolean;
  lProcRefCom,lProcObserv,lProcSemIE,lProcComIE: Boolean;
  wMsg: TStringList;
  arqMsg: String;

implementation

uses CadPrinc, DMGeral, uGenericas, uIniGeral, uDdSISV, uMensagem;

{$R *.dfm}

procedure CodigoPais;
begin
  wOper    := 1;
  FCadWork := TFCadWork.Create(nil);
  FCadWork.ShowModal;
  FCadWork.Release;

end;

procedure RetiraIndicacaoICMSST;
begin
  wOper    := 2;
  FCadWork := TFCadWork.Create(nil);
  FCadWork.ShowModal;
  FCadWork.Release;

end;

procedure CalculoGeralSaldos;
var wExec: Boolean;
begin
  wOper := 3;
  wExec := True;
  DMG.CadFSit.Active := False;
  Try
    DMG.CadFSit.EmptyTable;
  Except
    wExec := False;
    MessageDlg('Cadastro de situação financeira em uso por outro usuário' + #13#13 +
               'Cálculo de saldos não pode ser executado agora, tente mais tarde',mtWarning,[mbOk],0);
  End;
  DMG.CadFSit.Active := True;
  if not wExec then Exit;
  FCadWork := TFCadWork.Create(nil);
  FCadWork.ShowModal;
  FCadWork.Release;

end;

Procedure CorrigeTelefones;
begin
  wOper    := 4;
  FCadWork := TFCadWork.Create(nil);
  FCadWork.ShowModal;
  FCadWork.Release;

end;

Procedure RetiraEdicaoInscrEstadual;
begin
  wOper    := 5;
  FCadWork := TFCadWork.Create(nil);
  FCadWork.ShowModal;
  FCadWork.Release;

end;

Procedure AssinalaEnquadramentoFiscal;
begin
  wOper    := 6;
  FCadWork := TFCadWork.Create(nil);
  FCadWork.ShowModal;
  FCadWork.Release;

end;

Procedure AjustaTipoContribuinte;
begin
  wOper    := 7;
  FCadWork := TFCadWork.Create(nil);
  FCadWork.ShowModal;
  FCadWork.Release;

end;

Procedure VerificaCodigosIBGE;
begin
  wOper    := 8;
  FCadWork := TFCadWork.Create(nil);
  FCadWork.ShowModal;
  FCadWork.Release;

end;


Procedure AjustaIndicadores(pmtInfAdic,pmtBalcao,pmtRelCods,pmtOrdProds:Integer;pmtRefCom,pmtObserv,pmtSemIE,pmtComIE:Boolean);
begin
  wOper        := 9;
  lProcInfAdic := True;
  lProcBalcao  := True;
  lProcRelProd := True;
  lProcOrdProd := True;
  case pmtInfAdic of
    0:lAdic := True;
    1:lAdic := False;
    else lProcInfAdic := False;
  end;
  case pmtBalcao of
    0:lVend := True;
    1:lVend := False;
    else lProcBalcao := False;
  end;
  case pmtRelCods of
    0:lRelProd := True;
    1:lRelProd := False;
    else lProcRelProd := False;
  end;
  nOrdProd := pmtOrdProds;
  if nOrdProd = 3
     then lProcOrdProd := False;
  lProcRefCom  := pmtRefCom;
  lProcObserv  := pmtObserv;
  lProcSemIE   := pmtSemIE;
  lProcComIE   := pmtComIE;
  FCadWork := TFCadWork.Create(nil);
  FCadWork.ShowModal;
  FCadWork.Release;

end;


Procedure RetiraFormatacaoMemos;
begin
  wOper    := 10;
  FCadWork := TFCadWork.Create(nil);
  FCadWork.ShowModal;
  FCadWork.Release;

end;



Function CalculaSaldoPortador(pPortador:Integer;pGrava:Boolean): Real;
var Qtds: array[1..2,1..4] of Integer;     // 1-Pagar 2-Receber  | 1-Vencido 2-Vencer 3-Total 4-Quitado
    Vlrs: array[1..2,1..4] of Real;
    DiasAtr: array[1..2] of Integer;       // Total de dias atrasados
    Atraso: array[1..2] of Integer;        // Titulos em atraso ou quitados com atraso
    MaiorAtraso: array[1..2] of Integer;   // Maior atraso ocorrido
    i,j,ipr,nDias,nOcorr: Integer;
    dtCompar: TDateTime;
    wVlrDiv,wVlrPg: Real;
    idxAnt: String;
    stAnt,filAnt: Boolean;

begin
  for i := 1 to 2
  do begin
    DiasAtr[i]     := 0;
    Atraso[i]      := 0;
    MaiorAtraso[i] := 0;
    for j := 1 to 4
    do begin
      Qtds[i,j] := 0;
      Vlrs[i,j] := 0;
    end;
  end;
  dtCompar := DateOf(Date);
  with DMG
  do begin
    stAnt    := Titulos.Active;
    if not stAnt
       then Titulos.Active := True;
    idxAnt   := Titulos.IndexName;
    DMG.Titulos.IndexName := 'PNroParc';
    filAnt   := Titulos.Filtered;
    DMG.Titulos.Filtered  := False;
    //
    Titulos.First;
    nOcorr := 0;
    Titulos.FindNearest([CadastroCodigo.AsInteger,0,'',0]);
    while (TitulosPortador.AsInteger = CadastroCodigo.AsInteger) and (not Titulos.Eof)
    do begin
      nOcorr := nOcorr + 1;
      ipr    := StrToIntDef(TitulosPagRec.AsString,0);
      if ((ipr = 1) or (ipr = 2)) and (TitulosSituacao.AsInteger < 3)
      then begin     // Só considera se for válido (1-Pg/2-Rc) e não cancelados
        if TitulosSituacao.AsInteger < 2
        then begin            // em Aberto
          wVlrPg  := (TitulosPgtCapital.AsFloat + TitulosPgtJuros.AsFloat) - TitulosPgtDesc.AsFloat;
          wVlrDiv := CalculaValorAtual(TitulosValor.AsFloat,
                                       TitulosVlDesc.AsFloat,
                                       TitulosPcJur.AsFloat,
                                       TitulosMultaVlr.AsFloat,
                                       wVlrPg,
                                       TitulosTpJur.AsInteger,
                                       TitulosDtVencto.AsDateTime,
                                       TitulosDtDesc.AsDateTime,
                                       dtCompar);
          if DateOf(TitulosDtVencto.AsDateTime) < dtCompar
          then begin             // Titulos vencidos
            nDias := DaysBetween(dtCompar,TitulosDtVencto.AsDateTime);
            if nDias > MaiorAtraso[ipr]
               then MaiorAtraso[ipr] := nDias;
            DiasAtr[ipr] := DiasAtr[ipr] + nDias;                                       // Dias de atraso
            Qtds[ipr,1]  := Qtds[ipr,1] + 1;    Vlrs[ipr,1] := Vlrs[ipr,1] + wVlrDiv;    // Vencido
            Qtds[ipr,3]  := Qtds[ipr,3] + 1;    Vlrs[ipr,3] := Vlrs[ipr,3] + wVlrDiv;    // Total pendente
            Atraso[ipr]  := Atraso[ipr] + 1;                                             // Titulos com atraso
          end
          else begin             // Titulos a vencer
            Qtds[ipr,2]  := Qtds[ipr,2] + 1;    Vlrs[ipr,2] := Vlrs[ipr,2] + wVlrDiv;    // A vencer
            Qtds[ipr,3]  := Qtds[ipr,3] + 1;    Vlrs[ipr,3] := Vlrs[ipr,3] + wVlrDiv;    // Total pendente
          end;
        end
        else begin           // Quitado
          wVlrPg := (TitulosPgtCapital.AsFloat + TitulosPgtJuros.AsFloat) - TitulosPgtDesc.AsFloat;
          Qtds[ipr,4] := Qtds[ipr,4] + 1;    Vlrs[ipr,4] := Vlrs[ipr,4] + wVlrPg;    // Total pago/quitado
          if CompareDate(TitulosPgtData.AsDateTime,TitulosDtVencto.AsDateTime) > 0
          then begin       // Pago com atraso
            nDias := DaysBetween(TitulosPgtData.AsDateTime,TitulosDtVencto.AsDateTime);
            if nDias > MaiorAtraso[ipr] then MaiorAtraso[ipr] := nDias;
            Atraso[ipr]  := Atraso[ipr] + 1;
            DiasAtr[ipr] := DiasAtr[ipr] + nDias;
          end;
        end;
      end;      // ipr = 1 ou 2
      Titulos.Next;
    end;
    Titulos.Filtered  := filAnt;
    Titulos.IndexName := idxAnt;
    Titulos.Active    := stAnt;

    if (nOcorr > 0) or pGrava
    then begin
      CadFSit.Refresh;
      if CadFSit.RecordCount > 0 then CadFSit.Delete;
      CadFSit.Append;
      CadFSitCodigo.AsInteger          := pPortador;
      CadFSitDtHrCalc.AsDateTime       := now;
      CadFSitCPagVencVlr.AsCurrency    := Vlrs[1,1];         // A pagar - Vencido - valor
      CadFSitCPagVencTits.AsInteger    := Qtds[1,1];         //                   - titulos
      CadFSitCPagAVenVlr.AsCurrency    := Vlrs[1,2];         //         - A Vencer - valor
      CadFSitCPagAVenTits.AsInteger    := Qtds[1,2];         //                    - titulos
      CadFSitCPagVlrTotal.AsCurrency   := Vlrs[1,3];         //         - Total em aberto - valor
      CadFSitCPagQtTotal.AsInteger     := Qtds[1,3];         //                           - titulos
      CadFSitCPagVlrQuit.AsCurrency    := Vlrs[1,4];         //         - Valor quitado
      CadFSitCPagTtQuit.AsInteger      := Qtds[1,4];         //         - Titulos quitados
      CadFSitCPagDiasAtraso.AsInteger  := DiasAtr[1];        //         - Dias de atraso (Soma dos dias)
      CadFSitCPagMaiorAtraso.AsInteger := MaiorAtraso[1];    //         - Maior atraso ocorrido
      CadFSitCPagTotAtraso.AsInteger   := Atraso[1];         //         - Pagamentos efetuados com atraso

      CadFSitCRecVencVlr.AsCurrency    := Vlrs[2,1];         // A receber - Vencido - valor
      CadFSitCRecVencTits.AsInteger    := Qtds[2,1];         //                     - titulos
      CadFSitCRecAVenVlr.AsCurrency    := Vlrs[2,2];         //           - A Vencer - valor
      CadFSitCRecAVenTits.AsInteger    := Qtds[2,2];         //                      - titulos
      CadFSitCRecVlrTotal.AsCurrency   := Vlrs[2,3];         //           - Total em aberto - valor
      CadFSitCRecQtTotal.AsInteger     := Qtds[2,3];         //                             - titulos
      CadFSitCRecVlrQuit.AsCurrency    := Vlrs[2,4];         //           - Valor quitado
      CadFSitCRecTtQuit.AsInteger      := Qtds[2,4];         //           - Titulos quitados
      CadFSitCRecDiasAtraso.AsInteger  := DiasAtr[2];        //           - Dias de atraso (Soma dos dias)
      CadFSitCRecMaiorAtraso.AsInteger := MaiorAtraso[2];    //           - Maior atraso ocorrido
      CadFSitCRecTotAtraso.AsInteger   := Atraso[2];         //           - Pagamentos com atraso

      CadFSitSaldo.AsCurrency := Vlrs[2,3] - Vlrs[1,3];      // Saldo (Total a receber - Total a pagar)
      CadFSit.Post;

      //
      CadPess.Refresh;
      if CadPess.RecordCount = 0
      then begin
        CadPess.Append;
        CadPessCodigo.AsInteger      := pPortador;
        CadPessCredLimite.AsCurrency := 0;
        CadPess.Post;
      end;
      CadPess.Edit;
      CadPessCredUtilizado.AsCurrency := Vlrs[2,3];
      CadPess.Post;
      
    end;
  end;
  Result := Vlrs[2,3] - Vlrs[1,3];   // Saldo (Total a receber - Total a pagar)

end;


procedure TFCadWork.FormActivate(Sender: TObject);
var fAnt,fTitAnt,sTit,lVis: Boolean;
    titIdx: String;
    xAux,xDDD,xFone1,xFone2,xFixo: String;
    i: Integer;
    wMod: Integer;
    munIdx: String;
    munSta: Boolean;
begin
  FCadWork.Left       := FCadPrinc.Left + 20;
  FCadWork.Width      := FCadPrinc.Width - 40;
  FCadWork.Top        := FCadPrinc.Top + 100;
  FCadWork.Height     := 126;
  BtOk.Visible        := False;
  wInterrupt          := False;
  btInterrupt.Left    := btOk.Left;
  btInterrupt.Top     := btOk.Top;
  btInterrupt.Visible := True;
  LabConta.Caption    := '';
  wMsg                := TStringList.Create;
  arqMsg              := FuIniGeral.wInicial.PathLocal + 'ValCadastro.Txt';
  lVis                := False;
  wMsg.Add(stringCompleta('Codigo','D',' ',8) +
           stringCompleta('Inscr.Estadual(UF)','D',' ',22) +
           stringCompleta('CNPJ/CPF','D',' ',22) + 'Razão Social');
  case wOper of
    1:Caption := 'Atualizar código de país';
    2:Caption := 'Retira indicação de ICMS ST';
    3:begin
        Caption := 'Calculando saldos de clientes e fornecedores';
        titIdx  := DMG.Titulos.IndexName;
        fTitAnt := DMG.Titulos.Filtered;
        sTit    := DMG.Titulos.Active;
        DMG.Titulos.IndexName := 'PNroParc';
        DMG.Titulos.Filtered  := False;
        DMG.Titulos.Active     := True;
      end;
      4:Caption := 'Verificando edição de telefones';
      5:Caption := 'Retirar edição e valida Inscrição Estadual';
      6:Caption := 'Assinala enquadramento fiscal';
      7:Caption := 'Tipo de Contribuinte';
      8:begin
          Caption := 'Códigos IBGE (UF e Município)';
          munSta  := DMG.Cidades.Active;
          munIdx  := DMG.Cidades.IndexName;
          DMG.Cidades.Active    := True;
          DMG.Cidades.IndexName := 'Alfabetica';
        end;
      9:Caption := 'Ajusta indicadores';
    else Caption := 'Verificação';

  end;
  with DMG
  do begin
    if wOper = 3
    then begin
      fAnt := Cadastro.Filtered;
      Cadastro.Filtered := False;
    end;
    Cadastro.First;
    Gauge1.MaxValue := Cadastro.RecordCount;
    Gauge1.Progress := 0;
    if Cadastro.RecordCount < 500
    then wMod := 1
    else if Cadastro.RecordCount < 1000
         then wMod := 5
         else if Cadastro.RecordCount < 10000
              then wMod := 10
              else if Cadastro.RecordCount < 50000
                   then wMod := 25
                   else wMod := 50;
    xFixo := ' de ' + IntToStr(Cadastro.RecordCount);
    LabConta.Caption := IntToStr(Gauge1.Progress) + xFixo;
    Application.ProcessMessages;
    while not Cadastro.Eof
    do begin
      case wOper of
        1:begin            // Código de país
            if CadastroCodPais.AsInteger = 0
            then Try
                   Cadastro.Edit;
                   CadastroCodPais.AsInteger := 1058;
                   Cadastro.Post;
                 Except
                 End;
          end;
        2:begin           // Indicação de ICMS ST (Crédito)
            //if CadastroCredICMSST.AsBoolean
            //then
                 Try
                   Cadastro.Edit;
                   CadastroCredICMSST.AsBoolean := False;
                   Cadastro.Post;
                 Except
                 End;
          end;
        3:begin
            CalculaSaldoPortador(CadastroCodigo.AsInteger,True);
          end;
        4:begin
            xDDD   := '';
            xAux   := Trim(CadastroCont1DDD.AsString);
            for i  := 1 to Length(xAux)
            do if Pos(xAux[i],'0123456789') > 0
               then xDDD := xDDD + xAux[i];

            xFone1 := CadastroCont1Fone1.AsString;
            AjustaNumeroFone(xFone1);
            xFone2 := CadastroCont1Fone2.AsString;
            AjustaNumeroFone(xFone2);

            if (xDDD <> CadastroCont1DDD.AsString) or
               (xFone1 <> CadastroCont1Fone1.AsString) or
               (xFone2 <> CadastroCont1Fone2.AsString)
            then begin
              if (Length(xFone1) = 0) and (Length(xFone2) > 0)
              then begin
                xFone1 := xFone2;
                xFone2 := '';
              end;
              Try
                Cadastro.Edit;
                CadastroCont1DDD.AsString   := xDDD;
                CadastroCont1Fone1.AsString := xFone1;
                CadastroCont1Fone2.AsString := xFone2;
                Cadastro.Post;
              Except
              End;
            end;
          end;
        5:begin
            xDDD := Trim(CadastroIEst.AsString);
            if (xDDD <> 'ISENTO')
               and (Length(xDDD) > 0)
            then begin
              xAux := Numerico(xDDD);
              if xAux <> xDDD
              then Try
                     Cadastro.Edit;
                     CadastroIEst.AsString := xAux;
                     Cadastro.Post;
                   Except
                   End;
              if not ValidaUF(CadastroIESTUF.AsString)
              then Try
                     Cadastro.Edit;
                     CadastroIESTUF.AsString := AnsiUpperCase(CadastroIESTUF.AsString);
                     Cadastro.Post;
                   Except
                   End;
              if ValidaInscricaoEstadual(CadastroIEST.AsString,CadastroIESTUF.AsString,FuIniGeral.wInicial.ValidarIE) <> 0
              then wMsg.Add(stringCompleta(DMG.CadastroCodigo.AsString,'E',' ',6) + '  ' +
                            stringCompleta(DMG.CadastroIEST.AsString + '(' + DMG.CadastroIESTUF.AsString + ')','D',' ',22) +
                            stringCompleta(EditaCNPJ_CPF(DMG.CadastroCNPJF.AsString),'D',' ',22) +
                            DMG.CadastroRzSocial.AsString);
            end;
          end;
        6:begin
            if CadastroCadClass.AsInteger = 0
            then Try
                   Cadastro.Edit;
                   CadastroCadClass.AsInteger := 1;
                   Cadastro.Post;
                 Except
                 End;
          end;
        7:begin
            if Length(Trim(CadastroTpContrib.AsString)) = 0
            then begin
              if CadastroTPes.AsString <> 'J'
              then begin
                Cadastro.Edit;
                CadastroTpContrib.AsInteger  := 2;
                CadastroIEST.AsString        := '';
                CadastroIESTUF.AsString      := '';
                CadastroISS.AsBoolean        := False;
                CadastroIRRF.AsBoolean       := False;
                CadastroPrvSoc.AsBoolean     := False;
                CadastroContrSoc.AsBoolean   := False;
                CadastroCofins.AsBoolean     := False;
                CadastroPisPasep.AsBoolean   := False;
                CadastroCredICMSST.AsBoolean := False;
                Cadastro.Post;
              end
              else begin
                Cadastro.Edit;
                if Length(Trim(CadastroIEST.AsString)) = 0
                then begin
                  CadastroTpContrib.AsInteger := 2;
                  CadastroIESTUF.AsString     := '';
                end
                else CadastroTpContrib.AsInteger := 0;
                Cadastro.Post;
              end;
            end;
          end;
        8:begin
            xAux := TextoRetiraAcentuacao(DMG.CadastroEntrCidade.AsString);
            if DMG.Cidades.FindKey([xAux,DMG.CadastroEntrUF.AsString])
            then begin
              DMG.Cadastro.Edit;
              DMG.CadastroUFIBGE.AsInteger  := DMG.CidadesUFIBGE.AsInteger;
              DMG.CadastroMunIBGE.AsInteger := DMG.CidadesCodigoIBGE.AsInteger;
              DMG.Cadastro.Post;
            end;
          end;
        9:begin
            DMG.Cadastro.Edit;
            if lProcInfAdic
               then DMG.CadastroInfAdicionais.AsBoolean := lAdic;
            if lProcBalcao
               then DMG.CadastroVendaBalcao.AsBoolean   := lVend;
            if lProcRelProd
               then DMG.CadastroRelProdutos.AsBoolean   := lRelProd;
            if lProcOrdProd
               then DMG.CadastroProdsDANFe.AsInteger    := nOrdProd;
            if lProcRefCom
            then begin
              Memo1.Lines.Clear;
              Memo1.Lines.Add(Trim(DbRichTextRefCom.Text));
              DMG.CadastroRefCom.Clear;
              DbMemoRefCom.Lines.Add(Memo1.Text);
            end;
            if lProcObserv
            then begin
              Memo1.Lines.Clear;
              Memo1.Lines.Add(Trim(DbRichTextObserv.Text));
              DMG.CadastroObserv.Clear;
              DbMemoObserv.Lines.Add(Memo1.Text);
            end;
            if lProcSemIE
            then if Length(Trim(DMG.CadastroIEST.AsString)) = 0
                 then DMG.CadastroTpContrib.AsInteger := 2;
            if lProcComIE
            then if length(Trim(DMG.CadastroIEST.AsString)) > 0
                 then DMG.CadastroTpContrib.AsInteger := 0;
            DMG.Cadastro.Post;
          end;

        else begin
          // Outras opções....
        end;
      end;
      Gauge1.Progress := Gauge1.Progress + 1;
      if (Gauge1.Progress mod wMod) = 0
      then begin
        LabConta.Caption := IntToStr(Gauge1.Progress) + xFixo;
        Application.ProcessMessages;
      end;
      if wInterrupt then Cadastro.Last;
      if not Cadastro.Filtered
         then Cadastro.Next;
      if Gauge1.Progress >= Cadastro.RecordCount
      then begin
        Cadastro.Last;
        Cadastro.Next;
      end;

    end;
    LabConta.Caption := IntToStr(Gauge1.Progress) + xFixo;
    Application.ProcessMessages;
    if wOper = 8
    then begin
      Cidades.IndexName := munIdx;
      Cidades.Active    := munSta;
    end;
    if wOper = 3
    then begin
      Titulos.Active    := sTit;
      Titulos.IndexName := titIdx;
      Titulos.Filtered  := fTitAnt;
      Cadastro.Filtered := fAnt;
    end;
    Cadastro.Refresh;
    Cadastro.First;
  end;
  if wMsg.Count > 1
  then begin
    wMsg.Add('-----------------------------');
    wMsg.Add('    ' + IntToStr(wMsg.Count-2) + ' ocorrencias');
    wMsg.Add('-----------------------------');
    wMsg.SaveToFile(arqMsg);
    lVis := True;
  end;

  if wInterrupt then MessageDlg('Interrompido pelo usuário',mtInformation,[mbOk],0);
  BtInterrupt.Visible := False;
  BtOk.Visible        := True;
  Tempo               := 5;
  Timer1.Enabled      := True;
  if lVis
  then if msgSistema(3,'Ocorrencias',
                       'Ocorrencias salvas em [ ' + arqMsg + ' ]' + #13 +
                       'Visualizar ?',3,2) = 1
       then AtivaBlocoDeNotas(arqMsg);

  BtOk.SetFocus;

end;

procedure TFCadWork.Timer1Timer(Sender: TObject);
begin
  BtOk.Caption := '&Ok (' + IntToStr(Tempo) + 's)';
  Tempo := Tempo - 1;
  if Tempo < 0 then FCadWork.Close;

end;

procedure TFCadWork.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled := False;

end;

procedure TFCadWork.BtOkClick(Sender: TObject);
begin
  FCadWork.Close;

end;

procedure TFCadWork.btInterruptClick(Sender: TObject);
begin
  wInterrupt := True;

end;

end.
