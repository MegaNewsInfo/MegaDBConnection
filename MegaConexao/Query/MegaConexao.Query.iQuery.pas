unit MegaConexao.Query.iQuery;

interface

uses Data.DB, MegaConexao.Conexao.iMegaConexao,
  MegaConexao.SqlBuilder.iSqlBuilder, MegaConexao.Logger.iLogger;

type
  iQuery = interface
    ['{AEAFA930-1C1F-4FAC-A6D6-BC64B71C6103}']
    function SQL(value: string): iQuery; overload;
    function SQL(pSql:iSqlBuilder): iQuery; overload;
    function ExecuteSql(value: string) : iQuery;
    function DataSet: TDataSet;

  end;

implementation

end.
