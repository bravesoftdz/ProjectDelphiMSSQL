unit uSetting;

interface

uses
  REST.Json.Types;

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
  public
    property Login: String read FLogin write FLogin;
    property Password: String read FPassword write FPassword;
    property Server: String read FServer write FServer;
    property Database: String read FDatabase write FDatabase;
    function Load : Boolean;
    function Save : Boolean;
  end;

function Setting : TSetting;

implementation

uses
  System.Classes, System.SysUtils, JSON, REST.Json;

var
  sSettingFileName : String = '';
  __Setting : TSetting = nil;

function Setting : TSetting;
begin
  if Not Assigned(__Setting) then
  begin
    __Setting := TSetting.Create;
    __Setting.Load;
  end;
  Result := __Setting;
end;

{ TSetting }

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
        Result := False;
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

initialization
  sSettingFileName := ExtractFilePath(ParamStr(0))+'data\setting.txt';


end.
