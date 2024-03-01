program WeatherClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  WeatherClient_Form in 'WeatherClient_Form.pas' {FormWeather},
  WeatherClient_Module in 'WeatherClient_Module.pas' {DMWeather: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormWeather, FormWeather);
  Application.CreateForm(TDMWeather, DMWeather);
  Application.Run;
end.
