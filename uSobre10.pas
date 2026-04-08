unit uSobre10;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
     Buttons, ExtCtrls, DateUtils, ShellApi, URLMon;

Function  Versao(Pgma:String;Info:Integer;Modo:Boolean): String;
Procedure ExibeSobre(pmtCaption,pmtProductName,pmtPgmName,pmtContact,pmtEMail,pmtFone:String;
                     pmtWhats:String='';
                     pmtDLL:String='');

type
  TFSobre = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Information: TLabel;
    Panel2: TPanel;
    OKButton: TButton;
    ProgramName: TLabel;
    btWeb: TBitBtn;
    Label1: TLabel;
    ContactName: TLabel;
    Image1: TImage;
    eMail: TLabel;
    Image2: TImage;
    FoneNumber: TLabel;
    Image3: TImage;
    WhatsNr: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure eMailClick(Sender: TObject);
    procedure btWebClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSobre: TFSobre;

implementation

uses uGenericas;

{$R *.dfm}
//
//
Function Versao(Pgma:String;Info:Integer;Modo:Boolean): String;
//   Pgma...: Nome do programa / dll
//   Info...: Informação à ser obtida, cfe Key  0-> Todas
//   Modo...: True-> Com identificação (key(s));  False-> Sem identificação
var Dummy: THandle;
    BuffSize,Len,i: LongInt;
    Buffer: PChar;
    LoCharSet,HiCharSet: Word;
    Translate,Return: Pointer;
    StrFileInfo: string;
    Aux,Arq: String;
    WResult: Array[1..11] of String;
    DtAux: TDateTime;
    HrAux: TTime;
    AA,MM,DD,HH,Mn,Ss,Ms: Word;
    wFil19: String;
    pArquivo: PChar;
    {
     Parquivo: Pchar;
   Arquivo : string;
begin
   Arquivo := Application.ExeName;
   Parquivo := StrAlloc(Length(Arquivo) + 1);
   StrPcopy(Parquivo, Arquivo);
   Len := GetFileVersionInfoSize(Parquivo, Handle);

    }

const Key: array[1..15] of string =   ('CompanyName',
                                       'FileDescription',
                                       'FileVersion',
                                       'InternalName',
                                       'LegalCopyright',
                                       'OriginalFilename',
                                       'ProductName',
                                       'ProductVersion',
                                       'Comments',
                                       'Comment1',
                                       'Comment2',
                                       'Comment3',
                                       'Comment4',
                                       'Comment5',
                                       'Comment6');

      KeyBrz: array[1..11] of string =('Desenvolvimento..',
                                       'Descrição........',
                                       'Versão...........',
                                       'Nome interno.....',
                                       'Copyright........',
                                       'Nome original....',
                                       'Produto..........',
                                       'Versão do produto',
                                       'Comentários......',
                                       'Compilado em.....',
                                       'Hora compilação..');


begin
  Result := '';
  Arq := Pgma;
  if not FileExists(Arq)
  then begin
    Arq := Pgma + '.exe';
    if not FileExists(Arq)
    then begin
      Arq := Pgma + '.dll';
      if not FileExists(Arq) then Exit;
    end;
  end;
  wFil19 := #13;
  for i := 1 to 19
    do wFil19 := wFil19 + ' ';
  //
  pArquivo := StrAlloc(Length(Arq) + 1);
  StrPcopy(pArquivo, Arq);
  BuffSize := GetFileVersionInfoSize(pArquivo, Dummy);
  if BuffSize = 0 then Exit;

  GetMem(Buffer, Succ(BuffSize));
  Try
    if GetFileVersionInfo(PChar(Arq), 0, BuffSize, Buffer)
    then begin
      if VerQueryValue(Buffer, '\VarFileInfo\Translation', Translate, UINT(Len))
      then begin
        LoCharSet := LoWord(Longint(Translate^));
        HiCharSet := HiWord(Longint(Translate^));
        for i := 1 to Length(Key)
        do begin
          Aux := '';
          StrFileInfo := Format('\StringFileInfo\0%x0%x\%s', [LoCharSet, HiCharSet, Key[i]]);
          if VerQueryValue(Buffer, PChar(StrFileInfo), Return, UINT(Len)) then Aux := PChar(Return);
          if Length(Trim(Aux)) = 0 then Aux := 'N.I.';
          if i < 10
          then WResult[i] := Aux
          else begin
            if Aux <> 'N.I.'
            then WResult[9] := WResult[9] + wFil19 + Aux;
          end;
        end;

      end;
    end;

  Finally
    FreeMem(Buffer, Succ(BuffSize));

  End;

  DtAux := FileDateToDateTime(FileAge(Arq));
  DecodeDateTime(DtAux,AA,MM,DD,HH,Mn,Ss,Ms);
  DtAux := EncodeDate(AA,MM,DD);
  HrAux := EncodeTime(HH,Mn,Ss,Ms);
  WResult[10] := DateToStr(DtAux);
  WResult[11] := Copy(TimeToStr(HrAux),1,8);

  if Modo
  then for i := 1 to Length(KeyBrz)
       do WResult[i] := KeyBrz[i] + ': ' + WResult[i];

  if Info <> 0 then Result := WResult[Info]
  else begin
    Result := '';
    for i := 1 to Length(KeyBrz)
    do if Pos('N.I.',WResult[i]) = 0 then Result := Result + WResult[i] + #13;
  end;

end;

Procedure ExibeSobre(pmtCaption,pmtProductName,pmtPgmName,pmtContact,pmtEMail,pmtFone:String;
                     pmtWhats:String='';
                     pmtDLL:String='');
var exibName: String;
    dllVers,dllInfo: String;
begin
  exibName := ExtractFileName(pmtPgmName);
  FSobre   := TFSobre.Create(nil);
  with FSobre
  do begin
    dllVers := '';
    dllInfo := '';
    if pmtDLL <> ''
    then begin
      dllVers       := Versao(pmtDLL,3,False);
      dllInfo       := Versao(pmtDLL,0,True);
      FSobre.Height := FSobre.Height + 100;
    end;
    FSobre.Caption      := pmtCaption;
    ProductName.Caption := pmtProductName;
    ProgramName.Caption := exibName;
    Version.Caption     := Versao(pmtPgmName,3,False);
    Information.Caption := Versao(pmtPgmName,0,True);
    if pmtDLL <> ''
    then Information.Caption := Information.Caption + #13 +
                                'DLL: ' + pmtDLL + ' Versão: ' + dllVers + #13 +
                                'Info: ' + dllInfo;
    ContactName.Caption := pmtContact;
    eMail.Caption       := pmtEMail;
    FoneNumber.Caption  := pmtFone;
    if Length(Trim(pmtWhats)) > 0
    then begin
      Image3.Visible  := True;
      WhatsNr.Visible := True;
      WhatsNr.Caption := pmtWhats;
    end;
    FSobre.Width        := Information.Width + 40;
    if FSobre.Width < 310 then FSobre.Width := 310;
  end;
  FSobre.ShowModal;
  FSobre.Free;

end;


procedure TFSobre.FormCreate(Sender: TObject);
begin
  width := Screen.Width;

end;

procedure TFSobre.eMailClick(Sender: TObject);
var strMsg: string;
begin
  if ConexaoInternet2(True)        
  then begin
    strMsg := 'mailto:' + EMail.Caption +
              '?Subject=Informações - ' +
              ProductName.Caption + '/' + Version.Caption +
              '&Body=Digite aqui o seu texto';
    ShellExecute (Handle,'open',pChar(strMsg),'','', SW_SHOW);
  end;

end;

procedure TFSobre.btWebClick(Sender: TObject);
begin
// ShowMessage('HLinkNavigateString(nil,"endereco") - Uses URLMON');
//  HlinkNavigateString(nil,'http://www.google.com.br');   // 'https://nfg.sefaz.rs.gov.br/');

end;

end.

