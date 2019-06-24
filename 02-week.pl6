#!/usr/bin/env perl6

my $input;

say 'Challenge 1:';

# Write a script or one-liner to remove leading zeros from positive numbers.

$input = '0042';
say ~+$input;

say 'Challenge 2:';

# Write a script that can convert integers to and from a base35 representation,
# using the characters 0-9 and A-Y. Dave Jacoby came up with nice description
# about base35, in case you needed some background.
# (https://gist.github.com/jacoby/764bb4e8a5d3a819b5fbfa497fcb3454)

$input = 4242;
say $input.base(35);
say $input.base(35).parse-base(35);
