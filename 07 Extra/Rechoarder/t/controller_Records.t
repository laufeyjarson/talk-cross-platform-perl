use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Rechoarder';
use Rechoarder::Controller::Records;

ok( request('/records')->is_success, 'Request should succeed' );
done_testing();
