unit fmuMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fmuBaseForm, uConnection;

type
  TfmMain = class(TfmBaseForm)
  private
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

procedure TfmMain.FormInit;
begin
  Self.Caption := TfmMain_Form;
end;

end.
