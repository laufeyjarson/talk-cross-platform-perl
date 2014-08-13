This demonstration shows the use of binmode..

The demo program is supposed to copy a file.  It expects to be given two file
names on the command line, an input file and the output file.  It does some
simple checking to make sure the input exists and the output does not.  It then
copies the file.  After copying, it uses a different method to verify the files
are both the same.

There are three versions of this script:

perlcp-bad.pl - Overly simplistic copy tool, lacking binmode.
perlcp-fixed.pl - Simple copy tool, with binmode, that actually works.
rightcp.pl - A much better way to write a copy tool.

There are also a couple of JPEG files to experiment with, and a couple of
output files to demonstrate actual runs on different platforms.

LarryWall-osx.jpg    - The result of running perlcp-bad.pl on OSX
LarryWall-win-as.jpg - The result of running perlcp-bad.pl on Windows,
                       Active State Perl

Both perlcp-bad and perlcp-fixed will say the copy worked.  If you run it on
a system with text translation, you can get corrupted output.  Windowsy Perls
(ActiveState and Strawberry) always have text translation, and Unixy Perls
(Unix, Linux, OSX, Cygwin) can have it if the character set is set, and the
files have a Byte Order Mark.

Always use binmode!()

No output is provided for perlcp-fixed.pl, as it produces identical output to
the original images.

The rightcp.pl is a better way to write a script to copy a file; it uses the
builtin modules to do the work.  They work on all platforms.

The script should run on any Perl with Path::Class installed.
