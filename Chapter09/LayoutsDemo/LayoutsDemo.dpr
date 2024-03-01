program LayoutsDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  LayoutsDemo_Form in 'LayoutsDemo_Form.pas' {TabbedForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TTabbedForm, TabbedForm);
  Application.Run;
end.
