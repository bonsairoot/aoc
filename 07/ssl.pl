#!/usr/bin/perl

use strict;
use warnings;

my $filename = shift;
my $counter = 0;

open(my $fh, '<', $filename) or die "Couldn't find file $filename";
while(my $ip = <$fh>){
    my @hypher = $ip =~ /\[([^\]]+)]/g;
    $ip =~ s/\[[^\]]*\]//g;
    for(@hypher){
        my $comined = $_.";".$ip;
        if($comined=~ /.*(\w)(\w)\g1.*;.*\g2\g1\g2.*/ && $1 ne $2){
            $counter++;
            last;
        }
    }
}
print $counter,"\n";
