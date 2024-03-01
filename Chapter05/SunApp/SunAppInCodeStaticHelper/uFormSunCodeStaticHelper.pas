unit uFormSunCodeStaticHelper;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects;

type
  TFormSunCodeStaticHelper = class(TForm)
    PaintBox1: TPaintBox;
    procedure PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSunCodeStaticHelper: TFormSunCodeStaticHelper;

implementation

{$R *.fmx}

uses uFmxCanvasHelper;

const
  DEFAULT_OPACITY = 1;
  POS_X = 150;
  POS_Y = 150;
  SUN_RADIUS = 50;
  RAY_COUNT = 12;
  RAY_LENGTH = 100;

procedure TFormSunCodeStaticHelper.PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
var
  Angle: double;
  A, B: TPointF;
begin
  Canvas.BeginScene;
  try
    // draw blue sky
    Canvas.SolidRect(PaintBox1.BoundsRect, TAlphaColorRec.Skyblue);

    // draw yellow sun solid circle
    Canvas.SolidCircle(PointF(POS_X, POS_Y),
      SUN_RADIUS, TAlphaColorRec.Yellow);

    // draw sun rays
    for var i := 0 to RAY_COUNT-1 do
    begin
      Angle := i * pi * 2 / RAY_COUNT;
      A := PointF(POS_X, POS_Y);
      B := PointF(
        POS_X + RAY_LENGTH * cos(Angle),
        POS_Y + RAY_LENGTH * sin(Angle));
      Canvas.Line(A, B, TAlphaColorRec.Yellow, 5);
    end;

  finally
    Canvas.EndScene;
  end;
end;

end.
