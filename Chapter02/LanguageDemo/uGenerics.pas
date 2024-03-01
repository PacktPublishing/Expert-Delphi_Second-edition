unit uGenerics;

interface

uses
  FMX.Types;

type
  TFmxProcessor<T: TFMXObject, constructor> = class
  end;

  TRecordReporter<T> = class
    procedure DoReport<T: record>(X: T);
  end;

implementation

{ TRecordReporter<T> }

procedure TRecordReporter<T>.DoReport<T>(X: T);
begin
// ...
end;

end.
