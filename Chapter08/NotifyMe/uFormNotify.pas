unit uFormNotify;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Notification, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit,
  FMX.EditBox, FMX.NumberBox;

type
  TFormNotify = class(TForm)
    NotificationCenter1: TNotificationCenter;
    ToolBar1: TToolBar;
    LblTitle: TLabel;
    BtnNotify: TButton;
    procedure BtnNotifyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNotify: TFormNotify;

implementation

{$R *.fmx}

procedure TFormNotify.BtnNotifyClick(Sender: TObject);
var
  N: TNotification;
begin
  N := NotificationCenter1.CreateNotification;
  try
    N.Name := 'MY_APP_NOTIFICATION_1';
    N.Title := 'Notify Me App';
    N.AlertBody := 'This is an important notification from Delphi!';
    NotificationCenter1.PresentNotification(N);
  finally
    N.Free;
  end;
end;

end.
