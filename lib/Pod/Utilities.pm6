use v6.c;

unit module Pod::Utilities:ver<0.0.1>;

sub pod-gist(Pod::Block $pod, $level = 0) is export {
    my $leading = ' ' x $level;
    my %confs;
    my @chunks;
    for <config name level caption type> {
        my $thing = $pod.?"$_"();
        if $thing {
            %confs{$_} = $thing ~~ Iterable ?? $thing.perl !! $thing.Str;
        }
    }
    @chunks = $leading, $pod.^name, (%confs.perl if %confs), "\n";
    for $pod.contents.list -> $c {
        if $c ~~ Pod::Block {
            @chunks.append: pod-gist($c, $level + 2);
        }
        elsif $c ~~ Str {
            @chunks.append: $c.indent($level + 2), "\n";
        } elsif $c ~~ Positional {
            @chunks.append: $c.map: {
                if $_ ~~ Pod::Block {
                    *.&pod-gist
                } elsif $_ ~~ Str {
                    $_
                }
            }
        }
    }
    @chunks.join;
}

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

sub pod-block(*@contents) is export {
    Pod::Block::Para.new(:@contents);
}

sub pod-link($text, $url) is export {
    Pod::FormattingCode.new(
        type     => 'L',
        contents => [$text],
        meta     => [$url],
    );
}

sub pod-bold($text) is export {
    Pod::FormattingCode.new(
        type     => 'B',
        contents => [$text],
    );
}

sub pod-code($text) is export {
    Pod::FormattingCode.new(
        type     => 'C',
        contents => [$text],
    );
}

sub pod-item(*@contents, :$level = 1) is export {
    Pod::Item.new(
        :$level,
        :@contents,
    );
}

sub pod-heading($name, :$level = 1) is export {
    Pod::Heading.new(
        :$level,
        :contents[pod-block($name)],
    );
}

sub pod-table(@contents, :@headers) is export {
    Pod::Block::Table.new(
        |(:@headers if @headers),
        :@contents
    );
}

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
