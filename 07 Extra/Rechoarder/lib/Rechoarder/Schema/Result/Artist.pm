use utf8;
package Rechoarder::Schema::Result::Artist;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Rechoarder::Schema::Result::Artist - Defines the list of known artists.

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

=head1 TABLE: C<artists>

=cut

__PACKAGE__->table("artists");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'artists_id_seq'

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 80

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "artists_id_seq",
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 80 },
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
  { "foreign.artist" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-10-24 22:17:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:QhCQr1vVv2N6IqXG23U/iw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
