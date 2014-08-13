This demonstration was to show that a large number of complex modules can
be used on many platforms, and complex systems can run properly in a
platform independent way.

This is a Catalyst application.  It was demonstrated on Windows in both
Active State and Strawberry Perl, as well as on Linux and OSX.

Installing it is a little tricky, as the Makefile for the module does not
contain all the needed dependencies.

Install:
Perl
PostgresSQL

Create the database and user listed in the Model.

Create the database by using the SQL in the sql directory.

Start the script/rechoarder_server.pl

It will crash due to missing modules.  Install whatever it asks for.

Once it stops crashing, the app is running.

This can be prevented by the author properly listing the used modules as
requirements in the Makefile.PL.  If that had been done, a normal Perl module
build process would have found and installed all the needed modules.

Since that hasn't been done, installing and running this is a little rough.
It was a bonus demo if there was time in the talk.
