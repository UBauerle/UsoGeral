unit uEnvioSugestoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, RLRichText, StdCtrls;
  Procedure EnviaSugestoes(pArqSugestoes:String; pSistema:String; pUsuario:String);

type
  TFuEnvioSugestoes = class(TForm)
    RLSugestoes: TRLReport;
    RLBand1: TRLBand;
    RLTexto: TRLMemo;
    RLPanel1: TRLPanel;
    RLLabel1: TRLLabel;
    RLLabEmp: TRLLabel;
    RLLabSis: TRLLabel;
    RLLabDTHR: TRLLabel;
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FuEnvioSugestoes: TFuEnvioSugestoes;

implementation

uses uIniGeral, FortesReportCtle, EnviaEMail;


{$R *.dfm}

Procedure EnviaSugestoes(pArqSugestoes:String; pSistema:String; pUsuario:String);
var wFileName: String;
    lstMens: TStringList;
    wDtHr: TDateTime;
begin
  if not FileExists(pArqSugestoes)
  then begin
    MessageDlg('Arquivo [ ' + pArqSugestoes + ' ] não existe', mtInformation,[mbOk],0);
    Exit;
  end;
  if MessageDlg('Imprimir arquivo ' + pArqSugestoes + ' ?',
                mtConfirmation,[mbYes,mbNo],0) = mrYes
  then begin
    wFileName := FuIniGeral.wInicial.PathRelatorios + ExtractFileName(pArqSugestoes);
    wFileName := ChangeFileExt(wFileName, '.PDF');
    FuIniGeral.wInicial.EMNomeDest     := 'Suporte';
    FuIniGeral.wInicial.EMEMailDest    := 'ubauerle@terra.com.br';
    FuIniGeral.wInicial.EMAssunto      := 'ATecnica - Sugestoes e melhorias';
    FuIniGeral.wInicial.EMNome         := 'Suporte';
    FuIniGeral.wInicial.EMAnexo        := wFileName;
    FFortesReportCtle.RLPDFFilter1.FileName := wFileName;
    FuEnvioSugestoes                   := TFuEnvioSugestoes.Create(nil);
    FuEnvioSugestoes.RLLabSis.Caption  := pSistema;
    FuEnvioSugestoes.RLLabEmp.Caption  := pUsuario;
    FuEnvioSugestoes.RLLabDTHR.Caption := DateTimeToStr(Now);
    FuEnvioSugestoes.RLTexto.Lines.LoadFromFile(pArqSugestoes);
    FuEnvioSugestoes.RLSugestoes.Preview;
    FuEnvioSugestoes.Release;
  end
  else begin
    lstMens  := TStringList.Create;
    Envia_Email('ubauerle@terra.com.br','Sugestoes e Melhorias',pArqSugestoes,'Suporte',wDtHr,lstMens);
    lstMens.Free;
  end;
  
end;


end.
