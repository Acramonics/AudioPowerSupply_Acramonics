#!/bin/perl

use strict;

my $inData = 0;
my $nPar   = 0;

while(<>)
{
    if(/\(sheet\s*$/)
    {
        $inData = 1;
        $nPar   = 1;
    }
    elsif($inData)
    {
        $nPar += CountPar($_);
        $inData = 0 if($nPar == 0);
    }
    else # !$inData
    {
        print;
    }
}

sub CountPar
{
    my ($string) = @_;
    
    my $copy   = $string;
    my $nOpen  = $copy =~ tr/\(//;
    my $nClose = $copy =~ tr/\)//;

    return($nOpen - $nClose);
}
