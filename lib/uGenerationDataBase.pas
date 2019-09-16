unit uGenerationDataBase;

interface

uses
  uConnection;

type
  THelpDB = class
  private
  public
    constructor Create(oConnection : TConnection);
    procedure CreateDB(aFileName : String);
  end;

implementation

{ THelpDB }

constructor THelpDB.Create;
begin

end;

procedure THelpDB.CreateDB(aFileName: String);
begin

end;

end.
