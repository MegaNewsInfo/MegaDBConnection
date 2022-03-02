unit MegaConexao.Query.MegaQuery;

interface

uses
  MegaConexao.Query.iQuery, MegaConexao.Conexao.iMegaConexao,
  MegaConexao.Logger.iLogger, Data.DB, MegaConexao.SqlBuilder.iSqlBuilder,
  FireDAC.Comp.Client;


 type TMegaQuery = class(TInterfacedObject, IQuery)
   private
     FMegaConexao : iMegaConexao;
     FLogger : Ilogger;
     FQuery : TFDQuery;

  public


    function SQL(value: string): iQuery; overload;
    function SQL(pSql:iSqlBuilder): iQuery; overload;
    function ExecuteSql(value: string) : iQuery;
    function DataSet: TDataSet;

    constructor Create(pMegaConexao : iMegaConexao; pLogger : Ilogger);

 end;


implementation

uses
  System.SysUtils;

{ TMegaQuery }

constructor TMegaQuery.Create(pMegaConexao: iMegaConexao; pLogger: Ilogger);
begin
  FMegaConexao := pMegaConexao;
  FLogger := pLogger;

  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FmegaCOnexao.Connection;
end;

function TMegaQuery.DataSet: TDataSet;
begin
  Result := FQuery;
end;

function TMegaQuery.ExecuteSql(value: string): iQuery;
var
  logText : string;
begin
  Result := Self;

  FQuery.SQL.Clear;
  FQuery.SQL.Add(value);

 try
    FQuery.ExecSQL;
 except on e: exception do
 begin
    logText := 'Erro ao executar comando Sql em TMegaQuery.ExecuteSql: '+ sLineBreak+
    value+sLineBreak+
    e.Message;
    FLogger.Gravar(logText);
    raise  e;
 end;
 end;



end;

function TMegaQuery.SQL(value: string): iQuery;
var logText : string;
begin
  Result := Self;

  FQuery.SQL.Clear;
  FQuery.SQL.Add(value);

  try
    FQuery.Active := True;
 except on e: exception do
 begin
    logText := 'Erro ao executar comando Sql em TMegaQuery.SQL: '+ sLineBreak+
    value+sLineBreak+
    e.Message;
    FLogger.Gravar(logText);
    raise e;
 end;
 end;
end;

function TMegaQuery.SQL(pSql: iSqlBuilder): iQuery;
begin
  ExecuteSql(pSql.ToString());
end;

end.
