This demonstration shows how carriage return and linefeed translation works
on different platforms.

The demo program is really simple, and simply looks for any line which
includes .pl anywhere in it and prints that line.  Use it as a filter on the
directory listing.

On a Unixy system, you can do this with:

ls -al | perl findpl.pl

On a Windows system, the equivalent is:

dir | perl findpl.pl

Included are sample runs from four platforms, using their native inputs:

output-osx.txt        - Output of the script from Mac OSX Mavericks
output-win-as.txt     - Output of the script from Windows, Active State Perl
output-win-cygwin.txt - Output of the script from Windows, cygwin Perl
output-linux.txt      - Output of the script from Linux.

There are also a set of input text files, generated on each of the platforms:

input-osx.txt        - Results of "ls -al" on Mac OSX.
input-win-cmd.txt    - Results of "dir" in Windows cmd.exe
input-win-cygwin.txt - Results of "ls -al" on Cygwin
input-linux.txt      - Results of "ls -al" on Linux

These can be used as input files to test and see what will happen with data
from a different platform.  To use the stored text file instead of the
raw data, use cat or type to output the file to the perl script:

Unixy:

cat input-osx.txt | perl findpl.pl

Windows:

type input-osx.txt | perl findpl.pl

You can experiment with what different line endings will do on different
platforms this way.

The script should run on any Perl.
