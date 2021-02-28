#!/home/ben/software/install/bin/perl
use Z;
use JSON::Parse 'read_json';
use lib "$Bin";
use GzipCompare 'compare';
my $files = read_json ("$Bin/all-files.json");
my $n = scalar (@$files);
my @files;
for (0..10) {
    my $filen = int (rand ($n));
    push @files, $files->[$filen];
}
compare (\@files);


