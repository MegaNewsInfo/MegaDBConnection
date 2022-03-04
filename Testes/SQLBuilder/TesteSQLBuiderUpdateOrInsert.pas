unit TesteSQLBuiderUpdateOrInsert;

interface
uses
  DUnitX.TestFramework,MegaConexao.SqlBuilder.iSqlBuilder;

type

  [TestFixture]
  TTesteSQLBuilderUpdateOrInsert = class(TObject)
  public

  [Test]
  procedure TesteCriterio;
  [Test]
  procedure TesteTabela;

  end;

implementation

uses
  MegaConexao.SqlBuilder.SqlBuilderUpdateOrInsert, System.SysUtils;


{ TTesteSQLBuilderUpdateOrInsert }

procedure TTesteSQLBuilderUpdateOrInsert.TesteCriterio;
var
 lSqlBuilder : iSqlBuilder;
 lsql,lsql2 : string;
begin
  lsql := 'update or insert into  (teste) values (1)';
  lSqlBuilder := TSqlBuilderUpdateOrInsert.Create;
  lsql2 := StringReplace(lSqlBuilder.Add('teste',1).Criterio('where').ToString.Trim,sLineBreak,'',[rfReplaceAll,rfIgnoreCase]);
  Assert.AreEqual(lsql.Trim,Trim(lsql2));
end;

procedure TTesteSQLBuilderUpdateOrInsert.TesteTabela;
var
 lSqlBuilder : iSqlBuilder;
 lsql,lsql2 : string;
begin
  lsql := 'update or insert into FERA (teste) values (1)';
  lSqlBuilder := TSqlBuilderUpdateOrInsert.Create;
  lsql2 := StringReplace(lSqlBuilder.Add('teste',1).Tabela('FERA').ToString.Trim,sLineBreak,'',[rfReplaceAll,rfIgnoreCase]);
  Assert.AreEqual(lsql.Trim,Trim(lsql2));

end;

initialization
  TDUnitX.RegisterTestFixture(TTesteSQLBuilderUpdateOrInsert);
end.
