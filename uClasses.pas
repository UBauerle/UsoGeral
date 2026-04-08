unit uClasses;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TIdFornecedor = class
  private
    FPais: String;
    FIEST: String;
    FUF: String;
    FIM: String;
    FCNPJ_CPF: String;
    FFantasia: String;
    FBairro: String;
    FCidade: String;
    FTipo: String;
    FRazaoSocial: String;
    FPaisCod: String;
    FCidadeCod: String;
    FComplemento: String;
    FCEP: String;
    FIE: String;
    FNumero: String;
    FLogradouro: String;
    FCNAE: String;
    FFone: String;
    FCRT: String;
    FCodigo: Integer;
    FMarg1: Real;
    FMarg2: Real;
    FMarg3: Real;

  protected
  public
    property Tipo: String read FTipo write FTipo;
    property CNPJ_CPF: String read FCNPJ_CPF write FCNPJ_CPF;
    property RazaoSocial: String read FRazaoSocial write FRazaoSocial;
    property Fantasia: String read FFantasia write FFantasia;
    property IE: String read FIE write FIE;
    property IEST: String read FIEST write FIEST;
    property IM: String read FIM write FIM;
    property CNAE: String read FCNAE write FCNAE;
    property CRT: String read FCRT write FCRT;
    property Logradouro: String read FLogradouro write FLogradouro;
    property Numero: String read FNumero write FNumero;
    property Complemento: String read FComplemento write FComplemento;
    property Bairro: String read FBairro write FBairro;
    property CidadeCod: String read FCidadeCod write FCidadeCod;
    property Cidade: String read FCidade write FCidade;
    property UF: String read FUF write FUF;
    property CEP: String read FCEP write FCEP;
    property PaisCod: String read FPaisCod write FPaisCod;
    property Pais: String read FPais write FPais;
    property Fone: String read FFone write FFone;
    property Codigo: Integer read FCodigo write FCodigo;
    property Marg1: Real read FMarg1 write FMarg1;
    property Marg2: Real read FMarg2 write FMarg2;
    property Marg3: Real read FMarg3 write FMarg3;

  published

  end;


  TFuClasses = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Function CriaIdFornecedor(var pFornec: TIdFornecedor): Boolean;


var
  FuClasses: TFuClasses;

implementation

{$R *.dfm}

Function CriaIdFornecedor(var pFornec: TIdFornecedor): Boolean;
begin
  Try
    pFornec := TIdFornecedor.Create;
    Result  := True;
  Except
    Result  := False;
  End;

end;

end.
