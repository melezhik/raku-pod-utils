use v6.c;
use Test;

plan 2;

use Pod::Utilities::Build;

is-deeply pod-bold("bold"), $=pod[0].contents[0].contents[0],
"Correct structure";

is-deeply pod-bold("bold").type, "B",
"Formatting code type";

=begin pod

B<bold>

=end pod

done-testing;