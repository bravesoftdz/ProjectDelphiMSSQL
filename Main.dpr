program Main;

uses
  Vcl.Forms,
  fmuMain in 'fmuMain.pas' {fmMain},
  fmuSQL in 'lib\forms\fmuSQL.pas' {fmSQL},
  uGenerationDataBase in 'lib\uGenerationDataBase.pas',
  fmuBaseForm in 'lib\forms\fmuBaseForm.pas' {fmBaseForm},
  uiBase in 'lib\uiBase.pas',
  uSetting in 'lib\uSetting.pas',
  uResStrings in 'lib\uResStrings.pas';

{$R *.res}

var
  oForm : IBaseForm;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  if fmMain.GetInterface(IBaseForm, oForm) then
  begin
    oForm.FormInit;
  end;
  Application.Run;
end.
