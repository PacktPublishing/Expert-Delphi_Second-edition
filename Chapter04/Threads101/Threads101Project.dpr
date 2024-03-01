program Threads101Project;

uses
  System.StartUpCopy,
  FMX.Forms,
  uThreadForm in 'uThreadForm.pas' {FormThread},
  uThreadClass in 'uThreadClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormThread, FormThread);
  Application.Run;
end.
