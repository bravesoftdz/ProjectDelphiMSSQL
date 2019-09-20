unit uConsumpionComposition;

interface

type
  TGoodData = class
  private
    FCaption: String;
    FID: Integer;
  public
    property Caption: String read FCaption write FCaption;
    property ID: Integer read FID write FID;
    constructor Create(aName : String; aID : Integer);
  end;

  TCompositionData = class
  private
    FID: Integer;
    FNew: Boolean;
    FName: String;
    FCount: Double;
    FGoodID: Integer;
    FPrice: Double;
    FGoodIDChange: Boolean;
    FPriceChange: Boolean;
    FCountChange: Boolean;
  public
    property ID: Integer read FID write FID;
    property New: Boolean read FNew write FNew;
    property Name: String read FName write FName;
    property Count: Double read FCount write FCount;
    property GoodID: Integer read FGoodID write FGoodID;
    property Price: Double read FPrice write FPrice;

    property GoodIDChange: Boolean read FGoodIDChange write FGoodIDChange;
    property PriceChange: Boolean read FPriceChange write FPriceChange;
    property CountChange: Boolean read FCountChange write FCountChange;

    constructor Create;

  end;

implementation

{ TCompositionData }

constructor TCompositionData.Create;
begin
  inherited Create;
  FGoodIDChange := False;
  FPriceChange := False;
  FCountChange := False;
  FNew := False;
end;

{ TGoodData }

constructor TGoodData.Create(aName: String; aID: Integer);
begin
  inherited Create;
  FCaption := aName;
  FID := aID;
end;

end.
