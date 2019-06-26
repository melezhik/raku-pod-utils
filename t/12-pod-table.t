use v6.c;
use Test;

plan 1;

use Pod::Utilities::Build;

is-deeply pod-table([["col1", "col2"],], headers => ["h1","h2"]), $=pod[0].contents[0],
"Correct structure";

=begin pod
=begin table

h1   | h2
============
col1 | col2

=end table
=end pod
done-testing;