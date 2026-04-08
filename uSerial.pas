unit uSerial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DateUtils, StdCtrls, Mask, ExtCtrls, Buttons;
Function GeraSerial(pAno, pMes, pValid: Integer; var pSerial: String): Boolean;
Function ValidaSerial(pSerial: String; var pUso: Boolean): Boolean;
Function RecebeSerial(var pSerial: String): Boolean;
Procedure DatasDoSerial(pSerial: String; var pDtUso: TDateTime; var pDtValid: TDateTime);
Function CalculaAlgoritmoSeguranca(pRzSocial, pFantasia, pCNPJ, pIEst: String): Integer;
Function VerificaAlgoritmoSeguranca(pAlgInfor: Integer; pRzSocial, pFantasia, pCNPJ, pIEst: String): Boolean;

type
  TFuSerial = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btOk: TBitBtn;
    btCancel: TBitBtn;
    Label1: TLabel;
    Image1: TImage;
    edSerial: TMaskEdit;
    procedure btCancelClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuSerial: TFuSerial;
  wValido, wValUso: Boolean;

implementation

{$R *.dfm}

Function GeraSerial(pAno, pMes, pValid: Integer; var pSerial: String): Boolean;
// pAno,pMes: a partir do qual deve considerar a validade
// pValid:  Validade pretendida, até 240 meses
// pSerial: Serial a ser retornado   String de 11 caracteres
// A4 A3 M2 M1 V3 V2 V1 A2 A1 D1 D2  (Ano: Pos 9,8,2,1; Mes: Pos 4,3; Val: Pos 7,6,5;  DVs: Pos 10,11
// A1 A2 A3 A4 e M1 M2 (dia 01) ---> Ano/mes (dia) da geração do serial
// V1 V2 V3                     ---> Validade do serial
// Result:  True -> Ok, serial criado    False -> pValid inválido
//
var
  XVL, XMM, XAA: String;
  R: array [1 .. 11] of Integer;
  i: Integer;
begin
  Result := False;
  if (pValid < 1) or (pValid > 240) then
  begin
    pSerial := '';
    Exit;
  end;
  //
  XAA := IntToStr(pAno);
  XMM := IntToStr(pMes);
  if Length(XMM) < 2 then
    XMM := '0' + XMM;
  XVL := IntToStr(pValid);
  while Length(XVL) < 3 do
    XVL := '0' + XVL;
  //
  R[1] := StrToInt(XAA[4]);
  R[2] := StrToInt(XAA[3]);
  R[3] := StrToInt(XMM[2]);
  R[4] := StrToInt(XMM[1]);
  R[5] := StrToInt(XVL[3]);
  R[6] := StrToInt(XVL[2]);
  R[7] := StrToInt(XVL[1]);
  R[8] := StrToInt(XAA[2]);
  R[9] := StrToInt(XAA[1]);
  R[10] := ((R[1] + R[3] + R[5] + R[7] + R[9]) + ((R[2] + R[4] + R[6] + R[8]) *
    2)) mod 10;
  R[11] := ((R[2] + R[4] + R[6] + R[8] + R[10]) +
    ((R[1] + R[3] + R[5] + R[7] + R[9]) * 2)) mod 10;
  pSerial := '';
  for i := 1 to 11 do
    pSerial := pSerial + IntToStr(R[i]);
  Result := True;

end;
//

Procedure DatasDoSerial(pSerial: String; var pDtUso: TDateTime;
  var pDtValid: TDateTime);
var
  R: array [1 .. 11] of Integer;
  i, nMeses: Integer;
  wAno, wMes, wDia, wUsoMes: Word;
  lEspecial: Boolean;
begin
  pDtUso := DateOf(Date - 45);
  pDtValid := DateOf(Date - 45);
  for i := 1 to 11 do
    R[i] := StrToIntDef(pSerial[i], 0);
  //
  wAno := (R[9] * 1000) + (R[8] * 100) + (R[2] * 10) + R[1];
  // Ano de criação do serial
  wMes := ((R[4] * 10) + R[3]); // Mes de criacao do serial
  //
  // Data limite para USO do serial   (data da criação do serial + 12 meses)
  wUsoMes := wMes + 12;
  if wUsoMes > 12 then
  begin
    wAno := wAno + 1;
    wUsoMes := 1;
  end;
  wDia := DaysInMonth(EncodeDate(wAno, wUsoMes, 1));
  pDtUso := EncodeDate(wAno, wUsoMes, wDia);
  //
  // Data de validade do serial
  nMeses := (R[7] * 100) + (R[6] * 10) + R[5];
  // Validade do sistema em meses, desde a criação do serial
  if nMeses >= 120 then
    lEspecial := True
  else
    lEspecial := False;
  while nMeses > 0 do
  begin
    wMes := wMes + 1;
    if wMes > 12 then
    begin
      wMes := 1;
      wAno := wAno + 1;
    end;
    nMeses := nMeses - 1;
  end;
  wDia := DaysInMonth(EncodeDate(wAno, wMes, 1));
  pDtValid := EncodeDate(wAno, wMes, wDia);
  //
  if lEspecial // Validade superior a 10 anos
    or (pDtUso > pDtValid) // Data de uso do serial posterior à data de validade
  then
    pDtUso := pDtValid;

end;

//
Function ValidaSerial(pSerial: String; var pUso: Boolean): Boolean;
var
  R: array [1 .. 11] of Integer;
  i, dv1, dv2: Integer;
  wDtUso, wDtVal: TDateTime;
  edSerial: String;
begin
  Result := False;
  pUso := False;
  edSerial := '';
  for i := 1 to Length(pSerial) do
    if Pos(pSerial[i], '0123456789') > 0 then
      edSerial := edSerial + pSerial[i];
  if Length(edSerial) <> 11 then
  begin
    MessageDlg('Serial deve ser formado por 11 (onze) caracteres numéricos' +
      #13 + 'Serial informado: [ ' + pSerial + ' ]', mtError, [mbOk], 0);
    Exit;
  end;
  for i := 1 to 11 do
    R[i] := StrToIntDef(pSerial[i], 0);
  dv1 := ((R[1] + R[3] + R[5] + R[7] + R[9]) + ((R[2] + R[4] + R[6] + R[8]) * 2)
    ) mod 10; // 1.dígito
  dv2 := ((R[2] + R[4] + R[6] + R[8] + R[10]) +
    ((R[1] + R[3] + R[5] + R[7] + R[9]) * 2)) mod 10; // 2.dígito
  if (R[10] <> dv1) or (R[11] <> dv2) then
  begin
    MessageDlg(edSerial + 'inválido', mtError, [mbOk], 0);
    Exit;
  end;
  DatasDoSerial(pSerial, wDtUso, wDtVal); // Datas do serial (Uso e Validade)
  if DateOf(Date) <= DateOf(wDtUso) then
    pUso := True;
  dv1 := DaysBetween(DateOf(Date), DateOf(wDtVal));
  // Dias até o vencimento ou passados do vencimento
  if DateOf(Date) > DateOf(wDtVal) then
  begin
    pUso := False;
    MessageDlg(edSerial + 'vencido desde ' + DateToStr(wDtVal) + '  (' +
      IntToStr(dv1) + ' dias)', mtError, [mbOk], 0);
    Exit;
  end;
  if dv1 <= 15 then
    MessageDlg(pSerial + 'validade do serial expira em ' + DateToStr(wDtVal) +
      '  (' + IntToStr(dv1) + ' dias)', mtError, [mbOk], 0);
  Result := True;

end;

Function RecebeSerial(var pSerial: String): Boolean;
begin
  wValido := False;
  FuSerial := TFuSerial.Create(nil);
  FuSerial.edSerial.Text := pSerial;
  FuSerial.ShowModal;
  pSerial := FuSerial.edSerial.Text;
  Result := wValido;
  FuSerial.Free;

end;

Function CalculaAlgoritmoSeguranca(pRzSocial, pFantasia, pCNPJ,
  pIEst: String): Integer;
{ Calcula o algoritmo de segurança
  pRzSocial: Nome da empresa usuária
  pFantasia: Nome fantasia da empresa usuária
  pCNPJCGC:  CNPJ da empresa usuaria
  pIEST:     Inscrição estadual
  Retorna:   Algoritmo calculado }
var
  i, j, nPos: Integer;
  xString, wString: String;
begin
  xString := chr(255);
  for i := 254 downto 1 do
    xString := xString + chr(i);
  wString := '**' + Trim(pRzSocial) + '**' + Trim(pFantasia) + '**' +
    Trim(pCNPJ) + '**' + Trim(pIEst) + '**';
  Result := 0;
  for i := 1 to Length(wString) do
  begin;
    nPos := Pos(wString[i], xString);
    j := (nPos * nPos) * 2;
    Result := Result + j;
  end;

end;

Function VerificaAlgoritmoSeguranca(pAlgInfor: Integer;
  pRzSocial, pFantasia, pCNPJ, pIEst: String): Boolean;
{ Verifica segurança e validade
  pAlgInfor: Algoritmo informado
  pRzSocial: Nome da empresa usuária
  pFantasia: Nome fantasia da empresa usuária
  pCNPJCGC:  CNPJ da empresa usuaria
  pIEST:     Inscrição estadual
  Retorna:   True->Segurança OK   False->Quebra de segurança }
var
  wMsg: String;
  wAlgor: Integer;
begin
  Result := False;
  wMsg := '';
  wAlgor := CalculaAlgoritmoSeguranca(pRzSocial, pFantasia, pCNPJ, pIEst);
  if wAlgor <> pAlgInfor then
  begin
    MessageDlg('Algoritmo VIOLADO' + #13 + 'Informado: ' + IntToStr(pAlgInfor) +
      #13 + 'Calculado: ' + IntToStr(wAlgor), mtError, [mbOk], 0);
    Exit;
  end;
  Result := True;

end;

procedure TFuSerial.btCancelClick(Sender: TObject);
begin
  edSerial.Text := '';
  FuSerial.Close;

end;

procedure TFuSerial.btOkClick(Sender: TObject);
begin
  wValido := ValidaSerial(edSerial.Text, wValUso);
  if not wValido then
    edSerial.SetFocus
  else if not wValUso then
  begin
    MessageDlg('Serial informado fora do período de utilização', mtError,
      [mbOk], 0);
    wValido := False;
  end;
  FuSerial.Close;

end;

end.
