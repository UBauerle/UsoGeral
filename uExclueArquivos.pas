unit uExclueArquivos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, CheckLst, FileCtrl, DateUtils;
  Function Exclue_Arquivos(pmtPath,pmtMask:String;pmtDias:Integer): Integer;

type
  TFuExclueArquivos = class(TForm)
    FLBox: TFileListBox;
    Memo1: TMemo;
    Memo2: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    LabInform: TLabel;
    BtExclus: TBitBtn;
    BtCanc: TBitBtn;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    LabPath: TLabel;
    LabMasc: TLabel;
    LabAuxil: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure BtCancClick(Sender: TObject);
    procedure BtExclusClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuExclueArquivos: TFuExclueArquivos;
  nExclus: Integer;
  wPath,wMask: String;
  wDias: Integer;

implementation

{$R *.dfm}

Function Exclue_Arquivos(pmtPath,pmtMask:String;pmtDias:Integer): Integer;
begin
  FuExclueArquivos := TFuExclueArquivos.Create(nil);
  with FuExclueArquivos
  do begin
    Caption := 'Exclusão de arquivos';
    wPath := pmtPath;
    wMask := pmtMask;
    wDias := pmtDias;
    nExclus := 0;
    ShowModal;
    Result := nExclus;
    Release;
  end;

end;

procedure TFuExclueArquivos.FormActivate(Sender: TObject);
var wFile: String;
    i,j,fAge: Integer;
    dtExclus,dtFile: TDateTime;

begin
  LabAuxil.Top := 1;
  LabAuxil.Left := 4;
  LabAuxil.Visible := False;

  if wDias < 0 then wDias := 0;
  dtExclus := DateOf(Date - wDias);
  LabPath.Caption := wPath;
  LabMasc.Caption := wMask;
  nExclus := 0;

  Memo1.Lines.Clear;
  Application.ProcessMessages;
  FLBox.Clear;
  FLBox.Directory := wPath;
  FLBox.Mask := wMask;
  FLBox.Refresh;

  for j := 0 to FLBox.Items.Count-1
  do begin
    wFile := wPath + FLBox.Items[j];
    fAge := FileAge(wFile);
    dtFile := DateOf(FileDateToDateTime(fAge));
    if dtFile <= dtExclus
    then begin
      LabAuxil.Caption := wFile;
      if FuExclueArquivos.Width < (LabAuxil.Width + 24)
         then FuExclueArquivos.Width := LabAuxil.Width + 24;
      Memo1.Lines.Add(wFile);
      if (Memo1.Lines.Count mod 10) = 0
      then begin
        nExclus := Memo1.Lines.Count;
        LabInform.Caption := IntToStr(nExclus) + ' arquivos encontrados';
        Application.ProcessMessages;
      end;
    end;
  end;
  nExclus := Memo1.Lines.Count;
  LabInform.Caption := IntToStr(nExclus) + ' arquivos encontrados';
  Application.ProcessMessages;

  if nExclus = 0
  then begin
    LabInform.Caption := '';
    Memo1.Lines.Add('*****  Não há arquivos a excluir  ******');
    BtExclus.Enabled := False;
    BtCanc.Caption := '&Sair';
  end
  else begin
    LabInform.Caption := IntToStr(nExclus) + ' arquivos';
    BtExclus.Enabled := True;
  end;

end;

procedure TFuExclueArquivos.BtCancClick(Sender: TObject);
begin
  nExclus := -1;
  FuExclueArquivos.Close;

end;

procedure TFuExclueArquivos.BtExclusClick(Sender: TObject);
var i: Integer;
    exFile: String;
begin
  nExclus := -1;
  if  MessageDlg('Confirme a exclusão do(s) arquivo(s) relacionado(s)',
                 mtConfirmation,[mbNo,mbyes],0) <> mrYes
  then Exit;
  nExclus := 0;
  for i := 0 to Memo1.Lines.Count-1
  do begin
    exFile := Trim(Memo1.Lines[i]);
    if FileExists(exFile)
    then begin
      DeleteFile(exFile);
      nExclus := nExclus + 1;
    end;
  end;
  FuExclueArquivos.Close;

end;

procedure TFuExclueArquivos.FormResize(Sender: TObject);
begin
  if FuExclueArquivos.Width < 268 then FuExclueArquivos.Width := 268;
  if FuExclueArquivos.Height < 480 then FuExclueArquivos.Height := 480;
  FuExclueArquivos.Left := (Screen.Width - FuExclueArquivos.Width) div 2;
  FuExclueArquivos.Top := (Screen.Height - FuExclueArquivos.Height) div 2;
  Memo2.Left := Memo1.Left;
  Memo2.Width := Memo1.Width;

end;

end.
