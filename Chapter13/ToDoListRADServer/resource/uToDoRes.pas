unit uToDoRes;

// EMS Resource Unit

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes,
  uToDoTypes;

type
  [ResourceName('ToDo')]
  {$METHODINFO ON}
  TToDoResource = class
  private
    FToDoData: IToDoData;
    function GetToDoData: IToDoData;
  published
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    procedure Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    procedure PutItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure DeleteItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;
  {$METHODINFO OFF}

implementation

uses
  uDMToDo, uToDoUtils;

function TToDoResource.GetToDoData: IToDoData;
begin
  if FToDoData = nil then
    FToDoData := TDMToDo.Create(nil);
  Result := FToDoData;
end;

procedure TToDoResource.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
begin
  var AToDos := TToDos.Create;
  try
    GetToDoData.ToDoList(AToDos);
    var RespStr := ToDosToStr(AToDos);
    AResponse.Body.JSONWriter.WriteRaw(RespStr);
  finally
    AToDos.Free;
  end;
end;

procedure TToDoResource.GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  AToDo: TToDo;
  RespStr: string;
begin
  var Id := ARequest.Params.Values['item'].ToInteger;
  if GetToDoData.ToDoRead(Id, AToDo) then
    RespStr := ToDoToStr(AToDo)
  else
    RespStr := 'Failed';
  AResponse.Body.JSONWriter.WriteRaw(RespStr);
end;

procedure TToDoResource.Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  AStream: TStream;
begin
  if not ARequest.Body.TryGetStream(AStream) then
    AResponse.RaiseBadRequest('no data');
  var Bstr := AStream as TBytesStream;
  var RespStr := TEncoding.UTF8.GetString(Bstr.Bytes);
  var AToDo := StrToToDo(RespStr);
  GetToDoData.ToDoCreate(AToDo);
end;

procedure TToDoResource.PutItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  AStream: TStream;
begin
  if not ARequest.Body.TryGetStream(AStream) then
    AResponse.RaiseBadRequest('no data');
  var Bstr := AStream as TBytesStream;
  var RespStr := TEncoding.UTF8.GetString(Bstr.Bytes);
  var AToDo := StrToToDo(RespStr);
  GetToDoData.ToDoUpdate(AToDo);
end;

procedure TToDoResource.DeleteItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
begin
  var Id := ARequest.Params.Values['item'].ToInteger;
  GetToDoData.ToDoDelete(Id);
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TToDoResource));
end;

initialization
  Register;
end.


