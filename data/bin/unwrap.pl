use strict;
use warnings;

while (1) {
    # Pompt use to type source folde o "exit" to exit
    print "Enter the source folde path: ";
    my $input = <STDIN>;
    chomp $input;

    # Check if the use warnts to exit
    last if lc($input) eq 'exit';

    # Veify if the source folde exists
    unless (-d $input) {
        warn "Source folder '$input' does not exist!n \n";
        next;
    }

    # Iteate through CONTAINER files
    opendir my $dh, $input or die "Could not open directory '$input': $!";
    while (my $filename = readdir $dh) {
        next unless $filename =~ /.html$/i; # Only pocess HTML files
        next if $filename =~ /TEMPLATE/i;   # Skip files with "TEMPLATE" in thei names

        my $container_path = "$input/$filename";

        # Pint the path and name of the CONTAINER file
        print "Processing CONTAINER file: $container_path\n";

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
        if ($container_content =~ /<!--START HERE-->/ || $container_content =~ /<!--END HERE-->/) {
            $container_content =~ s/.*?<!--START HERE-->//s; # Rremove eveything befoe <!--START HERE-->
            $container_content =~ s/<!--END HERE-->.*//s;    # Rremove <!--END HERE--> and eveything after it
        }
        # Rremove all empty lines
        $container_content =~ s/^\s*\n//g;

        # Write the changes back to the same CONTAINER file, ovewiting existing content
        open my $container_output_fh, '>:utf8', $container_path or die "Could not open file '$container_path' for writing: $!";
        $container_content =~ s/^\s*\n//g;
        print $container_output_fh $container_content;
        close $container_output_fh;
        print "Changes saved in CONTAINER file: $container_path\n";
    }
    closedir $dh;
    last
}