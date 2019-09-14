unit fmuMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fmuBaseForm;

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
  uResStrings;

{ TfmMain }

procedure TfmMain.FormInit;
begin

  Self.Caption := TfmMain_Form;
end;

end.
