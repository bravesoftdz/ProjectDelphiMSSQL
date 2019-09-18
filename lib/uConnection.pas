unit uConnection;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Phys.MSSQL, FireDAC.DApt, FireDAC.Comp.UI, FireDAC.Stan.Async;

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

  TMyQuery = class(TFDQuery)

  end;

  TSQuery = class(TInterfacedObject)
  private
    FQuery : TMyQuery;
    FSQL: String;
    FConnection: TConnection;
    procedure SetConnection(const Value: TConnection);
    procedure SetSQL(const Value: String);
  public
    constructor Create(aConnect : TConnection; aSQL : String); overload;
    constructor Create(); overload;
    destructor Destroy; override;
    property Connection: TConnection read FConnection write SetConnection;
    property SQL: String read FSQL write SetSQL;
    function Open(var vQuery: TMyQuery; aSQL : String = '') : Boolean;
    function ExecSQL(aSQL : String = ''): Boolean;
  end;

var
  Connect: TConnection;

implementation

uses
  uSetting, System.SysUtils, FireDAC.UI.Intf, Vcl.Forms;

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
    FConnectSQL := TFDConnection.Create(Application);
    FConnectSQL.ResourceOptions.SilentMode := True;
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

constructor TSQuery.Create(aConnect: TConnection; aSQL: String);
begin
  Create();
  FConnection := aConnect;
  FSQL := aSQL;
  FQuery.SQL.Text := FSQL;
  if FConnection.Connected then
  begin
    FQuery.Connection := FConnection.ConnectSQL;
  end;
end;

constructor TSQuery.Create;
begin
  inherited Create;
  FQuery := TMyQuery.Create(nil);
end;

destructor TSQuery.Destroy;
begin
  if Assigned(FQuery) then
  begin
    FQuery.Close;
    FreeAndNil(FQuery);
  end;
  inherited;
end;

function TSQuery.ExecSQL(aSQL: String): Boolean;
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

function TSQuery.Open(var vQuery: TMyQuery; aSQL: String): Boolean;
begin
  try
    FQuery.Open(aSQL);
    vQuery := FQuery;
    Result := True;
  except on E: Exception do
    begin
      Result := False;
    end;
  end;
end;

procedure TSQuery.SetConnection(const Value: TConnection);
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

procedure TSQuery.SetSQL(const Value: String);
begin
  if FSQL <> Value then
  begin
    FSQL := Value;
    FQuery.SQL.Text := FSQL;
  end;
end;

end.
