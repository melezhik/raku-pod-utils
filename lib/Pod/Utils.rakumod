use v6.c;

unit module Pod::Utils:ver<0.0.2>;

=begin pod

=head1 NAME

Pod::Utils - Set of helper functions to ease create new
Pods elements.

=head1 SYNOPSIS

    use Pod::Utils;

    # time to work with Pod::* elements!
    say first-subtitle($=pod[0].contents);

    =begin pod

    =SUBTITLE Some cool text

    =end pod

=head1 DESCRIPTION

Pod::Utils is a set of routines that help you to deal with Pod elements.
It lets you manipulate several kinds of Pod objects, obtain gists and modify 
headings.

=head1 AUTHORS

Alexander Mouquin <@Mouq>

Will Coleda <@coke>

Rob Hoelz <@hoelzro>

<@timo>

Moritz Lenz <@moritz>

Juan Julián <@JJ>

<@MasterDuke17>

Zoffix Znet <@zoffixznet>

Antonio <@antoniogamiz>

=head1 COPYRIGHT AND LICENSE

Copyright 2019 Perl6 team

This library is free software; you can redistribute it and/or modify
it under the Artistic License 2.0. 

=end pod

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

#| Accepts a Pod::Block and returns a concatenation of the content of all subpods
multi sub recurse-until-str(Str:D $s) is export { $s }
multi sub recurse-until-str(Pod::Block $n) is export { $n.contents>>.&recurse-until-str().join }
