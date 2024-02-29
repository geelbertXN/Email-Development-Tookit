#!/usr/bin/perl
use strict;
use warnings;

sub replace_links {
    print "html directory: ";
    my $input_dir = <STDIN>;
    chomp($input_dir);

    my $captured_link = "0";
    my $total_href_count = 0;
    my $total_href_counter = 0;
    my $local_counter = 0;
    my $counter = 0;


    if (-d $input_dir) {
        my @html_files = grep { $_ !~ /cue/ } glob("$input_dir/*.html");

        if (@html_files > 0) {
            for my $html_file (@html_files) {
                
                my $output_html = $html_file =~ s/.html$/_cue.html/r;
                my $output_link = $html_file =~ s/.html$/_cue.link/r;

                open my $input_fh, '<', $html_file or die "Cannot open input file: $!";
                open my $output_fh, '>', $output_html or die "Cannot open output file: $!";
                open my $link_fh, '>', $output_link or die "Cannot open link file: $!";

                while (my $line = <$input_fh>) {
                    $counter++;
                    my $local_counter = sprintf("%02d", $counter);
                    if ($line =~ /<!--.*link=(.*?)-->/) {
                            $captured_link = $1;
                            $captured_link =~ s/\s+//g;
                        print "RLINK: $captured_link\n";
                    }
                    
                    if ($line =~ /href/ && $captured_link ne "") {
                        my $link_num = () = $line =~ /href/g;
                        my @label_values = $line =~ /_label="([^"]+)"/g;
                        my @category_values =  $line =~ /_category="([^"]+)"/g;
                        my @html_values = $line =~ /href="([^"]+)"/g;
                        my $current_num = 0;
                        my $current_num_str = "";
                        my $current_num_new;

                        #  print "_label values: ", join(", ", @label_values), "\n";
                        #  print "_category values: ", join(", ", @category_values), "\n";
                        #  print "href values: ", join(", ", @html_values), "\n";

                        for my $i (0..$#html_values) {
                            # print "_category values: ", join(", ", @category_values), "\n";
                            $current_num++;
                            $current_num_new = sprintf("%02d", $current_num);
                            if ($link_num > 1) {
                                $current_num_str = "-$current_num_new";
                            }
                            else {
                                $current_num_str = "";
                            }

                            $total_href_counter++;
                            $total_href_count = sprintf("%02d", $total_href_counter);
                            my $replacement = "${total_href_count}-${counter}-${captured_link}${current_num_str}";
                            my $replacement1 = "${total_href_count}-${counter}-${captured_link}${current_num_str}";
                            my $replacement2 = "${total_href_count}-${counter}-${captured_link}${current_num_str}";
                            my $replacement3 = "${total_href_count}-${counter}-${captured_link}${current_num_str}";
                            

                           
                            # $line =~ s/\Q$label_values[$i]\E/$replacement1/g;
                            # $line =~ s/\Q$category_values[$i]\E/$replacement2/g;
                            # $line =~ s/\Q$html_values[$i]\E/$replacement3/g;

                            # $line =~ s/_label="([^"]+)"/_label="$replacement1"/g;
                            # $line =~ s/_category="([^"]+)"/_category="$replacement2"/g;
                            # $line =~ s/href="([^"]+)"/href="$replacement3"/g;

                            $line =~ s/\Q_label="$label_values[$i]"\E/_label="$replacement"/;
                            $line =~ s/\Q_category="$category_values[$i]"\E/_category="$replacement"/;
                            $line =~ s/\Qhref="$html_values[$i]"\E/href="$replacement"/;

                            print $link_fh "link=\"$replacement1\"\n";
                            # print "$local_counter : $link_href\n";
                        }
                    }

                    print $output_fh $line;
                }

                close $input_fh;
                close $output_fh;
                close $link_fh;
            }

            print "lines processed: $counter\n";
        } else {
            print "No HTML files found in $input_dir.\n";
        }
    } else {
        print "Directory not found: $input_dir\n";
    }
}

replace_links;
