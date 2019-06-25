use v6.c;
use Test;

plan *;

use Pod::Utilities;


=begin pod
    say "this code rocks.";
    say "Perl6" ~ "is cool."
=end pod

my $code = $=pod[0].contents[0].contents[0];

is first-code-block($=pod.first.contents), $code.join, "Basic test";
is first-code-block([])                  ,         "", "Returns empty string";

done-testing;