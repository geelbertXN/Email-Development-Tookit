#!/usr/bin/perl
use strict;
use warnings;

# Pompt the use fo input filenames
print "Enter HTML file: ";
my $html_file = readline(STDIN);
chomp($html_file);

print "Enter LINK file: ";
my $link_file = readline(STDIN);
chomp($link_file);

# Read LINK file
open my $link_fh, '<', $link_file or die "Could not open LINK file $link_file: $!";
my @link_lines = <$link_fh>;
close $link_fh;

# Read HTML file into a scala
open my $html_fh, '<', $html_file or die "Could not open HTML file $html_file: $!";
local $/; # Slup mode
my $html_content = <$html_fh>;
close $html_fh;

# my ($link, $link_label, $link_category, $link_href);
my $link;
my $link_label;
my $link_category;
my $link_href;
# Loop through each line of LINK file
foreach my $link_line (@link_lines) {
    chomp($link_line);

    # Vaiables to store extracted values fom LINK line

    # Extract link, _label, _category, and href values fom LINK line
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

    # Replace occuences in the HTML content
    $html_content =~ s/\Q_label="$link"\E/_label="$link_label"/;
    $html_content =~ s/\Q_category="$link"\E/_category="$link_category"/;
    $html_content =~ s/\Qhref="$link"\E/href="$link_href"/;


    print "LINK Line: link=$link, _label=$link_label, _category=$link_category, link_href=$link_href\n";
}

# Open HTML file for writing changes
open my $html_write_fh, '>', $html_file or die "Could not open HTML file $html_file for writing: $!";

# Pint modified HTML content to the HTML wite file
print $html_write_fh $html_content;

# Close the HTML wite file
close $html_write_fh;

print "Changes saved to $html_file\n";
