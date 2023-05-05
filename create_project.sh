#!/bin/bash

# Parse input parameters
while getopts ":p:r" opt; do
    case ${opt} in
    p) # Path to project directory
        path=$OPTARG
        ;;
    r) # Remove project directory if it exists
        remove=true
        ;;
    \?)
        echo "Invalid option: $OPTARG" 1>&2
        exit 1
        ;;
    :)
        echo "Invalid option: $OPTARG requires an argument" 1>&2
        exit 1
        ;;
    esac
done
shift $((OPTIND - 1))

# Validate input parameters
if [ -z "$path" ]; then
    echo "Error: Path to project directory is required (-p)" 1>&2
    exit 1
fi

# Function to create a directory if it does not exist
create_directory() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo "Created directory: $1"
    fi
}

# Function to remove a directory if it exists
remove_directory() {
    if [ -d "$1" ]; then
        rm -rf "$1"
        echo "Removed directory: $1"
    fi
}

# Remove project directory if it exists and -r flag is present
if [ -n "$remove" ] && [ -d "$path" ]; then
    remove_directory "$path"
fi

# Create project directory
create_directory "$path"

create_directory "$path/frontend"
create_directory "$path/frontend/src"
create_directory "$path/frontend/public"
create_directory "$path/frontend/assets"
create_directory "$path/frontend/styles"
create_directory "$path/frontend/images"
create_directory "$path/frontend/tests"

create_directory "$path/backend"
create_directory "$path/backend/src"
create_directory "$path/backend/tests"

create_directory "$path/data"
create_directory "$path/docs"
create_directory "$path/scripts"

create_directory "$path/docker"
create_directory "$path/docker/connect"
create_directory "$path/docker/kafka"
create_directory "$path/docker/postgres"
create_directory "$path/docker/redis"
create_directory "$path/docker/zookeeper"
create_directory "$path/docker/schema-registry"

create_directory "$path/jenkins"
create_directory "$path/jenkins/build"
create_directory "$path/jenkins/build/archive"
create_directory "$path/jenkins/build/libs"
create_directory "$path/jenkins/build/reports"
create_directory "$path/jenkins/src"
create_directory "$path/jenkins/tests"
create_directory "$path/jenkins/vars"

create_directory "$path/kafka"
create_directory "$path/kafka/src"
create_directory "$path/kafka/src/producer"
create_directory "$path/kafka/src/consumer"
create_directory "$path/kafka/src/schema"
create_directory "$path/kafka/tests/unit"
create_directory "$path/kafka/tests/integration"

create_directory "$path/redis"
create_directory "$path/redis/config"
create_directory "$path/redis/data"
create_directory "$path/redis/lua"

cd $path
git init

echo '{
    "folders": [
        {
            "path": "."
        }
    ],
    "settings": {}
}' > "$path.code-workspace"

echo $path.code-workspace > .gitignore 