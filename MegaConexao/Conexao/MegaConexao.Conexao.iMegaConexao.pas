unit MegaConexao.Conexao.iMegaConexao;

interface

uses Data.DB;

type
  iMegaConexao = interface
  ['{56361056-87B5-476D-B3AA-BA8710136E5B}']
    function Connection :TCustomConnection;
    procedure IniciaTransacao();
    procedure CommitaTransacao();
    procedure RollBackTransacao();

  end;

implementation

end.
