#! /usr/bin/perl

use strict;
use warnings;

my $usage = << 'USAGE';
Usage: $0 [width height] pattern.txt
  width: cellular automata width (default 40)
  height: cellular automata height (default 40)
  pattern.txt: cellular automata patterns to be loaded
The dimension options, if given, must be both provided
USAGE

my ($width, $height) = (40, 40);
if (@ARGV==3) {
  $width = shift @ARGV;
  $height = shift @ARGV;
} elsif (@ARGV!=1) {
  die $usage;
}

my $pi = 3.1415926535897932384626433;
my $size = 5.0;
my $scale = 2.5;
my $map_x = $width/4;
my $map_y = $height/4;

my @torus;
for (my $j=0; $j<$height; ++$j) {
  for (my $i=0; $i<$width; ++$i) {
    my $circle = 2.0*$pi;
    my $y = cos($j*$circle/$height)*$scale;
    my $diameter = $size+2*sin($j*$circle/$height);
    my $x = $diameter/2*cos($i*$circle/$width)*$scale;
    my $z = $diameter/2*sin($i*$circle/$width)*$scale;
    push @{$torus[$j][$i]}, "n_${i}_${j}", $x, $y, $z, 0;
  }
}
for (my $j=$map_y; <>; ++$j){
  chomp;
  my @nodes = split(/,/);
  for (my $i=0; $i<@nodes; ++$i) {
    $torus[$j%$height][($map_x+$i)%$width][4] = $nodes[$i];
  }
}

for (@torus) {
  for (@{$_}) {
    print join(",", @{$_}), "\n";
  }
}
print "-\n";

for (my $j=0; $j<$height; ++$j) {
  for (my $i=0; $i<$width; ++$i) {
    print $torus[$j][$i][0],",",$torus[$j][($i+1)%$width][0],"\n";
    print $torus[$j][$i][0],",",$torus[($j+1)%$height][($i+1)%$width][0],"\n";
    print $torus[$j][$i][0],",",$torus[($j+1)%$height][$i][0],"\n";
    print $torus[$j][$i][0],",",$torus[($j+1)%$height][($i-1)%$width][0],"\n";
  }
}

