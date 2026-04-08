unit uVisualizaRegistro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ValEdit, Buttons, ExtCtrls, DBTables, DB;
  Procedure VisualizaRegistro(pTabela:TTable; pInfo: String; pModal:Boolean = True );

type
  TFuVisualizaRegistro = class(TForm)
    PanBottom: TPanel;
    btFechar: TBitBtn;
    StrGrid: TStringGrid;
    procedure FormResize(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuVisualizaRegistro: TFuVisualizaRegistro;
  xNames: TStringList;
  xValues: TStringList;

implementation

{$R *.dfm}

Procedure VisualizaRegistro(pTabela:TTable; pInfo:String; pModal:Boolean = True );
var i: Integer;
begin
  FuVisualizaRegistro := TFuVisualizaRegistro.Create(nil);
  with FuVisualizaRegistro
  do begin
    Caption            := pInfo;
    StrGrid.RowCount   := pTabela.Fields.Count + 1;
    StrGrid.ColCount   := 3;
    StrGrid.Cells[0,0] := 'Nr';
    StrGrid.Cells[1,0] := 'Campo';
    StrGrid.Cells[2,0] := 'Conteúdo/Valor';
    StrGrid.DefaultRowHeight := 17;
    xNames  := TStringList.Create;
    xValues := TStringList.Create;
    for i := 0 to pTabela.Fields.Count-1
    do begin
      xNames.Add(pTabela.Fields[i].FieldName);
      case pTabela.Fields[i].DataType of
        ftUnknown:   xValues.Add(pTabela.Fields[i].AsString);
        ftString:    xValues.Add(pTabela.Fields[i].AsString);
        ftSmallint,
        ftInteger,
        ftWord:      xValues.Add(IntToStr(pTabela.Fields[i].AsInteger));
        ftBoolean:   if pTabela.Fields[i].AsBoolean
                        then xValues.Add('True')
                        else xValues.Add('False');
        ftFloat,
        ftCurrency,
        ftBCD:       xValues.Add(FloatToStr(pTabela.Fields[i].AsFloat));
        ftDate:      xValues.Add(DateToStr(pTabela.Fields[i].AsDateTime));
        ftTime:      xValues.Add(DateTimeToStr(pTabela.Fields[i].AsDateTime));
        else         xValues.Add(VarToStr(pTabela.Fields[i].AsVariant));
        //ftVarBytes:  Aux := 'VarBytes';
        //ftBlob:      Aux := 'Blob';
        //ftMemo:      Aux := 'Memo';
        //ftGraphic:   Aux := 'Graphic';
      end;
    end;
    for i := 1 to xNames.Count
    do begin
      StrGrid.Cells[0,i] := IntToStr(i);
      StrGrid.Cells[1,i] := xNames[i-1];
      StrGrid.Cells[2,i] := xValues[i-1];
    end;
    if pModal then ShowModal
              else Show;
  end;
  xNames.Free;
  xValues.Free;
  FuVisualizaRegistro.Free;

end;


procedure TFuVisualizaRegistro.FormResize(Sender: TObject);
var nDec: Integer;
begin
  nDec := StrGrid.Width div 10;
  StrGrid.ColWidths[0] := nDec;
  StrGrid.ColWidths[1] := nDec * 3;
  StrGrid.ColWidths[2] := (nDec * 5) + (nDec div 2); //StrGrid.Width - ((nDec * 4) + 6);
  btFechar.Left  := (PanBottom.Width - btFechar.Width) div 2;

end;

procedure TFuVisualizaRegistro.btFecharClick(Sender: TObject);
begin
  FuVisualizaRegistro.Close;

end;

procedure TFuVisualizaRegistro.FormShow(Sender: TObject);
begin
  //FuVisualizaRegistro.FormResize(nil);
  FormResize(nil)

end;

end.
