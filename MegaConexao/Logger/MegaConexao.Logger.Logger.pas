unit MegaConexao.Logger.Logger;

interface

uses
  MegaConexao.Logger.iLogger, MegaConexao.Utils.CriadorDePasta,
  MegaConexao.Utils.CriadorNomeArquivo;

type
 Tlogger = class(TInterfacedObject, iLogger)
  private
    FCridadorDePasta : TCriadorDePasta;
    FCriadorNomeArquivo : TCriadorNomeArquivo;
  public
    constructor create;
    destructor destroy;override;
    procedure Gravar(pTexto: string);
 end;

implementation


uses
  System.SysUtils, System.Classes;

{ Tlogger }

constructor Tlogger.create;
begin
 FCridadorDePasta := TCriadorDePasta.create;
 FCriadorNomeArquivo := TCriadorNomeArquivo.Create;
end;

destructor Tlogger.destroy;
begin
  if Assigned(FCridadorDePasta) then
  begin
    FreeAndNil(FCridadorDePasta);
  end;

  if Assigned(FCriadorNomeArquivo) then
  begin
    FreeAndNil(FCriadorNomeArquivo);
  end;

  inherited;
end;

procedure Tlogger.Gravar(pTexto: string);
var
 lTexto :TStringList;
 lArquivo : string;
begin
 try
   try
     lArquivo := FCridadorDePasta.CriarPasta+'\'+FCriadorNomeArquivo.Criar;
     lTexto := TStringList.Create;
     if (FileExists(lArquivo)) then
          lTexto.LoadFromFile(lArquivo);

     lTexto.Add(FormatDateTime('dd/mm/yyyy hh:mm:ss',now) + ' : ' + pTexto);
     lTexto.SaveToFile(lArquivo);
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
