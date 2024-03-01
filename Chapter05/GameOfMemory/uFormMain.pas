unit uFormMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.ImgList, FMX.ListBox;

type
  TFormMain = class(TForm)
    ToolBar1: TToolBar;
    SpdbtnSettings: TSpeedButton;
    GrdltTiles: TGridLayout;
    SpdbtnPlay: TSpeedButton;
    LblScore: TLabel;
    CmbbxLevel: TComboBox;
    TimerGame: TTimer;
    procedure SpdbtnSettingsClick(Sender: TObject);
    procedure TimerGameTimer(Sender: TObject);
    procedure SpdbtnPlayClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CmbbxLevelChange(Sender: TObject);
  private
    FPairsLeft: Integer;
    FVisibleGlyph: TGlyph;
    FTimeStart: TTime;
    procedure OnGlyphClick(Sender: TObject);
    procedure GameStart;
    procedure GameEnd;
    procedure DisplayGameTime(T: TTime);
    procedure AdjustTileSize;
    procedure SetCurrPairsCount(const Value: Integer);
    function GetCurrPairsCount: Integer;
    property CurrPairsCount: Integer
      read GetCurrPairsCount write SetCurrPairsCount;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.fmx}

uses uFormSettings, uDMGameOfMem, uGameUtils;

const
  TILE_MARGIN = 2;

procedure TFormMain.AdjustTileSize;
const
  ADJUST_FACTOR = 0.9;
begin
  // adjust the size of every tile in the grid
  var TileArea := GrdltTiles.Width * GrdltTiles.Height / CurrPairsCount / 2;
  var TileSize := (sqrt(TileArea) - 2 * TILE_MARGIN) * ADJUST_FACTOR;
  GrdltTiles.ItemHeight := TileSize;
  GrdltTiles.ItemWidth := TileSize;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Randomize;
  CurrPairsCount := DMGameOfMem.ReadCurrLevel;
end;

procedure TFormMain.CmbbxLevelChange(Sender: TObject);
begin
  DMGameOfMem.SaveCurrLevel(CurrPairsCount);
end;

procedure TFormMain.FormResize(Sender: TObject);
begin
  AdjustTileSize;
end;

function TFormMain.GetCurrPairsCount: integer;
begin
  Result := 4 + CmbbxLevel.ItemIndex * 2;
end;

procedure TFormMain.SetCurrPairsCount(const Value: integer);
begin
  CmbbxLevel.ItemIndex := (Value - 4) div 2;
end;

procedure TFormMain.GameStart;
const
  SHUFFLE_TIMES = 10;
var
  Indices: array of integer;
begin
  // remove all glyphs from the grid,
  // if there are any left
 GrdltTiles.DeleteChildren;

  var PairsCount := CurrPairsCount;
  var TilesCount := PairsCount * 2;

  FVisibleGlyph := nil;
  FPairsLeft := PairsCount;

  // initialize the list of indices
  SetLength(Indices, TilesCount);
  for var I := 0 to PairsCount-1 do
  begin
    Indices[I] := I;
    Indices[I + PairsCount] := I;
  end;

  // randomize indices list
  for var I := 0 to SHUFFLE_TIMES - 1 do
    for var J := 0 to TilesCount - 1 do
    begin
      var K := Random(TilesCount);
      var Temp := Indices[K];
      Indices[K] := Indices[J];
      Indices[J] := Temp;
    end;

  // add "2" to every index
  // because "0" and "1" are special
  for var I := 0 to TilesCount-1 do
    Indices[I] := Indices[I] + 2;

  for var I := 0 to TilesCount-1 do
  begin
    var G  := TGlyph.Create(GrdltTiles);
    g.Parent := GrdltTiles;
    g.Images := DMGameOfMem.ImageListMain;
    g.ImageIndex := 1; // hidden tile
    g.Tag := indices[i]; // image index
    g.HitTest := True;
    g.OnClick := OnGlyphClick;
    G.Margins.Top := TILE_MARGIN;
    g.Margins.Left := TILE_MARGIN;
    g.Margins.Bottom := TILE_MARGIN;
    g.Margins.Right := TILE_MARGIN;
  end;

  AdjustTileSize;

  FTimeStart := Now;
  TimerGame.Enabled := True;

  SpdbtnPlay.StyleLookup := 'stoptoolbutton';
  CmbbxLevel.Enabled := False;
end;

procedure TFormMain.OnGlyphClick(Sender: TObject);
begin
  if Sender is TGlyph then
  begin
    var G := TGlyph(Sender);

    if G.ImageIndex > 0 then // it is not a "removed" tile
    begin
      // if clicked on currently visible tile, do nothing
      if G <> FVisibleGlyph then
      begin
        G.ImageIndex := G.Tag; // show touched tile

        if FVisibleGlyph <> nil then // there is one other visible tile
        begin
          // there is match, remove both tiles
          if G.Tag = FVisibleGlyph.Tag then
          begin
            G.ImageIndex := 0;
            FVisibleGlyph.ImageIndex := 0;
            FVisibleGlyph := nil;

            Dec(FPairsLeft);
            if FPairsLeft = 0 then
              GameEnd;
          end
          else // there is no match, hide previously visible tile
          begin
            FVisibleGlyph.ImageIndex := 1;
            FVisibleGlyph := G;
          end;

        end
        else
          FVisibleGlyph := G; // there is no other visible tile, make this current

      end;
    end;
  end;
end;

procedure TFormMain.GameEnd;
var
  BestTime: TTime;
  S: string;
begin
  TimerGame.Enabled := False;
  var GameTime := Now - FTimeStart;
  DisplayGameTime(GameTime);
  SpdbtnPlay.StyleLookup := 'playtoolbutton';
  CmbbxLevel.Enabled := True;

  if FPairsLeft = 0 then // game was completed
  begin
    BestTime := DMGameOfMem.ReadScore(CurrPairsCount);
    if (BestTime > 0) and (GameTime > BestTime) then
      S := 'GAME FINISHED!' + sLineBreak + 'Your time: ' + GameTimeToStr(GameTime)
    else
    begin
      S := 'YOU WON! BEST TIME!' + sLineBreak + 'New best time: ' + GameTimeToStr(GameTime);
      DMGameOfMem.SaveScore(GameTime, CurrPairsCount);
    end;
    ShowMessage(S);
  end;
end;

procedure TFormMain.SpdbtnPlayClick(Sender: TObject);
begin
  if not TimerGame.Enabled then
    GameStart
  else
    GameEnd;
end;

procedure TFormMain.SpdbtnSettingsClick(Sender: TObject);
begin
  if FormSettings = nil then
    FormSettings := TFormSettings.Create(Application);

  FormSettings.ReadTopScores;
  FormSettings.Show;
end;

procedure TFormMain.TimerGameTimer(Sender: TObject);
begin
  var Delta := Now - FTimeStart;
  DisplayGameTime(Delta);
end;

procedure TFormMain.DisplayGameTime(T: TTime);
begin
  var S := GameTimeToStr(T);
  lblScore.Text := S;
end;

end.
