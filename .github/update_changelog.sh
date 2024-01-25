#!/bin/bash

GH_PROFILE="https://github.com/Awesome-T"

CHANGELOG_FILE="CHANGELOG.md"

PACKAGE_NAME=$(basename $(git rev-parse --show-toplevel))

DATA=$(cat $CHANGELOG_FILE)

VERSION=$(grep -E '^version:' "pubspec.yaml" | awk '{print $2}')

CURRENT_DATE=$(date +"%Y-%m-%d")

NUM_COMMITS=$(git log HEAD --oneline | wc -l)

if ((NUM_COMMITS > 0)); then
    COMMIT_SHORT_HASH=$(git log -n 1 --oneline --pretty=format:"%h")
    MESSAGE=$(git log -n 1 --oneline --pretty=format:%s $COMMIT_SHORT_HASH)
    URL="[[$COMMIT_SHORT_HASH]($GH_PROFILE/$PACKAGE_NAME/commit/$COMMIT_SHORT_HASH)]"
    cat >$CHANGELOG_FILE <<EOF
$DATA

## [$NEW_VERSION] - $CURRENT_DATE
- $MESSAGE $URL
EOF
    echo "CHANGELOG updated"
fi