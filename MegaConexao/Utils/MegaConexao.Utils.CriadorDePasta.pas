unit MegaConexao.Utils.CriadorDePasta;

interface

uses System.SysUtils, System.StrUtils, MegaConexao.Utils.CriadorDeCaminho;

type
 TCriadorDePasta = class
   private
    FCriadorCaminho : TCriadorDeCaminho;
   public
     function CriarPasta:string;
     constructor Create;
     destructor Destroy; override;

 end;

implementation

uses
   Vcl.Forms;

{ TCriadorDePasta }

constructor TCriadorDePasta.Create;
begin
  FCriadorCaminho := TCriadorDeCaminho.Create;
end;

function TCriadorDePasta.CriarPasta: string;
var
  PastaArmazenamento : string;
begin
    PastaArmazenamento := FCriadorCaminho.GeraCaminhoPasta;
    Result := PastaArmazenamento;
    ForceDirectories(PastaArmazenamento);
end;


destructor TCriadorDePasta.Destroy;
begin
  if Assigned(FCriadorCaminho) then
    FreeAndNil(FCriadorCaminho);

  inherited;
end;

end.
