unit TesteCriadorDePasta;

interface

uses
  DUnitX.TestFramework, MegaConexao.Utils.CriadorDePasta,
  System.StrUtils, Vcl.Forms, MegaConexao.Utils.CriadorDeCaminho;

type

  [TestFixture]
  TesteMegaConexao = class(TObject) 
  public
  [Test]
  procedure TesteNomePasta;

  [Test]
  procedure TesteCriarPasta;

  end;

implementation

uses
  System.SysUtils;


{ TesteMegaConexao }

procedure TesteMegaConexao.TesteCriarPasta;
var
 lCriaPasta :TCriadorDePasta;
 lPasta,lPastaTeste :string;
 lCriaCaminhoPasta : TCriadorDeCaminho;
begin
  lCriaCaminhoPasta := TCriadorDeCaminho.Create;
  lCriaPasta        := TCriadorDePasta.Create;

  if DirectoryExists(lCriaCaminhoPasta.GeraCaminhoPasta) then
    RemoveDir(lCriaCaminhoPasta.GeraCaminhoPasta);

  lPasta := lCriaPasta.CriarPasta;

 Assert.IsTrue(DirectoryExists(lPasta));
end;

procedure TesteMegaConexao.TesteNomePasta;
var
  lCriaCaminhoPasta : TCriadorDeCaminho;
  lCriaPasta        : TCriadorDePasta;
  lNomePasta        : String;
begin
  lCriaCaminhoPasta := TCriadorDeCaminho.Create;
  lCriaPasta        := TCriadorDePasta.Create;
  lNomePasta        := lCriaPasta.CriarPasta;

  Assert.AreEqual(lNomePasta,lCriaCaminhoPasta.GeraCaminhoPasta);
end;

initialization
  TDUnitX.RegisterTestFixture(TesteMegaConexao);

end.
