unit DropTarget_Form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ExtCtrls,
  FMX.Memo.Types, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Menus;

type
  TFormDrop = class(TForm)
    DropTarget1: TDropTarget;
    Memo1: TMemo;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    procedure DropTarget1Dropped(Sender: TObject; const Data: TDragObject;
      const Point: TPointF);
    procedure MenuItem2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDrop: TFormDrop;

implementation

{$R *.fmx}

procedure TFormDrop.DropTarget1Dropped(Sender: TObject; const Data: TDragObject;
  const Point: TPointF);
begin
  for var AFile in Data.Files do
    Memo1.Lines.Add (AFile);
end;

procedure TFormDrop.MenuItem2Click(Sender: TObject);
begin
  ShowMessage ('This is DropTarget');
end;

end.
