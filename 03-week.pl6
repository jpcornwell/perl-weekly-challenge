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
    @incoming-vals.append: $last-val X* (2, 3, 5);
    @incoming-vals .= sort;
    shift @incoming-vals until @incoming-vals.head != $last-val;
    $last-val = @incoming-vals.shift;
  }
};

for 1..50 -> $index {
  say "$index \t @hamming-numbers[$index - 1]";
}
