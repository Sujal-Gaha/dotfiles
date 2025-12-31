echo "Setting up dotfiles..."

# List of packages to stow
PACKAGES="vim git fish kitty hypr"

# Dry run first
for pkg in $PACKAGES; do
    if [ -d "$pkg" ]; then
        echo "Stowing $pkg..."
        stow --simulate "$pkg"
    fi
done

read -p "Continue? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    for pkg in $PACKAGES; do
        if [ -d "$pkg" ]; then
            stow --adopt "$pkg"
        fi
    done
fi
