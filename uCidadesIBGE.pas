unit uCidadesIBGE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, DBCtrls, DB, DBTables, Grids, DBGrids,
  Mask, Buttons, DateUtils;
  Function  ObtemIBGECidadeUF(pmtDBName:String; pmtCidadePadrao:String; pmtUFPadrao:String;
                              var pmtNomeCidade:String; var pmtSiglaUF:String;
                              var retIBGECidade:Integer; var retIBGEUF:Integer): Boolean;
  Function  ObtemNomeCidadeUF(pmtDBName:String; pmtCidadePadrao:String; pmtUFPadrao:String;
                              var pmtIBGECidade:Integer; var pmtIBGEUF:Integer;
                              var retNomeCidade:String; var retSiglaUF:String): Boolean;
  Procedure ManutencaoCidadesIBGE(pmtDBName:String;
                              var retNomeCidade:String; var retSiglaUF:String;
                              var retIBGECidade:Integer; var retIBGEUF:Integer;
                              var retIBGEUFCidade:String);

type
  TFCidadesIBGE = class(TForm)
    Panel1: TPanel;
    MenuPrinc: TMainMenu;
    Cidades1: TMenuItem;
    Incluir1: TMenuItem;
    Alterar1: TMenuItem;
    Excluir1: TMenuItem;
    PanCtle: TPanel;
    Nav: TDBNavigator;
    LabNRegs: TLabel;
    CbOrdem: TComboBox;
    Label2: TLabel;
    Grid: TDBGrid;
    LabLocaliz: TLabel;
    EdLocaliz: TEdit;
    PanManut: TPanel;
    LabAcao: TLabel;
    Label3: TLabel;
    EdCidade: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    EdCodIBGE: TDBEdit;
    BtOk: TBitBtn;
    BtCanc: TBitBtn;
    btUsarSair: TBitBtn;
    Sair: TMenuItem;
    TSUFs: TTable;
    TSUFsIBGE: TSmallintField;
    TSUFsSigla: TStringField;
    TSUFsDenom: TStringField;
    TSUFsAliqICM: TBCDField;
    TSUFsAliqICMInt: TBCDField;
    TSUFsCEPMin: TStringField;
    TSUFsCEPMax: TStringField;
    TSUFsAliqFCP: TBCDField;
    STSUFs: TDataSource;
    Cidades: TTable;
    CidadesUFIBGE: TSmallintField;
    CidadesCodIBGE: TIntegerField;
    CidadesNome: TStringField;
    CidadesUF: TStringField;
    SCidades: TDataSource;
    CidadesCEP: TStringField;
    CidadesVlr1: TCurrencyField;
    CidadesVlr2: TCurrencyField;
    CidadesVlr3: TCurrencyField;
    CidadesObs1: TStringField;
    CidadesObs2: TStringField;
    CidadesObs3: TStringField;
    CidadesZC_CodIBGE: TStringField;
    CidadesZC_UFCodIBGE: TStringField;
    CidadesZC_CEP: TStringField;
    dbSigla: TDBLookupComboBox;
    Label6: TLabel;
    DBEdit1: TDBEdit;
    Label7: TLabel;
    DBEdit2: TDBEdit;
    Label8: TLabel;
    Label9: TLabel;
    DBEdit3: TDBEdit;
    Label10: TLabel;
    DBEdit4: TDBEdit;
    Label11: TLabel;
    Label12: TLabel;
    DBEdit5: TDBEdit;
    Label13: TLabel;
    DBEdit6: TDBEdit;
    Label14: TLabel;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    Label15: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    cbUFs: TComboBox;
    cbIBGE: TComboBox;
    Label16: TLabel;
    btNothing: TBitBtn;
    btSair: TBitBtn;
    btTamOrig: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure cbUFsChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CbOrdemChange(Sender: TObject);
    procedure EdLocalizChange(Sender: TObject);
    procedure Incluir1Click(Sender: TObject);
    procedure BtCancClick(Sender: TObject);
    procedure BtOkClick(Sender: TObject);
    procedure Alterar1Click(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btUsarSairClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CidadesCalcFields(DataSet: TDataSet);
    procedure CidadesFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure cbIBGEChange(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure btTamOrigClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FCidadesIBGE: TFCidadesIBGE;
  fTime: Boolean;
  wAcao: Integer;
  wfUF: String;
  wfIBGE: Integer;
  lUse: Boolean;

implementation

uses uGenericas, uMensagem;

{$R *.dfm}

Function ObtemIBGECidadeUF(pmtDBName:String; pmtCidadePadrao:String; pmtUFPadrao:String;
                          var pmtNomeCidade:String; var pmtSiglaUF:String;
                          var retIBGECidade:Integer; var retIBGEUF:Integer): Boolean;
begin
  Result        := False;
  retIBGECidade := 0;
  retIBGEUF     := 0;
  FCidadesIBGE  := TFCidadesIBGE.Create(nil);
  with FCidadesIBGE
  do begin
    pmtNomeCidade := TextoRetiraAcentuacao(Trim(pmtNomeCidade), True);
    pmtSiglaUF    := TextoRetiraAcentuacao(Trim(pmtSiglaUF), True);
    if Length(Trim(pmtNomeCidade)) = 0
       then pmtNomeCidade := pmtCidadePadrao;
    if Length(Trim(pmtSiglaUF)) = 0
       then pmtSiglaUF    := pmtUFPadrao;
    //
    Cidades.DatabaseName := pmtDBName;
    Cidades.IndexName    := 'Alfabetica';
    Cidades.Filtered     := False;
    Cidades.Active       := True;
    if Cidades.FindKey([pmtNomeCidade,pmtSiglaUF])
    then begin
      retIBGECidade := CidadesCodIBGE.AsInteger;
      retIBGEUF     := CidadesUFIBGE.AsInteger;
      Result        := True;
    end
    else begin
      Cidades.First;
      Cidades.FindNearest([pmtNomeCidade,'']);
      if pmtNomeCidade = Trim(CidadesNome.AsString)
      then begin
        retIBGECidade := CidadesCodIBGE.AsInteger;
        retIBGEUF     := CidadesUFIBGE.AsInteger;
        Result        := True;
      end;
    end;
    Cidades.Active       := False;
  end;
  FCidadesIBGE.Free;

end;


Function ObtemNomeCidadeUF(pmtDBName:String; pmtCidadePadrao:String; pmtUFPadrao:String;
                           var pmtIBGECidade:Integer; var pmtIBGEUF:Integer;
                           var retNomeCidade:String; var retSiglaUF:String): Boolean;
begin
  Result        := False;
  retNomeCidade := pmtCidadePadrao;
  retSiglaUF    := pmtUFPadrao;
  FCidadesIBGE  := TFCidadesIBGE.Create(nil);
  with FCidadesIBGE
  do begin
    Cidades.DatabaseName := pmtDBName;
    Cidades.IndexName    := '';
    Cidades.Filtered     := False;
    Cidades.Active       := True;
    if Cidades.FindKey([pmtIBGEUF,pmtIBGECidade])
    then begin
      retNomeCidade := CidadesNome.AsString;
      retSiglaUF    := CidadesUF.AsString;
      Result        := True;
    end;
    Cidades.Active       := False;
  end;
  FCidadesIBGE.Free;

end;


Procedure ManutencaoCidadesIBGE(pmtDBName:String;
                              var retNomeCidade:String; var retSiglaUF:String;
                              var retIBGECidade:Integer; var retIBGEUF:Integer;
                              var retIBGEUFCidade:String);
begin
  FCidadesIBGE := TFCidadesIBGE.Create(nil);
  with FCidadesIBGE
  do begin
    btUsarSair.Caption   := '&Utilizar' + #13 + '&& Sair';
    btSair.Caption       := '&Sair';
    TSUFs.DatabaseName   := pmtDBName;
    TSUFs.IndexName      := 'UFSigla';
    TSUFs.Active         := True;
    cbUFS.Items.Clear;
    CbUFS.Items.Add('Sem seleção');
    TSUFs.First;
    while not TSUFs.Eof
    do begin
      CbUFS.Items.Add(TSUFsSigla.AsString);
      TSUFs.Next;
    end;
    Cidades.DatabaseName := pmtDBName;
    Cidades.IndexName    := 'Alfabetica';
    Cidades.Active       := True;
    cbUFs.ItemIndex      := 0;
    wfUF                 := '';
    cbIBGE.ItemIndex     := 2;
    wfIBGE               := 2;
    Cidades.First;
    while not Cidades.Eof
    do begin
      if CidadesCodIBGE.AsInteger > 1000000
      then Cidades.Delete
      else Cidades.Next;
    end;
    lUse                 := False;
    FCidadesIBGE.ShowModal;
    if lUse
    then begin
      retNomeCidade      := CidadesNome.AsString;
      retSiglaUF         := CidadesUF.AsString;
      retIBGECidade      := CidadesCodIBGE.AsInteger;
      retIBGEUF          := CidadesUFIBGE.AsInteger;
      retIBGEUFCidade    := CidadesZC_UFCodIBGE.AsString;
    end;

    TSUFs.Active         := False;
    Cidades.Active       := False;
  end;
  FCidadesIBGE.Free;

end;


Function Controle(Acao:Integer;Modo:Boolean): Integer;
var i: Integer;
const XOper: Array[1..3] of String = ('Inclusão','Alteração','');
begin
  Result := Acao;
  with FCidadesIBGE
  do begin
    LabAcao.Caption := XOper[Acao];
    PanManut.Enabled := Modo;
    BtOk.Visible := Modo;
    BtCanc.Visible := Modo;
    if Modo then Modo := False
            else Modo := True;
    for i := 0 to MenuPrinc.Items.Count-1 do MenuPrinc.Items[i].Enabled := Modo;
    Grid.Enabled := Modo;
    PanCtle.Enabled := Modo;
    if Acao = 3
       then btNothing.SetFocus;

  end;

end;

procedure TFCidadesIBGE.FormCreate(Sender: TObject);
begin
  fTime := True;

end;

procedure TFCidadesIBGE.cbUFsChange(Sender: TObject);
begin
  if not Cidades.Active then Exit;
  if CbUFS.ItemIndex = 0
    then wfUF := ''
    else wfUF := CbUFS.Text;
  if (wfUF = '') and (wfIBGE = 0)
    then Cidades.Filtered := False
    else Cidades.Filtered := True;
  EdLocaliz.Text := '';
  Cidades.Refresh;
  Cidades.First;
  LabNRegs.Caption := IntToStr(Cidades.RecordCount) + ' registros';
  if EdLocaliz.Enabled then EdLocaliz.SetFocus
                       else btNothing.SetFocus;

end;

procedure TFCidadesIBGE.FormActivate(Sender: TObject);
begin
  if not fTime then Exit;
  fTime := False;
  Form_Define(FCidadesIBGE);
  FormResize(nil);
  wfIBGE            := cbIBGE.ItemIndex;
  cbUFS.ItemIndex   := 0;
  cbUFsChange(nil);
  cbOrdem.ItemIndex := 2;
  edLocaliz.Text    := '';
  cbOrdemChange(nil);

end;

procedure TFCidadesIBGE.CbOrdemChange(Sender: TObject);
begin
  EdLocaliz.Text := '';
  EdLocaliz.Enabled := True;
  LabLocaliz.Enabled := True;
  case CbOrdem.ItemIndex of
    0:begin   // UF(IBGE) / Codigo
        EdLocaliz.Enabled := False;
        LabLocaliz.Enabled := False;
        Cidades.IndexName := '';
      end;
    1:Cidades.IndexName := 'Numerica';       // CodIBGE/UFIBGE
    2:Cidades.IndexName := 'Alfabetica';     // Nome/UF
    3:Cidades.IndexName := 'CodPostal';      // CEP
  end;
  if EdLocaliz.Enabled then EdLocaliz.SetFocus
                       else btNothing.SetFocus;
  LabNRegs.Caption := '';
  if not Cidades.Active
     then Exit;
  Cidades.Refresh;
  Cidades.First;
  LabNRegs.Caption := IntToStr(Cidades.RecordCount) + ' registros';
  btNothing.SetFocus;

end;

procedure TFCidadesIBGE.EdLocalizChange(Sender: TObject);
begin
  if not Cidades.Active then Exit;
  case cbOrdem.ItemIndex of
    1:Cidades.FindNearest([StrToIntDef(EdLocaliz.Text,0),0]);          // CodIBGE/UF
    2:Cidades.FindNearest([EdLocaliz.Text,'']);
    3:Cidades.FindNearest([EdLocaliz.Text]);
  end;
  
end;

procedure TFCidadesIBGE.Incluir1Click(Sender: TObject);
begin
  wAcao := Controle(1,True);
  Cidades.Append;
  EdCidade.SetFocus;

end;

procedure TFCidadesIBGE.BtCancClick(Sender: TObject);
begin
  WAcao := Controle(3,False);

end;

procedure TFCidadesIBGE.BtOkClick(Sender: TObject);
var Msg: String;
begin
  Msg := '';
  if Length(Trim(CidadesNome.AsString)) = 0 then Msg := Msg + 'Nome da cidade obrigatório' + #13;
  if Length(Trim(CidadesUF.AsString)) = 0 then Msg := Msg + 'Sigla UF não informada' + #13
  else if not TSUFs.FindKey([CidadesUF.AsString])
       then Msg := Msg + 'Sigla UF inválida' + #13
       else CidadesUFIBGE.AsInteger := TSUFsIBGE.AsInteger;
  if CidadesCodIBGE.AsInteger = 0 then Msg := Msg + 'Código da cidade não informado' + #13;
  if Length(Trim(Msg)) > 0
  then begin
    msgSistema(1,'Erros detectados',Msg,1,1);
    EdCidade.SetFocus;
    Exit;
  end;
  Try
    Cidades.Post;
  Except
    MessageDlg('Código IBGE ou Nome duplicado, reinforme',mtError,[mbOk],0);
    EdCidade.SetFocus;
    Exit;
  End;
  wAcao := Controle(3,False);
  LabNRegs.Caption := IntToStr(Cidades.RecordCount) + ' registros';

end;

procedure TFCidadesIBGE.Alterar1Click(Sender: TObject);
begin
  if Cidades.RecordCount = 0 then Exit;
  if not GenRecordLock(Cidades,True) then Exit;
  wAcao := Controle(2,True);
  EdCidade.SetFocus;

end;

procedure TFCidadesIBGE.Excluir1Click(Sender: TObject);
begin
  if Cidades.RecordCount = 0 then Exit;
  if msgSistema(3,'Exclusão de cidade',
                  'Cidade: ' + CidadesNome.AsString + #13 +
                  'UF: ' + CidadesUF.AsString + '  (' + CidadesUFIBGE.AsString + ')' +
                  #13 + 'Confirme a exclusão',3,2) <> 1 then Exit;
  Cidades.Delete;
  Cidades.Refresh;
  LabNRegs.Caption := IntToStr(Cidades.RecordCount) + ' registros';
  btNothing.SetFocus;

end;

procedure TFCidadesIBGE.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form_Salva(FCidadesIBGE);
  
end;

procedure TFCidadesIBGE.btUsarSairClick(Sender: TObject);
begin
  lUse := True;
  FCidadesIBGE.Close;

end;

procedure TFCidadesIBGE.FormResize(Sender: TObject);
const wLrg: array[0..8] of Real = (0.33, 0.04, 0.04, 0.07, 0.08, 0.10, 0.10, 0.10, 0.10);
begin
  if FCidadesIBGE.Width < 680
     then FCidadesIBGE.Width := 680;
  if FCidadesIBGE.Height < 560
     then FCidadesIBGE.Height := 560;
  Grid := DefineGrid(Grid, wLrg, 0, 0);

end;

procedure TFCidadesIBGE.CidadesCalcFields(DataSet: TDataSet);
begin
  if (CidadesCodIBGE.AsInteger > 0) and (CidadesCodIBGE.AsInteger < 1000000)
    then CidadesZC_CodIBGE.AsString := stringCompleta(CidadesCodIBGE.AsString,'E','0',5)
    else CidadesZC_CodIBGE.AsString := '0';
  CidadesZC_UFCodIBGE.AsString := CidadesUFIBGE.AsString + stringCompleta(CidadesZC_CodIBGE.AsString,'C',' ',5);
  CidadesZC_CEP.AsString       := EditaCEP(CidadesCEP.AsString);

end;

procedure TFCidadesIBGE.CidadesFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept := True;
  if (wfUF <> '') and
     (CidadesUF.AsString <> wfUF)
  then begin
    Accept := False;
    Exit;
  end;
  if wfIBGE = 0 then Exit;
  if (wfIBGE = 1) and
     ((CidadesCodIBGE.AsInteger > 0) and (CidadesCodIBGE.AsInteger < 1000000))
  then begin      // sem código IBGE
    Accept := False;
    Exit;
  end;
  if (wfIBGE = 2) and
     (CidadesCodIBGE.AsInteger > 1000000)
  then begin      // COM código IBGE
    Accept := False;
    Exit;
  end;

end;

procedure TFCidadesIBGE.cbIBGEChange(Sender: TObject);
begin
  if not Cidades.Active then Exit;
  wfIBGE := cbIBGE.ItemIndex;
  cbUFsChange(nil);

end;

procedure TFCidadesIBGE.btSairClick(Sender: TObject);
begin
  lUse := False;
  FCidadesIBGE.Close;

end;

procedure TFCidadesIBGE.btTamOrigClick(Sender: TObject);
begin
  Form_Centraliza(FCidadesIBGE, 640, 740);

end;

end.
