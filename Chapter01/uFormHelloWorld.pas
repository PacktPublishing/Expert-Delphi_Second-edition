unit uFormHelloWorld;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFormHelloWorld = class(TForm)
    BtnHelloWorld: TButton;
    procedure BtnHelloWorldClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormHelloWorld: TFormHelloWorld;

implementation

{$R *.fmx}

procedure TFormHelloWorld.BtnHelloWorldClick(Sender: TObject);
begin
  ShowMessage ('Delphi Hello World');
end;

end.
