unit MegaConexao.SqlBuilder.SqlBuilderBase;

interface

uses
  System.Generics.Collections, System.SysUtils, System.StrUtils,
  System.Classes, System.Variants;

type
  TFormatoDataHora = (SomenteData, DataEHora, SomenteHora);

type
  TCampo = class
  private
    FValorCampo: string;
    FNomeCampo: string;
    FQuoted: Boolean;
  public
    property NomeCampo: string read FNomeCampo write FNomeCampo;
    property ValorCampo: string read FValorCampo write FValorCampo;
    property Quoted: Boolean read FQuoted write FQuoted;
    constructor Create(pNomeCampo : string; pValorCampo: string; pQuoted : Boolean); reintroduce;
  end;

type
  TBaseSqlBuilder = class(TInterfacedObject)
      private
        FTabela : string;
        FListaCampos: TList<TCampo>;
      protected
        procedure AdicionaSemQuoted(campo: string; valor: string;
                                    adiciona: Boolean);
        procedure AdicionaComQuoted(campo: string; valor: string;
                                    adiciona: Boolean);
        procedure AddDataHora(campo: string; valor: TDateTime;
                              AdicionarParametro: Boolean = true);
        procedure AddHora(campo: String; valor: TDateTime;
                          AdicionarParametro: Boolean = true);
        procedure AddDataHoje(campo: string; AdicionarParametro: Boolean = true);
        procedure AddFloat(campo: string; valor: Double;
                           AdicionarParametro: Boolean = true);
        procedure AddBoolean(campo: string; valor: Boolean;
                             AdicionarParametro: Boolean = true);
        procedure Add(campo: string; valor: String; TamanhoCampo: integer = 0;
                      AdicionarParametro: Boolean = true); overload;
        procedure Add(campo: string; valor: integer;
                      AdicionarParametro: Boolean = true); overload;
        procedure Add(campo: string; valor: Double;
                      AdicionarParametro: Boolean = true); overload;
        procedure Add(campo: string; valor: TDateTime; Formato: TFormatoDataHora;
                      AdicionarParametro: Boolean = true); overload;
        procedure Add(campo: string; valor: Boolean;
                      AdicionarParametro: Boolean = true); overload;
        procedure AddExpr(campo: string; valor: string;
                          AdicionarParametro: Boolean = true);
        procedure AddData(campo: string; valor: TDateTime;
                          AdicionarParametro: Boolean = true);
        procedure AddNull(campo: string);
        function GetCount : Integer;
        property Count: integer read GetCount;
        procedure Tabela(pTabela : string);
        function NomeTabela() : string;
        function RetornaListaCampo : TList<TCampo>;
        procedure Add(Campo: string; Valor: Variant; TamanhoCampo: Integer = 0;
                       AdicionarParametro: Boolean = True);overload;
      public
        constructor Create(); reintroduce;
        destructor Destroy;override;
    end;


implementation

{ TSqlBuilderInsert }
procedure TBaseSqlBuilder.Add(campo: string; valor: integer;
  AdicionarParametro: Boolean);
begin
  AdicionaSemQuoted(campo, intTostr(valor), AdicionarParametro);
end;

procedure TBaseSqlBuilder.Add(campo, valor: String; TamanhoCampo: integer;
  AdicionarParametro: Boolean);
begin
 if (TamanhoCampo > 0) then
    AdicionaComQuoted(campo, Copy(valor, 1, TamanhoCampo), AdicionarParametro)
  else
    AdicionaComQuoted(campo, valor, AdicionarParametro);
end;

procedure TBaseSqlBuilder.Add(campo: string; valor: Double;
  AdicionarParametro: Boolean);
var
  Valstr: string;
  bkp: Char;
begin
 bkp := {$IFNDEF VER150}FormatSettings.{$ENDIF}DecimalSeparator;
{$IFNDEF VER150}FormatSettings.{$ENDIF}DecimalSeparator := '.';
  Valstr := (FloatToStr(valor));
{$IFNDEF VER150}FormatSettings.{$ENDIF}DecimalSeparator := bkp;
  AdicionaSemQuoted(campo, Valstr, AdicionarParametro);
end;

procedure TBaseSqlBuilder.Add(campo: string; valor,
  AdicionarParametro: Boolean);
begin
  AdicionaComQuoted(campo, IfThen(valor, 'S', 'N'), AdicionarParametro);
end;

procedure TBaseSqlBuilder.Add(campo: string; valor: TDateTime;
  Formato: TFormatoDataHora; AdicionarParametro: Boolean);
var
  datanula: string;
begin

  datanula := FormatDateTime('DD.MM.YYYY', valor);

  if (datanula = '30.12.1899') or (datanula = '')  then
  begin

    AddNull(campo);
  end
  else
  begin

    case Formato of
      SomenteData:
        AdicionaComQuoted(campo, FormatDateTime('DD.MM.YYYY', valor),
          AdicionarParametro);
      DataEHora:
        AdicionaComQuoted(campo, FormatDateTime('DD.MM.YYYY HH:MM:SS', valor),
          AdicionarParametro);
      SomenteHora:
        AdicionaComQuoted(campo, FormatDateTime('HH:MM:SS', valor),
          AdicionarParametro);

    end;
  end;
end;

procedure TBaseSqlBuilder.AddBoolean(campo: string; valor,
  AdicionarParametro: Boolean);
begin
  AdicionaComQuoted(campo, IfThen(valor, 'S', 'N'), AdicionarParametro);
end;

procedure TBaseSqlBuilder.AddData(campo: string; valor: TDateTime;
          AdicionarParametro: Boolean = true);
begin
  Add(campo, valor, SomenteData, AdicionarParametro);
end;

procedure TBaseSqlBuilder.AddDataHoje(campo: string;
  AdicionarParametro: Boolean);
begin
  Add(campo, now, SomenteData, AdicionarParametro);
end;

procedure TBaseSqlBuilder.AddDataHora(campo: string; valor: TDateTime;
  AdicionarParametro: Boolean);
begin
  Add(campo, now, SomenteHora, AdicionarParametro);
end;

procedure TBaseSqlBuilder.AddExpr(campo, valor: string;
  AdicionarParametro: Boolean);
begin
  AdicionaSemQuoted(campo, valor, AdicionarParametro);
end;

procedure TBaseSqlBuilder.AddFloat(campo: string; valor: Double;
  AdicionarParametro: Boolean);
begin
  Add(campo, valor, AdicionarParametro);
end;

procedure TBaseSqlBuilder.AddHora(campo: String; valor: TDateTime;
  AdicionarParametro: Boolean);
begin
  Add(campo, valor, SomenteHora, AdicionarParametro);
end;

procedure TBaseSqlBuilder.AddNull(campo: string);
begin
  AddExpr(campo, 'NULL');
end;

procedure TBaseSqlBuilder.AdicionaComQuoted(campo, valor: string;
  adiciona: Boolean);
begin
  if (adiciona) then
  begin
    FListaCampos.Add(TCampo.Create(campo,valor,true));
  end;
end;

procedure TBaseSqlBuilder.AdicionaSemQuoted(campo, valor: string;
  adiciona: Boolean);
begin
  if (adiciona) then
  begin
    FListaCampos.Add(TCampo.Create(campo,valor,false));
  end;
end;

constructor TBaseSqlBuilder.Create();
begin
  FListaCampos  := TList<TCampo>.Create;
end;

destructor TBaseSqlBuilder.Destroy;
begin
  if Assigned(FListaCampos) then
  begin
    FreeAndNil(FListaCampos);
  end;

  inherited;
end;

function TBaseSqlBuilder.GetCount: Integer;
begin
  if not Assigned(FListaCampos) then
    Result := 0
  else
    Result := FListaCampos.Count;
end;


function TBaseSqlBuilder.NomeTabela: string;
begin
  result := FTabela;
end;

function TBaseSqlBuilder.RetornaListaCampo: TList<TCampo>;
begin
  Result := FListaCampos;
end;

procedure TBaseSqlBuilder.Tabela(pTabela: string);
begin
  FTabela := pTabela;
end;

{ TCampo }

constructor TCampo.Create(pNomeCampo, pValorCampo: string; pQuoted: Boolean);
begin
  FValorCampo := pValorCampo;
  FNomeCampo  := pNomeCampo;
  FQuoted     := pQuoted;
end;

procedure TBaseSqlBuilder.Add(Campo: string; Valor: Variant;
  TamanhoCampo: Integer; AdicionarParametro: Boolean);
var
  basicType: integer;
begin
  basicType := VarType(valor) and VarTypeMask;

  case basicType of

    varEmpty:
      AddNull(campo);
    varNull:
      AddNull(campo);
    varSmallint:
      Add(campo, integer(valor), AdicionarParametro);
    varInteger:
      Add(campo, integer(valor), AdicionarParametro);
    varSingle:
      Add(campo, Double(valor), AdicionarParametro);
    varDouble:
      Add(campo, Double(valor), AdicionarParametro);
    varCurrency:
      Add(campo, Double(valor), AdicionarParametro);
    varDate:
      Add(campo, VarToDateTime(valor), SomenteData, AdicionarParametro);
    varBoolean:
      Add(campo, Boolean(valor), AdicionarParametro);
    varVariant:
      Add(campo, string(valor), TamanhoCampo, AdicionarParametro);
    varUnknown:
      Add(campo, string(valor), TamanhoCampo, AdicionarParametro);
    varShortInt:
      Add(campo, integer(valor), AdicionarParametro);
    varByte:
      Add(campo, integer(valor), AdicionarParametro);
    varWord:
      Add(campo, string(valor), TamanhoCampo, AdicionarParametro);
    varLongWord:
      Add(campo, string(valor), TamanhoCampo, AdicionarParametro);
    varInt64:
      Add(campo, integer(valor), AdicionarParametro);
    varStrArg:
      Add(campo, string(valor), TamanhoCampo, AdicionarParametro);
    varString:
      Add(campo, string(valor), TamanhoCampo, AdicionarParametro);
    varUString:
      Add(campo, string(valor), TamanhoCampo, AdicionarParametro);
    varAny:
      Add(campo, string(valor), TamanhoCampo, AdicionarParametro);
  end;
end;


end.
