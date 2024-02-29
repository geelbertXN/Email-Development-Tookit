#!/bin/bash
# find . -type d -iname '*output*' -exec rm -rf {} +
CURRENT_PATH=$(pwd)
find "$CURRENT_PATH" -type d -iname '*output*' -exec rm -rf {} +
echo "------------------------------------------------------------------"
echo "           ALL OUTPUT FOLDERS ARE PERMANENTLY DELETED             "
echo "------------------------------------------------------------------"
CTR=0
output_dir="$CURRENT_PATH/output"
sleep 0
# find . -type d -iname '*output*' -exec m -i {} +
# find . -type d -iname '*output*' -exec m - {} +