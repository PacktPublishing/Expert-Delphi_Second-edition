unit uFormSunRotate;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Ani, FMX.Effects, FMX.Gestures;
type
  TFormSunRotate = class(TForm)
    RectSky: TRectangle;
    CircleSun: TCircle;
    LineRay01: TLine;
    LineRay02: TLine;
    LineRay03: TLine;
    LineRay04: TLine;
    LineRay05: TLine;
    LineRay06: TLine;
    LineRay07: TLine;
    LineRay08: TLine;
    LineRay09: TLine;
    LineRay10: TLine;
    LineRay11: TLine;
    LineRay12: TLine;
    FloatAnimation1: TFloatAnimation;
    procedure FormCreate(Sender: TObject);
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    FReady: Boolean;
    FDown: TPointF;
    FMoving: Boolean;
    FLastAngle: Double;
  public
    { Public declarations }
  end;
var
  FormSunRotate: TFormSunRotate;
implementation
{$R *.fmx}
procedure TFormSunRotate.FormCreate(Sender: TObject);
begin
  FMoving := False;
  FReady := False;
  FloatAnimation1.StartValue := RectSky.Height + 150;
end;
procedure TFormSunRotate.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  if EventInfo.GestureID = igiRotate then
  begin
    if (TInteractiveGestureFlag.gfBegin in EventInfo.Flags) then
      FLastAngle := circleSun.RotationAngle
    else if EventInfo.Angle <> 0 then
      CircleSun.RotationAngle := FLastAngle - (EventInfo.Angle * 180) / Pi;
  end;
end;
procedure TFormSunRotate.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if FMoving then
  begin
    CircleSun.Position.X := CircleSun.Position.X + (X - FDown.X);
    CircleSun.Position.Y := CircleSun.Position.Y + (Y - FDown.Y);
    FMoving := False;
  end;

end;

procedure TFormSunRotate.FloatAnimation1Finish(Sender: TObject);
begin
  FReady := True;
end;
procedure TFormSunRotate.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if FReady then
  begin
    FDown := PointF(X, Y);
    FMoving := True;
  end;
end;

end.
