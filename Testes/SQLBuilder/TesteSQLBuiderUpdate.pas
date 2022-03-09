unit TesteSQLBuiderUpdate;

interface

uses
  DUnitX.TestFramework, System.SysUtils,
  MegaConexao.SqlBuilder.iSqlBuilder, MegaConexao.SqlBuilder.SqlBuilderUpdate;

type

  [TestFixture]
  TesteSQLBuilderUpdate = class(TObject) 
  public

  [Test]
  procedure TesteCriterio;
  [Test]
  procedure TesteTabela;

  end;

implementation


{ TesteSQLBuilderUpdate }

procedure TesteSQLBuilderUpdate.TesteCriterio;
var
 lSqlBuilder : iSqlBuilder;
 lsql,lsql2 : string;
begin

  lsql := 'update FERA set  CAMPO = ''NORMAL'' WHERE  1=1 ';
  lSqlBuilder := TSqlBuilderUpdate.Create;
  lsql2 := StringReplace(lSqlBuilder.Add('CAMPO','NORMAL').
           Tabela('FERA').Criterio('where 1=1').ToString.Trim,
           sLineBreak,'',[rfReplaceAll,rfIgnoreCase]);
  Assert.AreEqual(lsql.Trim,Trim(lsql2));

end;

procedure TesteSQLBuilderUpdate.TesteTabela;
var
 lSqlBuilder : iSqlBuilder;
 lsql,lsql2 : string;
begin

  lsql := 'update FERA set  CAMPO = ''NORMAL'' ';
  lSqlBuilder := TSqlBuilderUpdate.Create;
  lsql2 := StringReplace(lSqlBuilder.Add('CAMPO','NORMAL').
           Tabela('FERA').ToString.Trim,
           sLineBreak,'',[rfReplaceAll,rfIgnoreCase]);
  Assert.AreEqual(lsql.Trim,Trim(lsql2));

end;

initialization
  TDUnitX.RegisterTestFixture(TesteSQLBuilderUpdate);
end.
