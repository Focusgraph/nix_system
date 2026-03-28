{ inputs, ...}:
{
  home.stateVersion = "25.11";
  imports = [
    ../../home-modules
    ../../home-modules/firefox.nix
    ../../home-modules/keepassxc.nix
    inputs.noctalia.homeModules.default # To check if noctalia is enabled
  ];
}
