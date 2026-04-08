unit uImagens;

interface

uses
  SysUtils, Classes, Controls, Forms, Dialogs,
  Db, DBTables, ExtCtrls, StdCtrls, FileCtrl, Tabnotbk, Buttons,
  DBCtrls, ComCtrls, Graphics, Mask;
  Procedure ImagensLogotipos;

type
  TFuImagens = class(TForm)
    Panel3: TPanel;
    BtSaveExit: TBitBtn;
    BtCancExit: TBitBtn;
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
    TabNB: TTabbedNotebook;
    PanTN0: TPanel;
    Label6: TLabel;
    DBText0: TDBText;
    Label15: TLabel;
    Img0: TDBImage;
    PanTN1: TPanel;
    PanTN2: TPanel;
    Label9: TLabel;
    DBText2: TDBText;
    Label18: TLabel;
    Img2: TDBImage;
    Panel7: TPanel;
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
    EmpFil: TTable;
    DbTextEmpresa: TDBText;
    EmpFilAbrev: TStringField;
    EmpFilCod: TSmallintField;
    EmpFilDenom: TStringField;
    EmpFilExibeAll: TStringField;
    SEmpFil: TDataSource;
    BtPrior: TBitBtn;
    BtNext: TBitBtn;
    Label7: TLabel;
    Img1: TDBImage;
    Label8: TLabel;
    DBText1: TDBText;
    PanTN3: TPanel;
    Panel4: TPanel;
    Label20: TLabel;
    Img3: TDBImage;
    Label19: TLabel;
    DBText3: TDBText;
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
    procedure FormActivate(Sender: TObject);
    procedure BtSaveExitClick(Sender: TObject);
    procedure BtCancExitClick(Sender: TObject);
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
    procedure TabNBChange(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
    procedure Img4_1DblClick(Sender: TObject);
    procedure Img4_2DblClick(Sender: TObject);
    procedure Img4_3DblClick(Sender: TObject);
    procedure Img2DblClick(Sender: TObject);
    procedure EmpFilCalcFields(DataSet: TDataSet);
    procedure BtPriorClick(Sender: TObject);
    procedure BtNextClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuImagens: TFuImagens;
  ArqFigura,Diretorio: String;
  Figura: TBitMap;
  PgAtu,NrEtq,NrDup: Integer;

implementation

uses uMensagem, uIniGeral;

{$R *.DFM}

Procedure ImagensLogotipos;
begin
  FuImagens   := TFuImagens.Create(nil);
  with FuImagens
  do begin
    EmpFil.DatabaseName := FuIniGeral.wInicial.DatabaseName;
    Imag.DatabaseName   := FuIniGeral.wInicial.DatabaseName;
    ShowModal;
    Free;
  end;

end;


procedure VerifImag(NFil:Integer);
begin
  with FuImagens
  do begin
    if not Imag.FindKey([NFil])
    then begin
      Imag.Append;
      ImagEmpFil.AsInteger := NFil;
      ImagDupSt.AsBoolean := False;
      ImagOSSt.AsBoolean := False;
      ImagEtiq1St.AsBoolean := False;
      ImagEtiq2St.AsBoolean := False;
      ImagEtiq3St.AsBoolean := False;
      ImagOrcSt.AsBoolean := False;
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
  end;

end;

Function Salvar: Boolean;
begin
  with FuImagens
  do begin
    Try
      Imag.Post;
      Result := True;
    Except
      Imag.Cancel;
      Result := False;
      msgSistema(4,'Figura inválida',
                  'As figuras indicadas devem ser formato BMP' + #13 +
                  'e de 16 ou 256 cores, selecione outra', 1, 1);
    End;
    Imag.Edit;
  end;

end;

procedure TFuImagens.FormActivate(Sender: TObject);
begin
  EmpFil.Active := True;
  Imag.Active := True;
  VerifImag(EmpFilCod.AsInteger);
  TabNB.PageIndex := 0;
  BtCancExit.Caption := '&Cancelar && Sair';
  PanEtq1.Color := clBtnFace;
  PanEtq2.Color := clBtnFace;
  PanEtq3.Color := clBtnFace;
  NrEtq := 0;

end;

procedure TFuImagens.Img0DblClick(Sender: TObject);
begin
  if Img0.Stretch then Img0.Stretch := False
                  else Img0.Stretch := True;
  ImagInicialSt.AsBoolean := Img0.Stretch;

end;

procedure TFuImagens.BtSaveExitClick(Sender: TObject);
begin
  Salvar;
  FuImagens.Close;

end;

procedure TFuImagens.BtCancExitClick(Sender: TObject);
begin
  Imag.Cancel;
  FuImagens.Close;

end;

procedure TFuImagens.Img1DblClick(Sender: TObject);
begin
  if Img1.Stretch then Img1.Stretch := False
                  else Img1.Stretch := True;
  ImagDupSt.AsBoolean := Img1.Stretch;

end;

procedure TFuImagens.Img3DblClick(Sender: TObject);
begin
  if Img3.Stretch then Img3.Stretch := False
                  else Img3.Stretch := True;
  ImagOrcSt.AsBoolean := Img3.Stretch;

end;

procedure TFuImagens.ImagCalcFields(DataSet: TDataSet);
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

procedure TFuImagens.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Imag.Active := False;
  EmpFil.Active := False;

end;

procedure TFuImagens.FormCreate(Sender: TObject);
begin
  TabNB.PageIndex := 0;
  NrEtq := 0;
  Drive.Drive := 'C';
  Diretorio := Drive.Drive + ':\';
  Diret.Directory := Diretorio;
  
end;

procedure TFuImagens.ListaDblClick(Sender: TObject);
begin
  PgAtu := TabNb.PageIndex;
  ArqFigura := Lista.FileName;
  Figura := TBitmap.Create;
  Figura.LoadFromFile(ArqFigura);
  case PgAtu of
    0:begin
        ImagInicial.Assign(Figura);
        Img0.Stretch := ImagInicialSt.AsBoolean;
      end;
    1:begin
        ImagDup.Assign(Figura);
        Img1.Stretch := ImagDupSt.AsBoolean;
      end;
    2:begin
        ImagOS.Assign(Figura);
        Img2.Stretch := ImagOSSt.AsBoolean;
      end;
    3:begin
        ImagOrc.Assign(Figura);
        Img3.Stretch := ImagOrcSt.AsBoolean;
      end;
    4:begin
        case NrEtq of
          1:begin
              ImagEtiq1.Assign(Figura);
              Img4_1.Stretch := ImagEtiq1St.AsBoolean;
            end;
          2:begin
              ImagEtiq2.Assign(Figura);
              Img4_2.Stretch := ImagEtiq2St.AsBoolean;
            end;
          3:begin
              ImagEtiq3.Assign(Figura);
              Img4_3.Stretch := ImagEtiq3St.AsBoolean;
            end;
          else msgSistema(4,'Seleção','Nenhuma etiqueta selecionada',1,1);
        end;
      end;
  end;
  Figura.Free;

end;

procedure TFuImagens.DriveEnter(Sender: TObject);
begin
  PgAtu := TabNb.PageIndex;

end;

procedure TFuImagens.Bt1Click(Sender: TObject);
begin
  NrEtq := 1;
  PanEtq1.Color := clSilver;
  PanEtq2.Color := clBtnFace;
  PanEtq3.Color := clBtnFace;
  Drive.SetFocus;

end;

procedure TFuImagens.Bt2Click(Sender: TObject);
begin
  NrEtq := 2;
  PanEtq1.Color := clBtnFace;
  PanEtq2.Color := clSilver;
  PanEtq3.Color := clBtnFace;
  Drive.SetFocus;

end;

procedure TFuImagens.Bt3Click(Sender: TObject);
begin
  NrEtq := 3;
  PanEtq1.Color := clBtnFace;
  PanEtq2.Color := clBtnFace;
  PanEtq3.Color := clSilver;
  Drive.SetFocus;

end;

procedure TFuImagens.TabNBChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  NrEtq := 0;
  PanEtq1.Color := clBtnFace;
  PanEtq2.Color := clBtnFace;
  PanEtq3.Color := clBtnFace;

end;

procedure TFuImagens.Img4_1DblClick(Sender: TObject);
begin
  if Img4_1.Stretch then Img4_1.Stretch := False
                    else Img4_1.Stretch := True;
  ImagEtiq1St.AsBoolean := Img4_1.Stretch;

end;

procedure TFuImagens.Img4_2DblClick(Sender: TObject);
begin
  if Img4_2.Stretch then Img4_2.Stretch := False
                    else Img4_2.Stretch := True;
  ImagEtiq2St.AsBoolean := Img4_2.Stretch;

end;

procedure TFuImagens.Img4_3DblClick(Sender: TObject);
begin
  if Img4_3.Stretch then Img4_3.Stretch := False
                    else Img4_3.Stretch := True;
  ImagEtiq3St.AsBoolean := Img4_3.Stretch;

end;

procedure TFuImagens.Img2DblClick(Sender: TObject);
begin
  if Img2.Stretch then Img2.Stretch := False
                  else Img2.Stretch := True;
  ImagOSSt.AsBoolean := Img2.Stretch;

end;

procedure TFuImagens.EmpFilCalcFields(DataSet: TDataSet);
begin
  EmpFilExibeAll.AsString := EmpFilCod.AsString + ' - ' +
                             Trim(EmpFilDenom.AsString) + '  ( ' +
                             Trim(EmpFilAbrev.AsString) + ' )';
  
end;

procedure TFuImagens.BtPriorClick(Sender: TObject);
begin
  BtNext.Enabled := True;
  if Salvar
  then begin
    EmpFil.Prior;
    if EmpFil.Bof then BtPrior.Enabled := False;
    VerifImag(EmpFilCod.AsInteger);
  end;

end;

procedure TFuImagens.BtNextClick(Sender: TObject);
begin
  BtPrior.Enabled := true;
  if Salvar
  then begin
    EmpFil.Next;
    if EmpFil.Eof then BtNext.Enabled := False;
    VerifImag(EmpFilCod.AsInteger);
  end;
  
end;

end.
