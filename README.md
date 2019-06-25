[![Build Status](https://travis-ci.org/antoniogamiz/Pod-Utilities.svg?branch=master)](https://travis-ci.org/antoniogamiz/Pod-Utilities)

# NAME

Pod::Utilities - Set of helper functions to ease working with Pods!

# SYNOPSIS

```perl6
use Pod::Utilities;
```

# DESCRIPTION

Pod::Utilities is a set of tools to deal with Pod elements. It lets you create several Pod objects, obtain gists and modify headings.

### sub first-code-block

```perl6
sub first-code-block (
    Array @pod
) returns Str;
```

Returns the first Pod::Block::Code found in an array, concatenating all lines in it.
If any is found, it will return an empty string.

Example:

```perl6
=being pod
    say "some code";
    say "more code";
=end pod

first-code-block($=pod[0].contents)

# OUTPUT «say "some code";␤say "more code";␤»
```

# AUTHOR

Alexander Mouquin <@Mouq>

Will Coleda <@coke>

Rob Hoelz <@hoelzro>

<@timo>

Moritz Lenz <@moritz>

Juan Julian <@JJ>

<@MasterDuke17>

Zoffix Znet <@zoffixznet>

Antonio <antoniogamiz10@gmail.com>

# COPYRIGHT AND LICENSE

Copyright 2019 Antonio

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.
