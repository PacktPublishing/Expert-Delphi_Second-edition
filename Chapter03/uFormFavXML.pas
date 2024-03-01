unit uFormFavXML;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation,
  Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, Xml.omnixmldom,
  uFavorite;

type
  TFormFavXML = class(TForm)
    ToolBar1: TToolBar;
    SpdbtnBack: TSpeedButton;
    Label1: TLabel;
    BtnWrite: TButton;
    XMLDocument1: TXMLDocument;
    BtnRead: TButton;
    procedure SpdbtnBackClick(Sender: TObject);
    procedure BtnWriteClick(Sender: TObject);
    procedure BtnReadClick(Sender: TObject);
  private
    function GetFilename: string;
    procedure DisplayFavsCount(Favs: TFavorites);
  public
    { Public declarations }
  end;

var
  FormFavXML: TFormFavXML;

implementation

{$R *.fmx}

uses uFormFavMain, System.IOUtils, favs;

function TFormFavXML.GetFilename: string;
begin
  Result := TPath.Combine(TPath.GetDocumentsPath, 'favs.xml');
end;

procedure TFormFavXML.BtnReadClick(Sender: TObject);
var
  Favs: TFavorites;
  Fav: TFavorite;
  FavsXML: IXMLFavoritesType;
  I: integer;
begin
  Favs := TFavorites.Create;
  try
    FavsXML := LoadFavorites(GetFilename);
    for I := 0 to FavsXML.Count-1 do
    begin
      Fav := TFavorite.Create;
      Fav.URL := FavsXML[I].URL;
      Fav.Caption := FavsXML[I].Caption;
      Favs.Add(Fav);
    end;

    DisplayFavsCount(Favs);

  finally
    Favs.Free;
  end;
end;

procedure TFormFavXML.BtnWriteClick(Sender: TObject);
var
  Favs: TFavorites;
  Fav: TFavorite;
  FavsXML: IXMLFavoritesType;
  FavXML: IXMLFavoriteType;
begin
  Favs := FormFavMain.Favs;

  FavsXML := NewFavorites;
  for Fav in Favs do
  begin
    FavXML := FavsXML.Add;
    FavXML.URL := Fav.URL;
    FavXML.Caption := Fav.Caption;
  end;

  XMLDocument1.LoadFromXML(FavsXML.XML);
  XMLDocument1.SaveToFile(GetFilename);
end;

procedure TFormFavXML.DisplayFavsCount(Favs: TFavorites);
begin
  if Favs <> nil then
    ShowMessage('Favorites count: ' + Favs.Count.ToString)
  else
    ShowMessage('Favorites reference is nil');
end;

procedure TFormFavXML.SpdbtnBackClick(Sender: TObject);
begin
  FormFavMain.Show;
end;

end.
