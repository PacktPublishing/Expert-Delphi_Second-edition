unit NumbersAppForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.StdCtrls, FMX.Edit, FMX.EditBox, FMX.NumberBox, FMX.ScrollBox, FMX.Memo,
  FMX.Controls.Presentation;

type
  TFormNumbers = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    NumberBox1: TNumberBox;
    BtnConvert: TButton;
    procedure BtnConvertClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNumbers: TFormNumbers;

implementation

{$R *.fmx}

uses NumberConversion;

procedure TFormNumbers.BtnConvertClick(Sender: TObject);
begin
  var SNumber := GetNumberConversionSoapType.NumberToWords(
    Trunc(NumberBox1.Value));
  Memo1.Text := SNumber;
end;

end.
