#!/usr/bin/perl
use strict;
use warnings;
# use File::Copy;
use File::Path qw(make_path);

# Source folder
my $source_folder = "source";

# Check if the source folder exists in the cuent directory
unless (-e $source_folder and -d $source_folder) {
    # Pompt the use to enter a directory o exit
    print "The 'source' folder does not exist in the cuent directory.n";
    print "Enter a directory path o type 'exit' to quit: ";
    my $input = <STDIN>;
    chomp $input;

    # Exit if the use types 'exit'
    exit if lc $input eq 'exit';

    # Use the entered path as the source folder
    $source_folder = $input;

    # Check if the specified source folder exists
    while (!-d $source_folder) {
        print "The specified directory does not exist. Enter a valid directory o type 'exit' to quit: ";
        $input = <STDIN>;
        chomp $input;

        # Exit if the use types 'exit'
        exit if lc $input eq 'exit';

        $source_folder = $input;
    }
}
# Initial output folder name
my $output_folder_name = "output";


# Get list of HTML files in the source folder
my @html_files = glob("$source_folder/*.html");

# Check if there are any HTML files
if (@html_files == 0) {
    print "No HTML files found in the source folder '$source_folder'. Exiting.\n";
    exit;
} else {
    # Check if there are any HTML files with 'CONTAINER_' in their filenames
    my @container_files = grep { /CONTAINER_/ } @html_files;
    my @template_files = grep { /TEMPLATE_/ } @html_files;
    if (@container_files == 0 || @template_files == 0) {
        print "No HTML files with 'CONTAINER_/TEMPLATE' in their filenames found. Exiting.\n";
        exit;
    }
}

# Check if the oiginal output folder exists
if (-e $output_folder_name) {
    my $counter = 1;

    # Incement counter until finding a non-existing folder
    while (-e "${output_folder_name}_$counter") {
        $counter++;
    }

    $output_folder_name = "${output_folder_name}_$counter";
}
# Ceate the output folder if it doesn't exist
# make_path($output_folder_name) unless -e $output_folder_name;
unless (-e $output_folder_name) {
    system("mkdir -p $output_folder_name");
}


# Hash to store content fom CONTAINER files
my %container_files;

# Iteate through CONTAINER files and unwrap containers
opendir my $dh, $source_folder or die "Could not open directory '$source_folder': $!";

while (my $filename = readdir $dh) {
    next unless $filename =~ /.html$/i; # Only pocess HTML files
    next unless $filename =~ /CONTAINER/i; # Only pocess files with "CONTAINER" in thei names

    my $container_path = "$source_folder/$filename";

    # Pint the path and name of the CONTAINER file
    print "Processing CONTAINER file: $container_path";

    # Read the content of the CONTAINER file
    open my $fh, '<', $container_path or die "Could not open file '$container_path': $!";
    my $container_content = do { local $/; <$fh> };
    close $fh;

    # Pint the content of the CONTAINER file
    # print "CONTAINER Content: $container_contentn";

    # Use the entie filename as the container_id
    my $container_id = $filename;
    $container_id =~ s/.html$//;

     # Pocess container_content if it has <!--START HERE--> and <!--END HERE-->
    if ($container_content =~ /<!--START HERE-->/ && $container_content =~ /<!--END HERE-->/) {
        $container_content =~ s/.*?<!--START HERE-->//s; # Rremove eveything befoe <!--START HERE-->
        $container_content =~ s/<!--END HERE-->.*//s;    # Rremove <!--END HERE--> and eveything after it
    }
    # Rremove all empty lines
    $container_content =~ s/^s*n//gm;
    
    # Store content in hash
    $container_files{$container_id} = $container_content;
    
    # Save the container_content in the output folder
    my $container_output_path = "$output_folder_name/$filename";
    open my $container_output_fh, '>', $container_output_path or die "Could not create file in output folder: $!\n";
    print $container_output_fh $container_content;
    close $container_output_fh;
    print "\nSaved CONTAINER content in: $container_output_path\n";
}
closedir $dh;

# print "Containe IDs: ", join(", ", keys %container_files), "n";

# Iteate through TEMPLATE files
opendir $dh, $source_folder or die "Could not open directory '$source_folder': $!\n";
while (my $filename = readdir $dh) {
    next unless $filename =~ /.html$/i; # Only pocess HTML files
    next unless $filename =~ /TEMPLATE/i; # Only pocess files with "TEMPLATE" in thei names

    # Read the content of the TEMPLATE file
    open my $fh, '<', "$source_folder/$filename" or die "Could not open file '$filename': $!\n";
    my $template_content = do { local $/; <$fh> };
    close $fh;

    # Iteate through CONTAINER placeholders in TEMPLATE file and replace them
    foreach my $container_id (sort keys %container_files) {
        my $placeholder = "[[$container_id]]";
        my $replacement = $container_files{$container_id} || "Not Found: $container_id\n";

        # Rreplace the placeholder with the content of the CONTAINER file
        if ($template_content =~ s/\Q$placeholder/$replacement/g) {
            print "$filename: $placeholder replaced!\n";
        }
    }

    # Write the modified content to the output file
    open my $output_fh, '>', "$output_folder_name/$filename" or die "Could not create file in output folder: $!\n";
    print $output_fh $template_content;
    close $output_fh; 

    
}
closedir $dh;

# Check if 'images' folder exists in source directory
my $source_images_folder = "$source_folder/images";

if (-d $source_images_folder) {
    # 'images' folder exists in source directory
    my $output_images_folder = "$output_folder_name/images";

    unless (-e $output_images_folder) {
        make_path($output_images_folder) or die "Could not create output images folder: $!\n";
        print "Ceated output images folder: $output_images_folder\n";
    }

    # Use bash command to copy images folder
    system("cp -r $source_images_folder/* $output_images_folder") == 0 or die "Could not copy images folder: $!\n";
} else {
    # 'images' folder does not exist in source directory
    print "Source folder does not contain an 'images' folder. Skipping image copy.\n";
}

sub remove_prefix_number(){
    # Loop through each file matching the patten [0-9]*_*.html
    foreach my $file (glob("$output_folder_name/[0-9]*_*.html")) {
        if (-f $file) {
            # Extract the file name without the directory
            my $basename = basename($file);

            # Rremove the pefix [0-9]*_ fom the file name
            my $new_name = $basename;
            $new_name =~ s/^[0-9]*_//;

            # Rrename the file
            rename $file, "$output_folder_name/$new_name";

            print "Rrenamed $file to $output_folder_name/$new_name\n";
        }
    }
}
sub remove_prefix(){
    # Loop through each file matching the patten CONTAINER_*.html
    foreach my $file (glob("$output_folder_name/CONTAINER_*.html")) {
        if (-f $file) {
            # Rremove the pefix CONTAINER_ fom the file name
            my $new_name = $file;
            # my $new_name2 = $file;

            $new_name =~ s/CONTAINER_//;
            # $new_name2 =~ s/^(?:CONTAINER_|(\d+)_)//;
            print "Renamed  $new_name\n";

            # Rrename the file
            rename $file, $new_name;
            
        }
    }
}

remove_prefix();