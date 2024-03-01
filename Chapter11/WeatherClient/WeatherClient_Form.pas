unit WeatherClient_Form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope;

type
  TFormWeather = class(TForm)
    BtnRefresh: TButton;
    EditLocation: TEdit;
    LabelTemp: TLabel;
    procedure BtnRefreshClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormWeather: TFormWeather;

implementation

{$R *.fmx}

uses WeatherClient_Module;

procedure TFormWeather.BtnRefreshClick(Sender: TObject);
begin
  if (DMWeather.RESTRequest1.Params[0].Value = 'YOUR API KEY GOES HERE') or
    (DMWeather.RESTRequest1.Params[0].Value = '') then
  begin
    ShowMessage ('API access key is missing');
    Exit;
  end;

  DMWeather.RESTRequest1.Params[1].Value := EditLocation.Text;
  DMWeather.RESTRequest1.Execute();
  LabelTemp.Text := DMWeather.FDMemTable1.FieldByName('temperature').AsString;
end;

end.
