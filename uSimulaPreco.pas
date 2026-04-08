unit uSimulaPreco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, DB, DBClient, DBCtrls, IniFiles,
  ExtCtrls;
  Function SimulaPreco(var vlrUnitar:Real; var vlrVenda:Real; var qtdVenda:Real): Boolean;
  Function SimulaPrecoPos(pLeft,pTop:Integer;
                          var vlrUnitar:Real; var vlrVenda:Real; var qtdVenda:Real): Boolean;

type
  TFuSimulaPreco = class(TForm)
    CDS: TClientDataSet;
    CDSvlrUnit: TCurrencyField;
    CDSvlrTotal: TCurrencyField;
    CDSqtdDisp: TFloatField;
    SCDS: TDataSource;
    Panel1: TPanel;
    btCancelar: TBitBtn;
    btSair: TBitBtn;
    Panel2: TPanel;
    Label3: TLabel;
    edQuant: TDBEdit;
    edValor: TDBEdit;
    Label2: TLabel;
    Label1: TLabel;
    edVlrUnit: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btSairClick(Sender: TObject);
    procedure edVlrUnitExit(Sender: TObject);
    procedure edValorExit(Sender: TObject);
    procedure edQuantExit(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuSimulaPreco: TFuSimulaPreco;
  wPathExec: String;
  wArqSimul: String;
  wModoExec: Integer;
  wUnitar,wVenda,wQuant: Real;
  lRetorno: Boolean;

implementation

{$R *.dfm}

Function CriaAbreSimulacao(pArqParam:String): Boolean;
begin
  Result     := False;
  with FuSimulaPreco
  do begin
    CDS.Active  := False;
    CDS.FieldDefs.Clear;
    CDS.FieldDefs.Add('vlrUnit',   ftCurrency);
    CDS.FieldDefs.Add('vlrTotal',  ftCurrency);
    CDS.FieldDefs.Add('qtdDisp',   ftFloat);
    CDS.IndexDefs.Clear;
    CDS.CreateDataSet;
    Try
      CDS.Active := True;
      CDS.Active := False;
      Result        := True;
    Except
      MessageDlg('Não foi possível criar "CDS"',mtError,[mbOk],0);
      Exit;
    End;
    CDS.Active     := True;
    CDS.LogChanges := False;
  end;
  Result := True;

end;


Procedure SalvaTela(pmtForm:TForm);
var wArqForm,wSection,wInfo: String;
    wForm: TIniFile;
begin
  wArqForm     := wPathExec + pmtForm.Name + '.fml';
  if FileExists(wArqForm) then DeleteFile(wArqForm);
  wForm        := TIniFile.Create(wArqForm);
  wSection     := pmtForm.Name;
  if pmtForm.Align = alClient
     then wInfo := 'alClient'
     else wInfo := 'alNone';
  wForm.WriteString(wSection, 'Align',  wInfo);
  wForm.WriteInteger(wSection,'Top',    pmtForm.Top);
  wForm.WriteInteger(wSection,'Left',   pmtForm.Left);
  wForm.WriteInteger(wSection,'Width',  pmtForm.Width);
  wForm.WriteInteger(wSection,'Height', pmtForm.Height);
  wForm.Free;

end;


Procedure DefineTela(pmtForm:TForm);
var wArqForm,wSection,wInfo: String;
    wForm: TIniFile;
begin
  wArqForm     := wPathExec + pmtForm.Name + '.fml';
  wForm        := TIniFile.Create(wArqForm);
  if not FileExists(wArqForm)
  then begin
    wForm.WriteString(wSection, 'Align',  'alNone');
    wForm.WriteInteger(wSection,'Top',    140);
    wForm.WriteInteger(wSection,'Left',   230);
    wForm.WriteInteger(wSection,'Width',  269);
    wForm.WriteInteger(wSection,'Height', 223);
  end;
  wSection         := pmtForm.Name;
  wInfo            := wForm.ReadString(wSection, 'Align',  'alNone');
  pmtForm.Position := poDesigned;
  pmtForm.Align    := alNone;
  pmtForm.Top      := wForm.ReadInteger(wSection,'Top',    140);
  pmtForm.Left     := wForm.ReadInteger(wSection,'Left',   230);
  pmtForm.Width    := wForm.ReadInteger(wSection,'Width',  269);
  pmtForm.Height   := wForm.ReadInteger(wSection,'Height', 223);
  wForm.Free;

end;


Function SimulaPreco(var vlrUnitar:Real; var vlrVenda:Real; var qtdVenda:Real): Boolean;
begin
  lRetorno      := False;
  FuSimulaPreco := TFuSimulaPreco.Create(nil);
  //DefineTela(FuSimulaPreco);
  wUnitar       := vlrUnitar;
  wVenda        := vlrVenda;
  wQuant        := qtdVenda;
  wModoExec     := 0;
  FuSimulaPreco.btCancelar.Visible := False;
  FuSimulaPreco.btSair.Left        := 132;
  FuSimulaPreco.ShowModal;
  vlrUnitar     := wUnitar;
  vlrVenda      := wVenda;
  qtdVenda      := wQuant;
  //SalvaTela(FuSimulaPreco);
  FuSimulaPreco.Free;
  Result        := lRetorno;

end;


Function SimulaPrecoPos(pLeft,pTop:Integer;
                        var vlrUnitar:Real; var vlrVenda:Real; var qtdVenda:Real): Boolean;
begin
  lRetorno            := False;
  FuSimulaPreco       := TFuSimulaPreco.Create(nil);
  FuSimulaPreco.Color := clSkyBlue;
  FuSimulaPreco.Left  := pLeft;
  FuSimulapreco.Top   := pTop;
  wUnitar             := vlrUnitar;
  wVenda              := vlrVenda;
  wQuant              := qtdVenda;
  wModoExec           := 1;
  FuSimulaPreco.btSair.Caption    := '&Adotar';
  FuSimulaPreco.btSair.Left       := 8;
  FuSimulaPreco.btCancelar.Left   := 132;
  FuSimulaPreco.edVlrUnit.Enabled := False;
  FuSimulaPreco.ShowModal;
  vlrUnitar           := wUnitar;
  vlrVenda            := wVenda;
  qtdVenda            := wQuant;
  FuSimulaPreco.Free;
  Result              := lRetorno;

end;


procedure TFuSimulaPreco.FormShow(Sender: TObject);
begin
  wPathExec := ExtractFilePath(Application.ExeName);
  wArqSimul := ExtractFilePath(Application.ExeName) + 'Simulacao.XML';
  if not CriaAbreSimulacao(wArqSimul)
  then begin
    btSair.SetFocus;
    Exit;
  end;
  CDS.Append;
  CDSvlrUnit.AsFloat  := wUnitar;
  CDSvlrTotal.AsFloat := wVenda;
  CDSqtdDisp.AsFloat  := wQuant;
  CDS.Post;
  CDS.Edit;
  if wModoExec = 0
     then edVlrUnit.SetFocus
     else edValor.SetFocus;

end;

procedure TFuSimulaPreco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CDS.Cancel;
  CDS.Active := False;

end;

procedure TFuSimulaPreco.btSairClick(Sender: TObject);
begin
  wUnitar  := CDSvlrUnit.AsFloat;
  wVenda   := CDSvlrTotal.AsFloat;
  wQuant   := CDSqtdDisp.AsFloat;
  lRetorno := True;
  FuSimulaPreco.Close;

end;

procedure TFuSimulaPreco.edVlrUnitExit(Sender: TObject);
begin
  if CDS.State <> dsEdit
     then Exit;

end;

procedure TFuSimulaPreco.edValorExit(Sender: TObject);
begin
  if CDS.State <> dsEdit
     then Exit;
  if CDSvlrUnit.AsFloat <= 0
  then begin
    CDSvlrTotal.Clear;
    CDSqtdDisp.Clear;
  end;
  if CDSvlrTotal.AsCurrency > 0
     then CDSqtdDisp.AsFloat := CDSvlrTotal.AsCurrency / CDSvlrUnit.AsCurrency
     else CDSqtdDisp.AsFloat := 0;

end;

procedure TFuSimulaPreco.edQuantExit(Sender: TObject);
begin
  if CDS.State <> dsEdit
     then Exit;
  if CDSvlrUnit.AsFloat <= 0
  then begin
    CDSvlrTotal.Clear;
    CDSqtdDisp.Clear;
  end;
  if CDSqtdDisp.AsCurrency > 0
     then CDSvlrTotal.AsCurrency := CDSvlrUnit.AsCurrency * CDSqtdDisp.AsFloat
     else CDSvlrTotal.AsCurrency := 0;

end;

procedure TFuSimulaPreco.btCancelarClick(Sender: TObject);
begin
  wUnitar  := CDSvlrUnit.AsFloat;
  wVenda   := CDSvlrTotal.AsFloat;
  wQuant   := CDSqtdDisp.AsFloat;
  lRetorno := False;
  FuSimulaPreco.Close;

end;

end.
