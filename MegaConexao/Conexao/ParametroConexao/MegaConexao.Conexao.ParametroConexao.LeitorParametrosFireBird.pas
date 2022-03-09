unit MegaConexao.Conexao.ParametroConexao.LeitorParametrosFireBird;

interface

uses
  System.SysUtils, System.IniFiles, MegaConexao.Utils.FerramentasApiWindows,MegaConexao.Conexao.ParametroConexao.IParametroConexaoFireBird;

type


 TLeitorParametrosFireBird = class(TInterfacedObject, ILeitorParametroConexaoFireBird)
   private
     fParametros : TParametrosConexaoFireBird;
     procedure LerArquivoINI;

   public

     function LerParametros:TParametrosConexaoFireBird;

 end;


implementation


{ TLeitorParametrosConexaoFiredac }


procedure TLeitorParametrosFireBird.LerArquivoINI;
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
     raise Exception.Create('Erro ao ler arquivo INI '+sLineBreak+e.Message);
   end;
 end;


end;

function TLeitorParametrosFireBird.LerParametros: TParametrosConexaoFireBird;
begin
 LerArquivoINI;
 Result := fParametros;

end;

end.
