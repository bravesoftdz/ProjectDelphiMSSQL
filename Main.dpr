program Main;

uses
  Vcl.Forms,
  fmuMain in 'fmuMain.pas' {fmMain},
  fmuSQL in 'lib\forms\fmuSQL.pas' {fmSQL},
  uGenerationDataBase in 'lib\uGenerationDataBase.pas',
  fmuBaseForm in 'lib\forms\fmuBaseForm.pas' {fmBaseForm},
  uiBase in 'lib\uiBase.pas',
  uSetting in 'lib\uSetting.pas',
  uResStrings in 'lib\uResStrings.pas',
  uHelpUnit in 'lib\uHelpUnit.pas',
  uConnection in 'lib\uConnection.pas',
  Vcl.Controls,
  System.SysUtils,
  Vcl.Dialogs,
  fmuConsumpion in 'lib\forms\fmuConsumpion.pas' {fmConsumpion},
  uMain in 'lib\uMain.pas',
  uConsumpion in 'lib\uConsumpion.pas';

{$R *.res}

var
  oForm : IBaseForm;
  oConnectSQL : TfmSQL;

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  //Создаем класс и проверяем подключение к базе, если пользователь закрыл авторизацию то непоказываем программу и сразу завершаем
  Connect := TConnection.Create;
  if Not Connect.Connected then
  begin
    Application.CreateForm(TfmSQL, oConnectSQL);
    if oConnectSQL.GetInterface(IBaseForm, oForm) then
    begin
      oForm.FormInit;
    end;
    //В цикле опрашиваем пользователя данные о подключении пока не будет успешно или пользователь не закроет программу
    while Not Connect.Connected do
    begin
      if oConnectSQL.ShowModal <> mrOk then
      begin
        FreeAndNil(oConnectSQL);
        Break;
      end;
    end;
    if Connect.Connected then
    begin
      //Удаляем предыдущую главную форму (для корректного отображения в пуске и возможность свернуть и развернуть окна)
      Application.CreateForm(TfmMain, fmMain);
      if fmMain.GetInterface(IBaseForm, oForm) then
      begin
        oForm.FormInit;
      end;
      Pointer((@Application.MainForm)^) := fmMain;
      //Для корректной установки Главной формы, если это делать потом то главная форма может не появится так как будет вторая в списке
      FreeAndNil(oConnectSQL);
      Application.Run;
    end;
  end
  else
  begin
    Application.CreateForm(TfmMain, fmMain);
    if fmMain.GetInterface(IBaseForm, oForm) then
    begin
      oForm.FormInit;
    end;
    Application.Run;
  end;
  FreeAndNil(Connect);
end.
