#! /usr/bin/perl

use strict;
use warnings;

my $id=0;
my $x=0; 
my $y=0;

my @nodes;

while(<>){
    chomp;
    @nodes = split(/,/);
    $x=0;
    foreach my $state (@nodes){
	print "n".($id++).",$state,".($x++).",".($y*-1)."\n";
    }
    $y++;
}
print "-\n";
my $i; my $j;
for($i=0; $i<$y; $i++){
    for($j=1; $j<$x; $j++){
	print "n".($i*$x+$j-1).",n".($i*$x+$j)."\n"; # -
	if(($i*$x+$j-1)-($x)>=0){
	    print "n".($i*$x+$j-1-$x).",n".($i*$x+$j-1)."\n"; # |
	    print "n".($i*$x+$j-$x).",n".($i*$x+$j-1)."\n";   # /
	    if($j>0){
		print "n".($i*$x+$j-1-$x).",n".($i*$x+$j)."\n"; # \
	    }
	}
    }
    if(($i*$x+$j-1)-($x)>=0){
	print "n".($i*$x+$j-1-$x).",n".($i*$x+$j-1)."\n"; # | last
    }
} 

for(my $i=0; $i<$x; $i++){
    for(my $j=1; $j<$y; $j++){
	print "n".($i*$y+$j-1).",n".($i*$y+$j)."\n";
    }
} 
