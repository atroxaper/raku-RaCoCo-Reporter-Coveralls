use App::Racoco::Report::ReporterCoveralls::CI;
use App::Racoco::Report::ReporterCoveralls::MD5;
use App::Racoco::Report::ReporterCoveralls::Factory;
use App::Racoco::Report::ReporterCoveralls::Transport;
use App::Racoco::Report::ReporterCoveralls::Externals :properties, :reporter;

unit class App::Racoco::Report::ReporterCoveralls does MyReporter is export;

has MD5 $!md5 = Factory::create-md5();
has Transport $!transport = Factory::create-transport;

method do(:$lib, :$data, :$properties) {
	my $ci = self.ci-environment(p => Properties.new(:$properties));
	my $json = self.make-json(:$lib, :$data, :$ci);
	my $job-url = $!transport.send($json);
	say 'Coveralls job: ', $job-url;
}

method make-json(:$lib!, :$data!, CI :$ci!) {
	qq:to/END/.trim;
	\{
	"repo_token":"{$ci.repo-token}",
	"service_name":"{$ci.service-name}",
	"service_number":"{$ci.service-number}",
	"service_job_id":"{$ci.service-job-id}",
	"service_pull_request":"{$ci.service-pull-request}",
	"source_files": [
		{self.make-source-files-json(:$lib, :$data)}
	],
	"git": {self.make-git(:$ci)}
	}
	END
}

method make-source-files-json(:$lib, :$data) {
	$data.get-all-parts.map(-> $part {
		my $content = $lib.add($part.file-name).slurp;
		self.coverage-line(:$lib, :$content, :$part)
	}).join(",\n");
}

method coverage-line(:$lib, :$content, :$part) {
	my $lib-name = $lib.basename;
	my $lines = $content.lines.elems;
	my $name = q/"name":"/ ~ $lib-name ~ '/' ~ $part.file-name ~ '",';
	my $source-digest = q/"source_digest":"/ ~ $!md5.md5($content) ~ '",';
	my $coverage = q/"coverage":[/ ~
		(1..$lines).map(-> $line { $part.hit-times-of(:$line) // 'null' }).join(',') ~ ']';
	join "\n", '{', $name, $source-digest, $coverage, '}';
}

method make-git(:$ci!) {
	my $remote := $ci.git-remote;
	qq:to/END/.trim
	\{
		"head":\{
			"id":"{$ci.git-hash}",
			"author_name":"{$ci.git-author}",
			"author_email":"{$ci.git-email}",
			"committer_name":"{$ci.git-committer}",
			"committer_email":"{$ci.git-committer-email}",
			"message":"{$ci.git-message}"
		},
		"branch":"{$ci.git-branch}",
		"remotes": [
			\{
				"name":"{$remote.key}",
				"url": "{$remote.value}"
			}
		]
	}
	END
}

method ci-environment(:$p) {
	my $vendor = DefaultCI.new(:$p);
	$vendor = GitHubCI.new(:$p) if GitHubCI.is-my(:$p);
	$vendor = GitLabCI.new(:$p) if GitLabCI.is-my(:$p);
	return ChainCI.new($vendor, DefaultCI.new(:$p), NativeGitCI.new, EmptyCI.new);
}

