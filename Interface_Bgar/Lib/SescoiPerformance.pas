unit SescoiPerformance;

interface

uses
  System.SysUtils,
  System.DateUtils;

type
  TElapsedTime = class
  private
    FStartTime: TDateTime;
    FStopTime:  TDateTime;

    function GetInfo():String;
  public
    constructor Create();
    procedure Stop();

    property Info: string read GetInfo;
  end;

implementation

{ TElapsedTime }

constructor TElapsedTime.Create;
{-------------------------------------------------------------------------------
  Procedure: TElapsedTime.Create
  Author:    vdupuis
  DateTime:  2015.05.21
-------------------------------------------------------------------------------}
begin
  FStopTime:=Now();
  FStartTime:=Now();
end;

function TElapsedTime.GetInfo: String;
{-------------------------------------------------------------------------------
  Procedure: TElapsedTime.GetInfo
  Author:    vdupuis
  DateTime:  2015.05.21
-------------------------------------------------------------------------------}
const
  Displayformat=  'hh:nn:ss.zzz';
begin
  if CompareDateTime(FStopTime, FStartTime)<=0 then
  begin
    Result:=FormatDateTime(Displayformat, Now()-FStartTime);
  end
  else
  begin
    Result:=FormatDateTime(Displayformat, FStopTime-FStartTime);
  end;
end;

procedure TElapsedTime.Stop;
{-------------------------------------------------------------------------------
  Procedure: TElapsedTime.Stop
  Author:    vdupuis
  DateTime:  2015.05.21
-------------------------------------------------------------------------------}
begin
  FStopTime:=Now();
end;

end.
