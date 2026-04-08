unit uArqMaster;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, DBCtrls, ExtCtrls, Db, DBTables, FileCtrl;

type
  TFuArqMaster = class(TForm)
    Master: TTable;
    SMaster: TDataSource;
    MasterEmpresa: TStringField;
    MasterFantasia: TStringField;
    MasterCGC: TStringField;
    MasterInscEst: TStringField;
    MasterUF: TStringField;
    MasterDtValid: TDateField;
    MasterAlgor: TIntegerField;
    MasterSerial: TStringField;
    panRodape: TPanel;
    btGravar: TBitBtn;
    btCancelar: TBitBtn;
    gbUsuario: TGroupBox;
    Label3: TLabel;
    EdRSoc: TDBEdit;
    Label4: TLabel;
    EdFant: TDBEdit;
    Label5: TLabel;
    EdCGC: TDBEdit;
    Label7: TLabel;
    EdUF: TDBEdit;
    Label6: TLabel;
    EDIest: TDBEdit;
    Label2: TLabel;
    EdSer: TDBEdit;
    Label1: TLabel;
    procedure btGravarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
   FuArqMaster: TFuArqMaster;
   WValid: TDateTime;
   Algor: Integer;

implementation

{$R *.DFM}

//Function VerifSerial(Serial:ShortString):Boolean; Stdcall; External 'RotSeguranca.DLL';
//Function ValidadeSerial(Serial:ShortString):TDateTime; Stdcall; External 'RotSeguranca.DLL';
//Function CalcAlgor(Empresa,Fantasia,CGC,IEst:ShortString;DtVal:TDateTime):Integer; Stdcall; External 'RotSeguranca.DLL';

//Function CritCGC(CGC:ShortString):Boolean; Stdcall; External 'RotGenericas.DLL';
//Function CritUF(UF:ShortString):Boolean; Stdcall; External 'RotGenericas.DLL';
//Function ValidIEst(XInscr,XUf:ShortString):Integer; Stdcall; External 'RotGenericas.DLL';


procedure TFuArqMaster.btGravarClick(Sender: TObject);
var Msg: String;
begin
  Msg := '';
  if Length(Trim(MasterEmpresa.AsString)) = 0 then Msg := Msg + 'Razão social' + #13;
  if Length(Trim(MasterFantasia.AsString)) = 0 then Msg := Msg + 'Fantasia' + #13;
  if Length(Trim(MasterCGC.AsString)) > 0
  then if not CritCGC(MasterCGC.AsString) then Msg := Msg + 'CGC Inválido' + #13;
  if not CritUF(MasterUF.AsString) then Msg := Msg + 'Sigla UF inválida' + #13;
  if Length(Trim(MasterInscEst.AsString)) > 0
  then if ValidIEst(Trim(MasterInscEst.AsString),MasterUF.AsString) <> 0
       then Msg := Msg + 'Sigla UF / Inscrição estadual' + #13;
  if not VerifSerial(Trim(MasterSerial.AsString)) then Msg := Msg + 'Serial INVÁLIDO' + #13;

  if Length(Msg) > 0
  then begin
    MessageDlg('Erros detectados' + #13 + Msg + 'Reinforme...',mtError,[mbOK],0);
    EdRSoc.SetFocus;
    Exit;
  end;
  WValid := ValidadeSerial(MasterSerial.AsString);
  Algor := CalcAlgor(MasterEmpresa.AsString,MasterFantasia.AsString,
                     MasterCGC.AsString,MasterInscEst.AsString,WValid);
  MasterDtValid.AsDateTime := WValid;
  MasterAlgor.AsInteger := Algor;
  Master.Post;
  FISDLL.Close;

end;

procedure TFuArqMaster.btCancelarClick(Sender: TObject);
begin
  Master.Cancel;
  FISDLL.Close;
  
end;

procedure TFuArqMaster.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Master.Active := False;

end;

procedure TFuArqMaster.FormActivate(Sender: TObject);
begin
  Master.Active := True;
  if Master.RecordCount = 0 then Master.Append
                            else Master.Edit;
  EdRSoc.SetFocus;

end;

end.
