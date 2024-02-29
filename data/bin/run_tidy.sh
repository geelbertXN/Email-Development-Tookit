#!/bin/bash

# Function to format HTML content using node-js-beautify
format_html() {
    local file_path="$1"
    node-js-beautify -r "$file_path"
}

# Main function
main() {
    source_folder="source"

    # Loop through HTML files with "CONTAINER_" in their names
    for file in "$source_folder"/CONTAINER_*.html; do
        if [ -f "$file" ]; then
            echo "Formatting $file ..."
            # Format HTML content
            format_html "$file"
            echo "Formatted HTML saved to ${file}_formatted.html"
        else
            echo "No HTML files found with CONTAINER_ in the source folder."
            exit 1
        fi
    done
}

# Run the main function
main
