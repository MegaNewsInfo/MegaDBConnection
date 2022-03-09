unit MegaConexao.Testes.Conexao.LeitorParametrosSQLite;

interface

uses
  MegaConexao.Conexao.ParametroConexao.IParametroConexaoSQLite;


type
  TLeitorParametrosSQLite = class(TInterfacedObject, ILeitorParametroConexaoSQLite)


  public
    function LerParametros: TParametrosConexaoSQlite;
  end;

implementation

{ TLeitorParametrosSQLite }

function TLeitorParametrosSQLite.LerParametros: TParametrosConexaoSQlite;
var
  lParametrosConexaoFireDac : TParametrosConexaoSQlite;
begin
  lParametrosConexaoFireDac.DATA_BASE := '';

  Result := lParametrosConexaoFireDac
end;

end.
