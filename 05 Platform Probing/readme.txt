This demonstration shows how to examine the platform Perl is running on,
and how to make decisions based on that platform.

There are two sample scripts:

showplatform.pl - Show basic platform information
freespace.pl - Show free space on a volume

showplatform.pl is very simple and just displays some of the platform
specific information available to any Perl script.

freespace.pl is more complex, and demonstrates how to isolate platform-specific
code and probe the system to take different actions on different platforms.
It uses system-specific tools to get disk space information.  It should work
on OSX, Linux, or Windows.  Note that it doesn't understand Cygwin, and
exits with an error message on Cygwin or any other unknown platform.

showplatform.pl should run on any Perl installation.  freespace.pl requires
Path::Class to be installed.
