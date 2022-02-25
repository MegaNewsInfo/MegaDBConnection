unit MegaConexao.Logger.Logger;

interface

uses
  MegaConexao.Logger.iLogger, MegaConexao.Utils.CriadorDePasta;

  const NomeLog : string = 'LogConexao';

type
 Tlogger = class(TInterfacedObject, iLogger)
  private
    FCridadorDePasta : TCriadorDePasta;

  public
    constructor create;
    procedure Gravar(pTexto: string);


 end;

implementation


uses
  System.SysUtils, System.Classes, Vcl.Forms;

{ Tlogger }

constructor Tlogger.create;
begin
 FCridadorDePasta := TCriadorDePasta.create;
end;

procedure Tlogger.Gravar(pTexto: string);
var
 lTexto :TStringList;
 lArquivo : string;
begin

 try

   try
     lArquivo := FCridadorDePasta.CriarPasta+'\'+NomeLog+'_'+FormatDateTime('dd_mm_yyyy',now)+'.txt';
     lTexto := TStringList.Create;
     if (FileExists(lArquivo)) then
          lTexto.LoadFromFile(lArquivo);

     lTexto.Add(pTexto);
     lTexto.SaveToFile( lArquivo);

   finally
     if Assigned(lTexto) then
       FreeAndNil(lTexto);
   end;

 except on e:Exception
   do begin

     if Assigned(lTexto) then
       FreeAndNil(lTexto);

     raise Exception.Create('Erro ao gerar Logger'+sLineBreak+e.Message);

   end;

 end;

end;




end.
