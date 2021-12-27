use App::Racoco::Report::ReporterCoveralls::MD5;
use App::Racoco::Report::ReporterCoveralls::Transport;
use App::Racoco::Report::ReporterCoveralls::Executor;

unit module Mocks;

class TransportMock is Transport {
	has $.sended;

	method send(Str:D $obj, :$uri) {
		$!sended = $obj;
		''
	}
}

class PropertiesMock {
	method get(*@keys) {
		[//] (%*ENV{$_} for @keys);
	}
}

class ExecutorMock is Executor {
	has %.responces;
	method execute($command) {
		%!responces.first({ $command.contains: .key }).value // Nil
	}
}