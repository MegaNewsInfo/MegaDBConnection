program MegaConexao;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {formPrincipal},
  MegaConexao.Conexao.iMegaConexao in 'MegaConexao\Conexao\MegaConexao.Conexao.iMegaConexao.pas',
  MegaConexao.Logger.iLogger in 'MegaConexao\Logger\MegaConexao.Logger.iLogger.pas',
  MegaConexao.Query.iQuery in 'MegaConexao\Query\MegaConexao.Query.iQuery.pas',
  MegaConexao.SqlBuilder.iSqlBuilder in 'MegaConexao\SqlBuilder\MegaConexao.SqlBuilder.iSqlBuilder.pas',
  MegaConexao.Conexao.ConexaoFireBird in 'MegaConexao\Conexao\MegaConexao.Conexao.ConexaoFireBird.pas',
  MegaConexao.Conexao.ParametroConexao.LeitorParametrosFireBird in 'MegaConexao\Conexao\ParametroConexao\MegaConexao.Conexao.ParametroConexao.LeitorParametrosFireBird.pas',
  MegaConexao.Utils.FerramentasApiWindows in 'MegaConexao\Utils\MegaConexao.Utils.FerramentasApiWindows.pas',
  MegaConexao.Logger.Logger in 'MegaConexao\Logger\MegaConexao.Logger.Logger.pas',
  MegaConexao.Utils.CriadorDePasta in 'MegaConexao\Utils\MegaConexao.Utils.CriadorDePasta.pas',
  MegaConexao.Utils.CriadorDeCaminho in 'MegaConexao\Utils\MegaConexao.Utils.CriadorDeCaminho.pas',
  MegaConexao.Utils.CriadorNomeArquivo in 'MegaConexao\Utils\MegaConexao.Utils.CriadorNomeArquivo.pas',
  MegaConexao.Conexao.ParametroConexao in 'MegaConexao.Conexao.ParametroConexao.pas',
  MegaConexao.Conexao.ParametroConexao.IParametroConexao in 'MegaConexao\Conexao\ParametroConexao\MegaConexao.Conexao.ParametroConexao.IParametroConexao.pas',
  MegaConexao.Query.MegaQuery in 'MegaConexao\Query\MegaConexao.Query.MegaQuery.pas',
  MegaConexao.SqlBuilder.SqlBuilderInsert in 'MegaConexao\SqlBuilder\MegaConexao.SqlBuilder.SqlBuilderInsert.pas',
  MegaConexao.SqlBuilder.SqlBuilderBase in 'MegaConexao\SqlBuilder\MegaConexao.SqlBuilder.SqlBuilderBase.pas',
  MegaConexao.SqlBuilder.SqlBuilderUpdate in 'MegaConexao\SqlBuilder\MegaConexao.SqlBuilder.SqlBuilderUpdate.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformPrincipal, formPrincipal);
  Application.Run;
end.
