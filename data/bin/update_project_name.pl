#!/usr/bin/perl
use strict;
use warnings;
use File::Find;
use File::Spec;

# Prompt the user to type PROJECT_NAME
print "Please type PROJECT_NAME: ";

# Read the user input from STDIN
my $project_name = <STDIN>;

# Remove newline characters from the input
chomp($project_name);

# Check if PROJECT_NAME is empty
if ($project_name eq '') {
    print "Warning: Please enter a valid PROJECT_NAME.\n";
    exit 1;
}

# Check if PROJECT_NAME is '.' or '/'
if ($project_name eq '.' or $project_name eq '/') {
    print "Warning: PROJECT_NAME cannot be '.' or '/'. Please enter a valid PROJECT_NAME.\n";
    exit 1;
}

replace_in_files("build.sh");

sub replace_in_files {
    my ($file_pattern) = @_;
    system("find . -type f -name \"$file_pattern\" -exec perl -pi -e 's|^PROJECT_NAME=.*\$|PROJECT_NAME=\"$project_name\"|' {} +");
}
print "Project name is now set to [ $project_name ]\n"