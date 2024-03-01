unit uFormDSClient;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFormDSClient = class(TForm)
    BtnReverse: TButton;
    EdtTest: TEdit;
    procedure BtnReverseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDSClient: TFormDSClient;

implementation

{$R *.fmx}

uses ClientModuleUnit1;

procedure TFormDSClient.BtnReverseClick(Sender: TObject);
begin
  EdtTest.Text :=
    ClientModule1.ServerMethods3Client.ReverseString(EdtTest.Text);
end;

end.
