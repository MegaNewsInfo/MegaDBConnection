unit MegaConexao.Conexao.ParametroConexao.IParametroConexao;

interface

 type TParametrosConexaoFireDac = record
    DATA_BASE: string;
    USER_NAME: string;
    PORT: Integer;
    PASSWORD: string;
 end;

type IParametroConexao = interface
 ['{08EBE91E-E2AB-4D7D-A7D8-B912065A9D7A}']

 function LerParametros:TParametrosConexaoFireDac;
end;

implementation

end.
