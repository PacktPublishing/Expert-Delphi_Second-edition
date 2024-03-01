program ToDoListRESTClient;
uses
  System.StartUpCopy,
  FMX.Forms,
  uFormToDoRESTClient in 'uFormToDoRESTClient.pas' {FormToDoRESTClient},
  uDMToDoWebBrokREST in 'uDMToDoWebBrokREST.pas' {DMToDoWebBrokREST: TDataModule},
  uToDoTypes in '..\shared\uToDoTypes.pas',
  uToDoUtils in '..\shared\uToDoUtils.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.CreateForm(TFormToDoRESTClient, FormToDoRESTClient);
  Application.CreateForm(TDMToDoWebBrokREST, DMToDoWebBrokREST);
  Application.Run;
end.
