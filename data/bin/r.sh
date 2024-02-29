#!/bin/bash

# Prompt for the directory path
read -p "Enter a directory path to search for files (type 'exit' or 'quit' to exit): " directory

# Check if the user wants to exit
if [ "$directory" == "exit" ] || [ "$directory" == "quit" ]; then
    echo "Exiting..."
    exit 0
fi

# Prompt for the original and replacement strings
read -p "Enter the original string to search for: " original_string
read -p "Enter the replacement string: " replacement_string

# Exclude file
EXCLUDE_FILE="r.sh"

# Function to replace string in a file
replace_in_file() {
    local file="$1"
    if grep -q "$original_string" "$file"; then
        sed -i "s/$original_string/$replacement_string/g" "$file"
        echo "Replaced in file: $file"
    fi
}

# Function to check if a file is of allowed type
is_allowed_file_type() {
    local file="$1"
    case "$file" in
        *.txt | *.html | *.mjml)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Recursive function to process files in a directory and its subdirectories
process_files() {
    local dir="$1"
    for file in "$dir"/*; do
        # Check if the file is not the excluded file
        if [ "$file" != "$dir/$EXCLUDE_FILE" ]; then
            if [ -f "$file" ]; then
                # Check if the file is of allowed type
                if is_allowed_file_type "$file"; then
                    replace_in_file "$file"
                fi
            elif [ -d "$file" ]; then
                process_files "$file"
            fi
        fi
    done
}

# Check if the directory exists
if [ -d "$directory" ]; then
    # Start processing files in the specified directory and its subdirectories
    process_files "$directory"
    echo "Replacement process completed."
else
    echo "Directory not found. Exiting..."
    exit 1
fi
