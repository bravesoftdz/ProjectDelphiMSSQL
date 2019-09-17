unit uConnection;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Phys.MSSQL;

type
  TConnection = class
  private
    FConnectSQL: TFDCOnnection;
    procedure TryConnect;
  public
    constructor Create;
    destructor Destroy; override;
    property ConnectSQL: TFDCOnnection read FConnectSQL;
    function Connected : Boolean;
    procedure Reload;
  end;

  TMyQuery = class(TInterfacedObject)
  private
    FQuery : TFDQuery;
    FSQL: String;
    FConnection: TConnection;
    procedure SetConnection(const Value: TConnection);
    procedure SetSQL(const Value: String);
  public
    constructor Create(aConnect : TConnection; aSQL : String); overload;
    constructor Create; overload;
    destructor Destroy; override;
    property Connection: TConnection read FConnection write SetConnection;
    property SQL: String read FSQL write SetSQL;
    function Open(var vQuery: TFDQuery; aSQL : String = '') : Boolean;
    function ExecSQL(aSQL : String = ''): Boolean;
  end;

var
  Connect: TConnection;

implementation

uses
  uSetting, System.SysUtils;

{ TConnection }

function TConnection.Connected: Boolean;
begin
  Result := FConnectSQL.Connected;
end;

constructor TConnection.Create;
begin
  inherited Create;
  TryConnect;
end;

destructor TConnection.Destroy;
begin
  if Assigned(FConnectSQL) then
  begin
    FConnectSQL.Close;
    FreeAndNil(FConnectSQL);
  end;
  inherited;
end;

procedure TConnection.Reload;
begin
  TryConnect;
end;

procedure TConnection.TryConnect;
begin
  if Not Assigned(FConnectSQL) then
  begin
    FConnectSQL := TFDConnection.Create(nil);
  end;
  FConnectSQL.Params.Clear;
  if Setting.CheckInputSQL then
  begin
    FConnectSQL.Params.Values['User_Name']       := Setting.Login;
    FConnectSQL.Params.Values['Password']        := Setting.Password;
    FConnectSQL.Params.Values['Server']          := Setting.Server;
    FConnectSQL.Params.Values['Database']        := Setting.Database;
    FConnectSQL.Params.Values['ApplicationName'] := ExtractFileName(ParamStr(0))+'_TestProject';
    FConnectSQL.Params.Values['DriverID']        := 'MSSQL';
    try
      FConnectSQL.Connected := True;
    except
    end;
  end;
end;

{ TMyQuery }

constructor TMyQuery.Create(aConnect: TConnection; aSQL: String);
begin
  inherited Create;
  FConnection := aConnect;
  FSQL := aSQL;
  FQuery.SQL.Text := FSQL;
  if FConnection.Connected then
  begin
    FQuery.Connection := FConnection.ConnectSQL;
  end;
end;

constructor TMyQuery.Create;
begin
  inherited Create;
  FQuery := TFDQuery.Create(nil);
end;

destructor TMyQuery.Destroy;
begin
  if Assigned(FQuery) then
  begin
    FQuery.Close;
    FreeAndNil(FQuery);
  end;
  inherited;
end;

function TMyQuery.ExecSQL(aSQL: String): Boolean;
begin
  try
    FQuery.ExecSQL(aSQL);
    Result := True;
  except on E: Exception do
    begin
      Result := False;
    end;
  end;
end;

function TMyQuery.Open(var vQuery: TFDQuery; aSQL: String): Boolean;
begin
  try
    FQuery.Open(aSQL);
    Result := True;
  except on E: Exception do
    begin
      Result := False;
    end;
  end;
end;

procedure TMyQuery.SetConnection(const Value: TConnection);
begin
  if FConnection <> Value then
  begin
    FConnection := Value;
    if FConnection.Connected then
    begin
      FQuery.Connection := FConnection.ConnectSQL;
    end;
  end;
end;

procedure TMyQuery.SetSQL(const Value: String);
begin
  if FSQL <> Value then
  begin
    FSQL := Value;
    FQuery.SQL.Text := FSQL;
  end;
end;

end.
