{
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.sshKeyPaths = [ "/home/nixy/.ssh/key" ];
    age.keyFile = "/home/nixy/.config/sops/age/keys.txt";
    # age.generateKey = true;
    secrets."nixy_password" = {};
    secrets."nixy_password".neededForUsers = true;
  };
}
