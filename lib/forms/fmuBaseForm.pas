unit fmuBaseForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uiBase;

type
  TfmBaseForm = class(TForm, IBaseForm)
  private
  public
    procedure FormInit; virtual; abstract;
  end;

implementation

{$R *.dfm}

end.
