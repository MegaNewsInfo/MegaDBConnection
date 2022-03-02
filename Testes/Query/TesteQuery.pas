unit TesteQuery;

interface
uses
  DUnitX.TestFramework;

type

  [TestFixture]
  TesteQuery = class(TObject) 
  public
  end;

implementation


initialization
  TDUnitX.RegisterTestFixture(TesteQuery);
end.
