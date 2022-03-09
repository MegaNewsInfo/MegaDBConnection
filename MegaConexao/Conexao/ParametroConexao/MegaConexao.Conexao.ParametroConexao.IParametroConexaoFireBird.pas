unit MegaConexao.Conexao.ParametroConexao.IParametroConexaoFireBird;

interface

uses FireDAC.Phys;

 type TParametrosConexaoFireBird = record
    DATA_BASE: string;
    USER_NAME: string;
    PORT: Integer;
    PASSWORD: string;
 end;

type ILeitorParametroConexaoFireBird = interface
 ['{08EBE91E-E2AB-4D7D-A7D8-B912065A9D7A}']

 function LerParametros:TParametrosConexaoFireBird;
end;

implementation

end.
