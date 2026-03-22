nix flake update --quiet

echo "Building package diff..."
nixos-rebuild build --quiet

nvd diff /run/current-system result
