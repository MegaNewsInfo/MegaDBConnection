unit MegaConexao.SqlBuilder.iSqlBuilder;

interface

type
  iSqlBuilder = interface
    ['{8288C0B3-B84C-4484-9B4E-8EAA7EAA851E}']
    function Add(pCampo:string; pValor:Variant) :iSqlBuilder;
    function ToString:string;
  end;

implementation

end.
