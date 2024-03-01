unit uFormPhotoDisplay;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Controls.Presentation, IPPeerClient, IPPeerServer,
  System.Tether.Manager, System.Tether.AppProfile;

type
  TFormPhotoDisplay = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    ImageDisplay: TImage;
    TetherMng1: TTetheringManager;
    TetherProf1: TTetheringAppProfile;
    procedure TetherMng1RequestManagerPassword(const Sender: TObject;
      const ARemoteIdentifier: string; var Password: string);
    procedure TetherProf1ResourceReceived(const Sender: TObject;
      const AResource: TRemoteResource);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPhotoDisplay: TFormPhotoDisplay;

implementation

{$R *.fmx}

procedure TFormPhotoDisplay.TetherProf1ResourceReceived(
  const Sender: TObject; const AResource: TRemoteResource);
begin
  ImageDisplay.Bitmap.LoadFromStream(AResource.Value.AsStream);
end;

procedure TFormPhotoDisplay.TetherMng1RequestManagerPassword(
  const Sender: TObject; const ARemoteIdentifier: string; var Password: string);
begin
  Password := TetherMng1.Password;
end;

end.
