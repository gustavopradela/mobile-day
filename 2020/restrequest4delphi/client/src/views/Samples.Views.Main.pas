unit Samples.Views.Main;

interface

uses System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, FMX.Types, FMX.Graphics, FMX.Controls,
  FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Layouts, FMX.Objects;

type
  THeaderFooterForm = class(TForm)
    Header: TToolBar;
    Footer: TToolBar;
    HeaderLabel: TLabel;
    vsbUsers: TVertScrollBox;
    Rectangle: TRectangle;
    procedure FormShow(Sender: TObject);
  private
    procedure LoadUsers;
  end;

var
  HeaderFooterForm: THeaderFooterForm;

implementation

{$R *.fmx}

uses Samples.Providers.Frames.User, Samples.Services.User;

procedure THeaderFooterForm.FormShow(Sender: TObject);
begin
  vsbUsers.BeginUpdate;
  try
    Self.LoadUsers;
  finally
    vsbUsers.EndUpdate;
  end;
end;

procedure THeaderFooterForm.LoadUsers;
var
  LFrameUser: TUserFrame;
  LService: TUserService;
begin
  LService := TUserService.Create(Self);
  try
    LService.GetUsersRESTRequest4Delphi;
    while not LService.mtUsers.Eof do
    begin
      LFrameUser := TUserFrame.Create(vsbUsers);
      LFrameUser.Name := 'UserFrame' + LService.mtUsers.RecNo.ToString;
      LFrameUser.Align := TAlignLayout.Top;
      LFrameUser.lblEmail.Text := LService.mtUsersEMAIL.AsString;
      LFrameUser.lblNome.Text := LService.mtUsersNAME.AsString;
      LService.mtUsers.Next;
    end;
  finally
    LService.Free;
  end;
end;

end.
