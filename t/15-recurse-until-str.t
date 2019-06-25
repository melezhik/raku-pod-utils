use v6.c;
use Test;

plan *;

use Pod::Utilities;

my $block         = Pod::Block::Para.new(contents => ["block"]);
my $complex-block = pod-block("one", pod-block("two"), pod-bold("three"));

is recurse-until-str("string")      , "string"      , "String not affected";
is recurse-until-str($block)        , "block"       , "Single block";
is recurse-until-str($complex-block), "onetwothree" , "Complex block";

done-testing;