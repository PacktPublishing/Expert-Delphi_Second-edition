unit uToDoUtils;

interface

uses
  uToDoTypes;

function ToDosToStr(AList: TToDos): string;
procedure StrToToDos(S: string; AList: TToDos);
function ToDoToStr(AToDo: TToDo): string;
function StrToToDo(S: string): TToDo;

implementation

uses
  System.SysUtils, System.Classes, System.JSON.Types,
  System.JSON.Writers, System.JSON.Readers;

procedure WriteItem(AnItem: TToDo; AJw: TJSONWriter);
begin
  AJw.WritePropertyName('ID');
  AJw.WriteValue(AnItem.Id.ToString);
  AJw.WritePropertyName('Title');
  AJw.WriteValue(AnItem.Title);
  AJw.WritePropertyName('Category');
  AJw.WriteValue(AnItem.Category);
end;

function ToDosToStr(AList: TToDos): string;
var
  ASw: TStringWriter;
  AJtw: TJsonTextWriter;
begin
  ASw := TStringWriter.Create();
  AJtw := TJsonTextWriter.Create(ASw);
  try
    AJtw.WriteStartArray;

    for var AnItem in AList do
    begin
      AJtw.WriteStartObject;
      WriteItem(AnItem, AJtw);
      AJtw.WriteEndObject;
    end;

    AJtw.WriteEndArray;
    Result := ASw.ToString;
  finally
    AJtw.Free;
    ASw.Free;
  end;
end;

function ReadStr(AJtr: TJSONReader): string;
begin
  AJtr.Read;
  AJtr.Read;
  Result := AJtr.Value.AsString;
end;

procedure ReadItem(AList: TToDos; AJtr: TJSONReader);
var
  ATodo: TToDo;
begin
  ATodo.Id := StrToInt(ReadStr(AJtr));
  ATodo.Title := ReadStr(AJtr);
  ATodo.Category := ReadStr(AJtr);
  AList.Add(ATodo);
end;

procedure StrToToDos(S: string; AList: TToDos);
var
  AJtr: TJsonTextReader;
  ASr: TStringReader;
begin
  ASr := TStringReader.Create(S);
  try
    AJtr := TJsonTextReader.Create(ASr);
    try
      while AJtr.Read do
        if AJtr.TokenType = TJsonToken.StartObject then
          ReadItem(AList, AJtr);
    finally
      AJtr.Free;
    end;
  finally
    ASr.Free;
  end;
end;

function ToDoToStr(AToDo: TToDo): string;
var
  ASw: TStringWriter;
  AJtw: TJsonTextWriter;
begin
  ASw := TStringWriter.Create;
  AJtw := TJsonTextWriter.Create(ASw);
  try
    AJtw.WriteStartObject;
    WriteItem(AToDo, AJtw);
    AJtw.WriteEndObject;

    Result := ASw.ToString;
  finally
    AJtw.Free;
    ASw.Free;
  end;
end;

function StrToToDo(S: string): TToDo;
begin
  var ASr := TStringReader.Create(S);
  try
    var AJtr := TJsonTextReader.Create(ASr);
    try
      while AJtr.Read do
        if AJtr.TokenType = TJsonToken.StartObject then
        begin
          Result.Id := StrToInt(ReadStr(AJtr));
          Result.Title := ReadStr(AJtr);
          Result.Category := ReadStr(AJtr);
        end;
    finally
      AJtr.Free;
    end;
  finally
    ASr.Free;
  end;
end;

end.
