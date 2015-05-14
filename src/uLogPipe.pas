unit uLogPipe;

interface

uses
    SysUtils,
    Classes,
    uPipe2;

type
    TLogPipe = record
    private
        FLogger: TLogFunc;
        FPipe: TPipe;
    public
        function Bind(const aValue: Integer): TLogPipe; overload;
        function Bind(const aFunc: TIntFunc): TLogPipe; overload;
        function Bind(const aProc: TIntProc): TLogPipe; overload;
        function IsValid: Boolean;
        function ToString: string;
        class operator Implicit(const aLogger: TLogFunc): TLogPipe;
    end;

implementation

{ TLogPipe }

function TLogPipe.IsValid: Boolean;
begin
    Result := FPipe.IsValid;
end;

function TLogPipe.ToString: string;
begin
    Result := FPipe.ToString;
end;

class operator TLogPipe.Implicit(const aLogger: TLogFunc): TLogPipe;
begin
    Result.FLogger := aLogger;
end;

function TLogPipe.Bind(const aValue: Integer): TLogPipe;
begin
    Result.FLogger := FLogger;
    Result.FPipe := TPipe.Bind(aValue);

    if Assigned(FLogger) then
        FLogger(Result.ToString);
end;

function TLogPipe.Bind(const aFunc: TIntFunc): TLogPipe;
begin
    Result.FLogger := Flogger;
    Result.FPipe := FPipe.Bind(aFunc);

    if Assigned(FLogger) then
        FLogger(Result.ToString);
end;

function TLogPipe.Bind(const aProc: TIntProc): TLogPipe;
begin
    Result.FLogger := Flogger;
    Result.FPipe := FPipe.Bind(aProc);

    if Assigned(FLogger) then
        FLogger(Result.ToString);
end;

end.
