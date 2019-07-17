use v6.c;
use Test;

plan 1;

use Pod::Utilities::Build;

my @contents = [
    pod-heading("head", level => 2),
    pod-heading("head", level => 3)
];

is-deeply pod-lower-headings(@contents), $=pod[0].contents,
"Correct structure";

=begin pod

=head1 head

=head2 head

=end pod
done-testing;