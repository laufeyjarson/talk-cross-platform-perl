use utf8;
package Rechoarder::Schema::Result::CatalogPicture;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Rechoarder::Schema::Result::CatalogPicture

=head1 DESCRIPTION

The catalog_pictures table maps extra pictures to catalog entries.

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

=head1 TABLE: C<catalog_pictures>

=cut

__PACKAGE__->table("catalog_pictures");

=head1 ACCESSORS

=head2 catalog_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 picture_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 number

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "catalog_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "picture_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "number",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</catalog_id>

=item * L</picture_id>

=back

=cut

__PACKAGE__->set_primary_key("catalog_id", "picture_id");

=head1 RELATIONS

=head2 catalog

Type: belongs_to

Related object: L<Rechoarder::Schema::Result::Catalog>

=cut

__PACKAGE__->belongs_to(
  "catalog",
  "Rechoarder::Schema::Result::Catalog",
  { id => "catalog_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 picture

Type: belongs_to

Related object: L<Rechoarder::Schema::Result::Picture>

=cut

__PACKAGE__->belongs_to(
  "picture",
  "Rechoarder::Schema::Result::Picture",
  { id => "picture_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2014-02-16 15:41:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+41QlKUZswScb07f6lRBfw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
