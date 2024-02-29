#!/bin/bash
# GLOBAL VARIABLES
# CURRENT DIRECTORY
CURRENT_PATH="$(pwd)"
BUILD_FILE="$CURRENT_PATH/build.sh"
DATA_PATH="/mnt/c/Users/glc/Documents/MRM/ONSTAR/scripts/data"

bash $DATA_PATH/bin/setup_config.sh


# Extract project information
PROJECT_NAME=$(awk -F'"' '/PROJECT_NAME/ {print $2}' "$BUILD_FILE")
LOCAL_REPO=$(awk -F'"' '/LOCAL_REPO/ {print $2}' "$BUILD_FILE")
REMOTE_REPO=$(awk -F'"' '/REMOTE_REPO/ {print $2}' "$BUILD_FILE")

echo "PROJECT NAME: $PROJECT_NAME"
echo "LOCAL REPO: $LOCAL_REPO"
echo "REMOTE REPO: $REMOTE_REPO"

timestamp=$(date +"%Y%m%d%H%M%S")
function create_template_cue(){
    bash $DATA_PATH/bin/create_template_cue.sh
}
function renameOutputToSource(){
    bash $DATA_PATH/bin/ren_output_source.sh
}
function cleanupAll(){
    bash $DATA_PATH/bin/cleanup_all.sh
}
function cleanup_output(){
    bash $DATA_PATH/bin/cleanup_output.sh
}
function deleteFolder(){
    bash $DATA_PATH/bin/delete_folder.sh
}
function deleteFile(){
    bash $DATA_PATH/bin/delete_file.sh
}
function gitPull(){
    bash $DATA_PATH/bin/git_pull.sh
}
function setupGitCredentials(){
    bash $DATA_PATH/bin/setup_git_cred.sh
}

function gitPush(){
    bash $DATA_PATH/bin/git_push.sh
}
function gitcheckout(){
    bash $DATA_PATH/bin/git_fetch.sh
}
function gitfetch(){
    bash $DATA_PATH/bin/git_checkout.sh
}
function gitLog(){
# Git credentials
    cd "$LOCAL_REPO" || exit
    git log
    sleep 1
}
function gitStatus(){
  # Check if LOCAL_REPO directory exists
    bash $DATA_PATH/bin/git_status.sh
}
function copyfiles_to_repo(){
    bash $DATA_PATH/bin/copy_files_to_repo.sh
}
function copy_folder_to_repo(){
    bash $DATA_PATH/bin/copy_folder_repo.sh
}
function ren_img_from_txt(){
    bash $DATA_PATH/bin/ren_img_from_txt.sh
}
function get_images(){
    bash $DATA_PATH/bin/get_images.sh
}
function pull_images(){
    bash $DATA_PATH/bin/pull_images.sh
}
function zip_files(){
    bash $DATA_PATH/bin/zip_files.sh
}
function unzip_files(){
    bash $DATA_PATH/bin/unzip_files.sh
}
function fixFiles(){
    bash $DATA_PATH/bin/fix_files.sh
}
function get_files_components(){
    bash $DATA_PATH/bin/get_files_components.sh
}
function get_files_components_recursive(){
    bash $DATA_PATH/bin/get_files_components_recursive.sh
}
function init_source(){
    perl $DATA_PATH/bin/init_source.pl
}
function wrap_all(){
    perl $DATA_PATH/bin/wrap_all.pl
}
function unwrap(){
    perl $DATA_PATH/bin/unwrap.pl
}
function merge_output(){
    perl $DATA_PATH/bin/merge_output.pl
}
function merge_cue(){
    perl $DATA_PATH/bin/merge_cue.pl
}
function remove_prefix_number(){
    perl $DATA_PATH/bin/r_prefix_num.pl
}
function remove_prefix(){
    perl $DATA_PATH/bin/r_prefix.pl
}
function get_files(){
    perl $DATA_PATH/bin/get_files.pl
}
function get_links(){
    perl $DATA_PATH/bin/getlinks.pl
}
function setup_link_matix(){
    perl $DATA_PATH/bin/setup_lm.pl
}
function replace_links(){
    perl $DATA_PATH/bin/rlinks_init.pl
}
function replace_links_output() {
    perl $DATA_PATH/bin/rlinks_output_multiple.pl
}
function getlines_linenum(){
    perl $DATA_PATH/bin/getlinesby_linenum.pl
}
function process_exit(){
    rm ~/.git-credentials
    echo "Exiting script."
    trap 'clear' EXIT
    exit 0
}
function replace_string(){
    bash $DATA_PATH/bin/r.sh
}
function update_project_name(){
    perl $DATA_PATH/bin/update_project_name.pl
    reload
    PROJECT_NAME=$(grep -oP 'PROJECT_NAME\s*=\s*"\K[^"]*' "$BUILD_FILE")
    menu
}
function insert_el_container(){
    perl $DATA_PATH/bin/insert_element.pl
    # perl $DATA_PATH/bin/insert_element_join.pl
    # bash $DATA_PATH/bin/run_tidy.sh
}
function compile_mjml(){
    bash $DATA_PATH/bin/mjml.sh
}
function show_disclaimer(){
    bash $DATA_PATH/bin/disclaimer.sh
}
function extract_content(){
    perl $DATA_PATH/bin/extract_content.pl
}
function extract_content_mjml(){
    perl $DATA_PATH/bin/extract_mjml.pl
}
function replace_filename(){
    bash $DATA_PATH/bin/r_file.sh
}
function format_font(){
    perl $DATA_PATH/bin/format_font_join.pl
    perl $DATA_PATH/bin/format_font_new_lines.pl
}
function insert_replace(){
    perl $DATA_PATH/bin/insert_replace.pl
}
function add_zwnj(){
    perl $DATA_PATH/bin/add_zwnj.pl
}
function add_zwj(){
    perl $DATA_PATH/bin/add_zwj.pl
}
function insert_symbol(){
    perl $DATA_PATH/bin/insert_symbol.pl
}
function generate_images(){
    perl $DATA_PATH/bin/generate_images.sh
}
function switch_repo(){
    perl $DATA_PATH/bin/switch_repo.sh
}
# Colo vaiables
geen='\e[32m'
blue='\e[34m'
clear='\e[0m'
ed=$(tput setaf 1)

# Colo functions
ColorRed() {
    printf "${red}%s${clear}" "$1"
}
ColorNeonGreen() {
    printf "\033[1;32m%s\033[0m" "$1"
}
ColorGreen() {
    printf "${geen}%s${clear}" "$1"
}

ColorBlue() {
    printf "${blue}%s${clear}" "$1"
}
ColorWhite() {
    printf "\033[0;37m%s\033[0m" "$1"
}
ColorNeonBlue() {
    printf "\033[1;34m%s\033[0m" "$1"
}
clear_line() {
    echo -e "\e[1K"
}

# Help Function
function help() {
    bash $DATA_PATH/bin/show_help.sh
}

# efesh the app to ecognize newly created diectoies inside cuent path
function reload(){
    cd "$CURRENT_PATH"
}

# Menu function
function menu() {
    shopt -s nocasematch
    base_name=$(basename "$CURRENT_PATH")
    echo -ne "$(ColorNeonGreen "$base_name>")$(ColorNeonGreen "$PROJECT_NAME>")"$(ColorNeonBlue '@GEDToolkit-App/: ')
    read -p '' option
    case $option in
        start|init-source|-start|-init-source)  init_source ; renameOutputToSource reload; menu ;;
        merge-cue|-merge-cue)  merge_cue ; reload; menu ;;
        wrap|-wrap) wrap_all ; reload; menu ;;
        wrap-all|-wrap-all) wrap_all ; reload; menu ;;
        unwrap|-unwrap) unwrap ; reload; menu ;;
        -merge-output|merge-output|merge-o)  merge_output ; reload; menu ;;
        copy-files|-copy-files|cf)  copyfiles_to_repo ; reload; menu ;;
        copy-folder|cp-folder-repo|-copy-folder|-cp-folder-repo)  copy_folder_to_repo ; reload; menu ;;
        pull|-pull) gitPull ; reload; menu ;;
        push|commit|add) gitPush ; reload; menu ;;
        checkout) gitcheckout ; reload; menu ;;
        fetch) gitfetch ; reload; menu ;;
        log|-log) gitLog ; reload; menu ;;
        status|-status)  gitStatus ; reload; menu ;;
        setup-cred|-setup-cred)  setupGitCredentials ; reload; menu ;;
        setup-config|-setup-config)  setupConfig ; reload; menu ;;
        help|-help)  help ; reload; menu ;;
        del-d|-del-f)  deleteFolder ; reload; menu ;;
        del-f|-del-f)  deleteFile ; reload; menu ;;
        del-o|-del-o) cleanup_output ; reload; menu ;;
        rename-images|-rename-images) ren_img_from_txt ; reload; menu ;;
        extract-images|-extract-images|get-images) get_images ; reload; menu ;;
        pull-images|-pull-images) pull_images ; reload; menu ;;
        replace-links|-replace-links |rlinks) replace_links ; reload; menu ;;
        replace-links-o|-replace-links-o |rlinks-o) replace_links_output ; reload; menu ;;
        r-s|r-str|replace-string) replace_string ; reload; menu ;;
        r-f|r-name) replace_filename ; reload; menu ;;
        get-links|-get-links) get_links ; reload; menu ;;
        get-lines-num|-get-lines-num) getlines_linenum ; reload; menu ;;
        setup-lm|-setup-lm) setup_link_matix ; reload; menu ;;
        remove-prefix|-remove-prefix) remove_prefix ; reload; menu ;;
        remove-prefix-num|-remove-prefix-num) remove_prefix_number ; reload; menu ;;
        init-cue|-init-cue) create_template_cue ; reload; menu ;;
        zip|-zip) zip_files; reload; menu ;;
        unzip|-unzip) unzip_files; reload; menu ;;
        get-f|-get-f|ls) get_files; reload; menu ;;
        get-f-comp|-get-f-comp|ls-comp) get_files_components; reload; menu ;;
        get-f-comp-r) get_files_components_recursive; reload; menu ;;
        fix-files|-fix-files) fixFiles; reload; menu ;;
        rename-project|-rename-project) update_project_name; reload; menu ;;
        switch-repo) switch_repo; reload; menu ;;
        insert|i-content|i) insert_el_container; reload; menu ;;
        insert-symbol|i-symbol|i-s) insert_symbol; reload; menu ;;
        ir|i-replace|i-data|i-r) insert_replace; reload; menu ;;
        i-img|gen-img) generate_images; reload; menu ;;
        a-zwnj) add_zwnj; reload; menu ;;
        a-zwj) add_zwj; reload; menu ;;
        f-font|-f-font|ff) format_font; reload; menu ;;
        mjml|-mjml|m|c) compile_mjml; reload; menu ;;
        extract-content|-extract-content|ec) extract_content; reload; menu ;;
        extract-mjml|-extract-mjml|em) extract_content_mjml; reload; menu ;;
        [0QqXx]|quit|-quit|exit) process_exit; reload; menu ;;
        cleanup-all|-cleanup-all) cleanupAll; reload; menu ;;
        about|-about) show_disclaimer; reload; menu ;;
        *) 
            echo "Command not found!."
            menu  # Call menu function again to continue the loop
        ;;
    esac
}

# Call the menu function
menu

# tr -d '\' < update.sh > update_unix.sh
# mv update_unix.sh update.sh
# chmod +x update.sh