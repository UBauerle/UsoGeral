unit uDragAndDrop;

interface

uses
  Classes, Controls, StdCtrls, Forms, Buttons;
  {Procedimentos para o objeto se mover}
  procedure DragDrop_MouseMove(Sender:TObject; Shift:TShiftState; X,Y:Integer);
  procedure DragDrop_MouseDown(Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
  procedure DragDrop_MouseUp(Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);

type
  TFuDragAndDrop = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuDragAndDrop: TFuDragAndDrop;
  moveX, moveY: Integer;
  mover: boolean;

implementation

{$R *.dfm}

{-----------------------------------------------------
{ Iniciando codificação de Movimentação de Objetos.
{----------------------------- ------------------------}
{Mover Componentes RunTime}
type
  TMoveControle = class(TControl);


procedure DragDrop_MouseDown(Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
  moveX := X;
  moveY := Y;
  mover := True;
  TMoveControle(Sender).MouseCapture := True;
end;

procedure DragDrop_MouseMove(Sender:TObject; Shift:TShiftState; X,Y:Integer);
begin
  if mover
  then begin
    with Sender As TControl
    do begin
      Left := X-moveX+Left;
      Top := Y-moveY+Top;
    end;
  end;
end;

procedure DragDrop_MouseUp(Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
  if mover
  then begin
    mover := False;
    TMoveControle(Sender).MouseCapture := False;
  end;
end;

end.
