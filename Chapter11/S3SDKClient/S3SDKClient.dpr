program S3SDKClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  S3SDKClient_MainForm in 'S3SDKClient_MainForm.pas' {FormS3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormS3, FormS3);
  Application.Run;
end.
