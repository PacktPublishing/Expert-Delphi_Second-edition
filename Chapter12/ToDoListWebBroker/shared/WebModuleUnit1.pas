unit WebModuleUnit1;

interface

uses System.SysUtils, System.Classes, Web.HTTPApp,
  uToDoTypes;

type
  TWebModule1 = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1ActToDoCreateAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1ActToDoReadAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1ActToDoUpdateAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1ActToDoDeleteAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1ActToDoListAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  private
    FToDoData: IToDoData;
    function GetToDoData: IToDoData;
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

uses
  uDMToDo, uToDoUtils;

{$R *.dfm}

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content :=
    '<html>' +
    '<head><title>To-Do REST API</title></head>' +
    '<body>Delphi "To-Do List" REST API</body>' +
    '</html>';
end;

function TWebModule1.GetToDoData: IToDoData;
begin
  if FToDoData = nil then
    FToDoData := TDMToDo.Create(nil);
  Result := FToDoData;
end;

procedure TWebModule1.WebModule1ActToDoCreateAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  AToDo: TToDo;
begin
  AToDo.Title := Request.QueryFields.Values['title'];
  AToDo.Category := Request.QueryFields.Values['category'];
  var Id := GetToDoData.ToDoCreate(AToDo);
  Response.Content := Id.ToString;
end;

procedure TWebModule1.WebModule1ActToDoReadAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  AToDo: TToDo;
begin
  var Id := Request.QueryFields.Values['id'].ToInteger;
  if GetToDoData.ToDoRead(Id, AToDo) then
    Response.Content := ToDoToStr(AToDo)
  else
    Response.Content := 'Failed';
  Response.ContentType := 'application/json';
end;

procedure TWebModule1.WebModule1ActToDoUpdateAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  AToDo: TToDo;
begin
  AToDo.Id := Request.QueryFields.Values['id'].ToInteger;
  AToDo.Title := Request.QueryFields.Values['title'];
  AToDo.Category := Request.QueryFields.Values['category'];
  if GetToDoData.ToDoUpdate(AToDo) then
    Response.Content := 'OK'
  else
    Response.Content := 'Failed';
end;

procedure TWebModule1.WebModule1ActToDoDeleteAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  AToDo: TToDo;
begin
  var Id := Request.QueryFields.Values['id'].ToInteger;
  if GetToDoData.ToDoDelete(Id) then
    Response.Content := 'OK'
  else
    Response.Content := 'Failed';
end;

procedure TWebModule1.WebModule1ActToDoListAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  AJson: string;
begin
  var AList := TToDos.Create;
  try
    GetToDoData.ToDoList(AList);
    Response.Content := ToDosToStr(AList);
    Response.ContentType := 'application/json';
  finally
    AList.Free;
  end;
end;

end.
