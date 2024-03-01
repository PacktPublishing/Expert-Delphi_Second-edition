unit uFormHTTP;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  FMX.ScrollBox, FMX.Memo, FMX.Edit, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Memo.Types;

type
  TFormHTTP = class(TForm)
    NetHTTPClient1: TNetHTTPClient;
    ToolBar1: TToolBar;
    SpdbtnDownload: TSpeedButton;
    EdtURL: TEdit;
    MemoData: TMemo;
    procedure SpdbtnDownloadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormHTTP: TFormHTTP;

implementation

{$R *.fmx}

procedure TFormHTTP.SpdbtnDownloadClick(Sender: TObject);
var
  Memstr: TMemoryStream;
  Resp: IHTTPResponse;
begin
  Memstr := TMemoryStream.Create;
  try
    Resp := NetHTTPClient1.Get(EdtURL.Text, Memstr);
    if Resp.StatusCode = 200 then
      MemoData.Lines.LoadFromStream(Memstr)
    else
      ShowMessage(Resp.StatusCode.ToString + ': ' + Resp.StatusText);
  finally
    Memstr.Free;
  end;
end;

end.
