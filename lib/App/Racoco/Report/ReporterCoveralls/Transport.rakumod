use App::Racoco::Report::ReporterCoveralls::Externals :http;

unit class App::Racoco::Report::ReporterCoveralls::Transport
	is export;

has $.uri = "https://coveralls.io/api/v1/jobs";

my class FakePath is IO::Path {
	has $.content;
	method slurp(|c) { $!content.encode }
	method basename(|c) { 'json_file' }
	method set($content) { $!content = $content; self }
}

method send(Str:D $obj, :$uri --> Str) {
	my $response = send-post(uri => $uri // $!uri, file => FakePath.new($*CWD).set($obj));

	my $content = $response<content>.decode;
	fail $response<status> ~ "$?NL" ~ $content unless $response<success>;
	self.parse-job-url($content)
}

# Example of $response<content>.decode:
# {"message":"Job #1618708989.1","url":"https://coveralls.io/jobs/92040948"}
method parse-job-url($response --> Str()) {
	$response.match(/'https://coveralls.io' <-["]>+/) // ''
}