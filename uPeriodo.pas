unit uPeriodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons,DateUtils, ExtCtrls;
  Function ObtemPeriodo(var pDtIni,pDtFin:TDateTime;
                        pTexto:String = 'Informe período';
                        pTop:Integer = 0; pLeft:Integer = 0;
                        pDtFutura:Boolean = True): Boolean;


type
  TFuPeriodo = class(TForm)
    Panel1: TPanel;
    LabTexto: TLabel;
    Label1: TLabel;
    dtInicial: TDateTimePicker;
    dtFinal: TDateTimePicker;
    Label2: TLabel;
    sbAnterior: TSpeedButton;
    sbAtual: TSpeedButton;
    sbProximo: TSpeedButton;
    sbTodos: TSpeedButton;
    LabInform: TLabel;
    Panel2: TPanel;
    btOk: TBitBtn;
    btCancel: TBitBtn;
    procedure sbTodosClick(Sender: TObject);
    procedure sbAnteriorClick(Sender: TObject);
    procedure sbAtualClick(Sender: TObject);
    procedure sbProximoClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure sbAnteriorMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure sbAtualMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure sbProximoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure sbTodosMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuPeriodo: TFuPeriodo;
  wAno,wMes,wDia: Word;
  lDtFutura,lResult: Boolean;

implementation

{$R *.dfm}

Function ObtemPeriodo(var pDtIni,pDtFin:TDateTime;                       // Datas iniciais
                      pTexto:String = 'Informe período';
                      pTop:Integer = 0; pLeft:Integer = 0;
                      pDtFutura: Boolean = True): Boolean;
begin
  if (pTop = 0) and (pLeft = 0)
  then begin
    pTop  := Screen.Height div 6;
    pLeft := Screen.Width  div 8;
  end;
  lDtFutura := pDtFutura;
  FuPeriodo := TFuPeriodo.Create(nil);
  with FuPeriodo
  do begin
    LabTexto.Caption  := pTexto;
    Top               := pTop;
    Left              := pLeft;
    LabInform.Caption := '';
    lResult           := False;
    dtInicial.Date    := pDtIni;
    dtFinal.Date      := pDtFin;
    ShowModal;
    pDtIni            := dtInicial.Date;
    pDtFin            := dtFinal.Date;
    Result := lResult;
  end;
  FuPeriodo.Release;

end;

procedure TFuPeriodo.sbTodosClick(Sender: TObject);
begin
  dtInicial.Date  := EncodeDate(1901,1,1);
  if not lDtFutura
     then dtFinal.Date := Date
     else dtFinal.Date := EncodeDate(2199,12,31);

end;

procedure TFuPeriodo.sbAnteriorClick(Sender: TObject);
begin
  DecodeDate(dtInicial.date,wAno,wMes,wDia);
  wMes := wMes - 1;
  if wMes < 1
  then begin
    wMes := 12;
    wAno := wAno - 1;
  end;
  dtInicial.Date := EncodeDate(wAno,wMes,1);
  wDia           := DaysInMonth(dtInicial.Date);
  dtFinal.Date   := EncodeDate(wAno,wMes,wDia);

end;

procedure TFuPeriodo.sbAtualClick(Sender: TObject);
begin
  DecodeDate(Date,wAno,wMes,wDia);
  dtInicial.Date := EncodeDate(wAno,wMes,1);
  wDia           := DaysInMonth(dtInicial.Date);
  dtFinal.Date   := EncodeDate(wAno,wMes,wDia);

end;

procedure TFuPeriodo.sbProximoClick(Sender: TObject);
var nDtIni,nDtFin: TDateTime;
begin
  DecodeDate(dtInicial.Date,wAno,wMes,wDia);
  wMes := wMes + 1;
  if wMes > 12
  then begin
    wMes := 1;
    wAno := wAno + 1;
  end;
  nDtIni  := EncodeDate(wAno,wMes,1);
  wDia    := DaysInMonth(nDtIni);
  nDtFin  := EncodeDate(wAno,wMes,wDia);
  if not lDtFutura
  then if nDtIni > DateOf(Date)
       then begin
         MessageDlg('Data inicial não pode ser futura', mtInformation, [mbOk], 0);
         Exit;
       end;
  dtInicial.Date := nDtIni;
  dtFinal.Date   := nDtFin;

end;

procedure TFuPeriodo.btOkClick(Sender: TObject);
begin
  if DateOf(dtInicial.Date) > DateOf(dtFinal.Date)
  then begin
    MessageDlg('Data inicial não pode ser posterior à data final, reinforme',mtError,[mbOk],0);
    dtInicial.SetFocus;
    Exit;
  end;

  lResult := True;
  FuPeriodo.Close;

end;

procedure TFuPeriodo.btCancelClick(Sender: TObject);
begin
  lResult := False;
  FuPeriodo.Close;

end;

procedure TFuPeriodo.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  LabInform.Caption := '';

end;

procedure TFuPeriodo.sbAnteriorMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  LabInform.Caption := 'Mês anterior';

end;

procedure TFuPeriodo.sbAtualMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  LabInform.Caption := 'Mês corrente';

end;

procedure TFuPeriodo.sbProximoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  LabInform.Caption := 'Próximo mês';

end;

procedure TFuPeriodo.sbTodosMouseMove(Sender: TObject; Shift: TShiftState;  X, Y: Integer);
begin
  LabInform.Caption := 'Todas as datas';

end;

end.
