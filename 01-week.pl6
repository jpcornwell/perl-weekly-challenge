#!/usr/bin/env perl6

my $input;
my $answer;

say 'Challenge 1:';
#
# Write a script to replace the character ‘e’ with ‘E’ in the string ‘Perl
# Weekly Challenge’. Also print the number of times the character ‘e’ is found
# in the string.

$input = 'Perl Weekly Challenge';
say $input.subst('e', 'E', :g);
say $input.comb('e').elems;


say 'Challenge 2:';
#
# Write a one-liner to solve the FizzBuzz problem and print the numbers 1
# through 20. However, any number divisible by 3 should be replaced by the word
# ‘fizz’ and any divisible by 5 by the word ‘buzz’. Those numbers that are both
# divisible by 3 and 5 become ‘fizzbuzz’.

$input = 1..20;

$answer = $input.map: { $^n %% (3 & 5) ?? 'FizzBuzz'   !!   $^n %% 3 ?? 'Fizz'   !!   $^n %% 5 ?? 'Buzz'   !!   $^n };
$answer = $input.map: sub { return 'FizzBuzz' if $^n %% (3 & 5); return 'Fizz' if $^n %% 3; return 'Buzz' if $^n %% 5; return $^n }
$answer = $input.map: sub { my $text = ''; $text ~= 'Fizz' if $^n %% 3; $text ~= 'Buzz' if $^n %% 5; return $text || $^n }

say $answer
