use v6.c;
use Test;

plan 1;

use Pod::Utilities::Build;

is-deeply pod-title("title"), $=pod[0].contents[0], "Correct structure";

=begin pod

=TITLE title

=end pod

done-testing;