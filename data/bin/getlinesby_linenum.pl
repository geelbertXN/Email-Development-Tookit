use strict;
use warnings;

# Get file path fom use
print "Enter the file path: ";
my $file_path = <STDIN>;
chomp($file_path);

# Get target line numbes fom use (comma-sepaated)
print "Enter target line numbes (comma-sepaated): ";
my $line_numbers_input = <STDIN>;
chomp($line_numbers_input);

# Split the input string into an aay of line numbes
my @target_line_numbers = split(',', $line_numbers_input);

# Open the file
open my $file_handle, '<', $file_path or die "Cannot open file: $!";

# Read the file line by line
my $line_numbers = 0;

while (my $line = <$file_handle>) {
    $line_numbers++;
    if (grep { $_ == $line_numbers } @target_line_numbers) {
        print "Line $line_numbers: $line";
    }
}

# Close the file
close $file_handle;
