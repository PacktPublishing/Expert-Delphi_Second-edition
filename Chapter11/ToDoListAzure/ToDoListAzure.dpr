program ToDoListAzure;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFormToDo in 'uFormToDo.pas' {FormToDo},
  uDMToDo in 'uDMToDo.pas' {DMToDo: TDataModule},
  uToDoTypes in 'uToDoTypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMToDo, DMToDo);
  Application.CreateForm(TFormToDo, FormToDo);
  Application.Run;
end.
