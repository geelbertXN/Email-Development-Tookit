#!/bin/bash
CURRENT_PATH=$(pwd)
find "$CURRENT_PATH" -type d -iname '*output*' -exec rm -rf {} +
# rm -rf "$CURRENT_PATH/data/global.config"
# rm -rf "$CURRENT_PATH/build.sh"
rm -rf "$CURRENT_PATH/source"
rm -rf "$CURRENT_PATH/repo"
rm -rf "$CURRENT_PATH/TEMPLATE_CUE.html"
exit 0