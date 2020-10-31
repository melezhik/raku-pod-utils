* pod-bold and code should use a single name, with type as optional. Maybe pod-link too.

* Some refactoring would be useful. pod-lower-headings could be done without a for, for instance.

* We should check where these routines are used for and take them there. I don't know if textify-guts, for instance, is used outside Perl6::Documentable.

* Does recurse-until-str does something besides converting into strings?