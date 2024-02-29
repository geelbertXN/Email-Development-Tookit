#!/bin/bash
CURRENT_PATH="$(pwd)"
DATA_PATH="/mnt/c/Users/glc/Documents/MRM/ONSTAR/scripts/data"
BUILD_FILE="$CURRENT_PATH/build.sh"
PROJECT_NAME=$(awk -F'"' '/PROJECT_NAME/ {print $2}' "$BUILD_FILE")
REPO=$(awk -F'"' '/LOCAL_REPO/ {print $2}' "$BUILD_FILE")
REMOTE_REPO=$(awk -F'"' '/REMOTE_REPO/ {print $2}' "$BUILD_FILE")
LOCAL_REPO="$REPO/$PROJECT_NAME"

echo "LOCAL REPO: $LOCAL_REPO"
echo "REMOTE REPO: $REMOTE_REPO"
function copy_folde_to_repo(){
    read -p "Enter folder to copy: " source_directory
    ls "$source_directory"
    # Check if source_directory contains system symbols
    # if [[ "$source_directory" =~ [[:punct:]] ]]; then
    #     echo "Error: Permission denied."
    #     exit 1
    # fi
    # Check if source_directory is "." or "/"
    if [[ "$source_directory" == "." || "$source_directory" == "/"  ]]; then
        echo "Error: Permission denied."
        exit 1
    fi

    # Check if SOURCE directory exists
    if [ ! -d "$source_directory" ]; then
        echo "Directory does not exist."
        sleep 0
        exit 0
    fi
    # Check if LOCAL_REPO directory exists
    if [ ! -d "$LOCAL_REPO" ]; then
        # If not, create the directory
        mkdir "$LOCAL_REPO"
    else
        echo "$LOCAL_REPO Found!"
    fi
    # Destination directory
    destination_directory="$LOCAL_REPO"
    # Copy the entie source directory to the destination directory
    cp -r "$source_directory" "$destination_directory"
    # Display a message indicating the copy opeation is complete
    echo "Folder copied from $source_directory  to  $destination_directory"
}
copy_folde_to_repo

