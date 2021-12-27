use App::Racoco::Report::ReporterCoveralls::Git;

role App::Racoco::Report::ReporterCoveralls::CI
		is export {
	method repo-token()           { ... }
	method service-name()         { ... }
	method service-number()       { ... }
	method service-job-id()       { ... }
	method service-pull-request() { ... }
	method git-hash()             { ... }
	method git-author()           { ... }
	method git-email()            { ... }
	method git-committer()        { ... }
	method git-committer-email()  { ... }
	method git-message()          { ... }
	method git-branch()           { ... }
	method git-remote()           { ... }
}

class App::Racoco::Report::ReporterCoveralls::DefaultCI
		does App::Racoco::Report::ReporterCoveralls::CI
		is export {
	has $.p;
	method repo-token()           { $!p.get(<COVERALLS_REPO_TOKEN                      repo_token>) }
	method service-name()         { $!p.get(<COVERALLS_SERVICE_NAME   CI_NAME          service_name>) }
	method service-number()       { $!p.get(<COVERALLS_SERVICE_NUMBER CI_BUILD_NUMBER  service_number>) }
	method service-job-id()       { $!p.get(<COVERALLS_SERVICE_JOB_ID                  service_job_id>) }
	method service-pull-request() { $!p.get(<                         CI_PULL_REQUEST  pull_request>) }
	method git-hash()             { $!p.get(<GIT_ID>) }
	method git-author()           { $!p.get(<GIT_AUTHOR_NAME>) }
	method git-email()            { $!p.get(<GIT_AUTHOR_EMAIL>) }
	method git-committer()        { $!p.get(<GIT_COMMITTER_NAME>) }
	method git-committer-email()  { $!p.get(<GIT_COMMITTER_EMAIL>) }
	method git-message()          { $!p.get(<GIT_MESSAGE>) }
	method git-branch()           { $!p.get(<GIT_BRANCH               CI_BRANCH>) }
	method git-remote()           {
		with $!p.get('GIT_REMOTE') {
			return $_ => ($!p.get('GIT_URL') // '')
		}
	}
}

# https://docs.github.com/en/actions/learn-github-actions/environment-variables
class App::Racoco::Report::ReporterCoveralls::GitHubCI
		does App::Racoco::Report::ReporterCoveralls::CI
		is export {
	has $.p;
	method is-my(:$p) { $p.get('GITHUB_ACTIONS').defined }
	method repo-token()           { Nil }
	method service-name()         { $!p.get('github_service_name') // 'github-actions' }
	method service-number()       { $!p.get('GITHUB_RUN_ID') }
	method service-job-id()       { '' }
	method service-pull-request() {
		with $!p.get('GITHUB_REF') -> $ref {
			return $ref.split('/')[2] if $ref.starts-with('refs/pull/')
		}
		Nil
	}
	method git-hash()             { $!p.get(<GITHUB_SHA>) }
	method git-author()           {	Nil }
	method git-email()            { Nil }
	method git-committer()        { Nil }
	method git-committer-email()  { Nil }
	method git-message()          { Nil }
	method git-branch() {
		with $!p.get('GITHUB_REF') -> $ref {
			return $ref.split('/')[*-1] if $ref.starts-with(any('refs/heads/', 'refs/tags/'))
		}
		return $_ with $!p.get('GITHUB_HEAD_REF');
		Nil
	}
	method git-remote()           { Nil }
}

# https://docs.gitlab.com/14.6/ee/ci/variables/predefined_variables.html
class App::Racoco::Report::ReporterCoveralls::GitLabCI
		does App::Racoco::Report::ReporterCoveralls::CI
		is export {
	has $.p;
	method is-my(:$p) { $p.get('GITLAB_CI').defined }
	method repo-token()           { Nil }
	method service-name()         { 'gitlab-ci' }
	method service-number()       { $!p.get('CI_PIPELINE_ID') }
	method service-job-id()       { $!p.get(<CI_JOB_ID>) }
	method service-pull-request() { $!p.get(<CI_MERGE_REQUEST_IID>) }
	method git-hash()             { $!p.get(<CI_COMMIT_SHA>) }
	method git-author()           { Nil }
	method git-email()            { Nil }
	method git-committer()        { Nil }
	method git-committer-email()  { Nil }
	method git-message()          { $!p.get(<CI_COMMIT_MESSAGE>) }
	method git-branch()           { $!p.get(<CI_COMMIT_REF_NAME>) }
	method git-remote()           { Nil }
}

class App::Racoco::Report::ReporterCoveralls::NativeGitCI
		does App::Racoco::Report::ReporterCoveralls::CI
		is export {
	has $!git = Git.new;
	method repo-token()           { Nil }
	method service-name()         { Nil }
	method service-number()       { Nil }
	method service-job-id()       { Nil }
	method service-pull-request() { Nil }
	method git-hash()             { $!git.get-git: :hash }
	method git-author()           { $!git.get-git: :author }
	method git-email()            { $!git.get-git: :email }
	method git-committer()        { $!git.get-git: :committer }
	method git-committer-email()  { $!git.get-git: :committer-email }
	method git-message()          { $!git.get-git: :message }
	method git-branch()           { $!git.get-git: :branch }
	method git-remote()           { $!git.get-git: :remote }
}

class App::Racoco::Report::ReporterCoveralls::ChainCI
		does App::Racoco::Report::ReporterCoveralls::CI
		is export {
	has @.ci;
	method new(*@ci)              { self.bless(:@ci) }
	method repo-token()           { [//] @!ci>>.repo-token }
	method service-name()         { [//] @!ci>>.service-name }
	method service-number()       { [//] @!ci>>.service-number }
	method service-job-id()       { [//] @!ci>>.service-job-id }
	method service-pull-request() { [//] @!ci>>.service-pull-request }
	method git-hash()             { [//] @!ci>>.git-hash }
	method git-author()           { [//] @!ci>>.git-author }
	method git-email()            { [//] @!ci>>.git-email }
	method git-committer()        { [//] @!ci>>.git-committer }
	method git-committer-email()  { [//] @!ci>>.git-committer-email }
	method git-message()          { [//] @!ci>>.git-message }
	method git-branch()           { [//] @!ci>>.git-branch }
	method git-remote()           { [//] @!ci>>.git-remote }
}

class App::Racoco::Report::ReporterCoveralls::EmptyCI
		does App::Racoco::Report::ReporterCoveralls::CI
		is export {
	method repo-token()           { '' }
	method service-name()         { '' }
	method service-number()       { '' }
	method service-job-id()       { '' }
	method service-pull-request() { '' }
	method git-hash()             { '' }
	method git-author()           { '' }
	method git-email()            { '' }
	method git-committer()        { '' }
	method git-committer-email()  { '' }
	method git-message()          { '' }
	method git-branch()           { '' }
	method git-remote()           { '' => '' }
}
