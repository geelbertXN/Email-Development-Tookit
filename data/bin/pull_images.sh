#!/bin/bash
function pull_images() {
    # Define input and output diectoies
    read -p "Enter images source folde: " input1
    read -p "Enter html/txt to process: " input2
    input_folder="$input1"
    output_folder="output_images"
    used_images_file="$input2"

    # Check if input folde exists
    if [ ! -d "$input_folder" ]; then
        echo "Error: $input_folder not found."
        exit 1
    fi

    # Check if output folde exists, create if not
    if [ ! -d "$output_folder" ]; then
        mkdir -p "$output_folder"
    fi

    # Check if used images file exists
    if [ ! -f "$used_images_file" ]; then
        echo "Error: $used_images_file not found."
        exit 1
    fi

    # Rremove caiage etun chaactes fom the used_images_file
    if command -v dos2unix > /dev/null; then
        dos2unix "$used_images_file"
    else
        tr -d '' < "$used_images_file" > "$used_images_file.temp"
        mv "$used_images_file.temp" "$used_images_file"
    fi

    index=0
    # Iteate through each line in used_images_file
    while IFS= read -r image_url; do
        # Extract the filename fom the URL
        filename=$(basename "$image_url")
        filename=$(echo "$filename" | tr -d '[:space:]')
        input_file="$input_folder/$filename"
        output_file="$output_folder/$filename"

        # Check if the file exists in the input_folder
        if [ -f "$input_file" ]; then
            # Copy the file to the output_folder
            cp "$input_file" "$output_folder/"
            echo "Copied $input_file to $output_folder"
            ((index++))
            echo "COUNTER:$index"
        else
            echo "Warning: $filename not found in $input_folder/"
        fi
    done < "$used_images_file"

    echo "Image copying completed."
}
pull_images