unit uForm1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    BtnForLoopRegular: TButton;
    ToolBar1: TToolBar;
    Label1: TLabel;
    BtnForLoopParallel: TButton;
    BtnNonResponsive: TButton;
    BtnResponsive1: TButton;
    BtnFuture1: TButton;
    BtnResponsive2: TButton;
    BtnFuture2: TButton;
    procedure BtnForLoopRegularClick(Sender: TObject);
    procedure BtnForLoopParallelClick(Sender: TObject);
    procedure BtnNonResponsiveClick(Sender: TObject);
    procedure BtnResponsive1Click(Sender: TObject);
    procedure BtnResponsive2Click(Sender: TObject);
    procedure BtnFuture2Click(Sender: TObject);
    procedure BtnFuture1Click(Sender: TObject);
  private
    function DoTimeConsumingOperation(Length: integer): Double;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  System.Math,
  System.Threading, // Parallel Programming Library
  System.Diagnostics; // TStopwatch

function TForm1.DoTimeConsumingOperation(Length: integer): Double;
begin
  var Tot := 1.0;
  for var I := 1 to 10_000 * Length do
     // some random slow math operation
     Tot := Log2(Tot) + Sqrt(I);
  Result := Tot;
end;

procedure TForm1.BtnForLoopRegularClick(Sender: TObject);
var
  SW: TStopwatch;
begin
  SW := TStopwatch.StartNew;
  for var I := 0 to 99 do
    DoTimeConsumingOperation(10);
  SW.Stop;
  (Sender as TButton).Text := SW.ElapsedMilliseconds.ToString + 'ms';
end;

procedure TForm1.BtnForLoopParallelClick(Sender: TObject);
var
  SW: TStopwatch;
begin
  SW := TStopwatch.StartNew;
  TParallel.For(0, 99, procedure(I: integer)
  begin
    DoTimeConsumingOperation(10);
  end);
  SW.Stop;
  (Sender as TButton).Text := SW.ElapsedMilliseconds.ToString + 'ms';
end;

procedure TForm1.BtnNonResponsiveClick(Sender: TObject);
begin
  DoTimeConsumingOperation(3_000);
  (Sender as TButton).Text := 'Done';
end;

procedure TForm1.BtnResponsive1Click(Sender: TObject);
var
  ATask: ITask;
begin
  ATask := TTask.Create(procedure
  begin
    DoTimeConsumingOperation(3_000);
  end);
  ATask.Start;
  (Sender as TButton).Text := 'Done';
end;

procedure TForm1.BtnResponsive2Click(Sender: TObject);
var
  ATask: ITask;
begin
  ATask := TTask.Create(procedure
  begin
    DoTimeConsumingOperation(3_000);
    TThread.Synchronize(nil,
      procedure
      begin
       (Sender as TButton).Text := 'Done';
      end);
  end);
  ATask.Start;
end;

procedure TForm1.BtnFuture1Click(Sender: TObject);
var
  First, Second, Third: Double;
  SW: TStopwatch;
begin
  SW := TStopwatch.StartNew;

  First := DoTimeConsumingOperation(200);
  Second := DoTimeConsumingOperation(300);
  Third := DoTimeConsumingOperation(400);

  var GrantTootal := First + Second + Third;

  SW.Stop;
  (Sender as TButton).Text := GrantTootal.ToString
    + ' (' +  SW.ElapsedMilliseconds.ToString + 'ms)';
end;

procedure TForm1.BtnFuture2Click(Sender: TObject);
var
  First, Second, Third: IFuture<Double>;
  SW: TStopwatch;
begin
  SW := TStopwatch.StartNew;

  First := TTask.Future<Double>(function: Double
  begin
    Result := DoTimeConsumingOperation(200);
  end);

  Second := TTask.Future<Double>(function: Double
  begin
    Result := DoTimeConsumingOperation(300);
  end);

  Third := TTask.Future<Double>(function: Double
  begin
    Result := DoTimeConsumingOperation(400);
  end);

  var GrantTotal: Double :=
    First.Value + Second.Value + Third.Value;

  SW.Stop;
  (Sender as TButton).Text := GrantTotal.ToString
    + ' (' +  SW.ElapsedMilliseconds.ToString + 'ms)';
end;


end.
