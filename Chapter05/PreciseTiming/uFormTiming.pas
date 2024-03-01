unit uFormTiming;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Memo.Types;

type
  TFormTiming = class(TForm)
    Timer1: TTimer;
    ToolBar1: TToolBar;
    LabelTitle: TLabel;
    Panel1: TPanel;
    btnStart: TButton;
    btnStop: TButton;
    btnClear: TButton;
    MemoLog: TMemo;
    procedure Timer1Timer(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FLastTime: double;
    procedure Log(S: string);
    function GetRawReferenceTime: double;
  public
    { Public declarations }
  end;

var
  FormTiming: TFormTiming;

implementation

uses
  System.Diagnostics;

{$R *.fmx}


procedure TFormTiming.btnClearClick(Sender: TObject);
begin
  MemoLog.Lines.Clear;
end;

procedure TFormTiming.btnStartClick(Sender: TObject);
begin
  Timer1.Enabled := True;
end;

procedure TFormTiming.btnStopClick(Sender: TObject);
begin
  Timer1.Enabled := False;
end;

procedure TFormTiming.Log(S: string);
begin
  MemoLog.Lines.Add(S);
end;

procedure TFormTiming.FormCreate(Sender: TObject);
begin
  TStopwatch.StartNew;
  Log('Stopwatch Frequency = ' + TStopwatch.Frequency.ToString);
end;

function TFormTiming.GetRawReferenceTime: double;
begin
  Result := TStopwatch.GetTimeStamp / TStopwatch.Frequency;
end;

procedure TFormTiming.Timer1Timer(Sender: TObject);
begin
  var T := GetRawReferenceTime;
  var Elapsed := T - FLastTime;
  FLastTime := T;
  Log('t=' + T.ToString + '   elapsed=' + Elapsed.ToString);
end;

end.
