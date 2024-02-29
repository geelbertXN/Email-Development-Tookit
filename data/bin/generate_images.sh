#!/bin/bash

output_html="images.html"

# Prompt the user to enter the directory path
read -p "Enter the directory path to search for images: " directory

# Empty the index.html file
> "$output_html"

echo "<!DOCTYPE html>" > "$output_html"
echo "<html>" >> "$output_html"
echo "<head>" >> "$output_html"
echo "<title>Image Gallery</title>" >> "$output_html"
echo "</head>" >> "$output_html"
echo "<body>" >> "$output_html"
echo "<h1>Image Gallery</h1>" >> "$output_html"
echo "<div>" >> "$output_html"

# Find image files in the specified directory
images=$(find "$directory" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \))

# Loop through each image file and wrap it in an img tag with width set to half its actual size
for image in $images; do
    # Get the original width of the image
    width=$(file "$image" | awk -F ', ' '{print $2}' | awk -F ' x ' '{print $1}')
    # Calculate half of the original width
    half_width=$((width / 2))
    echo "<img src=\"$image\" alt=\"\" width=\"$half_width\" style=\"width:${half_width}px; display:block;\">" >> "$output_html"


done

echo "</div>" >> "$output_html"
echo "</body>" >> "$output_html"
echo "</html>" >> "$output_html"

echo "HTML file generated: $output_html"
