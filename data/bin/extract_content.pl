#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;

my $source_folder = "xxx";
our $currentName; # declaring global variable

# Check if the source folder exists in the current directory
unless (-e $source_folder and -d $source_folder) {
    # Prompt the user to enter a directory or exit
    # print "The 'source' folder does not exist in the current directory.\n";
    print "Enter a directory path or type 'exit' to quit: ";
    my $input = <STDIN>;
    chomp $input;

    # Exit if the user types 'exit'
    exit if lc $input eq 'exit';

    # Use the entered path as the source folder
    $source_folder = $input;

    # Check if the specified source folder exists
    while (!-d $source_folder) {
        print "The specified directory does not exist. Enter a valid directory or type 'exit' to quit: ";
        $input = <STDIN>;
        chomp $input;

        # Exit if the user types 'exit'
        exit if lc $input eq 'exit';

        $source_folder = $input;
    }
}

# Initial output folder name
my $output_folder_name = "output_extracted";

# Check if the original output folder exists
if (-e $output_folder_name) {
    my $counter = 1;

    # Increment counter until finding a non-existing folder
    while (-e "${output_folder_name}_$counter") {
        $counter++;
    }

    $output_folder_name = "${output_folder_name}_$counter";
}



opendir(my $dh, $source_folder) or die "Can't open directory $source_folder: $!";
my @files = readdir($dh);
closedir($dh);

foreach my $file (@files) {
    next if ($file eq '.' or $file eq '..');
    next unless ($file =~ /\.html$/);

    my $full_path = "$source_folder/$file";
    open(my $fh, "<", $full_path) or die "Can't open $full_path: $!";
    my @lines = <$fh>;
    close($fh);

    my $print_flag = 0; # Flag to control printing
    my $output_file;

    # Get the basename of the HTML file
    # my $basename = basename($file, ".html"); 
    my $basename = "CONTAINER"; 
    my $counter = 0;

    foreach my $line (@lines) {
        if ($line =~ /\{extract-end\}/) {
            $print_flag = 0;
            close $output_file if $output_file;
            next;
        }
        
        if ($line =~ /\{extract=(.*?)\}/) {
            # Create the output folder if it doesn't exist
            unless (-e $output_folder_name) {
                system("mkdir -p $output_folder_name");
            }

            $counter++;
            $currentName = "${basename}_${counter}_$1";
            print "$currentName\n";
            close $output_file if $output_file;
            open($output_file, '>', "$output_folder_name/$currentName.html") or die "Can't create $output_folder_name/$currentName.html: $!";
            $print_flag = 1;
            next; # Skip printing the {extract=...} line
        }
        if($print_flag){
            print $output_file $line;
        }
    }
    close $output_file if $output_file;
}

# wrap content to be extracted to {extract=some_name} and {extract-end}.
# this will be useful if you want to edit the whole html 
# then separate chunk of contents as needed