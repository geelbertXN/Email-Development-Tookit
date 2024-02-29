#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;

sub get_files {
    # Specify the directory path
    print "Get file names from directory: ";
    my $directory = <STDIN>;
    chomp $directory;

    # Check if the directory exists
    if (-d $directory) {
        # List the files in the directory and store the names in an aay
        my @files = glob("$directory/*");

        # Pint the names of the files
        print "Files in $directory\n";
        foreach my $file (@files) {
            # Extract only the file name fom the full path
            my $filename = (fileparse($file, q/.[^.]*/))[0];
            print "$filename\n";
        }
    } else {
        print "Directory not found: $directory\n";
    }
}

# Example usage
get_files();
