use v6.c;
use Test;

plan 2;

use Pod::Utils::Build;

is-deeply pod-heading("heading", level => 1), $=pod[0].contents[0],
"Correct structure";

is-deeply pod-heading("heading").level, 1,
"Level";

=begin pod

=head1 heading

=end pod

done-testing;
