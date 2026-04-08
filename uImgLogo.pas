unit uImgLogo;

interface

uses
  SysUtils, Classes, Controls, Forms, Dialogs, Db, DBTables, ExtCtrls, StdCtrls, FileCtrl, Buttons,
  DBCtrls, ComCtrls, Mask, Windows, Graphics;
  Procedure ManutencaoImagensLogotipos(pmtDBName: String);

type
  TFImgLogo = class(TForm)
    Imag: TTable;
    SImag: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    Drive: TDriveComboBox;
    Diret: TDirectoryListBox;
    Lista: TFileListBox;
    Label2: TLabel;
    Label4: TLabel;
    Label11: TLabel;
    Panel5: TPanel;
    EmpFil: TTable;
    EmpFilAbrev: TStringField;
    EmpFilCod: TSmallintField;
    EmpFilDenom: TStringField;
    EmpFilExibeAll: TStringField;
    SEmpFil: TDataSource;
    ImagEmpFil: TSmallintField;
    ImagInicial: TGraphicField;
    ImagInicialSt: TBooleanField;
    ImagDup: TGraphicField;
    ImagDupSt: TBooleanField;
    ImagOS: TGraphicField;
    ImagOSSt: TBooleanField;
    ImagEtiq1: TGraphicField;
    ImagEtiq1St: TBooleanField;
    ImagEtiq2: TGraphicField;
    ImagEtiq2St: TBooleanField;
    ImagEtiq3: TGraphicField;
    ImagEtiq3St: TBooleanField;
    ImagOrc: TGraphicField;
    ImagOrcSt: TBooleanField;
    ImagOrcStEx: TStringField;
    ImagDupStEx: TStringField;
    ImagEtiq1StEx: TStringField;
    ImagEtiq2StEx: TStringField;
    ImagEtiq3StEx: TStringField;
    ImagOSStEx: TStringField;
    ImagDST2Ex: TStringField;
    ImagInicialStEx: TStringField;
    PageControl1: TPageControl;
    TSImgInicial: TTabSheet;
    Label15: TLabel;
    Img0: TDBImage;
    Label6: TLabel;
    DBText0: TDBText;
    TSDuplicata: TTabSheet;
    Label7: TLabel;
    Img1: TDBImage;
    Label8: TLabel;
    DBText1: TDBText;
    TSOrdemServico: TTabSheet;
    Label18: TLabel;
    Img2: TDBImage;
    Label9: TLabel;
    DBText2: TDBText;
    TSOrcamento: TTabSheet;
    Label20: TLabel;
    Img3: TDBImage;
    Label19: TLabel;
    DBText3: TDBText;
    TSEtiquetas: TTabSheet;
    PanEtq1: TPanel;
    Label3: TLabel;
    Label12: TLabel;
    DBText5: TDBText;
    Img4_1: TDBImage;
    Bt1: TBitBtn;
    PanEtq2: TPanel;
    Label5: TLabel;
    Label13: TLabel;
    DBText6: TDBText;
    Img4_2: TDBImage;
    Bt2: TBitBtn;
    PanEtq3: TPanel;
    Label10: TLabel;
    Label14: TLabel;
    DBText7: TDBText;
    Img4_3: TDBImage;
    Bt3: TBitBtn;
    Panel2: TPanel;
    btFinalizar: TBitBtn;
    Panel3: TPanel;
    DbTextEmpresa: TDBText;
    btPrior: TBitBtn;
    btNext: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure btFinalizarClick(Sender: TObject);
    procedure Img0DblClick(Sender: TObject);
    procedure Img1DblClick(Sender: TObject);
    procedure Img3DblClick(Sender: TObject);
    procedure ImagCalcFields(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ListaDblClick(Sender: TObject);
    procedure DriveEnter(Sender: TObject);
    procedure Bt1Click(Sender: TObject);
    procedure Bt2Click(Sender: TObject);
    procedure Bt3Click(Sender: TObject);
    procedure Img4_1DblClick(Sender: TObject);
    procedure Img4_2DblClick(Sender: TObject);
    procedure Img4_3DblClick(Sender: TObject);
    procedure Img2DblClick(Sender: TObject);
    procedure EmpFilCalcFields(DataSet: TDataSet);
    procedure btPriorClick(Sender: TObject);
    procedure btNextClick(Sender: TObject);
    procedure Img0KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FImgLogo: TFImgLogo;
  ArqFigura,Diretorio: String;
  PgAtu,NrEtq,NrDup: Integer;

implementation

uses uMensagem;

{$R *.DFM}

Procedure ManutencaoImagensLogotipos(pmtDBName: String);
begin
  FImgLogo := TFImgLogo.Create(nil);
  FImgLogo.Imag.DatabaseName := pmtDBName;
  FImgLogo.EmpFil.DatabaseName := pmtDBName;
  FImgLogo.ShowModal;
  FImgLogo.Release;

end;


procedure CarregaImagens(pmtFil:Integer);
begin
  with FImgLogo
  do begin
    if not Imag.FindKey([pmtFil])
    then begin
      Imag.Append;
      ImagEmpFil.AsInteger  := pmtFil;
      ImagDupSt.AsBoolean   := False;
      ImagOSSt.AsBoolean    := False;
      ImagEtiq1St.AsBoolean := False;
      ImagEtiq2St.AsBoolean := False;
      ImagEtiq3St.AsBoolean := False;
      ImagOrcSt.AsBoolean   := False;
      Imag.Post;
    end;
    Imag.Edit;
    Img0.Stretch := ImagInicialSt.AsBoolean;
    Img1.Stretch := ImagDupSt.AsBoolean;
    Img2.Stretch := ImagOSSt.AsBoolean;
    Img3.Stretch := ImagOrcSt.AsBoolean;
    Img4_1.Stretch := ImagEtiq1St.AsBoolean;
    Img4_2.Stretch := ImagEtiq2St.AsBoolean;
    Img4_3.Stretch := ImagEtiq3St.AsBoolean;
    //
    PageControl1.ActivePageIndex := 0;
    PanEtq1.Color := clBtnFace;
    PanEtq2.Color := clBtnFace;
    PanEtq3.Color := clBtnFace;
    NrEtq := 0;
  end;

end;

Function SalvaImagens: Boolean;
begin
  with FImgLogo
  do begin
    Try
      Imag.Post;
      Result := True;
    Except
      Imag.Cancel;
      Result := False;
      msgSistema(4,'Figura inválida',
                  'As figuras indicadas devem ser formato BMP' + #13 +
                  'e de 16 ou 256 cores, selecione outra imagem', 1, 1);
    End;
    Imag.Edit;
  end;

end;

procedure TFImgLogo.FormActivate(Sender: TObject);
begin
  Imag.Active := True;
  EmpFil.Active := True;
  btPrior.Enabled := False;
  btNext.Enabled  := False;
  if EmpFil.RecordCount > 1
  then begin
    btPrior.Enabled := True;
    btNext.Enabled  := True;
  end;
  EmpFil.First;
  CarregaImagens(EmpFilCod.AsInteger);

end;

procedure TFImgLogo.Img0DblClick(Sender: TObject);
begin
  if Img0.Stretch then Img0.Stretch := False
                  else Img0.Stretch := True;
  ImagInicialSt.AsBoolean := Img0.Stretch;

end;

procedure TFImgLogo.btFinalizarClick(Sender: TObject);
begin
  SalvaImagens;
  FImgLogo.Close;

end;

procedure TFImgLogo.Img1DblClick(Sender: TObject);
begin
  if Img1.Stretch then Img1.Stretch := False
                  else Img1.Stretch := True;
  ImagDupSt.AsBoolean := Img1.Stretch;

end;

procedure TFImgLogo.Img3DblClick(Sender: TObject);
begin
  if Img3.Stretch then Img3.Stretch := False
                  else Img3.Stretch := True;
  ImagOrcSt.AsBoolean := Img3.Stretch;

end;

procedure TFImgLogo.ImagCalcFields(DataSet: TDataSet);
begin
  if ImagInicialSt.AsBoolean then ImagInicialStEx.AsString := 'Dimensionado'
                             else ImagInicialStEx.AsString := 'Normal';
  if ImagDupSt.AsBoolean then ImagDupStEx.AsString := 'Dimensionado'
                         else ImagDupStEx.AsString := 'Normal';
  if ImagOSSt.AsBoolean then ImagOSStEx.AsString := 'Dimensionado'
                        else ImagOSStEx.AsString := 'Normal';
  if ImagOrcSt.AsBoolean then ImagOrcStEx.AsString := 'Dimensionado'
                         else ImagOrcStEx.AsString := 'Normal';
  if ImagEtiq1St.AsBoolean then ImagEtiq1StEx.AsString := 'Dimensionado'
                           else ImagEtiq1StEx.AsString := 'Normal';
  if ImagEtiq2St.AsBoolean then ImagEtiq2StEx.AsString := 'Dimensionado'
                           else ImagEtiq2StEx.AsString := 'Normal';
  if ImagEtiq3St.AsBoolean then ImagEtiq3StEx.AsString := 'Dimensionado'
                           else ImagEtiq3StEx.AsString := 'Normal';

end;

procedure TFImgLogo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Imag.Active := False;
  EmpFil.Active := False;

end;

procedure TFImgLogo.FormCreate(Sender: TObject);
begin
  NrEtq := 0;
  Drive.Drive := 'C';
  Diretorio := Drive.Drive + ':\';
  Diret.Directory := Diretorio;

end;

procedure TFImgLogo.ListaDblClick(Sender: TObject);
var wFigura: TPicture;
begin
  PgAtu := PageControl1.ActivePageIndex;
  ArqFigura := Lista.FileName;
  wFigura := TPicture.Create;
  wFigura.LoadFromFile(ArqFigura);
  case PgAtu of
    0:begin
        ImagInicial.Assign(wFigura);
        Img0.Stretch := ImagInicialSt.AsBoolean;
      end;
    1:begin
        ImagDup.Assign(wFigura);
        Img1.Stretch := ImagDupSt.AsBoolean;
      end;
    2:begin
        ImagOS.Assign(wFigura);
        Img2.Stretch := ImagOSSt.AsBoolean;
      end;
    3:begin
        ImagOrc.Assign(wFigura);
        Img3.Stretch := ImagOrcSt.AsBoolean;
      end;
    4:begin
        case NrEtq of
          1:begin
              ImagEtiq1.Assign(wFigura);
              Img4_1.Stretch := ImagEtiq1St.AsBoolean;
            end;
          2:begin
              ImagEtiq2.Assign(wFigura);
              Img4_2.Stretch := ImagEtiq2St.AsBoolean;
            end;
          3:begin
              ImagEtiq3.Assign(wFigura);
              Img4_3.Stretch := ImagEtiq3St.AsBoolean;
            end;
          else msgSistema(4,'Seleção','Nenhuma etiqueta selecionada',1,1);
        end;
      end;
  end;
  wFigura.Free;

end;

procedure TFImgLogo.DriveEnter(Sender: TObject);
begin
  PgAtu := PageControl1.ActivePageIndex;

end;

procedure TFImgLogo.Bt1Click(Sender: TObject);
begin
  NrEtq := 1;
  PanEtq1.Color := clSilver;
  PanEtq2.Color := clBtnFace;
  PanEtq3.Color := clBtnFace;
  Drive.SetFocus;

end;

procedure TFImgLogo.Bt2Click(Sender: TObject);
begin
  NrEtq := 2;
  PanEtq1.Color := clBtnFace;
  PanEtq2.Color := clSilver;
  PanEtq3.Color := clBtnFace;
  Drive.SetFocus;

end;

procedure TFImgLogo.Bt3Click(Sender: TObject);
begin
  NrEtq := 3;
  PanEtq1.Color := clBtnFace;
  PanEtq2.Color := clBtnFace;
  PanEtq3.Color := clSilver;
  Drive.SetFocus;

end;

procedure TFImgLogo.Img4_1DblClick(Sender: TObject);
begin
  if Img4_1.Stretch then Img4_1.Stretch := False
                    else Img4_1.Stretch := True;
  ImagEtiq1St.AsBoolean := Img4_1.Stretch;

end;

procedure TFImgLogo.Img4_2DblClick(Sender: TObject);
begin
  if Img4_2.Stretch then Img4_2.Stretch := False
                    else Img4_2.Stretch := True;
  ImagEtiq2St.AsBoolean := Img4_2.Stretch;

end;

procedure TFImgLogo.Img4_3DblClick(Sender: TObject);
begin
  if Img4_3.Stretch then Img4_3.Stretch := False
                    else Img4_3.Stretch := True;
  ImagEtiq3St.AsBoolean := Img4_3.Stretch;

end;

procedure TFImgLogo.Img2DblClick(Sender: TObject);
begin
  if Img2.Stretch then Img2.Stretch := False
                  else Img2.Stretch := True;
  ImagOSSt.AsBoolean := Img2.Stretch;

end;

procedure TFImgLogo.EmpFilCalcFields(DataSet: TDataSet);
begin
  EmpFilExibeAll.AsString := EmpFilCod.AsString + ' - ' +
                             Trim(EmpFilDenom.AsString) + '  ( ' +
                             Trim(EmpFilAbrev.AsString) + ' )';
  
end;

procedure TFImgLogo.btPriorClick(Sender: TObject);
begin
  if not SalvaImagens then Exit;
  btPrior.Enabled := True;
  btNext.Enabled  := True;
  EmpFil.Prior;
  if EmpFil.Bof
    then btPrior.Enabled := False;
  CarregaImagens(EmpFilCod.AsInteger);

end;

procedure TFImgLogo.btNextClick(Sender: TObject);
begin
  if not SalvaImagens then Exit;
  btPrior.Enabled := True;
  btNext.Enabled  := True;
  EmpFil.Next;
  if EmpFil.Eof
     then btNext.Enabled := False;
  CarregaImagens(EmpFilCod.AsInteger);

end;

procedure TFImgLogo.Img0KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if msgSistema(3,'Imagem','Confirme exclusão da imagem',3,2) <> 1
     then Exit;
  if Key = VK_Delete then ImagInicial.Clear;


end;

end.
