use App::Racoco::Report::ReporterCoveralls::MD5;
use App::Racoco::Report::ReporterCoveralls::Executor;
use App::Racoco::Report::ReporterCoveralls::Transport;

unit module App::Racoco::Report::ReporterCoveralls::Factory is export;

my $*create-md5;
our sub create-md5(--> MD5) {
	$*create-md5 // MD5.new
}

my $*create-transport;
our sub create-transport(--> Transport) {
	$*create-transport // Transport.new
}

my $*create-executor;
our sub create-executor(--> Executor) {
	$*create-executor // Executor.new
}