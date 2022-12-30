use v6.c;
use Test;

plan 2;

use Pod::Utils::Build;

is-deeply pod-code("code"), $=pod[0].contents[0].contents[0],
"Correct structure";

is-deeply pod-code("code").type, "C",
"Formatting code type";

=begin pod

C<code>

=end pod

done-testing;
