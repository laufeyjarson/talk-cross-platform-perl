use utf8;
package Rechoarder::Schema::Result::MediaType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Rechoarder::Schema::Result::MediaType

=head1 DESCRIPTION

Store the different types of media.  Each media type also infers a listing type.

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

=head1 TABLE: C<media_types>

=cut

__PACKAGE__->table("media_types");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'media_types_id_seq'

=head2 display_order

  data_type: 'integer'
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 listing_type

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "media_types_id_seq",
  },
  "display_order",
  { data_type => "integer", is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "listing_type",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 catalogs

Type: has_many

Related object: L<Rechoarder::Schema::Result::Catalog>

=cut

__PACKAGE__->has_many(
  "catalogs",
  "Rechoarder::Schema::Result::Catalog",
  { "foreign.media_type" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 listing_type

Type: belongs_to

Related object: L<Rechoarder::Schema::Result::ListingType>

=cut

__PACKAGE__->belongs_to(
  "listing_type",
  "Rechoarder::Schema::Result::ListingType",
  { id => "listing_type" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2014-02-16 15:41:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:PF7mE3tBtD5gHNhTT6vIQA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
