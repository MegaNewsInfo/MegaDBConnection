unit MegaConexao.Testes.Conexao.ConexaoSQLite;

interface

uses
  MegaConexao.Conexao.iMegaConexao, Data.DB,FireDAC.Comp.Client, FireDAC.Stan.Consts,
  FireDAC.Phys.SQLite ,FireDAC.Phys.SQLiteDef,FireDAC.Stan.ExprFuncs;

type TConexaoSqlite = class(TInterfacedObject, IMegaConexao)
private
    FConexao : TFDConnection;

public
    constructor Create;
    function Connection :TCustomConnection;
    procedure IniciaTransacao();
    procedure CommitaTransacao();
    procedure RollBackTransacao();
end;

implementation

{ TConexaoSqlite }

procedure TConexaoSqlite.CommitaTransacao;
begin
  FConexao.Commit;
end;

function TConexaoSqlite.Connection: TCustomConnection;
begin
  Result := FConexao;
end;

constructor TConexaoSqlite.Create;
begin
  if not Assigned(FConexao) then begin
    FConexao := TFDConnection.Create(nil);
    FConexao.DriverName:= 'SQLite';
    FConexao.Connected := True;
  end;
end;

procedure TConexaoSqlite.IniciaTransacao;
begin
 FConexao.StartTransaction;
end;

procedure TConexaoSqlite.RollBackTransacao;
begin
  FConexao.Rollback;
end;

end.
