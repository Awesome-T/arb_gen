#!/bin/bash

PUBSPEC_FILE="pubspec.yaml"

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

NUM_COMMITS=$(git log HEAD --oneline | wc -l)

if ((NUM_COMMITS >0)); then
  sed -i.bak "s/\(version:[[:space:]]*\)[^[:space:]]*/\1$NEW_VERSION/" "$PUBSPEC_FILE"
  echo "pubspec updated  $NEW_VERSION."
fi