#!/bin/bash

# Set PATH for cron environment to know where `gh` tool is
PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

osascript -e "display notification \"\" with title \">> RUNNING dl-atlantis-repos.bash <<\""

ATLANTIS_DIR="/Users/milessorlie/gitroot/onxmaps-atlantis"

clone_repo() {
  local repo=$1
  local wrapper="$ATLANTIS_DIR/$repo"
  local bare="$wrapper/$repo.git"
  if [ ! -d "$bare" ]; then
    echo "==> CLONING NEW REPO: $repo"
    mkdir -p "$wrapper"
    git clone --bare "git@github.com:onXmaps/$repo.git" "$bare"
    git -C "$bare" worktree add "$wrapper/main" main
  fi
}

update_repo() {
  local repo=$1
  local wrapper="$ATLANTIS_DIR/$repo"
  local bare="$wrapper/$repo.git"
  echo "fetching $repo"
  git -C "$bare" fetch --all --prune > /dev/null 2>&1
  if [ ! -d "$wrapper/main" ]; then
    git -C "$bare" worktree add "$wrapper/main" main
  fi
}

export ATLANTIS_DIR
export -f clone_repo
export -f update_repo

echo "listing remote onXmaps atlantis-* repos to clone"

# clone all atlantis-* repos
gh \
  repo \
  list \
  onXmaps \
  --limit=3000 \
  --no-archived \
  --json name,isEmpty \
  --jq '.[] | select(.isEmpty == false) | select(.name | startswith("atlantis-")) | .name' \
  | xargs -P12 -I {} bash -c 'clone_repo "$@"' _ {}

# update all repos
ls ~/gitroot/onxmaps-atlantis | xargs -P12 -I {} bash -c 'update_repo "$@"' _ {} | tee /tmp/dl-atlantis-repos.bash.log

osascript -e 'display notification "Done running dl-atlantis-repos.bash" with title "All done"'

cat /tmp/dl-atlantis-repos.bash.log | grep 'CLONING NEW REPO' > /tmp/dl-atlantis-repos-new.log

NEWNUM=$(wc -l /tmp/dl-atlantis-repos-new.log)

sleep 4
osascript -e "display notification \"$NEWNUM\" with title \"Number of NEW atlantis repos\""
