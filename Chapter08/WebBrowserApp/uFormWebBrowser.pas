unit uFormWebBrowser;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.WebBrowser;

type
  TFormWebBrowser = class(TForm)
    ToolBar1: TToolBar;
    EdtURL: TEdit;
    SpdbtnGo: TSpeedButton;
    SpdbtnBack: TSpeedButton;
    SpdbtnForward: TSpeedButton;
    WebBrowser1: TWebBrowser;
    procedure SpdbtnGoClick(Sender: TObject);
    procedure SpdbtnBackClick(Sender: TObject);
    procedure SpdbtnForwardClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormWebBrowser: TFormWebBrowser;

implementation

{$R *.fmx}

procedure TFormWebBrowser.SpdbtnBackClick(Sender: TObject);
begin
  WebBrowser1.GoBack;
end;

procedure TFormWebBrowser.SpdbtnForwardClick(Sender: TObject);
begin
  WebBrowser1.GoForward;
end;

procedure TFormWebBrowser.SpdbtnGoClick(Sender: TObject);
begin
  WebBrowser1.Navigate(EdtURL.Text);
end;

end.
