use Test;
use lib 'lib';
use lib 't/lib';
use App::Racoco::Report::ReporterCoveralls::CI;
use Fixture;
use Mocks;

plan 13;
my EmptyCI $ci = EmptyCI.new;

Fixture::test-ci($ci, (
	('repo-token', ''),
	('service-name', ''),
	('service-number', ''),
	('service-job-id', ''),
	('service-pull-request', ''),
	('git-hash', ''),
	('git-author', ''),
	('git-email', ''),
	('git-committer', ''),
	('git-committer-email', ''),
	('git-message', ''),
	('git-branch', ''),
	('git-remote', ('' => '')),
));

done-testing