#!/usr/bin/env raku

sub spigot($n) {
  my @a = 2 xx (10 * $n / 3).floor + 1;

  for ^$n {
    @a = @a.map: * * 10;
    for @a.elems ^... 2 -> $i {
      my $predigit;
      my $r = @a[$i] % (2 * $i - 1);
      my $q = @a[$i] div (2 * $i - 1) * ($i - 1);

      say "For $i: r is $r, q is $q";
      
      @a[$i] = $r;

      if $i == 2 {
        $predigit = $q div 10;
        say $predigit;
        say @a;
      } else {
        @a[$i - 1] += $q;
      }
    }
  }
}

spigot(4);
