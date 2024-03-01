unit uThreadForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TFormThread = class(TForm)
    BtnStartThread: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure BtnStartThreadClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ShowMin (AMin: Integer);
    procedure ShowMax (AMax: Integer);
  end;

var
  FormThread: TFormThread;

implementation

{$R *.fmx}

uses
  uThreadClass;

{ TForm23 }

procedure TFormThread.BtnStartThreadClick(Sender: TObject);
begin
  var AThread := TMyThread.Create;
  AThread.FreeOnTerminate := True;
  AThread.Start;
end;

procedure TFormThread.ShowMax(AMax: Integer);
begin
  Label2.Text := 'Max: ' + AMax.ToString;
end;

procedure TFormThread.ShowMin(AMin: Integer);
begin
  Label1.Text := 'Min: ' + AMin.ToString;
end;

end.
