#!/usr/bin/perl

use strict;
use warnings;
use ntheory qw/chinese/;
use List::MoreUtils qw(zip);
use List::Util qw(pairs);

my $PART = 1; # Change to 2 for part 2
my (@size, @init);
open(my $fh,'<',"aoc15_input.txt") or die "Couldn't open input file!";
while(<$fh>){
    if($_ =~ /Disc #(\d+) has (\d+).* position (\d+)\./){
        $size[$1-1] = $2;
        $init[$1-1] = $3;
    }
}
if($PART==2){
    push @init,0;
    push @size,11;
}
my $length = @init;
my @diff = map{-$init[$_]-(1..$length)[$_]}(0..$length-1);
my @zipped = zip(@diff,@size);
print chinese(pairs(@zipped)),"\n";
