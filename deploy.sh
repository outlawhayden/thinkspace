#!/bin/bash
set -e

BUILD_DIR="_site"
BRANCH="gh-pages"
REPO="git@github.com:outlawhayden/thinkspace.git"

echo "🔨 Building site..."
bundle exec jekyll build

# Clean out old .git if it exists
if [ -d "$BUILD_DIR/.git" ]; then
  echo "🧹 Removing old Git repo in $BUILD_DIR"
  rm -rf "$BUILD_DIR/.git"
fi

echo "🚚 Deploying to $BRANCH branch..."

cd "$BUILD_DIR"
git init
git remote add origin "$REPO"
git checkout -b "$BRANCH"

git add .
git commit -m "Deploy site on $(date '+%Y-%m-%d %H:%M:%S')"
git push --force origin "$BRANCH"

cd ..
echo "✅ Deployed successfully to branch '$BRANCH'"
