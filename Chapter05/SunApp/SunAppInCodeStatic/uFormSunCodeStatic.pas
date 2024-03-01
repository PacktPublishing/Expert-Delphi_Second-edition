unit uFormSunCodeStatic;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects;

type
  TFormSunCodeStatic = class(TForm)
    PaintBox1: TPaintBox;
    procedure PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSunCodeStatic: TFormSunCodeStatic;

implementation

{$R *.fmx}

const
  DEFAULT_OPACITY = 1;
  POS_X = 150;
  POS_Y = 150;
  SUN_RADIUS = 50;
  RAY_COUNT = 12;
  RAY_LENGTH = 100;

procedure TFormSunCodeStatic.PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
begin
  Canvas.BeginScene;
  try
    // draw blue sky
    Canvas.Fill.Color := TAlphaColorRec.Skyblue;
    Canvas.FillRect(PaintBox1.BoundsRect, 0, 0, [], DEFAULT_OPACITY);

    // draw yellow sun solid circle
    Canvas.Fill.Color := TAlphaColorRec.Yellow;
    Canvas.Fill.Kind := TBrushKind.Solid;
    var X := POS_X;
    var Y := POS_Y;
    var R := SUN_RADIUS;
    var ARect := RectF(X-R, Y-R, X+R, Y+R);
    Canvas.FillEllipse(ARect, DEFAULT_OPACITY);

    // prepare stroke for drawing sun rays
    Canvas.Stroke.Color := TAlphaColorRec.Yellow;
    Canvas.Stroke.Kind := TBrushKind.Solid;
    Canvas.Stroke.Thickness := 5;

    // draw sun rays
    for var I := 0 to RAY_COUNT-1 do
    begin
      var Angle := I * Pi * 2 / RAY_COUNT;
      var A := PointF(X, Y);
      var B := PointF(
        X + RAY_LENGTH * Cos(Angle),
        Y + RAY_LENGTH * Sin(Angle));
      Canvas.DrawLine(A, B, DEFAULT_OPACITY);
    end;

  finally
    Canvas.EndScene;
  end;
end;

end.
