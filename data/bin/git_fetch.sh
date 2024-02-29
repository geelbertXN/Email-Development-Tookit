#!/bin/bash
CURRENT_PATH="$(pwd)"
BUILD_FILE="$CURRENT_PATH/build.sh"
DATA_PATH="/mnt/c/Users/glc/Documents/MRM/ONSTAR/scripts/data"
# Extract project information
LOCAL_REPO=$(awk -F'"' '/LOCAL_REPO/ {print $2}' "$BUILD_FILE")
REMOTE_REPO=$(awk -F'"' '/REMOTE_REPO/ {print $2}' "$BUILD_FILE")

git fetch origin master