unit uSiglasUF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, ExtCtrls, Grids, DBGrids, StdCtrls, Buttons, Mask,
  Menus, DB, DBTables, ComCtrls;
  Procedure ManutencaoEstados(pmtDBName:String);
  Function  AliquotasICMS_UF(pmtUF:String; pmtAliqInterna,pmtAliqInterEst,pmtFCP:Real;pmtDifAl:Boolean): Boolean;


type
  TFuSiglasUF = class(TForm)
    Panel1: TPanel;
    Nav: TDBNavigator;
    RGOrdem: TRadioGroup;
    BtSair: TBitBtn;
    LabNRegs: TLabel;
    Panel3: TPanel;
    MenuUF: TMainMenu;
    Estados1: TMenuItem;
    Incluir1: TMenuItem;
    Alterar1: TMenuItem;
    Excluir1: TMenuItem;
    Sair1: TMenuItem;
    Grid: TDBGrid;
    PanManut: TPanel;
    LabAcao: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EdIBGE: TDBEdit;
    EdUF: TDBEdit;
    EDenom: TDBEdit;
    BtOk: TBitBtn;
    BtCanc: TBitBtn;
    GroupBox1: TGroupBox;
    EdICM: TDBEdit;
    Label4: TLabel;
    EdCMInt: TDBEdit;
    Label5: TLabel;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    EdCEPIni: TDBEdit;
    Label7: TLabel;
    EdCEPFin: TDBEdit;
    GroupBox3: TGroupBox;
    LabFCP: TLabel;
    edFCP: TDBEdit;
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
    btNothing: TBitBtn;
    TSUFsDifAl: TBooleanField;
    dbDifal: TDBCheckBox;
    TSUFsZC_DifAl: TStringField;
    imgEdit: TImage;
    imgShow: TImage;
    StatusBar1: TStatusBar;
    btTamOrig: TBitBtn;
    procedure BtSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RGOrdemClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Incluir1Click(Sender: TObject);
    procedure Alterar1Click(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure BtCancClick(Sender: TObject);
    procedure BtOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TSUFsCalcFields(DataSet: TDataSet);
    procedure GridDblClick(Sender: TObject);
    procedure imgEditClick(Sender: TObject);
    procedure imgShowClick(Sender: TObject);
    procedure btTamOrigClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuSiglasUF: TFuSiglasUF;
  orUF: string;

implementation

uses uGenericas, uIniGeral;

{$R *.dfm}

Procedure ManutencaoEstados(pmtDBName:String);
begin
  FuSiglasUF := TFuSiglasUF.Create(nil);
  with FuSiglasUF
  do begin
    TSUFS.DatabaseName := pmtDBName;
    TSUFS.Active       := True;
    FuSiglasUF.ShowModal;
    TSUFS.Active       := False;
  end;
  FuSiglasUF.Free;

end;


Function  AliquotasICMS_UF(pmtUF:String; pmtAliqInterna,pmtAliqInterEst,pmtFCP:Real;pmtDifAl:Boolean): Boolean;
begin
  Result          := False;
  pmtAliqInterna  := 0;
  pmtAliqInterEst := 0;
  pmtFCP          := 0;
  pmtDifAl        := False;
  FuSiglasUF      := TFuSiglasUF.Create(nil);
  with FuSiglasUF
  do begin
    TSUFS.DatabaseName := FuIniGeral.wInicial.DatabaseName;
    TSUFS.IndexName    := 'UFSigla';
    TSUFS.Active       := True;
    if TSUFS.FindKey([pmtUF])
    then begin
      pmtAliqInterna  := TSUFSAliqICMInt.AsFloat;
      pmtAliqInterEst := TSUFSAliqICM.AsFloat;
      pmtFCP          := TSUFSAliqFCP.AsFloat;
      pmtDifAl        := TSUFSDifal.AsBoolean;
      Result          := True;
    end;
    TSUFS.Active       := False;
  end;
  FuSiglasUF.Free;

end;


Procedure CtleUFs(pAcao:Integer;pModo:Boolean);
var i: Integer;
const xAcao: Array[1..3] of String = ('Inclusão','Alteração','Consulta');
begin
  with FuSiglasUF
  do begin
    StatusBar1.Panels[0].Text := 'Operação: ' + xAcao[pAcao];
    LabAcao.Caption   := xAcao[pAcao];
    PanManut.Enabled  := pModo;
    BtOk.Visible      := pModo;
    BtCanc.Visible    := pModo;
    if pModo then pModo := False
             else pModo := True;
    Grid.Enabled      := pModo;
    Nav.Enabled       := pModo;
    RgOrdem.Enabled   := pModo;
    BtSair.Enabled    := pModo;
    for i := 0 to MenuUF.Items.Count-1
    do MenuUF.Items[i].Enabled := pModo;
    if pAcao = 3
       then btNothing.SetFocus;

  end;

end;

procedure TFuSiglasUF.BtSairClick(Sender: TObject);
begin
  FuSiglasUF.Close;

end;

procedure TFuSiglasUF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form_Salva(FuSiglasUF);

end;

procedure TFuSiglasUF.RGOrdemClick(Sender: TObject);
begin
  case RGOrdem.ItemIndex of
    1:TSUFs.IndexName := 'UFSigla';
    2:TSUFs.IndexName := 'Alfabetica';
    3:TSUFs.IndexName := 'FaixaCEP';
    else TSUFs.IndexName := '';
  end;
  TSUFs.Refresh;
  LabNRegs.Caption := IntToStr(TSUFs.RecordCount) + ' registros';
  btNothing.SetFocus;

end;

procedure TFuSiglasUF.FormResize(Sender: TObject);
const wLrg: array[0..8] of real = (0.06, 0.06, 0.33, 0.10, 0.10, 0.10, 0.14, 0.14, 0.06);
begin
  if FuSiglasUF.Width < 480
     then FuSiglasUF.Width := 480;
  if FuSiglasUF.Height < 420
     then FuSiglasUF.Height := 420;
  Grid := DefineGrid(Grid, wLrg, 2, 0);
  StatusBar1.Panels[0].Width := FuSiglasUF.Width div 4;
  StatusBar1.Panels[1].Width := StatusBar1.Panels[0].Width;

end;

procedure TFuSiglasUF.Incluir1Click(Sender: TObject);
begin
  CtleUFs(1,True);
  TSUFs.Append;
  EdIBGE.SetFocus;

end;

procedure TFuSiglasUF.Alterar1Click(Sender: TObject);
begin
  if TSUFs.RecordCount = 0 then Exit;
  if not GenRecordLock(TSUFs,True) then Exit;
  CtleUFs(2,True);
  EdIBGE.SetFocus;

end;

procedure TFuSiglasUF.Excluir1Click(Sender: TObject);
begin
  if TSUFs.RecordCount = 0 then Exit;
  if not GenRecordLock(TSUFs,True) then Exit;
  if MessageDlg('Excluir Estado ?',mtConfirmation,[mbYes,mbNo],0) = mrYes
  then begin
    TSUFs.Delete;
    TSUFs.Refresh;
    LabNRegs.Caption := IntToStr(TSUFs.RecordCount) + ' registros';
  end;
  btNothing.SetFocus;

end;

procedure TFuSiglasUF.BtCancClick(Sender: TObject);
begin
  TSUFs.Cancel;
  CtleUFs(3,False);

end;

procedure TFuSiglasUF.BtOkClick(Sender: TObject);
begin
  Try
    TSUFs.Post;
  Except
    MessageDlg('Duplicidade !' + #13#13 +
               'Verifique Código IBGE, Sigla da UF ou Denominação',mtError,[mbOk],0);
    EdIBGE.SetFocus;
    Exit;
  End;
  CtleUFs(3,False);

end;

procedure TFuSiglasUF.FormShow(Sender: TObject);
begin
  Form_Define(FuSiglasUF);
  FormResize(nil);
  RGOrdem.ItemIndex := 1;
  RGOrdemClick(nil);
  TSUFs.First;
  StatusBar1.Panels[0].Text := 'Operação: Consulta';
  StatusBar1.Panels[1].Text := 'Edição: Desabilitada';

end;

procedure TFuSiglasUF.FormCreate(Sender: TObject);
begin
  LabFCP.Caption  := 'Fundo de combate' + #13 + 'à pobreza';
  ImgShow.Top     := 12;
  ImgShow.Left    := 416;
  ImgShow.Visible := False;
  ImgEdit.Top     := ImgShow.Top;
  ImgEdit.Left    := ImgShow.Left;
  ImgEdit.Visible := True;
  
end;

procedure TFuSiglasUF.TSUFsCalcFields(DataSet: TDataSet);
begin
  if TSUFsDifal.AsBoolean then TSUFsZC_Difal.AsString := 'Sim'
                          else TSUFsZC_Difal.AsString := '';
                          
end;

procedure TFuSiglasUF.GridDblClick(Sender: TObject);
begin
  Try
    TSUFs.Edit;
    if TSUFsDifal.AsBoolean then TSUFsDifal.AsBoolean := False
                            else TSUFsDifal.AsBoolean := True;
    TSUFs.Post;
  Except
    MessageDlg('Registro em uso',mtInformation,[mbOk],0);
  End;

end;

procedure TFuSiglasUF.imgEditClick(Sender: TObject);
begin
  Grid.ReadOnly   := False;
  ImgEdit.Visible := False;
  ImgShow.Visible := True;
  StatusBar1.Panels[1].Text := 'Edição: Habilitada';

end;

procedure TFuSiglasUF.imgShowClick(Sender: TObject);
begin
  Grid.ReadOnly   := True;
  ImgEdit.Visible := True;
  ImgShow.Visible := False;
  StatusBar1.Panels[1].Text := 'Edição: Desabilitada';

end;

procedure TFuSiglasUF.btTamOrigClick(Sender: TObject);
begin
  Form_Centraliza(FuSiglasUF, 640, 630);

end;

end.
