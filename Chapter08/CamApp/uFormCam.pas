unit uFormCam;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Actions, FMX.ActnList,
  FMX.StdActns, FMX.MediaLibrary.Actions;

type
  TFormCam = class(TForm)
    ToolBar1: TToolBar;
    ImagePhoto: TImage;
    SpdbtnTakePhoto: TSpeedButton;
    ActionList1: TActionList;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    SpdbtnSharePhoto: TSpeedButton;
    ShowShareSheetAction1: TShowShareSheetAction;
    LblTitle: TLabel;
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
    procedure ShowShareSheetAction1BeforeExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCam: TFormCam;

implementation

{$R *.fmx}

uses
  System.Permissions;

procedure TFormCam.ShowShareSheetAction1BeforeExecute(Sender: TObject);
begin
  ShowShareSheetAction1.Bitmap.Assign(ImagePhoto.Bitmap);
end;

procedure TFormCam.FormCreate(Sender: TObject);
const
  PermissionCamera = 'android.permission.CAMERA';
  PermissionExtStorage = 'android.permission.WRITE_EXTERNAL_STORAGE';
begin
{$IFDEF ANDROID}
  PermissionsService.RequestPermissions([PermissionCamera, PermissionExtStorage],
    procedure(const APermissions: TClassicStringDynArray;
      const AGrantResults: TClassicPermissionStatusDynArray)
    begin
      if (Length(AGrantResults) = 2) and
          (AGrantResults[0] = TPermissionStatus.Granted) and
          (AGrantResults[1] = TPermissionStatus.Granted) then
        TakePhotoFromCameraAction1.Enabled := True
      else
        TakePhotoFromCameraAction1.Enabled := False;
    end);
{$ENDIF}
end;

procedure TFormCam.TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
begin
  ImagePhoto.Bitmap.Assign(Image);
end;

end.
