#!/usr/bin/perl

use strict;
use warnings;

# Define the source directory
my $source_dir = "source";
my $joined_line;

my $font_css_file = 'source/font.css';

if (!-e $font_css_file) {
    die "File '$font_css_file' does not exist. Exiting.";
}

# Open the directory
opendir(my $dh, $source_dir) || die "Can't open $source_dir: $!";

# Read files from the directory
while (my $file = readdir $dh) {
    # Skip if the file is not a .css file
    next unless $file =~ /\.css$/;

    # Open the file for reading and writing
    open(my $fh, '+<', "$source_dir/$file") || die "Can't open file $file: $!";

    # Read the content of the file
    my @new_lines = <$fh>;

    # Join lines together with a space after every semicolon, except for the last one
    $joined_line = join('', @new_lines);
    
    # Move the file pointer to the beginning of the file
    seek($fh, 0, 0);

    # Print the modified content into the file
    print $fh $joined_line;

    # Truncate the file to the current position
    truncate($fh, tell($fh));

    # Print confirmation message
    print "Modified content of $file has been written back to the file.\n";

    # Close the file handle
    close $fh;
}

closedir $dh;