unit uCancelaOSRelac;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, DBCtrls, Buttons, ExtCtrls;
  Procedure CancelamentoOSRelacionada(pNrOperacao:Integer;    // Nro da operação
                                      pNrNF:Integer;          // Nr. Nota Fiscal
                                      pModDFe:Integer;        // Modelo de documento
                                      pOSOrig:Integer;        // OS de origem da NFe
                                      pCodClie:Integer;       // Código do cliente
                                      pRzSoc:String);         // Identificação do cliente

type
  TFuCancelaOSRelac = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabDFe: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LabIntegrada: TLabel;
    Panel2: TPanel;
    btCancelarOS: TBitBtn;
    LabInstr: TLabel;
    LabPgma: TLabel;
    btSair: TBitBtn;
    LabNrOperacao: TLabel;
    LabCliente: TLabel;
    LabNrOS: TLabel;
    OSAC: TTable;
    OSIE: TTable;
    OSACNro: TIntegerField;
    OSACEmpresa: TSmallintField;
    OSACSit: TSmallintField;
    OSIENro: TIntegerField;
    OSIEEmpresa: TSmallintField;
    OSIESit: TSmallintField;
    OSACCliente: TIntegerField;
    OSIECli_Cod: TIntegerField;
    OSACVendaNr: TIntegerField;
    OSACServVendaNr: TIntegerField;
    OSIEServVendaNr: TIntegerField;
    OSIEVendaNr: TIntegerField;
    OSACObserv: TMemoField;
    OSIEDescrObs: TMemoField;
    procedure LabInstrClick(Sender: TObject);
    procedure btCancelarOSClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuCancelaOSRelac: TFuCancelaOSRelac;
  nrOS,codCliente,nrOper: Integer;

implementation

uses uIniGeral;

{$R *.dfm}

Procedure CancelamentoOSRelacionada(pNrOperacao:Integer;    // Nro da operação
                                    pNrNF:Integer;          // Nr. Nota Fiscal
                                    pModDFe:Integer;        // Modelo de documento
                                    pOSOrig:Integer;        // OS de origem da NFe
                                    pCodClie:Integer;       // Código do cliente
                                    pRzSoc:String);         // Identificação do cliente
begin
  if not FuIniGeral.wInicial.IntegVendOS
     then Exit;                             // Não tem interação de vendas X OS
  if pOSOrig = 0
     then Exit;                             // Nr. da OS não informado

  FuCancelaOSRelac  := TFuCancelaOSRelac.Create(nil);
  with FuCancelaOSRelac
  do begin
    LabNrOperacao.Caption     := IntToStr(pNrOperacao);
    LabCliente.Caption        := pRzSoc + '  (' + IntToStr(pCodClie) + ')';
    case pModDFe of
      10,11,97:LabDFe.Caption := 'DI';
      55:LabDFe.Caption       := 'NFe';
      65:LabDFe.Caption       := 'NFCe';
      98:LabDFe.Caption       := 'NFSe';
      else LabDFe.Caption     := 'Indef';
    end;
    LabDFe.Caption            := 'Nr: ' + IntToStr(pNrNF) + ' (' + LabDFe.Caption + ')';
    LabNrOS.Caption           := IntToStr(pOSOrig);
    LabIntegrada.Caption      := FuIniGeral.wInicial.OpES_PgmOS;
    if Length(Trim(FuIniGeral.wInicial.OpES_PgmOS)) > 0
    then begin
      btCancelarOS.Enabled := True;
      LabPgma.Caption      := FuIniGeral.wInicial.OpES_PgmOS;
      LabInstr.Visible     := False;
      btSair.Caption       := '&Sair (sem cancelar a OS)';
    end
    else begin
      btCancelarOS.Enabled := False;
      LabPgma.Caption      := '';
      LabInstr.Visible     := True;
      btSair.Caption       := '&Sair';
    end;
    nrOS        := pOSOrig;
    codCliente  := pCodClie;
    nrOper      := pNrOperacao;
    FuCancelaOSRelac.ShowModal;
  end;
  FuCancelaOSRelac.Free;

end;


Procedure TrataATecnica;
var xOS: String;
    xMsg: String;
begin
  with FuCancelaOSRelac
  do begin
    OSAC.DatabaseName  := FuIniGeral.wInicial.DatabaseName;
    OSIE.DatabaseName  := FuIniGeral.wInicial.DatabaseName;
    xOS                := '';
    xMsg               := '';
    // Verifica que tipo de OS (AC ou IE)
    OSAC.Active := True;
    if OSAC.FindKey([nrOS])
    then begin
      xOS := 'AC';
      if OSACCliente.AsInteger <> codCliente
         then xMsg := xMsg + 'Cliente  Inf: ' + IntToStr(codCliente) + '  OS: ' + OSACCliente.AsString + #13;
      if (nrOper <> OSACVendaNr.AsInteger) and (nrOper <> OSACServVendaNr.AsInteger)
         then xMsg := xMsg + 'Nr.Operacao  Inf: ' + IntToStr(nrOper) +
                             '  OS Venda: ' + OSACVendaNr.AsString + '  Serv: ' + OSACServVendaNr.AsString + #13;
    end
    else begin
      OSIE.Active := True;
      if OSIE.FindKey([nrOS])
      then begin
        xOS := 'IE';
        if OSIECli_Cod.AsInteger <> codCliente
           then xMsg := xMsg + 'Cliente  Inf: ' + IntToStr(codCliente) + '  OS: ' + OSIECli_Cod.AsString + #13;
        if (nrOper <> OSIEVendaNr.AsInteger) and (nrOper <> OSIEServVendaNr.AsInteger)
           then xMsg := xMsg + 'Nr.Operacao  Inf: ' + IntToStr(nrOper) +
                               '  OS Venda: ' + OSIEVendaNr.AsString + '  Serv: ' + OSIEServVendaNr.AsString + #13;
      end;
    end;
    if Length(Trim(xOS)) = 0
       then xMsg := xMsg + 'OS ' + IntToStr(nrOS) + ' não encontrada';

    if Length(Trim(xMsg)) > 0
    then begin
      if Length(Trim(xOS)) > 0
         then xMsg := 'OS encontrada não corresponde à operação de venda' + #13#13 + xMsg;
      MessageDlg(xMsg,mtError,[mbOk],0);
    end
    else begin
      if xOS = 'AC'
      then begin
        OSAC.Edit;
        OSACSit.AsInteger   := 8;
        OSACObserv.AsString := OSACObserv.AsString + '  <Cancelada:' + DateTimeToStr(Now) + '>';
        OSAC.Post;
      end
      else begin   // IE
        OSIE.Edit;
        OSIESit.AsInteger     := OSIESit.AsInteger + 8;
        OSIEDescrObs.AsString := OSIEDescrObs.AsString + '  <Cancelada:' + DateTimeToStr(Now) + '>';
        OSIE.Post;
      end;
    end;
    OSAC.Active := False;
    OSIE.Active := False;
  end;

end;


procedure TFuCancelaOSRelac.LabInstrClick(Sender: TObject);
begin
  ShowMessage('Utilize o programa de tratativas de Ordens de Serviço');

end;

procedure TFuCancelaOSRelac.btCancelarOSClick(Sender: TObject);
var nrPgmOS: Integer;
begin
  nrPgmOS := 0;
  if Pos('ATecnica',FuIniGeral.wInicial.OpES_PgmOS) > 0
  then nrPgmOS := 1
  else if Pos('OSLoja',FuIniGeral.wInicial.OpES_PgmOS) > 0
       then nrPgmOS := 2
       else if Pos('Mecanico',FuIniGeral.wInicial.OpES_PgmOS) > 0
            then nrPgmOS := 3;
  //
  case nrPgmOS of
    1:TrataATecnica;
    //2:TrataOSLoja;
    //3:TrataMecanico;
    else ShowMessage('Utilize o pgma ' + FuIniGeral.wInicial.OpES_PgmOS + ' para cancelar a OS' + #13#13 +
                     'Procedimento a ser disponibilizado' + #13 +
                     'Obrigado');
  end;
  FuCancelaOSRelac.Close;

end;

procedure TFuCancelaOSRelac.btSairClick(Sender: TObject);
begin
  FuCancelaOSRelac.Close;
  
end;

end.
