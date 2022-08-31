unit MegaConexao.Factories.FactoryQuery;

interface

uses
  MegaConexao.Query.iQuery, MegaConexao.Query.MegaQuery, MegaConexao.Conexao.ConexaoFireBird,
  MegaConexao.Logger.Logger;

type

  TTipoConexao = (tcFirebird,tcSqlite);

  TFactoryQuery = class

     public
       class function Criar(pTipoConexao: TTipoConexao) : IQuery;
 end;

implementation

{ TFactoryQuery }

class function TFactoryQuery.Criar(pTipoConexao: TTipoConexao): IQuery;
begin
  case pTipoConexao of
    tcFirebird: Result := TMegaQuery.Create(TConexaoFireBird.GetInstance, TLogger.Create);
    //tcSqlite: Result := TMegaQuery.Create( .Create, TLogger.Create);
  end;
end;

end.
