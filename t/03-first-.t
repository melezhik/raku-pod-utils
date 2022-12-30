use v6.c;
use Test;

plan *;

use Pod::Utils;

my $code = $=pod[0].contents[2].contents[0];

subtest {
    is first-code-block($=pod.first.contents), $code.join, "Basic test";
    is first-code-block([])                  ,         "", "Returns empty string";
}, "first-code-block";

subtest {
    is-deeply first-title($=pod[0].contents), $=pod[0].contents[0],
    "First =TITLE";
}, "first-title";

subtest {
    is-deeply first-subtitle($=pod[0].contents), $=pod[0].contents[1],
    "First =SUBTITLE";
}, "first-subtitle";

=begin pod

=TITLE Some cool title

=SUBTITLE Perl6 rocks

    say "this code rocks.";
    say "Perl6" ~ "is cool."

=end pod

done-testing;
