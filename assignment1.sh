#!/bin/bash

menu() {
    echo "~~~ Welcome to Angela's Linux Git Repository Manager ~~~"
    echo "Available commands:"
    echo "- Init a Git repository:"
    echo "   Usage: mygit-init <directory>"
    echo "   Desc: Initializes a new Git repo in the specified directory."
    echo "- Clone a Git repository:"
    echo "   Usage: mygit-clone <remote_url> <local_directory>"
    echo "   Desc: Clones an existing Git repo from a remote URL to a local directory."
    echo "- Commit changes:"
    echo '   Usage: mygit-commit -m "<commit_message>"'
    echo "   Desc: Add and commit changes to the local Git repo."
    echo "- Push changes:"
    echo "   Usage: mygit-push"
    echo "   Desc: Pushes committed changes to a remote Git repo."
    echo "- Create a directory:"
    echo "   Usage: mygit-create-directory <directory_name>"
    echo "   Desc: Creates a directory within the Git repo."
    echo "- Delete a file:"
    echo "   Usage: mygit-delete-file <file_name>"
    echo "   Desc: Deletes a file from the repo."
    echo "- Delete a directory and its contents:"
    echo "   Usage: mygit-delete-directory <directory_name>"
    echo "   Desc: Deletes a directory and its contents from the repo."
    echo "- List directory contents:"
    echo "   Usage: mygit-list-contents <directory>" 
    echo "   Desc: Lists the contents of a directory within the Git repo."

}

git_init(){
    local directory_name=$1
    if [ -z "$directory_name" ]
    then
        echo "Error. No directory name specified."
        echo "Usage: mygit-init <directory>"
        return
    fi

    if [ -d "$directory_name" ]
    then
        echo "Error. Directory $directory_name already exists."
        return
    fi

    echo "Starting git init..."
    git init "$directory_name" || echo "Error. Failed to initialize a git repo."
    
}

git_clone(){
    local remote_url=$1 local_directory=$2

    if [ -z "$remote_url" ] || [ -z "$local_directory" ]
    then
        echo "Error. No remote URL or local directory specified."
        echo "Usage: mygit-clone <remote_url> <local_directory>"
        return
    fi

    if [ -d "$local_directory/.git" ]
    then   
        echo "Error. $local_directory is already a Git repo."
        return
    fi

    echo "Starting git clone..."
    git clone "$remote_url" "$local_directory" || echo "Error. Failed to clone the repo."

}

git_commit(){
    local message_option=$1
    local commit_message=$2
  

    if [ "$message_option" != "-m" ]
    then
        echo "Invalid git commit flag. Use '-m'."
        echo 'Usage: mygit-commit -m "<commit_message>"'
        return
    fi
    
    if [ -z "$commit_message" ]
    then
        echo "Error. No commit message specified."
        echo 'Usage: mygit-commit -m "<commit_message>"'
        return
    fi

    echo "Starting git commit..." 
    git add . && git commit -m "$commit_message" || echo "Error. Failed to commit."
}

git_push(){
    git push || echo "Error. Failed to push changes."
}

git_create_directory(){
    local directory_name=$1

    if [ -z "$directory_name" ]
    then
        echo "Error. No directory name specified."
        echo "Usage: mygit-create-directory <directory_name>"
        return
    fi

    if [ -d "$directory_name" ]
    then
        echo "Error. Directory $directory_name already exists."
        return
    fi

    mkdir "$directory_name"
    echo "Created directory: $directory_name"

}

git_delete_file(){
    local file_name=$1
    if [ -z "$file_name" ]
    then
        echo "Error. No file name specified."
        echo "Usage: mygit-delete-file <file_name>"
        return
    fi

    if [ ! -f "$file_name" ]
    then
        echo "Error. File $file_name not found."
        return
    fi

    rm "$file_name"
    echo "Removed file: $file_name"

}

git_delete_directory(){
    local directory_name=$1

    if [ -z "$directory_name" ]
    then
        echo "Error. No directory name specified."
        echo "Usage: mygit-delete-directory <directory_name>"
        return 
    fi

    if [ ! -d "$directory_name" ]
    then
        echo "Error. Directory $directory_name not found."
        return 
    fi

    rm -rf "$directory_name"
    echo "Removed directory: $directory_name" 

}

git_list_directory_contents (){
    local directory_name=$1

    if [ -z "$directory_name" ]
    then
        echo "Error. No directory name specified."
        echo "Usage: mygit-list-contents <directory_name>"
        return 
    fi

    if [ ! -d "$directory_name" ]
    then
        echo "Error. Directory $directory_name not found."
        return 
    fi

    echo "Listing directory: $directory_name contents..."
    ls "$directory_name"
}

menu
read -r -p "ENTER A COMMAND: " userCommand arg1 arg2 
case $userCommand in 
    mygit-init)
        git_init "$arg1"
        ;;
    mygit-clone)
        git_clone "$arg1" "$arg2"
        ;;
    mygit-commit)
        git_commit "$arg1" "$arg2"
        ;;
    mygit-push)
        git_push 
        ;;
    mygit-create-directory) 
        git_create_directory "$arg1"
        ;;
    mygit-delete-file)
        git_delete_file "$arg1"
        ;;
    mygit-delete-directory)
        git_delete_directory "$arg1"
        ;;
    mygit-list-contents)
        git_list_directory_contents "$arg1"
        ;;
    *)  
        echo "Invalid command." 
        ;;

esac