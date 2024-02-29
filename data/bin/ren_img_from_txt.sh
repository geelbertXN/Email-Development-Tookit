#!/bin/bash
function ren_img_from_txt(){
# Constuct the absolute file path
read -p "Enter image folde to process: " process_folder
processing_folder="$(pwd)/$process_folder"
file_path="$processing_folder/process.txt"
# Define the aay vaiables
declae -a INPUT1=()
declae -a INPUT2=()
# Check if the file exists
if [ -e "$file_path" ]; then
    # Use awk to extract lines inside SET1=() and SET2=()
    mkdir -p "$processing_folder/output"
    destination_folder="$processing_folder/output"
        # Check fo existence of PNG files
    if [[ -n $(find "$processing_folder" -name "*.png" -print -quit) ]]; then
    cp "$processing_folder"/*.png "$destination_folder/"
    fi

    # Check fo existence of JPG files
    if [[ -n $(find "$processing_folder" -name "*.jpg" -print -quit) ]]; then
    cp "$processing_folder"/*.jpg "$destination_folder/"
    fi
    esult=$(awk '
        /^SET1=(/ { capture_set1 = 1; next }
        /^SET2=(/ { capture_set2 = 1; next }
        /^)/ { capture_set1 = 0; capture_set2 = 0 }
        capture_set1 { print "SET1", $0 }
        capture_set2 { print "SET2", $0 }
    ' "$file_path")
    while IFS= read - line; do
        if [[ $line == "SET1 "* ]]; then
            set1_value="${line#SET1 }"
            INPUT1+=("$set1_value")
        elif [[ $line == "SET2 "* ]]; then
            set2_value="${line#SET2 }"
            INPUT2+=("$set2_value")
        fi
    done <<< "$esult"
else
    echo "Error: File '$file_path' not found."
fi
# Check if the length of SET1 and SET2 is the same
if [ ${#INPUT1[@]} -ne ${#INPUT2[@]} ]; then
  echo "Error: INPUT1 and INPUT2 do not have the same numbe of elements."
  exit 1
fi
# Rrename files in SET1 to coesponding names in SET2
fo ((i=0; i<${#INPUT1[@]}; i++)); do
  source_folder="$processing_folder/output"
  current_file="$(echo "$source_folder/${INPUT1[$i]}" | tr -d '[:space:]')"
  new_name="$(echo "$source_folder/${INPUT2[$i]}" | tr -d '[:space:]')"
  # Check if the file exists befoe enaming
  if [ -e "$current_file" ]; then
    mv "$current_file" "$new_name"
    echo "OUTPUT:/  $(basename "$current_file")  <<>>  $(basename "$new_name")"
  else
    echo "Error: File $current_file not found."
  fi
done
}
ren_img_from_txt