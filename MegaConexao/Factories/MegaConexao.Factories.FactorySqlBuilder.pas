unit MegaConexao.Factories.FactorySqlBuilder;

interface

uses
  MegaConexao.SqlBuilder.iSqlBuilder;

type
  TTipoComando = (tComInsert, tComDelete, tComUpdate, tComUpdateOrInsert);

  type
   TFactorySqlBuilder = class
    private

    public
      class function Criar(pTipoComando: TTipoComando) : ISqlBuilder;
   end;


implementation

uses
  MegaConexao.SqlBuilder.SqlBuilderInsert,
  MegaConexao.SqlBuilder.SqlBuilderDelete,
  MegaConexao.SqlBuilder.SqlBuilderUpdate,
  MegaConexao.SqlBuilder.SqlBuilderUpdateOrInsert;

{ TFactorySqlBuilder }

class function TFactorySqlBuilder.Criar(pTipoComando: TTipoComando): ISqlBuilder;
begin
  case pTipoComando of
    tComInsert : Result := TSqlBuilderInsert.Create;
    tComDelete : Result := TSqlBuilderDelete.Create;
    tComUpdate : Result := TSqlBuilderUpdate.Create;
    tComUpdateOrInsert : Result := TSqlBuilderUpdateOrInsert.Create;
  end;
end;

end.
