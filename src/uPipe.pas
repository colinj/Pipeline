unit uPipe;

interface

uses
    SysUtils,
    Classes;

type
    TLogFunc = procedure(const S: string) of object;
    TIntFunc = function(const I: Integer): Integer of object;

    TPipeValue = record
    private
        FValue: Integer;
        FError: string;
    public
        function IsError: Boolean;
        function ToString: string;
        property Value: Integer read FValue;
        class operator Implicit(const aValue: Integer): TPipeValue;
        class operator Implicit(const aError: string): TPipeValue;
    end;

    TPipeLine = record
    private
        FLogger: TLogFunc;
        FValue: TPipeValue;
    public
        function Pipe(const aFunc: TIntFunc): TPipeLine;
        function StartWith(const aValue: Integer): TPipeLine;
        function SetLogger(const aLogger: TLogFunc): TPipeLine;
        class operator Implicit(const aLogger: TLogFunc): TPipeLine;
        class operator Implicit(const aValue: Integer): TPipeLine;
        class operator Implicit(const aValue: TPipeLine): string;
    end;

implementation

{ TPipeValue }

class operator TPipeValue.Implicit(const aError: string): TPipeValue;
begin
    Result.FValue := 0;
    Result.FError := aError;
end;

function TPipeValue.IsError: Boolean;
begin
    Result := FError <> '';
end;

function TPipeValue.ToString: string;
begin
    if IsError then
        Result := 'Error occurred: ' + FError
    else
        Result := 'The value is ' + IntToStr(FValue);
end;

class operator TPipeValue.Implicit(const aValue: Integer): TPipeValue;
begin
    Result.FValue := aValue;
    Result.FError := '';
end;


{ TPipe }

class operator TPipeLine.Implicit(const aValue: Integer): TPipeLine;
begin
    Result.FValue := aValue;
end;

class operator TPipeLine.Implicit(const aValue: TPipeLine): string;
begin
    Result := aValue.FValue.ToString;
end;

class operator TPipeLine.Implicit(const aLogger: TLogFunc): TPipeLine;
begin
    Result.FLogger := aLogger;
    Result.FValue := 0;
end;

function TPipeLine.Pipe(const aFunc: TIntFunc): TPipeLine;
begin
    if FValue.IsError then
        Result := Self
    else
    begin
        Result.FLogger := Flogger;
        try
            Result.FValue := aFunc(FValue.Value);
        except
            on E: Exception do
                Result.FValue := E.Message;
        end;
    end;
    if Assigned(FLogger) then
        FLogger(Result);
end;

function TPipeLine.SetLogger(const aLogger: TLogFunc): TPipeLine;
begin
    FLogger := aLogger;
    Result := Self;
    if Assigned(FLogger) then
        FLogger(Result);
end;

function TPipeLine.StartWith(const aValue: Integer): TPipeLine;
begin
    Result.FValue := aValue;
    Result.FLogger := FLogger;
end;

end.
