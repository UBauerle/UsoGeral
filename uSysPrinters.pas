unit uSysPrinters;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Dialogs,
  DBCtrls, StdCtrls, Mask, Buttons, ExtCtrls, Db, {DBTables,}
  Controls, Printers, Winspool;
  Function ObtemImpressoras: Integer;
  Function RetornaImpressoraPadrao(var pPrinter:String; var pPorta:String; var pDriver:String; var pIndex:Integer): Boolean;
  Function DefineImpressoraPadrao(var pPrinter:String; var pIndex:Integer): Boolean;
  Function DefineImpressora(pAutom:Boolean; var pPrinter:String; var pPorta:String; var pDriver:String; var pIndex:Integer): Boolean;

  Procedure Imprime_Texto(NomePrinter,Arq,Relat:String);

type
  TFuSysPrinters = class(TForm)
    PanBot: TPanel;
    BtOk: TBitBtn;
    BtCanc: TBitBtn;
    btImpressoraPadrao: TBitBtn;
    Panel1: TPanel;
    cbImpressoras: TComboBox;
    Label1: TLabel;
    procedure BtCancClick(Sender: TObject);
    procedure BtOkClick(Sender: TObject);
    procedure btImpressoraPadraoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuSysPrinters: TFuSysPrinters;
  // Dados para obtenção de impressoras disponíveis no sistema
  Device : array[0..255] of char;       // Dispositivos
  Driver : array[0..255] of char;       // Drivers
  Port : array[0..255] of char;         // Portas
  hDMode : THandle;                     // Handle
  // Dados da impressora padrao
  PadraoPrinter: String;
  PadraoPorta: String;
  PadraoDriver: String;
  PadraoIndex: Integer;
  //
  wSysPrinters: array of String;
  wSysPortas: array of String;
  wSysDrivers: array of String;
  //
{
  wDefPrtDevice: String;                // Device da impressora default
  WDefPrtInd: Integer;                  // Indice da impressora padrao
  WPrts: Integer;                       // Qtd. de impressoras
  WPrtIds: array of String;             // Array de impressoras disponíveis
  WPrtPorts: array of String;           // Array de portas utilizadas
}
  PrinterId,PortaID: String;            // Impressora e porta a ser utilizada
  wNrPrinter: Integer;

implementation

{$R *.DFM}

// Obtem impressoras disponíveis no sistema
Function ObtemImpressoras: Integer;
var i: Integer;
begin
  Result := 0;
  Try
    Printer.GetPrinter(Device,Driver,Port,hDMode);
  Except
    MessageDlg('Não há impressoras disponíveis',mtError,[mbOk],0);
    Exit;
  End;
  // Impressoras disponíveis
  SetLength(wSysPrinters, Printer.Printers.Count);
  SetLength(wSysPortas,   Printer.Printers.Count);
  SetLength(wSysDrivers,  Printer.Printers.Count);
  for i := 0 to (Printer.Printers.Count-1)
  do begin
    Printer.PrinterIndex := i;
    Printer.GetPrinter(Device,Driver,Port,hDMode);
    wSysPrinters[i]  := Device;
    wSysPortas[i]    := Port;
    wSysDrivers[i]   := Driver;
  end;
  Result := Printer.Printers.Count;

end;


Function RetornaImpressoraPadrao(var pPrinter:String; var pPorta:String; var pDriver:String; var pIndex:Integer): Boolean;
{   pPrinter    Impressora padrão
    pPorta      Porta
    pDriver     Driver
    Retorno     True: Impressora encontrada   False: Não há impressoras  }
begin
  Result   := False;
  pPrinter := '';
  pPorta   := '';
  pDriver  := '';
  if Printer.Printers.Count = 0 then
    Exit;
  // Impressora "padrão"
  Printer.PrinterIndex := -1;
  Printer.GetPrinter(Device,Driver,Port,hDMode);
  pPrinter := Device;
  pPorta   := Port;
  pDriver  := Driver;
  pIndex   := Printer.PrinterIndex;
  Result   := True;

end;


Function DefineImpressoraPadrao(var pPrinter:String; var pIndex:Integer): Boolean;
var np,nOcorr,i: Integer;
    wPrinter,wMsg: String;
const pIndefinida: String = '_XYZ_ZYX_';           // para forçar inexistencia, se impressora não informada
begin
  Result := False;
  np     := ObtemImpressoras;
  if np = 0
     then Exit;
  //
  if Length(Trim(pPrinter)) = 0 then pPrinter := pIndefinida;   // Força impressora inexistente
  nOcorr := 0;
  for i := 0 to np-1
  do if AnsiUpperCase(pPrinter) = AnsiUpperCase(wSysPrinters[i])
     then begin
       wPrinter := wSysPrinters[i];
       nOcorr   := 1;
       Break;
     end
     else if Pos(AnsiUpperCase(pPrinter), AnsiUpperCase(wSysPrinters[i])) > 0
          then begin
            wPrinter := wSysPrinters[i];
            nOcorr   := nOcorr + 1;
          end;
  //
  if nOcorr <> 1
  then begin
    if nOcorr = 0 then wMsg := 'não encontrada'
                  else wMsg := 'com mais de uma ocorrencia';
    wMsg := 'Impressora " ' + pPrinter + ' " ' + wMsg;
    MessageDlg(wMsg,mtError,[mbOk],0);
    Exit;
  end;
  //
  Try
    Printer.PrinterIndex := Printer.Printers.IndexOf(wPrinter);
    Result               := True;
  Except
    MessageDlg('Impressora " ' + wPrinter + ' " inválida',mtError,[mbOk],0);
  End;
  //

end;

Function DefineImpressora(pAutom:Boolean; var pPrinter:String; var pPorta:String; var pDriver:String; var pIndex:Integer): Boolean;
{
  pAutom     True: Escolha automatica, neste caso pPrinter deve conter o nome ou parte do nome da impressora, e ser único
             False: Escolha 'MANUAL' da impressora (Tela de interface)
  pPrinter   Nome ou parte do nome da impressora desejada, retorna o nome completo da impressora
             Se pAutom = True --> Prossegue
             Se pAutom = False e Nome em branco --> Erro
             Retorna o nome da impressora na mesma variável
  pPorta     Porta da impressora
  pDriver    Driver da impressora
  pIndex     Indice da impressora
  Retorno:   True se operação ok, False se houver erro
}
var i,nPrt,nOcorrNome,nOcorrParc,nIdxNome,nIdxOcor: Integer;
    wrkPrinter: String;
begin
  Result := False;
  wrkPrinter := pPrinter;
  nPrt := ObtemImpressoras;
  if (nPrt = 0) or (not RetornaImpressoraPadrao(pPrinter,pPorta,pDriver,pIndex)) then
  begin
    MessageDlg('Não há impressoras disponíveis em seu sistema',mtError,[mbOk],0);
    Exit;
  end;
  //
  // Escolha automatica (não manual)
  if pAutom then
  begin
    if wrkPrinter = '' then
    begin
      MessageDlg('Para definição automática de imressora é necessário' + #13 +
                 'informar o nome ou parte do nome da impressora',mtError,[mbOk],0);
      Exit;
    end;
    // Localiza impressora pelo nome completo
    nOcorrNome := 0;  // qtd de vezes que o nome completo da impressora
    nOcorrParc := 0;  // qtd de vezes que a referencia à impressora ocorre
    nIdxNome := -1;   // Indice na tabela de nomes de impressora p/ nome completo
    nIdxOcor := -1;   // Indice na tabela de nomes de impressora p/ referencia
    for i := 0 to nPrt-1 do
    begin
      if AnsiUpperCase(wrkPrinter) = AnsiUpperCase(wSysPrinters[i]) then
      begin
        nOcorrNome := nOcorrNome + 1;
        if nIdxNome < 0 then
          nIdxNome := i;        // Retorna o indice correspondente à impressora
        Break;
      end
      else if Pos(AnsiUpperCase(wrkPrinter), AnsiUpperCase(wSysPrinters[i])) > 0 then
           begin
             nOcorrParc := nOcorrParc + 1;
             nIdxOcor := i;
           end;
    end;
    //
    if (nOcorrNome = 0) and (nOcorrParc = 0) then
    begin
      MessageDlg('Impressora [ ' + wrkPrinter + ' ] não localizada',mtError,[mbOk],0);
      Exit;
    end;
    if (nOcorrNome = 0) and (nOcorrParc > 1) then
    begin
      MessageDlg('Impressora [ ' + wrkPrinter + ' ] com mais de uma referencia ( ' +
                 IntToStr(nOcorrParc) + 'x )',mtError,[mbOk],0);
      Exit;
    end;
    if nOcorrNome > 0 then
      pIndex := nIdxNome
    else
      pIndex := nIdxOcor;
    pPrinter   := wSysPrinters[pIndex];
    pPorta     := wSysPortas[pIndex];
    pDriver    := wSysDrivers[pIndex];
    Result := True;
    Exit;
  end;

  //  Escolha manual
  wNrPrinter := -1;
  FuSysPrinters := TFuSysPrinters.Create(nil);
  FuSysPrinters.Caption := 'Impressoras disponíveis';
  FuSysPrinters.cbImpressoras.Items.Clear;
  FuSysPrinters.cbImpressoras.Text := '';
  nPrt := -1;
  for i := 0 to Length(wSysPrinters)-1 do
  begin
    FuSysPrinters.cbImpressoras.Items.Add(wSysPrinters[i]);
    if (wrkPrinter = wSysPrinters[i]) and (nPrt < 0) then
      nPrt := i;
  end;
  FuSysPrinters.cbImpressoras.ItemIndex := nPrt;
  FuSysPrinters.ShowModal;
  if wNrPrinter >= 0 then
  begin
    pPrinter := wSysPrinters[wNrPrinter];
    pPorta := wSysPortas[wNrPrinter];
    pDriver := wSysDrivers[wNrPrinter];
    Result := True;
  end;
  FuSysPrinters.Free;

end;



{
Function EscolheImpressora(pPrinter:String; pPrtPorta:String = ''; pPrtDriver:String = ''): Boolean;
begin
Function RetornaImpressoraPadrao(var pPrinter:String; var pPorta:String; var pDriver:String; var pIndex:Integer): Boolean;

    Printer.GetPrinter(Device,Driver,Port,hDMode);
    CbImpress.Items.Add(Device);
    WPrtIds[i] := Device;
    WPrtPorts[i] := Port;
    if Device = WDefPrtDevice then WDefPrtInd := i;       // Indice da impressora padrao
  end;
  Printer.PrinterIndex := -1;
  CbImpress.ItemIndex := WDefPrtInd;

  //
  Result :=

  //


  FSysPrinters := TFSysPrinters.Create(nil);

  FSysPrinters.ShowModal;

  Result := PrinterID;

end;
}

Procedure Imprime_Texto(NomePrinter,Arq,Relat:String);
var Handle: THandle;
    N: dWord;
    DocInfo1: TDocInfo1;
begin
  if not(OpenPrinter(PChar(Nomeprinter),Handle,nil))
  then begin
    ShowMessage('Erro ' + IntToStr(GetLastError));
    Exit;
  end;
  with DocInfo1 do
  begin
    PDocName := PChar(Relat);
    POutPutFile := nil;
    PDataType := 'RAW';
  end;
  StartDocPrinter(Handle,1,@DocInfo1);
  StartPagePrinter(Handle);
  WritePrinter(Handle,PChar(arq),Length(arq),N);
  EndPagePrinter(Handle);
  EndDocPrinter(Handle);
  ClosePrinter(Handle);
end;

procedure TFuSysPrinters.BtCancClick(Sender: TObject);
begin
  wNrPrinter   := -1;
  FuSysPrinters.Close;

end;

procedure TFuSysPrinters.BtOkClick(Sender: TObject);
begin
  wNrPrinter   := cbImpressoras.ItemIndex;
  FuSysPrinters.Close;

end;

procedure TFuSysPrinters.btImpressoraPadraoClick(Sender: TObject);
var xPrinter,xPorta,xDriver: String;
    nIndex: Integer;
begin
  cbImpressoras.ItemIndex := -1;
  if not RetornaImpressoraPadrao(xPrinter,xPorta,xDriver,nIndex)
     then MessageDlg('Não há impressora padrão definida',mtInformation,[mbOk],0)
     else cbImpressoras.ItemIndex := nIndex;
  btOk.SetFocus;

end;

procedure TFuSysPrinters.FormShow(Sender: TObject);
begin
  //btImpressoraPadraoClick(nil);
  
end;

end.

