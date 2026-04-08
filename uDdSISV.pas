unit uDdSISV;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, DateUtils, DBGrids, Buttons, Grids,
  ExtCtrls, WinINet, TLHelp32, Math, IniFiles, Printers, ShellApi;

  Function  ValidaCEP_SiglaUF(pmtDBName,pmtCEP,pmtUF:String):Boolean;
  Function  ValidaSiglaUF(pmtDBName,pmtSigla:String):Boolean;
  Function  ObtemCodigoIBGE(pDBName:String;
                            var pUF:String;
                            var pMun:String;
                            var pCEP:String;
                            var retUF:Integer;
                            var retMun:Integer;
                            pPesqManual:Boolean = True): Boolean;
  Function  VerDiaUtil(pmtDBName:String; pmtData:TDateTime): Boolean;
  Function  ValorEmReais(pmtDBName:String; pValor:Real;pMoeda:Integer;pData:TDateTime): Real;

type
  TFuDdSISV = class(TForm)
    Feriados: TTable;
    FeriadosData: TDateField;
    VlRefs: TTable;
    VlRefsVlrData: TDateField;
    VlRefsVlr01: TBCDField;
    VlRefsVlr02: TBCDField;
    VlRefsVlr03: TBCDField;
    VlRefsVlr04: TBCDField;
    VlRefsVlr05: TBCDField;
    UFSiglas: TTable;
    UFSiglasIBGE: TSmallintField;
    UFSiglasSigla: TStringField;
    UFSiglasDenom: TStringField;
    UFSiglasAliqICM: TBCDField;
    UFSiglasAliqICMInt: TBCDField;
    UFSiglasCEPMin: TStringField;
    UFSiglasCEPMax: TStringField;
    Cidades: TTable;
    CidadesUFIBGE: TSmallintField;
    CidadesCodIBGE: TIntegerField;
    CidadesNome: TStringField;
    CidadesUF: TStringField;
    CidadesCEP: TStringField;
    CidadesVlr1: TCurrencyField;
    CidadesVlr2: TCurrencyField;
    CidadesVlr3: TCurrencyField;
    CidadesObs1: TStringField;
    CidadesObs2: TStringField;
    CidadesObs3: TStringField;
    gbUFMun: TGroupBox;
    cbUFs: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    cbMunic: TComboBox;
    btCancel: TBitBtn;
    btOk: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure cbUFsExit(Sender: TObject);
    procedure CidadesFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure btCancelClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FuDdSISV: TFuDdSISV;
  kSigla,kCidade: String;
  listMunIBGE,listCEPs: TStringList;
  nIdxUF,nUFRet: Integer;
  nIdxMun: Integer;
  lProcess: Boolean;

implementation

uses uGenericas;

{$R *.DFM}


Function ValidaCEP_SiglaUF(pmtDBName,pmtCEP,pmtUF:String):Boolean;
// Retorna TRUE para CEP/UF Válidos, caso contrário retorna FALSE
begin
  Result   := False;
  FuDdSISV := TFuDdSISV.Create(nil);
  with FuDdSISV
  do begin
    UFSiglas.DatabaseName := pmtDBName;
    UFSiglas.IndexName    := 'UFSigla';
    UFSiglas.Active       := True;
    if UFSiglas.FindKey([pmtUF])
    then begin
      if (pmtCEP >= UFSiglasCEPMin.AsString) and
         (pmtCEP <= UFSiglasCEPMax.AsString) then Result := True;
    end;
    UFSiglas.Active := False;
  end;
  FuDdSISV.Free;

end;


Function ValidaSiglaUF(pmtDBName,pmtSigla:String):Boolean;
begin
  FuDdSISV := TFuDdSISV.Create(nil);
  with FuDdSISV
  do begin
    UFSiglas.DatabaseName := pmtDBName;
    UFSiglas.IndexName    := 'UFSigla';
    UFSiglas.Active       := True;
    Result                := UFSiglas.FindKey([AnsiUpperCase(pmtSigla)]);
    UFSiglas.Active       := False;
  end;
  FuDdSISV.Free;

end;


Function  ObtemCodigoIBGE(pDBName:String;
                          var pUF:String;
                          var pMun:String;
                          var pCEP:String;
                          var retUF:Integer;
                          var retMun:Integer;
                          pPesqManual:Boolean = True): Boolean;
// pDBName: DatabaseName
// pUF    : Sigla da UF
// pMun   : Nome da cidade/município
// pCEP   : CEP da localidade
// retUF  : Retorno - Codigo IBGE da UF
// retMun :         - Codigo IBGE do municipio
// Retorno: True: Ok    False:Erro
//
begin
  Result   := False;
  FuDdSISV := TFuDdSISV.Create(nil);
  with FuDdSISV
  do begin
    UFSiglas.DatabaseName := pDBName;
    UFSiglas.IndexName    := 'UFSigla';
    UFSiglas.Active       := True;
    Cidades.DatabaseName  := pDBName;
    Cidades.IndexName     := 'Alfabetica';
    Cidades.Filtered      := False;
    Cidades.Active        := True;
    retUF                 := 0;
    retMun                := 0;
    //
    if Cidades.FindKey([pMun,pUF])
    then begin
      retUF           := CidadesUFIBGE.AsInteger;
      retMun          := CidadesCodIBGE.AsInteger;
      Result          := True;
    end;
    //
    if Result and (not pPesqManual)
    then begin
      UFSiglas.Active := False;
      Cidades.Active  := False;
      Exit;
    end;
    //
    nIdxUF          := -1;
    FuDdSISV.Top    := Screen.Height div 4;
    FuDdSISV.Left   := Screen.Width  div 6;
    FuDdSISV.Width  := 310;
    FuDdSISV.Height := 190;
    gbUFMun.Align   := alClient;
    cbUFs.Items.Clear;
    UFSiglas.First;
    while not UFSiglas.Eof
    do begin
      if UFSiglasSigla.AsString <> 'EX'
      then begin
        cbUFs.Items.Add(UFSiglasSigla.AsString + ' - ' + UFSiglasDenom.AsString);
        if pUF = UFSiglasSigla.AsString
           then nIdxUF := cbUFs.Items.Count-1;
      end;
      UFSiglas.Next;
    end;
    listMunIBGE := TStringList.Create;  // Códigos dos municipios
    listCEPs    := TStringList.Create;  // CEP dos municípios

    FuDdSISV.ShowModal;

    pUF             := kSigla;
    pMun            := kCidade;
    pCEP            := listCEPs[nIdxMun];
    retUF           := nUFRet;
    retMun          := StrToIntDef(listMunIBGE[nIdxMun],0);
    UFSiglas.Active := False;
    Cidades.Active  := False;
    Result          := lProcess;
    listMunIBGE.Free;
    listCEPs.Free;
  end;
  FuDdSISV.Free;

end;


Function VerDiaUtil(pmtDBName:String; pmtData:TDateTime): Boolean;
// Verifica se data é dia útil, utilizando o cadastro de feriados
// Parametros  pmtData: Data a ser verificada
// Retorno: True->Dia útil        False->Não é dia útil
var wDiaSemana,i: Integer;
    wAa: Word;
const xDia: array[1..8] of word = (1,21,1,7,12,2,15,25);
      xMes: array[1..8] of word = (1, 4,5,9,10,11,11,12);
begin
  Result := True;                                                // Dia útil...
  pmtData := DateOf(pmtData);                                    // Retira as informações fracionárias da data
  // Feriados considerados: 01/01 1.Janeiro     21/04 Tiradentes    01/05 Trabalho      07/09 Independencia
  //                        12/10 NS Aparecida  02/11 Finados       15/11 Republica     25/12 Natal
  //
  wDiaSemana := DayOfWeek(pmtData);                              // Dia da semana (1-Dom, 2-Seg...., 7-Sáb)
  if (wDiaSemana = 1) or (wDiaSemana = 7)
  then Result := False   // Domingo ou Sábado, não é dia útil
  else begin
    wAa := YearOf(pmtData);                                        // Ano da data
    for i := 1 to 8
    do if pmtData = EncodeDate(wAa,xMes[i],xDia[i])
       then begin
         Result := False;      // Feriado fixo, não é dia útil
         Break;
       end;
  end;
  if not Result
     then Exit;
  //
  // Verifica em feriados cadastrados
  FuDdSISV := TFuDdSISV.Create(nil);
  with FuDdSISV
  do begin
    Feriados.DatabaseName := pmtDBName;
    Feriados.Active       := True;
    if Feriados.FindKey([pmtData])
       then Result := False;    // Feriado cadastrado, não é dia útil
    Feriados.Active := False;
  end;
  FuDdSISV.Free;

end;



Function ValorEmReais(pmtDBName:String;pValor:Real;pMoeda:Integer;pData:TDateTime): Real;
var wData: TDateTime;
    wFaz: Boolean;
begin
  Result := pValor;
  if (pMoeda < 1) or (pMoeda > 5) then Exit;
  FuDdSISV  := TFuDdSISV.Create(nil);
  with FuDdSISV
  do begin
    VlRefs.Active := True;
    if VlRefs.RecordCount > 0
    then begin
      wData := DateOf(pData);
      VlRefs.FindNearest([wData]);
      wFaz := True;
      while wFaz do
      begin
        if wData < VlRefsVlrData.AsDateTime
           then VlRefs.Prior
           else wFaz := False;
        if VlRefs.Bof
           then wFaz := False;
      end;
      if VlRefs.Bof
         then VlRefs.First;
      Result := pValor * VlRefs.Fields[pMoeda].AsFloat;
    end;
    VlRefs.Active := False;
  end;
  FuDdSISV.Free;

end;




procedure TFuDdSISV.FormShow(Sender: TObject);
begin
  lProcess := False;
  cbMunic.Items.Clear;
  cbMunic.ItemIndex := -1;
  cbMunic.Text      := '';
  cbUFs.ItemIndex   := nIdxUF;
  if nIdxUF < 0
     then cbUFs.ItemIndex := 0;
  cbUFS.SetFocus;

end;

procedure TFuDdSISV.cbUFsExit(Sender: TObject);
begin
  cbMunic.Items.Clear;
  kSigla           := Copy(cbUFs.Text,1,2);
  Cidades.Filtered := True;
  Cidades.Refresh;
  Cidades.First;
  nUFRet := CidadesUFIBGe.AsInteger;
  listMunIBGE.Clear;
  listCEPs.Clear;
  while not Cidades.Eof
  do begin
    cbMunic.Items.Add(CidadesNome.AsString);
    listMunIBGE.Add(CidadesCodIBGE.AsString);
    listCEPs.Add(CidadesCEP.AsString);
    Cidades.Next;
  end;
  cbMunic.ItemIndex := -1;

end;


procedure TFuDdSISV.CidadesFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := False;
  if CidadesUF.AsString = kSigla then Accept := True;

end;

procedure TFuDdSISV.btCancelClick(Sender: TObject);
begin
  lProcess := False;
  FuDdSISV.Close;

end;

procedure TFuDdSISV.btOkClick(Sender: TObject);
begin
  kCidade  := cbMunic.Text;
  nIdxMun  := cbMunic.ItemIndex;
  lProcess := True;
  FuDdSISV.Close;

end;

end.
