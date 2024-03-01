unit uFormFavJSON;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  System.JSON, System.JSON.Readers, uFavorite, FMX.Memo.Types;

type
  TFormFavJSON = class(TForm)
    ToolBar1: TToolBar;
    SpdbtnBack: TSpeedButton;
    Label1: TLabel;
    BtnWriteDOM: TButton;
    BtnReadText: TButton;
    BtnReadDOM: TButton;
    BtnWriteWriter: TButton;
    BtnWriteBuilder: TButton;
    MemoLog: TMemo;
    BtnReadReader: TButton;
    procedure BtnWriteDOMClick(Sender: TObject);
    procedure SpdbtnBackClick(Sender: TObject);
    procedure BtnReadDOMClick(Sender: TObject);
    procedure BtnReadTextClick(Sender: TObject);
    procedure BtnWriteWriterClick(Sender: TObject);
    procedure BtnWriteBuilderClick(Sender: TObject);
    procedure BtnReadReaderClick(Sender: TObject);
  private
    function GetFilename: string;
    function FavListToJsonTextWithDOM: string;
    function FavListToJsonTextWithWriter: string;
    function FavListToJsonTextWithBuilder: string;
    function ReadJsonTextFromFile: string;
    procedure WriteJsonTextToFile(Txt: string);
    procedure ProcessFavObj(Favs: TFavorites; FavObj: TJSONObject);
    procedure DisplayFavsCount(Favs: TFavorites);
    procedure ProcessFavRead(Favs: TFavorites; Jtr: TJsonTextReader);
  public
    { Public declarations }
  end;

var
  FormFavJSON: TFormFavJSON;

implementation

{$R *.fmx}

uses
  System.IOUtils, uFormFavMain, System.JSON.Writers, System.JSON.Types, System.JSON.Builders,
  System.Generics.Collections;

function TFormFavJSON.FavListToJsonTextWithDOM: string;
var
  Fav: TFavorite; Favs: TFavorites;
  ObjFavs, ObjF: TJSONObject; ArrFavs: TJSONArray;

begin
  Favs := FormFavMain.Favs;

  ObjFavs := TJSONObject.Create;
  try
    ArrFavs := TJSONArray.Create;

    for Fav in Favs do
    begin
      ObjF := TJSONObject.Create;
      ObjF.AddPair('URL', TJSONString.Create(Fav.URL));
      ObjF.AddPair('Caption', TJSONString.Create(Fav.Caption));
      ArrFavs.Add(ObjF);
    end;
    ObjFavs.AddPair('Favorites', ArrFavs);

    Result := ObjFavs.ToString;
  finally
    ObjFavs.Free;
  end;
end;

function TFormFavJSON.FavListToJsonTextWithWriter: string;
var
  Fav: TFavorite; Favs: TFavorites;
  StringWriter: TStringWriter;
  Writer: TJsonTextWriter;
begin
  Favs := FormFavMain.Favs;

  StringWriter := TStringWriter.Create();
  Writer := TJsonTextWriter.Create(StringWriter);
  try
    Writer.Formatting := TJsonFormatting.Indented;

    Writer.WriteStartObject;
    Writer.WritePropertyName('Favorites');
    Writer.WriteStartArray;

    for Fav in Favs do
    begin
      Writer.WriteStartObject;
      Writer.WritePropertyName('URL');
      Writer.WriteValue(Fav.URL);
      Writer.WritePropertyName('Caption');
      Writer.WriteValue(Fav.Caption);
      Writer.WriteEndObject;
    end;

    Writer.WriteEndArray;
    Writer.WriteEndObject;

    Result := StringWriter.ToString;

  finally
    Writer.Free;
    StringWriter.Free;
  end;
end;

function TFormFavJSON.FavListToJsonTextWithBuilder: string;
var
  StringWriter: TStringWriter;
  Writer: TJsonTextWriter;
  Builder: TJSONObjectBuilder;
begin
  StringWriter := TStringWriter.Create();
  Writer := TJsonTextWriter.Create(StringWriter);
  Builder := TJSONObjectBuilder.Create(Writer);
  try
    Writer.Formatting := TJsonFormatting.Indented;

    Builder
    .BeginObject
      .BeginArray('Favorites')
        .BeginObject
          .Add('URL', 'www.embarcadero.com/products/delphi')
          .Add('Caption', 'Delphi Home Page')
        .EndObject
        .BeginObject
          .Add('URL', 'docwiki.embarcadero.com/RADStudio/en')
          .Add('Caption', 'RAD Studio online documentation')
        .EndObject
      .EndArray
    .EndObject;

    Result := StringWriter.ToString;

  finally
    Builder.Free;
    Writer.Free;
    StringWriter.Free;
  end;
end;

function TFormFavJSON.GetFilename: string;
begin
  Result := TPath.Combine(TPath.GetDocumentsPath, 'favs.json');
end;

procedure TFormFavJSON.WriteJsonTextToFile(txt: string);
var sw: TStreamWriter;
begin
  Sw := TStreamWriter.Create(GetFilename, False, TEncoding.UTF8);
  try
    Sw.WriteLine(txt);
  finally
    Sw.Free;
  end;
end;

procedure TFormFavJSON.BtnWriteDOMClick(Sender: TObject);
var
  S: string;
begin
  S := FavListToJsonTextWithDOM;
  WriteJsonTextToFile(S);
end;

procedure TFormFavJSON.BtnWriteWriterClick(Sender: TObject);
var
  S: string;
begin
  S := FavListToJsonTextWithWriter;
  WriteJsonTextToFile(S);
end;

procedure TFormFavJSON.BtnWriteBuilderClick(Sender: TObject);
var
  S: string;
begin
  S := FavListToJsonTextWithBuilder;
  WriteJsonTextToFile(S);
end;

function TFormFavJSON.ReadJsonTextFromFile: string;
var
  Sr: TStreamReader;
begin
  Sr := TStreamReader.Create(GetFilename, TEncoding.UTF8);
  try
    Result := Sr.ReadToEnd;
  finally
    Sr.Free;
  end;
end;

procedure TFormFavJSON.BtnReadTextClick(Sender: TObject);
var
  Sr: TStreamReader;
begin
  Sr := TStreamReader.Create(GetFilename, TEncoding.UTF8);
  try
    while not sr.EndOfStream do
      MemoLog.Lines.Add(Sr.ReadLine);
  finally
    Sr.Free;
  end;
end;

procedure TFormFavJSON.BtnReadDOMClick(Sender: TObject);
var
  Favs: TFavorites; ValRoot: TJSONValue; ObjRoot: TJSONObject;
  ValFavs: TJSONValue; ArrFavs: TJSONArray; I: integer;
begin
  Favs := TFavorites.Create;
  try
    ValRoot := TJSONObject.ParseJSONValue(ReadJsonTextFromFile);
    if ValRoot <> nil then
    begin
      if ValRoot is TJSONObject then
      begin
        ObjRoot := TJSONObject(ValRoot);
        if ObjRoot.Count > 0 then
        begin
          ValFavs := ObjRoot.Values['Favorites'];
          if ValFavs <> nil then
          begin
            if ValFavs is TJSONArray then
            begin
              ArrFavs := TJSONArray(ValFavs);
              for I := 0 to ArrFavs.Count-1 do
              begin
                if ArrFavs.Items[I] is TJSONObject then
                  ProcessFavObj(Favs, TJSONObject(ArrFavs.Items[I]));
              end;
            end;
          end;
        end;
      end;
    end;

    DisplayFavsCount(Favs);
  finally
    Favs.Free;
  end;
end;

procedure TFormFavJSON.ProcessFavObj(Favs: TFavorites; FavObj: TJSONObject);
var
  Dav: TFavorite; Val: TJSONValue;
begin
  Dav := TFavorite.Create;

  Val := FavObj.Values['URL'];
  if Val <> nil then
    if Val is TJSONString then
      Dav.URL := TJSONString(Val).Value;

  Val := FavObj.Values['Caption'];
  if Val <> nil then
    if Val is TJSONString then
      Dav.Caption := TJSONString(Val).Value;

  Favs.Add(Dav);
end;

procedure TFormFavJSON.BtnReadReaderClick(Sender: TObject);
var jtr: TJsonTextReader; sr: TStringReader; favs: TFavorites;
begin
  favs := TFavorites.Create;
  try
    sr := TStringReader.Create(ReadJsonTextFromFile);
    try
      jtr := TJsonTextReader.Create(sr);
      try
        while jtr.Read do
        begin
          if jtr.TokenType = TJsonToken.StartObject then
            ProcessFavRead(favs, jtr);
        end;
      finally
        jtr.Free;
      end;
    finally
      sr.Free;
    end;

    DisplayFavsCount(favs);
  finally
    favs.Free;
  end;
end;

procedure TFormFavJSON.ProcessFavRead(Favs: TFavorites; Jtr: TJsonTextReader);
var
  Fav: TFavorite;
begin
  Fav := TFavorite.Create;

  while Jtr.Read do
  begin
    if Jtr.TokenType = TJsonToken.PropertyName then
    begin
      if Jtr.Value.ToString = 'URL' then
      begin
        Jtr.Read;
        Fav.URL := Jtr.Value.AsString;
      end

      else if Jtr.Value.ToString = 'Caption' then
      begin
        Jtr.Read;
        Fav.Caption := Jtr.Value.AsString;
      end
    end

    else if Jtr.TokenType = TJsonToken.EndObject then
    begin
      Favs.add(Fav);
      exit;
    end;
  end;
end;


procedure TFormFavJSON.DisplayFavsCount(Favs: TFavorites);
begin
  if Favs <> nil then
    ShowMessage('Favorites count: ' + Favs.Count.ToString)
  else
    ShowMessage('Favorites reference is nil');
end;

procedure TFormFavJSON.SpdbtnBackClick(Sender: TObject);
begin
  FormFavMain.Show;
end;

end.
