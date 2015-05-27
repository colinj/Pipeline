unit Demo.Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmMain = class(TForm)
    memLog: TMemo;
    btnGo: TButton;
    btnCalc: TButton;
    Button1: TButton;
    procedure btnDemo1Click(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
    procedure btnCalcClick(Sender: TObject);
  private
    procedure Log(const aMsg: string);
    procedure LogValue(const aValue: Integer);
    procedure btnDemo2Click(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  Demo.CalcFuncs,
  Pipeline.Pipe;

{$R *.dfm}

{ TfrmMain }

procedure TfrmMain.btnDemo1Click(Sender: TObject);
var
  I: Integer;
begin
  try
    I := DivideBy(2)(Multiply(3)((Subtract(5)(Add(12)(6)))));

    Log(Format('The final value is %d', [I]))
  except
    on E: Exception do
    begin
      Log('-----------');
      Log('The error is: ' + E.Message);
    end;
  end;
end;

procedure TfrmMain.btnDemo2Click(Sender: TObject);
var
  I: Integer;
  Add12: TPipeFunc<Integer, Integer>;
  Subtract5: TPipeFunc<Integer, Integer>;
  Triple: TPipeFunc<Integer, Integer>;
  Halve: TPipeFunc<Integer, Integer>;
  DivideByZero: TPipeFunc<Integer, Integer>;
begin
  Add12 := Add(12);
  Subtract5 := Subtract(5);
  Triple := Multiply(3);
  Halve := DivideBy(2);
  DivideByZero := DivideBy(0);
  try
    I := Halve(Triple(Subtract5(Add12(6))));

    Log(Format('The final value is %d', [I]))
  except
    on E: Exception do
    begin
      Log('-----------');
      Log('The error is: ' + E.Message);
    end;
  end;
end;

procedure TfrmMain.btnGoClick(Sender: TObject);
var
  I: Integer;
begin
  try
    I := 6;
    I := Add(12)(I);
    LogValue(I);
    I := Subtract(5)(I);
    LogValue(I);
    I := DivideBy(0)(I);
    I := Multiply(3)(I);
    I := DivideBy(2)(I);

    Log(Format('The final value is %d', [I]))
  except
    on E: Exception do
    begin
      Log('-----------');
      Log('The error is: ' + E.Message);
    end;
  end;
end;

procedure TfrmMain.btnCalcClick(Sender: TObject);
var
  V: TPipe<Integer>;
begin
  V := TPipe<Integer>
    .Bind(6)
    .Bind(Add(12))
    .Bind(LogValue)
    .Bind(Subtract(5))
    .Bind(LogValue)
    .Bind(DivideBy(0))
    .Bind(Multiply(3))
    .Bind(DivideBy(2));

  Log('-----------');
  if V.IsValid then
    Log(Format('The final value is %d', [V.Value]))
  else
    Log('The error is: ' + V.Error);
end;

procedure TfrmMain.Log(const aMsg: string);
begin
  memLog.Lines.Add(aMsg);
end;

procedure TfrmMain.LogValue(const aValue: Integer);
begin
  Log('This is the LogValue procedure: ' + IntToStr(aValue));
end;

end.
