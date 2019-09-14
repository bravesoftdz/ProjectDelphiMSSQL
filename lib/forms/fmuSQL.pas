unit fmuSQL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  fmuBaseForm;

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
  private

  public
    procedure FormInit; override;
  end;

var
  fmSQL: TfmSQL;

implementation

uses
  uResStrings;

{$R *.dfm}

{ TfmSQL }

procedure TfmSQL.FormInit;
begin
  inherited FormInit;

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

  Self.cbDB.Hint                  := TfmSQL_cbDB;
  Self.btReloadDBs.Hint           := TfmSQL_btReloadDBs;

end;

end.
