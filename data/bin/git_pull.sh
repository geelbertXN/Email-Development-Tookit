#!/bin/bash
CURRENT_PATH="$(pwd)"
BUILD_FILE="$CURRENT_PATH/build.sh"
DATA_PATH="/mnt/c/Users/glc/Documents/MRM/ONSTAR/scripts/data"
# Extract project information
LOCAL_REPO=$(awk -F'"' '/LOCAL_REPO/ {print $2}' "$BUILD_FILE")
REMOTE_REPO=$(awk -F'"' '/REMOTE_REPO/ {print $2}' "$BUILD_FILE")

echo "LOCAL REPO: $LOCAL_REPO"
echo "REMOTE REPO: $REMOTE_REPO"
# Git credentials
REPO_URL="$REMOTE_REPO"

# Destination directory fo the repositoy
DEST_DIR="$LOCAL_REPO"

# Check if the destination directory exists, if not, clone the repositoy
if [ ! -d "$DEST_DIR" ]; then
    git clone "$REPO_URL" "$DEST_DIR"

    git config --global credential.helper 'cache --timeout=3600'
else
# Change to the destination directory
cd "$DEST_DIR" || exit

# Pefom a git pull
git pull
git config --global credential.helper 'cache --timeout=3600'
fi

