unit uPipe2;

interface

uses
    SysUtils,
    Classes;

type
    TLogFunc = procedure(const S: string) of object;
    TIntFunc = function(const I: Integer): Integer of object;
    TIntProc = procedure(const I: Integer) of object;

    TPipe = record
    private
        FValue: Integer;
        FError: string;
    public
        class function Bind(const aValue: Integer): TPipe; overload; static;
        function Bind(const aFunc: TIntFunc): TPipe; overload;
        function Bind(const aProc: TIntProc): TPipe; overload;
        function IsValid: Boolean;
        function ToString: string;
    end;

implementation

{ TPipe }

function TPipe.IsValid: Boolean;
begin
    Result := FError = '';
end;

class function TPipe.Bind(const aValue: Integer): TPipe;
begin
    Result.FValue := aValue;
    Result.FError := '';
end;

function TPipe.ToString: string;
begin
    if FError = '' then
        Result := 'The value is ' + IntToStr(FValue)
    else
        Result := 'Error occurred: ' + FError;
end;

function TPipe.Bind(const aFunc: TIntFunc): TPipe;
begin
    if FError = '' then
    try
        Result.FValue := aFunc(FValue);
    except
        on E: Exception do
            Result.FError := E.Message;
    end
    else
        Result := Self;
end;

function TPipe.Bind(const aProc: TIntProc): TPipe;
begin
    if FError = '' then
    try
        aProc(FValue);
    except
        on E: Exception do
        begin
            Result.FError := E.Message;
            Exit;
        end;
    end;

    Result := Self;
end;

end.
