unit uHelpUnit;

interface

function DebuggerPresent: boolean;

implementation

uses
  Winapi.Windows;

function DebuggerPresent: boolean;
type
  TDebugProc = function: boolean; stdcall;
var
  Kernel32: HMODULE;
  DebugProc: TDebugProc;
begin
  Result := False;
  Kernel32 := GetModuleHandle('kernel32.dll');
  if Kernel32 <> 0 then
  begin
    @DebugProc := GetProcAddress(Kernel32, 'IsDebuggerPresent');
    if Assigned(DebugProc) then
      Result := DebugProc;
  end;
end;

end.
