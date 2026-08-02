#!/bin/bash
set -e

REPO_URL="${1:-.}"
REPO_DIR="${2:-$HOME/.dotfiles}"

echo "Arch Linux Rice Installer"
echo ""

# Check if chezmoi is installed
if ! command -v chezmoi &> /dev/null; then
    echo "Installing chezmoi..."
    sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply "$REPO_URL"
    exit 0
fi

echo "chezmoi found at $(which chezmoi)"
echo ""

# If repo URL provided and not current directory, clone it
if [ "$REPO_URL" != "." ] && [ ! -d "$REPO_DIR" ]; then
    echo "Cloning repo to $REPO_DIR..."
    git clone "$REPO_URL" "$REPO_DIR"
    REPO_URL="$REPO_DIR"
fi

# Show what will change
echo "Changes to be applied:"
echo ""
chezmoi diff --source-path="$REPO_URL" || true
echo ""

# Confirm before applying
read -p "Apply these changes? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Applying..."
    chezmoi init --apply "$REPO_URL"
    echo ""
    echo "Done! Restart your shell or run 'exec bash' to load new config."
else
    echo "Cancelled."
    exit 1
fi
