use Test;
use lib 'lib';
use lib 't/lib';
use App::Racoco::Report::ReporterCoveralls::CI;
use Fixture;
use Mocks;

plan 15;

my $p = Mocks::PropertiesMock.new;
my GitLabCI $ci = GitLabCI.new(:$p);

%*ENV{'GITLAB_CI'}:delete;
nok GitLabCI.is-my(:$p), 'gitlab is my nok';
%*ENV{'GITLAB_CI'} = 1;
ok GitLabCI.is-my(:$p), 'gitlab is my ok';

Fixture::test-ci($ci, (
	('repo-token', Nil),
	('service-name', 'gitlab-ci'),
	('service-number', '123', <CI_PIPELINE_ID>),
	('service-job-id', '1234', <CI_JOB_ID>),
	('service-pull-request', '321', <CI_MERGE_REQUEST_IID>),
	('git-hash', 'hash-code', <CI_COMMIT_SHA>),
	('git-author', Nil),
	('git-email', Nil),
	('git-committer', Nil),
	('git-committer-email', Nil),
	('git-message', 'the message', <CI_COMMIT_MESSAGE>),
	('git-branch', 'branch', <CI_COMMIT_REF_NAME>),
	('git-remote', Nil),
));

done-testing