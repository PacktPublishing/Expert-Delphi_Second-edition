unit uFormFavMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uFavorite,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFormFavMain = class(TForm)
    ToolBar1: TToolBar;
    LabelTitle: TLabel;
    BtnTextFiles: TButton;
    BtnJSON: TButton;
    BtnXML: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnTextFilesClick(Sender: TObject);
    procedure BtnJSONClick(Sender: TObject);
    procedure BtnXMLClick(Sender: TObject);
  private
    FFavs: TFavorites;
    procedure AddSampleItems(AFavs: TFavorites);
  public
    property Favs: TFavorites read FFavs;
  end;

var
  FormFavMain: TFormFavMain;

implementation

{$R *.fmx}

uses uFormFavTextFiles, uFormFavJSON, uFormFavXML;

procedure TFormFavMain.AddSampleItems(AFavs: TFavorites);
begin
  AFavs.Add(TFavorite.Create(
    'www.embarcadero.com/products/delphi',
    'Delphi Home Page')
  );
  AFavs.Add(TFavorite.Create(
    'docwiki.embarcadero.com/RADStudio/en',
    'RAD Studio online documentation')
  );
end;

procedure TFormFavMain.FormCreate(Sender: TObject);
begin
  FFavs := TFavorites.Create;
  AddSampleItems(Favs);
end;

procedure TFormFavMain.FormDestroy(Sender: TObject);
begin
  FFavs.Free;
end;

procedure TFormFavMain.BtnJSONClick(Sender: TObject);
begin
  FormFavJSON.Show;
end;

procedure TFormFavMain.BtnTextFilesClick(Sender: TObject);
begin
  FormFavTextFiles.Show;
end;

procedure TFormFavMain.BtnXMLClick(Sender: TObject);
begin
  FormFavXML.Show;
end;

end.
