unit uCEPACbr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles, CheckLst, Buttons;
  Function ACBR_BuscaEnderecoCEP(pmtCEP:String): Boolean;
  Function ACBR_BuscaEnderecoLograd(pmtLograd,pmtBairro,pmtCidade,pmtSiglaUF:String): Boolean;


type
  TFuCEPACBr = class(TForm)
    MemoCmd: TMemo;
    MemoRet: TMemo;
    cbEnderecos: TCheckListBox;
    Label1: TLabel;
    btOk: TBitBtn;
    btCancel: TBitBtn;
    LabTexto: TLabel;
    procedure btCancelClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FuCEPACBr: TFuCEPACBr;
  wUseEnder: Integer;

implementation

uses uGenericas, uMensagem, uIniGeral;

{$R *.dfm}


Function CarregaRetorno: Boolean;
var wDecim,timeDecorr: Integer;
begin
  Result := False;
  wDecim := 0;                             // Decimos de segundo
  timeDecorr := 0;                         // Tempo decorrido
  while timeDecorr < FuIniGeral.wInicial.ACBR_TimeOut
  do begin
    Sleep(100);                            // Espera 1/10 de segundo
    wDecim := wDecim + 1;
    if FileExists(FuIniGeral.wInicial.ACBR_ArqRetorno)
    then begin
      FuCEPACBr.MemoRet.Lines.LoadFromFile(FuIniGeral.wInicial.ACBR_ArqRetorno);
      timeDecorr := FuIniGeral.wInicial.ACBR_TimeOut+2;
      Result := True;
      if FuIniGeral.wInicial.LDebug then ShowMessage('Carregou retorno: ' + FuIniGeral.wInicial.ACBR_ArqRetorno);
    end
    else begin
      if wDecim = 10
      then begin
        wDecim := 0;
        timeDecorr := timeDecorr + 1;
      end;
    end;
  end;

end;


Procedure RetornoCEP;
var wLinha: String;
    i,j,k: Integer;
    wRetName: String;
    wRet: TIniFile;
    xLabel: String;
    wLarg,nEnder: Integer;
    wCEP,wTpLogr,wLogr,wBairro,wMunic,wUF,wIBGE: String;
begin
  if FuIniGeral.wInicial.LDebug then ShowMessage('RetornoCEP');
  FuIniGeral.wInicial.ACBR_CEP := '*';
  FuIniGeral.wInicial.ACBR_TpLograd := '';
  FuIniGeral.wInicial.ACBR_Logradouro := '';
  FuIniGeral.wInicial.ACBR_Bairro := '';
  FuIniGeral.wInicial.ACBR_Municipio := '';
  FuIniGeral.wInicial.ACBR_SiglaUF := '';
  FuIniGeral.wInicial.ACBR_IBGE_MunUF := '';
  FuIniGeral.wInicial.ACBR_IBGE_Area := 0;
  wLinha := AnsiUpperCase(UTF8Decode(FuCEPACBr.MemoRet.Lines[0]));
  if Pos('OK:',wLinha) = 0
  then begin
    MessageDlg('Retorno inválido' + #13 + wLinha,mtInformation,[mbOk],0);
    Exit;
  end;
  //
  nEnder := 0;
  with FuCEPACBr
  do begin
    i := MemoRet.Lines.Count-1;
    while (nEnder = 0) and (i >= 0)
    do begin
      wLinha := MemoRet.Lines[i];
      j := Pos('[Endereco',wLinha);
      k := Pos(']',wLinha);
      if (j > 0) and (k > 0)
      then begin
        j := j + 9;
        nEnder := StrToIntDef(Copy(wLinha,j,k-j),1);
      end;
      i := i - 1;
    end;
    MemoCmd.Lines.Clear;
    MemoCmd.Lines.Add('OK:');
    MemoCmd.Lines.Add('[Endereco1]');
    for i := 1 to MemoRet.Lines.Count-1
    do MemoCmd.Lines.Add(TextoRetiraAcentuacao(UTF8Decode(MemoRet.Lines[i]),False));       // UTF8Decode --> Trata caracteres especiais VIDE HELP
    MemoCmd.Lines.SaveToFile(FuIniGeral.wInicial.ACBR_ArqRetorno);
    //
    wRetName := FuIniGeral.wInicial.ACBR_ArqRetorno;
    if not FileExists(wRetName)
    then begin
      MessageDlg('Retorno [' + wRetName + '] não encontrado',mtError,[mbOk],0);
      Exit;
    end;
    //
    cbEnderecos.Items.Clear;
    wLarg := 0;
    wRet := TIniFile.Create(wRetName);
    for i := 1 to nEnder
    do begin
      xLabel := 'Endereco' + IntToStr(i);
      wCEP := Numerico(wRet.ReadString(xLabel,'CEP','00000000'));
      wTpLogr := wRet.ReadString(xLabel,'Tipo_Logradouro','Rua');
      wLogr := wRet.ReadString(xLabel,'Logradouro','Sem nome');
      wBairro := wRet.ReadString(xLabel,'Bairro','');
      wMunic := wRet.ReadString(xLabel,'Municipio','Municipio');
      wUF := wRet.ReadString(xlabel,'UF','RS');
      wIBGE := wRet.ReadString(xLabel,'IBGE_Municipio','4305108');
      LabTexto.Caption := stringCompleta(IntToStr(i),'E','0',2) + ' - '
                          + EditaCEP(wCEP) + ' '
                          + stringCompleta(wTpLogr,'D',' ',10) + ' '
                          + stringCompleta(wLogr,'D',' ',40) + ' '
                          + stringCompleta(wBairro,'D',' ',25) + ' '
                          + stringCompleta(wMunic,'D',' ',35) + ' '
                          + wUF + ' (' + wIBGE + ')';
      if wLarg > LabTexto.Width
        then LabTexto.Width := wLarg;
      cbEnderecos.Items.Add(Labtexto.Caption)
    end;
    //
    if nEnder > 0
    then begin
      if nEnder > 1
      then begin
        FuCEPACBr.Width := LabTexto.width + 80;
        FuCEPACBr.Height := 400;
        ShowModal;
        nEnder := wUseEnder;
      end;
      // Leitura dos dados do endereço indicado
      xLabel := 'Endereco' + IntToStr(nEnder);
      wCEP := Numerico(wRet.ReadString(xLabel,'CEP','00000000'));
      wTpLogr := wRet.ReadString(xLabel,'Tipo_Logradouro','Rua');
      wLogr := wRet.ReadString(xLabel,'Logradouro','Sem nome');
      wBairro := wRet.ReadString(xLabel,'Bairro','');
      wMunic := wRet.ReadString(xLabel,'Municipio','Municipio');
      wUF := wRet.ReadString(xlabel,'UF','RS');
      wIBGE := wRet.ReadString(xLabel,'IBGE_Municipio','4305108');
      //
      FuIniGeral.wInicial.ACBR_CEP := wCEP;                           // CEP
      FuIniGeral.wInicial.ACBR_TpLograd := wTpLogr;                   // Tipo logradouro
      FuIniGeral.wInicial.ACBR_Logradouro := wLogr;                   // Logradouro
      FuIniGeral.wInicial.ACBR_Bairro := wBairro;                     // Bairro
      FuIniGeral.wInicial.ACBR_Municipio := wMunic;                   // Municipio
      FuIniGeral.wInicial.ACBR_SiglaUF := wUF;                        // Sigla UF
      FuIniGeral.wInicial.ACBR_IBGE_MunUF := wIBGE;                   // Municipio (IBGE)
    end;
    wRet.Free;

  end;
  {
OK: [Endereco1]
CEP=18270-170
Tipo_Logradouro=Rua
Logradouro=Coronel Aureliano de Camargo
Complemento=
Bairro=Centro
Municipio=Tatuí
UF=SP
IBGE_Municipio=3554003
IBGE_UF=35
}
  if FuIniGeral.wInicial.LDebug then ShowMessage('AnalisaRetorno 99');

end;


Function ACBR_BuscaEnderecoCEP(pmtCEP:String): Boolean;
begin
  Result := False;
  if not ProcessoAtivo(FuIniGeral.wInicial.ACBr_Exec,False)
  then if not CarregaProcesso(ExtractFilePath(FuIniGeral.wInicial.ACBr_Ini), FuIniGeral.wInicial.ACBr_Exec)
       then Exit;
  //
  FuCEPACBr.MemoRet.Lines.Clear;
  FuCEPACBr.MemoCmd.Lines.Clear;
  FuCEPACBr.MemoCmd.Lines.Add('CEP.BuscarPorCEP(' + pmtCEP + ')');
  FuCEPACBr.MemoCmd.Lines.SaveToFile(FuIniGeral.wInicial.ACBR_ArqComando);
  if CarregaRetorno
  then begin
    RetornoCEP;
    if FuIniGeral.wInicial.ACBR_CEP <> '*'
    then Result := True;
  end;
  if FileExists(FuIniGeral.wInicial.ACBR_ArqRetorno)
     then DeleteFile(FuIniGeral.wInicial.ACBR_ArqRetorno);
  if FuIniGeral.wInicial.LDebug then ShowMessage('Apagou retorno: ' + FuIniGeral.wInicial.ACBR_ArqRetorno);

end;


Function ACBR_BuscaEnderecoLograd(pmtLograd,pmtBairro,pmtCidade,pmtSiglaUF:String): Boolean;
var pTpLogr: String;
begin
  Result := False;
  if not ProcessoAtivo(FuIniGeral.wInicial.ACBr_Exec,False)
  then if not CarregaProcesso(ExtractFilePath(FuIniGeral.wInicial.ACBr_Ini), FuIniGeral.wInicial.ACBr_Exec)
       then Exit;
  //
  FuCEPACBr.MemoRet.Lines.Clear;
  FuCEPACBr.MemoCmd.Lines.Clear;
  pTpLogr := '';
  FuCEPACBr.MemoCmd.Lines.Add('CEP.BuscarPorLogradouro('
                              + UTF8Encode(pmtCidade) + ', '
                              + pTpLogr + ', '
                              + UTF8Encode(pmtLograd) + ', '
                              + pmtSiglaUF + ', '
                              + UTF8Encode(pmtBairro) + ')');
  FuCEPACBr.MemoCmd.Lines.SaveToFile(FuIniGeral.wInicial.ACBR_ArqComando);
  if CarregaRetorno
  then begin
    RetornoCEP;
    if FuIniGeral.wInicial.ACBR_CEP <> '*'
    then Result := True;
  end;
  if FileExists(FuIniGeral.wInicial.ACBR_ArqRetorno)
     then DeleteFile(FuIniGeral.wInicial.ACBR_ArqRetorno);
  if FuIniGeral.wInicial.LDebug then ShowMessage('Apagou retorno: ' + FuIniGeral.wInicial.ACBR_ArqRetorno);

end;


procedure TFuCEPACBr.btCancelClick(Sender: TObject);
begin
  wUseEnder := 0;
  FuCEPACBr.Close;

end;

procedure TFuCEPACBr.btOkClick(Sender: TObject);
var i,nInd: Integer;
    wMsg: String;
begin
  wUseEnder := 0;
  for i := 0 to cbEnderecos.Items.Count-1
  do if cbEnderecos.Checked[i]
     then begin
       nInd := nInd + 1;
       wUseEnder := i + 1;
     end;
  wMsg := '';
  if nInd = 0
  then wMsg := 'Indique um endereço a ser utilizado'
  else if nInd > 1
       then wMsg := 'Indique SOMENTE um endereço';
  if Length(Trim(wMsg)) > 0
  then begin
    MessageDlg('Erro na indicação de endereço' + #13#1 + wMsg
               ,mtError,[mbOk],0);
    Exit;
  end;
  FuCEPACBr.Close;

end;

end.
