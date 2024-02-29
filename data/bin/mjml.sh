#!/bin/bash

source_dir="./source"

# Output directory for HTML files
output_dir="./output_mjml"

# Create output directory if it doesn't exist


# Find all MJML files in the source directory
mjml_files=$(find "$source_dir" -maxdepth 1 -type f -name "*.mjml")

# Check if there are any MJML files
if [ -z "$mjml_files" ]; then
    echo "No MJML files found in $source_dir"
    exit 1
else
  
    # Check if the output directory already exists
if [ -d "$output_dir" ]; then
    echo "Output directory already exists."
    # Count the number of directories containing "output" in their names
    count=$(find . -maxdepth 1 -type d -name "*output*" | wc -l)
    new_dir="${output_dir}_$((count+1))"
    echo "Creating new directory: $new_dir"
    output_dir="$new_dir"
    mkdir -p "$output_dir"
else
    echo "Output directory doesn't exist. Creating it now."
    mkdir -p "$output_dir"
fi

    
    # Loop through each MJML file found and compile to HTML
    for file in $mjml_files; do
        # Extract the filename without the extension
        filename=$(basename "$file" .mjml)
        
        # Compile MJML to HTML
        echo "Compiling $file to $output_dir/$filename.html"
        mjml "$file" -o "$output_dir/$filename.html"
        
        # Check if compilation was successful
        if [ $? -eq 0 ]; then
            echo "Compilation successful!"
        else
            echo "Compilation failed for $file"
        fi
    done
fi

# Check if source directory exists
if [ -d "$source_dir" ]; then
    echo "Source directory exists."

    # Check if there are images in the source directory and its subdirectories
    images=$(find "$source_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \))

    if [ -n "$images" ]; then
        echo "Images found in source directory."

        # Create images folder in the output directory if it doesn't exist
        mkdir -p "$output_dir/images"

        # Copy images to the output directory
        find "$source_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -exec cp {} "$output_dir/images" \;
        echo "Images copied to $output_dir/images"
    else
        echo "No images found in source directory."
    fi
else
    echo "Source directory doesn't exist."
fi
