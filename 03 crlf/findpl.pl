#! env perl

=head1 NAME

findpl.pl - Find lines of text containing ".pl"

=head1 SYNOPSIS

    findpl.pl input.txt
    cat foo | findpl.pl

=head1 DESCRIPTION

This simple script reads lines of text and prints only those that contain ".pl".  Case is not
siginificant.  This is a trivial, contrived example.

=cut

use strict;
use warnings;

use 5.12.0;

while (my $line = <>) {
    if($line =~ /\.pl/i) {
        print $line;
    }
}
