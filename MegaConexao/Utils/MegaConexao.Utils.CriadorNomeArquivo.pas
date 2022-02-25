unit MegaConexao.Utils.CriadorNomeArquivo;

interface

uses
  System.SysUtils;

type
  TCriadorNomeArquivo = class
    private
      const NomeLog : string = 'LogConexao';
    public
      function Criar() : string;
  end;

implementation

{ TCriaNomeArquivo }

function TCriadorNomeArquivo.Criar: string;
begin
  result := NomeLog+'_'+FormatDateTime('dd_mm_yyyy',now)+'.txt';
end;

end.
