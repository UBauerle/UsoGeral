unit uRAWPrinters;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Printers, Winspool, ExtCtrls, Buttons;
  Function SelecionaImpressora(var IdPrinter:String; var PortPrinter:String): Boolean;

type
  TFuRAWPrinters = class(TForm)
    Panel1: TPanel;
    btOk: TBitBtn;
    BtCanc: TBitBtn;
    Panel2: TPanel;
    cbImpress: TComboBox;
    BtPadr: TBitBtn;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure BtPadrClick(Sender: TObject);
    procedure BtCancClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuRAWPrinters: TFuRAWPrinters;

implementation

{$R *.DFM}

{
Function SelecionaImpressora: ShortString; Stdcall; Export;
var NrPrts: Integer;
begin
  FPrts := TFPrts.Create(nil);
  NrPrts := ObtemImpressoras;
  if NrPrts = 0
  then Result := 'NADA##'
  else begin
    if NrPrts > 1 then FPrts.ShowModal;
    Result := FPrts.LabId.Caption + '##' + FPrts.LabPort.Caption;
  end;
  FPrts.Release;

end;
}

Function SelecionaImpressora(var IdPrinter:String; var PortPrinter:String): Boolean;
var Device : array[0..255] of char;
    Driver : array[0..255] of char;
    Port : array[0..255] of char;
    hDMode : THandle;
    i,qtdPrinters: Integer;
    wPrtIds,wPrtPort: array of String;
    lCancel: Boolean;
begin
  Result        := False;
  lCancel       := False;
  IdPrinter     := '';
  portPrinter   := '';
  qtdPrinters   := 0;
  Try
    Printer.GetPrinter(Device,Driver,Port,hDMode);
    qtdPrinters := Printer.Printers.Count;
  Except
    MessageDlg('Não há impressoras disponíveis em seu sistema',mtError,[mbOk],0);
    Exit;
  End;
  //
  FuRAWPrinters := TFuRAWPrinters.Create(nil);
  with FuRAWPrinters
  do begin
    cbImpress.Items.Clear;
    SetLength(wPrtIds,qtdPrinters);
    SetLength(wPrtPorts,qtdPrinters);
    for i := 0 to qtdPrinters-1
    do begin
      Printer.PrinterIndex := i;
      Printer.GetPrinter(Device,Driver,Port,hDMode);
      cbImpress.Items.Add(Device);
      wPrtIds[i]   := Device;
      wPrtPorts[i] := Port;
    end;
    cbImpress.ItemIndex := Printer.PrinterIndex;
    ShowModal;
    if not lCancel
    then begin
      IdPrinter    := wPrtIds[cbImpress.ItemIndex];
      PortPrinter  := wPrtPorts[cbImpress.ItemIndex];
      Result       := True;
    end;
  end;
  FuRAWPrinters.Free;

end;


procedure TFuRAWPrinters.FormShow(Sender: TObject);
begin
  btOk.SetFocus;

end;

procedure TFuRAWPrinters.btOkClick(Sender: TObject);
begin
  lCancel  := False;
//  LabId.Caption   := WPrtIds[CbImpress.ItemIndex];
//  LabPort.Caption := WPrtPorts[CbImpress.ItemIndex];
  FuRAWPrinters.Close;

end;

procedure TFuRAWPrinters.BtPadrClick(Sender: TObject);
begin
  CbImpress.ItemIndex := Printer.PrinterIndex;
  btOk.SetFocus;

end;

procedure TFuRAWPrinters.BtCancClick(Sender: TObject);
begin
  lCancel  := True;
  FuRAWPrinters.Close;

end;

end.
