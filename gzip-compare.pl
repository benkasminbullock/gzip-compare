#!/home/ben/software/install/bin/perl
use Z;
use lib "$Bin";
use GzipCompare 'compare';
compare (\@ARGV);

