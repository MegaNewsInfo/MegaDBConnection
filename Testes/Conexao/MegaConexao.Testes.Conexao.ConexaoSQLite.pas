unit MegaConexao.Testes.Conexao.ConexaoSQLite;

interface

uses
  MegaConexao.Conexao.iMegaConexao, Data.DB,FireDAC.Comp.Client, FireDAC.Stan.Consts,
  FireDAC.Phys.SQLite, FireDAC.Stan.Def, FireDAC.DApt ,FireDAC.Phys.SQLiteDef,FireDAC.Stan.ExprFuncs,FireDAC.Phys.SQLiteVDataSet, 
  System.Classes, System.Generics.Collections,FireDac.Stan.Async;

type
   TCampo = record
       nome : string;
       tipo : TFieldType;
       tamanho : integer
   end;

TConexaoSqlite = class(TInterfacedObject, IMegaConexao)
private
    FConexao : TFDConnection;
    FDLocalSQL : TFDLocalSQL;
    FDataset : TFDMemTable;

public
    constructor Create(pTableName : string; pFields : TList<TCampo>);
    function Connection :TFDCustomConnection;
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

function TConexaoSqlite.Connection: TFDCustomConnection;
begin
  Result := FConexao;
end;

constructor TConexaoSqlite.Create(pTableName : string; pFields : TList<TCampo>);
var
 lCampo : TCampo;
begin
  if not Assigned(FConexao) then begin
    FConexao := TFDConnection.Create(nil);
    FConexao.DriverName:= 'SQLite';
    FConexao.Connected := True;

    FDLocalSQL := TFDLocalSQL.Create(nil);
    FDLocalSQL.Connection := FConexao;
    FDLocalSQL.Active := True;

    FDataset:= TFDMemTable.Create(nil);
    FDataset.Name := pTableName;
    for lCampo in pFields do
    begin
       FDataset.FieldDefs.Add(lCampo.nome, lCampo.tipo, lCampo.tamanho);
    end;
    FDataset.LocalSQL := FDLocalSQL;
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
