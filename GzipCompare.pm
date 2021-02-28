package GzipCompare;
require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw/compare/;
our %EXPORT_TAGS = (all => \@EXPORT_OK);
use warnings;
use strict;
use utf8;
use Carp;

use File::Slurper 'read_binary';

use Compress::Raw::Zlib ();
use Gzip::Faster ();
use Gzip::Libdeflate ();
use Gzip::Zopfli ();

sub compare
{
    my ($files) = @_;
    my $max = 10_000_000;
    my @stats;
    for my $file (@$files) {
	if (-d $file) {
	    next;
	}
	if (! -f $file) {
	    warn "No $file";
	    next;
	}
	my $size = -s $file;
	if ($size == 0) {
	    next;
	}
	if ($size > $max) {
	    warn "$file size > $max";
	    next;
	}
	my $text = read_binary ($file);
	my $gf9 = gf9 ($text);
	my $gl12 = gl12 ($text);
	my $gz = gz ($text);
	push @stats, {
	    file => $file,
	    size => $size,
	    gf9 => $gf9,
	    gl12 => $gl12,
	    gz => $gz,
	};
	print "$file: $size $gf9 $gl12 $gz\n";
    }
    return \@stats;
}

sub gf9
{
    my ($text) = @_;
    my $gf = Gzip::Faster->new ();
    $gf->level (9);
    my $out = $gf->zip ($text);
    return length ($out);
}

sub gl12
{
    my ($text) = @_;
    my $gl = Gzip::Libdeflate->new (level => 12);
    my $out = $gl->compress ($text);
    return length ($out);
}

sub gz
{
    my ($text) = @_;
    my $out = Gzip::Zopfli::ZopfliCompress ($text);
    return length ($out);
}

1;
