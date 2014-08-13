package Rechoarder::Controller::Records;
use Moose;
use namespace::autoclean;

BEGIN {
    $Date::Manip::Backend = 'DM6';
}
use Date::Manip;
use DateTime::Format::DateManip;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Rechoarder::Controller::Records - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 base

Set up the actions to work.

=cut

sub base : Chained('/') : PathPart('records') : CaptureArgs(0) {

    # doesn't do anything yet
}

=head2 recordID

Given a record ID, find and load it into the stash.  Used by several
items.

=cut

sub recordid : Chained('base') : PathPart('id') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    my $searchId = $id;
    $c->stash( searchId => $searchId );

    $id = Rechoarder::Schema::Result::Catalog::extractId($id);

    # If the ID wasn't formatted right, fix the URL!
    if ( $id
        and Rechoarder::Schema::Result::Catalog::formatId($id) ne $searchId )
    {
        return $c->res->redirect(
            $c->uri_for(
                "id", Rechoarder::Schema::Result::Catalog::formatId($id),
                $c->action->name
            )
        );
    }

    my $record;

    # Bad DB queries should be ignored.
    eval {
        if ( defined $id ) {
            $record =
              $c->model('RechoarderDB')->resultset('Catalog')->find($id);
        }
    };
    if ($record) {
        $c->stash( record => $record );
    }
}

=head2 list()

List records, etc.

=cut

sub list : Local : Args(0) {
    my ( $self, $c ) = @_;

    $c->stash(
        records => [ $c->model('RechoarderDB')->resultset('Catalog')->all ] );
}

=head2 detail()

Show the details for a single record.

=cut

sub detail : Chained('recordid') : PathPart('detail') : Args(0) {
    my ( $self, $c, $id ) = @_;
    my $record = $c->stash->{record};
    _record_to_form( $c, $record );
}

=head2 edit()

Edit the details for a single record.

Need to copy the data from the request to 'form' in the stash for redisplay.

=cut

sub edit : Chained('recordid') : PathPart('edit') : Args(0) {
    my ( $self, $c) = @_;

    # Load the stash with the items needed to draw the dropdowns.
    $c->stash( conditions  => [ $self->_get_dd_names( $c, 'Condition' ) ] );
    $c->stash( media_types => [ $self->_get_dd_names( $c, 'MediaType' ) ] );
    $c->stash(
        mono_stereo_types => [ $self->_get_dd_names( $c, 'MonoStereoType' ) ] );

    my $record = $c->stash->{record};

   # If we have a valid item to update, and they pushed the button to update it,
   # check for validity and either return an error or save the changes.

    # Check the form's data and load it into the record
    if ( $record and _sparam($c, 'submit') eq 'Save Changes' ) {
        $c->log->debug("DOING A SUBMIT");

        # check validity
        my @errors = ();

        # Must not be blank
        # Everything but release_country, release_year, release_month, release_day,
        # and physical_location
        foreach my $item (
            qw / artist category media_condition cover_condition
            description label mono_stereo nrecinset onhand price
            release_number title /
          )
        {
            unless ( length _sparam( $c, $item ) ) {
                push @errors, "$item must not be blank";
            }
        }

        # If release_day is set, release_month and year must be as well
        if(length _sparam($c, 'release_day')) {
            unless(length _sparam($c, 'release_month') && length _sparam($c, 'release_year')) {
                push @errors, "You must set a month and year to set a release day";
            }
        }

        # If release_month is set, release_year must be as well
        if(length _sparam($c, 'release_month')) {
            unless(length _sparam($c, 'release_year')) {
                push @errors, "You must set a year to set a release month";
            }
        }

        # Copy any items directly in the record object
        foreach my $item (
            qw / description nrecinset onhand physical_location
            price release_country release_number
            title /
          )
        {
            $record->$item( _sparam( $c, $item ) );
        }

        # Properly parse dates and times.
        # TODO: Test Day, Month, and Year to be sensible
        foreach my $item (qw / release_day release_month release_year /) {
            my $datestr = _sparam( $c, $item );
            $record->$item( _sparam( $c, $item ) );
            if ( $datestr eq '' ) {
                $record->$item(undef);
            }
            eval { my $test = $record->$item; };
            if ($@) {
                push @errors, "Can't format $item properly $@!";
            }
            eval { $c->log->debug( "Set $item to " . $record->$item ); };
        }

        # Change any needed related items.
        foreach my $item (qw / cover_condition media_condition mono_stereo /) {
            unless ( _update_related( $record, $item, _sparam( $c, $item ) ) ) {
                push @errors, "Can't figure out what $item is supposed to be.";
            }
        }

        # Find or add any fields that should be looked up
        foreach my $item (qw /artist category label /) {
            unless ( _update_add( $record, $item, _sparam( $c, $item ) ) ) {
                push @errors, "Couldn't update $item!";
            }
        }

        if(! @errors) {
            eval {
                $record->update;
            };
            if($@) {
                push @errors, "Invalid data: $@";
            }
            else {
                return $c->res->redirect(
                $c->uri_for( "id", $record->formatId($record->id), 'detail' ) );
            }
        }

        if (@errors) {
            $c->stash( errors => [@errors] );

            # Copy the stuff from the form back to the item in the stash so it
            # will be redisplayed for re-editing.
            my $edit = { id => $record->id, formatId => $record->formatId };
            foreach my $item ( keys $c->req->params ) {
                if ( $record->result_source->has_column($item) ) {
                    $edit->{$item} = _sparam( $c, $item );
                }
            }
            $c->stash( record => $edit );
        }

        my $form = {};
        # Set up the form data for redisplay
        foreach my $p ( keys %{ $c->req->params } ) {
            $form->{$p} = $c->req->param($p);
        }
        $c->stash( form => $form );
    }

    # Load a new object onto the form, without any validation.
    else {
        _record_to_form( $c, $record );
    }
}

=head2 add()

Add a new single record.

Create a new record, put it in the stash, and then call edit normally.

Need to copy the data from the request to 'form' in the stash for redisplay.

=cut

sub add : Local : CaptureArgs(0) {
    my ( $self, $c ) = @_;

    my $record = Rechoarder::Schema::Result::Catalog::CreateBlank(
        $c->model('RechoarderDB')
    );

    $c->stash( record => $record );
    $c->detach('edit', 'new');
}

=head2 import

Base for all import steps; does nothing yet.

=cut

sub import : Chained('base') : PathPart('import') : CaptureArgs(0) {
}

=head2

Import pictures from the pictures dir to the DB.

=cut

sub import_pictures : Chained('import') : PathPart('pictures') : Args(0) {
    my ( $self, $c ) = @_;
    my $msg = "No action taken.";

    if ($c->user) {
        my $inputDir = $c->path_to('import');
        my $outputDir = $c->path_to('root', 'images', 'imported');

        $c->log->debug("InputDir is: $inputDir");
        $c->log->debug("OutputDir is: $outputDir");
        my $msg = Rechoarder::Schema::Result::Catalog::importPictures(
            $c->model('RechoarderDB'),
            $inputDir,
            $outputDir,
        );
        $c->stash(message => $msg );
    }
    else {
        return $c->res->redirect($c->uri_for('list'));
    }
}

=head2

Export base function.  Not currently used except to define the namespace.

=cut

sub export : Chained('base') : PathPart('export') : CaptureArgs(0) {
}

=head2 export_catalog

Called as export/catalog to generate the full availability catalog for GEMM

=cut

sub export_catalog : Chained('export') : PathPart('catalog') : Args(0) {
}




=head2 _record_to_form

Copy the record information to the text values for the form.

=cut

sub _record_to_form : Private {
    my ( $c, $record ) = @_;

    my $form = {};

    # Set up initial form data
    foreach my $i (
        qw / description nrecinset onhand physical_location
        price release_country release_year release_month release_day
        release_number title
        /
      )
    {
        $form->{$i} = $record->$i;
    }

    # Set up the related items
    foreach my $i (
        qw / artist category cover_condition label media_condition
        label mono_stereo /
      )
    {
        $form->{$i} = $record->$i->name;
    }
    $c->stash( form => $form );
}

=heda2 _update_add

For each named relationship, find the right ID and set it in the record object.
If there isn't one, add it, and then set it in the record object.

=cut

sub _update_add {
    my ( $record, $column, $value ) = @_;

    # Get the related result set, to find out what class that reprensents,
    my $class = $record->related_resultset($column)->result_class;
    # Now create a clean resultset for that
    my $rs = $record->result_source->schema->resultset($class);
    #my $rs = $record->related_resultset($column);
    my $found = $rs->find_or_create( { name => $value } );

print STDERR "\nDEBUG: update_add $column -> $value\n";
print STDERR "DEBUG: setting to ", $found->name, "\n";

    $record->$column( $found->id );
}

=head2 _update_related

Given a record object, the name of a related column, and a value, update the
record object to point to that new value.

Return a true value if the update made sense, or a false if there was no
matching value.

=cut

sub _update_related {
    my ( $record, $column, $value ) = @_;

    # Get the related result set, to find out what class that reprensents,
    my $class = $record->related_resultset($column)->result_class;
    # Now create a clean resultset for that
    my $rs = $record->result_source->schema->resultset($class);

    my @match = $rs->search({ name => $value });

    #my @match = $record->search_related( $column, { name => $value } );
    if ( scalar @match != 1 ) {
        return undef;
    }
    $record->$column( $match[0]->id );
}

=head2 _sparam

Safe param - returns '' instead of undef.

=cut

sub _sparam {
    my $c     = shift;
    my $param = shift;
    my $str   = $c->req->param($param) || '';
    $str =~ s/^\s+//;
    $str =~ s/\s+$//;
    return $str;
}

=head2 _get_dd_names

Get the text items to put in one of the dropdowns, in order.

=cut

sub _get_dd_names {
    my $self  = shift;
    my $c     = shift;
    my $table = shift;

    my @names;
    my $rs = $c->model('RechoarderDB')->resultset($table)
      ->search( {}, { order_by => { -asc => 'display_order' }, }, );
    while ( my $item = $rs->next ) {
        push @names, $item->name;
    }
    return @names;
}

=head1 AUTHOR

Louis Erickson

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
