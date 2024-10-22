-----------------------------------------------------------------------------------------
                       geelbertXN EMAIL Development TOOLKIT (GEDT)
                 HELP SECTION - BRIEF DESCRIPTION OF AVAILABLE COMMANDS 
-----------------------------------------------------------------------------------------
INSTRUCTIONS:
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
            8)Run help to see the summary of commands
-----------------------------------------------------------------------------------------
                                GEDT AVAILABLE COMMANDS
-----------------------------------------------------------------------------------------
rename-project:         This allows the user to update the build.sh
                        and edit the PROJECT_NAME. Take note that the
                        PROJECT_NAME will also be the folder name
                        in the local repository which will later be
                        pushed to the remote repository. If the local 
                        repo folder needs to have a folder inside,
                        you can declare PROJECT_NAME as a path.
                        For instance, PROJECT_NAME="STORY-00001/headers"
                        so on and so forth. To make a directory
                        in the local repository bearing the
                        PROJECT_NAME assigned value, invoke the 'status' command.
-----------------------------------------------------------------------------------------
status:                 Displays the status of files in the repository if
                        the directory is already existing. If the directory
                        is not yet existing, this will create a directory
                        in the local repository bearing the name
                        declared in the PROJECT_NAME variable
                        in the build.sh.
-----------------------------------------------------------------------------------------
init-cue:               Before running init-source, run this command
                        to create TEMPLATE_CUE.html. You can edit
                        the TEMPLATE_CUE.html to hold the container names
                        inside [[*]] which will serve as actual placeholders
                        for the actual content.           
-----------------------------------------------------------------------------------------
init-source:            Initializes new source HTML files
                        generated from TEMPLATE_CUE.html.
-----------------------------------------------------------------------------------------
wrap-all:               Wraps all container HTML files with
                        the TEMPLATE.html so that we can work
                        in each container locally.
-----------------------------------------------------------------------------------------
unwrap:                 Unwraps a previously wrapped file
                        when the HTML containers are needed
                        to be merged with the main Template.
-----------------------------------------------------------------------------------------
merge-cue:              Merges multiple HTML files into one.
                        It will create TEMPLATE HTML files and CONTAINER
                        files in the output folder.
-----------------------------------------------------------------------------------------
copy-files:             Copy files from the current project folder to
                        the local repository.
-----------------------------------------------------------------------------------------
copy-folder:            Copies an entire folder from the project folder
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
get-images:             Retrieves images from HTML or text files.
-----------------------------------------------------------------------------------------
pull-images:            Pulls images from a folder to an output folder
                        based on the reference cue.txt lists.
                        This eases the burden of copying the images
                        one by one.
-----------------------------------------------------------------------------------------
remove-prefix:          Removes a specified prefix from file names. 
                        In this case, CONTAINER_ will be removed from
                        the base containers.
-----------------------------------------------------------------------------------------
remove-prefix-num:      Removes numerical prefixes from file names.
                        Removes numerical values from filenames,
                        in this case [0-9]_ will be removed.
-----------------------------------------------------------------------------------------
get-f:                  Retrieves file names of the target folder.
                        Very useful when you want to get all the names
                        of HTML files to be used as placeholder texts,
                        or the names of images needed for pulling images
                        from one folder to the output folder.
-----------------------------------------------------------------------------------------
get-f-comp:             This is just getting the file names of files from
                        a specific directory and wrap them in [[]].
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
rlinks-o:               This will look for .HTML file and .link file that
                        has the same file names and start the replacement.
                        The process HTML files with links replaced will be
                        directed to an output folder.
-----------------------------------------------------------------------------------------
i/insert:               Inserts content or presets from the bin/assets/HTML
                        folder to the CONTAINERS_ in the source folder.
                        Note that this will only work if there are
                        files in the source folder that have CONTAINER_
                        in the base filename. Eg, to insert container
                        boilerplate in the CONTAINER_ HTML, place [[cntr-default]]
                        placeholder in the HTML and run "i" or "insert".
                        This will pull the content from container.HTML
                        from the bin/assets/HTML folder and replace
                        the placeholder with the extracted content.
                        You can also edit the bin/assets/HTML folder 
                        to expand the content that you can insert.
                        If you want to see the list of available inserts
                        use [[i-list]] in a CONTAINER_* html.
-----------------------------------------------------------------------------------------
mjml:                   Converts MJML (MailJet Markup Language) to HTML.
                        This will look for all the MJML files in the
                        source folder of the current directory where
                        the script is running and compile all MJML
                        files into HTML files. The generated content
                        will be directed to the output folder.
                        MJML library should be installed in your system
                        in order for this command to work.
-----------------------------------------------------------------------------------------
quit/exit/0:            Exits the current session or program.
-----------------------------------------------------------------------------------------
                                 SUMMARY OF COMMANDS
-----------------------------------------------------------------------------------------
                        init-source               wrap-all unwrap
                        init-cue                  merge-cue
                        copy-files                copy-folder 
                        pull push                 status log
                        setup-cred                zip unzip
                        setup-config              rename-images
                        get-images                pull-images
                        remove-prefix             remove-prefix-num
                        get-f get-f-comp          del-f del-d del-o
                        rlinks rlinks-o           i/insert
                        rename-project            
                        mjml
                        about    
                        quit

-----------------------------------------------------------------------
i/insert list currently available values
<!-- BUTTONS -->
  [[btn-223]]
  [[btn-228]]
  
  <!-- CONTAINERS -->
  <!-- inserting this will give you the currently available
  list of containers in the assets folder -->
  [[i-containers]]
  
  <!-- IMAGE PRESETS -->
  [[img-50]]
  [[img-295]]
  [[img-520]]
  [[img-600]]
  [[img-fw]]
  
  <!-- TEXT CONTENTS -->
  [[headline-medium]]
  [[body-txt]]
  [[sitb-grey]]
  
  <!-- FONTS -->
  [[book]]
  [[book-blue]]
  [[italic]]
  [[italic-grey]]
  [[medium]]
  [[medium-blue]]
  [[bold]]
  [[webkit]]
  
  <!-- SYMBOLS -->
  [[copy]]
  [[reg]]
  [[tm]]
  [[apos]]
  [[dollar]]
  [[ndash]]
  [[mdash]]

  <!-- MSO -->
  [[gte-mso]]
  [[mso]]
  [[no-mso]]

  -----------------------------------------------------------------------------------------
                       geelbertXN EMAIL Development TOOLKIT (GEDT)
                    Work your passion and have passion in your work.
-----------------------------------------------------------------------------------------