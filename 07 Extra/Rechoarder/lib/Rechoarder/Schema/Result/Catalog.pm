use utf8;
package Rechoarder::Schema::Result::Catalog;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Rechoarder::Schema::Result::Catalog

=head1 DESCRIPTION

The catalog table has one record for each piece of media, and defines the meaningful details of that media.``

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<catalog>

=cut

__PACKAGE__->table("catalog");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'catalog_id_seq'

=head2 title

  data_type: 'varchar'
  is_nullable: 0
  size: 80

=head2 artist

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 media_type

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 cover_condition

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 media_condition

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 price

  data_type: 'money'
  is_nullable: 0

=head2 category

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 description

  data_type: 'varchar'
  is_nullable: 0
  size: 16000

=head2 label

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 release_number

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 release_year

  data_type: 'integer'
  is_nullable: 1

=head2 release_month

  data_type: 'integer'
  is_nullable: 1

=head2 release_day

  data_type: 'integer'
  is_nullable: 1

=head2 release_country

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 mono_stereo

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 nrecinset

  data_type: 'integer'
  is_nullable: 0

=head2 onhand

  data_type: 'integer'
  is_nullable: 0

=head2 primary_picture

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 physical_location

  data_type: 'varchar'
  is_nullable: 1
  size: 35

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "catalog_id_seq",
  },
  "title",
  { data_type => "varchar", is_nullable => 0, size => 80 },
  "artist",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "media_type",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "cover_condition",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "media_condition",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "price",
  { data_type => "money", is_nullable => 0 },
  "category",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "description",
  { data_type => "varchar", is_nullable => 0, size => 16000 },
  "label",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "release_number",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "release_year",
  { data_type => "integer", is_nullable => 1 },
  "release_month",
  { data_type => "integer", is_nullable => 1 },
  "release_day",
  { data_type => "integer", is_nullable => 1 },
  "release_country",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "mono_stereo",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "nrecinset",
  { data_type => "integer", is_nullable => 0 },
  "onhand",
  { data_type => "integer", is_nullable => 0 },
  "primary_picture",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "physical_location",
  { data_type => "varchar", is_nullable => 1, size => 35 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 artist

Type: belongs_to

Related object: L<Rechoarder::Schema::Result::Artist>

=cut

__PACKAGE__->belongs_to(
  "artist",
  "Rechoarder::Schema::Result::Artist",
  { id => "artist" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 catalog_pictures

Type: has_many

Related object: L<Rechoarder::Schema::Result::CatalogPicture>

=cut

__PACKAGE__->has_many(
  "catalog_pictures",
  "Rechoarder::Schema::Result::CatalogPicture",
  { "foreign.catalog_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 category

Type: belongs_to

Related object: L<Rechoarder::Schema::Result::Category>

=cut

__PACKAGE__->belongs_to(
  "category",
  "Rechoarder::Schema::Result::Category",
  { id => "category" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 cover_condition

Type: belongs_to

Related object: L<Rechoarder::Schema::Result::Condition>

=cut

__PACKAGE__->belongs_to(
  "cover_condition",
  "Rechoarder::Schema::Result::Condition",
  { id => "cover_condition" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 label

Type: belongs_to

Related object: L<Rechoarder::Schema::Result::Label>

=cut

__PACKAGE__->belongs_to(
  "label",
  "Rechoarder::Schema::Result::Label",
  { id => "label" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 media_condition

Type: belongs_to

Related object: L<Rechoarder::Schema::Result::Condition>

=cut

__PACKAGE__->belongs_to(
  "media_condition",
  "Rechoarder::Schema::Result::Condition",
  { id => "media_condition" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 media_type

Type: belongs_to

Related object: L<Rechoarder::Schema::Result::MediaType>

=cut

__PACKAGE__->belongs_to(
  "media_type",
  "Rechoarder::Schema::Result::MediaType",
  { id => "media_type" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 mono_stereo

Type: belongs_to

Related object: L<Rechoarder::Schema::Result::MonoStereoType>

=cut

__PACKAGE__->belongs_to(
  "mono_stereo",
  "Rechoarder::Schema::Result::MonoStereoType",
  { id => "mono_stereo" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 primary_picture

Type: belongs_to

Related object: L<Rechoarder::Schema::Result::Picture>

=cut

__PACKAGE__->belongs_to(
  "primary_picture",
  "Rechoarder::Schema::Result::Picture",
  { id => "primary_picture" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2014-02-16 15:41:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xsseCLoghkyEqWbsnJDpNQ

use Path::Class ();
use File::Path ();
use File::Copy ();
use File::Compare ();
use File::Basename ();

=head2 formatId

Given an ID, format it to the "public" view we want, which is LWExxxxxx.

If passed an already-formatted ID, do the right thing and work.

Returns a formatted ID or undef if it can't make one.

If called as a method, will default to the id of the object.  Scary evil!

=cut

sub formatId {
    my $self;   # Undef if called as a method
    # If this is a reference, assume it's a self
    if(ref $_[0]) {
        $self = shift;
    }
    my $id = shift;

    # If we got a self, but no ID, use the id out of ourself
    if(defined $self and not defined $id) {
        $id = $self->id;
    }

    $id = extractId($id);
    if(defined $id) {
        $id = sprintf("LWE%06.06d", $id);
    }
    return $id;
}

=head2 extractId

Given an ID or a formatted ID, return the numeric ID.

Returns a numeric ID or undef if it can't fathom the ID.

=cut

sub extractId {
    my $id = shift;

    if($id =~ /^lwe(\d+)$/i) {
        $id = $1 + 0; # Convert to an integer value
    }
    elsif($id =~ /^\d+$/) {
        $id = $id + 0; # Convert to an integer value
    }
    else {
        $id = undef;
    }
    return $id;
}

=head2 CreateBlank

Create a blank catalog entry, suitable for later use.  Handles filling in defaults for all the required
fields and querying for IDs for values for foreign keys.

Assumes certain values exist in the DB for it to find, but not what their IDs may be.

=cut

sub CreateBlank {
    my ($schema) = @_;

    my $attrs = {};
    my $unknown = $schema->resultset('Condition')->
                           search({ name => 'Unknown' })->first;

    _setDefault($attrs,
        title => '',
        artist => $schema->resultset('Artist')->
                  search({ name => 'Unspecified' })->first->id,
        media_type => $schema->resultset('MediaType')->
                      search({ name => 'LP' })->first,
        cover_condition => $unknown,
        media_condition => $unknown,
        price => 0,
        category => $schema->resultset('Category')->
                    search({ name => 'Classical' })->first,
        description => '',
        label => $schema->resultset('Label')->
                 search({ name => 'Unspecified' })->first,
        mono_stereo => $schema->resultset('MonoStereoType')->
                       search({ name => 'Stereo' })->first,
        nrecinset => 1,
        onhand => 1,
    );

    return $schema->resultset('Catalog')->create($attrs);
}

=pod _setDefaults

Worker to set a default value to a hashref, if that value wasn't already set.  Prevents a lot
of duplication in new.

Called with a hashref, then key -> default pairs.

=cut

sub _setDefault {
    my $hashref = shift;

    while (@_) {
        my $key = shift;
        my $default = shift;

        unless(defined $hashref->{$key}) {
            $hashref->{$key} = $default;
        }
    }
}

=pod importPictures

Given an input directory and and output directory, import all the pictures found in import.

Expects to be called with a DBIC schema object it can insert images into, and two Path::Class
objects containing the source and destination paths for image storage.

=cut

sub importPictures {
    my $schema = shift;
    my $from = shift;
    my $to = shift;

    my $messages = [];
    my @extensions = qw/ jpg jpeg png gif /;
    my @images = ();

    foreach my $ext (@extensions) {
        @images = (@images, <"${from}/\*.${ext}">);
    }

    return "No images to process." unless @images;

    # Make that thing if we need it.
    if (! -e $to) {
        my $err;
        File::Path::make_path($to, {error => \$err});
        if (@$err) {
            my ($emsg) = values %{$err->[0]};
            push @$messages, "can't create $to: $emsg";
            return $messages;
        }
        push @$messages, "created $to";
    }

    foreach my $img (@images) {
        my $src = Path::Class::file($img);
        my $dest = Path::Class::file($to, $src->basename);
        push @$messages, "File: from $src to $dest";
        # If the file already exists in the new location, resolve that conflict.
        if (-e $dest) {
            # If the file is the same, just erase it from the import location
            if (File::Compare::compare($src, $dest) == 0) {
                push @$messages, "File already existed.  Removed from import.";
                unlink($src);
                next;
            }
            # Files differ - make a new name for the destination and then copy as a new file.
            else {
                my($file, undef, $ext) = File::Basename::fileparse($dest,
                                                                    @extensions);
                my $dir = $dest->dir;
                my $counter = 0;
                my $testfile = '';
                while ($counter++ < 1024
                        and -e ($testfile = $dir->file("$file$counter.$ext"))) {
                }
                if (! -e $testfile) {
                    $dest = $testfile;
                    # Falls through to move below
                }
                else {
                    push @$messages, "Couldn't import $src - $dest exists";
                    next;
                }
            }
        }
        # Move the file
        if (File::Copy::move($src, $dest)) {
            push @$messages, "Moved $src to $dest";
        }
        else {
            push @$messages, "Can't move $src to $dest: $!";
        }
    }

    return $messages;
}


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
