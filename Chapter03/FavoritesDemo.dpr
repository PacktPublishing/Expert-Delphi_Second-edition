program FavoritesDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  favs in 'favs.pas',
  uFavorite in 'uFavorite.pas',
  uFormFavJSON in 'uFormFavJSON.pas' {FormFavJSON},
  uFormFavMain in 'uFormFavMain.pas' {FormFavMain},
  uFormFavTextFiles in 'uFormFavTextFiles.pas' {FormFavTextFiles},
  uFormFavXML in 'uFormFavXML.pas' {FormFavXML};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormFavMain, FormFavMain);
  Application.CreateForm(TFormFavJSON, FormFavJSON);
  Application.CreateForm(TFormFavTextFiles, FormFavTextFiles);
  Application.CreateForm(TFormFavXML, FormFavXML);
  Application.Run;
end.
