#!/bin/bash

# Assuming $GITHUB_RUN_NUMBER contains the GitHub Actions run number

# Define the version file path
version_file="version.txt"

if [ -e "$version_file" ]; then
    # Read the last version from the file
    version=$(cat "$version_file")
else
    # If the version file doesn't exist, start with version 0.0.0
    version="0.0.0"
fi

# Increment the patch version based on GitHub Actions run number
# Split the version into major, minor, and patch parts
major=$(echo "$version" | cut -d '.' -f 1)
minor=$(echo "$version" | cut -d '.' -f 2)
patch=$(echo "$version" | cut -d '.' -f 3)

# Calculate the next patch version based on GitHub Actions run number
next_patch=$((patch + 1))

# Form the new version string
next_version="V$major.$minor.$next_patch"

# Store the next version in the version file
echo "$next_version" > "$version_file"

# Print the version for debugging or further use
echo "$next_version"
