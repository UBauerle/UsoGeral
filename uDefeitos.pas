unit uDefeitos;

interface

uses Db, DBTables, Mask, StdCtrls, DBCtrls, Controls, Grids, DBGrids, Buttons,
     Classes, ExtCtrls, Forms, SysUtils, Dialogs, Menus;
     Procedure TabelaDefeitos(pmtDBName:String; pmtTipo:Integer=0);

type
  TFuDefeitos = class(TForm)
    PanCtl: TPanel;
    BtSair: TBitBtn;
    PanManut: TPanel;
    LabAcao: TLabel;
    Label1: TLabel;
    edCod: TDBEdit;
    TabWrk: TTable;
    STabWrk: TDataSource;
    Label2: TLabel;
    edDescr: TDBEdit;
    TabWrkTipo: TSmallintField;
    TabWrkCodigo: TSmallintField;
    TabWrkDescr: TStringField;
    TabWrkZC_Tipo: TStringField;
    DbRgTipo: TDBRadioGroup;
    BtOk: TBitBtn;
    BtCanc: TBitBtn;
    Grid: TDBGrid;
    Menu: TMainMenu;
    Defeitos1: TMenuItem;
    Incluir1: TMenuItem;
    Alterar1: TMenuItem;
    Excluir1: TMenuItem;
    Sair1: TMenuItem;
    RgSelec: TRadioGroup;
    RgOrdem: TRadioGroup;
    Memo1: TMemo;
    N1: TMenuItem;
    Imprimir1: TMenuItem;
    Panel1: TPanel;
    Nav: TDBNavigator;
    LabNRegs: TLabel;
    procedure BtSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtOkClick(Sender: TObject);
    procedure BtCancClick(Sender: TObject);
    procedure TabWrkAfterRefresh(DataSet: TDataSet);
    procedure TabWrkFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure TabWrkCalcFields(DataSet: TDataSet);
    procedure Incluir1Click(Sender: TObject);
    procedure Alterar1Click(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure RgSelecClick(Sender: TObject);
    procedure RgOrdemClick(Sender: TObject);
    procedure DbRgTipoEnter(Sender: TObject);
    procedure DbRgTipoExit(Sender: TObject);
    procedure Imprimir1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FuDefeitos: TFuDefeitos;

  WAcao: Integer;

implementation

//uses uGenericas, uMensagem, DefeitosLst;


uses uGenericas;
{$R *.DFM}

Procedure TabelaDefeitos(pmtDBName:String; pmtTipo:Integer=0);
begin
  FuDefeitos  := TFuDefeitos.Create(nil);
  with FuDefeitos
  do begin
    TabWrk.DatabaseName := pmtDBName;
    TabWrk.Active := True;
    RgSelec.ItemIndex := pmtTipo;
    RgSelecClick(nil);
    RgOrdem.ItemIndex := 0;
    RgOrdemClick(nil);
    ShowModal;
    TabWrk.Active := False;
  end;
  FuDefeitos.Free;

end;


procedure Controle(Act:Integer;Md:Boolean);
var i: Integer;
const Txt: array[1..3] of string = ('Inclusão','Alteração','Consulta');
      Btn: array[1..3] of string = ('&Cancelar/Finalizar','&Cancelar','');
begin
 WAcao := Act;
  with FuDefeitos
  do begin
    LabAcao.Caption  := Txt[Act];
    BtCanc.Caption   := Btn[Act];
    PanManut.Enabled := Md;
    BtOk.Visible     := Md;
    BtCanc.Visible   := Md;
    if Md then Md := False
          else Md := True;
    for i := 0 to Menu.Items.Count-1 do Menu.Items[i].Enabled := Md;
    Grid.Enabled     := Md;
    Nav.Enabled      := Md;
    RgOrdem.Enabled  := Md;
    RgSelec.Enabled  := Md;
    DbRgTipo.Enabled := False;
    EdCod.Enabled    := True;
    case Act of
      1:begin                // Inclusão
          TabWrk.Append;
          if RgSelec.ItemIndex = 0
          then begin
            TabWrkTipo.AsInteger := 0;
            DbRgTipo.Enabled := True;
            DbRgTipo.SetFocus;
          end
          else begin
            TabWrkTipo.AsInteger := RgSelec.ItemIndex;
            EdCod.SetFocus;
          end;
        end;
      2:begin                  // Alteração
          if RgSelec.ItemIndex = 0
          then begin
            DbRgTipo.Enabled := True;
            DbRgTipo.SetFocus;
          end
          else edDescr.SetFocus;
        end;
      3:begin
          DbRgTipo.Enabled := True;
          EdCod.Enabled := True;
        end;
    end;
  end;

end;


procedure TFuDefeitos.BtSairClick(Sender: TObject);
begin
  FuDefeitos.Close;

end;

procedure TFuDefeitos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TabWrk.Active := False;
  Form_Salva(FuDefeitos);

end;


procedure TFuDefeitos.BtOkClick(Sender: TObject);
begin
  Memo1.Visible := False;
  Memo1.Lines.Clear;
  Memo1.Lines.Add('Erros detectados');
  Memo1.Lines.Add('');
  if Length(Trim(TabWrkDescr.AsString)) = 0 then Memo1.Lines.Add('- Descrição inválida');

  if Memo1.Lines.Count < 3
  then Try
         TabWrk.Post;
       Except
         Memo1.Lines.Add('- Código informado já existe na tabela');
       End;

  if Memo1.Lines.Count > 2
  then begin
    Memo1.Visible := True;
    if DbRgTipo.Enabled
    then DbRgTipo.SetFocus
    else if EdCod.Enabled
         then EdCod.SetFocus
         else EdDescr.SetFocus;
    Exit;
  end;
  TabWrk.Refresh;
  if WAcao = 1 then Incluir1Click(nil)
               else Controle(3,False);

end;

procedure TFuDefeitos.BtCancClick(Sender: TObject);
begin
  Memo1.Visible := False;
  TabWrk.Cancel;
  TabWrk.Refresh;
  Controle(3,False);

end;

procedure TFuDefeitos.TabWrkAfterRefresh(DataSet: TDataSet);
begin
  LabNRegs.Caption := IntToStr(TabWrk.RecordCount) + ' registros';

end;

procedure TFuDefeitos.TabWrkFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := True;
  if TabWrkTipo.AsInteger <> RgSelec.ItemIndex then Accept := False;

end;

procedure TFuDefeitos.TabWrkCalcFields(DataSet: TDataSet);
begin
  case TabWrkTipo.AsInteger of
    1:TabWrkZC_Tipo.AsString    := 'Relatado';
    2:TabWrkZC_Tipo.AsString    := 'Constatado';
    else TabWrkZC_Tipo.AsString := '';
  end;

end;

procedure TFuDefeitos.Incluir1Click(Sender: TObject);
begin
  Controle(1,True);

end;

procedure TFuDefeitos.Alterar1Click(Sender: TObject);
begin
  if TabWrk.RecordCount = 0 then Exit;
  Try
    TabWrk.Edit;
  Except
    MessageDlg('Registro em uso por outro usuário, tente mais tarde',mtWarning,[mbOk],0);
    Exit;
  End;
  Controle(2,True);

end;

procedure TFuDefeitos.Excluir1Click(Sender: TObject);
begin
  if TabWrk.RecordCount = 0 then Exit;
  Try
    TabWrk.Edit;
  Except
    MessageDlg('Registro em uso por outro usuário, tente mais tarde',mtWarning,[mbOk],0);
    Exit;
  End;
  if MessageDlg('Excluir registro' + #13 +
                'Tipo: ' + TabWrkZC_Tipo.AsString + '  Código: ' + TabWrkCodigo.AsString + #13 +
                'Descrição: ' + TabWrkDescr.AsString,
                mtConfirmation,[mbYes,mbNo],0,mbNo) <> mrYes
  then begin
    TabWrk.Cancel;
    Exit;
  end;
  TabWrk.Cancel;
  TabWrk.Delete;
  TabWrk.Refresh;

end;

procedure TFuDefeitos.RgSelecClick(Sender: TObject);
begin
  if not TabWrk.Active then Exit;
  if RgSelec.ItemIndex = 0 then TabWrk.Filtered := False
                           else TabWrk.Filtered := True;
  TabWrk.Refresh;

end;

procedure TFuDefeitos.RgOrdemClick(Sender: TObject);
begin
  if not TabWrk.Active then Exit;
  if RgOrdem.ItemIndex = 0 then TabWrk.IndexName := ''
                           else TabWrk.IndexName := 'Alfabetica';
                           
end;

procedure TFuDefeitos.DbRgTipoEnter(Sender: TObject);
begin
  DbRgTipo.Color := $008FFCF9;
  
end;

procedure TFuDefeitos.DbRgTipoExit(Sender: TObject);
begin
  DbRgTipo.Color := PanMAnut.Color;

end;

procedure TFuDefeitos.Imprimir1Click(Sender: TObject);
begin
{
  FCtleImpress := TFCtleImpress.Create(nil);
  FCtleImpress.wAssunto := 'Tabela: Defeitos';
  FCtleImpress.wEMail := '';

  FDefeitosLst := TFDefeitosLst.Create(nil);
  FDefeitosLst.RLReport1.Preview();
  FDefeitosLst.Free;

  FCtleImpress.Release;
}
end;

procedure TFuDefeitos.FormResize(Sender: TObject);
begin
  if FuDefeitos.Width < 640 then FuDefeitos.Width := 640;
  if FuDefeitos.Height < 580 then FuDefeitos.Height := 580;
  Grid := DefineGrid(Grid,[0.15, 0.08, 0.33],2,0);

end;

procedure TFuDefeitos.FormShow(Sender: TObject);
begin
  Form_Define(FuDefeitos);
  TabWrk.First;

end;

end.
