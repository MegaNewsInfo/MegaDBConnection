unit MegaConexao.Conexao.ParametroConexao.LeitorParametrosFireBird;

interface

uses
  System.SysUtils, System.IniFiles, MegaConexao.Utils.FerramentasApiWindows;

type
 TParametrosConexaoFireDac = record
    DATA_BASE: string;
    USER_NAME: string;
    PORT: Integer;
    PASSWORD: string;
 end;

 TLeitorParametrosFireBird = class
   private
     fParametros : TParametrosConexaoFireDac;
     function LerArquivoINI:Boolean;

   public
     constructor Create;
     destructor Destroy; override;
     property Parametros : TParametrosConexaoFireDac read fParametros;

     function LerParametros:TParametrosConexaoFireDac;


 end;


implementation


{ TLeitorParametrosConexaoFiredac }

constructor TLeitorParametrosFireBird.Create;
begin




end;

destructor TLeitorParametrosFireBird.Destroy;
begin
  inherited;
end;

function TLeitorParametrosFireBird.LerArquivoINI: Boolean;
var
 lArqIni : TIniFile;
 lCaminhoBanco,lIP : string;
begin

 try

   try

     lArqIni := TIniFile.Create('.\dbxconnections.ini');
     lIP := TRIM((lArqIni.ReadString('IP_Server','IP','')));

      if (Trim(lIP)='127.0.0.1') or ( Trim(lIP)='') or (Trim(UpperCase(lIP))=Trim(GetNomePC)) then
          lIP := 'localhost';

     lCaminhoBanco := lIP+':C:\MFX\Dados\MFX.fdb';


     fParametros.DATA_BASE := lCaminhoBanco;
     fParametros.USER_NAME:= 'SYSDBA';
     fParametros.PASSWORD:='masterkey';
     fParametros.PORT:= 3050;


   finally
     FreeAndNil(lArqIni);
   end;

 except on e:Exception
   do begin
     Result := False;
     raise Exception.Create('Erro ao ler arquivo INI '+sLineBreak+e.Message);
   end;
 end;


end;

function TLeitorParametrosFireBird.LerParametros: TParametrosConexaoFireDac;
begin
 LerArquivoINI;
 Result := fParametros;

end;

end.
