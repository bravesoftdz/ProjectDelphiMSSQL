unit fmuMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fmuBaseForm, uConnection, Data.DB, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, fmuConsumpion, System.UITypes, FireDAC.Stan.Param;

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
  uResStrings, fmuSQL, uiBase, uMain, uConsumpion;

{ TfmMain }

procedure TfmMain.actAddExecute(Sender: TObject);
var
  oConsumpion: TfmConsumpion;
  oForm: IBaseForm;
begin
  inherited;
  oConsumpion := TfmConsumpion.Create(Self);
  if oConsumpion.GetInterface(IBaseForm, oForm) then
  begin
    oConsumpion.Data := nil;
    oForm.FormInit;
  end;
  if oConsumpion.ShowModal = mrOk then
  begin
    ActionModif(oConsumpion.Data);
  end;
  oConsumpion.Data.Free;
  FSQuery.RefreshData;
end;

procedure TfmMain.actDeleteExecute(Sender: TObject);
var
  oField: TField;
  oSQuery: TSQuery;
begin
  inherited;
  oField := D.DataSet.FindField('ID');
  if oField <> nil then
  begin
    if MessageDlg(Format(TfmMain_Delete, [oField.AsInteger]), TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbNo, TMsgDlgBtn.mbYes], -1) = mrYes then
    begin
      oSQuery := TSQuery.Create(Connect, 'DELETE Consumpions WHERE ID = :ID');
      try
        oSQuery.Query.ParamByName('ID').AsInteger := oField.AsInteger;
        if oSQuery.ExecSQL() then
        begin
          FSQuery.RefreshData;
        end;
      finally
        FreeAndNil(oSQuery);
      end;
    end;
  end;
end;

procedure TfmMain.actEditExecute(Sender: TObject);
var
  oConsumpion: TfmConsumpion;
  oForm: IBaseForm;
  oField: TField;
  oSQuery: TSQuery;
begin
  inherited;
  oConsumpion := TfmConsumpion.Create(Self);
  if oConsumpion.GetInterface(IBaseForm, oForm) then
  begin
    oConsumpion.Data := TConsumpionData.Create;
    oField := D.DataSet.FindField('ClientID');
    if oField <> nil then
    begin
      oConsumpion.Data.ClientID := oField.AsInteger;
    end;
    oField := D.DataSet.FindField('Done');
    if oField <> nil then
    begin
      oConsumpion.Data.Done := oField.AsInteger = 1;
    end;
    oField := D.DataSet.FindField('ID');
    if oField <> nil then
    begin
      oConsumpion.Data.ConsumpionID := oField.AsInteger;
      oSQuery := GetListConsumpionComposition(oField.AsInteger);
      try
        oConsumpion.Data.LoadFromQuery(oSQuery);
      finally
        FreeAndNil(oSQuery);
      end;
    end;
    oForm.FormInit;
  end;
  if oConsumpion.ShowModal = mrOk then
  begin
    ActionModif(oConsumpion.Data);
  end;
  oConsumpion.Data.Free;
  FSQuery.RefreshData;
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
    '  c.ClientID, '+sLineBreak+
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
