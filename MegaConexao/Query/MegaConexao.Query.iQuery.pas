unit MegaConexao.Query.iQuery;

interface

uses Data.DB, MegaConexao.Conexao.iMegaConexao,
  MegaConexao.SqlBuilder.iSqlBuilder, MegaConexao.Logger.iLogger;

type
  iQuery = interface
    ['{AEAFA930-1C1F-4FAC-A6D6-BC64B71C6103}']
    function SQL(value: string): iQuery;
    procedure ExecuteSql(value: string); overload;
    procedure ExecuteSql(pSql:iSqlBuilder); overload;
    function DataSet: TDataSet;
    procedure StartTransaction;
    procedure CommitTransaction;
    procedure RollbackTransaction;


  end;

implementation

end.
