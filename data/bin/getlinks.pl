#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;

sub get_links {
    print "html directory: ";
    my $input_dir = <STDIN>;
    chomp($input_dir);

    # Check if the directory exists
    if (-d $input_dir) {
        # Find all HTML files in the input directory
        my @html_files = glob("$input_dir/*.html");
        my $local_counter = 0;

        # Check if there are HTML files
        if (@html_files) {
            # Loop through each HTML file
            foreach my $html_file (@html_files) {
                # Extract and print href links with line numbes fom the HTML file
                my $filename = (fileparse($html_file, q/.[^.]*/))[0] . ".link";
                print "$filename\n";

                # Open the HTML file fo eading
                open my $html_fh, '<', $html_file or die "Cannot open $html_file: $!";
                
                my $line_numbers = 0;

                while (my $line = <$html_fh>) {
                    chomp $line;
                    $line_numbers++;
                    
                    if ($line =~ /href/) {
                        my @links = $line =~ /href="([^"]*)"/g;
                        my @labels = $line =~ /_label="([^"]*)"/g;
                        my @cats= $line =~ /_category="([^"]*)"/g;
                        # if (@links) {

                        #     foreach my $link (@labels) {
                        #         # print "href=$link |";
                        #         # Uncomment the line below to wite links to a file
                        #         # print LINKS_FILE "$linkn";
                        #         print "href=$link\n";
                        #     }
                        # }
                        for my $i (0 .. $#links) {
                            my $label = $labels[$i];
                            my $cat = $cats[$i];
                            my $link = $links[$i];

                            # Check if any of the variables is undefined or empty
                            $label = defined($label) && $label ne "" ? $label : "null";
                            $cat   = defined($cat) && $cat ne "" ? $cat : "null";
                            $link  = defined($link) && $link ne "" ? $link : "null";
                            # Uncomment the line below to write links to a file
                            # print LINKS_FILE "$link\n";
                            print "_label=\"$label\" _category=\"$cat\" href=\"$link\"\n";
                        }
                    }
                }

                close $html_fh;
                print "---------------------------------\n";
            }
        } else {
            print "No HTML files found in $input_dir.\n";
        }
    } else {
        print "Directory not found: $input_dir\n";
    }
}

# Example usage
get_links();
