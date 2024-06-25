
#!/bin/bash

# Calculate the version number based on the GitHub Actions run number
VERSION=$(printf "V%03d" $GITHUB_RUN_NUMBER)
echo $VERSION
