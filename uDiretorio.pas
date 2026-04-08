unit uDiretorio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, FileCtrl, ExtCtrls, Vcl.Menus, IOUtils;
  Function uObtemDiretorio(pCaption: String; var pDiretorio:String): Boolean;

type
  TFuDiretorio = class(TForm)
    DrvUnid: TDriveComboBox;
    Label1: TLabel;
    DirLst: TDirectoryListBox;
    Label2: TLabel;
    Label3: TLabel;
    btOk: TBitBtn;
    btCancelar: TBitBtn;
    PopupMenu1: TPopupMenu;
    Novapasta1: TMenuItem;
    Renomear1: TMenuItem;
    Excluir1: TMenuItem;
    edName: TEdit;
    Panel1: TPanel;
    LabDir: TLabel;
    procedure btOkClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure Novapasta1Click(Sender: TObject);
    procedure Renomear1Click(Sender: TObject);
    procedure DirLstMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edNameExit(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuDiretorio: TFuDiretorio;
  xDiretorio: String;
  xDrive: Char;
  lResult: Boolean;
  wTop,wLeft,wItem: Integer;


implementation

{$R *.dfm}

Function uObtemDiretorio(pCaption: String; var pDiretorio:String): Boolean;
begin
  xDiretorio := pDiretorio;
  if not DirectoryExists(xDiretorio) 
     then xDiretorio := ExtractFilePath(Application.ExeName);
  xDrive      := xDiretorio[1];
  Result      := False;
  FuDiretorio := TFuDiretorio.Create(nil);
  with FuDiretorio
  do begin
    Caption          := pCaption;
    DrvUnid.Text     := xDiretorio;
    DrvUnid.Drive    := xDrive;
    DirLst.Drive     := xDrive;
    DirLst.Directory := xDiretorio;
    DirLst.Update;
    LabDir.Caption   := xDiretorio;
    ShowModal;
    Result           := lResult;
    pDiretorio       := xDiretorio;
    Free;
  end;

end;


procedure TFuDiretorio.btOkClick(Sender: TObject);
begin
  xDiretorio := LabDir.Caption;
  lResult    := True;
  FuDiretorio.Close;

end;

procedure TFuDiretorio.edNameExit(Sender: TObject);
var OldName,NewName: String;
begin
  OldName := DirLst.Items[wItem];
  NewName := edName.Text;
  edName.Visible := False;
  if (Length(Trim(NewName)) = 0) or
     (AnsiUpperCase(OldName) = AnsiUpperCase(NewName)) then Exit;
  if RenameFile(OldName, NewName) then DirLst.Update
  else MessageDlg('Não foi possível renomear o diretório',mtError,[mbOk],0);

end;

procedure TFuDiretorio.Excluir1Click(Sender: TObject);
var wDir: String;
begin
  wItem := DirLst.ItemIndex;
  wDir  := DirLst.Items[wItem];
  Try
    TDirectory.Delete(wDir);
    DirLst.Update;
  Except
    MessageDlg('Não foi possível excluir pasta' + #13 +
                '[ '+ wDir + ' ]',mtWarning,[mbOk],0);
  End;


end;

procedure TFuDiretorio.DirLstMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  wTop  := Y;
  wLeft := X;

end;

procedure TFuDiretorio.Novapasta1Click(Sender: TObject);
var i: Integer;
begin
  xDiretorio := LabDir.Caption + '\Novapasta';
  Try
    TDirectory.CreateDirectory(xDiretorio);
    DirLst.Update;
    wItem := -1;
    for i := 0 to DirLst.Items.Count-1
    do begin
      if (DirLst.Items[i] = 'Novapasta') then
      begin
        wItem := i;
        Break;
      end;
    end;
    if wItem >= 0 then
    begin
      DirLst.ItemIndex := wItem;
      wTop := (wItem * 16) - 6;
      Renomear1Click(nil);
    end;
  Except
    MessageDlg('Não foi possível criar pasta' + #13 +
               '[ '+ xDiretorio + ' ]',mtWarning,[mbOk],0);
  End;

end;

procedure TFuDiretorio.Renomear1Click(Sender: TObject);
begin
  wItem          := DirLst.ItemIndex;
  edName.Text    := DirLst.Items[wItem];
  edName.Top     := DirLst.Top + wTop;
  edName.Left    := DirLst.Left + 40;    // wLeft;
  edName.Visible := True;
  edName.SetFocus;

end;

procedure TFuDiretorio.btCancelarClick(Sender: TObject);
begin
  xDiretorio := '';
  lResult    := False;
  FuDiretorio.Close;

end;

end.
