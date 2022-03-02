unit MegaConexao.Testes.Conexao.LeitorParametrosSQLite;

interface

uses
  MegaConexao.Conexao.ParametroConexao.IParametroConexao;

type
  TLeitorParametrosSQLite = class(TInterfacedObject, IParametroConexao)


  public
    function LerParametros: TParametrosConexaoFireDac;
  end;

implementation

{ TLeitorParametrosSQLite }

function TLeitorParametrosSQLite.LerParametros: TParametrosConexaoFireDac;
var
  lParametrosConexaoFireDac : TParametrosConexaoFireDac;
begin
  lParametrosConexaoFireDac.DATA_BASE := '';
  lParametrosConexaoFireDac.USER_NAME := '';
  lParametrosConexaoFireDac.PORT := 0;
  lParametrosConexaoFireDac.PASSWORD := '';

  Result := lParametrosConexaoFireDac
end;

end.
