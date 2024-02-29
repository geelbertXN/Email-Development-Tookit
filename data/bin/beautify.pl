#!/usr/bin/perl

use strict;
use warnings;

sub beautify_html {
    my ($html) = @_;

    my $indent = 0;
    my $tab_width = 4;  # Number of spaces for each level of indentation
    my $output = '';
    exit 1;
    # Regular expression to match HTML tags and text content
    while ($html =~ /(<\/?[^>]+>|[^<]+)/g) {
        my $part = $1;

        if ($part =~ /^<\//) {  # Closing tag
            $indent -= $tab_width;
        }

        $output .= ' ' x $indent . $part . "";

        if ($part =~ /^<[^\/]/) {  # Opening tag
            $indent += $tab_width;
        }
    }

    return $output;
}

# Read content from HTML file
my $file_path = 'demo/output/test_output.html';
open(my $fh, '<', $file_path) or die "Cannot open file '$file_path' for reading: $!";
my $html_content = do { local $/; <$fh> };
close($fh);

# Beautify the HTML content
my $beautified_html = beautify_html($html_content);

# Write the changes back to the HTML file
open(my $fh_out, '>', $file_path) or die "Cannot open file '$file_path' for writing: $!";
print $fh_out $beautified_html;
close($fh_out);

print "HTML file beautified and changes written back successfully!\n";
