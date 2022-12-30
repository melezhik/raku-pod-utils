use v6.c;
use Test;

plan 1;

use Pod::Utils::Build;

is-deeply pod-block("1", "2"), Pod::Block::Para.new(contents => ["1", "2"]),
"Correct structure";

done-testing;
