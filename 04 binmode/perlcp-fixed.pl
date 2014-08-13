#! env perl

=head1 NAME

perlcp-fixed.pl - Overly simplistic file copy tool!

=head1 SYNOPSIS

    perlcp-fixed.pl source-file destination-file

=head1 DESCRIPTION

This simple script copies a file from one path to another.  It even goes on to verify the copy
worked!

All fixed!

Call it with an input file and the desired output file, and it will copy one to to the other.
It won't overwrite existing files.

=cut

use strict;
use warnings;

use 5.12.0;

use Path::Class ();

my $source_name = $ARGV[0];
my $dest_name = $ARGV[1];

die "Usage: $0 source destination\n" unless $source_name and $dest_name;

$source_name = Path::Class::file($source_name);
$dest_name = Path::Class::file($dest_name);

die "$0: $source_name must exist to copy it!\n" unless -e $source_name;

die "$0: $source_name must be a normal file!\n" unless -e $source_name;

die "$0: $dest_name already exists; won't overwrite\n" if -e $dest_name;

eval {
    copy_file($source_name, $dest_name);
};
die "Couldn't copy $source_name to $dest_name: $@\n" if $@;

eval {
    diff_file($source_name, $dest_name);
};
die "Files $source_name and $dest_name don't match!\n" if $@;

=head1 FUNCTIONS

=head2 copy_file()

Called with a source file and a destination file, copies the file.  Throws an exception if
something goes wrong.

=cut

sub copy_file {
    my $src_file = shift;
    my $dest_file = shift;

    eval {
        open(my $src_fh, '<', $src_file) or die "Can't read $src_file: $!";
        binmode $src_fh;
        open(my $dst_fh, '>', $dest_file) or die "Can't write $dest_file: $!";
        binmode $dst_fh;
        my $copied;
        my $buffer = '';
        while ($copied = read($src_fh, $buffer, 1024)) {
            my $wrote = print $dst_fh $buffer;
            die "Write error to $dest_file: $!" unless $wrote;
        }
        close($src_fh);
        close($dst_fh);
        die "Read error from $src_file: $!" unless(defined $copied);
    };
    # Error?  Clean up the bad copy and re-throw the error.
    if ($@) {
        unlink $dest_file;
        die $@;
    }
    return;
}


=head2 diff_file()

Called with two filenames, reads the files and comapres them.  Returns a Perl true or false
depending on if the files are identical or not.

Note: Uses a different algorithm than copy_file, just to be sure!

=cut

sub diff_file {
    my $src_file = shift;
    my $dest_file = shift;
    my $src_data = read_file($src_file);
    my $dest_data = read_file($dest_file);
    return ($src_data eq $dest_data);
}

=head2 read_file()

Called with a filename, reads the entire filename into a scalar, returning that scalar.

Throws an error if there's a problem.

=cut

sub read_file {
    my $in_file = shift;
    local $/ = undef;
    open(my $fh, '<', $in_file) or die "Can't read $in_file: $!";
    binmode $fh;
    my $data = <$fh>;
    close($fh);
    return $data;
}
