unit fmuConsumpion;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fmuBaseForm;

type
  TConsumpionData = class
  public
  end;

  TfmConsumpion = class(TfmBaseForm)
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

procedure TfmConsumpion.FormInit;
begin
  inherited;
  Self.Caption := TfmConsumpion_Form;
end;

end.
