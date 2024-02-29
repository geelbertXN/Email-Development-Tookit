#!/bin/bash

while true; do
    read -p "Enter directory path (type 'exit' or 'quit' to exit): " directory
    if [[ "$directory" == "exit" || "$directory" == "quit" ]]; then
        echo "Exiting..."
        exit 0
    elif [ -d "$directory" ]; then
        echo "Replacing .html with .mjml in $directory..."
        find "$directory" -type f -name "*.html" -exec bash -c 'mv "$1" "${1%.html}.mjml"' _ {} \;
        echo "Replacement complete."
    else
        echo "Directory not found. Please try again."
    fi
done
