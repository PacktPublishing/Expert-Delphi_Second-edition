unit uDMToDoEMS;

interface

uses
  System.SysUtils, System.Classes, uToDoTypes, IPPeerClient,
  REST.Backend.ServiceTypes, System.JSON, REST.Backend.EMSServices, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Backend.EndPoint,
  REST.Backend.EMSProvider;

type
  TDMToDoEMS = class(TDataModule, IToDoData)
    EMSProvider1: TEMSProvider;
    BeToDoList: TBackendEndpoint;
    RrespToDo: TRESTResponse;
    BeToDoRead: TBackendEndpoint;
    BeToDoCreate: TBackendEndpoint;
    BeToDoUpdate: TBackendEndpoint;
    BeToDoDelete: TBackendEndpoint;
  private
    { Private declarations }
  public
    // IToDoData
    function ToDoCreate(AValue: TToDo): Integer;
    function ToDoRead(Id: Integer; out AValue: TToDo): Boolean;
    function ToDoUpdate(AValue: TToDo): Boolean;
    function ToDoDelete(Id: Integer): Boolean;
    procedure ToDoList(AList: TToDos);
  end;

var
  DMToDoEMS: TDMToDoEMS;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses
  uToDoUtils, REST.Types;

{$R *.dfm}

{ TDMToDoWebBrokREST }

function TDMToDoEMS.ToDoCreate(AValue: TToDo): Integer;
begin
  Result := 0; // no response expected from POST request
  var StrStr := TStringStream.Create(ToDoToStr(AValue), TEncoding.UTF8);
  try
    BeToDoCreate.Params.Clear;
    BeToDoCreate.AddBody(StrStr, TRESTContentType.ctAPPLICATION_JSON);
    BeToDoCreate.Execute;
  finally
    StrStr.Free;
  end;
end;

function TDMToDoEMS.ToDoRead(Id: Integer; out AValue: TToDo): Boolean;
begin
  BeToDoRead.ResourceSuffix := Id.ToString;
  BeToDoRead.Execute;
  Result := RrespToDo.Content <> 'Failed';
  if Result then
    AValue := StrToToDo(RrespToDo.Content);
end;

function TDMToDoEMS.ToDoUpdate(AValue: TToDo): Boolean;
begin
  Result := True; // no response expected from PUT request

  var StrStr := TStringStream.Create(ToDoToStr(AValue), TEncoding.UTF8);
  try
    BeToDoUpdate.Params.Clear;
    BeToDoUpdate.AddBody(StrStr, TRESTContentType.ctAPPLICATION_JSON);
    BeToDoUpdate.Execute;
  finally
    StrStr.Free;
  end;
end;

function TDMToDoEMS.ToDoDelete(Id: Integer): Boolean;
begin
  BeToDoDelete.ResourceSuffix := Id.ToString;
  BeToDoDelete.Execute;
  Result := True;
end;

procedure TDMToDoEMS.ToDoList(AList: TToDos);
begin
  AList.Clear;
  BeToDoList.Execute;
  StrToToDos(RrespToDo.Content, AList);
end;

end.
