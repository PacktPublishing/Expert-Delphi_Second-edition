program DropTarget;

uses
  System.StartUpCopy,
  FMX.Forms,
  DropTarget_Form in 'DropTarget_Form.pas' {FormDrop};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormDrop, FormDrop);
  Application.Run;
end.
