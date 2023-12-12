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
The script will search for the list of component names listed in the config file that are placed inside [[.*]] double brackets.

## Usage
To use the script:
1. Save the script to a file, e.g., `process_html.sh`.
2. Make the script executable: `chmod +x process_html.sh`.
3. Run the script: `./process_html.sh`.

## Notes
- The script assumes the presence of HTML files matching the search criteria.
- Ensure the script has the necessary permissions to create and write files in the specified output folder.
