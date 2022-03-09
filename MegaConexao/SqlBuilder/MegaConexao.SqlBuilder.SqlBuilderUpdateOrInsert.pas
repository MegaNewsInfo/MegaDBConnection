unit MegaConexao.SqlBuilder.SqlBuilderUpdateOrInsert;

interface

uses
  MegaConexao.SqlBuilder.iSqlBuilder, MegaConexao.SqlBuilder.SqlBuilderBase,
  System.Classes, System.SysUtils;

Type TSqlBuilderUpdateOrInsert = class(TBaseSqlBuilder, ISqlBuilder)
 private
    function MontaCampos : String;
    function MontaValores() : string;
 public
    function Add(Campo: string; Valor: Variant; TamanhoCampo: Integer = 0;
      AdicionarParametro: Boolean = True): iSqlBuilder;
    function Criterio(pCriterio: string): iSqlBuilder;
    function Tabela(pTabela: string): iSqlBuilder;
    function ToString: string;

end;

implementation

uses
  System.StrUtils, System.Generics.Collections;

{ TSqlBuilderUpdateOrInsert }

function TSqlBuilderUpdateOrInsert.Add(Campo: string; Valor: Variant;
  TamanhoCampo: Integer; AdicionarParametro: Boolean): iSqlBuilder;
begin
  inherited Add(Campo,Valor,TamanhoCampo,AdicionarParametro);
  Result := self;
end;

function TSqlBuilderUpdateOrInsert.Criterio(pCriterio: string): iSqlBuilder;
begin
  result := Self;
end;

function TSqlBuilderUpdateOrInsert.MontaCampos: String;
var
  posicao : Integer;
  SeparatorSintax: string;
  InsertIntoSintax: TStringList;
  lListaCampos : TList<TCampo>;
begin
  try
    try
      InsertIntoSintax := TStringList.Create;
      lListaCampos := RetornaListaCampo;
      for posicao := 0 to pred(self.Count) do
      begin
        SeparatorSintax := IfThen(posicao = pred(self.Count), '', ',');
        InsertIntoSintax.Add(lListaCampos[posicao].NomeCampo + SeparatorSintax);
      end;
      result := InsertIntoSintax.Text;
    finally
      if Assigned(InsertIntoSintax) then
      begin
        FreeAndNil(InsertIntoSintax);
      end;
    end;
  except on E : Exception do
    begin
      if Assigned(InsertIntoSintax) then
      begin
        FreeAndNil(InsertIntoSintax);
      end;

      raise E;
    end;
  end;
end;

function TSqlBuilderUpdateOrInsert.MontaValores: string;
var
  posicao : Integer;
  SeparatorSintax: string;
  ValuesSintax: TStringList;
  ValorStr : string;
  lListaCampos : TList<TCampo>;
begin
   try
    try
      ValuesSintax := TStringList.Create;
      lListaCampos := RetornaListaCampo;
      for posicao := 0 to pred(self.Count) do
      begin
        ValorStr := IfThen(lListaCampos[posicao].Quoted = true, QuotedStr(lListaCampos[posicao].ValorCampo),
                           lListaCampos[posicao].ValorCampo);
        SeparatorSintax := IfThen(posicao = pred(self.Count),'', ',');
        ValuesSintax.Add(ValorStr + SeparatorSintax);
      end;
      result := ValuesSintax.Text;
    finally
      if Assigned(ValuesSintax) then
      begin
        FreeAndNil(ValuesSintax);
      end;
    end;
  except on E : Exception do
    begin
      if Assigned(ValuesSintax) then
      begin
        FreeAndNil(ValuesSintax);
      end;

      raise E;
    end;
  end;
end;

function TSqlBuilderUpdateOrInsert.Tabela(pTabela: string): iSqlBuilder;
begin
  try
    inherited Tabela(pTabela);
    Result := Self;
  except on E : Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TSqlBuilderUpdateOrInsert.ToString: string;
begin
  try
    Result := '';
    if (self.Count > 0) then
    begin
      Result := 'UPDATE OR INSERT INTO ' + NomeTabela + ' (' + MontaCampos +
        ') VALUES (' + sLineBreak + MontaValores + ')';
    end
  except on E : Exception do
    begin
      raise Exception.Create('Erro ao transformar para SQL. ' + #13#10 + E.Message);
    end;
  end;
end;

end.
