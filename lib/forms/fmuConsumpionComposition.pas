unit fmuConsumpionComposition;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fmuBaseForm, uConsumpionComposition, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, System.Actions, Vcl.ActnList;

type
  TfmConsumpionComposition = class(TfmBaseForm)
    cbGoodID: TComboBox;
    edCount: TMaskEdit;
    lbCount: TLabel;
    lbGood: TLabel;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Panel1: TPanel;
    Panel2: TPanel;
    lbPrice: TLabel;
    edPrice: TMaskEdit;
    Panel4: TPanel;
    ActionList1: TActionList;
    actCancel: TAction;
    actOk: TAction;
    procedure actOkExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure cbGoodIDChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edCountChange(Sender: TObject);
    procedure edPriceChange(Sender: TObject);
    procedure edPriceKeyPress(Sender: TObject; var Key: Char);
  private
    FData: TCompositionData;
  public
    procedure FormInit; override;
    property Data: TCompositionData read FData write FData;
  end;

var
  fmConsumpionComposition: TfmConsumpionComposition;

implementation

uses
  uResStrings, uConnection;

{$R *.dfm}

{ TfmConsumpionComposition }

procedure TfmConsumpionComposition.actCancelExecute(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfmConsumpionComposition.actOkExecute(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

procedure TfmConsumpionComposition.cbGoodIDChange(Sender: TObject);
begin
  inherited;
  if cbGoodID.ItemIndex <> -1 then
  begin
    FData.GoodIDChange := True;
    FData.GoodID := TGoodData(cbGoodID.Items.Objects[cbGoodID.ItemIndex]).ID;
    FData.Name   := TGoodData(cbGoodID.Items.Objects[cbGoodID.ItemIndex]).Caption;
  end;
end;

procedure TfmConsumpionComposition.edCountChange(Sender: TObject);
var
  dValue: Double;
begin
  inherited;
  if TryStrToFloat(edCount.Text, dValue) then
  begin
    FData.CountChange := True;
    FData.Count       := dValue;
  end;
end;

procedure TfmConsumpionComposition.edPriceChange(Sender: TObject);
var
  dValue: Double;
begin
  inherited;
  if TryStrToFloat(edPrice.Text, dValue) then
  begin
    FData.PriceChange := True;
    FData.Price       := dValue;
  end;
end;

procedure TfmConsumpionComposition.edPriceKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key <> #8 then
  begin
    if CharInSet(Key, ['.', ',']) then
    begin
      Key := FormatSettings.DecimalSeparator;
      if String(TMaskEdit(Sender).Text).Contains(Key) then
      begin
        Key := #0;
      end;
    end
    else if CharInSet(Key, ['-']) then
    begin
      if String(TMaskEdit(Sender).Text).Contains(Key) then
      begin
        Key := #0;
      end
      else
      begin
        TMaskEdit(Sender).Text := '-'+TMaskEdit(Sender).Text;
        Key := #0;
        TMaskEdit(Sender).SelStart := Length(TMaskEdit(Sender).Text);
      end;
    end
    else if Not CharInSet(Key, ['0'..'9']) then
    begin
      Key := #0
    end;
  end;
end;

procedure TfmConsumpionComposition.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
  oItem: TGoodData;
begin
  inherited;
  for i := 0 to cbGoodID.Items.Count-1 do
  begin
    oItem := TGoodData(cbGoodID.Items.Objects[i]);
    FreeAndNil(oItem);
  end;
  cbGoodID.Clear;
end;

procedure TfmConsumpionComposition.FormInit;
var
  oSQ: TSQuery;
  oQ: TMyQuery;
  iItem: Integer;
  iItemIndex: Integer;
begin
  if Self.Data <> nil then
  begin
    Self.Caption := Format(TfmConsumpionComposition_FormCaption, [TfmConsumpionComposition_Form, TfmConsumpionComposition_FormEdit]);
  end
  else
  begin
    Self.Caption := Format(TfmConsumpionComposition_FormCaption, [TfmConsumpionComposition_Form, TfmConsumpionComposition_FormNew]);
  end;

  Self.lbCount.Caption   := TfmConsumpionComposition_lbCount;
  Self.lbPrice.Caption   := TfmConsumpionComposition_lbPrice;
  Self.lbGood.Caption    := TfmConsumpionComposition_lbGood;
  Self.actCancel.Caption := TfmConsumpionComposition_actCancel;
  Self.actOk.Caption     := TfmConsumpionComposition_actOk;

  if FData = nil then
  begin
    FData := TCompositionData.Create;
    FData.New := True;
    FData.GoodIDChange := True;
    FData.PriceChange := True;
    FData.CountChange := True;
  end
  else
  begin
    Self.edCount.Text := FData.Count.ToString;
    Self.edPrice.Text := FData.Price.ToString;
  end;

  oSQ := TSQuery.Create(Connect, 'SELECT ID, Name FROM goods');
  try
    if oSQ.Open(oQ) then
    begin
      iItemIndex := -1;
      while Not oQ.Eof do
      begin
        iItem :=cbGoodID.Items.AddObject(oQ.FieldByName('Name').AsString, TGoodData.Create(oQ.FieldByName('Name').AsString, oQ.FieldByName('ID').AsInteger));
        if oQ.FieldByName('ID').AsInteger = FData.GoodID then
        begin
          iItemIndex := iItem;
        end;
        oQ.Next;
      end;
      if iItemIndex <> -1 then
      begin
        cbGoodID.ItemIndex := iItemIndex;
      end;
    end;
  finally
    FreeAndNil(oSQ);
  end;

end;

end.
