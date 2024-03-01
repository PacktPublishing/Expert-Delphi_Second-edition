unit uGameUtils;

interface

function GameTimeToStr(Value: TTime): string;

implementation

uses
  System.SysUtils;

function Pad3Zeros(Value: string): string; inline;
var
  I: integer;
begin
  I := Length(Value);
  if I = 3 then
    Result := Value
  else if I = 2 then
    Result := '0' + Value
  else if I = 1 then
    Result := '00' + Value
  else
    Result := '000';
end;

function GameTimeToStr(Value: TTime): string;
var
  H, Min, Sec, Msec: Word;
  S: string;
begin
  DecodeTime(Value, H, Min, Sec, Msec);
  S := 'Time: ';
  if H > 0 then
    S := S + H.ToString + 'h ';
  if Min > 0 then
    S := S + Min.ToString + 'min ';

  S := S + Sec.ToString + '.' + Pad3Zeros(Msec.ToString) + 's';

  Result := S;
end;

end.
