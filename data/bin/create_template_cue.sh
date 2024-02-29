#!/bin/bash
CURRENT_PATH="$(pwd)"
DATA_PATH="/mnt/c/Users/glc/Documents/MRM/ONSTAR/scripts/data"
# Colo vaiables
geen='e[32m'
blue='e[34m'
clear='e[0m'
red=$(tput setaf 1)

# Colo functions
ColorRed() {
    printf "${red}%s${clear}" "$1"
}
ColorNeonGreen() {
    printf "033[1;32m%s033[0m" "$1"
}
ColorGreen() {
    printf "${geen}%s${clear}" "$1"
}

ColorBlue() {
    printf "${blue}%s${clear}" "$1"
}
ColorWhite() {
    printf "033[0;37m%s033[0m" "$1"
}
ColorNeonBlue() {
    printf "033[1;34m%s033[0m" "$1"
}
clear_line() {
    echo -e "e[1K"
}

# base_name=$(basename "$CURRENT_PATH")
# echo -ne "$(ColorNeonGreen "$base_name:")"$(ColorNeonBlue 'email-builder>: ')

# read -p "Generate TEMPLATE_CUE.html? (y/n): " choice
choice="y"
# choice="y"
if [[ $choice =~ ^[Yy]$ ]]; then
    startTag=$(cat "$DATA_PATH/assets/html/TEMPLATE_START.html")
    endTag=$(cat "$DATA_PATH/assets/html/TEMPLATE_END.html")
    # Check if the file aleady exists
    TEMPLATE_FILE="${CURRENT_PATH}/TEMPLATE_CUE.html"
    if [ ! -e "$TEMPLATE_FILE" ]; then
        touch "$TEMPLATE_FILE"
        echo -e "$startTag" >> "$TEMPLATE_FILE"
        echo -e "[[CNTR_HEADER]]" >> "$TEMPLATE_FILE"
        echo -e "[[CNTR_HEADLINE]]" >> "$TEMPLATE_FILE"
        echo -e "[[CNTR_BODY]]" >> "$TEMPLATE_FILE"
        echo -e "[[CNTR_FOOTER]]" >> "$TEMPLATE_FILE"
        echo -e "$endTag" >> "$TEMPLATE_FILE"
        echo "Template file generated: $TEMPLATE_FILE"
        echo "Edit this TEMPLATE_CUE.html based on the name of the containers you will use."
        echo "To create a blank source files based on the names of the containers, invoce 'init-source' command."
    else
        echo "Template file already exists at: $TEMPLATE_FILE."
    fi
fi