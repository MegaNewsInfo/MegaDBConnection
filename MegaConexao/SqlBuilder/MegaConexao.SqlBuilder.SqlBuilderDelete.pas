unit MegaConexao.SqlBuilder.SqlBuilderDelete;

interface

uses
  MegaConexao.SqlBuilder.SqlBuilderBase, MegaConexao.SqlBuilder.iSqlBuilder,
  System.SysUtils;

type
  TSqlBuilderDelete = class(TBaseSqlBuilder,iSqlBuilder)
  private
    FCriterio : string;
  public
    function Add(Campo: string; Valor: Variant; TamanhoCampo: Integer = 0;
      AdicionarParametro: Boolean = True): iSqlBuilder;
    function Criterio(pCriterio: string): iSqlBuilder;
    function Tabela(pTabela: string): iSqlBuilder;
    function ToString: string;
  end;

implementation

{ TSqlBuilderDelete }

function TSqlBuilderDelete.Add(Campo: string; Valor: Variant;
  TamanhoCampo: Integer; AdicionarParametro: Boolean): iSqlBuilder;
begin
  result := Self;
end;

function TSqlBuilderDelete.Criterio(pCriterio: string): iSqlBuilder;
begin
  FCriterio := pCriterio;
  result := Self;
end;

function TSqlBuilderDelete.Tabela(pTabela: string): iSqlBuilder;
begin
  inherited Tabela(pTabela);
  result := Self;
end;

function TSqlBuilderDelete.ToString: string;
var
  lCriterio : string;
begin
  try
    lCriterio := '';
    if not FCriterio.Trim.IsEmpty then
    begin
      lCriterio := ' where ' + StringReplace(FCriterio,'where',' ',[rfReplaceAll,rfIgnoreCase]);
    end;
    result := 'delete from ' + NomeTabela + lCriterio;
  except on E : Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
