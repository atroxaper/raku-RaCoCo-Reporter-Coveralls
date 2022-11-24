use Test;
use lib 'lib';
use lib 't/lib';
use App::Racoco::Report::ReporterCoveralls::CI;
use Fixture;
use Mocks;

plan 13;

my $*create-executor = Mocks::ExecutorMock.new(responces => %(
		'%H' => '_hash',
		'%aN' => '_author',
		'%ae' => '_author_email',
		'%cN' => '_committer',
		'%ce' => '_committer_email',
		'%s' => '_message',
		'--abbrev-ref' => '_branch',
		'remote' => "origin  origin.git (fetch)\norigin  origin.git (push)\nzork  zork.git (fetch)",
	));
my NativeGitCI $ci = NativeGitCI.new;

Fixture::test-ci($ci, (
	('repo-token', Nil),
	('service-name', Nil),
	('service-number', Nil),
	('service-job-id', Nil),
	('service-pull-request', Nil),
	('git-hash', '_hash'),
	('git-author', '_author'),
	('git-email', '_author_email'),
	('git-committer', '_committer'),
	('git-committer-email', '_committer_email'),
	('git-message', '_message'),
	('git-branch', '_branch'),
	('git-remote', ('origin' => 'origin.git')),
));

done-testing