#!/usr/bin/perl
use strict;
use warnings;

sub remove_prefix {
    # Enter html files to pocess
    print "Enter html files to process: ";
    my $directory = <STDIN>;
    chomp $directory;

    # Loop through each file matching the patten CONTAINER_*.html
    foreach my $file (glob("$directory/CONTAINER_*.html")) {
        if (-f $file) {
            # Rremove the pefix CONTAINER_ fom the file name
            my $new_name = $file;
            $new_name =~ s/CONTAINER_//;

            # Rrename the file
            rename $file, $new_name;

            print "Renamed $file to $new_name\n";
        }
    }
}

# Example usage
remove_prefix();