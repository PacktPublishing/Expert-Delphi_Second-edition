unit uDMGameOfMem;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, FMX.ImgList,
  System.IniFiles, System.IOUtils;

const
  MEM_GAME_CONFIG = 'MemGameConfig.ini';

type
  TDMGameOfMem = class(TDataModule)
    ImageListMain: TImageList;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FIniFile: TIniFile;
  public
    procedure SaveScore(gameTime: TTime; aPairsCount: integer);
    function ReadScore(aPairsCount: integer): TTime;
    procedure ClearAllScores;
    procedure SaveCurrLevel(aPairsCount: integer);
    function ReadCurrLevel: integer;
  end;

var
  DMGameOfMem: TDMGameOfMem;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

const
  StrSCORES = 'SCORES';
  StrLEVEL = 'LEVEL';
  StrSETTINGS = 'SETTINGS';
  StrCURRLEVEL = 'CURR_LEVEL';

procedure TDMGameOfMem.DataModuleCreate(Sender: TObject);
var
  Filename: string;
begin
  Filename := TPath.Combine(TPath.GetDocumentsPath, MEM_GAME_CONFIG);
  FIniFile := TIniFile.Create(Filename);
end;

procedure TDMGameOfMem.DataModuleDestroy(Sender: TObject);
begin
  FIniFile.Free;
end;

procedure TDMGameOfMem.SaveScore(gameTime: TTime; aPairsCount: integer);
var
  T: double;
begin
  T := gameTime;
  FIniFile.WriteFloat(StrSCORES, StrLEVEL + aPairsCount.ToString, T);
  FIniFile.UpdateFile;
end;

function TDMGameOfMem.ReadScore(aPairsCount: integer): TTime;
var
  T: double;
begin
  T := FIniFile.ReadFloat(StrSCORES, StrLEVEL + aPairsCount.ToString, -1);
  Result := T;
end;

procedure TDMGameOfMem.ClearAllScores;
begin
  FIniFile.EraseSection(StrSCORES);
  FIniFile.UpdateFile;
end;

procedure TDMGameOfMem.SaveCurrLevel(aPairsCount: integer);
begin
  FIniFile.WriteInteger(StrSETTINGS, StrCURRLEVEL, aPairsCount);
  FIniFile.UpdateFile;
end;

function TDMGameOfMem.ReadCurrLevel: integer;
begin
  Result := FIniFile.ReadInteger(StrSETTINGS, StrCURRLEVEL, 4);
end;

end.
