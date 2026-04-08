unit uExplorar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, FileCtrl, ExtCtrls;
  Function Explorar(pIniDir:String; var pRetorno:String; pFiltro:String = '*.*'): Boolean;

type
  TFuExplorar = class(TForm)
    PanDrive: TPanel;
    DriveCBox: TDriveComboBox;
    Label1: TLabel;
    Panel2: TPanel;
    DirList: TDirectoryListBox;
    Label2: TLabel;
    FileBox: TFileListBox;
    Label3: TLabel;
    LabDirInic: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    LabDirAtual: TLabel;
    Panel1: TPanel;
    btOk: TBitBtn;
    btCancelar: TBitBtn;
    Label6: TLabel;
    LabFiltro: TLabel;
    procedure LabDirInicDblClick(Sender: TObject);
    procedure FileBoxDblClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure DirListChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FuExplorar: TFuExplorar;
  wRetorno: String;

implementation

{$R *.dfm}

Function Explorar(pIniDir:String; var pRetorno:String; pFiltro:String = '*.*'): Boolean;
var i: Integer;
    lDrive: Boolean;
    xDrive: String;
    wDrive: Char;
const Drv: string = ('ABCDEFGHIJKLMNOPQRSTUVWXYZ');
      wDrv: array[1..26] of Char = ('A','B','C','D','E','F','G','H','I','J',
                                    'K','L','M','N','O','P','Q','R','S','T',
                                    'U','V','W','X','Y','Z');

begin
  Result   := False;
  wRetorno := '';
  lDrive   := False;
  for i := 1 to Length(Drv)
  do begin
    xDrive := Copy(Drv,i,1) + ':';
    if Pos(xDrive,pIniDir) > 0
    then begin
      lDrive := True;
      wDrive := wDrv[i];
      Break;
    end;
  end;
  //
  if FileExists(pIniDir)
     then pIniDir := ExtractFilePath(pIniDir);
  //
  FuExplorar  := TFuExplorar.Create(nil);
  with FuExplorar
  do begin
    LabDirInic.Caption  := pIniDir;
    LabDirAtual.Caption := pIniDir;
    DirList.Directory   := pIniDir;
    DriveCBox.Drive     := 'C';
    DriveCBox.Enabled   := lDrive;
    if lDrive
       then DriveCBox.Drive := wDrive;
    LabFiltro.Caption   := pFiltro;
    fileBox.Mask        := pFiltro;
    ShowModal;
  end;
  if Length(Trim(wRetorno)) > 0
  then begin
    pRetorno := wRetorno;
    Result   := True;
  end;
  FuExplorar.Free;

end;

procedure TFuExplorar.LabDirInicDblClick(Sender: TObject);
begin
  DirList.Directory   := LabDirInic.Caption;

end;

procedure TFuExplorar.FileBoxDblClick(Sender: TObject);
begin
  wRetorno := FileBox.FileName;

end;

procedure TFuExplorar.btCancelarClick(Sender: TObject);
begin
  wRetorno := '';
  Close;

end;

procedure TFuExplorar.btOkClick(Sender: TObject);
begin
  Close;

end;

procedure TFuExplorar.DirListChange(Sender: TObject);
begin
  wRetorno := DirList.Directory;
  
end;

end.
