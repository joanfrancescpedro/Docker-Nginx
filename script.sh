#!/bin/bash

SCRIPTNAME="${0##*/}"

warn() {
    printf >&2 "$SCRIPTNAME: $*\n"
}

iscmd() {
    command -v >&- "$@"
}

checkdeps() {
    local -i not_found

    for cmd; do
        iscmd "$cmd" || { 
            warn $"$cmd is not found"
            let not_found++
        }
    done
    (( not_found == 0 )) || {
        warn $"Install dependencies listed above to use $SCRIPTNAME"
        exit 1
    }
}

project1() {
    echo "You have selected the Nginx webpage."
    echo "First, we are go to check if you have all the dependencies installed: "
    echo "- Docker"
    echo ""
    checkdeps docker
    echo "Alright all dependences have it, let's run the program"
    echo ""

    chmod +x ./Docker-nginx/docker-create.sh

    cd Docker-nginx 
    ./docker-create.sh
    cd ..
}

main() {
    echo ""
    echo "---------------------------------------------------------------"
    echo "|            Welcome to @socunzombi DevOps project            |"
    echo "---------------------------------------------------------------"
    echo ""
    echo "Here you have a list of the actual projects currently working: "
    echo ""
    echo "1. Nginx webpage"
    echo ""

    read -p "Please tell me the project you want to execute: " value
    echo ""

    case $value in
        1)
            project1
            ;;
        *)
            echo "There is no project with the value $value"
            exit 1
            ;;
    esac
}

main
exit 0
