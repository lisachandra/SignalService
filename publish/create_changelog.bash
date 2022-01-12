#!/usr/bin/env bash

DATE=$(date +%F)
LAST_TAG=$(git describe --tags --abbrev=0)

VERSION=$1
REPOSITORY=$2

git config --global alias.changelog "log --pretty=format:'- %s by @%an ([%h](https://github.com/${REPOSITORY}/commit/%H))' --abbrev-commit"

ADDED=$(git changelog --grep="ADDED:" $LAST_TAG..HEAD -- src/*.lua)
FIXED=$(git changelog --grep="FIXED:" $LAST_TAG..HEAD -- src/*.lua)
CHANGED=$(git changelog --grep="CHANGED:" $LAST_TAG..HEAD -- src/*.lua)
REMOVED=$(git changelog --grep="REMOVED:" $LAST_TAG..HEAD -- src/*.lua)

declare -A CHANGES

CHANGES+=(
    ["Added"]=${ADDED}
    ["Fixed"]=${FIXED}
    ["Changed"]=${CHANGED}
    ["Removed"]=${REMOVED}
)

echo -e "\n# $VERSION - $DATE" > CHANGES.md

for key in ${!CHANGES[@]}; do
    if [ -z "${CHANGES[${key}]}" ]; then
        echo -e "# $key\n\n${CHANGES[${key}]}\n" >> CHANGES.md
    fi
done