{****************************************************}
{                                                    }
{  Pipeline Library                                  }
{                                                    }
{  Copyright (C) 2015 Colin Johnsun                  }
{                                                    }
{  https:/github.com/colinj                          }
{                                                    }
{****************************************************}
{                                                    }
{  This Source Code Form is subject to the terms of  }
{  the Mozilla Public License, v. 2.0. If a copy of  }
{  the MPL was not distributed with this file, You   }
{  can obtain one at                                 }
{                                                    }
{  http://mozilla.org/MPL/2.0/                       }
{                                                    }
{****************************************************}

unit Pipeline.LogPipe;

interface

uses
  System.SysUtils,
  System.Classes,
  Pipeline.Pipe;

type
  TLogProc<T> = reference to procedure(const Arg: TPipe<T>);

  TLogPipe<T> = record
  private
    FLogger: TLogProc<T>;
    FPipe: TPipe<T>;
    function GetError: string;
    function GetValue: T;
  public
    function Bind(const aValue: T): TLogPipe<T>; overload;
    function Bind(const aProc: TPipeProc<T>): TLogPipe<T>; overload;
    function Bind(const aFunc: TPipeFunc<T, T>): TLogPipe<T>; overload;
    function Bind<TResult>(const aFunc: TPipeFunc<T, TResult>): TLogPipe<TResult>; overload;
    function IsValid: Boolean;
    class operator Implicit(const aLogger: TLogProc<T>): TLogPipe<T>;
    property Value: T read GetValue;
    property Error: string read GetError;
  end;

implementation

{ TLogPipe<T> }

function TLogPipe<T>.IsValid: Boolean;
begin
  Result := FPipe.IsValid;
end;

function TLogPipe<T>.ToString: string;
begin
  Result := FPipe.ToString;
end;

class operator TLogPipe<T>.Implicit(const aLogger: TLogProc): TLogPipe<T>;
begin
  Result.FLogger := aLogger;
end;

function TLogPipe<T>.Bind(const aValue: T): TLogPipe<T>;
begin
  Result.FLogger := FLogger;
  Result.FPipe := TPipe<T>.Bind(aValue);

  if Assigned(FLogger) then
    FLogger(Result.ToString);
end;

function TLogPipe<T>.Bind(const aFunc: TIntFunc): TLogPipe<T>;
begin
  Result.FLogger := FLogger;
  Result.FPipe := FPipe.Bind(aFunc);

  if Assigned(FLogger) then
    FLogger(Result.ToString);
end;

function TLogPipe<T>.Bind(const aProc: TIntProc): TLogPipe<T>;
begin
  Result.FLogger := FLogger;
  Result.FPipe := FPipe.Bind(aProc);

  if Assigned(FLogger) then
    FLogger(Result.ToString);
end;

function TLogPipe<T>.Bind(const aProc: TPipeProc<T>): TLogPipe<T>;
begin

end;

function TLogPipe<T>.Bind(const aValue: T): TLogPipe<T>;
begin

end;

function TLogPipe<T>.Bind(const aFunc: TPipeFunc<T, T>): TLogPipe<T>;
begin

end;

function TLogPipe<T>.Bind<TResult>(const aFunc: TPipeFunc<T, TResult>): TLogPipe<TResult>;
begin

end;

function TLogPipe<T>.GetError: string;
begin
  Result := FPipe.Error;
end;

function TLogPipe<T>.GetValue: T;
begin
  Result := FPipe.Value;
end;

end.
