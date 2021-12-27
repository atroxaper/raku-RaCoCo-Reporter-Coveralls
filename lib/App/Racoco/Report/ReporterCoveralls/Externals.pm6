use Digest:ver<0.*.*>;
use HTTP::Tiny:ver<0.*.*>:auth<zef:jjatria>;
use App::Racoco::RunProc:ver<1.5+>:auth<zef:atroxaper>:ver<1>;
use App::Racoco::Report::Data:ver<1.5+>:auth<zef:atroxaper>:ver<1>;
use App::Racoco::Report::Reporter:ver<1.5+>:auth<zef:atroxaper>:ver<1>;

unit module App::Racoco::Report::ReporterCoveralls::Externals;

our sub md5(|c) is export(:md5) {
	Digest::EXPORT::DEFAULT::md5(|c)
}

our sub run-context() is export(:run-and-get-out) {
	RunProc.new
}

our sub run-and-get-out($context, $command) is export(:run-and-get-out) {
	autorun(proc => $context, :out, $command)()
}

our sub send-post(Str :$uri, IO::Path :$file) is export(:http) {
	HTTP::Tiny.new.post: $uri, content => %(json_file => $file)
}

our role MyReporter does Reporter is export(:reporter) {}

our class Properties is export(:properties) {
	has $.properties is required;
	method get(*@keys) {
		[//] ($!properties.property($_) for @keys);
	}
}

our sub create-data(:$coverable is raw, :$covered is raw) is export(:data) {
	Data.new(:$coverable, :$covered)
}