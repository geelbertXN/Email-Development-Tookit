#!/bin/bash
CURRENT_PATH=$(pwd)
read -p "Directory to delete (Pess Enter to exit):  " folder
#Check if source_directory contains system symbols, this will prevent from deleting system related files and system directories
if [[ "$folder" =~ [[:punct:]] ]]; then
    echo "LISTING $folder contents"
    ls "$folder"
    echo "Error: Permission denied. Cannot contain system path."
    exit 1
fi
if [ -z "$folder" ]; then
echo "Enter an existing directory!"
 exit 1
else
if [ ! -d "$CURRENT_PATH/$folder" ]; then
    echo "Directory does not exist!"
    exit 1
else
    dir="$CURRENT_PATH/$folder"
    rm -rf "$dir"
    echo "Directory deleted successfully."
fi
fi