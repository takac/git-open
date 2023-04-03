#!/bin/bash

if ! command -v git &> /dev/null; then
  echo "Error: git is not installed."
  exit 1
fi

if ! git rev-parse --is-inside-work-tree &> /dev/null; then
  echo "Error: Not inside a git repository."
  exit 1
fi

URL_TYPE="uknown"
# Get the file path if provided
if [[ -n $1 ]]; then
  FILE_PATH=$(realpath --relative-to="$(git rev-parse --show-toplevel)" "$1")

  # Check if the file exists in the repo
  if ! git ls-files --error-unmatch "$FILE_PATH" &> /dev/null; then
    echo "Error: File not found in the git repository."
    exit 1
  fi

  URL_TYPE="file"
else
  URL_TYPE="root"
fi

remote_url=$(git config --get remote.origin.url)
repo_url=${remote_url%.git}
if [ "${URL_TYPE:-}" == "file" ]; then
    # TODO allow specific branch
    # current_branch=$(git rev-parse --abbrev-ref HEAD)
    ROOT_BRANCH=$(git branch -r | grep -v HEAD | grep "master$\|main$" | head -1 | sed 's#\s\+origin/##')
    if [[ -n $2 ]]; then
        LINE_NUMBER=$2
        echo open "${repo_url}/blob/${ROOT_BRANCH}/${FILE_PATH}#L${LINE_NUMBER}"
    else
        echo open "${repo_url}/blob/${ROOT_BRANCH}/${FILE_PATH}"
    fi
elif [[ $URL_TYPE == "root" ]]; then
    open "${repo_url}"
else
    echo "Error: Invalid URL type."
    exit 1
fi
