program Greeter;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

var
  y, m, d: Word;
begin
  var date := IncMonth(EncodeDate(2000,1,1), -1);
  DecodeDate(date, y, m, d);
  Writeln(y, '-', m, '-', d);
  Readln;
end.
