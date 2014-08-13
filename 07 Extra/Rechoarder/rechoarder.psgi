use strict;
use warnings;

use Rechoarder;

my $app = Rechoarder->apply_default_middlewares(Rechoarder->psgi_app);
$app;

