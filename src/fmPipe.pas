unit fmPipe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    memLog: TMemo;
    btnGo: TButton;
    procedure btnGoClick(Sender: TObject);
  private
    procedure Log(const aMsg: string);
    function Add12(const aValue: Integer): Integer;
    function Subtract5(const aValue: Integer): Integer;
    function Triple(const aValue: Integer): Integer;
    function Halve(const aValue: Integer): Integer;
    function DivByZero(const aValue: Integer): Integer;
    procedure LogValue(const aValue: Integer);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
    uPipe2,
    uLogPipe;

{$R *.dfm}

{ TForm1 }

procedure TForm1.btnGoClick(Sender: TObject);
var
//    V: TPipe;
    V: TLogPipe;
begin
//    V := TPipe
    V := TLogPipe(Log)
        .Bind(6)
        .Bind(Add12)
        .Bind(LogValue)
        .Bind(Subtract5)
        .Bind(LogValue)
        .Bind(DivByZero)
        .Bind(Triple)
        .Bind(Halve);

    Log('-----------');
    Log(V.ToString);
end;

function TForm1.DivByZero(const aValue: Integer): Integer;
begin
    Result := aValue div (aValue - aValue);
end;

procedure TForm1.Log(const aMsg: string);
begin
    memLog.Lines.Add(aMsg);
end;

procedure TForm1.LogValue(const aValue: Integer);
begin
    Log('This is the LogValue procedure: ' + IntToStr(aValue));
end;

function TForm1.Add12(const aValue: Integer): Integer;
begin
    Result := aValue + 12;
end;

function TForm1.Halve(const aValue: Integer): Integer;
begin
    Result := aValue div 2;
end;

function TForm1.Triple(const aValue: Integer): Integer;
begin
    Result := aValue * 3;
end;

function TForm1.Subtract5(const aValue: Integer): Integer;
begin
    Result := aValue - 5;
end;

end.
