unit uCertificados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, DB, DBTables, StdCtrls, DateUtils, Types,
  DBGrids, Buttons;
  Procedure VerificaCertificadosSISV(pmtDBName:String; pmtExibe:Boolean);

type
  TFuCertificados = class(TForm)
    TbEF: TTable;
    TbEFDenom: TStringField;
    TbEFValCertif: TDateTimeField;
    TbEFCNPJ: TStringField;
    Panel1: TPanel;
    Panel2: TPanel;
    TbEFCod: TSmallintField;
    Grid: TDBGrid;
    STbEF: TDataSource;
    TbEFZC_Dias: TIntegerField;
    TbEFZC_Situacao: TStringField;
    btProsseg: TBitBtn;
    LabMsgProx: TLabel;
    LabMsgNorm: TLabel;
    LabMsgVenc: TLabel;
    TbEFZC_DiasExib: TStringField;
    procedure TbEFCalcFields(DataSet: TDataSet);
    procedure btProssegClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject;
                                 const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuCertificados: TFuCertificados;
  nVenc,nProx,nNorm: Integer;
  pExib: Boolean;

implementation

{$R *.dfm}

Procedure VerificaCertificadosSISV(pmtDBName:String; pmtExibe:Boolean);
begin
  FuCertificados := TFuCertificados.Create(nil);
  with FuCertificados
  do begin
    pExib             := pmtExibe;
    tbEF.Active       := False;
    tbEF.DatabaseName := pmtDBName;
    tbEF.Active       := True;
    nVenc             := 0;
    nProx             := 0;
    nNorm             := 0;
    tbEF.First;
    while not tbEF.Eof
    do begin
      if tbEFZC_Dias.AsInteger < 0
      then nVenc := nVenc + 1        // Vencido
      else if tbEFZC_Dias.AsInteger < 31
           then nProx := nProx + 1
           else nNorm := nNorm + 1;
      tbEF.Next;
    end;
    tbEF.First;
    if (nVenc > 0) or (nProx > 0) or pExib
       then ShowModal;
    tbEF.Active := False;
  end;
  FuCertificados.Free;

end;

procedure TFuCertificados.TbEFCalcFields(DataSet: TDataSet);
begin
  if DateOf(tbEFValCertif.AsDateTime) < StrToDate('01/01/2011')
  then tbEFZC_Dias.AsInteger := 9999
  else begin
    tbEFZC_Dias.AsInteger := DaysBetween(DateOf(Date),DateOf(tbEFValCertif.AsDateTime));
    if DateOf(Date) > DateOf(tbEFValCertif.AsDateTime)
    then tbEFZC_Dias.AsInteger := tbEFZC_Dias.AsInteger * -1;
  end;
  if tbEFZC_Dias.AsInteger > 30
  then tbEFZC_Situacao.AsString := ''
  else if tbEFZC_Dias.AsInteger > 0
       then tbEFZC_Situacao.AsString := tbEFZC_Dias.AsString + ' dias para vencer'
       else if tbEFZC_Dias.AsInteger = 0
            then tbEFZC_Situacao.AsString := 'Vence HOJE !!!'
            else tbEFZC_Situacao.AsString := 'Vencido !!!';
  if (tbEFZC_Dias.AsInteger > 9000)
     or (tbEFZC_Dias.AsInteger < 0)
  then tbEFZC_DiasExib.AsString := ''
  else tbEFZC_DiasExib.AsString := tbEFZC_Dias.AsString;

end;

procedure TFuCertificados.btProssegClick(Sender: TObject);
begin
  FuCertificados.Close;

end;

procedure TFuCertificados.FormShow(Sender: TObject);
begin
  if nVenc > 0
  then begin
    labMsgVenc.Caption := '  ' + IntToStr(nVenc) + '  ' + labMsgVenc.Caption + '  ';
    labMsgVenc.Visible := True;
  end;
  if nNorm > 0
  then begin
    labMsgNorm.Caption := '  ' + IntToStr(nNorm) + '  ' + labMsgNorm.Caption + '  ';
    labMsgNorm.Visible := True;
  end;
  if nProx > 0
  then begin
    labMsgProx.Caption := '  >>> ' + IntToStr(nProx) + '  ' + labMsgProx.Caption + '  ';
    labMsgProx.Visible := True;
  end;

end;

procedure TFuCertificados.GridDrawColumnCell(Sender: TObject;
                                             const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (Column.Field.FieldName <> 'ZC_DiasExib')
     and (Column.Field.FieldName <> 'ZC_Situacao')
  then Exit;
  if tbEFZC_Dias.AsInteger > 30
     then Exit;
  if tbEFZC_Dias.AsInteger < 0
  then begin
    Grid.Canvas.Brush.Color := clBlack;
    Grid.Canvas.Font.Color := clAqua;
  end
  else begin
    Grid.Canvas.Brush.Color := clRed;
    Grid.Canvas.Font.Color := clWhite;
  end;
  Grid.Canvas.FillRect(Rect);
  Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TFuCertificados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (not pExib) and
    ((nVenc > 0) or (nProx > 0))
  then MessageDlg('Há certificados VENCIDOS ou A VENCER nos próximos 30 dias' + #13
                  + 'Informe ao setor responsável para que providencie a renovação'
                  ,mtInformation,[mbOk],0);

end;

end.
