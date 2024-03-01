unit uFormFavTextFiles;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Memo.Types;

type
  TFormFavTextFiles = class(TForm)
    ToolBar1: TToolBar;
    SpdbtnBack: TSpeedButton;
    Label1: TLabel;
    BtnWrite: TButton;
    BtnRead: TButton;
    MemoLog: TMemo;
    procedure SpdbtnBackClick(Sender: TObject);
    procedure BtnWriteClick(Sender: TObject);
    procedure BtnReadClick(Sender: TObject);
  private
    function GetFilename: string;
  public
    { Public declarations }
  end;

var
  FormFavTextFiles: TFormFavTextFiles;

implementation

{$R *.fmx}

uses
  uFormFavMain, uFavorite, System.IOUtils;

function TFormFavTextFiles.GetFilename: string;
begin
  Result := TPath.Combine(TPath.GetDocumentsPath, 'favs.txt');
end;

procedure TFormFavTextFiles.BtnWriteClick(Sender: TObject);
var
  SW: TStreamWriter;
  Fav: TFavorite;
  Favs: TFavorites;
begin
  Favs := FormFavMain.Favs;
  SW := TStreamWriter.Create(GetFilename, False, TEncoding.UTF8);
  try
    for Fav in Favs do
    begin
      sw.WriteLine(Fav.URL);
      sw.WriteLine(Fav.Caption);
    end;
  finally
    SW.Free;
  end;
end;

procedure TFormFavTextFiles.BtnReadClick(Sender: TObject);
var
  SR: TStreamReader;
begin
  SR := TStreamReader.Create(GetFilename, TEncoding.UTF8);
  try
    while not SR.EndOfStream do
      MemoLog.Lines.Add(SR.ReadLine);
  finally
    SR.Free;
  end;
end;

procedure TFormFavTextFiles.SpdbtnBackClick(Sender: TObject);
begin
  FormFavMain.Show;
end;

end.
