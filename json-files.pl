#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use utf8;
use FindBin '$Bin';
use lib "$Bin";
use GzipCompare;
my ($files, $n) = readfiles ($Bin);
my $count = 0;
my $maxloop = 100000;
my @files;
while (@files < 10) {
    $count++;
    if ($count > $maxloop) {
	die "Max $maxloop $count";
    }
    my $file = randomfile ($files, $n);
    if ($file !~ m!\.json$!) {
	next;
    }
    if (-s $file < 1000) {
	next;
    }
    if ($file =~ m!META!) {
	next;
    }
    push @files, $file;
}
compare (\@files);

