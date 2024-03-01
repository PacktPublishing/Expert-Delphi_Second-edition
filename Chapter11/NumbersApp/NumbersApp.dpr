program NumbersApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  NumbersAppForm in 'NumbersAppForm.pas' {FormNumbers},
  NumberConversion in 'NumberConversion.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormNumbers, FormNumbers);
  Application.Run;
end.
