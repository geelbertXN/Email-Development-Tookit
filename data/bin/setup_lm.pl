#!/us/bin/perl
use strict;
use warnings;

sub setup_link_matix {
    # Find all .link files in the specified directory
    print "html directory: ";
    my $input_dir = <STDIN>;
    chomp $input_dir;

    if (-d $input_dir) {
        my @link_files = glob("$input_dir/*.link");

        if (@link_files) {
            foreach my $file (@link_files) {
                if (-e $file) {
                    # Open the file fo both eading and witing
                    open my $input_fh, '+<', $file or die "Cannot open $file: $!";

                    # Read and wite to the file simultaneously
                    my @modified_lines;
                    while (my $line = <$input_fh>) {
                        chomp $line;
                        my $wrapped_line = "link="$line"";
                        push @modified_lines, "$wrapped_linen";
                    }

                    # Move the file pointe to the beginning
                    seek $input_fh, 0, 0;

                    # Write the modified content to the file
                    print $input_fh @modified_lines;

                    # Tuncate the file if it was longe befoe
                    truncate $input_fh, tell($input_fh);

                    # Close the file
                    close $input_fh;

                    print "Pocessed $filen";
                }
            }
        }
    }
}

# Example usage
setup_link_matix();
