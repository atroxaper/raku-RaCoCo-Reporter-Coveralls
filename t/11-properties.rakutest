use Test;
use lib 'lib';
use App::Racoco::Report::ReporterCoveralls::Externals :properties;

plan 1;

my $racoco-properties = (class :: { method property($key) { %*ENV{$key} } }).new;
my $properties = Properties.new(properties => $racoco-properties);

%*ENV{'KEY'} = "line1\n\nline2  ";
is $properties.get('KEY'), 'line1 line2', 'properties one line';

done-testing