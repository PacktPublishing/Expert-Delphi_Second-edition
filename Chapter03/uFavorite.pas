unit uFavorite;

interface

uses
  System.Generics.Collections;

type
  TFavorite = class
  private
    FCaption: string;
    FURL: string;
    procedure SetCaption(const Value: string);
    procedure SetURL(const Value: string);
  public
     property URL: string read FURL write SetURL;
     property Caption: string read FCaption write SetCaption;
     constructor Create(AURL, ACaption: string); overload;
  end;

  TFavorites = class(TObjectList<TFavorite>);

implementation

uses
  System.Classes, System.SysUtils;

constructor TFavorite.Create(AURL, ACaption: string);
begin
  URL := AURL;
  Caption := ACaption;
end;

procedure TFavorite.SetCaption(const Value: string);
begin
  FCaption := Value;
end;

procedure TFavorite.SetURL(const Value: string);
begin
  FURL := Value;
end;

end.
