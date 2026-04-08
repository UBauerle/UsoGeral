unit uArquivosDisp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, FileCtrl;
  Function NomeArquivo(pPathInicial:String = '';
                       pMascara:String = ''): String;


type
  TFuArquivosDisp = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    cbMascara: TComboBox;
    btOk: TBitBtn;
    btCancelar: TBitBtn;
    Drive: TDriveComboBox;
    Label2: TLabel;
    Label4: TLabel;
    Diret: TDirectoryListBox;
    procedure btOkClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuArquivosDisp: TFuArquivosDisp;
  wDrive: String;
  wPath: String;
  idArquivo: String;

implementation

{$R *.dfm}

Function NomeArquivo(pPathInicial:String = '';
                     pMascara:String = ''): String;
begin
  Result         := '';
  if Length(Trim(pPathInicial)) = 0
  then begin
    wDrive := 'C';
    wPath  := '\';
  end;

  FuArquivosDisp := TFuArquivosDisp.Create(nil);
  FuArquivosDisp.cbMascara.ItemIndex := 0;
  FuArquivosDisp.ShowModal;
  FuArquivosDisp.Free;
  Result         := idArquivo;

end;


procedure TFuArquivosDisp.btOkClick(Sender: TObject);
begin
  idArquivo := cbMascara.Text;
  FuArquivosDisp.Close;

end;

procedure TFuArquivosDisp.btCancelarClick(Sender: TObject);
begin
  idArquivo := '';
  FuArquivosDisp.Close;

end;

end.
