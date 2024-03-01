unit uFormVideo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Media, FMX.Objects;

type
  TFormVideo = class(TForm)
    ToolBar1: TToolBar;
    CameraComponent1: TCameraComponent;
    imgVideo: TImage;
    ChkbxCamera: TCheckBox;
    LblTitle: TLabel;
    procedure ChkbxCameraChange(Sender: TObject);
    procedure CameraComponent1SampleBufferReady(Sender: TObject;
      const ATime: TMediaTime);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormVideo: TFormVideo;

implementation

{$R *.fmx}

procedure TFormVideo.CameraComponent1SampleBufferReady(Sender: TObject;
  const ATime: TMediaTime);
begin
  CameraComponent1.SampleBufferToBitmap(imgVideo.Bitmap, True);
end;

procedure TFormVideo.ChkbxCameraChange(Sender: TObject);
begin
  CameraComponent1.Active := chkbxCamera.IsChecked;
end;

end.
