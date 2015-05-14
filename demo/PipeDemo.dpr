program PipeDemo;

uses
  Forms,
  Demo.Main in 'Demo.Main.pas' {Form1},
  Pipeline.Pipe in '..\src\Pipeline.Pipe.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
