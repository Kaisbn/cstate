#!/bin/sh

set -eu

repo_uri="https://x-access-token:${DEPLOY_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
remote_name="origin"
main_branch="main"
target_branch="gh-pages"
build_dir="public"

cd "$GITHUB_WORKSPACE/$build_dir"

git config --global user.name "$GITHUB_ACTOR"
git config --global user.email "${GITHUB_ACTOR}@bots.github.com"
git config --global init.defaultBranch main

git init
git checkout -b "$target_branch"
echo "status.kaisbn.fr" > CNAME

git add *
git commit -m "updated GitHub Pages"
if [ $? -ne 0 ]; then
    echo "nothing to commit"
    exit 0
fi

git remote add "$remote_name" "$repo_uri" # includes access token
git fetch
git push --force-with-lease "$remote_name" "$target_branch"
