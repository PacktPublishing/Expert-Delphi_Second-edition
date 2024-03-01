unit uFormDemo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ScrollBox, FMX.Memo,
  FMX.Memo.Types;

type
  TFormDemo = class(TForm)
    ButtonMultiline: TButton;
    BtnPersonsTList: TButton;
    MemoLog: TMemo;
    BtnPersonsGenerics: TButton;
    BtnDoStringProc: TButton;
    BtnDocAttribute: TButton;
    BtnRTTI: TButton;
    procedure ButtonMultilineClick(Sender: TObject);
    procedure BtnPersonsTListClick(Sender: TObject);
    procedure BtnPersonsGenericsClick(Sender: TObject);
    procedure BtnDoStringProcClick(Sender: TObject);
    procedure BtnDocAttributeClick(Sender: TObject);
    procedure BtnRTTIClick(Sender: TObject);
  private
    procedure ClearLog;
  public
    procedure DoLog(s: string);
  end;

procedure Log(s: string);

var
  FormDemo: TFormDemo;

implementation

{$R *.fmx}

uses
  uPersonTList, uPersonGenerics, uAnonymous, uPerson, uDocAttribute,
  uMySuperClass, System.RTTI, System.TypInfo;

const EL = #13;

procedure TFormDemo.ButtonMultilineClick(Sender: TObject);
begin
  ShowMessage('Welcome!' + EL + 'Good morning!');
end;

procedure TFormDemo.ClearLog;
begin
  MemoLog.Lines.Clear;
end;

procedure TFormDemo.DoLog(s: string);
begin
  MemoLog.Lines.Add(s);
end;

procedure Log(s: string);
begin
  if FormDemo <> nil then
    FormDemo.DoLog(s);
end;

procedure TFormDemo.BtnPersonsTListClick(Sender: TObject);
begin
  ClearLog;
  DoPersonsTList;
end;

procedure TFormDemo.BtnRTTIClick(Sender: TObject);
var
  Ctx : TRttiContext;
  T : TRttiType;
  M : TRttiMethod;
begin
  ClearLog;
  T := Ctx.GetType(TButton);
  for M in T.GetMethods do
    if M.Visibility = TMemberVisibility.mvPublic then
      Log(Format('Type = %s; Method = %s',
        [T.Name, M.Name]));
end;

procedure TFormDemo.BtnPersonsGenericsClick(Sender: TObject);
begin
  ClearLog;
  DoPersonsGenerics;
end;

procedure TFormDemo.BtnDoStringProcClick(Sender: TObject);
begin
  ClearLog;
  DoStringProc;
end;

procedure TFormDemo.BtnDocAttributeClick(Sender: TObject);
var
  Ctx : TRttiContext;
  T : TRttiType;
  M : TRttiMethod;
  A : TCustomAttribute;
begin
  ClearLog;
  T := Ctx.GetType(TMySuperClass);

  for A in T.GetAttributes do
    if A is DocAttribute then
      Log(Format('Type = %s; Attribute = %s, URL = %s',
        [TMySuperClass.ClassName, A.ClassName, DocAttribute(A).URL]));

  for M in T.GetMethods do
    for A in M.GetAttributes do
      if A is DocAttribute then
        Log(Format('Type = %s; Method = %s; Attribute = %s, URL = %s',
          [TMySuperClass.ClassName, M.Name, A.ClassName, DocAttribute(A).URL]));
end;

end.
