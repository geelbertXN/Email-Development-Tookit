#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;
use File::Path qw(make_path);
use Time::Piece;

# Prompt the user for the directory
print "Enter directory path: ";
my $directory = readline(STDIN);
chomp($directory);

# Get the current timestamp
my $timestamp = localtime->strftime("%Y.%m.%d");
# Create the 'output' directory with a timestamp if it doesn't exist
my $output_directory = "$directory/output_$timestamp";

# Check if 'output' directory already exists, assign ordinal numbers if needed
if (-d $output_directory) {
    my $ordinal_number = 1;
    my $new_output_directory = "$directory/output_${timestamp}_$ordinal_number";

    while (-d $new_output_directory) {
        $ordinal_number++;
        $new_output_directory = "$directory/output_${timestamp}_$ordinal_number";
    }

    $output_directory = $new_output_directory;
    make_path($output_directory);
}else{
    make_path($output_directory) unless -d $output_directory;
}

# Open the directory and get a list of files
opendir my $dh, $directory or die "Could not open directory '$directory': $!";
my @files = grep { -f "$directory/$_" } readdir($dh);
closedir $dh;

# Loop through each file in the directory
foreach my $file (@files) {
    # Check if the file has a .html extension
    if ($file =~ /\.html$/) {
        my $html_file = "$directory/$file";
        my $link_file = "$directory/" . basename($file, ".html") . ".link";

        # Check if the corresponding .link file exists
        if (-e $link_file) {
            # Read LINK file
            open my $link_fh, '<', $link_file or die "Could not open LINK file $link_file: $!";
            my @link_lines = <$link_fh>;
            close $link_fh;

            # Read HTML file into a scalar
            open my $html_fh, '<', $html_file or die "Could not open HTML file $html_file: $!";
            local $/; # Slurp mode
            my $html_content = <$html_fh>;
            close $html_fh;


            # Variables to store extracted values from LINK line
            my ($link, $link_label, $link_category, $link_href);
            # Loop through each line of LINK file
            foreach my $link_line (@link_lines) {
                chomp($link_line);

                # Extract link, _label, _category, and href values from LINK line
                if ($link_line =~ /link="([^"]+)"/) {
                    $link = $1;
                }

                if ($link_line =~ /_label="([^"]+)"/) {
                    $link_label = $1;
                }

                if ($link_line =~ /_category="([^"]+)"/) {
                    $link_category = $1;
                }

                if ($link_line =~ /href="([^"]+)"/) {
                    $link_href = $1;
                }

                # Validate replacement values
                unless (defined $link_label && defined $link_category && defined $link_href) {
                    die "Error: One or more replacement values are undefined. Check the LINK file format.\n";
                }

                # Replace occurrences in the HTML content
                $html_content =~ s/\Q_label="$link"\E/_label="$link_label"/;
                $html_content =~ s/\Q_category="$link"\E/_category="$link_category"/;
                $html_content =~ s/\Qhref="$link"\E/href="$link_href"/;

                # print "LINK Line: link=$link, _label=$link_label, _category=$link_category, link_href=$link_href\n";
            }

            # # Open HTML file for writing changes
            # open my $html_write_fh, '>', $html_file or die "Could not open HTML file $html_file for writing: $!";
            # # Print modified HTML content to the HTML write file
            # print $html_write_fh $html_content;
            # # Close the HTML write file
            # close $html_write_fh;
            # Open HTML file for writing changes in the 'output' directory
            my $output_html_file = "$output_directory/$file";
            open my $html_write_fh, '>', $output_html_file or die "Could not open HTML file $output_html_file for writing: $!";

            # Print modified HTML content to the HTML write file
            print $html_write_fh $html_content;

            # Close the HTML write file
            close $html_write_fh;

            print "Changes saved to $html_file\n";
        } else {
            print "No corresponding LINK file found for $html_file\n";
        }
    }
}
