unit uImprimeRAW;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons, Printers, Winspool, ExtCtrls;

type
  TFLstRel = class(TForm)
    LabArq: TLabel;
    LabAviso: TLabel;
    Panel1: TPanel;
    BtLst: TBitBtn;
    BtCanc: TBitBtn;
    CbDelete: TCheckBox;
    CbCopias: TComboBox;
    Label1: TLabel;
    CbEject: TCheckBox;
    procedure BtCancClick(Sender: TObject);
    procedure BtLstClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLstRel: TFLstRel;
const
  WCtles: array[0..3] of String = (#13, #13+#10,
                                   #13+#10+#13+#10,
                                   #13+#10+#13+#10+#13+#10);


implementation

{$R *.DFM}

Function SelecionaImpressora: ShortString; Stdcall; External 'RotGenericas.DLL';


// Imprime arquivo de texto do sistema...
// Tamanhos variáveis, com controles
Procedure ListaRelatorio(FileID:ShortString;NCop:Integer;Excluir,NovaPag,Exibir:Boolean);Stdcall;Export;
begin
  FLstRel := TFLstRel.Create(nil);
  if NCop < 1 then NCop := 1
  else if NCop > 20 then NCop := 20;
  FLstRel.CbCopias.ItemIndex := NCop-1;
  FLstRel.CbDelete.Checked := Excluir;
  FLstRel.CbEject.Checked := NovaPag;
  FLstRel.LabArq.Caption := FileID;
  if Exibir
  then begin
    FLstRel.Width := FLstRel.LabArq.Width + 32;
    if FLstRel.Width < 260 then FLstRel.Width := 260;
    FLstRel.ShowModal;
  end
  else FLstRel.BtLstClick(Nil);
  FLstRel.Release;

end;


procedure TFLstRel.BtCancClick(Sender: TObject);
begin
  FLstRel.Close;

end;

procedure TFLstRel.BtLstClick(Sender: TObject);
var XPrtId,XPrinter,XPorta: String;
    ArqNome,Linha,Ctle: String;
    WCopias,i,j,NCtle: Integer;
    Lista: Boolean;
    Arq: TextFile;
    Handle: THandle;
    N: dWord;
    DocInfo1: TDocInfo1;

begin
  ArqNome := LabArq.Caption;
  if not FileExists(ArqNome)
  then begin
    LabAviso.Visible := True;
    BtLst.Enabled := False;
    BtCanc.SetFocus;
    Exit;
  end;
  XPrtId := SelecionaImpressora;
  if XPrtId = 'NADA##' then Exit;

  i := Pos('##',XPrtId);
  XPrinter := Copy(XPrtId,1,i-1);
  XPorta := Copy(XPrtId,i+2,Length(XPrtId)-(i+1));
  WCopias := StrToIntDef(Trim(CbCopias.Text),1);
  for j := 1 to WCopias
  do begin
    if not(OpenPrinter(PChar(XPrinter),Handle,nil))
    then begin
      MessageDlg('Erro ' + IntToStr(GetLastError) + #13 +
                 'Não é possível imprimir',mtError,[mbOk],0);
      Exit;
    end;
    with DocInfo1 do
    begin
      PDocName := PChar(ArqNome + '-' + IntToStr(j));
      POutPutFile := nil;
      PDataType := 'RAW';
    end;
    StartDocPrinter(Handle,1,@DocInfo1);
    StartPagePrinter(Handle);
    AssignFile(Arq,ArqNome);
    Reset(Arq);
    Lista := True;
    while Lista
    do begin
      ReadLn(Arq,Linha);
      if Length(Linha) = 0 then Lista := False
      else begin
        NCtle := -1;
        for i := 0 to 9
        do begin
          Ctle := '#' + IntToStr(i) + '#';
          if Pos(Ctle,Linha) > 0 then NCtle := i;
        end;
        if NCtle < 0
        then NCtle := 1            // Sem controle, é o mesmo que espaço simples
        else Delete(Linha,1,3);    // Houve controle, retira o ctle da linha
        Linha := Linha + #13;           // Somente CR
        for i := 1 to NCtle
        do Linha := Linha + #10;        // LineFeed (de 1 a 9)
        WritePrinter(Handle,PChar(Linha),Length(Linha),N);
      end;
    end;
    if CbEject.Checked then Linha := chr(12)
                       else Linha := ' ';
    WritePrinter(Handle,PChar(Linha),Length(Linha),N);
    EndPagePrinter(Handle);
    EndDocPrinter(Handle);
    ClosePrinter(Handle);
    CloseFile(Arq);
  end;
  if CbDelete.Checked then DeleteFile(ArqNome);
  FLstRel.Close;

end;


procedure TFLstRel.FormCreate(Sender: TObject);
begin
  Top := 100;
  Left := 100;

end;

end.
