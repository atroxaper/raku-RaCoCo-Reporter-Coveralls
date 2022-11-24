use Test;
use lib 'lib';
use lib 't/lib';
use App::Racoco::Report::ReporterCoveralls::CI;
use Fixture;
use Mocks;

plan 22;

my $p = Mocks::PropertiesMock.new;
my DefaultCI $ci = DefaultCI.new(:$p);

Fixture::test-ci($ci, (
	('repo-token', '12321', <COVERALLS_REPO_TOKEN repo_token>),
	('service-name', 'service-name', <COVERALLS_SERVICE_NAME CI_NAME service_name>),
	('service-number', '32123', <COVERALLS_SERVICE_NUMBER CI_BUILD_NUMBER service_number>),
	('service-job-id', '333', <COVERALLS_SERVICE_JOB_ID service_job_id>),
	('service-pull-request', '111', <CI_PULL_REQUEST pull_request>),
	('git-hash', '44112233ddss', <GIT_ID>),
	('git-author', 'git-author', <GIT_AUTHOR_NAME>),
	('git-email', 'git-email', <GIT_AUTHOR_EMAIL>),
	('git-committer', 'git-committer', <GIT_COMMITTER_NAME>),
	('git-committer-email', 'git-committer-email', <GIT_COMMITTER_EMAIL>),
	('git-message', 'git-message', <GIT_MESSAGE>),
	('git-branch', 'git-branch', <GIT_BRANCH CI_BRANCH>),
	('git-remote', (ori => ''), <GIT_REMOTE>, 'ori'),
));

%*ENV<GIT_REMOTE> = 'ori';
%*ENV<GIT_URL> = 'ori.git';
is $ci.git-remote, %(ori => 'ori.git'), 'git remote full ok';

done-testing