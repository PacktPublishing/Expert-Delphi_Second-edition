unit uDMToDo;

interface

uses
  System.SysUtils, System.Classes, uToDoTypes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI, FireDAC.FMXUI.Wait,
  FireDAC.Phys.SQLiteWrapper.Stat;

type
  TDMToDo = class(TDataModule, IToDoData)
    FdconnToDos: TFDConnection;
    FdqToDoInsert: TFDQuery;
    FdqToDoSelect: TFDQuery;
    FdqToDoUpdate: TFDQuery;
    FdqToDoDelete: TFDQuery;
    FdqToDoSelectAll: TFDQuery;
    FdqToDoMaxId: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure FdconnToDosBeforeConnect(Sender: TObject);
    procedure FdconnToDosAfterConnect(Sender: TObject);
  private
    function IsMobilePlatform: Boolean;
    function GetNewId: Integer;
  public
    // IToDoData
    function ToDoCreate(AValue: TToDo): Integer;
    function ToDoRead(Id: integer; out AValue: TToDo): Boolean;
    function ToDoUpdate(AValue: TToDo): Boolean;
    function ToDoDelete(Id: integer): Boolean;
    procedure ToDoList(AList: TToDos);
  end;

var
  DMToDo: TDMToDo;

implementation

uses
  System.IOUtils;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

function TDMToDo.IsMobilePlatform: boolean;
begin
  Result := (TOSVersion.Platform = pfiOS) or (TOSVersion.Platform = pfAndroid);
end;

procedure TDMToDo.FdconnToDosBeforeConnect(Sender: TObject);
begin
  if IsMobilePlatform then
    FdconnToDos.Params.Values['Database'] :=
      TPath.Combine(TPath.GetDocumentsPath, 'ToDos.db')
end;

procedure TDMToDo.FdconnToDosAfterConnect(Sender: TObject);
const
  SCreateTableSQL = 'CREATE TABLE IF NOT EXISTS ToDos ('
   + 'Id INTEGER NOT NULL PRIMARY KEY,'
   + 'Title TEXT, Category TEXT)';
begin
  if IsMobilePlatform then
    fdconnToDos.ExecSQL(SCreateTableSQL);
end;

function TDMToDo.GetNewId: Integer;
begin
  FdqToDoMaxId.Open;
  try
    var Fld := FdqToDoMaxId.FieldByName('MaxId');
    if Fld.IsNull then
      Result := 1
    else
      Result := Fld.AsInteger + 1;
  finally
    FdqToDoMaxId.Close;
  end;
end;

function TDMToDo.ToDoCreate(AValue: TToDo): Integer;
begin
  var Id := GetNewId;
  FdqToDoInsert.ParamByName('Id').AsInteger := Id;
  FdqToDoInsert.ParamByName('Title').AsString := AValue.Title;;
  FdqToDoInsert.ParamByName('Category').AsString := AValue.Category;
  try
    FdqToDoInsert.ExecSQL;
    Result := Id;
  except
    Result := -1;
  end;
end;

function TDMToDo.ToDoRead(Id: integer; out AValue: TToDo): Boolean;
begin
  FdqToDoSelect.ParamByName('Id').AsInteger := Id;
  FdqToDoSelect.Open;
  try
    if FdqToDoSelect.RecordCount > 0 then
    begin
      Result := True;
      AValue.Id := Id;
      AValue.Title := FdqToDoSelect.FieldByName('Title').AsString;
      AValue.Category := FdqToDoSelect.FieldByName('Category').AsString;
    end
    else
      Result := False;
  finally
    FdqToDoSelect.Close;
  end;
end;

function TDMToDo.ToDoUpdate(AValue: TToDo): Boolean;
begin
  FdqToDoUpdate.ParamByName('Id').AsInteger := AValue.Id;
  FdqToDoUpdate.ParamByName('Title').AsString := AValue.Title;;
  FdqToDoUpdate.ParamByName('Category').AsString := AValue.Category;
  try
    FdqToDoUpdate.ExecSQL;
    Result := True;
  except
    Result := False;
  end;
end;

function TDMToDo.ToDoDelete(Id: integer): Boolean;
begin
  FdqToDoDelete.ParamByName('Id').AsInteger := Id;
  try
    FdqToDoDelete.ExecSQL;
    Result := True;
  except
    Result := False;
  end;
end;

procedure TDMToDo.ToDoList(AList: TToDos);
var
  Item: TToDo;
begin
  if AList <> nil then
  begin
    AList.Clear;
    FdqToDoSelectAll.Open;
    try
      while not FdqToDoSelectAll.Eof do
      begin
        Item.Id := FdqToDoSelectAll.FieldByName('Id').AsInteger;
        Item.Title := FdqToDoSelectAll.FieldByName('Title').AsString;
        Item.Category := FdqToDoSelectAll.FieldByName('Category').AsString;
        AList.Add(Item);
        FdqToDoSelectAll.Next;
      end;
    finally
      FdqToDoSelectAll.Close;
    end;
  end;
end;

end.
