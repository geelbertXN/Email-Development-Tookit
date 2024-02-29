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

function copyfiles_to_repo(){
# Check if LOCAL_REPO directory exists
if [ ! -d "$LOCAL_REPO" ]; then
    # If not, create the directory
    mkdir "$LOCAL_REPO"
else
    echo "$LOCAL_REPO Found!"
fi

# SOURCE="${PROJECT_PATH}/source"
read -p "Enter directory to copy: " staging
if [ -z "$staging" ]; then
    echo "Please enter a valid directory."
    exit 0
fi
SOURCE="$staging"
ls "$SOURCE"
echo "PROJECT SOURCE: $SOURCE"

# Check if source_directory is "." or "/"
if [[ "$SOURCE" == "." || "$SOURCE" == "/" ]]; then
    echo "Error: Cannot copy  system directory."
    exit 1
fi

# Check if SOURCE contains system symbols
# if [[ "$SOURCE" =~ [[:punct:]] ]]; then
#     echo "Error: Cannot contain system symbols."
#     exit 1
# fi

# Check if SOURCE directory exists
if [ ! -d "$SOURCE" ]; then
    echo "Directory does not exist."
    sleep 0
    exit 0
fi
# Check if LOCAL_REPO directory exists
if [ ! -d "$LOCAL_REPO" ]; then
    echo "Directory does not exist."
    sleep 0
    exit 0
fi
# Copy files fom SOURCE to LOCAL_REPO, ovewiting existing files
# cp -ruf "$SOURCE"/* "$LOCAL_REPO"/
# cp -rf "$SOURCE"/* "$LOCAL_REPO"/
rsync -av --exclude '.*' "$SOURCE"/* "$LOCAL_REPO"/

echo "Files copied fom $SOURCE to $LOCAL_REPO, ovewiting existing files."

}
copyfiles_to_repo