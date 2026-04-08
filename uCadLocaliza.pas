unit uCadLocaliza;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, DBGrids, StdCtrls, Buttons, DBCtrls, Db, DBTables, Mask,
  ToolWin, ComCtrls, DateUtils;
  Function uBuscaCadastro(pDbName:String; pCadas:String = 'C'): Integer;

type
  TFuCadLocaliza = class(TForm)
    PanBot: TPanel;
    Nav: TDBNavigator;
    Cad: TTable;
    SCad: TDataSource;
    LabNRegs: TLabel;
    CadCodigo: TIntegerField;
    CadTp: TSmallintField;
    CadRzSocial: TStringField;
    CadTPes: TStringField;
    CadCNPJF: TStringField;
    CadEntrLograd: TStringField;
    CadEntrNro: TStringField;
    CadEntrCompl: TStringField;
    CadEntrBairro: TStringField;
    CadEntrCEP: TStringField;
    CadEntrCidade: TStringField;
    CadEntrUF: TStringField;
    CadCont1Nome: TStringField;
    CadZC_CNPJ: TStringField;
    CadCont1Fone1: TStringField;
    CadCont1Fone2: TStringField;
    CadDtCadast: TDateField;
    CadCont1DDD: TStringField;
    Label4: TLabel;
    edLocaliza: TEdit;
    Grid: TDBGrid;
    Label1: TLabel;
    cbOrdem: TComboBox;
    CadFantasia: TStringField;
    CadDesign: TStringField;
    CadIEST: TStringField;
    CadIESTUF: TStringField;
    CadIMunic: TStringField;
    CadEMail: TStringField;
    CadEMailNFe: TStringField;
    CadRefCom: TMemoField;
    CadObserv: TMemoField;
    cbEOu: TComboBox;
    btUtilizar: TBitBtn;
    btCancelar: TBitBtn;
    Panel1: TPanel;
    Label2: TLabel;
    ImgTamOrig: TImage;
    procedure btUtilizarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadCalcFields(DataSet: TDataSet);
    procedure CadAfterRefresh(DataSet: TDataSet);
    procedure FormResize(Sender: TObject);
    procedure cbOrdemChange(Sender: TObject);
    procedure CadFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure edLocalizaChange(Sender: TObject);
    procedure edLocalizaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbEOuChange(Sender: TObject);
    procedure edLocalizaExit(Sender: TObject);
    procedure ImgTamOrigDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;


var
  FuCadLocaliza: TFuCadLocaliza;
  codRetorno: Integer;
  keyNum: Integer;
  KeyChr: String;

const
  wLrg: array[0..3] of Real = (0.33, 0.25, 0.20, 0.08);

implementation


uses uGenericas; 

{$R *.DFM}


Function uBuscaCadastro(pDbName:String; pCadas:String = 'C'): Integer;
var lExec: Boolean;
begin
  Result     := 0;
  CodRetorno := 0;
  FuCadLocaliza := TFuCadLocaliza.Create(nil);
  with FuCadLocaliza
  do begin
    Cad.DatabaseName := pDBName;
    Cad.TableName    := 'Cad_Geral.DB';
    if pCadas <> 'C'
       then Cad.TableName := 'Cad_Fornecedores.DB';
    Try
      Cad.Active := True;
      lExec      := True;
    Except
      MessageDlg('Falha na abertura' + #13 +
                 '[ ' + Cad.DatabaseName + ' - ' + Cad.TableName + ' ]',
                 mtError,[mbOk],0);
      lExec := False;
    End;
    if lExec
    then begin
      FuCadLocaliza.ShowModal;
      Result     := codRetorno;
    end;
  end;
  FuCadLocaliza.Free;

end;


procedure TFuCadLocaliza.btUtilizarClick(Sender: TObject);
begin
  codRetorno := CadCodigo.AsInteger;
  FuCadLocaliza.Close;

end;

procedure TFuCadLocaliza.btCancelarClick(Sender: TObject);
begin
  codRetorno := 0;
  FuCadLocaliza.Close;

end;

procedure TFuCadLocaliza.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form_Salva(FuCadLocaliza);
  Cad.Active := False;

end;

procedure TFuCadLocaliza.CadCalcFields(DataSet: TDataSet);
begin
  CadZC_CNPJ.AsString := EditaCNPJ_CPF(CadCNPJF.AsString,CadTPes.AsString);
  
end;

procedure TFuCadLocaliza.CadAfterRefresh(DataSet: TDataSet);
begin
  LabNRegs.Caption := IntToStr(Cad.RecordCount) + ' registros';

end;


procedure TFuCadLocaliza.FormResize(Sender: TObject);
begin
  if FuCadLocaliza.Width < 590
     then FuCadLocaliza.Width := 590;
  if FuCadLocaliza.Height < 520
     then FuCadLocaliza.Height := 520;
  Grid := DefineGrid(Grid,wLrg,0,0);

end;

procedure TFuCadLocaliza.cbOrdemChange(Sender: TObject);
begin
  if not Cad.Active then Exit;
  edLocaliza.Text    := '';
  cbEOU.ItemIndex    := 0;
  case cbOrdem.ItemIndex of
    1:Cad.IndexName := 'RazaoSocial';
    2:Cad.IndexName := 'CGCCIC';
    3:Cad.IndexName := 'AlfaFantasia';
    else Cad.IndexName := '';
  end;
  edLocaliza.SetFocus;
  Cad.Refresh;
  
end;

procedure TFuCadLocaliza.CadFilterRecord(DataSet: TDataSet; var Accept: Boolean);
var wCompara: String;
    resComp,i: Integer;
begin
  Accept := True;
  if cbEOU.ItemIndex <> 0
  then begin
    if (cbOrdem.ItemIndex = 1) or (cbOrdem.ItemIndex = 3)
      then wCompara    := AnsiUpperCase(CadRzSocial.AsString) + ' ' + AnsiUpperCase(CadFantasia.AsString)
      else wCompara    := AnsiUpperCase(CadCNPJF.AsString);
    resComp := 0;
    for i := 1 to FGen.txSel
    do if Length(Trim(FGen.txComp[i])) > 0
       then if Pos(FGen.txComp[i],wCompara) > 0
            then resComp := resComp + 1;
    if ((cbEOU.Text = 'E') and (resComp <> FGen.txSel))
       or ((cbEOU.Text = 'OU') and (resComp = 0))
    then begin
      Accept := False;
      Exit;
    end;
  end;

end;

procedure TFuCadLocaliza.FormActivate(Sender: TObject);
begin
  edLocaliza.Hint     := 'Texto a ser localizado, palavras separadas, ou' + #13
                         + 'utilize ";" (ponto-e-virgula) para delimitar textos';
  Form_Define(FuCadLocaliza);
  FormResize(nil);
  cbOrdem.ItemIndex   := 1;
  cbOrdemChange(nil);

end;

procedure TFuCadLocaliza.edLocalizaChange(Sender: TObject);
begin
  if not Cad.Active then Exit;
  if Cad.IndexName = ''
  then begin
    keyNum := StrToIntDef(edLocaliza.Text,0);
    Cad.FindNearest([keyNum]);
  end
  else begin
    if cbEOU.ItemIndex = 0
    then begin
      keyChr := edLocaliza.Text;
      Cad.FindNearest([keyChr]);
    end;
  end;

end;

procedure TFuCadLocaliza.edLocalizaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Return
     then btUtilizarClick(nil);

end;

procedure TFuCadLocaliza.cbEOuChange(Sender: TObject);
begin
  if cbEOU.ItemIndex > 0
  then begin
    MontaTextosPesquisa(edLocaliza.Text);
    Cad.Filtered := True;
  end
  else Cad.Filtered := False;
  Cad.Refresh;

end;

procedure TFuCadLocaliza.edLocalizaExit(Sender: TObject);
begin
  if not Cad.Active then Exit;
  if cbEOU.ItemIndex = 0
     then Exit;
  MontaTextosPesquisa(edLocaliza.Text);
  Cad.Refresh;

end;

procedure TFuCadLocaliza.ImgTamOrigDblClick(Sender: TObject);
begin
  Form_Centraliza(FuCadLocaliza, 0, 590);  
  Grid := DefineGrid(Grid,wLrg,0,0);
  Form_Salva(FuCadLocaliza);

end;

end.
