#! env perl

=head1 NAME

rightcp.pl - A better way to write a copy tool!

=head1 SYNOPSIS

    rightcp.pl source-file destination-file

=head1 DESCRIPTION

This simpler script copies a file from one path to another.  It even goes on to verify the copy
worked!

This is how I should have done it in the first place.

Call it with an input file and the desired output file, and it will copy one to to the other.
It won't overwrite existing files.

=cut

use strict;
use warnings;

use 5.12.0;

use Path::Class ();
use File::Copy ();
use File::Compare ();

my $source_name = $ARGV[0];
my $dest_name = $ARGV[1];

die "Usage: $0 source destination\n" unless $source_name and $dest_name;

$source_name = Path::Class::file($source_name);
$dest_name = Path::Class::file($dest_name);

die "$0: $source_name must exist to copy it!\n" unless -e $source_name;

die "$0: $source_name must be a normal file!\n" unless -e $source_name;

die "$0: $dest_name already exists; won't overwrite\n" if -e $dest_name;

File::Copy::copy($source_name, $dest_name)
    or die "Couldn't copy $source_name to $dest_name: $@\n";

if(File::Compare::compare($source_name, $dest_name) != 0) {
    die "Files $source_name and $dest_name don't match!\n";
}
