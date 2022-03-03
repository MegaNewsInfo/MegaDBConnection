unit MegaConexao.SqlBuilder.SqlBuilderUpdate;

interface

uses
  MegaConexao.SqlBuilder.SqlBuilderBase, MegaConexao.SqlBuilder.iSqlBuilder,
  System.SysUtils, System.Classes, System.StrUtils,
  System.Generics.Collections;

type
  TSQLBuilderUpdate = class(TBaseSqlBuilder, ISqlBuilder)
  private
    FCriterio : string;
    function MontaCampos : String;

  public
    function Add(Campo: string; Valor: Variant; TamanhoCampo: Integer = 0;
      AdicionarParametro: Boolean = True): iSqlBuilder;
    function Criterio(pCriterio: string): iSqlBuilder;
    function Tabela(pTabela: string): iSqlBuilder;
    function ToString: string; override;


  end;

implementation

{ TSQLBuilderUpDate }

function TSQLBuilderUpdate.Add(Campo: string; Valor: Variant;
  TamanhoCampo: Integer; AdicionarParametro: Boolean): iSqlBuilder;
begin
  inherited Add(Campo,Valor,TamanhoCampo,AdicionarParametro);
  Result := self;
end;



function TSQLBuilderUpdate.Criterio(pCriterio: string): iSqlBuilder;
begin
  FCriterio := pCriterio;
  result := Self;
end;


function TSQLBuilderUpdate.MontaCampos: String;
var
  UpdateSintax: TStringList;
  ValorStr: string;
  SeparatorSintax: string;
  i: integer;
  lListaCampos : TList<TCampo>;
begin
  try


    try
      UpdateSintax := TStringList.Create;
      lListaCampos := RetornaListaCampo;

      for i := 0 to self.Count - 1 do
      begin
        ValorStr := IfThen(lListaCampos[i].Quoted = True,
                           QuotedStr(lListaCampos[i].ValorCampo),
                           lListaCampos[i].ValorCampo);

        SeparatorSintax := IfThen(i = (self.Count - 1), '', ',');

        UpdateSintax.Add(lListaCampos[i].NomeCampo + ' = ' +
                         ValorStr                          +
                         SeparatorSintax);
      end;

      Result := UpdateSintax.Text;

    finally
      if Assigned(UpdateSintax) then
        FreeAndNil(UpdateSintax);
    end;
  except on E: Exception do
    begin
      if Assigned(UpdateSintax) then
        FreeAndNil(UpdateSintax);

      raise Exception.Create(e.Message);

    end;
  end;

end;

function TSQLBuilderUpdate.Tabela(pTabela: string): iSqlBuilder;
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

function TSQLBuilderUpdate.ToString: string;
begin
  Result := '';

  if (self.Count > 0) then
  begin

    Result := 'UPDATE ' + NomeTabela + ' SET  ' + #13 +
              MontaCampos + #13 +
              IfThen(FCriterio <> '', ' WHERE ' + #13 +
              StringReplace(FCriterio,
                            'WHERE',
                            '',
                            [rfReplaceAll]),
                            '');


  end;

end;

end.
