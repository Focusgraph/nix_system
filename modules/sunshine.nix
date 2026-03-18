{
  services = {
    udev.extraRules = '' KERNEL=="uinput", MODE="0660", GROUP="input", SYMLINK+="uinput" '';
    sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
  };
}
