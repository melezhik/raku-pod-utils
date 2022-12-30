use v6.c;
use Test;

plan 2;

use Pod::Utils::Build;

my $paragraph = $=pod[0].contents[1];

is-deeply pod-with-title("title", [$paragraph]), $=pod.first,
"Correct structure";

$=pod[0].contents.pop;

is-deeply pod-with-title("title", []), $=pod.first,
"Empty blocks";


=begin pod

=TITLE title

Hey, I'm a pod.

=end pod

done-testing;
