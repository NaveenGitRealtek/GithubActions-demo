# #!/bin/bash

# # Calculate the version number based on the GitHub Actions run number
# VERSION="V0.0.$GITHUB_RUN_NUMBER"
# echo $VERSION

# #!/bin/bash

# Calculate the version number based on the GitHub Actions run number
# VERSION="v${GITHUB_RUN_NUMBER}.0.0"
# echo $VERSION

# #!/bin/bash

# # Get the latest tag in the repository
# latest_tag=$(git describe --tags --abbrev=0)

# # If there are no tags, start from v0.0.0
# if [ -z "$latest_tag" ]; then
#   current_version="v0.0.0"
# else
#   current_version=$(echo "$latest_tag" | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')
# fi

# # Determine the type of version bump based on commit messages
# commit_messages=$(git log $latest_tag..HEAD --oneline)

# # Default version bump type is PATCH
# version_bump="PATCH"

# # Check commit messages to determine the version bump type
# if echo "$commit_messages" | grep -E 'BREAKING CHANGE:|MAJOR:'; then
#   version_bump="MAJOR"
# elif echo "$commit_messages" | grep -E 'MINOR:'; then
#   version_bump="MINOR"
# fi

# # Split current version into MAJOR, MINOR, PATCH parts
# IFS='.' read -r -a version_parts <<< "${current_version:1}" # Remove 'v' prefix
# major="${version_parts[0]}"
# minor="${version_parts[1]}"
# patch="${version_parts[2]}"

# # Increment the appropriate version part based on version bump type
# case "$version_bump" in
#   "MAJOR")
#     major=$((major + 1))
#     minor=0
#     patch=0
#     ;;
#   "MINOR")
#     minor=$((minor + 1))
#     patch=0
#     ;;
#   "PATCH")
#     patch=$((patch + 1))
#     ;;
# esac

# # Construct the new version string
# new_version="v${major}.${minor}.${patch}"

# echo "$new_version"

# #!/bin/bash

# # Get the latest tag in the repository
# latest_tag=$(git describe --tags --abbrev=0 2>/dev/null)

# # If there are no tags, start from v1.0.0
# if [ -z "$latest_tag" ]; then
#   current_version="v1.0.0"
# else
#   current_version=$(echo "$latest_tag" | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')
# fi

# # Determine the type of version bump based on commit messages
# commit_messages=$(git log $latest_tag..HEAD --oneline 2>/dev/null)

# # Default version bump type is PATCH
# version_bump="PATCH"

# # Check commit messages to determine the version bump type
# if echo "$commit_messages" | grep -E 'BREAKING CHANGE:|MAJOR:'; then
#   version_bump="MAJOR"
# elif echo "$commit_messages" | grep -E 'MINOR:'; then
#   version_bump="MINOR"
# fi

# # Split current version into MAJOR, MINOR, PATCH parts
# IFS='.' read -r -a version_parts <<< "${current_version:1}" # Remove 'v' prefix
# major="${version_parts[0]}"
# minor="${version_parts[1]}"
# patch="${version_parts[2]}"

# # Increment the appropriate version part based on version bump type
# case "$version_bump" in
#   "MAJOR")
#     major=$((major + 1))
#     minor=0
#     patch=0
#     ;;
#   "MINOR")
#     minor=$((minor + 1))
#     patch=0
#     ;;
#   "PATCH")
#     patch=$((patch + 1))
#     ;;
# esac

# # Construct the new version string
# new_version="v${major}.${minor}.${patch}"

# # Output the new version only
# echo "$new_version"

#!/bin/bash

# Usage: ./update_version.sh [major|minor|patch]
# Example: ./update_version.sh minor

# Docker image details
DOCKER_USER="naveen775"
IMAGE_NAME="my-go-app"

# Retrieve the current version from Docker Hub
CURRENT_VERSION=$(curl -s "https://hub.docker.com/v2/repositories/$DOCKER_USER/$IMAGE_NAME/tags" | jq -r '.results[].name' | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -n 1)

# Parse the current version
IFS='.' read -r -a VERSION_PARTS <<< "${CURRENT_VERSION#v}"

# Increment the version based on the input argument
case $1 in
  major)
    VERSION_PARTS[0]=$((VERSION_PARTS[0] + 1))
    VERSION_PARTS[1]=0
    VERSION_PARTS[2]=0
    ;;
  minor)
    VERSION_PARTS[1]=$((VERSION_PARTS[1] + 1))
    VERSION_PARTS[2]=0
    ;;
  patch)
    VERSION_PARTS[2]=$((VERSION_PARTS[2] + 1))
    ;;
  *)
    echo "Usage: $0 [major|minor|patch]"
    exit 1
    ;;
esac

# Construct the new version
NEW_VERSION="v${VERSION_PARTS[0]}.${VERSION_PARTS[1]}.${VERSION_PARTS[2]}"

# Build and tag the new Docker image
docker build -t $DOCKER_USER/$IMAGE_NAME:$NEW_VERSION .

# Push the new Docker image to Docker Hub
docker push $DOCKER_USER/$IMAGE_NAME:$NEW_VERSION

# Output the new version
echo "Updated Docker image version to $NEW_VERSION"


