#!/bin/bash
CURRENT_PATH="$(pwd)"
old_dir="$CURRENT_PATH/output"
new_dir="$CURRENT_PATH/source"

if [ ! -e "TEMPLATE_CUE.html" ]; then
    exit 1
fi

# Check if the 'source' directory does not exist befoe enaming
if [ ! -d "$new_dir" ]; then
    # Check if the 'output' directory exists befoe enaming
    if [ -d "$old_dir" ]; then
        mv "$old_dir" "$new_dir"
        echo "Source folder created at $new_dir'."
        echo "NOTE: Once source folder is created, you cannot overwrite it."
        echo "If you invoke 'init-source' when the source folder already exist"
        echo "the generated files will be directed to an output folder."

    else
        echo "Directory 'output' not found in $CURRENT_PATH."
    fi
else
    echo "Directory 'source' aleady exists in $CURRENT_PATH."
    echo "The generated html files will be directed in the output folder"
fi