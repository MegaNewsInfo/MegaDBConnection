program TesteMegaConexao;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}{$STRONGLINKTYPES ON}
uses
  SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  TesteCriadorDePasta in 'Utils\TesteCriadorDePasta.pas',
  TesteLogger in 'Logger\TesteLogger.pas',
  MegaConexao.Logger.Logger in '..\MegaConexao\Logger\MegaConexao.Logger.Logger.pas',
  MegaConexao.Logger.iLogger in '..\MegaConexao\Logger\MegaConexao.Logger.iLogger.pas',
  MegaConexao.Testes.Conexao.LeitorParametrosSQLite in 'Conexao\MegaConexao.Testes.Conexao.LeitorParametrosSQLite.pas',
  MegaConexao.Conexao.ParametroConexao.IParametroConexao in '..\MegaConexao\Conexao\ParametroConexao\MegaConexao.Conexao.ParametroConexao.IParametroConexao.pas',
  MegaConexao.Testes.Conexao.ConexaoSQLite in 'Conexao\MegaConexao.Testes.Conexao.ConexaoSQLite.pas',
  MegaConexao.Conexao.iMegaConexao in '..\MegaConexao\Conexao\MegaConexao.Conexao.iMegaConexao.pas',
  TesteQuery in 'Query\TesteQuery.pas',
  MegaConexao.Conexao.ConexaoFireBird in '..\MegaConexao\Conexao\MegaConexao.Conexao.ConexaoFireBird.pas',
  MegaConexao.Query.iQuery in '..\MegaConexao\Query\MegaConexao.Query.iQuery.pas',
  MegaConexao.Query.MegaQuery in '..\MegaConexao\Query\MegaConexao.Query.MegaQuery.pas',
  MegaConexao.Conexao.ParametroConexao.LeitorParametrosFireBird in '..\MegaConexao\Conexao\ParametroConexao\MegaConexao.Conexao.ParametroConexao.LeitorParametrosFireBird.pas',
  MegaConexao.Utils.CriadorDeCaminho in '..\MegaConexao\Utils\MegaConexao.Utils.CriadorDeCaminho.pas',
  MegaConexao.Utils.CriadorDePasta in '..\MegaConexao\Utils\MegaConexao.Utils.CriadorDePasta.pas',
  MegaConexao.Utils.CriadorNomeArquivo in '..\MegaConexao\Utils\MegaConexao.Utils.CriadorNomeArquivo.pas',
  MegaConexao.Utils.FerramentasApiWindows in '..\MegaConexao\Utils\MegaConexao.Utils.FerramentasApiWindows.pas',
  MegaConexao.SqlBuilder.iSqlBuilder in '..\MegaConexao\SqlBuilder\MegaConexao.SqlBuilder.iSqlBuilder.pas';

var
  runner : ITestRunner;
  results : IRunResults;
  logger : ITestLogger;
  nunitLogger : ITestLogger;
begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
  exit;
{$ENDIF}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //tell the runner how we will log things
    //Log to the console window
    logger := TDUnitXConsoleLogger.Create(true);
    runner.AddLogger(logger);
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);
    runner.FailsOnNoAsserts := False; //When true, Assertions must be made during tests;

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
end.
