#!/bin/bash

clone_repo() {
  if [ ! -d "/Users/milessorlie/gitroot/onxmaps-tmp/$@" ]; then
    echo "==> CLONING NEW REPO: "$@
    git clone git@github.com:onXmaps/$@.git /Users/milessorlie/gitroot/onxmaps-tmp/$@
  fi
}

export -f clone_repo

echo "listing remote onXmaps repos to clone"

# clone all repos
gh \
  repo \
  list \
  onXmaps \
  --limit=6000 \
  --no-archived \
  --json name \
  --jq '.[].name' \
  | grep "^atlantis" | xargs -P12 -I {} bash -c 'clone_repo "$@"' _ {}
