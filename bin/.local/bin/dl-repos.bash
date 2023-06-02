#!/bin/bash

clone_repo() {
  if [ -d "/home/miles/gitroot/onxmaps/$@" ]; then
    echo "$@ already cloned, skipping"
  else
    echo "==> CLONING NEW REPO: "$@
    git clone git@github.com:onXmaps/$@.git /home/miles/gitroot/onxmaps/$@
  fi
}

update_repo() {
  pushd /home/miles/gitroot/onxmaps/$@ > /dev/null 2>&1
  if [ -z "$(git status --porcelain)" ]; then
    # Working directory clean
    BRANCH="$(git rev-parse --abbrev-ref HEAD)"
    if [[ "$BRANCH" == "master" ]] || [[ "$BRANCH" == "main" ]]; then
      echo "$@ is on master/main and clean, updating";
      git pull > /dev/null 2>&1
    else
      echo "$@ is NOT master/main and clean, skipping git pull";
    fi
  else
    echo "==> SKIPPING UPDATING DIRTY repo: "$@
  fi
  popd > /dev/null 2>&1
}

export -f clone_repo
export -f update_repo

echo "listing remote onXmaps repos to clone"

# clone all repos
gh \
  repo \
  list \
  onXmaps \
  --limit=1000 \
  --no-archived \
  --json name \
  --jq '.[].name' \
  | xargs -n 1 -P12 -I {} bash -c 'clone_repo "$@"' _ {}

# update all repos
ls ~/gitroot/onxmaps | xargs -n 1 -P12 -I {} bash -c 'update_repo "$@"' _ {}
