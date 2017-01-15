#!/usr/bin/perl

use strict;
use warnings;
use Digest::MD5 qw(md5_hex);

my $PART = 1; # Change to 2 for Part 2

my $length = $PART==1 ? 1 : 2017;
my $salt = "yjdafjpo";
my $index = 0;
my $keynumber = 0;

while($keynumber<64){
    my $hash = get_hash($salt.$index);
    if($hash=~/(.)\1\1/){
        my $second_condition = $1x5;
        for(1..999){
            if(index(get_hash($salt.($index+$_)),$second_condition)!=-1){
                $keynumber++;
                last;
            }
        }
    }
    $index++;
}
print $index-1,"\n";

sub get_hash{
    my ($input) = @_;
    $input = lc md5_hex($input) for 1..$length;
    return $input;
}
