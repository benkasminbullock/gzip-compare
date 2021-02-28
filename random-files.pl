#!/home/ben/software/install/bin/perl
use Z;
use JSON::Parse 'read_json';
use lib "$Bin";
use GzipCompare;
my ($files, $n) = readfiles ();
my @rfiles;
for (0..10) {
    push @rfiles, randomfile ($files, $n);
}
compare (\@rfiles);
exit;
