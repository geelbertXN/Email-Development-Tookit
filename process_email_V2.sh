#!/bin/bash

config="config"
output_folder="Z_OUTPUT_FOLDER"
timestamp=$(date +"%Y%m%d%H%M%S")

# Check if the output folder already exists
if [ -d "$output_folder" ]; then
    # If it exists, append the timestamp to make it unique
    output_folder="${output_folder}_${timestamp}"
fi

empty_html_file="$output_folder/TEMPLATE_.html"

mkdir -p "$output_folder"
# Use touch to create an empty HTML file
touch "$empty_html_file"

searches=($(grep -oP '\[\[.*?\]\]' "$config" | sed 's/\[\[\(.*\)\]\]/\1/'))

index=1

for search_string in "${searches[@]}"; do
    # files_to_read=($(find . -maxdepth 2 -mindepth 2 -type f -name "*$search_string*.html" -not -path "./$output_folder/*"))
    # files_to_read=($(find . -maxdepth 2 -mindepth 2 -type f -iname "*$search_string*.html" -not -ipath "*output*"))
    files_to_read=($(find . -maxdepth 2 -mindepth 2 -type f -iname "*$search_string*.html" -not -ipath "*output*" -not -path "./$output_folder/*"))

    # Check if there are no files matching the search criteria
    if [ ${#files_to_read[@]} -eq 0 ]; then
        # Create an empty HTML file in the output folder
        touch "$output_folder/${index}_XXXXXXXXX_${search_string}.html"
        
        ((index++))
        echo "No match found for $search_string. Empty HTML file created."
        echo -e "<!--  [[$search_string NOT FOUND]] -->" >> "$empty_html_file"
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
            # echo -e "$content" > "$new_file"

            # echo "Content of $file written to $new_file"
            # Wrap the content within an HTML table
            # table_content="<table border='1'><tr><th>Filename</th><th>Content</th></tr><tr><td>$filename</td><td>$content</td></tr></table>"

            # Write the content to the new HTML file in the output folder wrapped in table
            echo -e "<!-- ${search_string} START -->" >> "$new_file"
            echo -e '<table border="0" align="center" cellspacing="0" cellpadding="0" bgcolor="#ffffff" width="100%" style="width: 100%;">' >> "$new_file"
            echo -e '<tr>' >> "$new_file"
            echo -e '<td width="100%" align="left" style="padding: 0 0 0 0;">' >> "$new_file"
            echo -e "$content" >> "$new_file"
            echo -e '</td>' >> "$new_file"
            echo -e '</tr>' >> "$new_file"
            echo -e '</table>' >> "$new_file"
            echo -e "<!-- ${search_string} END -->" >> "$new_file"
            
            echo -e "<!-- ${search_string} START -->">> "$empty_html_file"
            echo -e '<table border="0" align="center" cellspacing="0" cellpadding="0" bgcolor="#ffffff" width="100%" style="width: 100%;">' >> "$empty_html_file"
            echo -e '<tr>' >> "$empty_html_file"
            echo -e '<td width="100%" align="left" style="padding: 0 0 0 0;">' >> "$empty_html_file"
            echo -e "$content" >> "$empty_html_file"
            echo -e '</td>' >> "$empty_html_file"
            echo -e '</tr>' >> "$empty_html_file"
            echo -e '</table>' >> "$empty_html_file"
            echo -e "<!-- ${search_string} END -->">> "$empty_html_file"
            echo -e " " >> "$empty_html_file"
            echo -e " " >> "$empty_html_file"
        done
    fi
done


