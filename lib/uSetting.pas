unit uSetting;

interface

uses
  REST.Json.Types, FireDAC.Comp.Client;

type
  TSetting = class
  private
    [JSONNameAttribute('Login')]
    FLogin: String;
    [JSONNameAttribute('Password')]
    FPassword: String;
    [JSONNameAttribute('Server')]
    FServer: String;
    [JSONNameAttribute('DataBase')]
    FDatabase: String;
    procedure Default;
  public
    property Login: String read FLogin write FLogin;
    property Password: String read FPassword write FPassword;
    property Server: String read FServer write FServer;
    property Database: String read FDatabase write FDatabase;
    function Load : Boolean;
    function Save : Boolean;
    function CheckInputSQL : Boolean;
  end;

  TLog = class
  private
    FFile : TextFile;
  public
    constructor Create(aFileName : String);

    procedure WriteLogQuery(aQuery : TFDQuery);
    procedure WriteLogConnection(aConnection : TFDConnection);
    destructor Destroy; override;
  end;

function Setting : TSetting;
function log : TLog;

implementation

uses
  System.Classes, System.SysUtils, JSON, REST.Json;

var
  sSettingFileName : String = '';
  sLogFileName     : String = '';

  __Setting : TSetting = nil;
  __Log : TLog = nil;

function log : TLog;
begin
  if Not Assigned(__Log) then
  begin
    __Log := TLog.Create(sLogFileName);
  end;
  Result := __Log;
end;

function Setting : TSetting;
begin
  if Not Assigned(__Setting) then
  begin
    __Setting := TSetting.Create;
    //Если при загрузке произошла ошибка ...
    try
      __Setting.Load;
    except
      //...заполняем значением по умолчанию
      __Setting.Default;
    end;
  end;
  Result := __Setting;
end;

{ TSetting }

function TSetting.CheckInputSQL: Boolean;
begin
  Result :=
    (Login.Trim() <> '') and
    (Password.Trim() <> '') and
    (Server.Trim() <> '') and
    (Database.Trim <> '')
end;

procedure TSetting.Default;
begin
  FLogin := 'sa';
  FPassword := '';
  FDatabase := '';
  FServer := '';
end;

function TSetting.Load: Boolean;
var
  oFile : TStringStream;
  oJSON: TJSONValue;
  oJSONObject : TJsonObject absolute oJSON;
begin
  Result := FileExists(sSettingFileName);
  if Result then
  begin
    oFile := TStringStream.Create();
    try
      try
        oFile.LoadFromFile(sSettingFileName);
        oJSON := TJsonObject.ParseJSONValue(oFile.DataString);
        Result := (oJSON <> nil) and (oJSON is TJSONObject);
        if Result then
        begin
            TJson.JsonToObject(Self, oJSONObject);
        end;
      except on E : Exception do
        begin
          raise Exception.Create('Ошибка загрузки настроек из файла:'+E.Message);
        end;
      end;
    finally
      FreeAndNil(oFile);
    end;
  end;
end;

function TSetting.Save: Boolean;
var
  oFile: TStringStream;
  sData: string;
begin
  Result := ForceDirectories(ExtractFilePath(sSettingFileName));
  if Result then
  begin
    Result := False;
    oFile := TStringStream.Create;
    try
      sData := '';
      try
        sData := TJson.ObjectToJsonString(Self);
        oFile.WriteString(sData);
        oFile.SaveToFile(sSettingFileName);
      except on E: Exception do
        begin
          raise Exception.Create('Ошибка сохранения настроек в файл:'+E.Message);
        end;
      end;
    finally
      FreeAndNil(oFile);
    end;
  end;
end;

{ TLog }

constructor TLog.Create(aFileName: String);
begin
  AssignFile(FFile, sLogFileName);
  ReWrite(FFile);
end;

destructor TLog.Destroy;
begin
  CloseFile(FFile);
  inherited;
end;

procedure TLog.WriteLogConnection(aConnection: TFDConnection);
begin
  Write(FFile, aConnection.Name);
end;

procedure TLog.WriteLogQuery(aQuery: TFDQuery);
begin
  Write(FFile, aQuery.Name);
end;

initialization
  sSettingFileName := ExtractFilePath(ParamStr(0))+'data\setting.txt';
  sLogFileName := ExtractFilePath(ParamStr(0))+'data\log.txt';


end.
