unit MegaConexao.Conexao.ConexaoFireBird;

interface

uses
 FireDAC.Comp.Client, FireDAC.Phys.FB,FireDAC.Phys.IB,FireDAC.Phys.Intf,FireDAC.Phys,FireDAC.Phys.FBDef,
 FireDAC.Stan.Def, FireDAC.DApt,FireDac.Stan.Async,FireDAC.VCLUI.Wait,
 Data.DB, MegaConexao.Conexao.iMegaConexao, MegaConexao.Conexao.ParametroConexao.IParametroConexaoFireBird;


type
  TConexaoFireBird = class(TInterfacedObject,iMegaConexao)
    private
      FConexao : TFDConnection;
      class var FConexaoFirebird : TConexaoFireBird;
    public
      class function GetInstance(pLeitorParametros : ILeitorParametroConexaoFireBird = nil): TConexaoFireBird; static;
      class function NewInstance : TObject; override;
      function Connection :TFDCustomConnection;
      procedure IniciaTransacao();
      procedure CommitaTransacao();
      procedure RollBackTransacao();
      constructor Create(pLeitorParametros : ILeitorParametroConexaoFireBird = nil);
      destructor Destroy; override;


  end;


implementation

uses
  System.SysUtils;

{ TConexaoFireBird }

procedure TConexaoFireBird.CommitaTransacao;
begin
   FConexao.Commit;
end;

function TConexaoFireBird.Connection: TFDCustomConnection;
begin
  Result := FConexao;
end;


constructor TConexaoFireBird.Create(pLeitorParametros : ILeitorParametroConexaoFireBird = nil);
var
  lParametros : TParametrosConexaoFireBird;
begin
  try
    inherited Create();
    if not Assigned(FConexao) then begin
      FConexao := TFDConnection.Create(nil);

      lParametros := pLeitorParametros.LerParametros();

      FConexao.Params.Database:= lParametros.DATA_BASE;
      FConexao.Params.UserName:= lParametros.USER_NAME;
      FConexao.Params.Password:= lParametros.PASSWORD;
      FConexao.Params.Values['Port'] := inttostr(lParametros.PORT);
      FConexao.DriverName:= 'FB';

      FConexao.Connected := True;
    end;
  except on E : Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

destructor TConexaoFireBird.Destroy;
begin
  inherited;
end;

class function TConexaoFireBird.GetInstance(pLeitorParametros : ILeitorParametroConexaoFireBird = nil): TConexaoFireBird;
begin
  try
    Result :=   TConexaoFireBird.Create(pLeitorParametros);
  except on E : Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TConexaoFireBird.IniciaTransacao;
begin
   FConexao.StartTransaction;
end;

class function TConexaoFireBird.NewInstance: TObject;
begin
  if not Assigned(FConexaoFirebird) then
  begin
    FConexaoFirebird := TConexaoFireBird(inherited NewInstance);
  end;

  result := FConexaoFirebird;
end;

procedure TConexaoFireBird.RollBackTransacao;
begin
    FConexao.Rollback;
end;

end.
