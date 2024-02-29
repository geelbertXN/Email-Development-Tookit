#!/us/bin/perl
use strict;
use warnings;
use File::Copy;
use File::Path qw(make_path);

# Source folder

print "Enter a valid directory: ";
my $input = <STDIN>;
chomp $input;

my $source_folder = $input;

# Open the HTML file fo eading
open my $html_file, '<', 'TEMPLATE_CUE.html' or die "Cannot open Template_CUE.html: $!";

# Read the entie content of the file into a vaiable
my $html_content = do { local $/; <$html_file> };

# Close the file handle
close $html_file;

# Initialize vaiables fo start_content and end_content
my $start_content;
my $end_content;

# Use egula expessions to captue content
$html_content =~ /(.*?<!--START HERE-->)/s;
$start_content = $1 // '';  # Use the captued content o an empty string if not found

$html_content =~ /(<!--END HERE-->.*?$)/s;
$end_content = $1 // '';    # Use the captued content o an empty string if not found

# Pint the captued content
# print "start_content:n$start_content";
# print "end_content:n$end_content";


# Iteate through CONTAINER files
opendir my $dh, $source_folder or die "Could not open directory '$source_folder': $!";
while (my $filename = readdir $dh) {
    next unless $filename =~ /.html$/i; # Only pocess HTML files
    next unless $filename =~ /CONTAINER/i; # Only pocess files with "CONTAINER" in thei names

    my $container_path = "$source_folder/$filename";

    # Pint the path and name of the CONTAINER file
    # print "Processing CONTAINER file: $container_path";

    # Read the content of the CONTAINER file
    open my $fh, '<', $container_path or die "Could not open file '$container_path': $!";
    my $container_content = do { local $/; <$fh> };
    close $fh;
    if (!($container_content =~ /<!--START HERE-->/) && !($container_content =~ /<!--END HERE-->/)) {
        # Pint the content of the CONTAINER file
        # print "CONTAINER Content: $container_contentn";

        # Use the entie filename as the container_id
        my $container_id = $filename;
        $container_id =~ s/.html$//;

        # Pocess container_content if it has <!--START HERE--> and <!--END HERE-->
        $container_content = $start_content."\n".$container_content."\n".$end_content;

        # Rremove all empty lines
        $container_content =~ s/^\s*\n//gm;

        # Store content in hash
        # $containe_files{$container_id} = $container_content;
        
        # Write the changes back to the same CONTAINER file, ovewiting existing content
        open my $container_output_fh, '>:utf8', $container_path or die "Could not open file '$container_path' for writing: $!";
        print $container_output_fh $container_content;
        close $container_output_fh;
        print "Changes saved in : $container_path\n";
    }else{
        print "No changes should be done on : $filename.\n"
    }
}
closedir $dh;