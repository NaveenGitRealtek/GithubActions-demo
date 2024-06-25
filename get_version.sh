#!/bin/bash

# Get the GitHub Actions run number
RUN_NUMBER=$GITHUB_RUN_NUMBER

# Calculate major, minor, and patch versions
MAJOR=$((RUN_NUMBER / 10000))
MINOR=$(((RUN_NUMBER / 100) % 100))
PATCH=$((RUN_NUMBER % 100))

# Format the version as V x.y.z
VERSION=$(printf "V %d.%d.%d" $MAJOR $MINOR $PATCH)
echo $VERSION

