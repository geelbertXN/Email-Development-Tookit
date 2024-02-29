#!/bin/bash
read -p "Enter file to delete, including extension:  " file

if [ -z "$file" ]; then
    echo "Enter an existing file in the directory!"
    exit 1
else
    rm -rf "$file"
fi