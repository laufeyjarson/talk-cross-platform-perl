use utf8;
package Rechoarder::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Rechoarder::Schema::Result::User - User list.

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

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'users_id_seq'

=head2 username

  data_type: 'varchar'
  is_nullable: 0
  size: 80

=head2 password

  data_type: 'varchar'
  is_nullable: 0
  size: 80

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 80

=head2 first_name

  data_type: 'varchar'
  is_nullable: 0
  size: 40

=head2 last_name

  data_type: 'varchar'
  is_nullable: 0
  size: 40

=head2 active

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "users_id_seq",
  },
  "username",
  { data_type => "varchar", is_nullable => 0, size => 80 },
  "password",
  { data_type => "varchar", is_nullable => 0, size => 80 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 80 },
  "first_name",
  { data_type => "varchar", is_nullable => 0, size => 40 },
  "last_name",
  { data_type => "varchar", is_nullable => 0, size => 40 },
  "active",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<users_username_key>

=over 4

=item * L</username>

=back

=cut

__PACKAGE__->add_unique_constraint("users_username_key", ["username"]);

=head1 RELATIONS

=head2 user_roles

Type: has_many

Related object: L<Rechoarder::Schema::Result::UserRole>

=cut

__PACKAGE__->has_many(
  "user_roles",
  "Rechoarder::Schema::Result::UserRole",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 roles

Type: many_to_many

Composing rels: L</user_roles> -> role

=cut

__PACKAGE__->many_to_many("roles", "user_roles", "role");


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-10-26 22:08:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:WjJbZyrvaIYjt2S46Lszbg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
