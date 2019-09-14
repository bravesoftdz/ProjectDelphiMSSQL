unit fmuBaseForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uiBase;

type
  TfmBaseForm = class(TForm, IBaseForm)
  private
  public
    procedure FormInit; virtual;
  end;

implementation

uses
  uResStrings, uHelpUnit;

{$R *.dfm}

{ TfmBaseForm }

procedure TfmBaseForm.FormInit;
begin
  if DebuggerPresent then
  begin
    OutputDebugString(
      PWideChar(
        Format(
          TSystem_InitCondsole,
          [Self.UnitName, Self.Name, Self.ClassName]
          )
        )
      );
  end
  else
  begin
    ShowMessage(
      Format(
        TSystem_InitMsg,
        [Self.UnitName, Self.Name, Self.ClassName]
      ));
  end;
end;

end.
