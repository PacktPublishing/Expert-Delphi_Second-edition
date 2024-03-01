unit uDMToDo;

interface

uses
  System.SysUtils, System.Classes, uToDoTypes,
  Data.Cloud.CloudAPI, Data.Cloud.AzureAPI;

type
  TDMToDo = class(TDataModule, IToDoData)
    AzureConnectionInfo1: TAzureConnectionInfo;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    TableService: TAzureTableService;
    MaxId: Integer;
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
  System.IOUtils, System.IniFiles, Generics.Collections;

const
  tablename = 'todolist';
  XML_ROWKEY = 'RowKey';
  XML_PARTITION = 'PartitionKey';

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDMToDo.DataModuleCreate(Sender: TObject);
var
  IniFile: TMemIniFile;
begin
  var IniFilename := GetHomePath + PathDelim + 'azure.ini';
  if not FileExists (IniFilename) then
    raise Exception.Create('Missing Azure configuration');
  IniFile := TMemIniFile.Create(IniFilename);
  try
    AzureConnectionInfo1.AccountName :=
      IniFile.ReadString('azure', 'AccountName', '');
    AzureConnectionInfo1.AccountKey :=
      IniFile.ReadString('azure', 'AccountKey', '');
  finally
    FreeAndNil (IniFile);
  end;

  TableService := TAzureTableService.Create(AzureConnectionInfo1);
  MaxId := 0;
end;

procedure TDMToDo.DataModuleDestroy(Sender: TObject);
begin
  TableService.Free;
end;

function TDMToDo.GetNewId: Integer;
begin
  Inc (MaxId);
  Result := MaxId;
end;

function TDMToDo.ToDoCreate(AValue: TToDo): Integer;
begin
  var Id := GetNewId;
  var RowObj := TCloudTableRow.Create;
  var ResponseInfo := TCloudResponseInfo.Create;
  try
    RowObj.SetColumn (XML_ROWKEY, Id.ToString);
    RowObj.SetColumn (XML_PARTITION, Id.ToString);
    RowObj.SetColumn('title',  AValue.Title);
    RowObj.SetColumn('category',  AValue.Category);
    TableService.InsertEntity(tablename, RowObj, ResponseInfo);
    if ResponseInfo.StatusCode = 200 then
      Result := Id
    else
      Result := -1;
  finally
    RowObj.Free;
    ResponseInfo.Free;
  end;
end;

function TDMToDo.ToDoRead(Id: Integer; out AValue: TToDo): Boolean;
begin
  var ResponseInfo := TCloudResponseInfo.Create;
  var RowObj := TableService.QueryEntity(tablename, Id.ToString, Id.ToString, ResponseInfo);
  try
    if ResponseInfo.StatusCode = 200 then
    begin
      AValue.Title := RowObj.GetColumn('title').Value;
      AValue.Category := RowObj.GetColumn('category').Value;
      Result := True;
    end
    else
      Result := False;
  finally
    ResponseInfo.Free;
    RowObj.Free;
  end;
end;

function TDMToDo.ToDoUpdate(AValue: TToDo): Boolean;
begin
  var RowObj := TCloudTableRow.Create;
  var ResponseInfo := TCloudResponseInfo.Create;
  try
    RowObj.SetColumn (XML_ROWKEY, AValue.Id.ToString);
    RowObj.SetColumn (XML_PARTITION, AValue.Id.ToString);
    RowObj.SetColumn ('title', AValue.Title);
    RowObj.SetColumn ('category', AValue.Category);
    TableService.UpdateEntity(tablename, RowObj, ResponseInfo);
    Result := ResponseInfo.StatusCode = 200;
  finally
    RowObj.Free;
    ResponseInfo.Free;
  end;
end;

function TDMToDo.ToDoDelete(Id: integer): Boolean;
begin
  var RowObj := TCloudTableRow.Create;
  var ResponseInfo := TCloudResponseInfo.Create;
  try
    RowObj.SetColumn (XML_ROWKEY, Id.ToString);
    RowObj.SetColumn (XML_PARTITION, Id.ToString);
    TableService.DeleteEntity(tablename, RowObj, ResponseInfo);
    Result := ResponseInfo.StatusCode = 200;
  finally
    RowObj.Free;
    ResponseInfo.Free;
  end;
end;

procedure TDMToDo.ToDoList(AList: TToDos);
var
  Item: TToDo;
  RowsList: TList<TCloudTableRow>;
begin
  if AList <> nil then
  begin
    AList.Clear;
    RowsList := TableService.QueryEntities(tablename);
    try
      for var RowObj in RowsList do
      begin
        Item.Id := RowObj.GetColumn(XML_ROWKEY).Value.ToInteger;
        Item.Title := RowObj.GetColumn('title').Value;
        Item.Category := RowObj.GetColumn('category').Value;
        AList.Add(Item);
        if Item.Id > MaxId then
          MaxId := Item.Id;
        RowObj.Free; // work around memory leak
      end;
    finally
      RowsList.Free;
    end;
  end;
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.
