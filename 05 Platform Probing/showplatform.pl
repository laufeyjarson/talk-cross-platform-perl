#! env perl

=head1 NAME

showplatform.pl - Display information about the current platform.

=head1 SYNOPSIS

    showplatform.pl

=head1 DESCRIPTION

This simply displays some of the information Perl has about the running
system, to demonstrate some of the information available from Perl itself,
and how easy that is to access.

=cut

use strict;
use warnings;

use 5.12.0;
use English '-no_match_vars';
use Config;

say "This script: $PROGRAM_NAME";
say "Running on: $OSNAME";
say "Using Perl version: $PERL_VERSION";
say "From Perl $EXECUTABLE_NAME";

say "Detailed config data:";
say "Get host name with: ", $Config{aphostname};
say "Binary compatible with Perl ", $Config{api_versionstring};
say "Byte order is ", $Config{byteorder};
