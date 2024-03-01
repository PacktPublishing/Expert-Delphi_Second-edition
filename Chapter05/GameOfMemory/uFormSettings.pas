unit uFormSettings;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox;

type
  TFormSettings = class(TForm)
    ToolBar1: TToolBar;
    spdbtnBack: TSpeedButton;
    Label1: TLabel;
    btnClear: TButton;
    lstbxTopScores: TListBox;
    lbi04: TListBoxItem;
    lbi06: TListBoxItem;
    lbi08: TListBoxItem;
    lbi10: TListBoxItem;
    lbi12: TListBoxItem;
    lbi14: TListBoxItem;
    lbi16: TListBoxItem;
    lbi18: TListBoxItem;
    procedure spdbtnBackClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
  public
    procedure ReadTopScores;
  end;

var
  FormSettings: TFormSettings;

implementation

{$R *.fmx}

uses
  uFormMain, uDMGameOfMem, uGameUtils;

procedure TFormSettings.btnClearClick(Sender: TObject);
begin
  DMGameOfMem.ClearAllScores;
  ReadTopScores;
end;

procedure TFormSettings.ReadTopScores;

procedure ShowScore(Lbi: TListBoxItem; Level: integer);
begin
  var T: TTime := DMGameOfMem.ReadScore(Level);
  if T > 0 then
    Lbi.ItemData.Detail := GameTimeToStr(T)
  else
    Lbi.ItemData.Detail := '';
end;

begin
  ShowScore(lbi04, 4);
  ShowScore(lbi06, 6);
  ShowScore(lbi08, 8);
  ShowScore(lbi10, 10);
  ShowScore(lbi12, 12);
  ShowScore(lbi14, 14);
  ShowScore(lbi16, 16);
  ShowScore(lbi18, 18);
end;

procedure TFormSettings.spdbtnBackClick(Sender: TObject);
begin
  FormMain.Show;
end;

end.
