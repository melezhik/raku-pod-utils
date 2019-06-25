use v6.c;
use Test;

plan *;

use Pod::Utilities;

my $block = Pod::Block::Para.new(contents => ["block"]);

is textify-guts(Any)             , ""           , "Any returns empty str";
is textify-guts("string")        , "string"     , "String not affected";
is textify-guts($block)          , "block"      , "Single block element";
is textify-guts([$block, $block]), "block block", "List of elements"; 

done-testing;