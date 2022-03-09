unit TesteSQLBuiderDelete;

interface

uses
  DUnitX.TestFramework, System.SysUtils,
  MegaConexao.SqlBuilder.iSqlBuilder, MegaConexao.SqlBuilder.SqlBuilderUpdate;


type

  [TestFixture]
  TesteSQLBuilderDelete = class(TObject) 
  public

  [Test]
  procedure TesteCriterio;
  [Test]
  procedure TesteTabela;

  end;

implementation

uses
  MegaConexao.SqlBuilder.SqlBuilderDelete;


{ TesteSQLBuilderDelete }

procedure TesteSQLBuilderDelete.TesteCriterio;
var
 lSqlBuilder : iSqlBuilder;
 lsql,lsql2 : string;
begin

  lsql := 'delete from FERA WHERE   1=1 ';
  lSqlBuilder := TSqlBuilderDelete.Create;
  lsql2 := StringReplace(lSqlBuilder.
           Tabela('FERA').Criterio('where 1=1').ToString.Trim,
           sLineBreak,'',[rfReplaceAll,rfIgnoreCase]);
  Assert.AreEqual(lsql.Trim,Trim(lsql2));

end;

procedure TesteSQLBuilderDelete.TesteTabela;
var
 lSqlBuilder : iSqlBuilder;
 lsql,lsql2 : string;
begin

  lsql := 'delete from FERA ';
  lSqlBuilder := TSqlBuilderDelete.Create;
  lsql2 := StringReplace(lSqlBuilder.
           Tabela('FERA').ToString.Trim,
           sLineBreak,'',[rfReplaceAll,rfIgnoreCase]);
  Assert.AreEqual(lsql.Trim,Trim(lsql2));


end;

initialization
  TDUnitX.RegisterTestFixture(TesteSQLBuilderDelete);
end.
