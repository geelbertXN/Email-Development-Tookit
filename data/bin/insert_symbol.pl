#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;
use File::Find;

# Define paths
my $CURRENT_PATH = "$(pwd)";
my $BUILD_FILE = "$CURRENT_PATH/build.sh";
my $DATA_PATH = "/mnt/c/Users/glc/Documents/MRM/ONSTAR/scripts/data";
my $ASSETS_HTML = "$DATA_PATH/assets/html";
# my $source_folder = "source";

print "Enter the directory path: ";
my $source_folder = <STDIN>;
chomp($source_folder);

my %special_characters = (
        'dollar' => '&#36;',
        '$' => '&#36;',
        '<' => '&lt;',
        '>' => '&gt;',
        '-' => '&#45;',
        '—' => '&#8212;',
        '†' => '&#8224;',
        '‡' => '&#8225;',
        '©' => '&#169;',
        '®' => '&#174;',
        '™' => '&#8482;',
        '§' => '&#167;',
        '…' => '&#8230;',
        '×' => '&#215;',
        '÷' => '&#247;',
        '¢' => '&#162;',
        '£' => '&#163;',
        '¥' => '&#165;',
        '€' => '&#8364;',
        '’' => '&#8217;'
    );

sub replace_special_chars {
    my ($content) = @_;
    foreach my $symbol (keys %special_characters) {
        if ($content =~ /$symbol/) {
            $content =~ s/\Q$symbol/$special_characters{$symbol}/g;
        }
    }
    return $content;
    print "$content";
}

print "DATA_PATH: $DATA_PATH\n";

# Open the source folder and read its contents
opendir(my $dh, $source_folder) or die "Could not open directory '$source_folder': $!";

# Loop through each file in the source folder
while (my $file = readdir($dh)) {
    next if $file =~ /^\./;  # Skip hidden files

    if (($file =~ /\.html$/ || $file =~ /\.mjml$/)) {
        my $full_path = "$source_folder/$file";

        open my $html_file, '<', $full_path or die "Could not open file '$full_path': $!";
        my $html_content = do {
            local $/ = undef;
            <$html_file>;
        };
        close $html_file;

        if ($html_content =~ /\[\{.*?\}\]/) {
            my @html_values = $html_content =~ /\[\{(.*?)\}\]/g;
            for my $i (0..$#html_values) {
                my $ivalue = $html_values[$i];
                
                    # print "Insert value $ivalue not found!\n";
                    foreach my $symbol (keys %special_characters) {
                        if ($html_content =~ /$symbol/) {
                           $html_content =~ s/\[\{($ivalue)\}\]/replace_special_chars($ivalue)/ge;
                        }
                    }
                
            }

            # Write the modified content back to the original HTML file
            open my $output_html, '>', $full_path or die "Could not open file '$full_path' for writing: $!";
            print $output_html $html_content;
            close $output_html;
        }
    }
}

closedir($dh);
