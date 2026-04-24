{ inputs, ... }:
{
  imports = [
    inputs.agenix.homeManagerModules.default
  ];
  home.packages = [
    inputs.agenix.packages.x86_64-linux.default
  ];
  age = {
    identityPaths = [ "~/.ssh/key" ];
  };
}
