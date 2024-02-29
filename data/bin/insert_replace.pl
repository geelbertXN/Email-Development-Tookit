#!/usr/bin/perl

use strict;
use warnings;
use File::Basename;

# Initialize $section to 'null'
my $section = 'null';

sub replace_keys_with_values {
    my ($key_value_file, $file_for_process) = @_;

    open(my $fh, '<', $key_value_file) or die "Can't open key-value file $key_value_file: $!";
    
    my %key_value_pairs;

    # Read the key-value pairs from the key-value file (.data)
    while (my $line = <$fh>) {
        # Match key-value pairs on the same line
        while ($line =~ /([-\w]+)=>(.+?)(?=\s[-\w]+=>|\s*$)/g) {
            my $key = $1;
            my $value = $2;
            # Remove leading and trailing whitespace
            $value =~ s/^\s+|\s+$//g;
            # If the value starts with '{', capture multiple lines until '}'
            if ($value =~ /^\{/) {
                 $value = '';
                while ($line = <$fh>) {
                    last if $line =~ /^\}/; # Stop when '}' is encountered
                    # $line =~ s/\}//g;
                    $value .= $line; # Append line to the value
                }
            }
            $key_value_pairs{$key} = $value;
        }
    }

    close($fh);

    # Read the file for processing (e.g., .html file)
    open($fh, '<', $file_for_process) or die "Can't open file $file_for_process: $!";
    
    my $output = '';

    # Read the file line by line
    while (my $line = <$fh>) {
        $line =~ s/"(.*?)"/exists $key_value_pairs{$1} ? "\"$key_value_pairs{$1}\"" : "\"$1\""/eg;
        $line =~ s/\[\[([^\]]+)\]\]/$key_value_pairs{$1} || ""/ge;
        $output .= $line;
    }
    close($fh);

    return $output;
}

# Main
print "Enter the directory path: ";
my $directory_path = <STDIN>;
chomp($directory_path);

# Create the output folder if it doesn't exist
my $output_folder = "$directory_path/output";
mkdir $output_folder unless -d $output_folder;

opendir(my $dir_handle, $directory_path) or die "Cannot open directory $directory_path: $!";

while (my $filename = readdir($dir_handle)) {
    next unless $filename =~ /^(.*?)\.html$/;
    my $html_file = "$directory_path/$filename";
    my $data_file = "$directory_path/$1.data";

    if (-e $data_file) {
        my $output_content = replace_keys_with_values($data_file, $html_file);

        # Write the modified content to output.html
        my $output_filename = "$output_folder/$1_output.html";
        open(my $output_fh, '>', $output_filename) or die "Can't open $output_filename for writing: $!";
        print $output_fh $output_content;
        close($output_fh);

        print "Content after replacement has been written to $output_filename\n";
    }
}

closedir($dir_handle);
