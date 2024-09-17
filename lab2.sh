#!/bin/bash

menu() {
    echo "Welcome to Angela's Linux Git Repository Manager"

}

git_init(){
    local directory_name=$1
    echo "starting git init..."
    mkdir directory_name
    cd $directory_name
    git init 
    
}

git_clone(){
    local remote_url=$1 local_directory=$2
    echo "starting git clone..."
    git clone "$remote_url" "$local_directory"

}

git_commit(){
    local message_option=$1
    local commit_message=$2
    echo "starting git commit..." 

    if [ "$message_option" != "-m" ]
    then
        echo "Invalid git commit option.. exiting"
        return
    fi
    
    git add .
    git commit -m "$commit_message"
}

menu
read -r -p "Enter a command: " userCommand arg1 arg2 
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
        ;;
    mygit-create-directory)
        ;;
    mygit-delete-file)
        ;;
    mygit-delete-directory)
        ;;
    mygit-list-contents)
        ;;
    *) 
        echo "Invalid option." ;;

esac