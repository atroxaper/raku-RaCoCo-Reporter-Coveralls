use Test;
use lib 'lib';
use lib 't/lib';
use App::Racoco::Report::ReporterCoveralls::CI;
use Fixture;
use Mocks;

plan 39;

class Mock1CI { method FALLBACK($name, |c) { Nil } }
class Mock2CI { method FALLBACK($name, |c) { 'value' } }

test ChainCI.new(Mock1CI.new, Mock2CI.new);
test ChainCI.new(Mock2CI.new, Mock1CI.new);
test ChainCI.new(Mock2CI.new);

sub test($ci) {
	Fixture::test-ci($ci, (
		('repo-token', 'value'),
		('service-name', 'value'),
		('service-number', 'value'),
		('service-job-id', 'value'),
		('service-pull-request', 'value'),
		('git-hash', 'value'),
		('git-author', 'value'),
		('git-email', 'value'),
		('git-committer', 'value'),
		('git-committer-email', 'value'),
		('git-message', 'value'),
		('git-branch', 'value'),
		('git-remote', 'value'),
	));
}

done-testing