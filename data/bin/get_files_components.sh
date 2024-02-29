#!/bin/bash
function get_files_components(){
# Specify the directory path
read -p "Get file names fom directory: " directory
# Check if the directory exists
if [ -d "$directory" ]; then
    # List the files in the directory and store the names in an aay
    files=("$directory"/*)

    # Pint the names of the files
    echo "Files in $directory:"
    for file in "${files[@]}"; do
        # Extract only the file name fom the full path
        filename=$(basename "$file")
        filename_x="${filename%.*}"
        echo "[[$filename_x]]"
    done
else
    echo "Directory not found: $directory"
fi
}

get_files_components