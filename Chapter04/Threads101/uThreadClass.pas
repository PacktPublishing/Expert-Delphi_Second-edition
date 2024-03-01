unit uThreadClass;

interface

uses
  System.Classes, System.Generics.Collections;

type
  TMyThread = class(TThread)
  private
    FIntList: TList<Integer>;
    procedure FillList;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  uThreadForm, System.SyncObjs;

var
  CS: TCriticalSection;

{ TMyThread }

constructor TMyThread.Create;
begin
  inherited Create (True);
  FIntList := TList<Integer>.Create;
end;

destructor TMyThread.Destroy;
begin
  FIntList.Free;
  inherited;
end;

procedure TMyThread.Execute;
var
  LMin, LMax: Integer;
begin
  FillList;

  LMin := 100_000_000;
  for var I := 0 to FIntList.Count - 1 do
  begin
    if FIntList[I] < LMin  then
      LMin := FIntList[I];
  end;

  Synchronize(
    procedure
    begin
      FormThread.ShowMin(LMin);
    end);

  LMax := 0;

  TMonitor.Enter(FIntList);
  try
    for var I := 0 to FIntList.Count - 1 do
    begin
      if FIntList[I] > LMax  then
        LMax := FIntList[I];
    end;
  finally
    TMonitor.Exit(FIntList);
  end;

  Synchronize(
    procedure
    begin
      FormThread.ShowMax(LMax);
    end);

end;

procedure TMyThread.FillList;
begin
  Randomize;
  CS.Acquire;
  try
    for var I := 1 to 100_000_000 do
      FIntList.Add(Random (MaxInt));
  finally
    CS.Release;
  end;
end;

initialization
  CS := TCriticalSection.Create;

finalization
  CS.Free;
end.
