#!/usr/bin/env raku

# This actually slows the program a lot. First just defining it slows it down,
# and then actually using it versus (<math>).floor slows it further. Went from
# .7 seconds to 1.9 seconds.
sub circumfix:<⌊ ⌋>($x) { $x.floor }

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
  𝐴= [2 xx ⌊10 × 𝑛 / 3⌋ + 1];

  # Repeat 𝑛 times:
  for ^𝑛 {
    # Multiply by 10: Multiply each entry of A by 10.
    𝐴 .= map: * × 10;
    for 𝐴.elems ^... 2 -> \𝑖 {
      # TODO: Is there a way to remove the my declaration here?
      # Declaring these at the top caused problems because I couldn't reassign the values.
      my \𝑞 = 𝐴[𝑖] div (2 × 𝑖 - 1) × (𝑖 - 1);
      my \𝑟 = 𝐴[𝑖] % (2 × 𝑖- 1);

      𝐴[𝑖] = 𝑟;

      if 𝑖 == 2 {
        $predigit = (𝑞 + 𝐴[𝑖 - 1]) div 10;
        𝐴[𝑖 - 1] = (𝑞 + 𝐴[𝑖 - 1]) % 10;
        @digits.push: $predigit;
      } else {
        𝐴[𝑖 - 1] += 𝑞;
      }
    }
  }

  return @digits.join;
}

say find-𝜋 :100th-digit;
