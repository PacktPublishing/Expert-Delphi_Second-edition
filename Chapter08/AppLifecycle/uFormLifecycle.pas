unit uFormLifecycle;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ScrollBox, FMX.Memo,
  FMX.Platform, FMX.Memo.Types;

type
  TFormLifecycle = class(TForm)
    ToolBar1: TToolBar;
    lblTitle: TLabel;
    SpdbtnClear: TSpeedButton;
    MemoLog: TMemo;
    procedure SpdbtnClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure Log(s: string);
    function HandleAppEvent(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;
  public
    { Public declarations }
  end;

var
  FormLifecycle: TFormLifecycle;

implementation

{$R *.fmx}

procedure TFormLifecycle.Log(S: string);
begin
  MemoLog.Lines.Add(TimeToStr(Now) + ': ' + S);
end;

procedure TFormLifecycle.SpdbtnClearClick(Sender: TObject);
begin
  MemoLog.Lines.Clear;
end;

procedure TFormLifecycle.FormCreate(Sender: TObject);
var
  AFMXApplicationEventService: IFMXApplicationEventService;
begin
  if TPlatformServices.Current.SupportsPlatformService(
    IFMXApplicationEventService, AFMXApplicationEventService) then
      AFMXApplicationEventService.SetApplicationEventHandler(HandleAppEvent)
  else
    Log('Application Event Service is not supported.');
end;

function TFormLifecycle.HandleAppEvent(AAppEvent: TApplicationEvent;
  AContext: TObject): Boolean;
begin
  case AAppEvent of
    TApplicationEvent.FinishedLaunching: Log('App event: Finished Launching');
    TApplicationEvent.BecameActive: Log('App event: Became Active');
    TApplicationEvent.WillBecomeInactive: Log('App event: Will Become Inactive');
    TApplicationEvent.EnteredBackground: Log('App event: Entered Background');
    TApplicationEvent.WillBecomeForeground: Log('App event: Will Become Foreground');
    TApplicationEvent.WillTerminate: Log('App event: Will Terminate');
    TApplicationEvent.LowMemory: Log('App event: Low Memory');
    TApplicationEvent.TimeChange: Log('App event: Time Change');
    TApplicationEvent.OpenURL: Log('App event: Open URL');
  else
    Log('Unknown app event');
  end;
  Result := True;
end;

end.
