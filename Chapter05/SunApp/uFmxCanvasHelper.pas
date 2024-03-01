unit uFmxCanvasHelper;

interface

uses
  System.Types,
  System.UITypes,
  FMX.Graphics;

type
  TFmxCanvasHelper = class helper for TCanvas
    procedure Line(A, B: TPointF; AColor: TAlphaColor; AThickness: Single = 1);
    procedure SolidRect(ARect: TRectF; AColor: TAlphaColor = TAlphaColorRec.White);
    procedure SolidCircle(A: TPointF; R: Double; aColor: TAlphaColor);
  end;

implementation

const
  DEFAULT_OPACITY: Double = 1;

{ TFmxCanvasHelper }

procedure TFmxCanvasHelper.SolidRect(ARect: TRectF; AColor: TAlphaColor);
begin
  Fill.Color := AColor;
  FillRect(ARect, 0, 0, [], DEFAULT_OPACITY);
end;

procedure TFmxCanvasHelper.Line(A, B: TPointF; AColor: TAlphaColor;
  AThickness: Single);
begin
  Stroke.Color := AColor;
  Stroke.Kind := TBrushKind.Solid;
  Stroke.Thickness := AThickness;
  DrawLine(A, B, DEFAULT_OPACITY);
end;

procedure TFmxCanvasHelper.SolidCircle(A: TPointF; R: Double;
  AColor: TAlphaColor);
begin
  var ARect := RectF(A.X-R, A.Y-R, A.X+R, A.Y+R);
  Fill.Color := AColor;
  Fill.Kind := TBrushKind.Solid;
  FillEllipse(ARect, DEFAULT_OPACITY);
end;

end.
