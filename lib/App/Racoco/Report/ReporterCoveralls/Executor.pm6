use App::Racoco::Report::ReporterCoveralls::Externals :run-and-get-out;

unit class App::Racoco::Report::ReporterCoveralls::Executor
	is export;

has $!context = run-context();

method execute(Str $command) {
	run-and-get-out($!context, $command);
}

