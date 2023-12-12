#!/bin/bash

template_file="config"
output_folder="output"
timestamp=$(date +"%Y%m%d%H%M%S")

# Check if the output folder already exists
if [ -d "$output_folder" ]; then
    # If it exists, append the timestamp to make it unique
    output_folder="${output_folder}_${timestamp}"
fi

mkdir -p "$output_folder"

searches=($(grep -oP '\[\[.*?\]\]' "$template_file" | sed 's/\[\[\(.*\)\]\]/\1/'))

index=1
combined_content=""

for search_string in "${searches[@]}"; do
    # files_to_read=($(find . -maxdepth 2 -mindepth 2 -type f -name "*$search_string*.html" -not -path "./$output_folder/*"))
    # files_to_read=($(find . -maxdepth 2 -mindepth 2 -type f -iname "*$search_string*.html" -not -ipath "*output*"))
    files_to_read=($(find . -maxdepth 2 -mindepth 2 -type f -iname "*$search_string*.html" -not -ipath "*output*" -not -path "./$output_folder/*"))

    # Check if there are no files matching the search criteria
    if [ ${#files_to_read[@]} -eq 0 ]; then
        # Create an empty HTML file in the output folder
        touch "$output_folder/${index}_!NOT_FOUND_${search_string}.html"
        ((index++))
        echo "No match found for $search_string. Empty HTML file created."
    else
        for file in "${files_to_read[@]}"; do
            content=$(cat "$file")

            # Use basename to get the filename without the path
            filename=$(basename "$file")

            # Use parameter expansion to replace spaces with underscores
            filename="${filename// /_}"

            # Construct the new file path within the output folder
            new_file="$output_folder/${index}_${search_string}.html"

            # Increment the index for the next file
            ((index++))

            # Write the content to the new HTML file in the output folder
            echo -e "$content" > "$new_file"

            echo "Content of $file written to $new_file"
        done
    fi
done
