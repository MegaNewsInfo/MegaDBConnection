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
  [Test]
  procedure TesteAddStringComTamanho;
  [Test]
  procedure TesteAddStringSemTamanho;
  [Test]
  procedure TesteAddComAdicionarParametro;
  [Test]
  procedure TesteAddSemAdicionarParametro;
  [Test]
  procedure TesteAddBooleanTrue;
  [Test]
  procedure TesteAddBooleanFalse;
  [Test]
  procedure TesteAddNull;

  [Test]
  procedure TesteCriterio;
  [Test]
  procedure TesteTabela;



  end;

implementation


{ TesteSQLBuiderInsert }

procedure TTesteSQLBuiderInsert.TesteAddBooleanFalse;
var
 lSqlBuilder : iSqlBuilder;
 lsql,lsql2 : string;
begin

  lsql := 'insert into  (teste) values (''N'')';
  lSqlBuilder := TSqlBuilderInsert.Create;
  lsql2 := StringReplace(lSqlBuilder.Add('teste',False).ToString.Trim,sLineBreak,'',[rfReplaceAll,rfIgnoreCase]);
  Assert.AreEqual(lsql.Trim,Trim(lsql2));


end;

procedure TTesteSQLBuiderInsert.TesteAddBooleanTrue;
var
 lSqlBuilder : iSqlBuilder;
 lsql,lsql2 : string;
begin

  lsql := 'insert into  (teste) values (''S'')';
  lSqlBuilder := TSqlBuilderInsert.Create;
  lsql2 := StringReplace(lSqlBuilder.Add('teste',True).ToString.Trim,sLineBreak,'',[rfReplaceAll,rfIgnoreCase]);
  Assert.AreEqual(lsql.Trim,Trim(lsql2));

end;

procedure TTesteSQLBuiderInsert.TesteAddComAdicionarParametro;
var
 lSqlBuilder : iSqlBuilder;
 lsql,lsql2 : string;
begin

  lsql := 'insert into  (teste) values (''MEGA'')';
  lSqlBuilder := TSqlBuilderInsert.Create;
  lsql2 := StringReplace(lSqlBuilder.Add('teste','MEGA',0,True).ToString.Trim,sLineBreak,'',[rfReplaceAll,rfIgnoreCase]);
  Assert.AreEqual(lsql.Trim,Trim(lsql2));

end;

procedure TTesteSQLBuiderInsert.TesteAddNull;
var
 lSqlBuilder : iSqlBuilder;
 lsql,lsql2 : string;
 lNul :Variant;
begin

  lsql := 'insert into  (teste) values (NULL)';
  lSqlBuilder := TSqlBuilderInsert.Create;
  lsql2 := StringReplace(lSqlBuilder.Add('teste',lNul).ToString.Trim,sLineBreak,'',[rfReplaceAll,rfIgnoreCase]);
  Assert.AreEqual(lsql.Trim,Trim(lsql2));

end;

procedure TTesteSQLBuiderInsert.TesteAddSemAdicionarParametro;
var
 lSqlBuilder : iSqlBuilder;
 lsql,lsql2 : string;
begin

  lsql := 'insert into  (teste) values (''MEGA'')';
  lSqlBuilder := TSqlBuilderInsert.Create;
  lsql2 := StringReplace(lSqlBuilder.Add('teste','MEGA',0,True).
           Add('teste2','COISA',0,False).ToString.Trim,sLineBreak,'',[rfReplaceAll,rfIgnoreCase]);
  Assert.AreEqual(lsql.Trim,Trim(lsql2));

end;

procedure TTesteSQLBuiderInsert.TesteAddStringComTamanho;
var
 lSqlBuilder : iSqlBuilder;
 lsql,lsql2 : string;
begin

  lsql := 'insert into  (teste) values (''MEG'')';
  lSqlBuilder := TSqlBuilderInsert.Create;
  lsql2 := StringReplace(lSqlBuilder.Add('teste','MEGA',3).ToString.Trim,sLineBreak,'',[rfReplaceAll,rfIgnoreCase]);
  Assert.AreEqual(lsql.Trim,Trim(lsql2));

end;

procedure TTesteSQLBuiderInsert.TesteAddStringSemTamanho;
var
 lSqlBuilder : iSqlBuilder;
 lsql,lsql2 : string;
begin

  lsql := 'insert into  (teste) values (''MEGA'')';
  lSqlBuilder := TSqlBuilderInsert.Create;
  lsql2 := StringReplace(lSqlBuilder.Add('teste','MEGA').ToString.Trim,sLineBreak,'',[rfReplaceAll,rfIgnoreCase]);
  Assert.AreEqual(lsql.Trim,Trim(lsql2));

end;

procedure TTesteSQLBuiderInsert.TesteAdicionaComQuoted;
var
 lSqlBuilder : iSqlBuilder;
 lsql,lsql2 : string;
begin

  lsql := 'insert into  (teste) values (''M'')';
  lSqlBuilder := TSqlBuilderInsert.Create;
  lsql2 := StringReplace(lSqlBuilder.Add('teste','M').ToString.Trim,sLineBreak,'',[rfReplaceAll,rfIgnoreCase]);
  Assert.AreEqual(lsql.Trim,Trim(lsql2));

end;

procedure TTesteSQLBuiderInsert.TesteAdicionaSemQuoted;
var
 lSqlBuilder : iSqlBuilder;
 lsql,lsql2 : string;
begin
  lsql := 'insert into  (teste) values (1)';
  lSqlBuilder := TSqlBuilderInsert.Create;
  lsql2 := StringReplace(lSqlBuilder.Add('teste',1).ToString.Trim,sLineBreak,'',[rfReplaceAll,rfIgnoreCase]);
  Assert.AreEqual(lsql.Trim,Trim(lsql2));
end;

procedure TTesteSQLBuiderInsert.TesteCriterio;
var
 lSqlBuilder : iSqlBuilder;
 lsql,lsql2 : string;
begin
  lsql := 'insert into  (teste) values (1)';
  lSqlBuilder := TSqlBuilderInsert.Create;
  lsql2 := StringReplace(lSqlBuilder.Add('teste',1).Criterio('where').ToString.Trim,sLineBreak,'',[rfReplaceAll,rfIgnoreCase]);
  Assert.AreEqual(lsql.Trim,Trim(lsql2));

end;

procedure TTesteSQLBuiderInsert.TesteTabela;
var
 lSqlBuilder : iSqlBuilder;
 lsql,lsql2 : string;
begin
  lsql := 'insert into FERA (teste) values (1)';
  lSqlBuilder := TSqlBuilderInsert.Create;
  lsql2 := StringReplace(lSqlBuilder.Add('teste',1).Tabela('FERA').ToString.Trim,sLineBreak,'',[rfReplaceAll,rfIgnoreCase]);
  Assert.AreEqual(lsql.Trim,Trim(lsql2));

end;

initialization
  TDUnitX.RegisterTestFixture(TTesteSQLBuiderInsert);
end.
