#!/bin/bash
CURRENT_PATH="$(pwd)"
DATA_PATH="/mnt/c/Users/glc/Documents/MRM/ONSTAR/scripts/data"
BUILD_FILE="$CURRENT_PATH/build.sh"
# Extract project information
PROJECT_NAME=$(awk -F'"' '/PROJECT_NAME/ {print $2}' "$BUILD_FILE")
REPO=$(awk -F'"' '/LOCAL_REPO/ {print $2}' "$BUILD_FILE")
REMOTE_REPO=$(awk -F'"' '/REMOTE_REPO/ {print $2}' "$BUILD_FILE")
LOCAL_REPO="$REPO/$PROJECT_NAME"

# echo "LOCAL: $LOCAL_REPO"

if [ ! -d "$REPO" ]; then
    git clone "$REMOTE_REPO" "$REPO"
    exit 0
fi

if [ ! -d "$LOCAL_REPO" ]; then
    # If not, create the directory
    echo "LOCAL REPO: $LOCAL_REPO"
    echo "REMOTE: $REMOTE_REPO"
    mkdir -p "$LOCAL_REPO"

    cd "$LOCAL_REPO" || exit
    git status
    sleep 0
else
    echo "LOCAL REPO: $LOCAL_REPO"
    echo "REMOTE REPO: $REMOTE_REPO"
    cd "$LOCAL_REPO" || exit
    git status
    sleep 0
fi