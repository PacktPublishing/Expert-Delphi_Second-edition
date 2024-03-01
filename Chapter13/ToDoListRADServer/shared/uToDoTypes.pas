unit uToDoTypes;

interface

uses
  System.Generics.Collections;

type
  TToDo = record
    Id: Integer;
    Title: string;
    Category: string;
  end;

  TToDos = TList<TToDo>;

  IToDoData = interface
    function ToDoCreate(AValue: TToDo): Integer;
    function ToDoRead(Id: integer; out AValue: TToDo): Boolean;
    function ToDoUpdate(AValue: TToDo): Boolean;
    function ToDoDelete(Id: integer): Boolean;
    procedure ToDoList(AList: TToDos);
  end;

implementation

end.
