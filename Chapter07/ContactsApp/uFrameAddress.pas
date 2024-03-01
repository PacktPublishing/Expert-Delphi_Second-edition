unit uFrameAddress;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit;

type
  TFrameAddress = class(TFrame)
    EdtStreet: TEdit;
    LblStreet: TLabel;
    EdtStreetNr: TEdit;
    LblStreetNr: TLabel;
    EdtCity: TEdit;
    LblCity: TLabel;
    LblAddressTitle: TLabel;
    EdtCountry: TEdit;
    LblCountry: TLabel;
    EdtZipCode: TEdit;
    LblZipCode: TLabel;
  private
    procedure SetCity(const Value: string);
    procedure SetCountry(const Value: string);
    procedure SetStreet(const Value: string);
    procedure SetStreetNr(const Value: string);
    function GetCity: string;
    function GetCountry: string;
    function GetStreet: string;
    function GetStreetNr: string;
    procedure SetZipCode(const Value: string);
    function GetZipCode: string;
    { Private declarations }
  public
    property Street: string read GetStreet write SetStreet;
    property StreetNr: string read GetStreetNr write SetStreetNr;
    property ZipCode: string read GetZipCode write SetZipCode;
    property City: string read GetCity write SetCity;
    property Country: string read GetCountry write SetCountry;
  end;

implementation

{$R *.fmx}

{ TFrameAddress }

function TFrameAddress.GetCity: string;
begin
  Result := EdtCity.Text;
end;

function TFrameAddress.GetCountry: string;
begin
  Result := EdtCountry.Text;
end;

function TFrameAddress.GetStreet: string;
begin
  Result := EdtStreet.Text;
end;

function TFrameAddress.GetStreetNr: string;
begin
  Result := EdtStreetNr.Text;
end;

function TFrameAddress.GetZipCode: string;
begin
  Result := EdtZipCode.Text;
end;

procedure TFrameAddress.SetCity(const Value: string);
begin
  EdtCity.Text := Value;
end;

procedure TFrameAddress.SetCountry(const Value: string);
begin
  EdtCountry.Text := Value;
end;

procedure TFrameAddress.SetStreet(const Value: string);
begin
  EdtStreet.Text := Value;
end;

procedure TFrameAddress.SetStreetNr(const Value: string);
begin
  EdtStreetNr.Text := Value;
end;

procedure TFrameAddress.SetZipCode(const Value: string);
begin
  EdtZipCode.Text := Value;
end;

end.
