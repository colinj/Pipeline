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

unit Pipeline.Pipe;

interface

uses
  System.SysUtils,
  System.Classes;

type
  TPipeFunc<T, TResult> = reference to function(const Arg: T): TResult;
  TPipeProc<T> = reference to procedure(const Arg: T);

  TIntFunc = TPipeFunc<Integer, Integer>;
  TIntProc = TPipeProc<Integer>;

  TPipe<T> = record
  private
    FValue: T;
    FError: string;
  public
    constructor Bind(const aValue: T); overload;
    function Bind(const aProc: TPipeProc<T>): TPipe<T>; overload;
    function Bind(const aFunc: TPipeFunc<T, T>): TPipe<T>; overload;
    function Bind<TResult>(const aFunc: TPipeFunc<T, TResult>): TPipe<TResult>; overload;
    function IsValid: Boolean;
    property Value: T read FValue;
    property Error: string read FError;
  end;

implementation

{ TPipe<T> }

constructor TPipe<T>.Bind(const aValue: T);
begin
  FValue := aValue;
  FError := '';
end;

function TPipe<T>.Bind(const aProc: TPipeProc<T>): TPipe<T>;
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

function TPipe<T>.Bind(const aFunc: TPipeFunc<T, T>): TPipe<T>;
begin
  Result := Bind<T>(aFunc);
end;

function TPipe<T>.Bind<TResult>(const aFunc: TPipeFunc<T, TResult>): TPipe<TResult>;
begin
  if FError = '' then
    try
      Result.FValue := aFunc(FValue);
    except
      on E: Exception do
        Result.FError := E.Message;
    end
  else
    Result.FError := FError;
end;

function TPipe<T>.IsValid: Boolean;
begin
  Result := FError = '';
end;

end.
