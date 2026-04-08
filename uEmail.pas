unit uEmail;
  // Desenvolvido por Rodrigo Nunes ....
interface

Uses
  Classes, SysUtils, IdSMTP,
  IdMessage, IdSSLOpenSSL,
  IdAttachmentFile, IdExplicitTLSClientServerBase, Mapi, Windows, Forms;

  function EnviarEMail(Para, Assunto, Texto: String; Var Arquivos:TStringList): Integer;

  function EnviarEMailSSL(strUsuario, strSenha, strHost: String; strPorta: Integer; bSSL: Boolean;
                          strAssunto, strNome, strEmailOrigem, strEmailDestino: String; slMensagem: TStringList;
                          arqsAnexos: TStringList; bTLS: Boolean = False): Boolean;


  function EnviarEMailNovo(
    strUsuario, strSenha, strHost: String; strPorta: Integer; bSSL: Boolean;
    strAssunto, strNome, strEmailOrigem, strEmailDestino, strEmailDestinoCC, strEmailDestinoCCO, strCorpo: String;
    arqsAnexos: TStringList; bTLS: Boolean = False): String;


  Function getDirApp: String;

implementation

Function getDirApp: String;
Begin
  Result:= ExtractFilePath(Application.ExeName);
  If Result[Length(Result)] <> '\' then
    Result:= Result + '\';
End;

{
  de           := Trim(ParamStr(1));
  destinatario := Trim(ParamStr(2));
  assunto      := Trim(ParamStr(3));
  corpo_email  := Trim(ParamStr(4));
}

function EnviarEMail(Para, Assunto, Texto: String;
  Var Arquivos: TStringList): Integer;
  type
   TAttachAccessArray = array [0..0] of TMapiFileDesc;
   PAttachAccessArray = ^TAttachAccessArray;
var
  Msg: TMapiMessage;
  // {lpSender, } lpRecepient: TMapiRecipDesc;
  // FileAttach: TMapiFileDesc;
  //aArquivoEnvio: Array of TMapiFileDesc;
  aArquivoEnvio: PAttachAccessArray;
  SM: TFNMapiSendMail;
  MAPIModule: HModule;
  Flags: Cardinal;
  I: Integer;
  Destinatario: String;
  Destinatarios: Array of TMapiRecipDesc;
  // Destinatarios: Array [0..30] of TMapiRecipDesc;
  // WndList: Pointer;
  // MAPI_Session: Cardinal;
  // dwRet: Cardinal;
begin
  // dwRet := MapiLogon(Application.Handle ,PChar(''),PChar(''),MAPI_LOGON_UI or MAPI_NEW_SESSION,0, @MAPI_Session);


  // cria propriedades da mensagem
  FillChar(Msg, SizeOf(Msg), 0);
  With Msg do
    begin
      if (Assunto <> '') then
        lpszSubject := StrNew(PAnsiChar(AnsiString(Assunto))); // PChar(Assunto);

      if (Texto <> '') then
        lpszNoteText := StrNew(PAnsiChar(AnsiString(Texto))); //  PChar(Texto);

      // remetente
      {
      if (De <> '') then
        begin
          lpSender.ulRecipClass := MAPI_ORIG;
          lpSender.lpszName := PChar(De);
          lpSender.lpszAddress := PChar(De);
          lpSender.ulReserved := 0;
          lpSender.ulEIDSize := 0;
          lpSender.lpEntryID := nil;
          lpOriginator := @lpSender;
        end;
      }


      
      // destinatário
      if (Para <> '') then
        begin
          Para:= Para + ';';
          nRecipCount := 0;

          While Pos(';', Para) > 0 Do
          Begin
            Destinatario:= Copy(Para,  1, Pos(';', Para)-1);
            Para:= Copy(Para, Length(Destinatario)+2, 255);
            if Trim(Destinatario) <> EmptyStr then
            Begin
              Inc(nRecipCount);
              SetLength(Destinatarios, nRecipCount);

              //Destinatarios[nRecipCount-1].ulRecipClass:= MAPI_CC; // ou ainda MAPI_BCC
              Destinatarios[nRecipCount-1].ulRecipClass:= MAPI_TO;
              //Destinatarios[nRecipCount-1].lpszAddress:= StrNew(PChar('SMTP:'+Destinatario));
              //Destinatarios[nRecipCount-1].lpszName := StrNew(PChar(Destinatario));
              Destinatarios[nRecipCount-1].lpszAddress:= StrNew(PAnsiChar(AnsiString(('SMTP:'+Destinatario))));
              Destinatarios[nRecipCount-1].lpszName := StrNew(PAnsiChar(AnsiString((Destinatario))));
              Destinatarios[nRecipCount-1].ulReserved:= 0;
              Destinatarios[nRecipCount-1].ulEIDSize:= 0;
              Destinatarios[nRecipCount-1].lpEntryID:= Nil;
            End;
          End;
          lpRecips:= @Destinatarios[0];
        end
      else
        lpRecips := nil;

        

      // arquivo anexo
      {
      if (Arquivo = '') then
        begin
          nFileCount := 0;
          lpFiles := nil;
        end
      else
        begin
          FillChar(FileAttach, SizeOf(FileAttach), 0);
          FileAttach.nPosition := Cardinal($FFFFFFFF);
          FileAttach.lpszPathName := PChar(Arquivo);
          nFileCount := 1;
          lpFiles := @FileAttach;
        end;

          {
          FillChar(FileAttach, SizeOf(FileAttach), 0);
          FileAttach.nPosition := Cardinal($FFFFFFFF);
          // FileAttach.lpszPathName := PChar('C:\METHOS5New\fnt\Delphi\sendmail2\sm.cfg;C:\METHOS5New\fnt\Delphi\sendmail2\sm.dof');
          FileAttach.lpszPathName := PChar('C:\METHOS5New\fnt\Delphi\sendmail2\sm.cfg');
          nFileCount := 1;
          lpFiles := @FileAttach;
        }

  // SetLength(aArquivoEnvio, 2);
    // aArquivoEnvio: PAttachAccessArray;
    If Assigned(Arquivos) and (Arquivos.Count > 0) Then
    Begin
      GetMem(aArquivoEnvio, SizeOf(TMapiFileDesc) * Arquivos.Count);
      For I:= 0 To Arquivos.Count-1 Do
      Begin
        aArquivoEnvio[I].ulReserved := 0;
        aArquivoEnvio[I].flFlags := 0;
        aArquivoEnvio[I].nPosition := ULONG($FFFFFFFF);
        //aArquivoEnvio[I].lpszPathName := StrNew(PChar(Arquivos[I]));
        aArquivoEnvio[I].lpszPathName := StrNew(PAnsiChar(AnsiString(Arquivos[I])));
        aArquivoEnvio[I].lpszFileName := Nil;
        aArquivoEnvio[I].lpFileType := Nil;
      End;
      nFileCount:= Arquivos.Count;
      lpFiles   := @aArquivoEnvio^;
    End;
  End;

  // carrega dll e o método para envio do email
  MAPIModule := LoadLibrary(PChar(MAPIDLL));
  if MAPIModule = 0 then
    Result := -1
  else
    try
      // if Confirma then
        Flags := MAPI_DIALOG or MAPI_LOGON_UI;
      // else
      //  Flags := 0;
      @SM := GetProcAddress(MAPIModule, 'MAPISendMail');
      if @SM <> nil then
      Begin
        Result := SM(0, Application.Handle, Msg, Flags, 0);
        // WndList := DisableTaskWindows(0);
        {
        Try
          // Result := SM(0, Application.Handle, Msg, Flags, 0);
          // Result := MapiSendMail(0, Application.Handle, Msg, MAPI_DIALOG, 0);
        Finally
          // EnableTaskWindows( WndList );
        End;
        }
      End
      else
        Result := 1;
    finally
      FreeLibrary(MAPIModule);
    end;

  // MapiLogOff(MAPI_Session, Application.Handle, 0, 0);
end;

function EnviarEMailSSL(strUsuario, strSenha, strHost: String; strPorta: Integer; bSSL: Boolean;
                        strAssunto, strNome, strEmailOrigem, strEmailDestino: String; slMensagem: TStringList;
                        arqsAnexos: TStringList; bTLS: Boolean = False): Boolean;
var
  IdMessage1: TIdMessage;
  IdSMTP1: TIdSMTP;
  IdSSLIOHandlerSocket1: TIdSSLIOHandlerSocketOpenSSL;
  iAux, I: Integer;
  sErro: String;
begin
  Result := False;

  IdSMTP1 := TIdSMTP.Create(Nil);
  IdMessage1 := TIdMessage.Create(IdSMTP1);
  IdSSLIOHandlerSocket1 := TIdSSLIOHandlerSocketOpenSSL.Create(IdSMTP1);// TIdSSLIOHandlerSocket.Create(nil);

  try
    try
      with IdMessage1 do
      begin
        Recipients.EMailAddresses := strEmailDestino;
        From.Address := strEmailOrigem;
        From.Name := strNome;
        CCList.EMailAddresses := EmptyStr;
        BccList.EMailAddresses := EmptyStr;
      end;

      with IdSMTP1 do
      begin
        Host := strHost;
        Port := strPorta;
        Username := strUsuario;
        Password := strSenha;


        if bSSL then
        begin
          IOHandler := IdSSLIOHandlerSocket1;
          with IdSSLIOHandlerSocket1 do
          begin
            Destination:= strHost + ':' + IntToStr(strPorta);
            Host       := strHost;
            Port       := strPorta;
            SSLOptions.Method := sslvSSLv23;
            SSLOptions.Mode   := sslmBoth;
          end;
          if strPorta = 587 then
            UseTLS := utUseExplicitTLS
          Else
            UseTLS:= utUseImplicitTLS; // utUseRequireTLS; //
        end
        Else If bTLS Then
        Begin
          idSMTP1.IOHandler                      := IdSSLIOHandlerSocket1;
          IdSSLIOHandlerSocket1.SSLOptions.Method:= sslvTLSv1;
          IdSSLIOHandlerSocket1.SSLOptions.Mode  := sslmClient;
          idSMTP1.UseTLS                         := utUseExplicitTLS;
        End;

      end;

      with IdMessage1 do
      begin
        Priority := mpNormal;
        // Inacreditavelmente, se estive escrito
        // Nota Fiscal Eletronica nao funciona e, parece ser, por causa do tr
        strAssunto:= StringReplace(strAssunto, 'tr', 't r', [rfReplaceAll, rfIgnoreCase]);
        Subject := strAssunto;
        Body.AddStrings(slMensagem);
      end;

      for iAux:= 0 to (arqsAnexos.Count - 1) do
      begin
        if FileExists( arqsAnexos[iAux] ) then
          TIdAttachmentFile.Create(IdMessage1.MessageParts,
                                   arqsAnexos[iAux] // TFileName(arqsAnexos[iAux])
                                   );
      end;

      //IdSMTP1.ConnectTimeout:= 6000;

      for I := 1 to 15 do
        try
          if not IdSMTP1.Connected then
            IdSMTP1.Connect;
          Break;
        except
          on E: Exception do
            if (
                  (Pos('timed', E.Message) > 0) or
                  (Pos('losed', E.Message) > 0) or
//                  (Pos('racefully', E.Message) > 0) or // Connection Closed Gracefully.
                  (Pos('Socket', E.Message) > 0)
                ) then
            Begin
              If (I = 15) Then
                raise Exception.Create(E.Message)
              Else
                Sleep(100);
            End;
        end;

      for I := 1 to 15 do
        try
          If IdSMTP1.Connected and bTLS Then
            IdSMTP1.Authenticate;

          IdSMTP1.Send(IdMessage1);
          Break;
        except
          on E: Exception do
          Begin
            // ShowMessage(E.Message);
            if (
                  (Pos('timed', E.Message) > 0) or
                  (Pos('losed', E.Message) > 0) or
//                  (Pos('racefully', E.Message) > 0) or // Connection Closed Gracefully.
                  (Pos('Socket', E.Message) > 0)
                ) then
            Begin
              If (I = 15) Then
                raise Exception.Create(E.Message)
              Else
                Sleep(100);
            End;
            sErro:= E.Message;
          End;
        end;

      If I > 15 Then
        Raise Exception.Create(sErro)
      Else
        Result := True;
    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    if IdSMTP1.Connected then
      IdSMTP1.Disconnect;

    IdMessage1.Free;
    IdSSLIOHandlerSocket1.Free;
    IdSMTP1.Free;
  end;
end;

function EnviarEMailNovo(
  strUsuario, strSenha, strHost: String; strPorta: Integer; bSSL: Boolean;
  strAssunto, strNome, strEmailOrigem, strEmailDestino, strEmailDestinoCC, strEmailDestinoCCO, strCorpo: String;
  arqsAnexos: TStringList; bTLS: Boolean = False): String;
var
  IdMessage1: TIdMessage;
  IdSMTP1: TIdSMTP;
  IdSSLIOHandlerSocket1: TIdSSLIOHandlerSocketOpenSSL;
  iAux, I: Integer;
  sErro: String;
  slMensagem: TStringList;
begin
  Result := 'OK';

  IdSMTP1 := TIdSMTP.Create(Nil);
  IdMessage1 := TIdMessage.Create(IdSMTP1);
  IdSSLIOHandlerSocket1 := TIdSSLIOHandlerSocketOpenSSL.Create(IdSMTP1);// TIdSSLIOHandlerSocket.Create(nil);

  slMensagem:= TStringList.Create;
  slMensagem.Text:= strCorpo;

  try
    try
      with IdMessage1 do
      begin
        Recipients.EMailAddresses := strEmailDestino;
        CCList.EMailAddresses     := strEmailDestinoCC;
        BccList.EMailAddresses    := strEmailDestinoCCO;
        From.Address := strEmailOrigem;
        From.Name := strNome;
        CCList.EMailAddresses := EmptyStr;
        BccList.EMailAddresses := EmptyStr;
      end;

      with IdSMTP1 do
      begin
        Host := strHost;
        Port := strPorta;
        Username := strUsuario;
        Password := strSenha;


        if bSSL then
        begin
          IOHandler := IdSSLIOHandlerSocket1;
          with IdSSLIOHandlerSocket1 do
          begin
            Destination:= strHost + ':' + IntToStr(strPorta);
            Host       := strHost;
            Port       := strPorta;
            SSLOptions.Method := sslvSSLv23;
            SSLOptions.Mode   := sslmBoth;
          end;
          if strPorta = 587 then
            UseTLS := utUseExplicitTLS
          Else
            UseTLS:= utUseImplicitTLS; // utUseRequireTLS; //
        end
        Else If bTLS Then
        Begin
          idSMTP1.IOHandler                      := IdSSLIOHandlerSocket1;
          IdSSLIOHandlerSocket1.SSLOptions.Method:= sslvTLSv1;
          IdSSLIOHandlerSocket1.SSLOptions.Mode  := sslmClient;
          idSMTP1.UseTLS                         := utUseExplicitTLS;
        End;

      end;

      with IdMessage1 do
      begin
        Priority := mpNormal;
        // Inacreditavelmente, se estive escrito
        // Nota Fiscal Eletronica nao funciona e, parece ser, por causa do tr
        strAssunto:= StringReplace(strAssunto, 'tr', 't r', [rfReplaceAll, rfIgnoreCase]);
        Subject := strAssunto;
        Body.AddStrings(slMensagem);
      end;

      for iAux:= 0 to (arqsAnexos.Count - 1) do
      begin
        if FileExists( arqsAnexos[iAux] ) then
          TIdAttachmentFile.Create(IdMessage1.MessageParts,
                                   arqsAnexos[iAux] // TFileName(arqsAnexos[iAux])
                                   );
      end;

      //IdSMTP1.ConnectTimeout:= 6000;

      for I := 1 to 15 do
        try
          if not IdSMTP1.Connected then
            IdSMTP1.Connect;
          Break;
        except
          on E: Exception do
            if (
                  (Pos('timed', E.Message) > 0) or
                  (Pos('losed', E.Message) > 0) or
//                  (Pos('racefully', E.Message) > 0) or // Connection Closed Gracefully.
                  (Pos('Socket', E.Message) > 0)
                ) then
            Begin
              If (I = 15) Then
              Begin
                Result:= E.Message;
                Exit;
              End
              Else
                Sleep(100);
            End;
        end;

      for I := 1 to 15 do
        try
          If IdSMTP1.Connected and bTLS Then
            IdSMTP1.Authenticate;

          IdSMTP1.Send(IdMessage1);
          Break;
        except
          on E: Exception do
          Begin
            // ShowMessage(E.Message);
            if (
                  (Pos('timed', E.Message) > 0) or
                  (Pos('losed', E.Message) > 0) or
//                  (Pos('racefully', E.Message) > 0) or // Connection Closed Gracefully.
                  (Pos('Socket', E.Message) > 0)
                ) then
            Begin
              If (I = 15) Then
              Begin
                Result:= E.Message;
                Exit;
              End
              Else
                Sleep(100);
            End;
            sErro:= E.Message;
          End;
        end;

      If I > 15 Then
        Result:= sErro;
    except
      on E: Exception do
        Result:= E.Message;
    end;
  finally
    if IdSMTP1.Connected then
      IdSMTP1.Disconnect;

    IdMessage1.Free;
    IdSSLIOHandlerSocket1.Free;
    IdSMTP1.Free;
  end;
End;

{
function EnviarEMailSSL(strUsuario, strSenha, strHost: String; strPorta: Integer; bSSL: Boolean;
                        strAssunto, strNome, strEmailOrigem, strEmailDestino: String; slMensagem: TStringList;
                        arqsAnexos: TStringList): Boolean;
var
  IdMessage1: TIdMessage;
  IdSMTP1: TIdSMTP;
  IdSSLIOHandlerSocket1: TIdSSLIOHandlerSocketOpenSSL; // TIdSSLIOHandlerSocket;
  iAux, I: Integer;
  sErro: String;
  // dm: TForm;
begin
  Result := False;

  IdMessage1 := TIdMessage.Create(Nil);
  IdSMTP1 := TIdSMTP.Create(Nil);
  IdSSLIOHandlerSocket1 := TIdSSLIOHandlerSocketOpenSSL.Create(Nil);// TIdSSLIOHandlerSocket.Create(nil);

  try
    try
      with IdMessage1 do
      begin
        Recipients.EMailAddresses := strEmailDestino;
        From.Address := strEmailOrigem;
        From.Name := strNome;
        CCList.EMailAddresses := EmptyStr;
        BccList.EMailAddresses := EmptyStr;
      end;

      with IdSMTP1 do
      begin
        Host := strHost;
        Port := strPorta;
        Username := strUsuario;
        Password := strSenha;


        if bSSL then
        begin
          // AuthenticationType := atLogin;
          IOHandler := IdSSLIOHandlerSocket1;

          with IdSSLIOHandlerSocket1 do
          begin
            //SSLOptions.Method := sslvTLSv1;
            //SSLOptions.Mode   := sslmUnassigned;
            //SSLOptions.VerifyMode := [];
            //SSLOptions.VerifyDepth := 0;
            Destination:= strHost + ':' + IntToStr(strPorta);
            Host       := strHost;
            Port       := strPorta;
            SSLOptions.Method := sslvSSLv23;
            SSLOptions.Mode   := sslmBoth;
          end;

          UseTLS:= utUseImplicitTLS; // utUseRequireTLS; //
        end;
//        Else
//        Begin
          //Authenticate:= True;
//          AuthType:= satDefault;
//        End;
      end;

      with IdMessage1 do
      begin
        Priority := mpNormal;
        // Inacreditavelmente, se estive escrito
        // Nota Fiscal Eletronica nao funciona e, parece ser, por causa do tr
        strAssunto:= StringReplace(strAssunto, 'tr', 't r', [rfReplaceAll, rfIgnoreCase]);
        Subject := strAssunto;
        Body.AddStrings(slMensagem);
      end;

      for iAux:= 0 to (arqsAnexos.Count - 1) do
      begin
        if FileExists( arqsAnexos[iAux] ) then
          TIdAttachmentFile.Create(IdMessage1.MessageParts,
                                   TFileName(arqsAnexos[iAux]));
      end;

      // IdSMTP1.ReadTimeout:= 30000;

      for I := 1 to 15 do
        try
          if not IdSMTP1.Connected then
            IdSMTP1.Connect;
          Break;
        except
          on E: Exception do
            if (
                  (Pos('timed', E.Message) > 0) or
                  (Pos('losed', E.Message) > 0) or
                  (Pos('Socket', E.Message) > 0)
                ) then
            Begin
              If (I = 15) Then
                raise Exception.Create(E.Message)
              Else
                Sleep(100);
            End;
        end;

      for I := 1 to 15 do
        try
          IdSMTP1.Send(IdMessage1);
          Break;
        except
          on E: Exception do
          Begin
            // ShowMessage(E.Message);
            if (
                  (Pos('timed', E.Message) > 0) or
                  (Pos('losed', E.Message) > 0) or
                  (Pos('Socket', E.Message) > 0)
                ) then
            Begin
              If (I = 15) Then
                raise Exception.Create(E.Message)
              Else
                Sleep(100);
            End;
            sErro:= E.Message;
          End;
        end;

      If I > 15 Then
        Raise Exception.Create(sErro)
      Else
        Result := True;
    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    if IdSMTP1.Connected then
      IdSMTP1.Disconnect;

    IdSMTP1.Free;
    IdSSLIOHandlerSocket1.Free;
    IdMessage1.Free;
  end;
end;
}




end.
