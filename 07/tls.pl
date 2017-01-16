#!/usr/bin/perl

use strict;
use warnings;

my $filename = shift;
my $counter = 0;

open(my $fh, '<', $filename) or die "Couldn't find file $filename";

while(my $ip = <$fh>){
    if($ip !~ /\[\w*(\w)(\w)\g2\g1\w*\]/){
        $counter++ if($ip =~ /(\w)(\w)\g2\g1/ && $1 ne $2);
    }
}
print $counter,"\n";
