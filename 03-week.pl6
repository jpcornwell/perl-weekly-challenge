#!/usr/bin/env perl6

say 'Challenge 1:';

# Create a script to generate 5-smooth numbers, whose prime divisors are less
# or equal to 5. They are also called Hamming/Regular/Ugly numbers. For more
# information, please check this wikipedia.

my @hamming-numbers = lazy gather {
  my $last-val = 1;
  my @incoming-vals;
  loop {
    take $last-val;
    @incoming-vals.append: $last-val <<*<< (2, 3, 5);
    @incoming-vals .= sort;
    shift @incoming-vals until @incoming-vals.head != $last-val;
    $last-val = @incoming-vals.shift;
  }
};

for 1..50 -> $i {
  say "$i \t @hamming-numbers[$i - 1]";
}

say 'Challenge 2:';

# Create a script that generates Pascal Triangle. Accept number of rows from
# the command line. The Pascal Triangle should have at least 3 rows. For more
# information about Pascal Triangle, check this wikipedia page.

# Simple solution but slow.
sub pascal-number-recursive(Int $row, Int $col where $col <= $row) {
    return 1 if $row == (0|1);
    return 1 if $col == 0;
    return 1 if $col == $row;

    return pascal-number($row - 1, $col - 1) + pascal-number($row - 1, $col);
}

# Mathy solution that runs faster.
sub pascal-number(Int $row, Int $col where $col <= $row) {
    sub postfix:<!>(Int $x where $x >= 0) { [*] 1..$x };

    return $row! / (($row-$col)! * $col!);
}

my $row-count = 9;

say 'Plain triangle:';
print-plain($row-count);

say();
say 'Pretty triangle:';
print-pretty($row-count);

sub print-plain(Int $row-count) {
    for 0 .. $row-count -> $row {
        for 0 .. $row -> $col {
            print "{ pascal-number($row, $col) } \t";
        }
        say();
    }
}

# Good enough for this challenge. For now I want to focus on quantity of
# challenges as opposed to quality, and one could spend a LOT of effort to
# make the formatting perfect. Some ideas to improve are as follows.
#
# Simply make the spacing constant given a number of rows. For example, rows <=
# 10 could have a spacing of 2. Rows <= 15 have a spacing of 3, etc. This
# would probably be the simplest solution that still looks nice.
#
# Pascal's Triangle will naturally create columns of numbers. For example,
# the very last row will have numbers in columns 0, 2, 4, 6, 8, etc. The
# 2nd to last row will have numbers in columns 1, 3, 5, 7, etc. The next row
# will then have numbers in columns 2, 4, 6, etc. One could determine the
# position of every column of the triangle based on the last two rows. We'll
# call these the "print columns". One can then use a formula to determine
# what print column a number belongs in based on it's row and position within
# that row. We could play with variable spacing between print columns. Numbers
# near the center will contain more digits, so they might have smaller spaces
# between. Simply print the rest of the triangle now based on the positions
# of the print columns. The numbers will always get smaller as you go up the
# triangle, but you might still play with alignment of the numbers. For example
# a print column may have a width of 6 digits, but a number further up only has
# 3 digits. That number could simply start at the beginning position of the
# print column, or you could actually align it so maybe the last digit of the
# number resides at the end of the print column. You could adjust alignment
# based on if it is in the center of the triangle, or left or right of the
# center. Finally, one may make a special case for the edges of the triangle.
# In order to maintain a nicely shaped outline, those numbers (all the 1s) may
# be aligned so that they are always equidistant apart. This is very possibly
# overkill though.
sub print-pretty(Int $row-count) {
    my @triangle;
    for 0 .. $row-count -> $row {
        my @row;
        for 0 .. $row -> $col {
            @row.push(pascal-number($row, $col));
        }
        @triangle.push(@row);
    }

    for @triangle.kv -> $index, @row {
        say ' ' x 2 * (@triangle.elems - $index) ~ @row.join('   ');
    }
}
