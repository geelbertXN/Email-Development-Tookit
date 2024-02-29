#!/bin/bash!/bin/bash
function fixFiles() {
    # Specify the directory containing HTML files
    read -p "repair files: " directory

    # Check if the directory exists
    if [ -d "$directory" ]; then
        # Change to the directory
        cd "$directory"

        # Run tr -d '' on all HTML files
        for file in *; do
            if [ -f "$file" ]; then
                echo "Processing $file..."
                tr -d '' < "$file" > "$file.tmp" && mv "$file.tmp" "$file"
                echo "Done."
            fi
        done
        echo "Script completed successfully."
    else
        echo "Error: Directory $directory not found."
    fi
}
fixFiles

