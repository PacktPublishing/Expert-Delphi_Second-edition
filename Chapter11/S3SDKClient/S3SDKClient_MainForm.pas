unit S3SDKClient_MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox, AWS.S3,
  FMX.ExtCtrls, FMX.Objects;

type
  TFormS3 = class(TForm)
    ListBox1: TListBox;
    ToolBar1: TToolBar;
    EdBucketName: TEdit;
    BtnList: TButton;
    Image1: TImage;
    procedure BtnListClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
  private
    FS3Client: IS3Client;
    LResponse: IS3ListObjectsV2Response;
  public
    { Public declarations }
  end;

var
  FormS3: TFormS3;

implementation

{$R *.fmx}

procedure TFormS3.BtnListClick(Sender: TObject);
var
  LRequest: IS3ListObjectsV2Request;
begin
  LRequest := TS3ListObjectsV2Request.Create(EdBucketName.Text);
  LResponse := FS3Client.ListObjectsV2(LRequest);
  if LResponse.IsSuccessful then
    for var Item in LResponse.Contents do
      ListBox1.Items.Add (Item.Key + ' (' +
        Item.ContentType + ')');
end;

procedure TFormS3.FormCreate(Sender: TObject);
begin
  var LOptions := TS3Options.Create;
  LOptions.Region := 'us-east-1';
  FS3Client := TS3Client.Create (LOptions);
end;

procedure TFormS3.ListBox1DblClick(Sender: TObject);
begin
  var Item := LResponse.Contents[ListBox1.ItemIndex];
  Item.DownloadFile(Item.Key);
  Image1.Bitmap.LoadFromFile(Item.Key);
end;

end.
