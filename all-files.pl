#!/home/ben/software/install/bin/perl
use Z;
use Trav::Dir;
use JSON::Create 'write_json';
my $o = Trav::Dir->new (
    no_dir => 1,
    no_trav => qr!/(?:\.git)$!,
    rejfile => qr!\.gz$!,
);
my @files;
$o->find_files ('/home/ben/projects', \@files);
write_json ("$Bin/all-files.json", \@files);


