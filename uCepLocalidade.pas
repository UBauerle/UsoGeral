unit uCepLocalidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, DBCtrls, ExtCtrls, Grids, DBGrids,
  Buttons;
  Function CepPorLocalidade(pmtDataBase:String;
                            var rCEP: String;
                            var rMunic: String;
                            var rUF: String;
                            var rUFIBGE: Integer;
                            var rMunIBGE: Integer): Boolean;
  Function ObtemCepLocalidade(pmtDataBase:String;
                              pmtCEP: String;
                              var rMunic: String;
                              var rUF: String;
                              var rUFIBGE: Integer;
                              var rMunIBGE: Integer): Boolean;

type
  TFuCepLocalidade = class(TForm)
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
    CidadesZC_CEP: TStringField;
    SCidades: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    Nav: TDBNavigator;
    Localizar: TLabel;
    Label1: TLabel;
    edtUF: TEdit;
    edtLocalidade: TEdit;
    Grid: TDBGrid;
    cbSelect: TCheckBox;
    btUtiliz: TBitBtn;
    btCancel: TBitBtn;
    Label2: TLabel;
    procedure CidadesCalcFields(DataSet: TDataSet);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtLocalidadeChange(Sender: TObject);
    procedure CidadesFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure edtUFChange(Sender: TObject);
    procedure cbSelectClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btUtilizClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FuCepLocalidade: TFuCepLocalidade;
  retCEP,retLocalidade,retUF: String;
  retUFIBGE,retMunIBGE: Integer;


implementation

uses uGenericas;

{$R *.dfm}

Function CepPorLocalidade(pmtDataBase:String;
                          var rCEP: String;
                          var rMunic: String;
                          var rUF: String;
                          var rUFIBGE: Integer;
                          var rMunIBGE: Integer): Boolean;
begin
  FuCepLocalidade := TFuCepLocalidade.Create(nil);
  with FuCepLocalidade
  do begin
    Result               := False;
    retCEP               := '';
    retLocalidade        := '';
    retUF                := '';
    retUFIBGE            := 0;
    retMunIBGE           := 0;
    //
    Cidades.DatabaseName := pmtDataBase;
    Cidades.IndexName    := 'Alfabetica';
    Cidades.Filtered     := True;
    cbSelect.Checked     := False;
    Cidades.Active       := True;
    ShowModal;
    cbSelect.Checked     := False;
    Cidades.Active       := False;
    //
    rCEP                 := retCEP;
    rMunic               := retLocalidade;
    rUF                  := retUF;
    rUFIBGE              := retUFIBGE;
    rMunIBGE             := retMunIBGE;
    if Length(Trim(retCEP)) > 0
       then Result       := True;

  end;
  FuCepLocalidade.Free;

end;


Function ObtemCepLocalidade(pmtDataBase:String;
                            pmtCEP: String;
                            var rMunic: String;
                            var rUF: String;
                            var rUFIBGE: Integer;
                            var rMunIBGE: Integer): Boolean;
begin
  FuCepLocalidade := TFuCepLocalidade.Create(nil);
  with FuCepLocalidade
  do begin
    Result               := False;
    rMunic               := '';
    rUF                  := '';
    rUFIBGE              := 0;
    rMunIBGE             := 0;
    Cidades.DatabaseName := pmtDataBase;
    Cidades.IndexName    := 'CodPostal';
    Cidades.Filtered     := False;
    Cidades.Active       := True;
    //
    if Cidades.FindKey([pmtCEP])
    then begin
      rMunic             := CidadesNome.AsString;
      rUF                := CidadesUF.AsString;
      rUFIBGE            := CidadesUFIBGE.AsInteger;
      rMunIBGE           := CidadesCodIBGE.AsInteger;
      Result             := True;
    end
    else MessageDlg('CEP informado [' + Copy(pmtCEP,1,2) + '.' + Copy(pmtCEP,3,3) + '-' + Copy(pmtCEP,6,3) + ' ] não encontrado',mtError,[mbOk],0);
    //
    Cidades.Active       := False;
  end;
  FuCepLocalidade.Free;

end;



procedure TFuCepLocalidade.CidadesCalcFields(DataSet: TDataSet);
begin
  CidadesZC_CEP.AsString := Copy(CidadesCEP.AsString,1,2) + '.' + Copy(CidadesCEP.AsString,3,3) + '-' + Copy(CidadesCEP.AsString,6,3);

end;

procedure TFuCepLocalidade.FormResize(Sender: TObject);
const wLrg: array[0..2] of Real = (0.33, 0.05, 0.15);
begin
  if FuCepLocalidade.Width < 600
     then FuCepLocalidade.Width := 600;
  if FuCepLocalidade.Height < 500
     then FuCepLocalidade.Height := 500;
  Grid := DefineGrid(Grid, wLrg, 0, 0);

end;

procedure TFuCepLocalidade.FormShow(Sender: TObject);
begin
  FormResize(nil);
  edtLocalidade.Text := '';
  edtUF.Text         := 'RS';
  edtLocalidade.SetFocus;

end;

procedure TFuCepLocalidade.edtLocalidadeChange(Sender: TObject);
begin
  if cbSelect.Checked
     then Cidades.Refresh
     else Cidades.FindNearest([Trim(edtLocalidade.Text),edtUF.Text]);

end;

procedure TFuCepLocalidade.CidadesFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept := False;
  if (Length(Trim(edtUF.Text)) < 2)
     or (CidadesUF.Text = edtUF.Text)
  then Accept := True
  else Exit;
  //
  if cbSelect.Checked
     and (Length(Trim(edtLocalidade.Text)) > 0)
  then if Pos(edtLocalidade.Text,CidadesNome.AsString) > 0
       then Accept := True
       else Accept := False;

end;

procedure TFuCepLocalidade.edtUFChange(Sender: TObject);
begin
  Cidades.Refresh;
  edtLocalidadeChange(nil);
  if Length(Trim(edtUF.Text)) = 0
     then edtLocalidade.SetFocus;

end;

procedure TFuCepLocalidade.cbSelectClick(Sender: TObject);
begin
  Cidades.Refresh;

end;

procedure TFuCepLocalidade.btCancelClick(Sender: TObject);
begin
  retCEP        := '';
  retLocalidade := '';
  retUF         := '';
  retUFIBGE     := 0;
  retMunIBGE    := 0;
  FuCepLocalidade.Close;

end;

procedure TFuCepLocalidade.btUtilizClick(Sender: TObject);
begin
  if CidadesCEP.AsString = '00000000'
  then begin
    MessageDlg('Localidade selecionada apresenta CEP por logradouro',mtWarning,[mbOk],0);
    btCancel.SetFocus;
    Exit;
  end;
  retCEP        := CidadesCEP.AsString;
  retLocalidade := CidadesNome.AsString;
  retUF         := CidadesUF.AsString;
  retUFIBGE     := CidadesUFIBGE.AsInteger;
  retMunIBGE    := CidadesCodIBGE.AsInteger;
  FuCepLocalidade.Close;

end;


end.
