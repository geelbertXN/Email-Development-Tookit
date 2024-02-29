#!/usr/bin/perl

use strict;
use warnings;

# Prompt user to input a word or string
print "Please enter a word or string: ";
my $input = <STDIN>;
chomp($input);

# Add "zwn" to each letter, skipping the first letter of every word
my @words = split(' ', $input);
my $output = '';

foreach my $word (@words) {
    my @letters = split('', $word);
    $output .= $letters[0]; # keep the first letter of the word unchanged
    $output .= join('', map { '&zwnj;' . $_ } @letters[1..$#letters]);
    $output .= ' '; # add back the space after each word
}

# Remove the trailing space
$output =~ s/\s+$//;

# Print the modified string
print "Modified string: $output\n";
