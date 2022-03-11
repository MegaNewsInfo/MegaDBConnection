# Como instalar o pacote do Mega Conexão

1 - Adicionar no libary path a pasta Conexao\ParametroConexao do projeto

2 - Adicionar no libary path a pasta Conexao do projeto

3 - Adicionar no libary path a pasta Factories do projeto

4 - Adicionar no libary path a pasta Logger do projeto

5 - Adicionar no libary path a pasta Query do projeto

6 - Adicionar no libary path a pasta SqlBuilder do projeto

7 - Adicionar no libary path a pasta Utils do projeto


---


# Como utilizar o pacote Mega Conexao

1 - Agora basta implementar no projeto alvo a interface do banco de dados escolhido que se encontra na pasta Conexao\ParametroConexao 

```pascal
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

```

2 - Criar uma instancia da classe implementada no passo anterior e injetar na implementação da interface IMegaConexao do banco Escolhido (Implementa-la no form principal ou no datamodulo pois se trata de uma instancia singleton)

```pascal
Constructor Create;
  begin
    FMegaConexao := TConexaoFireBird.GetInstance(TLeitorParametrosFireBird.Create);
  end;
```

3 - Quando for utilizar basta criar uma variavel do tipo da interface iQuery e receber da fábrica TQueryFactory, passando o tipo da conexão;
```pascal

procedure Buscar;
var
    lQuery : iQuery;
begin
    lQuery := TFactoryQuery.Create.Criar(tcFirebird);
end;
```

4 - Podemos utilizar um contrutor de sql, o ISQLBuider através de uma variavel deste tipo recebendo da fábrica TFactorySqlBuilder passando o tipo do SQL.

## Exemplo Deletar
```pascal 
procedure TClass.NomeProcedure(Sender: TObject);
var
 sqlbuilder :  Isqlbuilder;
begin
  sqlbuilder := TFactorySqlBuilder.Create.Criar(tComDelete);
  sqlbuilder.Tabela('GRUPO')
              .Criterio('ID_GRUPO = '+DataSource1.DataSet.FieldByName('ID_GRUPO').AsString);
    FQuery.ExecuteSql(sqlbuilder);

   SelecionaDados;
end;
```


## Exemplo Update
```pascal
procedure TClass.NomeProcedure(Sender: TObject);
var
 sqlbuilder :  Isqlbuilder;
begin
   sqlbuilder := TFactorySqlBuilder.Create.Criar(tComUpdate);
   sqlbuilder.Tabela('GRUPO')
              .Add('GRUPO','TESTE 2')
              .Criterio('ID_GRUPO = '+DataSource1.DataSet.FieldByName('ID_GRUPO').AsString);
    FQuery.ExecuteSql(sqlbuilder);

   SelecionaDados;

end;
```

## Exemplo Insert
```pascal
procedure TClass.NomeProcedure(Sender: TObject);
 var
 sqlbuilder :  Isqlbuilder;
begin
    sqlbuilder := TFactorySqlBuilder.Create.Criar(tComInsert);

    sqlbuilder.Tabela('GRUPO')
              .Add('GRUPO','TESTE')
              .Add('COMISSAO',0)
              .Add('DATA_ATUALIZACAO',Now);

     FQuery.StartTransaction;
     FQuery.ExecuteSql(sqlbuilder);
     FQuery.CommitTransaction;
     SelecionaDados;

end;
```

## Exemplo Select
```pascal
procedure TClass.NomeProcedure;
begin
   DataSource1.DataSet := FQuery.SQL('SELECT * FROM GRUPO').DataSet;
end;
```

