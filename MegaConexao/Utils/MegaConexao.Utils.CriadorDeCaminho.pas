unit MegaConexao.Utils.CriadorDeCaminho;

interface

uses System.SysUtils, System.StrUtils, System.DateUtils;

type
  TCriadorDeCaminho = class
    private
      function GeraMes : String; overload;
      function GeraAno : String;
      function GeraDia : String;
      function GeraNomePastaRaiz : string;
      function GeraMesNumero : Integer; overload;
      const PastaDeLogs :string = 'LogMegaConexao';
    public
      function GeraCaminhoPasta : string;

 end;

implementation

uses
   Vcl.Forms;

{ TCriadorDePasta }

function TCriadorDeCaminho.GeraAno: String;
begin
  result :=  yearof(now).ToString();
end;

function TCriadorDeCaminho.GeraCaminhoPasta: string;
begin
  Result := GeraNomePastaRaiz+'\'+
            GeraAno+'\'+
            GeraMes+'\'+
            GeraDia+'_'+
            IntToStr(GeraMesNumero);
end;

function TCriadorDeCaminho.GeraDia: String;
begin
  result :=  dayof(now).ToString();
end;

function TCriadorDeCaminho.GeraMesNumero: Integer;
begin
  Result := monthof(now);
end;

function TCriadorDeCaminho.GeraMes: String;
var
  lMes : Integer;
begin
  lMes := monthof(now);
  Case lMes Of
     01 : Result:= 'Janeiro';
     02 : Result:= 'Fevereiro';
     03 : Result:= 'Março';
     04 : Result:= 'Abril';
     05 : Result:= 'Maio';
     06 : Result:= 'Junho';
     07 : Result:= 'Julho';
     08 : Result:= 'Agosto';
     09 : Result:= 'Setembro';
     10 : Result:= 'Outubro';
     11 : Result:= 'Novembro';
     12 : Result:= 'Dezembro';
   end;
end;

function TCriadorDeCaminho.GeraNomePastaRaiz: string;
begin
  Result := ExtractFilePath(Application.ExeName) +
            PastaDeLogs;
end;

end.
