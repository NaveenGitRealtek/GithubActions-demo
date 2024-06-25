#!/bin/bash

# Read the current version from the VERSION file
if [ ! -f VERSION ]; then
  echo "V0.0.0" > VERSION
fi

VERSION=$(cat VERSION)

# Extract the current version numbers
MAJOR=$(echo $VERSION | cut -d'.' -f1 | cut -d'V' -f2)
MINOR=$(echo $VERSION | cut -d'.' -f2)
PATCH=$(echo $VERSION | cut -d'.' -f3)

# Increment the patch version
PATCH=$((PATCH + 1))

# Create the new version string
NEW_VERSION="V${MAJOR}.${MINOR}.${PATCH}"

# Write the new version back to the VERSION file
echo $NEW_VERSION > VERSION

# Output the new version
echo $NEW_VERSION
