{ inputs, ...}:
{
  home.stateVersion = "25.11";
  imports = [
    ../../home-modules
    inputs.noctalia.homeModules.default # To check if noctalia is enabled
  ];
}
