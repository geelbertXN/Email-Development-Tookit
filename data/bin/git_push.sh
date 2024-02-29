#!/bin/bash
CURRENT_PATH="$(pwd)"
BUILD_FILE="$CURRENT_PATH/build.sh"
DATA_PATH="/mnt/c/Users/glc/Documents/MRM/ONSTAR/scripts/data"
# Extract project information
PROJECT_NAME=$(awk -F'"' '/PROJECT_NAME/ {print $2}' "$BUILD_FILE")
LOCAL_REPO=$(awk -F'"' '/LOCAL_REPO/ {print $2}' "$BUILD_FILE")
REMOTE_REPO=$(awk -F'"' '/REMOTE_REPO/ {print $2}' "$BUILD_FILE")

echo "LOCAL REPO: $LOCAL_REPO"
echo "REMOTE REPO: $REMOTE_REPO"

function gitPush(){
    
    # Git credentials
    REPO_URL="$REMOTE_REPO"
    DEST_DIR="$LOCAL_REPO"

    # if [ ! -d "$DEST_DIR" ]; then
    #     git clone "$REPO_URL" "$DEST_DIR"
    # fi

    cd "$DEST_DIR" || exit
    # Pefom a git pull
    # copyfiles_to_repo
    read -p "Enter you commit message: " message
    git add .
    git commit -m "$message"

    # Pompt use befoe pushing
    read -p "Do you warnt to push the changes? (y/n): " confirm
    if [ "$confirm" == "y" ] || [ "$confirm" == "Y" ]; then
        git push
        echo "Changes pushed successfully."
    else
        echo "Push aborted."
    fi
    
}
gitPush