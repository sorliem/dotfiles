#!/bin/bash

osascript -e "display notification \"\" with title \">> RUNNING dl-repos.bash <<\""

clone_repo() {
  if [ ! -d "/Users/miles.sorlie/gitroot/onxmaps/$@" ]; then
    echo "==> CLONING NEW REPO: "$@
    git clone git@github.com:onXmaps/$@.git /Users/miles.sorlie/gitroot/onxmaps/$@
  fi
}

update_repo() {
  pushd /Users/miles.sorlie/gitroot/onxmaps/$@ > /dev/null 2>&1
  if [ -z "$(git status --porcelain)" ]; then
    # Working directory clean
    BRANCH="$(git rev-parse --abbrev-ref HEAD)"
    if [[ "$BRANCH" == "master" ]] || [[ "$BRANCH" == "main" ]] || [[ "$BRANCH" == "develop" ]] || [[ "$BRANCH" == "onx-master" ]] || [[ "$BRANCH" == "v2-master" ]]; then
      echo "pulling "$@
      git pull > /dev/null 2>&1
    else
      echo "[x] $@ [x] skipping pull - not on master/main/develop";
    fi
  else
    echo "[x] $@ [x] skipping pull - repo is dirty";
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
  --limit=3000 \
  --no-archived \
  --json name \
  --jq '.[].name' \
  | xargs -P12 -I {} bash -c 'clone_repo "$@"' _ {}

# update all repos
ls ~/gitroot/onxmaps | xargs -P12 -I {} bash -c 'update_repo "$@"' _ {} | tee /tmp/dl-repos.bash.log

osascript -e 'display notification "Done running dl-repos.bash" with title "All done"'

cat /tmp/dl-repos.bash.log | grep skip > /tmp/dl-repos-skipped.log
cat /tmp/dl-repos.bash.log | grep 'CLONING NEW REPO' > /tmp/dl-repos-new.log

SKIPNUM=$(wc -l /tmp/dl-repos-skipped.log)
NEWNUM=$(wc -l /tmp/dl-repos-new.log)

sleep 4
osascript -e "display notification \"$SKIPNUM\" with title \"Number of SKIPPED repos\""
sleep 4
osascript -e "display notification \"$NEWNUM\" with title \"Number of NEW repos\""
