unit MegaConexao.Utils.FerramentasApiWindows;

interface

uses Winapi.Windows, System.SysUtils;


 function GetNomePC: string;

implementation




function GetNomePC: string;
var
 V_Nome : PChar;
 V_Tamanho : DWord;
const Buff_Size = MAX_COMPUTERNAME_LENGTH + 1;
begin
  V_Tamanho := Buff_Size;
  V_Nome := StrAlloc(Buff_Size);
  GetComputerName(V_Nome,V_Tamanho);
  Result := String(V_Nome);
  StrDispose(V_Nome);
end;


end.
