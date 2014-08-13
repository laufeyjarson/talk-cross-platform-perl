#! env perl

=head1 NAME

freespace.pl - Show free space in a directory

=head1 SYNOPSIS

    freespace.pl <path>

=head1 DESCRIPTION

This script demonstrates isolating platform specific code into maintainable
sections.  It has a general script that uses a simple function to get
information about free disc space and keeps the code using it clear.

That function does the needed work to keep each platform's implementation
separate and hopefully also clear.

=cut

use strict;
use warnings;
use 5.12.0;

use Path::Class ();
use English '-no_match_vars';

die "Need a directory to test on the command line\n" unless defined $ARGV[0];

my $workdir = Path::Class::dir($ARGV[0]);

die "$workdir isn't an existing directory!\n" unless -d $workdir;

$workdir = $workdir->absolute;

my $info = get_disk_info($workdir);

say "The disk at $workdir has ", $info->{size}, " total space and ",
    $info->{free}, " free.";
say "It is ", sprintf("%02.02d", ( ($info->{used} / $info->{size}) * 100)),
    "% full";

=head2 get_disk_info()

Called with a Path::Class object containing the directory to get space
information for, returns a hashref containing information about space
available in that location.

Returns a has containing at least the following keys:

=over 4

=item mount

Where this path is mounted in the system.  The location requested will be on
this file system.

=item size

Size of the file system, in bytes.

=item used

Bytes used on the file system.

=item free

Space free on the file system, in bytes.

=back

Returns a hash ref on success.  Dies on any error.

=cut

sub get_disk_info {
    my $spacepath = shift;

    # We can be Unixy or Windowsy.
    my $dispatch = {
        darwin  => sub {
            my $path = shift;
            return _unixy_disk_info('/bin/df', '-k', "$path");
        },
        linux   => sub {
            my $path = shift;
            return _unixy_disk_info('/usr/bin/df', '-k', "$path");
        },
        MSWin32 => sub {
            my $path = shift;
            return _windowsy_disk_info($path);
        },
    };
    if (exists $dispatch->{$OSNAME}) {
        return $dispatch->{$OSNAME}->($spacepath);
    }

    die "Don't know how to get space on this platform!\n";
}

# Implement the disk info function for any unix-like system.  Should be
# called with the path to get data for, and the correct command line for df
# on that system.  Shells out to df, parses the output and returns
# the needed hash ref.

sub _unixy_disk_info {
    my @dfparts = @_;

    # Run whatever df command was passed
    open(my $df, "-|", @dfparts) or die "Can't run df: $!\n";
    my @lines = <$df>;
    close($df);

    # Parse the last line of df output for the requested location's space
    my $line = $lines[-1];
    $line =~ s/^\s+//; # Trim leading spaces
    if($line =~ /([^\s]+)\s+(\d+)\s+(\d+)\s+(\d+)\s+/) {
        return {
            mount => $1,
            size => ($2 * 1024),
            used => ($3 * 1024),
            free => ($4 * 1024),
        };
    }
    # Couldn't fathom what df said; crash!
    die "Can't parse du output!";
}

# Implements the disk info function for Windows machines.  Should be called
# with the path to get information for.  Shells out and runs wmic to access the
# Windows Management Instrumentation data about the desired volume.
# Parses the results from wmic and returns the needed hash ref.

sub _windowsy_disk_info {
    my $path = shift;

    # pushd will pushd to a drive letter.  If it's a UNC it will map it for you!
    # the cd alone will print that path
    # The wmic will get the data
    # And the popd will get rid of the share.

    my @cmdparts = (
        'pushd', "\"$path\"",
        '&&', 'cd',
        '&&', 'wmic', 'LOGICALDISK', 'Get', 'DeviceId,Freespace,Size',
        '&&', 'popd',
    );

    # ActiveState perl doesn't support the list form of pipe open, so we use backticks.
    # Escaping the path is tricky, and this is probably wrong.
    my $cmdline = join(' ', @cmdparts);
    my @lines = `$cmdline`;

    # The first line is the CWD we wanted, the rest is disk info
    my $cwd = Path::Class::dir(shift @lines);
    my $volume = $cwd->volume;

    # Search the disk info for our volume, returning it when we find it.
    foreach my $line (@lines) {
        if ($line =~ /^$volume\s+(\d+)\s+(\d+)/i) {
            return {
                mount => $volume,
                free => $1,
                size => $2,
                used => $2 - $1,
            };
        }
    }
    # Didn't find a volume!  Crash!
    die "Can't parse wmic output!";
}
