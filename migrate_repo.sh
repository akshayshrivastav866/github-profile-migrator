#!/bin/bash

# ===== CONFIG =====
OLD_USER=""
NEW_USER=""
REPO_NAME=""
SOURCE_GITHUB_TOKEN=""

# ==================

set -e

echo "========================================="
echo " GitHub Repository Migration Script"
echo " Old account  : $OLD_USER"
echo " New account  : $NEW_USER"
echo " Repository   : $REPO_NAME"
echo "========================================="
echo

read -p "👉 Continue with these settings? (y/n): " confirm
if [[ "$confirm" != "y" ]]; then
  echo "❌ Aborted by user."
  exit 1
fi

echo "🔎 Checking repository existence..."

echo
echo "➡️  Checking OLD repository (HTTPS + token)..."
if git ls-remote https://$SOURCE_GITHUB_TOKEN@github.com/$OLD_USER/$REPO_NAME.git &>/dev/null; then
  echo "✅ OLD repository exists and is accessible."
else
  echo "❌ ERROR: OLD repository does NOT exist or token has no access."
  exit 1
fi

echo
echo "➡️  Checking NEW repository (SSH)..."
if git ls-remote git@github.com:$NEW_USER/$REPO_NAME.git &>/dev/null; then
  echo "✅ NEW repository exists and SSH access is working."
else
  echo "❌ ERROR: NEW repository does NOT exist OR SSH key not configured."
  echo
  echo "👉 Make sure:"
  echo "   - Repo is created in NEW account"
  echo "   - SSH key is added to NEW GitHub account"
  exit 1
fi

echo
echo "🧹 Cleaning any previous local mirror..."
rm -rf "$REPO_NAME.git"

echo
echo "⬇️  Cloning with full history (mirror)..."
git clone --mirror https://$SOURCE_GITHUB_TOKEN@github.com/$OLD_USER/$REPO_NAME.git
echo "✅ Clone completed."

cd "$REPO_NAME.git"

echo
echo "🔍 Scanning commit emails used in this repository..."
echo "-----------------------------------------"
git log --all --format='%ae' | sort -u
echo "-----------------------------------------"
echo
echo "⚠️  IMPORTANT:"
echo "The email(s) above are embedded in commits."
echo "After migration:"
echo "1) REMOVE these email(s) from OLD GitHub account"
echo "2) ADD & VERIFY them on the NEW GitHub account"
echo

echo
echo "⬆️  Pushing full history to NEW account..."
git push --mirror https://github.com/$NEW_USER/$REPO_NAME.git
echo "✅ Push completed."

cd ..
rm -rf "$REPO_NAME.git"

echo
echo "🎉 MIGRATION SUCCESSFUL!"
echo
echo "NEXT STEPS (VERY IMPORTANT):"
echo "-----------------------------------------"
echo "1️⃣  Go to OLD GitHub account → Settings → Emails"
echo "    → REMOVE the commit email(s) shown above"
echo
echo "2️⃣  Go to NEW GitHub account → Settings → Emails"
echo "    → ADD and VERIFY the same email(s)"
echo
echo "3️⃣  Refresh your NEW GitHub profile"
echo "    → Commits from old years should appear"
echo
echo "4️⃣  ONLY after verification → delete OLD account"
echo "-----------------------------------------"
