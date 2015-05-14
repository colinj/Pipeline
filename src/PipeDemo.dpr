program PipeDemo;

uses
  Forms,
  fmPipe in 'fmPipe.pas' {Form1},
  uPipe in 'uPipe.pas',
  uPipe2 in 'uPipe2.pas',
  uLogPipe in 'uLogPipe.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
