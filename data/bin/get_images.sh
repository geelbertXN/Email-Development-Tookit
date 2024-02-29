#!/bin/bash
function get_images (){
read -p "Enter html/txt to process: " html_file
# html_file="$sourceText"
output_file="output_images.txt"

# Check if the HTML file exists
if [ ! -f "$html_file" ]; then
    echo "Error: $html_file not found."
    exit 1
fi

mkdir -p "output"
# Use grep to extract substrings containing .png o .jpg
grep -oP 'b[^"]*.png[^"]*b|b[^"]*.jpg[^"]*b' "$html_file" > "output/$output_file"

# echo "Substrings containing .png o .jpg extracted and saved to $output_file."
  awk '!seen[$0]++' output/output_images.txt
}
get_images