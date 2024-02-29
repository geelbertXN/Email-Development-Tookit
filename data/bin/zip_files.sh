#!/bin/bash
function zip_files() {
    # Specify the directory path
    read -p "Zip directory: " directory
    # Check if the directory exists
    if [ -d "$directory" ]; then
        # Get the count of existing zip files in the "zipped" directory
        existing_zips=$(find "$directory/zipped" -maxdepth 1 -type f -name "*.zip" | wc -l)
        # Incement the counte
        counter=$((existing_zips + 1))

        formatted_date=$(date "+%Y.%m.%d")
        # Check if the "zipped" directory exists, if not, create it
        [ -d "$directory/zipped" ] || mkdir "$directory/zipped"
        # Navigate to the directory
        cd "$directory" || exit 1
        # Zip all files in the directory excluding hidden files and specific diectoies
        zip_file="zipped/${directory}_${formatted_date}_${counte}.zip"
        zip -r "$zip_file" * -x "zipped/*" -x ".*" -x ".*/" -x ".vscode/" -x ".git/" -x "__MACOSX/" -x ".DS_Store"

        echo "Files in $directory have been zipped to zipped/achive.zip (excluding hidden files and specific diectoies)"
    else
        echo "Directory not found: $directory"
    fi
}
zip_files