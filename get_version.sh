#!/bin/bash

# Function to display usage information
usage() {
  echo "Usage: $0 {semantic|commit|timestamp|combined}"
  exit 1
}

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
  usage
fi

# Function to get semantic version
get_semantic_version() {
  if [ -f VERSION ]; then
    cat VERSION
  else
    echo "VERSION file not found."
    exit 1
  fi
}

# Function to get git commit hash
get_commit_hash() {
  git rev-parse --short HEAD
}

# Function to get timestamp
get_timestamp() {
  date +"%Y%m%d%H%M%S"
}

# Function to get combined version
get_combined_version() {
  if [ -f VERSION ]; then
    BASE_VERSION=$(cat VERSION)
    COMMIT_HASH=$(git rev-parse --short HEAD)
    echo "${BASE_VERSION}-${COMMIT_HASH}"
  else
    echo "VERSION file not found."
    exit 1
  fi
}

# Main logic to select the versioning strategy
case "$1" in
  semantic)
    get_semantic_version
    ;;
  commit)
    get_commit_hash
    ;;
  timestamp)
    get_timestamp
    ;;
  combined)
    get_combined_version
    ;;
  *)
    usage
    ;;
esac
