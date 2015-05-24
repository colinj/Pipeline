unit Demo.CalcFuncs;

interface

uses
  System.SysUtils,
  System.Classes,
  Pipeline.Pipe;

function Add(const X: Integer): TPipeFunc<Integer, Integer>;
function Subtract(const X: Integer): TPipeFunc<Integer, Integer>;
function Multiply(const X: Integer): TPipeFunc<Integer, Integer>;
function DivideBy(const X: Integer): TPipeFunc<Integer, Integer>;

implementation

function Add(const X: Integer): TPipeFunc<Integer, Integer>;
begin
  Result :=
    function (const I: Integer): Integer
    begin
      Result := I + X;
    end;
end;

function Subtract(const X: Integer): TPipeFunc<Integer, Integer>;
begin
  Result :=
    function (const I: Integer): Integer
    begin
      Result := I - X;
    end;
end;

function Multiply(const X: Integer): TPipeFunc<Integer, Integer>;
begin
  Result :=
    function (const I: Integer): Integer
    begin
      Result := I * X;
    end;
end;

function DivideBy(const X: Integer): TPipeFunc<Integer, Integer>;
begin
  Result :=
    function (const I: Integer): Integer
    begin
      Result := I div X;
    end;
end;

end.
