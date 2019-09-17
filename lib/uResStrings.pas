unit uResStrings;

interface

const
  {Системные сообщения}
  TSystem_InitCondsole     = sLineBreak+'~> По всей видимости забыта инициализация!!!!'+sLineBreak+' Для формы: %s.%s (%s)'+sLineBreak;
  TSystem_InitMsg          = 'По всей видимости забыта инициализация!!!!'+sLineBreak+sLineBreak+' Для формы: %s.%s (%s)';
  Application_ErrorMessage = 'Ошибка подключения к базе проверки корректность ввода и повторите попытку';

  TLog_Connect = 'Имя подключения %s - (класс: %s) '+sLineBreak+'параметры:'+sLineBreak+'%s';

  {Форма подключения и инициализации SQL Server}
  TfmSQL_Form               = 'Настройка подключения';
  TfmSQL_gbLoginAndPassword = 'Логин и пароль для подключения';
  TfmSQL_lbLogin            = 'Логин';
  TfmSQL_lbPassword         = 'Пароль';
  TfmSQL_gbServerConnection = 'Сервер и база данных';
  TfmSQL_lbServer           = 'SQL Server';
  TfmSQL_lbDB               = 'База данных';
  TfmSQL_cbServers          = 'Поле выбора или ввода сервера для подключений';
  TfmSQL_edDB               = 'Поле для ввода название базы данных';
  TfmSQL_btReloadServers    = 'Получить список доступных SQL Server в сети';
  TfmSQL_edLogin            = 'Поле для ввода логина';
  TfmSQL_edPassword         = 'Поле для ввода пароля пользователя';
  TfmSQL_cbDB               = 'Поле выбора или ввода базы данных для подключений';
  TfmSQL_btReloadDBs        = 'Получить список баз данных доступных на сервере';
  TfmSQL_acClose            = 'Закрыть';
  TfmSQL_acConfirm          = 'Подключится';

  {Главная форма}

  TfmMain_Form = 'Главная форма';

implementation

end.
