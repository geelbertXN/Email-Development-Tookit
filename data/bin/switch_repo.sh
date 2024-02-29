#!/bin/bash

CURRENT_PATH="$(pwd)"
BUILD_FILE="$CURRENT_PATH/build.sh"

# Read the current values of REMOTE_REPO and REPO_SECONDARY from build.sh
REMOTE_REPO=$(awk -F'"' '/REMOTE_REPO/ {print $2}' "$BUILD_FILE")
REPO_SECONDARY=$(awk -F'"' '/REPO_SECONDARY/ {print $2}' "$BUILD_FILE")

# Swap the values
temp=$REMOTE_REPO
REMOTE_REPO=$REPO_SECONDARY
REPO_SECONDARY=$temp

# Update the build.sh file with the new values
awk -v new_remote_repo="$REMOTE_REPO" -v new_repo_secondary="$REPO_SECONDARY" \
  'BEGIN {OFS = FS = "\""} 
   $0 ~ /REMOTE_REPO/ {$2 = new_remote_repo} 
   $0 ~ /REPO_SECONDARY/ {$2 = new_repo_secondary} 
   {print}' "$BUILD_FILE" > "$BUILD_FILE.tmp" && mv "$BUILD_FILE.tmp" "$BUILD_FILE"

echo "Updated REMOTE_REPO to: $REMOTE_REPO"
echo "Updated REPO_SECONDARY to: $REPO_SECONDARY"
