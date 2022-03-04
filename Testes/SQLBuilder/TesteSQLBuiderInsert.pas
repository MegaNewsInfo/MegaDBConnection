unit TesteSQLBuiderInsert;

interface
uses
  DUnitX.TestFramework, MegaConexao.SqlBuilder.iSqlBuilder,
  MegaConexao.SqlBuilder.SqlBuilderInsert, System.SysUtils;

type

  [TestFixture]
  TTesteSQLBuiderInsert = class(TObject)
  public
  [Test]
  procedure TesteAdicionaSemQuoted;
  [Test]
  procedure TesteAdicionaComQuoted;


  end;

implementation


{ TesteSQLBuiderInsert }

procedure TTesteSQLBuiderInsert.TesteAdicionaComQuoted;
var
 lSqlBuilder : iSqlBuilder;
 lsql,lsql2 : string;
begin

  lsql := 'insert into  (teste) values (''M'') ;';
  lSqlBuilder := TSqlBuilderInsert.Create;
  lsql2 := StringReplace(lSqlBuilder.Add('teste','M').ToString.Trim,sLineBreak,'',[rfReplaceAll,rfIgnoreCase]);
  Assert.AreEqual(lsql.Trim,Trim(lsql2));

end;

procedure TTesteSQLBuiderInsert.TesteAdicionaSemQuoted;
var
 lSqlBuilder : iSqlBuilder;
 lsql,lsql2 : string;
begin
  lsql := 'insert into  (teste) values (1) ;';
  lSqlBuilder := TSqlBuilderInsert.Create;
  lsql2 := StringReplace(lSqlBuilder.Add('teste',1).ToString.Trim,sLineBreak,'',[rfReplaceAll,rfIgnoreCase]);
  Assert.AreEqual(lsql.Trim,Trim(lsql2));
end;

initialization
  TDUnitX.RegisterTestFixture(TTesteSQLBuiderInsert);
end.
