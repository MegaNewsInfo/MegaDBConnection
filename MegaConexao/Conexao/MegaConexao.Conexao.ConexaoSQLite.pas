unit MegaConexao.Conexao.ConexaoSQLite;

interface

uses
  MegaConexao.Conexao.iMegaConexao, Data.DB,FireDAC.Comp.Client, FireDAC.Stan.Consts,
  FireDAC.Phys.SQLite, FireDAC.Stan.Def, FireDAC.DApt ,FireDAC.Phys.SQLiteDef,FireDAC.Stan.ExprFuncs,FireDAC.Phys.SQLiteVDataSet,
  System.Classes, System.Generics.Collections,FireDac.Stan.Async,
  MegaConexao.Conexao.ParametroConexao.IParametroConexaoSQLite;

type

TConexaoSqliteMemory = class(TInterfacedObject, IMegaConexao)
private
    FConexao : TFDConnection;

public
    constructor Create(pLeitorParametros : ILeitorParametroConexaoSQLite);
    function Connection :TFDCustomConnection;
    procedure IniciaTransacao();
    procedure CommitaTransacao();
    procedure RollBackTransacao();
end;

implementation

{ TConexaoSqlite }

procedure TConexaoSqliteMemory.CommitaTransacao;
begin
  FConexao.Commit;
end;

function TConexaoSqliteMemory.Connection: TFDCustomConnection;
begin
  Result := FConexao;
end;

constructor TConexaoSqliteMemory.Create(pLeitorParametros : ILeitorParametroConexaoSQLite);
begin
  if not Assigned(FConexao) then begin
    FConexao := TFDConnection.Create(nil);
    FConexao.DriverName:= 'SQLite';
    FConexao.Connected := True;
    FConexao.Params.Database := pLeitorParametros.LerParametros.DATA_BASE;
  end;
end;

procedure TConexaoSqliteMemory.IniciaTransacao;
begin
 FConexao.StartTransaction;
end;

procedure TConexaoSqliteMemory.RollBackTransacao;
begin
  FConexao.Rollback;
end;

end.
