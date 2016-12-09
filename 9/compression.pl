#!/usr/bin/perl

use strict;
use warnings;

open(my $fh,'<',"aoc9_input.txt") or die "Couldn't find file";
my $text = <$fh>;
chomp($text);
my $text2 = $text;
my $length = 0;

#Part I
while($text=~/(.*?)\((\d+)x(\d+)\)/){
    $length+=length($1)+$2*$3;
    #pre+3(for brackets and x) + two numbers in brackets + post
    my $cutlength = length($1)+3+length($2)+length($3)+$2;
    $text = substr $text,$cutlength;
}
$length+=length($text);
print "$length\n";

#Part II
$length=processLine($text2);
sub processLine{
    my ($line) = @_;
    my $result = 0;
    if($line=~s/(.*?)\((\d+)x(\d+)\)//x){
        my $repeat = $3;
        my $nextLine = (substr $line, 0, $2);
        $line = substr $line,$2;
        $result = length($1)+$repeat*processLine($nextLine)+processLine($line);
    }else{
        $result = length($line);
    }
    return $result;
}
print "$length\n";
