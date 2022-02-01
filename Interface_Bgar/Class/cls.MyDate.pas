unit cls.MyDate;


interface
uses System.SysUtils,
System.Generics.Collections;

type
  TElementDate = class
    private
      FMydateStrg : string;
      FMyDate : TDate;

    public
    constructor Create(AVal : TDate);
    function IsNull : Boolean;

    property MydateStrg : string read FMydateStrg ;
    property Mydate : Tdate  read FMydate;

  end;

type
  TDateList = class(TObjectList<TElementDate>)
  public
    function Exists(AElement:  TElementDate):Integer;
  end;


implementation


{ TElementDate }

constructor TElementDate.Create(AVal: TDate);
begin
  FMyDate := AVal;
  FMydateStrg := DateToStr(FMyDate);
end;

function TElementDate.IsNull: Boolean;
begin
    Result := FMyDate = EncodeDate(1899,12,30)
end;

{ TDateList }

function TDateList.Exists(AElement: TElementDate): Integer;
var
  ElementDate : TElementDate ;
begin
  Result:=-1;

  for ElementDate in Self do
  begin
    if ElementDate.FMyDate  = AElement.FMyDate   then
    begin
      Result:=Self.IndexOf(ElementDate);
      break;
    end;
  end;
end;
end.
