unit uAnonymous;

interface

procedure DoStringProc;

implementation

uses
  uFormDemo;

type
  TStringProc = reference to procedure(S: string);

procedure CallMe(const Proc: TStringProc; Msg: string);
begin
  Proc(Msg);
end;

procedure DoStringProc;
var
  Proc: TStringProc;
begin

  Proc := procedure(X: string)
  begin
    Log('Declared proc got: ' + X);
  end;

  CallMe(Proc, 'Hello');

  CallMe(
       procedure(V: string)
       begin
         Log('Inline code got: ' + V);
       end,
       'World');
end;

end.
