unit uOpcao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;
  Function OpcaoGeral(pTitulo: String;
                      pMensagem: String;
                      pBt1,pBt2,pBt3:String): integer;

type
  TFuOpcao = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btUm: TBitBtn;
    btDois: TBitBtn;
    btTres: TBitBtn;
    btCancel: TBitBtn;
    LabTitulo: TLabel;
    btNothing: TBitBtn;
    LabMens: TLabel;
    procedure btUmClick(Sender: TObject);
    procedure btDoisClick(Sender: TObject);
    procedure btTresClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuOpcao: TFuOpcao;
  nResultado: Integer;

implementation

{$R *.dfm}

Function OpcaoGeral(pTitulo: String;
                    pMensagem: String;
                    pBt1,pBt2,pBt3:String): integer;
begin
  nResultado := 0;
  FuOpcao := TFuOpcao.Create(nil);
  with FuOpcao
  do begin
    Caption           := 'Indique sua opção';
    LabTitulo.caption := pTitulo;
    LabMens.Caption   := pMensagem;
    btUm.Caption      := pBt1;
    btDois.Caption    := pBt2;
    btTres.Caption    := pBt3;
    ShowModal;
  end;
  FuOpcao.Free;
  Result := nResultado;

end;

procedure TFuOpcao.btUmClick(Sender: TObject);
begin
  nResultado := 1;
  FuOpcao.Close;

end;

procedure TFuOpcao.btDoisClick(Sender: TObject);
begin
  nResultado := 2;
  FuOpcao.Close;

end;

procedure TFuOpcao.btTresClick(Sender: TObject);
begin
  nResultado := 3;
  FuOpcao.Close;

end;

procedure TFuOpcao.btCancelClick(Sender: TObject);
begin
  nResultado := 0;
  FuOpcao.Close;

end;

end.
