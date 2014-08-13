#!env perl

=head1 NAME

pathclass.pl - Demonstrate simple use of Path::Class

=head1 DESCRIPTION

This simple script exercises some of the features of Path::Class and shows how they can be
used to manage paths without ever building them as strings.

=cut

use strict;
use warnings;

use 5.12.0;

use Path::Class ();

my $curdir = Path::Class::dir();
say "We are in $curdir";

$curdir = $curdir->absolute($curdir);
say "That resolves to $curdir";
say "On volume: ", $curdir->volume;

my @dirlist = $curdir->dir_list;

say "\nThe directories are:";
foreach my $d (@dirlist) {
    say "\t$d";
}

push @dirlist, 'new', 'subdir', 'with', 'spaces in it';

my $newpath = $curdir->file('new', 'subdir', 'with', 'spaces in it',
    'temp_file.txt');

say "\nWe built a new, exciting path: $newpath";

say "\nOn Unixish systems, that is ", $newpath->as_foreign("Unix");
say "\nOn Windowsy systems, that is ", $newpath->as_foreign("Win32");
say "\nOn old Mac systems, that is ", $newpath->as_foreign("Mac");
