unit uTabGenericas;

interface

uses Db, DBTables, StdCtrls, Mask, DBCtrls, Controls, Grids, DBGrids,
     Buttons, Classes, ExtCtrls, Forms, SysUtils, Menus, Types, Graphics;
     Procedure ManutTabelas(pmtDBName:String; pmtCod:Integer);
     Function PesquisaTabela(pmtDBName:String; pmtCod:Integer):Integer;

type
  TFTabGener = class(TForm)
    PanCtl: TPanel;
    BtSair: TBitBtn;
    PanManut: TPanel;
    LabAcao: TLabel;
    Label1: TLabel;
    EdCod: TDBEdit;
    TabWrk: TTable;
    STabWrk: TDataSource;
    TabWrkCod: TSmallintField;
    TabWrkDenom: TStringField;
    Label2: TLabel;
    LabAbrev: TLabel;
    EdDenom: TDBEdit;
    EdAbrev: TDBEdit;
    TabWrkAbrev: TStringField;
    RgOrdem: TRadioGroup;
    Grid: TDBGrid;
    DbFixa: TDBCheckBox;
    Panel1: TPanel;
    BtOk: TBitBtn;
    BtCanc: TBitBtn;
    Menu: TMainMenu;
    Topico: TMenuItem;
    Incluir1: TMenuItem;
    Alterar1: TMenuItem;
    Excluir1: TMenuItem;
    Sair1: TMenuItem;
    TabWrkFixa: TBooleanField;
    TabWrkZC_Fixa: TStringField;
    Memo1: TMemo;
    N1: TMenuItem;
    Imprimir1: TMenuItem;
    CadEstoq: TTable;
    CadEstoqItem: TStringField;
    CadEstoqDescr: TStringField;
    N2: TMenuItem;
    RetirarIndicador1: TMenuItem;
    LabLocalizar: TLabel;
    edLocaliz: TEdit;
    dbFPgto: TDBCheckBox;
    TabWrkKPlano: TStringField;
    TabWrkPessoal: TBooleanField;
    Nav: TDBNavigator;
    LabNRegs: TLabel;
    cbDestaq: TCheckBox;
    btTamOrig: TSpeedButton;
    procedure BtSairClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtOkClick(Sender: TObject);
    procedure BtCancClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TabWrkAfterRefresh(DataSet: TDataSet);
    procedure RgOrdemClick(Sender: TObject);
    procedure Incluir1Click(Sender: TObject);
    procedure Alterar1Click(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure TabWrkCalcFields(DataSet: TDataSet);
    procedure Imprimir1Click(Sender: TObject);
    procedure EdAbrevDblClick(Sender: TObject);
    procedure EdAbrevKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure RetirarIndicador1Click(Sender: TObject);
    procedure edLocalizChange(Sender: TObject);
    procedure cbDestaqClick(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btTamOrigClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FTabGener: TFTabGener;
  fTime: Boolean;
  wNrTab,wAcao,wCodRet: Integer;
  xTabela,wCodEst,wRefEst: String;
  vAbrev,vExtra: Boolean;
  UpLoCase: TEditCharCase;

const wIdTabs: array[1..160] of String = ('Grupos de estoque',        'Tb01GES',
                                          '',                          '02',
                                          '',                          '03',
                                          'Zonas/Regiões',             'Tb04ZnR',
                                          'Centros de custos',         'Tb05CCu',
                                          'Rubricas de receita',       'Tb06RRe',
                                          'Rubricas de despesa',       'Tb07RDe',
                                          'Ramos de atividade',        'Tb08RAt',
                                          'Convênios',                 'Tb09Con',
                                          'Eventos',                   'Tb10Eve',
                                          'Profissões',                'Tb11Pro',
                                          'Aparelhos',                 'Tb12Apa',                 // Não é tratado aqui
                                          'Marcas',                    'Tb13Mar',                 // Não é tratado aqui
                                          'Modelos',                   'Tb14Mod',
                                          'Tipo OS',                   'Tb15TpOS',
                                          'Ocorrencia em OS',          'Tb16OcOS',
                                          'Tipos empregados',          'Tb17TpEmpr',
                                          'Defeitos',                  'Tb18Defeitos',            // Não é tratado aqui
                                          'Tipos contratos',           'Tb19Contratos',
                                          'Equipamentos',              'Tb20Equipam',
                                          'Capacidades',               'Tb21Capac',
                                          'Checklist Ferramentas',     'Tb22Ferramentas',
                                          'Checklist Limpeza',         'Tb23Limpeza',
                                          'Material instalação',       'Tb24MatInstal',
                                          'Tipos de gás',              'Tb25TpGas',
                                          'Equipamentos/Imobilizado',  'Tb26GrpImob',
                                          'Tipo de equipamento',       'Tb27TpEquip',
                                          'Motivos de cancelamento',   'Tb28Motivos',
                                          '',                          '29',
                                          'Orçamentos',                'Tb30Orcamentos',
                                          'Marcas',                    'Tb31Marcas',
                                          'Aparelhos',                 'Tb32Aparelhos',
                                          'Tecnicos ',                 'Tb33Tecnicos',
                                          'Status Aparelhos',          'Tb34StApar',
                                          'Transportadoras',           'Tb35Transport',
                                          'Ocorrencias',               'Tb36Ocorrencias',
                                          'Defeitos',                  'Tb37Defeitos',
                                          'Sit.Atendimento',           'Tb38SitAtend',
                                          '',                          '39',
                                          'Atendentes',                'Tb40Atendentes',
                                          'Condições de pagamento',    'Tb41CondPg',           // Não é tratado aqui (CondPagto)
                                          '',                          '42',
                                          'Situacao de Orçamento',     'Tb43Situacao',
                                          'Produto',                   'Tb44Produto',
                                          'Frontal/Papel',             'Tb45Papel',
                                          'Gramat.Papel',              'Tb46GramPapel',
                                          'Adesivos/Colas',            'Tb47Adesivos',
                                          'Gramat.Adesivos',           'Tb48GramAdesiv',
                                          'Tubetes',                   'Tb49Tubetes',
                                          '',                          '50',
                                          'Segmentos',                 'Tb51Segmentos',
                                          '',                          '52',
                                          '',                          '53',
                                          '',                          '54',
                                          'Cursos',                    'Tb55Cursos',
                                          '',                          '56',
                                          '',                          '57',
                                          '',                          '58',
                                          '',                          '59',
                                          '(M/C)Motivos',              'Tb60Motivos',
                                          '(M/C)Tecidos',              'Tb61Tecidos',
                                          '(M/C)Cores',                'Tb62Cores',
                                          '(M/C)Composicoes',          'Tb63Compos',
                                          '(M/C)Tamanhos',             'Tb64Tamanhos',
                                          '(M/C)Lin.Produtos/Tipos',   'Tb65LinProd',
                                          '(M/C)Modelos',              'Tb66Modelos',
                                          '(M/C)Departamentos',        'Tb67Deptos',
                                          '(M/C)Coleções',             'Tb68Colecoes',
                                          '',                           '69',
                                          '',                           '70',
                                          '',                           '71',
                                          '',                           '72',
                                          '',                           '73',
                                          '',                           '74',
                                          '',                           '75',
                                          '',                           '76',
                                          '',                           '77',
                                          '',                           '78',
                                          '',                           '79',
                                          '',                           '80');

implementation

//uses TabGenerLst, uMensagem, PesqEstoques, uIniGeral, uGenericas, FortesReportCtle;

{$R *.DFM}

Procedure ManutTabelas(pmtDBName:String;pmtCod:Integer);
var i: Integer;
    xFile: String;
    wExe: Boolean;
    cTab: TTable;
begin
  wNrTab := pmtCod;
  i := (wNrTab * 2) - 1;
  xTabela := wIdTabs[i];
  if (pmtCod = 12)
     or (pmtCod = 13)
     or (pmtCod = 15)
     or (pmtCod = 16)
     or (pmtCod = 18)
     or (pmtCod = 41)
  then begin
    msgSistema(4,'Tabela [' + IntToStr(pmtCod) + '] ' + wIdTabs[i]
                ,'Tratativa através de rotina específica'
                ,1,1);
    Exit;
  end;
  xFile := FuIniGeral.wInicial.DatabasePath + wIdTabs[i+1] + '.DB';
  wExe := True;
  if not FileExists(xFile)
  then begin
    if msgSistema(2,'Tabela inexistente'
                   ,'Tabela ' + wIdTabs[i+1] + ' não encontrada' + #13
                   + '( ' + xFile + ' )' + #13#13
                   +'Criar tabela ?'
                   ,3,2) = 1
    then begin
      cTab := TTable.Create(nil);
      with cTab
      do begin
        Active       := False;
        DatabaseName := FuIniGeral.wInicial.DatabasePath;
        TableName    := wIdTabs[i+1] + '.DB';
        TableType    := ttDefault;
        FieldDefs.Clear;
        FieldDefs.Add('Cod',    ftSmallint);
        FieldDefs.Add('Denom',  ftString,50);
        FieldDefs.Add('Abrev',  ftString,15);
        FieldDefs.Add('Fixa',   ftBoolean);
        FieldDefs.Add('KPlano', ftString,12);
        FieldDefs.Add('Pessoal',ftBoolean);
        IndexDefs.Clear;
        IndexDefs.Add('','Cod',[ixPrimary,ixUnique]);
        IndexDefs.Add('Abreviada','Abrev;Cod',[]);
        IndexDefs.Add('Alfabetica','Denom;Cod',[]);
        Try
          CreateTable;
        Except
          wExe := False;
        End;
      end;
      cTab.Free;
    end
    else wExe := False;     // Não criar tabela
  end;
  if not wExe
     then Exit;
  FTabGener                       := TFTabGener.Create(nil);
  FTabGener.Caption               := 'Manutenção tabela - ' + wIdTabs[i] + ' (' + wIdTabs[i+1] + ')';
  FTabGener.Topico.Caption        := '&' + wIdTabs[i];
  FTabGener.TabWrk.TableName      := wIdTabs[i+1] + '.Db';
  FTabGener.TabWrk.DatabaseName   := pmtDBName;
  FTabGener.CadEstoq.DatabaseName := pmtDBName;
  FTabGener.CadEstoq.IndexName    := '';
  FTabGener.btSair.Caption        := '&Sair';
  FTabGener.dbFPgto.Visible       := False;
  FTabGener.cbDestaq.Checked      := FuIniGeral.wInicial.LGridLinDestaq;

  if (pmtCod = 6) or (pmtCod = 7)
     then FTabGener.dbFPgto.Visible := True;

  FTabGener.TabWrk.Active := True;
  FTabGener.TabWrk.First;
  while not FTabGener.TabWrk.Eof
  do begin
    FTabGener.TabWrk.Edit;
    if not FTabGener.TabWrkFixa.AsBoolean
       then FTabGener.TabWrkFixa.AsBoolean := False;
    if not FTabGener.TabWrkPessoal.AsBoolean
       then FTabGener.TabWrkPessoal.AsBoolean := False;
    FTabGener.TabWrk.Post;
    FTabGener.TabWrk.Next;
  end;
  FTabGener.TabWrk.Active := False;

  FTabGener.ShowModal;
  FTabGener.Free;

end;


Function PesquisaTabela(pmtDBName:String;pmtCod:Integer):Integer;
var i: Integer;
    xFile: String;
begin
  Result  := -1;
  wNrTab  := pmtCod;
  i       := (wNrTab * 2) - 1;
  xTabela := wIdTabs[i];
  xFile   := FuIniGeral.wInicial.DatabasePath + wIdTabs[i+1] + '.DB';
  if not FileExists(xFile)
  then begin
    msgSistema(4,'Tabela inexistente'
                ,'Tabela ' + wIdTabs[i+1] + ' não encontrada' + #13
                + '( ' + xFile + ' )' + #13#13
                + 'Pesquisa não realizada',1,1);
    Exit;
  end;
  wCodRet   := -1;
  FTabGener := TFTabGener.Create(nil);
  FTabGener.Caption               := 'Consulta dados tabela - ' + wIdTabs[i];
  FTabGener.Topico.Caption        := '&' + wIdTabs[i];
  FTabGener.TabWrk.TableName      := wIdTabs[i+1] + '.Db';
  FTabGener.TabWrk.DatabaseName   := pmtDBName;
  FTabGener.CadEstoq.DatabaseName := pmtDBName;
  FTabGener.CadEstoq.IndexName    := '';
  FTabGener.btSair.Caption        := '&Sair e Utilizar';
  FTabGener.cbDestaq.Checked      := FuIniGeral.wInicial.LGridLinDestaq;
  FTabGener.ShowModal;
  FTabGener.Free;
  Result := wCodRet;

end;


procedure Controle(Act:Integer;Md:Boolean);
var i: Integer;
const Txt: array[1..3] of string = ('Inclusão','Alteração','Consulta');
      Btn: array[1..3] of string = ('&Cancelar/Finalizar','&Cancelar','');
begin
  WAcao := Act;
  with FTabGener
  do begin
    LabAcao.Caption := Txt[Act];
    BtCanc.Caption := Btn[Act];
    PanManut.Enabled := Md;
    BtOk.Visible := Md;
    BtCanc.Visible := Md;
    if Md then Md := False
          else Md := True;
    for i := 0 to Menu.Items.Count-1 do Menu.Items[i].Enabled := Md;
    Grid.Enabled := Md;
    Nav.Enabled := Md;
    BtSair.Enabled := Md;
    RgOrdem.Enabled := Md;
    EdCod.Enabled := False;
    case Act of
      1:begin                // Inclusão
          TabWrk.Append;
          TabWrkFixa.AsBoolean := False;
          EdCod.Enabled := True;
          EdCod.SetFocus;
        end;
      2:EdDenom.SetFocus;    // Alteração
      3:EdCod.Enabled := True;
    end;

  end;

end;


procedure TFTabGener.BtSairClick(Sender: TObject);
begin
  wCodRet := TabWrkCod.AsInteger;
  FTabGener.Close;

end;

procedure TFTabGener.FormActivate(Sender: TObject);
begin
  if not fTime then Exit;
  fTime := False;
  Form_Define(FTabGener);
  RgOrdem.Visible := False;
  RgOrdem.ItemIndex := 0;
  if (wNrTab = 1)              // Grupos de estoques
     or (wNrTab = 4)           // Zonas / Regiões
     or (wNrTab = 6)           // Receitas
     or (wNrTab = 7)           // Despesas
     or (wNrTab = 13)          // Marcas
     or (wNrTab = 14)          // Modelos
     or (wnrTab = 20)          // Equipamentos
     or (wnrTab = 21)          // Capacidades Ar-Condicionado
     or (wnrTab = 65)          // Linhas de produto
     or (wnrTab = 66)          // Modelos - Magazine/Confecção
  then begin
    RgOrdem.Visible := True;
    RgOrdem.ItemIndex := 1;
  end;
  vExtra := False;
  vAbrev := True;
  UpLoCase := ecNormal;
  LabAbrev.Caption := 'Abreviatura';
  TabWrkAbrev.EditMask := '';
  case wnrTab of
    1:begin       // Grupos estoque
        dbFixa.Caption := 'Venda NÃO permitida';
        vExtra         := True;
        Grid.Columns[3].Title.Caption := 'Vendas';
      end;
    6:begin       // Receitas
        DbFixa.Caption := 'Receita fixa';
        vExtra         := True;
        Grid.Columns[3].Title.Caption := 'Tipo receita';
      end;
    7:begin       // Despesas
        DbFixa.Caption := 'Despesa fixa';
        vExtra         := True;
        Grid.Columns[3].Title.Caption := 'Tipo despesa';
      end;
    //13:vAbrev := False;     // Marcas
    //14:vAbrev := False;     // Modelos
    24:begin                // Mat. instalação
         LabAbrev.Caption := 'Cod.estoque';
         CadEstoq.Active  := True;
       end;
    30:begin                // Orçamentos - OS Especiais
         vAbrev   := False;
         upLoCase := ecUppercase;
       end;
    31:begin                // Marcas - OS Especiais
         vAbrev   := False;
         UpLoCase := ecUpperCase;
       end;
    32:begin                // Aparelhos - OS Especiais
         vAbrev   := False;
         UpLoCase := ecUpperCase;
       end;
    33:begin                // Técnicos - OS Especiais
         LabAbrev.Caption := '% Serviço';
       end;
    64:begin               // Tamanhos (PP, P, M....)
        dbFixa.Caption := 'Extra $$';
        vExtra         := True;
        Grid.Columns[3].Title.Caption := 'Vlr extra';
      end;

  end;
  Grid.Columns[2].Visible := vAbrev;
  Grid.Columns[2].Title.Caption := LabAbrev.Caption;
  EdDenom.CharCase := UpLoCase;
  LabAbrev.Visible := vAbrev;
  EdAbrev.Visible  := vAbrev;
  Grid.Columns[3].Visible := vExtra;
  DbFixa.Visible   := vExtra;

  N2.Visible := vExtra;
  RetirarIndicador1.Visible := VExtra;

  TabWrk.Active := True;
  RgOrdemClick(nil);
  TabWrk.First;
  TabWrk.Refresh;
  FTabGener.FormResize(nil);
  edLocaliz.SetFocus;

end;

procedure TFTabGener.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TabWrk.Active := False;
  CadEstoq.Active := False;
  Form_Salva(FTabGener);

end;


procedure TFTabGener.BtOkClick(Sender: TObject);
var xMsg: String;
    wPerc: Real;
begin
  Memo1.Visible := False;
  Memo1.Lines.Clear;
  Memo1.Lines.Add('Erros detectados');
  Memo1.Lines.Add('');

  if ((wNrTab >= 44) and (wNrTab <= 49))         // Produto,Papel, Gram.papel, Adesivos e Gram.adesivos
     or (wNrTab = 51)
  then if Length(Trim(TabWrkAbrev.AsString)) = 0
          then TabWrkAbrev.AsString := UpperCase(TabWrkDenom.AsString);
  if (wNrTab <> 13)        // Marcas
     and (wNrTab <> 14)    // Modelos
     and (wNrTab <> 30)    // Orçamentos - OS Especiais
     and (wNrTab <> 31)    // Marcas - OS Especiais
     and (wNrTab <> 32)    // Aparelhos - OS Especiais
  then begin
    xMsg := '- ' + LabAbrev.Caption + ' não informado';
    if (Length(Trim(TabWrkAbrev.AsString)) = 0)  and
       (wNrTab <> 24) then Memo1.Lines.Add(xMsg);
    if (wNrTab = 24) and
       (Length(Trim(TabWrkAbrev.AsString)) > 0)
    then begin
      if not CadEstoq.FindKey([TabWrkAbrev.Text])
            then Memo1.Lines.Add('Código informado não existe nos estoques');
    end;
  end;
  if (wNrTab = 33) and           // Tecnicos - OS Especiais
     (Length(Trim(TabWrkAbrev.AsString)) > 0)
  then begin
    wPerc := StrToFloatDef(TabWrkAbrev.AsString,0);
    TabWrkAbrev.AsString := FloatToStrF(wperc,ffNumber,5,2);
  end;

  if Length(Trim(TabWrkDenom.AsString)) = 0
     then Memo1.Lines.Add('- Denominação não informada');

  if Memo1.Lines.Count < 3
  then Try
         TabWrk.Post;
       Except
         Memo1.Lines.Add('- Código informado já existe na tabela');
       End;

  if Memo1.Lines.Count > 2
  then begin
    Memo1.Visible := True;
    if EdCod.Enabled then EdCod.SetFocus
                     else EdDenom.SetFocus;
    Exit;
  end;
  TabWrk.Refresh;
  if WAcao = 1 then Incluir1Click(nil)
               else Controle(3,False);

end;

procedure TFTabGener.BtCancClick(Sender: TObject);
begin
  Memo1.Visible := False;
  TabWrk.Cancel;
  TabWrk.Refresh;
  Controle(3,False);

end;

procedure TFTabGener.FormCreate(Sender: TObject);
begin
  fTime := True;
  HintsDBNavigator(Nav);

end;

procedure TFTabGener.TabWrkAfterRefresh(DataSet: TDataSet);
begin
  LabNRegs.Caption := IntToStr(TabWrk.RecordCount) + ' registros';

end;

procedure TFTabGener.RgOrdemClick(Sender: TObject);
begin
  if not TabWrk.Active then Exit;
  if RgOrdem.ItemIndex = 0
  then begin
    TabWrk.IndexName := '';
    edLocaliz.Width := 53;
    edLocaliz.MaxLength := 5;
  end
  else begin
     TabWrk.IndexName := 'Alfabetica';
     edLocaliz.Width := 160;
     edLocaliz.MaxLength := 30;
  end;
  TabWrk.Refresh;
  edLocaliz.Text := '';
  TabWrk.First;

end;

procedure TFTabGener.Incluir1Click(Sender: TObject);
begin
  Controle(1,True);

end;

procedure TFTabGener.Alterar1Click(Sender: TObject);
begin
  if TabWrk.RecordCount = 0 then Exit;
  if not GenRecordLock(TabWrk,True) then Exit;
  Controle(2,True);

end;

procedure TFTabGener.Excluir1Click(Sender: TObject);
begin
  if TabWrk.RecordCount = 0 then Exit;
  if not GenRecordLock(TabWrk,True) then Exit;
  if msgSistema(3,'Excluir ' + AnsiLowerCase(Caption) + ' ?',
                  'Código: ' + TabWrkCod.AsString + #13 +
                  'Abrev.: ' + TabWrkAbrev.AsString + #13 +
                  'Descr.: ' + TabWrkDenom.AsString,3,2) = 1
  then begin
    TabWrk.Cancel;
    TabWrk.Delete;
  end
  else TabWrk.Cancel;
  TabWrk.Refresh;

end;

procedure TFTabGener.TabWrkCalcFields(DataSet: TDataSet);
begin
  TabWrkZC_Fixa.AsString := '';
  case wNrTab of
    1:if TabWrkFixa.AsBoolean then TabWrkZC_Fixa.AsString := 'NÃO';      // Grupos Estoque
    6,7:begin     // Receitas ou Despesas
          if TabWrkFixa.AsBoolean then TabWrkZC_Fixa.AsString := 'Fixa';
          if TabWrkPessoal.AsBoolean
          then begin
            if Length(Trim(TabWrkZC_Fixa.AsString)) > 0
               then TabWrkZC_Fixa.AsString := TabWrkZC_Fixa.AsString + ' / ';
            TabWrkZC_Fixa.AsString := TabWrkZC_Fixa.AsString + 'Pessoal';
          end;
        end;
    64:begin
         if TabWrkFixa.AsBoolean then TabWrkZC_Fixa.AsString := 'Extra $$';
       end;

  end;

end;

procedure TFTabGener.Imprimir1Click(Sender: TObject);
begin
//  FCtleImpress := TFCtleImpress.Create(nil);
//  FCtleImpress.wEMail := '';
//  FCtleImpress.wAssunto := 'Tabela: ' + xTabela;
  FFortesReportCtle.RLPDFFilter1.FileName := FuIniGeral.wInicial.PathRelatorios + xTabela + '.PDF';
  FTabGenerLst := TFTabGenerLst.Create(nil);
  with FTabGenerLst
  do begin
    RLTabelaId.Caption := xTabela;
    RLCab2.Visible     := vAbrev;
    RLTx2.Visible      := vAbrev;
    RLCab3.Visible     := vExtra;
    RLTx3.Visible      := vExtra;
    RLReportTabGener.Preview();
  end;
  FTabGenerLst.Free;
  FFortesReportCtle.RLPDFFilter1.FileName := '';
//  FCtleImpress.Free;

end;

procedure TFTabGener.EdAbrevDblClick(Sender: TObject);
begin                         
  if wNrTab <> 24 then Exit;
  if not uPesquisaEstoques(True, wCodEst, wRefEst, False)
  then begin
    EdAbrev.Text := '';
    Exit;
  end
  else EdAbrev.Text := wCodEst;
  BtOk.SetFocus;

end;

procedure TFTabGener.EdAbrevKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 113 then FTabGener.EdAbrevDblClick(nil);

end;

procedure TFTabGener.FormResize(Sender: TObject);
begin
  if FTabGener.Width < 481
     then FTabGener.Width := 481;
  if FTabGener.Height < 431
     then FTabGener.Height := 431;
  Grid := DefineGrid(Grid, [0.08,0.33,0.22,0.20], 1, 1);

end;

procedure TFTabGener.RetirarIndicador1Click(Sender: TObject);
begin
  if msgSistema(3,'Indicadores'
                 ,'Retirar indicador da tabela ?'
                 ,3,2) = 1
  then begin
    TabWrk.First;
    while not TabWrk.Eof
    do begin
      TabWrk.Edit;
      TabWrkFixa.AsBoolean := False;
      TabWrk.Post;
      TabWrk.Next;
    end;
    TabWrk.First;
  end;
  
end;

procedure TFTabGener.edLocalizChange(Sender: TObject);
begin
  if Rgordem.ItemIndex = 0
    then TabWrk.FindNearest([StrToIntDef(edLocaliz.Text,0)])
    else TabWrk.FindNearest([Trim(edLocaliz.Text)]);

end;

procedure TFTabGener.cbDestaqClick(Sender: TObject);
begin
  FTabGener.FormResize(nil);
  if TabWrk.Active
     then TabWrk.Refresh;

end;

procedure TFTabGener.GridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if cbDestaq.Checked
  then DestacaLinhaGrid(Grid, FuIniGeral.wInicial.CorLinDestaq,
                        Rect, DataCol, Column, State);

end;

procedure TFTabGener.btTamOrigClick(Sender: TObject);
begin
  Form_Centraliza(FTabGener, 580, 556);

end;

end.
