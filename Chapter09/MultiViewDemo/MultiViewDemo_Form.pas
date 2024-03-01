unit MultiViewDemo_Form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.StdCtrls, FMX.ScrollBox, FMX.Grid,
  FMX.Controls.Presentation, FMX.MultiView, FMX.ListBox, FMX.Layouts;

type
  TMViewForm = class(TForm)
    MultiView1: TMultiView;
    SpeedButton1: TSpeedButton;
    StringGrid1: TStringGrid;
    ComboMode: TComboBox;
    BtnDrawer: TSpeedButton;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    StringColumn4: TStringColumn;
    StringColumn5: TStringColumn;
    Layout1: TLayout;
    Label1: TLabel;
    Layout2: TLayout;
    Label2: TLabel;
    SpeedButton2: TSpeedButton;
    procedure ComboModeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MViewForm: TMViewForm;

implementation

{$R *.fmx}

// TMultiViewMode = (PlatformBehaviour, Panel, Popover, Drawer, Custom, NavigationPane);

procedure TMViewForm.ComboModeChange(Sender: TObject);
begin
  if ComboMode.ItemIndex >= 0 then
    MultiView1.Mode := TMultiViewMode(ComboMode.ItemIndex);

  Caption := 'MultiViewDemo (' + ComboMode.Items [ComboMode.ItemIndex] + ')';
end;

procedure TMViewForm.FormCreate(Sender: TObject);
begin
   MultiView1.Mode := TMultiViewMode.PlatformBehaviour;
   ComboMode.ItemIndex := 0;

   for var J := 0 to StringGrid1.ColumnCount - 1 do
     StringGrid1.Columns[J].Header := 'Col ' + (J+1).ToString;

   for var I := 0 to StringGrid1.RowCount - 1 do
     for var J := 0 to StringGrid1.ColumnCount - 1 do
     begin
       StringGrid1.Cells[J, I] := Format ('%d, %d', [I+1, J+1]);
     end;

end;

procedure TMViewForm.SpeedButton1Click(Sender: TObject);
begin
  StringGrid1.RowCount := StringGrid1.RowCount + 1;
  var I := StringGrid1.RowCount - 1;
  for var J := 0 to StringGrid1.ColumnCount -1 do
  begin
    StringGrid1.Cells[J, I] := Format ('%d, %d', [I+1, J+1]);
  end;
end;

procedure TMViewForm.SpeedButton2Click(Sender: TObject);
begin
  ShowMessage ('This is the ' + Caption + ' Project');
end;

end.
