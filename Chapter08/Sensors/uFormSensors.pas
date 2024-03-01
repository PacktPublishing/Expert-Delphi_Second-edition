unit uFormSensors;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Sensors,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Sensors.Components;
type
  TFormSensors = class(TForm)
    LocationSensor1: TLocationSensor;
    ChkbxLocSensor: TCheckBox;
    LblLocation: TLabel;
    MotionSensor1: TMotionSensor;
    OrientationSensor1: TOrientationSensor;
    ChkbxMotion: TCheckBox;
    LblLinearAccel: TLabel;
    LblHeadingXYZ: TLabel;
    ChkbxOrientation: TCheckBox;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    Label1: TLabel;
    procedure ChkbxLocSensorChange(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure ChkbxMotionChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ChkbxOrientationChange(Sender: TObject);
  private
    function DblToStr(Value: Double): string;
  public
    { Public declarations }
  end;

var
  FormSensors: TFormSensors;

implementation

uses
  System.Math,
  System.Permissions,
  FMX.DialogService;

{$R *.fmx}

procedure TFormSensors.ChkbxLocSensorChange(Sender: TObject);
const
  PermissionAccessFineLocation =
    'android.permission.ACCESS_FINE_LOCATION';
begin
{$IFDEF ANDROID}
  PermissionsService.RequestPermissions([PermissionAccessFineLocation],
    procedure(const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray)
    begin
      if (Length(AGrantResults) = 1) and (AGrantResults[0] = TPermissionStatus.Granted) then
        { activate or deactivate the location sensor }
        LocationSensor1.Active := ChkbxLocSensor.IsChecked
      else
      begin
        ChkbxLocSensor.IsChecked := False;
        TDialogService.ShowMessage('Location permission not granted');
      end;
    end);
{$ELSE}
  LocationSensor1.Active := ChkbxLocSensor.IsChecked;
{$ENDIF}
end;

procedure TFormSensors.ChkbxMotionChange(Sender: TObject);
begin
  MotionSensor1.Active := ChkbxMotion.IsChecked;
end;

procedure TFormSensors.ChkbxOrientationChange(Sender: TObject);
begin
   OrientationSensor1.Active := ChkbxOrientation.IsChecked;
end;

function TFormSensors.DblToStr(Value: Double): string;
begin
  if not IsNan(Value) then
    Result := Format('%3.5f',[Value])
  else
    Result := 'NaN';
end;

procedure TFormSensors.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
begin
  LblLocation.Text := DblToStr(NewLocation.Latitude)
     + ' : ' + DblToStr(NewLocation.Longitude);
end;

procedure TFormSensors.Timer1Timer(Sender: TObject);
begin
  if Assigned (MotionSensor1.Sensor) then
  begin
    LblLinearAccel.Text := DblToStr(MotionSensor1.Sensor.AccelerationX) + ', '
      + DblToStr(MotionSensor1.Sensor.AccelerationY) + ', '
      + DblToStr(MotionSensor1.Sensor.AccelerationZ);
  end;
  if Assigned (OrientationSensor1.Sensor) then
  begin
    LblHeadingXYZ.Text := DblToStr(OrientationSensor1.Sensor.HeadingX) + ', '
      + DblToStr(OrientationSensor1.Sensor.HeadingY) + ', '
      + DblToStr(OrientationSensor1.Sensor.HeadingZ);
  end;
end;

end.
