#!/usr/bin/perl

use strict;
use warnings;

open(my $fh,'<',"aoc9_input.txt") or die "Couldn't find file";
my $text = <$fh>;
chomp($text);
my $length = 0;

while($text=~/(.*?)\((\d+)x(\d+)\)/){
    $length+=length($1)+$2*$3;
    #pre+3(for brackets and x) + two numbers in brackets + post
    my $cutlength = length($1)+3+length($2)+length($3)+$2;
    print "$2,$3,$cutlength\n";
    $text = substr $text,$cutlength;
}
$length+=length($text);
print "$length\n";

#part II
$length = processLine("X(8x2)(3x3)ABCY");
sub processLine{
    my ($line) = @_;
    my $length = 0;
    while($line=~/(.*?)\((\d+)x(\d+)\)/){
        print "$line\n";
        my $index = length($1)+3+length($2)+length($3);
        my $nextLine = (substr $line, $index, $2)x$3;
        my $cutlength = length($1)+3+length($2)+length($3)+$2;
        $length+=length($1)+processLine($nextLine);
        $line = substr $line,$cutlength;
    }
    return $length;
}

print "$length\n";
