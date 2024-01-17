#!/bin/bash
# 
GH_PROFILE="https://github.com/Awesome-T"
CHANGELOG_FILE="changelog.md"
PUBSPEC_FILE="pubspec.yaml"
CHANGELOG_FILE=$(echo "$CHANGELOG_FILE" | tr '[:upper:]' '[:lower:]')
PACKAGE_NAME=$(grep -E '^name:' $PUBSPEC_FILE | awk '{print $2}')
#
upgradeVersion() {
  VERSION=$(grep -E '^version:' $PUBSPEC_FILE | awk '{print $2}')
  IFS='.' read -r major minor patch <<<"$VERSION"
  MAJOR_V=$major MINOR_V=$minor PATCH_V=$patch
  if (($PATCH_V < 9)); then PATCH_V=$((PATCH_V + 1))
  elif (($MINOR_V < 9)); then MINOR_V=$((MINOR_V + 1)) PATCH_V=0
  else MAJOR_V=$((MAJOR_V + 1)) MINOR_V=0 PATCH_V=0
  fi
  echo "$MAJOR_V.$MINOR_V.$PATCH_V" | xargs
}

NEW_VERSION=$(upgradeVersion)

CURRENT_DATE=$(date +"%Y-%m-%d")

NUM_COMMITS=$(git log HEAD --oneline | wc -l)
if (($NUM_COMMITS >0)); then
  echo -e "## [$NEW_VERSION] - $CURRENT_DATE\n" >>$CHANGELOG_FILE
  COMMIT_SHORT_HASH=$(git log -n 1 --oneline --pretty=format:"%h")
  MESSAGE=$(git log -n 1 --oneline --pretty=format:%s $COMMIT_SHORT_HASH)
  URL="[[$COMMIT_SHORT_HASH]($GH_PROFILE/$PACKAGE_NAME/commit/$COMMIT_SHORT_HASH)]"
  echo -e "- $MESSAGE $URL\n" >>$CHANGELOG_FILE
  echo -e "\nChangelog updated NEW_VERSION $NEW_VERSION."
  sed -i.bak "s/\(version:[[:space:]]*\)[^[:space:]]*/\1$NEW_VERSION/" "$PUBSPEC_FILE"
fi
