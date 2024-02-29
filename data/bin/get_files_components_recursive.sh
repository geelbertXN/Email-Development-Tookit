#!/bin/bash

function get_files_components(){
    # Specify the directory path
    read -p "Get file names from directory: " directory
    # Check if the directory exists
    if [ -d "$directory" ]; then
        # List the files in the directory and its subdirectories and store the names in an array
        files=($(find "$directory" -type f))

        # Print the names of the files
        echo "Files in $directory and its subdirectories:"
        for file in "${files[@]}"; do
            # Extract only the file name from the full path
            filename=$(basename "$file")
            filename_x="${filename%.*}"
            echo "[[$filename_x]]"
        done
    else
        echo "Directory not found: $directory"
    fi
}

get_files_components
