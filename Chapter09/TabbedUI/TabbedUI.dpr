program TabbedUI;

uses
  System.StartUpCopy,
  FMX.Forms,
  TabbedUIForm in 'TabbedUIForm.pas' {HeaderFooterwithNavigation};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(THeaderFooterwithNavigation, HeaderFooterwithNavigation);
  Application.Run;
end.
