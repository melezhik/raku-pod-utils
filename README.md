# NAME [![Test-install distro](https://github.com/JJ/raku-pod-utils/actions/workflows/test.yaml/badge.svg)](https://github.com/JJ/raku-pod-utils/actions/workflows/test.yaml)

Pod::Utils - Set of helper functions to ease working with Pods!

# SYNOPSIS

```raku
    use Pod::Utils;

    # time to work with Pod::* elements!
    say first-subtitle($=pod[0].contents);

    =begin pod

    =SUBTITLE Some cool text

    =end pod
```

# DESCRIPTION

Pod::Utils is a set of routines that help you to deal with Pod elements.
It lets you manipulate several kinds of Pod objects, obtain gists and modify
headings.

### sub first-code-block

```perl6
sub first-code-block (
    Array @pod
) returns Str;
```

Returns the first `Pod::Block::Code` found in an array, concatenating all lines in it.
If none is found, it will return an empty string.

Example:

```perl6
=begin pod
=begin code

    say "some code";
    say "more code";

=end code
=end pod

first-code-block($=pod[0].contents)

# OUTPUT «say "some code";␤say "more code";␤»
```

### sub first-title

```perl6
sub first-title (
    Array @pod
) returns Pod::Block::Named;
```

Returns the first `=TITLE` element found in `@pods`.

Example:

```perl6
=begin pod

=TITLE title

=end pod

first-title($=pod[0].contents)

# OUTPUT equivalent to:

=TITLE title

```

### sub first-subtitle

```perl6
sub first-subtitle (
    Array @pod
) returns Pod::Block::Named;
```

Returns the first `=SUBTITLE` element found in `@pods`.

Example:

```perl6
=begin pod

=subTITLE subtitle

=end pod

first-subtitle($=pod[0].contents)

# OUTPUT equivalent to:

=SUBTITLE subtitle

```

### multi sub textify-guts

```perl6
multi textify-guts (Any:U,       ) return Str;
multi textify-guts (Str:D      \v) return Str;
multi textify-guts (List:D     \v) return Str;
multi textify-guts (Pod::Block \v) return Str;
```

Converts lists of `Pod::Block::*` objects and `Pod::Block` objects to strings.

Example:

```perl6
my $block = Pod::Block::Para.new(contents => ["block"]);
say textify-guts($block); # OUTPUT «block␤»
say textify-guts([$block, $block]); # OUTPUT «block block␤»
```

### multi sub recurse-until-str

```perl6
multi sub recurse-until-str(Str:D $s)      return Str;
multi sub recurse-until-str(Pod::Block $n) return Str;

```

Accepts a `Pod::Block::*` object and returns a concatenation of all subpods content.

Example:

```perl6
my $block         = Pod::Block::Para.new(contents => ["block"]);
my $complex-block = pod-block("one", pod-block("two"), pod-bold("three"));
say recurse-until-str($block); # OUTPUT «block␤»
say recurse-until-str($complex-block); # OUTPUT «onetwothree␤»
```

# Pod::Utils::Build

# SYNOPSIS

```perl6
    use Pod::Utils::Build;

    # time to build Pod::* elements!
    say pod-bold("bold text");
```

# DESCRIPTION

Pod::Utils::Build is a set of routines that help you to create new
Pod elements.

### sub pod-title

```perl6
sub pod-title (
    Str $title,
) returns Pod::Block::Named;
```

Creates a new `Pod::Block::Named` object (with `:name` set to `"TITLE"`)
and populates it with a `Pod::Block::Para` containing `$title`.

Example:

```perl6

pod-title("title");

# OUTPUT Equivalent to:

=begind pod

=TITLE title

=end pod
```

### sub pod-with-title

```perl6
sub pod-with-title (
    Str $title,
    Array @blocks
) returns Pod::Block::Named;
```

Creates a new `Pod::Block::Named` object (with `:name` set to "pod")
and populate it with a title (using `pod-title`) and `@blocks`.

Example:

```perl6

=begind pod

Normal paragraph

=end pod

pod-with-title("title", $=pod.first.contents[0]);

# OUTPUT Equivalent to:

=beging pod

=TITLE title

Normal paragraph

=end pod
```

### sub pod-block

```perl6
sub pod-block (
    Array *@contents
) returns Pod::Block::Para;
```

Creates a `Pod::Block::Para` with contents set to `@contents`.

Example:

```perl6


say pod-block("title", Pod::Block::Para.new(contents => ["paragraph"]));

# OUTPUT

Pod::Block::Para
  title
  Pod::Block::Para
    paragraph

```

### sub pod-link

```perl6
sub pod-link (
    Str $text,
    Str $url
) returns Pod::FormattingCode;
```

Creates a `Pod::FormattingCode` (type Link) with contents set to `$text`.
and meta set to `$url`.

Example:

```perl6

pod-link("text","url");

# OUTPUT Equivalent to:

L<text|url>
```

### sub pod-bold

```perl6
sub pod-bold (
    Str $text,
) returns Pod::FormattingCode;
```

Creates a `Pod::FormattingCode` (type B) with contents set to `$text`.

Example:

```perl6

pod-bold("text");

# OUTPUT Equivalent to:

B<text>
```

### sub pod-code

```perl6
sub pod-code (
    Str $text,
) returns Pod::FormattingCode;
```

Creates a `Pod::FormattingCode` (type C) with contents set to `$text`.

Example:

```perl6

pod-code("text");

# OUTPUT Equivalent to:

C<text>
```

### sub pod-item

```perl6
sub pod-item (
    Array *@contents ,
    Int   :$level = 1,
) returns Pod::Item;
```

Creates a `Pod::Item` object with contents set to `@contents` and level to `$level`.

Example:

```perl6

pod-item(pod-block("item"), level => 1);

# OUTPUT Equivalent to:

=item item

```

### sub pod-heading

```perl6
sub pod-heading (
    Str   $name,
    Int   :$level = 1,
) returns Pod::Heading;
```

Creates a `Pod::Heading` object with level set `$level` and contents initialized
with a `Pod::Block::Para` object containing `$name`.

Example:

```perl6

pod-heading("heading", level => 1);

# OUTPUT Equivalent to:

=head1 heading

```

### sub pod-table

```perl6
sub pod-table (
    Array @contents,
    Array :@headers,
) returns Pod::Block::Table;
```

Creates a `Pod::Block::Table` object with the headers `@headers` and rows `@contents`.
`$caption` is set to `""`.
Example:

```perl6

pod-table([["col1", "col2"],], headers => ["h1", "h2"]);

# OUTPUT Equivalent to:

=begin table

h1   | h2
============
col1 | col2

=end table

```

### sub pod-lower-headings

```perl6
sub pod-lower-headings (
    Array @content,
    Int   :$to,
) returns Array;
```

Given an array of Pod objects, lower the level of every heading following
the next formula => `current-level - $by + $to`, where `$by` is the level of the
first heading found in the array.

Example:

```perl6

my @contents = [
    pod-heading("head", level => 2),
    pod-heading("head", level => 3)
];

pod-lower-headings(@contents)

# OUTPUT Equivalent to:

=head1 head

=head2 head

```

# AUTHORS

Alexander Mouquin <@Mouq>

Will Coleda <@coke>

Rob Hoelz <@hoelzro>

<@timo>

Moritz Lenz <@moritz>

Juan Julián <@JJ>

<@MasterDuke17>

Zoffix Znet <@zoffixznet>

Antonio <@antoniogamiz>

# COPYRIGHT AND LICENSE

Copyright 2019 Perl 6 team

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.
