program PipeDemo;

uses
  Forms,
  Demo.Main in 'Demo.Main.pas' {frmMain},
  Pipeline.Pipe in '..\src\Pipeline.Pipe.pas',
  Demo.CalcFuncs in 'Demo.CalcFuncs.pas',
  Demo.Update in 'Demo.Update.pas' {frmUpdate};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmUpdate, frmUpdate);
  Application.Run;

end.
