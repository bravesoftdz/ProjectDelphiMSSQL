unit fmuConsumpion;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fmuBaseForm, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls,
  uConnection, System.UITypes, uConsumpion;

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
    Panel3: TPanel;
    btOk: TSpeedButton;
    btCancel: TSpeedButton;
    actOk: TAction;
    actCancel: TAction;
    procedure ActionList1Update(Action: TBasicAction; var Handled: Boolean);
    procedure actAddExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
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
  uResStrings;

{$R *.dfm}

{ TfmConsumpion }

procedure TfmConsumpion.actAddExecute(Sender: TObject);
begin
  inherited;
  { TODO : Реализовать добавление товара }
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
begin
  inherited;
  { TODO : Добавить редактирование товара }
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

procedure TfmConsumpion.FormInit;
begin
  if Not Assigned(FData) then
  begin
    Self.Caption := Format(TfmConsumpion_FormCaption, [TfmConsumpion_Form, TfmConsumpion_FormTypeCreate]);
    FData := TConsumpionData.Create;
    FData.ListGoods.Active := True;
  end
  else
  begin
    Self.Caption := Format(TfmConsumpion_FormCaption, [TfmConsumpion_Form, TfmConsumpion_FormTypeEdit]);
  end;
  Self.actAdd.Caption := TfmConsumpion_btAdd;
  Self.actEdit.Caption := TfmConsumpion_btEdit;
  Self.actDelete.Caption := TfmConsumpion_btDelete;
  Self.actOk.Caption := TfmConsumpion_btOk;
  Self.actCancel.Caption := TfmConsumpion_btCancel;
  D.DataSet := FData.ListGoods;
end;

end.
