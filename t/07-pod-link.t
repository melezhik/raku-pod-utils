use v6.c;
use Test;

plan 2;

use Pod::Utils::Build;

is-deeply pod-link("nometa", "meta"), $=pod[0].contents[0].contents[0],
"Correct structure";

is-deeply pod-link("nometa", "meta").type, "L",
"Formatting code type";


=begin pod

L<nometa|meta>

=end pod

done-testing;
