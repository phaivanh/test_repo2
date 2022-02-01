unit uTranslations;

interface

  function _(AText: string):string;

implementation

function _(AText: string):string;
{-------------------------------------------------------------------------------
  Procedure: _
  Author:    vdupuis
  DateTime:  2015.05.13
-------------------------------------------------------------------------------}
begin
  Result:=AText;
end;

end.
