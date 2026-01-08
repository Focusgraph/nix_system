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
    # Fonts
    noto-fonts
    noto-fonts-monochrome-emoji
    noto-fonts-cjk-sans
    # Terminal
    ghostty
    starship
    fzf
    # Other
    git
    feishin
    motrix
    cava
    # Code editors
    neovim
    kdePackages.kate
    kdePackages.kdevelop
    zed-editor
    package-version-server
    jetbrains.idea-oss
  ];

}
