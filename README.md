# Bash Script Explanation

## Overview
This Bash script will search for  HTML files listed in the config file and collect those files altogether in a separate output folder.

## Script Sections

### Variables
- `template_file`: Specifies the template file to be used for searching.
- `output_folder`: The folder where the output HTML files will be stored.
- `timestamp`: A timestamp appended to the output folder to make it unique.

### Output Folder Handling
The script checks if the output folder already exists. If it does, the timestamp is appended to make it unique. The output folder is then created.

### Searching for Patterns
The script uses a regular expression to find patterns within double square brackets `[[ ... ]]` in the template file. These patterns are stored in the `searches` array.

### Processing Files
The script iterates through each search string in the `searches` array and searches for corresponding HTML files in the current directory. It ignores files in the output folder.

For each search string:
- If no matching files are found, an empty HTML file is created in the output folder.
- If matching files are found, their content is read and written to new HTML files in the output folder. The index is used to differentiate between files.

### File Naming and Content Writing
The script processes each HTML file found, uses the base name and parameter expansion to construct a new filename within the output folder, and writes the content to the new HTML file. The index ensures each file has a unique name.

## Usage
To use the script:
1. Save the script to a file, e.g., `process_html.sh`.
2. Make the script executable: `chmod +x process_html.sh`.
3. Run the script: `./process_html.sh`.

## Notes
- The script assumes the presence of HTML files matching the search criteria.
- Ensure the script has the necessary permissions to create and write files in the specified output folder.
