use App::Racoco::RunProc;
use Test;

unit module Fixture;

our sub test-ci($ci, \data) {
	for data -> $for-method {
		my $call-method = $for-method[0];
		my \expected = $for-method[1];
		my \envs = $for-method.elems > 2 ?? $for-method[2] !! 'default';
		my \env-value = $for-method.elems == 2 ?? 'default'
			!! $for-method.elems == 3 ?? $for-method[1]
			!! $for-method[3];

		for envs -> $key {
			%*ENV{$key} = env-value;
			is $ci."$call-method"(), expected, "$call-method $key ok";
			%*ENV{$key}:delete;
		}
	}
}