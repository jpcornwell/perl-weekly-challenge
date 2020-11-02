#!/usr/bin/env raku

my $input;
my $temp;

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

# Using built-in functionality
# $input.base(35);
# $input.base(35).parse-base(35);

sub to-base35(Int $input --> Str) {
  $temp = $input;
  my $power = 0;
  $power++ while ($temp ÷= 35) ≥ 1;
  
  $temp = $input;
  my $base35 = '';
  while $power >= 0 {
    my $val = $temp div (35 ** $power);
    my $char = $val < 10 ?? $val.Str !! ($val + 55).chr;
    $base35 ~= $char;
    $temp -= $val × (35 ** $power);
    $power--;
  }
  return $base35;
}

sub from-base35(Str $input --> Int) {
  my $power = 0;
  my $base10 = 0;
  for $input.uc.comb.reverse {
    if $_ ~~ '0'..'9' { $base10 += (.Int     ) × (35 ** $power) }
    if $_ ~~ 'A'..'Y' { $base10 += (.ord - 55) × (35 ** $power) }
    $power++;
  }
  return $base10;
}




# Solutions after seeing some others on the internet

my @chars = (0..9, 'A'..'Y').flat;
my %lookup = @chars.map: { $_ => $++ };

sub to-base35-A(Int $input is copy --> Str) {
  my @results;
  while ($input) {
    @results.push($input % 35);
    $input div= 35;
  }
  return @results.reverse.map( { @chars[$_] } ).join;

  # Could also do this instead
  return $input.polymod(35 xx ∞).reverse.map( { @chars[$_] } ).join;
}

sub from-base35-A(Str $input --> Int) {
  my $power = 0;
  my $base10 = 0;
  for $input.uc.comb.reverse -> $char {
    $base10 += %lookup{$char} × (35 ** $power++);
  }
  return $base10;

  # Could also do this instead
  return $input.uc.comb.reverse.map( { %lookup{$_} × (35 ** $++) } ).sum;
}

say to-base35-A($input);
say from-base35-A(to-base35($input));

