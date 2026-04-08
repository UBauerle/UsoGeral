unit uXMLNFe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, StdCtrls, Buttons, msxmldom, XMLDoc, ComCtrls,
  ExtCtrls;
  Function RegE_LeituraXML(pArqXML:String; pArqRetorno:String; pVisualiza:Boolean): Boolean;
  procedure GenerateTree(XMLNode: IXMLNode; TreeNode: TTreeNode);

type
  TFuXMLNfe = class(TForm)
    XMLDocument1: TXMLDocument;
    Panel1: TPanel;
    btFinaliza: TButton;
    Panel2: TPanel;
    TreeView1: TTreeView;
    Label1: TLabel;
    Panel3: TPanel;
    Label2: TLabel;
    MemRetorno: TMemo;
    btProcessar: TBitBtn;
    Panel4: TPanel;
    GroupBox2: TGroupBox;
    LabArqXML: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LabArqRetorno: TLabel;
    procedure btFinalizaClick(Sender: TObject);
    procedure btProcessarClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  FuXMLNfe: TFuXMLNfe;
  ArqXML, ArqRetorno: String;

implementation

uses uIniGeral;


{$R *.dfm}

{ TFuXMLNFe }

procedure GenerateTree(XMLNode: IXMLNode; TreeNode: TTreeNode);
var
  NodeText : string;
  NewTreeNode: TTreeNode;
  I : Integer;
begin
  if XMLNode.NodeType <> ntElement
     then Exit;
  NodeText := XMLNode.NodeName;
  if XMLNode.IsTextElement
     then NodeText    := NodeText + '=' + XMLNode.NodeValue;
  NewTreeNode := FuXMLNFe.TreeView1.Items.AddChild(TreeNode, NodeText);
  if XMLNode.HasChildNodes
  then for I := 0 to XMLNode.ChildNodes.Count - 1
       do GenerateTree(XMLNode.ChildNodes[I], NewTreeNode);

end;


Function FormataNumero(pNro:Integer; pTam:Integer=3): String;
begin
  Result := IntToStr(pNro);
  while Length(Result) < pTam
  do Result := '0' + Result;

end;


Function ObtemChaveNFe(pEntra:TStringList): String;
var i,nP: Integer;
begin
  Result := '';
  for i  := (pEntra.Count-1) downto 0
  do if Pos('chNFe', pEntra[i]) > 0
     then begin
       nP := Pos('=',  pEntra[i]);
       if nP > 0
       then begin
         Result := Copy(pEntra[i],nP+1,Length(pEntra[i])-nP);
         break;
       end;
     end;

end;

{
Function MontaIdentificacao(pEntra:TStringList; pSaida:TStringList): Boolean;
var
  i,nP,lIni,lFin: Integer;
  wLinha,wTag,wTexto: String;
begin
  Result := True;
  lIni   := 99999;
  lFin   := -1;
  for i  := 0 to pEntra.Count-1
  do begin
    nP := Pos('ide', pEntra[i]);
    if nP = 4
    then begin
      lIni := i + 1;
      Break;
    end;
  end;
  for i  := lIni to pEntra.Count-1
  do begin
    nP := Pos('emit', pEntra[i]);
    if nP = 4
    then begin
      lFin := i - 1;
      Break;
    end;
  end;
  pSaida.Add('[Identificacao]');
  for i := lIni to lFin
  do begin
    wLinha := pEntra[i];
    nP     := Pos('=',wLinha);
    if nP > 0
    then begin
      wTag   := Copy(wLinha,1,nP-1);
      wTexto := Copy(wLinha,np+1,Length(wLinha)-np);
      pSaida.Add(wTag + '=' + wTexto);
    end;
  end;
  pSaida.Add('');

end;
}


Function MontaIniXML(pEntra:TStringList; pSaida:TStringList; pTag,pLabel,pNextTag:String): Boolean;
var
  lIni,lFin: Integer;
  i,nivIni,nivFin,nP: Integer;
  wTag,wTexto,wLinha: String;
begin
  Result := False;
  lIni   := 0;
  lFin   := pEntra.Count-1;
  for i  := 0 to pEntra.Count-1
  do begin
    nivIni := Pos(pTag, pEntra[i]);
    nP     := Pos('=',  pEntra[i]);
    if (nivIni > 0) and (nP = 0)
    then begin
      lIni   := i + 1;
      break;
    end;
  end;
  if nivIni = 0 then Exit;
  //
  if Length(Trim(pNextTag)) <> 0
  then begin
    for i := lIni to pEntra.Count-1
    do begin
      nivFin := Pos(pNextTag, pEntra[i]);
      if (nivFin = nivIni) or (nivFin = (nivIni+1))
      then begin
        lFin := i - 1;
        break;
      end;
    end;
  end;
  //
  pSaida.Add('[' + pLabel + ']');
  for i := lIni to lFin
  do begin
    wLinha := Trim(pEntra[i]);
    nP     := Pos('=',wLinha);
    if nP > 0
    then begin
      wTag   := Copy(wLinha,1,nP-1);
      wTexto := Copy(wLinha,np+1,Length(wLinha)-np);
      if (wTag = 'CNPJ') or (wTag = 'CPF') then wTag := 'CNPJCPF';
      pSaida.Add(wTag + '=' + wTexto);
    end;
  end;
  pSaida.Add('');
  //
  Result := True;

end;


{
Function MontaDetalhes(pEntra:TStringList; pSaida:TStringList): Boolean;
var
  i,nP: Integer;
  wTag,wTexto,wLinha: String;
  lChar: Boolean;
begin
  Result := False;
  for i  := 0 to pEntra.Count-1
  do begin
    wLinha := Trim(pEntra[i]);
    nP     := Pos('=',wLinha);
    if nP > 0
    then begin
      wTag   := Copy(wLinha,1,nP-1);
      wTexto := Copy(wLinha,np+1,Length(wLinha)-np);
      pSaida.Add(wTag + '=' + wTexto);
    end;
  end;
  pSaida.Add('');
  Result := True;

end;
}

Function MontaDetalhes(pEntra:TStringList; pSaida:TStringList): Boolean;
var
  i: Integer;
  wLinha: String;
begin
  Result := False;
  for i  := 0 to pEntra.Count-1
  do begin
    wLinha := Trim(pEntra[i]);
    pSaida.Add(wLinha);
  end;
  pSaida.Add('');
  Result := True;

end;


Function MontaLancamentos(pEntra:TStringList; pSaida:TStringList): Boolean;
var
  i,iniProd,ctaProd,finProd,nP: Integer;
  wSeq: String;
  wTxtAuxil: TStringList;
begin
  Result    := False;
  iniProd   := 0;
  finProd   := 0;
  wTxtAuxil := TStringList.Create;
  //
  for i := 0 to pEntra.Count-1
  do if Trim(pEntra[i]) = 'det'                       // Pos('det',pEntra[i]) = 4
     then begin
        iniProd := i;
        break;
     end;
  for i := pEntra.Count-1 downto iniProd
  do if Trim(pEntra[i]) = 'total'                     // Pos('total',pEntra[i]) = 4
     then begin
       finProd := i;
       break;
     end;
  //
  ctaProd := 0;
  i       := iniProd;
  while i < finProd
  do begin
    if Trim(pEntra[i]) = 'prod'                       // Pos('prod',pEntra[i]) = 5
    then begin
      ctaProd := ctaProd + 1;
      wSeq    := FormataNumero(ctaProd,3);
      pSaida.Add('[Produto' + wSeq + ']');
      pSaida.Add('nItem=' + IntToStr(ctaProd));
      wTxtAuxil.Clear;
      i  := i + 1;
      nP := Pos('ICMS',pEntra[i]);
      while nP = 0
      do begin
        wTxtAuxil.Add(pEntra[i]);
        i     := i + 1;
        nP    := Pos('ICMS',pEntra[i]);
      end;
      MontaDetalhes(wTxtAuxil, pSaida);
    end;

    if Trim(pEntra[i]) = 'ICMS'                       // Pos('ICMS',pEntra[i]) = 6
    then begin
      wTxtAuxil.Clear;
      wTxtAuxil.Add('[ICMS' + wSeq + ']');
      i       := i + 1;
      nP      := Pos('IPI',pEntra[i]) + Pos('PIS',pEntra[i]) + Pos('COFINS',pEntra[i]) + Pos('det',pEntra[i]) + Pos('total',pEntra[i]);
      while nP = 0
      do begin
        wTxtAuxil.Add(pEntra[i]);
        i     := i + 1;
        nP    := Pos('IPI',pEntra[i]) + Pos('PIS',pEntra[i]) + Pos('COFINS',pEntra[i]) + Pos('det',pEntra[i]) + Pos('total',pEntra[i]);
      end;
      MontaDetalhes(wTxtAuxil, pSaida);
    end;

    if Trim(pEntra[i]) = 'IPI'                        // Pos('IPI',pEntra[i]) = 6
    then begin
      wTxtAuxil.Clear;
      wTxtAuxil.Add('[IPI' + wSeq + ']');
      i       := i + 1;
      nP      := Pos('PIS',pEntra[i]) + Pos('COFINS',pEntra[i]) + Pos('det',pEntra[i]) + Pos('total',pEntra[i]);
      while nP = 0
      do begin
        wTxtAuxil.Add(pEntra[i]);
        i     := i + 1;
        nP    := Pos('PIS',pEntra[i]) + Pos('COFINS',pEntra[i]) + Pos('det',pEntra[i]) + Pos('total',pEntra[i]);
      end;
      MontaDetalhes(wTxtAuxil, pSaida);
    end;

    if Trim(pEntra[i]) = 'PIS'                        // Pos('PIS',pEntra[i]) = 6
    then begin
      wTxtAuxil.Clear;
      wTxtAuxil.Add('[PIS' + wSeq + ']');
      i       := i + 1;
      nP      := Pos('COFINS',pEntra[i]) + Pos('det',pEntra[i]) + Pos('total',pEntra[i]);
      while nP = 0
      do begin
        wTxtAuxil.Add(pEntra[i]);
        i     := i + 1;
        nP    := Pos('COFINS',pEntra[i]) + Pos('det',pEntra[i]) + Pos('total',pEntra[i]);
      end;
      MontaDetalhes(wTxtAuxil, pSaida);
    end;

    if Trim(pEntra[i]) = 'COFINS'                     // Pos('COFINS',pEntra[i]) = 6
    then begin
      wTxtAuxil.Clear;
      wTxtAuxil.Add('[COFINS' + wSeq + ']');
      i       := i + 1;
      nP      := Pos('det',pEntra[i]) + Pos('total',pEntra[i]);
      while nP = 0
      do begin
        wTxtAuxil.Add(pEntra[i]);
        i     := i + 1;
        nP    := Pos('det',pEntra[i]) + Pos('total',pEntra[i]);
      end;
      MontaDetalhes(wTxtAuxil, pSaida);
    end;

    i := i + 1;
  end;
  wTxtAuxil.Free;

end;

Function MontaDuplicatas(pEntra:TStringList; pSaida:TStringList): Boolean;
var
  i,iniDup,ctaDup,finDup: Integer;
  wSeq: String;
  wTxtAuxil: TStringList;
begin
  Result    := False;
  iniDup    := -1;
  finDup    := -1;
  //
  for i := 0 to pEntra.Count-1
  do if Pos('dup',pEntra[i]) = 5
     then begin
        iniDup := i;
        break;
     end;
  if iniDup < 0 then Exit;
  for i := pEntra.Count-1 downto iniDup
  do if Pos('pag',pEntra[i]) = 4
     then begin
       finDup := i - 1;
       break;
     end;
  if finDup < 0 then Exit;
  //
  wTxtAuxil := TStringList.Create;
  ctaDup := 0;
  i      := iniDup;
  while i < finDup
  do begin
    if Pos('dup',pEntra[i]) = 5
    then begin
      ctaDup := ctaDup + 1;
      wSeq   := FormataNumero(ctaDup,3);
      wTxtAuxil.Clear;
      wTxtAuxil.Add('[Duplicata' + wSeq + ']');
      wTxtAuxil.Add(pEntra[i+1]);
      wTxtAuxil.Add(pEntra[i+2]);
      wTxtAuxil.Add(pEntra[i+3]);
      MontaDetalhes(wTxtAuxil, pSaida);
      i      := i + 4;
    end;
  end;
  wTxtAuxil.Free;

end;

Procedure AjustaPontoDecimalDatas(pStrlist: TStringList);
var i,nP,nA,nSeq: Integer;
    wLinha,AA,MM,DD: String;
    pesqChr,novoChr: Char;
begin
  for i := 0 to pStrlist.Count-1
  do begin
    wLinha := pStrList[i];
    nP := Pos('dhEmi',wLinha);
    nA := Pos('dEmi', wLinha);
    if (nP > 0) or (nA > 0)
    then begin
      nP := Pos('=',wLinha);
      AA := Copy(wLinha,nP+1,4);
      MM := Copy(wLinha,nP+6,2);
      DD := Copy(wLinha,nP+9,2);
      pStrlist[i] := 'dEmi=' + DD + '/' + MM + '/' + AA;    // + Copy(wLinha,nP+11,8);
      Break;
    end;
  end;
  //
  pesqChr := ',';
  novoChr := '.';
  if DecimalSeparator = ','
  then begin
    pesqChr := '.';
    novoChr := ',';
  end;
  nSeq := 0;
  nP   := 0;
  while nP = 0
  do begin
    nP   := Pos('Produto',pStrlist[nSeq]);
    nSeq := nSeq + 1;
  end;
  for i := nSeq to pStrList.Count-1
  do begin
    wLinha := pStrList[i];
    nP     := Pos(pesqChr, wLinha);
    while nP > 0
    do begin
      wLinha[nP] := novoChr;
      nP         := Pos(pesqChr, wLinha);
    end;
    if Pos('dVenc',wLinha) > 0
    then begin
      nP := Pos('=',wLinha);
      AA := Copy(wLinha,nP+1,4);
      MM := Copy(wLinha,nP+6,2);
      DD := Copy(wLinha,nP+9,2);
      wLinha := Copy(wLinha,1,nP) + DD + '/' + MM + '/' + AA;
    end;
    pStrList[i] := wLinha;
  end;

end;


Procedure RetiraTabs(var pTexto:TstringList);
var i,j: Integer;
    wLine,wAuxil: String;
    xTab: char;
begin
  xTab  := Chr(9);
  for i := 0 to pTexto.Count-1
  do begin
    wLine  := pTexto[i];
    wAuxil := '';
    for j  := 1 to Length(wLine)
    do if wLine[j] > xTab
       then wAuxil := wAuxil + wLine[j];
    pTexto[i] := wAuxil;
  end;

end;


Procedure ExecutaProcesso;
var wTextoXML: TStringList;
    wTxtRetorno: TStringList;
    arqTreeView: String;
begin
  FuXMLNFe.MemRetorno.Lines.Clear;
  FuXMLNFe.XMLDocument1.LoadFromFile(ArqXML);
  FuXMLNFe.TreeView1.Items.Clear;
  FuXMLNFe.XMLDocument1.Active  := True;
  GenerateTree(FuXMLNFe.XMLDocument1.DocumentElement,nil);
  arqTreeView := FuIniGeral.wInicial.PathLocal + 'TreeViewSave.Txt';            // FuIniGeral.appPath
  FuXMLNFe.TreeView1.SaveToFile(arqTreeView);
  //
  wTextoXML   := TStringList.Create;
  wTextoXML.LoadFromFile(arqTreeView);
  RetiraTabs(wTextoXML);
  wTxtRetorno := TStringList.Create;
  wTxtRetorno.Add('OK:');
  wTxtRetorno.Add('ID=' + ObtemChaveNFe(wTextoXML));
  wTxtRetorno.Add('Versao=4');
  wTxtRetorno.Add('');
  MontaIniXML(wTextoXML, wTxtRetorno, 'ide',  'Identificacao', 'emit');
  MontaIniXML(wTextoXML, wTxtRetorno, 'emit', 'Emitente',      'dest');
  MontaIniXML(wTextoXML, wTxtRetorno, 'dest', 'Destinatario',  'det');
  MontaLancamentos(wTextoXML, wTxtRetorno);
  MontaIniXML(wTextoXML, wTxtRetorno, 'total', 'Total', 'transp');
  MontaIniXML(wTextoXML, wTxtRetorno, 'transp', 'Transportador', 'vol');
  MontaIniXML(wTextoXML, wTxtRetorno, 'vol', 'Volume', 'fat');
  MontaIniXML(wTextoXML, wTxtRetorno, 'fat', 'Fatura', 'dup');
  MontaDuplicatas(wTextoXML, wTxtRetorno);
  wTxtRetorno.Add('');
  wTxtRetorno.Add('*** FIM ***');
  AjustaPontoDecimalDatas(wTxtRetorno);

  wTxtRetorno.SaveToFile(ArqRetorno);
  FuXMLNFe.MemRetorno.Lines.LoadFromFile(ArqRetorno);
  DeleteFile(arqTreeView);

  wTextoXML.Free;
  wTxtRetorno.Free;

end;


Function RegE_LeituraXML(pArqXML:String; pArqRetorno:String; pVisualiza:Boolean): Boolean;
begin
  ArqXML      := pArqXML;
  ArqRetorno  := pArqRetorno;
  FuXMLNFe    := TFuXMLNFe.Create(nil);
  with FuXMLNFe
  do begin
    MemRetorno.Lines.Clear;
    LabArqXML.Caption     := pArqXML;
    LabArqRetorno.Caption := pArqRetorno;
    Panel3.BevelWidth     := 1;
    Panel3.Align          := alClient;
    if pVisualiza
       then ShowModal
       else ExecutaProcesso;
    Release;
  end;
  Result := True;

end;


procedure TFuXMLNfe.btFinalizaClick(Sender: TObject);
begin
  FuXMLNFe.Close;

end;

procedure TFuXMLNfe.btProcessarClick(Sender: TObject);
begin
  ExecutaProcesso;
  btFinaliza.SetFocus;
  
end;

end.
