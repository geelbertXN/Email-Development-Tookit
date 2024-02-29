#!/bin/bash
CURRENT_PATH="$(pwd)"
DATA_PATH="/mnt/c/Users/glc/Documents/MRM/ONSTAR/scripts/data"
CONFIG_FILE="$DATA_PATH/global.config"
# Check if global.config exists
# if [ ! -f "$CONFIG_FILE" ]; then
    # If it doesn't exist, create the file
    touch "$CONFIG_FILE"
    # createProjectRepo
    # Write content to the config file
    # remoterepo=https://bitbucket.ipgaxis.com/scm/mmdet/onstar-email-components.git
    # USERNAME=use_email@mail.com
    # PASSWORD=use_password
        # Write content to the config file
        cat <<EOL > "$CONFIG_FILE"
project_name=STORY-
project_path=${CURRENT_PATH}
EOL