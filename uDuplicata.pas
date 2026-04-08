unit uDuplicata;

interface

uses
  Windows, Db, DBTables, RLReport, Classes, Controls, Forms, SysUtils,
  RLPDFFilter, RLFilters, RLRichFilter, RLPreviewForm, Dialogs;
  Function EmiteDuplicata(pEmpFil,pAcesso:Integer;pMotivo:String;pPreview:Boolean): Integer;


type
  TFuDuplicata = class(TForm)
    Cadas: TTable;
    CadasCodigo: TIntegerField;
    CadasRzSocial: TStringField;
    CadasTPes: TStringField;
    CadasCNPJF: TStringField;
    SCadas: TDataSource;
    Imgs: TTable;
    SImag: TDataSource;
    Tits: TTable;
    STit: TDataSource;
    RLDuplicata: TRLReport;
    RLDetalhe: TRLBand;
    RLTopo: TRLPanel;
    RLDados: TRLPanel;
    RLLogo: TRLDBImage;
    ImgsDupSt: TBooleanField;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLDBText6: TRLDBText;
    RLLinha1: TRLLabel;
    RLLinha2: TRLLabel;
    RLLinha3: TRLLabel;
    TitsAcesso: TIntegerField;
    TitsNro: TIntegerField;
    TitsParc: TStringField;
    TitsPortador: TIntegerField;
    TitsTpDoc: TSmallintField;
    TitsDtEmiss: TDateField;
    TitsMoeda: TSmallintField;
    TitsValor: TCurrencyField;
    TitsDtVencto: TDateField;
    TitsTpJur: TSmallintField;
    TitsPcJur: TBCDField;
    TitsVlJur: TCurrencyField;
    TitsDtDesc: TDateField;
    TitsPcDesc: TBCDField;
    TitsVlDesc: TCurrencyField;
    TitsPrcPagto: TStringField;
    TitsInstrucoes: TStringField;
    RLCNPJ: TRLLabel;
    RLIEST: TRLLabel;
    RLEmpresa: TRLLabel;
    TitsNroParc: TStringField;
    RLPanel1: TRLPanel;
    RLAngleLabel1: TRLAngleLabel;
    RLPanel3: TRLPanel;
    RLPanel2: TRLPanel;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLLabel5: TRLLabel;
    RLDBText4: TRLDBText;
    RLDBText1: TRLDBText;
    RLLabel7: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel4: TRLLabel;
    RLPanel4: TRLPanel;
    RLLabel8: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabDesc: TRLLabel;
    RLLabJuros: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    RLLabel18: TRLLabel;
    RLDBText5: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLDBText12: TRLDBText;
    RLDBText13: TRLDBText;
    CadasCobrEnder: TStringField;
    CadasCNPJEd: TStringField;
    CadasCEPLst: TStringField;
    RLExt: TRLMemo;
    RLLabel19: TRLLabel;
    RLLinAux: TRLLabel;
    TitsPagRec: TStringField;
    RLMotivo1: TRLLabel;
    RLObs: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel22: TRLLabel;
    RLLabel23: TRLLabel;
    RLLabel24: TRLLabel;
    RLDraw1: TRLDraw;
    RLEmprAng: TRLAngleLabel;
    RLLabel25: TRLLabel;
    CadasEntrLograd: TStringField;
    CadasEntrNro: TStringField;
    CadasEntrCompl: TStringField;
    CadasEntrBairro: TStringField;
    CadasEntrCEP: TStringField;
    CadasEntrCidade: TStringField;
    CadasEntrUF: TStringField;
    TitsMultaVlr: TCurrencyField;
    CadasIEST: TStringField;
    CadasIESTUF: TStringField;
    CadasIMunic: TStringField;
    ImgsDup: TGraphicField;
    ImgsEmpFil: TSmallintField;
    TitsEmpresa: TSmallintField;
    TbEFi: TTable;
    TbEFiDenom: TStringField;
    TbEFiCNPJ: TStringField;
    TbEFiIEst: TStringField;
    TbEFiUF: TStringField;
    TbEFiMunicipio: TStringField;
    TbEFiCEP: TStringField;
    TbEFiLogradouro: TStringField;
    TbEFiNumero: TStringField;
    TbEFiComplemento: TStringField;
    TbEFiBairro: TStringField;
    TbEFiTelefone: TStringField;
    TbEFiCod: TSmallintField;
    TbEFiAbrev: TStringField;
    RLMotivo2: TRLLabel;
    RLDBText14: TRLDBText;
    procedure CadasCalcFields(DataSet: TDataSet);
    procedure TitsCalcFields(DataSet: TDataSet);
    procedure RLDetalheBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLDuplicataBeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuDuplicata: TFuDuplicata;

implementation

uses uGenericas, uIniGeral, FortesReportCtle;


{$R *.DFM}

Function EmiteDuplicata(pEmpFil,pAcesso:Integer;pMotivo:String;pPreview:Boolean): Integer;
begin
  Result      := 0;
  FuDuplicata := TFuDuplicata.Create(nil);
  with FuDuplicata
  do begin
    Imgs.DatabaseName  := FuIniGeral.wInicial.DatabaseName;
    Cadas.DatabaseName := FuIniGeral.wInicial.DatabaseName;
    Tits.DatabaseName  := FuIniGeral.wInicial.DatabaseName;
    TbEFi.DatabaseName := FuIniGeral.wInicial.DatabaseName;
    TbEfi.Active       := True;
    if not TbEFi.FindKey([pEmpFil])
    then begin
      MessageDlg('Empresa/Filial não encontrada',mtError,[mbOk],0);
      TbEfi.Active := False;
      Exit;
    end;
    Imgs.Active        := True;
    if not Imgs.FindKey([pEmpFil])
    then begin
      MessageDlg('Imagens: Empresa/Filial não encontrada',mtError,[mbOk],0);
      TbEfi.Active := False;
      Imgs.Active  := False;
      Exit;
    end;
    Cadas.Active       := True;
    Tits.Active        := True;
    RLMotivo1.Caption  := 'Reconheço(emos) a exatidão desta duplicata de ' + pMotivo +
                          ', na importância acima, que pagarei(emos)';
    RLMotivo2.Caption  := 'à sua ordem na praça e vencimento indicados.';



    if not Tits.FindKey([pAcesso])
    then Result := 1     // Não encontrado
    else if TitsPagRec.AsInteger <> 2
         then Result := 2     // Não é ctas a receber
         else begin
           if not Imgs.FindKey([TitsEmpresa.AsInteger])
              then Imgs.First;
           if not TbEFi.Findkey([TitsEmpresa.AsInteger])
              then TbEFi.First;

           FFortesReportCtle.RLPDFFilter1.FileName := FuIniGeral.wInicial.PathRelatorios + 'Duplicata' +
                                                      TitsAcesso.AsString + '.PDF';
           if pPreview then FuDuplicata.RLDuplicata.Preview
                       else FuDuplicata.RLDuplicata.Print;
         end;
    TbEFi.Active  := False;
    Imgs.Active   := False;
    Cadas.Active  := False;
    Tits.Active   := False;
  end;
  FuDuplicata.Free;

end;


procedure TFuDuplicata.CadasCalcFields(DataSet: TDataSet);
begin
  CadasCobrEnder.AsString := Trim(CadasEntrLograd.AsString);
  if Length(Trim(CadasEntrNro.AsString)) > 0
  then CadasCobrEnder.AsString := CadasCobrEnder.AsString + ', ' + Trim(CadasEntrNro.AsString);
  CadasCobrEnder.AsString := CadasCobrEnder.AsString + '  ' + Trim(CadasEntrCompl.AsString);
  CadasCNPJEd.AsString := EditaCNPJ_CPF(CadasCNPJF.AsString,CadasTPes.AsString);
  CadasCEPLst.AsString := EditaCEP(CadasEntrCEP.AsString);

end;

procedure TFuDuplicata.TitsCalcFields(DataSet: TDataSet);
begin
  TitsNroParc.AsString := TitsNro.AsString;
  if Length(Trim(TitsPArc.AsString)) > 0 then TitsNroParc.AsString := TitsNroParc.AsString + '/' + TitsParc.AsString;

end;

procedure TFuDuplicata.RLDetalheBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
var Vlr1: Real;
    Aux,AuxM: String;
    nl,i: Integer;
    Faz: Boolean;
const XTJur: array[0..2] of String = ('','DD','MM');
begin
  RLLogo.Stretch       := ImgsDupSt.AsBoolean;
  RLLabJuros.Caption   := '';
  RLLabDesc.Caption    :=  '';
  if (TitsTpJur.AsInteger > 0) and (TitsVlJur.AsFloat > 0)
  then begin
    Aux   := FloatToStrF(TitsPcJur.AsFloat,ffNumber,5,2) + '% ' + XTJur[TitsTpJur.AsInteger];
    Vlr1  := TitsVlJur.AsCurrency;
    if TitsTpJur.AsInteger = 2 then Vlr1 := Vlr1 / 30;   // Mensal
    Aux   := Aux + '  (' + FloatToStrF(Vlr1,ffCurrency,15,2) + ' ao dia)';
    AuxM  := '';
    if TitsMultaVlr.AsCurrency > 0
    then AuxM := 'Multa de R$ ' + FloatToSTrF(TitsMultaVlr.AsCurrency,ffNumber,15,2) +
                 ' após vencto';
    RLLabJuros.Caption := Aux + '  ' + AuxM;
  end;
  if TitsPcDesc.AsFloat > 0
  then RLLabDesc.Caption := FloatToStrF(TitsVlDesc.ASFloat,ffCurrency,15,2) +
                            '  (' + FloatToStrF(TitsPcDesc.AsFloat,ffNumber,5,2) +
                            '%)  até: ' + TitsDtDesc.AsString;
  Cadas.FindKey([TitsPortador.AsInteger]);

  RLLinAux.Caption := '';
  RLExt.Lines.Clear;
  Aux  := ValorExtenso(TitsValor.AsFloat,200,True);
  nl   := 1;
  i    := 1;
  Faz := True;
  while Faz
  do begin
    RLLinAux.Caption := RLLinAux.Caption + Aux[i];
    if RLLinAux.Width > 510
    then begin
      RLExt.Lines.Add(RLLinAux.Caption);
      RLLinAux.Caption := '';
      nl := nl + 1;
    end;
    i := i + 1;
    if (i > Length(Aux)) or (nl > 3) then Faz := False;
  end;
  RLEmprAng.Top := (RLPanel1.Height - RLEmprAng.Height) div 2;
{
  RLObs....  deverá receber a moeda e a cotação na emissão...
  Se for Moeda <> 0  então calcular o valor em REAIS....

  LabObserv.Caption := '';
  if QRDuplic.TitulosMoeda.AsInteger <> 0
  then begin
    VCot := VReais / QRDuplic.TitulosValor.AsFloat;
    LabObserv.Caption := 'Valor de emissão: ' +
                         Trim(MoedasAbrv[QRDuplic.TitulosMoeda.AsInteger]) +
                         ' ' + FloatToStrF(QRDuplic.TitulosValor.AsFloat,ffNumber,15,2) +
                         '   Cotação: R$ ' + FloatToStrF(VCot,ffNumber,15,2);
  end;

}

end;

procedure TFuDuplicata.RLDuplicataBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  RLEmpresa.Caption  := TbEfiDenom.AsString;
  RLEmprAng.Caption  := RLEmpresa.Caption;
  RLCNPJ.Caption     := EditaCNPJ_CPF(TbEfiCNPJ.AsString);
  RLIEST.Caption     := TbEfiIEST.AsString;
  RLLinha1.Caption   := Trim(TbEfiLogradouro.AsString) + ', ' + Trim(TbEfiNumero.AsString) + ' ' + Trim(TbEfiComplemento.AsString);
  RLLinha2.Caption   := EditaCEP(TbEfiCEP.AsString) + '  ' + Trim(TbEfiMunicipio.AsString) + '  ' + Trim(TbEfiUF.AsString);
  RLLinha3.Caption   := 'Fone: ' + TbEfiTelefone.AsString;
  if Length(Trim(RLCNPJ.Caption)) = 0 then RLLabel1.Visible := False;
  if Length(Trim(RLIEST.Caption)) = 0 then RLLabel2.Visible := False;

end;

end.
