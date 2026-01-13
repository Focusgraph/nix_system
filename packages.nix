{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # System monitoring
    btop
    fastfetch
    # Nix
    nil
    nvd
    # Gaming
    lutris-free
    mangohud
    # Web browsers
    firefox
    ladybird
    # Terminal
    ghostty
    starship
    fzf
    # Other
    git
    feishin
    motrix
    haruna
    handbrake
    # Code editors
    neovim
    helix
    kdePackages.kate
    zed-editor
    package-version-server
  ];

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
  ];
  fonts.fontconfig.useEmbeddedBitmaps = true;
}
