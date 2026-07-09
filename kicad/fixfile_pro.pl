#!/bin/perl

use strict;

my $inData = 0;
my $braCount = 0;
my @ids = ();
my @text = ();
my $field = 0;

while(<>)
{
    if(/\"sheets\"/)
    {
        $inData = 1;
        $braCount = 1;
    }
    elsif ($inData && !$braCount)
    {
        ProcessSheets();
        $inData = 0;
        print;
    }
    elsif($inData)
    {
        $braCount++ if(/\[/);
        $braCount-- if(/\]/);
        if($braCount && /\"/)
        {
            if(!$field)
            {
                chomp;
                s/^\s+//;
                s/\s+$//;
                push @ids, $_;
                $field++;
            }
            else
            {
                chomp;
                s/^\s+//;
                s/\s+$//;
                push @text, $_;
                $field = 0;
            }
        }
    }
    elsif (!$inData)
    {
        print;
    }
    
}

    
sub ProcessSheets
{
    my $nPrinted = 0;
    my $nSheets = scalar(@ids);
    print '  "sheets": [' . "\n";
    for(my $n=0; $n<$nSheets; $n++)
    {
        if($text[$n] ne '"48V-Booster"')
        {
            if($nPrinted)
            {
                print ",\n";
            }

            print "    [\n";
            print "      $ids[$n]\n";
            print "      $text[$n]\n";
            print "    ]";
            $nPrinted++;
        }
    }
    print "\n  ],\n";
}
