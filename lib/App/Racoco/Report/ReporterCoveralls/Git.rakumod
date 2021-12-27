use App::Racoco::Report::ReporterCoveralls::Factory;

unit class App::Racoco::Report::ReporterCoveralls::Git is export;

has $!executor = Factory::create-executor;

multi method get-git(:hash($)! --> Str) {
	self!git-log-format('%H')
}

multi method get-git(:author($)! --> Str) {
	self!git-log-format('%aN')
}

multi method get-git(:email($)! --> Str) {
	self!git-log-format('%ae')
}

multi method get-git(:committer($)! --> Str) {
	self!git-log-format('%cN')
}

multi method get-git(:committer-email($)! --> Str) {
	self!git-log-format('%ce')
}

multi method get-git(:message($)! --> Str) {
	self!git-log-format('%s')
}

multi method get-git(:branch($)! --> Str) {
	$!executor.execute("git rev-parse --abbrev-ref HEAD");
}

multi method get-git(:remote($)! --> Pair) {
	with $!executor.execute("git remote -v") -> $from-git {
		return $from-git.lines.grep(*.contains: '(fetch)').map(*.words).map({.[0] => .[1]}).Map.sort(*.key).first
	}
}

method !git-log-format($format --> Str) {
	$!executor.execute("git --no-pager log -1 --pretty=format:$format")
}
