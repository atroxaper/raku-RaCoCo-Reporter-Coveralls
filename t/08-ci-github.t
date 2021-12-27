use Test;
use lib 'lib';
use lib 't/lib';
use App::Racoco::Report::ReporterCoveralls::CI;
use Fixture;
use Mocks;

plan 19;

my $p = Mocks::PropertiesMock.new;
my GitHubCI $ci = GitHubCI.new(:$p);

%*ENV{'GITHUB_ACTIONS'}:delete;
nok GitHubCI.is-my(:$p), 'github is my nok';
%*ENV{'GITHUB_ACTIONS'} = 1;
ok GitHubCI.is-my(:$p), 'github is my ok';

Fixture::test-ci($ci, (
	('repo-token', Nil),
	('service-name', 'custom-name', <github_service_name>),
	('service-name', 'github-actions'),
	('service-number', '123', <GITHUB_RUN_ID>),
	('service-job-id', ''),
	('service-pull-request', '1234', <GITHUB_REF>, 'refs/pull/1234/branch'),
	('service-pull-request', Nil, <GITHUB_REF>, 'refs/heads/branch'),
	('git-hash', 'hash-sum', <GITHUB_SHA>),
	('git-branch', 'branch1', <GITHUB_REF>, 'refs/heads/branch1'),
	('git-branch', 'branch2', <GITHUB_REF>, 'refs/tags/branch2'),
	('git-branch', 'branch3', <GITHUB_HEAD_REF>),
	('git-author', Nil),
	('git-email', Nil),
	('git-committer', Nil),
	('git-committer-email', Nil),
	('git-message', Nil),
	('git-remote', Nil),
));

done-testing