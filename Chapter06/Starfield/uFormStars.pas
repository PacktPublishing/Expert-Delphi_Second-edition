unit uFormStars;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Viewport3D,
  System.Math.Vectors, FMX.Types3D, FMX.Controls3D, FMX.Objects3D,
  FMX.MaterialSources;

type
  TFormStars = class(TForm)
    Viewport3D1: TViewport3D;
    Camera1: TCamera;
    Light1: TLight;
    SphereStar: TSphere;
    DummyScene: TDummy;
    LightMaterialSource1: TLightMaterialSource;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    function RandomLocation: TPoint3D;
  public
    { Public declarations }
  end;

var
  FormStars: TFormStars;

implementation

{$R *.fmx}

function TFormStars.RandomLocation: TPoint3D;
const
  MAX_X = 50;
  MAX_Y = 50;
  MAX_Z = 200;
begin
  Result.X := -MAX_X + Random * 2 * MAX_X;
  Result.Y := -MAX_Y + Random * 2 * MAX_Y;
  Result.Z := Random * MAX_Z;
end;

procedure TFormStars.FormCreate(Sender: TObject);
const
  STARS_COUNT = 100;
var
  Star: TProxyObject;
begin
  Randomize;
  for var I := 0 to STARS_COUNT-1 do
  begin
    Star := TProxyObject.Create(DummyScene);
    Star.SourceObject := SphereStar;
    Star.Parent := DummyScene;
    Star.Position.Point := RandomLocation;
  end;
end;

procedure TFormStars.Timer1Timer(Sender: TObject);
const
  DELTA_Z = 2;
var
  Ctrl: TControl3D;
  Obj: TFmxObject;
begin
  for var I := 0 to DummyScene.ChildrenCount-1 do
  begin
    Obj := DummyScene.Children[I];
    if Obj is TControl3D then
    begin
      Ctrl := TControl3D(Obj);
      Ctrl.Position.Z := Ctrl.Position.Z - DELTA_Z;

      if Ctrl.Position.Z < 0 then
        Ctrl.Position.Point := RandomLocation;
    end;
  end;
end;

end.
