unit MegaConexao.Conexao.iMegaConexao;

interface

uses Data.DB, FireDAC.Comp.Client;

type
  iMegaConexao = interface
  ['{56361056-87B5-476D-B3AA-BA8710136E5B}']
    function Connection :TFDCustomConnection;
    procedure IniciaTransacao();
    procedure CommitaTransacao();
    procedure RollBackTransacao();

  end;

implementation

end.
