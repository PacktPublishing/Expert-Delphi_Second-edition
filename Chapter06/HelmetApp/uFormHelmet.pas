unit uFormHelmet;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Viewport3D,
  System.Math.Vectors, FMX.Controls3D, FMX.MaterialSources, FMX.Types3D,
  FMX.Objects3D;

type
  TFormHelmet = class(TForm)
    Viewport3D1: TViewport3D;
    DummyCamera: TDummy;
    CameraZ: TCamera;
    LightCamera: TLight;
    DummyScene: TDummy;
    Model3D1: TModel3D;
    LightMaterialSource1: TLightMaterialSource;
    procedure Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure Viewport3D1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure Viewport3D1MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    FDown: TPointF;
    FLastDistance: integer;
    procedure DoZoom(AIn: boolean);
  public
    { Public declarations }
  end;

var
  FormHelmet: TFormHelmet;

implementation

{$R *.fmx}

const
  ROTATION_STEP = 0.3;

procedure TFormHelmet.FormCreate(Sender: TObject);
begin
  for var Mesh: TMesh in Model3D1.MeshCollection do
    mesh.MaterialSource := LightMaterialSource1;
end;

procedure TFormHelmet.Viewport3D1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FDown := PointF(X, Y);
end;

procedure TFormHelmet.Viewport3D1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
begin
  if (ssLeft in Shift) then
  begin
    DummyCamera.RotationAngle.X := DummyCamera.RotationAngle.X - ((Y - FDown.Y) * ROTATION_STEP);
    DummyCamera.RotationAngle.Y := DummyCamera.RotationAngle.Y + ((X - FDown.X) * ROTATION_STEP);
    FDown := PointF(X, Y);
  end;
end;

const
  ZOOM_STEP = 2;
  CAMERA_MAX_Z = -2;
  CAMERA_MIN_Z = -102;

procedure TFormHelmet.DoZoom(AIn: boolean);
var
  NewZ: single;
begin
  if AIn then
    NewZ := CameraZ.Position.Z + ZOOM_STEP
  else
    NewZ := CameraZ.Position.Z - ZOOM_STEP;

  if (NewZ < CAMERA_MAX_Z) and (NewZ > CAMERA_MIN_Z) then
    CameraZ.Position.Z := NewZ;
end;

procedure TFormHelmet.Viewport3D1MouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
  DoZoom(WheelDelta > 0);
end;

procedure TFormHelmet.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  if EventInfo.GestureID = igiZoom then
  begin
    if (not (TInteractiveGestureFlag.gfBegin in EventInfo.Flags))
      and (not (TInteractiveGestureFlag.gfEnd in EventInfo.Flags)) then
    begin
      var Delta := EventInfo.Distance - FLastDistance;
      DoZoom(Delta > 0);
    end;
    FLastDistance := EventInfo.Distance;
  end;
end;

end.
