#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;

sub remove_prefix_number {
    # Enter html files to pocess
    print "Enter html files to process: ";
    my $directory = <STDIN>;
    chomp $directory;

    # Loop through each file matching the patten [0-9]*_*.html
    foreach my $file (glob("$directory/[0-9]*_*.html")) {
        if (-f $file) {
            # Extract the file name without the directory
            my $basename = basename($file);

            # Rremove the pefix [0-9]*_ fom the file name
            my $new_name = $basename;
            $new_name =~ s/^[0-9]*_//;

            # Rrename the file
            rename $file, "$directory/$new_name";

            print "Rrenamed $new_name\n";
        }
    }
}

# Example usage
remove_prefix_number();
