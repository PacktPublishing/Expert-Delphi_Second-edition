unit uFormSunCodeAnim;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects;

type
  TFormSunCodeAnim = class(TForm)
    PaintBox1: TPaintBox;
    Timer1: TTimer;
    procedure PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FSunPosY: Double;
  end;

var
  FormSunCodeAnim: TFormSunCodeAnim;

implementation

{$R *.fmx}

uses uFmxCanvasHelper;

const
  END_SUN_POS_Y = 150;

procedure TFormSunCodeAnim.FormCreate(Sender: TObject);
begin
  FSunPosY := self.Height + 150;
end;

procedure TFormSunCodeAnim.Timer1Timer(Sender: TObject);
begin
  if FSunPosY > END_SUN_POS_Y then
    FSunPosY := FSunPosY - 10;
  Invalidate;
end;

const
  DEFAULT_OPACITY = 1;
  POS_X = 150;
  SUN_RADIUS = 50;
  RAY_COUNT = 12;
  RAY_LENGTH = 100;

procedure TFormSunCodeAnim.PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
begin
  Canvas.BeginScene;
  try
    // draw blue sky
    Canvas.SolidRect(PaintBox1.BoundsRect, TAlphaColorRec.Skyblue);

    var X := POS_X;
    var Y := FSunPosY;

    // draw yellow sun solid circle
    Canvas.SolidCircle(PointF(x, y),
      SUN_RADIUS, TAlphaColorRec.Yellow);

    // draw sun rays
    for var I := 0 to RAY_COUNT-1 do
    begin
      var Angle := I * Pi * 2 / RAY_COUNT;
      var A := PointF(X, Y);
      var B := PointF(
        X + RAY_LENGTH * Cos(Angle),
        Y + RAY_LENGTH * Sin(Angle));
      Canvas.Line(A, B, TAlphaColorRec.Yellow, 5);
    end;

  finally
    Canvas.EndScene;
  end;
end;

end.
