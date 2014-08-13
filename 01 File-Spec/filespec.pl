#!env perl

=head1 NAME

filespec.pl - Demonstrate simple use of File::Spec

=head1 DESCRIPTION

This simple script exercises some of the features of File::Spec and shows how they can be
used to manage paths without ever building them as strings.

=cut

use strict;
use warnings;

use 5.12.0;

use File::Spec;

my $curdir = File::Spec->curdir();
say "We are in $curdir";

$curdir = File::Spec->rel2abs($curdir);
say "That resolves to $curdir";

my ( $volume, $directories, $file ) =
  File::Spec->splitpath( $curdir, 'no_file' );

say "That breaks down to:";
say "vol:\t$volume";
say "dir:\t$directories";
say "file:\t$file";

my @dirlist = File::Spec->splitdir($directories);

say "The directories are:";
foreach my $d (@dirlist) {
    say "\t$d";
}

push @dirlist, 'new', 'subdir', 'with', 'spaces in it';

my $newpath =
  File::Spec->catpath( $volume, File::Spec->catdir(@dirlist), 'temp_file.txt' );

say "We built a new, exciting path: $newpath";
