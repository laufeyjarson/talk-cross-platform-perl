use utf8;
package Rechoarder::Schema::Result::Condition;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Rechoarder::Schema::Result::Condition - Store the list of grades for our media.

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

=head1 TABLE: C<conditions>

=cut

__PACKAGE__->table("conditions");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'conditions_id_seq'

=head2 display_order

  data_type: 'integer'
  is_nullable: 0

=head2 brief

  data_type: 'varchar'
  is_nullable: 0
  size: 6

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 description

  data_type: 'varchar'
  is_nullable: 1
  size: 1000

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "conditions_id_seq",
  },
  "display_order",
  { data_type => "integer", is_nullable => 0 },
  "brief",
  { data_type => "varchar", is_nullable => 0, size => 6 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "description",
  { data_type => "varchar", is_nullable => 1, size => 1000 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 catalog_cover_conditions

Type: has_many

Related object: L<Rechoarder::Schema::Result::Catalog>

=cut

__PACKAGE__->has_many(
  "catalog_cover_conditions",
  "Rechoarder::Schema::Result::Catalog",
  { "foreign.cover_condition" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 catalog_media_conditions

Type: has_many

Related object: L<Rechoarder::Schema::Result::Catalog>

=cut

__PACKAGE__->has_many(
  "catalog_media_conditions",
  "Rechoarder::Schema::Result::Catalog",
  { "foreign.media_condition" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2014-02-16 15:41:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:64KNMtY7kuIPf/cNusP4VA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
