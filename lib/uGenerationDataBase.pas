unit uGenerationDataBase;

interface

uses
  FireDAC.Comp.Client;

type
  THelpDB = class
  private
    FConnection : TFDConnection;
    FLogin: String;
    FPassword: String;
    FServer: String;
    FDatabase: String;
  public
    property Login: String read FLogin write FLogin;
    property Password: String read FPassword write FPassword;
    property Server: String read FServer write FServer;
    property Database: String read FDatabase write FDatabase;

    constructor Create;
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
