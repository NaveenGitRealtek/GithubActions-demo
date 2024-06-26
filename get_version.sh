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
#!/bin/bash

# Get the latest tag in the repository
latest_tag=$(git describe --tags --abbrev=0 2>/dev/null)

# If there are no tags, start from v1.0.0
if [ -z "$latest_tag" ]; then
  current_version="v1.0.0"
else
  current_version=$(echo "$latest_tag" | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')
fi

# Determine the type of version bump based on commit messages
commit_messages=$(git log $latest_tag..HEAD --oneline 2>/dev/null)

# Default version bump type is PATCH
version_bump="PATCH"

# Check commit messages to determine the version bump type
if echo "$commit_messages" | grep -E 'BREAKING CHANGE:|MAJOR:'; then
  version_bump="MAJOR"
elif echo "$commit_messages" | grep -E 'MINOR:'; then
  version_bump="MINOR"
fi

# Split current version into MAJOR, MINOR, PATCH parts
IFS='.' read -r -a version_parts <<< "${current_version:1}" # Remove 'v' prefix
major="${version_parts[0]}"
minor="${version_parts[1]}"
patch="${version_parts[2]}"

# Increment the appropriate version part based on version bump type
case "$version_bump" in
  "MAJOR")
    major=$((major + 1))
    minor=0
    patch=0
    ;;
  "MINOR")
    minor=$((minor + 1))
    patch=0
    ;;
  "PATCH")
    patch=$((patch + 1))
    ;;
esac

# Construct the new version string
new_version="v${major}.${minor}.${patch}"

# Output the new version only
echo "$new_version"

