unit fmuSQL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  fmuBaseForm, System.Actions, Vcl.ActnList;

type
  TfmSQL = class(TfmBaseForm)
    gbLoginPassword: TGroupBox;
    edLogin: TEdit;
    paLogin: TPanel;
    lbLogin: TLabel;
    paPassword: TPanel;
    lbPassword: TLabel;
    edPassword: TEdit;
    gbServerConnection: TGroupBox;
    paServer: TPanel;
    lbServer: TLabel;
    paDB: TPanel;
    lbDB: TLabel;
    cbServers: TComboBox;
    cbDB: TComboBox;
    btReloadServers: TSpeedButton;
    btReloadDBs: TSpeedButton;
    Button1: TSpeedButton;
    Button2: TSpeedButton;
    ActionList1: TActionList;
    actClose: TAction;
    actConfirm: TAction;
    procedure ActionList1Update(Action: TBasicAction; var Handled: Boolean);
    procedure actCloseExecute(Sender: TObject);
    procedure actConfirmExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
    procedure FormInit; override;
  end;

var
  fmSQL: TfmSQL;

implementation

uses
  uResStrings, uSetting, uConnection;

{$R *.dfm}

{ TfmSQL }

procedure TfmSQL.actCloseExecute(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfmSQL.actConfirmExecute(Sender: TObject);
begin
  inherited;
//  ModalResult      := mrOk;
  Setting.Login    := edLogin.Text;
  Setting.Password := edPassword.Text;
  Setting.Server   := cbServers.Text;
  Setting.Database := cbDB.Text;
  Connect.Reload;
  if Not Connect.Connected then
  begin
    ShowMessage(Application_ErrorMessage);
  end
  else
  begin
    ModalResult := mrOk
  end;
end;

procedure TfmSQL.ActionList1Update(Action: TBasicAction; var Handled: Boolean);
begin
  inherited;
  actConfirm.Enabled :=
    (Trim(edLogin.Text) <> '') and
    (Trim(edPassword.Text) <> '') and
    (Trim(cbServers.Text) <> '') and
    (Trim(cbDB.Text) <> '');
end;

procedure TfmSQL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmSQL.FormInit;
begin

  Self.Caption                    := TfmSQL_Form;
  Self.gbLoginPassword.Caption    := TfmSQL_gbLoginAndPassword;

  Self.lbLogin.Caption            := TfmSQL_lbLogin;
  Self.edLogin.Hint               := TfmSQL_edLogin;

  Self.lbPassword.Caption         := TfmSQL_lbPassword;
  Self.edPassword.Hint            := TfmSQL_edPassword;

  Self.gbServerConnection.Caption := TfmSQL_gbServerConnection;

  Self.lbServer.Caption           := TfmSQL_lbServer;
  Self.cbServers.Hint             := TfmSQL_cbServers;
  Self.btReloadServers.Hint       := TfmSQL_btReloadServers;

  Self.lbDB.Caption               := TfmSQL_lbDB;
  Self.cbDB.Hint                  := TfmSQL_cbDB;
  Self.btReloadDBs.Hint           := TfmSQL_btReloadDBs;

  Self.actClose.Caption           := TfmSQL_acClose;
  Self.actConfirm.Caption         := TfmSQL_acConfirm;

  Self.edLogin.Text := Setting.Login;
  Self.edPassword.Text := Setting.Password;
  Self.cbServers.Items.Add(Setting.Server);
  Self.cbDB.Items.Add(Setting.Database);
  Self.cbServers.ItemIndex := 0;
  Self.cbDB.ItemIndex := 0;

  if Setting.Login.Trim = '' then
  begin
    Self.ActiveControl := edLogin;
  end;

end;

end.
