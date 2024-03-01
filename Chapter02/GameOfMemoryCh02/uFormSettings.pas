unit uFormSettings;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TFormSettings = class(TForm)
    ToolBar1: TToolBar;
    SpdbtnBack: TSpeedButton;
    procedure SpdbtnBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSettings: TFormSettings;

implementation

{$R *.fmx}

uses
  uFormMain;

procedure TFormSettings.SpdbtnBackClick(Sender: TObject);
begin
  FormMain.Show;
end;

end.
