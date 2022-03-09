unit MegaConexao.Conexao.ParametroConexao.IParametroConexaoSQLite;

interface

uses FireDAC.Phys;

 type TParametrosConexaoSQlite = record
    DATA_BASE: string;

 end;

type ILeitorParametroConexaoSQLite = interface
 ['{08EBE91E-E2AB-4D7D-A7D8-B912065A9D7A}']

 function LerParametros:TParametrosConexaoSQlite;
end;

implementation

end.
