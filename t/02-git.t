use Test;
use lib 'lib';
use lib 't/lib';
use App::Racoco::Report::ReporterCoveralls::Git;
use App::Racoco::Report::ReporterCoveralls::Executor;
use Mocks;

plan 2;

subtest '01-with-mock', {
	plan 8;
	my $*create-executor = Mocks::ExecutorMock.new(responces => %(
		'%H' => '_hash',
		'%aN' => '_author',
		'%ae' => '_author_email',
		'%cN' => '_commiter',
		'%ce' => '_commiter_email',
		'%s' => '_message',
		'--abbrev-ref' => '_branch',
		'remote' => "origin  origin.git (fetch)\norigin  origin.git (push)\nzork  zork.git (fetch)",
	));
	my $git = Git.new;

	is $git.get-git(:hash), '_hash', 'hash';
	is $git.get-git(:author), '_author', 'author';
	is $git.get-git(:email), '_author_email', 'email';
	is $git.get-git(:committer), '_commiter', 'commiter';
	is $git.get-git(:committer-email), '_commiter_email', 'commiter email';
	is $git.get-git(:message), '_message', 'message';
	is $git.get-git(:branch), '_branch', 'branch';
	is $git.get-git(:remote), %(origin => 'origin.git'), 'remotes';
}

subtest '02-with-real', {
	my $*create-executor = Executor.new;
	my $git = Git.new;
	ok $git.get-git(:hash).chars > 0, 'real git';
}

done-testing