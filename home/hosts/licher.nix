{ inputs, ... }:
{
  home.stateVersion = "25.11";
  imports = [
    ../core
    ../tui
    inputs.noctalia.homeModules.default
  ];
}
