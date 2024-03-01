unit uInlineVar;

interface

procedure Test;

implementation

uses
  System.Math;

procedure Test;
begin
  var X := 20.0;
  var I := Trunc(X);

  for var J := 1 to 10 do
  begin

  end; // J goes out of scope

end;

end.
