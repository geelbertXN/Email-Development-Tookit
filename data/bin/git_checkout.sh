#!/bin/bash
CURRENT_PATH="$(pwd)"
BUILD_FILE="$CURRENT_PATH/build.sh"
DATA_PATH="/mnt/c/Users/glc/Documents/MRM/ONSTAR/scripts/data"
# Extract project information
LOCAL_REPO=$(awk -F'"' '/LOCAL_REPO/ {print $2}' "$BUILD_FILE")
REMOTE_REPO=$(awk -F'"' '/REMOTE_REPO/ {print $2}' "$BUILD_FILE")

# Prompt the user to enter a branch name
read -p "Enter the name of the branch to checkout: " branch_name

# Perform git checkout
git checkout $branch_name