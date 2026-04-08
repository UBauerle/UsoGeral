unit uPrinters;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Dialogs,
  DBCtrls, StdCtrls, Mask, Buttons, ExtCtrls, Db, DBTables,
  Controls, Printers, Winspool;
  Function DefineFormaDeImpressao(pmtRelat:String): Integer;
  Function ObtemImpressora(pmtRelat:String;pmtExibe:Boolean): String;
  Procedure ImpressaoMatricial(pmtArquivo,pmtImpressora,pmtPorta:String;
                               pmtCopias:Integer;pmtEjetar,pmtExcluir:Boolean);

type
  TFuPrinters = class(TForm)
    PanFormaImpressao: TPanel;
    rgForma: TRadioGroup;
    PanRelatorio: TPanel;
    gbPrinters: TGroupBox;
    CbImpress: TComboBox;
    btPadrao: TBitBtn;
    btOkPrinter: TBitBtn;
    btCancelPrinter: TBitBtn;
    PanImpressao: TPanel;
    CbCopias: TComboBox;
    CbEject: TCheckBox;
    CbDelete: TCheckBox;
    Label1: TLabel;
    LabPrinter: TLabel;
    btCancelImpressao: TBitBtn;
    btImprimir: TBitBtn;
    LabPorta: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure btCancelPrinterClick(Sender: TObject);
    procedure btOkPrinterClick(Sender: TObject);
    procedure btPadraoClick(Sender: TObject);
    procedure rgFormaClick(Sender: TObject);
    procedure btCancelImpressaoClick(Sender: TObject);
    procedure btImprimirClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuPrinters: TFuPrinters;
  // Dados para obtenção de impressoras disponíveis no sistema
  Device : array[0..255] of char;       // Dispositivos
  Driver : array[0..255] of char;       // Drivers
  Port : array[0..255] of char;         // Portas
  hDMode : THandle;                     // Handle
  wDefPrtDevice: String;                // Device da impressora default
  wDefPrtInd: Integer;                  // Indice da impressora padrao
  qtdPrt: Integer;                      // Qtd. de impressoras
  wPrtIds: array of String;             // Array de impressoras disponíveis
  wPrtPorts: array of String;           // Array de portas utilizadas
  wPrinterId,wPortaID: String;          // Impressora e porta a ser utilizada
  wArqLista: String;                    // Arquivo a ser impresso

implementation

{$R *.DFM}


Function DefineFormaDeImpressao(pmtRelat:String): Integer;
begin
  FuPrinters := TFuPrinters.Create(nil);
  with FuPrinters
  do begin
    Caption                   := 'Forma de impressão';
    PanRelatorio.Caption      := pmtRelat;
    FuPrinters.ClientWidth    := 281;
    FuPrinters.ClientHeight   := 155;
    PanFormaImpressao.Align   := alClient;
    rgForma.Top               := (PanFormaImpressao.Height - rgForma.Height) div 2;
    rgForma.Left              := (PanFormaImpressao.Width - rgForma.Width) div 2;
    rgForma.ItemIndex         := -1;
    PanFormaImpressao.Visible := True;
    ShowModal;
    if rgForma.ItemIndex < 0
       then Result := 2
       else Result := rgForma.ItemIndex;
    PanFormaImpressao.Visible := False;
  end;
  FuPrinters.Release;

end;


Function ObtemImpressora(pmtRelat:String;pmtExibe:Boolean): String;
var i: Integer;
begin
  // Obtem impressoras disponíveis no sistema
  Try
    Printer.GetPrinter(Device, Driver, Port, hDMode);
    qtdPrt := Printer.Printers.Count;
  Except
    qtdPrt := 0;
    MessageDlg('Não há impressoras disponíveis em seu sistema',
                mtWarning,[mbOk],0);
    Result := '';
    Exit;
  End;
  //
  // Impressora padrao
  Printer.PrinterIndex := -1;
  Printer.GetPrinter(Device,Driver,Port,hDMode);
  wDefPrtDevice := Device;

  FuPrinters := TFuPrinters.Create(nil);
  with FuPrinters
  do begin
    Caption              := 'Selecione impressora';
    PanRelatorio.Caption := pmtRelat;
    ClientWidth          := 485;
    ClientHeight         := 155;
    gbPrinters.Align     := alClient;
    gbPrinters.Visible   := True;
    CbImpress.Items.Clear;
    SetLength(wPrtIds, Printer.Printers.Count);
    SetLength(wPrtPorts, Printer.Printers.Count);
    for i := 0 to (Printer.Printers.Count-1)
    do begin
      Printer.PrinterIndex := i;
      Printer.GetPrinter(Device,Driver,Port,hDMode);
      CbImpress.Items.Add(Device);
      wPrtIds[i] := Device;
      wPrtPorts[i] := Port;
      if Device = wDefPrtDevice
      then begin                              // Impressora padrao
        wDefPrtInd := i;                      // Indice
        wPrinterId := wPrtIds[i];             // Identificação da impressora
        wPortaId   := wPrtPorts[i];           // Porta relacionada
      end;
    end;
    if pmtExibe
    then begin
      CbImpress.ItemIndex := wDefPrtInd;
      ShowModal;
    end;
    gbPrinters.Visible := False;
    Result             := wPrinterId + wPortaId;
  end;

  FuPrinters.Release;

end;


Procedure ImpressaoMatricial(pmtArquivo,pmtImpressora,pmtPorta:String;
                               pmtCopias:Integer;pmtEjetar,pmtExcluir:Boolean);
begin
  if not FileExists(pmtArquivo)
  then begin
    MessageDlg('Arquivo' + #13
               + pmtArquivo + #13
               + 'não encontrado, impressão não realizada'
               ,mtError,[mbOk],0);
    Exit;
  end;
  wArqLista := pmtArquivo;             // Arquivo a ser impresso
  wPrinterId := pmtImpressora;         // Impressora (matricial)
  wPortaID := pmtPorta;                // Porta a ser utilizada
  FuPrinters := TFuPrinters.Create(nil);
  with FuPrinters
  do begin
    Caption := 'Controle impressão';
    PanRelatorio.Caption := 'Arquivo: ' + wArqLista;
    ClientWidth := 485;
    ClientHeight := 207;
    PanImpressao.Align := alClient;
    PanImpressao.Visible := True;
    LabPrinter.Caption := wPrinterId;
    LabPorta.Caption := wPortaId;
    CbCopias.ItemIndex := 0;
    if (pmtCopias > 0) and (pmtCopias < 21)
       then FuPrinters.CbCopias.ItemIndex := pmtCopias-1;
    cbEject.Checked := pmtEjetar;
    cbDelete.Checked := pmtExcluir;
    ShowModal;
    PanImpressao.Visible := False;
  end;
  FuPrinters.Release;

end;


procedure TFuPrinters.btCancelPrinterClick(Sender: TObject);
begin
  wPrinterId := '';
  wPortaId := '';
  FuPrinters.Close;

end;

procedure TFuPrinters.btOkPrinterClick(Sender: TObject);
begin
  wPrinterId := wPrtIds[CbImpress.ItemIndex];
  wPortaId := '[' + wPrtPorts[CbImpress.ItemIndex] + ']';
  FuPrinters.Close;

end;

procedure TFuPrinters.btPadraoClick(Sender: TObject);
begin
  Printer.PrinterIndex := -1;
  CbImpress.ItemIndex := WDefPrtInd;
  btOkPrinter.SetFocus;

end;

procedure TFuPrinters.rgFormaClick(Sender: TObject);
begin
  FuPrinters.Close;

end;


procedure TFuPrinters.btCancelImpressaoClick(Sender: TObject);
begin
  if cbDelete.Checked
     then DeleteFile(wArqLista);
  FuPrinters.Close;

end;



procedure TFuPrinters.btImprimirClick(Sender: TObject);
var j,i,nCtle: Integer;
    Handle: THandle;
    DocInfo1: TDocInfo1;
    nomeDoc,Linha,xCtle: String;
    Arq: TextFile;
    Lista: Boolean;
    N: dWord;
begin
  for j := 1 to StrToIntDef(cbCopias.Text,1)
  do begin
    if not(OpenPrinter(PChar(wPrinterId),Handle,nil))
    then begin
      MessageDlg('Erro ' + IntToStr(GetLastError) + #13 +
                 'Não é possível imprimir',mtError,[mbOk],0);
      Exit;
    end;
    with DocInfo1 do
    begin
      nomeDoc := ExtractFileName(wArqLista) + '-' + IntToStr(j);
      PDocName := PChar(nomeDoc);
      POutPutFile := nil;
      PDataType := 'RAW';
    end;
    StartDocPrinter(Handle,1,@DocInfo1);
    StartPagePrinter(Handle);
    AssignFile(Arq,wArqLista);
    Reset(Arq);
    Lista := True;
    while Lista
    do begin
      ReadLn(Arq,Linha);
      if Length(Linha) = 0
      then Lista := False
      else begin
        nCtle := -1;
        for i := 0 to 9
        do begin
          xCtle := '#' + IntToStr(i) + '#';
          if Pos(xCtle,Linha) > 0
             then nCtle := i;
        end;
        if nCtle < 0
           then nCtle := 1               // Sem controle, é o mesmo que espaço simples
           else Delete(Linha,1,3);       // Houve controle, retira o ctle da linha
        Linha := Linha + #13;            // Somente CR
        for i := 1 to nCtle
           do Linha := Linha + #10;         // LineFeed (de 1 a 9)
        WritePrinter(Handle,PChar(Linha),Length(Linha),N);
      end;
    end;
    if CbEject.Checked then Linha := chr(12)      // Ejeta página
                       else Linha := ' ';
    WritePrinter(Handle,PChar(Linha),Length(Linha),N);
    EndPagePrinter(Handle);
    EndDocPrinter(Handle);
    ClosePrinter(Handle);
    CloseFile(Arq);
  end;
  if cbDelete.Checked
     then DeleteFile(wArqLista);
  FuPrinters.Close;

end;

end.

