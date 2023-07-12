#!/bin/bash

# applyto will apply the changes you have locally to remote repo

if [ $# -lt 2 ]; then
  echo "Usage: applyto user@host path_to_repository_on_the_remote"
  exit 1
fi

# Check if the repository is dirty (contains uncommitted changes)
if [[ $(git diff --stat) != '' ]]; then
    echo "The repository has uncommitted changes. Please commit or stash them before running this script."
    exit 1
fi

# Generate the diff and save it to a file
git show --no-prefix > applyto.patch

# Copy the diff file over SSH
scp applyto.patch "$1":"$2"

ssh "$1" "cd $2; git stash; git apply -p0 applyto.patch"

echo "Applied!"
