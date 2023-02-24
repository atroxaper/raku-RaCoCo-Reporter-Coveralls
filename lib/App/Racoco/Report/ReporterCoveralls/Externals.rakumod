use Digest::MD5:ver<0.*.*>:auth<zef:grondilu>;
use HTTP::UserAgent:ver<1.*.*>:auth<github:sergot>;
use App::Racoco::RunProc:ver<2.*.*>:auth<zef:atroxaper>:ver<2>;
use App::Racoco::Report::Data:ver<2.*.*>:auth<zef:atroxaper>:ver<2>;
use App::Racoco::Report::Reporter:ver<2.*.*>:auth<zef:atroxaper>:ver<2>;

unit module App::Racoco::Report::ReporterCoveralls::Externals;

our sub md5(|c) is export(:md5) {
	Digest::MD5::EXPORT::DEFAULT::md5(|c)
}

our sub run-context() is export(:run-and-get-out) {
	RunProc.new
}

our sub run-and-get-out($context, $command) is export(:run-and-get-out) {
	autorun(proc => $context, :out, $command)().trim;
}

our sub send-post(Str :$uri, IO::Path :$file) is export(:http) {
	HTTP::UserAgent.new.post(
		$uri,
		%(json_file => [$file]),
		Content-Type => 'multipart/form-data'
	)
}

our role MyReporter does Reporter is export(:reporter) {}

our class Properties is export(:properties) {
	has $.config is required;
	method get(*@keys) {
		my $value = [//] ($!config.get($_) for @keys);
		return $value without $value;
		$value.trim.lines.grep(*.chars > 0).join(' ');
	}
}

our sub create-data(:$coverable is raw, :$covered is raw) is export(:data) {
	Data.new(:$coverable, :$covered)
}