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
my $source_folder = "source";

my %special_characters = (
        '&' => '&amp;',
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
    # $content =~ s/&/&amp;/g;
    # $content =~ s/</&lt;/g;
    # $content =~ s/>/&gt;/g;
    # $content =~ s/-/&#45;/g;
    # $content =~ s/—/&#8212;/g;
    # $content =~ s/†/&#8224;/g;
    # $content =~ s/‡/&#8225;/g;
    # $content =~ s/©/&#169;/g;
    # $content =~ s/®/&#174;/g;
    # $content =~ s/™/&#8482;/g;
    # $content =~ s/§/&#167;/g;
    # $content =~ s/…/&#8230;/g;
    # $content =~ s/×/&#215;/g;
    # $content =~ s/÷/&#247;/g;
    # $content =~ s/¢/&#162;/g;
    # $content =~ s/£/&#163;/g;
    # $content =~ s/¥/&#165;/g;
    # $content =~ s/€/&#8364;/g;
    # $content =~ s/’/&#8217;/g;
    foreach my $symbol (keys %special_characters) {
        if ($content =~ /$symbol/) {
            $content =~ s/\Q$symbol/$special_characters{$symbol}/g;
        }
    }
    return $content;
}

print "DATA_PATH: $DATA_PATH\n";

# Open the source folder and read its contents
opendir(my $dh, $source_folder) or die "Could not open directory '$source_folder': $!";

# Loop through each file in the source folder
while (my $file = readdir($dh)) {
    next if $file =~ /^\./;  # Skip hidden files

    if (($file =~ /\.html$/ || $file =~ /\.mjml$/) && $file =~ /CONTAINER_/) {
        my $full_path = "$source_folder/$file";

        open my $html_file, '<', $full_path or die "Could not open file '$full_path': $!";
        my $html_content = do {
            local $/ = undef;
            <$html_file>;
        };
        close $html_file;

        if ($html_content =~ /\[\[.*?\]\]/) {
            my @html_values = $html_content =~ /\[\[(.*?)\]\]/g;
            for my $i (0..$#html_values) {
                my $ivalue = $html_values[$i];
                my $content_path;

                # Find HTML file recursively
                find(
                    sub {
                        if (-f $_ && $_ eq "$ivalue.html") {
                            $content_path = $File::Find::name;
                        }
                    },
                    $ASSETS_HTML
                );

                if ($content_path) {
                    open my $i_html, '<', $content_path or die "Could not open file '$content_path': $!";
                    my $i_content = do {
                        local $/ = undef;
                        <$i_html>;
                    };
                    close $i_html;

                    my @lines = split(/\n/, $i_content);
                    my $num_lines = scalar @lines;

                    my $is_first_line = 1;

                    foreach my $line (@lines) {
                        # Add 5 spaces to all lines except the first one
                        if (!$is_first_line) {
                            $line = ' ' x 0 . $line;
                        }
                        $is_first_line = 0;  # Set to false after processing the first line
                    }

                    # Join the lines back together
                    $i_content = join("\n", @lines);

                    $html_content =~ s/\[\[$ivalue\]\]/$i_content/g;
                } else {
                    print "Insert value [[$ivalue]] not found.\n";
                    print "If you are fetching value [[$ivalue]] from data, use i-r.\n";
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
