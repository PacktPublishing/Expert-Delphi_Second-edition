unit uFormPhotoTake;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.StdCtrls, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.MediaLibrary.Actions, FMX.Controls.Presentation, IPPeerClient,
  IPPeerServer, System.Tether.Manager, System.Tether.AppProfile;

type
  TFormPhotoTake = class(TForm)
    ToolBar1: TToolBar;
    ActionList1: TActionList;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    ImagePhoto: TImage;
    SpdbtnSendPhoto: TSpeedButton;
    TetherMng1: TTetheringManager;
    TetherProf1: TTetheringAppProfile;
    ActSendPhoto: TAction;
    SpdbtnTakePhoto: TSpeedButton;
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
    procedure ActSendPhotoExecute(Sender: TObject);
    procedure TetherMng1EndManagersDiscovery(const Sender: TObject;
      const ARemoteManagers: TTetheringManagerInfoList);
    procedure TetherMng1EndProfilesDiscovery(const Sender: TObject;
      const ARemoteProfiles: TTetheringProfileInfoList);
    procedure TetherMng1RequestManagerPassword(const Sender: TObject;
      const ARemoteIdentifier: string; var Password: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPhotoTake: TFormPhotoTake;

implementation

{$R *.fmx}

procedure TFormPhotoTake.TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
begin
  ImagePhoto.Bitmap.Assign(Image);
end;

procedure TFormPhotoTake.ActSendPhotoExecute(Sender: TObject);
begin
  if not ImagePhoto.Bitmap.IsEmpty then
    TetherMng1.DiscoverManagers(1000)
  else
    ShowMessage('Take a photo before sending');
end;

procedure TFormPhotoTake.TetherMng1EndManagersDiscovery(const Sender: TObject;
  const ARemoteManagers: TTetheringManagerInfoList);
begin
  if aRemoteManagers.Count > 0 then
    TetherMng1.PairManager(ARemoteManagers[0])
  else
    ShowMessage('Cannot find any photo receiver app.');
end;

procedure TFormPhotoTake.TetherMng1EndProfilesDiscovery(const Sender: TObject;
  const ARemoteProfiles: TTetheringProfileInfoList);
var
  Memstr: TMemoryStream;
begin
  if ARemoteProfiles.Count > 0 then
  begin
    if not TetherProf1.Connect(ARemoteProfiles[0]) then
      ShowMessage('Failed to connect to remote profile.')
    else
    begin
      Memstr := TMemoryStream.Create;
      try
        ImagePhoto.Bitmap.SaveToStream(Memstr);
        if TetherProf1.SendStream(ARemoteProfiles[0], 'Photo', Memstr) then
          ShowMessage('Image sent')
        else
          ShowMessage('Failed to send image');
      finally
        Memstr.Free;
      end;
    end;
  end
  else
    ShowMessage('Cannot find any remote profiles to connect to.');
end;

procedure TFormPhotoTake.TetherMng1RequestManagerPassword(const Sender: TObject;
  const ARemoteIdentifier: string; var Password: string);
begin
  Password := TetherMng1.Password;
end;

end.
