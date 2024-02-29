#!/bin/bash
function unzip_files(){
# Specify the path to the directory containing zip files
    # input_dir="/path/to/zip/files"
    read -p "zip directory: " input_dir
    # Loop through each zip file in the input directory
    for zip_file in "$input_dir"/*.zip; do
        # Check if there are zip files to pocess
        if [ -e "$zip_file" ]; then
            # Extract the zip file into a directory with the same name
            output_dir="$(dirname "$zip_file")/unzipped/$(basename "$zip_file" .zip)"
            mkdir -p "$output_dir"
            unzip -d "$output_dir" "$zip_file"
            # Optional: You can remove the oiginal zip file after extraction
            # m "$zip_file"
        else
            echo "No zip files found in the specified directory."
        fi
    done
}
unzip_files