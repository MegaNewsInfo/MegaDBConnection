unit MegaConexao.SqlBuilder.SqlBuilderInsert;

interface

uses
    MegaConexao.SqlBuilder.iSqlBuilder, System.Classes, System.SysUtils,
  System.StrUtils, System.Generics.Collections, System.Variants, MegaConexao.SqlBuilder.SqlBuilderBase;

    type
      TSqlBuilderInsert = class(TBaseSqlBuilder, ISqlBuilder)
        public
          function Add(Campo: string; Valor: Variant; TamanhoCampo: Integer = 0;
                       AdicionarParametro: Boolean = True): iSqlBuilder;overload;
          function Criterio(pCriterio: string): iSqlBuilder;
          function Tabela(pTabela: string): iSqlBuilder;
          function ToString: string;override;
          constructor Create();
          destructor Destroy;override;
      end;


implementation

{ TSqlBuilderInsert }

function TSqlBuilderInsert.Add(Campo: string; Valor: Variant;
  TamanhoCampo: Integer; AdicionarParametro: Boolean): iSqlBuilder;
var
  basicType: integer;
begin
  Result := self;
  basicType := VarType(valor) and VarTypeMask;

  case basicType of

    varEmpty:
      AddNull(campo);
    varNull:
      AddNull(campo);
    varSmallint:
      Add(campo, integer(valor), AdicionarParametro);
    varInteger:
      Add(campo, integer(valor), AdicionarParametro);
    varSingle:
      Add(campo, Double(valor), AdicionarParametro);
    varDouble:
      Add(campo, Double(valor), AdicionarParametro);
    varCurrency:
      Add(campo, Double(valor), AdicionarParametro);
    varDate:
      Add(campo, VarToDateTime(valor), SomenteData, AdicionarParametro);
    varBoolean:
      Add(campo, Boolean(valor), AdicionarParametro);
    varVariant:
      Add(campo, string(valor), TamanhoCampo, AdicionarParametro);
    varUnknown:
      Add(campo, string(valor), TamanhoCampo, AdicionarParametro);
    varShortInt:
      Add(campo, integer(valor), AdicionarParametro);
    varByte:
      Add(campo, integer(valor), AdicionarParametro);
    varWord:
      Add(campo, string(valor), TamanhoCampo, AdicionarParametro);
    varLongWord:
      Add(campo, string(valor), TamanhoCampo, AdicionarParametro);
    varInt64:
      Add(campo, integer(valor), AdicionarParametro);
    varStrArg:
      Add(campo, string(valor), TamanhoCampo, AdicionarParametro);
    varString:
      Add(campo, string(valor), TamanhoCampo, AdicionarParametro);
    varUString:
      Add(campo, string(valor), TamanhoCampo, AdicionarParametro);
    varAny:
      Add(campo, string(valor), TamanhoCampo, AdicionarParametro);
  end;
end;

constructor TSqlBuilderInsert.Create();
begin
  inherited Create();
end;

function TSqlBuilderInsert.Criterio(pCriterio: string): iSqlBuilder;
begin
  result := Self;
end;

destructor TSqlBuilderInsert.Destroy;
begin
  inherited;
end;

function TSqlBuilderInsert.Tabela(pTabela: string): iSqlBuilder;
begin
  try
    inherited Tabela(pTabela);
    Result := Self;
  except on E : Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TSqlBuilderInsert.ToString: string;
begin
  try
    Result := '';
    if (self.Count > 0) then
    begin
      Result := 'INSERT INTO ' + NomeTabela + ' (' + MontaCampos +
        ') VALUES (' + sLineBreak + MontaValores + ') ;';
    end
  except on E : Exception do
    begin
      raise Exception.Create('Erro ao transformar para SQL. ' + #13#10 + E.Message);
    end;
  end;
end;

end.
