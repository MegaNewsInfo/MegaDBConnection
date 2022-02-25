unit MegaConexao.Conexao.ConexaoFireBird;

interface

uses
 FireDAC.Comp.Client,   MegaConexao.Conexao.ParametroConexao.LeitorParametrosFireBird,
 Data.DB, MegaConexao.Conexao.iMegaConexao;


type
  TConexaoFireBird = class(TInterfacedObject,iMegaConexao)
    private
      FConexao : TFDConnection;
      FParametrosConexaoFiredac: TLeitorParametrosFireBird;


    public
      function Connection :TCustomConnection;
      procedure IniciaTransacao();
      procedure CommitaTransacao();
      procedure RollBackTransacao();
      constructor Create;


  end;


implementation

{ TConexaoFireBird }

procedure TConexaoFireBird.CommitaTransacao;
begin
   FConexao.Commit;
end;

function TConexaoFireBird.Connection: TCustomConnection;
begin
 Result := FConexao;
end;


constructor TConexaoFireBird.Create;
begin

  if not Assigned(FConexao) then begin
    FConexao := TFDConnection.Create(nil);

    FParametrosConexaoFiredac := TLeitorParametrosFireBird.Create;

    FParametrosConexaoFiredac.LerParametros();

    FConexao.Params.Database:= FParametrosConexaoFiredac.Parametros.DATA_BASE;
    FConexao.Params.UserName:= FParametrosConexaoFiredac.Parametros.USER_NAME;
    FConexao.Params.Password:= FParametrosConexaoFiredac.Parametros.PASSWORD;
    FConexao.Params.Values['Port'] := FParametrosConexaoFiredac.Parametros.PORT.ToString;
    FConexao.DriverName:= 'FB';
    FConexao.Connected := True;

  end;

end;

procedure TConexaoFireBird.IniciaTransacao;
begin
   FConexao.StartTransaction;
end;

procedure TConexaoFireBird.RollBackTransacao;
begin
    FConexao.Rollback;
end;

end.
