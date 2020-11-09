#!/usr/bin/env raku

#| Uses 𝜋 spigot algorithm from Stanley Rabinowitz and Stan Wagon
sub find-𝜋(:th-digit($n)) {
  # Math symbols
  my \𝑛 = $n;
  my \𝐴 = [];
  #my \𝑞 = 0;
  #my \𝑟 = 0;

  # Program variables
  my $predigit;
  my @digits;

  # Initialize: Let 𝐴 = (2,2,2,2,...,2) be an array of length ⌊10𝑛/3⌋.
  # TODO: Create custom operator for floor
  𝐴= [2 xx (10 × 𝑛 / 3).floor + 1];

  # Repeat 𝑛 times:
  for ^𝑛 {
    # Multiply by 10: Multiply each entry of A by 10.
    𝐴 .= map: * × 10;
    for 𝐴.elems ^... 2 -> \i {
      # TODO: Is there a way to remove the my declaration here?
      # Declaring these at the top caused problems because I couldn't reassign the values.
      my \𝑞 = 𝐴[i] div (2 × i - 1) × (i - 1);
      my \𝑟 = 𝐴[i] % (2 × i - 1);

      𝐴[i] = 𝑟;

      if i == 2 {
        $predigit = (𝑞 + 𝐴[i - 1]) div 10;
        𝐴[i - 1] = (𝑞 + 𝐴[i - 1]) % 10;
        @digits.push: $predigit;
      } else {
        𝐴[i - 1] += 𝑞;
      }
    }
  }

  return @digits.join;
}

say find-𝜋 :100th-digit;
