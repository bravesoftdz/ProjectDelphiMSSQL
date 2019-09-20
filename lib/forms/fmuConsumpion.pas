unit fmuConsumpion;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fmuBaseForm, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls,
  uConnection, System.UITypes, uConsumpion, Vcl.ComCtrls;

type

  TfmConsumpion = class(TfmBaseForm)
    gbComposition: TGroupBox;
    Panel1: TPanel;
    Panel2: TPanel;
    ActionList1: TActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    btAdd: TSpeedButton;
    btEdit: TSpeedButton;
    btDelete: TSpeedButton;
    D: TDataSource;
    DBGrid1: TDBGrid;
    dtDateCreate: TDateTimePicker;
    lbDateCreate: TLabel;
    cbDone: TCheckBox;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    actCancel: TAction;
    actOk: TAction;
    cbClient: TComboBox;
    lbClient: TLabel;
    procedure ActionList1Update(Action: TBasicAction; var Handled: Boolean);
    procedure actAddExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure dtDateCreateChange(Sender: TObject);
    procedure cbDoneClick(Sender: TObject);
    procedure cbClientChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FData: TConsumpionData;
  public
    procedure FormInit; override;
    property Data: TConsumpionData read FData write FData;

  end;

var
  fmConsumpion: TfmConsumpion;

implementation

uses
  uResStrings, fmuConsumpionComposition, uiBase, uConsumpionComposition;

{$R *.dfm}

{ TfmConsumpion }

procedure TfmConsumpion.actAddExecute(Sender: TObject);
var
  oComposition: TfmConsumpionComposition;
  oForm: IBaseForm;
  oField: TField;
begin
  inherited;
  oComposition := TfmConsumpionComposition.Create(Self);
  if oComposition.GetInterface(IBaseForm, oForm) then
  begin
    oComposition.Data := nil;
    oForm.FormInit;
  end;
  if oComposition.ShowModal = mrOk then
  begin
    D.DataSet.Append;
    oField := D.DataSet.FindField('GoodName');
    if oField <> nil then
    begin
      oField.AsString := oComposition.Data.Name;
    end;
    oField := D.DataSet.FindField('GoodID');
    if oField <> nil then
    begin
      oField.AsInteger := oComposition.Data.GoodID;
    end;
    oField := D.DataSet.FindField('GoodCount');
    if oField <> nil then
    begin
      oField.AsFloat := oComposition.Data.Count;
    end;
    oField := D.DataSet.FindField('GoodPrice');
    if oField <> nil then
    begin
      oField.AsFloat := oComposition.Data.Price;
    end;
    oField := D.DataSet.FindField('GoodSum');
    if oField <> nil then
    begin
      oField.AsFloat := oComposition.Data.Count * oComposition.Data.Price;
    end;
    D.DataSet.FieldByName(TConsumpionData_New_FieldName).Value    := 1;
    D.DataSet.FieldByName(TConsumpionData_Delete_FieldName).Value := 0;
    D.DataSet.FieldByName(TConsumpionData_Modif_FieldName).Value  := 0;
    D.DataSet.Post;
  end;
  oComposition.Data.Free;
  FreeAndNil(oComposition);
end;

procedure TfmConsumpion.actCancelExecute(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfmConsumpion.actDeleteExecute(Sender: TObject);
var
  oFieldGoodName: TField;
  oFieldGoodID: TField;
begin
  inherited;
  oFieldGoodName := D.DataSet.FindField(TConsumpionData_GoodName_FieldName);
  oFieldGoodID := D.DataSet.FindField(TConsumpionData_GoodID_FieldName);
  if (oFieldGoodName <> nil) and (oFieldGoodID <> nil) then
  begin
    if MessageDlg(Format(TfmConsumpion_Delete, [oFieldGoodID.AsInteger, oFieldGoodName.AsString]), TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbNo, TMsgDlgBtn.mbYes], -1) = mrYes then
    begin
      D.DataSet.Edit;
      D.DataSet.FieldByName(TConsumpionData_Delete_FieldName).Value := 1;
      D.DataSet.Post;
    end;
  end;
end;

procedure TfmConsumpion.actEditExecute(Sender: TObject);
var
  oComposition: TfmConsumpionComposition;
  oForm: IBaseForm;
  oField: TField;
begin
  inherited;
  oComposition := TfmConsumpionComposition.Create(Self);
  if oComposition.GetInterface(IBaseForm, oForm) then
  begin
    oComposition.Data := TCompositionData.Create;
    oField := D.DataSet.FindField('ID');
    if oField <> nil then
    begin
      oComposition.Data.ID := oField.AsInteger;
    end;
    oField := D.DataSet.FindField('GoodID');
    if oField <> nil then
    begin
      oComposition.Data.GoodID := oField.AsInteger;
    end;
    oField := D.DataSet.FindField('GoodCount');
    if oField <> nil then
    begin
      oComposition.Data.Count := oField.AsFloat;
    end;
    oField := D.DataSet.FindField('GoodPrice');
    if oField <> nil then
    begin
      oComposition.Data.Price := oField.AsFloat;
    end;
    oForm.FormInit;
  end;
  if oComposition.ShowModal = mrOk then
  begin
    D.DataSet.Edit;
    oField := D.DataSet.FindField('GoodID');
    if oField <> nil then
    begin
      oField.AsInteger := oComposition.Data.GoodID;
    end;
    oField := D.DataSet.FindField('GoodCount');
    if oField <> nil then
    begin
      oField.AsFloat := oComposition.Data.Count;
    end;
    oField := D.DataSet.FindField('GoodPrice');
    if oField <> nil then
    begin
      oField.AsFloat := oComposition.Data.Price;
    end;
    oField := D.DataSet.FindField('GoodSum');
    if oField <> nil then
    begin
      oField.AsFloat := oComposition.Data.Count * oComposition.Data.Price;
    end;
    D.DataSet.FieldByName(TConsumpionData_Modif_FieldName).Value := 1;
    D.DataSet.Post;
  end;
  oComposition.Data.Free;
  FreeAndNil(oComposition);
end;

procedure TfmConsumpion.ActionList1Update(Action: TBasicAction; var Handled: Boolean);
begin
  inherited;
  actAdd.Enabled    := (D.DataSet <> nil) and (D.DataSet.Active);
  actEdit.Enabled   := (D.DataSet <> nil) and (D.DataSet.Active) and (D.DataSet.RecordCount > 0);
  actDelete.Enabled := (D.DataSet <> nil) and (D.DataSet.Active) and (D.DataSet.RecordCount > 0);
end;

procedure TfmConsumpion.actOkExecute(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

procedure TfmConsumpion.cbClientChange(Sender: TObject);
begin
  inherited;
  if (cbClient.ItemIndex <> -1) and (cbClient.Items.Objects[cbClient.ItemIndex] <> nil) then
  begin
    FData.ClientID := TClientData(cbClient.Items.Objects[cbClient.ItemIndex]).ID;
    FData.ClientIDChange := True;
  end;
end;

procedure TfmConsumpion.cbDoneClick(Sender: TObject);
begin
  inherited;
  FData.Done := cbDone.Checked;
  FData.DoneChange := True;
end;

procedure TfmConsumpion.dtDateCreateChange(Sender: TObject);
begin
  inherited;
  FData.DateCreate := dtDateCreate.Date;
  FData.DateTimeChange := True;
end;

procedure TfmConsumpion.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
  oItem: TClientData;
begin
  for i := 0 to cbClient.Items.Count-1 do
  begin
    oItem := TClientData(cbClient.Items.Objects[i]);
    FreeAndNil(oItem);
  end;
  cbClient.Items.Clear;
  if FData.New then
  begin
    if cbClient.ItemIndex <> -1 then
    begin
      FData.ClientID := TClientData(cbClient.Items.Objects[cbClient.ItemIndex]).ID;
    end
    else
    begin
      FData.ClientID := -1;
      FData.ClientIDChange := False;
    end;
    FData.Done := cbDone.Checked;
    FData.DateCreate := dtDateCreate.Date;

  end;
  inherited;
end;

procedure TfmConsumpion.FormInit;
var
  oSQL: TSQuery;
  oMySQL: TMyQuery;
  iItem: Integer;
  iItemIndex: Integer;
begin
  if Not Assigned(FData) then
  begin
    Self.Caption := Format(TfmConsumpion_FormCaption, [TfmConsumpion_Form, TfmConsumpion_FormTypeCreate]);
    FData := TConsumpionData.Create;
    FData.ListGoods.Active := True;
    FData.New := True;
    FData.DateTimeChange := True;
    FData.DoneChange := True;
    FData.ClientIDChange := True;
  end
  else
  begin
    Self.Caption := Format(TfmConsumpion_FormCaption, [TfmConsumpion_Form, TfmConsumpion_FormTypeEdit]);
  end;
  Self.actAdd.Caption       := TfmConsumpion_btAdd;
  Self.actEdit.Caption      := TfmConsumpion_btEdit;
  Self.actDelete.Caption    := TfmConsumpion_btDelete;
  Self.actCancel.Caption    := TfmConsumpion_btCancel;
  Self.actOk.Caption        := TfmConsumpion_btOk;
  Self.cbDone.Caption       := TfmConsumpion_cbDone;
  Self.lbDateCreate.Caption := TfmConsumpion_lbDateCreate;
  Self.lbClient.Caption     := TfmConsumpion_lbClient;

  Self.cbDone.Checked := FData.Done;
  Self.dtDateCreate.Date := FData.DateCreate;
  D.DataSet := FData.ListGoods;

  oSQL := TSQuery.Create(Connect, 'SELECT ID, Name FROM Clients');
  try
    if oSQL.Open(oMySQL) then
    begin
      iItemIndex := -1;
      while Not oMySQL.Eof do
      begin
        iItem := Self.cbClient.Items.AddObject(oMySQL.FieldByName('Name').AsString, TClientData.Create(oMySQL.FieldByName('Name').AsString, oMySQL.FieldByName('ID').AsInteger));
        if FData.ClientID = oMySQL.FieldByName('ID').AsInteger then
        begin
          iItemIndex := iItem;
        end;
        oMySQL.Next;
      end;
      if iItemIndex <> -1 then
      begin
        cbClient.ItemIndex := iItemIndex;
      end;
    end;
  finally
    FreeAndNil(oSQL);
  end;
end;

end.
