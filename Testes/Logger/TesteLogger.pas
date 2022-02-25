unit TesteLogger;

interface
uses
  DUnitX.TestFramework, MegaConexao.Logger.Logger,
  MegaConexao.Utils.CriadorDeCaminho, MegaConexao.Utils.CriadorNomeArquivo,
  System.Classes, System.SysUtils;

type

  [TestFixture]
  TTesteLogger = class(TObject)
  public
  [Test]
  procedure TesteGravarTexto();
  end;

implementation


{ TesteLogger }

procedure TTesteLogger.TesteGravarTexto;
var
  llogger : Tlogger;
  lCriaCaminhoPasta : TCriadorDeCaminho;
  lCriadorNomeArquivo : TCriadorNomeArquivo;
  lTexto : TStringList;
  lCaminho : string;
begin
  llogger := Tlogger.Create;
  lCriaCaminhoPasta := TCriadorDeCaminho.Create;
  lCriadorNomeArquivo := TCriadorNomeArquivo.Create;

  lCaminho := lCriaCaminhoPasta.GeraCaminhoPasta + '\' + lCriadorNomeArquivo.Criar;
  if FileExists(lCaminho) then
  begin
    DeleteFile(lCaminho);
  end;

  llogger.Gravar('teste');
  lTexto := TStringList.Create;
  lTexto.LoadFromFile(lCaminho);
  Assert.IsTrue(Pos('teste',lTexto[lTexto.Count - 1]) > 0);
end;

initialization
  TDUnitX.RegisterTestFixture(TTesteLogger);
end.
