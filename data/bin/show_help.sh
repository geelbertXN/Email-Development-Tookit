#!/bin/bash
# Color Variables
# Help Function

    clear
    echo -ne "
-----------------------------------------------------------------------------------------
                       geelbertXN EMAIL Development TOOLKIT (GEDT)
                 HELP SECTION - BRIEF DESCRIPTION OF AVAILABLE COMMANDS 
-----------------------------------------------------------------------------------------
INSTRUCTONS:
            1) Locate the init.sh File: Navigate to the script folder in your terminal.

            2) Run init.sh: Invoke the init.sh file by entering the command bash init.sh 
            in your terminal and pressing Enter. This script initializes the setup process.

            3) Generate build.sh: After running init.sh, a build.sh file will be generated.
            This file serves as a portable executable for your application.

            4) Place build.sh in Your Project Folder: Move the build.sh file to your
            project folder where you intend to run your application.

            5) Run build.sh: Navigate to your project folder in your terminal and run 
            the build.sh file by entering the command bash build.sh and pressing Enter. 
            This will execute your application in the current directory.

            6) Single build.sh per Project Folder: Note that each project folder 
            should have only one build.sh file.

            7) Edit build.sh if Necessary: Before running build.sh, you can edit 
            the information within the file to properly configure paths 
            and other settings based on your project requirements.
-----------------------------------------------------------------------------------------
rename-project:         This allows the user to update the build.sh
                        and edit the PROJECT_NAME. Take not that the
                        PROJECT_NAME will also be the folder name
                        in the local repository which will later be
                        push to the remove repository. If the local 
                        repo folder needs to have a folder inside,
                        you can declare PROJECT_NAME as path.
                        For instance PROJECT_NAME="STORY-00001/headers"
                        so on and so forth. To make a directory
                        in the local repository bearing the
                        PROJECT_NAME assigned value, invoke 'status' command.
-----------------------------------------------------------------------------------------
status:                 Displays the status of files in the repository if
                        the directory is already existing. If the directory
                        is not yet existing, this will create a directory
                        in the local repository bearing the name
                        declared in the PROJECT_NAME variable
                        in the build.sh.
-----------------------------------------------------------------------------------------
init-cue:               Before running init-source run this command
                        to create TEMPLATE_CUE.html. You can edit
                        the TEMPLATE_CUE.html to hold the container names
                        inside [[*]] which will serve as actual placeholders
                        for the actual content.           
-----------------------------------------------------------------------------------------
init-source:            Initializes a new source html files
                        generated from TEMPLATE_CUE.html.
-----------------------------------------------------------------------------------------
wrap-all:               Wraps all container html files with
                        the TEMPLATE.html so that we can work
                        in each containers locally.
-----------------------------------------------------------------------------------------
unwrap:                 Unwraps a previously wrapped file
                        when the html containers are needed
                        to be merged with the main Template.
-----------------------------------------------------------------------------------------
merge-cue:              Merges multiple html files into one.
                        It will create TEMPLATE html files and CONTAINER
                        files in the output folder
-----------------------------------------------------------------------------------------
merge-o:                Merges multiple html files into one.
                        It will create TEMPLATE html files only
                        in the output folder but will not
                        copy the and unwrap CONTAINER_* html files.
-----------------------------------------------------------------------------------------
copy-files:             Copy files from current project folder to
                        the local repository.
-----------------------------------------------------------------------------------------
copy-folder:            Copies an entire folder from project folder
                        to the local repository.
-----------------------------------------------------------------------------------------
pull:                   Fetches changes from a remote repository.
-----------------------------------------------------------------------------------------
push:                   Pushes changes to a remote repository.
                        This also takes care of add and commit.
-----------------------------------------------------------------------------------------
log:                    Shows the commit history.
-----------------------------------------------------------------------------------------
setup-cred:             Sets up credentials for accessing a remote repository.
-----------------------------------------------------------------------------------------
zip:                    Creates a zip archive of specified files or folders.
-----------------------------------------------------------------------------------------
unzip:                  Extracts files from a zip archive.
-----------------------------------------------------------------------------------------
setup-config:           Configures settings for a specific application or environment.
-----------------------------------------------------------------------------------------
rename-images:          Renames image files according to specified rules.
-----------------------------------------------------------------------------------------
get-images:             Retrieves images from html or text files
-----------------------------------------------------------------------------------------
pull-images:            Pulls images from a folder to an output folder
                        based on the reference cue.txt lists.
                        This eases the burden of copying the images
                        one by one.
-----------------------------------------------------------------------------------------
remove-prefix:          Removes a specified prefix from file names. 
                        In this case CONTAINER_ will be removed from
                        the base containers.
-----------------------------------------------------------------------------------------
remove-prefix-num:      Removes numerical prefixes from file names.
                        Removes numerical values from filenames,
                        in this case [0-9]_ will be removed.
-----------------------------------------------------------------------------------------
get-f:                  Retrieves file names of the target folder.
                        Very useful when you want to get all the names
                        of html files to be used as placeholder texts,
                        or the names of images needed for pulling images
                        from one folder to output folder.
-----------------------------------------------------------------------------------------
get-f-comp:             This is just getting the file names of files from
                        specific directory and wrap them in [[]]
-----------------------------------------------------------------------------------------
del-f:                  Deletes a specific file.
-----------------------------------------------------------------------------------------
del-d:                  Deletes a directory and its contents.
-----------------------------------------------------------------------------------------
del-o:                  Permanently delete all output folders
                        in the current directory.
-----------------------------------------------------------------------------------------
rlinks:                 Replaces all the links with link name and reference numbers
                        which will be needed for automated link replacements.
                        This will also generate a *_cue.html file and *.link file 
                        The .link file will be used to set up the link replacements.
-----------------------------------------------------------------------------------------
rlinks-o:               This will look for .html file and .link file that
                        has the same file names and start the replacement.
                        The process html files with links replaced will be
                        directed to an output folder.
-----------------------------------------------------------------------------------------
i/insert:               Inserts content or presets from the bin/assets/html
                        folder to the CONTAINERS_ in the source folder.
                        Note that this will only work if there are
                        files in the source folder that has CONTAINER_
                        in the base filename. Eg, to insert container
                        boilerplacte in the CONTAINER_ html, place [[container]]
                        placeholder in the hml and run "i" or "insert".
                        This will pull the content from container.html
                        from the bin/assets/html folder and replace
                        the placeholder with the extracted content.
                        You can also edit the bin/assets/html folder 
                        to expand the content that you can insert.
-----------------------------------------------------------------------------------------
extract-content         add {extract=*} and {extract-end} to the content you
                        want to extract, then run the command 'extract-content'.
                        This will create an html file in an output_extracted folder.
-----------------------------------------------------------------------------------------
mjml:                   Converts MJML (MailJet Markup Language) to HTML.
                        This will look for all the mjml files in the
                        source folder of the current directory where
                        the script is running and compile all MJML
                        files into HTML files. The generated content
                        will be directed to the output folder.
-----------------------------------------------------------------------------------------
quit/exit/0:            Exits the current session or program.
-----------------------------------------------------------------------------------------
                                 SUMMARY OF COMMANDS
-----------------------------------------------------------------------------------------
                        init-source               wrap-all unwrap
                        init-cue                  merge-cue merge-o
                        copy-files                copy-folder 
                        pull push                 status log
                        setup-cred                zip unzip
                        setup-config              rename-images
                        get-images                pull-images
                        remove-prefix             remove-prefix-num
                        get-f get-f-comp          del-f del-d del-o
                        rlinks rlinks-o           i/insert
                        i-r/i-data                i-s/i-symbol
                        rename-project            extract-content
                        mjml                      ff/f-font
                        gen-img                   add-zwj/add-zwnj              
                        about    
                        quit
-----------------------------------------------------------------------------------------
                       geelbertXN EMAIL Development TOOLKIT (GEDT)
                    Work your passion and have passion in your work.
-----------------------------------------------------------------------------------------
"
read -n 1 -s -r -p "Pess any key to exit..."
clear
exit 1