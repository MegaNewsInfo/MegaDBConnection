unit MegaConexao.Factories.FactoryQuery;

interface

uses
  MegaConexao.Query.iQuery;



 type

  TTipoConexao = (tcFirebird,tcSqlite);

 TFactoryQuery = class

     public

     function Criar(pTipoConexao: TTipoConexao) : IQuery;


 end;

implementation

uses
  MegaConexao.Query.MegaQuery, MegaConexao.Conexao.iMegaConexao,
  MegaConexao.Logger.iLogger, MegaConexao.Conexao.ConexaoFireBird,
  MegaConexao.Logger.Logger;

{ TFactoryQuery }

function TFactoryQuery.Criar(pTipoConexao: TTipoConexao): IQuery;
VAR
 lQuery : iQuery;
 lConexao : iMegaConexao;
 Llogger : Ilogger;
begin
   case pTipoConexao of
     tcFirebird: Result := TMegaQuery.Create( TConexaoFireBird.GetInstance, TLogger.Create);
     //tcSqlite: Result := TMegaQuery.Create( .Create, TLogger.Create);
   end;
end;

end.
