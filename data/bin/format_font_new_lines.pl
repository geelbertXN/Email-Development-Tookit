use strict;
use warnings;

my $font_css_file = 'source/font.css';

if (!-e $font_css_file) {
    die "File '$font_css_file' does not exist. Exiting.";
}
# Read the content of the font.css file
open my $fh, '<', 'source/font.css' or die "Cannot open font.css: $!";
my @lines = <$fh>;
close $fh;

# Initialize counter

foreach my $line (@lines) {
    # Add a new empty line at the beginning of every font-family string
    # $line =~ s/font-family:/\nfont-family:/g;
    my $count = 0;  # Counter to keep track of occurrences

    # Use a callback in the substitution to increment the counter
    # $line =~ s/font-family:/++$count == 1 ? "font-family:" : "\nfont-family:"/eg;
    # $line =~ s/font-family:/\nfont-family:/g;
     $line =~ s/font-family:/$count++ == 1 ? "\n\nfont-family:" : "font-family:"/eg;
    # $line =~ s/font-family:/$count++ == 1 ? "\n\nfont-family:" : "\nfont-family:"/eg;

    # Add a space at the end of the line if it's not there already
    $line .= ' ' unless $line =~ /\s$/;

    # Remove extra spaces
    $line =~ s/\s*:\s*/:/g;
    $line =~ s/;\s*/; /g;
    $line =~ s/\[\[|\]\]//g;
    $line =~ s/(-spacing:\s*-\d+\.\d{2})\d*/$1/g;

    # Replace background with color
    $line =~ s/background:/color:/g;

}

# Write the modified content back to the font.css file
open my $fh_out, '>', 'source/font.css' or die "Cannot open font.css: $!";
print $fh_out join('', @lines);
close $fh_out;

# Open the file again to read and replace font names and styles based on font weight
open $fh, '<', 'source/font.css' or die "Cannot open font.css: $!";
@lines = <$fh>;
close $fh;

foreach my $line (@lines) {
    if ($line =~ /font-weight:\s*450;/) {
        $line =~ s/CircularXX;/'CircularXX-Book', Arial, sans-serif; -webkit-text-size-adjust:none;/g;
    }
    elsif ($line =~ /font-weight:\s*500;/) {
        $line =~ s/CircularXX;/'CircularXX-Medium', Arial, sans-serif; -webkit-text-size-adjust:none;/g;
    }
    elsif ($line =~ /font-weight:\s*700;/) {
        $line =~ s/CircularXX;/'CircularXX-Bold', Arial, sans-serif; font-style:bold; -webkit-text-size-adjust:none;/g;
    }else{
        $line =~ s/CircularXX;/'CircularXX-Book', Arial, sans-serif; -webkit-text-size-adjust:none;/g;
    }

    $line .= "\n"; # Add a new line at the end of each line
}

# Write the modified content back to the font.css file
open $fh_out, '>', 'source/font.css' or die "Cannot open font.css: $!";
print $fh_out join('', @lines);
close $fh_out;
