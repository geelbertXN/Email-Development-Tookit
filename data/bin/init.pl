#!/usr/bin/perl
use strict;
use warnings;
use File::Find;
use File::Spec;

my $CURRENT_PATH = `pwd`;
chomp($CURRENT_PATH);

my $PROJECT = "PROJECT_NAME=\"STORY-0000\"";
my $DATA_PATH = "DATA_PATH=\"$CURRENT_PATH/data\"";
my $LOCAL_REPO = "LOCAL_REPO=\"$CURRENT_PATH/REPO\"";
my $REMOTE_REPO = "REMOTE_REPO=\"https://bitbucket.ipgaxis.com/scm/mrmdet/onstar-email-components.git\"";
my $REMOTE_REPO_NEWT = "REPO_SECONDARY=\"https://bitbucket.ipgaxis.com/scm/EPS/gm-email.git\"";
my $DATA_PATH_P = "$CURRENT_PATH/data";

# Find and replace in app.sh
replace_in_files("app.sh");
replace_in_files("create_template_cue.sh");
replace_in_files("setup_config.sh");
replace_in_files("setup_git_ced.sh");
replace_in_files("git_pull.sh");
replace_in_files("git_push.sh");
replace_in_files("git_checkout.sh");
replace_in_files("copy_files_to_repo.sh");
replace_in_files_pl("insert_element.pl", $DATA_PATH_P);


# Generate build.sh with the desired command
open my $build_sh, '>', 'build.sh' or die "Cannot open build.sh: $!";
print $build_sh "#!/bin/bash\n";
print $build_sh "$PROJECT\n";
print $build_sh "$DATA_PATH\n";
print $build_sh "$LOCAL_REPO\n";
print $build_sh "$REMOTE_REPO\n";
print $build_sh "$REMOTE_REPO_NEWT\n";
print $build_sh "bash \"$CURRENT_PATH/data/app.sh\"\n";
close $build_sh;

# Make build.sh executable
chmod_executable('build.sh');

print "build.sh has been generated.\n";

my @directories = ('.', 'data', 'data/bin');

# find(\&process_file, @directories);

sub process_file {
    if (-f $_ && /\.(pl|sh)$/) {
        my $file_path = File::Spec->rel2abs($_);
        print "Changing permissions for $file_path\n";
        chmod_executable($file_path);
    }
}

sub replace_in_files {
    my ($file_pattern) = @_;
    system("find . -type f -name \"$file_pattern\" -exec perl -pi -e 's|^DATA_PATH=.*\$|$DATA_PATH|' {} +");
}
sub replace_in_files_pl {
    my ($file_pattern, $new_data_path) = @_;
    my @files = `find . -type f -name "$file_pattern"`;

    foreach my $file (@files) {
        chomp($file);
        local @ARGV = ($file);
        local $^I = '.bak';  # Create a backup with a .bak extension

        while (<>) {
            s|^my \$DATA_PATH=.*$|my \$DATA_PATH="$new_data_path";|;  # Replace the line with the new content
            print;
        }
    }
}

sub chmod_executable {
    my ($file) = @_;
    system("chmod +x $file");
}
# process_file();