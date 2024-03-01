unit uFormToDoEMS;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uToDoTypes,
  FMX.TabControl, System.Actions, FMX.ActnList, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Edit;

type
  TFormToDoEMS = class(TForm)
    TbctrlMain: TTabControl;
    tbiList: TTabItem;
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
    lblTitle: TLabel;
    EdtCategory: TEdit;
    lblCategory: TLabel;
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
  FormToDoEMS: TFormToDoEMS;

implementation

{$R *.fmx}

uses uDMToDoEMS;

{ TFormToDo }

function TFormToDoEMS.GetToDoData: IToDoData;
begin
  if DMToDoEMS = nil then
    DMToDoEMS := TDMToDoEMS.Create(Application);
  Result := DMToDoEMS;
end;

procedure TFormToDoEMS.ActAddExecute(Sender: TObject);
begin
  FCurrentId := -1;
  EdtTitle.Text := '';
  EdtCategory.Text := '';
  CtaEdit.ExecuteTarget(self);
end;

procedure TFormToDoEMS.ActDeleteExecute(Sender: TObject);
begin
  if FCurrentId > 0 then
  begin
    GetToDoData.ToDoDelete(FCurrentId);
    RefreshList;
  end;
  if TbctrlMain.ActiveTab <> TbiList then
    CtaList.ExecuteTarget(self);
end;

procedure TFormToDoEMS.ActSaveExecute(Sender: TObject);
var
  ATodo: TToDo;
begin
  ATodo.Title := EdtTitle.Text;
  ATodo.Category := EdtCategory.Text;
  if FCurrentId < 0 then
    GetToDoData.ToDoCreate(ATodo)
  else
  begin
    ATodo.Id := FCurrentId;
    GetToDoData.ToDoUpdate(ATodo);
  end;
  RefreshList;
  CtaList.ExecuteTarget(self);
end;

procedure TFormToDoEMS.FormCreate(Sender: TObject);
begin
  FToDos := TToDos.Create;
  TbctrlMain.ActiveTab := TbiList;
  RefreshList;
end;

procedure TFormToDoEMS.FormDestroy(Sender: TObject);
begin
  FToDos.Free;
end;

procedure TFormToDoEMS.LstvwToDosDeleteItem(Sender: TObject; AIndex: Integer);
begin
  FCurrentId := FToDos[AIndex].Id;
  ActDelete.Execute;
end;

procedure TFormToDoEMS.LstvwToDosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  ATodo: TToDo;
begin
  FCurrentId := AItem.Tag;
  GetToDoData.ToDoRead(FCurrentId, ATodo);
  EdtTitle.Text := ATodo.Title;
  EdtCategory.Text := ATodo.Category;
  CtaEdit.ExecuteTarget(self);
end;

procedure TFormToDoEMS.RefreshList;
begin
  GetToDoData.ToDoList(FToDos);
  LstvwToDos.BeginUpdate;
  try
    LstvwToDos.Items.Clear;
    for var ATodo in FToDos do
    begin
      var Item := lstvwToDos.Items.Add;
      Item.Tag := ATodo.Id;
      Item.Objects.FindObjectT<TListItemText>('Title').Text := ATodo.Title;
      Item.Objects.FindObjectT<TListItemText>('Category').Text := ATodo.Category;
    end;
  finally
    LstvwToDos.EndUpdate;
  end;
end;

end.
