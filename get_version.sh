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
VERSION=""
# get parameters
while getopts v: flag
do
  case "${flag}" in
    v) VERSION=${OPTARG};;
  esac
done
# get highest tag number, and add v0.1.0 if doesn't exist
git fetch --prune --unshallow 2>/dev/null
CURRENT_VERSION=`git describe --abbrev=0 --tags 2>/dev/null`
if [[ $CURRENT_VERSION == '' ]]
then
  CURRENT_VERSION='v0.1.0'
fi
echo "Current Version: $CURRENT_VERSION"
# replace . with space so can split into an array
CURRENT_VERSION_PARTS=(${CURRENT_VERSION//./ })
# get number parts
VNUM1=${CURRENT_VERSION_PARTS[0]}
VNUM2=${CURRENT_VERSION_PARTS[1]}
VNUM3=${CURRENT_VERSION_PARTS[2]}
if [[ $VERSION == 'major' ]]
then
  VNUM1=v$((VNUM1+1))
elif [[ $VERSION == 'minor' ]]
then
  VNUM2=$((VNUM2+1))
elif [[ $VERSION == 'patch' ]]
then
  VNUM3=$((VNUM3+1))
else
  echo "No version type (https://semver.org/) or incorrect type specified, try: -v [major, minor, patch]"
  exit 1
fi
# create new tag
NEW_TAG="$VNUM1.$VNUM2.$VNUM3"
echo "($VERSION) updating $CURRENT_VERSION to $NEW_TAG"
# get current hash and see if it already has a tag
GIT_COMMIT=`git rev-parse HEAD`
NEEDS_TAG=`git describe --contains $GIT_COMMIT 2>/dev/null`
# only tag if no tag already
if [ -z "$NEEDS_TAG" ]; then
  echo "Tagged with $NEW_TAG"
  git tag $NEW_TAG
  git push --tags
  git push
else
  echo "Already a tag on this commit"
fi
echo ::set-output name=git-tag::$NEW_TAG
exit 0
