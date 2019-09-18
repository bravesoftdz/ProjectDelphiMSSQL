unit fmuMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fmuBaseForm, uConnection, Data.DB, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons;

type
  TfmMain = class(TfmBaseForm)
    btClients: TSpeedButton;
    btGoods: TSpeedButton;
    gbConsumpion: TGroupBox;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    btDelete: TSpeedButton;
    btEdit: TSpeedButton;
    btAdd: TSpeedButton;
    ActionList1: TActionList;
    D: TDataSource;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actClients: TAction;
    actGoods: TAction;
    procedure ActionList1Update(Action: TBasicAction; var Handled: Boolean);
    procedure actGoodsExecute(Sender: TObject);
    procedure actClientsExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FSQuery : TSQuery;
  public
    procedure FormInit; override;
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

uses
  uResStrings, fmuSQL, uiBase;

{ TfmMain }

procedure TfmMain.actAddExecute(Sender: TObject);
begin
  inherited;
  { TODO : Добавить расход }
end;

procedure TfmMain.actClientsExecute(Sender: TObject);
begin
  inherited;
  { TODO : Показать форму клиентов }
end;

procedure TfmMain.actDeleteExecute(Sender: TObject);
begin
  inherited;
  { TODO : Удалить расход }
end;

procedure TfmMain.actEditExecute(Sender: TObject);
begin
  inherited;
  { TODO : Редактировать расход }
end;

procedure TfmMain.actGoodsExecute(Sender: TObject);
begin
  inherited;
  { TODO : Показать форму товаров }
end;

procedure TfmMain.ActionList1Update(Action: TBasicAction; var Handled: Boolean);
begin
  inherited;
  actAdd.Enabled := Assigned(D.DataSet) and (D.DataSet.Active);
  actEdit.Enabled := Assigned(D.DataSet) and (D.DataSet.Active) and (D.DataSet.RecordCount > 0);
  actDelete.Enabled := Assigned(D.DataSet) and (D.DataSet.Active) and (D.DataSet.RecordCount > 0) and (D.DataSet.FieldByName('Done').AsInteger = 0) ;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FSQuery) then
  begin
    FreeAndNil(FSQuery);
  end;
end;

procedure TfmMain.FormInit;
var
  oQuery: TMyQuery;
  oColumn: TColumn;
begin
  Self.Caption := TfmMain_Form;

  Self.btClients.Caption    := TfmMain_btClients;
  Self.btGoods.Caption      := TfmMain_btGoods;
  Self.btAdd.Caption        := TfmMain_btAdd;
  Self.btEdit.Caption       := TfmMain_btEdit;
  Self.btDelete.Caption     := TfmMain_btDelete;
  Self.gbConsumpion.Caption := TfmMain_gbConsumpion;

  FSQuery := TSQuery.Create(
    Connect,
    'SELECT '+sLineBreak+
    '  c.ID, '+sLineBreak+
    '  cl.Name, '+sLineBreak+
    '  c.DateTimeCreate, '+sLineBreak+
    '  c.DateTimeDone, '+sLineBreak+
    '  c.DateTimeInsert, '+sLineBreak+
    '  c.Done, '+sLineBreak+
    '  c.Sum, '+sLineBreak+
    '  case when c.Done = 0 then N'''+TfmMain_DoneOpen+''' else '''+TfmMain_DoneClose+''' end as DoneTextStatus '+sLineBreak+
    'FROM Consumpions c'+sLineBreak+
    ' LEFT JOIN Clients cl on (cl.ID = c.ClientID)');

  if FSQuery.Open(oQuery) then
  begin
    D.DataSet := oQuery;

    {Колонка ФИО Клиента}
    oColumn := DBGrid1.Columns.Add;
    oColumn.Title.Caption := TfmMain_ClientName;
    oColumn.FieldName := 'Name';
    oColumn.Width := 100;

    {Колонка дата создания}
    oColumn := DBGrid1.Columns.Add;
    oColumn.Title.Caption := TfmMain_DateTimeCreate;
    oColumn.FieldName := 'DateTimeCreate';

    {Колонка даты закрытия расхода}
    oColumn := DBGrid1.Columns.Add;
    oColumn.Title.Caption := TfmMain_DateTimeDone;
    oColumn.FieldName := 'DateTimeDone';

    {Колонка внесения в базу}
    oColumn := DBGrid1.Columns.Add;
    oColumn.Title.Caption := TfmMain_DateTimeInsert;
    oColumn.FieldName := 'DateTimeInsert';

    {КОлонка суммы расхода}
    oColumn := DBGrid1.Columns.Add;
    oColumn.Title.Caption := TfmMain_Sum;
    oColumn.Title.Alignment := taRightJustify;
    oColumn.FieldName := 'Sum';
    oColumn.Alignment := taRightJustify;

    {Колонка тестового состояния заказа}
    oColumn := DBGrid1.Columns.Add;
    oColumn.Title.Caption := TfmMain_Done;
    oColumn.FieldName := 'DoneTextStatus';

  end;

end;

end.
