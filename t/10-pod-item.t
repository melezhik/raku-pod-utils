use v6.c;
use Test;

plan 2;

use Pod::Utilities::Build;

is-deeply pod-item(pod-block("item"), level => 1), $=pod[0].contents[0],
"Correct structure";

is-deeply pod-item("code").level, 1,
"Level";

=begin pod

=item item

=end pod

done-testing;