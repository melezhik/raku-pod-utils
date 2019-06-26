use v6.c;

unit module Pod::Utilities:ver<0.0.1>;

#| Returns the first Pod::Block::Code found in an array, concatenating 
#| all lines in it. If none is found, it will return an empty string.
sub first-code-block(@pod) is export {
    @pod.first(* ~~ Pod::Block::Code).contents.grep(Str).join || "";
}

#| Returns the text in the first =TITLE found in @pod.
sub first-title(@pod) is export {
    @pod.first((* ~~ Pod::Block::Named and *.name eq "TITLE"));
}

#| Returns the text in the first =SUBTITLE found in @pod.
sub first-subtitle(@pod) is export {
    @pod.first((* ~~ Pod::Block::Named and *.name eq "SUBTITLE"));    
}

#| Converts Lists of Pod::Blocks to Strings.
multi textify-guts (Any:U,       ) is export { '' }
multi textify-guts (Str:D      \v) is export { v }
multi textify-guts (List:D     \v) is export { v».&textify-guts.Str }
multi textify-guts (Pod::Block \v) is export {
    # core module
    use Pod::To::Text;
    pod2text v;
}

#| Accepts a Pod::Block and returns a concatenation of all subpods content
multi sub recurse-until-str(Str:D $s) is export { $s }
multi sub recurse-until-str(Pod::Block $n) is export { $n.contents>>.&recurse-until-str().join }

# vim: expandtab shiftwidth=4 ft=perl6
