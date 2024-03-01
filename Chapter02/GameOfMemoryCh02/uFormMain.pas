unit uFormMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TFormMain = class(TForm)
    ToolBar1: TToolBar;
    SpdbtnSettings: TSpeedButton;
    procedure SpdbtnSettingsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.fmx}

uses uFormSettings;

procedure TFormMain.SpdbtnSettingsClick(Sender: TObject);
begin
  if FormSettings = nil then
    FormSettings := TFormSettings.Create(Application);

  FormSettings.Show;
end;

end.
