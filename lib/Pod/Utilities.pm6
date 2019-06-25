use v6.c;

unit module Pod::Utilities:ver<0.0.1>;

#| Returns the first Pod::Block::Code found in an array, concatenating 
#| all lines in it. If any is found, it will return an empty string.
sub first-code-block(@pod) is export {
    @pod.first(* ~~ Pod::Block::Code).contents.grep(Str).join || "";
}

#| Creates a new Pod::Block::Named object (with :name set to "TITLE")
#| and populate it with a Pod::Block::Para containing $title.
sub pod-title($title) is export {
    Pod::Block::Named.new(
        name     => "TITLE",
        contents => Array.new(
            Pod::Block::Para.new(
                contents => [$title],
            )
        )
    );
}

#| Creates a new Pod::Block::Named object (with :name set to "pod")
#| and populate it with a title (using pod-title) and @blocks.
sub pod-with-title($title, *@blocks) is export {
    Pod::Block::Named.new(
        name     => "pod",
        contents => [
            flat pod-title($title), @blocks
        ]
    );
}

#| Creates a Pod::Block::Para object with contents set to @contents.
sub pod-block(*@contents) is export {
    Pod::Block::Para.new(:@contents);
}

#| Creates a Pod::FormattingCode (type Link) object with contents set to $text
#| and meta set to $url.
sub pod-link($text, $url) is export {
    Pod::FormattingCode.new(
        type     => 'L',
        contents => [$text],
        meta     => [$url],
    );
}

#| Creates a Pod::FormattingCode (type Bold) object with contents set to $text
sub pod-bold($text) is export {
    Pod::FormattingCode.new(
        type     => 'B',
        contents => [$text],
    );
}

#| Creates a Pod::FormattingCode (type C) object with contents set to $text
sub pod-code($text) is export {
    Pod::FormattingCode.new(
        type     => 'C',
        contents => [$text],
    );
}

#| Creates a Pod::Item object with contents set to @contents a level to $level
sub pod-item(*@contents, :$level = 1) is export {
    Pod::Item.new(
        :$level,
        :@contents,
    );
}

#| Creates a Pod::Heading object with level set $level and contents initialized
#| with a Pod::Block::Para object containing $name.
sub pod-heading($name, :$level = 1) is export {
    Pod::Heading.new(
        :$level,
        :contents[pod-block($name)],
    );
}

#| Creates a Pod::Block::Table object with the headers @headers and rows @contents. 
#| $caption is set to "".
sub pod-table(@contents, :@headers) is export {
    Pod::Block::Table.new(
        |(:@headers if @headers),
        :@contents,
        :caption("")
    );
}

#| Given an array of Pod objects, lower the level of every heading following
#| the next formula => current-level - $by + $to, where $by is the level of the
#| first heading found in the array.
sub pod-lower-headings(@content, :$to = 1) is export {
    my $by = @content.first(Pod::Heading).level;
    return @content unless $by > $to;
    my @new-content;
    for @content {
        @new-content.append: $_ ~~ Pod::Heading
            ?? Pod::Heading.new: :level(.level - $by + $to) :contents[.contents]
            !! $_;
    }
    @new-content;
}

# vim: expandtab shiftwidth=4 ft=perl6
