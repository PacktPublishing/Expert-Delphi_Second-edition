program MultiViewDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  MultiViewDemo_Form in 'MultiViewDemo_Form.pas' {MViewForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMViewForm, MViewForm);
  Application.Run;
end.
