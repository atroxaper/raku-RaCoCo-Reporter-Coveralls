use Test;
use lib 'lib';
use App::Racoco::Report::ReporterCoveralls::Transport;

plan 4;

my Transport $transport = Transport.new;
my $content = q:to/END/;
	{
	"name": "App::RaCoCo::Reporter::ReporterCoveralls",
	"description": "RaCoCo reporter for Coveralls.io service",
	}
	END

lives-ok { $transport.send(uri => 'https://httpbin.org/post', $content) }, 'success post';
dies-ok { $transport.send(uri => 'https://httpbin.org/wrong_uri', $content) }, 'fail post';

my $responce-content = '{"message":"Job #1618708989.1","url":"https://coveralls.io/jobs/92040948"}';
is $transport.parse-job-url($responce-content), 'https://coveralls.io/jobs/92040948', 'parse ok';
is $transport.parse-job-url('https://coveralls_io/jobs/92040948'), '', 'parse nok';

done-testing