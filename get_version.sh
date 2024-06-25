#!/bin/bash

# Read the current version from version.txt
if [ ! -f version.txt ]; then
    echo "0.0.1" > version.txt
fi

CURRENT_VERSION=$(cat version.txt)

# Split the version into its components
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

# Increment the PATCH version
PATCH=$((PATCH + 1))

# Form the new version string
NEW_VERSION="${MAJOR}.${MINOR}.${PATCH}"

# Update the version.txt with the new version
echo $NEW_VERSION > version.txt

# Print the new version for use in the workflow
echo $NEW_VERSION

