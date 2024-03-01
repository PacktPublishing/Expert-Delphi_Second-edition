unit uWireframe;

interface

uses
  System.Math.Vectors, // TPoin3D
  System.Generics.Collections, // TList<T>
  FMX.Controls3D, // TControl3D
  System.UITypes, // TAlphaColor
  System.Classes, // TComponent
  FMX.Types3D; // TContext3D

type
  TPoints3D = class(TList<TPoint3D>);

  TEdge = record
    A, B: Integer;
  end;

  TEdges = class(TList<TEdge>)
    procedure AddEdge(PStart, PEnd: Integer);
  end;

  TWireframe = class(TControl3D)
  private
    FDrawColor: TAlphaColor;
    FEdges: TEdges;
    FPoints3D: TPoints3D;
    FDisplayed: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Render; override;
    property DrawColor: TAlphaColor read FDrawColor write FDrawColor;
    property Points3D: TPoints3D read FPoints3D;
    property Edges: TEdges read FEdges;
    property Displayed: Boolean read FDisplayed write FDisplayed;
  end;

implementation

constructor TWireframe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPoints3D := TPoints3D.Create;
  FEdges := TEdges.Create;
  FDrawColor := TAlphaColorRec.Red;
  FDisplayed := True;
end;

destructor TWireframe.Destroy;
begin
  FEdges.Free;
  FPoints3D.Free;
  inherited;
end;

procedure TWireframe.Render;
begin
  if Displayed then
    for var Edge in Edges do
      Context.DrawLine(Points3D[Edge.A], Points3D[Edge.B], 1, DrawColor);
end;

{ TEdges }

procedure TEdges.AddEdge(PStart, PEnd: Integer);
var
  Edge: TEdge;
begin
  Edge.A := PStart;
  Edge.B := PEnd;
  Add(Edge);
end;

end.
