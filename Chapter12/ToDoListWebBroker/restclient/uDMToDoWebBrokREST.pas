unit uDMToDoWebBrokREST;

interface

uses
  System.SysUtils, System.Classes, uToDoTypes, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Types;

type
  TDMToDoWebBrokREST = class(TDataModule, IToDoData)
    RClientToDo: TRESTClient;
    RRespToDo: TRESTResponse;
    RReqToDoCreate: TRESTRequest;
    RReqToDoRead: TRESTRequest;
    RReqToDoUpdate: TRESTRequest;
    RReqToDoDelete: TRESTRequest;
    RReqToDoList: TRESTRequest;
  private
    { Private declarations }
  public
    // IToDoData
    function ToDoCreate(AValue: TToDo): Integer;
    function ToDoRead(Id: integer; out AValue: TToDo): Boolean;
    function ToDoUpdate(AValue: TToDo): Boolean;
    function ToDoDelete(Id: integer): Boolean;
    procedure ToDoList(AList: TToDos);
  end;

var
  DMToDoWebBrokREST: TDMToDoWebBrokREST;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses
  uToDoUtils, System.JSON;

{$R *.dfm}

{ TDMToDoWebBrokREST }

function TDMToDoWebBrokREST.ToDoCreate(AValue: TToDo): Integer;
begin
  RReqToDoCreate.Params[0].Value := AValue.Title;
  RReqToDoCreate.Params[1].Value := AValue.Category;
  RReqToDoCreate.Execute;
  Result := RRespToDo.Content.ToInteger;
end;

function TDMToDoWebBrokREST.ToDoRead(Id: integer; out AValue: TToDo): Boolean;
begin
  RReqToDoRead.Params[0].Value := Id.ToString;
  RReqToDoRead.Execute;
  Result := RRespToDo.Content <> 'Failed';
  if Result then
    AValue := StrToToDo(RRespToDo.Content);
end;

function TDMToDoWebBrokREST.ToDoUpdate(AValue: TToDo): Boolean;
begin
  RReqToDoUpdate.Params[0].Value := AValue.Id.ToString;
  RReqToDoUpdate.Params[1].Value := AValue.Title;
  RReqToDoUpdate.Params[2].Value := AValue.Category;
  RReqToDoUpdate.Execute;
  Result := RRespToDo.Content = 'OK';
end;

function TDMToDoWebBrokREST.ToDoDelete(Id: Integer): Boolean;
begin
  RReqToDoDelete.Params[0].Value := Id.ToString;
  RReqToDoDelete.Execute;
  Result := RRespToDo.Content = 'OK';
end;

procedure TDMToDoWebBrokREST.ToDoList(AList: TToDos);
begin
  AList.Clear;
  RReqToDoList.Execute;
  StrToToDos(RRespToDo.Content, AList);
end;

end.
