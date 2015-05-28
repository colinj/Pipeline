unit Demo.Update;

interface

uses
  Pipeline.Pipe,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Data.DB, Datasnap.DBClient;

type
  TUpdateRequest = record
    Id: Integer;
    Name: string;
    User: string;
    Timestamp: TDateTime;
  end;

  TUpdateResponse = record
    Id: Integer;
    OldName: string;
    NewName: string;
    User: string;
    Timestamp: TDateTime;
  end;

  TfrmUpdate = class(TForm)
    grpDataEntry: TGroupBox;
    edtId: TLabeledEdit;
    edtName: TLabeledEdit;
    btnUpdate: TButton;
    cdsCustomer: TClientDataSet;
    dtsCustomer: TDataSource;
    grpEmail: TGroupBox;
    memEmail: TMemo;
    grpServerLog: TGroupBox;
    memLog: TMemo;
    chkBadConnection: TCheckBox;
    grpServer: TGroupBox;
    grdCustomer: TDBGrid;
    procedure btnUpdateClick(Sender: TObject);
  private
    procedure ValidateRequest(const aReq: TUpdateRequest);
    function UpdateCustomer(const aReq: TUpdateRequest): TUpdateResponse;
    procedure SendEmail(const aResp: TUpdateResponse);
  public
    procedure SendRequest(const aReq: TUpdateRequest);
  end;

var
  frmUpdate: TfrmUpdate;

implementation

{$R *.dfm}

{ TfrmUpdate }

procedure TfrmUpdate.btnUpdateClick(Sender: TObject);
var
  Req: TUpdateRequest;
begin
  Req.Id := StrToInt(edtId.Text);
  Req.Name := edtName.Text;
  Req.User := 'COLIN';
  Req.Timestamp := Now;
  SendRequest(Req);
end;

procedure TfrmUpdate.SendRequest(const aReq: TUpdateRequest);
var
  R: TPipe<TUpdateResponse>;
begin
   R :=
    TPipe<TUpdateRequest>
      .Bind(aReq)
      .Bind(ValidateRequest)
      .Bind<TUpdateResponse>(UpdateCustomer)
      .Bind(SendEmail);

  if R.IsValid then
    memLog.Lines.Add('Successful update')
  else
    memLog.Lines.Add('Failed updated. ' + R.Error);
end;

procedure TfrmUpdate.ValidateRequest(const aReq: TUpdateRequest);
begin
  if aReq.Name = '' then
    raise Exception.Create('Name must not be blank.');

  if Length(aReq.Name) > 30 then
    raise Exception.Create('Name must not be longer than 30 chars.');
end;

function TfrmUpdate.UpdateCustomer(const aReq: TUpdateRequest): TUpdateResponse;
begin
  if not cdsCustomer.FindKey([aReq.Id]) then
    raise Exception.CreateFmt('Customer not found with ID: %d', [aReq.Id]);

  try
    Result.Id := aReq.Id;
    Result.OldName := cdsCustomer.FieldByName('COMPANY').AsString;
    Result.NewName := aReq.Name;
    Result.User := aReq.User;
    Result.Timestamp := Now;

    cdsCustomer.Edit;
    cdsCustomer.FieldByName('COMPANY').AsString := aReq.Name;
    cdsCustomer.Post;
  except
    on E: Exception do
    begin
      cdsCustomer.Cancel;
      raise Exception.CreateFmt('DB Error: %s', [E.Message]);
    end;
  end;
end;

procedure TfrmUpdate.SendEmail(const aResp: TUpdateResponse);
const
  EMAIL_MSG =
    'Dear %s,'#13#10#13#10 +
    'This is a confirmation email to notify you that ' +
    'the name of Customer %d was updated from ''%s'' to ''%s''.'#13#10#13#10 +
    'Regards,'#13#10 +
    'The Server Team';
begin
  Sleep(1000);
  if not chkBadConnection.Checked then
    memEmail.Lines.Add(Format(EMAIL_MSG, [aResp.User, aResp.Id, aResp.OldName, aResp.NewName]))
  else
    raise Exception.Create('Bad connection. Email was not sent.');
end;

end.
