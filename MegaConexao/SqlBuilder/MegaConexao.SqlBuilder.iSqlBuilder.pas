unit MegaConexao.SqlBuilder.iSqlBuilder;

interface

type
  iSqlBuilder = interface
    ['{8288C0B3-B84C-4484-9B4E-8EAA7EAA851E}']
    function Add(Campo : string; Valor : Variant; TamanhoCampo : integer = 0; AdicionarParametro : Boolean = true) : IsqlBuilder;
    function Tabela(pTabela: string) : IsqlBuilder;
    function Criterio(pCriterio: string) : ISqlBuilder;
    function ToString:string;
  end;

implementation

end.
