unit uFormToDo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uToDoTypes,
  FMX.TabControl, System.Actions, FMX.ActnList, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Edit;

type
  TFormToDo = class(TForm)
    TbctrlMain: TTabControl;
    TbiList: TTabItem;
    TbiEdit: TTabItem;
    ActionList1: TActionList;
    CtaList: TChangeTabAction;
    CtaEdit: TChangeTabAction;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    LstvwToDos: TListView;
    SpdbtnAdd: TSpeedButton;
    LblToDoList: TLabel;
    ActAdd: TAction;
    ActDelete: TAction;
    SpdbtnBack: TSpeedButton;
    LblToDoEdit: TLabel;
    EdtTitle: TEdit;
    LblTitle: TLabel;
    EdtCategory: TEdit;
    LblCategory: TLabel;
    ActSave: TAction;
    SpdbtnSave: TSpeedButton;
    SpdbtnDelete: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ActAddExecute(Sender: TObject);
    procedure ActSaveExecute(Sender: TObject);
    procedure ActDeleteExecute(Sender: TObject);
    procedure LstvwToDosDeleteItem(Sender: TObject; AIndex: Integer);
    procedure LstvwToDosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    FCurrentId: integer;
    FToDos: TToDos;
    function GetToDoData: IToDoData;
    procedure RefreshList;
  public
    { Public declarations }
  end;

var
  FormToDo: TFormToDo;

implementation

{$R *.fmx}

uses uDMToDo;

{ TFormToDo }

procedure TFormToDo.ActAddExecute(Sender: TObject);
begin
  FCurrentId := -1;
  EdtTitle.Text := '';
  EdtCategory.Text := '';
  CtaEdit.ExecuteTarget(self);
end;

procedure TFormToDo.ActDeleteExecute(Sender: TObject);
begin
  if FCurrentId > 0 then
  begin
    GetToDoData.ToDoDelete(FCurrentId);
    RefreshList;
  end;
  if TbctrlMain.ActiveTab <> TbiList then
    CtaList.ExecuteTarget(self);
end;

procedure TFormToDo.ActSaveExecute(Sender: TObject);
var
  Todo: TToDo;
begin
  Todo.Title := EdtTitle.Text;
  Todo.Category := EdtCategory.Text;
  if FCurrentId < 0 then
    GetToDoData.ToDoCreate(Todo)
  else
  begin
    Todo.Id := FCurrentId;
    GetToDoData.ToDoUpdate(Todo);
  end;
  RefreshList;
  CtaList.ExecuteTarget(self);
end;

procedure TFormToDo.FormCreate(Sender: TObject);
begin
  FToDos := TToDos.Create;
  TbctrlMain.ActiveTab := TbiList;
  RefreshList;
end;

procedure TFormToDo.FormDestroy(Sender: TObject);
begin
  FToDos.Free;
end;

function TFormToDo.GetToDoData: IToDoData;
begin
  Result := DMToDo;
end;

procedure TFormToDo.LstvwToDosDeleteItem(Sender: TObject; AIndex: Integer);
begin
  FCurrentId := FToDos[AIndex].Id;
  ActDelete.Execute;
end;

procedure TFormToDo.LstvwToDosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  Todo: TToDo;
begin
  FCurrentId := AItem.Tag;
  GetToDoData.ToDoRead(FCurrentId, Todo);
  EdtTitle.Text := Todo.Title;
  EdtCategory.Text := Todo.Category;
  CtaEdit.ExecuteTarget(self);
end;

procedure TFormToDo.RefreshList;
begin
  GetToDoData.ToDoList(FToDos);
  LstvwToDos.BeginUpdate;
  try
    LstvwToDos.Items.Clear;
    for var Todo in FToDos do
    begin
      var Item := LstvwToDos.Items.Add;
      Item.Tag := Todo.Id;
      Item.Objects.FindObjectT<TListItemText>('Title').Text := Todo.Title;
      Item.Objects.FindObjectT<TListItemText>('Category').Text := Todo.Category;
    end;
  finally
    LstvwToDos.EndUpdate;
  end;
end;

end.
