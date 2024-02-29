#!/usr/bin/perl
use strict;
use warnings;
use File::Path qw(make_path);

if (!-e 'TEMPLATE_CUE.html') {
    print "TEMPLATE_CUE.html does not exist, invoke 'init-cue' command to create. Exiting...\n";
    exit;
}

# Initial output folder name
my $output_folder_name = "output";

# Check if the original output folder exists
if (-e $output_folder_name) {
    my $counter = 1;

    # Increment counter until finding a non-existing folder
    while (-e "${output_folder_name}_$counter") {
        $counter++;
    }

    $output_folder_name = "${output_folder_name}_$counter";
}

# Create the output folder if it doesn't exist
make_path($output_folder_name) unless -e $output_folder_name;

# Open the HTML file for reading
open my $html_file, '<', 'TEMPLATE_CUE.html' or die "Cannot open Template_CUE.html: $!";

# Read the entire content of the file into a variable
my $html_content = do { local $/; <$html_file> };

# Close the file handle
close $html_file;

# Initialize variables for start_content and end_content
my $start_content;
my $end_content;

# Use regular expressions to capture content
$html_content =~ /(.*?<!--START HERE-->)/s;
$start_content = $1 // '';  # Use the captured content or an empty string if not found

$html_content =~ /(<!--END HERE-->.*?$)/s;
$end_content = $1 // '';    # Use the captured content or an empty string if not found

# Create TEMPLATE_STORY_.html in the output folder
my $template_file_path = "$output_folder_name/TEMPLATE_STORY_.html";
open my $template_file, '>', $template_file_path or die "Cannot open $template_file_path: $!";
print $template_file "$start_content\n";

my $counter = 0;
while ($html_content =~ /\[\[\s*(.*?)\s*\]\]/g) {
    $counter++;
    my $match = $1;
    my $filename = "CONTAINER_" . $counter . "_" . $match;
    my $startTag = "<!--$filename START-->";
    my $endTag = "<!--$filename END-->";

    my $placeholder = "[[$filename]]";
    
    print $template_file "$placeholder\n";

    # print "$placeholder\n";
    print "$placeholder\n";
    # Create and write content to the HTML file
    my $output_file_path = "$output_folder_name/$filename.html";
    open my $output_file, '>', $output_file_path or die "Cannot open $output_file_path: $!";
    print $output_file "$startTag\n";
    print $output_file "$endTag\n";
    close $output_file;
}

print $template_file "$end_content";
close $template_file;
